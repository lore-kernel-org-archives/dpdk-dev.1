Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A17EA3C4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 10:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91840402D3;
	Thu,  9 Apr 2026 12:46:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4FAA74028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 12:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775731572; x=1807267572;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bxLJWcXInMx75dHgb0GBV24eAilWBgvPIrRyA7XCP+o=;
 b=OuZvncEYm8zipIavjD98Be0som0/mH00W62xWNdDXsoNoOVfjCJgTFXI
 N7c7kWb03A/B87N4iKrDJDG5n31oxrDzQm46d+/8TwTNUepyPfuQUbZ+z
 2WO0bDRksvdGJWOelxfaG4/eveLCjdShQcoWcMnnCDn2kHMVREwSCxV/i
 cPf6Mevehn+J+RBuuXizSLZPdxs2jzJ3czgNPFfkmb//eOjvaK4GlYrxr
 CS2znL8wGP+nQLTc6bZIGGhMA2dur/vK2kqdqDDJgNIaE27WQ2eOZEwfx
 aJW8UrjdItViaRviYTwX+N5l/TFdGHd7xUMMqVH0MGsTF2Nr66jCpC1fa w==;
X-CSE-ConnectionGUID: BkTtmHeqRHW0VDO9Byr4HA==
X-CSE-MsgGUID: oN8E45u4TdCNBe4embcQcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87357008"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87357008"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:46:11 -0700
X-CSE-ConnectionGUID: SJTBjSC5Syy0JLEkrHsv+Q==
X-CSE-MsgGUID: tOGxebwdR3iuRFlQvvPv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233628189"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:46:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:46:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 03:46:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwORIUIZq5jLExFxFYJmvGB9VqaCRHEzmFvm0C8Dv+u50ZAkdtPbl8uqU5l3yXGKXzkRDFvkiayoInVs4hX0plfeLPJbiz3+ZVrZJNCe6NP3Vbg8Za2pBpQUUQaQfe/LkbBO1oppagTpewc77JvqKw6XBp1IVVcelP9be72ehczuWvzXa8sS/1pPclKkwcKcCDmUFeiNIBFxQqKpHNRbXg2zGXpJoKwl0y1LNuyRdcrpSyBFNngjRdjYZWBDJwOIXYAnOj/fUa0doy4UtIy5asUQxfSFnTSoWBnv2QF9Ta5J5l8W/XuZemv7LVMZ2y+kZ+km8vZVZrBKCtERZcPJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTf0oF9smjGIrGRF8IR3LbgQmlYUSWxsPLKlUSsClMc=;
 b=bm7Cb/jlnqElXzUi9d4dyQlpzkdXKTWlq0IfX2Dwf3uZ4/wjaRn9gzA6dkCkJtPZIaZ4rg2F0rShAlPQomVgBZ/GwfCW4ZtufrzYJhJt8bcJhO5rLG4iza9av/lxj0wwGq7pbZ1iAYY9bJrSwsupkYBYrU2P9k3hO6d3KRAdcFmc596+J2pGJB9usi6aQCuB0l8kGbfz7UmF2fysnqQx96tEr9WpqajD/dA8wUyfV8SNNPeJ+YLal2xsqvRvTVGlw8PQDHhnA7UiikI3jwb9lWJbOGEz/fgCXsp/HEChSaGGPeeDeWaTtLGkGq9dFZln9pB5S/gnhgQCMm5Kvs8jyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 10:46:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 10:46:03 +0000
Date: Thu, 9 Apr 2026 11:45:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: introduce a dedicated idpf complq struct
Message-ID: <adeDZuCwrCK5eroT@bricha3-mobl1.ger.corp.intel.com>
References: <20260406044125.3170558-1-shaiq.wani@intel.com>
 <adZ1iJkmy1l3uzu0@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adZ1iJkmy1l3uzu0@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0258.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF2F7FC4EE6:EE_
