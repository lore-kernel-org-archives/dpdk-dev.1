Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C56C3601E
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Apr 2025 08:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BA740156;
	Sun, 13 Apr 2025 10:07:16 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by mails.dpdk.org (Postfix) with ESMTP id D17B240041
 for <dev@dpdk.org>; Sun, 13 Apr 2025 10:07:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA7XLZ5hLvZRtAnCfS9Nksaj27n/sSIFv/K9Y5rzSvLUiNSG0t2UDdqQuqYHPCzOICHLmmtnZbf3i5NBW9IcrwnzQ5ZMtWORn0ybdBzipBqP25hVbpcRQlYA1DI5k3Pit1jKHpgJTRZfmCXJCZRGwefhhYwACFpsLu5Ac6TLSvrWBb/U6U7bK6x1Sx9jIpN8obgfewO6VyRiGngwG2+MNojnWVZRpvnG1YqejsILCcOORhrKv6i5cxLcxd228x9ccN1xU49O2G0KOgn6rFCog/fsV3ud6OKMSjngRBcCDAWVO0wXCRe3g/Nl237OQeVpak5sc11FkoAtx00jRij9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHTYenJKp1NBR8Pn/BySbnGshgVuaxqrPDHkQV/1nAU=;
 b=ppD/xUWQ9BZTDwilxkh/9jSG/LGogHPw5fSbr3UUA0zs5Ny3gdOMQBATEOwgqyT/mWojNttiPUIxG7kpLnYQLmdJOGOiwsqvMJ+49w6LlgWNBK98KPJLKAcLsgs9PMN1s3+/CcmH/gookLg4Yk+POQMQ0TJMwKRA9Vsw7Om4VYhrUCDHFK1VrGXzj6Zd2gEJN+Jsd0OzuRPu2MGAiuAV80zBVu/7FX6z6hxUYrWo3ZEjOP+EYJS/ezEmMbpYO11AdP2jobRs+c6VGgexT7YHtbfsU8M9/3+GiMKR71I14g96LhMv+xheuqEVuRS7jOGZa4w0jnD71gEWukQU+W4uBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHTYenJKp1NBR8Pn/BySbnGshgVuaxqrPDHkQV/1nAU=;
 b=ToO9rnoGq6ByeCkHKlSdq6eZ+gHG5MgYtkTneDGGqnoca+1VdOoatXZGlfX+g9VSLFbg+q6uppG7stj4uUME2DEb+3UQWSrW5DQI2OFYKYekQdyuHnbTsTi9Gb0USzkxC5uw8e8dMMQgvV8lg4KNsI32lW2DjLX+Uy6NmBx17NlygTL+dCTHGvM1ODcdY0Q8wB7GnPirgyWhWyfLRWN0G/Bw9S3pMdM4r7fA/JicTaN/mJkKNOKCkD9lC4wmdPO5hnGw3EvFk97O4TdFqT/d2cZqJZUCsGLwXdINo6BCxiM3jX/apRa9RnOr+c/OFOdwGt1ZxP+c6YGvnOIUQyGBjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sun, 13 Apr
 2025 08:07:11 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 08:07:10 +0000
