Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2769BF33A7D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 15:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF5EC4029D;
	Thu,  5 Mar 2026 16:16:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBFB40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 16:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772723771; x=1804259771;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZytmqnvmmwHt+JgylUt7y3C/Bwgibv70TZY2grIVtiE=;
 b=SFahVzKUY2ZCB3fbWimTWApF6isMiUrEwZSK4i6BsjpThQKjuQGkLw3n
 CyZ/j5eosYwu5IsiZfNewMrn9/4tPH5dX+h/vAT2zWA+ocZMit8Kcv6hi
 rkdj90NXf4NislXtdXajiPnh8OHTGPQGXBRsBn/2uYORyYuotAkqxDHc/
 mq4x2FuU4z1/+M/N/KnvcocmpdPjrooiN+5f2wWxvm7DOu3ENTKhSU2sD
 8NBGUSvUbvVgYU/SPTgTYIZOQUwKcAuqBOifAnNYShTntHnESXK4u8y9D
 fj1fEz+KLTp6/0Fz7oZIe1WBWIhDfH8izApf7h7QMyXFH+N7100vB+j3Y Q==;
X-CSE-ConnectionGUID: AHoLUHeFTUO02QLrurY5pw==
X-CSE-MsgGUID: E/78NrXaQ2eZlpJadiRoPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="61385028"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="61385028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 07:16:09 -0800
X-CSE-ConnectionGUID: 7TdCuYGKTzuT8wb+LcKQDw==
X-CSE-MsgGUID: twTELPDXTFionBkVOp4DnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; d="scan'208";a="217859139"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 07:16:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:16:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 07:16:08 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 07:16:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAq5BNhczXWIjELMPQlBOwGecsLv9yYYngPnyq2MdzpWWL/Fvr8/dKXwtfzYxR/UjhUT27Lhsj6Yl87kE728maIqFy4pm8bVDRdliiV/GE+MqGsuUn0zno+oFFpAyIx56eqjj7KA4SwRgxyaIX789RJxzhMn2ddRiw+YtlyAs5CeMpWDJOGOueJqQZKiBa7IRz1w7483VnP/0EwAVcBZsF2qMWhKkrAPTDX50AQ71WsyK1Qke1xR/t2p93vVOJ3POu/HSyJFx39I81Av/9NhkZ19qb2X6vduW1jdzDuZBi/sxcAKDccY5J788bpwb8+sqngfF9la9vjJOO6qjB07JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuVsBj8dr2CvGuoWHTzuM/rEVkzcUWOFQOC6/XR+BZ0=;
 b=olNd474HvJZlx2f8mG+0dfUthEApZmmvyvbVNLwMeO14CbxOrnQgF9/rn9y/278wwlVDNE14X0qEYyfwrSExm/KhfIdfDkl1Nw0/CWCZPZVO6jeG58AwlsQT9AKOzHY481BmJtfimof5g1BRfi7kouEgONUwXiVQz3tN/QwbdiHqKAwOLyj579x/CbkoanFM4t5+u2wpP8hpk/40s65X9ie/RWx69FcuiXNsFypb6+FGWFq/v7pVgMorobUhOLU0bKZJAibMIh6kXBC/lrb1FYc82YQQo0RTmEcSLSA5c/3JBbkpbCgx+fICK6HvneIUvceCY31/TI/sUFMy3TA+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:16:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 15:16:03 +0000
