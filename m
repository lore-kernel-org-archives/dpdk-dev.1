Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B43C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 07:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 073C64042E;
	Wed,  4 Jun 2025 09:49:57 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by mails.dpdk.org (Postfix) with ESMTP id 217334029D;
 Wed,  4 Jun 2025 09:49:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9ib1fET6dh5xgdy7HRArSaRtCpiw0A1t9AqY4Ihkiv+IdK+jPwwDpI3ATvQS9csehIX1FYDw7sNQLT4Dg61qyNu0Wu+xnuiMmxHy6A9Dv4pSyjF6lZ/i/Abjf/naa2iOIEWPDWq1D5cUnsC+nDXqEkRuNp6n0+poUyd6kJyvwl9MD75sRerpeItlkuERprzmVmypQpIGe4yJtBB6NRc4P8fEuVlbYRpRw7qIkK+rP+dOw8hR9d8xrrGz4GhsN24tozryREQWHylCpmG6uO58o4vLWAgaq7aap9jcdIAZlbnL8rJrGLlsz1dxvtEZhLbceyduBiE5a2oBsbAAMKOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdgIJwIY8kfMemrEoR12pwkgKlxfZMKxg0e5IJ2IMHc=;
 b=N3/O+nvhfRAiHxYaW/5I1S7Obaqf5kbBklu+oR+cI13d02J4BUOA1Wyh/uGlXu1ipWolTpz+7pNGz1yW1dCFPtI4e6wgqZrPxjwt42k4ZCVj7LRSKLakClKHV4DzeOc+Fxl15thjo62SJJ1LsWr0fmDSCuQrneO5zsrLSnhXkT3IlCJUKQKw5OcMn9k9M1n8Zsi0J2oICLgWHvb+0Dyv8vXm7qUfJVtu43O5Jp4IUkdbtBatCDmbIeD+DU0irg20Lz6RoC3wYYssik0NMlab9FSazOKuv129O+/rQ4vaKDaxGACLc15SH/P8OzX1Snb1CBI0xD5EpgTlrGFhkl1PsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdgIJwIY8kfMemrEoR12pwkgKlxfZMKxg0e5IJ2IMHc=;
 b=qdbanIxaMPrC/XqjyNkcYHCpwOFbBDgLPmQwdSj03Xw0f/JsLvqXSRAX5Hc/LC4xMLizLTAQnGSY9AYlyrE6Y3GScM/PkT7y+edrgpRpkaHLTMUHukCy6BgPghAQ8BYx+djr03N1mKw2kQQd0O15uTMWaF9Gi45TJMU2NGkansACITKhmzr267AYOrpn1tEot4Rb7qEekHU3HVPlhZLTbRer9WTzaV6TbytUIxjYX0tZCKIsfaYzO1yH8U1tNCZoqlqrVphj8dqXeuzkZB0YpkLDOyB7jTo/klylvpWcPOavO/C1IehQfZJOXbZOPyoL0sgABXfScjIPaNYllKQoXw==
