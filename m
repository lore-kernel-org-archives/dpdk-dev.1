Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A9C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBDA8402BC;
	Mon, 16 Jun 2025 17:38:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3EED44021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750088325; x=1781624325;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a9tXMIB81najyHO/zLKb5I3V5sEiXraBIOpQGnJvuVs=;
 b=Z0cRNeEodQAWKniIXcATm7nfEnywOlIv/2kNZxehfQ/F0MouRWf8W+nz
 9gqxJwGI8/HuNEclxChqeF2s4xvjQFXtljzrq6rrpzIzvskJwUU8My4ZK
 oHS+8guHcp2vqOp/S5bOIxpUwkDKD2XwCfm1RlNDiEO3svkVLXJGQAx2j
 1BTqw670UjGyaPIsQTht51bOxIgD17MvFZN6DIMFwoLjaP5LkFwwZJFea
 nBpV38wE4THszAiRomG2MSqO15N/LqvGtI65d7BbveCmqTM7WY1wcKexx
 tPcwQRE9CucpNaNfhMs3sMAb0DbuiCN4jguVgO7hly9/xKXtUaKon4R6K A==;
X-CSE-ConnectionGUID: tmctIyPcS4u60ChKkXNQIg==
X-CSE-MsgGUID: n0Az7sCoS6uh8bvfeUMcBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62508257"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="62508257"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 08:38:44 -0700
X-CSE-ConnectionGUID: eWzjumr/T92qEQhnh0x2YQ==
X-CSE-MsgGUID: 9yyMJE3RSRGeH8Pk+Ye4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148399643"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 08:38:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 08:38:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 08:38:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 08:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQBB+Ko5YxwlsNFAEvoccndjOTi3KJSYiGojihNGKqmKmAm0p0iki0v0XyMYoYCDCmLbiik8j6K9K4f6dkCNqsTDO46GwUbt774ipcOCl5wcaOvj8my6Qr88OTJLEilk4AfTQdg/+XzJ8ujHsUN2BqMmrtbyFyFfBoOqukBRW7X/Mrjmqv3b0smmOI5/zpOM45jr60K2GXJ1kV9Ev4zSCqN9rH2WERaD9Xnue6SnhTs5HkNFcYYnW+FMfhuEKDcih7M7hy7FEe8j7YbQfIOewhgODqAQ3BlI7OpBSIRVxj8ccMXJrulj6TWtfk5PM0lLH54KOetQUxnQNZ16eBDLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX+F169OTYYAP+PSLOptimu3WHN+NfbdU6/k+NudLis=;
 b=GFjlj4HUV/lBz5jdVEJtgnN2CudL5lvgydNwvlviUdWTgn/KkMceYw5yUnOT/gE2C8ateIs4vQXHhScibgtNuQyoxiVUpa3hGHXM7oAnHDbXR67pUbX8mdwIIeibusSq3p9dpDty+k2f0SAyJREQFkxej8ClOr10JUKAVdlI9VDL+nR9xI5yF5+u6DmYIevElA3wd/+YIYgQvG1sPyXnJAi0UJTZWLze/a0+U/EA/5ejg84GDvIHmxT0DoYdgo+l1MGe0Sb0G0bb5jhSeNFVzX8pOYKwQzusKY2ZB7bZ16G7f3Qv3jRbk2G+yio2ZR1sqrheyMFajoVVB7CtkdOFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:38:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 15:38:40 +0000
Date: Mon, 16 Jun 2025 16:38:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] buildtools: allow a different minimum meson version
 for Windows
