Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3194CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 17:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EC03427CB;
	Thu,  4 Sep 2025 19:10:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id B153B40275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 19:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757005839; x=1788541839;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fba8B5dE14NKiAK3MJBvl7MjzYXgHwcQ732BgFab/Bo=;
 b=JusL97LrjQVr14vcCe2XmedaUo+6qicnW88qxMyg5wtliVm1GxWnJuWE
 FXseyT3hcnhp2ODN4k8uLrAcWaZoT5aGcMl+OFfrwvXm8ndnoYqffEL6s
 Zp0lf/a/c9GEAi5bFx1YxqqbI7G9i2IVKM/LNsHEOLmhhiRfVI6lWPEPe
 IV7detkHtSzjTtH3/v6GQmJigH6AOd6kRrwWRVww5yUAySv36nMoMx3xp
 g16W5hq9EFRH/ZaySLvZ8GP//UKg6nWbW9WfhbtnrhywjwvY7g0TtN7tz
 OzGDEI51rkIDCxDP0hnFI3LfhO7HB+ciEbkYTzOk6lMe9u/tu6N4O6TPL Q==;
X-CSE-ConnectionGUID: n3FLuSYvQf6B7/msxhWDcg==
X-CSE-MsgGUID: s+6dMwmoT9CESZULAE1wPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81943854"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81943854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:10:37 -0700
X-CSE-ConnectionGUID: oot/DiWWS0KIKug0KD3slw==
X-CSE-MsgGUID: kL5N+68YRPusvEjpYu1vFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="172386582"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:10:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:10:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 10:10:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.88) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKJlz9bwDSsIgqrU+O/kuha1KY/Jcq8RxKrN6+NEZD0MVEF/dmtIf95VZkw8b8r+IyJz8shsv2ePoHsSDAhdMLtu33dipEv6eymLYC3uBYE3VYkKohqNhJJY6+Zvw2YTs8G6dMUTwekwszSi0qNpmAAYMU6jIfTJ5Oja92RPGAIY3NB46bjJsUV45GTPQU3NBBlQV0OYKkHeWFSg3rmRvwHXJwq1LqkQpLahJLgsiaingQFxp4R4pLg/uorCGoAmGRXy9Bwu7CgWdWIQTb5ieO49zRrwVrrHsOzg3KjeaxaQuCKEITvDo+7tYjA6vBtmVlm5MZFaT0HqBocpI8oyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9Ilhcey7je/zL7+D9M6XdBYbosg5Is4Kowam4sesHk=;
 b=xLihReAvhWQq+u4VTezaSm1xhKFTBCk+P8FBxPa8hhI7cjGj7qh2kCri9GD1hKCqErAk/hNPROfIP0qo0GXodNv0LtHUhW8ntwg6KEzw4cw0MFsE5RUeBK/IIcOkOjOT1DprPudQnWsLjlEuf16+VLdle8POotL8NtijjGno3fmyekVdNcvD9ih+sZ9BpZ1wwfNE3G8tPcfQQ/h6RIjKbwVhGwf7/VtqlygGweXbGZUWLD0LL2usG7FWzsEGM29BpU3+t8HYbFfT2g5Uk2MB3NxCrS5uAKr25p+z7yWPq0ZuzuK+k1OsW35JnepCrt0lp8UighkYEanHtJfMUJ7J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.18; Thu, 4 Sep 2025 17:10:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:10:29 +0000
