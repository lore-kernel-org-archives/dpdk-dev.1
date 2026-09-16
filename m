Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356ACC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B2C8427BA;
	Wed, 16 Sep 2026 13:10:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D92D04067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789557024; x=1821093024;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kEcXr/1cCSiefsn9SDnGLfhTsubkM+S6KF3Y+ICEMHo=;
 b=h6+7yC6CcJ8toT+egCkSWH/xGFPiJJ2vrhmjhyvVr+w8JvPqdGpHYCOo
 FJ6j84pU2MfxMCVghzRBC07kPEhB8/+8qccKasqr5AV8X96F7jJ6/TcMp
 QECGJQUr99XEI8QSu5J+dqHkiSJsCReNNtOeRK+NK1I9KBY8XEW/L4GPU
 Mqno6uVKkhNLDBFIAyRs6NkpO2QNDjlp948RgMWodFnK5X5T661rWX3xC
 VDkyhx41ECU/keHNomUas/2uoW2pOySh3GS1r9/ot1ErfA9t3HeIGB8id
 fq70P0P6xuBjQZqhMBjzGeAEMfY7hcMagjBnG4JMM1TtOS+HXU5Qej9Ug A==;
X-CSE-ConnectionGUID: EWzheyNJTtqkPkzQGQBQ7g==
X-CSE-MsgGUID: LQbMkzVHRheH/W/15MJ7kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93634198"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93634198"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:10:23 -0700
X-CSE-ConnectionGUID: DKDmm7hiSyqveu17BASlFw==
X-CSE-MsgGUID: 2Vy1DsOqTImX8ZYgwYOuaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="267098188"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 04:10:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:10:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 04:10:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 04:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVyK3Y3QKCmOgBdY2LC51sHJ2jcOTH2yAmM9qBjkeHfDf/4ME5OP2lUNf9+92KTyxSbPItWyLbChwqWGJxMOAcEvK58mFPpP+CjMYZW0X0SGeOsD6Qbne06DlvJIekCKWnulNhnfq4gAQMvmwUAhB1vRq7Fia5MoMq4kNlcsFCK9FUL4jmPSfg04Xxb4MEZZcPL8lLabcGKrCvkgsqVx/UwRuWS33jaqzLnkiSu+gJ1+2vltJ8jJkB4vRhZ75ThErmbqpPsaK9Tf1zcf8RViIop8cfTW+Xnlhx7ROwb/jM30pKipqti8cFoledKobsPF27DcOK1j86Tg2GIXvUbBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0piRo8gYUFMDB3TtPDxldss2t33AtFsm4/w4h0y1IBE=;
 b=x6+c8XfNiTkkyARTA5QvVuA21rBItApCzrICdHvGGe53gBVZjmQ5+Tv0zsP//cau3eN3CapRSzLp8utWWxYbtuOdfTMINxs015SXaDaA3Hmp7vkv0gYwzNpDV5qv14Waw/MkKRX/LiL6q9wsAk/ctxJ3/6vEb5v+MI6+D90f8xE+B0Z189y3BDhgXQGJuNT2pOmAd9os2Vdpv+FbhK++upvHqHIK+QTnq+ahTWJtk/0CEmlTiW4nN95xCG1dPFWEbm8u4BlvoI0PYE4U5H2k6lcEpdezcTi5RUfKSYII5Sa+w2mbpKu2Xbt17yWmczk4Trae6w7qlnJQ5RmCa8KGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB6465.namprd11.prod.outlook.com (2603:10b6:208:3a7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 11:10:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 11:10:16 +0000
