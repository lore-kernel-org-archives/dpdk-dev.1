Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E277C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:40:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91379402AB;
	Wed,  6 Aug 2025 15:40:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 277B240291
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754487653; x=1786023653;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aOdcl9fTgp6mKeTwXP1t8Kw8jabOU8l+ZEynPs7Ym/U=;
 b=WFNTFkop5Gsdji6lsnJmDLpubbmmlAx7DOdr2drk/iQKGcdrzIaRG+xg
 xzalChHu/Q4zhcuBptsi9lPcmj6xjOKx7TTFKk03sG6cInW5H1omB8Gc8
 auTWedylCXG/h9OCW3kxzoPhHcVBvOH9ix220fMHVGVvPaEbO0HVoF08e
 lBq2RX9q1XH7N85kVTAm/5J9ceDl7pp0P+1Ty7JR+RKoARd7GcHOtSedt
 zVtgj9EURW1d1dzpWcif11Ob5uwnB+FwpxeH8c5ypmzqe+8hll0AFv6pc
 qihhpEhyc7R7Sa/pPSnREP830pwGBr9V/e8+ug2Py5Ou4CTefu1IQDBxb Q==;
X-CSE-ConnectionGUID: 6VE4IRGLTPq6Ypmughe+6w==
X-CSE-MsgGUID: tgHqp890RVmsjTkteQn2Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68254640"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="68254640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:40:52 -0700
X-CSE-ConnectionGUID: /2a2C/MnSbS2/efozAQ05A==
X-CSE-MsgGUID: 8HcGeE+DTd6BeM4YzEchvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="164448230"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:40:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 06:40:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 06:40:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 06:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJclRaNeYglnIrh5jtfFePyVLtf5Gr5258DxprCxdY5MztK+uzYGACWx6zJstH2UL5QHAx2DQV6fj1KlfOBG63D8oy/3n8TsNP6smtHMep3zA6UtmZq+DcJ+agLKRG4t57FnJGvTxTbSKjL6FkLOI/QzBo960oSY67tDj8zzgWbxBuSVXxbzSYTocMDG0VaNnS7LqFV9wu4AjWJKeJr7PIiTLn3y8bErkN86hL7glxJI2d/n/5VOl9uD0imbqjiTZqqtQLt2vxHm8ydwyAXfAZ50qxGl8sf2YOJOm+bpAqSbCJX/VNCnSKCL+rT8VAOO+RkgbXEEtI+or0Gps+jUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR66mA8PLIuiEOZMnXU8I1K827jefqmmpgCyiJdNMdg=;
 b=gfXtq16fDu0EC+m8rpHenFlBfpdPilgCGE5mxnIiqyoAZi0vWfZQDSl4RXapaJXhptVLnaQxHWLozTO7m+rHSE1AlkGFLIEo4c/u6/uowmfO+03GVz+bU+VvaiwpDqOk40vn/WyYvQApHJ/y9CEo3GXFsw6TCZAIO0LwtRDEbrUQa+T0hVE9YJpjWKqlvnV1/wu6T22fXxHnzxuLnOh83sRX5NXpVC6wyBosrM47Kk0n51nbJbGRXb6YOofzW6tOFUVXIjYQcFeSZeqTNv9FfWVveqGfWrvdGmD8tz0kpBHGKrqftTR6gUBgLo6FVRcvKTnddzvaDDnfq/AJyhHUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 13:40:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 13:40:47 +0000
Date: Wed, 6 Aug 2025 14:40:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <andremue@linux.microsoft.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v4 1/4] eal: add basename function for common path
 manipulation
