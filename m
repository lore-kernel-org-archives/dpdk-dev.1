Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB7FCCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13A5840B8C;
	Mon, 19 Oct 2026 13:47:10 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id E3E404026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:21 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-35ef6b49813so278256eec.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172781; x=1792777581; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFvYuJw3jbA8YGiYjUyjJ5LBjBpmBMJ3m1xvxwxxdGo=;
 b=hVy+CVflCA7mHnbslPH3aDbkPqVuehWXeEmfOqAYxhdJXsEcp47ysQFCKXCUpR0iRS
 Kh+Mk/yA0HO63A/m2XBfQqDktIZVrEp96YVm6i/Hq3r/Ea72OZVsuSrq/goO67+BHBYz
 6OLpGWg9kGhDS1X6pDVZMUy5uOzElX1G2nME23+bIMJ9VWk42vnDZTes9JS71E6ZyLiP
 U967W3oD97z+qfEae9QMeH+2iEmIBdJjw0Fs5xs+iPLFUNyG61snNycjr/lrkd4wFunQ
 PSx3YrJthn9VUraACdvkLt6NG5Jhpu6UBhyfUWANqa2/0QXqAkOren80OEro9xTWRmax
 Jy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172781; x=1792777581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KFvYuJw3jbA8YGiYjUyjJ5LBjBpmBMJ3m1xvxwxxdGo=;
 b=whrfBG9naKDyXhjiLYD4H70URse5AhzPIKZpH92r3ebKyImyw9fIYZ/YSwskdfVQzG
 MSp5Qg5AmsVOvnsaRruvyzOQ3+YX7Cg7mM//We6C4ab7h3lb6Po3y7bBPL+0+znxvmhG
 VrHdEPhtw0CLd66+IjPV+q8ddoM1Ef0KkqACSKSssXb1/XM8pOYk0TIFuy3033ZFVEAc
 ajrGhBdzu4ps/EOUqyOBCTZQq5tcRPjGSUkEj8+XsTunAUyGQz7ofj4bUCzvumdhLiuJ
 uu+NU0q5NE/hjv5q9gIx32+vyForYTvDsNLpbNaOse9nCKAJ7438vfqP6JxL2EqjlpkZ
 Xz/g==
X-Gm-Message-State: AFq9FYJ8BXzJFoqdmXqFOjYKrjPUlsk1PkkZm3b8uYd9A3KGtRm0b8Lv
 pj0ucz1qMEAjWIxVNx0soGzrGrxTFIsr+ri2wZzrK5fcVnTuvhIZkOuEXI6rDw==
X-Gm-Gg: AYBFou1iPkVQSwuPLo1EWxdiiy3lo/kQ2PXy0XyojlIR9BatMa9RGb7BIFT7K0/n8xw
 H0RICaamtjlb4tDZ7yjigSgzqqS4ThB2z2N2ZmjX5bZobwhvyKVPBeiZD3SO292t71jIZHmDnCp
 z4DY8sjj7fUcwDQobhf2283FX6Qanqdwq+r2ssScThTxAVsCIohLt3xun4WXUWuBWdgEW0HB3iJ
 eN7qZVYETGiFQPIKNLE9+rFE/qUu++hHOdn+5HYQKXIXGOUGP0N0ryP3xj23zi53a9R2n04fdEe
 I3GXkxOx4gVeO1pyUWMb6SUuqwjSTBSR2W1vcSyzl8AS8Xq+0H2oiZk+vacQHsSKCCDeSor+q06
 X9WExQRMWF/R++EpWkYCShjSozQzc1cPlkiVWP8vI568jZaTcXjd6SkNN3kRiicwDrCtG3ZTCn6
 rwKazFOBO+mj/goJmXJ+xjFCCBqskJr7GBY/phLOKrEFNy+lCEBQD6qqnRxr2RcEWdZk4xZWbhw
 moreDmLEbw=
X-Received: by 2002:a05:7022:ea8b:b0:16c:6459:35b1 with SMTP id
 a92af1059eb24-1851310977dmr685989c88.28.1792172780838; 
 Fri, 16 Oct 2026 10:46:20 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:20 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
Date: Fri, 16 Oct 2026 17:45:44 +0000
Message-ID: <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

The device requires non-TSO packets to be 17 to 9728 bytes long, as
noted in the Linux driver, but packets of any length are posted. The
device treats an out-of-range packet as coming from a malicious
driver: it drops the packet and disables the datapath, stalling all
queues.

Drop such packets in the driver and count them in a new invalid_pkts
counter.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/base/gve_desc_dqo.h |  2 ++
 drivers/net/gve/gve_ethdev.c        |  1 +
 drivers/net/gve/gve_ethdev.h        |  1 +
 drivers/net/gve/gve_tx_dqo.c        | 17 +++++++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index c1534959c2..d50d88765e 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -12,6 +12,8 @@
 
 #define GVE_TX_MAX_HDR_SIZE_DQO 255
 #define GVE_TX_MIN_TSO_MSS_DQO 88
+#define GVE_TX_MIN_PKT_SIZE_DQO 17
+#define GVE_TX_MAX_PKT_SIZE_DQO 9728
 
 /* Basic TX descriptor (DTYPE 0x0C) */
 struct gve_tx_pkt_desc_dqo {
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 1dfbe8f396..53b0a0ec63 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1044,6 +1044,7 @@ static const struct gve_xstats_name_offset tx_xstats_name_offset[] = {
 	{ "errors",  TX_QUEUE_STATS_OFFSET(errors) },
 	{ "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
 	{ "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
+	{ "invalid_pkts", TX_QUEUE_STATS_OFFSET(invalid_pkts) },
 };
 
 static const struct gve_xstats_name_offset rx_xstats_name_offset[] = {
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 66cb31dadb..be744d955b 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -115,6 +115,7 @@ struct gve_tx_stats {
 	uint64_t errors;
 	uint64_t too_many_descs;
 	uint64_t invalid_mbufs;
+	uint64_t invalid_pkts;
 };
 
 struct gve_rx_stats {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 46a03d482d..f686a8c110 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -123,6 +123,17 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 		gve_tx_clean_dqo(txq);
 }
 
+/* Validate packet lengths against the device limits. */
+static inline bool
+gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
+{
+	if (!is_tso)
+		return tx_pkt->pkt_len >= GVE_TX_MIN_PKT_SIZE_DQO &&
+		       tx_pkt->pkt_len <= GVE_TX_MAX_PKT_SIZE_DQO;
+
+	return true;
+}
+
 /* Max descriptors a single packet may use. A larger packet can never pass
  * gve_can_tx(): one slot is always reserved, the cacheline overlap margin
  * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors posted
@@ -306,6 +317,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
+		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+			txq->stats.invalid_pkts++;
+			rte_pktmbuf_free(tx_pkt);
+			continue;
+		}
+
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
 
-- 
2.43.0

