Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BC606A329
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=irySE6QH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B6C4064C;
	Wed, 21 Oct 2026 12:03:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4069840041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792576985; x=1824112985;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iCUtdIgSpFlEsU8rEveAWMtoy075cw6KWnC9Yp7kzzQ=;
 b=irySE6QHjk2W/6LTbBMYdnkn7U8MwLUmHsI6UylTbWH3nx4rDASt9gYO
 9fqQ0u5+T3STjT6HQyr0dXggmFsfABefcRPhhQeij43/nwP1PxSMZkbAu
 mBsuwXaor54e1PYn86yVWwEnHVlnGSgKOGAAwaFl/2X4YuU4EDdc+9YUg
 KdSGl67FGlIH/t+MnIWRzieZAMXGDfQSCQueQVrEm4L7a6ccsvH/AT0Yo
 OSdM02rWgzf62nn026+oti5LukfIQw9s9QK8m+cTxjO8OQMM9aKZJNmj+
 dcowEFwhzB0AQkVUCoordeBoAZDr5HJSDAGLcSbEy1eqvB5W4c25Ruz/u Q==;
X-CSE-ConnectionGUID: m7iRJXuMTzK/A0Nigywm1w==
X-CSE-MsgGUID: oZVIfQ/7SjKtoebDA7d9jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1329789"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1329789"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:04 -0700
X-CSE-ConnectionGUID: YDB1feCJRSytIAEJDGxUZg==
X-CSE-MsgGUID: +diC+6AsRYKCW7CaSt2+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4848633"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:03:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:03:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxBCXypTciq8uQRvv8uWV0Ln4jNg11CutlJlUF25EHh8+ZcLq8zf7FwIRo80o+LfvTmR3IVBi/Z5gPWEYtubq94QZpthVDfoTLBWSJ+KNxQWL6kKTXY5vH7SuqI+Q7Kp/h8lfCSm3wPZ7MHPL5G3l5DWowEC92yBRz2df6cPCtcq+PUx9pkIfdBdmAyWBmli/LZYQh7B7OsFm6njfQacLBMhn0nfZmPHOQZVh3s6PkJjqQH5fYDRiPbHMwjE7tdGKp/ZwWbXuwh3Z3ESrjFJM7LfCs14ccdX+tPET6bjnBezBpCAcG958ElP5yO/sxpxsYriK/YVoRDwjh7KGmY1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrCMTaZVke7iuQmBwrVm4G62rBNc0ASuTjaziiDT3es=;
 b=cqM/1KbZrci+DOgGmuvc/65f0XHR4GKUoS/nPVh7x7DA9ZfExicJW0plrwHhG9WJUzLgjrVlSb09leukTTeJY4ej07cF/JzaNcQhWkIYIjBneThzwaov2xtPoa6Scf+dINyc+nYbjgsUNXhJDzrhk+oQIFpuOURXATeFybg5wZTF8pe71mRIBAYv2geQir9vkp5NAYetWXVweEvyoouCAgSum0y7fXFIW1mOF2JezN9CEhYD5nBU14J1rnDoGtCYw98bgjLbyockbx+rmxaIN1BBX+x0cAjaoFH64jZ2BgpGDbjVQZmtowYaLbYJdOD9U4Jj++y88mXdzmjQcORucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:02:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:02:57 +0000
