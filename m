Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31981CD3429
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 17:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67F0740DF5;
	Wed, 12 Nov 2025 18:04:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 97C0940687
 for <dev@dpdk.org>; Wed, 12 Nov 2025 18:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762967071; x=1794503071;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eLbq+sTdvWeYacUBpo2tKwSVcgDsIO2TGISvP/0ekiU=;
 b=DyEMEYRwIpZxudyl6wvpFEKY9ElI0xHPBOqsIF6Cag3DE+kN1FwpCLWd
 VYm2VQvcyJYAh7XkmkolBW695w4sw0SyVjpX7ZXeJ+xKpMbdkpL6Ww3ir
 TMWpNMVUkBa6weB9c571RXgmZpZfGTE/NgHSoJJUtayzoaDT1FppXvzsr
 JzUfWvb9OfyT+v0NYEnvnjbd4YMopxagaCh7adaorwTXLWjzdIY7K0s+b
 86/G8DorWgU7Dy84Ve200qCOf24rLDTyGmqxLDgrL7CzE7yqSFYXBbjI/
 rAvT97uQfz/Itq+ELXiLtJx3mgK5iObDg4Vi5Jh+TW57XdYjyWRDdSddJ Q==;
X-CSE-ConnectionGUID: dCxSwPW5QWeKsEi6STNzOQ==
X-CSE-MsgGUID: Lg2jp3QQRlmbYtcwFG5K/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64741766"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64741766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 09:04:30 -0800
X-CSE-ConnectionGUID: RkQL5d9YQri5qHkd1Lg1/g==
X-CSE-MsgGUID: OTOwZI4DS5WnObw8e4jtIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226546310"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 09:04:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 09:04:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 09:04:30 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 09:04:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWusnS95RBQXnADLtv9rIbemZIDSSGlW2LQWxY4A//+grQhr7wLfuDxkLdw2/5hEbndGOo03jLQC1OcLYHOnhpBMNylNNLY4xmzC8N7+f0GJF8J9SNIcALqjtSsAPd+x0O79rI/AwWTmJNA6C5GyMC22c0ZCIjAR1YMwUbPfbqZA3hCcFBwosQ2KAK4kOZTxCCg18p3iBYc/bkOFw3eEHGj6nsdQePL3NbM3tN20xuX1tjAGl0WM2ERdlMMSq8TIR9Rgf6fZBT+8ktLJoVZEAp3v7cnMeQ3z10sHysvouYiIEyD0Ebv8CasBEKFPGuHhIRLjMYBf092rXB455bqhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSDOd9gDjxt7Zp/4SmnqfFXRG+FN+b2Bcy7f45FWm08=;
 b=DOFvvBxB36vFKO3G2uQCAKHKle+hSgud3Jdnz1Z/xVf0TAU+0fD7zjpuMDhToDxSGYY94jJ+6ACfjU8nMAnSn67W7+9QFhEPbe/0ZgIdnr1p7GTwXNeZJnwAGdyUOnFAdADBI8C46TvZP9fb0cLX6XrEfggcmeOV28mmjltM+SeLCanpc3rWaTustHpMWyRM4pK9AkLq5AmXYhdoGJngYD37TtRWvO7JJhrQqtTtqG9JDFwP29UM/OFMkpnb0Z15kYlAynsbOnjAbUl0kVwNbM+H5oQ93lpQD/p28ppUpu3WL9PAUF0qWGvGQFmPxR4sYf92gtphEOhIaiVvKGEtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 17:04:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 17:04:27 +0000
