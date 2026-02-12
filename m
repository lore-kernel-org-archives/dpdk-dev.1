Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16EAEE36AE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14884025F;
	Thu, 12 Feb 2026 18:13:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 917D140041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916412; x=1802452412;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2E8ienG6SedgqlfX/95do8Nmd5YNEt2povzFHe52V10=;
 b=m7D9M5Ceb6Hd3DVxoz1nWvk17j28/BPtqo/uQqUttSjQAm1C4LZBsJYC
 NfP2Ql5tqkAME7aykSn6aRBtjgG86ifSJqammq3IEdnh/xqwmOVSGQQSb
 5Gleulgi0/Br8FwEXWgbCvCfxGMxtJiPZhKmfmDiN9PAv1nVy1UAFlzKM
 KqVrCw6tuL9m6OBxVzVBcO85D/vE9+nnSUP4o9Ns/zffxliabZ+9O09bu
 9eFDVjWn2Ntqw1v0Rl2JlIedh2Kl33sUOLDDUt/ddz2MbgexpJnvj4u+f
 cCHCucYJ4KFc8o7Ifgo/yYyOo3jww2JMC0aUI9qHfNbM5DlqoQfVkknsC g==;
X-CSE-ConnectionGUID: l6fVxzU5TI2SZZ6uP+GMLQ==
X-CSE-MsgGUID: B6GSJe5ZRLqedVzEexmc/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82733980"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="82733980"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:13:31 -0800
X-CSE-ConnectionGUID: +bQ2kZrMR4qz+YsEWvttpg==
X-CSE-MsgGUID: /11uG6ILToa9d/7mzbNUQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="250343056"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:13:30 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:13:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:13:30 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:13:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auNmBzvySYifV4C08FGIV6fvtm+4Ayl9XE6KdoX0EiSgw3IjaJmtU2vNAgakqOnYZeZ4izHdf+GQ7fTcAHxKlMD4vOH1ZsDjBez+Oh9tyIfSGvdVKxxUdKtnqTgK1JC1RVFLHZ059Nrbql5P/EDYOl/VAw7OahBlL6f7OhqYaQj/Gy9jPnXF6R9rHsD/z1ALWnNb/OvriIOitqZ2WK7e4IHLhwN9buMDYcmXkuXeHLQ4xpXRrmEnviZkfcM6kwxN+G7oFY5qL5fyE6mMbtIkPdsn9fKX5gZ8mGY1SnbRYRO/LMJmCk9phEi/PIUqlfQmjEvyvWAPLs5JvELbQdy3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV1aj1zc4u7pPt1IfyRVLVvMMcXK/Ig64kEKXBKRa08=;
 b=EkhZnnSTXGeOz5b4QYkwhu036Q0pt/LI1WUj/+YgygMJKV6Liho7vYBHnb5BYiUJZjqQl14WtwZFrkmqG5ayEL6PE8tWpjILxvsCYdvKh6CIWSyyEKxxdGR9G+QbmrR7Osd/4F3+z4dZkHqa6iFlRuQq6sn83467h01ftmhlh9SMDSzVPpa1vupySH2m3gdsPm2KHaoHVNGEKfKdR6e1PdbkUiWt9Ks72X4GbkIvKNmGAaYKw+jVmAjmVOoFIP1TZ+z49p3hXuLBK4KUJV+RzwOZsA72cUUepil7thge4x7oH6yJFM6Bq5sF5bTgDML/XtntretMVDvkuX9iyRJ0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:13:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:13:26 +0000
Date: Thu, 12 Feb 2026 17:13:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Radu
 Nicolau" <radu.nicolau@intel.com>, Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH v5 03/12] net/ixgbe: fix potential null dereference in
 IPsec
