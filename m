Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C15FC83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:14:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B7B640DCA;
	Fri, 18 Jul 2025 18:14:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 38455402DB
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752855248; x=1784391248;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RV5G7iZWDdns6kO5FWawcmV14EC7nA2XLKNY/5cp8RI=;
 b=C08ofz3PrRboLtVp5NJ3+xUKe6TbCeW+6J39YzyIXGrnjcyT0KZyU7B1
 AxoGNGGZCrQXi9OVRfMuJVky1XljsN9W1pNi3GfCAe91PL+ab8wYNI0bJ
 AC21N1uW5ETdm6s58hQw18FyAYQyvQAJYfBgL1kCrKF/Uz4qYi/2ZCnzM
 Fbok9W7XONUm4qlzPlczif15c75r5jxNBw8sHnWzGatlWtXeC+IsoNTmU
 LdlKp8wncVJGudbRu+PXI6iw0HzPhtRRlxqcxrCRnMIhXii1vXfR7dYsO
 a3p2ktO5dQ+/IeUspdHqwb8bIIuTgZK78ZOFtQW9zK3pyQESsmBRx+xoj g==;
X-CSE-ConnectionGUID: YXQQFijESdSbvCp4IuFFag==
X-CSE-MsgGUID: Xj+J1GiZQt6jk+9+U8qC7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54364127"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; d="scan'208";a="54364127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 09:14:07 -0700
X-CSE-ConnectionGUID: AG6ft5wMS3e08A1PtDd3bQ==
X-CSE-MsgGUID: xZHRM0jXTkecPblp4hRy4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; d="scan'208";a="163722790"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 09:14:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 09:14:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 09:14:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 09:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am28m80+RjybnTmIAqVz/8paYppBicC055aDrBWM+BbAicyVclrK3AmpUTbQFic6rQ9L+IkstH6tBq3yp4f1ajkHc0SFNhnmdy2vEY5IRFqrOUAZRFesXu5Ix6kmY3XJpeqyzRiGt0sPJ+P3ntiolIIBUeOZ/9BBoK96B2UbfSobQqDj0wNQJbItDgWy2Czx1efIblO/2nnv7SrnV/voPX5yCb1SOMj1YCG3yTxpBlSd0r7nOG/j3H1yNE6y/k5paC+RvwyEXLJ91ZmhMcjpOtok4cg9VFMx9IFZh0wRdUAHVnl4bzFvAepqxbbJr2iyE35VmtOY315oqoSRKR5D0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMVQ309SRl04xHnEkrFTotDITtJw2RpTug6um0Ph6U8=;
 b=rEhYRb/QsvjFbK9zmfnfmbjw7UwIWVCiknseYQJUDTulbIrQV3AAKMn2qz89DkKRZXrXd9V5usS8SdDOsdVff4KKK8N9ic4AwFlAmovLA7liBwkJK9eHo8azxY7FR/0Db3iDC8bWEmcrUQUerZ4W6onK+RsOKI2JFqXVuGqzsHyRUaHlv6c5HXRwOagI/wbl3p3oRO3DZwEj0NSJheRnVcH3qhRFeRgn3YDk1yPNPgKE2GVy9r3cZQSrc3SwdfIN1MpMLEfn87lFfRg1c3NgyCLkL2m78ZEIHXg4tRnHQPi716BLhHoL8TpTL5E76nkcubjBZpHECD453rkM6IOnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 16:14:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 16:14:02 +0000
Date: Fri, 18 Jul 2025 17:13:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: deprecate some SSE paths
Message-ID: <aHpyxTGvwgF90U7g@bricha3-mobl1.ger.corp.intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
 <0c964d09-7b83-4367-b6cf-6cc05bd64967@redhat.com>
 <aHpl6L51T1in1wPW@bricha3-mobl1.ger.corp.intel.com>
 <86757a63-6464-4b7b-bd0b-fdd816b40aaa@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86757a63-6464-4b7b-bd0b-fdd816b40aaa@redhat.com>
