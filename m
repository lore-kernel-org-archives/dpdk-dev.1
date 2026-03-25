Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F303109C058
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46FC04278B;
	Wed, 25 Mar 2026 20:10:01 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by mails.dpdk.org (Postfix) with ESMTP id DE276406BC
 for <dev@dpdk.org>; Wed, 25 Mar 2026 20:09:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUgzTE7isBFHpxKqgK5DEkTh9vefQeC6cnM4XrC837UU3hnmYOBQAgs7MTkb3Q6RIhFgQDQYiTUm3VoZ1GTHTv36F476q8/vIRZdzhH5A/yywiqKdvQulZO3WjfkIpnSyomKcwuYDNPjOOpbua8RpAEjYimudfJozUakJjy70Dn4tIZ0smPukH5N1QMrENxSsoyiqc6k3r7tdWOUop74Z0axwF5dlNuqkw7gD/hjq3/rCgy7AndrL6BdnlUaVj7GkORqHenxhAHMMK6RqwY9vC7NAuHv42/CRe0+WdFZ/1USi6FEAIVsDxfbsw0su/Y6XKLu9IAvMaHaPaa/y7DQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzFmbpJLu8xmkSO9AqDmozTUAv10aL7RTO8YOktqMKo=;
 b=cYJ32a4r0KFfo0K1RmQoXs+6fgpP5hFDrXgXUc6NhPL0bVTPE2xttRt4iJPI6tmbFzzD4BWt7LO1WnInWNANudMKK7BF+kW/1vJUssxUu4dFU/Gq4YN8iq57/L+zB7CiSubXtxbkoe/XDY2d3UcdDKe6WvhL+JbAubOXwbnhSaQub86hA7eLu0KZiZxifwApx1kVnNsM8FaYC0ToSO9qcbhxELcElmE8Tw+Lk904iyymPnD0hHj3mHeBWHSRUgBgzVgljfopvZcUhE7ufe2yXgYXmhaTIAUuBkXz4+tAgOxJU4Z9QsDSjfnxxcu5wtFkdKL/d4USU7iv9dr4yN08jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzFmbpJLu8xmkSO9AqDmozTUAv10aL7RTO8YOktqMKo=;
 b=IWiTOFjxDAfEovbdCmfYGrJFxQtGIVx6adxMpM+EsIiwB9lSMzc2/6+DTHsbySpcI3gNiOFFRlMG7g6ku9+hK6aHS+9m70Fdt6ziSdq2jYpiT/zKMuODxgTVLaKS2FH3zHKBJ2I4ucqanmCWTEFy6IRQP++serNKx2vlsDdS1oa/UnkLB7wluuO41mm/zmSYm+UYExjbaNbjly+H/ilaU28N7utm1QHs0deP82XxwXmYRD8LHGHOHSDuTBmtCzEESz8LaikimP9sSMitO4YHCN+K3ndKmD+mOhn/nAvdNjKOMGBaoTDCDIG2RbNSYfmzu29VZ7H7iNzj1qxJuz0mCQ==
Received: from DM5PR07CA0076.namprd07.prod.outlook.com (2603:10b6:4:ad::41) by
 CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Wed, 25 Mar 2026 19:09:54 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::17) by DM5PR07CA0076.outlook.office365.com
 (2603:10b6:4:ad::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:09:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:39 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:37 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v4 2/2] app/testpmd: revert switch domain mismatch check
Date: Wed, 25 Mar 2026 20:09:06 +0100
Message-ID: <20260325190906.68531-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325190906.68531-1-dsosnowski@nvidia.com>
References: <20260325180255.57489-1-dsosnowski@nvidia.com>
 <20260325190906.68531-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 96409e63-ea51-4142-7373-08de8aa21934
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y9imZxltKzAggfHA+5cRcKYn80ulBwD+q6IWz8qNMO/mhQ4vCGgVErQgNhfOorVtWNHglr8mQ81jIwML2jkMnQhfjAF7kiI7KffvK0Sb+rmZRWR5Le+ER/OLOGQALcWuXwrYFP0bZWjb0645JGU5fYAuzRycbwSlBwj7zL/vNXXq6e42nCpQRMcKzFtl/lCIUvVau0p6Yscc8ww2tspCGB6KXxtjHB07s0xYp2JoSUf+PhFbDGpkieeDl+PGQlWT6vXSchTk4dPSTBgdjG69oFsk7LgoFlmkPU9hKqt9b/F7gEmpJdjJA5kKVTt5JUYc4KEbkkcmG/oRLhIO9ohxAFNVhiexB1724n08GsjzfvqHHD7lcbtpfemL0/EMZ+Bqm5IjwTSzUtL0g0b4Ra4LKGZiNDQDSOyjO/yeBzCNO4YZIzsAU2x6lhiystWaKvYDir5IgZJ9litEfdBnOAqxKP6oodRa/74JdvgXuktbEboc/5UUV+19k1Xnwmy8WX9moTdUnj8ZThluSLIPeoi5UpXQ2wHwj5JYRo5iYZ9f5HWyOjiN4vg478n8L0wviUyjW2H/XgnDaUdaLEfoxyZPgqDVhu2frFN4XZtXPHT7VwM1XOIi6MNd7rpmbSjWKuwq2Kj/8c6PN5/y0gZHgvaEK3SwAUXC4BK4BRKE3OTN/K4LMjNb46PFZJR+E5c5MPtIyNeYZTAk4D2XWjJ8cvAggWeug4mz21TOSq4PEwXJSQ/AmfMwYNVqeKStYqjuPN/3gs9GDuc7amQK53zR0unJUA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iD8etI4DFz2pwL66t9u5Xu0dePQOPGS3EceCHmbC0npGAPgjYR8LLkBREzt6pH40Gbw0bSeKv98SLajZSnKFaZ3OOXa+g/qC8VY/QWG8SyXhIvUE/9+tXqfbYfU+PxgJe2n/StJvkXSjMLAkvZmULMbuHlCxj34ucYf2+KGupPeEf0yaLkKhUeAFwVXHfiU5lGnN5M09n8k/QrMFj9sAB6NyfcK+6EfCzKvqN2v38cfbN0i4mtXVeBAf04Sfq75mSvKrJUsI2W4M3ShjigFDgyQHwEnq2XPD/KK+mGqgEE+ip6QRPqZ0ZyExpnxiVpVFlkKHmrk0hmDqP6uLy5+3RLSdwzfYya7cTs/BCd73Iteov/rxYFewf+GmCkz/Z9zQeFYuKs4YCmCq3jrkZfn/WzbgZb47/VhHFnvg1vnfpIPCMc5TF6zU1PsXij9ZVvym
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:09:54.4275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96409e63-ea51-4142-7373-08de8aa21934
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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
index e655ddd247..e2569d9e30 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2744,46 +2744,6 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
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

