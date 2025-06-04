Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873CDC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 14:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99A9042E4B;
	Wed,  4 Jun 2025 16:59:49 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by mails.dpdk.org (Postfix) with ESMTP id 2F8D6402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 16:59:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buPs7Bju6OuzbT0AaWKgGPvVfhtkr+N8P5SFWPZhyBqakH1cs2ekxkUc8ZIMYsFnn1+F8QxleLFgmsqgEbdRb8uwVbNVIIMtXcxsD5cQb0eB7AqLsCl8HRqEY0ojYXzLPpaq0i5W4AXPNMFk21kxgRYm/X4eaGT/jtXWSxHcN9DBz8FVCaCk6WwGKnIr4EG+cFcMWgsOGU7JO7nbE0enanCUllX1ESV25GxxvDHTFn1Qr/rX3b3oPWHrefY9xmjgJaNL+DGiqp+amEh57B0A0yJ6C9bzaucEo48jfvSiFDzLgcRSMMz9vWk2s4jtN4O4H1fV/LGQdMVvtzPI47xjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYfgvTclYoJHqKAkZFzUhdHdCywZOA6/idQ/qnZvBls=;
 b=bxMoMlHWmG3e8y++CDv/8PvpyaWAXvY8FzAcRV2lvIeRahiIn+NTGuZY0Dfk3138IlmN0tAoSnvOUyQ5dgJ6onu2u1euduzjd3WA7DWYadzusz2fy7VOLdaLKdS+FQED+maC5RAraL6iVfx2wMsqdaZCnoT80RLXU1tgfs3ayr3TmTUHPW95jAfZmGDh8KxsSnxme04OPS4kjvP4KRqb6qpMETmbXpL6krP+HHJhArpDNZZIGTV6rcvEMJAx/XaDLfy7e1UBtkEXfkkVdapfN/wkznVykvlBsPBvYs+gMiB53v6UdshTZfioPh+8X0o+SKCju2M8P6GAX0koccABVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYfgvTclYoJHqKAkZFzUhdHdCywZOA6/idQ/qnZvBls=;
 b=aXLNIKQ0JOAKTvFOyG3ABPffG6zBpgPrA/+EpiK2UQ5eAQlCCjraR9GQlPdJ7Q5o4Myi46lvyQTTi2ZcR1XXfZjoGnDunt05PbkteiUp+KSeUVk2/Be/JPjPsphQ9wifvWppbmXD7fHWvlGaQdKisNuJ325FJ+VDGSQx7uTrE2nuJKGjuNTVScgVruSIlBBBAPr5VkiNib5gIrdtWWXvTZV98C2F5HkVt3OoJ6bFiUFfFKBqFWS+a497lh9GfIEEk3q8yfvPEWqcTIr/U51TRXxkb97yJs9PxkXVAVy4vDM/QPIuDXedsYKEQNqv1TOPXlNCiZXid7a7+grcQlayWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 14:59:42 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:59:41 +0000
Message-ID: <49c35db2-7406-46c0-90b6-938c3482c034@nvidia.com>
Date: Wed, 4 Jun 2025 17:59:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: optimize counters ID greneration logic
To: Alexander Kozyrev <akozyrev@nvidia.com>, dev@dpdk.org
Cc: viacheslavo@nvidia.com, dsosnowski@nvidia.com, bingz@nvidia.com,
 suanmingm@nvidia.com
