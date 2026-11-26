Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE81606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7oYTKTi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B11A340B92;
	Thu, 26 Nov 2026 19:14:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 07A73406BA
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716874; x=1827252874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PguTt65fU0/Q/I7/qCxyafoWoSLa5nYtRmjjywNeCjk=;
 b=M7oYTKTil3inTGKkUsVCbAgp3hQbX0cE/iWXGhGkHppiEjHn4gMpldPb
 2JwvsRCbNEEHt1S4J2QRste6fXHRbrKIDCk76tLY/SAMcWQ6eXrB9g2dj
 08hPghj/ehjGg4jZn/+vlAojgE2LbsJ6HBaL+/+lgXGI2S45eGS3dWPWL
 6obLXgbOcLXcBc63OxWh9Txkt/sqMcptBNnyxr0OCgUdfrnlldOtcvDBt
 k8zZA1PRRVvUQVZQU2BTATFgVzsVhh2XGV/QQ9DBpsQx9vKSvNrjexqFL
 yGzZoEXCzGHAGYNRUE1Ez6r4haIMgvIzucAEW3akhynEWtpLxXO5bj7Nv w==;
X-CSE-ConnectionGUID: mPJU8gIzR46dyyAjg4DVBA==
X-CSE-MsgGUID: eh2brw25QqSX4rgYdFhp1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633576"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633576"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:33 -0800
X-CSE-ConnectionGUID: PxNCZdXoQam5AUbDewT8Sw==
X-CSE-MsgGUID: vMR/zFdwR/G/2wBdREAo7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732908"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 15/39] eal: store lcore configuration in runtime data
Date: Thu, 26 Nov 2026 18:13:48 +0000
Message-ID: <20261126181414.124094-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the standalone lcore_config array and instead manage the lcore
configuration as part of the runtime state.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_launch.c  | 25 +++++++++------
 lib/eal/common/eal_common_lcore.c   | 49 ++++++++++++++++++-----------
 lib/eal/common/eal_common_options.c | 37 ++++++++++++----------
 lib/eal/common/eal_common_thread.c  | 24 ++++++++------
 lib/eal/common/eal_internal_cfg.h   | 19 +++++++++++
 lib/eal/common/eal_private.h        | 21 -------------
 lib/eal/common/rte_service.c        |  8 ++---
 lib/eal/freebsd/eal.c               | 23 ++++++--------
 lib/eal/linux/eal.c                 | 24 +++++++-------
 lib/eal/unix/eal_unix_thread.c      | 11 ++++---
 lib/eal/windows/eal.c               | 22 ++++++-------
 lib/eal/windows/eal_thread.c        | 11 ++++---
 12 files changed, 147 insertions(+), 127 deletions(-)

diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index a7deac6ecd..a0f2a43b2a 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -20,11 +20,13 @@ RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
 int
 rte_eal_wait_lcore(unsigned worker_id)
 {
-	while (rte_atomic_load_explicit(&lcore_config[worker_id].state,
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
+	while (rte_atomic_load_explicit(&runtime_state->lcore_cfg[worker_id].state,
 			rte_memory_order_acquire) != WAIT)
 		rte_pause();
 
-	return lcore_config[worker_id].ret;
+	return runtime_state->lcore_cfg[worker_id].ret;
 }
 
 /*
@@ -36,21 +38,23 @@ RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
 int
 rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int rc = -EBUSY;
 
 	/* Check if the worker is in 'WAIT' state. Use acquire order
 	 * since 'state' variable is used as the guard variable.
 	 */
-	if (rte_atomic_load_explicit(&lcore_config[worker_id].state,
+	if (rte_atomic_load_explicit(&runtime_state->lcore_cfg[worker_id].state,
 			rte_memory_order_acquire) != WAIT)
 		goto finish;
 
-	lcore_config[worker_id].arg = arg;
+	runtime_state->lcore_cfg[worker_id].arg = arg;
 	/* Ensure that all the memory operations are completed
 	 * before the worker thread starts running the function.
 	 * Use worker thread function as the guard variable.
 	 */
-	rte_atomic_store_explicit(&lcore_config[worker_id].f, f, rte_memory_order_release);
+	rte_atomic_store_explicit(&runtime_state->lcore_cfg[worker_id].f, f,
+			rte_memory_order_release);
 
 	rc = eal_thread_wake_worker(worker_id);
 
@@ -69,12 +73,13 @@ int
 rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 			 enum rte_rmt_call_main_t call_main)
 {
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int lcore_id;
 	int main_lcore = rte_get_main_lcore();
 
 	/* check state of lcores */
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (lcore_config[lcore_id].state != WAIT)
+		if (runtime_state->lcore_cfg[lcore_id].state != WAIT)
 			return -EBUSY;
 	}
 
@@ -84,8 +89,8 @@ rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 	}
 
 	if (call_main == CALL_MAIN) {
-		lcore_config[main_lcore].ret = f(arg);
-		lcore_config[main_lcore].state = WAIT;
+		runtime_state->lcore_cfg[main_lcore].ret = f(arg);
+		runtime_state->lcore_cfg[main_lcore].state = WAIT;
 	}
 
 	return 0;
@@ -98,7 +103,9 @@ RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
 enum rte_lcore_state_t
 rte_eal_get_lcore_state(unsigned lcore_id)
 {
-	return lcore_config[lcore_id].state;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
+	return runtime_state->lcore_cfg[lcore_id].state;
 }
 
 /*
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 1042ffabd9..e207697900 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -36,6 +36,8 @@ unsigned int rte_lcore_count(void)
 RTE_EXPORT_SYMBOL(rte_lcore_index)
 int rte_lcore_index(int lcore_id)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return -1;
 
@@ -46,12 +48,13 @@ int rte_lcore_index(int lcore_id)
 		lcore_id = (int)rte_lcore_id();
 	}
 
-	return lcore_config[lcore_id].core_index;
+	return runtime_state->lcore_cfg[lcore_id].core_index;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	unsigned int cpu;
 
@@ -65,17 +68,18 @@ int rte_lcore_to_cpu_id(int lcore_id)
 		lcore_id = (int)rte_lcore_id();
 	}
 
-	for (cpu = 0; cpu < CPU_SETSIZE && cpu < platform_info->cpu_count; cpu++) {
-		if (CPU_ISSET(cpu, &lcore_config[lcore_id].cpuset))
-			return (int)platform_info->cpu_info[cpu].core_id;
-	}
+	cpu = runtime_state->lcore_cfg[lcore_id].first_cpu;
+	if (cpu < platform_info->cpu_count)
+		return (int)platform_info->cpu_info[cpu].core_id;
 	return -1;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_cpuset)
 rte_cpuset_t rte_lcore_cpuset(unsigned int lcore_id)
 {
-	return lcore_config[lcore_id].cpuset;
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
+	return runtime_state->lcore_cfg[lcore_id].cpuset;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_lcore_role)
@@ -135,10 +139,11 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return (unsigned int)SOCKET_ID_ANY;
 
-	return (unsigned int)eal_cpuset_socket_id(&lcore_config[lcore_id].cpuset);
+	return (unsigned int)eal_cpuset_socket_id(&runtime_state->lcore_cfg[lcore_id].cpuset);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cpu_socket_id, 26.11)
@@ -175,6 +180,7 @@ rte_eal_cpu_init(void)
 	/* pointer to global configuration */
 	struct rte_config *config = rte_eal_get_configuration();
 	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned lcore_id;
 	unsigned count = 0;
 	unsigned int socket_id, prev_socket_id;
@@ -207,14 +213,15 @@ rte_eal_cpu_init(void)
 	 * ones and enable them by default.
 	 */
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		lcore_config[lcore_id].core_index = count;
+		runtime_state->lcore_cfg[lcore_id].core_index = count;
 
 		/* init cpuset for per lcore config */
-		CPU_ZERO(&lcore_config[lcore_id].cpuset);
+		CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
+		runtime_state->lcore_cfg[lcore_id].first_cpu = UINT16_MAX;
 
 		if (eal_cpu_detected(lcore_id) == 0) {
 			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
-			lcore_config[lcore_id].core_index = -1;
+			runtime_state->lcore_cfg[lcore_id].core_index = -1;
 			continue;
 		}
 
@@ -223,14 +230,14 @@ rte_eal_cpu_init(void)
 		lcore_to_socket_id[lcore_id] = socket_id;
 
 		/* By default, lcore 1:1 map to cpu id */
-		CPU_SET(lcore_id, &lcore_config[lcore_id].cpuset);
+		CPU_SET(lcore_id, &runtime_state->lcore_cfg[lcore_id].cpuset);
+		runtime_state->lcore_cfg[lcore_id].first_cpu = lcore_id;
 
 		/* This is the first time we discover the lcores, so the bitset should be zeroed */
 		rte_bitset_set(config->core_indices, count);
 
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
-		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
 				"core %u on NUMA node %u",
 				lcore_id,
@@ -414,6 +421,7 @@ unsigned int
 eal_lcore_non_eal_allocate(void)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback;
 	struct lcore_callback *prev;
 	unsigned int lcore_id;
@@ -430,7 +438,7 @@ eal_lcore_non_eal_allocate(void)
 		if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
 			continue;
 		rte_bitset_set(cfg->core_indices, core_index);
-		lcore_config[lcore_id].core_index = core_index;
+		runtime_state->lcore_cfg[lcore_id].core_index = core_index;
 		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_NON_EAL;
 		cfg->lcore_count++;
 		break;
@@ -452,8 +460,8 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
-		lcore_config[lcore_id].core_index = -1;
+		rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+		runtime_state->lcore_cfg[lcore_id].core_index = -1;
 		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 		cfg->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
@@ -468,6 +476,7 @@ void
 eal_lcore_non_eal_release(unsigned int lcore_id)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
@@ -475,8 +484,8 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	rte_bitset_clear(cfg->core_indices, lcore_config[lcore_id].core_index);
-	lcore_config[lcore_id].core_index = -1;
+	rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+	runtime_state->lcore_cfg[lcore_id].core_index = -1;
 	cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 	cfg->lcore_count--;
 out:
@@ -537,6 +546,7 @@ calc_usage_ratio(const struct rte_lcore_usage *usage)
 static int
 lcore_dump_cb(unsigned int lcore_id, void *arg)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_config *cfg = rte_eal_get_configuration();
 	char *cpuset;
 	struct rte_lcore_usage usage;
@@ -555,7 +565,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 			return -ENOMEM;
 		}
 	}
