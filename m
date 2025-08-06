Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A39C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 10:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4403340264;
	Wed,  6 Aug 2025 12:36:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 19E7F40263
 for <dev@dpdk.org>; Wed,  6 Aug 2025 12:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754476583; x=1786012583;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MwPtQSaL8Nfhxnz7W1Tzn4yauZ89ErZDmnpVy6xcLW4=;
 b=WBObNEUCrsDRsocBVCZSSb8PuNvZM9YYkpNBNbvrL/LPgHh4LMei5lva
 XuhD0wRPC0Z8FxiVyKWNacff8bZflLrq2dZhxPfVT4WNKebtq4cWJuqod
 NKT3W2ASsScS8X2itltEmP7OaFlilKpS67YiJUYewXUsurg4VQ56JmY+X
 pLY85PucnfzCtn08IrAcBgEJa6TALn2NAbJF8EVIUYm/2M/BEZFE9H6el
 7HS9NOHzn0UGkFKLkyO3EmL2SGSaHbKxQv8j7TFoO2SZfH/3rGmIreogh
 lvQj4KCvzF0KeuaB9cAsId7Y+zJKSucrNMTsS30/4ej15o7FdomlA5SNN A==;
X-CSE-ConnectionGUID: /0hJYr3wRQi5wUPjMHSJuw==
X-CSE-MsgGUID: eQb4IxeIRjasE54Vzonq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="82237882"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="82237882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 03:36:21 -0700
X-CSE-ConnectionGUID: 32xGM3cBTaisqHaKjtZHjw==
X-CSE-MsgGUID: N3fDehRsRwOVTvS/bNkWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="195709660"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 03:36:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 03:36:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 03:36:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.76) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 03:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTJ9zL/2nlFblozbfexc3y767chpi1VjaUtEQ6JT/DgKiOWnrXt72aMJ4lS2wsLNcpNawfB2LVMgo8CfEJUc43NahfSMr7p1t9Wt1juODuW1hJF5+5p2dMSZmYyiApLpzq/o8CpKOfvtD4aBhnQoH0F9OxC0GZ+NkvkIWYFgBRAvd2NqFnRLdmH935woLFY7Z387XGvJHPsW8lzS7RtXnV8VXTz3fUBF8MbLZviHTyMeOq80LtSE52+ZbuYfrxOE+W47WErTH3gVpHe8gU2f/GpqIpql8Y8RJWOE1dZtv3kIl05mgxZN6rFvPaovFSaQqZA9HtFxRtpa3HPkL49UhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyFPHQQcK1e3kKJcwlY3NMk1NBN1C1vOyiGQ73BnWrI=;
 b=EQxCeuSBQagBaYDmIIDrv9g6/HVII+TnFKkrDGCda6LpUw1fhxNN4j3zs4LmcQ7MEYk56gv/Ew320njwbFdS6ztfdJBEQum3r4z5cZAEuTultDJY9yj0N+WcjnBaLy3Yjq9/96JG3c8LcgVLE5wD4knDI4BpXneJGmscqbOa4+d/egI52y1MPbWn/53knF4y40fd8GcRKz9nQnOIGtwiC2zpNSMtzctqVZ5k7cG25+8DR9edwlxQypRk5Ojeyjoj2Una3bh90JJfVBKfr9DqK30yX3lkuSXeJ1fyMr05G26dp1Ss4xEdWHltmCrfDnFs2LRReTGFEDFzDpcM50uAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 10:36:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 10:36:16 +0000
Date: Wed, 6 Aug 2025 11:36:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC PATCH 10/14] net/intel: introduce infrastructure for Rx
 path selection
