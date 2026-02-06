Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA51FEE2092
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 12:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B18CF4028E;
	Fri,  6 Feb 2026 13:13:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id DA9E040276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 13:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770380002; x=1801916002;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=02reWqRdtZXlgpxnfpXpx9KiSiG3vOYES4NHKNo41Pk=;
 b=j0XjCwRkrwctXigeHPhzqSOC6qfhGpuZmEow8ClomEsAT7puo/47N22X
 a0RoJbDPOKxptB8xy+3J6ORsHfAV/P6W/flVxzGP8/oNYXhJmfw4Turbt
 l3kmqr20a6JxlDr/0MAPKjxKylJAiPgngMJhtA77EPyYCnQupgDUg1S7q
 LotsxV8kg7ZP6LzPj7D6xDHL9VXU8qEwbY4TfYEU0ZN6Zw0Uu2wJaVHVq
 RLYh/TkIaUMPhbHUxLqpsms4mlsVQAj4Imr6/JDO5VR9NW5YRSGh/hsC1
 A1voZdAWGK9G5f2Fov02g9aDBEA31Leqhsv6m3lbSxw9/TAOpJ4a8n/I4 w==;
X-CSE-ConnectionGUID: LNyTz50OSvWzwXpD5ANM4Q==
X-CSE-MsgGUID: nnxiLYcaSiGGMw47W6gTWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81903640"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="81903640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 04:13:21 -0800
X-CSE-ConnectionGUID: 8ETzntE1ToKd2rRAJQgw2g==
X-CSE-MsgGUID: k2eu0o7MR3G3DOFBzcbNhg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 04:13:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 04:13:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 04:13:20 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 04:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIUspiRiod9bVJigDHP6TsDh47mHWS02cultNajC8655pPB8A7DbHtZegC89HiYlQWjQtC6W9UvR+xGIvZ9TrHOQ+UEGyDtkdUDFI+IvO5PCtr3N3GC78Sm63t9REpyb7xCQI8eXe5znsonl1NcuTX6yIuz8DTIkCpVZhYvrG4l55iXnrVv2V5S85JOPwAz6yOpvxno/Wa7JQbGsxtZcaVazE6NIG2wFUOTPUz8uT8Hb/nNhMNHY2wnZPKdj00zxOW48V7pukUfxKdc/Xdax0tJRU8ExIe+pu1gZAbeEfGqTZ86BWmWJ37FD83PDRd/Cksc6oFr7kf+BnChWm6iAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJC9jqdZ6BcwFNG8YQAZywqLTI5Ibug1/UK4uZlkvU=;
 b=cc7kVoW5EKumIlwqnbFTYhyPolal5IgQ6PTjWSDnWlIAJuV7xUBsUvZabYIKSm1BK7ZqkGLYwEeJgd9h0pY5oQ9QRIPMQaJ/JfRXhUMDapEI4AMT8dw6Wvc2UWdBl2q2j1D82zzOrvcQxz6Tw8MbDPD5wOuTX4RkItQo6xDm+LAOp8XFcdCDsHccv358Kvrfuk1gwe69qdAN9CIUNcA8QN8ZYoECTCnTNI6f+t1rXbhVgaqqSiu9rRKn3PZPynP4zXMZKHMw49FXSah5NhrRhH5zts8FRDDJzXAZnDxc1AiwCSvybDeSYGbKQ62HjXxMvM3P2BwtGBzg8irEB5nFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 12:13:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 12:13:14 +0000
