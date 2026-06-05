Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF8CD6E75
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6834C409FA;
	Fri,  5 Jun 2026 02:48:39 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 642434066E
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:35 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2bf237e1433so15822555ad.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620514; x=1781225314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tR5zNkq+YwKoXwxEDX+sNngYrhum1EhmHQXLnwNfOPk=;
 b=rrfSLmx62ukjPqsCmEKTSuPu3aQJWG+AzzgJFaKY6xhyh/KGLrfF/EkyYx7PrUn0g5
 84TNuez32Tk/Jd7era761pR5WRDXbSk/py4WwXrTIhrXXBym62sMcpUV2nkUdaFsSpj7
 8+3ZeAi2UV+6pQnXMnn3Txibq4Tzo6bkR64SacZhW0RII5omoC/H0gTmy2U4GMMaCzbd
 VsAm1t5gIopASitFvystEfTjHguSkMxNDuBbFAJfQYp+6m2SgK6LZdFSWEc+LvT3bUTu
 H7SFa5cnKc5jig0ebAMweFb7pv79yTS7cqiCZ5wGF2JvmHKwCq1FDS0YX6tr4uuqNfFF
 z9Qg==
X-Gm-Message-State: AOJu0Ywb9V7rNo0R3tsNjw+1i64gKoiz6AWBfL8QLo5FRvUEzG2jNa1j
 mL/4dVremHn1WUR56VUfNi5GfpVQcbtG2euSo+rU1EcLlk0vWHZWWMCxxO9spZQFs3rGvLJNEI1
 TAKzlRYW0MPDUwEy/5MqDOJD1joT0V2iAkoe3xvveInJfvm8dHi+abIM9eoOMKZfgFw/5KDmCmz
 JwODYg5kb+v0GPWtpxZ01C8Bemh4qEs2GXh7wY+nXCtGcqVIw8pqagKg+eCN6jweNujLSgaZw74
 DYiCcTGZ7hp
X-Gm-Gg: Acq92OFlkuvqxu0J0/lq/ACW8JiDEVY//dkZA3nbbCk8T92ZYp1sim4c+i4AkUb6/0b
 Tif2IPUYE4XUdcdV12bSFXjmO2d6OdCuXP186UpAN9DLSv3xUg3myeHEbK2i268EEJRtt1LXmf1
 ke2ABStlaSrVxiV34Zja19DALJuzhKtU+PTFFjlSmE5cp1TN0rOzz1hOUWgn4YuhaJfW2hlwq0C
 o35eXEZfZFIqgT19lZdsyTI3PZlBBNY/Ohf1EPOaDYouKBW7TdS4bRQShs/55CZoq7crpVGkkbL
 pCeDe1gMR7hDiPkV0LNWamS9z0GlE+YLDLUKlOjML+KAOZHoaSH3OWFXKkm7s4T1oQgVoEGuKDl
 7gmBcJABMS3EuzTkJybU4C9h5LvsAbqE1ktsBQ3Flkn7fFLdbMD/K2JuULiY6qFCnlWzk/iRCJ1
 L2FsXa0cbcEkoun0E0Ib4YSQcCOi65xg==
X-Received: by 2002:a17:903:f8b:b0:2c0:cf44:3b3b with SMTP id
 d9443c01a7336-2c1e847d71dmr10186195ad.24.1780620514495; 
 Thu, 04 Jun 2026 17:48:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164f88df8sm6653785ad.14.2026.06.04.17.48.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccd3213beaso27430146d6.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620513; x=1781225313; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tR5zNkq+YwKoXwxEDX+sNngYrhum1EhmHQXLnwNfOPk=;
 b=YWqTb3GufDfQgLMBLgNLpFi0it9qUidPJgPkTR4aGOGCqmD6grNqtRvkQ3C7OMa+4B
 Xib7G/HutRMJInZaL1aHXsA2DII+MUnoNgIOsgY+0LsXIf5jBoCHxAmhkKsX1/VUOqu9
 rihcTjHgZ44+vA8qB1bN2nCwBQaCwzzSo1vZ0=
X-Received: by 2002:a05:6214:1d2d:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8cee62654ffmr26473726d6.24.1780620513409; 
 Thu, 04 Jun 2026 17:48:33 -0700 (PDT)
X-Received: by 2002:a05:6214:1d2d:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8cee62654ffmr26473236d6.24.1780620512753; 
 Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 5/5] net/bnxt: fix for segmentation fault that would occur
 on exit
Date: Thu,  4 Jun 2026 18:50:16 -0600
Message-ID: <20260605005016.2290160-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

When exiting dpdk while having still having members in a bonded
port, the program would experience a segmentation fault due to the
bonding driver relying on the ethdev driver to free the rx and tx
queues of the bond members. The member ports would then try and
close using the bnxt driver, which would then try and access memory
freed by the ethdev driver causing the seen issue. The bnxt stuct's
rx and tx queues pointers would still point to the freed memory,
while the ethdev pointer would reflect the status changes to the rx
and tx queues array and be nulled.
- Changed net/bnxt/bnxt_stats.c and net/bnxt/bnxt_rxr.c to check
that the rx queues had not already been freed by the ethdev driver
and changed net/bnxt/bnxt_stats.c and net/bnxt/bnxt_txr.c to check
that the tx queues had not already been freed by the ethdev driver.

Fixes: 898248fc4287 ("net/bnxt: support statistics query when port is stopped")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c   |  2 +-
 drivers/net/bnxt/bnxt_stats.c | 17 +++++++++++------
 drivers/net/bnxt/bnxt_txr.c   |  3 +++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 293b5c03b6..ab2175d21a 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1491,7 +1491,7 @@ void bnxt_free_rx_rings(struct bnxt *bp)
 	int i;
 	struct bnxt_rx_queue *rxq;
 
-	if (!bp->rx_queues)
+	if (!bp->rx_queues || !bp->eth_dev->data->rx_queues)
 		return;
 
 	for (i = 0; i < (int)bp->rx_nr_rings; i++) {
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 7b96cf0df9..49367588e4 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -547,15 +547,20 @@ void bnxt_free_stats(struct bnxt *bp)
 {
 	int i;
 
-	for (i = 0; i < (int)bp->tx_cp_nr_rings; i++) {
-		struct bnxt_tx_queue *txq = bp->tx_queues[i];
+	if (bp->tx_queues && bp->eth_dev->data->tx_queues) {
+		for (i = 0; i < (int)bp->tx_cp_nr_rings; i++) {
+			struct bnxt_tx_queue *txq = bp->tx_queues[i];
 
-		bnxt_free_txq_stats(txq);
+			bnxt_free_txq_stats(txq);
+		}
 	}
-	for (i = 0; i < (int)bp->rx_cp_nr_rings; i++) {
-		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
 
-		bnxt_free_rxq_stats(rxq);
+	if (bp->rx_queues && bp->eth_dev->data->rx_queues) {
+		for (i = 0; i < (int)bp->rx_cp_nr_rings; i++) {
+			struct bnxt_rx_queue *rxq = bp->rx_queues[i];
+
+			bnxt_free_rxq_stats(rxq);
+		}
 	}
 }
 
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 83d18e220b..d37a38735c 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -24,6 +24,9 @@ void bnxt_free_tx_rings(struct bnxt *bp)
 {
 	int i;
 
+	if (!bp->tx_queues || !bp->eth_dev->data->tx_queues)
+		return;
+
 	for (i = 0; i < (int)bp->tx_nr_rings; i++) {
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 
-- 
2.47.3

