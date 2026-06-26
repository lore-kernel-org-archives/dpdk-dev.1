Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103ACDE012
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0100F40663;
	Fri, 26 Jun 2026 10:48:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 60D65402F0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463736; x=1813999736;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Py/T8vw//qvjEdcGcXLXdYULyxRHgJ21GvyvxrLowlI=;
 b=WY3K2Zs5q8uaYrlBax4kfPfOUzQEij4tpA8j7Hky8QMk2eT6lDI7o/ra
 5Q/1vxmkugAmKn5wjxCY8o1yBUZBzo+nSLaeTFwVMOQOgAsEX4zysnOad
 qDpqg+wrZHPvPscoS60+QOO7skw+43I1/42kJ/mOnh8QHWzADiU4w8UZP
 NfGK03pNcrjbd/tWuWFTEAEyd3qiUNEP4bicbZ2l+44F8mkVs5kTKzKUs
 pn/hzMq6v1Jj8BWN0JOPj8IGdNruI+2MTdM6TXI4qC5AMVp6VZUaCVU6v
 wkznIXubyu8DE6HEz5Dz0qN2iefGW7+GzLgN0skXDrBX3oBMuU6Eqtr4u g==;
X-CSE-ConnectionGUID: 8ryw68U2Ra6mtw2uEYhAXw==
X-CSE-MsgGUID: 4YFeB9jWR+eMDBnrMEZxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94649527"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="94649527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:55 -0700
X-CSE-ConnectionGUID: oyrtK2jWQoan009JsrOYMA==
X-CSE-MsgGUID: ZXExxw0KQFSuQeM8fBY0OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281359487"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:48:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:48:54 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAmST0XdykzlmZrD+GMRmrR08iwv8p/4ifwgL4/yLwVZmkWUzhAhWvAP/B8WC+VDV6XgWccRczemXNrtNFrcTGHrS6XpWVs4TAsV3p3QU0ra3O41t2G5i4tHjc7icwgdi4wV/VBQh+Mvt9H95UPWxLdUso3cDp7T6Hbz5u32HQe0cq7pugB63LEVM0YI1D2yk3Gr35jRN7ZMWniLXEVMrJPKyvVEWeyOBHnpL9Ze6/6z0uLH/XKyb8ND1ewlNhRrJV2frtMtwjxKXIk1nOIDijzgDnBmEPRO59PN0Al7QZugX9Y67y7KjwCrTE6DvL27s4zRXZPzw7g75PF0Gk3eUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxqPx+0G0jwOXcr9fITJ3H8TwvkDDBiUka9ndhDwSVk=;
 b=EjXBHMueJaIKIPatusS0f6H5ougiI8JUIHo2SBoXW720FGYcQgbBV58GuKaXFSDgUtmaBZ4YjLIyUfs6TBCoD7HC+VFy6G0nipKK5ASTqoCbE2p35/VUf2wb2f5fSBNW04RC4IVslea9h31pdw2XClmFATkPMlaScPGMFQy7Z2xgbfwshAhMWAuKFMt0fdLLmRN65iXo8ekW/KoZSDl+ty62RW1XQIIbcdT3Qqd1KufBLlWiG1F7OMRlzHE0oaX8K8THVmzgzxP2k18zx2WynuBqFqpYvoCL7LGBqhbK9R9TzzQtxrNbWchh7nNDIqDpABWhDV7zY7gkWj4fsgx8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:48:47 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:48:47 +0000
