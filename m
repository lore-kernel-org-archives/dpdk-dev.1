Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD568C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B09C40B8D;
	Fri, 25 Sep 2026 09:09:57 +0200 (CEST)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com
 [74.125.230.76]) by mails.dpdk.org (Postfix) with ESMTP id CA1244026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 19:51:41 +0200 (CEST)
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a47f740839so42621fa.2
 for <dev@dpdk.org>; Thu, 24 Sep 2026 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790272301; x=1790877101; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NApvt+nZEPTsIUVCjIdIvYgxFTj36kaWPmB+n72AQpU=;
 b=IhiCzjOWFuKwsJyGsAGm6xD+rvK+S6C+GK9cRoDEN1534ujVAi2uzn+4eUOcoZkFaC
 8vY1qf5nMsBPx2MsgXpURI8hDLQvxIdSbO5xUwjG+YR6LiC4VHMKZCyX0MLeZYJKaVDo
 zLXibYC4IeOPe9L+2igt0Wxxhc1UcUvGgQyQdzWc07uBBXt6roeIimove3msR876KKmE
 /boQ4/MzJhzUM9N3nIwOWNuABiGDndd+2L0spCGPBd1ETXKPq9p5zAcm8cwFZ5FItwn9
 X0+qkycBu+WzIrZKAWEy0xs2Utmpx3C56GvVTwDAQLRAwL4RD3fwN3ACGgI/zuFu+5w9
 MmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790272301; x=1790877101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NApvt+nZEPTsIUVCjIdIvYgxFTj36kaWPmB+n72AQpU=;
 b=PDQpPZibeUFc4gCVZQrs/lX04GYnkljBa5sXdoKwK98eTXkXpMVxzt0OKZTIeNta9W
 /7JxGzJakEd1Ofg6d4Ao838/e/M6Xs2RUKNdGLm8hCpYAReCQCFn5bR9xNw3UigNrB4W
 8uV/EqpvgMBCNDH9zjnHjzEHryhxYgJ4CLuOiXt2mWhypLHbEhjvuzNF7JgeCdsc3IOM
 w/s/PSs9E5JP9w6TJkB+ifG0rYd85xDpjUBXrBBIv1gaUPa4u0v8OlElnGlfJkaLKoRX
 uYVHBPyH4rx5FRQkW2bBcKiD1+TTy4EJfEO+TrrXfTd2vCmaaGtn6rxXNWfytmilMMBd
 DpIg==
X-Gm-Message-State: AFuF++kk8Qui5ZjnTG3eR+QsuWO7QKuXzZ0OJJUOh6loLQM8iyNkgkfZ
 bLDZ8RrwMdPojvuOYcmHyatvN2v32tKWbh00edzEg7uddV1+BKuyJxh8
X-Gm-Gg: AYBFou1qrtayulIG0Z1DQx9cvF0FnyQqNN3lmYKdoyGJVlKXJtQC23omt3IeOhIRHQg
 kY6hoz0YcJDnAz7hn5kxOjKnTdfyEvLmR9mmvbIDtG9wLi1huEoKkD/19pYwVT8M+kn7HQHfYJ8
 iltiB25LSnGA0V8jszGfWtWxUST3hrx9Uiw1Mkq0nv3atcNnqzoRTBjCUMAINIda7KV5Th8wJHe
 QNIWxoHBkX+KBP1hSpQqAwLvyfDkVr0zMoGIjPLJdPV29Ajf8TknoS3zYyfJxyyCINkx5YTF47Q
 blVNn/Sh8wBtt0RJFu/v3e0lgPyVPz1RJxDCZ9VsDH48ZDamM8/M70zBD8iC6pM2p596wJ10OPF
 pQvthFdYc2DX2rDrxC9lcQMlBVgW2znPu0bFrNB+10/qNbKuak2ZJBi/numD7V6ZWl3WhUmvjhJ
 m0WwNa5MlEaa1XYFIeCD/blPK9dsT2KBwBqTlW4c0kA1LVhqLR0UUCBhKEnGXEe9YM1Q==
X-Received: by 2002:a2e:a985:0:b0:3a6:3074:1226 with SMTP id
 38308e7fff4ca-3a63dd87232mr6313151fa.8.1790272300654; 
 Thu, 24 Sep 2026 10:51:40 -0700 (PDT)