Date: Fri, 6 Feb 2026 12:13:09 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 12/36] net/intel: create a common scalar Tx function
Message-ID: <aYXa1f5Cz5mKR34G@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-13-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1A9D1B959705F1F8BDEBF8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1A9D1B959705F1F8BDEBF8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: c27524bb-ad07-4f96-b3e1-08de65791ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YwY1sEI1JyYYN7wBw2sqXcGmxLBIEaMvAgMQxj1ZlxRxyff+xEzcYDbcIg/6?=
 =?us-ascii?Q?UrElFgpEcDXq8XyAQaavPA0ty2cgHo/HJxr5QQJHI70kAxuD+Z6sgbo3JdiX?=
 =?us-ascii?Q?Va7RdW0BZ4tAapFHkXr5EYGjn8uCDs4cjomtfpCOZsMFkryaepUbyXDDmT14?=
 =?us-ascii?Q?oIIRLDuipVV/twVJAgdXtgCIj3CNXTAVr2wc5GKwXgix7dixERfeLIVN7Gly?=
 =?us-ascii?Q?E7Oz7pV/ZtL5iuke/4uT1DF37nNEJsDSa/U2uWcq/Lu81w8tcnq/W7ao9vx9?=
 =?us-ascii?Q?Reb9wAshuXvhYgGgEYja/iMZUfv+ug3eW4XVshuIlFup+MquzPEs/lJHN9gR?=
 =?us-ascii?Q?z/bbvj/bhW+DiTfqXRmnL7nfFRv/ykyLH7Z61VERN9C2CMAebwJ1jVwvfn3T?=
 =?us-ascii?Q?R4pwUoaslHa4oPVzJgHwSzshOyqqooiBV/v20MLqtNZuo3udY1XgVC4nFnpn?=
 =?us-ascii?Q?P9xhSnsAr/A0jeJEa2aQsDEFAygZ1X0FdfQhDWSi06kQvCt92H5HelTJNxyM?=
 =?us-ascii?Q?CVsM1ZjfcKJmbyX7aXPJfmSuMd6BFdUB5iEsVHPgN0wgoXD5lyNfP4NA/mFA?=
 =?us-ascii?Q?XlmkUwIt6bZXRLMl3x3SugxRp640k6DlagwyOqxQDKhCdy8TlY4SpTy3gdHP?=
 =?us-ascii?Q?X2LJ2yIH/QAnIw7QiLXrap65ewZiNmntQUIbu1Iw6Qh50GEDVqGJC1NI79uF?=
 =?us-ascii?Q?aQF8U7iytNmRH8Rlt8s/aehy4L68YcAO/uml4TDeFfspEB+pvGXLFu6dKcam?=
 =?us-ascii?Q?TJ1nUUuhkYQCss3kKuOdeflgpjhf/LKLp66ehdyAs8fk0E+QKlDNRiWihySv?=
 =?us-ascii?Q?Hg0rah7PxmnIltr43qwLlQB17PtAUZKnnABktfaXeENFvRj8T36KP7oYOlPJ?=
 =?us-ascii?Q?fgTzP83EMgzpFTvkOUwXGg+0RclJPKvEpLPH8VQUn88Ef7OpTyNG/y9qDuBL?=
 =?us-ascii?Q?tyIMn28WzWKHKTkqWhm1q6Tla74be1ICe2jmYHJckP9tnkE54U2qmgfBbzwv?=
 =?us-ascii?Q?D+XCmVINwXXOCifJL5Bxu05uhH2x1lzWzq8smaYZFQknjP65fGNkbdXiXZyS?=
 =?us-ascii?Q?KYnyrNss4w7+/K5yolKjugU1RU41MWdR9Lr9+8pgOrILUL4LF09kOvJPKULL?=
 =?us-ascii?Q?r9ZWkGPCQGs59xKaYx4cBZNRxlUKBbpR6wV495dykG5ojOwXKtDW6k0NIRm0?=
 =?us-ascii?Q?xEnzlMecBlRBe+wOw9LY13k8cBMg1AG2JxEBEr7b+gSro+3KGaM3CVBH70OT?=
 =?us-ascii?Q?41XJS0RqeuHk/3FwaYcouXL1kRqhcSnuH3IwfAHKwaLtoup9pwA3JVavr/l1?=
 =?us-ascii?Q?FZ67bIJ8/iEFkaSxGDWveKV+/U+ZXX4JakKW+rE/wqi/UPmDNBmmGBj9+/uk?=
 =?us-ascii?Q?XLFgeSbuI30KWFMVq6JzVsuAV7Nc19X4iJxlNGxqS2r/mh+INJ53hPlG3G/R?=
 =?us-ascii?Q?t7bWwt49WhQ2EAYvSZ0kydSAONb0uwhJdim5mFgVh6eea+j+aVodNrd/D6jr?=
 =?us-ascii?Q?gZNF8tX23FC8qZCZU0YvqCCl2F3p3vliq4+F4bBAzgzUJ2kuF9ekGpXowoBV?=
 =?us-ascii?Q?Kejfl2t4+XPD2xXSBCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qV92wihwA9+XU7NVmueS0bTOhDFDNDxrSZ221/NuUcpOyuQGODLGZcR77bh7?=
 =?us-ascii?Q?jK8qOBlCGcbotSvhWDXdlNK5rgA6iYFYSA22xGn0tV3bPCxYOrZPKRKq6iiP?=
 =?us-ascii?Q?Ot5cuZM4WW0/V90OhRoiVsjJ+aVUNUSKvA33xn3mvLAXhI8H2kId3gBUFGLE?=
 =?us-ascii?Q?wzMGsPfOGd6/3r6fUFjCFs1OhQSqvyB7bkgofkh9WN9onLcbYurSkTzyFkS8?=
 =?us-ascii?Q?bk+2cRcYuz6MTyRobcNUB9IywNMPSHyqoghfbHtNx7IEnJsfxDgK6vnsSCW6?=
 =?us-ascii?Q?tAQOePksZGQ8lLs6yEq9Jd5KOtBFjsUIwGxiHPpxjQZFLT+0cu1/G2YmOcKr?=
 =?us-ascii?Q?z3n7Bh+TeYt/05wxZH8sZrauYx92qdtc/5wd91LCEriAwXpziaJwFtJZBfKi?=
 =?us-ascii?Q?G1fxTewZ5c0msnFaeuLnUM88IQBY4EMfe1nC7rd5PC0M8gp2ZYGtSLVSlEoC?=
 =?us-ascii?Q?KbrU38Ze9HYRvr+QoM4hno5I323sV4WAEsHaUYCg/hyVKGnZwVyNw8D2KTJI?=
 =?us-ascii?Q?qYYKDTVKoIB4hYiSI3ItQjAo6QOO45qBhFXUkGdG4GDMWCXGCznDG1pqDIlF?=
 =?us-ascii?Q?s6+tMbkSc/LyRpPTMkVlGY49A1t1wZkumDX5rSGNymK8gAZO/705lku9NVi2?=
 =?us-ascii?Q?a3riSd8pKp4BMpcnxA+9YrFzwHPGmF/TSTi0B2UXl63bjsFzeeILFxGqN4DD?=
 =?us-ascii?Q?ck0iqz0YozWVbXHp2Jm14oMhRqfm8DzPCTWhf42BYnqh3eq1tcZwogGiSAUa?=
 =?us-ascii?Q?zGeqZCy1N7aGSC5poftTSrbRQzajqnm7P+vMhTosyXXbRhvZzNtUEglTR/lq?=
 =?us-ascii?Q?5CJkiE61KfrsDKAZgE3321iY7zM+Zdw5eoTAinHPq6k87SA3O7T2BXixcq1P?=
 =?us-ascii?Q?VrQE9Mp2NVvMXqS2UkTyFqcVKIoEPx/UwSTaNfT5MZwv1AM9nbvfGKtXQprM?=
 =?us-ascii?Q?4RAKCMf+bte7w08tBiAMiR5vnL7jS3qpRcjnqiFrBiMW/o2kfh0PzqneL0Mv?=
 =?us-ascii?Q?QO1zaO9AP9VfkitL3ktIwmfXSvRRo3YazKU9D9Vb6DedlKXJ1dQvdzTP9U8I?=
 =?us-ascii?Q?OoSdWNuBTr2sGT4QUZ64KRDWMXmcFx3lq/zY6HmmfPUFfDo9B8VBILy+wyt6?=
 =?us-ascii?Q?tc2aOw24Sv+sm4UyIiFTSiSkH6nJxlMXB9Hiez3nI6IyH+7s/sjB2i3ggnPa?=
 =?us-ascii?Q?29Kuvo4U01MSHPGRNlkua4HArP8mf1Z9M0TXgQY53fktgGLOPzR1fx7KN+lO?=
 =?us-ascii?Q?IMH5nPuy5p5FoA6GNwmtibvAKJGPUWuuHitFYf8uhZGz8AD9wDgHvEkdct32?=
 =?us-ascii?Q?0dib6Uuprx+ktL+SSU6jEuiEGxTie/p16L7V4ZdFyrrf7U/mhYhHtH8c3qXT?=
 =?us-ascii?Q?kb13vY8A47ewESRiggk84HEW+RjVTXpPbmZgmCDGhRznu1jTAa2Jogbl924+?=
 =?us-ascii?Q?Ua9hEW3hw7zsQr3WUGjQvE+bTWkGS1XAaZCiMIPFvDZ/2Z8/MsnXN7l4qD4A?=
 =?us-ascii?Q?Ym4FRyrmLPtbXW5b3DSKtiQhcRIwnFCRqIIIhOA0XxWBjc3XVr/N/KiawXgw?=
 =?us-ascii?Q?iyw6uri9cgXd5XLMGfXp3jUDegq+BHjVNgwePcWa6ayV+UwTfVCLvUg+Zsir?=
 =?us-ascii?Q?YnERjZxZyw+wjP/XXDq1oMYiwiU5i2QS9t0AS8kMoOk7GB93qU5r5sdgv1Wn?=
 =?us-ascii?Q?FdsM/B6MARmJOG+nN6qhSCh25uVmYY+UlQAMJPHTIASGsrqX1XXmtwAWcPCx?=
 =?us-ascii?Q?9+hQeLJIR+0kZG+qE+W5yuLSFUQ3cpU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c27524bb-ad07-4f96-b3e1-08de65791ab9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 12:13:14.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51SZECdh+YxLkMLblXM/rmF9ptGlv0rHXc3twZohKpmN9oVjqxjxRCzU9wFaVG0Oar84Fkzuo+yiImzoDcApl94qscQ7otc43/dAk4jE1SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
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

