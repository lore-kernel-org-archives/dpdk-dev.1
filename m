Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39478E91299
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4450C4026D;
	Thu,  5 Feb 2026 10:12:40 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by mails.dpdk.org (Postfix) with ESMTP id 9A98640264;
 Thu,  5 Feb 2026 10:12:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV0e8UyjGhqXDpWyuTk/PkNzwdVKb6bgHyWZ0ZP2Ox98mD8ICsBCPjfADrLXNR6B6jbz+Z0CaFU9ifTLIzRxCDB4pWYnuSKLUt13DO0Pxq/KJ0yaiwHdSa+75zauMFxUov4SSCHYN0HjU+RA94yZpWoLgVe9fGDe7mwBtA69mWJo3eMhjUg1M7+3admkENBusQlvjMFdVzJHB5PGSDv2towJ5pehCvPSHW6h9GepapNgbaTM/w7Lb9ijcs+S5zlESL1dtWbWsbi6xTLk+nT70Zx9SzLbzsuHwMZknlh3GYTZv1wT0htXMrJrqB673JyFxrxz3j1BIrarBbor1jtqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO6RuOcK3CZSHX67q1WaZCH4buOc2QiMwuBJBZjzDec=;
 b=Zt6rEYL5hddhIUKfcjySQxIF0o/vzTRputFtPrDOnSvmgn6zP1a5VOa+x/5bEYykEvTXQQjGgLTBrbo+Xe/gjzc3wxxz0q4gbIvm4gXXBkvLg8hgnJo1ruigbZ3hWgaCGasf7MuDT6BXdgt29xJ2ZqwM4anpCiwn/IvV9T2iQdGd6u5WVOTYfvYwHHzdWN8RQ1qWsw7StpuVu1SA6xD1z7FDBQAZ526QbQZdZO9DQw9lZlWcvXPbZbpQiOzzS9YChsisNI7ElEdudjbj9rpKMlsz0si9pXA2aXUwVUP8dbg4vWKTqESucMdV5Hij/Cghe+QJDvZF++Ng2yoRyVUqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zte.com.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO6RuOcK3CZSHX67q1WaZCH4buOc2QiMwuBJBZjzDec=;
 b=F3yLwB+I634Ac78C64HipHDmaXhsNYZXK3IdhP7x4dRy8qzADWHth7ooywnOGFSei6fIxTr7alAAZ7n+xXg/flNRO24fiDDKGPdAHz1nmy8Y10tRC5p6booqZlWdEWOw2mS4CF42/JGpKBfdreiKTkoruZpfHmPekfYvOJshpo9c+AmqEhSqlitzys8bCCgUjXwV82Tayf5ydHtbfBlrBXaZPiytsS+I402DkDlIFPgSGWJt9YClryMxmFZ1JFYs9jXynMTOkRx1aLr5wToqV8GooU4n9K8N+1dql/Hnj2wLBunV+eywcvLYALzWe9R9QICoGMNnZw5N/OpkSr2SyA==
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 09:12:33 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::32) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 09:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 09:12:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:12:21 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:12:20 -0800
Date: Thu, 5 Feb 2026 10:12:21 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yang Xu <xu.yang3@zte.com.cn>
CC: <thomas@monjalon.net>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <yao.chenghu@zte.com.cn>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/1] net/mlx5: fix port down in link detection error
 branch
