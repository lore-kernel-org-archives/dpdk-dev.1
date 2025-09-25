Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8ACAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 16:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE14D40663;
	Thu, 25 Sep 2025 18:49:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 27C7C4065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 18:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758818940; x=1790354940;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Vf27tLhJiTo0UX3b+75KLyqrfOhTyqZQAwaPmdwcZls=;
 b=eR1CSTIy1BrHkoVPSf36RNg6iOBaVp6eiPxTwpeIrRcX7xhOAgX/m5TM
 t0iYAO7uqs/1AeWB/rG3nYRTc2tG2MH6mER0+tZGFoSI6U4FDftBb+67s
 Sjvhnua3Yl7WGixS6yGtiF0jWcdVI9YZbhhalQJ1dRfMK4v3qrBnbiIQM
 vGbbgaIC7kbI603dM3ALLsX/4bTEaDTVsl+U90HjzIMgzHgzmbDIs3amh
 FUmThI4RD25xi+b5J0ZXwZZtIj/493ur3rbDuC+Gg+8l5dKtX1ZfT+/CS
 jSbCYOrVjF79otqAWS6Dy+80y/dh/Zw9DG3Q7i4VmbdtxBnoQ9trYzy6L A==;
X-CSE-ConnectionGUID: gRcA7FezTS+XGXd1ZQqjxw==
X-CSE-MsgGUID: wqbbY++NRZONGywXneNXIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="63778946"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="63778946"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 09:48:58 -0700
X-CSE-ConnectionGUID: 6JDPYoZ5SvibPRtuZDK3mg==
X-CSE-MsgGUID: 1qSblw5TRx+Hkr7NKidrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="182649242"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 09:48:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 09:48:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 09:48:57 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 09:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcFeRMlRstkDtxqSNAt1+6yDi46hNVVtZJCLLdYkPBJoCEcO4QTVeKOBJ1XqLK+0QZyFxkEVJWuXCGny9U2kDtCthY660qt+8XZLlkxSY7wlC+oqtfyMufEUA0efJOLipRz0NHvcE6JIWAIwFBmwfiCJ5t0x0lqwsprp2ZRFZlAYVQfyTjFHVB09jmwCDia6gQ1ekhnYXh1B4Z6NBLCniyaLOiXO0LJ1xvjRyYAGjIjZqQX+As8PSS404lBaFpsVnFnDseT3upXlQFyT1AFPTArj8VrdYacwmEznlAo0VzQpp3z+E7HNOzhonWDIMjpkTFNK0IklcEgdOoUOAXhV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dnisOXHktWiiyPEh/67vxuUPAzBMdeIOjuUWMgLYXA=;
 b=J7MY5QYkQdE0q9a0HkpDTL9AvF31UVhHlURMIfnyFsos1lmEYaUNpoOg3iFlYOldlG9GcGT6ivOqc/NCTVUbFXCnwU94M4vbQ4DHTnkM0WUYds7Mf/w4/CbI18qyhUQVJOfmqXbdNLZWBr63b3YwGdhhnqfeiXSdIoc1Cg600mxEDCT4+o5pV8c0/ShVGV17XHdKxaR8K/SEJBkIxQVyOkAtYJGiSUBCBMABjiBQ9OK3N/U9uAbXkjcUyFtj+7TFO+MAVc/9ZL/peLaqNq1kz2hvkDYI1GyoI5W6Z6CmQMruybUg1YcqRc4bbxPq63kQatjpb9Pe9zh09Ii8X5/M5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 16:47:26 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:47:26 +0000
