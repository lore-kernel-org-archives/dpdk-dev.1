Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0AC4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 11:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFF8B40270;
	Thu, 16 Jul 2026 13:06:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 17136400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 13:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784199981; x=1815735981;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BOnUeBwkEMJGjKpfdJtRNZMPy/f6SCAxmmM080uV6Ok=;
 b=TP2hb5cc7JOTXqGdi/CTQ7CHp+tc/yPts0p14rpCL5fnKbH+9+pQzgoY
 1FpjPNF+aRP7ykEz2szQzXuNCds8w1sSEpQlrzn59KjOmuDSfYrZPqNQx
 Mbege0TkRoWwDbgAEsFHeK2Nr4mcusyMC05bfrD6pBCCgskle/CmQGU0L
 S9PNDUv0iCpOa4DRh5aO+pslQlh7xrJS06RjouI6iPKlcdMfBRH4+jblz
 KCFFmiqumYjEnYgu4YVzzemwcJ+Git/KL/wGb4y/urjqjBtdm+3DFyYPF
 0A97kfZK0/QMi1zWBOYvHGrrKe2NG4zR80MydRB2xLwV4mmLZBcKUSYqg Q==;
X-CSE-ConnectionGUID: CJ9Q+4AORRaN6A8yc38GJQ==
X-CSE-MsgGUID: flPCoADlQCyoFg+a0FbYAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95459223"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="95459223"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 04:06:19 -0700
X-CSE-ConnectionGUID: MDLtxYHQQdKTShPzsIeo0A==
X-CSE-MsgGUID: 06GWNUTkQwmayHzWP5oDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="253843721"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 04:06:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:06:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 04:06:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1oHlnb50+GEl9oRCC9Cn0PLCsax6jie6X1cuBIWRsG4x2RWgJFlgGJCLntdmaeRMto7O8PQtS6DdWQnVqgCGK7WQrg21SHfWWHkZGdf7A+Md8nclQnvWpMHeh/sLHmml7ItJRX+ijFwEuW5O7rnBT6e4i6j8D0Tv+Rgi8XmqltDlegPInpV528ytcDbO/5gI7/lSrOy3V46MsoGChkIc8D4D7gFNWEaJCSRmB/bhEwp77X4r72FElrlICvQDmerCbOx/DDZZ5trHyp+Iml6yO7s+w/GGmfaojB2uPcYGoIOr3TMesxzXTuyWW8zt7jwWEyTBtB5aB12CJB7zIM6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgLBUG7oy9ckwb0Oo+usp4hnK6yuxMHsw7ncbEU8nNs=;
 b=Y/NWmGRWuE7cO3DKVjCbFH+gz2u3ykwwMFJQfZJaD+Y7psjuWakaCq0qCXa3UwAm9N2ErYidBL+QAh+hbkUubkzshHeg0smMuT7feT1fcTd5esHpa6ap69o6KzJi0u3IO4oCh48hpm8u/RTwycpJy2Dl/8GdSF91frKIk3yB9zNaubGelRDtLXDiW55hkEB/RftKO5SVqYM6IUaql2cCRqLf9/8E2m4aV32HBkyyqZU5+fvzVdF1ixi9fvP0ZSLNpCO/6KVXV6RdEeealpRNtvo6ZeEjvI5WFab+7KI8wtzBx7VaQucL63PC5DRWPoiVYsp93jyMod1cnTZcUyx6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 11:06:14 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 11:06:14 +0000
Date: Thu, 16 Jul 2026 12:06:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH dpdk] meson: bump the minimum required version to 0.60.0
Message-ID: <ali7Ip2pkWI_ZhWh@bricha3-mobl1.ger.corp.intel.com>
References: <20260716105330.1612578-2-rjarry@redhat.com>
 <ali5V3LlVPtDNBny@bricha3-mobl1.ger.corp.intel.com>
 <DJZY1C07GJ4S.1GFZVJ01RL16D@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DJZY1C07GJ4S.1GFZVJ01RL16D@redhat.com>
