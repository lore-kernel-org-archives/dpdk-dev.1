Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357A606A329
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kzaA9ZF0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EDE34060F;
	Thu,  5 Nov 2026 11:16:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id D79D640296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 11:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793873768; x=1825409768;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=upJwB9/AhUNUqIHVrMwyJkBu377TbxGcT3+5T1pcypg=;
 b=kzaA9ZF0h9G71ZFR0RaZ4bcNI56Ux1yaLAyYwmJOD02XuWYA1j6QVsiL
 v5pUjVfq5LCtAmVLe7NPz24pbIWhgAR6brtOeTnrSAH5IQbfmg+Hc1euQ
 zRy+3vTzSJu8c09DffO3OhV+FgQcpf8L1j6pahENcD+gqT6JyPITrXJFB
 Bk1T4HPfkYqYY+xvW1HWoQJNA0xJCMIGtPIp/NtNYknwvvTyyS5Ct8U0h
 GigZRCrJUsqfvNg5pDgE/b7Nw5dWUrhfTgxBRBOH9QJTUM/kY8OxZ9PkF
 BJER3E0VczJDjtW3tvTob/oGgGhkmYPpmjbQho2ngooBnAiIfJSo0EOpR A==;
X-CSE-ConnectionGUID: FuUO1OaySxCiHAvhyU8ziQ==
X-CSE-MsgGUID: wTe5DWawRSy3CYai5HieJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2540795"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2540795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:16:06 -0800
X-CSE-ConnectionGUID: aRRRmEbiS7OSvHOmHUIeVg==
X-CSE-MsgGUID: uT0W+321SHixxD2nrAD6wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6987894"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:16:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:16:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 02:16:05 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 02:16:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lix5zHOpuvLv7ifb4Q8FgvNqT3seo9vcByBBie7FWqsUpPMca3XHTvChZti+5Wbz4TIx+v3LkUoVPtRh80k1P3dE/xxbl858UfkOAIj7QQ/DrRccM6YcE0yWp+RyxsiO422dAJcQ314BfFP1bNFMz7yfOzCQqkTEWfpbkDmSEJ1XqskDPi6EkQ09pbXKq3FIHJREURoIeaiuQqygcdzx7y70GLa2vKkeDi1e4wD2env9IEcxgsVipMtebIN8B5HsdEct7tgwXcPdbeE1xrTlBPbiDJ4xrh37Qk59+lXuleJtpXAZHxClZnDwXageZRazBVk+8/QaRZvu4vJN0qQ7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmySo5pKVvU/nYJ8MwBLeBTsh0UDBmO0uhRGFNvr0tE=;
 b=F6N/VX4Z+HEfxP2z1uEOyDc0ozbeFApcE637iG+wOeI/QDnHDt7agRzPUb9JsMi8zsVtDy5jvZI+yQbjIz2TDNiA7bco286KJASuiRXt5w8exHkG3rDLv+8yVaKXN4bzlokcR4iTsWG0XrBnYL3u1uXuNLYQxpr4az9UYEwHgfSQlCjw2fHD5X2g6oK6mn2jNtPTDCoJAFj4/qE5Fldl08MVAMcBR/JnfZm0SPiCROGmYIJHFUtoL+OkwCgJ7IWCdludZxXgaZCTI2HjDILCqd3b1VbtKZ6K12oAaaBcupBSvJeLZWMPNXEKCHjRWZ1M9c2o20FmQoSx1MtCIr5GRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 10:15:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 10:15:57 +0000
