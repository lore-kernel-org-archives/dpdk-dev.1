Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4CCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:12:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64B8340A71;
	Wed,  3 Jun 2026 23:12:07 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 38ADA40A6F
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:12:05 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-36d5fd50d20so3536734a91.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521124; x=1781125924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tR5zNkq+YwKoXwxEDX+sNngYrhum1EhmHQXLnwNfOPk=;
 b=XL+HnUkx4S+Z7OXupsGCVMkNk5ZAtXwrzv8rLDDKdsxEU4wroA+FjQYPs9nO8sJm9r
 9K4uetvS8lX/jEq2koAImRnMWvfxm6CNpZSgx9I+tOxqDGtKTXxNgu9LZKxUxyq6Ef2K
 NcloD1h8Cfdgu1o44Trt4X6gGcEeCfqQYHiCgbFyxaBqgrJTZ2LAGylRbRoK8om7AHjl
 Q94PghaNSNzK8IsyHjcSNUkSUW1BPQJS0s7/FdRIXk8dJ3zM8d87qKdecQthvjHbIac2
 ohhbJ9MD7rPGDy3/CHOqGXqWcsW//8qUiB3KnbhHcVPv42Y2AvJyhA2p7KcNvS7cKF9O
 uIaA==
X-Gm-Message-State: AOJu0YwiQmXgatoFLz7kDqYn47uLSqZhWrFE6VK7YryzVJ4HDPOrjfug
 EeX848cE+GmI93+7TcgdhYrcTdQeI0TMXn6w7MiFdsNM6fAnHd8dB4bBTIqYw/tSpBZ5DG4Wwy7
 G+xUHowgRGhbOPRis+DAgmN109F4xiWG162+9r26OJ47hOLgrJ3eRMZGZL7M9xQEJHIOtfqNgb/
 ki937bNS2Vn8O5WTaj+cu005LXNCpthS2tG/Y/5mspoY+fL0L7wjEkDMATWHAO0ZO5GHraEUaTv
 L9M4gHMFMeJ
X-Gm-Gg: Acq92OF9SXkj+s5VA1X11dtRIHb3lkfwH3fgdC/SaX0euVSykg5Bd7ssgdYWWu2VS5L
 x4gvB4DF11DcTI8XIqwmE59NUI76+/aUrug4uVcDPQt/NErMEeNg87X68bYjPNsage49HUO0l13
 wTkVYBstC6DDSlDFe4o92RdxeU7Tl2ip2HxI+RmYb0O7LUJSJR1tNN8YYYw3+EwcTqa2R2FLTlb
 UgvDfS+UtjNVSVHyCTl9L52qrlMNZyWp9av/0nJJioKOOVSiXYWPW5ZkTs/JjUtdTwmEnhTxEIK
 tZK1XQfjV0PJ+wud19v8S9hhna95LJ0GFAWHFfNWbAj42nA69CQSO85nXAf77shhL11kQJBaJEV
 YLPENZSVNEiON959EpYZjcXFh9+0m46rY3kzetMIATgof9ORdavfSio50/RMtXNUDkBFldvpFYT
 beLxyLJvB8eQVzVbZLlaHNd5FAaFFkdKAUL+oXtkCLQlsykfjtUpbpVN6EjK1L4IE5SfXFNKkiR
 e7I/vyyaA==
X-Received: by 2002:a17:90b:4f81:b0:366:1172:597e with SMTP id
 98e67ed59e1d1-36e32a42cb0mr4474301a91.9.1780521124322; 
 Wed, 03 Jun 2026 14:12:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36f6c46dd84sm80337a91.1.2026.06.03.14.12.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:12:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd51bc2f5so165154646d6.2
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521123; x=1781125923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tR5zNkq+YwKoXwxEDX+sNngYrhum1EhmHQXLnwNfOPk=;
 b=S4sq7eOx1u4emw/Y7MNQIkWW01wvR/uSpHO/fVLKSV2JgWSH9mkf1KxqhbZvpHVLza
 JS4cFDHv2N08XF5sMLGGmEWTXaCNqRe7tl562cMkSaZ8i0/pCfaA9/PY18o3VTNW3zeN
 SqdD910EikxeMc9S3NmO3pUywRM44C/gpTUTg=
X-Received: by 2002:ac8:5704:0:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-5177e26646dmr56444281cf.39.1780521123369; 
 Wed, 03 Jun 2026 14:12:03 -0700 (PDT)
X-Received: by 2002:ac8:5704:0:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-5177e26646dmr56443511cf.39.1780521122681; 
 Wed, 03 Jun 2026 14:12:02 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:12:01 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 5/5] net/bnxt: fix for segmentation fault that would occur on
 exit
Date: Wed,  3 Jun 2026 15:13:41 -0600
Message-ID: <20260603211341.2112344-6-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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

