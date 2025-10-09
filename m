Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04052CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62CA240A84;
	Thu,  9 Oct 2025 15:01:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 89FE2406BB
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014884; x=1791550884;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ablFsNZndxii9a5B/pxb33/AQ6fFMGULx5pvH4UM9IE=;
 b=Z7kIjDjAz9rntx8PQt6UnRsKZc6O+HTJKzA7MjT/zW1Uq5rDlZAWntE0
 ehHlcpcWmysfIKve5Zluj8xDpT+Fd8BGKpwg3M+ViGLwX4BD0u1zGFp/i
 UhTJZYFJkRr7GFoSahKAMXyCOwLCgL4iYb6aSEz8kPS3o3h34lL6dhcJM
 PSOmDpqq7rWNTm7gV0EkEd7DazQNJ4PPd6P+cVvhvZ+nIhnxodU4Q2NiN
 GWkHcpOQMlRZUVEWgJhFD+fVmWfzrgJ9qZylNGD5V1ZiLV3H119GJKH79
 GIAeQqvJGmfhdtZvCnRMIcrzxDnvpv5RJJkX75VCNegemQr+EjXIYMb1H A==;
X-CSE-ConnectionGUID: Q5HvCM7wSzmm3FVdV/59rg==
X-CSE-MsgGUID: Jp1rONzSRbGxKkbwuQbr+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663119"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:24 -0700
X-CSE-ConnectionGUID: TV6GQcCEThKf3FZzDYd4Rw==
X-CSE-MsgGUID: 4LC5x85KRM26ij3N+2IbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951631"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 12/21] eal: ensure proper cleanup on EAL init failure
Date: Thu,  9 Oct 2025 14:00:47 +0100
Message-ID: <20251009130056.2630343-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c | 37 ++++++++----
 lib/eal/common/eal_options.h        |  1 +
 lib/eal/freebsd/eal.c               | 83 +++++++++++++-------------
 lib/eal/linux/eal.c                 | 90 ++++++++++++++---------------
 lib/eal/windows/eal.c               | 47 ++++++++-------
 5 files changed, 137 insertions(+), 121 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 569ca5623d..b6f19f0536 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -280,6 +280,8 @@ rte_set_application_usage_hook(rte_usage_hook_t usage_func)
 
 int
 eal_save_args(__rte_unused int argc, __rte_unused char **argv) { return 0; }
+void
+eal_clean_saved_args(void) { /* no-op */ }
 
 #else /* RTE_EXEC_ENV_WINDOWS */
 static char **eal_args;
@@ -311,6 +313,28 @@ handle_eal_info_request(const char *cmd, const char *params __rte_unused,
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
@@ -355,18 +379,7 @@ eal_save_args(int argc, char **argv)
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
index c6d1298d69..6215245ad5 100644
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
@@ -566,13 +562,13 @@ rte_eal_init(int argc, char **argv)
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
@@ -587,8 +583,7 @@ rte_eal_init(int argc, char **argv)
 		if (ret < 0) {
 			rte_eal_init_alert("Cannot get hugepage information.");
 			rte_errno = EACCES;
-			rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-			return -1;
+			goto err_out;
 		}
 	}
 
@@ -617,7 +612,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -626,14 +621,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -641,19 +636,19 @@ rte_eal_init(int argc, char **argv)
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
@@ -664,7 +659,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -717,14 +712,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -733,7 +728,7 @@ rte_eal_init(int argc, char **argv)
 	ret = rte_service_start_with_defaults();
 	if (ret < 0 && ret != -ENOTSUP) {
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -748,18 +743,22 @@ rte_eal_init(int argc, char **argv)
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
index a13ee23db4..9fd426f214 100644
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
@@ -730,13 +727,13 @@ rte_eal_init(int argc, char **argv)
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
@@ -750,8 +747,7 @@ rte_eal_init(int argc, char **argv)
 		if (ret < 0) {
 			rte_eal_init_alert("Cannot get hugepage information.");
 			rte_errno = EACCES;
-			rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-			return -1;
+			goto err_out;
 		}
 	}
 
@@ -774,8 +770,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_vfio_enable("vfio")) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
-		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
-		return -1;
+		goto err_out;
 	}
 	/* in secondary processes, memory init may allocate additional fbarrays
 	 * not present in primary processes, so to avoid any potential issues,
@@ -784,7 +779,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -793,7 +788,7 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init memory");
 		rte_errno = ENOMEM;
-		return -1;
+		goto err_out;
 	}
 
 	/* the directories are locked during eal_hugepage_info_init */
@@ -803,7 +798,7 @@ rte_eal_init(int argc, char **argv)
 		rte_mcfg_mem_read_unlock();
 		rte_eal_init_alert("Cannot init malloc heap");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_unlock();
@@ -811,25 +806,25 @@ rte_eal_init(int argc, char **argv)
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
@@ -840,7 +835,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -891,14 +886,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -907,7 +902,7 @@ rte_eal_init(int argc, char **argv)
 	ret = rte_service_start_with_defaults();
 	if (ret < 0 && ret != -ENOTSUP) {
 		rte_errno = -ret;
-		return -1;
+		goto err_out;
 	}
 
 	/*
@@ -922,18 +917,23 @@ rte_eal_init(int argc, char **argv)
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
index 3d65c405cc..21fe7cb1d9 100644
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
@@ -292,13 +292,13 @@ rte_eal_init(int argc, char **argv)
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
@@ -308,7 +308,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_memzone_init() < 0) {
 		rte_eal_init_alert("Cannot init memzone");
 		rte_errno = ENODEV;
-		return -1;
+		goto err_out;
 	}
 
 	rte_mcfg_mem_read_lock();
@@ -317,14 +317,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -332,13 +332,13 @@ rte_eal_init(int argc, char **argv)
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
@@ -347,7 +347,7 @@ rte_eal_init(int argc, char **argv)
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
-		return -1;
+		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
 		&lcore_config[config->main_lcore].cpuset);
@@ -393,13 +393,13 @@ rte_eal_init(int argc, char **argv)
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
@@ -412,6 +412,9 @@ rte_eal_init(int argc, char **argv)
 	eal_mcfg_complete();
 
 	return fctret;
+err_out:
+	eal_clean_saved_args();
+	return -1;
 }
 
 /* Don't use MinGW asprintf() to have identical code with all toolchains. */
-- 
2.48.1

