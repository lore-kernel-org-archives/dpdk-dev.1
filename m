Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A21CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D871542EDD;
	Thu,  1 Oct 2026 00:44:11 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id AB38242EC8
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:09 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4b4770191so1081276a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808249;
 x=1791413049; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xEhPQipE6WkfEDs7UQ7+L4Om3PdAtIx3HyVXJT2X/So=;
 b=USp60KPPJ4ET2AbMZEjxCSGRP9QctJ6t3JA+jQwQRSWdsLa2lqR0h/nE5TqD+EP+MH
 jiaP0v+bzMrViYVw3YStGblGioy52rLxZuJqtqNDaCeyM32bZ8UFyZzJOvif1FC0ZVk6
 4AVO78lcpCuNrJUy3gCCedKfOFqfvLU0Va18aZO2u9RCA3FvdAfkR+TNHzSUnaU0wSyF
 koKrLbrGsesSOsQyTjnvBfk0VQQdPaUq85VRouPbiO8RBOK/K8GYFrve0Mcoi/amr/gI
 wFhFPb6pRCvKJTgMcmwWU0ldaljMKHyjWrvMzzUyw4g/p6GZIU/o28+eJqfFXDfBarxL
 NCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808249; x=1791413049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xEhPQipE6WkfEDs7UQ7+L4Om3PdAtIx3HyVXJT2X/So=;
 b=o4N83gHCsdsII2174IZeeGKdbFXvvhxnUHARbh0FMGX5MA1p4BrKousfRunPop3xs8
 wbUT23q9puCC3cfmwD9MFykrVY6YroSNME9qLx86MV6rm7iBkTRsvVYqPpNwM+azNzeh
 MhRkdqPKILaBT+X9Tj0EIHj48NiPYLpP3PBO8j5fGyDIoDt6FB0aQa8ckCg6QXBzBMZl
 PxEfoFi9+qu7MNXBNDCARl2CDqDrjA80AM7m6zyGEovVzgOUoLBW1TtDFlu8R7VVRG4P
 gVnRiTBRub/CavB39AvK0TMSfDEMYHqC4hHru+UmM5YEL8D5l+f3TxA4f+1mFHRs+dkV
 SBJA==
X-Gm-Message-State: AFq9FYJmCNdMhPD/hhVg0qkZMxDzOQTdn7rj570gKhTLtKTLMHd7NPBQ
 eEMjAsbwD2tOKuyMxaRmekcy1QxumhGnW8QjLXi2x48GKZpKjPs8Tu7UuRpescFKovREcX0me21
 EEEI8OAA=
X-Gm-Gg: AYBFou0mYcDQqM/XeyX1XO0l+UUPOpR/Zc5IgWrxPKNx2brN2P6+A0EpK1XOLX4jG4M
 VPKOQvziiRwXAb/gr6aSEfjiJFXZ1sf0w+58Nj2JWbLCQdXnB7FhMcBRnV5N2ly2/TUUKlGB/3Y
 kSKS9cjaOFjywx1EZK7QBCAayzEUZ/85EUCIfi6fomrIDPNM1L5MezR02A2ACghQSQ8QBlyuTu5
 pJWP9vxq7Tk59ifJ5UQtFujw2HPYEHZJiok6mM+ipC2q6fsyafDSvGDzrNsWyoPwufcTeCcZnaO
 VMRr0pTHsUV9Zqt8gOw19ZD1wDPUE5pIcdLuroFIuVnINdfBIaJLBJh9CJAtiO6bLxlv84ehIa/
 z8RJldi4jeSLiy/LVcYM1lP02CnVpxAodbBkYDlCEBL8Pg1T8jvchJI0IHl759T+rh5owCgdUSA
 3ZNvZ2kJKOAoEA4GSxtKVih2uyTKcdBNCAEKV/KCJj/4sh2YGhW6l1wFXWri6omu3/6KojqbAlH
 raqfFkBkecUkTAPETglcT7V+b+sxfRATscNIaM=
X-Received: by 2002:a17:90a:e7c9:b0:3a4:85c4:68fc with SMTP id
 98e67ed59e1d1-3a4d1545a03mr2556008a91.29.1790808248776; 
 Wed, 30 Sep 2026 15:44:08 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ke Zhang <ke1x.zhang@intel.com>,
 Kevin Liu <kevinx.liu@intel.com>
Subject: [PATCH v3 24/65] net/ice: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:42 -0700
Message-ID: <20260930224340.58580-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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
index dfee07c457..4c3db27812 100644
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
@@ -738,18 +740,20 @@ handle_proto_xtr_arg(__rte_unused const char *key, const char *value,
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
@@ -1089,7 +1093,7 @@ ice_init_mac_address(struct rte_eth_dev *dev)
 		return -ENOMEM;
 	}
 	/* store it to dev data */
-	if (ad->devargs.default_mac_disable != 1)
+	if (!ad->devargs.default_mac_disable)
 		rte_ether_addr_copy((struct rte_ether_addr *)hw->port_info[0].mac.perm_addr,
 			&dev->data->mac_addrs[0]);
 	return 0;
@@ -1119,7 +1123,7 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
 	int ret = 0;
 
-	if (ad->devargs.default_mac_disable == 1 && rte_is_same_ether_addr(mac_addr,
+	if (ad->devargs.default_mac_disable && rte_is_same_ether_addr(mac_addr,
 			(struct rte_ether_addr *)hw->port_info[0].mac.perm_addr)) {
 		PMD_DRV_LOG(ERR, "This Default MAC filter is disabled.");
 		return 0;
@@ -1769,7 +1773,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 		 */
 		vsi_ctx.info.sw_id = hw->port_info->sw_id;
 		/* Source Prune */
-		if (ad->devargs.source_prune != 1) {
+		if (!ad->devargs.source_prune) {
 			/* Disable source prune to support VRRP
 			 * when source-prune devarg is not set
 			 */
@@ -2140,25 +2144,6 @@ ice_base_queue_get(struct ice_pf *pf)
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
@@ -2178,45 +2163,19 @@ parse_u64(const char *key, const char *value, void *args)
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
@@ -2457,13 +2416,13 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
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
 
@@ -2482,8 +2441,8 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_RX_LOW_LATENCY_ARG,
-				 &parse_bool, &ad->devargs.rx_low_latency);
+	ret = rte_kvargs_process_opt(kvlist, ICE_RX_LOW_LATENCY_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.rx_low_latency);
 	if (ret)
 		goto bail;
 
@@ -2492,8 +2451,8 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, ICE_DDP_LOAD_SCHED_ARG,
-				 &parse_bool, &ad->devargs.ddp_load_sched);
+	ret = rte_kvargs_process_opt(kvlist, ICE_DDP_LOAD_SCHED_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.ddp_load_sched);
 	if (ret)
 		goto bail;
 
@@ -2503,12 +2462,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
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
 
@@ -2762,7 +2721,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	}
 
 	if (ret) {
-		if (ad->devargs.safe_mode_support == 0) {
+		if (!ad->devargs.safe_mode_support) {
 			PMD_INIT_LOG(ERR, "Failed to load the DDP package,"
 					"Use safe-mode-support=1 to enter Safe Mode");
 			goto err_init_fw;
@@ -4313,7 +4272,8 @@ __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 {
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	uint32_t val, val_tx;
-	int rx_low_latency, i;
+	bool rx_low_latency;
+	int i;
 
 	rx_low_latency = vsi->adapter->devargs.rx_low_latency;
 	for (i = 0; i < nb_queue; i++) {
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index e39757e842..39583cff38 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -627,16 +627,16 @@ struct ice_pf {
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

