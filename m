Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F7F106B50E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E4F7402CE;
	Wed, 25 Mar 2026 13:31:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id D78774028E;
 Wed, 25 Mar 2026 13:31:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774441909; x=1805977909;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NlYoR+EYGBONd+0yw7WImOCYmgt9GVfq6KhHO3dbtIk=;
 b=jfAmOSo4PugCPnzZL29u54cWphADj9KWomth3eq0yQt5trU9UrnWQzXX
 EqNSNBK1Qdb948O3err5LlrjveuHkBaHtmBrQ58BKgqLC9jrCve2f9J8n
 wY74bNcqFyM125+4mbA+FT6X36cTez1cY9dSPXMhK0Woo1b13D5Bb4JF5
 MFPRJb7RyxsE/RQpURfNiJmDdG4o5dIS0ayHhuMmUSI6SqWeHqDSUDxVf
 LxVbDusWej8wQImX0fywg22RDjg5ujWS5hue/CDKHk38r6ZQTGI+KFYCV
 5GoW746HHfWtZteOlF8HDVbs2FOLNUF3zFjk/w5GRl4tYTneGAJ+5dmZu g==;
X-CSE-ConnectionGUID: uUsrlWmjSHyUm3r7UfKvEA==
X-CSE-MsgGUID: CGGQlkixR8ymeluQimbpnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93053240"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="93053240"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:31:48 -0700
X-CSE-ConnectionGUID: uk5R/jxkTiWP8DbtMm60CQ==
X-CSE-MsgGUID: XpN5juz2TcmIsyitSFnjxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="224930289"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:31:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:31:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 05:31:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8eF1f7n3AVT2xf1GBb+sY8G+KpJzqb7ZeQ9EadLJZnhYZoKyjhqYK+M35GWCBdFJ96sJFoNOH7VwfWltKiwNnsA26O8fFIwcW1oP2du2CYhR1vRkdFCFrf9KQSB9DpqEz5PPHO6pIC/3u2LipihmDWPDwOGl0rZ/3dNE6kanqHj/kLA2SJdJ8CPbh1Fk5u/gihdACRiwvhGlw9YUyE/6x75NSSp0rGlGJVy045xM87JjgWUNE3MY6NFC42c+NPWaKhpNyuuSd/9S4G1MO2Q7WdXy/KgJgvXjkgcAEAH1+DSxAM2RhxYr/yqYjQOZ69f4nqCKi/5l6AHdV8lH+89PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejrtGn1jmRjsofupkRlkVfPBFYVDVwK1TIZObdbggNg=;
 b=TmPJBr7j3c30M//AEkIa2y531qSAhNUr8Pb3Cssi82oPrrN59OZA6zhw3KWuOUnBWA6Xgt1FYEBzl489Iwcj6+R0RYj7X31WGQAl2jl/dm6dDpouuXZTTwvX27QhaPXBr80HcCZ7UHhc+afdPURa7tgxAOm2tQAVf4jHTBdAhW7o4m1+3ihEPraRnAVdFZ+hFSyvk/BFEh6lDYC17I11dPv3zjggqhy4iFeWTOrJIA4gQBZCjjVv2k6UF/6UHgQnH8l+9l6O6sCaN3H8UsjFKpUZA2p8KM+tcSupn/96ExbQaqWf5iUkZZfSmiG6qdTlG+rij7XFs3eAFkKzCgoe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:31:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 12:31:44 +0000
