Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38474C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 11:51:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 412D7402D9;
	Tue, 21 Jul 2026 13:51:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 87C4640294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 13:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784634681; x=1816170681;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hXk5mgBsE7wfFy6iz1wfX4fnnE7T+sherKHgznHK9uE=;
 b=fUy3onp/1fbJnayXiykJT4Sk83pikl9PlA++H2wXMhjFBT9DEtj+vevw
 QF3kRBBYtUP0kPbUR7PFFCvYrgJC2kNTDGY5KYqA8VpxEkFEUry28BMee
 yGiZn2/CdvLaX5mE5jfnjrafitf0pHb4Oym96OE0uZgFzbbTme0QpnpVi
 Dy8Pv+E06UrZpq/AfQZsxmXgaTgFRAPvB3B1Do4nIv7ixVGDK6JONzTXu
 sMFg7onW5vjbwYraqqEhhfaHVc981fceej7IYq9gxs2OyUufHNUHXMTEw
 ky8Z6OkbmPbtgzYcD88M4QcLzh1ZS+iuaP55muvp9hnzwuTB/tX/UAwAz w==;
X-CSE-ConnectionGUID: 7AFf7B3dQYGs7d7OAqMwhQ==
X-CSE-MsgGUID: B/XRDZmLTzyN8lWVWS7kyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85174865"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85174865"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 04:51:20 -0700
X-CSE-ConnectionGUID: LStwFTm7TPSqIQXoDXqk1A==
X-CSE-MsgGUID: Xhr3BOViRsib841xMH755g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="255099541"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 04:51:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:51:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 04:51:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lye6DxC5HdjSo9T2IuRGSpGihPItfNSV+WfLiKkpr2iuwboDAVYz5gwIh/T9alO2sCCJVbSKoGYDjaVPTYm+nhKbhZADnPwTqhhsMpRBm15emLj0UvR6uGWBn3sQz0tgwVYF9hbhhE/puSUAwq04XajV2RHeK0lEPxNccj0fwmiP/2tSy5nMRBY8bbctqjDY6DnMfu7yz8Ewt1OnXjgVKfcSk1Iiot9DtFzgjBQU8sTNF5Xl+cKdKgu5VrhB2gMiKlADji30WqIKGVpJquPOQlnRk7iKMmQJwxIFGqukSPB8Bl3ZOBxxfoXNNMcaQJr/3JBmlYoKCq+kIbYmQEdwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEzD4nSLaz3kvpZjIANQk4HUZ6DG3P6YUIf/p/AFsCU=;
 b=PRESrl1jvYUCIUEnh/p6iElZ3pan4dwGZXbxMlG0WJzkeJgKJiUALyTtHCc8aZHYQfhHF7L8MldAcWJlFZR9Z7q5pYUOqXUvFDRAlQRjM/hHTFOtRwJYMBJHNA3iUM40W37MCBSwhvZ8gGxeHgijMvou2/q7HC39QQAgaClNgVi3hi8YQUHdG8jjNCQu236oQ7LT19D2ML2UNkj4oVIPeTaK+nRo+8dq8O/4S4MuyRAOkj49ll7siR/jIsg6Do2HpAzTMtldIa8jNLIJqeqDUUu1z3i1LJFXY4HCURCTNEE0wkgdsTeNEb9i5yf3b0KI2peo6HSv1gQb6bl3EPJ4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 11:51:13 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 11:51:12 +0000
Date: Tue, 21 Jul 2026 12:51:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH dpdk] doc: announce rte_graph ABI changes for 26.11
Message-ID: <al9dKzan6h0Mxe17@bricha3-mobl1.ger.corp.intel.com>
References: <20260717090121.1859773-2-rjarry@redhat.com>
 <CALBAE1OmG3d4=63YfqYCs+ZWWVzitpCcTBRTjr5yhLA-RZGgmA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALBAE1OmG3d4=63YfqYCs+ZWWVzitpCcTBRTjr5yhLA-RZGgmA@mail.gmail.com>
