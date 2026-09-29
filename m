Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13544CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E6CF42EE0;
	Tue, 29 Sep 2026 18:38:55 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 173484026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:34 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098db8dcdso1901431b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699913;
 x=1791304713; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M1o8gPflkDU8DXzzEjH8SP5MGbwx7fJoSMidiZTGq1I=;
 b=hQnxP40Qg94fzZjzs1FDRINvwSd5yfsq0WfWjcALm4SvZtNGVvcZaGFdShkVuZDo13
 KW5apn2LWWkcbUScFMijpzSWjyOOa1et7McYwQQ5jPppdTy6oe3+nuxkxWshd9g6eS2r
 UCjSB0AKUXjipOedNEWo5z6h+20RaLpvMzxhXeRbVSmx7KnqQg9wb07ysUfBVmtIIOEe
 BwUzU53kkB+TT00KrxX6Z5FVMlIJF2Ii2T/u4OoXwuyfPqFWfRzD1xxlZ7eC3pYFzwS/
 4RFWw3JhTxoSpoGjFJlJFSyIGtGSRDK/num8bDDOFRbK2O4FpSeOJ1yXy2KwEBcK/CRT
 MUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699913; x=1791304713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M1o8gPflkDU8DXzzEjH8SP5MGbwx7fJoSMidiZTGq1I=;
 b=g5SCw8WM+zV6/M5KVsfWr3DrqYcnwSnPktZK5DmQTcd5vvBoipkTrGhz5TmR3FYEpV
 6Z5aoyWLRyWWuKw4WoYfO9sylPNUgb4IgoBKbQpU5YhlSK8qAu1gKzs2oVnU47nUly3h
 YLP3lp1guoQZxnKjF7dQrq2j7rcQWZMXBu9N1Nq2CSwZvnWXNoEdvBvZW2mIOXrmtTz6
 WqUkSBh27SlfayM0w1TUJZSNU4gTD2WRv1uCYfQIAD7cwYAflBJVVUXkU6dv+ceHLWCI
 4wy6KBcUvyrxOGiBjddS+kvNgGApYbsNtMHNO9SQObV03G0EKcwxrj72C5aExRLkJVhw
 txIA==
X-Gm-Message-State: AFuF++m6DnkzSlZVRXPyIN8+yVzpv2faHgF6PArSnM1q3+wQGbQ7qFHj
 v3wx3Q5BVlmmc5YP0XvInsgV1wAE84oDDvbOFMU+vELczliyxfsMESOfmmRBaTRpLcWRl3gvt9J
 uRufnMT8=
X-Gm-Gg: AYBFou0tE4cNokHf/fM7pQtrFFksFIpGrOPXQFbU6Gr+F3kyf6HPcswYXPCbC89PpSq
 UsoP2TtNX8P0NDezj52R1BnZckAzsrZtBYRrooGfpjwi9zz/B+nChVESiF+M7zYsafewUSO0XAI
 MwVqcG/4DG2UcUyLQXQ+qV1MVJFwgbD6oCPTk463kghOrnkiqhX4erY82VF1N1XBLiqpyqmHt4P
 b7aeKhoJtSqK6FWkRm+PnbItn9IyQY0UCJ86ey/cyrEMKNE/N02PLanReaPZw8hsAMshidX+TNb
 fjgvQZlB6EwWSDxZQfp1vqxfpJyFGz5L4f3PrCKLAt+x3PNkAxOdLsm63LWZnaKWqNcej7aR/zq
 O1nVE09hNP62RynmOVSRbtwpbJy+e72g7C7m9nCMS0AtCwwDI8czRCdzZM7W055qmbF30iggJ93
 bEEthM0MvN9JXzUtCy/1s9NRqac+ntx0PQJwtANqcptSVfrhiWCEnMrSQHGbMwdtTVaQCRsBGMY
 nKYxjh6i9B7g9IHqvRVHI9wWjMMs+9sPdbYKb+VNrof8gv1
X-Received: by 2002:a05:6a00:bb05:b0:878:38af:1970 with SMTP id
 d2e1a72fcca58-87e9e77ea65mr13140544b3a.60.1790699913184; 
 Tue, 29 Sep 2026 09:38:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 28/61] net/ixgbe: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:31 -0700
Message-ID: <20260929163800.1108305-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

