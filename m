Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4194F10F995F
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CEEB402EB;
	Wed,  8 Apr 2026 18:41:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id D497B4013F;
 Wed,  8 Apr 2026 18:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775666484; x=1807202484;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=V/3y1lb8kXpqlE0mC2upeyBo/GiWdZTcTTdFyvsLMxw=;
 b=OSgagSVdEsqRlbovQjy27CHUBMfjxsJe/12F56bTwQ6aj5J3ETIkRV3A
 oBEOuHCA//BSWRHMol0Q47AEP161SWXX0sP2hDQ9/0TVq92RdL24Z51Jd
 711lTBk0eQ0SwgKMbubIFHK61MHuPd6NZVmKGliMlXzi0Pq1Z2+H1N2i2
 4sdbi3x1EEr5SpYClOqPUE8l1lDUhO+ggLEy0HYKqueMKupXTIngJka4s
 KIJUueBaoVr+OIRdD8lZ0zPkMuqJpYrUXVCDMw5odYiPyERrxTWAhZLCF
 SyGxZGKSJ8eCQryMOMGLShjbtO49QMFkTxY8alrRR0ISWYqGjM8piz1Ia w==;
X-CSE-ConnectionGUID: VEXIU6T1Q+Oji3eDXSPl/A==
X-CSE-MsgGUID: i6suf0VoT9q7iFfntOsf+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76672799"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76672799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:41:22 -0700
X-CSE-ConnectionGUID: VsZBK3g3SQeO4rFviiOkfA==
X-CSE-MsgGUID: HJ58naYvQGyY88j+YQoWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251667171"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:41:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:41:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:41:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+ZosyUZwOMKq0xwsL1znWcyFtFuSzX6++5+HqCm/e+416uFTJRYo5v0StswK708O8Oyf4uHbIVLrlKTLZz8HwubuP0aDHWmunfSt1ljlW5aSTe5pG/HFK6I0PqkCXmn/T/lZHV+kkZjRQc0JMyZwoyGctlnKSGFuCa+ixoQFkaQP1M3i9Ej0kjYOfca3lf+0/iCwi9CMKjYdL0k1mWjQEDRiWHNND4wB3SvmhB1bnxoOZz+rdBJBnlBgO8bhxjT1LISxPfUt6nrYL9f3o5HSODJz7RYVX88wZSUMZqhGQz+cyTLOOXl1aJmty357bVHKNoIv2dnKwdvb1TsWOSDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiMqUxJvbq9tjpZ6YbbEh6pGSphJNtXrd2lX7Nlsrp4=;
 b=XuTxt+rVQmBbP1clX9Vv+2YJZKS0gRrkyVVHI0WtATrvlYRahqlZHBGtoaKCXPr5NlHJDu+xO1EI7G/5oSWKzTf2yhFr1E9yYkuPMa7fxFUDc0xFA5+0o35RUT0nykthJws62lxWN2/FxLphe7N4FSQnm2Q6BgAZpAWXnKpWORPapeYi1wgi051jbbreMuFfFG0+J206HpWzQV9d3kExBD4XX4n/+haOB8NsWZ6JvPOg10lpUwo/73HJ8u708wzYsmgGaO5SXaU2exZq2PbIFA45TvPm4yXQXVU488lr4RDQHUERYctBFa8Jp3UurEfOYRhg7tLTnx1BOR4tEiEdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 16:41:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 16:41:17 +0000
Date: Wed, 8 Apr 2026 17:41:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sergei Iashin <yashin.sergey@gmail.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Qiming Yang
 <qiming.yang@intel.com>, Ting Xu <ting.xu@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: remove dead code in TM node parameter check
