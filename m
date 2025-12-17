Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F75CD6554E
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 11:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901C340275;
	Wed, 17 Dec 2025 12:53:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 534E44026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 12:53:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765972390; x=1797508390;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kzevQzoaw+5i8gU8kRM+Ui/Z8oE86RivYCQQY+UYkAQ=;
 b=dtHhLTvyil551e2jE6wNFtqhS1XeYkoAKUV/Z66mW9XJnCmYrJGQzgvv
 K31HojCmNG+lrpMnT1w/hDYLRQkt4aHX4NIlUJffI77HAjVfs2lTjO0+Y
 Ep8iWhi/5tRJOWqTPlexO8GJAbL+9RknkMo8GSMaxFJTgDwJFK07YI+Yq
 h+BRtw+X1aiBYdgukU11QRXvuP/Ty4A9vEVq2KG+tQ7ExFgbCqJBN4l+Q
 lh0yJlE0774enl9dUft+KazLdsZJCOi2lNAVNw9e6NOGBZgc2BMdwLTnw
 tHcBbmeWjjxAUQfKoWeq/C0+5jkuj+NfL97cSF+CifzqIxzalbF0lz8qz g==;
X-CSE-ConnectionGUID: fpVh70ClSXiLR2hxj1X0jg==
X-CSE-MsgGUID: D7F+POQGTBSIa1vX5467jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="90566327"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="90566327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 03:53:08 -0800
X-CSE-ConnectionGUID: /xFnesWyRau9eCQl6eO6cQ==
X-CSE-MsgGUID: 4C4WbbjrSc+6yeqcRXal8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="202666558"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 03:53:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 03:53:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 03:53:06 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 03:53:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrottqAu8Bm7025uTjvl2Do62JLS53xsmW643+oHJJ2w2laiZrT7yXWNKLJyIm6DQxek/XEfLrh2QU/2/cZytHUB33qRvfVxsXdu14oSBizGmtEKGOICGRZbe57W7vCFlFR7zjLYsjg/NqGJSXb7z5haLMaw37WHxhsXs8jGOVX5VpG/SHdAvtQWwEegHDzcoM+vy1eczICOsEX92K3PVs/VQsi4y6lWljQC+iL7cr7T1rgDl8SV+6pqgoh4kqhMBj2so4emNrjJUvBr3Ps4hOUSVWkUduM/8ReAy97CzmKO9V9fcF9Jfby5maN8cyfOtjjkUyadwd3IgoC1P6JTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXelNOh1KCshZ5n5UljVfVR73QQfS0qGLmvWnjdHrhM=;
 b=OYWnhfP3lYDwfD7O8XunxxPJOLns2tczkgarGlMkWtCE9sbOCGz+MBSr1prLaiKcs0l0RNG+1IM9YhbJSM+nHgbpNNQU4/a7bS9fWLKtunubZ/LpVWIU+Q6iQMD/Q4LfWu26UJXHYNC0DhWcKMwZqCrndiPYTCkdZBSS8BjXaghjRxoAN3PL5p84QXIWLMa+h5gp4PtBrVO/xfdNrX91DYxZtOCggL2iMbKcEGuoT+JfcsGMbBijmHZWZEwey8iGMyJPxd28w8lHKPD+5vvEOvQcTGNspvT/SP4TLeY2FzfGEoh8RZn92xTpsDGSGsKYEpowh+cmWYwDgrdFA4Y7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 11:53:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 11:53:04 +0000
