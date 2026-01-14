Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA80D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7EA0410DF;
	Wed, 14 Jan 2026 23:25:29 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E2038410DD
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:27 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so2074175e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429527;
 x=1769034327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBbCODNMA3YADuMOoiuPQaivGk0khNB6McMZ55Pko3E=;
 b=wpn+k0iUeu0fFkZKPB6dFloSceSL2jl+4dUPR5QJMhzhReCTbXe5Hjhm5R/qgWe2UV
 4qOzwGfC/ih2qpZ/zEUXCoL+CVKcwA2IG/E0e8bm/yZ+OJkac4SpYAaP6294dOpgyoYj
 G5dNnPVXBJX4M3VDMsGoztrmHNxuPhZy0NxAGkT2uHTrbD4gVvmKGV8LO/qXoL3faSfo
 55yLwVBqjwzBtP+Pj+mRjmspd7VPKIs9z8EeX0kbzGoh7qXQRhthfxjsCnoDMN+F39w6
 N6ws8C/srK4GA2T6TMDC8XFFU4QhhwYPE1n6xGPUpQOhguGfUpGD3IdMwe6FWGmcGN36
 nynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429527; x=1769034327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YBbCODNMA3YADuMOoiuPQaivGk0khNB6McMZ55Pko3E=;
 b=dzDn9+T9cn6Jub3O36m/9YpTv5U05rWGX3LAr/nd52n/jTSw3FTzCuNHt2aqZ29/2q
 7iywE/cBEFwn3CP4BEKgkAiStCkKZFduvVlIba7HfX9CkEX9ihx5kW8Xe9h2rHUVR97O
 4aHpfVNynQb0YzRPfLPKlHrNRDSqZYfmGCytBOXAKcga7mjd1pGPEues/dAfojsH/55W
 su+Q+O0OjfSOPw790Y6TiNFk5YP/rZide6RwJiymvOcVJsyCFBRxiL7JRW6Z43gf5m+R
 1YPWMBrY0TjeuBi+QOoEEaA/pjFgy+bVfHePLCudxGapkjbVMNXipBPDwDHxxMPOmXMF
 69Xg==
X-Gm-Message-State: AOJu0YzStWDCTxiFM2FbTzncyBN3UPxpDegOg7L05eBeojPGsnwdbX4N
 NzOUYppyjhT2/ixXKPuHvZyeH5ttv3Ojn7ZHFdJcUpR03GpPgXvTIaXViV3gwrMiFGrfNBVX7JP
 cDoUz
X-Gm-Gg: AY/fxX64k9vHpyuFeculZsOzT8t1Gpj3Cekpe2LKFF6X6QxdTebg5TZ561tnbPCgdvN
 gj832TbkrJ3Ne0FuBNfDDczIKt9Wdn+xuZxkyHRTGEWRp9MuKGMwgF7KWl9RNjL0lGThzqWoBl+
 9x9yOt7d8VKmpiAvKkV9I+yW3nr4QTysDIwJmLxDJHdSeIyXrRpGIPO0pyaoVOg5Eusl+n+0qHE
 qsmbqZ7fzKLJsiUT4hl5FRmauiwDgWveORnxDhfpnoiEa28WHNQr6XwUhejAgX4kbatPu/t3eeX
 8UxegRIqV07R3nvskB/Epl6IiNSB6+Z5IbWGFD3qhUMWnvPgdsq583F8IwGmqUrpggjWZpN/iSJ
 M3y20lftqZviJT+fGe3BpgApCxSivIDL8xE/6adeHsnzvisbrVH7arRHVCkFMdYOx0sTloxOsaa
 QOk/b181f+/zuVbRsgbFYZ8Pw/JUiF+UtX/b/6BeSrl3YQq1Lp4Q==
X-Received: by 2002:a05:600c:c16a:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-47ee32e92c3mr44524225e9.4.1768429527388; 
 Wed, 14 Jan 2026 14:25:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 14/29] doc/guides: improve vDPA sample application guide
Date: Wed, 14 Jan 2026 14:21:55 -0800
Message-ID: <20260114222458.87119-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the vDPA sample application documentation:
- add Overview section for better document structure
- use consistent capitalization of vDPA
- replace contractions with full forms
- fix grammar and improve sentence clarity
- use proper article usage and punctuation
- replace abbreviations with full phrases

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/vdpa.rst | 71 +++++++++++++++++--------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index cd3ec99054..ec25a57183 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -4,41 +4,45 @@
 Vdpa Sample Application
 =======================
 
