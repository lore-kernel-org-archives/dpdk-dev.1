Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C326E81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:15:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 778F840608;
	Mon, 16 Feb 2026 18:15:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9580640289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262137; x=1802798137;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1A3DBogPqT+JKhjONiaQey2kCrv6BGa1oi6/EOkgGeQ=;
 b=kXTUfyYrhEvgmUHOfG9bDv6BtYWBOPTmnfFgB6XHtBBe3lAd/mlkIy3u
 fh/wE5O+6G8T7H5omo0nQpnJCGhdr7oFwIR8OYvrxlPO5C98cmTDahEWY
 Gw5oslb608GX+lvMhh1BwNjykpYB2WiriDg694FbnAWJES8LfxV/PEzZt
 cYU3WXqnTZFoRh5Imi9jYgvUXfSwN5qni1c5ZE3+q4i0LeUBnLMOzSL5m
 4f8lVAySWT6bhVySPThkSd+hbjvWEXrAbI47TF4xBNr2ceRyqV2EWQOG0
 bYJZ4NgZLwBYE4TFTUNuvbjkVgVnIbCma7YGSvak5G/C8FH6FO648Pqtz g==;
X-CSE-ConnectionGUID: Hp+sxXHRRm2RFtngm2iWEg==
X-CSE-MsgGUID: 2U+yRsjPQtSUa8UNg7ZrOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72412349"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72412349"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:36 -0800
X-CSE-ConnectionGUID: DOgNON0nRUiBfwruSK5LtA==
X-CSE-MsgGUID: rlgA+CelTc6Xrzwlti+4xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="242753882"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:15:36 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2ZyLYTqQtdtchJeeM8niF+60rshoUPBpptuXDhmfmbx9M2mS6GIbypJUZAxcknMmiZn8aALKGMLikgUrypMAjKUgRpCMMQFgqXfDXZ2QUpYrviueOO6L0+8VMlqVWOnut7rsBJ/womysW+TeNtfC35JVDnacLds7Xr49abPljR/UTBH0nfSdGV/gi2bQSoj4qtAsPr+Xl+96NB1UO3r6RS510995eDBkjLwYRg6+Gg0BBuZ65YO1WignFCQ2Ifa5qHoKAogk5eHiGq91AI0yA9BCJ2nLWjpvG/p8wpxWPh+77n9rJOR1XJrTrEHfdoT+sDwGll/5kFMhooYw+r+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW871NV0mPhJlT7HpfhN5eCL/A2d84TnuUdcoX8cyBg=;
 b=lEG+OFbiMbIY8hg0XrCkhpYR/HDvDRtAm6iwmDVg0pAhpPqxflHbC3Ft/0xN2E3sXDjbKqWUiTNSsxoZTKVl4RnTblXPKWcYp913be5Z1n02w3s4tgTMegsNA2KHNG/IOjlQ0b5Wl3GBswPbKm2E5iWJ8uBk6rp+/UhJ1fZimREqklijpcrZj5ZGmBlPbCUH32Vr6ywybuGcnxhc/yAlOENrHLOADKEzxL/4FKP3Tm8MmPDd73DyFvFxpWCxdaziiQhGFdMRjBBAxNPLEFVZAhgV9eVpYyYCSwEiiU771vMKcy7FbjWGoP4AJVm9JhuwSS/GLJFk+kwbqKagNlzCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:15:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:15:34 +0000
Date: Mon, 16 Feb 2026 17:15:29 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 14/27] net/i40e: avoid rte malloc in DDP package
 handling
