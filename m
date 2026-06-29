Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCFC43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 12:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 680E740299;
	Mon, 29 Jun 2026 14:59:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2F82E4021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 14:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782737982; x=1814273982;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Nd9kUAX8rOnsCnXInXFe/RndR5+js1w+eiENxC9SgDk=;
 b=bJdrHeWu1RFUIw1amOT5l+iZD99ndwBmf2lcyf0QcX+kZfG2Y2nf3uGW
 ThMgMkHs2DFfjD3enK2o7ZiWHcA6x5LtOzFMyVUePyO0yNg3Z12Wn0b8U
 4lWIcn/jczl3R0dq+e7gJo4t3ZRbEfLZ38zJyFZ1EofLLRsVio7e6Xbgi
 JwqyrHBdAYl+0vChU438edMYf3VYTKMN5lfOjpE0BxNe1fbBRxZUa9Hlq
 ouaVP5bJ5gPO5dSQc4L8Uo/exTj7p0yA9GThy3n74+RnEa+eSt+IobpOM
 PHheyNZAGJyQabDMwUVKq9EsMcyzpkPVPGyYTiq504E2Pb1akiOZGDfrr g==;
X-CSE-ConnectionGUID: C/gbuqpFQoO8q4KRv2+pwA==
X-CSE-MsgGUID: a1cQRJnATZqEHpCPvkKMUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87332482"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="87332482"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 05:59:40 -0700
X-CSE-ConnectionGUID: xnP4ltRJTYSpj41RUz74aw==
X-CSE-MsgGUID: H3JnDhV+Tdegb9Ym/yMkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="249322951"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Jun 2026 05:59:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] usertools/dpdk-devbind: improve query performance on BSD
Date: Mon, 29 Jun 2026 13:59:29 +0100
Message-ID: <20260629125929.2331943-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The time taken on FreeBSD to run the status command from dpdk-devbind
was exceptionally long. When run on a real system with lots of
devices, the original code took over 80 seconds in some cases to produce
the output of "dpdk-devbind.py -s". (Time on BSD VMs is quicker as they
tend not to have so many hardware devices, which is why this may not
have been noticed before.)

Rework the processing to avoid doing so many subprocess calls to
pciconf; use one call to get info on all devices rather than an
individual call per-device. On the same HW as before, it now takes a
fraction of a second, rather than >80 seconds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-devbind.py | 111 ++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 27 deletions(-)

diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 93f2383dff..e72f238aba 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -111,6 +111,9 @@
 # global dict ethernet devices present. Dictionary indexed by PCI address.
 # Each device within this is itself a dictionary of device properties
 devices = {}
+# for bsd, cache of all devices with ifconfig info merged in. populated once on first call.
+devices_cache = None
+
 # list of supported DPDK drivers
 dpdk_drivers = ["igb_uio", "vfio-pci", "uio_pci_generic"] if is_linux else ["nic_uio"]
 # list of currently loaded kernel modules
@@ -220,7 +223,10 @@ def get_pci_device_details(dev_id, probe_lspci):
 def clear_data():
     '''This function clears any old data'''
     global devices
+    global devices_cache
     devices = {}
+    if is_bsd:
+        devices_cache = None
 
 
 def get_basic_devinfo_linux(devices_type):
@@ -253,38 +259,89 @@ def get_basic_devinfo_linux(devices_type):
             dev[name.rstrip(":")] = value_list[len(value_list) - 1] \
                 .rstrip("]").lstrip("[")
 
