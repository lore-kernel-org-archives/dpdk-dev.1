Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D1DCA600E
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 09:56:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD7504027B;
	Thu,  8 Oct 2026 11:56:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4660D40274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 11:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453409; x=1822989409;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Asg0ZCacc5g76Fb4DPLkQUYzO3If6Y9MYoM1Ljr6jxI=;
 b=g7ElpoUL93dgAFMZ+IoHPqFpDaBimj1dwQLBCSDSNo4AUDnppMreJPtR
 ZSzFn99wQ98hJRp3jDA0koF1B8FCCs/OW/YJ5yWkiN2Gf1jcK6xzEzp+8
 4TApQQAn4FNHXNrIxCk7p5b81rfEiq+AnHzsT6sgOXMK7We7jTfVkcXr/
 xUZ+qcYCJeI/pl3bfBAhB1B/u4m1j1sHURcaoEEJel6DtAk3e68y0zO4/
 1buL9Igd4TERWmzJ296LzBsQucVQrxHVmKZLpM8m9Kg4mrjQ6ROu9rObQ
 lPGuqrMw0+7lf7I0uOdrWWfwYmsebzxWySLozn1UWn2yDoFj3x+hE6zZo g==;
X-CSE-ConnectionGUID: ft3pfKAZS/euKPRaLAmJnA==
X-CSE-MsgGUID: be5ASBd6RXCrvx5xb2CwyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="114198"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="114198"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 02:56:48 -0700
X-CSE-ConnectionGUID: U48FeMadSz2J0mS0Py1Qkg==
X-CSE-MsgGUID: s1LeL7n+TsOajF+L3un63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="324088"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 02:56:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:56:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 02:56:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPS2uIP4mV4Al5zzoUxMRF0Qv4Sh3DBYpD17mHinZkN9wXWWMPDLvm2f/tWtl5U2YTxE0YMTho7bAq7MyAZgcBadlCkEWqhNI6DWpR1rMNHRJkGa1BGR1xeoh3V2MA9CcuEIzoIEy1XAMfc9hJ7fcAuSYVapxQjZ3FYfjV8AB7K5NbBy9uhX5eaXaoACVuVwogOP+LqHEY7iU0+XB39PUtOkScFIvBhwr8NuMaW5LQPCgOb6kWbGWHEVH5EZ94wLDhwdPYKidy0wBcWZgDnUqdwHDII+pa2n14h2qcrsUsuwxzhXAtiTF+vRuD3cbpJ7Gp2Bv0XqyOSR0Mj6NRiA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgOs/3w2+M8pQ9PffXmor17YzsshkiZ+RliFzqvcLQg=;
 b=UExlJynBWrX737ufxsNhQ24id0NZR8ePQTOLsBdMCQuSVFAXwU6TIhNg18WLmPM4rKpZiCfvkl0/r1of5jCX+PWg5QQmmuOp/U5Mx5xs5aiKwjIdomk2R/0hRco3PZ6YZ8oMaHsW0yK5mfNb5v4yI8CLo6XrMGPdXOJAo92JWX5TT5wN2D+EV6PNgsQVz5xWkznaZSNmyD73XNX7eusvVtnrY7QN5KKrlLKpXJ7r57NYOO+4TTII6h+BvjHaE2LppNCZjDJN3kVM8bMFOlMHJWl7llUD7XG7KF7EMgg+xFEivsgDIdVsCI7pHAGoReIib0809HQLgGh9mepynGG6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH3PPF1BAF94C4A.namprd11.prod.outlook.com (2603:10b6:518:1::d0d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:56:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 09:56:40 +0000
Date: Thu, 8 Oct 2026 10:56:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH 02/20] eal: promote rte_basename to stable
Message-ID: <asdo01RTy0xwuFld@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH3PPF1BAF94C4A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e151ed8-29cd-4f1a-fdfe-08df25227330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: QlhBNKKx0JEQLsHZm0YiFRFxH4gEJcRfXHZYzOLxlQb//rCNu1+H2Ob/H/VtK6uwkbGhT4KitLPKXt4IzT05gPQp2x+TF/8S2h3reBvpf+U0YQQiCw0x0KqOPXmC8BAtMAiqyQqgTdQ2bnRb3gLkNzIjABajGi5RBT/exK+iCqAiSGUM/wDd5E5TKBZT7vDEYIUiJI1r/6NM6LAafSF26i8eAKBIxh3TvX4tPBSj2CXWSJjIeTdSTnaGcST7vdoxLbbJCzKd7RnPJGYt0adanCN15tl7tG2YH56vF6gHHbjGN4gvuH0jtA1mvLAxewWzQmhfWYWYDPOFvDK+O/LKYTy47Uypc8LB5n1vX8OHGKZ+ENZXpbU7V9rBFoH3noeyhw7IGefH2XgvGx5+PpRQ2wJ9jComKCdliydSVrSMfnD8EvMjQL6pqtVZtnYm7TK3zkatwGhL05GHvDwfh4Aohdod1x18jJ8oDW9DCBICMvrfMK6k7UB4tnXFaRlf8p/89FcZI2QU26NCnfkOgtKENYGc+YDWP0URWo+hZVOnRNOzP9F7MZ4hTsDg36sVgXh7cnJeO3F50Krt3mlgczqRWrzTNVL7DlyHNQCuGz8lDf6mNsRLvXbMADUPsMzdEWKTc9/6K89w2k3Lxck0Mb6Lru0F1qdO0pA9TFfUdivzC8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6Swuqh3IZwGDmsVgbGUSFV4S+buOi7VDc64ld4NyMn33Us7ITvfq+UEtaUU?=
 =?us-ascii?Q?MLoPE/+4MHEVjDRs+eEpcu66xe5bCsJOgSMDY+wA/uezdukQiOnzZ65MUaY0?=
 =?us-ascii?Q?fsZaG4uCivEvT8yW2SHRE1f9gjurkPu4RZ4GAbXk1BEsN4V8ppDqhwWhiY6O?=
 =?us-ascii?Q?pn2ouQYVX6s1QX4PvTrN9MMYkmLESunLciZVSy5E798+2o2b5ZAuBxZe6RoQ?=
 =?us-ascii?Q?mq4HNARhPBZAz45u38RCVh7ZAjG8f4f6VBLwhcJiMgc/VCh7TSU0L7cU8Kbh?=
 =?us-ascii?Q?fm/O+L2v0drCdwnjJiDJSxyNIbFPt+zWU8SlAqPK8X2O6XhKFa4BSaIDfIQ3?=
 =?us-ascii?Q?YW3Tb5GksIziLcCQNHpmKkn4J/T4gznSXv/VLehj4GTX+ds1wU0A1nOsHbf0?=
 =?us-ascii?Q?2mxXWlag4Et9c4G1fVZhCjZWu0wlipiJq2zeDjkS6Jetjd0BXH6K5H2I5v+F?=
 =?us-ascii?Q?hjqrZnlXLUsI/gAasqrt3PFDibiYojNnKhtlKP5bqgwCJI7zKDito6VzqniN?=
 =?us-ascii?Q?ZHFoAMGRZyGcTrOtXev1LuXDKsZo+1qGIvuSPo9TNdGAYkkXqTaXYxE8Wod7?=
 =?us-ascii?Q?UuieLESEaLm+9M8xcGrdh3TqecWa6oIry525pSjVXUh/UKSZ1Ba3o5UA4IVO?=
 =?us-ascii?Q?aF5j4Qxzh0uuAD8NR0lkFKVk3PcId3NkwD3ibF89LG2GiOwBlAPDgIfEuOwk?=
 =?us-ascii?Q?jq7fYRGCDNyH1BMufUMHOYQ4s16w45blD27srbfngC71ksjemJK0m7iJpEUw?=
 =?us-ascii?Q?W+taWGUJF9yCabaIsLSMnzqsH0wbox0fwipITI3GxwXOM248oVSMB6Lu0zO0?=
 =?us-ascii?Q?y/bqIoBv+Z9P8tnqQR8IGyV7JDvNK+pPX95rM/KWiEWQHzvVALEW8InvqLQl?=
 =?us-ascii?Q?R1vHMc8M4WzceHEp8xUSWglLh6rOGKW5UyF/QCHd0TTfwRx2xIQbZnhBTOzQ?=
 =?us-ascii?Q?nRmZgkkYFWfE5SHVJ4DG2UE3a6H+yUx+28ukWLzPUzuTArd/IW+Rm4AJxz5w?=
 =?us-ascii?Q?eU1WNOb+RS/BkR+SAlneK1kc8kjIo76QsW3r9YpvClvBeRPUjhjaXUGpxACE?=
 =?us-ascii?Q?m2L+WtEEVj4YzB2nbr3KdgI2CwYSrTLeL2Mh8UTvwQCRxRVnSpAgzvx5eqxg?=
 =?us-ascii?Q?40/1uUTaJ3l93VTJzSmDSgSfZBI3+v8IIniGDPqbLmDefQWy9wOUNdLAVOlt?=
 =?us-ascii?Q?sieTUZj4vjNY9jbyhwi34AyqKB7aaTYeLzCR+v21GBDHtEMh1dJJu+M45Qz0?=
 =?us-ascii?Q?AkLELp43K0vUmwgBWg7/cvj1O6luubg34boaoKxbAAa8wQYe9vFZh2oY2ZX5?=
 =?us-ascii?Q?s9m3jEUqWOGlZli1NBcDwCyHxM6rnWZKSUZaHWmiEhcodKyiBSKHx2GhCWSJ?=
 =?us-ascii?Q?BT45UEi9S/avQac6jldzUuGlxIU2MBRW9WfLVpj3K7eq5/Gnozou/E+w6KRv?=
 =?us-ascii?Q?luAXqdkF2StTxFvUTPcFgKPy3Z+H7hstXvDPce7oeyAYKSn7pKVxSMb08sPg?=
 =?us-ascii?Q?3NsC/v1YtjH39SneFGgqRP8LMDmPhw9LUvdpDGGzrTNuVUacGS24trEdBK+b?=
 =?us-ascii?Q?2M9dzeYKMYiBjMEaPBP/Uw/LoyNNx7Ufm/o01uHKAlNtiNHB5scJFm7Y/L7V?=
 =?us-ascii?Q?ykS51NHzykxo6i4UrzjS0YzDnydddnBAv/WkbZvM6B3JSKN3bMhj6ccj17Vb?=
 =?us-ascii?Q?gWXxNYdqLmIq8bFwPMFJy/DnQaRThF67YyG1WZTNVRKukRsnJb6G9vJn0UQT?=
 =?us-ascii?Q?j6VIa63uhGD4eETnj/OUyOMrCVsDCMs=3D?=
