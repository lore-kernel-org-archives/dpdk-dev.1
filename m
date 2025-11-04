Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E3FCCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79AB14028C;
	Tue,  4 Nov 2025 14:32:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4399440269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 14:32:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762263174; x=1793799174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wIDMwL84GwWava7ZnwGGXDFkMD2I/m4RRM7JaO9ehao=;
 b=Ibg0W4N7uuBzPUDsT+IRf8jSl6x8FqgtHzv0l2t+UHBXWoj0AAaiMRF0
 bZ3bxjW7aBwC9rqpLAWWEZWQz+6bkL5a2FKBr9LHT969jg7PGPrtt1XBZ
 dXHi5JnbIUnlTsdtgcdqlYpNU2co9gCPyZqZa2+nrKBX8n18SIskv+snC
 ZWanrWytPzSM3ox5FxRf2Az0kRaLRd4JZvTscOEpMWhI/Hk86j3V4z4+Y
 Alhz919U+g+HkiMgCBNQsVrqPajvoSkY5BHImrWdey9QbsOEqOwiu1L5x
 1J6g9or+lBmzUwbVTyrCssgOlIcKz8JKlreNvMTCKfaJMZh/iNKZVTIWM Q==;
X-CSE-ConnectionGUID: nqqwBj/rR4mPrn8oqR9ZIw==
X-CSE-MsgGUID: K39hB4rGSPGe1b2JtNX/9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63560872"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="63560872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 05:32:53 -0800
X-CSE-ConnectionGUID: bqnRn+UaR8S0SOflWkWJYw==
X-CSE-MsgGUID: XGNdXm/oR8e1eWrOR2Fvng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="191252578"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 05:32:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:32:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 05:32:53 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 05:32:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WePvjzUwvwSTv07oZvPHDEYXncnZmZNtr0yYiINVQctF6zA5b9jYNEwjTi+kLdcTU5De8jRiQIH/IyikY/yXrEHIKtHXi6ulpNY37MlVLy4q5h5UOyMnuuTkRI4q18hC79etKYheIPwVFPcIf87H3YBaWy2b/2KyXwQmWGTmwWANKUgKR4Wk8qZPZJEb8mAhYPeKpI2r+uNd/hFJU5MWz4A7t9/SyXHF3bPEtSXkoWKwYyg6K5mI2LssvPTt9QLpLH46hwWuPSK7ymg5hHmy/WaCj706n26opgzGT2WZAyC9N9wu4ACFVF1XgV1l5PgKlR3kyIpOcU/1KcjJbFMgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT4hBx0BWp0uUzEF6/26RkIduR1xbFqWP8wGtpaJzgc=;
 b=G9o3jInDQdeLEQI7IEgLTFdvsi+HEqDtne11l2R9bgzDYxNRj80H05KpZeHO7cg8W5yrR0T/CUitopVRUs7aMNBdYvgDY/HwkqL7pyfcbCZBYHUV3lmHSsxOEL0HsPm6GF7QeQUBMdt9NQOkVZuem5jx1HnfCPcA7jRs16NvSZpx397hH5RYQBT1srzFh7T5CdVAafd6frLei2MXquZYZTj46zzPEwhsskc3pvJHY/XY+nzJG4B4R5karMbM9gmUCDX1yitDxPG1Vdmh1t4OthplKg7tLWJHdotcnsJumbKhshXtaL7ykHo1YpONbxu8FI/Lol9/CiORP4OBmZe4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:32:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 13:32:50 +0000
