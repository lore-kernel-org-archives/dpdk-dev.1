Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD1CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 15:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B8BA402E0;
	Fri,  5 Jun 2026 17:21:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8760B402DD
 for <dev@dpdk.org>; Fri,  5 Jun 2026 17:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780672866; x=1812208866;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BmYyTQACd6NTcAjASN2xTwJW0O6m4/V8oAiMYpfmvDE=;
 b=TNu+7dBQykGTZqgRsPyPnOVkDt3uCmbyr7dELKsLuPtatVKu3kzvkzq3
 lS44DEdfqqlqSvuLa/rU+Sm3h1oXaoTX3GuFBZKPKbd+8FU2Dwrsqclev
 k6JwHQ+gq6Uw2k9ILrz1/hmKcmv2uv/2WtcSUb5LCskmlTspDFPhB+tie
 3iRxgCV06uHOzbGLmQL/tcvkH//owI7R5GF1sBx4IOE4OyHbkRYmVA26d
 2NaH33JtshVssOu32t+a5Ng3TbvG2RjxNxnd3u10QkYwWnXZYBRbnJBBy
 18Eh/A18Y5mdx8uLBUqWLqBDCGsBXXvyRJJG2NThooc9jqYB3+RGlG8Zo A==;
X-CSE-ConnectionGUID: 3vJMHu9PTZKYF81s82si7w==
X-CSE-MsgGUID: 4J5cjqtTQDGS75tw/FRqbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81363499"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; d="scan'208";a="81363499"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 08:20:57 -0700
X-CSE-ConnectionGUID: HEmXrTMaTfmVFBMiod96Bw==
X-CSE-MsgGUID: lCQde4LGQKui3nBkKcQ8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="242395768"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 08:20:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 08:20:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 08:20:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 08:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEIN7NM7Wd8TInzdDAlceFSyPNMJpACsITYoDwGkLwfBs8f5RE1lSULonDEofANDQTTxfnlYpL+VRiJhpPoNdBg5cDdPDdqSOc84VvQmcZ+QBIiCRbslJDYSfvOVg137iTa7j0iFSCRs2WXNZ/W/8pMWkmIVsqiBwh9zY3cC068+u2BWWZoXUa3wK1r0aAbvyAt9W/f5BCK+awz0dgxV9MSIRJGcgd94MNJKLoxKoaDgqsvicFYFBX/JkuH42Dy89ZHe3l32Rk/eZ1+76naJGI0Bcdw1zIIEEvMXVU2V7s8PFS9k7rXrFvmjIn/XVxkmglBA7aHBedYyMEUxBRigLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFd44mKvXTbPOTJ/M3H73o83teWHvXV7PTQ5JDoNUdg=;
 b=WnJ70XSmrYKa46bNRgB5ok0RTJTzJqdKRFpD/4hIdBPUuPvSQ5zytEZohWwGN20B0NpkVQNDKKmCUPGV5hNvQmHrMkIkz2/rLFBrkUDD/zhZK5n2Uplk2f/Mnzoq5/8F0JpTJoVUjARB5+lD4kOxKQXvzRHquJEjnCFpVhsbpGSH1SGLi7+gNjum06SfF3zuTNJUrKVMH52gt/v+KWQF470Rxy3wWG9VJyLJend5jcKXh5wuLEI2bRd9sv16b7OIjTaiSz7tVEXHBhLSOQdEmHgPV3qMZvtlvcvQF9ndbPjmU7AWumKWxL3wBOdY6+aHdBa/S7ZhGiw3VIPHkV9HQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 15:20:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 15:20:52 +0000