Date: Sun, 13 Apr 2025 11:07:01 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: "Etelson, Gregory" <getelson@nvidia.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
In-Reply-To: <PH8PR11MB6803A8EFAF0A3E8DA8211254D7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <4bdd732d-03ed-3de1-e412-6d57a1b7a8e4@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
 <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
 <PH8PR11MB6803A8EFAF0A3E8DA8211254D7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: LO2P123CA0098.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::13) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaf7b73-99c5-417a-7ccc-08dd7a623124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sk4EMZ0FBEtu56vPyEjBrOG8i8G4aV/lAqv7PHEvRlZLsIV3OejOpQHzKeji?=
 =?us-ascii?Q?+JnxkEjt7rx5aXhxAWZJ/qbVDehkZXpxIsTuwet52fhbzbQQZv9HyylLOxMP?=
 =?us-ascii?Q?zmkLbySHBYzjC2nMUZIV1kWGVg1oiNNAvHMPOT7lfFH1WqegU5ehP0sQefFQ?=
 =?us-ascii?Q?/ndpnqTw8650IGg1fZr1ZBObhVyGVupmcsx3o3/APGDtQTf24tw1zVhkfhGa?=
 =?us-ascii?Q?RKZDQ46sOicZTHuwYHXQqf7AxkCxKT8Bm3AmE0pO52N/z2gk85VXCu+VVPnI?=
 =?us-ascii?Q?7bQFcx73pLRVC1YQKVuxvcWp0xfepm7Vz0S6aTE0zy8ZNBt+89CkR4RvQBoi?=
 =?us-ascii?Q?yqRjAZTeh1efF8ceJEmDeXGETymX+UJ5hp8cG2HLUVjcdEv1c6q3etrmPTWm?=
 =?us-ascii?Q?0HzfgeRfTjTZp9eprRn4yZspWYOGSBraTxkF2L1VSNYK9XE5+mhcmi3YIp1Y?=
 =?us-ascii?Q?3cCeh3wKo1b3MSPUy9qgzV40NpIeIMYVEEqPW8q+slOc8nSrrlSMxvHdz6Qt?=
 =?us-ascii?Q?owMQtzql0vUXrVjIsR/zW9IKoF4VbAkVKTuvLaTv49+tGnfY97ICf/oAqVVY?=
 =?us-ascii?Q?P3hTUNQmPXaie2vNpjrNeuHgncM5DZWdn+rzI1DrXDpDzFkmo1WvyApwq42B?=
 =?us-ascii?Q?zK5a7kMQ+jNwPgKZwoasQyNj7y3UzEnw2DozGuNdhregSm9ygp9Oa+WEIznd?=
 =?us-ascii?Q?XYF3+0Mmd+0BWvILtWO4HdrZ9SIWDW4cSSzHoatJ6geuEH3ZwAkA1EfZBLR8?=
 =?us-ascii?Q?FsDw+cXF3GRxINyjdaa1W3CMspbjqtJD0qoCdMkVpcWJ/icCplIc6FhqVDEw?=
 =?us-ascii?Q?Vmf+/PGjAegzycE+DUZwJNBWNdEysNn4hq2zOYfV4KkavMZABfdaI4VVfU6z?=
 =?us-ascii?Q?hjiIoYY0tPnfqidMPtD2/5UgVk/34QHyDOnzND7B6qSQs419le24VQYG6z1d?=
 =?us-ascii?Q?4f4th54EmRpetdlXhy6Onz39Y5+UeHaUPxbSc0cK0aa/ULnAUb7PD6HXWKTh?=
 =?us-ascii?Q?5rwlb1Xv0VFwDHM0H2rTLqmmmq+3NIFBfomtjQBJYgwZPM58mDnGoiKIuggH?=
 =?us-ascii?Q?VhDJG1SIPQOq6ymEe9gp0X0agQcfO5iCkjAa9LFk4kIdh+g8CMYfaXIq2Tow?=
 =?us-ascii?Q?3C33VD7iKOsQwX+vGzIOQJX60GY6eaYxDzCxhgxBaL1EV4tF06bIODzGbGYG?=
 =?us-ascii?Q?4M2QyR+tWBujOy+WY/ybj4qmOSp1ljkabkDyiNFYoDUGEL0djO9dcHGi35yD?=
 =?us-ascii?Q?iaMngCW0v4DXJ63F4WLbC9A3Mn+W6nJtWhUA5SHUG9MP2K95+T/iubWmO6iF?=
 =?us-ascii?Q?JtRV6eHPhCxvetAb4ocRTMuv6pOQHKxZezozL+PilzM/crMM2wLIydk+GqU4?=
 =?us-ascii?Q?1XYyieATx8SpHHa9MI8DevnDLDyoJ6LHUGla3GaqUA5vFJJ8TEaKCFNvrf7p?=
 =?us-ascii?Q?SYH4/qNly8Yc+K8uM6sriijM+Ghn6/K6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZaY9bzBy2I2j0zkldP8UrkrqlDVulDZJHcUtzvHpJnFNU6cnnk/0qUkJ9Z8?=
 =?us-ascii?Q?UzM6b4pvVlOJXMct8g6nhDWSVNdOFQCA7g+xiwP34FY45143b34IyQfJHEkq?=
 =?us-ascii?Q?8dii+UFGU3qvfYe87WaVdkcHilzEkOtuzVQ+HNmSiFgpOTuWetxEJMS99ekD?=
 =?us-ascii?Q?/h/0zgnuYchY13FmsAh13SQVrC4qVP+X3HuWTHwy9sgp5NlBw+HRDcWNsror?=
 =?us-ascii?Q?A+Mfk+qF/3qMYJII23NjQ43d6SFyN107MomHxitG/nqj0gy/347ppYvGNVoa?=
 =?us-ascii?Q?rOCItu6oBpB5biRHHaEE6Iw7z6LcTZijpYY8g6/VjNlgVVnhQqrK7w8TZxKD?=
 =?us-ascii?Q?q0OX0E5udMqe56WZZJdASN94PZaoh8eNrgIgguZac0Eve+btcqPSVCyWXU6m?=
 =?us-ascii?Q?qjBf3ps55Uwqko/DjHL20vv+k272HhgjbpnyRXF64iG0BNhdlotTUIDpSLsD?=
 =?us-ascii?Q?q9drHUnNqZERIvGsKpvwBN3sR0DzjZKfUew1XJQn6UUAGSV900OO/r4c/8QZ?=
 =?us-ascii?Q?MCwZZYh8+Tb7NLQd41FyK9Werngq+2UcxA/wLYQgF9zocrQmF0bPM5II7Z0m?=
 =?us-ascii?Q?/18BbRtChhtMaJWArO3lQwVx2AwujQ1tQZLa0Rd/Pwohep91rrfLwHktjpDO?=
 =?us-ascii?Q?5nDw7Z6MY835+udy9gQUSLp2+scbWgpPSprzJz0x2OMp5vyW9G17e+VI/3qX?=
 =?us-ascii?Q?FVt62+HWq2TWyih5d1mDH3+qtKso8wlHmt4C3sBjJGGdKrfs4a4ps0VNh7Bs?=
 =?us-ascii?Q?rUC1jdE7ttawHzG1h7Yci3U3WWE3PqCpFtuGiOTIESC57BYjmspGiOjoB3wm?=
 =?us-ascii?Q?sQPETB5QXCiwx33bn2oyaFsbM4/w4EbSmTQ1QPTPUx7dMnaBQoyIIAM9T41X?=
 =?us-ascii?Q?9seA40fJ+WHVN7KvrHDEus8/kfHCjBOpWWCc3ZxiSIElJTjd8n1WFWikGkmi?=
 =?us-ascii?Q?0ucfWOW9hkhoE27uq6U3mEfn4zAbSsDp4xTZ4nMXywY5BgYsps8Fpj6adhMh?=
 =?us-ascii?Q?nAqb1/FuopC2EkUHs97TXB6MNzItpXI7u12LF0FWw3/0eXvJonhLf7sal6R8?=
 =?us-ascii?Q?RJXq1VcyGj9bisgyGDL7NpuyOpexANiFCM3fTECO+SqYTQZ+C+1Yrq2djnHD?=
 =?us-ascii?Q?9yYhhLiM63hqKPbaFhLyZM1uzBAYNnrCiiz9KTH1nxhxC9r8Rf2X1FuW/+ly?=
 =?us-ascii?Q?EapMkrgZsdK9wNFixurM6yaYLRTmfhkliC2LolbyeGmkjSXOrffPOKX+MPBi?=
 =?us-ascii?Q?lIgoI0in6LxfWhjE1z9X7bvh3TWiWqk1RRftmwvaIwF0PzIdSWT1FMUPFJlf?=
 =?us-ascii?Q?15Q2ltEyUoEd/A0wbTEKZ+UGHWLppwOa2zWjXS0VnvPpckWHqYVEj2gFWtHf?=
 =?us-ascii?Q?g2JRXNH2hhL2ZLJLf0qMRaYr1rrQDMqjHgDDYa/NMYRPxNKxTosh7PefWPJC?=
 =?us-ascii?Q?SldypjzR2w43pkghLlVzKDHwH4g1MNEvLak/mGGG8Ffa0QhtJi2WpOt4Vy1v?=
 =?us-ascii?Q?lkA8R9M1iNlMeA+H1/63NSY9ZrhEKPHAyVYLhuomMnchK05lVH1dAyueP3nu?=
 =?us-ascii?Q?FgDpbRxfmVLqzuxOHqqNlYGvFzYrOFEIT4MBcJZx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaf7b73-99c5-417a-7ccc-08dd7a623124
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 08:07:10.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM4fzog0wAygU3//xNsAfOif+V16OvffjDydlEi1aNEUSHXt0uAzjipyXqhzfdpCwsm0QicYZdQOrZp4I6mutw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

