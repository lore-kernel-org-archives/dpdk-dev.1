Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0FBC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 20:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B14924025F;
	Wed,  5 Mar 2025 21:05:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 78EB740156
 for <dev@dpdk.org>; Wed,  5 Mar 2025 21:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741205113; x=1772741113;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=arTVK9bH8OcK2ay+XmybCaxBe88A//gN2OiKBJsa0cA=;
 b=IlY2eUJZsijkrLVzrEGWW3y+MZsbsbyFSOX746oqGER42m2D70Ahqini
 M1REWFaGG7INJlOTxVsNzYRfWZDoPqLwlv4yod6haYmeRkAc3rxhMyn9S
 UNuQPNYvL7QDKSYF4Ajgs5UZJ6gdNuc08qMR+bAy6+/m10xCfvRYKmmyl
 gR+agKozKy3S/oa2wkyYY68KlfOPOxUa68cAueii1Iw74Y7d0oI9kelKA
 h9nnslfIEWk0nD6eWf3hma2yMA/Y7ScC3zV64i42DWQkyHu7EzEJIAw1d
 X9kZqLx3h7lBT2zoo9snDIVT4hwvCAGhLfVd0SDBn49o46nPju1FzsACC g==;
X-CSE-ConnectionGUID: bdlxEqZxT+a2ck3szHzWAw==
X-CSE-MsgGUID: inS+ZhiuQo6aKQZyMajr8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46115016"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; d="scan'208,217";a="46115016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 12:05:12 -0800
X-CSE-ConnectionGUID: twkjIDzDQXSOzeZHbBOmLg==
X-CSE-MsgGUID: 3e+otEWfQCKjo4l9z8BDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
 d="scan'208,217";a="149560989"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2025 12:05:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 12:05:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 12:05:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 12:05:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUkhc07rUkSB8stHIpi5xFqdxtZtdKeJl6FLSH+sJGvJHDlKk+9gWDmev6ETuu/lkJoSTit1FnXkbp67ofomjIO3BgdotTBxCCUMa/qHnJPQGLrSKmdpc4ddrFjsuj4nzbJQ3O1QO6H2iPxff0W3i3jsgsfZpHdR2VfMHrE8jWgYW7JSzLZposbWOP/vdNF7cEptICGMwGWDco5gPKQljYJTb/2wTKOdlosa56Xf95O70EjD/2UzZrCFcslv/5AHTq0ztRlzZIDA0WA9/QPTqIYANnRytC5IVwCr+t8tJ0Vfe4Od6pud9v+JHY1UemlzwAOTiF808Mw5D9W8/y4jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j0wnV4jhOjeUuP4+XBfrciH4Y2DRLPf5k2CRAWt1PY=;
 b=rWgx9jyUHvOyb0qdomZfDQOp1lUIEw6FmQit6Yf3wqvOHBK5NSMOQShyzbyReVsAql/iyysCXYlV+LBLMm1sIh6gMrHmP7i82fBLigALM1qawZHVvbvMF6KVccxbfAQiNBJXPwKHDZ4lxsBb+KyszpJP/mG8L14spZJDL+OrmvVex1A5kl6x4GqV8AWrPjZ3XBsXSueU46yTW+IStCaaXXX53T0nR14NwYAFGUIX1BymAWib8bVfxcBPgSsd2kXdZrZvft8SorWIrbUoRMTDanpOlW5aXWK2MCNjebfXIPl+T1x6mqMlKC9+470j9Jtc1Luq0ISasjJ/yQEDKIUYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 20:04:53 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 20:04:53 +0000
Content-Type: multipart/alternative;
 boundary="------------cNLhPMok0UU3SULGD3ss07MQ"