X-ClientProxiedBy: DUZP191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 230fe330-0a0f-4532-8190-08dee32a4098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t/rQqiododjIDUtXHjiJCyhtIchYod+7pHGzNo15wIETLJxeku/G4WZ+TWgmqHVPOtft1GFLzij3P2UjXreXg5LHv0hk2rt/QyZzQ0V/xGTPow/lb+KK1LXglHtTA5Mo4b1dMf1Em278cWMTmYBwNZM/2wOK3uz2fNtTovqfCT2FjJoiJjxuVjSVtoXbwklvo50yuLIUeI6aJEJmpFjpSNmWHT/8woadJiSfuEn/a77Dm2hQ3+z6VwvAy4IYpZD3TqnC0Lob9Jalh+FfsnJaBHiZq40MMoeVBCk3wGhzz7pchqa+ny3ZTNtvHeP9MsDJNrfO6syI2pPbG4gyw+DjVwoBQOtgpXdtx1vlLnwjeGI37xBUkJElK2ntwMaRWOrAY1Pfhq3HPapqhJt6OA8fK6h4r1Ii1z+DUWBPuSS+a4UTQtP/+MHUSkJ34cfIbt1iqDLxJPT79i+w6bFMHXHd71Wm4du/BsZQRtiW2MCTc2mrfOSkNPDs3DRt463UFy0eYpGTlJtWnb3Bi0SNMolso5lnqaq63cJVkf7qM2jGEEOmmwqVZ+uJlg/5PsbN6EVdaXbLwMEIo70U0Vpb9t9bfSz8loVe5itiis6Ras0Gve/pKhbA2dNmcac5u0XdoNxhf7hBtEZdNPTWl38soGHF5ILQg2DkpwEbyfkE9tcsObQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5VRRbuY83e0oQm/E+iJ9fCVWJDLTWY29nR2GDkLUyhbrELFiyYgwuGG31uxz?=
 =?us-ascii?Q?ayqb5PCS7rQ9+gG6bQpI4lLbYJH2DttPH3SP5e9eIb5BSVKZ8eHySZlklIY3?=
 =?us-ascii?Q?Po8ybg2dRBvSfxtODG59L609bzRKC+IgeOtt88GPGr1/F8B0xbRW/jq7o/55?=
 =?us-ascii?Q?ovJuNvFcQpGJJEvhmJD8FzuRe8DKHjA9v1O2/k+8SfGGBttD6T6icMl3QZ2i?=
 =?us-ascii?Q?5SvyVcCZWb0lbj5PFP3ZBXWKuax+bya52O16WYzn+TnYTo3sTATA8cXUXGS0?=
 =?us-ascii?Q?0lSzdI1oP3Csbp0hBfW4nfzxP5aCZpKiCsH3yNKfGwP31QQQOymIOehvkUuj?=
 =?us-ascii?Q?mA3XAC+jh09nWsZZ00fjkAIIswa2oJRdWhjzajUoht/MZqy2Zjjgaivx6N20?=
 =?us-ascii?Q?2ZnSRMloPufB1TPa2A7uc+G769xtplzDIAOsYINIcQr+Cp0V9dME6sZKth1K?=
 =?us-ascii?Q?hPulRneFmI+pVXDLvldeafGXWLym/zx20TIEt9uUg49CMSZAM4rSWrmeFiX3?=
 =?us-ascii?Q?nsaQQwoTvtMNET62pYPaaZf1piWCryTvhjrcWOgx5ojIcrBV41rUSDBxldtD?=
 =?us-ascii?Q?xcSA0vCHL8X4Y4+xEemXwpvK8ckjL/Cjv0NqDlHYYqV+QdLi34OBTzVHnSV3?=
 =?us-ascii?Q?FNDojlb+3vWyVOjipV4DF4aUW4UZRoJMm/XKRo1ZMT47JAGin112TM9pFdpJ?=
 =?us-ascii?Q?ic4MjoTP5pZMwXMnXxzlnhBc85h/bMjXp+2Ey1qbmz+IoYjShS8Z0W7W5Xxy?=
 =?us-ascii?Q?JDvX9i1n2WLAea5CK3BzZKhKFgndw7twXQAx8CLDzeCORwYqCrKHA99twwH8?=
 =?us-ascii?Q?wIJs4Fnl/X1ejMjP1uSFy602hhFJSMmJqM2GOjgSU6k7QDoh6GgnLhxNkX/T?=
 =?us-ascii?Q?6lzhSCrwVMCw648BkSBLE6ipz58NkFKQqmJEnSDG1hS8CnUxPTIR/J8VYOqf?=
 =?us-ascii?Q?RbxBaF/db2KDKrKMsSserJRXhpZb2XAoHdvhyrYusfQxab2t5XDLt5WAZWHb?=
 =?us-ascii?Q?AV60X+CASD+umcxsMyaMTJ5EBhICyYkjJ3HiV5f5BtgBYxF2dEOTlMOii4PH?=
 =?us-ascii?Q?mTGx91hZc0nhvALR7S9IwgMEyCHOsnpGUY/FlhQvNGSUEjx1NTtr7BwWR9Ap?=
 =?us-ascii?Q?BjwnsZqGCQr1oddWTTrdMR1D8ONRyMLQhfKAGfHj4E1EMWbbe6cYmpHNmMmS?=
 =?us-ascii?Q?aohK2eDRssZAfJmWx+YMmT3++4luujWxDfheVRUzM3A9gpl8dNRTXR7wRXDc?=
 =?us-ascii?Q?QG3QP38Mpc53AyBlJgN7DhG/WXU1kd4t94HsnMSp8MDONyXkcmlSHiZP4/jj?=
 =?us-ascii?Q?eXY8kRZ03dteEZtHFdX1rea16zTpuuOvCZAFkZczZcoxH9BSLg1y20G5LPVt?=
 =?us-ascii?Q?Ohcz1JlpVq/U7qE3veAcU2efd+uDwKr2YH3p1NNQVl7VG5In+9MLmDBag0+h?=
 =?us-ascii?Q?Bk5oAZdH6r090l52i7tCWS/NcBXDAwRxYzoK2bmeb0DecinhO6amH6K2wuBu?=
 =?us-ascii?Q?2jZdUdpQMwhsx/nOMMo2mwxArvq4EennOsiVRJJet4U3JptBZS0T7CXVGLEq?=
 =?us-ascii?Q?A29q1sHVyo8mBeudluhDgxIhCK6CT7JvHpUYU0HwjGPZvaw3wOA7tX6HMA7a?=
 =?us-ascii?Q?7kIilIoezAIPKtkW5ecOBJgiHd+34jhHa0OEIRqpTGrChCkTy/rqXiIRIVCq?=
 =?us-ascii?Q?uNmpKAMTyCLzoxVmXpdLXzK10UBPOBDnW10HckdwCD0TXiXWgMMug09qrut7?=
 =?us-ascii?Q?isGnspAnxm1LP1WXmGHhTaEC6nM1e3E=3D?=
