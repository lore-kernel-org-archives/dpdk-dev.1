Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA980C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 15:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B203940269;
	Tue, 22 Jul 2025 17:09:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7B6B34003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 17:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753196993; x=1784732993;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GYL29cXYoS8Vnte8ZNfYF5iuv9RjXLNDLcZg5MH/J1o=;
 b=MrfTVyVLW0KxURuvzxRfxLGwHZQalfiGqTrMQTlyEdaEkO6qDdS943gH
 abVwCHUxkLmZ7Yxn8QzfX3GtXyGxaIg4FC2EJGzkUFFORyZG2ape9TwKs
 U1a+BqFG4fvRqr0LQ4wR4mQYwQMvP2QRlnek5IrHwPMc5k2RjXsXMKj9N
 CJOcVRBUMnS3sLih8GpleJJmzh+X4+MoUVwi2wi9Ikg3hsHWaxYMqR2sm
 dyD9hFST6PuJxWviXGkwaF3fbe8iOqlT5tOlDpwfK7GuU+e0Pv1mPlMAn
 oTgYEpi426wiuM9WorJV6NRkFEiABCd/jmLsyoEx5PeUNCTGrmknO4wHi A==;
X-CSE-ConnectionGUID: qNii2I3ORJKmAh8aRN3eZg==
X-CSE-MsgGUID: JeMWPmRqRZi9FY7UXxuEnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66794121"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="66794121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 08:09:52 -0700
X-CSE-ConnectionGUID: POxS6bSyQNeNxDlKkauVuw==
X-CSE-MsgGUID: RaGBKKvSRFiZOyu78Udszw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="163442924"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 08:09:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:09:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:09:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 08:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvcu2hFJzym2uJZ+/VtiD0zLlc6sb8xmjJWA1pL8ZtqEQgFv7xqRfb/cUVXeZagqmmQq3IKKPZkRpIdm/33DXGRTpe+GUfnm2In2j1A3GNth9uqxF6oN0mJ6/3lgT5kjanyrf31v9WipoVw62JXIGu/XTA8fhsaIHdGqGYSGYYGzI1ndDyN9jk5F3gn9GzxYm3UWqf+mkiBEWnV9rV3LtLF+TIynGplvI5fCkrMhAQUvNdi8V8xPJVJhWciUWcGd7dDl97T/8qzielc3DGu6IkgRydsXQU/iwn32kUvBX5ctxhbp06aOG6OfdvZhIvx1ME6TL1amz1gfEwBz1XFnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRDqjGgcAEz5gmdFHRF0aYny7PUsAhya4nRj4R4Bly4=;
 b=MiAZ2uh2Cco70/ATTVG9az0phnWoRnX3yURbIg//OPW7Bqq0++vVC0ioT1KyMhZpDNiQqkfHqnjniO2+lBkr3DqkJL3oILKV8RMmHVrzpo8nEjf0wIg+vv4+L6aduU04DRVFG1mP129sGkK+zBiTp5JQRwZmTLHQVSwsVvn79VwKgJrXG6Kmfqew/eaeN/ZHfnv/XnlCf24jzjbLfAzUUQcaF+dDPdoIzQO171G0pPLkJYI06S6QrxFoCgcYw9vkgbIXZeRbx/n0v1dcIGFojgJFTXSxhjflH81OY+LrBKfDJ/po4pRWpl++RTaJATadgiGlJRvg78LVcxhEQTUX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 15:09:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:09:49 +0000
Date: Tue, 22 Jul 2025 16:09:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] app/testpmd: add flag to enable RSS for single-queue
Message-ID: <aH-puUrmc7ILq6Ok@bricha3-mobl1.ger.corp.intel.com>
References: <20250715125330.2127309-1-bruce.richardson@intel.com>
 <20250722070815.620df80d@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722070815.620df80d@hermes.local>
