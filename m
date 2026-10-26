Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0000606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ry34IW5E
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FB844060C;
	Mon, 26 Oct 2026 14:23:50 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by mails.dpdk.org (Postfix) with ESMTPS id EF93540275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:23:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ836gnq6S5DZsj+/bSEX3s+p/FZzJTqokEmbxyZjy9i9Tjng+lajkPJlGj5mxM5RBQl/IkjZzQf2TnS/Wp/QiVz+hoBMl6yPWq2maeEjFW06JGZnp6R6v+Tejr56VLYTcV8+goZl9heIMQYJJ7VofomQsoXsR4/iDIS/PAQQiImPoX/oru8JhXiSp6o6RS4FDLQC8jQ0kerjKCpjiUVZbWozm/msJldXsWUivdRW3csohUlptSa7d+0hAr/W5ksGnuSB5La54ir7b03Ged57Edj4jdIONjgSrJaSN7ej5dnrfBSvpSl+ouhcWLVRMP7kPfAf9gvmp1CaBqvpFeFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=HiLOOPXCBf+kb3UDuD9mxaLhtQIxZZTI5Tdk0fF2GpTshTFVqB7d3RkusnN+QfGgbulWqRd3gj+evp12ymIZSQj4ybI8coV6iteD/5EEjf13o7iBRpU5q9puQoMizCpfHnIwgov8hstVy6TMSLjRGaSXzoZrv8nNpMfc3DW2bPIMe57F3IkNDKJjIrC0iytc9LRJGtOE59o5fG6KeSpkQTf2x8hvyjDZVRTujx96ch4UuTPn4ORRRBANYXRl9jH1OcT39i5nWIJkFLmb5T8Iquj986F8kuHsW2vG+ku5vCvRj8aOa++IdhM9bDTSvSDo8NlBI3Bl6KmaABFY8KSyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=ry34IW5E2iOqZyOsPgfLgvyK4tzNNSbKpRYZxgedahgAVo5RfdTyoOe2x9bpQmh7AovocIz98T7INgEP/QlxXw96hSYYDT2rwSwOvo76SCTCEc4BRilcqvLmqpxHQjuwP1rNc74+LEjuO8TRASmpnOHPhDzB0UqtyGylzk1Oloi6bggVpSROa9uRVn98AfDwypdlIz2q/qbgzw3MqffrZVMVa1CxdzhAG29ch4ttZwlQxtCF5joLRgKSLAHAsGN0Gdk7jkORZu5CmYbZvXL62M80NfkKxH490h5D3nTfRWYeA72Wk3nflXXkZ+8iwGR/scxzNfXZHKe0/W/QapDFSQ==
Received: from CH2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:610:60::25)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:23:44 +0000
Received: from CH3PEPF0002457C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::3c) by CH2PR14CA0015.outlook.office365.com
 (2603:10b6:610:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:23:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0002457C.mail.protection.outlook.com (10.167.252.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:23:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:25 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:23:24 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [2/2] net/mlx5: skip DevX Tx memory allocation for Verbs
Date: Mon, 26 Oct 2026 15:23:12 +0200
Message-ID: <20261026132315.14029-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020115859.96750-2-mkashani@nvidia.com>
References: <20261020115859.96750-2-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457C:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 39eb26dc-bbd8-4bc3-5b91-08df33645b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DDkj3xlJQiLdto5LFtsNQZgTS3myGrTOq7tvPlyAnfTfPK4Utk40vuryP7a09Ny3RcYfu/zwSJ1HJa9creSC0kSltD7kftGk6if7fQJcaytTZS75040rSi0hIbxQAHe0dYkw67T7dtlKd7tRyHuFDdQ++fsJmPA6C45tkrIg+Hy/Soa19QacPb357UA9zyAssnLKvpmdxNaI3i9AdjxWiw5NrjqpWsv4Yn3fswI93MEQmAu7JFWTTKV/v1qY81l3/rrqSqBlN2oTX5HQiyHawAZ+w5skJOOkBLsECDUIlbDaU/ZM79t+Iqu4vaGiS49AJlHXN4nQPJ5MIo/x4jg3Gjrif4HM236OzXNWN1qnXitlmo3OOqPQqLCBKnTdsB8U317KOsuYMMA6Xb6mvmdLgx/pAeavdgIqheto5OdXgSqBWZwKFUNEkYFxSOY+ccFm7JjSvCtSZAQXFEtZeJFCj/khhazSzBiFB4KkhovGsbxNiGPDlCVN0Jc3BRnI3wrK5qJXo/1oTyB/Wspblta5qHAdY0yzx/KHOBCebyqwyOFll9HqU2GxXsC5k7bbdTJv41hPP8GcmwJfnCJ5VQpQjfUa/Y37pjH1sCRoouBTbj0M0hZF2Xrsc5p0v+iP2n0UGSpn9xZCnHVCU9LKnOudw4gTgXkSBYYB2SMQacMCaaGrdI2na+zgrWtLgEBbjBjKgmoiDobBTVdKR+CZgUShGQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q+FekBvrHuv4yv/TcKS3iORBVCSNXTNf6Xf4pRt1qbK1uHzfvYplbQG4bNPPKWqr96asJgYSiWb2LdtNCoSZrTota3aQUEgFxMq6+5+q3e8FHPtN6ZIgTXCcb7BRVfeHtSHonx3pO/DzYjeRRpnYRjUzMlrjMFdGwJIeFYKaG5tEBtr9in29bNQOHCLy0hVHWVRgbrb1zVase5oHdalJUCYZdUNNPkyPhbAxCIQ2ivyCKrlDlPfLqAIGdXunlo0ya95ZfLMUJlWdil59niZ+FTAdvv7RMXvC7w+0sONnR6QEJX5oj5S5B6cWRr6YPNJmxiJn4Oslzz4hvmXOSNbynJnog1ieARELUSvThlFFYIWOu+GkeyQGqPTGfbd3GCZfbJJu0V5iYlUN3Qu9sVKMLnoib9ADPKgcUOnmlidegoAWBVkMqVmeq+pLaKyo6siJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:23:43.0795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eb26dc-bbd8-4bc3-5b91-08df33645b6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
