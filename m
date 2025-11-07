Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F16CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 539D540659;
	Fri,  7 Nov 2025 17:13:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C1A9640659
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762532034; x=1794068034;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hELglYgg1M5fAOYwhfZCHrkw9H8pFFMy9m/vYmR71vM=;
 b=n1rmp9S5uBHHmfMMKlfJYXwgmBWvvekCuADVXTBc9jwZsilwKKDMMqLC
 0Z38aPP5jNaVAemJBakV6ys1iD2P8GzMu5u5dzDkKb+VcccZcUT2eTxZa
 M4wu3j53TrcEEJWfBwrMZxGgBEmaZ1eMULIyeyoG6oUv0Wz5bVRRuTYpX
 ciR/eW3pvbBTDxSG4tFG3sH/7DaEPOW0theaRnQv/cB/pcw4jIBSKATqv
 xQsJGtEtCO8PzIlcFSW4LTArouL2Tmsau3rkeAVKEdaTAX/VMzmNajWFH
 8UWZtOai6wqDoYk2O746G65WXAM0Vxi1U6h3xb3J3hY2shn63yhoqpDtG g==;
X-CSE-ConnectionGUID: pORn8o+KSmOgf6KZBsR8qQ==
X-CSE-MsgGUID: EziwpeYlRquoPLyqhpGOKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64720744"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="64720744"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:13:53 -0800
X-CSE-ConnectionGUID: 7DqnDWz8TYGeYdcdMolCNw==
X-CSE-MsgGUID: 79YJtzO6SOytB4Kfmb894Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="192331958"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 08:13:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:13:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 08:13:52 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 08:13:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMP+bJW3YUAzGvfuX/dEyIpjHvOx+9vKyo6ZFHjnmg5vM2wBzMf179JGQJHvyiuqogbbGcq1JPxKZ2uvsGZsgbRnBH37+9KSbcUAWvdoO4a1Ksv9MGo21YWVWl8+ZDMVZPJGeNcWQo7EfoWp/FCZck1iU9oHbRmx7X4HC56EzM/UyDta2ZyxwRqDv/DpQNIotyTBBaNeXNjUTo8V4LUJPLgA8qyr3rCfGNForcs3BfQUdY5ZiM6bXS3NvRZ5evpjqdn7eqnvvsst7iSN0soGNd5fz4D0LqNkXXvB6B+iiGbTY8K+FK0eCwMsp2d2K9uSOl3gQ0gHW2XKUm+7cUmoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/5X2FhV/DzpEt0FIemYNnBD9d21RarHVBpM8Sx6RE0=;
 b=sPWIOmVORRpyLTN3Jk40h6Uferw6ANY1g1aAJpqjVF3YsSnlRyNVnWDE2CqyLHIodw0crBgtjSeQSPdyWsHDR2qFNCRLTyAWmcfOl4+ekC1hkWiQ/dVSVy3QFSDL8n4EzZTALhqfiPrQanBLjfVS/ElpkSQ/19HgWFGSCJRyd+s2a4SjlD7Xa8d5OCAMrG7BANIxMx81/jwgHW5i6pKIHkbPINzpNDoolLEWWKqnCo3Dics+vEGHA3zRC3mmh/Hz03OVu8ixJfP2/duNuoqOTtgB51CIAsSISH+sBTNs61aldgU2nubCCKli+1RHQIfoANEKuzFSce6LTXQ6CBa00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:13:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:13:50 +0000
