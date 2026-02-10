Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B5AEB26F5
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1099C402CE;
	Tue, 10 Feb 2026 19:32:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 51CBE402B0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770748324; x=1802284324;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KKIYwlsGmvHOPvrW2v5mpGjKdBn+im7OtQFZlz1B87Q=;
 b=cG8WSEfNHMFjMsrk4kqsqeH448TcfAC1tg+K6txGEzU3EFvj5H4VVIkV
 VrxkvGKCLTgJQe64p1I0t95/F4irDSYnDfIRuyfPzd+1IRcfs5qzd46HU
 f3XgmXwS8zgAzRJHvla19bycNxvakk4GzbJTLjXkqd103uMgX1o83Pv4/
 RZym3kg3obP0AMaWsj2YJeyHFXVr38os5jcMc61Odj/6ZFE/CuBWXZys2
 qled6RGndNwD1cqv1dNMen9Yycrq+l8l8BtHOTNbGjj5rUlGOxt6WH/sP
 JOmcNeNJVgNi6KoHMhB6ZjuFU8cgre3AQbqHIPXqpUKZVtv+B2mMdX2Id w==;
X-CSE-ConnectionGUID: fnobrFjtSKq6mzQjX5S3og==
X-CSE-MsgGUID: r5iA/WAnRhKqdl93EwVw2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="74487703"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="74487703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:32:02 -0800
X-CSE-ConnectionGUID: ZGGKba9SRvaOevEyFIsXnw==
X-CSE-MsgGUID: uWpxqhcDQFiTLHj2L2CRdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216504108"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:32:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:32:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 10:32:01 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:32:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWA2uacjGX6VyKeeugDQMpjX3PP4Dw3coyJ+r55ckpbpQcSlaYQpobE8CIXltJO9+VJjaZDDTmhxtk9ToD2tT+cqx8yNNE/Op3UAvT6uI5nU+JEbvv+maaIf0U1QNWnyHHxcLSMkPRO+duFUPMPpxuvV42tnJ4aki/WN9/Q+uB8BNYzv2nNncicW8xCbE24piqKe/FQTjlkE+IMevxzuIHAGvo5qnb/g8cUTAGca4noE9JNyi9xQa2L2C320UBi1j5tGLl9QIOTlfiXYGfVDcCexNB9acpcRa5YErxvrA+FsJhEjkZ2eBUmS17hLvU4rL7kw5FsTdKUkW6LOt8SIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Zwn6nksA/1A7Rzr48yCLk1aJVkKq7+LuICPswUM+4=;
 b=AKOuFmaGfe9BR2y8T/681a1Vg6+NG6o4rff9Dz4f4TPL3E7WetpNmvWo7DstQHAg/tnT7QkVygiybC13kPCuXV0y4z5AjEnshzcnZJRC/GHeb7kXPHL/8Pe754OkXmpQGBzt+AcDfio5IrwJ5nB1Z3tRVi1ivcTSqKq7XFGCdUCBD7U53k0CqpwAn19YaGDPApKpeC13bsK/qVB80Yp79bN19pVRzlj6HzFkvl9xHe/UQqdNIzmj2gut0zYeT53ZPz9S/TzjUh1v9BUHNMGc1OXMhe6OTwzYtCzgvWtxkYBzjvF13yy2gq4RbPG3R1VfkFCVGpxJzr1Ca/9Ql2F4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 18:31:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:31:56 +0000
