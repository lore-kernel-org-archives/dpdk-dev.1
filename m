Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD9DC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 263E640269;
	Fri, 11 Sep 2026 11:50:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2F6B440264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120231; x=1820656231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nPgP03Lt4ktgjRstDfMlUPFPXRTzg6QXojt79XkH82w=;
 b=T86suLwZ4PzPtWo/o5r5qDiG3n3te4hOObhDsjrU6/scXVZnIlgR5vzN
 ADUtbApv//9crcPDOpv6/fZP5RykP6n8mlVeTZR+qrl3u456rweuEb6wX
 e5OD5XS+IIErNSln7Q3MTAweT+W77D87KxBm2lz3WTzunI0kL0eAsuN+w
 D1XjS15y+7DSHI1RmtpeCIrzHf2tDzfqYgz/sVCcP0MVUMk8v9yrbl7Fh
 i1Zb+bORndi3q20HA/yNKrsEym7MWfAuYzN11BVsiHtcb0lXHTrTHHzdd
 ivO69kAx+bZ6w9i5JO1PDrb16jjFX8CKgMRA/jQlNtloJKeI2kab8DrNA g==;
X-CSE-ConnectionGUID: wJAnYwZWSCOUQSMFR0asfQ==
X-CSE-MsgGUID: NPc5G1pBTTSKeHlkqS49CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100933606"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="100933606"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:50:30 -0700
X-CSE-ConnectionGUID: Jnn+ZEkeQ+OUFfRu5ix0cw==
X-CSE-MsgGUID: FGIIN+NoQ9itjrq28vgeWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="275399153"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:50:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:50:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:50:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:50:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1hH3dn/BOHRP4vlEuCR4QtnqEhaIewcPAoB7ojOyirZDgXN/bRMPFNtGxbVGeHSLWBTzk2E5wC6ifaasDEugE+kf6+QDQRAD5MzJAQrat8zO7aZx2jDSymDgUEEQRq6usah9KMatNENWXDjorM3+ZNcLzsuqomsBxOpTm6yNADq0KmciDWrSivDV0Xg8pDi1AbH1JUAXlj5hK46meN6gnv7SmKOjPCb32szLiGwZfoWjwqu8eNRyU0EWGPw09vbhZxt6ipzpQ3ZBdEUd6cvpJJaNPvw3lDcn66Vo1AvGHQVHHoVZpZMiQYsoGZQ8uvr6gcTBSJU6bfA0DzbdDdBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTbuGv0n3VLDAKMGV/TfUq6SD3bfNxubTk3ZYXEKqHc=;
 b=FEVURQmIhniYqftf72oCLIu7Uf6/uSvPzt57SyXJvmtIOrKcp7K74vDlyz7ggtd1h5Zb9PxysJd0Jh6VI1KPMjdEXb4Fi4ryaZnq4CClnEKWP6JcuhkR1UG6M4qNqMIt4ajrEU1OltHCyaIWqq4XkoQSFvmo1i4SQrk/CtamtHT71uflGMRtu890EqSMYG3IAL8faUp2Cn6N4NyssKthTWm21LgOsjdH/kNuOu9ZTz3DFq/cCPEiV2o2qUPZJTXCXIsO/jXamW3GqrS7Ffbfry1yAVXfj9CuLy8O2s1Mytm0itswK90qo5xuilQpGOYbHTnwDTDbyvOg7MgDM1abEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB261624.namprd11.prod.outlook.com (2603:10b6:408:413::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:50:27 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:50:26 +0000
Date: Fri, 11 Sep 2026 10:50:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>, Tirthendu Sarkar
 <tirthendu.sarkar@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH v2 58/68] drivers/event: use memcpy for fixed size data
