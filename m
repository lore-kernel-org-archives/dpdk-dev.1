Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D5CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE66040657;
	Mon, 15 Sep 2025 17:02:23 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 44592402DC
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:02:22 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-76ea7993925so24207836d6.3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757948541;
 x=1758553341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=O4j8VA6a3SVX9VMalFpi9NvA2VPgEGyntqLiZFpIBX6ooSMqgqPT0ULNGJ1tzdFVCP
 uqDzibTrRWHtFd1UuP14uHnQ1e8K2K4A50xJd6S8O+5qOVXQYEknPUAG0PJGRXJd4Zdo
 BgidoE8AkNlmYpQgUB/zbJA5zYgNVSPfuXp6q2XFgE20AZa+ZQ15Qcs/+jjej3Gslskf
 La8uzAN/VPS8sO5p/i1ri/x02jSWAg38HTebTR5YkPiJRsrOECIkrAoaBTUm+/GLJClB
 EOdSGBIbRKYfaNl4iol9qkJtImHzQD4TUrIuhWL/K12JRxCWEL7QK3J2bCun3bHyDLnZ
 prbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757948541; x=1758553341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=lHyFvg/OmEbpFY2nrOT5aOFijpdhPhAg/16gCgX7cM0nyna2IffLNnUYj6Qh90MS/K
 2I6kRxfCbz9T1fjaX3myYG77TQ6IHBiXgmd9iYiY8eZmTkM+eatiHJHI1qTQhFxkoLhG
 yDbzwEO9Rv//lhwih9YQZXsY4A+suSSbkDa33g7BTsm/nsuHLzJD5GpFoVxibQdtim+B
 8RIn8wjAJ6NyfLyIPfM5xxRg6pikUP0ltUJha49btdmuVjhkXm4/907OeC2uSE7NRbfT
 H52eKYd4K7HfgLLda+vZ6prUQuRzHKlI/XfFtY+fHN6CkMfuiQnQgZ2g2yKhavxOLQ0d
 YJPA==
X-Gm-Message-State: AOJu0YyQkvadVy+S7Bp4Z3Fwi2tt0Fg67sZiiVyaJzMB4PwJagY0C/aC
 wP+/IhxzfHhtCgH0xgjbOcm/7ijREIGCO9PcwnfI23lt/sC2VvFMg8sdD8J83mAHHgEhzUFBln6
 dS/8=
X-Gm-Gg: ASbGncu1elbldDBjJCJlhUWZoeJ9inF+u8rUcqpbKs/UooBCxoJPB1IKg03BIQPyr7w
 /uUeteq/fBYEsS3qSI3QbsP1qCU1E6Y1Bp8IqU63sIND+Ffa9hbHmRiMQM4+H8O72xLjT8K/1bS
 oOjyh+G+ukcyovd1sPF9IYKiUGAlOl9DbxZvmHv6XZjU7PPuieSFRR4rpsGzUiMh7F9kIA7jg4u
 7izY2I9kYGK8A3sMTf+PofxUbSGOF9plA9b3q9nyqG0nLPuAYv/wIZYXT6YV61eMWwVo5OGZ8+/
 6zPmj8g2NNsuXVLkgYeqQ6EBPuP51tkx/JsIwk4c0b+KJ+zpB7TFBII4p/qBjq3mPOqGMMoMyGn
 eSIk7bHPJMGesQ3oHqH6++Y0AAHZjZ3niDnTgJF5ZrRgTnkK9ZKWUyeYwH7kfHgPoogLrfvnWOV
 y9J7Eyf6yN
X-Google-Smtp-Source: AGHT+IGfmDngqVI7D4LwIKGz5xZJtkZhdVoaBVIPWwA6Dz+bEN+pjyYvWkfATc1kfaBgxzaAMHiKFg==
X-Received: by 2002:ad4:596a:0:b0:70d:ff3a:f96b with SMTP id
 6a1803df08f44-767c215b61bmr142651446d6.44.1757948540678; 
 Mon, 15 Sep 2025 08:02:20 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783edc88db3sm18930486d6.66.2025.09.15.08.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:02:19 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v3 1/4] net/ark: add PCIe IDS for newly supported devices
Date: Mon, 15 Sep 2025 11:02:01 -0400
Message-Id: <20250915150204.1719628-1-ed.czeck@atomicrules.com>
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

