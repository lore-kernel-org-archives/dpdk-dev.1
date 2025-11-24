Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0CCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 13:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A644042E;
	Mon, 24 Nov 2025 14:53:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id AF151402E5
 for <dev@dpdk.org>; Mon, 24 Nov 2025 14:53:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763992418; x=1795528418;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ujPFRjdSTogFOqXS8fx6jyvmTHjHfiL9EbNUHBQaQTI=;
 b=mByYNAbB1Pbn+43MdEX9r9uRUNI4ymXdWyEYyA7xWzHLl6NqowIh4uIG
 2XK1aEn6ju6RrKesAyNawDWbgwxODB3zmWRs3WXYJ85jOI7Bhx5DcUQOt
 sJIR4yzEe+0jU+7lEb7JEdoUmHyG+WZbqgjK6XnHn2qAMEMKm5eA8niaj
 ECbFz8lsGMCjaPt9dG01TGssELU7JiFEP/EA7TWFzaKg1E0z0cnVzwroi
 bk0NnqT2HAenKjGIuDjK1Mpk0vMnEDQChfEmEgr3h4NIT7UXAUdi0hWHa
 2+10lSBwDzSrgKoXY0TRE38vhmgDaurSIKnJGMTrJX7gurTiADDsBIrKF g==;
X-CSE-ConnectionGUID: 1CX+0IFuQ1CXo3+sslx1nA==
X-CSE-MsgGUID: jPUbocyDTpeHCSdhzF44zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77465842"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="77465842"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 05:53:37 -0800
X-CSE-ConnectionGUID: Cb4JhHjrRnWSFPbAx9p3AQ==
X-CSE-MsgGUID: WCINrXNVTOWoLG1KwXNEuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="197268643"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 05:53:37 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 05:53:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 05:53:36 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 05:53:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqltLEb46yfDfPkYSUTnd94nhXweIj9AYGmMa4y9wZrEkpBlUcc7nwR+cmTf451X1BSLQ+oV26ad4rGZh2lTbFfa3ak9qkT9sIKXPc+/yb9tCu6yVNv1gjS+kqeqsgx9JM1FFYRIsZ18iy8t8gRPu8yVTYtZc1xvFiLAWhHMr84zhHP21yjRI6PLGkZD3SdT97MOT6nSCU5WBXQAdI+fH8K6qzvvZq6lw1pIc2wPmseLINS32MromhMLgFpyiq7P/nizFvF37mLEgaLzEGlZFMRQ43n1JPBLeuVXSIqYa+HoRgwf+tcsEPP8LUwee2I83lR0Z5mRSP4jrMVen5aErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnVfPhNgtUnwetD9Qhk8mIJnNZDj9GK2f1l59qLTaRg=;
 b=FsY6bcln92CVXSYPeBd4bhjQXy/xOwC4qIB6o+kIYMREexVrH7/Kad+8OWDLVYZ+N8L+xz+IyOfKoHe0fDTBLxac+4H/IOiq+LqgpfJqNdwFbvsp3734LN/PgDOigdahz+aDPCNV1ylJbFH9pmM5HM0UfAxNts9AH/3LLuJ/83MnFYJtChXzjXHTs4SoL6b/55mOoEXqbfdeoMnyHPYoQuKGsi2jlTE2ErxpbrEkrWN50hnA3KlsOK2mpJlfuV5s9LBXDYaQNLmFV3CwISVcX3XoMwJfjXA2I3cftx+1tA/CIPnVYp9RcRn6ocqb3gom6N++ik1PN6wZCUsTOaQSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:53:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 13:53:33 +0000