References: <20250425155515.2635090-1-akozyrev@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250425155515.2635090-1-akozyrev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: daa1373d-4bdc-472b-a096-08dda3786f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVo0TThMcGtBTjZwZUdpL3BVblBJNkpkemQxVHZXNHVZNVFBNjlTbmZ3TnV1?=
 =?utf-8?B?YUh6eEdQUEpwc0xueUxsdHcvQUNCcFgzSVlWTkFhMDJRdk16VUtnc1BKWitr?=
 =?utf-8?B?TFdZQ0VOVkljYmcvOU9tV3JKelpkWFdWQ2tWcmUyYWZmeTBwS2hJMkZuMWxW?=
 =?utf-8?B?QzJoaUlZZXdkVFpWQllhckRlN3N6Z09oUTdHZ1YyWkhRTkNFcVBQTkw3b2pC?=
 =?utf-8?B?a05wU3pMVGRZOTdMUDgrOHFwcEQzYUNvSFlqZTM3VVU3Y2crdFlteWRmMHE0?=
 =?utf-8?B?R0ZOTE9yM1NnNjVXaFVqRlFBdGg0OTFIZGNnaE5NZzB2SHZEZFlVWWdxa0Jv?=
 =?utf-8?B?V0QrNW9qdEpibnNsSENLeXY4OGR0MGwrZEhieXJYTVdvNGtWRFkxcjlFR2oy?=
 =?utf-8?B?TEhOeG83Vy9UQ0xIQWRGNGE2cm9nVGgrUFFLSVFjazVlQjZ3SmYxMVFmdGFp?=
 =?utf-8?B?anRvWEgwTDFSVlVscGFTQlBqYXY5d3daZGVQMDlKS3BSV2tCTkpDMGcwajd2?=
 =?utf-8?B?Uzl5VXNJNzl2RTB0QVdRUG40SGdidVkyekcrT3VSby80cFdqQVVtUnBOSjQz?=
 =?utf-8?B?MDlFYUY2VHFDellYR01FU29RcndsVWxwUExiK2Nsekl2UnlEVGVzVHp6L3ZN?=
 =?utf-8?B?K29lOVhUeWhLZVNXcUN1K2prdW5YdmZTeDJBc3dIajV4eVJKcHE3YjM4WENh?=
 =?utf-8?B?WTBudkF1OGF0amNnNmVMcnhKckhPeVVuZXB1S2xSdHBiU0dUMHdRMVBBazlp?=
 =?utf-8?B?WDdoamU3YlFNbXVDNWJ2SWxITjZhUmd5TEsxV1pSTDNkaEpYcEY4Nm9QVURN?=
 =?utf-8?B?WHZ4ZTBZT3V3bWF2TmFmUFh5a2NtRGZCWk9VRVFLSi9yVVNuUVRicklpNVN3?=
 =?utf-8?B?VkF2QWFGMTkyVEZHcGp2dFcyanBVTnFiN3BSMDZKd1d3WTFSTytmQmV6QjZo?=
 =?utf-8?B?c0M0TVk2L3VQbWwrVERhTU9kdjhNYlZBU3ZYc2hkSGZPVWxjekRJaGpBVHJz?=
 =?utf-8?B?cGs3ODgzYzgxNGk3cVJpNWFJTTdPai9JY3I5clVlZ0Z3Q2o2VmV3cThSZ2g3?=
 =?utf-8?B?RHR0Tk1sd2IrRTYrUWZpbWZ0b3U4aW10YU5BR21ZTWdFcTFxcGdnbDFESXkw?=
 =?utf-8?B?ZjJBYWtuVDg0UDgwTVJVRThMcmovcStkOTBGeEx0SG1yTkFXa3JDbUpLYitH?=
 =?utf-8?B?UnFJMWZZMEpHU3IxOWoxVVRYaUZSQTJHdXNDWnFsLzArSW1DNmREZFhoeXQx?=
 =?utf-8?B?cUZFNUViclVJYXdIcFpJMGFqTjJQMk42enZ4VzJEWEhmWUR1ZXczcTYrNTlK?=
 =?utf-8?B?TUNsbG03UjB5QlZuc0ZDZ01HTDFoTGtkU2xIUExaUk02Nk1ZS3UxYzlVbzlK?=
 =?utf-8?B?SzhyZG9tWk9QMVMwaENzOTYvanJPejZERDJCM0dQTXE0c2laRUF1VXhwSWpJ?=
 =?utf-8?B?WHAxd243ZjR3Y3pnQXk1NlFIUVlvKzk4STRwMFowWWlkK05xUVBRSHlyeGFS?=
 =?utf-8?B?MTlkNWgvRElwcG12byttaWhHbDlFUk12REdWUjVrSE05S1hXckJlbU5Cekt1?=
 =?utf-8?B?b1pxM0U5VE40eVJkeDd3TXJWRzlHekhrTXBLcGZKZmREMDNtTFBhVkxIcFk5?=
 =?utf-8?B?R3diQW9kL2dWOE9mUXBIdE1YU28zU2ZuWXBWa2VodkFrZHBmM3J4QmpJczJH?=
 =?utf-8?B?MTU4ZzN4c1pXRVkwMzQ0cDg4SURzMzZ0SVBPOGoyNVVaTlYrQ0gvOWJZOWds?=
 =?utf-8?B?ZUt2b1phYVN2NzZ5VHVubXdXYW9menhRbXo4ZlhGUzU1SFE2dTc3Q0J0ZlVT?=
 =?utf-8?B?Q0hsRGJKZ1R3R3d5Q2hYc3JCUGhVNEs1TVVtcjU4TjRyQUZIbWNKNGpBVjVh?=
 =?utf-8?B?ejE2cC9JeTFSOFdtTVBPVkNkTE84ZzJiVjQvVEdGdG9KSXdWcXpiLy93dnl5?=
 =?utf-8?Q?QjkPEvychls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVxM1BmVzBLL2VwS3U4VXZCQXlkeGx5U1FMRmdWajZDYzhyTHgyeHExaUJq?=
 =?utf-8?B?WUVhbm1GRFg5VE9pWWZIa0JrREhFNGo1TEIrVFFXT1hyRkNZQmJUTkRabkFW?=
 =?utf-8?B?em91S2UxbFg0VGI0VWYvdzFnTTIzY0xNemg5bHo3am96WEZ3QmJtbjU2cjZD?=
 =?utf-8?B?WDFpcFNyR05RbUVBSDd0YkIrQlM4emNRYnMyY3h6RXZMc0Q2RVpPb1ZmZWdi?=
 =?utf-8?B?a3pWakt6VXhuQXJ0Qjc1bzZwK2d3NENFczJDbmFtRFRNKzFSOHJmSmlnLyt4?=
 =?utf-8?B?aEttZkh6M1c2TjBnVEp5N2dKU0NKQXVLRmFzTWM3SGkzNkJsbFNWb0xOUUNN?=
 =?utf-8?B?QVNJTEUyVUp2LzBLdm4xSzBOWkhjbUlsMVhYNlU4bUhqT3BZRjcydk1PV05j?=
 =?utf-8?B?anNrbGZ5ZWVJeG9EZi9uOCtPc1E0ZG1vd2YvM1FCSlUySUNueEY1RW1rVVVJ?=
 =?utf-8?B?ZEJ4MEJVT1Fmb0dsNkZpc3dBMGQ1TTM2eStXQ3hmL1padEVGOUsxdlNDS3Z2?=
 =?utf-8?B?WmFxcFpoK3ZmcWlUNis2b0dzY1Eyb0pObTVvNzh5MUh6TVBQRWFYWHAxNU9o?=
 =?utf-8?B?RGk3SVBLS00xa0RtazZielFFSzVMdmowaDZzRnF6Y0FCcjlWRFprTGdSU1Nt?=
 =?utf-8?B?dVhPT1BlN1NhbGRGWmorUC9halRnZHVCYXhiZG5kS3V3eWcvVVhVNURUWExB?=
 =?utf-8?B?MFdtTXZxZHVjYUdQMXk0TjBUT2tRSjZLbzB1UVJnMUw4Z21aY0pxNk5BRFBX?=
 =?utf-8?B?VDAvRGpaQ09MVWV5bzk3RVhyVG9ONENyQVFzeHFRNWViRmFyNStiT2JmeXR0?=
 =?utf-8?B?TW15L2Mvd05PVVYrT1FuVG85cUdRaVF5THl3dm1BejJPc05jZkc3MWFVRCs5?=
 =?utf-8?B?a1lja2hpR3l6Y3JrY2lQL3drYnA1RE4yeHpqQ0p0T01yME52c212OFY1Wnd6?=
 =?utf-8?B?QWNqaFY0dVhSNlBrSWIxSVdjSkV5VU1hblJMM3VXL0t3R0dnYmJrNFFzdEpV?=
 =?utf-8?B?cVJmUzZ5K0RmUVdOYkV2citML1dtRXBqREFhQnNwUENJaDg2dWJBK0c5WEtM?=
 =?utf-8?B?MGZjcDE0eDdwV2hlZ1FXTHN2UU5NWk5OSCtid2RnQVpjT0E5b282bnBoVzdv?=
 =?utf-8?B?ODZPSFdRT0dYOVNXQTU4UXczYjMrd2hnRGRtK1BvYTdVeXJDd0h2cXhnOFZD?=
 =?utf-8?B?L0tMQUIrOHpxN1BjQSt4T3AyekloQWVBU21ydzg1c1UwaEhrOEdzYlRjWEsv?=
 =?utf-8?B?R2ZwOUpDRFNSdXdtQUROZWNSVGFITElpM21zSTNIbEtaRVFMVm4ySW9lOGVV?=
 =?utf-8?B?em1aY3o2Z2p0bkZDUlNLS2kzY2VCbkxUMFFoQndvaERyVDZpQ0g0eVg2OFhW?=
 =?utf-8?B?OEZlZU42M1pwOVV3bysrRmZ1VnZYZENKZWxJYXllVkZEWEsyUjdvZHdibnMy?=
 =?utf-8?B?N2pFZzBrUVlDMjY4QmdvdGNmdzRBS0J3a1laS1RIYUFWV3UzTVRwZEt5SS9N?=
 =?utf-8?B?b1p3bVk3UXdqblkwSzZVNDI3d004RWJCUUkzaDlEYUtCeWx2aHkyaFpJNC9U?=
 =?utf-8?B?a0MzOSt0dUZxdCtZc3NPTWsyMG11bFFnbklKT004N2h0S0xQNDdqWXF1Z2Y3?=
 =?utf-8?B?am85WVdUK01mcDZsWTJOeSthakJyWm1tZE8vNG0yRW5qVCs3enFDZXcySEdm?=
 =?utf-8?B?bXlMNVhFbzhYeU5PNDVNd09wQnczZ2pVQisyVUF6RWN6VDFiaTc4MUNZNEZK?=
 =?utf-8?B?NDFwWlk3TWdHc0cxcndqbWFhWDBqYjFkY0szZTVMalJmK0kycU14a0hrMmJF?=
 =?utf-8?B?QUZiRUNJdjhmbGg4KzhPeWlEcUI5R2N4WFNyT3VYYnVNMCs5cFNjSGtPYWg0?=
 =?utf-8?B?aXJCejg4UUZadWIyZ1BkZjZIUWVmK2JIZDV4YUpSWVdSUUJERTF4dGZqQ1Ax?=
 =?utf-8?B?MWk5Q09qQmNXOUk5WkduU1VNSGhWSVpYQ1BZNDdxWE5hWFhSSjVYU0FjVVc1?=
 =?utf-8?B?aGcrOGVQL1pSclhId1I2eGViL3RDRFJsb21IR0dKMG1sZUZjaXJhb0dQNDBT?=
 =?utf-8?B?eC9TWTd4VDl0R2VRdk1PUVFZRDVjMTcyRnY3Q2xqS3Y1dFhYdGo5QVFFME5T?=
 =?utf-8?Q?Hor8Mk2Al1GwQxyCi96X0zbXz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa1373d-4bdc-472b-a096-08dda3786f52
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:59:41.8933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6E4kRHIC/bkMFsdkCR0mZ4KDKUIKCbkCO1sW50ejVk+3Lz38ZSkF7/R+kOKHmrD5BdktWsF9lUAxkU4aryRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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


On 25/04/2025 6:55 PM, Alexander Kozyrev wrote:
> Enqueue generated counter IDs on a ring in bulk.
> Generate them and store in an array before putting them
> on a ring all at once. That bring better cache access
> and speeds up the mlx5_hws_cnt_pool_create() function.
> 
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

