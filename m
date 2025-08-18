Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0564CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2648740267;
	Mon, 18 Aug 2025 13:24:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4852740262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 13:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755516240; x=1787052240;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KRYvwOJBwcJtrPsCLopYwlXXQKTlwytzLpwxSL2ARa4=;
 b=KUgWg5hv8vY4j4kCwAhDrm5G2FMlW5NdZzTpwZ87b+zwjX4RsNwc/8r5
 OtuhvzTfA/D/aKvOLwHRKDYNcXXTkQhLeRuy3qJCnPVJQuqIbEmh8RsYI
 mXUFFh3L+tfWyRYBPtlJcQV0K26N4/mLUPCF/5etKvTN+Kfi1fDfBh0jn
 W7pYYHvOU6UDbXC1BexnpC6nMP8PGxizG2b0CnBccRAg4tWP2x2q3aqW9
 vq5zYJmqUiBbHLKedHk8YEJvw17jDwZ992ZbhSUIyFgPFlVHO5U62ES5L
 ZLIslLgaL6YeL7YzxlrhGmRLpmQLt7+bOlqdFpCWB9SUnIk3847jfdehG g==;
X-CSE-ConnectionGUID: Xfa6Squ9RyCSpMVN0p0Mhg==
X-CSE-MsgGUID: KFH8wOlYT7mVhm9Zd9xYjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57691986"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57691986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 04:23:58 -0700
X-CSE-ConnectionGUID: odWx7SWjTDmQYFtX+dyvxQ==
X-CSE-MsgGUID: zg77aBfgRlSHrd2vvn5zsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="204715367"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 04:23:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:23:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 04:23:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/V48p+wg7w6IscGF+zd9qFEMF0SeKCB4gGG9z+2V7JoXiNxDquJ1ZxKIpkEjBDeSVQ6GxLpL9Rm/m/ZPuUMNZNXDsRowIuiyMBw1G5Tyd/jTsdqRLvtdE5y4FahN7Ns5KwlZkGELCeGVvuDqF9JGtqCHDpl93p6RGRghwC5QcuAGg4pec13EnvWc6QZIHkOr26v08JWSft0ckiz/o5fwk3VxQ3BZfTPI4sOlXvJFjngT2n1qbH2+QHkj07hKcQJdw4hOEG+CIdK7cTVHBNEVtFVVrvsUnYTFtnZ/HAVt2UtHDXzZZTeSH+7rqcc8bEe9SHNM/oPCGU4rbcXod291A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCAxbyh1cHOOBtSvaN8qGbh+8AY+vgi7VHTVKcyANfo=;
 b=ZeyB/DTYEoYfpuMfa36GFOjJ9H6qPtQ1KuMhptDfvi9JTLQkrNA46hwDPXAriVM0kXp6N49IuB0jtJOsuavacuEq3WH+6mmS22I6hTjHtsbiN8vg2WXUVZeUZormUVfCzi5MpoAEBLOmEalNEC6rGBheo4grZrzbhKhA7+HSeZsoIj5TpUr7zM2RZDO+vgpsi1Xqlmv0ficMAP6VpTYHof1FkRvhpHTsby47rPo8LBWh3AUZCzR9t+IL9OH89BD3Ta5jzGhchQi0ugjWr22l+5yrg1jrMWCQwC7deXHvDKHyrO8DW/kmCTENHqRKY/FNaqp5eJKFEGyy5cXkVeqnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:23:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:23:55 +0000
Date: Mon, 18 Aug 2025 12:23:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 12/15] net/intel: introduce infrastructure for Rx path
 selection
