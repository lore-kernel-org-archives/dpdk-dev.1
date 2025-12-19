Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B567D7877D
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 267464026A;
	Fri, 19 Dec 2025 14:58:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F069240150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766152685; x=1797688685;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HHNiUMvgFjAG/Ocgpvi5e8TCI50gZg8dI6Wl1rswo/Q=;
 b=TJR5hmUtPJpX2p+J0OEgqDdy0GCYgQQtn2PRtbSdcIPWcB99cgaPlbW8
 nqAizS1ieLZDffSnQEDtQvuFNZUfJXXMaUKMShA1PJtkzkmTt+CD/3H1p
 ggdFi7feKD2X03sDxwC/de6aJ/TMdRRyzT4SDFHyGsusAxKG2V/LUufws
 6HB4y+Sslli95cFY8SIsY7MivxGVbbcTlfJ2uPZkdjswgFapJfBSFd4xb
 rN8M3swSLyTFgMzYE/2+N3Av294VvsUlVIf3X7sgaiaLxaNn+vGGdakRi
 a5k95/37/oLw3WJPgewiR/KpkArMkydzNPaJfgNr/xcpTMf9tTHAy6U25 A==;
X-CSE-ConnectionGUID: YjMF4WfTRle058kz28LZHQ==
X-CSE-MsgGUID: K8KomDCWQxySytEPaXbJYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68187803"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="68187803"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 05:58:04 -0800
X-CSE-ConnectionGUID: ktoJBEAWQJCU822cRsajTw==
X-CSE-MsgGUID: vhvpAgx+SdWsUFCH2OA0rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198770258"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 05:58:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 05:58:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 05:58:03 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 05:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4IowE5ric3VrZxSS8g2UgYGJrOqYbVz35lbB74+E1b1wVStjI7AqU8YMQTT+hHEUexz7Xftu/OIAhXUwWwBJ26/Gb3lCc5wtARrsRMN55oH/25mKZMIri0v8HeV6eK2S7nUrqxBfcwY/c2WNFRHpOfJdFA33HL36izBS5N6a1QF59XLUXmo3ek34Yyy/ckrHcgZHfpl6Th2K72GMsGkL7kYC8Rkj7fJpCOqKIKtTnAQB79hf1DKyi9uiRtkDvCJ9/bzfSQMiNlye+z2PtzSWxucRyU/7/itW4L0XrlsbAoRAY5zHrMtE/2TFSIG53jYJ2qZNB+XyFw+wzbai00xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QooIu9eGl+JpBIz+LfJ4xraMYXi6qUsPGiuETbdpNsQ=;
 b=jh8ySgmGz3j9oZZ3UuVep9+xzWntof0d6vjr11dHVsX6s5uONaHJIaiy3lML296kVsiwJM5MmqdbMlx1dVhJMY9EyXpT+0ok4xfiqML8gfEnLZ+1ICNuZjPHgvoa7YBPfSUsk3W9TOdUnbMVPDObiNAcF/0ehmy735loYO2bGW4X/Q1jl/WsPumyNL/fEB1ayEl0YFR84t24iY8WwGwg0tSybGBWb7ChCkR7tCyKaEtZjCrM0X5NcF7i9ksbqNA/+Qsyz5LCY42gz1ckRRc93NuwufsRJY8ZYDBhFlsaQenWNIHin8IE3+cqcEBRM3hPSbYyTU0KiFpaDyGu54TOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 13:57:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 13:57:56 +0000
