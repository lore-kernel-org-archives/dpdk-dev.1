Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE3CD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC07A402BE;
	Tue,  9 Jun 2026 12:21:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CBE774025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 12:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781000461; x=1812536461;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+RGNbrLucmHCivMcAPm7IO5XRRPJUl2mJRtEF5ZcCmI=;
 b=BpbVa+KnKeEMCU/ztQ5I3Qy5wuqKqYmOeWQyV8QbcqXU3Gee3fZFE5K9
 BbgRcoO4blsD+H+nPOb3HnOhwqh0lmQPc2A6qyep2gO4KyOPXnPIAa+WQ
 3EweKJjjhUc3bt+/Uw8kUDbJSoYSjg/OGaWmxB0WfF1KqFDbXoQ/5sybo
 T4JgIrg3FyXLavWYQIQrrP4xmBuaguJF9BCf0IeGcTBYn3437Z14wpmYU
 sS5YrmWcxG11i64vWFjRk+C/U1zcTW8s1fZAi6aB6k+ardtx8w6zU9lRG
 SjV0apSDDYyr852WlD4vsYQ1nFTmyXrvGNHGDGTuDtQoEx0gT5DM+3xM/ g==;
X-CSE-ConnectionGUID: T4SUpLIRTeefk6Z9O1jhaw==
X-CSE-MsgGUID: q4ameDNoTwirkY5Kb6EkdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99332442"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="99332442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:21:00 -0700
X-CSE-ConnectionGUID: PIzTEZPBQMiz1N6QBy8x3w==
X-CSE-MsgGUID: 0SrKhUx6Rr6dITae5/QFgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="241658713"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:21:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:20:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:20:59 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4FYu0yzXuIL2/lkZnfSlWXvF+g4vy2PnaeY/PIuhQyk7J6pN/WId43o/Ld0YkxIx3eOVHwa+BGfUsuNiPuRB1atUueMKzMYd0p2/GOra00w518IAlwNvoUEfSCRH/mgdUVVpf5MGOdRMpQHoD9yOoHxuPWMtmDGULZR/jhg7c/PC2c/XxNk2V8ubT6zOxZYTJYOl8lN7i2eDohzBmcJnQ54CwNrKvjhi3NVtnC4f1f7E58kSQjZAIvqDagJUWewlnhnR1X7a/r1OlZiAVv8+JhBna/DdeLhIzCYxFsHBQpzDKib9IsLQI29mys2WNtD3i7X7uL/DX4b4ADiSSDt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7Gmvk/2kQv/Uj0KSR1KwOg2MH1KfiA3huT4tIVvBsc=;
 b=O4m6zjd9WGofRMntnHNzuTtgS3VheX8Xzt+AubsgCgQb+v7Rm1BWfbayqIWA07JTq/CdMxRhCgJOFW0W+V6P0r35/HeDISGyV+FiHV5TryQ2WCd12EAh4i3KlpJc5aDIrRwUCSMfVwl5U1qWoQNPvK1z6U23OO91MhhiXE7qO5wj7S+DJdjw/Gu4hJeH5saTiqGbRtR4k0kO+SwKM6iZmy/uGmBfxfYdYaVQ6kCamDWyEOq8zNOgC0JbjPrLbrEshJqS90Mzteyu9QCN4PEUOD0zY/A+xRbVLCe0enFQyiuYf269XGZbexK1Dexf2CI6Urx59ARp+IwVSg130C/19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:20:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:20:57 +0000
