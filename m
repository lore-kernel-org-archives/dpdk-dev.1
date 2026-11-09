Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AF606A334
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FfuZ5Eiv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5854F40BA3;
	Mon,  9 Nov 2026 18:58:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 3FBE340270;
 Mon,  9 Nov 2026 18:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794247127; x=1825783127;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mzaMz5mgYMLiFIUdMLYVFyNi+tQo6/dpxjKEUaUBqvo=;
 b=FfuZ5EivOHyRbvG5qiN9L3csW/uNqd+6H1wlatt65Y3rK1grzwxes9xf
 9ewtUYibrwXjXbhUiJJ8RN0dLhQR3otafgykjV18SEfMZ1pGYlHU4kDMc
 7Rd5E69xlHc2gZbRAXv4bgs3vkq1TgSfLOT6lT1ZkXxmEUkgnt1q+Q2FD
 hNgg91bCx3IlaHhrRiWHj6Nyhr/Vz35jZXyNT/jpPukIKnWfS18iC3npK
 rMUhmwrVJKAXNSjskx3N0W+tRMh9KksouiDfpqKWvdrJm30dYTDnVhR61
 hSxXjyqIxLDjDXYh+Ll/6Ox3Z9TFrRbyHB2sUpfK6hO2ufFIdtDzvSdjE Q==;
X-CSE-ConnectionGUID: 39Mt9yXfS4WhNBAfIuREeg==
X-CSE-MsgGUID: cY2TC++jT5KuGTTpdmE+zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3003910"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3003910"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:58:45 -0800
X-CSE-ConnectionGUID: 1GSSfHXIRp+ygEyE6opQHA==
X-CSE-MsgGUID: SYarBR5pT1KjhMuQ1TIMCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9672484"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:58:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:58:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:58:44 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCF6g5gvxMlZo9hg3kPM5zYJPem8i3lDOHEckPq1PlaLRTafS1WsEM5ktQyQPM/tJ5CMQqOIkjNU1ygjVG3C5zojgSlbLK3MQXS0+G8lFTDhyvMvPTHPzF1stMBWKXEYzex8fN303TIVW9UfQJVXxu4/Pj7c9Qr1to+wWEIOAwXZAX8ron72Je0rNztDIn6jDJ0KilKZg9DYJj4YiUzBbAbSCLy070XGlPM00cX9VwYgq4TcUl237t3uRTfeED243Z2TavQYkpgkkpcv640mfboCdtsc8YeGJXclVo/RQp4Ht+//qnXkuKeHZfwqgeMhWdBzV0MGtifw+8IZ999sYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SluIYc+uDemsaSG82WsD+shQEsiKLdq1LnC19IJ7CjU=;
 b=HzjAh41ngpeV65UsGUrXcSYq8WVg8/CDsOJ/wz7/O1//m8iFKslLrFP3OBEVKBw6piWvG19sjWrd3bbTZAixIlLWdfFyjKs/0NBP8r5SELd/miCRySMwqgXQexOVfa4QyqEVAFyZFHBVQP9xrxIpMrVRrWWv6SyLKoXCLWbx1W8fd1dTBnWiqO04hVdi6M/E7H6Z3CczQ1QMW3JdKX4xxa+UYTf1vrnv6ZPzfKvYcV6O7Ecu2wV+MkQpFknGMBIvELF0ReTXL8jojnMCwYyTU352yCHUzY3aNkTBxJdwrvVw4/e4JpzMKPejkxrkUDwKtstB9s0kkj+QrdH6Ujdt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:58:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:58:37 +0000
