Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FEC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243B940DF8;
	Wed, 23 Jul 2025 17:08:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7229B40DD1
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753283326; x=1784819326;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kLE9ylJDVIwQpucObOHiveZ4udjW0qoIm3R/PjmiokM=;
 b=jNPCKf2ag6wDmP9jgolxAgGGDutsHgnr49724v0I5cM7ISjA0ys3QDCc
 UD2bLfpPPx352Pv4wOjKb2v93HP7c2hVGjEA/7oFng6wPEE5/epHaZhqI
 aS4IBahOV4DNQCXVWjnGAOpNBhG9r/4rhhl40VCnRgudbebUeDcFv9cy6
 3OYmhUHaXc0qm0OTBbYHwDwVvgk9b7Js+u6UYu0CR12Q0nQkIltWMzG1V
 T58xh1zjfvVOBh2brh3gA5XSbyS54dwqEdpYJMNMkq5Lhjx238cnFacGw
 A+0QUEOAHINHeKx7YojYp65OGtxiSFYyM/BNUjsgd1RZysU0N+g0tYL50 A==;
X-CSE-ConnectionGUID: mxDmqyV+TRO7pVqgZdLfYg==
X-CSE-MsgGUID: N57sXkCDSHmOW7ErYo6TKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73150190"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="73150190"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:08:44 -0700
X-CSE-ConnectionGUID: lz8zRZxbR0KVcmp0TkpxUw==
X-CSE-MsgGUID: m+lnYAA8TW2oZwgatszncQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="159201013"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 08:08:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:08:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 08:08:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 08:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHvtqMxKzHS3XoBn0rggtb5wfmvXxNPg61lrbjQmLS6HPyAdkoM6nfMvbwKt7YANMU+QsQGu8nSC0FutQT33xNsjfwEkaMqOmaxVPTsYNleaVs1YYlrpipPUtLCsAjpoaV9P3vnHE10BuvYdacOpWhxXOWskkOpogRuvJ3L3t4zFl/lvImuPghhPOF34G7vZGKKUC7RN6OnbkT6jU993SZVVmf9Yu11qjmx/eKKnk0xm/nyCYVVNYzPcu9Ro2Cm80v/Rp5RHi/ev6N5yqNxH3jToAyuin+4eZFC46xA8s0djMLUb8WSbDa0ssNqfsexqOM3xUmqPTMs06PEw7XFoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0llqjeGXCLAY1orkAPb9xOmRk+sgOJIPjO3FRfMUSU=;
 b=iylGj3BpTpgy/0hMbG4ySCNq7ZRabLvG+9FA6ZrlTPKuLz/2rMOVY3JjvPzv/bLYf+7V4xUk78Qbx/VldNGLohct/hb4vina1Gf7Kyzzwgq/Uwk9ZOefWTIggqYRk7iQcn9/ya1qxC3tWQGRCLQNmLHaLkzUndMAqWzUdd6O6PH9mrOPvTcgOxeTeyAAPEOyNCVSD4XkifR6mSR4DkamkglG1q3j+YkAxaS5iF9dEOH1uJk2lGiSX54J3mZ9kbBw/Nd/2+WkaUsSV3uOmmTJW35dtHAcMICXPcZkN3NDZ4DjEMUhQi0unsWVcPDectm+Tt2Tx7O983RqHJket1RaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:08:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:08:11 +0000