X-ClientProxiedBy: DU6P191CA0069.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::22) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd9148c-ec23-49fe-558a-08dee71e5c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aBI1W5lxPNgrQphUn5Ab4vwNutwNlbIzutG56s6t6aAvaH9j/55LmwVFsrdPSHFxuMi2bkDPw/3SletF0lkw4gwkX4DdpUBprwzqFOi37h1aeQd+vEW+VsMQbhjg8V0UwkZtyBnDQNvBLpOU52dsFBvNmtkSb4uH19upIzK1O5/l/BMOSsKjuBy+qohQHlPX3+NilRJXuGmJluuITqhr+ri9fhU3G4HBbiv07681xtt2L+unZHQTI7g4Kpu5UBhsIHKQEA5Belrl3jqSipb2CfADGxTeLZoAaf5jH2g7LeeFvoTyemHZXPppHmxvzFYgjkvKugrpxzS6R4rWhm+sW4OT0K6zjafyj0YiZ/iwKl2tPRf/Hka/Oyi3SEwHfSTcdPSBfn1NZNdzaMyoCQKspnks3N/GTMsCQUhlXFdwTW7se65NHQ45ahSuR0NAv8NQ3xrCJoaBsOS3UX/pkeXeb1IQy/EwaloOu6wTv1MmNqXVlmp8VzS7haJfUDh25buKqUf8DcLTPYg2vwGCVYGmKjvK9SjzqpSNN8fKOanGEvQ1JzXCJgQcrr6Z8pzrFFQIkrmI+HbdW9HhHbu1+fYfcAgvilbOICyQSC08yiWiNIFZAoiTjJ1FDNkqDcU/BfMQjDuCbvKRlJUjKqxbUFzZ68mek3mzrGKmyOPrMtkjJXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNiK21WR2VCMzJHZzA5cTNEMWc3ZTVGTy9jeC8ydUdIQktyUktYOVVvc2lC?=
 =?utf-8?B?c1U1MGFQK2RlWjhVbGgreG04RDBNcVRPbmdNR0VwOWVGdDZIdndncDhzWU9H?=
 =?utf-8?B?MUpRREVCUW9POEdjUHFHUUpaVm1jemRhY2N5Z3BBUXA4KzBzY3VrSFRuWEJi?=
 =?utf-8?B?MFBqcjMyZDhjYmxQWGVGNEJCdmRoZ1E3MnhPZjg5TjJqYXFZL2lvM2FYaWZu?=
 =?utf-8?B?bUFmMk95amIyYWQvemk2Mlo0ZWNUeno3Z1NIc1dSaVRQczZycFBZczV1NTFS?=
 =?utf-8?B?aUVabHhHdmlBMERqcVlVbXdHUDEzaHhiNVFhRVEzd0JRc00xeGVaYmQraG1o?=
 =?utf-8?B?bWJIZVV2dWdodjJ2NzN5TStqZ01HcmhBOTlHbzFNUmlPQ0V4UVVKQnMrMjZv?=
 =?utf-8?B?RjB2dWkwdVN2OU95c0ppMGxZNm8vbzRkV1lHUGM0dnlxWThNTzlLRFhBM2Q0?=
 =?utf-8?B?SnFvdzNPWVB6aTY0bEMwYVhycTBvWGRWMHozNnRWQkJma0tmWjNKNkVCSFdW?=
 =?utf-8?B?RFhRU2FsK3NBUk9Rb0tGa3RWUFA2c2ZZZXlzcmpoQTNtTG9zUk9iZlB0bllB?=
 =?utf-8?B?ajNlK1ViTGlSY256YUx4QnNWRExlQU5zNHZDV2w3dkliaTVLcXk2RGhIUmcz?=
 =?utf-8?B?YTVRRHJqQ2doR1oxbXJMU0JEM1FKT1htZ01IN3hRVHIwdmFQb042c0Z6SDlz?=
 =?utf-8?B?OHZhY2hYNlk2UVRiZVpEVzBRa0Zuc2FZMmRlbERyanJkWURzOEZVYW5rM1ha?=
 =?utf-8?B?OEZEN2JFT2pEa0V4akhmNlFXaWNIUHdZN1lHQUJiYXNQQmxYa3ZPRDNFdnpV?=
 =?utf-8?B?Ulh0VUt2Y2tTT1M3UDhYNXlQOTcxT0VwNmJhS2MvTThUSGJTUisra2VVTHVD?=
 =?utf-8?B?aHBDaUg1R3RtTkFSU0hzY2NVQ3hwMjhRYlBiUjNSdEk1UWk0ZWFkTlp1YlJk?=
 =?utf-8?B?b3BjVDdmY05lbU1uWEFvYnk2M1MzVmR6Wi9pM2J5NXpzOVh4QmJpUEdWOTB1?=
 =?utf-8?B?RytxQXdUSjMxa2pXMGtQY0hPbExSMHlySVI5ZWllUVEzYlR1N1VJZmd3aU5j?=
 =?utf-8?B?bm9oQUtaYk83SUVkSXY1SlFZL3dzKzRQaHVma3F6bXRsSGl5ZE9pcHk4VllH?=
 =?utf-8?B?bjU5dmJWeDRkTzh2czgwRERqZ1A1QncwdjlxNHB2N1hxaDVpWktwOTFtWGZE?=
 =?utf-8?B?d1VLREFGOWRwOUV0Nkk2MXBPdDVlMXhYZFZabUtzR3hDWlkzQnFYMG5VU3BY?=
 =?utf-8?B?bzhBQzkrVVVUcXArQi83RUI0VkhhRkp6bFR1WmFyaENGZ1AySUZYcmFMcHZs?=
 =?utf-8?B?ZlUzdkJHSld5YXc5WGdyYUpQK2s1VHVvVlh5eWQ3eWdZZHJZMFhpeHkvWnI4?=
 =?utf-8?B?MkFkUS9ncEhNK3pycTNTZTR5UmN0T2g5dnB3dGFTVEw4QXhtUjRlYm5sNGFU?=
 =?utf-8?B?ak4xNGx3a0gyNmhwbCs1d0xYSkdHbnF3Mzl2bW81QmVnNVpmR3dMcFV5SWFj?=
 =?utf-8?B?L1VXUmZyanAzd25lQ3A0R2pORDM1L2VuU0dLMXZrQkYwSU1yMThiMFVoOUw4?=
 =?utf-8?B?T2RhbGJyMmlrMi9TOTBHWmhmeVVXSjZValJZNlJ3SnVlVEV0NGxNY3VVd1kv?=
 =?utf-8?B?Z29RQ0RWd0ZCV2ova3N2YXlFNjIvMzlFbzlDMUU3RjdxNG5ac2J5TzIwQTVF?=
 =?utf-8?B?dVoxbnV1Q0xKT1lCZVExNVBaYzFEcFNkUW5yZlNsV0VUZU4wbGhzSjd0dDds?=
 =?utf-8?B?L3IxYkdkRzN5Y0dodElnc013dXM5RkVzOE1meDlFelhISDZHU3NKNUV0cklN?=
 =?utf-8?B?WUxaM2Q1bnQ5WkRCN2xJa0ZSQUd6aHB0a0JsRUFxcCtjdVF0TElKQjFqZzd0?=
 =?utf-8?B?VDJxSjdlNm5ta1RQdldyYTNubGIxdlRuS2JVa1BZeDdjTFg1K2IyejhhTm9K?=
 =?utf-8?B?ZVhiZUVqNnJOSytVQXE1TGxlQ3pIZklmd2hsbXY3OTYvRkx3Zys3RVRqUE5h?=
 =?utf-8?B?UStZMHk0VS96R0Q4VzZMd2tqbXdFalkrcXlDMWhnVTBidTRGcjRUelUvWVJC?=
 =?utf-8?B?RTVlbWYxblZiemFpTDBXdDdTeU5WOWxzU1NSUDhxSC81OW9GdVRsVnVSSDcw?=
 =?utf-8?B?T2trVzdVU0ozYm9aRjVOblRMdlFjSUYybmJhTEJQQndhcFRvbXZOWUU5eWdr?=
 =?utf-8?B?VzVWdFdKcTdtTnpORFZIbVFyYzNGRFozNW9RMEdvdlM2ZDZUbmd0SVJNYlBp?=
 =?utf-8?B?NTlnZmNLRUpOMStDNlhTUmp1TC9Jc0pXS2dSdjNSdzFpaXpOaVllaHcxblla?=
 =?utf-8?B?eXJ2WHgzbXRJaHM5UGF5V0dqWThaRnlTWktzam5FcFBkVkdseXJQN1ltaVB6?=
 =?utf-8?Q?7bLEty20M4u6KQiw=3D?=
