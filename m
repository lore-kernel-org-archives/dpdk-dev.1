Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBFC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A2704067A;
	Thu, 10 Sep 2026 15:20:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 32A6840274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789046447; x=1820582447;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Wxlwf8Vs7M6zk2Y7t+9SELXM+cyiKbs2Um5wdBaHIS8=;
 b=gzlqKI5dAdI3ebmC4iGJ2m28YNq5laKpsmnWwz1gmHi8wPtjkjwRun2h
 qkXEzFmE2XePgAsvGURH2mS2cJ0w7iNx/b/tTSHpDAe9hVBVpdwSFxMGA
 KWisF5bdc/MnQyLmkYtxk7WyJwM/8mH8kTpM44yGzhmZQW3OG37WpLVGl
 ZXoCkBtoux5joAoTnKzHzvmN9PNdEn6q3XBE7ZGu8et1FFYFVhn/6VrJk
 mqvwkQnDs27VgA5xnO/LqJSxXNRssr0K5zt6moJd/LZ5F1qayUCfCh9D8
 I0Wur9+cNglB/ZdZDOKTgpAgVVwPEQiA6hupUOAVhUZHw+hqhCJ8+tEEo w==;
X-CSE-ConnectionGUID: SrvGtbvYSjiPoLlLHUyC0Q==
X-CSE-MsgGUID: v1SZvZDqQHKjSgVs7ePv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89706424"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89706424"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:20:46 -0700
X-CSE-ConnectionGUID: NmkmZsUkT0WD+tYcKQEyww==
X-CSE-MsgGUID: qv+fxdZARfyen/zyGtIa1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="301536572"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 06:20:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:20:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 06:20:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 06:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFpH3eUTf9PhymTdG48+2LfMGLxDkFywvAMnF/x+ydAQfRpclX1SXoR9zw9SQiuwyo+iYHOcAAS5NeGFbMyvxm0kN9Mh/PDxlCr1DHVy9JWslKZsfBt3afcgCCIaANyO3YoTA3ixzSbmY8ypA3xPyeqQN38vt+a9hLGmnvBhOBgX2aT1zQBrRuxQAJrRU9/TbK78bLZ3Hnok8sXsf0flLocP8ErrA3T+/axFGfoZksUOzJfuLr+YWO3VRSqJm6ljkCQMtcD8SnPItQ/tc4MZLodCi1dwN/yg2zaTba3tNCo8lp3eLn95S7Os/CQOoQUdRo2Mdz0BsTMw4BgXgjszCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD91rcWQCpCvMFKi7GqSgKuirvX6eFD40SEWIucbFPY=;
 b=w/U4qh9PEOv5HOY+J4JbUkNj+uGI79x0FZ83IIFiVM5usi7iazijKETQ+Ch9qc5xgqHE1Ax+4crbUC8mcIjPLj+2XqPFeRfZqxckEOdIm5t7W6Noi8a5ppVE837Je1ZSKC17/gWv5jLjrlzSBGlfCcxcEJttQ7L6xnyCT2bkzSlkpOjrWk8X9QniqneoJD9WAX4u+VYrRZBT8/u6TaTQH8Q6yxvxGR+Mx/aH8wPq78S8e/QDoXb/NpAsfvcNFH3FNFWnPMI1q6OGpfD5w9NJJd64c4W7PGnWcRQHyEd0c8axSCDskhZukweKNhubLOAr9wYxXaShcHltpwdgwHf44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:20:43 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 13:20:42 +0000
Date: Thu, 10 Sep 2026 14:20:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/4] net/ice: fix Tx scheduler hierarchy queue
 accounting
