Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E2FCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E3C40395;
	Thu,  6 Nov 2025 16:09:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F3EBA402BC
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441755; x=1793977755;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UYkjNaOl1fAQW/wcvh1vxhLz7yBN9OrBZp1Y1elztwU=;
 b=nSvKpQv3VSzWlIZ9tx3HBxEuGLU6G2MCTjuXWiqt1n5yoppcLfAqefl3
 oODETh6LZBirmp8HvCZrbdH3cdFCL1gyEX7AWOv884tvoEdEfj3gUdiMK
 sOhoDjpbMgJ8YiCjHNgH9V6lxsB1nbZaiNwxYPhumhxxCeFwgyy7U1CRn
 N6jOHS/AcZyS1vyzm4dNxpNxwCpbK/+6PGmXq388sPD6nOC8Ra60l8yGk
 /CPvDrs9y5QrKbo5qTUVCb1q3FG3bX6pRWVLyVlmjfVm6oUZw0acC5t1L
 GdyZofO2coYXL79ruGXpfS/FstzqX+LmfpK2VEcSKlIaqLUEHOMLyKFRI Q==;
X-CSE-ConnectionGUID: DwCaoMZwSEGoVGQ+S4rUgw==
X-CSE-MsgGUID: cDxtHf9PS5qJp7ypGxPhkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75695731"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="75695731"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:09:14 -0800
X-CSE-ConnectionGUID: 57lMFA0oQIOFyF5RGypcLA==
X-CSE-MsgGUID: kto76rseQ3CPVxa0Q3tViw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="211237492"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:09:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:09:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:09:13 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:09:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBKRadvUJZYuSmXy1uujaL7LTW++X4V5kv7UzEmvBwGNtyHvYeTjIBcMnErrZxq51zHh9VjkeIW8nXvLNIpEDxAvMMsQbu3TfSlOTwA7pGBukAOFpJ46T4Greg1lRfwszn+D8ZmK/sm++EZ2tCbri9TN1XhwKCumV+FAGdKzNcI1j5wh5hojj3Plwo24eSaAnqKi6xn9cLrM43wsyDNBajr3HisjRH5nsTmAL58w0a+kY7zTut9iYjxteJtTJp/0nigGNaJvjIILK4qcqaRke5179ACHROkCqEK4PHFPAcGF2n5V+qsoiHw2su4ogYK4FfNticrXHPdwdQCY6bmZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3EHsCgkLM8gLCO8HgN/X5hmwyPsl2+Jt44At5L8sXU=;
 b=sFa80PMGxwy7rmw+ZoFqOHPnLpWVZAFsJdbfIB/kecIgZO/pWtTPQrHI3DhXfJCZK9PI4Ob/bw7gVmZd8kAGUY2bOLUQqlrWkxWTUpCBp7xjLgrfKIME3G9xj2xOJphfG+4eBxSk5HiVE8YwuFnFKZDJqWF4ynhyPvzZF9OuEEnlOQVZcN26NnSRhQor+ePES2hzry0v8oNXtcpL/lgOD7o9Fl5CHQGJ6FwlrJRGFpTfNyidpYBm/rZq25M90b+oMdwHClK2jtsvbBH1uhSDWMCWyH0aJ5X+Ttp549XZLPymaOaYlf8wxkwBJ2Km44hiJvc3WcMwi1293UC7d6Buaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Thu, 6 Nov 2025 15:09:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:09:11 +0000
Date: Thu, 6 Nov 2025 15:09:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 3/6] net/iavf: ensure correct conditions for AVX-512
 VLAN offload
