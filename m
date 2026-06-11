Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2DCCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A3143007;
	Thu, 11 Jun 2026 12:19:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4135540041;
 Thu, 11 Jun 2026 12:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781173141; x=1812709141;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=12Lj+CJ08+FvDQjet21PWOW13ts2WnBZtshVLtHkGeA=;
 b=T1HlG9gJ5eWt8CBPHgmqyaYcG7OaoyXwwTG8zOPWQqlpUXPFWOpBrmN7
 hvuJe0QK0vyGAuZh4gQOnNT28j5m3OBvjYSWsVNki5i8Qajbn96wk8Boo
 2dbaZE6JLIeAeK0T6ASMHR/Ig6l1YehLXBq5XeVdVGWejdoYEuefG8bAd
 ew29JNAR+L+/ruUsvbrTAPkBVEc1Fn7fTY+i4MLDMFz3RwdMsq9QAp6bO
 BOh3yaEeuS8K6u4M1HM0RPLUiDXSyFEFb9FUW1piSLVC2OTX+hBDxzCcI
 5SwyL9KbWST+CLiJl3RTxF4mAduHt0+UhY0IgZHvJHsQAiU8FlMwAqSXs w==;
X-CSE-ConnectionGUID: GPQ/4uvUTpqypdWU9NHiIQ==
X-CSE-MsgGUID: RMALcHyxQV6XuFMFnov2Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92547183"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="92547183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 03:19:00 -0700
X-CSE-ConnectionGUID: fToKwIisQ4ubpHvNpYeUgA==
X-CSE-MsgGUID: 0+wast12TAmHf8BJ7z3UWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="250360862"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 03:19:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:18:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 03:18:59 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 03:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb/T/g+WDpzV/kbzCp3ntVSFW3tyruaIBx8FoByTSWHwpbqNHjPoTXf1qSPwk3/HesfjT3Ql+jBRCU99zKT3yalT2YXbHd968ucCfq0s8AO0xGEawGuJYKw0YCnyISAV0PWK/yFJh+vndwXz+YLZoaZQ+VyU2gr9w/trujzw5EXtzug+KeTBzXMc76qpmrt1gGTLWpZHDeeKTuW9Sa1p1cU5W7ipxwUJC07SDZcGijVcKGQyMfbkxot8w1de4BM39/qQi7UKKJ0XBlNJLrO0yfWqHGYcTsMr997G0vcUD4fUGgGJ9EAs2tYoVIQXXm9MV/G/KTBbnA2hMaNGnCz3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2vGFFh8uAFlHNwtkV/R7VarkM7TozfO/tRYeBdPHtE=;
 b=GChU8AJbv7F8IDBQxQ3XTUFtgNFjgyj2QYdWOfCMCRAdSI/XaOQ1XUyhYD8KupYq//aEgO+ro3G2tvjmvZh8J4nyoXX7nbR3New96hz0Y2ZxpesZpvHu9/10SlBF56xfosFLtPEEWSvKNZwWR0TMhZG+rzsSgZcg4JY1wJXYgRBtgTqAEcKo/n15bfh91HcPB+ZIUqdEQMVth+TCQNg42KKLZA+K+M0eMoJhCkP4PRx1ArO6lDpNM0Nub3eVADNMO7gWDO4neJ6tv0egd0E2EXux2yps/PBelE2MTQJyIKAb9NasHt9B5rIb6e7a6yCsLiNb8AYdwPIJ8FO68WkLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:18:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 10:18:57 +0000
Date: Thu, 11 Jun 2026 11:18:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset
 recovery
