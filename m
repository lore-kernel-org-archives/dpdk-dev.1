Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02613C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 05:56:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A1694021F;
	Thu, 29 May 2025 07:56:41 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by mails.dpdk.org (Postfix) with ESMTP id CF43C4003C;
 Thu, 29 May 2025 07:56:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTOgi2xDO5wIdIL9kHt2J4KAgfBCXxLitNiOLMRghTZqwhdPIBeBiL2On5ci2N53c3Eil3moz92aT4FdBPwzPeyZtqo3krGZ4wh2j3gF1BUFo5f5aEHdynGySJ18B6LhTptqaRTIjJNP4zg3X5EA+z7Wu7XPDIQ7GXfDEobQz5J8bOqM4ZJESC1Juqc0buCKXT/AaDIMp05bosrngg8RdMx1cuqS56tHHis9sdmOebNMtk/cyvMPjAqK14XosbdgLRZbmCRNw0IGS3mlOk6C87HN93b47yWN1ggOeXhuSavGbXk2taQs4Me6T64VKT1StpG2FqPTe5ZgRZMPI7stng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbvvgg7WEIjCZ2y7JN3hOnmhpURd5zs1OHis4zaGSm4=;
 b=NtNsUxP1ENxY/J7a2ys/NjOObLMHwnA4JE3349gvXnXwfDpwPdWqbb0ODQb/1zy8Yq2wpG3Y+1MDk9As28O1uUA4Bha0SFSXORVnsVRjJnJ3spYi8nuhsxfIEx8VFUJBkTr9vXvuKL3WrIrO5tb+p0cM8MmPnI1RENU6A5tIz/rSvYlTgxwHTOL6z4/o832RTW1rgVYlhNriCPuv4861TuSvXlZ4UGIkUUyhgn97QxtegMPiZoEUzD73e5QXixUgt3TP99RriapULFjkThBf/CJFD9ecD7nEdcoajJe8eBUi6/9sXdTzrCAJtn4hkXTournCN6BE1SemSuWZ/ne/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbvvgg7WEIjCZ2y7JN3hOnmhpURd5zs1OHis4zaGSm4=;
 b=I1eDlrlITecguGITZP2J0BLcp65Zie+8ms+6vu2n012qTG+c8uE7xQjkGxCTCfVczi5Qax14Bq5DPgGlWD/Sl+b4jOqVii12ArkE+EjNmtqrwMODECZ8Vp3qjjnfZhEGZmcM530isB1JgB0rKe+9QKX6ps2+f3pvkVksn6mpPZWnLNPllhVYKW04sUduacP2SQkZUtO/W1vl3TThk9oy7omE6uRB47TV91Qfd3HWehJfWAB9JWHmQmcdbhtUFrMjZTdoOqkYcUcgGmRgWhXsK/sAJTksomTEnKuNvs08eM0oaXj6+IHly6+Z0erx2wWhoanIQ9tjPDjMedURkubtoQ==
Received: from CH2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:610:57::37)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 05:56:35 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::1f) by CH2PR12CA0027.outlook.office365.com
 (2603:10b6:610:57::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 05:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 05:56:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 May
 2025 22:56:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 28 May
 2025 22:56:18 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 28 May 2025 22:56:16 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Ori Kam <orika@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] ethdev: fix null error struct in flow configure