Date: Fri, 19 Dec 2025 13:57:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] doc: add devargs documentation
Message-ID: <aUVZ34pv5pJ0m9fl@bricha3-mobl1.ger.corp.intel.com>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
 <e3241bd4c2224616c60b7f4b0145d37ebf612344.1766150746.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3241bd4c2224616c60b7f4b0145d37ebf612344.1766150746.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:10:36::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9a413a-cc73-4857-e9f7-08de3f069c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p5/DX0rFSLVx5DM+KKTGo+3W5UZNSF5+nwa+5nPwCP/+pPnkJ+MHP0OZYjnJ?=
 =?us-ascii?Q?PDdzh9p36RSTQX1OX6iNgT6Ok843jnpH+VT2RlzNGGrDVfV/AzBOWvPDSFb0?=
 =?us-ascii?Q?6g4zHEQJJHulXYt6EvsK9ukYadd1BonBLIZ3Xc+3yrHZiUDwU3VeDFyVp0zK?=
 =?us-ascii?Q?r+/jQTvPHUug2EWxGm0zTRWbOJb7fsWJaGH2uAqhG28m97PACuQ7Nxq4Abtk?=
 =?us-ascii?Q?2T/zFzhEk1zVKkO4OpwI9Ouuduk8T+i4zNEa4xddh2fp3y2+N2/49b5mu0oR?=
 =?us-ascii?Q?kWKSLn78/amQEC7rH943IVMxKUIoh7sz673+wLCATtaAhcYXbCSyfxIFlGQS?=
 =?us-ascii?Q?EOVF059h2Jai9pQIdGkOmdYphZKud4dUYGQmSdL3twbTydn+2+6Ci+yoVeiH?=
 =?us-ascii?Q?+PODUf43S9Yi5BQzpmILLuCDgSaOpwU0eb9zlSn7mAflirk2QWqbW3Q2eJEy?=
 =?us-ascii?Q?bC7Fh0Q/hgALkbd88iOnaBMVHVgh3ze9N+imrapntxTbBysZBYk56Ekl4gF3?=
 =?us-ascii?Q?hlihu7X/Fxw5z5ZZqsic2+PBljfz5YJP5d+vg/XfQTWDRT0NRW8XttS61+pa?=
 =?us-ascii?Q?C9wgIHuCogN0NFVtyBmOh/4a3T7oOcrNthHDz7TPfyhzXLmJcGsNiuvxH4Uo?=
 =?us-ascii?Q?xZwKQ7Z9O54ctn64blUeH6Zeob7WwL7WZcGYg1oNgklfiwtK8tQiTyRHBuaT?=
 =?us-ascii?Q?WkxeKbEhk+nrDDTxSGrNLN9Xy87rHlpc7yZJ3BDdPLMPrgfU83suNduAyBNA?=
 =?us-ascii?Q?WPpoI5WHdW8m4c96FWq8ZPuvVW5gOlv8Dr9l502kO+5MHEWVokH9gsEOquip?=
 =?us-ascii?Q?iXqqLYjBeFQ3N79Yr5oCKQkdzFQDaWLvwtBl918Rxh+vo+6LjLCCVY8byU+f?=
 =?us-ascii?Q?JkgJWQ73iPeiagdpSjJHqbB3R0ZNG6buaDX+JD1qI/G38TWxpxf4hR3CIGOc?=
 =?us-ascii?Q?giMzOOFfHr4QjtNdL4+wmMQxxLL3N4E7r/cuye+kL3XHHhUT8W3ckNrDhBEm?=
 =?us-ascii?Q?KNkkXrOYcxz1idwK+7NjwxcsDQ3oJ6Sbu++X1qpZSiC9FA4sFntEt6AU9DUT?=
 =?us-ascii?Q?fvQL9dMdml8wenHei2P/Q89EDajHjag98cwisZXxLqnqVDzbIc2ggPvCCeOF?=
 =?us-ascii?Q?BZwQUJGZNXNqMfCO70RTLnbWAvzhqjgUc6erw5imgkh8J5Pt4/Bu7Yes1yuv?=
 =?us-ascii?Q?E3uoN2OE96FruPpmHQueYE+ZQUdNwcs2TdDGu219rPZ3qhQS7+1nJYHNNl5y?=
 =?us-ascii?Q?ZZA3es1bmEii12o5vrffAmMcJkdRbtGVvbMj5RTKVQYlIm0Efoj+/Ah2FiEc?=
 =?us-ascii?Q?15HPcUvLq73Vgifb2O23FJLqbQ+r12yQtp6RvPxz6wswokbhUN2KjBRywOVa?=
 =?us-ascii?Q?eDR2NbFbEFwLMrpkSHXHdk1r09vykYD62JvB9dkE1h4GPtF/69/4RcfOrGVZ?=
 =?us-ascii?Q?LKJEfQBES/Y6GM9og/76Ri8lBdarky2d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PeiQjCnXZL2O73MUpzduFjq5c5/QHSBwSiA495EEeZqz4+3D9WGR+CJvyPaa?=
 =?us-ascii?Q?0hQz0ZFuunJKQvgzlCaTUhu8Lqy2TsdCgDBvWWfPTYyRcm5TIBehOugt/kT1?=
 =?us-ascii?Q?es+tKttfxl1zbeFPzNjlsSduS2NFpyMQoyZTpJIv5G1Np010160RZDQzDQw/?=
 =?us-ascii?Q?//fZVmN5Z6Ia7nScWUUNsfpAG5dT4vHu6ZduCcVBTONQnFmG0z0tICCzWO4R?=
 =?us-ascii?Q?kn0KQchvtJR/R2OSz+xhmVo7IUbGRABhORTBTws7ZLkHKJcGKKT2VkZ+bJgV?=
 =?us-ascii?Q?kR+ehioK3vLqTsAGTM7miQxh9F59+vMLLMo3K4vEnlZpJtwI68V8/7eD1/xF?=
 =?us-ascii?Q?9L0VoawxEyaFd1RqO3X8d9qZ/3tAu2BUSvlUUJUs+qMwfm9lXGWAPaGJx7Vu?=
 =?us-ascii?Q?hd+60poGiua2zrdfvr0XvGKWC5kZm+3p+/6FfgmRRruLyD/5DOsVZHqESqMr?=
 =?us-ascii?Q?4I0yYWVhSFi0TeHU7MOO4qaFpnQHyNfaFjGCLMAYQsADZUhpUYEcWDFvCtD2?=
 =?us-ascii?Q?GMdWe/bCcIui1BVySE7QDzuRO95/CE4lRMOhpIcTZVJHYOoEb7yIbddPFxnE?=
 =?us-ascii?Q?C2zxnyuAUmBTDotl7eWhB4bGJUnevRj8ZT33WXFtimOjwCirYasDCKFeP1c5?=
 =?us-ascii?Q?1LlJzcCTS/0a0S9QoLgu9kFagyzS1dR5ioV0aNG3YqPGr+qHRm0rD5KVuIE4?=
 =?us-ascii?Q?JpoSmd6v2Qf/e1kattHP5kFu2q45hdTxJoUQN4rW5vK9GXS/NJ1OmtaY7oVK?=
 =?us-ascii?Q?O+4rAUZQAWxqsXFahESiRt/e/mupjn12CmrxzguQzL5dLMojCkzfROmkNhDY?=
 =?us-ascii?Q?DN9LnQKjxuAIH3pevVzkrSM/ZJhG3RBQ5HUmG1wTnQ+1aqCYEKVPqqTv9OVh?=
 =?us-ascii?Q?7VCTGTin6q1kF8PZTWB3Cq36St0ta+dgiuG0L3dfmIaOn7vLWyhrlQ5+O5Ol?=
 =?us-ascii?Q?BSEWVXZRwNdA+3IzwxY+UqhiaFh+aRFoDT1Min3oRYgWYN7KMM+tmf7TRPS/?=
 =?us-ascii?Q?BBlHO324FVMWy7j0aF8hfsecU7hurjCPi+zoIUrBkRfQ+iy24ah6q1jYtRAn?=
 =?us-ascii?Q?gXE8G3Ok5N+Aahq0318XTgm0NkM01VP5jRt9Kl00rnQrze1ENKR3wAKzddfg?=
 =?us-ascii?Q?w43oX8vz5mrUX4i7qRhCjg8MORbbs/V0f9H4UDT5rd3vLJMvkgkLm/iAwJa5?=
 =?us-ascii?Q?ZzLm9WFLf5hoMd56myU3V0LhPGeDub6fMY5wq6EfkKqBWOjX6FfuJg3sM4XL?=
 =?us-ascii?Q?nf2FD7mL6ThaG31pvye4JpqT943rQqQA9Y8UCBJ9hy48oECbzawv4zQUhwyU?=
 =?us-ascii?Q?fKuMvFROVbMG6156eFl1HJfWDqTuil9U8dALBzvC6i8PSSb3rt4KnXP8YhtH?=
 =?us-ascii?Q?D5InHKdtmUlBE7L+TzgaRtikiBuglYRazRvvqyoVYELzPaeQzb1q32oSEOTu?=
 =?us-ascii?Q?7vTvDZgN32RQzrh95MBim+pXJlbpWM4QcC6GQnfHUa26a8j0Bmpef3sF+6kR?=
 =?us-ascii?Q?grnlPOIMC4javLKmg2IDM12eiyUpQ3OMJqduaavWmfbycUBZ88stVnbnFlA7?=
 =?us-ascii?Q?5sVOxC8aATiMmcvahRswbLFddwGihI49CO4tssmibUU5G514PSzUF5Rud+cS?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9a413a-cc73-4857-e9f7-08de3f069c7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 13:57:56.2182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mkcdfq76x6mU3qRNQWIGKSfe/WpE8wzj6roZmX07xKX0yK1XEHg51ID9ndNVuttTeSmp75OYpGe3tuOST5EXysk/MbquXsXEBKf5/2jLlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
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

