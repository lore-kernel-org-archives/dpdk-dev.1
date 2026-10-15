Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBCCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 451D6402DA;
	Thu, 15 Oct 2026 14:18:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7BBB3400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792066716; x=1823602716;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4RUdnhXJgDEY1OPNJ01Th8pdap/hhR8Sz/KM1bGS49M=;
 b=Oga3OqxeI3yy0Ab/KTz1FN7n5ckhYDtCvNtYmmNGJqQ0Fq6nfE4YRMwW
 1FoAxiUg/hOfkuQSviB1lPnvQYHzkGRzN9xObz3AWfJRnzYM4UIty+iWn
 s8l9ZhYi6hpbdPgN5FKOVa1JbEOerHRFAKKqfDz9wNsSlR3+Py5JfUYbd
 PxZq9gHKvrNmKf7rocB5QKCNQKtri60Qx+TvlrFmUCgsIiKrNtzcK+10P
 4BFmCmcq4dAxagywDfrs3OBpoLiqu97wdle54pxG+etin3UZqQlYK6K3p
 bzi0KmVzc0IECqzBVah+viehnmkzp93FwfTK9LmhaLOY3U8qhM6MiXS5T w==;
X-CSE-ConnectionGUID: hWC4cYgEQrec+mj4yFtI6Q==
X-CSE-MsgGUID: 46uAc3oKTX+O4LqTY0pQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="829137"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="829137"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:18:34 -0700
X-CSE-ConnectionGUID: k9bRBq9vTfCqmrMfb7B5gw==
X-CSE-MsgGUID: z2ZIOsbPT6W1Ndf82lEjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1588067"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 05:18:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:18:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 05:18:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 05:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw8hZuXrsNJUwrkiF8NHwFZF7kMUpTdsfTDQ74CcVZLf3W09gq4hu0yw/YhAmOV3eeckll6eaX/0rewcpvHztoI3OIROPp/UhMcvlWrqRjYBld18qqwvJZ7i0/xshm2A463VEBLIQhdVmtkUlAbmHamhzsncMQ42XLPOI1IyqxpCSF4aVzBMnyuJ3cSDtPpO9kuSv5oYCJgy077znLnrt85LeXsTzrvPDd8SmmWfu7sQTp7uymgbZdPJ65AkJnvXZUrq4I/zAZJ9yDX6fFZ0fq5jLOFuoL66dCWIOzM205LOA4kFKF12/HtIz5TpUBSEfeZO8eOC6IpjkhWgu0YpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay/vsq/4Hf5pmnJI7XWB73GCQfE1wCIEjyG0/6NYTIo=;
 b=FhDS1d41l6ts13ohBbHxT3xUEF2vhPSfnG7Y/xV2mmKeu35p69MHEMlWO/pwAok1gyxb/a3Wty6B4IC+RMajnQYKsMSVLF2Tnw7ZEqXj5gM8KUEONI+BvEshAlFyuMTIFMkMRVbcxEWsjSImT45HfA2zwnrKp2JCTKiMP/dTHWQVfY71vstfiAgEbovQ34ZaSwWWggFr4TOECRCcI8z8RgAWd5+WnzYD31QpK9xRpNoOGCe35VzvJmyh3IfP+1ExR3yp1BKZbGJkDwZga/k4aDHl5Wdy5VmSQX7nGN8TCcTlitx8VEkeBKnjW2QTJ1Uk6xDLfBCjvRCt9yYZS8oU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 12:18:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:18:28 +0000
Date: Thu, 15 Oct 2026 13:18:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk v2 2/2] meson: add drivers to dynamic libraries
Message-ID: <atDEkFQs5XyI3xIp@bricha3-mobl1.ger.corp.intel.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015112607.3008792-4-rjarry@redhat.com>
 <20261015112607.3008792-6-rjarry@redhat.com>
 <atC-kJHTeupb1Qri@bricha3-mobl1.ger.corp.intel.com>
 <DM5ED553NJLC.NBQ71EIJ8HFP@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM5ED553NJLC.NBQ71EIJ8HFP@redhat.com>
