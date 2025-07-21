Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71676C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D466F40671;
	Mon, 21 Jul 2025 17:09:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 79E8D406BB
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753110584; x=1784646584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SPggl80n5phtQFD1LfDEhSTrRr+y7oU3PVf56GXDMtE=;
 b=OVyUXkVTJbOgjom3VffOeLqpnMsQlCc0x8QJGecpSbWu+3tMFBu8gpQR
 a//vjRQNxwkneh0mTFYPrpZgKKqqyXH1ow8bsVgMeV9slXHdjKqUoAU79
 h0Gm8O51H5FddXErbwsTyRQPhqRawcrzo0nIUU6SxQIQiLR8K9rGPBXAM
 UnBFGxSsKmuM8bpISHtiIqne6EmaOw/oiS27cH5OUEebsQXTBvrGwTC86
 ruWPrSKzS9lfZlW8cMwQ5g7B9flsFM9Pk8Bv/I7fptegKTDSXaZXfk579
 yhw7E/1+cAYcyBjgn5ccDO16AO7JyEtXBCu5/eJYuUfXs2HAU6ql1NSIp A==;
X-CSE-ConnectionGUID: fCEAxg3URXix+88Zt57nTw==
X-CSE-MsgGUID: 9XD8+aX1TfWFWv/dcnLtgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55179834"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="55179834"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:09:41 -0700
X-CSE-ConnectionGUID: XfvbjzI8R/mcKQsEtyzT2Q==
X-CSE-MsgGUID: ciWOnxxhRrWY/xnfMBvz9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="159291230"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 21 Jul 2025 08:09:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v4 7/9] eal: ensure proper cleanup on EAL init failure
Date: Mon, 21 Jul 2025 16:08:40 +0100
Message-ID: <20250721150843.2737763-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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

When rte_eal_init fails part way through, any saved EAL arguments need
to be freed, and the run_once flag needs to be set back to zero again.
The former task was never done on failure, and the latter was only done
on some occasions. Rework the error handling to always go to an err_out
label where cleanup is done.

To prevent memory leaks from the saved arguments when eal_init is called
twice, the check for multiple calls must be done first before the
argument saving and parsing is done.

This patch modifies all three eal.c files. Windows doesn't actually need
changes, since there are no args saved, and no run_once sentinel value,
but updating it keeps it consistent with FreeBSD and Linux versions.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
NOTE: this patch can probably be squashed in with the changes in the
previous one, but for easier review I've kept it separate for now.
---
 lib/eal/common/eal_common_options.c | 37 ++++++++----
 lib/eal/common/eal_options.h        |  1 +
 lib/eal/freebsd/eal.c               | 83 +++++++++++++-------------
 lib/eal/linux/eal.c                 | 90 ++++++++++++++---------------
 lib/eal/windows/eal.c               | 47 ++++++++-------
 5 files changed, 137 insertions(+), 121 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aea2c813ed..9c27d44a96 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -271,6 +271,8 @@ rte_set_application_usage_hook(rte_usage_hook_t usage_func)
 
 int
 eal_save_args(__rte_unused int argc, __rte_unused char **argv) { return 0; }
+void
+eal_clean_saved_args(void) { /* no-op */ }
 
 #else /* RTE_EXEC_ENV_WINDOWS */
 static char **eal_args;
@@ -302,6 +304,28 @@ handle_eal_info_request(const char *cmd, const char *params __rte_unused,
 	return used;
 }
 
