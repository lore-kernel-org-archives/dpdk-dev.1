Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A849C43327
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 15:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31173402B5;
	Mon, 29 Jun 2026 17:21:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6BA4840299;
 Mon, 29 Jun 2026 17:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782746496; x=1814282496;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sEgRFf1CMZyJ6YI8uKTC8hWkzTQtN/GbaE2mBDfrZg4=;
 b=VthDVLfimEwlSwuaAIbLp3+Q57G9Lg1mdfUoKAMklJbOLfyzvWs2kycz
 tuv0qVmDIKFE/tlj1NZ4jBLPodXUwiQS2TLZyNJ70RuQgvKE6+1W44GO3
 ePWXUW3pDmgoPC1L+/0GYEnat/9Gc5HFmpqNLg+6/rYFYyWPERwHh8K4X
 xZrlj6ff3O5VFq8LnaJsSyMbQCrf7RPb6NZfPphttqDbsOtaxNtlF2v7k
 scvaFZcuNisS9OZchUQBB2PjsqdnQUL5i7ZUpR0nS4g+rhYNzZFHf7R9J
 IM2tcxOpm4KsSIlQyfr9gtCwC5QkPr+BxscW7P0ZMZFg4i43M9qTkXOVs w==;
X-CSE-ConnectionGUID: i3Tmb8nKSQimfK2+HxqaxA==
X-CSE-MsgGUID: F1EhD4DDRi+v3oqqFiz4Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83444894"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="83444894"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:21:34 -0700
X-CSE-ConnectionGUID: LjE6BjmvQ3ynjZH6Sm8e1w==
X-CSE-MsgGUID: wN08Jc+USJ+0EuI5YgsKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="250929452"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:21:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:21:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 08:21:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJfbdnZ1yLLHcd7OAUMEea/dC3WVt1taVkRI2fMximpXKfZ2FXGFo5DRizGi+iIwk7uJy27zjUspeT2h2pBQX4pGtuZNGzWRPSyJUkKEXQLaw9ZcOAPGiOoUeXmrGzgebLeTzeqNqFiNyvNBniiBkcBbuBUXA+NQ3omr8StH2SQVVMHZyq2YNRPcdaQpjojrYaX48zl/6bYCITay21+Lvaye6gvtCqf6/UlLbkmWQH8vdno5dqRgxwZdwKDgZVHbA6HAAgnCqfq5b+UmttN0tqPmG+F+Mhqo59XJu+xTi/xI11CkDF2/fKUsdkTZw01x1WTPQqERqnnG3RrHdyz4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57gWu4WMGejfLxCO+5JFR1ha5ENeVSqSSUioy71hCTc=;
 b=nNeXDjG7hHMq9G2UkBrVyMZw5F/a6kczMArum9RiIOZpSqwRwmu/CxuOIa+vnGXYWT7lxH7kNKrGsmyBn9yZ9VN/tLBlNfYB/ksj2lYU0n5VKNtCQfj6aCeWEADTEswhM9xKfLtZ3YS9HQM3oBwRoYrVp/5hvUjCM5n0UlRIupztVDnmGup4tKQcL7larQOhNryKVzK6Hoe/LZ1xbAzBSVMFTXT02tKZMppM3eUHPIZAbhfrYV3cih1hRGworfuj0ePZWgHamoBlmC+P2Xy+WM9pCUWiJA41s6usDBEWFYu0OLXXVgXmJ352yk+TSdGQlrxGHF0bsDZT63h7WevWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM3PPF4C5964328.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:21:31 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:21:31 +0000
