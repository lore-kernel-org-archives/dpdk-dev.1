Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7335C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 12:12:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A571F40616;
	Mon, 23 Jun 2025 14:12:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 17AE440151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 14:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750680757; x=1782216757;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fac4idstpM2JDGOQa5fYJivRhf7cVbP1EIINXj5VD34=;
 b=mxufZQ1PdJMzr9i3ERB7jGeEYtG4nh4N/Nu75KGWTV6XTXp7MVhoTzsA
 vwB7ivMJhlUawVH6rAzo0l62OFWKygd2SxK42vHqmAfNUkrZTvcvUCr7I
 1TxTYu3hTqqPfa+OjYTybISXxZLEKMNYZvNYsmlxPxXOi5XobESyj8H27
 cLGQ/nA/XtHVSWBbYtcdXErWiez0S/7Fqe8Y/frl6UG2paV110no+NLfx
 pU9GGtsUIfcqoALtWu8+C6ElTwdJzz00wSJvIeqE4MxJL9toGGuk/kVP9
 yiryyIiqgORRZy+xDSqY7yNwC0hkQzz99jBS0MQ5D5mbcd3bfS9D62j/V g==;
X-CSE-ConnectionGUID: +wLCSBg1T7e9nJPxQHU90w==
X-CSE-MsgGUID: 1mK5+6L4R8Wkq41JPXS6Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52755380"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="52755380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 05:12:36 -0700
X-CSE-ConnectionGUID: eg//ZQefRYCbxKrSBnruDQ==
X-CSE-MsgGUID: xf6T9SbPRMuNNdV69LztVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="151053599"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 05:12:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 05:12:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 05:12:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 05:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYtkV6N7444uZOX2RCeW6YsvTgW++Wk2uuu8x+zj9osGGnRoQ6Qlns/YLjLSeezs8v/wIQE2jOckWNO4RWuoUTp+TrqBtjxswXNKCtNz3AEg3QXvM6UJI8VWNddZupemL7UkjKCMBTVxVXCREJ+XMvqTMcBZUy+jFoHR4zfP6FgQMTuFs3XIO38e284tXZFxY6xl3wxHkifQxj1NG5kABt0DT5KbjRg4+dJObfyKcvIM29D9/OizUKL0rbN/E09X0kVyNR8vFjLV1NdIWhlg/5HRyilDzWMwB1BfbCks8Rfb6/gStQIX4UjG8nVEvx3R4rPwJ9u32JTMJhkWcwFUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC2rJXnLh0UWwwt13YyBFurGKfHvxSz12kcu1/Gssf8=;
 b=kGNbLgO7OTeSrzzWUKizsksDmElMdueuIZDsqjkO+41ddHyCRQJ7uA2IckjQBYa0YlMz3Y4uRy52AHMd233m+3zPIlogYKwEduaB3+hdt9+Dhb8gUs7Y99/z8Vn2X1yxHOGdDsJ/MK2c8WIuvGbBFDnYeq4juUseNO1j36ypeJKHILPYNOKonH/jl+qbJi0KKvoiN3csNeAiREFnuHIfIYWswrpeoUZFyf/19qErqyV18otkimyBnphzb1r2Wd+/aGl/HzrRwRqxhkMMDOMwjaypG/oQaED4ChWxsFIZ/0oE7dgjyEoEZtKIIP+P4LbPQ/hXsiWgJ9T9XKs7gaOVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:12:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:12:17 +0000
