Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CA606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwwut1CV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74CD402CE;
	Tue, 20 Oct 2026 18:56:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1370840151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 18:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792515407; x=1824051407;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gp2fBn7bIm1LyTkwIbYRwFwcsfuTM4hcg2KI5BW1cZQ=;
 b=lwwut1CV1p/av18Rcndvgl5Y6C5F7FmFj1wxg2iJiaiYO4boxgm+hZey
 Ma8rWh0EzJ+c0txZpqseEd7XCHG9vt912ualnLVdDp1sO3hrGPKmzBpYO
 9HhTUYaTBycmNfprv6UsJZxSDwXn5aB7TqQvQtz3JAIhrOcPOsmuNCk7M
 XzxuQl6zQ9hBpHk7Saw25gvqa5uU/ouhwxvjV7mJQFH2DTG4rVLAyU1NW
 4bQSnJvaPMmifS0kuxTI9Xa7axfKSpuG1d0dUGjj/ISNf40YyBCgN7o5A
 mLZNPMQbeYenvmUIYOl5SYjS0xscXyoprjbh53eBPcjwmcYXzZxtcimUJ A==;
X-CSE-ConnectionGUID: S/G162qJRTWMnehmMopKBg==
X-CSE-MsgGUID: WNG8HU2jRma2BN8R/VNzug==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1327155"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1327155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 09:56:46 -0700
X-CSE-ConnectionGUID: YXIbU+s0QECxs+F7piMRVQ==
X-CSE-MsgGUID: DuHkRshITI29V415Oh791g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2870660"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 09:56:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:56:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 09:56:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 09:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8a5hUY0k2qEHhDqP/ao7ZxoZUfMMKz5chGGNvrQu9d9nfeO+s2x3SAaktWgYfEZTXqP2X5U6qnbTArQp7ExcfXRPKnS8F65Epqnjr0GnqjjmTBTL91qKYRcSeXTIXoegTNcsnGfZjbG8K2ueDUufU1gzSuYwNI9oN5UaOgo6vBbmFPq5PxJjNBntEXjzdPwdRrU47dUqZqb+Y4NPYW0DIQ35IpVlWocsb8uHlwc6xyXLhNCKmsKQmHic3rxM07NPeCyL4fph7pPK4FeQ+zutZINmIDwz8fXUxvonqJ/+jr6bQaO5cLcD2YA22GWSxOAwSyXcxM/m1lIocuS6rSsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUQczEf72OIgVjufpobq/ot5msuD144yjoQHApYYT00=;
 b=Cu8TmK6VBlkAlG3+PQNi9nuh1KbE3t7mGK6mrdcrWqNXmfNVAxbOx+edS9EXbwwWvcl0KhwwIWxTaC2E6DrkG6wNynU0/2jgUinKtilEpjPhwim06JCg00XM2fVBYxgpbYz/QkPMuExF+L78kULjjNan0BQhsUwgZdU9NKxnAf+tyE7/Cwu+aPCdoRT5m6k6axNOpBLeEH4aUjOX0YXNFT2TqDbU+1MX3Gq762R1hHUDpEGRf37VOLa+smr4LF6oOsyFl+FER57eRJTatuKHr8cYsuUf9858+aJ/tLw6weIpxworQwCS5K6o/dHVWsl0ngTJ5MS6TGCQezqMqOu9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 16:56:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:56:43 +0000
Date: Tue, 20 Oct 2026 17:56:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v2 0/3] net/iavf: fix TM hierarchy commit and TM ops
 without QoS
