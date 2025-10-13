Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020D0CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 12:09:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9282402A8;
	Mon, 13 Oct 2025 14:09:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 17F4E4028C;
 Mon, 13 Oct 2025 14:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760357355; x=1791893355;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o70i1MxDJzlE7+nMwsLvXYFjJDqwTkhlCLTcnEdhgn4=;
 b=bC7ddDApT6CxvJodb9OpKu0cYIgd4z6KQ8idttf1kTRsgmmpd7KDEpx7
 iBEbOoXnEWJxFI6c1WNslq5GOE6kexWkTc8yq/kNlbbSueou5MxuflnI7
 AznnJMvz2uaCk5TjlweTsrQ4QoKzP6i/DWRzH9pVSmtn2bCJ2A3zLzpnN
 YoeZwuv0XqUpRisAxn7kr359C5sLSbLmSFVxnDvvOFVaKzXD997l51aNC
 rqoNuiPsCP/J9XxmaVL3shsLKZBqwqzRj1vEUR8d8PJ6DwDz9ETkJP9Yu
 ny0lSOeGlyIgmwezKWiIOVJfcUgSsccPfEDJxyn9j1X5LBsZDysGfPKjY A==;
X-CSE-ConnectionGUID: hBvJX1ecTLas3vBdj1E3YA==
X-CSE-MsgGUID: HMENeUx1S0eQVLwS7I9n6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62381601"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="62381601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:09:14 -0700
X-CSE-ConnectionGUID: zeod8BclR/m+tsnTk9PyVA==
X-CSE-MsgGUID: HF7Ju8CqR1iSAPPYjASLAQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:09:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:09:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:09:13 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNgJa7DojZef2k+aU7kjtHV1wC/0EKJlDLhAem0s9FSg0hZqHD/U79pxyoYsyGngIHSBxkM00TqIFgj88pD+Tu8VTgHgi+3XEHW+ymQpH7gAQDbQeGX2yPOhtp5dEqzNn5wY6naBcAFrfcXbmQVX1V8vq22jark2z3zrPeIA0pKA1OS8cA/ua4guRxIvAP2fKbvfn57ESMl7PE7MJbZHPsGba0N5rDs+woYjm57XcxJjrvEQsHpkiYT/lPWwE1A2DMntBXZDYlI2ihAq8Yqt2LK2nk6ea6trqSETfOxOY0LEx+JG1v80vKJLg9AF7Hl6vQn86xNcbMwKyAo+3FXSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWpZ8MAiH1otGvFo8kqpRZelwYd+218sWXuCCjvfMC0=;
 b=VJkjJM7QjEf55ufx1bwf/oSoBUAq/lEkQA+YUmhszTietnuAnHawVH5fIWeqojIvtV3D/cl67sl/CaJxXBwloVCPyE4T0iHhB8UczcJrRwE6i9mdAwPEpRV/i+s0P86mA3kXJG+0+hfvXb8yq8cCzPLoXo5IvWvcWDq0QxQlr+sSVTqxVIi7lXX6Ht6lJtqcb5DXJ+7Q01nHctJNlS0tpEpiJp7ldSeHQVvt/Kb7TutJV0jyduq2mkftSv7wl1MV0l6lhm6gTWAj7FzJSixppKuajaQK+hdy0X56is3CBNw+/WpgInbi/Oqm3mPWWx/q8t8arDHAxIkwUpgt1hM38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 12:09:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:09:10 +0000
Date: Mon, 13 Oct 2025 13:09:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Junfeng Guo <junfengg@nvidia.com>, Qi Zhang
 <qi.z.zhang@intel.com>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/2] net/ice: remove indirection for FDIR filters
