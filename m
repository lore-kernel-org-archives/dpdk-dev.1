Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64899C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:13:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A103427CE;
	Tue, 15 Sep 2026 19:13:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9DEA34003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 19:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789492403; x=1821028403;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BbiZnSn04TSSoZ30MmoR6xaHqKBBPoj6NrLdJO235cs=;
 b=Rmo9Xypuw2zq4WDbSaXDMBFWdTIlsMmfcpjL6L9fbxEMDqtEd5MDsrVu
 4ALN8CPxZ9yH6F3Vi+ZpaX7/t7YF08iQP98/OGoQPb0TQQ8AtOp1gaPiT
 n6gDhGM1Va9skTZGc8dI0VBlN6+T6RZZ5+56bS75wSqmInqglDtD2qUi5
 Vl6+9i4o4sz2bQFdhIgAiyRRu9G2xAdQNf5TKl089NQmol1ogGv6xHlMF
 LoGRDcG4AXH2Q35NQgXO0ak8rtoIPoJTcPx/P9dumjbzljvViYLV2HwUC
 yG3Xpo9eIQcPaS4/3HXPQz8PO6cO2eWjTslUdwO/INePGjFzRlZZVxH+A w==;
X-CSE-ConnectionGUID: 6noMbnn9QcmTmgJ9vWMJmw==
X-CSE-MsgGUID: j8pkSIbRS36T6x9T1HWhZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89882532"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89882532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 10:13:22 -0700
X-CSE-ConnectionGUID: 1LAgvJAmQ0SEX7mzO/Albw==
X-CSE-MsgGUID: jVBj7VoVTQeL6AVgRLC1MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277192128"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 10:13:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 10:13:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 10:13:21 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 10:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaHfEUBu8G4wu0SpZtJnxwjjG7FRPvrihxhWcledfv3RSoalMOoRrnTyD+OsmHyHhBfXZj8O+Miypjxp2PuwyLfhD5TjhkagA/s0XHpOlb64h3v+pivKmsY7jmoeTQlMXm8I/V2kCSRIs9LgkPYt0BljMJQxKTG0R9UcO0teZNOTrIGwgi4u6NEeTDYW8zAnAGW1deTnAYvvgfVDrqbUmpagCm0bHntZ8Id5v6VDxZYbpu7vzqhiFUhx8+FZcpHC6Lda9rzjwEOwQaWfR3Q6TSvPDnGXe42AM1LxL/79GN6dDq0/LKM0Lfl8kiIl+vZwjYpCIgKm5djx5AEeCG6Qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm/WrU50PDJdisKjo6Jmh71EKBQrpNxOCVfA+aZiTqY=;
 b=bOAf7pmS72uxBOjGJh5ro7mTmkDWyHRmzgRP3MIfOFltaOGpwuQ6nGvT/Zq8oeqQmF5doIhvUe7lFB+wlN6AZcEiHLUQ2Lnw1AOFbfxVf0OgdL7jUgRFlibjcyTYbNvYl1OytCyMD2lRKLdE2ackPLSFrMCpqAA1c2b3RVigJOh6XYA/EoGdQcICGJbS9oqiQseby+bI+d18MfWyf6Fm/dcLWEdoIAxRoAeDNiJ7smsc91EV5UZhv83PS1leKbEIMP32VJuXVZS8/pLa5GMqsxZhp/UmPwoUZXUDWvqznnZas//5RHR4x79W/wb42hoQAjAlOzVP1ahd5Ji+5ynV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:13:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 17:13:13 +0000
