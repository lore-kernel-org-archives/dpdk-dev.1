Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA84BCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19C99402D6;
	Thu, 23 Oct 2025 18:18:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B17D840144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761236305; x=1792772305;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IjHILlMdZOrlCouwSPfiQqazLthZ/adSNM1SCLLYho8=;
 b=gwcKTOiZzhbJHYodjBcZPGYZa6qy5LAeovWRo49FYKEfKxsVPdYOK2ag
 PrKFw+pnzx0qEoGFRwDA2ulf3dxbu9ClTgZj4eOW04+LSZvSb0tXLW+XZ
 3W3x7OSKz/kiAulQsAP8yVhQsOurSyfHhD4+97LcCwdIBaPPLuUniu+KM
 jacpr32Di0g3EDBAgGgwqK1TcwQJlx6sFNATEAkCQ9XFUt5FniWjX62Pf
 sX6d9T2nQwl5o/3X0wQ5zi/D1NC422A4Wg6ARAUBo0u+/hhMMiQvwxxFG
 PeGJp7kW60dGZBU7lpx8SZE3cqjr0KA3+A1ENBIJLASo7NQZKe07dX3tL A==;
X-CSE-ConnectionGUID: f0AwWO1nRZeBGB6KfvOdxQ==
X-CSE-MsgGUID: 0PSIRm74QHShnHNSyoF+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63117314"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="63117314"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:18:24 -0700
X-CSE-ConnectionGUID: CnKItIEASA++rrjm7F67PQ==
X-CSE-MsgGUID: MAcrUKMsT4OKyt/+SKnRbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="184586527"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:18:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:18:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:18:23 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX45+0SOD1Eb/2h6sYPEgStrNomHzjriDuxbG709NPW4DNnJ5U0KWyoCuxU63OcgL5RNiEDu/JLLudzy01ZEx2nUZF/lnDjGa9CqhEnxjVFHieSXodirmUYOOH6YyHajMQz83Ba7GqKDnfm4AXsRBdR1OlQuqp8hUtRAQjfEKQ6aC6+DTM3ciRHrAgZu5HOYd4P+sJMTh0DOQJ+GS61R9LhF2Ej6btOQ6cz1S6T6EcXpo5CZkoVhl+Re133ixrN4Q2U2OTyT6pMgLlNlewPt2NQ/YS98BHdVX582zpkw+SUKFcZCIMz43yJezBRQbXusqGwxdQnuNULLgKRo0Bn53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srYmPlZW/DCXigTaVTQjv9e67fsEKCfBP11qXgjARxU=;
 b=aAtgzLiVXgAzWNoxfC4+rAL7pAxhQDr77PEKmi6HE/EMRM1oDarbxMZ/dVpbU7w5Y6k4CQEz7NLTfHUoGt7FwFYGpGWOgL4ugKJQNTIwAnWJuPiE5A+/SZqSrnqIiaZUcOF3jAwk4Uqp4gSr4tNgxICoPmF/apB6GBhZExRBFfFroD2akrPRCH1/XrxAtT1BzwC8x0J0vW/2GBmvPqWSR1rekY70pyYZfruxPbwJWTC0As3i+o8BVRFSrgmZU07LIWCCnomy2zDfJDw6SlJuli0khlqpxTgz5zCRVXH6HF54+fdLiLS6G7TNSCWqmlW4S2wIECm+sA6QnDG3uEDfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:18:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:18:21 +0000
