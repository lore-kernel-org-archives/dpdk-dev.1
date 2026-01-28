Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7703FD46BE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77AAF4026F;
	Wed, 28 Jan 2026 18:47:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 21C694003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769622432; x=1801158432;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x3ljDPdejpFCxpxp/tFECJ3uqRbLjZ9cTQpUWFK2wWI=;
 b=SP/Yo1GIxWmpKht33CUxCnb03624LGrHxWe+he/ahyxQPr2hGhwOXOAy
 gKdYj/Lcn4mttPOtZ46S+4SxIP09f3bKtbwVGW113nsu4d5cjdtpaBBEo
 cbh9ypVj2dM7W1JJXw71wIRLEQOpN2yXs9JULqIcs6JMlDRQvTNpt1z3B
 aQIcI1cJN0MwB5EQQuVu5+tmS/dyP4vSVWXh9y4kPQrvjfb3XLv6T77Co
 19LBMS0E1ccdERC3FdKN1VLzDoYoTQmHXBJKyFrowdSO5n+mcw8V0VAWP
 tUlUX+z/O3MfcJV6WDn11hd1frKt/Tx7VYw7zePCwbj0GZSmkRhiQzWEU w==;
X-CSE-ConnectionGUID: XKgBKiY9TvaSUMd1/POqow==
X-CSE-MsgGUID: uldB9b6uQNaQfjP5HJyD2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74467914"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="74467914"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 09:47:11 -0800
X-CSE-ConnectionGUID: 4kv/DID2RimXCKGXXoLkGw==
X-CSE-MsgGUID: /AOzJf/fSomCbSfh9axRcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="212824425"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 09:47:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:47:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:47:08 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:47:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv13kpBaUCU4Tmec8BsFOQxVErxYWQiWRBYzlCgh2OBpL7dUV+TuGbDPt6lwinBDBKe4nhWaxpBM9KN+df4dYU1JZ2IUf3ePs40J6Cz3i6A1REZr6vYCHqltykEiE9/DzoiiBaor6nGKAJRbcw9wzZGHMGeA5pcbGiRGpQp2GkMr6RHX6Zi05c3/bT2m2HKiAia4/gjmS0IlorFLoOakCicDlRNRvliQpLY3mqbKtpxD5AJbOOFxhLHsRRiWNOCFtd2nZinUlnvwZDpXjDLdsnjZHUwpqpjOtzvuqvNaOcs7CxAKlze9iPzQoL7z15pQ97ZO1gHZ04DJpnOT3kv8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5+80rNnzdLaMFG0ursEEaH82Kiq74EVtHdNDrwM6zM=;
 b=ye8BcmEiYWB8QI2Ma6XZX+hwXQQVdSnm8REDvjjwxoyEVzMGfBGHD0MgNpYNfYg3sOReVntVf5l26BiGr13Q8LdngfE3B5KyyMiUSjjoHytCSAifZ5uA3CHbor9FwgJANGNsUYxZTp3X1/7rAYKdEOqx58IwTAkZAWUldlsoYAam+J408SWJik/z+KcQC/J3co9NRO18038qwqbEEXMkX/HQzJVFzZ+JW3zEWc9t//ebgWNlbcm2iwr5apyXXnSYvUn8vofvDFTQP1xIcZQk1yJoGm0QzZ8adK1iiH5F5a/3vEgGScKILBcEE0N19z4TqPYYOOXzG9ZBlKB6fNO3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:47:04 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:47:04 +0000
Date: Wed, 28 Jan 2026 17:46:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Kai Ji <kai.ji@intel.com>, Gagandeep Singh
 <g.singh@nxp.com>, Igor Russkikh <irusskikh@marvell.com>, Steven Webster
 <steven.webster@windriver.com>, Matt Peters <matt.peters@windriver.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] license: standardize SPDX tag
