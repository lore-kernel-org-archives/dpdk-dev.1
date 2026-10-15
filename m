Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEACC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:36:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913FB400EF;
	Thu, 15 Oct 2026 12:36:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BF3BB40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792060606; x=1823596606;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=H7g0F9UK5blxetRQOVeOMi6OTIF4zmFsacUyC/dzAaA=;
 b=RQD0FpNVTFF5v9iv6wUWGzLbQnz+wcwdyDRONUc5a5eW2BbDUYfepv32
 VCIfI3RAP/4rvs1V5MHR58iny7zDUcZMYps9DY6KyUVf8EqbhpPMwdz90
 7gtqIUbt+xXCy9YSjL9Fguk7haiLeu5CwUZI3pD23tm7v6yloVz9J0aU5
 tROBoTGmd2DGHVZzS9FJ9btJaWJ+1lBBdtqrrqaT4UzDr4Cx2mRhfkcpD
 z5I2ZxW5nH/8K+zVI48hlYmDfgDkV0W6xwmR3lT5PV1CMy4TV1sy81wHw
 8UJd+Rdix+LEivOmqv4LTfan/d/TmrwLrm8ELQNgIGfpST3rgqeB+9123 w==;
X-CSE-ConnectionGUID: abv1nkmdRd2wk6XQ9Qrnjw==
X-CSE-MsgGUID: MfPSjcpxQv2GA0WAEENvgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="836794"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="836794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:36:45 -0700
X-CSE-ConnectionGUID: cFeLUegFQnCsqgwM5ZV7Jg==
X-CSE-MsgGUID: sDpUpoOGSHmWygkGSJmnxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1625535"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:36:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:36:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:36:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL9OJ08Rq1UWWukWbgiuT8/Ps9Ps3pbYT7aXNE47gnf8m4znOik7VYP8yCTOGLWXuDmgUOZLlE0cmzVCzS1jRhOjmdZQqcX8S7hw4BWVjKQFEkksmIWN23ILqxlfbKbCReejuydAVQISYSSzmToYghGCmCshUOKzoknLCeRWfpEPfVX5QUd+fhpPWsgCKDGLazu1lqotMZKRSiNldE0530qClIDqAonAyycXZ8rcqR6NNp7XaD/7YvFfGKNvS3aNhHmpSJQPF+3RAUE40C5dmHch4cZCwH0ipwj652p1KIxfi5QXMNNTQHyZmTZPs1fBtOiIgJR30iIOo5L+oe2FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRoC/tTuTTLrHCkhgMBpBQcuvVaNyKGunBRKo4s3cI0=;
 b=njH8EQA7M85CDiAUbMpx8h5xzhPvXiZjWSrQ73GSmool7ZPqtFsBGUDLhKiTNBCxqLjgOOh5YZVXZdJanzbIBSYw1zDmJM6/TGaUOvpEaMOrd4HGRdEWHtaJOfYGhGq93ym0vxZH04jCLiMGdWn6NTDPChNEUyhWkG05MwUbkg4YbLEbn6HZvLgPCPe9FaiVYpjHrczd+CKRlhJmPR//hMBZxkR+Qh/1tpxrYRvDRfO9WfpAb6dhRInF/Ot51ddCyfVw/omX8DRLCphtYXBDFLpWmnwgxxnTrBb7PmH3HJZoj8Ouhz5Ja32CR2ycabLjD5ybVzQOL44BfviBZ6x6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:36:39 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:36:39 +0000