Date: Thu, 25 Sep 2025 17:47:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 2/2] net/idpf: enable AVX2 for split queue Tx
Message-ID: <aNVyGDSeLWT4gq9I@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250925092020.1640175-1-shaiq.wani@intel.com>
 <20250925092020.1640175-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925092020.1640175-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: f52bfe2d-3186-4b6b-d31a-08ddfc533515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?77Wv3QYiwCqD1A9EtGtAk1QMAN2JGFJs/7IWXTsSr9uZA5lFNDOQzY+w7J+e?=
 =?us-ascii?Q?NIyQVjw6t/NjWyWMGWtkVBGei67t4pKcDFixhhd2Ev2AwgLvirahPFd8bOgp?=
 =?us-ascii?Q?6CzZrETUnNLhautDgqdqpu4+bCz8/Fdt4WGDOOHuHTeKtqhg90cJODIu26v5?=
 =?us-ascii?Q?hLjrka8jwGvpw3eKTuYMXz86wjAYxFtIAB/FyzNnabGgcjwJce+BDHJh476b?=
 =?us-ascii?Q?A4f0dqg2TXa40WooZso6VBzgNDi69/LZraBekeimvzrfCXniHRChiDtxJZPj?=
 =?us-ascii?Q?VxJjxWvM4mxQ1N26N1QM95S2GDmYHEpwule3jn/6uNT2CF622uKAv74J6ZqL?=
 =?us-ascii?Q?QDDRfs0NZ8LyV6KRSYBtjjm5KHHgdEL9U2fhfi+PshjejcWzY51QXeNU5x0c?=
 =?us-ascii?Q?CZaYww/wzeNhxkW9nisuMFWSlws1kOxe8SvwgZBXcvajBvA/NKFX9H4H+oxc?=
 =?us-ascii?Q?FqFbbeBVUQb9KC9fpYN0tcYDJIklR4EHd2Jxh3O47230hHZrV2SqYcj/jdIp?=
 =?us-ascii?Q?K+ypOleR7tj2yfHDzMHFhagk/XKPb25B9Pb/sOk4Q5s+HRe6lB3+RcTjWBK/?=
 =?us-ascii?Q?noP9z5tzRufqdDqkokY7rkDPtZdmayP33zaUDXcjK4pMDYuK4f63uTx6XHc7?=
 =?us-ascii?Q?IhCXH0C+ijqzMAxggO/F3fKOT6/ycbQXmdbSIBUgD4D9fXkNi1IzPaUogOUh?=
 =?us-ascii?Q?3vhh6fljcX7eRwkLmNV3+yioxOw0P5UGAbVavxTu9yOEO4iVR2dP52J56oYq?=
 =?us-ascii?Q?uR4ulfHT7fDTbU+Z+LpwbRr2VjMLC3ipy9q4uM793iMZpGWu5OmpKB5jN/rj?=
 =?us-ascii?Q?NXJAQP9fOlxXF/VRmE0UgAk8XOzKVtf97X1yxNHDi8a5tHMXkhBIygo5Np2v?=
 =?us-ascii?Q?CpXxfL44INbujqOCMumCfUHWN/iiypcbt6NRxIjFZX48ySSYQYkFgNtHEoTy?=
 =?us-ascii?Q?56lIq4AKyjQZ4/cMtTOj5ITv2nMWHNKWgjYmfK/7y3kumeYgQP96djawKzBh?=
 =?us-ascii?Q?ic8EZ1f7KabLRTJTTLuVN55KhODyjBosNUPkojPajLQ334zddFtaVBzp4G3o?=
 =?us-ascii?Q?8XAyT8p2QRyWSYe9MMUcmwG54bmGIXKsPV2kes2xTDasZD6DSoUWJh1e3SY0?=
 =?us-ascii?Q?/GzaXRK14Pk0Bmf/2ZY5qtKKIuAKYjmBghsiOEpBvMPvm34bzD9MBLr6PbqQ?=
 =?us-ascii?Q?OXjAStZbSYOWeMgw5562Qykssxp0DX9lHy1AO8P9k/X0jbfSo2gj9jCep29/?=
 =?us-ascii?Q?UhtzyWSN4PzMlG4/03t8Zn96IkBDEmLh1dNxHF3BKBQh5mBYUL0Cw3G4k/zg?=
 =?us-ascii?Q?HCAyEWiJIVBC9Fx+iUBFlpuFGAFEBS7MfLu9qkBTZ5HNJp8XQPCdoGJETte3?=
 =?us-ascii?Q?O7VKlj42qlUeffd9pB5Deanf+C6K65EZr+7UaqjCfAaZCg1fip8y1t6/uopV?=
 =?us-ascii?Q?Fy+KXDlvdYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OcY2uOb5tSUqbxh4nQUgNQ7ZVoLh9E03u+Tvd5zkaUI8hDqcp5kVW/ti0Rs+?=
 =?us-ascii?Q?Xp/fZoVdX/z92H6U4Fo8/W+y3BjlC9eApIMdELbW5hmVDALYk58RwDB8GBt+?=
 =?us-ascii?Q?fZv+jFCUC8s2DpDCFR8TtNgvl6bcyahd1Jhuuf0YAzSkfn0SitMx1tFF4aBF?=
 =?us-ascii?Q?TLgHGv9GWOrTUHyrz+JAlvSS7K5SjCYhJmMVJCNmNJrsU63MDtyYwbRuar1S?=
 =?us-ascii?Q?q2G3URZg6QHqPy7r+KJFedYj7yPAp2qjWmVFyy5TrH/TFOAEknyvpWTYK3rW?=
 =?us-ascii?Q?e2nLnY1RNL755IsqRKiHWNHXHHrTzkAp0L1UsvxrYCXNE4H4cRri+52qedgd?=
 =?us-ascii?Q?Kr6/oVWMylWQK37hIukw/k8vJAxki5s5tJQke0OWgjpP36St9AwJ9Iqu8GBU?=
 =?us-ascii?Q?i7c+h7OOInX70tccnpRlCCDROqgFZbhxzQ7/1fkhmVkdGLYBxHgooy5xpxqn?=
 =?us-ascii?Q?vXK0QZHT6rDQk7ELwmpkMIiXpqCUmqtTxCJUUbcBUVPFCulgzwN1jr/cgzoD?=
 =?us-ascii?Q?bBnDi85WPHkNTBVN9dtqvbTxP9NjX4YhrwnRO/NGXjrrrWRHumHV5AxSg1tY?=
 =?us-ascii?Q?M3yMgHtPw1QDi2bw3UNPLtB00DkgMGe/HJD1XVF4Rs7yzlXhrXdMT1oVDNXQ?=
 =?us-ascii?Q?3bRrmILs7fWj6m8BbTfToNEZ5v4GUfdpLAWbSn/8e5XRvjsEa2NhFyDwLabw?=
 =?us-ascii?Q?8Qb0JOMmj7NUX1ZOSPapWYocvIuVrt9P0qnBbEfWZ9btedxdNCeCiyUGyHN9?=
 =?us-ascii?Q?uWtfGCQTLpEMO3TDq/hUJfaqsVBx+KUaPCem8/cZuzGLKGCHLpiqIVffcGcY?=
 =?us-ascii?Q?BkAOXImvEDcsBq63tyQVNdKZiOgy8AB6Wz0HAZELSi8uBHUqF92JYViI0TUG?=
 =?us-ascii?Q?4u5em4TO8zeqbIUrESnfniEpTq6w7SJDPgPsF3pSCcdji0cbp8HeNnvnj2T4?=
 =?us-ascii?Q?WSmpwdunZbk3Q4I/yj6xlJO8R96uJw8pDQEg8agUJ3/Wu9k+KuZrc0s/ahrz?=
 =?us-ascii?Q?fHA5CNHuxn7ZbCjOpzuaL1YrOcH9O1G6xPjHbWvE0N2rXbdTezncPf0v3f20?=
 =?us-ascii?Q?D76QeMWswNE7towbREi0qHY2xvDXrKFW64wclV8T5jcj04v3cw6nK7mrFUYP?=
 =?us-ascii?Q?QT4KwaFxVmAgR3isaCzHpaUmfyMBrp6JQLJjPeOhyQQwwEZIU8+tFEo2xiyR?=
 =?us-ascii?Q?o5fNLUUaRwsbvyfpNWex8deUaeDpWerFHWSbfZMTKKCBoz6X74A79m6yC+1S?=
 =?us-ascii?Q?lDGrqUj25et0Fu3juke5rnIfBX7/oULhkOvyWWW2zIF3e5jR9ohmsuz/0wf4?=
 =?us-ascii?Q?J9AMIQHwNNXL1zzRYB2gJc25vtmT7fqp1/8ladUZyPmWdzC2XzEjUrc3Uhub?=
 =?us-ascii?Q?2kPnejLFOb9fydp2CPJSt6oKPUyRf7oy6muGAWJD9LbZyCTqOlLTwGksGe2a?=
 =?us-ascii?Q?vL+Io1FmNhr1Tm0XzjIl5UoZ6tJtjQXn47K0iT0HCjgWa7B8sd4V6hd/ED/k?=
 =?us-ascii?Q?/9/Hjn59J1x96jC43AmnJhDz49/cnnkPg7gR1GLDDQBOR/kA42ztw4SUbLZd?=
 =?us-ascii?Q?rUEe4RqF7XYaELB29InIEWKaXF2ZPfdc60xnXOBYyLjntXQo56J8tznMEqxR?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f52bfe2d-3186-4b6b-d31a-08ddfc533515
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:47:26.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Lv2JqXWeIr3qTqlJQrWVnKq2p1rHSevxnc68wZDzJH9ZulOEGCWThVUf166cTZsotZ7bi/6lwAPOcfNpxwAw3QFEHKGzRsfu2MXDWcsr+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
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