X-ClientProxiedBy: LO4P123CA0231.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c87852-d207-41bd-dfcb-08ddc6161c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPP9pOtapKbhtos6EN8ZR4ML5zUd6bYhWB1pJ3vC9wL9EsA4VhzuEKDG/8fE?=
 =?us-ascii?Q?Akztfexyj7SoLYD01BcC8FAzN5ZfRVVn//IPcUlE6wSk7lzs5eEipSGauL1s?=
 =?us-ascii?Q?oSWqR43Wp74NMS9bMjIhzXzcnC3gqtPoiO7qFeDY/OCZFnLJMou8R3nE4/5w?=
 =?us-ascii?Q?6NxU1ksOQ8sEhO6qelTvTcvVcU5G3NzmP0i/3FCWBF+7ftckuMZAX/OP0QLR?=
 =?us-ascii?Q?QIXPxUhcnGNTIDeJrDtH8JnJOi9HSZCqXWuf5RrP+thowS/bJ/0b7+pVCSbt?=
 =?us-ascii?Q?WjJ259zGrWv+j7z26U2SCOvv48UVQYBioKBA7CZmkESLBvT5vSMxc/neoQeB?=
 =?us-ascii?Q?GlzxdI5zPODXtDGInVibnUBWwC1YhOZpstDzbvm1vDBl2VneWGMu5X8pkW6n?=
 =?us-ascii?Q?k8wzWysxZiqIv864LiL1EYWi52fncLkYa2TmrfR8krrj4aQLDJsIxe2ZcNWc?=
 =?us-ascii?Q?Z3+CbGk/ruI+VbgJRrrCpMuU4LMG7OOl+D3j+i28kat+wPh9hiXm3W+8SyTJ?=
 =?us-ascii?Q?yNEXh9wCUqMowINdzuBldspn+oTSRAKJe2MVWIGi/CmhSpcRprkK+9yfG2hJ?=
 =?us-ascii?Q?vken0RkFDoRbn2zxWOOAPe5AzpmXWogwT/mrdNGNer3ljHdLl7JuPtedIn6o?=
 =?us-ascii?Q?91YVLTXgVx8CDX/eLMelk5anBSJgoz0phdu7TlvS27J0YMu0EbRnTdAfcrms?=
 =?us-ascii?Q?nTTOcJ75Xhxl649nTMzw72iLqgdOD8TXTOwGsKXuK+AVwrnP+rgfDyq/KXdJ?=
 =?us-ascii?Q?hNKAW7qgIncqJEDJJzxLueVSRSBeBSNY1vcSmyx6WIOXt4/3xWbcwgaWmWuf?=
 =?us-ascii?Q?9/GdejpvJXzxEbH2eleNtRMHW+7mhbith7Z+IiS4pvWLMGro7IPi3WBda8Sx?=
 =?us-ascii?Q?Grb4AitQUg6ujaAgdgCuP69qxqDRn++UNqjYE57kWLr2OpgAYA3s+DpKXzb7?=
 =?us-ascii?Q?glEuVTEobFOz+2/949YOq/AYB4ipW685IS3+ldaT6r4YSohJczqJ1PzejIek?=
 =?us-ascii?Q?8nNwlFXUBAR/22ygGV1tvx303N7EPDHUyp91/VOv2jGBbhsAtmJv6UMwlQ3t?=
 =?us-ascii?Q?KWmKVbVwo2oOLiERVsWmC5I1ZSalVYlC4GWo1jI/rzKvHVpcVmQxlA0gJ8Jz?=
 =?us-ascii?Q?63Sdbo8AOOLsUJ9v+HPUnnRqLjjs9dWQVyjN1opJ+pdwxnkrVn2Ct3zKRPgy?=
 =?us-ascii?Q?cNVEWFFAw1lMz2QubXyhr4tbupxIb53fHLP2Sn4zgJYXjwJrd9T5isdNXuzR?=
 =?us-ascii?Q?b7inyPklL/EYA1VV44qoE6xMJDwSObX85fRXisvF3pRYkdz6sWyvznXyZU3B?=
 =?us-ascii?Q?gVMIYqBrJ5cD+GHj/cF/w1KmwF6x3/GKXxc0XbuCt3tKLh3F8+4pq4+i6xHp?=
 =?us-ascii?Q?RwUc4WTeFmOM9EB5BL/Q97GNyOnDfZQirZba6/lBKMT2lgXDTRYBMp2X/PjX?=
 =?us-ascii?Q?5suTGMumH6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnCuHIF/Q5Toust0Rzza4U7xBA8JdPBo7jeBBwXxUxieKruV2QnghH+t4VTi?=
 =?us-ascii?Q?OVUJIp2ljFt70g3KmIlsbhrTVY1fR0WKbEM7qzfIBvuZt+BbKnbxBEcEhSYs?=
 =?us-ascii?Q?mIpsij4FkmgLjS9i+QyvLIGwZ9AB3xsVy/Y5F3w4gNq/hVm/dkW85ebsttgE?=
 =?us-ascii?Q?AAIlDXGsf2i8pmp2pJsH1cQOQMFfa3qbKnsbCMXQ6EtGsV6kpdk6OnNVWoF+?=
 =?us-ascii?Q?oKTk9VbNbw0fPtzPuoPDECjhK+v4Cte0A2NGLfrFYMqzvRCHyIy2wNNE+Iha?=
 =?us-ascii?Q?Rwcrkeu1uOjiiI6j1bLHlvbx59GzErPFelvZQzn59rvXhuTcaDVj+RwE+0DU?=
 =?us-ascii?Q?u9JyZcQrJMJYvNA2GTEIltY9rOo1b3NX4zSOas0f3mGNouE03u7jgo4faml+?=
 =?us-ascii?Q?MMkk8PN8gdBNHCVtInaMesP7gFSqKhP3InKDwUOfooy7o8UGiEagaq6VmtQK?=
 =?us-ascii?Q?g80N1GpXSQUf/NxxUTBkVMUqUYJU3OHV0WcLdgkcPDZycgryU5Y/LypUVKrZ?=
 =?us-ascii?Q?LvnNinGegd9K1cBjyNnlT2zrTb//L+GXhSEg/reF/DqnkIFFp3z0ZVYGvbhw?=
 =?us-ascii?Q?ME38+/8b971bZjc+6cXItirKB6A7HBGW9TOOKjAn0uuKf+mU1Rx4Jvl8EDSk?=
 =?us-ascii?Q?k8DRQ9ewRlNHdPAWprMz50qKToQH2i2bbeznXeTQHVBcttmkuQDchK+pGvVS?=
 =?us-ascii?Q?q46Vb4brsZ3Hn8RthL70zhnOhB/lbpkuq1zpKSdAvAI7Du2WkZJG0j+zLe9Z?=
 =?us-ascii?Q?qwFydQGuVI2xYAPZi5jZvmT/GfH8nMDAhTJkzMeTQjjtRVhci2ot0oQUVcFi?=
 =?us-ascii?Q?ljvSZJ5lG2FTYnK6t3Q2fgKZFkICaGM6zdSJG8PeQo/kCpFxg3EGMhsEBmPe?=
 =?us-ascii?Q?49IIwD9e8ct3h+CJ1M1mFhoFGiZ50MLT2hqCRUEHVHfXb8YRVvmdPxvasxrr?=
 =?us-ascii?Q?GlLjuIvitZB7IDFprgV8qTq4RLPMbo5O2wxAqsDywDuJkxJCi5cZsLDMK7Xq?=
 =?us-ascii?Q?nLoLmhH9Wlv+qESOfs9PZkkU7k2lkkuZf+BNb4lNPtVULvJH24kenlaWacrt?=
 =?us-ascii?Q?fRSdYljKxujZAI6JNETD9QgjNEzoW96Q+GDmCRrJmJzh2AQ34yBycOrv4RNA?=
 =?us-ascii?Q?vehanKpMlKGgHnCPax6fb7eI49zWF00RsOZtuSVu90MyoyERk10jK+be6M+G?=
 =?us-ascii?Q?RvnsFTPQWh+OHjGa044ZFAEzl1VWiDFOHfZDZz9d/x/zMP0P35yE9eX+OWP7?=
 =?us-ascii?Q?4d2D9TTHydkuj4QFQElkjO6HhCaV9Vqn6tw57/0uHjA/e6NvIsPd8vZzziQG?=
 =?us-ascii?Q?XqExLIjk6tL2tav8KvXco4+1clQJ2Rt82H2teL3Zkyx1/rtBa5TnH/dpSbY5?=
 =?us-ascii?Q?iT1R9xHFmOiJmx8/EzdqqIBK90aYiT1ksGYsJdyjVxw4YLeh9tTz53gXDNdX?=
 =?us-ascii?Q?ZvrRv+NSiGOnzMZN6MZqLdcKPLbBhtU9UxIlzekad+YOqzroriBYFne4xf/T?=
 =?us-ascii?Q?sNTWiWuEFCFYdgFaqH4e3NhJdytlE2Ga8kbXVBTlMOl0EHLth2YPfcd0ku5Q?=
 =?us-ascii?Q?HHlUjREJ1w70fXReTwGAyLgs+fKXbF12jg2XqlGceAGcOuKDQY8rnr8aLIyC?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c87852-d207-41bd-dfcb-08ddc6161c5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:14:02.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vMoLu5+3nConWKwZMSN8u5fW6X62OZOh5yFRlOkf1sazxpVYmjNcduab0/gRM/x+jmkh9EV6lw6tPmNgTv+UXfZdks346JT/inzm/SdN1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
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

