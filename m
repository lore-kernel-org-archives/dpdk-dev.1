Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E444DC982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:30:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A10D040262;
	Wed, 23 Sep 2026 09:30:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 7C88E40041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148606; x=1821684606;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0Tqs7aoJEQF9BrM36U45NRi1q9iV+2fj0z8PBwmh4h4=;
 b=N3tG0kOTD3hks0LAE/DRc4j8Co1vuCcIsVawPO6ZfE1DegBB9yalrCVj
 6bgXNcVcne4M5gh7h4ppZc4V+peXYNpHoPY8CxqDKtOqhcQTuiwySTbmT
 70wE+N5FxOnorpMJ1N7ieklO8sECFnPKqjphMDCOTqSKTaIXiKRrE3n2U
 6NmFNmVs+sMVFXyx9ekpLwNLfo0h23mpi1gVEPssxUHQe5R2yG4hIplDi
 VXLPeulVtUjThLga7BeZdGVRzYmWQwTktuyDWTRgWvlYnul0zSyJR9vyg
 l7UinrW4O7WHiooLmvX/A9szj9Tr2ARIhxyD6KSROiaDsX6lJ8JRPsY9M A==;
X-CSE-ConnectionGUID: hgtm4EuMScagHaOJdpfyhA==
X-CSE-MsgGUID: GiTYYL+sSGShvQkZHfQqCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1330863"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1330863"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:30:03 -0700
X-CSE-ConnectionGUID: /GFrgoIxSiWVEW5SjcJJuQ==
X-CSE-MsgGUID: KsuNC7zlQcmSD8VNh93WwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="301409817"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:30:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:30:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:30:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:30:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmP5D1VoHjihQP0mqmrcqyQAUVxYegkDbxVe5bn6uj7KH5DpmINMqP4f+DRkD941AgAGWrXSxmXvpWLEwzAORo4fI0Q9wUcXO9qRwRvLq1IL2Bx01yY5lXBVCvQgvAUDGM3JdnJu5K1hZBotQtszg1a2DRJ1Wwft9oir6JXTJ3th+CchpZmvtiwSEBcmjzae0p0vlYQoM2xxnVdo0Gc540w4f0Ln99FUtvY1xP5t1Ds+QY6mTYIjeBY5NRydyEfdPZzbdcIm9a4haFX58gOq4NY7kUZL8SnzXYj3Rn7KG9fqylew/RXtFbkaI//Gx/EqNWJFg7f6t0RO9IpxpapGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF68O0SNOM6F6bpdhiRVyTQZJLRlYLVp7obCiPOuJbU=;
 b=LRgFFAbaX5S91OQ9vPR4psW7QVUfkECLPEIS1Nj3xTdrz+nVoZ5FkS/jgI9AYclS3qClhTumiMrbBjZssajoifHMtUPniaRWQmLOzN9SIZ0ki/YZMug/P8l/5DWOOZTl5I9+61j4Ze4iG814pSK/6fuo+z/iFBdhVAIcFMRWuoaVwwkVKHqpMsfZhHLlm9vXyHa5TO+uW7UdgFJ9C7oOkhAt84cFfaHRBGy3SKkQT8bUUC0EK3TNU5wHZahh2eOtFEg1MMhGsq0ybDMd3guRzFL82cstkN8QzHl9ptP9q+DTknSk5KOVI0NQ98QDtFgmJwk5DrGCqv67Jju+xyTuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:29:55 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:29:54 +0000
