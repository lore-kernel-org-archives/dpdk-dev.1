Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A3606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QGZAek9H
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E22940DF5;
	Thu,  5 Nov 2026 08:37:53 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 042EE40E01
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:37:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUESpA2JbPO5MYWS3HeMMSlPew37QqG+PQx/OWb7Se/g7Z6KfnEcdprnjvLIXawKNnqcw+9ZxMeAKeonThp8G4Ty7t5/IpXJG3SnWrVuZQAqm06h34uza+5PRA6jxpG0ekbgHzZH1s+fQgLAoVTJG15J/YoKt5P4DAtL7zzCPCwYXkUCpjuxgrBzoRKRMcDRpDZZqLVrpXD0XppBpMyzrcCcaoAYZ/WWqOmXFYY9VhXJJRcQUWY3Hn9mEtVwqDoQPsgyOiZYpO84nhUkzdgW3rAlTk6V3LrvP/XIpXsA6d3OCuBKgh5vuBli8upx6HyjCbQIxNThwS1Afb/0nUgl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=WyWDmaIxA58/ciKL5xj5T3OT1wjpSS23nOSzO93tw6P2Sr6PLSGoMTSNJeFFVrQL/5v42Ybf6kmwUVKeDIqBmHft2SAKlTVGp5iyj33+gZE3pa3qzIiT9tJd5GIVIMCC1pgTlu4rgKwF2tSQ5HwyW8UDyO6O+R11W1aAJdOzA6vU3Wz6qKqcfgXHOkygZV2yQ2itdcncfI+ZGqxBkxPv7ZcMmWgae1UMOT+gQvHSxIv/XyQr99zZd9H/MYCFxWqSKeOUu6YBZXwXAWTsLIvFmelaVHNqgXDmb7YbHa5XoLb371eDdKlptv0ckmvhickgoKjGMHZUgfrTte3quPPCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=QGZAek9HLcvidiiS5kysk/B0D5R0ObSQ2mqC6ASjtDmxJqsQ6ZXYPrFlx736u3U5V1YDsPUILzqyxOhFgadXV9tt4WUkRmuthNwhVZT0Fdgrwaypm1OZIVRfgUa5VqsTXkvOfzNON2DJXTXlzNvs7TY4N+1l42p1eWIMp7o42oAIYNcU//11JoPcQ5IBUHSt/utIBgK+qdKLsZC8r4hn5xNYTqa3uSi8ja5MyiD2okxaiamv3eo8Vdqw0IO7Z2mubBc5SJpeDEy4VZjOxhuzAE+ndacpRaUq/V828rDVfZtDOXdQkZEwj3jPSuzeA8Gg/RaGJLpTLMwad0v4zoFnrg==
Received: from PH8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:510:2d2::8)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:37:47 +0000
Received: from PH3PEPF0005961B.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::86) by PH8PR15CA0009.outlook.office365.com
 (2603:10b6:510:2d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:37:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF0005961B.mail.protection.outlook.com (10.167.243.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:37:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:30 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:28 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/mlx5: move to polling for LSC interrupts
Date: Thu, 5 Nov 2026 09:37:18 +0200
Message-ID: <20261105073719.20410-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030172843.2304296-3-dsosnowski@nvidia.com>
References: <20261030172843.2304296-3-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961B:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a36ea9-a2a3-49cd-70b4-08df3b0faff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IVM6DOzq6aWBuESjvNanIExKL3FqvOQ4qhnwrkmra2rGEhY4dUbLoUQM9MUIEDggEvOyNuQT5OrYaKYzbHMMRK01Pl2w4p9LHDyCxAHKRW2b74K13TI56MENfH615jTsy21OaASLeDlNVkIyYaNXN3QYU1JFjeT5IF8vQp52pXjkK/tQyCWpXAWswePgrrEveJnhW6Ol0iAp5lncrVmbtoUVV04KgrWCfWZ9PNg9zxyKHXgO28SXGDCzjEIzWBOj09Q92GmZMjwneS8y96Oit7qF6615SgDNf8QjdriAntObOzJmaBDvvXfR4eVNEAsjdnUAJVGxisxFVXQdL/2u00hsWzV20+u0wRLtrM+wnM4QZdxFQFEzg3A+rGUiIJTMz+d/n+/PGfPGrrBc6C+yE4r/pXKzH71x/niduAiiWGLCwIILxYnG66e5sZ5pw7BPp3h+BGTII/0rPlsD9ZSxDcD5PcSxXyVy4V8oQKUJNR/E0jxyeKJtIHANngyPTGHLbEXxnLY3/p3Mmobk4LkONVFwy71iGo+VIZmTNTPUg/n+M71nQLlKVz8inh7x6v10D5yIL2AI6s+fsRyjsCtM2291EIoqVMYCykUCizhuzh2oOHm+mPE0EaMS3VULfJwRgb3qlmYOZv6AewnovQsULbjsCU9+++bMkkwxVI9+78Uzv3n/GxoUYzc2LN6xrQTJB5PwHGX863CX3YFOOM1/zw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qKR9h5NGl3hqkupfrMf0e/GUMZxKfrVUwCQqNkJ2w+xAg4li5tk4yP2l/kw8degE6+0N3XHawncjlFqnQ9nZwfLvE/mor1PBPwOjgciOJ2VjaGm++KcMZT9iRsSClhkUaPcJsqfDYjBh+ge/PSPoZh1BFRwnfuckKWVxzpj3kHi+nxzIbq7ZZkHt4PkO05c4/hsYpColFN+ym2Qw4c816QpOtFnceOrHZjXiQ20/yz6pZxHHGc1bVVXIYnMRvVGddvdkNqDIM8sw+SZvcovtupY001sQnh4jeryNgkrZJ34URd85Arhc2PSoYAJq1q7zU05Ndp6tXI4+CTY48QHG9wGx+8QKaFcB/Uz6rrVROh5n8pAiUaIk2nacPnNuHcbuTrrv8OXA2Jmh8yQsvwpP20sw9Cg8gjvWS89BWMDu+Z0AjHTVhVLVrgv6dsFx++4F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:37:47.1105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a36ea9-a2a3-49cd-70b4-08df3b0faff8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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
