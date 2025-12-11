Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CD3E792
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 12:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3655C40A7A;
	Thu, 11 Dec 2025 13:02:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C412640285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 13:02:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454531; x=1796990531;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x11f2WPG3zv9YAfYwhtZpO5GLwvh1QxE09qenFMcFNM=;
 b=NlUDxfmTpA3RV4gcPX0qhIIxF1qtcKLNB2LO3W8IGv0K/q2hRjj3BmwE
 kuwp/szM78tpPob9wxQp9o2M9CaaXmIaBTkXa7ownJR6kWWYU7TMYmTxe
 yqSLAcQB2VMQG2zfRIWDPuwY8rJQwHOltJnbvZ/jMxzWpDZWV6p3ENITs
 FNG2HCMU1CyWMYPkJoAO/BlA8cD6U3ThRqnajpUQ7jiatsVehGxxvH7El
 0xEXMLvHWqm9HezlG8YpiyE54UQWcoSR99fZGVryfaVyVom46LCEB7JXJ
 lviHdnzwAyhXxZcQKQ35EBIcOuaRw9zHXE+lCEUCXClpkWQetd7qE7xb9 w==;
X-CSE-ConnectionGUID: Hk4WFMx8RtKO4J1n1ssXRg==
X-CSE-MsgGUID: /PcpOrYvSlam7/wNBEPR9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71301139"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="71301139"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:02:10 -0800
X-CSE-ConnectionGUID: Mp7XRsrJSIKzPZ+5VuwHkA==
X-CSE-MsgGUID: k7TUog76SY+n/2CGu7VmTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196049791"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 04:02:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:02:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 04:02:09 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 04:02:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhRULuzhXJ7le9EV9+U4ePTW3Dw2nKcn69pAWh2KUOHxFax9MLFjy5ZPfAfF+eKUIff82SpwMDQiVExMDxHBObE/m2FX7s3FTDCu6B2nRJw4ceHn8v7omsWb6fgQTBcF9AOaARaktm0/qHNsvXiqoMvmi1YWv38kx3Y3bw53mNTvJgVNEqDD8MJZyqa4S3lbVWMCgvORLp8F6GSfePR6Hmy7MBjmkffpxVbnO3AFxHJccf1Wy8NrjmplItrOmV4KoW3V4W12tHngEmjA1VXmQ2sCwbW5cmuJL1WaQF0NA7iqtlbiKF9KcEBaU64HiBprP5xyCSte1AudZpzOEu7jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je8t9KBQwPdmO0xyWzRb/jOtEvc0IhaCUoLbUe43X30=;
 b=vHNV25ed5dEzHd9W4DqO9HczeugJqKxN7Rdyk0qjkWo7oHrOzBCPgrULUQoxrycvstcNMKhQFhOXJ5kmJgyz6Xn52P/yE+kYXbtRjBWONMA1cKQrdvXNf31Fdl5u9pYRN4ESWP5RxU0evuBV45XHRiaQRvbqRD+r7Pn2Pk4352awPFKkZialPom8lv7BUBed2o6S40VJneyxHjlgHzRxh5PYpKetbT4sQqSqgqDI/insYciN5zwWkHOjK+KkJLhyakECCsHrJ1A5shKnN9N83/0hY8Sze6vzPX2ZrpbWxFgOcnK3GHHLdWsPOgtyzwAfKTir5XVMZflrH29PWcMtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9441.namprd11.prod.outlook.com (2603:10b6:208:569::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 12:02:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 12:02:07 +0000
Date: Thu, 11 Dec 2025 12:02:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 03/13] net/ice: use common Tx path selection infrastructure
Message-ID: <aTqyujCqtnLVdSbR@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-4-ciara.loftus@intel.com>
 <aTqxXFZzcrM3ccpk@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTqxXFZzcrM3ccpk@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a24b41-48ce-4933-27b2-08de38ad1b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e3rBflXkKLdyJmeW7mteL7txGwEgSKTIeTCKF0iXpe9cZ20xV+9SLi0fIu7y?=
 =?us-ascii?Q?zVBwl//9J6I9VurBj+rtj7Mo2FlDztGyAw5V37P+1XSsFQyZ9hT4kecIOmJD?=
 =?us-ascii?Q?ua6fn4hB0y3tw/yzKdvvwmPeQZ05cK7F4TjjmJ9xBZBif+x+YdztvpLhndDr?=
 =?us-ascii?Q?cx4i1uVt3opQoBx2RqWJ0tMzxB6czs1s6xeGoxVXZcfuyUJPt1uVuIr8UMvQ?=
 =?us-ascii?Q?DzedtLZD3MHmHynSmpuvIi0lqtENiOCqjvebsPU4QEJPfLaWgiuOQkSabKKd?=
 =?us-ascii?Q?jiULkvphkFDf0xOK0yzIxwAys/DHuX2E2w7n2ySPccjJ3K0Ho7P4DK/Kql44?=
 =?us-ascii?Q?GAeazjv6Ni2fiZ+GNtjU5kzwZ8i6nfL+Zf/r/W4nLZRePXxHrapQ5drWeRok?=
 =?us-ascii?Q?o46fc/mVqgcxg6ot+kOV35Tk5F4hbjhBmcv6aggU9aTpNEgXYSn1f9A/ce5+?=
 =?us-ascii?Q?LPvdAyYCLvhj2cKVNslRaPSTYvC5BiEdqfvN8/f17JNKE1j2DUOr/BGlvZox?=
 =?us-ascii?Q?zegQ0AasQIAPiru3qZjjgWDfwkD5IM5pH/5u9Gz9BtfPAZQMesLDRtn29mdA?=
 =?us-ascii?Q?WDp0GM34Oxs06KP7NwXayenVkMoV4U7PsganyfvlnSrJy3Qa+h6DmqvZ4oIh?=
 =?us-ascii?Q?g2Z1wmBQPQvyxs8ki3YHHOMX9m0lqr/P6wz2ayeHSJ1iZUp2kYq7FeK9pBc7?=
 =?us-ascii?Q?+S+63cOkR8QzohJDh8cmK38n/SAHlFYsPq+GSd9Zghuk8ylfwsRXaMKUAoM2?=
 =?us-ascii?Q?w10JUC92RgUctbrsEqotwLueXv+lPB/SApb2GLWAQ1jaJPOkV9+HIFO5Tx9m?=
 =?us-ascii?Q?3LOAePnR0q46Ia6rTXJDRyogwpm/Ex4ODv4GQhsD04T2kZToUxQzUuxVs9HK?=
 =?us-ascii?Q?HGw34eLuKb47T0FTms9sgfHcGYc3Xic2K5j/mCBvR/0mdafHTPaPBVV7cpuz?=
 =?us-ascii?Q?XiJm5Ozm7ZHl7LBR/D+XXKPTjxeyofCCG3h2VLTm4VxkcgfcO07zQM6UaZof?=
 =?us-ascii?Q?QVRMZvmnDYyj2/bCsXxL7CzB0DU+CBmi3e9repp73Hc/JjE+pdDRTQezzKjO?=
 =?us-ascii?Q?SdZms7dAdM0Pcw4xPRp2RrjW0e79b6reIT8S58/1CEfD66UDdUo2IUFvW7+E?=
 =?us-ascii?Q?+zwIh1gSrGi4Mj1N+/i5m95qpoYCrwnsd+q4ugeZ2ICuA2WlU6jzgcXUtGLY?=
 =?us-ascii?Q?iE+8HyMGb6y1X3P9nmhfyZ+KySJXUGm78Q01AshiB9kWMiQmHK30fqGRTYhM?=
 =?us-ascii?Q?jnn96Bfm2bufMhL+OkTXFlVR6lVAyD0VOoR7yC5+ER/E+13Py2w9fd9RYARJ?=
 =?us-ascii?Q?MGfWPLOELjQznb4SFbU/qOCYnsBzG8sZ1hFKlCc8idD3o+DJasUIhAP/Mf+Z?=
 =?us-ascii?Q?CcutjI+NL9B2CloYxECi1rPGCEXdmJcxZAAPBt7Npfkh6SsJpnmNEJ2mEZdA?=
 =?us-ascii?Q?i+1nY6nARRolmE/u9tTrWr9vSpv2WpPX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wF7IrNQngNG3tP8tcFTBIsC18Be9aC/YTRlYafclxVHwLYPg+i+XoVE95zo6?=
 =?us-ascii?Q?SAqdw7IlQEo7wFNLrptCoGrzAVt/seq67dUQ7/xUMGd2HIfrmqH5MUBtpR2B?=
 =?us-ascii?Q?0iPdF78S3cgLd56897Yle2nYHlumyJIirR3jJJ2HYASgA8pUzy1Mu1bqAB+K?=
 =?us-ascii?Q?pS3Op1sP7bwDGUJOH/K+6Zejq87WnPsC2ga5f5WuajWUH0XhjLKALy0gTxj4?=
 =?us-ascii?Q?TLvnb3PEt4a6zkj5wyA2ihlM+nzrptRxpJ0pRzWcBoMo5TSqSiJhLXzoYP1p?=
 =?us-ascii?Q?6UMwEV/k994GyNzOSjKe9Qz85sH8z/2k5M8XgFOjYP7pXGmxqjQRIOyTQBFo?=
 =?us-ascii?Q?WeDSb9Icc/nCUiNhbD6pEqoz9Brbzlpr1v5OqcRhHzH4CCzAcOraFuLxI9+g?=
 =?us-ascii?Q?K834aIV4qVOmMtwaM2U/LYE6PaTZxR1wqaVMSJ2UQa5rRYp+Fmo75jw1o6aa?=
 =?us-ascii?Q?gO+BvbkBEccBfg3Lc675bAyIolk0kYw/CDLixAxYSn0u3h63VENWRGWkM34D?=
 =?us-ascii?Q?ySRCC/hDL3oQKpv+ctNRypP1Bk9tAR7q/R1apfSkHn7wwqaY4InU6sVaEX3k?=
 =?us-ascii?Q?jJvzH7f5ta1huXwbsfhOhPH28VqXSYBfc+qtUWypyWbrM4t/XExgawLPKWvm?=
 =?us-ascii?Q?MJEhVYY3ffgmSrkpcuLS3RkeAL//8LuJ+XIUdc72ryaKTdQA0joGxhYDHSYf?=
 =?us-ascii?Q?1OG70e0BxnltVKTYONrS5TmeKYtEpbdPaIARxwqTxzRi5TeaV/x1D0Ky6E4n?=
 =?us-ascii?Q?CofnBhJk9xyNlSzAfbak32NtPa1pAW/nUBIocQ5jiVag2dK8F1+v8RIaGcMx?=
 =?us-ascii?Q?ODuHnkOgHEVKeIPc1IxsbC+3JvykCb8gCuiuaZAmXcP3I9xXMgPuk7E3fYnV?=
 =?us-ascii?Q?Gm86eq3+3izHvVl8mKo/jdhtRc5yk8k4QE4Y276lhiKSkvwNK837CXm0VIP8?=
 =?us-ascii?Q?cfyMkB2SyU1/NIOBpxW00rJSneBgttnN7gixQ/bPjyzLRLhQNTPKfBfzYk7z?=
 =?us-ascii?Q?iorz5l51sHxGhPBsIZ0v3KZ2scplt0LfubSVSWuzrsK4N/WTpaBNto6dE4zV?=
 =?us-ascii?Q?377RvPrwZwCxwtL+/YyTxKbHMD+t5GBGwxHWaQt6k9fCKJOvFE8kVnIN62go?=
 =?us-ascii?Q?UEcqr5/DF0H4oT5d03OoaoHWJdCNPsg2hdY7U3w0J5veMyQlFaTFKXZSqE5A?=
 =?us-ascii?Q?7Gh0ZMsCT41wTB3ClDLuKtaR+HtcvwcRCrwOMGPCr1mZpE/zj8MMbAPTxd8F?=
 =?us-ascii?Q?LVHVj/DLwzGfacBgraMkfzP7HdBtPkUl9pRBSf8u/ntBMztsS2y7U52QCU5B?=
 =?us-ascii?Q?ScHe79EzY1Ysbyxg+uJ2ZM1VzW8KpMYJwsrPji0Un6LqTlNFkYWMUZqdMtPf?=
 =?us-ascii?Q?7F3gWvhFWQSD6FHTPGYhe4c6YGv+y22iq5XfoUTYqkGU9jimLLsP6x595DtL?=
 =?us-ascii?Q?p/NRVG+WhbNPMMtpETTyhM3YqR8Bdl3icawU9pzlFv6k59238EPpxznD/Li0?=
 =?us-ascii?Q?/WqWqosASJRutycc/XDshHojy+YOLwTMinGbJoOXqySEfDVMEu3I2IRHhLO5?=
 =?us-ascii?Q?Nan56TfgkAparXWrWIkENsE7HsF1cgxitI9SZbLx/4hkkTSLdp2AzumUP7pN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a24b41-48ce-4933-27b2-08de38ad1b55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 12:02:07.4493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjBR+zy+9yqdAryqPNJV626v3gamfqMvsJBQ4VEy7rOJH0G+Cqdn+xHQfbKIX5fSYT+8LQ7RN1k7JmVfcVe8XgU51x1chNWxj9/4LBzb2Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9441
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

