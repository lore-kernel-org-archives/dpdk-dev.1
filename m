Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5BEB3622
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A6F840E6E;
	Mon,  2 Mar 2026 18:11:52 +0100 (CET)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id D70E240E40
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:11:49 +0100 (CET)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2ae45a4cc54so11060915ad.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471509; x=1773076309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IyeWRJD8E4bbVgTp+JP8CLccXEut2YZzvDoEcejc6hg=;
 b=dV2QzrSO/ETnE3nyzA1Uj8ZkKNiaaqzwWGHAZkD80AypDpuKB+ZDK/XrIijMpdUgZU
 mM6duEVRvEeBquxH5U12GS8C2ud5tMwMaiKU6nhhb+M9IN9DVlaXH7huIsQbcyZdoCsT
 jyW55o/4daJXj+633cASE+XFFQk3N7o+oY9qAVzOazCKjqy/8yIwVJg/x8MU+Yn4ZOC/
 l+HUAPFuaQltUBMtyjsOBajjSqqSIE+/+Q+24SaPOgXQJ/whAqj6reCdkBN8e9b9GIXt
 d/F85rVufQoJ46G0BhyqiOh2zkr9cpzMVlaJQIe7hY2WItpyimGGdS1GuljMNgJfYyUw
 fQJg==
X-Gm-Message-State: AOJu0Ywx0DJ5ioN5HxWaCIwFM5Jf3qLkx4WymfFGXjpEjx4nOuI9+rhp
 Jq8efYtP3lFUfR7Q4O7U1knsZkJWZp3s5fTo1HUkDAF/AW5PTg1IvF0E7wriiW6q7/u+zaNj7ZK
 /V+/eoGxxxejY1dpXHC3mL+6CV3gYOkdaRdhqvnXUq67VBogNOihfcbjQZ2YN2KOvKajjs8AED4
 8kt8YaXUPgxlG9C3F5wue6+T7djnxRCsaWcXNaC0vEN34+U7HPDWUOkinPAPmkTB7QFdGn3rZ0p
 Hfm/BIghLb8
X-Gm-Gg: ATEYQzytbToR49pQz+O4NFMuHgXe2y6V/BzMCV563/rnEG26u8WcoybwLMJz+6BYLle
 7FsDfPfxFAwg8XinST3eomQW2H7dIdS5mOFIBgy854O6Ms+1/4qHOjZKgqk3Vd4oQRFtKlMq9bd
 wIyvBCw9Dbph9PnEB3FSpGpBkKupIy3QsYkQW7vo+OIyTscio1lLM+XV0a4Y8KovxXN1umkeTYK
 sCU824wkuu6kjcyfSJwnXMTqfm8cNzpii3KWZ5iKz6DkJAejmNefDlfddxhTfb+lq8q8Vm0ZsT/
 sqVQmj7XBmC+nmcpD7z1Ht4j7pYUUsW5kvPzwhXQvYSbjTaXYZ//X5TIe0OyOozeRJwMp2bSxvP
 Z55LZ/ub7/fldxNCuLipvX5vp80UG7aBqhE1vPG3SK25x26H14t0U4uc3H235tuZKuqmAASZ9/+
 ymEwO2v1VXiPPXML5WcUsJgA3sR1l+ODOJAohi3h9oQ5/kZMy4bwun7LXa1fIoytf5rs1JSqQMh
 Q==
X-Received: by 2002:a17:903:2383:b0:2ae:3a77:a1f4 with SMTP id
 d9443c01a7336-2ae3a77a619mr86164395ad.24.1772471508823; 
 Mon, 02 Mar 2026 09:11:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2adfb5eee53sm16814065ad.43.2026.03.02.09.11.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:11:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-126e8ee6227so8531966c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772471507; x=1773076307; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyeWRJD8E4bbVgTp+JP8CLccXEut2YZzvDoEcejc6hg=;
 b=iDi6AsixoT2zWHOczFJ/hPXTjFjDXtwbg+vytlJ+Cm3cpwT0ZOxGtcCkAVkUiL+YwI
 GDT8uyVwxwvTttKy8RVSkOrcy4Bi9IoxirHj/v+UM6b2qOXx7oCV8EcsWLfnk5nwHHSE
 aPowNxKQNDyo/qcXf/elAaGHdMWJr2hb7phns=
X-Received: by 2002:a05:7022:6283:b0:124:9f67:6b6f with SMTP id
 a92af1059eb24-1278fbb1245mr5540221c88.20.1772471506671; 
 Mon, 02 Mar 2026 09:11:46 -0800 (PST)
X-Received: by 2002:a05:7022:6283:b0:124:9f67:6b6f with SMTP id
 a92af1059eb24-1278fbb1245mr5540204c88.20.1772471505939; 
 Mon, 02 Mar 2026 09:11:45 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm13910511c88.0.2026.03.02.09.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:11:45 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/4] net/bnxt: pass Rx timestamp in mbuf
Date: Mon,  2 Mar 2026 10:12:34 -0700
Message-ID: <20260302171236.98625-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

