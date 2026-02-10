Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD3EB26F3
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:56:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ED5F402E4;
	Tue, 10 Feb 2026 18:56:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 84181402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 18:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770746207; x=1802282207;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CMVgfXhDsvkzaqGX2pwbOW4q7ucBgAHTF0yOlibAEps=;
 b=PMRue7o9yaBnUlUQspj1AeAkUhzRRxr5NMLd3Zq8fVdQ1bOfVSd70y2G
 2lBgB88BcZniFu0d8iXYgIjGMqOmOphKozD/NHsny+cryj8HIP8+c+ozf
 qJC14If39cWsT2HwuJwX6VjhT5+ocQjvqQllofR4KuUtAhGtO8AuuBfh3
 TcQoZFCKfxOlhROPWFXZRynAMmN5sd1BS96EUxFlYlWeHn3D61NW/xU+a
 SaHHbdZ/JsAzhjLwj58bY8WbPWOlE+uMIbiVbi6IEg+sEIvdPnSocOIFv
 Z7EeNnTQ9jTXvZzs9YR0EnomJ3E6NbY0hgtAzRv9wyMC30PvhGdvALjfH w==;
X-CSE-ConnectionGUID: KM+ahL8yQ2CVZ1MUcDGxMA==
X-CSE-MsgGUID: CV7nAkYdSS6iBhEwhynsbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="70899674"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="70899674"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:56:45 -0800
X-CSE-ConnectionGUID: ofm6F2BQRqSb/KsExW8Qjw==
X-CSE-MsgGUID: ei81G/EsQrC8cK1MkxTWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211621117"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:56:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:56:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 09:56:45 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEqVqyMt+nBXjugRGbY2qV+bRqKZoINi+dE7lkaI+NKa8NZT1qiUgQnWcBINvr/D0HqrbIwVoAgY2o7n9uOrW8s3+YItetN9nDWP8H+X0n1kRbtCFU0vYcnuYRZbtO840fBQrEl0GhpagBKOyJYakGXyIDZP8mD754rUXtWUEdVxFFXeNspCVLCckDOWhqZTVV9qT0nhDWOTKLGMrAuGJQVJe5hDP4klCFaAjk/ZrYFixNoDKSocoWq4Pj0LHw7VujS2PhS6rBKjM0D596W429BUaMBA8aY2GpVCdmMK9+SzNNnvjKwZrwbnCt8rE+4id9XcL6+/clW22i54I/QPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBU3/PvdTKn78g4cCC2Wvf4fhuYIUTUrsssWXIOZZqQ=;
 b=vxTdGLzw/J3yFzUZROBkjlcmkZeamVo6mbeSb5yzhl8vS2dFqYRhbF3nnQkKh2OBwE9n4X/3sqjp/qh/znkOxAeORoTX5fzzWefPRLh1f3LIkyMvhZrjMh7XGOwzOHe5qBGOAySdlAdSL5w1NNHEY1N+YWVKQqAABPthubP7jedG20NBKpAcFY5M3mkrzOGY0p4Nry72Zq8m6tOcJnSoGHiDHPjLdalHXKZFk+Ljbl5z2OYs5L2r5c5kAeGtgled5BzLrWaUulUQBn7RwrxU6VgOJmGbDLpVKd9MN/TEqvGnAcsPO7goWiw3hJZi60LhZhO+dTT7LG/jP9oSddHcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 17:56:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:56:41 +0000
Date: Tue, 10 Feb 2026 17:56:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 10/35] net/intel: create common checksum Tx offload
 function
Message-ID: <aYtxVKRlVUHGYfjA@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-11-bruce.richardson@intel.com>
 <0862456e-6f40-4134-ba33-6ce4e461c8b8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0862456e-6f40-4134-ba33-6ce4e461c8b8@intel.com>
