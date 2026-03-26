Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854BB106F31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1522E42D87;
	Thu, 26 Mar 2026 11:25:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DA48402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFOlTml8zKflMPrKNwgmENRA6vasT/wsbyRe4tnQlxY=;
 b=JYtXix+cBn4LDB/663uFeF5kkqJf47xYYGaJS/VofmzW6xLV0dtWGDOlB5dnRI+nsS/Z8v
 4Id2eh7s9v8pGw9RTzNlNChzyi0kNijizLAs64GVVK/CFP3lyuazhtjM4yAKPZCiJ5kT1e
 OUKhtzp1/LK7nNbfKHTUo6dp51wX3Wg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-lXi1RHJyMSGaNUDy4AW7Lw-1; Thu,
 26 Mar 2026 06:25:37 -0400
X-MC-Unique: lXi1RHJyMSGaNUDy4AW7Lw-1
X-Mimecast-MFC-AGG-ID: lXi1RHJyMSGaNUDy4AW7Lw_1774520736
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AF6D1944DD9; Thu, 26 Mar 2026 10:25:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D56241800671; Thu, 26 Mar 2026 10:25:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 7/7] eal: configure initial device probing
Date: Thu, 26 Mar 2026 11:24:23 +0100
Message-ID: <20260326102424.2361945-8-david.marchand@redhat.com>
In-Reply-To: <20260326102424.2361945-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EADXKywhBNkafEWXUhFZjRvWJ94e6cfYXikm-10vEwQ_1774520736
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
block-listing to allow-listing which can be summed up as disabling
automatic probing.
In case some applications want to require automatic probing, add the
opposite option.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Robin Jarry <rjarry@redhat.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Kevin Traynor <ktraynor@redhat.com>
---
Changes since RFC v2:
- added -A short option alias as it seems intuitive to use with -a,
- renamed option to --no-auto-probing (half Robin and half Thomas
  suggestions),
- made -A and -b conflicting options,
- added opposite option in case an application wants an explicit behavior,
- updated unit tests accordingly,
- updated documentation (namely some detail on --vdev),

Changes since RFC v1:
- changed approach following Bruce suggestion,

---
 app/test/test_eal_flags.c                 | 63 +++++++++++++++++++++++
 devtools/test-null.sh                     |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst | 13 +++++
 lib/eal/common/eal_common_bus.c           | 17 +++---
 lib/eal/common/eal_common_options.c       | 10 ++++
 lib/eal/common/eal_internal_cfg.h         |  1 +
 lib/eal/common/eal_option_list.h          |  2 +
 7 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b3a8d0ae6f..5594cc992d 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -119,6 +119,8 @@ test_misc_flags(void)
 #define no_hpet "--no-hpet"
 #define no_huge "--no-huge"
 #define no_shconf "--no-shconf"
+#define auto_probing "--auto-probing"
+#define no_auto_probing "--no-auto-probing"
 #define allow "--allow"
 #define vdev "--vdev"
 #define no_pci "--no-pci"
@@ -338,6 +340,14 @@ test_allow_flag(void)
 			allow, "09:0B.3,type=test",
 			allow, "08:00.1,type=normal",
 	};
+	const char *wlval4[] = {prgname, prefix, mp_flag, eal_debug_logs,
+			no_auto_probing };
+	const char *wlval5[] = {prgname, prefix, mp_flag, eal_debug_logs,
+			no_auto_probing, allow, "00FF:09:0B.3"};
+	const char *wlval6[] = {prgname, prefix, mp_flag, eal_debug_logs,
+			auto_probing };
+	const char *wlval7[] = {prgname, prefix, mp_flag, eal_debug_logs,
+			auto_probing, allow, "00FF:09:0B.3"};
 
 	for (i = 0; i < RTE_DIM(wlinval); i++) {
 		if (launch_proc(wlinval[i]) == 0) {
@@ -360,6 +370,26 @@ test_allow_flag(void)
 			__LINE__);
 		return -1;
 	}
+	if (launch_proc(wlval4) != 0) {
+		printf("Error (line %d) - process did not run ok with no-auto-probing\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(wlval5) != 0) {
+		printf("Error (line %d) - process did not run ok with no-auto-probing + allow\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(wlval6) != 0) {
+		printf("Error (line %d) - process did not run ok with auto-probing\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(wlval7) != 0) {
+		printf("Error (line %d) - process did not run ok with auto-probing + allow\n",
+			__LINE__);
+		return -1;
+	}
 
 	return 0;
 }
@@ -383,6 +413,11 @@ test_invalid_b_flag(void)
 		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "error0:0:0.1"},
 		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0:0.1.2"},
 	};
+	const char *blinval_probing[] =
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0.0", auto_probing};
+	const char *blinval_probing_inval[] =
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0.0", no_auto_probing};
+
 	/* Test with valid blocklist option */
 	const char *blval[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			       "-b", "FF:09:0B.3"};
@@ -396,6 +431,16 @@ test_invalid_b_flag(void)
 			return -1;
 		}
 	}
