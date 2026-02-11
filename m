Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF5EA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:28:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28930402AB;
	Wed, 11 Feb 2026 16:28:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C001840297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770823733; x=1802359733;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=GxsXDFvxeas1xBTIQt0aBsgHvDnkaFXtg5F0CWVyFjc=;
 b=idH4KyACC/yrzzP57XWEirsKvyRbia/CuYSpH109ShuDfaU/Avcsx+jT
 qXnlQ4k4+AuFEl+Ft7Ry8imbraT5U0mcmisHhFASKQKHTghIqxhrksjsd
 JmFXbU1eVxOfE3jUYu6kKaH9fH7j4L4kwnDzjkZqlPRuFAVOPu9gNa3RO
 JxVsOH0lZWyqz7fCV98RQdkNKwRMoYwLAjuWibo2J4zK/27KFfD60iNm2
 IQz7ZihMMoSi3GNlB2P6mJO0fpQh8dM9Uq6NX7Jbs47uqMxaER2idaEcT
 6gJ+vBYvl4NJnRrVkq70krR4dpiYPxIqglecQZI5LCysBYXtaryk+j5B7 w==;
X-CSE-ConnectionGUID: Jz6qd1xWQLyKMRhC+hyQrQ==
X-CSE-MsgGUID: 3HWbW/60RtyCrbvtv2Bqbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75816794"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75816794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:28:52 -0800
X-CSE-ConnectionGUID: mbXEDQ8YS/q2/bMnWuP88w==
X-CSE-MsgGUID: 7C56J2q9T+GypWOMLjdsxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216552369"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:28:52 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:28:51 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:28:51 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfIGoKxjqEz/8gE8DxhBNLZ4uZck6gRxHlSv9+cyGdIfGbAvPCUHzfsf9wqlGTG6Y3+FgH0qrG5IIhKVRirzBRpyKTUAGs6zpQ4pngpTBk9gTo1QKwpgt9iAEn89KqaXsYJqp09aVIkLReCF9+FkaDpgZALYP+4kJFTMkko087HdFVXQeTI6iDi6YLJBMA0lrP/QDBs7UcDfjcxousry5BIGWRIKw2fSY3Muj2hw2ZnWI6/TEzb8QEwYj4apm2cmCFgYKeOvYJpFwxplko+njZNcd4YvrBgu2GziohUqp50wWhWplVuK6jtA1psRuSDqcjCU0ckTW/Php1Wg8zbDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK/APAz7sw7rucIPk9KDgYWBd9XWWfDkj0Yi0q84y/E=;
 b=Aoa5ly967tPdaRQMj9nLXb45mtsWiauL2urzBYe/0XYYBcMIHqzdSFujO2LJbEfcwCShqCXbE3nqD/KD9iKE9i2WjPVGX9oXUKnzA/j38zTv/vMOjuzQHXIut4uXpN69D/uoMpQRV/sjy2INLD0/TfPCgCFGKAvkGqPl/Hzlc/9L1oF4Ti43PUBmc7xXfvWau09Iuyn8xAbfdcBUJW8rElJYb+i7+IoKgCeuzGJimwCGhzVj/G3uJj1l7qAZR7ZF88TPqdS65LgW4aaq9z5kPg55iY7QSC5uwTnYNQSlJbgdgcFdxwzn9VJe20Ln24wXq2KiIF/xGQKwium1IvSdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 15:28:49 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:28:49 +0000
Message-ID: <d1373420-e064-41c2-9dc3-16b5c8aa4f32@intel.com>
Date: Wed, 11 Feb 2026 15:28:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] net/ixgbe: fix memory leak in security flows
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Declan
 Doherty" <declan.doherty@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
