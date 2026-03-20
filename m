Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD781098786
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B42402D1;
	Fri, 20 Mar 2026 15:31:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 62F55402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 15:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774017082; x=1805553082;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4uyHESEqUi0aRLJQE36nJcv/XajkGC5Y9CtICaPGU8U=;
 b=Dii3dOvvreVvrCDikGIzJtLfdW2z/L3IS3uo7B9Ue9zNAfZmVIiRVAYy
 gDzg8asGzKjpsqzd3Oc39+Jnzbou0PUM24nRHu3hF65UdVyo1NB4i2+3q
 VTsaiiF1zlXMOHxkKsXW6Y6W4c+Qk6h6dMEyaX/Q3ei9aXi8CYvszaJ1+
 xmXVFwFnc/jtv3tbcJCki6vLm01jKa4GJGJ/QXPGzPgV7ajozKYNZ1dsQ
 W5wZlFlhnYcMhMDAg4L31hwd4FFvSuYty7rXSBuoCtUSjfcxkzYhIuftb
 8v99Jh7CghFY8tJhaWCkHLMfF5jGez7YMJ+kHnF9iFpMyt+1KcW9jrank g==;
X-CSE-ConnectionGUID: m6Qj0w5GTBmeEyCMWIKJUA==
X-CSE-MsgGUID: 7ZvK/o14QrGoUDWrqP38jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74804727"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74804727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:31:21 -0700
X-CSE-ConnectionGUID: UhpFbfZsSQujxKu5YKzvzQ==
X-CSE-MsgGUID: KORlAp66S82DMAyfl3VYNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223324681"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 07:31:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:31:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 07:31:19 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 07:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUpKsJA0dHPu3WB/ALqB2vJj3vYg1tMdJ1ouGYK1R2BOQrxp8zPNNCWjEJlm+qXviFrfiKOa9Zf0F7egkwexfgQQISsvBPMk7BWsU+4PUdFq69Stg3aiWOjRcKkP2NiKleVpY0/iPvPOfu0P/nZkS/IPgQQGf74uB2g0TeaKipYix8my9zKynH7x4epl3OSC1UHlWZdw54evR0kcqLggmzeiIESAyHA/T3OVor0SEKfGYpyOjJ5r1CAndWuh+O27vqHOFO/p8UTWlaauz67KnOFPRTpLBEd1xeuoX72nbsGavJ6hyYl4IKWbpOVDCLSRRWcZp4bgIy/CUdIqYlDSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS4A/GM0dlIFNKz3MXTH4UhNSeOv3x8VES8IrV1xi/k=;
 b=D4cvQsWeVKO5zXkWFoPzImO+XQPT1yZrTMWubFC+7abTmMoUQFPJa8yiYF679H5ZcPaEEHtAVyge2Mo0F0iOm+9E70o1Y/FALyqwNwFUd7jhFrXy7V/2nkNarduYXdOOZa0G9jkzgMCAcoLMyOS13cp2fM/6jeyv92y5P1QQ+s9QsH/0tJQq8hTPvgollP52oluSMGaGT1UYkOwBn2/rL+n5NeN8wcXFag7c6T0wj//y9/ioVHgMYJ+UaED5cvWyjuDlqYB2b5zpS59l/vSGVdc8rAvV9R4ayAZ/LlryNE7jyOuSznlqgAzhijhlqdlgwUkZHlpIbdjvn1VjNIbxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 14:31:12 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:31:12 +0000