Message-ID: <aKMNR0MgCNBtWYYR@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-13-ciara.loftus@intel.com>
 <aJnVvjcg_nhgnesS@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A14E9758E3D0F2CCE373428E35A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aKLhvoclHxDkyVpy@bricha3-mobl1.ger.corp.intel.com>
 <SJ5PPF6E320AF71904ABC4769CFD6CE4CF18E31A@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ5PPF6E320AF71904ABC4769CFD6CE4CF18E31A@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0193.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 904387e1-f257-405b-95ee-08ddde49b7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RgQEG/JcqGCPkFjvTyC3jHcLX4iqqYOgHDGCTArxyh9FLTvecRkF2WA8dUfo?=
 =?us-ascii?Q?9KfTbk2dH4WlmE6DAH7nBAwEdmHR76H59I1fKF+bSW90/KbnC3O/ynx2Sozf?=
 =?us-ascii?Q?Mo3SFg1A94voKM9gYKrJmaQBBxezDuD5iwZQ/I0Xg0ID2yjXSO4ZAVnLpQKY?=
 =?us-ascii?Q?CKSZ4eLjDvTAVGwWNmCFyIbxNTr1/ZZWpjMSy6eiV7uqBPvsRVinjCQwlGBQ?=
 =?us-ascii?Q?iXgo3VXdWW/eEmbsBYGvW8qE8eBixWx5MvOq/r926ve3/tp6Xrf/7ern8VRA?=
 =?us-ascii?Q?4SeEZDLKRGyVpWpqChj+vtkvoTei1fXISacrXj2ErhhWkjomaAki3Weu4IUN?=
 =?us-ascii?Q?+pT2t7axB2K8wuu0E8Xo6K3J+jirNyYZL6wAsnLwbhrXa+VVApG/bMwphO7E?=
 =?us-ascii?Q?Fx5uDUmExeTRv780swWPGrWRAsbgHfX8mljuMPf7rkBig0XijfdwRi+K/kId?=
 =?us-ascii?Q?Vq8KfG49eZgvwLgJ/FAL+8v2hW6ZCH8J90b8lpQklZPy8MQ/wJ6i9tqaIdZy?=
 =?us-ascii?Q?kxganN0ATd/4/BDX2Vx4z/Fcgzh+muEDu/Sh1w9xpCwYhc41BiqTfEEWkOhb?=
 =?us-ascii?Q?pFmoc83PanV4O5n8lnDV3dFx9TYpmwdReYmPo1u1BZzgmK6P9l8oEkAniBcE?=
 =?us-ascii?Q?MA/f47QN9a1BZizNDmVVictr71vMlNv9fvalGxaB/SiTOPofWNBSZrKV5b9R?=
 =?us-ascii?Q?q39ELlutWGRT7+2KtHrhOlz0b1AGdUeko7ajB6eck4dV2TboZm8OnZYW3Gh6?=
 =?us-ascii?Q?y44FQHc0kHq3nOP00NEYRQ5SkSsLadPzY8Mf4VueGvq91YEp7dG/HjZNLt6n?=
 =?us-ascii?Q?vzQB2VTtRo+fkRGD/HHiFMUPdGW69punIftqEGwP6OeL0VR2V9Swi89BFzsp?=
 =?us-ascii?Q?4hzPVQfmFnrHOp11ju+I2fHQroDB0Om0EshXHpviwBRcTEBoR9JZs82B0EDw?=
 =?us-ascii?Q?HCsfMsayMGpD521SSYRHRfCWR4a/hCUL88sflPe02IZLQQBR49Ti+nUKPTK8?=
 =?us-ascii?Q?UOUew7VO1HECtA3Alm0bdHxldFxSuuwD1NnQsxV6PTrAvTPTn60tWDWsgE1m?=
 =?us-ascii?Q?VU8503/b00KimHuS2hvSz68c9Zggn/Po1RRbpsg01iu1krw9A4ojunLyL1+I?=
 =?us-ascii?Q?g8fk0Aj3T0Wrs7gDUrtRewAB2909ubcvB7EEnZg5l0BGUkgDWPB1jtui/PFb?=
 =?us-ascii?Q?yTOga4X0C7AHzcr//HUTuJwKz5w3TnugyCplPz5gXz007Klc6m1/cB0n2FIE?=
 =?us-ascii?Q?mPlqDrnoj7x7OBvv32HTOFx8X4OJQF5vH+sWCVT7CMb4cZWk/xVYUp3QVfyM?=
 =?us-ascii?Q?FKYhy0F/z4COJGQS+ZgSfQdKVJ/aPt9SWWC0RJfgngu3nMEN4reMGee/80Rg?=
 =?us-ascii?Q?CJ2ccpFbm2WfL+ZaZCCmrPPkl//zL9KM/IW7HhtSdQRI4DDJxisU9KTckKPC?=
 =?us-ascii?Q?bPU1PJzBApA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sEo8rMon6tzhSwAfjJyO835cDBRE5/uV68p8TtJfEauAZtPWh1EoFSzrLVaX?=
 =?us-ascii?Q?guYLYqeb8daVCzoYGOYPOWhG1fY3rWiA3k3GvgZJhV7JQf5HTuA27vS7QcPa?=
 =?us-ascii?Q?717EKiclkx5Kq7z1l7aH4cNhU19gp6cqZyjqM751pAza5hn7Ncmhu97SOQPl?=
 =?us-ascii?Q?bASLphlFP9Nm0JQewIQWeJXdMIP4jDxoPf9LYZebLD9LjJNamqqAykzYZlH2?=
 =?us-ascii?Q?wLEpEw43UnlmmTO2j0J5IRRCFCPlYkzSJsoR8g3k0rbBNdbor42HRASjAWH4?=
 =?us-ascii?Q?8bHVgv+bHGDx00lKQuLztoo2wOsJRm3+XiGTysbCBUr67pkBxiDsHG0jgtSt?=
 =?us-ascii?Q?I1pFMPamQuy40EVhy/jpzluRjIy7HfdE3rVpJGG8dhMRHOortcHtr8mA2Zno?=
 =?us-ascii?Q?tOnuTjkelijsvzigvZSXZrIxzMv8kkcSKpziFFALDAzSq1P3pUrivsCww1Wc?=
 =?us-ascii?Q?0778KLMI7SlotBaE98BX9hLroa/0hTNHg9Tfl2lZekZaCywnm2lCGWyzTnQA?=
 =?us-ascii?Q?GmaLodrW3kOYgx/Vbzyt9aXMS64chj/f4xUq6nrgPguOZkQiul/COV7spQie?=
 =?us-ascii?Q?pDFU6bOJF6YFVEYe90B7tVOxMoZYRwoLhFDid49IpnwQtM/wyT+MVWwVmAFU?=
 =?us-ascii?Q?lRuyOs9HKAl+JWErubhAQVCNuoL7Ea6UF7pAri5tWDrdLD8XNFhCPbrCaf8q?=
 =?us-ascii?Q?gFg8s0WPSH6lioE/UPpdCuHw9RpnKxHzZIdZbb0KSn6eSYvzEbCwgm6iRc2W?=
 =?us-ascii?Q?C4NjHV0+ImriLd+tqYDLNTfKOoIEO93z7Y1t8C4SN6r4ltmgDsCzSz6DTdzM?=
 =?us-ascii?Q?9DVbr+1PQEgO4JmNoZCd/Fko0jLlvT7oDW6rEPB5UnRLtPSTT3v4oAxS+Tlz?=
 =?us-ascii?Q?am37shTXp/iy875glX6i5/hQVDAiBXFrKDmDUeekhQ5hb+tKiVclCHmapvS6?=
 =?us-ascii?Q?O0JEa1BZsYLm6QjL0ObMVUOBbb7qvG9lscvH8BO7YDwHOH3Be5LsQvXQPAMT?=
 =?us-ascii?Q?Jt8P8kKLXOH5/UKG7amyfe67eVq2lUUbdqioEog/A5OCbxDL4YASoSVZ06Go?=
 =?us-ascii?Q?jXypO76HGC44pX4TF9Zep8IbFdDApkmkobye5d3VDCl9TOQZXeXOQKcC67YG?=
 =?us-ascii?Q?jYYY/a31x5ejar8cayx/pEYD/FUJ5xi5O+OZL9BXDdCey9uR1Y29dOQYmJ8D?=
 =?us-ascii?Q?Q2XfVkskFaI2aCA3TT+WPo9ga55TjPuHjHo8/vMAZwCPGDzsXCLMHXK6EI/j?=
 =?us-ascii?Q?Dkn0LxzEc+fljJbQrbRz6bVSF/v3hFkftFkVk7U7rTmGv6vuwasmCDqVmCdB?=
 =?us-ascii?Q?FsHSAf/SzNwaCCEljy/EB+Cda53CTZA8wN89vOOcRhtyQv75aKmBlo0HrAze?=
 =?us-ascii?Q?qa721T828JYxl/FNTL83OZrLxTPhVoEiVBqD5OIGgyffqkWPFwnUUXtgMwi7?=
 =?us-ascii?Q?bPrzff03fM/7B2KQXomiqBkF0gFrmLjnrFRDrbcGrhO/Jh8bYvQyF5rlcOCp?=
 =?us-ascii?Q?Pql2k3stu575wETtThuxttQOm8hCQmYciZvh5YVTwAVxZR8y3Ig4mIZ/Y84K?=
 =?us-ascii?Q?k/vzfDBZzFTeGLd/4EY0Y1miJJXOOMjxMTULK0k84stRjvR9WsKSNEseLr7x?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 904387e1-f257-405b-95ee-08ddde49b7c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:23:55.5940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F79Yd4xjyO0eMpKV73qm9/w73SI0+6vimR6gWmVxYQTQTSVVBhaCUQGzbWaIYfXJSqtsWFycRH9aTG2Oh3W2vUoHC2cS31NP2KBwuw4EOE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
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