Date: Thu, 5 Mar 2026 15:15:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/2] net/ice: get link status updates via adminq message
Message-ID: <aameL_9QgoD79gjM@bricha3-mobl1.ger.corp.intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
 <CAJFAV8z2vGkbe+HKDqiO2cvhxKJRjM1Ghc=F_YmOZj8zg-Ak0g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8z2vGkbe+HKDqiO2cvhxKJRjM1Ghc=F_YmOZj8zg-Ak0g@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: aa03c59f-df53-47f5-3622-08de7aca1dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: aRVzxz/DcyqSktHoxCPoACXV8+NWl/vWPQ5BqO9HXEs/uo0r/hk+V7g10HUfbjGDFNQ3ry4jzVicOwI1TiyFgg0ITvjtoOWRpKEkKRB23bOi7ncD5xIYwyA/SxT2ct7cgi/6vfpUye1fb2DHH7oK87axY3vrBvZ11kgPrCUAEwaFj528anTeP0I5QvLC64K77IJW5+5ujRW1zjzTAPIQYWFSlEaQ/V5nDhkKcL3czLsQSlmePNDFDKtbYquzJzpdKwMGJgX2AF12HRLY6lOqfD/iiBM8/7lSTpvsf61yaPybcTFcIXRuHk4wOeJqVGbnm1MvKGPV+ue0TZApp5brqqg4lE5mbqItfySZnB9BnXKJv+1UK/aXZb/6XA4cIEXSNX5dfe1xWn9XkQSnC8hWI3YxqoQB94N8BtBgMuhlpQLTmknwjGvRG9TW0YZnJaIJOmx1kQGj4rYSOghl3Dih8n2jygZk1W9ED362jUb1yluQUKklhrPoMNTyw2ib5IVhf5hTGpm63Nw4TAZMCkc6HU1QjU5swnTpwLQTBHnrbGDgJm/WP6SGIb9IwvhSTPzEiL86OGKJcl3sp7d2XU5C6VnrTC1llCanamh/h5EI5zD/izH2FJ8omedYEQlFuy+d/0e5hsQGwYy61tFbUG7VUJkQtkjzaGqzZPsHLg6EUo9QbkluUru0cFqQkjGQrX5FU7Yia4T2OYy/UJ2IRhrbrhlKrEmKQJyDpi9oww3JThU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XacJmqiH1fwyKM/TpX/o4wHn6BTV8typqvrlNzot8ardERsX9YH4Z0R8pp4Q?=
 =?us-ascii?Q?IkVx+Ha9IvW6WPT9+v0bW5rS2m8jzyZDt/JYgpIqcjsm/og58QCzoB2TqOmy?=
 =?us-ascii?Q?keqeY95BNfDX6VPozveldyr+NJQ+JE6lsJfQb1eBUygYY1EGmPHTMDDe/JwN?=
 =?us-ascii?Q?09LZaCUVTXDKac2Axa/Kf9tCaPPXh/rXudl832WuJmY3iesW7l6cpGeNzLVD?=
 =?us-ascii?Q?WjIk17mKxdNzG9/CuaM0w8Yh0U0/hEXKKpwt69zOnw8eVlpGs1Ai6lNQQ3Q1?=
 =?us-ascii?Q?NnPcfrutiNTZhL4B5gc3AQpMaQOSY3Yu6gAjDhPf4aM40Ek7Z4qD9WIuD/sP?=
 =?us-ascii?Q?iCcjZJ6G4+ryPD57o/zSZuRC1A1mbJLo3w6rW9NGlEwS/XqCI9rjV6SOyYqW?=
 =?us-ascii?Q?mIH50ImJfa8ZaG0dRlYogIQSYxLbxprEHx5IQSHTwiCWGbmjJ3/Q51YUSN7s?=
 =?us-ascii?Q?nV72dDgEseV9rgZi3IfpOcBAjXWcsyMM5PmmHqiTyfOq5gm25o9T9OzHFcUb?=
 =?us-ascii?Q?1ymz29pBltauO2NVuM9q7IlFJoS8rbsvarnih3ejpnjglu1tBzBDaYnCox+J?=
 =?us-ascii?Q?jodiQZDZmooDlWepRjUusG9UfB/wW8r3whGPEQXeP9xOkAjjN7EgEhBWFqkD?=
 =?us-ascii?Q?FYeHnjrqm+4jwGysWuvczrBQVFZzeofLZl4gji+hKY29AUifZ/VWm6ACMRwk?=
 =?us-ascii?Q?hka5BgbYDpHY0kLd8PuoeYa2lb1EPlzrMknqCHR6DL18AS90ruNiZNl0neAR?=
 =?us-ascii?Q?mKCLAYb4tl5sk8wb8kUlHKq9ABfaE8+uVjLy9MSqj/bnSKePwujgF93DO8VZ?=
 =?us-ascii?Q?cO2jcQ8rmT2jQcjyB2l/kiBv/9hO9/y/LKxZOsA9sUMyj66Wpdk3GSuVhxD+?=
 =?us-ascii?Q?b8eLQrDavKqoOoCNaL9Y/Z/++8QV7qp+j0HSmD+Knf9fYN1aiGcEuaMldWJS?=
 =?us-ascii?Q?YdSrHii1VZ68LzZ4ZCFWnTcVR98aewafWGJF6Y21xTkn4dY2jeY7IfT1kK8B?=
 =?us-ascii?Q?TUvuB1IGAmRWCUxwJKVcuMl2WI6h0wdGggIbLuOuRjOkK8DYRrF81pTI03zC?=
 =?us-ascii?Q?oLuBm417SGht+VwgOVJIB6pay7aeuPQY264a3rv+QvZut7wQd3xrHt3h7ECZ?=
 =?us-ascii?Q?7EJaLFMyjZBZUjWrMybTkhDWLDpKaQIryxYQ4AzU3ETTXcVx+rBgb8j+Qe68?=
 =?us-ascii?Q?MduQoQx1ZU/6ojc8mnTih1qOvGqtL3igoWiZx3Vp4aRJCdrr0cyaE1OJeg3g?=
 =?us-ascii?Q?vaf1dFE2iwQnPSTpi41nB4TEb1ZihFqG8H0ZZaNAtaYePSPCw9yxOHjBFvFN?=
 =?us-ascii?Q?L867yDzrjSRAmdWVtMLacQyf7t/DegLF9nhvPCTgLyrnhJbkABH5REXdnmOi?=
 =?us-ascii?Q?PBnDkL3MLXFefp+B7OxB36GJ/zsO18iqLevq64qp3Q6TTnHmAnsqQT2wUWdQ?=
 =?us-ascii?Q?gSf7M0UwBJI1dOMCVnZtmCe3pEdBAdp1JNAzjD6oHVW2MFH8YiHB3Lu4US+w?=
 =?us-ascii?Q?U/2xO+4seqwczQYoe0zRBTGevOmHN9KoiURYqVNBJkYhWOEq/XM9xqPTtht7?=
 =?us-ascii?Q?Gu4vOx3ydhihUotLL9PakNh5jd4MgbXzCYuMEjWFpzoMshDcxBF/XVh2yLyX?=
 =?us-ascii?Q?PTpXxnUsSVVISlHKqBlXWmOcM7NsJxMO6jipGEgEDZfwnNlLceovmcQxiVAG?=
 =?us-ascii?Q?cQTcUem3eSrQWAgVTXN/+WWXpCqr6ff0HNTX+ahiQUybahmdXhbF22w40WiL?=
 =?us-ascii?Q?lG7lFBB3uMTk3QbCM3RcM44SccvyLCw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa03c59f-df53-47f5-3622-08de7aca1dc3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:16:03.7560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeiGJQkzazyCxU2K2Yn49xcx8Pi2BpyLcFwKrtmKcDlBf7dQdRQgfISE7vJ8eKQr3cNYILr8kpSKpGUTCCej1MxLmPNA3d3MGk6emJ4HDEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
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