Date: Wed, 17 Dec 2025 11:52:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v3] net/ice: add MAC anti-spoof option
Message-ID: <aUKZmzuLWYguKOlE@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
 <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fae3ba6-d843-4bb1-6115-08de3d62d627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RX4BHjzQiYHlFzblySHIIYDT9D+9pIkvGb9XKulFT1NvIPOdOhh5z85609?=
 =?iso-8859-1?Q?POMR/QFn9z4cd6MZIF5fq5TV3D484bu23nyJimupp47M0Bbjue2hSPcjFO?=
 =?iso-8859-1?Q?bfA2j1gFPgI2tQvC8XOXJMyNZIwdrKcQmDYMSFqw/Asp2MhK9wX7CQT9sD?=
 =?iso-8859-1?Q?Ri4shVGM3c5ua2ZNDrVon8pDnNo4r9lTx6aNKJxQR0rkVowRkTQ5OhtoaQ?=
 =?iso-8859-1?Q?j00XDxf9qw7Mebsp19f/oPfeog/auGzDh6xckyy8W8+p4KfAzFCLoZNZ3T?=
 =?iso-8859-1?Q?9ynHOUaf+46T1Ktf27yvZUIYyC7ULdZC9/TeGo1+FVhW4B+y0w2KMgTktc?=
 =?iso-8859-1?Q?rz5/NyMWr+KhQ/QiK+j/OPchoPD5BUj3C5rey4c37NlhL6aUDY4J1Y0Tpl?=
 =?iso-8859-1?Q?J2mUk7/s5gZSfID/C5sjsPuTdNkeksOvgI2642Azf3q/3XsYShP4dGqIan?=
 =?iso-8859-1?Q?K6NWdUEyki5MNvZIsSqe/KYRof2pZTOACCEsnzxEcRq8tnRWXrXuIN0R/1?=
 =?iso-8859-1?Q?YWb+JXs69z5aX94QEhlHPJ6guSMLzYFm9VPkhawe1LcK//aP0JJj+C7v7s?=
 =?iso-8859-1?Q?UYtnJGugna8nS/xvqHCCYve64jdzBYVWf989+7jifCU7uPI7LDT34NV9Xj?=
 =?iso-8859-1?Q?c8LFqmwVcbl2v6XySykGGUn2b7GKb9t8npceVuBf3apseyGJDjrp8pKvMT?=
 =?iso-8859-1?Q?izylHmmuC1tdtaXewrbN/VktQCrnlnykoWHMf7/TJM8o0MjJJzWn3PqZsU?=
 =?iso-8859-1?Q?Nue9GDtriDzpST2XzGox7EFbx3bewUO4LkugcsdICiNrbRykLvAvVq7IWO?=
 =?iso-8859-1?Q?kb6Lfi0nP+jiENJWiMz73q9pKR+cFc3Gtee0wPpcyroL71DE0GdguCaUME?=
 =?iso-8859-1?Q?fHuBT7MKyy/O1hlsNMbtj7iUQI9kpU8gLb2191Zh3nO/mlt8lBrgg0LcfN?=
 =?iso-8859-1?Q?ttOVSyJ8q8IBx5bbO/iGljLhsXfpGOkYEl3ZdSa+dr5hZ4wxr+X539w5mk?=
 =?iso-8859-1?Q?mYcUpVuoEDCnHhya5eNS/ZrW4hkCWSGDKu9S/k0RZYq5EWkPeVOtErBoWu?=
 =?iso-8859-1?Q?hmkk0nrsYv9SG/oi7AhS3YUsm1Pq08WXT0WxRoHnfzkrDCuMm9c0RuXZ5L?=
 =?iso-8859-1?Q?+NGKoGsfG5jMAJFfcaHF4NtIeSkKbBis8GuY7SWzR9tvhlJqhcRGjlhWPh?=
 =?iso-8859-1?Q?mnlyEyq2P0+wm7XhqrbIuzGnMl7inw0EjTWsAw7I6PFqy3djRuM+rEtSI7?=
 =?iso-8859-1?Q?4BygidrnP7xg3nB8JzrL4Mkv4l1CZIqwvn46AqKBSgicJq+gM7cFUsSuPM?=
 =?iso-8859-1?Q?YLcKofe8YyRGqiad+3R9NTHvKKbG7pW17py4LQpmgCMobWqESHhyP39TlM?=
 =?iso-8859-1?Q?qetEMz7bpWbQW/2jGZVf8BqSKAFuWNvFE0OLxNNVRgXKwlmrol+USFlvKh?=
 =?iso-8859-1?Q?w3li8DeYNKQDMgP5oabxayZA9vM/bTJUOJxtAbChBNCRfcfAnHGwi3034S?=
 =?iso-8859-1?Q?8yxq2EvZKgaNFVDF3SgtV4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8gFYTOzZEkLXIBazf5upL+v/eQRX8z47v7tqlkzETiDbVGCjixqIkQZGVd?=
 =?iso-8859-1?Q?9Vf80BFXpo68cORCS6OfZJgijW8P+r3zhw1j6JY8K7OX1byURINQq0N5ib?=
 =?iso-8859-1?Q?8fSGuEtcoa6lkahnleF7qWANaOcyaeHQmvZvPVo6VJeQ4JT91InyS5R/Lz?=
 =?iso-8859-1?Q?5uLLpm7gA6SkXZBngF6AccFaSc2hSwIBLuINgo12mCTh1C5Gn7wmuUhXvM?=
 =?iso-8859-1?Q?GOuWkH7nmqD3xQaF5cC9mem79p/4UtwxpE7i1DW4A7BLwVYYFMPh3FWDYs?=
 =?iso-8859-1?Q?0OuiovEAKBP1t54lG5Vx3dYkSEZUpt30RytLHYw+woqVXXBSpT0UZMDvTu?=
 =?iso-8859-1?Q?Cqc6dYqnLzfukRbo/PhLy2qEZH9BE4M+6ayX0l5FaBrC6x0FOKlFwMDXHQ?=
 =?iso-8859-1?Q?eisQVHzXtZaeIBFzrVR4PFTV3SxDaix1yOYsShbhO5gAyPUfp+cEn0IS/Y?=
 =?iso-8859-1?Q?FcNLsKfJSvigSGgNyCMUhhSh0QzoAoKrE5WOdur7jPp0+vx8eRiAjWip5E?=
 =?iso-8859-1?Q?C/bIWvx7ZWiD0vm/voCphdWWOYqGLdr+wGxpa3vSSE9T7K9yIFIoMzFA82?=
 =?iso-8859-1?Q?g22gst2rgLnqQoJURCa0Xe003vkBBsmMXTlQ/nutI9UuReA1re3IhvOhYg?=
 =?iso-8859-1?Q?mB3sK7w+OM2Gdt0h8d2UnhOR+T8xEn5IruoW0YGzPUwMlIQ17DJ4OXZ5Zh?=
 =?iso-8859-1?Q?Kh8HuNKgJLKTXV6BNcHMVOhp8YmWUWbDcQetcR6dqFMq9RJFQ0D4eFgNr7?=
 =?iso-8859-1?Q?gwAZiRVYe5nocqVnH/714wALNDHzGCig5lFybBOziO8WMEAVxjHJ7yUhQe?=
 =?iso-8859-1?Q?kHz4sQlqKewdYpvFTaI/xMCSUdhhI9DgEtvk8ThuBaBa9+eltRZVGVURQ8?=
 =?iso-8859-1?Q?cyjWBuoV+UpGh67HqmSeT2AAmYKdBKcJK9qVyjwWiCVdeqINIP2uv59TWR?=
 =?iso-8859-1?Q?thyTrrtwnndNcd0FOE1QQfshivs/BnEzatKYl/jdaBFymDdHqNP+XP+Ipb?=
 =?iso-8859-1?Q?BBPopn1bt8eeWT/QAy4ro1jy1SWVXHAySMCEXPXnQCnhrSTV24NK7I/HSF?=
 =?iso-8859-1?Q?PuZrmOMf7beYNFAFO5VwlAu1f6ltl5GSyIoBu0x2JctvOhvSRUS80jdLQR?=
 =?iso-8859-1?Q?ipxXz3/+Pvw79OEsn37il6oaQJVsrgZyGnrb09+RgvLZVkfwhsiVBFZd/c?=
 =?iso-8859-1?Q?DIVkLG+YIJ8tq3O8aV+o7a4CH0zvJ7wmMGkcTnUT7w5QVnlsx+2N6bxLKx?=
 =?iso-8859-1?Q?/YjHmGo7JxMXXPKEswb7cPkj0F24hquRk2kZO2/cwC95TZTtg5qKFilDGt?=
 =?iso-8859-1?Q?v5/welq/GOzPXkkUo7T4s+fmdKVnQ4y5Cdg0kUd1wyJVtDhOtcWn4wIaHR?=
 =?iso-8859-1?Q?AyLu/4dp+n5tC88uwa0wemAPG8RyHoIvUSfv2pV/BUtXvgm2mcRPQDKUvR?=
 =?iso-8859-1?Q?CVnnfzV8nWKdU6u7CbhL3CH27+TFHntJRCSM4jq3TLR+29W8VWd2lXfZE0?=
 =?iso-8859-1?Q?pFtcjOZFjz3Y4E1IQqWn830iY3EmQjqn2QC6DIJkFPOO1JIkCEpMa5twEE?=
 =?iso-8859-1?Q?Wfqy8qXBKdhCJZGsosBosA9EpEPB5eB8qma+zZ1HM0An0k2nin48aZzmI6?=
 =?iso-8859-1?Q?bxEwu1X+G1Dj2+Y2IcpoPu8xUCMQNOyQA0CTomZQ1MC9w9UXxka0B7uQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae3ba6-d843-4bb1-6115-08de3d62d627
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 11:53:04.4904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvILNneyd0y7G5sjzlcE14RovAdFk3Q77c1x7FkhOLGjuesHboxTSyANXuKWDLpkNDrajRUVPwWJKqfnI6iSxAS0psC/v29NS9yc1jVybFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
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

