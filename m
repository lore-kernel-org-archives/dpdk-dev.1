Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F0C5DF70
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 10:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1317140269;
	Mon, 17 Aug 2026 12:46:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 358C74021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 12:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786963582; x=1818499582;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Hum8X8xU85mz3JcS9YbtkJEgO6/GaDmDKxzfP9x7LAE=;
 b=SbZR+9vSdGJnv3ysP9gP61uD4sBghkXq+2+CWFz8SG8bokuRgRc//Cc8
 W0Ija4OBb0+z6V8Vp/+Dk+yLeIba85fN3PA+fO3nXOnR2Q1qlXl7LLvlM
 WPGkDhtH5FM/YK23Dtn6lX9e43IpstXoUpXgVh7zR8jreg4eNAePClFY3
 Et6900CoKOGZmWFUWbV3vNIIo0Y0jxJpVgUB98/Z4ISON+DBkIVAuDce0
 4IuQj1A2t91fFVvovDezug7tmcANesuBfH6IFtL4FcZNOtvU+8MwhhoGx
 VSOSlHVQtiW9MRnVbBbgwik2DaYGLiLbNJ6wZ9dZpkXLN5PkKXik4qzyO Q==;
X-CSE-ConnectionGUID: OmjEQVI4T8ajNNcwtS/X6w==
X-CSE-MsgGUID: bjJIEMDvQLCMAoHz3DjjSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98589160"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98589160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 03:46:20 -0700
X-CSE-ConnectionGUID: g7Li6CNbTaeDMh3BUjjT4w==
X-CSE-MsgGUID: NF4DDdadQvCEQrrKmbHocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263539257"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 03:46:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 03:46:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 03:46:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 03:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvADdFrtU/8gKwR/axGzUBmpniM+7z5bLUeCNSRk2Gm4T1ZEKoOg76EIstGGXo6SqGiPG0fa9Cozw1/MXDaNTT7hSgETtq0TLBj8L4nltP+e0+D55jcM6n+cdolX8uWs24QHE3XGbZmG6sagkIQntEE9XEc7xrZ+wIWiJZw6YfHWq/zdjKYKWdSHYkDJrYMn1gxZRqOyFKtQcHrWznOlJlvif04Bf7RCP4/6zk07DDQlgSTfRR7WjIo9CgZwYGwk5gJy90mq9Mzrt961yUo22rlT0YmQYqap9Fsra2qviNyEiJfBvDclXrYR/qBArkrlBeR6ItM9IJQtyLyPUFGcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3uy0kpHAQbU+3C9NXb4LCYufXwaQKGWh5GTAy8ykc0=;
 b=JC1EKHNbj/DRQ9XmtmeTH1S8DG89+NJ+JGCNOP8N2QffEmkF2aNPe3PLgv3fJ7iAXmsvu8e5KiS2P3k1jv6eV1/hKnKD2a74GO5ATAtlNgZ+pXNkRIi6ScOPnNGpMybryowKOzRHKvFHwa6YXdmT9pk4jkvuHmZP2Qec9JoxEkhfXTEvmiox1u+ghoDnSPTNPlhG6XDY/5c8h/hRBmO9SdLzmlsrH6ry3v1zDIMkOSpomGYVy7Fx2vBcfmFJADR99/S1cx1E3Hr53wezlSsC/zJSR27VvHTrvN85kavqYTZwMNlhXqkf3bFpXmNAH5aDHzTqHF1Me/y1RkxrCQOeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:46:17 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:46:16 +0000
