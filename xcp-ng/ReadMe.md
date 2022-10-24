1. Install Visual Studio 2022
2. install git for windows here: https://gitforwindows.org/
3. clone https://github.com/nforgeio/neonSDK from c:\git and then `git reset --hard a2d4112b08d6f105c7bec9e70c3392dae5c30f88` as a mechanism to version this doc
4. Open solution file neonSDK.sln from Visual Studio
5. Install .net framework 3.1 and 5 (if prompted)
6. Install VSCode for Windows
7. Install https://www.cygwin.com/setup-x86_64.exe
8. Install 7zip https://www.7-zip.org/download.html 64bit version
9. Install Putty: https://www.putty.org/
10. Install WinSCP: https://winscp.net/eng/index.php
11. Run: winget install --id Microsoft.Powershell --source winget
12. open cmd as admin and run c:\git\neonSDK\buildenv.cmd
13. `clone https://github.com/nforgeio/neonKUBE.git` from c:\git and then `git reset --hard 24fb4a66ede68003d95221061a34361b95ced72e` as a mechanism to version this doc
14. Open neonKUBE in Visual Studio
15. add a new package source called 'neon' with https://nuget-dev.neoncloud.io/v3/index.json in Tools/options/Nuget Package Manager/Package Sources
16. run as admin: powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
17. Set Tools/neon-cli as the default project in Visual Studio
18. Right click on neon-cli/Properties and go to Debug tab
18. Click open debug launch profile
20. Paste in: `cluster prepare C:\git\setup-neonkube\xcp-ng\cluster-beaky.yaml`
```
Before you run cluster prepare, make sure to backup/delete everything in the C:\Users\alice\.neonkube folder except .\.neonkube\node-images. Also backup/delete C:\Users\alice\.kube folder
```
21. Press play in the debugger 
```
The cli will, among other things, download a file from https://neon-public.s3.us-west-2.amazonaws.com/vm-images/xenserver/node/neonkube-0.8.3-alpha.xenserver.amd64.xva.gz.manifest, but it downloads the whole file in parts using special code: https://github.com/nforgeio/neonSDK/blob/master/Lib/Neon.Deployment/Helper/DeploymentHelper.cs#L206. 
You can find the download once complete in .neonkube\node-images
Setup will create a 32gb virtual disk on each xcp-ng-0X host called neon-ubuntu-22.04 0 that will get resized during setup. 
Make sure to allocate at least ~40Gb of space below the amount of available space you actually have on your disk so that the host os can have room to install neon charts, the OS image media (ubuntu), etc. For example, for a 512 Gb Physical SSD, only allocate a 360Gb disk.

If you have to restart 'cluster prepare' then backup/delete everything in the C:\Users\alice\.neonkube folder except .\.neonkube\node-images. This will allow you to start from scratch without having to re-download the large file neonkube-0.8.3-alpha.xenserver.amd64.xva every time. Also backup/delete C:\Users\alice\.kube folder, and delete any virtual machines that were created
```
22. Change the debug launch profile to: `cluster setup root@xcp-ng-beaky` where `xcp-ng-beaky` is the name of your cluster defined by line one of cluster.yaml
23. Press play in the debugger
24. Create a sample user: https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md and port forward:
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\xcp-ng\serviceaccount.yaml
kubectl apply -f C:\git\setup-neonkube\xcp-ng\clusterrolebinding.yaml
kubectl -n kube-system create token admin-user
kubectl port-forward --namespace neon-system service/kubernetes-dashboard 80
```
25. Using the port forwarding in step 24, open your browser and navigate the kubernetes dashboard at http://localhost. Paste in the token credentials into the token field that you got from step 26.
26. Extract the root sso password from `secrets/glauth/users.cfg` in the kubernetes dashboard found in the `neon-system` namespace
27. In Virtual Service/k8s-dashboard-virtual-service spec.hosts, extract the host to connect to the actual dashboard, e.g. neon-k8s.777e-42fe-5d6e-4eba.neoncluster.io
28. Open your browser and connect to https://neon-k8s.777e-42fe-5d6e-4eba.neoncluster.io, using root as the username, the password you have found in step 26, and the url you found in step 27.
29. Harbor is installed and the url is similar, e.g. https://neon-registry.777e-42fe-5d6e-4eba.neoncluster.io. The credentials are the same as neon-k8s

### Rebooting
1. There is some work to do after a reboot that worked for me. In one of the operators I got the following error: `unable to retrieve the complete list of server APIs` To fix I did the following:
2. `kubectl get apiservice`
3. Look for ones the AVAILABLE is False. If you don't need those APIs any more, delete them: `kubectl delete apiservce <service-name>`. In my case it was `kubectl delete apiservice v1alpha1.acme.neoncloud.io`
3. Then find the apposing helm chart installed command associate with the one AVAILABLE set to false in the logs stored at `C:\Users\alice\.neonkube\log\master-0.log`
4. Uninstall that chart and reinstall it using the data found in the log