Date: Fri, 20 Mar 2026 14:31:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <lylavoie@iol.unh.edu>, <probb@iol.unh.edu>
Subject: Re: [PATCH 0/7] Get fast-test suite to run on FreeBSD
Message-ID: <ab1aKo2xDOuIBCUm@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <CAJFAV8ynEzM+h0YTb-ONxqTcAzhu4hfj6yE0ZQFTZAi-9J02RA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ynEzM+h0YTb-ONxqTcAzhu4hfj6yE0ZQFTZAi-9J02RA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0246.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::11) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffc1f09-ef13-45b3-2bb4-08de868d558c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 8Sovqq01UYyc2hVShjOyEzjM7nRQbOnARggjTayha6l7p4X3HV52+gwy9AfBZBcUEDKPdTuXgazyWf6+DCcn2t0CFSyGmi0XYSMjD8aCul2/m8laO3M3tmdrL5NabzXq7yOf1uLw61SRWTgmaVG8fpeU7amCJVqMbpBEwmd2Z22yh5Ibesd2xlPqAx4eS3OPENlSBZUnd6wfjLm1DMsM/Eypz/NGLL2FDp9KSE29JdyXb63KPCvhidc8oYCpA4PKfGPnZrxMa6hZk9w6kOMI6IWObPCpY6yKyxsW7tsJQ5l+CLft6bKV7XiX6dhVQ7s30c0n7t3+Gdv2so2tskJ+SHuOUh9WTeLlJJoRyKHLUNGePyFL3LrY7YVnP0jwW/ESuEFztr22F+alV2wxcf+6+8/0s1WaGyADSKoned3Myj6Xp28a9sCiTVyWRqCnBol/SbVF3dDHksVXz9IB6yVC7thCE+LZkD2hGpay97cu8R0YnEsNrru9Lmxes7HSVtgh9TmcicdUco3IpSwXlDeU8kAZpI2J+JtUE1reXC94QFQ5UI6IGf8XWzEUNAIRYCjwWxDxpRITugdjZp9M/sxMmM2i00wBXgHFNHx9rFbWXxInsWM+kq1LJh09IsLJYW2/fRl30RZLQZsuX9+FaxwcoxoW574ghKHl+sW+asfRxl/M4O5yTdslzw9QX+yCwHg4WJq9NmdGIeJeLSxrNpl4VCcXhKlQTL+QyhbTUm/P1tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z30qOP79xsFfvJIoq0PXFvubEE12jnuh14zuhqP9vd0Sp/oAbVMb5WbSr3ds?=
 =?us-ascii?Q?XTdHAYk8/XKxYd+kkAlwJ3yPgitbdrKEdpYVHh0BDBT2K4jdEicU+f6505s6?=
 =?us-ascii?Q?Yw9ojVXUHA0mBU1iJBuZu/VypZjHKpp+AFxZlJhHxh2j2m61qSWVy5E5Dtav?=
 =?us-ascii?Q?lBYjpjwYTuAtbfU4kWx9xg0iIph1CeyigYFYWJevnJ8D2nJ1kCl5HI17nhZJ?=
 =?us-ascii?Q?A6B0JiwE2NXfUeT+t4WU2J5NGqSaTRbxx9qKTTRHjVW+EM/DSFPIpIyMp5Sm?=
 =?us-ascii?Q?w+zux0GK/6u1ITgN+CoxMuC8rOrYbqHMBs0ZWVawLrVhGbuKnlXw6VarPnix?=
 =?us-ascii?Q?rxMRZEWQD37nDXAnikPfAx9gSr6I2SDTFH3jwR5KPp+CcoX0lezLWfV3HIEZ?=
 =?us-ascii?Q?brCgbpqkS4Isru/LDBJE8PrEeg4VPnvK3Qm52OBpEzpmLLhee2Q94V/hIFme?=
 =?us-ascii?Q?//dhUcRFuzKXbppR4N5SpA1MFKF7S8XJ1vOVbTW9fucz4MSpQvagxe5Yi0bR?=
 =?us-ascii?Q?D9pWBd1xGECdUGSNg958XSGl/SfrVrxagatxP2TCsq7U4e7E1WY8pSzQT2jJ?=
 =?us-ascii?Q?hNvFj3vfmUbiQJIhViQcubUFtQtfazFqlfnB8bQ6hJ4hSCX9L5yk2m8KEPEL?=
 =?us-ascii?Q?ICGoD8asuvrUDUVjoN/i3T/434FOu5fNVwPFeDYav7idetPArVWpoN31cyGN?=
 =?us-ascii?Q?n5NmdzIKQn2sYxnOS4GapMKF4tUW/OgFoPLvwHtx3DxLzbCVbwCKLlCUOGL5?=
 =?us-ascii?Q?fTARgMlOcuGTsLHNE3rOfdQvPtMIPirND51Xi6XjetL74vqEc0UzBGfPcogx?=
 =?us-ascii?Q?Rwo+3K8Hm70Rvbb/WuLMsYqcP2A94MozLO7Rg/I4Wfcql+WgDuiDNWGHTTzd?=
 =?us-ascii?Q?ZAdpuTRapTblmoXJZ+Pb3tW9QUnMe56PEIHldF+Z14fcfKA6HogRh5hHps2k?=
 =?us-ascii?Q?jsGkp7zGm6JRsd2WyvHnaBwLJtU5Slce0hFu4TSg+LHDCtP86yZQmRftGmvL?=
 =?us-ascii?Q?Ij2+fg6cnGUWGNo/BoPT+Z8NudIuR6NNzffWNtJuWWLZPdcFBCwsDiMOX/1C?=
 =?us-ascii?Q?FBqltU1SC2ixny5dopp7SXTHTYZJ3jM/7ecEZukhdtjD7OCfUz2UCJ36ufOR?=
 =?us-ascii?Q?d46i3HK0qC93FQ65pOaVxnEFg9M+V+1SuCN5tsxR6KbCT7sZ4cZTFMVDbzn6?=
 =?us-ascii?Q?8Hsf+iUyJyGSAB5BsbLwR/20qqZifoYxE8PHFLd9X9vEouWz68F5ub1f2pEC?=
 =?us-ascii?Q?i6/+ywdaBlqx+8NerD1Ow5RB0fVs4JIVd57L1RRVxK/Szp8Lsou2GIoFgjun?=
 =?us-ascii?Q?H83YbjKZMoo+HxJ+XrbZjJqnRGRB963CyWjJSm55rHaS9ogxM1b5S7jrqDJh?=
 =?us-ascii?Q?sD15wtTqP6lLU/PN/ti2YKFAhA9HE+jlOlHeYAXJ1hrPBb42DT0jowfhrZge?=
 =?us-ascii?Q?j7ufWclFy+VXB1Ym9jo8y+kUGwYUwbPTqlOd/Rah78N4TVT7jE62d/4RXW1q?=
 =?us-ascii?Q?l5u+/n7qMm/0En0gtWPn+dXOFnySFd1aLdtEwc2qgGmopcWrhbcvwWOS3aJG?=
 =?us-ascii?Q?+Zsv+CXnODNl7ZpcXN/V/6a561P/jWF+NZEcrTbMXX2lr+AEcCg3RCM+K4Lt?=
 =?us-ascii?Q?68nrnVcnCi4+kX5xd8W2BLUwJOyEaJXnPLPJtOC+34XXF0wd8vdoOiJDYa7G?=
 =?us-ascii?Q?hjMeyYREOhO48B3F6GLkpod/Jhhkl+9PF0KydmGp8uq9XcwbnJDFSCfrdOkr?=
 =?us-ascii?Q?7knE9NUaBbsRkICuWX2yBI8g7PgcYGk=3D?=