Date: Wed, 23 Jul 2025 16:08:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Allain Legacy <allain.legacy@windriver.com>
Subject: Re: [PATCH v5 20/22] cfgfile: fix section count with no name
Message-ID: <aID61pJDV3gbZTeS@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-21-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723133157.159825-21-david.marchand@redhat.com>
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: ab456097-adb1-4513-7eba-08ddc9fabd69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eIz+uqbN+Na7Ybm3xKgNbuFeUv4hNSMMc4KvC91xu7SqGDS0VVuuX2qOCq0p?=
 =?us-ascii?Q?g2bu8fKj3Gzs8TSVRKHPiEL2YV8bIM4U1k23zFLR9e6JHg5G5R+8tIiQ2IDH?=
 =?us-ascii?Q?Oz0YjHrVPM7HSWG4pdxiEvDvzxDPmiAw7TlqxY9fgC/Ww8jS9+c7MCce7ZU1?=
 =?us-ascii?Q?5KOYF11z+IighwA78aBK76lmu+07lOdN7m2eMu+kd9zGZBnEvdh5PzhEG0Xg?=
 =?us-ascii?Q?r6s8lBZrVTe51jCfwWQEDH7XO9dJdrLwrekbz7NNMaZfOvGNuSma448njoU7?=
 =?us-ascii?Q?iMnELOtDskMW+olU1AX22D6RNXL7TlU0j5ajCASnQw1vuRP1ixNfCpVuqeXf?=
 =?us-ascii?Q?vKuTnQWxJvYOu2i39fMD7gj81jfXfhj6sa0VdIyqy4u0TPmRnjsMNuBTCwvZ?=
 =?us-ascii?Q?nLCfaRadChAlPa+3IicOweC19sYrdIsSfJczSdDx40gcxzXdaauDrEYix4ak?=
 =?us-ascii?Q?f/BuGXYwXLkIQuzuf7DovV2meKU2UBTrKXUUawCwZwnmgkSl4k4JVf7xA8t3?=
 =?us-ascii?Q?oijJBfW4X/5uT9JZTSUMJEBsnAUE7EeV3EsS/bNtOOk7xUZVOMRHD0XwN0Ip?=
 =?us-ascii?Q?3HifZ2WjBtM/ePU2y5xp92MZFppW1xAScjxKsvNbfAikigZvLiO5G5bmu+Dl?=
 =?us-ascii?Q?dzzDmWEwt4fJpKrC1Ng95f7clyXQR2bQ+1wzs78kHSRJVv/INGF2LNx2jSaz?=
 =?us-ascii?Q?Gmm4eO/UXv9h/d+5fMXIzms6r8wI5UC7cVooCROxcTBb6W/70YEcM0KYwdc8?=
 =?us-ascii?Q?LTTrTxjyTViKeWXmuvy/DRgnbttfD8xLiKz1J+weymwPkFjdi3RqOBO6S5z+?=
 =?us-ascii?Q?cP+t1gAki/D4tcpwL6oa/aOrLFK0LTLTOdwsbLARiF7cdgVy/aNQ8QGWv3Iv?=
 =?us-ascii?Q?dpdiBlSJ+eaICIBmQRk52V313dqD4KZUnsRKja7u7QZoXcP0cQQyw5ePUNsF?=
 =?us-ascii?Q?S6Mai3Imcc1w8jksfQpIwKQgoTUaUfRGg7ICLAj2isJziMOZC73HgDteFQdH?=
 =?us-ascii?Q?j5Z5IMqGPqifj48dcW5ZxLnO4TYWNKmTTooI2MjapSnSvDpRmLOaCT4GsB2V?=
 =?us-ascii?Q?rFPcg/NHO4v+DvUZ9wlyNVj7w6qbVgalEImeGGR7RWaz8vpeW6eqdkzl1qrT?=
 =?us-ascii?Q?0ml5wuanfTBTCrhEonqav7jhaBn7ohY+uDTBc2+Y5UipXozHT1X0IvpC4NwA?=
 =?us-ascii?Q?LiOKFM46ellf8ff2UPwmQKkf4WtNkBTt1VWlWnliVIyqYMDinq8LllkGxp1H?=
 =?us-ascii?Q?JIdshiW/e0SO/2odCVEIohH3IstExADZlPS0v0KdddvHYLJC+gDRyx/K87Yc?=
 =?us-ascii?Q?gDqWcyD4D9BSL2m+UvOmkFvIp6BNr6VRd0Wsf6cQtfhMtEt8aWy83y7+FzXy?=
 =?us-ascii?Q?Y+s+YFU1SKRgo0AndoAXR7g6bnJseGZoVC5EI2T04qHE0606tzmGsv4/iEM7?=
 =?us-ascii?Q?6gTWehtJC4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzqr0qAbmuRUQkVZu8uSZXchmhrNxsrkULjCms7tJz/X3rqnXua/bBV/G0NG?=
 =?us-ascii?Q?rVrJbxPceZFnIMfeLFEpyrGmBo4pNU6FH8POd2mqS1P03jjOefQ84rzzUYYy?=
 =?us-ascii?Q?kAwIii7i+WhHyfx39+chMrmAOtfbR/jRwuZ7Dp7TlGnD74nXa4oPqAMcOpMG?=
 =?us-ascii?Q?1GqXvofwQJUa4Q7JmQsaK+yxMa99/Of1qf33zyllicF92VoutC/fT+kjM6O6?=
 =?us-ascii?Q?KNVIZctjbgDVUhWJ7XM2iion50mCXSJ9CAqjXWj/FjCvRpnSgNBicLx3vVuu?=
 =?us-ascii?Q?3HeX8xFVq71fudqE5o6JFTgYN49GNapAy39iFI+OgBLfTkpZInoY7YRDl507?=
 =?us-ascii?Q?NwvR4JVxE7hEn+shHHObGWcH56+e5812I6TVGveOx9oSUSsAkfpY1JhmQcm+?=
 =?us-ascii?Q?SO9//6Obd4MW6GnbKF1QEVZrqlw/Dqhf8AJk7e49KFTWUiV90szij7b/dJc6?=
 =?us-ascii?Q?7k9H4AQQrXaATLPmCXh8l+cOfFYxvRCY5m3lzcX/PQQ0U1JTGSci5Cg50m8l?=
 =?us-ascii?Q?tlRS1eo6wnvw7sJDjA0x9WLoKSvXACrabR294RWmPhX46H8s0/sFWN66cgL/?=
 =?us-ascii?Q?M2fzOv/sUC6DypPyn16Jfnm3EgvorgaCVHwf+yDu6uFwFih//EjfoJU1bb56?=
 =?us-ascii?Q?D0yyqQWXwIFhuggLib+4gTQzW5zFIQ3tw32M+s3/EiRKCqXrx4m/EEGqAVJ5?=
 =?us-ascii?Q?aOg30RUartvd8ulH/ZSHMi5APCsz5CdzsQuZhg92xWgUkOjzEBrJply5dpx2?=
 =?us-ascii?Q?lPJGeMdhH+cMqZ/cacYsThXjLFbwadr6O7pxkQRRzcjmJ6CaclanN8LKCDrS?=
 =?us-ascii?Q?XRzi0cePZ68J6nBtc/jiRNdz45GegXmnmzyIQiG8j5v2QaJG9r2TTQlOWBLf?=
 =?us-ascii?Q?ZdDS4iz/ay+a8DVqzk4EEEM5oBbxGOEh3KvwVKaswY5tp9miUCXXfrsWBhYh?=
 =?us-ascii?Q?EnbrSPCAtf1HlsZV50TxdGwdvA7CXEyI0yOUCtLHTJ2bMFuMlVJV4G8OQJzl?=
 =?us-ascii?Q?2dfl5RZcplcOjR2TpZ6yqC1bufYEUnndzyADmDACAhJjuOjByeFPX7uvdGlV?=
 =?us-ascii?Q?ke/WWrhP7KIgiwrhrUYZ07JLzO89YHpgz+D7qKlWT7x3LcYJ3dFQHtPUl3Uh?=
 =?us-ascii?Q?iozkBaXG40H2DsA4DlChrUUXLQmBeWo/S9S2bA8AiOPHT+YpyDv/B1NY1BFl?=
 =?us-ascii?Q?nenG1y1DEF128/PVhwnbeP0ZOOyP91o9sdjzGhQo8n6JTgGsxwqKRTb5tO4J?=
 =?us-ascii?Q?5EEd2+m8PpCMc12PVBEoEKV64hAk05n/OguRo11rNFh9p6BCmLtRMFBdlLRq?=
 =?us-ascii?Q?dFlK6SwxlZenBZ7ba1ggZOXYROFdj6K1xJIJftSaMxCI2XZncItSe5tEO79/?=
 =?us-ascii?Q?DfanErH6H4bLYVZ8Ilkr6BRG6lsL9zdr8byEv2lV+YPVpXoR8WbLl7C31QjT?=
 =?us-ascii?Q?NRpCU/MHdFe0N42C4SXy5Bd1sK/9u3xU3nXjI/PACVRqBKlAtsVxTyRYVDry?=
 =?us-ascii?Q?hPjnmgOUgVrhs/lEblX3G9ri9sGCHVgr9PHIDzJDnmNgXfuvp8yj4+6F5pKQ?=
 =?us-ascii?Q?4lGx1YrJbKlTE09EFUL/Gh61Y0jTX98lN96+mMOHAqCPZBUI69jP7Lz2Hwbr?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab456097-adb1-4513-7eba-08ddc9fabd69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:08:11.5656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14PaEx24YlL0L944IIsGhneu5QqHK9WqzaptcwqeW0VlfFufN8KjjHzFF/ScWcTyXjLGrxP7J0f7TMcee/GTTLtOyxIz0136MvSZUQ1Z9ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
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

