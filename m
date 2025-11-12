Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF077CD13DD
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 16:35:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D55402AF;
	Wed, 12 Nov 2025 17:35:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 39BCF402A0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762965321; x=1794501321;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MenYjq1TDSa9J2rfZwPWu8Gf/BpZ2qGb2YiTOAnF6/s=;
 b=IIxSllOob6q/1trSqs8rNEoHBpwRCsVXmFtLvwh9AUmVeipBAcTNtHWO
 tu71ac7QaWoTLFRhLor9EtreAK6uWW42DBcJaC+pPLOfxbyznx5EQbZXf
 FIz5wrbDlMV/KKvDVfZTAVwz+1XK4s3IKLijJ8m4JQ0+2BMYLyRuctqvR
 mcWV+V3zMUYj5FvtvpYm9OeMv21/vEdjiomzpgQNZzDMBxz+ihy6B+jpC
 oBxR6hg3lElOw4H4hVN5IaoJFRy3i+4Zk1168bhymn+H77ZQQWle86AUH
 wbybKbFRxtl5G/XosGrGHiMZodQQttc/UOS4pr9JhIi0CIhdJPwrA243s g==;
X-CSE-ConnectionGUID: EZ6aGwaxSJ2EmoJbIvi1tQ==
X-CSE-MsgGUID: yxXSI9RFRrq9dB7hQYT+UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="68883269"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="68883269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:35:20 -0800
X-CSE-ConnectionGUID: 3GvHxYc1Q0i/ubtSSQXyvg==
X-CSE-MsgGUID: k1kK7TWLRZOlQXCK9IS64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="194241434"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:35:19 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:35:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 08:35:18 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:35:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjZA5Y97P6Mu5b+nJBRNm5Hq6AqfIBs245K0gxZWOorcE6osIziFBZKj1PHrhRwwgCjIcy+Lwv/HzOSVJaW/Qnv6qhw+lWR9mVzAxyPpKGB6PNRAmAboSgXPG2qe3a0DPXyMB/8nvvt4NShTVMOCcxYAp1uhl774CsgU8+QYMruE9lP20HFRxDMX355OAODvJkfZHhhmLjQpnYRyvfR1rC99dOsY88QyCFvh+NfwLX0JF8JVtC6fxAV5yaBS1sNyFVwhLbKQVjqtND5uGhAfncABARuaFSSns8TMDixV4z14I93AFU/z0mJAf8ZANSxqwew0dajMnp7+ViUZ0UK5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMz2AVfsF192+eeiqKMfmXmO7LT9/4HhWiMG3v0Q3e8=;
 b=CkbEqmg2Vrr2TkqPDcIrp2iiF26ZROeqAjIRZYEFDm2Dejp1M+Vt8L46pIcaaPf25EeZL0E5khjyk7SRNDOpRWsH2eiPWFVg8CdHVHlpHcLlIqVNZmMtAYG6QIGshqqExR9QYmNQdjRZDEwSS2zxn0+ThnPoYQ885dkm30V89PCmkcVcLHAOlnNhPPHQvfU7RDanpAZfUEZfMruArk1GaiXcCEDzqeG+FJ7Y4mir9kLmoebo51IURoo/M4Ip0pwUHuo3p5tCkAarh/v8Lt1vI7rkwnW9bpU9Ypq3vVFYQBZtAggrasjkMK65N0hcPZW0/90tt1FjFSWGcUWUcjCMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 16:35:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:35:16 +0000