X-MS-Office365-Filtering-Correlation-Id: fae91887-7c4c-41ce-7cf8-08de962531d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +4xcNiSUdM8HzbPNACgkJyvXM0W1FPqoI0+dmmpO1VZvncOISwAjUuaOzTAz604DEYcHxkXLVpq6wPLvw5w3dl6anbC1tO/j8MmidXxBQA/ZXGTYaP4DcAVHmDTXENz5z/IhbOTPmJTCkB1M6TYzrgCqBbR4hVZ2tz+M06pDdln/sHCOv/mtTkpg5HIhBhTqt4zvFxfkBrwC6p20lIBoAEdJoBs4NQZaj8c/SoEpJLktWb00cscnqO2lH9IT1g15x8Qe3LysFwDn2+ksDfEVlIvV16ml9zFHIqcsx23unVXpthHiyiMubVUuvbsAHVtG0yGky0xXZyUmG4rc/M4bxLCAEvjrGUPJ1/5GKgYBv7iL/9HQrOSpZvZG9YjpI35Afpucs6YQ27yXQK4WABJOV5yRRmp68CU08knn8DNmzF6bhv0302RRfLuL2pHR4Z8QTfP5J70qtavCvMzcptWtcR90NZpLf+TqVMZdFw7d9/jV7A45zXHkpul580HWwPC1ET9p+kAlVOcJbwnKiMzD0D0ZeDRWWS7JKI9HIEHXzkuRmfj2RCo3RL52z8efPuLMsCmZ0MhVsHyznEzLpczHZJTGVGPr7e1bjWr8aQWEXIj1e+RsKnQHi9oo4tCfPX/NKE7h4TZdbX5O08uYOQJXMKuFwrxzIi/KesjBBkYmYVrDYftQTN5E+i+HJVO9qGUG9MYorpc/Mp10cZg7LKL0vYhCRl/w0t9x2Qt9nY+zVrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiVrF6nL7uXYdngjT9uDm8wc44yRgcHzia7ck9JAqn/4QMmCXSv6LVUVvL1A?=
 =?us-ascii?Q?/JZdm2MQNv06IP0aZonDpaNkFQ4WWM0e5v0gwu9aRgd26CIgGuAB5t1KnkgA?=
 =?us-ascii?Q?CRRII5nZr5oMaEZC7mqeaOjU9BXVdGUjxu5jBTIJgUK0DnUKpoRCRzwcukzw?=
 =?us-ascii?Q?OxD29YVcYuyyAip0PvrXWwQ68YVqiMUHl+8+E/VTPqzMmCk1ovh2A+6JrXMX?=
 =?us-ascii?Q?p6HEi+efpBNP2qJv0J7YkJ9ZQB3xb1PCbIpCXFQz0JRHaKywDWW0Tr4VFv+5?=
 =?us-ascii?Q?Xa1Q36DVVA3UxssLaMjlXqolFy4AyMNJ7OJ/tPATxhDi/dXqMpM7gCW7jqZm?=
 =?us-ascii?Q?lALepu9MWUSS1z4GLfd3oS5CJcPQaY91fa34jf5OrizoUshDOp2YXL1fXPUz?=
 =?us-ascii?Q?j2McoSCzmiCsriR5/7g+RL27MgzfwkAnWfYDXcVOX+hhGHWztM2i9wthIbgR?=
 =?us-ascii?Q?rfKa3Xw8gSXvYkhggFkOBcLOW3x4FvS+TgdosCGwRL9O0SyDSjmoZiTgC18C?=
 =?us-ascii?Q?Iw5O/CKoAS0frh2Tm8/I2aoVTGqK0D4j8Kw3aEkGoWd8dR2r7yoc303960Qo?=
 =?us-ascii?Q?Qx/4mD+fggLlZQgH15s9nhtgRYsdWRwKzVX8sEiZmPS0Y8MlVSij6ZMD5F43?=
 =?us-ascii?Q?qM/FwMecXQnr/EPl4Q2pNSPIXC5kNioI+t7wNdBexyDeqLvM7lz8TTtUQozI?=
 =?us-ascii?Q?vjISb0Vd8q214XQOvevPfFAxhRMm8N4ACTng87P/U9d7zSwSjQIVIN+DD7dY?=
 =?us-ascii?Q?2FN4A8c7u3icUP5BUy3/h0YlFyUpt8eApsHTJVwhq9/2pGWb4+7cw27NkPg5?=
 =?us-ascii?Q?ThzA9XhjlfJ70MSQdDY6sTYSwP6OVLh5wFHAHwny8pSrB+25W1wClz5vZK5c?=
 =?us-ascii?Q?NFWTIgEwE0r2sHVcwwvtx+RE8iJNvIgRRXn0OZI1HMxlo+nx0biiIOQpBNET?=
 =?us-ascii?Q?swXV1E/teNgFpDVNvCwEtNsYERNOqjm6H0qsVJ/62FpX+Vh9uaqFxKGV7RMn?=
 =?us-ascii?Q?7Hbd9lkNXByRQJJKArOQxsytdk5ziLIyV5GtJOuVDlqFoQqwFAvMUwxcVx4Y?=
 =?us-ascii?Q?D6RxSiDlaX0WLLd2TOlFLng37ONRgH6RdhvavnipWlm2JH01jtH/E+7p+t4h?=
 =?us-ascii?Q?JMoaq8ZGEPRDR7OUUdJaFVUeHCNy9Si99Gh8bv3CSbslIKijhRv7nvbvpBDo?=
 =?us-ascii?Q?ygBZtNrLFO2TutBBp8blQA01K4Jm0MrhZX8atP8gUp/APjLR9k5sTzE00e06?=
 =?us-ascii?Q?mODAjsIXj66vCzo8PrPOxQwn5F8uamairQ9n61UG2Q60YcPYIpbd4paRM3zx?=
 =?us-ascii?Q?rGwmVcpblkx4StJ+DiOCaAJxi0Pqxyw/8NFslAdowDBIYenOmhbgJzFpZ2E3?=
 =?us-ascii?Q?DBcDEXuqhCzSpxHhmN5eF+SnPAPfCc801g90+D6xzUC/og66tmBklrMTxN9r?=
 =?us-ascii?Q?J6IcYBQvl7ouFV32w1Y5AM/u2uifslDwab25NRe+fL3b9jqvRKt9yeImm9ZB?=
 =?us-ascii?Q?FhvAKatZAIj7ysPz0u4mYNjzK7ySrZj5Ly7BUzvlum15W1fK37LUdCDmwbXH?=
 =?us-ascii?Q?MPBemdQZAiUV2YlhxnFB2YaPQwFd7Oy7u1CDXFEWBwqDentqwark6hAj0A9i?=
 =?us-ascii?Q?Rad461Sxhvt9rb0oyjDXDaeIr2dkS9thuZhWD+QFDfh9xa999zb9CQT/rD39?=
 =?us-ascii?Q?5E+DOItZAOItBbuFGHuaEGEMxAAoy8MbCPzpuhtld6BMXufoQkY+ba/PjKhP?=
 =?us-ascii?Q?hq031HEGHDfehdkfcg8JneM3B73LKCw=3D?=
