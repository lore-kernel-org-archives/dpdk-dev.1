Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97259606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iafxi72O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE60F406BB;
	Wed, 21 Oct 2026 12:54:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF4540041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792580045; x=1824116045;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lSKAuU8+kGy3fMHmuuM/Nlf17C4O03kvxm/OrlAGwy0=;
 b=iafxi72ODYrVdH4hjToibD7j5v1zUuHA/56K5jhh/CKRkOMBW3vvqopY
 7ozVsa7jB7qGauzDFCWxSOsZlynud9xylzxmtsR5w8ZYL6zH/OmnHz6SF
 mo3LUltmRbCO39Q6w5Ks5jwPpo1fa0y8jxArDXD17QHfbvwUkZGhTu+wm
 8AysluaQ1ThQ5hmEVTpjNq9WA6YYv7aUuh9sQU5pLudRTtGeaW/SLVSNZ
 ghSD4hRTsU/vah+3aflDbaZzg9TltPx6YCUyvG7fiGegQjg5j5Se4jlYZ
 CrUo/P8h11AmIKZ6RlYPrBkrWti4plDkswkOt6jS4AafqtjR6GdUP/5+f Q==;
X-CSE-ConnectionGUID: H8AKC25gS7OHBlmlvYqQHg==
X-CSE-MsgGUID: y8AB+LktSke/ftTU0+wqfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1317652"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1317652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:54:04 -0700
X-CSE-ConnectionGUID: +dEnWSj5S7mZZOpM6UPPUw==
X-CSE-MsgGUID: RhKRW7dTRe2yO77ys/Sm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3389493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:54:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:54:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:54:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAZK8aDmUGgcl85ArKMvw3AeTUQubOO4ECpcdJO3A3J750f54S8ao65xYkhSolGooiOxQwf+jliUFNhlZKhkEVdQu2U/eSTLE5Yyp7WTtiAcMT/Z3f9hqfVG5Z5Ii9V7oD+rAbsvqCQYY6WBSTEe3rhxvE08VhAx49kmvmwPX4FtTmMyEcZ/TrPMTad9d2gqYVcJSc3LZ3yIDO/t/JP1jSxH89L02ztUywPFykIhEklnZhKPb4IN7hyeJ4L+rRW2ycVox5S4ULwRlQhr/Uwe0EowLQ1m+bKZkFYpKR9bQRr99ZWPDbU6OvJkXTwnuzQDU+QS0e4OLzphTu7bR48azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g2VQDS533gAa4SJVHgChzk3yo4sORHNrEEZ/ONDlrI=;
 b=crcSoMak6oe1NZ4FOs9qW7K1QfmHBCxG9E6Jzo5e/vJi63nYSglyRs+OeX6X++9RuMKPnyarA98BB1FkI+3PgexzizmZYXZz+8yEQGFm9gaw+gfNmq1rAAHLlLOv0Wg3K0ZAwxzQA7TwaJqyXIS9AeX9oAA7WAuvxeLAVlLmYXV1E3VSSBPc4QIigHDMe+c8TufBPGgy+bbH/0qSoylmyTW/dzqb6kif2sBYfqDAu+uWgvcQOL77doWDDErC+JNB9KI8LGpn0bOHVt+QLuIZHJG9dTlxVx5KswICdwTwsE8gioU0X/eBXELDQdXBve+PnCm8KyWWBLsCwahwEujUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB283782.namprd11.prod.outlook.com (2603:10b6:8:502::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:53:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:53:58 +0000
Date: Wed, 21 Oct 2026 11:53:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, Gaetan Rivet <grive@u256.net>,
 Rosen Xu <rosen.xu@altera.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Jiawen Wu <jiawenwu@trustnetic.com>, "Zaiyu
 Wang" <zaiyuwang@trustnetic.com>, Jeff Shaw <jeffrey.b.shaw@intel.com>, "Jing
 Chen" <jing.d.chen@intel.com>, Shreyansh Jain <shreyansh.jain@nxp.com>, "Dan
 Wei" <dan.wei@intel.com>, Andy Pei <andy.pei@intel.com>
Subject: Re: [PATCH v2 05/12] drivers/net: fix reported VMDq capability
Message-ID: <atiZv8jUN3iOBpFi@bricha3-mobl1.ger.corp.intel.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021103027.2050351-6-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0294.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB283782:EE_
X-MS-Office365-Filtering-Correlation-Id: 83219d05-94d8-48e0-040f-08df2f619b7a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DvvYfk2c9yvMWWNwznRrsdSdF5G1JRcEnDQGM94YHvaP20qOcKTKkpsaR0I1q3veGlmDNNGcsQVnBVxN8QFmw4H/t0AbhgP/IG/c49ecNLG1WKYYs4Wzb8+L9PRSokN2VPFplXY1m8MTk9CU/tiVFUJtKK/V7BhHvywHshflff8sgz0+LoSVCmxl5+L50N2C+5YfLnSWr2yEPvedzYCGFJDaMaYQgPJZhlOjzqVcyvvAiq5OSnNnvo+80cpWgLtjpmk1QOMae8INOOaC7IF3amNM4UJ0iA73g3vDiYz5MvemD1oZ5IKWR6GO9cznOrGuy1HGZIjlCUxD+Mu1lab45Mmkr8AvoliBTTisEy6rtiuMKy2xwp7OT1T4rLg0Q2yKb1cIyTLpLKra/nozVDFcsyVQLeFhT28IF01NczgX9PE3gwp5SKwsLAzNHcc6zjax2OSGW8zinsJOuSYdaktGEAGd8bOCRmMywA4MfPr1pMBVCrKq9hFMyr4/0YN6dWyZZUSvJ6kkb9aoCM5IsN5zLUDq2QWeMUXSUpytElJtKy8eRE6Zrq91hFh42eNugIoK7/J7MlijCrlFWj8xas+JXavf2t+P3O9vfTmLaxgXW4LlW8bOAvvqb54hTPcPnT3V6S0ca8MH/cDcOAYvBIf48tNAAt4RNpYn154iXs7a5nE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrL12cTxCCKnMWYgF4ZOCYW+8DImcyJqcyYVt5PPRLcP8Qbbi5/X1TVL+rwQ?=
 =?us-ascii?Q?B+z/exgRGcQUqrAEDp7C4geQ69Xwp1Xr6OLRHMZXIM5pvcQgoZEpnaolFS7A?=
 =?us-ascii?Q?VMdeNiSHIBsmk9xHsiTcgMFso+QuXGH29SpzdO0honIhGLWckRbaL+HksauJ?=
 =?us-ascii?Q?aFkMLejHZX55xvnWI8uLyjkxyzC2eHLp23It7S65P+rxL9GpT6zQZgimMVzS?=
 =?us-ascii?Q?IBflHFWcHbOYcJcike4PvtTsI5olKnDV/klDC3aOuLEgxhUMfgydCIHRxzH7?=
 =?us-ascii?Q?NeQ/Ph+H0etqjWwBjNB+6TrEYmEEbfHOto+5qcJr056a3lXK/WLI23hWuKlD?=
 =?us-ascii?Q?PDL3+wz655Tjw+sBbl589v51rS//v/5BdbuSYi7fOnFV8zTxue55qETI4Ln9?=
 =?us-ascii?Q?qhn9z5tveYV/neYSQKRNNUxhmdNXZ9uNL6w6Rdb5UkXrvEMuVOnazROWtuLP?=
 =?us-ascii?Q?khL1MY/bDIRQYXuzGF+zv5H6M40T34IvwTMTnnjDm2nM18I5Cfw3Bc4lCwL7?=
 =?us-ascii?Q?NtGrPee+1NLqhydCAslTjbu1IoF9YCCkXg1s1Fu6D/VYw+WStS3bjteSYwiR?=
 =?us-ascii?Q?HbqxSlelciUjl8vp2/isXJGguRdj4IedL2mjNMHfLfdrtXbUM9Zwwnes4XiL?=
 =?us-ascii?Q?YBQ234Fus2HhWDlGnDhmSLAtndZUoT0wZoEk3oVofXPwowC7udYyqsfhiELW?=
 =?us-ascii?Q?VjXPWDMJkBhSO0XSEK6CmBEJ5+pY41lFpMLnR/llTOWxswbXtJnp8PHLZMPm?=
 =?us-ascii?Q?LleFykq3Es32FC4yFrzACqujZNLSRcKaF0PkHGI4yOtnu+XHSazwxtXpYFvL?=
 =?us-ascii?Q?O7yAWLuJDOubfhYNrqY5JCyK2RY08f9z+G6LycdQ/nPVN/u5oN3OI9SZRss8?=
 =?us-ascii?Q?clYdxdIlB6PxMrei6M6xPtkJ9hPD2xrzU5tmsLgRCWrc2KeXyQVoNKXTCcjp?=
 =?us-ascii?Q?hjj06kf8llRqkRGGYWRMs+8ZQ+z7jzGw8noVUpAktbSyZ/2Q4GGQH6HyPSPh?=
 =?us-ascii?Q?p/SAPgyFOsjdsKboxA0siuf40dkPGdrAXPe4zn6zQXWfYtcDdFtR2MAqez2T?=
 =?us-ascii?Q?Xy9iXpWAPV/UDh+ATx+rae2WJ9lEx84S2jH2aH9u/JSlm2/Yir+n3jB7zDsR?=
 =?us-ascii?Q?l3v5fvECnEkDVeW5m4oV7mEYNAB4Oy0hn0kMSBuiEs1ZjvrZ7aWkoiUkmYGc?=
 =?us-ascii?Q?1RGlJ78/gNTO7iLDA/LmKPj2ZErM/4ju18c9qq7Ie/IU/eXiQke6ll6EM355?=
 =?us-ascii?Q?WAsVHQPt0SAnXCrktD3+1vLD2lHZ8KC+5a7RHgdF4bpCpbTkFaiIeIV+JMx4?=
 =?us-ascii?Q?6JI07ch+zLwyTDiaFxwMVEHPmcMQTF79Q6hEgX0S74sNXgKkX92w4vOFzY9d?=
 =?us-ascii?Q?Tg24Vr08faQfbzSZgERCqB2IrVh+x8LMpuulojtiktfc47L76i+oOwdZdTeX?=
 =?us-ascii?Q?xtcqhUrv8A5ltWz9STr6jTSZuVkTbcX6W4c2RBgtWMudlGmAJFFuB+jRXTI8?=
 =?us-ascii?Q?5ts2qAJ+sqRaQEsnDqEnr5rlmkSL0Fb0ADxhC8M5y8BGSon4h7k4fstiIY0M?=
 =?us-ascii?Q?iH1J12Vpcf906fAQr7MTOd16491XP0fjuooKh5pqMxpLAJ8czPemeAoBvkej?=
 =?us-ascii?Q?ZQCEx0Eu/DICqq58lbWiY5CRnUvOglB8SttgYK37KZ9GL84oekl4Yqmnx9UG?=
 =?us-ascii?Q?QjyrmM5qQ68NdgwqTJijEduJg3Mo4ppnrRgCbQdREe7Hrbevdi7pf1sv1Iq/?=
 =?us-ascii?Q?+Uj+z5dxjvk3XWAYDsCxDek1+qqmKoA=3D?=
X-Exchange-RoutingPolicyChecked: tEjN9vw2ARQN1dD5VeFwNWthnQcRxKPjF13BkuUQkqvmb1NKZm3v2qrVvQtsb0acXfj2Yo15nih/DUEKx3bKC9JfNZbwQmtKYGfhl80V6H3KQ0+UA4ElQ+SODYdLcs+Olb93zr1okgPD590zUfJypWxX5xPvylq93jfRTTE+w6a3PJ+f3hBxK4BGUKyeCSepdTSiqRVztZ9hJTMOAKJhybeVWVNCXb3zvstYiQ7DtX/ZZAB/3m8IX8UdApJL9/SC6+EJsC9a1obIRJMEEsbeX18YSpOBPWhgAaMu7VYRABOcSqAJvbF5o1jihE9VW9s5eSZln8wQdpGMze5hrsH2ZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83219d05-94d8-48e0-040f-08df2f619b7a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:53:57.9246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTjCm8cYIerVHAHJZONpbUEcDojhitOeP33SUr/6x0/pi9wYsqEIMD/O+lFqXaM7Q+HiWFdfKv6YrGLM9XBb6xS2uDz2QFVLnnDu8esbF20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB283782
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

On Wed, Oct 21, 2026 at 12:30:19PM +0200, David Marchand wrote:
> Some PF drivers (dpaa, dpaa2) and VF drivers (ixgbe, ngbe, txgbe)
> are announcing some VMDq capability though this support is not documented,
> and no action is taken if the feature is requested.
> 
> fm10k announces capability for VF device, but rejects it at configure
> time.
> 
> failsafe may support VMDq, as it only passes the requests to the ports
> attached to it, hence mark it as partial support.
> 
> Fixes: fe3a45fd4104 ("ixgbe: add VMDq support")
> Fixes: 7e72cbfa320b ("fm10k: add reta query/update")
> Fixes: 799db4568c76 ("net/dpaa: support device info and speed capability")
> Fixes: 762b275f20f8 ("net/dpaa2: add missing device info fields")
> Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
> Fixes: 5dec0169554b ("net/txgbe: support VF get information")
> Fixes: 66070ca419c1 ("net/ngbe: add hardware configuration for VF device")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - moved net/atlantic and net/cxgbe changes where needed (later in this
>   series),
> - added comment on failsafe in commitlog,
> - fixed ipn3ke,
> 
> ---

For the intel driver changes:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  doc/guides/nics/features/failsafe.ini  | 1 +
>  doc/guides/nics/features/ipn3ke.ini    | 1 -
>  drivers/net/dpaa/dpaa_ethdev.c         | 1 -
>  drivers/net/dpaa2/dpaa2_ethdev.c       | 1 -
>  drivers/net/intel/fm10k/fm10k_ethdev.c | 9 ++-------
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 4 ----
>  drivers/net/ngbe/ngbe_ethdev_vf.c      | 1 -
>  drivers/net/txgbe/txgbe_ethdev_vf.c    | 1 -
>  8 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/guides/nics/features/failsafe.ini b/doc/guides/nics/features/failsafe.ini
> index c7c696fbbd..09afdc1963 100644
> --- a/doc/guides/nics/features/failsafe.ini
> +++ b/doc/guides/nics/features/failsafe.ini
> @@ -13,6 +13,7 @@ MTU update           = Y
>  Promiscuous mode     = Y
>  Allmulticast mode    = Y
>  Unicast MAC filter   = Y
> +VMDq                 = P
>  Multicast MAC filter = Y
>  VLAN filter          = Y
>  Flow control         = Y
> diff --git a/doc/guides/nics/features/ipn3ke.ini b/doc/guides/nics/features/ipn3ke.ini
> index 29f40a5b11..ba43b9d91c 100644
> --- a/doc/guides/nics/features/ipn3ke.ini
> +++ b/doc/guides/nics/features/ipn3ke.ini
> @@ -18,7 +18,6 @@ Multicast MAC filter = Y
>  RSS hash             = Y
>  RSS key update       = Y
>  RSS reta update      = Y
> -VMDq                 = Y
>  SR-IOV               = Y
>  DCB                  = Y
>  VLAN filter          = Y
> diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
> index 1aaf97f175..7d45386a9d 100644
> --- a/drivers/net/dpaa/dpaa_ethdev.c
> +++ b/drivers/net/dpaa/dpaa_ethdev.c
> @@ -662,7 +662,6 @@ static int dpaa_eth_dev_info(struct rte_eth_dev *dev,
>  	dev_info->max_mac_addrs = DPAA_MAX_MAC_FILTER;
>  	dev_info->max_hash_mac_addrs = 0;
>  	dev_info->max_vfs = 0;
> -	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
>  	dev_info->flow_type_rss_offloads = DPAA_RSS_OFFLOAD_ALL;
>  
>  	if (fif->mac_type == fman_mac_1g) {
> diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
> index 8ae4fd89c5..07e89d5c39 100644
> --- a/drivers/net/dpaa2/dpaa2_ethdev.c
> +++ b/drivers/net/dpaa2/dpaa2_ethdev.c
> @@ -452,7 +452,6 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
>  
>  	dev_info->max_hash_mac_addrs = 0;
>  	dev_info->max_vfs = 0;
> -	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
>  	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL;
>  	/* DPAA2 has no software-visible indirection table: incoming packets are
>  	 * dispatched to FQs via 'queue_id = hash % dist_size'. We expose the
> diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
> index 3b2daba79e..9b123c0b2c 100644
> --- a/drivers/net/intel/fm10k/fm10k_ethdev.c
> +++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
> @@ -411,7 +411,6 @@ static int
>  fm10k_check_mq_mode(struct rte_eth_dev *dev)
>  {
>  	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
> -	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct rte_eth_vmdq_rx_conf *vmdq_conf;
>  	uint16_t nb_rx_q = dev->data->nb_rx_queues;
>  
> @@ -425,11 +424,6 @@ fm10k_check_mq_mode(struct rte_eth_dev *dev)
>  	if (!(rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG))
>  		return 0;
>  
> -	if (hw->mac.type == fm10k_mac_vf) {
> -		PMD_INIT_LOG(ERR, "VMDQ mode is not supported in VF.");
> -		return -EINVAL;
> -	}
> -
>  	/* Check VMDQ queue pool number */
>  	if (vmdq_conf->nb_queue_pools >
>  			sizeof(vmdq_conf->pool_map[0].pools) * CHAR_BIT ||
> @@ -1386,7 +1380,8 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,
>  	dev_info->max_vfs            = pdev->max_vfs;
>  	dev_info->vmdq_pool_base     = 0;
>  	dev_info->vmdq_queue_base    = 0;
> -	dev_info->max_vmdq_pools     = RTE_ETH_32_POOLS;
> +	if (hw->mac.type != fm10k_mac_vf)
> +		dev_info->max_vmdq_pools = RTE_ETH_32_POOLS;
>  	dev_info->vmdq_queue_num     = FM10K_MAX_QUEUES_PF;
>  	dev_info->rx_queue_offload_capa = fm10k_get_rx_queue_offloads_capa(dev);
>  	dev_info->rx_offload_capa = fm10k_get_rx_port_offloads_capa(dev) |
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 44eb932058..50e44484b1 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -4076,10 +4076,6 @@ ixgbevf_dev_info_get(struct rte_eth_dev *dev,
>  	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
>  	dev_info->max_hash_mac_addrs = IXGBE_VMDQ_NUM_UC_MAC;
>  	dev_info->max_vfs = pci_dev->max_vfs;
> -	if (hw->mac.type == ixgbe_mac_82598EB)
> -		dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
> -	else
> -		dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
>  	dev_info->rx_queue_offload_capa = ixgbe_get_rx_queue_offloads(dev);
>  	dev_info->rx_offload_capa = (ixgbe_get_rx_port_offloads(dev) |
>  				     dev_info->rx_queue_offload_capa);
> diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
> index c440e02369..55cbffaf2c 100644
> --- a/drivers/net/ngbe/ngbe_ethdev_vf.c
> +++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
> @@ -475,7 +475,6 @@ ngbevf_dev_info_get(struct rte_eth_dev *dev,
>  	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
>  	dev_info->max_hash_mac_addrs = NGBE_VMDQ_NUM_UC_MAC;
>  	dev_info->max_vfs = pci_dev->max_vfs;
> -	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
>  	dev_info->rx_queue_offload_capa = ngbe_get_rx_queue_offloads(dev);
>  	dev_info->rx_offload_capa = (ngbe_get_rx_port_offloads(dev) |
>  				     dev_info->rx_queue_offload_capa);
> diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
> index 341f62bc75..3cf33a8bd6 100644
> --- a/drivers/net/txgbe/txgbe_ethdev_vf.c
> +++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
> @@ -575,7 +575,6 @@ txgbevf_dev_info_get(struct rte_eth_dev *dev,
>  	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
>  	dev_info->max_hash_mac_addrs = TXGBE_VMDQ_NUM_UC_MAC;
>  	dev_info->max_vfs = pci_dev->max_vfs;
> -	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
>  	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
>  	dev_info->rx_queue_offload_capa = txgbe_get_rx_queue_offloads(dev);
>  	dev_info->rx_offload_capa = (txgbe_get_rx_port_offloads(dev) |
> -- 
> 2.54.0
> 
