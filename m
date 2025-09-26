Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DCCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 13:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B83F840664;
	Fri, 26 Sep 2025 15:08:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 188314028F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 15:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758892109; x=1790428109;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jKpspuD5dstNP9uFDyFYzcXqWr36gW0n0q+apbpwli4=;
 b=aKM+6J5ALfasiNJH1/CFKsApB3IEvYGBTsBbNTrgmnHoQEgGatzRiEJd
 hRbOdNA411tv7UL4V+0mYhhEYXhQtdlSRkAEB/8x2o1JLGikn3Quw+rJn
 HLOqrtu571iYi4Z1OswoHUDgk737tmOtZzelYy00PVDjMvpljQcy/RY4z
 GFqtgb9UrOkwRVgx79+aWK25Ood/4LmectqSfAQvNyhfmM/r4Xu2+I0S0
 yB668LjcpdrYifGtv4pkXfCNh48WB3cHesrIssBqe23mYnLCSVTWe5Dzh
 qoxr9GVLzCnKwezv9Oylyf7X8F+ZRVCmKtIXvuRC4RTzQXfQ/aUP+zwHY Q==;
X-CSE-ConnectionGUID: rBfFqJ1yR2216KTd/2LR9w==
X-CSE-MsgGUID: cpoBlIpsS3ewlTRUrFsc4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78656492"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="78656492"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:08:27 -0700
X-CSE-ConnectionGUID: QXXBb2fNQVuD2g26OMmCpw==
X-CSE-MsgGUID: xu+EhV55SDCtZaw3iaWyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="182778703"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 06:08:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:08:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 06:08:26 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 06:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXHwXvB/ji53lKg6YNTdC5uonrEB+XYk3hTnqVOEHAlVTQn5Q1XLoKrlsKFcW9vcF4jJIvlmqoFk0i4kQ2akjhAQIihaRT/o08gCCBPUx3Ne3yVzr2BtKAKXZ4F0G1nVyfuRNrgOE0tYBIkf/FPCbseMgEhG2/Ey3dloqxucyDdk2n0lqeaK5DGmjL0yNMWALgvUE8mFhaDWhgLEDbP9GT/KnLnzIkJYhAdFv2sl3usKU+P4wbf2Dxt5/sIDPmJEY9cF0Vx8kVK9efpb3FCe5O8t2zznn+OZkICzAh8nnyrtI9mYMzXSIIsagik+4kTvTE54ssQzyFFhB6abF576wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QssHzLQFTze+FH264RqMIGSLNLzmhBsWtiffzwEW4zc=;
 b=Al6Ct2p4FJC1uQjO3reo6RCQbK3vrimI1Xjd2tzSYE/wkDa/A54KdBnbSifmY9fsyKdzda9DrrA/58UVNz5KLK2wb280r2mb/0V1A/8mlSDFtjQikqZTe7zIC6W9wKYtCxp7mCjtlnZCtIntYycegc6H+eTqby6tgJu1mOf8QowoHfBknL+jbm+84eveQqPst+MEzA19cq/T37EMuUcXK0dFrDhz4W+waDUnJIzHOJzAgzvPVQrZWiaOVFD3sI+48qhyDCtGyjC/9voyuFNZEph8U9XoPp8rEwxIXK9VIMO5HzeIBmeGITyDTXn/MYYGt6DWE4/7opnD22oyZquohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF821BFB4AC.namprd11.prod.outlook.com (2603:10b6:f:fc02::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 13:08:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 13:08:21 +0000
Date: Fri, 26 Sep 2025 14:08:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Min Zhou
 <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 =?utf-8?Q?Stanis=C5=82aw?= Kardach <stanislaw.kardach@gmail.com>, Sun Yuechi
 <sunyuechi@iscas.ac.cn>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v5 7/9] build: factorize headers installation
