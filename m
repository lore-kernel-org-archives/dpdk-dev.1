Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38BEA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8821A40648;
	Tue, 10 Feb 2026 14:33:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 13A62400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730434; x=1802266434;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Ote2RE+PR4Za/6HMXs28tQizxgf7WvAIdnVNr180hZM=;
 b=Ujd1j6Yv3G23udL93aiRdqWy6gorr5eaVL0tOuxAZCAxMD+STuwY+P7R
 4FRT8hAfKfnYQRi8Mc3PEs9+SCubMHqczi6u6Jkonm6xPDXT0Cd0vq9dK
 dUyJ0jhA3AUU5d2FadTM4AmXh6AjcwDbOCkKa71GYhjzDtkJ9fWDEup6z
 vHeNzk/EjxRjxFIu7PFdQc+ppBi2rr8lrtGZzYZvkJIj5Vq1D98AstnH5
 IMrHBqenNxpo85JWMXfuDsS5S/DM6q12+wjvYc7DTf5UBGtkNCqK1rpg9
 GLL9Npoeod24x4XvB7SjUNYS21paRuQkLdCUHZmN6PbkBvo5hF2OO4thR Q==;
X-CSE-ConnectionGUID: Wewr/QItSK203760p+MIeg==
X-CSE-MsgGUID: n0jzjfkaS8WferarPDhzXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71575432"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71575432"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:33:53 -0800
X-CSE-ConnectionGUID: hZsl/OWdTouBtuISXurFoA==
X-CSE-MsgGUID: T/l50tSCROmxLJP4D8gxVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="210978859"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:33:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:33:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:33:52 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:33:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFRJhFa6VF/lWbm/yZ6I3Vgma5XLn39qa/Q66Z+lSlZe04wnS11Gekrnl1kNTLCql2SV6Wkpq2epkbSpNEfDoSkmU4PDmNqVXqiAHO5AXkT1FTrdABZPLwFmsoKJ5aIp1Sqpnk6pxaWSFIArN944+SYjq8OyE65xJECW2Hr3npEY7W93HbNBA/l0Qy3TUZhczLYBKGDght/N2RYzIrRJYaK0o32wKQKZ3q8MGu0o4vePu8HEf/s5BZfkjcT/RcBBeBKzibLK6PdXZzzFwB0xUjIaJIN+UBXTpuZV0LSxhQ0cyAE6gKdlrSy452sIMiVVcKBVL0sytt24/wgwzq38qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGfd6EIqS+yC2plYAMZJTB1xxu4amJ1Q4GMDMQ/MgBM=;
 b=awZYWighfm4fJsi5aC+0Y7tOyDjYmr565cbGRaPD5F309Xqo7G9TmYsxvZmTTtXm+NOvBECyT7emqfTNsKCrq4sf29ObKf5f6/5EVINkpcLicocK/ypcsXaTfslBwbchUqWyvHyrBcMbuVi7lXcKSWADvyPvvpCiGn8KUtciOQdYZjI1xFSQqJqYX7gnt7TACxWSRojJr4ZPxXExX3k+BGS5zoyJwA4JDmuPYrsAWcP4a1hXNyxTKmHLUa0O8HRJo7hlqZIU45rV94R+MzmjpPzIXoySM6/Abj02A3Or9vCRomT1A/IkTH4QDGWuq4sTMqUb6vzPQQSaMVOTQz8hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:33:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:33:50 +0000