Date: Wed, 21 Oct 2026 11:02:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 0/6] Centralize flow memory management in ICE
Message-ID: <atiNzOhTRrDe8IR6@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 822231b0-50a0-4be5-61fc-08df2f5a7b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: EsfJ3z9O/kBKYpSxcRGb1l7h3s3TlfwvhSfL8O38151S24rMDBKVMz+NG7BqdcoSt216tx1v45JxMuB+SrtL8/7ZrsQ3ifSxjtBsIHaPGjsVpWqUaHSSPh8kYZR5eaNY9GFWub+CFwFc6yJPD1XnJOYS81CMDP1MQqQVpjkDP735u2x8gA9+hKy9cvtEMSj77rLtaep13vgsjK3JIBUW2Ke8GLJ2CD2YWsOMyVLYPRnzg+2snfoqYsb9y34GhsrAlfM3AWrJp75s2E1tY6y95jkQyZWOJ27pwEUdgX2wNW4ezsA4njbWY2bHLb6diSmRdpnATUsQ+OVXI3dcIztxoPasccz0AJaUWoDhqvc/4DGK+nn2h8Mdv4V2a6DItj1PeIphrjE0/HBY0HAqiyj3EGL2k+bHbku34P/L+yrFWYv43JTzp/cCJckMcFRoGgshzZ9SHqIwpI+qvBaHzaZnFqW8izu8qqc6ATS62XGLlJ5vxipKH9unhNjidFVQbKjuxaknF2XOA+asjWxp3CbQkR88zytE4I8D3ALlmmpPkrJyUj/K01ivhgF34UTYERZbEVnd6hkOMGxe2j0xwFb1UPincrXje0lmvjZaOIvPCK8QwtkUDWXrClD1SNNtqdKId63IHBTj6Afzfeg/VAOIZxZU851KreESU24+7iPTpsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUrhz0w4p/QEuiBcRO6FcbNOsVeL5n4HV0XgbL86TRODr7gjWIQkTOlrWPeO?=
 =?us-ascii?Q?7Rjwb5LpVGwHVv/oKUzy51Kj8pOKKEJf5MfAFD1CIV/5x+mqT12NBxyAAAWv?=
 =?us-ascii?Q?+wO2lx4umd5WhHJXAtEGcFOO7U6PDo37o7BHFLxmNG/0Hb95IruF5PAOlZXG?=
 =?us-ascii?Q?LYg2UJAoQQAt8bHOtwK8wBmST8rsaasWTgAyUzIELJ6IY6EqF2ayTna08niZ?=
 =?us-ascii?Q?z5bF73pY6/pJvSyvC1R3ybf9oRZVzYaYPxWkTahMvzcxJdPcOVgTC22iexZj?=
 =?us-ascii?Q?AVHgMWcV6GhcgLzPPNCGRmgzAoW67mWqU5GtLi4zG6L+MpnBjbWPHCN+NWRV?=
 =?us-ascii?Q?iyrA+DlQe0pdNtnvjfCQ5zhIpUcLONsdax/UcwlAHz/w9mKYMlEkxVawvMWR?=
 =?us-ascii?Q?GbZ20/1m5DxbficFKTKAbNu3QP3y+a5m2sp5+06XDzMZgYCZlCEQeKmuN7lQ?=
 =?us-ascii?Q?JGOIz6gwOYeR1Zmlmd/oswvBb9gC2vHi4jpAWsi0aEEtZuzs694AAu1tp9ux?=
 =?us-ascii?Q?9H/bq8Zm9s7T1DKek3yQhC3L2RQOGbJ5lKVXG9DfM0Kh2SKCoHZiDS+kaNyN?=
 =?us-ascii?Q?iLq/uk1Oemz1F7xGV5DUFw0pbmbioXXT6HDBJ0RBv8/0o+u2pt5aClsTKWdZ?=
 =?us-ascii?Q?Mf6rfLfGgHfDcJ9RpK0/RNvDKd8zoI3VQCLKwaNNqlEIvSO0rPUiMxztrinM?=
 =?us-ascii?Q?0ITMvGPM+/iSj8HakS4HPUj5cNEETmaB3TgU9y8z5EbiLfXRKeFdUrlanJrP?=
 =?us-ascii?Q?jN6pSxXnOKI0CfWqyM5saAnmGp2ClO2VziI1Yf1xvX9Vz13o7NIOeYt7fmBU?=
 =?us-ascii?Q?A3RFNLOZcPLxPCfLKcxpW6KcW+v8vmxix81VFEqPktXB5tJsNy7PPzw5MjWK?=
 =?us-ascii?Q?26I82EcUAaPQciSLELuNs425Z+uP6K+tJVbYQF0Tjts77hdG1A3mM0JZKqST?=
 =?us-ascii?Q?vCC3do4dx7xa2CjG8+ZgAB2hn9qEClCLASQsKtvIqw2EkNoTW4jZU9KqddP5?=
 =?us-ascii?Q?yKWhBr2d/DjljxAY4osvjrgleAdFb1g8gt5Zw0OoHSg4brHQsEZfBZn3AImo?=
 =?us-ascii?Q?4Ro+ni3ETtiw15c4ZEDIsDQUPQiNbV6v/7ek26E/4sBWd6wGoNCcdIoCjl29?=
 =?us-ascii?Q?6rGqTTAhTPHQy3UbimHJpHJXQb8ConGhsv6I9UVnF+Ff4YpvCsZ7TWOxu6/C?=
 =?us-ascii?Q?n/kZ8fyJez9KScb+wZGT1z1ua2geEkoYmGwb24aZmUsoLAZoMKC7pOjnKq/Y?=
 =?us-ascii?Q?LyvYr/TZq2eWWDvUVcL7W1O28q6yGZNZcfS5lp23vT1LCyhjwXdfycNEpFof?=
 =?us-ascii?Q?yMgKY/k2hxLM5G/1pZhf03JborbnSD+qOCoBpX88DYj+LZpIvihdiEJj+Z7L?=
 =?us-ascii?Q?vPP4mPeq2aoG8AN27NOYFzhImJsEsbChfah4bfFqk7h3ubDb1u0DBJXFyHBC?=
 =?us-ascii?Q?BhiUZflBMZjll6wwS5RbS5El08rFQ6KEqIfO6X99x4BITrIGnn5PG+jF7nmZ?=
 =?us-ascii?Q?SdOL5SVjhhN1OrczrXmo7Vz4cfqKEAoLsJpAapTNC2Csx6/hqlmnHbUpXPeP?=
 =?us-ascii?Q?iBNKBX+NfezDTsZfZKxEmAHzTX72J9RJEDeT8czG4wa3ze0WbWLQLBuaTQbU?=
 =?us-ascii?Q?4nW4ArhRdw+FUM66bGsRfAHFJJShaooPVIRyFhgJqFVJ+O4+lXPLRGvj/pT8?=
 =?us-ascii?Q?ZYMd+wKiBVAIiu5QFMcUicUu5ws5Gr+mHdBCzRaBSJoxWoTKr96ds29LRx0g?=
 =?us-ascii?Q?waKS+at7tEDh7dwiBdOjepwbuHg+AQQ=3D?=
