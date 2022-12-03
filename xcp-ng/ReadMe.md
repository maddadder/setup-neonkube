1. Install Visual Studio 2022
2. install git for windows here: https://gitforwindows.org/
3. `git clone https://github.com/nforgeio/neonSDK` from c:\git and then `git reset --hard d3427af3693d17bfd2292980d069184929f25923` as a mechanism to version this doc
4. Open solution file neonSDK.sln from Visual Studio
5. Install .net framework 3.1 and 5 (if prompted)
6. Install VSCode for Windows
7. Install https://www.cygwin.com/setup-x86_64.exe
8. Install 7zip https://www.7-zip.org/download.html 64bit version
9. Install Putty: https://www.putty.org/
10. Install WinSCP: https://winscp.net/eng/index.php
10. Install xcp-ng on a target datacenter server(s): https://xcp-ng.org/docs/release-8-2.html
10. Install xcp-ng center from: https://github.com/xcp-ng/xenadmin/releases/
11. Run: winget install --id Microsoft.Powershell --source winget
12. open cmd as admin and run c:\git\neonSDK\buildenv.cmd
13. `git clone https://github.com/nforgeio/neonKUBE.git` from c:\git and then `git reset --hard 252acaa6fa68c0b640fb3a1109cf72699985ba72` as a mechanism to version this doc
13. open cmd as admin and run c:\git\neonKUBE\buildenv.cmd
14. Open neonKUBE in Visual Studio as admin.
15. You may be asked to login to GitHub. Enter your GitHub username and GITHUB_PAT as the password and check the save password button
16. run as admin: powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
17. (optional) To add redundancy to openebs you can configure Mirror instead of Stripe by changing the code to `DataRaidGroupType = DataRaidGroupTypes.Mirror` instead of `DataRaidGroupType = DataRaidGroupTypes.Stripe` in `C:\git\neonKUBE\Lib\Neon.Kube.Setup\KubeSetup.Operations.cs` line ~2646. Make sure you have an even number of openEbsDisk disks configured
17. Set Tools/neon-cli as the default project in Visual Studio
18. Right click on neon-cli/Properties and go to Debug tab
19. Click open debug launch profile
20. Paste in: `cluster prepare C:\git\setup-neonkube\xcp-ng\cluster-beaky.yaml` OR `cluster prepare C:\git\setup-neonkube\xcp-ng\cluster-aurus.yaml`. 
20. If you already have the image downloaded locally, and building a new xenserver, you can import the template onto the server via xcp-ng => File => Import => Browse for the template, e.g. neonkube-0.8.4-alpha.xenserver.amd64.xva.gz. The image must be imported before setup will be able to create the virtual machine.
20. If you already have the image downloaded and have the image imported onto the xenserver can specify the template via `cluster prepare C:\git\setup-neonkube\xcp-ng\cluster-aurus.yaml --node-image-path=C:\Users\alice\.neonkube\node-images\neonkube-0.8.4-alpha.xenserver.amd64.xva.gz --debug --base-image-name=neonkube-0.8.4-alpha.xenserver.amd64.xva` OR `cluster prepare C:\git\setup-neonkube\xcp-ng\cluster-beaky.yaml --node-image-path=C:\Users\alice\.neonkube\node-images\neonkube-0.8.4-alpha.xenserver.amd64.xva.gz --debug --base-image-name=neonkube-0.8.4-alpha.xenserver.amd64.xva`
20. You can test ahead of time for xenservers to see if the download is going to work by navigating to: https://neon-public.s3.us-west-2.amazonaws.com/vm-images/xenserver/node/neonkube-0.8.4-alpha.xenserver.amd64.xva.gz.manifest. Note that the actual image is a multipart download so there is no way to download the file without special tooling.
20. Before you run cluster prepare, make sure to backup/delete everything in the C:\Users\alice\.neonkube folder except .\.neonkube\node-images, .\.neonkube\passwords, .\.neonkube\tools. Also backup/delete C:\Users\alice\.kube folder
21. Press play in the debugger 
```
The cli will, among other things, download a file from https://neon-public.s3.us-west-2.amazonaws.com/vm-images/xenserver/node/neonkube-0.8.3-alpha.xenserver.amd64.xva.gz.manifest, but it downloads the whole file in parts using special code: https://github.com/nforgeio/neonSDK/blob/master/Lib/Neon.Deployment/Helper/DeploymentHelper.cs#L206. 
You can find the download once complete in .neonkube\node-images
Setup will create a 32gb virtual disk on each xcp-ng-0X host called neon-ubuntu-22.04 0 that will get resized during setup. 
Make sure to allocate at least ~40Gb of space below the amount of available space you actually have on your disk so that the host os can have room to install neon charts, the OS image media (ubuntu), etc. For example, for a 512 Gb Physical SSD, only allocate a 360Gb disk.

If you have to restart 'cluster prepare' then backup/delete everything in the C:\Users\alice\.neonkube folder except .\.neonkube\node-images, .\.neonkube\passwords, .\.neonkube\tools. Keeping the .\.neonkube\node-images folder will allow you to start from scratch without having to re-download the large file neonkube-0.8.3-alpha.xenserver.amd64.xva every time. Also backup/delete C:\Users\alice\.kube folder, and delete any virtual machines that were created
```
21. Build neonKUBE\Lib\Neon.Kube.Setup to embed/build the cluster-manifest.json file 
22. Change the debug launch profile to: `cluster setup root@beaky` OR `cluster setup root@aurus` where `beaky` is the name of your cluster defined by line one of cluster.yaml. Another option is `cluster setup root@beaky --upload-charts` OR `cluster setup root@aurus --upload-charts` if you want to upload the charts from source instead of it pulling from the image.
23. Press play in the debugger
24. Once setup is complete you need to find the Url and password. The quick way is to check the log in `C:\Users\alice\.neonkube\log\master-0.log`. You can search for root and look for the password. For the Url you can search for `.neoncluster.io` and then navigate to neon-k8s.GUID.neoncluster.io in your browser. Another way is to log in to the dashboard by port fowarding. If you don't have the log file, here are the steps to create a sample user https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md and port forward:
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
30. See https://github.com/nforgeio/neonKUBE/issues/1707 about fixing an error with minio


### Rebooting
1. There is some work to do after a reboot that worked for me. In one of the operators I got the following error: `unable to retrieve the complete list of server APIs` To fix I did the following:
2. `kubectl get apiservice`
3. In the results, look for rows where AVAILABLE is False. In my case it was `v1alpha1.acme.neoncloud.io`. Find the associated pods and restart it. In my case, restart the `neon-acme`, `istio-ingressgateway`, `neon-sso-session-proxy`, `neon-sso-oauth2-proxy` pods.
4. You can also try first navigating to `https://neon-k8s.18e7-091a-7bb4-d81e.neoncluster.io/oauth2/callback`
5. If all else fails you can try reinstalling the chart associated with the API that is unavailable found in the prior step. You can find the apposing helm chart install command in the logs stored at `C:\Users\alice\.neonkube\log\master-0.log`. Uninstall that chart and reinstall it using the data found in the log
