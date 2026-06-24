Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27188CDB470
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E66A24025E;
	Wed, 24 Jun 2026 09:16:09 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by mails.dpdk.org (Postfix) with ESMTP id A30E940150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:16:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLGI/m4jTOL2aVAm/9f4mGeKL1f6ZUPtDrRHFKNxHrN2liT1YNAhoKG++VHXy3N68LdJqdk7ExIvIb+NhCROuQF5Wd3AYL2rp9MMj6wu2TyKgXOhHkgSPhjeCuTT0R+X7GjBkATzXH9KJzh27Bsd/bPFZPzSOlMF1t1BQYzhCA8CHTc20U/u9EmJTa4Wu5H6eUK7BDEXtpjtvY0JBQphilSd2UXD7v/IJQIjrc5G4QdAy4X7A4qRKnXtVDCBJ81RSwDpWmLC0TUMvTlbumcx6sP4/US0/GfxfSHm7+IQ7QlZXKPsSe+/6xvHiziA+I07zR3MOaPkXXRk2XRvbRckCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5wcMqsGjpF/liCgE53vgcU2GP7UTfatkkM+e+E1vyc=;
 b=eU3P2eEy2YPNprN3JsdtpMIQaf2AW+R42cTn1EzeaM5aAL9uDLqrwK/P7veOuvpIwOdBN5oDwl0e1TaTyCdkmzIqSfic7u+wzujH6VZHcfDS1z7TqM9QhxVM9TKtUAdbqLiHp7NYifG6j2bP8h507jSctsfh1u+89WZXUqgfj9Il0Fe3+m/J8sSpSH+upUcyvu3qhAnRuVrUCOilvBUJnTVu4Ajk65y6UIXIye0vRuaNCHkdnvm0m/q2ZVlEwb0quPZHLBq2ad1xucR1DLZb9+tj0GTt3EQI6VGRWrB2/kyQZbipID7Jg5tfbUrNfgMzSXwIAXJu9K+thx5uuLvgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5wcMqsGjpF/liCgE53vgcU2GP7UTfatkkM+e+E1vyc=;
 b=DH+amw9kHR894z9mpSrbYzJUlnxMq2bXF1mxyiYPx62kOc3YKpBgew6bs/tE0Xy8Tmc/fEjLUsdz4L/rzQyUmBw1IW/RbTfdOEFsbxDpEeMkJIjmxNQsGf5Ag4ItZdMFFTPkBQbUjV8M9iLBrpb0a+vxk6CBgSL2KUbaFcD/DJbxQzRkxL5+lLwu+u8h7v1YaqGivwaGcISZKAJwkS3EQXgt9m+wKGQZhi+62ua/yomRzP4gj0zxFKM0/HpPxdrxpd9hYdqt+ZvBTBYiUoJUd421sdRmObJh2WKowodXnEwI1IDkGPCqLgd3wFruTmziOEVjV09ee13jTYPrUD8Jkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:16:04 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 07:16:04 +0000
