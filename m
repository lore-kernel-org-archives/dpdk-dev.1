Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69550CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0EBE4114B;
	Tue, 29 Sep 2026 02:21:56 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 5C9D5410D4
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:52 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2d560775ca2so10388085ad.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641311; x=1791246111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Se70ABlvV31pf3hn946Ugs4u8WDDnB4RVhywoYvfTM=;
 b=MJqpuRGIaXVjaY/S1MxRgvebLXXSPhKsnIdjIKQKDm4AicK+NjYbw1N0z05yMFW8cq
 xv4rLwB+t2vF1hLqgKGTCszROSQgxSOeBtPbKDQDE1KQiGs2XdnRTtrTxIDPZhgc9PlO
 Att53ISPX5q32ibI7dfvKKk8OgsoBENkOL/K9D4RS6jCv+o5aSyB1oYaxO6te5nGCAgN
 og2C9GM8u5KRav9yxaua5Pnba3DvoYZTEtufe7cB9q8y4S369orPWX54rcOkSJ4UGs7a
 EiPAERY2gF+urzKmEM0jH3ShjbeqczmK6DqeilAa2cGo/CXUX72BAEIaDlgs5WgwCgi5
 3nOg==
X-Gm-Message-State: AFq9FYLyG4IzyklI2s40Nf8X6df6TxXsYYyvPEE41WPEh1g4McpdZg0l
 qzzm/p+yU40CG/B6TuMVQGdhUTgfhXTjY0TRYiu//nsKX2Fy/7hOWJQIomQWZqM8G29xt3IH5Wb
 J/Xz82pJhm/cIi654RmW2CugoDfdufSJsNuQyId1AlX2Ffgi9TK8+jzk21y2qNXBWSrnjXJLvZT
 mO8j1SHvV18gwiqG4NcB0IwvrSpRgLdnTVeaHYr9j9ldYydhMSH1df5o0tw3p1JS2iQpfK9/HkD
 olIX0xOADQj
X-Gm-Gg: AYBFou2MKuIBJ5mfaM5tBt/e0kERASi69voeBoI4GZ+MPHcvl0Ux9HldzTVWNbDXzPt
 aJIzVW6VkzPADskI0fwrRsPcY6EfFmKegmdxwZXHhBdDlYta3jI8nn4A/WcQxGmj2lCSDh9RT64
 hkdCkkDzpDOORkYqFYeulcqQu+N+elyajD8RJqvy7TiXVg9RmOgZTnybgoZlJw1vUZqhGBjU//S
 XrVWtrRyl2X5mruNjv8CAsnHc5jJAPoS45eBbbZG3oK1Sj07OwpD8lN2iX49B7dg1EjI5mi/Oyi
 ymyO6a4molpjuNzaXxSSOUwCBbqFj4nX78kWLO53SB8SydDR+VciPrxA6wEtXAlZQnCkCWlsFNy
 yMvJLiprJaXpMBoe7xXmGydrghx+JwgDitjHh8YoPiRYV6F4ZZuenYHXu69CL8+0mz5EsERJekp
 qHnkX7e9ew8c9s9bT+kXb9PWduxORQSUIxVfczFkAxGqZ9MKvT/YHO
X-Received: by 2002:a17:90b:3952:b0:3a0:c22d:fbea with SMTP id
 98e67ed59e1d1-3a0c22e022amr8463213a91.60.1790641311266; 
 Mon, 28 Sep 2026 17:21:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc7902474b2sm6687969a12.1.2026.09.28.17.21.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so644706585a.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641310; x=1791246110; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Se70ABlvV31pf3hn946Ugs4u8WDDnB4RVhywoYvfTM=;
 b=Vgl/j0vAMTxpdeydzQAXen3MWOP8LIWp0SPbT4uWp7pE9Eh2ZmeEOmUOV0yIXR1gdp
 9G3/86P3OA7CoFZeNjW+O70huPV1d8iykGJ59BeKe83Qt+ugBS5sgFwVVW1AG71mVniK
 cvRRI7xuZ318mQDZroXuzE38IQW7/Fll7OsiY=