X-Exchange-RoutingPolicyChecked: ctkMQiioPaRf9i+ICnMQA+dm+AiiFxkwLlTgjYzGYYs9FZhGX/VTxcyCPmE8ozzckHJgI22BWzkJC3Db3cilDYXwTcDZp79eOwngHuLglVrBHKBHK9bSbBHnW/wJMcS8IkA4Iz/ymiBVXzv2UJBbJwC/aW5/V6/nx5x6aa7Kbxh4dRCzi/7+AmmiKWI3vzCfAk//6G9heGiRRG2mUohSqjihL4SDRKUrslMglQah0S4ZCPMCug/TX09DsQEPAAE+ZFRW4FwpBNcjXXgSBK1YUano80MmT3n6Gygq95CJQ65LxajXPFk2FzcIqohE+2aP7Me1Hd08vtD7eRpjiiEd1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd9148c-ec23-49fe-558a-08dee71e5c9b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:51:12.2997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuPJXyC9prsMi8vnABH9IrJtlxIAhimQT0hYyCjttsTD7pqHX0nqgjRn+W7cujKp+yd9V9+ul/WPW2H9d3ol5+4jIa2yklEQqe7JSTaVDds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
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

On Tue, Jul 21, 2026 at 03:53:56PM +0530, Jerin Jacob wrote:
> On Fri, Jul 17, 2026 at 2:47 PM Robin Jarry <rjarry@redhat.com> wrote:
> >
> > The graph library internal scheduling will change from a circular
> > buffer to a topological bitmap. This affects struct rte_graph and
> > struct rte_node layouts.
> >
> > Signed-off-by: Robin Jarry <rjarry@redhat.com>
> 
> 
> Acked-by: Jerin Jacob <jerinj@marvell.com>
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
