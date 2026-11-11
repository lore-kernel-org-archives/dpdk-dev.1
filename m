Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC8606A326
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oF1cMtOq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B3EB410EA;
	Wed, 11 Nov 2026 14:12:11 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by mails.dpdk.org (Postfix) with ESMTPS id AB21A410ED
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:12:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCSb/3h3JiQALMR85MKH9TQ0g1u5ylTLFjyq6jo1lQB7ebjcqLjQoveRSEcytmZcwsAZLUvKHH18zPr2n9+5a4rMkElUGoyRVohRLa1yB56WQqqLVcK3JQwqKKTDgOxAO9HL5BcdXyCEHsbF8P5z98SBJ75PSHGuLxhQWRIQgJcfDeLHhd6jc4qS5Vav7pOg089iTLK1TEg4P1OM26qqhqjxPzsMrsT9gCDkeNDaI/Pu+Gb211GtX7LK9GqcPgBKBAeGq0Xb/FTg39D8rJx6xJiYVZrXPsDT/tEwXsmsGycRUDEHkX28HNzqcCAPpW7d78Y30UbZX993oAIoZ5l9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=KJW8v2jVHHWul2uNFLleJ3vaLbkudoV36wUMQ7ckgGY+Tf2N+mPxMqi8/hMSqRz7QAolw1PBBRvKTopG7UCKo2ahGurB4xmwO2m7jsW5OCMq9mxa7my4E1qkfkxdquAqveJpNDUwRTZduUpGs6Da59yLKMhVqzfX3QQ1i4zQDStpfwLbQrrKLMOsAYPml8iZ0Pzgn4S6peMVdM/I29SP3eqVs0wPyvYOdIBzJQ7IhLDLsIbCG248HqY56BDJ+saAfSAduJz2dq0h6TjRgh4UxNhNv0V9A+RjncwjWNAZjEdjPFXZiJJv+gHX0RjSEI9ihMPn4bEqPkh4j48Uak9GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=oF1cMtOqeLizcBQ7ign0GN9LvVuMgIM0Rm+dHaL8B1bamOX3ZfXjX8XxJMYB/YMF0s5izAG0DS1CpQNuitpYLwgYGRoXhNtBDpds16MeEek9e1ie97aLtT2JDmM6G7Qo7ZcLefy3xobfdwL4cBiNgbKK6+waeORkCQbC9IrRxd5I8qjr7t0jretc96lDuMZgYlFX7GTWHqtBJtSOjY/XhqLoZcN/a96mKRnqsfRJY6HwbuDFIWWFmFMHQyCa/5BxDiAtMsL+xemDmfjQoqIwHELeU7UBYXQAApSourp+KryOHqvyUvurRbGeYyEpDNqzsRpkuKGYR4zq18ojewbFHw==
Received: from CH0PR03CA0447.namprd03.prod.outlook.com (2603:10b6:610:10e::24)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:12:04 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::5c) by CH0PR03CA0447.outlook.office365.com
 (2603:10b6:610:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 13:12:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:12:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:46 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:45 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: add root table encap and decap limitation in mlx5
 guide
Date: Wed, 11 Nov 2026 15:11:35 +0200
Message-ID: <20261111131136.14425-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109133518.4042113-1-mkashani@nvidia.com>
References: <20261109133518.4042113-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c7ee71-0bb5-4492-dc09-08df3ff56111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ADNSyip2T4EoYT9j7T3NE/c7Y66YsL+q2iUzHUYnBYzCfzXlqf97fG1gGK849iuxDn21rxPNbFDJJX6TAkzOCwUh5t4aBMZDU4tahiGYBFXoDd3Wfp1PgEIs2pUsf6NGKvYpa+f4b/9pO/bf/yw2kwOEhvptPECjmWXFXDWOaBTX7nO8RKDvTs7rbYP2uWWN9hClizXW8t42ZE3zJPbZE1hIiUSgXwk0Q+il8vbCdqjn/Bq4wChO8qozS8J9+cGdXbHjAsZOL7EWoCTbpESLwwDYOFX+F9PBCANBeMTFllQYzSe3NQ/Ww8D94Q2FTrHwIlHl24ui1S+EOXm1AQpPdjts06DYCiibVWjGD/roHODh3q7iymVyKIwxdCqQ9sSYL+QW6f9ZzWAsIND4rncHD7/iTurVxPMXLutcneWViESURIYKjYR4T4XK8lvR7E0q6Mvz/0+4itKocT8XLX2QZP6bgugIwGC3yOqmz2/XZHhVEq7WEZq9/BYmYKgaZi8JjccIEYp293Ff+OHN9QuPWs4axFLgEs09AlmI9o+YkDDVcH4hSF4SG54Yljq1rlidrH1uKgdYquoInZCH/6lusA2Wf2NA07tMsWifw1y0j10ljYwQL0o+E235FnxN/N1+2OGlwo8dZgjQFWg6U1Z0sx2YLYh5wDP3f2RQmUYSHbTV3UsoxpK0iBQjKEgK8yVyw5upbW7JtzicuRmXGljKgw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EilDcbKl94yrTCmOoyzpIKWkeNtiRcJPrPxU+WZWB0iMFJ+GHXQbE2t7nki7BaURpUx2bJwiabLApMGgEMqmqWp5HXzPk4IoS7mZM8eGvhpcV2o3smPXcOWnLS1CUjiGzhb45EJjmd1jNn9aTz4BjvS/Obo5mwXzEB8Yfr/mi131PoNwJY+JxCsqLMDhhtL1qWk2g6RkRkM83y366eGJuyguG8Mil4/ApUnNppDWeeVVHj26QAOdi9AuXmksrE8nNMgD4LVo0HjVBLi+zFITAw2VYtrTGGBLGLZkfqK3ITYLwhB/3sX26H66CvPGSSk/w3Cvf7UpQVfxxiuYA7QpTpij7QBuDFU3NzfMXuNYBT7BQnLIm0KoZ3/LsVDkLxydaCKdmCD4Ff5pdeGgzMgKF225AixbYz7xB81GG/X8ULhE6Yg4sCeGqmwjocs0yacF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:12:03.5678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c7ee71-0bb5-4492-dc09-08df3ff56111
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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
