Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33E7CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 15:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDAF0402A0;
	Thu,  9 Oct 2025 17:23:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id CD43E40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 17:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760023431; x=1791559431;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FG4Qw/8v5A3pkJu/Ob3qqDnLo19Jag54SzpCxn0Bwho=;
 b=I75q2gYbseyeMwfEMqV3ksppUviozkgYiKx43NPID8WRCdikuINIIdFX
 vccZZShy6SaZrUYlOTjhs+3UgFpTw5Bq1mRZShTNuqM6lDDvS57nqbYtC
 OxbnyhUHTpk94rKNSaxpxJyAQ9JEUObzE8fL+7h5sBM11JFcEV879WLUD
 6NexZvUsYSCYPvpB6yGy+LuCa+o1/DF58PK27ZUV4D9HPlpk1iaHz2DoC
 fkHE4Pn3r7fMbC+eTsFBxqTv1irSv3kW44EDPk//qReun0II6noehD2Gr
 e6O/gs2cvzgbGkSd/ubicarZCNV9vwoDoP6WwoEhhTx7dNYizDW1g4XiA w==;
X-CSE-ConnectionGUID: pjwTnS0hQMi3YuHQkuS1bw==
X-CSE-MsgGUID: tpskRGmMQS61jhQ5ekYyvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="65884696"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="65884696"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 08:23:48 -0700
X-CSE-ConnectionGUID: gl3X8WaTQkyLV2UMXJRORQ==
X-CSE-MsgGUID: jPjAIhmkS8ytJAd8EFIzSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="180684355"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 08:23:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:23:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 08:23:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW0dE5U8ZZeLouNYlQZnTY+ArfYh61iej+gBPguP2BVET2nMig00xbt6ThhS5iEv/sj3F/sN+opj4Q++OFOWKrOJUkJOBtJYAN1+l3v1lwgIgUNl8cyxcZyoUdxx2Y5EObAm73JYRB0OmNZgvUPOTjtsDEzbfxabrhCfkFkduy6fuTcw1bXINeB9+txCDkrhhjDLS6vf/is1y2Glkw6QoF6Uhzgzn3ykzfu5IUcy0yfrynySTXgvbA6PlPawrSwSnEy5aLFLJJzKf931cJSL2QEZcCNPBXF/6P7wAnpnUZdSU1sZrzVA30zP1iBNj2+xZsKvlNm4ruaG3Pu7gZHBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK2tI1aFqXtTrEtdiuNW5DubnCfVuvq4K2zkC/Sv7S4=;
 b=hIvp5q7y/lVxLCoMBQsW1TFyPFV6Ud/T7dwanbbtO4ki1Ndj8uaHcLN0PHa/+Oe9qkei3GMtt8WO+ndjS7fHnfIht6KLKiPUsCvqN8QR9ZQ8TwdkuIvJZeXTH2BcjAZpb73fieOpQfZqv+zPcOao4joGEkKG/Ou5ctgJBbWid5n5jQJZQv5YPs8Zr5ElM32I5IeLD//p+JzMCWNI8TucTt57jw85jWeYp5ukcqR13FIcl8nYzGOxQBb4QPZOLfw28k4B6JCOcpcuapd4YqP8AP+R3vmZqebYSWmtSIYLSpkTUANOY1I7qnaQ8aCToSU7GLjHzFw8F9tiJeGqzco2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7274.namprd11.prod.outlook.com (2603:10b6:610:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:23:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:23:43 +0000
