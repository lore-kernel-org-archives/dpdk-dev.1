Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 16:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CC4402DC;
	Mon, 21 Jul 2025 18:06:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3DF5540297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 18:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753114010; x=1784650010;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3gjhqDDMWWd6ZKZZKlT7OrQkUQGXNA15mQnORPS1x/g=;
 b=SV4BmidHYY/z3GNlMevCW7FvExCpsWEbliWrTqpTJe98XnMJlkNDbyte
 aMAGlE4NnULr2JIxZOJQTXvxI8pFisM87iqragFYhJ4iYO6t7IECN2Xkt
 Wk/iyHmQBt8/2EjcDbCeZ2/Cm6kuQuaqKIf101v4GNtndw4ut6n2yRluH
 t406rm3kLiFw3CkzMBlQOunt2lzoKQyEYDo+HgkbdeC12BwPaw260EOrs
 axRmv12r9k/Kl3k0ai9Syvu+lawOk3nizVi1J6rcqnqrR9zoUII6kr0EP
 7Vd/asXTvOSiHNdwr5jCnjLGxY8EVAr/uc3apZXaKBxjAImrc+xI9s4Bg g==;
X-CSE-ConnectionGUID: LOB6Ma6FSvWuMnIyYHvXWw==
X-CSE-MsgGUID: gxqbjZeSQhS2PSIWFWbMCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66771909"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="66771909"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 09:06:49 -0700
X-CSE-ConnectionGUID: tjOhw/NrTb+nnImO6qpHiQ==
X-CSE-MsgGUID: cmhCKR8hSVi+MfyGJ/uBWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="163103214"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 09:06:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:06:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 09:06:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mut6+KM3orZ+jed8XcEyJfaVSI51SG7Pt/izlQR2wLi0Q6LrRoKizHoe7ihrKt3nWfh22juTGUhDOajebDL9oGlMZvz9mYDiBm2tokTLv3iA35Zrfe7W08k/C5Worxs2e8Z6G4o20kV/oNb0HXUKNQCVJRrDbivLssVScjxXUlAALDHmtsL7WQOlGcfIjwQOjTqF0o5uUZ+ILnQuOP86orNPPz6UaEu1fyUbvrpZo6RBgd7qSQFIFWkWuXbLT5We8IUYj9Om+mkjWZnXB2k3pLc95q2qWXaB553pYSWRr5Av3eMo+SS6X5CaDssiXp90Mw6/9bJLB30Ep7bXbABKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDhAlQwzpjHPiBPlj+cqN4doWy7KawE+PxlMYoLgfNM=;
 b=DIhYzpUFxogKgmwajXhTBexf2nSTDQjlFJQBZfoW5WhlK2w0Q3fOZor7u8ycFdiB8O1VYJkL5G5A9pWdaqrdbeBFesKjqlo27iHOW7AdBoSih36uC8HU0sCR/OzReF7Flazh6uarvm+JrLHJv3YJ7oYceY91YISDtAKpqmQp7ruiSyqg7ndVQePNUtSCh4OwLA/YEC/tFbSQJfF5HrWIikaSb695H8tiy1fPxOTzWL5NBRpP7DDp63eL3JzXImGDscwopQIwarQPI9YU4xte7Juo9sHsbRl5ti4LE5ATEsLKO2lxmqQ4JdYUhedx1AHz/HyY9JiNKsmZl95YOAWCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:06:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 16:06:10 +0000
