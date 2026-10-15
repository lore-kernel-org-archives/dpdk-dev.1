Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE6CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6FED40658;
	Thu, 15 Oct 2026 14:57:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A997A4042C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:57:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974E114BF;
 Thu, 15 Oct 2026 05:57:42 -0700 (PDT)
Received: from KDFJ2LQKPJ.cambridge.arm.com (KDFJ2LQKPJ.cambridge.arm.com
 [10.2.197.114])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F433F871;
 Thu, 15 Oct 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1792069065; bh=8f9DQfaX/5q23NZ+n36O46vmWEdVRRkQrczLXlDd4LE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iK/ih4W0BY1+P5UepRy89Ne1jTvcaoIe8knjWsn50AD82tAa7BTresV9LDDUAjgS1
 Zsj27TqF2HdIaDDt7asIpZzMpQLB5HScAFOpjLickRmCWN3rqY5s919mngdXs+kcJ9
 YaxjnqcluuUwEixzQucMEiXFT4utmIcyPTv6Hcoo=
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: Chas Williams <3chas3@gmail.com>,
	"Min Hu (Connor)" <humin29@huawei.com>
Cc: dev@dpdk.org,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/2] net/bonding: fix minsize build
Date: Thu, 15 Oct 2026 13:57:40 +0100
Message-ID: <20261015125740.47008-3-jack.bond-preston@foss.arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
References: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
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

"minsize" builds of DPDK with GCC can trigger the following warning
(error with Werror):
../drivers/net/bonding/rte_eth_bond_pmd.c: In function 'bond_ethdev_tx_burst_tlb':
../drivers/net/bonding/rte_eth_bond_pmd.c:997:29: warning: 'primary_member_addr' may be used uninitialized [-Wmaybe-uninitialized]
  997 |                         if (rte_is_same_ether_addr(&ether_hdr->src_addr,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  998 |                                                         &primary_member_addr))
      |                                                         ~~~~~~~~~~~~~~~~~~~~~

This is a compiler bug - primary_member_addr was initialized above by
the rte_ether_addr_copy() call.

Silence the warning by replacing rte_ether_addr_copy() with memcpy()
in this instance, which satisfies GCC that the variable has been
initialized.

Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---

Note: The other option is to memset() primary_member_addr after declaring it,
which also satisfies GCC - I went with this change for smaller code impact.

 drivers/net/bonding/rte_eth_bond_pmd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..b7b111536e 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -978,8 +978,13 @@ bond_ethdev_tx_burst_tlb(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	memcpy(members, internals->tlb_members_order,
 				sizeof(internals->tlb_members_order[0]) * num_of_members);

-
-	rte_ether_addr_copy(primary_port->data->mac_addrs, &primary_member_addr);
+	/*
+	 * memcpy() the address to avoid a GCC bug - using rte_ether_addr_copy()
+	 * causes -Wmaybe-uninitialized warnings to trigger on usages of
+	 * primary_member_addr.
+	 */
+	memcpy(&primary_member_addr, primary_port->data->mac_addrs,
+			sizeof(primary_member_addr));

 	if (nb_pkts > 3) {
 		for (i = 0; i < 3; i++)
--
2.43.0