Message-ID: <aqKupb0atjfx3OfF@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260907130750.3406004-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907130750.3406004-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR05CA0028.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW5PR11MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: c7be8e30-17b9-46eb-38c0-08df0f3e507e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OyhhNsTtGjL7tITLjayLcnYSSeM8p6nyGlT5adm12ogk00pwvksExpYzPJLvZCCbyO1JGm2ojS/jbrUfyyKvaoGP49kocLGHWseFnsJLA7oXdrZlI8S8tnU05Oa5mRT8bDknLNmmFYqCHFfmCm/ZYoTFuCAOHiYSKhx1Ezedz9kjkOeLl+gv3Z6kmtuS/UYPDG7dIpMruTzRlF94Z1F27AXHO8DRQPW5ZnRphhTEPKKu6F77HpvzH8Kpk4xfm/fqWFFD+CNIlaBrEs2tr1wx/I1wUHrOEvoIK2Pw/v27OBfvg3TOo/HvBY1dzS6FgBC+3bNf/XtHNrmi7j/J2eL9YTA2blSYJhSdN4RrsqwjwkI71b6FB6eG8X1t5j1pXad0YEUeRa/3RSqhGq0Pp7gN/cyVpGDNgvdKDmz8TBz/aKBlogy+YMi20Gsv03abk2n4Dh8Tr23LjTEiFlE+4VSrVkeetMn8Be8y96Clai+Fs7CI+suj5FCnz+ofNtwZPc7cXpBvBgZdjh1I9bE0ndBtgo9wJNV04c/+pcGRQvopsIGHAvlMPZgGGzszHgRgCnXvk0+3nZ712d+GYdWacYKUUU1cr+xt3rWS4wfJyRc6E8UoqVXJTtJDWOMsXVkhL7C/jLkgRdOt9HA6ho9+rQnDmaIJLX3FYGkT/OTowBpymxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fb3G7E3p/FYVO0cvqsDSY4T+L2m8t53/sUhlg9Efn50ZkSfNxJ3ie1O0dh41?=
 =?us-ascii?Q?FlGgfPa0xBpoFAsG0kLtgXg7fd+nZKKFr6OzC75zPbUg7SphCLGZuITcJjS2?=
 =?us-ascii?Q?+G7lMKQJtPh12JySZKBXxyyuKUZPLctV66uGWpJMnpk7jH7M0t6/2AeIZvOk?=
 =?us-ascii?Q?EktWEeGBLnT/+RqSK2spLJCWTN5uvGXqfRTJCRbRyfxA+98emvCDtEYyFWhp?=
 =?us-ascii?Q?25V6kVyO5I50Akk8bK0y8F6n4FcLzWyoGaGQCDfDJc2+86ATzE9XaExe2+ia?=
 =?us-ascii?Q?UJXttcM9ONTmu1YUSbwkRjMkw4Xt8g2TBcnsfZSUvwoachhtwsjIguLbr2v/?=
 =?us-ascii?Q?u5hbSJjak7MNaBr+yz4e47nOnC60h2C2JcuQMrb6DFzLCTnYmUHN7rK+lE7X?=
 =?us-ascii?Q?Q/4Jh/76wWugq4Vib+pRq8M57zo9pRkhH+rEx6ATEnyxMRnqbF4r0AkQSC0R?=
 =?us-ascii?Q?smAm7z7fFoD2zXwKNGADKaxIWyTDXF/YDnmcQggfbnZa6/zzPPsocdsLK14b?=
 =?us-ascii?Q?PBMKjAVwW1qBMx7cEb0YUems98R8GFP79d3T8H2tUwHrYEDS9TJBxl3htXBD?=
 =?us-ascii?Q?Xgc4ybebgbxHsPpEYdeRamJZyy4ImRoJ2I4ccFiy4F4Gsb6RvMq+sO4vvEVz?=
 =?us-ascii?Q?5B8/lfActGgy9dum3l7kVEztV8FuF4UlsGbB9y0pOhd72C7cIaAAF5KphFOC?=
 =?us-ascii?Q?cxXGz+r7qIA1M8mcAGRxch3ahFp4VBSY/Mp4IdqIvZrmR+I8jk4vsEuvUPF4?=
 =?us-ascii?Q?6AOKMT/ewsC0XqgN5HAp2Pha6qJsLVLiccuIYK0IYSoMA8YQ60G48vJffD1d?=
 =?us-ascii?Q?xyyFhBY+wYM3d58HoPp77rn3Gd57AWBkJOAIhk4JwGeZT53j6VEwgq11KBlW?=
 =?us-ascii?Q?J7/ozPtfmxp+fDIZLPECZHdb9rQECYtTSx98HeDbiaOE8g6rRSkeQwdjQZXI?=
 =?us-ascii?Q?dE2y8zvFcsycNebsyi6nISV/hTXWrWNiIQVrhL08Rrbo05RlTbuYwZWrGvJO?=
 =?us-ascii?Q?xGuTTcPfa/u/02UQhBsuEFnZH2HXH/zK3LhA8oRUZdJCSQ3oFk++ijvjdgHy?=
 =?us-ascii?Q?gE80WtrqvgJMWNwdJmz/AP+wyRbUSMbODnFDp3nsIXZnC04HbQUGBRwKqBZ2?=
 =?us-ascii?Q?3ZLnYe/xp1Hu9rAT4qN12ff2HWGeapjqhgzUOXkoo5gd/p+mCKY2111OBHw5?=
 =?us-ascii?Q?kFJnM5r89t4idgA8FtufCMeWyjXySxyL/aX+P2U/vH8gQPo4ADw33u+uwIJW?=
 =?us-ascii?Q?YyWspma37nOFve7GWKnhBGZu9quEBWnh6ZNyIdF+Fmjj1jrluDPW4nzdnTx2?=
 =?us-ascii?Q?C85JN/mHlwg4GL/eujMmGLUn7rP2kc35CFBNjNAAjY4f1156CbX+CvQyyI3x?=
 =?us-ascii?Q?a5HMVrf7Od7god3DkcpDZ+4DZa933Ezo8bFgFcVngGFV+uS88VJGiqkJZipY?=
 =?us-ascii?Q?eNo9HqVjt7fvJ7J/zsiUhWOBewpuitP5C+BJkCMTM/OO7/5G5Y0w3VHxZ/zU?=
 =?us-ascii?Q?6rXMzEzXvHb+h2rKOT4BjUXxjZpsHhTTieND4IfKM6AWp0nOiGbjW+NEJ0Qk?=
 =?us-ascii?Q?gwDkAub9H1BamcRkdJF1f97fkjV2F6uc7h/cQtAgLCfK0zURqbzbp8ncVceC?=
 =?us-ascii?Q?xJLLbjFGdg7ujznd1rD8lQxvWDPOgp0LYayIs+ix1Iaer4DKSjwMmMmcUbjb?=
 =?us-ascii?Q?gMgQPysDVBkNOOHtHZiRMeiS3vLBvEpB1NBJEUE6AD7cUG8H/UJgFxJWo8Aj?=
 =?us-ascii?Q?sHw2QemsbEfIZvELCyo6RTCHpG/bHMA=3D?=
