Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D40C7115B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 11:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9938E40E03;
	Tue, 17 Jun 2025 13:33:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 82D6B40609;
 Tue, 17 Jun 2025 13:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750160034; x=1781696034;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Bls/es4zepsErJ+GW72s52i5Pgr5HGTDM0HDIsoMLZw=;
 b=bYznOrEpRHIFXtP1Bl6TGEoxrgQknlToaU8z0fU+RojfsI4OllxW8END
 9yeuSvgHO/KBiNjrnzCH2vEBnLu85Ke3MaIeVavZjb81+Znef7fpBmF3J
 RY7BGfkP0DNuSqY3xE54Wr8CQeEVzBaQhea26pFuwWfZKoC8Mf1tVnMrw
 UsDXHYjqh8ZTL6gh1h9tRdtQF084Dy4zbXKvbEnVU38O3slt3VKDyTH5n
 W2/cAKP2BxkGodPxzmgbNb1AlegSQvfFbfKg94LvPlcfRZvrgi1usijE2
 VWTiHfsLUs8w089rqMCVJE9qayT7se57fQomJ5KsrOfopMF9fk4rGDrV9 A==;
X-CSE-ConnectionGUID: R7hNxrXhToOO49ALwP1Bng==
X-CSE-MsgGUID: Y8fofkRvSE2Vxf7GffwwkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69904643"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="69904643"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 04:33:53 -0700
X-CSE-ConnectionGUID: p3NARfFaQvaMkfcqIj8PNQ==
X-CSE-MsgGUID: 08Q+9YdpSCm0C7UjoO+mZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="154045202"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 04:33:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 04:33:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 04:33:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 04:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5TIAQmjG8Ujn5hIng6MKhfjRxZSYz/jVS3btOMru7oTQIdMKkSk8SkZc0RGEyYpYXKEL1WWwcmi1V2hfrQOLOYmEcpMhFjkE3CHaODO+p9vnFMeGg+1naAL2iI9eP443bidWo8TPxzxELdkt4HzuZcBqUK1RF7T5aE57+JmV147+me3AkOcRjmFhu/J2eayu84kB5c5MgwSMrC33lwMyA1t1Z4YM9ie5vNs8qm8VHaoibvo1lMsseigYWbiszY/xsErilqHC4mdi9cOSzjwCYwNGiyEzbMAZciMIW27jhJik6qmCANIzUdxHiBJSkd0Iyc2Bt/L59SL6DS3hkxaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okUjF3oTxEmsrAE20AKVGSV2ssJfpEP1Rsg8QCezXys=;
 b=YLmuCoX/rMh0nPBJaHG9QJOR/+KPE+l2DHaNDzJFEavoYqr20w2mhzQF0V1e6+zPbjmKCi5GU92WRPEk3KmVFpNNGgXf7f/+uyeA1fJ+zRTYXIll01MeI8o9qO+dJ9YWq+Ab0iI1jGjJ713wvSKQ+NakugRf/N5zegqOgg9AwiqL8KfGLs2lrErNcFj0dY/oEjT6mhL07HRPhYyL1eZanX3MT8uJg+jlbatIJOtr3a9OrYRk2gxfM+Gjx32N0aPoySasw1oi1c4DCIXukQC7PYP65LZtB986fSXPu3ekYQUSemclb08zXj1JD4EeXAwXPSzMaqY0zKp7uyuELSMH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 11:33:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 11:33:50 +0000
