Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B2F94CD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:28:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D79840272;
	Wed, 22 Apr 2026 09:28:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1C6F840144
 for <dev@dpdk.org>; Wed, 22 Apr 2026 09:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776842894; x=1808378894;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1GQYUD6JL8cjQnOvTNGAtOOVqZNB4crZdmbbbkaM3iE=;
 b=N51aVXpffwM2UazfM0Qlei9I8sAWHx1xXW9Etse5AVoIIqw4kRed47Jm
 PS/c026dobEI0xDk7UpWypDsSW0wOYWyedkW0/DNd/H5S8SccqMJVMUOy
 gAS6gBNEekBU8X60ryNCNt4lUTB1S1kQAiRUP45aiAVw7wKf82zhF9zqy
 hEvP1Q16LeVODvQQfGe0A+u/WMxKkg3kHpIrfTV1QNbdlcql3qQIYWapE
 rDkThdaZMxPZ39fNZgvYklW6ef4JG5JtJjlVVb83wstF8JxHPm0bmNnwv
 Jz+39ZCWqrTGLKuCObQ2fJ9ik+aWjQrJFxm3sATW8I1vlzS7lhNKc66TF g==;
X-CSE-ConnectionGUID: BfFsGRvVROCnZSv2UIfmng==
X-CSE-MsgGUID: 5oZaOHBgTRGlfN8W3ymAlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81655132"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="81655132"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 00:27:56 -0700
X-CSE-ConnectionGUID: Wb50uItFQpWWJRUSuVInCg==
X-CSE-MsgGUID: ddCpRRidQAOfmhEr6jUkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="231387804"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 00:27:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 00:27:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 00:27:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 00:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laSe2FfoRSj92rFDWqsv5+OoHRIOi42TeV1tk8BJrQEXjnlBKCjTezexP/1D6lLiyuZKkRJ4ZspP2iuhGx75i2eYdgVluGe2SjjUst/j9m4/K3G2uzyQ5vLnerwwP74BqQPbnt6irpv3NXyn3HPZ234n2Qy7OGs1iDRrNWZArDxPuKX8q49CEGJ+YCT5K8dc5AxN9RgCD0C2nURLrekliS0MQNbbi/+WtNmJM864+YdwrsrVzfaWhzfNoRuc48J+oy+ivfZd/QPVkTArwnZRTRRmItyOOdKkeI5QinGVLxJgeUKf1r+//A9TEo/5asce0Q3LG8vHtoOsucDab8/txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW3gToeqKjre5y9YiQV7gfHW+bU2/NW2Ek5Ke0MqgHM=;
 b=K1T5/TuI6QqG7th2H1h29sLpuLC9PR/tY2xXFIADdExqtIoGAbyEz00zQzKMTbk3FjAR0Os8jRdlcAqc0WfSD/yWS192XiyKrspYV3EmtO/bQLFa83Dkkz3GaCOUiDqft8U+pSP9BFeOI0wQ3vZk1MHFXOOi5C1Ms6SStQ4cE7WzQwwVt3M1Gk0V+7qDNCjcAGrm/HyRubYcI/YKy6vb1ghjlMcpnhzS7CmNHPOEqfpTgF3pWhyvernJTQQ1v3LDYx8DjKfLr0RODTiKcsOd2/GnC3viNArT8WMS9gaNA63wFiHiO1nYyx2fX6cIVm54gGGEg1kpHvwslqO8CJ05qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8830.namprd11.prod.outlook.com (2603:10b6:208:599::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 07:27:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:27:45 +0000
Date: Wed, 22 Apr 2026 08:27:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH dpdk] net/mlx5: add option to reduce Tx datapath
 compilation time
