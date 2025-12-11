Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41225D41D57
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 500EC406FF;
	Thu, 11 Dec 2025 16:22:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A699340151
 for <dev@dpdk.org>; Thu, 11 Dec 2025 16:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765466567; x=1797002567;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8ZHz02expjbZdnzAg+679fgS0wYbLw9vnqZ7lTrz3Fo=;
 b=CVi+J6P8fTxwNTh8Wr1XcNPYWGRTrWsnZfD0xycf65rgLgIBYgntEeA6
 lLWMF//Xfmv9UJkm1dvTTcicLAiQ9+DsJ5XhnJ5mLSTUTaz8rRCYJ7Z1F
 o6Lzgi/es9OZE3EVQBAU8XOKBkuQHEuCAoo6um7pGy+OcD8Vpk5OaROxr
 mMWQSRL7DnY3fJMBwaUH0njAeJyBhguuF5xGMatZXrXpp8l4j9agD8eRC
 PZ0JRWiaLG4ky7RoJRLRNMRJ4oCG2l25pJX8AtHBXnXLXoa7lwHLlfZ63
 Tg9Vij4iEYia4WZheb4MWGDM1Xwp8nEar3smAgaZrl5bSZifhXt7+aCZW w==;
X-CSE-ConnectionGUID: Qs96LUUkQAKw8vSl7wRT/Q==
X-CSE-MsgGUID: izvtFIF6Q+Sk17rlNOln5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67490615"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="67490615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:22:45 -0800
X-CSE-ConnectionGUID: KKrfOu+VSoGu5pvhhMvAhA==
X-CSE-MsgGUID: NwXV2a0aQeKPtlnHKV/96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="227885890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:22:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:22:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 07:22:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:22:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYD/Atl7tJLz7N4Gw5TmwlvnRMM+lkA5w/KYERug/A/i9AcfpEolRJxIxXLNPCFwEry0ktV4xfvhAQO3xyUv/vkaAXSs5OWJi6oYPEubUOk7FKPpjBNdPqxEmLSKp32M85guJXNm0ghmeSOsiUAhrOLqSkzXcC3++Vt5ntHK0aVZQmP1H3WQxNahwnmJoX07P4SrI4V4LWbY+YsPIka1iuVVzVrvhy2IT2e4hPKiu5s1N5yJmyFDrzk2jM2pEAfJb1Fl/Y37pJO6nYYkr9rRURC8cVUkkHOBpX0EblBw2QE63YFwJxdENupfiFjAg86Gy008TPqZBp3FLZ/nMIA4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MErmiamCleFe8CIVtxNO2UZN+zlDYSRpwx7Tsfcq6Lk=;
 b=p/WjpYJWxcBd9u1iey9Mlf1GCUyOVN7zqy0yU29cadlserf1mLdpu82rqu971/GLfxSwOEqxe4JfJuNw/6L7uXHVxSr62wTP/gwZUD+K12xwkIrHYNBwqoo2tSac9mZOioP94Al+Ag6T8lcHYghapaK+Vy/Kpg8CHTX20iyAEfAA9seLF8Wn4YhyeRWsTQoxFIvt4+AcemYL7WLU2LgnulgguWUiGnnqI+N0ZW4DJZ+fIuN2HLC2ikWvoQZqvT6FU9hHK72j9d5xgdnUh81nIGNMlvawN1RAgvHCDGJ3Xa5LAdChC4XH2GSsOjgX3p63tYSHlH9fAFItAYPv2vsF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 15:22:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:22:37 +0000
