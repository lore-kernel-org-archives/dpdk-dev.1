Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01375CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 11:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0D33402B5;
	Fri, 26 Sep 2025 13:40:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 14ACB4025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 13:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758886853; x=1790422853;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xHu0Mpg/092oP37LmBSrlgVl5ghIpBDNrk9jc3Ff8ok=;
 b=ZidbxLeWvft36COw/dAJSf9aOgFBfA7LIWDsJbJI7+4KDbLTXaNXFXGs
 sLvrtYqWab5FCwpS2a2k1x5P8gRyWmPTigkp5PIz65CoJtlJdxqG94HWI
 +MZhrG0Ojv3eTvvxV41A+lFTQohVHa5aKFZuIokDfFSHBJnTvx7vYONDU
 sW5s0CwlSOTdqo12Rgot3lqp+IjSWLfNkFUchZ0dos3WYaL/U2HZXvI3C
 hzzdyddp67hiYSroozSF/pM/hqvM/ZZR3225uaJpeEpjcshipfm6mXl3u
 /l96dv7PkVwCdIVNYq1ZfpEins8jvhonizglfnKsftUxS7sbGfD3ssgqG g==;
X-CSE-ConnectionGUID: MNqVEqwSSF2rfBAgTlgkJA==
X-CSE-MsgGUID: 28ukq+3yTIu71u4XgkHkOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60917638"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="60917638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 04:40:52 -0700
X-CSE-ConnectionGUID: my3R8jS/S/KAMa751vq6PQ==
X-CSE-MsgGUID: av6EXgP7RamV3VQOdehXjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="177644519"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 04:40:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:40:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 04:40:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 04:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwdjUzmgTomZlzrgfX4KYMsxcPPPW37FkvcFgw77i+IdUp+4Hb54FZB2Dmm1MYuNH8mRGXahiTe/+Z575ShRXfDNaQ5HBMiEBCV7GBJAtgMk8N62ygOjC9+xjk29GhfOty1vjETTuVCNYn1tU4hB3p0b0gJw38esgdhmdvVy7vrlKUB1nl6zlna5nVAgJemOEprWGiizCwh9IgfmU0EjA3WrusObba5OzFaxStRvMYiKeKtffKI+u3/7UOMxDmW235KYE0r2c6mkhWBGmn0y0h94hZy1ESBUVzgUbLuanNN+iIZ4BxqHNUDhN/APhDg2OV2Eb758Y0NHKYU2ugAtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WsyuQTDenNMoluKvlKKiQejEmuC9fRXdWFQnOpBdTI=;
 b=BH+NtglWj4SRHlkQnFFqBERaSwCh31Vsk/+BZXZEIag2Wq2ztt4VRQ4PCh3sTTqNorQ64KqcHq4RnFvPSR5iuVhgrHzyLbORkhghqdV59UtYoPgRh3Y0XEUC5uoVJwa+Xw1lUr+0GseXKEus6QRKGPVrGypNpMDZcEX9946tgfTnL8cd+THLjNL8n8AZLer41HlxN4NkuHKOKgJJqU//5MPrN/BdMssc0nKcWQvDYEvFdx7V0Gk5IIzhJdyOih54x906qfBLgT0JGKMHAo+peFqRB626K6Oy19VNjlin9va5Nm7SjD3CtZTNa22Mqpd8FirQyF2Xb46xgC0GvMJQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6702.namprd11.prod.outlook.com (2603:10b6:806:269::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 11:40:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 11:40:43 +0000
