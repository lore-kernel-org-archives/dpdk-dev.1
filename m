Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8729BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 09:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C30E40280;
	Fri, 19 Jun 2026 11:52:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id CE2A840279;
 Fri, 19 Jun 2026 11:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781862761; x=1813398761;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/ePAQLFD5cEOa37/sm+KYos22X7dTPiSFc/0IYJrYV4=;
 b=VQkk8O5kfuRApYCudnIjglU4bMTc6EsDJTWjjG7hOULDGuWIv0x9Dngz
 pl/mjxI+JRYPIW1MBzN1orcPbehqmuB2QgsBliqoUZBMKxEJqnlMGfFK7
 75iJSbm7CNKf1nZoXoRHz/hlHIxdplUuNEneR462GXP6KozZ5cQ3ERwXK
 vvjaB3CY4jH4G7zG3+heziVSo7DapGq+F2bOuNHvooP6u0eXsK/3Pg3pO
 DAn1jX40N2JmhXVSoGT8Z5EXYECaYl/sbE4Pq4QqQVw0DXuvp6DfcMaqK
 g3gtWJsC+gf3Q/Fhc/cwA3ha2VuJamqFdOR4SbEcheqaX3g3wq2vnAci7 A==;
X-CSE-ConnectionGUID: x9p0/CF6ToieC+foXEX3/A==
X-CSE-MsgGUID: 7lQpgv2wQTyCwOsUrGan9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="105508936"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="105508936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:52:39 -0700
X-CSE-ConnectionGUID: nYAWHXgWTqee+z5oTK+/Rw==
X-CSE-MsgGUID: gbFi5OMmRe+xF7zNKGtEXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="253581202"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:52:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:52:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 02:52:38 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDzAJNKmxMN7MpGgcPRSIGKngZltQaT7oZ1hkSazcRMpP0BoizmjsKGQBoeiOFy9b7HEcd9nBJjBp/IHI26d+MexJsdqGV2FUMqIrWbOMRwCw5Vp7j53kXLtuxGrlrMtWRvafnXglXHsUX2HPqH8JoZjplYmlPD3fnM8NixedvTxO+I18QoFT4IOUzKz/nBe9nWmo+1Azgw7vlPEkJfxwxJsxN6/NayflGwTI9abzMp0nOisZnsREJRCvTS/WmFDzb/1IvRyXZZDorrRN5zyNzOEp0FAwCT7kp2gFr0A37zCUfj8nDvjTIlDzb4GQMlDqTg/OVQ37zEeTzTTMR0Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fyQmOOpYOl+edOksWcfD5e4IPzo6X9cPadC/Xgiswk=;
 b=Gllu/2jTYKBa4hiAPVKtVxDNGaA0g8hpQnL37jXAj9VSR4ULYYzfqWe2dCf6Un41hyXvkauwulmj7dR7wTtNr344WtJPVizjDNB1fqtEbV/TfLmHsAPhPvMw2sycCnPkK6OnCRJksBSojvEDYBGzi7wAkzWmLel8Ny3y+QcHPPH1BLse2RnBYlbYOhdlSIevKuMKavl3bkNFLpsBHyk1FPoACUBBKKcICYwOltLLD8OSACm6AsPrrpkRtbpFmChRXyycqCKJ+sUKqnfZd2TOc3qZ5TGPXpzSG7YCkfw1gE3KKhM8eWh8pm8ZFjdFF4M35tVwqNbVS2gpqfEEeg9Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 09:52:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 09:52:31 +0000
Date: Fri, 19 Jun 2026 10:52:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min
 Hu (Connor)" <humin29@huawei.com>,
 Declan Doherty <declan.doherty@intel.com>, 
 Tomasz Kulasek <tomaszx.kulasek@intel.com>
Subject: Re: [PATCH v2 2/4] net/bonding: check mode before setting dedicated
 queues