X-ClientProxiedBy: DB8P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::38) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4bf7d3-31bf-446c-90de-08df2ab66b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: azDKqSmOrpgJk7RZX6wjYKYSHD9DouKdliw/oU0VZCJI9B8HFzAUOmImsMkgqMT0Xle7NeQuYLvIKS1FaRvAjVQSfjwIMbCqr7AfiQmfL6vsn7+hWPx5lKXhTwtAqZbvN4h8YkqAOATI0hgY/8EfvWSlU+hQ82oUTUcGhpGpXTzOwmUuSKPs5XPWaehzHtkuGuQJPLRfIsJ0g+HB9uPbSWlt7YuOS+zMtbYha4ptPmOkud4DmVMDqTp3YrwFVVRrVva6zO4yDluO46WTQNFgs+yEYWtu56mdT0ZfngyLtKH+V87SBKOyqY9TEC8SWLfyXjhWTflUmnDl15+EgjLS76DXmMIPR/A3YgVyk7FYS2w89BoBM9HJNJjjbDNuW4jMgcwcPBDsh7ECbk/hOjgUnGXoPVgzg45JVZAXaJ2vWftkSvwpXP52dbeowqPSbJ65MA9zGnJIw3SflihFUnzAfmq93zC2cgCuLAmq3Oy2I5mKcSG/isQTyG5EqDpx++VcYCbwDGU6Kq2Hl3D83g+fJlLpanHsTkxgnFU5AQk2rVn5rzqgQIP+GPbMRWeKChkEBkQFwMk2gD5fPOaceP3nQcR4081Mwcy6IN1ZWCV2AphmlGX7RPFg0HDJMqYNflypcDrU0fMNTxlkoZwoSf/Sn/E7FxHI+40zFGniBfAxmYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rkWvuxH5IJv4Dt7uPdJKzt/1FvG3R3LJo8q6bb0bO9khB3EvF51b9fl/Heva?=
 =?us-ascii?Q?ak6G6CVaN8r+434xBu/LZMlyrJjsgKQgNID6hPjsUoOJ/NAwBY4CZPwYAhPP?=
 =?us-ascii?Q?B1CqtKIATQJLGG76I+u0Wdw1bf/y0SrVP6PpN0YciB3rBeUt9jB57IIwTkuP?=
 =?us-ascii?Q?dHohLlCb433J054n6Buo31c38X85m5ou4IQxnPLNbLDO9SyBde7Rrq4J7HsY?=
 =?us-ascii?Q?YiXlKw1neuOqJrD8gqTQRw5WvOT5HxD3bIoIzVHzXp19CZsy7ngJH2zyn7QZ?=
 =?us-ascii?Q?G8cqtsuTgbP1hx9rQUIuRHnQ4f8LqnGQmlyVjjNJPsScqIyeCYAutG8xjYSl?=
 =?us-ascii?Q?IAAKCcE4QUhL2ZyuEOv0T5ovAc6T2h+Y9oDFQAaznNbhaLacvb/cMToD+kcA?=
 =?us-ascii?Q?1OgtkIZnLMpRWnXskWkr/YZLniu72R7bAmIXQlStd6+Vuu+Zjqfnmb9r2ltr?=
 =?us-ascii?Q?t2246yRSofjyPo/mpH3X/9S7FzlDLz5mYS7on5id5jpoBC3vuMIZ3ORt4QqE?=
 =?us-ascii?Q?dVpG7V3VnvwWQqN3aJNQP05Qjo/+Y8d2uADTDWb6E2Q5k1UT91Dddd1SYs5A?=
 =?us-ascii?Q?HE7YfX8WvQP82l76hldcXpODAncSUqQd0Hycl3U5PHh8buGKx7ycEHKTV/js?=
 =?us-ascii?Q?veNHC29jbfuQj+hV41zAYrj17WqWzr268QgHJsRCyJWXVHvkxx+gFci/Rty7?=
 =?us-ascii?Q?9J26iV8BGClA0VVtUa30QjXwiGBOtpwuOIxu8a6PHBjMAlDUDtxXb6igbPuv?=
 =?us-ascii?Q?1t7lTBYTSVlM20iCe4rGLDcZk5Zcg1gfeDknmT2x0Vzczx1FdSXNhlzpPsBa?=
 =?us-ascii?Q?askGraFhpmPB0gMJgsq/Ax9qphdML0aqfw4HnhngWkUuEJMIYBR1lrC2X9U+?=
 =?us-ascii?Q?xfEZcmvkhx/MtQxBAkLm2BbtmxjA+ZAr3682UvWW24loCHVDbIeFg6fPCq22?=
 =?us-ascii?Q?e1rBRMlpqpe7eRQSL2ImGaOnWLXrGuA6WLIDlzLiEdGUlD9nclXU1JhR1Je4?=
 =?us-ascii?Q?o0Ndhrppd5Buuwmbesrc7HSZ7dogC7fP8cCv6Vh7B1lB9vPb3f30aEuPIuYa?=
 =?us-ascii?Q?xkYU8A+9nbzBnn78CXlI/Wrrv3JOSIz6dSLDiMGvViGO/2Bn2ZNaPpQXVFqn?=
 =?us-ascii?Q?ush2ntW9NCYEPvFAXkmMrocN1ljFwm7TJwLj/Ya8Oj8btgXGtpQV+jIzMf3L?=
 =?us-ascii?Q?lRyojAo4OZLw0qToDmMcGQLZkAlo7GFjjX1x+kR7LwLD1ZFE3oc6rtzBRUqX?=
 =?us-ascii?Q?PE1azipjzGRA/6Z8PG42V/+1x7R6E2JRSZOy7yJo3KKUURfBy/y6zUUicWbU?=
 =?us-ascii?Q?JEWe3qELh8ue7Lhh7Be4h2hIDbpLxCLd1vcO2Pl26veqcQ4tN+5auY+dqdmz?=
 =?us-ascii?Q?g3ZnwRWFN2ZExqZGbuS3FHfURVdXvtg6l3ckskQr5xiqU2dzK72TVoSfqG0+?=
 =?us-ascii?Q?O0Sa5zkU/12jlryppooY4p+9GlmcjIiZvwp5/X3PSd5Q4YUFQ4ghcqvI1Y/V?=
 =?us-ascii?Q?iN7NalyHy6mh5uECZlFvfNCv8KHO2AZ2e4aXY7slOL0sRi7qT1aUidD54i8u?=
 =?us-ascii?Q?5vfsBiB5QpTF8puItEPVlbyunJ10g0mycWtkNbrJu7mMJLb8K68ir4LFD/qD?=
 =?us-ascii?Q?CVekpHKcewsW9YtmWLfidoz8te+tt1Bitb66hWJu1y+1pbjPon/jhRYQwhYB?=
 =?us-ascii?Q?KRm3fS8QIRy7bfZy0AmKzpBtM5vYcEm6NDVzxdCF9nqyO11NXOu1T+9zW4Gl?=
 =?us-ascii?Q?B+aK8aV/BeYnYsyaF74TQeYI+yJ9lxc=3D?=
