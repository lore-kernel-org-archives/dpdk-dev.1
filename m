Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CCD41C2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 12:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED49740A7A;
	Thu, 11 Dec 2025 13:25:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D5C2340285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 13:25:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765455941; x=1796991941;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CbwqNIJUjOfFbIZxLRpw23QehFOUoptDF3Tz7E8ea14=;
 b=CpaakRmFVTT8PWsg/L8RWVyziF9WyEfQaNQijn2oiS2C370nL3wUbKav
 J57dpXyWECSipk9ZPhHipcNkido8A8rvXOXKLSyl+N6ZbnKahjodzWx/y
 wwVOcq8HEE4gt6smcW69/hG/MWuGqkNLqn1R5PFv4URczPY77wFqAbPLZ
 lNwaCHACAGYNHn8dtiEnFn21vQrlMsYQHYVGDhiRo6cfTBaRUwwjWHM7i
 eoyhLz79xRW2if7PZO4BI2a6pJoC3Tglc1MknqnQmajuK4yVoAiJbTABo
 p/uJfd4LmgNhRanxUqxk8NIwaIHIJhwjfUI3ho5BEbDuHeWapEhqvTfE1 A==;
X-CSE-ConnectionGUID: +cAh7hpZQfSHiBdSyuzdEw==
X-CSE-MsgGUID: Z0ockvWsT8yLEe1mTa7hyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67509124"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; d="scan'208";a="67509124"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:25:39 -0800
X-CSE-ConnectionGUID: raYfdLLsQEGMmS9c5RTJBw==
X-CSE-MsgGUID: yL0a46dkRW2kwZDwxUca8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; d="scan'208";a="234192510"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:25:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:25:39 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 04:25:39 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:25:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHFsVSd2lcTBor7ipv+yWZMZv+VX+Vtb1WMEux2urSD9W+/YGXO5l3jRUxxlWNxBjlTkJ2PV2+cvmrFIWaL0qqJu/YYD4jaOrYfY8tGrrYiX0enJjh8IQufvAQn27gC9lGRSiW3muMvr6IF1f2v5/r4ZVxuwQZvNCrQt252XeN3ayMV5KRBNoczCBSSNsUvpa/5Im0Ynv4KZWd1xb5OVsDBV37CiLBHbGJHioOAKxQwnYOJwAuqBfTUTuu8bILsjXNKEl5lcrH4vnsYpqh9RnLo27+b7Jk8GSbkqa7GyOIaqtOfySzcpen8214kYqz8rhQ9rofOviQ9zO/NGwIU++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLEjBpPQbIQLpUpvV5ARqeO3eIX71TJKJQgerKWLDs0=;
 b=H8TlhMy19+REo/pMtl2ULAoURchMcB8nk2AgB/294cgyXpB1pxG6RRvjD8rn1n2hIgTfr9urKFK6JNHuQKs8nu69WiBn2/6Kfdm/cRbm+aoU0qg5tn9UwQGKmnnqzEDqKAAhlHoPbu2VcmyWZF9iNiOovM7XGNoR1xS2RaU3tygwgWRcd2xSGtT7AKNHzjYndi1SGGXMDMYMHZeeVJXdX0mZfbAh2GNW2AF6B/uuSzW90sh69JV5U6vn7gY0Dsq3qwsXMajV5ObL+b8pn9iHbc/d8jRlMsPJtQ9cP7UfkccG48xYlATAsYv67L8F6aF/HgZ37VHJytDhudfxu80brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 12:25:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 12:25:35 +0000