Message-ID: <ajURWZfxQjF6TsPi@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
 <20260529000157.235931-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529000157.235931-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:10:232::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b13b278-831c-42e7-43a5-08decde87af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: HXyMtkgO0e8VdOEstyhcBGYtrrzII7gwuQWsX7tiklLFK9j82t4OeKlK++TcUbGV8tvpeSUYUxEQ8QjPHMtcghrciD2kCkUQHMXwSbELVPfy5zCirdTg7XC1m03R2IGS1L6HkFPOuFLJCucLhbY+WgHcgP9LTr8Y0sPI/GIHmSHBQQ4qT27G96ij+7KGiW9V7NovL56q8zJlHjfJ/FZT289XO+Dam+COPX6mwFtq5Vkk/zruJyRJr2rLmY/G87ti50X3v3xivrXYkQrIPs98YyhMIsKpZTUVDAX/MYM3VraCkMk08lAoD9nrUn+mqPW/kyBfdJuW68fwiNaZLFw67dstcjVhCamRoLQFIt2N1Z6XDiba0iq1Hd1oBwTTEBsrdQbVvP9pGzmAR1opy6wHJWSDpNN1eW6665orjNzvUMMvYxd4OYyaErc0wjOqcUzMnyMFtNbob+b7vmKyXUGMa34RwjlauSGqr9YcgcKmM0EdRhtPnYAda/kgljQcdJ5DtnpeMh2p4K2iz3v5s16m82gGELrZ7RFxr9T4mQ2utQ+OAJEiiKWqbvL7/WMtyeABMid5vA5ukTnbZi1ejE5xShVrqldS3+/RCsJ/a/JtyCUGjMJpzwBLzUCLj9bqgF+LGclcJ/bCuneNdYQgZ09pqLS2ICO90pnRLc5x0yimu44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEIqK5XEZnUwjNecoHyHDdkbR7Wwz6QUmkQRzAvLCy9ZdsekilVeXqNf2S0U?=
 =?us-ascii?Q?EP00N2AnyNGNFNikc4GfVgcxhi8yHwARlNJF4Oq40bHONBO3ZPPQWVXhvWYG?=
 =?us-ascii?Q?bnTofVWmkvcWO2+FzCf6WSTa/HxPEgTyQ8W2kgsi94rOXp6+Ba4/fFqn7mIn?=
 =?us-ascii?Q?Li3LHGMBJaZ8ffVcudo6G6+ZU/uo7mIM7NfGxrsjiJFpQ4hUFbTv98x5yQrH?=
 =?us-ascii?Q?KeFGJaQLzpGdfNgpx73Ab+NSN4M7keiCP+lg1zyK3gWgt8B6vMu+bAHNFnrY?=
 =?us-ascii?Q?oeWDPFp7aypJPq3jE/2qpB2kN9T0o7kYIGUkQiSlmnPG6/TRLGbskUJ7Lwqd?=
 =?us-ascii?Q?pOB3QcspV72csyURLE1TojvsIyUpkJIU88a/K+Xf3J2PR27E1a3hkE1oJvwJ?=
 =?us-ascii?Q?HqKVi+yqk74KcW9EY0LDqt3K5eCzy7wji5pi6nNvTdZhzuSna8QpLGd01XO0?=
 =?us-ascii?Q?z4CT7Bp8ThhbjHZksnOnyVVBKnmy4rptGyT47QUCvNE92k7HLc0G/eLi8cao?=
 =?us-ascii?Q?JbSaPw4eoWFPrJHxIakDm/a8aGgf2iP6kqpwcWkUEgAMi7du+TIzMmE+iSDV?=
 =?us-ascii?Q?IjvvRZse27aLNLa/patKg1UETEK7/zvgQKkn0RFVhpXCEPkO7iJDAAldGufG?=
 =?us-ascii?Q?BevIh7AC2vbR8+IV1JyNXMx/vC3kVngRuSY6ih9a+jDJN8ZKH7GKbrKxOwYD?=
 =?us-ascii?Q?9UNHh0xxrVairIXXybagQDXF0G1011yGXlfbFg7HPgJvA7WK7Ie36ncloHM4?=
 =?us-ascii?Q?1JLooyqdwiR/au2P3AVmAQDmyoSjouSW4MJHKzOk89Occ1kxA86to/VZbP1R?=
 =?us-ascii?Q?6DZBNUEm7UK3co4S2tMhVmZryC4AJRAfkHyJtqmKHYwUSoEgducwUSgnc9t/?=
 =?us-ascii?Q?TCEbsCbtk9iqbohZn71zf7qoRDnjPoy5co8WxqpkD49NRPPPNMOaOcfKsy7J?=
 =?us-ascii?Q?9MuxmV9jbyeXdjTfVcjTvvn8umwz+LsOe0uasTrlHL/32w0P1XluyIvPWMXU?=
 =?us-ascii?Q?pjD/51R7So47+PBvsev1UE/LbY0VeRabnK8BcUz2QcqY7eGKk4m+L/wheTUT?=
 =?us-ascii?Q?Yz1W8IM+40lmUohmyMaedlY+6CPMKSOjrXYIw/dA9DKt+gfopOLvbkWwkBou?=
 =?us-ascii?Q?lqbtxZ9PKVEgmj0lch5v2NE2gdDxeyPkLBG1yyTvd8M6eaOr6TCWf/i3K7VS?=
 =?us-ascii?Q?vAArvbSZY/kdGzyUdpksBxUs43//JprLu+VDd0NAR2CZ81CDnCJuuJ44/eMS?=
 =?us-ascii?Q?l8qH66taXgdq2QpFm3xOFl/7E4n3lwwUOzs5D0Svxa3IgeIi4HeIGkirZAy8?=
 =?us-ascii?Q?0Ki5Oug9csfZjH0adXNeZXjJZGOcFgEbdLUOqBwecZIekf63ruiRC3HC8PjT?=
 =?us-ascii?Q?XYFiVZqbqPPDOntRvYCcKHayepzOrDBgwD+xu1HDPDjtzy6y7KtEuufYLhKz?=
 =?us-ascii?Q?g3cIYoi2re0vQKA5PIMR1WWtoupbCrGCqG5nZbKGxdWnyj37VzaIyfCDWLo/?=
 =?us-ascii?Q?/5bVpOprflZPvsus3uc7pZLGbYWIRY9/vfyPEETp3Zp6Uk9rMG+ieE/vl8/m?=
 =?us-ascii?Q?0mylmWAI70jnPugdPvHD7var8nVcd0csavL24l7wafvn2pxX4ZXbxYuD8L6l?=
 =?us-ascii?Q?ozztGkpj2XTKqZq6QxbQ1jiGw+e52ImVmYriHWVA2BJ2eLU4RVVW4m/RvftV?=
 =?us-ascii?Q?i9ZCMZv5pnDRk4WwlZFWhnuptXlvtLqNQ6wsmcJHsXo8o5NF9lqrb0i84R5E?=
 =?us-ascii?Q?OgSNzGGa5LBnCt6bK4tIZ3noaqbByBM=3D?=
