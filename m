Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F029D185CC
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 11:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A57F24028C;
	Thu,  8 Jan 2026 12:07:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7DF9540261;
 Thu,  8 Jan 2026 12:07:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767870440; x=1799406440;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=722dXlmBWlhi01y3zb41SBjPFcvx5rWE/3wzIdJbIPA=;
 b=LaXwTbSeaPLWf/Ymt9l9Kp6PtqOh78ANmfisdceQFnvuLogS4kSwBo8U
 NWh5grPFhgLc8JWg7nH5qeUz0FTAoh6Vhe1PwszHC5ApZPV1OK3ZE68S4
 +p5UMw6qoLcNZoJmO5Vml9e7RWMlV1JEprLw9J4SgVBVNvpY6wiHiZWYP
 OOkQ115xCg6EiXphRWVcDWhP6Uf6AZcaicDdomHB4X6QX7XsaskDDdbCX
 LLabm/kuZ2nm+wedB5T5NgknoMU8G59rygX+0zjVlT981NEtf27kpTcFk
 /K+Ixfz0Md3rJ90aJMziRTujGIjyQnRiLTVXhAt26M/4d7T6AO2TOcLm/ A==;
X-CSE-ConnectionGUID: abB5svCzRpqUy9atnUMsug==
X-CSE-MsgGUID: CRuZl63zQYqtIbWCIQ7jTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79887499"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="79887499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 03:07:19 -0800
X-CSE-ConnectionGUID: dzHbiTZCTgGgno7DRAhstA==
X-CSE-MsgGUID: 3BSpKJN8QryOZi4pUgYlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="203093523"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 03:07:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 03:07:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 03:07:18 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 03:07:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUcX8KSopRFUgrsF0EJUu/NXDQOJAuKNfOTeuAnd83oU3JpXLbAABvYNNbx1ZzGYtX0hjInaswbPxJQepEMaBaj6Chn1OcBBty+51pPdz4toerffygTE4dcLjmybfQ6grWXtd1MfV0QJCF96ymbdct8mDY+vDlev62OGCX5uJenyDr7pw1fq5wVezH+BKkK0uyB8qcmm2tV16rYUTYMhWVMr70fty/qQvbs00VzCwIlC9RD4NdYE8MN23rT0xi1lyk90u+ggHa4Jo7OW/l1LnA9KS/DEjRnRMPrNf6W9kZf+7iRTqHaEUwEsNM/W7upNag60GYkdS9Hc6TuPQoEuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0b3VI+HO4fdDDfZK3g7RZ9M1J4GefWdqpyWl4WTEag=;
 b=e+WYyDOdPmbKcYiwm2nLCZ/h4aTnmomBb8v1eC8xZ3sg249p1FgCzgXjY5qWdtI7Jnv64k081BAnchZVOj4BlQ2A3m6ko+mFoDiuac40OrimWeTDMrUgIFCZ4iCNzT4CBE5TBX6V82QzVUncJrXyMpveivojxafxm61HYZhEeAE2+WhXmZIgm8Nd4bpCvy1cA9PGRUObpL5FaNZK1deY5KFP5BNhqCcqF0nZEWhDIFhq9Y/miC7a2VmfhgfrJ6N0klw2EK566HF7cxIoGvVj82aEyqdMaDq8faKMprKx1E2iUZ/EEerF335kPr9TriTWBbi1yjqmpAxPvlguXzRLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 11:07:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:07:14 +0000
