Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B2C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 14:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83D7B40270;
	Mon, 24 Aug 2026 16:47:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 16038400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 16:47:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787582840; x=1819118840;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LKeWDZcVKTLt0uDoXBuzYjKu5h0isVvenRGudeKNbCc=;
 b=KXdbjhzzqwQtUQv8bqv5LeOLqzrDNyYNCDqmqCiTxfsOMDpAQu7GBEx4
 tSEVPF0qS9Ahh35ux3vPQAf39bBHMBXTG85jGsmR4GQvZKjA4CkUTZBwn
 56f/6Sr1EPxpr0nQkQw/ecqONtTrquxtWofcnk+2UTB4nVz5nGssNOl4i
 qr3X6V1NNVXAMEdhPmcTqEqjBAtY7/LXCvUlmYN3kvTkAG0pH02dU+LyY
 ILynqMvgy1bV8vRPZi/UL03UjxGKo4iHuEK/v53386e0qLw8Mmc6c7CVV
 9jBj5r0/HZuRW55TD6SXZXkBgZEd5KkNHenOb5DiXmMBxTF6+WsmAe/E9 Q==;
X-CSE-ConnectionGUID: 0PASoQpgTEmhYtfT75dtKQ==
X-CSE-MsgGUID: xxi8oq9TSaCNR3mzuqijXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98370399"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="98370399"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:47:19 -0700
X-CSE-ConnectionGUID: GZWOqP3BTw6THSsaClIHMA==
X-CSE-MsgGUID: sKXPR105T2O1s7aMpbEWcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="291861449"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 07:47:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:47:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 07:47:18 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 07:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru6jIEA8nNEpnooIKHtTmIqcGyd66GRDKxC8JRfyER35Vz7B2kbunqOXf/FHleC3dIjTOBHWVs8fyzp7ACYOcca8XIwwIEGTWR7OqjqzpOUmqBGAUZjXeBENETIUy1MK3AnQCwG7bL+E4WFf+jDYspwDDHajTyL96zoDkbs0vUKBz8lzcF3D7ayi4rUIOLkxGbzDJ4h5cxOI0iSfP9kKffYBjoA8rRTxf6X870kkgYDyg2+SQFou2zHUzPfuy676WDQdfvfH1NnIIfqAw075/jVqfExN0DVZj9i0O1Jbchp+DXJdu/F8KnE9YXsTglGMpvg6cPkjnLqdShhAxM1atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBbNMbvqxMkI0EF+7wMvWDyYSl0sGdZtLj5dOy/tcc8=;
 b=Al7ta2h4zuE46QYaFC26rkrmZAVqLmiZWyUuCeFT3yI//+NTvCT+btEef1kf0PtLsJyG8GiQhYSYjs7G8uiNBbWBjSTTCUI1LMixn/Qcquhvmve89HQ7mbC4QsYzrw+sjYDYB5wEFq00RPV0ojc+zlNurKSbrdXmiefxsSAjF5YjpSYhJKsUgZ0qnFe9L/0mPWxBg9FXf+efD948RtLFvFv4xyRM9J/jOHYovwZwi3iqgutRalSV7oUKfOyvtgG3WXqmXO/0yguj8LUE4qf1Qq9zRt4vGJSbXEBcJeayyTCTVck6hmop1hMq7mfrprfXmx6xIyS3i77a6A/cmZ9hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ5PPF5DFCDEDFC.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:47:13 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:47:13 +0000
Date: Mon, 24 Aug 2026 15:47:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 3/4] net/ice: add AVX2 context descriptor Tx path
Message-ID: <aoxZbXfVD998ewbp@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
 <b4330095555cd8da32f211062bca072348c98b3d.1787566677.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4330095555cd8da32f211062bca072348c98b3d.1787566677.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU7PR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ5PPF5DFCDEDFC:EE_