X-Exchange-RoutingPolicyChecked: g5DL8x+MTneg8MAMTgyQhnXbQWcyFfwatbtA7T9mKHI/HveDMA+UMYO2qrmsNY/R94hUyvo21b+oUOsQg238Idul4XIbZviAyGz36/ratjxnHXpVlU4kNQUbi2l6Jk54jQWLhZrkXRutu0YEM81ynQkKD87g8ZiNM0xrqnjAH/YsfLLDdcjNQ+HINgH9ppFHfdolk0v7Iiy6uzjTBKkzntYBzwDYFJ4eSZfKmjNnmfYCLK3a0/Gj/J6zmxxxAC12Ou5mHReo1PRUYucyHmI2t0/6uMI6QLfi2hWL+9O705sRVoiNBnxB1+nLQjAes72kMVPLhszKwU0qxz1wa18SiQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b13b278-831c-42e7-43a5-08decde87af9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:52:31.3339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1CL6g5MRnkz79soEt14CeTpP/f04aZTKx9vYn1hmsKinGVeQtbCCAtnUB3md1KT3q2ORekbcuodcVyghhXoKwKiiot4RDy2W/tg0x9DUtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

On Thu, May 28, 2026 at 04:59:14PM -0700, Stephen Hemminger wrote:
> The calls to enable and disable dedicated queues are missing
> check for mode.
> 
> Fixes: 112891cd27e5 ("net/bonding: add dedicated HW queues for LACP control")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
