Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB4C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 13:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18D0042DC7;
	Wed, 18 Jun 2025 15:41:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1A18F427E0;
 Wed, 18 Jun 2025 15:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750254107; x=1781790107;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VT0AZCui6NevfGoUasxGAD8B+yC2mztWrXbzKKDkRFI=;
 b=Cx0R+tpCOs9qTl3yPtZU3bySBr1qdd+9pBVlHin/J3cId8naJVMnC0Ka
 i2483uikUnrIdLBwtsyBWCj52D+HZIWB14dCKACFgDGVWBqJsjO1C6JuC
 9t1aJr1FQCjq0EjF+jdOHIRq5qKxxxYnv1MAscrwWEf6Ka28Z5mHWkHVY
 V7iGZyXFJ71+xtfj9tHAcr8rlXeqVJm5Qg0Q3UrXayHZJlWLR00XPfojw
 BZKmT2cCVidyyYQdQsllu5b3YzznHKh9yyl5zpi2tCU+kiIo8mE+q+95C
 G1Yc2uCtUDusZ7BxPLYxI47Ffr4wp225GeRE6oByI6bJ7mAoE2OCliOgu w==;
X-CSE-ConnectionGUID: VjtFIJ15ROW9mIUOpisg3w==
X-CSE-MsgGUID: PNnQD5pIRkaNIWI9EIJlwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63899920"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="63899920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:41:45 -0700
X-CSE-ConnectionGUID: vViZmnCQRRWYNJAwzbYXmQ==
X-CSE-MsgGUID: uyaUCy2LS4qF6BhlU8AkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; d="scan'208";a="149715681"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 06:41:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:41:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 06:41:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXBWQmwb2JW6BF795gBv57ZCb1QN59RHokrOwCOA0mIkOdkaL1bVWZ8FMvDrDcrNohndOInPvtcWfahwFJFby2Wm2kSnTQqy+HvimtRfOva8VD3r+VQsBJw6otBtvTLlBIGchRrPRvsHcCtvENHNcbFmum/HsvnV6fs8OKRVMDt2oBJDNL+lb1jfM6pH5MALSGVwhT12Dfw6lDesiZjcX8iBW7e5AFhsLJ1U/iCb9UQu6jCI0EG64yoIuHFJuitJh1yZFK/kR1jnO8OCliISKiuLrOkZqWU3k1yvEfwFGqIoWbMCDLbNYdhulvkwByp8dHI6ZmcEN23dZeYZB/r7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++qlQ6CUpGwhmxp/uJWXVxGz7g9y3nujUH8ELzufydo=;
 b=PahyIpkrmv3o8j5eLaUYJBx7aQdvLBhkZK049LhsEYx/O20+fu6MEd8OPvDH9DjYkrQkiJsJZKhhD9G/wLdTMP7a4BMJpwTExtjNfop7kIR24w8lGznZhqmlMZqpu2785IyNQ+4jIgeDQzOMP9K7B2MBEglpl3paE3PuNq3aOddsvTMZlDNUTy4SdoUGDbqsJLRVQfKsHOstSdG2clDNadoLohB8yLv/qLj3PsbufVS9CzDTvAigWzp3ONI8H0ljc4atLFAnBW/6yZynRNkVZJQxsysxXEXhIHBMQD9EqqVwZf+P2VaKzVUrs06Z1A0ZlI2lSWj348RaZPhbbYQLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 13:41:42 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 13:41:42 +0000
Date: Wed, 18 Jun 2025 14:41:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 2/2] net/ice: fix updating DCF RSS hash
Message-ID: <aFLCCErZ-WYoKQOR@bricha3-mobl1.ger.corp.intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <20250618070844.174484-1-mingjinx.ye@intel.com>
 <20250618070844.174484-2-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618070844.174484-2-mingjinx.ye@intel.com>