On Wed, Jul 23, 2025 at 03:31:53PM +0200, David Marchand wrote:
> Passing a NULL to strncmp is incorrect.
> 
>  + ------------------------------------------------------- +
>  + Test Suite : Test Cfgfile Unit Test Suite
>  + ------------------------------------------------------- +
> ../lib/cfgfile/rte_cfgfile.c:475:7: runtime error: null pointer passed as
> 	argument 2, which is declared to never be null
> 
> On the other hand, it seems the intent was to count all sections, so
> skip the whole loop and section name comparisons.
> 
> Fixes: c54e7234bc9e ("test/cfgfile: add basic unit tests")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  lib/cfgfile/rte_cfgfile.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
> index 8bbdcf146e..9723ec756f 100644
> --- a/lib/cfgfile/rte_cfgfile.c
> +++ b/lib/cfgfile/rte_cfgfile.c
> @@ -477,10 +477,14 @@ int rte_cfgfile_close(struct rte_cfgfile *cfg)
>  RTE_EXPORT_SYMBOL(rte_cfgfile_num_sections)
>  int
>  rte_cfgfile_num_sections(struct rte_cfgfile *cfg, const char *sectionname,
> -size_t length)
> +	size_t length)
>  {
> -	int i;
>  	int num_sections = 0;
> +	int i;
> +
> +	if (sectionname == NULL)
> +		return cfg->num_sections;
> +
>  	for (i = 0; i < cfg->num_sections; i++) {
>  		if (strncmp(cfg->sections[i].name, sectionname, length) == 0)
>  			num_sections++;
> -- 
> 2.50.0
> 