Date: Fri, 26 Sep 2025 12:40:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3 1/2] net/idpf: enable AVX2 for split queue Rx
Message-ID: <aNZ7th9tfoix1VR3@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250926085404.2074382-1-shaiq.wani@intel.com>
 <20250926085404.2074382-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250926085404.2074382-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 10732aef-424e-437a-7419-08ddfcf1869b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NvgUSQ5veIkhSowFMNvwPgqG15RlCyDP+sAp8zA5n+FrN5hcAT8h/5nxKPHz?=
 =?us-ascii?Q?c2T+3Z+U04kFT1aPaOqgjZOhd8PewGMoCpkia4kp//1a82YiorT+LpGrO1RU?=
 =?us-ascii?Q?Btrexb2V9MEbbtjNNaZ/j63SJVgXHPybtpSyARnpLpe5AJEh0KPitJz6J0Ru?=
 =?us-ascii?Q?Vf8TXmN/W413uYnlfUtdFFTiPl0LxEzlCu27SzpoIOPRElBkjB+5M9XJagLF?=
 =?us-ascii?Q?erMFr0jjssCwW6osN0tWkeYmk0BS3XYK+2PtLUqvmY53+N1Hu3OlmnDwy/zO?=
 =?us-ascii?Q?De5t1jA1nVt4KM+nlcaZ32w+IG37m7vxTk7kA81XY8avS47lQINyKtm1Bxkk?=
 =?us-ascii?Q?uAHEWOygmIaOSnwkpBl584Rb5NfeytEnmPzrGK0Y0T0gqedTHZMzAOnWoBsU?=
 =?us-ascii?Q?2Zv5COPDeaWxoS9Z2CgPcdo60rwF7VeoTJaEaEZn7Cd6Au3cmRfDhzcqY/q6?=
 =?us-ascii?Q?YBzHWyPJALbr9Png3FZdWGotmjdP4cAdecFYgljk6LLOdFuBxKAbptEmFgUk?=
 =?us-ascii?Q?P5dASCt4QHwXAoEsON0V9Fv4vdkPJunwsNUMMBzU7zWrOj0Mm7iGJNx08HoQ?=
 =?us-ascii?Q?D0LoBPk/8YHYOYTf+y5S+zdg0lzlTvUdD7ZS19ZzVl7YHjQSIYbF6h+DxqzX?=
 =?us-ascii?Q?5qtB2b6IzLfACS5R1BLjFM7K1Ccup7lpYTtAWAl/CaVBAjqUy+iGT9oeCgnS?=
 =?us-ascii?Q?DdgfT9oiUDbIf6jlnQTmH+7woJsvp5PEHQ/+A3bRoDfWutIAlmOxJ/m3MPCM?=
 =?us-ascii?Q?YE8JYks6a+zmf5OSl4AT8HH2hpL23eozVuzxgU3ZrUWg0eRZXulwdsgoJj7A?=
 =?us-ascii?Q?NcPP7FNd/l3py6HKt8NmPGLTNElaD3oppoSUCe055Z5E+krdQXtFVOXu1kyh?=
 =?us-ascii?Q?M3EMaFt8IruaoPbIoUWEVIM5tp0tPJVFNbK3SAe8Un0spamb1d/YWQ5i/2dt?=
 =?us-ascii?Q?42MBf/pSAtIlUCfM5X7ZQN2Lv/NOvVGsq3x4yVgPD58VGw3NY9VGXTFeF0qo?=
 =?us-ascii?Q?IDXL5kOAvsXng6TZxacT3YV/IieWDSVld/tv1Z9DXgAn4+5CF5zgfY9g9vEY?=
 =?us-ascii?Q?lbElwcPBW3diZ1Qa9xvzcelZIqjl09Yptv9/r5RHfwUupabuI27TzPtOl0mV?=
 =?us-ascii?Q?tkDgYHgr+A2fNvF4zUTPTdS/o2m2jCP9vTkOW2GbfjyhatTICnPiJOo7im34?=
 =?us-ascii?Q?TyBSdgPruWqUeWEL8rs1eWxr/Sq2pcyMUig7nLZrFKJ0rcdptpnECYoZ9UWe?=
 =?us-ascii?Q?RD3DJeRGYyffHdeZwtS7/OIStkhZFlmkEhQfdbOdZa5egqkWPX/ycnwf+fNq?=
 =?us-ascii?Q?0R9fiByLkRqxb1VcEW/8EA86Mm+Y9WwPWTdRVkAPRU/lQ1JXmArsO9JaVdfh?=
 =?us-ascii?Q?PMPgbeOWF7fAT+DiXbEoXSE9D7xGtd1L3s9WJq89vM96Swp3jsz4m08CsYuo?=
 =?us-ascii?Q?qDNHTmjGJ1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkEs9VUVcz0miGVMVrrjHAQlSqrmlFz5YblMOh4yraJoc+/vTRPF4c37lNBP?=
 =?us-ascii?Q?ahAJ69eYafFhgXwjMfEanwewqPwwPz5sdp75yWg/h5RxWHxuvTvoP4+N/OeL?=
 =?us-ascii?Q?zpgCgbG1WN/IIGbigB4RmqEoQL+nUWtVWw9HlHvkhplJbxQiKkSeEz66Ybrp?=
 =?us-ascii?Q?EwQapNXp2eIfu0xhrtitqdjHMk/ZFqSeO8L1FWwKYPimUpSUTPE4HV4oDPfY?=
 =?us-ascii?Q?tBCz0yKzm1E5+sImg4Q+fDSyCEIBVVdpLGZYtiW3WcP9E9GdqFTBNnQBpJq/?=
 =?us-ascii?Q?E0azVRSu9b09ZQqpS1yKO2eC9Db6/Bf0Ovw3lzoGtagEU63YFRP4w2yyJX+E?=
 =?us-ascii?Q?ebuV1sJkZs80iIKHmyegEIzkejXhFupkgShda7LKdjvQC5yX/A9uCKkgHlBT?=
 =?us-ascii?Q?xv/5ORZGOgY6BiNKoeBqEZGukpnfU8R0D2iANrOfZE0MXixdFPbpvALOmXgi?=
 =?us-ascii?Q?/DtmpzMQF9bT5pX4Gy/QNYV30K+RV1pMtYlE6xV4Rzya6dEBQUTx7z1shBo/?=
 =?us-ascii?Q?szPDdaDtQb5owroN154w/3fH+GnTBICqZHyD288sXxH8I0bmnhcNSRhxnOka?=
 =?us-ascii?Q?lFq3luI9kq4va77EOQMenc5RthqGHQjENbvzfXTy9CMrQjeI1oHe8sUuyvmk?=
 =?us-ascii?Q?iG6LItPKRV+/1uee1JZQ5aJA3oP66gSk4Jb3JpmuU4NZZnrwnWNiE62QP3sk?=
 =?us-ascii?Q?4g/sgln3fb02KomATIgJS84iqgUI/5oWyvIvWAGnjpXVHse6Pw9mRZ/vk2Fk?=
 =?us-ascii?Q?Ch8Akx73wKQqxsbmkX0Izcvl7bkGHXZ7zyEiN36hW+lbgJ58van9r7KLfABc?=
 =?us-ascii?Q?suswwAoSGsthtH89/D5BM3CzkTv7ZF3BWct9TZzlKb7/vgmJhnR3ZTA/phMy?=
 =?us-ascii?Q?bgPTnbKtSTTovEYAs/htT7mqOyBmv+f6LMpMCovLrUdLrbfI/7DJtNhJZg/7?=
 =?us-ascii?Q?Igh9HWLdLYMKQdFGkhbVx6Bl1xvuqYyT1ZG/pqhx/T8ZlWkEtFxArNeLRI22?=
 =?us-ascii?Q?P+2TIqYbE0iyyowhZjdLzCAqvtMza4dJtueOcLrSliRIQcM9Zrmoo8gnPwVU?=
 =?us-ascii?Q?UigXM6sIxVi5MnsL+WRlBUFIDjo8MjmGIG8ifsIEuDxnWg2epUh3J/CCau3l?=
 =?us-ascii?Q?yZ7tFj6VhNnLJfinKpwuNuIfEwv1x5OlGTlzlivEhBFhFuqLzKhubGYYfeoU?=
 =?us-ascii?Q?YP2DQK4MeQcP3v8WP5mKMIM7AKJL5UY/qWXAyGjAoBcN76Uiy/x/jMrEeE6F?=
 =?us-ascii?Q?0l/XtZK95bZB2CvyypWdPx4U/4D35SLZBai4Bxe3pvLKMZt35wVy8XuXTzkW?=
 =?us-ascii?Q?ISmawx2tc7I4IbhSUWZFJYnK7ct50z2pA3RIiSARcW/Pv2J9IIwq3t66FPmq?=
 =?us-ascii?Q?nx0u0JjCsnwgZi2rbjd3ND6EaZJd3jvpdX2MsxzrHg+XxJYcV0/v1Z68kYmc?=
 =?us-ascii?Q?xM7Q/fbpKUz2OTKC3GMVVnqrz1dvYLZElD8UWjeZvZa7gdD+gaqLM+emaO8b?=
 =?us-ascii?Q?GdvJVPUl/nyB8zRQk9vwLh+sUoNJQ3LbzZsfH8UYrvFm2D9QuLaOpzIAlXOJ?=
 =?us-ascii?Q?HtNlrRDgGe6J0fWiPcUSvbvhlFRUyz4yLMRmO5ZpA1heY3VlyMPdvXhzpX0U?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10732aef-424e-437a-7419-08ddfcf1869b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 11:40:43.4372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1ehBsObcM8vav07oR73EPFMsEWVCEowVL46FsY38XqEPBJtXLTDPAssCBPK1xksghXp9J3oX5IiQY70+tc9TBWW97gDkyj58BbFIPGTYbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6702
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

