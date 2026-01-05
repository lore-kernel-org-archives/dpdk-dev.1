Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D3C2A08D
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 10:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C084026F;
	Mon,  5 Jan 2026 11:14:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id ED32C40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 11:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767608094; x=1799144094;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/GLaIMwhNh6a/ivPZFEhDSLEwm82FUl2fTLeOpJM3KE=;
 b=dmb9CffQMMAOiKom4r/de52wggvJFm24pjPZugdqvqW3bEGOujkiwO36
 cYmi54/SFb0dBj1I91hPjg1YZuboNwAXNltFe7jZjoEnpVKnIYBfL6Hwo
 worVr55CuHDBtbA4jYT51KOdk/OMXYYkniwo3FWEEB5kBtMMMzhg6jcWM
 EFZp+QEEkVp3BSJkJkDFeZjcmZK9eV0GKpRi+IViqHkGiXFgX/5P4jpgY
 dXJAhttEbOq+aA1xijOEvrtd+2hl7aVBMogzd0S+3JKn+0S8BepPmpRUa
 SWvx0xhDqxSTRtXt/gK0V7aMiVIRomuuT0mXmg35LTf/SEXrgUGMf0NHf g==;
X-CSE-ConnectionGUID: fd5fzsMFSleXoMrnrageMQ==
X-CSE-MsgGUID: RUb32CeMT12D9vBEiVDApw==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="80091556"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="80091556"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 02:14:52 -0800
X-CSE-ConnectionGUID: 84p39PvvT4u7GWCLvhpHYg==
X-CSE-MsgGUID: J088X+FKR1ivCmMe7jbr8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="202602434"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 02:14:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 02:14:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 02:14:51 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 02:14:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNs3nSt1DlGq80ESBXP4UYMoODu9Q18LxyWAGe4uecGfHgrx4fUZJQsRjgCqG078tpqCuP3fECwxyfXXxu//wZ24iF9cP+uDDlVShzvX/YdJc50RWZWx+z6gAB5KcLDgDDQ2wxAMGsxY97hwBtD6wHt+YlanW7B1abvtEyPpFNYn7xAcDzOhnRi7TfvqAc+4oS9wdaMv4/c2eddPqV9C7HExuOq/ikeUO0nQddnGyxmMNZ76u2QDb0l/Rz6jBW71e/G8uK7T8ZA+Fp5RPEU0M5ylnpDzELBCltpYkCdLg4/NX95/za/jaUNfafSueLYkO/P8DVZcynipXZPlL782iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vUevMYi2ZRowdWZLa0FL7AR7Bi9OA29A3R2q8PIk58=;
 b=yDTQ/ONDZfTQZF7Bt0tumU5doDqlcjtBh6Wf6p/AvDGXeXTZ4Oa5fswlIVzmjXv8w4oN2oDeAz5u3CG1b49EeLzw3QeigRm1Z3tIA3FXno42lRGGqlodzhz2kNRZwIptj02gyEfXrzKqaU/f2f6a3cZzchIY0fWvNB0BXxgzMkdaKe8Y+XLWsnKfC4NXKqxAPUiorV/VqZd6+Fcu40p8M5nCJJ9TvinmheBg8ABuVIqBX+NREhipFy79YLTT60CdEJBKbDZinfLYH6VLi4O8I9Z4cC8vU8EEXNIEl5tPFjYT10N1Z6orbOxEK7abIYF2zzLuMhfA2KTs5nfOXWdspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB7126.namprd11.prod.outlook.com (2603:10b6:303:222::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:14:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:14:49 +0000
Date: Mon, 5 Jan 2026 10:14:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 3/4] telemetry: replace perror with log
Message-ID: <aVuPFBURB4R0amji@bricha3-mobl1.ger.corp.intel.com>
References: <20251228201649.555898-1-stephen@networkplumber.org>
 <20251228201649.555898-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251228201649.555898-4-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f5a37f-95d8-47b2-4c7e-08de4c434260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ljAxzE6BC+NMOj8CYf/Isi/+uOLbgXBgXVAqTjbB1xQiH3XeeLlsgGTDRJ31?=
 =?us-ascii?Q?Ww26vpXpL8kMBqlV1y3pqZgNRi7C/EPDyeoJFH6MKeIE1mlMSbDf4dDYha6x?=
 =?us-ascii?Q?UjbCejqnj0sEnjwbK1NNF1ol28YbgaASFRQAYb/XSmz6qtXG4sfZigIYIM0F?=
 =?us-ascii?Q?kjMe5d68Dmj2e3xc1jPq16YT0pSkitaNGb/w8I/424NVWPBKQE8enSV3nhTI?=
 =?us-ascii?Q?UxMlzkJnZdCBuWavZ+4jtoDXHQ4HIvbknjIcSDmjruPlPS29g+KdeMkgYUwk?=
 =?us-ascii?Q?X6brFZaD8hB5QUF5UcwetRCj2iJqsCVrlxOWTkFqO8dh47ZkKrfCAhY+8Yqe?=
 =?us-ascii?Q?wkzMUSzrKAHPPZAil/yhFuPwXBB1mo2MnwGE6qygSSGp160ZBwSU9gWkCLyP?=
 =?us-ascii?Q?0Y4MYr4AT8wpKQrFJMAcXR9/Zo9PDTRmayHycuKqm8+CmR8hIGolC1jkZPfI?=
 =?us-ascii?Q?/codSkuepNCtIsdq8CDoGM+8LwUQKf3XwqlURFk6SPV44eUtzjR6JahKVDgi?=
 =?us-ascii?Q?0OYCiu1KLzYxIvc0AkHiPf8hY+2gErc7zFDTTAB+F+tkQueJTii2578rFnAv?=
 =?us-ascii?Q?3+by2Gb74N1CaeC9I7zyDKJ4J+omoE/nc1Hpxd6rBPEKTxzIQpx0cZStXfjo?=
 =?us-ascii?Q?ejXwK0/h7g9M8IZ+VcaddvY0sq7CBXHe/tDyaU2VvUoelmciUQ4qBYljEe86?=
 =?us-ascii?Q?cYyfQZCFTSHXwaSFHzf3akaXt9lQKsp17qwa4zyULOKq2gQuhnHCjjtTJvdX?=
 =?us-ascii?Q?tokvA9qTTNTbJVweBJQOZAs2xKW1ra+qduoErvVlCPpzN8ToWcXarRkZMrFv?=
 =?us-ascii?Q?2AHXs3Wiq90r4DSlRZjsTXZKFsRLHJqnaIyUcRUmJFH1VNTTTfXAefw4m1Lw?=
 =?us-ascii?Q?34xZHyQ24YUD2fDf/FtHQ9+YYhF39jw40RpAodvxwZj1/5pSr9XrYEs1rq5B?=
 =?us-ascii?Q?hz+9LAHb1sHdYmMtNRJnOXPils1RQFvkENjNJ6MSzU5/ua3i4XIbqoUJ7B1j?=
 =?us-ascii?Q?KOTtjFwX6yzNZ3F2j8aRfeS0+QY+2jpGN+Bd1FWu5nIgc+hQP+Ux/yT08vI8?=
 =?us-ascii?Q?h3agOAopshfWhFJEC/s2CgfuqpXH3vKcY8SwmEUrH167G11fGW/k8Vs2vn3P?=
 =?us-ascii?Q?ghbV0b02pPWwdezj/0LatLWBVZcWyvDEvxQ56J9bUM2PW8DYFpzgyg1tTVfy?=
 =?us-ascii?Q?WtmX9jvbInMu2fE9T+mNzan7U2rfqQSLRTwwgd3AZjPdKGzXmgaYysmeP7Dp?=
 =?us-ascii?Q?mkdAAiwuWWkxnYrCl0QVh2IBENKfsjuN3cr3OB/CGh/OIxfYWd9gQx+rQwFv?=
 =?us-ascii?Q?Mm/2eA54okvTYbv1O32EUvEesDK5sPZp3bQYBY9ZZRWRd+mWanmWKxSwo0lQ?=
 =?us-ascii?Q?M5ddywSz9Nb50buB/ArUNUtFAUpLqlFnD6pQ5LSfiGa/hsEc3hNTPrPnJg0K?=
 =?us-ascii?Q?5NVN0mF3lz9l+N+FMSMc4jzpJxG9nQVw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eoPBxtiKV1ckFPkrhs/SABtWDJQi24fG4uIuoocEUAq9vilg4L20RJ3zeTUo?=
 =?us-ascii?Q?r9TvUxinM0t3KpeAnLVCRqlcNMVKSqfjw7F1QFzlPgQXj9GNXDWCfv8JZTVO?=
 =?us-ascii?Q?uqXVIixmppI/+yBply8LcsaU8fLJMOslCXVkhd6xgTuHHOk2T2oSS98J+xMZ?=
 =?us-ascii?Q?uCgY2K9u26Gk+LaAGZI60krIDj6aFMM/KGX4RE8AgwihAIgucJrJR5b3lmwD?=
 =?us-ascii?Q?d24XuUBZxONOXbFUmsftr9EmZo9E0XGTijKqohdJeG+xjMH1TSRZeWphK+yo?=
 =?us-ascii?Q?0khuUt6OIu6e0TUxNiSC7kb+pehIEFoPPmTLy2xwPx6W3tQLGOsZW7zTOTWQ?=
 =?us-ascii?Q?2gNpYmSmkzJX2ayxuA2AKxXuIetxKehodRT7CSW7BP3ruvyJPGaJgybNwNkf?=
 =?us-ascii?Q?s/OdPxApuSZHwQDqCj9nXSf/9BQ6dd1Lx5e67vIxBTaugPqhciMb1C0DinRf?=
 =?us-ascii?Q?+SWJZFTTF25E22wIgMN308yknfSnmEyBaNbPdIWJzBRt6tO4pAljmXdP04C9?=
 =?us-ascii?Q?D9omqeKVhbgJBkHlt2oA663KaHYPFGVMkq9a+9uJEB3eXQ4tgVMQFKQTtrX6?=
 =?us-ascii?Q?VS/HYknTwh5jP8khnpVpLxPBqkCFfYvBlmLRS2XmL2YJoARU71tm8sbYzrsJ?=
 =?us-ascii?Q?QwIdq71cQMwbKXzuBzK2oZAafduNzdCJOhoDHNlaO1qU46zgRJ6VO04ro9GN?=
 =?us-ascii?Q?Po98LbwTaaFi9PaY/6UTZaTu+PbwQDCru5X4xk9WK3XMbygfa16iGoQIY7F6?=
 =?us-ascii?Q?Zu1E1IQp2dG3YZ19ARHLzmdU2sg2FQ9B0HoYCQb3KDfMLARujYAD1qioSVGm?=
 =?us-ascii?Q?wHoN4YMgVdz/6qha5MGt/ROdsiz6r/fLOe+3HU2KX3/Yghoic2a9eLYyZJ1G?=
 =?us-ascii?Q?2+ondRwYOdWrVBC6tVboJBVIp7xVmGQRFuTjcg9ZPDnU8/k4xUk3gX60ufCd?=
 =?us-ascii?Q?P4XYo2ZfkOS8vhtgdgLWf1tru2HExtSbKD8artwn+ljT3N2DM9PfRF7+NbKL?=
 =?us-ascii?Q?8Qu7NBKHOGF0cuZCTzOxsm+LEcLzykpvJz9cw+JGtbZVeIzDRNNmhyXK4Ept?=
 =?us-ascii?Q?dC+LIu059m5J0tzs5cQncbl775/bUa/Xi0GfKvVb5xOc8+npvNVneG77A0/5?=
 =?us-ascii?Q?Bk+AjyOCnBJBKNDA5KdhKhfG8yM/j8ZjnW1cso1M1RrK8bZP9IlwRtCO76gg?=
 =?us-ascii?Q?5H06nbSJehwSW8AUgDa/ii6melDNSvjzQ6/3lU4qSpJD6Ab+vxz/0T/cTlas?=
 =?us-ascii?Q?4za5Acg7dxJmCh1BMuQgDMbwzSlhsrplhjKaC4uNRNkUkAk3T8l/nt/3F/Sn?=
 =?us-ascii?Q?g5tnCR7wnS539Mj9/TxmrGY+dFM6uS3dU796RTMui5lUdz2yEbB1OSaPpnmo?=
 =?us-ascii?Q?owDB7uc7i0OuzkFtVK1DXcJMrtLzwQLL7fpZseqLGnify+wsOR/GTtHh2XdD?=
 =?us-ascii?Q?TxvJICav9ZVSJgqt5RPVeqNWfr1ZH6zIT6Lg64dDghATmJXlzsuRQwvoHj8F?=
 =?us-ascii?Q?joUMY7NuBRrrwIYCkgEvEdYpnZpY518JOWKRVwthKeQNLLE8/dngbO87kBv4?=
 =?us-ascii?Q?17fT5ado3F3BwB+SQHEt2Way+AVfEeht34B1C8G9Nf63ACo68/pBJj+zs/KL?=
 =?us-ascii?Q?hSbd/ZAmCQvomUGG2HGrwq8tevJwmNvKIacuDNkAMV3prcyo6hrM1mLF0uPc?=
 =?us-ascii?Q?QGib4tY+to/5373ob8F8ylo91JOMAG1MpdsGSnXAioATnmv2kJmOVqEyJnzr?=
 =?us-ascii?Q?fjB1vRMgHr/hr0A7ug1+Zq2R10ubbqI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f5a37f-95d8-47b2-4c7e-08de4c434260
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:14:49.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSxeht3qwmPCabKSZ7t+PtHgCFYYbxqVv6viLYUMXsWzFQxdCpKFYmNAXsleIBE+Lkw5xA8W/oUYAornA6DxS1ma1msJq35aC/QGslDpy3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7126
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

On Sun, Dec 28, 2025 at 12:10:52PM -0800, Stephen Hemminger wrote:
> Use logging instead of print to stderr.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/telemetry/telemetry.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