Date: Tue, 15 Sep 2026 18:13:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
Message-ID: <aql8o5UgMKjq3kbz@bricha3-mobl1.ger.corp.intel.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
 <aqKGofPyWqWVWEwK@bricha3-mobl1.ger.corp.intel.com>
 <AT6PR11MB044526A42C6B7BE8BBFDFA1C35E4BA2@AT6PR11MB044526.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AT6PR11MB044526A42C6B7BE8BBFDFA1C35E4BA2@AT6PR11MB044526.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be09e46-e200-4bac-aab5-08df134c9f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: j6zdXBkURTAmSvGZMBMwLSCuwpgBmnCxKfvhXY3lYETzpoZUy4HCyue2gCsvjTxW1sDOryxiG6lHYS+0SNhuGDrDunh+m2ou1w8eb7AFHAPE9gzEFlYER5/fNbdNwbqzm5thM5sQsVWOGGxIZoZznkyx9suzZ8D/5pl0DR3zJs9PFU8bO29F1GeSJyllThbgOa6AAJo0GUDAdBJEOrfvAFAWsfkv0Wvil2VFJMVF95EBRXpYSduV7oN4JuZFXm+lk2yLfW8RJzfN1dJkAoc+h0DjyY3Qo/ZB8pbb1W1raS17JWf/V5wekMBPefkopjvgHUTtTpuwWAVe7zqs6+3Zl/zzaX20Nxblkuwn3ZDdGVBWrbWzZ+wWN5Ef2g2UoNEHyYfdLbHqZUDUwKe4PHh9yufIdts5mecWzJAFmDchO340GXZrJ+q/NhHouoFFbYtBHz1EWvxBU9lPeMWCKZWxJ6b5VojVEIQI502mswaEXljZw5rCZ0t952MVcSYTIllK+44Fylde7YxaUU0C4v1I1YJVYjSlTbGrWNQnDQP4qUXMFzduMXt6XOQBV77RbFIMEuwQMtncexvLrfEBQlEkpY7OeoKUfR0nHz2bznsFLPZoB8RLHNfI+a7f2aDEuP2KGcocpYIJMzeoEd1xpj03tf8/jAr9DMsXeC1JO0YeTVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrAh5PalIfL1z5jlLDQXDgbq7yykQ9b/KN7VlR7cLCesxo4kuGsxchXnZujf?=
 =?us-ascii?Q?+S4WgzgIKAb3FnYbOhx0jlbD1opc8B2/QPgeuosHYdoof3Vq1Cx3y3/Xe+Gy?=
 =?us-ascii?Q?GQw6dRQS1B+Yg8/BG/g43YErkJ5A0e4YUFIsMFuAdvX+wIjJRNNSs5u8p0Q4?=
 =?us-ascii?Q?3iJ/dspngrGsQdo3BZqeV9utwBcnUh56xcN1hG4a7fccR7ko61c7h3kEg7G6?=
 =?us-ascii?Q?53hkiVJR1Bowjcuhd1XQyIhiPOriK4dfpWTdi5nmYNxkawjnWV3gb2kDXTgQ?=
 =?us-ascii?Q?K0AH0i+W7+MDIt6lXPxHJnoOmDV2Urw/+MzydI500n6TU4X9ZrO8dI/DkYFK?=
 =?us-ascii?Q?gSkifkdMYmDvjrNINV8lxKzYhEEw8h8eKH0wxHQsU4ydEfS/9vx5uDcaXf0b?=
 =?us-ascii?Q?vxKkPTOElBuiRmnqDD30XF5HovXS73IdGnmXDIzX74/F4wtd1DOzHpo3lP1o?=
 =?us-ascii?Q?i+/oeum98DyUODzwklq8QLQ43rWRjLlsQPNssM2TfNqEXPxbyGJpFo6o06PV?=
 =?us-ascii?Q?tWd6de21UQAOKl7O52bp5d50nbaoIQ3UKoh4F+5WX9ug59k/XExUpRpuWTxM?=
 =?us-ascii?Q?h+lAxMT8t4y3GnAF60/rC27OQbL14xYXze4cYNX8pZxsqoqN21mLAZBJd5fO?=
 =?us-ascii?Q?1Bq4RJSDajxYa4bUnnIMcEpOkWAtN26D/XzIJbhZ2DnkHBwVzWpfjpIwkc/y?=
 =?us-ascii?Q?Vh4hkGm8Vc3vuGk//a31deg8ZEeSa3stv+jM+2cTri/ikjK+6sH5YsGWG01P?=
 =?us-ascii?Q?LpeSqRk/4EjiNAasQ2L7SiesOI9D0935+cVp7I1zL0gAZpcE/TEmsqwpYOzU?=
 =?us-ascii?Q?2B1+Xej9ngDEQon5OD3UILrZChdOSIz+W1GHFYfQTjcedBUChK633mfFa0Xz?=
 =?us-ascii?Q?fFNAxt1W5GYbsktCXcaAY2ptYHKyu+8nCTp/2tOzP7lUMkb933tYgOIcZOMS?=
 =?us-ascii?Q?MFA630Dmk9w5XjeXOyoRG5BlidJcjdr9W1dqxQzJ5DyteJAEpMewkNccEBN7?=
 =?us-ascii?Q?eoRVSSh4W+2u2gaJ3suhJgfE4GOvmX4k7CK3uvv6HVMJNVjaXckIon3ZCWFm?=
 =?us-ascii?Q?e1nijR/QSOfQCgrhbfCtpag4t3EPBoV5fDhNVtywZ8QurkvpZa4MViY0Cn+O?=
 =?us-ascii?Q?g58nXlRzItGEJKjHia3qtLi4RyFwVIpbJw/GRxIVqNJVd1TkKoIMzRFZTYmQ?=
 =?us-ascii?Q?oxij8orop38E6kVmA/gUj/Wj6gmWJsCttFLURiQ3ZIjziVjQUxnKDfc5PwPP?=
 =?us-ascii?Q?Xf5mljx2ELERG4uCD98Dwh2NIbhAAu/Qmd1WCyDItX2J4jWv+EiOjicgeGcx?=
 =?us-ascii?Q?t8+eU0TaFDmaJ7xY02N8YLfwR5VREpZtGxOfIf7YVyiqnV9ejTnNyNtkEJz7?=
 =?us-ascii?Q?dFBe04H2MXTBGLqmaZL9tHucMdQacuQRry8hUNZSr+6D2a/l5bnQZH2r0aLq?=
 =?us-ascii?Q?2K8k8iiRGl9jPoDuEqTtmCIEUd768opbUhEStfxdiE9JieyQjSbnXPGSlAhc?=
 =?us-ascii?Q?/sivD380p0zzqQheSX6zGjqAY2SlpqJUtsLQYHxLYBQcQEYIQcAG0iVyjeFq?=
 =?us-ascii?Q?cD2S4PgjsFlHaJjmbaRaYCFCSYWMFsvNUR57eLuiLpsWdS780gNxSYxJL1DQ?=
 =?us-ascii?Q?K093QeYL4L7IppL//V7YgDdzKnqg+qfCDkz/2qMLV06EfMp/vit1HjmiQw8N?=
 =?us-ascii?Q?yjvSmlWmgy2hx7SO+KTspvU7yDhlueSpQ5UiwtVjJT6r3XrBxB+YN+fxKbIC?=
 =?us-ascii?Q?+fwhTcbsCOAdAFEbdq7riQDjSEJ3ywc=3D?=
