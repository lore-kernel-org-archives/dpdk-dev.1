Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C443C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD19042DDC;
	Fri,  7 Feb 2025 16:09:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 31F3C42DC1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738940994; x=1770476994;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Tx3pV+DVmhxcJi8kw5BUdV8SiVPtwslPed8j2vX36og=;
 b=lLQcnQL6dM9oUuqHNnfJohLpz9S2arn292JGCyilGQD1TzSyznco9nkv
 VgnJZC6fjDK3I2MIKMpykPO2yL5As/aiVnDNIF8b+mKkfUgqhttBARTEU
 EfJxOgewr/BV/YQzKwqF2m7sM96bB0O6wp75MCmSrTMeJ/LpfJftAstNf
 +1592DPL/uKhHogNBRp0hFvXZ3XxQ1tNTyOp+AjeeCdD9VE4DZXhJ/t49
 6K334wEe6UZgDLCVr+2cqJd4JhWM9IUxKD8FFi6qgch7yf8FWwq3vmsKz
 kCUEUEb3Kz0gDMXkBCKDeCAf2ufNYZv6eU6O2GzA70NTTshCtqp/tN1dN g==;
X-CSE-ConnectionGUID: egzB1MXjQ3KVtxCpWrYj4Q==
X-CSE-MsgGUID: 5mhMMqGsT0uAiYzIr4spSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39699272"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39699272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 07:09:52 -0800
X-CSE-ConnectionGUID: h+30F+qAS4qtMhG0tKnEDA==
X-CSE-MsgGUID: Zymoj2DeSQKVylkp6cHrFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116156326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 07:09:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 07:09:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 07:09:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 07:09:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/5TzsNizMqzi0IUeX0xY1T+lx/gYEczpdZPSQtOXRejjuKh5ZoEMG7OKdDYBWjyUwqkLEma8sCqeo15J+FQDTRQG7Xyoy2gjrlRoKMqjlqve5Rupql8nHqom/x/xTEwvNHwdFGQBhwukPQrNVjKZW14dXfp2Zi85f4BeoMKNw7CW7t5halo/+DDihOGb1fxx1RefRJu9iX8ff+sXKW6UjHxZaWAZd8K1RubJ1h6GDmhFFFpc6QcPJqysv653Lci9QPno0CHmQvMebXKweR19kd70OJ60c6HqH8IQD2BiWqsnWYNgDZtuB1l1LIgb31Ci3tn1JRR9DH2dphypKOxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssWE2ncrjQ2GiaGzAfc+6C9V5x9rPnxJBRZkAn0V42I=;
 b=UBUajwBplM6U681y2JZyU1B2WEQ2M6/tMXzCxlu4QwO9sLneL9JcEfDEr0Q5lIX5aW/ZKJBb8z121oroZriY4l0O+I3dbx8sO2MeMd641IfxYgyheIDorZlpUC6njNqdb+iOVZK2gyeqWIggAtiPrvsjZToJX/ahNXmWXDpPSGCInO4X5kbeoJJl1he8OGn5dayua8s5rVPzTshXOqWUBx0IaQFiD63E8tb52MGixEguvzeQE/E07jCnGJT9GtLMk1Q0Xvym4NH+1YeFajZE1dJtfLeEbeFH2YBhWOIJ6kCczHju9Oa3IQ58+VAVIbcVl5Zgzu2XqB2YokJR4p1ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 15:09:38 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:09:38 +0000
