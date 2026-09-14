Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB4C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EDE440DD7;
	Mon, 14 Sep 2026 16:52:30 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by mails.dpdk.org (Postfix) with ESMTP id 6DD5740A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:52:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM3vhcDGDINCGBDZFsdnTp9Ccy49htfrZb/WJ7i1nPGgFsA8kPsfP1BFqyRTA6j5+NBgH38Ewq2W26qg+OxFoB8qpTJYERyUMhPIvm14lBdF3V8EM7rmf2ZpH3DaOn2oEIiUhIZwHIqx2JCsoahKNsRT9vh+gemVKrhTqRgq2zJA7AcNk5eCMByWCrZT7OIh41j/IplCwKyuaGlYwZwogAPK8cQyXD7ZbyVSYzj8ad9nXE7GcX0q2oyLLjVqiVwGyzw8EWdHs3fvAbsoMGIh9HafAE9D509M8CiYMIpt9LKU3IdYncWuGVJbBfgE3Yt9OKQINJ6v9EDb4M/aNlFGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVKUBBxGO2P6LT2rRtxH/zvfwBK6P8JGlf52uC7Neow=;
 b=DKbRYqIvcxxXcUv79eFBHmGEtV1uD5xHCwpuNLs1rYUzP/R15f+aE+6eugfbkFSbGOVWsYZ8uNPXHHQbifIHxKztYw2C/ECO7RThpc7MyDuRY3N9BlCOdWSSo3hUJLdnMwzS6iir7PWFTQRIumQR/f8B/gy7YV1ySFMLqVElgEFBv9AkZ/2iD/etrQLoLN9ylCXvPoHGZZGn0geV6IyUnZ3M9qr2+BQBrqWkx7x12hVax1krEgJK8BcZP8cIPcwC78NNVhOJ9K6qYLt/stnIPtzWkTTmjUuekaud6R1m2D3arE0y53fPGa4Tf9oEXz49ALC7DNAuxhzMb0T4d+v8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVKUBBxGO2P6LT2rRtxH/zvfwBK6P8JGlf52uC7Neow=;
 b=sAHphog6IfIjv4jBZyxB3cId8z6zTKCB4pWR2Nim9FtFsi08eIKgTcRiUFABOUHABYYMVyTl08dpARsrnY7CW18ew/ljvsHUm0acEkO4Njwu8sP1nKRgJ0BiMlQLTlJyL6GWA4PCHG5EeW0PPwHzJsijk7+x5+VXuL7UwEzkmob5Op0bP3StwQcD5XOVDC+RDJI6BZ+h+C/T0mY5MJS1qsV9hRf1IjefjIPNg1Zofa2Shk9nDXr5jvpmiYxhLyhsIGkc49hSprJatOA6UCa5wUhBMkmaWVwPclJNZfZK9MeI3TO+Q+7H9sIU7aQj+hjJDSI5YcnY6V5g33kMLEyvjg==
Received: from MN0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:52c::25)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:52:21 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:208:52c:cafe::97) by MN0PR05CA0014.outlook.office365.com
 (2603:10b6:208:52c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 14:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 14:52:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 07:51:57 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 14 Sep
 2026 07:51:56 -0700
Date: Mon, 14 Sep 2026 16:51:33 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v7 5/5] net/mlx5: accept more unicast MAC addresses
Message-ID: <chpwwjtygmcyoa6nchal3cve67nfwh6cgn3rkmpq5hiq4oiya5@imp3vyggv6dw>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914144234.1540150-5-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 36554fed-1d01-48cf-9268-08df126fc80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: q1DCei1MQegcqOFRq2pQT1T4KfM9Ua37Jef1EU2OqGDkcTIM54o4UmOYj53XGVVhKImfL2ieiWKngp5fZYjK/Sdqx5WozKTiFRlhlGuyskyipUWngWw6b+9JD4RDQTR9xpIx7sxzk8TUbw9WGQT1rXTr39bfB8XjXrQA2k+WJ2mIVF0daZYmTlw7DQL9i3iOIb2E0iBbBmOktmaZem/Jl/7hzcj3gYWecZM9JVGqkLITERVJsalq9fbuEervOnvjvrtEWW2wqmXqNnxTVvZJERP6j1HaqYZk9Og8Np8nqI6QPIx/NxLIxcfUemImikwP2jM97woFKsdsJP98ezrMSEkw1heIS6zsjw5GQyPfoQK3YqSIamMtlDYx1kPMMH/vzuhebU7Frv4rjg+NdQkxuCjbpySOggRvVPvadyjTE2QfhwRbmUMudMqYrY+ladtarGSDO09nUvdor0tJkW3p5C9nxkJIUZg65wriZPXrlrUD/r7PTbZvwhpzoYOsgRcVVDUwSy2njmORNyUjmNq/84rtIv+kWUdkjMPcOJyKtbxl2k9dTSJ8uCkd5hd9meSTuAdNNteAf1HGrKhpodn5UqY/HU5sRi2YrBrYL8MxplySY3gqRB4DWfCjRk4bNHXaYF3S3+PKm7OJjBHjFmtCdkIvPPuj/0DZGzVubOZnSi5SHbSmKsmI8bKEu8KS7kx7
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YQjg6SkyOWfCMUb25QC8AnuTAxWpE9DQcScFqERsYhTMr1NOvc3nw3FmtaG7GF71NS/3ksJbkVGl/pOIe+MGgAEaWKMIYwxXTykOX1yl1fOEqE7YLwMOBgGoaNMJCZjXcpQHbsQhz8Wuq0dShUqvHgxe/15Bo5Jt3mLQKjliL8lgF2mjZ7yJuVxOtx0hedcC+ti6077/uYUKXzViHwWZnwmmxKCaRr7oBoUgzbuEb+WL6hQkkLuHZzBOAsBFOxxyogbJHma3zprnVfVWaWkwZLG9r0sufZf2qEGqbeu6BhMxfcNgj7GphDP2wGGWhcZCfJrLMKH6KYUG32JNp1Z9Ein0Brp5eDcacP3OZTvOFLC2HtCiXJOVnq2ZHis13tMRgcm+AanbcIa2STo3DLwbcQOaw5EY6V6cVnbYunHDZ9RuRrbMwi/WOlXoB55ghcau
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:52:21.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36554fed-1d01-48cf-9268-08df126fc80c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

On Mon, Sep 14, 2026 at 04:42:33PM +0200, David Marchand wrote:
> Starting firmware version 22.49.1014, the number of mac addresses
> per VF is not capped to 128 anymore.
> 
> The value can be increased via devlink:
> $ devlink dev param set pci/0000:3b:00.2 name max_macs value 4096 \
> 	cmode driverinit
> $ devlink dev reload pci/0000:3b:00.2
> 
> On the DPDK side, we must retrieve the maximum number of unicast
> and multicast addresses supported with a query to the firmware.
> 
> Then, dynamically allocate the mac addresses arrays and report the
> limit instead of the previous hardcoded value.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