Message-ID: <088621af-c8f1-4ee5-8018-0aeed891551f@intel.com>
Date: Wed, 16 Sep 2026 13:10:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/26] vfio: do proper teardown on VFIO cleanup
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <818e1b48e7656636b76f223d1769b1b25897dcc6.1789044747.git.anatoly.burakov@intel.com>
 <CAJFAV8w31Awymm2y=h9ja75erkV4yX+KvRd50scitH9rwQ2-KA@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8w31Awymm2y=h9ja75erkV4yX+KvRd50scitH9rwQ2-KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4dad9c-dc5a-4b01-f594-08df13e31649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|6133799003|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tlxtIWRVV3xNTc0fQr4vTVBDI8UeI50ZoLavKsr/GVfSOWYqRvUThU9XV8BfmGsObiSz3CdJzVqdjQmEIoyubB16WicOz2UDDX1bPk17lVTkQthPFECCy5eUKlS4KgKqlib5nUUBTwS7C6yvOxXKWscb0BawEwbGa2qTsIqJZMqgS+9Nqcd3VfOcj+dCls8zOvUAY28DEFEPnchaNkT0s8sA+KAF4zglm4ndIxgMr4P804oIv2iD3e9G2VPBA0/Sl0tMpRuvPYzBlAW4P0uGBzsrb50amkovawIjCE2a/orjTJb/meg9N0FtIlyEySGwl8k2E0xRLZrvuJUgBWCnvzRyvBmA5nCPUtA3UQaODA9Qc2hqUCxkFlcpNPtfg+Zs+yFeUprPmywLqNbZ3TZ0VMsxXN3/G8cGHRCugzRiWBoNoTJrkUq6Y5nZJvqOVDi9Wd0rSOnzSnbj6c0lFfFnuJtqn40OjIMlGC5FjjgOVA+4tMNoBFNfKlR0JILXoxZQNLpBg/T62/R2YYGxj1RltzoYSt0OAzJgG/PIA79V2tW1w1qBANBfMATUl7tciMRjP04lhBQeEAkNYxk6r6SnDEly0HRteSo53TO6b54PBs7/pdcd08nAPCB9ZmTBuToUL5x2LgRfN0wnDineg36XfFJ/1qvzXzchBbGXAmBJclA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURaWkhDTTZYQ3B1QVVXOFJ6MWpkYVZZcUhEclJMVkM5Rzc1akxkeENwUUpK?=
 =?utf-8?B?MVNXbzgzVExsQW5xcENwS1pLSnNtUnpJWEQxYm9SRWVMV0FnL1NiaDV0Vjhu?=
 =?utf-8?B?ZTd1MHNFMXYzcUtiV0FsNHBpSkJoOHoxa2FlVjV0aGszb1hQeGZlUjE3UVhv?=
 =?utf-8?B?cGZ0SGsxWHZBWHNsS0xVczNlNzlvV1ZqMVppUzR5TkVOS0NoZ21PRVFWTDZE?=
 =?utf-8?B?SDVVeFZOT1ZJOFRuTDE2ckhscW9SSm5kWmhibU55eWFWd3VZSmRUbmZOQ2hD?=
 =?utf-8?B?c2JGVnJ1b2dGTnQzdEJRbUJLVXZRTHVMUWJtblY1ZWdxM3VHRHNpdW9ZMEdH?=
 =?utf-8?B?RDh2TEtoYmI3MjBybk5SYXg4RHluZDNETWJ6L2tHekxQUXcxenFhYXJmOXdT?=
 =?utf-8?B?YTRtVTNJM1pWRFBqSzVIcTBRaXl0VlRtb1ErZHRzemI0cmU3U1kvdDUrVys2?=
 =?utf-8?B?R255ZVh2dkxIODg0NHNDdS91ZWhKajZoUGxxZVNoNnRERDkvVjBxcUxpWHJo?=
 =?utf-8?B?MSs1RCtzUW9qbzFOQnMxWm9UUmdLZmlFMVQ0S2JIR29leGthcHo2UkJqcVNy?=
 =?utf-8?B?VmVaeEtJTk5qcGRPQjlHRmJFdWNNZlZ0MVhBT1NXVUVlVm5pcEZoM0t6SFlG?=
 =?utf-8?B?bWxsdGdWZFBVZmx4ZXRmYzhSbitqZlVIelBuMUNHUlJrU093bFJ5MFZnaDlm?=
 =?utf-8?B?RmVYcmhoZHNJREV2WmFVUis4UnhQbSttTWpySUFpSGVEcGpoSXNRVnoxY0pK?=
 =?utf-8?B?elZ2VUZNd0t1U1VNVzhxc0hPMzZXVytkeE5vdEN0KzN6cFk0d3Q5N2hDRExw?=
 =?utf-8?B?ckVZTlgwaGMxTHhNS1B1M1F5cWx1ODM3UVpyT2lFQzljQ05oRGpYM01XWGJk?=
 =?utf-8?B?OXlpQXJmK2ZmcVdqY1djUE9ZTVV2SVRrYUNKeGxZNDhQbVR6YStpZThRRWNF?=
 =?utf-8?B?elM3RVBUUENBRXVCY1NUQmltd3ZUQ24zUE5aTk9kdGdkdk1tdUZBem10L1NV?=
 =?utf-8?B?aDhvMmh2MytkQTlvOVJ1d2F5Mm4vKytXNVl6Z0ZYM2l5Ymh0ZExPTmpTOXJi?=
 =?utf-8?B?ZUkxRTdLd0doand6eUEzYTlQS08xMWU1RUVpcEMzek1CWDU0ellreTl0dzRo?=
 =?utf-8?B?VENsaHFueU4xblAxVlFPUHlFTHFUQTBTM0hnVTlTTXR0SXpieHRiZlRaeVJl?=
 =?utf-8?B?ZGNEUWhNdG5Dd0hLb2FTeTJYTWowRCtBTGdYK0lVMkc3amhyUzVPSlF2WnA5?=
 =?utf-8?B?MmtuVGRJQ0M3RURFV3MxTFZ6WnlySkFkbHhxSHZ5SlZ3NEtzWDNCWVdwdWx0?=
 =?utf-8?B?WFFYZ0gwNnBSa0daVDZ2d05ERXNTMVBiWFR6dkJHbHk2VnI2bnZsbE00dm45?=
 =?utf-8?B?Z2dJRkYraVBhV0VwYlAxSjdpc1pIOUZ5UHNURW1OM3Q3ZW1aSGc2QUZRVzB3?=
 =?utf-8?B?bkZ5OXo4YW9ub1NSY0E4MFp4MUdxWElHVm16UUM4aVY5Vm5BcCtqS0E3SkdZ?=
 =?utf-8?B?MHRGejRPQkQ3QnJUTUQ5VEEzUXpTU1V4d3N5MHR2Zlo5UlI0eVFkdVRlWXlL?=
 =?utf-8?B?WmJxKzNsTmN1OFlsaEdTZmJ5cDdJVWg1ZHJ6TmlJbk9RWUhYVDBES2Zibk5l?=
 =?utf-8?B?R2VDK2NWZS9OUHhNYzVyRTQvY044UFpWRVNvN2wwQ0dRQjJ2alBFZmRTZHdz?=
 =?utf-8?B?VjBWNzlWamhEZDRWQjBJTTk1OU5aVWZneWtpd3NSWVZ0T1QrRm0rL0ZjQ2tT?=
 =?utf-8?B?dmNlbnp3UVR1OHRLZmxRR2dhWW1GTk0xK0RzYmlQK1dvemNncDdXUllZRjVX?=
 =?utf-8?B?cDg0TTBCc1Z3RjB0WXNiNG9TRDNObFlyMUJnOHNSQmpxLy9GZWZTakd2WjBz?=
 =?utf-8?B?bnQxZExYdVZ3WDdaWGR4RkROZmFya2ViR0d4Ujd4TUV2UlFhTjU5S0hqZ3lx?=
 =?utf-8?B?T2Fvd0ptdFVEbVloSElnellyNGZMRzN1aWZBTkREV1UwMjdqa1lsTnlsVGli?=
 =?utf-8?B?UXhFRUNTUzRXbWN6aE5KTG5uNCtpS0d5eGQyL1YrTncyMWZvekJ0U1VRRjl3?=
 =?utf-8?B?ZWxEejJIWjlDZ0RGZCtraDlCdFl3Z05kT0FBcnp1aE5RVWZIbThnWGpWYS9J?=
 =?utf-8?B?bjlaZnVVR2YwemVBUk9URkMrLzA3MC9pTlBjZWRDczZpZkJDekxndjh3UjNh?=
 =?utf-8?B?NGNZQnNWaTEwSXdUOHUyU3drTU1VRU9zdU5ybWFveXYxMEZTSkZKeDVMT0NR?=
 =?utf-8?B?YW5QaUhSaE1XSENUYkE0ZlNqZ3VkOU1mRUw2a1ZQd1QyT2kvOTM4aWduRnRT?=
 =?utf-8?B?ZTRmQ1E1Nmo2aEpXZkpudGdsb0JqejhPOVhMZWIyekdZQzJrellxSmJrYWpw?=
 =?utf-8?Q?K8Wd5FMvuy+lSdxY=3D?=
