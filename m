Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E47C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4933B40E22;
	Mon, 14 Sep 2026 07:50:43 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 7989540696
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:42 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2713174a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365041;
 x=1789969841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rS7IdVshl8LC/yEU6oSnzh6f/eAIG+WKelue1XGc3XI=;
 b=gs2S8HR+iSQ4RMv0R3tPBsy3IGa0sLS1KqFl9t76Hu8wuEdIeY8fJvOEChiEyOX+q6
 sHY/ZILTzUN2uwwkH2JfuPVkZPGCcncxtxV8iltT/4sLA/+iSybZa2ur7r4NhrjU9xrX
 ILXggMhbIe+WAp1s9TRPB1+oNfdC2eNIBw9Fzd1fK6RTpnwAT13U7C4JW+qDe02Zzxo/
 dg5QEGD85m226qdQmqGdwqJFOlklHGZ+/xSTiENu58qApOI61/SWKeRo6mryiGGAlc0g
 inwS8QsDOj1jCElsVMud1MG2CS464OqCiAn9US2wtECpYuSyGIbWwkbwPjpWq0rSMs62
 hdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365041; x=1789969841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rS7IdVshl8LC/yEU6oSnzh6f/eAIG+WKelue1XGc3XI=;
 b=tKmDgDuQXS88hcNrQqv/66K/JBuqS5lXAjOHl6zl5gXx+hb2TkQHkP86qM9ctRkxiT
 phgWLFry527JttpT6Tb3hmuSylCfSqX1YAfGiYRL98rdVN+X2FU7fmSUFZGa8/NwUDnk
 5iSoBayxqvksRNE5+hu3GEwxWGvVLuchUXSsA38EvLum/rsjgH0MxAIzpppZ/T6me0Km
 zd/OsnK9TyCnoN2PRVmMNgwlpy5gqk8y0NfR7UsIZbsCjriQ20LakrU716SGeYYraSCJ
 lGx03MuUQUC6I+hYsY500VcU8Pml7XVCLgjWr0C4oMAFmT4TlsWkP/ZBce1laNYhs2lU
 aZIA==
X-Gm-Message-State: AFuF++nLZUs+n3lS/EmNzjO2oR7k2f+iW+nlXxJ8KxPLcz0VLhsyMBHR
 0y6qKuB4YoiM6wD9sz84CP8tATL/oiQIzIVxBa1PPuBFm0GfXSdFtP1evXASGb7XkPbs0xDw0kK
 NoZZj7Z4=
X-Gm-Gg: AYBFou2/tirlblWahB4SnkROxaYzX48wmOQGoQ2S/rRzxO4KrVFbuyu81N7GZjKnjdt
 KuHptSz2y3va2p4tydQmX8JdB6vOpkgYXscBB25CB1szVwrO8usL0p4ZlNClHLb4tuxzCI07V5E
 IdiN9JVT3UB4QXhFT1Wn0fGrgUXm/dIce9+gnjivtFH3NJmPjtsmqlqLJ8cKUN6xuJ4SG0mHrMZ
 6Ds2EiMhZkJlMu1yWZ4z2vfHcOgxRlqlAOArKdfWlVohKC/huYoIkKoSrLLnKFoPlVRpYxRUTca
 NOjTSU3VPAm0SZeEGtHeX9dh9xU/71nMwBznZXPzKQBk381QS2TOynmq8vWEMy9weje9pAyqwEv
 Ssn0/oZgxverZhz1if4lwHOmFAggbOH4f9azVBGV0fGlGPUFyhbaSTSRhg8l09awHcevx7i0xQL
 NVybLs7BUUaHtaOVAsLrvDO8jnHJ4oUFGunD/scmkrgxRfzDKMtmBHBUdNm7bno2a5NkyHayi9l
 TBJ8dTFAiT8A2VciGAD+PZbhOXHeJ4rtHxTvA==
X-Received: by 2002:a17:90b:582e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39dec08daf1mr2466317a91.16.1789365041520; 
 Sun, 13 Sep 2026 22:50:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ke Zhang <ke1x.zhang@intel.com>,
 Kevin Liu <kevinx.liu@intel.com>
Subject: [PATCH 24/62] net/ice: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:55 -0700
Message-ID: <20260914054912.755403-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

parse_u32() open codes the errno, end pointer and range checks that the
helper does.

parse_tx_sched_levels() assigns before validating and uses base 0, so a
leading zero silently selects octal.

handle_field_offs_arg() converts with atoi(), which reports no error,
and stores the result through a uint8_t pointer while the caller passes
&xtr_field_offs, which is an int. Only one byte of a four byte field
was written. Convert with rte_kvargs_to_int() and store through an int
pointer instead. The range starts at zero, which keeps the old isdigit()
rejection of a negative value: -1 is used internally to mean that no
extraction field is configured.

