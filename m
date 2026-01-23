Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E34DD74EC2
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 12:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 492F34028D;
	Fri, 23 Jan 2026 13:54:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3E65D4026F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 13:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769172848; x=1800708848;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qMvyx1CLWkGxxVfmphwTojYHCWOEJAlWGejXmn7lQGA=;
 b=b8vSVIYunDVPyK00pb+a2jv2AM0bCxDmkxaF6cegS+c/0qX3xIwtbKZE
 jsDm+hyAb6q//LCzW7FmWmg2nCXmkVQy2hewQ3AAphgU4wkN6MdCCMdPG
 M5mqb861R7h96C7Aqt3g5Sbqs1DYJA2x471QBHzTAc/ffAalaohPjseK0
 sB9R7pKW12ylqX9sYw1wEF6E7PHG18aCHlY9CV8YVF0skH4T/R+TRNIZ+
 GKJOswWtB2zjZw86znF5AhJqOMuCynlu2/UPK+7wozxkEHduOH+VYo+GL
 030cts5q/Qi4EPjRHgDFcXajFoWpkTuxDdr2FMZgAu+0esErFtKhlOPUi g==;
X-CSE-ConnectionGUID: ERVIr9VGQb2I68/ro3Cdhg==
X-CSE-MsgGUID: 7HU00y7yTOugl1NB2vNFdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81536417"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="81536417"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:54:07 -0800
X-CSE-ConnectionGUID: BCKnAt/ATqigd2MbLb5fpA==
X-CSE-MsgGUID: +cmjU3aBQ66Ai2VHXBMu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207442871"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 04:54:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:54:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 04:54:05 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 04:54:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJl1jt3BTAAbXkRwjideRHwWcAYnMJxJYeB+Twg75ZRECL6p7sudbxGy3nmvtuxj7gWm10kbmafgio70/tF2xCCpCmuDJw4fdW2YGzMJiz3OCPYo4ZEL5JsfhQGavW22ji1HlW+tOQVZuuDsF+2BF+iYNVKcqxeMk/dYHOsAWwNAH3M44XHWA16aD7MBkIir3YhV0rv3AENLRGyyxo2vKCezML1NirPIoqsyq5ccfvyAUOmAwfwYDFI3jTnX/YdV3waHRExho4QaijLpp9YUgqj/z3TBhnWPFR/6DPYr1n5eCoxFpFVUnsWzl3YgtDK+m2eBFGX8ENXDlmlh/ZTYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhGl5G+vwKfWc1JmvlT4fUJ6ysbJCNxEmmrqUmSSQgI=;
 b=yr0tUJiN4jWg5ocyhr4qyJtOArn0yCjk4mBueFm6AlLdPLl13C/m1Y/6KS3c8r+FATMTWyL+gdxiPOl2pWNIDzG4tqk/tjAMvOwCINwIkbGKxQV9H+6az5HHBfzSLtPhxTyPm7F+0Z/K9Hii4iFZrRh3i5tTcZSx3I8MuKupWJCDqJC7zCdHJbX7ouxqk6h4uHxiSyf5JMjENnKVcc8jz6RwDWg6ovOUlF3nmLsiVW1v4pT52Hi6U4kdospLp+ub3Z+BlYonPOjJBGy/iy0SayGjoCUVsIspAfLZ9wPlyqT2OLWLRVZPq2YW6aJqWYYikgomGeKoqbcWK7BZ/LuSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 12:54:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 12:54:03 +0000
