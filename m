Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D7AC624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:39:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7353402D8;
	Thu,  3 Sep 2026 12:39:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D10554275A
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:39:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788431985; x=1819967985;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hwImNihCii9c7O7h6yHRfM4b19quc1gBGGuSSYwgYCE=;
 b=L9phVV4hY+4w6iE/IytdDp1T2TaVEd/dyQMITXFyUocyXU0nk3kkRXx9
 BcNs1/12OTirxV26gUZ41jsKOesgvKqZDc12nuqNX2ZPuJPvRdyxebd/M
 KKR9ljLMq2JElrPS6fDWVZZcYORYSOHGAHeUnIqE2uflqoOFZGJVtiqp4
 pnzX5VrN2XusDcI95T/P8FQQ6+koqGXapGutoHNP5caOh92XFhswg/+am
 DnuZ/MpkxqOJo4uHBxE8mw7a/Bdgxgdrs+mRqnO6xLx9npBsFsvPz7DxW
 AkpaKZzPSxpPQn+mh6Fj9xSNBBF9XEPcP4H5I9EiiVF7FE62A59NN4EJM w==;
X-CSE-ConnectionGUID: TJQt9MLHQU+DraVhl9hvVQ==
X-CSE-MsgGUID: zntg+J81Te6NjS/5NxS+0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88758140"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88758140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:39:44 -0700
X-CSE-ConnectionGUID: rSrCCIrkS4e7uBbDUso8Dw==
X-CSE-MsgGUID: TiN/kyD5RV+2tXqmnwAMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="273200158"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:39:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:39:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:39:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUDm7v6FPcBluM175sf7ZRcpLb27y0Uk1/dnOaKCnhQnamBkJM6UkeZUxMZLhjE1FtrkTb874m/Ox1/8kVrz8z8akswVCPxZrYrC/0BVcexauXqthZE7MXuB5XI7Jyx+I5C7l+sPOIAFn1QQnG6DrmXm8UDRJ6/vuxmzTmEBTXmyJf9bfL6ZNXTJhZH8D5ywrpvD9+F2i609dPuwJUyvWDbwacp9jGso10uDlaK1YXH+2QIweI1Yi7s2mcNjIEjGm489xAQchmcAcdmdRss4Skt1ihzmfnYxfINnBvX9Fvqdic2b4YuIcJkl014leGQgyON8z8cfuaTeuxqjucAFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqz6TDtBBzH9QsVPpnvbiI44LMOzWyVb/l9tEr+Svek=;
 b=viCE1QQPmT1+FoDX0kTYL6rukg5D6k5ZlR8qNvVCS4srDMWj70BKHXE3H7an00CMnBPja7cumCt4YlmJtOxTJbUcm9GUb1bF6fzIYxPnlMAU5Qraqztjv3Wdrx9O73LnRxCW8OJ7RMo2L7heBkBt5xYNbLkz5/hXxpSNflDHyju+KLgl+Ha6LV5fFRMen6iN2bEpBn9YEePZdXMi7+iPF01m+OR50seahDk5ZCQ+tl6qxNQ9lOQdsOGdLFBrSWSPTN+GYRhA3DInth6CWiStWQjI5KNAPPfF1AEEtplv4wdLPVhTVjW7L+tuOfI/3RwF2Y1KK5FyQRtpKL8CQ/xARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:39:40 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:39:40 +0000
