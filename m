Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2517C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C99A4279F;
	Wed, 16 Sep 2026 15:09:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A963540E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789564188; x=1821100188;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uVtDRPIdExtXP6/gfd+rF6X44l3EaWu4xIgzCFQn1+8=;
 b=FmSR6CAZAtR4a9z/2NrgYiK2Xcl7Q2zYELdLYJ9qeQ8+0uaEnSwbuuLX
 +xbuZI2SUflRldE8pg2lqToTa9xR4uCV5Kl1FFnnxL/NrFzHaNFi6eXjd
 xPQSuyvD1ejudYk+zBVVl0CWWPviLcfc5q9uOiiFFv6irawqaGoiOiwG3
 WvSULPtR3abfYUrXy5l50uoOXvtJzjD6HTqYrx0scZ6GEZH5mA/JuLeEg
 1MNIxzoG3OuQAqaOLy3enFQ0TgnGNBUSKjo35DbHPLyPJ2uv8RMreUJWd
 0nBc5aqUfUw5hr8D+2qxgwy8kaR0v+K0OqPpEt14YATain3RXEj2ejt+3 w==;
X-CSE-ConnectionGUID: kCe5hsnVSXmDR2j0d5aleg==
X-CSE-MsgGUID: tyYdK6ERTt+6IbgCVWqoaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89809468"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89809468"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:09:46 -0700
X-CSE-ConnectionGUID: dKKUR5LuQsmYpwV3CpMQ4w==
X-CSE-MsgGUID: PtdAJc03TKWa1J70NBfNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269080215"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:09:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:09:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 06:09:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 06:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCfrQfFsrerIy/iKYWh2KTwdjXA00P2E9sKcaJjXypM8jlXqaoajEbuswBciDAX+sdyC/4pQNUTcebM/y/OJm/WzckFwiRsx4vQIbUtF4K0Ew63F2myFhNeSWaDHISYwm2j7/mkS6zd5BIlqRZUGoCo9CWYTeWTdp6lFNKKuh89czhw+ahpYwYEqhhkJwcQfAfJS8yF+RZ2J2Tpv6MfzT7FvtsFXnDO3C501qo3gmguzWrDjtPH3NTkQS4KIEeffDmNzLsc21KPTk0V+eBewrfdtZTRDra6YzlXeXpUsIUUBhqAk8qzhEahCZO65pLSkAtoN+1aIl78nsL6HTVrzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw6UDY1SUFJRhUaWuN1/luqfKdU+Lx/8uXB7FyBr+cU=;
 b=vx7M/3pa7kOh8wVBZ1S+TM0wOULQ2JYPJcupZjvTRkg2Tr3jVv/jr6lNiaoP3Mi4+kb9U6B5DI+4A3C5xSiQth9MB3ae8O//+tlxviXexsDmRiPaZpL2HMOw4jF5DpdEs360qTZvnWQJoxqyosky/A2HWEFkxZRidy/QONd5kqo3BV/nesw2lxPjtZVyNmwwqO2s1ItqLweDQMZJIfnOwntsRr1Om8ygxx62wMMhWiebOcJC431jtnxgwQ8Szs/98/hFGdzYObQg+gmIGP7NMMHMUMwW+YsIlamuYt1aAVdX5tvuuPqf3bBQL30CNy4QW2bxMWP7r1XhUPlrc2JBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY2PR11MB921967.namprd11.prod.outlook.com (2603:10b6:930:118::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 13:09:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 13:09:42 +0000