Date: Mon, 9 Nov 2026 17:58:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 0/2] fix minimum virtchnl API version logs
Message-ID: <avIJyFvDQRrRlmdl@bricha3-mobl1.ger.corp.intel.com>
References: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: c60f4fac-1097-47ce-d7a0-08df3e8b1438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4TQ71A8kCNF/MJYiEynzOxNqrYdbeF862LRmpadmnRHML/01dT4msC1Gexmi3llw1gi0IktZn2QU10ho0GVpHl2cmrLaccYw4rosQVOPR1c+cV78QQKhPr/NdgIiMaVFCXEPIik63wv4miS7jN25ktIrbA9/20aQivsY7+5tdgA7/2MUSy8ykfRyhWPiwJMBGsPD89HT7Tv2dQO9nzBvBH7tqq1njxbI4i3YKtYs9NHdexBQrLDKr9xsyatOGvnQI45+zNLBpUhb0K6p+40GWTilCHM/9jdSRnXjgS5YNiW/RoHr1YW5fcyJj/wEHCLO+fjJt75GwVqOJuAm7ZgjpUZeARaRxo2Tk9n6S3DDOfCVyhWBozHSCKMAOX99r4dXTG+zRvrzgXYmfCpz0/9FQ+fHqM50EK+NgGsHMgMm/KW/8sPg8GehrO/wbGsvA7EB886qf0wgIU46NozhmiUqtrHwZhE70BAL8uPHZl1NH85WQAjvA1/X4lrIvxJa7I491DCnxAnMNB1LoS4W5wZYaW4aE7fBnQ4W3kXpE+19bYWM0ieDyi9YjzHGQbbhOJO6MY2Q0MLoDvplViEBfXnugws9MKq0lFKb5k5woSX67sFe8+rvOYdheJcNI68fU+NCwB0ljJCdXUKDkm6nJiqWD0z7h+foI4bMuedHoc9IqqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kfenro8wY1uqFmaeYKVfuAemXcbyT/KgFBRDaTynzSctOF3pvtE86YRYNHPl?=
 =?us-ascii?Q?qyak6GdyvGVa3EOpLkmvU8FkEa8z5OZoUuiS6mMdd7l8Au0JLgCu9wH4ULjn?=
 =?us-ascii?Q?7SkYNyQJqV1ClQ85nHTSl1tsY6LBPmuOhYWagRgYqsWo3uUgkI9WFfyy74aY?=
 =?us-ascii?Q?st777GrR2ew1euYMipjoGlbWunpDeWpZSnlVV7Sgqy13alhJ3gF19OkB7dti?=
 =?us-ascii?Q?wF9rhUrd5C7pyp93WAa2tzfzqkUelWY69gLlcDbbfdqVL7fmXrHiPYJ55Biv?=
 =?us-ascii?Q?KJ2DFjmEWBxZAxYkMOz37+dvSEk5HYVL87oAnkDpgvxUVs7g+o9CT5d/oIqs?=
 =?us-ascii?Q?9YCCrcFodT4tl65vUl2jomTr7iGCSMcEpxTBFlpfL3Eb6sfmsNQ+vckZF9F+?=
 =?us-ascii?Q?1k0Fl3sWu09zc/x8WImvzB+zRW15gNtksHj+zxU7+BVlctQ41wVMzwtrFsPe?=
 =?us-ascii?Q?FphTyBV9FcUNXb51K3fU+HxO8smesUamY9n5n4kvUag8La6SqZ63IemVpiYf?=
 =?us-ascii?Q?TeQi1TaxjSVmcggOc4zE39UiRI1PKmKlvygNsrnaZ6Ho2Wv2/3T3HoS9VfPX?=
 =?us-ascii?Q?uvUhDe1O9SbQ8+bWJPtTZnrl+Zoqo99gGEgpHJAZM0zaxH9aUDXkhWiUfQbM?=
 =?us-ascii?Q?N53t2mrRMUVS+pMbbbuhDf3X9MvHNcQhLVKrv1JM8zbYi92/xlk7TGnEHOZV?=
 =?us-ascii?Q?JDW32worZO66MkNclPeJpEO2SjfkFSitf9HPIiouvJ8VBDwG7HdrYNxi+goc?=
 =?us-ascii?Q?N3JJHA7swPoRut9LQFo8ZzucETiq7JTh6OoIhCbcK5XKFVVUWzZxJuCWfgd+?=
 =?us-ascii?Q?UIRERvEJqAgAxggVJ3hFY2q5LbXLPoFf7+CrGO+JAWN/kO8EtYr7Jt+0pEqY?=
 =?us-ascii?Q?OM5zCrepcfx5aUhp/UL0JMmxixuSwg5rHvhG52m4dv5PiXPluEalXYUQVyUl?=
 =?us-ascii?Q?qX2G3ApiV4L92AsCmI/Uls66QslXIkK5zPL9crm7vf/n7nP92w/mJWyb5A40?=
 =?us-ascii?Q?KL5SZwE+TVrZY5LWG4LJlUYMw73BbasSvULYXaghVSsE/aLw/TwWyBe4RYwK?=
 =?us-ascii?Q?iyUk3eJgCWMrmaIrOJk4FqdlxP6Zas8ndbhntVvkDvOpj18pXHbcpb02TwBQ?=
 =?us-ascii?Q?ewCT1LPYVpmqWK9egzCADDG0cK+RZOwjeL9yrCddRV/wC2NmOMAph38Du4KQ?=
 =?us-ascii?Q?YNAI/OYkohyvnAczVMshP6piH+OIsktGaTp7hB7zx918xOWMYhdwUGSY8DN0?=
 =?us-ascii?Q?XBjwqOGw+j7c1IM+G//nMBcci8MsJSW6w9GPQ6srRUJvy1x7FtSI/nCVqTgs?=
 =?us-ascii?Q?0723I12wPcDG1ehvvRJLsaOJfdaQEk9uzJxE6MZx0jzU7fVkU/8AJcrZhxI0?=
 =?us-ascii?Q?74Am63RNR6kzs8FiTJ06driawneXbu1Q4V89K4gOzOFWhZyYJjSfCLT2Hh01?=
 =?us-ascii?Q?RF5TJ+K0xV1gQm4Twnp5st7RgpJFFsJTbVrsof7NjmtfYcEAMuKLhARtWC8Q?=
 =?us-ascii?Q?XjsLOwHsv7N5fLngAWH6vNM0zpJqbiJbTOk5uJ3JX9PkAAzfSErBtox0OMCc?=
 =?us-ascii?Q?ZtQl8csRTABo4QNZ0N0IOLNl/E/vhkCbVefURXYAB3LtqkhnoVlhxsMBnFyX?=
 =?us-ascii?Q?A+IQoCE7LZr9cO0ER8FQHXXma3w95LpUEdyl3A3IKbVkhzu3D71mGQp4BeXz?=
 =?us-ascii?Q?tXW+cYITqzYqgJPPhbLdQbRwLZtyylJrcGKb1lr0d/UwQYQqRIoi0F+CNi7O?=
 =?us-ascii?Q?Tb1AJPcWQQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: BxvDExEMtW1A9afyBURy+xKy/8NJsPUKhUlNr9kOFkI1k1bnjOG0e/1fKOIGZbTiVyWxJ6lIQJwLsCgvMm9ikazXu0hnSlyTIJp/ZIrs56t01sZLZZeXiofC503dEwmqWyu5Yn0XGGAoRzqf7kJ5UZXwjjOtirXcYr8EzC8hLb2oFXYzBCADjJsigatVxRlzLzi2HDW0lYjL6re2v8ZPVCdoKm57CuRpMWLeEaBJWfAUtdEijihPuhXas+KjHQg++7l3NzrGI8Yq9N8TPYaD1qI/9brQKEw19Ue6jGas179PPpEhuHrMtedJq7UzZC4ynoG4Eb8FvJVavgYGPpkObg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c60f4fac-1097-47ce-d7a0-08df3e8b1438
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:58:37.1509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGpbib2sF/eQU26kx8TA6tDe4gN9DlnWKNplcxSgt6Xbf5F7C7hpwIooBlKMdOGhcMTi4lpq935U74rth9XnyveuzTudgLsjT0YlrrUJWX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 12:45:22PM +0000, Sandeep Penigalapati wrote:
> The iavf and ice DCF version checks compare against the minimum
> minor version, but both error logs pass the major macro twice.
> Both minima are 1 today, so the printed text is still 1.1.
> The logs would be wrong if a minor minimum ever diverged.
> 
> Sandeep Penigalapati (2):
>   net/iavf: fix minimum API version log
>   net/ice: fix DCF minimum API version log
> 
>  drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
>  drivers/net/intel/ice/ice_dcf.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
