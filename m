Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0DC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 11:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BC3340E34;
	Mon,  9 Jun 2025 13:09:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 0660D40E17
 for <dev@dpdk.org>; Mon,  9 Jun 2025 13:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749467358; x=1781003358;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bvM5ILNzLjuqaLXW32II8IivkzYU+FX7s32wNufoFlQ=;
 b=ch/9Rj4CHiQsasBhgurKQmsed/qdKGLpugLt5LXHC3fYvFpM8mJi3n67
 TU31UlNWU0VB01CmiYfLR1gYkPVSAGMQ5vQHqTOoAe63zBN0PtdBRrf1o
 cBrm+wdsgndYqREku/pUl680dKcXOTqt2T1e6Hf+mAku9U3q0FWyZZbcZ
 +7c5uHZhDZP3uwB4jqDh2eqQQ6FJYHwhCzDi5KvegbX7guROZXNUj+jZA
 PgXgTteq+01LSzvr5n/MTdXMhgaZvW1t3exZymVSTJG0jdTvek+ZF67Nc
 +bTw/9QzgsFAU8SMz9l4mn13aAt0ZdNxThTgPXOra2QJROFYKUGWhtZv2 w==;
X-CSE-ConnectionGUID: oHttQ8LCRbu8C/7IChyZug==
X-CSE-MsgGUID: P58lJcbcQfqEKVwK09BqVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="76935625"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="76935625"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:09:12 -0700
X-CSE-ConnectionGUID: qQXJzm/OS62a1tv0L+LmgQ==
X-CSE-MsgGUID: x5CwgY4RRsmC4T9JZnFtCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151298855"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 04:09:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 04:09:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 04:09:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.80) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 04:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZQ/fiTYHGiefcC15k7WuyRrPMz499ZdojsZUrI4Tjvul6UtMhabWqL1I4nZS4/zBgBYYRe0bsE1AwBswG0+SgWdmAsQVbKgk7HSy63vSKz8nU92gs6mvulht6+8B0cMZgjGc65YlcPc6EHR3a05Aa/Gx/sKR+pPuorOE95teBoc7Pvvk01UoDgghrtRYU56VmqTh8ytNLtPTH+w6qLLricn6vS4EbRnwkQ6GWFVkCg7bn1qqWwn3gDJ9uM30YTkWf1jCN19Np43ID1t4TbwzmjNvCIKu1ICwnvmdcaBho+zc8uzl6nL9BsjIXzTn/kulyXrM51X70n3zVnxxi8/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8JhZ5yJtoZC4HoHqHAuZiTP6JY5QII+JKZZH+v49Jo=;
 b=mT1EfyaTY+53bgYZHxYj34SxYTaJq+RIMLf8uah81Gf0kghnI/J9aRtRI/QQp3nAjyuHPnwWCr+bAmGRveHmCu0/1cjbTjPBcWiUfm37KpA6Nj2WUlSj7acd/SyRDUTbvHa6S6dUUgQWJwE00lUxRros5RaYhja+6jCnlsJgZSLIWvKg+tgChdgF10L+2HvxW8b9DW1QunJ0A3mgqH8B5vqKreq5nuA1eX6XQirbU25Pn+IAzcN9MnoF8wF3sguG5aPSMT2wHahHyV7qTAFJh2VKkcJJjwXXJd6MDXYkFlu9Zek7S0vpw40CTW+XkOwysKa95FP40ICXyWoze+6/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 11:08:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 11:08:56 +0000