Message-ID: <adaFKBRr2LlAyG51@bricha3-mobl1.ger.corp.intel.com>
References: <20260407114730.1222526-1-yashin.sergey@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407114730.1222526-1-yashin.sergey@gmail.com>
X-ClientProxiedBy: DU7P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f049d21-a6a5-4d13-6b88-08de958da7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: C7Mf4HUaf+qEgYZQ+GYybcb9+otlseapcI3XXFiSkLeU10Qo48aR36dmCw3wP9E+9UE2cw4728t1BQKgL1ThZEIU/d9Y12F6belrH7kbd8kS/IUevFahPs1s10COse8tKv74ak6ATxR/F7BBZcFnW5lRPAnLjTMJ/MGBWWkp3y1x17gzU5IB+G3fG53W8HHx+lYW/AyeH5uGet5v4Gli7YiJDCkBpWUwU1pMYiItMV4OQb1VaLwxI/Cv2P+4aFpxY29vGYVL3326y2q05O0An1SJC9f1r2jM5+kG3SLdyjiRYBO41pUuwmfX5nTe0RGBPFTEQOckp71Z5+b+kqiy8cII/VwKckLOeqLfJbPlhNlp2LV4SPExjTtRKQzXZoF1i3SrkHXRQRjUCbe1EMmDZLQ7fzdIc7jn1qOEbt/mbrPO5WaA19o6faOsgxgqbfMLV/1DS1jZmdnPTk6vMrfU6Kk7XNStRQz1hZqhCLAJPTXlYSUFOtr9Lg6NndaVB/XZKsTwBTfFtJ+BUYj03Evjep0DmEN1IinsqqrJjADrHHI+VuprhQxeQwdNoM8s69FG10NaGvOpCuJmDPuTBmpCOwnZuMXjcXXCagNeXaIn7FoA54cd0Zd6FodPFQxy0PlZEqffeHwJN91kFFmmupaG/URSJk5cmbBkDrnTzhK9Ixvir4/f6C/Mn4P0RFColTjKrKzNjiS6eSUpsHOK+h1ffVdyh36RUNeejXusHWMFPwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIofBwctf3k/K068HWYh4RWU9dtHR6IQcDNzSEpbIEKf6ctyizb5UNnLqzM8?=
 =?us-ascii?Q?71IgTVsZuCaVmS97IZESDskmRhOE4uG3FyZ6lBpo8n57wq8APb9qFUcrA/+Q?=
 =?us-ascii?Q?SgtLMNK2bV+EEect0SemUSORbpwcPgvWj2iDIIt2ZQ4HmLxk7oQqya4kOt2G?=
 =?us-ascii?Q?JN4yKrYD0JqSnZAkooRQZULrEJBeu40Q05schfxJYf00sLMF8/ihy5lyFUHa?=
 =?us-ascii?Q?xd+viY2zLsYo7b2eHeOZeiXHRtaNrlRj1cAZwDp67tktYWA0IZElovVUaT5b?=
 =?us-ascii?Q?V8dQyNYuoDvv92FiexbwFNiCZzAIPIHg5GZDbncTjTof8yUplKe/mUU5kKjN?=
 =?us-ascii?Q?wKO1uasKGgptBpwUO4jDju6UJ/OOmKZ+KLvj4HvOf4L2AlSH/6Mz8BnS1/3Q?=
 =?us-ascii?Q?GJl74JbWQuR8Wnlzqmsyl3uJUTfBIvSrPcC9CNZt7yvFSH3XTJ8F1OcabceV?=
 =?us-ascii?Q?W4Cq35lmf3DJI7GOaPuS1k4cXlcgpgjqbEbHCg5Xh9nKINj6kYksIo0onxT5?=
 =?us-ascii?Q?h/F7g9dRSo0nk13AQ4jEU1ZNd12CYiTNCUxU5QmkyJXbArPuRkbVRSUQSeVv?=
 =?us-ascii?Q?YY+JmmQGsss7Mwrry8hKXzw59cHDbQjPfhcYvzJ5ip1pRGToPNPPjAeEZZv5?=
 =?us-ascii?Q?z2iqIHayf+iq36nB3PHFddC+fHNhvumEH7Anzz9SWEHlc9TEWSljBn7n2FYi?=
 =?us-ascii?Q?cwhpuakT1X0gvYjt6kF1DrIwU0JweaBdjYAB3cluem0g0UipRiHCw4xOmb/j?=
 =?us-ascii?Q?UJVlL0FNXeNjAn0i1Rgb1c4jR4zcvydjMXppxZ72Ndqp7Q00zY4h4Buq9GHs?=
 =?us-ascii?Q?fXc5LX3aGIz+LIYpVtvPuGQbuKPI1vmhlOIHAa9VoD14cJylob23QAeEmsp0?=
 =?us-ascii?Q?8FO6JAMCI4BFCZl0ZI7mAge/REcOMUmyRodP0KUE3ynDmiBgyw6U4xqDB+MQ?=
 =?us-ascii?Q?494AlZ5zHSoMF0Tk82XINhqCie34p3l78sCZta8ylQJK/XSqIQezu6cz0q07?=
 =?us-ascii?Q?AUsKwRJoFwcGWslxYJ1hrGNIovq+P26LoucuDTovslB02kllvI3r/SbNia0Z?=
 =?us-ascii?Q?qGfhHquayDScRsDbiUnluLAQ5STOECvTRi5Zn+GIwKjfrH3HLTEHlMh9rOpr?=
 =?us-ascii?Q?O+qHOpHS1whpdKOwDBVa6Vl4QMo7178zncy0Jvl5L1rRmEPIXfQV/nVYl1ki?=
 =?us-ascii?Q?SnLAHnE3pN0KAi0quoCltd3pQL5swxKDWQ5AQ57wLsgEJW8u6JMnzF4s9OOk?=
 =?us-ascii?Q?BQxKN+CupmLxaDDVMxEEDLif4sbsD+Z0zn/TFKHgiBUvhadjQzkwyliJ5bjK?=
 =?us-ascii?Q?xvXbx0b5QndtBp+VOQjMTu6A7gW2a5p7TPhAHbDmDu50FnZQhUDh996gAeG2?=
 =?us-ascii?Q?6z5LKIXgyR06yae+6tR7VioYI68BQiOQt/9PX8r1D4WTcQmZGyE0ykChm8VX?=
 =?us-ascii?Q?fzY0pQUXHyQNx0ku43mMRrArEdRhxo4zLa0qcPbv6YZhzUGs7w9b8atlsvEW?=
 =?us-ascii?Q?QtRpoS/IOO+6FhhS4CdFL23a+Qo2DFn9PDc5yU4aare7YMFxmbIYzTfZFcE2?=
 =?us-ascii?Q?vzV+RXMRjJMJywQb421WT5Ik2NOCltf6cK7IiNkXzY8VpC5nSOUN9SlbKDwP?=
 =?us-ascii?Q?A4CaWrjKcgolh/kCOS+GEplgxbbpjJgan4yhXyo3VwnUKt6f4DzFC7+/aEID?=
 =?us-ascii?Q?nsWdhaiuUW9Sxo3d24/9APRztFLKNxYwDp9a5LKgYVl4faF5/YGA3mKykh6T?=
 =?us-ascii?Q?VpGi3XAEVtSt2OVEPnJvIKHTKe6OnCE=3D?=
