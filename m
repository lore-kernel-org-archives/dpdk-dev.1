Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D37D3C539
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 12:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13BC4028F;
	Wed, 10 Dec 2025 13:39:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 836FE40285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 13:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765370342; x=1796906342;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9Xis861fgxnxywvMOzJFh5Kme/IBfPL438nVbapUiAk=;
 b=TLc5Q84q4q2aiyhVyqnvqfUQ6DPeDEsKHf/drTqRkBVKUHEW2DzaBw3z
 wx+5OQM0d0slyi4c/cP/5f4IefbnwvLUHetx9sNcqdav8T0IRh0EAaYXx
 dcgl/bFOHZbQN3Sfrrhhd0hCoxyAwi8MPqTYfknHhGDOv7Au/L2/BrAm6
 OnOQptDPkw/w5xN/2xYhAAz3OjCIb+yUetYXPiDzx7bCjAGu8m3WcgLMI
 0fZrRrxiKZ7PoTnjtmin+yLZmxqYXpGJTXLaoDC0QbCPTChBKIB8sLeWf
 uGvLOJJtu/SJGrmu71sOBt+McHMDHlDtFepWMnptk8aVn1FhIzDBbXWVP Q==;
X-CSE-ConnectionGUID: uRfFJw6fSgmQTUd/6mn+VQ==
X-CSE-MsgGUID: od4gBjMCRkCdzvNAyz8Qug==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67298544"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67298544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 04:39:01 -0800
X-CSE-ConnectionGUID: v8kvTQtoQaKNeV853NnkNw==
X-CSE-MsgGUID: p7Hmj7hmTCSsRwQWobZU5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="196413650"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 10 Dec 2025 04:39:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] usertools/dpdk-devbind: add basic FreeBSD support
Date: Wed, 10 Dec 2025 12:38:54 +0000
Message-ID: <20251210123854.68761-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Add support for using dpdk-devbind to query device bind status on
FreeBSD. For other ops, bind and unbind, which are unsupported,
report a proper errors message indicating the unsupported status
and pointing the user to the docs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-devbind.py | 96 ++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 16 deletions(-)

diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 06ae25aa34..93f2383dff 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -15,6 +15,12 @@
 from os.path import exists, basename
 from os.path import join as path_join
 
+is_linux = sys.platform.startswith('linux')
+is_bsd = sys.platform.startswith('freebsd')
+freebsd_err_unsupported_string = """Error: This operation is unsupported on FreeBSD.
+See FreeBSD Getting Started Guide for details on binding and unbinding devices.
+"""
+
 # The PCI base class for all devices
 network_class = {'Class': '02', 'Vendor': None, 'Device': None,
                  'SVendor': None, 'SDevice': None}
@@ -106,7 +112,7 @@
 # Each device within this is itself a dictionary of device properties
 devices = {}
 # list of supported DPDK drivers
-dpdk_drivers = ["igb_uio", "vfio-pci", "uio_pci_generic"]
+dpdk_drivers = ["igb_uio", "vfio-pci", "uio_pci_generic"] if is_linux else ["nic_uio"]
 # list of currently loaded kernel modules
 loaded_modules = None
 
@@ -124,6 +130,9 @@
 def module_is_loaded(module):
     global loaded_modules
 
+    if is_bsd:
+        return subprocess.run(["kldstat", "-qn", module]).returncode == 0
+
     if module == 'vfio_pci':
         module = 'vfio-pci'
 
@@ -214,12 +223,8 @@ def clear_data():
     devices = {}
 
 
-def get_device_details(devices_type):
-    '''This function populates the "devices" dictionary. The keys used are
-    the pci addresses (domain:bus:slot.func). The values are themselves
-    dictionaries - one for each NIC.'''
+def get_basic_devinfo_linux(devices_type):
     global devices
-    global dpdk_drivers
 
     # first loop through and read details for all devices
     # request machine readable format, with numeric IDs and String
@@ -248,7 +253,53 @@ def get_device_details(devices_type):
             dev[name.rstrip(":")] = value_list[len(value_list) - 1] \
                 .rstrip("]").lstrip("[")
 
