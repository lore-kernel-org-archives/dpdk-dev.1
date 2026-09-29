Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A2CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4950840ED1;
	Tue, 29 Sep 2026 15:58:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D625A40E36
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790690283; x=1822226283;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=B5XHwij0atpEFQZDhcjNMIdoOcTNY2HYrx8NpxECcr0=;
 b=YVAhuxzRGlYTVajB483W18rOOHNY3OkQ5rvsHUfi88cmy35naDdML/OK
 mjOi1/B984yNRIquU36p56aFSPBaXRn6ip1qq7oLoPiXhHdPjieqHIrkr
 bq1sX13RhOwdsPHpoUaGjSpeTjHP8sGqyuBj/lJXxCU5/dhYNNYE81SMo
 ps6oQrThpe7Ay7mNcGaryaswFeLAy3OeSXBcZsINKKGFSoyz8IeEXp6Xk
 L113Hv53oD8bDYx8Lc8rutXDo0bbTWcAC2GkJnZ3HO59nk65WSZkVy+Gb
 KeiQXq2JFGhHFNteLrgO6opfVkmkV3B3HTeu717+dW2Nn5+2yFRqrFIuS g==;
X-CSE-ConnectionGUID: Ws9BCNdjQ9aPM2/sK3yhXg==
X-CSE-MsgGUID: cY+a+skARX2D92Ua19qwlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="107795006"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="107795006"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 06:58:02 -0700
X-CSE-ConnectionGUID: JNrkGa+nSky9ncjIMz70gQ==
X-CSE-MsgGUID: tuoO1kanSWCCu7nCW5v02Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="283472692"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 06:58:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 06:58:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 06:58:01 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 06:58:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdj/CnEPBYvFFMQJbqxCqDx/+9QVLjFJm/rOFAAO8h2pqhzCFCsPyEZXTzGTKlbKlJxNkFBEmzV8bZQR16DAVKVqIEQAKxNlTmvQ4gA6u/OnxcPNdQZDT5hdJmfhKEuoZGptQ8PHK8NhUaoejH1ObohxJhnBkDWyAvbvVE35xpsGtOfQNjaOU297ZiFJ3ZCfpuzJX760+SIos4zGrvN4MnCDFFVa+xPh6lnaUgmfCNV+Yxnfo50l3Y/++hUnNZ1NzFtYMrpFWJVhOjwTgELp+1rNQLWwucq8LlcTOThU5a8GjavK6W/Wu/Ak/0AIJn9FeU3Ccsji34asE9nuhMtCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTD8a/oB541DKGVenOecL4dB4+A6saQhxgWQnQxjV/I=;
 b=o59jCtwNBnvL016VB8+0r/laDk8KGAx3PygcH/PlUWNuC5wHhNi/iJEcxEP0y0Xv8VC0cGfoZX7O3UN5/qeTYekEoDF2Cd7Q/rGiaOVCBTJUtb0QUO1tANwxZK5X29FhD2IXV6qndipLCmgpcwMbEolXxVQyEapZwGGYuHeBzJacIMgZOM/r5/byiGNduGq2pK/7/AoDxGP/Ccw5ZlTy3bHg8O51CDbcR5jrRri1sPp1xJBvVcs/khX4kCn+QpcIQOFM59dE+3MJNgNmMupdQTbfp1NneI0GohRCHbr5X1F9vLNTGnof0Ng3WfJs91VmKMrmWRPa3JmuhlMsblPoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB057924.namprd11.prod.outlook.com (2603:10b6:8:508::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 13:57:59 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 13:57:59 +0000
Date: Tue, 29 Sep 2026 14:57:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ravi Kerur <rkerur@brocade.com>
Subject: Re: [PATCH v2] eal: fail initialization if TSC frequency is zero
Message-ID: <arvD4gDTBcNFAdAh@bricha3-mobl1.ger.corp.intel.com>
References: <20260927195440.89193-1-stephen@networkplumber.org>
 <20260928231637.733450-1-stephen@networkplumber.org>
 <art5SCrwPVJ8JkKQ@bricha3-mobl1.ger.corp.intel.com>
 <20260929064208.6c7453bb@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929064208.6c7453bb@phoenix.local>
X-ClientProxiedBy: DU6P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB057924:EE_
X-MS-Office365-Filtering-Correlation-Id: 81456590-aabd-4bd2-5817-08df1e31abd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zx6a5K+2LODTPOpJ2DpVHTiJHbD8PeRy5HC37EWD7yt4BBdBKju/HOn2PLIOgXsqXOBYZqbzSXrjtyh5bfk8gOcuKhpbtFA+QAtPjlGIviRIKMIcLWfqg9tBypEoDN6IPzRGXsByemuc0vb5dEkeBOpuakFLVgQlQmsG6b6E3kaQRNsl4vvmycaqg+kA0HF+M/XeMg2z7vFQ1KwZ5/qvMfGAkELRX8fSWNXut14E4o5re4Y0ZMMMjwLEW+DSx8DO0zBRu5JG8KJunleJDra6u2fwL0z99VHPM5NCrGk1ukkSfZVa3SlNUIiF8s6Es8tLkzW37zgtHAB9AUXxopikFhKZo1mElEVX2LIkt/3ZeSkZLfIBaf9xNsZ3EVK/5vSEdmkDyc99C5jLESEXdRqyiljoo0jOhYpDwLgKcsMMhIPlVExhlZP7VzF+lz6SwFw58gf7sq47Nynka1GZqrFQZO1lx76rLIyLv4NuW+PUgcEK2M7tcQNeqRVKrtRSubOkwPg3/9UevsIC9dq+8blL8VvkN/yvZKR5EtY9SD/+V4iXhuqGmbn39Gw0+5FM3a0AEfkvl2VsDm5ld6RlEUSFID/J6ikvUyYoPE5ymfNVLl3XfmDzZG67+GP1ERiWBv3kUPLx8HHTgsTQEvit7EwvdhfEa1AiSO/mfe1zmw/Za/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upwa3+09L7i/QfrzBNcsoXupSieOlLMr7iwR0rMNCy0HwlE+8PFW0UbJMU89?=
 =?us-ascii?Q?LH+XUmKt9hqWpyUz47sl09rgemhc37Sh4IIVM4oQBTbHdaivBDjpi77kgSrh?=
 =?us-ascii?Q?qwgeQK192PJCX/nBGTCTjIwF3Q+7LpPAlIw5jL8BnNnehphIBfp+FfHJrrFw?=
 =?us-ascii?Q?+HrLFKSSekaG3yoMsCFAhq8geh2Y4s0YcW7m5NjTI/QiWH0vrAS/2CU1Np3m?=
 =?us-ascii?Q?er9JNjp4zAv4R41FyT4vw09tvBq6xY7w4ZgA0/owPXkItldgFagiLndiWQYR?=
 =?us-ascii?Q?zvvTdKuCkA6vALL6zZJg9R9qTuoWMYQ1jw1rGPEuD90D8w0jQCG40Hy0wZlq?=
 =?us-ascii?Q?v71+rl1yIIQOoDYGg+fPATm+z8GUsTrv9nFcKhAfoyXQlPoAssOcu+8LuKex?=
 =?us-ascii?Q?Jf/pk72x3fU6o/QDJ4u8Ug+9bqhqAXL0MMqAIaDZagSUY/IpZ+uTZtV1C4IH?=
 =?us-ascii?Q?dQ9ib27j9NwJJ1EWNbKC3luZwP9l/YiC3pGpYw/Wm+w7yINCr0wwEVNzr69T?=
 =?us-ascii?Q?IMg+RPtRM+rtGxbiwCSCU1TqUodXdCkj9N4a6il/5VEpoDce1EHSr2+zXHhK?=
 =?us-ascii?Q?9ME9mvRb8vxNHKYjDdS7APm5GaLifJmrALN1PyYMAZ2DlfxuUcmrFhajSgVZ?=
 =?us-ascii?Q?LUESGQp1x1BwPxjmWUIionzuoXohUmjA3R6gkiJkAMXSZhHEpa0HEnU5uOvH?=
 =?us-ascii?Q?MvyWmmhgTsZ+I57DSyxwLVEjfif+0rxTwRJPF9RU4DlFa0tHpXbyO6Yenb7F?=
 =?us-ascii?Q?409viqMMzaCQg64sMj5J0WIfeiD+yweTwnWQiwc+c4RAhejwu29F5L4Y9vEZ?=
 =?us-ascii?Q?uiSJ1mmuE0pJwAefh4Cu57JfPHlzqHEg2vuGi2DCIrlvQO9gji9GHRlLjh32?=
 =?us-ascii?Q?+kuuWySB6j/aujvMxjpdj8JQTXwS7x8WKa3NN5SWAXnc7wBXnKaWOVriJSoQ?=
 =?us-ascii?Q?L8RDtBE4LHySFnGSpK66381Ndga2WB771r6h3q1ocYms9t+YwhxDdWYvSPX2?=
 =?us-ascii?Q?O30Hjmr8cUzYMrg3Dl3QuJJxlSOi8l9cxnR14C2208ngr1bAegNnOEbL3vXW?=
 =?us-ascii?Q?lvuT+dYnUfXuzRfB1y0STvslpLmLgAUiS7jBSKkW5M+zuXW5KXQpHmNQlnOp?=
 =?us-ascii?Q?6hFnzTylD2DoSFzCehRf0uA4niukUW+0JTSbpDyW2NrVv/P/RCUh2zOqxndb?=
 =?us-ascii?Q?KdCXPxsSxB3h161ODgSUsWLZO9R//gMtwuKToL5UYAjIWaRcVLIf17/Ism+o?=
 =?us-ascii?Q?xO5vSQH0CJyFPS8BFUmFQN+O4edF9hyy+uFM4Eke2fHdRnLKlnriKzgmwVr/?=
 =?us-ascii?Q?CXwacMFphxpbc6zF3N8B9d6bB51MqkQi/jvg3NxGvzFBF1j5sipFItY8Z8QQ?=
 =?us-ascii?Q?iTenNAOFpyxAK/sdfLQg0BSrjTc1ZxHnM6wiA0GFUatwNZ6R+GjHfPj9hloh?=
 =?us-ascii?Q?zaI8w4dSji6xQ/m3UpIR+gBY4S+t6FXnswpl46GP0/CFi0Pni/xEAdWmskKQ?=
 =?us-ascii?Q?Mpd9iXptV1QoFUA9QQWziLGWGV6IocthzRHHidaRywTXbWU1mqjFZR1ojcsp?=
 =?us-ascii?Q?st5QZsos+MC2IgF8H+P4aVdUWY6cTdVUFVHg/FN7U6JvXWAt2kxObXff/J+W?=
 =?us-ascii?Q?fUW8+WRRPGGNabptaxbSJblnmlnvSbEkJvjmOLrFTUvyJI/1IamY/iSmcSrO?=
 =?us-ascii?Q?5AQDY6TV1OZl5rI0lKQN6CJJ43J6J7e+8e7KsEbZC7XbcdcP7LktV+t4J/dn?=
 =?us-ascii?Q?tuqVNpAX2xrS/qwH/lvWHysptRzszng=3D?=
X-Exchange-RoutingPolicyChecked: XJtbAp2vH9zsE+mzLv7BBwEk5roZcFzPmJPzLULX6QO3FXl7LRzcEAqDHVDgG2UH+INOAIKue/zMle+4ja6P8nwRtb8ZfIVaBe0UueTXCpK0AKUfgTmfmvtlm8EPraT0Nw8uAdnO0bTMhgftuY58diIf53vm0bRS3B4vcvx6hsExu/orKX5xR/Y6NbtVJT7Iqc3GrkgsoK2gdlyKi23NaAPbHCdjuEliKL+lhXdbgDxYK+NQM9k/zEvlwW10XDBAq4a7N8sgnbrHTVPLQYnAi6MbdOP4qaRONKdGlEixxYeTmUBObILMFaURMZJq2dc3GVK/KihjnPdIpHuF2RegUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81456590-aabd-4bd2-5817-08df1e31abd4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:57:59.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dgR+OUlO4P0tfLgCzm+pElhUHGQGx6kLuYvSxcJhg2i1WWKEOgARk1+5wB1HSQIhXFpkHIBINfDWq0DSJA5H3Vn83A+d9X8xpxIf1o0wgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB057924
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

On Tue, Sep 29, 2026 at 06:42:08AM -0700, Stephen Hemminger wrote:
> On Tue, 29 Sep 2026 09:39:36 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Mon, Sep 28, 2026 at 04:15:58PM -0700, Stephen Hemminger wrote:
> > > Many parts of DPDK will fail with divide by zero and
> > > other errors if the initialization logic ever TSC hz was ever
> > > determined to be zero. This might happen on a broken get_tsc_freq_arch()
> > > or bad emulation in QEMU.
> > > 
> > > If TSC hz is zero, log the error and propagate back to
> > > fail rte_eal_init().
> > > 
> > > This fix doesn't need to go to stable since it is a purely
> > > theoretical problem; we aren't getting divide by zero reports
> > > from users.
> > >   
> > 
> > How was this discovered? Is there a coverity issue id, or was it just AI
> > discovered?
> 
> It was part of review of pcapng timestamp calculation.
> Kind of funny, AI spotted overflow (which I verified) in the code which
> it had previously helped write.  Then it was asking it self,
> "what if TSC was 0". I didn't see how this could happen unless QEMU
> had some broken CPU emulation.
> 
> To me it seemed best to fail fast and die in a safer manner.
>
Agreed. You can add my ack, either for this version or a new version with
the "set" function renamed as I suggest.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