Message-ID: <aiqLjKjYC5FbaTqZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260610154306.371431-1-anurag.mandal@intel.com>
 <IA4PR11MB92783284E084FA4FEE8422638E1B2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92783284E084FA4FEE8422638E1B2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 39826d87-ebb7-4340-d0f0-08dec7a2d8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: lWLTdWHRhUAmkLrl6/BUf1uziwBmuyL+XMdnWjXlp1sHrfg7GuDj0czvwcVZgNbA6+CT+Ym6TDE0UoQJisBEuIUzvsUc4YxkLWWPM1jjhd1WHQ6sEq/QXbIgu6QCl62MXq5U/rPpLURMh1d6IcxM4iZbDWVE2fxqAipime7N6HLG7S7COXw1CQfsNi8qSAVb9haPBo4FUGEw8Drgg09o+YFJn8k9qaZFgRUnaSSWXE2uXeX6aB3EHY5+oAsf0j7dlmdIJAdCP5tBLQpK1LY/zLCXBGAwijUnX794IHD5iTNVNTLtL/dq+dYRnAJVp9uww9s6yOrvIlKbTqZWvOHGm/aSI0hRiBUEbEwFxabftDYVBC2pUpYqEUwEVrzfDerFhrqiiQ8i0WDM/zMv5B9SE5xF35TT9PPrgwYsFK3S+VjRaSBXPfTkFczsNEC0MxizLfLytZ0zS2GsZ02lDj6HshYvcNv4vCfGrW0B2DaLrUAeYbnNuPGbgMPO/7eTOfDtkRmueBkCHD9QLTdkm4ynGK+7qEtdnBwPQSaa9lQP10FMrJgV0FCDFH3euPnyn1RrFu0OUwAps51ZdmhJfM1pLKHcJ4/O8faw3ImTSo70+U69ENn74J/cBaa0DACOvQGV5DZDdCNM5Z/eB1XHLRwII5xfb4hP5aYsobes203JwXJK35aaZzboKWxAS5ZLN3x7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+xASWhCKFnIh0/x2ZMSuX6owUTZQOni61eETTlPtyemRkZeQ8icJRR/N9x4?=
 =?us-ascii?Q?WMMudjO6GzGkIGPmTOGmBsCfM5JP5d48J/L6x+j1QcLRYbENKeBYT3NcVRs/?=
 =?us-ascii?Q?GmjmDaM3xmZdcw1ePmLtYOTtEgMX2Nv6EiHGM+Nj0Zvm3+jfqXrss+w9g3GA?=
 =?us-ascii?Q?qj2fWxl8sZ9NKnZewCGvZCUKrXhIlap/rAgecViafVcLHmVAHGfm7FhPohWw?=
 =?us-ascii?Q?Q6bfQ+VmYg+YaVWVMLfi8snx/Frbe/bYy+JWvF38aaqjxlXpzNQPB6JbfYyp?=
 =?us-ascii?Q?mXVQTZWIVS0GvRF7jzb8jo8VBL/6kcSrIqtDEd5b//bI9/r6Uym7woUD2dlo?=
 =?us-ascii?Q?aKD79PmbSQ8pKsSAli1wRYPxYc0vPWkDB10n82wzUsc6dhgt8siDmWVNDOe/?=
 =?us-ascii?Q?Qj7sZLkwt7M4ByZwMLB1Mapo5G12FlYZRSldaKheY3a1Et1yhj+Q4a4bKDMI?=
 =?us-ascii?Q?hvW3XLvY2jG6ebVAAm9UEWcB654eQZ5E1bsLYt255HMQcUmmYUIcCFW40gzZ?=
 =?us-ascii?Q?FYLnn1fF73gHvmmPat2EYCVU7Y5Md3WEu27oWUa3SZQQ2FSXba+OuJEzg+GI?=
 =?us-ascii?Q?LUcLF9joGzORhfQ5r6BfIYn2UVH6gx5B/zZO+zpLtgmYIAzXWR9QP54jMdXL?=
 =?us-ascii?Q?pkZRxbIv4XGh30kAFjS+URn8Gl56EXqS/2Y6mWR1NLcvKh1V3RiZiaUV+qu4?=
 =?us-ascii?Q?DnF6JRT0qyWKAi/qnzdzwARRRnwmWSG+buJgd+EPg1Y4A+0DwvoTmABU3GC5?=
 =?us-ascii?Q?n65K7eEsR3YJ0HRb5itJo+Wvehpq0fOraseMagw/2/UEA0iyhMORJ9g4NaSy?=
 =?us-ascii?Q?U56R1V1eNolAPDWNXkXWt/cIGMhttMgzgNKs6fTH4oOwxh8WJBdU5VzYfBZm?=
 =?us-ascii?Q?3dP8yMMTNwijHZ256IXQ5G5f8c611ZwcB33QzB6E0YaN8DFFHg82CJWgYG/l?=
 =?us-ascii?Q?DkvQ4DZlM2ktgwgJLRe55kYiDn1wY/DQ6NrwemD2wsI0HMut+MdXRUYXEjbv?=
 =?us-ascii?Q?h+sOVtaZX0pZvQqMcB3Rigbj+gEFHcSNdyjVFmgbw7zfYTU1qOE0a4bW2b/9?=
 =?us-ascii?Q?y3VEnJuiXPjgVgXBcxH1Hsozn5DpLQOxjilGNt/vgDMj+t9ThfgWnL9RCzUW?=
 =?us-ascii?Q?wvI5krTPNNlZlv/w0dxIycYLpDzlqJxNnI7gVjrjDomJmc/A+ug7HOktwPZU?=
 =?us-ascii?Q?Zq8LWvZpt2e3zuPo0rBaBM6B9SLvXx4fW9HJX5wwzRjG/LeViE0657QZCLYg?=
 =?us-ascii?Q?r4JJVCEd3zAOjJvs7jMybkMU2tZzCH6V1S90FXMDbAmnhh+Qcx+RZfhNGaQT?=
 =?us-ascii?Q?3SQsglN5XOrEnsTz/tUonEH0623s0IJzobISJEMaEJRgG+vW/lDnkQWU9rxG?=
 =?us-ascii?Q?p2sqP+oK/deJaVqgoYWQ9DfEeQKiNQ2jAAnUbwv0DOQLCB3Z7yeRblfjw0FA?=
 =?us-ascii?Q?eT3L/amxY0dNwddDuErY1YiiYReQsJLnh9EbO0Nl5WytKBaSBp5NwRTNCbtn?=
 =?us-ascii?Q?E89Wqz6v4gI+3unxTrorajyOyb/uMCX3ZWIMDd6VCQRZYJlD8FatdU1snOpI?=
 =?us-ascii?Q?FvSEeej/Le88LOWiQkTH8rraSulmuGUK7xU9+/Mf5gqAeBik/UjadUSmD1/Q?=
 =?us-ascii?Q?sCeuZohvT+9HK+yqZJR2z43KjTYXV8V0eZ98c2Xdjw0PhPebK/DDPksL3bOk?=
 =?us-ascii?Q?/tzpKwiNQKyWSey6MAnpwzBKCVe1tbhh+G1kPy1JBXt59dVx5vwvmr42mIfD?=
 =?us-ascii?Q?3zpMIxbqxLFS3Iz5NHurRhnB8haQwzk=3D?=
