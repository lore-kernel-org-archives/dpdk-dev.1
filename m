Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE6C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6791402E1;
	Mon, 10 Mar 2025 16:27:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9989C400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741620471; x=1773156471;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SFVg8HYpUzvCZgA1JjXmZ5s4ZvNEX85HGBzADbR4uC4=;
 b=aobLg9ot5VdLtCiabpVi28etuXMaIXbSEjUZ9L/zm2YuNQczSE5JmBPr
 wQuXuwiij6435mwswJMmNR/bHoVNkQwFvWkRd92Fj7sVv00d100yh8r5D
 68CYpv63Vk06gPxz2D3EojlY8SwIZHYntJQ/ybvOEv0y56sWYDk+eFePH
 Spgg4gbonCnPWKuZ7Wq5I9l34dFkJejI0m4glkXHH9FORUhYbwLS6A44g
 LKSSW731nMmIZuFxal7pbLLu4yaQwJ+x0S1tPJcWLROaIZMTRJxIePmJp
 cmJS9p2P2tJm/68eNCWgSJkEtsbzrMR+Fs8bIuIW0wyQ1KEb4t2xTFWl1 w==;
X-CSE-ConnectionGUID: HWNXapELR3yRdY4kKz32cw==
X-CSE-MsgGUID: 9QmVLUKhQ66ITTcs7FCY8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42814009"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="42814009"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 08:27:43 -0700
X-CSE-ConnectionGUID: X3aAxAkpThiHjlYLdzqmIQ==
X-CSE-MsgGUID: +3acvHg/Sw2w5DI+S3jt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="125035296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Mar 2025 08:27:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 08:27:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 08:27:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 08:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giKUTCayzdmpS/ZUZ2Tliv0NXxtZ4si9tpDSoEohH7RZJemhv7wc8VqpsTueu1oWYZnxK3LTwj9NPWMEUJ2AZu4Z7Ba66HTRIVPfM2fmDNXMnUEV4iUhp0BQfw6toKmLY95p1wqyDif+z2aeCRgX7BzdetR798aNGt7boBEAH+BO04rSCBHKTv66QfHZK2NwBMnkYvNvguEoqFySsx/xkkfISB3I4bHlRGIlcsiO/nm5bz4jQCK0v0xS7N2k3QwfXehgZ/FAPF023iIS4b2BpbzS9E/kOKihahUWBMAtSSTDGNmU1JcwVXnyKDn3+Dc/KuOEIwVV/M5j2qbZN3ThJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv+X9K3MZjbOdIjvVUv22cxhAUgncB/SJJ+9sMWKmqU=;
 b=jSQlh9FAy2NfOCh4IUTt6zECZxbBwIqruBq5FJNhPcqExomTA51kRa9MqiOQ644XqUN0T2BKGBxETDMVvkQQxrnDS7Jfs0Fu7y93eHjYq2w8ZED9ZuFJZy42OFxjRW7Tac7MTnbC2VAEMBqkYuMigIGwmsvRS/tGaLHTmGz4PW5F9hR4PqNZEQ9SbmlH2rBUs67WzHgmUOvC8esV3m4fDG7El20X1+nSV80CYDkHubgUN1Toz7FVBkh+E8h3jRo3WLxBfF6ZrivelMCoUS4QKDPv8tA11YkCvJDgGGhA/8mdww08oqSSpFBQEgVPZBlvHkrg9wRPJgi0eqyoPpflkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:27:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:27:33 +0000
