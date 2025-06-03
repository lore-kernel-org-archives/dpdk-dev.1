Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B7C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 17:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1822410F2;
	Tue,  3 Jun 2025 19:56:55 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by mails.dpdk.org (Postfix) with ESMTP id DBC4940E0A;
 Tue,  3 Jun 2025 19:56:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNRkm4W4pP4HYn1WQ4Y5Jt3l/uBWoRpCAh5CSv5pIjpw2i63YVi5FLq7psoSfrU+meFPN/dJtD5uAepGRkbHTWK7sEElpwOXO81U1nyU/MKmQdbc3qHCKKdBqZO/L8LhTo9j/t8VNS+83KCFCj6StWXmpW5C88twS4aDOfXEHqIyGwVppIKCrUVVnN9RO0NxXOH3p4+ifzvQkEJXoB9b8ZociWvU3C6vTMLjrgsFUEssoTPTXz19v64ammh3mBtZ6V9AAmVhRO85VGgoDNj2BP06Zag/fSXaQvPuuR5znBU36R599ZJrue72d7zRk+ZDB4Ij9k6jilZDeJ9+zFxMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVbxD6mw20crr+iB2VMA2ylwdbJqCrFymA6CAzaxW3I=;
 b=lp6BEdiWcXmePgKc9EzEFhqhRsFKEFj40jFcWUuvP2evyl3ciCPiBlFO7YcdxkAxWXp5CKQqSrQtkq2GIqsTSJeYgAOFo1bboM8Dz4H0V5X0Rz4tnOcCiNlcw6/9Z8kzvgNZ6YzUvRmT9u9Q/VNx6SSFP+k7oZuHZ79wOQ2GsHfnSnYmQdXb/XL1l8IynE4vLfCxVxgxVvdK5qg7kag4U9FdNIFExoi3jG9iaSG2TJinVgQmtrBgjw7+Uz+AEeYbZhvz8CMlSiyMky8H22xLji0fNmANyHYucebe9sLM/Hd8wK+uAhwOjROQDA4mZ7Rs98aus0JHdFRSOxdhnS5Iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVbxD6mw20crr+iB2VMA2ylwdbJqCrFymA6CAzaxW3I=;
 b=O50CsJ0euN6h2jH8fPRb7YeubudeHPCuBEbp5Dl8pwJB6ZfRnogJWp4rrDOBDRC8SZGllGsV7plD0brsXPAGfq3TlnhsBi5B7jw/Ew5jriUgWpHsdgStDRAqByyBR7lCaD2N6hQOU//ltKJjQYORO1ETGP4Exfty1UXbjEFBw+3oL2cPVSGoL9mkchS2vxFJDP5v8eU4Wg5Y0z0WIrfij2Vq0eUxL/RGcWJbioN89MsAhr8KOOQQvTZkE7amIU9NUuHkZhp08qCH5kit6NL7fsBFFYVxF4xi876K/194vXnlrtuprOHTZyODJlclJ5sVOh5rqiOFb2hEZa2LIQnesg==
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 17:56:51 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Tue,
 3 Jun 2025 17:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:56:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 10:56:32 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 10:56:31 -0700
