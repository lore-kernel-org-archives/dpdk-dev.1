Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD1FCD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7F2C402C8;
	Tue, 19 May 2026 13:01:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 06EB040296
 for <dev@dpdk.org>; Tue, 19 May 2026 13:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779188499; x=1810724499;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZhA1gJJrTe0fB7HQkJuncNq5RxlmtrlgzpqDJlqnfQM=;
 b=D0d+TtCSM5+IG7qCWhEA0xNx4OS8JcxHi4LmKkleOp/5cqaBqRmNCMb9
 fMta46/c7Gy/NsCcbgoGX1z5DfqLOr6//g0r/tDXP7f9C3K8i73AyXl2k
 qb3xVS85fzjVtLEq6Ac5O9zZh+dhbobzLciYM9opfeKenBwPTXuUk1Yg+
 o7UOeCrwjm5v4UJeskpR7KdjUAmkTLyXjuiWlpqQuAYcH+fruOECFVjkt
 CQk8NKXKSjY38lQ+c2l4jBDE+1wtVRY0MdI7E1DnFZK9GC4NJfWdx5Oiv
 /FiF8nS9XEDSpgYlPVEeXKRFhIGaYc2jSNMY48+0NUetVdH68ECeXX7ME w==;
X-CSE-ConnectionGUID: ziv5yytfScywHTZNxBqXnw==
X-CSE-MsgGUID: PGrWnQ7XThuq656+3+laoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79913026"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79913026"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 04:01:35 -0700
X-CSE-ConnectionGUID: ioMKB3v+T9KWsQeX6QWtbw==
X-CSE-MsgGUID: KNQPfouNREq+VJZiajg3Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="270077071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 04:01:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 04:01:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 04:01:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 04:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEAj6hz0wX8/1nR9zPh+YHWTNBt87mzv93ONtNAZJjmZfMlKck3nhne8T6pF/Y+Eb6oPLST+qAN8lxAQCF5yEdIJE2+p/cpKtQpUxdJSNcUDQB7tX7GCHl6U4E8/WJWDRvDXJtWVb1KY2ZT5y6RJv8fibgUCe7elp3uIwDdFd0ycoIfAmEgBnlIiEFUNMWUHSPFyBV1WPbFy4tQEcNVEOfsZQFtx3gni5vn5BuSwHY40bJslR0BYFS95pQIWadh8tAysUZX4/Zvfxdibp2LYHEYAg7UAGdAItUk8GauPwY5P76hCjbjpFNl/cml1gZzG+D/txKc2Vge6AM23TtGVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdTJ+bVxzEQHk973fCqnM4uFXEBXt8zmrFR7dCGjnjQ=;
 b=ZdAbKvswLCh1XGg8KNv7XB4Rwx1Ix4wxgtPKOc8GGsigtvXbIha6a2my4wkxplJWq9XakpDwA80duUqMI+pTk6JnoR+GmNYPYtrP5oVYYal/5U1jXd3LbsW3IfU7XTBQNfHz2CQe5mIA1gaLtibE8Kfb1acfPZyscR1+63C4RJGNDWJpKY8s/6ndgUAiGazX09WhPelaea7FF2QmQVwM4sPZIzeCJhUAz47o0Gb2wzGJg8DQ3sfl6/5vQCSWOLMfy45RTdSu6LhmI3hl0ZiEweqsrh/FjfoEedo7IXFS93VZNfRrrQuz51xHQKGkIhlPl5H8vcoUXTgcKPoFEa3/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 11:01:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:01:27 +0000