Date: Fri, 5 Jun 2026 16:20:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/7] net/ice: L2TPv2 flow rule fixes
Message-ID: <aiLpUNW622tTMoCk@bricha3-mobl1.ger.corp.intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427023115.1225843-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: a02fb310-e045-4456-b969-08dec3160820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DjNWQxmI4OX/gpOchqTc54Q7FsVznMMw8GTPvuUBwe0S8FcQE7HS5TzNXyZ07bK4VLfoBSvUE36R/oF0SXXFE1kDdvx1o8WCMpOlvBxEmV/aIoxLkfLY8irnYEsfDKwKX/TZRSeoBJ4qcZDTeT7BvvRK3kGv3dTJFNX7gJD92SaShB9q1Ynzt1Rt4SjEB7zhbLq/9uM30MXyUF6agNKdprxYEnAi+MSvFMknMJoY5HxzhrF+em14tHou8p6mx7mmFTsrX55NLVrYAV3Uc+qxysuyOYwapbkHbHIuUmVSFtEZeVrKrMIbAmod8KvV2bk7lFj5nZyCExgq20GfAz3jyHdmYvdX0MJ3TDc7QXXkSmSVPQfLCylCExn9qtdKfhSmYNEuROL6JHY6TynFrC8fcLwMhKXLN1owVrAtj4Yu3izR4nD35CkfrKzVY7egejNiF0Ta02eJ3ticrvepqkLySKjd25NUoVpz7aRQNsPft/M9Mn63vrp4yQzwul/wJpbaqslynsPdvLrW2GQQjzpQGlbI07RfhfcLxmGNmWBvJbSJF68QjxJJgGTKir3Bhbi7F0dBH1uiduLKQ7osWsJNiljyss4DFL1Y47YEJsUNC4atqqzcdYiq3mvQCLwCImxMapg292Us/cY0h2/V8k6ovLXofB80c2XDRTt16fuz+A6B9W1ZR04j3gf+f01xsaF7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7yHooe6qB2I4/pg6bod8P9g1xZJEKJxzZZFLncuM5q5SJ7/AjDG/NVaUbQb?=
 =?us-ascii?Q?W5sdgWNbKybywcqZnX21Qk3Wnv2R6kWok1rW8fAmczQniBnaqhGX1FB/Vze1?=
 =?us-ascii?Q?wNOf1jc8UiJKEtUv0eLUiEmGIRu9RxPFuLeW9+Pg+gV6naN9n4uYIcVslZWG?=
 =?us-ascii?Q?PfDwOY/2LgkzYo0yd56jWtJpUKxuGlgyIoR17cEMKN8Ulcfhg0TkW2eMfG8k?=
 =?us-ascii?Q?fBkNJldoxn9+6KP90P1F+xccaIExhy5WrK5hhlh/e+i8PZAZUg3nUJWig/+r?=
 =?us-ascii?Q?K9JmHcDzlO8EQNLPj4/8ccm1EGTWNp4FyyXefm7htAGfV4lNQsHPrP9SKqeL?=
 =?us-ascii?Q?qvDLjHhWpZP4nzJpMgC5TIt6oTkup6cAxrBP54K9aRfojbfgMuVUyKN94bOC?=
 =?us-ascii?Q?Vuk8w1EZdZGvD9xF3wq6ELsoQaby5uRKmG8MHaTsdFT+l6VNF5zB/M1zR4lA?=
 =?us-ascii?Q?TTzip5Ye2E30NYxYk8IBN9E/j2n+7BlAV5es5Bi8HbiXH7XVDXOzkUh7X7OM?=
 =?us-ascii?Q?Rd2u5dEi4OcpiZ8/Gpq8feNfm/IMErO4gZbYmReeefDrIK5zpDliaAA2KeWe?=
 =?us-ascii?Q?mhcXjXgsOJpwmo/kejODy/7JXZ2EQj1MOqex4ppvRw+b9zC9TZWHeWjc1Xhj?=
 =?us-ascii?Q?vU5S07bSxwdoLgykeDI+uOSddxKctEzd67EuOKqMmBDotstiDIDv9QGyoSa6?=
 =?us-ascii?Q?wxNdOiDSnj4ha1nmPWl2qS7MNbOGABXxNV46VxQO2cRZHGKXefbKd10kV+8H?=
 =?us-ascii?Q?UZEwYsRfIj7bfCs9hzyYv2XoeNS4fKlGR1yPo7w2cLGYb632iw4yZgDyLmpn?=
 =?us-ascii?Q?d29ILJNoiHotjQPhM671j7Bi5JbY86ylRKw7leaxAcsTfcATFPnGGBuSqyNN?=
 =?us-ascii?Q?lYCny7Tqgo1BiFCroGghSNtgng/TayHaNJv9Y4PgGaM/pE0/LzkrepQ/dkEg?=
 =?us-ascii?Q?FVSKrIhwoLoJk4m2xFfsUWTqBrBxkt5dE4G85xRU44jBNLwmVX3ZbI1EB61K?=
 =?us-ascii?Q?kDkC7T6nV1MbhNHaoY4b8ZDxrREMM6hE+G675NsLecULBUojOF437fe6K8U9?=
 =?us-ascii?Q?ABIYBx2JUiJ3/KDeH7M+yGEd5roi0v4aPLuFwtU7IyL68Tq5UyMjoOQQoeiE?=
 =?us-ascii?Q?7IJyEYxMPLoouIBw9/2eWeN3v87if0bAfBcxLnx2K+pxc7iRZIImU2+uEdxY?=
 =?us-ascii?Q?I7UYLqgVEH4WfS6snwfC3st++77ZY29qOArTE8E2dXDBXwP4P+8P3M3415s2?=
 =?us-ascii?Q?DpKnYcGNoULe6d6iVnSIEk3GRzZJllivoTCmDBjCoB115KaD/M9era6LUGJR?=
 =?us-ascii?Q?2KfLIV72mbFUKZj9I7+LBIMX0p5PqyFz34UHyFX78JFW/dTl/r7Rx+Eh3P8N?=
 =?us-ascii?Q?aQLNQspErD8+w5hY202hrFBNaSn8iniqrvtdDHgWsmRUwgQmjZE2Lky4Bq8p?=
 =?us-ascii?Q?RBLP3vdEAagP6sB6JHjdYg/t+abo/gkNspmyjBC86Y1jNBnNH+ENrycvUBsh?=
 =?us-ascii?Q?ZjAJvYWceGywssACBtHnO4R2HxRtXgflDrh04wElJ8XghoPDLa7euCBpfeB1?=
 =?us-ascii?Q?MMCsD7t6HFdxsPSO/fzKSPItVDOLOXKPB4R6SXb9p6mRJoTMGiYIMz6McpKh?=
 =?us-ascii?Q?3qBqwuq1bq0eG5PIvIgrkJoGpr0bMF17smQdbnz/MriPH57xLqFFNYD3ucia?=
 =?us-ascii?Q?F7TchneOi9E7f5Te8NRjKvl5Bg1xom4oyuBVeXjbAhQIqVPeOW69aq6w8mk8?=
 =?us-ascii?Q?tcSI8vBa/7XqZqBl0T8O2K2Po7KrUMs=3D?=
