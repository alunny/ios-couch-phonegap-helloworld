Everything should be there more or less, to run on the iPhone simulator (pre-built PhoneGap framework, Couchbase.bundle, libCouchbase, libTouchJSON).

If you want to run things on a device, see here:

`https://github.com/couchbaselabs/iOS-Couchbase/blob/master/doc/using_mobile_couchbase.md`

and build the couchbase stuff for iphoneos

## Notes

* The `demoapp.couch` file is taken from a local couchapp I was running, using Aaron Quint's [soca](https://github.com/quirkey/soca). You can just dig into the filesystem of your local couch and pull out the `.couch` file
* To get your couchapp running, make sure you edit your `PhoneGap.plist` to include `0.0.0.0` and `127.0.0.1` under `ExternalHosts`