Date: Mon, 21 Jul 2025 17:06:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] mailmap: keep only one name per contributor
Message-ID: <aH5lbXCH4WpxJRCJ@bricha3-mobl1.ger.corp.intel.com>
References: <20250721154403.2688034-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250721154403.2688034-1-david.marchand@redhat.com>
X-ClientProxiedBy: DB8P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::38) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fc3213-8288-4757-08b7-08ddc8708237
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LaQiZISduqlB154TrmuqKASsqyayyRDIDX6fLxVrW7mb4Qrqj1zISbhYootL?=
 =?us-ascii?Q?6YoTpBAB3Fic5EmICsKU6PMYwVIlkcCcA7p8I8yoXjxAYic+nms/aQC29Vpg?=
 =?us-ascii?Q?Mf9ODuiAb3XuJPjPCd+brml3xSYTUQ8cuj/IIekwiJ/3XrFUQ9/mqVVbfqYd?=
 =?us-ascii?Q?r7TNCgl9kJJa3PrxvBbQBT84x2I13RQ7Qocpek2R7N+4PIOKR/1nbk/zVhg3?=
 =?us-ascii?Q?Q0EIXshUd0KiMpoFX4KlcCS3VEW+YlOXmABhjjrljfne5g504qf+pbt7azCV?=
 =?us-ascii?Q?/6IXUbhMw1VH71zHYaOhWV3d23UwlfxqtIwynw1wgGogCLE3zFMpms2d9iNy?=
 =?us-ascii?Q?59XV0jmGE/kcZy0x2auuwCMhf5R2vkNHUOkHMm6YI3l9gL6WdgAx7GJTJMd5?=
 =?us-ascii?Q?Cgt6GxtIyhn13g6z68GUvKRgbgzL8zEeD6DjeiyxSQ/qB92QbsmFGiQWl/Ew?=
 =?us-ascii?Q?jYxFJQQFhO1XIKqHoKC/RHqXEHLedEHX9jLiDo8cldPx+yu2wr2taF3F1iKi?=
 =?us-ascii?Q?K1kHZnA2phveNsmpP83188b3L3lPNZJE23efGdHW/zOam/fo2IAJOQVfsBry?=
 =?us-ascii?Q?1XRdJTjbLTHZYGKQqZ3rJPNSbkliZC1hHcdlz65X+1qmJyWE5/Q9JhdqSpda?=
 =?us-ascii?Q?Hjp525j7nqdzX6JH5kSNAw1maNrmy1jHKOpJhwaXUNq7b/C7ZM3xrWdxhxKH?=
 =?us-ascii?Q?Nq67WXt9hhxhpiLkz5d5DMuGZDkAnbi5QgBwb/Uze+x/eFbOeuPfhQ3wiFJ0?=
 =?us-ascii?Q?pMRULEbfGpazQ+4h6wz11jizZEgn4F+UAo36hdbkfNNSGNcwBqYe1pT1jLgv?=
 =?us-ascii?Q?Y6cj3uQNiHKftr5rwLWjMz41zF8JbDA6X2VwJmUVngfPPkNRbA4hV6mh0wnx?=
 =?us-ascii?Q?k6H1TOFYoQKChbAjatZJBacHE+lVm8mVWAo2V84lXfn9pnLMo4LjUSoznNln?=
 =?us-ascii?Q?ngfw17p9s+rjv14TJHrD9JEnru/OqZAK/heBGc6EQ3rU+eE6BDkVT6ZSIBtz?=
 =?us-ascii?Q?FDjuAVRnv2iCEXZAHgdtLxeMSpE/p6KvxMpYPrcsWzuXAm5KgiEuB3srgOaM?=
 =?us-ascii?Q?RZgV+M0KGL6Xs87gondLbgdBBM2g+uKmitcRPO5YIOSLkMElDMScCzqabwjt?=
 =?us-ascii?Q?qpzXH7Zjp3G6bgjT8+vOkY3A1mV9/LuXb2Vrngb/SVW9Re9VTZtQoDgxY5Ik?=
 =?us-ascii?Q?1zNnN2L4UrSzu5Hik5EZDuYDpEKEErl0P9RoUjIVGthLMcBag5OJA429N/4X?=
 =?us-ascii?Q?yiv/cntusbCvawIj5RmA6eJQ09AquxAdGoc1nifNaHhqZQDoUinSPRgFH0+r?=
 =?us-ascii?Q?9TUtE0Ni4bbLItBoFquPNKjb8iQwYlqHYid67TA5VhBsFtzty59u4xkGRr9G?=
 =?us-ascii?Q?X4fah4EhoJIeQrBg/9SXEhvhHB3axA7/cCLGaMDS2kZvEArsksexEwWm7DGU?=
 =?us-ascii?Q?IBpcW490lV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?281sewO5V429APOOAyXC2Fu0RMxg0qE72Yeo+DHMNlfKg393Gq8j0qOWupgK?=
 =?us-ascii?Q?URQExi+WEADfGEwQHC8oSpGoFV8Wr3V1JCLEffktYN2QoDFUmqZjrRsLVdmt?=
 =?us-ascii?Q?rXzmMQoPLbgYTgiq3HyTuUKTihGa7KDCa6aYVnwk5js48pegttN8KCjfDF0G?=
 =?us-ascii?Q?f0V5tEt14n3w0n8EHiPGWLXQLUB1iqC7DTqdqN0TGHcZeNSrzFZ9fhR5srH5?=
 =?us-ascii?Q?EjSBzpKQEqCdE5sZ/OasquM5HmIbE+5fLPUfTnYQRdt4pR8TRRwkwyfCNao+?=
 =?us-ascii?Q?vLBa31bLGCKS8LrVEINwdUX6nMzN3hi/27I6Ifk7MsJZbBYE1BzDMOQjPpJr?=
 =?us-ascii?Q?8nrWU+J+5TwQat+XMmLkPw1LS4wZLRX6VJyjpMl4WmJJmDgKg6q4GX6Uzcpf?=
 =?us-ascii?Q?J63o4CfTsOys7J7OMX83Lgap23DpW58kP9vFHw0aW+KZYG/8lP5XHzZLKTvy?=
 =?us-ascii?Q?DtimH2mebmB2XzY+Jg3yzSvSTCQ5yyfHj/ENBBetreU9HEPWlCyS51MoxrMX?=
 =?us-ascii?Q?peImVp6UEaenkKq6zWXJs4RM27cO5+kGvwG6F3uCzyeJg2XV+EvJwlx6RSgK?=
 =?us-ascii?Q?BaimEfDODbfHt1/peolbAtfhY02TLuckXocPc43rsuPzpq5Mv2FtCuQe6pmA?=
 =?us-ascii?Q?/Jy82HdvCNw1nxTonTXktIfZmcdzFLU2fQvv75SFU889jbFPlT4QVj/VePiD?=
 =?us-ascii?Q?FyBoI9k6fO4SXsY7ulRBBCNV4jk8fBRFcI6Y/8v3RddLQrnm2NkEmmf3HcW2?=
 =?us-ascii?Q?PJH9X1juiqrtLZvnGpu0qcvAW1UkC9XLKp69Kvse/zv8BD/SHN7VPxVGoiCp?=
 =?us-ascii?Q?XKr78Q9SM3iri7k5ZgwzeV84C6EXZtFfJ0xMB42DLkvXCYOlu3xRkp/XqbEm?=
 =?us-ascii?Q?OevpytO5TyIADTt9+dDcbozaNO9mM+EP00IJHL9uEP1Zl+FOdUYdfsxswar3?=
 =?us-ascii?Q?xqKwVHvVmtwxVMYcqieG4TS5O28Ump4axwdxeaGv/V4yZ+an75v4LKSFeZ/c?=
 =?us-ascii?Q?Ct77gfGj8iqybs/6STi0rPsazuSq8rTnd/FXgbjWif62xUkOg2ivCKfoAT2B?=
 =?us-ascii?Q?Yt1G4Qao/w7nOKdmyYjCSflhcEreSoJ57aL8BJYJGdBg/LqRulIwtGmhu4Yp?=
 =?us-ascii?Q?ZgsW/Y2tDjQLNIUZtR3IdR4HwancH611c7rtz/rz602BEVUxPqWD2RHKaSBy?=
 =?us-ascii?Q?6sL2H3kGYDuCUL8p7pBxV1XjfWXnvdZshnNVRpo/ETmCwaxuO6HDf+OBc+5N?=
 =?us-ascii?Q?dK7nTxuJddVAgywVL9fIri7r4Yb7BAZkSJL/upeysbcoofQuTBwaNBCBrMmJ?=
 =?us-ascii?Q?Uyqs+XFFFDhtpurdn4693QmotFLyfslK+gNe6TbF1mCLWMp86l+pNmmEtZPN?=
 =?us-ascii?Q?4MnDatC2hxUU15CsNwUvbN9adu3rgGff+SJi3Q9OLIWTGm6pl984dRZTzBD0?=
 =?us-ascii?Q?gvWUnVpUmFQngsBicQUa/QzUJifmbSMLf3Fp3zzpBiqvTVMRlmmSK+1S078u?=
 =?us-ascii?Q?AFLjtHhZ8gUvtVXmgtTXnes7m6TZRf/8dlKYF7NJSpjm6t1wCb9LR4HK1x3C?=
 =?us-ascii?Q?5asKsIChZ3158paYQmDx5Yg3ZZZDvTl62LkkJdcP7/fRivBMOFo0v7GJaend?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fc3213-8288-4757-08b7-08ddc8708237
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:06:10.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+bZ88AW/5uMTxIqmz1FIOKIOeybYRT2vQZsjKUOJmxiE7DUypq+RJ2upjcKxzvEIyljZFcMGGD/76XgPIpXjA/8J5yxH2SawPp+L0PkVg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
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

On Mon, Jul 21, 2025 at 05:44:01PM +0200, David Marchand wrote:
> Some duplicates have slipped in the mailmap file.
> Clean this up.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .mailmap | 4 ----
>  1 file changed, 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