Date: Tue, 19 May 2026 12:01:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: optimize for fast-free hint
Message-ID: <agxDAvhFcY-eXePW@bricha3-mobl1.ger.corp.intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260408132515.1314728-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DE@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657DE@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c34b00e-15df-436a-4917-08deb595f980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: HP5H8gwlGnq1jx3tdpl5CLoHmKHqsPI4nbHIvWRtu+8o65NiNLjCimUdD5ZoM3w1keBAHnOM5r2/FPg1DBM1E1e+dxzlrAqY83aLc85krlEqWe4p+hLrW9pamt6IvpuYUaeajODBWbOanBvPmuQw4oW7GBd7IehGM9Np0hhAhrXk0TTrxkwk+tY7XpV+hwCSYwj3EajJZsL5Ro19O3eWmVNsN9th6J1YTQF1JTBc/htlOGidV5yta8Zc2XqqsAPC0POw2YRmyb/agwpbcUXi0cG5vJc7ezT6QR/4bqsGNV0TLqiUrOKXtubqKUlPdzwnVCynUx+vAlSI9z4HVpkZmJ4m7cX4EGjr1kdEg5NhLqGjq8RhBd5sWyrdagrUy2bW4jFSOKn0iCwrI9YiIe0fTs+0u+NjEwc5z8A/zGbaZ0dri9KzLcGBh5QDTaystdwzNY8AwoqbmEBsIfvF7CEO41EdJ12N59QR7enHo6BaDBQuQ6NPHpPFnG3Gc8EZny4xssAMVfwf5eU9OOPpybofU8KT8Xm+nWcQYB5ENcJJEpp80kKlU5Y3RKIcUU/dSKSr6QLzsazhjxh+f7bwbpS1VOOpinRLSlSs3X1rBrDbIMUTUwpNxeumo8YXkWO43GYoWZiHXWJ88xOISrBtrJBtjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ybxC1QU6Ka0G460c5kX0CSreNI370zdxVxAMTQ9nTb1plmlNDT/T27fsot?=
 =?iso-8859-1?Q?3AJ8fbUJw5IMO5GWe0iveIdqwKuXL/Ef75ftz5+u2gnJMw9pFCZQAvakmM?=
 =?iso-8859-1?Q?CyW2QGyf+pzeaR5g2jd+jaxEYswoFes4zCSItoHTI9i04VcBheh+W2QGqR?=
 =?iso-8859-1?Q?062irE2C+fkTBIljpi798NX5OFcO7DxFZ7w+eXj7izlzxbYxTbbpfhZgV+?=
 =?iso-8859-1?Q?6mi8HUQtnkA1whh8RK3h/MCIikK20OAI27omUJzAmJwh7sIYpZhtKIgwWA?=
 =?iso-8859-1?Q?kY4BkI6nBIXQRjFmi9UZ7Z6Wkda9myHJ9FmyMIjGg0xsr7BGhrvb480qDN?=
 =?iso-8859-1?Q?GawTiq89VKxJ9n1S9jpGY04oxKaO9OY+M0fswV6RNxb6VnwJ9O6H0ilP2y?=
 =?iso-8859-1?Q?WqJKR+LnvCsu5CKnjJAV60IWUevrRRxebCNsjnyBam9ClyJS2I660EVZCv?=
 =?iso-8859-1?Q?FA3qd29XPjmPPwofGnzxI1+uqbZtImciJKqo4f0mFqf+MfOPT40sKkwXRj?=
 =?iso-8859-1?Q?Tdq66ochdyNAo3cj1SmimSE0XWyYpVShAKjJfXc/HcOjIkozJP9c0xbaFk?=
 =?iso-8859-1?Q?/RmP20QAal4TgxsFR5h61fzGiVFM4pEQVtN4LiI8aqUUZqPmOLZ3zggs3z?=
 =?iso-8859-1?Q?kMOMXCDW9psCVEdszEDlfkEam+PGeYn+OUVwxmcZq8N7gYlhe/yOI9goTU?=
 =?iso-8859-1?Q?W8OSE7hyd/6HNIU7BYKaLfpikB9sfW689PtySdzF6HobogKjHfCFbU2O3M?=
 =?iso-8859-1?Q?h5k0wePN5ShCm0goz7EZBivRHGFg0ftVKTcqy4V9psUHLrWy2+ISE9glkd?=
 =?iso-8859-1?Q?4Uhpuz9GoVMBgWcajzMOWOu8o3gZoU1nn/SrtvlqcDf0FuAKGkp4ZAWdLP?=
 =?iso-8859-1?Q?NzyerjuQZwCVvBeNEiCQ+9XfAKXqsYT4UZiYeQ4Plk2nb9YmaVIofMMSJ7?=
 =?iso-8859-1?Q?7o+NzHQmyb8MZaPAAq/nmAvXs+/z+YsrrTVzI2l3PB16a4ObskedktxtLk?=
 =?iso-8859-1?Q?dcLu0b3h7RmoC94AebcQT3F4D7cCAkp34fX57VYOn8S/yYL16NFB3LhN8q?=
 =?iso-8859-1?Q?zthingx3WVWFFJs8uUJLqoJD85RT8/voBept7TbMrlqe+I9AFyda4XUwnz?=
 =?iso-8859-1?Q?Tj0d0WSJpsHp9pYf5b/vbu09xOCxNnDXIdwkpxtBHO/JeNv/m4DFlt7nHD?=
 =?iso-8859-1?Q?VRJAwmjfwCkswDoY8Qqu/4Ae8cfbvO60yOIwaoQumEmUhfkcngSGgyn4Pu?=
 =?iso-8859-1?Q?L8DCDMTzn12N5D5+Hxy2XAep+U3qHBN4uofDWYQBRBXyQYRox8llil7a7K?=
 =?iso-8859-1?Q?KVs/lC7benJj3IsPyL8VG5ND0IncXQ7ZeabZHi0d3+9mkHTRhZuoL4GQBm?=
 =?iso-8859-1?Q?tkq6nfjX6JKtt1+z7G/0tMd6Xxm70ZZYWputjaKELE8uTvN+mIIDj9DJMn?=
 =?iso-8859-1?Q?FKCPw1EBLeF9790ph9XXtXfXPddSJ6ye0DpWkrq05DdYKiwtkiPV5YjNeU?=
 =?iso-8859-1?Q?mPDoNw7kVtv8NaOppQnV4fNJy3j0ojALD+Nsgj+sUprQji3sORhv4qHnvB?=
 =?iso-8859-1?Q?/avoYFAUVnrdDh0ZPRd/yU7OilhCAiuZEy+GcqT1hNUe0bJ+SJLmqlbNER?=
 =?iso-8859-1?Q?2bCOYL1CSHVcbVKwmnhMam/VfdmtZTZTWqoXwXYUE4d6PrIAbPEnVsphqQ?=
 =?iso-8859-1?Q?oJrw1PIw4aIR7YMKFThe2/frkCCJBJPFl3/MfU/FVhFldWCkfJZZ3eAPJQ?=
 =?iso-8859-1?Q?e/jwx0kCwPYqCYUaGHhSn2Hn9fMgw32Z57B9LeuisxBrNbpR8hMcKWys+R?=
 =?iso-8859-1?Q?jDb6hoJUOoP1VrtMFoPIbjx1NvofncU=3D?=
