Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E97CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 13:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 072A54027F;
	Tue,  5 May 2026 15:18:45 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 196804029B;
 Mon,  4 May 2026 14:26:59 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777897616; h=from:subject:to:date:message-id;
 bh=5mB7fII0Ex6jBmQoNJmt9lwrKZe1U6zrOTz29HInq0E=;
 b=lDQbkk9RdrZoHpf053SehFB7he8m+ilFdVfyWl9firnQ7RAnRCjDQG9SUmgR/rYTKiOAbXrRcLA
 t3JzH9jCZviojXDFgmLQx+Ed/nnaxv9WFMB8fUGDQ16Xt8DG0GRIx8f93joFyVzwYC5u/jsyYoWAA
 JJDL/I8KlL/bBq3QAEaC4ww9qdZxo1ctEFEk2kDm6TjBLzSUuC6wBRE0fXsDKosTmsocRdrYIraq7
 tdFO8tzFRtYqY5LKycTQfSRsZNJvv86+8TeAB+en9KeVEOzpH/BCdZT1kIOMa6l1fXo9cIaYplBAI
 kL1yu2aF8k7c+jUnXiqokxRn9R1ws7hr1kZQ==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 4 May
 2026 15:26:55 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Harry van Haaren
 <harry.van.haaren@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Daniil Iskhakov <dish@amicon.ru>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] net/ixgbe: fix queue received bytes CRC adjustment
Date: Mon, 4 May 2026 15:26:23 +0300
Message-ID: <20260504122623.37067-1-dish@amicon.ru>
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

For 82599, QBRC is a 36-bit clear-on-read counter, while
QPRC is a 32-bit clear-on-read counter. ixgbe_read_stats_registers()
accumulates QBRC in a 64-bit software counter and, when CRC stripping
is disabled, subtracts the CRC bytes accounted for each received packet.

The CRC adjustment is computed as:

	delta_qprc * RTE_ETHER_CRC_LEN

Since delta_qprc is 32-bit, the multiplication is performed in 32 bits
and may wrap before the result is subtracted from the 64-bit QBRC
accumulator. A full 32-bit packet delta needs more than 32 bits to
represent the CRC-byte adjustment.

Cast delta_qprc to uint64_t before the multiplication so the adjustment
is computed with the same effective width as the byte counter.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c03fcee9abbd ("ixgbe: remove CRC size from byte counters")
Cc: stable@dpdk.org

Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
Cc: harry.van.haaren@intel.com
Cc: sdl.dpdk@linuxtesting.org
Cc: rrv@amicon.ru
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..c17ce70810 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3237,7 +3237,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 		hw_stats->qbrc[i] +=
 		    ((uint64_t)IXGBE_READ_REG(hw, IXGBE_QBRC_H(i)) << 32);
 		if (crc_strip == 0)
-			hw_stats->qbrc[i] -= delta_qprc * RTE_ETHER_CRC_LEN;
+			hw_stats->qbrc[i] -= (uint64_t)delta_qprc * RTE_ETHER_CRC_LEN;
 
 		hw_stats->qbtc[i] += IXGBE_READ_REG(hw, IXGBE_QBTC_L(i));
 		hw_stats->qbtc[i] +=
-- 
2.43.0

