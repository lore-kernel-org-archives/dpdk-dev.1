Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68556C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:31:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7A040663;
	Thu, 23 Jul 2026 15:31:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id DB30540274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:31:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784813516; x=1816349516;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Prd++uN+cnuNTYxDKUSKs/ekgwqK3l9kTJz7+slpBL8=;
 b=XYPeWoe6DBRoLaK5dgxXDEMpAs58t+ejIu9utN53xsp2Z6ieYTb1wOlx
 TkiryfKw4rBodSNI49y0YXL91UJBVR4cayG4OWCyq/pt0VU5c5r/AO43U
 p1lx94Ku/x/VzepTKmeZEB0R+IOt+DdxL0MX7FaKiDXg82Z1j7QYPAP1m
 qaREBlnt5cQX9PLWebU02hEuFT0Qc2RqJpb+USbbgcvrDbgkC1Cib5RMN
 sRa5l6MWBTdOmUgdiLywkZnlWYw9JIPtlt25mvjjlIZtHfyrUgV5G9/J6
 fm8MhskNPgNcRlepGIrKzrBz9tu/69OfkOY3bx88HJb/5vk6vga4vPEAs Q==;
X-CSE-ConnectionGUID: 0S3es4WtThqPBSMY8QVgXg==
X-CSE-MsgGUID: 8sO730ZxS1i9PfWyjSTmPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85318475"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85318475"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:31:54 -0700
X-CSE-ConnectionGUID: htgYo16ARTai/+G7U3TB6g==
X-CSE-MsgGUID: jzNik4cxQ52Dx2e/V+enfw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:31:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:31:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 06:31:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKrbE7RY0ciHwmWvjd205VjpdOSVM0ASoYKPBjwRKX0KsddxRF2XQ/9c/tOCw1btTWSROn/FHobJ3g20bJbvOOiOthTfk4P+5kU0R1fb0W1fsY4cDD2zRAsnq9fGXpZ6QYW54DMA3fAGls56BjQgqh2bbe+ip34kEXGrw3RrMWJUT6JUXrmblLPT9pgDbn4tG1zycj53JzS8v8VfeMhrscFWpz4z49IDEFr5rnOOw/CKObvH42trLJppg1ISuHOzEKsabyfSQJytdNpmevjqGyDFMopbQcRyACEHW8hVYA1OuMuC77rHnixozBg265EAcsEvnqyOJuIeXkR+ZNe44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpg43vnkCg7U5SjvcVjW9jWBWRpXBa25w+op9g2oZlk=;
 b=SAjdZqGuL7SSOWULBd9V/F0WEbbPaaL7tjdPG0BWRSbKrIPMzY8PAMDBW5f3JhBO0czKiixGNRgZD7IodkJHG1b65RBhIJJ9Z3CoPWwvmUSL1TBzhlhH4yAfMihTJ4au5VNd2sBViDhsDDgxeAsTCi3IwU8jaybej3Dy++icsGqjh/eyZSEiIcCdvz1JoC5ifbTf9Lxk14KuUU/0teZwJrL8W+hdvzTPTOC0rLSMMj/SGD65l6WWxwQHclQBGF2bpAY1XL6bYglqO/ldNMPYajfjrN8MecoUAWuSjuLml0yyTjc/7CEFzRgWEswKrgQ2u97rqPWgwHAlwjdCQoNmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 13:31:51 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:31:51 +0000
