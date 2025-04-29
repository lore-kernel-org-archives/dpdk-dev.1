Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0CC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 14:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C286402A3;
	Tue, 29 Apr 2025 16:47:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BBE0940277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 16:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745938052; x=1777474052;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EiTJYDQtSMySL7/z8QLRgUDJ2u4D1VnJrQ3hDeZoE9c=;
 b=Z/QhrroS8FowwIGW1wblZWOfyFjMspDyXeNcDT0MDW71b8VIxlGqG2RV
 tqrf4Hh63c47i8Wp7U2/55GZBMvogAwgPUQ33sDF0rhGoq33wKPLWF1aJ
 8AQNCi53MZJI90/Iaiimaux6jX+ggqj1CRBw0DQaGcNr9G+hM65829X7I
 VcffFZqhj6g/9Wzlj7Sg4itOpym3SyBYZXk5MxdbHe5jWArxiC5yslWiA
 ztNIiILCq4t4R+mJ59+CyiCKtoV76FD7eTyGafDQ3rKCIYtoqekcj8qLu
 645zf66pAQyKf7420282P76lwJREffLc0RMqgr12m9HXb5ByQkHg3VW8d w==;
X-CSE-ConnectionGUID: 0nMzyzaTTWSBAlWjpPp7RQ==
X-CSE-MsgGUID: OCzo+3x8TfSiKP1rGHzSaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="35176618"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="35176618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:47:27 -0700
X-CSE-ConnectionGUID: 3J+PRCEJQhCpiPFLtT982A==
X-CSE-MsgGUID: lumkMvEoR4WWqlEVdcTjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="134346171"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 07:47:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 07:47:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 07:47:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 07:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQhFI2lE3Ak+5tX71JrGCNscMYWH43DyUd/KgT6/NV1aAaK0ilQY3Yhh8vDhdF7PtXWXxv1dYAVVn22ZO8mW/3lj+hDhiE51w1KNy/fmKzSPQk++2K65j/2mPAsebPdbPi3vI77aLLXw/lIqmetIfb4HV5SsX93B1fcw+1ZgAuT3aAnELykoQw4ADW0vKZmtSqh8PqzGlSwP8HqnRp+emV1Pg8FeCpKQcGqrjots6ZRNrPCmyIBri5BNqka1DVH4DAA12qH8GQaf6DkbcyVobNss+8V7vrhRvUY8biGcbPuzMdZtJ6rxY5+XZAGxHCvR4JJdPAOdgrZ1FDxNzgeMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76KToCICHx5QFnqM1mPBpIuIxZKydh00PFsswnDMNBo=;
 b=w7w/S61HPUP2sP3FHWq6p33aPROhle2nFFc7ZtS2mE5Am0nVmCah4LLz5LPEuqLGodHipWdtP7/2QEzxgF4sjh3hz8K+oXclMH4fk6xSx9cvNmO+msu24q14Pvob6S9zCnmJPwGYcskKqpio5ka8hQitCQGIr1+Jee4bE+CqLxxhH8kgt9K2jJmzuRHMIrsOx7HaWjKqcyBTyPpgb5D+evaaAsm1xlRlAhRjxXBZs7yMJFEOTmtEh8jNzfUdqLhiWHXVvNXRim0so8J3xoZxZ+OckLK3JNq+5obSYpSWAWllJ/67LNomZyoHeC+MI1obzQgtz6jrpnk7aCk0+KKYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 14:47:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 14:47:24 +0000
