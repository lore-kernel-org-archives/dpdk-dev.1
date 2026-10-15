Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC8ACC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC08D402E4;
	Thu, 15 Oct 2026 16:52:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CEA304027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075957; x=1823611957;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=h+104yR82VpqyuPLya/qS0TYMvdZqxCW986Dykl9QAI=;
 b=gUviFEtZ+OnfAh4GV6U7ozZ06DQF7VGgJrLsDCLh3pOl4fLEwiaX1FT1
 RXbFMPy3RzV3bP0cu6DSEYbzn14D7Cj/l9fjPsW2ImAJOf0Xh9LYHQSQe
 0pWutcrvsLDEs8epbRK7NJzOCr4IIpc1/+WmYxDld8yUvGut8VCTqVxN/
 qAE1dwXRePbUXSU2zIM0X5LErLmHyq8zcLGu50/c5dHlctzKRWadWD6Ns
 OeBz+/88DZ/LpPasm6L0DNXNpJUnJ4GYytLRL26+QMj+jhnOjkpECh/yx
 sfS24lhtz887JVVe/29hw68a0Ssh9voH3OBRId3Fo57X5Wum/BxVb6v1e A==;
X-CSE-ConnectionGUID: E1WckwmuQjiDIJXDTpj11Q==
X-CSE-MsgGUID: 2UFF3NcARyeKs8b6ajampw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="881082"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="881082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:52:36 -0700
X-CSE-ConnectionGUID: tIYJdodKQemiEECigBvgzQ==
X-CSE-MsgGUID: xFXQi2/xQrW8z8guB1+cog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1766261"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:52:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:52:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:52:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KayA1kMuyBQYtpu1ZfRdv//OwoJsFOa3JRxVngJCWlreMcWiKqIHA0DKyhTvAUE8sNOhUAMFMlYZ85SObmo50IasMODRARxJOCsMuvOO8DJUreV8Zk39O63a/r1be2sMSG+KK+pgt4akZE+JiLlTpXYGrGls/ck1s23efe/lFUFe49V/N0bCgEigL3Piw9aDE03XSDUlJM7cvK5aY7blf+11G1P1eCqBjg4fgsXx5Jkn/sVRCX979ErgFF/nQh+KQ58Lp8GcOYpebJPly/7cUJ5CsU+/F0VaPdsUePJpVEQqxawMtD25MwHbpaMdVxDNr7LewNo4LOf2+rzMG5BFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH8lDgrgOoqxY5x0VUh39V9gkiTSmbsr0oRx19jitEI=;
 b=SJto/jK3yrmyj/n85ss2r/zvtkfeBJ9an7QyzkCsCVuZOF/8MltmPPghRhlKSqkFWofU0RdCldlYON+3kszOD/tdKcvVElaLEG11qD1M3KMf4oJHuyUDUKL9+0EzXNe1WjHYICRzAqVIROx/0eki1B8PEAQzzthw9OESM3AqbuaCWiCI4tGaWq/tRYfdLcP2Qc95lHLa6SYfR/GpRujgbqJZ8XtRn85eWmnY/lLbXPk+G5RcYqAbbxqvKfdIUMnE2buycSpnfEzBoibgYBBrxMe2lSPwjQMAZaDW7LESWKYhZ1rho1OhVfFsQQ5rPeOzDrMMwBdCvDxUbyWiniw34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:52:29 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:52:29 +0000
Message-ID: <46e98c80-f44a-4c69-93fb-050ccc864c4b@intel.com>
Date: Thu, 15 Oct 2026 15:52:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Kevin Liu <kevinx.liu@intel.com>,
 "Qi Zhang" <qi.z.zhang@intel.com>