Date: Tue, 10 Feb 2026 18:31:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 15/35] net/iavf: use common scalar Tx function
Message-ID: <aYt5l7NTHvKHStNH@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-16-bruce.richardson@intel.com>
 <c6f38b5e-f3c9-40e3-aa6e-bf2f620b02bc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6f38b5e-f3c9-40e3-aa6e-bf2f620b02bc@intel.com>
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cff4eab-4ba9-49ce-9a76-08de68d2ab41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95GAffte+o1KuAjFvb7/K+pCoquVR6tau94w/xfSb506xa+v4LZUD7Pw8SLL?=
 =?us-ascii?Q?F/O/V7haj5z02UA9s02Lm2n/xuSvbGcBMhjFpqhYq7U+MICwgUVEn895mhQI?=
 =?us-ascii?Q?BpUtlEhz7txIi0gaDIefgart1YDlzzJjWSgPnUsfg1bIkkHBhdPm7IpVxMRC?=
 =?us-ascii?Q?THOUAPO+vN4fXdcmNMG6jWTMAlZFdDJf8AayYqIyNI00cuGIILayExAhysX7?=
 =?us-ascii?Q?HVHvgxfNzZ0eDjBqRjVUyIq5F8lJ9e9b+ewQM8qKnD1MCUU7Sb/kSUZmaG1d?=
 =?us-ascii?Q?lSG/ICS5bBNgthB+qt3I9c/CW7WLiGuDs9c5V/IoDhnDhU+ZdIhroDSYOXiU?=
 =?us-ascii?Q?8Xkpz91A6w6CNhe9e2ZSkFjs2eqnIa4AXqTz4T2vHkocgwjbuIC4edYSvKfM?=
 =?us-ascii?Q?tbuqOawVdSMwVyaSdGyXw4JaD/FJ3wWbCmkrBDASelZ1IERGwBZqjJzEuL72?=
 =?us-ascii?Q?De0065+daNJuL1lERS8rBFHvEueU9wAEp2XCEUJUyZl1NvOzVZylqrOmomTO?=
 =?us-ascii?Q?ASOq+hvGbKHmjbJtb19H2TUMVWC4IkMSjhFTppcGMOcXpf6D1C77f7ukn6/L?=
 =?us-ascii?Q?ztarR2ohwASPE+/cfstQqHwrswe7CImhQ+y2qC9tpOj1UxX9RvyAelPJgWmb?=
 =?us-ascii?Q?TqxBUYbuH0I5dUFYdC0u5oMtqICkgph2eOCzF5hRomovNpspfS/4aa0wMM24?=
 =?us-ascii?Q?daaTSFBSIBzz5oVgNENxn6YD0v2LGPIFxvXlk6frCdJnj0OYc+L8VNl8GIkF?=
 =?us-ascii?Q?iVET8UwwVwWhWsi9j0KwDGHh/JKkpFt2SEBxgM7RM0OdOyTL4N9/LYZK2iE5?=
 =?us-ascii?Q?CzZ1sRKQ+HxETVPNrIceOP1cg1ZECDWNagB+zJnRDvbjt8Ajya9kwyoprFxz?=
 =?us-ascii?Q?jmRSV8G87FfOqt126CQaN8T2vmgQCxsQgXvsoL/5vzHrXSKTsi9RjtMDJ06G?=
 =?us-ascii?Q?CRiG8zCfJQRU0XRi1GEup5rmY+xTibzp+FX72kZ0mDnlYJLqMAGQBbOlNCuQ?=
 =?us-ascii?Q?ZteVTx+F4j20Ho7ZEPr12xbbAorSfInmnu6N7LxUMq1KGD6nAVQoJ47XLqZb?=
 =?us-ascii?Q?j83BMKih7ljC4uHWV1bA5dbQs1omuu9mYyKyXOE51LMt8k63g9yfbJnYu7yW?=
 =?us-ascii?Q?HR7BConZMosMUyZNcXEHqDsvNMO+1eOf+emFow80DW5NlMAZ2RP2raTSJ/XQ?=
 =?us-ascii?Q?F/6k9vYBie4rX3gDVgFinr3zAHsLOsDTGXQM2ozxdP6+shUdESQeMFCvOJKG?=
 =?us-ascii?Q?tqaW7KX5YXuVquwQOygBEDQeREjsxINWwiLrraDXtJ+RblMosmsYwtQYhmv8?=
 =?us-ascii?Q?f2KPhYVCW8SCz1vn3bYr7hP0aixBflMsAhCd+VO5ctLReCavGx86d2HsqOWg?=
 =?us-ascii?Q?40erEHB86Cx0gxWQeVz9kuFcM2SBZgV+dAvLvUqRArVkAQ19EYRfHdx7eT+z?=
 =?us-ascii?Q?87+6tYpIiHn6imDv/GuqI3E/fYHOVD7g9qEqBu54svj2mf5gBovpCAGQy5SE?=
 =?us-ascii?Q?7HTdFiO9KawK37LVBanSYlPb2J6NoNyrxtS6q/nG8/eaykKbHYqXxjYkcDd6?=
 =?us-ascii?Q?C/CEK90ANO5W1ydm8y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AXjmVBr/ICGbC/vjpezmafxrNeU+i4jSd8NCZDdFVeem1K9AdnR6v/La5/nG?=
 =?us-ascii?Q?zMd5kilVKhhBynMLFDnKmrr6LygHct70I6yZbZyWr3xFto1V9aOxeKZGR/fM?=
 =?us-ascii?Q?liQgdLWgYr1rWYCX/LjUvvs73x1mkQ997eNLFIBJmNAn9BIKeAt0gcUMWL0V?=
 =?us-ascii?Q?3F+OXW51zIf5EriMTebw2xeGVPHweCyIGfD7Q38B2zDVmRqr1Wb2aB8+sabL?=
 =?us-ascii?Q?v28+3+d57rk+Kf5llGz4jNpw20SBQZDPmn3C4skhI1nCwXtJn04sqTuB9YMN?=
 =?us-ascii?Q?+aOYLw4YxhRLJI82XFnOSMeeRLL1DhBKxPQ3tCl8uFEVj699iCMd1I0gxUHd?=
 =?us-ascii?Q?XcpOPbxRa+eSNtwvswr5PV8TMbJLTsVtVnalIoN14hXPx+U9JPybecb5twyE?=
 =?us-ascii?Q?OuspyZmrxu3WPefLiOeOqrChTb7RmvbjmHPCCPema1ItnPKWX3c1VZhYVQAQ?=
 =?us-ascii?Q?PpPO/NjGtI9GdOsZUVSGCvlE3Ppjv2G7+D2dcizTX9cZdVLZPDjYIYPVn1d3?=
 =?us-ascii?Q?pa2wLflaFrRw+3e9hPvjC3ymFLkbkmyXpk/NtB9FwWcDyhBqXa7nxBE1ootO?=
 =?us-ascii?Q?8xCPc6sWfQIf53c7Rm2xFYIN/PFlG8x+7Th6lWrC/sKTeS11pdhlZCikepIJ?=
 =?us-ascii?Q?y0i2T7klrX1hUiErPNJYPlGbaXeoWBsL3uAH7EPgzvjarjKNT90ibAO4bBmp?=
 =?us-ascii?Q?pcXiV2wjCr3IITuACKE3UvQMX5mAttMfZdnt/4MVXQ4hGmz+N3txtmLJEH7w?=
 =?us-ascii?Q?lVwv6KsoWDfIankTal8ImM9P1n2xoSA5G7+s2m6b5+DkoAwZRD4LvkPWOj1v?=
 =?us-ascii?Q?aNtMAR4/2OqYaZa6KbBhC4AkpfyGRrrDVMvZX/u8YsrAe9zP9Rww0Ue+S17j?=
 =?us-ascii?Q?JMPI6c+xJIBe7g6gwzFzAExxXgZRot15yeMtp6bty2H/ciHWGEdDnVIrOBPS?=
 =?us-ascii?Q?YgOkvndqRv8ObP+SBTlwtR+fdh6iBTp0FTRTtQmLhJHvKWr0OGWtUP7qHuNN?=
 =?us-ascii?Q?sMOqz8DJchsoi/M1NFQpL1C768sP/P68DWysWIKqTKKo9CSPzjOhxSa1Ess7?=
 =?us-ascii?Q?sILZeCC/x5CpSOFljgto6i9CoWDxclF8bKwMQ1+5tX5SW0wlpQpeR7WwIrER?=
 =?us-ascii?Q?uMJJlcE8NjFVcgMko1nH0CW8PTiq5dMWXZV97CV2XcfHMLh2LB+x/6N2Zif3?=
 =?us-ascii?Q?Aj3018be+MOzd1ygBD4i1HM/k5n+KOBDanlUHvnntrxipNo1DLh832w2ME4x?=
 =?us-ascii?Q?pPuYdP7PZMd9Ce+o+PLxcVIBj5gwd5MzPSFXmdpIhVgdMxqiWlmtLuBPJroB?=
 =?us-ascii?Q?lp6y6RHUg+7matXdFiWCnOeVKkXpmDtkOZNem43cOiXiIYpXJT0F/JkgkT3/?=
 =?us-ascii?Q?TodytuCE2CiB7pPntck+D5M7CMNEkSuHHEIN9HwbX95m2SAYF4EyEDCR6Ird?=
 =?us-ascii?Q?IN8qaDJ8KYGoormCGbXx2sx3rVu9CKC595pG55gxvJA/vnE9/9WHJnUODgEF?=
 =?us-ascii?Q?nTr5Gisk1zCV5PrbC6HLBtNjJtfashR5egB4PG947RCWORW75c1iw1Uea8sS?=
 =?us-ascii?Q?1s4s350UPXbuWJAG0l0EV+FZNcPhwgjwJl3UbQAI78uR+e1vkubOfJIoChrR?=
 =?us-ascii?Q?Vh922ZW4Rc3dkf+dN4SDqifv8FtCfrZkoeKEDQEnDOEP7zLj0HoUVOiU/dNs?=
 =?us-ascii?Q?URPSz0DGnl5gVwGeaCsZuHINwYD2ZQtO4GZcR2tPpbfbxjusO3q+7OBSkcy+?=
 =?us-ascii?Q?SDhs1QyRWrA+xhxXe9SROVoWQqhxboA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff4eab-4ba9-49ce-9a76-08de68d2ab41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:31:56.0277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHs4l4S5/7U/rFkqo5ERO2RGTOC7qjxcfn+ABU+IOkpqk7Ih21BXxZJzPjPDReuXorbhbNtdf8SKs+EWw2sua+p70m2ZndY0MQHPskpEmsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
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

On Tue, Feb 10, 2026 at 02:27:18PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Now that the common scalar Tx function has all necessary hooks for the
> > features supported by the iavf driver, use the common function to avoid
> > duplicated code.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> 
> > +		}
> > -		return;
> > +		/* TSO segmentation field */
> > +		tlen = iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd,
> > +							     mbuf, ipsec_md);
> > +		(void)tlen; /* Suppress unused variable warning */
> 
> RTE_SET_USED?
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
since tlen is a local variable and is only used for the return value here,
I can just get rid of it, saving having to pretend it's actually being used..