On Mon, Aug 18, 2025 at 11:58:22AM +0100, Loftus, Ciara wrote:
> > >
> > > They're not necessarily needed but I think they improve the readability when
> > they are used in the next three patches when defining the features of each Rx
> > burst function. If you don't agree I can remove them.
> > >
> > 
> > I'd tend to prefer assigning bools to just true/false for type-safety and
> > type-clarity. In terms of readability with defines like above: if we do
> > want separate defines for scattered, flex-desc etc. I'd tend toward having
> > them as enums and the variables below typed using those enums.
> > Unfortunately, that's not really feasible with the struct below, because
> > while bools only occupy 1 byte, even a two-element enum would use up 4
> > bytes per value, which is padding we cannot afford. :-(
> > 
> > 
> 
> I went with splitting out the boolean features into their own sub-structure, which you suggested in a previous thread.
> 
> The definition can look like this now:
> 
> [I40E_RX_AVX512_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx512,
> 	"Vector AVX512 Scattered", {I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
> 		{.scattered = true, .bulk_alloc = true}}},
> 
> Let me know what you think. It's perhaps a bit unusual with the nested structures but I'm ok with that since it's more readable than a series of true/false. However, if you would like to just go with the simple true/false approach I'm happy to spin up a new patch.
> 
> Ciara
> 
I'll review in the v3, but that does indeed look quite readable to me.

/Bruce
