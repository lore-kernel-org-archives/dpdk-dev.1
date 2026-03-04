Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF5EB7EAC
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 09:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5590402E4;
	Wed,  4 Mar 2026 10:58:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9E5E2402A9
 for <dev@dpdk.org>; Wed,  4 Mar 2026 10:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772618333; x=1804154333;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=RkbVbOuN1Rj5NhbzZQ4AF4DyzxfJDWp3ztHfltVrvFA=;
 b=A2RQ/30pcNaPJg0sDwh33Dmr/JdKMMnbAevhJuVQHFXa1H3hIN8NdK5I
 U+Kif7qRl9FTfNd42mkFaFmX273mnjwaJrjdy9XkwlsTLVa61SvVTVnix
 ESahYZWVwJKBmSXzPl6zpEQ72/EMpAjCzkOep9I5+8beszj3SFThk9Ran
 TVzdTPnFkqtdOGqCQ1SM95CYNRRSqoyNO9vxFEytp5Rvwk5UOUgjVyvPq
 vkEJ75EUrjnA46eb+T9ktwX/Jnfrz0Nqhruzj7spAV/UMAqe+tI95wHpM
 SNTzll02/Xw4tOSPvKX2xfgu5+Az1vB0pO3o7DsbJpv0bYr+yHJuQ4Hlm g==;
X-CSE-ConnectionGUID: FqjOn/EKQLqxUKKvZ7iOHw==
X-CSE-MsgGUID: xZ3aR2aNQeWPNCH8/uTn7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="96285386"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="96285386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:58:52 -0800
X-CSE-ConnectionGUID: pLeAb4xAS3aUBwncTv3t+Q==
X-CSE-MsgGUID: 3jLHiJhZSKOt5/ReaFxvww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="215261436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:58:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:58:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 01:58:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:58:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g024V9COhvhlJ+m2RJE4bY2oWC2BsZi97flfEppuxp716qCT9/aU7qYRy3D7v5hCtiN7PLRF9Js8ximy79O+18nmeFEpR+KksuWDVi6LGyjFxP7+xnQdcqhy1BsaK206klquGHu0Nf2jOI5lV7BgI2ORCGwSQJBP36Ah/y0WyDvtwefaja9mgPRhULO1cHJej6oIlSU+/RCQPradteUgwQKLuJoEqhh+SsgbNGZzEGmcUYD+wEAXuy13wttQDSHZl6ri9neWOsyWrBHFOb6Hb3ehlnFYZRg7Wowvo/GPy0eZQKGUbdaZRNV5UFh5B3Crh2QIEUa1qeBZQK69D2B3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmS1BT9gEagFfODc59GuWBIMXU5VqAc5JpovNOVOewY=;
 b=A7SqV7S4fknPhufldkTOU0ThGe6h9EH7N4LRZX50hYWBzUcA6GqmTmEieTdRVG3IXFkrtlQ1mGK8fbFi3gYOv5oYrViDrWFUAadq6XzfEJ+kHYkccJr23jdKdi8y/ZsKGr139TEL0VXZp1P8lxLHuEKt9wPwT5c76hvHIczTZzRgCPEbwj/Sqo+Vj1DCOrnbo3NKK+9T+qRbMU+1Akyyme2VzISyipUJcZ+E/KV7kpe1e4EOOe75vxyG3LjaGOHUMEl7lkluBElrQvIR2wxAwTYsGx2ZQkkMO/0R6DkHllVZyOGkp9OXBKgPKVUnAYdu/6RboiIOdBQerPkVdOetjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 09:58:43 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 09:58:43 +0000