X-Exchange-RoutingPolicyChecked: b/fD0bozfwlamAERiGNWmz1yvXosZuyZb7acLaVjS1YgrSILQDgk7IWKMvJvzY/C9UbWi+m7yHxzVt3NOZHEBkGU4BrVjLglBO0ovE88PNNH5XIercLu4Vux7mfbRM7aQQLmzJ7nIEZ8CbJ9PvHpABd4/A1t8w7+cKMvX5nb26iVDnLZOWpCiyu5pvWP5nB8CKRNX4bITqVNIS9YAPMrZEbkfSp4fciSsUA6V/rut5H03j0zri4WozXLygNHSq7Y9Nxt+NCxItfA0R+tdtCJiy+SgjZv6HaAWKta1QybNZ23ct6UaEPxh4mJDuHpgHnn3NaoE76/lUtMIarflWbD3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7be8e30-17b9-46eb-38c0-08df0f3e507e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:20:42.4520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQjzR90PbM3poTHWZD+PXYI4LUr/w69Fuigy6x7rskaldd33SwjtPTezWw6je/0rYptxwxHjHNS8DF/fOoLQ0+Swo9+BgCfRZ0xGrVmQI90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
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

On Mon, Sep 07, 2026 at 01:07:46PM +0000, Ciara Loftus wrote:
> Committing a Tx scheduler (rte_tm) hierarchy on ice can grow the port's
> usable Tx queue count beyond what was available when the port was first
> probed. This series fixes three bugs related to this, and makes a
> cosmetic change by renaming variables related to queue counting.
> 
> v2:
> * Variable renaming in patch 3 nb_tm_qps -> nb_tm_txqs
> * Added a forth patch to split VSI qps variable into separate Rx/Tx
> varaibles
> 
> Ciara Loftus (4):
>   net/ice: fix Tx queue capacity sizing after TM commit
>   net/ice: skip TC validation if hierarchy committed
>   net/ice: fix Rx queue count reporting after TM commit
>   net/ice: split VSI queue count into Rx/Tx
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
