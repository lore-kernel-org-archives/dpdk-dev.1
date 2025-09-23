Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E5CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 15:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F13D40615;
	Tue, 23 Sep 2025 17:33:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0CC6D402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 17:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758641596; x=1790177596;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+j313Cue0BxVu9sVKgu3QD4+jMFPYmXFYe+1cJtQwXM=;
 b=JVpuPN6fnKerhelNHWt0X/2y6MCDmZhmhfZrNKj9Q2BGoAb1vYE21R0D
 pTUumda7Wg8sRqQkI/Ag3Q2MajGuuupysKx3L8hJvmROPohNbBy9g1EYC
 CQA8CNbf0rrr1ThX+dyKh4HtnhIrciqnWDmhpVKTyuEztyI+tZ49/P2Ul
 gpXevnciuTZkhN3I7SJ0nNzXMzo3GOOSDIovvCobxv5ofqc4aZxZyDPrA
 I9Kc+hUsCJOa68nOw+ECpMZD8tfV4PiiDGGpPe+BlBdLlVTyJTatf0/TP
 mNGpr6ZnJ1MyUqYqXL4spNPKPvUJVmC79qp/oDtFfYxbgz4F0pX05VWIZ A==;
X-CSE-ConnectionGUID: nCAeOv2URY+L6tmrdKM1RA==
X-CSE-MsgGUID: H2bVAutxTNKz606mJkdorg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="83528272"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="83528272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 08:33:15 -0700
X-CSE-ConnectionGUID: IlEh9uUmSxC6BURWyEVAfQ==
X-CSE-MsgGUID: /bL4nRDPToebIiUATrSr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="176876003"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 08:33:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:33:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 08:33:13 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:33:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb4cSR0Mr6KznwLRlTS0dXwVUzt+rHOBkwZww458ZSCrtUUTnreRnpAKSfHt6rP3PzXCNqyKyY41CBggX3gnEQcz1ewoMI7bLf1RD6VXa43ln2bhpCfPPJ34HcMyZH67u0KRvLIUmepLSeL0cTscsM17VbG3Z2/DuQHjyOEh/3qrLsJj9Um6iUPkpIYDRYoTUBELcMT9DqfE6Ofj8a60LoxaSMS3OKFgFcf2axyqqufHHVKbZ/7xUgvssr7G3x8eMIqyLGWiSZBFCfoql4Jr9sCzSb6qYOq2ZOHFCBIiwMAoNB6IZCQJHTRJsNFFvhbrG4IT++KEk6sT6tDf1u/HIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANNvgXZI+2YwvZSfF2GbWABWLTs64dzNQS/2YmUUHqU=;
 b=ZaJWGdRVW1oXMoLsNk6GR1WTarkzkV+YldjDTQn3/R5MZriWiepWVqS9d1MoEoo7NDdaa4GTDdkZZTopLupferQksDzipb/xlmekelJuun9K3pyQd/rPDnmbKh4LpTYMKPHsV0Q7jpEgMuvwkxgD2k60rDTQ6mMGH7dSqw2TkUuURsasdg0nvm+Grjjp2AL13c5x1+K6vDTt+pzblrct3qEZ4gMdCfV8QFlKCJ3d6/bAJDkB8aAZ9OWwaaCEyW4AegG4HBKsPF73f1tx9GJuW2tUhmwt9YU45DvlpIoPZwM6VG5Ac7kWfXcmc+9kZCKkjoyUFA6sPeOF5z+p+0D9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:33:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:33:09 +0000