X-Exchange-RoutingPolicyChecked: Szzq1bqmAbDhYFVBxKE0ac8+lU094NBemrRUtTjl6fr5qyNOKYZ+gGKjQyDCkEcA7E4ULzciXUF8vs0qW5nOCMcKbBNAtSBRNusSstI25ty7MUgkGcPLRNaz4FUo5orzVkt+NWzfNBw7eTc+NoAxpKPpWYmAqj0ir/lXdoLNvv5H4gQ6pGzdqSF/TRUbBYRkRK8dIEvhYfKUslZNtID0ZyD+/8mAiEQC3I9WkWLsC5PBDEXJqS51ktCa6GFmpwYJRc7bdbCT4uMflJqcp5ynJ8tYHC0VsQFzD12P2rdXIY4OcMWzOBktIq11Bn6KBFdonPLYhp28B0He6cWvpqTeyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f049d21-a6a5-4d13-6b88-08de958da7b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:41:17.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qglYfS7mYvh7RLAjhS/CUjMBuZ6wPOLI1xRoC53xxpz9nawwYZcIWRg+D0aS1bjo6Xfta1h/Y4Bm863aWtctXG8nxCpxV8FQc1cMf71CNRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
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

On Tue, Apr 07, 2026 at 02:47:30PM +0300, Sergei Iashin wrote:
> The non-leaf validation in iavf_node_param_check() unconditionally
> rejects a non-NULL wfq_weight_mode pointer at the top of the block.
> The else-if clause below re-tests the same pointer, which is guaranteed
> NULL at that point, making the branch unreachable dead code.
> 
> Remove the dead else-if block. No functional change.
> 
> Fixes: 44d0a720a538 ("net/iavf: query QoS capabilities and set queue TC mapping")
> Cc: ting.xu@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
> ---
>  drivers/net/intel/iavf/iavf_tm.c | 6 ------
>  1 file changed, 6 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