Message-ID: <aNaQP2v6RQS6Soby@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250926124103.750844-1-david.marchand@redhat.com>
 <20250926124103.750844-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250926124103.750844-8-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0343.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF821BFB4AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdb5d9d-e705-4fd1-3303-08ddfcfdc4c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmezvG3z3bHyMxand9NVlAMEKVhx4q2lKl3N6Nc1DVfjvgHlWYwjHkR/QZfF?=
 =?us-ascii?Q?5CK3rFeSLHsOLl9GIYvxvhPyRLREiKNkgrJz1M8YmJdV8TBt7I1Zx1Mq5SiS?=
 =?us-ascii?Q?719ICL0/To8yUVHFiV8IRdc2Zll7ilxlTCdoVOZ4cFQ706206qBqwzOSneR4?=
 =?us-ascii?Q?nCRmihF2U1+2ETFzZv+O+TPJrRGkppVo/pBrMDfhfFkhcDNomZ3hcouz3m0c?=
 =?us-ascii?Q?mqZwmVd2pTMOpOUl3gem3D5idu8doiOefM2xDmVB2lmvYCM1at9lwDVoyHT7?=
 =?us-ascii?Q?c7Pfc/IcMzceMV/EyghFMvRs+e4PXBSiXAdYdHjVGncbHBlA2bX/gXDxrPS/?=
 =?us-ascii?Q?gBGM2v4HiRcBpmmk6QG/S6sfrQNNXl/4xGOSkcSrq83Gx0kjiDLKTCUFhNQr?=
 =?us-ascii?Q?VImHxXa1dSdQRg4WzWcrnaio1PJrlPD4Wm5YYMMS9vaoDbgEpd578KWNetS/?=
 =?us-ascii?Q?1EMw9ltbTJMYXELnasuyR71f7epL8KsOQV1fC4Ztc/tooyTH5ptts3FGMsvq?=
 =?us-ascii?Q?k5VujX8AZjNBouEpjMiPzCICe74SlTjv3zcsf8JJ9lQt0/vkt1ZuTFY0dJKX?=
 =?us-ascii?Q?eU36FrulUDs0Gth2RU2UGyGtbApOzHcT9SJcY8OMWhG8tRL5nhz5evmxePXR?=
 =?us-ascii?Q?d8z+gS/kONO4/PrLJCaj97q8OPbAlyPTO9mxyzP4sVvtdOwr4PNUOpmWX2Dv?=
 =?us-ascii?Q?5ANoewsQbXGSPGi+X7YuHxLPn2sp2aSuVRqZIn4V/z3zllZcmMWQTXsQTC5S?=
 =?us-ascii?Q?g33sg07LyV5CIMEh7/vMFwaJoQG8aBz+p0hWBUGDErLyBS8Sxa/lsIkLaoUD?=
 =?us-ascii?Q?9Trcg086i+2g/qocXS5ikjXXKJX4bnZyfcLL0ypor3L/G6oH5hhV9eSGTbKo?=
 =?us-ascii?Q?e/gc1Ojlo4427M8KLQfTBC2MMm+WrTpFoGXeLstWfLYnIrMl874hQVQYPU6Q?=
 =?us-ascii?Q?kh+CxqNLpWvRl0AiaYDgrxqmNhsu8VuuN6V4WC4qZ90sBJLGBIZeN0bTpEzw?=
 =?us-ascii?Q?QOJTMRE/37CoaOE0yzkYK27lONx9oeZWQ+1hKXz+XAdfQO0p3axM+D9ZpaEB?=
 =?us-ascii?Q?ZGWqqxvWPpOpsDHjKNyB5CJy4RSSuxxHa9D6HoD/ZcbdwSREqslys+KaYb6A?=
 =?us-ascii?Q?Z9Y8O77B/jAIsaZP1OAY6QuTBS7AQ4T3sFk2h6FJzwp0nuwZjo/DsafLOaz1?=
 =?us-ascii?Q?RF4ShKTpx1hwZwl9cAcRyVbf0yWnqgt0LXdxeZdKN4u7f3offIONCgWwoCIh?=
 =?us-ascii?Q?ys/lM1YU9Ztw2GG+LDWuWcWIatWMmCU/NQBZMd+sSJ4oo8XhZQvh307q1Cbg?=
 =?us-ascii?Q?K8H03RQPIyqOd9fJszMFuUztkqWVSVgaRLZrLvp3F1eNrdT/kVQCVlNofTcz?=
 =?us-ascii?Q?cQVFFl12ntGeQ5t1IClOfIlNUcYEJRi/7LxQBGF3A4d0fU5sob8z3+gj2vl+?=
 =?us-ascii?Q?rJ/GviL8a6wJuCOXGyzIpAeRGrjmV33/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0cKASaaniKLrAbv+VHLRRNlN+wYgagmGS5kTfVHWoIY27PnnDEkEq+7PVkr?=
 =?us-ascii?Q?WJpOAprxa2nmeU2cpQul0YrOmv46g9N4DnuGsQVr/X3ZMa+voxUj4G392dGy?=
 =?us-ascii?Q?KPIO8LdsH2MD2yVaYACOPZC7t313WIgnsh0Ij2h6/74CZ2lzS6O9JlTQJ09/?=
 =?us-ascii?Q?x8ZpVn/yT9JRljTiqww85hzOAYAzMRFI2nfknHsRZ+HrzsAKoAsujKUTa4b1?=
 =?us-ascii?Q?Q8z+Wr21tnGvIXu5KfollK0+pjvG/fUmFSP/Hn3BGCEn4oJnhBOUyeyTafKH?=
 =?us-ascii?Q?2BDaAT0G9MK9U65wNsOXkMCCnS38CJ78HH19CV7Lqa6eTX9UqbAu66k/dVL8?=
 =?us-ascii?Q?CULUOtd0TCJiNHAhl8SyZSw3OWTAaQsvPVS/NpNV9pcuRcVm6RkxKSbx15By?=
 =?us-ascii?Q?wnQIqLH7e1L7TwAkhelwNCVxa44zamVSIjuzAqHes71WjhMS3nsPwEqQ9P2E?=
 =?us-ascii?Q?vzNic2eUul922YIoWU0x2Qh8H6zducUROOIpGZaxgI5AjkzBCsPnIP9qHn76?=
 =?us-ascii?Q?RQTz43DVZokGUyjpNhGyr/N5gIONgxaG75kADOJDcIgTP3JKniD5TsUPfonR?=
 =?us-ascii?Q?0b6TGg0PJTVqzF4PhFum7NMvNKjShYRkum4gi9HphIavOlUkaMVQHYc4tpGR?=
 =?us-ascii?Q?bwQ54R+HwTmdI3iJYeb/yhkvPaBeEMuP6dj99qtibI3Ddw2wr0CghxYZxBzB?=
 =?us-ascii?Q?Z8rnskUE4YPaKdkUEVU7oDHEe25uC23ldlG+uEv/VUrC5Wy0Ug1zDLJW5B0b?=
 =?us-ascii?Q?CI7i0GTNHJzNQgW+Tlc8KevNStipvFV5I0ZYO0BzN8GxhuirpZd2rZREwrqY?=
 =?us-ascii?Q?ROryb0K3UHxmKbAxHDgU/Qpx4Sw6pdCCS/C9ifmZgtZDHnHV3zixN2jL29yT?=
 =?us-ascii?Q?E9tgKKmWdEKcl+y3ed4F7/Vo14MMRtE8fd32iqmj6Xex6KJWz4DUYx0wiJll?=
 =?us-ascii?Q?7Vc4TDYRQGWrs+MjffJ+jpS2RPZRveRKb6u4BRHVYRHwV/g39NSD2aqZi/yl?=
 =?us-ascii?Q?nAkS9qI8e2F8/oKsl3UVps0lrzE7Xg1HZnhcImPStm1nu1wkxXkZ4YzuWfBv?=
 =?us-ascii?Q?H1/CwYV7WQbc/lO9MqPcoFWmj5daN85/EpJQOYKS7Yg3ZUrM5/4996N70OiY?=
 =?us-ascii?Q?9k6IzXSxqLtVmQNXxL4QlY4BhBsSBN2+FHkIbvWOU5VTFquyDcyY4HdiwY7P?=
 =?us-ascii?Q?B7G2WlDAv7/SLnb5eAX6GnkYScI3BIYmYhfvTBhACvxbMHpLxllhNobcmIZ3?=
 =?us-ascii?Q?vNQ4Gu1IEiBqfOc5LjEzDR241FU3BGKrAM+G1yBx8NY1YTvkTX+fTcnZNB4M?=
 =?us-ascii?Q?tZjWvUG7o100xFOn+v8qlIWNoW0K77r5xsyp8zkC4gAABKhOIcWvWVHeuZZp?=
 =?us-ascii?Q?sHGcp95iEyLVt6z7ntZQVC2dKCqE5DxswtPxiOrnG1ji8J8qVmpR+HHU1Hvp?=
 =?us-ascii?Q?6odozRj6QalxI9ocUOjOvsCgTIN2c7uY2Mo7y5g8T8HkRXBs4j0SZqIVYLLO?=
 =?us-ascii?Q?ySL5/mp3hu7evU3MAgwkZT91BmQMfUf2fDjqoYpMPeiJQLriBcCCwbiorwO6?=
 =?us-ascii?Q?OjTMG3Umzmozc03d72AS5afYLP908qD+McUE5W7ZwKXLmdQ/ILchQj5wQJE/?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdb5d9d-e705-4fd1-3303-08ddfcfdc4c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:08:21.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P15XLWYHXRvhoKYWiWTu/29mZY2vcw1m0FJyrMZpylShTu/eokC7uRVYdvvLfRCUOLLM/32sC0S8dDW8z4AjhGg6UlPRUn7UsKLkoa3tA8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF821BFB4AC
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

On Fri, Sep 26, 2025 at 02:41:00PM +0200, David Marchand wrote:
> Gather all headers in global variables, put headers installation
> in a single location and make the headers check use them instead of
> dpdk_chkinc_headers.
> 
> This rework reveals a number of issues:
> - net/txgbe driver was directly installing its header, bypassing
>   drivers/meson.build and skipping the headers check,
> - arch headers were not checked except for x86,
> - some driver headers were not checked,
> 
> For the last point, a build warning must be disabled (like it is
> globally in DPDK) for headers from raw drivers.
> 
> Finally, checkpatches is updated to avoid reintroductions of
> install_headers().
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Good cleanup, thanks.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

