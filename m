Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFA606A334
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D0tUR6qD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64BF740E19;
	Thu,  5 Nov 2026 08:38:04 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by mails.dpdk.org (Postfix) with ESMTPS id A082340E20
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:38:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgUzt1FeBscGF20LCY0qCCHWl6mqzuWYNzsQmNFnGnLnf5XB4IsDf5E0bkcDRyjJUIdCnerV3VeI85sfg94gkMBlxYInRW5DQzfhChKEZUHA4Yt+gpCwAxX3Knlyn7fWmA0+e12MujoJ2nissiItvE0YKC+yUJt8pZIIWd8BQWn7eFgNbB/qj3EnMlxYjWFShO/1Wu3h0HdQCd4g664XTsD4055+Dw+EfMKHwkjR5Agqam1+OETCaAEnC4YFd9wslPFxFi39bYyMqq+oim/2OSXrQwSu0RCMrxgS1WrObJw046VBok8vtXMvn+4k0YRRIaULxLxUerZcoeAewIZFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=MPsCkE2oV4durC5ozMcs3ag2/a9Pr8p9kKHlG9paLjxNEt379WbBw1np6MJS/eefoCm8BnoEJAx+RZMKNFi+Qt34pJvcdbRCA9hEVBrO7vCwTCj+DSiqK0bNRv6hozTWJfBaajoOV9Ta1VEeQ/sLQWPmw8cZ9fgtb+QyFgcO+5vgieMEn2aBftoAlOXAIdhmkORXbyhR9V+chx3/j6gIQt653bTy8xPp7UE1YBPcu6Cop1VF9vLYO5o2hHSDnw/hJvq9ZexkKCXlnBebUFflO4X+hHM4ycoNCKprDuIOGxXFcisUG9CgBA+3+Fk2InRjbOjBnsPXv3KWpkOwKllRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=D0tUR6qDa3QAsFUdAZQkwFpDjOh2AU6H50Ra8ehrbonGYmDa3YW97B2yO4WSTmY44VI4VVdhrnH22c5mM7gv4L/+51RR/Wwv1SSx/S6SFBPZ/ANTdYHMKH/TE8x5RyeFhQFUftKmB2uSUolWk3pPruFaKjoYjKqzln4TCkGXdqpGcB22b2EfPTdYcM57D5pKG94GoP9PAXMJQUSeRCSOtjGc6OaJVQptQYXopNJ9kYGvhW4lzC8ktB/OAv34V3haQ4gVDDSqbaki5R8Pww80/YbY4EoH9YBKwAbwfV3Hnx49pjMPnWgo/YzN3/tC6uhV5kbQ4Rr6a91AwCBnP7g75w==
Received: from CY5PR15CA0183.namprd15.prod.outlook.com (2603:10b6:930:81::29)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:37:58 +0000
Received: from PH3PEPF0005961D.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::6f) by CY5PR15CA0183.outlook.office365.com
 (2603:10b6:930:81::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:37:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961D.mail.protection.outlook.com (10.167.243.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 07:37:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:41 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:40 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: document group 0 IPv6 fragment VLAN limitation
Date: Thu, 5 Nov 2026 09:37:30 +0200
Message-ID: <20261105073731.20446-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101160443.3216180-1-mkashani@nvidia.com>
References: <20261101160443.3216180-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961D:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dea48e-11b7-406f-6a47-08df3b0fb60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IfdPsIPzYp7TNdCqvoq26XIjDr0Yat/DxrkQrXMpzLyAMGy1Gsv/UKnjj3zRcHBDbhmPJXT3pxYYDtgserNco64C9aluGGlOBbHaUtc6zG/aHKrnNS3sO4JXKPh0z9pkadxpUVhkdRfbRgs41lI1Rht5GArykfnqs05w3w50ng2cFnxO/kwoR9Ew/dhP9gLfRkRDxdajQMkU/ut4ccCFV2i+vHrw4ESohVBW9cV2EjuIoixM7F2sXQ9a36hMHlLZf6vdkuvl39TYqwPGg6EWSKD8cAprv2QeIZT/bINAtpqBCD+WcOBX1MQgHfqR+RdNKPLrB9HGDSfQRILZggdhnkE7jV4DyryGIp09iPEEPrQ5bLiYsLeGyeV6xwfLLR7PcIgop6VAlkq6tjeCjKLrSoldOnCtzU5n9/F5aXg1T2I7wkH4pcSwL6adS1yt8P6cIr+qc4uWM9MHdVFQjYTNRNSrsGm/l+DP6hAIpwRQIJcBSq+fsJQBrl68SVdWy5Heuv2I9UOFhEGWEsQ+hIIGIL84G0LTBhpKVtVmskblwmF9gnUd5fCX22vuVANOYnzm4Nu3QlF90nyBERrh79tj411V+VjW8xn8epm8jJjvoaD2u4otmkGO4fcesCghfiEKKi2HA+PjrrrvjY7zF4iTfw5H9/1mxtXxy1t/7OSEWPfRECWwK2YstmvxEgZ4iFjDNbuhYQ84mtjrQsjErXPnfQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 841L6NsrxMuJAK7rC1MZEVIHZmdn675kud9Rum781f15uBJD3V5A4MkMTfOgdGdaYEW2fd978KQ2YSl8TOFPUKUQDeAD1UbfwBmUicB5vKfORU0+Prv2UqqVlgrbY78eFxf4BUT4uvAIDzQqnyHD569yYeDRziMZmAZU9QTISlubUUuGS3R0jEZ95PTDjWPyngGNEqQHza1Wq53VvRx3fTb+IQwK3Fuu3hicloO0Yvd+6qOMKtiEBVihYH5VsCQc0u+yhoG1dWn5D4/EMUkh5YdG0EPXsMXLQS3EtJX9MdNbL4D/uIlW8jiPbHJseXQw77KNoJu9kR3wMfPCG6sJG7ZTbv4ZywcVO7thSGDjr08z8d8nVHpft0S6fluMZ1QRbR/FgGcOUn5Jk12oxip0JbPW8R+QJeABLay1eN7vaGjVp05h9kDz2weTVPogGsBv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:37:57.3044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dea48e-11b7-406f-6a47-08df3b0fb60b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
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