Message-ID: <aQy6EvibXbC4jJ5i@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cadb25a-8993-41a4-008d-08de1d4670ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eK1Aen18SE6udK0fj0y8WdQ4aj5loCH0/0YFF8IM3eEHqM7DUc1sAClEPpm3?=
 =?us-ascii?Q?jnAANlYlulstg5o1u+T3qaNT5dh/NxcKviatmk1m2xgkL5Au2oBICSbvCWxa?=
 =?us-ascii?Q?XBRNHr12fIixrLEAuM09CK7fXATyU2zaf9F2wktNeOLp+SP/Gp2wweRoQ1vB?=
 =?us-ascii?Q?X+BZzt20Uikeorv3ZAplGNzp7TnemBSe9DXqzwnJYCllByqqVkyqx0+7+o5p?=
 =?us-ascii?Q?KWl4GN1EMVvlb/ybJfU/XmgXNC1CRB/QFNLRqGxYJc3th5MDh8UdvjklyDXz?=
 =?us-ascii?Q?ANtkJz0LcOFhcpWAKvioiCtfxGy4CtN6OH+NHFYsX7Hg8kBrWvb0+AaAwJmY?=
 =?us-ascii?Q?R6taFsJYJWZ+v1pzA0d5liTlS7/Rdzz76SkLZwtlF8yMIngFlNxaMuTM6l58?=
 =?us-ascii?Q?Zq3ZVydAis+6DNwEacxYsVu67KWqqsO5RHmLhMokD4bNqMYVD/EiXwGMLPph?=
 =?us-ascii?Q?Zt9fQemgTOBgqyPzCVJYxpJ+8/gb9rK8k7Ionf+R6GZCpYH+Z4soMTuryoAg?=
 =?us-ascii?Q?UaSpWHx14UpRvYYB8axjIHn3YKTspHWKiZBXFkzDsXyxFJghiWfkngQiLe8k?=
 =?us-ascii?Q?9Mtgmk9NblUaGSMaJyjj207Zj3UrNovoUUjSgC26ZJ4WrEm3WWcSgsv0LNBn?=
 =?us-ascii?Q?TjGCkR1CLjrF9LVy4mtjI/fHRLbfnqybNuTymKwg2/B973Ch6V3Eh66rU4ru?=
 =?us-ascii?Q?O6u2Ca/fEQLY8J6dNnKL3tJbH1HXA5DmiMbM0fKn5RaYltW90o/c3UPLOARh?=
 =?us-ascii?Q?s9zUEhEUQp5IQ9FDBRdRA5biUpkchldTY34slfLFYPY0GyL4qCUgz5NTX3o0?=
 =?us-ascii?Q?IwR9pSj8fW6A+VTHyhsJsioydPoAiSyPYrhnilUJ9Uf443CYDNvOBcEvCKAR?=
 =?us-ascii?Q?X2tQDbHzrEDwUJeeXEd8iBoSIS+GGKvn/1xlWG6poFVh9UNBdCVapA606Woz?=
 =?us-ascii?Q?smbwP3ygViulu0ydbnxnNKf3SH8EO5cTbrrrz40uz76KOtOl6jWGNkfmTp+J?=
 =?us-ascii?Q?B3OlUVQUlTRcnXJXjaANyEb6lSFBo5cmHAFRQpmL0hYdwOehF1RYW3T2U/MN?=
 =?us-ascii?Q?zMmgrOCtd4CCHVL6fsOxBsrLUvGTf4SEI9hhpfyuiv1QK+rDao1FPbLqyEW8?=
 =?us-ascii?Q?ap7Tdbp2VJj8l4y2kb/H8cXqkgL5HyjSaR7uLIDOhkYjoF/VwQKDGhovjLwv?=
 =?us-ascii?Q?5OedKzd7MV5dyx68z/w2jSyE/zN77sHFE13m9nOoNs6MsLKpG4RLIsBVocb3?=
 =?us-ascii?Q?LfcZk3ngGwBHpnjMv7DkxQGgT8APtSG14abrjfZrDlJs8i8vc7L7sOhPDHSU?=
 =?us-ascii?Q?AGfAl1M9pzEDNNXmBvkSHXpNN7mqFOn6LB6E23puN/yw9bNE1pPbknM5f3D/?=
 =?us-ascii?Q?6sgYgO/dg4XJNJxgh2HI6MVNKnDlEJdselLttrWTYfT0Dm4GXUP5HLrm6q12?=
 =?us-ascii?Q?YeffmW0mTPpNZ5x84pgtcUaDHzsWdDER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NY3d549Ox3eU9q/ATS+s4XQYAhlODq+i29ZklgpuhI05sdRVtC+o+XLQNcLJ?=
 =?us-ascii?Q?zq1z0rRuKK2CwObp/Lev2PT+VxeFtm25gY0h6LixMwwl7jrqsTPRvGzpSsaQ?=
 =?us-ascii?Q?VzagtHrJN+4MiQXag9u2yuwsb8/Wsl83RxR8LmmtLwTcUhVfJz9rjLkSgw67?=
 =?us-ascii?Q?0CL8RyZHPJjfJ0hVyJ+6Ymog5wrRy3OEde6FMAdhMOIKvYF1T81H/PlOYy5n?=
 =?us-ascii?Q?DX2EmPCf/b1acRxl8aNSmff1tanvom1D7IGqYgm+nZOVQ8FWDfIS0HWI68I0?=
 =?us-ascii?Q?MEZ0Q1jbot6lDLbznhIrybcZ9N8nE/gSEHaONwzRcB7X/xOJUzXcJGZiPNqn?=
 =?us-ascii?Q?/Q8LgMklMNb7Iqrec4EjuvMbcBOziHHipO1AhFkWVvcNHUJxpyWbQ9fW3kaS?=
 =?us-ascii?Q?PDGVcquft3xb5JviH49SVLyuTAfOfu9lJVN7vImWeLiQ/TscKf4UfGozE4fd?=
 =?us-ascii?Q?Up0Q4NA42q7S97lJPRtkNJvKuok7d7oP/euBEubkM4NpRJRei3SLp1NYA+W9?=
 =?us-ascii?Q?VC4LorzoSMFjjvisx/008W/oBQBHGlWOj6Y2NS5a5+3fAWl7g3n+1Y1UoUtE?=
 =?us-ascii?Q?+ien/tG5yPQnsBctZYQOtqsI7OCIf1COnmNBr+6rc2z2roHfSePRygmJPkhv?=
 =?us-ascii?Q?9Y5dq6Esx+R9QW/sb8q/Tdtn8AkADAADTEDftGa4D2HpMhiJ8AEqk2yc9zm4?=
 =?us-ascii?Q?kVTN1w84VZo6TDcv10L50SiV9warH5d/gM8y+IiBReMpfuSmYr2ec8eC1F/C?=
 =?us-ascii?Q?W/8esGiUGiaLnpR0U0PfR5YlhCuZNNZvCH0mhy6Lg6Pdtw0PKrGOy+a1VJ1F?=
 =?us-ascii?Q?K3mCrpl+N1ZQqsIMTv49SCGbKDEhfYNlJCji5aI0y5Yu3CLqiSLmL3zSNyb6?=
 =?us-ascii?Q?3HhOWlv2EyKoZifLYP+qEscCCM1Af8qW9+cYY92yq3EpAA0iwfofoDdV6Stp?=
 =?us-ascii?Q?a751J+uPffmorMqQeTwHo8dN2dHB8KjbQqq0gsK3FW7LI06qsxem60buE+B/?=
 =?us-ascii?Q?Yz5poZBtz2tVRJT8Hfynlp+GC3uUpUgLTy0dbYILi0OipcRscd7q5ygDYA8F?=
 =?us-ascii?Q?5POtEj8wan9V/7RAHSVk4bDmxwL7050rY2h+cZzhiKMUL1GGAhxM//hwxIcc?=
 =?us-ascii?Q?arEzReqUZgJBO25p+ymeOQ3vUnq+hw+NvZ4UxmV1wHwn+GzA1f7TOHsrgXc7?=
 =?us-ascii?Q?PuNAJYH/k/992JyU6OYAMdlzJ45WBoL5GPrrjScMKAma8PT78IrP+UL/DWnH?=
 =?us-ascii?Q?TiNme4spHFzutliAkksrx1kwbzwuQmcmCxFIY3O9OyqVzw++EnQcxxgTvswx?=
 =?us-ascii?Q?rt0BePpkzWjxzMSJwcYnnDRIjxv71ZmpIH77MEnPMRc1qcpooJUC2qtzEJO2?=
 =?us-ascii?Q?qtSNu3BnrwXk0qc4ZM/ugZNBin56to26BgBNunYb8+h+SfMDUoOVZeCC5OPm?=
 =?us-ascii?Q?JFhTAfP0qk25uEaI62MaEUyW4BM9bjyokadwl7YITAhw7OIccJ9jZn3tnPsc?=
 =?us-ascii?Q?GlU9O3Cb3hc23YhEhzBmbtS9k36I4DHwwuJqpXh88kiPJh2hTFo0oAOtdc3e?=
 =?us-ascii?Q?DUiIHq2nZj0j7T5guEdOd5/tU2j/3rXSIPv4d94jeq/aQAcoUfRHRP03fRaP?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cadb25a-8993-41a4-008d-08de1d4670ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:09:11.2616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3DylW4Qese3FuvIerOL0T4h5zBesvfVMAu2reWkSrkIEPpYPFxcUTuQDcKcjBLDEuQBeBe9xKyHyUlhAoP8mbJW3iDCGmQ9SoBnqd2BD48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
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

On Thu, Nov 06, 2025 at 11:50:13AM +0000, Ciara Loftus wrote:
> Commit 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> re-enabled VLAN insertion on the AVX-512 path after it was disabled in
> commit efe1b63775e8 ("net/iavf: fix VLAN insertion in vector path"). The
> initial implementation introduced in commit 4f8259df563a ("net/iavf:
> enable Tx outer checksum offload on AVX512") was inconsistent in that if
> the vlan tag was to be placed in the L2TAG1 field, the offload was only
> performed if IAVF_TX_VLAN_QINQ_OFFLOAD was defined and if the path was
> an offload path. However if the vlan tag was to be placed in the L2TAG2
> field (requiring a context descriptor), the insert was performed
> unconditionally.
> 
> When VLAN insertion was re-enabled, these inconsistencies remained. This
> commit fixes these and ensures the following two conditions are met
> before VLAN insert is offloaded on the AVX-512 path:
> 1. IAVF_TX_VLAN_QINQ_OFFLOAD is defined (defined by default)
> 2. The path is an "offload" path
> 
> Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
