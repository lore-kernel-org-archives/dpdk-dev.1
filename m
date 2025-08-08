Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D4C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 07:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7418240270;
	Fri,  8 Aug 2025 09:32:30 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by mails.dpdk.org (Postfix) with ESMTP id 15D5240150;
 Fri,  8 Aug 2025 09:32:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK3w4mIWidjIUDgQWbIawxsEnT2QuqP3JB/DJsaviG7N4SYb5F+zM89m8Yyp26v9WKB2vAsCDRKylOQPclwwGFVTWHMYCNToX3JIHN1iYdL0pFSjgEtuYyMi1OoFMB63l9GciJh/Vey98BUgDY3R49iwGjgAYVvQqbzmJiN0L1+b7kDXZUKzDSdiumCfWRM09H2zKoM32netkPEfDo2GUlZx2cpTeZTNc5LyjBu/BSlOGL9W7cx4PV8TkrCgYdvXqEbk+9DhiVqPDYJHpCCnNmwhe7QfYsb0CKBO+BptdkBUoVO4SZL6A8EQOW5+w0RHK5Njs4AAroHKiY19xRhBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyehSJAxojxSQAaTTkCSE1nCIyadLXskHhPLjAEk8bk=;
 b=NGwzCHzQBDop3TLOnQ9MCbN+TVF7BgMXFRlmj9945VRxc/TQNkzBowulrfclMG4bRFgAaZdTiUoyUXFmsEU5Y/Rm6WkBmDj2ou39BspZjONXuwZCzGfj1udrWEId0ZB4oNvaSLkkVB5u7wVthQFH0TVc3bXqFu7s8P/+umqqoX5QvAl9Vp/5KERZgpxcSJhmZq31G/flWznxNmtj1G8lZc+w4B5Q9lFChKUT7+CJIvtvI+lngBUKWG3kJvz2I2BNLwF1ZpyIxriBVeaQlwRPQTdiXenhU3z19gHyHxs1xjlZ1f9oJ2XD/jyPxjCuoFbIxK5wEaOhIdDk1v0gwHstHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyehSJAxojxSQAaTTkCSE1nCIyadLXskHhPLjAEk8bk=;
 b=EkLsoxJ+MlyA3Z6N1hv8h2eoaoJ53OF1ah509sGmrIBsUaGldif1wgJEmjba08MwieuJS+IoJlD34Q5jf5Eq3ojwafwZvBKi88NaDVhwsDEATv3+eSM04rpIQIBRVO1amR10HGd2CiUxkPw1xfotGrtFyzkJasljoIEfOGNR/WeAZbnT1nnZ9WhhsIz5jnKH9mdshFhutbuEf+cRG7p4uNDcY+d4JW9UQ0AGRglpbmVHFeqVXLFgvQTyvzabzN1IN7I3iWh6eUNSpqoisZ/gJHk6gQ57HGSj77f8QecdB48O0v5pzv1UbzGmiSnuxR5MoND2ZCtxp1p5hiRBUWZi4g==
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:32:24 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::b7) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 07:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.0 via Frontend Transport; Fri, 8 Aug 2025 07:32:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 00:32:09 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 00:32:08 -0700
Date: Fri, 8 Aug 2025 09:30:33 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <matan@nvidia.com>,
 <suanmingm@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