The debug_mask parser is converted separately, later in this series,
since it needs the hexadecimal handler rather than a decimal one.

parse_bool() stored an int through the pointer it was given, but three
of its five callers pass the address of a uint8_t field in struct
ice_devargs: default_mac_disable, ddp_load_sched and source_prune.
Each of those parsed four bytes over a one byte field and corrupted
whatever followed it. default_mac_disable is the worst of the three,
since it is immediately followed by proto_xtr[ICE_MAX_QUEUE_NUM], which
ice_parse_devargs() has just initialized when the argument is parsed.

All five arguments are booleans, so make the fields bool and use
rte_kvargs_handle_bool(), which removes the mismatch along with the
hand written parser. A bare key such as "safe-mode-support" now enables
the option, and the usual spellings are accepted.

Bugzilla ID: 2037
Bugzilla ID: 2038
Fixes: 66214b547c65 ("net/ice: add option to disable default MAC")
Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_ethdev.c | 102 +++++++++--------------------
 drivers/net/intel/ice/ice_ethdev.h |  10 +--
 2 files changed, 36 insertions(+), 76 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..af859f2174 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -8,6 +8,7 @@
 
 #include <ctype.h>
 #include <fcntl.h>
+#include <limits.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -15,6 +16,7 @@
 #include <math.h>
 
 #include <rte_tailq.h>
+#include <rte_kvargs.h>
 #include <rte_os_shim.h>
 
 #include "eal_firmware.h"
@@ -732,18 +734,20 @@ handle_proto_xtr_arg(__rte_unused const char *key, const char *value,
 }
 
 static int
-handle_field_offs_arg(__rte_unused const char *key, const char *value,
-				void *offs_args)
+handle_field_offs_arg(const char *key, const char *value, void *offs_args)
 {
-	uint8_t *offset = offs_args;
+	int64_t offset;
 
-	if (value == NULL || offs_args == NULL)
+	if (offs_args == NULL)
 		return -EINVAL;
 
-	if (!isdigit(*value))
-		return -1;
+	/* A negative offset is reserved: -1 means no field is configured. */
+	if (rte_kvargs_to_int(value, 0, INT_MAX, &offset) < 0) {
+		PMD_DRV_LOG(ERR, "Invalid %s, must be a positive offset", key);
+		return -EINVAL;
+	}
 
-	*offset = atoi(value);
+	*(int *)offs_args = offset;
 
 	return 0;
 }
@@ -1083,7 +1087,7 @@ ice_init_mac_address(struct rte_eth_dev *dev)
 		return -ENOMEM;
 	}
 	/* store it to dev data */
-	if (ad->devargs.default_mac_disable != 1)
+	if (!ad->devargs.default_mac_disable)
 		rte_ether_addr_copy((struct rte_ether_addr *)hw->port_info[0].mac.perm_addr,
 			&dev->data->mac_addrs[0]);
 	return 0;
@@ -1113,7 +1117,7 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
 	int ret = 0;
 