Date: Tue, 9 Jun 2026 11:20:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/ice: revert fix link up when starting device
Message-ID: <aifpBJIjnHIOzQrc@bricha3-mobl1.ger.corp.intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
 <20260603143407.1108527-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603143407.1108527-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b17824e-e253-45f0-76c6-08dec610cbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 49FGs9JE0uRtyck1TzxTG4P75MqAGWGgtOSr7ThTLwRZgeLbrzqPyCLsOCu5Ncd9ZTuf4qaE7ZYShRG+9mP0ulHRqM1Ee/Sdc07SPTLyVxw7O5SuIc2fuYW4ZVhk5PSQPsehLbGTEYicG8fbQHMRUom6rQ+L5n6KDwavUQkPQKVFWGEMF+sYvxbmRKaMK/tx07Tr/cHy7AFolgdDsx03vFJF23WqBfmiND18UN4SuzEa3At8n4avM1OTt9iG4O7do1MXw5sn3AbWmydmljl22+OkVTUKV0EoIyA/fibxXHv84uczP6Il1rhPceC9pF39wC97Q1pGHHI1Xh91YaYybe2HBrUdrVDX0RYxBT2p1C5le7HyRqsctPDZRojpoSaVRh/rCDzORrY97zplERL5o61xEDMq9FE/uUuL9Y9oKFkwdhpZrzShCLi8bt4Inm8KWeWZGEyF44PJknog9V+0RPV+iGnYSiss8KrjN/Xsk6KD+m00WUW40Po49ho6sS1Q/X5CnSUQc/64ewDrWgx8RzjH/ZAOHTe27aWpUdZfnIeNNiOSJnd3x9Y56H+uryDWbKIDs7GvCW5AxMXrbDR3jVcBW5ppI6FhdDMiw8W/ZZecx3y9eEm/JleZi0ogxtHKse3b8nWOyEui4pFCCoO+oIJq1rHcifS19YrlW3ZTKLToa1jzN2ApVIZLte8dmutC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q9YX9Keu1lt3gaAa0Z5vp1t9agIe0KdamTomyfQHZykwKfi1UFVU0ziOb3gB?=
 =?us-ascii?Q?SpXX1MRGzM8Kc42Fe1Ykd16weqS7NJ156BysdsY1uSHdSx8JFtj7J8fp883S?=
 =?us-ascii?Q?RgL3e6Fch3I5s2B+QxhNNl0gwSxxkpaVJcDroWV160Rti2VWKLhV6JsnWevT?=
 =?us-ascii?Q?ZvFc5XRqO+XfIDtg/sVmA7b5wUdnWTJYtmF7VP/yGBe5TyYoPobVO9eKO0Cz?=
 =?us-ascii?Q?29mPGHspw1idbFoXCq0PwV62WBheZAMovQjjxuqLTHwEcS8FHtnixBEWszOJ?=
 =?us-ascii?Q?d2896Yh1VoXtQpdjzIhz6l7hxoTt1dx12Nd0dMHnpJ5+0kfi5/4gTWt9MgrW?=
 =?us-ascii?Q?MUkwD2hSTdBREApI39vQJuUcHP9t4cJpBjgSD3kNXo+sIif6/GwVFFxNkpc5?=
 =?us-ascii?Q?El72yyrSP2LXls6ez55+AtNI+5eiL1HJdnwWeyyqIvBR3SdNHWhyZFNLqvKr?=
 =?us-ascii?Q?tKWBhnT7LtvpRM5WUML8kKMBmh/NJiaU7eKQ6RNT5nEGEz5YW1N0HAegJwh+?=
 =?us-ascii?Q?4+qL1jxnDi9DaUBVao0Dojkogghhd2HPWNuiKu5PKYxYgGPgXv2UdktLf28E?=
 =?us-ascii?Q?pRlAoLKWOFuN7Cdet1GwkVxRP7dPMKaTATRW2CZuVfGcS7x+e6/1GkqjgA8z?=
 =?us-ascii?Q?arxoxel0B9/fp1j4TYj+c6pklccsyQ2NOOWh7UFLhqIENNzdaNMIm0OLg+XN?=
 =?us-ascii?Q?DqO664kZoqTK7/xNpI30SlagbfW2OI0R8Ug+G8KwwZsODduonz7rnaB/D2nL?=
 =?us-ascii?Q?gPwKNSUWHrQb7yD2n1fMypLUv2OXGanBAR3wjtgO4sZ8FboxR0bzN+WHhCNK?=
 =?us-ascii?Q?V9v7AQZp0AuCCa0GPOEby85oC3TjXE4L7finK1iAvon4tnHRXIDVQu1CIXfc?=
 =?us-ascii?Q?/MTpG0ulbZoq8mXLuNmoeIAu+trlvSlb34nfGJ/5kRzg0ECVCD4m3b4//nzc?=
 =?us-ascii?Q?jDUN0zFcra/whUvfrREzzwWEs182FAX7v9/YkGvgMW6XGxLEVGhCZkTDY7fY?=
 =?us-ascii?Q?zzwKWEGFmD0eJxoqRmIkwV5iyk1C65zyGP8dHpZveb7SKmKEjqIpuzBZIREk?=
 =?us-ascii?Q?fStoTZ9DEojQSpIxtef0wosJ+gCvoff0LgvTZQIQVh3Cg02Fmq6lbCuqunN5?=
 =?us-ascii?Q?G7G3D+jKBb4sLB4F0K/+59WzfJudC3SPqrGcFHVtgdBmjMa9kdETlmshqTXG?=
 =?us-ascii?Q?wOgw79NaQT/c5bC+OEF6mMwiMQyKRgpul+uGlCSKskCMO5d3p+SUIxWejIEr?=
 =?us-ascii?Q?eO345Xz5wetVUANj0PToTEwvxsWlYZEP+pJOEShkyv9goRFnE1A06/lzfsEx?=
 =?us-ascii?Q?b3FOr22tfptTqFsILgdeDBJePiiK1eux83BNDMl25h3m4TMkLJfEkjzmfA/O?=
 =?us-ascii?Q?R7ENGTIbtBLs+M4rUNUd7mgYnDQbjRMBpGSkUXueXhITSUYORF0Yodl/eh4W?=
 =?us-ascii?Q?EX5qU46BJ1fP071VLyoIux85a0K0fRGhprEhezecLf//luOnNynMw2axPvnD?=
 =?us-ascii?Q?sO59ccz1zDKZ5uSpelpCkwjFx4hJk5Qjv5lO4n3htx1BQiOlM5NnCQ6/opzh?=
 =?us-ascii?Q?+DfVyDqXUATWPnxPhSbeOnQLkzv0lOTWjJSmn6VaHRyIUhKPQXa24CYp+vma?=
 =?us-ascii?Q?BIMXJIcLyDko+pFIUYtP4xJD8iNUfbr/bQg+LaeI1qWhOK/DIwIsc5XH4KKf?=
 =?us-ascii?Q?CCbpYEELNf2cxeGOqPNdV2e55I2RigSeAH3kW+LJGx8m6Bf9d42gkaffUn7w?=
 =?us-ascii?Q?LRfbhtWnmp6CA8WurwVqzWsvGk2sAzE=3D?=
