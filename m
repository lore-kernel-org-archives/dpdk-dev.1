Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6037CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 09:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F29E7402EE;
	Wed, 24 Jun 2026 11:35:42 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65]) by mails.dpdk.org (Postfix) with ESMTP id 9C069400EF;
 Wed, 24 Jun 2026 11:35:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWxv/m/rfEi4M5nwYVVDc2xXYxoctOHPyCaAUapv2wGT5GeMju8pWymQWvylEYpP1mM78AZXRKY3l8hrzEaqbxzCPxeI8gr4D9sQZjGRF4pxdXgMI8AfW3dI+s+bW6/FjqqxyAz4F8Hw51PNRhMCqu8DOicPNxcFKlHDPVbDPSVX2JDjFY991pO1wBiFDazgGyWiXcyhRp/BZzEcaKyknFFOuy89BlQThgR3qcvp9XnBHIG2v+6X8bAR9hCup4YgbZd9N7jbRttD/cVhDrGIk8FUYGVlRfit9NSWRBWepHpAd2eC31Wy9ZBgLqq5MAX+Ig0CQqPqQD/pU2FOwmfgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjyQTvBLJ+RGcpjdao8MVlnqj6MN/ByckzxcKB68SSE=;
 b=pnryS/2HldjTPYeDv9P03IIzK25h5uw0puH9BnN5lBQOhmntCRx3DEFK0B74/1DzBYCD/8uiuM87yHIx9LPwpWixkymPp4Rdb7djlPyu7AITydJvSU6tSId0yp5WfEoT+PfehnYxnCjZOlyZzd6TFnD4jCRkOj47eoXlVCjBTNKGIxhIKJMxkw16xX1NZR66bUBPKn4PLGUT6ZRKFuIBi4bGcC/Kt5FNZ3xW1JV3ciUOLqvGzQCV2rCw8C6YkB4vfcsVdbrzzb/yje87ziUpOzC67zkeWZSSaanlplpFiFSUsegFqMngdMxMjq1/aWjf8qg0tv1oq4o59RaBrWqXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjyQTvBLJ+RGcpjdao8MVlnqj6MN/ByckzxcKB68SSE=;
 b=Ap2idM9BmR5PO8eLzzfQ9Frd6g41fLYvrOUDsUSvmn2NolwVm1LfktaBayGufGy568+RGtwtr6hBvGRY7xhs5aXN9xt1q2Tqi7sk4h26hhZjjj2rgJbff/0rmdZMR2UYw1I6mlHKi2EidT9xY5T6ETyIQfjY/wfZL2hfcEL7w5iM/E06NwswKZdbtHkiMF7Raj5sZwHi0xJPK92DwtRGIZLYcwTyAViVZCyLpvUHFpdOJMdzWWpeAVfF3NBmiaCnSokDwox7+K7Fp68cD+jbmQieSentZWlrHfseEeTgbfzQdy9Ggt3kKHHWQ9QW2QOSA2dXKHcPuKHGP6m2i9FPIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 09:35:37 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 09:35:36 +0000
