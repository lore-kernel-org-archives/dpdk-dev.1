Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFDEEB3622
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89FDD40E4A;
	Mon,  2 Mar 2026 18:11:51 +0100 (CET)
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com
 [209.85.160.227])
 by mails.dpdk.org (Postfix) with ESMTP id D42A440E3F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:11:49 +0100 (CET)
Received: by mail-qt1-f227.google.com with SMTP id
 d75a77b69052e-5069b3e0c66so79343041cf.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471509; x=1773076309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hVmbnyO1dfZsO5EzEpEwEXNSVnWx49U1Mf387zwh+VQ=;
 b=RXFr42jNs5tEjv073IZo8W6+jRyGF0fLvwowFdoRoLZqJBLqZajd6nQ9qDi5aTmPdx
 UtqYKa0I6gGeepEeYyZHj38rmxtJLGJPeeD/2t8F9qsIE2IGlYD9XS953/OYPTHRO4HI
 uVKXNf8uMtccE6NxzFHpwu/ymCV6naV3YriJ+QdI3dVYl42knpC4Mzzk6ExqSo5aKrr5
 vPY4JJSI+0Xk3t+YwhdjyTHTLqOownLwlUs/amTsBm1MKigUlMnU0pibhca1ucHEiU+m
 5DoJADcYLwI8gmuT7q8F5ArrW0Tx27RjYF3lGjT+PrdRmNvXGXPxsectnfvFp3z/cWMw
 vjHQ==
X-Gm-Message-State: AOJu0YxRk9UuHdyBudLx16wOQC9IP15t+gqHAz7EJCVvp1MyDdN+4HXE
 rx3wM1HtuDadCzJBzIZcwwEBBMt808+ppEO6uMuPESMDuForwwR/Hxhrpjxj0wjcYkTeBSbOa1z
 TGYPaCq/7vgxbLqvinh/ranoUHm0j/0WvFZ4pU2ky0tCSCNUgjOXQQ868RSmDSYnWvEPGzLpCX0
 IKXFw5ccMaTbLBxM9p8AD6WZiOccnMskKNmS/oK8ETdK4ob3pmrkULePJgabyglZN6mj0L8S0Zf
 O2JLoEKfPUh
X-Gm-Gg: ATEYQzx7srPe1b68eaZDWF32U2W5uDBXZOMCrglPWA4aNYVBp1Etf0YoSfFQN399OAp
 aDgrzNlNlhl5LboA1Yy6eiBnuLKh3/S2pbzKjK1kOF4E5j4FndnIjcEuXHY+JUr64abMbg14QbO
 9Cqrl6QPJWnBj6ecpbJsXo4+HKSEp3awjXJ+manea4aMoe8To4TTHxCKori+PIBGt5al8Hhe6/3
 qWLVw493Kl2qf7zfdHtVMJ4kQpwieLpliki82LsEMHUHQOwGulps1v7mN6iNQ+1XLbpd06EK/Co
 7miVCPlQ8uprclwOw/Msf5r+N0MBpaxxMH6esmO6hgdVeYNud0GgOb1f47QijBlz5Mk/PSCN0Xr
 bJgnRaRFTfZWJ4tz54HGghHlXHL7ok51XFzH4dONfG26IjUZ+ilYX/aegdTyN3vQ3lXhIlCqtsU
 Yafvx5JHkzxZdKhbl09dnDprOGV/5nJh7pOIrPSLLNRsccGobAt6g/d2ehFVB+jwT6zE2b/iTeg
 Q==
X-Received: by 2002:ac8:5d07:0:b0:501:4c42:ee15 with SMTP id
 d75a77b69052e-5074433e728mr208583191cf.1.1772471508865; 
 Mon, 02 Mar 2026 09:11:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-899ec546d4esm7428966d6.15.2026.03.02.09.11.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:11:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-127876be621so2805526c88.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772471507; x=1773076307; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVmbnyO1dfZsO5EzEpEwEXNSVnWx49U1Mf387zwh+VQ=;
 b=S/xN29DB2DPprIVwcB+DbnOH83/u4s7qSvFmp2UYN1Ylp/Si+x9atf34KsmgBTRAZY
 LJ8ZSvJuuLqVJGjrpn0VaTLvKX0s7O7rvEnpoaKZPow81UpL6iuvxjynRwum1UD0poWz
 W1QCrnD9fZdf+FuEPD1g2JklwlPu+kihIEaao=