Date: Mon, 23 Jun 2025 13:12:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v7 0/4] Add TxPP Support for E830
Message-ID: <aFlEnOEtKe0xvBN6@bricha3-mobl1.ger.corp.intel.com>
References: <20250617051337.563233-5-soumyadeep.hore@intel.com>
 <20250617223614.568996-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617223614.568996-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6b68b2-5fec-441c-8c51-08ddb24f325c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QKWhq7CAUw8XTyOblG3T0wateA239aA4XIzMMe3vpapsCUVQK5gUL4tuVSFq?=
 =?us-ascii?Q?oGAPIPMsrvGaahJdHa7CjnQxUZS0mu6RgacbNMlzq6hiXB8wrn9EYDz49b3Y?=
 =?us-ascii?Q?u/LGsJSxqrXUft4KCJPFXYGVihp2/ODD73t/Y+Am3+velYQeIGrZxSSoWjrm?=
 =?us-ascii?Q?jIBgAlaycMyMYajSuFlpuSGngt7V5Sylow7gUcqwTf66sS9epiosFpm90OGR?=
 =?us-ascii?Q?JsDCenlc7X9H+6FGDMslzrDaID2KcIWKiyeSNUzD7mL79zmVqHmQw/8KJjK4?=
 =?us-ascii?Q?Y+6qTFzg8w+slOxs/tB+OcrPTJ9b+h4+1bLP/jaSLzdMyc7Q+9OoqltUPIGy?=
 =?us-ascii?Q?oQ5C/OTRoT7vLp/vfEObRH0r5rU5T9ToB4VRBW6FGYahM/XVAhTi7bsC4yK9?=
 =?us-ascii?Q?wyVoZyogdriOvIFG1eOE0Ly48yHiSfjZvFNjXCC5iPYnLE6xhlINH/IRvlqn?=
 =?us-ascii?Q?1CEM731ITDLZQcQpz6Qi79+aZnDdrxHz6fTeqdtVVOOEyhL0yZtlHAahEU2G?=
 =?us-ascii?Q?y0TwgJN1GzwYIlJRdcbIbCHbp9IzHWD1KSDDKcyaN1z9kugY8yz+jk+kJRwX?=
 =?us-ascii?Q?xaZcLPlDFtgdvhUXAAkZwGss98AtiRDSPXFqIe6DSyHbqWJS+Yld3J0jYj9k?=
 =?us-ascii?Q?Osp+ssAR743b2aTu9O2pQNGon6DqatM4ti8+WYLKdLR5PkoHBgEIS45l4xwB?=
 =?us-ascii?Q?AAaejoiVtEqfN0l2A+b65z7dFd258g4SawvQ2eDXmWqg+jlO/Shd1m7mDDkJ?=
 =?us-ascii?Q?IHwTLP/LrVW4ONkcCNdOY9ddJOYDtpqTtuHHfcVxFpyL/bS1/hdc7WCcTSlm?=
 =?us-ascii?Q?P/v6ROpvA+18tdGR0xG4cptMAfxd6io8vYDIjYLzg2SHNWIRqMUjULl66RkM?=
 =?us-ascii?Q?BnMLIndyj7igZVk7fY/Godqwtq2C+uNBLozsAh5mXjalBJc7PcmdPcBq7flY?=
 =?us-ascii?Q?gSye9Fb5uUj5wYpYy2AqieT9t+rOkfZiSTExqpXb0zXVGkxRRxYRChpuxenP?=
 =?us-ascii?Q?5bpabJ99pUiYFBazGUKzs5/tJUs0YiwM0O1pcwZeMmPKFrVT+v4fAk+gRjWC?=
 =?us-ascii?Q?TCFvJA2blIbsaMmU5HsScxQx71r1mbcH6V1hYBFWgelEFQ5ylD1tM+sA+xkt?=
 =?us-ascii?Q?1zvqsjRFT81MQyWVQfLSNQa+KUGi2aMDZJVZwfsE9qRwKGxoUp3gCh7+iMdp?=
 =?us-ascii?Q?U48450lnc/3uznWERHpVOOR78l1xEDJzuCwu5B9cRXjWaMvrlkyXBmW7PrO9?=
 =?us-ascii?Q?oYZx9EISWV2ya+RYIFCNvoI2o5aAy/k9FGper+VRrC/5Na+wRjBJFZIKzVJR?=
 =?us-ascii?Q?aChjPmf/ZVx+rvYFrWAh30wNnBWM0F8fqQioQEfqD8/0bwQR53XCVLcSJ8/e?=
 =?us-ascii?Q?Vv2k7m16LLZpKJu2RPXup1gUmaededxoVTu5O45hXmPCj2+9Gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMADCUQ8LkRLN3+3Azc9XWHTc7HV7AMQ4lVusrc7RicKZEvPnZIrnAbiArNc?=
 =?us-ascii?Q?E+GQQdMZ6NYWwGZB/43kIb94MFucL+berBG7P1G629eaxLwVDGeUsc0GVkEI?=
 =?us-ascii?Q?SyKfumKQQHrGknrpg+63JFpzk7URj7Y2fI4VR7M4TCknK99iLaBsnz98sSPg?=
 =?us-ascii?Q?OoLROE59bMmHl28wFi0Ws9vzLayUi90maSGsXjJsTcVWgsOT4YhIyXRwPMnL?=
 =?us-ascii?Q?iwsXdEcAHL1uMzMeIWBQJBFWgjMKyo40by59UEM7BoWUNvg2oYYBBuJ8w7uS?=
 =?us-ascii?Q?vBUHOCU6TNvt4WSrCLJ7t8Ienh/Y+kGbJ0/cK6YdiFdwnR2hQ8QTX0E0JZuA?=
 =?us-ascii?Q?7+rKu2ZIjiZ5+E4bTFNWw8QhQrafOmjpx0RVgSreubv4sEKyM/m9+gdVSKMV?=
 =?us-ascii?Q?kowPbvHKnt1hEOarnXFltddPNJL9KvKtxA98wvU6OPl4opSurJf4Gy93Jp8M?=
 =?us-ascii?Q?n0aBcm7P1Gftqdrno1SyKyPDK2M0SWC6Jp6Pti4CsA+Wbf6/rlLDarzbwryv?=
 =?us-ascii?Q?juAXoa5Swy8AZtid9ur1tePOGUltAvqojnHboi/icIE4u+N36y+o+JNSJl82?=
 =?us-ascii?Q?5W/WZs0wvIEF7aR4Bn/5Wf/xCbHIXJdsmYxFkSToSrtUNqw7Sb+F8XZW0phE?=
 =?us-ascii?Q?K8F2wkoAJpi0Rtx1NBQOP76OPuOlPkf+wp5uBR4G3Bxa6qx4ezood8lCiZBT?=
 =?us-ascii?Q?YzW6G/iYUKsWKVvw+oYc+LpfrhMZPqRjm6WHAbCslyAUauhx5KeSX4X8LNI9?=
 =?us-ascii?Q?0rMxmZrmVJRENJz+9A/3mH6xSKdiVjFbf5J8bpPN8FslMmd3u40GJGBwBHbC?=
 =?us-ascii?Q?/sTDkSUplqjqUGjvgOS8hsFEIza7z2Y2Ru77Cbxwd/4dlUI1oqqRzFZI0TTg?=
 =?us-ascii?Q?MYKN3qIodQ37Kp3jwveN0AFePGpSoOPm+m4He8Dz0dgE2aenshRLeB7ny4ZW?=
 =?us-ascii?Q?EpGSpQxmMXzaBr/Pn4h5LSqyYnuhpMhZVIXhrGdyL/BThhJwyeGcgVyvYM74?=
 =?us-ascii?Q?ihbICvyEz4CHLiGTeFSDw1Rbeb9XsrWQ8XuZ+R1dPurJueU5/bqzCG61fv1H?=
 =?us-ascii?Q?k/w5b3Di/8LDQC4ra/DhlIossOxiLDsInTYy/haGWmIy851DvWRM83mPcZ2F?=
 =?us-ascii?Q?2vD1ia1zynuR7WzTivlGaW7/P7UUvLoghmHxGi3LY8mrKjNsHWHz02GIiou2?=
 =?us-ascii?Q?xaxVuIcoO4dwELS6px6Cr80WfEe6MPfjHNC8YRDOFe8waI5Fd/qSbbloFvBK?=
 =?us-ascii?Q?ztvceIDgPhHghz/HYt179C2H0b4qkC3lVnTYncJ1XV8fTaFM5Bv/P12MhBZZ?=
 =?us-ascii?Q?pboFpXpxVRkxldha7cYDCIQrcqwSXbNd6mGsj7QHE7sq9e6qufsH4WEJjGOu?=
 =?us-ascii?Q?8wvTz/MuOQnVwnpKCRmiwxBTF4EvwDnxhEHnzj78iI4MAUo6KCUYX8Kt5SGx?=
 =?us-ascii?Q?1+nk9Oy1195p8+Kctwq+kub6vGkvo5COzXE9E20fLn9zmZ+9hdNdkhMJlb/i?=
 =?us-ascii?Q?jaOWzdxgLqPooxJJeurYGVk1z9dDmNmkuXo9LnD2CruwuWN89TIZCqSPnHUq?=
 =?us-ascii?Q?Ph6dgEJ+5PQohn3ow3DLNBdujuduOaFD7Z7UfXuYnULC7zhRUFo9maUscN2j?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6b68b2-5fec-441c-8c51-08ddb24f325c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:12:17.8252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htTi8jj228c6SHGV9qE4ZkcARmGIAmOtkZXvz3695e2hrzBWTu1mqpg7yPwnYfl+ZocOAex22gjNrFSeQ7Syr1vKI+PpraKyc1d+4KUcp6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
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

On Tue, Jun 17, 2025 at 10:36:10PM +0000, Soumyadeep Hore wrote:
> Added TxPP support for E830 adapters.
> ---
> v2:
> - Fixed Compilation warnings
> ---
> v3:
> - Fixed further Compilation warnings (uinitialised one)
> ---
> v4:
> - Addressed Bruce's comments
> ---
> v5:
> - Addressed Bruce's and Ciara's comments
> ---
> v6:
> - Addressed Bruce's comments
> - Fixed compilation warnings
> ---
> v7:
> - Addressed Bruce's comments
> - Fixed Windows Compilation Warnings
> ---
> Paul Greenwalt (1):
>   net/ice: update E830 Tx Time Queue Context Structure
> 
> Soumyadeep Hore (3):
>   net/ice: add read clock feature
>   net/intel: add TxPP Support for E830
>   doc: announce TxPP support for E830 adapters
> 

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patchset applied to dpdk-next-net intel. I've adjusted patch 3 a little on
apply:
* adding a short release note entry
* removing some of the line splits so that error messages don't break
  across lines, and so that code lines don't split unnecessarily.

Please double check the patches on next-net-intel to ensure all is still ok
after these tweaks.

Thanks,
/Bruce