Date: Mon, 10 Mar 2025 15:27:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/intel: allow fast-free to empty cache
Message-ID: <Z88E30q5IkJvISW5@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a60bf82-66bf-4262-6408-08dd5fe813fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?o86evRhohl1scKUNU2Q1nQoPHuBPA86yO5KdNt5Lqi6VSBBgdnoq6qeQ3M?=
 =?iso-8859-1?Q?tB70g/dVnLAvun+Z7pzYjZ3gMHoMnb6j50TefacJj+kAuuOMrIdg1EqgM9?=
 =?iso-8859-1?Q?EH8hb00Bi7jK6Zrcg003s5Qfg6uT1ga7LvinhPkBZX+HWpW04HQMqXaPBQ?=
 =?iso-8859-1?Q?TehYDmVBYe+fcDtViKyUl1XZcQHikY5u9YEq93lvXvtX4uDcia9QaSI84W?=
 =?iso-8859-1?Q?fXHIBrcSjyB2w6jYSVyIqT+LIgb87gFUzUSBCLNn33NNbh3ONTpOpMyA5i?=
 =?iso-8859-1?Q?qlNK8lMtMluDZPrkeoYXyb88EgM0RjkRgLAHiUdDBNB8E3T6hWxI6Ul9W0?=
 =?iso-8859-1?Q?DLYlq0szKAxN+zsmHPy6tVY4AjY1JGrrCMhhV2JmPjiMt3FneoAYvLLoYQ?=
 =?iso-8859-1?Q?HJTG58wbxEScU9w1t4/gPLfOA5ZwiYPmckLmTfuyQZCMNOZR0bF6+CCX7Q?=
 =?iso-8859-1?Q?ofk+BMU3bBFXm2FVJDdGxwEWjHV+FvOLx4wNXSX8rkxC+BpZvLgEF1GR5y?=
 =?iso-8859-1?Q?wqCGSL7vOHVxUOo3OdzYCNsv9wrY4cI8ADI6JAsjouvt9FzJX0WMuH5BOV?=
 =?iso-8859-1?Q?AGKGNtdKSlqu/69t7DxwMlQ16QTBHnzdhbCjuQOGM608aYrVLM1IxodBs/?=
 =?iso-8859-1?Q?Qkxz98BI7eThjkKlV/OiQhk0G3/1wGgLdwXTuc3BbzlFISCWHzMkZ54bAB?=
 =?iso-8859-1?Q?8ePihEi3Izne9RBEhXlABc7Q1QOYo3jrXAo6K4lLPz0D1CB8kcHx0dHHbL?=
 =?iso-8859-1?Q?GQYOw1R2PgRiSsOdHwp1uCBnMBW454R++uFcdYp2qlst0rwUmiAePQs7Of?=
 =?iso-8859-1?Q?DLSLs/DkSw3EYoPW5PvMR4ohfkis8bkPeHvNyHJqbXycubzbOUw2DphVEZ?=
 =?iso-8859-1?Q?iN1Z9L32dkN8U/dCm4EcnrCa40wiHUSyRe6YHk5JQJ90V4vCnHRsfUoJgT?=
 =?iso-8859-1?Q?/plhLUSQe4ejIgsiq0G+19y83ecLnknNgLix64bToesBT+anYZk6vRyaWO?=
 =?iso-8859-1?Q?yTFjuwRA6hEfvl8TDlr1RzVxPPn9BBXDqTlhCfOiGGERsXwL4opLRSfw22?=
 =?iso-8859-1?Q?KEv7G9LtN7SXj/3v0RuA2M3ts6H5qdqYSdl6zicGis8DVy2Q4XpJj7fG6g?=
 =?iso-8859-1?Q?s2q99ZOo2m6ZwRZ6+xoDpOsFcE5HzVo8cRdlVTduJ2HbGcsQoLGfy7jT01?=
 =?iso-8859-1?Q?/bGE1u1//NSL4aZe/91MujpF7H3N2CBxz+maX/w3emYGs/VHp0v21ApIKV?=
 =?iso-8859-1?Q?J+ZobYSUVDZ3mFKaoLaiHzoIAGr3pfvhULYX5efXFjsOXnN6fMil1XjN59?=
 =?iso-8859-1?Q?r+AXReXKGLoi5SRQ/VVdgKz87emZJaqJ3ZXmcpA04vGr3BD6umPz5zVuJV?=
 =?iso-8859-1?Q?7tA9JN2kAlsv1m1Sa5jPxrVlIEg07UjK2yWDFoJa7qxkJHwCPBswh68lV4?=
 =?iso-8859-1?Q?TjQZkOu0Qdrbmxe6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?w6dXWcvV66MtnZ0FeouFefqRIUzXiVV1neNpN062NNik2n6XzR4zm+cB3q?=
 =?iso-8859-1?Q?/b1JrV63yHZ3xNURU5wUqEnewKjFkflTNyb5dkU5LwSH9YMbstyTN3FQ40?=
 =?iso-8859-1?Q?2rnu2Wjprb3XfOi0FIHBvj6gl2EwJOQ5ml7kmL4R511fdui01TME9T5M8c?=
 =?iso-8859-1?Q?zgh77CTJhc6rWPdPjEJ7pwxFn+N+4wpxO3eThm/+scgZ2uE95DMmyLqwG+?=
 =?iso-8859-1?Q?OAH0sVGLFz3QnEyGchJa2EsJVpRJT5a0cj5Q4h/vcvRrL9e2a+zYJci/oT?=
 =?iso-8859-1?Q?2Ufn2sf3hIf5trQykL+hdmP2CHj/JPQDqCmpvAb0jp+xnTRzDKKR1F/Qmw?=
 =?iso-8859-1?Q?c+XwIfPoZcnFnbA8NKSJSErR/NgHq26Z6j/LjZz4nupFs+zdju0p314tiG?=
 =?iso-8859-1?Q?nHHO5L9M/2zl+LSQ8kxreFxyJfvDu0M16o1F5R6GM40Zcck/BEWNuNl2G6?=
 =?iso-8859-1?Q?kqHajeCPuySbizgo3m9c4OMHcPVSr1IRCNx4A+5XMhkM1QdfNPAyFuw9Ae?=
 =?iso-8859-1?Q?m/w0YsFcB7uNhGbisNda53K9ilkFs+ML/brCrxqnsCyTzf41uQw5IJx5Gw?=
 =?iso-8859-1?Q?L3K0rPLkObLUEzFvtiKPi/QlWsN9Wh7cAmA2OL92EYs6BR81MJG5LS9nqO?=
 =?iso-8859-1?Q?YTvqr+LxVWcW2HdCkEzmptj1EfK6jwrkR7FRh5iR11dz5NbouY6kfLHQu8?=
 =?iso-8859-1?Q?+DQvGYwXkzjP/uzJsHlV55RGuLliAbQNXRlXjGkgPpRu+VwR+xzZBxRQ1A?=
 =?iso-8859-1?Q?EP/NGOqadrwSS72MZiOvIA6cjRjWjAp3jvvX2GACtJ9DKkIFTKZ4jRUsLq?=
 =?iso-8859-1?Q?JxT5P5ewxfJ6IPuwG9HtWi6w+QWZHt0q4PF3/wJfSwPb2arReUr2Kft4Ue?=
 =?iso-8859-1?Q?5xT8ltOPclQ9eRKwybpMshXkXWbsVpQrrAIHmKolEgKiTF/oARa/jlpon7?=
 =?iso-8859-1?Q?sontPvI4CrfMOo8iTlYXhLifhYamG6xk4WRwdyJnNALiXr2+vAjyz6/8bU?=
 =?iso-8859-1?Q?q8duJWrXaWruJLiMnRPDvMc/AGjBkRFuAAHP0Ms3mI6Sb/wSMz5MTVlkku?=
 =?iso-8859-1?Q?mq3ltJmUXzEZWJX3KWehjwFAb/MzE+xkqc4M7O7DW9ynpsZkDqLSw2BNro?=
 =?iso-8859-1?Q?+TqQR4ASxLjmr7e4kgPPyADV3pGLgiY60cNScYByC8W7N82vgTJctsL66u?=
 =?iso-8859-1?Q?zKcsxN00IHoQcYbYvkADAhWOH+RxbwtCmZKnqhSBewTo70H+XBkzeFwn1m?=
 =?iso-8859-1?Q?Vk5cPl3Q/kHOp1MvtlEmFcquALeio+oPlw34okURxYmtMl+pfU+ywC3fVK?=
 =?iso-8859-1?Q?JUkoi9a5E8Ef+BEIZQrC4qeyQVuDC5zT9fvQC09iAN3B3AKf0CH8v+Qt/I?=
 =?iso-8859-1?Q?hA5vlb1OoMYt6TX3xShqzNHl6TOwSfuJH0/Ou2khMZcXBZcP6AKo+/T7SP?=
 =?iso-8859-1?Q?ujcSodAeorFR+zznzD8R8TE1x340rbL1LUUjNAFl8xcxhsoM7cNkuyMNLo?=
 =?iso-8859-1?Q?AIuQFN4cejQSB8++Tv0kU1v5J74G/9VZVJSMsFu+wAc5LVsXvU5l2RXlq6?=
 =?iso-8859-1?Q?ZTj1dJsdAf7bvbHbvwOrMylm3HT99zWURnT1pOFaC5DemxzaAuDYuzRvdr?=
 =?iso-8859-1?Q?t+TEqyfxjNPip6JLLwzy8FvQTBuYpI1KYvdwFJNhbS5tx7HJj8TAhOiQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a60bf82-66bf-4262-6408-08dd5fe813fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:27:33.1580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM/h0vbGCBAyoF2KuYwjCs7WNTRE4aQ99PyWsgbHPnY/rWJwFbnanTrnMAG1hsm0ktEJOeE8moHFHAOY6YhTNWchydrc682HRJLEB1ZUIoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
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
Thanks for review.

FYI: Given that this is in a sensitive area and we are now past rc2, I'm going
to postponse merging this patch till 25.07, rather than risk it in 25.03.

/Bruce
