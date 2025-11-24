Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8907CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 12:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE2E84066D;
	Mon, 24 Nov 2025 13:19:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4BE402E5
 for <dev@dpdk.org>; Mon, 24 Nov 2025 13:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763986741; x=1795522741;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zwfb+myf63cK6jngGqAClub3xR5Pef2mZ7+W8XaYPxQ=;
 b=S7a9aKE2VMqK2dhH2O5PAVsvkJH4xXlruzikO/uiwNoc/3XuLsVi1KU1
 HTzHEODD1ifQxGc2T0+PwZBAhbWfUxrZSLRg6lOFBcEeoAW+NNc+e+/AY
 vmbU3hNJ6judYolOGMR7H5bQ5mPhVIf2Hi/t0UTgmoAGRlGf5VWJ88/Eb
 pWIrETydjfp1a6DH3QJZpiQLyjb8FeQ1FxQqSiAgqaBoC2VyujzJtgYed
 9Ww4iap5lsHYB3NQkLwPfWwLxlOvJSPNAMjwtZITI21htycrlx0zLUjsA
 ZoT1pp0Sc1Hoz+yxZluZc6SzwkrJStodPh8GMtJPdgzc++LA0HaNk+/mW g==;
X-CSE-ConnectionGUID: wBtiPWAiTqmCKxMMJs48GA==
X-CSE-MsgGUID: ZV1564S1TqKExPyn33d7cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69848246"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="69848246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:19:00 -0800
X-CSE-ConnectionGUID: DNfwgZBlQz+nQQxWrI3AcA==
X-CSE-MsgGUID: 8yL6FCi4TxqBBSuZCwmbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="222971435"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 04:19:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 04:18:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 04:18:59 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 04:18:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anPuBHJbd3fYBl4V9Tqe2N1nB/KPHU6hUCpKfj5r4yo6WgFjmM9cuYwiBzIqybM08Ez8kd0Y+uLYyzlJQBVCbOrBJAw4jm4bcOtQbxp6pLwGp7+/lFigD7I62MTI5r1YcDTox5mY4brkBSpGXCQhqJq+d1yqJkPHPtjRTE3yZL4iEANUmgy20UODMShSQjb6xlK4cZSwt7iTLlmHh6Gi3PgbPdeHi9linDkhm8ul7gUdpNOKLSqi5aMu4O8Z83xha1Dk9NsONoMa3NOs4q7gD2dJ03nK31gPgaBxsGXTiJKIeKUtnzmhf17KYXYCqzaqHiUUMcQebA7MVpoDIgiTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi/7/aL6S9MaoFE1cc5NjRa1SB7C8YH4M8FOP+XVhSI=;
 b=mdCz5IJaHWmgyqKP3C2MhVfIbSdhLuakVQ51dSeCx58al2md1aJudGIkaZAddHUV0xdYb+dl9b6sFYUPlOfOZEeIoNMzspxlMEyLHbivGvkz2Uxw27hYTzh12RGRPdf1VJt2kfi/UG3otT2b1iiyQQhTlc/3tJOJlBgH8bJ6fI2cX273iEAIF4NfJEmSFJ1SvnuijIllD1sdAH4GLUPmXSCpH+iZvP2u1DIihwj/tW7/7nfrTX34FtC2uS3PysxkPCBL5Ev6dE8IBnAg9/dhWh57ksxV63aGjyRixVAmO3phWWRWiZY+qhAYXViDPKWgY9CHoQ27FJRdRPac2lKBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:18:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:18:56 +0000
