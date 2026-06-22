Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE3640150;
	Mon, 22 Jun 2026 14:16:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 010DE40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782130586; x=1813666586;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dNYfu92qQRM27oGhQHEfAzpZUWIrWr0NL2K9YkuBRFY=;
 b=cH9U6g+8KzFNN4bLKEKOdMBF8lMfTqVOjHje/kSIzMZVeMzVFTrHPqgF
 Uf2lgeAipLOIxIHlIPTLkc+F8o6rdN/CbhD11kOeya7KAAp1iwCFxpBJI
 zJNtjrl1DnNFJJcxE3gHptEpNi09QWsego3uzgm5Et+gx7mtKwVDS5Skw
 EJVU5eDckqRPeK9qYv4sGlrVj1mND2QuVBR7FsqhS8kSpGQmgAhQmm6iT
 1Z5vhXw9x2sRpCv/TzUnxu+V85suMMWQphjMMNCdlvVEAkPyeuiQaoPHF
 ViE5NB4Qq7HUOHu9FlqV9g34LSagJ7qK5t8YioSjOCicNQtPHZeHLzsaq w==;
X-CSE-ConnectionGUID: CPOh/ytHSkKsorgdQt+/wA==
X-CSE-MsgGUID: 3BDCtl3RQw6tI9Zy3yl+qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="70373378"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="70373378"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 05:16:24 -0700
X-CSE-ConnectionGUID: sSj62QzDTLeU4L4306SLqw==
X-CSE-MsgGUID: BUrOsV/LQWGePjpukiAWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="249068592"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 05:16:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 05:16:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 05:16:23 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 05:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3wrsEWduYi8J1cN0BwOXjBsSJeB72qzROjDAwyXEn/wNltadZT79M1aM/tQmy76qTX74ymVK2bDFxxA3fpUjrAQKyp1wRwv1TIL7bsyso6JnkB5qoCrI516SIHaHc0NOR8ZpY8oqtAENIaKQYitVt7HI1AQeZxThiwPCHFBjwDRAlNjsU6raFrX2V/ysT4L+fssowm6peBt8cAFpJuzK/dV7v0rCJeg83fPdK52SgWnqKsJfLBLoaWiISWZyy1VDpahIpfkesIFKEuq6nyPVz171+x4ApHAZStS597Ee/uH+VHRjF/P6ftgM76EeVls7XTAAIde126EligeHjwxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afFoWONYvi29+BcoBqS3X/8PgRVFWQH6UWvT4eK/dwo=;
 b=GcuYfEascttULamwDs5Nuduh/IQ50obv/z0k5v3oSYnLASHuhyGjDts8Ex4br2Oor8DZVi0OwH5cFM1YPcFkc1JVp6EsAIts94erI+hzS+g+LinXGbTZFSAfEjD6pJYv2+PsS1hKkyE3oey5EQVAphA0Sj/wawLO1qYm8lMyiAbtmuFWISzx4HU59QIQdeXGPY+tKfWhSE3ccjpCAUW3/Izpi3Vj7eoSKrkicfMVydguNKvRoa0lO/HgXO553T1dz10RgMRT7Eh7ZmO7v6ex3xj2GS5fPPr+oXy3OZbiHuJ90ZZS4BUv90c3wTelSjcS+TWpBlkH/ZUFQ3CQ4hVH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 12:16:21 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 12:16:21 +0000
