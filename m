Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51573CD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:35:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 834E440270;
	Thu,  4 Jun 2026 11:35:04 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by mails.dpdk.org (Postfix) with ESMTP id 6BAC840151;
 Thu,  4 Jun 2026 11:35:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCJyek/i88Cv018uoqGMT8ttL42a/uOFnqGFdwRgFd/pC3CNnVEALeHD6daAbeT4FS3WKvgm8dk1j/lz+SGTrcT/ts8qy7v86vP+OEkNXdBT9CTSne2j0f4+/7KS3W8UY07e04jQ//objEbntxPG6WUIVVzGibYQYEDvNO5l3LS31LLQqRNY0oZC0570+5t4OtaOW+07N6cxw32lHniZ/IH7m7LaVRyjpZX1dUoA2i6EIUL1RafWA5In34v/xQnqo9B3GbIavcU6+NB0uuYNgqpnHDtML/Ozi0UUgnwe9UIfPvU4R38E6dmAcZCGUjytg9S9XAPr+jabFzL1/s4YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX3uvDjYjnyz+uu0WZ6Mcl6YSSUrIVx6LXMsjTv/mOM=;
 b=gfpKtsLS8/EBJgHk536UKrNnMM3Pl2vER4pP1VIM1ffX6pGifJa2vbfUPOnSUZG5pljcvAOzxPAHNS8QwWBa9Q+0IMRjCaqDioF/YJWssvIMJ17k9sVWwjNfjmWC7Mq+YyyJ5HtgJfnr6M/a7ZLJkFP/V0l/IJ2awVFYHZoW6C/s1bjl22E7oPVfmlbg4U39QhDEl7oCoU2T1pl5D4Lr7olBxM+jX6cufPPnFQ9/wgX5xvyk8orOolEGiK2ZtcD4OuuVdLo80zjmFEtZoH4vhQlzT/jeOdbHSZH7yglSXSyb4mrzy/3joVXA/OzNSkl9/PWCzHkXkeo2TL5BEi4hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX3uvDjYjnyz+uu0WZ6Mcl6YSSUrIVx6LXMsjTv/mOM=;
 b=fO/5aZyzxethaYvlZoQ9Xh7nRsDI3ycaP6gTv1ZaA18PlzE6ecrqc5esJ7rL12KffNN5DoZAB/QpjLQG6slOfUvYg/LeUBIVYnZDWj0VXyoFi6F5DLaSefKp53tGWZEQD72nRlLgPyHQG+CrBVvNYTt1/aaQka0NPkLWRIK7CPTa8z5bHEz7abNUBju0RXQhPRNM3Ah6ixgkRWTtSI+Mylqp+sedTZ9IcYjuaNQoq3oKYmc5Oh0IGFEmxJiGTX+cT/HhmZbC8EOJT+RNTa2cWGKrRDp/qwLwtQkmFUZFB8jfediXFsbf1acgRUfcD9u4YeoIEsI9ygesIrowYjPZbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:34:58 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:34:58 +0000