Hello Harry,

>>>> My concern is how to properly maintain Rust crate once DPDK starts to implement
>>>> it's own API.
>>>
>>> I'm not really sure what is meant here. I don't understand what "own" word refers to?
>>>
>>> I see it like this:
>>> - DPDK has the public C API exported (and that stays the same as today, with ABI rules, version.map files, etc)
>>> - The Rust crate consumes the public C API (via bindgen, as done in this patch. More detail about bindgen below.)
>>>
>>
>> Bindgen cannot provide access to all DPDK public API.
>
> Ah - you're referring to C static inline functions, declared in header files, which bindgen doesn't wrap.
> Correct - thanks - I understand your point now.
>
>> A good example here is rte_eth_rx_burst().
>> That function is defined as inline and bindgen does not translate it.
>> Also, the function definition references rte_eth_fp_ops array that is not part of the
>> public DPDK API. That means Rust cannot duplicate rte_eth_rx_burst() "as-is" and
>> the solution can require extensions to existing DPDK API.
>>
>> I added a new public API that exports rte_eth_fp_ops for a given port Id.
>>
>> Rust implementation of rte_eth_rx_burst() does not have to follow the original
>> approach.
>> Usage of rte_eth_fp_ops is good for C, but Rust has different methods.
>
> Agreed there is a certain "mismatch" sometimes, if functions aren't in the
> actually "C ABI" then they can't be called via bindgen.
>
> Agree that elegant solutions (clean, maintainable, and high performance) will have
> to be found here. Many existing solutions just wrap the "static inline" function into
> a "non-static" function, and export it as a public symbol. That allows calling into it
> from Rust (via bindgen-generated header) however causes an actual function call..
> (LTO _might_ fix/inline it, but not everybody compiles with LTO.. link times!)
>

