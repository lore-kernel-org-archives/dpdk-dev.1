Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB407CDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 09:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB0940150;
	Mon, 22 Jun 2026 11:48:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6229D4003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 11:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782121734; x=1813657734;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A58YtT+D+tF0ZIHhUXmEc8UAqXPfRkCO6n7ID4/eY1I=;
 b=dA6F6GVCiyo4Pk98jO1z2q2GWfRh+gyBZmb5xytooY1GbuNRfS368K9G
 ji1IUkxCe0v+K6VEGtNvyo604yEEaDibm6W5PZFMWgFg9zBbsCiAS19rp
 fPaCbjJrcgrOWo9I3RZUmf40OrfgRMLu3YbaamdmXMgea4wxJQPUX8C1v
 XQy6mh/wXX3PGKimHuTu9jKO4h/tocOyaGBqlc//R7tU4MypQDkJtLnk6
 NorecugtLnp20kGWAXh6hAc0vt9DIZcDAZwdEDrWCmpd6ZUmcidduaRcD
 p2eyGv59vDrau2yvyAJmvch75SlB99c7mzQ5X3EY+Cu1X7ZWljLoZE21a Q==;
X-CSE-ConnectionGUID: SpW43IbQSEiyUa6dDQgoMQ==
X-CSE-MsgGUID: UPsee41RSNSaNK0E6/do1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82715676"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82715676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:48:52 -0700
X-CSE-ConnectionGUID: mpHTfVBuSrCeAX1uiW/cYw==
X-CSE-MsgGUID: EgJ0sBvxQgiNM0WU/2VBrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="249285593"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:48:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:48:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 02:48:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0hKrjJ3/zu4ugFfmjhcDFPQva6AK+ZUdPJvDvObaZ8TJlWO8DVQX6VYk8oNM15VGqO95ZtaVjHv6HAs5hlQ+rK1ifKAHW+vcLYTxg2ggp3S5CjWPTIIxlr7qUN9aeA6Vu6ZbymwdFUsqChGJLTbhxScm7mvH0q8BZ2RGs/N4Uatch7tDwOY2Pl5TMH3lEmA/avbHLT9sVJueZr1TVWBWnI6pkg3GgYwiTraahQl5z1LotUnEp6FScRVfQc7aQuuHRT/a5NAlV5NpcyH8X3Fg+jKLCtmEePwPNA/cMZ3x/KcDOQ87i1/mFCgVD2yZsw9B7WHADQibV4caooNcLKrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVmNG+f11gZZxbsoyqxd5Xe1fF6iC6tvqRu74tLndcM=;
 b=tpTBFArMgc/vyStQ9cWD+v97fvu6ZGlSXiusS60nrc2T7649hIiUn5VxvQ3iUhM/bXFHtAo9LwkPlak4VvfhDC7oFp+EQH7M4aEJQMs4QVJFZtT/iRP50zXvn+0jNPuEP8m5EUxePIlqGA8H4RpR1Zpn8eFe6wNRx31cgjwG/reVChInYY90+q5DgHyQpsW/Dgi7gd4O/lUBu/KlaIWxV+AYkEzmiyE6TlgfNCTPWb6/GrgNs/CsCPudfzn1Sg4LIkgColYDslJJjv932IfXfaCT2IAdm0PjEq54WaZt9EpHnxE835ACz3wpy5b82010LjZnqv1aUrc+Q1wUfTWsmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LV8PR11MB8721.namprd11.prod.outlook.com (2603:10b6:408:203::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:48:47 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 09:48:47 +0000
Date: Mon, 22 Jun 2026 10:48:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <longli@microsoft.com>, <hemant.agrawal@nxp.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v2 02/10] dma/idxd: remove next pointer in bus specific
 device