Date: Thu, 15 Oct 2026 11:36:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 1/2] meson: rename static drivers list
Message-ID: <atCssvmXqgMTprHD@bricha3-mobl1.ger.corp.intel.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015100921.2944274-6-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015100921.2944274-6-rjarry@redhat.com>
X-ClientProxiedBy: DUZP191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf170e6-7862-45a7-88a4-08df2aa831cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9X8160aTJwraXzUkz7GL7oq/G4b0imamSLVw+gtLLDBQX2jS0PZfpqmOp0xHyHtumaP8XgoAYLlkI1QB2lmAXHg8zjqCCFTs6ekhQXlDa6ToayAXMDjS4msY0r8BfftQy2JmqrNxiLg16REdNEj1n8kPmJIwujgg9T0k+zHEaLvQUJULxkL6casfw9mjxMs+YJwTX+7efyXTPvkFDtIJ3RbMS5rgcoOYZGqjMZW2GeqkXVIgfs8mDFIF+P5buYtcHtcP6PUi0MQrqzqxh7NIKt2QCF+MfDmVcaWFEksF7dZnZn/wV+T3CJ+3bDbEf/cMOC1D6pHPqzTxEUuOseygm+60EiY840bzIugOj78fsHc+3pUoUBEthX2OL5i5Ytqbil0O57VF/0XipHnWGFpxE7CJ5+cytRf0Q4fN0s77bR/WKtZVESsg/T3DJj5OnSmMubl4uDEXOYEFgjeLEjoR2qzMrj2QDmEGd2dKrdm4Fvfp9DxFLa7zT9fSsD0rjfHt3DwiwgE7s4Ns5qCt852uGQs61bVdFPLpCD7EbUuxrYFx7jGF8+FOnEswDMG3eZfy2behw0sRiQfn4leaPw08+DNgahxO1DOuPH9ZGJVVWu5Ai1dClBqPrdv8jzRNlssv5sP6LPUjHcUHvGzXrfmPfhHxx+zoRJHfXsyfEHFwWdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DX/sguRiaVunw1OcDFG38YjoM3S1xUO+vNfOgcnnuQrDNf8GFSEbDXX0JO7p?=
 =?us-ascii?Q?60O7lzw5PkiPDmyiNRGhivlkn9kQBsrIRDMuiMmZutkHf1wRnnmI0LD7ZpL1?=
 =?us-ascii?Q?EN6p2z8CpyfQEbpxcvJjobXvdTFMJW6TdkXi57J2xabKbCwtyYg/ZclarA9n?=
 =?us-ascii?Q?PzdO6tFFmnRULxQNmDRi2J7wfVJJodFoq/eYV6xl2Sw/CBoaP7zpBhhWRYyh?=
 =?us-ascii?Q?kogr2oQxKUrYCtqVNWnrLB77K+8OClCoGtpdU3qqa9kZxkDi1XUGsnf/zsZn?=
 =?us-ascii?Q?VDxX7kqK4Dr7FCd3vbPykcquQm3ZZRqMvs+aAOYRl1L2CySm0Fu/irGFPvTO?=
 =?us-ascii?Q?wnMu89EC0WlF32q1kNRTsBls5beeymhbssatzKqDrrP2s2v4OtE1qTDnhads?=
 =?us-ascii?Q?yll8/Oc9/aHbGaPU7NrQ6L4x+oGeM6ru3aqW8s7m3H96jTUN2VaLpVeLX/Q0?=
 =?us-ascii?Q?vLzPq5rtVhyOvLY8bqsTu3JJbCdEj9uOZYu7W8Q7KZGmhT1/jyGluKjMruTG?=
 =?us-ascii?Q?/q5VHEYy3cTu/8KKk7MBkUaXpLkXnaf7he6Xs7mj376beMMm/sJzAijFuUyz?=
 =?us-ascii?Q?26W3+BJ7OH0uuRFQbyJo2iYjID2vQ0MioKrd566BKXJnrp9UMqyJ2NbUSPyw?=
 =?us-ascii?Q?6zc4Freq27B/Du4uJABDFETBsO1TPP7MTmjn5OZ3mmEMMDiAFXobhniJAjXq?=
 =?us-ascii?Q?xOXhr3Tjx4BFf4h7IchtFr/GB1KJf5He/sQaCxnHrdkbEYqua1ADCBDTgVln?=
 =?us-ascii?Q?KWyqO5aXLcWkpbtzrjLZl1CcZ3wv6czx+ozq6A+RHBGzslBLEPIWk6975iFV?=
 =?us-ascii?Q?8Eel9D8+ec9I/hS90EkGdU6gpcv2dDTBgx2jD7pGzJD1hS4KVN62fI7a08n4?=
 =?us-ascii?Q?4S3eSPS04i6FybmTktbggDwYEbg5dqOcMagjTKuB7kIHX0YCyuUmetFWu3sF?=
 =?us-ascii?Q?6LoErxMyvglxWA3k67nyS2XGYzbNxmNoCtnPpvQk59a53DW6VFX6CyUC3e4o?=
 =?us-ascii?Q?zVCbciyd6iIKQUh14leZEVPj0A8kbByukgKGWiMZXS8Ku+ccyeKdbW4ERk+y?=
 =?us-ascii?Q?i7KIfQMNGAS6r9Iay19hTCza6VmTnfrCdQUYINOj97ozznyOkPKbn7VEOkc0?=
 =?us-ascii?Q?UD7Lj/Fcy4zCI/17nMYF4ynpJvyf50sT1/vXCwzL72006i/pUR5AovlomJuv?=
 =?us-ascii?Q?R941QjtXsZseWbjRotjvpX6dL6S+pFmb7Z+3mPBVoxkhaYGBeAiEaDR28K4g?=
 =?us-ascii?Q?RgVqeeugFNwgX6chC1/01vN+xokATRvlI1eifMdRF8VZJDtmrDAde1kib9tq?=
 =?us-ascii?Q?nM5fbqN6ZVgEnk3FmWYvOWVck88LHE+xx4Qw0U63sepCnEAlR6hHPvchRsI/?=
 =?us-ascii?Q?cTujIfNdHSB8EJFnysB6hxzR2bdA14XQH9zD6kINBHFa/4ni3WyvS2OFR8KA?=
 =?us-ascii?Q?wTEWQf4u/kQXNYQlD3vWWRMdEEDwuZY+zweQUW2sFE7weHPo+ZlyEeGf9mDh?=
 =?us-ascii?Q?AjrNHtYDbdeS5PxwTs1XTn9Sp0QF4lXSU80140xy3Qrd087XATYtPC99G7PB?=
 =?us-ascii?Q?y9ryAzsMbKlZZoUudmGnWtoN83qcDWosBk7sDRR9V9YbtVSG7gRq1/4qfbY0?=
 =?us-ascii?Q?gZbmFxuOQG8S4Sydu0cTw6t4NA9ihh3HJMyjRkQxY3vub1rdZnfefQWgLOzn?=
 =?us-ascii?Q?hZc+EbPrHeq5SHT/3uDx2Mea1ufn5SqZ3klZd7nrSo95H+oHBmokMrkBGdiG?=
 =?us-ascii?Q?UjT4LMofiptruWOB2sUEuHXpcWVIuYw=3D?=
