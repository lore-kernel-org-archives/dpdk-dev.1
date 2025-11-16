Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D0CCD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142C24111B;
	Sun, 16 Nov 2025 16:42:19 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71]) by mails.dpdk.org (Postfix) with ESMTP id 609DE402E3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 16:42:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBbU1OQyoYznV8bNgHFuiLJDGM7n4FyXnyf5jiSD53lm4IjduhMJVmDK7AVu+1RFXcp2e47nsHy6fYqAdHnwevzkyQqrHj5ELMY5z6dqF5R9/1Nh+qNeu1UZN6sK49SYpkbI3Ov7Fxug/af7GIxxeBqoWdLluJb8ZHbMqnqbBCevlpVROlUEVetqn4+4+pPi+cda1dtLP2r6M3a6eEIteJvPTP30r2KVjYNT52rDLVHPk6H94CCBq25WMsz8IgWZIMz7aWxP6lopigl6p/L6g9BC5fEkLgoV/ak49xD3lnPuUC9aLqvydcIutcshfZ8j80VUWCm3nzi5sM/1hW/EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCuswmt6otQdqAmF9HC1mW5SluJwf4NYwUjrMYPa3wU=;
 b=UFIS+VTfJ8iTL+Ph9/IByYNj2vQqMgHSjR0Z5JxBNu/9f65VP4BBDLsv3ilO5kIvK83sABLP0rUEqewx9Pvo4AT/KHa9v5pS9vRuxSx6TW7zgAYYVCgsVMdIzf429rtOTWLBaN0EZlWQqRe435LvSBbwVbIr16xhP5GWpUyFfpqivYy/ojOwl+BwQkVuvVYzu1sufcEFQ1kjPnWr5nZNDQJMxnZa8m9xP8lCZFtSWBh7Qpbxv0NPymMuW0rQYJVclDN10iuztEzZR9xBQFLnNmrO3z9r/lmBRhaLlEqWIE3xvL9PhvDRRNGMxXmcuO/G6pctPYWrLnoKfKOOTc+7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCuswmt6otQdqAmF9HC1mW5SluJwf4NYwUjrMYPa3wU=;
 b=KoYQj6xCyw6IREGQpIz5bKfyj0xDfxnqs0rrjhCqvLw9GkiavWfuQEMd0EefvJHxNfqFdqJqpucOLZZ0Tjvq31GUO0sr7eoNhCTQ0R/KeVQPGtvi8L3Megis9vLeTnvTtmwzU3EuimpZT7Vam44M+kOkXt9KVnfN04+aIDfZcwfUsRo8dv8Gdw9Vo0mfMohyidHWAil/niHendCbhn2K910CCeHZBH3pOH2iwsgiVHIpeyG4xeBInwharY6EEIC8akFwyR3Q/GXKWxYTInP/YWMG4wXVVjObpA8aVPbUkc2hW0zkh9ppj2Q7q1O6I5J6S43qjhehkyK/LGRHgEM4TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 15:42:14 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:42:14 +0000
