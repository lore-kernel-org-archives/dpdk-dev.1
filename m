Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C81CA600E
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46AA640274;
	Thu,  8 Oct 2026 12:06:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 549F44026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453961; x=1822989961;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c3vvfCajj2uz1rWGqsBsPhbqPH4Ui5gCC2JCobjrzj0=;
 b=T5GKsh5yXDGgZzqeELkzNmbPiIscu3Ck5zHuHqMqQkN2bHdD/TN4SxRA
 8Xo/ZwHIKnvTet4bpNvEvLElM+autrFxjoYFTBzoaMHMQIitEhYZmt3C2
 3qjNRjJ3Qp2zHtkUi6y7h7SJLwI+SJAi17MTovs3/q/akoctyvcht+iDO
 eAq7npjeVAx9e+nyN9QP7dDFNc1K00r2yxZsWM3ZpCvb1udkWlX4/8fr0
 osev4Py4YuCzKMbavQvXpJG53H8xYxHQnaI5juuRwXk3vFwiPC6DFB+uS
 BcVdynE1fzk4TX49O6EJlUZfSMBSjEtOe4AOcLEgekvHzTX4bPWPiJbeu w==;
X-CSE-ConnectionGUID: HS/sfg1PTYq4c2lk5X51JA==
X-CSE-MsgGUID: uNqvURSTS8CSOGNgcW4prw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="239220"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="239220"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:06:00 -0700
X-CSE-ConnectionGUID: 8zyEnR/+T222nPvB5ASzdw==
X-CSE-MsgGUID: zOPg5fviRN+mQfXAF6VxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="109595"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:05:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:05:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:05:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:05:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9LZsuB2F8acdwHSdfKFSFmnm7bg0R8+ITcpLzzc23FFa/ltKbLcFW2w/Vj5P/O97bQbFFIFeFn4Y4iWMd3VMkQH77LOaxkGzeLgkDDgOyo8g+eolZ0eM0ACWUk/osEmgs9+gmfDZeZ+nsf+u4hOrYH5m9jVhAFnt7YqltFyEfnELCkC6mmJMiEBRI30xySaDKX6HcVbLfl1FXQ+183ik3pq52kEANDRJG26gaJfxRp0+teWo7ItM3KgKfz5iRjSMmx6TELkJU+pkalS6N+mjs4ToeFzxNRwxM/UbE+Dw0InYsLdiObr62VPklwuYVDyr8YtQPTPj8M3VWfD+j0MGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFTcyYDTLE8wewImajrXTr1S5C5D6CWn4Qc59n5/vuQ=;
 b=KWis5WZyKrLaHbrJw0HT8lZfIhBXeQ+nPoqjg9K0sqMFpm0fwvw5utIuBo0mjEHw0xo5GG0lmMcqU2zGKLdemVsmCAFvuRUsV27DexzNLQgozkZqhLKNaHD1u3l/xgwMN5n0CNXI3/+oEVqKPhN5tZXObRPY1mBvZuWWH4lRYNvAmUGDY61M/iAYSsMwzdWNi3GVM7mYYbKYOwE0YJudzim3J8+YzapHo+1Bw/54cEnua99z+RcmlXAalxOjZDk1yzQ3dKFtsqMauLQqA+yiYvNxOZ88y7z0lfr8LnJcT4QTKcX3b9oGOBYUAWuLiR+S7vWzLh/v8t308RzTYoZZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:05:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:05:37 +0000