On Fri, Dec 19, 2025 at 01:25:55PM +0000, Anatoly Burakov wrote:
> Currently, the devargs syntax documentation is missing from the
> programmer's guide, and is only documented implicitly through the devargs
> API headers. Add a detailed description of the two supported devargs
> syntaxes.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v2:
>     - Made generic syntax the primary syntax
>     - Removed summary
>     - Moved index link to after ethdev/index
> 
>  doc/guides/prog_guide/dev_args.rst | 234 +++++++++++++++++++++++++++++
>  doc/guides/prog_guide/index.rst    |   1 +
>  2 files changed, 235 insertions(+)
>  create mode 100644 doc/guides/prog_guide/dev_args.rst
> 
> diff --git a/doc/guides/prog_guide/dev_args.rst b/doc/guides/prog_guide/dev_args.rst
> new file mode 100644
> index 0000000000..a8025d383b
> --- /dev/null
> +++ b/doc/guides/prog_guide/dev_args.rst
> @@ -0,0 +1,234 @@
> +..  SPDX-License-Identifier: BSD-3-Clause
> +    Copyright(c) 2025 Intel Corporation.
> +
> +.. _device_arguments:
> +
> +Device Arguments
> +================
> +
> +Introduction
> +------------
> +
> +Device arguments (devargs) provide a standardized way to specify and configure devices in DPDK applications.
> +Devargs are used both at EAL initialization time (via command-line options) and at runtime (via hotplug APIs) to identify devices and pass configuration parameters to them.
> +
> +A devargs string can specify identifiers and arguments at multiple levels:
> +
> +* **Bus identifier and arguments**: Which bus handles the device (e.g., ``pci``, ``vdev``) and bus-level parameters
> +* **Class identifier and arguments**: Device class (e.g., ``eth``, ``crypto``) and class-level parameters
> +* **Driver identifier and arguments**: The specific driver and its driver-specific parameters
> +
> +DPDK supports two devargs syntaxes:
> +
> +1. **Multi-layer syntax** - Generic syntax for device filtering by bus, class, or driver.
> +2. **Simplified syntax** - Legacy simplified syntax.
> +
> +
> +Devargs Syntax
> +--------------
> +
> +Generic Syntax
> +~~~~~~~~~~~~~~
> +
> +Generic devargs syntax is meant to cover all use cases supported by devargs infrastructure, such as passing arguments to various layers or matching multiple devices.
> +The basic syntax format is as follows:
> +
> +.. code-block:: none
> +
> +   bus=<busname>,<bus_args>/class=<classname>,<class_args>/driver=<drvname>,<driver_args>
> +
> +This allows the user to specify:
> +
> +* ``bus`` layer: bus identifier, as well as bus-level arguments
> +* ``class`` layer: class identifier, as well as class-level arguments
> +* ``driver`` layer: driver identifier, as well as driver-specific parameters
> +
> +.. note::
> +   By default, multi-layer syntax is driver-centric and will apply to all devices using a particular bus, class, and driver combination.
> +   To target a specific device, a device-identifying argument can be provided to the bus layer. The specific key depends on the bus:
> +   for PCI use ``addr=`` (e.g. ``bus=pci,addr=0000:02:00.0``), for most other buses use ``name=`` (e.g. ``bus=vdev,name=net_ring0``).
> +
> +**Example**:
> +
> +.. code-block:: none
> +
> +   bus=pci/class=eth/driver=ice,representor=[0-3]
> +
> +The above example will pass "representor=[0-3]" devarg to each device matching the provided criteria (PCI bus, Ethernet class, in use by ``ice`` driver).
> +
> +Simplified syntax
> +~~~~~~~~~~~~~~~~~
> +
> +In cases where the full syntax is not required, devargs can be used with simplified format that targets specific devices only:
> +
> +.. code-block:: none
> +
> +   [bus:]device_identifier[,arg1=val1,arg2=val2,...]
> +
> +Where:
> +
> +* ``bus:`` is an optional prefix specifying the bus name (pci, vdev, auxiliary, etc.)
> +* ``device_identifier`` uniquely identifies the device on its bus
> +* ``arg1=val1,arg2=val2,...`` are optional driver-specific configuration parameters
> +
> +The arguments are provided to the driver, but the driver name itself is inferred from the device and does not need to be specified.
> +
> +**Examples**:
> +
> +.. code-block:: none
> +
> +   0000:02:00.0                          # PCI device, no arguments
> +   0000:02:00.0,txq_inline=128           # PCI device with driver arguments

I would look to include some examples with the "0000:" omitted at the start
of the PCI addresses, since that shortened form should work.

/Bruce
