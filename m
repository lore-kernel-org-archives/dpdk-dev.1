Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51777C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 15:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD1C4021F;
	Mon, 14 Jul 2025 17:12:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F0B78400D5;
 Mon, 14 Jul 2025 17:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752505924; x=1784041924;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LyBkiKdtyOy89M2l5ymprX1OlIRDgiA7ki5VRy5F6Jw=;
 b=EOdQfR1wwWzu9o9ucjIFgfqm+6n7YiWGyvRy3YtBNSLaMfcUTRGebjQn
 6PinsuNcJFXi2x5cEaryiW+hdakodh8qZtreQM9EpkZdm99z3zcxcuWb2
 DbIXcJpX74KsUMpnOee5G0jd4FwxPJmakVZkZ8GwCT0Dl+EKCHg7CkRB+
 EDgarq/VqSWBy8HjZXwgGU3NTUlgVTXk48qqKmZ+EV9bjq8D2SGIE2ZUx
 tCc+MQmTzEskh7wEb0FBtDLGUqRiX1ZgpYP98NSqMCbfVS1wVQHRox+Ov
 XluSO1c2FWQhG41+hkKXtwdMYniZliVQQTv0fR9ndELFpH4LH6+9tPd6L w==;
X-CSE-ConnectionGUID: xKOblR45Si+j0JTebluJKg==
X-CSE-MsgGUID: s1NDIGocRAme/et4wQIzoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66147404"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="66147404"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 08:11:49 -0700
X-CSE-ConnectionGUID: s4lKR1RxS0iL89T3DM1T7g==
X-CSE-MsgGUID: rZFBDJdOS2GzvPFEbOU9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="157297435"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 08:11:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 08:11:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 08:11:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 08:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul4FtGEf0VvyXn8I4jB6AI6aIwCARebmL+iq60XSRLXWkk8bCjcTGu4HrRXpIw7UrXEwnC50Z/jUxPBUIqXNtM3E+n9TXoOeA8tYtPW8IiLVqh0LZAp/fcfuDi3m1HnTP8/b+OsPgYbuj8vW+hzn2bqivciuPe7oTkR4JU8jFNjQHB/ufp+IJ8p+g+O4OudVJFk0W+lxWlmeZaKz2LMs/SpeXvUmbUUwATs80mvdwElYipSRpTcE3etSqDBjUhjzArWA4G9oVh8KUdWhEcKuXviII9bagWX9pvBRdjRIY+cK0CAAgHfXGwJtgNkcgul1QC04DEkhz7su7Fpd0tl5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGMCyH8xwX0d2OyspKVTCgY5CkTjC/qcGT7SLfbo6HA=;
 b=IrH2RWjHBsxQYDs6aRNHki8e2VIlOCXryR/tgBMu6h+D4Uyz4qgQIdJhwTZYjfDuMSUfBb9DGyPmHv66CMqxR/4MVoVCf/NKo3kYIQxzGAJnNfqhs6uhmEXWewI4TXNIt7lVM27JKR/keXhbpFJzbyFaEgvDfDJxh9LBFJUMPxLocNUuur2/PHpZ6dAnHJdpotnnd/pAuvPaQC5ZVlrfa3r+mbKMxgy4JUXe8zUPPUlYu8fKwKg7/gZewmXX35KYbdhnnuvJqZ5UAPMjOt908vZ8uekq+iMexaipfwTHMuWr0l2HeeuEiMPgExjUjr+ksX56KN1z6xHgflTdwKsE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:11:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:11:13 +0000