Date: Mon, 17 Aug 2026 11:46:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <ciara.loftus@intel.com>
Subject: Re: [PATCH v3 3/7] net/iavf: drain in-flight Tx before reset
Message-ID: <aoLmdIZKxCpA4V84@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
 <dad85e16c65b7966dcf767eee5000d8d5d127d06.1786948817.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dad85e16c65b7966dcf767eee5000d8d5d127d06.1786948817.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 617bc052-5413-4910-e859-08defc4cc3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: DZ8LyNwVyR4wLB3/EpSewTUk5nOVu+nVlEV2A5fC01/glPY8P6+O3owYC5OM6vs9Bj39k8C/EvQ0LDiDY1Ogvj9qKDhhaN4Fz2nr2CEPEOKhF2CURVK3sRNAFRgZD9n+iqt0qANELcysVNlUKm2G04VyLcrBPJmDap+DdP7FbW1CxSd+Kw4+bAScqYr4Kt8O3JZ3IHw5z1yDyqGSK/pwBuG0Q8/WdQXoawah3WIVFMfaXPgRYTX9FuPV4AwDCvpICEsc4FHWSCnyeGYlpTcjdNk8Fhm/2voJX/vUu9lFbtLoH9jBzm6IGnfhknflGXyYErZ7KG5a8DrKVLQ6b9byIODHFxZ+J3zFjgrlMDM+DcE993JD3TiKN77vJ+6tTgmzpYaDuvDfJsgvEK8onEG6HoX7FU45h3j3vk1m7oxSSowWf/DLi/C+P2e2C+76TJekjRHZGZRtjn74NeBa+59YBS6uY+/xdrq0lW2pZUmkepSFdWx263xdn/MEmCktwnYXOzvWbQ/DGafSlGosd2EU1ypL6Jc8s9W7OMOLhs2EwMEG8E+qSEs/eOMe7svfiZfopvXtS+QsmQbgEjG99Wd/kTbq/mu5vLzgfVhGyz+KJcJEiC6JPvviTzFhHWdK7OXtCGy/CIEUHrxh9Xlb6hMqQs+6Hs/Kse4X9pvfyvXGwzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ohtn1DqVXUWGoCSpelE8eCSUy1SJ4dVpV6fV8xqZcdU/ceGya87BwQLZLVT?=
 =?us-ascii?Q?uZkrNlzB+Q+FKHZaJiBwHw855U7cX95dGZxdrvfXJ+5LPwbc5/aEbsJib4IW?=
 =?us-ascii?Q?x58/9nNkQgpnd33rneUEAyiCGCrP7y89Z1op4C0SnH9fppEprdzkA+flRNEP?=
 =?us-ascii?Q?LbIfdjF7SGmThXNAPhAuRiD8w1+1KTc4o9IRnTPTzM0j1TwO1cNheR4+VDhO?=
 =?us-ascii?Q?A+Zx4frov2sh5ANF6uamIS7M3qvn6fDZIC2ooteUA+eHv1bagsi3m6FulLH7?=
 =?us-ascii?Q?Yh4o3ovXZebdRt/vuNj7X+GvUp0OlgzqdDikdQ2SYWzMDEPb8xwib77FzNzX?=
 =?us-ascii?Q?1M4VgnbO8H6+IiT7bam5wdhA2/FOHDzMCWwYnsdctDC1xKkPLuYINYiC2GmK?=
 =?us-ascii?Q?xJIuEE+PnOh56NQKZ9yRo6vfbhcnIFiL/eb1t7IsNhDwE4YdQYqWzAEsHyu4?=
 =?us-ascii?Q?Bf2bY9sIalnR0ZMsMbBttzZCFF3pJ0SJlybtuRBE4vZNEfkrRbvf62YpWNgM?=
 =?us-ascii?Q?glVHJ3u+NXxnSxt8Xqn53ZBGtOCKaOEMZSIVk7lLaP7B27aShPshy0MUnnPT?=
 =?us-ascii?Q?VCRb1CaDSCf9oQTCoIsiol+A3rera5YbuEju/UEgZDxqUhUBV4GUW1dc/nk1?=
 =?us-ascii?Q?KuGgMLkr4VXLnbhbrq8g7w+Pal8ZgUJQbexpLEQqBocAvykYrvSp5aee6HG8?=
 =?us-ascii?Q?xMzOnLSlMIhwte64rphfXcWbFYN6aPwWSPz1TfZAYlOUlN2A9tMe//cJGL5P?=
 =?us-ascii?Q?3DAcxt1qsg4sKEvWnuzrpxHYmC54BNplJDPScz+X6dX5sq7sV6Dt/sl3Fm+1?=
 =?us-ascii?Q?3lDihWeBh4AgcjjLYkIsf6txEVEAbtcP3ScKsVkFlbWgbM+uPokwhkcjLSW4?=
 =?us-ascii?Q?pjEH562hXpySghZhtIbgpXZJS8xThI9pHTtO/sp0+Xi8kfRZRPZLH2hEO7g7?=
 =?us-ascii?Q?jSYoWH58v24mtd1/ArOA66KXTXQfivEiJGvB4cPkPMoBCO/uF9Bndd+6+N8J?=
 =?us-ascii?Q?bgcFZszb6eNzrANwaNCbMk/dFp2J2eqXLGXHsfECah3QyGfimxNwdw7TElnV?=
 =?us-ascii?Q?jnxOvjnCApY7uOrSy+BHNSceKAXJUHKZw/UZsH4//9hSMzBurgtASwc0UN3W?=
 =?us-ascii?Q?G7ANGFKlJaBvSLMwSOTpv4gqM8U35dopcOVBxTL9fvtag0/ohWrZA5lfVau5?=
 =?us-ascii?Q?fTgtgHKFe8crdXda/uH8qlG5PKbl8e2pUiaIASzcAyLzlSj67prZUFonaTeG?=
 =?us-ascii?Q?ZixqZr9ccYAni7riADkXNli/8zM9wSq8/e72PjZgkFINd4f83O7PznaraogM?=
 =?us-ascii?Q?jdgUV82JkSfVWNE9cw5KfQIaNCvtwy3J/0nELDKSQ/Quw46qA6T2nYi9EvU4?=
 =?us-ascii?Q?+hv1WGM9/h0ksK1x48azVBYv4MTsrNIxlqTf1UOHp1yt5q8xnJcDK/+DF93l?=
 =?us-ascii?Q?83Y/lJ3dY/zcvxJTVkNF4a7t6swqaLEa6h7uqKpoz2zjfQVAGSrNvaXRTcBL?=
 =?us-ascii?Q?EsoTXSK8TvCu/0JXoLfNRh/BWjAs+PalRAgSCTFwUH9kB5vgoTEzX/9aCl4n?=
 =?us-ascii?Q?qcxoDYpuaOPX1EPFu/iyO+yxlFiLgPpmaFuexX63hJ4TzZP1zlBLSsu4ieao?=
 =?us-ascii?Q?77rT8ADv3z7Q3ZGrvlOXGWaMWTAM/tiaiIFMmyc/7rDYoBQ4lXCWgDZHIewC?=
 =?us-ascii?Q?GY1IdaDjOTzI5Skn6Bi9f7qXFSBtXpz727pSufyzDICcAH0fFH+PR/1l7yIp?=
 =?us-ascii?Q?v9YVjDdmwL/sRdKfNoYiOwOLyzFf66Y=3D?=
