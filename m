Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103DD49228
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 13:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C2C040268;
	Fri, 12 Dec 2025 14:40:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3CB1C400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 14:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765546854; x=1797082854;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DEd18YdbKwL6LAGPAdj/2YbXM02NJEs7be3p0nfwdpY=;
 b=kv8t4Nb5syF+nRaOEJmMDExYTAxu7gzL14zzxQBAGBhiOxRpxYv4fRJJ
 ELZFg2CCegugWsqqzJymR8dUAXGURuBgD9GGgr94hwAF9bIZRHXoauJkF
 2vsUcB7TSgcvUrmDH4OQEyQH2QqRVjLA48LWcw3/ZtjSD5uB2R9Hm4lzu
 2FL/HzEHdeBjFmpYEmQh22SjolYPjsJTfyEJjcFxlUkTxcnB+cEeiGkSj
 W7Bzc8+qYLmmq9LJb0cqNXV0R+XCyuXvL+i6/Bo0NzdTtNuWDbGpqgozV
 UYOrMXp8lNPwdq27ySSZ8VfTx732H7sVpTER36iR7GVQV6/RXpkp5u9ZW w==;
X-CSE-ConnectionGUID: OPNjY2NERIGetQW2RU/mPQ==
X-CSE-MsgGUID: N/CY6CiUR2CTOEV035oI/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71175742"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="71175742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 05:40:53 -0800
X-CSE-ConnectionGUID: laG6OIsgR4WCbqaBPguSWw==
X-CSE-MsgGUID: 3lA+qh71S0SMjjhCoGNiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="196378276"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 05:40:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 05:40:52 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 05:40:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 05:40:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI4xIzMYcHHGLKDFqakdheO+//lQEQVsKJyCmEvkx20odDEm1D70fE5fH8n8CRhRWCMPQb0419eMdFxmXHIQIZ4V8Ef8YoqQw6RiOlkFWMdFz4eKvnLHh1DiYZ8EWEZAvxkiwBAY2sGtYFnZUzXhYxG3lds/DBG5PlkCTFV7mxZTEbVDnckDW3N76w4iZgP4sTgu4s5wNLVd9RQ9hwBlgLNSYPpgXVBT0WagOXtxugHmU+K7obCXgY8Gkv3qG4a4zxGKXcrUHwbm64dKDwcWfnHB+4Tjzlu7SF7PjZxqd/NWdBJAkcgeK+/kiWzXCto05qZlDEM21f39mDJb4A5HDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhWT/K+pnZ4KicA3sCACRHLBJObKiUsf/Pu73bmhr00=;
 b=V70vApjdfPzCrNCrH+N9zAeeLWJ8bn1NsTU+tnLPltlSbGKaq/B63RhPppEIfOmx/MfTpMjHoimIua9TXt4YDbzOT45Y+kclYvcmCfvJkxAZKg9seQmfghwKkd6PAyL31DLptTkKfqDVgjSvHobdgRVqCrxkQ50n1FDgfnl/NO5xQDFejYeMHtHmoY2Gkc3z62Lsky0eOxPPAdpg83vIM/Xbp+JS2AitMD7nmCRGse5TDrJgzLZb8usqfXszTZKCPjc+ZyobykVthT69Vcci4CtuKCJxld/uX41WrXh9LeJwiuXIXYDAJxOTim8A6fUyic218Dy/GrAT10O1aIXoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 12 Dec
 2025 13:40:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 13:40:50 +0000
Date: Fri, 12 Dec 2025 13:40:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 02/10] net/ice: use common Tx path selection
 infrastructure