Received: from SN7PR04CA0227.namprd04.prod.outlook.com (2603:10b6:806:127::22)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 07:49:50 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::39) by SN7PR04CA0227.outlook.office365.com
 (2603:10b6:806:127::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.23 via Frontend Transport; Wed,
 4 Jun 2025 07:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 07:49:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 00:49:34 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 00:49:33 -0700
Date: Wed, 4 Jun 2025 09:49:18 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <stable@dpdk.org>, "David
 Marchand" <david.marchand@redhat.com>
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
Message-ID: <20250604074918.ca6qmcl5js3wowec@ds-vm-debian.local>
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
 <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
 <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
 <20250603175611.igdc3m74l5x6bheo@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603175611.igdc3m74l5x6bheo@ds-vm-debian.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: dc626baa-09f6-4655-8113-08dda33c6272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nno0aG5HOEhpaFE4MHNTRzhUWDhNd2JnV2FtSm9KTUhlNjIwQmRYVnlETnFh?=
 =?utf-8?B?cjJyUjZjN3hvdC9XYUxjWmhmdUJvUldLeWxlUzJscXVGT1VMdjB2SDVCcExG?=
 =?utf-8?B?RHFuamJxNGQ0Q2NEMW43dXNYd3BxZUVWZGc4VGtEQlk0T1NvNWptd0ZhZHBQ?=
 =?utf-8?B?S3RxMHE1RmZsUEZGU1lNMHNjdC9vdWxEaEQ0WnBHREppdGU3TktoUUVlZkw3?=
 =?utf-8?B?VUtkK0UyT1NObTgwZU5yU3UvVmJxblRjZ0IzNFJYRldsbWJjb1N5dGp2UFBj?=
 =?utf-8?B?d2NUeSsrckRWVXN2andHS0theUh4TEhSSklKd2lJK0Z3a00wejlpM05hOHJY?=
 =?utf-8?B?SEdYQkZUTmNURVdxNjQzOFJQbmNjV1JyK3lhNUhxV0prUmhmYkJSU0k0TTZH?=
 =?utf-8?B?VmR5RkNqQkRSdU9lRFdBM3RQZHl1WjdtZXZGM1RNbUM3ZU9SdU1aZmJTL1M3?=
 =?utf-8?B?cGxIOGdQN2xIcW83LytEYm13TnhNc2Z1UmZ1RFlQSU1kdEF4ZjdNdEVvV0Rl?=
 =?utf-8?B?Snp0T2toN3VsNXhZbzVFUW1ObjZCNEtqYzFsVVFyaEFSTTlwVWRpczlGaWdo?=
 =?utf-8?B?REZSZ28vSll3RlpHWlp1THNydGZTNit4SlVQd2hrTjlVVWp4T1RTSTN2OU92?=
 =?utf-8?B?cG8zODFzaktwVnBZUFpsZTFCSUtkZWFEa280UDRNdjlUeUhtSHFibGZDZ3R3?=
 =?utf-8?B?c2lrY3ZqTGhuaFczZHNJdUUwdENOV05xTVdGWm0xWWNnZ3lOZ1ozRUNWVmV5?=
 =?utf-8?B?VU1ZaFk5RDJQQjVaWTdNOFJlSTEvUUpPWFZoUEZuTnZqdTFWWjNCVXNZNlFR?=
 =?utf-8?B?MXlEQms0L0wvOE9UTEM5NE1FUDRmNGVTRUhLb2dyb29sUitBTDVPUHpEZXhl?=
 =?utf-8?B?N0NxaG5Qd2UxazVpbUo0V2pUMXJFVytWbXR6SVkydDZkbzU0eTFKZXIxVU50?=
 =?utf-8?B?MzAvY21RR2FvUG1uTGl6N2J5L093SUswWmFGVm85aDU5K1hSRkhvZ015b2tk?=
 =?utf-8?B?dzRiT0s2ZndIb2N5NXhDVmpHUm1zV0t4RVRxR2ozbkhlZDRubE9DWVgvd0pn?=
 =?utf-8?B?d1VDY0dtelJla1JJQ09ybmRtUzBKZ1dmMmFadi9jQnlOZG5ac0RORXVaOGZl?=
 =?utf-8?B?UVN0OE5EQ1FnaWl5S1JvSWppYTRhdmRoVnJCUE0rcmd5N0M0VGZNQnFyVXMw?=
 =?utf-8?B?Z010VUV4dkFhL2w5NFpOU3VLSjJPTHp5VTJ1ZGNRUXNhdlFGU1ZDVGxRNUhQ?=
 =?utf-8?B?c1cyMlpRcVpZbUdlSE9QeU1EN3ZZcnJGeUdsc2lMeHVuYUFTZENqSE9jamFs?=
 =?utf-8?B?M3Y2WllIa0hPM05Ua0xLS0V6OWhuenpFMU1uamh2aHVud0h2UFRxOFRHdHdr?=
 =?utf-8?B?UW01TTYzQk0vNitrMTRQdlo0SmtkV0NMczFmbmp0dWhRQ3FBMVpDOEtidDNq?=
 =?utf-8?B?MDVSQjJ5Ykk4OGFoTlBueGJTeXl3S1lzRUx6RFZaa1NBWlBWeTg2TzhHSDA2?=
 =?utf-8?B?WnJYRWRRSDlnWVV0YU95VkVlQVNBeUJaQnVuT3pscnBlczZLbUZOUm9NeXRI?=
 =?utf-8?B?cnZWeGR0NWc0VjU2V0VyQkN1ZmRZOU12WEFUY2ZOaXRzcWtra3hGRWN0NnF3?=
 =?utf-8?B?RnM1eUt1QTdlMnRub3VNMlNrdVpVVTF1L2lDMVAzWGc2a0FDZUpZWGtNWVpm?=
 =?utf-8?B?VGFYek5SRi8yZkxjTisxTitrSTdPZHA1dTFyeEtLK1NySWdnQkNuelp0SEtZ?=
 =?utf-8?B?YjQyTnFud2N3MkZHNjBXUTJ1Nm9MMXFaQk95cUhVUHFlZlAyZHhNWGEvZUhC?=
 =?utf-8?B?djNqZjNpcmR5SjErdE41RXdjZjlzN3BnUlk3UmdJOW5NYXNJeUdkRUgrcFdW?=
 =?utf-8?B?TTNwbTVTa3ZYMzBlYjNoRUVCTTNBZmdFUTYzQk9uOXhEWm5UZllGcXZNMUxm?=
 =?utf-8?B?THRnUjFaNTVhM2JveEdQQk9LMU1qNVN6VXNhQnFoRDBWVmV6QmhiKy83WUFE?=
 =?utf-8?B?UEdBMGtvK0FpTWI5MnM3dTU4SGpocEJpZWloY3JyWGxwVHRBblFHTmQ5c1ZD?=
 =?utf-8?Q?85vWT4?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:49:49.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc626baa-09f6-4655-8113-08dda33c6272
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
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

Hi Maxime,

On Tue, Jun 03, 2025 at 07:56:11PM +0200, Dariusz Sosnowski wrote:
> On Tue, Jun 03, 2025 at 07:53:45PM +0200, Dariusz Sosnowski wrote:
> > Hi,
> > 
> > On Wed, May 28, 2025 at 02:12:37PM +0200, David Marchand wrote:
> > > Hello,
> > > 
> > > On Wed, May 28, 2025 at 11:36 AM Maxime Coquelin
> > > <maxime.coquelin@redhat.com> wrote:
> > > >
> > > > This patch checks whether the Kernel MTU has the same value
> > > > as the requested one at port configuration time, and skip
> > > > setting it if it is the same.
> > > >
> > > > Doing this, we can avoid the application to require
> > > > NET_ADMIN capability, as in v23.11.
> > > >
> > > > Fixes: 10859ecf09c4 ("net/mlx5: fix MTU configuration")
> > > > Cc: stable@dpdk.org
> > > >
> > > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > ---
> > > >
> > > > Hi Dariuz,
> > > >
> > > > I set priv->mtu as it is done after the mlx5_set_mtu() call,
> > > > but I'm not sure it is necessary, as is the existing call to
> > > > mlx5_get_mtu() because it seems done in mlx5_dev_spawn().
> > 
> > Correct, this additional update of priv->mtu is not needed here.
> > It can be removed.

As a matter of fact, the setting of priv->mtu can stay as is in the
patch and the current version of the patch can be applied in my opinion.
The "future" patch which removes mtu field from mlx5_priv
would take care of that.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

> > 
> > > 
> > > It seems there were some back and forth on this priv->mtu topic
> > > between Nelio and other devs in the past.
> > > 
> > > Atm, I don't see the need for keeping such a cached mtu value in priv.
> > > There is only one user of the value, and it is for configuration
> > > operation that can do a query to the kernel.
> > 
> > I agree. It's not really needed, especially since the same value is also
> > stored in dev->data->mtu, so the kernel query can easily be replaced
> > with reading dev->data->mtu.
> 
> Correction - "so the use of cached value can easily be replaced with
> reading dev->data->mtu".

Best regards,
Dariusz Sosnowski