X-Exchange-RoutingPolicyChecked: nihE+20KnZNZLMqvvaf0KfxwV+6d/vLN5mmiNnAYpIcl4ildxXcoSRdkWQsrSJpl4bhQ4ZESJbcmf6ETdxkRZ+IKfDMIzy4jN/b6ZshQV0YKbVxWXZU+W8ZSyVKhYaoL2nIHRK/UJXjEpCfOGtu4TXLIHcGku+M4ebBaFOnh9THT1UslejlKbW4LTTq1MsdE4Ehtc3MKKzgHN1KNLnT6rMuKFS7o4Dmm07GbWMvCCtk5LHpgJni2o3UKjr2ir5dGsuFa8zpqIp7QR552b+0oRTn0ER1dAlsiK5FksCys+gH3vrZkDQ0labuXVKX1dnW8OWc1j50dF4z7wonvTcMGfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39826d87-ebb7-4340-d0f0-08dec7a2d8c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:18:57.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRaCBMToGVQ6ymrHb+tWUaGIG1dcSBRxeSJvtKRhFKVzFcC87RkF99p23OjRFMVVtqHG0KRieaf6mRC4QpPR+ha56GOT3pVGKtu7A4Uui7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
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

On Thu, Jun 11, 2026 at 09:52:39AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v6] net/iavf: fix duplicate VF reset during PF reset recovery
> > 
> > During PF initiated reset recovery, iavf_dev_close() sends an
> > extra 'VIRTCHNL_OP_RESET_VF' while recovery is already in progress.
> > That second reset can leave PF/VF virtchnl state inconsistent and
> > cause 'VIRTCHNL_OP_CONFIG_VSI_QUEUES' to fail with 'ERR_PARAM' after
> > ToR link flap/power-cycle, leaving the VF unable to recover.
> > This results in connection loss.
> > 
> > This patch introduces a new flag 'pf_reset_in_progress', which
> > is set only when iavf_handle_hw_reset() is entered for a
> > PF-initiated reset (vf_initiated_reset is false), and
> > it is cleared on exit.
> > The aforesaid flag is used to prevent sending close-time VF
> > reset and related close-time virtchnl operation messages to the
> > AdminQ when PF triggered reset recovery is set.
> > This is done to avoid duplicate VF reset requests while preserving
> > normal behavior for application-driven close or VF-initiated reinit.
> > 
> > Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> > Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > interrupt")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> 
> Thanks Anurag.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel.
Thanks,
/Bruce