References: <27473234ede7bb1551ad61cd69e3ed34f120fed7.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <27473234ede7bb1551ad61cd69e3ed34f120fed7.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cd0a35-2e2b-4b03-401c-08de698240db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1NjOUlOdFlnNk9QQ1JxaXJybFVRZmZZZ3JMZUZ2dFZwUERUVms0QVp0cFk1?=
 =?utf-8?B?WXR4L05id2lNYndIUFUrZVZWRVZIN0ZWcWZZWHhUSVl3bW5ydXVlWE9ET1ow?=
 =?utf-8?B?R3VMcDlCZmVNM0RBZTBYYXZvNzV5dzNORlBEVTVkSHVkWTNNSnB3K01ndklO?=
 =?utf-8?B?ZnMrMG0xNzNoQXBvRHp0T0FMQ0N1d2hBeG9wRXB4Z2gycTRvOS9PV1Y5UmM4?=
 =?utf-8?B?ZHFSTEt0UzBpdlRJS01OdWtTQ2lNQzJBRW5WcWkxYUluN1BCc2phVC9SNDFO?=
 =?utf-8?B?UE16czU2ZGNHbnc4OC9XeVpJRWNTZnZKblUzcnJRVUNtaWV5MmYyRjh6UVMy?=
 =?utf-8?B?c2xPdXRlZUp0RG1hSEZNZTNRRStaaFNzQk1ZRXNxbEtERUNCNFV4YWdiTGlE?=
 =?utf-8?B?T21IT3c0b1NPRmpkM3hkdUQxWVBISkxPNENMMTMzdjJ0S3FRMzErWGpIWEpw?=
 =?utf-8?B?NTNyWThzUHJoV2s3SEVVNTFkT05kdjlkeGZRWGl3enhKejZPVHQySG96LzEr?=
 =?utf-8?B?R01Hbm5SRU4rN2VvNHNleXMvRDdRcWwwUmJ5cGN6emQzK01EdXdzaDdhaHo1?=
 =?utf-8?B?Y28yejVaZXhOMlViR1lndk96aXpnWDhZL2JJQVZ6QVNic0FpOTBuNkhCMlJp?=
 =?utf-8?B?UzJ2VEVYTXA1bXhLaDErL0lCTnhKME1wbC9xNGNwVC9xSUxRL3Z1cENlMFdD?=
 =?utf-8?B?OUpGSW5DeEhWazR1ZU83Y1hEaDRVYVJjRHZzMTFxcTVyRXE5bG5FbDhYeENl?=
 =?utf-8?B?dlhXRjRMME5JNFR3OUdhUVkrbC9VZlBNeS9DR2FLbXZKREp3YVFBSktmdjhE?=
 =?utf-8?B?eEovS3pJTEFyYXprV0p6VE9tM1RkNnI0QjVDSDJCWHc5WHQ1SmpBOUc4b3pV?=
 =?utf-8?B?bkdrNk9CdXUwcVE0WXIxeEV0cTJoSzAyUXhnZng0R3FuT2l3QVU5TFYvMFZ6?=
 =?utf-8?B?VnFMWlNqSTkyWGZzS2c1WjE4ZXJZaW1JOExUTjAydm9OSlJ1NHNHU1JjdTli?=
 =?utf-8?B?ZzlXclRUK3VMc0N1cVJyejVhYnVxZmZWRDZHSmcwSmxPc0hMZ1FYQUwrN0dD?=
 =?utf-8?B?c1RxdXI2S0tEdDVETktUWmUzbzNHVC9ESXBZWGJ1TWJOR1k3RjNJSHhrWldu?=
 =?utf-8?B?dG5uMytWNXhHQlJzNU13c0pkcldTWUI3OHgwQjBKTVhXaGpwWm53STlZMTdu?=
 =?utf-8?B?SnRuckRUZWpYbi8wMDFCV2o4RmtaUGJ1R2VKZkZwQTZOdnd3TVBKTW81dldp?=
 =?utf-8?B?Z1V6dkx2WGhDY1F4V1EwM3o1aEFwWm5FWnhtMEpXeGxKS0I3SXhSMjhGelQ2?=
 =?utf-8?B?djFPWW54RmhVOHo1VmVEK1c1Um9ZNDFNQ2Q0RUNpUVFPaW1OWU93NFlEUWd1?=
 =?utf-8?B?dko4c1NNemc2TnhpVTVHa2tsb0x3eTVZL3ZQSjVkREdDNFhabTNYajFQUGZo?=
 =?utf-8?B?TTQ0eGcwSkhBdHlGamtOa3pmZzNCVXpIS2FFcGdGYUllbURYQ3NUYjVLL09N?=
 =?utf-8?B?Sy9wOTNObTE2SmpuNkJwNlJkdEoxT0FjOEFWRVppeE1FWGgrT09JQjZ6Zkww?=
 =?utf-8?B?UW83clR2K3Uxa2FxM2RCdVl1SmZKRjIyVWhBRU5Ld2I0bW92TUtKR0RZK2ta?=
 =?utf-8?B?ZmpOc2xiemJESzNZV29MU1IxMkV0RWVkYnR6U0RZSXVQZU9iWUlUbXlkcFhX?=
 =?utf-8?B?bjV3amtpNkpud1VvVVFGbDloZ1ErVW1HbWIrYXM0RUZ1NkI2dEg5Z2pKTVc3?=
 =?utf-8?B?RkhhUnRjTmczZ1BRMDg5aVRqMEgwSkVGZzNtU0I1YVNySTR2M2h4ODlmSHp3?=
 =?utf-8?B?b0J6aUhtRjhlcmREWERRYkNRSnV6NWZ6Mlp4bWRubkI1bm1IditEUGE5a242?=
 =?utf-8?B?Y0wweEVscXJ0Skw4T2tid1ZTaFpwdksyVzZqcStWNjlGRFpGUVlpVzFTR21r?=
 =?utf-8?B?ek5ub3luai9oU3ZQeTFSZ2diYUlUbmVMZExBM2N4VjFnc0IyS2pFSVhUOVBm?=
 =?utf-8?B?VHR3emxrRWFVNUtDNFM1d3RxTk0vbTlKcDlPZUJ2Wk0weWFDYXB4SDFXODVm?=
 =?utf-8?B?alFTUU5teTkyV3MwdUlISWViU0pibStETDBaS2xnVW84dkFPcG1Ta250aWRa?=
 =?utf-8?Q?MA0k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JOdmN6L3BBVU1LdVR0UUY4SEJXZTllckFPSWJkSm1sUklkTnlkdFJvVUZy?=
 =?utf-8?B?dURYR3JNQ0xiRWtXaFFvZHZDZFpobjhJc21LTUN5VDhMajhBcXU5Q0NtZHJ1?=
 =?utf-8?B?cXE4YURUdnloRk1WaWxOTUpEL3JPT0RSdGl2YWNmbHRBcUR0WHdVcU9NZVZu?=
 =?utf-8?B?cTJzb0JQMEVscGptakdEYUhTT0U1S3dqeCt1ODdoWHlHNVZqcnB3MjBmdGZa?=
 =?utf-8?B?NytGSmR6c3RSemVDMHRwRzY4aXFXMEVLWGFrS2lNNjBEM2M1cUVYQTVsUDFw?=
 =?utf-8?B?OU9hM3drZGQvT3RTRys0YzhldVJqeFNSUGxCdDdBcEtZOVZYQkxmWGI1UnF2?=
 =?utf-8?B?MkR1OElSZTNOd255QWNXMHZJQ2R2NUZsN2xhd3lDWXdLQ3ZJd2RENkx2QnNE?=
 =?utf-8?B?WHpQbU45aWs0YTc4ZHV5MGM1ZGZkdHpyYWQzcnVOZHFObDlGWHBKUk45NFpi?=
 =?utf-8?B?c0czL0c3Vy90OXJWMHJtL3hjaTQ1QzA4VnJOS1YvUjRWMGd5cStKZ0RUYXpP?=
 =?utf-8?B?VlhmTzAyZ2FmUHVsbGk3QktjVUwzYjM4bit1NnNUdWJOYXc5MWZ6YWFGdnE0?=
 =?utf-8?B?UWRCOHdFbFJMd2ovYUpyVXlhbkNkK0huSFlEOHd4bzU4RnJsUW10M3hQRmIw?=
 =?utf-8?B?Q0wxMXQ2Qm5jcmlJYy92cU5Zc245TVlLaWIvRUt1Q1lQUVo0RnNXVXNoWnBw?=
 =?utf-8?B?eS92aDhlaFFWd25IUmdaOFc4SDlHR0d2QVRlMFRpdFJFLzRMTGNIYWJJRjdu?=
 =?utf-8?B?ZzBjYXJqeUtzYmZJS3ZPV2Nsek1DOXRVS3o5N2RzK2VtMFJnQWpkS2dqVVBM?=
 =?utf-8?B?RFYxamJBNmN1VER0WndHRU1VZWd2amFZMUVhT0t0Ykk1SEtKQ1JxZTFLbUlT?=
 =?utf-8?B?VGRwOC9vcTJ5aW1XdHIrWlVQTjc5UUpXY1Z0YkRKZVZRWUlvRmtrR1pYc0Rh?=
 =?utf-8?B?Z2w0RkRWQWhPNVpPSEJMZVM2dk5XdG92dDlKWjNUOTNiZjJpdlBuM3F2N1U0?=
 =?utf-8?B?amxKY2pDS0lVK1kzNTE1M0pVZkxNU1NOMTV5TkdEWU8vM0kwbjdxNm1TMUE5?=
 =?utf-8?B?QUpJeXh4SEZYakF2MDIwQS9hOERLYTlVY21WMU9pbkZJQ0pCNkdPMUthM0NC?=
 =?utf-8?B?MjhlTER3a1o2TFNkR21NRzlhM3d4dlFQWXZUT25IbktQd0pveVRwaXZ6UHNM?=
 =?utf-8?B?djNKNWl5QmMxNTIvOGcrVXRFMWdDKytDd1ljeG5ubjhkU3pxcVozUUtuZmta?=
 =?utf-8?B?T2IwdDVPNnY5OUNBeDYyblJMNHpiUmFYMks2WG9WTnNFQUM4QlphaDFqVjR0?=
 =?utf-8?B?enZPSzlNMVVPbFVQWHNEQ1VGSkFSS21aby9BaUhzYjlDbEMvb0JMaG1aQ2Fa?=
 =?utf-8?B?dDZLU1Z6RUpwcmM1d01IemZTU2NuTkpjUGJIcVVpZlJBMkpaV3U5cnU2Nk1h?=
 =?utf-8?B?U1pDL1ZTZUdmWDU4U3k5b1IwRkJVSVM0bjd3ZzRvaFF0aWRLRlA0VCtDMlRt?=
 =?utf-8?B?TnNVYWxrWEpBTlQvdmozZWVjM3dEWTFsRlZnYkxNZFVVYjYyZkFKYXZzQlgy?=
 =?utf-8?B?SENxcTlNb3g3T1dGLytoV2dKVjVBVTBZZVVXRnRtTDlGTWNUSitPZ0xNUXAv?=
 =?utf-8?B?c0NibWQxZy84RGdaQTZyVU5RVEcxYnVzcjVXdll3UWJIbDRhUDZXUXVnTmp5?=
 =?utf-8?B?Zk5jNW94ckNkS1hqY3RJV2dGYWJQUUwwb3FNZ0dvQURUMmtNVnhUOWthSFhM?=
 =?utf-8?B?S3d3ZFBYT0xXSHA3NUF4bWllUmFpaTZlWFcxS0xZQVI5RDNRaXIzN1BhSUJj?=
 =?utf-8?B?YlhFdDJma2tzbmpCaGpzTjRsU09jc0V6cUlRVXNLaG1jNXRQYXE0S0lVZjd5?=
 =?utf-8?B?eWhLYzJTUVVvVDl4MU8xa3FnUXFhbXc2RXFrdHRnQmFnRm4ydUw3aHlxRzgx?=
 =?utf-8?B?Zll1S0l2bVFKOHJxeVNtNEp1OVo0V3pBQnBhZlVJNEVXaWRnYTNjZ043MG8x?=
 =?utf-8?B?aHpWUm8rZW9sZnM2eXNPcXRpMUNjbjBmQzJDeS9iZzB4TFA4ZXFFZVJ2MVp1?=
 =?utf-8?B?KzNGL1I3UWs4akZjSXlEN2I4T21IdmdCdUZUam9NNVpDbXByNXlzdnVmTGFs?=
 =?utf-8?B?NDcwUWpxSFgxRHloWEEza1J2N1RiVTk3QkdObTJEWUJoQ2sxNkJEVFhtL08r?=
 =?utf-8?B?OXpvRGh0ejlyTnRzZXZaMmdFZk55UDRJbVR4Uis2TDY4SlVGaFN3MFp5NTB4?=
 =?utf-8?B?dXRkUjB3cDZ4cDRpZDBWLzBybERDL3ZjTm1BS2FSSmR4VXl5dkFXSjVoQkZZ?=
 =?utf-8?B?SStOMDFsUnhOekpkUzVhR1FyZW5IbS84aExaL0Nib21mb0M5WU02OWFYQjM4?=
 =?utf-8?Q?1XLQ978nuPtee1rw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cd0a35-2e2b-4b03-401c-08de698240db
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:28:48.9752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwasxqauD2iRs0Ix/9M2QIr9YMJhISMifssEsVtT+lP1fRGzmItybVtiYwgwYbzRguQfoZnooPzI12geunvR19cagr56gwZ+69QQ7Szfxs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
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