Message-ID: <aJNbWj-bdHaPXTUS@bricha3-mobl1.ger.corp.intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
 <20250731160041.914837-2-bruce.richardson@intel.com>
 <20250801145611.7a2ef22f@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250801145611.7a2ef22f@hermes.local>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: e775731d-da86-4c2b-7436-08ddd4eed942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C9xtqCNldEn8fn1x2q/2SaR/eyA/9oo1k77zS3/Mw+aLNkRgPEyqA3d9bv+P?=
 =?us-ascii?Q?9KKijQNpk46EP5JzywQ3bRdTplOZVePnNyMiRF5NCOsGYhV+zjP5vaN3aOPY?=
 =?us-ascii?Q?7dEiD6CXFSg6C7J7ZZCFDydNgGhPULnCdNxP3L1L6V/1GKP4ow7iZcg7twrD?=
 =?us-ascii?Q?OUfRxZ1ynEymUpgXbrhDvDAqY8o8yKG5N9HUfHD2kG32MOIqIZQG5NoQA4iy?=
 =?us-ascii?Q?bNHX9iYpX7Wdca6qdiZuHXE9tXNrptC49S9fYGQ+mFBNHUJwy8k6uYx3IgUt?=
 =?us-ascii?Q?ecB/U8EI9rHw3JWRLIIXfQv1OyaFcKBz1YXYtJtLJkaFb/okBJytubTmyWvX?=
 =?us-ascii?Q?ZBNTA81XO7fHbp3EEEuWZney7KqJFWy+RrS6nwF+Tu/AtZ+1AYkQsHvpAFYP?=
 =?us-ascii?Q?48zswDNlTGCvFnemAZvMuF7QEY9WrZhgVbqjppbRr/V3iJsIgKHtyTmkkVFB?=
 =?us-ascii?Q?HXcgiaSGgZ2xJgBWf6Q95wHAHRL7hRp8S7eZ3XfRDKd9S1veKi+B3vdI3D1e?=
 =?us-ascii?Q?W0cjAVHwSRCop7jw3HxShgihrNZsIAXCvFR6FSWrGOChtRXFMdjKVrmBJfZP?=
 =?us-ascii?Q?Jb3ea5WjTtwCQJCqoSOAV85gVbAqcU7crS0VHOjSgMrR8WtZqxL8mTG7ZcOl?=
 =?us-ascii?Q?Oj/JK2ibydHzwOzKtNDFf7HiemWepNXhjr+FUV2jM0cnGi7vgI9rob/iFQ3X?=
 =?us-ascii?Q?t0/vao2JUTY6ClGMIe8MBf0YheLC8Xr0WuHSISAiAbhlGgr4HwmdZEyB+c0S?=
 =?us-ascii?Q?Mhpn6B38WZ8+ykZA1Rij9BTzZkFua8bfLkSO87OwxoTgvMKrEEvhvMgIiAxa?=
 =?us-ascii?Q?pZYGxELABWhX1zeTVxoZLMU/CDBWgdu2lgiJKLPdrKdEkC+lUALzpXVFKr1y?=
 =?us-ascii?Q?8hNZW2OBPFe8sgIedBisOCiYUlaD5NDWN3DGkH8ZriNmOuMkMYDIK0B4libm?=
 =?us-ascii?Q?k6CIonCTkKo70bPqY+chk4/9D8uvfrC9FXDRh+2fp9I0LM9lYa5Q5EQuuNQd?=
 =?us-ascii?Q?ZX+okimeYNX5Ny8ExPawc1oW9HEyLKfOkbSGVaMrE8TWU8CZ2uRlujfuZvVF?=
 =?us-ascii?Q?jRjTkynlsj1qKQ1yGHGLfVJuDGJRJTeD3LcnbVMdkcIxuxQQI8A9h9wEYL/J?=
 =?us-ascii?Q?YY387AeP/KBeqrKDT7w8JtdUxnjS/m+u1zJfJb2PGgvGRWdzRlpbMleNjh+e?=
 =?us-ascii?Q?jcpg6QA5LillrwlWSvJeKvJpXcGdddyIQAX+RZ7voFAK2V00y0zfNhoJtMKZ?=
 =?us-ascii?Q?0OEY74NOp7PpSFKtc0FdCnLKovWMrzGVmKRWKlg7dkiB10E9mwQOA8ifrARO?=
 =?us-ascii?Q?Xug2ri1QJSQf0t2sG1GgQYDLUvGa5VtlALss4kDsSzKX71+nYJzWuERjAnTO?=
 =?us-ascii?Q?38dx0peGTrH3AqTv7DUixjb48ThCXNTPjoqSQzkfqslcSWizaVfaFOxMykct?=
 =?us-ascii?Q?PkiSftXBlbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hy6LhV8Ae4OoLhFLT9Z0cceo1Oo4m42VQcukYFwFXuLEfN1E9hbOWmgBrYt6?=
 =?us-ascii?Q?wuDXgP77OnqiyJo+b0oWp19GcOnuwhXR8MNrhMI9IwVZ/g7LY9treHJ5Jo8V?=
 =?us-ascii?Q?BSBOZ/jpiRz9JcmyEDVIcee+DK+lJQCc25yhDB43MTp9IHrAvX3Mg1124Ge0?=
 =?us-ascii?Q?dNWkTtV73iM7q6ZhZgzjQbn/AW+1QxrPf/5ABb5vqidimEQWRCAb4EiWXLNl?=
 =?us-ascii?Q?+8A9MsqoBbs5WnKXC9RMh+uTgc0uPUrdNCZHNzUy7DGVJJOsyJRnMw8Zqo8C?=
 =?us-ascii?Q?2zY+QO2FyXe/jqEPGDCcK4O3fpxVgfxMPa5YrBFSFZWyztV2XGxovfxS8HO+?=
 =?us-ascii?Q?U2NjywOxAqJk8JTBKvLAQBikF2qe0B4JQUyjDwoRlVT/7eQwIdAbQll79tfh?=
 =?us-ascii?Q?5nEOoZm4yguhH9lmx78qQqlkh7E9/OVb7Nf/P2XIsii9rwSFRkgnAvTUVYp+?=
 =?us-ascii?Q?gss0fmEUIaVo3Y4biYVUhybHEg2ax1yapfLx6gNMp+7lQxh+ofmkXBfJ+0XE?=
 =?us-ascii?Q?2COp10YROPssY0KOv+iDvG+RHaobJ3WUMciUWoGORrkfgmI8nR8yPgJt3I3i?=
 =?us-ascii?Q?UtZ7WYuROTHo8FucjK/HpU7734s2ygx85b/bpah09MQ/PYntyW93PoPUF8iI?=
 =?us-ascii?Q?c/Y31UsZfrIr5oFYo6nkTmjx3zTECrCuGLvhvLcLEbiDu+5OwW0ODhcdkVvd?=
 =?us-ascii?Q?PCAt5NIQwJnDggitiXCsuRG0ZFAGgxMm5qgUH/E/DQrEbjujyoKAmZhb0ne4?=
 =?us-ascii?Q?wPCLxjZowlwxR93tpTW5my9d9LAO92PSWr8KYdXXuu5Sh68VLnuqkSV5Vx3D?=
 =?us-ascii?Q?7pBLDHsgCuf00NzRAJJJVZAGh3h+xtr+e70zVUJIXoD8+EfxOvEa4fW894tc?=
 =?us-ascii?Q?Y63dkJSG41iKp+j5QpCy9w3gTQS0s/qJDJY9nue1PXpL2wSUhALhuP8GNceB?=
 =?us-ascii?Q?oqVl/hwgjcy1fnVUyTClb1bAXZkvUKx5+ykJn3CHavcteRrGKL2I200MoNXK?=
 =?us-ascii?Q?1Z+t7j5e5plPSsvYV3GKtRj9LN0IQOjKnXMGKXCgLrv3AwVikgxJkL9WaokW?=
 =?us-ascii?Q?vx4ZSOOMZCo5mPlV0/hU9cml6qdK6vFbk7LgM4xiITa90/rQRVm3VPcf9Dss?=
 =?us-ascii?Q?FBbhlKJygGmjeqrTOCL8kqVXskGe5wa37EJ/OghHQTrIZnaBAaqDmHlc0txf?=
 =?us-ascii?Q?mUjTv5zVAtWk98ok+U8y30pZWQo2YrcxAWLc+lsxgQ49R790oUNXMRlZIZz3?=
 =?us-ascii?Q?3a/p7Oei6D+3vWVez72uposY6EtVtxNz9nihBvbpeP0HInA4ChU2armQeswv?=
 =?us-ascii?Q?ovDjZY1D1uUeoQr5Mk0k7jVJAptT4INKd2vFN5U5q4vuF7tc0ZrwwlR9fplW?=
 =?us-ascii?Q?hU2k25j88VnpxY8gLtaCPAU8YQY5FBcEtsH01GTACsHr1FaKVKfA+71sGLuW?=
 =?us-ascii?Q?7tJ6CEnvTxSa+Cpyn6hNIXOIPye43dOKcKWz+J23V6Aii/YKQcIV8DSArnYG?=
 =?us-ascii?Q?19nF/b2aA0LUB+Krcg0m142+2F556NuP0uqXgGEjZwEgSWR5ZvnVZGMTcsjl?=
 =?us-ascii?Q?HDkrqIT0MU9ex/RQnNPV6yM5GUMKQc8xe/9FsAhz+Mv8tlQKpi1M8zOoj0v3?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e775731d-da86-4c2b-7436-08ddd4eed942
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 13:40:47.0215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Eq1DY9W+ADX2MdkGo7YH6Z7YzR7sKsn4QSYw5i6WTC30coXD1aFjpB/OrdKHxYqICG3m5xJCN5qCELkK0xwhCpFeDusB1ZSFfJrtb+4g3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
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

