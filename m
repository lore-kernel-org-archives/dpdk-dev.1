Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CA606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d16EU241
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDD840264;
	Thu, 22 Oct 2026 14:57:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 629674003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 14:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792673844; x=1824209844;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Cqn9s8fC0PGy7wIDY02Dz9VqIMFM66YJbxgXHOWBoOw=;
 b=d16EU241mB0EFcJs8d9KH8Y7iZ7egNPO7zwUWX84z6snQfXD5XlLeo0z
 CIXmEmxCGPAelNyCc5bvFEs8Pm2bjUTBhclv69jjlG+wb/NSX3/c+WntA
 HdVpVq7eshXyqsK5F3ikoqiLxR2Ztq4J/eFQZhESRHczuFpqi3+NbaSTw
 XyFMF2aWOolpPuXWP6pEV4FTs73GkZCoJE6lZ6pfwb/YyFLzW8yDgspSd
 QW33RzR6QQs90b7NeuZbJxqmmw7rt8WKMHcfdlwjM2laKilXqq+kLvXnv
 51a9l10Lr7Xv7kmTowZYERTFkjsyq9H/bKq86vvqQtTh8wBW326+Ypy0l w==;
X-CSE-ConnectionGUID: NVQhvTHkQSe8kfPuKqwtGg==
X-CSE-MsgGUID: ZXQvlbPrS4q5iXXtaSTurQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1428624"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1428624"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:57:22 -0700
X-CSE-ConnectionGUID: BoeWWN0STfSTCRmy8/O7tA==
X-CSE-MsgGUID: YPWM+AW3RviVxRPeJ1Jqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3717934"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:57:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:57:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 05:57:21 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC7ru6RRJYLG1YIvQt7TkUToCiBiZYH9aN+bdhIRzHiTE/0mZhA+kG8RwwEe6ahbFtR1YooBdviOcYGwsWJifjwwwd4/Sdjf+DpaGvedAgtx4cQidNfFtMk6uqBeYMCzwIERW9JkOhR0vs6VXWQCA1KccL79vgpFKGNHHitk46sIXOCgGHOsVDS1QM/tvqE/nujNVZQ1YUMEQ6OpLbv9KWhzF1Xh+vMAaDN6AvJ9k8+gwB/oXlgBPDCdXtw5k5DpBRIwMVA+QTNR0duLg8WdI16hXoAgu1cPkjirKdw89VhdTo89VO6irdDCWECWMM+bTlGgfGlYCeLgTko3HRQMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmalQmi3GjFN1LgJ1dNt21JdMIYQ48+YQmyk36s9nik=;
 b=WgnSsKN329Z5LsBwkY8WDDfguWRqedhOG0/tnzAwji9nfetFNdrfJE2XMaQb6e9FihMKAAFAmBvt6n7fYHX2JmhpWzXP/aRpTbsOecxCgSxZkTck3EDV8vTttg8Pa5op+/+k7DlF/8QaT/unUd0mcZs8jVoltDGtJZ4DWCz6XFqyIDZPh9rOClvSsk2ebeOyHDgCzJt7CKTsDd1IFkJIY670yzJP3yMg7FDi4AyjAP/hbyJi6l/pygfyBEN/2jxOtv09uI1OUuDoAbhv7e3JxCRD21HNFv3SBaG9yQWo516700H5GpyKNg52IMLc6cvHKC2V9p5xokbWMoLWnLOqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:57:18 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 12:57:18 +0000