Date: Thu, 23 Oct 2025 17:18:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v4 4/8] dumpcap: handle pdump requests from primary
Message-ID: <aPpVRyitrafuXY0z@bricha3-mobl1.ger.corp.intel.com>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
 <20251023154748.38535-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251023154748.38535-5-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: e4485dbd-71ba-4d86-2049-08de124fc872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96On4nltG/EpupUgyiuiIoYYqawaPjdj5xUwVV309wND2r+hBIEHdggoY9kx?=
 =?us-ascii?Q?hUNvUG1J2RwhhGkBYZqI4z30qptSUPwFev3dLwoONo0OoJMNoq+GYcFzRbOR?=
 =?us-ascii?Q?TIxvx3zDeZTtwz/9BPPG9QMCxntxEcV4V43yLt1Ddu9MQPpltkiexvdE0M5J?=
 =?us-ascii?Q?Q/C7HMxonsSv3PVkDhxTyt/wDq2Ss84d0Y/k5a+HMIAr5PkYkGwZoP/CnCIH?=
 =?us-ascii?Q?mSDcGey1NkVHN7gvhFfCdNb7h6FwIt87DFghYC5z7iB0El9/fBmJfymMYr9J?=
 =?us-ascii?Q?CYL8eY/AC4SwVYfcZfCqO3uY0RTB7oX7d5677trPamAeF5pnMBL9e3cazucW?=
 =?us-ascii?Q?jd0faWHCxm7pfuR2IuwAv/k5z8GWoUcyOwXMJLuwiLId/lkW5WSNHxiLIFJQ?=
 =?us-ascii?Q?LmRzpSuJ1vdVRyLip08zqm3oOFWQkRd6uxrhL7uOuaWo8PQim5EsY2QMR659?=
 =?us-ascii?Q?IEInRsP+FATwfLnEWfjFoNnYJc/w8mt5JURJtENSPyR5GQ/ltBzZ++7+K1nO?=
 =?us-ascii?Q?XJux3tqDoDFHZUOxA/9tM3G5OdpXmhKpSPEuaT3AB5GpQmSgTxEjhTKfvZ8R?=
 =?us-ascii?Q?oGHt8o53S/E2pWivmttXqXFYGdfZugI0vD1dZ7d5CUVOOzNlmqIup2MFBTHj?=
 =?us-ascii?Q?H/8UMFFGdMwbnEkuxu6KC50zWYTG2+xX8SWoZGY+YBWjaF/YWh/XIQjlEeNz?=
 =?us-ascii?Q?+2MlmoeKO6LXfylbg5IP6hs3ZEztwc3Oe0ANiJM7Eb2LKU0ciB0Rr8ofTHHC?=
 =?us-ascii?Q?sqgd0XgQgSlnN3hKgrr+toMe6wsyjWldTUy7PfsLBeAVeLmTzTrccqozzAMp?=
 =?us-ascii?Q?54HakrSCtbj5sVNO0jRrnsoATemh8ia3EzP60EkmkYvmftNURpot4jBiCF9X?=
 =?us-ascii?Q?UsLIfPOXQCBp+g+g6/h8DiAMbY6MSry3UyiN/4uLurXxHIVUes5RVwKQMdbs?=
 =?us-ascii?Q?1ANJbiu14I8MnN9AMQ2UxrVeEMjrIzbfSimVrSYHswaQaYFr9op+97a+66LI?=
 =?us-ascii?Q?T9SmttPSqcCPTb/sLHn+35AnvqrMhKx97jMSXuq+01wHzHZrWj7RVuRmCzt2?=
 =?us-ascii?Q?jZHVR+BaJAWk3P/qty4mptyHImpRkkJABQatnmm4MYsb91xunoaQIAKLgk/8?=
 =?us-ascii?Q?AT896t4n8NJtyF88PLI/j2K9nUIqk4C7OnyrUKv4fyHCv6jM8NoEYAJtELkQ?=
 =?us-ascii?Q?Hud1S6s3hL6xKn27HoyHrlwOyxav1JbqVfRC5Lz/puC6TLhDEnhJTAzDuEhO?=
 =?us-ascii?Q?yukUrU/kjt1PE/9aNZC5t7kxKVcCe4FX+uYUyVUg/W6CoHnpxVmV9kHFANt0?=
 =?us-ascii?Q?gpCqKMgWIck5Sur4mfNtsLw+4ig1e2fU31LG5h7Dr7LFhGH9H6SF+jgImMYV?=
 =?us-ascii?Q?72qw0sWTJYcUzIrM8QNnmp0hHJCZ4P0/PMJZSZhOSRS1LbaTVmzdG5nWjSt2?=
 =?us-ascii?Q?2A38S4aOO6e7m6h/z9emHDOX7Ou0mr0n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVHR1zo2/1+O9+WrcNNDZXRLeBztZ3f+LAk0WOdWe5jmOuAB4y8Kl0RfMZ37?=
 =?us-ascii?Q?yWuzG3gH2MzBFsiy7U+xVFmWOke7CNIfedkmu1uqkhCZTWEKWNKU7lj/0jIw?=
 =?us-ascii?Q?hy3TgBA+pyWL3luCRr6WSTeacip04sTxE/2n4KX+cPDwwuJ1wg3xIs8J4T7N?=
 =?us-ascii?Q?tWGN5YX0zSD8H37eNRV/hvmNztCXxWPU7IP97mLY+oSxQIvxbzzjSagADXCk?=
 =?us-ascii?Q?E6K/Xk5T6j3ehcaimpxbjxxN8xoL1i6PsQ/VGJ6bvz+E39mqCZUCleHl1oZx?=
 =?us-ascii?Q?rZ5AuScJCN8TDW3htR4KtQWn/saGOVEoYZw0eG6dD6ppXIP7CGjY7vOnFZN2?=
 =?us-ascii?Q?HXLaCsDhSjAQ4gFwOVs4G+qD665S5pNqm1c6XA1rvlAh3m7LGz+CwHw4K3Sb?=
 =?us-ascii?Q?bMHQntvEMACGq8kqQErMt8Iz8OWDmXYISVIG8vNBFXa9Xq5zo3WxAiuP6ftT?=
 =?us-ascii?Q?kqDmWpUuqxe12UwFsUrgG+i4gV4JDKVPKtgNGrJKbWoy/WpPw9Vb9uqSP6H3?=
 =?us-ascii?Q?+KqLGuUog/aQC0NBxdOY6BO9CNEGHXs2WT4NcMylEIAie89Y1ULys8b9t7P3?=
 =?us-ascii?Q?Y43AR4m5J7qQongnXmqsY6SqDyw90ECMCgP0c1PJY7lVeh1bMYPX9xG80wTC?=
 =?us-ascii?Q?k8/ePTDfnBOShhpD/kDJjqzgO5A9kW/2fPYrAom0hlrEwkYBkkSTpq/vlrow?=
 =?us-ascii?Q?hwHLC93juKZoiHLYe4UqpcaasASXPnmzbL71YCiuSFBj8Jm9pGeecBLerIXa?=
 =?us-ascii?Q?xiE7nRLd+Uw1cTWh1hFxaVYS+099fBJChrtooHjxLf9aUW6psjh0L4eWR3cy?=
 =?us-ascii?Q?BKWQM2rRhGFPGgrwAy62qT/VwMGUl3y6I3EMFtb9Reggwbc6AVaMK8ylo8rW?=
 =?us-ascii?Q?RsNipbllbPlh9PIGtUSOg/0LyPjsNM0ei/6OM1MbSw4urMBvqgumsF6PMRbM?=
 =?us-ascii?Q?EulDuax3L/IaigqDllSU0sbLuhguNbX5roR3ipplFuxumIZyCorLM5tAZ8cd?=
 =?us-ascii?Q?GosPjnm/yT4jh4xg6WzI3X7b/z7a+k1OCyQI9rfSvnTTMKTO+g+A6JfiSS/8?=
 =?us-ascii?Q?yVIUGKnLsY4Iu5znIRgrEu1LQZe6oPnRYev9AYxSyODcoHiMbgfQt1bTfjCQ?=
 =?us-ascii?Q?4Cz1Emepq+w0+DMPb3vVEqkgUlAmn/0b3HLlaOmfYEqBSZYdYgtDVF13Efzs?=
 =?us-ascii?Q?Lx4u83z2kh+a7Q1/jxa1ubGWpPtPZqUm1iwfqlCY0r2v05lf4vZ+JWR+VJFQ?=
 =?us-ascii?Q?25VUavkbLO3KKM5NItuUJWaXLRRGALqi06fyWYIwG0Bu9WutMp6jsf+4Xc8U?=
 =?us-ascii?Q?ITACHmNmsHBhqnkBhpPSfT6kyftqxzt/XFvrk6YnhxJp/oHWlgydqGX3ldcM?=
 =?us-ascii?Q?ECQfo7gWZ55IFU9HltXdaHURT/sBQvy5EAZZozYfoO2D6IrKkQD8ztG7wZ9a?=
 =?us-ascii?Q?UtO34HZHhN1oxezc5Ksmz7MeuwHWpTK8qzmwwkcNJuUgM/Zv8oOYfijbxmaG?=
 =?us-ascii?Q?65jtN5cQMp7ysL1XDPWVuHKpPM06wefNN5timeMaR+kZF+KT1TTuuY8Ha8Nf?=
 =?us-ascii?Q?foz5LSiF+2bzzw/f8kE2O7p/nojLaJFBQw9IbzHZaRA9hDkbs+TYuL3h9BFz?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4485dbd-71ba-4d86-2049-08de124fc872
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:18:21.0456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AeW2a/cA/khRcFMvBlrtWm/zkQG658IvbUfhWInM/D50QOZjn+wxD9nRKYqqKYj+FPBPE37KyMDVO5dWAVQQt072h9Z2B36zGH2eOgO1zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
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

On Thu, Oct 23, 2025 at 08:46:25AM -0700, Stephen Hemminger wrote:
> The primary process will start to notify all secondary processes
> about pdump changes. The dumpcap secondary process can just call
> rte_pdump_init() and it take care of that.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/dumpcap/main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