Message-ID: <aJMwG1wMe2DNByEn@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-11-ciara.loftus@intel.com>
 <aIOhFIwIpdo1nghY@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A175CDB2701F500BBD0EF18E2DA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A175CDB2701F500BBD0EF18E2DA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0316.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 2360d38d-756a-4602-50b6-08ddd4d512e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gymO0dSZ5izg+uvONLt5iDgy+RdazUXB/BOdY44n/L0q1RH2oUsHxDLffxS1?=
 =?us-ascii?Q?jB7wgJQeyf7GzLVpGNwNOehq5WcCKA4veNDhPbMESnHrWYIIv9d3hFo5ErJy?=
 =?us-ascii?Q?Zk1kwaghtlJdblnuaQ2zRwKYjDJAaFK2QfSgOKq0COymaNNlS3NbJ5pKue0v?=
 =?us-ascii?Q?QzmWAYU7ZoAG/gMZuyWet03ox0jUTMKpGY5Qf52LUW5rYB6OyM4d9B2ki9yy?=
 =?us-ascii?Q?pNoSPOhwv/15lXv8AsxiJyvla2g5ozOYM4mGYtzZQNmkE4g04OOkVb3lSCA1?=
 =?us-ascii?Q?p6JKaWK9C6U3kC295QtPTb9YFviAg4JV00WAEV6DIPl7T0Lc7+tdzdBz7Hg5?=
 =?us-ascii?Q?FeAyGDNZw/v707QJzhkC2ww6FlZd2Eyc/NfgGHYXRklICEtxETWqN5qPJm3P?=
 =?us-ascii?Q?wo5dny6gIvSfM+x3DcIrEpD8zR6oNh72D3zPqL/yPFGSRmE/pAZt9OfNJNd3?=
 =?us-ascii?Q?ViN0TBnr6wtwV/5PBY0c2EPRtXS5eDJhZBqHOcdGUvLAV+KzIGwYEnF93gem?=
 =?us-ascii?Q?+D+JjhYZmEl9ZmMZEo0OgpRW2QLgeOXQanzd/pgpFGNtuPasOLGkavyzOob/?=
 =?us-ascii?Q?Qys2kU8wg/P5zTcQyUMRUPRIvOFskqP7do8ENVCgu9Vg07eVQuQPQwushzpJ?=
 =?us-ascii?Q?8ZmpGI6cTPHrI5KRJaGcMGujrw+LDcxLbcqKVdKT8j1Jlovpk8mD7l+PewbS?=
 =?us-ascii?Q?JGeYS88ck0k79ZwhkIsZUE2sfjZE1KFmKzP1EZednjlsrmYfgMcdE4Gm+xSn?=
 =?us-ascii?Q?lIPMNs9JvoWap25LzWomT4+dyOHcp4fn4yK3mK/51wSC3GmiVlMM6z0qgWwI?=
 =?us-ascii?Q?r2N0hScbd4IN+JkFibPo71EW5Lwn03ehr1aV7qwa4FtnXXxZRXieGLefCR+Y?=
 =?us-ascii?Q?S9RUZS2LrYDWnAlvDbw6TlW0H/7DIMZRwo4lrMVKkFbYgOuzM7MOThRSuyYz?=
 =?us-ascii?Q?TIcF01FCdQfAWN9Pf8rwqpXUzzznUEVEPOwbBDxPUNpE6fqS9UIZ2XE4SaFV?=
 =?us-ascii?Q?ppKyAO7/rNqfTop7fP5qu1Y9pnQAt5WFK2KYgQKjfLgQW1i1J2uGtaKdKxn2?=
 =?us-ascii?Q?SbpEYOvAjBoTJeWMoc1P/2XQewT3fFwfTpR2PbWi1I+wd7AWHB0k2xxjI34N?=
 =?us-ascii?Q?3CtzRM//wwJYeonppTqdkoB7v5/UO0uaBecyDa+O4IlfHfFtpyDY+foW6fj+?=
 =?us-ascii?Q?8K7HkrWqHuWQmzCWLkauSt/6Q0K5rvoUlFhB9bGuIfte6M+sVcAsmJygjXBZ?=
 =?us-ascii?Q?KVJBEMWeoo+V88xLnE7aEc4Cz12RGdjhl5p4nO25gqxxkDSQNkyJYAYkyqgH?=
 =?us-ascii?Q?y3WR6QEs3WhBfJNeArjTWFHNbtWpWOpy6gb7NmILXfR+n2uI2OTexydcnKru?=
 =?us-ascii?Q?wDyoIAFDDcrhwcJ1tFWQV3MwszyUepMSyujT7i6XzZY/o62QZwamWqopnopH?=
 =?us-ascii?Q?Jx+HlZZd2+A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ferXEAxwsxcabm5fdyaIWU01cfHhkJ0Gw+INxsgaJSuX/W1xado8iUbhVpNB?=
 =?us-ascii?Q?PpGB6c0hQVgbSP3cuG1Pc+U7nS6J4UeG9XMJBOD1Gsy57augxdDrAHO5GQDL?=
 =?us-ascii?Q?NaMkNQmGz68djOQDe7wOf7iQbtKxWiOGrspKRqUbq1tBCPPx7f8mSj8d7Yl/?=
 =?us-ascii?Q?kKX1b1rMiIf0dCWUbXyfv9/FVDDQLP7WX+zlWn1F8P+XEJIju2z/DQdRaeSi?=
 =?us-ascii?Q?e+2A2fcS2rbVvKaXHc4h5mT1zKV1qNahPPEjbpbTMJdrASvhGYEqs5kOlqBb?=
 =?us-ascii?Q?+Wa8eb6L9zrQArR7P/9sDXZGMpGx2qWUZPpKXdUygbiOQBcFfQe6lNvClwQ9?=
 =?us-ascii?Q?RmwGWvkNsIQNHUxeTanYIy92+gBfxTfRe9OsM9ZVaK7K3DP6vSHLwx9ctgF2?=
 =?us-ascii?Q?dIjaROzfUSUPtQbj2usIv4mw/LUXJBHDtrk8Y2LIfTDtAkqc4lDYSFhQbW68?=
 =?us-ascii?Q?XhIElHpRZdB0a/R0VNBVchlDcRNMP2o6NCjL+6o4DItb5nTzBx2nxzgcsXwK?=
 =?us-ascii?Q?mCNWA4Om2D4o7tUR+62FSy2TcAuS0M1HLyM6npftttUelEqspAmzCh05gTLK?=
 =?us-ascii?Q?KEBYcBFUeBkh6ilfZhUZ51oqwyE+iNIrUYDSg5tyjAL/WfftiJDRH2TTuM8P?=
 =?us-ascii?Q?p4mD0K5NTSSS72j8ViikTmKpIOCaWKBxABg5ndjtwKKze2/awqLUNhFr5aCl?=
 =?us-ascii?Q?173bGJEBaoZWfOxXvLj9CVfbznmPeOzIWSuG3pCZWQRDRlBS4zm1sSJvriiL?=
 =?us-ascii?Q?S5xdRJ3vsBfnaMcSt0a9IvUwGzr373/AUy3mAm9f9C4kapns3jHoUDvmRy/u?=
 =?us-ascii?Q?56o2R42iISFDcAZqHK7yYk6COknosnICBU8caNKIuodN1UXL91tDQ7bLEM3P?=
 =?us-ascii?Q?KlKrtQTs70vZ4bCd52XZp8ookSbtaMXCyGHx7rBd2H5YCfjs5sH9Nspkeg6A?=
 =?us-ascii?Q?cgfx9hnMZ6Xlkl7rX0XzvHxXkptXZKeK2Yw6BNNLqQsp3TYxnkUBwbSluVuD?=
 =?us-ascii?Q?oJ535OcxGIiqJK+BqCLvUv0IPdgsYkUz3fOf/Yjj17wWypqQWI7ijR2oQnup?=
 =?us-ascii?Q?dOr62KVkju6Qnjo9RKUtK5QjvCzOBsDfldwzYoWR2Ci3iz1Tclh6s3FEh61P?=
 =?us-ascii?Q?t8FYKZn5k1rE8Z2JGC7nliB0lsfNaukAW4pzdjDBD20PhWm7e+Vje8TU7KB7?=
 =?us-ascii?Q?eFYNzMZVsX8lXehuCD3e+/ikGF7IuUUZz0okxO5Ip5Wj9cgHsDm1lH70l4oM?=
 =?us-ascii?Q?h7I5WJN9fwh972XYby5bWwwyzbhzekBduEzN8ICmgTM5M8M/6pVhPGOCzpUx?=
 =?us-ascii?Q?yChSdEC9pBg6eo4OJAnl35P29Duaxfdb8spvnomqJCCyBnjglDTX3H7QcHa2?=
 =?us-ascii?Q?iyp6RtWYC9afOyc1QSitbyOZg4adGtYmTFcB9MSvDYusN9yoHPXbCvlJlSHR?=
 =?us-ascii?Q?e6mWkgo15l1FsCb94FOX42+AUjf6QAR7Z455d5t64MWLg5Bw5RehhA5N8MOp?=
 =?us-ascii?Q?7IxPEZIAPzCRk0XoiZ+dHHk+oKzFbZgqfGg87MJtYOAIIYTkRfFdeca29CrK?=
 =?us-ascii?Q?nLYoS6qy5yxG3BJ53+JLRmrzD4AOIKmdsIjlVaMTljBhePCCYFCNysNRXfA+?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2360d38d-756a-4602-50b6-08ddd4d512e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 10:36:16.8872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQOBHmJCq92efMEqaZy3MiFGWGsPZbIRGYZ/mLt0h2X6dvw09cawX3OY1LlVirconNxhbmmWQJtY6pLO5ea9Hovkm7OAMXlBXtVpb3Ygc+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
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

