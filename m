Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF1C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:35:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36FEB4042E;
	Wed,  4 Jun 2025 11:35:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E001C4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749029711; x=1780565711;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dIxjtkWw7CrIiqDkR5xXWY9Jprblk27K12bqgDQGOK4=;
 b=nNjP3RoRCDh76DimhLjuIuH71GE0TJVFeVwFUofgVWMhxwp1WFats8Ph
 V2dNkr8OQzLAVdi0i3+eEWaw0aQ/iPaE9B+zu22L21Hxpk0T32yNuJj0g
 d3kl65Hu+cQeNGcUiii1nBSNNlg99fwuHc+SaCCj9PiMc2FQBGmBLafZP
 KnvPDjxG828cXbu/ljHGJki7hfoq6I6z7hCUUM1t+rJlFAYh34HLbXEXl
 25XS5F6Lz0H5kwe7mKPzQS1T+IrLjJVxU0p31OG1UXGxRer8fy+ApOoXh
 LJKYFxODy3IU9h5kUFqEG6LXF/2QPA+YA8dnHPMd/daDG9kWUEcKdbmPs w==;
X-CSE-ConnectionGUID: hptVl+5GQWCXHS3eJjvIHA==
X-CSE-MsgGUID: FPb79XcaTl+rNgzhKpl1lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50219087"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="50219087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:35:09 -0700
X-CSE-ConnectionGUID: Y5Q91Bt2RQe6ImjKC3ipLw==
X-CSE-MsgGUID: 7fAN2kHLRJ63VrtAekHYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="182304790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:34:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:34:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:34:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.83) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 02:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZMUcnY0Bwdj2pJBht4JBoVMsonm5qxF16Sln6VDKoUpwDHwzzcjS4bJln1rKfnt/IP8YIfsVBXLEs5M746ZSGtrX8qf5fRtdoI3uGmN0K1ZFtVTNTb/F98nFC2saaaQjaMZ5rTkCa9LymySgGVIe/ixR0UaQuUFT/YOd+tnnkiwwKhqSI45Kr9oqjWG/PFCUcriyXymomkypVa29b47OUXQVrHpz6oSufyPvV5cVFQpkaeNufwfI9O1IgUyv/uA48YU+NyyPJRlT3Q/X8wUVDYcIuF2JvWCho3k3wwi7JvcU9DNZTXZuv+m3nM0hgBoMZWAsOkmDvP7R9UYt8DSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa5lVeRjQ3ceanosFQcUe6wgK9b8XzSo7WwcgDMNcLk=;
 b=AUwRhlGV5G/eS+beGwv4IAhu+SyAkRUkXq5+hR7mOMHYsPdt4XJsez6GXnPHgNAb3KU780cfB54VSadxAV+ZSF/xEdjcv6RVL7bPpeQ5mEQlWCetVoQAwiHEikqWB8O9BFhEYD5yminBgfJElpPtzysqMev8eA4AS4NB54o355SYzOwLo/WOar35H9+NQzDnLVQragu/WGCXWgImfUfDqK7Q5jKAsSivRswf1D0jLUrwq/5VV3KcWPuanLR0hBpbdgEzQPj+gfmhMVjVPb6Ega9vjVUKHk7bxBGYaNNnf5Jw+0FMphw1N0NaktRifQz6NAhKACfGKERIkBU2YC92cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 09:34:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 09:34:48 +0000
