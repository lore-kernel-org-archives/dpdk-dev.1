Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B39CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 580F440A8B;
	Fri, 16 Oct 2026 16:16:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
 by mails.dpdk.org (Postfix) with ESMTP id 44EFD40609;
 Fri, 16 Oct 2026 16:16:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPrD4MtH3emfskDpCi+G5g54O3EtmIDcJtq9RoiBWg6vDFIUR5a7E5nnjRFQTRRKypQS9nRZOimHUo9mO270gH1664N9i2p74ClK17jgnaYi1M0gYgVG2MSguvEbYBG6tWd4uCqW0t5vdUCJRjsAiVXN2sNUrQ3JhWivMQyfB5G140ad3XO5EsF6Ic8RCeGLtDwR1kocuX3m2htDcV6vfjmii2Cr71w7Uy6m2TMzAj6Lrv6v+2cSAq3TECgi4h2VwXKZ56THa1egYcCm6UuQ7vuaZ0TbOai/XazJH/+uLfaAs2yShK3PVWyVPfWF5MNSr+DCnuftwGlgijRucGCBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e71tApqYizhimSO13TkY0nuaJlNrVO07rcSsIJe0DaU=;
 b=V6TmP+CBqGc2zgFrtOmhxBCX6mt5TCCJ9lBIUSHW/H1lkd5aRcNMPZaw6nY8u8Zb22KshTSXbo5P4xj4dQonJ0N6dRdmwfM8r0iw+kFagsonoaJwFhkhHk7zId0otD58DniL158znTvbYn1f5cj9PGMwZrOP3CnpSco/b8TGYbiqIyYKblmgWWb4UAKHIZ9/wT3KDjocw+uLL6bNFMJ4PueRy6wEwfIRaly6/i2kXpgF9/Bs/GIEmuxfdKABwIf0gZMewbkAcdy+B0ghgtkN1ex1Dgb0UEsbXESjPQOw3A6nATMJyigljFjJlK11u/+9jx21+Z5KlEVz7SyrA0tfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e71tApqYizhimSO13TkY0nuaJlNrVO07rcSsIJe0DaU=;
 b=kWq1s/ZEChl08zjwCVpBWczW78hcm+O1DHA1qPcMEy1YBNiEZw7hw/W5WZrR7Rd1+6spUJEUqub5Ez1hh67YHtVFO0kjR3CCzkLS7o+FKHkoT2KyMdTGuc4yM+NwWWwF9VubAcZKMjqKjv0bNfXbO+2qKgP317/2AfrbrMv5KFb2AsQ2V4IEfwQyDRuR6/ka158dZE5GwTHGWPxie8R2dTtLss55lrwUB1fOS78R90EOE/kssHmUIMfFRSca9XnrZ2Q3H8HCtELB41KMJrqQFP/ouUIZmJbINs1iy6CRgthZce4KoiKkIcOA5PnzTWGCoOzlaEeYUpOO9r0lTt/7tw==
Received: from DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) by GV2PR07MB998015.eurprd07.prod.outlook.com
 (2603:10a6:150:306::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 14:16:03 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::58) by DUZPR01CA0226.outlook.office365.com
 (2603:10a6:10:4b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:16:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:03 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id C07B84020A86;
 Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 8C1CE628589E; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 4/9] net/memif: fix MAC address leak on probe failure
Date: Fri, 16 Oct 2026 16:15:52 +0200
Message-ID: <20261016141557.3081522-5-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|GV2PR07MB998015:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ce90a-0670-419a-a73f-08df2b9002e4
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: C+VaKjlptCMFjwqv/f6idLRdkTkZY/8g/xvTjjGuzoCuNeGYL0kd74R89NM4R68brAKJWyaanz2kP5f9mYt3H5RXhIPCCWwHa976hveOx2Dx2Cjh+EpW63JAZjyHy+qNZCG9KakW37p/xC8c4UAq3XlP2f+hnO/p8TMu0Igh5v2JIBcJlxI4OJGQ8JpwUQQsaD0pOOcnY95XBxZOTxxSFd0eZ21dQsNUL9y45DQdJCaY25040WGAbVN64OgN6Im6kGI9FYS9PTdy+kizrqd4LuOxar9yA5tOFb3uj2VEg0sU8hIGNx44ipO6qrh1dVHD4iUXJRJe4Eam6aQJiDxuY3xqu84xc4ggNGTCoqMh0ztjbGDYsLLCxJjGMS0jnndDxBlEbwV1uZe8zZP4J6Nf58RQdzMj+/tFrhAMWHnBJ1NStaLyVXxt5SzgD0W/Z4T29hFy/d4tSKQ7IJfdeZlqt2HB79WvPFrFsdP/4oemMKmPyFqkxcPnx7aw1GOMroFVipcEWJ51I86F/IF7ekLXZi4WitQj9CBu9LbeEiz2mVSsLfriABscns19FvwMdJuqHV10/P8WPl76yd2ILZWna0PBq4s+HWazf7VdkTarjHUol6BDsliZi2ragpbaMNlWpHXQlVnmX8T+JdPO6e/NIr7yZsSdPIqGzDjJJJQiwa6v1/spgflD5fb6JNye0jZSGoIpFmNx1Wxn4T0ePT8tNQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DpMizvrvmh6qzrfCzLX6EiLlqYeOeC5O9BAqTCJv4XmxkYHe9TyzncTizqQfsxVi9BUFUqAv4vrTcTEie5ooAckDpoqJs1lhdPOTJ8BAYKwW7ysTDBOA19NHTawK20bILutek6ukYp6kPoiBSnc3+s6O5UAE/f5RGXr0z+C6goJFrccrmucNNcsxdSMw4UCjaFz9KisLSUnnAfgZGGtVI11FAjU5sBL2QYGBIuRFagjayKU0neP8H/+s7Gk2kH1Ps2BzfeoI2ROav94mFMNIooR11Z1CXheBTJZ588k6GNB61M0iSjTa3PrERzPuVS5berqdEKpryTvjivhUUc779z10sQxwz6xmkYTkvBnWDOoQEd/gZuris458xTH7JQNRDmOIFDsZJqE1O/rM8qT1vzcOjDoAKSErVQ4mExWI80BTqCrWku7aaHc2WzoJ3dId
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:03.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ce90a-0670-419a-a73f-08df2b9002e4
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB998015
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
While here, return -ENOMEM instead of -1 on the secondary-process
process-private allocation failure, matching the primary path.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index e753243440..70359554e6 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -2232,12 +2232,9 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
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
@@ -2264,7 +2261,7 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
 		if (eth_dev->process_private == NULL) {
 			MIF_LOG(ERR,
 				"Failed to alloc memory for process private");
-			return -1;
+			return -ENOMEM;
 		}
 
 		rte_eth_dev_probing_finish(eth_dev);
@@ -2272,6 +2269,13 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
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
@@ -2346,6 +2350,12 @@ rte_pmd_memif_probe(struct rte_vdev_device *vdev)
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

