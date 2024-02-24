import psycopg2

def delete_account_by_email(email):

    query = f"DELETE FROM accounts WHERE email = '{email}';"

    conn = psycopg2.connect(
        host='tuffi.db.elephantsql.com',
        database='umccjcgc',
        user='umccjcgc',
        password='sM7sz-20hJkZCQSOS3zKaCD54Fj58gCR'
    )

    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()