On Fri, Sep 26, 2025 at 02:24:03PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Hi Shaiq,

more review comments inline below.

/Bruce

> ---
>  drivers/net/intel/idpf/idpf_common_device.h   |   3 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |   9 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 242 ++++++++++++++++++
>  4 files changed, 255 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 3b95d519c6..982849dafd 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -49,8 +49,9 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ,
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_AVX2,
>  	IDPF_RX_AVX512,
> -	IDPF_RX_SINGLQ_AVX512,
> +	IDPF_RX_SINGLEQ_AVX512,
>  	IDPF_RX_MAX
>  };
>  
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a2b8c372d6..57753180a2 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -1656,6 +1656,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.extra.single_queue = true}},
> +	[IDPF_RX_AVX2] = {
> +	       .pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +	       .info = "Split AVX2 Vector",
> +	       .features = {
> +		       .rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +		       .simd_width = RTE_VECT_SIMD_256,
> +	       }},
>  #ifdef CC_AVX512_SUPPORT
>  	[IDPF_RX_AVX512] = {
>  		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> @@ -1663,7 +1670,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  		.features = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_512}},
> -	[IDPF_RX_SINGLQ_AVX512] = {
> +	[IDPF_RX_SINGLEQ_AVX512] = {

This renaming is good, but should really be in a separate patch as it's not
part of the AVX2 changes. Can you put it in a new small patch 1 in this
set.

>  		.pkt_burst = idpf_dp_singleq_recv_pkts_avx512,
>  		.info = "Single AVX512 Vector",
>  		.features = {
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..3a9af06c86 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -252,6 +252,9 @@ __rte_internal
>  uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					 uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
> +				     uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			  uint16_t nb_pkts);
>  __rte_internal
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..b00f85ce78 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,248 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> +static __rte_always_inline void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	int i;
> +	uint16_t rx_id;
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	struct rte_mbuf **rxep = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Try to bulk allocate mbufs from mempool */
> +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> +				rxep,
> +				IDPF_RXQ_REARM_THRESH) < 0) {
> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >= rx_bufq->nb_rx_desc) {
> +			__m128i zero_dma = _mm_setzero_si128();
> +
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxep[i] = &rx_bufq->fake_mbuf;
> +				_mm_storeu_si128((__m128i *)(uintptr_t)&rxdp[i], zero_dma);
> +			}
> +		}
> +			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +							IDPF_RXQ_REARM_THRESH,
> +							rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
> +
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += 2, rxep += 2, rxdp += 2) {
> +		struct rte_mbuf *mb0 = rxep[0];
> +		struct rte_mbuf *mb1 = rxep[1];
> +
> +		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
> +		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
> +
> +		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
> +		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
> +
> +		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
> +		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}

