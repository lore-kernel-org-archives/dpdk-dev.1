Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84237D3ABEF
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 08:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658C340280;
	Mon,  8 Dec 2025 09:58:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id DB9054003C
 for <dev@dpdk.org>; Mon,  8 Dec 2025 09:58:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765184313; x=1796720313;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TXvKcA3Tschd7u95NXwSzkhSWjdkzJPvTumqdNapb3E=;
 b=TJFeRLcu15YhoAo5yE8FkJPKBHVulTQTN4uPu8wM9N5Q1C1bWhmzONAX
 6R3OLqVHGXdpcjE3miEPR/MUC5Z9JHrSupx09cB8eBs31bkWL9xt29oo7
 y98zyZSZLt8o3uzEisXK7kYscDAWnjEFMOvrD7L3NoZDGwj2awCRT6gRK
 A9ZmqqKii6U8u//9N70FgcvWvM35HhFXeLqQkFUVc4HdgtuTAE7clI6Y6
 acC+B1k47wc4gMcR9VBAOzRehnSLecfckooisuojk7sYMpLRr/bNJCIGS
 5pgEbrT86E233a1ZkxR68P8fd8Ta9oEcQipYb6q4rXxBGecOsk7FoYEMY Q==;
X-CSE-ConnectionGUID: vLp5mrRIQlOGFk71yJf0XA==
X-CSE-MsgGUID: chTMCQa5Sv6VBdJ/DHELTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67201514"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67201514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 00:58:32 -0800
X-CSE-ConnectionGUID: gmqei1I8RC6U7uNtE/dIQg==
X-CSE-MsgGUID: G2eoIRyESmmoSeNP8fDNtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195904565"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 00:58:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 00:58:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 00:58:30 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 00:58:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjYm1PjougKEKK8bhRcqTocOxOi13oeTO5nQPsqlm4HfsjBGtO3z66QMK1JM8j4Bxvwq9Woq4yMPdFP6O3tI2vlxjkiH1RvFf+8q8mzuZa7L5g8Wg27zPxON1pEfBpJPEjWEsDhpnkDy9UKz1YgSpJkgEnZoKw8ri3FAVQjlcduBTODJZrnP2h4zSYAk+x3GeX+VSDcmCshiVsVlU8myIskSvzk7UODRg/Gn+dMUvIc6NN5jV2JSG7ogkpnvLs93mBA3Rj0o55r4Nw28UaGyUbCUprImmcwVgNzlgrKHFzSwqtCAv1TGh0Ep4Mj+w6KfmmHvYqBK7LAFDhWcBEpZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtyFnjmtOsiWKpzd0wN8f4Ce3z4L3+XpeSoe6Z8AF5w=;
 b=Obm8pjkzvqMeRYqNjpb7PXWdNiCLSmBoakJwrcehj5kUWIOfB4Wdg98AwQqHZVxCvqqn35XoOhO1F/QiMV0X9n483vn2s1fZWgiA85FyVeJ5tu1csvkbFzavTzcSUjj7AK52XRf8kXkp18LdNlGpO8k9F7SssxMeS7+9vvjsVHu0C57iWsJum6eliyVUI9qictc9TiAJsl+d+OjjqfvCVdjLF/Ajlp9aNWdWIkiqIpl5YzQ+lAIxvkxxk2CNjm2wEMbz0WLNnqWW9ihZBx64RYGn93EsuxZt0I8zkSf8AVtia7NkhxWS8SJ3OA8xCBShW6EhmYW48uMD7glEYRmIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:58:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:58:27 +0000
Date: Mon, 8 Dec 2025 08:58:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 10/16] eal: limit maximum runtime directory and socket
 paths
