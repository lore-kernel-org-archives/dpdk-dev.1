Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C0C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 09:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B963402D3;
	Wed, 15 Jul 2026 11:15:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 810BC40290
 for <dev@dpdk.org>; Wed, 15 Jul 2026 11:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784106930; x=1815642930;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aZLGYJk/bC1IbKLPJ86Dy+KP+zBTA9c2pr0Mw6nb2XA=;
 b=Wx7MflQQkxpQSpYcbtUs9s+dDux2S2Zyb9jt3Xn02N3Op/kxPk9HtdaS
 TahbL+h7grc4mQgYlCs/9AUVeEP9qrsMakC7BE0fEzsxfFHFtm/Af+FN4
 pm0/IUhtnl3mKvAGL1jjVrOwmTZifq0xI+bt2FkWy0ko6MB9/AYcleFD+
 1olXyqo2bV8YnwLIEepNdPBG0y2xVoYszvH8remkXpDJciekG1w/T2Di4
 n9gzPUBVKkIl+seDjosbhdT3noGhorFwVCcTy9opDkPBSxgHRuts+X17N
 gCEOQJR1acaIGWpX24OGRTQGjNmFw+qDRLvs58bnnK5PMgX0ZWw3j9eAx w==;
X-CSE-ConnectionGUID: Zvkv4LhNSSmIfuPHIRTBOg==
X-CSE-MsgGUID: UjC0octbTpOMtUSnLJuXmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84780563"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="84780563"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 02:15:29 -0700
X-CSE-ConnectionGUID: ly/txLiwSyGdlGA9CKyejg==
X-CSE-MsgGUID: UWtix57vRhqapuP/Tg8aGA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 02:15:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:15:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 02:15:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMFUvWB29K4yrD1zacY19cNuUzK6FUCcaGzW25qIb74SzmItsaypwkFtSloRnRzzcVtrijU/d5hS6QcH7WZb5YAnnMMX9oTQ6fTSJWcqMoiN/3joO3KkA7dAwAn4y4Dr2lEVlMdi5XYN06nPpeAyv38vjagMaw04+ook316Qs3W6bW++UlesNiNVBDpHgxKSj1enZp8ZRrbDdRnh1cQq7ebootvr/7BnBiboMI7zVgnoL87x3/KHTe1uPpd0ELIl5JJi/GnnXUqPGw1r8S+PAG5uasq6g2UqZBOpYrOXjX1IX6157WhXRkBHtzYaYhTq5mR1yrR0Md4YcBi+2Q9HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JISCHEatse3RrvYDG6/ZSmfPokjBnV2oh1UISP3i7uc=;
 b=xHdMGhPzxaPSegHMpbYwMgNiAZHXLwDpHvhsLA07N9M8+Br6wjyf/GIfOoK4wRWIuGJ0wEdmwSZyMqYBYHVAXAUayPDGHssDMI3l4YBFkwVga3fC6QZLfu+kcn/FOUTCfmS1deyTp0OnTVsFf3/ipa3nhWud/UbDH3I5F01Pbgr+ptTHCIaXnR7uC5yM3KdDLopXf+g7MPJpjQgKDdGBwk83rxu+/BnD8WerhxEFoA3SHJYl0BjU/ZXSePTbWS9RL1yr2pVT6VIkGKVf/lUg5vAA1wNmQQSgJkd7m4+zJ5dxV/Z+jyypE7IqDWMC5ro6SEcaPjaSKDrM0Z/bxPqUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by DS0PR11MB6448.namprd11.prod.outlook.com
 (2603:10b6:8:c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.24; Wed, 15 Jul
 2026 09:15:26 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:15:26 +0000
Date: Wed, 15 Jul 2026 10:15:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: add deprecation notice about upcoming change to
 ethdev API
Message-ID: <aldPpq_U633rZTPN@bricha3-mobl1.ger.corp.intel.com>
References: <20260603023207.31974-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603023207.31974-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|DS0PR11MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b95ae7-59be-4707-23c2-08dee2519a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: j4/sKRNzaLG420rJX9/HFM1jMgcCiB4bO5L9JOc2lfqExz7tGogHWic4p3elHnaDgXmV8273iOkA7vwlLoWwn5WYprRnFRD10DyK5MK35vYIRNe7IRXfKKotTkHO/ejgxluUuYvbc57EXuOYg6Dw0MJOCFlGiCp5Hz9Ol65/KEiNMJnibWOGfMDoUGuy4Hex1iVpVa5qqZY9wiTWW2++SnZeq94hR73UHLTlzoE8FTlYVeUBvXzpAk7/HqDeEPYP4pZcNGvR1uxPq97Gvx+8KMzb1OINFW/QERk6S0YJ4jamIby7MbsVhd4gEoeGMwFcaWQcZamY3nuPEDamd1lKVXHT+5CjbJk3ZPtF1An1+tT0Q5MeggEF/MIYvLminoPA+h2ysFy3HorTuJFUpdEHQEY/ESpLP1kZOOj6BaALs/jwY0u2Rz5xndRgqlGwI8FM35cooahk7GwqvxRyTYmYAFJbmpQqS1xluN4XIzACWRHTSRh7df3VW5pryg7ja8BgQQbJ4suzYG4yGxJ9ihee5nKp9u1lOqPP2hMVfEY/HyA+KWcZ5k4dyQ2RvhjJtYKtsy44rFLoQ3OImz+fSYC7sf6kG7RzqXN8dY8aYDJKgodTwRq32vKhLRmvBKjmbT82xu686wpYKPcBD9+30/JN9G9VLXdI/LqHmG+r9EWDVqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRCF8Un7uW9MfqvwJBMyn0MfCXosezeu0azw3xeCopMca+pQiMaZgctkyc4O?=
 =?us-ascii?Q?hBDuEbEE4x9BQvgn8toVDx/V0ujabFy0lNk6TGUcORXHd3dIcPalyYA8BQE2?=
 =?us-ascii?Q?CR/WW2vGV0/fBdAhFHobksrfQynn10SZziqCgZG6FPiiL2QEkcP0/m2jiBqF?=
 =?us-ascii?Q?5bYzW/bbOl7FShoe3lRQFEvZUlf9bygdagFsAto+yYoDK/Q0efAoDzNL8tMr?=
 =?us-ascii?Q?OQD7HFPTUbQj0vpqjdvT7E28KowbR/xnp/b8bQUCeFfrsn7xlh4YD5MfvSvn?=
 =?us-ascii?Q?V4lbiHTovURWJ2glnqpWnCOX39Q7ACQHckYs/7JYFmPdZAMvZydAk9ERZm7W?=
 =?us-ascii?Q?4VlAO7mFNRcTFyA9GXWeDJ1q2JYX0b8qCem9foqKRgV1TMdcPOSNzdO2RPdk?=
 =?us-ascii?Q?2lWlBoUNOtsuZVC/4OWllkD8H+bQHU4xsmDhQdQOuok2aLCkPDy8relOSAJz?=
 =?us-ascii?Q?1zwGI7BGARGfCSrNXcuSZII2BIlDGnMyb9YKdPcculjJ9QbY5ZtAk63Riiim?=
 =?us-ascii?Q?mENd54BIEOpynZjrzeoxkx8P3zocnocesn0SzAesKSGgpEdvrp5/8vYlv/Zu?=
 =?us-ascii?Q?9fkUJlWuWgeXUoiOAlBa6YMcyr7VHNLALHrOADIPVhHFvzNlHOPvMZzH1Fxp?=
 =?us-ascii?Q?UZFgyBnptfE0rhmu0ClrL+HeUWNQ7eiGHrGY2fawwaDCmPwiEU1xoP5Auu52?=
 =?us-ascii?Q?mGLAOruxBMWgNJPxdDcynjlwUORP0wEiR0TGhBgKaWhJWpIEYFUnyx8mjkda?=
 =?us-ascii?Q?lcYf1Ha0sjCXQy4FY0GwKx7hC8CecMXqT74k4bYpflXNpBZ0xPEjRvnYQl0E?=
 =?us-ascii?Q?JocDc5ddpQpfff6+i3nxwzM8Vaksyl98H8yyFCwbM4jLh323M1F7aIyNb8zr?=
 =?us-ascii?Q?VNVX56SZaBUWlQmfJz9VRz+k7glhdNhR7y5npw6/GsnOINZ44VrD/5zgc7K6?=
 =?us-ascii?Q?DbaiRjXjMSXkLefZMMAaGUjBLzrhP7q9UB13/A6lrhJ2PasjOs5NNG3YVOkl?=
 =?us-ascii?Q?QxvPPNWWD2QyfCMz7u4dKbETnEr85va6fPOlAWCTLWsN83ynRkUskNHXg0Fg?=
 =?us-ascii?Q?fGMNImUUp5PLA672HlO2P5cs0dYZXzTv08aBztD0rzrgZH0+wBLOHzmZjDQz?=
 =?us-ascii?Q?I564Ndn2bzoSlvVvzd6Xr30CovFzXAorNPvf2tUguP6mAMBXF4JBn77fNTHU?=
 =?us-ascii?Q?S1gJChzaSLhPAk9yE4vWYq2/uq7+3zaZukdkgndh3/xjClOLcmZFwLyO0Pp7?=
 =?us-ascii?Q?V/YfRi6YQ0PsmdFHgxXsYV38ESYjrmyXhnGZNloEgciTDRTRJKnXaEijADgI?=
 =?us-ascii?Q?3rmlG80RTCJ6pPsRiIQ6Q1ygWaNcYsLWU9dyk21jjtoTEvQmxB/UZh2nFCIc?=
 =?us-ascii?Q?ag1aSFVFrBDGG1VoGkbAWvWQv7SDhNPA6wX+Cwn4I072uaQvrd40FZKDE2YV?=
 =?us-ascii?Q?zrJARTi97GSKQ4WgJH3KgFAGhrjN6TXjeSIxQj7qvkXiMyRHcxZN5isUIy0E?=
 =?us-ascii?Q?8moUGlRNkmQNlfIiJVOPcDBjd/UBJ1wQHZw9q77iOJ1/h4bVjOwEOlPV6kmf?=
 =?us-ascii?Q?IzbM9qxzc92Lv3PrtTR63cYzPZIL05PJ0q/1Hzzz8/9hW0V9iBg0hQEtv0ls?=
 =?us-ascii?Q?Ne6tHGLEmt8ImXVyfjf6OPCExIzm4XBaz2E6JaieZhHb27a5oz1EcCQszcGP?=
 =?us-ascii?Q?jgtfKT0cuiTqitJCqQl1aHO5OsYtOjNRDV9hc2R5/mkbgh6vUXt3xNk5xhmf?=
 =?us-ascii?Q?hXdrdHHuD349/oV+lh15iFXNPqBIUko=3D?=
X-Exchange-RoutingPolicyChecked: tDUhG5mHm8Wlsr3EYG81CXKlcjCYKxSWAQDHJcoePoRwygskwKTko+hziNO5H3uGZ3zpYP/f5ygD0KPWDnE0uaajqEKl6g+Kfo43ww+cNhNyFjtMmq9fStSvwlWQ0d9CxxFzdjQP2Q3X6Z6OK3UGXh23EQEDBy54tvPaPjnI1T2bW08UeD+67JrG2fgjaZhqU9Dh9Hr208hBs74hBbEs0x+D2zP3yGCco31BWZGrXs1xa7rOJr0UML5oecNLc4Ruu2dlF3lVYEWnzfjUK03iGY0L6Hc48vlEGNmGXTI3ex5R+lvDk1+iuSMfrZYGdvfVJFpcWiV614UwCEkmM0uwxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b95ae7-59be-4707-23c2-08dee2519a6c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:15:26.5245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5szu4Ib0onaHjgM3xRn/kg/11Z5181CeSCSuZ6nb7ngrg17IWK6HxEwKCxeQOYlglt37x/Y8LHPMIUxnRJ1BHcE7A1PUeB2jkS5d9DNvguw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
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

On Tue, Jun 02, 2026 at 07:32:07PM -0700, Stephen Hemminger wrote:
> Inform users that rte_eth_dev_get_name_by_port() will add a size
> parameter in next release.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  doc/guides/rel_notes/deprecation.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index 17f90a6352..d390a1640a 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -158,3 +158,7 @@ Deprecation Notices
>  * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
>    transmit path in the iavf PMD will be removed in a future release.
>    After removal, only packet type-based detection will be supported.
> +
> +* ethdev: Starting in 26.11, the function ``rte_eth_dev_get_name_by_port()``
> +  will take a size parameter as well as the string buffer.
> +  This will detect and prevent accidental overwriting of caller provided buffer.
> -- 
> 2.53.0
> 