Date: Mon, 29 Jun 2026 16:21:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/e1000: fix igc RSS redirection table
Message-ID: <akKNdk8s7O17S9m1@bricha3-mobl1.ger.corp.intel.com>
References: <20260629045511.473850-1-deadcafe.beef@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629045511.473850-1-deadcafe.beef@gmail.com>
X-ClientProxiedBy: DU7P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM3PPF4C5964328:EE_
X-MS-Office365-Filtering-Correlation-Id: 959b2125-5684-4096-0f7f-08ded5f218e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QrEz8omCyeplA3go+6ZxIl5wmSRabcYvDpXfg+WnBkZ8AbwbexlQIfAlMPLM4Qv3bX+3w1tAQbVAX4SviRKCwRGioHqUUyggXSOKZ0dkfFPKUqquVK3n+D/FaiKmrWRMVvm97sbYQCddJezwUfYkkh8bniwYre/BUXLTSnn4ZYKIrnmKQZwQg0DRS4PAxeWAxNayXe9HpMEsZCgrB8MMhU4mNVAnx4iOenSFQyhDcUa66QGyYZtJ8hAaEg7Y5vDV8SkIGikhMNlKpdpCKVi22rHz2us4/TKjm5a/+XqGW7anyxhIEAAxyRJAT1336acFJ9XK2Qk60zvLxSDgmycWCBMo8tuR7aOkwYWCScNQTGzg1pvSQ2Pl9SDXP3nS8AZWdGx2uwQRwW5ZK3nAxfasfdGaIzYBpMkMru8zKLr1tL1WtzUevxSlBDA5fizIdYlXVg7JJx3ajlWyGWNxINvKWqtfAEGkAoNDgCNdG/ayx6ECvvlbg4mXv7pLilA/ghE+8cv150sFwE5rmdza0x/IPAbzOU1FNTMbmSciAs3g9ULPQrqfxh1KWj7J3aM5TAQHuiKbwivkHOZmCBo/rgtSsnuc8yqK8CJKDzN6Awfu1Fqg6+CVx7dtNdKhuBtgUtABX1HEfYy7mrrN7RkuWO8hiy+5a+OkITDeq3mcrKckigU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTql1OdxpJ3Oh+CLzOR7Mlp/LJCjnMn2kmIPXaZcq6OiQmkcs6pD5Gf1DSN5?=
 =?us-ascii?Q?lo1SokSzmrQP46mPZX5HkzsoYoLgs8MyniFSNDluORBdN67Qx16fO+y5ZMG9?=
 =?us-ascii?Q?cx6/9x8jL6hIHyeFAuYCJWx1Euts/4ovRUBvmonCfSsMONEP+642veKUUg2O?=
 =?us-ascii?Q?EWOOKNpv75BUaHanOxZX8hu+HqUwH2u004DgPop7bvvw/k+l0lur7znr8olI?=
 =?us-ascii?Q?cmPteL4qiNhUuPcHzvC6GyLtTgW2zfAsVrQoNGZh/halO8mK2CIpR9cDOAot?=
 =?us-ascii?Q?5ZRuGSqzt67gi6r7+P+Pi2vERqyUPmUNPf+KJF64doaBqzVs8dWimoA+3ESn?=
 =?us-ascii?Q?47eJKrj8JMAU4HSrAz646q+se9okuJgf6OUEPSB57hKWrtKBUJ8AAs43xXn8?=
 =?us-ascii?Q?qNZ63QKp+FVCpx3R706JGa1ARatOHvJ2PnUGdwRB65Rz+4ACLkpdqi/0ZRXc?=
 =?us-ascii?Q?NZeN2+wB4QYI/9KGrOPsdkY6/abW6cCT66h5BBoBh/p8s1Pb8lpXQd/qvD/K?=
 =?us-ascii?Q?6ZLtN7NmJuyM1+IHkPXCMpPRAGjAlW7bUR66uIHEs7DsFWTR4AZGdFzatqdB?=
 =?us-ascii?Q?Ca1VAMVYOePrhzuv4qwHAMapjpxBxFy6p3PvnwJkTcAac72nd3xXkuCwoBah?=
 =?us-ascii?Q?Z8sn0iwlAiZwmT550ffEP1AnoxL+b76tHKeLBZxB/9rs0XLYT+vD1/T6aiKt?=
 =?us-ascii?Q?GftKnnnMNagB5CbihPxE9fdOcSUvEzr4D2xrVJuCPCCIXlxmZdaxnDIb+3sC?=
 =?us-ascii?Q?6+UCJe8z/1b+YonU/4hqgUeo3ubjzrcRR8Q7N8y3k5fbAChnEZVw7w5jLGzN?=
 =?us-ascii?Q?+BTH0hiOi86G3pQRjyg/LcmRSbGDMmeeVclTNMGLSaOrF8p5sDqSah0TJ7Wy?=
 =?us-ascii?Q?Mknfj3Tw6kMOpdBiD6UYLiA1gLCbYZJyBjmCEEwR2Ie2PpGCVfjxL2Gm+GhN?=
 =?us-ascii?Q?Y30V+fWedeqc088iqEskGBr2G1XQAPG/3i7PbrsIKoM240JwSdyZtcHgxjtk?=
 =?us-ascii?Q?XY2iU87f83qG0rxoLJ2TSaN79cVUhgQp6MrHayihyQ6dBNXSb5ZjL+JYyvnG?=
 =?us-ascii?Q?bGPz05qWzdEUm1XyMFE1EOO0RFi+ACnMwIemM243csE+aH7IMYgNwSoV19Bo?=
 =?us-ascii?Q?2eOxuOeUA1ABMkPA74yBQBTpAG3gQ0z1XiF+VUt9i+lWoZNTECOkpS2cpS38?=
 =?us-ascii?Q?8Czua+7IoJViLStF4GVC96BL3Ux0prTEh3rc+1kcSSmrGHeEK4oAlMMDlDs0?=
 =?us-ascii?Q?YaomugsIxYWSIHCZ353D3R6YK0QbnoOoqBZkmhJDYQi9mNBH7NrlPZlRD6zS?=
 =?us-ascii?Q?TBVosVK2qUA7PC/Aakz0+PkR2sy9K+ETqFlE9OY+psxQloktJCq5IlGj99jU?=
 =?us-ascii?Q?+AxPFkXqcaCM3bddKdwbY7cwwZTTag/cxqhn0NyX+1x+uaoF3oMMSXFl1a9w?=
 =?us-ascii?Q?kY7CyhAXjYuKZ4C6qRUy9Hxfn49KnDCtOPFtucGSY9TyblhKvD9Y/zQ82rNa?=
 =?us-ascii?Q?q6LFCzBtLiIwcy+bIM099cXE9B+uTZh+KB66IlC1SXAmiXUPsTCUyhp+5Zq1?=
 =?us-ascii?Q?Rw84IaLwSqPA4EprinF5KzUQm6XUeh3AA8g0PZ4JqsHkjAXvOCbUx3+Ye05c?=
 =?us-ascii?Q?uyQBf1z9hmKVK2abLpAs9ZDi60LY0ro73M0LxCT6vvp1WdPQuqHs2JOXA4RJ?=
 =?us-ascii?Q?lYlheiEQA8w+2K2Bqf8S/Ku704ESh/GgYwrPHyqgPWRLAG17n86ht1XoAP8o?=
 =?us-ascii?Q?hH6pHNEP4UNGkMKPcJNxZKRM4LvQT44=3D?=
