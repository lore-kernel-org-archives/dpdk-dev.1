Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F549C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 18:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 368E54114B;
	Thu, 13 Mar 2025 19:07:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E6BB141141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 19:06:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741889220; x=1773425220;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=t39A4FZrSelj40njiWoghL9f79sIbZVW/CTBznIRZW8=;
 b=K0bUa9FFJ82qhceSrP4lPSUtsaSVBvWeRRRdO3/GazJQZ9kT2/kl65ZE
 P0YrflzxjPkkq+YW1jb6Zu2zavXouugka/hVDzOVBocrAMSykZPoXv1hc
 qPWHP6tnfDsZE3yJEQxbWTZ1ufmOD6jSdCmo2uiCGcy40xOzfz822cwco
 yDiDCtSuDAIxjVvmAwPiaWqcp+N8oP7NMM00cmdabhfRTJJ5hbiFjysW4
 +rxwyt0ydBXbQTlXAEtkMiVOKHFGtWUQoeMsMFjMUf62VBMIuNuaPADr9
 T6gqqzy55eeitDpiLG8ur+vTJsn7d9ZSOovUrh3Hxy1vNFHr29M4V1pK5 Q==;
X-CSE-ConnectionGUID: NiQblEC8RkWfHGEJRu5mCA==
X-CSE-MsgGUID: jRGFsexAQTypN5+ridZlmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60563497"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="60563497"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 11:06:59 -0700
X-CSE-ConnectionGUID: WVRIaOoqQOqm6l/C3i8Urg==
X-CSE-MsgGUID: J6sj7MeLT466kQZvW+AadQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="121238551"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 11:06:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:06:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 11:06:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 11:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH82EQhV0QU23V8opSqBknqcWcpVV4JQNxtPETUVAqJ7K94TeXdnd+wG0c/1tUBzeDQJKZilOR4cGvBvrh2wPIdFwK8+mGRxPqSHYvUgwE5Ab30mjFG/xXhNiJV14EK9IidsXJ/N2GYfxnJePtKl4DRLFyMqafEkWfd/r2Hba1fnBeeSU7dqdRYt+S2eLgMeqIweo0eIOp7a9wnBWYg5ZGRoEmonGxxcRHgsADnvUztSb8UVkIw04SvXwtghjKOQd3wPbUX4x+JHhdzr4R5alCufMpxvn6NOZQm95RSfarweHbHVvYdKLy/TrS/SyAHrTbNXq6idFet9LoOjLE5lzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gThQAvfImUj07m/6lP7WbYcBAhUHZuA5VtbAAf+Zu5M=;
 b=QPPfxkJcBD9yk0zQHJzLlfFwEWvx3S/VSNvbZfL9IJYPlnyXKiN4qJIUPNIh8uIoYCe+uX/iiEWj1jxo0et+TdINgvKueOi9z5vcEc//TkqnT91znrgzB6WnyuVbGD7EQH6dpUvn96T7lMa+jCPlG4p5nfNYjpEY3DgRLRfj29YR/Id7cq9Meu9/5VM2P0qCJvry9HTgWtoKrzCHkawUcmIWWkBDIcdu/8BB5ucgjwlJZZaqqzZNYs7PvDYjCCHZ+uJ/gWOKqodKa7/zL2o/9DYTg4Hlxt+eMqrUPvtYDNfkKUKDFjGlAdVHrQ2T4sWaOnODwxwDMaeGuAD07dbwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:06:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 18:06:56 +0000
Date: Thu, 13 Mar 2025 18:06:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: Matthew Smith <mgsmith@netgate.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: set flags while adding vsi
Message-ID: <Z9MeuwPzEo_RktGB@bricha3-mobl1.ger.corp.intel.com>
References: <20250311214031.2217808-1-mgsmith@netgate.com>
 <877bda27-4f86-4c47-8f78-f7fab1c20d34@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877bda27-4f86-4c47-8f78-f7fab1c20d34@intel.com>