Message-ID: <aeh4a5HS9iFtm9_D@bricha3-mobl1.ger.corp.intel.com>
References: <20260421212356.573976-1-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260421212356.573976-1-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8458d0d7-9286-434f-84b8-08dea040a586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ip5gRfz7I9gpKOR6n/j1Sh1Ub5lFLO3ARfvwQmJgIPGExN9CphbarV7fV2imiYY7pAEZpKtc5fYOFmQXIrYUv0+EDUhDBoRMoBuzhfhzXjZZvJ4qzWFud/f+NiERDLe0guiQPnI6LykO+smx4ueKgp5zdPLHcbkA0f+A9N9fR2unK/xvo1FbSFGoblymq+LTyeTd6zk0TD7MTnPgsn453vBAvEnFGfDx8EDo2mgBTIFmPSSUnrQ685SVGgy647T2tJ/GJuybsxRGScvMr1JLWx0/k3g7o51LDk8LoumHUlhzIRJRItfio83QO/pn5cm6upCKApjUUD583c9Zj5NDZFL4OlW94BiZZmQxiOtIBrnjRdpyXpK4E7uDZ5ytSnaM8nTd2deT6MkKUxfCQoZ6C9MeSyv11TDPdhUw78GMbqgLKZeh6l6i5hzyWx3hupxM5NBN4YduG56RjwxL7Jhg7ICbP2jnHnSH0xHGCaQOYOUtcuZaEk5UfEJvDIUMHBNsg4y6rcBj72PbQ02+73fzc9vPFj7uDpCKUTW3/2dcvelSorldcHhXdNjCV1ipr9UmILPKBPco6c/2yBCAIfvFpECFlU19Mq7YzdUKq2DU8y6T92XINPH6HmBDBluqjKg3MEjtQDTxvw6N7/5Zx1j8MgHLeBCeGmb8plGiGPPwA+TSRIwZeO3SXVe0+bOcrNfGFlKisoUkmPEtcFQRzmipykHzkM66AUpH/n6xnntjyuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0UMxYTaeY/Wp88/vaVktT0BQZw768NF619nqavJDzuoMeyTyq2+DeApHUpe?=
 =?us-ascii?Q?CjP62m0yCzs5P5cL7azlZMLJWlYGe09o7f/w4EYjKlvzkFoxQrkCGmVjxLfA?=
 =?us-ascii?Q?utjzyHVbBkLOLtoRm1wZ29usdaU6IiFobHF2nhrcm9HATNQ0lODHVrvCrNFm?=
 =?us-ascii?Q?crAHfzFb/94xGbGswLEdjs2fVzCRgxTCBUoONIjsQ24jvYHaemW69Mwh8qbh?=
 =?us-ascii?Q?a/gVl0UYXmd+EbGKujELjLwdFzgfm2boeMOrkx23bleFyUNJxu4d/l/NCdSl?=
 =?us-ascii?Q?8SlFcKgmcjyxng2lmB1H93Y1I2kjTi5dxGqRLSyjTTIo5M/bjL1BTVgZDjFu?=
 =?us-ascii?Q?6wjMgEhSPJPQp/Xt8iRsiSfUiGFmNuIEfsQt9uUFxQfJZoSQfIg7G6nN/MvC?=
 =?us-ascii?Q?Slbz/51QydIcTO+dxJuczCe1APLcJzt84LLhEfaOdkSbfBz2gaQ9Bbz8+gQZ?=
 =?us-ascii?Q?iBDu3rDCXjanNjrNiXwjAsoKcAqlIs1jytNTH7HTZGbY6CpcDpblpEx8aAi/?=
 =?us-ascii?Q?KnZYbUUtEVM/UJzJ0MG60M2xhlX4B278Wvp2srlxVEzL3GkFxn3ILzKLy2jd?=
 =?us-ascii?Q?p1iPtVjKFFkCWOjIhpYJjCwKk0aDiDdWSE3UYVStIIiw6rg2gB1B2roPY+XA?=
 =?us-ascii?Q?469THR6LWTqKjNtIiyyJQT52mXGfZUP3lSxtgnEP8ZPVwq/obxddn34aE1Xq?=
 =?us-ascii?Q?7RLqFjqwMB63wo72a9PZNB8hSuWaN5e+++qzEe9d+PwlM8rcp2pkYhPTPd3F?=
 =?us-ascii?Q?3nweEAnhpiPBGiHKanezFskUTClkOFsq6UW2NWsODgp6/TeGDKs39A656BIp?=
 =?us-ascii?Q?i3gEAPhAzcEyzPm1D6qF4cAY2cFl9oskN6I+qx1qpXln61/ioaA67PmO6P1+?=
 =?us-ascii?Q?pKBW9CQMSUcXE0Q1yYNYL87UoKfDsZWxGx2JYeEmZglohQgZR1eVdF27yp8A?=
 =?us-ascii?Q?kwRTU1m0saNQxVtlfIRDnfME78YhNkvNdgjZSgUWAxFjiVaDyTNdTuK8IcSm?=
 =?us-ascii?Q?oPXdhtnGqF2Pwpdb2MW4N8jJCrUUbGjlsBhS6ms4K8IxJng4qHA0cCWePdu5?=
 =?us-ascii?Q?Lt2EQYwoFnOnBLmumTBNcutsIgB66aN0a3p4gOQHMLTDWbSei6zNmnlqd8o8?=
 =?us-ascii?Q?t/3Fvaqnp9ASWhOxTppCWeuB5JFV4Qkdgq14w6eXJpxcdMu3gH6jeh5aprm+?=
 =?us-ascii?Q?wtN3k8kzxSALPC8W16Upxmv0ih+rFfUDVX/Idj0voGsQ186gMD7/czDPS6cc?=
 =?us-ascii?Q?c+JIoHQp8bJF61B1nmDrH1gTslHYdJc1rSrIF1kvK0cqb8dxfCDpwkOiHYms?=
 =?us-ascii?Q?Hduj6+ijh/HdhhY1TYDOyid9jtSvvJzY5vHKX1in8DNiNK77YfGX3SBbTu6C?=
 =?us-ascii?Q?ZMqeKiQa3IdaXxqrY7J+IWGwPTcWpq4yG0p6RNJp9PChVyC0Ieu2c8orwBrK?=
 =?us-ascii?Q?TTYokbGZDniQxe1M+Fx80O92ypKId2LLSx3tGBrbvQncC8dHXMUrnXoMtWXM?=
 =?us-ascii?Q?5KLo23wgUXwXbj4e/jjf1/CFmxe8oRzrnkCowpPpsLpCvHQIGTZkCQcTpaap?=
 =?us-ascii?Q?PpIcD8vgzKAXJy2K/vxC6CRBYq7jlcR8ecCLdTbI0DZs3KdpYQ/E12/559Jy?=
 =?us-ascii?Q?NO7pwcYZaLjD69TQ1MOzXg2mP0vXS+2LV8QUqq8aSAJ3PmnDHEJlrjV8WI3Y?=
 =?us-ascii?Q?d3cN7TM5TROqpP7lZj9rPgF0yMF1Yklz/DkICv2BC3eOikclLgGcA7o8b5z2?=
 =?us-ascii?Q?vUpNK0BIEEO9nrRMwaMyAhjp2IhaZnw=3D?=
