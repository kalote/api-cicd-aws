resource "aws_iam_role" "instance_role" {
  name               = "ec2_instance_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_policy" "services_access" {
  name   = "services_access_policy"
  policy = data.aws_iam_policy_document.services_access.json
}

resource "aws_iam_policy_attachment" "ec2_services_attach" {
  name       = "ec2_role_attach"
  roles      = [aws_iam_role.instance_role.name]
  policy_arn = aws_iam_policy.services_access.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.instance_role.name
}
