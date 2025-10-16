Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4BCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2957840E96;
	Thu, 16 Oct 2025 10:15:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 703B1402C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760602513; x=1792138513;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=752uEuz3YX+IvlE/s7ZtG4FM6+HNV0gvTC5MNNSDKLs=;
 b=DyBJkDmKnGuYfSPAw+uyqXWUSD7DdILXtCUQfPsBjWuTTdhlYJSpSkqk
 z2/AYjnN/9jBppFwtVhOpJ/zMBsgOVn/MvON1nzDQq9Qn5gTCC/QecANC
 75XEC8u68gnMRzv6cAb56Zr2F1E+OZVBok2AIA9wX6PIPVs7F8ge4o+Zv
 xNbqqpRERGDIEZp6CaKN2pxF128ftPlR7I19WmWttYBuR16ygEMz6AoPs
 nuImZC8UIoAw7dzMfsXCuCdMzBrpGhNtj9ORFrYR9F5wADH5nHW6zNYmR
 Nkee8oiLCf6DIlZjTR+y/Jh1yNYOXBiFrEO73Zb7Br80cxN0rTFSY/jr3 A==;
X-CSE-ConnectionGUID: SKTayfaBS7Gg2e0iQMVilQ==
X-CSE-MsgGUID: RZyeMnJNRECpl1Qk44C1bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80230212"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="80230212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:15:12 -0700
X-CSE-ConnectionGUID: WCzDpZDMTPCiAescFnTpIA==
X-CSE-MsgGUID: o4/zJsWvRNKDjWycJMC+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="183187256"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 01:15:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:15:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 01:15:11 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 01:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA3QYiq8Ah0aEFooILWwaiCuJylhy/fFRClqVvAJuoVe/GIRZfgdmhADJuW4atBxSEEhRHl9GWIJsSxJtGbGInXRVAnAroZYMYjCEXdg1JqMfaKtEeK567+H88RGYQqg0Ao9JvDVxgK/BWYJH2EdeTwXfGxzVPGhmFAuJ9djdQlbFhniDKNS1zZga/FElt8AmaBmO9i/In2AOqk2Fev8vkIUe4rTNwbCjQ4JtLEmipvvy29S+Wgw1G8m6zHr6fEmarQUAu8gGud7Awx0j6a59WYsTolie3wsPSbEhe4mSQFtkYCU3ryAqMbHVkej5N0UraK6vur1KOCsq8r1dJZL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5477jejQSpKxXSIl92P6i8DSzM4qp+HGc/SrS6I9DJU=;
 b=Lh2sYTwhjLLsmGYUzU7x96Yx8fPby1GtqEKue+4DMehruUEPyO8yZ9D9h+vRwgylzyRG+KqIraum2C9Hic2rCsIpufAJj9CGf29QGdREvFaFPLJiaGkhpfm3wsCZp6cJQqwuMmXiwjL8Lm70UOKJTWQPsRDGpoipVbMyVvZmD+Vkchm5NZTV7nyAkxz95JDViY7tS5amyeF9w+CH10KSDFJ96buOWHc46tZ9sEA9qmLhRJMFyUGJ/ECpR8CIzmzbAs4a7odh+XSO4QfJisKrAuM6SO5P5dwhlz5mTirFzKN9g69me/MsAqsm5PV1+z9LGjSUwaMwwan5KhsmwPS3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9063.namprd11.prod.outlook.com (2603:10b6:208:57d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 08:15:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 08:15:09 +0000
Date: Thu, 16 Oct 2025 09:15:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <pbhagavatula@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH] dmadev: replace zero length array
Message-ID: <aPCpiEAYt6YM4-Ai@bricha3-mobl1.ger.corp.intel.com>
References: <20251015185946.338417-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015185946.338417-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0182.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f0ed06-4617-447e-2b36-08de0c8c1f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PD1Rcg3E4fHLG+EADdEEMWFbO4Lb6kdGwZ7Aeb/ffXYUpjVoDSWRZDFQYgYF?=
 =?us-ascii?Q?0UF/r77gkx8KqZU3LVvQqHLx9TcztkTHFWLF/24ef6XKVIFgQz0WABIhWjtA?=
 =?us-ascii?Q?tPtpVma77NrCmfwsTeWyFzOTffdS9afJDZp56JkNWSiZHMohZPT0Gb+16khs?=
 =?us-ascii?Q?DTBw4guZfMJRte6cGwvbxLzyVuJCY20AA2DyyMUb9jBNqg6bLReH9sOIu2Tq?=
 =?us-ascii?Q?qatZo8gfKaquCRUFd0Uds9exFd0Thm93XMvtgjnM/Eq2/9+3VbbF1gRFt873?=
 =?us-ascii?Q?Bij3A5JQ7r6pE/4KGhOBEtIzqzLi66nVRnVwOYA3bg1OdacNH6POUQv4yb3N?=
 =?us-ascii?Q?821zWUoIFdMvGjpwqX5fMuyKETH/7V/3/b+Ss9skkjIHgOfBUWcjCKOSzC5W?=
 =?us-ascii?Q?wQvqSqyE/9a5/FPrHZK6aqlAxzk2hg2zMdbKjyh6V6ukToCqfj9ajXAdzLjn?=
 =?us-ascii?Q?Camw7wykhdgefLHyvFloCf8dhURPzPteYyafJwvPBgYwf7WiacTKXchYeFdy?=
 =?us-ascii?Q?R/CqnHlvC9IyFiQs6So6+XUTC8vbDSjODOkMZOOoYhtp/S6wtPyXrrlGNpWK?=
 =?us-ascii?Q?WwtJqGg6qKn0yPZGpKmTQOISs1giLD7HZB6M6xlZ4o/asesxLKsQPzQQsco6?=
 =?us-ascii?Q?3kLCWTPimVpnxzCSpcjOxthgVv8kguYX1Md6929LN1V80XkyTvXsp1OMH9Qe?=
 =?us-ascii?Q?vgDdCZzlv2jyo+WORl/OPxpNmwEVyqJhYMBpF+MBd21HJdsVtAgtdtCADZDJ?=
 =?us-ascii?Q?5Yf4cQSoHtAq2csh0jlKpUgoAsaU8y2im2OqJkpPHwB8pEwcE+o6uu9Ct1U8?=
 =?us-ascii?Q?/j8DAlLqApHvEVYb8VPuCx4+mLwkRFicELmu0BMBVQ8sFlNpS7AwSsLmf2u+?=
 =?us-ascii?Q?yywbP15oQkseg8aWOiMnnwjAstSqJipRnQuUE5l17mi0t8VzUhOt/gaXbd0S?=
 =?us-ascii?Q?GJIhe7Gu3TuZiptCRmRnnA4Y6PtwWkJaqDXknKa4HRaiGDn81Uv6LXF1oMtn?=
 =?us-ascii?Q?YZXdfZUjwJMwSmeh/E8H+mzvTZiBjLSwkZ5mWEeozuQAiN074pXi10N4SvDD?=
 =?us-ascii?Q?MzfCbNQbX/lgN11bMeoQJjMYQDEC71xtuopvtgtOyxoq/bsumF1W4PA2UGT+?=
 =?us-ascii?Q?kSBvx4BbCJsGVxziNfxXvZtZ5zC/pLxbW0ATOV1qJbGBguENHVJ+5BlAV1vz?=
 =?us-ascii?Q?/VGEkVAe/I/dlRZRS7m1V+auU/PZJ07023W8ueqwqmn74Y4mS3fzWN3gumuD?=
 =?us-ascii?Q?xqczPl0zUQgZJUFdOEX3rqr030BqABKvnt/R0AaCamucWYeXIndRCXiUw18M?=
 =?us-ascii?Q?SjC2CZB9BgMgQCSoVyNSEP0bJtgTmVWclLgA7hm9R93As5tnLO0HIm7vgDQz?=
 =?us-ascii?Q?OHryh10GJIuO6WKO2p5NmihHY2c3EKAt9TmX5Ti7QaCCghCjgluRiQorHoLf?=
 =?us-ascii?Q?sRQuI/R5jk1X42m2tguDnsKVDUonZRvW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y9RpMrhO8Jpa5/ECRbyXmQIm/94PXg1U+dKNmrI7cm9AfFXlPvsjMNkXSDgs?=
 =?us-ascii?Q?HRa6iFSEQWz4a6raDjXLhNdlFTnXgAggmW5oKjM1kltIRio3YcnvXBOBJRm7?=
 =?us-ascii?Q?rD9KMC194qgKnkWWnbhwNlBPJ/Q7FLIrAenDd1tEETq7+bbbwnyGHuyQh4yK?=
 =?us-ascii?Q?znfqY/uZ/JKkzctlpi6ZrEB5ZyvDxKESLvLhPTKc+jriOuKWTRMCTxmhuHzQ?=
 =?us-ascii?Q?JUPBesXsv4hGGGlqPd0j9dsvl5pWm8qXH1Jabjgw1ICgKXoxQDVZsKVWF2XK?=
 =?us-ascii?Q?M/69EJXL3BN+QyI4nUe7rmq8Hgl7O2NDyXb/aKRo1QV2o69tv+pnPAFCiwat?=
 =?us-ascii?Q?ZHhlCFNpVtD/2OhOK4tz4sYUILAKSUNw9/U0yVoVvsJyto2SfefYvwpLTIkA?=
 =?us-ascii?Q?TevPX6DVfVd0elMV+5aMOLeVsL4dZPxB1ck3YLzOOE8uDE6RVxAqZBK7fz3R?=
 =?us-ascii?Q?4LL4P0hzwsHNGOgp+HKZAZ3GAwtZwpaPFXIG1PLHYe7/iOkQgwy2yxDL5abL?=
 =?us-ascii?Q?C0Gccs5GyyrnmYkxNKxYWUq9XTfjWC/+tJmRFlAM4Mw03DPG+A6nMYCvS6pB?=
 =?us-ascii?Q?0KjpOJFGzdRFLZpwzfdA34Kz5HlhcTujDBLs0UNs3noPwrBLwDkCqTphcZFR?=
 =?us-ascii?Q?p8tC5sTFvo298ivNlMai9GQrUwd2rMg4ELXU0GtZ7hZ3AfN14Eqauu2lls3Y?=
 =?us-ascii?Q?zYKSLZrNEyQLKpwYADkTZ0Y59VUV2H7F/eVioKXIHdQz3a/OCbts5m9En5gL?=
 =?us-ascii?Q?zf/xUoPXaFLBeKLsMTrCd8jfMVKO6FJ1GhLJVY583s018tbeNeDGHtiWdYfT?=
 =?us-ascii?Q?gQyVmBL2rx79ZMIDIrKnfZ916t+O333zz87/jCfQRuZn14zUqDXQ8pLKYqDS?=
 =?us-ascii?Q?ovS6Tex7CfgN1H7E7k4i2PIsFvNyxLI2I4VbjK1nd8UqUu6GFmwbFKs/paR1?=
 =?us-ascii?Q?sLx4YbM1oHhebwIkkjO9SISICiGfJ/UTpT8pQcK3ChwkPCPdFpwKi03SVRMZ?=
 =?us-ascii?Q?FeriJlJRa/VWQBbseGOa8YK6gEkq3cKP3lHz4/R+6Ygkpdn2XOrWMiRaR79s?=
 =?us-ascii?Q?6T5aDmfIUykdem7rDorSvlGkxvuZAo7B6H/69iI0WrzcUHB/58YRWX++PmCu?=
 =?us-ascii?Q?HVi0F84KVxAypbtC7nVAyOg2B59LZT/nqZoCbKmndwRalLPDuPMRCCZCfM6W?=
 =?us-ascii?Q?5l4kyEG/4MIs0UmertwGYJHVUfau7H9mXgDjqVD95IDfwAgwSyf6DtmviSb/?=
 =?us-ascii?Q?9zZJekLtzqTtx4fllg6h9I2lAX0CivLXMFSXArRpOqXVbbNFM1+UQs1+k+5x?=
 =?us-ascii?Q?2isS8w+cz57lFvYHtl/eOthkxqC/hXHh5siUCxoJlZ9WALrL9U9fBHVLwQ1N?=
 =?us-ascii?Q?NZAXP6z17fbeZdIKXSo5hnx5GWX7LaxBJpYEpOcef+mXKkKAtRxUbqEOieRr?=
 =?us-ascii?Q?+e9edKNOdkPkqDp/6otXxRMSWHVxv0UtiymF7iTYPkCUZSKCEYjLfuHhPTTn?=
 =?us-ascii?Q?V2aK2pu4jUPzg+XZH21Gj+RSBHqcqR0ekUa4R+Z7eZm53/yHFQp9nQAtvG8Q?=
 =?us-ascii?Q?pmUcKlwK3oMDYJsldo61P22qFyMTEtAhZiRxtH8hAw8qnYKsyR5prv97eZwu?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f0ed06-4617-447e-2b36-08de0c8c1f00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:15:08.9923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLjHhD92Hi2uf0XxDTz2mj0M7K2LKL338omB4pUcBjM4/14ZP6jEUK23agg6sfaGrl7FjkAjexBR72vl+BHpo0fmseqGWs2lyCvG7sa0/5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9063
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

On Wed, Oct 15, 2025 at 11:59:46AM -0700, Stephen Hemminger wrote:
> Use of zero length arrays is Gcc extension.
> Found by zero_length_array.cocci.
> 
> Fixes: 9674119fbf27 ("dmadev: add enqueue/dequeue operations")
> Cc: pbhagavatula@marvell.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/dmadev/rte_dmadev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 30e168825e..8ae9ee031b 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -856,7 +856,7 @@ struct rte_dma_op {
>  	/** Number of destination segments. */
>  	uint16_t nb_dst;
>  	/** Source and destination segments. */
> -	struct rte_dma_sge src_dst_seg[0];
> +	struct rte_dma_sge src_dst_seg[];
>  };
>  
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