On Fri, Feb 06, 2026 at 12:01:38PM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 12/36] net/intel: create a common scalar Tx function
> > 
> > Given the similarities between the transmit functions across various
> > Intel drivers, make a start on consolidating them by moving the ice Tx
> > function into common, for reuse by other drivers.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx_scalar_fns.h | 218 ++++++++++++++++++
> >  drivers/net/intel/ice/ice_rxtx.c         | 270 +++++------------------
> >  2 files changed, 270 insertions(+), 218 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> > b/drivers/net/intel/common/tx_scalar_fns.h
> > index f88ca7f25a..6d01c14283 100644
> > --- a/drivers/net/intel/common/tx_scalar_fns.h
> > +++ b/drivers/net/intel/common/tx_scalar_fns.h
> 
> <snip>
> 
> > +typedef void (*write_ts_tail_t)(struct ci_tx_queue *txq, uint16_t ts_id);
> > +
> > +struct ci_timesstamp_queue_fns {
> 
> typo: timesstamp
> 
> > +	get_ts_tail_t get_ts_tail;
> > +	write_ts_desc_t write_ts_desc;
> > +	write_ts_tail_t write_ts_tail;
> > +};
> > +
> > +static inline uint16_t
> > +ci_xmit_pkts(struct ci_tx_queue *txq,
> > +	     struct rte_mbuf **tx_pkts,
> > +	     uint16_t nb_pkts,
> > +	     ci_get_ctx_desc_fn get_ctx_desc,
> > +	     const struct ci_timesstamp_queue_fns *ts_fns)
> > +{
> > +	volatile struct ci_tx_desc *ci_tx_ring;
> > +	volatile struct ci_tx_desc *txd;
> > +	struct ci_tx_entry *sw_ring;
> > +	struct ci_tx_entry *txe, *txn;
> > +	struct rte_mbuf *tx_pkt;
> > +	struct rte_mbuf *m_seg;
> > +	uint16_t tx_id;
> > +	uint16_t ts_id = -1;
> > +	uint16_t nb_tx;
> > +	uint16_t nb_used;
> > +	uint16_t nb_ctx;
> > +	uint32_t td_cmd = 0;
> > +	uint32_t td_offset = 0;
> > +	uint32_t td_tag = 0;
> > +	uint16_t tx_last;
> > +	uint16_t slen;
> > +	uint16_t l2_len;
> > +	uint64_t buf_dma_addr;
> > +	uint64_t ol_flags;
> > +	union ci_tx_offload tx_offload = {0};
> > +
> > +	sw_ring = txq->sw_ring;
> > +	ci_tx_ring = txq->ci_tx_ring;
> > +	tx_id = txq->tx_tail;
> > +	txe = &sw_ring[tx_id];
> > +
> > +	if (ts_fns != NULL)
> > +		ts_id = ts_fns->get_ts_tail(txq);
> > +
> > +	/* Check if the descriptor ring needs to be cleaned. */
> > +	if (txq->nb_tx_free < txq->tx_free_thresh)
> > +		(void)ci_tx_xmit_cleanup(txq);
> > +
> > +	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
> > +		uint64_t cd_qw0, cd_qw1;
> > +		tx_pkt = *tx_pkts++;
> > +
> > +		ol_flags = tx_pkt->ol_flags;
> > +		td_cmd = CI_TX_DESC_CMD_ICRC;
> 
> Why change this initialisation from 0 in the ice code to this value in the common code?
> 
The spec specifies that this bit is reserved and should be set to 1.
