Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F739C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 10:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF4A402AF;
	Thu,  7 Aug 2025 12:01:03 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by mails.dpdk.org (Postfix) with ESMTP id 6A509402AA;
 Thu,  7 Aug 2025 12:01:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMDTphOGjTEaxHNC4OteARqo0vT7miFysZnsV0fbt5EBCn27kShbYX3HC+mvsp2tPcz9Jsglm+6gqJHLVwl4OI/sEiBDNOhAvRckXTS63bb7y+4KwhxblPAQdDBWnSG2TONtJn36RS3rmemWFmCXGeL+OB5LZpQducKMpRUGr1KP5Cum/y58lm4gZ4b3flBTcVDnH8MBFRa7A7x8Dunxoj5DiCM2Tf8b0CwM3mAMnr+5DANEhLB4dno5CaaBN2cic42thZhI3lm7sGs+URsdSyAvKdCWkqbRLjM+jvVU21Faw9HkMfJPVklyJa+XExlxzdj3qnkk7t0x/a9j6l6Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbsmiuWXGxj6pGzNGx7GKP6PxmusQQVHliOMuQCuh1M=;
 b=WGKFwJd0f7KguEY5aV4sA2m5qQ69pNWBMxvP1yA8/i2qL9x04DnpTkglmSkB9fY/8KPXdBoYgyT+7pgeSbPSY9SyHxrUQ01MQ1t88d2JKLlOkm+Ar4gB+40TnB2lQ8Qv5o2wue61Bo+LjPzRz3gfSB2gI28uuf7DYn4Tz7kSMyup96JvecoJveVLQu+cRwiUZZPeh5GoRZkemBIVyT9KYcmYgM2u50pWAoBY8r7BsV4QKFVb46tYopEvJ0i9tg/EycuXoVWhCW6aMVqXlfojwzvyTX1wyPfCQkpr+16PuC0HsOrkoCKSK9UyuEbJkD+SaET3LUaMZxw/Ba6tEd97nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbsmiuWXGxj6pGzNGx7GKP6PxmusQQVHliOMuQCuh1M=;
 b=ECNM9iKpnKH5HWezwGD8iAewM6nEeueBZ/NDSJuhyD1xRuSwC/GJk9Q3KJVAzR98clYe5wRUPVJ0AlPOACLtwC/gKAlf6lMwEWKflm20az11hV5TVJmG+oc6j5zQgxTadoKdpc421sPBd2iqmvaa8tSAf8O4GMkv2MVk2ilGWfN7cIH1JvHEeaU5M2N9CBrPKt21P3BDDEM3T1IcX4NMz7hd0w+oLTr0KWD+zb6Y3BkaD8KkWy91icWCjrPVn1sIaYH09W7kchsI6sUWNnwHhzpIBIhYXYyVaSrbch2Jy0fo6DA9MlOstTJBQw0+hbEaEIi6J01xdY0aMJWsNj5DEw==