Date: Thu, 3 Sep 2026 11:39:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: Re: [PATCH v4 08/23] gro: include headers directly
Message-ID: <aplOZ1-Ki5qXvGG7@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-9-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 34945a8c-045b-467d-e252-08df09a7a85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VNwCQJHVNWpzg4lBfn8JmWRKlqMfPSjv1ziIKjdBqVZTF5MJ+Ro/Iu+N646Bo/58KEqZlM0TXMQo5suyvKKpJqwQXSJbCmjlhM0j5KPohepJI/5an0ainrsloQFuhbx+mLjOg4Zjuzqik+jEichaa9wsF0JyFz7LfvtyRtKU4j06lG+W8SsPPeVyGaudTppBpNITPy0GQ6eBCEjKvK7GstqvCdWRs1rRdTR50Nan5y9j4zIk3eK+J+kNRJWXfuPpfvveg652PV2xMWIs8+KUStwGDPJ0WbZB1DmvfABn/Qk6JnMapu6HENnY1M4ZEYcoSf+xCl4E1RiLHVbEFbUPSpzWylF/gNok52AejUOA7HFdlrZ7JmX5sW1ub9BaC24xJVQxb7ZoAgPiGtBfAQ1XPrh1K+IV4ZGa0rRPYyprvgHJsOblU2WunMdtcmYGzOCwF8+arPCun4M5NDXQyD9JpTFdEaddpUaMSrlbqtNS1VPFkdM8bGGkr7TWvKdVkL4ReCmvBCDn6Wm0e8A7U/j6JbMfLXGAEvrkK8aBp1O4mEy5KmZuyWXq86VY+4uNF61/y83b4od0Skpj1paWNnX+afDlQESMSP/YWpgZAKqCIn7LyN4OA241HYQeeolZKpCEgbGxlMaCoG/i6lEVjX+Efw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rUBMiYAiCdXOln//pAXdc/t/1UU7fDx/3myj2GGDWemrj+5Cg2WVBV2z2Hax?=
 =?us-ascii?Q?4jX1Nb5vNX2RG8Q6adpvmQsX5+65ApvUf9gdiL69SFrXwS3N3lFbQJufQBWF?=
 =?us-ascii?Q?VCq7ithYKG1qRFdyNe7B8kMAyxT4NZUCuMROs1nR72uRb+oA64fvbnlnaTX2?=
 =?us-ascii?Q?DSoZxOPm1sfvrQKknEi4dVNzaHK96q5QbMnt7u680ihKpof2QGQnjQVtflMG?=
 =?us-ascii?Q?zrXyh1jtvd/7bF60zFLGGou6YJsadqpOBxqgPdjjWD0MsdQwotHELJdHaNp2?=
 =?us-ascii?Q?+ihHYZL3HTMYrnSQCmgbPCtOGYqaXUV4hanTlq0jPk/5B00l9/+t2TvouoTH?=
 =?us-ascii?Q?mab0LX4JaTWIWbFO81ZIGl31LbD7BcXIE28V3KC+37SzO6NIYkVbK8u8PVY5?=
 =?us-ascii?Q?h7Gj87a84KKaI2GXrOzAse7Ke7R4OkkHlSQi1rUEp4XHS8bcdnIC3Mw+1ljA?=
 =?us-ascii?Q?Lwocbbb3plOomH1sMC4wOFzOP4pxPd66Qtg2U/PRZhVIsjUj8LCRwRRU+RvA?=
 =?us-ascii?Q?7NwLNxKu9CaZd6LiWGCYW0zIHWyqgKDvCq7XG14aA3jUz7Da2M1d9HXLtsux?=
 =?us-ascii?Q?UsNoYCtqerrLYHkwB/XbwsHg31zFQbGdBCyonL4Mqr2xlIBNJYOtHudKeKwH?=
 =?us-ascii?Q?FhGAAFmpxQ4OOsa73UHmP969GI1973TFwQ5yyglfT0MRvSaiBF+2HWi1eFvX?=
 =?us-ascii?Q?2PQAhHkw4O5wlcjjoyOrxG9kdxbY+Z0O5WA2v/anBg8cjKzK4wHFw/HznAZ5?=
 =?us-ascii?Q?1BTo3NcmqFJQFOT22gxg6ylB63oyaHbqplrQ27qu0gi5R9XdZl/QKV82U9mu?=
 =?us-ascii?Q?b0C0GgchOMV9GYwV06G8QYg/agJ9Ri+3sDtU3JXdjAxKTc6PHyuWHKg3CSgE?=
 =?us-ascii?Q?HSzNVNnNVW8aP52p5wz7jgRujEMpVVW6EWRubdUq3aRhzWoq+gEpXXSE8BBn?=
 =?us-ascii?Q?EHvn9pHhDrX4kNownRnIQIj+VYvjlaebeWwQWbZIL+EUK76KlMv4oGfwDRVP?=
 =?us-ascii?Q?1yvQcK2TpswjKE6h+otSWB2BaqV6i74PUq/TW9bHJu2+c4e7D0AHE1p/t7oc?=
 =?us-ascii?Q?SL/EcMpebowDwK8t7L6m9M2iGU+3q9DvfVergkgqCdlwWE+TdY+VXaO9lo9X?=
 =?us-ascii?Q?QVSs7BdvM7Q75uABTha++UF0OSeWxnnZWHa8KIdREvTsF9yYHqK5y/bmDd1G?=
 =?us-ascii?Q?j3Bmt2fWCRHwY2jSfspv06PWqS6zNXQ2WowJ+PUtcGLIN7oG3YuvOJjkuTZ0?=
 =?us-ascii?Q?7M5gbI98pwpH2BTN7BaJk9w3LQuZSFfq2XGFpnZWK9jAV/GnMCB89jBzn9xf?=
 =?us-ascii?Q?ofqCu9cB/d7HQHZcIEP2nphr5Hs7T5rJu9wgTe5i1xgOfi/JpRyoPRLWKIAI?=
 =?us-ascii?Q?2bUuD/P4vrTpZ+Dq7e+ptUVtVs4+ZLoVZA6R+6w1nj3n4rTQlzrWs+XoOsiw?=
 =?us-ascii?Q?yzJVg9eopUcl2ElGK48CNn6IYDoxdqnwrCU7CUfmEKGCEjoh687MH6teNOSz?=
 =?us-ascii?Q?XfbxCsgBFxAJw7GclOnBGTR/26CHBFV2gpxNxyeVDJ+fugu+AxCjQtSh0ZHP?=
 =?us-ascii?Q?Y5YH0Ocr6MtRAcJwoNfAW5yaBFsgIsYjBpDin2aYsNVjRqRaKC65RVEQvXx+?=
 =?us-ascii?Q?SJXtMdbSocw7S/7dfqEqJpj+rPS29AzIjNTFqC0lYazB8Vd+sGB1l+jT0IlE?=
 =?us-ascii?Q?OBspSZZ7DB73NQMGXLDNxc+GKRHWwb5yE9g0hzIGJHjP+jOgoDZDUoo93Zsp?=
 =?us-ascii?Q?jXMtW9wpj6NP2XGCqdcqGhXFJRIIBHg=3D?=
