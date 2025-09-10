Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22CCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 18:57:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B9840615;
	Wed, 10 Sep 2025 20:57:32 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id E97D34042E
 for <dev@dpdk.org>; Wed, 10 Sep 2025 20:57:31 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-80e2c52703bso617018985a.1
 for <dev@dpdk.org>; Wed, 10 Sep 2025 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757530651;
 x=1758135451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=nz8j2NMM8Fakq86Xm4ETaH4yk23vJVX++I5ZTti8V0NN+DyjvTVSJ7+YyahZIKhvB9
 qBNFsuAwcRjGa54pQdMwxijDMHIAgBbFdr3RFhHWY+/Ncgps+gWFnYgbkbOQQIVcSAjb
 1mkzV13+vgIXw3/wmYtoV7NRyjxqY50LOK+YABow9WugtiEAd9qWIUuu66R6XbMJpLUH
 gln7Wdbsk7jgrzbzDqcs6YXflLN93FRSNbYr89xwW7Tdikp5a0YyOaBKR+LsVAy1hh9Q
 Z0XI17sVrJyu2mQEVsbnsDAGsAKmP3Ij6kk5gaqP6kWUsYkFU5Jrb3u37W5sdJjj27DP
 ZHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757530651; x=1758135451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DiOe3DsGkPpuJjCiId51FazWRCcWlEP+HKY0kMpZ/Ro=;
 b=fXg0yzNzXRy4FpIIV7HYeGrmHre3b5MWkMXlMb+Rns170E0pXEt7LRByqx521vYuvl
 cycXA9k7EOySFKKtr4dCc3s+w5wLAvf7bN5r4cawpJdMYr8/0HoluXCxXao8NH5FkHcW
 7kVIKCqGr1gCI+AUoHg7DWHxxhz1ZPES6l2MWfa8H3XA9qCmXRqdvzoWjg4bZ1mI3Uen
 MTUbvtHD20vW7lef98WNLYNMc0BBN2B28STozlf4g3ioO+AV+zUu2AeQFs9N/y+XjJXW
 fLTHwB0LtBQ4igb6/kMJH/wGFukGyQVOHtWNCpH4Z1Q73BckNEE/VIWd0LUp6KyhsVXJ
 GWrA==
X-Gm-Message-State: AOJu0Yw/H9NpaufVCA558tsD8HsH46xP0jwrWyUFk+XSP4VtmskXpUAz
 DC2KpRmjidEBamRWWZkylltyzFoJc87/HfWBH4d1FvwJSuGowN7oRbXL002+U95IRxdlvKKNpmr
 0Jno=
X-Gm-Gg: ASbGnctMXtMpcFfh+F9GWKAGRikSIeTCQf44Jr867ngRsdVaCHiy+tJmtgJ8SfkLHHZ
 s09+Orbmkf8VOaqMB5juV4gYdtwouTF9msqS5180+duxAjdYIZEm17VfznNz8H5hCbmFWRfwPaf
 7OzjGYAq6x6CYAF8AOJrE6HkzT8dE87C635DSQZJnD1ZwLCtoA6l3fbr4uBWljkDSfwr9R7ZY5K
 iCBLw3TpRL+qRjsWidxF+QpUllK1vv9yVenwhp4fXSRSZrWtsRz7zpLEIJWe+hAkn9m0io3rEQC
 hLsYxWeYob2hdLF8OEsFSQwO9H5MBdK0tICC/I8K9B9I3WIL1nVrsO+RID4eI1eVC03E5llRSva
 ckmeBqmQcqJD7uk2iyZKqq5S2Ts/vdo/fevhobGQF7YTz9rmzyc+uoBuJ18fo5RUYkZuaqCGKsP
 UGnEGJFJRS
X-Google-Smtp-Source: AGHT+IG05J7cwpiJDchGqlGRgmulPLApWMHoVYy5j2f9RAzVaK5v1dRklgRbsoXN697Q7Ad+J/v0LQ==
X-Received: by 2002:a05:620a:4483:b0:7fc:8b95:524a with SMTP id
 af79cd13be357-813c660b296mr1550954485a.63.1757530650664; 
 Wed, 10 Sep 2025 11:57:30 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c955968csm376176d6.73.2025.09.10.11.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:57:30 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 1/4] net/ark: add PCIe IDS for newly supported devices
Date: Wed, 10 Sep 2025 14:57:17 -0400
Message-Id: <20250910185720.995300-1-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
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