+void
+eal_clean_saved_args(void)
+{
+	int i;
+
+	if (eal_args == NULL)
+		return;
+
+	if (eal_app_args != NULL) {
+		i = 0;
+		while (eal_app_args[i] != NULL)
+			free(eal_app_args[i++]);
+		free(eal_app_args);
+		eal_app_args = NULL;
+	}
+	i = 0;
+	while (eal_args[i] != NULL)
+		free(eal_args[i++]);
+	free(eal_args);
+	eal_args = NULL;
+}
+
 int
 eal_save_args(int argc, char **argv)
 {
@@ -346,18 +370,7 @@ eal_save_args(int argc, char **argv)
 	return 0;
 
 error:
-	if (eal_app_args != NULL) {
-		i = 0;
-		while (eal_app_args[i] != NULL)
-			free(eal_app_args[i++]);
-		free(eal_app_args);
-		eal_app_args = NULL;
-	}
-	i = 0;
-	while (eal_args[i] != NULL)
-		free(eal_args[i++]);
-	free(eal_args);
-	eal_args = NULL;
+	eal_clean_saved_args();
 	return -1;
 }
 #endif /* !RTE_EXEC_ENV_WINDOWS */
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index c4d2cc84dc..fd28111e73 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -124,6 +124,7 @@ int eal_check_common_options(struct internal_config *internal_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
+void eal_clean_saved_args(void);
 int handle_eal_info_request(const char *cmd, const char *params __rte_unused,
 		struct rte_tel_data *d);
 
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index ee8bf92bff..2882d218f6 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -418,6 +418,14 @@ rte_eal_init(int argc, char **argv)
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
 	/* Save and collate args at the top */
 	eal_save_args(argc, argv);
 
@@ -425,14 +433,14 @@ rte_eal_init(int argc, char **argv)
 	if (fctret < 0) {
 		rte_eal_init_alert("invalid command-line arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	/* setup log as early as possible */
 	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	eal_log_init(getprogname());
@@ -441,21 +449,14 @@ rte_eal_init(int argc, char **argv)
 	if (!rte_cpu_is_supported()) {
 		rte_eal_init_alert("unsupported cpu type.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	/* verify if DPDK supported on architecture MMU */
 	if (!eal_mmu_supported()) {
 		rte_eal_init_alert("unsupported MMU type.");
 		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
-					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
-		rte_eal_init_alert("already called initialization.");
-		rte_errno = EALREADY;
-		return -1;
+		goto err_out;
 	}
 
 	eal_reset_internal_config(internal_conf);
@@ -463,14 +464,13 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_parse_args() < 0) {
 		rte_eal_init_alert("Error parsing command-line arguments.");
 		rte_errno = EINVAL;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	/* FreeBSD always uses legacy memory model */
@@ -483,37 +483,34 @@ rte_eal_init(int argc, char **argv)
 	if (eal_plugins_init() < 0) {
 		rte_eal_init_alert("Cannot init plugins");
 		rte_errno = EINVAL;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_trace_init() < 0) {
 		rte_eal_init_alert("Cannot init trace");
 		rte_errno = EFAULT;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_option_device_parse()) {
 		rte_errno = ENODEV;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_intr_init() < 0) {
 		rte_eal_init_alert("Cannot init interrupt-handling thread");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_alarm_init() < 0) {
 		rte_eal_init_alert("Cannot init alarm");
 		/* rte_eal_alarm_init sets rte_errno on failure. */
-		return -1;
+		goto err_out;
 	}
 
 	/* Put mp channel init before bus scan so that we can init the vdev
@@ -523,15 +520,14 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_init_alert("failed to init mp channel");
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			rte_errno = EFAULT;
-			return -1;
+			goto err_out;
 		}
 	}
 
 	if (rte_bus_scan()) {
 		rte_eal_init_alert("Cannot scan the buses for devices");
 		rte_errno = ENODEV;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -562,13 +558,13 @@ rte_eal_init(int argc, char **argv)
 	if (iova_mode == RTE_IOVA_PA && !has_phys_addr) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' since physical addresses are not available");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	if (iova_mode == RTE_IOVA_PA && !RTE_IOVA_IN_MBUF) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' as it is disabled during build");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	rte_eal_get_configuration()->iova_mode = iova_mode;
@@ -583,8 +579,7 @@ rte_eal_init(int argc, char **argv)
 		if (ret < 0) {
 			rte_eal_init_alert("Cannot get hugepage information.");
 			rte_errno = EACCES;
-			rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-			return -1;
+			goto err_out;
 		}
 	}
 
@@ -613,7 +608,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -622,14 +617,14 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init memory");
 		rte_errno = ENOMEM;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_malloc_heap_init() < 0) {
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_unlock();
@@ -637,19 +632,19 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_malloc_heap_populate() < 0) {
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_tailqs_init() < 0) {
 		rte_eal_init_alert("Cannot init tail queues for objects");
 		rte_errno = EFAULT;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_timer_init() < 0) {
 		rte_eal_init_alert("Cannot init HPET or TSC timers");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	eal_rand_init();
@@ -660,7 +655,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -713,14 +708,14 @@ rte_eal_init(int argc, char **argv)
 	if (ret) {
 		rte_eal_init_alert("rte_service_init() failed");
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/* Probe all the buses and devices/drivers on them */
 	if (rte_bus_probe()) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	/* initialize default service/lcore mappings and start running. Ignore
@@ -729,7 +724,7 @@ rte_eal_init(int argc, char **argv)
 	ret = rte_service_start_with_defaults();
 	if (ret < 0 && ret != -ENOTSUP) {
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -744,18 +739,22 @@ rte_eal_init(int argc, char **argv)
 	 */
 	if (!internal_conf->no_shconf && eal_clean_runtime_dir() < 0) {
 		rte_eal_init_alert("Cannot clear runtime directory");
-		return -1;
+		goto err_out;
 	}
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !internal_conf->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
 				&internal_conf->ctrl_cpuset) != 0)
-			return -1;
+			goto err_out;
 	}
 
 	eal_mcfg_complete();
 
 	return fctret;
+err_out:
+	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_clean_saved_args();
+	return -1;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_cleanup)
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index f59cb43b0e..210d461497 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -579,6 +579,14 @@ rte_eal_init(int argc, char **argv)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
@@ -586,14 +594,14 @@ rte_eal_init(int argc, char **argv)
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	/* setup log as early as possible */
 	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	eal_log_init(program_invocation_short_name);
@@ -602,21 +610,14 @@ rte_eal_init(int argc, char **argv)
 	if (!rte_cpu_is_supported()) {
 		rte_eal_init_alert("unsupported cpu type.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	/* verify if DPDK supported on architecture MMU */
 	if (!eal_mmu_supported()) {
 		rte_eal_init_alert("unsupported MMU type.");
 		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
-					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
-		rte_eal_init_alert("already called initialization.");
-		rte_errno = EALREADY;
-		return -1;
+		goto err_out;
 	}
 
 	eal_reset_internal_config(internal_conf);
@@ -624,49 +625,46 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_parse_args() < 0) {
-		rte_eal_init_alert("Invalid command line arguments.");
+		rte_eal_init_alert("Error parsing command line arguments.");
 		rte_errno = EINVAL;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_plugins_init() < 0) {
 		rte_eal_init_alert("Cannot init plugins");
 		rte_errno = EINVAL;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_trace_init() < 0) {
 		rte_eal_init_alert("Cannot init trace");
 		rte_errno = EFAULT;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_option_device_parse()) {
 		rte_errno = ENODEV;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_intr_init() < 0) {
 		rte_eal_init_alert("Cannot init interrupt-handling thread");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_alarm_init() < 0) {
 		rte_eal_init_alert("Cannot init alarm");
 		/* rte_eal_alarm_init sets rte_errno on failure. */
-		return -1;
+		goto err_out;
 	}
 
 	/* Put mp channel init before bus scan so that we can init the vdev
@@ -676,15 +674,14 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_init_alert("failed to init mp channel");
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			rte_errno = EFAULT;
-			return -1;
+			goto err_out;
 		}
 	}
 
 	if (rte_bus_scan()) {
 		rte_eal_init_alert("Cannot scan the buses for devices");
 		rte_errno = ENODEV;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 
 	phys_addrs = rte_eal_using_phys_addrs() != 0;
@@ -727,13 +724,13 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_iova_mode() == RTE_IOVA_PA && !phys_addrs) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' since physical addresses are not available");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_iova_mode() == RTE_IOVA_PA && !RTE_IOVA_IN_MBUF) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' as it is disabled during build");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	EAL_LOG(INFO, "Selected IOVA mode '%s'",
@@ -747,8 +744,7 @@ rte_eal_init(int argc, char **argv)
 		if (ret < 0) {
 			rte_eal_init_alert("Cannot get hugepage information.");
 			rte_errno = EACCES;
-			rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-			return -1;
+			goto err_out;
 		}
 	}
 
@@ -772,8 +768,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_vfio_enable("vfio")) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 #endif
 	/* in secondary processes, memory init may allocate additional fbarrays
@@ -783,7 +778,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -792,7 +787,7 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init memory");
 		rte_errno = ENOMEM;
-		return -1;
+		goto err_out;
 	}
 
 	/* the directories are locked during eal_hugepage_info_init */
@@ -802,7 +797,7 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_unlock();
@@ -810,25 +805,25 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_malloc_heap_populate() < 0) {
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	/* register multi-process action callbacks for hotplug after memory init */
 	if (eal_mp_dev_hotplug_init() < 0) {
 		rte_eal_init_alert("failed to register mp callback for hotplug");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_tailqs_init() < 0) {
 		rte_eal_init_alert("Cannot init tail queues for objects");
 		rte_errno = EFAULT;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_timer_init() < 0) {
 		rte_eal_init_alert("Cannot init HPET or TSC timers");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	eal_rand_init();
@@ -839,7 +834,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -890,14 +885,14 @@ rte_eal_init(int argc, char **argv)
 	if (ret) {
 		rte_eal_init_alert("rte_service_init() failed");
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/* Probe all the buses and devices/drivers on them */
 	if (rte_bus_probe()) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	/* initialize default service/lcore mappings and start running. Ignore
@@ -906,7 +901,7 @@ rte_eal_init(int argc, char **argv)
 	ret = rte_service_start_with_defaults();
 	if (ret < 0 && ret != -ENOTSUP) {
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -921,18 +916,23 @@ rte_eal_init(int argc, char **argv)
 	 */
 	if (!internal_conf->no_shconf && eal_clean_runtime_dir() < 0) {
 		rte_eal_init_alert("Cannot clear runtime directory");
-		return -1;
+		goto err_out;
 	}
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !internal_conf->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
 				&internal_conf->ctrl_cpuset) != 0)
-			return -1;
+			goto err_out;
 	}
 
 	eal_mcfg_complete();
 
 	return fctret;
+
+err_out:
+	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_clean_saved_args();
+	return -1;
 }
 
 static int
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 14547d5ac9..cd9a72a0fc 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -174,14 +174,14 @@ rte_eal_init(int argc, char **argv)
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	/* setup log as early as possible */
 	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	eal_log_init(NULL);