-	cpuset = eal_cpuset_to_str(&lcore_config[lcore_id].cpuset);
+	cpuset = eal_cpuset_to_str(&runtime_state->lcore_cfg[lcore_id].cpuset);
 	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
 		lcore_role_str(cfg->lcore_role[lcore_id]),
@@ -610,6 +620,7 @@ format_usage_ratio(char *buf, uint16_t size, const struct rte_lcore_usage *usage
 static int
 lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_config *cfg = rte_eal_get_configuration();
 	struct lcore_telemetry_info *info = arg;
 	char ratio_str[RTE_TEL_MAX_STRING_LEN];
@@ -630,7 +641,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 		return -ENOMEM;
 	rte_tel_data_start_array(cpuset, RTE_TEL_INT_VAL);
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
-		if (CPU_ISSET(cpu, &lcore_config[lcore_id].cpuset))
+		if (CPU_ISSET(cpu, &runtime_state->lcore_cfg[lcore_id].cpuset))
 			rte_tel_data_add_array_int(cpuset, cpu);
 	}
 	rte_tel_data_add_dict_container(info->d, "cpuset", cpuset, 0);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 5d11f90a05..fa1d7763c2 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -910,7 +910,7 @@ eal_parse_service_coremask(const char *coremask)
 				if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
 					taken_lcore_count++;
 
-				lcore_config[idx].core_role = RTE_LCORE_ROLE_SERVICE;
+				cfg->lcore_role[idx] = RTE_LCORE_ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -921,8 +921,6 @@ eal_parse_service_coremask(const char *coremask)
 			return -1;
 
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
-	for (; idx < RTE_MAX_LCORE; idx++)
-		lcore_config[idx].core_index = -1;
 
 	if (count == 0)
 		return -1;
@@ -941,6 +939,7 @@ static int
 update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int lcore_id = remap_base;
 	unsigned int count = 0;
 	unsigned int i;
@@ -950,7 +949,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		cfg->lcore_role[i] = RTE_LCORE_ROLE_OFF;
-		lcore_config[i].core_index = -1;
+		runtime_state->lcore_cfg[i].core_index = -1;
 	}
 
 	/* now go through the cpuset */
@@ -979,9 +978,10 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 
 			rte_bitset_set(cfg->core_indices, count);
 			cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
-			lcore_config[lcore_id].core_index = count;
-			CPU_ZERO(&lcore_config[lcore_id].cpuset);
-			CPU_SET(i, &lcore_config[lcore_id].cpuset);
+			runtime_state->lcore_cfg[lcore_id].core_index = count;
+			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
+			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
+			runtime_state->lcore_cfg[lcore_id].first_cpu = i;
 			EAL_LOG(DEBUG, "lcore %u mapped to physical core %u", lcore_id, i);
 			lcore_id++;
 			count++;
