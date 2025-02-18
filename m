Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8007CC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E162402A0;
	Tue, 18 Feb 2025 11:34:14 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by mails.dpdk.org (Postfix) with ESMTP id 794184025F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:34:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXei5v5I3V7HvrwIt3hTAZzJbVsFl1TvxQqAUdxJIwegtmlTA7GzieU8A7drHpcHactZJ46+LJUQZ6fBxNsSdmXo13haq/rAf2IuiA/CpZnRrVGOgygtR5zEUd3YwHQPHNWgfykhyj6cJccwBMTGFx5xcVnXJ/k853Nw80++8oaFQOZF3Tw49CitPnqE+fQ989TN4/+1UKaJhi3kltpLLK3sHY2d+4j+ktdTpqFZyqtdwRGVASoHyOliPUf3HKkzP1CZumKEjDabF/OpT5Xd/lFdM16g16WcgGVTiEGm4zpiah4Dvs7gsAIf64Lw1TVuOcZl3CFvqLKc+4cEKXIcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aow8dd5awsTIdc7pGkHBkfgYYfAfxcpTZB0T5X6pbUE=;
 b=EU27m70REBGJER2FdZVwavpjb+ska1cl+uDGelhO8bvHzjhnDBiq9oLjS4JcAfGo0Bw/baJ3vu84rN/Awz0Jzx3KNQQE4pa94T+wtN1Wae7CagYiBndQTWkKvu+EpH8cIvj/6BZDz48bLcDX+nGdRMxLNtGUN/Q2KXcP2aB3l6iQNtHvwE7z3UDeUGuuighhDc8GSh8v1MSI1NJoFhwW4U6iYb0E4oJdvwyLcmHhzZ2Z/CPEVduHl2nXkj3N05xermbQL/nXQVv4ktPFt15VnCZdjBvD66vtEJ/mPekcF70TG9yWweOLrTYY3V6ebXPmX6kf7RdFGfmzMbK8JCZ4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aow8dd5awsTIdc7pGkHBkfgYYfAfxcpTZB0T5X6pbUE=;
 b=qHhA6GKmmxhoZb2Qn3M8A1RjGE4aohzQjjgQZN/7ISn6EDYBp8YNw1Iq9vnH5u5dAYMByDh041dAZWNOeiRYxOng7tn22ZxWi8nnFPUmyliaxnISAbfsM3DIdBw+zQJDmI8ggekx3BNGvKld8CgpcOVxnd3LbSppYEV0cYK7Pa5aabqewUp73nAl4QYiZnZGazyle85vTNNSvjavO7q6af0Yp9b88+4ASQSlqsFffUMZx6JHR7uSV+SghabesWnbIz/ISCQq8bWGHuIycHVz7LMLZstcQuQTORtOvl0PngmMO5td822vCLX+p+yNJ0FVeuyvOPh4/aS3LP7QX/g3SA==
