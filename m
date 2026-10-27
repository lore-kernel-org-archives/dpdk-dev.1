Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF72606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MDN1sGp9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B90D400D7;
	Tue, 27 Oct 2026 13:40:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 1634E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:40:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793104802; x=1824640802;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FwR8NyHVb/nfJDjh5rJ8UhqV6lTlOcXrTISAsiAJN2E=;
 b=MDN1sGp9H81lgnz0KAhcbPZgCjl88QS9btJJtGzdyAe34HX0/5y6BWyj
 PL3jsN4wKrWaFluDWT9y6GehL+vEcXLyvNPBU/GUmbwOAukY4YK5xxDvQ
 8wsvL9Y6RBaqw3bgjsMozvtQPRB2cwNSChq9yN5f5aCuEkVj7yOSfcpXf
 YxKkFhDVhYIZ4vIyt5G1MB0pTXloarWRTa2YqhvumIkZ+AbtbNFuaoQ7M
 3VOkccXYfYUNO59xIJc8IiEd/2p+WqlnFdg4qOFVdRAYOW874dJ3Et6SZ
 4r0MCQsxRZymbGa9ThLvD8p9ltB57ztxTFvkueNZeevCKa7w70ItrVlea g==;
X-CSE-ConnectionGUID: dq1EdfWPTe6b5oGdQ4sx7A==
X-CSE-MsgGUID: YZKAlHk5T7a8kRw6UCM+3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1828041"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1828041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:40:00 -0700
X-CSE-ConnectionGUID: f3Xy0ybqSUqywPdmv5MeEQ==
X-CSE-MsgGUID: fAJ3zcbNRPem05z3uv1V6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4871813"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:40:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:39:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 05:39:59 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:39:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMCeykkwH0mN8zDn+bBUsHGzU/goSQtzgzzFXeEYOJDut463G7Gxkri6vrexNw6rnqAYZ0B5Bgrhp7R0rOXz7jsKOnAUn/DmV+BciiCodAcdt/Y9f+RMiJWrLj1Ctg2OxUKZZkAxbrIGbYX5xwft2yNK4gjarm5J7CBn+bApjHAd/HzfVcftGGEXC/6+e2GH56GYQh4GEM8abmS2SSqXJR8YxF7nwCLW+pWEp8rNpFydo9LTf89//F7AuzFhJER+xmlL2Q61VlaN768rYfRDyamYHeqEHaz5+Q90qzOaKwiMV6tHlUac8ysEIvTjR+1VBjpOp6WkPcrgGrU4XtHGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT2z7ywajhyKBv5sjONkYsSB1H605kqB2/2N1cCYECY=;
 b=CDkm74J+UhQXmfjlMQ2bUKbAc2n4ipOkIT5WftgfTXnS05+XWbubRQQQ4XYur2Hjixy0gAKd9zEc+A1VwUhh/NXWgi6Uqgs+cOH4YKD+ceLLBXRFol6ci12GRQ21sCqGb36XmoZCj/SJCm0nb8gHbMlMDAhbjIyvZsILQwLdfLbxaoh38MoESXECKHf+aSSz2ziI4eTctzIQMGVhCaoSbXHgHm4GJ/ouoFoFocRXlJIQMrRTzTNPS2AGMiVP5m8ajeyAb4hamIyKdnjLmtp1R/A8H0eU+eP8hKJmycuwDeroLcxfnYKZg84qHrbOZfI54YM4pBAJWOgVslAv9Sq9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPF57F27BA08.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:39:55 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 12:39:55 +0000