X-Exchange-RoutingPolicyChecked: ldeXgl2IU1bhZ79HycCGhPd5nXFpHaWA8bctf/2WLdHGBny0LPye12HPtM96HQFSyixNTVweVHUmufgWiKT33SjD5YSjXaqYLLvdonOxVUW0Okw/gL8Lsxr3+vf5IayGWDdudgTKHXYJYLvBhZqC+5Mhc1kTlrG9OWiHNBi6gORXOXIX1fZ+b+bFu+kFFEccrHb7q1WVl8casInAiDblGBKJ0Ks/FozvXQYLrjReuCedsLS+TsO9WiL1YZoLZ7Ae4LZAdfC/lsn+sxB17KmEORELQ/fukGnTEf8GF+46nOOYzZqhb1hqyUWTlzKDkXrV40ighujiGzsjB+v/nwHxSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fae91887-7c4c-41ce-7cf8-08de962531d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:46:02.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osup3Ae+iynK0VC7NFbM23Ev8T1gnHVuASfgD5YwYmXQOMDt5tb+DUEMrPvDZ7LIgH7ErOZssxfSLvpz1HdWePQ7UxnSxFCMfnR7kicaNUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F7FC4EE6
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

On Wed, Apr 08, 2026 at 04:34:32PM +0100, Bruce Richardson wrote:
> On Mon, Apr 06, 2026 at 10:11:25AM +0530, Shaiq Wani wrote:
> > The IDPF split-queue completion queue was using ci_tx_queue, a structure
> > designed for TX descriptor queues, wasting ~96 bytes per completion
> > queue. Additionally, the CQ-only fields (compl_ring, txqs, tx_start_qid,
> > expected_gen_id) bloated ci_tx_queue for every other Intel driver that
> > shares it.
> > 
> > Introduce struct idpf_complq with exactly the fields needed by the
> > completion queue. This brings the CQ allocation down from ~150 bytes
> > to ~48 bytes.
> > 
> > Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> > Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h                    | 11 +++--------
> >  drivers/net/intel/cpfl/cpfl_ethdev.h             |  2 +-
> >  drivers/net/intel/cpfl/cpfl_rxtx.c               | 11 ++++++-----
> >  drivers/net/intel/idpf/idpf_common_rxtx.c        |  4 ++--
> >  drivers/net/intel/idpf/idpf_common_rxtx.h        | 16 +++++++++++++++-
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  4 ++--
> >  drivers/net/intel/idpf/idpf_rxtx.c               |  2 +-
> >  8 files changed, 32 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index 283bd58d5d..9da9366046 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -114,6 +114,7 @@ struct ci_tx_desc {
> >  
> >  /* forward declaration of the common intel (ci) queue structure */
> >  struct ci_tx_queue;
> > +struct idpf_complq;
> >  
> 
> Minor nit: You probably want to have a "struct idpf_flex_tx_sched_desc;" line here
> too, since you reference that struct below also.
> If no other issues with this, I can make that change on apply.

Actually, since no other pointer types within the tx_queue struct have
early references, we can instead just remove the new complq one too for
consistency.

> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