Date: Mon, 24 Nov 2025 13:53:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC] eal: use C library to parse filesystem table
Message-ID: <aSRjWHmqAl7B8YGq@bricha3-mobl1.ger.corp.intel.com>
References: <20251122194921.158921-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251122194921.158921-1-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL4PR11MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f8c90-a169-4e0a-5ad4-08de2b60db6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R9xe9Zeh7xnYJVeFfwmuaaiEoddz0pvKUchqVLsKIFCjfmkJdNEsuPUFy/+Z?=
 =?us-ascii?Q?r98WjpSNr9SgeI+qS4lf4d09C9zRrItexMSIEKL3LE363lJNvKfT1SPpqGye?=
 =?us-ascii?Q?1/NUSltt7JezEbn2e8748cWhLTU+flpqo80J748vYE0EGiDqnmryClx2JWGd?=
 =?us-ascii?Q?MGinZWP3ZB5NlaqGrtxRM417E6BRdPqUpuGFPV3e+7OoZ+UibSj5cdRU6uYs?=
 =?us-ascii?Q?T/er40kSzgUjvQSNRvGsNlcXHaRxCwJju7LKSK0iAMHixmlGjQICnXLh5kkc?=
 =?us-ascii?Q?6yP2o7+grtcaVW4ELw2JQnl1cJ9Fe9AZ+Y7ujJjL3bPgpkAY40DqB4HNsABA?=
 =?us-ascii?Q?/V4LzgEkrukgBPJ0AeW/EWH2wNH0cNruluHeZBFUej4bQCJOtU5b+Mt4AE1A?=
 =?us-ascii?Q?5z0g4FZ0y2vsEsv2PUhPwuhuLjlmVC0+hM8BaldpR2oyxc6uHikcfk+gbpFh?=
 =?us-ascii?Q?Le2pEeUYsMrci67LkOc++P0LxrAtFtSb60Jofc/yuwpmG/S6p60vHsA7IKE0?=
 =?us-ascii?Q?3x1rZdgPX2ig0tNnrtKmryPuTuCQ/9GHPy0PysDOyWC4iF212qUbMs7sbfmx?=
 =?us-ascii?Q?4x6vR4ql5wqw7THFyWIiLO/gpdHKsr6DqVeiZ7RbAAOljNXTqxqgwwV8fzNr?=
 =?us-ascii?Q?baUZDKmfOEru4yzQn3zWG22Dq/YMqkxB7mg1/1lCtndsUFTKY8AXuDsi9CTY?=
 =?us-ascii?Q?cOHOdF4Err+bYW7UWNYjWdFHeNtL9vkDx+a5FYe3UT5oZyzj/O2ZfMFDEDZE?=
 =?us-ascii?Q?IqrL6xN8PbVEQdmS4o1sUVlPMEX6lxDpNfbZe06znRsT0jxFJ9O4VDZu2CEf?=
 =?us-ascii?Q?lrd2qZ9znPt9P+kkW1LukM73dYduTveullrXddqZQ8YCxk0zUm5E6uPSzC0j?=
 =?us-ascii?Q?pY5siqh6hh8RC0Xqo60RVn9cTEp8ly0asBmFHA3pQOL+eETb0p0PczHCcNpc?=
 =?us-ascii?Q?PYh4NpMMvI5pq0zxeISmCB80SBHZQSdtDAqUc5NpVQyHWmdskJcOz86CzAbu?=
 =?us-ascii?Q?u9Sra00x2+oO/3/KZoShKyY/huY8D9AWNYIylgMKEx1Mk1NkORtSK81IY1s+?=
 =?us-ascii?Q?cpY6kIwJL69kMDdGnnGkzP0ULEjlD5ZL+kQVCie0O/llc+Cz0ewBEH1JR1Se?=
 =?us-ascii?Q?tro90WplYf2jPpHbQYZxbwzX9fPR3evRcJuM0ltpI/0YQCiamOjmXK9dZi/K?=
 =?us-ascii?Q?Hh6M8tperBvScSB9J2eXSrUQklpivsFJDEPvUaiNZLBXTwptTT6EJLBcx3Ly?=
 =?us-ascii?Q?pnieIRRniKDdwMgEWEmW2zQWhtPdUDmqCubB1SEZCtyXXhRvX0mYdbA0I+ow?=
 =?us-ascii?Q?3YnmjKh+Dzv/50wLw0PMgl1WLi30otUzZyoTTdJ1qyJZDu2MXh/rbKp7apdS?=
 =?us-ascii?Q?eHYUYONEabI2nNiYRTeSWyTG971e9FK7h3DCPT3K4cmVBk+djXybQUNTkdw/?=
 =?us-ascii?Q?DnMZDYs6PXhN7IGZqeYRCke/+zNSsmPg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IuVYv5U1c93qndHFhDsXzpBEIQz+Et5qcdku9s/Opxw76xAxkbXHIcQO6+N?=
 =?us-ascii?Q?lkGjjO7P8eGhTiVRW9QHm1XLJtqJaDslpCkQuaoOh/6+rSSb56J7sk8Iaswq?=
 =?us-ascii?Q?hwRC2ZVIzsYL+wqBnKbtr6bBrRq8QgS3pWamUroqfXTmcsCNQ0T7vE00L/Nt?=
 =?us-ascii?Q?SfOw6Oh9SChDXF71r0IS5e2cEBKaH8Od+Xu0J10G0FJAdRQZqRekE0bW4SRi?=
 =?us-ascii?Q?uNgD7BOmfF9AlM9Ip+2Vs+vjsQ8SFyKyLbC+A224IozMfSMewOtojeizm5sK?=
 =?us-ascii?Q?iy4+TUWjl+PtywTq5NoJOQtjZfIkrjytC+bupEcUGiCH+9EGkgauzohjJU1d?=
 =?us-ascii?Q?MDclvvzh9p04T8pbFpmenl8fbKZw4oUA4Km+Ww2DMffUnMy6gbqe0fHCkLH6?=
 =?us-ascii?Q?RB1bpEWM3Ka3Ng3bn4JySo9i3Sr7HwfSqNi1L+Tqn15tG6F25N//uzHdgGLA?=
 =?us-ascii?Q?Ne7VxjT0E+5xvHnpuKZgGSrLR56/+jqjBvL+a9HvI/+HqEEoW9fATReCHoS2?=
 =?us-ascii?Q?vm35Vz1gvNQ0KwLKhlbGetUkeQheF+B1tCn1+PXBNouDnwnsNz+BCHPE497M?=
 =?us-ascii?Q?DrOP/qNQAbXUg3UqI/mSkvir+QoFe/zHA/x6M46bONWIZ2wBfDk3HLAMMhnA?=
 =?us-ascii?Q?EUDYozqFwLvd3cfwPG8jq1sHPAKdupVTOcxmEZDWVl9Nmhl1+ZXqGXB0jOb4?=
 =?us-ascii?Q?eRFhy1QA8Al2fzb+iSwABPoXYOawPo8zCNwAv+U9m+b5QlRQmEOI/t9fiS8k?=
 =?us-ascii?Q?UYnsi5hvcbRz5ATEfmTWLwnJi3VKgo6M+P9Q24nbQ1IRgQAD3GL7zysVcTxV?=
 =?us-ascii?Q?GqkCEPP7/vuY8DPStEZ7QyCIfx7q6QzAvvSVMKn9WJzBP1CsdcDY3zKC3Ev8?=
 =?us-ascii?Q?qqvWOKbH5kGayIqHZJ4wKUWqmYquDqp06vkrlu4UPHzkzLWelacz/W8owagu?=
 =?us-ascii?Q?bd939sUCZ0G2sDUYnMlO9zjYl20ZcgkwvWslxQ0r7hkK6Ikwoan4ILMH0dEN?=
 =?us-ascii?Q?0/WQEp6Qm31k3iOiavfic6dWhI01fCq+fVMpwjCTKS/2yqy58/wG6Tc9Wvln?=
 =?us-ascii?Q?0aBCVhU7JqywJ1Qu9ZQRdifBjojkKozZu3+sz2iZkN+1nZ+DkD4Ntknr6Z1J?=
 =?us-ascii?Q?uwnfymXXRK1Rs1ZonN1Qn9pkiO3F0PPIPB9s3VnYm7b9fwz/5XpTN9E/SSj9?=
 =?us-ascii?Q?ZQorc88iVlGfy/LxTQOSz35S2fSu+XY8LO+aRFoN/iE5EqdmnW3H9gW0ilEZ?=
 =?us-ascii?Q?xVQRAg+GTcuLJyz6bZnfweeHDa/DdkweCoVHG6QRul14XEfemsESVWVUEvQi?=
 =?us-ascii?Q?rq09vj79f4Xf0MNNMDcXttgogXay0qBlVElxEZqjZQ6b6nh4h5ZjNSTdivTd?=
 =?us-ascii?Q?ynzMTsbt6vL4jER6GZqnbojWIw+UNlAz/P5QA7uvZaSKm3Qu7Lg4aD82A/it?=
 =?us-ascii?Q?r3VQ60aFgtxY13OZ9zHe+DAz8trgY//k+RchYRoJK+R1qEXtdMcftdv9WGqr?=
 =?us-ascii?Q?mjIoG6LN+uGBBfSdYU1SDq0GD6ERnl9ysAxbtS2BTf2MtXnIrBZ34+nu70b6?=
 =?us-ascii?Q?aO9llUUuymiQvwWBRDrjxqjBrCZm49AlzbGZ+7cSqsfvNFHE2NtaKjzVttL4?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f8c90-a169-4e0a-5ad4-08de2b60db6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:53:33.3099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owP09aUUcmj7d0HYCwANpltkzkPDRIhIgOv4ZU2Ny0WWSsP8FoiI5lU2bTa/3T7M0TrgeFT49JVYsonBnIGst+x60D4b2rTv0v1pkxjIN6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8797
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

