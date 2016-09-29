simplerepo
==========

Make a RPM repo out of a S3 bucket, good for public repositories.

We need Docker or 'createrepo' binary.

*Warning*: it may empty your S3 bucket, use with care.

    AWS_PROFILE=foobar SIMPLEREPO_BUCKET_NAME=mys3bucket ./ci.sh

On the end users OS create the simplerepo .repo file, like this:

    cat > /etc/yum.repos.d << EOF
    [mys3bucket]
    name=mys3bucket
    baseurl=http://mys3bucket.s3-website-us-west-2.amazonaws.com/
    gpgcheck=0
    EOF

The bucket needs web access enabled.

Alternatively set up a "release" package that contains a file like the above.

TO DO
=====

 - Enable GPG signed repositories: it may be as simple as running

   ```
   gpg --detach-sign --armor repodata/repomd.xml
   ```

   As part of the build process. Provided that the running environment has the signing GPG keys.
