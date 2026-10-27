Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FB606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TG+bUcR9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C868240151;
	Tue, 27 Oct 2026 18:21:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id BD7A6400D7;
 Tue, 27 Oct 2026 18:21:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793121679; x=1824657679;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Keb3yDrJHkVoTb+VttwZVswhTu8Uf17oaq08oALzE5I=;
 b=TG+bUcR9M3cCG9JhUXpWQScmhEimAZ3uWvGkxzRsC018ZK3YITUXXPtv
 UmhSnBbvxAPYHqInaDmF88J0NVi3Ql4xLKgyC5ASH2/DvD9nhQsrfbfNY
 LUpD/QRRWBmcn9c/+vN4kjRKjVm+uqg5VVc+UxVY8lwDNDT4ziHd3wQ9c
 eiPzOwAAyN5UYiF9WFcaYIdNVifyHdM/fdwlPbo7F3S3R3Slmrdep+KlB
 nLm71NEYc2tMVlCLmewDcYyenhOK5Tvetpt007dJP5sZDQAcAylBJce3q
 QArN2W94W+dMjUkEX5JJp/uEb6BrN0TDaEz5YXWzgolUEbiZbLc++shrO w==;
X-CSE-ConnectionGUID: JeVOFTdvR7mNAQhvtU11kw==
X-CSE-MsgGUID: EMq4bPhLTsWYV5wH2zBLSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1707550"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1707550"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:21:17 -0700
X-CSE-ConnectionGUID: xICfS1M9RjSpp+M3oVC8KQ==
X-CSE-MsgGUID: KLH/HGCcTHaCDIr8VhQKbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4549650"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:21:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:21:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 10:21:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaqTjGZ0Iw3bhAJVTb9fDvEgOeidno0EgxqOAZa0IokISKk2WCtCMb/GmQCCPRvQKV4fr9n8N5Fr37on5zPQk6c5rC3Warl1ZzII+kYEiOrrBqijtB5JQJ9GQqhqlVUxuFJ/XqBA0yTecw/rrhD9nVNboX3Sr74dhHDKRTUCdKjrpI6RF7P1w7/ei9whv2FotaHrs0p0cmI76Jep/l0lkuqlzMKVWweLELrpVT0oxoVaipy6u8INJ4B5+4g82qXt0sBUj9niqnmNfTcF1Y0CfljhKc3Pfmpkq4Bin0tHdNbJ3O9zqH6/Art/FkQsUbdCJonT5gjtv6PBO9yKzEFcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0BbYvA8C/2f3mQG2r6l3XyZtZGNM/xU07cxQgm1Oss=;
 b=g95jfcrBOU99dKzRuopf2q6/FXI7mc+egXKjNsdAKcUe+sU996wEI7O1iT7w9ubjiNGITrGdSr3uBqmGJTRZb8K6asLXYJQc0AXO/u1/g0ehQ0YaCeyrxCZeeCZ7g/bXr4RGxOsODyqWmy09vBDPm2V886fyzVWWj0wDbkTzWZm2xlb/90ApuAXAHVoYggIZ+NlssCa5rO7xAAv/Ymfw2oKseGW8YvgQzKJgZe75uvx04lneqXeoX08OQFpm3IPaCm5uOfm4cDZicrKVg1iMu0KGrbEp2fySpBEw/TlxljNgHYf0svFGzd2xXmjqh67TsqaNfuH6YdxZEWswxaAblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:21:13 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 17:21:13 +0000
Date: Tue, 27 Oct 2026 17:21:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4] net/intel: fix idpf Tx payload corruption in split
 queue
