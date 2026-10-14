Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF3CC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A174064A;
	Wed, 14 Oct 2026 11:13:11 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
 by mails.dpdk.org (Postfix) with ESMTP id C82BA4065A;
 Wed, 14 Oct 2026 11:13:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTWTQRzsomM/TLgxlCNrIKE6IYUDFstNTbJLCZb1H1uQN0OhGzdxPujDLo1iL2Ck7EoLC7GTbt9ehCKjeaCuoX2BRiR9hRJKcoQYZgBlX+VLBVBhnDXKCdeXZuTJkw+ORutju0oQiJrBmGMrGp/ZGkkqWJ/9h3YWrwavlInXnINV3yLDnEIa6TlifXL0lBT2Gim9gnMfdo7D3QDzbPwwD42jpCwak72wgC/nIpxtnmpG13pf/Tp2iHJxHthcNomExg5ZS2VIXacD6GkVxsH+Ea+d+e8afxv/CqZlMvqIphvrQjaVdt4G0MuVWzJR8sewHV4697IEbPcrmtqELUR5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAl71l9HqY0f/+gEVviSZ3JEDIgjFiQ5GxjGC4fwr7Y=;
 b=m91btfuJE+xyh3kCgD5rwJgKo/sodzWOKkkRdRLl1Pq3U9BrtoIGsx7qYnIEQS62Y0/Yy6Rz753f/2G7vNO2mIOv4oMfuBzvFE2EB2gmatJAnl0qPzpzz1HsD1d6t/167OmncUmrxjIPjuWCvabSGVCLBRNFSfwQPlURfSPYrapD+ppYt4pNDY8Fr+BJh/+CrB9SDJtxy11pEq9a1zlBC78VLWKDr0J6XMUwFfRvV/fhdQ7ubA4zdzQct3+yk+ImWOSakw5xyi5UrD6NNrcVWGfLF4K2h+cwEhYsewwsYrKwBH2gQKgdtP286OTaxcsMxoNf0slS+9wIFOsz0E7mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAl71l9HqY0f/+gEVviSZ3JEDIgjFiQ5GxjGC4fwr7Y=;
 b=mnsS3rTJOsJ5oi2UJGd7xrdn78x0w0oVnF9ZoGJfWNbPSKZm5iVgqwm4kseK/jiWgNB5IrIUwHNPfDmOqLzGhosq8OcbtSH63POZsObGIt5ARrjhAWhNZxvNgv2sHEBfILw+gIWmBOGCYq0CmQuPXdpgFsrLWRq2FHlFoXaNumuBrRlNm3n9R5oVHeTc7pjfafcnWpG3typZBo110oe47ue/AA9aaloKmVEtkU+YU0kegfJOgPlpl3qbCYcZ2EO8vYO6fpTFK+K4gJ9mJt2wjb7GAvlGGYXmXcKKYvldHybTWVxp2TBulYvoxeDWC4zWHBcWUeKgJlQcoD4YJfejHA==
