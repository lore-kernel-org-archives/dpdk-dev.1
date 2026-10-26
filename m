Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D1606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T1Ul3H0p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD8D402A3;
	Mon, 26 Oct 2026 14:24:35 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 683C740275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:24:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrpLCa28b1uWkfH18akAuedEr30blfP6u5tJ/YBoWFiBx/2kE+SweOqzo9Z9uMcZG3irbC980Qs4N60MNbyRH6/bTnYIJRbwxYLAMSNIA6ZYbWVvq/92ddGLgafeRYR+K8c0NQYscFAQwPGNjJfjYHnVHp/GVjNC1ZiHu2yDJq3k8T09QVVwMlFbcDsVTQLmQ4bxHo/8M1u9o4/XJjO+tOQev29lNj5WmeFv/y2iCx7ew90rj+4TsWYAnKZ1RPMfO1k1v+oN7n37NijwSyB4V8/IfJxotrR/xFIHF+sj8nPpDk/Z3vLea+b++/837ngM4t/0j+KlIKaTmQPmVlAuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=rvr0fl03F/6pO7XsAaFFnaXDS3x0QS1g1KWdIM1WnibXhJmTfw/sansRac9sx6yYTBd8iRHg/1BVx3bo0QxES2NnpuZh3W19PqPSYf3BrSEMUnEcJoLKD+6fwSmUJImRKeADYhXo0ZxkonRWMBNjMSE/6NR/1hH0o4UgRg9KNPaz1KdMXOSZKEagyLab9Nm6bYpmPwmKODWedJyUZtXW+07CNY/Wxj3+gaK8SLmfNwiBgtc7cr8u2GK6f3ZrLqYctIvL0DGpdVpal5NlvRAaebiMh1MCQccrlEPzNokBwAHstee0W1dmdueacaRzghbj96sUiSihLS6HI+6MR/cYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=T1Ul3H0pLZ6RX0MEolB5V9uFklprizAo8Ce5AYbJfaKXEEobqSRfWu8WKxa2+3dxs+Mmj/2pSQqtvgK6FNE/VBR0v9K8rJAx73eBUUoZ8fE+/gaa8d8Ts+RdsbCq4KfDfcMCtWt7p3MQvwZa4XjZdyA9ujVarA0oA24kR2x/C9FIfEf5x+HS8fQbKpdoN/UKBHFOJ8HxwJVCLXVj525SyxENzo0vDl2WAPU7Of26e25L3csekOlofkKlqtP88dCyyDTMA7fwayGF6UG1xRv/CXzxJKz7KNE4TD4wQmBJysDXFL4vTiM+DjY0IFvP/fzp7PwC1rvf7krAVlTaCxKWvw==
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:24:26 +0000
Received: from CH3PEPF0002457F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::3f) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0002457F.mail.protection.outlook.com (10.167.252.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:24:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:24:06 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:24:04 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: net/mlx5: fix mini CQE compression format log
Date: Mon, 26 Oct 2026 15:23:47 +0200
Message-ID: <20261026132355.14202-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021181646.1385008-1-dsosnowski@nvidia.com>
References: <20261021181646.1385008-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457F:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4962b115-8350-48e8-a459-08df336474f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ll3wdK10HmDdZiMEnDrU3n/6YTPmVZDBMbBc5ohhL3PeI/dXRM21vy+x7Zdi0/MySNANIOvOaMp2yaXyYpDXbq+K9d7T4OfQU/aIvpkcJCd1ZpRWM/ZfagmyplGFP3XqetZ79oMiO5/uP2GG6OwVITFGu23zm+T0ynoW0XItGGfNmFhcL1S/c2+3Wk3sz00bpeMn0Ul5t7DGpmYwJyvNYUXS1S0hpGoou96/8DZMbQ/1HM7t793y8PoVF5zbgM9b8hYO7+2Oz8cLVq0QrhrtmnhcaggtyfuAGdO13IGf/ZsQngHRhJPT7CvZfNaVxhqohuyWccRfXJWsPGFYyKEvzF95AuCJewM3OnHfduMtHSBydjBgNdzqBdjP1H9Dea1ROBK0lsrMatD9oiuKEHqErUolPMTSoq0YwUgtx2eIhc7GlPmJ0mEGwCCAeWWvH1z0p/Do+3o2DXiy1II78kOVzx8iHKRdSPuwHZXVO5RgUs6S6SU3iU7tMeROciJ0XEtTMlnTLlQroeuYo8iUQdp9Cvg94nbevdUs7L/kw9JoO/fGhuMZP2fNoBA68Kr1oiWdThZS8JTenMA87GABbVHHQSMvUszn0/lOZontyq6iNIDvdU1RGnIiIQCdHh6zZGU/8lg/b+HYZHoQ3QsK00BkdPOKfNzw4feDOZ4sR6rQ9HnpV/Xk+Te1JRrydJk/n78UzzXJ8w7MQSCwNmZsvOvrLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rE1OLIjjV/ZfgQDvOpEC/favYojiuZxT4Rd28+wgLTTneHa9S8jCmgVD84Sz2dMq3xKKcMrrZG5OoLp2a6nARtNJ3eUDhXoobyGJvoWYn/7obgFQCTTeCI0p+if16tnAHBjc8QD3rmUVHTlC5uPCQWuxKjuN65pMWFMDBJaXysYhQ2fJi0i7I+0Pl800L3bHx9BRGk3mHRNF5N8ZcVKJDOuYy+uVlVjruBw1y2nPGQg3HyVY9jMAh6Xj+hK7+cRy0N/NAoUls+3PuNdVbtv8MnZMvzRwEZtpoPGM3EnMqeR27o2Kmhy1JYclp4Sam755VEICsLUrpEpg1B/SwgIvgigrQESf3YfoFSBBtTfV4QoG4jv7efotu3TVQVLZEOMGKPCjibKpHlmNqDXyBcAnmvrFcmwPfoUmH/tyNPJFpDQZECKKnfkzmWVAPsSOtMwC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:24:25.9165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4962b115-8350-48e8-a459-08df336474f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
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