On Thu, Sep 25, 2025 at 02:50:20PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Hi,

see comments inline below.

/Bruce

>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 202 ++++++++++++++++++
>  drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
>  3 files changed, 214 insertions(+)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3a9af06c86..ef3199524a 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -262,6 +262,9 @@ uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
>  					struct rte_mbuf **rx_pkts,
>  					uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +				       uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
>  					struct rte_mbuf **tx_pkts,
>  					uint16_t nb_pkts);
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index b24653f195..7b28c6b32d 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -889,3 +889,205 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
>  
>  	return nb_tx;
>  }
> +
> +static __rte_always_inline void
> +idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
> +{
> +	struct idpf_splitq_tx_compl_desc *compl_ring;
> +	struct ci_tx_queue *txq;
> +	uint16_t genid, txq_qid, cq_qid, i;
> +	uint8_t ctype;
> +
> +	cq_qid = cq->tx_tail;
> +
> +	for (i = 0; i < IDPD_TXQ_SCAN_CQ_THRESH; i++) {
> +		if (cq_qid == cq->nb_tx_desc) {
> +			cq_qid = 0;
> +			cq->expected_gen_id ^= 1;  /* toggle generation bit */
> +		}
> +
> +		compl_ring = &cq->compl_ring[cq_qid];
> +
> +		genid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			 IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
> +
> +		if (genid != cq->expected_gen_id)
> +			break;
> +
> +		ctype = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			 IDPF_TXD_COMPLQ_COMPL_TYPE_M) >> IDPF_TXD_COMPLQ_COMPL_TYPE_S;
> +
> +		txq_qid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
> +			   IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
> +
> +		txq = cq->txqs[txq_qid - cq->tx_start_qid];
> +		if (ctype == IDPF_TXD_COMPLT_RS)
> +			txq->rs_compl_count++;
> +
> +		cq_qid++;
> +	}
> +
> +	cq->tx_tail = cq_qid;
> +}
> +
> +static __rte_always_inline void
> +idpf_splitq_vtx1_avx2(volatile struct idpf_flex_tx_sched_desc *txdp,
> +				struct rte_mbuf *pkt, uint64_t flags)
> +{
> +	uint64_t high_qw =
> +	IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
> +	((uint64_t)flags) |
> +	((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +	__m128i descriptor = _mm_set_epi64x(high_qw,
> +				pkt->buf_iova + pkt->data_off);

Indentation is a little off here. The high_qw line continuations should be
indented beyond the first tab-stop. For the descriptor definition, a triple
indent is a bit excessive, double indent should be sufficient.

> +	_mm_storeu_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
> +}
> +
> +
> +static inline void
> +idpf_splitq_vtx_avx2(volatile struct idpf_flex_tx_sched_desc *txdp,
> +				struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags)
> +{
> +	const uint64_t hi_qw_tmpl = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
> +	((uint64_t)flags);

Again, indent more here.

> +
> +	/* align if needed */
> +	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
> +		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> +		txdp++, pkt++, nb_pkts--;
> +	}
> +
> +	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
> +		uint64_t hi_qw3 = hi_qw_tmpl |
> +			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw2 = hi_qw_tmpl |
> +			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw1 = hi_qw_tmpl |
> +			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +		uint64_t hi_qw0 = hi_qw_tmpl |
> +			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
> +
> +		__m256i desc2_3 = _mm256_set_epi64x(hi_qw3,
> +			pkt[3]->buf_iova + pkt[3]->data_off,
> +			hi_qw2,
> +			pkt[2]->buf_iova + pkt[2]->data_off);
> +
> +		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
> +			pkt[1]->buf_iova + pkt[1]->data_off,
> +			hi_qw0,
> +			pkt[0]->buf_iova + pkt[0]->data_off);
> +
> +		_mm256_storeu_si256(RTE_CAST_PTR(__m256i *, txdp + 2), desc2_3);
> +		_mm256_storeu_si256(RTE_CAST_PTR(__m256i *, txdp), desc0_1);
> +	}

