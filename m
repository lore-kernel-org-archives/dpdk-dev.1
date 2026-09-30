Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E9CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAEB842EB9;
	Thu,  1 Oct 2026 00:44:08 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 0194242EC1
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:07 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49b6bb21eso1913849a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808246;
 x=1791413046; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=jxX7pFHWCr5pjpUsqhCOjyh1BwKqyuR6pquxqf2VxtS1LGjw43vxWkvu8Qio4vBAvs
 6sNYz21xoaRj5imkiLyTaVww8ZKFIab9g8Tl0kk7R/QKB3vIlKt2w5GkvjCwVlDi3Nn5
 QU0nTC8j2KnfckTMecYAvCZCqWR99ZhDd3XUr00LjtqzL1wuPpLoEGaBMnwY59M9dtjx
 X0XixrIvE++oa2+wrXb++/Ymlh31GZ324KuR+Phokfxhl9+QWLMDi6qu/dXyRorUutZn
 c6245oPVZkSVve76bSMf+/GXwXU6MnKF2FrNA5VxyOJpISifhX999FVgUCAIqFZSa05q
 0y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808246; x=1791413046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=pBsWZRsBNaNJpfDm+o32bTxkY5sXGIquO6IVbgW4LqrT/TuYjoq4w6zfW1JCE08sWW
 V0K9daluISWbv9CcicgZENZM/4thVUz1J9NP/5p9rBc6mIrpbHh7OO4qPW0TiyRP8eT8
 8q3mf937eyJrhQFNJVGKl5y2nRjEFTLnD9kI5RLnrpzR5VlZLFj7kou5TLqXfoR3clZ6
 SY6/4bKK2FtG14CImqT5D6Y3gsVHGNdH5cQPWN7hnz3wBNQtXs1/Cv83AppzgNnzg3jZ
 mgu7mzomfz4olhS0APJsK27vGjgDYZDljj19ItaMgH5qG20GWvEJIZYDmjCcKCVg5TY0
 U+bw==
X-Gm-Message-State: AFq9FYIks8+TsX8ye+V0F9A4t/suGqr83SfdA8K7ETuIRH/gTYvlJ+lN
 92K+1w0fyZMLWpJH2F/eAjWveqx4yQe5cDA9NItm8TugEiARgLPLvRR7mlMkiD1udRx13P4qUSg
 PRhQX
X-Gm-Gg: AYBFou0jPl5Ar0G5Q84ZUddpcsY92sBfyIVpCPAIdFLMkQYSJP0x8k0XIAEmHnIMKHf
 JSAOFGyyjeG9aNT/tXYAODAepeTwYY+j8P1fI8iEu8quiR08/NVEijdBHBBvfe9MzRyaphsopKc
 rczv46TT0MATRo11GHVSN5er3tbSsKUR05kZepl8C92VeucK4ZHPE/2C3xAu/t3ci60OunYUPAK
 hIgm2JiGkHFuBmh7l8Mlmpbi3Ai4kf2s0sKpGB7HySjPHIBgxruZhGBdRlbo5yNhIZQ1pZ4p+sr
 pjWvmV2GYWQlbPzfJi96NKkUkXhWCKl+o9S2t272euCuiG2wO+q9fkGZ85AroRS8SgIolLipNRh
 J23yjdoJZBmynvLvDXqOWazcUHKNtxMSC4fTCDTFHa7+SM0EURjXrDlQOsSQuuq+c+0Lyx6Kttj
 h3xSZkJvWgVWn7ToLw4XRlSDR/Zp3HNjK8WyBDDqIG8A8OtrIoArQJIsQ/fFqcx5jF0Sm1Nzvns
 u0W/n/WU2Zsg+/kx+5os+GV1HOXu/nZYD/KJWo=
X-Received: by 2002:a17:90b:3ec2:b0:3a0:b40d:827 with SMTP id
 98e67ed59e1d1-3a4d059c0b5mr1794289a91.0.1790808245993; 
 Wed, 30 Sep 2026 15:44:05 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v3 21/65] net/bonding: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:39 -0700
Message-ID: <20260930224340.58580-22-stephen@networkplumber.org>
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