Message-ID: <9e2b472e-21af-436f-a443-ba6297129c4b@nvidia.com>
Date: Thu, 4 Jun 2026 12:34:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: redirect LACP traffic for legacy E-Switch
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260515123700.354341-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260515123700.354341-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a011ab1-0486-420a-00d2-08dec21c8b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: V3wxMoDIeSL2LbkHdFacRLLb8TqA/C6uB2Y0jstA1mP1gVVRZvWaH5VZFbjqdEmHsJnSSTVje8Ha7jK8UHj96Dz78I1SIlJi4LFoMBa2p6F0MhdszIEDEeEh8XdfJu6Co6YSe+h/C/5HTpmIoY+70X247iskNEjxDesr07QD6lnWe5s4FmkLYXSFETKeVkZLbjzcO/97FfWLe+qHGhBUGMLQXDQ42LF9hLvsCrZhSUKh2Bgi59Y1K8p1Rg9jTMBIC3Zo167J7XRG4wBvvKva8rsEVbD14kVq1deAFUN8W6w4aq7fc/Af+zY9/Zrn6wflsYsWlfmJ0e0J2kqfG46X95U0RP/3CxhTHEBYxCl86fSunmW4tL2uJty0O8LTD/HOgE58rlL1CZJ0aPDDHN4DfNayHPcDc9ueNq55JGlDzJfwQnYbVhiWXgApfMdyNViZFulmn4QZFrLySGq+Zbz/aBiKxdYvjg7OwAp7EC4rYmPYWFesLJjnZHWlXLhoanx3E3CWV91+XCdWI1/HlwuDMp5mtv37T9dnYUozYTVuzkT7nS2EQlLJlqLokf4IMCZc5Zl/jXhXnXINwy9YTdXWRwbtMplAZgwMhUOWozih4KLMk7AjKf1IdEz5zTkZpxr2xPrUbYCc+WhgZkD5M9nhU8MzgDEqGlY/1fyRbJb/iHi+5funmBEYdVnNEcjQ4xYk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VldIMzFxQTBXNVpzQnFSbDgwY3JYNjl3VEJOZHg3UjdGWnJPN1oxcVU4WE1Q?=
 =?utf-8?B?emNpeGp0ck9zVk1IamR2TStkMkVoUEtIcFMzZGs4ck81ZTB6ZW9ZN3J0cENy?=
 =?utf-8?B?c3F4aTdoZml6OWlvZGpDNkp3c2pLRXA1eU1UWVBMY2F5eVdxd25aaWtBSnd1?=
 =?utf-8?B?dUo3emx4NHVmMUxOVTA0N1ZrSmNlZHdueFF3Ri9QV0todVQrOFhrcTd0RFVS?=
 =?utf-8?B?UGlZTnBMS3cxZERKZG00aFdEb1M3cFBVRVNmWm9xVlU4bmVRZ05UdFhVNjdi?=
 =?utf-8?B?ZFhEV1Yrb2pKcktQZXRSd3E0M2VnRzR0SjRTNHhUeXRsa2RFMVArY05aUzdq?=
 =?utf-8?B?ODRYbEc3RU8zWlRkN1hodWlnaW9UUStGK09ka3pERllxQmFrbjRoWDcyZ2h6?=
 =?utf-8?B?NTd3WWF4dldML2xWTDlSVTJ1MnZKZmxsaFBpbEppSDQweDcvc1Z0WTIySHRL?=
 =?utf-8?B?b3pJVUxLS1dORXZHNDdiKzlrZE53cHB0TDhhTElFRW9LbG5ER0o1SXEvbXB6?=
 =?utf-8?B?OVJqa2dwNGdpSC9HM3Y1eWpmb3ZHYVpHQ2lDSGpiTWl5dWNGYjZrWVhmcE9Q?=
 =?utf-8?B?d2VHeTY3QXVvdUx6dGxZNGphNzdzS251WEtTNDZjdEwwOFJGUG9aaDFYOXpt?=
 =?utf-8?B?SjA0UGt5bDA3UGZ0T1RHZFlRejNRUWJRTk50NkdSMDhHKzVod2lmN3hUbUdV?=
 =?utf-8?B?OG1aMXRKR1RkM1FnRlBiYzZmSFdDa3kwejdtL09aRmNXS1pKTEdDNnNaSk9h?=
 =?utf-8?B?YUUyc0hIMmYrT29VKzJhNGJENlNMQmhldkNic3BVUXdEVjVLZUM2WGFkdVJB?=
 =?utf-8?B?RW9JZmE0Y3VLWWN3cjB5Y0JSdXE5dGFYb3ZrVXg4VG5lUUhuQTdBaURMQ1hp?=
 =?utf-8?B?Mk1uMXZhZm4yOEMzYk90KzNVeWVVN0t2Ym1Sd2RCbmdDQkthQk1iWHZWWTZF?=
 =?utf-8?B?U2o1cFpiZGh5VVFvNDdqQjNGQnhyM0N0VVBBckdHQXlNbFdmWldka21wUmRv?=
 =?utf-8?B?Y05wWVZBN1pjemhCL3drNU84VWpvUXIrMWZFeTllTFpjN0NWZUtCMVFUMTQ2?=
 =?utf-8?B?cnYvb3dQaUJpdk1YNDVraDNKR3BBcWJTZjRqUEhMbDVUYmdGeXd1UTNyRk5p?=
 =?utf-8?B?bE5ZZlRIQ0NpVDV6djUvaFhlSTdsVmV5VURMbWorVjUrUHAvNmt3Z0JkaExz?=
 =?utf-8?B?ek1NbDVQV0trSUVjenRjNjUwMWxIL1RBVnpES0lSVzF4Q3g4NHpLem0rRWhR?=
 =?utf-8?B?Tzh4YnZFQTY3QW0yL25Icjlaa3hDMm9kdzFZeHBONC9pbXFhbWpiOEF2NFBt?=
 =?utf-8?B?N0MvVXBoOHRSTjlqUmxzbHZneFVnT0NIRUdzd1I1NlFGcmo3d09ucnFoY3BO?=
 =?utf-8?B?ZFR0SExVNGZTT1ZOVHplbUoxK1dsM2JJN2hVSk5JTnVUSWZuM1AyNzJFcUEw?=
 =?utf-8?B?RDUyaStXV00zelV6OHRQcEVXR2lTajUxZ1VPSm10N0FwRGJ4WmJsdi9jdG16?=
 =?utf-8?B?SXVkblNwL0VKSjdlazZhd0ZCazh4T0hWZGs0NzgzMUZONDEzMDhNNk9IMytK?=
 =?utf-8?B?MlpSUkNxUVdVUEZYVkprbUw0QjU1MlhxdnhrcWFhNFgyTXJUT0tMQU9sdktw?=
 =?utf-8?B?Y3NteWFSRzA2bmFXdDBrL2d3UFBxQ005WjR0ZFVIbnRYaDBSV0JjYUV1RTBY?=
 =?utf-8?B?eDhDNVNxZzhSNUo1d2dhVlVHdDdKMThJbmlRWlY5YXdsbFhKYVJzb0JmaEJI?=
 =?utf-8?B?c0dhV25UaGw3aVVRUTY2UVBBWm5jTWI4MEg4S1hPRndHQTMxaSs5dG9jMXM1?=
 =?utf-8?B?cWRwbzRvUURrMHM2OUowbDlYVXEvaENGMTRJRHd4cm9BUWppcW56Rmh3WXZF?=
 =?utf-8?B?ZTBTdHlvMDhLRWk3ZU4zdmJCMmc5SGRmb0drTkhuQmtEa09wWkp6dzdHTDZl?=
 =?utf-8?B?dHR3ejhYYzkyTGg1U01vbnZ0SzZXYUhIMGJnQzJmeXVDZ0x1akdROE5YdndP?=
 =?utf-8?B?bm1qb0pyS2hPb280dXV1bytaM2s4MVIxYnlNOS9Ha1lEVDc0a0RCcGtySENU?=
 =?utf-8?B?YnpLWWxBN0dtSUFlWFk5R0FVMTQ4MHRvejY4TllBclg5QjZOYzhxNDFXZVNK?=
 =?utf-8?B?SE9laWNkdXVITlI2RWlDc09xRHpQMC9yOElwMjluMzhDME1NdEVPSW5KSkhv?=
 =?utf-8?B?dUJrLzRpeUlDR2p3TlZwVVIrOWIzTUs0eDhSU1QyUkpxZTJxaUdsTkNOcE1n?=
 =?utf-8?B?dGVrRnlUdUJ3Ym5XZFVYRlpMUWcvQlZVQmFLajROOFh2ZXkzUVdLalV1b0pa?=
 =?utf-8?Q?uHaHHUgB3/01fS7epm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a011ab1-0486-420a-00d2-08dec21c8b2c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:34:58.6073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB8BTNvmFFLD+o0m0YT4Zf0NoMG8dwMo1+Ih4kN8gvETBBEZuzCpfHm+/YYJvz9+UgpsqSPP8XBSg+wDisXEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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


On 15/05/2026 3:37 PM, Dariusz Sosnowski wrote:
> Offending patch fixed the LACP miss rule logic for NICs where
> switchdev is enabled. In this case, LACP miss rules should be inserted
> if and only if started port is a main port on the embedded switch.
> Side effect of that change was that LACP miss rules are not inserted
> when switchdev is disabled and legacy SR-IOV switch mode is used.
> 
> This patch addresses that:
> 
> - Fix the LACP rule insertion condition.
> - Move HWS table for LACP rule creation out of FDB rules,
>    so they can be created separately.
> 
> Fixes: 87e4384d2662 ("net/mlx5: fix condition of LACP miss flow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