Date: Fri, 7 Nov 2025 16:13:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH v2 00/33] build DPDK with -Wshadow
Message-ID: <aQ4ausa8XHrmPsm5@bricha3-mobl1.ger.corp.intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107080250.584cc614@phoenix>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107080250.584cc614@phoenix>
X-ClientProxiedBy: DUZP191CA0062.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: be037e22-5065-47da-f930-08de1e18a395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uikboCEpDCfk57EVD8nphg3HBGYGyK7Q8Y8O+l01J8nZK4Gu5QZitnxg2kzT?=
 =?us-ascii?Q?sgm7BhlOzmpxJEjHliEmOE+zRaqSpO9nAWXGVO7tK3aDhLanz6Rq0/Idb5kV?=
 =?us-ascii?Q?n/3MDOaLYebXAyM8NIMuVrrnqKi+kW9Eu//i3H9H5uPcIyv6KoB2706O2qPC?=
 =?us-ascii?Q?apwO+svW51t0pAe1ILmc3fnHcXW1UVq5Bn9Ys9eBSQCX3ekHL/VB/FqMfim8?=
 =?us-ascii?Q?FXGDaT/WAmXroNYVuSGFQpwwMMmAiP64tR/4nhdbBgshMmSeO6LnBUcaqhlm?=
 =?us-ascii?Q?qaSO3XslbRKgmCuVCKXmz90ds+EcQG0tyKVQlbn/KGuJCPm1lb06jKPumKnU?=
 =?us-ascii?Q?RlDPKHEapaZg3GvBVwJBjwReh9OlYfOEm2yaq0a6tCsT7wL5NxCd3vS7+Xwe?=
 =?us-ascii?Q?ATO4nI6iG/VMkMiG3YAnIWhIH/RkBv1msI9klYt3n1rhmDS//ZAvyW5SRsmV?=
 =?us-ascii?Q?wfvXPLHccEN/IqbULYYk1ImGX0quyxO+GnMI9KkKyxdkvR0WnZDx2SRJdLiW?=
 =?us-ascii?Q?5yCDtizRDNwpmFA2btYICENcfRwY+qGhihy6xLv0q6NWveMDUaS66B/CaPXt?=
 =?us-ascii?Q?nqSDTmFaw6rO2J6GGx2JU+dNXPR1IE79+TmCARNeFGhnFibD94TG6Yx4jaq8?=
 =?us-ascii?Q?pvEGfQCM9wRmQQ2eqvQHZVMxLLxcW5kCQxsf3Om2wWT1LH1ajKakEEfNBhhr?=
 =?us-ascii?Q?6vhfVbXV3MHC9ZFE6xlUHkF/u594sOdMyNdYYFKnw6FillnVIFsIwi2jGEzU?=
 =?us-ascii?Q?AfM++aogpFU97ZhX5WewAqm58w23pO8GWfdQF0MNYEAKHzUdND6TMq7kbFsI?=
 =?us-ascii?Q?3j3K+OWTT+W7Ofv6W6rwKTX93uWfIIR8/A+stseBIqu92g8/UVqmc6yXVBYv?=
 =?us-ascii?Q?2fhqExZ3w1eYhsyfeRI9Rn/6toIlwhWRqcJzF4hSX8VnxC0oZDVdFAu9rOks?=
 =?us-ascii?Q?pYsABKNNrSJhXGw5zv2fcr4lvhhVGABxjtaHcDNdNhiA81LoLvaLji9jZsmG?=
 =?us-ascii?Q?Zh8f3T0TnNhkRvAS2/ew3yquvpUco3STcausVXX8J9RYDp+Pn25nNfyn67sg?=
 =?us-ascii?Q?MsFXeqYd5RrtZF1OLPnvDZ8mTxTeJ0L7tbajdeBTxwJ+76ZJfniJu6R8FvgZ?=
 =?us-ascii?Q?Luiddik3Cbgow9XDzlqN7NL71xBzJtzL9Z2zk+6Ue/zFMdcGnkNs8zB6ELIf?=
 =?us-ascii?Q?jZy3O6TuAb1RjoFPaI5SOXGgzm769u4w2tMDaFblseEMc/CVsFNaiLexsjVk?=
 =?us-ascii?Q?P6VFX6X5Tl1mb7YfhSBu3d/M1QQ1dOpAKOPuh9HzWsBuauCxCDK2hCx9pao4?=
 =?us-ascii?Q?I5qzfJva9N/qO5TpcchJSQBN6y/QzsL2tvh6paslif3t7qARVCPRlABqGvmG?=
 =?us-ascii?Q?4bx5f8xK0QrBfzafGRdk39AwrznmimGnSKeNnvch/n1daYeYEd5e0b6OxC5X?=
 =?us-ascii?Q?5/Pes9f/ZiRNrdq/RfQVhX4R42RL7wd6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjszdNh/YgKv/AdHex+mzzU59UH3GtbWB8qhTYD7J8g+iEwGcev7OAw30Uiw?=
 =?us-ascii?Q?vHI8uY1I1TQIMnClxY9UmCWqh7M0dTzBW4D+lsN3WYwHtj+ZOxn16Ydu2ghV?=
 =?us-ascii?Q?LVRdhMO0eaFEYJKKg+23xH6IInLENDn5uLPNDyEHGDStVKM5r5DmNaBMo/eN?=
 =?us-ascii?Q?gsOiQW5Y93NwVVUlvIJdpir3vTDXVli5iFQYHJ1IEyc6hApPXT1iwOIKWpS4?=
 =?us-ascii?Q?L0Zx2bCJyxFOTo1nDpBhEi/uL6AiiyoAIKdNVgxav2ObklEgFLusuXZdiWjl?=
 =?us-ascii?Q?vSa5UPeQz+KjWCYCbTT9nBUJ8xTDvD7GXv5R2gMfLG0yfgBmEDXDkf04QzPy?=
 =?us-ascii?Q?JpQGroCDVZwbuesrPrelLiEttfE038wRGeJ1aLeNW4CYEVuzcH07a7EWRiKV?=
 =?us-ascii?Q?RKYShTBBiVzuGiEeex/lXFgBpOSQcOplvGyuezzR/nBdpyhtsWPYgIPIJSLF?=
 =?us-ascii?Q?QyyVRom2n2940jRhQ1Ig3W02swsZ6EJ3H7Y0eSHDqKmcVXfxvzx5rYmpLSNi?=
 =?us-ascii?Q?mruwYsQNU7ugT/Qtiq+ppvN5FzlMNLbIsgnPMkBJNtzAGHkL8yTfbUr7hO3e?=
 =?us-ascii?Q?CiZ87gy91tdEBdlgN1Yb5Vz2RR6fdHf4t3wKf7U59hXhu6PlEQKYASIc4Xgf?=
 =?us-ascii?Q?BCvggsxfTX2bzs7JUTWJWNN8hB/sTGc5fwX6opjcv5YaOoyjrP9D5wXhuNnt?=
 =?us-ascii?Q?U+5LN1kQVQbOwiDC42TyVZq5KIwRHZHucEhC940bSWkLoXFYlCFgHrHHd+da?=
 =?us-ascii?Q?fpz+SkBJFWjk+T47YHmUbQRqJhgQue0TjdDHVGouKrRQAUxDi1x2kCDQhIT8?=
 =?us-ascii?Q?MxXj4NM8n3V4Fd2TAVDFwkmTRkidEzQ6KdsHDUPyTQ1b/bhjGALzfnImNeJC?=
 =?us-ascii?Q?SOpv0IcJcImYDPCNP4uWOC0hPYwdOdvnVp9HEnWl6YPdpUuCq95yrfoa+07O?=
 =?us-ascii?Q?ZMC5CQVhL7iOh3rE2Rbl77UkypO9KFzHTWKBit6J/RffRxNwr4SoZ/cVIESS?=
 =?us-ascii?Q?ZYFgTFYdZfKDsY/B1jt3oFb+57zefYw9YlCU6mSUzUl44Suj1jYsz1P/7fPL?=
 =?us-ascii?Q?ZVBxxiTi+TZ3kdEaTFucHVQV3bLIKtFR3NcRaq1IU59fHv+rqHFJ9Vs0t4xs?=
 =?us-ascii?Q?z5Fruc9n9E3l/mThtFrinkBDyPigp4frSK8dMObPgGlfZFk5QNI8KfIj3NkH?=
 =?us-ascii?Q?6ScAl59kcv8U4GotZWPn2jWGkBif5qEuV5JuNV0G1RQoOmcw2zDm+Rh3uDGW?=
 =?us-ascii?Q?0RTARQL0X0sLRoS6oRNq6Xd+GsALEDgu3KSlX0WnnOF42aR7bv/oDW17I1Zx?=
 =?us-ascii?Q?B8JKTg1FxMR3ytbZIiVQvGvhS4qBYhwuJ+iPY0tkWjL2n/Qtd7sHAvGc50px?=
 =?us-ascii?Q?eWEMymXcNaWYmD/jb9ukok9JTQdk48r11E4egy+kzElXdY8AonXyJP81MCex?=
 =?us-ascii?Q?/LhlW2nijv/bcCiuCKbW+W2bJHGH5lMUTo9UbFT7PaBANT/OeRXfPyAgF4Tv?=
 =?us-ascii?Q?0yp/jaQSXRbhu+7v4V578StAZOwjP7fQ3GsFi1FkjV3KJxJKiF2KDIsMGSFP?=
 =?us-ascii?Q?CEXnvfydjuSqoqK+5IFcDKrPLYbM27UCQR5csS2DIsc+ofbuJ6YtCMezssYY?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be037e22-5065-47da-f930-08de1e18a395
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:13:50.8128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqDbu3hVcQ4AGw8OVXboReMTH2NOqJt3FpvplgchpsKWYGPWWWB2bjKi70kyK1rdMsnT0uen+YKH8s6TZC7dXuPLRFfiIVwFoahq5QP43GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
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

