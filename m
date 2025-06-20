Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33176C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 08:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54E9C4060B;
	Fri, 20 Jun 2025 10:44:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1ED3E400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 10:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750409086; x=1781945086;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=PDpYNQnvXTx2K05/NM25SewwQC5pxvpOUHpmxOI96wA=;
 b=WJS548tRblkej9DrzTdqYOeTCXgpAmE3jyPWsIxeZ5hV1+Xo8qADMiKZ
 2+wMpiod4soRBElxpTrCYSOxgPsAh4CG4J1oieyvSv3P7XcydBJ0kua8h
 AbVOb1GQOiOGbJW+xFRNiq+8M70Me1qG3KMsbXAt9A5yjNUk2H78fevxn
 GUK5bHnulizbByI8OHzjxma2tNrgf/wGsQuPBhC2rsjPQehEY6ESRLFEp
 FB3jLEAfYVe16iZ+Ak0sdiLGf+bWEGF46IPm2DcoNax1U7i0rDzTgq6EI
 NL73nhbrYmsc8+ponyBNZe/4CY/2zOK7S61FJ9aKgJu1uEgAUmf7Tx6AB g==;
X-CSE-ConnectionGUID: uCQzJ+XRSqGJFsXrBmLdDw==
X-CSE-MsgGUID: J5qN0C/aSJGXscD8m9kXCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="64019376"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="64019376"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 01:44:40 -0700
X-CSE-ConnectionGUID: Lr6Hj09/QxmOLNIWTDKaGw==
X-CSE-MsgGUID: 2mfnqBYeQtC8YM9fwmBF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="155145410"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 01:44:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 01:44:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 01:44:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 01:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZLftksRdmkhH/FNscoEbtCFeYi/P8hOE5YGgiAKpU2h8SFD54dm3e76kxJPyR/2V3O/54mBOqIjNHlbkwS328iHkAW5+TMVrgKXF59c+GlyDvN5VoHpbVRgqcpdW20okk8tiFRmX5ktbCJG1Rr9l88/YP4GMa8Ycn3GbgLN3o4FJQEWEpnA2KlcfA9ena1J5fz9qIHh31RN0Rgt9d5fe2t0KJxnAMDbeEA4vwY27kttwbZYiSNPkWklD0qCdvwqk6Q2bCBHZG6+SDxZx3LdPqqcQU69onujAkroOBX8rG0lAhp0oGACHYAyLUbmtDicza9nMufuAkp4L6FQEu34fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoA5Xlzm5ovgmu8GISy8G7YyMD3QZFQGlBfye0MXfI0=;
 b=b3OyuR/bwFObJRvsd7FDKZe6fWPwPgZAhQerq+8AqXMHNCGmFM3UuHn6A+gXAMEkdHrrMTNXa7C6CLw24/GBi3OFgrbHuW12kDGxpBjNXon1b2XPUyW5qR9D64JOGOdL7QRTAiT16hgBrz0A8J7zOnuQmOsEGqSgGgMg4TFpfvcktWUbE1FUb8t7MimyuLg9NpdZc1W5OGXD/JIC1A+AF18knXb9TAtSAsW+onwQ0z0Y04BlW+JWUqSIWtlWgj9oG4sRDZ87TcdTUxvvBy7Ax2ftUhHDd/XpWJzc2szXND73znHJ26b7XZbyhLK5Lr/hlSPgDO9rxwGRzQOZING+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:44:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 08:44:19 +0000