Message-ID: <auDdhEoq-EZX5cQK@bricha3-mobl1.ger.corp.intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
 <20261027061017.1018902-1-shaiq.wani@intel.com>
 <auDcoAtbWmUzVjSo@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auDcoAtbWmUzVjSo@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0323.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6800f1-207d-4ed4-4a0d-08df344eb343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|261026121527099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261022105027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: APu1sUkcu9fXKe/DxeSxRh8OBavyQWeN/3NRlgkR6w5dim3gp9JR5gGns1JN/GUnUazv4BIMjdPn74z6DzPfEDa6PzQVXVTm1rBrxZupB81WWH9DZNLdx5oqLsKn4Wp80sk2UBgU1JezlDWZfwKlV4ZAcHc98+vd8LkPxUGHjj/KwrgpkoJraVjTijcKwmGCv+xSN6fyl8RaT6IX9GzXo9UpYzdm+K0yOb1RHDtvxI61TITsBNvSzvyuS8z4LMNBf1pAQjPzn1Ct6rkgqKSH8GSDVOU8rMibK9kbPw3z5hjuNsF1ZvMWq+4/b9ITES8oaAQxs1xulvkHT8FEyHSI8F48I+kGAUQJuOMUTwpwaBIui0wo3ajA9fRuKJJorhBkufolmXkDZeSwc9Yv5kIG7mRdE/X3FHO+oxz1SpHwnC4NCDkkdx5EJETg9uuPByqrsbKclg33bHnMWgcQc2/8I+tQQKryoYIrx25tHDFPT/X+63Dcam2WRdvCyZJbFrjzzCMG9LqWiwnSxQP/vobIpCU7RrgYefKmEmb4TmSSq0xecKwE0dVBrYJsc8uzSCzoqcaCAqtH1xtao5CKPLRREWMtoyZoDu0NaiaHg4Q6VmdG0s1jNN0661MidYk83OkG7apfk50utWYsQN/TZL6BGQ8AoYzbbYX63YoWTN2Zc/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261026121527099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261022105027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ohni5/+ULoYVodSmkVrMZAShspcUnpIoMfjrRfGQg1VZ8aCBJ7VOzMVY3Rz?=
 =?us-ascii?Q?qscf6vvrdQ3D7qwsMtuDqX9FNxr/LKJPUMK5l6N35Z8I3+zwDp7sBw1IZmCL?=
 =?us-ascii?Q?WcKbySuQ1gZfQD1Z85O0Ta1fL2ixC3mTYPj5AS85MLttOZhsI7boAcdqRb+d?=
 =?us-ascii?Q?PT4nTBhbcnUhN+fkwBEMzxLuuHo3DE+w9zD4Bmi8Zf8vq1oPJECoX70sqHw7?=
 =?us-ascii?Q?Y77QvESLlyT883WKINzMLcMuOCSzYWN3tUgtMr40DfzlHTfHhHpX95j4x0Bt?=
 =?us-ascii?Q?D+QWehXo8MdduUFMOhdL2NsDwdNAe7rReH69tCZ1T4ziFmXg9IUtY6tK5Ijr?=
 =?us-ascii?Q?4m56m4Xl0CYUzRNUfvrhsOnv44dQ+x1Yyqb2tVVcbT5eL2FihA4278C62zmp?=
 =?us-ascii?Q?lOmQNqx9wkM7y15IzUtcmafGuzVVXnR+gSynH/C8JYB8JVg55PXXszHjpoAX?=
 =?us-ascii?Q?sxNI1TfC8xWVvjTVxEY99YEtZ33ToBySxTS4IOTvdOCS4MVQ0mcRwgHTbsnr?=
 =?us-ascii?Q?gMmLTfnsCFo6YDHID2tYSRmiCyW80LPZ8iss3AWsd9eucYJh7sIgz5h2lHZh?=
 =?us-ascii?Q?59AlM5RJyjIHCDFMRQ3o9+giABehMgqpIgf3zgl5d7zZXkO8bEpRH11/fGbi?=
 =?us-ascii?Q?Z505QJi0SZutvUeRWv4tAUg2DNK7SgpyxTm5LaU6zqprzbAmjVmEA8Vh6KRI?=
 =?us-ascii?Q?kBtRjGTxBgOBTL2xNdJhYiMzXlIgTp8MJ6uWAkTIxTdghgIwKtTN2/D8sCLu?=
 =?us-ascii?Q?wvnoiLMmSvgkjza1Biu2cAgFx2a/c8aQuR+P7sdexhn8P9nP6u4GeW4tA05w?=
 =?us-ascii?Q?VFVjZVApY+kVgGfSAmW9MFtY/yczGbHYU/TMZ65aKSv1vs3qYl98auFdi0LT?=
 =?us-ascii?Q?ik6BnHI5PY0SUI26v7B6tTr14DAbrQJjYMG3Vlh5mvHnWuQT8TZoXxKYNZoR?=
 =?us-ascii?Q?v3iOdpZay72oGmw9A+MkliWIPwqnz4UyIPc9EFGBMWVpTfnN3+hYJOTo4BDK?=
 =?us-ascii?Q?FTYHxnO8osbCvq2uacokVU5uTYpph3SVR1BBnZT2J0J/RxJ6Q8fICqyt72EA?=
 =?us-ascii?Q?RpzRHQjQFq7+cxT1E1MbQ6XHZ1tiAaUpX5dD4awkAtinWprUBb4nOEnpV8oc?=
 =?us-ascii?Q?z48J8lmb2quXp5uG2RH/OthWZV3H9cKOJdsIlOunGAdVgDuc4O7B3yFG1CVg?=
 =?us-ascii?Q?+XR1MlJPMsdLsbGOC4Z+6DPk/OD08MmkXstGxMY6jo/vrQAHrXjCsrZ5ymt4?=
 =?us-ascii?Q?kVX3Yi+SB/+3jrrHuQux74JoZMIN1cM6Dbs1rJJo6l2/fCq6jKSMaRKACB/f?=
 =?us-ascii?Q?JTxiQceuolozHEOOfjrY40l9Y4A2BmcLPwgHLCAM+21pbhAuYxhch7JW1O02?=
 =?us-ascii?Q?pBXL3aeq9pTEWwPGc2LQZxfPV92hGweDMuvbCzmfi7HNTycFFJY+DUJOfjUC?=
 =?us-ascii?Q?zmvXWuO2Eb/5fRJsHzjJS2PbA756PaoNYVghaPWQNafaD+oyDScDM0qeGE21?=
 =?us-ascii?Q?5+LrPXU+wQ1qVJ395oikmM/2rlJxmrHaFcByqnsfUjvuipqTHJmHhrb2nWjS?=
 =?us-ascii?Q?d5HtwkcyXopypzyLlWCa2h8vPsOKizY0wn9opm4aRZHLYYd4wRn1JU45Sykg?=
 =?us-ascii?Q?0CJo9WxbZ/npcl3lV4Lo2xPSPWVAWsOaCFaLEkXo29+ftxb+2FW5LyreSEN3?=
 =?us-ascii?Q?jaeyF7/tirlwlsupMKvO4LUcTmeDAQDaoRXsDhH6r5txVIjRJR+drZe/sGVE?=
 =?us-ascii?Q?vAtUX2ggZhv7rWu5rY9ZkG9jejTCJgE=3D?=