Date: Thu, 22 Oct 2026 13:57:13 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH v4 01/10] net/iavf: keep device stopped if start fails
Message-ID: <atoIKReb5cEShscl@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <6c09ec48e2026b535a2e6aff3a664267297b23ef.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c09ec48e2026b535a2e6aff3a664267297b23ef.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 074cccd6-12aa-496c-1fdf-08df303c0108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5OQ2ZDP6Mw6YMzb+2NmXb79254sPnHwe+GleB2k0C9oruEPin98PcXxkvlzQjsaY82o8K8kHxEcQHn/LPLA8hl4XUVueJKyujSRvLQ9aJj/CkyQGadp/for2hO/EkmSYMR21lm9mSXgvz0mdGq3trr/WGRr2F0WTmKvPU8PugbEvS3GPlnkaQOIEprJjM5uuuSqTuDPVBvbjEUxfBqT3LS3NXbe7mw44VyrrXwWR/TumY0AJOj76aJGOhVfjjFRPbJBCcKx8iHbIj1qFdp5j+MrFsgNUHz7iW/U7G4D6UOrvZIVNirh3SWfHE5hvhUHghl19ZghKldQ6/+C1CTgUhwHjZcMvsWEmFj1XKgODR9J4fFZkJgJUKqRwH8I5iuusBcRjsPUUmZc/GoI79Sc1MHE0dto5YLDN+b5o3UBqAdrQnU5JYbKIKsCxpLtnSXuydSEHVeBsvXA1qjO4WeQSr84gROdB32x14zzwoZZZcVUfFV8Cp2GgeyxC6+5sBk7FsR7mI2gnqG4zUIhuuK9rXq0gOtFFQk6H37pkCiuKP89Vkn62mh3jja+d73a/hi6QSfjD5LLuCSOxWZf7HLaoMDhdCzJEe6MNqtoPRNLkRs92fRJdfZxW1YAmA+4CqTmtFme+dpZ7mRKqMMEV9avhYqZuA7WCzECNGrLTdV1k09U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkPhKDShfaeZxIaONJdvKQNAYvZd44sTvC9lUpVGu3wUcy52BbjPV3SDJn4i?=
 =?us-ascii?Q?gZdIouwhVgX0zjfHzvKrbU8c32e3rmT3C6JElHOCCs2e3oba7rUXPi/t2k5M?=
 =?us-ascii?Q?bGMspv1kvmBTfoeAWAVoOuYUDpOrUzY3mJbdQSCvh6X7ZpQXXnpnlh8YGjxZ?=
 =?us-ascii?Q?ZUMBjDGDXNVvLYUISU7BjL9bPnwrUErCOJhDqcKClZ8FkiQ9UDrCvUOZzO1w?=
 =?us-ascii?Q?WVtTpcFf/haGXW+xxUsgrkWo35I3GRa5k58MFFji11gmDhtlKuuRrNmFkj1k?=
 =?us-ascii?Q?yNMCCL51gkxlqK6zuBYMaXVG3lo30tN1/Bz95bW54PmYtBqAZv4qIk8aUkdo?=
 =?us-ascii?Q?gA/rY9tAHkxviftXa0Nwv3w2LN7HNAcXmQS+mgpDDW7/cgl8N7zrqcZcHLne?=
 =?us-ascii?Q?kWAtqEQyBQb1JPaQ84wq7LlJn/OxrZcrE8PDy7ZxH9pPSzCFYdhpGfnABoQR?=
 =?us-ascii?Q?5TQo1GXz8cYa/LBZe1S7nVl+nzfCY1XWycH4kPbUuyeKQrut0aBExLWy4zjK?=
 =?us-ascii?Q?KneXbVK7LyvUiewKH15sCIYLe28l1y7kvvtDYfk472UlYjOVBvTijj+0auGe?=
 =?us-ascii?Q?3ChOu/qadP9aypo7DiKSHrA6jTOxsRp2tWV6J2wv+N9x8jhwrTsakMbIRtWK?=
 =?us-ascii?Q?3coaONzABkupZg72HfAniH1E+YXhrkvw3030PZ20OclToaQJea9C7a242cbo?=
 =?us-ascii?Q?VQlCoErWUqIo7OjErWtw9e1kyN+vlnlY57UJ1tw5N3D/FgaDIQz/HN10mnb7?=
 =?us-ascii?Q?gADsKhrTSd0hV+4HYvJcv8YFIgpCyr8dIzf2WTJM0lu5rXzml4cyzfYeycJw?=
 =?us-ascii?Q?cJQovgbvku5tcRK01if9cGyKEw8m04LUUPK3O2tNcbAR03nYsrfAn4qFgHb9?=
 =?us-ascii?Q?2JYOzvZgi/k3w3A3yTuz2ZrkFKlroMIXKn1sOSiHaK2TxnBewwp+N9j6DV7V?=
 =?us-ascii?Q?TlfWjsLTeG+Z5M38B87wZs9xLJ60niyyEgbX3VW30oFHa4GNXM8k3R6oAnVM?=
 =?us-ascii?Q?fNZe/DCbllLDHKtuTE0msp8GYkOPFMfoJgBLVeUSzlJT+TMEApqsbrQ/F/De?=
 =?us-ascii?Q?iMRxkRX/G0tonmI2GObRKr7ZRkqKZnMflGhs+nN4L8ZzHWj/0gsQxAoPQv6+?=
 =?us-ascii?Q?2WjQUwIo5CHnKgnfWmFYLVkP7Y78TDb9c8GTQEc3OWWj59iVDSkXc/znKZWV?=
 =?us-ascii?Q?KE+DuCZHIrO5b2QhMpwvV729G9F9o3r7KIqotLVlkXiI/3oceozi64Uc6Wl2?=
 =?us-ascii?Q?19RCtZqXfLgeN02FsbnEChOUaqdqsZF5d+gyHDfI8+BnNQwd3YoJHo5iNcDH?=
 =?us-ascii?Q?/tLX5mTor4xxN/obkCG2s9A0ntCA13t712sJMrmMHOGYC08RiArTgQQhsKn8?=
 =?us-ascii?Q?/cUOC9dJvn+l2ZPeiDPMoJjjyXGSKIAvaH8eawB2/0+KsL3RzPc2SS5vMVJd?=
 =?us-ascii?Q?MrAO14DCt+NeGXs1FxQF0xqHlyyKJf4gr0USQ7GMqAhxPU7of1hTDUzFpnGQ?=
 =?us-ascii?Q?vSmG9yGH8obA3S14DufFegnxSpx2m1YZ9Ryf+efYSiM/A9QZ+HcAZ/oWkqDi?=
 =?us-ascii?Q?DVxJWDcYqPxdeLEC9X9lIte5136axaml0Y1s8iIqF8OQxAUWfIuO2T9CvacS?=
 =?us-ascii?Q?4EsQMnKwshlTXex2SCYzY/z3UX0stylCcIHVGJAkxJI/6uAJcOlsyp8jsa+0?=
 =?us-ascii?Q?Wp0PLb5WAo6YYg349rztaQeJahGsprb633OwlLKj5+ebSMmtiMuj2xaI8D2Y?=
 =?us-ascii?Q?uXSviokDfyjXZaG3BX91rxmXGlsFaVo=3D?=