Message-ID: <aTwbXHEziGeam1_8@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
 <20251212110628.1634703-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2668a5-023a-4a64-498c-08de39840fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mWpyqur6CDp+XhzXG9a8/+lfpzSdCILB+m8eOjZ9Z7q/YwaLtd3G8DD5mzs4?=
 =?us-ascii?Q?4c9fvMEwO4VM12VL1B/kaCQyMNPPtufi8QPalhdCmBftU35SjqR3mxhHfXkk?=
 =?us-ascii?Q?UQDRU3r7ExvWrzX8l87JosD4NYOJN9Miu/jxI3i2Vw21165UbkE2r06jF9SL?=
 =?us-ascii?Q?C1MKKnzNw/GxwMVQKivm/nHwwE+UNp7qXRUS+7/zuELb776aw1xhrRxFJuO1?=
 =?us-ascii?Q?UuU0sfw/PWQwVKqUdH/HYyI1XKKEfkn+14GiNOYo3BVA/0maKfvdDYaftSKF?=
 =?us-ascii?Q?A2D7CSQNFXLV1cMKH/qaoKVd/bNZ7QSXZLS/WYRrp5D5EeJoOFWlz4uIAFbe?=
 =?us-ascii?Q?3rjC3/Rk6crhgVK7qGnbzywqYXs91l5XEMEAwidfzxM8MY67xO4QzncSHetM?=
 =?us-ascii?Q?uqtED6hkp++RNC1iRd4EnEwxz2Xsb0AKXqTsypOWoROiUcgIOASi4Rc0PwIs?=
 =?us-ascii?Q?Y1SkeEi1bVObJV90Xv45I4pIAlC2LaVUtPBnGHrslGZ4YxFVVRm5DeMSCjET?=
 =?us-ascii?Q?BdiTeMeHxMvPC/yO+OWhuezFvPLQNIGNj4RY/HdiH5oSF0N+W7m5vX8DmF+t?=
 =?us-ascii?Q?y2OQ1dDlgWb/AJ2zeg0kyxm+ZqRHpFwd88FUSnng6Yx0d5jfX8JJL+MdHMap?=
 =?us-ascii?Q?CJhtOIN4UExbBmZ56rSWmg70edlBiL9lsxE+TAvaO/IFRkt6KhaWlB+oEgKE?=
 =?us-ascii?Q?E3feLbGoRaleaBRxruhXjYZ6QYeRFtENodqYDPAhESj0KQ09L+w+4kCfhuJ8?=
 =?us-ascii?Q?pcAp9BOyZL7XXcgOUOae0ulH4pKWERhzrt4ykpjtr3kyNojlO0Af0SEo1Qcc?=
 =?us-ascii?Q?v7dbiXS2EZTLadoMUry5Wsg+EVDe9iuj9W9LiPtat9dfFEpIrWOjjuFPyWFT?=
 =?us-ascii?Q?eNiVioUGl+dP/WlHClBHLUKDFv/eGq6mQ73u5P/t9qFr67CRsLyzq8oFSsAt?=
 =?us-ascii?Q?a7/+REX5rbB5UlMsizIWOvEFNTRPxNyWBiBTMoNuU+ezZiUgQd+Mde14V/hf?=
 =?us-ascii?Q?hVUis+ZUJ4R5PZ9J7SBTp1aZ3+SJvO9hpptaVGuR/NjwvTlPCFL1oyI09S8B?=
 =?us-ascii?Q?Nznim5AZap4xtHWXDFlMNnWfintGHK7PYQiGLWY6QnM/hn1R1+MVLkn1z7Gw?=
 =?us-ascii?Q?cVUyDbk7Dkku/ByGNFFhhLdK9OVMW4AjNcn2HfSa89i+lBFqPipUoCtfwt1G?=
 =?us-ascii?Q?afUM1/txeihlIfyKa2WKIBeJc+yKx+hWbNv6DJUAGEUMqfZbgZeVhOVKbHIp?=
 =?us-ascii?Q?u6jNUrUZABznmv8lagTamwe24CmdvixDafY2cf9Na+HV1qL7okR6f1iAj0d9?=
 =?us-ascii?Q?qw0Or8vaLWzTyYeYA4Cwqd4okFNmL3cYzhI2pvjivZ7qnl5+IA8r43IFxoEC?=
 =?us-ascii?Q?a98FhiLV4DEdWP5aIOLTBIjn2/CwRvN0EgDiY1y/qPeorMoMh6bG0624Ol+Z?=
 =?us-ascii?Q?FmwYjLslWqii4X/cvjsiE01hTAfzyM6V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGy98w7ynLKlgTikAu/2Kj1ecrjyvfP4brlU2Kt1aYMuf7ABqpqScmUawWMU?=
 =?us-ascii?Q?DwJsK49O7mijkleKUVrzCNpEBPEMqgBNB+8Zr7iAZi/O1xJcNx2nWnn5uV90?=
 =?us-ascii?Q?xajJVHcCoLfX59k3Cd4RMp5+ArP1LjdOZV1F+OXttAc5rIUs99XOedvjkAS4?=
 =?us-ascii?Q?wSOMMh3fKxvdHcj2tGBGXNme8SRQ9/HEG5kXrKbLvxzcKBMju9Rv8Gm6Jm4x?=
 =?us-ascii?Q?I53hga4XSK0UDFc71DIDpWAH5c1tysDHhIVRLTGo1ULuZGmy23XcvSslgijK?=
 =?us-ascii?Q?porMweAXXXMbS7hQwThGQRm26pO6DjUANeD5HHydpGOdpXzeyJrrDkD0jd7N?=
 =?us-ascii?Q?ByHarilpO2PALb2CEx95gTYOYuMb58sgyLAfxi6/i2sd5BQ/cYliqkfEIHg8?=
 =?us-ascii?Q?qNdrVlYgg9DyyGaeVg6OmF8X6mLmyTJ9tc6pUl+xHS9cHeC74Ahwo55VUYOn?=
 =?us-ascii?Q?6trsRbQtT2cvlAXBFpqCaLCdvY/AvA+MX/qW9YmmqPbzLlDN2kIWKoJKGLFY?=
 =?us-ascii?Q?4G2gS/OoUSfzBiYkSv3md9zJQ9jgoF1g4QbKYatcWEEZkKhsWS0doVoftRNz?=
 =?us-ascii?Q?5d3LYMr2CUf5R8Xdba9v+S7RdC8pcN/Ng8rOCCApyMAeh6A29b9+AOZGNZ/m?=
 =?us-ascii?Q?EFsH8372PI37wJEnx68Cxp9kOWmzq5v8WPkkpwmJrB/ppIx6CSgWoXP/RdVq?=
 =?us-ascii?Q?obqQ7H4+LHcrLarkvNv1sSootzJOu0RlW1pe8IfgaP4oO+eup+Tj+fOda1hp?=
 =?us-ascii?Q?Tt4gDzd0VMbespX+60ctdMK0c/Y41tXhizKGvCMU5+LGKYGcMcZt4VkqsTds?=
 =?us-ascii?Q?nInhES9zTivL3mkSolJ34YbFD5wKGu9VsBBlMwm80T234etvyxz/MTkUKwYo?=
 =?us-ascii?Q?23yOmh+CfrEAMrnic9yQt8dowMYWm9q66sCnLvYD7jfhKiNtusf1RrhZMf2U?=
 =?us-ascii?Q?PiQJbeMBk66ICuLQlAedxJbDoOj+4kkdoS4hL7aXIOeLBH56MOt1Kr2v0sx8?=
 =?us-ascii?Q?wmCvSiqq45j0sfB2MNhOVw22SCkvezz6vyqYzev1ychWxQSlAZFXvwI3Jx7L?=
 =?us-ascii?Q?NuRi1+5/ssPbR7nSYPMKh1Go70kd7n7zrfaXUWwGUUhRYo4XTZVZaOE4uwA3?=
 =?us-ascii?Q?jyQUBZcInRyrDDBIcuZsBLoBp1hz4BenDUrD6XKCP4DjNiZKfkefFaFNP9b4?=
 =?us-ascii?Q?C2DXFMlPytTJ3vdAOviIi7cXV6yw/6rh/7cTzoLz5h3M7MRDCZpqqh9IvLGn?=
 =?us-ascii?Q?CUKaEXIWywdFdkYQR1phWzy3EwGmfCL24UlL4UEmn49LNZlZhuva1nMyTuHw?=
 =?us-ascii?Q?Uo2sib84UbvQnLZpy/fdnwGrXMo/I2SSPj7ad+SiyQoi5ZPkX27QlujpxozF?=
 =?us-ascii?Q?xgOAkhATlOHkodyMTvF/Ge7iwuUJcQ0R4jFMDvOJigNW5UrXxYZEoLZ/rpxC?=
 =?us-ascii?Q?XuHhZsGiX7qfbTgCuk745RSUnPkEOC6Iyge3+uOj5xU3J1iDqoLeS8WuLFNr?=
 =?us-ascii?Q?GNywf23XUV748dRQ6Z4oqSFDMU0NsfIkWQZxC7WPwrXCmcbsWcN/OndojpiZ?=
 =?us-ascii?Q?p9eHd9qtXF852v5TSoIkRqJgF2TMJLqwH1FtHmWUDnyCV8/wxD7CLmK1h9RM?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2668a5-023a-4a64-498c-08de39840fc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 13:40:49.9365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TF4e+2AepuUI045Rvt4iQAaRPzEfhpfFftRLscoE0gjaQtS9R7lOZQxxIHlXJ9Z54OlQ8uRyLCHgejDaTtBkFh/G1e3Frz4YMiWVjapd44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
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

On Fri, Dec 12, 2025 at 11:06:20AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Also let the primary process select the Tx path to be used by
> all processes using the given device.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

