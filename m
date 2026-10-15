Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6FECC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2543F400EF;
	Thu, 15 Oct 2026 12:41:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 73F6740041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792060888; x=1823596888;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y+FrPVzNOZPTzBgrjyum0lOfG+Q4p7b2PzROvH748BM=;
 b=jxZS5xbNLKK2/We6BNiYHeS/Drt9rZ5AYCBlxfCflJXZAdJcwSdliKij
 P6vCDW8nw05qshPcn4A3qt30i0tI7TkfBMBx/Jf8uz5jPLZ7HEHsHuZPS
 9YzInbZWgNxUrt2AfVEHOc6J1GAeA36VV2iOg5q7xhbhWMsommz7GAO4E
 Yjt2ntjs2yg21xVD89scWXefkxpYTUT9t6xub7ETRpKHuoDhh3FeCDwFQ
 OoZsdje0ElG9sC7iMqax88jJq4bRmfaZIA+0HGjz7xPMo/PwU6XlDXzit
 iype+pN72JTblgo09mm9xed7TFPujQpnkX+Z67AuhY4fszp/pySrSByuT g==;
X-CSE-ConnectionGUID: V9nBW6QoST+XZ2KB9ijU7A==
X-CSE-MsgGUID: JdvGeuVJTnO2gKuReeMwzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="714168"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="714168"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:41:27 -0700
X-CSE-ConnectionGUID: RuAjdR9STO21NptrRUE84g==
X-CSE-MsgGUID: rKFnDhUqSpKHhuYAaJsuLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1999168"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:41:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:41:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:41:27 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:41:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2aatl6tPFvCPQVTTttmYjkn2Vc5d6XsXotHuuU8inJW6vMi6OJ1DAvx9YYgzvJtD05NVo5l4zXFHq+qDqGV9rfOwJ+3rGD4g1NQqVNA6CVfdKo27GYRQwfzEaPSgzVfCBuM6f3V54lFpwL/aIxfpPO6zLoAE3BdGzbq4jJM0uHXIKRwhT3wfEak/CEZU4qX3X6o5zIq3S727lHb27Ez8Bv0cUO5h92ol5koAZ0OVBzQ0V8NUPOLWsr4RMFnj3wjymOQlA1JAyyqIYJqqxyJGWTJgQtalPlgwgw5rJdcEm1izrTG1tgDHex6ra3x5L57YgcFgiQxyg36YC85YIB2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlUtV/CF2GJSC4kXaFThJiBRwmLJfR7gDgXPXV66uuM=;
 b=HE2xGC5XeRJ6OjPuM2w02VH3BYYRykX0m+DZx6Ao6Q7ol/v6e/NnWkIMqOdzKQpm55d5RvENF+qkClNXmzqYv757dcZhYuGFZk+vUM9+yisj2BQfbU636FF0mF2eU3vJWuKY8Snu74tcBDovefBirSGmH2nF1mWhYI/3E5hwbkEr9ZpmtOVFRyZpGGPBRFlMSYucZFpWyG9ueF36TWbP6vnXqsQl2aKe9cFLkckqV0mI348QTSvP1YnUvHUDBuAGTqQrRdH6ahnXWPwV+sBuip9xqAXaU/DEVWOzXsIXQIP1MKbgwGwOXS9lDAtTusSnjjQCe0ke58Se5KGYAlmfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH9PR11MB931975.namprd11.prod.outlook.com (2603:10b6:610:33b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:41:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 10:41:18 +0000
Message-ID: <fe35faf8-fad1-4977-8272-bdf6f1896825@intel.com>
Date: Thu, 15 Oct 2026 12:41:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
 <Q5JnIR46RbOi5z8Dxhadxw@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <Q5JnIR46RbOi5z8Dxhadxw@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0018.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::23) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH9PR11MB931975:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b384552-9c76-4411-62aa-08df2aa8d865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Kw+O4OAjUOYGGk8WjMT808c4/OZOKLVKFaBOXveGdJbxxXr6oD+8wjcbRMguqS+1RDAAGTEFEhsaE59t0VlAs5UMgs/VMHGbmXGVyOSukL3X+XbGGfxacqsmuuQAuyHSgNE/FSPVM5pGgjeUkjvFoVLZGU93KadBt6DcFwwfd1f5dcyU6lPjg7I8Uf8bYgoQ2T3EcGKQGTCj/wImACzvqZnJ2Cmo802rgRg0zdEkoNnLE7N09lJUbLdS9rTBWGV5Fi+KceQK2+zcCuPC9Es4qPajK1jEFgmpf/d69xxlf/DeZkT6UX0pEoG4RTxf2ZtsvuJdQjUxHhcajo7oEUuQaRWp+QJs1NnF9D4h8EgzmxEUeBdRmhgspDzw/+JB0TATbW0nK/RjjrFchm1gcRW5Wcwh+vOfPplS+AkQ6mmaoDPLtaC+uJ9huCsj/2ulFKCQNxWV+JXXOzaeUKRUeFBe6EIEdcF6k/iITZM6TF7OMOVfFFR8z0Cp1u8gMvFDdBqEbK7dLzVlbCJpNNwlHibkRnqyiBHYAOLQsZbENCBET+V9gSAbOIeJrMSJT0OIK1eikGRrzAl8796jR4FTWJ2g2sZUezUupdJyN5by0v6IobaSuc59FU8YV5Cl/lwPkSBbv0p8TyShi1i5Q1erEhylqayf/sS2xcNgblXL+fYHthA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVZTXZseVRFZ1NMNVNOc0Npb0I3QmZ3Z3E4RVBKN3IyUTd6OUcwTWVHeVZr?=
 =?utf-8?B?QUl6bDFEVmRDMmt5ZWl0RUtrcmkxSk5pWkw1VFd5Smt4MVlLcG1VTi9VNk9O?=
 =?utf-8?B?Mlo2ZXk5TWczVHp0d1lZZlBkMkZPcDE4SjZJRGE3V1lEUS92ZWxMOVFReEFH?=
 =?utf-8?B?RUdmM1dZaldyTldOQWprQ2xoVUZzbGUwTWtBaGhtME5tQ1RZV2xLWlNhL0Vx?=
 =?utf-8?B?V3U2dmFZVzc3cWZYUkhnR0tvNGRWSGZLTm03aUQ2cmxXV09LczcweTZjQnJr?=
 =?utf-8?B?SnFOR0hoSXJPTUtHdXNJQXJabGJjeUgycCtKbWc5YWVoR2hIU1NVcmlVNmxl?=
 =?utf-8?B?dGZCdURXMGdTUVlFc2tMT3VkVWdORkZrdytSSVpSQ1pHaVNhdTIrYzhhZmRt?=
 =?utf-8?B?Wmhjbnd4UEUrT3M3cnpoWkUyVGJuQzVBUkZaL0FOeTNwVGpucHhLcjZGZEpr?=
 =?utf-8?B?Q1pqQzc4Q3BOSUpIcjVDMHBQT0I0anE5czR3QkhQS1FPbEdwK0hlUGVoUWFm?=
 =?utf-8?B?enFJT3hvZ2V5WVNjdDNPVjJRWmhjbjJTb1hrR2xOL1o3RllYcGxTczJBM0x1?=
 =?utf-8?B?c3ZLeWtlM2M1QW5CR3djVXRIZnNFNVJnQkJOaWtnSnRBRDB5TE5pN1EvY2hD?=
 =?utf-8?B?K3pES09oVWNoOXdzK3FtMTFpYkZ5YWFIQllOc2o5K3BVdlE5cUFsWFJYT0FS?=
 =?utf-8?B?eHV6ZWZmelZYTmFpSk5FSHBqcDlKTjNQVlZwMVU2UTdDemc5eVp6Sjh1bnZT?=
 =?utf-8?B?OGxDYkZBQWwvK2Q0NWZENGdrbm5iWTBmRjFDdzRRZ2NpVDVEckViUzRUYlh1?=
 =?utf-8?B?MHZQV1dVbyt3RFE1QnFxQStmcHlaVHZudVpmVkROeGJiYnRuM2pMaHNJbi9h?=
 =?utf-8?B?WGZMQ00yakJ5K3FkdmQ5V1h0SUNqaEZYVzY3cVd6RG5Nbm5XUmlLcjQyekZx?=
 =?utf-8?B?QzRCTHlKaVdqczVHSFduQTMxQWpNTUN2UFZaalhZdjhNS0prWHB6T3JkckJp?=
 =?utf-8?B?cXhVOWRxaEpoaXg3ZVdlMHQ2Zy9XWVFGdlB5NVZ5Nk90ZEovdGhYdzZEeE5z?=
 =?utf-8?B?K2pkY01LQ0tRcWtKenhlYWhGU1dRZTNWZzRncU9XS0lIMzA5QWxWVExXRjZD?=
 =?utf-8?B?TjdwdXhIVGQrcUNZQU9WRGl6OURwSENJWFpVZFRQYU12WjI4V1c3NWIycFV2?=
 =?utf-8?B?S05ZQ0Z3NlQzVDlFVXVHNEp1UWR6NDdrWEZsVjNFVnBwRVVuMXJ6MVI1M3ho?=
 =?utf-8?B?cGl6UnRrend0Z294bTdvQTNWSEdHNkdBd2FvSlVxLzRLdU02L2MxRlF0OFJM?=
 =?utf-8?B?TGVENmg4akRQMVpJWFFJKzR2VHA2SXVVb1poanBwNG4zbDZUL0dtK214VGx1?=
 =?utf-8?B?NlVLTHJVbnBxZjMvSStzK2haMlRLdGlEd0JTb2xmRE50aHIxYmYzRFJaaDhw?=
 =?utf-8?B?K1N2enF1aG5jQlI0cnh0YnIzRXhvWHBzYndISmdhVzVoVWRCUnkzcUtWK3ZK?=
 =?utf-8?B?NENQdUc0T1JlQUFzZXRmRzJBWUQ2RG01NTZ2M2NhcnJwWFo4MDFuVlNsMjRp?=
 =?utf-8?B?SFFud01uZ2puM1RUMm5DalA4dmVoS1BtYkVnZ0JHQTg4WXFzNjFhMVdtTUpp?=
 =?utf-8?B?Ulh2dmxJOE93TkpxZFFpdm42cG1DK0o1NzFvUlVXQzNqanJQL3FQRGQ4SGdM?=
 =?utf-8?B?czMvdS9EYnE3T3hYNEs5cFNyQW9kb29FN2RUOGZnSUI3a0ZsQnd2TklWSHJi?=
 =?utf-8?B?M2tiYlF0dzcxdnh2UCtlOHFySW9URVdWQ3g1TERDZHoydkpOd0lkNGptbU5G?=
 =?utf-8?B?NWcrb3NKRzhndE9DajdMVmhRR1d4QXBCaUVUanV5c0Z0N3ZjOXJyWWxNZU5G?=
 =?utf-8?B?ZmhiMExoRTIxSVZhT1RwVVRhVEdPaUJOK0pwb1RFelpIVEdxMWdEYmxqSG02?=
 =?utf-8?B?OVhxdzcxVlBLMVhhUnVxRlNlTjlTeloxQ0RtQVk5WmJHVFQ3SDNTUnM1Qk82?=
 =?utf-8?B?bWM2NW9lWFZjM1d0WmRKTkNSc3NrUzBpMnpsNnErVmFiclV4S0FQcG5ORnFu?=
 =?utf-8?B?YkZpbDRIaUw4clBqdFJHWHBCTVRpWHZ5Qm5wYkJ5YlhFTkxXM2dpWnN5M0xX?=
 =?utf-8?B?blQ4NmlpeFRrdzBpRTJBMEp1WHB5NEtCNXQ3L0w3a1E4b05GYVpNdFV3Rzc2?=
 =?utf-8?B?WDdMWHBUK215b3B2bjlrY0lJb1lTeGpvalB5YWl0Z2l0Nm5md1FmMkxMUEhR?=
 =?utf-8?B?NlkvT3FCZzdHckJZWkJkYS9NVitCVk1kZnRJVmxKTlMvdDlYdlVDYnBDRFNx?=
 =?utf-8?B?VmhuUVJsckNFdmh6TTBER1JKOXc0K2lyTW9IMGJmMEg3ZmxKVThPa3E3dlp5?=
 =?utf-8?Q?OgjwgSm0VbIJohw4=3D?=
