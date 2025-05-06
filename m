Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A3C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 11:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D15A40269;
	Tue,  6 May 2025 13:07:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AA67340150;
 Tue,  6 May 2025 13:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746529629; x=1778065629;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OyO6Q2Xgw4B8D0w5c01Si85HnTatfmheBJLeYkw8VnI=;
 b=bLF+Y7oOvK+9wjs7WxWLMHaHm/XAy1gIr6tTKzdmCDsRD1A40YfEH2rh
 QGlxgecekLbWbQdZJo0EpI1hG7XGGNNH5JxWkFZTB4A7CHPstNH7D/o91
 lHeV9gjAuSuaBvD3M8vFlCkZOoNY0gE76afcucjD2XlNr4Y2zpQGAkaJY
 A3xpHgtnQg22l2M9kE6A8aT3LLmbzpJ3ZUlGNLR3x/ooIiTB8Tkn0pYfO
 KiHZVNqyon61BFhgDMwZLs73XQALmiyDBjygSr61bUUUTSDrm/ONO9bq6
 R0PY9AEJHfKpdUYhivsaDSguWSGtZd1+LD1GfkwBZSx67EjxkPTEfDDVm g==;
X-CSE-ConnectionGUID: XT9FaqnLQmaeWYAsc4agkw==
X-CSE-MsgGUID: uqjt0+GfRlmW/oGF1o1zjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73589949"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="73589949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 04:07:07 -0700
X-CSE-ConnectionGUID: wXVK8DOcSgGNmCj9VBLoTg==
X-CSE-MsgGUID: rlH9dsZkSyqgoagfrprUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="140343978"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 04:07:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:07:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 04:07:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 04:07:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r77CyEGj1zI58SeB7ihkRboXnqSJI6QYoErwwZuIBHh3BAYoiFDZcux22QUUSKUjd1/PNhIyhfFFe7W1YFb/3cwyQxK48HsOPGmqytrNCyvJeblAwJuWHYANyU88DWe1CKk2t6QxChb5RwpOVwWF+NYE0PcJjdTpB0Al2ICp27hu1LTMAB9MqkQhe1DCrzc+UoxaSOlprTt8XgM1c2bjoKf5ZwNH++cIQVx4JYlxDi8Zqt6VeWyss7Mnjf2sZ61vmeOTgb3n1BFPPEO8h09jSsqQ2Cv1qC6avZVsCPOnlRovvJvXUipriDyV6tiVHbt6iv/a5ztHi9stQt1Muwd2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECmNfIQgttmUwZxWK5nR3jZ+gLHdQnZQNZykqYEH5R8=;
 b=g7oXw5IQP2QmH3eZCx9l3u+rMwe6L3Ejgl39BxHO78KShG6wm3rLj0ywofoWXPC2+gw7ETLotu1ouRYBPSGPGVKjV0d7i4bwljp1tpr2dTag01CEtKQbCfCICvR2QYVzlMAynTOAjz/IwBlqwboPKqjUOSaGGfU94kX/NQlN3hRJGHCTJl0Q1nXENX4GU5eBnEQ6GxF95YeLQ5xdxaw0GeQyBXdT+smBgyCSt+pDmpYWmvNt7qt27L8vnm8PpuZjKA974PPLIIbbGHQ+z1N3w/K9T9kUdHz0nBBL1JiG3RWe08Q8Scj2hIPWXT3jom+TsW0a4z58YuFdu9ckbgooag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6079.namprd11.prod.outlook.com (2603:10b6:8:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 11:07:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 11:07:00 +0000
Date: Tue, 6 May 2025 12:06:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>
CC: "Wang, YuanX" <yuanx.wang@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix port mask default value in flow director
Message-ID: <aBntUJTRlqhUZH96@bricha3-mobl1.ger.corp.intel.com>
References: <20250418074309.705337-1-yuanx.wang@intel.com>
 <MW4PR11MB5912DA7DB0D41DEA230127559FBF2@MW4PR11MB5912.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MW4PR11MB5912DA7DB0D41DEA230127559FBF2@MW4PR11MB5912.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: bd069885-94eb-44da-211f-08dd8c8e1fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FroGSp1klPDWR4rE6ugo61Dyxm+GYyKN3u+XjeS6wS8+98YNtMucJvT734dF?=
 =?us-ascii?Q?Rbffg6eNOhoU4WHK6X0wQEVcpCt8MrIh0WqgreMBsw6ezt+UzEuSfs5zs+Nl?=
 =?us-ascii?Q?vC6NUEFU+x4+cw58/2+DVvxByMgFVpi23gpw0zWZR7nWV2vCdNx8IxJk8L3f?=
 =?us-ascii?Q?oj8GG/awANFhD3nM4IdLFhENCRuHzjUOPIbmJDUcU+FtAd52jqgkx5Ec/lWo?=
 =?us-ascii?Q?yEZQF9/0Dm4llkPJoDZvDDdKBJibCPixh1sHAJIFYPHpp3iIqp+JIwfFbhP5?=
 =?us-ascii?Q?95rmycS55d/CHyRoy5PEmypi+eLixDeHMWp9G4JtHAvmmfNxk69ejgcSst+X?=
 =?us-ascii?Q?lnBnw5lpfhOz8LAeJDTNwPK6mBqcLKhFXT0/0eY37X2zS8CyYGHRfeLwkU32?=
 =?us-ascii?Q?hf7VCNMGs9eUwABYpNdnCxZfsC7I4QR/bggvfElVcqCiPK+uBdd8f0vkMmPV?=
 =?us-ascii?Q?olKnzC+x1rVntfaw4RuyMMd/NNHxPoziPRdTLYeaoHbBsVZCgnIGNG1gGRr1?=
 =?us-ascii?Q?PBFBbzm28BFgpTmr8fhW5/6Tj/bFl527q5sbVXWKo8AusVBWjAtBDf2V07Hx?=
 =?us-ascii?Q?A64BfaPSa2ZwRpiUy0QZMA7i0KWbJUwr1TT3+Mve2dJidx/VqJSgRgW4jOoD?=
 =?us-ascii?Q?X9x+UlHsju+y9Qw363de0vKC4ZWf9TWQB77AnAVk8RG6yuaHnHjl/oOhJmwg?=
 =?us-ascii?Q?R3cYdAuYosRtQ67xA6bj7KIGOCp6SjheqA+pOOqxM328YmtUM7UO7h8Xq/fZ?=
 =?us-ascii?Q?H0hQpJgFOojXQoHFGL3hvOzCIkmVX+J2uHkC3T/MNxncLchX3LzZJCVowze7?=
 =?us-ascii?Q?/Yqw/ZDnjQZAvTcFAJ8oC/PiXdIQsoslcX7je9XJUJxDZwB5cKh8b1eaBWl/?=
 =?us-ascii?Q?W4WF3vfHTgvVO9qko7hTlaaBU4mURFQuFOoKE+WSfCbQUEhgEUci6D5DMmsp?=
 =?us-ascii?Q?1D2ZY2XUofV+5GtUID8vATLVdBjVNm89jjpg2UL5lqsh7qJ3X8JhnhX36xfE?=
 =?us-ascii?Q?JK+9mIcooH2uiIosLloHBDRgfts3vwTgmSVz9IRjwmf0zdTvjuo2Hc6ElG9F?=
 =?us-ascii?Q?KOqyoLaAhn2/EQj5M06Syc3erBm5SkdxOqL9tHpZ9Qxp8xzhJ/woI0HVbH//?=
 =?us-ascii?Q?8V6UoC9Red6DJvjrJ3CsceSQrLcnVkjynh8+CdLG9L12ZS50QEozofW+Hxit?=
 =?us-ascii?Q?j2PQVajGcEOdbWb5LDDTbetdReciTYAv9hhkN+Jh41QVHejQCdlG/5AAzRbL?=
 =?us-ascii?Q?ZhQNUCwxanpRZbfWf/nNoBEhDfTvtveSXxP8HsL094ctvjuyAaHieTDlqKFn?=
 =?us-ascii?Q?B8Og3eY81xpFDSd5wkKJD/VweYNCXyfWtHDSDZTJBzTjFXSD567CYrbC6o9b?=
 =?us-ascii?Q?R9COeXyGp0R4loWlhovlSP4KwpH+qT7f313m2zEJrzGkhzvqRgxPN6TluDpr?=
 =?us-ascii?Q?Z5SPjj//VFo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0r9CvP71ayPS5yPxamUrNiXpnEIcgUZlgRH5siO1G8D3LdqlXLgXVXbOr4Q?=
 =?us-ascii?Q?t8RoC1+I7oGvnaH7utJtMj+2oE/vfG2bYU1/FM/linHhkvSVktb714AOeBw8?=
 =?us-ascii?Q?kKuRKg5XXFk1lJYDkqMW0ItzB0yjmtv571lhkpDCoFGSU+pXqsJ/aJOO7uVj?=
 =?us-ascii?Q?xyRpIxYQybtnfsh/mxl6ZjHxduN2I/t45CZp2lnu1bsqmZweyPEhruto0YND?=
 =?us-ascii?Q?rZwjcpWWEd0egh3jDhggJOxDVcizVksj/ir7MnD5Hp9BYAhQ24ip0M+1wckN?=
 =?us-ascii?Q?Ns6Tr/fQTig+r3064t4sc8EmfPD/+7nVwF49w3+mQATvhBrSNPn2bPdvUDgg?=
 =?us-ascii?Q?UlVExMxFv6A7FHU9E+/3V2mSCSuqmsRLzKWjiS6b73+8RQmdTtdr0PRBHVVa?=
 =?us-ascii?Q?E1BWZ+A7RWWw5yiTo/SzpUF0C7JMdnnj4u1KgrdPizCBfB2osj7pXfLJA6jI?=
 =?us-ascii?Q?rZPeOJyDGQwYnax9PBthFK7J7djJFKQLOKhXYxy4/CBh2wdM3U9MqwmoFxLZ?=
 =?us-ascii?Q?OvTw1B3r5+fTTfdgG304nbGbe1+DRnWvA31JuaSH/pFVEZHv7RjY32EKdSqW?=
 =?us-ascii?Q?jAXHKXV7Vups/YW6js1RbrW+f+Kf5bV92YKQYYb0TjfITwM5toFh5TlBlaQa?=
 =?us-ascii?Q?X9a6kd4iQXk0Qov6nvF0qUa4VQtcMPd4rJtDs5qh4AOAGIM9OybpN7+DwGy9?=
 =?us-ascii?Q?cxE37PG5OewKZj3AQAXCBlTqLq8NPb5A7s8nGlFBqSt/e3wq2EaVI5JktgCR?=
 =?us-ascii?Q?eKk+1s6Morp+sbkXu1+tGWrJ4Bck91aZS1JgEpncrv0zVKR3wQXk0VOMe5KB?=
 =?us-ascii?Q?IWXicbY3TVkIVL89e7dmzFeNnN7upWE9Ps1zCTlm9MPUhZ8FefxAR8qDGkRF?=
 =?us-ascii?Q?onUTV9BZnvMzjYcRa2sTtAbA1PJj6tIS5vbjiedL3U/Xwc79Pxtr1WuF87xp?=
 =?us-ascii?Q?+2ebtTaw+yiebOqtZuXcVUpgR+2R6U/iE3wS90G5Gz4K5Vjz4vSIBQOEi4xG?=
 =?us-ascii?Q?snPBc80TWH8ukVNSmF6r0l3I/FmylNNvogdx/K5lTzbUP4lWxexxTYblUVQJ?=
 =?us-ascii?Q?utEdG0G9MdG48wtTEPBknPaLivhz2L1AbovgUQPZgpzVQlLwQyZJjqyzo7zZ?=
 =?us-ascii?Q?59F9VXwKHlHRtpBpRZ7qvjCxEFOWI8cN1R2NOdHPlfgCVRSDCqvyMvJZK+ay?=
 =?us-ascii?Q?siN7/VZ2YS/p9QQKCbMCMJi6tVqcntf+oZudTr4I8XpILm0bQIhLgOcvg5dW?=
 =?us-ascii?Q?Cs4PDd6NY0JBD4XDu5X9iik8kxBsb5fWEv8PKJWuFsF2osP50Q49lkFm17nw?=
 =?us-ascii?Q?z/3OKBaGzxJhkxSA5fnO6K9/co46ykTMiATY/+TG+kMUInc+JYRZMSZE5u8c?=
 =?us-ascii?Q?pk5XsFdb60TufhOotz1/If+5lWYHdGrCbiJ7JplVIMAQZSLsv9KJF3jlwd9z?=
 =?us-ascii?Q?A7a/huapG3O70qDfDusZiWOo66dACDOoc3qMicqmcHQrPRjwCaBxwLbDR3vY?=
 =?us-ascii?Q?0ILjSPeQVqYKq7YT6o+EpKg/PwRnMNSzlEtJ0u2rDCvz4z3POFI4TrxLlPGM?=
 =?us-ascii?Q?AsdTGPH+UsMRuvcKamoPRgb2UKE3a67OJhvI+5NOQ5McBtQXeU88cDknArLB?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd069885-94eb-44da-211f-08dd8c8e1fe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:07:00.6730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95w2NIjEMPIRC9K6UMyytssloZL1NWgm92cBTJ5XD+5k0SCbs1/xPrStFdQm/V5FUw0I3EqIplzp86r0/uE85UOHgHEMplS8/hMN+KADARg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6079
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

On Fri, Apr 18, 2025 at 10:42:22AM +0000, Xu, HailinX wrote:
> > -----Original Message-----
> > From: Yuan Wang <yuanx.wang@intel.com>
> > Sent: Friday, April 18, 2025 3:43 PM
> > To: Burakov, Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; dev@dpdk.org
> > Cc: Wang, YuanX <yuanx.wang@intel.com>; stable@dpdk.org
> > Subject: [PATCH] net/ixgbe: fix port mask default value in flow director
> > 
> > The fdir filter should mask L4 protocol in order to process raw IP packets.
> > However, the initial value of port mask is 0xFF and the filter will not process
> > raw IP packets if the flow rule does not change it.
> > 
> > Fixed by setting the default value to 0.
> > 
> > Fixes: 444505f933f1 (net/ixgbe: fix IPv6 mask in flow director)
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> > ---
> Tested-by: Xu, HailinX <hailinx.xu@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