Date: Thu, 11 Dec 2025 15:22:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, <dev@dpdk.org>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] net/ice: add MAC anti-spoof option
Message-ID: <aTrhuMI14CVK27aS@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251203104126.75935-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655B7@smartserver.smartshare.dk>
 <CY5PR11MB61160E99ADCBFDE1182D6BABE4D9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655BA@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0182.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 199e16ba-664d-45e0-d0e5-08de38c91d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kQvQWt/FJCEg+2dGLBqbLDNCQTasGv5g7hzgySloevaYUoAd+xLjVSLWAg?=
 =?iso-8859-1?Q?GtiO6GAna3Eev6rxBG0WhWxKSFBnHjZsOJ6BwPheVaq37fRp2YHao8Q2f8?=
 =?iso-8859-1?Q?tQZReikz+Zqdfg6wi4uBiVMjcPSeoRrepr7ClqryyxMt5ouWc2D0u1p0X1?=
 =?iso-8859-1?Q?hpberxYhjNsMzUFKPYe1/AReJaCHBCHfM+jqKHBC9uVjGfAuVH+k+qALFA?=
 =?iso-8859-1?Q?06sliKBcQAKUfq0CeiCjjtwIQMUB3Lh9AuRl44M7V4tVjUp7nirscT1o8k?=
 =?iso-8859-1?Q?LXIk8Jf+waEab9mtIYsgrMNJ7ex8lAgHZ+4Zwciz7BF2wTyXFrRgQUMXDW?=
 =?iso-8859-1?Q?ui+5gQ732liKNzs4B7ZfM4r6c/iQaryIKgIYlyb4qMUvUJHcYuiNKdKxbw?=
 =?iso-8859-1?Q?S+ypxNxi186lwKdHg08d5Dz42/nWc/h+3Uuskl6CjLs/SpAV1CKsXoSlKq?=
 =?iso-8859-1?Q?tt1od79ixQV+6v7PIwVZ4zKVAIhXnnDCko6HtQPebNCjNvHDIihi7gSgiC?=
 =?iso-8859-1?Q?W4O1Gi61lBLfxe0wTSpAkjra+a2cV97+4LHrKvFbt+w8QESaYlH94f5hcX?=
 =?iso-8859-1?Q?BwhCIPUHz/nfeh0b88x7PgHlSqJFB/3TgQIO4ZKdvSECutBlJS403SlQCr?=
 =?iso-8859-1?Q?Fisbi3+8QI0ZhXOWZHMGUtgCAYccw1TlHrv8rE+UGVooC4ijppAN7PyJ4D?=
 =?iso-8859-1?Q?8xowl426oCsEGoeNFWeyMdQmJUTc/1TfufRmZM0pensPpDHTp+PkmqmOs2?=
 =?iso-8859-1?Q?Wc75y+f58Xnbu0xtoFWi+MlMWtIQYubeXpNSIUNph/49hhmibqgIdBY7Dk?=
 =?iso-8859-1?Q?PJXpQlJeSV6y2VaQ4vW9LbNH3E8tpgQ9P0MrWjlsaT1iZjvRKNe/R7B4If?=
 =?iso-8859-1?Q?9/afaTQFqitMRNzcQIPyr+4C6vYfD+yR6+f1Iraqc1mnpzQxnb+g+cqMh8?=
 =?iso-8859-1?Q?1FmuM1UKUooKQ0ThspY/Dx+iKt0Wbt+VEZuWRIKAZjmw7Lyqve8D/+frRM?=
 =?iso-8859-1?Q?2iuDabpxn3qGgzplJKx/HRCvrVtaJITj14i5qNDzjk75fl+phw6NQBSoJ2?=
 =?iso-8859-1?Q?rhn0aZ2sJJxdksZlkhsA1uFgQHPwkZ/OXjNRtMniJjMryK63vxh33IEsv1?=
 =?iso-8859-1?Q?t9VabZ9ezKKfSWh6gJWagUdbNTeqtILIze/NjgaIYmgXg0gbzqOTcTXaqd?=
 =?iso-8859-1?Q?n9fn6+FF3wwnoox3nEMGkNwtLI1Yamm5LiwhM9uKRwNn/2y064wCJAQNDC?=
 =?iso-8859-1?Q?xRpvjOVvmtT0QF9UkGhcZWpxowoePTVjvo6ONpxeUG7VP1d95rse3WLjNv?=
 =?iso-8859-1?Q?6qZTYqshE3+Y5TNvdohwCT6T2d/LaPJ5hBHEUR7yaBbLGmrKHXVEePBr7z?=
 =?iso-8859-1?Q?OtmkQJj1LihJoEQ0ZnAlQkieBiRorzERth5oarr31zZkfXhOw0MuH10RVl?=
 =?iso-8859-1?Q?AmLdSytpB6IZBphUqM8oddHTVXfFoTNkqHQMyJk7ocSCvJc8PZpC9Mb4aI?=
 =?iso-8859-1?Q?K9YxfDYsT9WkKdgUUADUgy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fgR17lm+Qp3Rl7QoJtg6VborOWPezACdXCvG61mjZybP95FC7L7Qtg5EwY?=
 =?iso-8859-1?Q?JFwsnsjHcUshl+mgunnmb2nErzVFPZP726YkPhia9jFqhUBWj252rDxf8b?=
 =?iso-8859-1?Q?+YWjPpbBevrus/Y5+Lfd9++FCVrAZ+BTnIZCA44VMFNOj0HhUermy/vBdr?=
 =?iso-8859-1?Q?f8zBIJhZ3gtQEDYGQo+AOGSnEFs/QXJSsNGQ9A+LWOPTuTpFhIEsllfFod?=
 =?iso-8859-1?Q?m1dg2cbTX8XaO1cpfj0jRL6eoDnxfWtc4ja3YDVO/v9YNgvloOSosCqWii?=
 =?iso-8859-1?Q?YXm8LaHKb/O9mIdpug1NlQ3/lp68TTI5sH03OX+wqsDcUiQC6gcHmJ4n7j?=
 =?iso-8859-1?Q?FjuORhlyK14tztsdHc57IsO5PgQ/NeATiDT802XLwKwRTYmNfcTaq1kL3B?=
 =?iso-8859-1?Q?/HHBrgKUepL836L5IUgMcYRRrWlPXfY+5cn6W50kq1tNbA0eSixFT2RF9j?=
 =?iso-8859-1?Q?RxprR7rleRBnx9rZVIKvCPsHbf6svLvOFkkjIQn1ljSCMjio3WNRI9EuGL?=
 =?iso-8859-1?Q?bC+JnYu/p9naKd1HIT1yHqFKIiHbGZV6+CwJNfrZyI5t2F3HWfpcDNNJiW?=
 =?iso-8859-1?Q?Vkh0tcPqGvCkrYd4EZYs6iwp01SKPjCGmWz6UGR2NaULiYO+o7qKwcHUTT?=
 =?iso-8859-1?Q?+Fg9N+1BQCRAja+3Z1y98EWiudfhV5RFTeSuYEubWsFwfqXMDN91ev97I6?=
 =?iso-8859-1?Q?XU5K3XdDXl+RsuBO4nwqJlKhj/7RCF27+sNmSgmcur5dt5sqhYddq5LADy?=
 =?iso-8859-1?Q?XIwOY1bOW3/2wJuzLFGr7Fnm31yHw9bPftSuyXK4PdtMi3bKWbd2v7EFvU?=
 =?iso-8859-1?Q?SCdHls6D3w3N1nM294R+i9p7xZe8eNrIkBa1I4nX143irY7nuHciXJIgha?=
 =?iso-8859-1?Q?ketg5yPVy5bJcI9FCnKu65vidBZsq9WuJDFM3kGkfi2/uF1sKXDFiMbPEU?=
 =?iso-8859-1?Q?TTNQPLx5cMQe6hwGTapGLcPq2lhZykoFH8ew0MV6+cLJt3s606TyJdI+ta?=
 =?iso-8859-1?Q?lDlZUhpK001eAWX8ndO0LBero309gnc8gXOwKm15Hm2RXNuBTHHz2YPuRm?=
 =?iso-8859-1?Q?y3aJOl0bCe1+dJQNowLNbNFbCpHLWxEPXjOw6PyCXwmmb1k4NSHm3fNnIS?=
 =?iso-8859-1?Q?1/ZR2sbHwSTFR7GEIb2/g/xaOdl7RIvhOE8hIa1eW05RMZ0buLclTTV3me?=
 =?iso-8859-1?Q?kXV7spW/Np3sd44IxsVbDXtWa6ysbWZlmBlW0NOirQb9cxNcOcroR8rsFq?=
 =?iso-8859-1?Q?HWMHyXzT5M1SYd7MxeG05uimh6ww0WJpyBXe10dnZaT54J/azE5GRokj+3?=
 =?iso-8859-1?Q?o02Oz6rfPIjuqPdvqQn7/H5XNfzRqPzipAELBdl3B5sIOR0+ii/CpbQaXy?=
 =?iso-8859-1?Q?BLKKqlRsFA3zfWaVd57+r833kbbIcgMeqrzaqR21uyw/uS1Ua4cZX46MQp?=
 =?iso-8859-1?Q?6uH58kL8VtC6qVGVB7lMSmoyjGAwXUGLq+8TLtYAHqYww66aTmZKcl6+eQ?=
 =?iso-8859-1?Q?37GbUFoXebfQxA8Ujz/8XUA94dsO8qnaWSsN1D+iLd3wxe9F61i6ZRhjCj?=
 =?iso-8859-1?Q?q1M4iFju5nbHWC/GqFHCNsfp6+k2s67M00/ozroo+ap02l8K19qhzKC0O3?=
 =?iso-8859-1?Q?g4KfK1aBZteXcEoLYksizPYy0eQNUnCM93usx5YfjybRv7fIqOPkNQ2g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 199e16ba-664d-45e0-d0e5-08de38c91d87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 15:22:37.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIOWYUAiJT4heI/hSFHDhqUEH1YtVYJ5D+GBb6mEH/IzDRDhMKbL9CLJT0sYYIZ07B89YQK2Qr9iMO5W79k3xllQsr0w5QpxzGGmJdKpPQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
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

