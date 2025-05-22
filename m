Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5351EC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 09:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C3FF402DE;
	Thu, 22 May 2025 11:40:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A7B59400D5
 for <dev@dpdk.org>; Thu, 22 May 2025 11:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747906803; x=1779442803;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+rwUiuRE/z768H9b/1OBo8r0sFijlukqX7zUyupUo3w=;
 b=ieySwiVJUxoiYUtLvFz+UPtvvyCWQ5K60zovzRs4FatsxadFuWXqQjPk
 yQ5ONx3gagWg3qJZEClZPJxKF45BkbqCSQMkbnURX0e6CE+ep5buW81BN
 thmAK/AlqM1OOEFzFnvsYS+HTpxNs7AKpIC72UZ9rcWwcj1eOapHCGeKx
 r0QEgfRYz/nWYUw6MZQvUgAeUl/5i5FQtM3En7JBGPewpiCgY0qxCla80
 VQC+K1mu3jz4ua0f/jI4YxfurM142jnOWqP9WV4lLcuQCnhYuhLy5TaPo
 koCJyBHS/Jf56YK5uf/fvGSAvA0PKQvvQmwT9icyvLBH8wD/jNudcrJ/s A==;
X-CSE-ConnectionGUID: 6Temxb05QHOByf4aa8L8Dg==
X-CSE-MsgGUID: pl3q4FTNRIqFenLzOHA+FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53585072"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="53585072"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:40:01 -0700
X-CSE-ConnectionGUID: yrrDIKwcRyusq59Tlf3jWQ==
X-CSE-MsgGUID: 9rqLV9aLRsOAd139TxvXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="140370473"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:40:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 02:40:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 02:40:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 02:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WX6FzVC6crD9wGv/8qXFcC3Rhxy/WLUj+Uex6XJjevmBask5T237Bq+ziZVPsOetB6gVuMtvvKCDoqC7c7Y6FvUC1X6JGH01MIWnoHJzVQp8XgdV0lfj1FJ/IACsAVnRvoGYA1vs131w1fTEJpJD7g9Ph8myElYwz+UShrXD5/w7N22Fi8W5ebwpcUN7kiGgffgkGI0umQq3pceGNqeNIm2Wn365RWpYt+mLznlGO9eA4U+p+fXv5fF3B4blLHJomGgf8rP9dGiXXzsC/j5Wqfa4LX3FyYPten19r65pLodhy8n2nUWhKWw96V0sEBkasdQRN8PcTtdQM8fvSPQbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgAP85jqi7B4hlYl0nWp9FZVkL4XgzGauLSOmTfAvnw=;
 b=E7ttIghF7MAZe44JrDFB09o5HlKt8vB5+ZQgeDjnRxwH94IxDBWp6Pg3V5OvA1T7CkVyHqGPqFK/vF+Fuxmpw0/k6B9JQVHMpEOWe+Pc/yxDnpr/P3pBO2XfGkIE1lYHEUJKlnUuf98crvhxLM8yMGnHVYmxMGYcWRZizWwXHHOO8wncGpKvCPJqI5NBTbdPUV98Cou1m9bOQXHSow6iM4DmiqczJW2y0fpAC8uCz4VRxEHXx+yAYOd05KjVClGtVueffalrIihDqqdqIlp/9dBdmrsS8s/a0/aP8i2OGgMG6qkVd7u0nc2WeRVDddke1s0pnwMdpIjbIWluU9jm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 09:39:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 09:39:53 +0000
Date: Thu, 22 May 2025 10:39:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
CC: <dev@dpdk.org>, <pravin.pathak@intel.com>
Subject: Re: [PATCH v4] event/dlb2: consolidate AVX512 and SSE changes
Message-ID: <aC7w5cJskrB2yLcN@bricha3-mobl1.ger.corp.intel.com>
References: <20250408130048.3115648-1-tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408130048.3115648-1-tirthendu.sarkar@intel.com>
X-ClientProxiedBy: DU2PR04CA0350.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: b5536e8a-f5ca-41ce-2434-08dd99149aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SzvApZSeZVCLoOkUiCTAna9KKULZ0mSCTsodhXwgZsY5a0NFdPyTxp2yQHiA?=
 =?us-ascii?Q?hFeP8SfBA7yJR7pYQyzFTVP3ediiCehHVnWI2p+0S5SJVFP8WaTdiyt4cWvz?=
 =?us-ascii?Q?qHdq+QJA0mz2/6Z8FNbsprrWmNx1XAswfFBvNlkXoZgT/PCfLdzXLLbxx7kN?=
 =?us-ascii?Q?/IXgsAqmYRl4F3reMzUk4FITAEblqXF5D+zAswlBBB0YTj7xi9dFgwNJrIvM?=
 =?us-ascii?Q?xB6P/OTk0JcvmyeyxJJtk8wYVgaB1fF+Fq7/jkF9r1TpkJPJaJjSRrAWxXMG?=
 =?us-ascii?Q?MYo96ZWxi0AxhTWhEjRZirZbrY1kvyVDjj2Kmm/a3ah3Z2SCC92mtMAJ8GVK?=
 =?us-ascii?Q?RZrsElJoekpOWhZuHyeQLWPuxHR5UsJQkvcI8f9FWIdXLElzJgHwhBbwOwn9?=
 =?us-ascii?Q?qmscYhvr4WLHb0XFPiJkxjcLBmReS+/ZGA15qhRtXRcxesDnmwAqO+x7Grvd?=
 =?us-ascii?Q?yKAIGw3Ca77tufrzsag7EDauQosSY/MG1co6OlVg/jLwAZXHl1JQ9wH6pqfu?=
 =?us-ascii?Q?zVVl6N8a+/LcBFqVzTHcvGybNxvPcU52+mkwtuB5UBV0BVqK8UXlet+lVznT?=
 =?us-ascii?Q?taFVJYC+FXGEPdhpvLtsxm8Z06UtE30Lby7KE1zJMVFruRxrXwf1p/ijEuHk?=
 =?us-ascii?Q?FudOjaGZiPsNR2uI2IsrGgKHhzlmDQU5kwGkilBude2oyWgJDXbzHzIrHPfD?=
 =?us-ascii?Q?Orh6xOJAnSNOEEtB5ZWUOn1ucAQnbjME9Ws6UuYuyxoGmfAHVqxRCuiJ1HE3?=
 =?us-ascii?Q?M3eO6n8uPr1axtBVlEWaZaEc9lKyzHanJ7e+HNizLvSAkSbgLSPeybBdqhRs?=
 =?us-ascii?Q?Nflf2j1nNFCE4RpHIA/O0U7ag7eW38GrvmWYPtQGtVYSH1gHq4w2KNLpDO1x?=
 =?us-ascii?Q?P9uimE0ToJdK71vIXhVgb3trPDnyIkTR6vQEOvc9pIQe0+7qUt5Bct1MAMEy?=
 =?us-ascii?Q?35p3HeRLBWK151ely53I1lnDee8MBXUt6Xf89FFY1AjPSOo7w2p5jvQXgjv8?=
 =?us-ascii?Q?ow7n3z5cQrYO6uDBCJ8Gx6b0yVPg4F7vaWI5mTC5uSDKe3ko8IrFT9Wm4smn?=
 =?us-ascii?Q?YYdZq/JAyNkJigFRdRK/nI0ORw41oe/zrZtZW5oSySxV9VnnaOyYCam1YkHx?=
 =?us-ascii?Q?uh66eZwdAjlRfqEoVeUQC55AUH9fspkhiWRrwNObeAAzGzTrTCMl4Njc/O+h?=
 =?us-ascii?Q?GD7UivVeu1clY0ZT10AjtctIRtTT+zeHI5Ve1hNUfJAucu8gAxwc0JNdIgR5?=
 =?us-ascii?Q?G/m+iDv5lUIiZ9nuFF91UZB6OdGXrwQ/kWhIX1y9tkHhetv927lKwWb7XyVX?=
 =?us-ascii?Q?7SiyjZAiChjj6mSbBjqZuPjX0zuVoxkK3ogtoZyCaaCq2Td+/KFzFCQjDOuC?=
 =?us-ascii?Q?mxybnmWrDO1JQZoZfkTmO+WAH5hGOq6sz6sswjetxL3V/gJAutaS2tuLxidJ?=
 =?us-ascii?Q?1pAJclB9iZ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QH26dRwlOjH67ReIchd9GaocNho4mWfEVEwx/sSen8VL9Z9/GZB/D+o+ZSUl?=
 =?us-ascii?Q?iCzQ3v1zbROuwu3FN4X1sLwXwjGKFj5PTCxLQwYjD/YQgT9xxPP78Ddjjdmo?=
 =?us-ascii?Q?E5Ruwi8CsnkGhUOID2VUnprCjGGHR1gbB87Z8Vztyc31CqesmhvA3PB5nH22?=
 =?us-ascii?Q?MkRBEujncAS7l0P8mXVIfYHIT0gw5GB6OunLu9swoSFIxuPr9i9xzUB/krbJ?=
 =?us-ascii?Q?6AssrmruVcLLmrSV0h6OrZeBmvNDUHn8QfW6jDt92n0nz1ZF0nreKi1mJniX?=
 =?us-ascii?Q?qiK12hOVZQ08i2ig7+M85lgraO4hWN0vBZDQVQPFDd+8ZV08K1A5qp9I1lrA?=
 =?us-ascii?Q?5cHIxJ4RWYFjwC3332xbjWFoo1Wr//NLCgkXVrSvqNsV+04Evp9DMEYZHap3?=
 =?us-ascii?Q?xK/yOloMOp5o6vULiDallaPIwBk8Ckg6MkQ5dAxjEoVKdm/IXrzSrqJMKJIh?=
 =?us-ascii?Q?yZRS3IO3z2JHxpnzvbiNOjd02+sLIWo+5blWAOJEo485GJiH0oFvJ4+mLjIh?=
 =?us-ascii?Q?Id404UlaX0a4gw0hN/qwV13NMiQ2kwS+SBgLdsqRw1tbKMHRrpiTaY5Qp9EM?=
 =?us-ascii?Q?6mInqHF2aXzoFYzkvJ2ufR+W1ptbsdEQnFTBXg/45laHYkpGxKcO6Pb+e2+Z?=
 =?us-ascii?Q?UtT2ZuSf3/6EXADEQlyeilLe+xxGzFJttnvCZiHt6OeMqnFw42PkXY0y9vc2?=
 =?us-ascii?Q?N4ySZHCv5WXz0keRZmENjdLPaNKbbFKqu30Y3VT24Ky1XMy8UxP7bfYtEXzr?=
 =?us-ascii?Q?gVWaD4hcHud0aVFIXcrxydVGKajUxXlc/esGiVjWE5kQ3OEn3ZXU80AKqFAj?=
 =?us-ascii?Q?5JH26huuMwQO1Lxruyy+i/X6vGCKz2Aa5SRU8S5Y7MId+kAp60HBQkJ5Hj34?=
 =?us-ascii?Q?uukvVg8iS4qNIJd+o5bRbY2XVx+SXaL12iJuAHPH6ipzDT86GID1DhDajJ4i?=
 =?us-ascii?Q?T0z/VeZQOqCrbpLKSe5dUW4WfShS7vAMJ7+SnJAd7fvoqMepxxMa8ap+XLXT?=
 =?us-ascii?Q?p7yKmaEGhilZheb5frzLDpFJqCes7xPj9AM/bNv96WnBJY5UUeauVRQMbl3e?=
 =?us-ascii?Q?7sOVuWYvSKs1iQh8PZwW3sIbZvr8HonuUjiP4lk/tJj/PwuoXH0Ja5h/XkEV?=
 =?us-ascii?Q?wm0XpyIY7LfoviuUruU5KLIf9N5Tv/KqhCJBxvRnIR99X0EDIXLY4Kyt7BH8?=
 =?us-ascii?Q?6yTRYrVDcEQkWE1bA1nd8/8JpDV45JXPmiqBHPDRhzBIcy/y3c/p0e8Ib7xK?=
 =?us-ascii?Q?ycRGhZiuZTE/1jGVDdKwifVRGnOC8mmUNNpGMo30xhdZkDjuXL2BeoPrl2+U?=
 =?us-ascii?Q?65s/lXlmhcMj/2OWUcE4iCWwY+qh7JBV2dRDtPpX5bsABQY1uyLjK4NcmmkN?=
 =?us-ascii?Q?cjz9y6r4Q/4Upl7sGH/g43CU43sweMt2Ug5lGXGXTUtxQDhAmzqfsjuO5DHw?=
 =?us-ascii?Q?hsg8UGc7YvOFNQWjPZHanz5FzrZc+pI3fDb43B8Fmz1ROG2pAMLTeXgX8fkE?=
 =?us-ascii?Q?5vLWgxTIka1npBCD8Q0EG6WsWPAXCZKQGEXjt7LZbmu8iUOxKBLKVQy+QbmG?=
 =?us-ascii?Q?u9P25OBlegkfWqnMM1PdQAKm0QC3rB2Fq0fAx9albwnca0k/sLrfbZcS+aX8?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5536e8a-f5ca-41ce-2434-08dd99149aff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:39:53.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtHX4oSzoRDKu6d1ujrAGHKIF5nsdHjUZorYBXHij7SIoMGBOIKWmohtLKaedwmwZC5jgO/a7Vxu7NkStMbQbCNpcYOA8PZooTql2tvfflE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
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

On Tue, Apr 08, 2025 at 08:00:48AM -0500, Tirthendu Sarkar wrote:
> Streamline code for AVX512 and SSE by consolidating the common code and
> adding runtime check for selecting appropriate path based on CPU
> capability.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> ---
> v4:
>  - Modify some AVX512 instructions to resolve compilation error on
>    older compliers
> v3:
>  - Simplified code for AVX/SSE paths
> v2:
>  - Addressed review comments [Bruce Richardson]
> ---
>  drivers/event/dlb2/dlb2.c        |  78 ++++++++-
>  drivers/event/dlb2/dlb2_avx512.c | 287 +++----------------------------
>  drivers/event/dlb2/dlb2_priv.h   |  10 +-
>  drivers/event/dlb2/dlb2_sse.c    | 242 +++-----------------------
>  4 files changed, 127 insertions(+), 490 deletions(-)
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