Message-ID: <aOzr4DMhgD3xAJa3@bricha3-mobl1.ger.corp.intel.com>
References: <65bfe82e74867020982e2729f84a7c00a5690c5b.1759837052.git.anatoly.burakov@intel.com>
 <2f0e588a6f838f4a641c1a23b22b9dfff6912264.1760101992.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f0e588a6f838f4a641c1a23b22b9dfff6912264.1760101992.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:10:120::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1aa391-ff0a-402f-50ff-08de0a515138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1WdJbEYnXVCmM+KAQPAZSNdvvDlKOwlfTCq61X2nIJ9zBpQDQXcQpUl7edjx?=
 =?us-ascii?Q?+/pvZpE8Slii7umBYZRJVbHCBcYxm5sLVVXeG3puCBNq4SABUb1tHGBRd7Il?=
 =?us-ascii?Q?EbpvziftaaL3Vz8yuMrOl2YIxrIhrHoLIDHNz+ZaJDeCGp0LudbftYFORX/J?=
 =?us-ascii?Q?sCuxB0T2RR6XAa0cMYft0k/D4tuOqHt9kXbSejGV7uWvYadMwptfe/WrR9xb?=
 =?us-ascii?Q?hc1jWW5ZrhXOk6+/5MG8SOsZb7wUOHuxuoXaY1MsPGKnLa2ON8NcrrPm6QB1?=
 =?us-ascii?Q?Q20HNpmygmPFC9gchQ/ZbEE75AQwjHhSAF70QTSOxOpyT0Ni49ndUweFoazM?=
 =?us-ascii?Q?p/OsquziWf3tzA+EGIaQV4xECpe8+cFLRlpL0PTYLi1NM/e5bdesk+HpkTYY?=
 =?us-ascii?Q?6ba818b+QFT0xjRCmGTknWpNwL3Mrybkpl33l2CUGQZgTiutIAcoSbt3aQtY?=
 =?us-ascii?Q?6yLgQTo9XAev8CyjrJ797JjSYp1WNFM9WQHYfWcOoQlecoCwWfId4nDkc8SO?=
 =?us-ascii?Q?ep0EZsVcpMk75DB728FnkbIZGvtTDnLqQqehmmyOeCeDa8R9YJJj+H7EmHor?=
 =?us-ascii?Q?b0uE8qoNkcMl27MleqZDRR/fRUOluV9mNiplYNv6q9tSpz0lssocwfjr4Dsq?=
 =?us-ascii?Q?0vW0b0w7FrzHufdMk1cCouJ0qZYrqXqSwPgqS7/NmlJMGriJme6lVJF1jdkc?=
 =?us-ascii?Q?fHHrjcEkPvOQk2BrxSRyoztzqAfc4WvIocezKVoXh2pfjX3B1Ad2kgHRTsJZ?=
 =?us-ascii?Q?3IQKvqmFFoorfpH4YphH3WBqaH22QBXU/TjlRGfd8c8W0NgZIV/aOcj1VdA+?=
 =?us-ascii?Q?w+F8UFPSYK+2aMmMJvM2j5ZJ384gbkjwKBJwZp4qsjDTp5R0hrwbuN3xMLwp?=
 =?us-ascii?Q?p0d40WvbEGHWJZ+eIzperGILXw52Vhq/Hf5dvkTgDcrgJNc38h8lweFU4kt/?=
 =?us-ascii?Q?EPxZ188UdNBwxXPi+jF7+xTuJj5N55DICeRo5ehMkX2/9XGwxxPDOnbgGpfZ?=
 =?us-ascii?Q?/PHsqaBnjAEqtnDjmgiQoL5mwIS3AsFpvk/LBdi9dUUIrOrW1mJl6byP9/CF?=
 =?us-ascii?Q?CW3cgOVN4YThfzXcdxL/u3PquG/jA81kz1eKfoPTmBwerL7f2wOzHAw304uO?=
 =?us-ascii?Q?dJHdnOMqGRh0AbGitsMR1lFTHULnIWpFQ0l6hoHXF+aVo+qWVR8K64o5g5rW?=
 =?us-ascii?Q?ImMmQF0MBZNHb/jBarhs+Sig89oyBMsUkqbxxVGtK3bWvuHQZzHZYWCg3ioQ?=
 =?us-ascii?Q?qFG+lN9/Qtj+PwNEkLzAXxFrlhDcCQkbkW312TRfd5ZbLm+q20BFsgaXAR67?=
 =?us-ascii?Q?gCbL/zflMnW/VYaG3OyslzBuBzut6uiv6ld9qUPGthaq6cshMvTSAMMK5LGK?=
 =?us-ascii?Q?SswwYpScoQuM7fWiOxCPQG3j9W43VZ/kqJ2QMeG1SR4GnTnPAmSJtvyd/Li7?=
 =?us-ascii?Q?PDvtMOihkEm11CEHKmTFLWs3WU46vlKS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eShh21GdS+fFLypvk+OD5pb6fixSxymuIxRc78b5IgsddduiO3+UPhx7FzHd?=
 =?us-ascii?Q?TXv674NvNybVECZ5R0QhRG5UayRUkA1MsAdp4caB2cI5IM8hAyg1F4zAJY/j?=
 =?us-ascii?Q?7J/PyzH8SOXTKwFYRYwAo3bmlAyh7p81umKW2QeEJW80TshoH2E0aJXKXIC+?=
 =?us-ascii?Q?UdKV9Q7wmrVrpRNwSiRvWymLsHT7UYks0ny/7jJYUXDxS9yb0JqyvXJod47Z?=
 =?us-ascii?Q?6WkE4TrHoXcFJV/H22I2SpbcBdKDjxibbnNb0e/5yJNwlgGVk8Ff+HLaasak?=
 =?us-ascii?Q?tkWvKq5cwqRmxRWBPupol82xLxMhgBZNtVVy7zf1SUrNk17D3SZJ/zV4FKyu?=
 =?us-ascii?Q?uLSYAaR5k6xFaUi0wWUeoq93+tNXPxZiL5oFVm0yRodygbnpmwFb3rhfK+IN?=
 =?us-ascii?Q?JsKTXSkyT8lZVm72i1UP/5cHhD3JwDBBfU6s4fNE82PZEyVqdD49hDZLFF0P?=
 =?us-ascii?Q?DIb3cC/KBGl0mVWHEaE/VM5Wq87ccY8ag0PdRMgosOtPxgqQbGzmqkR6nN0X?=
 =?us-ascii?Q?k8BPzwSApm+ppKhgnOV2sGffosaRBOoNull9Z7227LEMHf0wEctBJPIgFNAv?=
 =?us-ascii?Q?SLO3J/rjvbbETGzdO9BLCmMFtDidQx2g3gdWUly6YqyscAu0EPd0oqLVeGaO?=
 =?us-ascii?Q?OEF0UeKuud91ViGyr5mEPFUIk3cSnbvH1TmnbN9tvMsU6/9QexOZhTfMBTUd?=
 =?us-ascii?Q?mzAiVwnRyg8WxE8AGY9iVwmG3/1txxGBo2M9sYsl8ZWZG7hfO5oNFgG+iQnP?=
 =?us-ascii?Q?BCrN951ZQw7AZG1HbjOqPHTc5/ZwPmonQ5aPuAK8t6Db76udP+sJcIm7J7ot?=
 =?us-ascii?Q?50zmIZ3mWqyJDF8b3vUmHvv20nGHZXN+o4wdPLQyjmdS2sXf9YczSiCFJBH3?=
 =?us-ascii?Q?n4zwHU2UNLIZx8W518qQI93pvOjhvgPEhjUPPoyWhx8b+hVp2ZlH0iIG6q+Z?=
 =?us-ascii?Q?mQBZ1q3k4KL/p2USihexKVkA4nQ6T9irqLjaJ5P+AH4/1mpLM2KIdoGwXwOf?=
 =?us-ascii?Q?Nik8NzijVjaDOO66AeQz4poJmCNehphfUg9F0A+3Ov/Wdx3PkCjpJJ3vTgcN?=
 =?us-ascii?Q?DgKTsTQFgYiPCMZHy2Y0SBec3JWtwqP9TuFTKwNfoYulSY9k76qgF1Fr5cOX?=
 =?us-ascii?Q?BHAaZ9Y3bznxH27mOtjBsGr/zdpyS/kp+snTHmQCX/uEABtsrPev4ivNuLLc?=
 =?us-ascii?Q?Yj1xG6riHZCEjoVc9arLEfZEuFahGYnlbrJixGpAY9A5H9c8AIcTd/6DP5NV?=
 =?us-ascii?Q?vTNlaSW73vMAQMlvSmPKEJ6EoeoVszvjobjboR/Vo6CGUH06w2aWUNp+SKKQ?=
 =?us-ascii?Q?Q0jHlmVBFEi5blVoQK7FXimXztUaMDF/bsImyca+CoEp9fosewnSUndKT5AO?=
 =?us-ascii?Q?+ioczrHos8NuuGxFsIdzUgfUuPEnl6lEzih7OhDxXtvJQLglWwBk2BQxhDMV?=
 =?us-ascii?Q?ZiKj1f4PLuSA2hU9rSjWfbNbTez5NpqxBWmaHdhmK0fRiMPR9M1PtnTlNbIK?=
 =?us-ascii?Q?piStnNLFHkzwVBs0nFK+wcO6ruO0nkka3B3B7lWXZNWM9qtSIPTk6wRIdvyf?=
 =?us-ascii?Q?oS9J/7qhNKgf8TBelw7NVBilzhDSrMl29EDQkQyhj6SytucBBNTULsVTFjEt?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1aa391-ff0a-402f-50ff-08de0a515138
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:09:10.8281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsvnjw+8sgzV0TiA2TKX9Hb6bMEvIJ8UNqJ4DGximkxUpkkU5I4pKXxNDLRe+gK3S+ttZPgpFLoEbApxX1gUDivJ9QimVHdKjPR+z7x6cd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
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

On Fri, Oct 10, 2025 at 02:13:19PM +0100, Anatoly Burakov wrote:
> Currently, when filters are created for FDIR, they are allocated
> dynamically using `ice_malloc()`. Not only this is inconsistent with hash
> filter code paths (hash uses embedded structures), this is also creating
> unnecessary indirection and complexity, and creates a memory leak where,
> if something fails during raw pattern parse, the profile memory isn't
> deallocated.
> 
> Since there is no actual reason for why FDIR filter profile must use
> indirection, instead of fixing the memory leak just avoid it altogether
> by making the filter profile an embedded struct. When parsing begins, the
> entire scratch filter structure is zeroed out anyway, so there is no need
> to add any additional zero-initialization code.
> 
> Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Series-
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