Message-ID: <aXpLkZDEFhW0Goqi@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260128162219.2929316-1-thomas@monjalon.net>
 <aXo5i0oz3ccqSBnG@bricha3-mobl1.ger.corp.intel.com>
 <11418515.5MRjnR8RnV@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11418515.5MRjnR8RnV@thomas>
X-ClientProxiedBy: DB9PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::33) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 04eb0795-80d1-4cdd-cb32-08de5e953f87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BU2BXuipAEnQB2LRN3FjG4lZfAEBBpjRqE4kGckqcrt8AH9jazXPGsX63vRj?=
 =?us-ascii?Q?5yMsFgOFv1TivZG5iXrUwe2SbRW4WEpXbNJgcU0/WQnGAtEEH2PacjoiLCWe?=
 =?us-ascii?Q?Y0honnOTL1rKI6xf5w1u4edcwwUmaWKdQTM7U/HJet7uNJABxkIv45KpbHIT?=
 =?us-ascii?Q?rKRHE+2LR4wV3gjAgsL6oUu80getMiHgclGRlreiP4qcgh7pclP6oSKLqK/7?=
 =?us-ascii?Q?1E4Vxq6p07kEoyI6+VcS0KhSsp6FffZF25YvJqIaEZ0wqF+ZMMEyk0rNgixy?=
 =?us-ascii?Q?DvAkF0CJRtT2KGrI53lmXVQpCLciQacZSpJh7L14bRtwbnSuliAddTEZo949?=
 =?us-ascii?Q?0BUk6nZfijCGwLjYfO1wn0fBj1AP79Ol458quD0zsG5imjdwNwDky/5Hk56L?=
 =?us-ascii?Q?PhxW7d+naC919/fxs8IBvapldZJPqwPsl1LirxdzvjrO+udHphdaZqNcWq0M?=
 =?us-ascii?Q?jZv9DP824YrGflvW60APEGDRD57g/nqkxB3LuM1vMHrjsF20VNymwfdxFDJp?=
 =?us-ascii?Q?qaw4NzvjY5LTsmTYPkvMdBCPqjw2AtPi6nLzHBC2tw34l1iClec66/cCopl8?=
 =?us-ascii?Q?yiFP8ckIkfvIs/IPG9sxY2SDL/SmExnu9fEnhF7gWVUto8y3u2JXIVPr2eHm?=
 =?us-ascii?Q?8vGzw8Jv5w60ytadACAo2tmnQbUVOPQOAzHDPPV7ogBe2A9OutGyRkzVDp7E?=
 =?us-ascii?Q?55LPc2/jUg45R7XPD91FM2k+CGi0gGTBzFdg5eQVQy8/kSGkGjGKhHdtf0JK?=
 =?us-ascii?Q?VsWMqCoAbSkT/w7iNSYEV34b2qDUnMR1oZ6EmQQNquYqBn7F1KG+DMDIw7PG?=
 =?us-ascii?Q?FrAOm8Es8mptllaZCyyk7YdWxtyhUa0Xrwn9tUndSF90grWZLEMXN335f57Q?=
 =?us-ascii?Q?JLtwDOWYiF8CMCmp55dVTUoUrrpDPT+GSojVESXDG1LLJYOrI9FnGfDj8vH/?=
 =?us-ascii?Q?pIU+QjGtQ3Hp7SFcMGF+Zovkkz0hxV/8P4DfZkSreC0wX65gZbCAQWlo9Cfi?=
 =?us-ascii?Q?9TK2LTRUsQh3wPb+KB3+tsNG0lxCSNoKzMrU/RPBufY/DhD6wZiepuJ+tXVm?=
 =?us-ascii?Q?DtjF0m3l8I3tODWH8ClF0reknzPJkpZBWjEAPnHiIm8Run3YryJDO4JkO7G2?=
 =?us-ascii?Q?CgJncBXeOac6IqfnWtQ4jKAjtvBNc/LEz7A/FBJ9aUp65UpdsgNFvitCIZ3m?=
 =?us-ascii?Q?sait1I7nLzRAbZo+Werklh305kx9jNASldXguYIRqZM181Ewbe2k8OKPsPUl?=
 =?us-ascii?Q?+ugou/vHwBy3hEAOryS8BiGN+VoBNJt4ILQ+Tc03/+DMt2eMqTrMOlIW8Kp0?=
 =?us-ascii?Q?W92PmPl6yGvBQzAQxeqsCtPY85ZT0GYW2jN0RfJBWnscY76/EE43I/h2wvgs?=
 =?us-ascii?Q?HOrAKUSSCpzacHdCDV9nBkjihgy203e4LWftVOCvmlVKXfww1erQ4qdTOc90?=
 =?us-ascii?Q?MRlaRy7qFj8NMI/KaFfks8fmZoBdZpwZ25bvJVy2A0kZzVaY3kRKgAgQg7Y/?=
 =?us-ascii?Q?NttZCcafUZ3/I03Z2aZVgQn2/6JxIc+Q7l9N/+H50mFuO07AOYuHJcoDzA+G?=
 =?us-ascii?Q?RnTJ2IoH7reB2Xa7lqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRG01JrQJztj1IHVjyFUnnnZdZXc0KFV/A58N6InVUeDrAokyX1hzNQkQTBN?=
 =?us-ascii?Q?mWNs7/CDTYef6hgIURZB0WFX2K5Ulzd+C0DWClv7CmIFjOACgH6CxOfnihwA?=
 =?us-ascii?Q?lmYXw2HxVIidgO45pV6yfXBbJve7lP6c1NeNbZSWJsmvhA42Zbds2Ph6Bx5h?=
 =?us-ascii?Q?OOvsgVtiU4ceQ7BfsyGRUQ7ojJjoDUoaOBmhQ8aInLHoQKVSVTlUJ4LLrj3s?=
 =?us-ascii?Q?Db/YQF+XJ9hJ3IObTj29fAiss3oh/n4BbZYpW9huNJXzv0Z74SCjfmmNtTY0?=
 =?us-ascii?Q?BOiAfLDa+iqSZD7RJpAML2yY0x7ApY26LV99IAk6XabaoNIo9oDBSvk9wxxf?=
 =?us-ascii?Q?KfSFbpqaOIiZwB1NcA7sUDzt5ScIC/K5Vtbe+pDga1zsl464FsgXUcuSbY6/?=
 =?us-ascii?Q?nIl5ctOUIOP6UHQS3vajOqljJMWIFV07mXBpafZYKmogaJaiSN46P75oqzBM?=
 =?us-ascii?Q?WsSwR9ju89URltKFiZBAJEzSLKUTgWvWrzvxkHoI4CiBr1w7GYVv/3ZRiM9n?=
 =?us-ascii?Q?Sxb/r7UzX8PB/8tUvzVq/CwXjoWnUe140QQcA+jl5AbtISzNdS/DbQ42R3/W?=
 =?us-ascii?Q?EUaaj3nzHqtLei+SaL04yp5ErCC/RLSXzaRF/3M8/zvflm/KmMoyJJMaew/2?=
 =?us-ascii?Q?rlBxmzTAdoKmZh2HTYho4OT4EHLpd0pwB3OspfjHFJk2U3cHrbfW/isvf3cU?=
 =?us-ascii?Q?NaEoKzgrHeAj/wTGuvkQw+tUNHRji+Ku5pTTd9b8HSFTm1djv4IUlNMtkz3v?=
 =?us-ascii?Q?yVpSebeecNrnUvyIEiwc8uXXNwcAMfLyzh7Vi6+wrRQqyPB0IJkeoSZNjKoz?=
 =?us-ascii?Q?R6IJH7TGybeSri+QP2ms72SNOgafMPAjk3DCqXRVwLPBlYrhCsW+NLHbA9Yn?=
 =?us-ascii?Q?YMoNoX3GPaaBt8zoOF0xa2DsSSqllUzWrkQn5fL3kv4wiZddrMganQrzXchn?=
 =?us-ascii?Q?MvMIV+j7j66ZNQpyHEpnZy1JFZLhUcAiKqBi121saBMCiFxdsnfgNVfZ3oHu?=
 =?us-ascii?Q?u6HRzug5Gxe5pbGJ12juf31tXrP79dNsHpFjrE5aqpL2gM8QmpWIO8opmmBr?=
 =?us-ascii?Q?5ztmYTicKtvt1rOfZ1VnFEFGVBWWyilR4OfBeA/eXOlKwCutHgtYLyj36H7J?=
 =?us-ascii?Q?YGS6VDTklQ7MA2v6J5aeZf3mwk058gsPGHYM1pv0EJYIU6XdyYsXYu51ODPy?=
 =?us-ascii?Q?5xZgxNUrNDaGOfUIq+nVDbQxr6xmtJYyLbfwLgh6zwq1ZKnoEz+yUc+Du+2w?=
 =?us-ascii?Q?kRflKvs3PieoPA9sEGxD/kLpXYTxS8iF+p9RfdpHyyf5UtjCaPqBRS6FXF0z?=
 =?us-ascii?Q?vP5hfwojWSd0c/0Kh36Ym5ExY1apJtxn6S1AvvlTtrzAloQCyMsiedPJjdCj?=
 =?us-ascii?Q?b5D8FsmepMDj9J1xXK+ubZzt2mIlNUQTNb6hlEBtU+RfZ0oWs14wJ+0wb5zW?=
 =?us-ascii?Q?J/G7+fm2NKPb5X3gvZxHIfCbzNaaXpj05Er0hcP5dnIy0Pm+h3YS4amAX7ZL?=
 =?us-ascii?Q?4luqim8QwKcpxlvnayO1SI5/n7mXyXPXgOL2xC+KW31aAEnz41wpHC6NC36I?=
 =?us-ascii?Q?DWf9e1V5VM0NCUB2WyGquAwWboRhH98clBKIWdH7cJbBThpxM+sQy3Uz6mOZ?=
 =?us-ascii?Q?RueCbYICgfZ0twENeGY2BbPa/Up1tc9VOup91GPa11bm1UMj5eVInu5qb4ri?=
 =?us-ascii?Q?IqrvEIomdhXDZrnf0UTb1jIVgSyjQm1gnklRtPxpugO+xbIvDg877KpOO1+r?=
 =?us-ascii?Q?y/FxcPyTSpCwXUFKKRp95YrjYWUKkHk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04eb0795-80d1-4cdd-cb32-08de5e953f87
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:47:04.4653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /weeJKgeyZpmyttawWQCX5iYhV1zWCCmyKs/KERfU0mJKKylR572tLEwU/ykXXO2w9gyg6o8iTmzZ+KIsl/iEWxDGXMIRLML4pbpTVFSUC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
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

On Wed, Jan 28, 2026 at 06:44:54PM +0100, Thomas Monjalon wrote:
> 28/01/2026 17:30, Bruce Richardson:
> > On Wed, Jan 28, 2026 at 05:20:52PM +0100, Thomas Monjalon wrote:
> > > In the Linux Foundation SPDX recommendation,
> > > there is no need of parentheses when 2 licenses are possible:
> > > 	https://spdx.dev/learn/handling-license-info/
> > > 
> > > The useless parentheses and spaces are removed,
> > > the keyword "OR" is uppercased, and the comment starts with /*
> > > 
> > > The script check-spdx-tag.sh is updated to detect some syntax errors.
> > > 
> > > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > 
> > I actually think this would be better as two patches - one for making the
> > changes across the various files and then a second to update the script and
> > readme.
> 
> Why?
> I like when new rules, applying them and checking them
> are done in an atomic way.
> 
Because it mixes mechanical changes which don't need much review with real
code changes in the checker which needs more careful code review.

/Bruce