Date: Fri, 23 Jan 2026 12:53:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: optimize for fast-free hint
Message-ID: <aXNvZr89NmNuxy9W@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <20260123112032.2174361-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65694@smartserver.smartshare.dk>
 <aXNk6DRHvzH1WuK7@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65695@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65695@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0311.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfdf1eb-2045-4258-9f04-08de5a7e7c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?DM7mef4aQANXUV6rcUCma8HGHj9I1z1RV8Xudi8fLv+efirnaeiZDs8Oj2?=
 =?iso-8859-1?Q?Z2TiAPK45Ta1M1v1MsycC8IqF0xBrpT9DiYofZhvXm0sVaYwsAEKe/P5Vk?=
 =?iso-8859-1?Q?M9eHmwogpRvD8Yu1WaHgeqxZ73lwN6TXIRuyaTJQiyggLmU8kTHC1D0wUe?=
 =?iso-8859-1?Q?f9ZWU2Rb8B5Nc2vOWGrqvCbiquIqsmBRWqfOU28rHf9IJt8urh8pXEhrms?=
 =?iso-8859-1?Q?lm41aYMioUSybxWdz6LVmGn2Tnp7E5VW5TrA+ydpdK1RU/Iyhs83R/Uy8N?=
 =?iso-8859-1?Q?/2L5B43Ku/Vnm6FV1W0Ln3v9Nvkh06DPflMZyYgyl11o61RZMsbtWYPyRs?=
 =?iso-8859-1?Q?Pk7avAJsHJcoHgyKeLsns0MZ2EPmha45pIHhrpzwB6nGycODCTNRX5X5Y2?=
 =?iso-8859-1?Q?2GHvyT0Pz2PRh312u4cQTNdOHi6tIxW95TxuO3xeN0Nn7xUxWOyQ/w8znO?=
 =?iso-8859-1?Q?xiiRNc8NfCd75WCJpSP3O23bz7HoQj4+vLDALYV6MpE0w7k51WUz7ycbpC?=
 =?iso-8859-1?Q?A+52UUnz28At1j7IbzzOs2uWPylB8Zs9QS4j742yPYcW58BkPSV4EeYIOI?=
 =?iso-8859-1?Q?EqzvY8RNxDPE3DMJvqqK2NfEXy8t4e/qQaH7OMQWtypB87NCkMmfra8uGf?=
 =?iso-8859-1?Q?2LmZorSpblnsYYgXMgjUJ5bhwqrgIrWJkpIbbN+oddLy/GM1KQ7cZMi78o?=
 =?iso-8859-1?Q?RUSd63kalC4+QemFwNedWpHWbYxtWRDJGiCVLaalMipQ0ncr5wB20ulZ1N?=
 =?iso-8859-1?Q?OOwn8JYiiVASHRjmf77fIx1ZoeQrbc4mbt+uh58pLcSU3QpzGfVoW8znDe?=
 =?iso-8859-1?Q?7R/ypnyIaWSnG6jOQLkV4LoW1oQxhjVcLHePdd0BFzp86mpkXh3PDbdhbD?=
 =?iso-8859-1?Q?6qSFpinkM2giADiTYXF5Zre6elXVES4FE17Al0mJubQ5cT2DosIPrb/m0W?=
 =?iso-8859-1?Q?ITNHYAgsh3aJUqTgyRBT5YgWSsFyZNA/dQSjsWPqhwYDGVAEYWeQXAt4d+?=
 =?iso-8859-1?Q?DOpaln/qDrtEhNnLj1tngn5iSubKuVIe1Iu07jz2N0VA8rxsCm2/GkjFIW?=
 =?iso-8859-1?Q?9BEQmT6pgrbkNJyMyw9a9vuFnD1NkEIuPty52/c70Z5mAZk6kOqc0RXK7X?=
 =?iso-8859-1?Q?VwwN1JoVhdn1ZBt+3u4fhSEjDqRHcnuFwNyIk36rpVGkPOjKCdBBEF2Zjy?=
 =?iso-8859-1?Q?PDYlh2jzOWSNHAPV9zxxTTOfIe4MBahS3Qh0cQdP/Kpv4m4ZJ9lbf2OWLw?=
 =?iso-8859-1?Q?3kUHQO5g9JWj9iU+cu9gL9Re+gorvELbeSwzm0RHWB8QYanegG/8TaILbD?=
 =?iso-8859-1?Q?pZMJ3C34GAW9fEfwrfGLKb1yQRUFOrZRZihSE1zKJd4VsoNH99MX0UQpvg?=
 =?iso-8859-1?Q?fNn1sJiu14hEoDY/2tDL8K+3qHhefJofZRYWblbZXEhkKOPr62UZPTVbKR?=
 =?iso-8859-1?Q?1ZF0yHkWYgAAGpNlQpS9UfwWujYp4c7fmjgn684pPsDCgzxWNa11aapBXy?=
 =?iso-8859-1?Q?tiDJB1y5ZAyFTiPB+quQCme2cgorRsbgdvNgOuV4vTLwlMOMRofFDXlfNw?=
 =?iso-8859-1?Q?10RKECW9HZmwvzPCu/BAaWVZS1sERFL2s+/5evYlTVj2/Amb/Kr8R6AlyO?=
 =?iso-8859-1?Q?fzF3KLd2w+OU8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0bPKx9AXuhUKZjIZmA7ST8wjnIUSYsObdbvk3kQ1e6fD0OFM5YFvA1MVj+?=
 =?iso-8859-1?Q?qLLFNyY+QBdUK3asmd+1lXAULuSzR4ae3dWH+5BtI2GNDGa42Yy7QPDT9p?=
 =?iso-8859-1?Q?Y2kuEiDhz827BB/WHdvn4XOQRkuM7EkM+fgnzz0PqUgvTuWc4P+XNohtXv?=
 =?iso-8859-1?Q?rkXrrb4MOPNHy8O/5/xFai6cX6qx4boZ1Jsl3/oQomIg0Kn7izSdN/s6G/?=
 =?iso-8859-1?Q?h7NEJXFdk0FtKnGojbiP0naRqUOCy5r4dYqUK1h0xUq5i7V2T/urWja/ai?=
 =?iso-8859-1?Q?5L4RsT/CDGQ0Khsaa59Kp4cWg5BVpX0KYmICIa87lirYBboluBn7o1wWTj?=
 =?iso-8859-1?Q?fMxEsmTmEnIFMTG+EnChovpBPGVpQy1e2JRPWc/nSrbbysWCJtJTCn3LI0?=
 =?iso-8859-1?Q?RVEz1slZiHGBuKdWbouh++cPnDu1KjoA+1ErSVslkOVesg2sOYciM0+Zyd?=
 =?iso-8859-1?Q?eXLnrIKc1S5CAYYwcaEquOxHX6VTsntbZqIKn24CbpeMLumW9hTR9ttkZY?=
 =?iso-8859-1?Q?5WPniEv005rG7E+oFIQcBm52+YN9152sMi7vSemS0JW2rlc2OBdD8JoRKu?=
 =?iso-8859-1?Q?yEkVD7k0jxnSuNWTNMkV7Rfu80boM6tCO7bZcRSoOfsIMMvgNAnEubpT+3?=
 =?iso-8859-1?Q?esIBKGvIlWTE4uTCbik2zzijnmBR7yZ1nX+XiiRWcBiLmUgSZ7gDhyqaAE?=
 =?iso-8859-1?Q?WzY8hDxpQOKEMp4fokL85O73QMQ1XDfWqbU7mbiFFjVjtNG5tZBK68GAuu?=
 =?iso-8859-1?Q?ltxycASHBBYnRMkZ0axk/L4cmQ82E2truQ6R2cew6vfYLV+F8rBIDzH/cT?=
 =?iso-8859-1?Q?smCMgZbCGoX0noW9ahW9MAyWUZwsQT77iXyJ/Vh7Qfc3E4mQ/eZML7sbHY?=
 =?iso-8859-1?Q?gD88OpJCXwX5CxVSjHhda7Yzgz539AtR7vVeFNYt9gIUU82bo2tJhVJCUF?=
 =?iso-8859-1?Q?JTYAFg58obHmcFVQN7kzEKXJaVVGydkRygvU/r63KTIkX+aRPsDb/Sr5Kg?=
 =?iso-8859-1?Q?jPhW+F+COw/kxyoZyTySRIIRKFMO6J9g1mCMJOh86ykNb13WK5/o6RlLqU?=
 =?iso-8859-1?Q?XlHUMCTKDtozDHqaY3eyVdHxb2jc3Uezr1Ek+ygFo7pMF/G40U/kfnor7H?=
 =?iso-8859-1?Q?Q6pdcnAqFuq97ahf0F7/vHss+dlKuo6Kqc6LoWb7jukClHgN34kAk3Ktw7?=
 =?iso-8859-1?Q?ie5pEHxVaUeUiaJBGsy2/I4Bzz76W/3cX7M5jK6pYhiV1GlATdKr4IDQOb?=
 =?iso-8859-1?Q?JrGxJ1ZQio6NU1OMam3mOQnYsk86vIDKki3c1qsbBcXiN58napeWObUj4d?=
 =?iso-8859-1?Q?8PUt2N3UEg+xC7Qtayb6ba/J3rspYoQA7G5kcQ3BkmDWHDL8EBenZbXSq3?=
 =?iso-8859-1?Q?Lg9D1THyjyg/DWraZ2SVrA68nmjfhGT9jZiG6eXEWS3XnPZsTvW/A+bGAT?=
 =?iso-8859-1?Q?rRhWxJkKzD2jBD5vtOe9xtzqnIHbaUNXcrbTEPuJMTIflMztwjGELtM4sp?=
 =?iso-8859-1?Q?XmFzSI3mUDJTWzzE1ViV86HqKX6kV5pm4iufkZxy6XiQbu3jGGcODkguI5?=
 =?iso-8859-1?Q?JgBqGAfDQ/q0bd2v7dgawv+aIv4X6blIZlagvYvCGh9O+d+l6Hlipf0KEg?=
 =?iso-8859-1?Q?TRkqzlGtkIiaFsUeuRpbL5pWwR6DYatlrwcb3xKm7Ew2CihL7vF4AluyeP?=
 =?iso-8859-1?Q?PRunrvLjw0aZbl7hoi4brdAFZCuPp/UbFbiFHwL2lIxVi9a6bhtyxlyGaW?=
 =?iso-8859-1?Q?f2dmG1qLwN+SHg05ADjW+uCVsUEuXUiWZxo6fQuvW34PCT/8Eth/yyP5Fv?=
 =?iso-8859-1?Q?Xd3B3gYLHrEsKff20lYTDyjsD4Z3wAU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfdf1eb-2045-4258-9f04-08de5a7e7c4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:54:03.3706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc5jpyTNHHOk4LVP4kqq2wHAsBiuzGJ2DiDJkeFPR5cqwXROOzvyIeB7nGuzpfTbM4NhoS2MyCQK0axb7IuawMSwCYyfpgm4fMo7qFsBhgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
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

