Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17FCA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4CCE40274;
	Thu,  8 Oct 2026 12:16:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id B0EF14026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791454612; x=1822990612;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OC1DZVLlPEPb7SLPgNX9sQQ/y5Zfs6YQrvI8UgzWk14=;
 b=WuqQ8nLkfPXGm18TDb9D84n/X7sTFIp8vZAs2Yqba2S/Q+4JrZ6fpmoM
 ZtpFADoooJX735E5r3QHE+QZ9GiQRwcykqVXRzKjtw2YsRFr9hn1Fwme2
 7etBJSh2qWpj+WvSPtRtj+9O6spgGG9JBSb+7zco7r/63NXweOr1cPXj9
 qBiB6KroWhrClExx7xAic87Aa2ANrh35m5t3v92FqxTmyA3fMpldYHiUF
 LKP7zD1Ra0JT1qQBLu1DTutrOHzgW50zXlK2QsE/28gycrB3vjXbr1S3z
 5ZWcQ1P1KLT21TnYeC/6mqkG4WXK8lMKigP4OQSZVkNXPc12/xoCdM9US Q==;
X-CSE-ConnectionGUID: SNj7gC1SScqPCQzWlMFM5w==
X-CSE-MsgGUID: 490RYnBpS7umURGCUzBYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="240166"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="240166"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:16:50 -0700
X-CSE-ConnectionGUID: G0ia/o4ERmGNsZ7NMwtqIw==
X-CSE-MsgGUID: ULwHj+KMSEOVIfO+p789yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="111771"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:16:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:16:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:16:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAwWYROHBKG34tZAp94OPMZn3BL/JSs0GYKSz36XPVDTu7yYruanDP7YGIVZgreICTTYhI/rJUdeo8JmtyV+kMESh/2K+yzk5MhoeimMKFj0hV+mhaPV1Fl2wcqH9+WhUUPJIaVapeFr/oUlpKcWCTouHhP7cu5VqgqNsosbU3+m/kqouGg//ru8Tp/WqSd3hcUrADHVBF04O52Eg9FVuEhvIXG0L6a1xAhcDoS4bVwJcRZktwU4efHFh/QbAZXNHPWi6CREFUQ4xy3hmb8bsz9VtL4TDyGEPjEjQy9psfgnr689TIZK8z7bjF931HsXHhG3mx5DqK5CFjlxd+VeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOeVjtYkprzuf4aJ4w18j2jYkGDjtW8xZVQzLrGzBSY=;
 b=StD/BFEYkVvCa9ARo+AikaeO14y8cAlHeJ2ynF6Zq5RNO2XFKiBvpgzAUYizq3yA+aYBvGf6/vGqGky7CsJMnew2WC6EAtmmdkoIqvWY82Y+H22skHpe1jKqnF0+lY8VuYmOp2nm3FX/gVC/HhoJ6ZR0AO4lNZjQm77B0Q4FH90wge5YrLrp/LPhnGE6lshVMKbf6BIq1Z6PmFTvhJ7ZRTMtCDp/IG2ckyaeAtgvA8fE9f43LGRdOc07HYupCjPp88tj9Tm1Yk5UJSi2MIBdL9BkUiplXhqgV99ift12XRm54XES7ZxUsRoa/cvCTja7EVxyv464LVUten6QIJcfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Thu, 8 Oct 2026 10:16:39 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:16:38 +0000
Date: Thu, 8 Oct 2026 11:16:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 17/20] hash: promote RCU reclaim and thash key generation
 to stable