Date: Fri, 7 Feb 2025 15:09:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Wani, Shaiq" <shaiq.wani@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx
Message-ID: <Z6YiLY6N2s9FLMMR@bricha3-mobl1.ger.corp.intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
 <20250203075508.1304702-3-shaiq.wani@intel.com>
 <Z6X2e4hD7FQN94ax@bricha3-mobl1.ger.corp.intel.com>
 <SJ0PR11MB59189C232D90074099052A3A92F12@SJ0PR11MB5918.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB59189C232D90074099052A3A92F12@SJ0PR11MB5918.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:10:110::36) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SN7PR11MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 29372c9a-b240-4b30-f12e-08dd478970c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GxX24VmMpsV/NI9Makuq7h42YaGK1XXTqMOspO/y5L3QO+gwzweoWmjL3WFH?=
 =?us-ascii?Q?kZugii2pNKX72LX3/DfQxEPotwUo1mQVeBm7Hn71ABpcLLxqo6uCqcm9tOha?=
 =?us-ascii?Q?lf2Nq9cdWFFs+okxN4GHQt1mZ/BXE423fkbKjVxw2agHM22rE2lhV7X/A6EZ?=
 =?us-ascii?Q?dH7uUrYcuHg3MEzIixJvrIFPYAvS9GewzU+fpMwmNt+xIwglpD1KNQPLA+u1?=
 =?us-ascii?Q?J4KYR+2QgqQ9E01bCfE079w4TgTy10t9uNbDljONqbJmfxMMoZkQ56ygZD5b?=
 =?us-ascii?Q?eTgZv5N1+OgW0gHagJsxz7jz95ZSQG6znOacaYxF3760UmKDD0fPap6o+Rkn?=
 =?us-ascii?Q?nTWJQv0swmWYUEzJmndZeBd8dKoKPzus0Xuwfu7hLA2z0qr1QdbtOY8Ri2nE?=
 =?us-ascii?Q?41RieGuOzNkxw1jwwFMWrfSNBumlCFcCtc9RnwN/vMTBglrMCcAH60hSAWvG?=
 =?us-ascii?Q?HxJHYMkrCUpYP4wu/zx52njjaf5ARqTUr8xNk0Le8hj89uUrOU8ol+foJ/UN?=
 =?us-ascii?Q?gXieecpGv7zexLXmjJxv+sfnpuThY6fknRmRSf69I9I1wFuW/9ccHcfi1BrK?=
 =?us-ascii?Q?0OpRfQG99KtuHzrmjY1K8vQEt1odRABms+u99iv6FH2bhzMtOB9zsx0fH+1A?=
 =?us-ascii?Q?wdB3rxhPltUE++6WzbjNq08VBUcV7zIPLRo1yZGowT2Vs1Qu/EBL6UvtXIXv?=
 =?us-ascii?Q?vJHS9XHdQw539kQikS2UYEJWa0vMqkNCc0i9d5Ts5Gv/19rbeIWdll6OJN9S?=
 =?us-ascii?Q?wRTJM7CfHWJ4RM4nf0JICfoM5TXvvwL5m8UiJU2wj8Y3ae7p45Bd0KGXGbQM?=
 =?us-ascii?Q?CE2ZhN5GuCKrMph5Uw4XgiTosPtr0i1ypk0Oom3H3973uhTQ9AfTUIK45EXo?=
 =?us-ascii?Q?urq5uAi0/4vd0unBI+AHSKJ83o2g7rwy0lRxJNRnl9HQTROqWlLHwd420xLN?=
 =?us-ascii?Q?rWAcQxZ5bx5EEGj2v0kBqIQMR8WL4JbGb1LvDTdEm84d1T0MAyqnDbNfahP9?=
 =?us-ascii?Q?+ybt6qg/dwWT/52Phbb7z9RJj6L2SXU6WOyKL3tmSYUMcbvK2FXYSK+21xFX?=
 =?us-ascii?Q?8MFOFeApF3PpjndbrmAiNIEi+JFKLJNCIaPWsjFtJYLzPUZ1lppDcuBf3504?=
 =?us-ascii?Q?J8U+w9GKkufWhKHLJDLsUKChZp69RP2jJ3H5fN/4SwLo80pSQUXCx0AuFBB6?=
 =?us-ascii?Q?aTdB+f2HuRYt43d/MkDLZ4uLoxBpEFppFCO8rvId2bvlhY1gCMI2yLOL96u3?=
 =?us-ascii?Q?eMX9yCBD3J36xlJJcHtALDuqfNxBgRz0Cc3dWLqtYAelNtuXBkWyax2o8o9f?=
 =?us-ascii?Q?X370lTFtsUQfkV/VTh5tDS9Bqa0GZuQjbpTVsG3/4gAmu25OhIAv6Ai/UqH7?=
 =?us-ascii?Q?5RhGHOhEfuKzQo7HHyVnwhU0a0te?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JirilFoHPSsqC+2v4te05yOR0N3J2yZdCdtgULWi5/emNCvelMiECPPor1GL?=
 =?us-ascii?Q?fTqkKpHGhkctt/pfu9LOBJ3xUtjMVZm3cS/xMYIeU/1Al8f+QW4fM03cqiAk?=
 =?us-ascii?Q?UNTcKAIzXq3WlV9Ghuxi4crEi+bvI+/UEX82vAdq9Qh7VRF+OAv2e47BOM6g?=
 =?us-ascii?Q?RcbC0Jst8E8CTkCdgQI/oOelzS5uf/anH5koySSj2uvCLX4U5OYdxFdPSgsC?=
 =?us-ascii?Q?x8dpsXPA5u1MPq9Y62idLFvD5OZtQeJmPA1bnUuL/TfNQkn2uIyNhHviJmf0?=
 =?us-ascii?Q?BFmkwFCZFZ9JPyKJHmZQRWCQqf5gnMl4L70uGNc7xHGtxFiwAnDwgB+xPYwu?=
 =?us-ascii?Q?jPI/qxtYVaipHXNXRMLj28QtT9On5BwXfIHb0znp5QTf58bcbyiZxCLF5baZ?=
 =?us-ascii?Q?4mrlTAwDRdhs+oh9jUQW6rnK0fVFN4kmcWWds0S8d7K7+vxSBktNPmQfpKyK?=
 =?us-ascii?Q?RsiwpIOa4oG7VgO0aKZqR/n7UEQrqMrvCFCBQYrnSslZV/1sc5zrSGrGWq9p?=
 =?us-ascii?Q?drEVGUr6H6O0ef+Od8obAAWaLb7lAe9EhoHzSx5K+i80/TIhNwfn9xX0rUbS?=
 =?us-ascii?Q?4nw2Zl/T+2ySi2+8xqFFpCO+Kkdavg8793dUH9jGAoVg3kC04FN5U3SKQFYP?=
 =?us-ascii?Q?vL4BD+uTd1i6J86gM2pNspbTb9z1JIIxun2MAq0gvRFp1Jr2xHlFb+D51fAz?=
 =?us-ascii?Q?IUAQoOEWLu4CtI6EyQBTXBgF8u81hqP9zJ+uvRyJrL+MK+FKoSXHOYWVp7Fj?=
 =?us-ascii?Q?DTh4jgKceZXZbv1CfGnWqv4nfdxHgnGYBGULQ5JxxUidID5QIyMQyRjXuYRl?=
 =?us-ascii?Q?f/9w4OCi0ke/Ma1ks3wOAuUTzZtEvQFRLO0XBjTNnhsqisDwqE7z6E2RQ3CR?=
 =?us-ascii?Q?pBsBQpDoms3Fb7u5lr6pp345cuinrXoy6xlFwZd4GIrMPOOWeOf0tRL9cQUy?=
 =?us-ascii?Q?NLYXaXuhdg3hfP0V1JpSBf86nvw+NNcgUhn6S7qF4NsGPjyz4gA/XX3EjMx3?=
 =?us-ascii?Q?0XEkD3JpDahqp+eePDkajVbrdn8hcWvEtASMz2cVj9T6q6NLMuz1r+J6/h6g?=
 =?us-ascii?Q?xXl1ZRHgQs5kCVc8jrJoRH5TSMxMmHSi+6Vdrc95ZgPQz/6f04PxIK4LowYt?=
 =?us-ascii?Q?3yvObwwPlof/igeEvv5LI15VBpPa5PeM5saBCl14b6CUNuG9iGwbpWe6eKmo?=
 =?us-ascii?Q?eQjIrYB0DLJaSylMFzfEtfTXbuBQTPvSLguv459Glji241OlzxrqhYz1miFf?=
 =?us-ascii?Q?bBV7IbFuMigFfdq1n/grL8oKfRtpLFa2XBN0bbkwZXQfd0lGWblO+Li/zthr?=
 =?us-ascii?Q?WvS6w5BCOtYwe3Jb4v7hsZUeha34tGjqOnMRvnTh0gX+oDhFNcsun2QXzfL3?=
 =?us-ascii?Q?yF3T8fEN8f3o5co/rVfTzzbivedZwbhCOuwds4Wplj6ukW6uzJtUA1cBwZcF?=
 =?us-ascii?Q?0apq9GMeSWAkYCYuLDMLwfzN0PsqDllTLAvKVgs6PHg0X20bPP4UFTGHuage?=
 =?us-ascii?Q?4jGcvWyofsJ9/xGuZ7TlP5DwtyiUK93IR3OM3ZmE/XN4qb8b7EaOzlJrSHP4?=
 =?us-ascii?Q?lflygirFo9hRag6vAoN2JBXeUI4SNJhy31cNPZIC0uMUd1ekzHUWDNOn/Ach?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29372c9a-b240-4b30-f12e-08dd478970c9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:09:38.6169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5Izhyq4J617XpKRchLeIlzyW7Czi3K2QxP8bPBst/BoydSEwetLaU73wbx0UKQE93K/2s3KPK8PMlF+mgBQ0BvP4BmrYmkQL+mhpS1GDWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
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

On Fri, Feb 07, 2025 at 02:55:09PM +0000, Wani, Shaiq wrote:
> Hi, 
> 
> The AVX512 code paths and SSE code paths should be done together, we will look into it next release.
> 
Yes, agree. There is little point in just doing the AVX2 path for now, best
to have all converted at the same time.

Thanks,
/Bruce
