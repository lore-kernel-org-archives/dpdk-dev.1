Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8153E9E311
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 305DE402AB;
	Wed, 11 Feb 2026 16:41:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 88C2A40297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770824502; x=1802360502;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=HZe+OZCwiDXOBdu6Ljo9SUkKBWx0Ev/Fy5XujFbfxMo=;
 b=lxAU4YyQps2lu2DQWSPcPGbtlViGa0fcC7xcKWtT9vBqyzhNOtPmf621
 +dRc3BijJvh5Tr4HrUuK1j5yn3V+N4UxtriadyKVvh7R9AJ+30z6E+WMQ
 LXe/7mjT/oZPsTDpoqdLnIpSAdkocVTx0MfUWAwXV1GmRHk2/wSFudU+e
 uX4uXdwOr8SNSNu5AN9D5jxMNJxDbz24+RemvOQV31K7GGx+FVCocwm2W
 bDuX9nGadPSC53B+FENx0xaHH9UIJui84r+EguXb5aWPAwpB+yrpz/cFc
 53rqxbgQ2s8hbjqPEQfLXTbsFDLK0/jKjUNolYBWrnNkoBwJkjN+JHC27 Q==;
X-CSE-ConnectionGUID: 6le7fMBhSv69e5GovFfdjQ==
X-CSE-MsgGUID: rjriwXS9SAWf2nu/PfewCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89565739"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="89565739"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:41:41 -0800
X-CSE-ConnectionGUID: Ko2FySWtQCKzGF+y+vlwWw==
X-CSE-MsgGUID: F5VYi9zoT2uy5UE7fY0MxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="211392482"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:41:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:41:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:41:03 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:40:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhzDv+MudGsD4fDdcgG137CurCsr7rnkme1wZ6+UNlTQnq6ojT+E+8uWHZ47HscBXVcI2974vMhTohRSDFIjdcpb/ek/SjUaZf/HIg8yAuOVN8TtpS9hDzHU41tSlQlEDmvjjkToccpHUmqhMcWkSM+NrMRNAKhyJgONF5LuyVRCdE71PvCEjGViGtjp14mlVPXxqe2mtXOWxLElv94tAg3cJkoq4Elp7GOBmOdZjhFGr/6tMLgxeLNXrwvalwpaO+CQVgIUYafmHqsjUI4K7vTV2q+HHVtHb4aEQUdX//Gr4aY7z6QZDmopGJKpmq6JSu95fX5mzPJExZjeo0irNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P4K8Qb97wAGBL78FFiqsXf1mRU0krutgxEpd+z/EnA=;
 b=tRbnw7NQcb15e5aStx6QSKeTV0K19Zxpwai8TKTB8eTMs7Co1DQcQpuOBA1n4P6Lk80ksZq0o+zLHB01E5yKTBkTy/itgRWWTAdPxaROxavMfqosIRZXgDQR2tsxgExQQFuCU/wPRbOVMR+FDdzh974XZg2/sW75YNNo0DhVaaT6Z0XK8reE6klog1L111fm6PSfS9a0iMVZkwfobQ5J95yoRkP3TtSKNav9wlS5mmnau1B6/CU+dZFyo4ye/G1V3Iaj+IkIKf7RmBMtGEm4WrhH1DuXWKXSSZXEHJvgbFHCHMUbPA6BaymPmFkKvsCKl66qS+S8r9qnWjRyzdhruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB5011.namprd11.prod.outlook.com (2603:10b6:303:6d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:40:40 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:40:39 +0000
Message-ID: <37733677-c0a7-46e1-9206-4e4b4987cd2b@intel.com>
Date: Wed, 11 Feb 2026 15:40:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] net/i40e: fix IPv6 GTPU handling
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Beilei Xing <beilei.xing@intel.com>
References: <00449319c555c67c6571547d2a46edb1634d3151.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <00449319c555c67c6571547d2a46edb1634d3151.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::16) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fd16fe-cea3-4249-7d24-08de6983e887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnZTUWdrRVNpU3FEekRJakNmTFZXblRhRkFWeUtZUW9hc0ZHWWgrYWdTWmxq?=
 =?utf-8?B?Q0g0Qis1dUZUWU1hUjZWT2NKTi9zSFd3VXpudkc5UHIwbHBEeVdaSkoxTC9H?=
 =?utf-8?B?YXpia1ZIOGVLOTFxVjFrUWI2RFpPSWVjMGxyOVVuSkNBVWNhRmMyQk1mbjVs?=
 =?utf-8?B?Sm9QVC9seXlGTHEvMkVZOUtuTTRwb3lXd3VmdVdMWHFKM2gwWFFhQmlNcWdC?=
 =?utf-8?B?bmJWYlBydWQyZGpmM0YrbFh1M0JwdnViOVZUNnIxSHlrSkpSazMwb25hNk1P?=
 =?utf-8?B?K3R5d0Zha0lQZHA0K3JqNlpHekNwWnI4b0FhRFEzVW9ETTlUNkMzK1BkOEJh?=
 =?utf-8?B?ODVBRTZYT3dwaHJWOURqV2cvcm1tdk5xQVhGTW1PQWs2c2d3WVJrQ28zOC9P?=
 =?utf-8?B?aXFtTEoxekhlV1pwV1BGaEtnb3pWc1VmZ04xQ2N1UXVqVVJ2NmNZWnIyV2d6?=
 =?utf-8?B?VVcyTmJvendIN3BCK1ZobUpjbE5tT0Q3ak55TTFEeWw4dUN6ZTFLTFR2Q2VD?=
 =?utf-8?B?UElwQ0tqV2N1UytEVVNCZnRid1U3MTRJdFVTaTIvbVdxdGdENE9ia2NaRm1B?=
 =?utf-8?B?SVk4OVRnT3FJdmhKUkdoaXRRQjgvTk5ldkpBbFJVeE9xc3ZDRElpUXpCeUF4?=
 =?utf-8?B?TjY5U1JEZzJOZ0sxV1d1dGpRV0FHTjY3d1NQNTRsUEk2Ri9MZFJFWUtmYkVP?=
 =?utf-8?B?Q2Q4M1lUVmEzYmlaZmZYV0ovN2h4cVhzb3RNc0ljelNwUXZMTEFBbzBYSDA2?=
 =?utf-8?B?WFpkMmhHYXg5bXFxWFFKaFBxb1Uxb2hLMnJZdzNoZXBVUWwzd2hjZHhhYVF1?=
 =?utf-8?B?WHRBRnd4alJ1Yy9WTjJ5M3ZVM2t5aDUzWUQ4MTdjVklGdEtBQmZoOE5mdmR2?=
 =?utf-8?B?UU1BMjI4YXJ4UGR3dTF1eHJ0MGFnRlMyTUdGVy9Vd1A2dWo3VTk3RWsrWko2?=
 =?utf-8?B?Zmt1SGw2WVBnbU5GSm9aVHlxUllMU1dKQ1dDWFc4eFNCbDRadFRXcmNwdExs?=
 =?utf-8?B?Z0xFaElveG4yWHN4WTBBK1l6L1I5YTdjUkc3RG5SZkRYbHFXM0l0WjJQNjBE?=
 =?utf-8?B?VS9uc2h5bGpXZC91dWYySDc5QmVlUGk0eDJUdk5xUVZnNWIrditHeHk3U3B5?=
 =?utf-8?B?MzJzdCtlWUN6TU1UZTU4eWx0S0R1YlJqcC9IMlIzbGVPT24rUVYyZmZOM3cx?=
 =?utf-8?B?WlBtZElMK3lVTUp1NTFsdU9EdWlCcWN0ZjMvb21oenJlSXdPSjFXUnZHSTc1?=
 =?utf-8?B?Qmg5QmYyS0tHL1U1TWhYNzF0SGlSK01WN3NoY00wZkZ5WmZENXh6cFgwY3hi?=
 =?utf-8?B?bnphTTVFWDVxbGFWVURhc2pxQUp3aXhObWlZUFFjZ0ZWYVRwVElhTTIvYXFj?=
 =?utf-8?B?dUFIMVU0NFVld1R2YndwUFBBcmFicENaQXJRSG5jbHZqSHJsVzV0R0ViTHlQ?=
 =?utf-8?B?Sko3bXJaODc0TGc0MGdNN21La01temdFd09HQ1JwQXArU0NGUGlvS3NGTjlr?=
 =?utf-8?B?Q25jZzYxL0JWalUvKzFNWlNyL0hQUGVLSGx3Q3M5VVBpZHB6TVd2ZVBmODRu?=
 =?utf-8?B?NTlSa0NRWnltWEpUM0VTNEU1NXBhRDZwZUZyRkI3LzNZalNjc21FSVhPdXFD?=
 =?utf-8?B?Y21NVXBvcW1wdW03OGVDaW9BY2xwSHpVd2o3UG54VWpvWFkrV0lEM0VhL1Ax?=
 =?utf-8?B?TU5nc1NlRmhxTW9xVGRTQTVoM1UvWG9XUUFZOExQQXQrQWdralExOTdUU3NI?=
 =?utf-8?B?TUtqZkRsUmh2Q0luMnhxSFRsaEh4OUVEekZ1QWpJeFZMcTdIZ1BXMjVURXJu?=
 =?utf-8?B?aWc5eThnd3VHYnVaSkFUV2NWUTEwNWh0ZnJ2VS8rZmtZNDAwTXh1TDFvZzlh?=
 =?utf-8?B?MkxFeXRMVTFyOEVBcVdQTWxZOStiU01iT2dZTFNxNkwvZmk3T2k5R25aL2Rq?=
 =?utf-8?B?Mkp0ejVUbGx1Y24vek1WTWJGZ0xnV3VwR1JuNkFxSkozZzczMkZsc3RZTUtv?=
 =?utf-8?B?ZFkzTlJGbExwUWhncUpJWjJnRS9FR1ZxQzRlVjhaa2NrcEhCcllxbXNycnQ5?=
 =?utf-8?B?bTd3QnJIekxJY1ozUkNTYy9PdUFodC9JTjRpamJ1Q05SL2R3OWpvSFJINjJo?=
 =?utf-8?Q?pekc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJwb2haM2ZpN3F3K3dPSVlOTkhnOVY1R3kwR3V5NGxXNktwL2JyQ29RVW4y?=
 =?utf-8?B?U2ttOUljZHNpV3dDTDAzaFhoaDBuN3hsS1lrYUNTc3BLczNoM08rTlJxaHY2?=
 =?utf-8?B?UDAzNndaVlNDb3FjTURBWkJrNmkxZkhYMkxsQXRlYU8xR2NaWFRzR1lGRUU4?=
 =?utf-8?B?SVphNkJndmtKV1Y3RzRyOTJ2MHJNKzdtR1IwMmtrd3J3ckJNUkE3RXluaWFx?=
 =?utf-8?B?YXI3MUNQUzNzL0UrRi9JRDUwRUNGcVNUZEpaRU44c0ZYNHZtOGVhR0xiTlh3?=
 =?utf-8?B?clU4elJlNUdUREhYVko5VldsN0NYZVRXOUZ1cHJUZmxVb0xXSkJyQzltVURx?=
 =?utf-8?B?dENCQnBKM3dRWHo1QTNNQ0F5cWM1dnF4aHQ4akwwZTV0MXNiVEZXb3kzUmNk?=
 =?utf-8?B?a2l5VXZnWE5hZS9uR0dHYmV0YnpnVnJkNEcvOWxhVDNMNzUzVzBMMXB6Q0JM?=
 =?utf-8?B?TE1ZRGhvN2c4emhBcU1NQXNvMzBWS0drOVRZTDE4R0hRdmdRbG5CY21UTWMx?=
 =?utf-8?B?K1RTY0o3NjhUYjFaM08wWFNSNjkzT1hJeTZWR0ZWT1YremJHWUhCcGNJNTJB?=
 =?utf-8?B?MkZqOGhSY29oVU5HY25ZN0I0cjFIMnVhN01mb1k1aG81NDlSdk9ONnZmdTFT?=
 =?utf-8?B?aG1TaFlMNG1zZXR1eG5ZblBJN1hKRlBucWkyd21xWkZCK0w5N29YZVhDbUlh?=
 =?utf-8?B?T1ZIN0J2ZkV2c1V6bmlLaWd4eDdCSXp1alpCb0ZhRGh3UlQ0cU9QNUg5ZXhk?=
 =?utf-8?B?cnArd3lLZW5ndVhmcEtpZGFiTC81V0J1Vnc1cDF2N04xWGM1aGJmWFBxRGxE?=
 =?utf-8?B?LzRER1lsS0ZQd1BtY291bGEvNVNuVWFEVGhOWVhiUE5WUDNUakRCQzZPbWN3?=
 =?utf-8?B?djlrQm15NWZzaU9TV1doVWRvbDZqYVVvWUVjSFVnYUtXTjgxcTdZOTZDcG9J?=
 =?utf-8?B?L0VNTTBmcnBDUnEvNXV4MTdGMmFMWXB0aG5rNURUU2tDSW1NRzN0SGNUOE1a?=
 =?utf-8?B?Q0NqcEI0NHJBQ3VySnRFc0RvYm9lYVM4aFVkUFg5Qm45V1pHN3RnVmlXMDIz?=
 =?utf-8?B?bllZdkkzdlMyUStIekpDT0tnMisyaVhKSCt3TGM1di9TMUxCM0ZyOC9RcklK?=
 =?utf-8?B?OVhXMkVnZGJqUmt6SXZ3d1RIV1NnY0d4ZURGcW0xVW1rTUxxbnRuNUkyY2NC?=
 =?utf-8?B?KzR2V0QwRmJzRzlXYkp6MmlFK1NIZ0tybVUwY1VydXNoMXpvaWtOYnRUUW9i?=
 =?utf-8?B?WjY3c0xWVkJYbURyOXFJdTZ4SmpRVjBtVTdUNmpTOTFCSDNFTXJpeEJDYkQ0?=
 =?utf-8?B?eVMraE9ncVE5WHdQZ2JWRUxnRmpnL081aWMwVEtKdTVoYU5tWkNUaUVEaDh0?=
 =?utf-8?B?cGx6dGZSa2ZXWU9xQWsrcnpmOEVOUGRhTDZoLzR0ZVJGM1ZXKy9QamFhZmpx?=
 =?utf-8?B?dUdzanFMMzU2NUsrN2lVeWdyZGhocDhHeWh4cTdIbFdnQVZYMG5FemtJUzJt?=
 =?utf-8?B?Nzg3d0tRdDdkd1ZGcTJwMkZ2aXJjTG1yWE5NWWxkQ3RBVUs0OW9XeCsxYVZL?=
 =?utf-8?B?SWtQbTJTMjcxTEVpSHdDWmdtK2VPcjFjcXUwa01OZ2JqWkIzNEFFcWhhdTNO?=
 =?utf-8?B?dnpBY0xhRGJKTlBuN1dXc2MrZFhRd0haSFFSZnh5TFFMSzdVV2cwR1lBT3ds?=
 =?utf-8?B?ekIwb1BtMnVFZFFDS09GbWhpU1ZyZjJFZDdTUFh3VjdvSEZTdW1zditYNWUx?=
 =?utf-8?B?ZW9RdnhCdGtYTERGKzlrcVJ5cEFNeDJkakdZQktvalhJbUxrR2FCK1lDejgr?=
 =?utf-8?B?ZWwxTm9qOEsxa3diSGtyQ0xqb0JtaFlmdmJoaGxQUG1zaVpqQW1YZmNiRFVh?=
 =?utf-8?B?L0VxQVl1dm5oZFZvc0JxeDEyOGdJOVFVS3NKTFpubVFWKysvbnFYQ2ZCQkMw?=
 =?utf-8?B?OEhDZmQxSmtKWUxWV3ZJUU1DTTNzelpjazBpRytxVmdnVTJNbU9DYlNnVlBh?=
 =?utf-8?B?aTYyK1lLVm9ubmo5TUdyYmduRGZwdHZqNHRiOEpXQ1dIZ0ZrbzZlYmxuKzlu?=
 =?utf-8?B?SDJId240OE5rTlp6WG1jQThJNEpWL2ZEaGJ2aUU1OHY3ZDJ1ay9xczd1Rmw4?=
 =?utf-8?B?VEJYMlRqOEdkNnBuUWJGaUIzSGJTVkNQYnBFc3RhZG02blVmL09IU1BNUksv?=
 =?utf-8?B?eERnbCthbk5MMFZFTjdYUEFUSlMxTUNmTGc3a0NCM01jSzk5QjB4M3ArL0kv?=
 =?utf-8?B?cEt5RVBXKzlxWnB6NWdTSWpSZGhUT1ZDMmNSSFRZNjdhR05NMUxXQjVhNjhT?=
 =?utf-8?B?UXpRM3ZrQStJR21IWWJSRllBOE9SM1l6U0VHczJVbFByYTBiN0xpdnJHUlhJ?=
 =?utf-8?Q?dRL2y6VgIAJYoV5k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd16fe-cea3-4249-7d24-08de6983e887
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:40:39.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqcvMEc1If0SnvjuPfmcyRk/r9hGtxuNfjfgw7Y+oV3x0b9rRruF/1YP6f5NM5kr4IXfwYKe8H183eL+yruRn4haOPI7XD1tjwshizfLpSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5011
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> GTP tunnel code declares support for IPv6 GTPU flows but does not actually
> handle IPv6 flow pattern item, resulting in incorrect parsing for IPv6
> GTPU flows. Add IPv6 flow item handling.
>
> Fixes: 47ba0398da3f ("net/i40e: add cloud filter parsing function for GTP")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_flow.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
> index 193b1b6725..2374b9bbca 100644
> --- a/drivers/net/intel/i40e/i40e_flow.c
> +++ b/drivers/net/intel/i40e/i40e_flow.c
> @@ -3580,6 +3580,19 @@ i40e_flow_parse_gtp_pattern(struct rte_eth_dev *dev,
>   				return -rte_errno;
>   			}
>   			break;
> +		case RTE_FLOW_ITEM_TYPE_IPV6:
> +			filter->ip_type = I40E_TUNNEL_IPTYPE_IPV6;
> +			/* IPv6 is used to describe protocol,
> +			 * spec and mask should be NULL.
> +			 */
> +			if (item->spec || item->mask) {
> +				rte_flow_error_set(error, EINVAL,
> +						   RTE_FLOW_ERROR_TYPE_ITEM,
> +						   item,
> +						   "Invalid IPv6 item");
> +				return -rte_errno;
> +			}
> +			break;
>   		case RTE_FLOW_ITEM_TYPE_UDP:
>   			if (item->spec || item->mask) {
>   				rte_flow_error_set(error, EINVAL,

-- 
Regards,
Vladimir

