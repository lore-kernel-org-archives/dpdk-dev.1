Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B165FF885E
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D28402BC;
	Mon, 27 Apr 2026 12:43:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 131F6402B2;
 Mon, 27 Apr 2026 12:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777286598; x=1808822598;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FEpnOAelGWwssDtUVKhXFsFMjPCOEx8PZcU7ZGjsxSU=;
 b=RSM13YfUu7g/yi7R1QHbmFGaASOwQViU2TA9BxyPdMEZuG+Bit+vl4vi
 4s+aAh0v0qYFTiBmfotVQ1h9g0JfGLrElcBcNSjjs67URwk2BbmXrrzCT
 mzKZbQGFnTpUnEhl299e1p9YhiDjBzVxwuNTni8B47ezLPiObpI+oYV03
 KZaK0/VUUgEqNYzhU+3K/b/F8lVSADjrE866QzRdBge2VYi0tiReVoZ/1
 3bfsZXxAFW50rb4jrWLFcDoFcBtZQBATT7KDLGYOVDOAvgC3GFHKwZvF2
 o0Y1P2YihkxCgvOaQQLaXrc6oqxe5tFTlpPdVw4hDD8DzTpx7ABsCiSKA Q==;
X-CSE-ConnectionGUID: 6PuPaAH3RAyGQAAMIviTiw==
X-CSE-MsgGUID: QMX7YZABQK6TfTMUPYF15w==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88484641"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="88484641"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 03:43:16 -0700
X-CSE-ConnectionGUID: J9S1TpsuSwmRa3yWUrqFJw==
X-CSE-MsgGUID: RXbSD04kShivseUivHDpAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="237924337"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 03:43:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 03:43:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 03:43:15 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 03:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKxDAJLOI8RCigkVc+qdFYDRaehTMgpo9V2dkF/HkM128h1icEboP0ZLxIo2EhuqFkMQOKYeeY5RiddR7ImSjHolueRJpG7RzfquoGMOmXfnONjk4aRCXfEhIJ/O+RmyKCsGu9j7ZXtPIm22ZVVf0fcoCwizW+iuWRPN4KiuPcEa20foMbzdndpNSNqsZpASQpYiWKreK6KvZjCFZvmCGllTBRXmQqTNZctd/Unk0RJX5KVKFiDjyMkqnKOSsbAhVSJmg3noQVW3DENMq7mdU43jurgxHWBdR+ogRjADfcX/810vtd2e3ySt01ng6wQd7C/k1KUlk65lnzsiEkP32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTfrmcI/Z2fAFSYhP7Y5g71vUMMqiMtdFwrxeNiGfjM=;
 b=O2yFfboEy5DZ7nmEjg2SLjlX6QHDzvGGPmD/ZH3ChnJkb5iurHV8I0Pre15YXKbxaVqt8bOjT0VH+UeB5mp7BqRQuaK96DwE3MjI3mBzErh+rQqaOJhF4aOS/kG5PIHLa9DidVHDbkFyJ6dGAePGtf1jwRh1834XVo58MuhybHjRtPXkAFOuhtpPVuV5MVZqQMMnUtsVDvT9OL/8q/y0z+PUKVr2yADYINOtYMJC5Bp5R7tm20f+CPO8h1eOnwTHzvT3jOm3N1t83x/Qw75glpeVXof0nZ5YOki/1M0LY6XNoMuYhTzcNmZ+G4wzLAnzYhdTtMxOz3heZ50rnDfKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 10:43:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 10:43:11 +0000
Date: Mon, 27 Apr 2026 11:43:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "aman.deep.singh@intel.com"
 <aman.deep.singh@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] app/testpmd: avoid
 cmdline use-after-free on SIGINT
Message-ID: <ae89uiRN-SC40aR_@bricha3-mobl1.ger.corp.intel.com>
References: <20260427091055.22412-1-sunyang.wu@jaguarmicro.com>
 <ae80NGXJc7qgqoDA@bricha3-mobl1.ger.corp.intel.com>
 <KL1PR0601MB5567C08F8735C6DF18AF973F90362@KL1PR0601MB5567.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB5567C08F8735C6DF18AF973F90362@KL1PR0601MB5567.apcprd06.prod.outlook.com>