Date: Thu, 23 Jul 2026 14:31:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 5/9] test/devargs: rely on net null driver
Message-ID: <amIXw5c8W0vJm8hr@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-6-david.marchand@redhat.com>
X-ClientProxiedBy: DB9PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: e33db840-8910-4bdf-e347-08dee8bec0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: goFof0VORqSMo73BiNqr/xjL5Pv9l1Vip9JTQWPsETN0uWZY53rR0JsmGjmiNhUT8jh/nnZx2Tq34lzrFwSH00VkJYb1Dn89PScF3AYLKrvgpP1hY8Wjvlbub9mSQ33ToajG7k3/pKBjDNmMxMnHSQIClHkZCyeq57ApvQ72uPKgJjYfNEcK57bM9YxMQVtM/TYygwXoPzt1QsaB+lBsaTWJXgnDE3FcGcPZmTlS8ucHS0Dg4ykw5VtPHGsc1RbLTrJ4VBQ/8bE3y1KJgSZ1J/0qFatHKys2/GPd/zaPbU1KYyAGM/4pkEiKYaTn0c7DRs0ZRVcWN7ydrnA62tl7dpXFCDXcQCEHIxEKeykK98hPN4zx/5pIwYLrpAJ4NowxqHvrceZoCoaOdKOas++RCTtV3IQgiiOjw7hDlq4F/7lM6wZNdUZgbPxnoqdifjT5fcJ96Lr90nIUTSWk3LD2E/k7TZoCxx0Q4xZzhgcr0YELasASIu+WzslFpXjV0JQ4AM0d2XUhurQFiibdSAZHbNz4TYP9QBjjuUS6WqdwHzGWXA5Nojt70r4K6jZuoYyL1/2ZkLaVoElQRkFVlzgEsWH8JOa8nSqShAXxSftjG1dg2AFQDUMCR2T2VqXVw52fdslLEpdnxwb6SK8FVpNV4Jew/VN47dpD9Xtu57Lz+p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1eI0oL9Nrh/QDhtwKuTvD9F6ilSvKd8rf5W7kimodeGpUERMqEehVDgyCZG2?=
 =?us-ascii?Q?NZJ+dtSkwrz1Hw3O1qUzaDuq4t9BQfO36qbGb1U9EtvXR94Slp8lczKxKP3y?=
 =?us-ascii?Q?kt53qazTFl7EatqqKTbh1/SJW9IhettlyvPR3+jZDtRF+L+zJxiZ5APEwDbz?=
 =?us-ascii?Q?7Sd74eFucYXEP9ZONKIHWl5PAubdtasR9WcGWOxQhvRCMf8eYj/VwXFHTJ94?=
 =?us-ascii?Q?OgNlblgXqR2tbsO1Qq5tUlwXWBWr4VnwUC6IhT00P9PGifKQupb7e5vFseji?=
 =?us-ascii?Q?xEAeB5z67Mdq1gvG8xGKGLyrWo+K62wLffD/BqQ4YSY44A/MLx1mTSZq8fgk?=
 =?us-ascii?Q?B3sFXKiiviyC4aq54cb7LYvp2S50Akjlgp/bcNK6kfftfZNM+wPuJ57mcL+O?=
 =?us-ascii?Q?9l51fg3FYZRKuUaK70cPgwsRtbDT2jnY49A8+8IetzZOFCiwZHa+ubuH0i65?=
 =?us-ascii?Q?SaPqVz7bEzYBX7WSe19wEoiie/9KH4RzgIPvmMiTVk+C6pfN3uZA+jlM5Q/R?=
 =?us-ascii?Q?+bXuF9rtjX5eXS5Yb2zTRP9kWCw6JGN2/aNZdfN2wNV/yFPcEZp7bpyYOYOh?=
 =?us-ascii?Q?NvFfNHqfDcUsaUBEaoEZcwR3jV9Q4+td064fxDbWvCneUOasB3neDW+KO1/B?=
 =?us-ascii?Q?zuOh/f1DfgZ0UT2ToMcbFedj21WRNTavbTTBL7/nUUzE0uZdknY1xi3h6j3M?=
 =?us-ascii?Q?v6ohLn65tpoLvdVCBdLdbo4TLltL0VJCYTAJem6FwlzUDL8sdqzgWvzOXxFd?=
 =?us-ascii?Q?Lv1SmEIPEko+5Z1h2iAqdtT9uypKQeK/peQEq1Tda3jRjJRjGB0/8K8zzZyj?=
 =?us-ascii?Q?hD6DhmxtQzn8vRodRQ1D1BvZIeUXvzaWGWbd4yRLsyvySEZTHHwxSjKhBOGP?=
 =?us-ascii?Q?sVqY1qrnpKkR0sDheC4RaCEOTeY0ku6n40J1a+FUU6H7esGEzfYOjEGp1u3n?=
 =?us-ascii?Q?iyKtlaLNSXreEy9kZYQon/hI8dJaDqBZkVT6y2zwyE9pf7QitPsw7WsIBB0A?=
 =?us-ascii?Q?u7BQKI0Kj1U0ojUMzm56pDJnGk4Kru3KWAM3G2ix9Seu+e4J88AJ+38WkKEv?=
 =?us-ascii?Q?RXfHB/fmVJZ71IVT27tAZgBAgvhKogEeOmlAIe6dyxnBI+Odi1vJz6yVoXV7?=
 =?us-ascii?Q?pfG9+BtglrCAmnwEn6EFGB+/erWkU/5VwnZeB8CI+CHElLwsVLb203eha0Po?=
 =?us-ascii?Q?Xxk5exIEu+3Ffq6VK1Awy5luL+I8alakHCPQucC8gusNc5ixA3RQ6nv0OZEb?=
 =?us-ascii?Q?HOCFhDFd3DSqDfBxX4GpCjZKJ0exFokVBg+eJmopsfBRhfP2NCXKNKLGC/Xm?=
 =?us-ascii?Q?0v4N37zLNz9UaE2QQJEa7fpaKP0kzBEjuRzIEMC+clQhblvxw9FyWfbdjcP1?=
 =?us-ascii?Q?rG/TMitVqjjyhSU/Kex/L8WwFm2lzlK39dlkTOPJHrRYxMq7Y8WA8fwvxvZN?=
 =?us-ascii?Q?IpxnK7zzeYFjWcXMkQmgn7LfJXC/vcmTRCbVIzLQlEqC7BcB7ITl0V2uk52Y?=
 =?us-ascii?Q?GTbAcsAgW25IsgfVBEnwVxx8Vzp8tbKAb9GX+Fp7DS7eMEUqqnOtzZp8R2IS?=
 =?us-ascii?Q?3c0uXtXGUVGzUsUE9nUzZ1zhWceUcWKNVqAkCAHrnRWH8JcBIMJmQBnveYvU?=
 =?us-ascii?Q?arossLf9Uwt40EhxCqu0LOwM70tz6clqPv5BzBo/OI3/Gpc+hOVkxaJdb9mk?=
 =?us-ascii?Q?H16rd/B6b0OTdfulhfntoGcW/qAc+fdc5aQ1GHjYTaGSUgew4u5odH5UaTPR?=
 =?us-ascii?Q?VqiJYjgsKTsWztaWMMLU0ZGPkY8q4kw=3D?=