Date: Wed, 23 Sep 2026 08:29:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 01/16] eal: introduce division round up macro
Message-ID: <arN_7eV4einLJ4zv@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-2-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-2-joshwash@google.com>
X-ClientProxiedBy: DU2P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::31) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8234d7-f180-4319-13f5-08df19447660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HFwfcVcIsYcfxUy4ERJwygOVCmYAHD9RDf4jz9UD0SJuCW9UJZONWeJ8tTWpNgQlC0eU2YAVz1OpyelJvChc7oOcittsznnSRIvi0/DvwGxmgQIn5WYe/rplgprq1ywyrGMcFKoVDyNoCBIWeTFWHHfJ6TBjIA282d1VoRGR01Y4XGjEQStb+7VKwPadsRet34sWRWyiIoiWNUgGKi6XXnUZIeRuB9IPkl4mroN5/hbKYX47aUtL4o/21BM7UJrblYnIGTe4QhcQMdhBwEfYjaNkI9W5bWxX1q51JUwrGkJu1JMM3H4WV9SvuSWJhFZzAq2IYHfQUj3LHB8ayJKSJQXksXb2ulBMpjYRe69SETKU+7wu0NLDZ8+qpWfVjfYgnub/o71YZeDjfmgGEljdcukqxgUFz6X7RxlYn13KFNb9up9PPDYfiyB6W2/SF2eirvEVBqs1SoslTkf3uG/8Tlv47Nwgx8cXMQKoJldO8XEBIOEYmsBR+kEq/80DEeK4OXb4pmGRn/6rD5t4heMLlOyTeYf1ihxFUUkQHZF37sDOS//w87u+2DahVv3iNkBABehlWR8N1PK63mvIbGA5p9KWvbbow9LOcyd/D7eQXvhK/p5qo9XG81rsl+Z1CEfIEE1QDjnqfi3T+ihY5awRLhQ7npaz1gjc0dMn5sAJ3kA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFRSCkMkqxupIa+R/fDs9pvQszVFbmGPrhw32CP/576/M+hzzdUWVrOrzGeY?=
 =?us-ascii?Q?oFNKF6M26fGAWEu4rz88LRGzitXQTY8phNt6l+d9FlxjDdq0DDnmKhTJLp1F?=
 =?us-ascii?Q?Ev60AmNmAu+/OPEHU3jv/Ws0M9Jfy5hfcG1uI/EbzSE3rqE4pLoD+iEIRuCn?=
 =?us-ascii?Q?qM3Czleb9TD3zXJrIykYygjQV1uYmkd9PJtaHYbs2uENPbRUFsaWCXzIy8D2?=
 =?us-ascii?Q?ZTQUbdjbJmoiqmZ7PaHKg1xQQ/Gjx2vsXWxtzDTZhM+rOtWw5PX0rBJ/wytf?=
 =?us-ascii?Q?Prw4GzprMj85cFgF8GccNDwh9Hsl6epvTnTEG84HXM+NcnGC7IoDsVl9ppqB?=
 =?us-ascii?Q?5Lip4GssigsyUB5FJzQpRDJ94HWA9xqHb8KO4FFzsfNiocTBM9gcuqkCGTS8?=
 =?us-ascii?Q?YZBzTfx9GVGReUjv/i9HsOHm2beT+BZAm2U2aFgZJPofPxcilMzt94kkLOI+?=
 =?us-ascii?Q?/td9HZZFEIwXXTuk9xv/j+3eLfUJFQTID3iR5h62eMgyGEsEwPUoLCtAgEFr?=
 =?us-ascii?Q?SGmdMjiCVUCxoCQP0Ov/8/THyJ4ujdRhwDtdnhRpvMm0qnYQzor7SoXOshGu?=
 =?us-ascii?Q?aE6yqG7vo87VHBng6u8M+0u5y+iPaYJ9oPp/AFAAB9Q7+tS84zdoXz2j00z8?=
 =?us-ascii?Q?K+6DxrJodxVyxbyKtr3WtPphrVu65uO/NXoMgbv54IhMwkVzxDnsLSt6nLXG?=
 =?us-ascii?Q?pp+fFo1QQzL0tQb7/zEzR0oO6WHhqxonvFK6Rz2Ys93oCoxFSP/WZU517d26?=
 =?us-ascii?Q?tLtizOYezmcvYco2lrEDcqClxZdmBD/3fWePGOBeh1cviSYvVfUJ5UyHH8da?=
 =?us-ascii?Q?hTsIxn+q6IFuOa93ZoZVOSotQq1k6QETYIZxNk6HfBaOKUU3O4Lgdj4sZxdP?=
 =?us-ascii?Q?WvFv7U9qWVFYfvxFjbka7UocDd1NNpD7zKzUm+ZZA39nq70Fn5DuMgUDBjDp?=
 =?us-ascii?Q?gdv0OqySgMNH5whJR76bI9P8WgGnwKVYPS8qxHeu2arCkp1WFbj1JYjZZAfc?=
 =?us-ascii?Q?JDXnCvYqknEXqdtG7wvKpzYyN0sSpyMeXA7NfpxntnLrU6nnXrQEI0ZVmr0V?=
 =?us-ascii?Q?v10P9OPa9nveTOt8MNKLiVoBC9M4Bu3L/rVtp4jSVxz+cLev/UsJwi6JhVQC?=
 =?us-ascii?Q?xwHLgwS6dN9oY3dG6NGE8CMQk9J+yOYyiXeUJXSNhna/PF/iFmPXm9UXuPBV?=
 =?us-ascii?Q?36gs/rOIl0E55X8QheDjDYZUspYQZTsw477uKk5M7AcHxETQCh+VCRrPZSkA?=
 =?us-ascii?Q?vuFznQL3u0xpbbgPPJ9e5uNytC6U2/JmDMIj2zdZdEX7FOdwL4zIncpFh6Ep?=
 =?us-ascii?Q?0QUsqGbu/bUJ2+BeTUeMB20+hIb8qu5hHTmNQyylVPhm5wy19rqn+sLM7yW1?=
 =?us-ascii?Q?HfkMpWh3xL1+0AYHyPBOcBfI+nWbBg4mx6pqat0yQtg69P4HCJEx4lTm7TZJ?=
 =?us-ascii?Q?mQBoE8AO+Z0bnDZS9ALCbSl0BW97amalwEw8oSLitaL8KWLBk6ytt2WkTKpi?=
 =?us-ascii?Q?drQmQteXoGnwdXTJ+SmMRR8ivlB1Ti/BLLMkNqsC8wOMueJ5jbSyRWNglHbB?=
 =?us-ascii?Q?uBCa9Tgz8Ebi7TniqXm3hfhkDymDWxmrWxibubPjh4JeD0M+sNQ+qM7gt9CD?=
 =?us-ascii?Q?1jPH89H/SHTLk8cePE+SU/MiQTAOy9JEalpZiE2sf9ct+I2XSzGPvTNmNI33?=
 =?us-ascii?Q?5mWpA30ILYcHz0D/tPVh4x9XHi/uHduMy638rWcIb8DkNQusTRpV3Xg44qUz?=
 =?us-ascii?Q?3EtH5UARafhbPaQIaSmbCJVMB/nxPN4=3D?=
