
resource "aws_sqs_queue" "notificacao-pagamento-sync" {
  name = var.sqs_pagamento_name
}

resource "aws_sqs_queue" "notificacao-pedido-sync" {
  name = var.sqs_pedido_name
}

resource "aws_sqs_queue" "notificacao-status-sync" {
  name = var.sqs_status_name
}

resource "aws_sqs_queue_policy" "my_sqs_policy" {
  queue_url = aws_sqs_queue.notificacao-pagamento-sync.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.notificacao-pagamento-sync.arn}"
    },{
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.notificacao-pedido-sync.arn}"
    },
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.notificacao-status-sync.arn}"
    }
  ]
}
POLICY
}