On Wed, Dec 03, 2025 at 03:47:08PM +0100, Morten Brørup wrote:
> > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > Sent: Wednesday, 3 December 2025 15.36
> > 
> > Hi Morten Brørup,
> > 
> > From: Morten Brørup <mb@smartsharesystems.com>
> > Sent: 03 December 2025 17:11
> > > @@ -1761,13 +1763,39 @@ ice_setup_vsi(struct ice_pf *pf, enum
> > > ice_vsi_type type)
> > >  		/* Source Prune */
> > >  		if (ad->devargs.source_prune != 1) {
> > >  			/* Disable source prune to support VRRP
> > > -			 * when source-prune devarg is not set
> > > +			 * when source-prune devargs is not set
> > >  			 */
> > >  			vsi_ctx.info.sw_flags =
> > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > > -			vsi_ctx.info.sw_flags |=
> > > +		} else { /* Enable Source Prune in Rx */
> > > +			vsi_ctx.info.sw_flags =
> > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > >  		}
> > 
> > This looks like a bug fix related to Source Prune?
> > 
> > Ans: Not exactly.
> > Initially, Source Prune was disabled, and MAC Anti-spoof check was
> > enabled by default. This was done by following:-
> > Source Prune is disabled by setting local loopback with
> > ICE_AQ_VSI_SW_FLAG_LOCAL_LB flag in the Rx direction.
> > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to prevent transmitted packets
> > from being looped back in some circumstances.
> > Now, MAC Anti-spoof check can be disabled by clearing both
> > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE and
> > ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF flags and setting Tx loopback
> > with
> > ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the Tx direction.
> > 
> > As we moved to making both source prune and mac anti-spoof check
> > disabled by default, I thought no point to set
> > ICE_AQ_VSI_SW_FLAG_SRC_PRUNE during source prune disable and then
> > clearing it to disable mac anti-spoof.
> 
> OK. Thank you for elaborating.
> 
> > 
> > Thank you.
> > 
> > Regards,
> > Anurag M
> 
> Note to maintainers:
> This devarg is like the Source Prune devarg.
> If we want to elevate these exotic features into proper Ethdev APIs, it should be done for both devargs in a separate patch.
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
