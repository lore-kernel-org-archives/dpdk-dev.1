Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF2606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=av5lyrXi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1B6F402A3;
	Mon, 26 Oct 2026 14:23:40 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by mails.dpdk.org (Postfix) with ESMTPS id E82EA40275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:23:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsGMaZRwDnAtmERtqzLOHqizAp41XFeixJWZj+5Yuv98hG/wrfm8lC7vjW14jaXedk9EhndZd/b7buzjX0h2exnU6K0Y6ZrpFe6aSe1PwJks73bd6NjOLXaJZ/xQzhV75BdC0g58tln5Izwg7uYuNXSsxp8vDgqg5o2E6G1gB76gmpLyquhY5n4USwWqN2k56HOffOyyBwNt68wn2a5kOkZQnjnq2UTiZ3kUcxGGYIGhX+RcT+3npoNHMgom8DxX0prhSIJi5tvEp3RE4Dd2v2twzG8uvaZg3StkDcbQqB4w/JfcNLQA2iymieZinfvGvNzR7TtHHGw7sYoT0kehbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=RO7foSlklc8xF1MUqVr1k6QsWl/p/DQA8zmd/jxeS+ahcLmd5KgxucdCLd9jLCwQV5SuUWrX6fLAvWsBBk+M92Hbvo5iii4REieexudORHfLQgYSlDrPDNaUmKibOwLFouaPNme3h+soUrJfbPsYzB/nrEJkKf1390uw+5CHrydxx1NoPVRZXvwJM1x2N4EzYzr9MzHjeVvZac75U2eJN5bQ+EzqQlmyRlA5yQYWdrqrV5jt7rcW5jVo2Jp6AQQSMYWf3GvrnxLY14yHyoWvFDu+kn8l1ITfg6LRjGiFipBgp3wjFihdEkdIkB6R/PB4EwsKod7c4sy7E5pbWNrc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=av5lyrXiMYYw724xx2mZzOX6+ae410UvDQjVfdCrY9XerOba3y3NP7xVUnQtwv9f26ZsHhVKju/QeEsnvRkkjXY5RtPSKR8bRbw37t7us0m7+FhJiRv13v1W7vsWR4x7dDf47Mr5nTxxg1P4vean2viZw6pr4ocGnw/bInT1E0PTiGPOMyE9HYnm8m6WjeGnbLG1Er+wWZk0+jXCKmriKMC5U5rYqcAwPkw80bMZ9XwCWzw7KSRJO2ub/4f/nw7YN7WcxdpEWqXOKK5xKLTAnBJN1j7r535t1+gsCZBqOb4P000XX5zCwLUVa+CWiHa0v1RlMOUceFoWrZg9frUpWQ==
Received: from DS1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::15) by
 PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:23:32 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:8:44c:cafe::e) by DS1P220CA0019.outlook.office365.com
 (2603:10b6:8:44c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:23:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:23:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:12 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:10 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: net/mlx5: fix HWS meter ASO SQ leak on multi-port init
Date: Mon, 26 Oct 2026 15:22:37 +0200
Message-ID: <20261026132301.13846-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018085510.8592-1-mkashani@nvidia.com>
References: <20261018085510.8592-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: e3605c51-4e20-473a-1df0-08df336454a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zIsUVeQssmvjSVqzIDOKSUEzBK39GszLwWWzqZSrhDCZKaRFOVsdzZyR3TsI7TPQPYhgzFZMu5/rchm8HaQEbN3QvZ5qNvSjxObQLEzzqXQSsv/nPRt7TX4SqO/s1wI0zpjg56bPyDYp0v2EreHEyBKHTPpzHpTIq8sXO37N9CJGCRnTpeKqR5fKcxD5wliNUAChASgHxWdnvQvXfjrbRN/gb/XpZ8iY55AKC897Yzhc+17ynGUmZapNNXwe79Juc33fX3RQSOeYq1inQkWF6OAkzuMqkm7jGMdprtRuBASKWW885XqIh1oPf/o+HgfHWiJbzccSfv7eZj77Vog4GA07cFLTBDqgAC2SD/AR4pM+WPT5pHOm4d6rrjwKxKIfYVXcQFZSpC+66nV5Ipm+Q/5RLQQXNyQNmCyw4bPo54iIw/LOCM2ATJmjCyFEsESRWZEDvY18sqfZdYhxIJU9A33FUsPN1ob09ieknT5hxb9lWem4xHCUc4pZ3nVmkCswIsu7feo9GZ/VRN+IYu2vO3K1QmD5Xi/QJ/CuzWAUYypUtxaCPDXbYq3xVf9QVHSHEY8aKqxCTmyNJHUXE3kgnCH7bn4LtCgdG2wSlbtDCcNthkmiODTlM6nsSdaQiLbcOSXxso2q8aIJCTvCTAO3EHENhdF37uQ2TjdMV+Rwhgg69CtC180oEAAAKQIBZRGOoAQgfv7LIYY6augl0f14/A==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7QigAG2bXVGwl4UpNy6NFRutLN5esltXwGB77KpZ7V1kVB1Bf/Sl9Hyj4qHfH9XwchD1ZxkXpxPC4j8j0yU1LYViWZe7cC0WsiNYczCuhszl+kLlIkS9S3ewqK3vy5/02Z6TISjsotbiT80UgEcv1vce/wCrz5zttnDOU/JRsJx7d6OByNOq/SrTwJH/oMz74svcZM2mLzphGvmdZtmIewr/D85dS+YPaYjxD/2NfcIeYBb4Wj2ioIaPbd9K3NpjTtRwM+/G8W/Hi2i/3+5eK+vSAKCEJ7yhFB3/rTH2o1y3GQsUShgFULW16NV8lPcTy2YuxO+4qz4YiaxF/ruvq5Y9Jlrg3eV3b1/7crw2nyEHT/WJWj8WHUofh+2Ek4QqjGBbYRdBNCdVxGvlVO0j5JnZgyDYxw4+qYd7Io5V0JGMm0/6vlHzE1PR4F9cH4ot
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:23:31.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3605c51-4e20-473a-1df0-08df336454a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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