Message-ID: <aTaTLpg2PL2khlVO@bricha3-mobl1.ger.corp.intel.com>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
 <20251205201537.251131-11-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205201537.251131-11-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a165ce7-04d8-491d-fa75-08de3637f3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hFXwDHwkUVLJNx1wtzvBwwy1MNVAVNAkjjSrF8jXqy0FJ/TCq+lhz9yjs61J?=
 =?us-ascii?Q?8A0lp0BRRNKOczcj2jDrsQuFRx7DAsVYG2HufJFXEUG7JeUE+ocsOtkGfooT?=
 =?us-ascii?Q?hL6VHHgJm2IVF8hJ+zdBMgTre9UztYMIEx+ebFJ6PLm4MisNNezL62qg6+6N?=
 =?us-ascii?Q?8E1ejJWMMZuFuGxk2yL0O2Lus9ARFbp8dX6VEwLQOzdUKxWFzZK8xKHIPkhI?=
 =?us-ascii?Q?pirPWrjsHaD8HtqfNUqfYKGutYjVfZtr/wj+HjF2KMD85fL6J3V++jYxFgCB?=
 =?us-ascii?Q?4IkhbWs8YCgdTv95lnP80Vjwu47odsM8CZBxVwIa6cP6GJWMcG2OUSPgq4BU?=
 =?us-ascii?Q?Y+ZMIbpoVUu3/T12lGbCxOwq1G5AwOzmrzSOfwxujXUiaW+r4nPk1n6zzwE4?=
 =?us-ascii?Q?1Vlw802e7Y7D3d+hgCuToPzt2XdaqkFZhV3cTEhXTcPmM2BWyc+lExXeo2V0?=
 =?us-ascii?Q?oF1pVal5bNcfc/JuC4mngMkIBEHwPcUIzsWB66BuYP/RlJICd1cnGzENgjYm?=
 =?us-ascii?Q?6boUrZnH2OM9D0O8HogOuPRWXgIUBd3wphjgYTusmbLZO4KzXdNUjiJTddyT?=
 =?us-ascii?Q?4B+/DAfJm0WmxOj1N1ZpCx0lDEDouhRZHKWfIxhufNIjzNv3MzDl8uvbmB6D?=
 =?us-ascii?Q?E2D1hL1RNrZE1Sx+uMx+bCO7GN/g1O7slF+k0xHLxBcjgasEnBQCa+Qhc26A?=
 =?us-ascii?Q?DbUj/hbjrxgT21oXlS3hqlfhQu5PRh2ft9VdYdoL0yBrHQ6HdrjBojxyDgnA?=
 =?us-ascii?Q?Yvp4/o+AjHmdN8o4Dt2WE7sDgaDpzn0Eh3fK0MduQ0IAXJGzuJXFgEKL+v95?=
 =?us-ascii?Q?j+yfEthuofFOq3YQFMkG9TLwZT7ZDe5wkrUPhjojT5fQ5pHnlxuMeXnUanDJ?=
 =?us-ascii?Q?pBUyoC06wDTnxUTXkDRijh4O3OoFL11wrbny31Dca4vhmJRRKjJM6NwveCFm?=
 =?us-ascii?Q?b9mvqTY7hXGsQ8ljaIrrW+UNDc7D6M3etbwtxAEAshG/2qazayDH7/8F2tz9?=
 =?us-ascii?Q?8HWWJr1vpXzlcVOnYPuTd4JmnW197m1mUG1/vDpgaTO/QqIHECYkuDRCIz7D?=
 =?us-ascii?Q?AS1959BggIGdJ4Gu17jqyJf8T+VdcIb+ZfBBRAasdy36E9dEugeFkJHfWrCz?=
 =?us-ascii?Q?cuWqsNgGgcV4rzA/i0SCQAb7P4aFa4XgNgyZTHWQg4O1SHqQ/WwN846WycEx?=
 =?us-ascii?Q?MMiypLMRBb4gUrmBqE8MSdUj1CCICC/Pkr4zmvsDyhNkjlfHjcngmAp47Jl9?=
 =?us-ascii?Q?OVvvRPPey50OSBOgypvfyzZJmpacV2xDEdtoMLEJavX04a2mAxVvlj1/qBKJ?=
 =?us-ascii?Q?LyndmWjiZxAF38q3mDz7lE2db8Eo6JEC5sq0f8y+amG7mKovk21zAer3KdF+?=
 =?us-ascii?Q?dUOd5QPLeerurspi1HGCtd4CCj7OAemACKQfdUwhwN9xmiPP2eZ2Nk+trhB8?=
 =?us-ascii?Q?4BNgKZvNSFifh7RV7RKWf5FnfXPxGoEI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGlnYKDzLwmna32CQbjMUIN6dno2bi69m9mw8Smp7ahvggzynMAzuVCodsZU?=
 =?us-ascii?Q?a2ogET9+71o+wvhjhLElyh+y8kKyuAdDiD26xH5D7taA0MauhSypgB97Io/Z?=
 =?us-ascii?Q?l6FQHrwJwqx12gPAIJDVzCbDVv2avXGYAoAYF23Z4mF/M+0FDAeHP3vMpc1G?=
 =?us-ascii?Q?rVK4D/dATh+B1GkwY5vGgaeQRuEqsDYDuNAW7viOelsCULO9JxQO7eP3knKk?=
 =?us-ascii?Q?j9grYL1D2SKzsCnQQhR8V7xobVAatS03gph7MMFnFneDHvYIMUFB17r98G0Q?=
 =?us-ascii?Q?JwQD/tGo+wPCI9eOqLVB6FqsBjIPYWovnubwH58NxOjoFz8rTanjkrn3wDnp?=
 =?us-ascii?Q?c8hEszMWWa31WodBOod4Cuvl3VjsxobJBtguXapGHoQYW7YNo4dZitH9/i87?=
 =?us-ascii?Q?ed2mpz8etFkW+FxkRFaGmdJWGo90alMyZtbgi/3A9o5CJ2dBZK4d6lI0jN7i?=
 =?us-ascii?Q?HL50oswKCBz1b2yopnigYXvH0V3rpviv6EG0Ln0VgOldUfY8MSNtF/rjG+ba?=
 =?us-ascii?Q?dPfD0XBrSfyYLO9pAvzyk4o5zT2HzU6Ie2PFhR/P84gsu35G44Mgirpm11hz?=
 =?us-ascii?Q?sWRXuqy29/SDlD5+2sD9IyFo43nnFglyUwNL25n+9dYTB6iVqC/0OEpKb9Ni?=
 =?us-ascii?Q?1Mpy7u9J2iZMSFyC6hxWSZxYpITBBQP3dpYioulun6N60yL9bExsC5pbGRAd?=
 =?us-ascii?Q?maXhv8ipecClMu+WA3JIYJ3ByYYOFFQbJIvutruQOwJW6yaiYDdtjTpfpure?=
 =?us-ascii?Q?RImkDrHOP7tKMMRfw0gwcFlvj0eoz7jtym6lg4nMi2+jjyMaHI76rnrHe3Mg?=
 =?us-ascii?Q?4ZPOHkixf9slzaGikE1mSJGdqfVw6kZtUl8hiyAvkQVS2YCFMWKC8SmEByXB?=
 =?us-ascii?Q?/BKJxgTZ/OkSiN8PraFPQEeL77Ay7Q5S2/Vw4auqKSR1nBDeXRQ3Ue9cmqZ3?=
 =?us-ascii?Q?LJ3WP67nqvHRv5Dps+gsflgjLAFxZaWfU8XuBJ/L2P1bgikJBE4KeoatoHef?=
 =?us-ascii?Q?7qPYWea1Abo/jQKe4rmwi5UfAaH0Qb5PQQ9nP7x1TB8A3CI6QoOxrQhrqbVk?=
 =?us-ascii?Q?9dDo2OUNSKhnHs4gPbzeQnoYDgax2YennOzrT7SU5YpRwCcB8czyEMyB0Qax?=
 =?us-ascii?Q?MFRPtMsUmLqj+oemZAmyBUK8cutmZqb3vuhU3pRtifvQUe+2MMkdO6UAuzWe?=
 =?us-ascii?Q?2rqP+izUbT6jXvqhmVFgXFOrWpn4VDjlvUSiVaIdwibLwgRmUVUARD6A7wnO?=
 =?us-ascii?Q?SCuFAMptXm9G/4KpnLTI+eJEL+MLLK7HNf8aGmISRC1fXjpTVeUYucfY6yF3?=
 =?us-ascii?Q?RF0eTHL43KQm3Ip2KRl1NwECC5ucIUEIo2rqj8TlaugRJJUKmc+1l1XNqnAI?=
 =?us-ascii?Q?lTL9veAJrMehESmNNgCbRerm6j/ZPvlApoYeIdiOv7VZY7M26u9WV0TKcr9+?=
 =?us-ascii?Q?JqmB1uHjFNY+W7b4NGFmEp0MoPcFTnwqEmn9qUsDhZy2MzFi+cAFloFUSsVO?=
 =?us-ascii?Q?MVkDSY6fSGmS0WgeLXqkHURkLsJEq36bNqWBh4aHyroDJktwQcKAbUPLkhsV?=
 =?us-ascii?Q?ukpEgqhnVxcB7jDhVuDQV1SpQZUhuDMbVyahUyiHuXC8bd6xbzWcm8aeFHiq?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a165ce7-04d8-491d-fa75-08de3637f3d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:58:27.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/Hi0S5mBi7ejMlIyN5BJbbuPUMjf3Hn7x2O6v2Wks+fot1opZcn53PiMOfzrRVzJyWdQIlMyzYcMm6uEPUdxzlb5KFQDRvsqQkhqqZS43k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
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

On Fri, Dec 05, 2025 at 12:11:39PM -0800, Stephen Hemminger wrote:
> Linux (and FreeBSD) has a limitation of 108 characters for

108 characters -> "just over 100 characters"

make it generic to cover both linux and bsd

> any unix domain socket path. Therefore DPDK would not work
> if a really large runtime directory was used.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