Missed this on last review.

This code is almost, almost identical to the function with the exact same
name in idpf_common_rxtx_avx512.c - and the differences don't seem to be
due to avx2/avx512. Rather than duplicating code, put this in a common
location and use it from both avx2 and avx512 files.

> +
> +static __rte_always_inline void
> +idpf_splitq_rearm_avx2(struct idpf_rx_queue *rx_bufq)
> +{
> +	int i;
> +	uint16_t rx_id;
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	struct rte_mempool_cache *cache =
> +		rte_mempool_default_cache(rx_bufq->mp, rte_lcore_id());
> +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	if (unlikely(!cache)) {
> +		idpf_splitq_rearm_common(rx_bufq);
> +		return;
> +	}
> +
> +	if (cache->len < IDPF_RXQ_REARM_THRESH) {
> +		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size - cache->len);
> +		int ret = rte_mempool_ops_dequeue_bulk(rx_bufq->mp,
> +						&cache->objs[cache->len], req);
> +		if (ret == 0) {
> +			cache->len += req;
> +		} else {
> +			if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> +				rx_bufq->nb_rx_desc) {
> +				__m128i dma_addr0 = _mm_setzero_si128();
> +				for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +					rxp[i] = &rx_bufq->fake_mbuf;
> +					_mm_storeu_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
> +					dma_addr0);
> +				}
> +			}
> +			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +				IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> +			return;
> +		}
> +	}
> +	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
> +	const int step = 2;
> +
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += step, rxp += step, rxdp += step) {
> +		struct rte_mbuf *mb0 = (struct rte_mbuf *)cache->objs[--cache->len];
> +		struct rte_mbuf *mb1 = (struct rte_mbuf *)cache->objs[--cache->len];
> +		rxp[0] = mb0;
> +		rxp[1] = mb1;
> +
> +		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
> +		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
> +
> +		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
> +		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
> +
> +		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
> +		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
> +	}
> +

