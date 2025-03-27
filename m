Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FCC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 09:28:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC9DF4066C;
	Thu, 27 Mar 2025 10:28:39 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
 by mails.dpdk.org (Postfix) with ESMTP id 581A540275;
 Thu, 27 Mar 2025 10:28:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMPKjs8ur4LpC+BMz32QXnIVb9X5vvPFmNNzEP9cmHBIKifjLXK0nDaI6MpmfAc1/kxiqZp5qmE1ON4a2uxjZQ417S8jMr/3n0sWhxVF73VnmSxivSAiFRhff8xz2jVujC2XMus6YYn49KRB8erY3yz2B6Qei2UYmsekUf1nquMME6Qr0GrFOw4h+/hYmB/x1bBO7pYhczATpe684EEPxRQ8zREKkods9AjTbBQ0oeNGNudur4rc124Bl/ABKKUmcesyltP+cqUh+TDx5sWlAyQ98mErAGRM46axht7xrmkGZvOH4nUr2TQh3VIgbKN/1bUgDSKkmnpsUE33NaC2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3Vpf6eZ8sWD5J7t1BMHHfY41/ZLxynFH6qJqZ4/HJc=;
 b=d99oSo+BM9yMGti5LfhbkqpADqNQY1v3SehtGr5X+OCJxNx0QvcImcKYpZz4BC0hEMgxfbidfbI8VZfUYwpqoPAnUqcquk5/npVojnX4qh5Il1/nm+j1nlDSpSfn04yVYye0TvE3bPlPRt6m3OeAzqmfiR9JeJlpjJpb4HVSRfgB0NF00PFGfGyh4V8JtArgpbOLOJoT3mz5++xhRpMooQyAoJu8wwdJVF/d2IJukdcjoBQOYcTv27xclWXvPX+jB3Qp0hosk2qpA/8KhIoj0ak9sK0vaSKxFvL1Z2vmUm8/p+a6TeZRoORd4lSzKRVXFeUoZlCYAQj/FCdpk7JMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3Vpf6eZ8sWD5J7t1BMHHfY41/ZLxynFH6qJqZ4/HJc=;
 b=A/m5mGp5V09YE5tjPfA93+LmLmtQhvHKPvbNwSMNcquckrMGB1qsyJURwc+Q692OMbkRmpUaN0IkrZ2JRRl2TSbpswdonHGSxlinMvj3sny9hWm9l47C5oGGj4fUYNTIWn1FykyZkxmmB1OFeHv7R/cvTzsAbi3dFl4koRC90YpihlM54zbv63et5PCmDjzMrp62gCRPBg2FfdQ2FlVzCq/TNl1IpkhAZsR5zyl3XefHAglO+2sZ6d2u0pIhspDR/Clyep2OPsheJoi/Sc/gy5E7Plk0I3o1bSVo/A6XYyqgJTOF9b7lQubBoS3VEiH1b959/ADHuBEfBYBgV1R7Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AM7PR07MB6595.eurprd07.prod.outlook.com (2603:10a6:20b:1ad::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:28:38 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:28:38 +0000
Message-ID: <ed17ac5a-2456-430e-8757-fbe0ae2fc198@nokia-sbell.com>
Date: Thu, 27 Mar 2025 17:28:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] eal: prevent socket closure before MP sync
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, dev@dpdk.org, stable@dpdk.org
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250317065609.79fa3ad7@hermes.local>
Content-Language: en-US
From: Yang Ming <ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250317065609.79fa3ad7@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AM7PR07MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 667601db-cd78-4101-ad5c-08dd6d11c11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2Z3K1RQVVlZRDNBalpWcUdHMlN0cGxuY1Q1WGlRNkN3VTRBU284MTVmTGZE?=
 =?utf-8?B?Nkovbi81OWxZQldWeTFRdlFMRXAzK2w3S2VDQldXdUlEZU80T1kxUzlHSXE1?=
 =?utf-8?B?bVgrZFBnQ2o5UnpOOUd3cExaT0Y0dDlOUFJOQVhNWWpNa0MySWNYdHR0ZlhD?=
 =?utf-8?B?L0kwd1h6VW0raTRTWVBKTHc5UzdkOG5keEZJRE1UQklwYTRCeU81K29RNHZi?=
 =?utf-8?B?RFBKU2NRTlY3MVgrVGFJdWR2YVdEREEybzhHZjFxbkF6UGx4RE91QlJxQlBl?=
 =?utf-8?B?QVgxMmpNTytVRmZIS2ludDRvQ3BrdmV0djBmdktwOU5hc3Bwb3hQOEN6TG5H?=
 =?utf-8?B?RlVrZ21xS2lXaEVNTncyYVZzVHFKbW5xUEQ2QTNhUGhFVmZsU04xT3pLODRO?=
 =?utf-8?B?b05RTmlXRmVRaDhiR0ViNFZBbG5aNENITTg3QWhsQVBHcS9YVFp5ZEpjZ2ZF?=
 =?utf-8?B?em12NkkzWVNnamM2bW50MkhQQlQ4MWRZU2tBbmVLdnpCVnpMZ0h4Z3V6cGth?=
 =?utf-8?B?MW1RVDBzclMzRWUvZWluUStyRktSL1NtdnNDbTJ2MFZER24yT1l3N0FBRHlO?=
 =?utf-8?B?NitxNXdocm5iTEZIbW5YdXFvK3RNWTkxYkdYclk5ZkZBdWtJd1JyOTBGbTJB?=
 =?utf-8?B?L3pYNHdqTW1VajlmWEtZdG1ZY3NkZGpaeENORXNEcVFYU0drK1Aya0F1ZlBD?=
 =?utf-8?B?SkJvcUVHUEx5U0pZYXNaekd6VGVSdUM3bUVMRHVKVVdDcnZnL2hZa3N0RDhS?=
 =?utf-8?B?eXZnNE0welFraXZ4VnlSZk0wcEZuZXd5S2xOb2RwcVpsbUJ3T2dLelVkTUlh?=
 =?utf-8?B?ZEprQlRWV0dXRlQxY0hzSDN0TXFUcUE3ZzllM1RGR09jeUprY3ZPS0tIQWlY?=
 =?utf-8?B?TXM3V3lHNjduODhYbGtRVERJR0REcHRWaW92ZHZKc1hzemladXJ2bjNJNmpK?=
 =?utf-8?B?QkljZlR1OVdzZitKbmR4TGp6L1M0eXYreld1eXdXVFppbnhRemw1YjRPUmNC?=
 =?utf-8?B?QmNHMFlnZ3l1SnN1ZElKV25mUDh6V0MyNWJ1VG1HdzN5Y0dUcWR0eDNweWFh?=
 =?utf-8?B?Qkt1R0c4cHhZVDFtZXR0REhzb09tekVvdkZrWkJ1QzA2UUJwNEpualJsZ1pa?=
 =?utf-8?B?TWphYUNhcVd1djZTdkIrOXJwSG5FZHNuTVBYS1oxTnMrRmVlaFBqYi96YUZN?=
 =?utf-8?B?VkNvVUFlRWZPeUg3b29ZV3ZhaGc3UDIvd3JuUmNCMFd6RHhzTzVndVJiSEo5?=
 =?utf-8?B?aUZsMjhSRDFEc0U1VzVLK1VTUWNDNEczR0pUeEwrT3VuQkd3YTVKT203WVVY?=
 =?utf-8?B?c0Y3ZTFvQ3ltUmZPci9mdTMyN0FOS2JZbE5yTkY2KzJzT1AyNlhYMC9SdkNB?=
 =?utf-8?B?TnY2K2dvNldEK3JXQlNZRGhRTEVFMG95Z1ZWZlF4bFhlcjg5Z2x3VjQzZHlz?=
 =?utf-8?B?dDNEb2lUeFhDaW5Hd0pMMjlKOWJiTWE0TklSZnkvMnVWZTRKOWhWdU9Nc2N3?=
 =?utf-8?B?UFoyelBES1d5d0xjK0UrQ2ZwTjBDcGJKRmh1NFNCSk9hb1BvN3U4MW1mOEhN?=
 =?utf-8?B?U3hGcFY1bHRJYzRUNDZPLzl0a2pLNjE0eDBGV0h4YU9VR2FrZ0UzM3R4RU5R?=
 =?utf-8?B?UTJ1Q0FJNmlHSXpyWXUzRnY5YWZkbFh3dlFLODRTaWp0UkVIb0k2a0IxZXVJ?=
 =?utf-8?B?WC9HZlA3cDdWS0crWlg5cmJVU2duNEhQUFlEYktuOE02SVc5WVZaUXhPYUNi?=
 =?utf-8?B?dDVBQTZFWVczL25IdzF3R2o5eVp0RzN2Z0ZBa3pVMng1N3RCa0szTzBEcGVn?=
 =?utf-8?B?dU9qYldQbThuU2U5dUIzMHQ4YisyZUwxUnpQeXNIUVRmZ0hCay95K2tMd0Nh?=
 =?utf-8?B?ZG1iTG5TbXJrYjZMRkFiYzFjZ2wzbFN4NUpIMld2RmZmb3E4MzVWSStJZld2?=
 =?utf-8?Q?OeY5tC4NC0g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2dtcUxta2Q4SG96WmtLQksyUXZtOGk5VXNXQ0FrNnV2aVZLMWVCU2RTZ3lT?=
 =?utf-8?B?cFlvSDlxZ25vNlNvWGRjbng2all1UnNnTzJCT3lyMW90NVZkcUkwejJpbzF3?=
 =?utf-8?B?eW9FM29wM281em41MERtNVQrRjdJMjRnQ3VZUm16aTE3YTZ6UEQzelF1THBh?=
 =?utf-8?B?YXZJYVJiNi9SVHJpWUxuRUxRWDZ5d1VVV0hHY2VhMTVxa09adGpjbzc2VGV4?=
 =?utf-8?B?bjZHYnFzUi9ZVWd3dm1wQ0w0MkhJMDA1MUxyZHEvaGtNanF6VUZ1UVA5S3ZM?=
 =?utf-8?B?WG40VDNyUThJdnVxaGEycHZxaEY5WWI4TkR6ZnNldVU4VnlCZmFnTk1lZFV0?=
 =?utf-8?B?alVXaEtLUE1WSHVMREJYaEhYYVg2OVVXL3pISW9LY0tvdHhlaUVpb2ZiTHll?=
 =?utf-8?B?ZWZqQlRBMEdZM3A1S1ZiV2Z0SUhFTDJTM3NlaVNTcnBlTGJEUzhJYVNxTEs0?=
 =?utf-8?B?TkJDU0krT2NGVElGVHkvTTdpMC9iS2NKMnpoaThVblI4dkRLZ0RpUStmQTdI?=
 =?utf-8?B?ZytoUWZhQStqNUFKR1ZzdVVUREE1ckZhUGpIRkNFd1U2NnkzZ2JuQWpMN0d3?=
 =?utf-8?B?ZTVqMjdxdElyc2RPSCtEUW5lM2ZWL1FiRWg4YmZ6OEpET2xMeERjYVVyd0Vr?=
 =?utf-8?B?OHFEV2p2YkREQS9McElMRlVpUERiekVTcUhhazA2NzdFbjJTODJhOTk2ZlpU?=
 =?utf-8?B?Tit5ZWRSYXptSlo0c2tNaU4xa3ArcmVDOFFVWFJib3lCTlVxV0F0bGJVdHVH?=
 =?utf-8?B?c3Q5dmdkaVFmWUZSVFY4KzVNbi9SV0l4NjhVRFlNUHliYU43UUZXbm1RSHFG?=
 =?utf-8?B?YzZFVEZ2UUt2cVNrbjR3bERWM2RHZjZydmZoNHU3bmRLZFdpRHFWOVJPZWIr?=
 =?utf-8?B?MFlSZ3N5MDlFV0hqODdkeG5rSGZVNDVaQnVMTjZRaS93UkpDTFJjWWlzcHRN?=
 =?utf-8?B?dC9hWFlBaU9YWkl5UzFIWkFBMmNMWjc3eXIrZElJeERycjJVZHc4M3hSNzlk?=
 =?utf-8?B?N0FDSWVZOTgwMG5NL1VFZ25wR3drSVhMMVpLRVVxQVgwTTZISjQrMldodXdt?=
 =?utf-8?B?Z2ZJcEtucDRZVUVGZUwrYnh5citEa01TM0NxUE5venlhZ2UvSXQxdW0rYkwx?=
 =?utf-8?B?K1hjWUR4RXJiRE5tWC91NmhESWZvNm5sYzBnMkVaR2o4NGNzdFBVa1B4Q0Fi?=
 =?utf-8?B?VXI3NXh2ZmFPSzYzMUtDVi9FM29RaHZIVDhFMFRUc0VqNFk2YVFZUGVsV1ZS?=
 =?utf-8?B?TWhVYjlYYldhTE9lZ0RJNW1kR24xRXFZakl5R0tUcENhRzhNN25aSmh1bGhk?=
 =?utf-8?B?Y1NDYVZqRFlZRWNNQWM2UTJDQWN4dkptUXI2SzhqMGh1S2tpb1VKNFRnZGtP?=
 =?utf-8?B?UGlLYVNVYU42ZjU4NW50WmZMZkNxQlJ5ZVF2akt5V0h3QkIyMlVvNzZoR3V5?=
 =?utf-8?B?eVRodkVqMzdoQTNZN1BWSFhabVNrYjZXTXpkVE9DeTIzb0RLT2VxRXNqN1E4?=
 =?utf-8?B?a3BqS1RzMnlvYWpzTzlTcW9lYW1zbzNyVUdNMlJuSW5DQ05nT0NvM1dXUnlw?=
 =?utf-8?B?STVtT3NMUzNTa0lRZUZudUtyd3lHTUxvM3Jsek9tYXJ5YkYyd2ZNM0NkcHdx?=
 =?utf-8?B?OUhlNUpoTTdmN1ZuU3VIZlZpTzM0S0xTREcvMjdUdXNPb2JESmFPdkhid0Zn?=
 =?utf-8?B?RVJqbHlESjArY0hIMC83S3JiaCtEcmJHV01IU2dGNWVjK3habVkxdkMxR1gr?=
 =?utf-8?B?L1BFRmJhRkcrVnRPcnFRNUdtc0I2TFFXUDVJNXZLRlE0TlNYdGs4Mlp6cmRq?=
 =?utf-8?B?QW9GcVR4dG43RTNibFlTQUxmMUVlMTIxd2twdlZPei9HNUFvNlRoR0NzMnJV?=
 =?utf-8?B?TUFHUG1CZ0pWRWNpclhNd0JPN0NkWllOc3NNWmxnOVluUUVrZzVNKzY1RStu?=
 =?utf-8?B?cEpKTlEwYnFNM0h4ODRwaXlqOTRDYVpGNGVMRmRzTVZEMldwOVplSE0zblRU?=
 =?utf-8?B?eHZBcDV0ZnBhZlowOUlmMnFZM2FXUkQrdXBVdlNvT1YxR1lFd1prLzJ4ZFFL?=
 =?utf-8?B?WVR1SDN0MldHVWppM1JhT1JCaVpObUtxTFF0em5pZ1pRVHJDZHA5ajgvWm8r?=
 =?utf-8?B?ZGJOQ29LMnRCcEN5SXlWU2lvMUQ3ZmpEb0FTMnJJZlhiQTZsdUU5Nm9DZVh3?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667601db-cd78-4101-ad5c-08dd6d11c11b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:28:38.1606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K2PoCy6IVMVWfibIPYBkw2rw0OkCAPSz+TO1kfyna34nifSE7epS57OR5Sj6Cm0tjgV3p357LohNtXFSA4vzZ0dZ9HwME+6aFYDI+hU3dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6595
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


