Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF33C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 14:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C9EE4279C;
	Fri, 18 Sep 2026 16:47:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E054B40285;
 Fri, 18 Sep 2026 16:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789742846; x=1821278846;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u+QoLx1c/njX6rkqWIFs/JenPU6bLp0khfnroT3lsxU=;
 b=l26KOhtiX1lZohrNzc3iCcnmDhY3loE8Q+WRRU3mNNhQu8L4WTHCwNxX
 GFZOr5MQyZK1iZJdqy6+rzTNSsngE52ukBjvL3IUlW7dXEcUncjGTGj2j
 TW7/QX+yN2rxf88xklqL3PlPt7IzDn+ngV7mww6THYTf/pP5t7NyLjjIv
 NoJK2Xz3mjtzZH3DP51QZD3yUkFI6jReVu0vZP4dIFLNdbJpr67XRn6+m
 aacQgPRETHZmvUxswVToEcwtaBiZqUvVcV+wHW/Wh+FgtedNwV9n8S+iB
 9ztW7rX+BMwGFPT3qQ7LnwFpWwO+LhEMDjHtPXuXzKqar72RaVOKFdiQu A==;
X-CSE-ConnectionGUID: QnEbrKOWSKiKwHI6MSgh9g==
X-CSE-MsgGUID: 9CDAI6LOQ7SWe51jUSN98A==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="89389968"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="89389968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:47:24 -0700
X-CSE-ConnectionGUID: caGqv8vqT3mgLbIzp0JozA==
X-CSE-MsgGUID: BAKyIe4SQMeemYJIPD4oFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="279663844"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:47:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 07:47:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 07:47:23 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 07:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odGd15AcBr15ui6LCKduUqJESH4hXk9oX/n15GsivLaqnA66Z3mx9wvqMg+AdqSrJRewK5IwL8FehMi4dcC7apJpvle3Q9A2PMLmJxm/qjvYEXXHCqKoeIzOszlv5/dcRzV8M5ttcoSE5yc8gFq8U4uG14TPmTRFTerSdrNKo4jgZSvW2RpkvreSzIWdudDTdx7DZdLjx3WBZ6XDNVvyurO/Mp4A5sknNaGi93BTVdqhRgp83FLvbcnonU/rAI+9hgP60zCI08YEtMtjqPyzYM9eBAhEcRcr61huY8eT91R30+7A0T5CibXLnz8Qm9jyndCEaX4y17JL1N4PwdI/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMHvpT91D+GOTS5tDK1/Av+Ux2dMRO1i64DaSXRKtz4=;
 b=eU3/6YIe9A/ARqya9TO5h5fS+vTRkSU0mM7VtNlxSn5e4xfxiIU2CNh6iO7tGko7h4CkEcOKpTswcWvXRmE8LpSaAU7Lx2YRedXsFAXVdaiKadLk7bJ/J+i4LEDifvHeUuYq1Pcv6N2jMuU8pBk+ety50o/kFPGdDOItEFJRgPlXnwipy2aQ/Nj/MDMs9ia86HOzHu70x/6acXq5Rte9jcFJiQFszsLhWnHS44dzPiWETnRDRcXI9L7YNybo4RHrtcs4xh3bbH8aOWfH2Sn+0omuPMmaT6t9N6JEPxTf2IBMTUFOrmdY3fETLF4axBGLDHSfaTBt4YEUfcHFNNABiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPFC222DF22F.namprd11.prod.outlook.com (2603:10b6:f:fc02::4a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:47:21 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 14:47:21 +0000
Date: Fri, 18 Sep 2026 15:47:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/idpf: fix overflow on store of single-queue
 settings
Message-ID: <aq1O9M440uyJKA0k@bricha3-mobl1.ger.corp.intel.com>
References: <bug-2042-3@https.bugs.dpdk.org/>
 <20260914162234.4058977-1-bruce.richardson@intel.com>
 <DM3PPF291EF9BF15763AC84A0C243D922229DBA2@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF291EF9BF15763AC84A0C243D922229DBA2@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0334.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPFC222DF22F:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa99669-91cb-41eb-1eda-08df1593be73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HJ2jGRH2b5YHwapM26Sj49GUPk79BrP6IBrg9Bztb58mGc0pdlr8V1xHX805c1jzUAViyl8oGnmGG/lbzYCbCALdP3xLFrOn3aZYwd9COXgbuigJBr07DFpzguqhZRKw1CLcMSJkLHr07VosUUBTOsWr107VGH+L1+o6IrYZQ1SYTtEU0jcs5+ZxGzoRBqvbr/NJOQMjGBM5sQy8bjoDQ6qnO7d8ki4CEOIBxGm8hCR8tMRMCW9cAU/DuUR0JL3L6YaQiGHyS+9mI0d0B4bCG7jMSVB1ydbwgOG1sFyZoDeeRMlaN6MLWV72cxdfH7v1NymDS8PgXAnUnhgfrjp8kDrKlCqcniUCg/6q/sX2Ko/mpB7oP4p16RnlN7CIzNTEB69XPK83n8Oj2xbF++r4hsRpIgzMN8SY0yG4KGcCLEVjir3BPg38yVNCfYYXC3mBAnY9fB+y/T3GXQtJ0ttoKZC0jUSTxmfbuAEMHaby7pn7tvDuyhCkd664AV590k5dkgsFWjP25bb4NwaQX2c0vt7HQHV9I7f0t/Acp6ESdxkBBoP9nHZwDLW74tdauzwhk671uABGhS8jdxaTx0ZbmvRu2usloHShq4RFmm4JmWs/B7C+YA+V6c3/6Suh6mImemSgHYXhELhDjM3iKnP9iaUdlv0/SPrbvVhMdD8rq4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIVviW8kH9VVNHGqv5MiQCUQx3hbcEL6wCDzdyx48GcVWT21MfVrMGQqvISb?=
 =?us-ascii?Q?Bpkyc7KkMqgbgBmEqzRu3ggvZADB6X4AyOox0HByk1dK4Bms72BlaYMkZcdY?=
 =?us-ascii?Q?goAP9/WkKvGM67Akd4hTd54Ju6GfwvPwiXrJ1mHYHhMRW0FhW6M6dLNidHyN?=
 =?us-ascii?Q?zhxqNNvhCNwLTi1i203j7VAf9KjJzkZBpCm2XSzvV6FDMjxQKpN1DfdIgIME?=
 =?us-ascii?Q?ijRdSi8qroKDq0unYwz6a5lDzpUXaq2sXjkFdYP/PnAiHpdhs9IIbRAx4N0G?=
 =?us-ascii?Q?WZuBmxkBvQPfZG7UrhKNqrW90Cmpehyj+lp1rMPaJBgGt2Qo3JV9y7sBnfPn?=
 =?us-ascii?Q?9gABaxmoM2lvSe8E8vZtLnW1vrmHIxIk2mpn5R07+4jNew67fMwOa6hriQoE?=
 =?us-ascii?Q?s61b5C2XzmVoZAE1BFFDnKStqA2qrnXk237qe9I50fX0fUutwbOAKwcDeErE?=
 =?us-ascii?Q?w6ebIUDQSuUhTi5pnKEjaHa4F6uzyhDRuKpdMadDUiU8a1cDTjwDjO1pXsJ8?=
 =?us-ascii?Q?+0oStO8WNgdSEhhoUZIv5QB/2c7SboZ83Nkyqn8P4eC3ODdf4JpjhYUBZwCi?=
 =?us-ascii?Q?l9QlRxSHmS6ekf2g2iPRETq/5efDas8NRJGgKZgqa2yIi1fJmkYfdBkeRjL1?=
 =?us-ascii?Q?bexhq11IWaQ7wYtQSYUrMSdMbEvdt3EfgV9Qo6aESRvjPIs6RnfigDu2VRGK?=
 =?us-ascii?Q?/uzzlSjlQBxRD5rFypWkpSZp8Sr8J/H1fhKZBVCavh6Ny7cV1X8eqpbubUUZ?=
 =?us-ascii?Q?eUMNvyNA0Exi/FyLXlZ77If1nkapCzUrf7o7vq6Bqpa0PEpg2ZwlWjIAK7tn?=
 =?us-ascii?Q?4Xbg7GFjRKY5//o2mJkpbzWz8WOIvOh3qdMqhcm3KOiXD92FoaShwnSBY5GE?=
 =?us-ascii?Q?1KCpC/qt1fkKe5NAdKScBdUCCqNJbsDJyFRRtA0iQHIUGIoj1Sh+QPimhHO7?=
 =?us-ascii?Q?39uJYLbKkCUshjcqJWm758hcM2GPwsozYuC3MgFc4o6hBko3RmSp8IBAUip9?=
 =?us-ascii?Q?LcQ8tDLwVA4X9ggTygIbPhGFt5fiG7IDzk5UFRDKxZv9JxU2kyztSAUB1bTL?=
 =?us-ascii?Q?1aJMPKo3UBejPLB5w+QCsOwNUfbRHShKvKBeK2+imFF0ppFGPLXiVNQ7kBb7?=
 =?us-ascii?Q?SQw1XI8t5OC+mgVwZEiD6QLNl6pbT/FV5HV35i4+kyWuaWMo4ATZFEuWy6Ou?=
 =?us-ascii?Q?jDHtHI4HdJH0Qq9zJseaELlsuXSF169cJyWkG84vdfPo51yfqgxEuhpgAPoR?=
 =?us-ascii?Q?NVm7tywWtxj/gRpKriqAJO/dtxOcQFrUdy9OonG9q0qZiEFgXMey+LxE+TiB?=
 =?us-ascii?Q?5+kjY4MbOEGSmuSmkQD4ZaWsAyBRxUqOsz+y9dK5ZybBQqDs4ktxfdENeHeT?=
 =?us-ascii?Q?45bncG+JiEy5qsjylQY+GpvQlLhd9a1vNKKQtTODf8rfeSV07YU7S2z2X8cZ?=
 =?us-ascii?Q?EoBYIvQFH75fPniK4+FYOnPdrGIWm3Qvysv+g3zHzJDZ8ePZlx4fHM+kznAS?=
 =?us-ascii?Q?NEfBPexVtotieXkx1aJbdV5/V7WS20E2lvVdV44Q2sBVSomZ+lTk8JAjd+b1?=
 =?us-ascii?Q?f07mYhQdI89FpPp/9NKYE+NldYMPNwdahYyyXoEmPlCigP3NMFLO+G8UNbpK?=
 =?us-ascii?Q?WxXmmGSb1jD3O2cmh0psGhifOWUT8wNz12+usQNiqJE0q+HJeiOkXV5qI/dQ?=
 =?us-ascii?Q?cNikhHh0Kd+SWZVrNk6KYhuN0lsKP1jsEAbxsq9551uxUhlaTA+/DeneYPAz?=
 =?us-ascii?Q?ItsKw9M3NbA29IFkVfEJAL6e7bvVf+Y=3D?=
X-Exchange-RoutingPolicyChecked: mzzogQLcSs2DK20J6ujjmszU1dGYQLuKBuLEJmWEwcBEny9lmvSyn7iVHn8pmXnKjAm7Ywow+mpbovwl54SI55KYh6paGava7A0uzyO0NS1TlEpOCkjC5efJx4UB/4HiPAoMi2bkRh5+coJlwMBjq26wNK6lSW96SW+ECuVX8iBLNBI2ZPTCyBlBfe3NGugijr1+1Ddp2fdVZR5gZwF6haVWCYYc6Z+b1cmZ/EGr8Efee/w5s704zz8Ao36J3wkPm3iy7F/wIOU8lX0CQ//CV4pfZj1OKNyfVLsSyJws0/NjmOrcO2xCEE5guVeDh6FKRzK6W3tdwUQ7EcEgSjSJpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa99669-91cb-41eb-1eda-08df1593be73
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:47:21.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS6H171zXn7G+okdpNkctVxzoklYXjUFDj1CrBvor04Q0oc8lc2+717SclI5f2Tw0j1eBLTmrr79vbhWKm7/ijgUQftQRMnXDZrm37AKbnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC222DF22F
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

On Tue, Sep 15, 2026 at 11:41:32AM +0100, Shetty, Praveen wrote:
> The Rx and Tx single queue settings in idpf driver are both boolean values, but the parse_bool function writes to them as int. This causes an extra 3 bytes to be written beyond the variable itself.
> Fix by changing store type to bool.
> 
> Bugzilla ID: 2042
> Fixes: 549343c25db8 ("net/idpf: support device initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ===
> Note: this fix is superceded by the kvargs numeric args patchset [1].
> However, that patchset relies on new kvargs features unlikely to be backported, so this standalone fix is useful for backporting or if the whole other set doesn't make the 26.11 release.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=39247
> ---
>  drivers/net/intel/idpf/idpf_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index c13505416a..9fd5b28adb 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1247,7 +1247,7 @@ parse_vport(const char *key, const char *value, void *args)  static int  parse_bool(const char *key, const char *value, void *args)  {
> -	int *i = args;
> +	bool *i = args;
>  	char *end;
>  	int num;
>  
> @@ -1261,7 +1261,7 @@ parse_bool(const char *key, const char *value, void *args)
>  		return -EINVAL;
>  	}
>  
> -	*i = num;
> +	*i = (num == 1);
>  	return 0;
>  }
>  
> --
> 
> Looks good to me,
> Acked-by: Praveen Shetty <praveen.shetty@intel.com>
> 
Thanks.

Both patches squashed into one and applied to dpdk-next-net-intel.

/Bruce