Date: Tue, 23 Sep 2025 16:33:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/6] remove deprecated queue stats
Message-ID: <aNK9sG1ISFOBUb98@bricha3-mobl1.ger.corp.intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250923080443.5430306c@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923080443.5430306c@hermes.local>
X-ClientProxiedBy: DB7PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:10:36::38) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2112027d-e697-4bbd-bd12-08ddfab67f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qwpYpGq9I1bsXAyzBEKXC9vXqj3e63QNtihrmomx00q0oIa4Wj925/QWAIJR?=
 =?us-ascii?Q?dT0jpuBXntGpZyrE6BU1rBeelRzZVPa81yz77cTX5cGwZQ+wtWPfIPBdnnwh?=
 =?us-ascii?Q?ZchWvhvRc5SAtxsEszXOhEd4MkFew40/GrZz2hluyz+iRny6A10+x/CnaCEA?=
 =?us-ascii?Q?yUn3KS9rACOwQii/mxB4+GkYKwVuXbnx9Ux/SK2mC7AdoLuzhV9kEvAhVXgL?=
 =?us-ascii?Q?4zikVDdGl1asgGmearwgyHPSQOwHcxCY85A1NfP8PLKi41Qvn6EmI81jkmiS?=
 =?us-ascii?Q?E3n/DcX/HAgKu3GQUGlWB3KcMgLr5vkqfUaqOjxCUKUi4Csn4HWdYJac5FC5?=
 =?us-ascii?Q?jD9C69KxQp2ekdSC9q6W0S//mSOAnyXTvyrS7Rvk22G9oGYS2Wgsudf2/yuw?=
 =?us-ascii?Q?nLzxT7Mnkri98oOvy5vRLwNH8fCNahtO3Ji+DgmvMwuryWumsMfd5CEI0M9e?=
 =?us-ascii?Q?8HRrkLaomGZ64IijHE1zeN8qczI09Ni5M8O6Op5blLTyFV9cCiE0A1lFL/1H?=
 =?us-ascii?Q?ztlrTLqii8j+we8pv4jAtSDRpNT5ybpEYQQKTv5Erzw86UJc4HbmUXrPzM3S?=
 =?us-ascii?Q?fx775T31JlpjtcMA5y1TuUPHj+SysZwnwbf9+57Wz3wiPy9iQ9OHcAjzSzcx?=
 =?us-ascii?Q?21ZGaAINxXns/s+2QJq11Np+yuGT0jtNG5SwrQ7tOkU+zuDrB7ANsn2Qa/4Q?=
 =?us-ascii?Q?eIC+XgHNvNVI70qZ9pnlnQkIiL+n7jqeAk/l3imiMns47IKE1IzyAysz7uff?=
 =?us-ascii?Q?5pAyKHlPzb3YGc6p5sE3isC23YeJOT8Db1xGasytiQgd7IlGkfnIeXikK3zw?=
 =?us-ascii?Q?jdSdnKhi+vn6VPWZSP6BcuzKnIYMly8hSvkovZ6q/JkQ9PT2blsP63hJLLMw?=
 =?us-ascii?Q?D4ndddMtjRy1ivxvW0aSXOB2Mvy+gi95vagiav8d6k4dAfN87ZFP019gt6ef?=
 =?us-ascii?Q?ItSubDKn/5hPC9W2UsOkNBYJAbVQRrnxhPggDpCu8cRpQ+gjGLXM7srPoHjz?=
 =?us-ascii?Q?WH0kbzAHE8EFGAJMNQeccQQxdAM2f4WFxPWyybj2S3nV5gxg6ao3fcdu76Aq?=
 =?us-ascii?Q?bM3vPmHakH2QrORs02A7clEWW0IyGbYB65AzYoSQVL1plIELEsj/7/9KvtgW?=
 =?us-ascii?Q?6Q6FtN4eKg9GNZAl49x1liQR8q5HBbUc6RSdgPS/gaRmrBlHicSyYJHoLPZ3?=
 =?us-ascii?Q?JZgt6C7s+Hz5GC3i3QUgzUVGq4UKfbaRXvBf22T1rs4xpuboVdbcsr/2gA2H?=
 =?us-ascii?Q?mJ7wtGqVBtAaeTPeLsHUOpvCJBytYhuoE8eVitDA8o/+m91hldPVwNzvKTOS?=
 =?us-ascii?Q?xY+fEDy3mvK7+fXUFdkkURGYW61Z7yDW6g4WtuBfH8cLXtjPvQEYFk0xFtFD?=
 =?us-ascii?Q?FhawJryxNKeZuxY3do9Uo87WaPBFZVz5dF5mK90g4ft6sYl6Sgb021WmUAGB?=
 =?us-ascii?Q?m6Oky1bnQow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlmRzoOBZzjjKQ3vNyYZM3Du5M43yLQKbXKCKnrUUiXe0upVwBrsADuBPQjJ?=
 =?us-ascii?Q?uafoueUpIGA+Hx+U1vUjenrlJaRhINTNsACsE+4QWt7bGiLdAFzn8zrF8q2a?=
 =?us-ascii?Q?NI1AClH7xKkuF9b+s1Bv+mZTv0M0yTOx3lQ41WvGjp/DADBiX4AjrvVpFS3l?=
 =?us-ascii?Q?Z6JbGzj3Sa+3qQKX3MXU7glzuIx3LJ2wgGY/CQC+kW/v/St7zvVbsneC4Uvo?=
 =?us-ascii?Q?oP6/dPiZ8HrliXBVeNQO7LK0c41VYa7BaIzGphh8kRUyrkrACZS1hneIKl9A?=
 =?us-ascii?Q?BFoO4o20shPmSWVpBl1K2GAiZTmpT5TNKGA4dwR3V46t/R5eUc4tstdEmUUa?=
 =?us-ascii?Q?m3iHr3ppXah7dJej6TmCppH9ryP6v5s66X1CFM9SN/sap5Z5pOIy/IARkVjI?=
 =?us-ascii?Q?Qg6AteOzhd7zTPcO5Ja2DuDwo1E4KSKaAaN5sC34OgD/aLOVuW2EUd97Obyi?=
 =?us-ascii?Q?q1AcnZi2JNUvG4yVm2fv+F03laPIpiR/wla9fYsWl1i3oq3eyQPEiZKftdYa?=
 =?us-ascii?Q?qwqdy7qBAXOO4QAf2szf8TjbXmQMzTgSw2J+3sQ+PdK8r96XPNVWp4mDA9UX?=
 =?us-ascii?Q?PP+uxK1EhDWx2Vc6PqstyTyD+f71uLhisNf9eQS73Hk5LP/9GhqTOWMdl39R?=
 =?us-ascii?Q?Bq+HJb20NzI47YQeU61QY3wHDvrhXvFRueZYXzVdZX3FfwvniT7BrAgz43Ih?=
 =?us-ascii?Q?VMJLWLC9UKprXJA81ekGirizKntrcbzW0674wh/19LBSnxK2vbMYeePIiFMr?=
 =?us-ascii?Q?9+PCGBkigRJEnlNHAwEPjsrDBvrDYx9FC9SE7rcSZTujvnsh3183FxZw0CNL?=
 =?us-ascii?Q?w0/9B/Rf45B+GzTfyuL/YsqLPt2aoroqebo5vMr/Z9YfmbWvGfkE8DfZLUiw?=
 =?us-ascii?Q?LKorp5SqU098QrF0m2mR4Y+Tr6YtzAmfOk5vRLst8bX7mh9HiRLePqcq0NMM?=
 =?us-ascii?Q?uOOyvuZKKylSbE+oXUidIu2hgqYml9eC883B4TamlGP/6X3RWTiv+Of28n1D?=
 =?us-ascii?Q?ocy5HVoyLWs941P0JeMGuQ5lwhD1qidNqpfR/wI+DfgqgOgDE77Y/vbQ35Ea?=
 =?us-ascii?Q?9TxVKJf4EM5BfVJ3C+bXgRxgo8oV6DWHrtrG7SzlEA2WTV6ANgeFyfhwlDWu?=
 =?us-ascii?Q?tmI24wA9njeYe/Tw+YYU8REtXJ0IfKQF0VVrdTlxlsBP3DeBtZdZYtoyWNWg?=
 =?us-ascii?Q?Vm4Vo/2cQ7Zws/D4jdczK06+xdlEn9bOX70O/Q3mz1Qy8M7kjNH+XITazM9Q?=
 =?us-ascii?Q?id/CTH5NccsABTJP1aC9RjRidXGoy9mYQYafxdknLBtjp1XgiDaRWIjQDV9M?=
 =?us-ascii?Q?V5VEPkKIZrwc/Y3xezVBqwQYtpt1X/7BeaGnWv0o4b0+bMyopmLWQeOM01lB?=
 =?us-ascii?Q?UfobFMdMLjLtlyDV6Nl9Vq/sC2rb14H7TInWERFe9mqNV+VhrIPn0veo3tC8?=
 =?us-ascii?Q?sFWEd34T4pePfvzz7DjZ76JZioCeTUIuglMVTkF6NJwPj/ox93NetbeY2O7l?=
 =?us-ascii?Q?t0JjycbJTWZ2i0KrgsvUx+Rn6S3xRw7JOxHW1MVnAr+7Ygx5aGWc2Iiet2Mt?=
 =?us-ascii?Q?cJW5XdaPlfVqSrmEGVi0pnxh2R1IgT7NPcShRy6pIg4ZYr+a/V+/XXBnf4hn?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2112027d-e697-4bbd-bd12-08ddfab67f94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:33:09.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgwRFX5GEJMk4deKEoESad2xsKRFkMU5WlZidF7EVc5RAk3dT1/SMJcL7F4vi9sKiVmRCAhBJ7UUVtyyggqeZPKD7GBSNrMfeaX+IuU4NiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
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