Message-ID: <atedRXQvvMrkOl4h@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <cover.1792504817.git.dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1792504817.git.dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7a9fc0-3005-4e78-446b-08df2ecb1e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wVw3mt+RRBh/EK0n3ETnZltYaXZ+oUq03r72XVs6C/N+5kmN9DPPrcXpjvMioHmt53zVHKzsr0sEblOBakM/dLO2tPiO6UJuESGgN4ZcW47ocXIe2oWyOxm8rSI/YyKbH4eb5eAo8KVYCdK3Eo/ISrsVsp/cREzs0T9xRFsyKiTbKK8mDXjPwuf5BM1in7riSMoeyRmuH60dPiwciRWRRgYGC1lqrL/wgtAnsiKnDljL0v6jUp/pnhJ382J9Bj9hJ+am+YTcrIyIPf7DFB1pjso64xm6rlptHK7UqaFaXwHx+NuGBVUMGMxLKid8PAfQaOQfVy32u4qwlYNzaiiCmPDTpuVlKcSHQfuSS4atB3bobucsWFfiE4qYuYZ5Cy2wasevmtRZCjMrE1hRhGAlxVTbbVKB1QG6ryQvMhEmfthM2KXHUcqS4UGGKy51eESMgcvQRn+uSYUGzX5kxIIXpvYDoPxJFWx0MWwIavFAmsT/Yj6mGWcYgK9tL3/lIFDkHXl0vBcyJMCO3rQ5EGaBDqJG2MaswMfgmEEwUTnc5f131Z3INK1Gl9jZEkm38bYxryWuqPqvB3e33fb5K/Hlh05JbnskMMp+sm2Ouam5zBYXhXPwnweqNbJOZcVRpRWaFFeGTFYSJvxY/v1sZ6UGiKqNDRhkznV6bD/IELePglU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5603P1kCpxI2qS/25Aa2EAFckJD/GU0cC0inoYu3nY/NHpIvYe995o9CTUEA?=
 =?us-ascii?Q?HImDlEus9TJ3L4yl05LccLsWwfbveXPtZNMYzbJIeU/aHI4BfPzwb34MIjME?=
 =?us-ascii?Q?x0WA7E4kDzowIZZamr3UU69Lhajq+Beh/aQrnzGPhSH369yaK2XrdPmLY0rI?=
 =?us-ascii?Q?v6WeTne6wWqQyO6QtbFKSG/Uw+y6GRw34r5zQqH652y4Vbch6Fu+845Zqm6o?=
 =?us-ascii?Q?/3HZNjT1RZc5+q75O3dSreYmOd+aHykeRgPrVhY/B703FX1d/PKx17hB/3g/?=
 =?us-ascii?Q?MS0Yz6bKIxEvqlicRf+GwUK6R7VheKgsTQ0fC63Bgv7tYneTBEi2OMYS1W9s?=
 =?us-ascii?Q?s31bFciRGbYJuw8DitwCZxICNdoWYrT/2JLlqjiGOBCue+3NOCiVvSsjeyJl?=
 =?us-ascii?Q?sMZXum0j/3yzgz0gxsXAgKrz4Ej81eNwLoSd1/jfAtfQlkbGH+HYNfRL+fxP?=
 =?us-ascii?Q?3fg/oB7JoB4clCIl2HtTHO5E7oIaajfB8yuQgUbw8FTAQUdNZG+9pvMtEk2G?=
 =?us-ascii?Q?drNas4vhEZRnSrGFpPZ/j47V1plI+bowqi0vYZa+GJAx8mZkXhZk/5++sPgt?=
 =?us-ascii?Q?qlF0vVTlLrn03QabnCNzWnM77ZWbFiCMQVk2hyQFUiNx+oZ3Uquo6w9GDq+/?=
 =?us-ascii?Q?v6PDmXJLsuERW18xe9RPbT96NpqToykV41pAgmU0lmU52QJYT0OtDVQaS+8p?=
 =?us-ascii?Q?8LmGO6ngFGXM6En4fU08qHtlJKQk0uh+mpisT5PmMh5CvzTGiU0bqbvFm9R5?=
 =?us-ascii?Q?KUrUQ7U0hXAP518le73Cp7CI1NKnTeaxogRG038BRTL6evUbStM7J0+XoQyl?=
 =?us-ascii?Q?LZH3jNJdQJ2Yb5+4CFE4iHzcUTS4rap+s9mzhgWDsxFrZYxGNL/mLPa4jqRs?=
 =?us-ascii?Q?Bk/HcWPI6GiNO7NDMo8q1Qx6omtICSayBQv+udn+jvhQOG3e0WKb7E5z3JRu?=
 =?us-ascii?Q?1/8TsRx55ruNH5WFJVV5fjQKCp7TLErKiCZBb5QGOhK4JDrvbyJROj1lGnoX?=
 =?us-ascii?Q?tPJ3u5QkUw8C49onlTfDUr7ybM94PeWGJHls0z/xJKTLzp/+GHI6/sCJBZsf?=
 =?us-ascii?Q?fsWmO4ROnmo1C9Z2M2TWij38KzDNHNObQlGAXeWR9wE8ofXzhLelJSlRe56S?=
 =?us-ascii?Q?VoHpsPkYtb6Ly3/O96A+E+0qvCeMdcbnJSJgYjuoX5HG7Pz8phvJcQCTpGxD?=
 =?us-ascii?Q?KlxclZeikaB0SuObynbeR3XOcC1f+wIU76LNEmAnhJPho3z/Su1PvxL2leZ/?=
 =?us-ascii?Q?aZNrzGs+q0fyXof+DIotufgTbR3KF9x+vlD0jFaHHEb/jXAdVCPDG8Ckq7t+?=
 =?us-ascii?Q?QL6pDdqjx7/GdQHmUOI2pShn4stSoZ7AKqIXX7NpIbQ5R9xUn1KWVLo+umt3?=
 =?us-ascii?Q?jZHQOQoQtwueQAaXkpLPGUxZjePxFTDFQxd6WGk8Ikm48Gu+PsZ2JDMh7sky?=
 =?us-ascii?Q?8USH/eiUs7yfkeGE3BkYW6hADrZbFY4EvnuyFcaqvnGki3GPM5qI66VzUExw?=
 =?us-ascii?Q?xS9gTbvbmVA4Pyx9TQRVN468Le17uN8Z9HXIcAoJyRDi4jlbSvLxdGRsEVn8?=
 =?us-ascii?Q?AkjrJKDf/7kDB9gP1Pq48SiDPU+WgsHkZr+WtdmD1bCQL3387oRdlFn97M+S?=
 =?us-ascii?Q?PbAWbUstiOs1vebTset/LUvhCUxF8KaXDwJkV5mtVpxx1fR3y3pMfwuTxTw1?=
 =?us-ascii?Q?St2GJRZrUZZdT1QChBB3MeCRCgdV9cdx5guFkxwgiIBJQTFFkV6YrNcP95Et?=
 =?us-ascii?Q?UdMehuvTiqhnA8xXkF3NnaKI1wzT4pc=3D?=
