Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4EF54ADC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D29F40DDD;
	Tue, 24 Mar 2026 17:57:44 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by mails.dpdk.org (Postfix) with ESMTP id EB38240DF5
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:57:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsOJ0BMjKlS3VSJGQk3va4iE5A6AIijpjwhoEDMao18rT1voLQVTqKVXEuvXRg0foh4JbjbXKpL6sa22T0jKKecwXuJrBhAb4uMtivDPtvg129y2hLXdw3rQqt6HlQELaUrRzpEph4c18ZbDhltRy/3YyTxgoeMqbyR7ZztmXfYv2ryBKXJzhcWIRvy3o+bAoX8g/NVJfhPQd8L6oZokHG/DRKiOjPh6M3tlVA7YZ3PwaRos68Q/3eGakckHLwOlyaVaRjeJQyn5hANCjnNTkgaVGCtCM61wWu/3hwMh9JTs2fppSyKErHB7BEKBU5fHT1FycRYJzQhG0Iw1L1Oumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk+L2LCeWWPrej8KDhRMH+5C7u+G+vBBhoBeBrnaEkA=;
 b=YUnppt4L/m2bpAYSCrON14RShpQOYRUyV1Fskt3mhtphCzJo4uaV9xxOdmz8mz1VWUDGM7Q054uptRQuIEFFWPPnI7L8GbbYsOOwlv8BSNSKuPA0NZxS6lvuFNQpQhlijUrhsP1Fd8SJYiuHiUIIY9o5DIFMFOfPcKBqGZwvcD3ZmeQP3G6UYfk1pV6JalFBmhh3G0zwdRzXC6767Xbjx4asinDJDV6QW7Akr8vjgdtPV4wgoc3h7wo6czzdnkC5+vTy8S/EpY1ZA2kQCxLi0Pc4SElWw45wQgVFLFJ2ncN6DFnbZS4b1n44kH2WC7BWxj5qpZiytLOZLqFLYWWmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk+L2LCeWWPrej8KDhRMH+5C7u+G+vBBhoBeBrnaEkA=;
 b=HcDY5NzVBM+N8s1Cy+q61rP+gJH6tqiJzMPGqtkxoIcdSGB7tWyHRToIKs7KXJPilBGzUUHOrsO/84WBOtnksd82kGJ144oouuCawgxUt0p29BPR0LlyrITINwXvSnXOT3Kx9ncPl3lV/79IEO3ZS37eMcDeM9vMfMt60ebY1Nt3KRfpMFl5UifiMbIvTgOd41O22w8jKpUD1a4+kAbMwEgfSuL2x3AwNE7cWNG9MO7eObm/ASHKl1TpPrmEDHIApVzsNaQoK8KkUwiFA1RTfH2AI1Jlf/mDGDeb/4ZXlOMxH2UQhG59BD77me+MzVkAjlYrgbxpwAgqi6kBv6Im5A==
Received: from DM6PR10CA0012.namprd10.prod.outlook.com (2603:10b6:5:60::25) by
 DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 16:57:32 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::1a) by DM6PR10CA0012.outlook.office365.com
 (2603:10b6:5:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 16:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:57:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:14 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:57:12 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v2 2/2] app/testpmd: revert switch domain mismatch check
Date: Tue, 24 Mar 2026 17:56:57 +0100
Message-ID: <20260324165657.23945-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324165657.23945-1-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324165657.23945-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: e78e4c25-ef66-4a6d-2278-08de89c67124
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q62s5TJ48QYHHocA/K+nrFubk99EI2nXmaLueoB+wO/bmuo+ulRxmg72fiaUU4XMiPQoxLCoGjRtsPjRsQd66rAcVpYEqv9XwzzxfVON7ElJD+PJbx2wcAWwmCjiW6bXFguwkHNtE1F23/LcYNJ27a5ts5i6wIOj3L82+QpR/BP0atizoICT0IaoeYvdJNe+RzeyTgOpUNeoCpvWQ6jc5y1wgGv+1xJ9Kxi1GMFhtXv9W9ReRL9YUvc5reHVxxVPGYkjMaOVWLHhDB2S3TXDHgKjTQcKqaOjBbSeu6vjLcKgvN1OnzmsgSqnySP5feOuNnXVQ6EN13ORGNIOgrEAHrgiUdxrl2C1PNb+0kYgAB16mY7g0PZT1izCDuNq7K2NhyD4Un5Ctwgakm91tO5cTGZDR8PA4+h/qM3Rs1Xe/ZWGxzo42C+Tn0j33LcYLMBZB0Jb4/OUQCSpHx41riMcBqhwJddsDQTtmdnDPVEVjvqqcon4JqtsfojvEOV1hhGy1f2kf5hI8m+g/egKgMo7oXqyfLBKyDX+Ael7IUdnDXxcvnc8LwUlhXTB7yAUGqvUIq5PherKb25cZWtdABSsg0jTP6ckalpmMPzkjFT6sn5Z7zcw2iiBve+OfgWP6Wfbxj/XoKu9o4ug2s/YNcTVxYgJA6E4ls363xQDMvSKOf6fyMX+ms6b9C6sQyO7KYgrsAyoQnNELAOdTh6Z6dssIaxqVn3ttpLzFdK8LiXRWuFHxmal+xU0bSR8PI1d5z7ThrOZtERHi+5suRfzHVNLuw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F0q4LFvWVaeNx/mNW8Sd+qoacJ65p9gjOTjh8Da7j+TlPkPdBZijBnXnCLd+y74gtAtdpPypRijb1eTQjUuQv3XQEKBTdRx/Oa4jf/+V6CAriR/DTNJ0c3fhKfzifpOFOPhHMHHuVjNEBlOSIlukD8WNcr2Z9iEbKmaRQ661G5cqNCQPiQwiMSc8fNuFqLp++7Td/y5pyWjQJnHVYrvpogkN/EWI6qKfIJ6ylnxpbb4jiPHbsN3Il4Po6KrqwZ0Qu0IEgJKhPGW4NO1Ewyfg4fJnaTKAfsmczCQoyeln2eIzuHJJWOx1TnbpYXwd84lt2tb2/hmZ44RpUGy0VaYlMPgiRtTBftRVZ8WTl7bwmZQtDKYH4hIt8E3//4lq/5LNBOnQydM8bSgIGPqnMM3owaWaO2Gzf9lhuAQJ2aSFflBGcqlZrJ3NMZl54zOTm9dx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:57:32.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e4c25-ef66-4a6d-2278-08de89c67124
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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
index 81b220466f..980f41d25c 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2753,46 +2753,6 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
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

