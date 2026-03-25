Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C8109C040
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C4B841148;
	Wed, 25 Mar 2026 19:03:58 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by mails.dpdk.org (Postfix) with ESMTP id 6988941101
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:03:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Fdk/nSbeL1vb3wD9lyB3R/sWyJPwtA15JntA6Jr6ip1J79i3xNffAr2ZwUfbNnyzrAUa4QjYiQ6sqPNIMwVuDaBexoA47Y4XEZh5mTUn7UwGfGu/fq5cRuLEp/Jj50rA8GhD8VpDi7flgzGr5OgVs8bobip6lU3t3p8mzYLPlKkemw54CxnZ/2IggJ4iseulj0dPLwAP3cHdHqPIsBrzr+i7kEl7vziKASRJx9lcrSTFtUjQQlJZOCDNrXkQ3+Z0WiYC6/vZE/alTrPpyfNddeliRR1HSLsh4tBUsbRrd/ZhGlDpQl0WFkEEs83KelP2ETbXD/mi7Ra1pZgmL6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlkzL6w1sqhOEWxSChMbKaZd+pNKAHApOhynnepSB3w=;
 b=jkTGH0sDgYuOlBmnN0odfaXLddCBS0HA0o5B1qWVMXCytdfk3t3KwDc9hI6nbcq6ijNYedrkfxT4IEgIkBLF5do25EqbZD+FuF2URXInyXOg1lUgM//GySkwOaC8z2vjIPDwrF8uuAY33xo3wb8xkUuKy8Cv3Yfc6oh8Pftl6oVM08nkL/yUw09MTGwJX1xAJyowi+FnyknHzhB3x6/JQ9GhtXCpA0cR8+qPD/uIKU8V3feoqXVCfSR2zZV+iUE5iQ+olJvgvJSWCoTOlbB21RlkVRCzEBbPV4DjtsvKR5Ix5Js4p//tgVkoL3XiARgn3szrlFktXNC3y6Qxwu39HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlkzL6w1sqhOEWxSChMbKaZd+pNKAHApOhynnepSB3w=;
 b=dZ3aolHGXzKulLW5VmMlflxfgxEM0hlomHTGsMa9LtReAV2kqf5QvXPVtw+aObNr8oBBlKEgxNGLWzp+bpcyXM25QNsPrCapkO/hIQ80MlEZpno87XDEOUb52Gh3CLlopyYRJ8Wq6oY4Nd+lCQTmlKZbNbJu/nO2//GkXjncXEntQ0JFnv4nTQW7iplFUjQNYljl5hsVMwil+uFzSjjC3LjRXxWUFvxb7IKa515LhRYhYEYHz3hUWMSHpT9dly2/spwA+3HAZ5K1QDMrVmBPdy2krz00MgnwlvkN891M1Vjv2Aqr5VaQmi7gZpUprlY99XXJdrI/9BoMHpQXGiIlNQ==
Received: from BYAPR08CA0019.namprd08.prod.outlook.com (2603:10b6:a03:100::32)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 18:03:50 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::6a) by BYAPR08CA0019.outlook.office365.com
 (2603:10b6:a03:100::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 18:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 18:03:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:31 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:29 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v3 2/2] app/testpmd: revert switch domain mismatch check