+def init_devices_cache_bsd():
+    '''Initialize the devices cache by parsing pciconf -lv and ifconfig -a once.
+    Returns a list of device dictionaries with ifconfig data merged in.'''
+    global devices_cache
+
+    if devices_cache is not None:
+        return devices_cache
+
+    # Get all PCI device info in one call
+    pciconf_output = subprocess.check_output(["pciconf", "-lv"]).decode("utf8")
+    # Get all network interface info in one call
+    ifconfig_output = subprocess.check_output(["ifconfig", "-a"]).decode("utf8").splitlines()
+
+    devices_cache = []
+    current_dev = None
+
+    # Parse pciconf -lv output
+    for line in pciconf_output.splitlines():
+        # Main device line: none0@pci0:0:0:0: class=0x088000 rev=0x04 hdr=0x00 vendor=0x8086 device=0x09a2
+        if line and '@pci' in line:
+            # Save previous device if any
+            if current_dev:
+                devices_cache.append(current_dev)
+
+            # Parse slot/address from first part
+            name_addr, fields = line.split(maxsplit=1)
+            devname, addr = name_addr.split('@')
+            # Remove trailing colon from address
+            addr = addr.rstrip(':')
+
+            current_dev = {}
+            current_dev["Slot"] = addr
+            current_dev["Slot_str"] = addr
+
+            # Extract driver base name from device name (e.g., "nic_uio2" -> "nic_uio", "ixl0" -> "ixl")
+            # Device name format is like: "nic_uio2", "ioat0", "em0", "ixl1", "none0", etc.
+            current_dev["Driver_str"] = devname.rstrip('0123456789')
+
+            # Parse class/vendor/device from rest of line
+            fields_list = fields.split()
+            for field in fields_list:
+                if '=' in field:
+                    name, value = field.split("=")
+                    name = name.title()
+                    if name.startswith("Sub"):
+                        name = "S" + name[3:].title()
+                    # For class code, extract only first 2 hex digits (class part)
+                    if name == "Class" and value.startswith("0x") and len(value) > 4:
+                        current_dev[name + "_str"] = value
+                        current_dev[name] = value[2:4]  # Extract just class code (e.g., "02" from "0x020000")
+                    else:
+                        current_dev[name + "_str"] = value
+                        current_dev[name] = value[2:] if value.startswith("0x") else value
+
+            # Check if this is a network device and attach interface info
+            if "Class" in current_dev:
+                class_code = current_dev.get("Class", "")
+                if class_code == "02":  # Network controller
+                    iflines = [ln for ln in ifconfig_output if ln.startswith(f"{devname}:")]
+                    if iflines:
+                        current_dev["Interface"] = devname
+
+        # Device description line: device = 'Intel 82576 Gigabit Network Connection'
+        elif current_dev and "device" in line.lower() and "=" in line:
+            current_dev["Device_str"] = line.split("=")[1].strip().strip("'")
+
+    # Add the last device
+    if current_dev:
+        devices_cache.append(current_dev)
+
+    return devices_cache
 
 def get_basic_devinfo_bsd(devices_type):
+    '''Filter the pre-cached device list by device type and populate devices dict.'''
     global devices
 
-    dev_lines = subprocess.check_output(["pciconf", "-l"]).decode("utf8").splitlines()
-    netifs = subprocess.check_output(["ifconfig", "-a"]).decode("utf8").splitlines()
-    for dev_line in dev_lines:
-        dev = {}
-        name_addr, fields = dev_line.split(maxsplit=1)
-        devname, addr = name_addr.split('@')
-        dev["Slot"] = addr
-        dev["Slot_str"] = addr
-        dev["Driver_str"] = devname[:-1]
-        if devices_type == network_devices:
-            iflines = [ln for ln in netifs if ln.startswith(f"{devname}:")]
-            if iflines:
-                dev["Interface"] = devname
-        fields = fields.split()
-        for field in fields:
-            name, value = field.split("=")
-            name = name.title()
-            if name.startswith("Sub"):
-                name = "S" + name[3:].title()
-            dev[name + "_str"] = value
-            dev[name] = value[2:] if value.startswith("0x") else value
-        # explicitly query the device name string
-        devdetails = subprocess.check_output(["pciconf", "-lv", addr]).decode("utf8")
-        for devline in devdetails.splitlines():
-            if devline.lstrip().startswith("device") and "=" in devline:
-                dev["Device_str"] = devline.split("=")[1].strip().strip("'")
+    # Initialize cache on first call (subsequent calls return cached data)
+    all_devices = init_devices_cache_bsd()
+
+    # Filter by device type and add to devices dict
+    for dev in all_devices:
         if device_type_match(dev, devices_type):
-            devices[addr] = dict(dev)
+            devices[dev["Slot"]] = dict(dev)
 
 
 def get_device_details(devices_type):
-- 
2.53.0

