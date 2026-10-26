Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0C606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MJz8zQjj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B719E402A3;
	Mon, 26 Oct 2026 14:25:03 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39]) by mails.dpdk.org (Postfix) with ESMTPS id F2A0440275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:25:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh3faJalotsYb9DqzbT+q03lVdkAJt0OV8QH9dolnsdoCR6FK6PDl8oM8gb0s4MLGSn3sC3s8ArnIwN6OsQQ1AcERYwGtaezOjBtOjWiLNzknf9tQn3tpWd4Lehidqolr7BmkxmZiCTne8xlbpcTE0aATUCNCJiubbrrOqDV8lMURlyiVDGp2XLUIjhOKtoMggBCee2ukHbWtMypd+Qd+eIr0bfTDKUoGpr3BDgcRzptZ0gXsXuVztiNfMYkd+FipNC5o0xv+852yCChDPDuT2O0I/+OEAmLbz3o2aGV+OQ5hQHk/9NzXuW8yAjKxlCm/DhN/jjmJqeuq8Y/t39xiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=CMFpnIYeNYWouOWwhbnnh7JnHWZ66nvNUTh0nvqD4PAMIKz9Eq5NSRbiLTJrtA1mn5I6R6dJ8MRwwzQpirZb6J9OHT1Q/v1xiEsMfenUXvKIpWaQhWEOb7rpZwI/6JZ9nVtlZ99yErL3k9xtY7GnK/NwsLWIQqJfFQ4sA9LqvYlhX11Idvv6ZYc2c97hVKrE0o3+A4mgwvVs4+xj6o8EPijCGLBE9k58n4uKbVLXXxwZDkpBmm4L8nrBrZWu7YUe1AzxpoGLfJQw49X/VknSfNjAokKcgrjwp+78m3AFu/tNYCc9muaUkh0/Faq21Qg6mdLt4WY/Qbw4+dOI4bh16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=MJz8zQjjOpQUbjZ2nk+ZOlNj6VAQPjq8eq7FL9I0aA2ytJkPYUfTnVIpEx0cn654FAStZsGRv/UqpQq3CkgVDihaOcN26qkxsmLgoL50611t/R17CVZ8yZ/qoAw4X526LHdorJZ1lS3dysCRkCBKeieb33hr1WShNf3oSgw/C/FDptdVB3iuignXAwWnjDw+yoZDM+Ta2+5QaJAIVbsbfK3OFA9XQlQGiktmBLUnY5MhEhLUM9BmB7RGhT/MNeGWKl1f3DeenICgU9/ORRfgZdZVYo4qEU2uHGIbF7ufggLeyIsJQwNvqMlWuxjHu4HOHb+i6riKF00oIXUp63olFg==
Received: from CH5PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:1f4::15)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:22:57 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::a4) by CH5PR04CA0009.outlook.office365.com
 (2603:10b6:610:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:22:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:22:37 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:22:36 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Rongwei Liu <rongweil@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [v1] net/mlx5: fix suffix groups without default FDB rule
Date: Mon, 26 Oct 2026 15:20:48 +0200
Message-ID: <20261026132226.13262-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016074817.2831545-1-rongweil@nvidia.com>
References: <20261016074817.2831545-1-rongweil@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bd3c12-b1d5-4744-e7b5-08df33643f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sa3tL8o1Y/jeir5F16GIMBtbTmqTanjKtwhlXo2SViEAYJFFfa5urkOMupvS+hhfOtbn1H2pblMogs8YEppP3h/7phelqxs5Km7zyVYfqt1Bg1l8q6WGLSTuMMP83wQ6XvO4rvNKoPuGodW4s3GwPZmB6iCDBzpynLJ441GvocXXQwIjr9msLPqrH+22xWT+zMPj2y5I022/IZdC50Nk+P6smx1fyoE5hTtoC0VuKI2xps+77fKkJkYQ/BQgSwGm+sFBIJ9zygX0L9Q3TUAbANrgN9B+7KlfHHl9prlr3hpIdAqVOS2sY25vYrM9YqcN6XOUdaOhcR4Uz51JZo8VcmEwCV8wVDkyOlGDE5e8nHa9x3e6zosCkoixHV33o3KGDCAZXs//GrOLp14EvyGodQvMsllLOaqimd1cI2KZYSIZNmEOtXoQG2NxPNTOWjG2IreBZAkDMKook8oTxumm8KCTL7lgvlUxRD6Ee7vcrh2SdkTM4NmTHitOl68OagEXCFblXdN48pe/cpe3/OI0HW1B1XzjFIWyiGBL5lxeNo/6CDKhhNxYD+JrYRM4JdDTTO3nPmj/adSgAJeXaeiPEOuPekkVU8IEbFjY0GqP0ik80dezZQZAXAAV1omnsl5bpM+CTtUgzFCpAnKHOAPejgv6KED/YG4qRadukhvCXRLtDmlSue1xcprMGtJ0Ayh5vtxlO573PK+4J5u8H4MwlA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KW4h3oV9hiwPLBOHbdFS2DCabB1if6t5mPDmRKL86WdHxJuBeQuTEj9UM3J0kIlxWt9DNgXoD42gN2rF6pw3F/zcIecrsTBVw3c58gmrW87L0SbIwNRq23CT/YZr6Uzctqs4hXQc4P+ekxwWA/qo/XjLZVXnLvxa6PSverqLgnRVysoZlcOxC3tr6J2mSiY9+w/B+nlnRxlRgRBDWcyFo0ZWS6Ti6sWxG8prjAM3hi2RMUumf3NQ7xl/6v5FBPdQ48l7O+0mBp75GsrOypsqZcjh4cV5J3EzJAWpPED8KI/Z+I3REBfZoofeD4Pb78Wcc5lbnLMLUpnlqk6KCNb/tfSRPyQBVfyegNeUQUIHPt5uDeDR8IIC+n12WW9K/JW3KEmq2zMN5R3XvVHYfMaVswVtcdoH2NIjhI8FhhDcW8mx88VvJRKfnz5rvtjNocsf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:22:55.9303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bd3c12-b1d5-4744-e7b5-08df33643f50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch applied to next-net-mlx.
