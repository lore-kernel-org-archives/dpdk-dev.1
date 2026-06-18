Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE8CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 17:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 653B64067D;
	Thu, 18 Jun 2026 19:25:53 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id BCFA24028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:25:50 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30bd47b9f0fso1361132eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781803550;
 x=1782408350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiX4clL9rLdZeQ0VBlofleoJAmVXVvFWJ69HyIxeFnY=;
 b=K4SMja0TosUI6qNed141G+NptHxFBHq0APu/ysfk+DQaUUYPJ3yjZfyBoKaG3Hxq88
 ZFrnLawH/D5o1ynzO7UHuYG3op8oMiHEuONanhFoKcA0asoHw2dVDYtAhtDZn0l83OkE
 V4e6SclQuvRncmFAtbIoi2xHXzDFABc1Ki4GQRwdQg5+jEcjuehX4qjCAWhjT8Zs3I8Y
 6n8gxIPfkvka4zfCoQt8ueZsq3TVMqpvKpc40j5TkjgRfMxqDR4TsubJlHI/FyFJZiwU
 qiYCkL/CUgURyRlWKclqpkLfXY+uq5pfOBhZWpAHSAbksw7MxKh3wjBA0uDiqvufjkJa
 fp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781803550; x=1782408350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiX4clL9rLdZeQ0VBlofleoJAmVXVvFWJ69HyIxeFnY=;
 b=MMek0dfLDWQycaRNsluz1cP+iA2QT6wl1QWgH5+UTQd8mI+IlwFx8/MYzvaD2mPLXC
 bbZBTWxasHA5NX2TLLkHolVLMrm26ddZvRVcxPbpxoBnMhUIc4EOTVCK64yPD88svod6
 ycGMRAFZpBdEzLm++qgyJm/tn6/ngobEKPp4K1mUXEAt7B9d+1wJYfr2G5M1XY7yrkEV
 E9hvi657xw6qHh3bwXgHI9EQem6SzrGs9ExGgUBf/5XofLYoaPX4dyacBJ8QwL3Eqytm
 ZvZbFrhzsHqnxR+/RyESvAYngllVTnNbgJBPXTKbyA5mcfHFCpAyMdHHKOhqHYi8Snpc
 JuHQ==
X-Gm-Message-State: AOJu0YxvEtSbX/nUpkiLS3FjH3FiTXGdjD+H/o35Nc8Wtg2F+cCPvyzt
 RXM2tem1iKhffJfaLrPuxIH6KCXiDZhPhJoT+Tw2xuNTRvxQqwGXBb12aE0IYcaGkO27aq+zvk1
 PAofX
X-Gm-Gg: AfdE7cnBC4fy1hCZicZJklecZ8YzkldCCyt5ZkcjWnFAjOej+gWx8wQxqxwcF4y1ntB
 nnI6NYvhlVMQ1bk9raomAYGu8y0fB3fJ79ZackjR00hMaateoGVwpzUFZUY+GZQUCbUsHJnOpTM
 JXwbUouVq/ohfyDCbPMsvqogQMvTdfh1Z+2XB0FsOmyzq2xXCZ9ZuGp9e0ar5CC948XntgUNioK
 CBRbewUAl3xHS1ruVCAZeTp5QA1cvmJHIBV2L6hY/LjAJnXkLuE8xIlipC7UhVdiyGy72OJFv6F
 8KDLdC8xUiAOv7KYxf4JhBdzRzFWbQMlYMyLLX4g7BkSetvw+izoNLKUERKB4VGnzZHYloFX6z2
 uLw2d8QVzxtqyupZqsMbDQOQW8U6YxWc4Fj6ZrQNyA5yYji81Omfol4CIDggPmVRMgGWDXg/TLv
 GzPubqV6pq+rcFIbtd4hHl4KuZRMbG975UB94r3AXMFyrPMAsagTI=
X-Received: by 2002:a05:7300:dc04:b0:30b:d6de:b20f with SMTP id
 5a478bee46e88-30c06d6710cmr162767eec.8.1781803549656; 
 Thu, 18 Jun 2026 10:25:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670a1b4sm122443eec.8.2026.06.18.10.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:25:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Chandubabu Namburu <chandu@amd.com>, Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v3 1/4] net/axgbe: fix resource leaks in device init error
 paths
Date: Thu, 18 Jun 2026 10:21:56 -0700
Message-ID: <20260618172544.338758-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618172544.338758-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260618172544.338758-1-stephen@networkplumber.org>
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
 - When phy_init() or the interrupt registration fails, the four
   mutexes initialized just before phy_init() are leaked.
 - The return value of rte_intr_callback_register() is not
   checked, so a failure leaves the driver without interrupt
   handling but continuing as if everything is functional.
 - When the DMA software reset via hw_if.exit() fails, the
   error is only logged and initialization continues with the
   hardware in an undefined state.

Replace the scattered cleanups with a single goto unwind so each
error path releases exactly the resources allocated up to that
point: the hw_if.exit() failure runs before the mutexes are
initialized and so skips the mutex teardown, while the phy_init()
and interrupt-registration failures destroy the mutexes as well.
Also check the interrupt registration return value and propagate
the DMA reset failure.

Fixes: e01d9b2e980b ("net/axgbe: support unicast hash table for MAC address")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 61725d55ca..415fc6d739 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2360,7 +2360,8 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 		PMD_INIT_LOG(ERR,
 			     "Failed to allocate %d bytes needed to "
 			     "store MAC addresses", len);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_mac;
 	}
 
 	if (!rte_is_valid_assigned_ether_addr(&pdata->mac_addr))
@@ -2406,8 +2407,10 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 					  pdata->vdata->rx_max_fifo_size);
 	/* Issue software reset to DMA */
 	ret = pdata->hw_if.exit(pdata);
-	if (ret)
+	if (ret) {
 		PMD_DRV_LOG_LINE(ERR, "hw_if->exit EBUSY error");
+		goto err_hash;
+	}
 
 	/* Set default configuration data */
 	axgbe_default_config(pdata);
@@ -2426,20 +2429,32 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 	rte_thread_mutex_init_shared(&pdata->phy_mutex);
 
 	ret = pdata->phy_if.phy_init(pdata);
-	if (ret) {
-		rte_free(eth_dev->data->mac_addrs);
-		eth_dev->data->mac_addrs = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_mutex;
 
-	rte_intr_callback_register(pci_dev->intr_handle,
-				   axgbe_dev_interrupt_handler,
-				   (void *)eth_dev);
+	ret = rte_intr_callback_register(pci_dev->intr_handle,
+					 axgbe_dev_interrupt_handler,
+					 (void *)eth_dev);
+	if (ret)
+		goto err_mutex;
 	PMD_INIT_LOG(DEBUG, "port %d vendorID=0x%x deviceID=0x%x",
 		     eth_dev->data->port_id, pci_dev->id.vendor_id,
 		     pci_dev->id.device_id);
 
 	return 0;
+
+err_mutex:
+	pthread_mutex_destroy(&pdata->phy_mutex);
+	pthread_mutex_destroy(&pdata->an_mutex);
+	pthread_mutex_destroy(&pdata->i2c_mutex);
+	pthread_mutex_destroy(&pdata->xpcs_mutex);
+err_hash:
+	rte_free(eth_dev->data->hash_mac_addrs);
+	eth_dev->data->hash_mac_addrs = NULL;
+err_mac:
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
+	return ret;
 }
 
 static int
-- 
2.53.0

