Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B1CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 07:31:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D02B41148;
	Wed, 30 Sep 2026 09:31:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 609A841109
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790753515; x=1822289515;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3wdkrJFadLScmKgm4D+4zSfJAw4Or6vUmR0yWZ4bKVM=;
 b=Ru5wE+AjY/y2bHGtTVEKaG7H4sjSBspinrXQe8q3sWZiOr7O4Y6XgDWz
 tt9U8jcFKT1ww9lDE5yrPftBbqvxTZu+dBdtxGl2XcouWtD5l7i9lnzHd
 Z1bDzGkMUrFzF4/xpEmuWkp1a5jDKrWtKZokIS/J6fwcPeVX+S0ksh87c
 TQjwpFVBlgut5sxY3f3rvhzwx/ZnaitYFO8iEiBOS9ez7ddBl30sJjwu9
 0w5SBhusBVYozj7L9kMklETHEL66BdD5aBqHDvWLV6dz2VCpYVo0HPOlm
 LNqpL6tdfYed84TlJO5yivEbmnPDVzT/Aw4iZ/5uCLG40OmnXyTQl4qS5 g==;
X-CSE-ConnectionGUID: ELlu5eTJRAmrNNvJxrhhHw==
X-CSE-MsgGUID: hTsfdCwwTZ+SPw4kjFqoKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101647186"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="101647186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 00:31:54 -0700
X-CSE-ConnectionGUID: gTRes/VfSuWdkUScVaLLqg==
X-CSE-MsgGUID: 9XQTmkrIRO+N2JP7MwFplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="303542824"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 00:31:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 00:31:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 00:31:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 00:31:53 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 00:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVLGsT8ByQqJjgEppKq3OQ8eGQRXtJtzpcEAVWncfQykSClHN3ZAltvOXlQZvraBq9N3DR6BtyEADT/tVh7bcw8xhlMGmBxYw/fwJM0zMOB6vpNCy+LEVMp77fmTsm2ZUM12lAERoaGzwWZMjpO1BvWC5iNTZ8p1dksA/Hm3dKypsJilJnv/eAd0hpgQl0wuNxvs0KJkGTLCCrxy0Z+GMzjZp98TYpsa81lDoys2J0+EafH8l9M4uH8M5pAWQ48dbTMSTtr04Z6fSYoHoDUGWlOAJYFbdi6qeScHJLI4cU9rAOPFHnQcpngx0OOvdKL2aULeO2dhUSYU8sWP1wYX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRv5J5w6xrxZrOfCKJq1y7bdYLr/EJ0xaDzUBPJrVp0=;
 b=KhA8tNuHE9DTWnh9S6ltN/Vk+dnjuGcktKwyKqrpMmH3LPXTXrYyQ25Otv7ifUisjuqpjjcBzna2ScQzkT1jBvQK1vHFkMA/sgtPBahJj9keVsRrtnTk/uBES0oFnMP7yCLEsie4BaWyw9ON2f5CKC8T6KBlicCDOkHCFfqtdoW4ntzMXqXOyW0ByJkumWTGuJZnPpwexgWUbxnpef9FBRCiYF+1e9R0wS05sLdLZi+ZHDF0LddrZQu9EyWSj5ZW88/4SXv9CXqfXqKxPPhvmW+QvgMWnW6hmLYByGNTaHMHUaMHCfcyHhhz/YAMf14eyRuaTojSYfF4OLdmC5H8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPFAB6A6CF3C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 07:31:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 07:31:37 +0000
Date: Wed, 30 Sep 2026 08:31:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: dev <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 02/16] net/i40e: use common division round up macro
Message-ID: <ary607xzhLs-QpIV@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-3-joshwash@google.com>
 <arOACkkEd71gFm5u@bricha3-mobl1.ger.corp.intel.com>
 <arOBJjd_dnv1a5E-@bricha3-mobl1.ger.corp.intel.com>
 <CALuQH+VtGnhmPoq4KpLuphM_tmXs2zu42dVDP5=M0Hiqvx2FkA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALuQH+VtGnhmPoq4KpLuphM_tmXs2zu42dVDP5=M0Hiqvx2FkA@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::30) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPFAB6A6CF3C:EE_
