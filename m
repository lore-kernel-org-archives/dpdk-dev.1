Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DCCD4F4A
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 16:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA77402D9;
	Mon, 18 May 2026 18:56:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5FF2A40041;
 Mon, 18 May 2026 18:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779123379; x=1810659379;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/58Kcr1oPttWD6O+IIYK+eDLueK/DoGpmRLVBF07LPQ=;
 b=fMSZsgjg9M1ow3qra9i7a6A1qbezUhakvh6qGl+9rOf3hBCZ6/NjI9g2
 XHedQcyNn9duNlxxQetD6AWyOmbVshmmULdEhPWQ8EmGJYLdo5PDBJUPe
 m0OOvVWOnf1KWj8LzpvmE/5m0LUA/LlSsFU7ZNdqHdQi/j4K6Go5vAcu2
 cN84nyAQagXtWRTEF7qApYB8/L7ZOrOhTj//rxRJ17VyfKbwEZPH+l29W
 sDSoGHDH4ZEdyHuk/E1KAopJr1fJ/PXbwbWKlMrNK58wkNlJTVNNy7qF3
 Yva7WLWbzMzqR5xP1lRFblOqQeEn/Sxmnf1a82Bxw2OdZn+K0M1MoPiNx w==;
X-CSE-ConnectionGUID: 8wOIokKVTWuH/n3AP0VEeg==
X-CSE-MsgGUID: NQeTC0xUR9mSGruZaasi6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90678562"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="90678562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 09:56:18 -0700
X-CSE-ConnectionGUID: hYCJ9V5QT9eNN1GJgDahtA==
X-CSE-MsgGUID: LKE5PiczQVC2a5BjUSAwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="243782365"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 09:56:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 09:56:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 09:56:16 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 09:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb8dUJs6qnmy7ntjpeF0cnYIuEg4ItyzpqY3CO9vWh/SN0stRnLYrkqyI9FvoEl9UML+i15XCTDdSp01JIjMM9isCzzbEe4SixNIDm7NXTU6LlmcGK2psfyd9Ez9lx7eT6PJuYZ8s5+ohQRw/UFywKQ8bbFH6MKuc38T/PQ3eSDeNtV5fh00DZgb/2ewGx5QCzpZaflyCMTRgpUn7zGxyPVpZ+WuqDsyMGDdTHlJixRTiLOo+/5bSS3Ueh9ZEcMp8H3M90YP2BMOGxpWSD56aWWXFLfTvN65aGucX/Dp332kNs0ML7lF1rW12UR5epYZ2qkrpZHS5PhyHrosv9Rwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+KBOC+daUfjMfBZG32r+r8BmiwR4TVfLC+kt3NEi6s=;
 b=ZOgaP5jqrAQzGxrYS66fISJgA+UA8tUYPnT11zP8qb7fbQofu/XKLqxOyJWfVP0CMw3FuQtEWfW57gwoTHlbKLtXDsSeu6v3PYDaPv7b/Lv/psMIKjlyV4DCrE8ziKlVgt1+AMBp4oEgWEET1OHKZkGsJ6ARxGzyeekW3rHTD0ubbYg8L5x/eh32RSXO4up48piHND/Ggd1WHvzartcZjuAI9nZ3+i2vxp2OkHiqnKq4i9ZfpBDQySCkH4OO/Q02MEg0IhQJxxjB/TQo4L6j7HkK+3tTEDUyll/g1/XzeZ7C9ZlY2N5sxyPOaCGxNqVa2GusGCZLrOH2RdeYVwWInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:56:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:56:14 +0000
Date: Mon, 18 May 2026 17:56:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Jack Bond-Preston
 <jack.bond-preston@foss.arm.com>, Gavin Hu <gahu@nvidia.com>, "Honnappa
 Nagarahalli" <honnappa.nagarahalli@arm.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH] eal: silence -Wconstant-logical-operand in
 RTE_IS_POWER_OF_2
