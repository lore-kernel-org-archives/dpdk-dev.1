Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A654C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C54540269;
	Mon, 31 Aug 2026 17:26:36 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34]) by mails.dpdk.org (Postfix) with ESMTP id BADBA4025A;
 Mon, 31 Aug 2026 17:26:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9mK4HQddMuBDU850exSJNTPZZ9kIFE8N2GhaMw7Ao3GTJpa/6nP2mfHlEGHIkzNOUXmWNaYq6usSz/awHcsbnpmwayzoSiU6VtKQw0lowgecoeNSLto88M5+uwqaW8VSTP4g8DyioTsVNcsCXGxBF8NCZzoYv9mx/PsMgz1iInO2MDg3SxxyN3fwPKB8xQ7uLA1W1XrCt1E7Og5ZEimxOZlpalgRWRbgMHmIgW6EUwDxEtu6k5S1aDiir3Hruh6rULB15ZJKWy8cww6HLD/q73y+8RQvNil97pnmmRQoecXupGPfA6pkOqaJIW+6+jdTZzMYqh/kBkf7oLeaT96dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJvfhf0E4by87zphAwuE9AzKylEReW7x0L9rf1xx0g=;
 b=ld8O+GvH+cjeM5Kd6f98oedMANO1d9QC8x6VwGLg090Z7DSa20ag3feFdIChvvwbqgeOg7i55G4cQiwzeHuv3f0gqJoUwV11flC1FpGkfmz54aagpOqircA+HcHKhlJKwmU9j1YpyKCyrS+V6jjxlH3HQjn9hyytzReZCdynZ52WrOLUBTHFriwelJrctL8vx3RyPSJRmaWsDJKut1D6wE1oCKG+FRjLbryvD/BeifPyxlhm+ac9CFlvYbRIDkyMCzwxbvwF+gBQzAPln6ND1SRjWfN4pIWTeSKTeDi2mGvJw4BQE5a8QGyVL8pp7+RnPMsNyK2VtvhYZdyJzY6zTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDJvfhf0E4by87zphAwuE9AzKylEReW7x0L9rf1xx0g=;
 b=JbMhVNjBbYoL7tm+eixwjzHWXGj/F+0Ew7tBh17TcmXgLtvrmM/WO/nyq+g07YYwUVBKh08PgDEae1ueURfEYP/k4O0g9WSfiAPi7HRWvJRsVrqJGXxVqW7DYgA+jcMcZ+zigP5kbI2tY1lUGidLFQP8OyHNQvhwwrGdmPVYc6WBfjrxj0tLEHeLCSW3ZvnlISesYWyNL9/hzL7UEZw2p0FDX4FTYSv4OPqxUHavCG4l18/GtNvb7F/jLmkmBgu73xXcEczPPC5O7S7/SDKkP+/MD+oqqGJTBDXe1Wjts5Xxuhb4MIbMLppuHq/ZBtU1Si1yGV/ksdFsTGMwW1QoEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:26:26 +0000