Pass Rx timestamp value in the mbuf using dynaflag.
Add ptp_cfg NULL checks to avoid segfault when ptp_cfg is not created.

Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h        |  4 ++++
 drivers/net/bnxt/bnxt_ethdev.c |  9 +++++++++
 drivers/net/bnxt/bnxt_rxr.c    | 21 +++++++++++++++++----
 drivers/net/bnxt/bnxt_rxr.h    |  7 +++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 83ae151066..92ba475198 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -403,6 +403,10 @@ struct bnxt_ptp_cfg {
 
 	/* On P5, the Rx timestamp is present in the Rx completion record */
 	uint64_t			rx_timestamp;
+	/* Dynamic mbuf field for passing Rx timestamp. */
+	int				mb_rx_timestamp_offset;
+	/* Dynamic mbuf flag for indicating Rx timestamp. */
+	uint64_t			mb_rx_timestamp_flag;
 	uint64_t			current_time;
 	uint64_t			old_time;
 	rte_spinlock_t			ptp_lock;
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 3c618c6e82..c75cd05d99 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1686,6 +1686,7 @@ static void bnxt_ptp_stop(struct bnxt *bp)
 
 static int bnxt_ptp_start(struct bnxt *bp)
 {
+	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	int rc;
 
 	rc = bnxt_schedule_ptp_alarm(bp);
@@ -1694,6 +1695,14 @@ static int bnxt_ptp_start(struct bnxt *bp)
 	} else {
 		bp->flags2 |= BNXT_FLAGS2_PTP_TIMESYNC_ENABLED;
 		bp->flags2 |= BNXT_FLAGS2_PTP_ALARM_SCHEDULED;
+
+		/* extra mbuf field to store timestamp information */
+		if (rte_mbuf_dyn_rx_timestamp_register(&ptp->mb_rx_timestamp_offset,
+						       &ptp->mb_rx_timestamp_flag) != 0) {
+			PMD_DRV_LOG_LINE(ERR,
+					 "Failed to register mbuf field for Rx timestamp");
+			return -rte_errno;
+		}
 	}
 
 	return rc;
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index ac4c61b850..0ccf47cf35 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1190,19 +1190,32 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	mbuf->data_len = mbuf->pkt_len;
 	mbuf->port = rxq->port_id;
 
-	if (unlikely((rte_le_to_cpu_16(rxcmp->flags_type) &
+	if (unlikely(((rte_le_to_cpu_16(rxcmp->flags_type) &
 		      RX_PKT_CMPL_FLAGS_MASK) ==
 		      RX_PKT_CMPL_FLAGS_ITYPE_PTP_W_TIMESTAMP) ||
-		      bp->ptp_all_rx_tstamp)
+		      bp->ptp_all_rx_tstamp) && bp->ieee_1588 &&
+		      bp->ptp_cfg) {
+		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP |
+				  RTE_MBUF_F_RX_IEEE1588_TMST;
 		bnxt_get_rx_ts_p5(rxq->bp, rxcmp1->reorder);
-
+#ifndef RTE_IOVA_IN_MBUF
+		bnxt_timestamp_dynfield_set(mbuf,
+					    bp->ptp_cfg->mb_rx_timestamp_offset,
+					    bp->ptp_cfg->rx_timestamp);
+		mbuf->ol_flags |= bp->ptp_cfg->mb_rx_timestamp_flag;
+#endif
+	}
 	if (cmp_type == CMPL_BASE_TYPE_RX_L2_V3) {
 		bnxt_parse_csum_v3(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v3(mbuf, rxcmp, rxcmp1);
 		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1);
 		/* Packet cannot be a PTP ethertype if it is detected as L4 */
-		if (mbuf->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_GOOD)
+		if (mbuf->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_GOOD) {
 			mbuf->ol_flags &= ~RTE_MBUF_F_RX_IEEE1588_PTP;
+			if (unlikely(bp->ptp_cfg))
+				mbuf->ol_flags &=
+					~bp->ptp_cfg->mb_rx_timestamp_flag;
+		}
 
 		/* If its a PTP frame, ptype cannot be L2_ETHER */
 		if (mbuf->ol_flags & RTE_MBUF_F_RX_IEEE1588_PTP)
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 5e5496964f..0b7649193f 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -181,6 +181,13 @@ bnxt_cfa_code_dynfield(struct rte_mbuf *mbuf)
 		bnxt_cfa_code_dynfield_offset, bnxt_cfa_code_dynfield_t *);
 }
 
+static __rte_always_inline void
+bnxt_timestamp_dynfield_set(struct rte_mbuf *mbuf, int offset,
+			    rte_mbuf_timestamp_t ts)
+{
+	*RTE_MBUF_DYNFIELD(mbuf, offset, rte_mbuf_timestamp_t *) = ts;
+}
+
 #define BNXT_RX_META_CFA_CODE_SHIFT		19
 #define BNXT_CFA_CODE_META_SHIFT		16
 #define BNXT_RX_META_CFA_CODE_INT_ACT_REC_BIT	0x8000000
-- 
2.47.3