X-Exchange-RoutingPolicyChecked: llK3oTTMtXykX37mQgn6cWVgduwdUGhC+mxxczPVAvNZhY1lD7SLryVRm8jwBycUuVx8skrGi5SgIxb99X6UIHpStPEUeshIa34MqREnpsSdjwAMqf8SNnRAejGEYFIck1MqyXZ3Iow9ZvvTpDiuP5urPyZh23VSpxW2v4Qsuce7501ESJHv8k/9RW/kNOWy7EuvJVSbzLiAo2v9O68gbM5WfSNiVfFmQepTg+YIoeDKcwW2vTK3BcqaTDTuH5LFxpDJwQHiSVFBKtkGReOnZyEBYd2pXkbOpePd1R0Bvu6FF21yCshXd4pcnWW11pbYRW9cyjA11eCJkd7s5T9i1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 230fe330-0a0f-4532-8190-08dee32a4098
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:06:14.6339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8FT0ONIaaHmkxbyKbZT0wx/4vPYDjFqLTSRrl0Q+Q5KTBiKCZYCNXECn9zGS63N/0O1CEb2YKfPbesY6J/PNIkdA6eamepnYvc7fv5yZao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
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

On Thu, Jul 16, 2026 at 01:03:01PM +0200, Robin Jarry wrote:
> Hey Bruce,
> 
> Bruce Richardson, Jul 16, 2026 at 12:58:
> > @See
> > https://patches.dpdk.org/project/dpdk/patch/20251205121301.3443561-1-bruce.richardson@intel.com/
> >
> > /Bruce 
> 
> I had missed that one. I'll mark mine as rejected.
> 
No problem. The idea of marking warnings as fatal for CI is not a bad
addition either. If we can get the version bump in, maybe submit that as a
separate patch.

/Bruce