On 2025/3/17 21:56, Stephen Hemminger wrote:
> Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
>
> On Fri, 14 Mar 2025 18:36:38 +0800
> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>
>> The secordary process should not close socket file for MP
>> channel before performing MP request synchronization.
>> This prevents error logs when the secondary process exits
>> without any operation on the crypto device while the primary
>> process starts the device.
>>
>> Case situation:
>> eal_bus_cleanup has been added in rte_eal_cleanup. But for the
>> secondary process, rte_eal_cleanup firstly performs
>> rte_mp_channel_cleanup, which closes socket file for the MP
>> channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
>> triggers vdev_cleanup, which calls mp_request_sync to send a
>> message via the MP channel. Since mp_fd is invalid, error logs
>> occur.
>>
>> Error logs occur as below when the secordary process exit:
>> EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
>> file descriptor
>> EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
>> ipsec_mb_mp_msg
>> USER1: Create MR request to primary process failed.
>>
>> Function call trace:
>> 1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
>> 2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
>> rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
>> ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
>> send_msg->sendmsg(mp_fd, &msgh, 0);
>>
>> Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
>> Cc: kevin.laatz@intel.com
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> Looks good, could there be a test?
>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
>
Hi Thanks Stephen,

We have some findings for this change in our product test line. I will 
do more investigation for this patch.

Brs,

Yang Ming