Date: Thu, 9 Oct 2025 16:23:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Rybalchenko, Kirill" <kirill.rybalchenko@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: fix initialization with 8 ports
Message-ID: <aOfTeh-z-iweQ3dB@bricha3-mobl1.ger.corp.intel.com>
References: <20250930142850.1782615-1-bruce.richardson@intel.com>
 <CH2PR11MB8777CB1697FBBCE40BD0538B98EEA@CH2PR11MB8777.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH2PR11MB8777CB1697FBBCE40BD0538B98EEA@CH2PR11MB8777.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2f1f67-6831-4961-d536-08de0747d545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vN7+TWPSzkqr4QblZjR8CtGTnU/4IBOV1cLz9GcFC/J2qcVszBq/5tBom43Y?=
 =?us-ascii?Q?bWeYzzgEd+43GN4G541uGPeIN5hYTYTyiJmdzBkWHNEE9xz0DO+N2M3FVGAu?=
 =?us-ascii?Q?Yq0vgA376F+E0LvbPqCgOCPuBKzMfotfAagHJqASKODgvZD/JXJr0qFjbCCg?=
 =?us-ascii?Q?dV9sx8AX66wsxWPNS6n4VbsQuY9VLwHa7+0tgeTkS07rT5B2e2I7nTfik3H+?=
 =?us-ascii?Q?8G8EmGjkF74pz3CCAh0ie1ecO+DSAXWvSVP4svnTxP0JH/jgWkrvQAMRWjzf?=
 =?us-ascii?Q?J313U2lkG7acs9V9NfzgNybyK8M4FzLocPpv1CE9B1YsIfii0agn4QI8L3bK?=
 =?us-ascii?Q?piyCwLkwUilEPFFKGSzyxg8S6awq4vuBaZCqp1enzqrdk8bd0hAp0q5rLMVf?=
 =?us-ascii?Q?STKgpRkcrf0stblDTbU2M/lcgKpU0GFoCNmYAnAMH67wlUw71R/dSBG0+OW+?=
 =?us-ascii?Q?/K5HA8meNagQgshf4xUBs0c+vAZMSCuZiIIFjf3bBSoH3Bfpg7K8TK5+/h7L?=
 =?us-ascii?Q?EsgyWr52rhFEW0431Hx9Kr+FFa7mYTgNNYRpL/ZMyocg5Wzt9CAow0cQDOAE?=
 =?us-ascii?Q?Fvwib0AlX/gr1uw5WDvOnsYWNBITgPX0RTnNmo7uptkr1HSSEQ5BETqEyLRH?=
 =?us-ascii?Q?bU3cvBYadIH8gwnNo2K0LGzt/4PZovak8dL3ZwMLnr40Q5l/3W6e5dwSP6+O?=
 =?us-ascii?Q?cXB6prNlVlvhbjSGaAdEYNIC+sSLafcrsrt1Y2evAw4H+34M4Nf3/hdWmmW0?=
 =?us-ascii?Q?PJv8EsmhgBzYMT+DT8B5PXHVLQK5dYubCgiIhLzShuhGXt7X8AbVxpfWZlI5?=
 =?us-ascii?Q?Porrtc7gIykvqxEU7RO0tvu5khvdoYfxU4e4lmNz3Gx8SAtqBIaUnlTlcFat?=
 =?us-ascii?Q?gBUIAZt4B4Zmo65fWgiK3UKMNDjHIZSkgYsI7eyDi7CStYQC947QpLcXy5am?=
 =?us-ascii?Q?MmHGpa3fObF+1C0BooQzETsBavMOHqhMyY7MPb47IU7wuv4gkSSJyiWRF18j?=
 =?us-ascii?Q?3C1GpdkFEbaLOR5rWCO46FOmcxjXJtqHWL9Lf4LU7D2t6XE+kS6/wKMr2h0S?=
 =?us-ascii?Q?gC7FAH0snqEZPnpun5p4h6dEIhGmpoA4K6HpxxMjlbPqyy7TqI0RI+5+oJ/e?=
 =?us-ascii?Q?cJQ3gSoAA8FscJgt5FDmMEnxHRlzKmOkOWwR1IxnwDWfg/qJ3sCYjNGoj+/1?=
 =?us-ascii?Q?5Pi92YC9aNPQeEwxNANmVX0cYxx3iZLDuxcHgzCKSVVj9gL4nf9PHOVD3JTx?=
 =?us-ascii?Q?Jz0RIP4Nyw2atUSRSd6ouRb24A11ck9V2S9DXc4te4pUwE1CMxaKnstMpy3K?=
 =?us-ascii?Q?AiW8C8I/giR2UT1JbiI/y119DeuklF8X2ASUxceCLDvC2uzKTmEMBrg26WfE?=
 =?us-ascii?Q?SyCxjr+S0m6hdocER5pILusfrzk33Kd2NBEEOQ6Vpw/wQlczYHBTLUhgTzUh?=
 =?us-ascii?Q?Bec1MNvrj7KaLrLYC7R/nH9JyIijgDqj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qf7JZih9PWTGfvKGqGYDSrp96cvq+7Xc/Mo0FsFfG2U3XfejpJoQaYS6nTec?=
 =?us-ascii?Q?IVlnVYIF1s77sYgqwCKfomGQdJH/MyEmE6o57EU093pqVrWalEsPBJtDtwGr?=
 =?us-ascii?Q?9+/eCCx2C0FIdaBbEMPxLOmLbcMdrqIKJlNIzWTYMd8peBfHwNIig3oqcRF5?=
 =?us-ascii?Q?EhIsnVf8BD3aLyQ4pI0P/Oz8DKUS9PAMvTj1T6DAURhWgiBjtFeKlShHONZL?=
 =?us-ascii?Q?iB8H4Po3w4r6r/TnIKj+5Ubt3VG92RcQIQmFhxQz3qxRBlOhChPADUI2aQkr?=
 =?us-ascii?Q?cWcZinFZRRbGm809idSABdSDHdS4/WhkNFuSijHPQ0rz4NogtRFsrxTda/7V?=
 =?us-ascii?Q?54t6MpxooCUjHpI66ueXujiY7zZafHa1VaWgVStqjgvaBcFKCR0SmLz5u6Ht?=
 =?us-ascii?Q?05Jk167uYk0IVr8RUQd/cWGwO+207aAzsacpHeufB7ivaUFIQ2JbU6XBH/8M?=
 =?us-ascii?Q?t9wD7UwxATkooexvvPeLp3IMuYxgCCplNBdCh/nTb3H6P+9cJYx/WZh1EoLU?=
 =?us-ascii?Q?PJvbAxdF07Uv54h4Of256nmV0XyWBOqAYobuPEnA+vhiRpzoHcimRGh7pBtO?=
 =?us-ascii?Q?LDoObZiqf5DwNg8eNgYiLL3qyRp8lPupWKiOheGTq7lYmZmRXQCQYMIVZ/oB?=
 =?us-ascii?Q?fgSWlpXHROrWDODkJZ9Oyz2c/cNXa5lGEJMAjH8/lZ6R4FFfVtkboy0q1A11?=
 =?us-ascii?Q?EaloeNIVvv4TLG2iCP6dDf53tEdOUqSYuMnN3i+PKLa7VTEKtM0Fm+POhMLu?=
 =?us-ascii?Q?z86c0u/mNo7aW5mn2uL1Ve4WUnnDTyqh1WLz0obQQ8zabSFqHUbzLSUHsu+t?=
 =?us-ascii?Q?30Dop0ES3MDZHR1Ohn9isYkrmZiCsq4RwZPV4fMSgHaZaLt3Rfp+kQImvXtl?=
 =?us-ascii?Q?fUUv0gtNATTMML2zBru5MVUbe6mAh6YAT6TLrQ95jhp1TFP0IPja/jJvWvXa?=
 =?us-ascii?Q?GvE+8RBZpOgeXQigiBhbqx1c7CdB4vpXjHh605rgBKPI/jQnPW93AuZM7buF?=
 =?us-ascii?Q?F7xJsFV9yOZ+fxAL+OreA6s+ZDRYgHqfyhXX1MONXmn9fEYh5WdjnayLqnJP?=
 =?us-ascii?Q?wtfCg2CDs3x6xSS1rTjGWvHu3WvUGD6QMMExlBTpeQjr1SePrvndsHfcDcy7?=
 =?us-ascii?Q?PIdlI0F1phq0PAUcSt41QzxapFPd9Y1MCqFZzNxFg+YAT/ca9n1pKR0ZC9bz?=
 =?us-ascii?Q?Xqi9XOTzFhPUOBId+RqsrtSIthxeWXlBSxtRN4ndNeD1wbQnS7cqoa2hudha?=
 =?us-ascii?Q?T7Cvg8n9xZKNDmJULqsRfLnZjpxYzDoIGqpVhQZZgVJQJRbseeMbIi4sYU8z?=
 =?us-ascii?Q?FvSW82jLOWkFD+QiowRjhvHqJI2hle5b6ym4r8XOwNPyBSbgoT5/AR9mMrdp?=
 =?us-ascii?Q?WM3JjQFKuDgDL0v4oQOm1xDBaaei/UQFhzLzl51RG8OgzaXPNNBSSgZoBWaF?=
 =?us-ascii?Q?9MIlnzwF4YF8MgFWdn1kuR2BNtbeyaQq1WHUFyuBiWp1t6gozJZbzTVLEkOB?=
 =?us-ascii?Q?HJ6mQy8KN4yA5Q0ncIeuINSkc8l8undii0Jci8+vsKWCqCG+nueb8sVkqTiU?=
 =?us-ascii?Q?rDJejKnl3gKFg+9a4RlogtoWbDYO8SsOZ7MIltGjSgdOK6TdSem91figviBm?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f1f67-6831-4961-d536-08de0747d545
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:23:43.7523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zydljh9ux44kzUrrC7gyp7hz6BWjRp9Bk4V2s6PF8nc6qEpnCV8MJduGjM2QasTJAXS1VjD2e6yzGw3HMv+jeY9Uv+RjBTrv/kkN13oy+a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7274
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

On Thu, Oct 09, 2025 at 02:28:00PM +0100, Rybalchenko, Kirill wrote:
> 
> 
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Tuesday 30 September 2025 15:29
> > To: dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>
> > Subject: [PATCH] net/ice: fix initialization with 8 ports
> > 
> > When initializing an 8-port device, the ACL configuration
> > failed with the adminq returning an ENOMEM status from the
> > sixth port onwards. Fix this issue by halving the depth, and
> > therefore the space required, when using a device with >4 PFs.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Acked-by: Kirill Rybalchenko <kirill.rybalchenko@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
