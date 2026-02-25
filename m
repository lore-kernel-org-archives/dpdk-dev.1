Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D19FCEE8A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C063402E1;
	Wed, 25 Feb 2026 12:29:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6688D400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 12:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772018979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/3Dxlnt4cHzREu2rntJUhGXUKnqBahukpeEX1Uims4=;
 b=CTNSTCaLG2G5jlPikoqVowlEPDy2mBWWaZiRxMmU3JoBUU7qREbp7UTXp+8NoEgOEja2ms
 UjoDO8a9qv+Ql4JQrwfYDVftqtT5r4LBUfN+zLEpcnjPgXpr5xFiLJ+XsyPoV4tOQee0bz
 5CgnDwxeZ7O8q7NrPe1UQnJ6kYF7kYk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-2Hq4KvcdPxiuIPnzCjiVIA-1; Wed,
 25 Feb 2026 06:29:37 -0500
X-MC-Unique: 2Hq4KvcdPxiuIPnzCjiVIA-1
X-Mimecast-MFC-AGG-ID: 2Hq4KvcdPxiuIPnzCjiVIA_1772018976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 257E219560A1; Wed, 25 Feb 2026 11:29:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D151F3003D8C; Wed, 25 Feb 2026 11:29:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [RFC 2/2] eal: configure initial device probing
Date: Wed, 25 Feb 2026 12:29:21 +0100
Message-ID: <20260225112922.3982104-2-david.marchand@redhat.com>
In-Reply-To: <20260225112922.3982104-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mt9O6Q2ycJffg4vPO5XjGSQc5BmptOhi0vnx2bx-lpw_1772018976
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

Add an EAL option to disable device probing, allowing to select per bus.

Note: the current implementation does not take combinations of the new
option with -a/-b.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test.c                           |  1 +
 app/test/test_eal_flags.c                 | 31 ++++++++++++++
 devtools/test-null.sh                     |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst |  7 ++++
 lib/eal/common/eal_common_bus.c           | 50 ++++++++++++++++++++---
 lib/eal/common/eal_common_options.c       | 14 +++++++
 lib/eal/common/eal_internal_cfg.h         |  2 +
 lib/eal/common/eal_option_list.h          |  1 +
 lib/eal/common/eal_private.h              | 13 ++++++
 lib/eal/freebsd/eal.c                     |  3 +-
 lib/eal/linux/eal.c                       |  3 +-
 lib/eal/windows/eal.c                     |  2 +-
 12 files changed, 118 insertions(+), 11 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 58ef52f312..296c5a8472 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -72,6 +72,7 @@ do_recursive_call(void)
 			{ "test_main_lcore_flag", no_action },
 			{ "test_invalid_n_flag", no_action },
 			{ "test_no_hpet_flag", no_action },
+			{ "test_no_probe_flag", no_action },
 			{ "test_allow_flag", no_action },
 			{ "test_invalid_b_flag", no_action },
 			{ "test_invalid_vdev_flag", no_action },
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b3a8d0ae6f..b5291a5123 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -46,6 +46,13 @@ test_no_huge_flag(void)
 	return TEST_SKIPPED;
 }
 