Date: Wed, 16 Sep 2026 14:09:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <ciara.loftus@intel.com>
Subject: Re: [PATCH v3 00/15] consolidate ice and iavf Tx vector paths
Message-ID: <aqqVEeT5YFSzS562@bricha3-mobl1.ger.corp.intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY2PR11MB921967:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a6fe9a-8dda-484c-531b-08df13f3c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZLtsJbffdTwUrI95q7HCtDAqenMnt4e4crniRfRB4TSSmhfOiM6DX8YZPmqd5VeH7xhbWJFLZH4W3yZJleuML+MyOKISqSrH4yFvT5ME2pY9wjcD7MoB3LlYSoSvcdKd45422YtDd4uOouB03lnCuOF+IH5Lvb9N0CWNEVFQJUk3SX1kxXrBfnzI0CTN+41oSEr+XZw2FTpNGgCpWro9Bdw7yk/8ldg9nGbAfHDtMMJKr7QI2j+XznE9NHIYMdfT1VVuLVnYFaAltObZHHDBi6vCBtyAsqnFVU1sc44gpUnj9HHzO6wpdHu8Z3edfqQsr4PJPveyMetzFLErg3cxSNS1BqARhVZQ+FzRHzA+RLWn/ujl3U2abtunXa8liFDaxfaUPfpI61sG9Z/az3qq4uOL5GLgq4nmwV0/7M+mVTohNQk/HlJAtgV5C1Qbawf8Q/zN6IlI/Elgptj6bfPeEoDD8p1JmKODLG33OFm7foqfseS3cq/EgvzcZ4LO2AqM2BrPokffDOzijdc9RcIi1BF6e5iS3QVyrNTuJfgOnD9be5KM/hThzhZDU3T7mopYXDuJR1okrs5s9d2TUgi1U6EopbzOGofZjywTyfk/E9AIo+BiaCW+3INPNVm6kg1c9VbyYfM8Nc2nDwIqmtVU+SQ7oID+elx8PFcsprR3LnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVvLHoFedrigstyaSSFCZiyQo/RXJ6SFWpbHUtWFbDZNoH6GDB4cX2po03cE?=
 =?us-ascii?Q?VJYDTMuitDfRv8KE7xqmsDXLQ2E5X+JYYvwg3stoaQBzKa4beeDSG+KL6IX6?=
 =?us-ascii?Q?+nNgv+TUPx9sKfz/X86Xt3bshyyINVSotWYAcUkb4FxvE+tvc6zBNxPPPgRg?=
 =?us-ascii?Q?3IZjs9gMLNi2dMkpzu6sJJNrj+L47LZQJvi03vvNcbPxnbrUifPTN+fEEjeV?=
 =?us-ascii?Q?GQPNoO0EftpnZ5Hw0dhSG2ItjsAQ7QgMMwW6soO3u0XPZnQnoRi+qCzU2v0f?=
 =?us-ascii?Q?Zy4e15dJ7Q4c/17BUL3piwhx93AhPTVO/ZO7dvieSomGsyzvU/dGhGVFNKcD?=
 =?us-ascii?Q?ECTg55qKeqzB1Vpf6n3sJb8q7fEp4/kHzl/oVRQ3bAH5w9tBqplbnrwucAu8?=
 =?us-ascii?Q?mE3D6iQ0odiLlU3VpPZEQoqSc8UA2bcBtlNfTukqA/tbSHFdAG92T+sGG735?=
 =?us-ascii?Q?WBUmTpxDXGUDRItW9BkAZF1D3VOH8rUIGkTXVRQ9Txy/NZyK1FQrhxJe6tRR?=
 =?us-ascii?Q?SosCe/qf4kOy2+AG1gP+OEmze5wvE/db7JBYBeE/vC9zVNIQJ2erugHB90Cq?=
 =?us-ascii?Q?o1zmzJF9NOPFaq5wfsGrtWYvjnF/sVXE8kV2U1IjWMCum09PFJ3ZSrBV11g5?=
 =?us-ascii?Q?Au52rsXT+Z6OAJXF/Wewo4lncW87wS68q+GLKyHcJB9cww5cOdSwK844kClL?=
 =?us-ascii?Q?9B0ySSVlWl8h9FFHZvtXCSZiLyS6+iov9Ah7funr92CRHceOxFa/Drwd84aY?=
 =?us-ascii?Q?5DQQvQbuTbdsM9zvs/2vhtSjdxq9tK3OeM/Y3e9o6hXZFEOAu4STupJoEFhr?=
 =?us-ascii?Q?pNPyTgivkuN+YK43dfCMTd0XoDHll/ICYorXx58OIqjmWkjRQyqw29zsHJwZ?=
 =?us-ascii?Q?5tWltPZFMB64X6j8PhZCD4w1iIjXk5Msdel0+TzMkXyZQ/f0hyQxMrvrzvsP?=
 =?us-ascii?Q?PfuIEJbaYPExAijwuqlb2/+zqwWGz13VJ3lYu5SThUpIJtO8V3jTqXOU7MBD?=
 =?us-ascii?Q?ycPRXkEbroK109Xfql4jbM1YRd/bvLaWmBR7jpeUcd1PNYmdBDfhlsnxCeum?=
 =?us-ascii?Q?oaTQxcES1X8VA436rvtVL69NeQgssPrQkACVuRpdvPHue/zr8Wip4V550xhK?=
 =?us-ascii?Q?/z1qdWt73hFI+r1/+VAYQBQi3+ZCfzEExiu3W5gQo2xN9pIVmprL8X61zPjl?=
 =?us-ascii?Q?VTsAuTu3n9jATOkZE1GkMcZbYgxfxozhAsdpFYY7NsIAd0jXpqFvY/oz1vKm?=
 =?us-ascii?Q?31Atq7RFsjC38FtnnItMsAUkunfJaCfIL4VNSDnElz9PahB+18dDUBYPjLXt?=
 =?us-ascii?Q?Z+KeCuMg91JyPhaFiirjIp2LMuBFSJhl0ub/d6vplVVMjiV3YHVnrFyb1CHO?=
 =?us-ascii?Q?DOxXP/XIdDVEbRD/Oqe0gB0C7bmFX9qDpH+/OsIgT5it47abZRA/MQIOl3E+?=
 =?us-ascii?Q?yu32Qx6JWkrzDHZhKTCn3kKTCrJpTTvbEB3Fx/dvFd5XvmDXjTso7G3duY3j?=
 =?us-ascii?Q?ihDOxy4jcyFqztupPfWuiPQJ53NZoKvGsyFH/Ney+JJUrzzunCCVfs0J2GMi?=
 =?us-ascii?Q?WtLMZtZ8xV1JpO0Mi4VgmqQ8YCe1rn/8uDq7zKlhraWolrLj5Sz5DKz8mi7b?=
 =?us-ascii?Q?wdwnQsu/CGJN/AzGJoMW6IIAr4BEB5YiNBzXvDwQNvXOoc0t0hYyrnLoYItG?=
 =?us-ascii?Q?+RHMIjCFqxo7EXQYe7uJmzyKAS8Da6idVzjCRzKorpujxdHz9l1zIlxYpBSa?=
 =?us-ascii?Q?3J3uPMalXl+89TbhuScEj6Rpyf4d+g0=3D?=
