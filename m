Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56706CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 19:11:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C8BC4064E;
	Fri,  8 May 2026 21:11:15 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 7AA3A40150
 for <dev@dpdk.org>; Fri,  8 May 2026 21:11:13 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c8c9c4cd8so2056122c88.0
 for <dev@dpdk.org>; Fri, 08 May 2026 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778267472;
 x=1778872272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si5z0tMVm0B5Yqh2wMs5Gjjrp6Dj3txaAtWmIkFRWCA=;
 b=Ycj6nnLsjdkGtfDkApSaWlqQ7A2c0xNSsawUJ6PmP0T6aYhxEfluV6xOZkhonEBQP3
 cJLME5qvZKPNzesRBt6TCyiUg1LvCviNrkSg3BJNKEF6nBoIleex4RJ4HsA2FaE2dw/U
 jM8//ppLDy9raB3kPBVb2Ev1rlZ7CVwEXQ5MC9XO8aGIM/2UZ75ja8R4xmK3AqX2pVat
 NcLwvoorRZSXyT5R174uEWnTJXkfnoefpySH3O9KnEnjYGcm8klefttxAb2t3eHyaoTp
 dOxQNhNawIK0I+Eb6vwz3yI13Oof/fE2V+VlWCpmlCWi2ymD4rdm+uMKeovP4zM4m1+y
 /Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267472; x=1778872272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=si5z0tMVm0B5Yqh2wMs5Gjjrp6Dj3txaAtWmIkFRWCA=;
 b=C7MJFPrvHIQHYUUz0QckYVoL29DA96MS1KQLKYBtL8xhsRPCGbf50C8RF6ELDQlUS/
 FPFRIbxcU5WlUaoyHgCB2d7QYq3CWdlJ1TXV6kCCzntx65XTN66vdU4rF5ef/T9IPbDC
 x77ttDhW5B95lg7VBQEAsJEm8vstKnl0Yys7lTabCByRY+TZwsFnXI5lUGd0bDxZjqEv
 cfc5WbqC5wPElCcypm+qGvcO8uVBsQdurC0Yto48PMRvvPH0UsnzQ44YM3BngCc+FTPF
 ZXpTScRz9aAPMQ9ycIAjcFeXqF14hK0VRS+3LA3r8cv88upCnNLok+LsU5JETotbG3G7
 4LNg==
X-Gm-Message-State: AOJu0Yx5kRPcFEtsQOHc1eZpNEvmyPkX+JVWTJaf964yYm4hbMEVT82t
 52GzcHPITKSteozON3xdWgJPHLycIZIQDL6AMHq6h+7jxUXgpwD5OSqecdgQ/wO1UTriIeXuDQv
 JRx19
X-Gm-Gg: AeBDieukvfHpK/5LPpHz/ofdH4GvLX7p8c48B2hWlZfuZ82dZ54H0mFgdimNS1RtR9Z
 qG6sl/pF2J5gkt7tOzjErj5NDS/vic1NqcDuYwADdMG6GlCaYddn+jj0DkPMe+Tgmd/s3rXOkGh
 67RNTvrj/1dePOhFI3o72v7jMnHTXPJnN/yxe6G11j8SdMt7SgGlMXDX7rQMBd0rsIR/8kjNVnN
 ADTvzTTAKX4c2b0edYH/mlf1QGcoJeKFXxPm8VjJfDKmCr5kDS1Izz1+fJDOogAvfQucCp3sCDa
 cv7TSlEi1rgIp5+qb6cGydevnSphtiKzoss8iYoqGG3Dq9JQmYEXURyLHBW/mT7CsLLlw/NG844
 2U5Mh8s3na2E6U67NLZAyNT9NqV7qAlbsALir8224z49CvzvEbT2e652IsRmhYHIM1YWWwC9Q5f
 k5N2xcemOY5XsxGEq7X5NV8PYtdN5Bn+k5Vp/meR3aFH0=
X-Received: by 2002:a05:7022:f212:b0:132:d1d:ef5a with SMTP id
 a92af1059eb24-1323afaafb4mr3608303c88.12.1778267472457; 
 Fri, 08 May 2026 12:11:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1329fc4bf3fsm212796c88.5.2026.05.08.12.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:11:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>, Chandubabu Namburu <chandu@amd.com>
Subject: [PATCH v2 1/4] net/axgbe: fix resource leaks in device init error
 paths
Date: Fri,  8 May 2026 12:10:49 -0700
Message-ID: <20260508191109.734377-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508191109.734377-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260508191109.734377-1-stephen@networkplumber.org>
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

Fixes: e01d9b2e980b ("net/axgbe: support unicast hash table for MAC address")
Cc: stable@dpdk.org

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
2.53.0