Date: Wed, 12 Nov 2025 17:04:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/1] doc/ice: document protocol agnostic filtering
Message-ID: <aRS-Fk088_bRM3gB@bricha3-mobl1.ger.corp.intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
 <5d6aa3eed2827e1f7c8e07c1e344e232f010f0e4.1762947241.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5d6aa3eed2827e1f7c8e07c1e344e232f010f0e4.1762947241.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR06CA0065.eurprd06.prod.outlook.com
 (2603:10a6:10:120::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 246308bf-40ee-4700-97cf-08de220d895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bG7DKKPCcCUxfb9mKxM4s8KcUZ19IwSRXFF59Q0F9RHDvnN3TysFbAKIzHs1?=
 =?us-ascii?Q?YXwR8VNq8x+JyTaV5VGh1R5L8obJLbpN2EGYYaT81GD5/eH2ZHJ/x6+TWAZx?=
 =?us-ascii?Q?8CtqhdBC9EzRG4xd1nv0UJ1Gm/VK+ZAQ/1RKVjef8WhM5UwyHQ8oVZrOZLuH?=
 =?us-ascii?Q?WlMmm+hUf4792LVWT38sWpQeBFRmn5aGv3S5HRMwhbDxWJbmAvBnE7zhZUcp?=
 =?us-ascii?Q?3FvN+dfHuvALvHQ8rLr/57ezJp571AdWPoDV5TIigePrm03ZPQT3ZzVDIWUm?=
 =?us-ascii?Q?YV4vYuPVkcw/8Rh8/r2hMjU25Ock75ZUElm+lWT1966ZXg2nM1g8X+gnQtbo?=
 =?us-ascii?Q?KFW2dyHxvyE7bfi/ApJag939qicWYhIHcivrJo1q+9aF2xFvNFqfvhRx6izp?=
 =?us-ascii?Q?xjLs+fJbZO/NlwRsRgTjRHyIcIGHi9w+HBVHtNBN3OFGlsh3r+1hdPxa5oad?=
 =?us-ascii?Q?DCuGZgxUkaJrQ7DpvSTtNs9mqZWZc1pSLlwpcF/gCWej3EHApoU+8A53CFPx?=
 =?us-ascii?Q?pp2o5IagWedaqt9qWp2cv8g5o/sx0IgLA+jG2lU3fY/tdr5L6Ic2WAQqNgak?=
 =?us-ascii?Q?xbN5adMAK6HDydER+4mKDZvYmv3WJmxuj0ChuO+IFmygnobz5nJC0oqpHl3Q?=
 =?us-ascii?Q?Uh6S5YOeOstzdHLnlAwZoz4/l7TTQ6qKnnfrOxQM+Hjo9piYomdKZ9gvzR/1?=
 =?us-ascii?Q?PWf+6ts47//bOkU1nXtLCOOHiZpH5ZTO2fAUu37vSg6bc9lscmuLeFOBwQZd?=
 =?us-ascii?Q?8i1M+WXvViohrKsI8ljyHZPbQ27vGvUeSU+xOKXC24hSDHtUupuM4H6ftpjI?=
 =?us-ascii?Q?GXrJ/hC0F54a+SQZSHbXvW6mI7uEjsee4ualKdU/qsXV6OuUJX/bsg85k5TV?=
 =?us-ascii?Q?1N8MJcyjFFbVT1hAxIu9znV7r8dvhAVRwYBhRZUg9qYqrHiSvtypSwEbwFSn?=
 =?us-ascii?Q?+U49aRKjSyBBgTBwYznFMM71OY6DjF5/IqbpaESxM5hq2ElMlKUvFz240C7e?=
 =?us-ascii?Q?J5nGWchDW7i37gYwdxOkiLWPPdSasvbzNTEDXhnXYbxV3L2DvDj3SkP79Dye?=
 =?us-ascii?Q?wHI5sBCCn1+umE8qV4Ib6JhHAPpNJ3n6WAvAyYfLQbP6zqIF7vFtHi0bkTq6?=
 =?us-ascii?Q?1QZ+sUVq0jMwbXFOeJFWgUKowy5W8VyuQf5p7BGk1aeFz5e42UYHypLGhvbS?=
 =?us-ascii?Q?OTgLafU0OxfwDBQXhtCfmHO4/l2nxlbUkzmBd6d2fcV4LHt2eYAziYxZfwmP?=
 =?us-ascii?Q?uZqdh0fRkj7AbHZmgLgHXfHKbQ0bG0Kl9pgdTDiqHsGKLy/7GqR9Uih6ZIgz?=
 =?us-ascii?Q?NHvaH1fjFue9SO7MZxwk88gymMIdrW+wCBAbjEQD5oyLqv/La0stZHOJjJrE?=
 =?us-ascii?Q?fQ8HbFeLDO2oiRPi5/R9EqNhVX68UPK8JVxapDsN2Ds/QCKqZwHfHAU+BLGO?=
 =?us-ascii?Q?dSDcCe/N30QLQCp2XEB3XAJyEO9WgypvfyMv81DnbFoV85hCD9O3lw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCxGjtkftCS9j8Mq4/DbxPPzMatIUcTTzukHBwHz7N+R2WxE+u8uWa1woT9W?=
 =?us-ascii?Q?hYzVBY7f4R69uKyogOjvgvdWeYeIPar+DVi2DZrsYEQ7H0Qq4DFrESqBtOLG?=
 =?us-ascii?Q?GdHdyouONlpKe92E9P08jy7CPXCiPC9J0gtAYrolIHccO3otFnv5YghyWDMv?=
 =?us-ascii?Q?5x4EURoRUbQfym/XArEcMFpa/p9BumDCzEXIbTcxXaLM2nnEVHI9JpvaaZ6s?=
 =?us-ascii?Q?CAWGDA7xpLee910KOk/hCbH2h+0a+vsfWM7t9uBBOEaEyH16WH84/QTKc8LU?=
 =?us-ascii?Q?Ob8JK+FTHd786yFQR20w87HnSDLXwqrLcOoKMyxakl1n2TnKrctU1JwtS+lR?=
 =?us-ascii?Q?Q2795ZpgOdO0IkG1IpLu0nESmpW3BF8HSaWQ7fJwBf7JxO8hNHJq+YPuMdwC?=
 =?us-ascii?Q?H4FlsorubX/jacfPGsWjjGMzhZT5MLhLlARPGp27nrSP+9WkxuHZm3fkCVVa?=
 =?us-ascii?Q?zFZkOeZEAPW76kePfs1OumpmXu0fHKC0Bi791CG06kFYkrj8zIE6QBFyQJrF?=
 =?us-ascii?Q?zIOrMI/eD8VY/pA4jscxHc4t1E0tz9263JI5VgbV3qsvKoyxo/9w3ybGPDcj?=
 =?us-ascii?Q?yczBzQCEhhR4YeokRXyUm7Xo53K5vA1c2GDOcIa6lmMNGI95cfi8ZtZYbS6j?=
 =?us-ascii?Q?T4ER1TKSqsCqLcwhQauW0CkhkCQLuqRqlp8H7a2GiZym2w1xHsalN8TzUyBB?=
 =?us-ascii?Q?g1C78dGTKVNILAddVmWT+tFjJynvbI1sKYhT9+9ML8Nsb3LeioXgsrdkzRvy?=
 =?us-ascii?Q?WjBltFhGX7oYWzU6FWGTn7Pnp+VbtWvfHOU0dTA+Atyd47GlY0b974NKA31N?=
 =?us-ascii?Q?QbbBKcKvWcTsAxcwB8g+j23/bj4wyFdXtijVec0x705CeFf1HRflkCFnVs6q?=
 =?us-ascii?Q?+V4COaf2dLCkdTlibgRrMuX5W78dbr/TdyevZiD7ZJ5ucCIUPziJiEwOkOTs?=
 =?us-ascii?Q?NdSv7nPyfWoSJife1l4djmyEk4R76Oe7LguftzYWS8xf0uGXvijs7vsPkwj4?=
 =?us-ascii?Q?fYI6PJiRQwiK/fetLIKY3vD5lR6IOqaNWprsdjCZwS4hz1CqEy6kPknfSlcr?=
 =?us-ascii?Q?HA9zWOnJ6yeMmnTbiGAVhszhbBGPOO7dXSdJI3LuIGonI9iDXRZGQFjHiSZI?=
 =?us-ascii?Q?p1e1CKb8ca1ulEchi9HBHeGkMUsnRaO4QF7bdZCfY7F6SMQpBMK8jTt3r9rE?=
 =?us-ascii?Q?pq9yGavYQhX7CL+A4SYFxzTymQGEAxLTi6eirxVQxA+0pi2mX8Jvl2W87xAm?=
 =?us-ascii?Q?UQXpQrWfVk5yGZs014la4Ua6DadvKueuOomUoYtET5BFQbaOkHjMMiW1sQ63?=
 =?us-ascii?Q?5c23dD0UhkUDivGwGpXSp8rgYkW+Sx62J2FSacOVw4OwlaTkxIftkMIHj/u4?=
 =?us-ascii?Q?KWjMlXYOOB8t8Fqe+BMgtPr7McFM2EsmKpjQ2XqcyTu2gzC6uXK61segvTcg?=
 =?us-ascii?Q?4bYkz9J9m4RAG/2pIYd1EpxGxcPuanERyzHBmUgEB+R08LCi7dnpY9p1rAN4?=
 =?us-ascii?Q?helgWAvcvzMOKb5EVtJ9XN7UigEbgLo6evbDYoWjd2Mo36cC76VHLmSzukSC?=
 =?us-ascii?Q?iCM4YsmAKjwB3a7Vu998VEcBKC1fmvBRKDw8NrY4B81fl5L/7qrXGGYzU/ou?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 246308bf-40ee-4700-97cf-08de220d895b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:04:26.9068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY+YNc6L8ybtgORNMDCb3zA98oY5/aX+JgiYJXbmi1psLOeMLNF4rgZwdGv1vKQ/KM32tHXAdMCe3tTfhFKnYuWV3KMLsgBws096F27PkL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
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

On Wed, Nov 12, 2025 at 11:34:12AM +0000, Anatoly Burakov wrote:
> Current documentation for protocol agnostic filtering for ICE driver is a
> bit terse and relies on a lot of assumed knowledge. Document the feature
> better and make all of the assumptions explicit.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
> 
> Notes:
>     v2:
>     - Reformat lines to have complete sentences per line
>     - Added C implementation for testpmd examples
>     - Added link to packetforge script
> 
>  doc/guides/nics/ice.rst | 222 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 211 insertions(+), 11 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 6cc27cefa7..ffa11cf066 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -624,20 +624,220 @@ For each engine, a list of supported patterns is maintained in a global array
>  named ``ice_<engine>_supported_pattern``. The Ice PMD will reject any rule with
>  a pattern that is not included in the supported list.
>  
> -One notable feature is the ice PMD's ability to leverage the Raw pattern,
> -enabling protocol-agnostic flow offloading. Here is an example of creating
> -a rule that matches an IPv4 destination address of 1.2.3.4 and redirects it to
> -queue 3 using a raw pattern::
> -
> -  flow create 0 ingress group 2 pattern raw \
> -  pattern spec \
> -  00000000000000000000000008004500001400004000401000000000000001020304 \
> -  pattern mask \
> -  000000000000000000000000000000000000000000000000000000000000ffffffff \
> -  end actions queue index 3 / mark id 3 / end
> +Protocol Agnostic Filtering
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +One notable feature is the ice PMD's ability to leverage the Raw pattern, enabling protocol-agnostic flow offloading.
> +This feature allows users to create flow rules for any protocol recognized by the hardware parser, by manually specifying the raw packet structure.
> +Therefore, flow offloading can be used even in cases where desired protocol isn't explicitly supported by RTE_FLOW interface.
> +
> +Raw Pattern Components
> +++++++++++++++++++++++
> +
> +Raw patterns consist of two key components:
> +
> +**Pattern Spec**
> +  An ASCII hexadecimal string representing the complete packet structure that defines the packet type and protocol layout.
> +  The hardware parser analyzes this structure to determine the packet type (PTYPE) and identify protocol headers and their offsets.
> +  This specification must represent a valid packet structure that the hardware can parse and classify.
> +  If the hardware parser does not support a particular protocol stack, it may not correctly identify the packet type.
> +
> +**Pattern Mask**
> +  An ASCII hexadecimal string of the same length as the spec that determines which specific fields within the packet will be extracted and used for matching.
> +  The mask control field extraction without affecting the packet type identification.
> +
> +.. note::
> +   Raw pattern must be the only flow item in the flow item list.
> +
> +Generating Raw Pattern Values
> ++++++++++++++++++++++++++++++
> +
> +To create raw patterns, follow these steps:
> +
> +1. **Verify parser support**: Confirm that the hardware parser supports the protocol combination needed for the intended flow rule.
> +   This can be checked against the documentation for the DDP package currently in use.
> +
> +2. **Build the packet template**: Create a complete, valid packet header with all necessary sections (Ethernet, IP, UDP/TCP, etc.) using the exact field values that need to be matched.
> +
> +3. **Convert to hexadecimal**: Transform the entire header into a continuous ASCII hexadecimal string, with each byte represented as two hex characters.
> +
> +4. **Create the extraction mask**: Generate a mask of the same length as the spec, where set bits would indicate the fields used for extraction/matching.
> +
> +VPP project's `flow_parse.py` script can be used to generate packet templates and masks for raw patterns.
> +This tool takes a human-readable flow description and outputs the corresponding ASCII hexadecimal spec and mask.
> +This script can be found under ``extras/packetforge`` in `VPP project <https://github.com/FDio/vpp/blob/master/extras/packetforge/flow_parse.py>`_.
> +
> +Example usage:
> +
> +.. code-block:: console
> +
> +   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
> +
> +Output:
> +
> +   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
> +   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
> +

This looks like it should have a code-block tag on it too. Was that a
deliberate omission? If it should be there, I'll add it on apply.

> +.. note::
> +   Ensure the spec represents complete protocol headers, as the hardware parser processes fields at 16-bit boundaries.
> +   Incomplete or truncated headers may result in unpredictable field extraction behavior.
> +
> +Action Support and Usage
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +After constructing the raw pattern spec and mask, they can be used in the flow API with pattern type "raw".
> +
> +The following is an example of a minimal Ethernet + IPv4 header template.
> +Source and destination IPv4 addresses are part of the match key; all other fields are ignored.
> +
> +Spec (packet template):
> +  000000000001              Destination MAC (6 bytes)
> +  000000000002              Source MAC (6 bytes)
> +  0800                      EtherType = IPv4
> +  4500001c0000000000110000  IPv4 header, protocol = UDP
> +  01010101                  Source IP = 1.1.1.1
> +  02020202                  Destination IP = 2.2.2.2
> +  0000000000080000          UDP header
> +

The format of the output in the HTML here is not as above. Again, should
this have a code-block tag on it?

> +Mask:
> +  000000000000              Destination MAC (ignored)
> +  000000000000              Source MAC (ignored)
> +  0000                      EtherType (ignored)
> +  000000000000000000000000  IPv4/UDP header (ignored)
> +  ffffffff                  Source IP (match all 32 bits)
> +  ffffffff                  Destination IP (match all 32 bits)
> +  0000000000000000          UDP header (ignored)
> +
<snip>