Message-ID: <0513cfe3-ea93-42f5-b052-20df56fc7127@intel.com>
Date: Wed, 5 Mar 2025 20:04:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] app/test: fix stack overflow in lpm6_perf_autotest
To: Andre Muezerie <andremue@linux.microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>
References: <1734057571-20367-1-git-send-email-andremue@linux.microsoft.com>
 <1734535286-27267-1-git-send-email-andremue@linux.microsoft.com>
 <Z8giob2jGIcDvltC@bricha3-mobl1.ger.corp.intel.com>
 <20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU2PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:10:232::30) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6d3685-c6cf-4891-017d-08dd5c20fe20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REdBRWZBUVRnN1VVcWNETitVZCtMeWdmendBQWdXVm1GS1JiWGVqNTVteHpx?=
 =?utf-8?B?QjFMdFY3NzlFKzg0WmZ5Rkt2ZFZlTFFZMTNIR0NKOXJSSmcvTzAzNTJtWXVM?=
 =?utf-8?B?ejhjSUJxZW84djJGZENFOW5ta2MxeG9UVnI4QWFJZ2h1QkNrWnhNSG50bGxV?=
 =?utf-8?B?OEdtL3NiRk03cjlwdVlWUXZkUlVQUXQ5NE9GeVZEMkVFbDM1VmxIMzRTTGNj?=
 =?utf-8?B?MHpTQkVET1Z1SzdSSm9EZU5TQVlXLy9YVVFsbjlLd2RVRzBxSXpSTXJUZFdP?=
 =?utf-8?B?OWdLaUdGVHhEbDJwLzVLTndneHMzbW4wVHJQenZjS1o2dGVtMGpNZUh3VEJC?=
 =?utf-8?B?eWxuQzRnTVY1R3dBeHJ1czZ4eHZPbmovaUhETTU5ZlRQV1dsc0RnOWE2cTBB?=
 =?utf-8?B?ZGEyZnhLTEp0ckJ4U1A3TVVRcUlGVnJjb1NYTHhkKy9oRW9tUDdjTzlqdm9S?=
 =?utf-8?B?Q0luR1d4YUJxa01IY01TNURLaW55ZDVTSzF5VlJlMytWZGNEc2ExaURZQmRp?=
 =?utf-8?B?WDR3ZEF2ZWdDSEgzajROWEVDM1JUdnpJRW82UFZ5RVlPSWV4RURpa0dyTzFp?=
 =?utf-8?B?QXdYcWViS1VoVEgvSy9idmhmdkxONjNiYVZldzRuMmJDTW42eHNWZzdrWG5H?=
 =?utf-8?B?eS91M1NScUxnNDRwYVFFZ2MyZ3hWaEFrdjdJKy9SNUdxOTdCK1R4OTBUcGMr?=
 =?utf-8?B?cXhUQmJjNmlodXpWU0tBZ0krQXJzZ1R5M3lLQ2ZqSi9MMkdpdE5zNFFDeUNX?=
 =?utf-8?B?Y21xd2dLREhzalpnbC9EN1h4QlU4dnpCR2k4SVlHeWRienAxWTNwS1FCUHhw?=
 =?utf-8?B?bjlyWU1FbnlLSHNueVcwc1U3Wk00ejA3d05MaVJPWGJtaU5JSkJMS2lGZ05w?=
 =?utf-8?B?b1BNdXhaYWtXU1R5bFFibFMydnViaGpzQmdsN2RLVXo1blpCRmxzRnloRFZa?=
 =?utf-8?B?SXIrUjBBb2lmYkt3VXlzVGQra2xia2l0U3RDQVdEZmhUQUJ5Mi9EbEpmQ1hD?=
 =?utf-8?B?UzVtRnJ0ejMwSkRlc2pUZXppMlZ5WWllY2V0b05pdFFRc1oxK3ZwQjNoOXph?=
 =?utf-8?B?K2RaTXQvMDRiQm8vVnFhSW5hdE1qOXJZNEFOc0V4dDhxRStvdktuWXdRMUtO?=
 =?utf-8?B?NWp2dHJUREREbnczQnAvcWVMQlRQMDFEb0c5U1RoRUJqNDIrTVpHNjZ3R1BK?=
 =?utf-8?B?MU5KQklWVHlpZUVIRGJOWGRmWmhsV253bUwxQmZmT3ZlU0wveU5xcnVMMjZw?=
 =?utf-8?B?Z3lHQ2l3MytaZjVvOVJHRmQzQ0VNeVB5SER6bFJEUmZEVmVqWUlHV0NUZjZl?=
 =?utf-8?B?ZFZVZ0hqU1hIanZDV0JONG50NzdDSEVkSzZNdTVvSGpUR3JtU0p3Z1RyZTcy?=
 =?utf-8?B?MjNnTmMyS2s2ZzVHelhBVzN4b2ZhUU9qWDlQeitLaFV1RmFEV0RYTGs0NzZi?=
 =?utf-8?B?eWdaSnZjQVNCaWxCOWNOUmZKaU5DYi9hYVRMSkkwbVJFSHBJbWxhVkpIM2tM?=
 =?utf-8?B?cXdlQWp1MHZPOCtZUmNCZWdzbExjRW5DSUVacHFwb3pCSTFXSlpDMmx2Wkdt?=
 =?utf-8?B?Y1pKZXBGVXR2OXdZV21jZjI3REw2TVZpeVpJQno5Qkx6elduZEI3cHZnR2Q1?=
 =?utf-8?B?NUZFMnlnWW9KSW9GU0QyMXI5SUZtTGNEMkRCZ2hhOHNVSEc3ZEtOTnFRYkZ1?=
 =?utf-8?B?K1RuVEZWOTN3Y01iUHVSY25rYWE0ZEZha3FlSVdsWlNrRnBESFd2WGlhcGN4?=
 =?utf-8?B?VW1ZZkVJTzJ0bVgyU0JFcSt3Y3NyQUhBWVMzOStsaEVKSkFNOXk3WVEzdTdl?=
 =?utf-8?B?eDAyWjZPcFZLdkloWG5tTHFRMVA0R0Y5OFJtV0FIUVpCSjJnRVdYVW4zVy93?=
 =?utf-8?Q?JWONkCLZR8I4X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFlRG9mczU4MFRDc01NMmg1MXZmdG5tdWlYaFZDS3FaU29NTHBsbjllMW1F?=
 =?utf-8?B?TUJITkl1N3ZleWE0dEp3MmlRS1BITHh2WDVSSFB6Z2Z4dFN4WC9HSVNSUnJv?=
 =?utf-8?B?RXNmRW52WmwxUm4wdk9ld3lIZmYzY0ljR2RhZjNYSUxyQnl0WGljZ0lZQjVG?=
 =?utf-8?B?RE9zbzNGOUgybmNrODNnT2RWN3FKa1pDNEx2TmVJeDl6a2cvSlZ4RTl5b2RJ?=
 =?utf-8?B?bHpoQVk5d3QyTW5JZENyd3NsL2JQMExHbW16VlBQb0tQODNrSjQ4QmlXUUZH?=
 =?utf-8?B?NzAwclhQQkMvYkhyZ3N3czF0RXFPQTZIcU9MOXNTNGNUMHVLZzZha3YvTUFW?=
 =?utf-8?B?SmJoNDlTcW1BYitkOE5udW5kbFcrMFM1STZPVmJmZzNGNFlwSXJoSG1URHY5?=
 =?utf-8?B?RGhGbnM0a1Zsdi9QeWhDZUhMVklFM2Q2V1FzTkFTWVVNdlE0WmhEUmU1YTZI?=
 =?utf-8?B?ZlpUMWtETHcvWjZKSGVXVElLMi90NXBlR1dYcHJCQXZGVXI3SWpGK0YxWHV3?=
 =?utf-8?B?WDd6T0hoZWJBZXRkb05tSGhJUkc4a3g0ZDhLbDlMK3BKQWYxTlNTejdnZ05G?=
 =?utf-8?B?d3UvMmhkQzdGaEpCSXVXZ3BWbkJDWThjZ0RPeStmaXhhdGZwalJPZ3Z6dm9q?=
 =?utf-8?B?Y2p6eGZtemJ4U3pBcFlDbVdabk43K0dYVkYrbWt3QVA1RXJ4d01INUI4dmZU?=
 =?utf-8?B?T2VVTk16dXlBMStRdE85VktJL0ZKUXZzc0RwQjNHdkM5REtFQldUWHY3Vloz?=
 =?utf-8?B?NVJqNGgyZ3RZY1BYaXdkcEVMbWFrWVhXYVN0MTJlT0N0bHFub21zMG9icERN?=
 =?utf-8?B?UW5ITThKcWxDS0FOaXpiR0w1c2c1Tm95QUZQbllmSVlXb2ZvYkpqMFZjbzQw?=
 =?utf-8?B?SkNZQjdCSzlKZDRyS3cvNFQxNVdEV2ZRMUJiOG5WNk1UQkI2TnQzaENFREdT?=
 =?utf-8?B?dU9xUUNuNkRMdGhCeGhOYUd6Y0plZUlZMDFHVFZOeFNSMzh0eDJKNnZCd0V2?=
 =?utf-8?B?MXE3dXc1TURDQkZSY3RLK1VuaW5haTR0TXR6cE9GY3h4dFMxdnB6KzJ1YkJF?=
 =?utf-8?B?VEJDL3JjcXdpYjVuVC9MM0d4ZVg2Kzcvb2JmdUE1ZkN4ZldXa1MxSVBrODJG?=
 =?utf-8?B?K0t0eFE5VmlweW1nNlVqaEdxbHVxcG1KSWFqREdDRGd3bGFBYnJ2MjN3TFNm?=
 =?utf-8?B?NWwrWXQya3lKQkdJcG9ES3FrSEJaZ3k1N0Q5ck9peVN6OHZtdkZVZDFrZDZW?=
 =?utf-8?B?MmQzdDV3VjFrM3Q1V3FtMDg2UngvS2ZsSXQvVnJtckxONWlGblYxeVFQRUVH?=
 =?utf-8?B?S2ozNE9UMDNpVzVDc2lkV01IM2FGK2RQMkVyTTc1c0ZUVTRXa3lZMU1MdTlR?=
 =?utf-8?B?UnlyZTRnSm02VXkzcTBGVTJlZyt3UDZBZDM1UjBXV1lEZjJDSDVQMlR5Z3FQ?=
 =?utf-8?B?a3U1Tk9jM3ZnVm1VWWwrTjB6STUvVllQcVIyRmJNbThoNUgxTmcwUy96d29C?=
 =?utf-8?B?TW1tSmozUGtzUWZlUk1xWW5aUHdWbWErTXJXd283S0VTWDN5eDh6V29Qd05E?=
 =?utf-8?B?Nk1KemVkbzcrT29FbzFHdWtoVlRiL1AzREdJdlZOQjc4S2JsVzRtUkNzQTcy?=
 =?utf-8?B?QWJvcDdnN3NFSmtTakZkejJRSDhNOGNMSE9uUnNaOXpyWmxvRmExRnVaRjY0?=
 =?utf-8?B?UU9FL0phS2pYOCthRU9ETHBlQUFRSnZjaDJzR09XQ2ZndkdEenlobTF1Vits?=
 =?utf-8?B?dkxTQlIzdlJOZ3Y4L25KbWRVaVFVQzBJZjRFV1N1RVhZQitEbWduMU9tcTN5?=
 =?utf-8?B?UGpOWDB0dEhpdjE0RFJGMTJhRnFxcjUyZUp0YTBwVFNrUnYraTlWQWk3TzFE?=
 =?utf-8?B?K1dIK1VUaTZOTlE4bkE5eis5ME9NeThKbjFjaklYZnlBVHVaL0RhL3lxMGVJ?=
 =?utf-8?B?aVBXalBTa2N2Q3FmOXVwNURSakh3Y3cydWZsNlRQeDJnNEJPaUR6K3ZBYWh0?=
 =?utf-8?B?QW8yblZGWkd4TzUxbUJDWHMvcGhEZ1JUYUtMcE92QU56SENxVG9WRm1zc0FR?=
 =?utf-8?B?OEZWb1JYRVNSMXNjT3VUMkhlTGdKNmJzZCtpNHF3LzVoNHk5VGNjV1VWWEk0?=
 =?utf-8?B?MmR0SlM4bEpDK0c2SWFJT0hhL1FCb2QrY2l3V1Jtem5IRkRFeERrNFdDOUkz?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d3685-c6cf-4891-017d-08dd5c20fe20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:04:53.1917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSfOzXECookzCM1/RZrkh9QkmxypuH5OewZWvPg7tMMCIbwz8yeJn0tY/KoxMxQvl6Gaa55W9KWM1YkIyckikeLcosou5kpxYEJurVMTz6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