Date: Wed, 12 Nov 2025 16:35:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: ensure correct Rx path is selected
Message-ID: <aRS3QEUwTpv9dCoO@bricha3-mobl1.ger.corp.intel.com>
References: <20251112151123.3757688-1-ciara.loftus@intel.com>
 <aRSsBFlNObpHuJJG@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A1AB3C04F36867D89420428ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1AB3C04F36867D89420428ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:10:232::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb86bc7-e209-44ad-c3e3-08de2209762c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4muuWOhOTD0l/S8rfc2PCwZVINa1QCLf3jeNH767FpBbzjucNO2aGWJrBeTe?=
 =?us-ascii?Q?VASC4kD+FmAnU4jBbnDDLdhPWuhFh5hwyEu1THKH1AlWkt+EkWbrnJTTAu03?=
 =?us-ascii?Q?9Ix/nZ10U03Zpc5VGRlODQy6dJeuNes7Ae0xfBov39jmpMsuGgENQ7chEeHI?=
 =?us-ascii?Q?9iD9/Xcj62cA66bkh8Z3Uu7bYxB4LVPyR9t5ZgrpdChYtI6ijJxRoaBdBoLT?=
 =?us-ascii?Q?T5WYRKaElWmvUPea6w7Rnx8W0zU+fAE/9hwse9k8lMxcykFC61TgrmAwNnBN?=
 =?us-ascii?Q?QWANfWPrii/mSw+g1sQDaS438pHQ/xjz31woo+Y7wXYuoUEdBL8lmh9twrcn?=
 =?us-ascii?Q?uUQP53/KH9kyGro24L5fIe0sYsiz62lF29dIVyPczH08uMohQlNYxm+w/laG?=
 =?us-ascii?Q?BXcSZBmSuTfDI+5GJkfjKjDb28zl+1DEy9zB1uBTh9EzzG7H/Dzd7hJzALcK?=
 =?us-ascii?Q?QoJ7AHjZAJsXCMpoXg8kzRMThrKns9gxhLr3h94U6tDmS9HcV//+xjrmdsAA?=
 =?us-ascii?Q?nWq5ujUHVn4303ZTiVmpY3gZH4KkBpkbphz5MV8x3+k21YX1S60rfGw2uNXi?=
 =?us-ascii?Q?OFsQX/nOnAeJ7i8sjLNPeWwQdiG+8dv14i8uSFqt1Bj1u5/jcaOk/SHF2m29?=
 =?us-ascii?Q?5bJqTsWwVxwm4qfhtEpsjb5qY5dUB6XcTgQyS2rYnKEmKQA1HFLdbinDf91x?=
 =?us-ascii?Q?VC1zPB/mEs6JJT2Nh2GjD4l8nihYAUWDzuymSZXeWliWbYXT32G69vsUdRDu?=
 =?us-ascii?Q?yEby6KpkVMx37mq2qMj4JjqL6SvpCOMjhvpoUP4rs9XQBGfI9H+EqnEKIzX9?=
 =?us-ascii?Q?6/E/D49NvmpZEbzG2z/NrovHIOlIO5pvUeVU5YGTIw0BxAyfTQmxZSDjjjli?=
 =?us-ascii?Q?Ce1dQqgXa3yWrKeQwnka9NXW/AKZI0b8UMpF1FcoJPYy8y6orNeO7Y8OhBkg?=
 =?us-ascii?Q?d2RxRVcHv3hIsuX4xyVs6pbmZBbG2pXMv/I6Z+RaUDe7yEAURoEXtpZzpDgq?=
 =?us-ascii?Q?ea69wfz3aysiZjJD3rwvGX+rIZTS5etsf1Ye9FcvPj6XVT85GAzpIm2F4iaE?=
 =?us-ascii?Q?fdBU0mUhccDVYEoBnv+UGgxVMQ25lcv/Hni4KTuuqTBOtfD+SgwrDodjkEII?=
 =?us-ascii?Q?HgN9repwxTQ3q+X/eLFmppHEL45Oaowwdj8OKCec9d3syeAlSBW81ayTjHZx?=
 =?us-ascii?Q?3355Cm5046OKnZTBpJFuSxIvTu2lgCWPf7iSiQW+Ap4e9lzGoFAq0UjI7koe?=
 =?us-ascii?Q?EkwwichI5C18AWX/r9DzG+6mQ7AAEtN0DjZLUS9GpWc9QfBvZxfX6i0Z/W+B?=
 =?us-ascii?Q?HRNQ7IqRkm2GCpfrZ9qbTnyveDokcEaD7YkaAr2jkWooDJ1ILpfZWBX3gyIt?=
 =?us-ascii?Q?u+RA5wrt+Ae2jrW4qEktGk/FQ0RB9D2ZpO0vLUm4UVDNLG4O0pkcSri9nyR2?=
 =?us-ascii?Q?xvq95bbRs/bI6FgWDg6+1LZ/Yfe06Tle?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4bRoYE2cwnl3UehTJo2oh6hwWprgNIFkabUekA7sMagzRR8lOnMeZhKzeRb?=
 =?us-ascii?Q?57kTtqkteNdR47s3gkLEV3ryUFCt9yO3tJQcSplMdZYDvxTYpvSwariTQmv1?=
 =?us-ascii?Q?rXTzUqptGcAyUDZzcECa58tSz38Fb/ypMI9MZ+s20XJaJ4TvU6QoOCMWhkLd?=
 =?us-ascii?Q?dGqfVM3rPout442qqf+eSQaZNiG6sUJ706+IHZyhQNFwKl1fAc005NIiA+bx?=
 =?us-ascii?Q?+s3c4FFYJGwL86jLfzmqoHzwkwev4eHnr161cNLGvd97LZYVLR+gsq96CxvC?=
 =?us-ascii?Q?bNhBKOXXW0g/Z+LtEawbVRqQuzF2VGCSNbNCrkl11AfkzSXocGxTj89NqT9u?=
 =?us-ascii?Q?FBj1m6GfW8jw8++hf1FqURstB4goJWUCkVhiL2TTwdH1t3RjeeXcSkNfEvYX?=
 =?us-ascii?Q?amrCYjHIqmGhbBR+wgBG/1oAtCdZqtvtxkbxU44/5EHfiRjx9Y13gkWBgaFb?=
 =?us-ascii?Q?yYeTMmC77xeuoQ+drzPYleFgtKAp23FoJGu9fvNtUEvK30fus/JMN8C5fHIM?=
 =?us-ascii?Q?CPfzNXXGrv+IqMODDBY6VLq1kIyEmQ7EZSnP3tmaAr+ZBkzb99seDD6WSWwZ?=
 =?us-ascii?Q?KlSeHnNR/ghv1P6WFPW1iovSAWwW5DuC+mIfVqcddmoEUdNVOy6s3USam2dw?=
 =?us-ascii?Q?NA5LwoMdjnzPbraQGH3joIcB+HpMhllLCpt3YdWdQ+jO2ZzyBjrdYKO4A8rV?=
 =?us-ascii?Q?7shSa5Wo5F4Llw4l+/434ZwJGJeSVJqom5FjEz2dRu18hY0PqbNHalYZdIfK?=
 =?us-ascii?Q?NNArb195BbJVjfvU1J+wkLcLDHpLNiHX/UfdyYpfuQucR3I5rayix7F/rNT5?=
 =?us-ascii?Q?ChUR+Fq7lTus5A4iBmM/0qkmoDQ0+F/ShdLHD3kSc/Gkg7+GiCQcHI1XwZsq?=
 =?us-ascii?Q?LBMiA0qqJmKtA3rpReCUfyqoILU+Dk2ujlLUy2aRKEKRp/wUQJocjc6MwNMz?=
 =?us-ascii?Q?dv+I7ncqHfuSs7/9FVMiXHwItBDUZtmXoslSaaThvv2eTdWjIff5ayjZXD42?=
 =?us-ascii?Q?x17fe2uyAUqUcvWwd/LleEXSSm3UtI4sfxpykDsFUVVd4sco75sY/rnJ+3it?=
 =?us-ascii?Q?kkWuEYsFT+s8prKq5lsk70MdGDyQ7+UhFpsEteIRqMX+1KAENRm3b4af8QV+?=
 =?us-ascii?Q?ch6bkwkyXu8wy23fD19pseN4DZIY9RfDfe8s5mwHLtesNJziEA+mPlrNDo9P?=
 =?us-ascii?Q?8yw36AqnEfqpR0U46zb1u6VgbQr23XNFA6bOsOZ5o23DZZtMaTcoXMGtZLNK?=
 =?us-ascii?Q?2MGgLSB8zokeXGO3LO++L+omvVulRZJO1+/jHhEssN85j9bdIyUsjgYycwn/?=
 =?us-ascii?Q?2vSe0VLoTUE62Im/JY+ESbivzK8U4XmoSa+OHlWrOdgFsEhNfX7WcpuTYPik?=
 =?us-ascii?Q?tO/6+RIJ0RFV5y0aicI+WsxlF+w2WuV5lFV/rsG1vqINBSSXLEIIrwAZuT38?=
 =?us-ascii?Q?JMYna7Hx7xLJLy9w80/crbEUjTI08ETra0FFD8trUv5KTZXxYWtLAhJzGkvj?=
 =?us-ascii?Q?644AbDrLDmv9BhC9x7HAOaXMYZRCtBEapbmsnJrrX6FuDnop/y+yjUy+SJ1W?=
 =?us-ascii?Q?xG1aXDW0wcy7PFwFgT6TD6/VMYqEyrCU+GeluJkQuNh7tt8lWeXDClE3XQWE?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb86bc7-e209-44ad-c3e3-08de2209762c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:35:16.8163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHJfqxoLjN9oOFsuDEHz1/rsxwbmX7pPGko6Kaf9Gmqc0zEV1Wq04K6pLGrobSMwoAhPoDbJl6A6t1IWCrpRpXeuUQbyHgH9u1or1vd49zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
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

On Wed, Nov 12, 2025 at 03:52:59PM +0000, Loftus, Ciara wrote:
> > 
> > On Wed, Nov 12, 2025 at 03:11:23PM +0000, Ciara Loftus wrote:
> > > The common rx path selection logic iterates through an array of
> > > candidate paths and selects the best fit for the requested features.
> > > Currently, in the event that two potential candidates are identified,
> > > the one with the fewer offloads (and thus less complex path) is
> > > selected. However this is not correct, because if the path with more
> > > offloads has a greater SIMD width, that should be chosen. This commit
> > > reworks the logic so that the number of offloads is only taken into
> > > consideration when choosing between two paths with the same SIMD
> > width.
> > >
> > > Since the paths arrays are ordered from lowest SIMD width to highest,
> > > and vector paths tend to have fewer offloads enabled than scalar paths,
> > > "new" candidate paths with greater SIMDs widths tended to have fewer or
> > > equal offloads than the "current" candidate paths and thus were
> > > correctly accepted as the best candidate. For this reason the incorrect
> > > logic did not cause any incorrect path selections in practise.
> > >
> > > Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path
> > selection")
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 

Applied to dpdk-next-net-intel.

Thanks.

/Bruce
