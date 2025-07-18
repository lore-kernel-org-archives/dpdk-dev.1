Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF2C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 10:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A90A4014F;
	Fri, 18 Jul 2025 12:48:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C91854013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 12:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752835726; x=1784371726;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gKyhO7G856XVbMjCAjFSHx9TByIOI79mLbVyS+vs0G4=;
 b=RxUBP1FiF5n7KmP9zC1P9b6+gw/ZxyKzmnBHoKrV3VmVas91x9zdKPK3
 0keZm0wZdS3RU//90+BvzBBbITO9CFIA9gvwIwnClgN/hMF+UQzk89eAl
 sNdhBfgSTB8yUjwzxWdez9dcX+CG6We1oeNFF6ho3VMrXOg0Y4TARcJwC
 32Symz2r9fZrtDRReDfN23HSpC5YWrgIpkOScAphAW+0yfOeqnNBoE6f8
 rPUxF68m4XB72tlNktAdy05y2YzGLAVl4Uj+Izvx4QDJwFw8AWAi8izWA
 /X8bXg/IKtNGx5f4DzttK5xOHEKk6j6tbKPECfjJN12kWRx2Ek+G1oMji w==;
X-CSE-ConnectionGUID: ugFansVORziJYKjU6+doKA==
X-CSE-MsgGUID: vL0QStX2RWyzq4QHAlBb/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55070183"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="55070183"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:48:44 -0700
X-CSE-ConnectionGUID: Ni8t4eMuShK6/JibOr427g==
X-CSE-MsgGUID: ZRy4kl4EQjW1eLzABl0RCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157415840"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:48:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 03:48:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 03:48:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 18 Jul 2025 03:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtC72HStFyxSQX12SIV0Qbm190HTzG02dZ0KBVGUWvKk9zAevB5V0EaZghjn+2C+Kzednd0axOMLe6pdyldW56cfv4sE+lWLfGt49/pRnEHFRvMQfQ0I4Z0pft3L/ooUR6SKUESM84GCSzbpbPK6MfIOXznz5zuQsIBT+UAq24I7IR1cDAmzn0L3Y95LvDo7AnMUiFUly8Nl5j2SI90ACaBDHEfryWjLEidY4GF9ECvVvHr8Y8my+V7VGU/lz1vXtRBTPgQI5M+lzPlr013KsVXnhCdUU3DAFBud976rALSNUDK3r6nAmaqJFKMefkCpFMEGqTOq7XKXz4PlrFOVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYLai9R7THDpHW0DLrYxibFfhmH4D6TXNOnb2AZf1ko=;
 b=gUcooh9SduyJt9Co1N588UwAxkjWtXSwKzm4uqrMsHPWwwDiNNJgdMbLrpIVvbztj/VskgJHxPBFoZkfsCKv9CB2Kq7w7cKMCN7tCKZX9EkDEfTkmThxsXPcQfHr0TtDGR6f8abojNsaNbWVjxGrKTwZOg6ACFPp4LUqw+uD5JgbLTrX0CVz0fNH5Ttqi8eGxtm0gyKaUw9ASGOnc6OzLvtkvUB7YLGaZnigYLxOmTtvJ+BDuPAiSdhEmwVlt/Pi19x1TSA4TogEplEfTkO8nnUu3o5qIWXcalev/xF9POvLWXJCK2CxIisLinLM3EgLtz3dUxQHX582TbXLnfy2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 10:48:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:48:41 +0000