Date: Wed, 25 Mar 2026 12:31:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix raw flow item validation
Message-ID: <acPVql8_iEhVgP4M@bricha3-mobl1.ger.corp.intel.com>
References: <20260324155627.1849904-1-ciara.loftus@intel.com>
 <acK5uJTAJQRgcxIO@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A1C342BE2897987EF10AC38E49A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1C342BE2897987EF10AC38E49A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 01723647-8ce2-4c6f-a1b4-08de8a6a7934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LxM937T6xbuzTBJo9V8f7BjRCYTzYkk2SS7IYw48kNIg5UodMdLS7Gx7X/gebTQbEc+5RkSZvLBpkkknlrCxBavypQWGlHVSTmB3ADjRGkNQIDa2cdDzbPOFWdrM80ut55aHn+Ueu51Gj93dK1oWWPbrJqeyujcoxWTOAtPrsg+7HgwpDRTarRTJt6bjTB5iBOrQJzzb7unqdwg8yPHJco1RAyqJ1DzrNVoj3vZoVGpQy3IiEh02eSzMF6x/oj+4s5pJE9W+ztRWJAA+nDH0R8bJKwWLeaENJJQbEbVYsd7dUiSCGJ2f/jo0iktgHeodHTJxiNZIhYVwU0h3NBOhUb4p8dk0O4v4CpLar2VyvupWYkchg3iygmfM5ygpHdIlZrfQkQhjhtYD0Z1Hn2lcHehYYZH/YyAOggaAN2AqDPWd5yyqtIjQhSNNE/ydRwWbuVXI0Csa0L862vWD2S8kDl09pPNeFKqk2DtvPIRPITltYrgPOeo0pPt2rfZ6kZzz4tpspRdmpwt8olf+dCVxXznxg6d9fIrMEd34YLIT8Uai9OQzWyKIHxVbI+tl4B8rChO7J5Smx6cXnsfUKvLvjksCNNtQtiq8kX+sf2CBys1HK1U1D6otcqeg5tg9MDneuMI8+qw+BPnH/HOqHHs1yIs7fkT4ZrepvnlLrIYsDtHViObwFpAoEEHdYZ1nMR5CIkVN3mhbDqyML+qmzOihUfZQAQ+gau46CHG/0xMcFVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FP011OdYNHGIjeBYcYOPgOJ5yAnHccCb9q5ETE39HBHm8NVm4zRPW5n9vfA1?=
 =?us-ascii?Q?vH3OWmj8g4s6IJ3bdd45OfZcGt8RaD+BHCM0pfrcNfU4M4htE6tP9U3KS6Dh?=
 =?us-ascii?Q?uC4emhtt6B/t4L+/9+1aK8put2ALQnkry+xFv223x437R1lR7o7CJV3j80pq?=
 =?us-ascii?Q?0yTQOyONcIBsXmTedJx4aZGGpI4sc+DCH/0RuFuT/WaECPD5DwuqyZ0jozAw?=
 =?us-ascii?Q?cT0pdUvEjj6KoCpL6mAlByVS9dy3BYzxRsip3b7yFlyDE/+XpaXE11FYybXu?=
 =?us-ascii?Q?JdI6VDSD+4ZV6VMktAjXB06jRlCoQNI33Iy3xIHung7ho1HQVYwXV0VyJXo6?=
 =?us-ascii?Q?3QoKVbcRCRX0Fd5FpuB8XljqlkxQ6WQuO+JjT9ZyDRF87FogiRoVDeas1QSl?=
 =?us-ascii?Q?nCmAlCYu0lkVVXLNxEFrulMEaTJ6Swptyoid7Zw6Ht89SBvYApEMqZaNjpir?=
 =?us-ascii?Q?0NUpTUN9IpR9Ah5N8pGsAdx7ZZ0z6ylvb3v2Z69JHhpmXkMmXav4d8PDyf+8?=
 =?us-ascii?Q?y3gapNKvMH3hpWznoN7Ps+greC/lNLiqj5DDKEmWF9b/dQ4jinzzBh0lEAwK?=
 =?us-ascii?Q?/IVWsaGTTe7MY6nPmcnQWAcy9QBjHMSjv6iNlLI24K07bdTTggnbnA1snEu9?=
 =?us-ascii?Q?N52aqnDYTx9WvtMfgha66vVe5U6CGIWgU+KftQX/uxokoxxmoYM9hy9ajCtL?=
 =?us-ascii?Q?bba2/02IpIQHXcAZd0kF5F1+qUzIpMDTC6vc9RBLMFdBusc5u7WFDvk+ZU+w?=
 =?us-ascii?Q?AFAWp/5efmP1evl/NqaqnFXa6+nBI2N6kfPNdK5Y1xrmXTZU7MueewMxKVLO?=
 =?us-ascii?Q?6TUvX2IhRD38PNN+LhfPZsz6NLdSfvaCBFScjWOk1o6wzbEL/mCCmnxP6FAS?=
 =?us-ascii?Q?953d81B7mM7dPP0YrOFfQB2rf0a73pMmawFgroaNPYtuEFc4k73hvbDqxGlK?=
 =?us-ascii?Q?Pnm88FUfSo6uG4pIQt9DGhoXl7vj9mX6waQK2ESKTSrs+gww7jkQCZnK+I6L?=
 =?us-ascii?Q?UxMEmm9BAgQRap6rrCbnkGKK708DTw2txXsfeJL1vNB3GGoHZ7E3vFnhCira?=
 =?us-ascii?Q?qBePwqLozZSHhmo9cDooYhKqhvza1TN8WH4PkxwivfKxaJPhSbDB/vuiXP0Q?=
 =?us-ascii?Q?NrMO4Jd7tWJ9i0NUViRUJtEyq95FTUY4juK1Tfo4ZZaHjK2TiCtZ8DOqz5Cg?=
 =?us-ascii?Q?HS82dFqZkKCiuNmJntLd2y4SoedSl8pVpi1/CO0OeZWPIaRESFE+HSFvHWVS?=
 =?us-ascii?Q?7nrmSeAXBuk6WB37dSuWkLezH1zEh9LybATIgIeTyYG4V87gE8FiHiJ9ePP6?=
 =?us-ascii?Q?cUmyPNyR0Wur3muNaWpKEXyJ8glYfCTmNcvhEU11O/jvNVbeXVLXtelcvIMQ?=
 =?us-ascii?Q?7F7A48xLFMxElIrvaAfxF2CmpaPvWLHlJEzpcxx0hXJXiGYIDm7t/ue+QQor?=
 =?us-ascii?Q?H2QkNVZbJlgJ1uuN5QbUxbYKYuRcTXwkgBFqjNJ/Rxk1lpVSP9AbVgvjzQAf?=
 =?us-ascii?Q?/rkJLqdQWS+v6r8kc6aw/S+/1fkGgR3EzWonw1ClXb2uBkbQ5XPOyjtaD6Na?=
 =?us-ascii?Q?F0FgrKc+Np71HKtDe+LL6w69MdupzH0aHXeQCfRuB04N4ewW9Xeu3GEY1C01?=
 =?us-ascii?Q?L2WFP/5rDm7nlA8Rx20SQcFs7n1+pSqcf2+fIs3mgaYUPmVc0w5+Jq2w8CWa?=
 =?us-ascii?Q?wULt1F3IOJF/TP1V6vryzgUJhBEh6An9HiltLj2j3iPJbFTYzKJXpc9NyFmq?=
 =?us-ascii?Q?OnGDCXOwRd0SLRWVGezeATwqBUQazMM=3D?=