X-Exchange-RoutingPolicyChecked: 1GunTSU0dkUS2jqnoUy5e7NAX150HOkzbHqy5GD17Yzx5if5RkLZwVRUk8l45lb6N4LjMBWyQwz8Hi5ONA9C0Gcy9ZjncYyE38eO0vhFH/bFSgSoB/UyyJZnEhaRPp7ChBN25EgBQ2PS+mDBBNG/YfWVQV/FS1SGNtwCTLKCtQwSEw09pMUXV8l/x+6hXH1ls/vnzxOJrK9sS5SU49ylFj8h/WXX/WFOEDO+SPm4F8OFHcDGVmq/wII34B2tFyb1aYTkZzqG5jIokfyUvyyLYLkzE+a2qxsX9Bn4ehYJXrE0S4OtVonij9wulCK0mZ1xNGGy/lyPiFmYjMNB6dlKUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 074cccd6-12aa-496c-1fdf-08df303c0108
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:57:18.5582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7153Ba6UBCx+5dmoYIqJ7FNXD3SCcs4SeIl5Dhi77fjdPcrObI88jrhn6xVPs493mHmqeqfuxWkv9/hqNJnRw7CQ1iWxH8ZUYuLa/0ZQxF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 03:25:41PM +0100, Anatoly Burakov wrote:
> Currently, `iavf_dev_start()` clears `adapter->stopped` before several
> operations that can fail. A subsequent `iavf_dev_stop()` then disables
> interrupts and stops and resets queues even though startup did not
> complete.
> 
> Mark the adapter running only after startup succeeds, and return early
> from stop when it is already stopped.
> 
> Fixes: 69dd4c3d0898 ("net/avf: enable queue and device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
