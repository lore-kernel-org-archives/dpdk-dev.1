Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EBCA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9BC40655;
	Fri,  5 Sep 2025 17:10:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 08FFF40612;
 Fri,  5 Sep 2025 17:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757085048; x=1788621048;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EO9aYVJsgMMsD0k8GLCWkS2BmJ9jCkOFl5Q9cpJKZb0=;
 b=BessxErTvNiw8qi1hoOtfO3icN1HtooWCO97eEd80unILE+oDRba8TiC
 RqMeyaKL9MRwQZlwGgrNEBd3yI5zbb4RKjadHRUNECV37Ow4ZUXT4Pydm
 dMyAMsEf0lK9z9o31KwL6GY4UqGORZ0dRPtsyuRwxmv55sA8MDGjklb/n
 qQ25IwgFFrHEMebaFyP3BplkX/Vy+fsNMJQlz4TPA/79bzwhnfmIYB09b
 vYY6ONE5haW1vh+HLWpQF6lHnxPoaeGH+SqTXiayzO1Pxe6NQXRq+5gLX
 0ZyeE6uWY0F35rGV2M1cCEeOBak2T1P+U+8xgpBny23cQy9z85togqGpl w==;
X-CSE-ConnectionGUID: pxpDk7BmQWiF57CN2B3fxw==
X-CSE-MsgGUID: STNLcG+kR0W3ZsWfrUppQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59136108"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="59136108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:10:47 -0700
X-CSE-ConnectionGUID: 5I64VlXkQcCp5eR5DBwQFw==
X-CSE-MsgGUID: UlnGaEveSXed2rg02mdKWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171750687"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:10:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:10:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:10:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.88)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVX+DpOmOo/l99Y62Fxh9vyhG3eZmo9KFSPaMgGMpqfmiQbQqz46jJt8/+Q12uTW/1x1gi6v94ZPt5wJYu/9oq8lkqywQSAfTO7tTp7udrFAccX3L6Lg9hG/ALN3t6eFA+jpsUAr4GxMAxK5cEVb3eY1oLx5nKQ0cnrTb2t0tPNMgqW+8KzLswIht7ejijCnAkrGoKvKCJVUAo8TdV65khzkU1DY09QJPMCOLWA33+xkkT2n7bhAXdRFI935o2+xohL69ALI2TFboKcpJwyHRC4Gpzod7LW+Cn4NcKRGeBZcS20yODEZKENHicojETD4F23LXLygKx2QgEESYJgytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hugUCxPMqJDuzSyDfnAkR232FKM+I7yFqGOzp+RpzU=;
 b=ljH+61yd1YooicC9/ArrYwEQsKnLu7sJ9J5LiV4YNJPN7vA7ex6PdJoMymUa6Kdk2bUb3ZAqUbB3m1jZLqVr+uQODK00f8eBW8lQrSedS1uR1rHIMtBBROW8fgLDHPPRpeQ51VOZGLCfu2VT2xZL3P0VbukzMOknthOQ5GSNxYmhve3DvUF4pjt/IdWVxn1o9hMz4LJtWOEruLZRAqNMnAdQS8g02EWWYuH23Y5yzc+QB4m5zFhudLdBe88BOsXfSJZiaIbZus3wQUPYk0ezLHti3X+SlHbSLoDL0s/3zxCCQc5uMBX/352MdPmPmhSlwTUjO5VT4n4fR6CIvCZTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 15:10:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:10:38 +0000
Date: Fri, 5 Sep 2025 16:10:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Grishma Kotecha <grishma.kotecha@intel.com>, Leyi Rong
 <leyi.rong@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1 04/12] net/ice/base: fix memory leak in recipe handling