And this code is very much the same as the "common" function above, in fact
the main block looks copy-pasted. Please rework to cut down on duplication?
How much perf benefit is got from this avx2-specific function vs the more
generic "common" one above?

> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +				(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +uint16_t
> +idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
> +{
> +	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
> +	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
> +	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
> +	volatile union virtchnl2_rx_desc *rxdp =
> +		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
> +
> +	rte_prefetch0(rxdp);
> +	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
> +
> +	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
> +		idpf_splitq_rearm_avx2(queue->bufq2);
> +
> +	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
> +		return 0;
> +
> +	const __m128i gen_mask =
> +		_mm_set1_epi64x(((uint64_t)queue->expected_gen_id) << 46);
> +
> +	uint16_t received = 0;
> +	for (uint16_t i = 0; i < nb_pkts; i += 4, rxdp += 4) {
> +		/* Step 1: pull mbufs */
> +		__m128i ptrs = _mm_loadu_si128((__m128i *)&sw_ring[i]);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs);
> +

How does this work on 64-bit? An SSE load/store is 16 bytes, which is only
2 pointers 64-bit (4 on 32-bit). Am I missing somewhere where you
load/store the other two pointers per iteration?

> +		/* Step 2: load descriptors */
> +		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
> +		rte_compiler_barrier();
> +		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
> +		rte_compiler_barrier();
> +		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
> +		rte_compiler_barrier();
> +		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
> +
> +		/* Step 3: shuffle out pkt_len, data_len, vlan, rss */
> +		const __m256i shuf = _mm256_set_epi8(
> +			/* descriptor 3 */
> +			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
> +			/* descriptor 2 */

By descriptor 3 and descriptor 2 do you maybe mean descriptors 1 and 0?

> +			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
> +		);
> +		__m128i d01_lo = d0, d01_hi = d1;
> +		__m128i d23_lo = d2, d23_hi = d3;

These variable assignments seem rather pointless.

> +
> +		__m256i m23 = _mm256_shuffle_epi8(_mm256_set_m128i(d23_hi, d23_lo), shuf);
> +		__m256i m01 = _mm256_shuffle_epi8(_mm256_set_m128i(d01_hi, d01_lo), shuf);
> +
> +		/* Step 4: extract ptypes */
> +		const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +		__m256i pt23 = _mm256_and_si256(_mm256_set_m128i(d23_hi, d23_lo), ptype_mask);
> +		__m256i pt01 = _mm256_and_si256(_mm256_set_m128i(d01_hi, d01_lo), ptype_mask);

I imagine the compiler is smart enough to realise it and optimize it away,
but you are still merging the descriptor pairs twice here, ones with the
shuffle and a second time here when doing masking. Rather than renaming the
variables as hi and lo 128bit values, why not merge them there into 256-bit
values.

> +
> +		uint16_t ptype2 = _mm256_extract_epi16(pt23, 1);
> +		uint16_t ptype3 = _mm256_extract_epi16(pt23, 9);
> +		uint16_t ptype0 = _mm256_extract_epi16(pt01, 1);
> +		uint16_t ptype1 = _mm256_extract_epi16(pt01, 9);
> +
> +		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype3], 2);
> +		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype2], 0);
> +		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype1], 2);
> +		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype0], 0);
> +
> +		/* Step 5: extract gen bits */
> +		__m128i sts0 = _mm_srli_epi64(d0, 46);
> +		__m128i sts1 = _mm_srli_epi64(d1, 46);
> +		__m128i sts2 = _mm_srli_epi64(d2, 46);
> +		__m128i sts3 = _mm_srli_epi64(d3, 46);
> +
> +		__m128i merged_lo = _mm_unpacklo_epi64(sts0, sts2);
> +		__m128i merged_hi = _mm_unpacklo_epi64(sts1, sts3);
> +		__m128i valid = _mm_and_si128(_mm_and_si128(merged_lo, merged_hi),
> +						  _mm_unpacklo_epi64(gen_mask, gen_mask));
> +		__m128i cmp = _mm_cmpeq_epi64(valid, _mm_unpacklo_epi64(gen_mask, gen_mask));
> +		int burst = _mm_movemask_pd(_mm_castsi128_pd(cmp));
> +
> +		/* Step 6: write rearm_data safely */
> +		__m128i m01_lo = _mm256_castsi256_si128(m01);
> +		__m128i m23_lo = _mm256_castsi256_si128(m23);
> +
> +		uint64_t tmp01[2], tmp23[2];
> +		_mm_storeu_si128((__m128i *)tmp01, m01_lo);
> +		_mm_storeu_si128((__m128i *)tmp23, m23_lo);
> +		*(uint64_t *)&rx_pkts[i]->rearm_data = tmp01[0];
> +		*(uint64_t *)&rx_pkts[i + 1]->rearm_data = tmp01[1];
> +		*(uint64_t *)&rx_pkts[i + 2]->rearm_data = tmp23[0];
> +		*(uint64_t *)&rx_pkts[i + 3]->rearm_data = tmp23[1];

Doing additional stores tends to be bad for performance. Extract the data
to do proper stores.

However, I only see 64-bits being written to each mbuf here, covering the
data_off, ref_cnt, nb_segs and port fields, which all can be set to
constant values read from the per-queue or per-port data. The "ice" driver
writes to the rearm-data in the avx2 path because it's doing a 256-bit
store covering the rearm data, the flags and the descriptor metadata. I
think here you are writing the descriptor metdata data to the rearm data
instead. Please check this.

> +
> +		received += burst;
> +		if (burst != 4)
> +			break;
> +	}
> +
> +	queue->rx_tail += received;
> +	if (received & 1) {
> +		queue->rx_tail &= ~(uint16_t)1;
> +		received--;
> +	}
> +	queue->rx_tail &= (queue->nb_rx_desc - 1);
> +	queue->expected_gen_id ^= ((queue->rx_tail & queue->nb_rx_desc) != 0);
> +	queue->bufq2->rxrearm_nb += received;
> +
> +	return received;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
> +
>  static inline void
>  idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
> -- 
> 2.34.1
> 
