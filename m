Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C22E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9650440608;
	Wed, 18 Feb 2026 17:43:30 +0100 (CET)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5C97A4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:43:29 +0100 (CET)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-45f0b597eb4so3115749b6e.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771433008;
 x=1772037808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+t8nlRwrEdKLy3OyoJT/mgWMhFX+uUPFpXg6LiJCQKM=;
 b=Qm4Pzh/lnwNjlxfO7yTuPdMUaP256DkwUDACCjp7MuQGwimYGDvn3znzwPW8pBN3it
 rhcSAXU87cYrwlgpdfzdqAunFuSlSnsHOwXyWdFyIxAc++LBSHP6YF1BZxklv7aPSYvq
 vZOC5aszVcSPj2cBLwOTBdTTXsLbBYcqTiyfFVHsTynKH1i4OFTZjBuoNXHpYsBpmWCI
 SHA6W9o95S3QsY9oXiPo+oQ5mWkD51UnzOivpaP/jqN8Lfn5bi935lTOZXxDNvG15V9c
 ECGLmmveRfjm3QHSkbuzAzkyVbaHHXXu8diSqGmVp/ia/suWx6yyOjWRuPFQR8aoKKSX
 J01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433008; x=1772037808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+t8nlRwrEdKLy3OyoJT/mgWMhFX+uUPFpXg6LiJCQKM=;
 b=p5nNsNfSs7QiI1k+2oeRRWAVAEqEul2kvXgFjh7gYmfkWktckBJi25kvlrzxuP7v0J
 De3ZAudHMvhW3K214KRAAzZjnf2w32yKGAR1MqH1VTxuDCATo8oZ/Xj4c8ycCHpOfx53
 g/qrkARA3g+Tl5hIdt7rWsQcyQYEB+mL5MxFYcLHkt6Bnw+eEIM8Pl0K/TWZG69SQyMz
 KyCF8i+GszvU+ICDzi8CXS2nXPZ+J6eHHECyAmHwv7mhpcM3Sy9u04zmMXuRtmlIqak4
 Si52WZHXDwm7lbjjrffVryGhwVFf+Al/SI80RmMM+i2KbhpP2dIGg793hQ4wUeEhxHnd
 W7qA==
X-Gm-Message-State: AOJu0YxbbJy6k3PZDhuVdRVsoPklwvL3Mfa2D3uXwpPnyMX1cGCWS8em
 wwNG6w7QhuR99+luwiT2EerJo/Bl5obqqD9yKuqiXkP0yFjVQZKIr7ru0wopsaj9p6EOdgHmUPH
 G1CnX
X-Gm-Gg: AZuq6aL0rxPTEAiEHu/whtcLA8qitPpGvBcuaBo/MmwejYxPTkWFWsO6fdJcNyHE1Jv
 jPPkOLNbzeEqVhWSsmCF/YZMZXML1T42aLcV0u1rzqf4dnnurwNT/yJFgKZdr3SQqVTr3ZKDzjo
 JIu9M2rr28YRRWrMXw5Ezx8CbwkReZIs0eSDX5AWZoVscQkSLy3H8n/Rc/NSImzVpLY9gK1JkQD
 ZRfugfAytwk+M8vCU+M59inqCq6r4cNbd9/imTgfnF4df6UB9rZNQTqrrWoy2zBBbJ17zfhfqD8
 zxI7grQ96YIWmY5c/bfMHirXsmItnaz1cxnQ6l5v0Am0dS5WfvlPg+z9m+hhtuMhN4MaE8iu4nm
 A+RNMBbyj+zlpqhlebJuZ10n+PtaU/RsCnu+N984oWlOdXdjOuY3onrm30pYhys45iRLXJhgEns
 WgzrpeBkx8ecNC9wFEvybaHLLj8kpPtHsi75f8RzQ/JFxfRw1AhHQkntWNZqxKsg==
X-Received: by 2002:a05:6808:1a12:b0:45e:f0af:a294 with SMTP id
 5614622812f47-46410b46abamr1210141b6e.12.1771433008522; 
 Wed, 18 Feb 2026 08:43:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c6727752sm12878313a34.23.2026.02.18.08.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:43:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH 1/4] net/axgbe: fix resource leaks in device init error paths
Date: Wed, 18 Feb 2026 08:40:59 -0800
Message-ID: <20260218164324.915065-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

Several error paths in eth_axgbe_dev_init() fail to release
previously allocated resources:

 - When hash_mac_addrs allocation fails, mac_addrs is leaked.
 - When phy_init() fails, hash_mac_addrs is leaked.
 - The return value of rte_intr_callback_register() is not
   checked, so a failure leaves the driver without interrupt
   handling but continuing as if everything is functional.
 - When the DMA software reset via hw_if.exit() fails, the
   error is only logged and initialization continues with the
   hardware in an undefined state.

Fix all error paths to properly clean up previously allocated
resources, check the interrupt registration return value, and
propagate the DMA reset failure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cfcd880961..709a52acc8 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2359,6 +2359,8 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 		PMD_INIT_LOG(ERR,
 			     "Failed to allocate %d bytes needed to "
 			     "store MAC addresses", len);
+		rte_free(eth_dev->data->mac_addrs);
+		eth_dev->data->mac_addrs = NULL;
 		return -ENOMEM;
 	}
 
@@ -2405,8 +2407,14 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 					  pdata->vdata->rx_max_fifo_size);
 	/* Issue software reset to DMA */
 	ret = pdata->hw_if.exit(pdata);
-	if (ret)
+	if (ret) {
 		PMD_DRV_LOG_LINE(ERR, "hw_if->exit EBUSY error");
+		rte_free(eth_dev->data->hash_mac_addrs);
+		eth_dev->data->hash_mac_addrs = NULL;
+		rte_free(eth_dev->data->mac_addrs);
+		eth_dev->data->mac_addrs = NULL;
+		return ret;
+	}
 
 	/* Set default configuration data */
 	axgbe_default_config(pdata);
@@ -2426,14 +2434,23 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 
 	ret = pdata->phy_if.phy_init(pdata);
 	if (ret) {
+		rte_free(eth_dev->data->hash_mac_addrs);
+		eth_dev->data->hash_mac_addrs = NULL;
 		rte_free(eth_dev->data->mac_addrs);
 		eth_dev->data->mac_addrs = NULL;
 		return ret;
 	}
 
-	rte_intr_callback_register(pci_dev->intr_handle,
+	ret = rte_intr_callback_register(pci_dev->intr_handle,
 				   axgbe_dev_interrupt_handler,
 				   (void *)eth_dev);
+	if (ret) {
+		rte_free(eth_dev->data->hash_mac_addrs);
+		eth_dev->data->hash_mac_addrs = NULL;
+		rte_free(eth_dev->data->mac_addrs);
+		eth_dev->data->mac_addrs = NULL;
+		return ret;
+	}
 	PMD_INIT_LOG(DEBUG, "port %d vendorID=0x%x deviceID=0x%x",
 		     eth_dev->data->port_id, pci_dev->id.vendor_id,
 		     pci_dev->id.device_id);
-- 
2.51.0

