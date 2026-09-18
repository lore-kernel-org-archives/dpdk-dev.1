Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E544C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6299043283;
	Fri, 18 Sep 2026 05:24:57 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 1D318432B2
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:55 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso167371a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701894; x=1790306694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S5B6Xpjv9PF4lxGVyGArfsyZUuxykdRc2T6C1KB362k=;
 b=E+jV7zemldNyFBFlXuZezC2rsJwWk0Eoc/kgs7QQzjTWz8j2cl6XWSJnILuoKpp08V
 qNCVSJvZFtg0NeBDLtfc9G0HaTlpKEes92wAe7zglsZ9+S71kVCIV+XSpYKTWhIZrL3R
 ZDHm8Q2QwwvW35wLqfhyNpfib2k0SBk4D8GFMVnjaP9CQjV293JEpV8wW/aIgoIc8Q7s
 Ms+r70IUUr4aKZuwFmdxY6hDm4zYQcAIJ+AuzsXwJ8f17kFCk4BEZjiIhEQhatd9XR0q
 mJjAbxssNubru41iavSoWvSsGCebrE9TO0BqwxiuMsSTaV0i5uZurBy7ZQJH69rlzbUd
 EHUA==
X-Gm-Message-State: AFuF++krpDZvXEYkLhMgKJdkpATtxRNGnhp3NJ7czyJx35UJC1qsKED+
 tpjkXr0/H/vbLjws/zLlnOKs6Lz4+oZUQRn1AaC8nJTWR3vxY/BiATVuhRyR9nycbSQN9c7QigO
 OY9dnXkGhbHjBx/wwpQeFe1+13AqP5RgBw9sCqZLXTCn3DhF1iIKNrWnGDA5mE1FlesV2+tSGyR
 xxiIDzADRP3h5NUtOdXga4f7MgIwD/4ExAPEi4Uk6CQ1EsQnHXiJuudxBv/Kb8QihYi7h0SKsXg
 QIjBAWBYO9Z
X-Gm-Gg: AYBFou2EkX5Eu/JE55GvkuxaCQ56DVIqrhvfWu3+8WF22PH480DR2G7fSVlAhAPjVV0
 XHhTlXe6aqjcs1EoQmDYk0WTIfSadicTrVgU7MUNA2KfyR4cY2nlOWlSo1rO0NkCAwHChiIt+x1
 wd2fnpMXLsr3BsEeDP6PLu2Eki/i1e/sggZzXvTnEWmqJ4pcfRuPuSlMwVgjgI1W9qeYTgKNehj
 uLTf+XJCdz5BiNrMewrKqQFZ2PIWXMS5zY12/zgtuJmHg407F1JvZ1iXZ+4YGhjXyt05Iy1w5u9
 FOsrhXn/e+XBo8yeA69UTuq5ot+D5JNrvhGn8863VSbKJlEIoO/1XdhKTB3Z2IdLeDLLyvQi2jO
 PkKVYDc2YJz0q8bd5H5AZHF1ejRtl4g2CYDqtlwU1mLJuaDGn8UWfvUmyH/NnaLDru1b3eSxhlp
 4Ho6roMfa+dbwjFgldvZyDdrO2Ba+3R/SfzL+ZM6O+446+z0IdOQ==
X-Received: by 2002:a17:90b:5291:b0:39d:e54c:a28a with SMTP id
 98e67ed59e1d1-39e54bba9e8mr2818426a91.8.1789701894129; 
 Thu, 17 Sep 2026 20:24:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e56268876sm130546a91.2.2026.09.17.20.24.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so604053a91.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701892; x=1790306692; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5B6Xpjv9PF4lxGVyGArfsyZUuxykdRc2T6C1KB362k=;
 b=QILrCmqeFkUOQUJFa/fsPUffnT7A6Uek42m5n60uQ5CUJvMh+x+/Z2Uc9e52HgjJUq
 BEwejrW+TljWZNUPNXXr2MzE1Bhtbk5YY5My+RupZ97wdcoI+kP8BIba2v4D0tB3fc2L
 Mm+0KapizC+9hVOF9GPdbhE6IMNhoED9c3HLI=
X-Received: by 2002:a17:90b:2884:b0:39e:b15:7950 with SMTP id
 98e67ed59e1d1-39e54d8678bmr2700194a91.23.1789701892317; 
 Thu, 17 Sep 2026 20:24:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2884:b0:39e:b15:7950 with SMTP id
 98e67ed59e1d1-39e54d8678bmr2700139a91.23.1789701891659; 
 Thu, 17 Sep 2026 20:24:51 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm537742eec.5.2026.09.17.20.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:51 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 5/5] net/bnxt: fix TPA agg Rx descriptor and VNIC query bounds
Date: Thu, 17 Sep 2026 21:27:52 -0600
Message-ID: <20260918032752.763408-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixes: b150a7e7ee ("net/bnxt: support LRO on Thor adapters")
Fixes: 0fe613bb87 ("net/bnxt: support Rx descriptor status")
Fixes: cbcd375d37 ("net/bnxt: fix HWRM macros and locking")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c |  3 ++-
 drivers/net/bnxt/bnxt_hwrm.c   |  3 ++-
 drivers/net/bnxt/bnxt_rxr.c    | 10 +++++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index db9b49238a..d21ebac0c2 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3631,7 +3631,8 @@ bnxt_rx_descriptor_status_op(void *rx_queue, uint16_t offset)
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
index 0143da8789..aae50c1fea 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6242,7 +6242,8 @@ static int bnxt_hwrm_func_vf_vnic_query(struct bnxt *bp, uint16_t vf,
 	}
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 	HWRM_CHECK_RESULT();
-	rc = rte_le_to_cpu_32(resp->vnic_id_cnt);
+	rc = RTE_MIN(rte_le_to_cpu_32(resp->vnic_id_cnt),
+		     (uint32_t)bp->pf->total_vnics);
 
 	HWRM_UNLOCK();
 
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 87640eaa79..cd4e93bdb3 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1164,7 +1164,15 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
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

