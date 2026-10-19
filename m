Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE0CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55D6D40615;
	Mon, 19 Oct 2026 15:27:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1203A40297;
 Mon, 19 Oct 2026 15:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792416433; x=1823952433;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9sFv/iBiwZCFidjhb3AGLpLmixy73bV83N6SrJ/uxAg=;
 b=WZDyQ0YC/RK2f0zZv+fue0bOb44RGgkcqnOTzU/lUkzQsAtdHtp1Z3pK
 oVJUMkwSM1PyJH+i4I5ezu3cgYljBp7AR4zdk7wnmhFQLRpvi9BrYMrwn
 UpFXZhlYUSUg40E7jKJA8GZbjMa1/3GqV+33vFCMr8N2QruaZOzg8Oow9
 L/AJ2X9PtqCQaH4xPh8wRgVA4mkekS/hDr6sth6h8O3V3CAgyI+BtgzTD
 NJeNY8Yu/aKeBFsmNBc8oKV0XNBW0iW/hq5XXg37cKtKAhg5Jc5LrhPb5
 zcxUlIpJiPJ9TtJA8n3OxBtFI/fSBu//XUfahZOi8FpUsqW+Xm91b7ICK A==;
X-CSE-ConnectionGUID: 6QdEZiigQ6arh1oDDqOXWA==
X-CSE-MsgGUID: 4Zlp1M+pS+aRV4W+jxT6bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="995659"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="995659"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:27:12 -0700
X-CSE-ConnectionGUID: pP1FBLjoRze9wzPzeDOFaw==
X-CSE-MsgGUID: i8tYKBuHR76yerXd24VQrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2413741"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:27:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 06:27:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 06:27:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 06:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6bVxiXBNH+HZsy4Gg2L+QHqpBQhEnr4oJ4Fda8jmmfHNCDyQFnGAc3InaGFYeqmqPOs/LJQYGjhPjvu1OXdD+z5igOJS+yejlcV1V77h/oSRvQlRrPy218jR+v7OcUFyR18I1W+8Tl5feDfOLKNojNobsctXSaGWqvaNWSiuZfoCXzDnIL8XTClTBEjsQCiv00yNZRoHakAFwJ32IewoBUM18tlEKEnDdAaGMZU8nVVLeXvFM4UTSfc3634Jhg8aCJnciNjvng+ngoHn0N5dMOhI/AM08mn7U7FNpDVqeNNk8mVvaM8hMAUQ342iGZH0w/Wl2sDsK0lJFOIvDeYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbHVQqILYVYMn8ljXGB66Hx7uRBukvGkKvwEyBGlZvY=;
 b=LbUQpznW44jcsrGf5MB1jS5t1FcwyY4ohdbAZefZ613J4OSyL78yX0Js/3ntmZu1jgZCLQv5AKfjUbcP4PdPnK6JcpuhbV+5MtTi4z6M5ghzSGFBWYdTffFNddJGXdxvcsVRBez8hnYraqDyVFuXXG6kSvncoDrbMtJWCOBB2kQQTVTW/vA8mVsHzg8kLRktPxr0U7WsSnLJ7mvfi2meqq+9VwG6T6QEE5msZ0yJaxjbgdZFD5wSS5ih7fEe0D7qbRxrL97+JUQ1sRNIlyUcvCNuDSYJsLP7SBHYcYlB18B7H6FnOaPb2zq1Cs6x2NfBeTrht8GQZjVcosYl/U/Dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 13:27:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:27:07 +0000
Date: Mon, 19 Oct 2026 14:27:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <anatoly.burakov@intel.com>, 
 <soumyadeep.hore@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix max number of descriptors for E830
