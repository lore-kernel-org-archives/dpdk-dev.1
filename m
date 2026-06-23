Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D6CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 17:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 330CB402B0;
	Tue, 23 Jun 2026 19:04:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D7345402A2;
 Tue, 23 Jun 2026 19:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782234238; x=1813770238;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j6gvMH/65T7qbTjEOGYjntbE4jlAwo4aMc+SJYZRvmY=;
 b=UJCrlQ+iKM3VMQdCgNY4TvOMjiX9x/qULgp2jJcp1XCaiRyfWZSSytkC
 /FuIoPWartB3kvwbPkX0h0939/Qu41xPni5mxsnioYGAL+9JNaxYIKJek
 z//GeC00y67MeCT/w3U95ElhdBwyNNgjZYeDg4WkOMrO2FfpnarqK22gr
 EOod90sOcjNmuJvUWXfzRoEUZpXUMbMqf/68JRjmKx71i2L3pWIzTYhwI
 nHgoZVM1eYCsFTI0rVQYV2OgHuxfia8N4oNRjLMOt5IndSOVCT7LzqUD0
 9mBF48o/f49Fka6d7Iet3YAXda+sIDsFya4Ro5c+/TqArIXRt70/Nf3IU A==;
X-CSE-ConnectionGUID: ZMTT75lvQyiMAJFgus1Kyw==
X-CSE-MsgGUID: gaCGAstzT4OJJQckXGEZbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94375004"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="94375004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 10:03:32 -0700
X-CSE-ConnectionGUID: cbcN3EXfRqO51EnkFGQ2nQ==
X-CSE-MsgGUID: PMRe7q1ERhKF46ErylZiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="249598540"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 10:03:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 10:03:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 10:03:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 10:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFgw/F0nuPv8sOPU5HzL945ORg1Vg88N4zm8/E6EVEqOrRi3y32jHQq7+gwwnqX9i+VQ3FcnLBbL7b/A1XSl3AfbuYBBOaKnzLjapErPwM1Zxw2FSc6LKOxvooBNn0vFHQpLtJ+CB1Fi/+Eb+HSxDKQQHA2p6zRy0TSwfMB8moVP2JNMad5RX6e/b03ymfZ7hlECC4feqlGhYVS58gmvPLcXOWOhcwnL4ivFvhz8Q7WQ5XHX1LuLce3HzuwbGAo0FeW+Stq2td7QCNYrmI17LB76hQFY0gV2vF60C/FnaQYpMzRJ6RS8lJ/OglQHpflRiGZo+AckznqVQat+CMXeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajTp/yO4lZEEvEggtY6ItcElkJNHmb9jD8XHz+9biJ0=;
 b=mYW+YmV5uBPuWr+Yt8AOR8xYHnUCRKtnplhoDoP7iTA5d82uGTzHfqgBAP9Yj5Ads+iSFEEf8nGdCfgJwz3ZTGCW2iiCXKvrvhFMP4f671Tfionab+jST7521fF+a7LJ45OHCp8Y/Q8HKRVUNXseiqDau3zkb3sx3t9jWjPfjG98N7Zw82R6UhHO5L3REIkhVud9kOfEG3mwSUXNjJNEDZBPVSZYaHrnBTNmQEiRTq8T7e9pHGyBex19C0biJwYnWHYMvdQsoz9Djip97G1PBt2DdjGcORnV5BjSXOCJHm7B7OKag6zvoc9UMhuleAt/gBHbqzOEPZ1NhZqviVSz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH3PPF7708D4D9D.namprd11.prod.outlook.com (2603:10b6:518:1::d31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 17:02:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 17:02:46 +0000
Date: Tue, 23 Jun 2026 18:02:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Devendra Singh Rawat <dsinghrawat@marvell.com>, "Alok
 Prasad" <palok@marvell.com>, Harish Patil <harish.patil@cavium.com>
Subject: Re: [PATCH 14/17] net/qede: replace strncpy with strlcpy
Message-ID: <ajq8MlCClDf7S7Su@bricha3-mobl1.ger.corp.intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623165150.765443-15-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623165150.765443-15-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0211.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH3PPF7708D4D9D:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3b1e7f-e201-4a10-29ae-08ded1493f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: IvDOktTlcVOzCwj1I6coWqN4bkSAoTDA0nmM6Oy9x+B59nzxRcX3wNYOJWL2bXHBWu4s21eulfKGJWVxJUe/Fmz72tNA43hprrlnvjkfR95BHmhD6zQBHDfE91j09OMLu88qCJaSAbiDh97KA3EQwmaS55HeMh83cE4I9ocxK6HySiHW76TpXyAfauPjZPABax16xVTyZ6bBaWMGteus3hN1vZrmMLTz1X6iEA6v0UvjjIUNrjtBUQ3PPX1pxbR8XNxD2wX0Y5s6G5GVNEIxZ/TT8iu3iKsMWC24LWg0+JGl2CuCbuPp4UUykFMmpY36hQpOJM+z00nGSNeP84lr/giRln9XGiSdBhEgksQt+zwPbBEma+94NAUYkHH8SuT/iMO80uOTT/XRdkSM0UrwVnlRuQEETm65ELloPIHD5967nPgo0iHrGrNT4jgRnjCMmlKz0iF5xiMnIMpOO7E4c9nxV6qHV0OHLI0/MJAKEcpaa53cIDeU9rc3JPpbHZZE/BH8y9/jMUxjTyE/CTYFuCq7Us8WojMnFJNnTQbgMF/jE9aTjDQ/RbtohbOr6Wapdi+mQQyaABLG7CHIYk9zrYDa+UHflfgtNebMuQUxBjRLPS5xJEPAttZPiz/ijBlidL1aQBhQo8otehvNf3oF1gnsMJS6GuUX8SGr2vymxkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6s//cY2l+5b1u3S+qOM5kEUAfhBJLvreNmgfjkJBRDsDDeZ9Y2MdPAbHv+ie?=
 =?us-ascii?Q?nhKc9V6jEmTdyp3DI/z9EMp4fcXMSVmqwIm/co2GY4nnpmrm062v9N3NIWPu?=
 =?us-ascii?Q?a7ONaEij4iAL+Wcx2QgKKNRZ1YdbkSARX2uHYuIoei7ni3RRgx2ODuNvVuwA?=
 =?us-ascii?Q?1OW/iOxTjB1/PKuvVQb4cMT+lykRDVt/J/8gvG8Bvz4+3/PmVvlBlWpQ0izu?=
 =?us-ascii?Q?z+6Pqc/TbOWGn2+F7EGnf9y29wrcw2EL9LbJE9kiHM2gSF0TwSp2cp3joJPh?=
 =?us-ascii?Q?yuXKfTiMWNPK0mdaCTnBasHjIyICGEbyvIempyBSzw0rc6ATfjYorZfX1uvB?=
 =?us-ascii?Q?see6hNijC1C0MLdf+DVSNALouXSr909ggdP7KCQtIVzACzAflxu/l3793mOE?=
 =?us-ascii?Q?IUSmnBN3n3ErGYQ9B96N60zTdINAfix3OMGyH9w46DM7saW75aj/1DFyTdAX?=
 =?us-ascii?Q?grgiIz3OxkKfgiTOAjrCcEiLUR6UJvSEM3ji2QWWdsKeTmXM8dYYXynXklXG?=
 =?us-ascii?Q?GER6eiV07D/Yr243cqaiRGEc0AX0Lcf/I74Z+1OJYntNXbvpupP1Hky2It4M?=
 =?us-ascii?Q?m6HRjDdwK7y4ZILLy8dge/u8K5XTJ15Covfm0n/lh3zeFvnSh8lf8OyMvjFk?=
 =?us-ascii?Q?m9cDOxXGuN8imvs6HxnJUWI63YFDyRIMY3Lhj/ui+KbxhlLCEreC/fui7wHE?=
 =?us-ascii?Q?Idd1XSIJndXlVB0rmd4VzIpdFtvTU8ojjoBT2vSOXq78dj+nwY/uGBhMBB7C?=
 =?us-ascii?Q?TxCxKeUxKfpq+O1KnW7SrpAXwGj9Zkh8syBAzDceWVjTS0IgVfHZ63+iPXoa?=
 =?us-ascii?Q?TySbq+7AzjUFhWzo6fXv7KqY7erXtl1+qodkaq2OHrVcBXAQsIrK86Nz7z96?=
 =?us-ascii?Q?IiPY4+Lno2NSK5zI1xBL/iZ3tZxDUv8X/6oFRyeRkOG8FxASWjYQmloo+z+K?=
 =?us-ascii?Q?VQ7Nx04FSTp8IlXOZUod5yAJM6ngGwsszfemJnReq8btOc3q1Y+od4HHSli/?=
 =?us-ascii?Q?Jd94ihOdvz+XVOz93aXSj7SL8oxUKabOygB8DazwkPfTXa7ouKml2wAV2up4?=
 =?us-ascii?Q?r9zvB6DHFRBYZ5ps2hcPiC6i96xtZEiwYOXgEKwtROhBd3ZW7mG696RqpZXD?=
 =?us-ascii?Q?QTA6DO9aB+KfjkjCNK3jX5QFkkiVnD2VTRrNQD5O4+YWc0rLVcOyNxRNAiNM?=
 =?us-ascii?Q?v28qk/oRB+Duo3oPcG88yzTbMurCX8E+3nPs/cRu0NV8dK6ep+3NjGTJX1lN?=
 =?us-ascii?Q?xG0iu7H319ZfnQZgb51PN+NNP+vj19SOP4c/iwSq+iPgn8EjRzhwxly8C1fY?=
 =?us-ascii?Q?NoqcTANG/PReL+LkNK31Vl/+3XmhdMIL3p+N++Nco9CIYEx3yZohwWZFo8/q?=
 =?us-ascii?Q?HfWxGHFo5D8NzHnLrmZzggDmaFqmjehVzyoLxin5P/tJMupLE3T7nSKbvhj/?=
 =?us-ascii?Q?uAHbtvBwFHg3ZEHb0BY36o9ppUfqDJ/Lsl/auOev2zrmB7Wsznekg8R5Im98?=
 =?us-ascii?Q?gyU38Qt6mcE+XfHHiJT+dCGnlUmKJSSkxNlEyPsXIU6qZn7AujqKzZCIngy2?=
 =?us-ascii?Q?ftgyXA8Qx/jlZ59qakVk01x2nG1vLEVbxN1zltVLnGLPF8viWLB5dkH8W1Sv?=
 =?us-ascii?Q?Dzz8+ME0dbpqRqJzSQ8BQTsza1EfJP3IQzRkiijUATzBuJIcrKK2PUkM/hBw?=
 =?us-ascii?Q?YGE8+myej0JsbWBBl8IvtKmA6uQ/u1b0A02D8NGfMIKrSUiZrv+PlMpE3ohQ?=
 =?us-ascii?Q?tKtZDiXv0iQlPzQBQDtIl4LwP9eVozI=3D?=
X-Exchange-RoutingPolicyChecked: bP3f8X0QP1XXvpOZmRN2RND4XDLqtHknIhzyoGnNjEQSEW7jkovk/rOFD5EhL31rhevmh36lshXFnytV2obKwqLm8IyEgb3YV1z2uCt4kh2yVWzJYtPkakiPnX5Wvao7VVfrCAsVrpZiaJq1TOack58SEkLIgUs7o/YaomK35agjNy42kK+xPTxD8bjRlWID8hK3WPVcfgzjZPWXaX8LY1M3kVP5HTpCQkfOY28DXI6wJb9VXh02Wiwplxfs3SGa0OJ4cOo6agxpRjiqdAei90bpfCW5JVnpGAdXIEkmETmIYdlEeDNcRo4NkUkrPIQmKAYenqKKPQ92ErSBu7Ajzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3b1e7f-e201-4a10-29ae-08ded1493f7a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 17:02:46.1932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTs8aIUbU4SqqnutUCIT3Dp5h47H6j9lijdH2AE2ewoAhsTHcnT+Iskq4qoPkynkHBmMiWq6D9mrriDMSvhKnWaLWpsSxYncRe7moDXsu4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
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

On Tue, Jun 23, 2026 at 05:51:44PM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: 7eca78cefde8 ("net/qede: fix driver version string")

Correction:
Fixes: 2ea6f76aff40 ("qede: add core driver")


> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/qede/qede_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
> index 4efc2dd349..2f37f956cb 100644
> --- a/drivers/net/qede/qede_ethdev.c
> +++ b/drivers/net/qede/qede_ethdev.c
> @@ -2596,7 +2596,7 @@ static int qede_common_dev_init(struct rte_eth_dev *eth_dev, bool is_vf)
>  	params.drv_minor = QEDE_PMD_VERSION_MINOR;
>  	params.drv_rev = QEDE_PMD_VERSION_REVISION;
>  	params.drv_eng = QEDE_PMD_VERSION_PATCH;
> -	strncpy((char *)params.name, QEDE_PMD_VER_PREFIX,
> +	strlcpy((char *)params.name, QEDE_PMD_VER_PREFIX,
>  		QEDE_PMD_DRV_VER_STR_SIZE);
>  
>  	qede_assign_rxtx_handlers(eth_dev, true);
> -- 
> 2.53.0
> 
