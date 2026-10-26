Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50359606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W4sONmTt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9171E402A3;
	Mon, 26 Oct 2026 14:21:20 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 6037040275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 14:21:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZfQwY2VMkJU2wNs4T1qqgfOGF4KRR35p2HqZ7ZQf1ULhkgFcThR87zQSq8kHGE9ultYdfPkjtT/6VzLe/DIXH/oAr6aAdtK5KSdwZpg08jqH1XrHYLGSG8pO7sVsn9yFk6WZTA84We0b9NBLRqBN3W25DeWNYrmpM4Lk5vtT723OFWpnReUaqzZ/fwFVqLIELEQ/RDD8keGARFJPOvjtYKL8UNZKDw7kMNoOM1ziXMExJDeOsSWTOXrIZzLYE/ETZoQNg1d+IYJl+EwSJNFC9p5c+2rlUP5oAPl7ni7JJCIOGaOQ1YmDZn4iX6386pkn1Eqvs0oGRp+0xOIbyF3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=WgwnR775KfuE2+VzwrRXh6Ow4FOHd44pj2DTf+5k8mfwHefkQte6KzZCyzD8T0r0Kpo5opjzWqDtKeYr3onYn1p8fIkn0a1SoRmGhX1CCmmroYi/BdK/9MwMz67Ul1km3xJ2MewflIp/7Upo7Of9P4ShgGlr7XCExjHZH0GVfqR94nl2wMaj96+ie7MbFq0WexGKO34qXLpjSzajzycyyBX6P3yIQry1Xo6QPy6gyboEFzB+n/jQYofYbYpJ7Yn1Nfs4JPRS80aQHeHFQ+nsDxIcKUcxkAcT6dmpX87HMk75LF8QRzFz58+PBa47U+StnBcuWCqXJtKDcCjd4TZGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nfware.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puH9YT+5jrwM1LWZlAdhQiJqp6eoiFLmwTt2TriOMlw=;
 b=W4sONmTt/JrjUD+Ce/rTrzoWOLJc1SiUj/YpgOXty86icZici/GZh0YFUb9dUgBLRd9Zj+QlyUmIw7kSnssoXaobz3uoCy74kaEihL8DWzXJ0BdnuNagAnj/mhioJ+0uYi4bUquu64fqmOuKbdOuvcN4UZds8P4VGiTlkTXxceQYapeayOeoW2yx+kFD2NBwyoXwCuxvNX+xGKkV54NmQBq5RPKUg9d8tlc/3yA2nSxZdUW0nxe2lPF0BjeUH38JjY172/Q3J26d5GirRCMwl69UGgBOg9XqISvHZxOpElSX8ESdlFZ2H0+sQvLc6/nzb9kCrmhdLBMy7q8utQP4IA==
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:21:13 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::4c) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:21:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014676.mail.protection.outlook.com (10.167.249.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:21:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:20:48 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 06:20:47 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: Pavel Ivashchenko <pivashchenko@nfware.com>
CC: <dev@dpdk.org>
Subject: Re: net/mlx5: restore fake mbuf guards on Rx replenish failure
Date: Mon, 26 Oct 2026 15:20:34 +0200
Message-ID: <20261026132035.13187-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924191303.18938-1-pivashchenko@nfware.com>
References: <20260924191303.18938-1-pivashchenko@nfware.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5841bc3f-c74c-419c-982e-08df33640205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: w5aWqx205QrAINb2dyiNlQc8DB2+h9PIv7fEA/FBTNn6gI7A7d1KwsZZOAwvwpUfwMPjI8ftAiUQmsgGYMmgSX75kFkyVcX2JBm//Y6utGnav2rOa/tK1u0VKj68RJgCdn4F0T6HFWtjOru6SNOlq4dK4EaOcnCbqeZlyeqxaVxhuvpUc4mm6BjgqhTXXP4yuUwlzdGDjCXGcNn3Uz5zRUMUIz6hM7V/toLZBoEYXlUfMicK2+fvwA7nsx/hu+wY6H5GGGOjVp6TaZfNoY/LZzRB6YuA5YD1avpIob6sCvzoHFM846RrW+muBa6d6Q9bieNjwAGhVgZUv/UzaKrRkMXgY+DPJTVlze4/VZkyZpgxIjxg5BYSmzOzda6nWiWCLW2f1m/M8ZV8KftUjl363KaCoqjt1K3Z5X/umrLxMVRSvDWm9jhY7xuKv4OmbQ6U8pVQSBn6GaLonUr4GXKhIvEnZMzICN4dVdvewkCdP+V2QVDLU8W9+NpwDPck8e8387r6aXpoEJHHaQrQfqQ71jykTdp96ubYJVvo2uj+u4NwQ3wRIIi92gnZRRsK+VJ//jyqWcAkg/bK2rGD8KxvNyH015HFC46oW8tBcIdr+/zwYJoZQsh4pOhe5k2QVtWEBE23J8bun1rDcQYb/3/KIxD/QHh7wYTNQhhuzOfyGbvNFsyj/KWPk33yzNBs0nQZei2hn2ylg76RUz+4wtfiAg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XnhfCey/H77qJwe//LPWV+QiuK+M1ZmYun+oUSTPIZcsUkfwLEkCEkaXFc/UwtzQiBvTXCSiz3M7/qhG349LumHATTsdzHPfM7g92kc3BlhcvoVYeJfKwldmUnQinIOi2s5Fo+d1p25/nNiiDBzDYg40fInEbRhwg8uep+odUmmykNtTnklmwRSmg3aRpMG6yp+mAQhs4wG8tPVcrRx7L8PkuPq4TyDro4A2CTAuW+7l6wfcikdyd8F19+0nEoZHCFzsieiOBicCjhrYw2K51cLvhmiQeYEyAwpHCMntBaAhB1J15otCi2vL2ScZxLbYQQwE+qnkSifmUv6OD6tVxtwJsZYCEdUMCv8rfEfNTiC/uofX/gdUfJbM1T0lCtDbwoBhjYNcy2THBeD1Or2IDoAE2pY7VRy03QNfF4K6ghnaGAPPIGx8BUw4DBnZ3DSG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:21:13.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5841bc3f-c74c-419c-982e-08df33640205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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