On Thu, Dec 11, 2025 at 11:56:12AM +0000, Bruce Richardson wrote:
> On Tue, Dec 09, 2025 at 11:26:42AM +0000, Ciara Loftus wrote:
> > Replace the existing complicated logic with the use of the common
> > function. Introduce a new feature "simple tx" to the common
> > infrastructure which represents whether or not a simplified transmit
> > path may be selected for the device.
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h               |  10 ++
> >  drivers/net/intel/ice/ice_rxtx.c            | 142 +++++++++-----------
> >  drivers/net/intel/ice/ice_rxtx.h            |  30 ++++-
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h |  35 +----
> >  drivers/net/intel/ice/ice_rxtx_vec_sse.c    |   6 -
> >  5 files changed, 103 insertions(+), 120 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index c6c1904ba3..3480c5e07c 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -118,15 +118,21 @@ struct ci_tx_queue {
> >  	};
> >  };
> >  
> > +struct ci_tx_path_features_extra {
> > +	bool simple_tx;
> > +};
> > +
> >  struct ci_tx_path_features {
> >  	uint32_t tx_offloads;
> >  	enum rte_vect_max_simd simd_width;
> > +	struct ci_tx_path_features_extra extra;
> 
> Two thoughts on this - do we really need a substructure here rather than
> just adding the flags directly to the path_features structure? Secondly,
> should this addition not be included in patch 1, which adds the rest of the
> support for the tx path selection logic? I don't see a reason to put half
> the infrastructure there and the rest here.
>
Just as follow-up here. I see there are more extra features added in later
drivers, but those (AFAIK) are pretty much limited to the drivers adding
them. Multiple drivers have simple scalar paths so I think this could be
part of the base infrastructure in patch one, while the others can stay
with their individual drivers.

/Bruce 