X-Exchange-RoutingPolicyChecked: wqekNO5HSyyQjI18KQnfH+WUt6nleWu05bb3HSveqAzTLBV6vIC50MDwRgDRQtJ3rL2O5Jk39aDvL4Ay2V8c7lD2m7k6Wom3PyBacVecO+QcXfBpWZf7aVYW3E2mMf6y9gBz+DXI2n9D51+6xl3TvvDEEybsuTzTThFwPo5gufj1qlSUbeRyQdw6YPfqoAzZKptJQ7mrnU/DG1NBugf/1GVOT/jouYjk1miwP/O8V4mN9GNCAKD0grOTvLM3dhr39qgBI2TIA1hYcCrzt1tqV88YvgkC+JeE8vpDUUS4cNdnFUj+4Mg+ESR8b8n0T649KWPd66yUWH/+xu1tETHEIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4bf7d3-31bf-446c-90de-08df2ab66b77
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:18:28.7232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuSJSHRIiGTI6hLkzb+0mRavoRutP/rEYbTrr9ZzGIzx7UdOimWEoPbVydVFVBGMP17eqLsp9KBIIcyf+gcHmbu6Jwduv1PlRkP1NMYaOUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
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

On Thu, Oct 15, 2026 at 02:06:00PM +0200, Robin Jarry wrote:
> Bruce Richardson, Oct 15, 2026 at 13:52:
> > I think this changes significantly how out pkg-config files are working, vs
> > our original intention, so I think it actually needs more discussion.
> > 
> > As originally designed, when dynamically linking against DPDK the pkg-config
> > --libs libdpdk call was only meant to list out the libraries, with drivers
> > being dynamically loaded at runtime. Since drivers were never meant to have
> > a public API that was generally used, I believe the idea was that anyone
> > using driver-specific APIs was required themselves to pass the driver
> > explicitly to the linker. Otherwise everyone who does not use that driver
> > could end up (depending on their linker flags) with a dependency on that
> > unused driver. This change modifies that assumption and, while it makes it
> > easier for those using driver-specific APIs, it does change how things have
> > worked up till now.
> > 
> > On my system using a default build, this adds 33 drivers to the list of
> > libraries to link against when using pkg-config --libs.
> 
> But since these libraries are preceded by -Wl,--as-needed, only ones
> that expose symbols that your binary uses will be linked. I don't think
> it would change anything in the final result.
> 
> Also, this aligns with what the static build is doing: list all drivers
> as well albeit with -Wl,--whole-archive and *without* -Wl,--as-needed.
> 
Yes, static builds link in everything, and that was always the design since
static builds don't load drivers at runtime, everything has to be linked
into the final object.

Personally, I don't that strongly object to the change because - as you
point out - the as-needed flag should prevent overlinking. If we do this,
I'd suggest making both drivers and libs full lists, rather than
distinguishing between drivers with public headers and those without,
because that should allow us to simplify our package config files. Right
now we have this strange split into two .pc files, as that was the only way
I could find to get correct behaviour for both static and shared builds,
where static included everything and shared was libs only. [IIRC, the
complication was that, when you pass --static to pkg-config, the extra link
args from the pc file get listed *after* the normal libs, while they need to get
listed *before* in order to satisfy the dependencies drivers have on the
libs]

/Bruce