Message-ID: <atYapo59J9nuxuEu@bricha3-mobl1.ger.corp.intel.com>
References: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
 <20261012161226.130164-1-sandeep.penigalapati@intel.com>
 <atYaFA6l8NqCjIqf@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atYaFA6l8NqCjIqf@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0291.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 48873007-d2e5-4ad3-f46f-08df2de4ac3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Q11tI/Szm28kKBJyeaRKbxO/7uIao6H7gmDY2Mnh74i09E4meBO4XLwzc8zYErdCX2eDx15+sFfP4aC0oHO1De5xcECHI/tHmQtCAkGiVYP6VQLriT/rtaIpfmG8QX4aJfxRlA4dd3h/HThFJMuTYSYLzqFjPNPx43eYXsnDKbJE2+51aanGjE9o6Krq1jO+04L/emzmjaE32m+NVfGOXi92PzYnF2RsidLxgA5KJSDn6lEsvnlKrB4HUfgOMy2Gc8aDv21d13FWIv+rKDVwC0Z44iuXGXPR7J4jAB4HqHx4V4av1wzk58MJjIBKCTbY8CYvzN2cq4szQ8own9gmXOudfS4XWDbPHKJHwrjGBS0XGwUyIytLdGfOEOVcowyxEFlqpZTtpy4LrBIjB0CEqzxJFD25xAvSVI3hNXht4F519JGzfJNE5wAvoQufgvOyq0VyaD0YrCGl38Qbh8oa/QEK7bMH4bZ/34Z5iOKxNdnwvbSZe29dtAncz0iUR22tQZmOz6uth90Czq1mfNhYVJEzn5TRWlC51WnEvRuOS3jcKcTuS2eRLteLhCqsDlv5cmo9cTxSPRJb/KCfS1EJjQSCv2BdpBp9VirnY3vbYX49GqUzinwdXD1sVRefJHMf2SJb155lthW8W5GAxpWc2X0S4tRaOK5QX/Re6boD8oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isZcewX4TsYoemyGTW6lNxx7qiIogJp1wVkBX36CoSC6Vw+534vLTEMgomzx?=
 =?us-ascii?Q?MV3jd0FiNmN8MXEvqxq7OxuHaJyoQVQ5GUxi4bflVkxWX2elm7lyOf92D1Ov?=
 =?us-ascii?Q?qr+69VcvoOowwMZFQc3P7Nn0DjbzUDIMBl4LiTQ7odnadkJMSamzkFWpv8bI?=
 =?us-ascii?Q?Y0tfrqZtFjYLP2C03fp6IBH5Vbp96zV8aSY4u5O4TPQZ38YDbz7HEFGX8yBJ?=
 =?us-ascii?Q?2RhDi0Br2wKGLXvjAYLmJ6xRDTGV3zjvyioV5E6FHgSQ9eVhAiHphcsY7G31?=
 =?us-ascii?Q?LYmY5wjPRV7Ks1b5hlIE3XbfCtfoPjC5RmnGTJ6hA62qOHYffnT7YM9F1EjK?=
 =?us-ascii?Q?4CRWAdveuDi9Ct9SA3AsYFS34BgF0FQpH4CG8Pq7k4S6TQHVhwnWg77JAPWR?=
 =?us-ascii?Q?pWRTMP4QkUvif412k/lYMwq6sz1EPdr7KDiVrPXgO97G8QecW8AEJUMKl5Ez?=
 =?us-ascii?Q?vl1KU9SEFzuMTM7d9ZWspw8yfzuj2Lrgs5MdlU1bA27hu695c68/afsdbPFO?=
 =?us-ascii?Q?KOE4Qpetqke0E//1WK6acpsFpMomaua4QNHvFbGV2C6vr4b9Qs1mfT1YHanQ?=
 =?us-ascii?Q?Si8egrwOdBWF6VNppzrYc6SFXUPBqFlRDvdPvSK9rZhJtcDTKIhBTgRgQVdq?=
 =?us-ascii?Q?yFF55LZzXJy3vUMZbjPUcgMca7R7O2Ce9ieHMZ7Ki3sRwo0SzFgJa6JFaTzm?=
 =?us-ascii?Q?ODeQh4LgBwTDuZ3FX7ObW6Gw4EqKcsnfskAmveLX43BOIQ31kqHYkjWJtg9F?=
 =?us-ascii?Q?5GF6989g0iXsthn5LWxdPpyAl+FhWmLj+Za3JhU8S/Fo3e9AZ5weLNgsb9qo?=
 =?us-ascii?Q?Vs8T+FIa4ghVmQAMeybQhXFRC91Artoyp934gaRRbodFFUQNHT5K6aYRhD+O?=
 =?us-ascii?Q?xuzty7Oekqs+mtcdZjdtS9d7fR+VS3TbqPENXZGZ/yMLj3/JjdtaUF+iNezI?=
 =?us-ascii?Q?+av28Oc/5wnWPlmgpcmye1puosWN8baj//ZOsFoam5Q/IEeOr1aV0s630DEg?=
 =?us-ascii?Q?tsBZe28cwgl2duR3ylgxllSDTdd4poorjAmxvXZS1n36PRGfq9bI2/tO4aBP?=
 =?us-ascii?Q?R5QRiPNr7H0za+sVoE7JgdsLLqPMEcMmGzCZBk3H2ON//8/SvCPIT0ExCQfM?=
 =?us-ascii?Q?lbWeJ9hF8KLinkeLMZKn9s3ecrNxISdA549Omt+u1uY0ADCEHoHtGS+MjQWN?=
 =?us-ascii?Q?KEFMvezPQGeLyqkWf4SCg+wNJXmEcpYXCC8d0vCayF5CUligRBLgGT+Cfs01?=
 =?us-ascii?Q?+i/Ubhi4Aha619wTvJuh4qHfCr/SdwK8gLl2Eybp7hP4M02P6mZ4C07jYDy2?=
 =?us-ascii?Q?qlItepTFN0FLZxBwCfyEhlNz+McMY4suZ0LfTme0Iu0WctQ6Eby35kvTQkQH?=
 =?us-ascii?Q?9qufhJypJnICUeU81bhdYaAP10/Y8MwcCWpfOl1iXVR0fAaN4PaxkbYkJ9qu?=
 =?us-ascii?Q?YoxiBqKDlZpte2eaBOJMzoaAgKwxuEJTzpbGLy1dRO74iD2kSDvPsTvBWHxn?=
 =?us-ascii?Q?2E0Ock1db0itByl9foN6eqgw7gVBzpISgvhPHJg4FvEJvEYMEjMiEbzKZOFq?=
 =?us-ascii?Q?rxzDcxqHAQB+0eozDSvWdD/ULkwWtvCDRR0QNFTMjZayZAp/LIUnMevwGfx1?=
 =?us-ascii?Q?JFOuXECIyj4bt6bGnhXP3gsoZwo84BUc68WaUk0wu9fX8yaICyDsHinX/0z2?=
 =?us-ascii?Q?zGi99U3snTjv8b6GOThcgtUesTmIu+Jl6wVm6WnreupgqGbJJPCLv1PxwqXC?=
 =?us-ascii?Q?sNS2Zr8QV76zJM0IbvLwgce5qzDx5Zc=3D?=