Date: Wed, 4 Jun 2025 10:34:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 21/25] net/iavf: use common Rx rearm code
Message-ID: <aEATNNml-1o_38Ap@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <7b28ca830c7e182bad74dce56965d54deddc247e.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b28ca830c7e182bad74dce56965d54deddc247e.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 6631baf1-1a06-4a91-dafb-08dda34b0cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/RDDH466EJUbeZVRO0ho7kzoXZDVWy1uTxCkZLMCsKPHRb8gumZcjLj74h7Q?=
 =?us-ascii?Q?gxAE/rEG60DdvkOyNkcIhxqwFunvuTRny3zDhWMBh1bo3XcEe/e/lCsCgEnr?=
 =?us-ascii?Q?5MjQv52AtQ+ZzWrSnVw+9DbKshMd6XV5tjP4CkihccxUFpzYhQe3KS/0sBQL?=
 =?us-ascii?Q?hqkGBz1Vm/+0HLfvt7Ai6HpIZG9l1EfNb07OnaTuCFvM89rtwLD8RJZw29/n?=
 =?us-ascii?Q?Fea/l93fVXMVkPz7Ovmm/JX5YsjROpMjrj2OSV8CZUrzoIzjfvtRm044e1RK?=
 =?us-ascii?Q?s+LHJWrsT0lpV+sHmSx7IPfv02H0ANNdNn+bc9agq8+jul7A7/isDdPbtXjD?=
 =?us-ascii?Q?/0xcuQhc0U+eeukgZJBGL+PqMecUnRdEG3dHJEwl9sExWoKJSPeQCrsrrYlN?=
 =?us-ascii?Q?AYy+cIjG0tNTnBaEAwi7fbs54uvGCHWoXPMRU6L6QxQfTdLv+rDZS1gZSUnk?=
 =?us-ascii?Q?AMDt0KALvfYoxkSwVXh39loTCUtwTO1KXhQijZ2ZGRqqnm8hHDqnlKlU43sz?=
 =?us-ascii?Q?wlGSfQcIk6N+F+OYxjXU9YP1A4oB8SO0NmX+QoU5kvdf5q88Fen20SV0XroL?=
 =?us-ascii?Q?KZ1AccqgKLbBiItUyMIazYgUbPhvYOi7kg2U6XI0DzVnSzhj0ceaogaS28B7?=
 =?us-ascii?Q?ZbqqJaqW8NanFze9tBj3hOYEGaige+/1ieeE94NM/NXj8MYXPdxYR8TpD5AC?=
 =?us-ascii?Q?qMg4sdqxE5oz86V4rAV5b5705Nrz2Gtd/TPrdd0ENSrk4Cbg1J+1lCUVewUz?=
 =?us-ascii?Q?l11kf0xWEKE5gBJ0MOu8h6JAp0K/aJTJFM9SS1Fg37+kQQbCIol2pZnv0x92?=
 =?us-ascii?Q?UuEHQd0Vl35K+hVq667je60DEO5waLH9IcHY+aTxCW8SKPyGku8D8p3ZVTtb?=
 =?us-ascii?Q?Jd2Mp3mLn0pCC+mAA8Hc1CVaRLYJPZr6VNKStOVBAtV14/ue1l0zGmZy7RiN?=
 =?us-ascii?Q?Iu5m9CwbTsgvDiuygukTMHO/2aveZmE0Qxkd+qMOjNh6xu8uHZr8LDuH7wNR?=
 =?us-ascii?Q?v5i2lz0c/I5WuQrtTcOqIfremGrn0Pi1BqHpu4i3GJQA9UD9xVy6eXw2rsQE?=
 =?us-ascii?Q?se5KR+AuQ7vgoF2cYPmKLBBfLAzy1WtHPpEq9Xb/qCOJYbCc+usZxaGOdJn9?=
 =?us-ascii?Q?HVm0B8a+Q+ZL1dfQT+I8xYtpCBH1aon6OuT0C3T2HrIzUZFC1brue+bvIHny?=
 =?us-ascii?Q?9gKFWTnNm08VljXyoXgJjoeint1HLNVv6IQAcqCRnyv79tsCuF5v7+UVIclB?=
 =?us-ascii?Q?yiLd+RGIFDz5Wiz3ChIZfmD+4z6vO5DF0FFytHTJXEKzXNjq0oEsqFambfOl?=
 =?us-ascii?Q?7POaGFyR2vPxzH527+4Fpd5T0zViuiGB6rZvlWkNqQ6EAbkj1ZsAvuq4x76e?=
 =?us-ascii?Q?b0KtFtoqXVSy14dWiE2JsBex+mEgbEgANOqiUD5E/vIGN4sxg+xAW4q+ZlT3?=
 =?us-ascii?Q?smYWQpNiCxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZ/Ol0INrTHKgG1YptV5eWu8rcbHxvh+T/eRS/zUR9c7phupaxcxcPcLG6M7?=
 =?us-ascii?Q?UNln3T5F4NlagiCfTWpc235LYbBWFjxXPhyRNK+vUp22aVXP0qrstR68cKtX?=
 =?us-ascii?Q?W/KDWssYNVbR4fvW7OGO+hVkGBQ1ddsFzvYkwUMcf5bTC3ylfhTWlfO+sI/h?=
 =?us-ascii?Q?8NA01qlGupwplwBNZEhG5b3kqrjQ7QKxmn7nSaWoiLbQaQCavJ5MZ/2HNU6R?=
 =?us-ascii?Q?lsONN8meC89uIhB2zzxPRpV2cWY8WhEG94MXls8EyKo70/uZR2sAODkPNXuj?=
 =?us-ascii?Q?/JerlsA8IF4pZR96LL1iSbGaK7xWy0PhWNi00UFlcoUksR2AVNfCoW7PzhuT?=
 =?us-ascii?Q?AW3qSzXbCbRcsSjuLkSLZrFeTtU+ikCsCZvLWRqvIDyqLSjo1SaocUzLDDR+?=
 =?us-ascii?Q?TEwB7apbpY8JCx6RxcyRV/7y2lNfgLMizlbR9RmEKMWf/6xbwT4oahMD7m8+?=
 =?us-ascii?Q?EGWWAGh1WixJcFOL3nIPkATpQl4aOarvL13UiLgqf9RpJ+JRea+YHQ1KXM0y?=
 =?us-ascii?Q?fqd41EGOsfNVlr6+pioZh/+O9OUpOIbjwpQ8MHrLRzM8yi+vz4krQwrqH1LA?=
 =?us-ascii?Q?5rtDIfVqzqG4NepHBNBz9ARMJvqT+XboRD/SPkd5RvL6591n2Km3qEETfEhg?=
 =?us-ascii?Q?yKvoXzEtq5YrmVmfPlLgM/IEr/hCvZHtNKwOjniITPqZhHpy291qg+0cec6u?=
 =?us-ascii?Q?0k5VKdalsbp8xgKFQcxLNRl52gvrXiJVKpTVXZfByblnPRAZyO/E0pjeNuvL?=
 =?us-ascii?Q?fTTXvddG6Y3o9PSMeICVaO9sKg+NDz6fQUH8wLH+wLVpH7urJRqPD96RdlpQ?=
 =?us-ascii?Q?tw6noawIWnUPngi4LNE6j7d4X28Zru+u4imgFMxNOROA6BqpdhovnWpxwFb3?=
 =?us-ascii?Q?hoM83lEsRp2Y+dXLVZIq+jLpzFnl9uDLPIwhyeMwNLHF1b1aemuH+KGOmreR?=
 =?us-ascii?Q?pxOV09SGc0qU0292T9iRzJKFEgO+Y6nEyDqX0UQOtJ+K0/Cn8GZq4gIFFcEb?=
 =?us-ascii?Q?WaX08NxmN5cF8A8hYdr+AOHxY5cpnzsqzbiDWRwDqW4MED0hQOG5zMVP0+AT?=
 =?us-ascii?Q?5xLymroGqTZ07SVtY2Xs3hkyWGeRj20PSqCO4Ppt3zNfBZDIvQKJLc4f6QG+?=
 =?us-ascii?Q?0JMi5OVeBbcGGqN8npz9mwe26fxJ2iPM1tZthXtVDISALmstzSEc25uxtN0s?=
 =?us-ascii?Q?mv6eILMoH05uDVeV1fKClYVoX4YFRyWWxLwNVTOQsxM26LiSiufMTpgw/1BY?=
 =?us-ascii?Q?zdjlrrn0GevAj9YNAIXt2QhBA4ttfIxJNvFRPBZES4+vXq5X2oQWhvJy9AQ0?=
 =?us-ascii?Q?Cb01VK0eJbXgVEKRuW1GaDSaTGaMoc8rfBQhaY7nVC7+3a7QT39ArfrwWi+q?=
 =?us-ascii?Q?NbKdDM6VxqxyCUd1iZ2TrswKoNUtU1JYgv6vNX+mtKNwnSV4k/2eqtkJPx5i?=
 =?us-ascii?Q?iVrTQW9Em6BD+B5McaJ5MVuubZMHaUEPM7tBsqq6bPM05sgzx6HMsjqQ6QxU?=
 =?us-ascii?Q?ceUIBCuGeqRAwV5//H47kPnT52meKy5OOwwAKrL5NWIfqdbPsQ57rBXTB4uM?=
 =?us-ascii?Q?Yvd93sN2jU+54Zp+5lKCZM26i6cTlw76mHwZJT6i+/Ic/v4aaRRsNxgDLeam?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6631baf1-1a06-4a91-dafb-08dda34b0cbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:34:48.8961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJWim3ZNT1pGT/IsetSUVD42ndqHCBkFDpMiM1bzfuqCC69K71CN0jL2OedmrxmxF45UUtCiLYFXufktqr4o2yaNny0UWYPTrxHlA4N7Nik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

On Fri, May 30, 2025 at 02:57:17PM +0100, Anatoly Burakov wrote:
> The iavf driver has implementations of vectorized mbuf rearm code that
> is identical to the ones in the common code, so just use those.
> 
> While we're at it, also make sure to use common definitions for things like
> burst size, rearm threshold, and descriptors per loop, which is currently
> defined separately in each driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
