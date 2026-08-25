Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D4C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D250B402D1;
	Tue, 25 Aug 2026 14:18:01 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41]) by mails.dpdk.org (Postfix) with ESMTP id 7F941400D5;
 Tue, 25 Aug 2026 14:18:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIpw9ZxUlxO41KvuteXjvrYgGdHo5DwwrKo8/UNvJ//dBPl8hRLlbDjvIhyDCEm1tycxXwUOxS2Dhv/9JfVkZv/yQDD2LZjm9tPrqszTWI/90AGSAvlqzG/R3anyCOa1gz6CvbXlXgJMu5XFO+CWbj41R3UE7ZvVs5YZfwFzLaH0hVjS4ETF+1AR8xl0XgW8KoIABiABA3EkK5xZrW93JScSVt328LMlqlw5dIRT64qjNmk1bqyFUrppWXmPu51fVMbaMldBdtgdmVq8RBHoibjx6XMVNRJG8q4reTzopZ5w02eczuYcyk7q71VKpbYLQqb7Ks8/iM9BVJbri0KOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah8Dy4sdf/t60AdKDrL6WfYdgBPwFw2NwCTuGMLsj9A=;
 b=oJRavQ5hu048+Ntede0F0n+Rloyo9De/EIlxlWQhzXAbH8sgKVMCly0LgOyaUyg17WBSoU6mejQjazb49hY9M0/e8voYW2gZOdVOpJ76gRryviBIF1LxCxJ2xqcdJal7PYQj634XpTZzW8AlblQVJMtVl+rubURS5qGA6luJyDTQpcWPPMxMte2/QVFkLrlV+Gbd75+mNq87cDmCiehySiP7mUU6X8+NVGH4gyJM8AQXLcgRe86V7T1D+XPjbBxBSm1ot0cXYmnGlZ+PB6T87ZxqBBBG7l9O6cy+xkxfUKpOEqxpny6T0YslP/pvbWQeWwWE/Z0MAoQToCUfxvZ0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah8Dy4sdf/t60AdKDrL6WfYdgBPwFw2NwCTuGMLsj9A=;
 b=q19vc/PbIzVV/5L2VlYhWh3opByW+NJouI43/csCtB/1i9g5luEcvB0o5S4MufnDx59CEX680nyT9TsGgiZKb0dZcc2SubuY9/tS0lsSkUAH+V7ZM7mVIEKmjF/4fhM8pPYIXvnMKL648tIm5dzHP+Ci0WZ/z8GhDtzVwHLQN6jc0Asm6KRaJPEPgmmmeZAhHI6TXW84kKTUrXZXCm2vMHYL0qYxEjv9WsadW1LQXp3bu6m8VCmAa7cWulvV8iNR4rYw2hqIFoz8l5y7Ys1M1cz91pmAPin3rrDeV9aSC7+LtMTzv2/RAzGe48CVOQPqoyU6IaFjy/8fGVTm7GNGDA==
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 12:17:55 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::8) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 12:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:17:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:17:29 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:17:28 -0700
Date: Tue, 25 Aug 2026 14:17:20 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH 02/17] common/mlx5: replace strncpy with strlcpy
Message-ID: <q3ihaixwsadsdjd3q3amxescmnq7h7g6jf6wlef6jgtwfd5lym@23thxbwqphzn>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623165150.765443-3-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623165150.765443-3-bruce.richardson@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: a35c3a51-1740-437b-78b9-08df02a2e379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hPTKMTUTKZRnIwlcfpnzkt2pG9TkxN1HzwuQah/M8DpQhAN3LupM0M+HOXPPa0hh0KmogflhnKkchAU56CUaQVykex8lFfrf53Y9eN7f1XVUflqSnvXG8w/OIqhBUbbNnDUE4SNl89r5F6qicK/ZMgPs1aqxVIs/Hkyq1JExQrfHNo5pHc+k9D7/kX7L99o2i1Iar8VROZTe6YOYtKkVzfqjxC6uYLL8q/4fHcIs31ZsEZj2sZqSas5ZEdR/CmqTHWUUjrccJgdXB2OUCigx9LILOkpjBbJSZgtw3+RSzNCugj6GE3gBR6LdVg2IDePrca0hE7ThWVU+d9Tn3lHV785me03rCiq4nH51DZkeqQp/X1tXyEKaQDB0tpyJzD9TU0mxQQywlKSC/R+APaSIGmW7ePLTkUqnxejJlzV3jGytiYeVrSCowmWM11JP9t4QGNvC0WtDWL2MXtVyKG450cwVtN+F+8zVNL+KQN/oteSaVqFFLXHcZGyQv5Qf/EUhKxRMRLAnTdv2xCHPVha9ifM1IACOnL9KZJalE2ZSjiOvd9jiMES1yMSojQ0pBsUjL67vAyiYmqnI0NuB2mC0GsktVNiFs97bqCzf+k3fAcG2gjXoJEnEHYtMZysb5SCp3fskqSbjtXeEykXEm1k5kDn22uNULO71cMMp1hHnol+YlgrvYTpNX/EHS+Fjhv+XN4AEqoWpZ2GFSAWSlQ+q8A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PtIY4V6mzdZE+JeYkXDYeWvcKb6IT+65fMRPmeFhc0vKFa631Q7ZkUtWjsIhced3uTQACPUtKMfwNi4s2OLP8Dzl+/DrjqrEm5UDCAikevxbf+ZeFBVuv1TasjLh31qQrj2APpYB8Ovp+V4ksJH6xrPYn3+5lbhxnbJmhm1ih2NfKW4MGkgZK4lDUp2IKxMjvH0CQNApOsafOSAflpsOPIMBr/k3evwCXwcJ70Kr1Q/0nBliI/iUF2sb4brsxygLiNQm2KytgjTEiHnhvFn3s4wTnDxihkUQYPJCmtkQM0voUYwDqkYgaaM138GlUIYcMURAjJJoiK/BcCPRFY/WlTbwhLB6kVfJOD9Ysbhx8mjBkNY40XCRy4vylv+V8WqyeOpZPULR+A0JSuWTjr3JGIbYqKsfF+F8jNbcysCBz1+blLn3hhvtfAUC6M+bLU33
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:17:53.3247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35c3a51-1740-437b-78b9-08df02a2e379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

On Tue, Jun 23, 2026 at 05:51:32PM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: aec086c9f1c8 ("common/mlx5: share kernel interface name getter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