X-MS-Office365-Filtering-Correlation-Id: a935262d-bcdb-452a-160a-08df1ec4dc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: C79rufiQzTEoVK78VJhOgIkn1JbTT60Ff0/pAMODE4ybO7TTg7LophCdDlcmHW9QQwhatV1mwq+c5NdfaR9XeTqCjR0CxWxxFD4jp9foh25FK2VbCIaxg/1+d75V18Vw3LqaCZ53uuV33Lyc6qkJm0jfV+GiTjoSGRB1MRmNa2tdRrMR8pXnIS5XEALY5fQOV44NGQnzQZKkS4RNbri8unvzH94DTgaQYUb4/aRtxjy0R8EoM6h761nnhOAZq2dX8saUYX8me8rOY1uavItOX//tZ9D9tIo/oT1egY2bsd5znAVm6qJU8XiXQF4PEQrhuR4N+5W14P+gJoDwi7AzqRClfNA5YUucQtfypYMpfwiKOB8XonYEhaDnf/7NL27I8oUgq9U3XI3zdEiv84A8fLEcfNM+UxKomgMaYs8WBlR2rkNGvD3OafzLCG+brYBaJywpo71fvg1pMN8ffp1Yai4cQNgkdm44GQzzXkni9qaq41UhACLqEShT2p7HW+53FlM9kpFdaFApEtJfWQgQH+QAsRcJgU3svK1exAAEN5rxjkblzRBHZ1+iloDa2SqhtuWJBWUhMcCfjccOoU6QBW7+0zSYIVqUEW2DBkn9Wudi87ttgQtBhAsXawabF/DUtz2kmDRq43agjKBGDIawLhSMLR4YbTzMMP0CzbRsCJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUjCWHbAdrahX0cQo8MnldyUxakV5l6Tloar/2xl1thgGVzZhc+ZEF5A5BCc?=
 =?us-ascii?Q?MZBGKjMF8gotb8wEenIRKoBx5Xaw+zI7SdII4Mv4mYqOJhSP3eNKnCDmH2m2?=
 =?us-ascii?Q?g8X0JSf7b6lZjhcz08P0kSOVsib+dxjsYmw+wqDm9E9azGlN3JUzaLT1dVbT?=
 =?us-ascii?Q?wxAPte4dkXfup5AC+ehx33oyTeG7Pemer2KgwXOjie4gvwfwcM66CY8OwpIN?=
 =?us-ascii?Q?yhlpsC5zNojwYpc4qj/+BNnTYZbQlHB7AUuiwGNm2XJUAjNuh/LGW1UDbcjB?=
 =?us-ascii?Q?lTh6gfmPgh/QFEBPiTVbl0wB4P44F5hxYdVsdK+DJPCuyW0xdTr6KP5SQv0e?=
 =?us-ascii?Q?q20rRPBxnBUDOdhjiwtJV3VuZ3QE3V/7u1V70Jq6Ok4VGgh9Ar/8WqqUHgZj?=
 =?us-ascii?Q?61Ft7JhQz8aEx/iF3I/yc+4afAdmBS0Wj2jm/QYJ8yXvvzWk0ICRQGd1x0vN?=
 =?us-ascii?Q?ju9tMKnlgVk2GBWWhY7g5hldTNMfJDlfvsCJxebOiT3wbe4ZNBsNPP9mROyK?=
 =?us-ascii?Q?acn5eWyCtV2gcCSiu+ejdPAnLUO7gXbhw3cjhavWWbclZaOB4oXbQx6e9MTe?=
 =?us-ascii?Q?lTBO0sZmmL1MWJJ0Rc1UHmD9PT2XRsI/h5w8z0RfBejIp8V3HjCvR7rzrO25?=
 =?us-ascii?Q?ijnCg9TxsHI4slZJEc75PeuiA7NXl3CSEa4MQR6IIVWvej1OPik28wXEc2Ag?=
 =?us-ascii?Q?y2Cr249fLoc3IlBtEj+mqy6IXbUfOg419WP/4bAkUmhC5q8d2Ca5K50l3Z6P?=
 =?us-ascii?Q?D5YBL1a2+p6j2jXwriesYvw+1Yw5Ew5YxaOrYRk+9q40hM5WgyTT0Jm8B/VN?=
 =?us-ascii?Q?MrLlGl0LeZuOZ++vP/EWg75t9vFsvhxOMs52wkLj7E+M4ViZJyg2QGiD90SK?=
 =?us-ascii?Q?aHMhh963PjsSqjOzksqa/rBsctQ0hS8hDgkpFu9aLq/ktyQPtfLFMMN5oQ7s?=
 =?us-ascii?Q?3PejKovmNWokDSwvQbBUlg7xxwSlGxqyHleGFvtFBf7u5nEImpUpKueqTRPQ?=
 =?us-ascii?Q?nXskt1PCIFWdZwaO1yq4v5sk+R7L1/D3dSe4ON+0toRZBVtnTmIY7wL/c4UH?=
 =?us-ascii?Q?Ng5WUPim+mWufDa2y6aI++cqAZ57kauQny3/LPM0oA83QiGHTDN4g7yce/G4?=
 =?us-ascii?Q?rKPmGK4DQUMK7MVqfs9HT/54mEZk6zMvt7/h0fiBKgbRi7jw5Xj0k2TWTVQU?=
 =?us-ascii?Q?HvHuxEuDacTr6wcI/YA2pPRbDJ/TfTwVFJA/0Mmy1BOR4UTSzLja+NH7KQ7d?=
 =?us-ascii?Q?c/z+4bDcr9axYvAPrEqX+9Url6XfqIrIK4krzYzwjeZWrzTyMeQUUvx2ToUc?=
 =?us-ascii?Q?7vvUC1mVmsgKa4mnvw2D20vIClXJ1ZbTav1c/ayNoLLofuBsN09TaZrNg/JE?=
 =?us-ascii?Q?86+ewEvzmLYYyi9Qq/odDJDCFfQfljUSZ4lFSdHKoDfvp68pdld1tLIzv2yI?=
 =?us-ascii?Q?szz3k46qNYu9TQSgpSYS3zBY+yJlTSJCfWoZZVLa7Nz2t4N/vTg6CP3CLpzy?=
 =?us-ascii?Q?+OD+SLxPasfOQTUGIMLlpEmGVMIQ4xFKObOr4nLPOYjVqHYrQJmgRwu45wcC?=
 =?us-ascii?Q?T5ckg+iwguD7pPoxtVrWksJKruGalRbdckCpgbYlya1s+pLKZlTHEmqnIK0m?=
 =?us-ascii?Q?VDmJB6sWwofsq9VqItfkvFn4r6MgRu0n5NiRjoRucWpIfOBTYHAPKm0um6oQ?=
 =?us-ascii?Q?MNayCR16qoJh28lKI8rObNXomnoegSYzUWNgfBsIOv59i53EU6X19b6FJENJ?=
 =?us-ascii?Q?0RTyNYrw2bRJbsmGK1rt3h0hkzbhThg=3D?=