Message-ID: <asdtgexRv71t_VTB@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-18-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-18-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: dd826c69-55d9-40ca-aed0-08df25253d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yFZ7zdYk68ql/xBE/VA/TpGahT8BaEotvV80Fs0K3DRWhxClsbR8F7XGxTACORviRNMKwGsf1TjmyiaQnn5LXIMegy6VGdGG0wup8XzkxQ1NK0Wr8h2aBH0rDaobmZAj+gUUPH+tuUgeyTbl5w031dchKk5uqqGcR7aJRlAVMqTnIBi7tOvDDIWxmp9KzM3kNBbdL+xVGFXiMOPlPlJeUiM26C94lGmtq5ZVWtRuFSdA8GuN7MUlqaDAI4gPF2iQUDRmpQol4vhsCbIySGulpNZwsudxOzE93EF5jAIocYXoRkU/Rj8BC6I8HSVofOQFq1vHjm16DuQoiY3a6Vbf0M2r038mcZhVv0RTatsQcFuKxxcMX25RmzhqlAA5O+CTUm5BiAwf5Sn1LQQkMG4+zm7jB3JYDxnJ+7TMhkLkKJTGez8RbZeli+d1jeLsl/eS58UTDO3ptVJ7/95sYTzsZjIJbllk9hY18TtyESAlx8xxDDE7ZFvQ/T4Rz9BKivK2Qabb37Pjl1dqazc+gAj4NEDIJ2ts7ZPUJ9uIk9I/cMilC3CQrpucW649EI8/K9/K2xZpuA/aNeGTM7898RF0Rqk2gPFCNcnJGJ0tP4fHpIFAkmZKHfNK3bZc+GZNv0+AKMMCKBeqW5ou/Z7j656781uz9CjAg+5MB3dSP+ODDjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gAK45teS88UeVUx47Yo0noeyoHaVdUCsXAcTVDm8s/6T75orP+7DhXUTHitH?=
 =?us-ascii?Q?qmtwZwAkOii3PAipYcV65T0uwJU/SPOecE0NYQPPHmpW5b8UE9qjQ44IxywD?=
 =?us-ascii?Q?PQ88QTPe90aKNJ6iJHX0TEaBugDLK4l8xcFQUuaYFbjc9BEIlNGOwuH4kWBW?=
 =?us-ascii?Q?OW7OvK9DwpZU26pp9+fNXNz2CuuZhiZL5r6Af4byyhcFj5o1SUu24Rq/97NQ?=
 =?us-ascii?Q?Gyo4GYKPRypodPV/PxnRE/gAfhy25yFpZu3kIAL2u/4Fw55pQHniVuCl7h+4?=
 =?us-ascii?Q?ji68zg6nIlo2pni/jYFYTmsQEUcuyzIN5s6u3g7Kn2GZ76MmNz49MSHOlrGv?=
 =?us-ascii?Q?cJ/h1ni8W0EzoNnYAyoSKRvyoQeO99775Sq3fXZyG4muGTrMjkd/ZYkTi5dZ?=
 =?us-ascii?Q?4n5MviS08BOFfxIG2eWR5/NDFTP18RSf/OPBcvadt7xl5DDqxLyfpsDSEg02?=
 =?us-ascii?Q?EmUyGyW6wOE2QgkIHZoA4WggQMVRUX5gWMHlF3nh8M5+qolTHDEq3X55tjpd?=
 =?us-ascii?Q?JziGh8mA3d8/sQsi35/GCsTUObZqgy5NxHGMEM7L8SiYBsKTeCVSG7TFNr9j?=
 =?us-ascii?Q?gKCKOWbsMQuOXxz5M8xkitJXkngGua0QlIcu9r6MuPl+78pk83MLYV3AX7uJ?=
 =?us-ascii?Q?gOrsXYFj9gDC7br1rV8yrLskoOv1f421LAfELdXOAEV0WJEFh4sWsqsp68aa?=
 =?us-ascii?Q?kguL7JiO16kKhgOLW2ze9QvgCPmuypeKv8VWteoLknF25QlheHvkovAY7JjB?=
 =?us-ascii?Q?BFPK8GPlqTLanHX5BFVTj9KDnn9z9PEy4JNE1nsbeCvouIcdJc/WAmX457tn?=
 =?us-ascii?Q?6tSFxvBmEDIknAxXH+YbKJX+oPylzXVUxA9fWtB1cfCiPEl+iJdFw4qVjNLZ?=
 =?us-ascii?Q?o5+kaGwwDcAd4r99WbjURO2kZ9PCnVjZkXSXQ3+uqDlSFZ7MZLz12MOqXA1g?=
 =?us-ascii?Q?j0Gua8nZazAu1MTgy3xsTPI5O3295xONEsOD+4xuD+cLndMZ6qDfZvw5kMwJ?=
 =?us-ascii?Q?jcIzkUBwEWaOgaRheIsEZBPln23eh/O9wo4H+4TfaU4jeJUC3zamZheOB8Ke?=
 =?us-ascii?Q?vWv21J1SpYssRBLtxPsElOeSfT1FNIweIJsYhOB5nSl/PBRk01JXADNDYnOz?=
 =?us-ascii?Q?o2EUAxdzqBd8zd8ksczBWbbrEvVgv+WvYbDbUJjUX8Xxcdaj1SWwYFKP0d79?=
 =?us-ascii?Q?98X4SYWmCMh7w2sOxaSldo33/b0WMkIIFrjW6JiSf7V+47/yOCFbk9qqbNeV?=
 =?us-ascii?Q?FItA0Dt1toX7msEhzYRI9PGcdhKpNz2FybD0OP9db2ETaju3PUSNy48sE8Zk?=
 =?us-ascii?Q?2NV0aK/HQlCZ+cPiXoZTlbyWCdLHgir5JAvbfjV82c+H5bFAmQ1YsrvRSIot?=
 =?us-ascii?Q?qJEwjDlhcPEMWh1m9zJ4p1tOxBN+gLWaQXxEYqZeOhgI5x3U6vTRU7lpTSFq?=
 =?us-ascii?Q?vW5lQsE0JbUWoaeLwKQ/KFRkIjBwOKIwr82pp+kmAq7s2s/nyDLG+Xz5Iydf?=
 =?us-ascii?Q?ZxcQnJFB24FA+cOu728oCZMnyumVqLiuZ9WQ5Vafjg2NW+HRrfrLtFVfUg5b?=
 =?us-ascii?Q?WsfE1wjKKsDptQRYfTRweM/cCb4L5jscbPeMfVv0tUFalat2zuYiaNXj1hqU?=
 =?us-ascii?Q?ZwSCtRjsFtZKYEPXSTYbXzO5QxHU98bZ+7d9V01R6kBNy4UeApcEoe1VpE9Q?=
 =?us-ascii?Q?qGZl0wJyPpoPxDED3JWrTIgXDo7oDsgtJM3IltZCK5lkaDzcbtiFh4tcsvpC?=
 =?us-ascii?Q?4bsf0bHneMMel5Rrrg/c5NiV4IkqRko=3D?=