Date: Mon, 14 Jul 2025 16:11:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHUeDKTOHzK8yLUK@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <20250714080654.3c1feeea@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714080654.3c1feeea@hermes.local>
X-ClientProxiedBy: DBBPR09CA0039.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b15082c-5423-4b0a-4055-08ddc2e8abf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hw1YK8ge6sFTY1xDMEVlO/hMyFShrOC/hrTC+rPA8CwfvfbENvQLS9Zxb+2M?=
 =?us-ascii?Q?4259WgLOoy4pxODRozpR1BiO1NKLoGTQGqyFevzkD4OcoIHUEyM8q65GUiWd?=
 =?us-ascii?Q?crzmGkgSEmQHKdy7V362IF1IWDkujggbuu5jpUhrOFcykhtil0U5FcpIPdme?=
 =?us-ascii?Q?6Ifx1keGhhOTsB524tXzXUo03JncNIJyG1eOlh9/AUii07QE3TlhF1pnIYmb?=
 =?us-ascii?Q?Aw7N8jJiIBL23KN/e/NjE/koCz7J7KU+hgU6oo+pHC/WM3oCPxsVwBBYvcRO?=
 =?us-ascii?Q?MjrElPtHBdwecj315hO70DrClv1bSBkpYi7ex05OiTykraUOTYxlBLbwNhZo?=
 =?us-ascii?Q?hbEHlCttHcsDC63V17ruHFPKQEcykk3YzL9aEPuJJW/jWhrGapwWlH4zUc1I?=
 =?us-ascii?Q?9krXz2YuW7jU3s7jmqBjCMY4QXH6KCxEP+JH4iob/wLK8bvxyZEaF6zZJDcO?=
 =?us-ascii?Q?g5ubD843I5yRLe9xQ/Io5g8omSEuxHL8y8PUfvtvQ0ilm/IaWAfSYrTWQ3AI?=
 =?us-ascii?Q?WoeIcg1o6nOoehpFsqr0s7iF2i6y2IGJ+21H1vztUff2yAnkve36qJuAC+4w?=
 =?us-ascii?Q?FKJi39qlGM0vnfELkqpxAjToGzOyBoUtqLX2wx2kkbWCjJeHtGUPIPl4RSgL?=
 =?us-ascii?Q?SMStWmRfBnuua3GswmeeYm9Pn/7soyaLKLCrvasdRzOMmDYrzZM18Xffo9B7?=
 =?us-ascii?Q?ieirKtHAnL04J5EuYezy7tybkCEuOH9qmgazXOB3Rq4tpHpctF96rt2eAD3o?=
 =?us-ascii?Q?+CAO0j/KfW/OttRLiIY5VLGf0d6dZ3mNlQHDwfiy8o7FqFx5OaiisHTEcoi7?=
 =?us-ascii?Q?L9Ob4RL9/76quD4MuOAbZWjbpOG4AFuiqzN632IvjUzekb//P3A6Buq1YwUm?=
 =?us-ascii?Q?oBth5UYDKki3+uWsNym3kdMeg03a00BShOl9bzzog/D/UbNIRQu2CP5kuxXm?=
 =?us-ascii?Q?V3KXp6T28kJ8lp0dvSGA20zigSCHKD7ZfBngrzrscuB1Wmsk6ggfMqnzqLz6?=
 =?us-ascii?Q?fQnws6zsaDgAEdKx2vASsQ23Ptv8pZ1dMzoQDDxeTH9Ovvs7K8Q5+7FEVTqX?=
 =?us-ascii?Q?j4kfOOYTfzoZhTkwfTnOEPK0g8SVYkekv8pAXdVpEqt5IhcUAYjmovGWCYQR?=
 =?us-ascii?Q?LscxizktCvmfgLow2s8ZgPOq3cLGMcokcP9AxNVpnKcXmK52mJhpRG9Ytaos?=
 =?us-ascii?Q?fCD7zmlYMBs0PwS1PG4PtlK8CXWD9qgOe/NOOhm8jbMAd0vvFmhHOSghWX6H?=
 =?us-ascii?Q?p3O0JLudivtxzOdxJKxQ+o2zHUXLxwjDvp2SY9RfqT3f//bBBvT3tGyLSwUW?=
 =?us-ascii?Q?7OcLjBKj1D+iM10Y9PYWHqqwLISGcH2aSbA6P3KztT1/rO6eV9+K3uJTDBvi?=
 =?us-ascii?Q?mhXKXFJHKml5Kpgb3CnFC5B62GgxiqMW76RVVC444iBpUJSeez5uB5fxV/4J?=
 =?us-ascii?Q?MACyHdU7508=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7tagCJxKMfuGy7CExqUHXpfK40/OAs8CvFpaTeVuKOzBuKZSo+vdphHnun3?=
 =?us-ascii?Q?yQwHDxbm7JiL8RRgxH8q6c8zaGclCiw0DbiTbvi1PHUJIzannS5wny5/gEm2?=
 =?us-ascii?Q?XChs0d7JTopADL4Cfw5mNBiBU/R2/bEsm5zVNT69K1eQx0GAZj9vejQoKgbA?=
 =?us-ascii?Q?SzJPlHMjFNeV11/GelN0ihGhh+8nOzzx7Fsc5hwVod8ugaHf/PWE69SRvvg8?=
 =?us-ascii?Q?9HbQBHRBkqUtGvBsed9g6oZ06NCnBjikf4Akbv0vv8UFnohSwKGi8WEdAxzq?=
 =?us-ascii?Q?gW6A7myk11+AjKnUYleBJ5sZ6OAnAq3yMqOooFOCd/IyqSvqEN4Wv5pr3MLg?=
 =?us-ascii?Q?1TYQIluN61W3zFtMfwWwUWpb39UJsD84/TZUvVOowTpMxgSuaChdvKIPFauC?=
 =?us-ascii?Q?RV1Q9wnAE4dmP5gKpiUiiBJCqQqGia26kxjA+SLB7KpPg+vd19UOiui2n7CC?=
 =?us-ascii?Q?U/pCv47eaHwj2r0GGRs2QQOpxdxmglNcnviknaJwwg6Pt/sOjmpL7USqydNk?=
 =?us-ascii?Q?b6wyf4mbIYtmGvTN2WJ2dWwsPpdfGdGPvLh4WZVpkUbZhdXK+m7QUB3oD3LW?=
 =?us-ascii?Q?jhSL/sLRrRtbp2mR68a2FNX6hYvmB+y3dUfHcwd3JXc4Lc6bDrwN3rKa5V1r?=
 =?us-ascii?Q?Va5hacNbzIH6rhv8a6JPkgTjwWSHLZw75B5EQ1EDmVxQ8Xm7AlrkgM6BbEKH?=
 =?us-ascii?Q?/GY7nP/JV6CYne7wlgY07XK5UrcNpwHHkf8x+u4UwjSpP5mHyfusYfYHwshO?=
 =?us-ascii?Q?rmYbRz5yAjvPxijWAfCd2TVxq2bLwsTeCh2Zj61N6+sYOpOh8OntW4fGPA1R?=
 =?us-ascii?Q?PnIrXPVuZs3ml4hVkPWMnPMqjpCa1R0ARXb7Zck6gXitml70YTm1EuYxfJix?=
 =?us-ascii?Q?z4Mt011l1S486D69CVkp/fefQ5ICPYZy877629i45TCWYOiETypAHiT7SW1q?=
 =?us-ascii?Q?en8hVeP8oCMSpt7Az4laFgV387nrMGISTMLOli+W8QBcqthb99Arcg91iL5T?=
 =?us-ascii?Q?NKJI9i1ewVOZteWBcqPTdXcBRUZvEH25eGo/vB3CvFvJSDsnZ9X7U/cFu9je?=
 =?us-ascii?Q?pyl9x8Whx8PwPg58BiYiX4X+lx/zGzty0maIzD8dnXJsmwP1LKthF2QB/j/P?=
 =?us-ascii?Q?Mi1/XT2HypMF4xXG8ooe8bCYrh/NkG+rmq1fdXsBsVVD8x1gAfpfKnpBKwRp?=
 =?us-ascii?Q?R5GuK7JpHwHGZ9lv2FMSdLRBf6TpBBRo0Ytx+zWz/ANeIdBrzdxnNQwQDk8H?=
 =?us-ascii?Q?i+CSKhfs+ofEs1SnxF9BcdOYFuP1wEFY3zU6iQP4DwNtPpNe3C88Dws+K7iO?=
 =?us-ascii?Q?1sCTFDBl9SYq5mX1W+V/kvhVAfuZI26UHt6w2Bar6Hr7y7BBTuJra2JfP6dq?=
 =?us-ascii?Q?RTv8wsIXfSe+YUZel1czz9x2FZ/6w+r5LkHkMBj+bdlHL4aNc9YxzhdiAEZb?=
 =?us-ascii?Q?R52ZgMIgc+GkeoISOzFx5uel7T+Zj8iewhLoRg2d0/GmMlsx4y9yDla7XJ2+?=
 =?us-ascii?Q?k7RoYvxrhhMBLeK0LPNto627YuyuqwDt2otXJSum3dFzMm8h3KtKJ5S3y/Qx?=
 =?us-ascii?Q?Bcs+aHmpUdMBH7YNW2WMsiwhmMcdpeNtiboSL26DJSglerCv4O+SSGzfZhvv?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15082c-5423-4b0a-4055-08ddc2e8abf6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:11:13.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmEfd5tv9sD/6THk2H3Kv1N4GOSAhB9XgH2rStWja5dgMYTrbJcJhCZ5GDQUKXDORvAm5wLiY4q9/k2taSr1NT/8r4IFnZromf8SQ+OcSVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
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