Date: Thu, 11 Dec 2025 12:25:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/4] Remove SSE from some Intel drivers
Message-ID: <aTq4OhjqR1z9Okew@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825123548.1177090-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 628968ed-7741-45c8-9b11-08de38b062b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B93nhBjJIEDIEKEI4fI+H2aJxALcuH3h3EkqhNtuFG0SHOVbQQVhOR3D9Qb4?=
 =?us-ascii?Q?8EQRW+rGhaWl4uqxue7x5yLxZb8TS6O69fwoG+QRkjNUc8mA7CXrPUmjJtoL?=
 =?us-ascii?Q?sVvF4VTpfr1kf+R6UVxfXLFj8NgRf8m2pmxefHTZbbWspbS6o10zndeB5fMG?=
 =?us-ascii?Q?y15JX98DWWFueB+9U53XjGYlrz5g1siY+QIxe56MYA0aj8tB4FZsymJMOZ2Q?=
 =?us-ascii?Q?GVOQ6jVjm28uhE9rP5CH6ERLXeyugJswO6H4i0Np0b9B/uWgnSXNtap5mcY8?=
 =?us-ascii?Q?jqNNsdog4S7cB6Fh3t9aUjsovyMMAvqTLN/GRv0SsbrJMHl66CXCJsMD47Do?=
 =?us-ascii?Q?LhwL38I1pT632JHlitED5o70brsaI6KlK8nLDO85OK4NDV5Ozz3s8X5cUubO?=
 =?us-ascii?Q?c/0qSwcmjUk+tqLI2RRwUSkRvUO9GkykSrP1UV3z+HUbnRnYU8AV/lWnrlLG?=
 =?us-ascii?Q?gW73bsD78vDCevZZRANZSJyIETKS5jHj4hSLYKjk6mzGRPV9FBluZc/p2KWO?=
 =?us-ascii?Q?pvYGjRVaQzaIZhIA8dIIOQ7uw8g8/bnJZXREbGUtDOvaBGEukskgM6Ok5Mmq?=
 =?us-ascii?Q?OeOFQDMJkahCpkuUuepHVCKrHbjfiNAh3crQNOZ9OfnA63R+hrJL4bwU5keB?=
 =?us-ascii?Q?xQTAjuv8zC/erSCQTqTblaDSTIQG549Fz7D26kZ1vor2/BXiiHOQXygOIgEN?=
 =?us-ascii?Q?shXKWCx9dltn9KbVwrZo6mrvVKZRZujmB0VfVQSEIHt30CF5Cxg7HdIoI7xP?=
 =?us-ascii?Q?t6LjCW1/KIwPjgDsStCV/E3EvoJEmNUdSWMVhdt9iexuh8uHiB3RnoW380j6?=
 =?us-ascii?Q?6BeBPdWNRqSW86PKaEKOmr3Ah/1DlOQ8cVN8sQ1xhH06thTD9a/APnR5OWQJ?=
 =?us-ascii?Q?0DTc+ZKcYpxdMCyDCvbG2JBP69JlXgeBzColoNwzXIiw60S1E6PeysrSJpDP?=
 =?us-ascii?Q?fxLN9Z/WtoS/+Z9M0xsJSb798DHdcfEz7wMQVGCtfzFAh1hhM6zkeCTrgNfv?=
 =?us-ascii?Q?EXeXRyPpz3A2P/ns68hkfd0mblX0U53KRnsw2dyKw2IOEqIu03oo2GtehJ6K?=
 =?us-ascii?Q?cpzrW2Zet1iVwfU3gKn3tT+JsAVMojEToPdlxpKhTHqjp8/2gNu9+O4+atr8?=
 =?us-ascii?Q?bwTfTAbUjDIC0ao45gVDtNGKEZev9j23UO4Vty47JyzZ6obpsIFEdgOk165h?=
 =?us-ascii?Q?D2sGMcMokvl10VHzWRkI7mF5OmEeIWX5uCMbb7JUL0YusStti9EEmGct8wfn?=
 =?us-ascii?Q?2UraPYoPxe/+Cyrc6pYeBB8ijDEnUjFj4KnDaBwVUMJ6d7+5WMY9mMBRxq0+?=
 =?us-ascii?Q?r3Wffnh/WRSNcOxFdCpne47x4vh8r0caqNnC59uHemOx3pz8NXIb0/0fqs/k?=
 =?us-ascii?Q?i0zAuTqCm0tqqb74jpvvidd4nRKK8jM5dGHbMqOZuKgicbURs9zz/5rVNhig?=
 =?us-ascii?Q?Er6HvRPf7uMNErVOZPcKO2ZcJmEnAbg8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYLD/GKlZW25pl8C7XbilR2w+pHlIrBIoCavuJG2d0WaeTUYuqdJkT+LRmY5?=
 =?us-ascii?Q?DRrb91dNL9u9rT94DQZwjVj/ZWx3TcRDh1zgnjgaLxy7ssY+wA3kdjEEVRK1?=
 =?us-ascii?Q?r5+l8Jphan6I9mSejqejT9eNLuX7vu6ZKLbbG35dU0wI12hdLYRp2odJ4QPx?=
 =?us-ascii?Q?5N24GgzbEddhYOAe5OfgIo9ks+5aJPgcpuKbYQtTa6H9bzFBZzdwm/iqDy78?=
 =?us-ascii?Q?yj5HLFACR1FX7utmHARI7AABGiftlBVQelXLfudxnIwoehzYuJWopgGJfuG6?=
 =?us-ascii?Q?x+IW0unjOhAx1ENx+GPa+VHLVhYn7LLJ3xxzJDZkkmpIYuKVEf2O40+rjOL0?=
 =?us-ascii?Q?bYHpoVMMBAo88wTC72RLGZ92v36DhU/nRfA9FSDTj8xy6yJg2bHpYhKb2knI?=
 =?us-ascii?Q?yGy0T3yswDq845GWMVF8+5MC5/BfJv8nPRIaeOr9VwlKjrfmQJq9tCRLKw71?=
 =?us-ascii?Q?vgTpMN9IR7UvtH+ZkmIr9a4kIV5zBirLeHpU/wJpN6eFyoHC8HLg+8i0XBq3?=
 =?us-ascii?Q?sSKk/bn0W3UNA/evPlOS5MzwuGXZfneh35D0SjEh6NyVLFyWMCnqm6skh1X6?=
 =?us-ascii?Q?Hy8b1szEdU0lojMVCvMfuDikbW8Z0R9vy0XLoboEcjMscwqsUSha52bmj4pU?=
 =?us-ascii?Q?brtuOL6ny2I3QFvaIPrbzOcxraUnXZ8/2o1JaGpAHRN6Wk5bvJVfcvA03Bew?=
 =?us-ascii?Q?lAY1xxQOsNPBGQQUj+IZ/Js3N1thtCVYEA+M0uk6lr5N1fRfYLgd5ygHyXTq?=
 =?us-ascii?Q?fuYkVCtSaaNVyTFgd/hVP+gk0O0OsZHLvkS+V5fBNAUsN7igY2W9xShumECP?=
 =?us-ascii?Q?Qck7fRVy3/Z2vav0/gu4Hs205JtFgTljXF/n53nrFBhbCUHMX/nzi8TnFRIV?=
 =?us-ascii?Q?AA+PkK6vW4zuQ5tQpkdQknZR0a9RY0vcYSqjYet/p2Q5+voho3E30ouUwRzK?=
 =?us-ascii?Q?rIlv0aTqFwofqNuI20Olf9qZPKiendhYQXPwClUhHNEZ2/3fJdhOoXaRSpmI?=
 =?us-ascii?Q?zZ1tuTRMGDbeHbBIz5F0aBDb7x2QwSjSeaUXVeIrD1TwGB3SdhrQFceeWvSP?=
 =?us-ascii?Q?T16AeUFRvyad2SJZrjKtfw30O0zkkKODcdmPWqZtW+vt+gan/aYHVS4/7Hx2?=
 =?us-ascii?Q?yrXzT7xqYsUgSxvH/dhbPl6D/WJw+m2nWRD2yvd5rWbEqw5tRS9MHjUkVl3v?=
 =?us-ascii?Q?ChUCR8gQpNmw1ry1gh16HjdmdNXLPBsFvopE4zj7BPj1w9cVOU1HUOnvGixH?=
 =?us-ascii?Q?4VcJziVca66ZL+jhMaGjI184LYe6ZepM5MB9UHhS1e/ROxTqE/yl1Bwv4ui9?=
 =?us-ascii?Q?C2iSp3pMIqiWchLWPDFJJwwn8ZuE1BfPqeebiJqaSDjbaI4NtVAPrk8oDs9q?=
 =?us-ascii?Q?/U0w0VrC9Idf3uFfXiqOoo6KBtP06W8jfYi50W3peSb8hkXAlAibKToDD8Tr?=
 =?us-ascii?Q?Bv5Uerfh1GoFOICfufNWmEs7ww6YlhpSXpQtetCpvtvJAP/vZCQDcfriXe3A?=
 =?us-ascii?Q?jUKX80GhdWNuJWEU0m3luqzOI5FzV2oz4ImD+OOjgTul6J1qIMn6kFHT4S55?=
 =?us-ascii?Q?25ZNjlbs/2P+MNxvzywxue2SNpx0tlgKvchR+CaDCvqIrmcbktFlxb46NlHc?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 628968ed-7741-45c8-9b11-08de38b062b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 12:25:35.9222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rPTefDqBIa7goMTj14b8JGyREh7xuWgrgVkJFxTQIzAsVCLwZgHO+EohVqCi2aPB+KpTEzEIE24TfK55Gcypup8Qcq3ZQ5TXZ2syWBHOwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
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

On Mon, Aug 25, 2025 at 12:35:44PM +0000, Ciara Loftus wrote:
> This patch removes the SSE Rx and Tx paths from the i40e, iavf and ice
> driverss. Each of these drivers have faster vector paths (AVX2 and AVX-512)
> which have feature parity with the SSE paths. In environments where AVX2 or
> AVX-512 are not supported, the scalar path will still be used, which also
> has feature parity.
> 
> This series is intended for the next-net-intel tree.
> 
I'm going to hopefully take the Tx path selection logic patchset first, so
this set should be rebased on top of the v2 of that set.

Thanks,
/Bruce
