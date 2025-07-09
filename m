Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D7C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 11:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B8A402AE;
	Wed,  9 Jul 2025 13:06:50 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by mails.dpdk.org (Postfix) with ESMTP id 1C7DF4021E;
 Wed,  9 Jul 2025 13:06:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK8ga3sYWRz/s0H/6ITfJZM31bH16UI6Z4ZBjt+KKG/ydpC0DJOkUrpMbIE7QReow0UcaGH8+iFABYd6kf5kv07iZzLmlGrxixcaZEycdjlf2mILeuftElp1NGVWwbTFG93Lj3XZGFi7r3JbYM3cQjN480XIbSTqk7TXDBnZcDgOwVFH2iFGcb991JZFJcM08qqGoBk49+hB+FqZXN2RJ+dq7ur3a17A+SX2S1x8RdaCAsxAMyQi7nal5DqZLB5N5f3G57IQY4S2ePk9rfr3zESzDxDIB9DWBVA3A4EbPUnYEBOLFd6yuC4TROeW/gnAPS/jiHZ9vcq6nGhDJG3DlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4ToYW93K6TUmMk6+YFSJTmrX7to1SOi+Ea/+QcXFj4=;
 b=O48dk1ZpwDeD2cBhUhMxUDQYqBetf1v33Kov2ppjDqPPJHEk7HVq7vR4RniEOZfFbqbK7ymQ43oCTZRlFzEaNQ9IvUiQdVF+KuJbC3De9dPd9dmxiDA9wXXVukMvE/FSV+fkSU1bg3G6HFxQ8m478vwEHCnv5zDjpOhtrzm86T8+7hMkCrBDSFBDKPxN5y5gkeq5z9SRUdZSRm7MeqmENvPqboxqKGd6x7Oe7rjheII8/+GO295PLfbCRPb/jLewrUDLTrQrkSTdsNUVLevR+Kdw7QucTCB2xHJmk32so+jMDnu0YkFzvjoKR4SRk0p+2icKm+DZRtEZ0I9HCleq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4ToYW93K6TUmMk6+YFSJTmrX7to1SOi+Ea/+QcXFj4=;
 b=b5hBPORzUa+9BwqOZAy0kACXsF0U0jJy1Fan1lheULF040NuGqDvRtERA+CbF4V2ZYHmT/fw7kLRWKlIeYTrrqpVpfZZ8avUhmql5458qHUqOKt9IFGuuRjXjQYYaEhSq9rIitQmFDu6oiimuUzI4iUGfFJgqs2gjryqfZE5E3+KyTBW5PrJWbBvrj5xZZ7H/BkCfZqSEqtdy6SX9oHon3XXQFPJrCdc74j5s0PC+UUKn9MI7xl6SEHZba1KfoRHLQXKzbpM6P91R6dCsNwFWt11+3Xjq6+p+lzHJHsYOelVcluJ2v+c5x1wOZjh1AY7mck7DVBJ2vDNH0PuLA2f/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 11:06:46 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%6]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 11:06:46 +0000
