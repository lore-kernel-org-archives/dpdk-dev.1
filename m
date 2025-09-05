Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E5CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4933A4066A;
	Fri,  5 Sep 2025 17:35:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 18354402E7
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757086544; x=1788622544;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z+a2n+PQvnPIWFGrby7Yk8O8qgrI+4SBmZ/sVfP6Eko=;
 b=NrTEQFjMDdYFAhP6EXZKIYvg3J6QSU7m+kVdE+KEfCcbzMkje1xEjen1
 eX8ANjWLO8GgkOZEx2H+0ua6OCbMQdcEDSWeMXFLMQ+keUns2ePyOyA9W
 78629mLlQ+kwPQgezJ2RxiHdDno6P7iTbrKnIX11esh8YcRdGvYqvfd0f
 g0QyNYxG9E0vF36kPF2N1DNyAlGbrfkINu6FyaLwo7z5+X013xqgsxok/
 NzYPNdd049lygU8GYI8gZFbqZWQ5Z9xMrac75ktWhgMeGtisuIMirkop8
 hYrSqJx1woSYcUlT+prGtkfCp0QnTSHC3mJmsMpJee+A3lK4KPbacxtOt w==;
X-CSE-ConnectionGUID: ToD/x2dER82ziEAPXDVp8Q==
X-CSE-MsgGUID: 50fg/zSAT62PKbXOtHcG1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="84876023"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="84876023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:43 -0700
X-CSE-ConnectionGUID: dFO55yvsR+2lt5MrXlwkOg==
X-CSE-MsgGUID: 7QQsodh/SoWzEjLi0cydyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="171468179"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:35:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:35:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVFCT7+6wI6c9m5tqoGlnNTpz5g95mujV8rM03I7PMwQ9UlJQysn8VbL8R1uz0gGdDRWkwP9DgncuMnjfLlX62xJswdq0oxt+GFDYDL8vbVkwKBqEoKN92JaAPsOO5J/+G/yefKtX88DfGays1GLpWxXCfh/NKPTn1rW/q7MFvytCNm2Qjj2Bo7jnWxuSbTBzvkecSL1nIOTkddQXTyA1rcr9D5TDX7WIRrsPZMLlj8yJZg2FtqquKwXmxgpRZhlLhueu8dzaA+R87wmdhukiE4+1hcAP3G+QwaplRFQhoUR4C5F58doCo10YDZv6X+jtl0KMj4HPLgjeJMqS+xQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDI/G64uCSr2HhGVBnQebxxRNPDuRf9Z1oJibO3w2/c=;
 b=O5dC9Nz1fzwr+q1QgVAeMP4An+CmxPbBzIWFt8YR8o0oaLOUKXgJq4KtGKYXB+mlpLqom3fuH971+uYZ3Hlj5Uwoj3iJMzckGS+/uj1hZB1Mitca4pwXcwfQt2RKrJFRRrIKqvLOu/8BgLuSaF5XSSpsVs2iGrbPbB7BLU5cP7u5pSYvBpX2wLAgmt6tin15piC70b+g379zil+QSEWCWMAAGqVfRzVXFAFP/JQ3cd06D2IVWhte/NrycrynzOVdyxgqXQ99CXlb+VnlOsy3tjAVg2eSt2QFMHF8Dwz/CzSMSQJne9VjtSmp83Qo/wGVJAdO1sgMpGVGiRyq2BD+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 15:35:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:35:39 +0000
