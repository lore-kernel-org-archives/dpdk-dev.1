Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB65C982DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AD0F4027C;
	Fri, 18 Sep 2026 12:14:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8D3E040276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 12:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789726462; x=1821262462;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=10SawMPTmMMHuyWP53TT+xMn83hnv24aWNOcdvpwkno=;
 b=fxeIX7A3vVgxpUJBzlKsc2vSiwWxfWfBjcGcttnWf7c35rNhaBCz6Hdz
 X8xez2iKUxqXgT5mau8vBq9YbK1LpLDCddG36qxIzCJJms5M2DI3Eausq
 jnXmWmMKUnqUzpyudlRai0sGfogHRMwr4nuD5b+y7D+JXdWniXi3c0qm/
 SgBetCoF638Xs0AMURAJV9igJ6ZqdR1TEMcJrOgHsjP5neLRbVfhVonFi
 M0ArvkFaWjn0uryBTyvWupfdi2M9NbcoZ4hyPbsxGWXU8VZXl+xOF09aL
 6icZr7+L48P+LNdWjwnCdYfXruNEWyxWoVdkMmojIicP15FOekAzkAlgc g==;
X-CSE-ConnectionGUID: ZiffJdGAQ024XLPgn+c30g==
X-CSE-MsgGUID: wJoT8AfiTryM95w/dnZfKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77785850"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77785850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:14:21 -0700
X-CSE-ConnectionGUID: cxvQMsgbRzSqOjgdVwydDA==
X-CSE-MsgGUID: gCNmzKRCTBabplJk/9+bnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270647583"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:14:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 03:14:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 03:14:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 03:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ5dvJ7WzJ9qORrHt/KZRPs/sIDzTjm5TcL29u8VmJVIyyeHv0292crc33zcps7LNB1dosZmdkmIT/7JpDjgSWOZ96Rgy3pCkocsLMJfePIdbmQvypdYHXr6c3+er71OvvlowXVa+oWHQsqKP/km3nOYGjlXuXOJBiAt4YqihuC+e9Hk/LAW4aUi38tR53Sjq7OlvpMqydfn661M97fzIErF90O/1e8bPQskAuJPKgLlQgs30/9AidolyqFG5SEFEec1ZQF8vc1dg2kuf/aB84/D8P6ZkUnJ524X9OuL2kzW4RAX9uVO53ic9w6drbCdMHoF9sNsR36+G5gBdMZ9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLllPg7IOTP+EBv2S7f5vmeQBr3DzNeRwwpLFngjAcE=;
 b=Jg2rNCiClzW7TiYDb1KeJGTXuzRdDFDHRTKkbdLIGM8u87Ru45tKMQ/QK+tCga5OlYMYpHiuvtt+Rt9WZ14Q+0URkfhG/pndEBKx1t1ViC1tXGkbnFx3C2OyO2lhpggLOkUbt1D9M4IT4t9gd55Ni4HC8QifXLuBRjTgL+dEMsAr4HQ5VSEAWetqNLu/2b/7APZ7qbphIzC+NQss9YyiIsJWb1vK0WL7m7GjoRYeglJPxyEht70oselNNnufs8OGv9z6AaJvhlzlX0A1A0R05jxZ/KQ9MSyQsVCNjh3upKcDVJ/GkDiC73/CoEe1hUS5VPQNsZ4g3pJmzOZqoG9HPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 10:14:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 10:14:11 +0000