Date: Thu, 29 May 2025 08:56:10 +0300
Message-ID: <20250529055612.115265-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 93aabf4a-728b-464a-4930-08dd9e759232
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kI9s4iwNI8n66f8ChmKO4AKoLjUYE7A3LBCyzRDOyhce5unUHRKy9qTXJkoF?=
 =?us-ascii?Q?ofoU83zn1xtXvXTkdWkS5aM3vT9XENaPoJH7ZJO6+DCesQlRnAgQxpXf9fz0?=
 =?us-ascii?Q?S45HARr/IyC2RJdQnHZDDOeCQ/HXfcfwHYv2PjYHH8hQpc1dCEJvTNu4isxv?=
 =?us-ascii?Q?XKuAW+3eePqQAJw3LC6DK0dY/CVQLuxT6Lqh5r5tO4HhXD0lnVprQ/Bm85xu?=
 =?us-ascii?Q?eMOj0SnyYzIdOHRt+oqagO77PFDZ8jj/uNVEtI4Qsy2+JGKoT5IzxGvHirX/?=
 =?us-ascii?Q?dkBlicByluyZyJzv0/VSxWzMl3Ey00tpAz5i4A7QRnvCt1Zn8jpII2lkAkQe?=
 =?us-ascii?Q?fV2lNe2WILxjYWrHYbzr0Wkl1FBWEfkZLbPGiG+sTs12y3Pvsl1ouX6huvA4?=
 =?us-ascii?Q?0qvfSa+jN9AC1VeicU9EvZN3SnCvQDkqLWe4F5LzYW8bsHXaR3Les8Ocl7IP?=
 =?us-ascii?Q?zGdIIGIYoALPGYcE9N4Agi3ahQ3JWBqLHG/+HD6T/bh2QAcTU5AeYxdE/INa?=
 =?us-ascii?Q?4iLX1m6qQkraCizT5Fnqm1y9k117+jGMW/XrvgGnO3yG+24NdwQcHKr2NAwB?=
 =?us-ascii?Q?kub5T+QCRfaGrAiYi9J7U8o5hWOeuMrmgOZAI7UZaapWRleVFB6irjXU6nop?=
 =?us-ascii?Q?exQg/LnnNNRwHw6tliY6Qnf/ShGOJD9Ll69DszO3vnXPnvtpSoHtg6crxdsd?=
 =?us-ascii?Q?r59qRJOW7ZTeK34LeERYxOoXbm9+U01S3vsqNcCtPPaC6K/GulZQSEehpjVv?=
 =?us-ascii?Q?W/NDh20ZJryxjDkxb6zKNsbqsx2FTsA4+0AIAao+U36D6IFyTEdOxURh6J9h?=
 =?us-ascii?Q?qOo1Ad4vwJYKaGkag5ZzQMbDuCN1NTfi5ZzmzcyHu/ojHvnP6Tpf9Ii+NTIL?=
 =?us-ascii?Q?Sdj+7w9/a2eDfkqRHMUwIKPP9umauaRh/6sZ70fQAL95XZON6oh/FsGA+Iyx?=
 =?us-ascii?Q?gNqSpERFzw3Yq48uj7kC5lsxaf7SETlmaHsQ+FCVUsMkWipIVPHgIMa0bQgT?=
 =?us-ascii?Q?WM8E9oTLwS4vAnuO2YSH6nhNa8kpZROYRs8zrfk64G7PrlkzBf0uhU5rhZek?=
 =?us-ascii?Q?P6FY8dyg7dZzYAziDDHl2UOjrTBzi41YEMavBFLGUTRfBCoFFtgJlD3ltEFQ?=
 =?us-ascii?Q?wTFSPlr28cdaG5VS/rM2mwTwucd5Ntqgovhk3CjAjeh+uGx9Ya+UZmtDupeZ?=
 =?us-ascii?Q?9p8GjrQ5kQfM+o+sem/ofO9nJyyA6+0wPztfDKlFU2krTuxEhwD6Zpv+LOfT?=
 =?us-ascii?Q?Q7yUfYFvZBNczlXVBTnfC4nzvat+xFxvUEUiI3n2jrouGUQDk86KN27jH9T0?=
 =?us-ascii?Q?MPYJHCqZydbrDqi+I3a1W6sml0HPc94g11ZtbC0iQkbw6XyyZfACjUd02B5h?=
 =?us-ascii?Q?D0cM43Ektjchtm56V/QzBAVXbP4qZlUh1ckVjvOpZg7+8kb76D+SKwJ7O3OM?=
 =?us-ascii?Q?jY/w8OdxjpN/smIZ0sfuLlWNUbI42yXOhZJYRgAwPLx4Khxp0NkghXg8m9BH?=
 =?us-ascii?Q?ykwagTQVnXHxnfyE4KXWTLcU26ksrvnhQV8M?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:56:35.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aabf4a-728b-464a-4930-08dd9e759232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
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

RTE flow configure returned error value w/o filling the
error struct which caused a crash on complain function.

Filling the error struct fixed the issue.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Fixes: 4ff58b734bc9 ("ethdev: introduce flow engine configuration")
Cc: stable@dpdk.org
---
 lib/ethdev/rte_flow.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 9f8d8f3dc2d..fe8f43caff7 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1725,21 +1725,21 @@ rte_flow_configure(uint16_t port_id,
 		FLOW_LOG(INFO,
 			"Device with port_id=%"PRIu16" is not configured.",
 			port_id);
-		return -EINVAL;
+		goto error;
 	}
 	if (dev->data->dev_started != 0) {
 		FLOW_LOG(INFO,
 			"Device with port_id=%"PRIu16" already started.",
 			port_id);
-		return -EINVAL;
+		goto error;
 	}
 	if (port_attr == NULL) {
 		FLOW_LOG(ERR, "Port %"PRIu16" info is NULL.", port_id);
-		return -EINVAL;
+		goto error;
 	}
 	if (queue_attr == NULL) {
 		FLOW_LOG(ERR, "Port %"PRIu16" queue info is NULL.", port_id);
-		return -EINVAL;
+		goto error;
 	}
 	if ((port_attr->flags & RTE_FLOW_PORT_FLAG_SHARE_INDIRECT) &&
 	     !rte_eth_dev_is_valid_port(port_attr->host_port_id)) {
@@ -1760,6 +1760,10 @@ rte_flow_configure(uint16_t port_id,
 	return rte_flow_error_set(error, ENOTSUP,
 				  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 				  NULL, rte_strerror(ENOTSUP));
+error:
+	return rte_flow_error_set(error, EINVAL,
+				  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				  NULL, rte_strerror(EINVAL));
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_pattern_template_create, 22.03)
-- 
2.21.0