Date: Wed, 4 Mar 2026 09:58:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/2] net/ice: get link status updates via adminq message
Message-ID: <aagCToPf1Z1Z5N4i@bricha3-mobl1.ger.corp.intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303162157.1634379-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM3PPF96964A2A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e31fb2-9989-46a9-b3dd-08de79d49e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: m418GcNsg4BK03gluD81kYTOl0koT0xcX8qheBMvMHZdSwmSCBOJ1rrIZxhYh3JNWSKXK9feawirpZR+4SLPJbiBQ6tz3wl1HxXiumRbqaWnl5G+v5VJiduXu2U8HKA3wAE5BmSIBzB1CCXVCSuIWm7Xk4okc7lNUtencmas7NWyXxuQ8xbl2z4FcOAKF0i6EKvP3WCAGSnzNSeTV9gwzPJEJCegv57QgL+b4KhTSiBQhX8jJ8JTUPGaDvntH5d/BcYmw/yNWnMbnLe6f+P0S0Oe5ZYL0DMIMNmjyPw/tOsDdcRHLTd4lqRE/fEMP4z5ctgjmktWuPGL6w3dpi+yIr5JNCcULod3nJ7ZRQ7xo2OgTLed4vXOMk1YPPiDG7vJE5hVH26QsncgjzlwfCS8gNqxsveJeGeBrb93oqrf46KXBz77PiOrUTQ9dh68E4PgFB6iDXXhOt6kptofVFfWJzixMju2rk1inrPkmNySqu3Hr0tDihqiz06cDPa7Ueag36Eu4NM8J7N8efvKxeLBiwVcXttX+UOHkvqnG0p0G6hp7RvBXurDB5Yzzz3vipfpjcMz2wQ53NTNpXiwfWQLus2cx3FXlKBW/FNktKTQ7zKpZ0GmrSvPbr97gTs9ZY++1D+SqPyWQS+B0kRyTQxjt4As4KVQiQoYLnMc6RLU7UCo0B+KkRe3QNKhUsXF2YYbJ31RtkN3+6UBG5TVso1Q9DaNMcYEuT7SKsG3BH8w3D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t35gDU0m8d1vJ5p5yG79964Xibd5PHNalpvwJTzlTxW6J5zEqFWgm7D/GqmY?=
 =?us-ascii?Q?T4pOGxbwNGH11uvdD7R8EvkkWBYZeQGHGlHRB69PVV/P/PIrMPM/HgH9vLhJ?=
 =?us-ascii?Q?gx6eMQ4MLTlBX38YQ6VSAtVarAtQItWjDdh5zXdJ0wTlHNXk9zsG9TL7d6Jg?=
 =?us-ascii?Q?E+1oE7PKpNqTYeOGd77662pioCnrIsrIyljkG+31/V3Yxc/XM02qMwK6PzTb?=
 =?us-ascii?Q?rUZW+c7HL3/kqDP1PCE7exgQTfz71jIHEhhkN4fXbcd3l3Bm6q46YD4uds6l?=
 =?us-ascii?Q?JzcxdKlyCPPY8VQ+qcqarXh6No+697X55twE+iBMPZ7FS5DioH9fizXcDyLo?=
 =?us-ascii?Q?DKAeXIrvO62z/YRSY+2N2/J+q5ZPxSdzQ4QMQcnSVGVDjhFnASOz6YllrgZk?=
 =?us-ascii?Q?raqwCzaM5aFij4y0j8YCSpQ/tsLnM2fhHIRf7CyaYfwathQMxXJxeVDSzHyn?=
 =?us-ascii?Q?s5Z3DMDW0NhCeqg4bGLMzDjaG/KEqZ8FEmFq6Iur5WijxNzNfev76mn5Gea0?=
 =?us-ascii?Q?uqwgda5GbaNeZLZwACbdKE9+XUta2w310jarZiiOhwcG32vUlE5pyUpgg/zL?=
 =?us-ascii?Q?pJo/buq0M03t44d3Lq4/+wpM86AnRcEPtBQMiKqFGOTAgv8pMAZ+LSN8bZzV?=
 =?us-ascii?Q?uyKkR6eiLxpLflRLFErGIy2i9TbqqJDQydmhRwyF38xVVvHcO/YZ1W9v0FTH?=
 =?us-ascii?Q?XZqaegSWZTWq1PWDEw2mom+7+TCslTunEC3vYRpll9QPM/oPaqWl0L518jA0?=
 =?us-ascii?Q?qGs0jzWjPkSKIFSnBUSOqu0+zZ0/A4AGGYNjzFjVXKX12H86pw2K3smDoxbQ?=
 =?us-ascii?Q?MJSdkHCwB5FAu4EA4HhdF57+i0oQgs49fA97/M+i1xR3U3zRpmshEeYzuWTh?=
 =?us-ascii?Q?X00bEBJHZOHvpkzg9hJMGffmGonfhCDR1s/jkP8HSJwlTM5l1wolDiJBrDW5?=
 =?us-ascii?Q?aGvThyTmoBbJckvnxHx7F/mL3peA86+Nb+LIAxp0Ojjy2T9DSy7hPaVG1odN?=
 =?us-ascii?Q?GE0RfdTqgmKYrEAYAVazb1/qjWR41c54/xB2vR0gErj3Emensx/u2fD4KNTX?=
 =?us-ascii?Q?BN+zWDSaAhybeE0SNxHXTHnxdI+SPWPZwmbdGFBnzE/GkCeCWJR6gHAn/M6n?=
 =?us-ascii?Q?hekhJmSz8x1kc7/GlOKvyMaSH0Bvh3qjqT1FaQmLxmKGf66Fq6j4vlqFHVt3?=
 =?us-ascii?Q?964bOlfsbNAHPfH+UVSOGgscyM7Kw65YOEGl5sep9eBRdL//yXRPwK11ADxL?=
 =?us-ascii?Q?wY38WXXaT3MJIxKUCFtTaDUJYr0XVk+fxX5XHL6mc2qEY5OHeRNBs4ENcEJN?=
 =?us-ascii?Q?kbSLBA96mkfEw2Je1JPizR0LdEt1kLwQwpo8ZVdIMUetGYfP/dySPsgiIfe2?=
 =?us-ascii?Q?zYg9T2VmrZU96WOk5zpz6XfNxbDU0sbunWtSSBBglMdy428EjqRcWYCV3V+W?=
 =?us-ascii?Q?k/A6h+9InwoKEQh4wJW2KceWjk856eb/Dx6cRZPle1lNys6u2xm9xgcg9fIc?=
 =?us-ascii?Q?cNFYBiUYkSMLnQC6s0VwEUna2X+EoGsx9R3N7ptdEdlIxNxOwSlt+sQ6QC6b?=
 =?us-ascii?Q?ZiQIhwTmjH6SGXJaDZQI6g/InX3uW12zhSghDjqjVFn8KI4UPS4zA/KGWzjP?=
 =?us-ascii?Q?x3DUS54JPXTYCEbYSp64xclWnLRlwwoQ7msBDVxnX72qT1esT4vkbdlB93NS?=
 =?us-ascii?Q?bOh7iGexpAhADwy8S39cKkGxG8hshYg4fwOHGSdsSZj5AraErP6dstusl4Dg?=
 =?us-ascii?Q?r8ljLdtAxQiSnMjq0c5P3m7JP/ps4q8=3D?=
