Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2DCA600B
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 14:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7020E40294;
	Thu,  8 Oct 2026 16:43:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 56CDD40284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 16:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791470600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I25iBPUHRpDeT5E0FLJMpuCBVI5ak+B7RlldN4m1BgA=;
 b=fncSAWSeHniTj988F4UJgk2qdtZfhDLSJrHuTUZ6bBGzqFwe6/MZZsjMBa2gzXXARwUWfH
 CgmcZ+wl1RiDnapMdodg8sOidptG1CXdxl2Gx1bXx/8xTL+pQPXtILft28wNiaEcfGZB+n
 FzFDDUAp1YMeBIXXJheRFHEeSQwj45I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-RTADcBHdOhClPLejYpZl0A-1; Thu,
 08 Oct 2026 10:43:19 -0400
X-MC-Unique: RTADcBHdOhClPLejYpZl0A-1
X-Mimecast-MFC-AGG-ID: RTADcBHdOhClPLejYpZl0A_1791470598
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD1431831EE0; Thu,  8 Oct 2026 14:43:17 +0000 (UTC)
Received: from dmarchan.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA61C1800473; Thu,  8 Oct 2026 14:43:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Robin Jarry <rjarry@redhat.com>
Subject: [PATCH] usertools/devbind: cleanup device type declarations
Date: Thu,  8 Oct 2026 16:43:13 +0200
Message-ID: <20261008144313.2000554-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kf3I0gKQhakN1QUY0RWgAnUZQjNDfgjcC24j5FlnZlA_1791470598
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Adding more device types has resulted in a nice chaotic order over time.
Introduce a single dictionary and group by types (keeping the original
order).
Sort match entries by class/vendor/device values.

The Sub Vendor and Sub Device fields are never populated, just drop
them.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 usertools/dpdk-devbind.py | 247 ++++++++++++++++----------------------
 1 file changed, 105 insertions(+), 142 deletions(-)

diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index e72f238aba..961094a42b 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -21,92 +21,91 @@
 See FreeBSD Getting Started Guide for details on binding and unbinding devices.
 """
 
-# The PCI base class for all devices
-network_class = {'Class': '02', 'Vendor': None, 'Device': None,
-                 'SVendor': None, 'SDevice': None}
-acceleration_class = {'Class': '12', 'Vendor': None, 'Device': None,
-                      'SVendor': None, 'SDevice': None}
-ifpga_class = {'Class': '12', 'Vendor': '8086', 'Device': '0b30',
-               'SVendor': None, 'SDevice': None}
-encryption_class = {'Class': '10', 'Vendor': None, 'Device': None,
-                    'SVendor': None, 'SDevice': None}
-intel_processor_class = {'Class': '0b', 'Vendor': '8086', 'Device': None,
-                         'SVendor': None, 'SDevice': None}
-cavium_sso = {'Class': '08', 'Vendor': '177d', 'Device': 'a04b,a04d',
-              'SVendor': None, 'SDevice': None}
-cavium_fpa = {'Class': '08', 'Vendor': '177d', 'Device': 'a053',
-              'SVendor': None, 'SDevice': None}
-cavium_pkx = {'Class': '08', 'Vendor': '177d', 'Device': 'a0dd,a049',
-              'SVendor': None, 'SDevice': None}
-cavium_tim = {'Class': '08', 'Vendor': '177d', 'Device': 'a051',
-              'SVendor': None, 'SDevice': None}
-cavium_zip = {'Class': '12', 'Vendor': '177d', 'Device': 'a037',
-              'SVendor': None, 'SDevice': None}
-avp_vnic = {'Class': '05', 'Vendor': '1af4', 'Device': '1110',
-            'SVendor': None, 'SDevice': None}
-
-cnxk_bphy = {'Class': '08', 'Vendor': '177d', 'Device': 'a089',
-             'SVendor': None, 'SDevice': None}
-cnxk_bphy_cgx = {'Class': '08', 'Vendor': '177d', 'Device': 'a059,a060',
-                 'SVendor': None, 'SDevice': None}
-cnxk_dma = {'Class': '08', 'Vendor': '177d', 'Device': 'a081',
-            'SVendor': None, 'SDevice': None}
-cnxk_inl_dev = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f0,a0f1',
-                'SVendor': None, 'SDevice': None}
-
-hisilicon_dma = {'Class': '08', 'Vendor': '19e5', 'Device': 'a122',
-                 'SVendor': None, 'SDevice': None}
-odm_dma = {'Class': '08', 'Vendor': '177d', 'Device': 'a08c',
-           'SVendor': None, 'SDevice': None}
-
-intel_dlb = {'Class': '0b', 'Vendor': '8086', 'Device': '270b,2710,2714',
-             'SVendor': None, 'SDevice': None}
-intel_ioat_bdw = {'Class': '08', 'Vendor': '8086',
-                  'Device': '6f20,6f21,6f22,6f23,6f24,6f25,6f26,6f27,6f2e,6f2f',
-                  'SVendor': None, 'SDevice': None}
-intel_ioat_skx = {'Class': '08', 'Vendor': '8086', 'Device': '2021',
-                  'SVendor': None, 'SDevice': None}
-intel_ioat_icx = {'Class': '08', 'Vendor': '8086', 'Device': '0b00',
-                  'SVendor': None, 'SDevice': None}
-intel_idxd_spr = {'Class': '08', 'Vendor': '8086', 'Device': '0b25',
-                  'SVendor': None, 'SDevice': None}
-intel_idxd_gnrd = {'Class': '08', 'Vendor': '8086', 'Device': '11fb',
-                  'SVendor': None, 'SDevice': None}
-intel_idxd_dmr = {'Class': '08', 'Vendor': '8086', 'Device': '1212',
-                  'SVendor': None, 'SDevice': None}
-intel_ntb_skx = {'Class': '06', 'Vendor': '8086', 'Device': '201c',
-                 'SVendor': None, 'SDevice': None}
-intel_ntb_icx = {'Class': '06', 'Vendor': '8086', 'Device': '347e',
-                 'SVendor': None, 'SDevice': None}
-
-cnxk_sso = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f9,a0fa',
-            'SVendor': None, 'SDevice': None}
-cnxk_npa = {'Class': '08', 'Vendor': '177d', 'Device': 'a0fb,a0fc',
-            'SVendor': None, 'SDevice': None}
-cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
-            'SVendor': None, 'SDevice': None}
-
-virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
-              'SVendor': None, 'SDevice': None}
-
-cnxk_ml = {'Class': '08', 'Vendor': '177d', 'Device': 'a092',
-           'SVendor': None, 'SDevice': None}
-
-network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
-baseband_devices = [acceleration_class]
-crypto_devices = [encryption_class, intel_processor_class]
-dma_devices = [cnxk_dma, hisilicon_dma,
-               intel_idxd_gnrd, intel_idxd_dmr, intel_idxd_spr,
-               intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
-               odm_dma]
-eventdev_devices = [cavium_sso, cavium_tim, intel_dlb, cnxk_sso]
-mempool_devices = [cavium_fpa, cnxk_npa]
-compress_devices = [cavium_zip]
-regex_devices = [cn9k_ree]
-ml_devices = [cnxk_ml]
-misc_devices = [cnxk_bphy, cnxk_bphy_cgx, cnxk_inl_dev,
-                intel_ntb_skx, intel_ntb_icx,
-                virtio_blk]
+device_types = {
+    'net': {
+        'name': 'Network',
+        'iface': True,
+        'match': [
+            {'Class': '02', 'Vendor': None, 'Device': None},  # Network class
+            {'Class': '05', 'Vendor': '1af4', 'Device': '1110'},  # AVP vNIC
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a0dd,a049'},  # Cavium PKX
+            {'Class': '12', 'Vendor': '8086', 'Device': '0b30'},  # Intel FPGA
+        ]
+    },
+    'baseband': {
+        'name': 'Baseband',
+        'match': [
+            {'Class': '12', 'Vendor': None, 'Device': None},  # Acceleration class
+        ]
+    },
+    'crypto': {
+        'name': 'Crypto',
+        'match': [
+            {'Class': '0b', 'Vendor': '8086', 'Device': None},  # Intel Processor
+            {'Class': '10', 'Vendor': None, 'Device': None},  # Encryption class
+        ]
+    },
+    'dma': {
+        'name': 'DMA',
+        'match': [
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a081'},  # Marvell CNXK DMA
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a08c'},  # Marvell ODM DMA
+            {'Class': '08', 'Vendor': '19e5', 'Device': 'a122'},  # HiSilicon DMA
+            {'Class': '08', 'Vendor': '8086', 'Device': '0b00'},  # Intel IOAT Ice Lake
+            {'Class': '08', 'Vendor': '8086', 'Device': '0b25'},  # Intel IDXD Sapphire Rapids
+            {'Class': '08', 'Vendor': '8086', 'Device': '11fb'},  # Intel IDXD Granite Rapids
+            {'Class': '08', 'Vendor': '8086', 'Device': '1212'},  # Intel IDXD Diamond Rapids
+            {'Class': '08', 'Vendor': '8086', 'Device': '2021'},  # Intel IOAT Skylake
+            {'Class': '08', 'Vendor': '8086',  # Intel IOAT Broadwell
+             'Device': '6f20,6f21,6f22,6f23,6f24,6f25,6f26,6f27,6f2e,6f2f'},
+        ]
+    },
+    'event': {
+        'name': 'Eventdev',
+        'match': [
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a04b,a04d'},  # Cavium SSO
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a051'},  # Cavium TIM
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a0f9,a0fa'},  # Marvell CNXK SSO
+            {'Class': '0b', 'Vendor': '8086', 'Device': '270b,2710,2714'},  # Intel DLB
+        ]
+    },
+    'mempool': {
+        'name': 'Mempool',
+        'match': [
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a053'},  # Cavium FPA
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a0fb,a0fc'},  # Marvell CNXK NPA
+        ]
+    },
+    'compress': {
+        'name': 'Compress',
+        'match': [
+            {'Class': '12', 'Vendor': '177d', 'Device': 'a037'},  # Cavium ZIP
+        ]
+    },
+    'misc': {
+        'name': 'Misc (rawdev)',
+        'match': [
+            {'Class': '01', 'Vendor': '1af4', 'Device': '1001,1042'},  # VirtIO block
+            {'Class': '06', 'Vendor': '8086', 'Device': '201c'},  # Intel NTB Skylake
+            {'Class': '06', 'Vendor': '8086', 'Device': '347e'},  # Intel NTB Ice Lake
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a059,a060'},  # Marvell CNXK BPHY CGX
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a089'},  # Marvell CNXK BPHY
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a0f0,a0f1'},  # Marvell CNXK Inline
+        ]
+    },
+    'regex': {
+        'name': 'Regex',
+        'match': [
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4'},  # Marvell CN9K REE
+        ]
+    },
+    'ml': {
+        'name': 'ML',
+        'match': [
+            {'Class': '08', 'Vendor': '177d', 'Device': 'a092'},  # Marvell CNXK ML
+        ]
+    },
+}
 
 # global dict ethernet devices present. Dictionary indexed by PCI address.
 # Each device within this is itself a dictionary of device properties
@@ -351,12 +350,14 @@ def get_device_details(devices_type):
     global devices
     global dpdk_drivers
 
+    match_list = device_types[devices_type]['match']
+
     if is_linux:
-        get_basic_devinfo_linux(devices_type)
+        get_basic_devinfo_linux(match_list)
     else:
-        get_basic_devinfo_bsd(devices_type)
+        get_basic_devinfo_bsd(match_list)
 
-    if is_linux and devices_type == network_devices:
+    if is_linux and devices_type == 'net':
         # check what is the interface if any for an ssh connection if
         # any to this host, so we can mark it later.
         ssh_if = []
@@ -371,7 +372,7 @@ def get_device_details(devices_type):
 
     # based on the basic info, get extended text details
     for d in devices.keys():
-        if not device_type_match(devices[d], devices_type):
+        if not device_type_match(devices[d], match_list):
             continue
 
         # get additional info and add it to existing data
@@ -379,7 +380,7 @@ def get_device_details(devices_type):
         # No need to probe lspci
         devices[d].update(get_pci_device_details(d, False).items())
 
-        if is_linux and devices_type == network_devices:
+        if is_linux and devices_type == 'net':
             for _if in ssh_if:
                 if _if in devices[d]["Interface"].split(","):
                     devices[d]["Ssh_if"] = True
@@ -720,17 +721,21 @@ def display_devices(title, dev_list, extra_params=None):
     print("\n".join(strings))  # print one per line
 
 
-def show_device_status(devices_type, device_name, if_field=False):
+def show_device_status(devices_type):
     global dpdk_drivers
     kernel_drv = []
     dpdk_drv = []
     no_drv = []
 
+    match_list = device_types[devices_type]['match']
+    device_name = device_types[devices_type]['name']
+    if_field = device_types[devices_type].get('iface', False)
+
     print_numa = True  # by default, assume we can print NUMA information
 
     # split our list of network devices into the three categories above
     for d in devices.keys():
-        if device_type_match(devices[d], devices_type):
+        if device_type_match(devices[d], match_list):
             print_numa &= "NUMANode" in devices[d]
             if not has_driver(d):
                 no_drv.append(devices[d])
@@ -778,35 +783,9 @@ def show_status():
     Displays to the user what devices are bound to the igb_uio driver, the
     kernel driver or to no driver'''
 
-    if status_dev in ["net", "all"]:
-        show_device_status(network_devices, "Network", if_field=True)
-
-    if status_dev in ["baseband", "all"]:
-        show_device_status(baseband_devices, "Baseband")
-
-    if status_dev in ["crypto", "all"]:
-        show_device_status(crypto_devices, "Crypto")
-
-    if status_dev in ["dma", "all"]:
-        show_device_status(dma_devices, "DMA")
-
-    if status_dev in ["event", "all"]:
-        show_device_status(eventdev_devices, "Eventdev")
-
-    if status_dev in ["mempool", "all"]:
-        show_device_status(mempool_devices, "Mempool")
-
-    if status_dev in ["compress", "all"]:
-        show_device_status(compress_devices, "Compress")
-
-    if status_dev in ["misc", "all"]:
-        show_device_status(misc_devices, "Misc (rawdev)")
-
-    if status_dev in ["regex", "all"]:
-        show_device_status(regex_devices, "Regex")
-
-    if status_dev in ["ml", "all"]:
-        show_device_status(ml_devices, "ML")
+    for dev_type in device_types:
+        if status_dev in [dev_type, "all"]:
+            show_device_status(dev_type)
 
 
 def pci_glob(arg):
@@ -971,16 +950,8 @@ def do_arg_actions():
         if b_flag is not None:
             clear_data()
             # refresh if we have changed anything
-            get_device_details(network_devices)
-            get_device_details(baseband_devices)
-            get_device_details(crypto_devices)
-            get_device_details(dma_devices)
-            get_device_details(eventdev_devices)
-            get_device_details(mempool_devices)
-            get_device_details(compress_devices)
-            get_device_details(regex_devices)
-            get_device_details(ml_devices)
-            get_device_details(misc_devices)
+            for dev_type in device_types:
+                get_device_details(dev_type)
         show_status()
 
 
@@ -996,16 +967,8 @@ def main():
     parse_args()
     check_modules()
     clear_data()
-    get_device_details(network_devices)
-    get_device_details(baseband_devices)
-    get_device_details(crypto_devices)
-    get_device_details(dma_devices)
-    get_device_details(eventdev_devices)
-    get_device_details(mempool_devices)
-    get_device_details(compress_devices)
-    get_device_details(regex_devices)
-    get_device_details(ml_devices)
-    get_device_details(misc_devices)
+    for dev_type in device_types:
+        get_device_details(dev_type)
     do_arg_actions()
 
 
-- 
2.54.0

