Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC84C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3FD340299;
	Mon, 29 Jun 2026 15:58:46 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 273694021F;
 Mon, 29 Jun 2026 15:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 366512C0B67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1782741524; bh=okZgILycrFV5jERYb8Ya3Z6FPdsAxx1yuRLx/KWBuaU=;
 h=From:To:CC:Subject:Date:From;
 b=fSpQf3BiHNAiPEIBgpYSTU7Oao0i5sYXKs7aqezHixCIOuPeyU03DaHoqQ+y/f32M
 j5NQqOvaBi6Fi+v91nZrcrkC1HwHNpVQ9MZk786dQ32zXRJgBk9Wu2Bkp8dVzd71aq
 VuqWM0PRgrmJ5L3UldiJAbFY6v3Khu3NRMAQkTl0=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 366512C0B67;
 Mon, 29 Jun 2026 16:58:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt F39B92C0B62
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id F39B92C0B62;
 Mon, 29 Jun 2026 16:58:43 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Thomas Monjalon <thomas@monjalon.net>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Declan Doherty
 <declan.doherty@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <chas3@att.com>, Evgeny Sokolov
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bonding: fix the log MAC address restore failure
Date: Mon, 29 Jun 2026 13:58:40 +0000
Message-ID: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: Evgeny.Sokolov@infotecs.ru
X-KSMG-AntiSpam-Info: LuaCore: 110 0.3.110
 f0d2b619c309de4e63f840296abc3ffdd9b7629c,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 infotecs.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204116 [Jun 29 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/06/29 12:42:00 #28319193
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

Log an error when rte_eth_dev_default_mac_addr_set() fails while
restoring the default MAC address of a member device removed from a
bonding device.
This improves visibility of failures without changing the existing
behavior.

Fixes: aa7791ba8de0 ("net/bonding: fix setting slave MAC addresses")
Cc: chas3@att.com

Signed-off-by: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: stable@dpdk.org
---
 .mailmap                               | 1 +
 drivers/net/bonding/rte_eth_bond_api.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8e1153ce58..ddbaaf744f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -461,6 +461,7 @@ Evan Swanson <evan.swanson@intel.com>
 Evgeny Efimov <evgeny.efimov@intel.com>
 Evgeny Im <evgeny.im@oktetlabs.com>
 Evgeny Schemeilin <evgenys@amazon.com>
+Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
 Fabio Pricoco <fabio.pricoco@intel.com>
 Fady Bader <fady@mellanox.com>
 Faicker Mo <faicker.mo@ucloud.cn>
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index 9e5df67c18..da2b538b3c 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -706,8 +706,12 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 			&rte_eth_devices[bonding_port_id].data->port_id);
 
 	/* Restore original MAC address of member device */
-	rte_eth_dev_default_mac_addr_set(member_port_id,
-			&internals->members[member_idx].persisted_mac_addr);
+	if (rte_eth_dev_default_mac_addr_set(member_port_id,
+			&internals->members[member_idx].persisted_mac_addr)) {
+		RTE_BOND_LOG(ERR,
+				"Failed to restore MAC address on member port %u",
+				member_port_id);
+	}
 
 	/* remove additional MAC addresses from the member */
 	member_remove_mac_addresses(bonding_eth_dev, member_port_id);
-- 
2.47.3