@@ -1154,8 +1154,7 @@ eal_parse_service_corelist(const char *corelist)
 					if (cfg->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
 						taken_lcore_count++;
 
-					lcore_config[idx].core_role =
-							RTE_LCORE_ROLE_SERVICE;
+					cfg->lcore_role[idx] = RTE_LCORE_ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1178,7 +1177,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE)
+		if (cfg->lcore_role[i] == RTE_LCORE_ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1207,7 +1206,7 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (lcore_config[cfg->main_lcore].core_role == RTE_LCORE_ROLE_SERVICE) {
+	if (cfg->lcore_role[cfg->main_lcore] == RTE_LCORE_ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
@@ -1379,6 +1378,7 @@ static int
 eal_parse_lcores(const char *lcores)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	rte_cpuset_t lcore_set;
 	unsigned int set_count;
 	unsigned idx = 0;
@@ -1403,8 +1403,9 @@ eal_parse_lcores(const char *lcores)
 	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
 		cfg->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
-		lcore_config[idx].core_index = -1;
-		CPU_ZERO(&lcore_config[idx].cpuset);
+		runtime_state->lcore_cfg[idx].core_index = -1;
+		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
+		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
 	}
 
 	/* Get list of cores */
@@ -1466,7 +1467,7 @@ eal_parse_lcores(const char *lcores)
 
 			if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
 				rte_bitset_set(cfg->core_indices, count);
-				lcore_config[idx].core_index = count;
+				runtime_state->lcore_cfg[idx].core_index = count;
 				cfg->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
 				count++;
 			}
@@ -1478,8 +1479,10 @@ eal_parse_lcores(const char *lcores)
 
 			if (check_cpuset(&cpuset) < 0)
 				goto err;
-			rte_memcpy(&lcore_config[idx].cpuset, &cpuset,
+			rte_memcpy(&runtime_state->lcore_cfg[idx].cpuset, &cpuset,
 				   sizeof(rte_cpuset_t));
+			runtime_state->lcore_cfg[idx].first_cpu =
+					(uint16_t)(RTE_CPU_FFS(&cpuset) - 1);
 		}
 
 		/* some cores from the lcore_set can't be handled by EAL */
@@ -2466,7 +2469,7 @@ compute_ctrl_threads_cpuset(void)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (rte_lcore_has_role(lcore_id, RTE_LCORE_ROLE_OFF))
 			continue;
-		RTE_CPU_OR(cpuset, cpuset, &lcore_config[lcore_id].cpuset);
+		RTE_CPU_OR(cpuset, cpuset, &runtime_state->lcore_cfg[lcore_id].cpuset);
 	}
 	RTE_CPU_NOT(cpuset, cpuset);
 