Date: Tue, 27 Oct 2026 12:39:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/7] net/ice: fix DDP package double free on init failure
Message-ID: <auCbllLxK2e6rYUY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <ef12fc7f36b7aac2225a3fb649ede19c46b7c9d8.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef12fc7f36b7aac2225a3fb649ede19c46b7c9d8.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0347.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPF57F27BA08:EE_
X-MS-Office365-Filtering-Correlation-Id: a005ce29-7de9-4336-5e44-08df34276762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261026140227099003|4143699003|11063799006|56012099006|261021121427099003|261022113327099003|261022105027099003|261021123027099003|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vtE2E9I9LGJjMmULj8AylwpIr4cnzyp3LJXR+AcUN5BwX+AFPJvAXakbFU6QeOt0saruQ6TiDFWK2L6CBgszBgmGgo6C38zQO40n57MiUiDBJm2zXOG4SaB6j3JAXBP0zcDu6iYjpFOzNXhHfuEoMa4719Vmy3pLKJm422wsDAt2acRjeh2miHiJXxkJERxZjWJnun0fiykpGruL4kwzcDob+R8zRDaarD4sA/Ea+ZYtdbS0dzmW0M7PMZoF1XaZv95zi0xqH1Xw3XrKjNU8aNE7z9XMuSKA2aBR5K1pe/0CR0YEKcG0J9jXT8xeNaWqQFOzkpHK0adjIymTKOIFCYo4f8LCF7Ht/HLTk7pjdec75SZexGNLT34mP8e1MbleDtMf+MPUX+dMaJE+bIPr3RCYw9ElfLPjTkVHRBAuc+sCvq5NikE/H6hBSL6IJ5a3zu9dPtv6aiK7cpOh8MJPQdM8WEORDf0hPHrpH+DoWE6xknNb8+5Mnlm4k4ETY8yPvzV/GfO8X7PfIzqol632zqiPvTqMyx4lJc/ZaTGz46qMehWgCu5oh5m5nU54gjs2c9fmmJv3RFaf3dbxFl87ufggAHZgmp5Cf1q+Ti+Ls5QAed8Uddj9wwYSmiSJDdC5dK4uuazgs943yEWben8NafLDhj08SEzunA7t4rGh+jA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261021123027099003)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1dPsXd3LdCgqi2cQeQxNq4R7+4GO4cPem2bK4JSMUtCV82OtEW8vyBa2IGf?=
 =?us-ascii?Q?YfJaL32VE4WSPNDO6FVDyO4DqClCxTd92gauX7yUdGcgHXWaAhi6u208piEy?=
 =?us-ascii?Q?0vqt9zXvA7K5BHEq/siM9+/4NO+LCPWFbjkGossp+LK90HMyCItKP72Mw/J4?=
 =?us-ascii?Q?Htd3uu7AphC2GrL7DpbNMeO+gF4MJc+UJKYmwxlUUYkaX5KQ8Ha4eyXDZM4r?=
 =?us-ascii?Q?gbVWNGsCQ2U//3yjf4ypMg/E1cRHzbN23GeiD6wfnTpbgyhAPsufysnd7Dbh?=
 =?us-ascii?Q?sq5X5szrgJnF5+dgrxJtJHUaINWVcy2957Zahq4uFnVWan2Z9KthbapMQCI3?=
 =?us-ascii?Q?9H3ixVMPycvac0rI76I9uY7EGXxMl/hly29atx7LtQuUOuYB0NwZzNHl3z6T?=
 =?us-ascii?Q?71k0R+cfy4LHtorf4QFH27GK7R+y2INvs42MIQLfvRuxOmIExQA5ubZTwbnG?=
 =?us-ascii?Q?6bAS6DKtMSWGxQ8nTvf13xP3/B1CzFL7UAI/ojRo2jfIWcL3/IYAjGZK98hO?=
 =?us-ascii?Q?f2JPyOd1SXrLDjpcmVPTLt2Pj9Rfq2uaoEWz8tRbj8ZYFAkY3QG+/a3akstt?=
 =?us-ascii?Q?eaQt3lsT7n+qY45pSlmN/F1b5B9an/mF7j98TjoUMZ9ygynLOb1/G8I/IGmN?=
 =?us-ascii?Q?t/8fk+oSwjk3F8V0Hs8rh3IggbzGV//hu4AO+NZ51kbB/5pffo7GUDbJJoDJ?=
 =?us-ascii?Q?TDr4XzlLdxl5x/lLQtuVYyV0X45wyOUezPWPHHP4GT0eTyCXX92NmqaXMEhh?=
 =?us-ascii?Q?NErgBlTvxpj77Wbuz+FF+frkPI2KYurE3Ykvj6dE1VVdTF6oCagspomc1+I9?=
 =?us-ascii?Q?HiU6lfTAScmG3JQxZNcCoDpyRGcU3RiTmBnKLYtDFv1e2OtC5JoYnjswLRBZ?=
 =?us-ascii?Q?SfQc85C9QTRJ9TDgPzySIj5rDzQ0FvTnarkzIX91QQDcc5hYegjK1IXI7mOM?=
 =?us-ascii?Q?swTeE63YSLO7AX3Jceh6oliEG1kFsb/AqKwuqMmw4XcFOVRjUO8kyCuM47wc?=
 =?us-ascii?Q?BVO86S9IU5y6RfKm3mTIcmgtEfvCx0dozofbhn8JisDyC1t2aD5nr2l1A0Lt?=
 =?us-ascii?Q?yI4CQx9CmAYi79CYohWRr+gkNQQcYm3jAUvtHWZjB3Ujg02KaWwekdbeLNHx?=
 =?us-ascii?Q?2cy6z8ef6VTADavQ+xHFANrQvNxbMrI8EkE7T/K780MX3tlE4emHSlsakRHB?=
 =?us-ascii?Q?FqUV4hKVwXbBjqMN8hHz/3W0HjMJ1k87238D7b60YrCTfWwL4bpeClAlnkQN?=
 =?us-ascii?Q?cVDaWPcb8n1o/Kv4DXUcr24rZbt8DHbJO/fObPEpeouQLYb1y2FMhuofZxSm?=
 =?us-ascii?Q?p25qk2h0o8vCTbwWcVV8SyejiNTfN1Bf+m2TaV6z+2QK+xmfLHAR7I8GB2co?=
 =?us-ascii?Q?OWQi3ZKHWjxxw6Gv5iJ7oDgT5OVoLKOfudl88VwdqHxGlk2W12QdkAlqGs6w?=
 =?us-ascii?Q?Y2A8IqIoNLScY1HMOEkd7SoatFXFtmL0LzgW3aOXaIvQI2tn83aNz5VnbT0f?=
 =?us-ascii?Q?cxU7xJ/t13KvrQL/sxjt71XDeHwV4fsGKdmzionI4MmRdnGoMs3plDj4MS23?=
 =?us-ascii?Q?mAVmi8c4PAF3qkSB8K4kir6N+IJvOxF9oGBn3iYU++3ijNRiKCk6vU2Nfj07?=
 =?us-ascii?Q?WqjkX+OrLX8obaDY8dV5XydEUzW/mJLpy6Ov3t/iaD0aVJrK4xC0m1hOMA54?=
 =?us-ascii?Q?o3uRn/GhMWU05sQf97aPXtONpMuAlq592EYH5JLaCpMmw/EEpqliJxNhAVEE?=
 =?us-ascii?Q?ng5fiaRvG0gilHeB+8YKkqejWULjNyE=3D?=