X-Exchange-RoutingPolicyChecked: 0mee83CsbJ09KrHRBSxdnHM2jPRLxEXyBRNQt/u6jOMOLsz0zaTsNSKQk6m7XMa/DrRVLfbEzfVzVj5np2HtVQmYZzM0jWO/vHdmXMPZakEwGKRJ5oHQCN3aPGps4ipt3UNOysYqsoFrc4nJz1Xu4cFcqS/U3TnQGrfcxbPq/zGC2hMGZxF3TSEg6f/bcrRvj4C6iOX7LJRX5RCD00+k+mR8V2k7rSFmhokFlXiKgwaihdfVXlwqut/OIT3jMKdNkon+3xO5ufdsxEyge64Q3pc0EYoKjRVRh0iVoreHcUOarC86v7enPOkToskiXUD1LMhn0oc/AOVQzHquEy7yXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a6fe9a-8dda-484c-531b-08df13f3c59d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:09:42.5763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2JVnOA4RDWvbEaefd1SLIgBSXjP+rOqlBW7AXlJNT3G1aIG/MmlHf9gQCxFhjwgwP5yccSTDUuHChvDmn28vp5gXHDxTs5x6psKvZoEZ+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB921967
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

On Wed, Sep 16, 2026 at 11:36:07AM +0100, Bruce Richardson wrote:
> This patchset consolidates the ice and iavf vector Tx paths, moving the
> code to net/intel/common. The iavf code is used as the basis for the
> move, because it has a superset of the features. When the common code is
> adopted by the ice driver, it then gains features such as QinQ support
> and tunneling support.
> 
> V3:
> * fix variable shadowing issue in patch 15 (ci_txq_vec_capable param)
> * update ice.ini with new features
> 
> V2:
> * fix build when iova not in mbuf
> * add extra patch to consolidate the offload flags
> 
> 
> Bruce Richardson (15):
>   net/iavf: remove unnecessary alignment calls
>   net/intel: make Tx context flag common
>   net/iavf: use separate params for VLAN and QinQ position
>   net/iavf: deduplicate tunnel field fill functions
>   net/intel: define common macros for tunneling bit-shifts
>   net/intel: move iavf descriptor writing functions to common
>   net/intel: use function callback for lldp
>   net/intel: allow building without IOVA in mbuf
>   net/ice: use common descriptor creation functions
>   net/intel: move vector Tx paths to common
>   net/ice: use common AVX Tx functions
>   net/intel: add common vector Tx fns with context handling
>   net/intel: improve Tx path selection logic
>   net/ice: enable context desc offloads for vector Tx
>   net/intel: consolidate Tx vector offload path checks
> 
Series applied to dpdk-next-net-intel.

/Bruce