X-Exchange-RoutingPolicyChecked: Huw62TjO0Rqx0fMJp3IaHjFemMAg4Pnisy4uy7OOw0dBJXhCESd+TTGcmj/4LU++M5C2y5PkYqaVn0Kdi1KF0dke8Hztvx8YCz4Xzoh3fYpEa0FtQOwqC4RUr4orvfXgVnAYddSQqnAqD+xX9L8mogJUAp78tETlPjwh0Cc87b4DMBkiHZj2Mi9QC+tt1DBqcjAZhvpt/6XJFghUMH5PPBJyNRaZIHPTmIC+7tym4NBFI5jj/HTQmmsSP2bdtCrKo7os2pr1LJQcyO7n3ct8eOrtyfVkd9bNFIKflJodt7BeiIehtNfmXxpKcT2UjUNpxr3UZlnAAbBzKQAkMVn/rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e151ed8-29cd-4f1a-fdfe-08df25227330
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:56:40.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxub0VS8spXCQqYoWLM4NJOdsVDOCwgccF9dBe17CDZt7x+v8L++s0MTIyOQlJKBOKw8aygSvxVhQeUnc3UjnQNZ8AzBz9NFIMM67hYKyVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1BAF94C4A
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

On Wed, Oct 07, 2026 at 02:39:32PM -0700, Stephen Hemminger wrote:
> rte_basename() was added in 25.11 as a portable replacement for
> basename(), whose behaviour differs between the POSIX and GNU versions.
> The prototype has not changed.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