X-Exchange-RoutingPolicyChecked: zXnHTMdtk9D8wrI+rtYWj5XnrRrhMD7EOog6vQUXPnwN6tXv4fATUesm8Wp5A9QALWFn/QSoAaRpIy2c8L8jBvzWwlQQCQB2jTKJLUR1PuptDPQ55Nh7Jrc+Nyhku9q6s3Ox4pUun8DAH/8Xjp1zH92ryZockuxVw3bMFpZcVb2LjxNqCRMcEyTN6SZnBFAz/Vh2OUb4xBb/ZcmwtLtP4qPBia+Zuajy2/d5EVxT+N83XSJlYUtCP+j/n++OOsMCpVUW2kqTKLMseob2+ZItl39RrWIUYWi/H2JWLUP6V2spKeW9rZtdrtdyc8+Swv5Kkd7in/OhqAe/b73/921VIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7a9fc0-3005-4e78-446b-08df2ecb1e19
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:56:43.1802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN/CUIOrjFqUSwgg7jxSpgNoMs4vouMJXPjISHag86L90A6bsKWH93F0qPooGMR013SZlL+/UgXEWX9yLw/SVwYU2DJmhHwu6jLbzRJe6r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 03:22:09PM +0000, Dawid Wesierski wrote:
> Three fixes in the iavf traffic manager.
> 
> Patch 1 removes a second free of the queue TC map. The fault is in main
> only, after commit f6e33f09f766. No release has it.
> 
> Patch 2 sets the queue ID and TC of each queue node in the queue
> bandwidth message. Without it, a queue node with no shaper profile
> resets queue 0, and its own queue keeps the rate limit that the PF
> holds from an earlier process.
> 
> Patch 3 returns -ENOTSUP from the TM ops that read qos_cap when the PF
> does not grant VIRTCHNL_VF_OFFLOAD_QOS, for example the in-tree ice PF.
> These ops cause a segmentation fault now.
> 
> Tested with testpmd on an E830 VF, out-of-tree ice PF:
> - Patch 1: three hierarchy commits on a started port. Without the
>   patch, an ASan build reports a heap-buffer-overflow in rte_free()
>   from iavf_hierarchy_commit() at the second commit. With it, there is
>   no report, also after port reset and close.
> - Patch 2: one process sets 100 Mbit/s on two queues and exits. The
>   next process commits two queue nodes without a shaper profile.
>   Without the patch, only queue 0 gets back its full rate. With it,
>   both queues do.
> - Patch 3: in-tree ice PF, so the VF has no QoS offload. Without the
>   patch, TM capabilities get, shaper profile add and node add give a
>   segmentation fault. With it, they return an error.
> 
> v2:
> - Patch 1: also remove the rte_free() of the map in iavf_uninit_vf()
>   (Bruce Richardson).
> - Patch 2: commit message from Bruce Richardson.
> - Add the Acked-by of Bruce Richardson to the three patches.
> - Rebase on the current next-net-intel.
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