X-Exchange-RoutingPolicyChecked: X+/ZD9l21Kv4OySJ2XwisxJzp2VfPNmXHQ+LFcSvSTsWFRuOVZCwgdCKkwvEpKFUD6IFdOrGD1Bpf06CaWAvXwMdFRqUfZqJrF8EjMBCX5zrbIR5ROgcFgWn6K387NSlicnWhw69qdeHn6yNbeFN45luNnKmxJf8TDcYJ5nQD5evkiRfbn4m/pPtjEVUJ5ucoVwtAoLEBsrZO9TSCrhpwQLGNSjeYdg6BPHRwoWsrRypjJaVmY+6jW03S5vudRYfmrDYqabLghsWBz1e78hO4eS2kyUbBOMRn0U0CRV2eB9lbAr/k0eNF1rCfSbc3w07Avrr+5y1Tw0hPdfBWl3j7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 959b2125-5684-4096-0f7f-08ded5f218e1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:21:31.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt81Hx+0LRIVtlKgHbOpg1uiKlU2aehqPGidRdU9kclSQTnzYtIIG6Hkvp/HznFLDs1VimIekej2J1psMc0Uyd9LV4HGKGmyrYLmDw8FGqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C5964328
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

On Mon, Jun 29, 2026 at 01:51:13PM +0900, Shuzo Ichiyoshi wrote:
> The IGC RETA register stores four 8-bit queue indexes.
> igc_rss_configure() and igc_add_rss_filter() used a fresh
> uninitialized union for each table entry and wrote the register only
> every fourth entry. As a result, three bytes of each RETA register
> came from stack garbage.
> 
> Build the register a word at a time and initialize all four queue
> indexes before writing it.
> 
> Fixes: a5aeb2b9e225 ("net/igc: support Rx and Tx")
> Fixes: 746664d546fb ("net/igc: support flow API")
> Cc: stable@dpdk.org
> Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

