Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95555CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 13:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF35240674;
	Tue,  5 May 2026 15:18:46 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE6F402B2;
 Mon,  4 May 2026 16:55:11 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777906510; h=from:subject:to:date:message-id;
 bh=x+OIGu9co52424gtlJ8r/pZBl5cT1qEyAML+fNMl6FA=;
 b=mrpD5SBdS4ww7xoZTbpgmDwalne+u9sSQXSVL9YIb9xcQRfyermOqv4bOeQ5t0Z/DGexqB9rQWP
 5RoiRoiDJvIJTNjsfC9i1yAC1BD840dlJjL90r7xhxSWy5N2u2EGw0fcosKuY3XowkpHs35tGFRZ7
 EZTgkpd5eMJMyWoCtYUr8w369d+OZagVc05kvO20Dojk5+oqL3EbrylBTKTqsOiaWpXCGODtoVUXG
 UBYtr1PsKDOovs1t7R52RE5h7ps6S13ybBtK4W525HohHi4H4HJNPdJE199OzN41lrzg4G+axVseE
 vTEPuX2WyTuT0731aAdNa87wKkY7ZT8N0Uyg==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 4 May
 2026 17:55:10 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Daniil Iskhakov <dish@amicon.ru>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] net/ixgbe: fix flow control frame byte adjustment
Date: Mon, 4 May 2026 17:55:02 +0300
Message-ID: <20260504145502.160806-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.2.39]
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Mailman-Approved-At: Tue, 05 May 2026 15:18:43 +0200
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

LXONTXC and LXOFFTXC are 32-bit counters for transmitted XON and
XOFF packets. ixgbe_read_stats_registers() sums their deltas and uses
the result to adjust the transmitted byte counters by the minimum
Ethernet frame length.

The sum is currently computed as:

	total = lxon + lxoff

Since both operands are 32-bit, the addition is performed in 32 bits
and may wrap before the result is stored in total. The wrapped value is
then used in the byte adjustment, which may make the software byte
counters incorrect.

Make total 64-bit and cast lxon before the addition so the XON/XOFF
packet sum and the following byte adjustment are computed without
32-bit overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..cff2dbd900 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3181,7 +3181,8 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 			   uint64_t *total_missed_rx, uint64_t *total_qbrc,
 			   uint64_t *total_qprc, uint64_t *total_qprdc)
 {
-	uint32_t bprc, lxon, lxoff, total;
+	uint32_t bprc, lxon, lxoff;
+	uint64_t total;
 	uint32_t delta_gprc = 0;
 	unsigned i;
 	/* Workaround for RX byte count not including CRC bytes when CRC
@@ -3310,7 +3311,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 	hw_stats->lxontxc += lxon;
 	lxoff = IXGBE_READ_REG(hw, IXGBE_LXOFFTXC);
 	hw_stats->lxofftxc += lxoff;
-	total = lxon + lxoff;
+	total = (uint64_t)lxon + lxoff;
 
 	hw_stats->mptc += IXGBE_READ_REG(hw, IXGBE_MPTC);
 	hw_stats->ptc64 += IXGBE_READ_REG(hw, IXGBE_PTC64);
-- 
2.43.0