X-Exchange-RoutingPolicyChecked: oGHonX7A1CVwc7KqDrFzwpIMAYG5LezgsVlXHWr2dP2Bj8hbYhCWmywQ1dlDp9NqkazMktk7JG/8hM3BmKVLNE6A3QZqnsrNIoQ5NE0vO2Iiux85d+3VRRvTAZDEqiLcLfUqKCGv+GVHKSeWDYUSmSZ5VUJeDjeik4F360+q+tzZCYqe24d7TYh3kOPpzXRvmII/0QBBQn+7fzi6bIYNweNjTAECUglEyzDBhGpksP3oZwa2qjfBl45Mgu8jDr5ZDA2VBcYVW7Y+JcSaAQHGNtTUbEyB3usjefgoNISOrIkoaM0BglYsq1ATwgbCa15/ufyS1dK3ARRC2uADhwzHgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 617bc052-5413-4910-e859-08defc4cc3bf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:46:16.6357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iOjPYNGEo2I7s3q73O3+Ql4EeUzfMdxiah2CBxM8OUGmD5ykCERqkhHUHFr9K/IcOzxVLEJV6HYl73MtfqDzpWnACegMnZhvgL/+9sXOAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
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

On Mon, Aug 17, 2026 at 06:48:42AM +0000, Anurag Mandal wrote:
> On a link-down or impending PF reset, in-flight Tx descriptors
> were left pending when the queues were torn down, which could
> trigger Malicious Driver Detection (MDD) events and
> leak descriptors.
> 

I agree that this is a good idea on reset, but what about on link down? In
most of our drivers, if the link goes down, the Tx packets are left in the
descriptor ring to be sent when the link comes back up again. Can we manage
without the cleanup on link down? If the link is down to reconfigure,
the cleanup should be done as part of the reconfigure, I would think.
Am I missing something?

Also, if this prevents MDD events should it have a fixes tag and be
backported?

/Bruce

