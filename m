Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA3C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B979B40ED6;
	Tue,  8 Sep 2026 18:27:45 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5F09240E19
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:27:43 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023123.outbound.protection.outlook.com
 [40.107.159.123]) by mx-outbound44-93.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 08 Sep 2026 16:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3KPR0whY7kxB7LkfC2VxURVIVJYCnGc/rdeF6nLZKSBSNK0SvXhawJGQ9nkjjQGVPuZAA4ZVNqh8VRNvNBgOPE9zkDooixd7Y3L5DxEC4UKdAat6IIG+FUWR77YZhP/5da+NweCkg5ybPf+GR4fCkR+GsLhHiRoUj3Mtvn1xi9IaU+HuwaDmWL22qyLwLdbNxXv/OWcqls30YNdrQwEGiWl4Rnbpy+cW8uj6MehF9UV4pdW6z2u+Is7wGHJEScdnhqTj67hYGVxr11Khe/shbrt0dDXjoPFbQHgfNfAgrhztFVYGPxrORhpTtPA0II1lVVgZrGxBpa1cpGFIAH7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkJbYnFMPVsCxv0FBn1z5oXh0TpC7nN9OBg1zi3U+XA=;
 b=Rn9pOeHbEF7+b0YzJMjWqQ1C3WWaDsvESb+7TTlMjlPyGkMAYnyVSgewAnB8DFkYGcQYFYyLmP6nWP4qUKtyK+abj8nKl6R19nG/zyYkVTsz1aondbUieClBetBAkpPtNcUx9kXnFkXoF5wEZj9zNEiJ/Ifr7NE1QNAXKlTo8muynUbBFEatl55bnKa8ai32Wt7CA8mmgy5lI8qpJcSUOrXtDwGs2cCUgVhZFOFmTd1k8V+Yg+Uo+xYmCmF2HXLrnkEz2w9rlstLVDamdnRH54GatT5MGskKvRAMFXBsUiKm3O9BlGfWIUDrDH7TdKNyrqOgggv7nVHWyuGYdkWPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=napatech.com; 
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkJbYnFMPVsCxv0FBn1z5oXh0TpC7nN9OBg1zi3U+XA=;
 b=L6N/DwdLl6N6ri6MgFszg5cTnPbVYncdYUF5dXonB2xpCx54dNIihpC2jCTNv/d32bQbVFuf8/Vs574MsnHAeEvfzVM5Hoe6z8QgYSsbhFduY2UF5GVHfsIcpKgrENJUo0dYXggZ1TEgvTOtdkLqgpjvqIIFiD+LJkGCjhgeTE8=
