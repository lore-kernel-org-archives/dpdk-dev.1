Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293EC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 17:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47E1D40E0A;
	Tue,  3 Jun 2025 19:54:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by mails.dpdk.org (Postfix) with ESMTP id D739740DCB;
 Tue,  3 Jun 2025 19:54:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjbt/ZZNyvBVe48EPSaOr5Z16CT2hbDIGkDGm5RzclQbcLgzEW2fNoZ115J9KKOXv75Z6DVE2Gw5oj4RDrqURY+EKdsbRvQ+fSethR+wEmEU7+gIP5hy9ofrNQ7QwM7uHszSm+2r/bULaCJCSr7qbojvFFXG5AF7HsUB+Fe9vqADLO5M6gFSGnplaP8NTNVSF0NF5rvUdBsMU/XBdO0ftI910LFIPDR4on+vw1X3RKsooE5W9SFEzCGpm6U+v8P9amx4GaOZOgvOF0IAUYUcfqsnS0Nb7iBi1v53z0flwMTshKmKRuwWlNdb0lcjRtUji0njNTy1VoyBhJId3KJyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGjMDkhhChatWZpB7ZS11vKE5SbL4Kt6ioAQu1oK6yI=;
 b=hc2e1bbJpNMfCfH9xcFIUO3Mq6wCZ+XJEZasdsFJmnTfKBgdTfL83D2vHJGBwpWwE9AlTxweTgGBtyZigDTbNRgw/dDD7WwsMDXt6alHYLnxYXbGeSNqZwKBQJecst9Q6kllt8pDMdjEKvknOiXmpTkYLaFWw4wTD6gQJGy/4CuirlbF+OIzny7bmZ04A2DM31dRQn2F8IVWRCpV+ZjLb0A/JUbVcMtIOQUj2FLl/GXjew/gUhqXsqubTAYr1ulYaRmP7gkWZ2ZwX0+vuf0ljjpuIX7mJFHPn2xMMfOf48JIXZU/lbAxEGjKzlRamUhFmH5sWdY1XNLuReLNk4OpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGjMDkhhChatWZpB7ZS11vKE5SbL4Kt6ioAQu1oK6yI=;
 b=qxIKwym5IU1F4v3NksMTCL4FhFUUkFLnnsvWPAwGu/vmhKP/DGf9qpr957hUueMAvRtDbCrLs0eXsEfFxgEiJ79JXlu60BhAkIpWvqonPwJyOWxtO/ogzvkcoyPVF4FIzh5+nRPmiZx8HdKw5DCFev6FKL6nUpIcoKq+sidkPxMUOPTkYGAueFWyhMg+h46XTSd1/ZCetuPFDoR84J7E6qLdYALTnvP57/sfeukcuELVciN61a81jM3OSnhl098Za4tqZ7Se1ETroMz14fk4ZMB3DJ79xrojQUHTClZBF4UnZ5282zFsgeSqS2HcDjncFCvp2AYMf7JfHesT7/GwsQ==
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 17:54:35 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::bb) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Tue,
 3 Jun 2025 17:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:54:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 10:54:11 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 10:54:10 -0700