On Sat, Nov 22, 2025 at 11:49:21AM -0800, Stephen Hemminger wrote:
> Rather than doing parsing of /proc/mounts with open coded string
> handling, use the standard C library routines.
> These exist in BSD and Linux.
> 
> It also avoids any possible issues with escaped strings etc
> which the library handles. See getmntent(3) man page.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  lib/eal/linux/eal_hugepage_info.c | 45 ++++++++++---------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)
> 

<snip>  

> -		pagesz_str = strstr(splitstr[OPTIONS], pagesize_opt);
> +		pagesz_str = strstr(entry.mnt_opts, pagesize_opt);
>  
>  		/* if no explicit page size, the default page size is compared */
>  		if (pagesz_str == NULL) {
>  			if (hugepage_sz != default_size)
>  				continue;
> -		}
> -		/* there is an explicit page size, so check it */
> -		else {
> +		} else {
> +			/* there is an explicit page size, so check it */
>  			uint64_t pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
>  			if (pagesz != hugepage_sz)
>  				continue;

Since you are already changing this part, this if-else block can be
shortened down to avoid duplicating the continue check:

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index ecc0374204..0e54b35ce1 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -227,22 +227,16 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
        while (getmntent_r(mounts, &entry, buf, sizeof(buf))) {
                const char *pagesz_str;
                size_t mountpt_len = 0;
+               uint64_t pagesz;
 
                if (strcmp(entry.mnt_type, "hugetlbfs") != 0)
                        continue;
 
                pagesz_str = strstr(entry.mnt_opts, pagesize_opt);
-
-               /* if no explicit page size, the default page size is compared */
-               if (pagesz_str == NULL) {
-                       if (hugepage_sz != default_size)
-                               continue;
-               } else {
-                       /* there is an explicit page size, so check it */
-                       uint64_t pagesz = rte_str_to_size(&pagesz_str[pagesize_opt_len]);
-                       if (pagesz != hugepage_sz)
-                               continue;
-               }
+               pagesz = (pagesz_str == NULL) ? default_size :
+                               rte_str_to_size(&pagesz_str[pagesize_opt_len]);
+               if (pagesz != hugepage_sz)
+                       continue;
 
                /*
                 * If no --huge-dir option has been given, we're done.