X-ClientProxiedBy: DUZPR01CA0203.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: adef252e-b821-4409-354e-08de68cdbedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSAt91YuMDjenIZF6Wi3HKIirLDDydpJMXf6JcAsGi4R/lYon6HauyC+mUIG?=
 =?us-ascii?Q?L0v06rOpcMG5scG1i4VFqU4eQPju71tKhHQ2J1KILerFjlwisn+ln8POJb4X?=
 =?us-ascii?Q?ZQDHvMFR1ComVEGNyvAMIJ+ExxEDEoXhmWi1FNXf3hSJwMgw67fBhIAEVCFY?=
 =?us-ascii?Q?Kz6K8n6JwlWFqIhhjJ5X8JdRMeT0W1rDSsdGGT1E6J/RySHm9sfIYugFT4AZ?=
 =?us-ascii?Q?1ah8r0gpLmDQ/Dg+jA6ibpXrNj4kfAHr4d8EteCLH+FB7oz9k9OJlnOBZQNd?=
 =?us-ascii?Q?/lHR4taYpCDi1+Ja4FgZRht9bDgTtTW3jXJVmD3i/wwlcYAvlaRmQ2YN7lSU?=
 =?us-ascii?Q?1asNeGZwsmVi1VNErxY62LIhblLwNGAEhczhXiT44B9vFX+g4wpP4n+XD4ZS?=
 =?us-ascii?Q?QMl6a9k92CNpRrTuRxqfgYD79ecxoatDU/FhcWvnDZ2VXL84RvaBZU8xxTLo?=
 =?us-ascii?Q?oTVSdTQ7nQbceDbNVg+G8qc0pLuv4eGIuFtf7hvTn2PO26JvutwnbIdxrmNI?=
 =?us-ascii?Q?EBKFekg/3NKk5rcJ0tSJtfo8kV6U+M28eeBOSsSOtkLx+GWJLMxb692jUWvX?=
 =?us-ascii?Q?lDsppCnylQ4tcnOWlgANf19CfN/zJDIiv85+oc5Z1VZcipl6NTbp0D49DV4K?=
 =?us-ascii?Q?/MzWgeSN3inG1WLs+2JTwnLryBS2F8NMRZxOHJHVdni4i0cUhoNi/8N8wsdH?=
 =?us-ascii?Q?vrw4JOalOYQ5fYS7vXOhe3pN0J1QRVtHagqmIUl7QZK3blIbqTPsBLBGq61+?=
 =?us-ascii?Q?3hvaiv9tLz+U3la8vp3nj+3XWseNd/bbBcwYkDdDKe2HdjdjTOy8Lfeh74+p?=
 =?us-ascii?Q?yt99UBsjfnv9sNpvzEo2X09NtHzBEk9mrwuMf1gTly+NUwQ/+2yAY1EZCVNs?=
 =?us-ascii?Q?iJ4hhF9dWoKxS5KOtcfmVxv7RgK2ebg7cxxykUplUVJmIDkKnlufgtvbfo0L?=
 =?us-ascii?Q?zakARxim13RMgPRppG438CKqPrLw8vfBYo1bD/DNVZiErzdPFA9jTLrXVxPb?=
 =?us-ascii?Q?Cr9H6vJo2lBzFHJ2G4P8sUmduNQ6bQN1R0IEra7ZJy71MbRGPhYWHVzmR9J9?=
 =?us-ascii?Q?iwCrmvneaFJ7WzpsvvJyHT8UhFsYNTa09bKJO79Syvv8D2GwJ/ZaoG4bXafx?=
 =?us-ascii?Q?2VMn+cYY/VF9a4J/rFzTYjgNc0+UC5ltObuAXGviPKzDwidPHiYmnqSw0qI1?=
 =?us-ascii?Q?mPL63y8tYntsfqXA5ouvPXyxmuHXCwvhzPb3q54lpx3Nb8wKGA8PGc22uL9W?=
 =?us-ascii?Q?UGM7DVMCGhe1eji0+AslzHCj6I2PVecmKb5YuKH1+ifKBmAlSvt6UmPMXh1L?=
 =?us-ascii?Q?nenwIohdQx32PmPT0xInHDjauuzKmxzlUjs2BO/gSE5uCrOcVkUvKH9Uic5Z?=
 =?us-ascii?Q?UkJvJC+Oo0oIrQBsHf3YBQpaVeCTQUqR0aa/u2TMpRp1GkPYuDeDsDrYDw1v?=
 =?us-ascii?Q?V9jBnAhaxuB6TyudnGwxh2JXXHsjlWQqAay5qwNTAShylkuM81QWdlc1DWdh?=
 =?us-ascii?Q?TntPWJhYgT1D2cmICnGmdUGV4E2H1iNZGSJrP8qKz7XukgcTOK61RNIVJdnL?=
 =?us-ascii?Q?+HmUrJE2+p/cccJwY30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQ9mYkyTu2aoXjJoJDQYnVLd3+Zvkpd7mkYnS+Ys1hBUBBQPNaxh6A9Vo2a3?=
 =?us-ascii?Q?uFsIUYylSv/a7sbazjH/lLdxiNcIYSv9uhe7COxAbcTsv8wk9uuREH2pGs52?=
 =?us-ascii?Q?t0ANpvnPMbcRrEWLSsq8rqPK3k+WK3jWqQld9+4ItfBPyVT6QgfNwstXgcoa?=
 =?us-ascii?Q?hFlwca13jq8nREiN3RGMl8uo3uMuMPIXp8FhI5WN8ZFPsJijc9bWTNkiyaw4?=
 =?us-ascii?Q?REDRHFqnMOyx0HFYjlQHKWeeroUkgLk3ZoHeTzGdlW7L2NVJOdNNe27nMbSc?=
 =?us-ascii?Q?5MDcItf5UzS8tcAvm8KyqoiNR9ZRdXPrOqsU/ljs6KfHrPRK9sY4y6wfA8i9?=
 =?us-ascii?Q?DKZ7qun+7XUqcNsPg/tbm8OSGM64pwn4JKcaXbVor9fVooARXM73TJiFoPRx?=
 =?us-ascii?Q?Wn7r7KM2VF/zzKVgh0zz0U1SlIuoLW7RxU8Ty6MkZ7IXtQ82bhB11+3laNvA?=
 =?us-ascii?Q?22P7MCAg5waDCfWsDO8TokTF9WBVid2SImWJvxSTQg89uUN7Rnz77iJSY79u?=
 =?us-ascii?Q?ZWFYxN9wrFouYyP5HfTia5etUu2Gkd+IBtVxn7F9OI29YQ5kKUhawh3WZ4DZ?=
 =?us-ascii?Q?PutwRCtxya1xvSw6mo8I7MFHXhwe8CgvwR+i/B/Ps4BUV+EunSw5dyoz2Pw0?=
 =?us-ascii?Q?wYi6T+JEUVmejotQMHlJJfse37IC3JLigs3PZPhMxlGESpVODF5RYOzdZ1bo?=
 =?us-ascii?Q?hNDqE/if05zHsiWBQykBv/f4ILM+NnTf52X1AsgwJqUw75ul0A9Wt15G2p0h?=
 =?us-ascii?Q?v7eQxOhCOQVaRbWdKJroYh6dmDm04aqPLD4S0VJ10Uq1e4jo+JbQ+vUrQZIa?=
 =?us-ascii?Q?mG6jY1g/YEq8mb3jJ8yFMAfUt4bq3gW2heAuXHkwfZ855SVIptPJ+4YyHs17?=
 =?us-ascii?Q?j0LWiUw/Tdtq7VwYJcGaZk/HOEwo+9L7BdW51UFGPQykYUHerS20HXz6iUBa?=
 =?us-ascii?Q?ctLwON0ihI8PFuu0X3kFFXo77Fg0YkSuIXhVd71dvU5A9W6ZVSr8H5T/sOb/?=
 =?us-ascii?Q?rIEu+Iq6wPGDZbDz/Sy2yYUu1kGxk5b1/I6zf9ndKcR+YS+upbtlBS8Wtv2p?=
 =?us-ascii?Q?x1uP7E8AmO2fJUemev4ZTbGJPt3HZtdqs08c86FFcXp9bhzY2cv1Lf/X7dnr?=
 =?us-ascii?Q?AkzBJhC5YzHlNNh+jYVJcU1u75SELwZ7+DSMUvowVSKSQ+MoFDcQJuLYLTqE?=
 =?us-ascii?Q?VQQZWoAOzPdedPAJ/SqonWHMvw1PfcIu9GHeIuM/dd8ernC/aEpXZ4psBL6g?=
 =?us-ascii?Q?MpI87+MY3EovnTsHmW+zMMUvazKC1p6DDdvzQHhG9T06Y/JpSiJ4eOyHXbR2?=
 =?us-ascii?Q?Mb5LTh4jI4MHMOnGiHmXx+SO+9LIw9EqWlGZ+9zwsOjt2M4SDKFHEcClt2r5?=
 =?us-ascii?Q?lqzN1QFT4LTnq5qzgNTwfOD5LArjbKijwqPiaICGauxSIIXKXOlm5oNAu7zb?=
 =?us-ascii?Q?hvh4jjPTeW9gQPZh+Ht/vHxJ2K2bzLGF3vxvCLWvnDEHzUnlNMSV8EiTz5XG?=
 =?us-ascii?Q?eAwOwoZUb+vZTUPoTIgh+cidjww40x+hlw3EO9pWqp+8dIdZUKi4pvqDoMNe?=
 =?us-ascii?Q?eYO2yxpGjFDG1UQO3Ylz3UPkf44zsrOLdTIq8+Jt0LHPvxwNCWs92+ZcsP8+?=
 =?us-ascii?Q?IA/oa8jXJcaD2O2mwtDhw2MDa6PebRJz+91sPKseNYbbjDb4AVKIOjtTeEFf?=
 =?us-ascii?Q?BBMui6fXRjItEbJ40rz3UG0WluNI3Cj+ezG/qaXVMGHXEcZv4H/M0R3i+TBS?=
 =?us-ascii?Q?JRrUpIkyLrKvkn/KrYIAMFHp9NgiV34=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adef252e-b821-4409-354e-08de68cdbedf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:56:41.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2M3caRwUwUYd8KPt5hGjPWjCc07L1+bvGV0esjOfVizfCJOz5N1vDwvBvc73zwXduRisJSd9r4ta6eMkEnqyFIYEjSOHxYOifQW1yvI9LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7621
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