X-MS-Office365-Filtering-Correlation-Id: d242a0d2-ccf1-4fc8-b955-08df01ee9548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|3023799007|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: kcugERU1k34nEuTp3pCsLnNHQ/SC4qtF8gHKPwTcYeBfNbyo3qDomIY2ENevTg12rWnqxtm2bRvG+XaCgl478KbB/ph97HDgksNzkYqPuUswNoBACip3fs/mtt7xJKbgWtL/ivgM2Q4LNZNJ/3PgLbUyiygZ/9ziAKwMd/UlZnDPk1wltHEE9AilBH4cf/qMF+ZggZd4Xtlm+f2aYwuyP/StyQ0apAvgOEiRQ6nTVjEXwxpegTx7I9+Ar0ZpYy6/S6E54p7Z/YGO2P3OyE8JWb1NIn2FFcgFJeC/2Ylw8tmfEXH0AcmTb1hoRqezsskbcUk8+YZXQH5tNabRL5iXFi5aRgrylHZwxamX6sZRQuiTH+jcVAQfZMNulSpmZ/3T3+OhTJ+GDD45Ox3x+aKztKldMimO1CYR4bJo/U6LAod6tX0XrGIQF0BOzAsA8uozXMN97yRCVXIKayFJipV9zjg8y4w8/22v9fMGq9FBGCQee2XtLMEGf+6bqgb18rMA30i0lSq/aytNVFiyFHmC/NlM0PI5qUsr/dL8QwkDnB58qKgwFxpd1B8wg1pYSkXDeqOM/qQYdl8q18I+xt/NMN7gD1Sue/Xi1SAUQaw/ZRq9Rgij1+srFp9Xu7/ibtJND7vDC/m04MwqvOYkXLF7R2mBlx0dqFkUmamdU1hyBxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(3023799007)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxVTlpyc2RnUHVTVHNDcVJ3eHp3VnJ6Yk8rVTFBUEg4M2hXc2QzL0pUUnNH?=
 =?utf-8?B?ZFZacEJZSUQwNHhSVGo2ME5IRVA5ZUlxQ3dMUG5FbWUrQkN4OVlPQ3RGeWJ0?=
 =?utf-8?B?L3ZzcjlkcDVlRzNCUGVUc1ZzR01YeTRNbngwODNDRlg4eGhOUzEwYXlYWTRQ?=
 =?utf-8?B?Mll3MjdzTFBXQjdIcWE2NlY5RG5Sb2YvRU1aQ0ZuTm5wUGozUG9ZZ3ppOU0v?=
 =?utf-8?B?Q0VrY0VBNW5ja20zaHUvOHVCQUl2eXk0YTM1bTF0Yi9XSFRxelJ4YmhxRnox?=
 =?utf-8?B?UGNoUHpLU05xcFZxcitxQnJrdHk3RnZmcmc4VEVlNVVrallPODFwNGRjcEFv?=
 =?utf-8?B?aFJSMytaTWZoV3J3Wk9panJuS0oycUxWM2xWa0I1SDZJS0phblY0eUNtUk9Q?=
 =?utf-8?B?cjc4SFJhNW9tVUxUTjZqTzUxMDZzQ3NsVVFVTzQ2S3V4WlNaWlVpeXhycFZv?=
 =?utf-8?B?cUk2dEM2NFNESEhoR0RFRXdDM01NL0NjQUdkMU9zYmlRRGl4THRRK1R4UmEz?=
 =?utf-8?B?dDBrNjYzMnNYOUZ6SkVVVUtTL09OU05xUFhTVGpwWm9UU0o1RkEzQjFDOHRv?=
 =?utf-8?B?RzFya0FkaDFycERPRnpSb2czZkdvMDRBRVVsaTNpTzlNSU1xaUE0bnBocTZ3?=
 =?utf-8?B?Z2pGMS9kOHNJMmJqNVgvZkZ5dUxzeWt4NGgrUnhLaURHai9hOVlGZ09RRmJD?=
 =?utf-8?B?bjhxNXlBRmFnMWs5WWVWMFhmSjI2NXIvbGF3WjRpZllHV29saTh4ZE1CVnc3?=
 =?utf-8?B?and6UElhb2pZandsZFRCaE5zZXM0dU4vK3diOCsybW1DTmxFSWhXaUtzam5L?=
 =?utf-8?B?WURhV1k0Tm8rYkFzSEZXM04vRENBdW4wRFFVVklicWg4cCt1ZlJjTkNjd3c1?=
 =?utf-8?B?cU5WbEVwQWFkWnQ5MVlURE43WFJSZkVCS2V4ejFmUnQrQ2lBVG1vdkxraHho?=
 =?utf-8?B?TEhtakRkbE84TG9rL2I0Nm5XcVhlU3p6dG50VXJjTXVkTEloNlEyT0p1TmlE?=
 =?utf-8?B?RmY3ei9ENmF4Q1B4QzVtUThFRFZ4L0trdVEvOThDZ2xHVkxEVWNLR3NVU3dU?=
 =?utf-8?B?SEZSY1J5TmtzVC9pWFJoZktSd1dPNzMzWmQrUjFETWh6L2NTeU9JN2ZOWHFo?=
 =?utf-8?B?MStsNy9LSmhnRHYyQmhFc215VitmR3pFTUkva3UwbkFtWmZreEhzMDA1UU9U?=
 =?utf-8?B?YnB6Wjh6T1hQL1NhaU5idU9TTFFlMW5ickMyMzY0OFFKenpOZ3R5cGw3blc3?=
 =?utf-8?B?U015a1Y3VTN6My9KSDBycVRuNklURHdQUVR1WTAvMGZpTkdQOS9EV2pUL3ZV?=
 =?utf-8?B?V1ErN2dGSDlndFpEQ3NGcXI3LzVoMExmK3ZaMGFqcFB1OExiT1RldnN5anRk?=
 =?utf-8?B?RjlZRFE2ZGttKzYvZUtydW1wekp5aVQ0eHp3Y3hOdHh2V2ZLUGVuWGZSQzhV?=
 =?utf-8?B?S1dSbUdoS2I5aHJjdkpsNUtvRGhLTEJQT0hKazRiYno0UDEvZ1AwQ0YyUjc5?=
 =?utf-8?B?WWY2RWpaN21wWHV2Z2pGaVA0RE9XaDhZbTdVaGVQOGpVVmtYOXR6VlFOa1JL?=
 =?utf-8?B?aVVaNFlaN2JDOVV2cWljMi9yWnZFeXYxRDA4VTQ5UXdnVTA5RnNYdG0vUU1S?=
 =?utf-8?B?TU9kT0FlQWxUNURuc25XWGY1dWJabHNreStSYXF6VVY3eTlDdTB5cFhhaENK?=
 =?utf-8?B?WWhrZ1Y5QzZJTWxWUUZkaSt4LzEyN0VGY01CaEpScE5ZY0pLT1IvYVBZVXBy?=
 =?utf-8?B?alhVdHJuRDZXajVuK1FHbStCUzZLa2hIYlV4d2t4Q3N1Wk4yUEFmWS9aTFR1?=
 =?utf-8?B?UU5CUVRuSVFEUUJDaXVrNDE0ZE9aa1NCd3NkTWdGSUpwVmlJRElGM0sybDVH?=
 =?utf-8?B?RTBVM1I2UUR2anRTc1dOeWZwaDJGcW5QV3BrdFYrWHdiNlB2c2R0bkhCYlRD?=
 =?utf-8?B?TzRQSEkveSt3aTlPcWF5YXRKWURXODV4WEIzQnZnUUxEOS9pSTNPMWtsVUJz?=
 =?utf-8?B?UjBxSDlsRWJEWXpsR1BodkNNeFpCRlFYd1ZWS1NDcjBYRjJsdTlCMkRVeS82?=
 =?utf-8?B?bUpGRzUvN0tvU3dDZFY5ZGRPRGZ6dnQ4REwzZ2dsVkNkV2RENGtTby9Rd3lx?=
 =?utf-8?B?aGVGMGNpakhOTWtRYThvOUxTNGs1aTVyZGRseTN3TGpIYVZkaEFKVFV3UllZ?=
 =?utf-8?B?cmR5Mjg0SXJYaGlWcFU5NU54TGVXNG1WckJzbTVxSnJhS0llbXlwYk54M1pJ?=
 =?utf-8?B?d3NhakRSdGxRaWI4TzU3Vyt6bXBXTDRwQk1vRUpVM2xjYXIvdHhDL0dzYTZC?=
 =?utf-8?B?LzUzS2NZcU1vY3oxbzJleFFNcmd2L3J6a2J5cVZOS3Fnbnkzd0ozQno0ZlJl?=
 =?utf-8?Q?zH2Fvshyc5h+D4T8=3D?=