X-ClientProxiedBy: DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a95e25-1473-4b66-db4f-08ddc931cd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6UtfmWQyjg5Ue86JnFqS40ZyTuWjmUeWHvA0pCI6hz8KtnEau3yg5q0c9LTS?=
 =?us-ascii?Q?Oxvr5eipk8Uj3cF0GgMPE+jrnwkagsaIFUjkJd1yCXKbiC3crubVJPDL+1M4?=
 =?us-ascii?Q?8bCZw4mRCmve+rd2aNhVmTYwdxm9i81+S9AC43KOHkMcQYXrwI87F3i2Dyc8?=
 =?us-ascii?Q?mEw2+PLshyNo200Ckxe5gfWdpVbc8GvHwsuZR3f7mReqGISdxxFeL8HbFL/M?=
 =?us-ascii?Q?5xxfpGKurjw9EHSu4tb5oK1xsdIy6ue7ueE3n+tLpFLVd6w0de0K6Nr9x+Xa?=
 =?us-ascii?Q?+bLW9wprw89jpGdtmwubqdz681vOtvoXdDz9byOQh2OJd7Qa+cpg+XO2WGw+?=
 =?us-ascii?Q?vlUjko+Fz5IX9nz4iqWT16gO2kgImsf2jedf3c9Fygaa0C1kdpQyTOOnAP5R?=
 =?us-ascii?Q?w7ZnS/df+HrctfZ/jtjOhPPall7QcFqxOgIIzEEuP3bXicSnZ7KZMEcOJPlV?=
 =?us-ascii?Q?n9Iqp7rVu+L6Ne2MgHlzhJ62HkeFZu5UaqY81dyzqsz5t7LkP1JtzMSIK6Zu?=
 =?us-ascii?Q?XZXN+alMpJB/XHX3HZ0vka4UFZtvOBMZvA3a9RUrFSlskKqvp25LFup0rkaG?=
 =?us-ascii?Q?plMnJNkhSJE1ucV6o1xmzB9ePJn1PkVqXs+YVn6/IL9gvh5j8vcC5EYDdRqs?=
 =?us-ascii?Q?zsw8p5mTUioaqoV1HHGCe3YwKsyhz2bmJJMhNDOh1Cq/9U4ENe1+VzwVdkJB?=
 =?us-ascii?Q?WFHSzNkVPaVCtIoJ4Noglo8tvArDMtPVNMGykQwM8lSGUvX/o40DQZZqvZ+9?=
 =?us-ascii?Q?Qbdk++m3MG4CKLVgE9gYQNohILvSGSeoV/1Ny6hcLd3DoVI3CltjUE1xiBAA?=
 =?us-ascii?Q?XICJcNtlrGPwCFFhaut3IXHXYYz/pja58L55wTccxbV3KvmaN6dy6YjKtQZF?=
 =?us-ascii?Q?YsW6IGrKA2dgqFJ3XYE8rhsWww3hS5McG0S2uPsSCPml9LF4IjCDbuh1JzfB?=
 =?us-ascii?Q?NclVYyTNW+aonANlfox5XpnG+A0q27ngrTA8rBUwv++h7iXajzTOSpYiZNVM?=
 =?us-ascii?Q?hEl0uARnfWp0w4nyVMUp9mxGexxoGvJGqb8xcgGMC8ZqbwXmd0Lsjx9ZjFnB?=
 =?us-ascii?Q?dcgSAqqY4lknvO88/72LbUR6X5lZtynZNlr2diNRBm8WkO/RvPrNdBryM/fZ?=
 =?us-ascii?Q?gUvI81ZcjRcCfJyIDMqI89RmqYDINmO330vmJ8DYoS3jm1MdhEnje7GhU/Md?=
 =?us-ascii?Q?OMRsQfVNf7Je+MhHuk1N3RW9q0cRIJMk72YZN69Lgh63GQWJT+ObNZdmaZAM?=
 =?us-ascii?Q?aT18SlvmWNdDSelCLa5gc6mQ4MloUq/SsGFKP8Wsi6Vhu4Ciq+S9/p1Msi4l?=
 =?us-ascii?Q?ziBObRgDHQSG3FVmEGz7lkg0nvIzsljMbRGMUcXsblmrI52d/dbfCQnC1V/f?=
 =?us-ascii?Q?dYPfcClOfyqdTCOUwn4oPWo/PbrfgBjFylxYyYA9B0FqIUnkjkksYIKC5YPf?=
 =?us-ascii?Q?SCySaBYLYIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcl46C+tpBCYgXj3jaWKoYT8J7N7xM4ESTs2K1cyfzN/CKbBXCcC5OWeGkJY?=
 =?us-ascii?Q?p3/0EnjwTPNBsqEXa3tix1XjOy2UU2LmJHSg/+zcgr4YrFWA+wIU3J2ksQPI?=
 =?us-ascii?Q?fWNCPDnQtjYqhBNw8aBYaFWKPKePMkdoag7VIlXu8PXMgBmOYRjBCdS7MdeE?=
 =?us-ascii?Q?Vc96fBKmpHKggRQCplJm+/FoskBu8NIsFyt+WHeQ6yPPDjqPjEtE3/Wk4n8L?=
 =?us-ascii?Q?X7gEsPJ4G49bSuGG1LG4sd+iPP0KSe3nj5sETLr9f79w2+Ex/XiFVyTbI9Cd?=
 =?us-ascii?Q?ArxBk+JulwhA4JC6LDPrauHCCj4Np1DTSQ0PUEU8Jfj7bXEJsjsOuUtS8Xa8?=
 =?us-ascii?Q?UtK6ePK3MGcfmD7FuQiavCgOc3sHvwISzi4F566NPviqhKSy8KbVoiuG4uDo?=
 =?us-ascii?Q?kN1P/4ieaRFzE6/mCpSWbdd7uuIJXZKwtHHWn1vUmd+n1YMna7Z9aYBisgHT?=
 =?us-ascii?Q?nmYO9GIRS0WTSlvIY/EnHSORhAX4kwrhq+yQx77LrO2kv7Aijze1OoMpZu73?=
 =?us-ascii?Q?fDtder3+47en8LLNryD5Sv6CdCUDhcaqzHtB162qoZqg8e+HQmAhMkMMMlGw?=
 =?us-ascii?Q?kGz4xxdLXOIr53hRbNLUuGcswbGi1p8uv3QDfpAMqY10boGirVUod3deSyvl?=
 =?us-ascii?Q?/2IkH2Oc7JcJBwZnuFXEu7RXcAAb/8LlfB96WzvWATwRzgYwSqLZXJ9c2rLR?=
 =?us-ascii?Q?H/a8Fx+VxNkr0kjeqvnAQ/HjxqgkS2Tve7wZrEmkn6K7yyXna9QfSZOQ8ZSz?=
 =?us-ascii?Q?9viDw8KqdyfkjT81z3JCtf6qouDeOmM+I5S1gSYxGCKAxxuqBr//qdvUjAGs?=
 =?us-ascii?Q?t9z0ro0m8gFkPQjsNjNicVS8ZsJChVDzLQaz/d15ZaF9CrZ/ohfG1B6vJfVC?=
 =?us-ascii?Q?SOi4tXdGSZU8NMfqzyjp/c+fxqyaZt3hX7Z1dwpmTXgT+OeJ3DYJWa1ZBtTV?=
 =?us-ascii?Q?8TmDDTZVUxt7Qbobua+bMOwbjDqIMQL3yO6Mp6YMnTp7ks5ZH8vb9VDR55X7?=
 =?us-ascii?Q?aSReBHK0jVPISDxWBrGuuA7/DVQXGoXQddx7I6e+Gc42piyaqNJ4ZWj/uG4U?=
 =?us-ascii?Q?52YtrBe+cPe3hTnshXNBJ+yRsUaYCT0cqVSgLX5kYLadtevgrdEXHdOz5OP6?=
 =?us-ascii?Q?QPgFmzvlmhkPD2pkPsI8sQiLlPpWdeRjR+4XAi/hQTeSZNmxTGGKj3GVSmbT?=
 =?us-ascii?Q?xsCjbjtXSHZdtZXNRTO69AC/8wsgNsZuTQ3M6hliyToaK8BdOtsymgNPSVBr?=
 =?us-ascii?Q?spG5Oys9VfOOFIoFDLkz6rsEknSYx+4BhG7LuwoqCGeYfD3UGuRIE7jSgdVS?=
 =?us-ascii?Q?kaxQGyKvCW9gbX/SOCFdEwD+BduVoZ/24m6y0N5TLXdE5AmZomz7s9ycKUK8?=
 =?us-ascii?Q?TVDyw+HfC/AqfGrJqhOOL/H3PAJpomgtgL6/CXPPhR/DSTTwq3jSDnl2dVDa?=
 =?us-ascii?Q?35IrQRKzS6cHiij7T+sDYG1V03ycvPgwy/PZUxcKXiYCRE3xCfMdkZOLbTVM?=
 =?us-ascii?Q?kf3/7H38XreL4hTUqYoDKvsLs67A5Xjr9v6S7nhtsAU19j3FMSHiq24fL/Zq?=
 =?us-ascii?Q?YkcH7wWxwHnQYKW6Iq+g1upgVkTyRXZBbnONWwjcuX2PBscU3zO5IW31rHZo?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a95e25-1473-4b66-db4f-08ddc931cd69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:09:49.5565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4OWJ5QBVGlmnGXRDNQvI/SoJRQQ5Ek+u0v0RpRAiP7IvfXohyZvRHCFlVRCaFKmB6lrGNOr8f6J+uChfZN5+1AbsHvp1vZaf5wBeVETnSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
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

