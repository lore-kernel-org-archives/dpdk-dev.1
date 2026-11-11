Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7034606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U5mG++kq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D841540297;
	Wed, 11 Nov 2026 14:10:46 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18]) by mails.dpdk.org (Postfix) with ESMTPS id 27DA74026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:10:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBIMdclycm9qNpM0ciP6l008C/AkxGgIBiyk7ipKPPGFzzYWiNa8q8x9Nm9DJv9xhKtQGxIPQngmBKmOvxwVAfTyFqFIN8vcZ41c5o2+dqGFAtFIU/ZeiV7hVvwralzH9LhpqEUKWs0ycG8fbP5jBe+3l6ItrZHE6C0ZIankYjql2eav7l5AQsHfoMWXRPFIo1eRPgyh0nv5RhGczbt9dKANZj5waE68s/S0Ly/+lSl1PjXR9OrvPiV3oieKsmEmk/amiBv5o1KSm6E5iW76XQk1qDEoFVyhCHUoivfdk14rakhXaBskbdK+qxPCJpZ1clOny4nUM8X25ftr2b85Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=ufWcl45qZDwX3St7t8U3RG3GjqUauBQ6iYey/JLSmMph/E067yNO1ETFoWY2dmJUUFCxXz7QVM83EYjSm04rMv7GuF1AZO/zxY98CcaZP68BEtITHlfQrzF7t0MOJAN4UcUXpLePKjdoXZR2wHlArAzPb8hE7mylJGyrK/XipIR5i3TOAXRV1pIjUgunBGnUh3GQvlhF0OjUJ1Xrd4eZvEO5bC7EdN0ikCZpAmeHjCyoouFFKk13JdSP0q8wFciLqzq/slNxv/iuvvHf0mln3zv5BWEtMWI58o8pEE+TCuEr5lEFHG8+AY50o27nLKZGS0gwy46+w5Kg9Oeajw/FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=h-partners.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=U5mG++kq+5OTM5YuL9UJURHIvm7OoclchbnUyqxg5MTzn+DnV2QxXDkfPipEQytguaz9FgQIpV2RjgNJVx2Za/ex8qbCB3UMAO6/ACbb4+K6/RfDlCrIAOIw1ZJHFz3nxl6Jxz9KIFKCHgBvVLVn4ZnSx3uV5HRpOiXZk/QBER+xRGJyIqAzovjpzNdqRZ+XsH19X+LSsy0ZIc6Scw0+Jn/VCoO8d+wk7VtkXjJ41c3fm4nm07sB972q9Rqlc5wn9HW2+V5S+O6B01f3B/0eMPx5n+fwfGvFbbDFtN+AYwHvz+JqresrjyZfzLxMZSqhOYJwerZx3Y9FxNVirSXjog==
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:10:39 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::a) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 13:10:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:10:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:21 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:10:19 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Shuaisong Yang <yangshuaisong@h-partners.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool
 alignment
Date: Wed, 11 Nov 2026 15:10:08 +0200
Message-ID: <20261111131010.14052-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105140824.2094914-1-yangshuaisong@h-partners.com>
References: <20261105140824.2094914-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 551c71e2-a2f9-409c-88ef-08df3ff52e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9Urryu33J26rk8IWSGW+9q9HTfRUcPtqro+lrB4wq8hN+KFYpduuokx1CQYemB/tXNM7OPR8ZMPOh8W43FG007b8aPuCppyeRqt2/DYTI3bT7rza9DkPQFsNs2a11Sx6fJRNszTeEFnMrCP0coruGYKTMKYBF7OYFerC1SnW35uuchMGM9mOksn3DvrWOGDbd3ZuthXTO0ZE+yRPKjKjjWAMQTmDD9dBKn9+AxQja0P3bSi+OaUG/xXELZfK8K6TJEKtUBJM14gtQK8/7DY9RaOomu5XBcqGKF09jcNBzmMuAHWC6Kb2xvFzAiUhW58g24jM8BDJ5st8vEuhJ1yP+TVlQKjh4tjulF8QrYs9k/lzqgY+Yc2yVzwGUGu6IeXWH1ig3BjyiueOh+eDzllqp0GrBcPUyp5JTzC7izo3WOJFUB4EiWh/0QuroiCdufHnHJOUdvwfe6xn14gga/4Yz0DN6dkktdO1UR3FY2NJTwY9R06Zqde5ozGDeH/ybd5n0p3dnSsoPqp3bgtQ2OvUTUgLs+IaLORSGZKSGXV22Ll0kY/aNgbFNtN/4BUn3WGNXYXuHOPylT/ReL1aEdBUQFGLtqSZmbElrW2ukBp8URwHvo/KLjY7HHDvdpaLwkiNCIfVbv0NoqcxNOSDd7yUNCezUcpBgyoTmUIQY5Ds0Uzh5qj16gojWYvNGmDkTxlR4w5kNnOf6fnDE5DE7Qlg9Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BonnliY5kTmRe5WJ/UvLY6355eHGZjqG2Wa3XIg2J+U6fk2HGORLmMB7x2i9UUNnw6JZTydtrCJV2zMSoX3uHJpgn5fq1ScOYOhj10tIELDbfzIlVm5T8xhKQLJXw7nSLJh9AE/Bvo1ak4ESBqLbITThUkcEr0fxUhL+YhOE83eIRHn3y9si8CfPI1hCT4uKB9Q2WFag+8LatNyFg8LqT8Bj0OZLUUTY+5zhTa3fOd7dc6YHn9tZpz9J6sPsr2o97cRk92TMG21WflXf4Ggl4y2VIcN+EZpsrAAJFPdf76s4O0o9GH1W3pG6dwgZ1mliSy+gZ2w8LVbBn85PujBVwbvqzqxB4giY4KigUBMRDt3mBNwsIClU8CeRhmGo5TRjfgfdCbHJnHdHITvp2ocRYFjwbc26j0Z0fIPBaKPRzW7fhThxKFaWBDNcwFCkcFD2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:10:38.1793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551c71e2-a2f9-409c-88ef-08df3ff52e2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