X-Exchange-RoutingPolicyChecked: LUkB2/pgH3ttVDdtaDb3n8hxNDy62hGP38rILOJ9QVdQJ78rTiJrdkQH6sMFpCpA5OOzXErI4qVV+quyuMk7MeIGGxe0Za/cGrCXq2zcEZfKWud6lp1dl2KciimsvNDYM6E/FmMJWuSn0WG0u6nFL6mJV8OXwtIVDqpdEGIFzvCYsesURbh+KsUWhrAv6m6ayBVDZnPmdjMajOFiksrPxlE+XD/Teg4r9I7CTLY1xI5fGmPRDJuOP6JK6QR+bAUxiJhKb51KdiB7S+qFFsEQ2V8bBdNquK6xbdbvLb0bHHR7AXtx3/zBj/XkSZ580pMHm9adOG3rBYOyyhNw7/KGnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc1f09-ef13-45b3-2bb4-08de868d558c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:31:11.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UtwrO1XK1BHDauvse1hHuRdXAPcAn2n4F3G7p3tbzUuxo/98UzvgRYFKn0foMB0JM87bNBcdFErlvvJ7NK4opILX0yAB0v0D7MY4LHB5Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
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

On Fri, Mar 20, 2026 at 03:25:26PM +0100, David Marchand wrote:
> On Thu, 19 Mar 2026 at 18:13, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Bugzilla ID: 761
> >
> > The standard "fast-tests" suite is used to sanity-check large parts
> > of the DPDK codebase, but it failed to run successfully on FreeBSD,
> > with large numbers of failures. This is a long-standing issue reported
> > in Bugzilla back in 2021 (hence the 3-digit BZ ID)
> >
> > This set attempts to rectify this situation by allowing the suite
> > to run without errors. Mostly it does this by disabling test suites
> > that rely on features like multi-process which are unsupported on
> > FreeBSD. It also fixes the test_debug suite which should run on
> > BSD but was failing.
> >
> > After this set, a run on my FreeBSD system passes with zero failures
> > and 22 tests reported as skipped.
> >
> > Bruce Richardson (7):
> >   test/timer_secondary: skip test on FreeBSD
> >   test/eal_flags: skip test on FreeBSD
> >   test/pdump: skip test on FreeBSD
> >   test/secondary_process: skip test on FreeBSD
> >   test/external_memory: skip test on FreeBSD
> >   test/interrupts: skip test on FreeBSD
> >   test/debug: fix unit test on FreeBSD
> >
> >  app/test/process.h              | 11 ++++++++---
> >  app/test/test_debug.c           |  6 +++---
> >  app/test/test_eal_flags.c       | 26 +++++++++++++-------------
> >  app/test/test_external_mem.c    |  4 ++--
> >  app/test/test_interrupts.c      |  2 +-
> >  app/test/test_mp_secondary.c    |  4 ++--
> >  app/test/test_pdump.c           |  6 ++++++
> >  app/test/test_timer_secondary.c |  4 ++--
> >  8 files changed, 37 insertions(+), 26 deletions(-)
> 
> I would put the exec discovery rework in a first patch, then squash
> all the rest together.
> Otherwise, it lgtm on the principle.
> 
Ack, will rework into a 2-patch v2.

/Bruce
