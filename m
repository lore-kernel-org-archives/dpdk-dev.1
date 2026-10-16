Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF031CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FA7F40B8F;
	Fri, 16 Oct 2026 21:59:13 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
 by mails.dpdk.org (Postfix) with ESMTP id 32843402EF;
 Fri, 16 Oct 2026 21:59:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKF1wNoRUWfaV34lyQ6XSJAPepCdcF6MVSaC/vxek7hVUeQUa6BgsM5+yhxftEwCoCJ8DL+jMACmhyVq8xNFf75yqxs3py7kGKQToGupQ9NY/7IHFYknLcKgnl3sp58a8r80912SwM9hstrrKcvcfrBw0bkDsD2h+lw4aC8Vs89clE/t0RyDgpfmH7iDYBRu69tVakIihirPtIkqRoY2V1le203eOV89AcHQN4Voaln+Lqlp9Jvs1uJd2D5+lh4Y1kkoUtzguHUIt6x5eE18ncxlP+N7HV6BQkPswH3dyenx7nB/hh1FJ+VXEPRebrKToFpS2LQaMwb6GsU1kybGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e71tApqYizhimSO13TkY0nuaJlNrVO07rcSsIJe0DaU=;
 b=c/nMhVekskzVb0nVuYiIA0uXXu8Sc4fed0T91T0RUlY7sOefkElZ5yFyWfcUJ7KX+n2SKpk+6bW47OAy3PV0Tim6amM10Wd0kxMBH6Nb60QkoJxYOfneB3255wWxYXWIG5kwDyvuhBVx4/p1NUlYkyvSmZTry0e0nR6/aoQWnxE0K4BMw8Tt7643MUqpwCMYPXu+s3LHgvisC+Z3267CyDsvEZTtEUTgW4A6k9T8c0ZysprGAdjqWgno/XGCdIzVkqO4R+XlqNIEYDGQDnfxXSbt/u1THwlHtwYzU/cBuDUxRLI1UbIzTucCh5krDZ7GXp7OJEjJ/rThOZ1r0vnmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e71tApqYizhimSO13TkY0nuaJlNrVO07rcSsIJe0DaU=;
 b=L5TzZKpx3lx6l+TO/3UDBs2thFR2g4FrzuBOKIw4zIRGI8Uhgu7SstnmKFEhPr3ynVV1lk96unOzKsyg5jnHOHY3e7AGEGZ2bzGmc65mqqQ+kQyhE9fMaflB3hLq0G8wNlAxKEFvAvpQNiV8cKheNggOQiL2E1nm86q3RTactRF3wjE8uAe+2R3R36mf+KHdpWjiwbWdeVQh5vC6hGtIFGwA0mRk9BNS4Kn/ZiLniKUzcZNnw6C8D0HpjQdJRvgqz70cY+FCd9Rgx0TXvHP4oIwzelgk7F4noFLyk3nVX4290kKMevkW4EziJO0wHDPtShEOsJrd/HADngtsjq04xA==
Received: from PA7P264CA0262.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::13)
 by GV4PR07MB11049.eurprd07.prod.outlook.com (2603:10a6:150:2bc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 19:59:00 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:102:375:cafe::5e) by PA7P264CA0262.outlook.office365.com
 (2603:10a6:102:375::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:59:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:00 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id F34A34020A9D;
 Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id C3232628589B; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 4/9] net/memif: fix MAC address leak on probe failure
Date: Fri, 16 Oct 2026 21:58:52 +0200
Message-ID: <20261016195857.3258796-5-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008496:EE_|GV4PR07MB11049:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc1758-b2d5-4cd0-1628-08df2bbfeba9
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|11063799006|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rXykF8WhnNyu7i96fUJTyM+VrJNKrMW1TJXSJHki9QOw1Y4KxUE3Mdal3DIU9ig0exUf4TG4Ezv7f11hc/XG3R9PRfvxLr/K96ODhLp4aM5OzeqEmV/dmd6//ifuYHFLEuys7MBLfYN7Y+ZhNIAHCayRaImD19iw3/IcTXWeicPzW0Co0YfccdbP2Mh3mq0BRkSPZQrAn+v5qb1xDbtXudWid3QOK+GyIkl4KkodW25p6wfbF5R0++J65bEfx4hvzCgUv/BV2KtYbFuPupZfdQAn0jCMq/DwfEwrzF611EVvKT82rRzJisv44Gn9toMFFShKkEAbOk9p7zgJH1TXhooHDerVSA2DgWAMLsRSyrF8O1n9tCcN4PAVO2/bauYi2q2TAR0G1l+jQaPuC/rjK8yhwuqKBjwwEOAOHDZjd+gvoekeapDxsFiCqp+uEY1y+KAQnV/1stPvYcdfjxkqWipR6anmMZ7wDu/C3owKIJgSHU1/Z9TDL57aeXKUDzXXbh72Y9NEa5DN0onCynLDrzd0KU75tAdrOU/iJIv4QepeoBAQ1psWCwSZiXxZSvi4ynbjGczfT/IJNBxDEGmQAIxtnL2QF7lJe39aY1XVpLXJend6t/LXiA1I50rTQ5BfdQNg5KycA5XUo15r9yr2R1m240ikbXPhohPvhvg82Bn0XD6QW8IIBBM2NKDsUym3QmoRoXojJPlogMFE/sAIJQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cf55CCRWSvYYCQHMwX3OSgAEVKC+enuIMHrFrG+3LuEWQAYJRwdJNbCKY/OH9XfrP3V6HnZCHCmZ8y5PZZwWvvJwwoO2a6lo/wD1fUd6LR/d/GXVBNdxHQxnhg1Jv+tK/QLXbbS8X+XypI8sehVp5IC8y2IjsdF2KEuC1zzXJd8mxfv9QM33/hm6MkpBdjWk/Mm54DorkQSAFf98fEeV+NHgHP3GaztWlISt33qdGtXEMgUSOhpAskTnScQsl5DXa6/nqjxyXvMEpQD0InOIKpWa1P1jm5qceTj05+gOjd/oy6fHv8DFJvCt04n0Pqf2tYOBktb7RtaS7KA+GWbiJv/TEzeOItPQZBPX59gG10TE2viQ0QbpEZ7duTzztHpVPje5viMKb0P1tTcFof9x3qCT660iFo6mU0jNjeVvRfTNt5Sq8xeC//pdRoSqYi43
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:00.1532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc1758-b2d5-4cd0-1628-08df2bbfeba9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11049
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