Date: Fri, 20 Jun 2025 09:44:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH 0/3] argparse: improve handling of multi-instance args
Message-ID: <aFUfX05kEUNz5k2S@bricha3-mobl1.ger.corp.intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616104944.3425929-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0174.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: a85e7029-fb90-4f9f-5c71-08ddafd6a556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xiuRI7u/XRDh3MeyjD7tq4pYPbiN0hyGvuG5acjAB2L20soo5aX/RYO1IZVL?=
 =?us-ascii?Q?EnJPAGycyGkc1QmDM5OIEUFWccv9hfbLbbnCP5Hu8GYJpcXtfv4k/EOAs9SJ?=
 =?us-ascii?Q?9zN5izFALu6VZCelkWUirwiyzGCCBJpr6zjsGRzwq7XvrvOMGyo9c58/ZBvk?=
 =?us-ascii?Q?2QaE7GG1wxS5YBnKk9MMbfgzZTXpq59q9iYiwwlMz+z0YE9ue73T3z2ueEXd?=
 =?us-ascii?Q?cPoHr0EucWH/zS6nG9bttAccFZ5f4R5myt63tjMiOdV3xkI0Mx3uTfa9yiiK?=
 =?us-ascii?Q?8qpc/R1rsKq91TaZf0A85jlpmd7uotvQHvPKoMC58RtruoUPDWh2zr3hvnLe?=
 =?us-ascii?Q?Ggf+oNGCJZIbXpCYS+lWNNxCTd/6oZHdk0kCwlM7IXFwXHbGsn3ObHaFZFid?=
 =?us-ascii?Q?C+Y2DtQknO/pQc4MczR2ICxZUEJp7fZ1e1SSE82+kWuxv3Zvdm0uegCYr4yj?=
 =?us-ascii?Q?z4qvbQ6q2HX5Ci06xjntqoq0qiSlu12m4pWe9HEJrp6xFISYJX38wp9OEcWG?=
 =?us-ascii?Q?DZrgwcFgsL9/O55pQ27mie2qVsV7v9dQ/3fYT0oYJJEZmoRf+/8M6iDPvFab?=
 =?us-ascii?Q?OXpTiUYzA0VvlMtW+DnfEaUAIsV0xHDL0Kjp5UDSdXmlabGVM+29kmMr+R8C?=
 =?us-ascii?Q?+JIC2xBHFDpR883Vri1Yu6atAviuW3Jn5MDMt+PRkelY40wlv9Xxw1v6Yh71?=
 =?us-ascii?Q?uNTFiqe575eq1YaF1HBzqtGOe3Dj7+CX2q1wNTRKoYptLTitXVUvyF5p0cep?=
 =?us-ascii?Q?md02aX6Pgfn+bXLWz9FXQ3REjV7jJ/T3I2+AY6u7y46VkxrVEDsuG9NNOSBA?=
 =?us-ascii?Q?gBJJ9JqlroXgS+NTY9kiHcZZjgIJJAPrC8v39my0O4GD4K68CGBRU30gQkvN?=
 =?us-ascii?Q?3REuggj7emwEn2oyF7TDD1pFrh8AM4CTitWjXHf+zNwvDTRpAowgsbN7Uuaz?=
 =?us-ascii?Q?unx9h76Lei5TZAPBIW20sxT/dM8E+HM9GJkH9sjtTuLNk65LLvn5InTb6kpU?=
 =?us-ascii?Q?SQnzB581gync69M65VDVU2rl3w19J8xdOKLHbAvzBROd+cEosNruQA+8QQ5h?=
 =?us-ascii?Q?NA+sbRkg+LDL9s5BUwArKmgpBv3m1NmgvZknxCfoc2VZTAMSlHGOX58y6Hql?=
 =?us-ascii?Q?CuIFUCJqJbT5pCTAs1c3yuipUpGiOQ9dgVzEN63384p9Tj2Vdsc2LIu2UlfO?=
 =?us-ascii?Q?gO258Yd7qdaDqkFExjnHBpMGcFSrCdXmjyX03J2WGjGFWZYAqxwSJ07WxCJ3?=
 =?us-ascii?Q?EMYbLLAAtOL1jCdvfccGwDNtO3h9ggWkAs7tEMkvb0NlTV72ves2YPZTx+M5?=
 =?us-ascii?Q?zD6rEb+4nSBK0sRFJkmifG7BstvPSuC59Qxf8JmWlW7YH7d2r1CIgy4WA2pS?=
 =?us-ascii?Q?Jh3irtDaMsW7vMcBSq5CGdScM1uDDMOgwCrNNS0lLyZMK2nwJa1/Nb/T4y+a?=
 =?us-ascii?Q?8aR9ldaZK28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKBCJeTpRlVgA2b4SnRBhYAIpxEyZc8aQxrkjFyggQ0Wu1kgb08IcNH6/sSM?=
 =?us-ascii?Q?em+V5ivYF5j18Hl0BRlxujSegXJOxiO66BOlXhiVuxWdScMBY3zbsKi5D7BA?=
 =?us-ascii?Q?S/R2Kv+GLXy2t/DjDlqYYl8+Hm4CLT0svyekTX19SidGJmQX/qtFGmHLinKK?=
 =?us-ascii?Q?cjyR4xbIL3kW7/Heg607QmtuoqgHDUQg32MtyrQHA+otQPjCEXWcQz0+EDV1?=
 =?us-ascii?Q?TCVu8yC0wf2VpBMwXaUQrJJAIGM6xnnYjajxpuBPOMQXK4kYUA6+EbLGm/WZ?=
 =?us-ascii?Q?C/e/hu6Q32XAkh59AHxO7I3J52x612flCUxRiOyi5zMx1VlmzdS5HZiMyuuR?=
 =?us-ascii?Q?gn8QO2ou22yC1G2m2MtvSDAZfQk6T1MlPZD2xPx19J+AzU6lh3w5Xo3tTNII?=
 =?us-ascii?Q?RGRrFShQOr1uhYAjDOscfB3Ue6I2eoJXAlP9VdZGFOTdvJPUnLYIfRwr4h0g?=
 =?us-ascii?Q?BRutkPtIzJyDqS7EvOQ1JPg+b87itlCgp1AdYK696jc6bk/x3aN3hAUiVuRd?=
 =?us-ascii?Q?m3zQhN8w2+GoQuz/1b+r7MWoSdOoi5vjNA0b/YfxiyHlwe6319HI6otSC4v+?=
 =?us-ascii?Q?hoa1GOnSjTQxx1Kx9P8JrxMcrp78ROuaIclhcZy6Y1dlphqutMHyNtV6uNUK?=
 =?us-ascii?Q?9iEe3papKD96y9QzQ6QU/3EeyfNtDahTPxWhzzLeXsvw8cMAw2oWFJiMp2/r?=
 =?us-ascii?Q?cQxEQefLbQmov65wR+CttJ+aUqbSvbjq9rtZoqoWuzMriBR/SMZJAcfZPoaD?=
 =?us-ascii?Q?fVaBLR0eMHRPbeSNkWDskb8K5ZsbFCanHywgSnOymXVT15nfsJYv/TRp8Net?=
 =?us-ascii?Q?Hb216IPl0Pzf6iKyMjOhdP2CI31i5zNKjYLsMtIYeZyHCbmG5K/o8/UD6Onk?=
 =?us-ascii?Q?8LsntX9BJFPNNakU/snPJ25KRqFxH9MBRmmM4xl8rxJPEEYA+INl9nQy6C9i?=
 =?us-ascii?Q?ObAk9nQ+A9ImTQRWylZx6QivHPMoPR3gOfHDIZJzK5EeaeLCNEy89u0lzZgr?=
 =?us-ascii?Q?k06kAI8FY7FmXhPRYCfM34YuCMUtYwER/qV71iyNexcjq9XUWCCh8Qh0NVBy?=
 =?us-ascii?Q?KxksvJS2sM7UMkMQCDRN+a6dMd/Gfc7KbxBrP/l+IQvv/v6VO2R/ZB2zWscF?=
 =?us-ascii?Q?LxEY7TzB3MtAv5tPyJORvv9hJ0iDlLg1nS9AVswwPvAGYmRVWo881Mc+2oxD?=
 =?us-ascii?Q?xesU21Tt5iZdGHHLZnTOTJFuPQBiob3H15a2SVz3+6qG5EatlrFhsdj4Ivnh?=
 =?us-ascii?Q?njUS27/ioyRqJnrBdN3fzZg4WhtBm4OPpVeeMWy7DUrvZi/g5XtYmnOd7Zdg?=
 =?us-ascii?Q?N3il2duXGYFXkz9X9wzQRPfysj0Y2ltEZ2B1KYFhLsgk5pdU9cR0esGhKuqe?=
 =?us-ascii?Q?uRmjIMCaUHesF49j8yaPSha4cmDC1Ll+UDr3xigKQJenYh4Jswtc30ngkhnx?=
 =?us-ascii?Q?u+Sj5PD1bJAwAJghRxrXZYvmxU4g/zGBfIbgIygRELvnJJ+sE/0RFfBCNfF5?=
 =?us-ascii?Q?ODcirBteO8SG18/e3lIiVghy3mnnwqqwARX9o6juQCzulkZtkrIFZkmeMGBZ?=
 =?us-ascii?Q?ke6IRUoP6pzCvWzDOmMTnxnIAwTPgUzCfvgLDk1btW89GDpiaV5HWAkZxG4R?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a85e7029-fb90-4f9f-5c71-08ddafd6a556
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 08:44:19.0887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/sELFG53Yd+E6sR4h0CMnFYj0l8N8jKr1uVLqxVo2ysBhGt/96HWpu5zthP4pcBl/JMA9WBuGHpAUwErkRIRlvUaISM1gsKmOHjublbcLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
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

