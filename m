Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBFC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:39:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4171427B3;
	Tue, 15 Sep 2026 16:39:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4F7D040B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789483194; x=1821019194;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oN+zFiDTVWuZCaQy7OP+gAAqPwATqtjvqsL6bwmsGN4=;
 b=PNzML7WEYePqTcUDkOi4B5F1X091/WB/JNgZTfN6Fvfy2sNcyjmhGgrL
 nk6fQhQwRghqGQWVYOwyobH48EUSbfIfCYzHvkw7/l7TqVVQpsqCc+dge
 iyq0LuWOBUevaar1mVIK/KKEu6JQglUoVVXk9NAPi3EI3EHpmGUzDA4ib
 BbzQ7CiEbMJ/+wrJ/Yqy1t9YgFqLDzVzcxQtU64vIzJgoxleGN0BiFSnJ
 iRfVzkXWAx++GQgaNGpf4wXTQF0U2qWGIYbyUmuuYbDc88r4aZQpS7Pw8
 RZIhsNLApaz+y815dw+7+xAm0xTmydBNmyHU0PQBHW11F6US035fF1tWT Q==;
X-CSE-ConnectionGUID: PJxoiXiBTLeVuH0yagzERw==
X-CSE-MsgGUID: w/RHyqlrSgyZiLywfIbSjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89978816"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89978816"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:39:53 -0700
X-CSE-ConnectionGUID: 1pBGST2ATXq88QaghPw57Q==
X-CSE-MsgGUID: TvfFzF8aT0S9J6DlbCuF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="311295447"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:39:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:39:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 07:39:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZHbD84g8n13toko4u3IN6JLAvxv2tQ/olADFgn0o8V/QyKyXtUyx0x4161Q0qyoRikR5z3LJ5/3ETMuy2Vu1wla/9kqLUyLNoqDLbU/UiizOAdtXjJb0ZYCH3xZ8AIWQFLluiwCkXNc82wehSyPuO6EirVEGdINR+ShBs9JJgkZPt+WBWsDapZM6xcVFXXEIQ29XVxQjl9RvHbWntkxpBDJoXCes5Bx5Fj0yZ5lnzdewONvYdiZG7xhweR05NQsWjCFskffFtT7XyC8sYqWZXz5/0E8gjBQpXmuQlp5lpx1Owal6saBau+j0fx8tyxPwGIO0uOY8gbEXDekp8+B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Pte8dJfEgs/TJwOHm1E76sg4dAajj/jjdI1T67DS/o=;
 b=yLhYIcq1ukVEFNILxesS1JejzxMhxq8g/XFXIs6eEK0jFSXipkBPyFlmGb6XaYKnoPp02PD6DI09V6soVlYRSjPujagFbTPMUPLYsIa9twBPINwu+pUF7ccqgsNUung0R6kcRm1P/VsH2jBnJiPssxz+WX1sJmzRqXIm3PiAqTQIB8WhZu1lzSmUPyV9RRnawlwh9f55XuDKXmrAUoONn+7xjMn51fM4T3qZzLdbmLQEPH5qAxl4599S03QU/6i+3FBZaiC3swoJHa5sYnPIdu1V+J1DtGMzLe0jGvMxc8X0G3awf9fl4yAFd9s5wrun4RdDYxC7p2csFAMWmpKA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:39:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 14:39:49 +0000