On Wed, Aug 06, 2025 at 11:14:58AM +0100, Loftus, Ciara wrote:
> > 
> > On Fri, Jul 25, 2025 at 12:49:15PM +0000, Ciara Loftus wrote:
> > > The code for determining which Rx path to select during initialisation
> > > has become complicated in many intel drivers due to the amount of
> > > different paths and features available within each path. This commit
> > > aims to simplify and genericize the path selection logic.
> > >
> > > The following information about each Rx burst function is stored and
> > > used by the new common function to select the appropriate Rx path:
> > > - Rx Offloads
> > > - SIMD bitwidth
> > > - Flexible RXD usage
> > > - Bulk alloc function
> > > - Scattered function
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > 
> > This is a good idea to simplify things. Some comments inline below.
> > 
> > /Bruce
> > 
> > >  drivers/net/intel/common/rx.h | 110
> > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 110 insertions(+)
> > >
> > > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> > > index 70b597e8dc..6e9d81fecf 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -10,6 +10,7 @@
> > >  #include <unistd.h>
> > >  #include <rte_mbuf.h>
> > >  #include <rte_ethdev.h>
> > > +#include <rte_vect.h>
> > >
> > >  #include "desc.h"
> > >
> > > @@ -20,6 +21,12 @@
> > >  #define CI_VPMD_DESCS_PER_LOOP_WIDE 8
> > >  #define CI_VPMD_RX_REARM_THRESH     64
> > >
> > > +#define CI_RX_BURST_NO_FEATURES		0
> > > +#define CI_RX_BURST_FEATURE_SCATTERED	RTE_BIT32(0)
> > > +#define CI_RX_BURST_FEATURE_FLEX	RTE_BIT32(1)
> > > +#define CI_RX_BURST_FEATURE_BULK_ALLOC	RTE_BIT32(2)
> > > +#define CI_RX_BURST_FEATURE_IS_DISABLED	RTE_BIT32(3)
> > > +
> > >  struct ci_rx_queue;
> > >
> > >  struct ci_rx_entry {
> > > @@ -125,6 +132,19 @@ struct ci_rx_queue {
> > >  	};
> > >  };
> > >
> > > +
> > > +struct ci_rx_burst_features {
> > > +	uint32_t rx_offloads;
> > > +	enum rte_vect_max_simd simd_width;
> > > +	uint32_t other_features_mask;
> > 
> > Rather than using a bitmask here and having to do bit ops, how about just
> > using individual boolean variables for each setting. Given that we only
> > have 4 settings right now (disabled, scattered, flex, and bulk-alloc), the
> > actual struct size here will be the same, but the code will be simpler.
> > Since this is not a datapath function, I'm not worried if the overall
> > struct size grows a bit over time.
> > 
> > I'd also note that in the structure below, we need an extra 4-bytes of
> > padding anyway, since the pointers require it to be 8-byte aligned, so we
> > can have up to 8 flags in the rx_burst_features struct without affecting
> > the size of the burst_info struct.
> 
> Thanks for the feedback on the series. No objections with the feedback on the other patches.
> 
> The choice to use a bitmask here wasn't for space-saving rather for readability in later patches when we define the ci_rx_burst_features for each path in each driver.
> For example, if a path just has the scattered feature, it's features can be defined like:
> {PATH_OFFLOADS, PATH_SIMD_WIDTH, CI_RX_BURST_FEATURE_SCATTERED}
> instead of the below if we were to split the mask into booleans:
> {PATH_OFFLOADS, PATH_SIMD_WIDTH, CI_RX_BURST_FEATURE_SCATTERED, 0, 0, 0}
> 
> Maybe it's not that much of an improvement in readability. And I suppose it introduces a little bit of extra complexity in the select() function when reading the values of the mask instead of reading simple booleans. So I'm happy to go the boolean route if you feel it's better.
> 

Hmm, good point. I suppose it doesn't matter much either way. In terms of
readability, if we do use bool values, we can omit any trailing zero values
at the end to shorten things. Alternatively, if using bool values, we may
switch to defining the structs using the ".name = value" syntax, again
omitting not-set values. [If you want, you can even make the boolean values
a separate struct, which means you can mix the two as:
{PATH_OFFLOADS, PATH_SIMD_WIDTH, { .scattered = true, .flex= true }}
though that may look a bit strange]

As I say, it doesn't really matter either way, so perhaps try implementing
with bool values and see what it looks like - then just decide which you
prefer. I'm happy to go along with whatever you decide works best here.

/Bruce