--------------cNLhPMok0UU3SULGD3ss07MQ
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andre,

On 05/03/2025 14:45, Andre Muezerie wrote:
> On Wed, Mar 05, 2025 at 10:08:33AM +0000, Bruce Richardson wrote:
>> On Wed, Dec 18, 2024 at 07:21:26AM -0800, Andre Muezerie wrote:
>>> Test lpm6_perf_autotest was hitting a stack overflow on Windows
>>> with both MSVC and Clang.
>>>
>>> The fix is to move some of the data from the stack to the heap.
>>>
>>> Signed-off-by: Andre Muezerie<andremue@linux.microsoft.com>
>>> ---
>>>   app/test/test_lpm6_perf.c | 13 +++++++++++--
>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
>>> index 1860a99ed6..59df0a958a 100644
>>> --- a/app/test/test_lpm6_perf.c
>>> +++ b/app/test/test_lpm6_perf.c
>>> @@ -10,6 +10,7 @@
>>>   
>>>   #include <rte_cycles.h>
>>>   #include <rte_random.h>
>>> +#include <rte_malloc.h>
>>>   #include <rte_memory.h>
>>>   #include <rte_lpm6.h>
>>>   
>>> @@ -117,8 +118,13 @@ test_lpm6_perf(void)
>>>   	total_time = 0;
>>>   	count = 0;
>>>   
>>> -	struct rte_ipv6_addr ip_batch[NUM_IPS_ENTRIES];
>>> -	int32_t next_hops[NUM_IPS_ENTRIES];
>>> +	struct rte_ipv6_addr *ip_batch = rte_calloc("ip_batch",
>>> +			NUM_IPS_ENTRIES, sizeof(struct rte_ipv6_addr), 0);
>>> +	TEST_LPM_ASSERT(ip_batch != NULL);
>>> +
>>> +	int32_t *next_hops = rte_calloc("next_hops",
>>> +			NUM_IPS_ENTRIES, sizeof(int32_t), 0);
>>> +	TEST_LPM_ASSERT(next_hops != NULL);
>>>   
>> While I don't think we need to use the "rte_" versions of allocation, this
>> is still an ok fix - and I see that in v1 regular malloc was used.
> The reviewers had different opinions on which allocator function
> should be used, that's why it was changed. Thanks for being flexible on this.

