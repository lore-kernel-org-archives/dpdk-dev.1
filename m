Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6DECA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF69042EF5;
	Thu,  1 Oct 2026 00:44:16 +0200 (CEST)
Received: from mail-pj2-f37.google.com (mail-pj2-f37.google.com
 [74.125.227.165])
 by mails.dpdk.org (Postfix) with ESMTP id 075B542EF8
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:15 +0200 (CEST)
Received: by mail-pj2-f37.google.com with SMTP id
 98e67ed59e1d1-3a4eda6744bso526626a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808254;
 x=1791413054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1o8gPflkDU8DXzzEjH8SP5MGbwx7fJoSMidiZTGq1I=;
 b=b+VjcXAtDmLw4yrtKLQH8yiOwDFDjfi/+ZCpB/WqZaPV8xvZVBZp9nr9dH+65H2g4u
 n2GWtodVDATYCZ6bx5Eu6jk8eRwCJ1MfaILYXGaLPUj2Jd+kiO6Kw2u38SdXu6AuU13P
 oLNSH2a8vmo2sD1eRIGbkoYbGIQATPIX0q1Veq0H+SNGeN6w+23H/mbgu59cqtmDZ1KN
 BcoKHvJDG//CkiCm7gB+btozUs3on0j1Ruy7+aTDV6vhnQg4ZsyGgk9Hkd767YWT3Cyo
 jkU9S2Iskp5hKsueO2tS82ezO09KjIZv4SMk7BfughX/E/LJFpwHJtOTyaMvnTHzRiMY
 93Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808254; x=1791413054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M1o8gPflkDU8DXzzEjH8SP5MGbwx7fJoSMidiZTGq1I=;
 b=reram479ktnNjgkQWQtOZhWXq9nqumZLTYHQ0m6zEDUy8GGnWwWBwT1+khnqrOEFDr
 K4bariaEkV4Mkv9qB1OiUs4dQpQ9gswVHcVxDLqkbLQppYVnuhgrkPuOXsVQtDa3cnId
 bTRYKYuR33zGNyjN03Shfd0O2U3sK9N2smKJ6+9Z2gv9vSgImVkaot03FNcP4yaHfeWA
 l/MO82yNuRwT2T4X4q9tvcasSp+AX2+xh2kWrA/+2Q4JTJbhhhjA40LIgYzrXlKDQCuz
 fy8c9Kxa0hEBmvm7dlOFYp7UwmeBKeWuKYcJUqhpMrPgSpSHg5zuqT007g6zVzHcHvlN
 L/IA==
X-Gm-Message-State: AFq9FYLrRd2B2EBprFDKT0Z1TpwE2AwJZ6Kh6KCu6/KMAORuGvoqCqku
 lSnc50b1UeXpm9chCcXJWfxHnz2VJbxmnVqmYIbYcAk3ykEhRZ6dyNvUUYz8pX0e1i9Sxqd1EGs
 lumtIs6o=
X-Gm-Gg: AYBFou1CKZPaPIwAyhixdFNq0tn2PB8oJJI9eGQopxll2PV7fR0OmuxVmYvcgWxTgI6
 0q7Ok3aKTfAklzYXpLOgg6qbfgQm71YGHkAeAHyxAh2GcUqmfMxvFo5B2dL27RgyScJAIbLksyM
 80N4Pc5Y39ImP9ZBveO+oZtfI7fd9+sEooqk1h0Y0sU+MwQM5vZyIRkWX7bd1r/Gdn3wPR0tF+y
 /BG6+65u72eBEWiomeWVWUb1s+qQQe6Krr6mZk458HLUhIryVC0yL2gtNz5C/m6pqC8QjI61Hy3
 39G3CjyKqoX4OPpeeQhqNapDTCKWoxBV7E3xXbXtJ3NgFdQF+mJPlbqsZwj8Xtlb0Rzn2pocZ+L
 JC0lxrV3BUUI92jwsY4Lh3MCmQ5Tbi8atTVYrTWnmiT/8WHboMekSYQv8W+meRn2gXQIYR9AbUF
 7Xz/JANC3Veu2hrPDuhdVfBy43OhwK7KdGg5E1L5rrt4IJLzwfK1ogw1r2ljSsO/p5ncGmtf14f
 QC3X3TLcSxnPuTfM2UtGsrv9m6/7pPSPiurIJJnWRBNATHl
X-Received: by 2002:a17:90a:ec83:b0:3a4:b51b:d415 with SMTP id
 98e67ed59e1d1-3a4d189d5b8mr2270294a91.44.1790808254091; 
 Wed, 30 Sep 2026 15:44:14 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 29/65] net/ixgbe: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:47 -0700
Message-ID: <20260930224340.58580-30-stephen@networkplumber.org>
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
index 284df77023..e05c9a8d1f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -353,8 +353,6 @@ static int ixgbe_dev_udp_tunnel_port_del(struct rte_eth_dev *dev,
 static int ixgbe_filter_restore(struct rte_eth_dev *dev);
 static void ixgbe_l2_tunnel_conf(struct rte_eth_dev *dev);
 static int ixgbe_wait_for_link_up(struct ixgbe_hw *hw);
-static int devarg_handle_int(__rte_unused const char *key, const char *value,
-			     void *extra_args);
 
 /*
  * Define VF Stats MACRO for Non "cleared on read" register
@@ -989,7 +987,6 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 		      struct rte_devargs *devargs)
 {
 	struct rte_kvargs *kvlist;
-	uint16_t sdp3_no_tx_disable;
 	enum rte_eth_fdir_pballoc_type pballoc;
 	int ret = 0;
 
@@ -1000,11 +997,10 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 	if (kvlist == NULL)
 		return 0;
 
-	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1 &&
-	    rte_kvargs_process(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
-			       devarg_handle_int, &sdp3_no_tx_disable) == 0 &&
-	    sdp3_no_tx_disable == 1)
-		adapter->sdp3_no_tx_disable = 1;
+	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1)
+		(void)rte_kvargs_process_opt(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
+					     rte_kvargs_handle_bool,
+					     &adapter->sdp3_no_tx_disable);
 
 	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FDIR_BUFFER_SIZE) != 0) {
 		if (rte_kvargs_process(kvlist, IXGBE_DEVARG_FDIR_BUFFER_SIZE,
@@ -1499,28 +1495,11 @@ generate_random_mac_addr(struct rte_ether_addr *mac_addr)
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
@@ -1529,11 +1508,10 @@ ixgbevf_parse_devargs(struct ixgbe_adapter *adapter,
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
@@ -4181,7 +4159,7 @@ ixgbevf_check_link(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 		*speed = IXGBE_LINK_SPEED_UNKNOWN;
 	}
 
-	if (wait_to_complete == 0 && adapter->pflink_fullchk == 0) {
+	if (wait_to_complete == 0 && !adapter->pflink_fullchk) {
 		if (*speed == IXGBE_LINK_SPEED_UNKNOWN)
 			mac->get_link_status = true;
 		else
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 0efef29a5d..fff9a07943 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -490,13 +490,13 @@ struct ixgbe_adapter {
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