X-Exchange-RoutingPolicyChecked: kjWZnLdDFb16TUXtOaZwsIszeB61QTLIi2bmhRsKg7FnGDEtXseu7RJo5qle+suvu7t6h40feEb8UgV9UH4+DEgo/OGy9/ehMuMWfcpkHZBd0Fqe8sIUZ7POBGFHBileeiQE2ZeyrKQa7bI0dIsthCR5Z/pdmr8ZZohncmnVgcTU0gMshcQI8vYtLA/0LkaFHWJyt4F7PJm26XkWCWI0euae+2EzK8vwTLjadD6QuD4VioW700bn4N4bzco/QiGXT8i2y2QiCQMfqSmOjGtLWrdhFuhww6c7aBWevYkwb5ACM0cGOlVaijTMJ1/uRUPy9Vulv8uAzbOyVS9SMfkr8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b17824e-e253-45f0-76c6-08dec610cbf6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:20:57.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtIuwx6o+UnXNLpgcH6MRj6zMXD7D+ReRvWWA1T31TT45TqbiKiK2zFvspAvF2nhO3AheN+ra2exlccyGtu0em/fuosszVuYapQeTgwRDHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
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

On Wed, Jun 03, 2026 at 02:34:06PM +0000, Ciara Loftus wrote:
> This reverts commit 6c76b76dc64183eb2f24a52b90d4ff9feb4872f4.
> 
> The reverted commit worked around a potential timing issue where the
> link could be reported down immediately after the link was enabled
> during device start. The commit introduced a blocking wait which gave
> the driver a better chance to read the correct link state before
> returning from device start. However, since the auto link update flag is
> set when setting the link up in device start, an adminq notification
> should arrive once the link is up, which will be handled and correctly
> set the link status. This means we can remove the delay from device
> start as it does not need to guarantee link up before returning.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