+	if (launch_proc(blinval_probing) != 0) {
+		printf("Error (line %d) - process did not run ok with blocklist and auto-probing\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(blinval_probing_inval) == 0) {
+		printf("Error (line %d) - process did run ok with blocklist and no-auto-probing\n",
+			__LINE__);
+		return -1;
+	}
 	if (launch_proc(blval) != 0) {
 		printf("Error (line %d) - process did not run ok with valid blocklist value\n",
 			__LINE__);
@@ -434,6 +479,12 @@ test_invalid_vdev_flag(void)
 	const char *vdevval3[] = {prgname, prefix, no_huge, eal_debug_logs,
 				bus_debug_logs, no_pci, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
 
+	const char *vdevval4[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs, no_auto_probing, vdev, "net_ring0"};
+
+	const char *vdevval5[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs, auto_probing, vdev, "net_ring0"};
+
 	if (launch_proc(vdevinval) == 0) {
 		printf("Error (line %d) - process did run ok with invalid vdev parameter\n",
 			__LINE__);
@@ -457,6 +508,18 @@ test_invalid_vdev_flag(void)
 			__LINE__);
 		return -1;
 	}
+
+	if (launch_proc(vdevval4) != 0) {
+		printf("Error (line %d) - process did not run ok with valid vdev value and no-auto-probing\n",
+			__LINE__);
+		return -1;
+	}
+
+	if (launch_proc(vdevval5) != 0) {
+		printf("Error (line %d) - process did not run ok with valid vdev value and auto-probing\n",
+			__LINE__);
+		return -1;
+	}
 	return 0;
 #else
 	return TEST_SKIPPED;
diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index 8f21189262..5e8a1b20cd 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -30,7 +30,7 @@ logfile=$build/test-null.log
 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA systems
 $testpmd -l $corelist --no-huge -m 40 \
-	$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
+	$libs -A --vdev net_null1 --vdev net_null2 $eal_options -- \
 	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia | tee $logfile
 
 # we expect two ports and some traffic is received and transmitted
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 4a3c4d9b5f..db9eff9321 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -101,6 +101,19 @@ Lcore-related options
 Device-related options
 ~~~~~~~~~~~~~~~~~~~~~~
 
+*   ``-A, --no-auto-probing``
+
+    By default, EAL probes all devices on every available bus, unless some ``-a``/``-b``
+    options are passed.
+    Disable automatic probing of non-blocked devices.
+
+.. Note::
+    Block list cannot be used when auto probing is disabled.
+
+    On the other hand, disabling auto probing does not affect the VDEV bus.
+    The VDEV bus is not concerned by automatic probing and requires explicit
+    ``-a`` or ``--vdev``.
+
 *   ``-b, --block <[domain:]bus:devid.func>``
 
     Skip probing a PCI device to prevent EAL from using it.
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 2ca0af7914..47ba303468 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -250,18 +250,23 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
 bool
 rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
 {
+	const struct internal_config *internal_conf = eal_get_internal_configuration();
 	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
+	enum rte_bus_scan_mode scan_mode = bus->conf.scan_mode;
 
-	switch (bus->conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
+	if (scan_mode == RTE_BUS_SCAN_UNDEFINED) {
+		if (internal_conf->no_auto_probing != 0)
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
index aad676a004..290386dc63 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -233,10 +233,15 @@ eal_collate_args(int argc, char **argv)
 		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
 		return -1;
 	}
+	if (args.no_auto_probing && !TAILQ_EMPTY(&args.block)) {
+		EAL_LOG(ERR, "Options no-auto-probing and block (-b) can't be used at the same time");
+		return -1;
+	}
 
 	/* for non-list args, we can just check for zero/null values using macro */
 	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
 			CONFLICTING_OPTIONS(args, service_coremask, service_corelist) ||
+			CONFLICTING_OPTIONS(args, no_auto_probing, auto_probing) ||
 			CONFLICTING_OPTIONS(args, no_telemetry, telemetry) ||
 			CONFLICTING_OPTIONS(args, memory_size, numa_mem) ||
 			CONFLICTING_OPTIONS(args, no_huge, numa_mem) ||
@@ -518,6 +523,8 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	memset(internal_cfg->vfio_vf_token, 0,
 			sizeof(internal_cfg->vfio_vf_token));
 
+	internal_cfg->no_auto_probing = 0;
+
 #ifdef RTE_LIBEAL_USE_HPET
 	internal_cfg->no_hpet = 0;
 #else
@@ -1972,6 +1979,9 @@ eal_parse_args(void)
 		}
 	}
 
+	if (args.no_auto_probing)
+		int_cfg->no_auto_probing = 1;
+
 	/* device -a/-b/-vdev options*/
 	TAILQ_FOREACH(arg, &args.allow, next)
 		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 95d327a613..fac45cbe66 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -104,6 +104,7 @@ struct internal_config {
 	struct simd_bitwidth max_simd_bitwidth;
 	/**< max simd bitwidth path to use */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
+	unsigned int no_auto_probing; /**< true to switch from block-listing to allow-listing */
 };
 
 void eal_reset_internal_config(struct internal_config *internal_cfg);
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index abee16340b..6a5ddfd8d1 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -32,6 +32,7 @@
  * Format of each entry: long name, short name, help string, struct member name.
  */
 /* (Alphabetical) List of common options first */
+BOOL_ARG("--auto-probing", NULL, "Let EAL probe all available devices unless some -a/-b option is set.", auto_probing)
 LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
 STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
 LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
@@ -51,6 +52,7 @@ STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name",
 STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
 STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
 STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
+BOOL_ARG("--no-auto-probing", "-A", "Do not probe any devices unless some -a option is set", no_auto_probing)
 BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
 BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
 BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
-- 
2.53.0