On Tue, Feb 10, 2026 at 02:04:55PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Since i40e and ice have the same checksum offload logic, merge their
> > functions into one. Future rework should enable this to be used by more
> > drivers also.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ---
> > drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++++
> > drivers/net/intel/i40e/i40e_rxtx.c   | 52 +-----------------------
> > drivers/net/intel/i40e/i40e_rxtx.h   |  1 +
> > drivers/net/intel/ice/ice_rxtx.c     | 60 +---------------------------
> > drivers/net/intel/ice/ice_rxtx.h     |  1 + 5 files changed, 62
> > insertions(+), 110 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx_scalar.h
> > b/drivers/net/intel/common/tx_scalar.h index 573f5136a9..cf0dcb4b2c
> > 100644 --- a/drivers/net/intel/common/tx_scalar.h +++
> > b/drivers/net/intel/common/tx_scalar.h @@ -59,6 +59,64 @@
> > ci_tx_xmit_cleanup(struct ci_tx_queue *txq) return 0; } +/* Common
> > checksum enable function for Intel drivers (ice, i40e, etc.) */ +static
> > inline void +ci_txd_enable_checksum(uint64_t ol_flags, +
> > uint32_t *td_cmd, +		       uint32_t *td_offset, +
> > union ci_tx_offload tx_offload) +{ +	/* Enable L3 checksum
> > offloads */ +	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) { +
> > *td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM; +		*td_offset |=
> > (tx_offload.l3_len >> 2) << +
> > CI_TX_DESC_LEN_IPLEN_S; +	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
> > +		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4; +		*td_offset
> > |= (tx_offload.l3_len >> 2) << +
> > CI_TX_DESC_LEN_IPLEN_S; +	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
> > +		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6; +		*td_offset
> > |= (tx_offload.l3_len >> 2) << +
> > CI_TX_DESC_LEN_IPLEN_S; +	} + +	if (ol_flags &
> > RTE_MBUF_F_TX_TCP_SEG) { +		*td_cmd |=
> > CI_TX_DESC_CMD_L4T_EOFT_TCP; +		*td_offset |=
> > (tx_offload.l4_len >> 2) << +
> > CI_TX_DESC_LEN_L4_LEN_S; +		return; +	} + +	if
> > (ol_flags & RTE_MBUF_F_TX_UDP_SEG) { +		*td_cmd |=
> > CI_TX_DESC_CMD_L4T_EOFT_UDP; +		*td_offset |=
> > (tx_offload.l4_len >> 2) << +
> > CI_TX_DESC_LEN_L4_LEN_S; +		return; +	} + +	/* Enable
> > L4 checksum offloads */ +	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
> > +	case RTE_MBUF_F_TX_TCP_CKSUM: +		*td_cmd |=
> > CI_TX_DESC_CMD_L4T_EOFT_TCP; +		*td_offset |=
> > (sizeof(struct rte_tcp_hdr) >> 2) << +
> > CI_TX_DESC_LEN_L4_LEN_S; +		break; +	case
> > RTE_MBUF_F_TX_SCTP_CKSUM: +		*td_cmd |=
> > CI_TX_DESC_CMD_L4T_EOFT_SCTP; +		*td_offset |=
> > (sizeof(struct rte_sctp_hdr) >> 2) << +
> > CI_TX_DESC_LEN_L4_LEN_S; +		break; +	case
> > RTE_MBUF_F_TX_UDP_CKSUM: +		*td_cmd |=
> > CI_TX_DESC_CMD_L4T_EOFT_UDP; +		*td_offset |=
> > (sizeof(struct rte_udp_hdr) >> 2) << +
> > CI_TX_DESC_LEN_L4_LEN_S; +		break; +	default: +
> > break; +	}
> 
> Nitpick: some of the indentation here is inconststent. Perhaps enabling
> whitespace view in your editor would help, if you haven't done so?
> 
> (the inconsistency was already present in the ice function but that
> doesn't mean we have to copy it!)
> 
Yep, I suspect the indentation was meant to align with opening braces but
that of course gets messed up when renaming things in refactoring (or in
this case adding in an extra "*" dereference char). Will clean this up in
v5.

/Bruce
