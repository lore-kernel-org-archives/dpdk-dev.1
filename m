Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB97EA3F28
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:03:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF9B5400D7;
	Tue, 10 Feb 2026 10:03:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 89E75400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770714230; x=1802250230;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=X5Jx/K5EeM+hlw7KzhMy7SnLMN3plAPtiB/g19ZrhMM=;
 b=M0nPQcrJ8VNGYM3dVHIVFU09GG6OinGF6zpAJsmk+MoGygH2c/a6gz3h
 FOUVSfbRiW7jtaOzgR6Fm3JnPz8bYpe/Ye3Zjw04h9nfphICK8HKIdJVz
 7SX5Dbx6ymI4EmHDsCUAaLQMMCZ66I/Qt9OHbYJOhnWVz6On29b30YFNu
 1Nb6g7r7iGpFGDTCIjtMws5iuG7huqyRf10MX5MMXccD4irClWuwWb7j0
 oNkcgEPDS51nPRFfTl0nnhrcqe6/Vud7Em4pt7OYmpLLcZ8QiLvX42/If
 h9DiJh3cF1TpZ0nusP+4b9SljaZeEq5WlXIqR4WaPXo73Tl5ThkwE3IwT Q==;
X-CSE-ConnectionGUID: G6Msn3PsQrehvbnsFJ84bA==
X-CSE-MsgGUID: Idd4lPZKSJSHJ/Dy/JxGSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="97297678"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="97297678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 01:03:48 -0800
X-CSE-ConnectionGUID: vWNHc31VQyCppo9vML4+8w==
X-CSE-MsgGUID: 4jg03cmZRJezqlvzhtJApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249502064"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 01:03:48 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 01:03:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 01:03:47 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 01:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ40wwlbP1BLrL+h1y+LOwq9Y8KBaGNVn7kRDCanX4CcB6OG+MGP5eheac9HFsty+Jee9/o3Fxkmki5jy+tXX2P5wwYQyLM2NOQjtPh7tWSrL+xcxoWzCWWL5Mn6VIChhdFXxlEJBU13UpKoPJQFKFNpKpf/TqhMKFhvJMpHX8H7Y1tF0fWV4lmhlirZ3UZX1OM1Ks7lp/0dTGcndbz5rfzPR+HXsODgA3lKGbtKaapoDT6nu7bKKzle/EV4ndesLbHwaJACpgXsLISTU7HfAWKZ2TFxHtuESpfsA4uMiiHMbISpevx/7D9LwV4PQ8eWPuVuwqRgOZZhvu0t9BtTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JLYlkcnsUzkQFfy7gPT9lNgLcJz5k66SSk7/MojPqQ=;
 b=CM37GD2fRXGvtJ6FFEwN3QKrSqUAmZAQ9IZCm4Xlx2DRTANj2i8LWQ2TZocGnP6Xh9zO7TJNKTKA/Q6HnAnaDGiGCvlHlCk0Pz4KmArBs7Kkj1YDUbKEaIjUr8WWA9a2aTLs6I5ZWtMTFjIVpIdcD7upSamAEaoHJSFeOSgOYH4ool8XMkVxZH2FvXkxDEiFd1ZXkW6LFb7o+op4idXrFFH/qt+cwDNPBfokQvFAJ4daqEKm15wAu5IU1s4yFkmQ3JQexLh0LNKu253FwtfGl/KBfpyX/tDfXPJVkyqwj/F18CFSNSvS+lSDsROtxd8LTEnfAH+cbqkKAN2rhR2tbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:03:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:03:45 +0000