Date: Fri, 18 Sep 2026 11:14:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] net/ice: add per-queue Tx rate limit support
Message-ID: <aq0O7pDv724p4ic0@bricha3-mobl1.ger.corp.intel.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
 <20260917063823.316379-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260917063823.316379-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZP191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 384cdda2-4ae8-4893-0cb4-08df156d955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: /rp/+UIyTCqJHoSIDnAO53NzM+4+rbzGFlKNDVWOeR/dGx85gas80ES3RewzBUIuak0Q5aK1KLDDy7VdWwhBG91jBziymIGaW7xegFJARdNEw847bLyrGt9rAisa30Hs8876oujte/OeUM40W44GzJg9Yjtz+sYs6wb78Tgntaa0veMxIKneT9dLihbXYvuyBOAITJEo9CHYpjAJAkxUdCQjdA87Xkb5nG6kWbb67R5bEUSt3y5GulUrpjo63Yxn0FL8WZ84e0Oaw7RBo/t+n+EO5n3m5vri5UtU7I93WpceaYH6YDmWnUJClE+8p6ifI51QVwr9CSmo2gJgSgxxXJ1yRuhQ9toZ/cMvR4u88cP0OeyBgGOKNTfm9AeGTQdavTFKCYhGMbml15TIfmL76omahJgkXmm6DUgaYtLADQRMwsPaqCAyRT6pVC8egAixWd4iusOOsnCuVkFxn4eGVmexDlac8OcUm92runbbksNdOOr/WDXemXk3GyexxaWPLJpW/YUQyQAjqi9IzIG3VshUcUtNq5DTJ948CEcaUVIXLmwqMD39m9foyOYY1LS3UvnSib4nKVksnpYtiCA2XJsBhVBDFoGTe71DBXH6YoyvASWezuT2pR8sK8rYgblTkcWHq2E2zb8Psp9B4AuDIXrrEFDRvHdtGahGzC5/su0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJmRm1MGQ3R1h7Ipp1/Usvv6rO3PRhREMdpqslL6LtU5w+R2bJHCkPx+1ocA?=
 =?us-ascii?Q?Asbjzi9hUfUd5WvAFKCqalt+uZh+oSY0d8inRtKXcxZRFOC5obkmKG+uvtWl?=
 =?us-ascii?Q?/ywGRcnIedFCb7EB3LZC4uP3RB5MAqZCbvgGOo84TF5NuQ9Q3/jCO8pLj3n/?=
 =?us-ascii?Q?Z4dG/Ql16U2B2Ep1GGeSXVMgiPJnhYSYsxM49JyxWEky3nKXZnUz3q6qB32E?=
 =?us-ascii?Q?zRgrcWfEAtKw0X3YHVCH8xMDRlo9QksCCUVZ0L1gaqL551sz9B676ULWqOGQ?=
 =?us-ascii?Q?1yIoIVkl1Fve6GUGXsLAzTCX73Bxgoe7hMjqFuC8iiQeplDo8drN2EouJrN0?=
 =?us-ascii?Q?QFJGRbdmxwmC43r/9iso79N/c79Lk3S2WqGEXDhUrsQqOwzNUf8PE7t72qfK?=
 =?us-ascii?Q?33c0+B4LmC8MKdSExglXBHMJUaRh1KRyUQD5dzHlr94H2srEcneSwfUy8Sb+?=
 =?us-ascii?Q?yIeKzVjCV/La86H2QAa8h7WWc5CDK0UoEdecbA81zsyCE7xq4yEUMryhLzQ5?=
 =?us-ascii?Q?ggdrzK3v1/W28BaupCF5PpUkHP4tJkXrRwtr/bIQB7y+z/W9YZX1Y7DALtGG?=
 =?us-ascii?Q?YErVYx9ItllIo2pEnnN7odF9evsmP/oMNjJcWIZj4Nz8iC02r4fzn6yeJof4?=
 =?us-ascii?Q?RvofQDWsRbYAS6uZJ6otNC3TGyy9BOsRVLW/nraXnDHyggoavvpWb7l+++WA?=
 =?us-ascii?Q?/ZidIkb3vIrxQ/pzIgw9THl0PC9K/FkJGBetz6GadQp170jRC6MjfAYKwNwi?=
 =?us-ascii?Q?zoSswDjSmZmQmTlcEgbdoeA+SO50zuEySUZyVQDPe1KfM+p3JtbTKz3eWyr0?=
 =?us-ascii?Q?9fl/KC5MGaiuo5Q6pv7V8+goHYnJTtnnOS/Ph8Zvn50y9RNz9DkuOZ7fqa/Z?=
 =?us-ascii?Q?JlsBMVVGoFnFiwoYicmh3qGFbN43fptLLg+50S0zcC/dn6q8YDSMRt0+q7v2?=
 =?us-ascii?Q?E8TG6cKy1r5RVkmyYOZxTgNzWHDaG9c+/p6j4pg0L/kj8xGvwnPFzjZkX0kb?=
 =?us-ascii?Q?4CEoOAaZOY8+szcv+NkSLBt26FIjG3oL9pTDQLDp7N4ex5wFEKQspHKIbZHJ?=
 =?us-ascii?Q?KcQoZWm+3ibxNX6BuZeBzpfeAclObdBPzF5UzpK9rtSt4N3gKIGHmy2+7lBH?=
 =?us-ascii?Q?wlJkivkLEmNJNTg2andTEf16SiIE8zfDXJKgmlclAkeKnBNLkoeR3IYkeybY?=
 =?us-ascii?Q?cPSInXpqBKzF3mifMigtoVWI9iY268k7CfTfPubT0nR+S6aetDJyqXMNqr2u?=
 =?us-ascii?Q?LDG74a0kNlLeO8zNWZE/kyx6JFSldOE5Rw2fpTwBXXGnDC5bfD9E904qY3bP?=
 =?us-ascii?Q?k9cN7fsKgmHtcQIJkSexskmW1I+uimFmkb4vaTQ5ShkGqWISQTH45Bv4zipC?=
 =?us-ascii?Q?UErEWuvCcxD59tXKVCaSeZ8bb0JeQ9KKwJJM80qZacf7qNsHQafye1pTpHww?=
 =?us-ascii?Q?7M8+U4r8vwzssxgA2pr5oA4Vo4HzvbxAUC/fn7bgKkTkoMBse1MAo356eaBN?=
 =?us-ascii?Q?VjejoiP2BONNu0F3ZQ5zZgx7EIkluIHPsDYUpe2WTiF2ddiwqmppXMj/zzcS?=
 =?us-ascii?Q?UEMrosL/DLdyM6wK1DwbBXfKEGq6vyJ3JGmztKy9/A49EYcVL09k2ljmBiqQ?=
 =?us-ascii?Q?NVFyYgMreOfq0vp/IjcH2wrRxBTy4m890EPPDB/e6pEAap7kYG9XQIXnTJdC?=
 =?us-ascii?Q?UtvKR0yU7UGwUbf2T1mR9yynCBGt0Fj1Qreb5MPowPlaNcQDS04UA+xBMlYI?=
 =?us-ascii?Q?cXEhMfklDK10X6N2DVizfhldmp9qwM8=3D?=