On Mon, Jun 16, 2025 at 11:49:40AM +0100, Bruce Richardson wrote:
> Coverity (correctly) identified an issue[1] where, after the recent
> rework[2], the internal flag, used by argparse to track what arguments
> were previously encountered or not, was out of range for the type and no
> longer having any effect. Fixing this flag to be back into range then,
> somewhat surprisingly, caused a number of unit test failures to occur.
> 
> The reason for these failures is that the tracking of args encountered
> is done via setting an internal flag on the user-passed arguments
> object. In the unit tests, this caused issues where the flags field was
> not getting properly reset between calls to the parse operation. [This
> is only an issue after the rework, because previously information like
> param type and optionality was encoded in the flags, so they were more
> often reset during testing].
> 
> Rather than fixing the tests directly to always reset the flags, which
> is simply working around the issue IMHO, this patchset instead fixes the
> issue in a more user-friendly way by changing the library to never
> modify the user-passed structure - making it completely safe to reuse
> across multiple calls. This is done in the first two patches.
> 
> The final, third patch, adds an additional unit test to check that the
> tracking of flags being seen or not, and the handling of the
> "RTE_ARGPARSE_FLAG_SUPPORT_MULTI" flag is correct. This closes a gap in
> testing, since the original issue of the flag being out-of-range should
> have been caught in testing, rather than having to rely on coverity.
> 
> [1] Coverity Issue: 470190
> [2] https://github.com/DPDK/dpdk/commit/04acc21beeeb78477b15a3f497d3628fd70a6a9f
> 
> Bruce Richardson (3):
>   argparse: track parsed arguments internally
>   argparse: mark parameter struct as const
>   test/argparse: add test for repeated arguments
> 
Hi Chengwen,

ping for review. I think this bug should be fixed for RC2.

Regards,
/Bruce
