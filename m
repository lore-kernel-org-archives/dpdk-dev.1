Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254DC982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 15:30:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E6E64279C;
	Fri, 18 Sep 2026 17:30:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3E7C240285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 17:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789745423; x=1821281423;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=px21ACgLdBrnAbYFL8T/u0yNfjh9qbYSa9DK4yhglcw=;
 b=VsAW17RrkwOq/4qm8wFIDP/yNjKAihETjbkMvRPmKZT8paGSjIqc84VC
 Kw2xe5Yu5tX+0QmWuyCFqr/tqgORqCZmiEbotBi7Icz25eFcj5PIVgKzM
 GGPkdSBdT7JPLRyHC01tA+1nS8E8g9Em2MLytgnP666TXGdAVQN8tZr5C
 OEL1ineS5o1T9Jm9urxUhfyqlnMdukFJC/dS7t085/B1c9u32ErlI07fz
 kIYT6tp8yMW+RDQW/18Iv8msdifda+yVXwQmrNSte9WqSUvqvVdByN0Sf
 GZ+LiwIH8Qa/q8eCK7lcwqKri2W6ThPfmU+CxcTm9z/anSXIoliDdpMt+ w==;
X-CSE-ConnectionGUID: vontcUBvSJSULOy3UmiWFg==
X-CSE-MsgGUID: DhNV+J6ERrygvOcI6wE4Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90126870"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="90126870"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:30:22 -0700
X-CSE-ConnectionGUID: LklzINIcTHi3cCqP98EVeQ==
X-CSE-MsgGUID: PYzzWOQ4T1m46dZu7GDHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2897143"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 08:30:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:30:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:30:21 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqi53lWBNU+pk2MNcrXwJCW/O/mpLOcl5Q8bQGdn1oBlKOiVpZ1iI0QvXogEM7yFULNVehO7wyAGeBq9tL8Nh1CSWD0vFrRgGl6yHzgzdUPO5izfCRVFaiq2WcH2hMeNlDmgD6w+hdoIELdZhwSbGlZh4pCXLlvyc901av0p6cDOvAMIdqS39Rw9B3K4VZAM7FI0WQgI0nPwMoRET4F6fT9cxIuu/I4KIGFdFtkQkmyMAa1Wvkbrk6ZTlak+ryyezNzBvrp6J6RfK0RCY1/dO+l4SKtR32ZB5mOMytzR12Kc+wx3527aI1Edl/BQWtpOJ+62xNT7sx3GIIKDbZC6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj4G5q8xvkvjeBTeRtCC6yyZaTzhqJUE1vObBM/Y+CE=;
 b=fyM54X3XUdavJLJ1dE83jYQmSQI5GK/L5bn46ouNd5wSzLJrPHA9i7ZD5JkGXvSE5qwQCF6Km6xe7waJFrPSrCIoRcyF55YPEWh2qitmZ3UorPV4mXeDLeAnx0IrGosKJPAJxPBFnqvlBHz5gokPeOTLZu8swEjASuRtIB1Ethv/TqHWA2QAPr8xsXxXLsIBi/6In+F4LD6iwIHQc2iPpwhVO4TMpiEyA99W0zuWqfZjBL4F1SEYg4wxGF8iaNOtZEas4N8fkUZtrFZyBfWCbVjZj0z5la1Jw3SnQ0o0UUwdO2ffG6WzytBSCVTyZy5csYrh/pbLgdjvxEl4GBoyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 15:30:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:30:14 +0000
