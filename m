Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4055AC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FB2C4021E;
	Wed, 16 Jul 2025 12:29:16 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by mails.dpdk.org (Postfix) with ESMTP id 2C9334013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:29:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSdGCnV0r/GC5mFO0VOawpIWA1UbXmD98u6j1Dn5cABwPC0zJQxXASfuJLXWOQHilujq/qvc4tB4sMWdjOdHg684vufpvpzAFCRSl3hs5eLIhA7F534lakal/Z0R4wtnmXkerhSaCVPVdLsyEE83iiZjabiRKFqqYAkUA6pz5G1i2UKN4pTkfzw/+C9s3vUpATFf+w2wyQPwvHDy/1uprZ2AHG7ng9iZy2nrxKilLMNcUBYs3ypzNEvXYTTGVjeHKprZLThaHCrsrdVkdBYSaYge7LOoWhQ+5UPmzQXzUe7nFqVAlqALTihsfpNf4rRHCkf1HfQ+7fo5AvvtR9t2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6+H9OIe46USwWHYtVhPW7XLMDaaUANz5jo57KVGjyg=;
 b=iiXLQSjtQsXq0aXp/l2mvRPKZMYsvO7Gg68Hz23Mqyyb69nl9QhSsq57IDNgsZfw2aTIsUbpqOGVcMdGTrfAtSzmiQpRh/SJ2DeZgcQ/PisqjXabpor0FCsIZXUj/1+oSVTuYkCc8BKP8YKc5OzjrGN/CoW4BvxVcJI7nQlghnnrFrX3zRYlUCjyNqbirHad0AQcWDd3j42YeKxBtxv6N56T8yiBu6EnRPA78vfmO5pfR2eUkJnrplOXwgrrb9gtFshZVyLu9CNXpc3vDP6Vtf2XJuouSdFW/rjnLAQ+2AY39plZUSeGiJOlRcxRyv0Ge/LtQS+2pSDkyqHNRaY6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6+H9OIe46USwWHYtVhPW7XLMDaaUANz5jo57KVGjyg=;
 b=Z6o8Xt+tsVLHtX8dFRlrGIrjslPdrEZuthoFsUgpoNJ4yyef+1B8ni7h7+roj7sVcVERVYjQBxTDKW2Ux1OaIB7fOXdr6N+Cu8DlPZ3FpUpf+wmcKYUjHLVJNpN9bpLXnb8pcGX19rvgIwmaxccEW2/QwhWQ6IduuqSssPoM+htwqyV9eyPQgF4YPwACksMHTNuro3dp5mU4lK5OrmWnQ7k/jmRwCHIYoltWh3aizL3v40qSvHJ6DXWmnsp3TyhqkGuBP+XeOZJcqqTciO29xTPsj1YVtpt/+MUZlQQB5mMcPYyiD4LwzMCAl0kTEnugcjtOVPT5SjVe8dRv2Tnskw==
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Wed, 16 Jul 2025 10:29:12 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:3b4:cafe::4a) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 10:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 10:29:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 03:29:01 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 03:29:00 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH] app/testpmd: report minimum and maximum MTU
Date: Wed, 16 Jul 2025 12:28:46 +0200
Message-ID: <20250716102847.1118815-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bd0304-feb4-4333-acee-08ddc4539b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HovvvAIkpDxwqRF4ph4qp9QmQGRozzUqZ3F7hskOpa3vLlOBNShShHbGG6Pj?=
 =?us-ascii?Q?Qu2t0EE5G0L1H6Guf4Kj7kb8qPbG2SY40xd45+Ia8g/HwbR/0q10CXYEuGmW?=
 =?us-ascii?Q?rz60/yo/AqxmjvIJAjSJ0WvnuP1cdahAcHAgXpV1VITei0c4lYaGuFcf8QZU?=
 =?us-ascii?Q?Z5zS8pA9pz7A07aT8XmXTr7EjRTT9TeSAc6SyI+1Ymy88gR5Zx3jaklSkaC0?=
 =?us-ascii?Q?VFRqX6klPIKd3avzMNQFas8TfA7hxONunygl7GptBAE+T5YkaQM/Dv4HEOfo?=
 =?us-ascii?Q?wmGszxklpVm42cehJypPmOqTmDbjg+yIJbjVQBqR41qBnu28rLtwzEE64oLp?=
 =?us-ascii?Q?C0/NpKtSPdl+A3biGSbBlLleB6Q6jIOjlf7e7E4/J5vxvAzOXyUPH/0g5f1K?=
 =?us-ascii?Q?5d48CYL+Rfg1bNj+65YJtqo+PEFHU3JH9nghpU/V7B4ttS5hHX/2YzA0K7mu?=
 =?us-ascii?Q?CZ7V30hRQfLXJY6g3viDt2m3oiMmKplMSTCJ3/mWoEj1KyI2riXkRZW+oUjO?=
 =?us-ascii?Q?3xPYDzxoeZL6wX7XjSkwQ7RAjX3I7EzOdA4Sdeny0tamRxsqe/LZprw/Qohs?=
 =?us-ascii?Q?nwOjY619p7OZ7aAGeNuoYfNquzErGUUbye8iJKYpqLHGD2n1AUBlblAsIJtO?=
 =?us-ascii?Q?DVj644OfO9tMsBYBZCwMfg0m4U8sXoEwvESp7d6xabLAZUytoN2x9NHAPIxv?=
 =?us-ascii?Q?GF7UZpfeq//wevK1V09RvBI+3bzHQZCU4aP2N+CIUxygk4dLC0RWOXgTm4KI?=
 =?us-ascii?Q?qNqNMlFp83pbGU3NSRunNz8/HhuKHkV7GbRBHIMYWJAFuWhX5YcG3YfJHx9r?=
 =?us-ascii?Q?LZQKHVuEBxl67dB2TO8uKK30x77o7QLjlzMIeU6utyMjjqKvTGuqOF2zKleo?=
 =?us-ascii?Q?5RMCEXsBtJzQDtWC3UHHdi0vS3vj3WPDjm/6YaOh2uu8dVld9bQHPs8bWvR9?=
 =?us-ascii?Q?2MN2u3pxgcQOVzd1X0Q8iZCmm11pIPjf7zPe95zOnCXtkFPUSYyWq1rR/DK6?=
 =?us-ascii?Q?2Mipz+YYhZwY62U7TOyBVlC8TVPc5q5/7anbUup3pMkwqSGFNgxl4f2POrcD?=
 =?us-ascii?Q?/3qJNObtf2SDSFVnYygIVwuALXonNwdGmv2Yigbjg/Fmrk2V7+Yl6Azy6mFn?=
 =?us-ascii?Q?GOmZPjNFAHfBVjmCUMzfVA2MI0x1esoDp4xNEqgTVOO/bU0g71jJrgEVlNTV?=
 =?us-ascii?Q?7LEcn5hA8w3wcJQ0j1sYaHvEEZtlmDysFPglyirXJc2ZfVJAWpiEiqZvfqFj?=
 =?us-ascii?Q?2a24iJkxSRkdUMDXNq8eqca+1vqLwnBouqM/z4OZL1E+EE4pjMdiI6dO35cM?=
 =?us-ascii?Q?ET1VQl3Kt3qikvE/wO7dmks4uAkcIRLjzUkpXFDzi87Hljg43aL6ChOBUFsK?=
 =?us-ascii?Q?mGZz6S9Go2EphHXxlSvfVWJHG5qpJk9KQa1Uqjhrt9dCX4HKx16fEOQ8WyII?=
 =?us-ascii?Q?yiWL7oTTcYP6+NKyVOCG0LS4k7nEOxypW/nMdzM+xgKZrZNG6zpTMNoqCMEj?=
 =?us-ascii?Q?dBGZzdFQGVPunHKS4Y2cBxJgwzOkhY9ce1hWGi1oN8UJxDsTgKk9B62I0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:29:12.4578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bd0304-feb4-4333-acee-08ddc4539b79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

Add reporting of minimum and maximum allowed MTU on a given port
to "show port info <id>" command.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---

This patch allowed simpler testing of mlx5 patch:
https://patches.dpdk.org/project/dpdk/patch/20250716102546.1118749-1-dsosnowski@nvidia.com/

 app/test-pmd/config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..08048da6f8 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -852,6 +852,8 @@ port_infos_display(portid_t port_id)

 	if (!rte_eth_dev_get_mtu(port_id, &mtu))
 		printf("MTU: %u\n", mtu);
+	printf("Minimum MTU: %u\n", dev_info.min_mtu);
+	printf("Maximum MTU: %u\n", dev_info.max_mtu);

 	printf("Promiscuous mode: %s\n",
 	       rte_eth_promiscuous_get(port_id) ? "enabled" : "disabled");
--
2.39.5