Message-ID: <20250808073033.cjquahkud27p2sdr@ds-vm-debian.local>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250804050514.244896-1-viacheslavo@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8a1a4a-88b5-4234-c412-08ddd64db7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QELkWf7T1c1wb5zuXlb3664Q/C55y0wdW2TBLb/SwIXY9FitHZTTrBocMWmd?=
 =?us-ascii?Q?LGmysXpj/SVSU3ZDnNP8/wihxaum3jj8oPRrltlv4tUmM9pwSEn7wzs23iD6?=
 =?us-ascii?Q?3iApYKIwCQ1hBBKHU0zmfW3+pbSwJIe6ErjZN/wld8fn7bKofYvYh4gsf3PT?=
 =?us-ascii?Q?XiDeqvJZzmQare+LliEj/Lb3l5OMdf9obncR2jIExja0t45RLai2pavL/nLz?=
 =?us-ascii?Q?doQhIhIg3E3cspkRUrmausASetBq3uNTXS/VBMeCZNyVv1aVbGieTMZTp6ll?=
 =?us-ascii?Q?0W1i1TpXj6HWGOmBO6APET8O/2uJMfkiDqNXLwi8akhxcrmr1rQdDu/EZtbP?=
 =?us-ascii?Q?mabnZ/elTMsHj9KntaFAvTltAkfos3hC3sWmtMp5W5rmW5+dW1S/GbnhgWo5?=
 =?us-ascii?Q?HvLYltQ1mTrOq5lO+W1R8tSIPpQ3mcUOrGgdpx1h1Y/MwE12DgCSWIEG71pB?=
 =?us-ascii?Q?WwDb9fWtb9WedRUuWgwX1JIieE23jgfznW7Tp23te07+nEz3tf6p0eWEizWx?=
 =?us-ascii?Q?wRvodgY7WKsc0m3x0pEKj+kYjVKxb4PdbNN8opfFjH2Sa1yTZR2d3NuDdvjy?=
 =?us-ascii?Q?c7uD4aYYGVsysutWiZrnZQ7NBFhwy5xzu1bkrIGZcbNJEBRilxXG6zDK/d+G?=
 =?us-ascii?Q?wJV/DnajFPAWtmP0K2owa9BUXlvev3d6sp4uyteVbMD/Aiq6kDzuNKzasteZ?=
 =?us-ascii?Q?JfG0+5u8w+At3rKBd2kKMkHgZmWYs1h+oG5Amkr+A0Qh7D+sEbo8692Xdutf?=
 =?us-ascii?Q?Sdn/oOCTTNpS4b1/IzJqCMjikXSxIQdJcVnosbmuKkM5EHKBdUwMtHF6XVGy?=
 =?us-ascii?Q?thFnJ7JyuHieDCXhFk8FEh/wNfp91ikr8hA4TadmiCLPPXxi/0CujdJYQZkD?=
 =?us-ascii?Q?F3uQKRv6synZpjk86gRuIRITYX07pEugeD43zTUfL3mIeVAOVnwXS4jwrrT8?=
 =?us-ascii?Q?BEWJzGWr9cm3dUJmiSs1lYFi2MZHUVVwldS2jo0OPcgaKErZ8QLaV5FSIL0T?=
 =?us-ascii?Q?JzcD0DLeFdSB2Y1j/VQANJTqLSnCkgBuva8fjy0HNLYPDHh40LB30p7ZhfHY?=
 =?us-ascii?Q?4GOu9vsQkc/ik0FwFWyO+MRZq2EfMZJ8eMIBmWoniKnjmLyFm6pm+Qy3g34x?=
 =?us-ascii?Q?/T29P/MvMVMPMoeeStDdZWe5g3Q1+lsGhKyl5NFUI6/rxD39EOrEU/NaVMv+?=
 =?us-ascii?Q?jFJnW9iWQyL7W8DW2+upMFKiWGe3wzaAeQofJjJ8b1OQcVZGhWgIOxsbcaI9?=
 =?us-ascii?Q?Pt+UTDne2fq4tUDGatjAuhs0yEgXLDdTILrddQUcro44TiZkStIcUSHWM+JT?=
 =?us-ascii?Q?5YmmtsaIV3EgCJqE7Lt7YMoYWLSXTgQeC961G1VlEoWccUKbqjbsV3uW723k?=
 =?us-ascii?Q?Y0fRbNl/iL2tXam3RZT/F0yPT0tukci9FsUW93D+wuVc/B/hnJp8EZS/Is/L?=
 =?us-ascii?Q?yCZc3FS1HPGC9WC34FGadLkKuseopoWPRINtj8/AG2BvE+iWNFEXEBhJZVxC?=
 =?us-ascii?Q?zDjClI/eBEtPD+uS4wU/HpStUOEasRBB2Hp1?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:32:23.7972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a1a4a-88b5-4234-c412-08ddd64db7b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Mon, Aug 04, 2025 at 08:05:14AM +0300, Viacheslav Ovsiienko wrote:
> The pattern like "eth / ipv6 / esp / end" matched on any IPv6
> packet in strict mode, because there was no impicit match on the
> IP.proto forced.
> 
> This patch adds the implicit match on IP.proto with value 50 (ESP)
> and adds implicit match on UDP.dport with value 4500 for the case
> ESP over UDP.
> 
> Fixes: 18ca4a4ec73a ("net/mlx5: support ESP SPI match and RSS hash")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
