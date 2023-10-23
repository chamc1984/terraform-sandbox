import boto3


def lambda_handler(event, context):
    action = event['Action']
    tag_name = event['Tag']
    
    client = boto3.client('ec2', 'ap-northeast-1')
    response = client.describe_instances(Filters=[{'Name': 'tag:Name', "Values": [tag_name]}])
    print(response)

    target_instance_ids = []
    status = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            target_instance_ids.append(instance['InstanceId'])
            status.append(instance['State']['Name'])

    response_message = "non."
    if not len(target_instance_ids) == 1:
        response_message = 'There are no EC2 instances subject to automatic start / stop.'
    else:
        if action == 'describe':
            response_message = status
        elif action == 'start':
            client.start_instances(InstanceIds=target_instance_ids)
            response_message = 'started instances.'
        elif action == 'stop':
            client.stop_instances(InstanceIds=target_instance_ids)
            response_message = 'stopped instances.'
        else:
            response_message = 'Invalid action.'

    return {
        "message": response_message
    }
