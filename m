Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA65C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A98CA40A73;
	Mon, 14 Sep 2026 07:51:02 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id C3071406B4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:00 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc149372c14so1783806a12.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365060;
 x=1789969860; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vft2cnUFS6Zk789J8+dFxZEzBNkoy/JQE9WhtP9jaXA=;
 b=O/L3M6iv3aKb3R3XG07Mplo3ur7cgTDeTL487VX/5l9pu8enc2XGKOxq5/d7N25fCm
 w7SZ/Q4Nb3CysLJg9v7YhYrCkd9YAn2HQiB19/c15mL050Tqay21cM11PdJTBmwH6PvC
 MN01tuqfUqltOqmyzbXibskCzZCA0U0GKLnZimvalXSps2k9jnnFvh5MJXrrCZvYMPQE
 nm2rzaK8zDl04fA3bTc+/DioTuu3RYIz7wFYmyU4v7yT9LVs4kZpMfzqfHCjNg2/AwbY
 EMYJXjsfA5yCJHYdN7CggeFdPyAp/Hy7cupWmXIdfbKaGu/h6wWuL3p0tE3iaINeYIYP
 DLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365060; x=1789969860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vft2cnUFS6Zk789J8+dFxZEzBNkoy/JQE9WhtP9jaXA=;
 b=LlyVvuDPe+h7P+bhiseXxPxetfj425e50msl74aVhtRfOK0v9igQmywHrbzfpzn/HU
 bBnO1gxlve74vCQqdTenGzA7fGfBSYHJNphTQQLN+9SgtjlOEEfwh2CsqMo0xK+QEg07
 CopQdjxrvCmL1FT3XLFciCGAf8MEEPQencrbyL1RHC6mzs+TwxpzurQ2jYdf0S0VKbe7
 PwNBzO1ifUuNmjdr4nupCu1Vk2EDdflVw2FWJQbLkWBy129u9ud6KEHLdND87owFix/c
 I7s0ixJhRJzFtOs9r4pCgDga/6IxEZiR0lR8OlQgPf2kTLD5FTJn8rnO2YzoN7U3ERn4
 mlrQ==
X-Gm-Message-State: AFuF++noFar7VF+Nt5MsVwY8mv3iY4qhyv5sAvoRe/Z5qYaig1xqd7+g
 t4xk+h6Bu3ACI754hJnMTzJcNtrKVCoTzOcWVoVS7ZflN+xtFv0JmXaq6tT9H8IpCdG+jhm+9dS
 Sx8lBWTM=
X-Gm-Gg: AYBFou1sX3r+BlOv8/EO/+KtqxIhC/66pO5hixhF9Pl/WQut+kFBxw7c9ml5EBjRaet
 ZtLilla5a9bpNrbKdgpwjjZ3lJoFBXNsLQZ6LSgil8Z+C8xkTMw8JweCs1g4iihrcBuuT2TXJwM
 LZQSQlMlL8qOH7XtQCXo4X5J8i6K/SQNDzX3h1Dopouv9hrFBIEM6uKRCKxXnE1/etDpFuv0cZm
 DydNOyKT8Uohb4qoqNN7F/P5lnZF4vpBjrrXRVtx/dHZ+NG9roSHfZnNoLJdM+HLRpS7bN+LyvP
 MX4PE1vNATn6sMqIYLpatRXMEzcYBtulCES4hqNDQImYPFiwhK2hQ/c5ynTKFt4YlygoxdLQtUJ
 jLWkxC4dRsLTFL34IBQ0JguhXbyMLjURz1nQ8qhWvG4LWTNE9Q08T9z+0bAeiUlpjP+grl8lrEx
 bRw0ycduk8cQM+TOjQIBMXqV3g62dbA5unwb5LQvxwLjpNeqxeHGHkeA0FM+FNEnMcoKvzrQ3vJ
 fey98T3ydBK8eC7Fnhojx0TBNVU15kg7xA7mQ==
X-Received: by 2002:a17:90b:17cd:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-39debf88a21mr2624937a91.1.1789365059646; 
 Sun, 13 Sep 2026 22:50:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 29/62] net/ixgbe: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:00 -0700
Message-ID: <20260914054912.755403-30-stephen@networkplumber.org>
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

devarg_handle_int() truncates the strtoul() result into a uint16_t and
then infers overflow from the truncated value being USHRT_MAX, so a
value such as "65536" is silently accepted as zero. It also never
checked the end pointer, and read errno without clearing it first.