X-Exchange-RoutingPolicyChecked: yoJN9fod9O/wGs2e1omKftbbmFIJaSQ1lHWkmJXXgpvHzS7qDldF+ikq8hgZPZgvUBl9FWz3xMvzyaUYW+tx74nQ4s3B63s269nMidH27wOkys0M2K7makMHAPUFj7AbT43SVrd0qT+BC/N7wmcfKKcqWoPAyFGfvcPxFVa7H6UZRaaHJ02bEgFcGHWco58gF14fZYvXc34Q7zVD5p9DObudFqFDRc91b7t7QOp3GnvFw7XUUp3VvBLI0nnwp1EKgUG17j7mUwGEITDc35CaUs+Vhq9yic+tRBCno8G+HqkG0m6vnv1DRuulP2Xwy5PKeoKGI+kWUlaUh7ryG/PT3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d242a0d2-ccf1-4fc8-b955-08df01ee9548
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:47:13.0595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF1j5oxxirSDhYUcBgxlUVpxw3iVjS10Y6sm1WJzsHSxawOf+VMr/Qavq1krpQGSCCysj1x1EbEHE2hkwS4XLeAWkqUsd3NHYu0h5sdogak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5DFCDEDFC
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

On Mon, Aug 24, 2026 at 10:21:53AM +0000, Anurag Mandal wrote:
> Added an AVX2 context descriptor path for tunneled
> outer IPv4 and UDP checksum offloads.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/rel_notes/release_26_11.rst    |   5 +
>  drivers/net/intel/ice/ice_dcf_ethdev.c    |   4 +-
>  drivers/net/intel/ice/ice_ethdev.h        |   1 +
>  drivers/net/intel/ice/ice_rxtx.c          |  31 +++++-
>  drivers/net/intel/ice/ice_rxtx.h          |   8 ++
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c | 119 ++++++++++++++++++++++
>  6 files changed, 163 insertions(+), 5 deletions(-)
> 