X-Exchange-RoutingPolicyChecked: QOvzOVTFJ01SQHmQh0lHHvXInREv2Txhx1DqiM2xgYI+ir7mSq7RtlSBrVnkw4QQx9we873teizHrdj17LERq4MHxtxr3xE6MQFrIfZMttD64+L9XETswpaynaH+G9TWw67tN09DHsT4MznFZA8zfYwviIIs7lt99Aw+81Wo0b1beIaITfiIOzDadYmUWtpTppCwk3BqMx/w9hxfY6QsXwqF37MEbezp+xOkYeMkEO0QguwM+nrm8MZgOcrrRDd8iIrj2Ot5OZtSXyl8Oj07QMZulim+V8os9SKdWF/XaU6cBozHZgpjGsRvgxjuv/SgZNMM9Te/Hdu6X4aUJpkbvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e33db840-8910-4bdf-e347-08dee8bec0d3
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:31:51.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YS9qAGsHP9IBVpYuHSgPUoiLdeGHAOHyhzHvjQupUmpSpvCDGDv+SEqeECi58S+uk9D6PJvdA7jJqvtsQveXgedCYZF7k5Yov+wziXYYiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-OriginatorOrg: intel.com
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

On Thu, Jul 23, 2026 at 02:55:54PM +0200, David Marchand wrote:
> The net/null driver is enabled in all our tests builds in the CI.
> Standardize on using net/null instead of net/ring.
> 
> This also removes use of an internal API.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - dropped dependency on net/ring, used net/null instead,
> 
> ---
>  app/test/test_devargs.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
