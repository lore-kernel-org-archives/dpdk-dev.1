Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8EC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 148DE40E0C;
	Mon, 14 Sep 2026 07:50:32 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4851340E0F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:30 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1631276a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365029;
 x=1789969829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=btFA2s8zn9nj/0YbngYb/J2FhvWr7D4jxTvfBLyWj5XeyGXdrrbeMleb8ymNCfHox+
 a3/P39tTKVxcFOAuZd6izmOTZsVH9kMWTRcNXk538JkFzPB4OdFC1TDHGK6YAObwzwUC
 5h8U4qr+LyeYJS7D7ABaB1nTawdfyMI/Ew8iiATnyZjA7TXQWX3Wclz5/tg55EF+KIOP
 Tk0Bl3iAnv77YJQ2P2ax41Gz1yypX2zg4IW3KyDpLPZ38cSev+/q/pcjYpa0Z2ajqtAl
 TID+qfppP/Ll6VILgvEKfmdV3ylWCRvKOtznYttGYuK77HlYTWnrNO8gVbsvgkFkD9GR
 SMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365029; x=1789969829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=heDAr5IPZ3OAQFv19uUBTk0VKhIx3o5/18fOY/D49MlywkFLQOh8vzpbJe1IbAXhs+
 dQU8L2PfD+EElHF0R6khe36CHjV8PLiowxPmgxuzbc6VA6W/uI+pGaGYa2CGth/mNBCB
 n0LCW5ojVrt24hQdZrGCb+RSrHqKl1fpGJbVLl/k3wV4/tIZPuOUlDZJvQuXsnp+dQc9
 GRRKB0k3VjAirvmD9gDa+Xfdc/U1ws7ZFfR21y1yCKTSyPuZ7wspQxYifu2wk+XsB6EZ
 bT5p+NBDkkxaDrNDXCMGq0vbL3O1f9g+y5yaB5N/113CFfpyrBzELxLLSeOG7kCRzbtz
 QIrA==
X-Gm-Message-State: AFuF++kTDhmPSd89JdkYXsTV4/fY6xCwuzFTNkK026omYsCA4nUvsuFL
 J1UJDo7iuA3bA0K0GOCO2iww5dRj4zAO2c0qZEEBYT3DIi01lR/HbnQyUaX0RMEK/h8Zj8f1T6z
 YQ39Tank=
X-Gm-Gg: AYBFou0r6nWW3DpkK13g44zGPCaK/3zwY9uJ31Vl7Lf+Nt23R+1xQaRiswWPFB0n3Ej
 3wV2TaQVJwP8NGIOZeWNAHtIM74ydW9fXuZ4WcOFu/8t5eoTT+Nkv/tQ3D0BysVtQliN6OePmfd
 GVQsA75CIuVaEbef7kUzhKtT9KXfYYIZfFvQxKpd6OFMQLfVPhkwAB3V+vPFGDndaQXATV6x3P8
 QWiR7f4mGxzOmGwo3RuOJW/eIdfwP6wCfKXWmyYPQ/nBlPyWCXAzaR3X9dt9AR/P5efS6Z1IKYX
 qh9lxUgbf7WgvG0T533A8K8E/1vtDVlYKGuCKEBLJBVInihX3vE5zTH8EG479xQTs6mfbN/hVAg
 s+7VSX26e4gFyiSIvnNjHSW21eP6zvog5xtoUSw38FXoGoEMTmzQGRvLneN338nB0p/6E07w6wn
 cMQ/MdP1JpkndEcWC9qq04v+94BjBeguril16gc6v+mEUB0iVf2RbaBtAudzyetDC1q8snpcLRY
 kTgqUFwMYva+oTBGl4MFMwzC/dYJzQHv7nNkw==
X-Received: by 2002:a17:90a:d2cf:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39dec1426bamr2918006a91.22.1789365029425; 
 Sun, 13 Sep 2026 22:50:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 21/62] net/bonding: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:52 -0700
Message-ID: <20260914054912.755403-22-stephen@networkplumber.org>
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

The mode, socket id and time_ms parsers all assign the strtol() result
before checking the end pointer and errno, and the mode parser truncates
into a uint8_t so "mode=257" aliases onto mode 1.

parse_port_id() has the same unchecked pattern, and did not bound the
result before using it, relying on rte_eth_dev_is_valid_port() to catch
out of range values.

The socket id parser cast to int8_t when testing for SOCKET_ID_ANY, so
any value whose low byte is 0xff, such as 255 or -257, was accepted as
SOCKET_ID_ANY.

Drop the stray errno reset in the agg mode parser, which only does
string comparisons.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_private.h  |  8 ---
 drivers/net/bonding/rte_eth_bond_args.c | 71 ++++---------------------
 drivers/net/bonding/rte_eth_bond_pmd.c  |  8 +--
 3 files changed, 14 insertions(+), 73 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..9a2fb7167e 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -298,10 +298,6 @@ int
 bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args);
 
