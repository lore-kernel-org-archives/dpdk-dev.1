Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C110F9956
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D819F4014F;
	Wed,  8 Apr 2026 18:12:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C63824013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775664769; x=1807200769;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BB97bHdAdGXilBxYlmPKRgff5cWsnINDtU09x7kLKlM=;
 b=f7EnPjX+txvQDgtYJfmUsMcOqBg2+pC7NKvD5MB5ESzhS8Fa8EV6qmed
 jFV89r0BKcEauWsievaornwomew0xutF8+oURQ4SnUumEDf/5zryLEG49
 RUq03NDENZ5Q+CZZB3wcmuL3l1kxKVMv9+R3kHzYax3vszi1DxcwwhtGP
 hEcR9sGvfHY5HuGCL8FouZqdPIaj1kOtJx4PmOLA83U3sjcDb6iUI5moD
 oKPdTBNh7aJvJd+Yx55yURRlWIvcd/7VyJ+0Z2jXI3WFICzLWz1yKZpuZ
 0NcdiqtwU/BsjnNYEGAQDe3ck9MgGsGeho38klhr9wPDbDPlpsYarmkdy A==;
X-CSE-ConnectionGUID: p5k8u42YT32fC3FJq2wr2g==
X-CSE-MsgGUID: tAhXSmJOQgW1C7E5Vr9YRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76727141"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76727141"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:12:48 -0700
X-CSE-ConnectionGUID: O3CtL24tRrGHB9a2ifMsgQ==
X-CSE-MsgGUID: IWVXV+nHQai1PSmj1SR/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="266492835"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:12:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:12:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:12:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOv0aKxCEKYt+pbkTg0bf8zWxvtXAXj7GVJwpOJtswqEOvNOWiyA7cbBKlZmDfOc8Q6XCQB/9eO3X57eD+vnzUsxZWiitIo0A+zEIwG/3fIJ4WgSQKwJyho6+HvdEd36RfrCBJZU//d2uSoBC9pOk5civRpSMHvDCjwMOHwY0IGYOkp+j8YotK5yy7ARXEWEi+r8CbMruQ8bVpOurAeykc+V8no2StnE0T5r1XMcaEdeG7gK4zUpguiw1tJK3mG6XeL+ZUfBqalLahZA+dksnEPzC3FOm5FxWnt4Zav09yPCb6ABQDofUG2lFnLC7pC4P61gj+sWlIJaYYtAGcUUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxH92VOCofDg5OoFT8KwSyu9wKXeLqDRSZUhc7MN1RQ=;
 b=O+9p2uqEfkWhVt+rFUZah9qkc3ytvxNeA8+10INbzXenlNwOeq6DttXZCyh1scX5LqnAsc/EYIpGH7MCMb4DKIxkiD0AEv39mv922jvW27ZBl5k9YsOFKlmFloGYrQkvGZl6ygkyEvS5jdMrGmqTXom8Wa1UlU4JtZu7B6nxSnL6q7+MSp7qRNS4N2MWjqugeLdKsIu6iauRf/ryNhihq1nai3NAhLGOnHA2nkBWDG7zk9yN4HE503vFVBFiI8b+9fBa4cnPSvhttECLE5SmQ9yAEzW7qCjijMRa4jl3LRXwtK07e0QBEnLHNDE5pvLs81zG2CD8DUQF8j/mpgAuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 16:12:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 16:12:44 +0000
