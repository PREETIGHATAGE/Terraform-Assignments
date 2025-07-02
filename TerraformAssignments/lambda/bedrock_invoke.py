import boto3
import json

def lambda_handler(event, context):
    bedrock = boto3.client("bedrock-runtime")

    prompt = "What is Terraform in DevOps?"

    response = bedrock.invoke_model(
        modelId="anthropic.claude-v2",
        contentType="application/json",
        accept="application/json",
        body=json.dumps({
            "prompt": prompt,
            "max_tokens_to_sample": 100
        })
    )

    result = json.loads(response['body'].read().decode("utf-8"))
    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