On Tue, Sep 23, 2025 at 08:04:43AM -0700, Stephen Hemminger wrote:
> On Tue, 23 Sep 2025 15:12:00 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Since DPDK 20.11 release, the use of queue stats inside the rte_eth_stats
> > structure has been deprecated with the intention to remove them. Sadly,
> > despite 5 years passing that has still not been done. This patchset
> > finally attempts to fix that situation and remove the queue stats fields.
> > 
> > The biggest complication here is the fact that, as part of the deprecation,
> > a new driver flag was added which caused ethdev to automatically add the
> > queue stats into xstats. While this was good, in that it allowed quick use
> > of xstats for getting queue statistics, it now causes lots of problems
> > because we have 35 drivers (by a rough count using grep) which rely on this
> > functionality to export their queue stats via xstats. This means that if we
> > drop the queue stats fields from the regular stats structure, then 35
> > drivers will lose *all* queue stats reporting functionality! This is not an
> > acceptable situation IMHO. [And in one patchset trying to change all 35
> > drivers to directly export via xstats is not feasible either, since adding
> > extra xstats can be very complicated at times.]
> > 
> > Therefore, we need to make changes that a) removes the queue fields from
> > the regular stats structure, while also b) continuing to allow the
> > individual driver stats_get functions return those stats to ethdev for
> > filling in. I tried a number of approaches here to find one that was most
> > feasible to implement for large numbers of drivers, so that either scripts
> > or AI assistants could automate a lot of the changes. The most feasible
> > approach I found was to define a DPDK-internal queue-stats-only structure,
> > which would be passed as a 3rd parameter to the drivers' stats_get
> > functions. When calling stats_get from ethdev, this third parameter would
> > be NULL, but for gathering xstats, it would be non-NULL for drivers which
> > have the RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS flag set.
> > 
> > For this set, I've separated out the driver changes from the ethdev changes
> > and the app changes, since the driver changes are so numerous, making the
> > rest hard to review. In order to ensure clean compilation and git history,
> > patches 3 through 6 should be squashed into a single one on apply.
> > 
> > Beyond these patches, more cleanup should/could be done:
> > * ensure that any drivers which don't set the AUTOFILL flag have the qstats
> >   parameter set as __rte_unused.
> > * For those that do use the AUTOFILL flag, we should ensure that they
> >   actually do fill in the stats, and not just set them to zero. (First two
> >   patches here fix that for a couple of Intel drivers)
> > * then work to reduce the number of drivers which use the flag to set the
> >   xstats, with a view to completely removing the queue stats from regular
> >   stats functions.
> > * Within ethdev (and testpmd), we should consider what to do with any other
> >   legacy queue stats related functions, for example, do we still keep the
> >   queue mappings functions.
> > 
> > 
> > Bruce Richardson (6):
> >   net/ice: don't report empty queue xstats
> >   net/ipn3ke: drop unsupported per-queue xstats
> >   ethdev: remove queue stats from ethdev stats structure
> >   drivers/net: update to remove queue stats from eth stats
> >   app: remove queue stats from eth stats
> >   doc: update docs for ethdev changes
> > 
> >  app/proc-info/main.c                          |  16 ---
> >  app/test-pmd/config.c                         |   6 -
> >  app/test/virtual_pmd.c                        |   3 +-
> >  config/rte_config.h                           |   1 -
> >  doc/guides/rel_notes/deprecation.rst          |   7 -
> >  doc/guides/rel_notes/release_25_11.rst        |   6 +
> >  drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
> >  drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
> >  drivers/net/ark/ark_ethdev.c                  |  36 +++--
> >  drivers/net/ark/ark_ethdev_rx.c               |  14 +-
> >  drivers/net/ark/ark_ethdev_rx.h               |   3 +-
> >  drivers/net/ark/ark_ethdev_tx.c               |  12 +-
> >  drivers/net/ark/ark_ethdev_tx.h               |   3 +-
> >  drivers/net/atlantic/atl_ethdev.c             |  19 +--
> >  drivers/net/atlantic/atl_types.h              |   1 +
> >  drivers/net/avp/avp_ethdev.c                  |  20 ++-
> >  drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
> >  drivers/net/axgbe/axgbe_ethdev.h              |   1 +
> >  drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
> >  drivers/net/bnxt/bnxt_reps.c                  |  14 +-
> >  drivers/net/bnxt/bnxt_reps.h                  |   2 +-
> >  drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
> >  drivers/net/bnxt/bnxt_stats.h                 |   2 +-
> >  drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
> >  drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
> >  drivers/net/cnxk/cnxk_rep.h                   |   3 +-
> >  drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
> >  drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
> >  drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
> >  drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
> >  drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
> >  drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
> >  drivers/net/ena/ena_ethdev.c                  |  46 +++---
> >  drivers/net/enetc/enetc_ethdev.c              |   4 +-
> >  drivers/net/enetfec/enet_ethdev.c             |   3 +-
> >  drivers/net/enic/enic.h                       |   3 +-
> >  drivers/net/enic/enic_ethdev.c                |   4 +-
> >  drivers/net/enic/enic_main.c                  |   3 +-
> >  drivers/net/enic/enic_vf_representor.c        |   3 +-
> >  drivers/net/failsafe/failsafe_ether.c         |   9 --
> >  drivers/net/failsafe/failsafe_ops.c           |   3 +-
> >  drivers/net/gve/gve_ethdev.c                  |   4 +-
> >  drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
> >  drivers/net/hns3/hns3_stats.c                 |   4 +-
> >  drivers/net/hns3/hns3_stats.h                 |   3 +-
> >  drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
> >  drivers/net/intel/e1000/em_ethdev.c           |   7 +-
> >  drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
> >  drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
> >  drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
> >  drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
> >  drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
> >  drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
> >  drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
> >  drivers/net/intel/ice/ice_ethdev.c            |   7 +-
> >  drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
> >  drivers/net/intel/ipn3ke/ipn3ke_representor.c |  14 +-
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
> >  drivers/net/ionic/ionic_ethdev.c              |   6 +-
> >  drivers/net/ionic/ionic_lif.c                 |  35 +++--
> >  drivers/net/ionic/ionic_lif.h                 |   3 +-
> >  drivers/net/mana/mana.c                       |  15 +-
> >  drivers/net/memif/rte_eth_memif.c             |  15 +-
> >  drivers/net/mlx4/mlx4.h                       |   3 +-
> >  drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
> >  drivers/net/mlx5/mlx5.h                       |   3 +-
> >  drivers/net/mlx5/mlx5_stats.c                 |  17 +--
> >  drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
> >  drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
> >  drivers/net/netvsc/hn_ethdev.c                |  17 +--
> >  drivers/net/netvsc/hn_var.h                   |   3 +-
> >  drivers/net/netvsc/hn_vf.c                    |   3 +-
> >  drivers/net/nfp/flower/nfp_flower.c           |   8 +-
> >  .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
> >  .../net/nfp/flower/nfp_flower_representor.h   |   3 +
> >  drivers/net/nfp/nfp_net_common.c              |  46 +++---
> >  drivers/net/nfp/nfp_net_common.h              |   4 +-
> >  drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
> >  drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
> >  drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
> >  drivers/net/null/rte_eth_null.c               |  15 +-
> >  drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
> >  drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
> >  drivers/net/pcap/pcap_ethdev.c                |  23 +--
> >  drivers/net/pfe/pfe_ethdev.c                  |   3 +-
> >  drivers/net/qede/qede_ethdev.c                |  23 ++-
> >  drivers/net/r8169/r8169_ethdev.c              |   6 +-
> >  drivers/net/ring/rte_eth_ring.c               |  13 +-
> >  drivers/net/rnp/rnp_ethdev.c                  |  15 +-
> >  drivers/net/sfc/sfc_ethdev.c                  |   3 +-
> >  drivers/net/sfc/sfc_repr.c                    |   3 +-
> >  drivers/net/tap/rte_eth_tap.c                 |  23 +--
> >  drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
> >  drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
> >  drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
> >  drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
> >  drivers/net/virtio/virtio_ethdev.c            |  23 +--
> >  drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
> >  drivers/net/xsc/xsc_ethdev.c                  |  19 +--
> >  drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
> >  drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
> >  lib/ethdev/ethdev_driver.h                    |  23 ++-
> >  lib/ethdev/ethdev_private.c                   |  26 ++++
> >  lib/ethdev/ethdev_private.h                   |   2 +
> >  lib/ethdev/rte_ethdev.c                       |  37 ++---
> >  lib/ethdev/rte_ethdev.h                       |  11 --
> >  lib/ethdev/rte_ethdev_telemetry.c             |  20 +--
> >  107 files changed, 898 insertions(+), 706 deletions(-)
> > 
> > --
> > 2.48.1
> > 
> 
> There is one thing xstats does not do well. Because xstats is a per-driver
> API, there is no uniformity in reporting per-queue information. And if you
> take off the auto-fill flag what little information there is will be disappear.
> 
> I would propose a new API (and driver callback) to query a single queues
> statistics. This would give uniformity across drivers.
> 
> But not certain it really matters, have not seen any code that references
> the queue counters directly. Maybe somewhere in VPP (doing SNMP??) could care.
> The main use of xstats is in debugging and in that case the per-driver
> naming is not a big issue.
> 

Yes, I agree that xstats is not ideally and that a separate API for
querying the queue stats would indeed be best. We should add that in
future, but for now, I think a first step is to start the removal process
we flagged 5 years ago!

/Bruce