Received: from PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8]) by PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:26:26 +0000
Message-ID: <5bd278a6-6ae3-4edf-aed9-3ea0184dee6d@nvidia.com>
Date: Mon, 31 Aug 2026 18:26:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix aggr affinity pattern create failures
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: stable@dpdk.org, Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20260803090629.1758028-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260803090629.1758028-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6747:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: ed560c75-0615-4c96-3fdc-08df0774382c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F0S+3K9FCOZK1HADRwC5mKykrCDPlSm5il02IdWqwhXsnn6u8hlnGHT2k/cR49EqOHC2Df0dHBwqapT/0Fg84HXL6UEwUhgNXHD7FMww76Odqx4XAJ/83CmZhILYgEb1IUOIEgXXNfZC4kRzHX+jp1DBgR4+PRhgink02EYm8TVyBdAJ3vgwPMk6WdrPyE5CUIUkA43jd8SmX1gjATQVKcLQy+uGKZHtAhtux4NnQfbyeF8zQ4GpYvlIIX+9k5hDgH8PKb9kVoDbDeOhDaHVcneGssblNhkcc/5gUwR4W/5KdzLAzRk2QkkRiYsuKPCIUPyrMhzbH7WfcD5+iihxTdMJWgNRJInWx/7yifBMJW9HKjldewPLuRMbs4E41KHX+7t39yVSTKcnaVNFKnQzrW/YPSk7Hykvc/nrxpgFenQqaYukbQsRYwn5WS1KJghb3xU24syJzohKMznj4jWMSIKlyC0QmWOpTzg5mjz2ULm//jNqjAzGD7OOW2l8yC1FHt5zIz+898ohSJJiv2j96724+E2qX/gkBofB64vJSi4ltgpvLjcH2+JnIVb5zgpk1hQHhDZIM+GUD0Yg/f+vxeTBUi3xx3gzX/n4P45VDsB2K4QFg0vHhiMZg/UbYxxLJ9o+mdd7uZT/pL/ObBVaKG2hwGvCVTUa4gC0DtBPIC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6747.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njc1YXJRTTJ1WXQ4alJHUlR4R2lpRDR4VDRwNDNPcVRQSVlBRXV2Uk5zTDdL?=
 =?utf-8?B?Q2VCamNmTWlRZmZiY3owNm0wRUZLVUNGRjRQSmY5NStHTVM4cnpmditYVVNh?=
 =?utf-8?B?Q295cXAwbndPZ21HQmFpMzFDc204Q2YwN2ZtbWNiUlVRb1NBM0laMTJtV2tF?=
 =?utf-8?B?Yy9FNWdNeGxBZXRsMks1NmR4ZHlVTTF0MEZhUFFLSDZWVC9IemxNalRtRkx4?=
 =?utf-8?B?bmlObHlGODVJNWVQMUJ4MEtGZmZiTWR6WjVhL0ovTUJIdzgwTUQrYTVGR3ll?=
 =?utf-8?B?c2I2Zld0bnVNTUd2Qm94dkhmWmpiUWdaZlN3eFFEOGtTNllhM3l6MUJqUUJr?=
 =?utf-8?B?OFlsK0JVQkpZajVPbmpVZlpLOUJndHRuekNuSXI3SVZkSkNJTDNmcWhibUJo?=
 =?utf-8?B?UmcwN3dIVXlwUWZqUURhWVBHN00yUWUzbHpISnNSRW9BWjBSZG9mYmJUMDkr?=
 =?utf-8?B?UFRKdzVlL1hmVXg1KzBXaDgrenFXSG5meUV0OG5Yc240bVJoeUIrZ2t2Wmxn?=
 =?utf-8?B?WlNxTkNURHR4NTB4YUMwYjJlTGZQeGdYbkVNUTFVa3YwRXFLK1R2MmxOMHla?=
 =?utf-8?B?ZWN4cDg1b2QrQm1vNHNCSlVvQkhlU2xJUEVZS2tIcmFHNHNlTVBhc2pSY29w?=
 =?utf-8?B?WDlBaDBMUXVuNjBUZm5KMllmbnF0a0JrUWhGdEExbU5LanVjZ1VXcjNvNldp?=
 =?utf-8?B?RGVpdWI3ck5ZVVhTTjhlQU8vb2hQQmZUNWc2YlZlbjkrYmhGdlkwb1BmbEpl?=
 =?utf-8?B?NDZ5RFJLNmhpeFhxNEE4bmk5eWtVL0VtM1VXa241N0E1MmZMSXJOOUVBQUFj?=
 =?utf-8?B?Sk1HeTRKakJyOVdHeVNSbzlRWW1lRkRUd2dIYk9lZnRuVzFHMlA5d09iMCtD?=
 =?utf-8?B?UXRoNktsU2NvQVRLaGdWc1pIbmFLVCtjMGI1anpOVlBpOUdsRnh2MXBQTHRr?=
 =?utf-8?B?NDBQVWN0bVJOUmpvaTd5ZXVRempBbVk4RDMwanZrcXJaZ0xpUnN5QTVSNTRh?=
 =?utf-8?B?QTFHRUwrWDBUY2VXU3pjeWtyZU1jUEM0LzBzMkE5blZnclhLSW1Wc2hLYXA1?=
 =?utf-8?B?bzR5N2ZQYmxHRTUyM09QSkM5cWhBakNWUkhEdjhudkRXRG80M2l4dXd0M3lH?=
 =?utf-8?B?Wk1SeUZFUk9QS255a0laa01mK3psbjNadDVDRDFPbGpUcGV0UFNYTTEydVRL?=
 =?utf-8?B?T2tmem9ndllveVMzUzYrVmVZd0N3V0svbkd3R0FSWFVXakRrVEtZWU9kNzZl?=
 =?utf-8?B?U05QSHdwV1haWjNoRnk4SXRydEFBcSthUnpvem82QWFoOFZDNG5JRDRET1gr?=
 =?utf-8?B?dU40dnlSSmtnTmRnbWRYTkw1TTVHOXNDNnNpWW5CVFZMdzNCV1Ayc2dPTzBM?=
 =?utf-8?B?N2hTQkhjSFdVazhIUUkyY2tvVHdWOExWZ1lVTWRLV2V1TmhVOGd2Nm43d2dJ?=
 =?utf-8?B?U3E5WVlqRGpPVTZJN21ZRDdXaGJwVGdVUWJFY25oYTdlckVtSHgrbkNDY0Vl?=
 =?utf-8?B?Y2FPU3JqTXAvejU5TmlCbjVZL0FXUE0yREJuNjlhZXd3TGltZEZzcVN0Tytw?=
 =?utf-8?B?MmNnK0lGRXdmcVFSL1NJYnB1VG9rUzZJSEs3TXVON3daS2hwUlZnZGlnVWRm?=
 =?utf-8?B?NVh0MkUwWEtlU0NlUTJGVlZGVldjM3hTYU8zc2Y1a3psYWRsaHZ5NGxlVEhN?=
 =?utf-8?B?MU5Nbmp3M0xXRGtjenFzSGhOaFhNSUE5eEpLRlBTNGdOOUdnQktnT2E2dUFR?=
 =?utf-8?B?R1k1bjUwY2Z0SWdNbU5SNzJHNUVIU01aK0lueXNmMU51MUc1NVdaZ0c5Smsy?=
 =?utf-8?B?TGE3MmFGQnBoSzQwd3RibDEwL1o1UnQ0Vy9pWDc1dkVCd3VNTFQ1emt2anBJ?=
 =?utf-8?B?bGQ4bFowdHRsYkVCVUgxajI4QWRNZkFwN1RqYXlwL0hiNE0yLzNiODBYNWd2?=
 =?utf-8?B?MXUxejBtRGlLWHpyd0NrZytGL3FrYnhheWs3cDBObmtibitJYVNjY0k1Z3dG?=
 =?utf-8?B?eGErR3Mra2dOaEJjS29yam1zY21IZ1BSMUVORHdkZ1VpcmliK2h2UUw2Qy91?=
 =?utf-8?B?d0hTZWwzSVNJYWFUNmpRV1lkSDhmamw0eDh1VDhPQW9kazRVWU4rUUFuenkr?=
 =?utf-8?B?NDdLWWFIUXRHTEVkVUltTUYwd2k2VEluZ0FqTm9vbk5ITmV6OTloSkxkeVVp?=
 =?utf-8?B?cjlyUTluSk14VTFNYTA0SnpsbExaZVpoaE5EOFJlaTBHNEU0dkNXc01OTE5P?=
 =?utf-8?B?Tm1PSEZYR0krSHdYY0JhRXdJQjR4MHFaY3pUbnRwVkNNQzZ5S2xNVk9TUlBz?=
 =?utf-8?Q?X1b54l2CDdO8GIHwIO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed560c75-0615-4c96-3fdc-08df0774382c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:26:26.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMbopyORsmbyJAtmDxiNm8jh7HB1KseUvgkMcaknhqXj+rEmYyrl9LHyW0E6aEH1x1ILRJApawgJRXBUur2D9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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


On 03/08/2026 12:05 PM, Rongwei Liu wrote:
> The mlx5 PMD attempts to validate the pattern template
> by creating an internal table under group non-zero.
> 
> Aggr_affinity is only supported under root table and skip
> its validation. Table create still fails due to definer
> translation error.
> 
> Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
> Cc: stable@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