Date: Mon, 22 Jun 2026 13:16:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Bhagyada Modali <bhagyada.modali@amd.com>,
 Robin Jarry <rjarry@redhat.com>, <Selwin.Sebastian@amd.com>, Chengwen Feng
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Message-ID: <ajknkCqlD0N5arvf@bricha3-mobl1.ger.corp.intel.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
 <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 059985aa-f3d9-4e91-cb27-08ded05811e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fG3XegWy8b+9FYT1sTsl2M8NVH0aCmVNzL88LuyoclRdIrnP33kBglUJOzqDRiddTXSUMaSt8vjZ+ELckKITeloNmlliFuiA/k7qB5qX/z6UqA5SOSa+Gfk45b+CEkW+OzwMobSEb6DzdCdqbolV8THz0Tk6GQb68+Zx271hXMJDc7FfWK1v3jxRyObzADlaT8b/i8lAZUCyVIjneKQClrESc4ReTo+8v9TGCfgRP+TAJnqUeEfnNoKoIxTGhfuX42YUg2+5kpmuA8aRrENuvm+qOn9HRHI9ouLFm1pf1ZCo+58cwzkYsoEu3o9qRgcD8YssUwTWzH/fumaQsD7b1PIPaqRY5OKuWLkYupDl1IxwrSF8BU1v9qlU1/1+RhJYUBL0lL+X86OE0WDrA05aubFQdcdWsXIxMkKITVh+lfNTvjFYtfZbPHu0XyHjMB0c37wrd8paIqd3soZImpeVDyHwvNW3Jt+wfR9bksUVRJ3S8T27dlz/7KLsOCe4NdIwSDMvppWvCGdLAw7PzGHFwGMNUG0EEWIYYGMmP8/6sbUG8xaw+scTGkJZRFrCC6cubjx5DIn7CShtsmk0bzW3GXeVXSgLGTVVGYpWK2gia5J2Fktn55MtrjOMvJ4S+8Qm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URzSpeoIfBjTBCmyosHCBNe03VmhINgzrvdh507jmUo+tU1gEi65F+tFjrSj?=
 =?us-ascii?Q?0/TzgobFpfvQJ4bfR9bZnJMavMuwPt64ZKQRDaLdeUEd89sdv70YaTK57jee?=
 =?us-ascii?Q?UZ8ZErF3M+8MISnlEuO45VEKPpfq6467g8TwPxCTPxtSsJenfkGBaam/4NM2?=
 =?us-ascii?Q?efW0eckNwSj4znpFUXr6R5K0XoMuTgphyIXihrRoD2kn3R+Dk3dMAwoDUGZM?=
 =?us-ascii?Q?qN7L1Bdbqe18JNG3K4v8y/3QY9JqI7jlWptU/5wqO97hLvPn+Un4B135N5jg?=
 =?us-ascii?Q?1gsyokaMaMougvjdKLPSzhfbl4nUIT+zTcPwUDALrbh2wzNFNIpKWopr33g4?=
 =?us-ascii?Q?ttmzM7QdjYs83DGQ1Z/wvHZsqqPk7THy9FxF1li2SsJV0OpOITjAyjOrp6OB?=
 =?us-ascii?Q?Af7sOzjyaZ2hEnZ2ZIoK5uuwe8XNZgCKZ4dpKvzcwwahHLwA8KmKjDtlx/Dy?=
 =?us-ascii?Q?frZXy/ZjKQYsw4cClW4c93E7+TuWsUO2zdSjp/j1H0hy9QH/EG4Ba7x4vUlo?=
 =?us-ascii?Q?h/RbJ29WDJGFJBD2D8JzJaCj2d4TL8naA34XB9RyjN4uImPGN+oY1mm3SbNA?=
 =?us-ascii?Q?DdANEYjgg5DVMq9LxkwyVsjuaSA5oMSmbukZU7y8oogUjh/0dTo0jWX2cOwK?=
 =?us-ascii?Q?SZefipf26gE1IpLiRlEpHdQJXT1O7ERRTzUi7a+FKj6iBaj213q7TxPd+Q+U?=
 =?us-ascii?Q?ys3MPegmFfAfPzn7JhQmTeywAWwG0XiQyzb5l+PTnJBjeOvP/63hMIBHKt4h?=
 =?us-ascii?Q?zJlS1t71qWdArsUcMiUl6mrTDtXtsbAsls1Ka2tI/Ai1Q/IZ/0JiWgCA3BGU?=
 =?us-ascii?Q?KVh2WsZ+20U4rF33B78gK8fEy6rZw6ugpvbwaH+zIP9RiKiYoLC5w0CEghzw?=
 =?us-ascii?Q?1tIvSzHJZkcA4rEg0X/J6hP33KEMn1IEacVjMN1HEka2hHhcf6J0N919OfR/?=
 =?us-ascii?Q?Iprdy4fl94S4sJL9fN+uUbMtYYpy1NGphnXfojNogF8RT68UwNtzShQxsxPn?=
 =?us-ascii?Q?wczDzVAzipD/oAQFgTBEUredmu+oD+Ols/mN1Ro/fXP6V2DyepQLjqDOvBJQ?=
 =?us-ascii?Q?C0ItwTmsifLiwCBeTKpJBuDqNY+F7bBz0J+2Semlcs27WcscKiL+0oJxCfnM?=
 =?us-ascii?Q?/0Bfwkw6+kFjH9h4bUDZIuuB2pRY83Xb8qyYiuMRkkL+ZK4Quc1fzWG4aJ4O?=
 =?us-ascii?Q?C+T3q9R7oiQ9HITbkroJsA0q68VY3zMYTjNFFI1v5Yj3q4Ux1zE4hNMQ8Z9d?=
 =?us-ascii?Q?HysAGVlIR3Ohs1eE9emmbGFX3dkrhBFZg+lQzmI7fuPv36Ax2RijlIsoBuMz?=
 =?us-ascii?Q?DKWnPONvxzkFGASUEIK72W+CHw2U47WH0W085dstV2aC/L9jdAqydE2X5gHC?=
 =?us-ascii?Q?FW7sJdJiYuCAyJKP46L68HoJMuGSchwk588sO4VE6+oc8yirUBSb180FzbGo?=
 =?us-ascii?Q?mzBwy+FU6iZDewWDTnr/FgacoUrKITcbsm+o1dEUkgQR9ERHOV8gPp5xgOgP?=
 =?us-ascii?Q?1jjzyaKtz/bkHXxfq+cNdLdZPYXOx1MubSqs4ZwcnB+WWLn9XeXXqGitXwZl?=
 =?us-ascii?Q?zT8SBtWyXJrKAwLASag1I6f27BKV2yMMzKF9j4LmjAmFl0+2beSnARTvmTPv?=
 =?us-ascii?Q?Hxjw8A6cPTzj7GavgarYyI2fMHjWRzVuLXlqmvde1t5LRHGHfQaJGIBPgTVY?=
 =?us-ascii?Q?wOswwRgPPwphDKmn1ramLbTY9z+NqN4qRTFl7xB7+JJwMd3ynK8Fn/9/RYfE?=
 =?us-ascii?Q?Smk+/guVD6aKlgirkE36yoASJEV+/bA=3D?=