Message-ID: <ajkE-iBGJTEjQV95@bricha3-mobl1.ger.corp.intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618152826.490569-3-david.marchand@redhat.com>
X-ClientProxiedBy: DUZP191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LV8PR11MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c48a189-222e-46ef-0b11-08ded043748e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: THZBYlt60HXy26Yuwh4krlauBpolmO4ZD26T5SF8BnTzPzVNP0Q5+I+WhJpmVdd3UKf79Lf3Lq5+aow4jaDDtYKPiP4xSHFR2oERbVg5dxBLy4NC7063+J0UIdtvZ2DAMu6ohhhr5nxbj9BRJ3Kt84NUS1gyyLV5CklDPvVmSyPp0kXAed11rsqcP0t6SrF9mSVHQnORyBH3z8UC7+jmQlATT1Wa13d3bQdUhGaCOp2KWk12Uc/YC//0gOZ9e8GlIMDlQ7rhqRiWtYksf+O8AwSb9MZgA45k7B0JyiRq5e3pgnVREflMOB1f2oI0+KX6XBzLOTj37GOwhWLRacQ2qJp4lYMM5+xKxDQVs5uQHT9ZNsPknwCjTxFw+S0PWiT7FhK0jYSRM5c7tlejeUwVjmFXfNfw7p5PfoaHarBNdOt/uRjrUFy4oeGtvrjPLX/5OqUhiOejGxgDqmvDg1vBl2QCttsm2o5crHtCIytDDQP1kYiRbrNyz5mWPl+AwMjukcZ1qJwM/YFIo/Slu+ZF/EizWC/1gAUhABu6WxrgSlJrhQawRx0FhUIESQ2cm3Vkg8eS3cb8PJNuNk/zsOqXgFTFFP7EdfKm2S+y5ic2Jf03o0a4JwzSpD/KqN/VCFcLf2VAA3LMfgIyJxlwcG5IV2xkD3hDhD4As4ijhecM2z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29ldjLaiNhrFk0v04TYTLv24EkFarYMYl+cNQIH3XXBoWFWZ46KDZi+2vppW?=
 =?us-ascii?Q?0YyxiT/Nd5/gAsD6VWvOSU681Fn69c7NLsP2Oo6DOGI5SpiMEnigE5aJxJ77?=
 =?us-ascii?Q?ahy1ZjqfQokxxuDESasmxrLOcjvfznNICcxvfUreT8GZhotDlPR00io2fHy9?=
 =?us-ascii?Q?wlaqV71GsPWhfTzD9OIXq1rtIP7dT9WsJbNvNJV0rOvpkemgJAtNsajEC09G?=
 =?us-ascii?Q?PfaEwBDIokL36L7hEjhvrSAvwGA+YdWVFxgu+fLQHCLURyB1nCI0QZLEQw6m?=
 =?us-ascii?Q?3cOnrl+J6e+Fkk/7ZbBjrOF2O4DoPqoqByO/SqHAjezu0wGOHA0GRRPZK7M1?=
 =?us-ascii?Q?1ddUnxyEUi1nS+cJ0fXc07+uDt8NhBE3jDSGW9/wLqCZkp+sxpBnNaNlKGOe?=
 =?us-ascii?Q?sUbce6Jud5j5b3Mru7mmOPIOR4vkXIwq4xPQug1Jnc/MULUPHCa+DihT7kCv?=
 =?us-ascii?Q?EmvTnqP0JTIEqHIg60ZHDPT2jfM47M6K0cO885waDx5bUtIyMJKfJ9zVVrGq?=
 =?us-ascii?Q?38wzq2I+BiX/65zY7ym0BEA4MHOLJd1orwLvMbmSo993NSZHwoo4m6mpe3pM?=
 =?us-ascii?Q?KtM6LzpG33Xcprr7o6S+MVY1whNT7vEVWETGv2VCUPdaBXeCoN7Vfl1dQ1eq?=
 =?us-ascii?Q?Cb70JeS7VQEEkkvjIFMQdVBHumqbWMnIfn783/l6hVxrc/vrY+mIDqgIrA/0?=
 =?us-ascii?Q?yfJ6dvJhkCllgBkSLMWLv5XeK/p6xMhAur7FI+D5LbQB2r5VA6DVwOk4i88s?=
 =?us-ascii?Q?t27780Ffkbub2ey6HPb8oHa9/CF9uYiUgVuxk3LM2m12HQi8d6Y9ealCX96t?=
 =?us-ascii?Q?KyqpQX3lDAnUHTSlqZc1YsArlEqLtSJylXK2OoxxmnGLJKhiTfGo6ACuKhjD?=
 =?us-ascii?Q?BeQC/hpZfLw38kaSZqiKgmdUhtd2ob0QwgVTFCpjm1QgKHR7LXUy86ED74yi?=
 =?us-ascii?Q?FQyv54dg6L0kahMUKfCdEj8RR0mm4xivw4nzrRsIok6hlYDASdKX30gEVpk4?=
 =?us-ascii?Q?+JxJKFs1rKWR3gLCmEBVNbXB8khWiTHdu+m75pnuU1cnTKe6iAUv7HY8lyHy?=
 =?us-ascii?Q?tSO82qSI8T4N9fyFofeluN1n13v1VoCMFzjZx446qIte9ysYzEtP8KwaJLva?=
 =?us-ascii?Q?pcZWh0Qtph8plKJQeCpslZKZZiuk5IVW/vLV20A8yW5DAl8Rg/3TSr69EOJC?=
 =?us-ascii?Q?K18V7Z8rKUqkcn2z7sc4YoPGxB0N7NpTVVSrEcXMgw4nDnx5eHV0Rz5C8b0Y?=
 =?us-ascii?Q?VXEKbuSn8JBmNx+KekTFfiQdMApcotEYz+Vnbq4ZbeCb9HPTs0jhmtKy7WJs?=
 =?us-ascii?Q?CFguafc/sdofEh4Nn6Zl6EWSTEN+A6Av6eQ9OgBfEjXZDiEcFfM6xKVOFQzO?=
 =?us-ascii?Q?vbaiVhqi/uyt6HtqgW5zWWsLTSUgFetg8cX0a26kP4/xvYCO/4LTg6g3ViQL?=
 =?us-ascii?Q?Z71nS69GDd8W5lWVPMXv14DRlQgyg13V38L2kch+zfBr/Zu9GbwcRr7NFmIr?=
 =?us-ascii?Q?No87gV6FB+if+vUSZhiBcN9izUcFaNGzPi5ZIUe8hB/tpoUs/PEeyIyZHH1c?=
 =?us-ascii?Q?9NWbVeJVwm4bBGOnJnfSa4d3yLJwANVWt+KPxcTpDMCkLsovK3RmqS8R4C3t?=
 =?us-ascii?Q?8Z5ubReFER4WTxL/TIgisAQfVRYajqT4JBYyFGojlHiDdei7Dt8vkVbTUvGI?=
 =?us-ascii?Q?BdzKFcH2r17ZdNTwXwf/HHNoMqOp6JDxyRIXk5ScwkzzUOwA6GAjkTO8QDu1?=
 =?us-ascii?Q?TIIbEGx2Fw6MlleQafWIVfENyTn2sJ0=3D?=