Received: from MN2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:208:a8::34)
 by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 10:01:00 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:a8:cafe::6b) by MN2PR12CA0021.outlook.office365.com
 (2603:10b6:208:a8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Thu,
 7 Aug 2025 10:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 10:00:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 03:00:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 7 Aug
 2025 03:00:36 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 7 Aug 2025 03:00:33 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix double free in non template flow destroy
Date: Thu, 7 Aug 2025 13:00:26 +0300
Message-ID: <20250807100026.157277-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b50279-c2ad-40d9-cf77-08ddd5994f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0MjBaq1Nlf7Lxwaryeqj0Aj8JYwoUqxnZbwLNph/07oJgOSMj6F4ZK0PksWQ?=
 =?us-ascii?Q?BlXUdnVlgQVn9JH9ae5LV2RvKNkyTmxV+USw2eJWikd7f3F+v3i5xnLcACMB?=
 =?us-ascii?Q?rsFGQCRhM/RIpjAiMX5bvUXAHRiEUBClq16UtuX8//Ac4O7K9uTxM0JkPx8k?=
 =?us-ascii?Q?j1TXC+igM9p8Me1XRj78ZzBfwFMT6+IHhLWZZ3g5LqHs2LLPsT8/b14lowsA?=
 =?us-ascii?Q?VLvW5cyac4rrp+B26Q7fka7JzQLyp/4j1DMdSq9V1JkecQpGvPk5tmWqi3XN?=
 =?us-ascii?Q?sOI0cf1A5///1ipYe9E7pFru6nYJNScaY3iFtykEGDk+Saj1FsJqalWxA3qx?=
 =?us-ascii?Q?Bcf71ppmPUteK8W9uJofUtW7wm9jzoG++dIfCytIwQwpJCPE8oAB1Ob5M06o?=
 =?us-ascii?Q?e2AHxJaVK7CUWTj4/fDeJskFy0M+f/F31LpyRxPc7LkD5n1Spc5HXcFEXCQ0?=
 =?us-ascii?Q?8nG6Exofsqe+th+greJQseK1GIG0S3xFpLPVtWvpEHnCgspo8ZnKAm+UPRn9?=
 =?us-ascii?Q?akvsqHImDP0298NSD2eeQMybfQNME5HvRESioPsW1K/uce8WlNEGpl3C53cx?=
 =?us-ascii?Q?KNl7szdH7SQSgb4YsdDCjZbP+wOSvcMX2Pw3eQNShYlOiHLt7q2xyLgjvJYe?=
 =?us-ascii?Q?IyaSXi9N1TAUfOis3aDdfbO/zXYJ5l+MaMe9I9zolpR3NyyhBY5+dR8fEh8p?=
 =?us-ascii?Q?gHW/kx22lVWEYFfGxntGSaHkcgoSTrZ6tLqhgDqzmWv+PTDuw1+OWulBaoLT?=
 =?us-ascii?Q?7MDSxLDlbxvAWxPbDB/2sOEK2lll/+e4PdWCDj8jW2OeUkE+RpCe1VE5pOFA?=
 =?us-ascii?Q?gxo9vnooUNxJPKmmUwnP7F8u+mYJN6Zf6g1E93xDEkMStuet4N3/dc3U2jjl?=
 =?us-ascii?Q?fE48R+2BvAMufbP6zp/EHT3yNF2Dko+KvklZc66UjV2PM6PzsBiWPtH0r+eb?=
 =?us-ascii?Q?hhdZBcZh9cKSMQ8Tx57c9vh+TDTRKIL/NS41OxJIho5HTtbeEtB+ypU/bFLt?=
 =?us-ascii?Q?E39XfTwwpgirhVeeGdvQFri29PiaeaiIG8M312ORfzPn33VJoUSfWRurfTAm?=
 =?us-ascii?Q?ZSfDI2r3rOaADX2dedk4DAQqZTpb+ZaNf3jV2BtImNgRFf1mYckO17Ufmj+b?=
 =?us-ascii?Q?UOqNnlp3T9bHp0Ma9tWvLOPWoJ8HZNDf5n5hW9TzWdV+QyZIjf8dsGO9gubM?=
 =?us-ascii?Q?vAKJJdN62RIyoxUUkKW9bL3rAhrJUrRwsXM4RSEDotS3PcAHoaEirIuEyYVA?=
 =?us-ascii?Q?Pq5jQ9+THaPhiMorP0UzrRwkfDjtNhipErFiqPc71ywi4RmiBeMduPXCqrT5?=
 =?us-ascii?Q?ol9cljwpJ+VDIJVhsUD4rqGjV7SoGgVvdsm3JmVdo0GalvmsZVWEJsY9vfJ3?=
 =?us-ascii?Q?ALw/CwiBXiv/uYFpxIcSAkrIzqnzCSXANQNhuFmjeqeGRUPFPCX7bRK68vw3?=
 =?us-ascii?Q?uFnGk2aLJ9LqtwJ9CFguJ/k77X7kAAjjk957fT2GPsqd7UxVY6YhOEVcjDAC?=
 =?us-ascii?Q?1MBg/EljJNbd74UWwMnZ3Bm7huxWMepeLsGi?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 10:00:58.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b50279-c2ad-40d9-cf77-08ddd5994f0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

Avoid calling flow_hw_unregister_matcher twice when rule creation
fails due to insufficient memory, which previously caused
a use-after-free error detected by ASan.

As a preventative measure, clear released pointers in
flow_hw_destroy to avoid potential double-free issues.

Fixes: b2845d51c748 ("net/mlx5: support FDB in non-template flow")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6dc16f80d32..062d2903a73 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14082,11 +14082,6 @@ flow_hw_create_flow(struct rte_eth_dev *dev, enum mlx5_flow_type type,
 		mlx5_free(hw_act.push_remove);
 	if (hw_act.mhdr)
 		mlx5_free(hw_act.mhdr);
-	if (ret) {
-		/* release after actual error */
-		if ((*flow)->nt2hws && (*flow)->nt2hws->matcher)
-			flow_hw_unregister_matcher(dev, (*flow)->nt2hws->matcher);
-	}
 	return ret;
 }
 #endif
@@ -14104,6 +14099,7 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 		ret = mlx5dr_bwc_rule_destroy(flow->nt2hws->nt_rule);
 		if (ret)
 			DRV_LOG(ERR, "bwc rule destroy failed");
+		flow->nt2hws->nt_rule = NULL;
 	}
 	flow->operation_type = MLX5_FLOW_HW_FLOW_OP_TYPE_DESTROY;
 	/* Notice this function does not handle shared/static actions. */
@@ -14118,18 +14114,24 @@ flow_hw_destroy(struct rte_eth_dev *dev, struct rte_flow_hw *flow)
 	  * Notice matcher destroy will take place when matcher's list is destroyed
 	  * , same as for DV.
 	  */
-	if (flow->nt2hws->flow_aux)
+	if (flow->nt2hws->flow_aux) {
 		mlx5_free(flow->nt2hws->flow_aux);
-
-	if (flow->nt2hws->rix_encap_decap)
+		flow->nt2hws->flow_aux = NULL;
+	}
+	if (flow->nt2hws->rix_encap_decap) {
 		flow_encap_decap_resource_release(dev, flow->nt2hws->rix_encap_decap);
+		flow->nt2hws->rix_encap_decap = 0;
+	}
 	if (flow->nt2hws->modify_hdr) {
 		MLX5_ASSERT(flow->nt2hws->modify_hdr->action);
 		mlx5_hlist_unregister(priv->sh->modify_cmds,
 				      &flow->nt2hws->modify_hdr->entry);
+		flow->nt2hws->modify_hdr = NULL;
 	}
-	if (flow->nt2hws->matcher)
+	if (flow->nt2hws->matcher) {
 		flow_hw_unregister_matcher(dev, flow->nt2hws->matcher);
+		flow->nt2hws->matcher = NULL;
+	}
 	if (flow->nt2hws->sample_release_ctx != NULL) {
 		mlx5_nta_sample_mirror_entry_release(dev, flow->nt2hws->sample_release_ctx);
 		flow->nt2hws->sample_release_ctx = NULL;
-- 
2.21.0