X-Exchange-RoutingPolicyChecked: H7KWQX8kzeCNuYRb8Fea3O3aWqAxLIcZIbp/aKgoqDgRgxggmbTHIEob15HGu9hEJaTHBR2xd1SU5IZ4MUJOfdXtmCixqZHTtc3qy/mBspgMBReQDmgs0zZITay1L00dvyoWpTAU4JRVLJ9mZa4oiFvgGBKAQ2krvAZBeI71fngfyU2UZFxo5B1QeVDAxLnwVoNqPDZOhmEDLyhSjECUPmRtqjtQn1Qp5R+fzHFYErl/jGBxHoFPmHl2dGhHN1wgG/gdLVWNun+8wM7pEMwWCgr9GY/3YBDA5oZ5Kzhh0v3dZ4R9J8iwpw8Hg0ipfdlevYJwjcB2BHu1Mpc6hEtQwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e31fb2-9989-46a9-b3dd-08de79d49e77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 09:58:43.6643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X553tvGcynVT3oXnnxA/BlccuQV8iZEFEgzB5HR3q3cNUJx8CzjWCDqWR+1SVnZ1XjzsfyVyq9SluDR29LB4yPdieh99sNSuVoJ/4wZj0VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
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

On Tue, Mar 03, 2026 at 04:21:55PM +0000, Bruce Richardson wrote:
> As explained in patch 2, change the link status tracking to be via receipt
> of an adminq message rather than directly querying the link status on
> interrupt. As part of this change, we can reduce the cost of using the
> adminq by removing the need to allocate and free memory but instead just
> use the stack to store any received adminq messages.
> 
Recheck-request: loongarch-unit-testing