On Mon, Jul 14, 2025 at 08:06:54AM -0700, Stephen Hemminger wrote:
> On Mon, 14 Jul 2025 14:30:14 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> > not very well documented. Even the documentation that does exist appears
> > contradictory.
> > 
> > For example, the doxygen docs for the mbuf flag
> > RTE_MBUF_F_RX_QINQ_STRIPPED says:
> > 
> >   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> >   is unset, only the outer VLAN is removed from packet data,..."
> > 
> > but the docs for RTE_MBUF_F_RX_QINQ says:
> > 
> >   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> >   headers have been stripped from mbuf data, ..."
> > 
> > Without a good definition of what the correct behaviour is, it's not
> > possible to assess and ensure conformance across drivers. Update the
> > documentation for NIC features, ethdev and mbuf library to all report
> > the same information: that VLAN strip feature is stripping one flag, and
> > QinQ strip feature is removing two.
> > 
> > Summary of VLAN and QinQ stripping behaviour as reported in docs after
> > this patch:
> > 
> > +-------------------+----------------------+----------------------------+
> > | Input Traffic     | VLAN-strip on        | QinQ strip on              |
> > +===================+======================+============================+
> > | Single VLAN pkts  | Tag in vlan_tci      | Tag in vlan_tci            |
> > +-------------------+----------------------+----------------------------+
> > | Double VLAN pkts  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer|
> > |                   |                      | Inner tag in vlan_tci      |
> > +-------------------+----------------------+----------------------------+
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  doc/guides/nics/features.rst | 21 +++++++++++++++++++++
> >  lib/ethdev/rte_ethdev.h      | 20 ++++++++++++++++++++
> >  lib/mbuf/rte_mbuf_core.h     | 36 ++++++++++++++++++++----------------
> >  3 files changed, 61 insertions(+), 16 deletions(-)
> > 
> > diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
> > index a075c057ec..c57ea8e08f 100644
> > --- a/doc/guides/nics/features.rst
> > +++ b/doc/guides/nics/features.rst
> > @@ -483,6 +483,11 @@ VLAN offload
> >  ------------
> >  
> >  Supports VLAN offload to hardware.
> > +This includes both VLAN stripping on Rx and VLAN insertion on Tx.
> > +
> > +On Rx VLAN strip always strips one VLAN tag if available.
> > +If multiple VLAN tags are present, it strips the outer tag.
> > +The stripped VLAN TCI is saved in mbuf->vlan_tci.
> >  
> >  * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_VLAN_STRIP,RTE_ETH_RX_OFFLOAD_VLAN_FILTER,RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``.
> >  * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_VLAN_INSERT``.
> > @@ -501,6 +506,22 @@ QinQ offload
> >  ------------
> >  
> >  Supports QinQ (queue in queue) offload.
> > +This includes both QinQ stripping on Rx and QinQ insertion on Tx.
> > +
> > +On Rx, QinQ strip strips two VLAN tags if present.
> > +If only one tag is present, it behaves as VLAN strip.
> > +Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
> > +
> > +Summary of VLAN and QinQ stripping behavior:
> > +
> > ++----------------------+----------------------+------------------------------+
> > +| Input Traffic        | VLAN-strip on        | QinQ strip on                |
> > ++======================+======================+==============================+
> > +| Single VLAN packets  | Tag in vlan_tci      | Tag in vlan_tci              |
> > ++----------------------+----------------------+------------------------------+
> > +| Double VLAN packets  | Outer tag in vlan_tci| Outer tag in vlan_tci_outer  |
> > +|                      |                      | Inner tag in vlan_tci        |
> > ++----------------------+----------------------+------------------------------+
> >  
> >  * **[uses]     rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_QINQ_STRIP``.
> >  * **[uses]     rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_QINQ_INSERT``.
> > diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> > index f9fb6ae549..ccf0cf5e30 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -1552,11 +1552,31 @@ struct rte_eth_conf {
> >  /**
> >   * Rx offload capabilities of a device.
> >   */
> > +/**
> > + * VLAN strip offload.
> > + *
> > + * When enabled, strips one VLAN tag if available.
> > + * If multiple VLAN tags are present, it strips the outer tag.
> > + * The stripped VLAN TCI is saved in mbuf->vlan_tci and RTE_MBUF_F_RX_VLAN_STRIPPED flag is set.
> > + */
> >  #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
> >  #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
> >  #define RTE_ETH_RX_OFFLOAD_UDP_CKSUM        RTE_BIT64(2)
> >  #define RTE_ETH_RX_OFFLOAD_TCP_CKSUM        RTE_BIT64(3)
> >  #define RTE_ETH_RX_OFFLOAD_TCP_LRO          RTE_BIT64(4)
> > +/**
> > + * QinQ strip offload.
> > + *
> > + * When enabled, strips two VLAN tags if present.
> > + * If only one tag is present, it behaves as VLAN strip.
> > + * The stripped VLAN TCIs are saved in mbuf fields and appropriate RTE_MBUF_F_RX_* flags are set.
> > + *
> > + * For single VLAN packets: Tag is saved in mbuf->vlan_tci (same as VLAN strip)
> > + * For double VLAN packets: Outer tag is saved in mbuf->vlan_tci_outer,
> > + *                          Inner tag is saved in mbuf->vlan_tci
> > + *
> > + * Note: Specifying both VLAN strip and QinQ strip is equivalent to QinQ strip alone.
> > + */
> >  #define RTE_ETH_RX_OFFLOAD_QINQ_STRIP       RTE_BIT64(5)
> >  #define RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM RTE_BIT64(6)
> >  #define RTE_ETH_RX_OFFLOAD_MACSEC_STRIP     RTE_BIT64(7)
> > diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> > index a0df265b5d..23aed8ec69 100644
> > --- a/lib/mbuf/rte_mbuf_core.h
> > +++ b/lib/mbuf/rte_mbuf_core.h
> > @@ -63,10 +63,17 @@ extern "C" {
> >  #define RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD (1ULL << 5)
> >  
> >  /**
> > - * A vlan has been stripped by the hardware and its tci is saved in
> > - * mbuf->vlan_tci. This can only happen if vlan stripping is enabled
> > - * in the RX configuration of the PMD.
> > - * When RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
> > + * A vlan has been stripped by the hardware and its tci is saved in mbuf->vlan_tci.
> > + * This can only happen if vlan or QinQ stripping is enabled in the RX configuration of the PMD.
> > + *
> > + * NOTE:
> > + * - If VLAN stripping is enabled, but not QinQ, the tag stripped will be the outer
> > + *   VLAN tag of a QinQ packet.
> > + * - If QinQ stripping is enabled, then the outer VLAN tag is stripped and saved in
> > + *   mbuf->vlan_tci_outer (indicated by the presence of flag @ref RTE_MBUF_F_RX_QINQ_STRIPPED),
> > + *   while the inner VLAN tag is stripped and saved in mbuf->vlan_tci.
> > + *
> > + * When @ref RTE_MBUF_F_RX_VLAN_STRIPPED is set, @ref RTE_MBUF_F_RX_VLAN must also be set.
> >   */
> >  #define RTE_MBUF_F_RX_VLAN_STRIPPED (1ULL << 6)
> >  
> > @@ -113,19 +120,16 @@ extern "C" {
> >  #define RTE_MBUF_F_RX_FDIR_FLX      (1ULL << 14)
> >  
> >  /**
> > - * The outer VLAN has been stripped by the hardware and its TCI is
> > - * saved in mbuf->vlan_tci_outer.
> > - * This can only happen if VLAN stripping is enabled in the Rx
> > - * configuration of the PMD.
> > - * When RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags RTE_MBUF_F_RX_VLAN
> > - * and RTE_MBUF_F_RX_QINQ must also be set.
> > + * Two VLANs have been stripped from the packet by hardware and are
> > + * reported in the vlan_tci and vlan_tci_outer fields.
> > + *
> > + * When this flag is set:
> > + * - The outer VLAN has been stripped by the hardware and it is saved in mbuf->vlan_tci_outer.
> > + * - The inner VLAN has also been stripped by the hardware and it is saved in mbuf->vlan_tci.
> >   *
> > - * - If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are
> > - *   set, the 2 VLANs have been stripped by the hardware and their TCIs are
> > - *   saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
> > - * - If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> > - *   is unset, only the outer VLAN is removed from packet data, but both tci
> > - *   are saved in mbuf->vlan_tci (inner) and mbuf->vlan_tci_outer (outer).
> > + * When @ref RTE_MBUF_F_RX_QINQ_STRIPPED is set, the flags @ref RTE_MBUF_F_RX_VLAN,
> > + * @ref RTE_MBUF_F_RX_VLAN_STRIPPED,
> > + * and @ref RTE_MBUF_F_RX_QINQ must also be set.
> >   */
> >  #define RTE_MBUF_F_RX_QINQ_STRIPPED (1ULL << 15)
> >  
> 
> Since QINQ strip without VLAN strip would be undefined, it should be blocked
> at ethdev layer. Something like:
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..0d51c7cf82 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -4542,6 +4542,18 @@ rte_eth_dev_set_vlan_offload(uint16_t port_id, int offload_mask)
>  	if (mask == 0)
>  		return ret;
>  
> +	/*
> +	 * QinQ offloading dtoes no make sense without also stripping
> +	 * outer tag.
> +	 */
> +	if ((dev_offloads & RTE_ETH_QINQ_STRIP_OFFLOAD) &&
> +	    !(dev_offloads & RTE_ETH_VLAN_STRIP_OFFLOAD)) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			    "Ethdev port_id=%u requested QinQ strip without VLAN strip",
> +			    port_id);
> +		return -EINVAL;
> +	}
> +
>  	ret = rte_eth_dev_info_get(port_id, &dev_info);
>  	if (ret != 0)
>  		return ret;

Ok, that seems reasonable enough to enforce.

/Bruce