As I mentioned earlier, I think it's better to use the memory allocated 
from hugepages here since we are measuring performance.

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

>
>> With either calloc or rte_calloc used.
>>
>> Acked-by: Bruce Richardson<bruce.richardson@intel.com>
>>
>>
>>>   	for (i = 0; i < NUM_IPS_ENTRIES; i++)
>>>   		ip_batch[i] = large_ips_table[i].ip;
>>> @@ -153,6 +159,9 @@ test_lpm6_perf(void)
>>>   	printf("Average LPM Delete: %g cycles\n",
>>>   			(double)total_time / NUM_ROUTE_ENTRIES);
>>>   
>>> +	rte_free(next_hops);
>>> +	rte_free(ip_batch);
>>> +
>>>   	rte_lpm6_delete_all(lpm);
>>>   	rte_lpm6_free(lpm);
>>>   
>>> -- 
>>> 2.47.0.vfs.0.3
>>>
-- 
Regards,
Vladimir

--------------cNLhPMok0UU3SULGD3ss07MQ
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Andre,<br>
    </p>
    <div class="moz-cite-prefix">On 05/03/2025 14:45, Andre Muezerie
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net">
      <pre wrap="" class="moz-quote-pre">On Wed, Mar 05, 2025 at 10:08:33AM +0000, Bruce Richardson wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On Wed, Dec 18, 2024 at 07:21:26AM -0800, Andre Muezerie wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Test lpm6_perf_autotest was hitting a stack overflow on Windows