Date: Fri, 18 Jul 2025 11:48:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ice: updated latest recommended matching list
Message-ID: <aHomgzA9qaeYdC--@bricha3-mobl1.ger.corp.intel.com>
References: <20250718020008.3364498-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250718020008.3364498-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3924e625-54d2-4212-0e62-08ddc5e8a8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f25PTAeclmfRAir5+PY8682XytgCSenIUe6e+olpCmw8is0otGxlVu6jUraZ?=
 =?us-ascii?Q?wOEjBo17p0rXaCLJH27nsFt905aAvB9Qbf91g2Rza9XB0k+hosERZtL0o+NK?=
 =?us-ascii?Q?MIO0SG+evDKEShVU0IJslAeNqtb4qinKQYG2AY8OIZTmkrL5VMNfJVJ6EYFi?=
 =?us-ascii?Q?Rhhi6Fu0F+ZlA5FYF5gJblLSTdlWIA7oFVquITx+6kpIReP2BBEuoH9NEXTv?=
 =?us-ascii?Q?eKZSiiaB36BkCExV6bE4i9gRHGu5yKz+mbFXCQB2XiriNOGPZJ//ntlgvLlD?=
 =?us-ascii?Q?y7/21FISfkGwc+W6QsUeirARQIKjR56E4/zSOeaG0+/pluLXejrRD4qXfTm/?=
 =?us-ascii?Q?9kGbg2kLHMQ2qgETfJE+E8/c9tAsbMTSHlTlBZGIXKP2EuOFn+ut2ZUas4NV?=
 =?us-ascii?Q?Yg+hfpgFTRIWsmEAFIlY6VKv7bh77vxgVnGVvFELdim5RP5Nkk1gxgjOPXT+?=
 =?us-ascii?Q?xKggojFIqyqGiaY9mk9kBGxBPkifnX4IafXtNV+X3E8C0kbDqKnj+Tlic3Yn?=
 =?us-ascii?Q?4/kh+4FZ4PXUAqtv1dsuWK+/+G0T8q1Tdk6ohUyViN2C4vXKLygqvjmYLoHb?=
 =?us-ascii?Q?dQpb4uEHb4iPIeDcsfaYziMvl1rdkH3CcRC3HvbnWccGqSQkc8p8Ft9tjeiD?=
 =?us-ascii?Q?2ltfTZmMzUmkcMWp6sKuHdzVllm+DZh1oTSXGG8STrqMQKgfdg5ZEe5ZwBjT?=
 =?us-ascii?Q?ltk2Vg12lMOA1b4GBbrPIEGhQ4TRggjQilTqMzFy+rHRB5gDXXweBFyjI5P9?=
 =?us-ascii?Q?bIVFq08pevSVBXq/at9+rvB25vgujG/Ak1kk/7ChcRv6DWCWsxhqXHDOqJIi?=
 =?us-ascii?Q?DHOUeG5IMfT36rZPHjK3Gv6wZr/PhW2/6BfNUJGMQkBvvFawCNyt0MYYij3b?=
 =?us-ascii?Q?2oyIbipVLkMT1Mujf8Jry4hrS2xrZER6LUzwlPY2Ski2+XgPP5iGLmtLLRCQ?=
 =?us-ascii?Q?9UbFqrvDcInbXU49KSIZNrMlEX+geTnZYs0hh6BzyI+yTaMyIeI3IS3CQvVH?=
 =?us-ascii?Q?/o8PpmEB7O4+1lZXM0ycd+htaDdX39g78qNbJZd/Y64HhZsZdLB5fgL16L2N?=
 =?us-ascii?Q?bhsUVnS13aed75G9C/hHp7gWAumTu+Y+l5B2XvapQsBXrdSxxIaTIyiJVend?=
 =?us-ascii?Q?iRMpU03Lv7cA4RG5/VzY31beD6k6kYbt7Nj+dOwVOECMSlMYR7dv8VUY1Q3N?=
 =?us-ascii?Q?SRKd00QgvVMEnqiXAzvwzEFFkAtoTWugzW/xa09VKIqUn5pST+kVsmL7KpbT?=
 =?us-ascii?Q?BD4vxRm43bhwd/UJ0CX+rn5hkIvAX7Kkxg7xIO6MlKy3mWLY82qPgsK+QQIf?=
 =?us-ascii?Q?alAOYwdsz46NfGm1VDv222h4Wn+wzo1kN9QLKcC1sY7YhYeVlqW67Q+vUohk?=
 =?us-ascii?Q?TucFBSG8OthB7YLm/gqC1Bq2Tl6SbHuSwXX+HTRZzIA31/UGU9IPamqXcAXH?=
 =?us-ascii?Q?aTrOZ5/+Y58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24GiggRGwdtXVrfC58qbQvndYn7tqM0oLHjbNqP1YuttjfsFnLUtqRtaHJm3?=
 =?us-ascii?Q?V79iazDx0ev9Nx5q3+6BYov9zuY6NUw7aovCH62zER/1hx7ibZrhzPR2hNLU?=
 =?us-ascii?Q?9R56JZLTJK0U9NtD/uR4mrb9gKseBlHEoYwIyYI8UKdGXHYb27wQ30xeDDZk?=
 =?us-ascii?Q?+M51IXdrYoFUM+U7Z2fFpSDdiFxyZdOwKTzTZdTwHkR9aohTAcG1FyZ/e/4Q?=
 =?us-ascii?Q?B2Czj/SOW/1SpRAYTuCbb+4GrUT44OOH5Ji4CkunYw3cJl633XfUMMG88dzJ?=
 =?us-ascii?Q?vP+FZdOc86DSeX/CoQH30TNeIZa3gzP4JTUySKv9Hse6FgP/0zKermI7ThKp?=
 =?us-ascii?Q?xAbOB2UXdt4vN6sEA4m/FiICqjobctMxcWVxB34vYi4mMBLYEPwnJevURRmC?=
 =?us-ascii?Q?a+iKkYuBlXNFGyFQPfrL4b4O0Zz4hNUW5a/dluKxmAKMV+v8hS1q4TKqwVc5?=
 =?us-ascii?Q?SVDv3knmtz913P9fTf9U6g5uSTergVcqpf5E5cfwsFLXDAZOCRPJMJfJYoUE?=
 =?us-ascii?Q?KlHU0vopwebH6EYpPNgoPG7V+dgHJtPTiL6jOhlsy05fVY80EnuiYUnGf0Pt?=
 =?us-ascii?Q?XQOi9a8+UGNrY0Vx3hgK98BEJTSZQyAhKxBjEMzreYENYstSQfAx6xP8teVf?=
 =?us-ascii?Q?vf6+e183DjzaHd5G8z/l/WhcwvsHjjlGtDq/Fy3/7mXAB0bgdDmPUUbxUATT?=
 =?us-ascii?Q?iEf8rFILvW+5a2t00DBi8NQ5sT6t3tsJA6cAFf0Qjm+MG99R/aIusMZVfCqy?=
 =?us-ascii?Q?0ybhwYwUytj8c9WFiEeSxBMIWW1OeNHczKtFpMvRRxJhd3zMdUndrQqVCHOx?=
 =?us-ascii?Q?NLU5hU/HeKJ7LHRdo7ZpsBbdn1IzWPuHBPGyxHoUNpFUzcPvtNKGKgWjlAlQ?=
 =?us-ascii?Q?DFI70lsAo2QNTm8Wk7y5ZMWBVzzI5C5w435PMxf5em1KyWGmd6gqhkOKMFg/?=
 =?us-ascii?Q?nWbvdGT/XVjFHNN3mvylchEEy8FhmW81HcepYQRDAk7xEqJyNbwjuNMDouu9?=
 =?us-ascii?Q?0cBnfkpSw7GsJbBNwBeY5NdQbg4cFZYfn5EjCJVkn32FAYVAsVhxO1/S6cNo?=
 =?us-ascii?Q?4sB+2CeUTZ+/fUXeO2lG9w0zi/2hdDqEfEf3MQylxvKBSItwv+K0iPfeTDhU?=
 =?us-ascii?Q?rOmzgWejeSShzF0bP6KrpKgHKVfBZGvjr34eYRWdqVDPJlT+njKb4PoxK99v?=
 =?us-ascii?Q?wBrNYSTTGM8/8kQ84xukoFKrW1PKRQ0KRqIBNxMIvwYj+mK4WsznHRFHHiOx?=
 =?us-ascii?Q?5vtSo2hfJxtUDQ6q4iM35YGvG0lyM6yVEWSVzhCNDqrGN75UEw2jxpjeWNvt?=
 =?us-ascii?Q?zQ9jzxWAwqbpAol5VxX9MxnUpg3FDO8Cw2JubNPpLZ7094Z7OnTCkv3g8a/g?=
 =?us-ascii?Q?Rqyuq7ILLhbuByUT1qOy7OzFfA1hviW6au/jc66zJ92UIhrObLPQh1dsCGLt?=
 =?us-ascii?Q?SK2iEBi1/o+cWUDaCjDyX5SmN+kl2mcULcjGYo872x6vXdqFXrZtTm5gyfck?=
 =?us-ascii?Q?ruvS4ATjNrPFW5IqHdnN1yCYwUemP1vHFcP4I1Q3KgsNrdiqpdcnbAyWKSnI?=
 =?us-ascii?Q?5dZlFyVs3Z723NV6RRufDZPXzsBLBGsrq1Mo1az9YkWVPqshzpVimBuviC86?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3924e625-54d2-4212-0e62-08ddc5e8a8d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:48:41.3516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjbi+OEwIgJO/jFL23pJ8ecJx+Z3K7LjP8jgnAeJLDsE+lxwgDAMYXRTZEZIvDp3tn1/vGQhbSPKpVXhzO/rfpr4uvf4Ohy/SO5oCVDKxMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
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

On Fri, Jul 18, 2025 at 10:00:08AM +0800, hailinx wrote:
> Signed-off-by: hailinx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ice.rst | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

For next release update, I think we can prune the version tables, removing
really old releases, and any non-LTS releases. For example, I think we
should list only the .11 releases from 19.11 onwards, and perhaps only the
last 2 non-LTS releases.