References: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 533d44d2-dd94-49f7-c1df-08df2acbef55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|10067099003|3023799007|18002099003|260925021911599003|11063799006|260925021311599003|260925022911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8uTSa6jHjIrKWmYYhHPW0nM04p72vBkv7tW2YIR8yavADWUACr9DCqkKC/UIVK5uwuYnMFq+Sxm5Kj8tm7RVAvdppcvzlRmyml6SOCvFFzFlj0tpveoEaD2v+G0/GI7aaUDdc2lxCzf7CCEJZlnNR+wZ44Gfd2jJHFHW87buE/rE8Fj7Ln3WZhav+bhb8Igkzyu4VV7/5Jj6KnRzz+wwvikyfxJGEi+9+0CkBl5KedqJcWQfcuOQTcPyBNPhVBtmJ95bAsG7Gqm/DhIkH0rZlbh90q7sVMDk5p3FeFZf2eWctWJveoIG2wz/SQU65NHwWG9iMXeJXh92ZlX+VAcod4vmnJrQGGHpORE/J2L9ZoltPTtg+C9Zi2AOIiGef8XIBMQP9YZ0sxZ8ojja398oWfw4/Pxu7M8yua16T/bPZ664bAcgYgzMK3UMilkGlnHAWG+BVMLYfETVx2IlqIRaelni8xjlC7h20tOuFqiFoM1RFfATFbdUmUhnQbDospuYKvYwOQmC5N9Uc85PBWuJHyc7K8TYpgcYQMubzac7M7I4wxYnit1lPxNHYiisDRD+OK4HfwwcURUU5tvk+TEw3SOPDhXGNfbzemn0eo/wVoO4vgaKfu0lms6CbvG2xKYUsmHggXINjthlR6Cjx30Gf81+GlH4x65iQvcthAvRJVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(260925021911599003)(11063799006)(260925021311599003)(260925022911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VxZVZVWU1zayt5RDJBSXYzNkxUcjJpQ2c2WVdYUnRMRUtIYWxNRWMwMGli?=
 =?utf-8?B?Nkc2MnJNY0N2eWpHcWRGRy9Jd3FNV3JtTTRXanpSM050cjBKRHRSV25CRFdw?=
 =?utf-8?B?QlVtbmgwWWlmSjVJTFVVQ2VnaGY2dCtvdDlDOGU2dFRsdkNqeDdzWkZOTVFB?=
 =?utf-8?B?dloycVl6c1pwQTJrSFBnWFRWRk9TNk5iN2I5RTlQbEo3d3NCSmMzNG9CVVQ1?=
 =?utf-8?B?L24wZC9DUEtiUDlZcHlleklaUXBURmh1TU94YTdFazJxcjJqZHh6TlFkY1VD?=
 =?utf-8?B?cFBhVUFwSis5aDFWWTR5bFhJQmV0YWFuSnp6VFEzYlc4RGZqSHJxR1hROEFN?=
 =?utf-8?B?N2NGcHVzWXNvWmJ1VGwrRlY4REx5Mmtvdm5VRGlVTmdIR3lXeXR2V3k1d1VU?=
 =?utf-8?B?S2hZWGtHNmVjV3RFcUJKOG5ic1o2UEdkLzh5d0l3eGgvZ2RzdXVsbGpWTk82?=
 =?utf-8?B?a2M1QjIwbWMxemFyMjB0akw1bE9aK0VRZWpFamQyanFmbmxhMVlpNCtwWU1K?=
 =?utf-8?B?QUNDR29pNEhVVzJMUTk2cnFka0E3VGVYc1dlWmtZc3hNRnBiWmg3cDZ2Z0xJ?=
 =?utf-8?B?Qm8zSllTUFhLaGNTQlhpcUlIN3NnSVdId2FLOFZ2azVRU01xWXBkKzNjSTJS?=
 =?utf-8?B?cG8vMHlUYnZkc3VnZWtJUHZlQm1pVUtLeTd3QSszUktQNkNmVDhwSFVMUldX?=
 =?utf-8?B?MTBVNENVSXNXdWgyNUJsOWpicktUTDgxeXJGTUVia3hTWmRhaitFWXZRcHor?=
 =?utf-8?B?UVAyT3JZTWpMYThNMFdJQjJBNFNHUkpkU0x6Wlg4MTI3d0t1cnNOeXEvRVFC?=
 =?utf-8?B?MjF6eCtCMjkxaUhUSG55dzNmdVZmdjdlTDlJdkUwTkgyaXYxOGNwVW9RQWdx?=
 =?utf-8?B?K3ZsWFBmL3NlUFR3OEZKYnErdFZyYVJRSmlDVXhCcFYxZ3BxOHo5WlF6bk04?=
 =?utf-8?B?MVBXa0JlaUlnT3ZFVFBTRVp4cFh5K2MrOUdyVWJIaytxWnNVc3RqYm0zU3o2?=
 =?utf-8?B?dHRpQVl6Zk9lcjdRS1FnWVJqNk1HNThBRFlYUDRqNWlQSzF1SklaYlJMMHFM?=
 =?utf-8?B?Z3pLcm5FOXFjTWNGRWM1MUdveUFiTGZzK04vTjFhRWhxT0ZSeFUwWm1sZG10?=
 =?utf-8?B?bjhFRXVLR2JpTFRCa1FHTmprOFlTcTZIYWJhc2ttYkNOYWpjMEp4emVDcDRi?=
 =?utf-8?B?SWJEcFpWTjZqRFFoWjJPVi9qSDhjalgvUlYwVVlTN0ZqV2pUMzZRcHUyMVUy?=
 =?utf-8?B?WkFYS0VpUlE4cXRrL2xKOEZPZ0IxU2ZHMmxpVktaQVNRcUJxZzN1TE9qRERr?=
 =?utf-8?B?Nk0rcXFFTTNleWlLSUJHSnNObHFVWHBuazVicXdIb1lSblVyb0ZkUVpKYlNr?=
 =?utf-8?B?ek9HRjFSQVF4QW14TFo5QXRvVWJnYVVLd1daZUQzTVprZzZJcFJaaXMwRnRV?=
 =?utf-8?B?eFJQTkdBKzVEQVEyZDlMZzZ6K0ptc0FwRFhncTR3TnNKRUVnTWNKWmxnenhk?=
 =?utf-8?B?NWdiSUE3V0IvSkxvMXNHL1lnalg3cUcrL3N6Q2dLRWRtSU5UYURhM3NCbVl5?=
 =?utf-8?B?VzMrS3dnM09uVS9kU0s5YVR2TW1vYjVoaWNhOXpWcVlqamVHRnhPcE82b2ZZ?=
 =?utf-8?B?K0RQbmswa3krNUFDZm1qS1JDaG5aeVVXUndhcE1KaTVTeDIxZW1vcFI1SGNr?=
 =?utf-8?B?ZERmbER3dktHaFRNTGhFZEVqLytQUE9LOVJra055ajNZVFR0YU1vOG52eXpF?=
 =?utf-8?B?Sm0wK05mY0ROUjVGVTVSSDQvOEFMcit3dVVONFFJVDZFQWYySTdRU1pvbnJG?=
 =?utf-8?B?eHFQemg5Rnd1RUM2dXA3WktVYVlGQWE5WEMyTU1PcGVSZXNWM0F6UmdxWHBv?=
 =?utf-8?B?MnFsYm9KT3pJeTh1Z0wzR2YxSENXRUtxdTIxNjdUa29OaUkyZ1pQMmU2ZE5G?=
 =?utf-8?B?ZjZETE8vQlo5U0hvZmtjSTJtYStBRlVxUnUyVmhSUHVtbVFtKyszVkk5TVFZ?=
 =?utf-8?B?ZTBaa1Rmc0dZaGJOZW9IOEhEbndQUDdpaDFDd0tOR0VJeHNmQVJkSGxIUWRy?=
 =?utf-8?B?MktEZEZDNWwyZ0FkdkkxNHJDeENaald6dmlkaVdiOUlRaVZvdkovRUVBMGNz?=
 =?utf-8?B?QjMydCsyeTZxUVl4cE96eUdnWk9QckhxNUhkb29GczRiaWRXb1B1cy9RcTc4?=
 =?utf-8?B?SlI1d2tFaXhZdU5OS1BCMHc4UisveHRyU09QWERXU0Q2cFhTZ3IrMW1Yemti?=
 =?utf-8?B?N2lRU1VySzlRS3VoditSajlaWVdjYWZ3L0poaEpOb0hXSjg4am5zWjlDdjJX?=
 =?utf-8?B?Rlg3ZWNHWUdvcTVWS3ExQnpmb2NSSmVmZzlZTEJiUXpNb0dpRW1idHo1VnJa?=
 =?utf-8?Q?9u831KWYeBPosGKE=3D?=
X-Exchange-RoutingPolicyChecked: JZw3szhNGAUH1gRC8PyDIDyoxJuyCK8IP8FcjGT+pcPARcaSIWBs68cd6tANexbhoIt4TIIg4HueQCF0xLGnW5Pj7aEcKPjEPVWUqBo5feKjTejbIsghvZDW19ntRiQtREF+UMdT/Z4ZTL6QYzH/uBKkb4t82hCRCUbgps/GelRbm53Eg4TvAUE9Zs/0Qx9vokr9ZyNuKHSu8qR6sMKeFSQDHIr/ATN5H5QhvT1VLxv5r82NNV5pywKvw25O5ZVsyhObyvECCbnlzLG1E6F1/yK2T4r+TDwlTHX7aKy086XFU/AxCuJjmpTpOFsVVSHtnWdVTH+xKTleQlVHh/HWzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 533d44d2-dd94-49f7-c1df-08df2acbef55
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:52:29.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cs0ZGBFi8/mhdBELj/ulutjpPcuKrx+JElAr43ZswJckqIBYSCnbAzSrBadEjis2M6/mAvau0IKzpywywSi9Tug7LnS4DgKnoYQAsiCZXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
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

Hi Anatoly,

One nit: the buffer must be allocated with malloc, could you please 
reflect this information in doxygen comments?

Apart from this,

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/15/2026 3:21 PM, Anatoly Burakov wrote:
> Currently, the `ice_testpmd.c` file includes headers that are only
> available to driver itself, but should not be available to applications,
> including testpmd. Instead, testpmd should access them through public PMD
> specific API.
>
> The ice driver does not have one (even though it offers a testpmd file), so
> add the public PMD-specific API header, move all function definitions
> into that file, and get rid of driver-private includes in testpmd file.
>
> Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   doc/guides/nics/ice.rst                |  3 +
>   doc/guides/rel_notes/release_26_11.rst |  2 +
>   drivers/net/intel/ice/ice_diagnose.c   |  1 +
>   drivers/net/intel/ice/ice_ethdev.h     |  9 ---
>   drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
>   drivers/net/intel/ice/meson.build      |  1 +
>   drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
>   7 files changed, 88 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h
>
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index ba598742c5..e4dd87649b 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -1021,6 +1021,9 @@ To start ``testpmd``, and add vlan 10 to port 0:
>   Diagnostic Utilities
>   --------------------
>   
> +The diagnostic dump functions are also available to applications through
> +the public ``rte_pmd_ice.h`` header.
> +
>   Dump DDP Package
>   ~~~~~~~~~~~~~~~~
>   
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index a4f44e5ebd..f3c820a72a 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -118,6 +118,8 @@ New Features
>       enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
>     * Added support for getting and setting link (802.3x) flow control.
>     * Added support for Tx rate limiting per queue.
> +  * Made the existing diagnostic dump functions available through
> +    the public ``rte_pmd_ice.h`` header.
>   
>   * **Updated Intel ixgbe driver.**
>   
> diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
> index 4946ace7ae..ecfcdf5559 100644
> --- a/drivers/net/intel/ice/ice_diagnose.c
> +++ b/drivers/net/intel/ice/ice_diagnose.c
> @@ -13,6 +13,7 @@
>   
>   #include "ice_ethdev.h"
>   #include "ice_rxtx.h"
> +#include "rte_pmd_ice.h"
>   
>   #define ICE_BLK_MAX_COUNT          512
>   #define ICE_BUFF_SEG_HEADER_FLAG   0x1
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 8d5e17e2df..08c2b61519 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -821,15 +821,6 @@ ice_align_floor(int n)
>   	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC) || \
>   	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8))
>   
> -__rte_experimental
> -int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
> -
> -__rte_experimental
> -int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
> -
> -__rte_experimental
> -int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
> -
>   int
>   ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32_t node_teid);
>   
> diff --git a/drivers/net/intel/ice/ice_testpmd.c b/drivers/net/intel/ice/ice_testpmd.c
> index 98c02d68c6..0c135d79a3 100644
> --- a/drivers/net/intel/ice/ice_testpmd.c
> +++ b/drivers/net/intel/ice/ice_testpmd.c
> @@ -2,14 +2,17 @@
>    * Copyright(c) 2022 Intel Corporation.
>    */
>   
> -#include <stdlib.h>
> +#include <errno.h>
>   #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_pmd_ice.h>
>   
>   #include <cmdline_parse_num.h>
>   #include <cmdline_parse_string.h>
>   
>   #include "testpmd.h"
> -#include "ice_ethdev.h"
>   
>   /* Fixed size for ICE ddp runtime configure */
>   #define ICE_BUFF_SIZE	0x000c9000
> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
> index 322d9597d2..00077be30a 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -19,6 +19,7 @@ sources = files(
>   )
>   
>   testpmd_sources = files('ice_testpmd.c')
> +headers = files('rte_pmd_ice.h')
>   
>   deps += ['hash', 'net']
>   
> diff --git a/drivers/net/intel/ice/rte_pmd_ice.h b/drivers/net/intel/ice/rte_pmd_ice.h
> new file mode 100644
> index 0000000000..dccfdcd5f4
> --- /dev/null
> +++ b/drivers/net/intel/ice/rte_pmd_ice.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Intel Corporation
> + */
> +
> +#ifndef _RTE_PMD_ICE_H_
> +#define _RTE_PMD_ICE_H_
> +
> +/**
> + * @file rte_pmd_ice.h
> + *
> + * ICE PMD specific diagnostic functions.
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +
> +#include <rte_compat.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * Dump the runtime DDP package configuration.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param buff
> + *   Pointer to an allocated buffer. On success, it may be replaced by a
> + *   newly allocated buffer; the caller must free the resulting buffer.
> + * @param size
> + *   Input buffer size in bytes; receives the size of the dump on success.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
> + *   or a negative error code on failure.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
> +
> +/**
> + * Dump the runtime switch configuration.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param buff
> + *   Pointer to a caller-allocated output buffer.
> + * @param size
> + *   Input buffer size in bytes; receives the size of the dump on success.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
> + *   or a negative error code on failure.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
> +
> +/**
> + * Dump the Tx scheduling tree to a stream in DOT format.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param detail
> + *   Include node configuration parameters when true.
> + * @param stream
> + *   Output stream opened by the caller.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, or -ENOTSUP for a non-ICE port.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_PMD_ICE_H_ */

-- 
Regards,
Vladimir