Message-ID: <aFA6e5m-4I4vpSna@bricha3-mobl1.ger.corp.intel.com>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
 <1750087871-27179-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1750087871-27179-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0207.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e0db92-6aa6-46c0-a2db-08ddacebde4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9QpDIeUFgNFKNO7afkEN9rnN4g4ZODCsEvb/mmMO8dYRbF50Movk1wMn2VIV?=
 =?us-ascii?Q?2opd3qbGO3L/jL7AYpbrPa3pJVj9b4+Sk3e+I+4wO1yVYMqwW6bzIyTOlxBW?=
 =?us-ascii?Q?kJCWVJhksK0JhoqZp8OLcSjQzS8UnVM7xsvtvUl0177Ve6mF5HhwAZUdIczW?=
 =?us-ascii?Q?6ZEAMo2l1uP8pAptK7Y8oyr0h3gVzhB9JryoOk5MVqor68ZnCynKBylU0EsK?=
 =?us-ascii?Q?7onVJVTM9n5MGVMidp+CUtAQtXwmCzGrkD4/MnW4Yi+oMfU1Gl4WCwMn6h/3?=
 =?us-ascii?Q?EdpvUGvIyjUWjSImzfUxqqX8XHkTwarObJ+IY7jMUg0FKdJcKfH3CffZwb7r?=
 =?us-ascii?Q?E2h4GOwmRRaSiakRJ2Mx2XAfAkw+QtP0fkFXQxgxtZJg9gper2Fb5Tx0ic5/?=
 =?us-ascii?Q?H6dCxGH6DNFXMJ5eSqmMjbdjkJqJ/9ApJZiqKOabYFq7URss+RjMEDY0Lqy7?=
 =?us-ascii?Q?jz04Y0QR2BKJUqyhTwYxqX8c56+rjokTkfh6Et0Ocokkv6BAKC5Xv1dvDejl?=
 =?us-ascii?Q?aPbuWO86DJ3K4GlxeUCKMjOrMw1gJSO72u7zH3FPoUI7R9yO8z5RaQBmnfsE?=
 =?us-ascii?Q?HexMiFF02k6WpAfEN0CH4jjaBySHLXAVLDnNEJbxGRJ5/KFplIbv07fc0goN?=
 =?us-ascii?Q?DpAdbf0ODtURInbG1FME5VhXEpcQJolJX0mr1bbwT79c/eEspcnC61/uCma1?=
 =?us-ascii?Q?CohhAL+NONdugnfBCOFjeznRfNyfvs4rF3jFubZK9jym7kpHj5NFd7zMU+bN?=
 =?us-ascii?Q?cc9jugL/NaPRPhd7HxMSUIPvQswJ0chRCPH1pq2uYU132A4/ePeQuq3YV3ca?=
 =?us-ascii?Q?n9rRlblEL4hb1BsYfttQOqn9aiVkAL52BFRTbm9orKuqTecs/v0ACG71xte5?=
 =?us-ascii?Q?lbeLGhnYNElrxIVoPC6m3Vqo9PxAGnd2rndN9FFPDHsW0QnA60QRNbST8ek1?=
 =?us-ascii?Q?QeR+6/Z61pvzW+kAE8uf0+UcfAUf0JcxJC2FFy+phfJIhnDeDQiAyY3CPUtG?=
 =?us-ascii?Q?KqQ6muIah5uWPpUf/AR42pBX1pHl1PaV3kRUfInwGLRLHMh0zjEuQ1yFYit6?=
 =?us-ascii?Q?AQ72IzWVKCEPW0MaSIJTm7zLxn30P5KDgFhZMQ/+4nLmw97XzbOw/dqIxXmB?=
 =?us-ascii?Q?TCKZNNlwpdcSoKRYGyAWDgT/mdh5VrYMMyS2XdxA0KUvA8bxeJPWubVHQe2r?=
 =?us-ascii?Q?XJ/FYRqKXMdIx1a8jtKZDLny060amRgRbAp0S+jNj+8A1DiOK1YK7mHMIXHQ?=
 =?us-ascii?Q?fncqWpo0WMpTWZ+sx0MK8rOiQvdCCCVT9I44kr+cQg5peUE3Alfe2q5jCbaq?=
 =?us-ascii?Q?ZodCL5ia4i/7+ZBfhsnU1auvIhhby8WUOTEzEs3Zf+sjX0CUH4JXudPTVYeL?=
 =?us-ascii?Q?vNI7EmNgEcJcLebd+fJaVp6wpbljSrWeS4icNIxB1Bdvke+DuZCKx4jCIJg0?=
 =?us-ascii?Q?hGzeV9624tQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlFbQX/bgkppf1/9B1SmxRhfbaGYERWgNl/j3Yyl1U+trr/0xZ7AXdTnu5uN?=
 =?us-ascii?Q?j/HMDQpkps7Dm1Jeno7SH7sSCE1AV/HDgfu61u5gD8m/wILctq3K01qlqgq6?=
 =?us-ascii?Q?ZDuGWpQ8ccdB8wDi58Pf+E7tyUlTzMy5YPi6XYFACUqiKMAv7Mt0fLNWwQPE?=
 =?us-ascii?Q?Y/wyyj446ZHEWy1VzR4XCSS7jEaMe3Y3v5kb0cWjmRIRzv5aTbabQyaTU4ll?=
 =?us-ascii?Q?tX2d90017NioXfR8EJNXjK8CiJMrK5qOBTf6V3s2aPpwu92Pf40QaWA1rRmq?=
 =?us-ascii?Q?CeXVjF7kRizc0ewovljNz9wvOrrA3TGEuPSzTKmCKa9jIB1HQZCCNwiXUhE3?=
 =?us-ascii?Q?alNkYgYAf1sjF9dRJdBCmoUWb5BQSfqHqT0J+PzOL/VSVTU7vCjnmcqP1b7g?=
 =?us-ascii?Q?0OCKBU8FeriYS7LEpZWG8zTEGS845SKvDGjureyztEEYW3naH2Z9/TpAVfbB?=
 =?us-ascii?Q?N/L6GiYXWSJ2Y4b60h9e7+0gC/ouxLcQ+MZ4qNDCUXHmqEG8EUDhq/EjSpjo?=
 =?us-ascii?Q?hxgAKCKg1IFoZVXdv4tYK5Z4Nw+rV1+IsrKNg9/53gcID6SqxIaYpDWLdE7J?=
 =?us-ascii?Q?/FyG869tp0DMTjr6F94/EXzb2tCTDew0jq94fiJVuAoZTIE7yjudQY0AslT3?=
 =?us-ascii?Q?M1nO31hysRRqDZWAgNBovDhY9lLVA149bI5+XanipTwzQELim6ssVLsuq6iv?=
 =?us-ascii?Q?NdIVU1e1JGp30IxGlSgraraSO/bD4I2wPe/Op/YFWRjqW/IJOuU8IEeMSuAz?=
 =?us-ascii?Q?qdo137jpg0J0P1kSDkujKjCWkqzGaisebCk022gZutiwTE5U8oLzE6KJfXQH?=
 =?us-ascii?Q?yGMKo7SWz/fmIflygQc8W+j/5lIHCzd39d2PzXYaLTO703eg0BIcJkgHOffm?=
 =?us-ascii?Q?XAJFiDYoOFUOE3iKCDTVHOPBEjO0tEdphWGetH7eFL6GuQ8lgkNR5CqDmf6t?=
 =?us-ascii?Q?+qPx6uMsB+ZrWhgVNP6pLp4BDREJZB3k7zPJw/PuJppEPHkYFg56LacPiziL?=
 =?us-ascii?Q?Lsn7YdM1rQhXnNiYj34MjG01/C7/mNCUury3MyAh4EJM4D5K3KCP05b1GyEH?=
 =?us-ascii?Q?jyu/nD9u41gjHIdtcPC5bbOQYH3lrpSWRAfCnP632XvX89/JRRiws5dSeEOC?=
 =?us-ascii?Q?o9dHVZst+060ZMSmM4Yu1nGEsia5uGP6lzEr4f71l0YXSiQOmQjtOLtAbr0q?=
 =?us-ascii?Q?mfdwDPGr7w7y3zVCfOLERHSnOGiQgETsbgN9ayCb6n9gjdzfveaJQJlcrgMy?=
 =?us-ascii?Q?cIceWrnmB5ywfus7e49U+oxrHmfokqoEcU+FjMp/jto1yRjcQWrTeorOQPU7?=
 =?us-ascii?Q?r6ap3TJ9oN3g+WxEOBLkC8FQuNwh9pp/22QkcB8s9zLKXVcTF0mzbq/0LrBB?=
 =?us-ascii?Q?/w8YiEHuPNnit9x7xiQC8and+dZna4JfgTn0GTuMZX6PFTxWbWzyAS3mF0fK?=
 =?us-ascii?Q?edsUl8dMLGVMmDuTrFOLGWf/KeI+HYAQQaZRTsAxd6CzecpKSdbdFEyp/wGB?=
 =?us-ascii?Q?wS6UCqoCjHZKJfGmvJ803+nF0iH71Vp7wIRbvhWT06lgP9V0tigzl65gfG89?=
 =?us-ascii?Q?aIqrdAxvImdoaVcQxlKq/RyGrdvTyWybWY3Bbl5OdqWCHMJFuyh+E+xIvvLc?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e0db92-6aa6-46c0-a2db-08ddacebde4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:38:40.4887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEk5hmKswVchV9tfxO9yFoTFzwGGUY89mCcf+ZJl2dEIhW0mZ3t7bIL4a+44VzCzm140MSqg1ttdaC+9hrMtVMJ4R021/xC24NZWFIn6jic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
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

On Mon, Jun 16, 2025 at 08:31:11AM -0700, Andre Muezerie wrote:
> There is a minimum meson version specified in the DPDK meson project
> section, which has been documented. This string is parsed by
> buildtools\get-min-meson-version.py and this information is used by
> lab automation to install the corresponding meson package on the
> build machine.
> 
> Turns out that the meson version specified on the DPDK project
> (0.57.x) is buggy on Windows: it has issues related to path
> manipulation, and these issues are causing failures. Therefore,
> a newer meson is required on Windows.
> 
> To avoid bringing the minimum requirements up for all operating
> systems before a more appropriate release, this patch implements
> a mechanism allowing a different version to be specified for Windows.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  buildtools/get-min-meson-version.py | 8 ++++++--
>  meson.build                         | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
Seems a reasonable, simple workaround to me.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

