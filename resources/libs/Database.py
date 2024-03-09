import psycopg2

db_conn = """
    host='localhost'
    dbname='smartbit'
    user='postgres'
    password='QAx@123'
"""

def execute(query):
    conn = psycopg2.connect(db_conn)

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()

def insert_membership(data):
    query = f"""
    BEGIN; -- Inicia uma transação

    -- Remove o registro pelo email
    DELETE FROM accounts
    WHERE email = 'jonas@teste.com';

    -- Insere uma nova conta e obtém o ID da conta recém criada
    WITH new_account AS (
        INSERT INTO accounts (name, email, cpf)
        VALUES ('Jonas Brothers', 'jonas@teste.com', '98593940080')
        RETURNING id
    )

    -- Insere um registro na tabela memberships com o ID da conta
    INSERT INTO memberships (account_id, plan_id, credit_card, price, status)
    SELECT id, 1, '4242', 99.99, true
    FROM new_account;

    COMMIT; -- Confirma a transação
    """
    execute(query)    

def insert_account(account):
    query = f"""
    INSERT INTO accounts (name, email, cpf) 
    VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}')
    """

    execute(query)  

def delete_account_by_email(email):

    query = f"DELETE FROM accounts WHERE email = '{email}';"
    
    execute(query)  