On Thu, Mar 05, 2026 at 01:53:25PM +0100, David Marchand wrote:
> On Tue, 3 Mar 2026 at 17:22, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > As explained in patch 2, change the link status tracking to be via receipt
> > of an adminq message rather than directly querying the link status on
> > interrupt. As part of this change, we can reduce the cost of using the
> > adminq by removing the need to allocate and free memory but instead just
> > use the stack to store any received adminq messages.
> >
> > V4: resubmit to recheck in CI, now that next-net-intel tree is clean
> >
> > V3: added patch 1 to reduce cost of querying the adminq.
> >
> > v2: rebase on next-net-intel
> >
> > Bruce Richardson (2):
> >   net/ice: remove malloc call for admin queue msg
> >   net/ice: get link status updates via adminq message
> >
> >  drivers/net/intel/ice/ice_ethdev.c | 62 ++++++++++--------------------
> >  1 file changed, 21 insertions(+), 41 deletions(-)
> 
> Did a quick test with 2 E810 25G ports connected to another E810, with
> and without LSC interrupt in testpmd, and in OVS.
> Those ports link status gets updated quickly in all scenarios.
> I did not test on a long duration, nor with other types of interrupts
> in the mix.
> 
> For the series,
> Tested-by: David Marchand <david.marchand@redhat.com>
> 
Series applied to dpdk-next-net-intel.

/Bruce