Message-ID: <aqPO3RaKocqdT7Iw@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-59-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-59-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB261624:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a0b8cd-c762-4981-f060-08df0fea1b5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DClGqqXouuz9EsBzFhWefh1QaaI0xA8pqw9YONPpVIGqAGOCcQROtj6++XUgv3bh+PMLDxWmNNCNUZWx+PcHPkBE+uw/o+K9NUeFxjEVq70svc5iEr41b/a8HhWTkLJ+REag/af/cOB1WPXyy67DFR+fNm/YfrbMEqtxXw21Es3HH4JeOlg9zW1vHG8MkavmHqVRwquYW2dpbhNKCjKeNngZ5doSFEWdwF7X7W4//pwgmlmOOu1mJ9JbSGLkEg2vkdOUnwxN04EbhuqN/d+ttALofqZSB6LgQIuHQATSyYFw/50mo+g5DYS5ZAVxMJ7URczySgDboVbOEy1W6xmv5o14oyADirLalVjXO63E5CoG03X2DWjt1ItKDfidHopQncNl+DMcfuqnNhvKl8OeD9ZIoK8retecJPNC3d0r2XzZD3SRBUJQON/vmmpW+maibJaBm/9IllK6DHe/+mezkB5p3ly6VL3TiKTztI3CEaFiFHHPCldYnENmJ2INXf12tmQtT7fTfOPp5I2Ymkxa3mlpYN5AQaddemZfVSZAgYO+rDNsGjBkjAuHErPVo+QBtSNpiyk3LERUFyg6nBoiLr3Iq5bJHcJ+pI1UkkQ1mUHLSFVAZw4gdlKNmqvS0qsfKpYVYEg+CqeDkjnS4hSUaWniNAAfb07HLGTd61f/abs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GkOXsjhuaLbJhDxP1meHVquQfIB+mRIlx3FgNYXr699mvh2+NYhOo9uOgyFY?=
 =?us-ascii?Q?ZOQUULPtZsxJEYL8ItunRJ4i8r7lA0vnO/+7XHYdBtaGjEd6lRnu/wujT7Io?=
 =?us-ascii?Q?lQ5bzGHy3sfjAEwH0BQp+WFozFBdI/fHE417/WKLzdexpIlvND8e3MmxqEIE?=
 =?us-ascii?Q?IXSV2BRBklokco+Q1fDcc8AT2nAKRkSx5xMbZCMS/lRkJW2usZFFqukCCmnF?=
 =?us-ascii?Q?Td9sZKzl4b0MBcwtViRm6fPYu/TIKcIrXYD2hIw+MOh2J3deqhw6TruPWRP1?=
 =?us-ascii?Q?stZShCeQsjnukEMoCTZtYvW/PwFU+H5a6mEg2guzobrlQLqvpq0pycDib5le?=
 =?us-ascii?Q?l0ICKzl57CyG76Qb4w7oslusx5KizqhoZruRKpOCBMRlCfufuegpPHfl52Vt?=
 =?us-ascii?Q?EULmEU4kFOryU/7RJ7YImbtWvTwqW9SVnsV16tkWmXewmPuNkQhsXuur7cWb?=
 =?us-ascii?Q?AVNlXrSVGATkqPV0thUfG4oNUlXJWPt+ydzNP8Pxwnwz7CA0R/SyFjmBa+BI?=
 =?us-ascii?Q?Phi0mSn3G2f7ciz57sof9L47hEwxB1NwvhwP2vp6zZhJ26ji8KCELnz+zIbw?=
 =?us-ascii?Q?GodM6Mbik5Lc87Tz9GRNvOUn48BXXxtuxGA1DbQ8v52K6hLgUPF0wfzZJ66j?=
 =?us-ascii?Q?z1R08PpHh1dNnzYWi90WDy6zq4JcdGrQvdS4Vf5ZwL5pAkXsfNu1Zvkc6zff?=
 =?us-ascii?Q?uWcWHyDHeNNkrCamYuES0Fgj1QfruwzUVKOBjMLZuXQxqgLtII8f0MElM5lQ?=
 =?us-ascii?Q?qlJcFeR+wM71UosoPfFGjas4/HmF3EQyyqvPpoppPc0usS4oLFP6JgTAkAc4?=
 =?us-ascii?Q?/VQpHHBBpGMIRP+0/eJxMXtjz1DBb+Mz8dRAL6DWL/ceL+K9RSFfOKRkUk1A?=
 =?us-ascii?Q?PQ/nATYVmjiLSQD2EuTvF5fxpHEIsi1zLtwgOlf2KCZoW8qwJ0PVFWm1fNfw?=
 =?us-ascii?Q?dsQUbrXhACbH/ijYsk7znv3wifjfrCsbgDKJx0D1DfKQooUtoKwAUJKc79Eq?=
 =?us-ascii?Q?I8TvzHJgMqqugtQCGxX6BW0CxI0djRwje9m/HKGQuAoR7o9ATMZbB7XuEusl?=
 =?us-ascii?Q?vPg6ujYfgeGAJtew/w2qpIwTkiFwVuYACkksD6yNCMfUU0UbIZEc35mvf4cf?=
 =?us-ascii?Q?fBOIC5TsR7fxU3+zvny+HrCgO25dblEKxgc8AeG/UxlDf8E8irreN+jj+z5A?=
 =?us-ascii?Q?qFK00K0GHsstf4u74p0wVth8uhatUTEzWDc9FUTJHX9j7um39xvIhKrRniLT?=
 =?us-ascii?Q?Z463XDPuZ2WchdQ5qgFHgujZ2lJ7oy2RTZWQzy7B4OdYJ9hE2jcTHKidhkk+?=
 =?us-ascii?Q?+CgVQ/IYJFYNCdBC/GnmlrgjeLIHOxQKTD0BtDxZGH81hkz9qDaezsaZWNVW?=
 =?us-ascii?Q?tNzvCZNRKR7EMykF7LPomZm05hUUOu1eVTY4BwTg8iOvUXIlFxqqr5wZq0u4?=
 =?us-ascii?Q?CyOIDOg3OxND4z6MkyzLnAZOcoeVE36jQUrcdguxJyYRnIH1AzUi45H4sbRg?=
 =?us-ascii?Q?V94Eu5a3PiwxDKq9VKrQMpBBXzP0Xk9CpILuavt1k6SazMe4shR2Du+kPWcD?=
 =?us-ascii?Q?rSJ9zX+rm//Ie82fe/b1EeaoTHUZdOmgDwwk/clWy2gGfN/wnpKqy4ItuKVm?=
 =?us-ascii?Q?YRROkFZLoF8B5VOoDZw0V09iJjxokCTcS9Vd6cmagaejB808+DnjgU2zKLj0?=
 =?us-ascii?Q?InHR6NKT6MvFPj458NAAKJqrUgmc5RJ5acQoLsbEdDEbv5wQ/IeOtJTtltZZ?=
 =?us-ascii?Q?wKOsqz8zGLfljitgCemeyYOoHkkYP0k=3D?=