Date: Tue, 10 Feb 2026 09:03:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Message-ID: <aYr0bDamNTwyDl9D@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd45469-4b57-4056-844a-08de68834bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?W+Z3GmxH0gTCdyUohorpn+sa1FomjiO6VbblX+qIvKUU57OuBvOnqy95bg?=
 =?iso-8859-1?Q?JKK+qVwhi7/3Uzyjfpg7Vfw7KGipgQ2D3MFQuO3cvEjLcqVnezC/REQU35?=
 =?iso-8859-1?Q?8pHPVzKgjYtdVm9J12WfyQy6+jVt19Ja+jJRO00yJ5hWDHEw2Z9CrhE2Yv?=
 =?iso-8859-1?Q?NgFpF+9yXql4RR4pkeXgnxuftjBtbbk+EBUpmLohkgtTJbrb2MVsjV1kBB?=
 =?iso-8859-1?Q?x2qj4dn0tIy/OWzcaMcQXr3tI9CHOtoyKl69Jxk9K7jNufGttNwOpwMu9d?=
 =?iso-8859-1?Q?J2JRDikok8IGgIT7np8MApXAIlTZSLqDaz0JTl7rcQ6JSBqqxGiaLyKIhK?=
 =?iso-8859-1?Q?NMjgcdFYT7W1HbUMkgbgYGqiLIsRAcBDOH3AvtG1KTM0a9jjQTfKkLi3Zk?=
 =?iso-8859-1?Q?COtIafby5oopiCiZDZw4WzITftD7waNnxhkkUrXy6wA7tE+TUVxLKSIMvf?=
 =?iso-8859-1?Q?AGfKzXOaWmH1VDyMXoAHEuh3aZ1kkZjatghJQX4UFKIeFVk1b6RBq8HGEZ?=
 =?iso-8859-1?Q?tARIINnkvz2aiiEayYXK9mzpPG250Q6pJ+Zx4Khzb5cINkp/evXR1ximys?=
 =?iso-8859-1?Q?EnOrdthO9WP/ZQI2BP1dVBJUq1YQdRoDkkednCkEB8CdCAZOFcFXvNok3a?=
 =?iso-8859-1?Q?iZSadCktuPEnWcNcBccVRtSKwD5P8LJioguXGTHZ9Rks+YwKL1E3umSuyW?=
 =?iso-8859-1?Q?uUJHfNRIzn92kQXTxOTHwkjD/bF9xMg8tg7IdAEEXsgFd0N99bICaQvtvT?=
 =?iso-8859-1?Q?L10FVh7FnWnwuCDZpxV/c+gXauiHWcGpu3k1S15A5aAn7mMhC8UtWhWPiB?=
 =?iso-8859-1?Q?qnXLqBot/S0eK72WXZLREMOZS8XaJuQRWU3pzZ2go4vSKy1o/9Pohk8e1z?=
 =?iso-8859-1?Q?xOFkCEtZYdbKmdgfJRaF96q/kxRniOYtO0mereYEE49FaaZurzRzl6Jh7g?=
 =?iso-8859-1?Q?o+MfQTp8xz3ERn3Mx3uBzh3cZNlM6G1tULrQwJ0ZnYp2pfdgv4RdvDCdoE?=
 =?iso-8859-1?Q?1eCYMINXxH+nk8Pzh1j3rmL/vVSTzoWJ2rRXzslK2ZTOZtSB/VwjUwc7f+?=
 =?iso-8859-1?Q?RO+LT3Hxmy5ZKgIhd8sNpPBrtjJ1/0t9RmGWxGN5QRWCgnRVZoCv5/xQjq?=
 =?iso-8859-1?Q?9Z/SzkYjecbuz6/Y5kAn8WUugX0SkRLLw0l9UDNPXN7EdwARy3FwSFyQ4i?=
 =?iso-8859-1?Q?PeyN4fvqJcybEwqGCU4dbSj9g5wuJ8FkWJvB03z0p0JXMx5kerJynuB+mp?=
 =?iso-8859-1?Q?6P5v11TDPXNvh7q5Ck4ievJyYIYGRY8TuY8V/HwUy2HT+4UikhXHIx2G1b?=
 =?iso-8859-1?Q?SP9lrJPi2zLP5nxsB7r4El2CyE5oJt48r2t4vg0QUUPjjji6jjPmKCKD2I?=
 =?iso-8859-1?Q?51n0cXT9ACaEcPjVXsUemMpWE6MOmSw9BanytOhM7xEzmbx8OkG/f1l76k?=
 =?iso-8859-1?Q?ii+8J7dfZl9c9+pweT4bW0kRYK7bW9+xawtf4UuDC0xDaw3Hs6RRbnMRuZ?=
 =?iso-8859-1?Q?4mzVJxraBoqMP0DlQbUiLRiEPnlVJNigs2Qc3Rjp51BHd6GRmpySoOyuyM?=
 =?iso-8859-1?Q?G8Hh16MnfZyEPxqoUr7Q+cpzt43WYs4fCaDcU8u6CswpVK+npmWVd3GgaE?=
 =?iso-8859-1?Q?KBSIKNjnvOuK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FT278QUpij45UlOgip3juQkTbOMhYMaDclMrH6ZFw1qClzKzrwm1a6Y/o3?=
 =?iso-8859-1?Q?FfXm4hXzMh1v1RCvhF7PqUQ+JwAebXl8n8pdr/XlvvjsWiNSWSYOnVnM4s?=
 =?iso-8859-1?Q?yAgxax7AFJRbk8Dg6mPYaybdV6RNiBpe2UK2HVf0AkSjhi1Gl8wNJ81pmV?=
 =?iso-8859-1?Q?zYo+LsBgp2pqcGZxE5IIhIje0JLOP/vOeHCGrJ1//h+hrBrEUtD/5c8CoC?=
 =?iso-8859-1?Q?Ph72KBj7Mlo6BlUmaYu1FNy/zTtXOHgQEM+LCVE7cvnHLTfNud8VocjFT5?=
 =?iso-8859-1?Q?5C/KBNObZcXQz7w5l+cHyF3BAdj00ZNLWe2Q3FxIetrLEZUC6G9tm6AHaq?=
 =?iso-8859-1?Q?AezxtNIKcscQ82iEnDz86VSwSRqCKMb/yeQmyG2hNpTqJZJMoCPw2/S7hO?=
 =?iso-8859-1?Q?+wy8UFHqGO8uAEjo2wRhN3FoWDLZ2adbsUWWoL8aTFd4OM4G+CzSWS6mW1?=
 =?iso-8859-1?Q?5jjPj7bocJbWAbu5rpWXXvFKOyzm4MAYd2kd/mQCCEQ88hJ9pVaU8PxT+K?=
 =?iso-8859-1?Q?0/j2jkOR2QltiTXIulqB2R/kiiCIDmxY+UcstzSKE6ZLGbDR84jwWTILLl?=
 =?iso-8859-1?Q?zshno8mthzSDel0OvzW+NkQeWI+RTTWRcgHuTl4XJIkzJzGhU4rJLyqAFj?=
 =?iso-8859-1?Q?9wwexY9U+orAVsC+t+N+BipOrc5lTNV0wx3MfQZQr3OKQsdwor1YCBR4Qc?=
 =?iso-8859-1?Q?qKBm50rxoUre8ByxwrxOPFexOBQu1anJO3HmRiOEkCWcSvjPKfamc1Ck01?=
 =?iso-8859-1?Q?ZBuXmxqoUNxiZUnpRYQk7xEBD0mhTwnKRbxaMMh+4CtOmXo3BCN/oGC3L8?=
 =?iso-8859-1?Q?hHPdF5rQgv/pC6l6hesdoo9WtpYZNuuKUnx6lbJtFmhzH49abl6FEsKq6l?=
 =?iso-8859-1?Q?Th9yQ4H/ceWqbxcpZYbePJbbIDriatijqzw5biR7+5z4+XGfZYcTs8wLff?=
 =?iso-8859-1?Q?zvWCaiUvpKyBagx7WxuoWN/bJ+7mgjPUKMPcJG4hWAHFUs4yEbnO3Mf5GP?=
 =?iso-8859-1?Q?jnJtAOZCB4EMw9KfXiLqewIY9v/sSsyTJywcMjsuCfrHbQTLvzJ8+1xjw/?=
 =?iso-8859-1?Q?ywFm2vAUU1XVv7Aojf8qSVCeS7FHmj4d73TLmp3UPUkD48FNftsGWx+GR9?=
 =?iso-8859-1?Q?nGGsDaYna/C52eTSQShXQ/XamlSQ5DsN3Yvl/qT9QHRsgWyE2M5dHVuXLa?=
 =?iso-8859-1?Q?OgZcE7lbPZIpQuOl8Q8+qGutSPZ5O7bGmYac/CElIxHp87PrrW7ujIiRYg?=
 =?iso-8859-1?Q?wr/dPTu4Uyt4xRDCC3Seo/i/giC9vJ7uxu7AZ5jzgmGLWbzAWK/hyFoaHg?=
 =?iso-8859-1?Q?fQyoazipGRcTlqk0zKZZUFoxOAkSrsRjuvgGFFmYkH6zEvTcZerv43v05k?=
 =?iso-8859-1?Q?24OMGVjQvtCaswScXEzsxd2WStyjwX1hnm77ISz74sMdAPb/Vj5r1geQn0?=
 =?iso-8859-1?Q?af9Ik3uooHr3JjiMCTV142viG/MQK3LJR4mbv0vNnr/cktUmwAnT05UCk3?=
 =?iso-8859-1?Q?9nG9dgllf4gayMmMCpgT+pEil/E2IHYCRlj8O6mCuphaABZRh6Ik7mx5Bz?=
 =?iso-8859-1?Q?3N3T502HMxFdkwC1ii5dKwfC7cohSOlyg+Sk9ecZU3j18yzzdjTXLdHEfn?=
 =?iso-8859-1?Q?AqOHQbl32ct3ouXYFI9VyBlZyhXFj7YP8Fg6rU7YR3L6oSKvddtFiFk2We?=
 =?iso-8859-1?Q?5MBcxq/MzxDD7ossJW357Bc7cI9r9mGoO1vEdabI/hgNUbu7nBQv6+3q9i?=
 =?iso-8859-1?Q?ouLIkGflI0jhmsXyJi2q5DYUhS9Afh+XrMSRVInJPzV4WczyjlXJz2f9hA?=
 =?iso-8859-1?Q?S2qZe8FC3/aGzqRwwaDsd2AVmpCiUCo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd45469-4b57-4056-844a-08de68834bbe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:03:45.6044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rLV2cOigvjXesbzDq6laYl8Da+LiGEZ/v6YkB3qoZL7t7zoWN6OaFq9z30ohNW+1vlORJMpZNyNvBxWkk2G2ZwCqHfwaf5awJ7Gtzt1bsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
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

