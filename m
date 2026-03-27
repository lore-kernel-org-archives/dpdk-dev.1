Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0AA10ED65C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 11:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7595402C5;
	Fri, 27 Mar 2026 12:46:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9180440280;
 Fri, 27 Mar 2026 12:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774611963; x=1806147963;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zEq38CxwTXkhrN8gOvIpg+05779n5DMkfP2SXdeBf8Y=;
 b=mwocZp2LrBSa6UyfIBPMBnT6MRJh15MmeUIFDFCzaiCARw62Mz/agFgg
 gT6anfcO/ILpXU1CrbwUAH4MWofQy4L1CJE5EZ5/q4gZBv3tv+ps2x9Tz
 N1iP3tlAf3IuLn+yuHsFQPm10VARVNiE1KIEQTBudg2ty4haMQpOkyGAB
 m26SmxFM0X0YhKZ8T9z2xbqO2d0vP3kclmb0fXM8j1bk8AgyJ1Zo0xESJ
 qn2PVYhD7TE4DqFk87kcFclnH3hWOX/4GDpUCYNlIvHsdI3X+qbpF9qUN
 L0IxrEwxcKJdtv661LVamJHXmUhxuF21BkZqLCqj4TPq7wUj6gzbMSPra g==;
X-CSE-ConnectionGUID: rP38mf+eS4mlb/wFqfoFFA==
X-CSE-MsgGUID: K6siizl4TaKq5v2W4Q3IBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75564495"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75564495"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:46:01 -0700
X-CSE-ConnectionGUID: L0iPlJ72QDOGfjG8i4ijYA==
X-CSE-MsgGUID: ++auISJGQpWVe5dnw0Nl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="224334679"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:46:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:46:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 04:46:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3DJ5G1Ovn1o9ByyJdSkLaCJGS+19ASl2ravQ0Py8f/w+6mXriYwV4iLOFX2rHFiXHImiggu12yzyL3TNNDHTzYs+/WcbHAwiWsXg8IovAs3vedJqSUpEyT5PW34Oti1EhvsIBKTaFVU8EwScdgY0vFNiLpBIZvHFdFbGQL40+Dc4m65cSXXM5SsO158bOtyCTBksoDja0RX38m9QEPZVZO9TQr37dzoe21lngWnRDb+z/Zo18IyL81pke8/wka8S3S0x4yufqlctQfeAjGo1fWwWzgdG94Q88h7TPaDSa5m8MzMTfVGDv113fs8V7LFfJ2uOPgtA98GKI7MZO+BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjEj6BBsy0iywJQmv0N5jsXrdy27GyDLfLVIwTMkVvg=;
 b=I4NcRY6SY9Znhw0JOvOt09au1uAMEX9rkVmHcgIde/yEQWRIrYVmD5p3Dz3xiugfmjAB9vLLPD63WSUVWVxYkCqv2RVnr578xwJdm2ijyGtMPc95ZBdxga15NstDctwfSAdtI2oWtFB1vWL+bfU6KyKV8bH2uoTch9ZAiOJCF2Z/WR4ZqVYs+O0ggMb0oigbw6FejHq+KBalxFBUkfeBclsjnCzmYB+08xED4zm+Hw6RH09HnCZeFrJCIx5dXhZHrIEfaYFKGBz9go+Q7Ep+LepMIkbe+FGC1PWwtjzIXwpcr8Ef2vSK61smnUQIzqevDyOtlD4Wp6I200SoDbU3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 27 Mar
 2026 11:45:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:45:58 +0000