X-Exchange-RoutingPolicyChecked: q/pXDTvTEFBKycqFtW1UrL6394QX4NfMl9vag83ku74O5rJQoPzGECjHlMe+SIaogSs6UCbW6mqzFMQpBLo8WnPZEzdB7FksehmJU8m136Dadg9QbzyRt4SCtrR6xF7dUZGNuL4U+KQx1lJOR3JbhD9wRtZJzngQHV70cetOnNacWf57VB4catsTQbE2+2b49v58/vIHSE8uSLQ3pTf6nCSGEZ8tI2lzUd1BNKM4lHMFPwoYGvcXnXhujhgfXNR4IKmiq12W0RKP51qwsk1Or6T3Cz27hECbuVdskXPxDidyjqOmS3ewhB0eo13wKa+nGBYTg890YJH1SwY0Z0/SuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8458d0d7-9286-434f-84b8-08dea040a586
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:27:45.0613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YImFzEctS6uIPbGqv9h/zeVYe8iy2C7x7By083RdmNEP/e7+i2rQknFfnxsSWO96uJfVEZyT6L68TJzQgZofkmjIYaUtvxnpTbaRFdqLGP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8830
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

On Tue, Apr 21, 2026 at 11:23:55PM +0200, Robin Jarry wrote:
> The mlx5 Tx datapath compiles 42 variants of the burst function, each
> a specialization of mlx5_tx_burst_tmpl() with a different combination
> of offload flags. The compiler must instantiate and optimize the entire
> 3800+ line template for every variant, which dominates build time for
> all the code base.
> 
> When MLX5_MINIMAL_TX is defined, only 11 variants are compiled instead
> of 42. Two new "full without inline" superset variants (full_noi and
> full_noi_empw) are introduced to satisfy the selection algorithm
> constraint that the INLINE bit must match exactly between request and
> variant. The remaining 9 variants are existing ones that already cover
> all reachable combinations of the EMPW, MPW, INLINE and TXPP flags.
> 
> The selection function is unchanged. At runtime, it picks the best
> matching variant from whatever is available. With the minimal set, each
> selected variant may include a few unnecessary offload checks compared
> to the precisely-tailored original, which has negligible impact on
> performance since modern branch predictors handle static never-taken
> branches well.
> 
> Compilation times (MM:SS) measured on Intel Core Ultra 7 165U with GCC
> 16.0.1:
> 
> FILE              BUILD          BEFORE   AFTER   DELTA
> ================= ============== ======== ======= ===============
> mlx5_tx_mpw.c     debug          00:31    00:22   -00:09 (-29.0%)
> mlx5_tx_txpp.c                   00:39    00:25   -00:14 (-35.9%)
> mlx5_tx_empw.c                   01:11    00:19   -00:52 (-73.2%)
> mlx5_tx_nompw.c                  01:13    00:16   -00:57 (-78.1%)
> ----------------- -------------- -------- ------- ---------------
> mlx5_tx_mpw.c     debug+asan     03:15    02:45   -00:30 (-15.4%)
> mlx5_tx_txpp.c                  *06:28*   03:13   -03:15 (-50.3%)
> mlx5_tx_empw.c                  *12:07*   01:55   -10:12 (-84.2%)
> mlx5_tx_nompw.c                 *12:54*   01:45   -11:09 (-86.4%)
> ----------------- -------------- -------- ------- ---------------
> mlx5_tx_mpw.c     release        00:12    00:09   -00:03 (-25.0%)
> mlx5_tx_txpp.c                   00:31    00:24   -00:07 (-22.6%)
> mlx5_tx_empw.c                   00:32    00:18   -00:14 (-43.8%)
> mlx5_tx_nompw.c                  00:34    00:16   -00:18 (-52.9%)
> ----------------- -------------- -------- ------- ---------------
> mlx5_tx_mpw.c     release+asan   00:25    00:23   -00:02 (-8.0%)
> mlx5_tx_empw.c                   01:24    00:42   -00:42 (-50.0%)
> mlx5_tx_txpp.c                   01:32    00:59   -00:33 (-35.9%)
> mlx5_tx_nompw.c                  01:38    00:37   -01:01 (-62.2%)
> 
> To enable, pass -DMLX5_MINIMAL_TX via c_args:
> 
>   meson setup build -Dc_args='-DMLX5_MINIMAL_TX'
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Out of interest, do you have any numbers for the performance delta between
the release builds with and without the new flag? I'm just wondering if the
flag can be the default to speed up builds generally? [Not that it should
affect me that much, I generally use -Denable_drivers flag when configuring
my builds to only select the specific drivers I want]

/Bruce