X-Exchange-RoutingPolicyChecked: TSgfgc+LaxGgR777iJDK21+33PCfsoyQLlediP37R6kCPn8/JO9azzC0VbsF+p2R/huZ41/EFR/ub0SizyLFVxKVgo6XsAJok+K9xalbpL5P+eVNtlyRRYVesSXVin/fwq60Z1DojOga/Mn052flAblDQzofJzOoIyXQ0BCNOJj42M7LVv4VW6HMZd7YcgGZom/07H6MzZ0Q5HG0mvn83DzYNlcx8FYXbQDIR/kXWFBgRtO79dCUyrVBywlQm8+mJwJUHlAvFhnSvI/F9g6Zmba7G31mJSQLxgZQZSrXmQsUV0gD/x9aCgACFP14QLdKJrH+5shhq9yUylEVa1u3hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01723647-8ce2-4c6f-a1b4-08de8a6a7934
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:31:44.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjLMLln2smFVz9GtJohUhXde77FgH8syNiqR1J2+aS7VaYxDKPOufYfJnbtFldK5y7juFTPdxchVs1tawdH7hn/ryBXe8DbyJ1NRLqzS8Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
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

On Wed, Mar 25, 2026 at 12:12:07PM +0000, Loftus, Ciara wrote:
> > Subject: Re: [PATCH] net/i40e: fix raw flow item validation
> > 
> > On Tue, Mar 24, 2026 at 03:56:27PM +0000, Ciara Loftus wrote:
> > > Commit c138a6c3bd0a ("net/i40e: validate raw flow items before
> > > dereferencing") rejected raw flow items when spec and mask length
> > > fields differ, intending to prevent out-of-bounds pattern access.
> > >
> > > This breaks flows using the default rte_flow_item_raw_mask, which
> > > sets mask.length to 0xffff regardless of the spec pattern size. Remove
> > > the erroneous check.
> > >
> > > Fixes: c138a6c3bd0a ("net/i40e: validate raw flow items before
> > dereferencing")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > >  drivers/net/intel/i40e/i40e_flow.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/i40e/i40e_flow.c
> > b/drivers/net/intel/i40e/i40e_flow.c
> > > index 84cfddb92d..78191a2d22 100644
> > > --- a/drivers/net/intel/i40e/i40e_flow.c
> > > +++ b/drivers/net/intel/i40e/i40e_flow.c
> > > @@ -2360,13 +2360,6 @@ i40e_flow_parse_fdir_pattern(struct
> > rte_eth_dev *dev,
> > >  							   "NULL RAW mask
> > pattern");
> > >  					return -rte_errno;
> > >  				}
> > > -				if (raw_spec->length != raw_mask->length) {
> > > -					rte_flow_error_set(error, EINVAL,
> > > -
> > RTE_FLOW_ERROR_TYPE_ITEM,
> > > -							   item,
> > > -							   "RAW spec and
> > mask length mismatch");
> > > -					return -rte_errno;
> > > -				}
> > >  			}
> > 
> > This looks a correct check to have. Maybe we need to check how the default
> > mask is generated for this case and fix things there?
> 
> It is unclear to me, whether the length field of the mask should hold
> a bytecount or a bitmask. For example in testpmd if a raw flow is
> created without an explicit mask, the length appears to hold a bitmask
> all set to 1s.
> If a raw flow is created with an explicit mask, the length appears to
> hold the bytecount of the mask.
> Modifying that behaviour so that it is consistent appears to be
> non-trivial, I would be reluctant to change it this late in the release.
> If we wish to continue to permit the ambiguity in the driver for now,
> this patch is needed. Otherwise, we are accepting that the field should
> always hold a bytecount.
> 
Ok, so safest option for this release is to revert this part of the code.

Will take the original patch.

/Bruce