X-Exchange-RoutingPolicyChecked: ozOljrIklD9VW+S7VswoIKNJdIC4Qlup9DsFUcTIyQdfiucR7RbQLryH4letyJTkJxJaqztSlVDF/KNnWjM6Qx2xz48uYgEclBXQfOu7WfTcmPaZyPGalFx1j7KKW+58G51DGEB0w1wUQ17BhWheF6kC3v+xwu80sFIgrVQHxutizgFoLZtsxEExOMerOpw00SBj+KpHScRYNpKOwS4qbOd/W+P6P5QOcpcOwRENff7MlG8pvJv4yPLsMx5YjAIINGN+5yR0R4v5AqWwESRusIMAzM6mLaM+GxaZkZ+P8waStNNbQUfIbWHEAZFrtTEQ+BT3epkOpYiH/EyQnFNlbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a935262d-bcdb-452a-160a-08df1ec4dc55
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:31:37.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZN9uHTw0VoTa4HUKX8TYcYq+J0uoQeI591hql/Y1ABymnD15IO7tPmrDdVJXyYgo9onFEVIoQuA+ftxHfQkJNjJs3WCWZ+VkSVKKT2fMyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAB6A6CF3C
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

On Tue, Sep 29, 2026 at 03:44:02PM -0700, Joshua Washington wrote:
> 
>    On Wed, Sep 23, 2026, 00:35 Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>      On Wed, Sep 23, 2026 at 08:30:18AM +0100, Bruce Richardson wrote:
>      > On Tue, Sep 22, 2026 at 06:07:25PM -0700, Joshua Washington wrote:
>      > > The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP
>      redundant.
>      > >
>      > > Signed-off-by: Joshua Washington <[2]joshwash@google.com>
>      > > Reviewed-by: Stephen Hemminger <[3]stephen@networkplumber.org>
>      > Acked-by: Bruce Richardson <[4]bruce.richardson@intel.com>
>      > > ---
>      > >  drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
>      > >  1 file changed, 1 insertion(+), 2 deletions(-)
>      > >
>      FYI: Just a note for i40e and the other intel drivers: the osdep.h
>      files
>      have moved in the repo in next-net-intel tree, so this patch will
>      conflict
>      once those changes are merged to main. Therefore, I'd suggest not
>      merging
>      this till after the pull, and then adjusting the paths in the patch
>      on
>      apply for simplicity of merge.
>      Thanks,
>      /Bruce
>      > > diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h
>      b/drivers/net/intel/i40e/base/i40e_osdep.h
>      > > index 9c5a94f055..93620f5c50 100644
>      > > --- a/drivers/net/intel/i40e/base/i40e_osdep.h
>      > > +++ b/drivers/net/intel/i40e/base/i40e_osdep.h
>      > > @@ -227,12 +227,11 @@ struct i40e_spinlock {
>      > >  #define i40e_memset(a, b, c, d) memset((a), (b), (c))
>      > >  #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
>      > >
>      > > -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>      > >  #define DELAY(x) rte_delay_us_sleep(x)
>      > >  #define i40e_usec_delay(x) DELAY(x)
>      > >  #define i40e_msec_delay(x) DELAY(1000 * (x))
>      > >  #define udelay(x) DELAY(x)
>      > >  #define msleep(x) DELAY(1000*(x))
>      > > -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
>      > > +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min,
>      1000))
>      > >
>      > >  #endif /* _I40E_OSDEP_H_ */
>      > > --
>      > > 2.55.0.1082.g2b9226bbc0-goog
>      > >
> 
>    Ah, I missed this. Thanks for the update. I will hold off on a v3 if it
>    is necessary until the main branch is updated.
> 
The next-net-intel tree has been pulled, so the move of the osdep files is
completed now. Maybe respin this patch so it applies cleanly again?
