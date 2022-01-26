class RegisterQueries{

static String registerQueries =r'''
mutation registerUser($name: String!, $email: String!, $default_role: String!) {
  insert_users(objects: {email: $email, name: $name, default_role: $default_role}) {
    affected_rows
  }
}
''';

}