X-ClientProxiedBy: DBBPR09CA0030.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e6d55c-62ee-483d-1750-08ddae6ddbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YG8tReFeENF30LIohkV8lU0dyRnFXAoFuW/PVEZOYifSaO/J2a17rTNxkOy?=
 =?us-ascii?Q?TZXCtITlA/DL49hNZqacmiHwI0NqCkagc/qejU3tU2fdfJJ9UEZ2UbUpN1zm?=
 =?us-ascii?Q?MnbdaAwmfx1G8X2oD3gwesrY41pvWFm1ua3mTX5GalobhYErV0CItr+/Lza2?=
 =?us-ascii?Q?3ig6PStdwngys3ARDM0F9YUjMnToP/9AdmWxkdtpKrXUELafL/7Rw5AibcpR?=
 =?us-ascii?Q?L6fyWSYnnRPElk85RAwOLA//tZxVUyC5PJzNgoz47IJDHulVN2MAAk0IvEQM?=
 =?us-ascii?Q?aOFmzbEFVUEXmm5NM4Znfb96xvpD8zgyJeun75NcDif1Zf7csE7yY+oN14D6?=
 =?us-ascii?Q?dkLxEVUTP9UPcdQq1oL+ZNzyghQTJVJ2CXSjnnQfIUmyxRs4RRJbAGTQg4ev?=
 =?us-ascii?Q?OQ8mgfNavsiXkz6/uxnz2NUIHH4XwjVP2LJ6FxEdm/O9DnlD8R44b2cKFkSF?=
 =?us-ascii?Q?7rUxzK+QZNdxO8r5PyakBTXXSzO1Qf1YrdrAd2Rk/GW60BDYT8tRuKFXJdta?=
 =?us-ascii?Q?cTBSUl/dm/rSzVhxelerXu1eRpAWoMqBYqPWc8yHTYsNQgE4n/pTEk+p5Ffy?=
 =?us-ascii?Q?XTXX0vLp2ku5s9hGC1uVypKRWhijZWgxNm1E3VNs5JxugResCmJGc8Y8f/QF?=
 =?us-ascii?Q?qhAsO/djhee+73zTEAleZ9+0gOe6K40gRiZCQ2W3RKLRhQ/yNAFPJKFHHNDA?=
 =?us-ascii?Q?Clmt61P/wVQfFi67cuYpfrLalIp2BS3PCx8QF7ZW+eFQzexsY6qga5vp+Lw7?=
 =?us-ascii?Q?890Dg/iB1xvfVtFskQD9HQrHJUl5nBlzoTE9e5XFBC/zO8o/xomrkt3Ii8JS?=
 =?us-ascii?Q?50nMa9TihlTMWBYyJEFagKguimzAPGYEW+eXVEMczUXMqMasiivtwQ21ueID?=
 =?us-ascii?Q?VTr8garXXyII6Fre+WEha+O4/y87AJnm4N1oX18jNfN0p1UoPiKdk+4kyId6?=
 =?us-ascii?Q?JCW+rTIap+dWvDUZ2o5TybLqDLMRZQeOme4qNuNjF6+RxkbQ4TRqQyEKz9pG?=
 =?us-ascii?Q?syELI1mim2p7vLFE/uRYCD51q5zREDvNKw1sROTqgAt2ngUh0HrZi+4QjAWl?=
 =?us-ascii?Q?z/7KOhjzQEZY/A//q6KQ4eQravDrW+7AY9TvdPxGInIwJwGjLMKY1ApmocIR?=
 =?us-ascii?Q?fnU4MRNM3VCDJZClRC2u/BqdMWcBb3rwIKYdEZsCD/J96ibaT4QdXJJlGdrh?=
 =?us-ascii?Q?Jn9zJLL4g7/VT2uOsMM89eJfEq561VcFYK/E5BdePw+Vec2oOQhfyspmh4HQ?=
 =?us-ascii?Q?fD4r3KkJChvva0P5dyq9HHfsFEOJ8LcNtkDhBzaC0+yJ4LHZEJffUtJns7ir?=
 =?us-ascii?Q?M+zMWUk5aUmisVW4H1qeF1pA/138xCuMu/qOvOzejLTYez7H+T8WPVCoAA7N?=
 =?us-ascii?Q?Xx16W6rGCx+3dZgsJbt8YuvjdjIzxC9485IV3TiWLlbESDhwFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGFoV+3xGkAN1eo1haYbQh4gUWiWV1e7SIJeqnHzTyXvgsO4Gjio5ChTK2UW?=
 =?us-ascii?Q?LMW2jLuCPArz9Lhf47vHeVhj3f32p5ZnQLFpknsLz7Dzbsf9gs8zd6Ucq/bN?=
 =?us-ascii?Q?S2xD5v6+1qTjHQZ+J2/OWMmVnYRQBQhm/FzaoZr4egGoJuUZYFUZ/tXQHfYS?=
 =?us-ascii?Q?HYOOsMbaJB8AXgoMfhFNTm+WndAyY0wgxj5nsFpr+BRPYZIujRTORRTsrzfH?=
 =?us-ascii?Q?T02trFXxH6V/HB3K75tMH5sJw4KKfBlqG1s9v44s554MBWR+wEuRuXrSTkIY?=
 =?us-ascii?Q?pBmCTdyazFMxx01UNRuT4tNfLJfGoYEuokyOmes2se2l7Q9lwazMTpDslgjJ?=
 =?us-ascii?Q?wq7q2R4NiNHnFUZrbjNq3y8418ndoYndEwoPxdFiNmjplT0k4Tj986lbcvFv?=
 =?us-ascii?Q?N1l0Dg6tRoDT9r/9NXmfU6xG87f1DYgU/lcq/FmW6Ee7hvbsZWT4Vm39yrh3?=
 =?us-ascii?Q?OTQHwFBQ4GcHN3hREGxwqSF6c/fGML/1VrzfZI5rIgdJwhffLQ0JrqcFQLIp?=
 =?us-ascii?Q?vzvmAkFd6LN623MO3L9C9vlm1E78LzzEOO2qZ7JSKzm8ME27SKx+w1VRjtbF?=
 =?us-ascii?Q?266qBFwGFRxeAe7LJFoieoc7Mlew/8wXO+sTswbj54SvR1TaCjVKQxHAQ7X8?=
 =?us-ascii?Q?zgCZu7kk1No1k0/ELPcdVGskSYCteye7sqhrIxaK4E6NdsJTMJIZS2iBF3sJ?=
 =?us-ascii?Q?fKNOO8mZ5li+wl0qrRfXzLOOZ6IUKIYQil/F22+ze5toDpwQTSa35S4YUWCi?=
 =?us-ascii?Q?NuKz9g3PmxnmRwLl69tAeaPB53kgf85/8xJNX5+b51w9cw8MFb+vsptnu2Pa?=
 =?us-ascii?Q?uXMoH/s8K3P2Sk66WbwDJ+jB4gQEnoDlxdaZqcMZ76U/2Mtet8QC5jGxqPwj?=
 =?us-ascii?Q?9oAgDPXd+n7XJyOhEh9dHnWuyS2w201ZO3nKOmBQQ3kok04TrINFSwcHlnVT?=
 =?us-ascii?Q?f25S00REvLmqOqjNbT6wuOXy6gwLbnwutzF8nL9v5+hh3Yp8h1JA4xqAGilx?=
 =?us-ascii?Q?go+lwLz3Fe/V95MbIt5W50jFyjHfoI/qr9uEnPGoHu0IZ2QCIJGZcR904umJ?=
 =?us-ascii?Q?Bv93WhGz/biasOASF6/wYk95I9sqIZ/Ttgzb5vkbk/JOY0qzln4hIN+qq76m?=
 =?us-ascii?Q?n6Ii+7ZtP4s8ORs8eYOokbOt29GYakuaqwqBZogeQv5z+JZcwd18+mFnfwGZ?=
 =?us-ascii?Q?YudM1cUrws4Rl5AjpzBDDLwICypJvpyZeEBF7qiVXemO/9MmyNzUSPG1/3Nr?=
 =?us-ascii?Q?sPneZqEVc8I7YH9/SJNisfMgw3nJk1V/vB/c8i/aSupTHmWXXYXYVaAh0U8C?=
 =?us-ascii?Q?kAdBDwVh2bpOLE+gXBzrrwIHBatK0ankzPjyj3Gc5HT3QJopLY8PMmBkt+71?=
 =?us-ascii?Q?4Jt4Fc2cwQ2gL+ZKaC/T8p+hNZNbjWdeK5G8a99y+ZFZCMbbFKGKeoxGuQ1b?=
 =?us-ascii?Q?WlWb5hQ05tPtAZgzVjPgzjdWviASrCFBe24GMam/SUR50xkwPiihjUMoJhbN?=
 =?us-ascii?Q?bizTxk1/coSeW02x+RcdmLfRzOd5ARxLDazZD+I/xntVRoIsi9Z3Pt50FPNh?=
 =?us-ascii?Q?8mWL5i1JT7ujb77S/AbchHIVBWbMHRJ7O4hDPBo3x3kDbrO+ltnx3jpQ1EcW?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e6d55c-62ee-483d-1750-08ddae6ddbbd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 13:41:41.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijvy+NjFURPXz2losdwFGQp47K4dAcBvoyT7ITtG3ahht3UsV3jPKXJLwmQod8VYo2ePsAvWXYTu+JIwHW+tziK8Rt9EIBsdE2anW2VzBvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
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

On Wed, Jun 18, 2025 at 07:08:44AM +0000, Mingjin Ye wrote:
> The driver does nothing if the rss key is invalid during the rss
> hash update.
> 
> Extract the update rss key code from ice_dcf_dev_rss_hash_update to
> ice_dcf_set_rss_key and make it consistent with the pf behaviour.
> 
> Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---

So just to confirm. The behaviour change here is that, if an empty (zero-length)
or null key is provided, the function continues to clearing existing RSS,
rather than just exiting immediately, right?

/Bruce