Received: from fedora ([185.61.79.67]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bdbc54bsm9454001fa.4.2026.09.24.10.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 10:51:40 -0700 (PDT)
From: Omar Munchaev <omarmunchaev@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Omar Munchaev <omarmunchaev@gmail.com>
Subject: [PATCH] net/ice cast rx_flex_ring to proper type
Date: Thu, 24 Sep 2026 20:51:26 +0300
Message-ID: <20260924175127.375701-1-omarmunchaev@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 09:09:55 +0200
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

its look like, that some parts of fdir code was not updated with new
generic ci_rx_flex_desc. This patch fixes it
Also im found out more verbose logs for ice_check_fdir_programming_status
in linux driver implementation in function ice_vf_verify_rx_desc:
https://github.com/intel/ethernet-linux-ice/blob/e4a92b1e84e084bc599580d065020986e501b8ad/src/ice_virtchnl_fdir.c#L3513

Signed-off-by: Omar Munchaev <omarmunchaev@gmail.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 46 +++++++++++++-------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..5ab58c8575 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2698,7 +2698,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 	}
 
 	/* Allocate RX hardware ring descriptors. */
-	ring_size = sizeof(union ice_32byte_rx_desc) * ICE_FDIR_NUM_RX_DESC;
+	ring_size = sizeof(union ci_rx_flex_desc) * ICE_FDIR_NUM_RX_DESC;
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 
 	rz = rte_eth_dma_zone_reserve(dev, "fdir_rx_ring",
@@ -2718,7 +2718,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 
 	rxq->rx_ring_phys_addr = rz->iova;
 	memset(rz->addr, 0, ICE_FDIR_NUM_RX_DESC *
-	       sizeof(union ice_32byte_rx_desc));
+	       sizeof(union ci_rx_flex_desc));
 	rxq->rx_flex_ring = (union ci_rx_flex_desc *)rz->addr;
 
 	/*
@@ -4464,40 +4464,33 @@ ice_set_default_ptype_table(struct rte_eth_dev *dev)
 static inline int
 ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
-	volatile union ice_32byte_rx_desc *rxdp;
-	uint64_t qword1;
-	uint32_t rx_status;
-	uint32_t error;
-	uint32_t id;
+	volatile union ci_rx_flex_desc *rxdp;
+	uint32_t stat_err, error, id;
 	int ret = -EAGAIN;
 
-	rxdp = (volatile union ice_32byte_rx_desc *)&rxq->rx_flex_ring[rxq->rx_tail];
-	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
-	rx_status = (qword1 & ICE_RXD_QW1_STATUS_M)
-			>> ICE_RXD_QW1_STATUS_S;
+	rxdp = &rxq->rx_flex_ring[rxq->rx_tail];
+	stat_err = rte_le_to_cpu_16(rxdp->wb.status_error0);
 
-	if (rx_status & (1 << ICE_RX_DESC_STATUS_DD_S)) {
+	if (FIELD_GET(ICE_FXD_FLTR_WB_QW1_DD_M, stat_err) == ICE_FXD_FLTR_WB_QW1_DD_YES) {
 		ret = 0;
-		error = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_S;
-		id = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_PROGID_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_PROGID_S;
-		if (error) {
-			if (id == ICE_RX_PROG_STATUS_DESC_WB_QW1_PROG_ADD)
-				PMD_DRV_LOG(ERR, "Failed to add FDIR rule.");
-			else if (id == ICE_RX_PROG_STATUS_DESC_WB_QW1_PROG_DEL)
-				PMD_DRV_LOG(ERR, "Failed to remove FDIR rule.");
+		id = FIELD_GET(ICE_FXD_FLTR_WB_QW1_PROG_ID_M, stat_err);
+		error = FIELD_GET(ICE_FXD_FLTR_WB_QW1_FAIL_M, stat_err);
+		if (error == ICE_FXD_FLTR_WB_QW1_FAIL_YES) {
+			if (id == ICE_FXD_FLTR_WB_QW1_PROG_ADD)
+				PMD_DRV_LOG(ERR, "Failed to add FDIR rule due to no space in the table");
+			else
+				PMD_DRV_LOG(ERR, "Failed to remove FDIR rule, attempt to remove non-existent entry");
 			ret = -EINVAL;
 			goto err;
 		}
-		error = (qword1 & ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_PROF_M) >>
-			ICE_RX_PROG_STATUS_DESC_WB_QW1_FAIL_PROF_S;
-		if (error) {
-			PMD_DRV_LOG(ERR, "Failed to create FDIR profile.");
+		error = FIELD_GET(ICE_FXD_FLTR_WB_QW1_FAIL_PROF_M, stat_err);
+		if (error == ICE_FXD_FLTR_WB_QW1_FAIL_PROF_YES) {
+			PMD_DRV_LOG(ERR, "Profile matching error");
 			ret = -EINVAL;
+			goto err;
 		}
 err:
-		rxdp->wb.qword1.status_error_len = 0;
+		rxdp->wb.status_error0 = 0;
 		rxq->rx_tail++;
 		if (unlikely(rxq->rx_tail == rxq->nb_rx_desc))
 			rxq->rx_tail = 0;
@@ -4506,7 +4499,6 @@ ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 		else
 			ICE_PCI_REG_WRITE(rxq->qrx_tail, rxq->rx_tail - 1);
 	}
-
 	return ret;
 }
 
-- 
2.54.0