On Thu, Dec 11, 2025 at 03:22:32PM +0000, Bruce Richardson wrote:
> On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Brørup wrote:
> > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > Sent: Wednesday, 3 December 2025 15.36
> > > 
> > > Hi Morten Brørup,
> > > 
> > > From: Morten Brørup <mb@smartsharesystems.com>
> > > Sent: 03 December 2025 17:11
> > > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf, enum
> > > > ice_vsi_type type)
> > > >  		/* Source Prune */
> > > >  		if (ad->devargs.source_prune != 1) {
> > > >  			/* Disable source prune to support VRRP
> > > > -			 * when source-prune devarg is not set
> > > > +			 * when source-prune devargs is not set
> > > >  			 */
> > > >  			vsi_ctx.info.sw_flags =
> > > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > > -			vsi_ctx.info.sw_flags |=
> > > > +		} else { /* Enable Source Prune in Rx */
> > > > +			vsi_ctx.info.sw_flags =
> > > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > >  		}
> > > 
> > > This looks like a bug fix related to Source Prune?
> > > 
> > > Ans: Not exactly.
> > > Initially, Source Prune was disabled, and MAC Anti-spoof check was
> > > enabled by default. This was done by following:-
> > > Source Prune is disabled by setting local loopback with
> > > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted packets
> > > from being looped back in some circumstances.
> > > Now, MAC Anti-spoof check can be disabled by clearing both
> > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and
> > > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx loopback
> > > with
> > > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > > 
> > > As we moved to making both source prune and mac anti-spoof check
> > > disabled by default, I thought no point to set
> > > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and then
> > > clearing it to disable mac anti-spoof.
> > 
> > OK. Thank you for elaborating.
> > 
> > > 
> > > Thank you.
> > > 
> > > Regards,
> > > Anurag M
> > 
> > Note to maintainers:
> > This devarg is like the Source Prune devarg.
> > If we want to elevate these exotic features into proper Ethdev APIs, it should be done for both devargs in a separate patch.
> > 
> > Acked-by: Morten Brørup <mb@smartsharesystems.com>
> > 
> Applied to dpdk-next-net-intel.
> 
Unfortunately, this patch causes changes in the driver behaviour leading to
CI failures. These issues can be seen with testpmd where packets are
looping back inside a nic port unexpectedly. Therefore, this patch needs to
be dropped from next-net-intel.

Can you please do a new version adding the feature you require while still
keeping the existing default behaviour.  I'm going to move the patch status
from accepted to "changes requested" in patchwork, in anticipation of a new
version.

Regards,
/Bruce