Date: Tue, 3 Jun 2025 19:53:45 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
Message-ID: <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
 <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a12bf8-ee98-4dd2-149e-08dda2c7b39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVBuY205cUZpUlhzT2wwS2FmR3drNmVVVVQwUnBPaU9iUHJNSlpEWWp2V09P?=
 =?utf-8?B?UHhKOEFXbG1BM2xlRWZxZWkvZlZ2RW4yRFdZSVpSNVVhUzVDYTY0VzRDOGRt?=
 =?utf-8?B?YVhrblZZREIxTDVSM3BYN2w4SkFOR2RqNHFZYUIwR1NXSC9wdHhDVExnRTRn?=
 =?utf-8?B?WXlPL1hKMGtzSUxsd3JpSm0xcm9DRnpOUlA0RlB4dkd3YXQ3TDNWVkdBY0dp?=
 =?utf-8?B?NTdjOXUrSGxQYW1iOXNsdE02NERjbWs4UjlYL3l5NkdpRDczOW9rSy9pbDhi?=
 =?utf-8?B?SGNXUjkyY2NVTDFESzBBWEIrUWVKWmg0NGRWOW95aVhXOUx2N3UrT2oyektD?=
 =?utf-8?B?RVZVOUhxbGU1dTQ1REF5c0lnU1BiMmo3S21LYjRKTW5XWnpENysxQXE5ODJE?=
 =?utf-8?B?d2U3OFlQNzJpM0d3M2hUcXVHZVFjUk9PMllkUGpiQkEzdmcwRjdvYnN4Wm9L?=
 =?utf-8?B?OEVCS1BNTHJnbzUvYldoa252NHRqOE8zVGI2WkVyY2h5c3ZjbEZJR3Z2eXpE?=
 =?utf-8?B?citIWGVDM0g0ejYzVExyNWdHYUNFb0lkVjNWTzFqNVVRMENDYWdvdU9DYVJ1?=
 =?utf-8?B?ei83ODltcU9samNGSWhMZmFvZ09jQzhlSGllN0JCTXBBM04xZUtMNHhleUFQ?=
 =?utf-8?B?NG9rMSs5RGJXZXVxb05RdjduODI3MUFlcjY5T3dhS21lektQdmpNc2hpSE54?=
 =?utf-8?B?U0VVYitxNG5abXNoMXpJQ25obGF5QStYa2FDKzRJaXZtOFFnUlNFdmIxTFJn?=
 =?utf-8?B?Vm5BM3E0LzBTZXdGOXQwNEk2OHN5cDhlNmxyd2dmSytDem9na0VwZ2tMbm9t?=
 =?utf-8?B?dlV2R1VodWUxblN4VUNWZ2djWHJlbWowOUVndjNtcitVOU1acG45OFNHUTFa?=
 =?utf-8?B?VXdaYm9pMDcxWVdpQnlmdzRpZzNlR0NtL1VLNGx5Wi9Dc3dkVWdZTGVkbGts?=
 =?utf-8?B?dE9xL0laalZuTWNEbFlXRmtzcnUvV0VINXNiU0ZQckU0S29PZGk3eEM1OGpv?=
 =?utf-8?B?R2xBazlGZDVWdWtnMU1vRjZpandUVFFJQTdGVzdlQVNOQWRXTUozdUVaWjhv?=
 =?utf-8?B?clk4L2d2b1dvZTZ2SlpodlVBT0kwQ3d4Q2c4MlNBbVBKMmNEUFlzRndYa1Fu?=
 =?utf-8?B?akQyaGQ2RWVnRFM4L3BJcmNVWm9KSHgxQVllQ3g0UGVINTZvQ0s3WFdmZm5z?=
 =?utf-8?B?eTFDeTB4WDdOYlFYWk82bjRQYTA4T1N0bkZjeGd1NlNNcmlYSTV2WE1OYUtk?=
 =?utf-8?B?YXVPTWhMZ0xSSDNHQmVLVWp2SHRXY0RmTlJZZkRlZnpQdmlYU09TZFNnc1V1?=
 =?utf-8?B?b3d2QlQ5SlhBVUtwaXdyYlFkS1dIYkpQSSsyd2krQlg0V3U0ZVZiMHB6UmZw?=
 =?utf-8?B?b0dQdk1GVkUybGdEWFlNL0hveG5yVExqWjBFTUFDaXBpNjlsQWJmRFdTM0s1?=
 =?utf-8?B?elcwN0FRZlhrVUNMczNnV2RGaEhIRmlZaTJxN1NXejNEN1hMLy9ONFhPRmF2?=
 =?utf-8?B?RU13UnVkWUJuWkFvTjVieDJiUGYrL2FXeGNvMUlnZzluLzBORVdSdEpEWmxT?=
 =?utf-8?B?RGpZbTFqQzJSKzZPZTBTMmtuSi9lTVgySk91WHplU2FWTFEzWVZDU1ArYVpl?=
 =?utf-8?B?RUQvR0ZRMElJY3V1TzVGa3d4ZGk2Yk9sQTJ0TXB4S1loVWNsY2xpSjI2alBS?=
 =?utf-8?B?OGJlOHpaN2dpVlFkdVhZMHUzS3hQc2NHOTZkN2dDSGpYVEpWb1I5dUJwWnpJ?=
 =?utf-8?B?aUZVQmZYZHE5Qm5keWdVbnh2WkRoMWRqM2dpd3VObmx3TUZuN3B0dXJrUW00?=
 =?utf-8?B?QXRUSkRpTlY1V1FzUzFzMXNZRmZHYzd4cnppTTk1SURkZ1hqQ0FrblphZkZX?=
 =?utf-8?B?WGJlV0w5aEw4NzZPa2dmdVBZNEI3NDV3TndOMXQraGRzY1NjanVNZ1BnaHVO?=
 =?utf-8?B?VUh1OW1qUnBRay9YZjMvT0NlTzBCRWR0azBQcUg3T1lERzRPWlM2dktDM0J1?=
 =?utf-8?B?TGZzWWw4NFRrZW85NGdKVXJlYkdpS3JRYXpTeko1YXp5b0tBWi9DS3dteG51?=
 =?utf-8?Q?rgzSNH?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:54:35.1967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a12bf8-ee98-4dd2-149e-08dda2c7b39f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

Hi,

On Wed, May 28, 2025 at 02:12:37PM +0200, David Marchand wrote:
> Hello,
> 
> On Wed, May 28, 2025 at 11:36 AM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> >
> > This patch checks whether the Kernel MTU has the same value
> > as the requested one at port configuration time, and skip
> > setting it if it is the same.
> >
> > Doing this, we can avoid the application to require
> > NET_ADMIN capability, as in v23.11.
> >
> > Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > ---
> >
> > Hi Dariuz,
> >
> > I set priv->mtu as it is done after the mlx5_set_mtu() call,
> > but I'm not sure it is necessary, as is the existing call to
> > mlx5_get_mtu() because it seems done in mlx5_dev_spawn().

Correct, this additional update of priv->mtu is not needed here.
It can be removed.

> 
> It seems there were some back and forth on this priv->mtu topic
> between Nelio and other devs in the past.
> 
> Atm, I don't see the need for keeping such a cached mtu value in priv.
> There is only one user of the value, and it is for configuration
> operation that can do a query to the kernel.

I agree. It's not really needed, especially since the same value is also
stored in dev->data->mtu, so the kernel query can easily be replaced
with reading dev->data->mtu.

I'll prepare a patch later which does that.
Thanks for bringing that up.

For posperity - this cached value is used only during
rte_eth_rx_queue_setup() while validating shared RX queue
configuration.

Best regards,
Dariusz Sosnowski