Received: from BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 10:33:58 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::72) by BYAPR06CA0070.outlook.office365.com
 (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 10:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 10:33:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 02:33:45 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Feb
 2025 02:33:42 -0800
From: "Minggang Li(Gavin)" <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH 1/2] doc: fix mlx5 VXLAN matching limitations
Date: Tue, 18 Feb 2025 12:33:21 +0200
Message-ID: <20250218103322.166461-2-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218103322.166461-1-gavinl@nvidia.com>
References: <20250218103322.166461-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e61eede-7529-4ab6-4e99-08dd5007c04e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t89dAq+tnaXeMe5kpwstgGe5V53JvQY87Ix33SfSpaXPPprQxvaN0XWTWJml?=
 =?us-ascii?Q?y3gz6g6jBc+Z/9NciAQfJDog593vSGlcdgxR6rEgEde1pMaRDFaThPdno65D?=
 =?us-ascii?Q?vkuQSeFF4jpgAsNIW69AJYzQ5fOxhPW6UlAs8xJxs36ylxtNVL7S0J//NAZH?=
 =?us-ascii?Q?FPDxJH/kRoTm0XZvxyozB5fTmS1pbE8IYxBKHKdLpOFpUDMUYrNfoxPcQs+2?=
 =?us-ascii?Q?Nnxe/bXI+302GcGLIu8KBUIXijlM9dllVUDQGzMbZD7aB42HmEnRC+4WRnfr?=
 =?us-ascii?Q?mNziOCfRs+7UovsHtZWn2WjRmCp8mFemaiazAkPbW5WX8KmedGp43pa5KqIP?=
 =?us-ascii?Q?CgufSur8cdLHK+nC1AQNR8x7UaqSNCGIcoWCPgOX0WnSCDHomDJq3tXqMm0z?=
 =?us-ascii?Q?D/e2BVaQITno2HeXd0QLbu7RuBkcQW3Wn20FlAYsxNScSrGjym5kxe17sjBV?=
 =?us-ascii?Q?8tOCG+WnLZupQZ4JlBEi29cR8E/21vDn4IkIF4wYmmL/oJimxzVdi9YObojf?=
 =?us-ascii?Q?DwbcEasRHcO5+zCvZg1OMUsjilfLzPAUnYt0b1PIKCD45w0G3V7XdMwF0ytc?=
 =?us-ascii?Q?vVskRfo27eIqm0edKnkXxNFaT292VO2S4pQ3uf+IxiU/lLcLOl8UOY/HBjsw?=
 =?us-ascii?Q?4PiZiHqBUuYxvC23PeEAd3DaB0QYaVuCfSUnl//PdEtHck1orJWnKnhzBQ+n?=
 =?us-ascii?Q?OoDv5nHSCrdgcofwn7A3rpemkyHt5RCgMb9RPquqikuepTHqS1p529iC5dpQ?=
 =?us-ascii?Q?EKWDAH9MBBC0rPgDQmRnH+ujvcvSW78du80XUxRglYJl2/4LR+rsDznz5s91?=
 =?us-ascii?Q?epKUqIBoK6bb/ebXcrIlMYb7qW8skkdJtbWxxZDBb/dHuxb8Qvcnrj61x6K9?=
 =?us-ascii?Q?/mcM1p50GTTdb3VYQsUdqG1uFOqUd5szJP+V3IciXAdfGIYD6SY0tJTJJhTc?=
 =?us-ascii?Q?nt7AjB1rgqiUHJbPo9nLPlajjcw9KzM7XQD1597lDb5HHuuBW2ERDYm0e6Lu?=
 =?us-ascii?Q?3gPL3CuzXA4COqfA8lP3vOgX/R3SmjVRm6lKhb09UdnXgJBHvlRaaVtVTRTw?=
 =?us-ascii?Q?o3HdyiDtFyM5rNYGgqMHofY+SfHy1c6vBEpV38TQkYWgRhr7rPO6Me7HmRHF?=
 =?us-ascii?Q?nOwxQUoFUNpzFgjWEdALiqVduTCHKLfBt0sUrbPhh3tWCZoz4MuiGk0qCmxK?=
 =?us-ascii?Q?bU5NW3Ias9zIGiOaLgfDkqd5zJAYeLVgJRX5pfzbUhxTXIlsFrIuBD+VBtQw?=
 =?us-ascii?Q?1kjRQOWfEsIWJnsjZVrG1AY7VeG33U4YA+TkzaX8Eew683KlwdKQTr9WTyPY?=
 =?us-ascii?Q?QA+TIy8nx8QxTi1OO89r33c5Xg9Puq5KEldmHsJKVbjipLudqBYc4kCJoH5Y?=
 =?us-ascii?Q?M9LLIX5RDnoqoEL4iFtXYJrTVnzF0Gw4AAjuOwolGAYvw3cjyKHXKSIGnhQW?=
 =?us-ascii?Q?fID5HSD1Fa/peSbf2Z4hnv9kRPk793IDbCt5sk0FqzEr/nUKawv0SAMlmyWO?=
 =?us-ascii?Q?zgUnjMk3NtKeo/0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:33:57.6422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e61eede-7529-4ab6-4e99-08dd5007c04e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

P bit of VXLAN-GPE and G bit of VXLAN-GBP should be set when matching the
protocols.

Fixes: 49765b78c81b ("net/mlx5/hws: match all VXLAN fields")
Signed-off-by: Minggang Li(Gavin) <gavinl@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 690b46a974..caf711ce67 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -339,6 +339,10 @@ Limitations
   - For ConnectX-5, the UDP destination port must be the standard one (4789).
   - Default UDP destination is 4789 if not explicitly specified.
   - Group zero's behavior may differ which depends on FW.
+  - User should set different flags when matching on VXLAN-GPE/GBP:
+
+   - for VXLAN-GPE - P flag
+   - for VXLAN-GBP - G flag
 
 - Matching on VXLAN-GPE header fields:
 
-- 
2.34.1