X-Received: by 2002:a05:620a:4494:b0:93b:c350:a31e with SMTP id
 af79cd13be357-93c43e0e7a6mr2350977885a.38.1790641310104; 
 Mon, 28 Sep 2026 17:21:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:93b:c350:a31e with SMTP id
 af79cd13be357-93c43e0e7a6mr2350975285a.38.1790641309613; 
 Mon, 28 Sep 2026 17:21:49 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:48 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 5/5] net/bnxt: fix TPA agg Rx descriptor and VNIC query
 bounds
Date: Mon, 28 Sep 2026 18:24:42 -0600
Message-ID: <20260929002442.1208481-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Three independent out-of-bounds issues:

- bnxt_rx_pkt() incremented tpa_info->agg_count and indexed
  tpa_info->agg_arr[] with only an RTE_ASSERT (compiled out in release
  builds) guarding the array bound, allowing an out-of-bounds write if
  firmware sent more aggregation segments than TPA_MAX_NUM_SEGS.

- bnxt_rx_descriptor_status_op() used the firmware-supplied completion
  opaque value directly as an rx_buf_ring[] index without masking it to
  the ring size first.

- bnxt_hwrm_func_vf_vnic_query() returned the firmware-reported
  vnic_id_cnt unclamped; a value exceeding bp->pf->total_vnics would
  cause the caller to iterate past the end of its VNIC ID buffer.

Fixes: b150a7e7ee66 ("net/bnxt: support LRO on Thor adapters")
Fixes: 0fe613bb87b2 ("net/bnxt: support Rx descriptor status")
Fixes: cbcd375d37d2 ("net/bnxt: fix HWRM macros and locking")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c |  3 ++-
 drivers/net/bnxt/bnxt_hwrm.c   |  3 ++-
 drivers/net/bnxt/bnxt_rxr.c    | 10 +++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 20084826d3..3a530c31aa 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3624,7 +3624,8 @@ bnxt_rx_descriptor_status_op(void *rx_queue, uint16_t offset)
 		case CMPL_BASE_TYPE_RX_L2:
 		case CMPL_BASE_TYPE_RX_L2_V2:
 			if (desc == offset) {
-				cons = rxcmp->opaque;
+				cons = RING_IDX(rxr->rx_ring_struct,
+						 rxcmp->opaque);
 				if (rxr->rx_buf_ring[cons])
 					return RTE_ETH_RX_DESC_DONE;
 				else
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 361402b36f..42ed6e5ae1 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6234,7 +6234,8 @@ static int bnxt_hwrm_func_vf_vnic_query(struct bnxt *bp, uint16_t vf,
 	}
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 	HWRM_CHECK_RESULT();
-	rc = rte_le_to_cpu_32(resp->vnic_id_cnt);
+	rc = RTE_MIN(rte_le_to_cpu_32(resp->vnic_id_cnt),
+		     (uint32_t)bp->pf->total_vnics);
 
 	HWRM_UNLOCK();
 
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 1790ce839f..fa10446c27 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1156,7 +1156,15 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 		}
 
 		tpa_info = &rxr->tpa_info[agg_id];
-		RTE_ASSERT(tpa_info->agg_count < 16);
+		if (unlikely(tpa_info->agg_count >= TPA_MAX_NUM_SEGS)) {
+			PMD_DRV_LOG_LINE(ERR,
+					 "TPA abuf: agg_count %u exceeds max %u",
+					 tpa_info->agg_count, TPA_MAX_NUM_SEGS);
+			tpa_info->agg_count = 0;
+			bnxt_sched_ring_reset(rxq);
+			rc = -EINVAL;
+			goto next_rx;
+		}
 		tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
 		rc = -EINVAL; /* Continue w/o new mbuf */
 		goto next_rx;
-- 
2.47.3

