Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF6FC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 06:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA03E402B5;
	Wed,  2 Apr 2025 08:58:51 +0200 (CEST)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by mails.dpdk.org (Postfix) with ESMTP id 6E93E4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 08:58:50 +0200 (CEST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3p48l4Oxn95TOEQ--.58242S2;
 Wed, 02 Apr 2025 14:58:45 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3vIgj4Oxn_yJeAA--.10255S3;
 Wed, 02 Apr 2025 14:58:44 +0800 (CST)
From: liwencheng <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v4 1/4] usertools/dpdk-devbind: add bind/unbind for platform
 device
Date: Wed,  2 Apr 2025 06:58:32 +0000
Message-Id: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: AQAAfwC3vIgj4Oxn_yJeAA--.10255S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jr4DWry3Kw18Ww4UtF4DXFb_yoWxZr4fpr
 4rAa9ayr1xGrn7Kr9xZ3Wa9FZYkwsFva4rKrnrXw1q93s8Z395tFWvyF1fu3srJr1fZ3Z8
 t3Z8XFWvka17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

This patch mainly adds functions for bind and unbind platform devices,
such as bind_platform_one and unbind_platform_one.

Signed-off-by: liwencheng <liwencheng@phytium.com.cn>
---
 usertools/dpdk-devbind.py | 131 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 17 deletions(-)

diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 06ae25a..600c4ba 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -65,7 +65,7 @@
 intel_idxd_spr = {'Class': '08', 'Vendor': '8086', 'Device': '0b25',
                   'SVendor': None, 'SDevice': None}
 intel_idxd_gnrd = {'Class': '08', 'Vendor': '8086', 'Device': '11fb',
-                  'SVendor': None, 'SDevice': None}
+                   'SVendor': None, 'SDevice': None}
 intel_idxd_dmr = {'Class': '08', 'Vendor': '8086', 'Device': '1212',
                   'SVendor': None, 'SDevice': None}
 intel_ntb_skx = {'Class': '06', 'Vendor': '8086', 'Device': '201c',
@@ -156,10 +156,32 @@ def module_is_loaded(module):
     return module in loaded_modules
 
 
+def get_platform_devices():
+    global platform_devices
+
+    platform_device_path = "/sys/bus/platform/devices/"
+    platform_devices = os.listdir(platform_device_path)
+
+
+def devices_are_platform(devs):
+    all_devices_are_platform = True
+
+    get_platform_devices()
+    for d in devs:
+        if d not in platform_devices:
+            all_devices_are_platform = False
+            break
+
+    return all_devices_are_platform
+
+
 def check_modules():
     '''Checks that igb_uio is loaded'''
     global dpdk_drivers
 
+    if devices_are_platform(args):
+        return
+
     # list of supported modules
     mods = [{"Name": driver, "Found": False} for driver in dpdk_drivers]
 
@@ -330,11 +352,38 @@ def dev_id_from_dev_name(dev_name):
     for d in devices.keys():
         if dev_name in devices[d]["Interface"].split(","):
             return devices[d]["Slot"]
+
+    # Check if it is a platform device
+    if dev_name in platform_devices:
+        return dev_name
+
     # if nothing else matches - error
     raise ValueError("Unknown device: %s. "
                      "Please specify device in \"bus:slot.func\" format" % dev_name)
 
 
+def unbind_platform_one(dev_name):
+    filename = "/sys/bus/platform/devices/%s/driver" % dev_name
+
+    if exists(filename):
+        try:
+            f = open(os.path.join(filename, "unbind"), "w")
+        except OSError as err:
+            sys.exit("Error: unbind failed for %s - Cannot open %s: %s" %
+                     (dev_name, os.path.join(filename, "unbind"), err))
+        f.write(dev_name)
+        f.close()
+        filename = "/sys/bus/platform/devices/%s/driver_override" % dev_name
+        try:
+            f = open(filename, "w")
+        except OSError as err:
+            sys.exit("Error: unbind failed for %s - Cannot open %s: %s" %
+                     (dev_name, filename, err))
+        f.write("")
+        f.close()
+        print("Successfully unbind platform device %s" % dev_name)
+
+
 def unbind_one(dev_id, force):
     '''Unbind the device identified by "dev_id" from its current driver'''
     dev = devices[dev_id]
@@ -360,6 +409,48 @@ def unbind_one(dev_id, force):
     f.close()
 
 
+def bind_platform_one(dev_name, driver):
+    filename = "/sys/bus/platform/drivers/%s" % driver
+
+    if not exists(filename):
+        print("The driver %s is not loaded" % driver)
+        return
+    # unbind any existing drivers we don't want
+    filename = "/sys/bus/platform/devices/%s/driver" % dev_name
+    if exists(filename):
+        unbind_platform_one(dev_name)
+    # driver_override can be used to specify the driver
+    filename = "/sys/bus/platform/devices/%s/driver_override" % dev_name
+    if exists(filename):
+        try:
+            f = open(filename, "w")
+        except OSError as err:
+            sys.exit("Error: unbind failed for %s - Cannot open %s: %s"
+                     % (dev_name, filename, err))
+        try:
+            f.write(driver)
+            f.close()
+        except OSError as err:
+            sys.exit("Error: unbind failed for %s - Cannot write %s: %s"
+                     % (dev_name, filename, err))
+    # do the bind by writing to /sys
+    filename = "/sys/bus/platform/drivers/%s/bind" % driver
+    try:
+        f = open(filename, "w")
+    except OSError as err:
+        print("Error: bind failed for %s - Cannot open %s: %s"
+              % (dev_name, filename, err), file=sys.stderr)
+        return
+    try:
+        f.write(dev_name)
+        f.close()
+    except OSError as err:
+        print("Error: bind failed for %s - Cannot bind to driver %s: %s"
+              % (dev_name, driver, err), file=sys.stderr)
+        return
+    print("Successfully bind platform device %s to driver %s" % (dev_name, driver))
+
+
 def bind_one(dev_id, driver, force):
     '''Bind the device given by "dev_id" to the driver "driver". If the device
     is already bound to a different driver, it will be unbound first'''
@@ -484,7 +575,10 @@ def unbind_all(dev_list, force=False):
         sys.exit(1)
 
     for d in dev_list:
-        unbind_one(d, force)
+        if d in platform_devices:
+            unbind_platform_one(d)
+        else:
+            unbind_one(d, force)
 
 
 def has_iommu():
@@ -500,7 +594,7 @@ def check_noiommu_mode():
     try:
         with open(filename, "r") as f:
             value = f.read(1)
-            if value in ("1", "y" ,"Y"):
+            if value in ("1", "y", "Y"):
                 return
     except OSError as err:
         sys.exit(f"Error: failed to check unsafe noiommu mode - Cannot open {filename}: {err}")
@@ -547,20 +641,23 @@ def bind_all(dev_list, driver, force=False):
         check_noiommu_mode()
 
     for d in dev_list:
-        bind_one(d, driver, force)
-        # if we're binding to vfio-pci, set the IOMMU user/group ownership if one was specified
-        if driver == "vfio-pci" and (vfio_uid != -1 or vfio_gid != -1):
-            # find IOMMU group for a particular PCI device
-            iommu_grp_base_path = os.path.join("/sys/bus/pci/devices", d, "iommu_group")
-            # extract the IOMMU group number
-            iommu_grp = os.path.basename(os.readlink(iommu_grp_base_path))
-            # find VFIO device correspondiong to this IOMMU group
-            dev_path = os.path.join("/dev/vfio", iommu_grp)
-            # set ownership
-            try:
-                os.chown(dev_path, vfio_uid, vfio_gid)
-            except OSError as err:
-                sys.exit(f"Error: failed to set IOMMU group ownership for {d}: {err}")
+        if d in platform_devices:
+            bind_platform_one(d, driver)
+        else:
+            bind_one(d, driver, force)
+            # if we're binding to vfio-pci, set the IOMMU user/group ownership if one was specified
+            if driver == "vfio-pci" and (vfio_uid != -1 or vfio_gid != -1):
+                # find IOMMU group for a particular PCI device
+                iommu_grp_base_path = os.path.join("/sys/bus/pci/devices", d, "iommu_group")
+                # extract the IOMMU group number
+                iommu_grp = os.path.basename(os.readlink(iommu_grp_base_path))
+                # find VFIO device correspondiong to this IOMMU group
+                dev_path = os.path.join("/dev/vfio", iommu_grp)
+                # set ownership
+                try:
+                    os.chown(dev_path, vfio_uid, vfio_gid)
+                except OSError as err:
+                    sys.exit(f"Error: failed to set IOMMU group ownership for {d}: {err}")
 
     # For kernels < 3.15 when binding devices to a generic driver
     # (i.e. one that doesn't have a PCI ID table) using new_id, some devices
-- 
2.7.4