-    if devices_type == network_devices:
+
+def get_basic_devinfo_bsd(devices_type):
+    global devices
+
+    dev_lines = subprocess.check_output(["pciconf", "-l"]).decode("utf8").splitlines()
+    netifs = subprocess.check_output(["ifconfig", "-a"]).decode("utf8").splitlines()
+    for dev_line in dev_lines:
+        dev = {}
+        name_addr, fields = dev_line.split(maxsplit=1)
+        devname, addr = name_addr.split('@')
+        dev["Slot"] = addr
+        dev["Slot_str"] = addr
+        dev["Driver_str"] = devname[:-1]
+        if devices_type == network_devices:
+            iflines = [ln for ln in netifs if ln.startswith(f"{devname}:")]
+            if iflines:
+                dev["Interface"] = devname
+        fields = fields.split()
+        for field in fields:
+            name, value = field.split("=")
+            name = name.title()
+            if name.startswith("Sub"):
+                name = "S" + name[3:].title()
+            dev[name + "_str"] = value
+            dev[name] = value[2:] if value.startswith("0x") else value
+        # explicitly query the device name string
+        devdetails = subprocess.check_output(["pciconf", "-lv", addr]).decode("utf8")
+        for devline in devdetails.splitlines():
+            if devline.lstrip().startswith("device") and "=" in devline:
+                dev["Device_str"] = devline.split("=")[1].strip().strip("'")
+        if device_type_match(dev, devices_type):
+            devices[addr] = dict(dev)
+
+
+def get_device_details(devices_type):
+    '''This function populates the "devices" dictionary. The keys used are
+    the pci addresses (domain:bus:slot.func). The values are themselves
+    dictionaries - one for each NIC.'''
+    global devices
+    global dpdk_drivers
+
+    if is_linux:
+        get_basic_devinfo_linux(devices_type)
+    else:
+        get_basic_devinfo_bsd(devices_type)
+
+    if is_linux and devices_type == network_devices:
         # check what is the interface if any for an ssh connection if
         # any to this host, so we can mark it later.
         ssh_if = []
@@ -271,7 +322,7 @@ def get_device_details(devices_type):
         # No need to probe lspci
         devices[d].update(get_pci_device_details(d, False).items())
 
-        if devices_type == network_devices:
+        if is_linux and devices_type == network_devices:
             for _if in ssh_if:
                 if _if in devices[d]["Interface"].split(","):
                     devices[d]["Ssh_if"] = True
@@ -470,6 +521,9 @@ def bind_one(dev_id, driver, force):
 def unbind_all(dev_list, force=False):
     """Unbind method, takes a list of device locations"""
 
+    if is_bsd:
+        sys.exit(freebsd_err_unsupported_string)
+
     if dev_list[0] == "dpdk":
         for d in devices.keys():
             if "Driver_str" in devices[d]:
@@ -520,6 +574,9 @@ def bind_all(dev_list, driver, force=False):
     """Bind method, takes a list of device locations"""
     global devices
 
+    if is_bsd:
+        sys.exit(freebsd_err_unsupported_string)
+
     # a common user error is to forget to specify the driver the devices need to
     # be bound to. check if the driver is a valid device, and if it is, show
     # a meaningful error.
@@ -719,10 +776,7 @@ def parse_args():
     global vfio_uid
     global vfio_gid
 
-    parser = argparse.ArgumentParser(
-        description='Utility to bind and unbind devices from Linux kernel',
-        formatter_class=argparse.RawDescriptionHelpFormatter,
-        epilog="""
+    epilog_linux = """
 Examples:
 ---------
 
@@ -740,7 +794,16 @@ def parse_args():
 
 To bind 0000:02:00.0 and 0000:02:00.1 to the ixgbe kernel driver
         %(prog)s -b ixgbe 02:00.0 02:00.1
-""")
+"""
+    epilog_bsd = """
+NOTE: Only query options, -s/--status and --status-dev, are supported on FreeBSD.
+"""
+
+    epilog = epilog_linux if is_linux else epilog_bsd
+    parser = argparse.ArgumentParser(
+        description='Utility to bind and unbind devices from OS kernel',
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        epilog=epilog)
 
     parser.add_argument(
         '-s',
@@ -866,12 +929,13 @@ def do_arg_actions():
 
 def main():
     '''program main function'''
-    # check if lspci is installed, suppress any output
+    # check if lspci/pciconf is installed, suppress any output
+    pcitool = 'lspci' if is_linux else 'pciconf'
     with open(os.devnull, 'w') as devnull:
-        ret = subprocess.call(['which', 'lspci'],
+        ret = subprocess.call(['which', pcitool],
                               stdout=devnull, stderr=devnull)
         if ret != 0:
-            sys.exit("'lspci' not found - please install 'pciutils'")
+            sys.exit(f"'{pcitool}' not found - please install relevant package, e.g. 'pciutils'")
     parse_args()
     check_modules()
     clear_data()
-- 
2.51.0