Message-ID: <362dbbd3-5ede-4cf4-8b07-ea1ae8e930e1@nvidia.com>
Date: Wed, 24 Jun 2026 12:35:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix double free in vectorized Rx recovery
To: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260617134301.798213-1-tsyrulnikov.borys@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260617134301.798213-1-tsyrulnikov.borys@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 166ccf7d-46f7-42d4-70d7-08ded1d3f229
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: khD297UzhpWw+HbwwHVpI0ptA30uKFMIoB5ZvKzd6Q3EZpGoWKN9B4rkp1PzXN7VxHytaUNwH7usyjh+MRjfrczSXw5TzhzuavkSnfLONnsBhdj0j7lVx9qtZ+TcUv2TZo5RnB5FNRjzKyToZmo2j1jpZ63d8CwGjW/x4YbIAg4Q8KQeDfqlTJeTx0I9OTEw07QWNvqwvmT5zx2t4xaOYd20I+4lOaRV/zKSz3Udx7u2W9Wh6/EC7Zz50kkXCiUoIfQHy+J7lFzwFSVWC4FXwBjMhDnH6RDej1cbGLr2GA7hGh886i0JyeN8X3OtgckMWhfQ/fZJxg6333/6L9kwG5Upc6iINFwzkL5KjRd+43W7y6ahhVDuJYDgu1WgHO25Cana0WJ264v2Y6BwNI22/sauvxRSzNN7//dZaR7Tkaof++/58Z5HAWN9TyW0OWxKipbG7R+LnhCqrXVKs5JR9nle/dlPLtjH6kxb3rS4YQ6548CgVvhrHR/STsd+TIJqQivJMuoEOhuvLCc6rDQH7eru4uRPkpVtiGwqGdclZiXaPKtz6Ibj9KQKUejxoXVuY7iirhc4Q7pH7BLt69sXokquzz8jH3MagomoUc4/wzwim/n10nYNTuwJrp1Ljot5IZKW4zul1nBIKTrdczghEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWo2KzIwWWU3WXVFWENJTHNlcXgydFdGWHRXMjRYdzNkVUFJT3dtUDFNUTRK?=
 =?utf-8?B?M1NzWUJEa0d5a0d5RWtNWXFPVXpRWVJMaUphTEpXWWxKTXdkbXh0SmdEWXdW?=
 =?utf-8?B?S2J3RTZrRUdoMmpseWZsbm4zUmhWVjllZ3kwMkhsU2kzeC9rQlRyYXBoUWRV?=
 =?utf-8?B?S0J4YWEweGxQRFcrdU9tVHRTTi8yTkRqT3dNeXRuRE5SeUxlVWhzdTc4aGZ3?=
 =?utf-8?B?bjlvenh6aW5YRmZ6NWhhNGVmRkxOSTZLbldYVForZ2dwQnR4WVAxYmpkSE1u?=
 =?utf-8?B?Mzh6bTJ5ZVhiUUNCcmRxeFBoV2FBSW51d25IMGl1M1ZuMUttVEt0Y3NJUCto?=
 =?utf-8?B?M0NRWTN2MlpCbWlVY3BCWnhXSDRxUC9uM3VzNGMvbGZiNnlzVWNXQnlTRDM1?=
 =?utf-8?B?aWgzb1ZpRS9PUC9maGhteTNHeENRYllXTmhQNDEzdkhEMy90dmVFVmRUOFJw?=
 =?utf-8?B?cm1nWHdnUmpvZCtUNjVZRjlGTzRYYU0vTXlrY2xjMDhYT3R2akovdzZsRkFw?=
 =?utf-8?B?a1hBM1llT0dkaVpxbVZnbVFCY1l0SmdNNFlaNXJxeDVDRWxjaWduTmk0bUVm?=
 =?utf-8?B?MHNKSnNtZWRUcWIvbEI1b2NEWHZBbm5kSTRVbGtSMlBMSWVrTU1ZV3NlMkNW?=
 =?utf-8?B?QkEvZWVXUytQU3pUalcvdWE0UmRzYVlHZWFkbXJNUDEweGNYNVVhMzNISXUv?=
 =?utf-8?B?cnVUZWNRSGQ2b050eThCci9lemk4OWJkbm5XK2g3am0vT09aV1l5ZEkwOGpF?=
 =?utf-8?B?UEdNVFpYK2lJNGVLbVgxdEhDQ2VTWnp1VE1jaVFSVHpmTW5nY3dBZGw1Tlgv?=
 =?utf-8?B?RHN6eFRYcHZXQlEvdkdiRU10UFNXa0RpMmV2VjRIZmFEQmJHbHNQZlJleDY2?=
 =?utf-8?B?U05vMW1McGVrblFhRGFyMEJBZDBndHZEa0pYb1NlcVE3VUxyYU4yblZPd0Iz?=
 =?utf-8?B?dXcwcytNeGd5anRnU3FmdVhjdHA5OUZvQjVoM2RMR3djVXhrZFl6REV3Z1Fm?=
 =?utf-8?B?NWJSQ3RBeGE5WlVnUXlsN0w2RWVZQlBkWWNBREVreldyNUgzNU5XTFpRZktF?=
 =?utf-8?B?YjJXaFN3bnBvUy92c1ZPbjlLeDhHdXdTYU1iQ2FnNFJTdnZlZVUxWjVzaTY2?=
 =?utf-8?B?ZXdKN3JBUmNUWWFhdFBtWmU4TWtsbnU4YmpBaE9NcitRay8xaW9DUGlSWU5o?=
 =?utf-8?B?WFV1dy9EUEQyY1hNZUFDZ0RuV2xRM3NpdEZQTWlzM3djT2dieE9lZG1IaVJP?=
 =?utf-8?B?VUZWeTNicnlMQ3FhNVVvbkk1T0Jla29hSXZSRHE0dmcrM2ZBN3hVQysvek9Q?=
 =?utf-8?B?WGVhbHZ5cGRlMWJ0ZGkxa0xPYnBKTjRuOXlqY3VDT0hGS0F1TWVHeUNEckZs?=
 =?utf-8?B?WjVJVUdDVytiNzl5Qkk1SWZXT1lqTUFtQkJKRi9ic21XVDFkUk1NblNzZHRY?=
 =?utf-8?B?K2dtaDcwdE41MGtEQXNCR3llWlh3bTlzTTA0U2Z4Z3lUWURlNVFadGpUUWov?=
 =?utf-8?B?dnAzNG1UYkZKZ2VVWWVUTnIyUnd2WHlsZjlvcmdVaDRKRlpmMTZYaGp1a0Vo?=
 =?utf-8?B?cnNyY0YvZ0hvMi94OTRxZWk5b1RzY0lDbmZuT2R3SXlYOVAwQWJiSlAvNEJE?=
 =?utf-8?B?MVp6U2VnTHExeVVyOC8rM0dGVWlaMy9ITHNxb01XaHdsMjVYOUlQYmNHc3NO?=
 =?utf-8?B?bllUUnJjdWdZbXJFWmwwNTVLN1JjelVRaHh2cXlrT01jTlpQci9HaUp2WTZY?=
 =?utf-8?B?a3YxVXhLa0pjcWRHcUlFZFFSeGx1LzBlODZ0NllWZTdGbXRheVBzL3hRdkpE?=
 =?utf-8?B?bVo5a3ZXc0xOYnEyU3pyN004UnlFVUFnZE55djR2cHgxM2I2VmRKMGI0amFq?=
 =?utf-8?B?aWRvTnZ5ODllK1c5VHdiZlZYbmZvSXhoWTZEclovRWR5YmVLNFh3UEVpU1Js?=
 =?utf-8?B?SXZOd1pacnM4c0N2dTlldUo3blYzdjJXb05weDdNNG4va0NtaVFpNDdMRmVS?=
 =?utf-8?B?VDFuMndSc0JrcVljTjFFK1VtK3RpV3A1TVJoUG9nN1liQ1BMaFZIeFNKOGNs?=
 =?utf-8?B?R0E1cmxvOG1DNVgzUGtaTk1HaVh4MWJsQzY3a0ptREt6S0JlcUxTSjlVbCs4?=
 =?utf-8?B?SmlOMG0xYzlqOFVKdFJHNW5yWnlwMC9aOUhGdzlqRXczUStYUlJiUWRiL0hz?=
 =?utf-8?B?QkhVU3Y3L0krZ0hQMFZJamI0NFJoRkcvSlhYRURQY1lHTkQ4UlR1Y0ZCUk1I?=
 =?utf-8?B?U0Y4ZWgraUJuOHcreEpIT3RVbzd0RnQvcHc4Y0RGQTd1TnVkMklwemVFSkFU?=
 =?utf-8?B?T2wrclQ4Tm5WcGFEYkFFSEZad1F5N3krNDdCQTc4S0ZmSk1HVGpNdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166ccf7d-46f7-42d4-70d7-08ded1d3f229
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:35:36.6883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIhMqEneTmWqxlapTOY7Fh4cZgugzy5hrXgwX1yJZ2yjB4jurMF5dkyrolfioKXIPc9eOav6szDsrWd8O9wAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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


On 17/06/2026 4:43 PM, Borys Tsyrulnikov wrote:
> During Rx queue error recovery, the vectorized path in
> mlx5_rx_err_handle() reallocates an mbuf for every queue element. When
> rte_mbuf_raw_alloc() fails (for example, the mempool is exhausted), the
> rollback loop frees the mbufs allocated so far, but masks the element
> ring index with "& elts_n" instead of "& (elts_n - 1)".
> 
> elts_n is a power-of-two element count, so "x & elts_n" isolates a
> single bit and can only evaluate to 0 or elts_n, regardless of the loop
> counter. The rollback therefore never frees the mbufs just allocated in
> this pass (they are leaked); instead it repeatedly frees elts[0], a live
> mbuf still posted to the NIC (use-after-free / double free), and
> elts[elts_n], the fake_mbuf padding entry used by the vector datapath.
> 
> Mask with the existing e_mask (elts_n - 1), as already done in the
> matching forward allocation loop just above.
> 
> Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

