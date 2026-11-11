Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC4606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N1EKOwCq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5DE240E1D;
	Wed, 11 Nov 2026 14:11:25 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 03DED4029E
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:11:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCAkjHKPPZLk7qrXv8bGH03brEKlFu803z13qL1ooY99OG+0f/ELX4DLqgnYm0JegA6+bG3/m1W1mjVmnk6AI/rTbvzWmt/BVUvlOmI35iL0BLKLxHKcL4VUMgdwoY6LKVgR0UgcWtUJTSdOm/aeB3tjf44pKv7lO6jz/FStaM97WNx5ED8S8NvCyqwa2JFEBOiIvSVo+rEwl3B5+8ZYGzuO1ic5rr9b1DiGIYfFZzSG6y2CApyuuC+wpUD1/eHHfoCT8m1k/3zabu97fH1xUMSDy4Z2+sBeUmDDO8VVoXbdPEnmtAkRjS6GaaTFncDZwJv34JFZYeqJYsoGhpZ/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=xOvArE+JuaLX+BTRDu1CZU2OlsTZxZMSD3HXodtb3vdKJeKKXLn8gA2i7VgENEnSUsrBldYp5JdKH0AlvZzNOqioyqUkAB+QV+bqyysHidWWh8O1FdoOY4SpN5gQWMbWChIfSGKiK+CDylimozTC4GNjxHChWiSU7942A5sz2zlzZ3OrNBy5ny+pNxautg0Lf3KrZWl+nn/lu+AWwPr6QaXwYFYbI1LnYqgJ+jcS8jH2gKqDGAm3SUQFRBfLV7AF/erFHQoMNpw0at9DQM4rVkqeX9VxHw7P/nRR9Grvb2u0/l1S+2S1UsVdLPSNft4YRVYkZqm1uzbgA+kXRuEILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=N1EKOwCqYjAHHxoUkq1ZdHWwyLREtv+lfs2+Mxwa+kybUmL+oxktjucUg9H8V9fa3qaDFRqWL3u957QduA5tegSomSe4IBGqFPzyuveogpL06nj2byTCsFYrY5lLXlArb/KwTEI+GKtREKtCpyOW81nt3nNGJplOcMxZYZ8g6NFo/4ubyXg/0CYjU1oArcXQFozUkvTW8PfoSIYFVpyL5Es8Pv0wlbMVqo6sLPtHI/c9fu37JxkgB4OyMBqDHj4LNcpi45Wp7+VZkEADUabXAUwval3MZuIGoPGMvybFlaq9kWfP6jCy9ECqGZ6WI4nPzCPxQNCnw9PwQjuJDoNaEw==
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:11:20 +0000
Received: from CH3PEPF00024581.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::81) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 13:11:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00024581.mail.protection.outlook.com (10.167.252.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:11:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:06 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:05 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix NOP insertion for modify field read-write
Date: Wed, 11 Nov 2026 15:10:49 +0200
Message-ID: <20261111131051.14288-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109125034.4027845-1-mkashani@nvidia.com>
References: <20261109125034.4027845-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024581:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 15789b75-78bc-4792-aaaf-08df3ff54701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N+XhJNw665RGEqtEpVj3WAb+20/iE1ryGvQXRXMxUOm227j0/Q9UmmH7i6qXDFI7ny/jxBVy8+zeHxeiGV0gFGhuNLI2rc1lvq2fo4bYjw1LkA255oRnsUhSlrMTOsQ3FLr6RJNsY9nC4lSX7s/voV6B7DnQbzehLf1ysFqxgyhETpT/7kWMWqdineROcvUxTlvPGtF9cbe52Z+UD4Ulgfzat7gQoWoPzoqV3ie4jiXJKi320tSjcwP8FU4ekQZrTYH+Uyc5vAH0maXivvdEqKzPrmf5FVgavGd9ibrgER53+kE83T3yCM/FYU1pZ9qiVjglpSdDAp+EcDL2hTv50pqmpcpDO34NHEUZwE1uWdRcfChuRZQPg4MXEwHh4PZ7O2xNzsEkLKnYvCH/wQ3I6j/Q79Y9/Z5HTITqFnT9oZR0DDvg2csuuA4nTLmwrnvzQVqFFJ1W5APGmFzcUQ/bYIZ2Y1VZyUAdMLSNw2+6jUBjrbr9IBNas5c2OKpPj3bq2NFozPolIL1hBZXtcgJ1i7Emg46TvAHavGpYx7vOTb1n5Ux676Ld79jjdsNPbaamxEPupLN4C7rfl7zi+g/6irf2Ez0iNi7Mf0EBUzsmdacmW8DPbrZl1/GUFhr+EmjwcV3/FlX3bCt1E2VYnd9pZS7BWCUa2KovcJe/fWuMeQpyVaHOl8dufKUClKlxBDNl+ZxSXwB0jsHAtGdnS7oR+Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uGLRvt5O65oZgVE8erFgtZU8/iHUXFpQK+AdylVXzHFZ3bRFnqWFONMFwmyipKKETu5FM8+SPt7e/m5j8F/ZmGYG3Pvb6JXo93jnMiyPqY6tv0VStt9Vje0laHImjV1jxnwEHb49P+qpCYyhtaMbSdV20Xbz3VvxvjfDCbKJEdrJYGTxbQgv32DYobm8RuoevXA6EqVYtwPlV0w9pql3xNJ3BzfiYJ4oc9vxqWP/0JYoP8BoZAoxgHk8QLKMXFQA8M7SV3/ry+IcQkMmCII6k3WMk2fnlm7WcX8n1TulePf6FAUyabbfGJXXVgZdjQF+CbVNSUuqmubcJsuLZvsAPnyMZ+ThretSgIa3JQ/9nd97V0tCngOtOIAjB3yGVu5EO+bwKCf7I23Hh+S8ho0f8wenAWzGshTQkZ+OuRO/YAj6Y+7XAnkgLNyyw5pSCaWe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:11:19.7518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15789b75-78bc-4792-aaaf-08df3ff54701
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024581.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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