On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> Currently, security flows are implemented as a special case and do not go
> through the normal flow create/destroy infrastructure. However, because of
> that, it is impossible to destroy such flows once created. Fix it by adding
> a flag to rte_flow indicating that it is a security flow, so that it can be
> destroyed later.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 ++
>   drivers/net/intel/ixgbe/ixgbe_flow.c   | 11 ++++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index 5393c81363..5dbd659941 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -359,6 +359,8 @@ struct ixgbe_l2_tn_info {
>   
>   struct rte_flow {
>   	enum rte_filter_type filter_type;
> +	/* security flows are not rte_filter_type */
> +	bool is_security;
>   	void *rule;
>   };
>   
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 27d2ba1132..066a69eb12 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -3062,8 +3062,10 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>   
>   #ifdef RTE_LIB_SECURITY
>   	/* ESP flow not really a flow*/
> -	if (ntuple_filter.proto == IPPROTO_ESP)
> +	if (ntuple_filter.proto == IPPROTO_ESP) {
> +		flow->is_security = true;
>   		return flow;

here previous call ixgbe_parse_ntuple_filter() may return an error even 
if ntuple_filter.proto is IPPROTO_ESP.

 From cons_parse_ntuple_filter():

         filter->proto = IPPROTO_ESP;
         return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
                     item->type == RTE_FLOW_ITEM_TYPE_IPV6);

ixgbe_crypto_add_ingress_sa_from_flow() may fail.


> +	}
>   #endif
>   
>   	if (!ret) {
> @@ -3350,6 +3352,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>   		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
>   	struct ixgbe_rss_conf_ele *rss_filter_ptr;
>   
> +	/* Special case for SECURITY flows */
> +	if (flow->is_security) {
> +		ret = 0;
> +		goto free;
> +	}
> +
>   	switch (filter_type) {
>   	case RTE_ETH_FILTER_NTUPLE:
>   		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
> @@ -3442,6 +3450,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>   		return ret;
>   	}
>   
> +free:
>   	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
>   		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
>   			TAILQ_REMOVE(&ixgbe_flow_list,

-- 
Regards,
Vladimir

