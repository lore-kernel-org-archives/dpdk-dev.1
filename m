Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B988D5E144
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 12:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB69402F1;
	Tue, 16 Dec 2025 13:06:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 602BB4026D;
 Tue, 16 Dec 2025 13:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765886770; x=1797422770;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UyCt3exC3K0npzRYPKRYPMpD4t++2STeXpHJCqoEF7s=;
 b=RReY+c6foGsxxHHUClompbu56RjV12e0Vq3cSHEjuWPGuHIjnujRHvVA
 FKrS5poA4f1GVXi7XMziuNYkxRHPx774C0Jk3xWVEFS4W/tV3DTZ5cbki
 przCI+QhRiiAKCgxR2dxBHgL3b2ry9SKYccZyGxKJu4hlcAT0b4sRI+Mw
 HyhoF+2pb7vO59hQbO/8Q08W+MtopiZnCkm3oBVt4dpP3cekUX+A3B/KK
 R7QrYrPdO6Z0Q2o74reGcYz5Ytnb8uDXeXkRRgnFUFUkoV/ry3bFPgpcX
 19RNMzyvUpihAtbCY5+m09GaugHfkb6zTemUki2v+0QfbAZQ/cbstmY5z A==;
X-CSE-ConnectionGUID: zUv1oDOKQUOZ62zxUtN7EQ==
X-CSE-MsgGUID: 8Yl2/hIUT0uyQwlSilydqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67557184"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="67557184"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:06:09 -0800
X-CSE-ConnectionGUID: 8mHg8g3yTP+kF03BpF3Zxw==
X-CSE-MsgGUID: CNErL2XhTc2ciXzCUpAlpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="197981559"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:06:08 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:06:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 04:06:07 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqXxRFTfPJdViOlo8HsnyPT+I78c9fY6llaHxEjnKQGI4VMd87qVXjZEOaN+yLgsfMKwvKMoHyMLnyLOioldUzxDyNa0N0qGQaWk7ahdp6AeTIwOtPLgjItG/M2RxbGe/t68uT9B22tAUkN+WX9fAMD/H72cntNbdlWoEYj5tzSkeEmvvzwfRxEIqUtxNkDpWNRhxh4FY5Anljss9FCnG928zg05qXZhUXcEBtQKdj2I+9BPU6e09iNsRV+VfWR/sg4fXwcJESMoihH+4szrJbLkZpgejcEHsYNXOWrsDwN+TgAaosWJ0tGuLKHmQQrSfd2lchmgZAiYUG3dXEdp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ36ByOi8LpNo8Fp/kDzSkrpUTnz0MgnbRYpqwxGIBA=;
 b=YS7iYVfv88jWO5fn6tIAwe9C+n3zVXwirauD+xCXb6SetCkkxiAj8B0wJu1tYj2RuMGj9hFAIE/ovIA+MxWCXxQyrBpH+kiDJJyADPKehf98KbsQxeHHi/KKPv8I/R6MyijGvL1PGi0VELjmi9J260sC8ap1iruA/4ObHIKhylbCMAbozjzEDjQ5kABffpq+y2/k1WDFBLLErLxaJh9LbJm/wdQmLAkyn32/hWZXgwp8Jk+AWt+1Z96oMHtRa6g/rktZAkTCGM60y+ue0G9/QoP31AFePFVbWrR9lWX+dVfn1kmPw6jXIZI21pzFGSjlUoPVywJN3c5h4cCPkYpYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:06:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:06:05 +0000
Date: Tue, 16 Dec 2025 12:06:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/3] net/intel: prevent selection of a null Rx burst
 function