Message-ID: <gs26anfuiwtc4htlczfvqjmt6rwaoohtcnptfwor537xexazf6@zfodp75nwvqf>
References: <20251119060222.2814478-1-xu.yang3@zte.com.cn--in-reply-to=20251119060222.2814478-1-xu.yang3@zte.com.cn>
 <20251126050948.3030776-1-xu.yang3@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251126050948.3030776-1-xu.yang3@zte.com.cn>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 324ee009-2ccf-448e-591f-08de6496b1e9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?37PrbvjtZRoy4mfyE9qbbdJdmlzVU8WkWugzY1e99k9yrUkSknGQx2WA1CuZ?=
 =?us-ascii?Q?CfrP0qDvHh8lqV5fIMpuKfT/shlR1uWC+k6kewd9FLOLLbXmtujXVlNnzH8m?=
 =?us-ascii?Q?1EsitEjUb7HqnZhefqj7gMK4Wz3jBs3F8GjiFBvWwraag0OEcLQxjOrkAXzL?=
 =?us-ascii?Q?ho4vl3+bgekkNROBYm+rNr67nrCmy9N9HsP0dHlIKwXxL0d+j9fwF0MdH7Yj?=
 =?us-ascii?Q?AsW2sGA6kBGq8W5ASM2GbkD0g/NGpfnCW97NX7gr+ouDcWDQl3RICaSMqUES?=
 =?us-ascii?Q?Ehkz8t8Y9vFciJhA6r2nAKLEKbBZns6PVZkaLb53sNQ35UUuFkq91Sl+QqlG?=
 =?us-ascii?Q?WZLItivL5ZUxF4P8YcXq6DAtrFf4FDdYNvABLY8N0OiEDyMt8J9ld9HPrVTU?=
 =?us-ascii?Q?n+PaVsTQDEppCdMoteKVgCkuiuyGWkqP/z6BL3HxpxY7ccKBQWynugXNvLGi?=
 =?us-ascii?Q?C/jDvgyGaZ8evbzaIugNlG5btZqmIrI3Dso6iStrUbrUYfV2p3os6XvKiQML?=
 =?us-ascii?Q?5a0ykrq3IbUYYoYzSy9VObL4LZKS4gE9q3aR27mAqQ8AeW3L0W0hJM+LZp18?=
 =?us-ascii?Q?mYMQjhb7DjKSLtHtYlibYMawPzHoOVed+XivpdNBy3nw7xm62kjbNmTF3CmP?=
 =?us-ascii?Q?LKFj28DGK0MQmSYPY+f33HftWxHUZPdaXFgs05dzdO/t5zXz3hNPyhfLMA09?=
 =?us-ascii?Q?FgyL6vuwiTnQ1YeV8ivRkuENefErgZ8FGiG9C1tFIqkcJwWbs7Rj1ITQLu7t?=
 =?us-ascii?Q?Fh7JqwprVgUpQTlC1F7WOfUWKMZ2HQfNAqJv8HUtr44Hnhm7AXTgHVxp2Ifn?=
 =?us-ascii?Q?qjb9dRuP51GXDn3OJvstFMvP+yWrsyKlLKio5/8Iv8H2aimZ6SkcEwR6SzNd?=
 =?us-ascii?Q?3j59ea9Laz4WExnn++6EYw0sMMQC2Z4lnNtCOM8quaXPTk9BG4y21u30IAE4?=
 =?us-ascii?Q?k+D5l1xo1P1uvVXFCuYFSh3KQuA8TJjsMVT82z5l99qsUNLfIuENryuSQoFv?=
 =?us-ascii?Q?6z6AM5rz3k6w0IrKl1OUzop0IZ6WTWlYN1xxNGhzHssC5G9vGhcVRyuSQzF+?=
 =?us-ascii?Q?cIhnCAQn7JcnLT2XVCE08VhNlS4vNn60oAL1B6/HYEyg26do1RflWzRNUJej?=
 =?us-ascii?Q?spotpNV4RRpD28JiSsHtr7kQF3Zi4AB7kAdzfpf7c/acfcoxqjJRAHF5h+Ho?=
 =?us-ascii?Q?fHL0Ftd4IBchcqZHg4A9ZSQfW2SLSFgtp48y4JcobBbyvM9ZnvBu9dGW1l85?=
 =?us-ascii?Q?eEEvaQ3pabNpNOMOBFoq0nKFW952bB1apj58WJwRQjyd2mlnutJ1bHR0p8dC?=
 =?us-ascii?Q?8c+Z1GDkgWaOghb4db1YaNzeU1TALqnENvAHlyQQFZrA8MKIuJrb2GGwYPKr?=
 =?us-ascii?Q?bAqNObE0ifHPEj0gNEMDNN9Zje0kjm0kUragHPhJ6Hg3Nlv5cG43GiR1Azjk?=
 =?us-ascii?Q?cGRJh731xYQDL9aqw+BIzaAcdYRSzaT2ANM+yISRX0GAljlXoColgP+LbPjp?=
 =?us-ascii?Q?ykufuKGT8W/O1kCLMir9U76SAn/zRRzidbngnSL6bh9lQVkWa9Pt190G0RqK?=
 =?us-ascii?Q?7hU2GSUgCPeiH/+O67UPc3NXSnEZBVA4SbVbenFICmNv/lruM00Z/f7mQqzK?=
 =?us-ascii?Q?QGICm2xr+b6XfF0iqAmZhUSWUqylHzUi6/DdFk+Z/b/ZVcM5cwsKkPfTyd0x?=
 =?us-ascii?Q?RlLlAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2QpwXAPnHwP/RcMk1f32MkxUef6m6p7j7fpHA3bwI3r1MMkd34LZ+Pla5eH77P9XbXgvn2ZgG0m/RftgYb8J9xXYqumQWzSt4bR2+v97mTlIbGTb0ZeqQ4BAUv3B7GeAYTrfQoK1f3qu17KmNOOx0cujkUv8F+BilhdayfclD0ps0jjS+VEgdIB6WMTW2/vKQy+H8F6yTQj7rjfFwINyUKpNzkC7mJE3rJGHKhfaB/Uv5GKBACyikYDg5VXJxgvK18fPd9OGW7QEzgqh/CN3EXdulRZTL+znpsCgA+ASDIAMCB2hDeufaofZHQnDfohh6T0sChKqWgkEGpKwqI7jRetA99nBu7uzTLIHmHlVeBrjDA0kGtTGeAFzuIkGOxznBQo27BhPbDSSrR9kUOv7s5N0ILPeCTNk7Kg0s6fi2j6MynRr2zU5jAFoksfB1QxT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 09:12:32.5475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324ee009-2ccf-448e-591f-08de6496b1e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

On Wed, Nov 26, 2025 at 01:09:48PM +0800, Yang Xu wrote:
> The port down state was not initialized in the error branch of link
> detection when MLX NIC link status update failed (ret < 0).
> This resulted in incorrect link state reporting, as the device
> retained stale link status instead of reflecting the actual down
> state under error conditions.
> 
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Xu <xu.yang3@zte.com.cn>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