@@ -2477,7 +2480,7 @@ compute_ctrl_threads_cpuset(void)
 
 	/* if no remaining cpu, use main lcore cpu affinity */
 	if (!CPU_COUNT(cpuset)) {
-		memcpy(cpuset, &lcore_config[rte_get_main_lcore()].cpuset,
+		memcpy(cpuset, &runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset,
 			sizeof(*cpuset));
 	}
 
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index 10e8d84aa7..a2e08242bd 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -69,9 +69,12 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
 	memmove(&RTE_PER_LCORE(_cpuset), cpusetp, sizeof(rte_cpuset_t));
 
 	if (lcore_id != (unsigned)LCORE_ID_ANY) {
-		/* EAL thread: update lcore_config cpuset first then find numa based on that */
-		memmove(&lcore_config[lcore_id].cpuset, cpusetp,
+		struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
+		/* EAL thread: update lcore_runtime cpuset first then find numa based on that */
+		memmove(&runtime_state->lcore_cfg[lcore_id].cpuset, cpusetp,
 			sizeof(rte_cpuset_t));
+		runtime_state->lcore_cfg[lcore_id].first_cpu = (uint16_t)(RTE_CPU_FFS(cpusetp) - 1);
 		RTE_PER_LCORE(_numa_id) = rte_lcore_to_socket_id(lcore_id);
 	} else {
 		/* Non-EAL thread: preserve SOCKET_ID_ANY if cpuset spans NUMA nodes. */
@@ -149,10 +152,11 @@ __rte_noreturn uint32_t
 eal_thread_loop(void *arg)
 {
 	unsigned int lcore_id = (uintptr_t)arg;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	int ret;
 
-	__rte_thread_init(lcore_id, &lcore_config[lcore_id].cpuset);
+	__rte_thread_init(lcore_id, &runtime_state->lcore_cfg[lcore_id].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 	EAL_LOG(DEBUG, "lcore %u is ready (tid=%zx;cpuset=[%s%s])",
@@ -171,7 +175,7 @@ eal_thread_loop(void *arg)
 		/* Set the state to 'RUNNING'. Use release order
 		 * since 'state' variable is used as the guard variable.
 		 */
-		rte_atomic_store_explicit(&lcore_config[lcore_id].state, RUNNING,
+		rte_atomic_store_explicit(&runtime_state->lcore_cfg[lcore_id].state, RUNNING,
 			rte_memory_order_release);
 
 		eal_thread_ack_command();
@@ -181,25 +185,25 @@ eal_thread_loop(void *arg)
 		 * are accessed only after update to 'f' is visible.
 		 * Wait till the update to 'f' is visible to the worker.
 		 */
-		while ((f = rte_atomic_load_explicit(&lcore_config[lcore_id].f,
+		while ((f = rte_atomic_load_explicit(&runtime_state->lcore_cfg[lcore_id].f,
 				rte_memory_order_acquire)) == NULL)
 			rte_pause();
 
 		rte_eal_trace_thread_lcore_running(lcore_id, f);
 
 		/* call the function and store the return value */
-		fct_arg = lcore_config[lcore_id].arg;
+		fct_arg = runtime_state->lcore_cfg[lcore_id].arg;
 		ret = f(fct_arg);
-		lcore_config[lcore_id].ret = ret;
-		lcore_config[lcore_id].f = NULL;
-		lcore_config[lcore_id].arg = NULL;
+		runtime_state->lcore_cfg[lcore_id].ret = ret;
+		runtime_state->lcore_cfg[lcore_id].f = NULL;
+		runtime_state->lcore_cfg[lcore_id].arg = NULL;
 
 		/* Store the state with release order to ensure that
 		 * the memory operations from the worker thread
 		 * are completed before the state is updated.
 		 * Use 'state' as the guard variable.
 		 */
-		rte_atomic_store_explicit(&lcore_config[lcore_id].state, WAIT,
+		rte_atomic_store_explicit(&runtime_state->lcore_cfg[lcore_id].state, WAIT,
 			rte_memory_order_release);
 
 		rte_eal_trace_thread_lcore_stopped(lcore_id);
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 3e04f42594..28388793a1 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 
+#include <rte_stdatomic.h>
 #include "eal_thread.h"
 
 #if defined(RTE_ARCH_ARM)
@@ -120,6 +121,23 @@ struct eal_platform_info {
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
 
+/**
+ * Per-lcore runtime state, owned by EAL.
+ */
+struct lcore_cfg {
+	int core_index;                   /**< relative index, starting from 0 */
+	rte_cpuset_t cpuset;              /**< cpu set which the lcore affinity to */
+	uint16_t first_cpu;               /**< lowest CPU set in cpuset, UINT16_MAX if none */
+	/* Fields for executing code on a remote lcore */
+	rte_thread_t thread_id;          /**< thread identifier */
+	int pipe_main2worker[2];         /**< communication pipe with main */
+	int pipe_worker2main[2];         /**< communication pipe with main */
+	RTE_ATOMIC(lcore_function_t *) volatile f; /**< function to call */
+	void * volatile arg;             /**< argument of function */
+	volatile int ret;                /**< return value of function */
+	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
+};
+
 /**
  * Internal EAL runtime state
  * May be modified at runtime, so access must be protected by locks or atomic types
@@ -131,6 +149,7 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 8e7c30fe08..e146be3adb 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -18,27 +18,6 @@
 
 #include "eal_internal_cfg.h"
 
-/**
- * Structure storing internal configuration (per-lcore)
- */
-struct lcore_config {
-	rte_thread_t thread_id;    /**< thread identifier */
-	int pipe_main2worker[2];   /**< communication pipe with main */
-	int pipe_worker2main[2];   /**< communication pipe with main */
-
-	RTE_ATOMIC(lcore_function_t *) volatile f; /**< function to call */
-	void * volatile arg;       /**< argument of function */
-	volatile int ret;          /**< return value of function */
-
-	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
-	int core_index;            /**< relative index, starting from 0 */
-	uint8_t core_role;         /**< role of core eg: OFF, RTE, SERVICE */
-
-	rte_cpuset_t cpuset;       /**< cpu set which the lcore affinity to */
-};
-
-extern struct lcore_config lcore_config[RTE_MAX_LCORE];
-
 /**
  * The global RTE configuration structure.
  */
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index cb07ce83fe..05bcdbb3dd 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -107,7 +107,7 @@ rte_service_init(void)
 	int i;
 	struct rte_config *cfg = rte_eal_get_configuration();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role == RTE_LCORE_ROLE_SERVICE) {
+		if (cfg->lcore_role[i] == RTE_LCORE_ROLE_SERVICE) {
 			if ((unsigned int)i == cfg->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
@@ -714,9 +714,6 @@ set_lcore_state(uint32_t lcore, int32_t state)
 	struct core_state *cs =	RTE_LCORE_VAR_LCORE(lcore, lcore_states);
 	cfg->lcore_role[lcore] = state;
 
-	/* mark state in process local lcore_config */
-	lcore_config[lcore].core_role = state;
-
 	/* update per-lcore optimized state tracking */
 	cs->is_service_core = (state == RTE_LCORE_ROLE_SERVICE);
 
@@ -1103,6 +1100,7 @@ RTE_EXPORT_SYMBOL(rte_service_dump)
 int32_t
 rte_service_dump(FILE *f, uint32_t id)
 {
+	struct rte_config *cfg = rte_eal_get_configuration();
 	uint32_t i;
 	int print_one = (id != UINT32_MAX);
 
@@ -1125,7 +1123,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (lcore_config[i].core_role != RTE_LCORE_ROLE_SERVICE)
+		if (cfg->lcore_role[i] != RTE_LCORE_ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 95f94239b9..89b43c450d 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -69,9 +69,6 @@ static struct flock wr_lock = {
 		.l_len = RTE_SIZEOF_FIELD(struct rte_mem_config, memsegs),
 };
 
-/* internal configuration (per-core) */
-struct lcore_config lcore_config[RTE_MAX_LCORE];
-
 /* used by rte_rdtsc() */
 RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
 int rte_cycles_vmware_tsc_map;
@@ -407,7 +404,7 @@ rte_eal_init(int argc, char **argv)
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
@@ -655,13 +652,13 @@ rte_eal_init(int argc, char **argv)
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&lcore_config[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
-		&lcore_config[config->main_lcore].cpuset);
+		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 
@@ -675,15 +672,15 @@ rte_eal_init(int argc, char **argv)
 		 * create communication pipes between main thread
 		 * and children
 		 */
-		if (pipe(lcore_config[i].pipe_main2worker) < 0)
+		if (pipe(runtime_state->lcore_cfg[i].pipe_main2worker) < 0)
 			rte_panic("Cannot create pipe\n");
-		if (pipe(lcore_config[i].pipe_worker2main) < 0)
+		if (pipe(runtime_state->lcore_cfg[i].pipe_worker2main) < 0)
 			rte_panic("Cannot create pipe\n");
 
-		lcore_config[i].state = WAIT;
+		runtime_state->lcore_cfg[i].state = WAIT;
 
 		/* create a thread for each lcore */
-		ret = rte_thread_create(&lcore_config[i].thread_id, NULL,
+		ret = rte_thread_create(&runtime_state->lcore_cfg[i].thread_id, NULL,
 				     eal_thread_loop, (void *)(uintptr_t)i);
 		if (ret != 0)
 			rte_panic("Cannot create thread\n");
@@ -693,10 +690,10 @@ rte_eal_init(int argc, char **argv)
 		if (ret >= RTE_THREAD_NAME_SIZE)
 			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
 
-		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
+		rte_thread_set_name(runtime_state->lcore_cfg[i].thread_id, thread_name);
 
-		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-			&lcore_config[i].cpuset);
+		ret = rte_thread_set_affinity_by_id(runtime_state->lcore_cfg[i].thread_id,
+			&runtime_state->lcore_cfg[i].cpuset);
 		if (ret != 0)
 			rte_panic("Cannot set affinity\n");
 	}
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index bfade6d57b..330a245cd7 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -69,9 +69,6 @@ static struct flock wr_lock = {
 		.l_len = RTE_SIZEOF_FIELD(struct rte_mem_config, memsegs),
 };
 
-/* internal configuration (per-core) */
-struct lcore_config lcore_config[RTE_MAX_LCORE];
-
 /* used by rte_rdtsc() */
 RTE_EXPORT_SYMBOL(rte_cycles_vmware_tsc_map)
 int rte_cycles_vmware_tsc_map;
@@ -516,6 +513,7 @@ eal_worker_thread_create(unsigned int lcore_id)
 	size_t stack_size;
 	int ret = -1;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	stack_size = user_cfg->huge_worker_stack_size;
 	if (stack_size != 0) {
@@ -542,7 +540,7 @@ eal_worker_thread_create(unsigned int lcore_id)
 		}
 	}
 
-	if (pthread_create((pthread_t *)&lcore_config[lcore_id].thread_id.opaque_id,
+	if (pthread_create((pthread_t *)&runtime_state->lcore_cfg[lcore_id].thread_id.opaque_id,
 			attrp, eal_worker_thread_loop, (void *)(uintptr_t)lcore_id) == 0)
 		ret = 0;
 
@@ -567,7 +565,7 @@ rte_eal_init(int argc, char **argv)
 	bool phys_addrs;
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -840,13 +838,13 @@ rte_eal_init(int argc, char **argv)
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&lcore_config[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
-		&lcore_config[config->main_lcore].cpuset);
+		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 	EAL_LOG(DEBUG, "Main lcore %u is ready (tid=%zx;cpuset=[%s%s])",
@@ -859,12 +857,12 @@ rte_eal_init(int argc, char **argv)
 		 * create communication pipes between main thread
 		 * and children
 		 */
-		if (pipe(lcore_config[i].pipe_main2worker) < 0)
+		if (pipe(runtime_state->lcore_cfg[i].pipe_main2worker) < 0)
 			rte_panic("Cannot create pipe\n");
-		if (pipe(lcore_config[i].pipe_worker2main) < 0)
+		if (pipe(runtime_state->lcore_cfg[i].pipe_worker2main) < 0)
 			rte_panic("Cannot create pipe\n");
 
-		lcore_config[i].state = WAIT;
+		runtime_state->lcore_cfg[i].state = WAIT;
 
 		/* create a thread for each lcore */
 		ret = eal_worker_thread_create(i);
@@ -876,10 +874,10 @@ rte_eal_init(int argc, char **argv)
 		if (ret >= RTE_THREAD_NAME_SIZE)
 			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
 
-		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
+		rte_thread_set_name(runtime_state->lcore_cfg[i].thread_id, thread_name);
 
-		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-			&lcore_config[i].cpuset);
+		ret = rte_thread_set_affinity_by_id(runtime_state->lcore_cfg[i].thread_id,
+			&runtime_state->lcore_cfg[i].cpuset);
 		if (ret != 0)
 			rte_panic("Cannot set affinity\n");
 	}
diff --git a/lib/eal/unix/eal_unix_thread.c b/lib/eal/unix/eal_unix_thread.c
index ef6cbff0ee..1555078f96 100644
--- a/lib/eal/unix/eal_unix_thread.c
+++ b/lib/eal/unix/eal_unix_thread.c
@@ -12,8 +12,9 @@
 int
 eal_thread_wake_worker(unsigned int worker_id)
 {
-	int m2w = lcore_config[worker_id].pipe_main2worker[1];
-	int w2m = lcore_config[worker_id].pipe_worker2main[0];
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	int m2w = runtime_state->lcore_cfg[worker_id].pipe_main2worker[1];
+	int w2m = runtime_state->lcore_cfg[worker_id].pipe_worker2main[0];
 	char c = 0;
 	int n;
 
@@ -35,11 +36,12 @@ void
 eal_thread_wait_command(void)
 {
 	unsigned int lcore_id = rte_lcore_id();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int m2w;
 	char c;
 	int n;
 
-	m2w = lcore_config[lcore_id].pipe_main2worker[0];
+	m2w = runtime_state->lcore_cfg[lcore_id].pipe_main2worker[0];
 	do {
 		n = read(m2w, &c, 1);
 	} while (n < 0 && errno == EINTR);
@@ -51,11 +53,12 @@ void
 eal_thread_ack_command(void)
 {
 	unsigned int lcore_id = rte_lcore_id();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	char c = 0;
 	int w2m;
 	int n;
 
-	w2m = lcore_config[lcore_id].pipe_worker2main[1];
+	w2m = runtime_state->lcore_cfg[lcore_id].pipe_worker2main[1];
 	do {
 		n = write(w2m, &c, 1);
 	} while (n == 0 || (n < 0 && errno == EINTR));
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index a39b39dc47..2f8f6200ba 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -38,9 +38,6 @@
  */
 static int mem_cfg_fd = -1;
 
-/* internal configuration (per-core) */
-struct lcore_config lcore_config[RTE_MAX_LCORE];
-
 /* Detect if we are a primary or a secondary process */
 enum rte_proc_type_t
 eal_proc_type_detect(void)
@@ -164,6 +161,7 @@ rte_eal_init(int argc, char **argv)
 	int i, fctret, bscan;
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 	int ret;
@@ -353,13 +351,13 @@ rte_eal_init(int argc, char **argv)
 	eal_rand_init();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&lcore_config[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
 	__rte_thread_init(config->main_lcore,
-		&lcore_config[config->main_lcore].cpuset);
+		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 	EAL_LOG(DEBUG, "Main lcore %u is ready (tid=%zx;cpuset=[%s%s])",
@@ -372,17 +370,17 @@ rte_eal_init(int argc, char **argv)
 		 * create communication pipes between main thread
 		 * and children
 		 */
-		if (_pipe(lcore_config[i].pipe_main2worker,
+		if (_pipe(runtime_state->lcore_cfg[i].pipe_main2worker,
 			sizeof(char), _O_BINARY) < 0)
 			rte_panic("Cannot create pipe\n");
-		if (_pipe(lcore_config[i].pipe_worker2main,
+		if (_pipe(runtime_state->lcore_cfg[i].pipe_worker2main,
 			sizeof(char), _O_BINARY) < 0)
 			rte_panic("Cannot create pipe\n");
 
-		lcore_config[i].state = WAIT;
+		runtime_state->lcore_cfg[i].state = WAIT;
 
 		/* create a thread for each lcore */
-		if (rte_thread_create(&lcore_config[i].thread_id, NULL,
+		if (rte_thread_create(&runtime_state->lcore_cfg[i].thread_id, NULL,
 				eal_thread_loop, (void *)(uintptr_t)i) != 0)
 			rte_panic("Cannot create thread\n");
 
@@ -391,10 +389,10 @@ rte_eal_init(int argc, char **argv)
 		if (ret >= RTE_THREAD_NAME_SIZE)
 			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
 
-		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
+		rte_thread_set_name(runtime_state->lcore_cfg[i].thread_id, thread_name);
 
-		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-			&lcore_config[i].cpuset);
+		ret = rte_thread_set_affinity_by_id(runtime_state->lcore_cfg[i].thread_id,
+			&runtime_state->lcore_cfg[i].cpuset);
 		if (ret != 0)
 			EAL_LOG(DEBUG, "Cannot set affinity");
 	}
diff --git a/lib/eal/windows/eal_thread.c b/lib/eal/windows/eal_thread.c
index 3eeb94a589..7dbba48ecb 100644
--- a/lib/eal/windows/eal_thread.c
+++ b/lib/eal/windows/eal_thread.c
@@ -20,8 +20,9 @@
 int
 eal_thread_wake_worker(unsigned int worker_id)
 {
-	int m2w = lcore_config[worker_id].pipe_main2worker[1];
-	int w2m = lcore_config[worker_id].pipe_worker2main[0];
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	int m2w = runtime_state->lcore_cfg[worker_id].pipe_main2worker[1];
+	int w2m = runtime_state->lcore_cfg[worker_id].pipe_worker2main[0];
 	char c = 0;
 	int n;
 
@@ -43,11 +44,12 @@ void
 eal_thread_wait_command(void)
 {
 	unsigned int lcore_id = rte_lcore_id();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int m2w;
 	char c;
 	int n;
 
-	m2w = lcore_config[lcore_id].pipe_main2worker[0];
+	m2w = runtime_state->lcore_cfg[lcore_id].pipe_main2worker[0];
 	do {
 		n = _read(m2w, &c, 1);
 	} while (n < 0 && errno == EINTR);
@@ -59,11 +61,12 @@ void
 eal_thread_ack_command(void)
 {
 	unsigned int lcore_id = rte_lcore_id();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	char c = 0;
 	int w2m;
 	int n;
 
-	w2m = lcore_config[lcore_id].pipe_worker2main[1];
+	w2m = runtime_state->lcore_cfg[lcore_id].pipe_worker2main[1];
 	do {
 		n = _write(w2m, &c, 1);
 	} while (n == 0 || (n < 0 && errno == EINTR));
-- 
2.55.0

