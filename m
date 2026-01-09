Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F1D26D6F
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 16:40:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 751A04028E;
	Fri,  9 Jan 2026 17:40:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B9EFA400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 17:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767976812; x=1799512812;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=AmenYXiSa5CoKUy3sO3Nhkn9Crzl4KZgNuYdb2YuJZY=;
 b=IeorCZQMZqhoUi/9PKxACVd82M6cfl8GraUWRYrVm6chk73S0ENTF5Ne
 yfnVDo6Qf9lrNpjEzOPStz+4O16BXPkH1xPQXYvDemPnaIOsALFoo85Wd
 XDKuJQyCthP9XJZ/3MGWMO3csujlxy0GZlVlkB/1n5MTeAzmWe9ooATc8
 wegnRqeqrASHZr8LlvytFSa3i1N1caOK02GRzHqOy7ENvTk2ShAsLHS1q
 vGQ/k1MDI2ai7MMbUmrRxBS0KR5/UEA05epcQyP+0yiISsgtBDQPVOu4Q
 +tKIwoBCx4rEgcYGbSVavW+jM+c0a+deqMbTFza4btEZxn22qZfffbfIF w==;
X-CSE-ConnectionGUID: GZQWmDidQ0ipq9WYWE6f+A==
X-CSE-MsgGUID: yOeLT+aWTvawB2j59lJHnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="86777434"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="86777434"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 08:40:10 -0800
X-CSE-ConnectionGUID: Cnffqrg5QYeOE2ES0j1cFQ==
X-CSE-MsgGUID: LalTVhXHTDScRAbUNxExFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="203795367"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 08:40:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 08:40:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 08:40:08 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 08:40:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T04YSc3bzSzoi6VLu05/dTJHrdRYzFQBR4ZFwKES6qxLddMHC96/6k50nyQ7B7ZUa8ob+ypBc1+LOAFVkx96Jfvb3kLvuqg/hbynvHGSRrh0/uKrvhkA2djgjM1qVTrVsiwLF5NsosUxm6UCvmwHYDZOovNNr6GlQL4Qz5LBZqgV681r/KsD0cF/mjj5fZaYFWqSGc9UpqI+izSzsjvtTdygqI4HkEzLOFrpVbPSBqJzyYMpbtTYRXc1uddvPXy/Pe6M1zFkrFGAZnObT5BuXtLKc23YUSizOKWPkYZUNPZxKR7+ulog41QvNJXWQDDueyl1FoPWepUQlDccC6GaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11XR4Wk0Hd17CHnfpuONi1BZlgH5QtsIXtPds1uKWso=;
 b=FTrx6MuZQDe9Vx/Ur1M37YPtrsHOQ/AGcsSbA6Rjg984IplrxF1ZxmCZa+2r/6QWKPWZHQibllPL/t18lRtTAgOkZV+5OmxbpqpG8o/P+HCtTBdW6kSsrRMYtASpqa3XC5rM7Zc0IHg7quLlqhUkTg1cdS1+KnWpXs8R+kDAnuTPExm9rf0zPcmFP+dlUZDoUcdzYqyDlblaQ6FpRrjLcPN+GmY6uINc/Hiw/h2ZxSRc5nk7p/0srDKKq0XE+OhL4FIg9N6bI82DnNnSwSCt1WBoDc/kx38jPdFfLD4Xt6PQSQaXb/OFK+DYNECEdeblXapW4ioRnWU1gp3ypbnYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9442.namprd11.prod.outlook.com (2603:10b6:208:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 16:40:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 16:40:06 +0000
Date: Fri, 9 Jan 2026 16:39:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: improve Rx descriptor ring size checks
Message-ID: <aWEvX0ynFXoNYGeu@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <20251215184342.1722960-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215184342.1722960-1-bruce.richardson@intel.com>
X-ClientProxiedBy: VI1PR08CA0209.eurprd08.prod.outlook.com
 (2603:10a6:802:15::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e37d2033-50b2-4ad9-be7f-08de4f9dbefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xZQt6FCCIwwU17iou75aGrZpUG0LK1Zc0DEin6QTTehnmYYkuJ3gfOAi/EV5?=
 =?us-ascii?Q?RRfO2/HpyoNaJ7Hh3NlHCWpzhA1uITA5NFyhDKArGWHI2zz6XouJ7G8OQsCG?=
 =?us-ascii?Q?DzrajpYVziUS1ceIU3vLavY3g0BROraEsXrcF9QJ0D9K4tVd1Vp2N7yYaALr?=
 =?us-ascii?Q?zVLuYlb+OpOKA8HnVkmckyIxOJlSw8Q3r7cL736CdVSASvnw9fPtUCkwCKSB?=
 =?us-ascii?Q?czuvwKVdyzNdlA1ybGj2/KSxkwxDihxd/oSzP/0AOFKMemHAt3WVrq5ueMCz?=
 =?us-ascii?Q?I6zxiHPpVPa+RAQAdT01LKriTGV7Sw8plYg+qlQQwJ029vSGnx+h76s+xkew?=
 =?us-ascii?Q?EmP/UO1VobsOJmdGI2ZJ59msBNCeQF/HP1/+Kmh062McXLKw+C3Os+rb5E1O?=
 =?us-ascii?Q?eExmTMYsFPug4Nhe/T3jn0qos1uOH8eSMzYxm4mUX0HxY0SLsv5gRkBbRbK9?=
 =?us-ascii?Q?Scl5WTCvC8ZLyDNcrQlgBoCUNBT//0jyuJB1MNxYZj2ACmSxp6pu4jOaDDzT?=
 =?us-ascii?Q?zO4dcu9kPSoDjuzNOcsUn3nz9GrsaxlW3s6hDgKsk9K1YJlXr/ZQKqyfH8n2?=
 =?us-ascii?Q?chDj+g3640c8pkuvtBtsMftjN3a4l8llt47s35ngEWzIYWiH0FQEE6mJ4qLx?=
 =?us-ascii?Q?rj7PVJi6Ds86u4sJDLo8eUgJ/N+stuOcSFZrwar8AhkLaUhUrtX6QvQWhZiN?=
 =?us-ascii?Q?QcenFvQZHF4K0lNhwhrK5nK9Ee92kSVFpli2VIXbWu/wB4D6KwGDkXsurCI1?=
 =?us-ascii?Q?rr16JJmeRJcUS6uobNdTzc8TPC0jUEgnwPpCdBIlOwyvOLfWR43vcrwJTE3k?=
 =?us-ascii?Q?0C9NQf3aFytiBSKWIBWMWTSOUmL8ne6pMWhA+O1YU1860T/1EJPvwnloHkMD?=
 =?us-ascii?Q?VCK4hceZ2UoHnOY76T28tNWbfZMpNyAqK+E7tNFl8BXac0MJFm0iee7Go9gn?=
 =?us-ascii?Q?QRreULcPU5ZVC1HKHeprr+GLY7z8HzzRSgwEKq83upU6i8t/UmTgfUMT4ayB?=
 =?us-ascii?Q?VDIAORHNMSKZshIMEmaUZz1sXpNonJYxTxjyNI7STOTh6vjSTRJ6uumRLHiG?=
 =?us-ascii?Q?M7wDwCCXYVmc+wj34EliK4god82gZBM4Q9LE8P6lwS/W10/t/31cJgZo8hsR?=
 =?us-ascii?Q?rgqJjKROtT29YVBn0jCSj2aadHxFmh3VdPXkVTKWj5/QKncatDLyAoLsY9HG?=
 =?us-ascii?Q?vY6iD9EjlB9cmH1M+TYD0Aqq7W3WJzIlhIRi0Ovk/gGSGCfWV2gT138jshzx?=
 =?us-ascii?Q?5hWdtcG+zbilbzW0Xy8XHEPm5dUis4ptbrIWfr02Rl4JbT7EKFRngnkFSWiq?=
 =?us-ascii?Q?RQEWW4DxBCX1uMfjryRRUg0LWQCRdCCF4TGriQFVvBGR2c/spn0SKv9ppoHY?=
 =?us-ascii?Q?7v4mqnoM1qn/oYwdmUWsAZVb1dHMMMMnnZmEBNfdWS00Ve9GjDym2ew7djYV?=
 =?us-ascii?Q?uuoileweAUiZnzifs0Zqu2bArqihTk3A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8D+dA0r2dtMVTG3wbMHmB21rmOHGMz7iYBA4sgGyaaaPIH/6kriUULEE6EG?=
 =?us-ascii?Q?peSv54CYbPSeCEVOIvR2rsGnKG2AvQ1Naom4SiGqwq3jLOk1kk/jcMFZC9sY?=
 =?us-ascii?Q?1vs9WJpMMxcem027AM94T3U+OnQWPfS9CJvpfItDN9FwD9/z83eQs2HYvIbn?=
 =?us-ascii?Q?bjYORw7fpc7bQB1hkyaPtYOnIzicAEJINPBHIPPchBkpyS4w9nX2bzQH8+Au?=
 =?us-ascii?Q?o+THk83yG3oa00uLr/FABn4GJ6Vl9noqS+dBhSuzQoyaOYQQhahEGqwM14o5?=
 =?us-ascii?Q?RBfzSrojFwlh2o69dx7Ac+xN98NaImDBezC08eQDM8YbEvtUgQ+MR+hqMFXu?=
 =?us-ascii?Q?3OFEG4ZuSXOAMMZFfEY0k6+Oa5tNa50jVyLPy11RSyyAIu+NE0VpJyeqalIm?=
 =?us-ascii?Q?DXObZSJBhH+DGUi7SlBF829W8dmYdX/AW+Kdk5Hkw4hze3Eb7wYP1KEI5X2m?=
 =?us-ascii?Q?KhnKctVKqlPMeM9A1+bokaYceLxek9YSCXpC57ANJuu/8p0jQ9myTd/Gs12M?=
 =?us-ascii?Q?qigfUGSy5DLVQrw3/sW/It+3a28We9G+Yhnayt+ijtq3caUNTkwJEx40Yd+I?=
 =?us-ascii?Q?KDw71y8IiF9KzQZdsvcPZ3tAmwNvIRY1tnM9MPLyTO4KcJHX7dUKhyLKZDz+?=
 =?us-ascii?Q?aYodEmXBdnV6LW12+ESGFNKJi96lpqhVbcVNonT0W/BWuWY0F6W1THdVMQv9?=
 =?us-ascii?Q?vv70218WvgYGYySDJ+aNepIWyvqGA+qxROfmzcTTh1qxl/tP01DKLVkLvfSf?=
 =?us-ascii?Q?oc9zewPfQW2DS+MMz1xA7B6PvEk/ed0NxSa5P+2kt9unu4Fyct5QKWlog/Oi?=
 =?us-ascii?Q?lCoIU+nggUGFGADE31AkJ3EUDqDJPDLYdkKNNioQ9oylwa0JmuqQp9ukz65c?=
 =?us-ascii?Q?uQQ7k4EwXhEVUNuOnmYh7U1HPbb+tAD/shXoJcwiw4o0lT0m0v1wIYbY5yiY?=
 =?us-ascii?Q?qzs0mDQHX+RgddrTFymdO8QTjLN7jt/Y5PZIpQ7xed9EjNtfR//0h5JpByQ3?=
 =?us-ascii?Q?+t+COQUwdMYfnDjniNe3VllBRfI8b+F5hAPo3jbXoH92/BBHm0ZWhfs+dOb+?=
 =?us-ascii?Q?zPF85m81S6hUgYwtagDEMsG8dMWeQ2P/EJb1LJMNv6bxbjWKolBWl0UYXpEh?=
 =?us-ascii?Q?4lN0wJUBIFfPPtntO7NOBV1VtKTzUUfpmgVtBhCpMm1nMmozZZwPPtV8o2f9?=
 =?us-ascii?Q?DkvvB10KMhPDvd6MHdnYR9QzM3Lq9wWZbvhXLBC/wBzzla6ahCmY08Dhv8Fv?=
 =?us-ascii?Q?PY0VK+6XZ+mc1OzvHb96gnK00+QXWQlV1H0/VwD2WSNfX8BsogLp9hvHQmi2?=
 =?us-ascii?Q?XXI5PAzJVQ/UCOwOQW2O0uPAqoy5RxYx+6QRjt3DI338iT7Cx77ZwU+IK/O4?=
 =?us-ascii?Q?BN1JoEnGRK5ornE655cs4A0YAink9bCcTfuZJwUN+s6Lzbkfxs2U2jAV3UBF?=
 =?us-ascii?Q?M5T1rKTYfv+pXHTHC6kR1lPlZuPCdJ0eiiVJZ55CQQNaRRjNJwofu/3oTR3r?=
 =?us-ascii?Q?+3q7JZgvNR3DgcWr2lynIX9rP/o89qIie8yP9piNySyIAYpIGJ+QiUB5FStm?=
 =?us-ascii?Q?UCdwhEst6b/GbAo2nBeaIVQq/tQ4dyFTySUpI9FV0/o/MFm/8n2oHJC+xir5?=
 =?us-ascii?Q?Yh3xp0Po9ClreVOX56QODJb/Rrf+GOe0RipjU8a6ygsABbO0N7+nWkKBo232?=
 =?us-ascii?Q?zSOeIDB6b+GaZVJh9ocbXpEiWVtBqsZgyBj9TsOYZ+LjeJYEpPXGfoTPxy3M?=
 =?us-ascii?Q?JUKpn3W+cxCKQ7IjUPezbObXGi2VYe0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37d2033-50b2-4ad9-be7f-08de4f9dbefc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 16:40:06.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPlIrw+yIokT4QZubHVqPkCvqPgL7plRzyzLH1SF9LDfA53vT9kj7PuL0gQiSTSSXGzUp/Ud6tBC5NrRDX285CF8CXmow41qgDO7Fm/SbkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9442
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

On Mon, Dec 15, 2025 at 06:43:42PM +0000, Bruce Richardson wrote:
> The default Rx ring size checks did not account for the fact that the
> port would not work correctly if the Rx ring size was only twice the
> free threshold size or less, so add in a new check for this. This would
> generally only apply in cases where very small rings sizes are being
> used, for example, with default Rx free thresh of 32, only ring size of
> 64 would cause issues.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Recheck-request: rebase=next-net-intel, iol-compile-arm64-testing