Date: Fri, 18 Sep 2026 16:30:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 6/9] test/vdev: find device with public API
Message-ID: <aq1ZAtiCDD9S8GuE@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-7-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: e8241f98-ea70-49eb-0f91-08df1599bc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: xqhyA5Ym+0hJ0NZVZztejICJrmHb4nwI8jXwzkfDm3SIsgPtfG9Nrv0THYZWa7Ey2ihsjDrddRDZMZx+6e6UwxcMylrVK/LX7T/OXisRYC5C54eiqITn37pqVi5qNTWJzBOisepQpwhC4iWncznGUAiVJezcxIKwVGctKvXImA+dAiS0J7i/uYIIN3fKov+F+CTOu69vl5XnrPajeHMTNPzpoenOUIIMqD5lFJ8+Dcsk2W/ClGksNFruBCzpnIyPe46lJui/415rMTS2v7kGzdf8X5fpgYs0D9mtPVydV/TzTX03LGOM1SQttGLW6pAMJ/P1PUFUPMyJLlN451p6KhfWkBkLti+L0X8QK8onMzrwr87X+h//bOWdM1kWI5BpMY8i3rf5m0mTLhHXj+R3yXS0CR58zAj6LqtCpggWcWC+mOHHGH2I7eupGJFQRpSwYtZaMr7M02ezwZpOq8R3pwYsfN3YzL/2hU+YZJi17Kl8wmn2WTsdNpeetUJgBldzI3mB00r8Fp0A0orZIW/QOgdF6eSVXKoJBgJUcfCSP8V4nGU2wcqjYtxpswHq/nPP8Vwf2PqiszKP+rMBV7qJXSetLYzAfMDNafGaapdq51PT3Q0YRP4X+fwbf6H5HLl/F4y0OEH8t2C99u7oiFGk16fcvBu029Mxpekd8wOGIcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dB3uCw0uP+IMSvEm9YhDLRicVNQLHC3XN1oGnKU/v9hNVrg0Xk2D0bC47V3E?=
 =?us-ascii?Q?16TKlxrv5Qt2plRqblMKO4x+KPkxQJ22MjPZ4WCBYT2jDyZYa4qvoUlL/vL7?=
 =?us-ascii?Q?ZoTBlIwli2Bn7Cf/92qy/YoWZHD8KN/hnKsr0zzfjr1yKdTx/Lcq+HKgZU0t?=
 =?us-ascii?Q?hcjKv5KJ3F39v6G3RkTnV0JFGbR9BOSo5jPZxae91r+g9RCPUEcKA7iB+LO1?=
 =?us-ascii?Q?O08tCAiTVhcYlZA9q19JgA2zkKUqZgVP9gloL4t2lvqTHAxJKmzwiLW7iiPL?=
 =?us-ascii?Q?h66dIPFSqknc1r4+4xR5BT1ttCKhkobZ9mG2ycjZBeuwdlZYip577BMpZWfB?=
 =?us-ascii?Q?hQLof+KdIIeJeoiqE8OrdSTYaFN02D8LtdjH/J3hoKi7gvkoa0c78XH7gd9d?=
 =?us-ascii?Q?noOXt9LO9/axfWFfqC+tFMgUxbxem8GTE6zy9C4NtML6lJBP2N/Kg2+BrtES?=
 =?us-ascii?Q?8uPgL9f8C19Dm8CoIjHzWksmxUuZJa/nOkvF00kFrBZJ/8vf6Y+FUqZNz9IU?=
 =?us-ascii?Q?wg/if935nIS1Hhy+q7r1gPvMSB1gNw1jqP+Ovcsp/5aH/g7fmmz0SOeC7ug0?=
 =?us-ascii?Q?t3l85kgPmcgeeEkgXCUItgvHSXNTpUWnNmSMo+ZLjh3dELlDA2QFYH/At7le?=
 =?us-ascii?Q?HVPx1rlZ10LgjUq3LdaGSO1I7bXZMnoDKQ5i9fuAGGN97dcb/6xqtBLFvmG4?=
 =?us-ascii?Q?3iDDRoTnijR8uYyjwzQeXa6TG3mafs6QmVizdqE/o2vcAyLmXifPyUmSUVO5?=
 =?us-ascii?Q?TLiuvzhL2XI2MLXNjqVoSD3jv4dzLruWuHS5sHKZSe/3r0KdimE4y6PxMinC?=
 =?us-ascii?Q?/Wvj0ZdF3bw3cgfxE7D0RPrC9fSjn5FpluKjgutCa5S093G1G6f+wKVRJTuZ?=
 =?us-ascii?Q?X8AUtAJTlIpEwHFwCbn/Ba7A8c8SxjjO+q22BvGS1A672MnAt44tI4roit4Q?=
 =?us-ascii?Q?ubfI3NGw8iM64BSafaTsluhuKhEvijlCba9JLHLje5mRsr5BSkXDYoiqm/k7?=
 =?us-ascii?Q?5YiYTPtTD3bR55oaVsLZyYsVKCV4wXaISNuX2RgcCL6kUM+P2gLZOKJcDLs/?=
 =?us-ascii?Q?cE4kqxWpS+QfPZXXWcYwl1jNTQi5rnSksnHuECOOaPlM99KP7kaG5TMTTMxU?=
 =?us-ascii?Q?44e4gj/l4HsaC7dWUJ/0Y9OS/zwUhOapzAmvQbDnfmbS6sQDf0WPDwrTW5L2?=
 =?us-ascii?Q?ambYpIS+HvSTAhW6BabG3Squcnhq6MaOjCEnkllwbxBNMROnz179+WH896g4?=
 =?us-ascii?Q?NrxihMeyZT0hSVe3DcwTLC9+DSGEiMZUZK1BCS5wAhhfCvlayyF2R9BWS7Re?=
 =?us-ascii?Q?mNtXV4nyshut7/Xlx8U/36AON1HFDjAPMSnZv4+oOl7+k5+jl5B6mwncstjh?=
 =?us-ascii?Q?L8Hvf76aZRXVZ1E4tdfNbZOv3+qzGUCZri7Hm+2pKrSukzRQAu0odfNW8ALl?=
 =?us-ascii?Q?Q2MfadLlR1dHzRqPFBidjSKesryOSgBIZo4s2B3Cybn2a22sfR44OdPr8XR0?=
 =?us-ascii?Q?sLknuhFUPLWm3+lQhrBn4mpAL48ZdvZdL4gqFnLR7AXAMRp/EgTX0BEObgx7?=
 =?us-ascii?Q?lKJJBgxyNky0F0D4y1IHLbduhp1oJ9VMS6KggmU9VFaSHSrHocuZHwB2zNxC?=
 =?us-ascii?Q?1k+NrbRcvvzhsq7L1jav1MllCRi02e9sYq8PT/lBLXjQ6hB/ktRbVnHqIOGo?=
 =?us-ascii?Q?xjBymBQ5mc1vKDgtg7k3iXvT6SaX4xRS0uEzbNTaBQVGV5ZS/jlyQjJIHZQ2?=
 =?us-ascii?Q?Ob53zrH5Z09Qk4FmF9tgGiAFqVJUp+g=3D?=