X-Exchange-RoutingPolicyChecked: V4JLDvzPtTWdaJf2iOGemIrB2lvVszRaUm6ujIzpGxKGbaBcgkeY/n8LO3JmwZH1Z+UZgAEzyeA6F/Gz3hzF//L0kQJPQhvNqWrrZ288eYgTeEf82e0Vahy7HfWruASOvw48sdOLImRzuFjz3w7gTeMkv+m+kdWl7oIPhLTvdPfsbJM4EIYiecuG6QUM2/EvmcemF7fg/Gz3PG/g68P80LS8TfuqZTa25medQUTT8u6+yt73HC21Nvvf/YPUYez+/3QWNMVPLuXo0oUfd96YWnHjgE1VajYYtCyALNMJRyv72ZvN8r84kCMbzZg8Mhqv6Jw4ir1Z6JLVnmEZj7kcmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4dad9c-dc5a-4b01-f594-08df13e31649
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:10:16.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9u7ZPTNjyKLaUkmLA7oFwUthu0tO/GlQftu1oIFu//ZgqRnqqK8T+n0KjqPv8S9tTd68MkKymAbUxacVVRfc1937xvVPwwhx8Dn8lebLPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6465
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

On 9/15/2026 5:25 PM, David Marchand wrote:
> On Thu, 10 Sept 2026 at 14:54, Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>>
>> Currently, VFIO cleanup only unregisters multiprocess callback, but does
>> not destroy containers, groups, and user mem maps. Do all of that on VFIO
>> cleanup. In order to distinguish between config that is not initialized vs.
>> config that has been initialized but happens to have fd == 0, move the
>> global VFIO enabled flag out of the config, and add a separate per-config
>> "enabled" flag that can be checked to avoid attempting to clean up configs
>> that were never initialized in the first place.
>>
>> While we're at it, also harden the API against repeated initialization and
>> attempts at using the API without having VFIO initialized.
> 
> - At this point of the series, I don't see the need for this change.
> The default config vfio_enabled should be set to 0 and could serve the
> same purpose?

It is not necessary to do it in this specific patch, I just thought to 
add it because having a proper rte_vfio_cleanup() implies some more 
rigor than just releasing the multiprocess state. We can move it till 
later, although it would require rebase work.

> 
> - Should we reset vfio_enabled in rte_vfio_cleanup()?

Yes, we should.

> 
>> @@ -2218,9 +2296,72 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
>>          return container_dma_unmap(vfio_cfg, vaddr, iova, len);
>>   }
>>
>> +static void
>> +vfio_cleanup_config(struct vfio_config *vfio_cfg)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
>> +               struct vfio_group *group = &vfio_cfg->vfio_groups[i];
>> +
>> +               if (group->group_num == -1)
>> +                       continue;
>> +               if (group->devices != 0) {
>> +                       EAL_LOG(ERR, "Cannot cleanup VFIO group %d with %d devices",
>> +                               group->group_num, group->devices);
>> +                       return;
> 
> Why stop?
> Should we continue for other groups?

It wouldn't really matter as cleanup would fail anyway and there's 
nothing we can do about it if we couldn't close all groups. So, tomato, 
tomato. We can, of course, continue here, and cleanup all groups that we 
can.


-- 
Thanks,
Anatoly