Date: Thu, 8 Oct 2026 11:05:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 06/20] cmdline: promote bool token ops to stable
Message-ID: <asdq7NEThAin9HVi@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-7-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: d79ee045-063d-4f7a-6b73-08df2523b30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NIm8khNpGnYeqLS1cmDtoVuCBhz0HD8RhDWYxpegdTU/NnNwotZCL22uMTXk6ByDDZ4JLUXKGeMNokIbHes+UsltjzK49wads9i8QamJgpkoEZ3lfokC6q0bxtNF2C1q67HRCLz8CdW6kl/m01E5wjzJybybIq/rxNQlIAvJdfbcL575bofb/q2vTCFfrIvs8yRwR/n06utbOswIi6WqXjitd4YZAlWt/3EOLmAswFOJnkVR82xpzsvIsps/Oze+WfzqIxHlCp77AvL0We+kjuYqpUxfaIOrDOhZbB1ZPAHe+hoLOypfULePSOhmD9Bva6vD3ExgEa1kdt89thr9MPl6M5lT7wYcLWc0XOpIBIpqH1nXJvSyr1N8jXxpqRBBt2M5IXlecoK2dHQaRqozpYL3s6kdzbX10Pb5UrorKQtnQT26Jw0cPcTScNIr6Jlw1j52Agb6Umeqs/IJ68n4du6XDS0XcAk97MC6hDPwjVV4TgAYQitA36rfaOfsm16HcDcQar5VBIefNYIuZ2+38VA2Ol7DLuaqeL5ZKethKEPlv20rakLfApBQFKzAYZoC4cJdlp6XP434oWdzTWLxiM4J4OPXa2h7O9aSvGaOZxr3u0fnC1B7OwZ+87DHxtt4GhJaYTiMJO2ub3EpvWh9Enq/QiB3Q4qp+vMVsb3sU5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V809V1GKwoufvisG/DuRqi7ZSV8oHdyP+OUjd/zio6QRa+tT0SQ4qxc/rFLX?=
 =?us-ascii?Q?Hozj/I7eTkWuN6V1IF6xj5n7CRWIhwZ2DDs/4o6LjGi7ImgGABisVmrHyL/+?=
 =?us-ascii?Q?ZQ7On05YUiNc/suAZnqAAUfPHbrND6wlJf2VVynFUfwVQJ5aKXWQKPzQ5eWL?=
 =?us-ascii?Q?4P6vIPrSlJTeFC7VYVMESZqCNTHOiVxk2J/j5Ckl9Yvww6VCc+F6p7DnuSQ5?=
 =?us-ascii?Q?9fy+dVRKnmHTWjbpuWrmSxl6gwDWv3R7xLAjjOmxYqhcuEBSDtGXM7JlYO0k?=
 =?us-ascii?Q?Q6hOxcEX1K2TMlZFu3R69DoMCMOdNYxkkHcGXAaOr9TflOjzMtnwb6oJsbH0?=
 =?us-ascii?Q?SON8ZQFiyglLgDYiVb7dyC1Zlb5R5N2VfDeHq9UUuEyePZLNKSfTuQx2vUHr?=
 =?us-ascii?Q?hlt4Vol03ZDggIXrybxRmJdEg5c9iDWl1bdBeCR2O3ivoYA55DGvDAHGsIFb?=
 =?us-ascii?Q?nbhiDvZoyV75nZZrOHizz4RDl3qwyrfiXlkg5v96VZa3ke3MUz8cjRP3fyp+?=
 =?us-ascii?Q?IV8RmN+KndQexfcGRIxX8bVwYaPpq6DOQLGfIKta/tF2uzOgL9Zi2MxlznSC?=
 =?us-ascii?Q?uz3chsRIH5QcwrOmPPWwYbn8zgIuNu8SP7qeMFX8yI1gQKoHrXWsnavevA0Z?=
 =?us-ascii?Q?kqqWMmhDHR/0LwUTiLccdSHWHjBbuwQ6sgJz9Q7Qg/oVXcJ14kcrsgRrrGE4?=
 =?us-ascii?Q?AqhJ0Hn+es8qFQqAXB15ICSbNVOkEHhJe6FiltBYdMB3YHZUDo4h7dHl2YIQ?=
 =?us-ascii?Q?vc6EBgakrfr4G7o1FGRtPMmAr8CLS0nboOv8q9hO0L8QuiTZWcRLMaGGwGlT?=
 =?us-ascii?Q?44Hi4FnARFpTwY6EiIu7dhdlJOIPBdcE/bq/r2TbRA6R9fxj7hkXaqXk1FxP?=
 =?us-ascii?Q?Fis3MnRlNVMpPhgSJSoDC8EwT2+rOgsMwgngJD3vXoG4zhcuDaX4+pTktmNd?=
 =?us-ascii?Q?XOlXCa9C9nf/TjVT5KKeDRstIgqN7/b3wlgHlfU7LHgxgrtdAbzKA8XIQQSC?=
 =?us-ascii?Q?B5CLshQN1KZiAR3OFVYv+cQgp3S6OKqrRLUTtDQGsbLJ7ajO7txc/NmNrfO3?=
 =?us-ascii?Q?bzoOP2WkbIOShbWhVZ/v6S3UrxM0iJ9IW1BVVXUX4cgeai+lyc4t6Cc1gXYz?=
 =?us-ascii?Q?g19hJiKu+TeBveD3XcjdoC/sXSD01uZKRhBa3eECapAu/NrY/AJbw8e9ocqX?=
 =?us-ascii?Q?B6/7A5BLbdNZdn2vU0xg7ut3RtL/DS2UZDLDHNyKb0O5F9/Np/KKiP0kEbV+?=
 =?us-ascii?Q?Oy/NpwEBj1hY1VPAcjB2ygA3LlnRhHsFNU+ru8G6V708+w4ucIj4QdVcruqS?=
 =?us-ascii?Q?Dl9Qe2lr31ZjipFm/kggzbCVPFXGetFUVU4zcG6WbiiEY+w0xpzKpJb1bCLz?=
 =?us-ascii?Q?CSZnFxqeQgPSrOtn620HB2mMxBugs8PuBcshHO3mTFgXzG/xU2e0tfHAD6rV?=
 =?us-ascii?Q?SjWEvKvn8OQMfqLiKvtCOQXfbu1MxZHKv0ak9qm8w6mKgXUHtxICAlXgtmhc?=
 =?us-ascii?Q?zdQWCSQL8nfASAZOELr6EDHoROsRWzmIfX7gmIl0m1PyJGAokSUsjLjZQglf?=
 =?us-ascii?Q?iQMJzXiy3ULo+G5ItGugoDlLfKmZ5jaQPP7cprkZhmTYm5eD9C+hUIWfiPkt?=
 =?us-ascii?Q?7EwdF9sVxo4f2Ez15DOEHX064mFoEAl9/0e5YRXq5dCssq/vt9qEiJn/io7z?=
 =?us-ascii?Q?4aGt43f+W0IdvvW2rM9Z7eB0w/ZJESgg9WpM4y4LinxKl6Q/tVPnq+1BOzJU?=
 =?us-ascii?Q?MOtnN5KK/7w+QE5Ml2zXsIdFrnHzb40=3D?=