X-Exchange-RoutingPolicyChecked: w+NUWOEEK62yMhvNV4IYEbcyRm/GtbOI72FV2lKv/uKbrDveVbhne7cROF6O3dSC4IkO+Fx2ojSjaerM3uMiUFrN+WkXSN62bC51uOsOGcfBIM0+tCWqRJkreqqYbNlNU1HetV4QNPtNXwWrlhCVJrHqPkZPsRAJUA6RtrlDjTVaj+1Hf2p0nQTFZLvM5VINzSDpc/gmaVJ7pN4AUYJ++AvLW2leCfAwY+6a5a8GdRTjHAbqBkGcfTMvcP1lCbmLlB69Gnd9o5+E5xhH1Q7vAY88W+bAMao10hkovWHxhwX6VGdEqFdyOpOyjm/au0yOlvoccfsNM3Oh0fxBVjJ3Kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8234d7-f180-4319-13f5-08df19447660
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:29:54.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBUP2P1QYuXWgf2gAAfN7c8tpTm2fdz9z4san2jBMAHg2dOTkB/JLcVMr5ed+pD2UkiFNRCWVMwJTeQJNf4KeqC9w6ETUflG33jG37bp8K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
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

On Tue, Sep 22, 2026 at 06:07:24PM -0700, Joshua Washington wrote:
> A number of drivers define the DIV_ROUND_UP macro -- add it to
> rte_common.h so that other code looking to use that functionality
> doesn't have to re-define it.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