X-Exchange-RoutingPolicyChecked: l9M0OjocmfECLfUd+xIDHldjK59Ax/nh4/eGyrH8C3pCcb2V7TPYEfKfWwwjU00fi5ClHpSg49mWp+BVuQr8Gn/87kkPEuBwrQNmvro+Q9Be3eigcSvc9iXTS3HAfhyThdNuVoWCkuyt9mnF8IhW+mBwYFx8zZHEY2jcAeuhdawjpQ3mXJdJFtqu/jdTxoDD5qkI95dz1vo+SJCI1asiNv+H8oXaC82GlGSJpCoVY1FYtiEKP2XhaTpPWjcA61CKC/VraRkcgq5WQwye0YZj0DyIpgEIA+yNcdQP48w8mPI2MYebzneob4fbpEoAmnT6Ghs2Z0MuF03YAvziOUCYaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a005ce29-7de9-4336-5e44-08df34276762
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:39:55.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeZcLWz3REllpqV89JCE7t9dFbuLISJKEIoGyYpK/nEDbWBIBQzi84CSdqg+OUWTGvB15Kr4i/5fFScdHQweOaoQ6yuZuF/OR0TX4F7ApcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF57F27BA08
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:31AM +0000, Anurag Mandal wrote:
> When ice_init_hw_tbls() fails, ice_dev_init() frees the DDP package
> copy but leaves hw->pkg_copy and hw->seg pointing into it. Without
> safe mode, the error path then calls ice_deinit_hw(), which frees
> the package copy again through ice_free_seg().
> 
> Use ice_free_seg(), which also clears these pointers.
> 
> Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index b846555b97..dd3a4976ab 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -2785,7 +2785,7 @@ ice_dev_init(struct rte_eth_dev *dev)
>  		ret = ice_init_hw_tbls(hw);
>  		if (ret) {
>  			PMD_INIT_LOG(ERR, "ice_init_hw_tbls failed: %d", ret);
> -			ice_free(hw, hw->pkg_copy);
> +			ice_free_seg(hw);
>  		}
>  	}
>  
> -- 
> 2.25.1
> 