Rather than casting away the volatile here, did you consider casting it
away earlier and passing in txdp as non-volatile parameter to this
function?

> +
> +	while (nb_pkts--) {
> +		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
> +		txdp++;
> +		pkt++;
> +	}
> +}
> +
> +static inline uint16_t
> +idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +						uint16_t nb_pkts)
> +{
> +	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
> +	volatile struct idpf_flex_tx_sched_desc *txdp;
> +	struct ci_tx_entry_vec *txep;
> +	uint16_t n, nb_commit, tx_id;
> +	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
> +
> +	tx_id = txq->tx_tail;
> +
> +	/* restrict to max burst size */
> +	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
> +
> +	/* make sure we have enough free space */
> +	if (txq->nb_tx_free < txq->tx_free_thresh)
> +		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
> +
> +	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
> +	nb_pkts = nb_commit;
> +	if (unlikely(nb_pkts == 0))
> +		return 0;
> +
> +	txdp = &txq->desc_ring[tx_id];

Suggestion: I would cast away the volatile here and save later casting
away.

> +	txep = (void *)txq->sw_ring;
> +	txep += tx_id;
> +
> +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
> +
> +	n = (uint16_t)(txq->nb_tx_desc - tx_id);
> +	if (nb_commit >= n) {
> +		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
> +
> +		idpf_splitq_vtx_avx2(txdp, tx_pkts, n - 1, cmd_dtype);
> +		tx_pkts += (n - 1);
> +		txdp += (n - 1);
> +
> +		idpf_splitq_vtx1_avx2(txdp, *tx_pkts++, cmd_dtype);
> +
> +		nb_commit = (uint16_t)(nb_commit - n);
> +
> +		tx_id = 0;
> +		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
> +
> +		txdp = &txq->desc_ring[tx_id];
> +		txep = (void *)txq->sw_ring;
> +		txep += tx_id;
> +	}
> +
> +	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
> +
> +	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
> +
> +	tx_id = (uint16_t)(tx_id + nb_commit);
> +	if (tx_id > txq->tx_next_rs)
> +		txq->tx_next_rs =
> +		(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
> +
> +	txq->tx_tail = tx_id;
> +
> +	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
> +
> +	return nb_pkts;
> +}
> +
> +static __rte_always_inline uint16_t
> +idpf_splitq_xmit_pkts_vec_avx2_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
> +						uint16_t nb_pkts)
> +{
> +	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
> +	uint16_t nb_tx = 0;
> +
> +	while (nb_pkts) {
> +		uint16_t ret, num;
> +		idpf_splitq_scan_cq_ring(txq->complq);
> +
> +		if (txq->rs_compl_count > txq->tx_free_thresh) {
> +			ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
> +			txq->rs_compl_count -= txq->tx_rs_thresh;
> +		}
> +
> +		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
> +		ret = idpf_splitq_xmit_fixed_burst_vec_avx2(tx_queue,
> +								&tx_pkts[nb_tx],
> +								num);

Reduce over-indent here. If you only indent by 2 extra, you can put the
last two parameters on the one line.

> +		nb_tx += ret;
> +		nb_pkts -= ret;
> +		if (ret < num)
> +			break;
> +	}
> +
> +	return nb_tx;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx2)
> +uint16_t
> +idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
> +						uint16_t nb_pkts)
> +{
> +	return idpf_splitq_xmit_pkts_vec_avx2_cmn(tx_queue, tx_pkts, nb_pkts);
> +}

Do we need a separate wrapper function here. Are there future plans for
another different wrapper around the same common function?

> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index 1c725065df..6950fabb49 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -850,6 +850,15 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
>  				return;
>  			}
>  #endif /* CC_AVX512_SUPPORT */
> +			if (tx_simd_width == RTE_VECT_SIMD_256) {
> +				PMD_DRV_LOG(NOTICE,
> +					    "Using Split AVX2 Vector Tx (port %d).",
> +					    dev->data->port_id);
> +				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx2;
> +				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
> +				return;
> +			}
> +
>  		}
>  		PMD_DRV_LOG(NOTICE,
>  			    "Using Split Scalar Tx (port %d).",
> -- 
> 2.34.1
> 