X-Exchange-RoutingPolicyChecked: BUjVNuY3nljLr00KUL8fgyKXNw1Vw352IUOcVcprq03kdoTr7xQf+WnhyPkaRtnUZUq08cSywkLOlBXJq31qY5/mwHNL65au4voNu7eNarubsVg42JWIu7IftxhYNtoZB+AkE2RRKMAPwBbyA//YTh0T5l0JciTBUxFtL01XRzSwmSTScjBPAeKEB0UcMMXDtt33KHJ3S+LwT7ecr9RdC2StUcgiNwLQyB8xqysD9PQN3oPrN+stuKgujhAviVUHVlkS1qXGKHLGqJtL3NjOBJyg/jUlhunB+vKGN9KgTyUjlD/NVM0FJtWJ3YxrS079pXZHqrwiQneLB9w5je7mmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c48a189-222e-46ef-0b11-08ded043748e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:48:47.2305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAfzxoRcO3/P0r+BrjtNQUL4QswOyuKJGPX8ff4yiuZNHT36u+BqcpYrFd12UvYQnRYqXQO2JvLgb5f5/ZgsEWq+i0+NlSakOP7Yr2MZjH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8721
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

On Thu, Jun 18, 2026 at 05:28:17PM +0200, David Marchand wrote:
> The dma/idxd devices are now stored in a list of generic rte_device
> objects.
> 
> Fixes: b4f0974a995b ("bus: factorize device list")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/dma/idxd/idxd_bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