X-Exchange-RoutingPolicyChecked: 2q4LRMbOrGWsbodPXXvwtK+ht9L+3oHtRNYuyb2XNQuV85eIxDj6oUwdNgLx+VTc0GtrJ7UfTkX6SAUmcn0gFyUF0EaMqHAB3/NIqHLoI7UzXvO7T7kxXMiSrDNRsdwJUJHi30iA2/Ve8wYV8WMNzK5bDzyGL2gRTjpDB5K6eV/N8tz/+IV6p37H6DnmRGcU3yloNU+EqnrqSs4EQRcsRDdeHg6a6MtcotsbMxEMClkhi+dahmLCKs3SGhvfulSCLGfCiTWdiuwKCy8i0moU/qaut9tma4pNw1jTnfsVclxWbRsW6vjbIgYqgeNihWywcw37DzfoelQzhmYFsN4pDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8241f98-ea70-49eb-0f91-08df1599bc98
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:30:14.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYgLvxbAdxbjJ8HtnXUGSHf+ApPy2E4uTU+GY4HmuU8UtkPCDq53C5KCi4fWgUST4lZO7R8rZLU8URBYJ5KtGhThbhZGZhrDSpOdDHQtRqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
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

On Thu, Jul 23, 2026 at 02:55:55PM +0200, David Marchand wrote:
> Checking internal API has little sense as users are not supposed to call
> those.
> Use public API to achieve similar coverage.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_vdev.c | 85 ++++++++------------------------------------
>  1 file changed, 15 insertions(+), 70 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
