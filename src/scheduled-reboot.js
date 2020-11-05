const AWS = require("aws-sdk");
const ec2 = new AWS.EC2();

const rebootInstances = async (instanceIds) => {
  console.info("rebooting instances", instanceIds.join(","));
  const params = {
    InstanceIds: instanceIds,
  };
  return ec2.rebootInstances(params).promise();
};

/**
 * A Lambda function that triggers the reboot
 */
exports.handler = async (event, context) => {
  console.info("event", JSON.stringify(event));

  if (!process.env.EC2_ID_CSV) {
    throw new Error("EC2_ID_CSV environment variable is required");
  }

  try {
    const instances = process.env.EC2_ID_CSV.split(",");
    await rebootInstances(instances);
  } catch (error) {
    console.error("Error while attempting to reboot: ", error.message);
    throw error;
  }
};