I asked AI to take a look at this patch and review it by comparison to the
existing iavf driver. Here's the output, most of which seems relevant.  [It
also is flagging an alignment change that could be fixed in iavf driver,
but that is a separate, minor issue]

Please review feedback below for a new revision. Ideally, I'd like to keep
the ice implementation as aligned as possible to the iavf one, so we can
merge those code paths in future.

/Bruce

Review: net/ice: add AVX2 context descriptor Tx path
Errors
ice_tx_queue_start does not set use_ctx, so runtime-added queues get the wrong value.

ice_set_tx_function iterates all existing queues and sets use_ctx. However,
ice_tx_queue_start (called via rte_eth_tx_queue_start) does not set
use_ctx. A queue added at runtime after device start will have use_ctx =
false while the device burst function (ice_xmit_pkts_vec_avx2_ctx_offload)
treats every queue as using context descriptors. When that queue is stopped
or released, ci_txq_release_all_mbufs(txq, txq->use_ctx) with use_ctx =
false iterates physical descriptor indices into sw_ring_vec, which is sized
at nb_tx_desc / 2 — producing an out-of-bounds read on the sw_ring_vec
array.


iavf avoids this by checking txq->use_ctx in the Tx burst path itself (it's
set at configure time from the per-queue IAVF_TX_OFFLOAD_CTX flag). The ice
implementation sets it only once globally.