Date: Tue, 17 Jun 2025 12:33:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: fix DCF RSS hash update
Message-ID: <aFFSmKEoal481ZzA@bricha3-mobl1.ger.corp.intel.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250611095058.114465-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DU2PR04CA0239.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3f5d5b-6fdf-45ca-83c5-08ddad92d47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBBOfuJPmyu39VHebXePXItEP43PF8puWF95rUXhHS4r2bdTpFstowziyfDi?=
 =?us-ascii?Q?vTmTiG+CyPeqoCTDnQiJnvzejrymIFW21haU4zlZJaSIrlAfFq4q0qA5cu4n?=
 =?us-ascii?Q?L/GjnUtdlWsKsv0E0YjzagRIGqxX00/CgR2J4q0XmNeyCzmBHUNVnJB/XtAE?=
 =?us-ascii?Q?TZBIoHHm87nx7nAifqI4nq7FM22/Qnvf/hGEmq+N0YwRBiRfmeKUcVeK6Eds?=
 =?us-ascii?Q?TQjFFyGryaYEnEsT5P6GkPdgM0JY3gbGzR7Jjjb2+U+8nB5N1A0YnRFuiJA6?=
 =?us-ascii?Q?a70KkZNy6pCkv8Xw//b9VUCTQbzSu/saeJQTea8bu22X80+k/p+jdniPJKsi?=
 =?us-ascii?Q?Gid2pUaZRq4zRwfAEQ3HWZZ56WQ5GEnPyjaxPciwn3kJbfgMCCuBscsrdBgG?=
 =?us-ascii?Q?HAkzuY+Ws7TqaeWZShQJY4Iv580EuAWQVCwjptNO4hxHch/859vmS8H9iXio?=
 =?us-ascii?Q?5B77HywwzuDyvb5GSSjW05cq+QVMdtJ5YiGxoVpfMP8Z5vNhMWy7sUWr1TOu?=
 =?us-ascii?Q?Cc5ZJOYzixUaKhpEfd8MlfnNurOn7Y2WHlL7rh4Osxi8HQdDxSIleX/yUIZE?=
 =?us-ascii?Q?zUEaw5QCF6KzP7degTFy3c4l8ckMacmAGPmzuNxQwLnTWX015kPeHTZYaGMk?=
 =?us-ascii?Q?rfxWElgD6fRVWjZPiKq86NQO9p8A+/jZZOJJ8J8L7jJafyZUDOhQXn8vq3sj?=
 =?us-ascii?Q?0VIiy6lKbe/l0SXLaiFIAZM/BnKqCITMi6w+K6NChOO+/k+bihILMKZi0qiA?=
 =?us-ascii?Q?+TDaTCBWblqQmhdIs1xwA5Bd8Z6I3RqE+eREp++3oQ6PhqrfzO0VmUNv0JMN?=
 =?us-ascii?Q?uV/Oh8VnrAOsKwKN6e5nTZPF9DrZiS7oJCRpMCoryLCV8pwTNmyHqi9Rnmwb?=
 =?us-ascii?Q?J3YH2zxdk2HKrUPoEjutsBp0hJdZmOhCrAykiTXtQw8DDYkYG7+24sbR5zui?=
 =?us-ascii?Q?LUrEcxxXg0M+Ye/yqUviV/OMDxwRU+ro/d+zzHLZZR/q/+oeHqAtTOdJVmlh?=
 =?us-ascii?Q?BPMCmKv8QBl3H8TFS1Q95nY0tHKbUof9zWpZ1ATUwVhF3htQiAMgNjhpbrc9?=
 =?us-ascii?Q?RSHLT/b1ir++uIswKOG4IU+sQtFNw6XwWVSqph5K3evFljJKq1BU5NLNtRGk?=
 =?us-ascii?Q?lJ/36ehAcoscTJLg8pxvZJEYgc5j13Ydm1jrOC5NTVW2K54AesYOMW1nN15F?=
 =?us-ascii?Q?O7oZhYyYylHcf7K9GXG24yaakjxSFu3PKodJpJbAKuFdgwJmeAwgSE5WRrh/?=
 =?us-ascii?Q?j1n7bHWbNwXsHt64NMnqPfJTivay3KFP9O5UVrEhmn56w0lzX39q3Oo7/z+O?=
 =?us-ascii?Q?IQGF5jUMuqmg2XjrHs7PQRx/+P9ZbEYQKD6Q7PTFT1vF25PErqIBGuATOkkw?=
 =?us-ascii?Q?j+C0+oTuHtVdYE94ShCZdsfXpbF+8+2ahe24dGbRbIq2W2ChIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKv+eNwrWXnkU0jQu0Fn/N2G9QsQ/utxTgJpzVw5zSTD20eav6wdJnniKilh?=
 =?us-ascii?Q?4iLXa9MMVLk1T8rArYae5ICJT/Ji5vMLba7ooKUuwiJzla7GK3JI/7iM1jU5?=
 =?us-ascii?Q?YgsTilfKDTG8SqzJ/fibxUL+QK/v9TO8v39x8BWvUO36edbmSpo+on1SCM3P?=
 =?us-ascii?Q?OBKOVHEJ2BwucBOBof1xxX7eL6VRrqUA/JjawiGYgn4ohXSSVvCx8jBTBPHi?=
 =?us-ascii?Q?EiW4XQrBm56iZGMCgc4cUwGPidnZp6YOwPOvklB6Y0Vg9eKg9tvHOCKtjWU7?=
 =?us-ascii?Q?qsXrSyoOGWcTw+jO+PHSIuk+r6qkrHss9l6lC7qu7X+/JSEAPMafvA+v5lIC?=
 =?us-ascii?Q?AenAJw/i4+7fiCE13omM9YeZtq+8QOwegOhFjqdD2mOFVGEqEatxzP+B8lay?=
 =?us-ascii?Q?pNKjzE0gZ1z1fYtyKdGl9xGUz4qUgsQ7hPRpKPFznxNk42n6HvX1auqBvCLP?=
 =?us-ascii?Q?2UDCnkjDI7CCLtq6YXe9OGVUS8kDJ119uSUEm8C/pTfJ4iemLuPc1DdDwVDG?=
 =?us-ascii?Q?u8+v4sRY4I3pln+/nhNCgNa253pK5ws5YT5s6NcTwvvx4GKgl5TKAJnssSqS?=
 =?us-ascii?Q?Cz4luoTnmDEcpbN/3CplyNACKS6X5DB/KHToebOQ1QWKhVk2XHBEbKBT5Hrg?=
 =?us-ascii?Q?xcUvoqC3qhMqcU36OjoCStRM3WElw4Sj7fR/U5I314wk33eQ/Tw3tjEBfAof?=
 =?us-ascii?Q?ydi73QWc+Hde7vcP91hKWxhOveacMZ2uuHsrucDIwGOwYMmH2aMka5jaOVYc?=
 =?us-ascii?Q?fSyQVCbTVyBA9irQxWwEstTFREcF5UbFtBofqFo/a8LPQhC1sNcpSPUP4e62?=
 =?us-ascii?Q?pup2VqJWPmpUQvtpRJpfNhzx7qqFRsqI4lJlf7QNX82zfTAs548zEERb98If?=
 =?us-ascii?Q?iFBvWvpkpQ6fFx1GbucGg2tUImOGaax514i98UkVx9gUHoNjXImBZZbbqAZE?=
 =?us-ascii?Q?r83TlS9DNkJ1YyLI8vKrwXwK0oh0JZB/R2IwXSWTbUNLTOhncFTAgOEPl2O4?=
 =?us-ascii?Q?CTN0vv2cTqEsmKPs2cqict2GZrnp7SVWXfE+hfA9pOKgBoFWF2Y/IbPIyumC?=
 =?us-ascii?Q?YOChQZaR38Hi4UpNlbpf9VUW9OWcXAgKIyEGZJwKDIpxAPYCeW8EQQSzof/W?=
 =?us-ascii?Q?Cwa34FiV3n7ffS2dN/t6UM79hSq7khLjLLhpjnDJe1cqnXcLFIF5kfO7r2a/?=
 =?us-ascii?Q?a4FtV3KPuVngsvfrbzEIvbp1iR+6C62qa3WQK3PWmscFkwTF7dXRZVAW9nqH?=
 =?us-ascii?Q?a4OBtYiFRM55n0wCLI3xqVWoBOA2NAGegZPXvWbslib1fUFghjVJBDVHFEiV?=
 =?us-ascii?Q?i/NZ4Q7KmahKVZefu1WtmrWCeaep8B4Ni7uWVK8lzGT884xmUyyImvkQqI4Q?=
 =?us-ascii?Q?rrMmqe/kZx3Q+656kljurJCE4lF69jp6uyYdTORFvbeD73oOEPp5k+OyhdbE?=
 =?us-ascii?Q?IY90jZjhAUWKHny8JJHnYSYybRwLZvlutdi4NJFnlZ40GSbaIDbDEAyLPp4u?=
 =?us-ascii?Q?SF1T6Vr1U0xHE1fh+R+4/hjrJ0K0QS9rgdwoO9b0lgRXv1X9lcAvm8N6Mc8V?=
 =?us-ascii?Q?IoIHRi6vbB4pDKIVlGH7gskSkEJS6IIMDchja/UF3Nsog2ZldgMZJoivh8na?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3f5d5b-6fdf-45ca-83c5-08ddad92d47e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:33:50.0594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhbWLo+gbPz0OmDjvkAyX83GjBlTpdFZhW6RBJqpEVonylp5aNOI6/ClZjAIdO8r6G8yBCCtlpi5QpiXtT91CKLe2MOE580o8aYh+Rro/Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
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