+static int
+test_no_probe_flag(void)
+{
+	printf("no_probe_flag not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
+
 static int
 test_allow_flag(void)
 {
@@ -302,6 +309,29 @@ get_number_of_sockets(void)
 }
 #endif /* RTE_EXEC_ENV_LINUX */
 
+static int
+test_no_probe_flag(void)
+{
+	const char *prefix = file_prefix_arg();
+	if (prefix == NULL)
+		return -1;
+
+	const char *wlvalid[][4] = {
+		{prgname, prefix, mp_flag, "--no-probe" },
+		{prgname, prefix, mp_flag, "--no-probe=pci" },
+	};
+
+	for (unsigned int i = 0; i < RTE_DIM(wlvalid); i++) {
+		if (launch_proc(wlvalid[i]) != 0) {
+			printf("Error (line %d) - process did not run with valid no probe parameter\n",
+				__LINE__);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Test that the app doesn't run with invalid allow option.
  * Final tests ensures it does run with valid options as sanity check (one
@@ -1678,6 +1708,7 @@ REGISTER_FAST_TEST(eal_flags_main_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_mai
 REGISTER_FAST_TEST(eal_flags_n_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_n_flag);
 REGISTER_FAST_TEST(eal_flags_hpet_autotest, NOHUGE_SKIP, ASAN_SKIP, test_no_hpet_flag);
 REGISTER_FAST_TEST(eal_flags_no_huge_autotest, NOHUGE_SKIP, ASAN_SKIP, test_no_huge_flag);
+REGISTER_FAST_TEST(eal_flags_no_probe_autotest, NOHUGE_SKIP, ASAN_SKIP, test_no_probe_flag);
 REGISTER_FAST_TEST(eal_flags_a_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_allow_flag);
 REGISTER_FAST_TEST(eal_flags_b_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_b_flag);
 REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_vdev_flag);
diff --git a/devtools/test-null.sh b/devtools/test-null.sh
index 8f21189262..617ba78bbf 100755
--- a/devtools/test-null.sh
+++ b/devtools/test-null.sh
@@ -30,7 +30,7 @@ logfile=$build/test-null.log
 (sleep 1 && echo stop) |
 # testpmd only needs 20M, make it x2 (default number of cores) for NUMA systems
 $testpmd -l $corelist --no-huge -m 40 \
-	$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
+	$libs --no-probe=pci --vdev net_null1 --vdev net_null2 $eal_options -- \
 	--no-mlockall --total-num-mbufs=2048 $testpmd_options -ia | tee $logfile
 
 # we expect two ports and some traffic is received and transmitted
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 4a3c4d9b5f..8007b72c15 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -136,6 +136,13 @@ Device-related options
 
     Disable PCI bus.
 
+*   ``--no-probe[=bus list]``
+
+    Disable device probing as part of EAL init. Disabling affects either all buses
+    when no value is passed, or the list of buses. This is especially useful when
+    the DPDK application relies on resources hotplug and has no idea of which
+    device will be used at the time rte_eal_init() is called.
+
 Multiprocessing-related options
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 0a2311a342..315bb99dd8 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <sys/queue.h>
 
@@ -67,15 +68,44 @@ rte_bus_scan(void)
 	return 0;
 }
 
-/* Probe all devices of all buses */
-RTE_EXPORT_SYMBOL(rte_bus_probe)
 int
-rte_bus_probe(void)
+eal_bus_probe(const char *excluded)
 {
-	int ret;
 	struct rte_bus *bus, *vbus = NULL;
+	char *filter = NULL;
+	int ret = 0;
+
+	if (excluded != NULL) {
+		if (!strcmp(excluded, "all")) {
+			EAL_LOG(DEBUG, "Skipped probing all buses");
+			return 0;
+		}
+
+		if (asprintf(&filter, ",%s,", excluded) == -1) {
+			EAL_LOG(ERR, "Could not allocate memory for filtering buses.");
+			return -1;
+		}
+	}
 
 	TAILQ_FOREACH(bus, &rte_bus_list, next) {
+		if (filter != NULL) {
+			char *pattern;
+			bool skip;
+
+			if (asprintf(&pattern, ",%s,", rte_bus_name(bus)) == -1) {
+				EAL_LOG(ERR, "Could not allocate memory for filtering buses.");
+				ret = -1;
+				goto out;
+			}
+			skip = strstr(filter, pattern) != NULL;
+			free(pattern);
+			if (skip) {
+				EAL_LOG(DEBUG, "Skipped probing bus %s", rte_bus_name(bus));
+				continue;
+			}
+			EAL_LOG(DEBUG, "Will probe bus %s", rte_bus_name(bus));
+		}
+
 		if (!strcmp(rte_bus_name(bus), "vdev")) {
 			vbus = bus;
 			continue;
@@ -94,7 +124,17 @@ rte_bus_probe(void)
 				rte_bus_name(vbus));
 	}
 
-	return 0;
+out:
+	free(filter);
+	return ret;
+}
+
+/* Probe all devices of all buses */
+RTE_EXPORT_SYMBOL(rte_bus_probe)
+int
+rte_bus_probe(void)
+{
+	return eal_bus_probe(NULL);
 }
 
 /* Clean up all devices of all buses */
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aad676a004..a37c245053 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -518,6 +518,8 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	memset(internal_cfg->vfio_vf_token, 0,
 			sizeof(internal_cfg->vfio_vf_token));
 
+	internal_cfg->no_probe = NULL;
+
 #ifdef RTE_LIBEAL_USE_HPET
 	internal_cfg->no_hpet = 0;
 #else
@@ -2206,6 +2208,17 @@ eal_parse_args(void)
 	}
 #endif
 
+	if (args.no_probe != NULL) {
+		if (args.no_probe == (void *)1)
+			int_cfg->no_probe = strdup("all");
+		else
+			int_cfg->no_probe = strdup(args.no_probe);
+		if (int_cfg->no_probe == NULL) {
+			EAL_LOG(ERR, "failed to allocate memory for no probe parameter");
+			return -1;
+		}
+	}
+
 	/* simple flag settings
 	 * Only set these to 1, as we don't want to set them to 0 in case
 	 * other options above have already set them.
@@ -2336,6 +2349,7 @@ eal_cleanup_config(struct internal_config *internal_cfg)
 {
 	free(internal_cfg->hugefile_prefix);
 	free(internal_cfg->hugepage_dir);
+	free(internal_cfg->no_probe);
 	free(internal_cfg->user_mbuf_pool_ops_name);
 
 	return 0;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 95d327a613..a5fbce36cf 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -57,6 +57,8 @@ struct internal_config {
 	volatile unsigned force_nrank;    /**< force number of ranks */
 	volatile unsigned no_hugetlbfs;   /**< true to disable hugetlbfs */
 	struct hugepage_file_discipline hugepage_file;
+	char *no_probe;
+	/**< a list of (or all) buses to exclude when probing devices at init */
 	volatile unsigned no_pci;         /**< true to disable PCI */
 	volatile unsigned no_hpet;        /**< true to disable HPET */
 	volatile unsigned vmware_tsc_map; /**< true to use VMware TSC mapping
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index abee16340b..487fa191bb 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -51,6 +51,7 @@ STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name",
 STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
 STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
 STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
+OPT_STR_ARG("--no-probe", NULL, "Disable device probing at init (for all or some buses)", no_probe)
 BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
 BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
 BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..51cc3c5409 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -469,6 +469,19 @@ int rte_eal_memory_detach(void);
  */
 struct rte_bus *rte_bus_find_by_device_name(const char *str);
 
+/**
+ * Call all buses probe() function except those present in the
+ * excluded string.
+ *
+ * @param excluded
+ *   A list of bus to exclude separated by ,. A "all" string
+ *   is a special case that results in skipping all buses.
+ * @return
+ *   0 on success;
+ *   (<0) on failure.
+ */
+int eal_bus_probe(const char *excluded);
+
 /**
  * For each device on the buses, call the driver-specific function for
  * device cleanup.
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 60f5e676a8..f3b4f7485b 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -717,8 +717,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	/* Probe all the buses and devices/drivers on them */
-	if (rte_bus_probe()) {
+	if (eal_bus_probe(internal_conf->no_probe) < 0) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
 		goto err_out;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d848de03d8..c81930987a 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -890,8 +890,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	/* Probe all the buses and devices/drivers on them */
-	if (rte_bus_probe()) {
+	if (eal_bus_probe(internal_conf->no_probe) < 0) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
 		goto err_out;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index f06375a624..0cb5c090bf 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -398,7 +398,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_bus_probe()) {
+	if (eal_bus_probe(internal_conf->no_probe) < 0) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
 		goto err_out;
-- 
2.53.0