Date: Fri, 27 Mar 2026 11:45:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ice/base: fix double HW reinitialization
Message-ID: <acZt8nxlDSC9bPHT@bricha3-mobl1.ger.corp.intel.com>
References: <20260326182035.726123-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1CEA1720D10AA42ABE2498E57A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1CEA1720D10AA42ABE2498E57A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0166.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 89646038-eeec-4618-7cc2-08de8bf669c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 1fTjeHEzkWPaOssvdfXiD3qOAa9y6CiYOIW2LI8357NWHAgdAhX9VnfcoyOx1bJos9JbFc2X90pdr/XRMi/eC3w4Hd6N/jnJUgjE8NAJxBCafawt9iHCwh51fBiS2xAjoJ/dyvvnAgFBnJsCeJ5G1o8axlLoOLYa8QZ+8PN0UMoDClKe5lap2yJPAI3Tih8lYtQRGdBPEqzwF4VLRLFjoo62VAp0YJR7wXh/NFSMOOmdIR57PU+aHqrV4owi4ZveE+I+RlXn+oDaVdkIglTBVtnOCKd83MqmU4Hi3f06ckZuH/43HdNkhnv6Nqj7HTKUdIsgZGbT62hIEaSK0O+s3UAbCrClPmAKttjwrft6AmlPX/RxFQQs6mse9XeGBZUnJ2cxtdyzyQYiLCjtjmqh9nrJj/3i8Z5JAy7/SEv/IKbbC8BYbPm+zM+4wxx4vRtA6jXgP4eDxyCgHqfJk+NAfkDOJy/AjjgiJmSG/xdct/Xm1P478QBYMtfPsMXPKCQvfYk2OnlWCZjGHjRCIvZ5xVr5dnXXx6dkt+GAApgs/OhKswUyhDx3P9xlP5jsDxbW9SScRUc7ewT0TO91CcMLaVJe+4NpFjXIMMpXwGL38/BweGNVeLNo00BdH/V0mpf+onosPNPI8FwCWkOLjfliLUPF9lIh57SZsEVLXTrgkkAcFxCHNSdEd5Y378S3TVU64Xc4j5umKLXDsEJMWXgAqC/+ET4D4gg2Hfe0ZALqFos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzyQmMjwyzK9MapzFZiooqO6IrT/oNTJsDy3MLw+3xLBPZxs7bz7FD5Qtv/D?=
 =?us-ascii?Q?+RJzqrj9auYbh72vqtWcNhW0kn7/x1rC38iBy6l031lYRZASKD5znMBFCAOv?=
 =?us-ascii?Q?duTUYqSJqXC1Mfiwe1kzdTaM7LLa4WGZ6SbITUbpL4kPsBWDRcmfUC8Di38v?=
 =?us-ascii?Q?lQRUpovmoNYXt2RrrF5opiC4Qkc/bpHgvrBp2P1MscCgymiWUm2BfVdHlZLB?=
 =?us-ascii?Q?mMrfme2WDJxaxfBBMvtkoU52Ada5ookDC7szDVxK4ecY7Sp6+ud14XRGnVXi?=
 =?us-ascii?Q?COG2IXf1BzHMIZrHaPmqcdXvhQh4jBoE66Jyvq71xpVOK+TUrlZTvpJC9Ksd?=
 =?us-ascii?Q?xlcRJCubnli9r4Qfmn39iAbL8P/I4eKQSH6rOAn5IvTN8+gSXza7PDq/7i0w?=
 =?us-ascii?Q?97E8RvQxbUywlkwcLNoa990N8JFkyH77m8i7jBOffVCpiXEVknHHF3YAsE2J?=
 =?us-ascii?Q?pwNBrX4yeOmFyqEYp0vN3PE9/gwT6lo9xhqlro4P3QXis9pmVG9UTamob7MH?=
 =?us-ascii?Q?9VPzUMHtFrK0K69CxK1QQzvKiuTntfniVmoisz8HXRgI+9CQG7S7/sPV4bhc?=
 =?us-ascii?Q?MMq5F2RRV4iepHFVqYx2ZPk28iXiqVPmQJ9AVFF3bqJR+li3nFFQUTg+/9Do?=
 =?us-ascii?Q?dWfoUe6OOPm4U9jukyBbcKoMe53m+lKyLd9tZmW+jVcuZzJH57+xExBmkYZU?=
 =?us-ascii?Q?VC6VMbCUl8zqduU16hhR0GtW6uR42J99ALF/dqOXVVSUOjcfH0PG+syXmYm6?=
 =?us-ascii?Q?8GRlplk0g12xrHnN0Mmmnc8rh8MoeTk72lUmQUuAFBpjINbMcD3VR+tYZ1bl?=
 =?us-ascii?Q?DdstTjwZ1BhO3wsnOSGpSd7KE4RvLUYwjpUDrN61x/BySc9Htwa5Pr4EyGH3?=
 =?us-ascii?Q?9OqLEzla4CN+gLxGc4uA22R+Jj+Hok+8JJDucr/K54nHf29zoQxhN1yN9myl?=
 =?us-ascii?Q?zuiq6yaZ5Jf7SfI61fXnVrOoFmmopPDLzS5diEStUfcr8oVyNbC3yEs2/Od7?=
 =?us-ascii?Q?1I645CExDqLcOEBZb5owlkns7K3E6h4LPDqC9OMwgvSk+Fhztkhp15nT7a9a?=
 =?us-ascii?Q?XLNIoNMrfuZvISuKg9+0BKEzHbKEG07/wGntsLPh0zxJi/+GfFHviMibZ+xX?=
 =?us-ascii?Q?J7As1Pp8l5Kj8xkTq7Jlz6I+v1UfSZ+sLbv95O4UCUmsktdZDqNBcRHnxTV+?=
 =?us-ascii?Q?FAP0YoseLGytz+BGfPpJ01hLaoMAyeZy0FQq79VwSec1f1A9tdk5wBCks2XF?=
 =?us-ascii?Q?ET+vExanQy19dg2kY+Wv2mLjNrMpZp/SCiVXLxtR5x+oPj9E2zpQj8BAMptm?=
 =?us-ascii?Q?o+UMX3yBXQ9vOsOToTR54fmAoD+fubTEPH5+MF4xiL8J3haw+5Q+q0e7Rids?=
 =?us-ascii?Q?3hyXJsPI0tHfb+5PBLx9p2etitYO3mVD431iJnTLLiNHCawDiLHYvB8E2j/I?=
 =?us-ascii?Q?xANSEvMGTRnwx2I19D+pL+0oF4641Bl1eCHRf77QivaEbFpKqynPRwIwtaek?=
 =?us-ascii?Q?LJ7ZpuW+8aF6KZ5Xn1uAO5qPrGyCrrqg/drS8RhhE0xSzt4W0YIZhAA+wTTR?=
 =?us-ascii?Q?hrqpnhP8/VBxnNBxPiER+EuKZO76n3ySe680eIATd6+hNcU9BPRND++iiPTB?=
 =?us-ascii?Q?L26WsmWCmH1uQhvqDWvdJzDTMK/m7IoMNuxD/ItekGBvaq65VluevxoySwxv?=
 =?us-ascii?Q?2IE+quOhVHT8WZ5K0uj47Nkv5UKAPrQj0QGGfnEr/6TlpLpye99t9mSqu5qr?=
 =?us-ascii?Q?9J2I7Gx1PTY0vbCBvhXjV2UhxYz+Tcg=3D?=