Message-ID: <96ab0903-bd2a-4425-9b8d-75cefeaf5f19@nvidia.com>
Date: Sun, 16 Nov 2025 17:42:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: update the doc for support multi-host lag probe
To: Jiawei Wang <jiaweiw@nvidia.com>, bingz@nvidia.com,
 dsosnowski@nvidia.com, thomas@monjalon.net,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20250930120247.24926-1-jiaweiw@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250930120247.24926-1-jiaweiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3568e5e9-b728-45f9-c88b-08de2526b6ca
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGIrS2c5Ty9uSUVjODVwTE9MaHBBVkhab3U4d1lQUGdxcWZ1RWpGeG14L3B6?=
 =?utf-8?B?bXJDUm9nUW8ycEgvYy9RckpPaXgwK1NJR041VUpvUXJKYnZQRVB1cElReElu?=
 =?utf-8?B?aVdJU2p0alRpM3pKeUpOa3ZLZTU2by9kd0lmb3ArY0twWkNveVZsSlFGWlU2?=
 =?utf-8?B?Yk9LQUs2MUdNQXVadDJFaHNVUkVDaGZ5NTdjZFg4MWZPMWxlTGs5ZFJmellW?=
 =?utf-8?B?SExLYTF5ek9XSXNwUnlTRDR6VmFIWXJHa1RTb2ZnY0xLUVJWR0t2U1kzdTFz?=
 =?utf-8?B?RnRwUS91VUk5QWZSRXZ4QzhKcWlvQXo5NmtVWkR6dlhocm04SWtRMlBQWTlx?=
 =?utf-8?B?ZVlYcVVkV1B3SkFKOHQwcVBsanRZRnR0NTZYV2NadXNoeE85ZXBXaTVwUnFJ?=
 =?utf-8?B?WnVVS2VyTms3QUc5ZGhCSit5cHhGZzdsSVFDU2lZdTdpOTdENTZmQjVtR1A4?=
 =?utf-8?B?Y0tjK3p3VUp5VXBmNXBiWTl4eHRuWk5PTDF0NStZSWp5MVBYRVE1dlEyUys5?=
 =?utf-8?B?eGJmSlovTEVzZGtGa0F6K25zVEpmSVRnNi9wR3ZFb1Q3QUYrN3FwTHk3U21P?=
 =?utf-8?B?YTY3azlqTVBRQ3JKbmVDbmVPZUwvdHpyK0FDMldrVEpnOXoyRXdJR252Si8z?=
 =?utf-8?B?M2g5NTlzMDhyeWpSWEpuNDhZS2FNY1UxMGlJNkl5VmFUOUNnZHlUN0szN1BC?=
 =?utf-8?B?ZVBFN0hGRkYvUlpJWWZTVVdqK0FZdDE1UDluT3NaTWRTRXl3dll4MWpvNHJZ?=
 =?utf-8?B?WXA4VTJ4dHExbXR3d0RSdDI0SXF2VTd0VnpPTVFyWmVHckZCc0h5M0VITm9T?=
 =?utf-8?B?RWNONmlnZWd4N09QNWhlQUhwVFJLK1ZDQmFOMG5NS1h5Ri83aHNiVElUdlVH?=
 =?utf-8?B?NjdRM3BkUlJXR1hPSWVxY29BNkFNYnZ5R0dXVGUrSnp6bXpJcDkxL1RsejNV?=
 =?utf-8?B?M2lHNDJDc1JyTFBMc05iRmtJd3FUS2NmU1FFWE9CVGkzeDhqNU56WWs5S2pZ?=
 =?utf-8?B?ckVLSU5KY3o3WTl2aXMxRUF2VHRXZ0dMclpDZ3ZtUHJIcVQrVHZlWXBob1Q5?=
 =?utf-8?B?NnpLUUJZVTBXbzlnSXlwb056TURVbXFQVllUM3NWTFo2WG1WbWxQUkxJYk1v?=
 =?utf-8?B?aXJtRDZLVWZWQURxQTYzY3FhNkdFeC9vL3RIVlFOSVFaNXJ2OXVXenlrMkRr?=
 =?utf-8?B?QkNqSTdvTFgzdlNMbGFIT0FyNXZxWHFyWHV6ZzhsbUlWSTFOcXRwNURDZmZQ?=
 =?utf-8?B?MHhmU0pYUUExSW9idnc5ZzlsaUh1UlJ3aTg3bk9RZjZGNngwNjVpdC93V2tF?=
 =?utf-8?B?TkFoZEFRMlNPT3cvUTM2aDdVbktUb1ZJUHcxM01lR1luU2FtbFhlaHNCUGYv?=
 =?utf-8?B?ejd4THpFU1dhcFlKc0NGQldZU1RxTU5CM29QdjVJcndOTTNwVXlxWlp2Skln?=
 =?utf-8?B?ZnBERWxybVJwS3gwM1VxenRacGVpTUN6eUFFTGp3dFJUclJLYm1aS3Z1TUx1?=
 =?utf-8?B?QkRvWU1qSFFiUEI0WTJmVkxHcTYyN0NuTUp4cmM4SVJ2ZElGUk9qZXNxajBV?=
 =?utf-8?B?UGMrcEZsNnFzVzhFRmFHZEdac3BxcE10NjJMeW5BSW1oU0FhNm5iZkluUDdm?=
 =?utf-8?B?Q1dqbDNwc1dDelg1ZjZvdThQTy9HNEZNZkdsMzgvZUZlWk9hU2QyWGpkMXQv?=
 =?utf-8?B?M3Q0MjVPc2ZoWURncy9jOWQ5cWVDNTM3Y0o4K1hPb2ZnbDEvSlFURVNBdTlK?=
 =?utf-8?B?OVpJU21vMmVleitOUUExRTJTRmZKV2MxanQ1bmpycXZubVdsbnVUYmwvMWRx?=
 =?utf-8?B?bGJVellqUllUTENJelB0Sk1oM2FMZzFRU3RtL2FOc3hDSVVvK2xsM0RZZStH?=
 =?utf-8?B?Ui9CcGpsUEZaWUYwM09ieFZqVWVqWEtHcEo3cXNHdm9XakhXK21QWUtqenho?=
 =?utf-8?Q?HL5vWPox43cMzHyrGLF1jARF22Ui4lZI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUZkZXIwT1M0Wm90aEFsTmt3QUNEY05NNGFDeFYzOEZZbExUS2lCNHdEcHRC?=
 =?utf-8?B?TXVXYlpjN1dOYmtkQ0xGUk8zVGI1Q2pXKzk1MXBGS1hhcEhwWWYwN2s4aGIy?=
 =?utf-8?B?ZjhCQ2hDZ3RKWWpUVXZNUExJZW4zb3hwMVNEY1lRZjVMaWZHRTJOczR2UXBn?=
 =?utf-8?B?YnIxSS9CTk1xOU1zZ1R3Qzdub0NWSDk3ZHdBL05PcHRiMTVKb3l1bFA3YkF0?=
 =?utf-8?B?NEVoSGtvazBpd2dOa1hMbk5FZ2psVEhTVkk5Q2hqdVNyYm1XVUFKWHc3cEo1?=
 =?utf-8?B?VkF6NVFKakpiYkp2MjJiejB4Wi8xVEprdnFLTFBlOUdoT0hFZHFzcWdLNlZU?=
 =?utf-8?B?ZG8rWUxxTDQzWmdTM0U3RVBPRVFsOUNOaG9mVHJzSEs5VWU1OEo4UFBCUkVl?=
 =?utf-8?B?cllHUGRKU2xrM0w1T2VtbGswaE55OXc1TFF2VVBpVzVPd21CMllNdXlRQzJW?=
 =?utf-8?B?NUhIc3BJSS95U0pVWFVSNHhkWStnb3hhYjAzMDJXdDQ5M2JheGd2MDJBa3Ni?=
 =?utf-8?B?anVMcHE3Y3VUQUtHN2RuR3gxY0Zxc1RYL2dVY3dpcmpjRUk0YzZ2WnNHbldu?=
 =?utf-8?B?a05sMnIwdXZKMlhSVkFHMzM1V0dvdDVRSFZLQmF2ajJaZXFOTFdsRUVPak9Y?=
 =?utf-8?B?UXh3MndHbFlPcmhrckQ0ZGZuUXRPZHJySjZ3cC9rbEpWS0xub2VKcXljQXA5?=
 =?utf-8?B?NENIY0EzbEQ4S3Nkdk4rcGRESFZMeTlpdy9UMDA0MnE3anI1Tmd1NFJCL3Vn?=
 =?utf-8?B?RmRBdWhJVVUzTnBPWlpHalpXai9iYXRpTS9zUXFYNm16ZStWSm9uVmVNTVZj?=
 =?utf-8?B?ckFyVUZWNnc3WXhnd2JTN0xvd0ZhTUY5d056bGpGT2RyL2NuRThHZGNEVG1u?=
 =?utf-8?B?WXc4N0hEWlBGaXhmVVkvZTVQTzVmMncwcTJPV1NOMGU4T284ZVNEOEd6bTA5?=
 =?utf-8?B?S3g0QmozeFR2YlM1OHZjaFN4Y2RTQ2d0TmY3cEZ6aGpHcDhhaHJlcWNUVDNi?=
 =?utf-8?B?c1hVUE9RM0FJU2grWGZ3ZG9UMy8ycnRhYzBzL3c2ZCtuYmNKNTV6TTFZTXZB?=
 =?utf-8?B?dWJUTnVld2E3MExQRHN4VDYzR3M0dG9Tc001elI1WU1uaGc4QzdpazF6NUxY?=
 =?utf-8?B?RWQwSHJkM20wZUJnVTZEK3kxT1Y0SG5jUGl5ejlYclczTE1qdjlXUVV0RDB2?=
 =?utf-8?B?Q21ZdjJGRlF1cytnemNVZmx4QWZWcFN3YUdWUVYzc0NzQkQzU0pVYzBjUEVC?=
 =?utf-8?B?bUtXdTVwbFdhQWJtOXFxejlhb1ZCV1dJeGRuUjB2eWtZNStRSE50Q0huZDQ3?=
 =?utf-8?B?Z0h0T2tnaktHVU5qNjhzcWtRRTM4UHlicTdpN0JDbmgrWGFibU43Y01wMC9z?=
 =?utf-8?B?SnRuQW4yMVg0bi8vU1NqL05lUUw0RnVZYVFZenQvN2V4Ry9uaGFXbkNxZmpv?=
 =?utf-8?B?clRJT2FKZHZZbG9JM1lmUEdvWFpIZ0FObmZaK0dtTzRYME9xcmFoUUx1YnZ6?=
 =?utf-8?B?Q2YrWW56YUhzTXdJZk9EVkRqWTlHRGFyR3pPa3lOa3kwb1FNRk14Rm9STytQ?=
 =?utf-8?B?azBUSWpXTG9VMEYrLzZzYzZ6eEVzdmRSMC9GNFVHQ2w1S2xXU2hCa2RhTkpK?=
 =?utf-8?B?RzFWcDRKMDRQb2lFUjAyaFFlTEJNTWdGWmduM1NhaDlKQlRRbGV6RDZNYmxQ?=
 =?utf-8?B?ZG93OU02QmNSWHJMZ0lOMFpWNzI0TnJmUkJjQ2hwUTlwMzJ6MU12MWY0RmtI?=
 =?utf-8?B?Nnc2QVBBbm81UDFOOUR5WG9nN0oxL1Q5NEtPTGE0aDhNOGlWSHpERGhJbVpl?=
 =?utf-8?B?d2wwcWRyd29va29WckxLT0FXai9jQ3VHMWxpcE94c0U3RzRlT0V0OUFveHU2?=
 =?utf-8?B?NWZxNngvN043cDhqK2VJekNOU1NsenBlUUdUSldjN05hc01QWjVsb2hiYnEw?=
 =?utf-8?B?aTI4RmI5VzdzTU13YUtXcXNtMTIvMzJld0NsYytLaFc4SkZKeUZCZkRGbFRj?=
 =?utf-8?B?MjFOTEhWTmQ3VWFqTURNSGtXSWNDMksyM0NCdWJZUG5FY0ZWMmdqQlRmMmsz?=
 =?utf-8?B?elFXUFdFckluQUZVZVhPc0NrRWlEOTJyY2Y1MWMrNVlKekhWSTRTVkx3aXZS?=
 =?utf-8?Q?yPN5XfNnvHuFoILKzs2l6uP+G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3568e5e9-b728-45f9-c88b-08de2526b6ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:42:14.1874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nv5xsgR0Y60SJjjIeUdCC8oMhpRsoqkADWb2OL2gwzis4qNXYLURd7BOqR0Q96q+BsY3OaO/rNbTGOTAaefyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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

Hi,


On 30/09/2025 3:02 PM, Jiawei Wang wrote:
> On the ConnectX-7 Multi-Host Setup, the PF index is not continuous,
> user need to query the PF index based on the return value of the
> related sysfs entries:
>      cat /sys/class/net/*/phys_port_name
> 
> Example output is 0 and 2 for PF1 and PF2, then use 0 and 2 of PF index::
>     -a <Primary_PCI_BDF>,representor=pf[0,2]vf[0-2]
> 
> Signed-off-by: Jiawei Wang <jiaweiw@nvidia.com>
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