Date: Tue, 3 Jun 2025 19:56:11 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
Message-ID: <20250603175611.igdc3m74l5x6bheo@ds-vm-debian.local>
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
 <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
 <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dcfbff-3e9e-44ce-b3b6-08dda2c80449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE10R3FGS3IxMzRJVlpQR083blR1MXZyZUtpUFJtYUd1VlJSQ3p1Y2JiR0Ur?=
 =?utf-8?B?SlJDa2k5Ni9XU0Y3TGQ5Y0dDYTNXdEl6T2dIb2R3TzFZK0hxWlNnMGF4cWV0?=
 =?utf-8?B?R2FVdXZFYVdIWllQTEJHMVhsbDVteU1tcEY2SjY0RUtuVjFqY0ZGOGRHWWMx?=
 =?utf-8?B?a1pGOEl4M0dXWFhmNExKaHBuVmdWVzc2NVZZK2kySjJpM21YbUQ0bjkyeFVV?=
 =?utf-8?B?cnN5U3lFek1LUjVsRURhU0I4UWd5N0NnNzZVSUU5U2Fxemt6KzcvMjVXR3ZZ?=
 =?utf-8?B?QWJkT3hZVXZWLzFTMHd0UjJaN3hSd0Jod3lpUEZNem1wL2E3bUFIdjYzcFlY?=
 =?utf-8?B?UWdxdk5mNmxCcHk5ZjZRZkM5TEtNSzRCK29XWnJIUXpZUGFBTlEvWGc2c0Q1?=
 =?utf-8?B?OHQzSGJWdVFJQ2RFbmh0T2Y4NVFEQnE0U3cweHNjNjh4bTNoeUs3anRnaDFB?=
 =?utf-8?B?Y0F4Z1BZUXJIMjA3SUxvbWhPeDNqNzB5U1ZmTjJVaG12WnQ5QVJ3c1FobzRv?=
 =?utf-8?B?Zmppc2VMdjFlaXJGZGpLYm5VQzVJZ2daSkRza0pJT3hMamZPMFJxdFpVam1h?=
 =?utf-8?B?VUsrN0hmeVFQczNZQ2M2ZVh5dnpKcWVsVUFyUXp5UG5Hay9pMHF0R2hqYzZk?=
 =?utf-8?B?RXVNMWdIeEJmUmZ5S2hQSmV6bW5idEJjRnBURlFKWnRqQUJzK0VJSXYzZDZN?=
 =?utf-8?B?TzZBT2VUZ1ZqakN0RzNqUWk0TlJLUmtoaERiUEdhRGpIbkVka2dGZTFCS3RQ?=
 =?utf-8?B?R0NZTUhkRXc2bVA2TDQ5dldpWmJaeGxYUTdscXJ1Sm1QYXdSS2JKeTJEWHdF?=
 =?utf-8?B?Sm8rNDZyWWR2bk9TaDV2Vk9jRUZ5ZWtNeHhlYXVTQytKS1dZVlNaaEZybnlv?=
 =?utf-8?B?WnRiMmNGZDBKcVhmcDN2cm5DTDU5RTY5eVpiSGZSZEZ6d0FyUFUzMFFuTFNI?=
 =?utf-8?B?RDhmeDNqVlVQK0FTODVIZlhKQ3Z4NDdXTXh5WmRUT013YmdUTEZWWmQ1VEJT?=
 =?utf-8?B?NHZ6cDZZWW9QY2c3WnppQmhaeWJ1a3Y1bmhac3lGSm10UDNtWm9tQ21IS21W?=
 =?utf-8?B?ZXoxRG9UOGdleVZNR0FrWjZ5anZKSDVlRFMvWUQ2MVo2eU9uQk5CdFhlZnQr?=
 =?utf-8?B?T2pqeHdhUjFkczNoK1ZRTnptN1BFQktNUVBOSlhWWkhtU2JyREJkV1hrWGZl?=
 =?utf-8?B?WlY0cVBITHpWR0JLTHE4dCtLWjlxejc0ODM1MjdMTWlJTzlROGVQTGUxN2Zw?=
 =?utf-8?B?Sm5kUjM0cmpMWHJqV2JEM05leFY1RElEaHRPSHhZbThuRXk1MUdjaTFxZkFF?=
 =?utf-8?B?RlpXSHpNdmEvZ0FldzJ0MGNKcEIvZEcrbFNobWxrN3NSL0EwM05zOEdJeDcz?=
 =?utf-8?B?ZG1LcWJhVlpJeGFkNXlGbU9uWWc3eXdjeWY0SmFSMnFidkdZbjNiMS9PaG5i?=
 =?utf-8?B?ekFINlVaR2RmVlFEY1MzWnRkTUhXdXpKbGh2NzR5cjlKeXdCeDg0MU9XTlFV?=
 =?utf-8?B?T0lJVDhlNjdlcm9OUjYxMjV1VnovMW1xVmM1R3JFOXJMV3F0ejgvMGtXZ1BY?=
 =?utf-8?B?MTJ2WGRSd3Uyb3lmcW9lcHdxbG43RnJEVm5yU1NYOWVadVYrQVgvNEltaHRx?=
 =?utf-8?B?akZJUjJvYXpuOUxhaS9HNnRpWTdWeCtWK2Exb3JaWDlhWDhvMXdBOTIyRkFr?=
 =?utf-8?B?Z0Vxa05nV2Y1UWFlbWFqOHNjTVZiKzl6LzNsWFdXVFRKVUhmYURBWkIzNVVE?=
 =?utf-8?B?dXJVMExFQlNLRzRiSTRVM3VocVM2NG5IRlE4d3JvNzNzRVNUNzIvd2VqN2x2?=
 =?utf-8?B?bmQ3Z3NGbDJ0YTZ3K0xJVUFqc1V2S0JEdUMyWFFwL0VCQWVHVHB3UU42eEcr?=
 =?utf-8?B?UnZUVWkzNlM0Z2xhV1NqZFA4cFB3Y05EbXZrTTdEU0psVFMrWmlDK2FTVEpW?=
 =?utf-8?B?OVJhbkIzU245VitYRE4xNFZ0Z0FUcWROYWY4cXJ2N1FJbFloN294ZVVGWDN6?=
 =?utf-8?B?bkNYeTB1SXZDbDdORVYybkgwQzdLeGh6a2hKUVhYWTZiL3AxdUVhNHBabS9p?=
 =?utf-8?Q?s/bf34?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:56:50.3966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dcfbff-3e9e-44ce-b3b6-08dda2c80449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

On Tue, Jun 03, 2025 at 07:53:45PM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Wed, May 28, 2025 at 02:12:37PM +0200, David Marchand wrote:
> > Hello,
> > 
> > On Wed, May 28, 2025 at 11:36 AM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> > >
> > > This patch checks whether the Kernel MTU has the same value
> > > as the requested one at port configuration time, and skip
> > > setting it if it is the same.
> > >
> > > Doing this, we can avoid the application to require
> > > NET_ADMIN capability, as in v23.11.
> > >
> > > Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >
> > > Hi Dariuz,
> > >
> > > I set priv->mtu as it is done after the mlx5_set_mtu() call,
> > > but I'm not sure it is necessary, as is the existing call to
> > > mlx5_get_mtu() because it seems done in mlx5_dev_spawn().
> 
> Correct, this additional update of priv->mtu is not needed here.
> It can be removed.
> 
> > 
> > It seems there were some back and forth on this priv->mtu topic
> > between Nelio and other devs in the past.
> > 
> > Atm, I don't see the need for keeping such a cached mtu value in priv.
> > There is only one user of the value, and it is for configuration
> > operation that can do a query to the kernel.
> 
> I agree. It's not really needed, especially since the same value is also
> stored in dev->data->mtu, so the kernel query can easily be replaced
> with reading dev->data->mtu.

Correction - "so the use of cached value can easily be replaced with
reading dev->data->mtu".