X-Exchange-RoutingPolicyChecked: hC+KIgd/DGgngtY8EJpxx9n+x77WBegnWSEn5aIckIagtN5HssXsdRgtS7GWy67AapXulN17CpGiZojkD5y9MWV3j31nH3zvbdT1UrARhwMpx/lX9Vaxfn80PwliQF0DfFhmI+Rrpvw0SdMSUwVZzoUmEAbM5LXbCnNbf1S1MeV16sIcxRXVDkT6Vq5GOU8n0sdOrW3qdhn1UU2iRimjRD1U0N52HjcCq0OWNg3BtAyxnfqnZFYDhoR7KROK4aULVuSw9DpBnmTyKWsPti77cHcFwxddhNSqJ/5HqOXpH6TDN31JsRX/2DuXzciBy4ccQ6LTU9y1+i0A0v5PLcOVLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6800f1-207d-4ed4-4a0d-08df344eb343
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:21:13.0954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2TCR2bNYak9yTgyNUpIbeZZPj+joXiqCNlAPK1McLbwc7VUAG/NwSYLbUx9Ub7ZIhhOAJaoq7vxl1nSIE1+gstZtnHj7cFcVfXSHuITkoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 05:17:20PM +0000, Bruce Richardson wrote:
> On Tue, Oct 27, 2026 at 11:40:17AM +0530, Shaiq Wani wrote:
> > Observed on ACC while running NVMe traffic tests: under sustained
> > high-throughput split-queue Tx, payload bytes on the wire did not
> > match what the application submitted, while headers and checksums
> > looked valid.
> > 
> > The RS-completion path freed mbufs by walking sw_ring[] slots between
> > first_id and the EOP sw_id. RE reclaims and reuses those slots before
> > RS lands, so the walker freed mbufs still in flight for later packets,
> > whose buffers were then recycled and overwritten mid-DMA.
> > 
> > Track completion ownership in a shadow ring indexed by a software-
> > defined compl_tag written to all data descriptors of a packet (per the
> > IDPF spec) and echoed back by HW on RS. The shadow ring is the sole
> > owner of in-flight mbufs, so sw_ring[].mbuf is no longer touched and
> > queue stop/release drain only the shadow ring. Size it to nb_tx_desc
> > and stop Tx when the next compl_tag slot is still occupied, since RE
> > runs ahead of RS and nb_tx_free does not bound pending completions.
> > Allocate it at queue setup (failing on -ENOMEM) and free it on all
> > setup-error and release paths.
> > 
> > Remove the now unused ci_tx_entry.first_id field.
> > 
> > The scalar shadow ring and the vector sw_ring_vec are both nb_tx_desc
> > arrays of mbuf pointers and are never used at the same time, so place
> > the shadow ring in the sw_ring/sw_ring_vec union and allocate a single
> > nb_tx_desc-sized ring for split queues instead of the old
> > 2 * nb_tx_desc ci_tx_entry ring. This drops split-queue ring storage
> > from 40 KiB to 8 KiB per queue at 1024 descriptors and keeps
> > ci_tx_queue from growing. Split-queue mbuf drain now follows
> > use_vec_entry: the vector path reclaims via ci_txq_release_all_mbufs(),
> > the scalar path drains the shadow ring by completion tag.
> > 
> > Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> > ---
> > v4: fold in the reviewer's split-queue footprint optimisation:
> > * Move tx_pending_pkts into the sw_ring/sw_ring_vec union; for split
> >   queues allocate one nb_tx_desc mbuf-pointer ring instead of the
> >   2 * nb_tx_desc ci_tx_entry ring (40 KiB -> 8 KiB at 1024 descs).
> > * Drop the now-dead sw_ring next_id chain init in descq_reset and the
> >   2 * nb_tx_desc sw_ring sizing; split queues no longer allocate the
> >   scalar sw_ring/rs_last_id.
> > * Set use_vec_entry for split queues and route mbuf drain through it
> >   (vector: ci_txq_release_all_mbufs(); scalar: shadow-ring drain).
> >   Rename idpf_qc_split_tx_pending_free() to
> >   idpf_qc_split_tx_release_mbufs() to reflect it no longer frees the
> >   ring (freed once via the union pointer).
> > 
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
