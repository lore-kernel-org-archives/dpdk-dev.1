Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896FED59D65
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 15:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1E04028E;
	Fri, 12 Dec 2025 16:48:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 10F6940268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 16:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765554510; x=1797090510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mBaD0mCjdXg4yJbQo3jm4bU8axHPFfs5Q9Wjqv2IpJs=;
 b=lMA1sgDxpqONqfJxT0etSn8zWmfa3cqvRoIXdPTTUoYOR/CY/4ZPWG5t
 QO06FxUJmcXmMSyHSJCRzWk/+fBrz/H4chn2Hbf0gODfVN/051ejclqzc
 kV6v6p0b6tXZR512i76Tkq13K6ikw9kfg754PStfY+gfiYo90MhqUVGkG
 qBMKjZ1A2u8MFbFxrQXImxX/r2JYUW9bwGb2HETrYiFoCMFhtUWK2WYSF
 iehylXfz1+s6xVAIWumsaeKMJT1Z4l8U5f4VVXBtxKE8jEA2AHkXEVqba
 qY1T7c5Y3jdY1A477s67zGHd2Vxo1c0ww+sM/opp5Bt8aXcfPql93aNmT Q==;
X-CSE-ConnectionGUID: fF1zahTMSR+4vtUelDy2KQ==
X-CSE-MsgGUID: iy4I2fAuRruKgIu6yCF3wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="78195083"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="78195083"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:48:29 -0800
X-CSE-ConnectionGUID: Ak+RuWo1TnSzQ7Lil6SeLw==
X-CSE-MsgGUID: 6/3mhAqvRlOz5rHI0Z43VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="202040403"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 07:48:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:48:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 07:48:28 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 07:48:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8jBsUhQg/1njZkg9DaETe1twxnyiFpajRZIdk4Nq9DGa/cmubvqQHWrb2agxEjiSVh8X5HxWAIQadDsvczbvbBnKgXgFCCOIi90YlNn+em0pPWhLlr/5U5iXk/8/0rlP0sJqvO2qThoa8ooQnzVpD4A3QBpUkFxGfmByeBD1cK1vVeB1XfEIwM1S+5qkiVcEBuXzVqQp40hsy/dbHxyVkReTtaX8f+UjuVTZ6fawzbHwfLgvmFxxN4ciWcE0n59zzwZHqu33AJ7zA9HwALt7NgX0VDh7Keo3J6507+r9uOc/Qloh7RDKy2P8DLda7rvChPPyXrOZXBtSYAe1EiMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPwoxEEiOfDL/utSTPzph9wodQyN/auhnmDeB0zJ11g=;
 b=or9j3mzaVVmreNmulmlaW66nOxAwNRzHhlSFv9ILOB0H0+uQBKbemNf9fdEvzjMAYS6NA7dFJx8FZk/sevQj9MuGhoIT457lPQkVCf3Q89yN5iN4n912RHYsg4AANwz/9L+n1CbjjemAYGxVFyj5j9aXMqhq5mhj4M7yDPUqEnh0fwwxnDjWrveJKy+8oezk18g0EXBKTttNnOln5dz5cY2novlzQT0mIeuxRJydiECRliPXnG4m4vULTtVsE0hkUbbaPqoKj4KZPY+FWd15jgebLheqKRmpdz/R6t2Xxnb1VSH1sP59beZArMGjEF/c+P9uA6E0eCY3WZcnQ74bMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5767.namprd11.prod.outlook.com (2603:10b6:510:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 15:48:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 15:48:19 +0000
Date: Fri, 12 Dec 2025 15:48:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/10] net/intel: tx path selection simplification
Message-ID: <aTw5Pg9R-PMUACIF@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a330ea7-34a1-480b-3c50-08de3995df44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ICnhuUuV/NFpJ0BPuNe/hsk9Juu8FWpfIpSn3PW/4G49ogKXoWXSpgUNXMB?=
 =?us-ascii?Q?xqV5nujn9qwhNI+AYtLAROG8MoO0Hy+hwELA14PSjIw156ZtFZqruk2uRdQ+?=
 =?us-ascii?Q?apU/LkhIjxiiY8+Ly5r6sI/Jcgl4/GyR4leG8ji7Z6+W3BnfSY9U62McZD9L?=
 =?us-ascii?Q?tC7WkjmMrUnOw0IZ2WMQtGrgBnOGJ5xY+iY2+/xU702zMOGikq9IFUhEuMEv?=
 =?us-ascii?Q?cq2ilmzhqve/U7gnJX8ba9am2oNFss5FrYmQtK35RRzLgcv/f4zn1/0uuzWA?=
 =?us-ascii?Q?QfdwhWTmNWmv0LjCHQmQQxjIsDqxQKu48bH5IobKxYUXBsNGwJj1BV7fH+k2?=
 =?us-ascii?Q?PjJrS9HVGwX0ohWcqXmyUPZjixhg3Cm48m/rCIMKPr/VSWCKOx+dDsy3xUge?=
 =?us-ascii?Q?LVRh49TctYTTtdEmJvRN7J/tlgovpQVIKiOKsIpHpkwVtVgX1Nxt/0QpsPLR?=
 =?us-ascii?Q?s24uTwfzPfreVvjz8rkHiew1VYoLXW7AJxr7NTxZErLdvcYMdS1kKgXNOwwp?=
 =?us-ascii?Q?3JmWD+pUPm4JRmJ1dfH993vA1dSF8JKWafb0ZClrRPbPtN5MX5i3QowrgNWx?=
 =?us-ascii?Q?QGgyGTNTEFUiB5Lgpe+6hmeK64YsACLyJNchW+9vf4JFbtqGOjatsPKgcWqc?=
 =?us-ascii?Q?/eOHUsudq7xD4LTlScZRu7DgpFZALG2wSq/1ZGV0jMAm7t9aMqb4szNt4Ges?=
 =?us-ascii?Q?Yrr0yMfyiePN6/FgqrLUdpnpj8cgu07DyE0XhNB4o6pUOmVdQzmyb52n3027?=
 =?us-ascii?Q?QgEEn7vihaGqy92Hlh9ClCJHVhIrkahiWec93pSsfInWoFoDxZ8mOu6k4YI3?=
 =?us-ascii?Q?IdN61crRPvRpWJHzKFcquGgNNFBd1zCXjnhfKgTUDl/DufgR7cFCOXPsCsvE?=
 =?us-ascii?Q?pY25bmVJS4zBAMyinkC5Wbde+/TiYU/TrMCLO6LYCbNXLaM5w/sNVw8ySpyR?=
 =?us-ascii?Q?5sR213QBds6pQpEiZh1nFggjUTVMuel8eI/sAxxKio5bzoPdR7cE8CVyC9Sk?=
 =?us-ascii?Q?26Wnw9sqLaRyzoRaYji/25pEorxTD6Aw/DZ6M99p5Vjqx7G+/sjLHalFCGXl?=
 =?us-ascii?Q?spK9w4iCxQt54p+NOVZAolu9/5aNeHWeeRcTbl1Ufm9abNvmJ1KDWfCgBoqp?=
 =?us-ascii?Q?9fsR26IrifS/YXXbcNgRZaZQolc2YoiZzTDWF4xV2N4CZJlVWQ+JSSiIBm0J?=
 =?us-ascii?Q?th2u6JIdiGdnzgcCkSwOqAy6719Dmb574PIgxildpYsJsjTA8EfetcWNEXpC?=
 =?us-ascii?Q?ww6hrr9xpiIhmJbPpXhoczneZbdaiivoxeJrMgt8tFvTAM9mLg6+0wnSTowH?=
 =?us-ascii?Q?SJEhBgRiQiI+vMISR1xL99VXeYFEAX+lPpfWn4uvKoZ5P5kw1DljRF1xdmuM?=
 =?us-ascii?Q?HNrXiqhkXafhYDrG70w5MrfvEcI/CpxDADxXFpBd57EDxs5+DNrjsPdzSLmy?=
 =?us-ascii?Q?nDQeNj8QJ+ChLkrfe64knXmia+zBo1vI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+X0zQSCcPO8Ef6DN7DnW5qrW4czJG+vG7v9RFixPclxsWYoIVEQaZuE8Fokz?=
 =?us-ascii?Q?AGnepbf1P7jcUhAfEUQLv6j4O531J8n2ZUBzzE4kGK0UvlfNbAOxbmLApn1U?=
 =?us-ascii?Q?BMAb41YzAFDBSf8+DhscIaSbuwqRD3I20gnwzfKcDNkseBfzLU4UGL1E9xwB?=
 =?us-ascii?Q?36IwdaDvCj4xM0xEd4iItt+ML/iFR3403L1XzdqdKhoi4uDwfHAGy37CY+bT?=
 =?us-ascii?Q?mrhpmA2XrLjLbQQCpYz5fZG3Z1+f21qmxbu0b1nvHjlIN+4ug16UHojneEPr?=
 =?us-ascii?Q?PYpf+bMB7aM/u79dfERIVlAnmXvJgPCna+XRNm7CaOI4Gky4kA8V2L00N6Pt?=
 =?us-ascii?Q?KYhlFoNZvkRLLtxxviG7+elVFHbC3BNCA7y3VKgrbZ95NXuzS1RtekPX5oWg?=
 =?us-ascii?Q?tbAdcXexiVoWcaYwmdj6/6rtrDbV7BDgn4fTPUSD4PMo35J8VgdiebAf53eT?=
 =?us-ascii?Q?aS16+AjDMqIBxzEkleiMYr8w6svNgLH3J562d4h7xpEkDNlcH5sRWmh1l4Gk?=
 =?us-ascii?Q?qqWS5flxAzMKaSrwRu2WTQ5HFRNntg8CNYj/+Ej46AgAxM0queSw+eBq+V/L?=
 =?us-ascii?Q?DrfW4buEfWFpXiAzHtfTq2KmHbkLdKfMnGsIp1o2yNs8W7lRY1raW4sURBUO?=
 =?us-ascii?Q?0PH6mpXmH07l5sjrcjTa1ph6c25uKI1H/zTtIElQVkHv2wxQviyY4UBkRTZ0?=
 =?us-ascii?Q?6cK2Xb3UQgjamRkyIcEDoE4wK7b6IynHohvzBxakg21PwfjmwUMSMdPPid8c?=
 =?us-ascii?Q?q8Mbb+4KI0JH65r77RFxMvzFE9KyNsRrraE1oV4dOPd8Xk4r4Xmk5N2AZevD?=
 =?us-ascii?Q?dlzcm0QtdlexwTW9CSdS2s4/4oSve13X+9aPcsJCDfaKA6azsIs7vTs2r+Jz?=
 =?us-ascii?Q?Yk87J1+XdHlK85uQ8Gd5CawY3bK6bsuM0kUGN/N+GOBy2qZnetBnpp6AFoCf?=
 =?us-ascii?Q?rnCyrtE8zb1WdfEQoMwfEo2PfBA4CIBG0tulQLP56uDiDmEJizfmFHQYBExo?=
 =?us-ascii?Q?t7L5i7bkxZYgO+T3P1MRtZW39k/uPfomJoGAGBzmbvMq5x0Mro2wxOfX2Ktp?=
 =?us-ascii?Q?4cir8zq/1LgxP2A6WI7NYvcvW1z4/0WHUyz0Fo66sfzSooz6Q6Md8+voV4Qm?=
 =?us-ascii?Q?45KyrsRY9haEM/vJ7PrvT55IAEMAoW9qiIPWlqn52DvYGpV/++gTFXRyBnD6?=
 =?us-ascii?Q?akRNk/MLdOakkXXr2LoWE0eDnsS3QsB11NnoSTbZI5/AswC4mUMl6EuSQmtQ?=
 =?us-ascii?Q?CushdV5lgvX+s7mhxoWJ8XJg6pN9uD8PfGioU1tb72jzddk96S3effXh9/cp?=
 =?us-ascii?Q?TKK5zHd9sX145jKW16nIRD1vT+y5qmOlWMKAp51m8LRPu/G63qlcjx5vxLOS?=
 =?us-ascii?Q?WwWKPbM2yfhXjCXNhE04BlsnxhljyqXQ0cbmKHXtkTBqUqCJ7lKcURnK8bz1?=
 =?us-ascii?Q?PhKMj9tZNgyX3VisHj58V/794POWehtadZYrUzpRE/BZAvSxFGx6gJj4uLpv?=
 =?us-ascii?Q?tEaBpPcC0QnIWSvV5IpjFFQaQc4F9Yi08xeCm6gIOio7rdF7DM/w95K8on3L?=
 =?us-ascii?Q?jBfRXVl3jeaXWn0PLAoJXXrHf2PfjNZ+DFWAgLS7DkadmVISoszx0V0b7FNK?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a330ea7-34a1-480b-3c50-08de3995df44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 15:48:19.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yJR13nNltGBeRVRpYpbdmG90eoaqyWqcZcwWC3JJ61aiP23yfQxlw3DMAU0wAXQtKRITVDit4cRSM2lMW8VHpVDiUCxzuFEgWrhFoD7IOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5767
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

On Fri, Dec 12, 2025 at 11:06:18AM +0000, Ciara Loftus wrote:
> This series aims to simplify the process of selecting a Tx burst
> function for the Intel drivers i40e, iavf, ice, idpf and cpfl by:
> 1. enforcing the same tx burst function for both primary and secondary
> processes.
> 2. using a common function for selecting the tx burst function based on
> maximum SIMD width, function features (context descriptor, single queue, etc.)
> and requested tx offloads.
> 
> Some fixes are made to errors in the documentation that became evident
> while implementing the new selection infratructure in each driver.
> 
> v3:
> * Fixed cross compile issue in iavf patch.
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