Message-ID: <2ef75ee0-0df7-4edb-9e59-e8005d7804a3@intel.com>
Date: Tue, 10 Feb 2026 14:33:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/35] net/intel: remove unnecessary flag clearing
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-22-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-22-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0060.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9086cd01-431b-4ec1-aa60-08de68a90654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tld6bithNmpCTzNtajI0NXJacHVtNzEyV1gvaDVQV3d5NEpiK0swczBiUnJB?=
 =?utf-8?B?bFc1NGpuejN4VlFFOEN2cm9MRk5adHJ5TVdQamJJNnplVHRtdHNFNEh5Mm9k?=
 =?utf-8?B?bjNhUGxCeDd5YXR2K2JaOE9xT2MxR2pFZW8xT0kyVVMzMTFsMlh3dEVwK3Ba?=
 =?utf-8?B?bTY5VXE4aFc0RmNLa2JlSmRGTGUweGVpRHRkNmpVSWFucVdpUVczUitjSlpV?=
 =?utf-8?B?UUhoTzNSY0srWUU0MjhQU0pOWXowSXIwbHRYZklyVlRPcVJ6TXNsUDlIOFNj?=
 =?utf-8?B?NW16ZFZhdXBoYmNVV3d1Q0t0OE1rWjNDQUpsNlFITWhNcWdydGw2Z3hOK0pU?=
 =?utf-8?B?dTQ5T0hOREJqQzh6TENqUEUxNmVpUmN6eS9VZTdPQklBbDdYbGY4TmlKeWw4?=
 =?utf-8?B?ZVNQNmNQOTU0V1l0M3NqaE1iUTBrRFdnVmhTLzUvQkttekF1emhhWVpHZk40?=
 =?utf-8?B?ckVVL2JydUpnV0kxWnU2aFBEcU02M2xBMmo1a0Y4aU9ZVzVUZGM2TW5Vck0y?=
 =?utf-8?B?ZjRuelVBaGVaSXRuaFVTV2YwcmZjeGlEdlhmcy82UHpwNDdpRVFNTCtOMEx1?=
 =?utf-8?B?Y21rVXltT3RKUmlzSEd0UUZXZ0lFWDRsaE8vcUVsZkU3bE1HMDlsL0pVelU5?=
 =?utf-8?B?U0dIQW1HVFlSOExiL3hOU3JnL2crSjRKTEkxVHZibHJZOC9sV0NxemVYQXRV?=
 =?utf-8?B?QlJTMmRjNTFIWk5aUklLTEQzNThzUW5lMnFNR0t5YXJ2WmNaZVhMa3pkMkVB?=
 =?utf-8?B?dFpma25XMUVuNXBmSmVjS3NHbG5QYlVMelByZmhWbVZOejFzMFhpelp4ejdN?=
 =?utf-8?B?MXBuc1UxL0V1b1p2SkdjRmo0d2ZEazRXNlZLcVJIQjlkQk1rKzg0QnJtRnVI?=
 =?utf-8?B?dGdReGpnWHV4Rk5hbWRvZUlkZ0NXVjd0Wm1tdklLUnZoY3J4OEVBUHJoczI0?=
 =?utf-8?B?UjYrMElJNkRQKzFpQU8wOHhXMC9BYkZ3NkpLVVJ3dzdSK1ZTY25RVFljS0N1?=
 =?utf-8?B?K1laK2FaT3hSbjVSaHZpSHRrdlFML1hIRW5jYlFzSFZRVHREdFRmNFhqaytL?=
 =?utf-8?B?cTdKUWpTSVFiM1BzNitRSUhaa0IxU2Z3M213cjVYYnZUYTByRHJXZnRRMm0y?=
 =?utf-8?B?QzQ2VGlwVmhTYlJVbkk5SUxySWNqWXgvcWEwS0FFNDNNbW43MGQ4VDcyOStY?=
 =?utf-8?B?YmsrQXhlVjBuOUpDV05TOVNnVENJWlh2VVNLanI5M2Zvcjc4YjIxYmd3ejBr?=
 =?utf-8?B?WTZTZHpZWWdXZE5SNHZhd2xrSU5PWDFLNko2RG9WRmJ5Z1dCSmdvVXp0U0oz?=
 =?utf-8?B?b0Q1YTdHNWd5UmFTUWFFWlRxT1piczRlczhKMmQzdmRhbG1IUlI5a2hsdDZi?=
 =?utf-8?B?Tjc4VG5iWlF5OTZxTzhtd1pkOUhlRklielNtTHBGNDR1bDQ0bmRTYm14S1lS?=
 =?utf-8?B?K0lLRit1NDJzWjV6WHgwZTlDVjB4K2ZYVHR0WFJMRnloNGg1TWhwOStlZWNP?=
 =?utf-8?B?U3JPNE5oaS9JbUN1OFBiZDBxckRReWo2TXp2dUtNZzhCWTArYTk5R3hSZXVR?=
 =?utf-8?B?Wi9KL3c0NWZ3dlhzWFhSV2VLWjlZcFF2SFFma0J3dlQ3MlhnK3hZQy9pdjAw?=
 =?utf-8?B?MksxT0RZdnBUWVdmQ1NkeWpYUnFyaE5YZE5GREFLeFhpUkFOanlzM0FJT0pr?=
 =?utf-8?B?dG51WFl4UzFjTFFRaUxkYWFGci91YU51bTdHYjJCTXJFb2cvdHhpSTNock1C?=
 =?utf-8?B?akpKOXQxUHBZL291MzhBeDc3YlExeXFRbFpMU0gxWmZieUVLck15MkR0ZzhT?=
 =?utf-8?B?Ky9vcmpxaTU4eExKZWRsRk14L0w5eHpGRjkyR0I5b29zYVRnWDZma2ViWVEx?=
 =?utf-8?B?cDduU1lGQllJdHRKTlRZc0FyMVh3dnVvT3cwOGxEeUtSN3Rzd1NWc3g1YkNi?=
 =?utf-8?B?OStLM01tTnNhLytyVGxzcEJHZ2FVVnRNUDg3YmtudDNZa0d3VC84Tm1SOXIy?=
 =?utf-8?B?bWF1ZXMzNllPdGVTN1FTY1dadkxnWWxZSFVjM1V2YkJ3VzR1WXhYdzdSa0t2?=
 =?utf-8?B?amZMYmRLNXBoYlpzYnRYWTBHUHRKRUNGV1IxcWRTanJYVzZ4elk4ZmhaSU40?=
 =?utf-8?Q?KYNs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDY0R2JBNnR0dWg4aHBtTEdJTmVjd2pRZlY3RitSU3RZWlJHeTJmKzFhcWdF?=
 =?utf-8?B?Y2RJT05neTZrQ2ltSlducklvRm5JU0MzVk5WOFcwUlhDMko3Wm1wMUI0Zzk1?=
 =?utf-8?B?N3N0b0JydmNaRjMyZXVaS1F5NW4zTUZObzZUK2o5ZDdBVzllSzJjT3N2OXc0?=
 =?utf-8?B?b0hhRHFYaDFaamo3UjUzVVJJRFR1aTFmdUxBcWxqcFQ0TmI0UlVHNzFRWmtV?=
 =?utf-8?B?ZTZraW0rUmFnWENtbkdkRERoTVp3eEN4R1RrUVpINDZ2aXpwK1BsQ0tJbUhs?=
 =?utf-8?B?VU1QR0pnUTFTblhuNUtmZEhMN1JTT3IrbnMvc3N0RHlCc2VIRWF2dUdXOFNT?=
 =?utf-8?B?a21RUjI1RFJYZTMxZjZFSldtakRvMXc3Vm44NC9oME9qdjFhYlBwNVowei9x?=
 =?utf-8?B?NTNhZzBSZnpLL3Z4SG5NSWdkSHcvV3dwdGFJc0dsS1RYazg1QVpoOG5mcnZt?=
 =?utf-8?B?bnlBVzNvOXZ2Z21kRWIwT2V4cHhFa0NkOXJwUUpUb1pIejBUTFN6WHdIWGtQ?=
 =?utf-8?B?enBvVHVMS091bE1XQzAzeW4xSm1rQUp1TGlkMTZBN2RvNjdNMWlkMjFDZVpq?=
 =?utf-8?B?dHpNNFRBZWNYaGJZSllHdXR3VWE3cHRyS2RVY2NoRTFNZEllVnB2V0p2YUlG?=
 =?utf-8?B?K1B5bDl4bGkrY1Jaenh1VmdPTnJwc0pqQjk0Y1U4cnNlZFlIZkRxUmlzeTJ0?=
 =?utf-8?B?TWx1ZjhPRmRscWIza0VpNUNFNFJQK3JOaHdaTnh0ZC9HUFZiNmVrUUZwdHll?=
 =?utf-8?B?bFJJdytwNzVSQjA1K2NtcENmWDV6Y1l0NzRDaTBOWHhURy9lMXhRTFRYZGhk?=
 =?utf-8?B?VUtFL3loZjRBOFVsdU9qK3BYSWRkMnFUSmJVc25ZQktMWnE5eTFRSUxHSTNw?=
 =?utf-8?B?RzZ6czJySUVCa2d0TXAraTFTQytqaGNJNVB2ellnUm40Z3lwbUFTbFY0b3dK?=
 =?utf-8?B?WHBtWW1VaTFhcjVPMS9oakRSM3M0UTRSa1ZTTXY1Yk1HaTd6L1JKQ3dJSFQ2?=
 =?utf-8?B?WVArK3M4U2Z1ak5obm1UUElXMGZYRjJkaVFBMnU3VUQra3Uycm1qc1Jjano5?=
 =?utf-8?B?RklkS0tKUEkzSGJaYkFGZzBycVNhek4zY3BSb1hGSyt5cGlzSTB3ay9yTEZ4?=
 =?utf-8?B?SnRjWGVwU2xQbDBndmtHWDd1NDc1ZERhMFNsZjhac2xXbmNpOTV4OVdibFhW?=
 =?utf-8?B?SWNKdGgxSEQvVndkd1h5V2dvUXNDL3dWdDA1UkY0SVVNYUF3eVBTWjR4bDlr?=
 =?utf-8?B?cVdRaXBNSXc5TFd3MG5VVGdsK21VRExkaUo0Q3BSSG1kVzI5WjVaNjh6S2xM?=
 =?utf-8?B?b0FsdlJKanlHL201MWNnSWo0eDRBWHpEMDhhS1J1dDQxYk9JTDlDV2FSQlp2?=
 =?utf-8?B?dngyeVRqNzFjN2dRMHJreVA2K0NqR296MnNRbnEyQmN0TnVXZUlzZGxIaXNL?=
 =?utf-8?B?dzVpNjRhK1FKNkFGeWI1bmFpOW9uMndlMkRoQTVkSUIvVjl4S2lqeDdmMVE1?=
 =?utf-8?B?azg2ellPeWFJSUtBSFFtTTdJM1I5OURXVVFuc0NQUEh4N0JJTElGS3FIVEU1?=
 =?utf-8?B?QjhrRnc5YXRRRG1wMmVac29tMFN0SjZ3NWtoR1I2M0lZNGd4VjZQZFhNaStX?=
 =?utf-8?B?YUgwRUxQNlZuNndqQmdZbFJnbDZKRklON21aWFQwWEY4OUNnNU52ajBnWlp6?=
 =?utf-8?B?SDRRWm5YaFdiRERHQ3dYU3JmUFdnRjFlOU55SXllR0N4OGZTalFhcytkUlFX?=
 =?utf-8?B?MENkRVhLWDZNc1JwRDBsU240aEQxdFFsamVOaDdlVE1Ya0VhQlBrU3IrTUZZ?=
 =?utf-8?B?Z2tEdmUwK0ZKeURyMS9NU1B4cDhFQi9SNUpaVkszb3dFU0VGSDB6K1RFa2hV?=
 =?utf-8?B?UCtoWVo1WHVES2piVHB3bmpjWGI4ZzM2T1dPRXhsSDI0NWVSTWJBWWpXWE1o?=
 =?utf-8?B?dDFXRXRhZ05ONUVJUE85U3I1RDFhUWZiV0UxaXVuakplaTUrYkl4dWVTbkx3?=
 =?utf-8?B?M2pDaEZPNjlNSCt2QVV2L0E3N0ljSE5RNzltNytDNFVJVkZRa0Z4bFVXaFJS?=
 =?utf-8?B?a25VNm95NHlpeEY2SjI1STRXc0RIZnhlS2R4U2FFcU5vc09LY2N5eVhRTSs0?=
 =?utf-8?B?ZkdTcnRFL1kwcTk3TTNUSXlWRnZ2NU83Nk5jR0tyWU52bEdFUkVtUkpjci8w?=
 =?utf-8?B?RXFhQy8rdUNjSVVZT0lrY29QTDVNYU81OWZEWmFUVWNTZlVWbWZmcVB0S3NF?=
 =?utf-8?B?SnRMWFZJeS9oT0JpK1hFZkxCZGNXRmZxM3dnQllBVW5PckxBaEZxb0hqaStU?=
 =?utf-8?B?NEVESWwxcGdKUDlhcHNObkpqbWd4VWpDZlZwWnNudVJDS0pBYmxEMTJjTWha?=
 =?utf-8?Q?Xkh7mAgUB221z1JY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9086cd01-431b-4ec1-aa60-08de68a90654
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:33:50.0932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV3pO0rCNRpUi+UJdCk+6zOusL3rrWsnameAKaPxho+RnMXEp+RkrObWm6bzbrwyjziD3GfnYbc4bU9IAQGXQ9kA9UVVH17XXh5KLoxjVaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> When cleaning the Tx ring, there is no need to zero out the done flag
> from the completed entry. That flag will be automatically cleared when
> the descriptor is next written. This gives a small performance benefit.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