X-Exchange-RoutingPolicyChecked: L3zHLfNu2zARNE5DRWuua/t/3AKkgvNu3DbCraIQE8Zxo3sD0rTEpXUubPj4RmEo5d1IbwnIuIpj1MrnMOji3S3iWE9wMv0jHvvqwxYUb9dy8OztHrgsmWT8qyz+pPqmsWBDOb0lQEAD2jmJ3V/W0FDS7BTEKuPdno0d/SqorHNa09ugftomgY6X2JXSpWWFZrT1JmuCpaqyz8om2Z+qlop547XLKGCX4GhjwsHG6NyD+6K393H0aJNsXwEnE05Ru3LjFMapyLDNMoNazK1KfsAdX7uvVEwzEH4zM2HqK0Dqz5nSNPwNMKoNgxYeN16Aycl1IiO3KlN+2F1Eh39j5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c34b00e-15df-436a-4917-08deb595f980
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:01:27.6811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZqYA+pxTo8lfNww0JiojJbD7wRtCe9hgrqEv/lyAAWy4Fd7TP6n7d5z2dLJ9jxHoBhpudQzqzn1dEzDCN2+a4224gZ+jRs4iV4VK6kFX8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
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

On Wed, Apr 08, 2026 at 09:27:11PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 8 April 2026 15.25
> > 
> > When the fast-free hint is provided to the driver we know that the
> > mbufs
> > have refcnt of 1 and are from the same mempool. Therefore, we can
> > optimize a bit for this case by:
> > 
> > * resetting the necessary mbuf fields, ie. nb_seg and next pointer when
> >   we are accessing the mbuf on writing the descriptor.
> > * on cleanup of buffers after transmit, we can just write those buffers
> >   straight to the mempool without accessing them.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> A bunch of review thoughts inline below.
> The ones regarding instrumentation should be fixed.
> The rest might be irrelevant and/or nonsense.
>