Warnings
Outer IPv6 tunneling (without checksum offload) skips the context descriptor path.

req_features.ctx_desc is set only when RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
or RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM is configured. An application that
only uses outer-IPv6 tunneling (no outer cksum offload needed) will not
select ICE_TX_AVX2_CTX_OFFLOAD, and the hardware will receive no context
descriptor with the tunnel type or outer IP type — even though
ice_txd_tunneling_ctx would encode them correctly. iavf triggers use_ctx on
any per-packet RTE_MBUF_F_TX_TUNNEL_MASK flag at the burst entry,
regardless of device-level offload configuration. Whether ice hardware
needs the context descriptor for outer IPv6 tunnels at all is
hardware-dependent and should be documented or validated.

No validation that tx_rs_thresh is adequate for 2-descriptor-per-packet mode.

ice_tx_vec_queue_default enforces tx_rs_thresh >= ICE_VPMD_TX_BURST (32).
In ctx mode, each batch handles tx_rs_thresh >> 1 packets. With
tx_rs_thresh = 32, that's 16 packets per burst. No check ensures this is
above a meaningful minimum. This is a weak warning — the current minimum
(16 packets) is still functional — but it's worth a comment.

Implementation Comparison (new ctx path vs iavf)
Aspect			ice (ice_ctx_vtx1)		iavf (ctx_vtx1)
256-bit store		_mm256_store_si256 (aligned)	_mm256_storeu_si256 (unaligned)
Context desc high word	CI_TX_DESC_DTYPE_CTX only	DTYPE_CONTEXT + optional IL2TAG2/LLDP bits
VLAN QinQ support	Not handled in ctx path		Handled in ctx descriptor
ctx_desc triggering	Device-level offload flags	Per-packet ol_flags at burst entry
use_ctx set per-queue	Only in ice_set_tx_function (device start)	Also maintained per-queue in setup

The use of _mm256_store_si256 (aligned) is consistent with the existing
non-ctx ice_vtx loop which also uses aligned stores, and is safe because
descriptor rings are cache-line aligned and tx_id is always even in ctx
mode.

> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 907f9013ff..8ce1875843 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,11 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel ice driver.**
> +
> +  Added an AVX2 Tx path using context descriptors, allowing tunneled outer IPv4
> +  and UDP checksum offloads without falling back to scalar Tx.
> +
>  * **Updated Intel iavf driver.**
>  
>    * Runtime Rx/Tx queue setup is now automatically disabled while a
> diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
> index c78b290b0d..d1cdae6eb9 100644
> --- a/drivers/net/intel/ice/ice_dcf_ethdev.c
> +++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
> @@ -498,7 +498,7 @@ ice_dcf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	}
>  
>  	txq = dev->data->tx_queues[tx_queue_id];
> -	ci_txq_release_all_mbufs(txq, false);
> +	ci_txq_release_all_mbufs(txq, txq->use_ctx);
>  	reset_tx_queue(txq);
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
>  
> @@ -648,7 +648,7 @@ ice_dcf_stop_queues(struct rte_eth_dev *dev)
>  		txq = dev->data->tx_queues[i];
>  		if (!txq)
>  			continue;
> -		ci_txq_release_all_mbufs(txq, false);
> +		ci_txq_release_all_mbufs(txq, txq->use_ctx);
>  		reset_tx_queue(txq);
>  		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
>  	}
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 7ee3ea8a70..0e74f8d776 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -213,6 +213,7 @@ enum ice_tx_func_type {
>  	ICE_TX_SIMPLE,
>  	ICE_TX_AVX2,
>  	ICE_TX_AVX2_OFFLOAD,
> +	ICE_TX_AVX2_CTX_OFFLOAD,
>  	ICE_TX_AVX512,
>  	ICE_TX_AVX512_OFFLOAD,
>  	ICE_TX_NEON,
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..5ec0b4d1fd 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -1193,7 +1193,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  		return -EINVAL;
>  	}
>  
> -	ci_txq_release_all_mbufs(txq, false);
> +	ci_txq_release_all_mbufs(txq, txq->use_ctx);
>  	ice_reset_tx_queue(txq);
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
>  
> @@ -1256,7 +1256,7 @@ ice_fdir_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  		return -EINVAL;
>  	}
>  
> -	ci_txq_release_all_mbufs(txq, false);
> +	ci_txq_release_all_mbufs(txq, txq->use_ctx);
>  	txq->qtx_tail = NULL;
>  
>  	return 0;
> @@ -1744,7 +1744,7 @@ ice_tx_queue_release(void *txq)
>  		return;
>  	}
>  
> -	ci_txq_release_all_mbufs(q, false);
> +	ci_txq_release_all_mbufs(q, q->use_ctx);
>  	rte_free(q->sw_ring);
>  	rte_free(q->rs_last_id);
>  	if (q->tsq) {
> @@ -3554,6 +3554,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
>  		},
>  		.pkt_prep = ice_prep_pkts
>  	},
> +	[ICE_TX_AVX2_CTX_OFFLOAD] = {
> +		.pkt_burst = ice_xmit_pkts_vec_avx2_ctx_offload,
> +		.info = "Context Offload Vector AVX2",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256,
> +			.ctx_desc = true
> +		},
> +		.pkt_prep = ice_prep_pkts
> +	},
>  #ifdef CC_AVX512_SUPPORT
>  	[ICE_TX_AVX512] = {
>  		.pkt_burst = ice_xmit_pkts_vec_avx512,
> @@ -3755,11 +3765,17 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  {
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	const struct ci_tx_path_features *selected_features;
> +	struct ci_tx_queue *txq;
>  	int mbuf_check = ad->devargs.mbuf_check;
> +	int i;
>  	struct ci_tx_path_features req_features = {
>  		.tx_offloads = dev->data->dev_conf.txmode.offloads,
>  		.simd_width = RTE_VECT_SIMD_DISABLED,
>  	};
> +	req_features.ctx_desc = req_features.tx_offloads &
> +		(RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
> +		 RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM);
>  
>  	/* If the device has started the function has already been selected. */
>  	if (dev->data->dev_started)
> @@ -3785,6 +3801,15 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	ad->tx_vec_allowed =
>  		(ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128);
>  #endif
> +	selected_features = &ice_tx_path_infos[ad->tx_func_type].features;
> +	for (i = 0; i < dev->data->nb_tx_queues; i++) {
> +		txq = dev->data->tx_queues[i];
> +		if (!txq)
> +			continue;
> +		txq->use_ctx = selected_features->ctx_desc;
> +		txq->use_vec_entry = selected_features->simple_tx ||
> +			selected_features->simd_width >= RTE_VECT_SIMD_128;
> +	}
>  
>  	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
>  					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 999b6b30d6..37e346fe39 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -136,6 +136,11 @@
>  	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
>  	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
>  
> +#define ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (	\
> +	ICE_TX_VECTOR_OFFLOAD_OFFLOADS |		\
> +	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
> +	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
> +
>  /* Max header size can be 2K - 64 bytes */
>  #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
>  
> @@ -284,6 +289,9 @@ uint16_t ice_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  				uint16_t nb_pkts);
>  uint16_t ice_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					uint16_t nb_pkts);
> +uint16_t ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue,
> +					    struct rte_mbuf **tx_pkts,
> +					    uint16_t nb_pkts);
>  uint16_t ice_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
>  				  uint16_t nb_pkts);
>  uint16_t ice_recv_pkts_vec_avx512_offload(void *rx_queue,
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> index b72f69a47b..88a3dfb1b6 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> @@ -837,6 +837,125 @@ ice_vtx(volatile struct ci_tx_desc *txdp,
>  	}
>  }
>  
> +static inline void
> +ice_ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
> +	     uint64_t flags, bool offload)
> +{
> +	uint64_t high_data_qw = CI_TX_DESC_DTYPE_DATA |
> +			(flags << CI_TXD_QW1_CMD_S) |
> +			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
> +	const uint64_t low_ctx_qw = offload ? ice_txd_tunneling_ctx(pkt) : 0;
> +
> +	if (offload)
> +		ice_txd_enable_offload(pkt, &high_data_qw);
> +
> +	const __m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw,
> +			rte_pktmbuf_iova(pkt), CI_TX_DESC_DTYPE_CTX, low_ctx_qw);
> +
> +	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
> +}
> +
> +static inline void
> +ice_ctx_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
> +	    uint16_t nb_pkts, uint64_t flags, bool offload)
> +{
> +	while (nb_pkts) {
> +		ice_ctx_vtx1(txdp, *pkt, flags, offload);
> +		txdp += 2;
> +		pkt++;
> +		nb_pkts--;
> +	}
> +}
> +
> +static inline uint16_t
> +ice_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
> +				  uint16_t nb_pkts, bool offload)
> +{
> +	struct ci_tx_queue *txq = tx_queue;
> +	volatile struct ci_tx_desc *txdp;
> +	struct ci_tx_entry_vec *txep;
> +	uint16_t n, nb_commit, nb_mbuf, tx_id;
> +	const uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
> +	const uint64_t rs = CI_TX_DESC_CMD_RS | flags;
> +
> +	if (txq->nb_tx_free < txq->tx_free_thresh)
> +		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, true);
> +
> +	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free,
> +			(uint32_t)nb_pkts * 2);
> +	nb_commit &= (uint16_t)~1;
> +	if (unlikely(nb_commit == 0))
> +		return 0;
> +
> +	nb_pkts = nb_commit >> 1;
> +	tx_id = txq->tx_tail;
> +	txdp = &txq->ci_tx_ring[tx_id];
> +	txep = &txq->sw_ring_vec[tx_id >> 1];
> +
> +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
> +	n = (uint16_t)(txq->nb_tx_desc - tx_id);
> +
> +	if (nb_commit >= n) {
> +		nb_mbuf = n >> 1;
> +		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
> +
> +		ice_ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload);
> +		tx_pkts += nb_mbuf - 1;
> +		txdp += n - 2;
> +		ice_ctx_vtx1(txdp, *tx_pkts++, rs, offload);
> +
> +		nb_commit = (uint16_t)(nb_commit - n);
> +		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
> +		tx_id = 0;
> +		txdp = txq->ci_tx_ring;
> +		txep = txq->sw_ring_vec;
> +	}
> +
> +	nb_mbuf = nb_commit >> 1;
> +	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
> +	ice_ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload);
> +	tx_id = (uint16_t)(tx_id + nb_commit);
> +
> +	if (tx_id > txq->tx_next_rs) {
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
> +			rte_cpu_to_le_64((uint64_t)CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
> +		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
> +	}
> +
> +	txq->tx_tail = tx_id;
> +	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
> +
> +	return nb_pkts;
> +}
> +
> +static inline uint16_t
> +ice_xmit_pkts_vec_avx2_ctx_common(void *tx_queue, struct rte_mbuf **tx_pkts,
> +				  uint16_t nb_pkts, bool offload)
> +{
> +	struct ci_tx_queue *txq = tx_queue;
> +	uint16_t nb_tx = 0;
> +
> +	while (nb_pkts) {
> +		const uint16_t num = RTE_MIN(nb_pkts, txq->tx_rs_thresh >> 1);
> +		const uint16_t ret = ice_xmit_fixed_burst_vec_avx2_ctx(tx_queue,
> +				&tx_pkts[nb_tx], num, offload);
> +
> +		nb_tx += ret;
> +		nb_pkts -= ret;
> +		if (ret < num)
> +			break;
> +	}
> +
> +	return nb_tx;
> +}
> +
> +uint16_t
> +ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue,
> +		struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
> +{
> +	return ice_xmit_pkts_vec_avx2_ctx_common(tx_queue, tx_pkts, nb_pkts, true);
> +}
> +
>  static __rte_always_inline uint16_t
>  ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  			      uint16_t nb_pkts, bool offload)
> -- 
> 2.34.1
> 
