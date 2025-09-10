Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23983CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:04:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BF5A4065D;
	Wed, 10 Sep 2025 21:04:49 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id C834A4042E
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:04:47 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-729c1074875so52521706d6.0
 for <dev@dpdk.org>; Wed, 10 Sep 2025 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757531087;
 x=1758135887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=SlH3l9zr8tThDeI1sQzwxENxO1omfhOjex6xtplR+y+zgzWbVD7UVpbWZ8xnTfGsmO
 2jGHb9v56ShkSGDqCMZtIsqh6Ep+SdAK56U3FNu+qqDRb51cEbplhuhU+5DzG3os0Rpk
 W/4Rlbg4rh6bTXRdQ3qJMgGLUJVnD6a2p+B4vV7eUdLsHzEBumcp1NXpwh9O+cbCqnyw
 qo7hMCGHUJQfvqcbQQZGdKuIfSUQ01r0iSr2c7Z5zgRdTVMtqzoARw+pJKvRpLZ3Bgza
 rQjzl3EbJDGrBevkj7KF6LLvMPW80fYjRo9rYIvUoPLwEsdiVPRU5OWZSsqMCaD7qo7+
 Z/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757531087; x=1758135887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=G/1g2TCPkxkVlRgh7qm5qLJJA+0txh76jAgPCqK0Lsvanbo/zPvi1tfRE8XhEKPCjJ
 QCUD4wqFAKaTVyNZk6noUo0S5xt3H0z7h+2IA1sZ/+T9pGrU35zMXVgW8gpCU4lDAyMs
 DxlD+3TZ8gLEMTiZhdJLH/Z22OQdkD+GxuGpjPCyh8jbE/xkL3Ayi8fNwYPxiYMEaI9B
 tFiZafj01jCartJ92VW+jujK3D0vnY7/ONOdDV+2PK4RQnPbD5qOM5EnSLxvEKZ7pPY/
 xG+6QZzNS9HkorTRJba1FcgqlHcw4sgXsY9DclSqm4ddaI/f6K5RCY4ZlSRZVvmy90Ue
 1vbQ==
X-Gm-Message-State: AOJu0YxT5xji0TOHY+apQdP/4KueF5x71eDs0ZjXstsBjfxJqxl9qAQc
 hiWR0D+NxX6NXrdclipg8NTAZUUnlE4DSd5xuf1oobrjPpri+dXSde4J+xhERvincE7jVWRcK/H
 XwkU=
X-Gm-Gg: ASbGncvg8U/S5/QS6dbfIhTUMNMYUTXvQXhAPuMrnw1aVQa7tSZq+DZmrQl2Dy5V8vZ
 oDgEQjznsOTvM7jbFwrujkBT7rbKjqHGBADva2J6xCFpnnCMu5Ud3QIbq3iiVNjKHm6jdmcgVAB
 +XTQ9uR1FoxW8cx7dKG7OENtVzZmYXyqe3fzz0CtCrF5XaQWdCUHAvGGRiNmioOUiWrUTHKq+rO
 RrRGFatP3Ak7e0nurg5CtwyVM0IcMHuC+qHs27PdDylkqINux1II3auPRzCOnbbUvWt8PtDrUrc
 cryujXQmmV7Le3mqEpMZamV/vuXnT6D6Dfd7DwvdOf3CDUuJYb74w/CyeLD/IgU4fAwGo27C3we
 qKL1CNaQznWI8S39kGoOx5ZC9Eb3hM1l99iEGT/NVFJRbPQN2+AmoKIvk3cAXqGBjuzkhy8gOD8
 KF8D+yp3Z+dObYEwVA9q4=
X-Google-Smtp-Source: AGHT+IFggmBqw/h8xgEt6Js1Fqmh/AVgrF1WWgF6V6RWQxLPysuD36BO5tE3MYsaG50XvJ6cPoTRsw==
X-Received: by 2002:a05:6214:d07:b0:72b:7a6b:686a with SMTP id
 6a1803df08f44-7393d42b4f3mr183472336d6.31.1757531086521; 
 Wed, 10 Sep 2025 12:04:46 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c81319e1sm488856d6.61.2025.09.10.12.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:04:46 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 1/4] net/ark: add PCIe IDS for newly supported devices
Date: Wed, 10 Sep 2025 15:04:33 -0400
Message-Id: <20250910190436.995899-1-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212846.268492-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
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

Update documentation and release notes
update link speed capabilities for 200G and 400G

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
v2:
- included 2 more device id
- updated link speeds
---
 doc/guides/nics/ark.rst      |  7 +++++++
 drivers/net/ark/ark_ethdev.c | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/ark.rst b/doc/guides/nics/ark.rst
index 6aabde2ed5..c8ed57289b 100644
--- a/doc/guides/nics/ark.rst
+++ b/doc/guides/nics/ark.rst
@@ -310,6 +310,12 @@ ARK PMD supports the following Arkville RTL PCIe instances including:
 * ``1d6c:1024`` - AR-TK242 [2x100GbE Packet Capture Device]
 * ``1d6c:1025`` - AR-TK242-FX2 [2x100GbE Gen5 Packet Capture Device]
 * ``1d6c:1026`` - AR-TK242-FX2 [1x200GbE Gen5 Packet Capture Device]
+* ``1d6c:102a`` - AR-TK242-FX2 [4x100GbE Gen5 Packet Capture Device]
+* ``1d6c:102b`` - AR-ARKV-FX1 [Arkville 128B DPDK Data Mover for Versal/CPM5]
+* ``1d6c:102c`` - AR-TK242-V80 [Gen5 PCAP Processor]
+* ``1d6c:102d`` - AR-TK242-FX2 [8x10GbE Gen5 Packet Capture-Replay Device]
+* ``1d6c:102e`` - AR-TK242-FX2 [8x25GbE Gen5 Packet Capture-Replay Device]
+* ``1d6c:102f`` - AR-TK242-FX2 [1x400GbE Gen5 Packet Capture-Replay Device]
 
 Arkville RTL Core Configurations
 --------------------------------
@@ -322,6 +328,7 @@ stream interfaces for both AMD/Xilinx and Intel FPGAs.
 
 * ARK-FX0 - 256-bit 32B datapath (PCIe Gen3, Gen4)
 * ARK-FX1 - 512-bit 64B datapath (PCIe Gen3, Gen4, Gen5)
+* ARKV-FX1 - 1024-bit 128B datapath (AMD PCIe Versal, Gen5 )
 * ARK-FX2 - 1024-bit 128B datapath (PCIe Gen5x16 Only)
 
 DPDK and Arkville Firmware Versioning
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..8d3c0a1b02 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -102,6 +102,12 @@ static const struct rte_pci_id pci_id_ark_map[] = {
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1024)},
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1025)},
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1026)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102a)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102b)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102c)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102d)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102e)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102f)},
 	{.vendor_id = 0, /* sentinel */ },
 };
 
@@ -733,7 +739,9 @@ eth_ark_dev_info_get(struct rte_eth_dev *dev,
 				RTE_ETH_LINK_SPEED_25G |
 				RTE_ETH_LINK_SPEED_40G |
 				RTE_ETH_LINK_SPEED_50G |
-				RTE_ETH_LINK_SPEED_100G);
+				RTE_ETH_LINK_SPEED_100G |
+				RTE_ETH_LINK_SPEED_200G |
+				RTE_ETH_LINK_SPEED_400G);
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
-- 
2.34.1