Date: Tue, 15 Sep 2026 15:39:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/9] consolidate sysfs access
Message-ID: <aqlYsYvgFaYTPcKT@bricha3-mobl1.ger.corp.intel.com>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0201.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 996039a5-5e9e-4576-3d90-08df13373216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: rPjPci3XXDvX5LDTsAmZF/ny2Pr1ZQkQDr6Q21Pmu2dsTK23EOY8ddeZ7IXuccmhH7Wx06X2rpcv2vqgZS7fTQQW1/i23+yKf+rl0Bh+zMn/KOYGs8xQ0wPZyNwoIP2KH98Fz40r1if2v1XXzMgmEJt9/SkfQyxiECIMJFtjbf3c/NaaQEyDSjyNNaFgn5A+9y0IfzNSwcD3lw9hNa4HYDWbvrjE0NtlOVYBiHGvikOgTD8epos2KSbw9i8k74zyCT3xcYfnBvVg5x/eN84si5yHsZNTW7drFYgUQYMYxjkzKuXA7Vp6bLjLDvUJXU1kivCUeQj3VgPRkH180g5k4UXxeocPhiEJOdvsv1ORTHLU0lgXUXLkIugNwFevNCiwVy3dxsgqFutDO6un+qrzqr6X8I/7MOGi8MkQ+N1KauwBp5FzlprB07dDd8QMqtjlBd80sZhKspsKp+XMBOCLEp8yefN0mQ1tayYZVHri+xI6jXvmhsbhCJrmkEGc4pd6Na/yA/++gJXM33Y33yI7tbF9csa4hF5dGA3SyDGXfe5Y3N3iR2n7amRPfYKC5+1vXBMnHFTUHKN4jXOJ4f8LfbRJ01AEm1kEnhffbVm3YBFVpV/L1AtCWuegYlKr0AVGDpq+uRgSr1POfXm/njnNjDfLPPbanR36IyE3K312Srw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pY7fPYQ5cHgk+tGMbhwF/5RhuV6Txq+aUKfgwTa+gV0fYYTfGs28c4bI8nit?=
 =?us-ascii?Q?dVchHoI/Z7Lk2UmUdN2+TZSglMBNBHRocETmTvtrfTADP9aTsp6CTcBslmCe?=
 =?us-ascii?Q?ts4t+Qj9PRlOzE5NbY4XX2I4mSiHd5ow/gW2d0dZ04rVz1hb5ylV4Exk/M4u?=
 =?us-ascii?Q?oKJaCPc1zLbNImOXKITF5PEKKOiVJJMXFlEAL1UpwpgZEShkyeIyVX3zSM+3?=
 =?us-ascii?Q?EHD/0EEbcbktOoPDHFU/BY61dZFhFOOdUUNRnVuvLPgoVz4HVj0C3LqKTDQo?=
 =?us-ascii?Q?qfl7ULEtPH5wr8t78wqTIJsUFiOw/gezup6xJZLIfIVZe51svC3FqsnGTznW?=
 =?us-ascii?Q?mGeercz18fyBPQW2sBt5dAn9iSFzZBlKdBrx3orBiCo6kB+UmaC79ZFpyBAL?=
 =?us-ascii?Q?uFe43iaXE83WzkWNspGjoGirFOclDZqUcl7lYqEnPDqoIBmk0vJruDp975qD?=
 =?us-ascii?Q?/7q8VaIQAYh0mmDpSf2fuwbUlBQE/+cxik6lvQLuWX+EhX3ry5s6X8Se9xjs?=
 =?us-ascii?Q?+fyz8NeTHXyQ1LzjTK+6r2MVrx1bPPpEXAWHKoCyf/p0yPq+kBtLl3s+Q2H3?=
 =?us-ascii?Q?cABZ1PDXZmJ0vd2kyn5M2FuwfBCQ7SDlbBlAn9eW5h32K8epaFQFV6ITGjd9?=
 =?us-ascii?Q?7pMb0kJ3uSMG5tduFO7K8RQH5pXbEIMJ6y8nnnmioHqwOmpAyfb+GzUkF+3J?=
 =?us-ascii?Q?TCu0Tqp3HoMb/mNzHXQnxiSZ9FKcPz4Mop5T2IN/3sUtr6xc4QM/Nw6cvF2U?=
 =?us-ascii?Q?nTIEeuZOdI1O+I34SMkhbx++7sdAbyCMT2xpni8L7gkut2jJcqhzENlE6/e5?=
 =?us-ascii?Q?S6JE7/TwlaY5ZI0fzYsB6YFjz0xlaWgR1NvKyIGmB7F1Cb6+1sR6BT3LozXv?=
 =?us-ascii?Q?djJq6Nc6wUS53fR6vxlWfKz4g+TIrGVA8HRTYsCvIwvzpegMcC0zqgDPK6kY?=
 =?us-ascii?Q?UFEUMNVASnsOpfOqz3PeCcLefrZlw5rI9mstsmJfNzpu1mRpDlZyy0OesoVe?=
 =?us-ascii?Q?DMnudfhT1oLsUvicVYprCoGmnjabQixSOAeZsHNWyObe5BDRQgd+VC19ZrcG?=
 =?us-ascii?Q?yJkg95Wz3pTiwRMa1FB/Y7tNXh0TaHSUrC8FLH/iQSWwbpdIS+tGYYdTl1rX?=
 =?us-ascii?Q?gncCW+TYQT5nfEeA33cJ7zwxNSBPIHib09HGwPmsUuYMXvTqee5sTrNDqDmU?=
 =?us-ascii?Q?nVdr1WK2CC8Ju85CITHAdFKoBDpWr/LE7aHQDPrZPMmymZUWYny9Ekxt4j5W?=
 =?us-ascii?Q?+ZYS3XCveFWfIVkHD5CE6IEBDnVZwxh7tiN5uHr7FqqNYouS44hwaFIIIPup?=
 =?us-ascii?Q?61//DxNzClST+/NLKhFj1eAbZ2aC7TpITJHBeq0bGvlrY/0ZDvONoiONKsRj?=
 =?us-ascii?Q?YOa1+zsFY1oN4ZfE8jML9VtopVeAM5x0OozZSdSit3Tfji/lQ2sEjY1wK/dj?=
 =?us-ascii?Q?CrOaNv6Gv7fzfAG6dSgJm5/TFtlVhboo/vvY3SV0RfYZ+G6SEm3AmFHLFVmF?=
 =?us-ascii?Q?KzO+GPv8IZDck5Uy6KOMatXXIzhCsb8SsWZhRsIFNEf7rqRltQva8KvvZC18?=
 =?us-ascii?Q?wIqxM9eYDfoPXKS3shH0Ifg9hR0T8WN0qrt5051mWjZ9Q1YXwUhsK7TUZtBB?=
 =?us-ascii?Q?nJz1Qtf4UDey+YrDFwB83jpbOzQtxIRfdzGLUGoVt0OOr8zvFa+JIebSaFpk?=
 =?us-ascii?Q?Doq2lGQZCHP2Ua1EVEuVV0xT96cDNjjeJa1keJqyBpjBLv+tlKCQN7NVAkdJ?=
 =?us-ascii?Q?C0Gb1TZfrus8DhC7uvr5kTizdgAlODk=3D?=