Date: Thu, 8 Jan 2026 11:07:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
Message-ID: <aV-P3jKpRex_gcEP@bricha3-mobl1.ger.corp.intel.com>
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260108105036.1341037-2-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: d943aa73-1843-441d-02c2-08de4ea61473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EoApN7MfHO2534aQWrrEkFOV3w99nzfIaWTfZsTP6loxnf1n99lHfUANH3/H?=
 =?us-ascii?Q?r+EXsPcfxCGUgsS7qePp9r6wQE2VxUc3Oy20ah3BPjZH/zyfzgnqbO+S5IcC?=
 =?us-ascii?Q?j5PPY7bc4ZvFCPPApvD7UHR3sDXehQVZK9wPG5hH86WsLG7e7YPovd2Hw9Qi?=
 =?us-ascii?Q?7jfgcyIyerja3vWaDljOQNQ+EmlAes+RYfqen4xwkLZbb46F/wCLSN34z/Xn?=
 =?us-ascii?Q?RN9aT5DwkXPXW/QDJb3yMzNbIYZcI2IiIERUYzPNIvRtIB3ssfXd6ogxdR+w?=
 =?us-ascii?Q?3gW4UvnOIqEPZH+a/HRDdfPOWAGVX0zXs26Bj6SjEnRG2LFYVx+J5FRLWnzs?=
 =?us-ascii?Q?ySYdwO2gx22oi3zloIV42us9UisXoH0UGfFK5XEwCrYSzxl0vh4usdEaLCcq?=
 =?us-ascii?Q?3jd13UhT0/PqcW18Tpklv/L29geRMghJoOgB670O7SdhezuC5H6l1s/rFxrz?=
 =?us-ascii?Q?sAJh3AVuQW4GDG5jdoysClvesyloeHc/V27tXw+oNtQTpmctypcSFCvQYrle?=
 =?us-ascii?Q?wiuwh4jeNTqfDNZrtFb/bSs5dLzQVMwj2x7IrXfae/X7R2gk0vlt6hNySN19?=
 =?us-ascii?Q?Y4bDwLRYTkPSNFuxzJgIbonWzXTJyXNTEK4sa8RveAI2M+W4ZULxY9Oy3GF8?=
 =?us-ascii?Q?FxCnvO2pJxYyo60L6Me3s1o+Ig3Xt3mZML8PnhBi3GbqHCxxW7CSjCKIvI1O?=
 =?us-ascii?Q?jYwNgGeQPfJ83t3yGRW5fAL9GIQ7QimW5CT/y94u1vb0ahEs93pFRdclM9/m?=
 =?us-ascii?Q?fF1qj36alNPymhy4HTUeOBAW+kcTrvk+nm6ZL1Gi85YGVUsWNE3A4Y4HzNCZ?=
 =?us-ascii?Q?PMLZZumjJJzzitL0zt8tvzhRfkCod8bifFfkuvJ+DKkPzM4bs58pgv+b4/og?=
 =?us-ascii?Q?k+jBcVq/QvTcRP50YMOrUuEXw8d3aBgzT8QdxV5K2t6fg/CKZpoj4tCiUbif?=
 =?us-ascii?Q?pI1K5cv1buwO4tUmEfX/MTWmSN6UJp+0R6A/HsfxNYA9CZ0tRxgnOCghMkwf?=
 =?us-ascii?Q?XBlAHO4yQCOYbclgD09HtWXJdRUFZ0Un+wh6RLbjzxFE8wMZ/Sp9VgHejQOk?=
 =?us-ascii?Q?Tm99olvNExDUzANBJX077SvOI76rY7nrb1qzNThhYX9s7mWi61u8BJ1jxUS1?=
 =?us-ascii?Q?RBI4nGMe+GOLFjH/lcjgRpX2mChirRj0kr0vhyJTgQ5d3gczHHWWtNrSLktM?=
 =?us-ascii?Q?7rE0XEnAGwY+sv0LlW50D9wcqlMaYEvfLJZq7Oi5wHngzWKDNXGFv5frsCTe?=
 =?us-ascii?Q?YUwx4PEnymihklqeqXIzJP/WviN8B0T6NCs8zSXsNHiYhayiZS2BlcIOmOc4?=
 =?us-ascii?Q?o5D6ojlTMOPtaqKrqMvWGHQ6ivvZeQYJZSHwAn9T1wfLl5dWb8LS3qoPcJIV?=
 =?us-ascii?Q?Df9RtN4Q3khgDkeBTjjuFLY+1yiLkfk8RDAFqyZaKShQih4tRjFf2e4h8QzZ?=
 =?us-ascii?Q?uW18gO7Xu1INKblOmVPTOCCHcp8+WnLY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dw8fYqetvpnBG5EFjVlStR9TdwrMwFEF53eVS+osuUQG87dTD5jvYNUszVhx?=
 =?us-ascii?Q?gzVGYhVPbXYxcRJrZs1SKp7v6JsdpxR7tJp7c8m39DsqHjrU2thq8p2yQXs+?=
 =?us-ascii?Q?5J/yheBZXzYyBOsnuFi+6O6VMFyLM/42Ht5A0Vv//jp1jhHYhdYA2Vc0hOBT?=
 =?us-ascii?Q?GNKFt1AbDL6qZNNJMhpBQTDtvC/l5mJimlsQ99zw7Im+nV3np26UyDcP6zmS?=
 =?us-ascii?Q?U3KZpywS3ijj1EHe7GkP28gNT44P9l4npUJramO+fsOHwLI5lRtOus1j/ZPI?=
 =?us-ascii?Q?LlUbX5RbdhF304VSJNGOsVtlnY2idwUc2yTV9PchrwAgLuIhJgs2Q3Kw4Eea?=
 =?us-ascii?Q?ZZOc9kOh9piDZo11SunrP3MPomzW/dyQDJ75bu1qruS8IzEveFiaCxCpHGE1?=
 =?us-ascii?Q?OKko4/RTa21SW+4HhbHIKdZmzTXeW/FxBQ80ZNTjlrZj1qnbfb7AM6LtjP48?=
 =?us-ascii?Q?cJiFzSjBzjgleGRNV42V0VpHmq+bZSAK+SxBbx8dMTKJqiYyln2SFVp+ybhj?=
 =?us-ascii?Q?6N2Ytq5+/K1R1Rq1/MTyH9FyvYXJe9LAJmjqYSCdo0DcCbcXQLkpfGwXOngB?=
 =?us-ascii?Q?y+hwg+LbKwixOe+TxA5ySfkIHxaVljozVWxlkjYYXh7gvrq8hkdmToDUuftk?=
 =?us-ascii?Q?+vrs8YO2A4fnff858svOfufJxJ9K1mG3RX081wetgbHjPW/95B2citFUEEUD?=
 =?us-ascii?Q?U9Y2Iixfj2ZUd2J19lroFItgXmgidhvoakw0j+wr9rpw5XbutbiyEjtSeOMR?=
 =?us-ascii?Q?DLVKkwITLm2R1tYZ87JIRSxnzojcmT7PVPkOZbdcYJVXPJDcDoICEkKJqUrv?=
 =?us-ascii?Q?VpRckB0fNJVv3m9+Gzadhd8BjgQnisarOVBASmWMuHyOXsPhbGLt+YiKlh8V?=
 =?us-ascii?Q?w03su6mmcOi0pkeqnq6UYYkGsnpUuU+JbX7bkY5HtVF2zKrMISHbFtnPMRGZ?=
 =?us-ascii?Q?Rd1kFuBQVwhcfJX20UL1MiNQ7opQKQKNQCXrZzErpMP9jwvth0x/7moBdhjA?=
 =?us-ascii?Q?qE3WtSo6PwwfMwE3UhXwTWjEENEIpNqx7wXuIbzCmtl57LHrc846PQxYYwcv?=
 =?us-ascii?Q?0noJl24zboQU4cXvP5JYIpyoyyyWXzOGOOjdl6ninF5N5vSOqAHcbSlfNMLi?=
 =?us-ascii?Q?Xg7jdw8StzSzPUkpL+UEdcDTm6V7OA6xDmMtfbTwfeauBJTnpqPt+Y/+DlNU?=
 =?us-ascii?Q?nXCbCkC4YoZ3XhqGOn+P+pciEd7GIfWnUNFApP+GV6EVFYoaPMPPt4SjzKAy?=
 =?us-ascii?Q?I6OuRTSrEDwGtl6gQGa/pO62aVQwuAdGGrhS3MHBdcMtID8ZBfowQgjBcjke?=
 =?us-ascii?Q?qx3nPz8g8uQpnqMv2UE/EGpjrvfG9k22TX/BLmrnaOzQAvpD/Zxnq9PcHcjR?=
 =?us-ascii?Q?wkQcnlB/b0PlyRATyQvGNgZOoY84lQtk5Fj998Q+45oRhzdGiZbk6/3zRBVJ?=
 =?us-ascii?Q?0+9FegwaeZdvQJfTTmDicCKyKVfI1ztR1dBFe+59tlB/Wck+joWyow98VLeF?=
 =?us-ascii?Q?Q7vHRl8l5GOa933l1apsopgunWfIdgr2CS+DKGxHcntrSklVo3hK2VchLl2G?=
 =?us-ascii?Q?H/i4vqrdOClkVbgq5Hbh5j7J4R7ifWpClCqhefmXhUi219Ii45zToXfHAw3Q?=
 =?us-ascii?Q?lJ0Hk7ldGT7K+Nr1HNB/+nAave8Zeq7N/2xGLY1jG/HP10W/bG44guducicl?=
 =?us-ascii?Q?j9z5EWxb2hPWK7k664tlx9iwDqh01SRiiBsgKtKDS15/GXRL45eGdar9STfT?=
 =?us-ascii?Q?GScprtSLiQ0GLSbXLi66SHAvv7v7eu8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d943aa73-1843-441d-02c2-08de4ea61473
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:07:14.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1soN9FpzEplQmVihJnL14v7ETXBfGfuJNzt6U1S01wwXpJDqaA+9RiJyfOVqk5DFAuSyvm6Q1ERJToJ+fjMjWsNPMwgrl53FSeEW5ku4xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
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

On Thu, Jan 08, 2026 at 11:50:37AM +0100, Robin Jarry wrote:
> Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> is not supported by rte_tel_data_add_array_container. It wrongfully
> returns -EINVAL where it should allow it.
> 
> This is supported by the JSON formatter.
> 
> Allow the same value types than rte_tel_data_add_dict_container().
> 
> Add test case to verify it works as expected.
> 
> Fixes: c933bb5177ca ("telemetry: support array values in data object")
> Cc: stable@dpdk.org
> 

Not sure this is really a fix since it's adding a new capability, but I'll
leave that to the stable tree maintainers to decide if they want to
backport or not.