@@ -189,31 +189,31 @@ rte_eal_init(int argc, char **argv)
 	if (eal_create_cpu_map() < 0) {
 		rte_eal_init_alert("Cannot discover CPU and NUMA.");
 		/* rte_errno is set */
-		return -1;
+		goto err_out;
 	}
 
 	/* verify if DPDK supported on architecture MMU */
 	if (!eal_mmu_supported()) {
 		rte_eal_init_alert("Unsupported MMU type.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_parse_args() < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_option_device_parse()) {
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	/* Prevent creation of shared memory files. */
@@ -227,7 +227,7 @@ rte_eal_init(int argc, char **argv)
 	if (!internal_conf->no_hugetlbfs && (eal_hugepage_info_init() < 0)) {
 		rte_eal_init_alert("Cannot get hugepage information");
 		rte_errno = EACCES;
-		return -1;
+		goto err_out;
 	}
 
 	if (internal_conf->memory == 0 && !internal_conf->force_numa) {
@@ -237,26 +237,26 @@ rte_eal_init(int argc, char **argv)
 
 	if (rte_eal_intr_init() < 0) {
 		rte_eal_init_alert("Cannot init interrupt-handling thread");
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_timer_init() < 0) {
 		rte_eal_init_alert("Cannot init TSC timer");
 		rte_errno = EFAULT;
-		return -1;
+		goto err_out;
 	}
 
 	bscan = rte_bus_scan();
 	if (bscan < 0) {
 		rte_eal_init_alert("Cannot scan the buses");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	if (eal_mem_win32api_init() < 0) {
 		rte_eal_init_alert("Cannot access Win32 memory management");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	has_phys_addr = true;
@@ -289,13 +289,13 @@ rte_eal_init(int argc, char **argv)
 	if (iova_mode == RTE_IOVA_PA && !has_phys_addr) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' since physical addresses are not available");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	if (iova_mode == RTE_IOVA_PA && !RTE_IOVA_IN_MBUF) {
 		rte_eal_init_alert("Cannot use IOVA as 'PA' as it is disabled during build");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 
 	EAL_LOG(DEBUG, "Selected IOVA mode '%s'",
@@ -305,7 +305,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -314,14 +314,14 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init memory");
 		rte_errno = ENOMEM;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_malloc_heap_init() < 0) {
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_unlock();
@@ -329,13 +329,13 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_malloc_heap_populate() < 0) {
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_eal_tailqs_init() < 0) {
 		rte_eal_init_alert("Cannot init tail queues for objects");
 		rte_errno = EFAULT;
-		return -1;
+		goto err_out;
 	}
 
 	eal_rand_init();
@@ -344,7 +344,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -390,13 +390,13 @@ rte_eal_init(int argc, char **argv)
 	if (ret) {
 		rte_eal_init_alert("rte_service_init() failed");
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	if (rte_bus_probe()) {
 		rte_eal_init_alert("Cannot probe devices");
 		rte_errno = ENOTSUP;
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -409,6 +409,9 @@ rte_eal_init(int argc, char **argv)
 	eal_mcfg_complete();
 
 	return fctret;
+err_out:
+	eal_clean_saved_args();
+	return -1;
 }
 
 /* Don't use MinGW asprintf() to have identical code with all toolchains. */
-- 
2.48.1