Message-ID: <aUFLKV-X8r_-JcCT@bricha3-mobl1.ger.corp.intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
 <20251216103504.2624535-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251216103504.2624535-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0179.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 10666be5-3e83-4202-a3f3-08de3c9b7d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYbDJ1fr74qKeYUZX+zYRDcHr/rqyQbyDAg/SQheFpB9Yr2vF4YCNYYZmmel?=
 =?us-ascii?Q?bID9imj6yKEz5MTHo83JpsgJZBfTt/2JiZhX+6024a8s1pkomyWdQERKaYqd?=
 =?us-ascii?Q?EhbPlMNtZ83mA2CFdFdVruF3EFgT+nQ/MZcQVgcWC7e6yPJZCOFC2pt5lmp1?=
 =?us-ascii?Q?dHRzv/Og2oGxVyx3EouMOSpb04YQWitaw4IwwEfi2sEhIg0nTLl9GPCrlvUm?=
 =?us-ascii?Q?KdMc/Hp3NIeDVxsHo/qDacc7CVlC6RQk2JmREfUGIMA9GuBvqy7xcPFo1aDn?=
 =?us-ascii?Q?dWtUgMFL7Id4dJv2LoogmhCacwuHCxoAdrqrAXs/P3t1I8F70v9haRezmlCe?=
 =?us-ascii?Q?LSKG36jlON2+UnOmDbSDV42rf7X4j43/RH9nQJUoSms3bTcbFsaLyPhgPw3a?=
 =?us-ascii?Q?HM1Svlf7OpgG+C92CksFS9k1IzpmBr25wjhZpen8+TZgHMGhFLiVR52DaBX1?=
 =?us-ascii?Q?rCOwnFIurmy7oIDOS+oqM3tTMwzkZjEO/qAX21owdwIKnK62aYZb5C1NO5vm?=
 =?us-ascii?Q?ZoOHsK/wPp1ovHOmikbxU4bFm2GIZQTi1OUfPxhemi2GnVwuLBONgg7KSl4h?=
 =?us-ascii?Q?fYZM5bA5XME0gJJ21Ja1Qa7vpnF0l3z3Onv1u8N7nz7ygduRB6BLdLLT9wbK?=
 =?us-ascii?Q?b17PHHSQXNPNcUsjuZjYD6DIzzPRPbl+bjG1a0FSQ43pmUsrnflQbRovsXnS?=
 =?us-ascii?Q?R8g62hvkXiz6TS1rBH7hl89UHd9hrQ6xU5m/s2uJZg06A7Z+4vNAFUkRNYdv?=
 =?us-ascii?Q?axWBB6rOQfABIo7zCV68XUNPpGebQqehtqhZOuYBmZxFigyORjTAR3ypBeSn?=
 =?us-ascii?Q?gBgtEwpRvcpRFWmrH4puVHq9dIhOZ3WFMcanz5naeqFzAg1mwvZyria33za+?=
 =?us-ascii?Q?UVgQ3SiimZSxOAzIe+J/h3rBiOdDejgGiM5glG31g4kLNvkzCRGMcCxuzlCT?=
 =?us-ascii?Q?1kkw1tRJIzzeBxWtrpero7ieBww6TQX5jVMTRpqhzVruuwJfSqQa6yVZfwfs?=
 =?us-ascii?Q?U7a3c8Z9MT/2Y8tInoKZh9QbiowKR+b2R84Ozu+bd7RNvBiygYQNfdRKXj6f?=
 =?us-ascii?Q?WOP7V95BDM+gUii7nUMj2Z5vsrn/lUHge2W7kYtA59LRA3p+iS7WvfZk/Qiu?=
 =?us-ascii?Q?kuo2cAaXKLz+VxHTEO9c60wGDTSQi1jWTSr+E0T5I2QOweFBuac1HYAncU4G?=
 =?us-ascii?Q?tZHMJRAyXXZnWUkldyODzzCjNeZk8Lu95AyqixojmZozkrFcjBUhunNR0tGk?=
 =?us-ascii?Q?+FSCdkH4eCLb6uYdv/h4HU6ot/KVUEHlc2q4eQGAKGOFhrepCTbMkn2Bl0tq?=
 =?us-ascii?Q?jgclc/h+o+yoERZ69B4SOubGPWJgaK3dquTBT+rytt5ngdzXOVRhVktlIyxk?=
 =?us-ascii?Q?X23efxsjKhGDrAU7ZHfYbybBqsJPFMtJu4AFK7OYL6jVp0P/+pNvvFqp+BPZ?=
 =?us-ascii?Q?ptdcFgtZD61JZtIzgRbBiWfuGoR9+GL7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3wiujG2VjxBA8hqigxfjdgYe1TsS0cwu/hFQmZIBSusY0T+7LGYM9OVHD+T?=
 =?us-ascii?Q?v53YQF1bQiyvfesXktFcQZjFvrlCS0fxlvKMbPCI7AW1oHb0DuOWTPU3vjzw?=
 =?us-ascii?Q?a6ICcOHp5jAENE3Oe0v7S+cgWuqdJOrJ4d0Ji/rumtPceAV3t6+edr5ZA81V?=
 =?us-ascii?Q?gIfMWDzkdhietZCGT34QKeAFAn9ZtXOsYPbHbJNdNfHZpp7Ssl/t+8gdKv5/?=
 =?us-ascii?Q?cuTROFF7ipgu60vMqr/C3httgGqkkIlPIgEX+bWA6zZ94q5aVsSC2j1Jg4gT?=
 =?us-ascii?Q?QO9ArBlmYYOqWIxtk3uL3xCBnEvyHlX7BVtGUHsc0Bag9xM+Xv5vOL6JZfYP?=
 =?us-ascii?Q?RaBmoYas1jFSfkqNI86FbHRQwESyzSHF5ggoFzjUtn1FNmotnOGUMzQ/eNuF?=
 =?us-ascii?Q?e4F9Hs5lTsS30+CFp4yuUisexKFopmnOzRVgtrD/8T2UHE573DrjWfA3LU3F?=
 =?us-ascii?Q?xOWtbeAe1Dqf3e5Ez+uf4JilS+xPTx/AaxK+NsKRIIICdbGhYCcTB1n0RFEd?=
 =?us-ascii?Q?XfHJNnxor/dQG3BpMvf3IXygvFb8D4rA3ZmdqGF+HYr4/4nKsLzlr7+BPpHr?=
 =?us-ascii?Q?Ue9xLlPwKl3+shT1nH19lgOy0Y7kbKeptWnWv1sxw3pBLhfO3LmKLAWz++I6?=
 =?us-ascii?Q?JyMXMosZYgbqPwM2oK9wCYb+EGZgCS7vxeGof2FD3KiD1SHTuNC+Hm9inPss?=
 =?us-ascii?Q?2BXVlLBVzq9yveGfsqY9MrHFChk3BGX1evwS/bQjYJWqTeKqC0UAyCxao21M?=
 =?us-ascii?Q?98u2VdovfXAPx8Sds1q8irwgVq5D4Stkf4sM3S5TlrwKXvYnzzODkfEu1h9+?=
 =?us-ascii?Q?kBqoioupr7DN1xn9UYqS/BEI2wVSxdkdHVm15l/ADuu2MUoVc6I/dt68vwDQ?=
 =?us-ascii?Q?m/kG/7J4A/qzfKusx+CeFXQP9GYypbO5OOfuO9922Zv54nQm2azR17BPm1Se?=
 =?us-ascii?Q?LZqQRWb/N2DptiKDkY+GCoI8uYSu92lZV7MuJ6K6crBaCQTH4/81Fm+PnSCh?=
 =?us-ascii?Q?7daSyVZIeRNlKMY2rjR8T8HASJBQ8RuYYwOWeWEyB/66Gzm0IrQMnUoVlMjd?=
 =?us-ascii?Q?Q0hfb2qgGIRnLSVuwQ9+foFqTNF0Z4VAVO2f5RpA5twHNcPHKBR01U+SElDm?=
 =?us-ascii?Q?nHhTYsdgTVzq4m43Q9xYwsUgGIjoCNTi2eKgyIngJbhrlTQzHk1w45z5Tlvt?=
 =?us-ascii?Q?6mHDUrURNrNlLrLl1jx9Nm00yvWF7JkjW8gqTFDliOYch0Jpo/u332FDaW9n?=
 =?us-ascii?Q?yyqwNMXapbR/DLwMm3M1+MuMhr0sfF2M2BPNgmc2tDZJrko3IKFEp00eXRnM?=
 =?us-ascii?Q?87n5WPwOFvJmTJx1h6eZ1PGSKOTkLtm2C7uRvU073XBWddjgC1fd6vm8yezv?=
 =?us-ascii?Q?h4E7LOA+EheNDE5NJsImgnpIq+g3ju0DIjlK6KpSfS0KkjfVx7R/u1BC2/yD?=
 =?us-ascii?Q?NqRqLui650sK6x4s5ahyZz+gR90934MuV3uOIsTw5lt4KP7UBdo60YvJmrmJ?=
 =?us-ascii?Q?BwIS2LDM0FrtSprUFZl0UlAFga1KOLmShovq54006DoPwsS02lKSxdyscFFW?=
 =?us-ascii?Q?RfUv65uiWmwteNpLKb1I2OuBDDsxfz67ADsfv1n0qtEPsx8p7pvTbX2JDmuk?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10666be5-3e83-4202-a3f3-08de3c9b7d4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:06:05.4302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0wsiRmOh0kF4hRInBX6g4kQ0k1UEWHQS/w+fWhxR5HciE48V4dSKinoGuFc/9fZnR01ljnRfZ3c0CLbA8zELPHY8TFFjEuZkaIgETrOSq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
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

On Tue, Dec 16, 2025 at 10:35:03AM +0000, Ciara Loftus wrote:
> Depending on the underlying architecture and CPU flags available, a
> different set of Rx paths may be defined by a driver using the common
> path selection infrastructure. However the Rx path selection function
> iterates through the entire array of potential Rx paths, regardless of
> whether they are available for selection by that platform. This could
> result in a null Rx burst function being selected. Fix this by
> discarding paths with a null Rx burst function from selection.
> 
> Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path selection")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
