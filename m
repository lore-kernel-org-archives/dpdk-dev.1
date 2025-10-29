Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536FECCF9EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8617840647;
	Wed, 29 Oct 2025 17:46:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2126C4028D
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:46:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761756396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vHXqginZl6x4VjImZAX3WOz16ab7gk7iG7/pzgd6xQw=;
 b=hDQEdIQGGrWjM8LWNdwzYT0ccyrbc+vGih6pVAE9NKLXUouIu//cJeOV4m+hsYkzhEX06l
 ch4twA9zXXGeQcVheMKNcXKCh/RE2kseMB8AImS9/p/WXODo235hdOj027fVTlecOmVmZ8
 quJPPIsb9SCmq7D9G3Nk+la85t4qz3I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-4_0w-SLsP1S7yCFEtYbuWQ-1; Wed,
 29 Oct 2025 12:46:34 -0400
X-MC-Unique: 4_0w-SLsP1S7yCFEtYbuWQ-1
X-Mimecast-MFC-AGG-ID: 4_0w-SLsP1S7yCFEtYbuWQ_1761756393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F6771800743; Wed, 29 Oct 2025 16:46:33 +0000 (UTC)
Received: from ringo.home (unknown [10.45.225.231])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D58FD30001A2; Wed, 29 Oct 2025 16:46:31 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH dpdk] pmdinfogen: fix warning with python 3.14
Date: Wed, 29 Oct 2025 17:46:17 +0100
Message-ID: <20251029164616.76233-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8e4zLK2JY8r-EEfWDceTNi9-vXpuCBRHydstjm12oVs_1761756393
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

Fix the following warning seen on Fedora 43 with Python 3.14:

 buildtools/pmdinfogen.py:118: DeprecationWarning: Due to '_pack_', the
 'rte_pci_id' Structure will use memory layout compatible with MSVC
 (Windows). If this is intended, set _layout_ to 'ms'. The implicit
 default is dep recated and slated to become an error in Python 3.19.

Use the struct module which is simpler and assumes everything is packed
by default.

There is no change in the output of dpdk-pmdinfo.py before and after
this patch.

Link: https://docs.python.org/3/library/struct.html
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 buildtools/pmdinfogen.py | 42 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/buildtools/pmdinfogen.py b/buildtools/pmdinfogen.py
index 63e0a8b364a8..4401106f0bf5 100755
--- a/buildtools/pmdinfogen.py
+++ b/buildtools/pmdinfogen.py
@@ -4,9 +4,9 @@
 # Copyright (c) 2020 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
 
 import argparse
-import ctypes
 import json
 import re
+import struct
 import sys
 import tempfile
 
@@ -110,24 +110,6 @@ def find_by_name(self, name):
         return None
 
 
-def define_rte_pci_id(is_big_endian):
-    base_type = ctypes.LittleEndianStructure
-    if is_big_endian:
-        base_type = ctypes.BigEndianStructure
-
-    class rte_pci_id(base_type):
-        _pack_ = True
-        _fields_ = [
-            ("class_id", ctypes.c_uint32),
-            ("vendor_id", ctypes.c_uint16),
-            ("device_id", ctypes.c_uint16),
-            ("subsystem_vendor_id", ctypes.c_uint16),
-            ("subsystem_device_id", ctypes.c_uint16),
-        ]
-
-    return rte_pci_id
-
-
 class Driver:
     OPTIONS = [
         ("params", "_param_string_export"),
@@ -166,26 +148,24 @@ def _load_pci_ids(image, table_name_symbol):
         if not table_symbol:
             raise Exception("PCI table declared but not defined: %d" % table_name)
 
-        rte_pci_id = define_rte_pci_id(image.is_big_endian)
+        if image.is_big_endian:
+            fmt = ">"
+        else:
+            fmt = "<"
+        fmt += "LHHHH"
 
         result = []
         while True:
-            size = ctypes.sizeof(rte_pci_id)
+            size = struct.calcsize(fmt)
             offset = size * len(result)
             data = table_symbol.get_value(offset, size)
             if not data:
                 break
-            pci_id = rte_pci_id.from_buffer_copy(data)
-            if not pci_id.device_id:
+            _, vendor, device, ss_vendor, ss_device = struct.unpack_from(fmt, data)
+            if not device:
                 break
-            result.append(
-                [
-                    pci_id.vendor_id,
-                    pci_id.device_id,
-                    pci_id.subsystem_vendor_id,
-                    pci_id.subsystem_device_id,
-                ]
-            )
+            result.append((vendor, device, ss_vendor, ss_device))
+
         return result
 
     def dump(self, file):
-- 
2.51.1