-int
-bond_ethdev_parse_socket_id_kvarg(const char *key,
-		const char *value, void *extra_args);
-
 int
 bond_ethdev_parse_primary_member_port_id_kvarg(const char *key,
 		const char *value, void *extra_args);
@@ -314,10 +310,6 @@ int
 bond_ethdev_parse_bond_mac_addr_kvarg(const char *key,
 		const char *value, void *extra_args);
 
-int
-bond_ethdev_parse_time_ms_kvarg(const char *key,
-		const char *value, void *extra_args);
-
 void
 bond_tlb_disable(struct bond_dev_private *internals);
 
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index 823ed80f07..25602b3b47 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -91,13 +91,13 @@ parse_port_id(const char *port_str)
 		/* try parsing as device name, virtual devices */
 		port_id = find_port_id_by_dev_name(port_str);
 		if (port_id < 0) {
-			char *end;
-			errno = 0;
+			uint64_t val;
 
 			/* try parsing as port id */
-			port_id = strtol(port_str, &end, 10);
-			if (*end != 0 || errno != 0)
+			if (rte_kvargs_to_uint(port_str, 0, RTE_MAX_ETHPORTS - 1, &val) < 0)
 				return -1;
+
+			port_id = val;
 		}
 	}
 
@@ -136,19 +136,17 @@ int
 bond_ethdev_parse_member_mode_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	uint8_t *mode;
-	char *endptr;
+	uint8_t *mode = extra_args;
+	uint64_t val;
 
-	if (value == NULL || extra_args == NULL)
+	if (extra_args == NULL)
 		return -1;
 
-	mode = extra_args;
-
-	errno = 0;
-	*mode = strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
+	if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0)
 		return -1;
 
+	*mode = val;
+
 	/* validate mode value */
 	switch (*mode) {
 	case BONDING_MODE_ROUND_ROBIN:
@@ -176,7 +174,6 @@ bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 
 	agg_mode = extra_args;
 
-	errno = 0;
 	if (strncmp(value, "stable", 6) == 0)
 		*agg_mode = AGG_STABLE;
 
@@ -197,35 +194,6 @@ bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 	}
 }
 
-int
-bond_ethdev_parse_socket_id_kvarg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	long socket_id;
-	char *endptr;
-
-	if (value == NULL || extra_args == NULL)
-		return -1;
-
-	errno = 0;
-	socket_id = strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
-		return -1;
-
-	/* SOCKET_ID_ANY also consider a valid socket id */
-	if ((int8_t)socket_id == SOCKET_ID_ANY) {
-		*(int *)extra_args = SOCKET_ID_ANY;
-		return 0;
-	}
-
-	/* validate socket id value */
-	if (socket_id >= 0 && socket_id < RTE_MAX_NUMA_NODES) {
-		*(int *)extra_args = (int)socket_id;
-		return 0;
-	}
-	return -1;
-}
-
 int
 bond_ethdev_parse_primary_member_port_id_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args)
@@ -278,22 +246,3 @@ bond_ethdev_parse_bond_mac_addr_kvarg(const char *key __rte_unused,
 	return rte_ether_unformat_addr(value, extra_args);
 }
 
-int
-bond_ethdev_parse_time_ms_kvarg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	uint32_t time_ms;
-	char *endptr;
-
-	if (value == NULL || extra_args == NULL)
-		return -1;
-
-	errno = 0;
-	time_ms = (uint32_t)strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
-		return -1;
-
-	*(uint32_t *)extra_args = time_ms;
-
-	return 0;
-}
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..766dfd9459 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3869,7 +3869,7 @@ bond_probe(struct rte_vdev_device *dev)
 	arg_count = rte_kvargs_count(kvlist, PMD_BOND_SOCKET_ID_KVARG);
 	if (arg_count == 1) {
 		if (rte_kvargs_process(kvlist, PMD_BOND_SOCKET_ID_KVARG,
-				&bond_ethdev_parse_socket_id_kvarg, &socket_id)
+				rte_kvargs_handle_socket_id, &socket_id)
 				!= 0) {
 			RTE_BOND_LOG(ERR, "Invalid socket Id specified for "
 					"bonding device %s", name);
@@ -4207,7 +4207,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LSC_POLL_PERIOD_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &lsc_poll_interval_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid lsc polling interval value specified for bonding"
@@ -4236,7 +4236,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LINK_UP_PROP_DELAY_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &link_up_delay_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid link up propagation delay value specified for"
@@ -4266,7 +4266,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LINK_DOWN_PROP_DELAY_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &link_down_delay_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid link down propagation delay value specified for"
-- 
2.53.0