Received: from DU6P191CA0052.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::12)
 by PA4P190MB1151.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 16:27:37 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::4e) by DU6P191CA0052.outlook.office365.com
 (2603:10a6:10:53e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 16:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server id 15.21.382.8 via Frontend Transport; Tue, 8 Sep 2026 16:27:37
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: stephen@networkplumber.org,
	mko-plv@napatech.com,
	ckm@napatech.com
Cc: dev@dpdk.org
Subject: [PATCH v1 1/3] net/ntnic: remove unused unmanaged virt queue setup ops
Date: Tue,  8 Sep 2026 18:27:22 +0200
Message-ID: <20260908162724.463767-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260908162724.463767-1-sil-plv@napatech.com>
References: <20260908162724.463767-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PA4P190MB1151:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d0e88a3a-e26d-44e9-5145-08df0dc618a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eJ/LW890iRPQfiixbhrydwA5PIyOYYw96ZXW+ovFN63pYUVh7NmGO9rAVoZsjoZ7GEzz5DbSt7gRxllysAuABxtzvTV4MI1FCCuD5vbeNAStE4aaP4ocoJ46xVM5+JQ6rHmFrhTog5PWyea1qslqA+/+jAMwKtnyiHiRCNShbvgF7dwgW+mbNIKgV+ruXgw1k24MauCAMD7e9U8KlR4y7q9a2ZagFi4B7tOvlZIVZaj3eKRX2jhueJgd64UbFJ977oPXTziYZsVm/mkbuuPjsxjFpbO9vePbTT+IKO/FymefoCevXqiiI483aF+5KBTguJZ8rTV2k+dYB7EDOae6I/TzJ+XmLeD5hbA2OZ0nEAltwCsL7RwAulqYr/1QMQsu4H4BwTuFy1KZ14zUT1VHzZo3o/QWtXyxe0B3kxaQVCHkYrS3+ruwPAgHBO7uyHe/eI3o9gw+r7ceU26UeV2dEurvgbjCgmwR/EHL9BJ2iMAwLtSy6CWLYqFQmYDASHs2TKYl/AJ91NH33jIsq13W+KkHe6qXfH+vyqm1jVqE5u63bSOiHUGBiza8awlc3HnVW8BzeAu9y7ZLv3Wmp/EXOmbu88w9mvvs0eWnBpgSGiY4fLpHUFDUcEvYZC1MiSQAb0QmFyQgsCA9YKIbtH9macM37t8dw+2L3kXvmcUo0UWDHfV1GwmpjbcxzimNqtQDddcLWusAL/j3ZIt3TwUYQQ==
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FeBqu84Ed6mN0dd/XQF843tn42NOVxZbJBMrIgWNpH4qK7oWlNCbMpr4h5iNlK7RZ4q2KNk2UaBBhA1zb9fCdh+S4dspyNvme1WyOeJyeDhqY2vRDBCZ6DB5sAZ0Np/5VYruD3tfhnphNPEnD3dYORRjbqjL0BzEWaPODfUwxGAZcqZ2VWqmz643xTJlEvsVLnYAAQdanbL3w4RS/yBzf58Jt+PveBbELml6JrzmrXgYVbTXfft42iSzKv2JZwNE2Ip5eXD+QbksIuoy1t9AHFL8r+MWMJRZ/sfeAloa/cPxR9zgWrzACQ5kyu7MCvsnNuIpmYb45BKbYmutTCUM/Ikh1HgQmOd0axgc2lWDjemM6jJk/iAr0+Ri/1OkKC9VNsJems+hMCI8z7LJrjqFFy7bCoVgL+3Bm4QZ1BOKN0mnLFTDEUGBldJfODG/K1Be
X-Exchange-RoutingPolicyChecked: lU7OS1KDscvdwDf0JyB1GZxOjRnDKbGPbVY5Lv6PE7JCv6s3zalt5KDq34lxgOwgDdd316XRJDl1KlwMeXjXNx7vSUh9eBlEjNVg1wsGfhXR1VIyr49UQPii8HJpJOapUMhZlUBomTjii2nsHCgifx5IxNsgzFvCU738ThHkYxiYU76qbPmYFs5TSuCi7OXkcG7ZF2EZvlPmgAnCRiJGpo2EIH5zi7s9ErjOOmfj78MEaddMarBOX4mfbn8UkN5KLphZeqZSuR86fea6A4ez2phhZyeaHDaE6dJ8qheI1FvBCQhQqff5x0BiI3/R8LsTp2AHgFUWi02ReTVdcMcieQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yAB5TjQL44Yhbua3Rz3u9BWQWf2/FS1tjEhcJseB3b4T3ohf/UFhw0NsUVmoZa584d6A5E3TgNNax4AdsbO/4E91HTvJ8OAWwA/POwqD/Jlw3Hok8Pa3LgFJDUA95ZypoVCKTzlkMaTz9B9pnpnhiil767sUDertIVzRY878XxirmDbFSiDrQ2eqd0nutk7gCQuS1AltZrZ0Ws+6ifiTdX6j+4U8+HxUZM0AISQ204mAX9JmEv48gGR/2fxMlanJQU4W8Zi6z/2wGwAiPbvibGJ2FS/2Jiiu2JjJJhs0HZ0K4HK+yXsft08sTH4dG+stFGM/F21+fg4iG/f32ShdXGMaZeM9Jl5gBWTu3r90FibmOq3tckgd1QxexNtjyNVZVWV/Q9dGav6+NLSgeY5zIqvlfCOrej+k4aFoqWl+ctQxP6YQuPZsayWUiBzdSSa9vSlXNWt9HA0XsYKrKuLR6vA5PtgNgQ+iwH3DQMOIfIezh468vGnd4KkwqfU+A+/5IpwIyOsnNjAQQFJMglx4HFkbaL0cCHBl2CAl0kCF0bMnToyGL3+1wWr9Rx2U1P35vOrhE8HhSecvlyCU+bf1Dghpexw5mGZkz4axPLxz0916ua+U+3YuXpfZnyHIc+z47FrOJMGAJeEAyRRJURnzVw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:27:37.6861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e88a3a-e26d-44e9-5145-08df0dc618a4
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1151
X-BESS-ID: 1788884861-311357-15606-2163-1
X-BESS-VER: 2019.1_20260902.2230
X-BESS-Apparent-Source-IP: 40.107.159.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJmZAVgZQ0NDC1NzC0MTAIM
 nEyCDVwMDMwNzCzNTQzNggLSnV2NBCqTYWAJggsZNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.275977 [from 
 cloudscan20-20.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

The unmanaged Rx/Tx virt queue setup ops have never had a caller;
only the managed variants are used. Drop them in preparation for
allocating the queue state per queue.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  2 --
 drivers/net/ntnic/ntnic_mod_reg.h             | 30 -------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 56eb710d25..7c10acb4e2 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -1432,8 +1432,6 @@ static void nthw_release_tx_packets(struct nthw_virt_queue *txvq, uint16_t n, ui
 }
 
 static struct sg_ops_s sg_ops = {
-	.nthw_setup_rx_virt_queue = nthw_setup_rx_virt_queue,
-	.nthw_setup_tx_virt_queue = nthw_setup_tx_virt_queue,
 	.nthw_setup_mngd_rx_virt_queue = nthw_setup_mngd_rx_virt_queue,
 	.nthw_release_mngd_rx_virt_queue = nthw_release_mngd_rx_virt_queue,
 	.nthw_setup_mngd_tx_virt_queue = nthw_setup_mngd_tx_virt_queue,
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 81ba1e44f9..1b5047b3dd 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -24,36 +24,6 @@
 
 /* sg ops section */
 struct sg_ops_s {
-	/* Setup a virtQueue for a VM */
-	struct nthw_virt_queue *(*nthw_setup_rx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
-		uint32_t index,
-		uint16_t start_idx,
-		uint16_t start_ptr,
-		void *avail_struct_phys_addr,
-		void *used_struct_phys_addr,
-		void *desc_struct_phys_addr,
-		uint16_t queue_size,
-		uint32_t host_id,
-		uint32_t header,
-		uint32_t vq_type,
-		int irq_vector,
-		uint8_t rx_deferred_start);
-	struct nthw_virt_queue *(*nthw_setup_tx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
-		uint32_t index,
-		uint16_t start_idx,
-		uint16_t start_ptr,
-		void *avail_struct_phys_addr,
-		void *used_struct_phys_addr,
-		void *desc_struct_phys_addr,
-		uint16_t queue_size,
-		uint32_t host_id,
-		uint32_t port,
-		uint32_t virtual_port,
-		uint32_t header,
-		uint32_t vq_type,
-		int irq_vector,
-		uint32_t in_order,
-		uint8_t tx_deferred_start);
 	struct nthw_virt_queue *(*nthw_setup_mngd_rx_virt_queue)(nthw_dbs_t *p_nthw_dbs,
 		uint32_t index,
 		uint32_t queue_size,
-- 
2.45.0