Date: Tue, 29 Apr 2025 15:47:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Roger Melton <rmelton@cisco.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/e1000: support Rx/Tx burst mode info
Message-ID: <aBDmdRekgks8RqUT@bricha3-mobl1.ger.corp.intel.com>
References: <20250416173057.372482-1-rmelton@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416173057.372482-1-rmelton@cisco.com>
X-ClientProxiedBy: DB8PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 75260c2e-c096-4b1c-89b7-08dd872cc0c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ByRSMyeg7g11Q/cg6hHmdQOndGPjpXIYLDPrsNu3V7HNBQ7A9MzZ0XB619a?=
 =?us-ascii?Q?qZhYeQKHFYnDEV565PLpOcz69iU0heVSlNF1B7Xq/hcF8IjYrzzm2sOrIEXN?=
 =?us-ascii?Q?HPoGyKgMjl4v7mFbIzO6mRMvlJMehi5wyUgdbQx/M+9XLB1NbSFIH0tr0izr?=
 =?us-ascii?Q?ApZ9PhZaxZVhF/Q2n+MEgPCssz6Ois3Ni4Pn7pEjdv2EorJfeDEZHIgas6GZ?=
 =?us-ascii?Q?yRRpUgeIaO/1CVcMJh2EwK1vtsfFyLZwNx6v1KuZHTVGaDoxnK/XrsPRtkuT?=
 =?us-ascii?Q?MxZDDTuovl4mwKo6oVcLOErnHg+27Umn5aWkWhBlmP/MXhNz+igpx5M8KeLO?=
 =?us-ascii?Q?ykVTa9yxwMSVrpkxDoYw138xxyCWXySGzulLz06Pe8a/22TcUL5iJQHB3w+A?=
 =?us-ascii?Q?xXDp+XPPuJaaLZFnknOehPS49y7YtpbsaOJLVGZih9FLVPLc7wF25Nc8iOSr?=
 =?us-ascii?Q?2p69P0UlYgRl2lQH0ypuJCtGXQoPuanvU1uinBGCjNtIzEQD1zijdQTuX5Ba?=
 =?us-ascii?Q?1GXEVsoCEWSjLbNZN2sP9N2y7kuJgo1A8ug7JI1OO2irQ4zcCNfR8DGWyO2E?=
 =?us-ascii?Q?G4g8Yoo/XH6ZkQ7Ru59PHsvc1iiyHUs0+YxnT23e+MyweamsugVbcfvM4LhQ?=
 =?us-ascii?Q?D7sMb1eoxbpO758r1r6vM12f7B2WPRetXTvnPLf4HRq8lWt78RKzzPEi5hDV?=
 =?us-ascii?Q?g+oEFwFkeMw8xl1z9QQ5ZwE0B1uweagIJT9spSMfE1J4oAUqGSiXWj/9b0LK?=
 =?us-ascii?Q?jX7PW54t9lQ0z2Or3YeCCbHIevLpm7RMq8WF+r2SJ7oD3aPNuJY3JjjAbSxu?=
 =?us-ascii?Q?jIquvcoHZipWm16SurhzHUeV+XHZ7AwS72bQphKHIf7irXqFwd4+NMDa+oxb?=
 =?us-ascii?Q?w4FydOb+3kPGHK6ATfZIm4LP2lrlMP/eLeHpQUTesI3Kv7cV5Z0kup7Qa8tc?=
 =?us-ascii?Q?nF+d999OUuFoy/b7aH7fWDlJce3HPCn22XKUaH4i8nM2N9mi2oEHVez6vehO?=
 =?us-ascii?Q?DmjirTuP/E6LqVGXPObdl97maBAlKaAdQ2zEno+VTjkL/8O4NuZ+AQjLcNFE?=
 =?us-ascii?Q?AcGoyL4NeARRMqvB7hUpLUidxrEvbkzvSPO3e0nxqB9U57XSet8/WXq5haN4?=
 =?us-ascii?Q?8J/2Qt08VsAptbd3dCmQz+HFPrPRPJZC2Aby9LOoYBU1Zt4ggfO5o8DGMmiS?=
 =?us-ascii?Q?/p1rJ0ApDndgjyUvvtEZXvP8znKR3rg19oeL/lwcsf7InoRL9UOxV62gqg5Y?=
 =?us-ascii?Q?jT5/OuQJNG5ukm2eFlwbceCS6CFmM5hgYdkNTto74Z89zb8x+TEgV6VnzbHv?=
 =?us-ascii?Q?GkUyP+ug510kqjXK1tgSFAAY7TJiduva14vKy3BBbs/r98qh/oGZSpx773wj?=
 =?us-ascii?Q?So65wFhlf2rgK3PuGUbVLYysPaFdNuQcpwSuzCzNdcUUU7rOeL3RsdoG/Vkr?=
 =?us-ascii?Q?zfo2EPXKwbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?if7igo2C0xrW9OuDqqYB+mLd9TUJEg81aYcdi1N+ZUyHCQw239vxoOzxuEQC?=
 =?us-ascii?Q?ytgaPXCRhtwjFh7SRPFRvXqpWwljcHABZWTD1TC9R8my30w945EDzTAwS07Q?=
 =?us-ascii?Q?9F7wu3Ipw3AOJqTmqzmUExa2aXwIaCeEBmvBcM+fLwQugJYj9QrQUCQxMDU6?=
 =?us-ascii?Q?VVUI6C0e32FCidzGK8P0etPjR0T9lLhAQgd+1cDmxRV7NWJlYYF/GdPUoAwm?=
 =?us-ascii?Q?at3pbINT/58rVSuyDaqpdSPalBfRKV+rC+ibTP5zn6RR6xf/ywc7YyZJ2Y2T?=
 =?us-ascii?Q?b2uPAec9ZlgPGQFx/GWAx7ddB6cwoQIqz2lH5KPl+ppSEu1pbafPNtJgd5N5?=
 =?us-ascii?Q?Hxs01Q9mcXIHTBM4DAuaZeZ6DXy2YJMw6/3R4MR/5hzMvRe/adiQHsVHsj8D?=
 =?us-ascii?Q?dqMoE5t/RGrTDsta12LJnfSu3dIYNJKa3X0GIrhkGVcEGg+YT28MaGlfrGdB?=
 =?us-ascii?Q?XrCoI8VCNUgWsoBTMsXwmuEFkYy9tcp8tUDao/gn4QaxTah01MsO1AUGmYGK?=
 =?us-ascii?Q?bVw+LJBAXvC+pbMZfxNlhGkQFnWCOSCuZPrmoWZK0oj88QeyzIwGSLM3bcOa?=
 =?us-ascii?Q?Kh8vuimslMkHIJ16pX2C+kBB2BDFU8SV/nIFMleIRP3LxGXlT4hrpOkyuQIc?=
 =?us-ascii?Q?wUUlXz5gs3CAxVwXdg/mlvW948hvkxAhsF9NBQtzLV+Fd6H6xE5bDZGizGlB?=
 =?us-ascii?Q?euyRr83iv7VcNkxrH0XgWsv55Zl8d+X6Bqov9SVZs5pmFvqqwOaqbSopPZJl?=
 =?us-ascii?Q?CrBGohN9wJ3HNCFaClNaM7wg701ccj1XCWJnQp881pOD+MQ8hwSR+Ti1GItL?=
 =?us-ascii?Q?7gJ6EFev6Nw4WwDYV6o3FjJcLkM6tIOGmizM11KGIxVRnxBt9iLx7M/iU9kZ?=
 =?us-ascii?Q?U9XyhCRCLZmDKGzCtF6DfzHXgB8CzvQPP6pbcSem05zXlJ4dBftY4Pzezbdm?=
 =?us-ascii?Q?RouaSuyp6mA6GGfg5bchIAQseEEOXreoFusvRyPNEsVI1GQzquKQuDUwwrS/?=
 =?us-ascii?Q?1rru+v/VStmWilsSM7zIzOa4T64xY8WRPLW629euvB5smqTSZ9GP+G/5U4M1?=
 =?us-ascii?Q?p+Du3tp+m+TRDTuUNJRXabAaWH1p+BaRDnSAwraZ0FR5gArJZSmCv6lZynxI?=
 =?us-ascii?Q?QzuheqfTxN5MCTcsYbWfZGhQcUGV3sMqFPSge6DquI5mSIIcklJVHY9BSTjQ?=
 =?us-ascii?Q?Y5naFfqiwj13ue9NBx3SJAxQsz3nCZ2H6SSH7eZWrBT/950M1Q5N4vilhmfr?=
 =?us-ascii?Q?Iz5ffNFxGJeJe+y1ohVKo/jAcAoTAiEEKc8IVb7KgghGd7u8oADKtvrTMft0?=
 =?us-ascii?Q?NBcCh4UoWByuC6UmSvFuV4EP+SKLo3GT+ixAI1CH+3YUUO29kZg3iofgf1nI?=
 =?us-ascii?Q?5YpzzGqcS3d0uPJvR71Yl0+hMgZeJBiH5br0MInQaKc2Hg8A7VoZ9fvXTMXg?=
 =?us-ascii?Q?VQ1MKGzsSYDVJHwL4eVzJ50abJ8kwPj42yJ4lXoOCK/0HIRb+8ZS76c0OPZu?=
 =?us-ascii?Q?BT4Uoi+7ggmB6ZoPUMvkxZLpAE0S4KprzzaX35Fdg4sIL9GnK0Pi059R+x9Y?=
 =?us-ascii?Q?X7C7A574N/KIVtjyFhQfqr3UvCBUdq6wCP4oDrWte/yPHi9DaJiTHlVYdklj?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75260c2e-c096-4b1c-89b7-08dd872cc0c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:47:24.0231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paE14HEU2zdA2QJo9XaICGqBdqr4XPvikR/j/ftIZUVL2Wn7QkavqDthNmG2zBp0aqgCF0GcaPfbsjj4IyfHP2g9ZdnogeUdZplmiTWXJ8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
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

On Wed, Apr 16, 2025 at 01:30:57PM -0400, Roger Melton wrote:
> Return burst mode according to the selected Rx/Tx burst
> function name.
> Update 25.07 release notes with this information.
> 
> Signed-off-by: Roger Melton <rmelton@cisco.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied this patch to dpdk-next-net-intel.

For the release note update, I reworked the change to effectively merge the
updates for all 3 intel drivers into one. This patch adds the title for the
change, and starts a list of Intel drivers with the update. The ixgbe and
iavf patches thereafter just add a single line to the list. Please review
at [1] and let me know if you have any issues with this, so we can rework
before branch is pulled to main.

/Bruce

[1] https://github.com/DPDK/dpdk/commits/next-net-intel-for-next-net/