X-Exchange-RoutingPolicyChecked: fPwQIZdJcWTm7mpnB+9ao2Mke2+aHNQOjcENB2y+b16GGNk8NBmeYsPtaeGsK9b4Y0CnHVVNMEO3mlPirxQDt4PBbw3LNGS+3nzxu7wKR8OEV78pNh8XziKYR5IwUv1kJHEcgsAPE25crnvtkfe2JYjeE/K3x8kxbuznlC5vWMm5k/p+MKAaPSHz3xRYFc2yQDiLnbIIlGOjCNTIVZpeg3PZHs93c9bPIWZEWCCQmQiiwFsRgSJAZqp3oSWMcnl+eIKdPTaJkbYdZL++W1XtxUyKOYCzBeHPx39SrB/NvZoJ1cc94qTVQ8GqLGf0HWA/xSA+YxfuS8XpW9Je0YNESg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a0b8cd-c762-4981-f060-08df0fea1b5e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:50:26.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kvr6yfys98MZF8uN94uVNjInwAZ27TXGZdgzlP1rXAeSVluB3+KgB8XIZYiCFkMClS1B/VIoGb+Tq3nY3ejuAN7tlXwr7AfB4KraYno6F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB261624
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

On Fri, Aug 21, 2026 at 12:24:53PM -0700, Stephen Hemminger wrote:
> The regular libc memcpy is inline for fix sizes and has
> better analysis coverage.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/event/cnxk/cnxk_eventdev_selftest.c   | 1 -
>  drivers/event/cnxk/cnxk_tim_evdev.c           | 4 ++--
>  drivers/event/dlb2/dlb2.c                     | 4 ++--
>  drivers/event/dpaa/dpaa_eventdev.c            | 1 -
>  drivers/event/dpaa2/dpaa2_eventdev.c          | 3 +--
>  drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 1 -
>  drivers/event/octeontx/ssovf_evdev_selftest.c | 1 -
>  drivers/event/octeontx/timvf_evdev.c          | 4 ++--
>  8 files changed, 7 insertions(+), 12 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

