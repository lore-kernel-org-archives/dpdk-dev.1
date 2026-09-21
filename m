Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18435C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47620410DC;
	Mon, 21 Sep 2026 04:21:30 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 04F5B40ED0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:26 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-39de1f85ca2so680092a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957285; x=1790562085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcTe+vAfC8bALPPPldwYdD09ACNUHl4MWrEO77q7sOg=;
 b=G+U4+mNmBrYNG4iKVFr9stG/PqQrym3AObZ78PLl+EJdvtqn4C4aAiVVFsGcXJclC8
 xRaq/oGZreXHTufrKQP08RZrBaJDfTzZ5HabyMrMHtRFAJoB3kePyTMUeR6XLxDnNsSj
 n45pKnIL3VQcThKCJf944yRotwCK55WZJcLuRVCaO44yKNXBHiu42oqAYghl0RxusFHf
 d/h5i+dt79LG2Lldk3DWI1kZNDfGhb/n6ZBqku5DoWxX4euR7oKXzNbEqEfV19nlR7fM
 EDGZ8C71TPKbC03fXBj/kqQf0D35nMx4+tD+TyDWAQEX5YEmjuwYqHpbTvqs2IlHTgPt
 FS1A==
X-Gm-Message-State: AFuF++kOG+zmwM0vZdkfHuPDcyicnCOiZRdCfc/Kxtvj8RLIb5h8/pvz
 4mARcpEucdGPYKSC0s23AkM3iPX0+gxC/bw99d501X4dkrSQn/6gSSUKma6fBungCDL5IZP+qGd
 J/BuZJxhHl77U0amp3VRAdLzBLsYuPP2HRRM9xrxeq0Kv6lBr5k79y9T8qERoCqztkRk/IxSTZt
 p4qliRhhEjExUw9zzIXePkCA123BhhETXwdA0W8xM/w2hdf95Zh874AarZ2DaQEQ7w2RHwI+8yf
 mqsAwvZE3wG
X-Gm-Gg: AYBFou23VREFtofhICqguU9Atwf3JjSBwpVZHVKNUeGbnkUbijc+JRgZ+DE2py7JvXM
 mGuPBZVE8pUisrYXBfwrZINGwaFys91JBZfeRygxOcXjLYnDP/cqynL9GiptdOLeLVG3rUUlZ9E
 KYq6Cgwotpyw7v5oDEuYil5U3wEwBn4zZBrHLT9hjnyNo5nuW9Q0vleEJ1JPlsAIMAzXmacVKSC
 MyPf4xTKnXYdLfarefyvfoM1OrkO6Gg4th+o2dTGEgSFq5D1De9o4N1CAV0ogShK3N+a/WD6RGY
 RCi6/Ml5TWe7NnLa7y1cCDLgY5oEO1kcgsdi3/05v5wRrIg/RREa9SrXbdv2ThNahGHffLdkz06
 bLfff93thU0Bl+DsPXPeX7UomYQ+mVLfJni2scnbDO104z1MdH6N334t10TgV8Cy6r/YKn/3GJa
 VDxy2M5UEfnqkkuFQgbvl9J0htpST7h4tBR05uxxKG84j4y8nuZQ==
X-Received: by 2002:a17:90b:2b8e:b0:39d:f024:c7ee with SMTP id
 98e67ed59e1d1-39e5500a842mr14415501a91.25.1789957285073; 
 Sun, 20 Sep 2026 19:21:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a049c5697csm1019253a91.7.2026.09.20.19.21.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso2297949a12.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957283; x=1790562083; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dcTe+vAfC8bALPPPldwYdD09ACNUHl4MWrEO77q7sOg=;
 b=dLL3SoyW/ctZOc69C6m8SlusI1tC9j8sj1RzI4MZXMqcq7eyBMa4+aFS+gEKgRZHTg
 PnslOXwHZyXFApeFCnjcosF+wdhthGVt0sjwGF+J8wyjtgicWT2/X9rSqoCQ0H8/MTy6
 3oPlb9SDwX0gOUrN5xjijyokVVUi/0UqMaZ7I=
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b64 with SMTP id
 98e67ed59e1d1-39e6c6a5438mr7243522a91.46.1789957283251; 
 Sun, 20 Sep 2026 19:21:23 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b64 with SMTP id
 98e67ed59e1d1-39e6c6a5438mr7243497a91.46.1789957282657; 
 Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 5/5] net/bnxt: fix TPA agg Rx descriptor and VNIC query
 bounds
Date: Sun, 20 Sep 2026 20:24:20 -0600
Message-ID: <20260921022420.1034071-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
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