Message-ID: <agtEqEv2fB7R7_Aa@bricha3-mobl1.ger.corp.intel.com>
References: <20260518163401.580696-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260518163401.580696-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: ce78e1de-e1f8-468b-74ec-08deb4fe5ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pdmJTbavEqMbyYO0ywVxeoFbGKOXDD/qK9mcf1GWOHv69qd8Qivw2YciWEiKv1UDTzAukEpSk0mf1IlP0dUMN7udN8EMafSXzESDhvkufYG1/lPWFL/oRktIL1eaiOAsoIDX+Mpj8nCbQnk5tQ7iaxF4N5Y+P66+TB3t6iRtAQLNHeDLc4MBnmM61CDlCSYx+1M9nKjdhxmyjmVrtoRMBLA1ZYc9gg6bZ4QD9zIJq09clhPMhiHIvE9WcrrLMrPHZAq8X5eDPR+QjRIbBKR2qzADSp1gXQYKh4JWmS+FQo0FObnJp38cIkIVRyKWQPN2A3hwrjtfB4oHFUYRefa58Pdu5iVQFW9O1FrhKeJ7OV/A7GfvoYPsqNpEDRI6hL+Odf3tNyNAYYZoCyzrleFBlbkz0XeCl2qpxZJDcWs3wFvVD0mcV/x4nPKE+mJpfWswqvqfxL/AbhzY9zRJf4zbUQ/W5gWEWaRM3md4Tg43Ifd3FxKLEYGeu/x4Hb8+EC5pRrhp3IKMg3ObPrVkhB36+GbSPYbrYBt0TAByn5SqS5IN0lzM1/wWVmhslDylS/UlNyemPK9MlcSytTfscTrUlrwlxoo98TlIvIQn8po91rxv7LW272vxR7/f0d22chK7rsg3uHmbtInuMXGWH4U5fp5Z21QYE+szd9k6Apj7IEjNY1wcMMiLtT6cHqWHK565
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdU4w+EJsvq9dISgzPEMByQBVHajnz4gB+KMZbbY1zxXiGV0eyP19/g27XO1?=
 =?us-ascii?Q?GeEm9SmHgBXTFWUBADaVCqRypnTTCPuzvzYdn900R2xXuW6th51wcQJ5ydSL?=
 =?us-ascii?Q?nFhYKD6LpmWi0w7TNDqSh/VJZvgxyYlaPAOKQ+LAHZEMpe4/ZuOe0k74IcwB?=
 =?us-ascii?Q?GPKQcm1SWpImw9hez2EQUvswjQoCuyPNgLJx2fhzO3h8Gr83IvsgawXoGBXf?=
 =?us-ascii?Q?NmZNeF0b+rUTdRARjrnRFAnNgJHQxdchyHLYGzpRVwn+b9o7ktzUOUrhKUmm?=
 =?us-ascii?Q?a5Hy/uRwQhFTT5LLxYZrANL4nhKk28NqmKAo2h6vU4gEl18IxWA9wVaw+LIi?=
 =?us-ascii?Q?Op5LVgKmITK/SZh+EsA1hIzG6gbUJDLsHqrCUA/CfG9iUz84akXsi2HebDgQ?=
 =?us-ascii?Q?2spsHBWq8KEWCICJievPZCZiIiuGI03QAMQYnBzGiAi3gjpHxpWrMAC+y+zy?=
 =?us-ascii?Q?zms8ZEVztLHzORfgMmUyTHuCh9ZU6hgztOkKBVed2XRDmBF7t75ouMTT1Dl6?=
 =?us-ascii?Q?yVUFIa5GseNhhA/j72r72FLmH23tD89GWN5vTrQYRirAeqSnvokSlBehMqTz?=
 =?us-ascii?Q?bHdFeGDxRQxeIdx+lSJC39kUAE2+pZyxpfQeoB6w7F5Xyc/OexbMf0koZ+3n?=
 =?us-ascii?Q?ehN1mXHm8p4A5Gh155i1Mm+S9aPR+BdgT+l5PM6fgdxImvOVrgf5eCBbYjnA?=
 =?us-ascii?Q?btpn6uZ74i399RHr4FxuoydpPypwXoKraETmGdZb3IF/xxGDYCakSfS3oIu9?=
 =?us-ascii?Q?hom9Web3MOjKeoqGYriApuXxAdReGtzEVZeXDH9UvbuVZa1/MnVAT+VIQAlK?=
 =?us-ascii?Q?qvrUGmFK0xWmaYvnRCqxp2gsxZix5EnC3WWHyZU05mbQcpMK2SrlpRJbEkKM?=
 =?us-ascii?Q?S/tNk+QHG6PlJh/CA0oLOdahwfLwPvzkI75mqUARlYTQ8UNbuEpmVPNoMr2a?=
 =?us-ascii?Q?uUvR6qDHYeMA0xO3yuI4HstdNPY4Lhu4qSvZggEufz8lVnkjXu7igXHOx8os?=
 =?us-ascii?Q?tww6u5vjuYucaaSWRBR1/fhgQ+d6hOIixYGiQrlQnfg4nCjCX1tSkx3r5g0f?=
 =?us-ascii?Q?FkqE6gdByodtk+A+XWganigaE3SVsTNYZHjQFukGuxhYH/9ddvLjMpeyXs9v?=
 =?us-ascii?Q?H3acDsiwDutSZX6XLF8I+Z+yF+nfviQS84OJLk5204OXdPMQeGk4djsLD1DI?=
 =?us-ascii?Q?Duwu2PfKMq4sbSdtmRov/Rfpc/US74uIjuIejXUhyDee9XXCxFVSBTlGBlXo?=
 =?us-ascii?Q?XYNR/mRKS0H2g6LFvXMc41qb+EU+ZYoSH/BSpkPv1WIZljUts3QisFrDtpL9?=
 =?us-ascii?Q?we93XzG632Ah56JvmTWXj0Mw1QE6GJ1wThEBGuGT95jImppDr8mwkw3yzFeb?=
 =?us-ascii?Q?Su3Zmn3gKhh49EMoOfn6XNh2xPWJt8Di/xJudZDm1glYCY9vUoiMFqocI6UW?=
 =?us-ascii?Q?QUDTIttM954fao43tWPxJqRSVehUazHk6y7iJPAX5deiiRN1Hgm1M5VXzghK?=
 =?us-ascii?Q?fPdye+8ilHxdwBiadSjHhDcfRn06e4rPI4Q/mA3t3rPXFvbd7u5w7oay43Ju?=
 =?us-ascii?Q?ZedMIkDfuUTSm4ZB2bU9Oh46iyysYRVNBqthqvHKQqS2gN288bs5nxbcwIuQ?=
 =?us-ascii?Q?qx+7qyn9oeyEn/xePueaLCgFpSgHWhFJPYiaC8mNMntifJBPAbKUH02mQCOs?=
 =?us-ascii?Q?lerrucQe1UkpD7plNInswRMNPi2Fl9r7tGhV5ZOPalr4IMZ4EENmu305rvNE?=
 =?us-ascii?Q?aZj2bhP2kwMcr1m+kSnusGdE2yre1sI=3D?=
