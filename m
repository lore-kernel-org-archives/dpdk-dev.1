Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A5FD8FD3
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E250F4067A;
	Thu, 26 Feb 2026 17:21:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 49A8440649
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOEiDOAmy2vdiOJkR5t/ykbxsmUcS7N0eS6+RAG/7N4=;
 b=g3p7x2UvTxNk0zq5Pq9PTyt+9zoX76Ww8PV+6/3L4lYo+aRePBoyKllmOKiVdh+6Xq6BWI
 tpwjWsoF/Q0ERAmAnlkl6Q1QvhmTxjyke35yuBL5kEEB6hJchvvmUwnIiZwFRpzxZgACnb
 +tGP0nLU2py28VDLqHKPg3cKNyzRbdU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-eLqj5c7fPqqNIWWZVudD8A-1; Thu,
 26 Feb 2026 11:21:29 -0500
X-MC-Unique: eLqj5c7fPqqNIWWZVudD8A-1
X-Mimecast-MFC-AGG-ID: eLqj5c7fPqqNIWWZVudD8A_1772122889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B628D1800473; Thu, 26 Feb 2026 16:21:28 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 541BB1956056; Thu, 26 Feb 2026 16:21:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC v2 5/5] eal: configure initial device probing
Date: Thu, 26 Feb 2026 17:20:56 +0100
Message-ID: <20260226162057.207202-6-david.marchand@redhat.com>
In-Reply-To: <20260226162057.207202-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fvzB25OgMI4vqdxxqupZ0kx-9vKoZtD5Ebt54MUDZtw_1772122889
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

Some applications use port hotplug as their primary way for using DPDK
resources.
Having a systematic device probing is a problem when not all available
resources will be used by the application, as such applications won't set
an explicit allow list at startup.

This is the case for OVS on systems with multiple mlx5 devices:
one device can be used by the kernel while the other(s) are used by DPDK.
In such a setup, the kernel used device may get reconfigured in
unexpected ways and trigger issues like the one described by Kevin
not so long ago in bugzilla 1873.

Add an EAL option so that we can change the default behavior from
block-listing to allow-listing.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- changed approach following Bruce suggestion,

---
 app/test/test_eal_flags.c                 |  9 ++++++++
 devtools/test-null.sh                     |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst |  6 ++++++
 lib/eal/common/eal_common_bus.c           | 25 +++++++++++++++++------
 lib/eal/common/eal_common_options.c       |  3 +++
 lib/eal/common/eal_option_list.h          |  1 +
 lib/eal/common/eal_private.h              |  6 ++++++
 7 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b3a8d0ae6f..a58d0b9c06 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -1030,6 +1030,10 @@ test_misc_flags(void)
 	const char * const argv28[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-color=invalid" };
 
+	/* Try running with --allow-explicitly */
+	const char * const argv29[] = {prgname, prefix, mp_flag, eal_debug_logs,
+				       "--allow-explicitly" };
+
 	/* run all tests also applicable to FreeBSD first */
 
 	if (launch_proc(argv0) == 0) {
@@ -1176,6 +1180,11 @@ test_misc_flags(void)
 			__LINE__);
 		goto fail;
 	}
+	if (launch_proc(argv29) != 0) {
+		printf("Error (line %d) - process did not run ok with --allow-explicitly parameter\n",
+			__LINE__);
+		goto fail;
+	}
 
 	rmdir(hugepath_dir3);
 	rmdir(hugepath_dir2);
diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index 8f21189262..37b8760f60 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -30,7 +30,7 @@ logfile=$build/test-null.log
 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA systems
 $testpmd -l $corelist --no-huge -m 40 \
-	$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
+	$libs --allow-explicitly --vdev net_null1 --vdev net_null2 $eal_options -- \
 	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia | tee $logfile
 
 # we expect two ports and some traffic is received and transmitted
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 4a3c4d9b5f..f6e56468b5 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -101,6 +101,12 @@ Lcore-related options
 Device-related options
 ~~~~~~~~~~~~~~~~~~~~~~
 
+*   ``--allow-explicitly``
+
+    By default, EAL probes all devices on every available bus, unless some ``-a``/``-b``/``--vdev``
+    options are passed.
+    However, when an application relies on hotplug, it may want to plug each device explicitly.
+
 *   ``-b, --block <[domain:]bus:devid.func>``
 
     Skip probing a PCI device to prevent EAL from using it.
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index fbe20cfe35..9a29c6a062 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -15,6 +15,8 @@
 #include <eal_export.h>
 #include "eal_private.h"
 
+static bool allow_explicitly;
+
 static struct rte_bus_list rte_bus_list =
 	TAILQ_HEAD_INITIALIZER(rte_bus_list);
 
@@ -98,6 +100,12 @@ rte_bus_probe(void)
 	return 0;
 }
 
+void
+eal_bus_set_allow_explicitly(void)
+{
+	allow_explicitly = true;
+}
+
 /* Clean up all devices of all buses */
 int
 eal_bus_cleanup(void)
@@ -231,16 +239,21 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
 bool
 rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs)
 {
-	switch (bus->conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
+	enum rte_bus_scan_mode scan_mode = bus->conf.scan_mode;
+
+	if (scan_mode == RTE_BUS_SCAN_UNDEFINED) {
+		if (allow_explicitly)
+			scan_mode = RTE_BUS_SCAN_ALLOWLIST;
+		else
+			scan_mode = RTE_BUS_SCAN_BLOCKLIST;
+	}
+
+	if (scan_mode == RTE_BUS_SCAN_ALLOWLIST) {
 		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
 			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
+	} else {
 		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
 			return false;
-		break;
 	}
 	return true;
 }
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aad676a004..3f75f2c436 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1972,6 +1972,9 @@ eal_parse_args(void)
 		}
 	}
 
+	if (args.allow_explicitly)
+		eal_bus_set_allow_explicitly();
+
 	/* device -a/-b/-vdev options*/
 	TAILQ_FOREACH(arg, &args.allow, next)
 		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index abee16340b..4e02766500 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -32,6 +32,7 @@
  * Format of each entry: long name, short name, help string, struct member name.
  */
 /* (Alphabetical) List of common options first */
+BOOL_ARG("--allow-explicitly", NULL, "Change EAL device probing to consider only allowed devices", allow_explicitly)
 LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
 STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
 LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..0bad3de56c 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -469,6 +469,12 @@ int rte_eal_memory_detach(void);
  */
 struct rte_bus *rte_bus_find_by_device_name(const char *str);
 
+/**
+ * Change behavior of rte_bus_probe() from a block-listing approach
+ * to an allow-listing approach.
+ */
+void eal_bus_set_allow_explicitly(void);
+
 /**
  * For each device on the buses, call the driver-specific function for
  * device cleanup.
-- 
2.53.0