X-Exchange-RoutingPolicyChecked: KncyWUYyjCgFcrnQrFJs/lx7STQLOH/5lTvMTYlpQP7GJ4fQvm1293RRimOvAGdACNP9FlK6r0nmhNddNNhLiZ904jxdQ0U58SreEDaggFi8EoD/k4Kq/hdHjzySJ9da2WsfB6LZz64Rp5psRRs4h2owyb5QzRg+BEXrtHPm/c6NlAqZdSXRr/YP4hP/cTYtfXKROLtj3gtutza2WOgXJZrcCVmLJoXp7KdoN2ar8uYidAT0TJuhEY/H9ZGQVoVpcSEVPgIE3AA+c4FfiZ4CxZ5KMT7YPo6Zc/7gRXZwdJYHXzw3p+bKYl/SWdTb1BOFLow6uleRikOHqlHUKYTgIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b384552-9c76-4411-62aa-08df2aa8d865
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:41:18.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edyxXO0wt4WhP5lkdjw3qKosBsbEIbwc0iJ2yuuyjXHhrLTO5Bpt5XjDrROQP4q5EcMZZEiGMj8a4KETa7FcES08dDJ4rkOyOFtZJJY7/j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB931975
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

On 10/15/2026 11:13 AM, Thomas Monjalon wrote:
> 15/10/2026 10:53, Burakov, Anatoly:
>> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
>>> Testpmd commands should use the driver's public API
>>> rather than access its private structures directly.
>>> Note: ixgbe_testpmd.c should be considered as part of testpmd.
>>>
>>> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
>>> operations are available through the private adapter structure.
>>>
>>> Rely on the public bypass API to check availability
>>> and handle -ENOTSUP in the commands.
>>> Remove ixgbe_ethdev.h, ethdev_driver.h
>>> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
>>>
>>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>>> ---
>>
>> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> I forgot to say it is mostly written by AI.
> I didn't review it myself.
> Please double check.

It doesn't look wrong to me, testpmd code should not be using 
driver-internal things anyway except through pmd-specific API, which is 
what this patch does.

-- 
Thanks,
Anatoly