The core DPDK code is maintained as a self-contained pure C project.
What about extending that model and provide direct access to DPDK resources that 
are needed for Rust API ?
That can be arranged as part of "native" DPDK API or as extension for 
Rust-enabled DPDK only.
I'm currently experimenting with the latter in 
https://github.com/getelson-at-mellanox/rdpdk/tree/main/dpdk-patches

> As DPDK uses static-inline functions primarily for "packet-at-a-time" performance reasons,
> it is unfortunate to give-up (some small amounts of..?) performance by having a C->Rust FFI call.
> We have work to do to find/propose the best solution.

What exactly is a small amount of performance degradation ?
For some existing performance oriented projects loosing performance to 
eliminate the `unsafe {}` construct is not an option.

>
>> For conclusion, Rust DPDK infrastructure cannot relay on bindgen only and needs
>> to provide native implementation for some public DPDK API.
>> It can be easier to maintain Rust files separately.
>
> OK, now I understand your "kind-of-C-DPDK, kind of Rust-DPDK" code, or the "own" code reference above.
> I'm not sure right now where that would be best implemented/maintained, I'll have to think about it and do a POC.
>
>
>> You can check out my Rust DPDK version here: https://github.com/getelson-at-mellanox/rdpdk
>
> Thanks for the link - I see you've been pushing code actively! Good to see opportunities,
> and compare approaches and concepts. Have you investigated wrapping the various pointers
> into structs, and providing safer APIs? For example, the [*mut rte_mbuf; 64] array for RX causes
> raw pointers to be handled for all packet-processing - resulting in "unsafe{ /* work here */ }" blocks.
>

This construct can work:

struct PktsBuf<const SIZE: usize> {
 	buffer: [*mut rte_mbuf; SIZE]
}

> The code in the above repo feels like "DPDK C code written in Rust".

Agree.
At this stage there is no native Rust DPDK API.

> It is a great step towards better
> understanding, and having something that works is very valuable; thanks for sharing it.
>
> A "top down" application view might help to brainstorm idiomatic/Safe Rust APIs, and then we can
> discuss/understand how to map these high level APIs onto the "DPDK C in Rust" or even "DPDK C API/ABI" layers.
>
> Does that seem like a good method to you, to achieve an ergonomic Safe Rust API as the end result?
>

I think we need to conclude what the safe API means in terms of DPDK project.
Because it's possible to provide native Rust API for DPDK what will use FFI.
Specially, if Rust PMD is not in plans and performance is one of the main goals.

>
>>> Next steps are to "allowlist" more DPDK public API functions, and start building "Safe Rust" APIs over
>>> them, in order to expose an ergonomic and misuse-resistant API. As you note, this is where a network ports,
>>> lcores, mempools, and ethdev configuration are all required. First goal something like "Safe L2 macswap"?

check out for Rx, L2 addr swap, Tx sequence here:
https://github.com/getelson-at-mellanox/rdpdk/blob/253fde7c16a5514bf99d3823725f825262e244c8/app/runpmd/runpmd.rs#L156

Regards,
Gregory
