Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE634C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 13:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A96094027C;
	Thu,  7 Aug 2025 15:35:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DFA9C40270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 15:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754573717; x=1786109717;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XYbJy/a23LAsVVg4KCVQhfw1yIfHp0zMldDMkunk1xE=;
 b=XsR4OVYzxB3jS/Zd8NVrdj+QTTAFYcEm9TN5WHNnSkfbJoox0x0WKm8c
 nyUpk2iUgj6pI1HKl1KtMsO5e0HYUscEHziWen2FRG/dBKXLJ9qQyu6gm
 g8v7JAhlxPbyoxtrAmHaDnRLqQoZ4G+f5wLPI7lqWHd4CJu6qJdyK4/Rf
 5Idg3qMWZEh/3YIeQvUu7YZIAhMsRzsIiiFT5DFYiXkqNhKvfJr34Mv5m
 gJueb6Kt0P++EuU73luJtHFy3IW/OeyeKtvZO+kZZ8N8GoMuS23llPgyq
 pwm8kzS0O087TzgVNJd3evU5DdZ56VpuGGRgCVwJNdY5Z9Dz0OCxStfpy w==;
X-CSE-ConnectionGUID: taXGs8m0QvObIieLONDJtQ==
X-CSE-MsgGUID: Idb6c7oYScqUKCqMxpoYAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74486798"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="74486798"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:35:16 -0700
X-CSE-ConnectionGUID: EUnHQU6tS0y2jue0jR0a6w==
X-CSE-MsgGUID: GpSMR35URzaslGoqIy56Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="165070575"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 06:35:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:35:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 06:35:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.64)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 06:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndQnmQ0M9Tpta/FGqwEjyvirXhftvpelvxbtS2qSFkhLRj9lLA242oWLkClFH/HIy2L8AAgaz9IfciJ8xSGLYvfWIiLcVrlaqKWkor2gDVeiKsBt+iFNg5DlD9NBvj00Ung2qcifdpd0Vsfvm3UpFSG9VUh+Vcq/IGxVbBs1qiqCG+UGzmloEVF28UN95OXNYyQ5MYZkjNJUG1dzT0e7xuVZxiF180UrfVAaLm3CkoieCwpXGdQTXZxSGPtpJKePxLBxZoowfelVAU3kWLMf4aI9FeTVPHkX4OX3wit6MH4wudLMkk0uI2YCig76uLGtXX5ja9DZVaVUihFKsN/HGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ta/fMtUOFd2eWkOqNOy460gk9C7saKa/M0AKx0pZfs=;
 b=dyI1bQUYfclkrmpqAcKt9L3SkC6BYuhWhMJ4RIUGyxZnAQ874hfkv6KeK99oFCwUu8X5b3CUaJmn1XilaSLYN/cvHuErzXSsPbLPlWrHrtbkyiSOfqs014c/IrPu4+wCzrDBxm4c+sR1RwvGKj0+LRpIIfqyr03nHiA9uTd/SDHo3RhrMte4wZBLQTr+45Fbk+2NdWssgOd+zCKgbVT8MLhp7tWYTFzWd6KKqpctGCRi3a33d2dMxB3bwd51H8CfE7d6HKLiaUbQEKabOlmhXFPNdd+5dxz3u3K+23nbHYjiZKQ9YbkZ1SbD0XuBnOww8PkVinDTBhoV6D21zLxbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPFBD6B1667A.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Thu, 7 Aug
 2025 13:35:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:35:13 +0000
Date: Thu, 7 Aug 2025 14:35:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: support qinq insertion offload for scalar
 path