Date: Wed, 8 Apr 2026 17:12:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ice: add missing SMAC field mapping in flow input set
Message-ID: <adZ-d2q3eu2aQu-e@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081439.3241409-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406081439.3241409-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0044.eurprd04.prod.outlook.com
 (2603:10a6:10:234::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: bee6fbd1-89ba-471c-59be-08de9589aaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ojNG527O0lBKk1J7n3RwXCa5RfR3ie+htn3oXQ2XY8CH62Ft/jf+wjcfTzvexpoMrxvXmikTBHYqCGXB0G47w/zXRtagEo5IAMX6bnG4eg5w64xFLD5+IzwNzgobpjuOY6pHZqeAlkzHEh6iixv/uv1eGk1FIdFgQsJWRWwXKkwi4DrootTQg+llexi4ZVWbgp9X9MoLMm89reZLxEEtd7IrvU18HgwUrphzgNKwu3aH7sEf8inxnz7+3giccbFex7BsrLYaqehJbNs8NWl1uHDalXc7la0s7yYUI0aoTei91rgA9fb2Gob70rwxk6q1fGsum8mbRzrD4feznfobqBjmsr5f+Hu7pQ33OxjROoXWRVC/hwypXEvRrNdy1mLo2orYMmra+V1axAnleGO2ZNCPUdwUAr0ei7uUhsIdNK+pddveMOvjXOGfPFQa6M5KS9ilQ85K6Yq0r8ZE0v7Qihn0kfU8YaUdsm+YNHmPgaAYhMDoWVbEW3TJT50HTa0PPblGKTLNlIOyMIaiRi5jx/OdmKokFBoe0r2hMJfajqoWhII/pC+k9QP2t1TST6lF8a0BcL2wnPc6zqLpz9rF6DTkW67RqgQ38yijrHCF0ic176ob+blhdwtXFC8Q67ImUskf7oVM1qLYAkswmFF13l2zhrsV8yQBVkljVGvlyZVh6JFZCKdJrmOvqK3DOGVNBYknqghpG6Dw0rH4M7TYVqaoc2FOa86ikvxE3BYqv6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSePfqA+H4V0YYDTVUVUkVCDqvCtkkc8g1W239O/qD2r5ybC3zdr0oxb/g4O?=
 =?us-ascii?Q?2IvwLo0znZf17kCmy5iS6ifgh/MiLpws1Wdaj93Y7WboXO1CuaPvzZcTeocA?=
 =?us-ascii?Q?3BNsJvkY0yc6yrW1jQV3ils0s6lKyPQDkAH5YbyFtuSzPrVg6IcR5PmvPeYK?=
 =?us-ascii?Q?38ZN2ndZ/JCabhF0QT/RHLDvN3qFf5KR7ABR2WazH2z3exDRoZaKWOuXdKB9?=
 =?us-ascii?Q?Mzy2bzds9pt6eMLaP7WCCpM7LZ9Y/R3Eam1BVxaEfpEM3K99Sb8gImIb8Q4Q?=
 =?us-ascii?Q?KieWQT8/9BObvsJ6ziYKyjMTCL1hfz4GXZMYuIw7Tw7K6Jv3N1R886AcQrFi?=
 =?us-ascii?Q?typgtDqnX1Cc0QyDv6klb491YkR872xKNaxv6yp8l1xA2NfsEX9idrYfRPJW?=
 =?us-ascii?Q?LsTGBwoKNOgJRUwfByIpIf9H1elkl3YM7TNVJpLJjdumOFzOr9Z/cjpfRkVQ?=
 =?us-ascii?Q?2O+PWyfetzI3GqUDylwhP4jpr1/hz1j2zCrq0SHG0fwJP6HkMjTn5VxxZtjq?=
 =?us-ascii?Q?QytuAqubUKbBfm179turXbnuwBKp7KYZgEoY0TWh1xvotI0Ze2MpzHxktD8X?=
 =?us-ascii?Q?eO771zcojHkxhqQGtafMmMCN2MEJZQm0K73cKWNTg35lz02EKeUPOrW7sWIQ?=
 =?us-ascii?Q?9sXKLUv6Gd2llUx0muu7R+qEfckSgIdD8Qaz4CCgq88zh65sz3PxJf3HmorW?=
 =?us-ascii?Q?LkiBHeK44tD1jUMMVVpcsUly4/ric7VSQDyqJxFVTCc5uPgYfxOYCRE9sHnj?=
 =?us-ascii?Q?ukhfSkaWS7yCP3f89Wr8YtPSdRJUyGpWOh2ukc5NgedcEM+86cNRQ2MQeodH?=
 =?us-ascii?Q?Jq0YQ6sujVknB72tWJB5opu2FMRt8105Kmjw1HbsUtvIDXHgWpawOWwEASJs?=
 =?us-ascii?Q?GYuOlD1FFBrFhSonUAZrO+pNm6V93p74I5r81ImybsBe7SL7nX9yTXcooHyx?=
 =?us-ascii?Q?DBjgL9r1jpyCVtxwFEt+1k3Z7EpE4E7NREc6GDAJjlvp8acz2xoMAq397Sez?=
 =?us-ascii?Q?oufIpF+EDfzy1p0M0wWOgN/ifO7FlLmVBLbnjoMaOIMJBLCNLC/x2ls/7D9b?=
 =?us-ascii?Q?1sq8/ID+VeLTbJf3UGiGMFtk5KMC+IyahP0WkYKXQLOc8kJcVWhNE7C/64Zq?=
 =?us-ascii?Q?u8mHglAm1ATBDoNJaYczIY8/D+uN1OtKQp8+nhMbpputp92z+ZFKTkklDK9X?=
 =?us-ascii?Q?TLWsKdllhbWATDWXJnVrwOmTv7myLBfgdPaGOSwXqdV5ZTQq+1t+6xdNXi7n?=
 =?us-ascii?Q?EbfMxnenMpWF0UDjgDlHKuMwHMfpoMUsxIAE5ZCSVTgLJTvdT4nNSq6CJ/dh?=
 =?us-ascii?Q?kAbSixq8/qsQeog6DBCLau/2xOQsJ4FL9Rw1h70ydF1UPtYiw9WPeOT6yXlQ?=
 =?us-ascii?Q?iLxIieACnwsTtxecpYdbb/EGrYK8faBlEG9NPO8U2G50fAMgAqKobh8Cxcqa?=
 =?us-ascii?Q?TkrQge4bBnSBe0BZ6oEzBeb+wl56Lr/5NGvclW2eWNsVy9uQEzRE3sj9rK9L?=
 =?us-ascii?Q?W0/e720J2wOmz4SP6Glxp9ex3nz9dYufQ2dif6z6VgqDDDs6zq9wNg/8GkUb?=
 =?us-ascii?Q?21p1PHL71d1h219hk3apBSHCkhIZGTW+C6aOmVpbxGiJq/W2iLSoFrOGuQmW?=
 =?us-ascii?Q?hzJStSI5oF5pqmTtD2KNhA2h3Q7Q/mSgrfS38Vb2GXRQiBjLASDRrBXLk8De?=
 =?us-ascii?Q?EewQzldmvp+0eUFqZ70wTxQ+cNQ6ptgFWJKU/rQRAU/0n01DbuCjW1Ar0fpM?=
 =?us-ascii?Q?QnB09K/3ngt20FCnCkaMuYq7OVA2gcM=3D?=
X-Exchange-RoutingPolicyChecked: sXrx8rOF41FMV27EhTvcyInr6wa9H7Vb72ef1Aowo5gvG1pDqA+GJ0vQKAVHR2mMmsDpaLGT1G7hSnSbPbUYhsErEHMZ4nJbOkP3f7qf60LczEGnqijthC/aUA8vrqvEzmLEVkou+erNORyAVBPP/6EUO4TLTaLkdzp3QEXIfnPm3SnjDwgkQp2p2BC73Cp3Vo3AS3vasR4Pv5KFJgy/t73T1ranP57W8BmyFSn8k6z5P52qLCqNu10nVf7x/qqnwzXCyy+m+sHUgmuhb+ffngL8ti+I4xbPbv/5yP8eez+U6gmSO3q9jX95ob6KGmWITH+JGoqIqeH7G31WHNVF5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: bee6fbd1-89ba-471c-59be-08de9589aaec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:12:44.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ale4sth+zQN/q9b3xAivyQOJHIj5/+CVc0CvBW6Yp4sl2JgohMi0zYTtlShJbJaY9cUtVVj5zYwLmdDXG+PGfizuUt/1HpN8UTo2KMEU3GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
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

On Mon, Apr 06, 2026 at 01:44:39PM +0530, Shaiq Wani wrote:
> ice_inset_map[] has no entry for ICE_INSET_SMAC, so source MAC is never
> translated to ICE_FLOW_FIELD_IDX_ETH_SA. flow rules specifying a source
> MAC silently match any source address.
> 
> Add the missing {ICE_INSET_SMAC, ICE_FLOW_FIELD_IDX_ETH_SA} entry.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Recheck-request: iol-unit-arm64-testing, iol-intel-Functional, rebase=next-net-intel