Date: Mon, 9 Jun 2025 12:08:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 27/34] net/iavf: use the common Rx queue structure
Message-ID: <aEbAw9HVDjwMNEYB@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <56c4e91c66a52e20bba0c9e456276fe18cab02b5.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56c4e91c66a52e20bba0c9e456276fe18cab02b5.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: dadc86b9-ab19-4596-c37e-08dda74606a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pUkQKrlkJ8aD4aSLzlr1JSm5RxmTP0vLe/TWLPI5Ln2WAVmlrB/zdefBmBYY?=
 =?us-ascii?Q?vpuoL2M+Nx00gQoD5jsTYR9AjoIYqJAbcAB7HS/3M23anJSBYGFPAhOZDgwN?=
 =?us-ascii?Q?IRStGy4xMHaACrSqX5eszy/yrhGY3cpn4C5oZui+YU80qeL+pzGkDDAWLIRV?=
 =?us-ascii?Q?CxJzjmFQocRHhIEPe8AFgipplYAwo+06pwOuZJWsOjSYi+rsdfsrJgM3MBin?=
 =?us-ascii?Q?iPpYoXE99ko33qNv5ELQQ+7xsl9UC0NMtLURwSnnXqT1fv3HEhfCIFMTm+kG?=
 =?us-ascii?Q?HzxY7G48reiYNpqk6tv9yChDynxUJWb5d+4LVUCmFrPzBrf/rH+4ldWU5niw?=
 =?us-ascii?Q?FGJuQseI1t+esYZGTabrVMN/gXteCrjVtR9J2ck+TUxz/0UotYxU1V6w782I?=
 =?us-ascii?Q?GQgXcmmT58pdRo5SVJUsK0Ic/0OCnqTgQqyEI/ewzsia69g6HzofDgEw2DTA?=
 =?us-ascii?Q?pinndycFf61sHmAjUrJvtu4CPjGXwWVXmAbG4IsU6KIT2p6mimvnY3Ytl0XY?=
 =?us-ascii?Q?DJr2dTcDLSv6yNeSX1DoO+BNcp6SL25aPMEYBfiagd35eO2Q63Cs4e68FEjT?=
 =?us-ascii?Q?L4GlmTjTsxtD3AJs9y3PueD+4oG9rjZWAi6zg0cnGHnO/CuMZRkT7qLTb5Wd?=
 =?us-ascii?Q?6o5s2H8sPvn8IuSUAWr3Gg+im1uRJMxRcXLjGas7+32iukRDHwE9RlbDiyi/?=
 =?us-ascii?Q?1gc+3WY+vFmW1U6fFkDrZzn+7WMytLZZ1N8epoNwAleqURbZ5cm2BSNlkEeD?=
 =?us-ascii?Q?2sDJK5nXq+vXIvPQssyBF8+ZIjRJvTFJF0vefBm4OzfUn+BQGS624w3LvnP1?=
 =?us-ascii?Q?jJY7DbQVGv22XPWytMsC/+btZMX3f4nL8nMB0csngdOS17SkMlg0XhjZqiYa?=
 =?us-ascii?Q?eQYpnJ9DrRZzTiBxctrmYBMIO8D+xo7HVOjnmM0gH+OCI3oDAeqQnAwo1vHl?=
 =?us-ascii?Q?6T65ZhJJuUPzDl0Bt5Nm03dfytAofyPxduTgq6TtpyRV449TL0QJjx9Yl8Wj?=
 =?us-ascii?Q?XNxIyPOKUnKetHoyNp/Rvp3v2CVx8D8BJBJa/SkRfXX4hydlZE+L9yReOPeN?=
 =?us-ascii?Q?f3sP5MZMskEr78JPmeIEL2/p4jGWgr6Squ9XGSdmjK2xNvW92wZ8YFGhuXu8?=
 =?us-ascii?Q?rmVwMP9zhlBvFpUP2QyNcgRMLY2/+HbEZIodr15mVOH1DxSCcdz2wzfS1g3Y?=
 =?us-ascii?Q?j/0fm5T/mYLOypXfkY1ajqrenR+ELErHhdvRxbTJcE/rdwkkTbJVTc8i4oGp?=
 =?us-ascii?Q?ThcWVtmoseEUcQRzvLvOSHkMDy2dlecXwykcjXi14Tf9oUSEFK6gmvoykAUX?=
 =?us-ascii?Q?by4iqni88FRGqrtSKi898muFWH/ViOf2twHXlj8ep27Kfb6I3asM8vGmAwXW?=
 =?us-ascii?Q?GNOn351PUh7irJr1ULphJQdvoPzNtrTc4U3sO4re6q4rPas1Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HpwdW9SYz3iRDm1UKKRZbQ/Re1NxS/Y/GnvgauFAHCFm8fZXHaaCZa9RUO3?=
 =?us-ascii?Q?ZxVjGB0GhGmKD2UhzqwizWVZPSDChfe6QWQ1kj4MEwf2cJAPyuwylVeCqTTm?=
 =?us-ascii?Q?UyxOw2+BpBLRHzrUwtfVQCRTUR2TnqjrtKxyOyfrl8MJoGMG5wR3Ihjfh9Hq?=
 =?us-ascii?Q?mRiKNGtXstu6k7aNA52OcJ9fPXJo5l0+L8twNTdf2s6PucZVCHOUMnPwbLp7?=
 =?us-ascii?Q?ASWhD+AdkhkQ3bRefD5Kz39yr88i8K2kQTYKo0GTiWiLD+vkMppThItbXuQG?=
 =?us-ascii?Q?oZzxeVcFBkpBhuYkIJuH5Pz+uw1Fl2X/Dhb2z/yOiFBUI0OmHfakdNyb4qaH?=
 =?us-ascii?Q?NYudzHsk/VMB+7ytuMHDfemj0RhWhWBsVSUXsUOkRz+REm3Q5vvHUq3oNF2F?=
 =?us-ascii?Q?87PrFPYcbZT4UBKlmcXwc+t9f8MfDOKtLhiKUROK78rd59S7MOvp9Bgl3eMT?=
 =?us-ascii?Q?nfSiPSnbW6W+rHUAit+51vhF0eB8miiKe8pUjjjfq3lz0h0W1yNc6tuverBs?=
 =?us-ascii?Q?/tSjZoAQ7Rj7U8RNFbZ9csclQRrvBwWHQ1y2lRAaCXDSI0TthVmx1U3CkaHb?=
 =?us-ascii?Q?27HMyGWl/6qiGr1Lv7HT267FsKGl7Pe55L0UE2ss8BUOT3uh3Xqu4TXozEO3?=
 =?us-ascii?Q?wAetAiFYQGo+iNkRYWwHIlwrz8bYv8zHgkdxG8fX169xY0paoNvAtAeka21B?=
 =?us-ascii?Q?N71qXnVRASqD8b4fJ2bUNphpfL30mMzmtEIpxcaWVfL3MbCkEZuhwaf4B8fi?=
 =?us-ascii?Q?Q/w6daTHLZHCIcrOLn37S5u/hVxNl5PX57M13eSTh0IS3pcsDQ/Au/AUwWj8?=
 =?us-ascii?Q?3BU63n08eqAAx5We9GbHw9i77PktieyhPitJPstDRk9IDlwyHfySsf6cD2Wb?=
 =?us-ascii?Q?lFwBHf39n30MEwVZog5Z5ud64xEu1K8gJITC/NDGKad/s+uUQdrFyXBr8Hhw?=
 =?us-ascii?Q?u6fjcKPa7s9i+X+31ovG9RC5wwt0Ud51Ykr+J4/qVKuTb7HfPraepRMZgCML?=
 =?us-ascii?Q?IDk3wbkQEJuEwGRSizz7dcTb/xrn2+47d219tM3J2n5A6jW1OGhTX4DKE2sl?=
 =?us-ascii?Q?uW4vRizGJOL0iEulAEOS59WPcjYAAi5GFx2GRSCkIJHuE9MDXurh0USp2CRr?=
 =?us-ascii?Q?EEp7McGCJQSLpAHNiCramtCV9Na1/I35le0tjO5IeIJbRTXs0n3jG4NsRk2G?=
 =?us-ascii?Q?j91zhAMPMEAUQ52QPkNewJhoq9HLvXCmjFmxDEQ63IGUZZVNIjYO4f7TNAuC?=
 =?us-ascii?Q?8GIAj0ya9QJi4ea+CbsB8bV6PGG7FZTECwWaOdJnC6BzR5awfXvUMfxKdOKK?=
 =?us-ascii?Q?sKKQE+5OttNFnoxDEFYCEisO/qJoWyLn/l7ejRrKcfc4HeNoJ0NOa0oB1Wg4?=
 =?us-ascii?Q?AmLn29FmHtKJ8Ix8AP6BUdFmm4LhukuLzF0+wG8aMxzsV5+vITpuLEeVhqkj?=
 =?us-ascii?Q?t60U7xDqgv0jlENOi4lNpWw4agYilDDdw7bM1cxXFV6RbgvDPxq4AB2gqGcI?=
 =?us-ascii?Q?znB5nQnQsU2XFSgZQTaeIVfFN5ximgszICYXUqWI7DpshCVCnK038uxLSvzm?=
 =?us-ascii?Q?HrCngJ/W35aw3Zl0IlMI0NeQhz4xWq5C+708dfyTwlmVgUJ5L4xktg91migB?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dadc86b9-ab19-4596-c37e-08dda74606a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 11:08:55.8741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPvRmQnEUiKqkKZA2/BWuBPljqE9pez/E4P1uTszTeI/lYM8B3dWo5WoG10OLrmt04I6jDzdHgXwRLaDFfRB/n/S4KHIjP1yyhqGcYqDsE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
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

On Fri, Jun 06, 2025 at 06:16:31PM +0100, Anatoly Burakov wrote:
> Make the iavf driver use the new common Rx queue structure.
> 
> The iavf driver only supports 32-byte descriptors but they are of a common
> format, so replace all usages of iavf-specific descriptors with the
> common ones, and force the common queue structure to only use 32-byte
> descriptor formats for IAVF driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