On Fri, Nov 07, 2025 at 08:02:50AM -0800, Stephen Hemminger wrote:
> On Fri,  7 Nov 2025 15:49:56 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
> > when -Wshadow flag is passed to the build. This patchset fixes many issues
> > of this nature, but not all, in the hopes we can move towards enabling that
> > warning flag for all components for DPDK in future. This patchset fixes the
> > following components in DPDK:
> > 
> > * all libraries
> > * Intel net drivers
> > * all apps in the "app" folder
> > 
> > For the rest of the drivers and example applications, any component which
> > does not build successfully with the shadow warning enabled has it
> > explicitly disabled via cflags. Then the last patch adds -Wshadow to the
> > global DPDK build, which should prevent any regressions in components which
> > are already working.
> > 
> > At that point, we should not have any regressions and we can, over time,
> > reduce the number of components needing the -Wno-shadow flag.
> > 
> > RFC v2:
> > * take patch from Stephen for RTE_MIN/MAX fixes
> > * add additional fixes to clear clang warnings - it's a lot stricter than
> >   gcc in this regard, and flags more issues.
> > * extend app cleanup to all apps, not just testpmd
> > * add per-component disabling, and add global enable flag at the end.
> > 
> > 
> > Bruce Richardson (32):
> >   eal: fix variable shadowing
> >   ethdev: fix variable shadowing issues
> >   eventdev: fix variable shadowing issues
> >   net: remove shadowed variable
> >   pipeline: fix variable shadowing
> >   table: fix issues with variable shadowing
> >   power: rename variable to eliminate shadowing
> >   pcapng: rename variable to fix shadowing
> >   telemetry: make socket handler typedef private
> >   bbdev: fix variable shadowing
> >   bus/pci: remove shadowed variables
> >   net/intel: rename function param to avoid shadow warnings
> >   net/e1000: fix build with shadow warnings enabled
> >   net/i40e: fix build with shadow warnings enabled
> >   net/ice: fix build with shadow warnings enabled
> >   net/cpfl: fix build with shadow warnings enabled
> >   net/ixgbe: fix build with shadow warnings enabled
> >   app/test-pmd: fix build with shadow warnings enabled
> >   app/graph: fix build with shadow warnings enabled
> >   app/pdump: fix warning about shadowed variable
> >   app/test-bbdev: use RTE_MAX3 to remove variable shadowing
> >   app/test-compress-perf: fix variable shadowing
> >   app/test-crypto-perf: fix shadowed variable
> >   app/test-dma-perf: renamed shadowed variable
> >   app/test-eventdev: fix build with shadow warnings enabled
> >   app/test-flow-perf: remove unneeded variable
> >   app/test-security-perf: fix build with shadow warnings
> >   app/test-pipeline: remove unnecessary variable
> >   drivers: disable variable shadowing warnings for drivers
> >   app/test: disable shadowing warnings for unit tests
> >   examples: ignore variable shadowing warnings
> >   build: enable shadowed variable warnings
> > 
> > Stephen Hemminger (1):
> >   eal: add more min/max helpers
> > 
> >  app/graph/conn.c                              | 134 +++++++++---------
> >  app/pdump/main.c                              |  12 +-
> >  app/test-bbdev/test_bbdev_perf.c              |   7 +-
> >  app/test-compress-perf/main.c                 | 122 ++++++++--------
> >  .../cperf_test_pmd_cyclecount.c               |   6 +-
> >  app/test-dma-perf/main.c                      |   8 +-
> >  app/test-eventdev/evt_main.c                  |   6 +-
> >  app/test-eventdev/test_atomic_queue.c         |   6 +-
> >  app/test-eventdev/test_perf_common.c          |   4 +-
> >  app/test-flow-perf/main.c                     |   1 -
> >  app/test-pipeline/main.c                      |   1 -
> >  app/test-pmd/cmdline_flow.c                   |  42 +++---
> >  app/test-pmd/config.c                         |  15 +-
> >  app/test-pmd/parameters.c                     |  38 +++--
> >  app/test-pmd/testpmd.c                        |   2 +-
> >  app/test-security-perf/test_security_perf.c   |  42 +++---
> >  app/test/meson.build                          |   1 +
> >  app/test/test_cryptodev_security_ipsec.c      |  13 +-
> >  config/meson.build                            |   6 +
> >  drivers/baseband/fpga_5gnr_fec/meson.build    |   2 +
> >  drivers/bus/fslmc/meson.build                 |   2 +
> >  drivers/bus/pci/linux/pci.c                   |   1 -
> >  drivers/bus/pci/linux/pci_vfio.c              |   2 +-
> >  drivers/bus/pci/windows/pci.c                 |   1 -
> >  drivers/common/cnxk/meson.build               |   1 +
> >  drivers/common/qat/meson.build                |   1 +
> >  drivers/compress/nitrox/meson.build           |   2 +
> >  drivers/crypto/cnxk/meson.build               |   1 +
> >  drivers/crypto/octeontx/meson.build           |   1 +
> >  drivers/crypto/openssl/meson.build            |   1 +
> >  drivers/crypto/scheduler/meson.build          |   1 +
> >  drivers/dma/dpaa2/meson.build                 |   2 +
> >  drivers/event/cnxk/meson.build                |   1 +
> >  drivers/event/dlb2/meson.build                |   2 +
> >  drivers/event/sw/meson.build                  |   1 +
> >  drivers/net/axgbe/meson.build                 |   2 +-
> >  drivers/net/bnxt/meson.build                  |   1 +
> >  drivers/net/bonding/meson.build               |   1 +
> >  drivers/net/cnxk/meson.build                  |   1 +
> >  drivers/net/cxgbe/meson.build                 |   1 +
> >  drivers/net/dpaa/meson.build                  |   1 +
> >  drivers/net/dpaa2/meson.build                 |   1 +
> >  drivers/net/ena/meson.build                   |   2 +
> >  drivers/net/enetfec/meson.build               |   2 +
> >  drivers/net/enic/meson.build                  |   2 +
> >  drivers/net/failsafe/meson.build              |   1 +
> >  drivers/net/intel/common/rx.h                 |   6 +-
> >  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 -
> >  drivers/net/intel/cpfl/cpfl_flow_parser.c     |   6 +-
> >  drivers/net/intel/cpfl/cpfl_fxp_rule.h        |   2 -
> >  drivers/net/intel/cpfl/cpfl_representor.h     |   2 +-
> >  drivers/net/intel/e1000/igc_ethdev.c          |   6 +-
> >  drivers/net/intel/i40e/i40e_ethdev.h          |  10 +-
> >  drivers/net/intel/ice/ice_ethdev.c            |   6 +-
> >  drivers/net/intel/ixgbe/ixgbe_fdir.c          |   7 +-
> >  drivers/net/mlx5/meson.build                  |   1 +
> >  drivers/net/ntnic/meson.build                 |   3 +
> >  drivers/net/pfe/meson.build                   |   3 +
> >  drivers/net/qede/meson.build                  |   3 +
> >  drivers/net/txgbe/meson.build                 |   1 +
> >  drivers/net/zxdh/meson.build                  |   3 +
> >  drivers/raw/ifpga/meson.build                 |   2 +
> >  drivers/vdpa/mlx5/meson.build                 |   1 +
> >  examples/bbdev_app/meson.build                |   1 +
> >  examples/bond/meson.build                     |   1 +
> >  examples/dma/meson.build                      |   1 +
> >  examples/ethtool/meson.build                  |   1 +
> >  examples/eventdev_pipeline/meson.build        |   1 +
> >  examples/flow_filtering/meson.build           |   1 +
> >  examples/ip_pipeline/meson.build              |   1 +
> >  examples/ipsec-secgw/meson.build              |   1 +
> >  examples/l2fwd-crypto/meson.build             |   1 +
> >  examples/l2fwd-event/meson.build              |   1 +
> >  examples/l2fwd-jobstats/meson.build           |   1 +
> >  examples/l2fwd-keepalive/meson.build          |   1 +
> >  examples/l3fwd-graph/meson.build              |   1 +
> >  examples/l3fwd-power/meson.build              |   1 +
> >  examples/l3fwd/meson.build                    |   1 +
> >  .../client_server_mp/mp_server/meson.build    |   1 +
> >  examples/packet_ordering/meson.build          |   1 +
> >  examples/ptpclient/meson.build                |   1 +
> >  examples/qos_sched/meson.build                |   1 +
> >  .../server_node_efd/efd_server/meson.build    |   1 +
> >  examples/vhost/meson.build                    |   1 +
> >  .../vm_power_manager/guest_cli/meson.build    |   1 +
> >  examples/vm_power_manager/meson.build         |   1 +
> >  examples/vmdq/meson.build                     |   1 +
> >  lib/bbdev/rte_bbdev.c                         |   2 +-
> >  lib/eal/common/eal_common_options.c           |  22 +--
> >  lib/eal/common/eal_common_trace.c             |  89 ++++++------
> >  lib/eal/common/malloc_heap.c                  |   2 +-
> >  lib/eal/include/rte_common.h                  |  31 +++-
> >  lib/ethdev/ethdev_driver.c                    |   6 +-
> >  lib/ethdev/rte_ethdev.c                       |   1 -
> >  lib/eventdev/rte_event_eth_rx_adapter.c       |   5 +-
> >  lib/eventdev/rte_event_eth_tx_adapter.c       |   8 +-
> >  lib/net/net_crc_avx512.c                      |   4 +-
> >  lib/pcapng/rte_pcapng.c                       |   7 +-
> >  lib/pipeline/rte_swx_ctl.c                    |  11 +-
> >  lib/pipeline/rte_swx_pipeline.c               |  21 ++-
> >  lib/pipeline/rte_swx_pipeline_internal.h      |  10 +-
> >  lib/power/rte_power_pmd_mgmt.c                |   6 +-
> >  lib/table/rte_lru.h                           |  38 ++---
> >  lib/table/rte_lru_arm64.h                     |  14 +-
> >  lib/table/rte_lru_x86.h                       |   4 +-
> >  lib/table/rte_swx_table_em.c                  |   2 -
> >  lib/table/rte_swx_table_learner.c             |   4 +-
> >  lib/table/rte_table_hash_key16.c              |   4 +-
> >  lib/table/rte_table_hash_key32.c              |   4 +-
> >  lib/table/rte_table_hash_key8.c               |   4 +-
> >  lib/telemetry/rte_telemetry.h                 |  11 --
> >  lib/telemetry/telemetry.c                     |   2 +-
> >  lib/telemetry/telemetry_internal.h            |  11 ++
> >  113 files changed, 489 insertions(+), 425 deletions(-)
> > 
> > --
> > 2.48.1
> > 
> 
> Thanks we may want to wait this series until 26.03 release
> Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Yes, absolutely, which is why it's still down as an RFC. I've also already
marked it as deferred in patchwork.

However, I also wanted to get it out early so that it can be considered for
early merge in 26.03 to avoid later problems  with new shadowing issues being
introduced in 26.03, and also to get build checks from the CI, since I
can't test the build of every single driver on my system (thankfully there
are only about a half a dozen which I can't build).

/Bruce