X-ClientProxiedBy: DU2PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 10579bd1-14f8-4b5b-e5ed-08dd6259d73b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GpEqJXplF8SC8qlyOm4nMaNHQVU8uBRQieCdcpT8muhYsWY/Ad1gSOkF2XUh?=
 =?us-ascii?Q?NSPoeE1M67sCRKePtZfSFc8AJ/PPM+sROA5FHOK8I0fQYba0FKxDodipq4WY?=
 =?us-ascii?Q?C+1r4VTV7LGA3Mgw+N2wPhlbVqf5NpAsRH+C+T/zG4oXSKEq1E4rx5TfaQYF?=
 =?us-ascii?Q?WcO8/973+A/v7uR2aUxmFH/MIHWAsYxujKDY5MCpFJBKz+/GlsOpgnONHkSP?=
 =?us-ascii?Q?AH2yy1qgOWp2hnqhSJNGaTeeeRa0D3O0GXTAn351XU9foIiFF3stlHAcKrAw?=
 =?us-ascii?Q?e4pUi6lsF5rNMsBuDXXGlAcLY1Dpsw+ec6d70fqCN8wJdiiCXNx1R/CElU/i?=
 =?us-ascii?Q?/8C2CrqX5G8sWKff1JTZ4t+QBTu0DJvORFu5diiOJwSPhk3dKls6HvqArsdn?=
 =?us-ascii?Q?OeZ0EBSoMyY39KDrxl0rU//2oQNZ6pHgyLUOlvmXHQK9/rUbyQ0Zag7e4iwS?=
 =?us-ascii?Q?TCDOxUjYSWh2jLU+ibnQ90j488yjcmu9BbNFneFzrEyElvnU8/6MYbTNHmFp?=
 =?us-ascii?Q?8hP8dfN0olChuaD+0vzXeB3k0vJ6cI9vFjR41JeHyPdc0T3LEbGQ6k+SIL3m?=
 =?us-ascii?Q?1PdbTkS0l/K/11n1CPWgcB4dLdxgakpyVWWdoCeUWO7HB9blgGTfhJC6U8Xi?=
 =?us-ascii?Q?X9ZE22k0giRG4a5xgbrg13qXeAATQHFtQrDgm71QxrkQwQWMyuAyhXtZCrxm?=
 =?us-ascii?Q?E25oy7++w4OI3Y2gDgLbwzHyCMazq1SvbuFxhb3psSlW40oNye8MQ3VOcEnL?=
 =?us-ascii?Q?xESPS5wAOh+1zBgu4K9tt3fePUTV+Qvoct4V/qe8uQml6dGDz7gm7F90kena?=
 =?us-ascii?Q?r0t6kwlX7lmuOGtmoRORM2Oz+NXhh7z0C7JFrk1aEK6VU/Unw7sjJLxsbgwG?=
 =?us-ascii?Q?9xV3EqywR05ldskA4vQx+zdlUM+iD9VU+t0UDy3xzYAAWSXUV0zp3Dg+Tl5K?=
 =?us-ascii?Q?QE5bwh5ILtSyOnEXhBSK10spF6xdqu4glVi24KNPqK+hTfh+C2d9eBIvVnVk?=
 =?us-ascii?Q?nvrTfB8R59g9tjLxGoIy1mQ3ActsjMFlg25y1zuMvSWSi2zcE8O1ND3oF8EO?=
 =?us-ascii?Q?2sMsh/deC+A5gmsyNumFC0mKXfvcnEDMFAnuDeqDxfg0nH3UdpH2bcZmX/Eb?=
 =?us-ascii?Q?ZbvOCwCgQ49nDZuwv3EA+Ls1DkCmbgevZnajUMHGF4HdCjW7heiWWXIiIiUM?=
 =?us-ascii?Q?QDDemlkF0n9PKeOgcJ+ekT6UZsZ8JJKSYlTn4GvFYFZ6ei/Hk/idbKB2YiJT?=
 =?us-ascii?Q?SI+Mjalosfs8X1hIqi7kqORftO8pbvrsARNGUxarN/e5s0fH624gdn/byKA4?=
 =?us-ascii?Q?OC1WkBVWsTT/5r/Dr3RiWTjw3tmK+sHggzJ7AkcQ632cUCe8GXkRX/vvyUMW?=
 =?us-ascii?Q?6Yf4TXAr4+RSVQn2xkn62SLA10Ce?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qb2nMwXI+9YPbidiS6xNG7wX+mUKtJDszcBerTLiBeGGamk56gD3LZN1XsGS?=
 =?us-ascii?Q?1NpLPf6NP88cgcklkgFFAPfO5DTLXk4wlRrcVajH/wcRTS0YxcSaSSYEVE9s?=
 =?us-ascii?Q?Wak+MPeSRNKJsxE0PEMPdoa9zeqXzUhecEiFJgiGUZy+CLSTU85ReZ8apApZ?=
 =?us-ascii?Q?nTQ+ARrZkjG6AGrml7PlDrFWE+lmGab1jh2f9XF6afdxckd9RLQ+BfqtKvMB?=
 =?us-ascii?Q?YpNYm0Qs/FRrC762ABXrAE3wxtDOeyk9J6/jaYXvVwlG+6RM9cnXP+aahZM0?=
 =?us-ascii?Q?sGm7F0+O+II9YLLqEwuf5uRijzkvPbyDSEYTiUBunb0CnfYd7KxPWv79TaNS?=
 =?us-ascii?Q?OzR0RnWs1cSxl/gPGgnS4z1JvSvLu3N/8dDguIU+E/cpH/ndd13soJStsufq?=
 =?us-ascii?Q?CBrAvKziopyTE4SmacP9QJmhoDOcYuu7AAIkQ+v3+qPtkPpsOtD9i0YJ0xvV?=
 =?us-ascii?Q?rhZf3e5xGt7yckSsGqX0R+sUM7oiDD2UiwwVmnOfBBlyfDlx2GCmk472P+ec?=
 =?us-ascii?Q?ANjVQT2FmdI3LlMKMxstYYzPZUpWoJVe903x5Owmnh1qV2paJ8drlH7tyROO?=
 =?us-ascii?Q?ScINWvmFnPmSX+HJs/+Z4ziXDQTwr0UAbhZB/SWg0AtZtjs5az7QIPzBklqA?=
 =?us-ascii?Q?SahsmwaoW2uOqM3ob4TnPBaVg2SslllysxUb4DmKBwn4F7AlFxFteQDZpKXU?=
 =?us-ascii?Q?vYu4tp8wymPuM/5F5h4lruV25/N4CtoSAYulM+ij4bb19sswj4mNTO3m55ud?=
 =?us-ascii?Q?kEyZUCR7DZVgTFIctwrFSFASgnlHJvJY7iU9UYCRYZhPx2i/93wHuUJ1gvUU?=
 =?us-ascii?Q?Mg9EYNsjvmp9DroRPMz5t/KzyGa3f0aTFRz1fXlzht+9krzT3DYQx4f6Gb6O?=
 =?us-ascii?Q?s8BNXw6Bx6CXEKC/YXqIC8Q7vL45qD/GQ8SoNfiaBf2yzjawxwyd48WpU1Tb?=
 =?us-ascii?Q?aVx0oPLJ9h1PP/VlSTmKDEvcI60oUoWnDSvB8/AXDwCP6lY+QR1lQY7pF2pZ?=
 =?us-ascii?Q?w9UExj+YRSN5M89rcrogoiBMQCiYopegs36i0qff6YuPAO+FcilM5+s4Hq8h?=
 =?us-ascii?Q?OQlDe3PDNXNnLW03rPnsOJ8XGDg6VV82aFm9Y8HMDwaQ7Bv2U4DW7qR29xlW?=
 =?us-ascii?Q?HKjJc1sbXnjrroW5Omn4Pqb8WkaIKf+BB4B0Hng+KqyDPOEutJuf1hyx0Gvw?=
 =?us-ascii?Q?cshrxshvfuoGL/HigN5y8/+Ftkn8XzcZ5QNWTlyB4EM+UNmmPyrNQhiC0mBu?=
 =?us-ascii?Q?PvuqDMM7BSqROpdHmVYnvhMBFnDQSPyIBf+qqQAjQmCBa+WUelX73YgwJJg1?=
 =?us-ascii?Q?loM/wkBtUbUxBeWsGuIJqhU3AaW+MWC1nl0mODxn+kKF9Wv9nDWMLsRjFQsw?=
 =?us-ascii?Q?YT3wWe8M5LHjfab4DjzAcic61APXyU3Yv4IS2NgbyTSZinNKEuHZRhy7pQJJ?=
 =?us-ascii?Q?GpuIhWgr27QgjbFZz1WrqCcDRCLxlpkvlOhLB7MTcaJ8DSVW4EEEzyVqDLiL?=
 =?us-ascii?Q?PQzVSdjRIkP08nKIRc1NO217oVy8nHmszgyPaOquKhqoSOyIHEBv88/HmeuW?=
 =?us-ascii?Q?sUpLahRzeSB4UNzRqPW84lyvrAM6TYA7eA9IEROlsWHjw4bUJbICFfMsE43s?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10579bd1-14f8-4b5b-e5ed-08dd6259d73b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:06:56.0606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+aGGxxlDndDwGUxHPLsCche93EVxo3Q0SQWiQhJQK5oXR8X6vZ5OuRDQE3PPets719Jo7warm3fayDIcwtppAHx69sC7+SQ0D7rm5CoRDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
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

On Thu, Mar 13, 2025 at 05:50:56PM +0000, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 11/03/2025 21:40, Matthew Smith wrote:
> > While adding a vsi for an ice PF, set the ICE_AQ_VSI_SW_FLAG_LOCAL_LB
> > flag. This will prevent packets from being dropped when using a virtual
> > MAC address with VRRP.
> > 
> > Also set the ICE_AQ_VSI_SW_FLAG_SRC_PRUNE flag to prevent transmitted
> > packets from being looped back in some circumstances.
> > 
> > Fixes: f9cf4f864150 ("net/ice: support device initialization")
> > 
> > Signed-off-by: Matthew Smith <mgsmith@netgate.com>
> > ---
> >   drivers/net/intel/ice/ice_ethdev.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 

Applied to dpdk-next-net-intel with title "net/ice: fix dropped packets
when using VRRP" and put stable@dpdk.org on CC, since it's a bug fix.

Thanks,
/Bruce