X-ClientProxiedBy: DU7P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a006b2-d1a8-40c6-20e0-08dea449c71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: yH1OICvIlaA7ArJg/Nd/BI7tFInwS3KZMxKALBQHvqYTfKAjb8baTrP84Fj7T1yiPhIR2LD89y2pubuKSIbPA9FITx96f7d0tcEyj58Z0vIuYPHSgaxo/ISh325cGr7v0+pMmL0EdJLgBljvCTBTciHNv3oaZ2hsm634A/I/SY1JnJualHUHCAef9Vb9YLIQVieSVjRhgMjhdgY/r7DarY1UeILfhkcImFKFIHsCOcRlnSlY4AehaPJ2+NPdj3rs3qZbPQ7U8Icx8Q1SauNVBUt1I3yOeUCm7rPaLWcokboPeoNc0NZrnJLpf+NjAp3wfFhkv+LdTI6pP+RTlS1KD5WSTBzJwAQc7mvh2Jv/iTLPVkSU0k2ZYSGv/I6k1FIK6740uBN7IyJna/kO8PB4SDddcFUgQ+ubgO/KyptEgYh1evxgJ6uK6G1ed1uNi5TJ6OW0GnXaD8n83CNumPpu5REW1yOOLCUbT62cyiQYq5lGXKg21qePM7SY+wwITpcT3zTRBxZAelDo9BCOQFIfretkyr9G9YHfrVb4B6w41DyRwyaKWmC+VvqNuW0aWHk7KeH5zPsr+ChBYLCNgI/JYN/r+MeTE+p3D4g13zQOYJKE9jttUh6DWBeDKqautwQAa/HpeXR7zYQ78h0EGNhPyNJMKGg3xipI+1Wg6YIPXrj4sCTRhyDl8tOZiYe8nOpyL54OVQY1hkC0twx698RQvsBGUaKuMvZFmxJjWGU3450=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MpdUQRjHtkhuRBpjBWoNpEb8wsZIF0BFXfxjjsVwdlkEpsqL6TSMfHLs0Tu?=
 =?us-ascii?Q?Rxv1oCD759Uq3Vc78BTKVNV2PDl/S5EhLSAnJE2NELrV5BXLc4Xy2WhbStHE?=
 =?us-ascii?Q?/udoQw0Hd1vLyY0NE25F7LSlsLMYT8sh53D6tP/3l1NOxex4jk3AX/JOId0K?=
 =?us-ascii?Q?Km7Oqz6wLvqdimbtyY6PcfoBrcQgkEmqFMr9ynym1Y0SBI3oLVuGhRl8bgQ0?=
 =?us-ascii?Q?TGHwmDWmCYad1ckk70AeQb7zgoTZixrookzjk1Z01RSCKjprYrJDNDJZJQ3g?=
 =?us-ascii?Q?bQIwwsE2IEzUrWaH666/v5q0cvc6u19fs5j0LUxGCvqgMqTJEh8585HXOoG5?=
 =?us-ascii?Q?9eGEPlLu819y2+RIstC/+piuvaceLG7eAznuNiDfqFwvRIcQu2mle8DtshE5?=
 =?us-ascii?Q?kGHSiO0qHm2yuISWnwdQSbqP1JQfcqv61IIDAAVC4Bg1QputtcmkLFGV0x1K?=
 =?us-ascii?Q?F3WeOb+DAr1jxh+G4LvEorBcaQWpJHP4C5HZgPLnIePrWU3TRAkSRwm/hMr1?=
 =?us-ascii?Q?Fh0ckNdqX+2qQMxQF5QsGwLao5a+pxDZ61sDZWHkIKXrh11b6/c7faSoOsFj?=
 =?us-ascii?Q?qo6uWg8Tsw4pcvtruwoTlPpU2/gxCYe21nfJMt6lMM/xHzMYfdsl1pRx+0Xc?=
 =?us-ascii?Q?LJWDU0w1J2FVXxaK4CEBudqxgh/ddtFcVXnu1RxoGBnMI4d7gxhao5cAvF0e?=
 =?us-ascii?Q?tc/CmM47HAiy//MlGTmbEZs5yrxdKzwshbNH80uT6UeimHI1a0NEYUbJ63Nm?=
 =?us-ascii?Q?3LfrE3N8iKPBz3Z/p4FLIBgAvJvdpq0HmK8pq04PMM9OJrr0Gs7YWygZYice?=
 =?us-ascii?Q?CRtbhedWlEgl1tIHAYCGEWSYfvk09mlV3D591wRt/m/fuEfK/9kKQPcOFoJJ?=
 =?us-ascii?Q?Xs1qeb5PnN/3C22PIfRMVohuSahYeVx3llObG2Mek1t8VZ/6CM9S59ByF3bl?=
 =?us-ascii?Q?luWJJciBnC8a7ylCvvsarbiTgm0D02B+rwl2syIoWtIuOkZjenVQQEl7xph+?=
 =?us-ascii?Q?+wTX5OMyU2Xku1dZsq0FHlIedDE5GD7gaIbOuE/5kXsZM3q6xJONo52zXlC6?=
 =?us-ascii?Q?QAEEN6P7kojZ14zBULoZuN7+j5Vrz58HowPgJfMOSeYiC5Cz7cLvrH6iPc8U?=
 =?us-ascii?Q?jVbiQJs/DlHL41BdYcn8P6Ppp3p9CUbaFDj52YXkpyzmzGea6DyHkuBRio5g?=
 =?us-ascii?Q?hOjNdMUIXPQ9Rz06rOa/iKVmZ2QUUXoY2JSKv8WWcUwWlBHgyFP/64a3u4oD?=
 =?us-ascii?Q?/73bih7TBimbUcVMzQgGLpMDlAGkj7QoCZHfdxhvOCVPX+V2ppFyGXPLX0t6?=
 =?us-ascii?Q?DEsLGhis6lf+4ZGmsa9eDsQh9yi8XtTjka4e05rrsPU2f7kWQ2MUGXiCGrnm?=
 =?us-ascii?Q?NmbKFAghcEauEssqjkuKUr6Xu8OwbdXrPxtv6STNuhSDJWbc0AKFt1foQ1Au?=
 =?us-ascii?Q?wr5UNnxXTLG1E01+at2ouGcNHNAAEUXIlYgc0CWKQjLkvzreRpDWSumgeR4M?=
 =?us-ascii?Q?PaA+CcG+vRAiQaN4w13NWI9YzP8WhZNKGEGFe8xkQi8Fcu3n414/G+oEOv5G?=
 =?us-ascii?Q?00g1ZxSzifIEhadFYBx2IqjLQv4DyRCiW60wGI2B85v7tMsI7BY6pr78ZvJn?=
 =?us-ascii?Q?LaGfeBQglhnpl58lB2tED+zfSLjnA1s8A8MtKfHv2UOnhMpjXQDRFo1hsNp+?=
 =?us-ascii?Q?CLTeLSkrZ3QzJPuu00O+N11eNLjpudD8nhXgLBVKdCilHHwc4bvaF6yYRNc1?=
 =?us-ascii?Q?SBsppnM6lRlCP3Umf/RXmPtMlNabUGo=3D?=