X-Exchange-RoutingPolicyChecked: tz8DZIFIPOdiw/y2IwNiYgUyQQ/BrpWXdBY4fb8gENhiFjBcC+zfrizIM8LMchBONNcZLrKLCfcPbcg2++yX/qthCDLHJFBAgVhebU7Dm2Iscs1W0J5az42teMnd4PIwor44kexexwdLFHRudGGZ/1VAG60551e0dq4KtaBEqMLjk8da+NDH9xj8ZRkucN15X/VHO4Dta5zTTQm0PhcLDrRNcOtQyknCdc+//E6PxMCzv5S0CWQf6AR0/kXyWFgFRnAkDMPvJePLI8gJid9S4BSM0L0wO/QiuvtG5A4KwuUI74StE5RgHdiTjucb2F4PwXKCA12tF788GKiZcPgE7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 822231b0-50a0-4be5-61fc-08df2f5a7b7b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:02:57.6310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLigTYfBFtsA/DD8LfdWMitHdOFOWl+fz9N4J8PmuBeuhFuXeYN3MDeSjzI+oDU9wFSX5iWyOrn7tfPATiKKjqZ1v9dcYJL3gh3MbrdMNKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:11:03PM +0100, Anatoly Burakov wrote:
> This patchset rolls in a few fixes for flow engines, but the
> main point is to rework the flow engines to have more defined
> memory management.
> 
> Anatoly Burakov (6):
>   net/ice: release ACL slot on entry creation failure
>   net/ice: fix inconsistent state on FDIR failure
>   net/ice: standardize VOID handling in flow parsers
>   net/ice: remove temporary flow pattern buffer
>   net/ice: use caller-owned pattern match storage
>   net/ice: centralize flow rule memory management
> 
>  drivers/net/intel/ice/ice_acl_filter.c    |  91 +++++---------
>  drivers/net/intel/ice/ice_ethdev.h        |   2 -
>  drivers/net/intel/ice/ice_fdir_filter.c   | 124 ++++++++-----------
>  drivers/net/intel/ice/ice_generic_flow.c  | 141 ++++++----------------
>  drivers/net/intel/ice/ice_generic_flow.h  |  25 +++-
>  drivers/net/intel/ice/ice_hash.c          |  87 ++++---------
>  drivers/net/intel/ice/ice_switch_filter.c |  97 ++++-----------
>  7 files changed, 185 insertions(+), 382 deletions(-)
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