X-Exchange-RoutingPolicyChecked: ujViAVKon+cAfp8+97EfyO99hUi+WnW2kVPspgq6dqhT1FDRPdMF1vlOMv5sGFRuu21qc6ptLdQO+oNT1u3DoPUL7kV9Son8w77b4Ne6gAxfeX+UH46uS0WUBle2riwdQKRpqibJRCho4Rr73ZqjDPxBJqMMpR6w2k0PuwUanyUqKPzK6zofKPohhrbyM9eTqJm74kVZrp9I0OWv93MLpE24cbHoxAGVh6C5NuM5ziC7+YPkVrGUJPcY740SuyCu8GyN6yPIt/d56/m4XVNdqlEAj+T3MxBFRvmGhiKkY8qxsQhv6h92qfnmU0kZABLtULZMUgOqvZLMlLzmxQ/OoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ee045-063d-4f7a-6b73-08df2523b30e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:05:37.0318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiRT0GsMsyRse9cnFVAHnUYh1t1Qgx9V2/71LY3rPeAIUuzTPRArPUt50QfOCdQhL5yKLzhsPHzh4tcodDyHIiasy8+MX6DKo9P/9ZVGo2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
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

On Wed, Oct 07, 2026 at 02:39:36PM -0700, Stephen Hemminger wrote:
> The cmdline_token_bool_ops structure was added in 25.03 and has not
> changed. It was the only experimental symbol left in the cmdline
> library, where the other 69 exports are already stable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 2 ++
>  lib/cmdline/cmdline_parse_bool.c       | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Though see previous comment about release note entries. This might be
better just as a bullet under a main stabilization heading.

> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 62e7df5728..3ad6ba2d81 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -221,6 +221,8 @@ API Changes
>     Also, make sure to start the actual text at the margin.
>     =======================================================
>  
> +* cmdline: Promoted ``cmdline_token_bool_ops`` from experimental to stable.
> +
>  * eal: Improved pointer arithmetic macros.
>  
>    * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
> diff --git a/lib/cmdline/cmdline_parse_bool.c b/lib/cmdline/cmdline_parse_bool.c
> index d5d5499531..ef41d2bc17 100644
> --- a/lib/cmdline/cmdline_parse_bool.c
> +++ b/lib/cmdline/cmdline_parse_bool.c
> @@ -18,7 +18,7 @@ cmdline_get_help_bool(cmdline_parse_token_hdr_t *tk, char *dstbuf,
>  		unsigned int size);
>  
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(cmdline_token_bool_ops, 25.03)
> +RTE_EXPORT_SYMBOL(cmdline_token_bool_ops)
>  struct cmdline_token_ops cmdline_token_bool_ops = {
>  	.parse = cmdline_parse_bool,
>  	.complete_get_nb = NULL,
> -- 
> 2.53.0
> 