X-Exchange-RoutingPolicyChecked: AxPACV4/UDLAdHiQfmtXUNXrXzNtYtjsISXVOn/2xkrIwFDd7mFq+kvh2wxU4eOtHVO866gVhO2ctk3z1FyqG7qSoCEnvQhJW/4VGx+JnOy7azj9c1j9N0DpFjPV3Sm14MQIw3v4hUkLEjaBqdr2GqvBVQ828XXnxan7ZOA23chgOIdWJ1TlXBWEb6EIzOGr0MVkt30vHDwHIzsAJASBJtERgHXmrWlqsAKBvgQdEXiNUm1lsRs3wPJbXALcKhnaObgADNE7BISpDVhHnriZ2M0yOFTbsr0AqmBR2dtpU6X3ECkRMjIfgfFwJlN/zOQZZzoJ8tm1EhiShsHJ/es0Sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a02fb310-e045-4456-b969-08dec3160820
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 15:20:52.8940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVYKXgRmcSl6RCBh/ltrBhzC9NOSfik0P9BrPP67dBKUR/tiNraAohUAs5Xox0Ue/aHmMR3grBdcN1GA1nEmRRL3CmXESUcdNsfjhOrfPFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
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

On Mon, Apr 27, 2026 at 08:01:08AM +0530, Shaiq Wani wrote:
> The original L2TPv2 flow support (733640dae75e) mapped every PPP tunnel
> variant to a single generic PTYPE and programmed both segments with
> identical headers. This caused several interrelated problems:
> cross-protocol matches, silent inner-field drops, rule deletion
> failures, and unintended side-effects on GTP-U flows.
> 
> This series addresses each issue:
> 
>   1/7  Use the 30 granular HW PTYPEs (396-425) defined by the DDP
>        package instead of the generic ICE_MAC_IPV4_L2TPV2, and
>        extend the training-packet switch to cover the new flow types.
> 
>   2/7  Add the 8 missing tunnel inset-to-flow-field mappings so
>        inner IP/L4 fields are no longer silently dropped during
>        field parsing.
> 
>   3/7  Pass a segment index to ice_fdir_input_set_hdrs() and expand
>        each L2TPv2/PPP ptype into its own case with distinct outer
>        and inner header sets. Also always program inner-segment
>        headers for tunnel profiles, even when no inner fields are
>        extracted, so ptype-only narrowing works.
> 
>   4/7  Fix deletion of bare L2TPv2 rules (no PPP) by switching to a
>        single-segment profile, and normalize the L2TPv2 flags in the
>        SW hash key to prevent lookup mismatches.
> 
>   5/7  Stop L2TPv2 tunnel detection from overwriting the GTP-U
>        tunnel profile, which caused GTP-U flow rules to fail.
> 
>   6/7  Invalidate stale HW profiles when the L2TPv2 subtype changes
>        between rule creations.
> 
>   7/7  Pin the outer Ethertype (0x0800 / 0x86DD) in L2TPv2 rules
>        so IPv4 and IPv6 flows are not cross-matched.
> 
> Shaiq Wani (7):
>   net/ice: use granular PTYPEs for L2TPv2 PPP
>   net/ice: add tunnel inset bits to flow input set map
>   net/ice: fix L2TPv2 inner segment header setup
>   net/ice: fix bare L2TPv2 flow rule deletion
>   net/ice: fix GTP-U failure due to wrong tunnel profile
>   net/ice: fix stale profile after L2TPv2 subtype change
>   net/ice: pin outer Ethertype for L2TPv2 flow rules
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