Date: Fri, 26 Jun 2026 09:48:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 3/4] net/i40e: fix potential NULL dereference
Message-ID: <aj486hC2qOd9EfVq@bricha3-mobl1.ger.corp.intel.com>
References: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
 <6dc186c05567cdbfd0c993c6001400151e168feb.1782402484.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dc186c05567cdbfd0c993c6001400151e168feb.1782402484.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eeacf37-9fe9-4920-ac36-08ded35fbc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: eUoTDj8wDvN3cUHvpQtGBF3ifZaMyQBzB2/Q0iVmrLnjAv7hkMOHvdvOrWWr9rdnbLGX0emkEIVOV7oxPERzsV9EVa/PRAMVobfpzE1muBhDIRZYfwf9vSel4QMJUvaMCcI1gqITD37zP9SUwWQWy6NqHKUQLUSOuAmODNBR4ZMQIHK2GSVuTQx7KSHnyrM01vKjinCQeXjlUqJ6BIvHJvHbocbGNkIkMEnsAztt3MA6BjtjDU8ZiGlepO06pE2SiWEU7FfhzLCcjZXEAswShbishrOAfc86+1mGAaOO2FmFOwD+B3FtNDvp11/b9OMnSSInHRSE5gLmeRBPIWj5o9th7IL+u1U/yhMN4HsCnzkOcnh+uCoUEt7s85s9vM6pG/65vtaK+iL+cdkpuNznFiZvuCT9GT30cAR0dSlPpvz+7obJWfDusxNSa+t+PEiql5Nj59Utu/fJxZdF5PIOKNVNy1Edejny62PEmMboF2DMfyEq7zrFapDbQHN1otEk67MPo1noBl9f/rnTtH0MugF54XTu1ERStzS19rZ4A603wzdP2w0CZBodOGsj/fJ35t+kfpGng7WmUClZznzyOgIitmGdVP2p2I88q1vIjxgvzFOxLMvGxulvY1ooJDVpnUcay2SBB0VJh18MSWXl1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKQ6WgsZVt6B2GqApzgaSHYTXchmbVKp5jVTqqzWb+GJs2IJGvMvWrhYAYbW?=
 =?us-ascii?Q?jAgXrKLVhyCoCJ0eTU53bBtnbJfhB7lrYwB9aGK8Mv/3k0s8oCzZRiMSUqHS?=
 =?us-ascii?Q?JaXlqwIsiZyxVFQqUW6bk2HBxSxaxEIvF4orRJSiENGXhUsCgaQLwSTQ8Ofh?=
 =?us-ascii?Q?5bxOat+h0+Uw8S3HR7SQgFUPy9d0p7sfvOT/qGSNvCQZcAfC4kVkzZAps1pE?=
 =?us-ascii?Q?5sSLSctGx3Xh3VA2c/tjiuZ2NQMWjpLpePmTgOfEoNWb6/q8OeXud6q/FQVl?=
 =?us-ascii?Q?mMuFeDqL0LThS082u/3Yu9JNjrPC6xY3WuKiNNoML2XbJeHPGiAptFLpncIb?=
 =?us-ascii?Q?cn78BE1sMXK+FKIxwf3a8xDQME5N0pD8SIFlPUoPKs37NZUtJUQqp9m/3zJY?=
 =?us-ascii?Q?ZGUE6tnO1H44SfNu6jlMK9zlnWldxt0r20fCnyn2T3kiNTujyQc/g8nLohNk?=
 =?us-ascii?Q?SQKMAFme/0dBa1sVsDQNkLza3gBi3PgkeaF8rjzhedXlyZA2dT5Y71O2rItw?=
 =?us-ascii?Q?qzIbxoQgME/vl44K6MwNRLVaTtWZqvy6HYJSD7+Be24h2VPFvfGEUq0gVFuQ?=
 =?us-ascii?Q?gq+5SyNzPOEc9iB7ubsxtoZNcBuHPyh+ceW5wafXkImFLOGLOR7H700WRT6Y?=
 =?us-ascii?Q?WIOZ2599UVzFW+AJ9D92DSw8WdY8pzDB60xHcJE28uR9gpsSyeWcEZqjPsll?=
 =?us-ascii?Q?4Fbqvx2V5uQ94io6rliPI8S3bqmicbWD55XY21dphPccgCbk4CDKsQ0Zb2B0?=
 =?us-ascii?Q?AT2Mo6CcTFFogAqZFjDLFNdSMgMAebcGSNEZ9Cmbtn+Yy74tOmVNcKC6e7IZ?=
 =?us-ascii?Q?M4xkmPWQZ++WIJHVtSclpjcnVfqHObQUnjqtCTv71N5vzos/yMxtnk6pf9on?=
 =?us-ascii?Q?6VHcbELZ14RBuQrRDvQC6vBu8O7U5MLlvBJ5lF8oRFR/yQJE+SeX7AcL2dFX?=
 =?us-ascii?Q?U3sjhAAWgeVAWw4NMF0B0x9J9/5HI/TGk9emz9D1p9ofTIn643oQLFxH2MkA?=
 =?us-ascii?Q?OmF8mSwhR7JXAmXEjnHhVTXkPCs+9rXCguTUgZXSYvA/UOHwx2BDQ70dv+Jz?=
 =?us-ascii?Q?FVKTWv5aO0huIBW9J02McovR9OG3lzNt5psuSDhp6gKJBAxLRVMelLpwxqyU?=
 =?us-ascii?Q?+AGwatWi2szMVX39EI0/eMCqWcqvpZ+T3kbCDVu1A2NzogBJ5hA68TkJmnl/?=
 =?us-ascii?Q?BaNZdIJsto07/daHbzBfu0zFNMZmsCIfEZJRr7U7B/QzdZ9h5rPc0Yel45q1?=
 =?us-ascii?Q?vQ1Ywm62DE5ATh4OXLoT84njZW4+d6xkoz+szbWGp4/85BXUmxja/NheaVeC?=
 =?us-ascii?Q?AlPz4e1vzcJUE18IPCn22IUE5lnkbjd3a8tKx02+aEIn2HMKuYyWXHjFe4FD?=
 =?us-ascii?Q?VXzaQBknWGXnbDUxaQ970qcjw7DNEMsCh3VtWJHtBOSbO7I8v9Hb/Knf79IL?=
 =?us-ascii?Q?otcqvi/FSCBapV/qwWofwsKLzPoRLOtsd3cMKH9HvkK5I1KSsM7RDUBkEgqL?=
 =?us-ascii?Q?uR0am7z/T6T/XNBnVSq8YnlUy2hw0Tqek7WSgEPQEacYS3+/osxXrFl1wLmS?=
 =?us-ascii?Q?MC3Aa4rib9yEzjwyMwWUw/UpMmCeLc/a665dRoxKGE6UuaGyIdmvYkUanA/O?=
 =?us-ascii?Q?4xd3Oxkf3z8HL0pPhxqfbg9V0tmWh2sJTu+34ClekqF/2ovUaxXRvr6ljsy6?=
 =?us-ascii?Q?zIsbK5043KYT2Dxm4gT2qosX4mMRCRhw5B/iHPDu38rhp8P24rLWatUAI4Ld?=
 =?us-ascii?Q?7kVEO8xHag08/cFoHI0gDpdz0yAeGKA=3D?=
