Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3CAE7E371
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 11:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A079D40296;
	Fri,  3 Apr 2026 13:08:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 94A624028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 13:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775214498; x=1806750498;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NNGWHNcL+HFpSokgPIEHhlFjSmyVHCvtVIWcnUOZfQM=;
 b=gWB9MRKOTVMU1VCc82Yv4rsPqBuNyBXEH/UTu0W42YasVWSGA6CmpwrX
 LHxDCm0Ug55TPVIPA1ezZSU++Dbn6Nb0mRfQF/8cK4N2Xe0yCaSy14rNF
 msldLevxGS/CtwHgV5I7sFhktQPVVWbaoVuMdUMQoQJ94HXyYoREDG1Nh
 ZfTXAQswfdWCM9MvV3PoE0emTg9foNzYhSIOJQ3zbkpDHkSheM4etvw1F
 bmsrj2Gr2sF3YM5U+QLw8NdAhbue2sP/koolN3F2avWUYuQYDG4RbZH/r
 SuE0PSvc84RYfGh4v8BUr6h+DNLk9ks9ki5C2HllDEGFWZh6C30A4Sscl g==;
X-CSE-ConnectionGUID: 3Vu7hwI6RyGRxvQ3Lxvgtw==
X-CSE-MsgGUID: R+fDq16RQHGdU3iEH044BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76340771"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76340771"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:08:17 -0700
X-CSE-ConnectionGUID: ojjQZTYDTkaNxQAz3iVJ+g==
X-CSE-MsgGUID: unoRyjCsQDy1YOiqPY5VmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="227101318"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 04:08:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:08:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 04:08:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 04:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw4H7K+pkcRxYzyGkxGeApWXYBCDQQNB5Og0CYed0YYsCuaVwB0jbtgYiIlRCgToGYlQ7lNRPK6zpS562alyScb8X6xBZmwUj8QgvnDucWKoESSBD2b2ZdmusfgVLvfrOB65pex9e/Xobe5hi0DW6Iy1QMyFkJBdpgcnEU05Mkn8oj2w9OwAbQADoqy4c9F8v5PE3mEZM0QyvG9C94mU7yLviHAWV1NRLyAmwM1HMDT+Z2b5f5IOrYZXF6EhYDcA8+P9Okfn/zaYU/+hfGN/l0qxRkSBKIC0GTj41eTVsCspLQx56exKhHOzSBjtw0W4uBhePO9use999ZuvT9+M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI0Bt0MiGsuCwJAqq2W1nFDz8CbZ/KxzW4sNEQZ2bqo=;
 b=fQ3c4WK6tGkQlSENQrszs40/t8qyiZEgDwurn16WQ7rOWzMCvEaGZN9IxOrIm5EnjdiWYWDATfLI6ZHunztTmbeqgZL8bKUU0sm5M+M4EGLUrcKIyLqnw/ErPVDXDAxXpTztdSq/G6mprntAE0ppXCyYDMA9xkb9uG09B/Sz5LN/dHkJrTO4aMPFooJRjDSwkJrGgWkqNNOpZSz2GoirbEbEmqAJQpREK9KNr88TkodHqROregcdHiJcu+KMe1plPHuwhcyZAom39sBIHWiNR6nutSTmU2+H6B8RqbCcKyNVrWWnMTZoMbS+3ANAEebLsHqX5Gc1pU3b7lb0n1OtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7357.namprd11.prod.outlook.com (2603:10b6:8:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 11:08:12 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 11:08:12 +0000
Date: Fri, 3 Apr 2026 12:08:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 6/8] net/iavf: respect output buffer in virtchnl
Message-ID: <ac-flzpRtnEEf_an@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
 <879969557ba349bc2e95506d6e9fe1d256927e41.1772794442.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <879969557ba349bc2e95506d6e9fe1d256927e41.1772794442.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 86afc47c-0b95-4473-3396-08de91714bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6eQ+crmCGYMd4RBXqqpbxhE/lYLRtR5FkIPXe10oneud3zy7Cz2yyo6PZrI+9XNTaDgWssKcGR4noQ6o8noejNpLUqQ1+LQtarpYq/tmJ7VeZ6yF/hivd/sziQD6+Aul3EPIN8tb+k76posC6eDgXkVkjB1lyffXABhzgvX5IN/FAsrN7lKQKVWXIGGyhD0rt6Ncbc93byfdbSGpM9QrUiWjji7wt5g5Ct9ZBd1dnrHDOl9XFIWIbvyoLl438lPRosdUrGb0804FIHYTAUWw3QTYwswY4WbfrUyNHW0rK2mnfBV5jnVWeb2iDRcMT8PUCFvG3j+wNWNyq8Ai7hasbO6U/uEdLzxjfYw9p9mFJGouNtNV73qsZ4Yzwkro4oV/ltlbcUIjkWwkmU8WKQYg2DphmfpB0DCbO7brnfiZtFFzCqe2tPKE3dxIzCYslhbaJZbLeZ3LVmKumVzQU/KxTP1hwOWhmGuNtDADA/JzJIdgf3BwNBHqLES19o7ug/eybcnTvVK66M98utG2372DS0a6ElE6qTWdmOgC5EKYdKQbleEqeA3X+77Q0cdBkDisRzg/OFV0QTvQg45mQWMcopG/i6/gTkx3eB/sPk0RiGUrBHVpOjpJLBO3RFZ+W9kTw0aKHXbGumhGxR400MlBD9gMPLPGsEcI+cM9cyuefj/1VQ9lYEZFHtQVdhNZ5AqBEKZ92N80ZA9w+2c5pmtMZEX/4M1fQS/J8yikDKIk0kQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KWTb8bj6c/0wgSJB4bVqTaWSuJAAP3BtBOPnHnWpPF7q7xrTImco1q0s3MmS?=
 =?us-ascii?Q?QTzy3NVMqA5dCWJhbXWOT6B/FA+aMWfpJgzCJDINGNRJRYUxwFaSeXvxVfyd?=
 =?us-ascii?Q?3z7z7vMQCOz+dRk7xh3QXFJn1pfkSF7uGJPggGKnZEF6+4dsTRkfsqSrVx4i?=
 =?us-ascii?Q?4p1tOEVyGoDH3+7O88KvFxp9QR5yFkj1fWGfWHMKAicsy8oS4VUtQFY4MGcX?=
 =?us-ascii?Q?YrASD5nLtvZVlcXBN4jb8zN8d9eQpQkWimUfsuBeJ1JSda5cLs7m9CbIwnRH?=
 =?us-ascii?Q?+tTKSa1Vu87lY7FaO2knww/ZWOlH07qii08K23hlHLFVUh9a1nUYDnQVPR73?=
 =?us-ascii?Q?hqOuu07nBv3Stcww+gyVKTfeTFXvlZ2s5lcrLhGpSWAotnB8cvOcNfXU0Iuy?=
 =?us-ascii?Q?yz1biFnvkhZJoVEcblw2XtD4oQ7j1UtbxkoOC9/EbkrcWJi0l2oAPjCl9fu5?=
 =?us-ascii?Q?Nkr6rG/UM61y37JfzHiqs3tGK5x2PZSUAHoB5uj6oWiqf5v5PFSoHOff7Zb0?=
 =?us-ascii?Q?xPvCF82gGaVYiiTO8qXRxkyHyVMk7wwWBUJ4bD4vmwD6xdkBgJDey5YryWeV?=
 =?us-ascii?Q?HdgAAX8UzJ5Yvq4QEdGIX1+hEuf2M+SswkB9X9jTCrMdcTe7w4cwm+2byILz?=
 =?us-ascii?Q?M+Iyh/Vn+C+Sl7yd+swE5iKrJrVlNU1sQ9pSr64GnUzrtXde0SqIxUtCwQlu?=
 =?us-ascii?Q?lk6cdl/Jgu8DNdXChHqPhQTlbzRaIT3zccmRQ6SObBYfY5TBLSmjIOF7IZG6?=
 =?us-ascii?Q?oZ5GbNxDuQ/Qf3xtjJRFOCfYWvDQfUOF2NLUWcGr2rv6KFSfBYRW/EDhZrzP?=
 =?us-ascii?Q?5mqEslJgJbO4Jpwdl1XU7LGQvaUavWp9foQC0elcN+aUO4S5S4Uz095Xyzif?=
 =?us-ascii?Q?xvGj328ycVKfaoEOC8gCfR4SHwlU/Ck1hzz6QUQ9yQXr5LCnL1fOJhIVXIm7?=
 =?us-ascii?Q?0EJoL0UT26VkkXZbG8EyHCboIzWKycXk9F+qbVp2GBD66f9/JhwuTJHlxtPM?=
 =?us-ascii?Q?KkwP7pEMgxF1VFNPtxEFBIWs6AC+C4AMtHwU+3VWN3kLsic2L5WODOMl8LqD?=
 =?us-ascii?Q?uCf7SaqaQXCjaTq23uyf75sSkyyk3x0s1ieKzQB7uBSiSUXeRxLVl54qUBzl?=
 =?us-ascii?Q?nROrmzRojaFAXV4sHrC41wzViGYhOysarvlqBPjvHc5lfNva+MKvua9Djvlo?=
 =?us-ascii?Q?cqVKrPKeukG8km0jMzXdll1FljuFy28kIvXQ7QbQ98YCshPLsUSJ6asmP7Ml?=
 =?us-ascii?Q?asQCDM1S1mTbqnaZOt0jv5dENRtbPtSJoBCJvapjvgLNgr0JxPZgN7EQ8RK8?=
 =?us-ascii?Q?uh81Nsfe5Ps9lLIWM3NZ2HF0cCgV2hcY9Kh/RLVhbVf1nMS6rRZgX8gv6D1g?=
 =?us-ascii?Q?zGcaFP3tikocIGY8Wqu/d9GNqdDw1pQnQWsboFek1rTCpgxTcM9yodjaxPnF?=
 =?us-ascii?Q?uNMOtAJ4lynUChyq7geFGtWzmyWanAQrAwjM/RBSVprucno6paEc5Zlc1AJF?=
 =?us-ascii?Q?CfVyKeep/tCp1MGuJXq8k3gwv9g7ZB8Vn2FxfD3yT4Nb6WGDDnsLk/yVxga0?=
 =?us-ascii?Q?x79dGn2IUIY4METCu/rcCd7rv8aPMSQK9/RmXUdmT2TBVGKrSvZFGrgd9UgP?=
 =?us-ascii?Q?waNQvpLffC4dAzBJ7PPJVlJYdnRXF+7Pc/ccWpBnmyb+jT19H895X0nNhkI4?=
 =?us-ascii?Q?Ef8v/t2Kom2YXIEjHoIIHmAQWKcLVMy58BUCKarW5a+Y96yS2SC0OmJwBOiY?=
 =?us-ascii?Q?GYxoPpanQpwh7tBVwml1B7ITIsoToQ0=3D?=