On Tue, Jul 22, 2025 at 07:08:15AM -0700, Stephen Hemminger wrote:
> On Tue, 15 Jul 2025 12:53:30 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > For testing purposes it can be desirable to enable RSS even when only a
> > single queue per port is in use. Add an "enable-rss" flag to testpmd to
> > match the existing "disable-rss" flag.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Not sure about this.
> It makes no sense to have RSS enabled with single queue.
> Maybe you want the hash but no steering?
> 

Yep, that is one scenario we have seen it being used in the past. Also,
it's a useful "harmless" offload that can be used to check that the offload
paths in the NIC are working correctly.

> But the DPDK RSS flag doesn't require driver to produce HASH.
> 
> I would even argue that ethdev layer should warn application
> trying to do single queue and RSS.

I definitely don't think it should warn about it, because there are
definitely usecases where you may want it enabled for single-queue case,
e.g. when using NIC that provides the hash. However, it should not be the
default, which is why this is a separate enabling flag.

Another reason it's good to have it, is to ensure that when testing single
queue vs multi-queue setups, we can test with the exact same configuration
between those two scenarios. Without the ability to enable RSS, then
multi-queue will always have a different NIC configuration to single queue.
In the case of some of our drivers, for example, the lack of any offloads
such as RSS causes a different faster RX path to be chosen in the
single-queue case, since no packet flags need to be handled.

/Bruce