X-Received: by 2002:a05:7022:49b:b0:124:9acd:3160 with SMTP id
 a92af1059eb24-12788fe1836mr6343789c88.0.1772471507453; 
 Mon, 02 Mar 2026 09:11:47 -0800 (PST)
X-Received: by 2002:a05:7022:49b:b0:124:9acd:3160 with SMTP id
 a92af1059eb24-12788fe1836mr6343768c88.0.1772471506777; 
 Mon, 02 Mar 2026 09:11:46 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm13910511c88.0.2026.03.02.09.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:11:46 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 3/4] net/bnxt: support timestamp parsing in Tx
Date: Mon,  2 Mar 2026 10:12:35 -0700
Message-ID: <20260302171236.98625-4-Mohammad-Shuab.Siddique@broadcom.com>
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

Support timestamp parsing in Tx completions.
Check the mbuf ol_flags to see if a PTP packet is being transmitted.
Set the request for timestamp in the Tx descriptor.

If the port transmits a PTP packet, the hardware will capture the
timestamp at the time of the transmit and indicate it in the Tx
completion on the corresponding Tx ring.

Parse the timestamp info from the Tx completion entry and cache it
for indicating to the application when needed.

Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 23 +++++++++++++++++++++++
 drivers/net/bnxt/bnxt_txq.c    |  6 ++++++
 drivers/net/bnxt/bnxt_txq.h    |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index c75cd05d99..6f962f8b73 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1827,6 +1827,8 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	struct rte_eth_link *link = &eth_dev->data->dev_link;
 	int vlan_mask = 0;
 	int rc, retry_cnt = BNXT_IF_CHANGE_RETRY_COUNT;
+	struct bnxt_tx_queue *txq;
+	uint16_t queue_idx;
 
 	if (bp->rx_cp_nr_rings > RTE_ETHDEV_QUEUE_STAT_CNTRS)
 		PMD_DRV_LOG_LINE(ERR,
@@ -1910,6 +1912,27 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp))
 		bnxt_schedule_ptp_alarm(bp);
 
+	/* There are a few conditions for which fast free is not supported.
+	 * PTP can be enabled/disabled without restarting some programs.
+	 */
+	for (queue_idx = 0; queue_idx < bp->tx_nr_rings; queue_idx++) {
+		txq = eth_dev->data->tx_queues[queue_idx];
+		if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp) || bp->ieee_1588) {
+			txq->offloads &= ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+			if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp) || bp->ieee_1588)
+				txq->tx_free_thresh = RTE_BNXT_MIN_TX_BURST;
+			else
+				txq->tx_free_thresh =
+					RTE_MIN(rte_align32pow2(txq->nb_tx_desc) / 4,
+						RTE_BNXT_MAX_TX_BURST);
+		} else {
+			txq->offloads |= RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+			txq->tx_free_thresh =
+				RTE_MIN(rte_align32pow2(txq->nb_tx_desc) / 4,
+					RTE_BNXT_MAX_TX_BURST);
+		}
+	}
+
 	return 0;
 
 error:
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 3938ebc709..7752f06eb7 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -172,8 +172,14 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_free_thresh =
 		RTE_MIN(rte_align32pow2(nb_desc) / 4, RTE_BNXT_MAX_TX_BURST);
+	/* For PTP packets, process the completion sooner */
+	if (bp->ptp_cfg != NULL)
+		txq->tx_free_thresh = RTE_BNXT_MIN_TX_BURST;
 	txq->offloads = eth_dev->data->dev_conf.txmode.offloads |
 			tx_conf->offloads;
+	/* mbuf fast free not supported for the following. Reset the bit */
+	if (bp->ieee_1588)
+		txq->offloads &= ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
diff --git a/drivers/net/bnxt/bnxt_txq.h b/drivers/net/bnxt/bnxt_txq.h
index 69652bbaaa..ac8af91c57 100644
--- a/drivers/net/bnxt/bnxt_txq.h
+++ b/drivers/net/bnxt/bnxt_txq.h
@@ -8,6 +8,7 @@
 
 /* Maximum transmit burst for vector mode.  */
 #define RTE_BNXT_MAX_TX_BURST		64U
+#define RTE_BNXT_MIN_TX_BURST		1U
 
 struct bnxt_tx_ring_info;
 struct bnxt_cp_ring_info;
-- 
2.47.3