See inline below. Summary:
* ack for mempool functions for instrumentation
* ack for referencing the mp pointer rather than the offload flags
* nak for setting the mbuf pointers for null, it's unnecessary with this
  design.
* ack for removing the prefetches

Thanks for the detailed review. Preparing v3 now.

/Bruce
 
> > ---
> > V2: Fix issues with original submission:
> > * missed check for NULL mbufs
> > * fixed issue with freeing directly from sw_ring in scalar path which
> >   doesn't work as thats not a flag array of pointers
> > * fixed missing null assignment in case of large segments for TSO
> > ---
> >  drivers/net/intel/common/tx.h        | 21 ++++--
> >  drivers/net/intel/common/tx_scalar.h | 95 ++++++++++++++++++++++------
> >  2 files changed, 90 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h
> > b/drivers/net/intel/common/tx.h
> > index 283bd58d5d..f2123f069c 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -363,13 +363,22 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq,
> > bool use_ctx)
> >  		return;
> > 
> >  	if (!txq->use_vec_entry) {
> > -		/* Regular scalar path uses sw_ring with ci_tx_entry */
> > -		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
> > -			if (txq->sw_ring[i].mbuf != NULL) {
> > -				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > -				txq->sw_ring[i].mbuf = NULL;
> > -			}
> > +		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail -
> > 1). */
> > +		const uint16_t start = (txq->last_desc_cleaned + 1) % txq-
> > >nb_tx_desc;
> > +		const uint16_t nb_desc = txq->nb_tx_desc;
> > +		const uint16_t end = txq->tx_tail;
> > +
> > +		uint16_t i = start;
> > +		if (end < i) {
> > +			for (; i < nb_desc; i++)
> > +				if (txq->sw_ring[i].mbuf != NULL)
> > +					rte_pktmbuf_free_seg(txq-
> > >sw_ring[i].mbuf);
> > +			i = 0;
> >  		}
> > +		for (; i < end; i++)
> > +			if (txq->sw_ring[i].mbuf != NULL)
> > +				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
> >  		return;
> >  	}
> 
> The above LGTM.
> IIRC, we already discussed it - or something very similar.
> 
> > 
> > diff --git a/drivers/net/intel/common/tx_scalar.h
> > b/drivers/net/intel/common/tx_scalar.h
> > index 9fcd2e4733..adbc4bafee 100644
> > --- a/drivers/net/intel/common/tx_scalar.h
> > +++ b/drivers/net/intel/common/tx_scalar.h
> > @@ -197,16 +197,63 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> >  	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
> >  			0 :
> >  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> > -	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) +
> > (txq->tx_rs_thresh - 1);
> > +	const uint16_t dd_idx = txq->rs_last_id[rs_idx];
> > +	const uint16_t first_to_clean = rs_idx << txq->log2_rs_thresh;
> > 
> > -	/* Check if descriptor is done  */
> > -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> > -			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > -				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > +	/* Check if descriptor is done - all drivers use 0xF as done
> > value in bits 3:0 */
> > +	if ((txd[dd_idx].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > +			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > +		/* Descriptor not yet processed by hardware */
> >  		return -1;
> > 
> > +	/* DD bit is set, descriptors are done. Now free the mbufs. */
> > +	/* Note: nb_tx_desc is guaranteed to be a multiple of
> > tx_rs_thresh,
> > +	 * validated during queue setup. This means cleanup never wraps
> > around
> > +	 * the ring within a single burst (e.g., ring=256, rs_thresh=32
> > gives
> > +	 * bursts of 0-31, 32-63, ..., 224-255).
> > +	 */
> > +	const uint16_t nb_to_clean = txq->tx_rs_thresh;
> > +	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > +
> > +	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> > +		/* FAST_FREE path: mbufs are already reset, just return to
> > pool */
> 
> Depending on which cache lines from txq have already been loaded, unless txq->offloads is hot in the CPU cache and txq->fast_free_mp is not, consider testing (mp != NULL) instead of (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE).
> Like here:
> https://elixir.bootlin.com/dpdk/v26.03/source/drivers/net/intel/common/tx.h#L281
> 

Ack. The offloads are on the second cacheline of the txq, I think, while
the fast_free_mp is on the first one. Therefore, checking the mp pointer
for null is slightly better.

> > +		void *free[CI_TX_MAX_FREE_BUF_SZ];
> > +		uint16_t nb_free = 0;
> > +
> > +		/* Get cached mempool pointer, or cache it on first use */
> > +		struct rte_mempool *mp =
> > +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> > +			txq->fast_free_mp :
> > +			(txq->fast_free_mp = sw_ring[dd_idx].mbuf->pool);
> > +
> > +		/* Pack non-NULL mbufs in-place at start of sw_ring range.
> > +		 * No modulo needed in loop since we're guaranteed not to
> > wrap.
> > +		 */
> > +		for (uint16_t i = 0; i < nb_to_clean; i++) {
> > +			struct rte_mbuf *m = sw_ring[first_to_clean +
> > i].mbuf;
> > +			if (m == NULL)
> > +				continue;
> > +			free[nb_free++] = m;
> 
> Should sw_ring[first_to_clean + i].mbuf be set to NULL here, instead of in ci_xmit_pkts()?
> I don't know, just want you to consider it.

No, we are ok just setting it there. The changes in this patch to the
ci_txq_release_all_mbufs() function mean that we assume all buffers between
tx_tail and last_desc_cleaned are invalid/freed (i.e. we free from
last-cleaned to tx_tail only), and so we don't need to set the invalid
slots to NULL.  The NULL sentinel is only used where we have a valid slot
but which does not have an associated mbuf.

> 
> > +			if (unlikely(nb_free == CI_TX_MAX_FREE_BUF_SZ)) {
> > +				rte_mempool_put_bulk(mp, free, nb_free);
> 
> rte_mempool_put_bulk() -> rte_mbuf_raw_free_bulk(),
> for instrumentation.
> 

Ack

> > +				nb_free = 0;
> > +			}
> > +		}
> > +
> > +		/* Bulk return to mempool using packed sw_ring entries
> > directly */
> > +		if (nb_free > 0)
> > +			rte_mempool_put_bulk(mp, free, nb_free);
> 
> rte_mempool_put_bulk() -> rte_mbuf_raw_free_bulk(),
> for instrumentation.

Ack

> 
> > +	} else {
> > +		/* Non-FAST_FREE path: use prefree_seg for refcount checks
> > */
> > +		for (uint16_t i = 0; i < nb_to_clean; i++) {
> > +			struct rte_mbuf *m = sw_ring[first_to_clean +
> > i].mbuf;
> > +			if (m != NULL)
> > +				rte_pktmbuf_free_seg(m);
> 
> Should sw_ring[first_to_clean + i].mbuf be set to NULL here, instead of in ci_xmit_pkts()?
> I don't know, just want you to consider it.
> 

As above, reason should hold for both fast-free and non-fast-free paths.

> > +		}
> > +	}
> > +
> >  	/* Update the txq to reflect the last descriptor that was cleaned
> > */
> > -	txq->last_desc_cleaned = desc_to_clean_to;
> > +	txq->last_desc_cleaned = first_to_clean + txq->tx_rs_thresh - 1;
> >  	txq->nb_tx_free += txq->tx_rs_thresh;
> > 
> >  	return 0;
> > @@ -450,8 +497,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  			txd = &ci_tx_ring[tx_id];
> >  			tx_id = txe->next_id;
> > 
> > -			if (txe->mbuf)
> > -				rte_pktmbuf_free_seg(txe->mbuf);
> >  			txe->mbuf = tx_pkt;
> >  			/* Setup TX Descriptor */
> >  			td_cmd |= CI_TX_DESC_CMD_EOP;
> > @@ -472,10 +517,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> > 
> >  			txn = &sw_ring[txe->next_id];
> >  			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
> 
> RTE_MBUF_PREFETCH_TO_FREE() doesn't seem relevant here anymore.
> I don't know if it fits into ci_tx_xmit_cleanup() instead.

Yes, dropping.

> 
> > -			if (txe->mbuf) {
> > -				rte_pktmbuf_free_seg(txe->mbuf);
> > -				txe->mbuf = NULL;
> > -			}
> > +			txe->mbuf = NULL;
> 
> Already mentioned: Should txe->mbuf be set to NULL in ci_tx_xmit_cleanup() instead of in ci_tx_xmit_pkts()?
> 
> > 
> >  			write_txd(ctx_txd, cd_qw0, cd_qw1);
> > 
> > @@ -489,10 +531,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> > 
> >  			txn = &sw_ring[txe->next_id];
> >  			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
> 
> RTE_MBUF_PREFETCH_TO_FREE() doesn't seem relevant here anymore.
> I don't know if it fits into ci_tx_xmit_cleanup() instead.
> 
> > -			if (txe->mbuf) {
> > -				rte_pktmbuf_free_seg(txe->mbuf);
> > -				txe->mbuf = NULL;
> > -			}
> > +			txe->mbuf = NULL;
> 
> Already mentioned: Should txe->mbuf be set to NULL in ci_tx_xmit_cleanup() instead of in ci_tx_xmit_pkts()?
> 
> > 
> >  			ipsec_txd[0] = ipsec_qw0;
> >  			ipsec_txd[1] = ipsec_qw1;
> > @@ -507,10 +546,21 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  			txd = &ci_tx_ring[tx_id];
> >  			txn = &sw_ring[txe->next_id];
> > 
> > -			if (txe->mbuf)
> > -				rte_pktmbuf_free_seg(txe->mbuf);
> >  			txe->mbuf = m_seg;
> > 
> > +			/* For FAST_FREE: reset mbuf fields while we have it
> > in cache.
> > +			 * FAST_FREE guarantees refcnt=1 and direct mbufs, so
> > we only
> > +			 * need to reset nb_segs and next pointer as per
> > rte_pktmbuf_prefree_seg.
> > +			 * Save next pointer before resetting since we need
> > it for loop iteration.
> > +			 */
> > +			struct rte_mbuf *next_seg = m_seg->next;
> > +			if (txq->offloads &
> > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> 
> Similar to comment further above: Is txq->offloads or txq->fast_free_mp hotter in the CPU cache here?
> 

Updating as you suggest.

> > +				if (m_seg->nb_segs != 1)
> > +					m_seg->nb_segs = 1;
> > +				if (next_seg != NULL)
> > +					m_seg->next = NULL;
> > +			}
> > +
> >  			/* Setup TX Descriptor */
> >  			/* Calculate segment length, using IPsec callback if
> > provided */
> >  			if (ipsec_ops != NULL)
> > @@ -528,18 +578,23 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  					((uint64_t)CI_MAX_DATA_PER_TXD <<
> > CI_TXD_QW1_TX_BUF_SZ_S) |
> >  					((uint64_t)td_tag <<
> > CI_TXD_QW1_L2TAG1_S);
> >  				write_txd(txd, buf_dma_addr,
> > cmd_type_offset_bsz);
> > +				/* txe for this slot has already been written
> > (e.g. above outside
> > +				 * loop), so we write the extra NULL mbuf
> > pointer for this
> > +				 * descriptor after we increment txe below.
> > +				 */
> > 
> >  				buf_dma_addr += CI_MAX_DATA_PER_TXD;
> >  				slen -= CI_MAX_DATA_PER_TXD;
> > 
> >  				tx_id = txe->next_id;
> >  				txe = txn;
> > +				txe->mbuf = NULL;
> >  				txd = &ci_tx_ring[tx_id];
> >  				txn = &sw_ring[txe->next_id];
> >  			}
> > 
> >  			/* fill the last descriptor with End of Packet (EOP)
> > bit */
> > -			if (m_seg->next == NULL)
> > +			if (next_seg == NULL)
> >  				td_cmd |= CI_TX_DESC_CMD_EOP;
> > 
> >  			const uint64_t cmd_type_offset_bsz =
> > CI_TX_DESC_DTYPE_DATA |
> > @@ -551,7 +606,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> > 
> >  			tx_id = txe->next_id;
> >  			txe = txn;
> > -			m_seg = m_seg->next;
> > +			m_seg = next_seg;
> >  		} while (m_seg);
> >  end_pkt:
> >  		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
> > --
> > 2.51.0
> 