On Tue, Feb 10, 2026 at 12:08:44AM +0100, Morten Brørup wrote:
> > +static inline void
> > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > +{
> > +	uint64_t *txd_qw = __rte_assume_aligned(RTE_CAST_PTR(void *,
> > txd), 16);
> > +
> > +	txd_qw[0] = rte_cpu_to_le_64(qw0);
> > +	txd_qw[1] = rte_cpu_to_le_64(qw1);
> > +}
> 
> How about using __rte_aligned() instead, something like this (untested):
> 
> struct __rte_aligned(16) txd_t {
> 	uint64_t	qw0;
> 	uint64_t	qw1;
> };

I can see if this works for us...

> 
> *RTE_CAST_PTR(volatile struct txd_t *, txd) = { rte_cpu_to_le_64(qw0),
> rte_cpu_to_le_64(qw1) };
> 
> 
> And why strip the "volatile"?
> 

For the descriptor writes, it doesn't matter the order in which the
descriptors and the descriptor fields are actually written, since the NIC
relies upon the tail pointer update - which includes a fence - to inform it
of when the descriptors are ready. The volatile is necessary for reads,
though, which is why the ring is marked as such, but for Tx it prevents the
compiler from opportunistically e.g. converting two 64-byte writes into a
128-byte write.

/Bruce