X-Exchange-RoutingPolicyChecked: AwK5HEyefID/CMzxSLO3+Eo+09egtZ2gP9LHLIR+8UoCXhmk+lgbcIVR9d0YOVqP/f6T5PBqIkNziZVNF0C0atRPRSWVabF1PipOOudnJSgDoLJHtscatBoEDjV+aQMbtWnVzb4VrkC+vYq1UnOp3mMtiF7kiUdXRMVwd4lnxK3nP2g3pEafQ92GoS1K2ases5m/amQGObzeej/pjLk7RfQqICSioKIXMXEaIqTn4UqTU5jA4s1R4eEk3vZxRIOn53/2ppBiqoavtNyQA27/AWbN9mV73Dl4gg5hsfqHbaTrv6CzpNLaWwpXnsmBTe6sErcWqsYei3Smp7KfDPQDPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 059985aa-f3d9-4e91-cb27-08ded05811e3
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:16:21.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siX8RzUwVeRcQAA7C4vWsuXYlGsVFqRufFWIYbJco9doAbSfyNLpJ/4RiDjnoOyoeVRKn4+v7nObiYMi47lgvHdvmSt1FKgoQcm6SA7l2qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
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

On Mon, Jun 22, 2026 at 02:06:55PM +0200, David Marchand wrote:
> On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
> <raghavendra.ningoji@amd.com> wrote:
> >
> > Add the skeleton of a new dmadev poll-mode driver for the AMD AE4DMA
> > hardware DMA engine, providing only PCI probe/remove and per-queue
> > hardware initialisation. An AE4DMA engine exposes 16 hardware command
> > queues, each with a 32-entry descriptor ring; the PMD maps each
> > hardware channel to its own dmadev with a single virtual channel,
> > so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
> > "<pci-bdf>-ch15".
> 
> I am not familiar with DMA drivers, I am not sure it is something acceptable.
> @Chengwen for info.
> 
This is similar with what is done by idxd driver when used as a PCI device
bound to vfio. We make the number of channels to configure a devarg, and
each channel becomes its own dmadev instance, since each channel is
independent from a user viewpoint. Only difference is that we use "q"
rather than "ch" in the naming. See [1] for what idxd does.

/Bruce

[1] https://github.com/DPDK/dpdk/blob/main/drivers/dma/idxd/idxd_pci.c#L326
