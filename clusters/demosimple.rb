ClusterChef.cluster 'demosimple' do
  cloud(:ec2) do
    availability_zones ['us-east-1a']
    flavor              't1.micro'
    backing             'ebs'
    image_name          'maverick'
  end

  role                  :base_role
  role                  :chef_client
  role                  :ssh

  #
  # An NFS server to hold your home drives.
  #
  # It's stop-start'able, but if you're going to use this long-term, you should
  # consider creating a separate EBS volume to hold /home
  #
  facet :homebase do
    instances           1

    role                :nfs_server
  end

  #
  # A throwaway facet for development.
  #
  facet :sandbox do
    instances           2

    cloud do
      flavor           'm1.large'
      backing          'ebs'
    end

    role                :nfs_client
    role                :elasticsearch_client
    role                :redis_client
  end

end