X-Exchange-RoutingPolicyChecked: tsDJtS270qehfI0wWw0m6DUDltwjeZJfvquvTFp84JRBp/0uZyMCq8QvhPsgE3plp7kqp7lH/fb5PpDeU2BJsTLQ40bpB2tB/rn7amOyuX5DzZHxT3kD6D/0HE3axczTSZ5xW7JMHy7FV9+NuG0nxO8hD9ducuRFljeKngJfvcllY3mk3HMZG/PNAdvmidlUVHex18tIvYu/FgDk/PbcyrRCro9AxFNRPMUHCBuu7yTefGQuTfCahKxBVywrXTz8aZEAB4SjS8yOVAjBX6WT2veDEm6DxLRbxDFkWvtgLd0ss6FEljptaSze4bwbyWND3NEU5BmyNMBVX5oeHtA2OQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be09e46-e200-4bac-aab5-08df134c9f88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:13:12.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+CA3txTXA6vmzBa8RNK9UYzSfdrrHYV4YdQGldWbxlxofxXl5pEXCHLHslkXyMXeRbBnLO5lZd1wM1+vHaFASKq2MlrQEvUj/EHNJKD9NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
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

On Tue, Sep 15, 2026 at 11:19:08AM +0100, Mandal, Anurag wrote:
> > -----Original Message-----
> > From: Richardson, Bruce <bruce.richardson@intel.com>
> > Sent: 10 September 2026 16:00
> > To: Mandal, Anurag <anurag.mandal@intel.com>
> > Cc: dev@dpdk.org; Burakov, Anatoly <anatoly.burakov@intel.com>
> > Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
> > 
> > On Thu, Sep 10, 2026 at 10:04:32AM +0000, Anurag Mandal wrote:
> > > The Tx rate can be limited per queue with ethdev operation
> > > ``rte_eth_set_queue_rate_limit()``
> > > and can be read through ``rte_eth_get_queue_rate_limit()``.
> > >
> > > This feature uses the hardware packet pacing mechanism to enforce a
> > > data rate on individual Tx queues without tearing down the queue.
> > >
> > > The rate is specified in Mbps.
> > >
> > > ice_set_queue_rate_limit() applies the requested rate as the EIR
> > > (maximum bandwidth) limit of the queue scheduler node using
> > > ice_cfg_q_bw_lmt(), converting the Mbps value taken by the API to the
> > > Kbps expected by the scheduler.
> > > A rate of 0 removes the limit and restores the default bandwidth via
> > > ice_cfg_q_bw_dflt_lmt().
> > >
> > > ice_get_queue_rate_limit() reads back the value cached in the queue
> > > context by the scheduler on a successful set, and reports 0 when the
> > > queue runs unlimited.
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> > >  doc/guides/nics/features/ice.ini       |  1 +
> > >  doc/guides/rel_notes/release_26_11.rst |  3 +
> > >  drivers/net/intel/ice/ice_ethdev.c     | 77 ++++++++++++++++++++++++++
> > >  3 files changed, 81 insertions(+)
> > >
> > Is this functionality not overlapping with what the rte_rm APIs provide for
> > ice? Using the rte_rm hierarchies, it's possible to rate limit a queue, no?
> > 
> > /Bruce
> 
> Hi Bruce,
> 
> I am guessing you meant rte_tm APIs instead of rte_rm.
> Yes, the two paths ultimately program the same hardware field.
> But, there are few reasons I still think the ethdev op is worth having:
> 1. rte_tm commit bounces the port. This does not. 
>     So adjusting one queue's rate through rte_tm drops traffic on every queue and bounces the link.
> 2. VSI subtree is rebuilt for rte_tm :
>  	a. Stop the port if running
> 	b. Walk the VSI root up or down to the new layer, freeing sibling subtrees
> 	c. free_sched_node_recursive() - tear down the existing scheduler subtree
> 	d. create_sched_node_recursive() - rebuild it, ice_sched_add_elems() per node
> 	e. Recompute pf->main_vsi->nb_qps, then ice_alloc_lan_q_ctx() to resize queue contexts
> 	f. Restart the port
> 3. ixgbe & txgbe pmds also implement both.
> 
Yes, your logic makes sense.

However, one final concern, it appears that this feature doesn't interact
in any way with the rte_tm one. Therefore, if a user configures a full
hierarchy using rte_tm, and then uses this new API to tweak the Tx rates on
queues, we could see problems later, e.g. losing all adjustments on apply
of a slightly different hierarchy etc.

If the two features don't interact well, we may need to put in place some
form of locking to ensure that you can't use one when you use the other.
What do you think?

/Bruce