X-Exchange-RoutingPolicyChecked: QKN4wFANCvx9Ybd6hlQTgpVeYqTYG5gMu+QbUoMypjbl5t7XJB2w2HEVInh/ym7bD30+nOV/pO6WlPId2rPMQiW2fuxM2YmBt/+oMyrh2xbzzk0fDaTEoJAlxWnnDtq3N7bZqZZQl2V4gI0ohD2phVvg/Qg7vU+wKunGABlUpNmFdcFi4ZwFF6HussceOlNcM6Ktvl1cMJdWjmOOk013QLnn4UlOYJr5ZaJF/1E2hnr8IOHrKGXHznkgKdZxlmFjQMZ8NVkKYT5DJtv7cCkiMXt4IGdfTvsg/BqfgAZPthD8xHb+5hofES4mEpHOid6YULKkkq7AoDWGicmKkC6eNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeacf37-9fe9-4920-ac36-08ded35fbc63
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:48:47.0129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMSNeK9YelWuCGRn1n6locMC2dG1tzAwcvGNmEHv946ujYmlh4VZhGQJ6w0dNUuSLupJbL08DlP5GtaLpyA5KpUwtN2VKzh2XFpjI4JcsWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Thu, Jun 25, 2026 at 04:48:12PM +0100, Anatoly Burakov wrote:
> Static analysis reports that a rule dump may trigger NULL dereference when
> rule pointer is NULL. This should not happen under normal circumstances as
> 0 sized rule would not dereference the rule data pointer due to chunking,
> but it's a good defensive check, so add it.
> 
> Coverity issue: 503771
> 
> Fixes: ffaddd0fa935 ("net/i40e: support flow dump")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