X-Exchange-RoutingPolicyChecked: kUMQ8MuUwVarotiKH9z2PePO6EIVf0q2iwZ+kgd8cbWu07ulZ2TH1/QpNH6WH8hCqj2em3v8Zf+v8fbKeKcoY3rcb56cq8A17gb17Ms4L+gU2+mnUYewuVNwx+r1XqMMcVUI8114ZbEUNcjx5umRIO5EKrICmH7Ysu+khliVmXAwKRwWk/hZyt2e6Ua32pxCoBjHbVCznPhmni7ORX/F2wZR71mVvBWh9MSJ6vj+uGt886tzMz7SknSFMC6msbHMkdTprrZjJsqA8Qgk+xzCqNOC7WzDh6F3fjX9urGg8+jsCqPmBMTDKGKth/d3nN7AoGvQ4r/L1kLYepWJjesSGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48873007-d2e5-4ad3-f46f-08df2de4ac3e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:27:07.6680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe/hpY8IKJnfl7m+9ZO+wxK8bNowmSlRvSMd/nqxzENENi70G27x4nHenheWXxeI4zEXhB5NFRMP8tFGo7kuPjJCyF7XiMcPDvYYSYr89JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
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

On Mon, Oct 19, 2026 at 02:24:36PM +0100, Bruce Richardson wrote:
> On Mon, Oct 12, 2026 at 04:12:26PM +0000, Sandeep Penigalapati wrote:
> > E830 supports at most 8096 descriptors per ring, but the advertised
> > descriptor limits and the Rx/Tx queue setup checks used the generic
> > maximum of 8160. Only the ring allocation honoured the E830 limit.
> > 
> > An application could therefore request up to 8160 descriptors on E830.
> > With Tx packet pacing enabled, the Tx time queue length (Tx descriptors
> > plus a fetch margin) overflows the 13-bit queue length field, wraps to
> > zero and triggers a Malicious Driver Detection event.
> > 
> > Use ICE_MAX_NUM_DESC_BY_MAC() for the advertised limits and the queue
> > setup checks so they match the ring allocation.
> > 
> > Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> > Cc: stable@dpdk.org
> > Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> > ---
> > v2:
> >   - No functional change. Added a short comment on the descriptor-limit
> >     defines pointing ring-facing limits at ICE_MAX_NUM_DESC_BY_MAC(),
> >     per review feedback.
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