Message-ID: <ab4daab2-a9a8-4064-b94a-28d275d02eb4@nvidia.com>
Date: Wed, 24 Jun 2026 10:15:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: update relaxed ordering policy for mlx5 mkeys
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260616122355.39114-1-mkashani@nvidia.com>
 <20260622075410.38103-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260622075410.38103-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To PH8PR12MB6747.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b9147e-6d78-4142-51b3-08ded1c07364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 0Cie9C4UiNh8HtoMeVAkUeEzEUpv+vhDJSMZUPAwx87mX65M7s2MtUV53xool5/ErEddAnDjx9uo/7EC7pFXmqzjFFUyO4VtaFBYM4aOJQIvJBytr8QRZM+IpvZuAMRS3sk6B8onqfoMcJZ+Zzf1BQ+P/jr0oOZnpKtq4pJZv1KS0+Y44wovYnj/SksEYzwP6Xnb+ghPMfwRv1UtpK9xKPsU2wv6ttzAe66lp+morg9rWNrXV1Szec1K8aopQfjTlwF9YU59izv1P5AkUlfH5opXocQWtHrehvMlGGzJxPuPjd8yNpb9kWJuhvbhcFjev2QIUP2Ve0yPcT5vEI01dymli8N2ktNwmZfjmW1GiKX79WDFN20Fp+bpo5O2qC2/97YNhhlKaDTqye9/g5DGOaM2JuSt2uA2pnDeqmlKpeg/QYg0xbYuUer95ED3aHSUL8y+PNWpgX1o9kDvlHY21DaWtBrxvdSgHMfWAtG8laI0nr8a3WS1fEhECXyjqIBzq9sCicFIbBqU1B5HTASyYyMeD8zLH1NyYkCw8rEFQyO0LQhX80BqbT/OyxFVauL+NVhgOH4aLB+bqGc579qg8UAGrK4x0ppdaFPN0VtZKqVNFg0Nqm924H78lf0iq5FlyjztCW9WAdReyWOxAopYyMM9NuAYa2o02w6stKXQ8v8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhjRUswWHlxY0Z2eEJMVXgyblZ2OXNHTGJUc3FzSVBkbUY2dmg1QjdoTnpq?=
 =?utf-8?B?NnAzZ2ZzSTdJdFhTN2YvWm94VVJmUnoxQjdyNTg3ZlY4dTlYazFoZnFUYWRa?=
 =?utf-8?B?Rk9xZmRpKzVnU0gzMyt0SHpHdHpCTHVDTWJ3NjFIY2J5T29QMmFwWm5MUHI3?=
 =?utf-8?B?cUl4YnhUMksvdnZ6VHZsdFFqb2xsM2VDeXU0SU9RTmwxV3hmZGhSRVJLRHI3?=
 =?utf-8?B?akJ5MEdqZGZuNnVCM2tOVURHZDZZUllVbExPT0ljRUNPTEVUbUUyaFZTMHlS?=
 =?utf-8?B?c0svMlhaZVFxRGZ3Vjl6TC90SG9LdndHZDNLcU9hNGY5OEIwb28rUWV2RXNG?=
 =?utf-8?B?ajRKQ20xTm5oeGJzc2R5M2Z6L3VIdmVDWmdzUVRtYndZMHRIWTlxdUJZNjJa?=
 =?utf-8?B?WHliQmhsYTVVZnFhdW5sSWt2OUIxYVV6V0FqSmRFb0tXODZMNnk3K0JlN09w?=
 =?utf-8?B?M0hQelNpeCtSK296VlpTM1Zva2NRdVRPaHVhM3ZzNlJyYTIwZElOeTQyYTBz?=
 =?utf-8?B?L2J2T3BjZDRhbjRYSVgreDJuQnFwZ2kvOFR2QU5MMW4vSXZaajhlbDY0Zkpn?=
 =?utf-8?B?d04xMXltL1BUVU5FUkRvMGlWcUNzSEhMdEFDUy81L1hVaTBPdFZ1UDd2TkNy?=
 =?utf-8?B?OUJvajhQdTJjUUxWbHVaeE9nVkxTcytubWxzMkMyZUhFdXJJWEZqemQzVmV6?=
 =?utf-8?B?RFVmNXZiWHl6Smg1MHFFZ3BWdlFBdUZ4TVZIWnBQSmJpSWxJU0VqK1FCeWxn?=
 =?utf-8?B?b2kyOFNTQlptd2I2SDJ6akx2dFVVbGJKMlNzaGR0bXdtaC9HeEhlK2YvNWdm?=
 =?utf-8?B?eFFNUFF4c3hQYmw0N21OczBOZFQ5dzU0K0s0NUFmZjM0WjhQQktWc1JTejZp?=
 =?utf-8?B?ZHVSZklNZTVIL21RK09FaXMwU2srZTBuNXdsdnZPUDBFN0xXbW5VTTh5cnFJ?=
 =?utf-8?B?alpiZ0djUk9RcmxwL1pkdXErMnNvdW44YktQQkZqZCtpeEtFdk5BZlFJd2R4?=
 =?utf-8?B?QXBiKzdYTTh2bnRKQUprMm51OGtETk1ydmRjVlZtTDFEZVh1elNkdFpQZEYx?=
 =?utf-8?B?anpaejhmbUJXYXA2OFkvY3ZHZVhrVHFyV0hDT3J2WDdjTUVpeVN0RjNSQnJ3?=
 =?utf-8?B?SW5LdjJ1cVphZjdZeHJjQ2J3TG5WSHNpMmlhcXl5ZEg5VXlFTlZENUdIOVZI?=
 =?utf-8?B?UUhESGNIdyt4VStvc2FuL1FERmlmUEpBV1M2WVlPbEsrbmlkV0tCU0luT1pL?=
 =?utf-8?B?bzdyaStwdzJDQlQrZWNSNzV0WkozdmhmS2UrUFU4RThvOHo2SHNoa3hGMDIv?=
 =?utf-8?B?UmRCZUxPYjJUVkx6eWhqdUtXZzlleHEzT3FXZzNNb2tTdFZLdHpDMk0yUXhJ?=
 =?utf-8?B?QlVQM0h6aGFyYjRBTDNTRzVlc1VmdHREVSsvZE1zd0tjdWF0MEIrekNIZVZ2?=
 =?utf-8?B?bHBvYnkrd2NsN1dvSzdDZnRuemE5c2JtaFVhYzk5T3UxU1ZMTGIxSU1KbnE0?=
 =?utf-8?B?UnJHa2Vvc3NMVmU0UmdPQ285Nkg0ZWVmYUg5V0xzMUlqYk5pV1B5ZytYOUlK?=
 =?utf-8?B?T2xYbStEUGlBZjM3RzQza0dpc0xrcUhpcmdzTmU3MTRFQWY1TmkrTjZFSGVv?=
 =?utf-8?B?bStqZ1RaQWZaRitpa3d5WGRsb0pCc3RSaTZHRkJLR0w0a040aHZldTBvZS9I?=
 =?utf-8?B?UU0zRVlzR01qckg1N1ZHYmpJb08wWjFwYmNTazVZN254RkkyOU1NSjBkOVZr?=
 =?utf-8?B?SnFWT3ZWSk5xTEp6RHpvZ254Zk1Wbk42UWxoMEkzUzF3Z2puMm43dkJ0Q1Fm?=
 =?utf-8?B?NXFWbUR1dVlLampkamxRSzBvd0RNVDh3b2hXVnhxSEN6VXhxMzFFaHh0NmFy?=
 =?utf-8?B?UTBPbUl2VzY5V2tZVmNDNFRrMjFMQnh4YkNMYVcxOTdXMnM2Qmd3eTNKakRF?=
 =?utf-8?B?Mi9lWFpaamhWMjZreUJsdDZRbWdOTGU1K25GZHRXZ1ZoMXV2Z2lnRHB0Qy8r?=
 =?utf-8?B?OWxyTEd4QVdWY0NMYUx6aHhIM1Y4MnNLSDc4dm5RRWV6ZSsvQ2NHOXN6VHlK?=
 =?utf-8?B?K0NEeVhOdHBLYjZHcHRCejF4MENtNkNTa0JpS1dKcU1LSy9UOXJUeEFpWVc1?=
 =?utf-8?B?ckRhTnpsWGJ4SzhZRVBHNFg0WnZZeHoyVFlMQnpvck1MTUNKRTZDS1l0aFRB?=
 =?utf-8?B?MlAySWdtay9mRHpIYUd3TkpDc3hmYkNQYXF0QUVpL2YxaGg3eCtodFJEbjVC?=
 =?utf-8?B?WlVpVno4eUszTUlxRGpDbEhZZ1U0UDY2VHZDd1pKTlZ4aExnNkVXdGh5L3Qv?=
 =?utf-8?Q?nyMngrrNvSK2/C+1Dp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9147e-6d78-4142-51b3-08ded1c07364
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:16:04.1334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU7jwx4xrkwqyM7DAY3qKlBoyHuxmoHcN/Les+SMufz6/mKUagZkPXXK0VJRgdjsfWQyAzHXSMq6saTPCmqG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
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


On 22/06/2026 10:54 AM, Maayan Kashani wrote:
> New adapters expose additional ordering capabilities.
> Query the new caps and apply them when creating DevX mkeys via
> mlx5_devx_mkey_attr_set_ordering(), which sets PCI relaxed ordering
> and RAW=RO when relaxed order is supported.
> Use this helper on Windows (still gated by Haswell/Broadwell) and for
> Linux wrapped mkeys and crypto/regex/vdpa indirect mkeys when
> relaxed order only flag is set.
> Linux wrapped mkeys continue to use the legacy Haswell/Broadwell rule for
> IBV_ACCESS_RELAXED_ORDERING on the verbs MR.
> Upcoming FW will requires setting the correct ordering attributes,
> otherwise it fails to create the memory key.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