Date: Wed, 25 Mar 2026 19:02:54 +0100
Message-ID: <20260325180255.57489-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325180255.57489-1-dsosnowski@nvidia.com>
References: <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260325180255.57489-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: e98130fb-67bf-4d09-e5b9-08de8a98de59
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OxUx9umeJhStA0G/z7GMkbr156iHU2Qvv535jk6l8X4kpBlV7FQdaBS6Zr+/eJ+lQx7qZghaXPnux3jj1vohs8MzIlqrQgf1qDytduCWST6qylcSFLp5sFU7WU0IG8oKVLGsFXnirzctx5RtIlQ1VDIXgZSdtv1TlCgpJfOx3gyno8kRzVqjJJq1nbesQXJ5VNpuBbeineZGY5+b4djFiPB1XBOCDa64IcHDZn6vYM+R1aO8J3+gU69hKfcCFRJEfLGwRXf6wa2Y7BWrljDCkipxx0TjyymGFNKBnAoxELC+raCzBwjAA6310ZNWTvLjWzXHxelqLXR51lm4Yq2bl0jHpMeqvXctTQeAPAqQ6ji7+7CNOSK1sQNr7SF6c1bWmgFDrR6it8NyB6UUJjRlXXhVMJyS3JwZIYtO9MrWImKuV3HLVUNVwQzPLUDUHz4QD0RxIOEbxSpFkoKmqAh8otzFAPXooFjRM+NSgHRN92nwvDWAprZZe+S85Tfn4zVl1+K3Hzs8gjIsNqcNhicE7OkaEacE/6gb4UUjiereMf5DYrteKGTxt7JHX5g1c/bVm2TuByNHK235hAdX/WfLoDjvhJfw5VCTPQ9kf6ghkkrZO9thIyEbatyJaCDh4T2XXAgwY4dJq3i1YPr2syc+CE2I9wco7S8p299aQwakOOYSL8WLGd1BcMrwn8hjBxPKQjdOJnuI0zlcZiFqMsqQ+GVvdAsSBz/mTDMBE43p8cMoG3dyuHJpYQw4pGz1fq7hfbe0Fpk+iAnErkdKAzY62w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FmiuwU/c6EwrhIsfCvWE2OKcS5bWccATuWl/C3i4cY+RSfNH/VqVjsc8UYA9lFgdA6iO+W98en8dtyNi6ryFatMhTjy5ExRd7rR9SSS3pXpSZQ7vp4bIDWAs67xt5dumLi6cC6+a7pKkn9utB+n+ADQxJL6nX1gylAD89hR2uimemA47i4NcI8BYwALppx/RESwNJXspv3l4nBH2o13G13cQnte/6M4pm1yBZew739JwHfxzFXSO9dIbDG2yM/zD3K1DoHffak1qzUX4V2WCuHB0GAdBgLIOIcILbhXKxH4bxvm0SjpBmf2HVPNAFuk62Nj/KVpcpTK2d0hU/1LkfDjzWhRNsc7aqaQ0PH8yw7OWPBPEd+RKOG5BJUUU+lK7kqiYeF7c9m77SgMCY+v+3pqjV2uQLTQVGdOTSlay9jiWlYx9LCRut+xOnRGr45UC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 18:03:50.3016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98130fb-67bf-4d09-e5b9-08de8a98de59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

This reverts commit 8ebba91086f47c90e398d7775921e05659c0d62f.

Previous patch changed --rxq-share parameter logic.
If this parameter is passed, then unique share group index
per switch and Rx domain will be assigned to each shared Rx queue.
As a result the check for domain mismatch is not needed.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/testpmd.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index a70efbb03f..20501acf9e 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2747,46 +2747,6 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
-	if (rx_conf->share_group > 0) {
-		/* Check required switch info for Rx queue sharing */
-		const uint16_t dom_id = ports[port_id].dev_info.switch_info.domain_id;
-		const uint16_t rx_dom = ports[port_id].dev_info.switch_info.rx_domain;
-
-		uint16_t pid;
-		const char *mismatch = NULL;
-		uint16_t mismatch_pid = (uint16_t)RTE_PORT_ALL;
-
-		RTE_ETH_FOREACH_DEV(pid) {
-			struct rte_port *o_port = &ports[pid];
-			const uint16_t o_dom_id = o_port->dev_info.switch_info.domain_id;
-			const uint16_t o_rx_dom = o_port->dev_info.switch_info.rx_domain;
-
-			for (uint16_t q = 0; q < nb_rxq; ++q) {
-				struct port_rxqueue *rxq = &o_port->rxq[q];
-				if (rxq->conf.share_group != rx_conf->share_group ||
-						rxq->conf.share_qid != rx_conf->share_qid)
-					continue;
-				if (o_dom_id == dom_id && o_rx_dom == rx_dom)
-					continue;
-
-				if (o_dom_id != dom_id)
-					mismatch = "switch domain";
-				else if (o_rx_dom != rx_dom)
-					mismatch = "rx domain";
-
-				mismatch_pid = pid;
-				break;
-			}
-		}
-
-		if (mismatch) {
-			fprintf(stderr,
-				"Invalid shared rxq config: %s mismatch between ports %u and %u\n",
-				mismatch, port_id, mismatch_pid);
-			return -EINVAL;
-		}
-	}
-
 	if ((rx_pkt_nb_segs > 1) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
 		/* multi-segment configuration */
-- 
2.47.3