-The vdpa sample application creates vhost-user sockets by using the
-vDPA backend. vDPA stands for vhost Data Path Acceleration which utilizes
-virtio ring compatible devices to serve virtio driver directly to enable
-datapath acceleration. As vDPA driver can help to set up vhost datapath,
-this application doesn't need to launch dedicated worker threads for vhost
+Overview
+--------
+
+The vDPA sample application creates vhost-user sockets by using the
+vDPA backend. vDPA (vhost Data Path Acceleration) uses virtio ring
+compatible devices to serve a virtio driver directly, enabling
+datapath acceleration. A vDPA driver can help to set up the vhost datapath.
+This application does not need dedicated worker threads for vhost
 enqueue/dequeue operations.
 
-Testing steps
--------------
+The following shows how to start VMs with a vDPA vhost-user
+backend and verify network connection and live migration.
 
-This section shows the steps of how to start VMs with vDPA vhost-user
-backend and verify network connection & live migration.
+Compiling the Application
+-------------------------
 
-Build
-~~~~~
-
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vdpa`` sub-directory.
 
-Start the vdpa example
+Running the Application
+-----------------------
+
+Start the vDPA Example
 ~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
 
         ./dpdk-vdpa [EAL options]  -- [--client] [--interactive|-i] or [--iface SOCKET_PATH]
 
-where
+where:
 
-* --client means running vdpa app in client mode, in the client mode, QEMU needs
-  to run as the server mode and take charge of socket file creation.
-* --iface specifies the path prefix of the UNIX domain socket file, e.g.
-  /tmp/vhost-user-, then the socket files will be named as /tmp/vhost-user-<n>
-  (n starts from 0).
-* --interactive means run the vDPA sample in interactive mode:
+* --client runs the vdpa application in client mode. In client mode, QEMU
+  runs as the server and is responsible for socket file creation.
+* --iface specifies the path prefix of the UNIX domain socket file (for example,
+  /tmp/vhost-user-). The socket files are named /tmp/vhost-user-<n>
+  where n starts from 0.
+* --interactive runs the vDPA sample in interactive mode with the following
+  commands:
 
   #. help: show help message
 
@@ -50,7 +54,7 @@ where
 
   #. quit: unregister vhost driver and exit the application
 
-Take IFCVF driver for example:
+The following example uses the IFCVF driver:
 
 .. code-block:: console
 
@@ -59,13 +63,13 @@ Take IFCVF driver for example:
                 -- --interactive
 
 .. note::
-    Here 0000:06:00.3 and 0000:06:00.4 refer to virtio ring compatible devices,
-    and we need to bind vfio-pci to them before running vdpa sample.
+    Here 0000:06:00.3 and 0000:06:00.4 refer to virtio ring compatible devices.
+    Bind vfio-pci to them before running the vdpa sample:
 
     * modprobe vfio-pci
     * ./usertools/dpdk-devbind.py -b vfio-pci 06:00.3 06:00.4
 
-Then we can create 2 vdpa ports in interactive cmdline.
+Then, create two vdpa ports in the interactive command line.
 
 .. code-block:: console
 
@@ -92,24 +96,25 @@ Start the VMs
        -netdev type=vhost-user,id=vdpa,chardev=char0 \
        -device virtio-net-pci,netdev=vdpa,mac=00:aa:bb:cc:dd:ee,page-per-vq=on \
 
-After the VMs launches, we can login the VMs and configure the ip, verify the
+After the VMs launch, log into the VMs and configure the IP address to verify
 network connection via ping or netperf.
 
 .. note::
-    Suggest to use QEMU 3.0.0 which extends vhost-user for vDPA.
+    QEMU 3.0.0 or later is recommended as it extends vhost-user for vDPA.
 
 Live Migration
 ~~~~~~~~~~~~~~
-vDPA supports cross-backend live migration, user can migrate SW vhost backend
-VM to vDPA backend VM and vice versa. Here are the detailed steps. Assume A is
-the source host with SW vhost VM and B is the destination host with vDPA.
+vDPA supports cross-backend live migration. Users can migrate a SW vhost
+backend VM to a vDPA backend VM and vice versa. The following are the
+detailed steps. Assume A is the source host with the SW vhost VM and B is
+the destination host with vDPA.
 
-#. Start vdpa sample and launch a VM with exact same parameters as the VM on A,
-   in migration-listen mode:
+#. Start the vdpa sample and launch a VM with the same parameters as the VM
+   on A, in migration-listen mode:
 
    .. code-block:: console
 
-        B: <qemu-command-line> -incoming tcp:0:4444 (or other PORT))
+        B: <qemu-command-line> -incoming tcp:0:4444 (or other PORT)
 
 #. Start the migration (on source host):
 
-- 
2.51.0