On Fri, Jul 18, 2025 at 05:05:45PM +0100, Kevin Traynor wrote:
> On 18/07/2025 16:19, Bruce Richardson wrote:
> > On Fri, Jul 18, 2025 at 04:03:17PM +0100, Kevin Traynor wrote:
> >> On 03/07/2025 15:31, Ciara Loftus wrote:
> >>> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> >>> drivers in the 25.11 release. Each of these drivers have faster
> >>> vector paths (AVX2 and AVX-512) which have feature parity with the
> >>> soon to be removed SSE paths. In environments where AVX2 or AVX-512
> >>> are not supported, the scalar path will still be used, which also has
> >>> feature parity.
> >>>
> >>> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com> ---
> >>> doc/guides/rel_notes/deprecation.rst | 7 +++++++ 1 file changed, 7
> >>> insertions(+)
> >>>
> >>> diff --git a/doc/guides/rel_notes/deprecation.rst
> >>> b/doc/guides/rel_notes/deprecation.rst index e2d4125308..0d020c9c1f
> >>> 100644 --- a/doc/guides/rel_notes/deprecation.rst +++
> >>> b/doc/guides/rel_notes/deprecation.rst @@ -80,6 +80,13 @@ Deprecation
> >>> Notices and the header struct ``rte_vxlan_gpe_hdr`` with the macro
> >>> ``RTE_ETHER_VXLAN_GPE_HLEN`` will be removed in DPDK 25.11.
> >>>  
> >>> +* net/intel: drivers that have an SSE vector path alongside other
> >>> vector paths, +  namely i40e, iavf and ice, will have their SSE
> >>> vector paths removed in DPDK 25.11.  +  Modern x86 systems all
> >>> support AVX2, if not AVX-512, so the SSE path is no longer +  widely
> >>> used. This change will not result in any feature loss, as the
> >>> fallback +  scalar paths which have feature parity with SSE will be
> >>> used in the cases where +  the SSE paths would have been used.  + *
> >>> ethdev: The flow API matching pattern structures, ``struct
> >>> rte_flow_item_*``, should start with relevant protocol header
> >>> structure from lib/net/.  The individual protocol header fields and
> >>> the protocol header struct
> >>
> >> I'm not aware of anyone using hardware that old and relying on SSE,
> >> but it seems a bit short notice for a patch to remove hardware
> >> support.
> >>
> >> Would it hurt much to give it a longer deprecation so anyone who needs
> >> to prepare by upgrade, or taking 25.11 with support etc. can do that ?
> >>
> > Do we think that will make a difference? After all, dropping the SSE
> > path won't break DPDK on older hardware, it will only run a bit slower
> > using the scalar path. Beyond that, it would only affect deployments
> > with new/latest DPDK on old hardware - obviously old hardware running
> > older DPDK would be unaffected.
> > 
> 
> Don't disagree, and it does seem a bit of mismatch using old hw and new
> DPDK, but I needed to spend a bit of time to try and check if this would
> impact wrt systems used, compile options, product upgrade paths etc. so
> others might be in same boat.
> 
> Alternatively, could put the deprecation now and revisit if anyone
> complains before 25.11.
> 
Sure. Let's deprecate now and if there are any objections or we decide to
postpone the removal in 25.11 that is fine.

/Bruce