X-Exchange-RoutingPolicyChecked: C1zIj47FVEMSEnfptnq2kdaGcYQjxtZ86FPiSiAwqKHrx/U/7VFQEAS8Mecyxct2/4J6S4ppmIE6X6DR76lPr2Uw1o3pMY6S2KshtORFwyR5TnmUBqUKlpYhsr+nyqJp4a1Smk7eYpKpCqj153VuyXqYPkZ2kSa79jkB/vx1wli0FC/z1PlNcCyHocosRoFfYPSqzgUVAJ9hhNUacWKftFEmOcgjcKnEtBV98gbuTCZBF+0oWCzmC35KGtUqZpJr4CoeR4Y+P0Sw8E5Uucfg+LIFyiISZGlJ3x5SHFiMWXNei30HpOLpXruO3mdhGb2LLLVa8oQCfCWWjtawYBpIjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf170e6-7862-45a7-88a4-08df2aa831cf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:36:39.0664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LHwS0Ed7/JCqGhogxB4pOZd8nx2dCQmc1H5OozLkfWMHQEGbjsXDSDEWH/SHgeDMY9kaOgEUNEWtZxiOv/Nid23sPSfkneKmmaQsXVPLh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
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

On Thu, Oct 15, 2026 at 12:09:23PM +0200, Robin Jarry wrote:
> This list contains a list of *static* driver libraries. Reflect that in
> its name.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  app/meson.build                   | 2 +-
>  buildtools/pkg-config/meson.build | 2 +-
>  buildtools/subproject/meson.build | 2 +-
>  drivers/meson.build               | 2 +-
>  examples/meson.build              | 2 +-
>  meson.build                       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