-	if (ad->devargs.default_mac_disable == 1 && rte_is_same_ether_addr(mac_addr,
+	if (ad->devargs.default_mac_disable && rte_is_same_ether_addr(mac_addr,
 			(struct rte_ether_addr *)hw->port_info[0].mac.perm_addr)) {
 		PMD_DRV_LOG(ERR, "This Default MAC filter is disabled.");
 		return 0;
@@ -1763,7 +1767,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
 		/* Source Prune */
-		if (ad->devargs.source_prune != 1) {
+		if (!ad->devargs.source_prune) {
 			/* Disable source prune to support VRRP
 			 * when source-prune devarg is not set
 			 */
@@ -2136,25 +2140,6 @@ ice_base_queue_get(struct ice_pf *pf)
 	}
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	int *i = args;
-
-	if (value == NULL || value[0] == '\0') {
-		PMD_DRV_LOG(WARNING, "key:\"%s\", requires a value, which must be 0 or 1", key);
-		return -1;
-	}
-	if (value[1] != '\0' || (value[0] != '0' && value[0] != '1')) {
-		PMD_DRV_LOG(WARNING, "invalid value:\"%s\" for key:\"%s\", value must be 0 or 1",
-			value, key);
-		return -1;
-	}
-
-	*i = (value[0] == '1');
-	return 0;
-}
-
 static int
 parse_u64(const char *key, const char *value, void *args)
 {
@@ -2174,45 +2159,19 @@ parse_u64(const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_u32(const char *key, const char *value, void *args)
-{
-	uint32_t *num = args;
-	unsigned long tmp;
-	char *endptr;
-
-	errno = 0;
-	tmp = strtoul(value, &endptr, 0);
-	if (errno != 0 || endptr == value || *endptr != '\0') {
-		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u32", key, value);
-		return -1;
-	}
-	if (tmp > UINT32_MAX) {
-		PMD_DRV_LOG(WARNING, "%s: value \"%s\" is out of range", key, value);
-		return -1;
-	}
-
-	*num = (uint32_t)tmp;
-
-	return 0;
-}
-
 static int
 parse_tx_sched_levels(const char *key, const char *value, void *args)
 {
 	uint8_t *num = args;
-	long tmp;
-	char *endptr;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = strtol(value, &endptr, 0);
 	/* the value needs two stage validation, since the actual number of available
 	 * levels is not known at this point. Initially just validate that it is in
 	 * the correct range, between 3 and 8. Later validation will check that the
 	 * available layers on a particular port is higher than the value specified here.
 	 */
-	if (errno || *endptr != '\0' ||
-			tmp < (ICE_VSI_LAYER_OFFSET - 1) || tmp >= ICE_TM_MAX_LAYERS) {
+	if (rte_kvargs_to_uint(value, ICE_VSI_LAYER_OFFSET - 1,
+			       ICE_TM_MAX_LAYERS - 1, &tmp) < 0) {
 		PMD_DRV_LOG(WARNING, "%s: Invalid value \"%s\", should be in range [%d, %d]",
 			    key, value, ICE_VSI_LAYER_OFFSET - 1, ICE_TM_MAX_LAYERS - 1);
 		return -1;
@@ -2453,13 +2412,13 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_SAFE_MODE_SUPPORT_ARG,
-				 &parse_bool, &ad->devargs.safe_mode_support);
+	ret = rte_kvargs_process_opt(kvlist, ICE_SAFE_MODE_SUPPORT_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.safe_mode_support);
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_DEFAULT_MAC_DISABLE,
-				&parse_bool, &ad->devargs.default_mac_disable);
+	ret = rte_kvargs_process_opt(kvlist, ICE_DEFAULT_MAC_DISABLE,
+				rte_kvargs_handle_bool, &ad->devargs.default_mac_disable);
 	if (ret)
 		goto bail;
 
@@ -2478,8 +2437,8 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_RX_LOW_LATENCY_ARG,
-				 &parse_bool, &ad->devargs.rx_low_latency);
+	ret = rte_kvargs_process_opt(kvlist, ICE_RX_LOW_LATENCY_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.rx_low_latency);
 	if (ret)
 		goto bail;
 
@@ -2488,8 +2447,8 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_DDP_LOAD_SCHED_ARG,
-				 &parse_bool, &ad->devargs.ddp_load_sched);
+	ret = rte_kvargs_process_opt(kvlist, ICE_DDP_LOAD_SCHED_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.ddp_load_sched);
 	if (ret)
 		goto bail;
 
@@ -2499,12 +2458,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 		goto bail;
 
 	ret = rte_kvargs_process(kvlist, ICE_RL_BURST_SIZE_ARG,
-				 &parse_u32, &ad->devargs.rl_burst_size);
+				 rte_kvargs_handle_u32, &ad->devargs.rl_burst_size);
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_SOURCE_PRUNE_ARG,
-				 &parse_bool, &ad->devargs.source_prune);
+	ret = rte_kvargs_process_opt(kvlist, ICE_SOURCE_PRUNE_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.source_prune);
 	if (ret)
 		goto bail;
 
@@ -2758,7 +2717,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	}
 
 	if (ret) {
-		if (ad->devargs.safe_mode_support == 0) {
+		if (!ad->devargs.safe_mode_support) {
 			PMD_INIT_LOG(ERR, "Failed to load the DDP package,"
 					"Use safe-mode-support=1 to enter Safe Mode");
 			goto err_init_fw;
@@ -4211,7 +4170,8 @@ __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 {
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	uint32_t val, val_tx;
-	int rx_low_latency, i;
+	bool rx_low_latency;
+	int i;
 
 	rx_low_latency = vsi->adapter->devargs.rx_low_latency;
 	for (i = 0; i < nb_queue; i++) {
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..3ca820ccb6 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -622,16 +622,16 @@ struct ice_pf {
  * Cache devargs parse result.
  */
 struct ice_devargs {
-	int rx_low_latency;
-	int safe_mode_support;
+	bool rx_low_latency;
+	bool safe_mode_support;
 	uint8_t proto_xtr_dflt;
-	uint8_t default_mac_disable;
+	bool default_mac_disable;
 	uint8_t proto_xtr[ICE_MAX_QUEUE_NUM];
 	uint8_t pin_idx;
 	uint8_t pps_out_ena;
-	uint8_t ddp_load_sched;
+	bool ddp_load_sched;
 	uint8_t tm_exposed_levels;
-	uint8_t source_prune;
+	bool source_prune;
 	uint32_t rl_burst_size;
 	int link_state_on_close;
 	int xtr_field_offs;
-- 
2.53.0