Date: Mon, 24 Nov 2025 12:18:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 0/2] updated latest recommended matching list
Message-ID: <aSRNLEQEGG8qgOc7@bricha3-mobl1.ger.corp.intel.com>
References: <20251124085010.707091-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124085010.707091-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0310.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c7eb1d-b51b-4bca-6055-08de2b53a3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CtKIeX1239TRiKCBmTTsedHJBN61uKw6GzPaQsK3dfpziJ/LM09KXGIsKNl4?=
 =?us-ascii?Q?jrD3zJP9ATl9CO0E9kw77hQniLDq5ytOlxoqICPtkVSxb3fJJjQtBfdTv+op?=
 =?us-ascii?Q?Iga+aySNU+oTCZj+7nsvwDE/5/QiG2mFf9G7+SDCK9gy5WKDGuKcetQAWzay?=
 =?us-ascii?Q?T6EmZTK3mcSDNZb9A1sCNW+lMEgPuaR5rqjMqt/YPZxI5uB1yq+2ixifZ9Cz?=
 =?us-ascii?Q?asgCO+x8yKvRtRp6/mufunACp981Ru46yw9qMLQoetBmI6TL380viF8EIvYL?=
 =?us-ascii?Q?RpF4xeAKmP+tGlzSKS/Ctzp52iawtdSRQgAOD3QbnfSftJY0vOsAXGrLUqmN?=
 =?us-ascii?Q?Ge3FnqLXzBsUsNQ3aa8bxOtRTeWH3m/lLzUJbNEqDZzePJBEOiyiASomET2/?=
 =?us-ascii?Q?UeYUBzO0BApzeNEh815u38gDqMWZVf581MXFoqW/AcTGPhPSxnAI3Z7B6fQ5?=
 =?us-ascii?Q?a9u4/OWQl5bPH1co+8W8fqzWB2U2ck3BHbS6l/fagQ1Jl13bhFBrWuS8G8aF?=
 =?us-ascii?Q?GsOwxIeZfA2ynIEA8IVZHg5teX9OleLWUOaTIVxfVUDFpnjzBmFkPye8XUCl?=
 =?us-ascii?Q?KCkVqfDZDRHR+CVeeXYbtKfzRXRAKlsa/Htkaq0RN6k8H415NAHH3GC9EN5b?=
 =?us-ascii?Q?YiBIs6c+vrYPsNfHZqHLjALEqPKGny+ZWvrahVopOTSqacpKkcSrcw/5loZM?=
 =?us-ascii?Q?D6yymWqyCfc7ywduzeUcGkJ8o73l0x5VJjJbufayJkPQzFiXizguRUV4It3q?=
 =?us-ascii?Q?loVRaoLQqyTAzJ2Z87o7PHI1jG6KnI4Kgdgut+UBDPDScEowZu5rrTeY1TDz?=
 =?us-ascii?Q?ePbmYWJFDAip4sLXAekemZffcTvCqhhcmssoABNgFL/m3+wgSPWhNcQUp4Hc?=
 =?us-ascii?Q?fFUkVObX5h/k42tceAmEsBp1HNVYfTipOU4Mg6xzGuUfVmF+SzxgT5AI9RQW?=
 =?us-ascii?Q?ibETB7LfpctmMKQOt7a50UGhmA0o/5V4K7gl0MGWs4CeM4bwF7hF+mA4fWMk?=
 =?us-ascii?Q?of464Tt5StD6oZYkMnekOysmrUDGx5WruHOie2mj7grjzo/oYrzRN+drKCQM?=
 =?us-ascii?Q?EczhuhFk+XH7rfS+AM4owKDFPWeWXfrutGa0VcRY/kq023N7aRL+g/QM+h9Q?=
 =?us-ascii?Q?/FvUmYjMiTTJd6TVfcwCZzjg2dhCIzNjY4fmPTO5r6ivGztFwQ+bVh+nk6fU?=
 =?us-ascii?Q?VFeWkoVPsKWJjkAQ5r7x4jlDSSHK5oXOqRWlo/dlMUnrlNOCKap36W6U6SHB?=
 =?us-ascii?Q?hRYdbxJXHRb3uWhzfP2DRaDz1iDiFvw7z8LqncRKrWzK8Qt8enr168/Q1Kx+?=
 =?us-ascii?Q?kZobbfy6ln62xVdkgxzq2GnsQKYlujYh+tt/t+to5RN74qucPRQ/AZ9Nhxit?=
 =?us-ascii?Q?gNbwXV1L1QpW+FBlb1DT9ukY7cIrl6kHgOL3eWk2EK9+JwivHO6H1dKf2jQ9?=
 =?us-ascii?Q?NY3Z1GAa8fupoISgmyZNMDU3z3QF9Jlm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJdW+AVy4j7c122VHQ2qCbzcox+KjEXOBkyRa73rQn6e0AVmVyqiXiI8AEug?=
 =?us-ascii?Q?Q3OmqPpG2FbtbN8uiWxl7OwK6LN92J5AGERPpuZk55QvlMxEFD0MkAJxNg2d?=
 =?us-ascii?Q?pikg+jzVxGvB1vzfCJjDP6AS/FObgrIQ3jsPE15kZBgFPGkPKDPwUDLSxpa9?=
 =?us-ascii?Q?aTlPtKxTAh8f1eNNu5qhvYNtdHTvmj0qAzAv5t1P59cGwead18YY/Ts7EMT6?=
 =?us-ascii?Q?mtKnBm22wbe63U4wyv6DzngNpLP6/luqGBKO1P9QxYXSWyug3ufa30+lzdJE?=
 =?us-ascii?Q?o/idCnNFisqqMJUAWy7zF+eDLVR3dHJI+FM0pQeYQQjxb6oA52pkIumjyM/L?=
 =?us-ascii?Q?nfuG6cGs+QQF6VyFMt8CR9CFl438bQpHNViSLDXjqJj2sHa+7k2LBilLP9Yt?=
 =?us-ascii?Q?RfzRxWW7V5iOhQYPgip0+wgzSCNRLgsIifuq37G6/Gk8GdOSb5iXipBgGH9q?=
 =?us-ascii?Q?nHNpXZos6L3kHETyrmA7q/3fsRTGuZqcqXiEs9TdxBe6vPBqf2QKN4F5Xehn?=
 =?us-ascii?Q?W1bYgO+DMWOVWJUQJCj33KnPlQ2jnIq47EXGAuQrp6aacgFkxg5BX4NZ0wAW?=
 =?us-ascii?Q?P8u/vk6/v1NGlGLiIN/bMs55jee3yBDWf97vqQbJjWFQ8kW0buXOkR3XxLWJ?=
 =?us-ascii?Q?N0q3iNLMHHoALqAaaTV1QdPjqnyyZJYQLSYHCGpoGUZtYLQp4aUQ/m1D8lBU?=
 =?us-ascii?Q?SHGeeuKaWpWiUXTwC9fwN95nXo0wyY5AZ9tIrRS0GupSroq9H7hOzMbyzdEU?=
 =?us-ascii?Q?SfPhRUwuTlwrBNZfzeinOSXIjDwkAnqRSBGEvEM6zz0HOmxHI18HtQYg4IVI?=
 =?us-ascii?Q?Ei9k0acYC1OFSQlDrqvVsQkjwOiPawSsKvFWR3D5qL8ixp6dzpR3YXsde+yR?=
 =?us-ascii?Q?3mKAzX8qX9n9tKr9lNbEogKUb2gck9Us7JVxwj4fS5PFJkoseJXaWkqfHcZM?=
 =?us-ascii?Q?63Q8k5/OAKiqvUojlk5HkzfQGTGieLl8w0eRi6JR88bn8m4RFHpHd4W1ajGd?=
 =?us-ascii?Q?rFvX2aSsPv2FMb/Y1xUOnfpXSgPNUCpXlW65RZiWEOuarTRDFdpLZvyXsVni?=
 =?us-ascii?Q?dqrADyW9aNsYYLtTP5kvNXapYqipdkHHhOwrtUbULDa50k+xs/J69TGMBtre?=
 =?us-ascii?Q?JvMhsbqThmCls4jRs6xpz7hPtqKh/RXiA1offeV0na9sKxtSRPDHfyc0S4yv?=
 =?us-ascii?Q?xIq6l3ZRouV6LeVZbRpL6IPrsic4adftCiL/8VgyrEfp9lce2Y4GigHfQuVZ?=
 =?us-ascii?Q?18xta0WOLw1Ve+/PKLb3kiJOrkwm5EQFWIgVo63P1mE40YHp7VUNloi4DlKB?=
 =?us-ascii?Q?KUowwkVbIWYDt5Axaytwb9jAwp0ZHD0MwMJpysQvumFVvzXQnlnrFlYXjig5?=
 =?us-ascii?Q?bgwlbGqWZ4Zkrqb7svwF0bu3p4oVVqgBol1yDDD/ahVIoZZSt4YxWcOmTSZW?=
 =?us-ascii?Q?e4Kmbz8q6eKxNCPlbUl93438mPAQi8kaEDDgnaTWklhqcMLXg3le71RMdKGP?=
 =?us-ascii?Q?a97oDOkLujkxf8NXnZvZ3YHEaBMxKO1Eg2ZpDs5lX4ly91wFdvoFDPLnmssG?=
 =?us-ascii?Q?fJ4CRmYitNPKdQovjAxKHyjqAkPx7aNIVeu5LtsqbTENKjnxUa1KTwolvv4G?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c7eb1d-b51b-4bca-6055-08de2b53a3c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:18:56.4675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YR5D0fLuUn0Z1FnrJ3xFJeWVfjLhDqtyXYL3F893CNq0hdR6NaEs03nFSUGPLZSZWEo5k7GlFg/1h4p64ifTWjRa6ZbwRAElpt5z76Qd/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
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

On Mon, Nov 24, 2025 at 08:50:08AM +0000, hailinxx wrote:
> 1. Remove recommended versions before 21.11
> 2. Update 25.11 recommended matching list
> 
> Hailin Xu (2):
>   net/ice: updated latest recommended matching list
>   net/i40e: updated latest recommended matching list
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

I notice that the ordering of releases is reversed in the two files - maybe
next release submit a patch to change one of them so that they are in
similar order: either both oldest first, or both newest first.
