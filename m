Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D1BC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 14:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A11B3402CB;
	Fri, 28 Mar 2025 15:50:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id CED6D402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 15:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743173404; x=1774709404;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+56LGusYftst8WbIykuv4T41LYV0/JV7H1EUJt3wbag=;
 b=SCNnP4Ol9lRYUI9hm9cAbxgPO0RdGqGwlsCRIlYXfoeo4f+2N877hyU6
 0+ujFuUWd6Vv1N93alkJIcGIMVvjuKKEDxrP5jkLu8yjrPxL0IxZCngQB
 8JF3c2psjyS94XsT1h4KM+Wzfl7a08uqatNDjWY/ImOLzYQM43p6Ee3qm
 SXq0sr5eLOI8Q9DML1HGOnItc1uFsTFbjp7X3pi40Puic01grc+bryiov
 veNb4J40jj6/WRC6JKRmqygON7YDJScEH4D1S02Pq22qn2YdSLmMTnZSi
 Grrnxhwm7UBzB6MlNxeeOgLY8Xlt0+FNuwn6LCGQX8wwZuT1AzhnvnMAy Q==;
X-CSE-ConnectionGUID: 6jcTgueAROaP3QnRUl1CUA==
X-CSE-MsgGUID: ySJbRgmtSOuvwz99vUxNfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44420969"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44420969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 07:50:02 -0700
X-CSE-ConnectionGUID: FmM3qNO/SKGS+11hclPO1w==
X-CSE-MsgGUID: YFNb2c6+SZ+RfiN9pVFWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125469719"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 07:50:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 07:50:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 07:50:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 07:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+oCm53Y4tUEyxB4dSt5qCLvk87HOXsD57QFHFydjU/EmV5BQZIqR0aVfiQSUyACx0NjBQQzIlgNfFJAMHgMKzCCErLLj2rxHsDc5+1AajVNNjL2zM7phtIoJIwTGYn1Tz+OcH+vDFNbw348LoycNpmcXYSzeKIrqODhNC2FN+XFPstEmhNFUTJkZBQcY2a8URMfR3iPXKWvB7sSEgDle31Mi8FOgZAjUi0AkWrmo3O8eY5WNR0qlfQE4L1YtqFwO3e9skmntopn67BwxrL7Glo+9B+Jq5jEcLCZ1/hiLm/2gzJhdhWD7j7q/8vvwBSQXK779uLJt77J2qrEg5r8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LblijEqrzuTM18N3tYZ0GH9KEeIXwD4j6MC3gdB9Fas=;
 b=b2cAz9RrEIcS3bjEtckwavSCJzPDe2OtbXlpRYo2K9LQZ9vRVUpKFxd2gHPXxw9jy+3aWlV2ZM0XZqLS0urHTRY+924SNP77FpdtROzcDdiJLtM8sxBTYlkzywtkfvsBMD0LlJf5a/byYEjxvGwh1TgbVR9d1jvMTFPNobyh6tBKDhmydp6hZscR4b4iMwkqMWi7EquI7Oy9M56w0S6AFao69Mi3JGeaD2p2heFWHLETccNBV/gy207rLBH7iIaqIQHEbeJH89l0yxooMK3x6C028v+GmuzYLe2IFPoBw3Xn4emmYh5343bBzHyDIhydAUTFLCXo23bxQP9TTm+HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:49:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:49:57 +0000