X-Exchange-RoutingPolicyChecked: MbAu6rgyzLR7tUi9fkfB4J9v6ujkc9pMMh08QkPiGPFIIBLjv4FjmdfnXGuqGZFUsV0bWPrSFbOQsWzbVSNgq8GI5lAoCDkh0mIYMuSaBUuGckCwmaaZMTpWMYp0hErSfA2obcbBDRk2ud231wSe0nhoJ953mzEy2aXUYjP4XMa+r7SH/IW70VPvUqe55KQSvSuJl7pUAi/Epod34zxTSX5y8yGDQWySatZb2W1XJgSFsHLqzjnzcW3c5rFJjYM1G7MkDvrISs0Gz71yR0ouCD/uKaJKwR/N79GmclARBYisDdopkh0JQNWjDlydBOW0ihZJiKsQyO0LYf542QS4Gg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34945a8c-045b-467d-e252-08df09a7a85d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:39:40.0765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8/UIOs1jtHO7oAnDvKuXjqjSh5Wk9JoDV133aLktaIohPRo/IHCVI3FzNxvmk0DtFVMLGWyt3MUxQSVBa/hUuGf/VAfdLSR2VgYJH6uf60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

On Wed, Aug 05, 2026 at 10:09:02PM -0700, Stephen Hemminger wrote:
> The gro library was getting headers such as VXLAN implicitly
> via rte_ethdev.h.
> This will change, so include the needed headers directly.
> Use iwyu to make sure all headers are covered.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/gro/gro_tcp4.c       |  9 ++++++++-
>  lib/gro/gro_tcp6.c       |  9 ++++++++-
>  lib/gro/gro_vxlan_tcp4.c | 10 +++++++++-
>  lib/gro/gro_vxlan_udp4.c |  9 ++++++++-
>  lib/gro/rte_gro.c        |  9 ++++++++-
>  5 files changed, 41 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
