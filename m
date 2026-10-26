Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A3606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nDLjCnQl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2B934064E;
	Mon, 26 Oct 2026 14:24:43 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7]) by mails.dpdk.org (Postfix) with ESMTPS id 6DEC940275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:24:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fH/yviL13wwDiG+1iJzKEHCBLSC0X0kcoL35QDWzuY+aKmqxSCrgbrvOFUWYAuu64/9rmtwccvhkXeOvdM0bDcjoW1lNyWkinFPg/rm6iMOzR/RekVB3j0/Rbf50jCrynO64IQsGB5oZord9ey9cuo+/Hs3/CqrBMQpLbmnsqZApDuaUJJlBFEj2WKuCnD2oz1QaegJpKAdqiGjbmVISfcGVgzfyU/3fx8ufkRTyR8DiOEJT/bvMDEvxA6z/T3rNVDf8HwJ5T+VB+7vSHPBhJWcfQeL8rnJmuwGjfl2/3hR86wwaPA0zfk9gWXdlglTiQJlAFXpyfBaBucCca31eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=ZHhtObNLijFjsu9rQLckiT9BDVHagEsGJj2ot5NbzhwGbK2uTqhgO9mCFth/lewKeCBPNC8Wi+UW55mOsq9olGK+e4ia3yo+zoXCPCNfxmAG0Myz0JNbeMvZMokT1rdKt2NsChp3hrLqMnbItPAfhWmaj/MKaOXGsb8LAY8Ob7kebsdkhDvTFWa0FbFRZpo4hGGwmWkcKDmcgZJ0FkvigkwN/ohVz+5Bi3xjWVTjVxWbKlDN6yuc5EG3a+jsVOyTvTAGKE9qZf+/IxuBPfxLJrHKmKOcxdTpGPswTcEuYdBcS2BTSdKbL8IGyerqFetoQFPNGJeJS4dxASfQI+NqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=nDLjCnQlOstQbx4BDYo5kzqUGMR36C4DYAVqUw8wXisxQGP8jLfnp3aFPJIr+E32DOgon9kTq8yPb1BVC2o0ybejhopmcc1vRYBIivXXFFo10MB7qHguDWi4Qf5DZ1gp2XMehOImOVy42ezl3wCcWT22sZtqMCDwpbk9cveviAd0iULG++gj+WnPHiaH/R46Hd22FnYe3WGuJxxcv0PGgUI6ZJzY+gAL5gMV9Wt2Dw3ewesl5W1B/Mt5s3gOlgkzKyzvJcosnqCnEnI8zf6Lqp0X9pnsZsLv6G8Jdy3GBXF/yvMer7SjERJvMuQcW3m81QNnXWsLW6lZqxU93RsDRA==
Received: from DS7PR03CA0222.namprd03.prod.outlook.com (2603:10b6:5:3ba::17)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:24:38 +0000
Received: from CH3PEPF0002457B.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::3c) by DS7PR03CA0222.outlook.office365.com
 (2603:10b6:5:3ba::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:24:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0002457B.mail.protection.outlook.com (10.167.252.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:24:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:24:19 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:24:18 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: net/mlx5: log Rx queue CQ number
Date: Mon, 26 Oct 2026 15:24:06 +0200
Message-ID: <20261026132409.14266-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021181738.1385097-1-dsosnowski@nvidia.com>
References: <20261021181738.1385097-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457B:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2b2f7c-7c4d-4b81-2073-08df33647c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: yV36dkAu0g4/fFgwa+QeosBL2s7b/PnauLLXOyTuIO+YyO/sK8pO+kkl01OGBofoOCQYgvE/NlOHHa+G6cnyfDEH5K8J7dTFeiqEnbUuxPCuaGtQApmngmoZdjA4GqlZ2vUgyLZRvwHfB3MtGHrhs27l53Kc63I+8oZ/zj04jJmfwxJ+pSecjc2KMaDyeC79437KgL0db52j5bXYyILtMzH7TAB6UtO5W7K03iEe0N8YLhN8OQNtS3lhXicTzVnoNMgQTbomvMyuMBtsSp93Gza6gl/jlTWijkN2xbxSls2OXefEOEqbM7EhpeVWW99AaiK4VtaT4MsfqYreBadbznXOirXYt1mJBJQxaSUhP+aAAW7JKbGp0UcefFTwpWXqgs6070sEwT0XUfQ2ZaQF6qbJ3iW/fcJIiX35tzUSHqyfkH4DvgieNffhKPkMQXwIUVhCaZKZpsxb96itFffqFH/fJukwHW4qudREjz80ktsdz7DVFa7UB/7NY4OAeTF8tv1vdUVm5wJBjHl01PA4fwJB+2VapM1mSAj+yomJqLz92QugXCjNdVjLaDJpIK5NOCvkzV250SPpd30ixf/mzADzVW3jipBRyNEIKTj9Q1l3Q0V7Ac1uCJ2zH5ufhYJI46vahmtI8hfQy0GmkJYEJl+wdZJJmD70753JWKcjHXfYnJNSl+nJKEm16xQIQ+jVZEeeAR6mPR2YZcJwqgPsww==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fnrOBgA9IqG7NuJRJyh2A8jWHhFQ5XK+PZpCNurvWDwVpZgKBFCSnuZ34Q73gpwP/nqfijeHrDUpmC3FPed9+LERRPrgSOWMOgbzeEjqvvDslQURgoPU048rT+jI1g9Lef0AIyT7HPf6ph8yYDL77vamKAA2nHIMhMsVceAemkDKLYcEWDJdAinxNcF3d+evryf5mrbBlbGXIiuCCFF9axbzz+/4ubcNZDdp4rODBxcAPqpT5rrJeWs9Dpd4+8T9fM0n9wwiVcRqylmZkwd7qMDsBL0SOrY01DqSOEEXA5UecU5isAQacieNprwRP8kYCbE7iSj44YG5XJlypdqQu+2HG9tngiYctFZtqGGaQaggSbYiJvcrt9OJX4bRV7iLnfVOz5ZmypZJNSnLcyYK1rvZbPiuYZ5oePK/aLq8d5nJpoSxvX88ailz474Aml+u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:24:37.8544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b2f7c-7c4d-4b81-2073-08df33647c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