Date: Fri, 28 Mar 2025 14:49:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/intel: allow fast-free to empty cache
Message-ID: <Z-a3ELVHCCbvyDIl@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: ae78e66d-08fa-468b-18e9-08dd6e07ceff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Mg1pKYgnJzX1W/6r3GXe0WTW6ESAdOeycuQZmm0YyMjcR2qnk9HhhaTsup?=
 =?iso-8859-1?Q?gBc+/9QHHLUmgRqvFW7mX7C7rDzudw/78Ytx5ZY5w+x0rRyVAvxqlW9xAZ?=
 =?iso-8859-1?Q?G0maHa0a9YGIudY5nQjISr6DU+yKdppQc6fGQZiYMf74aj07Jj8pEG3ndv?=
 =?iso-8859-1?Q?2EqCiOjcXJQanZoewLIPyCLq4UZNfeiknrNfUu/1Vj93gU/34zfrDh5+lL?=
 =?iso-8859-1?Q?kaPEr/MlUId/DeotQAHtVht9lLUkaqOfw/+O5XR3MbL1ngfVnrZ0eXr4uz?=
 =?iso-8859-1?Q?kEENCZSOVycF919Lueypinlq//GopnTM1MCbRa/nZKVpoqwQq/6sK36stX?=
 =?iso-8859-1?Q?pGwIDrXWJ7kmFUyTlVgyv9mf8QAGr0tRcuyKiPSn/gt289Mw8qsmdDooaA?=
 =?iso-8859-1?Q?ZbDgXRIC/Jgq0W404Kt/yXmAPYP9Zd8d/sCvH8qFvUQC1lyLYq3b36+FHC?=
 =?iso-8859-1?Q?UJ0r3RYnigSANXwBZK4LqywFh7jZsvcglW8bbp2SkbR9WVl8U7N+JB7rYQ?=
 =?iso-8859-1?Q?1NFAdI07Yo/RAr5M2NeZ9EvsHupHS6szjy58lJOmsfyMPpCQ6EzUzt1Mcm?=
 =?iso-8859-1?Q?4Ars92wBflZOPiAWUaZdQZRoYqLWYH45SAJMS8m1wS8n/qVF/XBs090LRf?=
 =?iso-8859-1?Q?t/M84jVFx5Z4O/7ixktc+9i4t3zumo7zSGtNzjV1V9BT5gu+Ww4iSPzYDx?=
 =?iso-8859-1?Q?nn2zTMt5XDDc8lnprAO/7+FAzW+CPY/wx/k428E05nlGLh6sAaodSkI/75?=
 =?iso-8859-1?Q?kykH/UwvE1/O5MiR6pAiZ6gIn4e9uAyLfCaYORn0q6bF0hNQ3+FTpjPcKY?=
 =?iso-8859-1?Q?ZoPsARDZ7k+GILzxXCIAMVkbLtWw4rnc5j/xF9o0/j+wdyOIWxodeGZzUP?=
 =?iso-8859-1?Q?50DMJ5kO+wMPnDNC5jd5c2UNpoQ2d8xHpUddGDSIdTIjsVHawbd2PiRUV2?=
 =?iso-8859-1?Q?ubSi+PgVPjeAnM8VH+7HMicd0dJ6SA5EVdzNs+tfx4j1i2TPG5eINDWhsQ?=
 =?iso-8859-1?Q?i+b0m0r7AnU0np9QCdiiLwtwWb1MwPDAzDj6HjdqxgNYw3ndmmnjgO7eDF?=
 =?iso-8859-1?Q?ubSQ4BwYD2hCourdacFYcVt7076wosXhB56e/0GueMjrAgERgJyvlgVnyd?=
 =?iso-8859-1?Q?wurfsClco09CZV5DrJU++Uqab3iVU1ly7oVuyv69NSYMHCzQW/TcE9ZRlo?=
 =?iso-8859-1?Q?xxC5i/LuOxbJtqQSPvxqBdTnJIzH9frpRhds986XurzI2tGLT6ZbsIArMK?=
 =?iso-8859-1?Q?5e9zgPFxE0mcbyWI3PAnAS2JOmv11LOUkKtDAOt02bDrwMrs/IKn1ZQUlG?=
 =?iso-8859-1?Q?Y8RaRng2UlbvKaGZI2/1XxdZ7pL04t0FFOT4iyXmdzqpg9nO7suqvScKBh?=
 =?iso-8859-1?Q?rXDAw9jbZpl4DZrBE1puOqcfDIoEvk36DkCj7XoDslTUPvSbXkDYkwZk75?=
 =?iso-8859-1?Q?wutVkDPRELi4RlUC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?R7ZZ9JszFWy4+A9/edGPj2asJyyg9CTFxLgraPtEFu8wgRbxOAaihcbWXT?=
 =?iso-8859-1?Q?7fj7J6EA44yGOCiCkOsSVgLAmQIYhUZnk3KgmxnJAzqx8zpq9upe768Hnl?=
 =?iso-8859-1?Q?ALIF3/Da5xewUdlpec5is0Yw9/CLFbyfzfMGEtiKsFaGCKy5TG5xUvL9hx?=
 =?iso-8859-1?Q?9OdV6tvMq4ak48RXngi1uGlroJ5gvEajFJXhJ9CtBWCd4iXnKVTU9Dy8BL?=
 =?iso-8859-1?Q?lk9z0Muq0B/BfB5IqqDe11EL7nb49DNeUbnVWcBs/irYAJk90Phzgioj/+?=
 =?iso-8859-1?Q?BKE5+Zo9I3S2nZX5qASAOS6A1VVfxHRcmgUzo0khOL+HG/K9UBut2A3Oox?=
 =?iso-8859-1?Q?wpaT29PP0jifGcfJXSEKKyOomH1tFivm1f/bCbZoU/4TxGBruVmGjNnUKr?=
 =?iso-8859-1?Q?9QlsOYXz04G/aDK27yIkWQTk0ijZQJmApnLuLx7cGDFvuyFE72vSxAYK0B?=
 =?iso-8859-1?Q?96TJxcOWm8wcUSFfhVq2TDT0a1ThPMhdwXVPRM1aBv2kYTi1Xmh+KEmq4Y?=
 =?iso-8859-1?Q?Vp9JWgU6w+OW/boBPf/qkD9MizNw+SQgW+6Au0I/+Wr8k9bF2Taed2ZwWK?=
 =?iso-8859-1?Q?A1FHrIvyPsAzleP397me5PYg7nsod27wt8WscewQHasNCaV8h8N9FRELf6?=
 =?iso-8859-1?Q?J6CazHAdON1cQJK0K4CgmXkvOtmhLKP1BHsllTDIS2U/Ec5ksKWLjpYVOa?=
 =?iso-8859-1?Q?bYfkS1GqZAPm4xcAeAE0E4bvB3dbTDtAnCP+cKO6ihs3lAjtSYnULxdAa3?=
 =?iso-8859-1?Q?rM9pJk93NALoFrMhUQMwYiMWaQj/kbnJtUm6UrV3e3J6IIZ4AHNuExi+z7?=
 =?iso-8859-1?Q?3V64haoHbDOb7ySAmUGwBksDIaWPFJbvGnC959lHEJHRJTiXwg6Soswsci?=
 =?iso-8859-1?Q?o3XvFyX3rXgYcL489rNvo+T5zRC7n5wRrziViAm5kyXTj40dSbi/eWHiCk?=
 =?iso-8859-1?Q?mDDbvJwWmJBVG8SuKPtUTyjuss++u6LxXOJGBM8s5FzbpOopZr08kFAvNO?=
 =?iso-8859-1?Q?Kic+CPyi3IX0xpRf8+FptdbNtup3DxoOmfhQ3xuZSytMIFWQxT+J7MT8uZ?=
 =?iso-8859-1?Q?fPUBzcpqNG+mwPMrh1V5v5S6FJxc9DiB9ni2G4ekRDOdhCYt+1dR4kjmWZ?=
 =?iso-8859-1?Q?Kw+sMhAbEiGc+IUIN9pV6lYgATx2xgU/wVLog9nSRjuipPIRHVUTaWSxdW?=
 =?iso-8859-1?Q?3yJAcrMGMst91T1hgadUTVWRIqiI34rInCUfuNZJK5JxFvQrCYYTHwcuKb?=
 =?iso-8859-1?Q?T8JOgKSqXMyRV4VCPkoLX40T37D4yl2/KsG/gWEhYNRwIfvt6anEznvTTd?=
 =?iso-8859-1?Q?fjZLcIy4HpEyxVge8bVP7YcR9qb8viCLKgWQqpRHG+D7cfkf1i6/JF7IDP?=
 =?iso-8859-1?Q?u4fBxSGoXipD/BZrbyMUEKfcMqODd4td20qt0d1OglNB0wrqE0+l+3ADBm?=
 =?iso-8859-1?Q?3Es3u7hJ09diTlIOS44JpST0OMNwNar4QjGy5+K0v65Yoab8gP+v3AROmg?=
 =?iso-8859-1?Q?PaepcrJM5fLVgL437qLC7/qwlWoVJw7oMdPjUSojemLcufwcEAiPquqYN2?=
 =?iso-8859-1?Q?sxtSe5iGYsrMGiXZzcYwpz6D6X5Dp4+mHU8oEqieE5QVQDcJwuB3o5vism?=
 =?iso-8859-1?Q?fueP39/zWI3xlKb4N/E83LcOFLia0vhTZPblBSEOHpqQi9NSocQgeSaw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae78e66d-08fa-468b-18e9-08dd6e07ceff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:49:57.5988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lYgOxNEDNE5A9OpIiRe8vdAuYcWNJgGL4FcP+GJ5x+qE1bKJYWlSJsL577gnC10t7c8I3lmbnMqgvVFWdKm7mDHsdQi+psGln/I7LfuXn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
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

On Mon, Mar 10, 2025 at 04:18:35PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 10 March 2025 14.26
> > 
> > When freeing transmitted mbufs, there is no reason to send the freed
> > mbufs directly to the ring if the cache is empty - only if it is zero
> > size (in which case the cache pointer is NULL). Therefore, remove the
> > empty check and only check for a null cache pointer.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h
> > b/drivers/net/intel/common/tx.h
> > index d9cf4474fc..d361fe64ab 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > ci_desc_done_fn desc_done, bool ctx
> >  		void **cache_objs;
> >  		struct rte_mempool_cache *cache =
> > rte_mempool_default_cache(mp, rte_lcore_id());
> > 
> > -		if (!cache || cache->len == 0)
> > +		if (cache == NULL)
> >  			goto normal;
> > 
> >  		cache_objs = &cache->objs[cache->len];
> > --
> > 2.43.0
> 
> Yep, it did look strange.
> Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