Message-ID: <bf988d67-cfaf-421a-9c2d-cdce05bf4d9a@nvidia.com>
Date: Wed, 9 Jul 2025 14:06:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix out of order completions in ordinary Rx
 burst
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20250708104641.444172-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250708104641.444172-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To DM4PR12MB8452.namprd12.prod.outlook.com
 (2603:10b6:8:184::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8452:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: ac267d76-b3f2-44f3-8f8b-08ddbed8b1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkdEalA1TGFobDRpU1FGNW1nRmt2eitqS3o2TDE2QU9DN1dGSUZiQ1RreHRM?=
 =?utf-8?B?WmVKSEl3bkxsMlJDck54Wkg2NTk5a1NiVEJTRkMxb1BYd1l5Z2c1QlNnT1V6?=
 =?utf-8?B?QmZRWHZaUkdOajVXaXY0MlpnMG5wZEpNV2w1M1pYY0tCSHQweGF5ZFFvUWNY?=
 =?utf-8?B?cDdhUDRvQmVJcXNZcC9vVkRiaDBHeS9YeURRVGVFMFRQMHViUTcyQlh4Y0N1?=
 =?utf-8?B?TlYwclUyeUdmWjVQTk04emZ2aStPcnJnd2JIaUowVFd4OVVkMWpCemhoUG5D?=
 =?utf-8?B?QmdGYUJmemYwQjNCM3Jna2N3M29YSDZac1Y3RWQrUmZyRk1oVlpHc0hBbHY4?=
 =?utf-8?B?V1dQZ1ltdEtjLzQ0bWQyQ0hYQktSSXlvRnVpUUF2cXMyVWdqMHdsZ3ZKWFY5?=
 =?utf-8?B?c00xR1NHaWt0MnlqWXloQStHd05kRVFrT3EwUDU5SHdrZDhXY1RrMVowajk1?=
 =?utf-8?B?Z3M1aVZkOStkZ3drSXUyOTU1eGZjOWVmMndnc08rR3psd0thdXlLWE1Xa2la?=
 =?utf-8?B?MDhJSWYvTWZMaHRiUGN1MENpcDYvRE1uTFBGd0hzN3JBb0JRQmhDMUZHdjdB?=
 =?utf-8?B?VEFGYjJFQzRKQTc0bWVFVUNzditRdGVNR3kyMHpMRUtMaHBUUG9uUTRTaC9n?=
 =?utf-8?B?VG8vZDhpR0dISEdzcXBwMzJJRldjMHYvYlpVQnkwUWhDald3bi9RdU0vYU91?=
 =?utf-8?B?Z05lNCtBVTVJYUNYL2VuakNZTFNlU0NxeVdaOTJGNitIaXBBUUhWR2J1MTdQ?=
 =?utf-8?B?MnRtSTdvUWxVenV4WjhuZU9Gcm80eWovRlFlSjMvc1hGeE9RN2J2b2o5WTFk?=
 =?utf-8?B?YW1nbXcvY2NIT1l5RGJVeitNWW1VWEVmcldpWHdncG9QUUtJNG51YXJTUzk2?=
 =?utf-8?B?VE8wTy92MG82VkttSXA3dWtWU2VDTFRUV0hERjZ2T1QvRkVZYkx0SzJxbFIx?=
 =?utf-8?B?WFlSWHhISmppd0NlRXpRb0VUNHllckdEQ2dCd05IWTlubVlRN3YxOUFMRU84?=
 =?utf-8?B?aDVOVFJFN2p6cU9DR2ZmSDdHU2kyZnNWdWhvT1BoRjlVWmRRL0d1ZXVTekN3?=
 =?utf-8?B?N1h3UlhwbzdQMFNoeGFjUkROZytqYW1zRkxNZThVc1VIR0FjTm4zRG04RGRB?=
 =?utf-8?B?Z2VhQnRVdFdxNVQvbU4zMXJMZVBjUWo2UGpVTFUwZEd5TTdpNysrZmEwWElF?=
 =?utf-8?B?c0plNEJVY1RxWmxXV2xsRTAxMjhQKzl1UHlIY3ZJL0lteXdwK2xtWVRKWE05?=
 =?utf-8?B?c2F3Z2h5OURPRnBYa2JDMWRIVXY2K0phbEFTTUh1Y0E2YnF6bGJhQkQ3a3h6?=
 =?utf-8?B?aVZsaUpPRUJxOVVaNlVYdWpwUUEzOVd5alFQTCtQTUpONXZhMHNVUUw1VE9M?=
 =?utf-8?B?MkpGZlM4bjU4UUFRM0x0T3BFQ0ZlZmRXdnoyVTkwNHRURUoyY3lkTXI4bkxs?=
 =?utf-8?B?SkhMYU5WSGVHam1OWk5USm9CN3lWMXNVR1NMOXlhT3B0T2Y0ZVRWSGJyUmxZ?=
 =?utf-8?B?WTVoc0V2Q0xINUE2bkd3VlNObEFpZEFhbmd6VTR3aWlYVy94QkUzRnJFb3I0?=
 =?utf-8?B?NjkrVUQraFNlVmJieFc1dDBWeHFEWTI1Vm8yck4vUFpSQ3lJRjlhVi85THJk?=
 =?utf-8?B?M2FaYm1aYnd2VmJ5VFlKSTdobk1pSUNHZ2ltcjV1Q3VQNkhFOFVIWUZuUFV0?=
 =?utf-8?B?Y2FSS09FRUExU002a3R1V2MwRzZkY2NqSi9Pak85WmZ5ZWtwSC8rWS9lR0dU?=
 =?utf-8?B?TmU5RWFkUldnR3pmRGl3dFpPWGh2QXM5NW9wdWd2eFhsYUZMczQ0S0F0SjNR?=
 =?utf-8?B?aWNwSEFMT3FCTVVtdUlhUG9HeHduamFRUGgyaExOZjFGNTRBdHM3Tk9kY0Jr?=
 =?utf-8?B?c3dnUUptS2VRalZLMDhYeDBIY3JuMEpEeDVOL3dJUjNaK1IyMzU1VFVReTF4?=
 =?utf-8?Q?HhNrO73GBgI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl5V2Y5QUtRa2pPc0NuZEdvSjc1ZCtaeHRwREllOWE2MFNhdnRlemc2RUd0?=
 =?utf-8?B?YjZ3TlRsN0M4U0lFVklsR3A5V2NsQngwZ3hWNXM1OVhjcnBJRm5jSjhPc0NC?=
 =?utf-8?B?OVQza0drVFRCd0xEMm1QcVZhdTJNYkQ3QlYxVHp5cGJDNm4vY2ZORG1hbjFC?=
 =?utf-8?B?VWh0RmFqdnBpTnF1dkJUTHVwRzFqSzd0dy9rdHFWY0pHRWcvcnFWZWxEemtw?=
 =?utf-8?B?bXkxMGh0VUc5WWsyQytDTzYybUoyRUdab2p4MTc3aWNucmc4M0hzdEdZT05p?=
 =?utf-8?B?QVFQcHFJRnhncElscVc1SWN3d0MyR2FiRE10d1krWkFjelZaNllCb3pxQm5m?=
 =?utf-8?B?WmNRRDJtMTBRUjRiTUFVOXVtN2RUUWJ5K0VuSGZrSXdWUnRzN3lrWkVUbDhC?=
 =?utf-8?B?VnJVMlB6RVhJYnNjaG9vb1FldzBzelpsTktpSkVHZm40RmppRWtJeS9Qa2Jr?=
 =?utf-8?B?SUhvTEg0SHJaNytLeGhDZzBLdXdqQ056bTFyV1o0V0Y0TVYxcHNiZjZsY0Zp?=
 =?utf-8?B?ajZjNE1RUlhKQURUaXFZdlRNK2xvWG0wdHZBMTdicXNWOVUzOXlzemhYOHJx?=
 =?utf-8?B?RHhtV1YxbmNRNi9JMCs2S1FPNEp1RE9zNFU2RG91NXNWVmxJUklXRmVzZnJu?=
 =?utf-8?B?YVBhUG4ya2xkNjRFNEJGMnNzUlV0Q2FnRi9TQ05wbWpHUDB6N1laQzkraUkx?=
 =?utf-8?B?WEQ4dTY3b0xKZWFDT3dTcjQ2Qm1VUEo1YjM5cDQ4dlYzb3hSYXZtK1QycmpW?=
 =?utf-8?B?UHc3N3BoclhEV1ZhL0VqOXliY3ZRT1pYV0tsbXdpZzM1bGhNS0FpWUxZRkM2?=
 =?utf-8?B?TGhsSUZwNTJtRjFxK1pEVEhqWVo4UjJqc2NiaG5yQnVXV0k5RGo2dE5jeVRt?=
 =?utf-8?B?WTlsQjU4R2ZINXJsYXhBWklRQWw0ZjBhUEl4aXo2aVpoMzUrbnVHNXh4VWc1?=
 =?utf-8?B?V3dqNWEvMGkvL2o1T0FWRXMwa2pyYTd0Q0xZTGZsTmpqWnlhUGNzWTlpVThN?=
 =?utf-8?B?bFdPa09ub2x0cncyaExrZGxvdzhTbGlGc3VyOGVmZDVRSjNwQXNmL3FBZ0Uw?=
 =?utf-8?B?Zkhkd2ZWbVJxcHQvNDB5Rzl0d0VSUWJKRTdKZ0p4V2ZSNWhnZDQzbXRDVFdo?=
 =?utf-8?B?Rm84ZFphUllnT05iOUNTZDB1WmY3TlR1TXNyYWI5dlR6WFdsZ0thV2hvdi9B?=
 =?utf-8?B?bm5lbzBHM3I4UDFjak1WcGRSTHNJWXVvZFpBbWdjS3ZxdUR4azFHU3pjSE1u?=
 =?utf-8?B?TGdaMld5czR3ay81MUhra0N3bkdNSTR6R1A4RFgzVktwY1JpSmpYbm9ybXJy?=
 =?utf-8?B?Z3p5WW4ycm1xTzBRbVo3TXJPNjN6aURZRDhVZnV5OVlKK2tjNnZlcnpQa0Y0?=
 =?utf-8?B?QncxNDBDNXNWZndrcGp0MFdSOXBjb1NEa3lkTmdkT3EyOFE1em5seDk1RGFx?=
 =?utf-8?B?YU0rOEtUcjFXMm9xeWdxNm16WlhlakJieUN1b2x6bENUNStyMGo3bUdDT2pS?=
 =?utf-8?B?YW1uRm9BTW81UE5hajE2RnhUeGhqK2VkMUVqbHJtOGN4SFBLNWI0MXF3UEZs?=
 =?utf-8?B?dy84Ri9iaE1RM0lVVVBBc25STmxQZzZEVm9aWTVvRGo5by80NEdVelQ1ays4?=
 =?utf-8?B?bmhzYjZ3TmdCSDZwUlQxTU1PVnFObG5iM2dJNmFFN3loNTJEZGZWSTV5VlNB?=
 =?utf-8?B?R29mSHZHMHVSYk5GNEJFRjB0T0gzNkNTWUx4U0dMVUlyKzUzdHRybGdkWXhy?=
 =?utf-8?B?cldnUDE4cGZRQW5pYm9kR0dGbXZTdEt0a3BFSS9TSXg2dk5lRWwzMFdtcjN1?=
 =?utf-8?B?LzFjL3hyTTRXdDBzNGQ3SEEzVkpYMmRvdzIxTlBuQkJ1cUhKZ0J1VDNaYkhH?=
 =?utf-8?B?aEt2ZjFxK0RVN3RoSjIzVFFYK1UzMmw0VUJMZVQrclowSkZHTWd0ZDBiLzVq?=
 =?utf-8?B?MkFXZVRyRUxXM2dwK0l5SndZK3psWDA1V0tXdUZtUGZkVnVDREdmb2xzc1gy?=
 =?utf-8?B?a0ptVjlQL1pEN2dXNkJQNGxpNVhPei9VZXJybDhMTW5kUDhlZGJWMWpNWDR1?=
 =?utf-8?B?SUtvdTNacmNsNnQvSlFmSnQxTmgzTFlUVjNKeVV3T1NVT3RWZjBzT1lUNCtq?=
 =?utf-8?Q?bfXmBYU2Bv/5wXN+ynbBV2At3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac267d76-b3f2-44f3-8f8b-08ddbed8b1b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 11:06:46.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1fNJrbvuG3xI7PU6p6BmOXwWsooIWsftVi1Ip67ej5QnfLFoHGx7dt8PVjN6ZcVM8xtISKmiAXeEnhsGUNeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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


On 08/07/2025 1:46 PM, Viacheslav Ovsiienko wrote:
> The existing Rx burst routines suppose the completions in CQ
> arrive in order and address the WQEs in receiving queue in order.
> That is not true for the shared RQs, CQEs can arrive in out of
> order and to address appropriate WQE we should fetch its index
> from the CQE wqe_counter field.
> 
> Also, we can advance the RQ CI if and only if all the WQEs are
> handled in the covered range. This requires slide window to track
> handled WQEs. We support the out-of-order window size up to the
> full queue size.
> 
> Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> 
> ---
> v2: added Cc: stable
> --- 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