Date: Fri, 5 Sep 2025 16:35:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 11/12] net/ice/base: add E835 device ID's
Message-ID: <aLsDRn86Hlyl5pzi@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <0a69285f4371dbbe1f2445d566987781e25720fe.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0a69285f4371dbbe1f2445d566987781e25720fe.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0221.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e5b981-4a41-4580-c14f-08ddec91dd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+qWbV3KXhgiug8qyWpq6EJJiYV3QRErD309rnN9zEqwmdinZt6+Js94kD+cY?=
 =?us-ascii?Q?YJPXJMSPve7PRUZgfwE93+MR20rh7GJyI+yBwmAxoaeUXDt1HSCNZUr3+6H5?=
 =?us-ascii?Q?myTPwtcYnuSbRcYFZNqke22KheoOnnDshL6TKxtOPf6WFzrvst5XWZ9QrLOf?=
 =?us-ascii?Q?maFt/zZtCJifpSS3rlya0N6NovfLOFGTxD+l9nk7xhqdKnXkrWmD0R5LLenI?=
 =?us-ascii?Q?ksA8KN3ovET0hLpxgzC/dIA0eJSbjhEcsLiWJeG/w0n8u+QSx9UxlcrdUrtO?=
 =?us-ascii?Q?R6yMoL0GPI+jePL40es0SgvUYfHZQ/gZM3/gCWr1IwddoBvdfCVQgxBurhHq?=
 =?us-ascii?Q?F4DMaYaDQwi81Zc7AaP7mn+k7o5lUnXLJoKAG3lOGlSYcPm/QnozUuNfDFJL?=
 =?us-ascii?Q?lDWkngTon1JuHF0Vb0kxb7aZCIuIRIaBKWfbhoMo3OXGZBNwEiydcVUrpPsY?=
 =?us-ascii?Q?tJ3EBoalvulu8Mab7fetPxLW5LkxEXkK/myJ8FxpT3OpwzHXixrJ3YU7kuuw?=
 =?us-ascii?Q?dnW5OpiUEx9kI2b4d/+6vuUf72kjngomgyMML9GBXxeiU8ROsGSn59ZGEDfT?=
 =?us-ascii?Q?eOLqqH5UOqZ2bRQJpbu+t0tS9canKqcld9VdHGYnagvcCV5731NxQcb9AztW?=
 =?us-ascii?Q?bIuQxxK0eH1Jp/U/vrkmrEZmnhgR91PfyXj+V8Yay1DGmGArWtT2zBy6Xd9v?=
 =?us-ascii?Q?tWLn0ZH/M4k/cIJLSPSABvHKJ1c33w+Z2n3obiZCuTHRaJJId5HW2armhv8M?=
 =?us-ascii?Q?HRcCTtxHeT2YBNJbpMINOhkjxenfvdvDZb6rT8lOjXvpR7ewsvlEOjsQNmob?=
 =?us-ascii?Q?6WLl5kJFISSqtgost1t+Zu2KgV8T0ZhT2nfQ1vAX0tzz8XX/gF8Arr5f7+H2?=
 =?us-ascii?Q?8Q6lpdnlXrm+rAc9TqNO6yhBYLiZ7BJYmWr/8BwUvpmtC77+lzN4hDKrqXYY?=
 =?us-ascii?Q?qXwI4kSZ7SqJDw0v0yJuQz7m125v490XNvsJoCDQ7A8efouPUfBmuCwmN3tg?=
 =?us-ascii?Q?Hlaj7xMU4f4piF1LApNFNuIl+RSug3Ns0vRzLeTiaWapKmaAdiJr9t/tN8TG?=
 =?us-ascii?Q?nREyA/0IWpk1ilE8gOeJ4H1DbWFQ4UJ5OOAr4Qzji7XBmeBbzwZeqt5InQLO?=
 =?us-ascii?Q?GKXFxdXtYwoSWPDFqNrSbDwiu3e7VfyYrqdfFYvZLVM25Hey9RTB2/d5FI1C?=
 =?us-ascii?Q?nBBP5BgqfEg/Lo+87UokjD17o6zcwzoUQE5xc5RBOvy1DRCYuRL26ZSefsUE?=
 =?us-ascii?Q?gEyozqNA2eynNHk8wWbX5FEAcIfSzBXrkFsYYTqpsevVDZ2QkKCw7xi0f8Ti?=
 =?us-ascii?Q?jM5prdwx87hNw3X5Ujhdbgjixc2NWokeVJCvugEQW7rBzhmNMet7zHnCKiAE?=
 =?us-ascii?Q?cBEG8sb3J6h0Ctz9rrsS2YM9wY+nFXZgOcqsPsrAokTRUYt2WA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pn4MkzSdRL5hiILj7IZjosrEy4/octTK2TNp1MmrPi8GGLUeF9TJOSUx/YJF?=
 =?us-ascii?Q?+fDk92DaVk65m0QqGArYnW6ZoXV08S+H+q6QVc0FPdRhnG1hL3/YBdkCwyHJ?=
 =?us-ascii?Q?RBQBZT9ZGyOSaEddmrs6IR55pfiLgLgif79ZUOyCOk/ynYvElOUA+8sWoqrH?=
 =?us-ascii?Q?EUN83jjZh1XSlG+Hu/bZhaofVK1aVfCrXejGY7tE3GgIokTDwU+Jq/GHpIGA?=
 =?us-ascii?Q?UESJd/z2SycxfLRx7n+O2oyQxPDvoTbRMRaSdBFciljZvf6gRAWEyMOv10tY?=
 =?us-ascii?Q?mtCgOmpE2PdVOlHX+FWK/Oo8sIgFdxHlQ+11uS9cs8iu8o609qLbKK/Hat8P?=
 =?us-ascii?Q?GeaTyo5K9JE+M9eeuxitU9wk2/hb69fPo5T1u+oW4eolbICgCFGa6FWC2k3B?=
 =?us-ascii?Q?uspkZm2uThhAXVTa8ZoskgsnbS33Jw5K+fH3a3Gf2IDvrQew6epRm4MtCQCA?=
 =?us-ascii?Q?OB07bMCwpuJk3Sq59MtlARtcXIX5U+QXVO8P2zKWF/+ssNl9Yq0M1qxgu0iz?=
 =?us-ascii?Q?pc0L4nlzz8DBNwCJn1fT5awb6U/qy39Stibs0QGQ8Rq0RSZ+/dQnnzlAsHB5?=
 =?us-ascii?Q?1LwCLJcBcfdAMLyrfNocPBW356pD9mtLktY/TKqFMpdXJBYZ3/qsZ1TKqzrn?=
 =?us-ascii?Q?UOCzgq3g3h7lIttPDiIT25i2UXk7j2d8XcRNJ29+Nd1oIhpnfmwEEGLU7wOP?=
 =?us-ascii?Q?eSa8riTrUzyJgdGSFuBUA3fHp3FdMAT7D7u90vzZzwbjUSZFJGMfCfd1bbei?=
 =?us-ascii?Q?iGxVLXV0DWSAFTeJXWJrQX+K3wJQgktAdXhlDtJHgx7iTt925fDHibJkUZFJ?=
 =?us-ascii?Q?hY86pT2tucpI8er0udtfNyBNMU3nq/09KUu+eYppqUaatKfZL1Vv+3VT5BUl?=
 =?us-ascii?Q?uoSKwnaoM+uRKd0BfZ/w7e+g0FivC+EIy5oXmT+T8AxW4j19fXGjD0ufnfQt?=
 =?us-ascii?Q?+KUDoPyOuQjBNjbh+8wUYfOlQLhGDi+SppzvWRCQhK96Td3LAN7hMnZRADDj?=
 =?us-ascii?Q?TcvXBEmGiDuYEQExyKKENlrVCxM/qAvvDp+kq1y1m3dCBlZaZRJtF3hQ6npS?=
 =?us-ascii?Q?WGmy/FiAHkWHbulodf8XeP1p2SWod2e7OgFxfyEwMa7ssvVF6ZYci5kVUfTr?=
 =?us-ascii?Q?m+b6JjLd+l0JYfp1nX38D2qb8ElXq4qVmQUkL1gjgKy53xWDp6kLOg2tr9L4?=
 =?us-ascii?Q?Osfo2H83s2cH7sTQYm2hk4xp+mrilq1MZ9D0z/sb45jlGTFK7ldcaFHNXr0z?=
 =?us-ascii?Q?ucAfdzdgnXCFvqgPtUv8OxX4vpSVNUG4gLy9gi7nqq7lu386xkybNI4wMyHF?=
 =?us-ascii?Q?crOqG07k6ZxLwsSMUUzag136G0xVCuEEQbNtuYX7lFyrwwppaH3MmwQoZH+R?=
 =?us-ascii?Q?6POA5WtJI0nLHGAztGLPo4+7A5ho9tt3hli5HvcF5nC3tr7lZO7cxD0PV59/?=
 =?us-ascii?Q?PYHcrz5nhyKn7CC5AYbMcu+w4cBjJRRKEGaTRSsw023AhET+3Tz/BazBYnRK?=
 =?us-ascii?Q?OwHmufwM4Q7k1fg/u6qudMoBjpUAYpFwIKkgQmGGxoZIcud+ifLR02kbnT+J?=
 =?us-ascii?Q?QBaOrxsrW9Cg5ODJCnhbHgW9fiEtboa34tjThSfLV/DJVdB9wpI6GSOADWxU?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e5b981-4a41-4580-c14f-08ddec91dd95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:35:39.0218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO65pNSLWxz5hKL0HoJyGgpjA0Sdf41SMUEpOWPVS0xS09wvrpDfO5cMgngcbIM/T88AnlU110smYTN7cega7RJgQ1aaKzu6wqGHYIIK2q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
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

On Tue, Sep 02, 2025 at 06:27:01PM +0100, Anatoly Burakov wrote:
> E835 is an enhanced version of the E830, and uses the same interfaces as
> E830.
> 
> Following device IDs are added:
> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