X-Exchange-RoutingPolicyChecked: XhDhv1MqqH1TYaFwb3HUuQeicYZC4WhQrXq4ZuS4ZEIKPvGuV/xva22ojtdHCA1q1QuLC5imMlhRYsOPE+COmpdxr0uP7gaGB/wuad+pHY12k3War3J6hFDaVIQNQOhwOj1PRZmwVKf+Fbt6TYheXXhiB0v3pXj80p2LT2FCxry0lOz8qjkl9zFpaxTBhshTyH0PWtCm5Xu/0iQBnKd11p9kPyI7PY7c5CRRntojRw5N/7lHcJwxjNkikHG/wYHxC1BMcRIVkbTGX0D/2CXpp/1Z7I7iKGY/2NjoU6T0Kr8zvdChZycu2jn5MOLcVQtCsPSRHxweZdKw/XFGi6C1nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 996039a5-5e9e-4576-3d90-08df13373216
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:39:49.7401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLW0rdSNAy0hyVHiJ4zjC/XJ2aQanPZn2OQJO5V6/WxgNx4OpiaxTU2UJQgZgDtSfUjaMDFtaq2XImEPyMhUuHNBvppVHmsiqP3VfGpmBNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
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

On Mon, Sep 14, 2026 at 10:36:13AM -0700, Stephen Hemminger wrote:
> After reviewing lots of drivers and seeing sloppy string handling
> resorted to AI assistance to unify and consolidate the parsing
> of sysfs values. Many drivers open code this with similar pattern
> but lacked any coherent error handling. The kernel API is
> consistent and won't give bad data, but it make sense to
> check for garbage.
> 
> Add one set of routines in EAL that build the path from a printf
> style format and convert with strtoul()/strtol(), then convert the
> existing callers.
> 
> Since the new routines are Linux only, a driver that uses sysfs while
> advertising support on FreeBSD or Windows now fails to link. Two such
> cases turned up and are fixed here: the eal_fs test and common/ionic.
> 
> Note: existing eal_parse_sysfs_value() goes away with this.
> It was exported as a stable symbol, which was a mistake:
> the eal_ prefix and the private eal_filesystem.h both say it is internal,
> and nothing outside the tree should have been calling it.
> The new rte_sysfs_parse_XXX routines are exported, but marked
> as internal use only.
> 
> v3 - fix doxygen comments
> 
> Stephen Hemminger (9):
>   eal: add common sysfs value routines
>   dma/idxd: use common sysfs routines
>   common/ionic: use common sysfs routines
>   bus/vmbus: use common sysfs routines
>   power: use common sysfs routines
>   drivers/bus: remove duplicate sysfs string helpers
>   common/mlx5: use common sysfs routines
>   net/mlx5: use common sysfs routines
>   net/mana: use common sysfs routines
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

I double-checked this v3 again (as with v2) by running the unit tests
against a device using idxd driver which reads parameters from sysfs. No
issues seen.

/Bruce