X-Exchange-RoutingPolicyChecked: bUfOY3qGU7iw4m7HPTjJyMZ7GbpFYS1jmtJHttXfE5coSeVmMbkT5X4F7et+P1E/EoBt2TLPrgCDjsbbEyK73+djd3QJ3YBBpYn8nIi4XHYSC5M4pEJITlbTbz3Vwf92Yu/GCP1YGrXWAD/kQhCFbVe0e1R62JB3JOZ5f9QofL+R75MXteXZ18rj+QXHf607AaSg/ZKP1wovEa1R91dbsEEOBJ/tcKbqsCDgw5FnTSLKV/g2aMGSYDjkR3EvWhjdPHjo7seAwMjkgM+D50lgbDGL+s4uxO6xHASWzXr0l5qIp5qzz3D09L56KNU9WekJ3rbJldEQ7f/AF7tfajK9Ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89646038-eeec-4618-7cc2-08de8bf669c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:45:58.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/kap6JzGBSwdJ5xOYbo2c4RwuFUyRv54Y1jLnOfq1lfw5ei06qN1XYon4aL9CFmdugLoMBkbJ2KuuXv9tpqeoYxCzZj8e2RNd3StyslWEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
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

On Fri, Mar 27, 2026 at 11:21:54AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice/base: fix double HW reinitialization
> > 
> > After downloading an alternate scheduler topology, the HW needs to be
> > reinitialized. Since commit b47c1229d617 ("net/ice/base: improve global
> > config lock behavior"), a reinitialization is done in the topology
> > download code itself, so we need to remove the extra initialization from
> > the calling code.
> > 
> > Fixes: b47c1229d617 ("net/ice/base: improve global config lock behavior")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Thanks.
Patch applied to dpdk-next-net-intel.

/Bruce