Message-ID: <aZNQsQgy3gqhK_Zu@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <827a17508d3a35bf5dd6a02f3431c2014acfdc79.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <827a17508d3a35bf5dd6a02f3431c2014acfdc79.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: a304710c-46ed-4f7d-5f67-08de6d7efedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k259pSq7NtfCWxL49Qi7VR07gf19yBDROHLKj/QRZNfkvClRupZ858Hf/dkx?=
 =?us-ascii?Q?GHeDqICXnbus+VMICCGqd+frKvTbvMgn0msljCcIIc1UoaY/DloGPuIhTtOl?=
 =?us-ascii?Q?AN7i3eOYVonVzaY+BpifKH5e3sF+MoyXnIk6kAY+woy3TS/1WZB9WXWVLju6?=
 =?us-ascii?Q?lmN304fzsfbpnPl1VZkVqDmWhc7abXjalB4GX5Gfch0tYLQaeckdbn1n8iB0?=
 =?us-ascii?Q?GEgCqfCm8ix00cuZ+Y5wSdfD09JWVhx/gvxQpfaZm0KR3X89IPsyFcU4/dcx?=
 =?us-ascii?Q?4DGk6E8z/2TPzm0YUwT+SPfxahWm7siV6XqIZ2bfyFfxvky29guioHl0r8ZF?=
 =?us-ascii?Q?VloOBHfldOkL+TghOaSPPb9TEU5DK6ODCQ9RLJHy2I0tlJowgOo7j74/1NoA?=
 =?us-ascii?Q?OxHhr1FchhStCjX3xy71i4M0Raz2GPWdvfTyNEazT/flPpKeG9oE+jG7d5hn?=
 =?us-ascii?Q?+3vCIsystVY4t1t6rAm1N5Zy0h17RyybXO6sKZIVQfxGKNTWkEy4j+5ypcQx?=
 =?us-ascii?Q?cUqqy1IpIIb9tSI85Jq7MhKIcrl2FnwHA9E8Vv5ejopXtKiwKtLYP2r5cMPP?=
 =?us-ascii?Q?Wkiw2TZZww2cAyzs55z0EN+aQG7Xi+m6g2pM4NjHc6oNFuzpFTY7u6BjDtW6?=
 =?us-ascii?Q?SlhevkdTr+yosyvzCqvjRTbUO3lHiOtI/R3lEux8CyoCjpd/E9dPPTWW8Qud?=
 =?us-ascii?Q?TTUInbzOaSg/ZObjPCX7YJwG9JelUBFRCFgrNM+LgKrGoVefC029OUuJz5c2?=
 =?us-ascii?Q?TaFuaCt+TEmQUv2Haa/yrnsA21kSWtUftevF1OhO9d/TFmW2s0GAeqZKiO1G?=
 =?us-ascii?Q?R1wO5MrGSw1dX5BP4VayPCkcPJVv7sSHFDCV6FtQ9ukTqNbu0iMoLZmfOzmE?=
 =?us-ascii?Q?qicnEJR93WL7xuXg4oLZ86hgD7si3UtCQAfJvkpro/xyq3A2Jw6rBWbZz3vw?=
 =?us-ascii?Q?dOs5IQ2vfV3pRepW4mytGkyMKXW7m90CJhfv5ePLoqz34WrRXrz36CqfUBVl?=
 =?us-ascii?Q?oUiUx3no0nWTGnkLvT4T1UxSjW/rJoJJDwboJ0RWH9hZ1u4SFqsWnfJFT7Lb?=
 =?us-ascii?Q?kDeULEuwLZB2oB/tosmqd9058hGt/KiTjON+tKuH+lJHtMKMsq+2gPyHOL4w?=
 =?us-ascii?Q?6S6DQHOrpAb8LRJ9rByKNLjcV+mD3WMcRw9Hi3TOlVYr+CvYBvZ31Vi+9S24?=
 =?us-ascii?Q?2TjcuJzZr3rWkD0SpHQexY+uLfKTBFU0asZ2qINT5ry8qWTOT501HOHZ0tur?=
 =?us-ascii?Q?DiYJDElU+u9FA3/AktmRIhbW61zo0snP3T9PnWFW7WL0FSkPcFWmJk/H3tzN?=
 =?us-ascii?Q?SDIDZ3fgdOPHiLzAgzlS+3/imCymoA+sv6vnoUPnqj5lTR3r8f52l5VgI3mL?=
 =?us-ascii?Q?Nn/lVCokg8q25rVlDYagU0fkaAN1M6+m8NuVlPx9UKkCYHGkds6kmJ7zsyST?=
 =?us-ascii?Q?YybtPOP5Kt7EleYCRouhRvTtzA1ahciTy3C+jxd0JMoXi6Y872TzQyMYH/J4?=
 =?us-ascii?Q?g5n4YlCz6kfoTwupaJLyjY6bIFAa2nh0pPwYtZIZU4TyUf76LOpBL1nzDRVE?=
 =?us-ascii?Q?py6WP+LNxN9usIR8jkc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X56k25IuiAcbM6jtPilc3rbMmHw4nvrvHiR2HvaxvfhMdffvvDSiQGLAilBp?=
 =?us-ascii?Q?bEywpX2LIUU+K/JuPehyBjYcK8CYDSgaImGX9mzlq/vmaBX4uJBlgRoEYXX5?=
 =?us-ascii?Q?ePHf3sOUtpedL/tn154pJY3RYdVLIWY8LebHl+4qc1jhRwP/Lo7xzEUWSY9d?=
 =?us-ascii?Q?Mb8uVBbc0qRE7ZTgCoPMeE559UT4rmMEnsigao99MpK0aITq+qAXS5OKrDLL?=
 =?us-ascii?Q?Wx35Oe1i7espXITgghUSoTFVtLQbzd+MeCrk1gcipCbmxr7vPkfE3SPFjYGd?=
 =?us-ascii?Q?tUwkNTzOxxXkVZPC1t/h1opleb45mSmWua88MJ/y2fUw18qCGcqs7ji2dano?=
 =?us-ascii?Q?RvUwCP7jzsqKKa21a908HjY0vVVHFNhmbxUhs7D8ps0hiIeAGQblNejcn1WP?=
 =?us-ascii?Q?eswGbBNHW9ygBVGVoANOzxoXfJABCoXChqLAjLHF1wEdCXtvx3at7Ph44Ugj?=
 =?us-ascii?Q?eCB1cslXdAsQ3kug5l9KVYnYSTmQJpLqesZs5GZ5cFF7ucnduFo4g719KI4F?=
 =?us-ascii?Q?tvJIqH786UjPjl0Fbhguy8Vw6IX3/gWSxF4Ychsa6tLz5WU9T70wztEIpPBt?=
 =?us-ascii?Q?GFPJ50mYZ8dLZqzqjb8FcZca7SA3ncsEF+bOsdki4PKsGzso5Y1Q7d2h5/8d?=
 =?us-ascii?Q?4biOTKsWDeCeDfylmICOI1fEOomCNtR9hCMg+PRm2WN4X9g9I5TtPJEd7l1T?=
 =?us-ascii?Q?lNVJjph+TZWUGzIpCz3ppOp01bpz+LPHz2PA3O905X/cQa9UkKLGwy3J/YEZ?=
 =?us-ascii?Q?y9v3qbiqC2to3T2pr575HykK0TkCFKoLugiQRBPJjyf7R3WciAEbX+xLtMzn?=
 =?us-ascii?Q?Fx3Reoy8oJe2wUe18EhtfspgDmx8PmOxNwW4haxhHxfx71CLkWFY9y/OKRc6?=
 =?us-ascii?Q?05ZvxoILR2Ze4uBn/XvlHHMF9b3rJ1dxgObPKIpi170lmyDAYXxUHtyFM2YN?=
 =?us-ascii?Q?ULQX1ceYLswnZPE0XQFcjyq0lz2GMnsDZnkkttIJw+k2/GpjPSsU3i0rWbX1?=
 =?us-ascii?Q?TrFT1K66l8PVEzluBXmYvoLDlq1zKiXbuit0j8mgzR11p+w0WT2qoCHEq/ov?=
 =?us-ascii?Q?zG3vlp7p+n5ru5q5ruY9IL8tGDwdgeM2NZDQWRBCtcj9U3fz2dxCV4BXWjjn?=
 =?us-ascii?Q?km1CWB/kJkgnTUK2RbPdMPwClhc8o7SFPNss8YShDFNhctD+Ih7Gftg6b0Nn?=
 =?us-ascii?Q?TCkkhyKnTZydFXJdaBKEAuIk+cScWDRrQ4reWJCvqjZKFNAIp8vJXphPkvEL?=
 =?us-ascii?Q?Dz4yAd77vSY+X8+FMwwly6chwRXYrRfBP/NxWUAUyXt2V25D/2JXOZK6DYSY?=
 =?us-ascii?Q?rGGdgHEHpwkkazhAsUnmW+Yb4YVAq6QjSTqw/FGi4NA7sjipR9V6B/61pxPk?=
 =?us-ascii?Q?Av12EDJl3hMUnoUvOQKRKKNF+iU8tGJp/8zPJxYDqxLhLG7YGJDrr0Ok8XaY?=
 =?us-ascii?Q?R7W5C8RHRZoGjx46v2coqSptTpyTESiz+MKGJy+BIQxjnVYy0lKXBFAj98zm?=
 =?us-ascii?Q?Gtjy5kFC3qCPQmqJI0mAYhOm2dsvb82pp9PeUMd454wZOMrUyXOujDpOj4pw?=
 =?us-ascii?Q?uWejBFwEyy75nYI4Q86r8/TXjIEUV5w7YjRRG9z132YZxVB94V+10QBuJ3PM?=
 =?us-ascii?Q?yKV1uWAdXKuUgRMstcRrhIuQAdvslLtOKe+vYvYGl/C1xweNOKazdzuoR6Qa?=
 =?us-ascii?Q?GmaY81MC5Y0TMsus9wfjLO6bbZ04RxpwQdnRYSFAp3zQBpzqmHSB5m/R82Ff?=
 =?us-ascii?Q?dowjPaqPA2mFzvqiE1gir+/ywbaBTu0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a304710c-46ed-4f7d-5f67-08de6d7efedf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:15:34.3598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67RnxNNxajyA2r+obtsGOkJIFrY3KrM1WzZ6ZrBMcmGK0nYfpzDcymBAghvQyVqfccbzXRmnn3A1knp3F4bZBEYTkb8bHRUImFtC4ltXOaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Fri, Feb 13, 2026 at 10:26:25AM +0000, Anatoly Burakov wrote:
> Currently, when processing Dynamic Driver Profile (DDP) packages and
> checking profile information, we are using rte_zmalloc followed by
> immediate rte_free. This is not needed as these buffers are only used
> temporarily, so replace it with stack-allocated structures or regular
> malloc/free where appropriate.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
As done on v3:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