Message-ID: <aJSrjExzZPM0YQg8@bricha3-mobl1.ger.corp.intel.com>
References: <20250619133658.13494-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619133658.13494-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DBBPR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPFBD6B1667A:EE_
X-MS-Office365-Filtering-Correlation-Id: 06da0bee-1627-49bd-f1e5-08ddd5b73ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QeVAC7cDxgUVjVGtL1g14SbcjrUNH9y+jrbZyutxRP0EllEmIEkF6Ju01J+g?=
 =?us-ascii?Q?qPwX8rYnDO15+BVJ+05ovQbal80ooTHKjuVFIS1zvpHrsJuN+FthAunLNKn1?=
 =?us-ascii?Q?xcOOxi8GiwH+Sa8TAYheT3T8AIjGUrSRhbA0n3zdm9bDFEyyTQmPJ4ZaK4a4?=
 =?us-ascii?Q?7EwzJN2QpvZuOJKmWvmt2+rwcwIPvqjFjNU2I2yAiPZeQC0oxCeNU9xTxMqV?=
 =?us-ascii?Q?aafUo2rz8TZw2dS1u4EcGirn1fYPfvXjOe7LG7Q3FU8zzwXSTVj0GQVeQg+S?=
 =?us-ascii?Q?TMopICqlqfjavaTTMq4lOVDFbHpe3PyQoO7y/T7EHmc0Q7+dVA6L/81A4puq?=
 =?us-ascii?Q?fPyQl6Ox3pXCNZb2GDtO6C+wzUC+ffb8+uGZAwbkgc1FjM8fmG9hSRzLYbrV?=
 =?us-ascii?Q?9Z6uaztbRGwO3w8VdQis9/RZ4pEz/4ntv9X5xVAV29nyXutOn2N0DgJjTSso?=
 =?us-ascii?Q?hRH8zET/4WiHeH1taKNqUmyg3ZO4cKiOnsfBN4RRkopcyo0nznXS22I13mOG?=
 =?us-ascii?Q?uzP1TZmGNwRmjUFK5KZRI5s6au+RRCC7APKgZkwtp4/hO3DW5UMFE3qgvsoi?=
 =?us-ascii?Q?tH8CzdBdS3Xq0tjwjcCsi0W9at7dw9QDkMuqpZBoBeJoiGQtZnI2yDQ0Tr4+?=
 =?us-ascii?Q?aLe7ILFhJB40Spj8opyi6zE6Bqwr4cmyn9Qv9NydCyO3UhIoz/Bx04zrvYcQ?=
 =?us-ascii?Q?7xCnL5x5twrLMgbgRC5T1lDiNyq9y07SlCDHmVfPzbTRZKSid4gr+ycMo7P7?=
 =?us-ascii?Q?fYS5Fp4cCsOLnl1Fn8T29is1pVw916maANweRkWGu72dk84496fT7Y6My1yp?=
 =?us-ascii?Q?m5D3ge1NgXtw2YbO+LbqO4G96B/VG5gO3XDUzX+wDQYOY71a3JFZZu2bbbJa?=
 =?us-ascii?Q?JgyXdSpj15mZaNWIi5Mc6Gt8MSWjw9vBsven1DW66V3R9vdmChX26Zv11kpH?=
 =?us-ascii?Q?FGlqYsdhO7kzwfJz6Hpb64NXdzguV19Egr6A4NEBQ9kPRypiMELW/qq3XyaT?=
 =?us-ascii?Q?Z6/M20/DkvMdrJQQ4v/YvvL7g0P8wRjbx9MFxEQnrfQy1N0RsL/fedOoSMSR?=
 =?us-ascii?Q?iyLYHXOwDSrl5GEUot+SVy8KyRFO3cH8D0gOnBOWX9ngrLbCzJpedNgCz4RB?=
 =?us-ascii?Q?5LnfPjdjDtDmFgO+O5xa0WnzkM3XNsfGQI1St7NyicgSp1zViVcR8ds2NHJs?=
 =?us-ascii?Q?hEimD9erLfTSrqO8V9+sZpS+zQQsQxgeQakDKjwgblBtR/TRtn50A1SvCTQP?=
 =?us-ascii?Q?VyhGbLwAfRJ5cZQK4NAgBYG6/uxqOR+FpENuNAphWNlwqTycv0fIuHILDP7B?=
 =?us-ascii?Q?XV4ZyohSkIOHaK63ErRuhHuYB5QDlOd0DpkHwyt4sEXwlHd0sWQsBM9QbMuF?=
 =?us-ascii?Q?JJa0MIWGEm5v6BBv+KVjW1nQLOSjbfrnN161eJf3TG1JzfdrmWWtFl7dgplf?=
 =?us-ascii?Q?SdbjWaHn5Rs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UmHwFeOXqYiLBw1798iL3KE4aV/JfzK1cNaHp9Gcd/RBNn+xvk94QoH+HMq?=
 =?us-ascii?Q?4S7wp+t8bWNR9olc09Bv46FZWADfeamvg0rdYbgqybSTQadto+a4x01cbNT7?=
 =?us-ascii?Q?aNrLJ8X4tcSNVcIaBTRzoIWdyhrO0taGKbtK5SEQkIegi6Z7qtEYZcE6RHr+?=
 =?us-ascii?Q?VfS/0EH9vRx/qfDy6yp2SfUHlprCJqmEDmAjIAur+DbfV4wvCmqY0ulXTiqJ?=
 =?us-ascii?Q?iuy6NIhzp1Qwpsit0BhQYAoxfec50XLoFuw33zfG6KhONK/KcIpZnv6U9ESV?=
 =?us-ascii?Q?ZedTaFZD9ilqdU2PI31Pbrajt83fKQZFBMy86IA1uEVwBM72BHCz+WR34R/4?=
 =?us-ascii?Q?nLES7EPAJ5SCN3SK7VP/UwFUPSFscu1ugKgEfWoHOAuCyUyfQUkqClzgeNIE?=
 =?us-ascii?Q?5VhBOmpZZO+svflHWEZOTWcs3BO9lb0FOgrYOjMqJ2vDXfnuZO0szwdH2T4Y?=
 =?us-ascii?Q?mAo7xsHFG9WoAcKfhnU88a4tOqQ50orgLjALk8k4An+2fzfJlPrBBGGLWnc0?=
 =?us-ascii?Q?f/fiWTRgZDs9wU58FLpmDf0ZDEYCA1QrPS+P+yPUjGnh+fy5mMrqhNHD1/2g?=
 =?us-ascii?Q?aDoqOqn0RleoCU4+VeYtqm9qKE072WUIGpsFbsJ3TcuxCIJWkLIQE5li0XbD?=
 =?us-ascii?Q?MAQxOOJDBKNtBtZ/CaBWuQybOg3IJ/BRhX8A4IZWr1r/RDUzL8uq6itKpc4E?=
 =?us-ascii?Q?n4mWAoV4u4ufRVQY0z0OFb4WGVUUo+FG4drOpvuiiNKiFt0aWKl+MfI9S/1r?=
 =?us-ascii?Q?yJ8bouXjsLd0zNs8RcsDUQc/N2Igvrwc2RWtdZ3+t/RN3NZRzzIbEhwkOm2Z?=
 =?us-ascii?Q?TwrjP2/sGmYmjbdL2XphC7wF91KZ/uTPgP3tVRTyu2XX46utMyI4gnqH9lo0?=
 =?us-ascii?Q?MNyMaM5nKsIfs0HcQZFx4IDg1IsYauGjy+dqvMkq5h+EygbLKXhPCuO9rvK5?=
 =?us-ascii?Q?lBfn+1KJG0+WMsI9JwW6rtasZGmrVwZnqecS9owCGz09DzwySrUg8ASCu4jS?=
 =?us-ascii?Q?0109H/VtYirKpR/fYCowyyNu0BYJb3Gy5P8GN7F23VdtVfo/EWj5hCz7pL1R?=
 =?us-ascii?Q?76GJ8jiQsRLkT2Ih/4W8AYdQb9tPU0U0eglFZICkstkvrkQEe+4qWkEBAucO?=
 =?us-ascii?Q?WIRH0NQ0c2F05u9ID7R+OxaXz95CcomOaLY6hY2/gwHamT1jLyoCHpRubPRU?=
 =?us-ascii?Q?byBu1BaRoyLuAcLFYEpHyG37gdmN6ITO5PP2Gfp6jp8GzEBZXtOl74fHLpN8?=
 =?us-ascii?Q?xvinUZSOPNRpyg7/rAHi1NdDTPVmmfiCPXOWgBkotzFJSAubeSCdzsTa21Fi?=
 =?us-ascii?Q?c+XmHIGV0ZwzZE0AgFslZG3c9+4S3X4M/dg2sr8pcO2ErMLnFI4nWe4NRLh1?=
 =?us-ascii?Q?zJYlgYsLtuEExdmrWQTaBsAqho7BRDauZR+En45kXVscSG5jDziFJJrosSXR?=
 =?us-ascii?Q?tDBvh+UDO7TIGupkZ65STxlkiNlj8SUwohPPpgJdUQVj4IAyRTtim+V1xsI9?=
 =?us-ascii?Q?lGUpNANWTMe/zxVM68dqt+yXAiO94+a31A2pGmlixpyqKOsgJ22naAl+3jUe?=
 =?us-ascii?Q?31atomKMp4bP7G8rPa//GQ9zW6BI5KSt9ChaXcYKB4CrOTqOo0Gfcz2CryER?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da0bee-1627-49bd-f1e5-08ddd5b73ce8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:35:13.5854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oak0+Nn4w+xo8Dz83B0vRm9gid+hszoHv6ppazN0nleN6V6VI0A8tVR2JLdK+RxjhEBWUzNQYdVW+cq/rUnCJpvFoa/yWqJ2RVhFTHIr9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBD6B1667A
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

On Thu, Jun 19, 2025 at 01:36:56PM +0000, Ciara Loftus wrote:
> Enable Tx QINQ offload if the VF reports support for inserting both an
> outer and inner VLAN tag. The VF capabilities report the locations for
> placing each of the tags - either L2TAG1 in the tx descriptor or L2TAG2
> in the context descriptor. Use this information to configure the
> descriptors correctly.
> This offload was previously incorrectly reported as always supported in
> the device configuration, so this is corrected.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini    |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c |  8 +++-
>  drivers/net/intel/iavf/iavf_rxtx.c   | 55 +++++++++++++++++++++-------
>  3 files changed, 48 insertions(+), 16 deletions(-)
> 

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