On Fri, Aug 01, 2025 at 02:56:11PM -0700, Stephen Hemminger wrote:
> On Thu, 31 Jul 2025 16:00:38 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > There is no standard, cross-platform function to get the basename of a
> > file path across all the supported DPDK platforms, Linux, BSD and
> > Windows. Both Linux and BSD have a "basename" function in standard
> > library, except:
> > * Linux has two different basename functions, a POSIX version (which may
> >   or may not modify args), and a GNU one which is guaranteed *not* to
> >   modify the input arg and returns pointer to internal storage.
> > * FreeBSD has just the one basename function, but, to be different, it is
> >   guaranteed *always* to modify the argument and re-use it for output.
> > * Windows just doesn't have a basename function, but provides _split_path
> >   as a similar function, but with many differences over basename, e.g.
> >   splitting off extension, returning empty basename if path ends in "/"
> >   etc. etc.
> > 
> > Therefore, rather than just trying to implement basename for windows,
> > which opens the question as to whether to emulate GNU and *never* modify
> > arg, or emulate BSD and *always* modify arg, this patchset introduces
> > "rte_basename" which should have defined behaviour on all platforms. The
> > patch also introduces a set of test cases to confirm consistent behaviour
> > on all platforms too.
> > 
> > The behaviour is as in doxygen docs. Essentially:
> > - does not modify input path buffer
> > - returns output in a separate output buffer
> > - uses snprintf and strlcpy style return value to indicate truncation
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> What about existing uses of basename()
> 
> 0 main.c                  main                       553 char *token = strtok(basename(rst_path),
>                                                          ".");
> 1 process.h               get_current_prefix         220 snprintf(prefix, size, "%s",
>                                                          basename(dirname(buf)));
> 2 mlx5_common_auxiliary.c mlx5_auxiliary_get_pci_str  85 base = basename(sysfs_pci);
> 3 idxd_bus.c              is_for_this_process_use    271 prefix = basename(runtime_dir);
> 4 bnxt_tf_pmd_shim.c      ulp_pmd_get_mac_by_pci     156 intf_name = basename(gres.gl_pathv[0]);
> 5 eal_common_proc.c       rte_mp_channel_init        628 strlcpy(mp_filter, basename(path),
>                                                          sizeof(mp_filter));

Replaced most of these in series [1]. Keeping those changes as separate
set, to avoid having too many patches and revisions in this one.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=35876&state=*