X-Exchange-RoutingPolicyChecked: suqoPgU1uNMVkty6N/woec9faMkgtWI6kGP7f41E8vKN9KjXsTcp+YjMNnQLx2MAxUhxxIpMbxeiPj6yqu/uWf3akdLbM1Y58qKSViQR916KN0ZlBdy4Z4bRCZ5VLRFLoDOcssX6+RcX0andXSTQUMqMrHsBGGmyt+Uhgj5zPqTNAuX42dgtCiuqDIiG8htKz+KZk4hJ4ToL/6vxCXJxR0ofiV69Mzg0MtmNK06PJvetcG3855ZJZkOXn1dDcXx+ohjAbgVUdT0bPR79sPtlYsTDmS3FP8fCL4CkOlwrDR4qlejkkuCe2risLOLpSA+z1M0vKktUGPTgm6mTjf5r0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 384cdda2-4ae8-4893-0cb4-08df156d955f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:14:11.6005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl2RSxu0lhjKiG0gBHZGK6Apn8/WVuj7ofcd9x2yMZk4v9ywCePEG/MERNJwBuXqig4dXqh5gos8xPPm8jRd7Fq3pO6TPrqsIFTBcD+vgyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
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

On Thu, Sep 17, 2026 at 06:38:23AM +0000, Anurag Mandal wrote:
> The Tx rate can be limited per queue with
> ethdev operation ``rte_eth_set_queue_rate_limit()``
> and can be read through ``rte_eth_get_queue_rate_limit()``.
> 
> This feature uses the hardware packet pacing
> mechanism to enforce a data rate on individual
> Tx queues without tearing down the queue or
> bouncing the port.
> 
> The rate is specified in Mbps.
> 
> ice_set_queue_rate_limit() applies the requested rate
> as the EIR (maximum bandwidth) limit of the queue
> scheduler node using ice_cfg_q_bw_lmt(),
> converting the Mbps value taken by the API to the Kbps
> expected by the scheduler.
> A rate of 0 removes the limit and restores the default
> bandwidth via ice_cfg_q_bw_dflt_lmt().
> 
> ice_get_queue_rate_limit() reads back the value cached
> in the queue context by the scheduler on a successful
> set, and reports 0 when the queue runs unlimited.
> 
> This interface and the Traffic Management API are
> mutually exclusive.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V2: Addressed Bruce Richardson's feedback
>  - The per-queue Tx rate limit and Traffic Management APIs are mutually  exclusive.
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce

