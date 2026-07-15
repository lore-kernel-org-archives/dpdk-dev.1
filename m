Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9CFC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 12:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD8340288;
	Wed, 15 Jul 2026 14:01:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 749D84026A
 for <dev@dpdk.org>; Wed, 15 Jul 2026 14:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784116884; x=1815652884;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RJczsE/sNH/F8R21AT3FJMR166DnQGWSQx7Jwr6hQ0M=;
 b=InHfJNO9BT8F3DvxW04vs1JjrBMJj9VUlkK6G8MSxhFrAdlhB1wPVLWE
 hrwAFx0rO5fklmv3doz0kk2+0WhQDChM5m7zRgOt1YfURrItlzX3l1xHr
 TGkxoH7yuzoipo75UnBCcSqjLWhYGt+bA7IKcc8HKpqyjDonrT9VoOcjl
 7KUfS6qOg9oTZux6+Nk2a5gw/1oRkaztGVY4qMmsvI1rIdo9zHT8qtcuq
 t3hoCif4dkeif61EbPNX9CKVXe9FolCIEV3fVH5fBx+vXQt/OZDqK8fgH
 K3a0vwqrNBS0rG1a2oy5hH7W3DZ+Uq2nFacgB0P5hQj8XF2uOdPcJGck3 g==;
X-CSE-ConnectionGUID: mvBCYI1WTCyFiDNGY7x35g==
X-CSE-MsgGUID: 4eNW6+jZTz+KRf7G1zd1bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72282067"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="72282067"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 05:01:23 -0700
X-CSE-ConnectionGUID: 3OzzkMHFT1e9RHZPk0rZZg==
X-CSE-MsgGUID: cX3LMohDQZeF+dddweFgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="259748734"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 05:01:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 05:01:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 05:01:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 05:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2qKt44N/uuofXrAk4bo+Oj0fkTw8VDHsPUU/lh42XFvEzCoREo8hdVXY7vbTl8xz8W0RqMyVCPHlG2XCRwpFfYbOxdvIvwxuC2VJVnDON1PG5VRqU/cmoM9vxDryeaQId8M89oHSB12yv66ciTWPbm58jQDwfhv+RvEBsl2I7qgi6lXkeYLQNlxgJ5bxJq7Ami8aLVfxhfnZ73CEF6LGdLwE0gKVf32wmkGBzeSLq/EhvWQTufFyujk0Uq/PpBLFwdAu4xhT/WVf06pA8H94PqQ4AeppYXfBh/b8+RFjqjWfHW5ZnLqPuSVR2V6NlqgrSEsP0PfvP4CohlL02dv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1xWllwkyh1UJ+rUHh0G5gpYO0sFC8SmbuUSX8DBeyU=;
 b=qQd1MGLkZLYouEPOD2yFgT/tdmsYrqdN54kX8joatsNnetvvXs/i685TBw2WsC48O4eM1/2k4Ox8aDjlARje4swWZQ4a+7ztHI7L0Y0s7NGPUN0pcrjOnQ9QZcuqs+eGqpR9WcKo0uSzwoQ48G8CRQinB7PPFvGi1tZ/dde638dWRs8Pbh2W1LWF/H//k4quvx4XQfq8lh0XnhcfvF1cZ+dKJQB25ZCen4AFgzqw5Vh5pi4zUCRJ7eR6Has//jXYWVqUERIsb0nD0siLqDFdQTmckwwDy6L6xZkcL2qgvUj8OBAEj+5d5BxL+p+bZSZwa/iCWa1j+VpAi2g0SctcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 12:01:19 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.011; Wed, 15 Jul 2026
 12:01:19 +0000
Date: Wed, 15 Jul 2026 13:01:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: add deprecation notice for iavf devarg auto reconfig
Message-ID: <ald2iil21xQdwI4L@bricha3-mobl1.ger.corp.intel.com>
References: <20260715105959.2216756-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715105959.2216756-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d0a6ec-8013-4d9b-b948-08dee268c7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tCCVtQsRBmGT3bdqXloRNIk58HGptaZgDfkB/aQ5hylgY2hHU1o6c+zaQvmRKh+JRxjYTji1HxqckX2PJPAi2U1PYf00TEbVLytrZaKbLUI7qM4nD5rViCKqGXVwKwlII0ggyTgOo4wIgraHyd6IsYafShpBLlBiZ2y/e7dgYlsZWj9CgWzcVy60qu5kFdq+M4MBssfGjVSmaReFuL7Fo6kBQVqM7jrys8Oc711p1kzRxQTT+GchenU5RlnN8bMfe7twjSnGrxDXJbzOmBacs+cn1qEu9/DDcgDjrvoDGtcbZ+Ej/mMGlW5zljrIGHLi0rSH2aAD7qKrH0prhKRITe/DBSadEG9xjLijdDyIh7kEwsVGNqtkCB0H84NZIO2k8TfMpqS8uiMp95cpTY13l1X7UAiZRTK7+2YzG8Dy0k6kffiE2TefuPAlRwH/UbH14T2lCtP9Y6bjQFTGlqwIyt1nXzD/l1j230+JSHmOsAyBn1tptgZCUMz0+BhOVIN7+iyz5CIlK6hKrat+KaB0CMBM2OXlaf378Xt7BKgqXJ1iwShSbvHbvRw3Mb7KEj0A0uiHKlz2Toq3lQY6UOA2CByufCiEtLxbPD5lSWPB3bzIuck7+bk8/EStZlZPbbEqqrmn0l3047bDezMDOfIHfeWyQ2WZVTbUfTpHX6Uz0F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hj+idNT3ZaC4Uom43fGBSPAccU4rTpTvQ2e93c5cGX0/bFp1xmWq1Hw3gq+T?=
 =?us-ascii?Q?0oAmts6d6VOd0nGITNfrcK2wOSfJrEBW7xOpckhWYTBwqBKfCPf9f4EQvnW4?=
 =?us-ascii?Q?qQtpk3UAYyeiBhYTc1B5w5MvUE70yVyJQ1xJIMBXuQ8IDAZHN1NIdFpA0LiE?=
 =?us-ascii?Q?hDhNDGxQbO934Bo51LjmWrq3kRARcyBEOzCEtPw8D6A9DdYFsZgM8qk7NA9D?=
 =?us-ascii?Q?j2cJ3si36+wMrxLnjCK/KavT6l6+SqmrF/sua/snGzh7t9fWo2en6ZMToLvB?=
 =?us-ascii?Q?SrYmmyv7Z1aEQ/R7zgqFFTehffJrRMrSbkMsme/V8pJSCcmF6elxM0Xqnguj?=
 =?us-ascii?Q?TdXiQS7GcCll77TiVdrUEiEm5uEomZWu1XgjrS/wUG4f3KMVQqQyJ4AhwYCI?=
 =?us-ascii?Q?kpMHw6PmrkFgXDO5Z9a/pbuWARt+FcwaRrSK0JEkntOe5yDemDEF9yp+vKkQ?=
 =?us-ascii?Q?IzliWbxgCS/Qq2eeWwUAHBx+W3ZFDP7QsoXxzUhMP3PgaF5kCbOB5/NZ/DJo?=
 =?us-ascii?Q?EhZHv4RJ0YRwX/Q527rK1kBbJjMh1JoSAUcXi2D86YAJEMglcZvvD0TwpiTG?=
 =?us-ascii?Q?hyTzKb20RcFLqwiiAS79sJf0E/HgDvKBbiKTXvveysSGDgsV9ve+OtfH1xqM?=
 =?us-ascii?Q?x10JIWTYF5Zo9nf/jDdvdVS1Aj4X/a9kvKJQG5Zuky6R6XxiwCEz3BNpjKa/?=
 =?us-ascii?Q?RukZSrZtWs+bFW1oyLmmPuUIHbcaUcPD9QXCc+kAqzwOgC9eRVcx6354nPLk?=
 =?us-ascii?Q?9a/LJc6I26UB2y5aQxWJKcA7LYKn83BVWrUjTktOAl+5x/3+YOxUzgjzZyhl?=
 =?us-ascii?Q?PBIHIVpaBW+Gz7b/SsH6Ks0gamXjun0VLmRaWJ6BC08YEdgqv2XIcMHoMMrR?=
 =?us-ascii?Q?LwlLJGyWkEFIqZqvGWlra+PxnucsCPXN8J0lclEinjaLs8wCcAH10Lx+FYFR?=
 =?us-ascii?Q?g7+P2sPEZfx8mZNZZM0ufr/2xDWsYQl3SlPsvjN4PypfaJQuKpPrpfmK1elh?=
 =?us-ascii?Q?A331BQtPwh3BVdn0EeoK+aJADbq6A2VWnGFU+h3gUVywXGycI+Eeo2KLzVGE?=
 =?us-ascii?Q?lViTUDNqFlm54Nj0eQk+YfzySQGAitMgsBYUbxD+W/Fmhz3ab0fSrjGvqXdy?=
 =?us-ascii?Q?Yzu02QC+Cv3pzHIs7Oleh86mKkJqSCAbUMBZ9f6BlyQcbiow4jpAdofEV0XE?=
 =?us-ascii?Q?+/KSDBxGxy4DDXl3NUVp8tvy7MJ+hN3I8NyhGhOQALlMcOaBxEclSCle4V6w?=
 =?us-ascii?Q?PD5HyefZ+J4Qyg90CqgFn5fYQBFTjXYuAVFufy2ewWZh3DAhDswB7a1dOIcf?=
 =?us-ascii?Q?8NBXjzu3+VrrRLVaImUKI1jue9Vwkn4SHsgiYTTBy9xj56vnOmKcWonqYw9d?=
 =?us-ascii?Q?Tyk1aNLSh7XGT9ppw6T1rU7/UEV8ePlLsCUVjhRfcv0Nm2RfyEdRFMyYfS6l?=
 =?us-ascii?Q?LWkFR21AvT+bsHOrJl7yDEBCmew9kFvxZO1D3KAdifYFySBQ5nZN/xt4Ci72?=
 =?us-ascii?Q?V0lsFgT5hLijiBmM/xCHnxKllqbkCgvubAEBjzVq8uigTNhba719g8J63eiX?=
 =?us-ascii?Q?HxvRWMs67sf20iAlWNB+urw1opqnD6M0miUeIpFH5UyqbvHKdzOqL2X/qaEw?=
 =?us-ascii?Q?p8bjE7/Ucp210dB+Y+Jr73M7Cl6VVw23O52T7c9K542CN3ytpXqIp+v/tVPC?=
 =?us-ascii?Q?3K8lSJ5YM/XLiZVont4uLAEPjM5NmoSTuoLemyyKt21lrEIrzM7mBCKNAv7g?=
 =?us-ascii?Q?7F4ZXCr+FxtKzBR00K58FOIa20VPC5E=3D?=
X-Exchange-RoutingPolicyChecked: k1a8kBV/7Emkq4F+pPc7r0X0N+tYwTCipzQKhkkPxtI9YlebOxAeWkhco0RsEV2xbYEg15nSstA3hPD1rTo+NeMMSnIm3wyRWsaG2hNKExaX7s6fmwD7wVO4uhLZ6z88a+OHYqz2j9GdkWllDvzFv9rNB6I01nbTKKECTS2QOOiEPydKLLQcKUGo+rTtagVuvMhvf6/YCq/4npfcOzNsxMZboap3HQt4b1VvCs2k7xy9p0xE41nPQXlodNgkYr9oIn7W5M2QQ+zwFF7ZUTGgyMZFF/SbXh3E4IQTbklyBeRRqhNU7k4IZ7p3WoljIcmkBvu6BwIRQimfGhXTrT3uyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0a6ec-8013-4d9b-b948-08dee268c7eb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:01:19.4114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zii5hhls2d8WzWNe75roFhZm1JZmOYSPoS+T4yfDJXV9m+AIZXM/GWh7ERI8j4tG4BTVMVXODHyz/wQSyrGIJce71qF2fwmS8oaP4Shm684=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
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

On Wed, Jul 15, 2026 at 10:59:59AM +0000, Ciara Loftus wrote:
> The `auto_reconfig` devarg in the iavf driver is enabled by default and the
> case for ever disabling it is weak. When disabled, it means the user is
> requesting the driver not to restore settings (unicast/multicast
> promiscuous modes) when recovering from a reset. The use case where this
> might be desired is during a VF initiated reset where the user initiates
> the reset and wants the VF brought back up in an untouched state. That
> scenario can be facilitated by extending the `rte_pmd_iavf_reinit` API
> rather than relying on this devarg, so it should be safe to remove the
> devarg.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index f5c12cc747..b88774a3ae 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -159,3 +159,12 @@ Deprecation Notices
>  * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
>    transmit path in the iavf PMD will be removed in a future release.
>    After removal, only packet type-based detection will be supported.
> +
> +* net/iavf: The ``auto_reconfig`` devarg is deprecated and will be removed
> +  in a future release. It allows disabling the automatic restoration of
> +  device settings after a VF reset, but this is of questionable value
> +  since most applications expect their settings to be preserved
> +  transparently across a reset. The only use case for this devarg is
> +  arguably a VF initiated reset; however this functionality could be
> +  supported by extending the ``rte_pmd_iavf_reinit`` API instead of
> +  relying on a devarg.
> -- 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I think the text might be slightly too long for a deprecation notice, so
I'd tend toward removing the description of the possible API change, since
you only talk about how it "could" be done, rather than how it "will" be
done. The first two sentences should be enough on their own.