On Wed, Jun 11, 2025 at 09:50:57AM +0000, Mingjin Ye wrote:
> Get rss hash configuration, rss_hf is always the default value.
> The driver does nothing if the rss key is invalid during the rss
> hash update.
> 
> This patch is get the current configuration of rss_hf. Extract
> the update rss key code from ice_dcf_dev_rss_hash_update to
> ice_dcf_set_rss_key and make it consistent with the pf behaviour.
> 
> Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>

Hi,

some comments inline below.

/Bruce

> ---
>  drivers/net/intel/ice/ice_dcf_ethdev.c | 38 +++++++++++++++-----------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
> index efff76afa8..accabd0ab9 100644
> --- a/drivers/net/intel/ice/ice_dcf_ethdev.c
> +++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
> @@ -1394,31 +1394,38 @@ ice_dcf_dev_rss_reta_query(struct rte_eth_dev *dev,
>  }
>  
>  static int
> -ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
> -			struct rte_eth_rss_conf *rss_conf)
> +ice_dcf_set_rss_key(struct ice_dcf_hw *hw, uint8_t *key, uint8_t key_len)
>  {
> -	struct ice_dcf_adapter *adapter = dev->data->dev_private;
> -	struct ice_dcf_hw *hw = &adapter->real_hw;
> -	int ret;
> -
> -	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
> -		return -ENOTSUP;
> -
>  	/* HENA setting, it is enabled by default, no change */
> -	if (!rss_conf->rss_key || rss_conf->rss_key_len == 0) {
> +	if (!key || key_len == 0) {
>  		PMD_DRV_LOG(DEBUG, "No key to be configured");
>  		return 0;
> -	} else if (rss_conf->rss_key_len != hw->vf_res->rss_key_size) {
> +	} else if (key_len != hw->vf_res->rss_key_size) {
>  		PMD_DRV_LOG(ERR, "The size of hash key configured "
>  			"(%d) doesn't match the size of hardware can "
> -			"support (%d)", rss_conf->rss_key_len,
> +			"support (%d)", key_len,
>  			hw->vf_res->rss_key_size);
>  		return -EINVAL;
>  	}
>  
> -	rte_memcpy(hw->rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
> +	rte_memcpy(hw->rss_key, key, key_len);
> +
> +	return ice_dcf_configure_rss_key(hw);
> +}
> +
> +static int
> +ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
> +			struct rte_eth_rss_conf *rss_conf)
> +{
> +	struct ice_dcf_adapter *adapter = dev->data->dev_private;
> +	struct ice_dcf_hw *hw = &adapter->real_hw;
> +	int ret;
> +
> +	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
> +		return -ENOTSUP;
>  
> -	ret = ice_dcf_configure_rss_key(hw);
> +	/* set hash key */
> +	ret = ice_dcf_set_rss_key(hw, rss_conf->rss_key, rss_conf->rss_key_len);
>  	if (ret)
>  		return ret;
>  

This part of the diff (from start of the patch to here) is just extracting
the existing code into a new function, right? There is no change to
behaviour here?

> @@ -1452,8 +1459,7 @@ ice_dcf_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
>  	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
>  		return -ENOTSUP;
>  
> -	/* Just set it to default value now. */
> -	rss_conf->rss_hf = ICE_RSS_OFFLOAD_ALL;
> +	rss_conf->rss_hf = dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf;
>  

This line seems to be the main fix in this patch. Is it worth splitting the
patch in two - having this fix and the code refactor above in separate
patches?

>  	if (!rss_conf->rss_key)
>  		return 0;
> -- 
> 2.25.1
> 