X-Exchange-RoutingPolicyChecked: JnfuS++ARJy4FzPV8edozIOfDklY7qpshpfQFdniK7xyMsr9Y/j/5Blo97LaBdR+z+1XfSymsoCD0BOTK0D54pLNP41oNCuxYRelePLuRu/y86NQL0XkPbLJnZta4l7tvaPj9tiTY3JLtXCpAtJeIdC8vjMd3WwziIpxDFMwNs2pw9wYWycWUyBsqgaf1keLYJiv+qwgW2pBCdjMoRf40OyCBT1muulhmzq3aly0SvUb2YAskfpsF96KWmLeDFct2RLangR9Cln/r/erO/1sZ8cjKo2pCb3OvCGL9GZZ5uyYR2oUBDxplqX4sc4FzNj//48oBxuBKLboNYDUsGs2hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86afc47c-0b95-4473-3396-08de91714bc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:08:12.3137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUab6CT/Umj8nrj6Qv1PZkmwzg568jCTp0BDSZpR+47XQqrk+b5/kjmf2i5Vs/P42X7SzLijockjcfSKirkRIMUHU9OzaAiNbPtHrmBwbqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7357
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

On Fri, Mar 06, 2026 at 10:58:22AM +0000, Anatoly Burakov wrote:
> Currently, in asynchronous case for virtchnl messages, we only store the
> command response data inside the global buffer. This is correct, because we
> populate the response in a different thread from the caller context, but
> this results in caller's `out_buffer` value being ignored. Correct it by
> populating caller's response buffer with data from response even in cases
> where the messages arrive asynchronously.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