fiber_sdp3_no_tx_disable and pflink_fullchk are booleans, so make the
fields bool and parse them with rte_kvargs_handle_bool() straight into
the adapter, which also removes the temporary and the "== 1" dance. A
bare key now enables the option, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 40 ++++++--------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  4 +--
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..e410c8d469 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -355,8 +355,6 @@ static int ixgbe_dev_udp_tunnel_port_del(struct rte_eth_dev *dev,
 static int ixgbe_filter_restore(struct rte_eth_dev *dev);
 static void ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev);
 static int ixgbe_wait_for_link_up(struct ixgbe_hw *hw);
-static int devarg_handle_int(__rte_unused const char *key, const char *value,
-			     void *extra_args);
 
 /*
  * Define VF Stats MACRO for Non "cleared on read" register
@@ -1059,7 +1057,6 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 		      struct rte_devargs *devargs)
 {
 	struct rte_kvargs *kvlist;
-	uint16_t sdp3_no_tx_disable;
 
 	if (devargs == NULL)
 		return;
@@ -1068,11 +1065,10 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 	if (kvlist == NULL)
 		return;
 
-	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1 &&
-	    rte_kvargs_process(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
-			       devarg_handle_int, &sdp3_no_tx_disable) == 0 &&
-	    sdp3_no_tx_disable == 1)
-		adapter->sdp3_no_tx_disable = 1;
+	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1)
+		(void)rte_kvargs_process_opt(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
+					     rte_kvargs_handle_bool,
+					     &adapter->sdp3_no_tx_disable);
 
 	rte_kvargs_free(kvlist);
 }
@@ -1555,28 +1551,11 @@ generate_random_mac_addr(struct rte_ether_addr *mac_addr)
 	memcpy(&mac_addr->addr_bytes[3], &random, 3);
 }
 
-static int
-devarg_handle_int(__rte_unused const char *key, const char *value,
-		  void *extra_args)
-{
-	uint16_t *n = extra_args;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	*n = (uint16_t)strtoul(value, NULL, 0);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
-
-	return 0;
-}
-
 static void
 ixgbevf_parse_devargs(struct ixgbe_adapter *adapter,
 		      struct rte_devargs *devargs)
 {
 	struct rte_kvargs *kvlist;
-	uint16_t pflink_fullchk;
 
 	if (devargs == NULL)
 		return;
@@ -1585,11 +1564,10 @@ ixgbevf_parse_devargs(struct ixgbe_adapter *adapter,
 	if (kvlist == NULL)
 		return;
 
-	if (rte_kvargs_count(kvlist, IXGBEVF_DEVARG_PFLINK_FULLCHK) == 1 &&
-	    rte_kvargs_process(kvlist, IXGBEVF_DEVARG_PFLINK_FULLCHK,
-			       devarg_handle_int, &pflink_fullchk) == 0 &&
-	    pflink_fullchk == 1)
-		adapter->pflink_fullchk = 1;
+	if (rte_kvargs_count(kvlist, IXGBEVF_DEVARG_PFLINK_FULLCHK) == 1)
+		(void)rte_kvargs_process_opt(kvlist, IXGBEVF_DEVARG_PFLINK_FULLCHK,
+					     rte_kvargs_handle_bool,
+					     &adapter->pflink_fullchk);
 
 	rte_kvargs_free(kvlist);
 }
@@ -4231,7 +4209,7 @@ ixgbevf_check_link(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 		*speed = IXGBE_LINK_SPEED_UNKNOWN;
 	}
 
-	if (wait_to_complete == 0 && adapter->pflink_fullchk == 0) {
+	if (wait_to_complete == 0 && !adapter->pflink_fullchk) {
 		if (*speed == IXGBE_LINK_SPEED_UNKNOWN)
 			mac->get_link_status = true;
 		else
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..75d9ef4cce 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -496,13 +496,13 @@ struct ixgbe_adapter {
 	uint8_t rss_reta_updated;
 
 	/* Used for limiting SDP3 TX_DISABLE checks */
-	uint8_t sdp3_no_tx_disable;
+	bool sdp3_no_tx_disable;
 	uint16_t max_vfs;
 
 	/* Used for VF link sync with PF's physical and logical (by checking
 	 * mailbox status) link status.
 	 */
-	uint8_t pflink_fullchk;
+	bool pflink_fullchk;
 	uint8_t mac_ctrl_frame_fwd;
 	RTE_ATOMIC(bool) link_thread_running;
 	rte_thread_t link_thread_tid;
-- 
2.53.0