Date: Thu, 5 Nov 2026 10:15:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Anurag Mandal <anurag.mandal@intel.com>
Subject: Re: [PATCH v3] net/i40e: add IEEE1588 handling to AVX vector paths
Message-ID: <auxXWEF8BqMEbjoJ@bricha3-mobl1.ger.corp.intel.com>
References: <20261009053449.843546-1-anurag.mandal@intel.com>
 <20261102164816.3067808-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261102164816.3067808-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b731fc-e182-46f8-55d4-08df3b25c883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261022113327099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: M59TpAij3j/xBiS8DPabgn41pFm/2HvUcDUFxiqvqgSuEiZaFsMhfFxqssDqGJGwsBBLTm9Y6XhMk5m4KE/pu7BtE708Hx2H1tzrXJfM0CtkvZVEZSLeplshf65LZzOREy7CLKjpd7zd6ATRuocR27v5O5jEEQHkuYQEFo9+kLRn5WDT2GqV2l0so0fLGwUAhhWkW6UEsFw201ITfG6vlmop/KV7BfpzEOzR3JylQJIErWklLe3n/a3EzSFncgBnM+bWt7rInXcsjJP4CFSEiGca6hotHhL0jCgIo2TFJzv8cMjm7187ygYQ2DZIvPqEs5PPlvJUXNZFvJ34hkyuSrr/R5ZF4uVnlEUbDoW+Lt3XbTkmV/8nWmAUTWYscTnaQO0A2P25B9aQJs8XtYgJ+YKzjbUB7soFNovoDWcEf+PL9BKjg/kHnFiDWjoXWvNGOwNR9lM4JzQWBEQhRP42tULSNTJQtReT6jGqAReyZzxlTesrFOPSKlgsnqEUkmSAutvVF8F9QZcb5DnIrYz3QWQTHE6EgxMLjvutwRyI4S9FYvf/7wBUwCsz/GKNFY65enLDQL/j+WA/rj2D7B5vLsx7skrkjK+TqIQ5wsPb2yjmM0G/E3JWl0ySZNr+wUp3HFGu/2/hiMi+rzVYuit68MeyNMzRAzm56SNi6k3Amyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261022113327099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xo6lh63JwHVP2d2n8QvR7LOm+Labxqqhj5wbBRtlU8RbNGktnS2zGwlGjqJ2?=
 =?us-ascii?Q?3gaASTKj7wtC6w6CmpPIY8ni9cWB0rUVKrlRKxRkezkIHuleCiGaL2nRUOXh?=
 =?us-ascii?Q?8OL058GmiYOEWVgefthAbUmyd7Gs8Ufk8y93hGfcS8nYn4Kxka3FOqYAnQn4?=
 =?us-ascii?Q?lWeANpIE1wYmfBPu/2i/Stqjzy4MyQkg/UCBOoJZMc3BTnEF1SnDzUreVLLl?=
 =?us-ascii?Q?wagjPO76ZV4o0czBoCzBDYwL3qD5ZQ5lDjGpzpq+nlnewUIlbCEJTne5BCRh?=
 =?us-ascii?Q?nm8qNzTM255H0g0mW7CIxK14pakudP40g5HVdsi2gPzzR+4WJXocJWnAv/nW?=
 =?us-ascii?Q?q2ikot9/Fa/Qiq2IbrHf8ieqUQPoXp6P8j93vXF/HiDfCYlKkVvOJSDh3Fay?=
 =?us-ascii?Q?79o99XMFjxalohh2EiPZ0/DjnSnqp3euRa3TdC4u9yloOaVFoXVJDt3M6P3T?=
 =?us-ascii?Q?Hb3QkYl+W8kD+QxCHipU9opYquSAFMsr15onMypObBtBpCU5sEBr4DSv2KGu?=
 =?us-ascii?Q?aWFWIptP5qNpqyV1kbZnM//T0sbL5TOLTUEfREEAOHY6wb6Gn/LFKD6EsF5S?=
 =?us-ascii?Q?1T1cRV6nSU9tLk4j3DXBRmCZFx3FhjL/b8vMqdjPMjxzHBu3tJvU5T3ssabI?=
 =?us-ascii?Q?+e8tC+E/gORZpMBigxyJcmurPiHY4nNGGOZwZgzlV2XbSBg/Ytl+JJMV25sT?=
 =?us-ascii?Q?azZIVQjKAq8qcEj3zml3KWR4H5XETcbHaMIZDJbO0e9Qadm9qqqZuRzNVFJK?=
 =?us-ascii?Q?ZyC5o8t6GkJMxKxOCEqYzHor1CajaatTmQagtqsHH+acG0remb2PVbwbKkdD?=
 =?us-ascii?Q?7dFh/BdNl8joaTSME2z3n6Ha82B0p3xBKuUhmUow8mWEPwEJIx/RkENdlg88?=
 =?us-ascii?Q?xV3CsijSt+ItPWnOA89qAynpuH5iOyR4P23OvmS4xGZPOzvFRnneNPCwg7Jw?=
 =?us-ascii?Q?ECD549W2xUZofBEL0PTEnYcjVrTuYXZWOn2MuKdkzMDnYGpnxSAod4crKwOw?=
 =?us-ascii?Q?uHjaC8Br3aO/UzUbM34mqdgO91ExCFXghi2NsxyuqMXHhlwF2GmQ9mFEjVzY?=
 =?us-ascii?Q?QXXuoq3bkWfvPA/pkc6fJ8pgRkVL/blS5M82LpUD7JwdncbCwYZZ6Xyt3Vge?=
 =?us-ascii?Q?NnYbYs1xFBo+QNuEupVe+zbht8G8kHmdgOPrAjarjNY0IqOyLqkFAD0wIACH?=
 =?us-ascii?Q?wCXMdgr2+YE7Ix0Hfj0rTrhTlPaF6+s6nyvDXTMgrO47fw58Oigvsnsn3E/C?=
 =?us-ascii?Q?Q9qHebOJboxxhkIuBVHgMTpsMAt175BC/vNvN8gbBYvYyT7kvXR+QAWWqWbh?=
 =?us-ascii?Q?THyN77lqGqJk2EradUiP4DSqGycaVRRM/xUQSfLoDNzEsZQ0FgqM8Io/URcK?=
 =?us-ascii?Q?UyUEE2l5McpVnOG5/QjN4jqNZ17Wl0ec3AKd9cgiULHbB+wtXH2o/0lYHH6f?=
 =?us-ascii?Q?fHg33uSh9RKQxWjvRiR0yRk6SncprSVcNst4VqxzZ9GWUdCR9ppbQCpR9ROh?=
 =?us-ascii?Q?Bfi4/bL48BCk0cL3wUvBZHTjeVtHPFuCOza47489mVJdYI1d0B5+UHSk1lbw?=
 =?us-ascii?Q?H55Z3aMvqh3wHPb7ZM4JV9oY6rIHUmRTFFNRHViWSWtPF+0hOjaEFcVzPB76?=
 =?us-ascii?Q?kPzaRoe9r6+LCr9NGG3BDo1FHEsKgh4P2zTi1icicTDMIa95M9qa+U2SKyNL?=
 =?us-ascii?Q?tlx+3yJOy86GVh6pXepRhM/VRg2qPYSeporASVdaogPcsAE48vw0u9a3OgW6?=
 =?us-ascii?Q?ddaR8B9GVIstIwS/bZKl5hre4qlvRLo=3D?=