Date: Thu, 4 Sep 2025 18:10:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 3/3] net/iavf: fix Tx path selection for VLAN offload
Message-ID: <aLnIAdsKANxZ5IdI@bricha3-mobl1.ger.corp.intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
 <20250904104440.2167205-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904104440.2167205-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 982fd2b8-f309-43ec-1b0d-08ddebd5f312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLZmSN6XF8qOCNsQHUk9wIp7CKJqc0noosPqqvDAMtFiUtAmCK7sWXHcA/ZY?=
 =?us-ascii?Q?kMZMRRCnu19VhAwrOgti/VMJEbEG8vnVrJgY5AATDtbbbT6AviNv9CgAcPt3?=
 =?us-ascii?Q?HkwpYDDaZxqUCW9oDZMUaS6YaD7/RrMUJNJt9it7wAknbG4fSAgAZnm+WqS+?=
 =?us-ascii?Q?U1VFLZlqh1WE2rbnZjRFtUssA74nM/jOxKMV9yetnXJdE03IfovaMAswdHDj?=
 =?us-ascii?Q?s2mONLD6z1apr1PFIBSFcez+t0t1Nwedo3pz+Oa7vKDMPbeeoKiCTJZK+Fay?=
 =?us-ascii?Q?6iHLE0zKnVuhMXmpOYNj8GflEiOCCJEG9YeC9A1WvndCneR6UCFVZ73MsEkJ?=
 =?us-ascii?Q?4cZOPLATMaZJanfhHmZWNZu4xqgYveh4ehD2X0R2smNuEPxWFwFznc4WqqG+?=
 =?us-ascii?Q?/Gl9K6dH28WIkwMy/87UTREyHvBVT2jMAfaVQdDyO6629WRKDSfYV1i2YvUk?=
 =?us-ascii?Q?dgvzKozazF4E3+r2hBZ/IIRVMFK17et6dtVgoHPqSjWiqI7lHc6IpoV5kTrQ?=
 =?us-ascii?Q?3yc3Fy1+ZGWIQWD1BhznMxS/feDtsjXJgs1DRx9So08D5NJSOU2/Baox7Frf?=
 =?us-ascii?Q?e0Xe4EGyc3VLIFA/8WQqSncJiqYwRBUWUcEwxAfafTFCecz4SMz68KZjZoCz?=
 =?us-ascii?Q?+ul+vZAE0L82No0OcRIwyqigGXfMBq+JaBeiEPxgol+QXOUIru6POafllnFU?=
 =?us-ascii?Q?oOxO9T2ufDbPURqLiXwxrlNlknfshb+gOB7TBYmz2VZw9AlXmI4d0Iz098NV?=
 =?us-ascii?Q?EQ0FXD1EINVfDQfd1CTYV7ZIHGquTaGF2xpnv/npwjZcyh2vv935CR9jvYGa?=
 =?us-ascii?Q?T33Tyw1TmYH5LXCMjlbHMOx16Pdgk2wkbhjgyO4EUMwLH/8UxEGqbmzrW+/k?=
 =?us-ascii?Q?C/xT6PSLYW0hyuluh1usOFc+WuQdDDChKCzG8n5k9UYna4/irVs7dsR3Jh51?=
 =?us-ascii?Q?h4VOR40YnuNXFq5dG94zkbqbJw+lk3T34b7IgAP+qy/l0rsAPdL473MhrqFD?=
 =?us-ascii?Q?7aPPOGoY1P9W4ZcUNRngwzR4DavlWsTnaOUNNvilpHWxOeqTrkaPCTaTqn3i?=
 =?us-ascii?Q?KPoSW5Jyq8Clb8Wxs1ChIb/XqWg/p8cWPbs6toKj8gmH6xTcyBV0Y5OBkpcL?=
 =?us-ascii?Q?GJ8R9DQZdVXlcejKf9knPyeQ0FOrPDBtpNCMZEqjuROkjaUXgsjPQu1RsJ+h?=
 =?us-ascii?Q?cKs0yetNSHB+EFKVg+HP68ERmfS5pOrmViyKSFVgcHbgh/zvxt7DoWR8q/6J?=
 =?us-ascii?Q?IWrr7obPlag9XZYsdftTbdSfGPGm/VU85dAtPHQ8F0FDF6Spc+n9SX5zWk8G?=
 =?us-ascii?Q?huHM2QRAdIbGTP6Bc6Lk7F8eiFcGwaJpB0UrGU+xhzFJBaDwHNHWedE+rtH2?=
 =?us-ascii?Q?gMbmojzmDevkmhItPCBkpSCnSfoTangtwMR8YOfN0S7c/9QXuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eu45X5MPweeo5cWD1xdbJ81k7boaHY7W0mkbVZ3NLxzBSItxJhQf4GWf4C5S?=
 =?us-ascii?Q?gL3o1GyU6nDzF8pbCvIh9eZdGv/zGUjaUeV2fMbzn3SRNN3NOWxA+3H/az5S?=
 =?us-ascii?Q?JZKbxvgG4WDgFLsQED83AZf2HNQCDZF4CyusIKiIG5hzkeFCwCQ+b+DewpoG?=
 =?us-ascii?Q?25SE2fYxXM8Rw+9YzPs5Dl5nO4qDSoYTtR0Bfouw0Npsog0/6bbK6W1zvYcL?=
 =?us-ascii?Q?jkaieaBXCwLH3eDtBS/DAaNf4fedEzVnI/G1zLPg7v7/FN/hJmB/l1mQB3my?=
 =?us-ascii?Q?u4jlR8czX/roZLjbu5OBxRDP2blhP1iS0LD1HYS+j2UlHF9WEzfluarOk3Tu?=
 =?us-ascii?Q?S6jsU1ORJ/Uv6Lk5HIWy21+PolhN0Eu5oyEBqWKMoFDGGbTSoKXKCQ6VAld9?=
 =?us-ascii?Q?yqhUiFkzBHGUNF06ojbqnwJSPItX42em2XUULHDLN7D++4VnOAWQuMs9LRsO?=
 =?us-ascii?Q?J2aIelx5NRcY6+AeuKefUOL8tq7nt2YoSar0thMNfWwYQ3RsMxXftmCGfL0c?=
 =?us-ascii?Q?HOKX9g4ii/hL3EQSCB7ye54gE60qGOKAG87ToVEHvAwkP90Z7h+3SFySBBye?=
 =?us-ascii?Q?WIND/TX80ekXtTRpNnc6cZxKBSogOCBkc9oSbDf2nec2RrovByTudGKjk3OK?=
 =?us-ascii?Q?QxYTkB6sZWdjf+MJK7Ey1fP9yAKNxhdSWXUe/ITQ0mCkxs9HMFcpevXlrAQC?=
 =?us-ascii?Q?z3mz90YKCAf5+DluMlSpFnRgtiOuJDI9qPA7Z2amq8VdMnYtw/zvybjiSwiy?=
 =?us-ascii?Q?/yREYYxqDyGVM3WluoPD1geekixN9VeZAE93Nz9L1H4ieUd9UPUsRi+8CyqP?=
 =?us-ascii?Q?qXAHrPnsNlrCiAFg3eiRFNoGifa6rgDmF+d9+dibuT7Oerq6kDVWd60Q4e0G?=
 =?us-ascii?Q?CS2RUeFEMpf9bZ7fulhCYc3pegyN1oCzuVAWiv7hH5HGOmTU1eIxBxL8UHUk?=
 =?us-ascii?Q?s6QLXrL4dXBSo8Dox693Ax6bbjx5fAJGH5GZ2wn21ggI/OhRjtMB2WqiDb/P?=
 =?us-ascii?Q?7kRKe3JL3zCHx3uGl5f6rvZ0w7SbdEB8L1vMSMcaR1vKnPRWw2b85j2VcTFa?=
 =?us-ascii?Q?2NK6VvZYbe7aqPismRhL8vDPsKjTfT/iXV4kY1jFSbT/MO+2hBOcwlLBM4Au?=
 =?us-ascii?Q?I33nVpk8QgSHlMMwVGV35uLsIfZqRd283nAhqBPX5Cjk5T/z9dEOJ8FCzyTO?=
 =?us-ascii?Q?eIDePhXGyT8jOT6WPzUCRHA3fN+gT9356ycT2D1w3F3+NPrKUoc/f3lVtudC?=
 =?us-ascii?Q?JSlask3rkA6Ag6ubGPWJT8XRhK2WcUNPKTwSCrs5hH2tvxpUmreXeVk1dsak?=
 =?us-ascii?Q?6SkQOEuhynx1D81XYChLLRIY2+fQDk5n5Z3H2QrD5YWW/H4A3ru2nOac42XF?=
 =?us-ascii?Q?UwnDWecJMbFaXGPOKXLmEn2lAjlPTTWBgDZtlPoNrzpLv/iyTt/Fmu7N0bg+?=
 =?us-ascii?Q?Jd15izyxfs0DROZPOvnUw43A98SRe2ji1Nq8JlRJIBddzGfEtUaPXPe8vWvT?=
 =?us-ascii?Q?Eha6hmmNPWH1XmcBqtf3McMzfSW4XEWgcyjz1+kB2iv5W4xJKIuGXggY//Sl?=
 =?us-ascii?Q?PM5sfbl3/0k3eqQ1mLbqL+DtanPiqVcLS6+3sL40lxxLIfwr0xIwylI6sX0t?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 982fd2b8-f309-43ec-1b0d-08ddebd5f312
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:10:29.6321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2xR+pdmLHZNKJpw4Wt3ZxXuy8PgIgslfIYZmzRzANgtWE72hTfl7+JD3r88NGq0BUGkKGtL2gomn+elVlwWZRDLb3pW7HDl91TrkGWu8J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
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

On Thu, Sep 04, 2025 at 10:44:40AM +0000, Ciara Loftus wrote:
> For the vlan insert offload a different tx vector offload path is
> required depending on where the tag must be placed in the descriptor
> which can vary from one VF to another. Some VFs use the L2TAG2 field
> which requires the use of a context descriptor. Adjust the logic for
> selecting the tx path so that the correct path is used for each vlan tag
> location. Before this fix, if the tag was to be put in the L2TAG1 field,
> the scalar path was always used which was incorrect, because the AVX-512
> vector path also supports this offload.
> 
> Fixes: abca31f780e1 ("net/iavf: support VLAN insertion for the AVX-512 path")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 23 +++++++++++--------
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Will squash into commit on next-net-intel
