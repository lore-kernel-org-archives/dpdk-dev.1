Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E53606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S5agECEJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CEED40DD7;
	Thu,  5 Nov 2026 08:38:32 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by mails.dpdk.org (Postfix) with ESMTPS id B838440DD7
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:38:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd96y3XIwdlf0cHwBu7GOqcejgj6Fpw4zHgvpUgDv7L5oYyDy7YdaPEXgBOfBd47a4tFx1DO77QCAP/TwvA1KnQOCoUjd3bcJZfODKc5IOPem3vnizVZQXpBFcWgjjLItnnKpP+GcP6JZIfIzCvX5mOsEXUEeL0RAiBP9upMefJ9u1OMeW6z4hoKdlZ93U+vjdbosEKKIxoyOil+Ux3t3NOeRLPbe/VY3JfYA0aJ294b4sJi/b8cxrIArMN87+22HyX4gfVENi4CCHWVy7xWL9Rf/t6Jh3HrfGXjo1P8JDz5ezRpobHiMkRzfiCu4i7w4AkR8SSxxk96FmT5SbAdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=yCTYnkqq6NPCduEKa56Z2qecDBjFhI/6mkaffoGkdeOtY8nFq9Gvr28qA+6X5wK9VUk9z3Hf9VvhofaOpb24d+ynDG8HAh3zz4dccIFVREcG+oYExDTTGcQZVSj1wrnCwVAZzddn22RvkKkbcX7Ol6GjpkhbfOlcNMZx1NOj4fcsOZFXrj55O7AMk4egHJ+QvW1gECFO3Qqp3ioAv1g4TS0R9+/D0ihdwa0ocsrbnDyUFGAE9C3expfBnMLJ92e+uvU8A6Zyvf1xyOdZ6/do3f+0hxUFxgdldlm6Z+oVszaFA+mDjxJ7XZqxdRut/BaLEmKnYpls1G64rAon+gGLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=S5agECEJGfvk2Pqs6QuzbtMZDHgSt2c3ocJlukTuQL/3awlGg0icXN4Yabl62eBoaJn8RRvmqGX/Vdp32gzkM31ipBPReKIXGCU8y5ERxFOEkkJpLj6MbWzpxWFUqr+BBikUmkIlkLs5xbNv/bnnlDLYBItvgsUBdqfLgCVqmZFPLqT9dWnujkuFaWa6JyU/r+/h5jYrmERUaVcz6cn1nb5DP7K/W1bjd0QhxPS8YWNsMurHZm3QbZd4z/uDlaxPZJVV4PNK2n4PhfotETUa34tUrhP9LAe+N7Al3dp6Xe0ONMMh0PU3dNAacX9N0dNJYeM4CGT+xJllZQap15XiFw==
Received: from MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::10)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 07:38:25 +0000
Received: from MN7PEPF0000014A.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::d) by MN0P220CA0017.outlook.office365.com
 (2603:10b6:208:52e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:38:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN7PEPF0000014A.mail.protection.outlook.com (10.167.254.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:38:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:04 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:03 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fix local and host representor name collision
Date: Thu, 5 Nov 2026 09:37:53 +0200
Message-ID: <20261105073754.20491-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103081959.2932331-1-bingz@nvidia.com>
References: <20261103081959.2932331-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014A:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ee3b12-bab4-43da-3f46-08df3b0fc6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JBD7nAMvUsIBqwOBRi4aOoTAwJqtO6l01o3PV7AlFZAKmJNP4FmumpaQF+Bx6q7aScUvRIZRn1iFzt09vHpUB3JDvZu5+S7LY9zdV0BiVh0ZvJphp0tWEHvNjgUzVJ+t4CR1ack/KMonpE1XhmS5s+sbnlf3WDESXYcqMOwCcDe0hA2o0mkd0Fjq1udaOv63mUMRVD+yP9308sc2rnoBPq5T+KOTNaQbwHn76+Uy5dRFa3qjUJjDSspuDbPVYEQ0TtZbgAwhFwcLIVxrgPpmXKMEv/eF8zNUoiDNcX+Z4x0aLMI/T9tBFgTxOzA308wWbfz+IBdfExBZLjD31ruQYfiY6zt8RDbuEyvLn4GT8NUrn7pGi/sS2mtzCOZmh9nieGfRbI8Mf6VGFdFCX5bclCFvDjUxGDGv3iGkxH8frsJG8oo//ouFYpA653UYi1hy+bNkLFQaeGPLmCshlQWu5ok5oJXEgAJ018m2HoC8OXsmtWOzyMG3UiztWCvoJsUuEOwby05r+hC2t/2OiTIWvPvaYx4K3uzwjv90/W+1mwV+EiDo3TApZDTAk+FOuxlaSeez6V8Nv/B6t2Qc30T8UJ2ygg3eh4tjmtyQ5Mg0M6RENwfB8RJRjDH2vAufGr6sZZx5vHmKdn+6rCA+WeBgrYcXXNqcXfsEpwCGFZljvBdcOwcHJyl+/EC4WhZdNOVKCAW4Leh8NTtAY+by7OI1Vw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jnU4lAUFKZoGhyBSAIINZtSwJefyrK8ZdrPyBWd1OSoqnzkFqb4S4UkJuPlhxH2BvlPd8wobZ9ceurz0gbw9T5BfWiNz8LP/Tj1gEcR+B8ApfJXoW49UrG4PrJa5W8yfRGIIPzzyIMGUcp+MD5WZUyB9xjOa0uEk0nv/nrvIY33CtaMwrqcOetLmQmdFAYU8oG8AtXOalPXEasFX540KKWzz0zLv2jfT1kfGi8D28zNgZKzO+MIMlCFJOpy2oEMJgVRhyS/TpyODutxiw0UgHwred1GXysohy8qN08Cbqni1QgSJgNrZ6gjgmpEWifMXYfb2XBszMb7d2UpTNEPbsS2HBJh6q6mg+ianXfWvFkGG2AzoWZIENB7Uu4Tfdq8ALMCWofFvLE9iQeCHZOhu4/JdK56sYZ8hKzqhDV1UAmTka/7pqQR2XAhLwW1ZFDSQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:38:25.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee3b12-bab4-43da-3f46-08df3b0fc6f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN7PEPF0000014A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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