X-Exchange-RoutingPolicyChecked: pA4c6qzFxwq+p5VyqHfXf9yE1M1YLwNo3d9w1M0T+Jk6Rmg0Omu9wyiILjysQapXLamEeGdratZUIqfxwh6reueOICsExKTiWttG/PC1KvNAQKlcl0a15Jbgi7sUzhXl8Hi3089pQ/tStxVM01RrTppXpO8+3m+oTB8NOoCIatDzoeGYur+Um1RUT7FkVcRqeqsgzhD2YeFsRUOdc2vErKzgD6l+nHRzuhaltrBOpL8BtQMHUeQsRYhHo08CUflCwBn1R2NvcNVmwJ7xqPByTVlADFBC1OOfuouysraKyELG48sVN/kqSzsWgDWbU2lxa9bLHyl7W06H9radBEFbbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b731fc-e182-46f8-55d4-08df3b25c883
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:15:57.4997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvgEqE3Ypoh8dqPefv1Q9K35rnh42pU27+Xst5kJkaWIDZStV+91/sO3iGBDh8KBuRMeg4u5sEpPDY65aSKMM+JfWMKcCuObP+U9VEA9uq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 04:48:16PM +0000, Bruce Richardson wrote:
> The IEEE1588 timesync support was only supported on the scalar RX paths,
> but is, in a number of ways, quite similar to how FDIR support works: we
> read and process values from the various per-packet flags and then do a
> single store to the mbuf. Add support for IEEE1588 to the AVX2 and
> AVX-512 vector functions inline in the main descriptor processing loop,
> as well as the appropriate one-line fix for the case of scattered
> packets.
> 
> Suggested-by: Anurag Mandal <anurag.mandal@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Tested-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/common/rx.h                 |  3 +
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 61 ++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 63 +++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 12 ++--
>  4 files changed, 135 insertions(+), 4 deletions(-)
> 
Applied to dpdk-next-net-intel.
/Bruce
