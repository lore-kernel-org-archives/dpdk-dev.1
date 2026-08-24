Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB68C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 19:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0123240689;
	Mon, 24 Aug 2026 21:23:42 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id C397040679
 for <dev@dpdk.org>; Mon, 24 Aug 2026 21:23:40 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-52d590ce5cdso27168541cf.1
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787599420; x=1788204220; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NIRRq9LoIdBLpUPEgllQs3m9uos+Nee7mdXfooiPje4=;
 b=RzXg3r4vMl/5TwQWT1b3HuDfXYA1NCwCzWN1XUZK/E7DePZ1Fp+gJoxQKfojtke32h
 q8ckj0+hL9ElaAjqAXDcosoRcYy5o1tfBMqbgVnHkxn99R7tpxi9LdO9KnzEm+tHff6H
 2W7qTRIV3LHC4cHIh+BHlxAeCwJnn40hb2t7vrMM2K7G8pvA2f0YGYOkr4mlcKQ+JS3w
 grSpCNCZSirQlkWCqSyk9kb00lI4pn2P75FWc2q9iHQvVhaSuxFT7D72t8WHHQbylvKf
 UtOkv+aR2QndOAb0cTgNYF5WYjovVYUTLxULKjjcffq9w0gb5JYaqTXTq4NTsRfktH1K
 mhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599420; x=1788204220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NIRRq9LoIdBLpUPEgllQs3m9uos+Nee7mdXfooiPje4=;
 b=b3WVuI0azcT/VdHjly9Cpd3fjzaMdHRCeXNmk2cwCZsjSORgk/+EIFC4QzOuOz67MQ
 6dIHuGom1K+gKyLQbuyBaKf9S4ufASe2Trr21xeGLJ9CBNJfX7O94vQj+f1xY63e+FVd
 rLMaIRpuTphaKvWvdz1Al0ywxPZF5Go9UqTxmvmqJ6jGyrupUJHZ489ZuUuZF2H++Xlc
 M9nmU0DdU/8DFJWjjK65jvyikJCybQgc9vAMKZcWGu+qaA+w3rCRzBkhAJPTYkoL9tsj
 Hmzd0UCPdIjCG58c5uFu3KCV01ev+bb1bEt10QUXBRCDu8y963/9fSTzImg3YhDAcEvt
 IckA==
X-Gm-Message-State: AFuF++nBEUlI0CXdRnu2ao5Fe4t3/EagutGmQPIT/DpQ2ACa06EA15bO
 L5HNs0Y9kuXwS4o1qu+5AHEawt+6uyIbJBFcowV2XGsjmqSEjJB8pe3sBtv6+V+zt+M=
X-Gm-Gg: AR+sD11ytEasyVbncu8GsGtEPjP/cFTmLI5doWKRUBW4fuRs/e8g+/rkBkwwMnCuk44
 GNGEnxmSvjXOQws3PAHcAuzBPkRIE8q57rhrLNghZ6jT93yr9ktg70StAfJOFC5+emWehL1+O4O
 bmOyMcSEB4aQBqTZtSBYjr/wPrLhu5+q4kRaAhibQ3JftNY4ROtYmWlXtHMIemvmY4LwtzKqddO
 9a1CHCCCgRK9Kn53V3TtGUhAPtJQ0Yzoxu7/rxo2B8s0NRIhxyfK5ac8BI4vsBLDbOdqmA4eCfH
 200Q+/FUUH4Uigmj2Ekf3A5ReqDKOhz5G0fPK2A38N3DyGoMKXrsfoX0NWwgOe1LFAqyiF3AwcJ
 nX7/ozR+GyPPCgB0x+0bnKez8QhoOUt4ytHn63pfDYpLoQBhfiB74whb30QI+eBMXwRnbQtmsja
 hedivAPXysBBnA7fSTlbdwSd4IOpMouBXcSYrPymqk3UQUBDAAUMXiIVBltVMvWw==
X-Received: by 2002:ac8:5916:0:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-52df5a7e229mr294809771cf.35.1787599419947; 
 Mon, 24 Aug 2026 12:23:39 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09974dc5sm53906081cf.1.2026.08.24.12.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:23:39 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: 
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>
Subject: [PATCH 2/3] net: add VLAN insert function with a TPID argument
Date: Mon, 24 Aug 2026 15:22:26 -0400
Message-ID: <20260824192228.1197189-2-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824192228.1197189-1-blandwwa@gmail.com>
References: <20260824192228.1197189-1-blandwwa@gmail.com>
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

rte_vlan_insert() hardcodes EtherType 0x8100 (802.1Q). This is wrong
when reinserting a stripped tag whose original TPID was 0x88a8 (802.1ad
QinQ).

Add rte_vlan_insert_tpid() which takes an explicit tpid parameter, and
rewrite rte_vlan_insert() as a wrapper that passes RTE_ETHER_TYPE_VLAN.

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 lib/net/rte_ether.h | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index cb10d8fb06..1410ec1968 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -379,19 +379,21 @@ static inline int rte_vlan_strip(struct rte_mbuf *m)
 }
 
 /**
- * Insert VLAN tag into mbuf.
+ * Insert VLAN tag with the given TPID into mbuf.
  *
- * Software version of VLAN unstripping
+ * Software version of VLAN unstripping.
  *
  * @param m
  *   The packet mbuf.
+ * @param tpid
+ *   Tag Protocol Identifier to insert (host order).
  * @return
  *   - 0: On success
  *   -EINVAL: overwriting would be unsafe because mbuf is shared or
  *            indirect, or mbuf's first segment is too short
  *   -ENOSPC: not enough headroom in mbuf
  */
-static inline int rte_vlan_insert(struct rte_mbuf **m)
+static inline int rte_vlan_insert_tpid(struct rte_mbuf **m, uint16_t tpid)
 {
 	struct rte_ether_hdr *oh, *nh;
 	struct rte_vlan_hdr *vh;
@@ -411,7 +413,7 @@ static inline int rte_vlan_insert(struct rte_mbuf **m)
 		return -ENOSPC;
 
 	memmove(nh, oh, 2 * RTE_ETHER_ADDR_LEN);
-	nh->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+	nh->ether_type = rte_cpu_to_be_16(tpid);
 
 	vh = (struct rte_vlan_hdr *) (nh + 1);
 	vh->vlan_tci = rte_cpu_to_be_16((*m)->vlan_tci);
@@ -426,6 +428,26 @@ static inline int rte_vlan_insert(struct rte_mbuf **m)
 	return 0;
 }
 
+/**
+ * Insert VLAN tag into mbuf.
+ *
+ * Software version of VLAN unstripping. Always inserts an 802.1Q tag
+ * (TPID 0x8100). Use rte_vlan_insert_tpid() when the original TPID may
+ * differ (e.g. 802.1ad QinQ outer tags).
+ *
+ * @param m
+ *   The packet mbuf.
+ * @return
+ *   - 0: On success
+ *   -EINVAL: overwriting would be unsafe because mbuf is shared or
+ *            indirect, or mbuf's first segment is too short
+ *   -ENOSPC: not enough headroom in mbuf
+ */
+static inline int rte_vlan_insert(struct rte_mbuf **m)
+{
+	return rte_vlan_insert_tpid(m, RTE_ETHER_TYPE_VLAN);
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