Message-ID: <aLr9aTY3Xy05bn24@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <bc0a3f0b28bfb84d7a8a372d43950c4730c4a189.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bc0a3f0b28bfb84d7a8a372d43950c4730c4a189.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR09CA0006.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b2c421-413c-4897-2e59-08ddec8e5ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XqXZGtPkY1/ZhoN//juOSpPYjHrx3MN/F8/s5SQeveeDXEywO1f0DzLYnHMU?=
 =?us-ascii?Q?9J+e2jTd2z7JV7x5VdsmAvlLLegT4mrU9oijNw5uxjarLF5dNpFZjG3uq9IM?=
 =?us-ascii?Q?OQ3z3F8xj7I8Gn9AXc9vl3CxPUjkNzR1HvB5MOD64ObECXxTgE8bjiTRTYtA?=
 =?us-ascii?Q?3hW4zpUn7Jgf/vum/cjOO+sYwGhLu5xUsXIwz6ARscGTdxGigmrCj/Ww6mde?=
 =?us-ascii?Q?0+KzSSrNmCl3mCn5MPvMdiL8aFdSp6EsHa9c0CvNCY3jUnqWkU07f+zuL1Ye?=
 =?us-ascii?Q?v008i5rjX/o0+hmujNTSRdqQwF3e9wedUPAnUO72Gfbcmts0v6q9QjNCqo+j?=
 =?us-ascii?Q?ZOsRC6Hq/t6UuXLKrzmlX293oSY0qqPRWW6FRgLpxKNHYKaftf5HWhZ/+dh3?=
 =?us-ascii?Q?o2+DT7XaRhVu1tCeoSsI7U9uJw7lk5otXMGM0wCUxkJ4EyWjpJUfxeNDqi4o?=
 =?us-ascii?Q?Lt0LctQo8jsBb1N4qErOdDwMcYK0OREVPGzw80b2uUqgSlv38MFtIqgbzzMo?=
 =?us-ascii?Q?SbgwTRwAkV8B+fxFZdv0zxWg6LvIELHQ36+SEGZNwwYeI5059MJo9HDrRy/h?=
 =?us-ascii?Q?MMGsfy2cC32PjwQ/8/swtf2SKK/sYmx/09YSFyclHzm7nKa+szXNKIXI43eo?=
 =?us-ascii?Q?YNFqwemTB1Y8Bv9rRXfRgDUoKId6c9j5l1y6/TJoTTlRs7ssKsACXZxtWtFD?=
 =?us-ascii?Q?lX+LD802txSOXsE7wH92WWBX6yrgoUoLhqWaDy4Rj0buuPH2+jBj0Ib+vEL3?=
 =?us-ascii?Q?dKCbVPZM7rKj+QRn4j5PfTJRUthbThdvatWuP65ZoZDuOr3T7v6z7vgGvsgo?=
 =?us-ascii?Q?s/dlXX6hqizT4u0bVIdiFJ5IjV/nv7zFNuWmkTydn3cDUPydj/2J9QFDHLcH?=
 =?us-ascii?Q?xQVKJQfA19CGZU1C9LrZQxFmA+zZYp100+CLuSsD/DiaIxxWqT3OIAsfECeO?=
 =?us-ascii?Q?ReKJmgUQaNqzMEY/7aMmBznOhOD6jXi/sbJltp/lqLJjEmCd4gdO6MQRYs/B?=
 =?us-ascii?Q?kiWOYB/IKGFgxpMeLw+N7Xh/PKpaCo7atZduqdvDnDv2xd+H/l6kAE+qLXVg?=
 =?us-ascii?Q?7DVGmjR4PLPRjbLxRxFQiF25IWDykwbUV19KvFulx2MndXnTOeSDpxfrZyLb?=
 =?us-ascii?Q?dh66+o8MN9COB+zj9CNYnECYKPx1lVC8vn20SGkJjOwge+adRaOZz7A8w9ZJ?=
 =?us-ascii?Q?zk+PEDwxRIzbKLniwe2l6fd8yZW+xxNhzQ4W8ZngHTc5GmLsgKG3oR39j39i?=
 =?us-ascii?Q?CapW3TLcLO4iYW9EaxcHvwG9+5vCL2VJUyUt43AwBtEh8ACAapmxwHUW/zXw?=
 =?us-ascii?Q?CQr5rBvUuxsOOqxHYl+yFqtH3OC6VXn2O6VwOpSdDtT8+DKTmEv5XUCpE30X?=
 =?us-ascii?Q?QZdDM/R9bwswTTn7MCoujH70qvokci5Jzg0EBms5nu2U7x5TqkXa8u6hdc9d?=
 =?us-ascii?Q?Qu8INeq6eh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?piLn9cMvPw6lFUJugAfvLOZESmrTfNkvQhLeO0SggBXJUyy5JQCSBISnN+lg?=
 =?us-ascii?Q?+N2B0fBuoupY25gvGNyjblSdhtdolty526FRi9w0EASG8X3nAQnUqbYZ+YHz?=
 =?us-ascii?Q?pXhEsmHL7PPPgHbeUvm3eNvUwyZyT5ECFx7jw0Gk+ijkM4v+HzgHGqjzMwBf?=
 =?us-ascii?Q?7lib8/VB9D487pcGUATgx75Q84SxwD7De0Fdv/8e0jBAbxiOqUfCHgSKsnOi?=
 =?us-ascii?Q?nfFC6FVLjbJFgHupCGEyyf4d+ZGJQLJ+eBh+Rw2a/g9MFe3qQwR00PX40G65?=
 =?us-ascii?Q?RpKudn69Yq1vx2HFm89/6f3LZ9qykRCvOPxr4F/LP7//4CKpX8mI14pA3Gq/?=
 =?us-ascii?Q?FEjhgWxlVqAvqCtcBEvyYE08cPdJMNzukSLXcXDlgRFLVnp4G+kxr0Rqkt54?=
 =?us-ascii?Q?+n8E77PbX6C+siRqip1+RX47iyHdQ3qSq7Y58pQkU7YRdEf0PZi45Cci3r0k?=
 =?us-ascii?Q?eASiHCnr/JzteJTqjswjqgXzKUZeBOiOT2mq+UhqI87qpoRCraEvmaDxzPlk?=
 =?us-ascii?Q?+6F0bWyZ9UsXj4ubpGMTBTNUOM6QPwEt7IU6s9QneKjMAlslprx0qoDAKPJy?=
 =?us-ascii?Q?3VzPUxuZ0hIjE6LO64ooBm+3ZAF6QyuyOird+XVVndZUQq+Y5F6HTLYnXg0z?=
 =?us-ascii?Q?eKnkaOyFTbRIgrGHlWcN4nIz5GmfDNSs4CPGA4enK/nJZ+9UOF4ttmE6sylD?=
 =?us-ascii?Q?SWJlp2jHWYsyfIBA9/nunSpf4Hy7Kt2oYlntuZqeBj2+I5lcHRISy0YxOdN1?=
 =?us-ascii?Q?qWOqbKrjNWb9hkd3b12OaeEPto4ZpPzg7Hn2iE3QLGFDIx0IaEnE3q2ApxwY?=
 =?us-ascii?Q?Uk3Y/UKjH7vDl89avPAE1d07eS2yjUdKW5yClSg2Az8HPI88edjwUHZPapVv?=
 =?us-ascii?Q?mmDGPT5781/RPaIYS1Pj0QqFJ+8d5j9NPpwYPRqT7RMd0M5IXFpoCNCaLHdu?=
 =?us-ascii?Q?qrP0eYHPX1Uj7oX5LAIWSxlVwFaH1WDKl14t+Ua5/t5+vZnWgt/bQE2Uf0xl?=
 =?us-ascii?Q?+Ldka3mjdMlF+FdFsL2/nP5VmER5X56IN3+SVuegrRkVTSwySb8oQPCgdnny?=
 =?us-ascii?Q?RejpmS9lPpG/SCt4Mwn5rHyDxyTiiws1ML0CnIOP5sLsdBFy0G167XKMuYSr?=
 =?us-ascii?Q?PfC3xzNyX9vrHWRxU7FhjsoWfmUqYsSejICAGYclvKVSJAN0yj9NUswondlV?=
 =?us-ascii?Q?adCG5LnEm5+Jjdf+HWCz5YV6G/nj8tcp8Lu/OYE1vq/5DvPgZ8l3NbV0SdyK?=
 =?us-ascii?Q?iSft6nNTjj0uO/8NXFemn83UUWgrP8Wk8AAbtpD3rA1qgTSp8HQCyr3v+sUM?=
 =?us-ascii?Q?4UnKPGNAtFyyBtceCEpQBx26mA92LPkWsPHlLEkAMSuJ6hexHY4Bs4JjiVT/?=
 =?us-ascii?Q?d4n66kHgMZAjZKLBSOegEYAEU2ssUUZp8c6RvCD9bSe6tmOODYrQ9EPv+tq7?=
 =?us-ascii?Q?MAatzY1mVTskMMgLVz0GvAFz7c/AzvvYo1V1RZ+GPgPmq9MLBu/XR8ApGoDZ?=
 =?us-ascii?Q?zT9vtLsBW53d/fgdPrcOYfdrRlk/pWYYW9mKpL8xjGraQNGt0VWakWO6kBcI?=
 =?us-ascii?Q?rM2iFE3vzGP4I/ZigRli7UeDTvao40iEejtQ1T+L49QpFRteYChKY39PRoTI?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b2c421-413c-4897-2e59-08ddec8e5ef9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:10:38.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShrKwOX7APJK4qUowQ3joQdp5ingKFpLgnEaa+fs0knbMCpgMgqWTbRtjr5cUHKuP78vir+EAMBh/INtw9K1pbL571mYr8Sal/y9h9k426c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
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

On Tue, Sep 02, 2025 at 06:26:54PM +0100, Anatoly Burakov wrote:
> From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> 
> Advanced filter operations (apply/remove GENEVE/VXLAN filters) trigger
> the call chain: ice_add_adv_rule()/ice_rem_adv_rule() -> ice_find_recp()
> -> ice_get_recp_frm_fw(). Each call to ice_get_recp_frm_fw() creates new
> linked list entries for SW recipe tracking without cleaning up previous
> entries for the same recipe ID. The linked list then continuously grows
> with each filter add/remove operation, leading to excessive heap usage
> over time.
> 
> Fix the memory leak by adding logic to remove the duplicate entries
> before adding new ones for the same recipe ID.
> 
> Fixes: fed0c5ca5f19 ("net/ice/base: support programming a new switch recipe")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
