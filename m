Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431ACA1012
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 21:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DDC040609;
	Wed,  3 Sep 2025 23:28:53 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2BBCD40281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 23:28:52 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4b109c4af9eso4379221cf.3
 for <dev@dpdk.org>; Wed, 03 Sep 2025 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1756934931;
 x=1757539731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7TvqMIRpEhmvIQEF4ROCJxPOAAO2h1SXNkXdCshOlew=;
 b=PkXFnvzhMAlSEQFh8oxtXsvShKhK3QTkWk2plhjwO/qPuSRAL1XfHKFRN3mgVrV+Ri
 QkoI69zkhK6QYjFHktdwN2AiE+4QX+vD0DA/KTtrJIK9pj/eP/2BxcagASPJX6WZyV0c
 ko6WVcSlTXNfXV7ng3BKkpCAUD4xjXV6LUwrOfg3+onedoP/+5oIcEw6wFqfbSoJNjKJ
 rpykttghmuS4rmdfAD3+FukBBR6eXkSGnj0lQ7snc+EvzlRUAikNxdBMPM7W6rSjT7pl
 y/kJPlHtN/lP4UPS9Zr9hVD9LTc3kt5zj5M6/Er8zw9Y3HNKxenCj1lJM9y2EJ3ypXqe
 q4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756934931; x=1757539731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7TvqMIRpEhmvIQEF4ROCJxPOAAO2h1SXNkXdCshOlew=;
 b=Uxtnw9nScodsJ4Rq+286kYpIuGqwyHDGnGxhIx3bRk28VG0pWAnSYAF7N6DZQWRkoi
 2FHjkJwcpvlaRFSwpPDwmnCTopAfE9wfK39/EEFAzXy/+/51pPBwP2h2TUdWFtgfivaa
 vWwsTIhEtn4yNim1CLgiASBJDM4fDdpS6Zns1L3cbog2OIYnv24qQCYA+E2fE/2dDr0G
 9R0SJDOY+tJpyjzA6Vg2mSNZIzd8ZTlwPq3Ry5zMSYvEWAGzy4gPz1jOo7v4vv7wOcD1
 qsY815zHppYqAbRleqqGZx+P63keMCto8VHYm7Fc0PHD20NRGb7Z/oj74luNBoAzyYHo
 6srA==
X-Gm-Message-State: AOJu0Ywb//RhElGcwzEx5ne1ubvORfSa144kfoSErbdykW50ULNVy7uf
 6rWcc9E/NZW+ooFFmuNrFsx6vkRNdgsSJOVdtJA+5ZnmJ9bhQaUlYJaYOihabtvqu2wsFEMlM9J
 WbPA=
X-Gm-Gg: ASbGnct0MsXKrt7Xdq5Db7cNoYecXn6505z5EjwqwdtcY9sKM6+j+gtw8x1nNpB82Dy
 AuPZDHL6F/rdmEO+MabhVnDZuECqh53kxm/UMfZXRXoORgHACfseptidPb0H77YJXj4kLCPezRN
 L/wbKE4H8OOaH2WnLAS0WxG5akxBo46j3RMm/itQGjiNjaLCJRBC9FvKZ52U3qmSiiEjX4mvEtK
 Jnd7eolyoqQ65chGBi1LE0T8/R0dcMiXSo1M3dt/tMwNXzeXAABYKLhKRQafib+dFITxF+bLB6s
 56tjYgNcO5Qze3fHcJKs8uElXuI6tIYw9xrPnSfRKO+BUP4lC/0OB/Iu4AHa0Kh2sJaXBQC7oHc
 1Y3NSa7mS4lg2KrKqlqPNp7AXFcmN8x+0s0iMy+9ZFWM8YBC5pLYFjyRkTo/XFcHio99FrgT358
 qSZzKapAzZFNWO8LzxImw=
X-Google-Smtp-Source: AGHT+IHKmFh5h32o1mHRPG+OTPGTFIoMr1joTK8yeChbfE9peg0EO1N9XYwNZYHB7uCW9qknPTJzwQ==
X-Received: by 2002:ac8:7dc4:0:b0:4af:2305:2c37 with SMTP id
 d75a77b69052e-4b31d8229a0mr218411281cf.21.1756934930846; 
 Wed, 03 Sep 2025 14:28:50 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aaaa1d6f4sm175929385a.42.2025.09.03.14.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 14:28:50 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH 1/4] net/ark: add PCIe IDS for newly supported devices
Date: Wed,  3 Sep 2025 17:28:42 -0400
Message-Id: <20250903212846.268492-1-ed.czeck@atomicrules.com>
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

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
 doc/guides/nics/ark.rst      | 5 +++++
 drivers/net/ark/ark_ethdev.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/doc/guides/nics/ark.rst b/doc/guides/nics/ark.rst
index 6aabde2ed5..1977f67e73 100644
--- a/doc/guides/nics/ark.rst
+++ b/doc/guides/nics/ark.rst
@@ -310,6 +310,10 @@ ARK PMD supports the following Arkville RTL PCIe instances including:
 * ``1d6c:1024`` - AR-TK242 [2x100GbE Packet Capture Device]
 * ``1d6c:1025`` - AR-TK242-FX2 [2x100GbE Gen5 Packet Capture Device]
 * ``1d6c:1026`` - AR-TK242-FX2 [1x200GbE Gen5 Packet Capture Device]
+* ``1d6c:102a`` - AR-TK242-FX2 [4x100GbE Gen5 Packet Capture Device]
+* ``1d6c:102b`` - AR-ARKV-FX1 [Arkville 128B DPDK Data Mover for Versal/CPM5]
+* ``1d6c:102c`` - AR-TK242-V80 [Gen5 PCAP Processor]
+* ``1d6c:102d`` - AR-TK242-FX2 [8x10GbE Gen5 Packet Capture-Replay Device]
 
 Arkville RTL Core Configurations
 --------------------------------
@@ -322,6 +326,7 @@ stream interfaces for both AMD/Xilinx and Intel FPGAs.
 
 * ARK-FX0 - 256-bit 32B datapath (PCIe Gen3, Gen4)
 * ARK-FX1 - 512-bit 64B datapath (PCIe Gen3, Gen4, Gen5)
+* ARKV-FX1 - 1024-bit 128B datapath (AMD PCIe Versal, Gen5 )
 * ARK-FX2 - 1024-bit 128B datapath (PCIe Gen5x16 Only)
 
 DPDK and Arkville Firmware Versioning
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..d3fd76eec1 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -102,6 +102,10 @@ static const struct rte_pci_id pci_id_ark_map[] = {
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1024)},
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1025)},
 	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x1026)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102a)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102b)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102c)},
+	{RTE_PCI_DEVICE(AR_VENDOR_ID, 0x102d)},
 	{.vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.34.1