X-Exchange-RoutingPolicyChecked: LsLRuio7Ss0WXR7DhhAl/Df618yUn1vmwFRuqvPogLEb0aJVe+DPBlKTME7ZElSZzkuXvCZ7DblVDwROl+l78QmbOYgZP11sZFmVw8XsYe6zKF+ujv2A4XnsY3UH/PBgCDJ01x+NCO/Skvlxj0cVnD5W3Ib7OOVNTn3STt9qosyI8gQr4G7907WzuS93EYGYQ23vABwOlhm7MOtQJF5qbLsE040rp/9gV2+CtiRdGSv/xq53S/DOF3afQPdmluoRbL7LZ1eVC9J6YFmkroF6kLoL3wByWiZOLgiQ3hyoH4Gj3gvlpVn8kEOInm065p0ririaRRyFUwgpc51u6njv7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce78e1de-e1f8-468b-74ec-08deb4fe5ea8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:56:13.8625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XGJ+R8QoITkzMaQJyxWrtFmm31LVjy2EuRXP1uQyJOscBY+LgyNYmYsJgA5OO6dXmT8odrQDkyvFPIMygZH093FddyHQ3fzhSYpemlhdUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
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

On Mon, May 18, 2026 at 09:33:31AM -0700, Stephen Hemminger wrote:
> Newer GCC warns when a non-boolean constant is an operand of &&, which
> trips whenever RTE_IS_POWER_OF_2 is used in a static_assert with a
> power-of-two literal. Make the zero check explicit.
> 
> Fixes: 7c872b96983a ("hash: validate hash bucket entries while compiling")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One further suggestion below, since you are changing this.
> ---
>  lib/eal/include/rte_bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
> index aa6ac73abb..d2719ecd5e 100644
> --- a/lib/eal/include/rte_bitops.h
> +++ b/lib/eal/include/rte_bitops.h
> @@ -1299,7 +1299,7 @@ rte_fls_u64(uint64_t x)
>  /**
>   * Macro to return 1 if n is a power of 2, 0 otherwise
>   */
> -#define RTE_IS_POWER_OF_2(n) ((n) && !(((n) - 1) & (n)))
> +#define RTE_IS_POWER_OF_2(n) ((n) != 0 && !(((n) - 1) & (n)))
>  

I'd also suggest changing the second part of the && to match, changing the
"!" for explicit "== 0":

#define RTE_IS_POWER_OF_2(n) ((n) != 0 && (((n) - 1) & (n)) == 0)

>  /**
>   * Returns true if n is a power of 2
> -- 
> 2.53.0
> 