On Fri, Jan 23, 2026 at 01:27:54PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 23 January 2026 13.09
> > 
> > On Fri, Jan 23, 2026 at 01:05:10PM +0100, Morten Brørup wrote:
> > > I haven't looked into the details yet, but have a quick question
> > inline below.
> > >
> > > > @@ -345,12 +345,20 @@ ci_txq_release_all_mbufs(struct ci_tx_queue
> > *txq,
> > > > bool use_ctx)
> > > >  		return;
> > > >
> > > >  	if (!txq->vector_tx) {
> > > > -		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
> > > > -			if (txq->sw_ring[i].mbuf != NULL) {
> > >
> > > You changed this loop to only operate on not-yet-cleaned descriptors.
> > >
> > > Here comes the first part of my question:
> > > You removed the NULL check for txq->sw_ring[i].mbuf, thereby assuming
> > that it is never NULL for not-yet-cleaned descriptors.
> > >
> > 
> > Good point, I was quite focused on making this block and the vector
> > block
> > the same, I forgot that we can have NULL pointers for context
> > descriptors.
> > That was a silly mistake (and AI never caught it for me either.)
> > 
> > > > +		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail -
> > > > 1). */
> > > > +		const uint16_t start = (txq->last_desc_cleaned + 1) % txq-
> > > > >nb_tx_desc;
> > > > +		const uint16_t nb_desc = txq->nb_tx_desc;
> > > > +		const uint16_t end = txq->tx_tail;
> > > > +
> > > > +		uint16_t i = start;
> 
> Suggest getting rid of "start"; it is only used for initializing "i".
> 

Not sure it's worth doing. I quite like having an explicit start and end
values for clarity.

> > > > +		if (end < i) {
> > > > +			for (; i < nb_desc; i++)
> > > >  				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > > > -				txq->sw_ring[i].mbuf = NULL;
> > > > -			}
> > > > +			i = 0;
> > > >  		}
> > > > +		for (; i < end; i++)
> > > > +			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > > > +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
> 
> Consider also splitting this memset() into two, one for each of the two for loops.
> Then you might need to keep "start" and make it non-const. :-)
> 

Don't see the point of that. The memset just zeros the whole array,
ignoring wraparound so no point in doing two memsets when one will do.

> > > >  		return; }
> 
> Or just keep the original version, looping over all descriptors.
> 

The reason for this whole change is that after the refactor the old code
was wrong.

The original code used the fact that all mbuf pointers were zereod or
overwritten after being freed, but that no longer applies, because we free
the mbufs in bulk after we check the dd bits, rather than doing so
individually later immediately before reuse.  Instead, in both the datapath
and this release path, we must use the index values to track what mbuf
entries are valid or invalid. (We go from having two states, NULL or
non-NULL, to 3; invalid i.e. freed or NULL, valid-NULL i.e. in slot used by
context descriptor, valid-non-NULL i.e. a pointer to a not-yet-cleaned-up
mbuf).

/Bruce