Date: Tue, 4 Nov 2025 13:32:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] doc: update documentation for ICE DCB and PFC features
Message-ID: <aQoAfOVh3zmJ3MPl@bricha3-mobl1.ger.corp.intel.com>
References: <20251103155150.965108-1-vladimir.medvedkin@intel.com>
 <20251103172621.970792-1-vladimir.medvedkin@intel.com>
 <aQn_Nzo16b7loInb@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQn_Nzo16b7loInb@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0256.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: b9994a0e-715b-4f9c-ac74-08de1ba6a699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3HM4m2ia9yRCCbl3Gxc2cNgvr8xZsborRZ6P5Lz1iP4TQ2YYrJLDtBSn85E?=
 =?us-ascii?Q?Y/DqLN4tozcOvZYT2YX0HY001QgLSEyILGpwmtGBRRz1Dy/MfyPJwqYsPdXC?=
 =?us-ascii?Q?8AhgDqtBr9uwPwNUfYUxgRtS9zg74Sg4vg5irnAYsKS5HK1blUsW5wFXEWeX?=
 =?us-ascii?Q?CUK3WjhDz/TW+Gps8bFP9N7/QAPV+MrllCMssISTEdDktUXB1Nu4D2DmkI3S?=
 =?us-ascii?Q?txDdR3h0wrCvHvUp+FSvYH/r+dK8xqSdjUCW9Y/ul7lRdFT5yxRfrTBMJuyW?=
 =?us-ascii?Q?sC64oqIPg1IeXDBUGuH1QPynK70I6IUjWQhRdLrDwTpDNuy7SqeifOELOIQG?=
 =?us-ascii?Q?3dQ4I/o7Iye6rDcv16H07cGJSUnSqiHQfI6gkLpN+lICLm/DRpeJ8lqNTDwK?=
 =?us-ascii?Q?5kcgqItKaosjp2zbdqriPLIajaH6jNLmXV9nqTZRjA9PCLQCpw5YD8b/SLW+?=
 =?us-ascii?Q?A0MDZpJkGzQyEOVBXhsmg6L0YMghHJQshlV4uGZ0H1VU1vtlkc+YEPqN2a3d?=
 =?us-ascii?Q?Dmyoddhv80Y0byU8NYbwrS8DplmGt62oRSMiKM85EigVVaTaPy+bwNRQFYJQ?=
 =?us-ascii?Q?f3ZEEscaWo3zr1uxRHhMTRcaoEX/HLWErXIFZA3ECHxlN5BSyzzlGm7f5C+k?=
 =?us-ascii?Q?s7TqZifFwysQXMVzQHtdCNnw1BZWPAaLkBXryRa6wXAbYvrSSSKzXiDYt0Tv?=
 =?us-ascii?Q?hHE3gF2g62EiT0dMIUt2OLGESxHz0YFouJkGlTD81z1+bgcamxbWu4OwREEK?=
 =?us-ascii?Q?4K+5G68ERyt8KgO8G2k9h+O1n9B8s/bkWGI49GvQbFCVWvbFQn8g7zGpoKQ4?=
 =?us-ascii?Q?olk7ffYoNGf0adhC446oBkSlxUs1ELrkqeypuMxuhx1d/Bv3D9jMrQvn/kBu?=
 =?us-ascii?Q?RctlyFmQUQdtGDoi3/OY0MkJD5X1Ap+y/HORndh5WdG5S6nGzcUnRKgKsHk7?=
 =?us-ascii?Q?lTMy23LOCkNUoo968za15OAxhqhZZ+Dwxdf1ozlxT9NRwmA7jyLKUB/AemQJ?=
 =?us-ascii?Q?D5sJki0Y0g9o46j6hUbhBcwEcPevB4dWfqqxJjbjptxosSF5kW198ndaM8my?=
 =?us-ascii?Q?Fm2EwQnsUTWvPSx6fEzcOo7idQKyl6Gc9jx2HJehr80qjUDbJX0+66lR6/zs?=
 =?us-ascii?Q?AztBE8Mazh3DLQLQq0lkLxHR+pb0gDlSl/cBIVyAYW/YA+BnlClIesakPO4f?=
 =?us-ascii?Q?Vvt0VxakECU73lY+dKKMralqpTzJ2fDkUCugzoRdnU+LvzDX8JUZ8GmQpQAo?=
 =?us-ascii?Q?68wp2xpcV4Egr2E6305RuwpJS2/oG7QydV0URvzVa5rHPEZG1KgF79QeG/oE?=
 =?us-ascii?Q?lq1KXr0maBLafb6XFnNTbeOcGY+ff2uWqTZ4rIWS78/RBH9tM3Q02wSH+15o?=
 =?us-ascii?Q?a5OoAjx95x3GZbm71KboMiMj71cmI0nfoWseLQC/rNtKm68RLrBhHGrSD0A4?=
 =?us-ascii?Q?QZvftRATOB0wi9++5+mhabw70Torp7nJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdFZdKvR0JEQQzK7pXVrF06ZgFhjUoPMWWJ4fPHzeBslvBniHbrFfwYqVso7?=
 =?us-ascii?Q?iwmHABJZMdLWHP9BsCNrE3BPwBQHXKvDt5TMVCDPxhtZcccsGh/f9uUSnkDR?=
 =?us-ascii?Q?Ap4lBZtXwZci9yACetCCeQHM7GuMpjWbW7tzOoh1ol7/OIoFJgH4ZXNBkjKM?=
 =?us-ascii?Q?x/z8raVkyBI1x0a6G/O23oXtJDN3b1NvS6C2h2fYwRUnYFgL07YWqTTuSvmu?=
 =?us-ascii?Q?9oCAMsW0MBdZpOKe0AmkuxafpkkO8XA9gZ5x8QaY8l/zscgDa4jO8vV5ORYk?=
 =?us-ascii?Q?YsspKnChNJNPZ/JLxaReAjijTWGLapH2qX8nBMJwQn5SXpiACEW8NnlQzIxk?=
 =?us-ascii?Q?WHD56CDtiwze5eaUltsNQ0Bya5QopCMATutFytqKz2DTsdWR5RJ5H04MZDj/?=
 =?us-ascii?Q?nXOenFDP6S+bZpZPEZRfE/Zh1G0/XrJs4Xo2/lwmTsfZSuMhmD/LDNG/4i8l?=
 =?us-ascii?Q?RqdXVU8EOXyeHQPK2RU5ereTxPc1nX17OiFV+OUDJ32e8qVmUE89tTVWYpbH?=
 =?us-ascii?Q?ssKYo5ZGWpT2LitXgD5l3OiutIfh1qx2Er7jKJDqhFUcc4AQw8VAJmqt2vOC?=
 =?us-ascii?Q?eLbr364sgPvDLoMILlJSijWShqsY5ZQSlwMjE1HO/luuP7BkGxT3xZZj5YwK?=
 =?us-ascii?Q?yhiOmtfKXcCaeTzn9pJ3HlutPODHDHR7FssekQ4kJZadriuTAPdSHAgkLxwA?=
 =?us-ascii?Q?1CTzm0mMeDCzdoZXbjboQ+znet5ABq/xdiwhUkRXk49IOWDgmKh+aKzV1xF8?=
 =?us-ascii?Q?ZWhQXIDN2yosWStWkiHPr3N/fwHPnxDqyavQyFy9fBQKdYM0Ll+R4X1F2yng?=
 =?us-ascii?Q?kVE96EshyzvobcEBTgas1pUAF73TjXdaHMCPheYotGPk3oiBOt9ZlzXGYmUq?=
 =?us-ascii?Q?B+PELJ3Wi4kZxYT0JOJYJ0DvcNoH6YbcgVMV0oWEBd/1XqWi4vuAP5G0pzSw?=
 =?us-ascii?Q?xjVlj3/8tZRy0/2hdpcuBM3rb5wuF9km5NbivnJyiUef41qAcQogRCjdRYuR?=
 =?us-ascii?Q?I5fWJxF/aS5Xmcz1Sy6HqlVEJAl6st/OYzW0ZNpMpEJ8sa2VhKaVoHYdShH3?=
 =?us-ascii?Q?Q62Sgw1XHgVtbXwASeJEvjMcFzm42OB+kXvU05buDhvbf/pTAnmnE5y8qu6D?=
 =?us-ascii?Q?+DA03D1HT0z5isbkz631v15Dz6QeOu49bF00pcPZZfOxQ3pw6ELYi0yCRfSE?=
 =?us-ascii?Q?+I3YW2tTfJhgS5YlnbMeeIAlVcFwXMlvazw7T8n9gD5qbrH3nBXPrhRwPioF?=
 =?us-ascii?Q?WhHUJTx3wiNEZCCPTU/bC9l7nCx0Xoks4gFRKC6zv6P8dZPNo67JT2Eo9b65?=
 =?us-ascii?Q?YhsD5KvdrAgTZmuL+ReDNTrmWX86hHyK2MWvLk9tLrEmpHlj+Co1VfdZdAZF?=
 =?us-ascii?Q?7Zg58l1g21ScqiFjlS8yb5z3I++cKI5JhIGsEa+72Xf/HIrmkJtEAvjCF9Qr?=
 =?us-ascii?Q?vsMquz5+gzR70I3b1+u5XvwrG+mKZhiy5F2A+A7brl72nYwWdZfGuJQ5Equ+?=
 =?us-ascii?Q?26y4qtEZZuLZ/QHfKbVabmkZo8CLnRyDHzOJXDljhJTk8eyNS5zRGppZXB1/?=
 =?us-ascii?Q?4UkyDQJugcWT6A73btuKAIP+jMmd4EGvLscZUo3YfadgE4gRhOQDeyr4wGTT?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9994a0e-715b-4f9c-ac74-08de1ba6a699
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:32:50.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gifFugNk20htEowB4J9L6i5xv54HqFNgBnCgvmmmPh0VWrvvzBCEyuaFaNjdESXBvAPpy0nfbq9kt4+YMDNZsAeRiplaMrt8q/TKFsob3xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
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

On Tue, Nov 04, 2025 at 01:27:19PM +0000, Bruce Richardson wrote:
> On Mon, Nov 03, 2025 at 05:26:21PM +0000, Vladimir Medvedkin wrote:
> > Add DCB and PFC documentation. Update feature matrix
> > and release notes.
> > 
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> >  doc/guides/nics/features/ice.ini       |   1 +
> >  doc/guides/nics/ice.rst                | 102 +++++++++++++++++++++++++
> >  doc/guides/rel_notes/release_25_11.rst |   4 +
> >  3 files changed, 107 insertions(+)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