X-Exchange-RoutingPolicyChecked: MtV9c9D/zMcXBnvaxBjk0nrvqvOAZPxGvZRbB4Xy6vTZ2aqJfY1PbCKf41DMCxZr4SGfpY1IlahEQpG3POT4n6NQPccWMqXiPvLeSv0an7dw/JvLGJVlcCYCKHb9VMa1shhv0CAybnnCCqiYEor9BYWbtA1eZj1IBGtACHi5FIWYF3TsfHYsEC2lrENQx/MeowPCSZwTo9fp/+8vjoHnAd2M1tM4U0qxratgiEQtKy+EYJ7jDKiQffbxsPs6uxpcqTM94eAbR7QVZSgmZm74XI4veFf1p8vAeE3RQPnictKH9uLcu5WHq+SHcSamyrlfqPT3HPcBc9MZirLahK4KTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a006b2-d1a8-40c6-20e0-08dea449c71a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:43:11.4334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2nkfc9q0PN+C74kD+J4KCUt3aacbOpu42mnT5f/4fi6Sc0X3JUtPzp85MbHG7mN65mbuXAoJelAVbQ+0VQLYptO44o1kXv9sZvjwAWX05E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
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

On Mon, Apr 27, 2026 at 10:33:42AM +0000, Sunyang Wu wrote:
> Hi Bruce,
> 
> Thanks for the review.
> 
> I do not think a memory barrier alone would be sufficient here.
> 
> In the intended case, prompt_exit() is used from the signal path to
> interrupt the thread currently running prompt(). In that case, the
> NULL store is already ordered before cmdline_stdin_exit(). However,
> for a later signal or a signal delivered to another thread, a plain
> barrier would still not make concurrent access to testpmd_cl safe.
> 
> I think the better fix is to keep the existing prompt_exit() behavior,
> but use a local cmdline pointer for lifetime management and atomic
> load/store for testpmd_cl so the signal path cannot observe freed
> state.
> 
> If this approach looks reasonable to you, I will send a v2.
> 

Sounds reasonable to me, but I'm not an expert on the behaviour of weakly
ordered platforms! I think do a v2 with your proposal anyway, since it's
likely an improvement over the v1.

/Bruce