with both MSVC and Clang.

The fix is to move some of the data from the stack to the heap.

Signed-off-by: Andre Muezerie <a class="moz-txt-link-rfc2396E" href="mailto:andremue@linux.microsoft.com">&lt;andremue@linux.microsoft.com&gt;</a>
---
 app/test/test_lpm6_perf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/app/test/test_lpm6_perf.c b/app/test/test_lpm6_perf.c
index 1860a99ed6..59df0a958a 100644
--- a/app/test/test_lpm6_perf.c
+++ b/app/test/test_lpm6_perf.c
@@ -10,6 +10,7 @@
 
 #include &lt;rte_cycles.h&gt;
 #include &lt;rte_random.h&gt;
+#include &lt;rte_malloc.h&gt;
 #include &lt;rte_memory.h&gt;
 #include &lt;rte_lpm6.h&gt;
 
@@ -117,8 +118,13 @@ test_lpm6_perf(void)
 	total_time = 0;
 	count = 0;
 
-	struct rte_ipv6_addr ip_batch[NUM_IPS_ENTRIES];
-	int32_t next_hops[NUM_IPS_ENTRIES];
+	struct rte_ipv6_addr *ip_batch = rte_calloc(&quot;ip_batch&quot;,
+			NUM_IPS_ENTRIES, sizeof(struct rte_ipv6_addr), 0);
+	TEST_LPM_ASSERT(ip_batch != NULL);
+
+	int32_t *next_hops = rte_calloc(&quot;next_hops&quot;,
+			NUM_IPS_ENTRIES, sizeof(int32_t), 0);
+	TEST_LPM_ASSERT(next_hops != NULL);
 
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
While I don't think we need to use the &quot;rte_&quot; versions of allocation, this
is still an ok fix - and I see that in v1 regular malloc was used.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The reviewers had different opinions on which allocator function
should be used, that's why it was changed. Thanks for being flexible on this.</pre>
    </blockquote>
    <!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-GB</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
</style>
<![endif]-->
    <p class="MsoPlainText">As I mentioned earlier, I think it's better
      to use the
      memory allocated from hugepages here since we are measuring
      performance.</p>
    <p>Acked-by: Vladimir Medvedkin <a class="moz-txt-link-rfc2396E" href="mailto:vladimir.medvedkin@intel.com">&lt;vladimir.medvedkin@intel.com&gt;</a></p>
    <blockquote type="cite" cite="mid:20250305144531.GA32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
With either calloc or rte_calloc used.

Acked-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>


</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre"> 	for (i = 0; i &lt; NUM_IPS_ENTRIES; i++)
 		ip_batch[i] = large_ips_table[i].ip;
@@ -153,6 +159,9 @@ test_lpm6_perf(void)
 	printf(&quot;Average LPM Delete: %g cycles\n&quot;,
 			(double)total_time / NUM_ROUTE_ENTRIES);
 
+	rte_free(next_hops);
+	rte_free(ip_batch);
+
 	rte_lpm6_delete_all(lpm);
 	rte_lpm6_free(lpm);
 
-- 
2.47.0.vfs.0.3

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Regards,
Vladimir</pre>
  </body>
</html>

--------------cNLhPMok0UU3SULGD3ss07MQ--