X-Exchange-RoutingPolicyChecked: VceVt+IAe5XrlnQfnS1ULXtsPKjayxtqM+/LN7Iq7K9B1pATAsPl52xdmnxgOmKOp4D6ChvLo8jmo0mwldlmxuCG9MCI/1mdTtXXYCvPbQpE2/LYBQkd9kNMVmOv4NslLe+9LGR4SdRTFtyLnzWfHBZbx2PF6cSVgXSV+FZD8uzLN63qo/JVAzCu8617R+PuocemC9ZFuiNxkIcKBcX8+bonWiUGTk/8m2vu2Mfb8p+c+EI+jk+Mnbb019eqZBb9FsqQ9VEcLojT9gtqXu5UQC/sG8c100gdo+EwFh/mioREEbFC4Ms+x70ZjG/UMZOGRQwaC+6Mym+tJlchW8LjEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd826c69-55d9-40ca-aed0-08df25253d8c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:16:38.8303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlGosiCfAmw0/zBrFwBCip9avYBTt3CU8hfr5Hm4/Uxy0HwBblUOLGK+xg48Gqn7Bl2l1xwlSPkv69ZhgR/qiviZniBoOk12xeCsJ2s2buU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
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

On Wed, Oct 07, 2026 at 02:39:47PM -0700, Stephen Hemminger wrote:
> rte_hash_rcu_qsbr_dq_reclaim() was added in 24.07 and
> rte_thash_gen_key() in 24.11. Neither prototype has changed and the
> rest of both APIs is already stable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 3 +++
>  lib/hash/rte_cuckoo_hash.c             | 2 +-
>  lib/hash/rte_hash.h                    | 1 -
>  lib/hash/rte_thash.c                   | 2 +-
>  lib/hash/rte_thash.h                   | 4 ----
>  5 files changed, 5 insertions(+), 7 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
