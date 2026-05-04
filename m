Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A37CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 13:18:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E732A40668;
	Tue,  5 May 2026 15:18:45 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3A3AD402B2;
 Mon,  4 May 2026 16:15:33 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1777904132; h=from:subject:to:date:message-id;
 bh=mbNH8OfnZziLQ3GEjOnsPo5vrHCpxHTXDtxFGX/dnZc=;
 b=hHaFxq4MYazUApRccp3qZCcAo7l/v7ZVYK1yV5atvk/iVvVk5umm78uf6FXeXo8auYp5LvMsW7K
 j3jqo/S/XdB0Q7f0FAgjvXGqnetgCdKgNmwa0RyciUXnzxcTk4u0T1voNL8UnKBc80/V/IXg1eJtb
 eOwwryqbi5cxEqVngp0c4Q1uU1jkOQybXP6jt9Vn+BHtbgtGxLFkikE6/qW2Ot7O3dr+ltD5LRkYd
 bGJc55u29kvn4CHvwMpy8hCndV92MynJTbN1qiQmX5I5Mm9DQm5vzLzAH4TqH/Cy+vvEQdVuhxyeV
 K+JIcp+mMAzxGNLGZBsQvDP7TADF0a3lBdHQ==
Received: from dish.amicon.lan (172.16.2.39) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 4 May
 2026 17:15:32 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Harry van Haaren
 <harry.van.haaren@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Daniil Iskhakov <dish@amicon.ru>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: [PATCH] net/ixgbe: fix good octets CRC adjustment
Date: Mon, 4 May 2026 17:15:24 +0300
Message-ID: <20260504141524.114604-1-dish@amicon.ru>
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

On some devices, such as 82599, GORC is a 36-bit clear-on-read counter,
while GPRC is a 32-bit clear-on-read counter.
ixgbe_read_stats_registers() accumulates GORC in a 64-bit software
counter and, when CRC stripping is disabled, subtracts the CRC bytes
accounted for each received packet.

The driver does not read GPRC directly. Due to an erratum, it derives
the good packet delta from the sum of per-queue packet receives instead.
The 32-bit QPRC registers are used for this purpose.

delta_gprc is used as an accumulator for those per-queue deltas and is
then used to compute the CRC-byte adjustment. Keeping it 32-bit may wrap
the accumulated packet delta before it is used to adjust the 64-bit GORC
counter.

Make delta_gprc 64-bit so the accumulated packet delta and the CRC-byte
adjustment are computed without 32-bit overflow.

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
index 57d929cf2c..71243610ee 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3182,7 +3182,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 			   uint64_t *total_qprc, uint64_t *total_qprdc)
 {
 	uint32_t bprc, lxon, lxoff, total;
-	uint32_t delta_gprc = 0;
+	uint64_t delta_gprc = 0;
 	unsigned i;
 	/* Workaround for RX byte count not including CRC bytes when CRC
 	 * strip is enabled. CRC bytes are removed from counters when crc_strip
-- 
2.43.0