Received: from MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:44::13)
 by AM8PR07MB7410.eurprd07.prod.outlook.com (2603:10a6:20b:234::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:13:01 +0000
Received: from MI3PEPF00008497.eurprd03.prod.outlook.com
 (2603:10a6:290:44:cafe::40) by MI0P293CA0008.outlook.office365.com
 (2603:10a6:290:44::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:13:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008497.mail.protection.outlook.com (10.167.240.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:13:01 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id E60A54020A84;
 Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id B0A9C617B8BB; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 3/6] net/memif: fix MAC address leak on probe failure
Date: Wed, 14 Oct 2026 11:12:54 +0200
Message-ID: <20261014091257.1051190-4-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008497:EE_|AM8PR07MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3029cb72-b2e2-4697-e316-08df29d358d2
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: eHtkPWQbmZgeMLY34Tui7GGb4KDrPX1TQOp4XFeByOepaWXuqSFI4g1T416UcvZhZQW8W0Ct1L2LMbRiypWekK4CcS9Jy0vPC7lN+SPqK4MKUq9W6J/Zk6j7ZFmqasBrpjzvNr8HeFj4H1F0Pdb8f61xm90CCDA16J5nNCeelllsm/gKDdeId2lBuzrrtQxRuKCXUaRfD9GrXaRYydyI1gtWXY9KzlTULzTnx0/LUVSlk9S/QLzH9KgIC2DIamiwl+5Np10RJdymjq43j6F18P68dPBFvsAYOaEgMg/UqDNJkUGLQJ9lOstgMy2AbwKm5DPXqYYDSGhCyE+rxkynQlpD6qdO+k0lP4c0jYAqY3TIwvo5X3BnYz7O04/zjhprBaMkcUcCoX3Uw/nAmdX2aCeeAukAX6WASI6UfpxoeZ9PnPds1djtggepkgTagk7DEA9k22IoXebmrOkf1IHZ+UgMSCnFZv9y+uYuSA9nHKj27xc82mYFqp0UL0GieasmuTN2VUHEsv1KTB0ptfccPcKXd9mYq4UxkG0sKZFDzFDpzShLXFzI596pfyWBEUZbr+uBAfPwNkgs98KIf++yhELVu3QaTaKVrKf9F338e1EdcNecBCPeKCZpabMXqR3JIHN5QlqzFuwwkoT5LxjTgJdakdnBSuCkwQsdb+NQyo5KFy9L1hZUT2l8lAXi3y49v2NlFZ5fvayFOWuO1i5nVA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QzfAnEM44MRhm/v5L4u/3B+CZN08jstUlVAdDgpdWHg7xfWqcKITcY0NZbOaTTwtfqsd0kumNuzt8V4lx8dRXo2I8m86lRRnZOMGWgPyGrIjJEKRkU1uqUS0IuZFMBnXeJZJxmCtBrzMM6WP/Zty9aaQr6WAdZY0/GWR3T46Qy55T110hc6h6FVrpV7wWufr8bslAc2Kl+rX9czwKg2CcioBkNipqHs/r8Afy1qnPcw9RhZ0jS/KoZRDNWNFmyTQptKfNzVY5B114IjTEvMl3RiZ0SYZH74dezdM7AX/XDiDKHIJ6iPk2j8HT0BLs3+cG2qqdmuG7DIbmM12EJEfgQ4acI3nQzP1xQ81YKEzktPd6aLpetTJof2S6sxMxAxG2+UkMMbTg/d5ONXPpCe6dORIXQOmvMjDVOqYk7BuzOkoIN0d++y2W1GQK6s7S8q9
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:13:01.4069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3029cb72-b2e2-4697-e316-08df29d358d2
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008497.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7410
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

rte_pmd_memif_probe() allocates the default MAC address up front and
only hands ownership to the device in memif_create() on success. Every
argument-parsing error jumps to the exit label, which freed the kvargs
but not the MAC address, leaking it. The allocation was also dereferenced
by rte_eth_random_addr() with no check that rte_zmalloc() succeeded, and
was done even in the secondary process which never uses it.

Allocate the MAC address only in the primary process after the secondary
path has returned, check it for NULL, and free it at the exit label on
any failure (on success memif_create() owns it via data->mac_addrs).

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 24a44d94d7..e8950166b2 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -2239,12 +2239,9 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 	gid_t owner_gid = -1;
 	uint32_t flags = 0;
 	const char *secret = NULL;
-	struct rte_ether_addr *ether_addr = rte_zmalloc("",
-		sizeof(struct rte_ether_addr), 0);
+	struct rte_ether_addr *ether_addr = NULL;
 	struct rte_eth_dev *eth_dev;
 
-	rte_eth_random_addr(ether_addr->addr_bytes);
-
 	MIF_LOG(INFO, "Initialize MEMIF: %s.", name);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
@@ -2271,7 +2268,7 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		if (eth_dev->process_private == NULL) {
 			MIF_LOG(ERR,
 				"Failed to alloc memory for process private");
-			return -1;
+			return -ENOMEM;
 		}
 
 		rte_eth_dev_probing_finish(eth_dev);
@@ -2279,6 +2276,13 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		return 0;
 	}
 
+	ether_addr = rte_zmalloc("", sizeof(struct rte_ether_addr), 0);
+	if (ether_addr == NULL) {
+		MIF_LOG(ERR, "Failed to alloc MAC address");
+		return -ENOMEM;
+	}
+	rte_eth_random_addr(ether_addr->addr_bytes);
+
 	ret = rte_mp_action_register(MEMIF_MP_SEND_REGION, memif_mp_send_region);
 	/*
 	 * Primary process can continue probing, but secondary process won't
@@ -2353,6 +2357,12 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 			   log2_ring_size, pkt_buffer_size, secret, ether_addr);
 
 exit:
+	/*
+	 * On success memif_create() takes ownership of ether_addr
+	 * (data->mac_addrs); free it on any failure or early exit.
+	 */
+	if (ret != 0)
+		rte_free(ether_addr);
 	rte_kvargs_free(kvlist);
 	return ret;
 }
-- 
2.43.7

