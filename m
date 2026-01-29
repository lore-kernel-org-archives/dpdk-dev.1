Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE032D73E84
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD0584042C;
	Thu, 29 Jan 2026 21:26:47 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id CA92C402D3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:26:43 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso12357985e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769718403;
 x=1770323203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FbJuGUcKS3h0fvgDtfhnt+8qcQX5IMN3V8hqrNcFXw=;
 b=x1EHC1S1z/bvOsZ61UUeF5SThkMMLdk0HwnojdrZHsbmrFuXYnC7VpFYVfM2l2Dm6D
 54/PqRwEdCkBofaLAQEHMSNvxNVbC+PR8ixgwKY5tQYDg5Y/MEU1emycbw9mFX1c2a+T
 bXxXxjYAl9wijW/6bc6tzEKEXO1FeUd13Q6UqthrkscL/DYFSMPdeNv9De9CDLww/W+w
 kR3ojFzZOetAxhlZq1yjVof+GzDViGt0SS9/DRZZUQbQlTdZQy+Jeqxac6KagQS5HsWU
 Zh131gnhdR9JcdDzfClbczk9k6wQyxxh8/kDXUAtZuUR8QLz9K9R4/LSwMePMND5juQ8
 CNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718403; x=1770323203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9FbJuGUcKS3h0fvgDtfhnt+8qcQX5IMN3V8hqrNcFXw=;
 b=F+DTyzdwm+ooB/l3YeUW0rhAc9lfJnSpjiJxP/d0j3uW0PN0oeO9G9axYEALLhtmnK
 IammN0GJa5+TRpx4B7PhB9YDHzoyTAAQjnEnq4mkpRnEAjyq80vVnhqvEU0iHAF2/lLO
 Pz5wNnhXBc4my75s6dufE4bAI1NrDE42Gl3MsounWNuKOWriPLHf4W76gLseC+RTknpp
 vxA82PlrTxTxkvORdgB6Fu1E2mKOxZwSILfvq8Gjr0msAMF5R5pXtoWSvcUUuC7kOUU9
 Lb7qHIZlQLvfx8vM9zMS24V8l/byVvETePWs63vkD5ZyqkQ/LSpe3bH32+NCZRZMYIjF
 5GmA==
X-Gm-Message-State: AOJu0YxwTxrgO2K4gR+VfT+1saiQgywSeSb5p0cCO3cW/TGAxzyNPE/U
 jH2jTbfVmLId34bovdvcv6W6Q1Hw2M4lGpW2InCI0yxzs5/u1C81BXp/HiAO+j+EEbNPyJp4isZ
 IECwn
X-Gm-Gg: AZuq6aKOmkOggPkMpQev9oHNemGTw7U4PYk00MpuGVe6yaW4W1u3YqxBGU0DafAp1Vb
 zk4dMlIwUK9eiwKPQUN5jhZJaW8eR+o0hm2Qs4B3AqlXR3qgKPts3rn4hgTbuiDBE2spC1aV/UF
 L3ib2Qfx4qoOaPuKwmBfZO1B2ToiCv/LurDLFqJSdY/f6F61ToJLHVv+L4SWRueeK4nHLGOCIni
 QEAP9eFrKw4eNg3Nhjtg4aouAwzu0eWMmnIZOG3grdAXWWxKoyHVM19TfajajgqdKul+PyowgVM
 0wcLlGPG7g4Z49MgUjAG8BBj02BKA3r9wThUwTs9qI2r445dEdsziGDlEtJsMEDhOVxhfQO0gSd
 A8f4DmIUF5ugqJDxAC38tbk4JvEPxKe1aKzGpqLKac0mPZU+vIrSD4czYq/yO/V7Nl/uP/ADg+o
 mEfCkfz6gUUXeHELb5xMqKIWCrLThS3QTlkVEwNWPY2pvB89Awnw==
X-Received: by 2002:a05:600c:4e91:b0:47f:1332:e5f with SMTP id
 5b1f17b1804b1-480829b5cfamr59493065e9.12.1769718403302; 
 Thu, 29 Jan 2026 12:26:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e2ba7asm4819435e9.20.2026.01.29.12.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:26:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v9 1/5] net/null: cleanup info response
Date: Thu, 29 Jan 2026 12:25:27 -0800
Message-ID: <20260129202635.173530-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129202635.173530-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260129202635.173530-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

The null driver generates fake packets of configured packet_size.
The mbuf pool passed when setting up Rx queue must have space
to hold the requested packet size; otherwise eth_null_copy_rx()
would generate invalid mbufs.

Setting min_rx_bufsize to packet_size enables the existing
validation in rte_eth_rx_queue_setup() to reject undersized pools.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..ba87c82a73 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,17 +298,13 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
+	dev_info->min_rx_bufsize = internals->packet_size;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