Message-ID: <aY4KMc-M6hZaqrjx@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <af139585d9da1c0211d9e4d7926260f83b216b3e.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af139585d9da1c0211d9e4d7926260f83b216b3e.1770900758.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae30363-cb3c-471d-72ca-08de6a5a0931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d5SDqJ7Gh7+trT5H2gP/R5nRV5vh+FJr8pCAUvmgv4yZjDdEFRWiMRm1ZKcl?=
 =?us-ascii?Q?XbTNVeAezcKjXJhG8mcfQ9KiJU3Gwdvs1kYuXj1lOs/VAG+BOu1x+8Fuz54/?=
 =?us-ascii?Q?Hu3B4T4I+mfOhF4qfzYq925oFGyg9E3yBNn46XoYyp8IQP6y8qb6H2hm5tfU?=
 =?us-ascii?Q?421GzECm+1i0I2DGTsZUmO0j5bcCEgEGaSP0XIvAiSIS3cRSwTJlIQesOoKb?=
 =?us-ascii?Q?O/gtCNvpo8aWjB1N0GvQIqPKyIdAC+CQFzLg8qZesnzThyQk+FsWIEE97egj?=
 =?us-ascii?Q?BcMTpgVKWC/LomWZcSVpbbN7dIBhNbssdtyAnWivwW5gNQoPs8kojrefyPHP?=
 =?us-ascii?Q?q3c01prUghgAw/3bsrxtvTlF6vjgM/Gm0YWM6BJRkoT5Uigv9o+dzAXgXIO/?=
 =?us-ascii?Q?M4y+qqWy3Ion7/2rrGRo6KJvT/uuKfPp+NEiJP1olkYTiHtPVllLHjt7Q7Bt?=
 =?us-ascii?Q?Z84Mfu4/HYFQk9qv3FFqkz/XE89p/WHXJ+yoOxWM0o5w1orUP60axkm6UMLs?=
 =?us-ascii?Q?55hJCp7csUJt1fvyG/vXS9DjBLHwkR7Ka4uxdqTeQ7vL7Wiejj3d9c1qqs2y?=
 =?us-ascii?Q?qOHK1nYayxNq+8aH7Gx+cQRRRvL3xXWukYT5nGcOJagPrm9JQhXFb3VEhCeQ?=
 =?us-ascii?Q?+x7PZY45U97HYFWgAwpqM/l4ilMStn+Sr+He8jsJXu8tYpkc2nZNWctiyJXt?=
 =?us-ascii?Q?4o8nqdXgy06H3qQds6CKYf1H7YOjnnGhQ7HCBIlHsnj5fq+3vI3JrwAepIl3?=
 =?us-ascii?Q?lhaOG3h6d3/9SocS9AxvYk/Nx7U10qp6NK4Lw0WGLlEWZYDTgLTiX5yuxIcL?=
 =?us-ascii?Q?Sbn5Dl/fmuoQr9Bwpd0e37acJZ3z7Ba9m7p8gGSYqvVdcXiuJSdef7+9aUD7?=
 =?us-ascii?Q?IhBu4CohzGcqHBIw3PFEAmLiUkPgDYtnwqWpoQvnnWFNIs2Y3JC0rTQZbWnG?=
 =?us-ascii?Q?rIo1eztg2f9F+9O/O5amqVa4i1dMJmwo4QSE6ihw3WmdWClCDBn7pseh1S2a?=
 =?us-ascii?Q?NSJX+TBtx+Ll9nu34rOuhclXPIN1F3A7c0L6JwNU2z7n63iV6v7x8DbpRn7S?=
 =?us-ascii?Q?Bjbzj7Sz3CgYknoybW3+ZKT4CZTZoRJsAWwm7+Ykqngp+QHkX8qNY/HttVQn?=
 =?us-ascii?Q?7Olwc7BsQ5In/ceXpG2Q2qiRzWNsDRt8QSobNqEERjJMdyTQD43G7+BhwmqV?=
 =?us-ascii?Q?QHBtcuhCjN8AFZyVcfvRExAikWeAW492X8vrvZePPCKUuTWSC1sLELNsvwRI?=
 =?us-ascii?Q?gyZ7JYyi9hAtkeBwpgAcBVfdNxUPaC0fihP2I0WkVn842cxUodizRTabopUZ?=
 =?us-ascii?Q?CAJPDX9H92cSRcp8+kyQiY3hwYhcTNEffomdLgVS+TNbCLvMp3SdaNJXnHMK?=
 =?us-ascii?Q?nk6Hpo40De+s3IEK3qQVa3SKot3RWqUeebp01tCG1rsWNPZuimGGAhFpFQK3?=
 =?us-ascii?Q?gtNn0Ttuwj9n8Z21qfI3+YZlsnio8Zzm/ivJlWJtBRfQJQA1hdW+1U8G7mgw?=
 =?us-ascii?Q?0a/1atACTvA8X9hiDD8oNPoFiWjL1mRAATkRKxwaEUiSioSvnAt4QITUoFdf?=
 =?us-ascii?Q?IQ7c7rKpXRtwagQVFwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckgaGmzqO78s1zzWsAdnOnpdS7qHMkHLM41AV87d62qV1jKqVncN0T8oqN4j?=
 =?us-ascii?Q?JATHpDJu86NDvTQ+fRFHCQSKd514UeJwEDZz/62obXHHaBAL4NFlPXi1Un3B?=
 =?us-ascii?Q?BETS6SEUlmpNAe1+OJkuxMyHgvvKIVfPs8YxmGOugZpWbomPymuHmHKgTr/V?=
 =?us-ascii?Q?uqMFErVvYoOUZbMJ999SiGL+taVOuob5mnzhzC5XdBSwSN4WE/lQu3Rl26iG?=
 =?us-ascii?Q?FvVplMUmEkiCfDm8095Qhif3AVVQPPiUAF2lPlXFxrHF/n274fPcKwrRM/Iu?=
 =?us-ascii?Q?s8SvdVWqx1JXOFB6chhBIHJYGdgxt8tMquIB6hSZMKENVV3/ZIOnL3bX5bOx?=
 =?us-ascii?Q?YEjHcB3K8I7LYMv4jAZ4XN+0CvWhJxc+FLo8o479AvP18YgSDP6Ev0GM3DUc?=
 =?us-ascii?Q?rDBaKR5p9SNxEsf+2/GDTV+t556kXiJjYstrYMR+DZ3e+TtE76/J4bfWbFd3?=
 =?us-ascii?Q?plZDSxFsVcBFmVzt4u4CWrqax0bMi+7nfzhzW87F7cegu9yzTL/ro1E3HLE6?=
 =?us-ascii?Q?SMP96zG8TCX+RE77XgxUlGPYGAYRowr0yXvWdV1bwpZ2fpPLRyVuSjR9Fzns?=
 =?us-ascii?Q?YBrXcYNIQpkSfjN/sRj/2wskTq/PVGA6lG74Oe+0m2fWZr6zrjr2T3ejNaUw?=
 =?us-ascii?Q?pZ6f3Bl2NniRJFnCsXF9KRnWsMNTrlq7Cvk8hTj080uo8oiMsLbJ/9HZSEHq?=
 =?us-ascii?Q?4aHd0zJNGrG/OLboe0lWge4eevxZoWizfl54cp26yElZ4Ee4HUqUINpfr13x?=
 =?us-ascii?Q?5Y1kdqB2vFluyxRV5mc84qS4Muu6xpwfBM9K5UqAw5aw8lj3gLYY8LrfvM4h?=
 =?us-ascii?Q?QDa0X7FzSEd3aUwsevgAG2X1Ry+O5XMu8cQccIdgJmQ4n64zdz3FfZDQtniI?=
 =?us-ascii?Q?pIYDiLIMqEYu64Bd60XMcuVvY07FY+lFGP7aLp2AN9TI8dWrOnBaJvaTqnDH?=
 =?us-ascii?Q?LSBsWQG1ivWmrEEA0evTsCChGaHV21MufoTYFDQxcGQ/aStEd2eK7rWIKoHz?=
 =?us-ascii?Q?bCrp3bMaFrqiOkAbBYCqbv+pHQjMEOgSAHccXFZpf+tFcCNwO4vOc3VHIFa6?=
 =?us-ascii?Q?Mrh54K7UQoiIdUJFKJrrWzlWaTyO4pLjUiikzPMb275bbiXp6qQciF4xH8gL?=
 =?us-ascii?Q?0bO7lTqNhzQWtP/XPbd2XcxVeNQ09Q90SnBpq8zP5/q5ctLBnW6Jo8Ti2J2C?=
 =?us-ascii?Q?hZ3pGhtshyNWSHPYeNxvd6YCz6cXObNcH0UF6uLcsv4zjq3mUeiYUXWm013i?=
 =?us-ascii?Q?eUJ9k35L3vjI6OHYObkUCrya4egVHQOi3pT8bGy3ITO9Hws55nGsYekIj0Lx?=
 =?us-ascii?Q?YSC2Tv5TbVcYYLg9XDMYKJPk8ccU9m79540B8sYsEXKI2qbcBfm1b0Hed+A/?=
 =?us-ascii?Q?lQw/VvP0A1/f0SUPjHnh4QlE31hvyHfatL4RXex+KQwjp61XNGe4zMvZmV8y?=
 =?us-ascii?Q?V0A9Hank3zmviJgJvrAvdOPv2l6OI71+U1/GQ5Fll+B3KBIQ748pbeRqJsOH?=
 =?us-ascii?Q?YNaerAq/aH99i5eWR8N3+1RR26qp75+62zJ5m57IJNeas7B/SXgJ0yV3nlu4?=
 =?us-ascii?Q?EBaXNvYlANuhYDqnbElHDRJ3u9wOuBEQ3ZyqP+QupCdH/5b6pV8PSdvN3S5D?=
 =?us-ascii?Q?EzlRLDN+msIlHxLbI09/nTR7N+MXukxygwo69/xZvGjYsNGnNoW+SAsqaolu?=
 =?us-ascii?Q?+nMDpbWKPsviSHUv0X1B2YD7vgwwd2qlgex9q0uigdML6mWpYj1h3H23K0Yx?=
 =?us-ascii?Q?h0o+K2ppUO3nDO2iLld5bq6z8nZR95s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae30363-cb3c-471d-72ca-08de6a5a0931
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:13:26.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHQqnGH9Uy7MbkVfCWUrLLEaIAzpWPM2qh2pcndga5YneZY4HnjcG3xUnqt03k6mP5DPQF2GqGsGU6ML+xRpg7nkZKBO9YgIp1JtJKMeXMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
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

On Thu, Feb 12, 2026 at 12:53:26PM +0000, Anatoly Burakov wrote:
> When parsing IPsec flows, we access the `conf` pointer unconditionally,
> even though it might be NULL. Fix by adding the check.
> 
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  drivers/net/intel/ixgbe/ixgbe_flow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 90072e757e..81b983ce69 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -221,6 +221,13 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>  	act = next_no_void_action(actions, NULL);
>  	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
>  		const void *conf = act->conf;
> +
> +		if (conf == NULL) {
> +			rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +				act, "NULL security conf.");
> +			return -rte_errno;
> +		}
>  		/* check if the next not void item is END */
>  		act = next_no_void_action(actions, act);
>  		if (act->type != RTE_FLOW_ACTION_TYPE_END) {
> -- 
> 2.47.3
> 
