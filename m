Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD84CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 08:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0DF7402BD;
	Tue,  2 Sep 2025 10:04:05 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by mails.dpdk.org (Postfix) with ESMTP id B2531402B2;
 Tue,  2 Sep 2025 10:04:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk6UXFV46mWMiTyfMnkxNAVh5QBigufAZsm9M3UUG4uxYWycBCYDD1tXOBY5NQQMj3vJvS8WaEv8Wqz+CLDkTaTLz96NJbNPkMxeB2qFW493EsElTvRcBItlfh65J9evmxCLCvrFtX6UbDzK5VpCs6uZU+W0bMA/0Td7SAe904978sRbSufuL3CoSF5Sgv6my4Cwj0yOT8I7ny/SBKUgpyVGFazv/pYlo10cjaE/+F4hfEqn0nM302mk+64lcxMykHR5tRhJtwjP+VgHvjyMT0HeY4tIIEJoGaL8ppTFjEDzvTo+HaZFx8lPdSGuCHMTfKK+TLprE57pK70Iy6Uruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+kQ1UEjLeZp1LN9rgBpeyfD6hBHp2vpIhFARU8Civ8=;
 b=KLKOjvQXf4E/u81BX8fJA1NSC49uWEcdN6ODu3Z/Ebicvjg/LinhN2ZRS2UCOi2O5qeHHFnfywZPSWX1SJwXFV17sTLu+97Iq56U2ltxhZ0ZD9qP6PpaeFVVzy85Hj4oZOw+nUp1Ag7zBXX1Cd1pBDZsrQ/qHjam4oPEFJW/QZaEU2KgCHyjqKwiSS1jEU/imEe7gufVkyz+WluFdXJWiIY/qOg5ZyMlx38YbzlqP0SkPaY9Ik7uJABHBc2pph2mv4LW7SYG+BIQql4HN5vd6BPA+HLXaP0bD0l4txc0RO0OTMIq7B7JPGweF6K/WcA8/unXH12jL/vd7NLRuRpFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+kQ1UEjLeZp1LN9rgBpeyfD6hBHp2vpIhFARU8Civ8=;
 b=c80Te4C/cCeU/LxpkiSdHlIzHHmH03VgY3xLNJSRI0TgtWCtesa9JBlPevmlyxzlt0lpOYyF+6+teLTMwyf+ejB8hoVl7VeT1FnW5J58HrjaYE2XVmNyvQikEU61AUVOg1mdK1Dm2RuVv/q/oyLBgABILo6znStF7N/AIEDHyIawlYn/4lPLBZZcoIHRfo/avNEVKtxNY40525TjKlPklEl+3uL3v3Rtt5P4L76FuG9Vqu8BoVm0f3IfweJoThHB+J9pqspX+1KcH1EMBVFDMcQVq82zdk2wkntFQJ2WsbMa7Ix2pdrc+yr0enEv8AUoEz7coB314yU4kWfYlpw5ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 08:04:00 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:03:59 +0000
Message-ID: <81366236-396a-417e-ae09-530b752bc550@nvidia.com>
Date: Tue, 2 Sep 2025 11:03:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix probe optimization race condition
To: Rongwei Liu <rongweil@nvidia.com>, dev@dpdk.org, matan@nvidia.com,
 viacheslavo@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com,
 thomas@monjalon.net
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>
References: <23111985.hxa6pUQ8Du@thomas>
 <20250829053532.445865-1-rongweil@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250829053532.445865-1-rongweil@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3a2fbd-ba5c-43fe-3858-08dde9f745e4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2JOMFR0Vkd0dHNnV0pWUU9ESDluTVc3NmdIYS81NmFZSzNueERKYituZnB3?=
 =?utf-8?B?dlYwdklhUk01bjJVYTJVNEw1cDEvK2I4TjR2RjdwU1lVcU00TnExVHV5aG5C?=
 =?utf-8?B?V3ZOTUM1YUVKUmloNHRxbXdsRlhtTVFQMVhQeXB5U21zZ0RHRlpaaWhOS2hy?=
 =?utf-8?B?d2o4VWx4NUN0K1lRdXdydU1YVmJoRWgzQmY3ZDNtU2ZIZnZOSStKN3BGMC9H?=
 =?utf-8?B?Z29NaFVoa3E4YVJ2UFFuQ216eHdaL3JwK09uMHZrdFRLQ25nNXZ4SVF1dVpG?=
 =?utf-8?B?UFdYWnh1T1JxOWZZZUJGd2VyNVQveENUREViU2t6d3NKVnRqaXUvaU5hRTV6?=
 =?utf-8?B?bHU1S0d2dGlGZ3doNi9qSjQ2eXBHTWhzQkJJMXJycUJVY1BUY3RESGwxRzBN?=
 =?utf-8?B?TTNITkNzUy9VZ1BuYzg5eXkrcWw0ckNhN0s5WlBxMVR3b0Y3RjBXQ3BIa2Yz?=
 =?utf-8?B?STJPYWZtYk5FUUFZU3NlZEE4VzdURXIxR0ZGWUFDN1BNNVhTVG5qMk1zYXQz?=
 =?utf-8?B?ZC9QRmx4UlhxSkpVZFNQRlpqTGZ0VktjL2RtZDBOaHJhL1FYMm1vaGUzT1FT?=
 =?utf-8?B?ZFR5enNmVHpWUVVKejVqUjRKTEd1T1J2VnlZcDFHaG5UL2R6K2JOL21LdEtr?=
 =?utf-8?B?UmN2U0xKb2NNVWRUWFFPZmZwcm4xeTJxRlNPaENlOHcwVndWd01GQStMR2ZG?=
 =?utf-8?B?OVNPNlNwMGhxVEt4UHVNZHRVMU5WamEzMEpIdEszSWxVUVVmMGM2REN4Q2hF?=
 =?utf-8?B?ZFI5MXl6N09sSWhRSkVoMXNWbjVlTnpJQUFiVmw5VUpDZXZDdE9neXp1U0k2?=
 =?utf-8?B?VFdib0RPVllzc29UcFNOOHFGbklsMnBlSzQ0TGN5QU94RXovWDREeWhUNEth?=
 =?utf-8?B?RVZZUDVPRG5salRnOEFPQmkvTkc4ZzRzS3kyZUFyemkwQjhtekVJNjFlek95?=
 =?utf-8?B?ZTgvbTVMMkw0RndMa1c1ejE5VlRRaUo3STBidzhSWHNLdkVkVWpBbVRReDJP?=
 =?utf-8?B?bzR5UVRTbG5OYjJuVDBvdGFVQmpaMGtLc2tjelRUUW1BTmZLMGltU0JoTzRj?=
 =?utf-8?B?UXZpMERKNWV0cTVCQ09iRmhMT2w3bmxKS3NsVXVqYmFDa1FIV1c4SjhQQVB2?=
 =?utf-8?B?MVFJY29PbDAyZVZ3eUtYQmpTeHdzTXY0TWo5bWVBV3dIOUhYTndSWnhGYzhP?=
 =?utf-8?B?QkhlQWNBQUJPL24wbmh1T3pUMEJzei9LTkM5Z2lvL21XL09yZ2RUZnNZcnVq?=
 =?utf-8?B?b2xFU05PaXQ5eDF4a1BKSEM2MUFoM0hmQVNneHd2ZEJ2RnJZWW1QOS93Kzli?=
 =?utf-8?B?L3MyM0krakxhWi9ncjY0Y0ZmQnhuSm5pZ1l0dFNISDNVVTZ0VFpLS3hJZ0Ju?=
 =?utf-8?B?UzYxZ0tnMEhEZ0hacGpaa0tkeGl1UnZ0YVNNY2d4STR5NFlZTFVjK2szUE1O?=
 =?utf-8?B?c1crdUREcng3eVZTNXZ5WnBKem1kQ2kvdmtIR3QxT2cyUXA2citMSzVuUG1i?=
 =?utf-8?B?MFlYMGNqa0UyQ1J6V1VzYzJlbFZ3Q1pGM3RHOEV4MzY0Q3JNV2VwYXFGQ291?=
 =?utf-8?B?TDlqbnRxbUgydFRtakNSdVhqQ2ZjcXJnQ3hiSEt4RXQxRGNUdDRNU0JlZWY2?=
 =?utf-8?B?dytuRUxRajFkdFFnQ0FlRVZPR3NhbHNPa2xSUnh1dlhEVCtJamNyT1dZUWxZ?=
 =?utf-8?B?UXZzOFVENUNmcndYTnE0T1M5a2gvVndNTGUvUXlFZFp5dGNUTnFYMUJjNEZS?=
 =?utf-8?B?NEl4U1Y3c0tvUUZrUEZZeGhEMkNOZE1CbVhRL1hhcWFIRkg4RXByYTh3R2M0?=
 =?utf-8?B?VDhsZnpqbytmcjdKMXVsUUVlZ3l3TlpSVWVLb2hKQ2FPU3lqV051akdKMEVB?=
 =?utf-8?B?UkRuOTFaZzdjejZRWXYrWUxoZjNHOFplSi9wK1Q4aFR3dDlHNTYxM2E3dUxT?=
 =?utf-8?Q?x8yK4WfwQ4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b21NMUl3U201elF5RUZyWEUyQU1LellOMTRVRU13V1A0WDg0U1Bnc1hCRXR2?=
 =?utf-8?B?OTB2Z2VXejlPRzlaWDAydWJFUVBHQ3RMcDJsbmx0QkR0UmR1ZmFwN3RDSGFR?=
 =?utf-8?B?RCtJRXZVdmQ3WlV5ZUErR0xlZWRMMHhzY0xBUmVoQVN4RktwdFhOZVBacGhF?=
 =?utf-8?B?L3hFNnFXVW9jVHBYclVEOThKaDhzbEF3ZlZXalk5REFKNlJTbi90V2FkenNw?=
 =?utf-8?B?MVUrSFNwNDBpZFhhU3R1bTYrdDVQMXVUVnBRcHNhMkEyYTMwcExvSWx2YWlv?=
 =?utf-8?B?OUtoZy9IUzIxWWxZNHMrZ2JLTllUajZuU2F4US9Oejl4Y3lqYlNONVREcGpw?=
 =?utf-8?B?eFU5VXgwemtMa3JlcnRrQWdGeDl2MGNxc0swMXlmV05YYzhCU2JwRVZkTXhj?=
 =?utf-8?B?MHdVeVdOMmlxR0wrYzRpanRYMjM1bjRJV2t6cy9FN1REQ3dFbTVWeWFVdHZ3?=
 =?utf-8?B?ZnZFSU1pY1lFZGZxNy9WTFdmV1dtQ05uLzVuTlZzRGpIZUtvMlRGYS92d2Uz?=
 =?utf-8?B?dE1qbTErREk4ek0xVTZ4YnVzRlJmODBXdmZDVW12bHRDSHlNSHovd0ZkUTJI?=
 =?utf-8?B?VWkwb0VMVHEzREFsQzVPUlY3b2hzMHUvdVczM0JNTXVJTldlMW16eE5HYW1H?=
 =?utf-8?B?UGVkMnkrM09sZkMrTUdLMk9OeDkyWWdRYjdEVzRSYU9QdjVPVCtReU53OFAz?=
 =?utf-8?B?R05uT3JWb3FsVjg4SnZYZjJGT0FIZXQ0SG1YUW1UMDZBODc4R1g4blE1ZUFa?=
 =?utf-8?B?emRxWHd4b0xpZ2lPNkI4aXVCMGlWZWM3cUIwZnpYNHJucExNV2tncGhnNWdB?=
 =?utf-8?B?VUhyZkhtTmduMWV4Q0M2RTlxWS83emxrS1ljQ3lFTEtMdmVWRkNzSVgrQS8y?=
 =?utf-8?B?TGlneXVVQ0IrcVZxTWljc2swOE9zNk1FbWZiaGorZmZIM0VFU1NtcWgwdFFL?=
 =?utf-8?B?VDBRUFlIaXBSeHZjQmZuRUJjK2xOUW9Kc21GbVg5b0prVEhQTFU0Z1NwamFy?=
 =?utf-8?B?dVoxTGhkTTdkMGE1OXprOC9Ga2d1bE1oVTc3dXdJa0dIM291OFFzaHd2QWVk?=
 =?utf-8?B?dm5Ec3pRaVlEazRBZWhMaWxtRlZ4dTB0emVpQjZETzIzNnNHdU8wQ0QxNzhQ?=
 =?utf-8?B?Y1loU1FLeVE3Y0Q4OVlYVGRKMFZGbDFHMVBnbWpqOGJpRWROenhaTHZLbGlp?=
 =?utf-8?B?V3JPcW9XZFRnTzRSbzFrTHRaN2lKT1RyZlU0Z2xSbWdzSlhHMXJ5bTI4VzE5?=
 =?utf-8?B?QWRCSXhIQUFRZUZiQ3pJTW9iZHh1Zk9CQUZOd05YZDBtZnlVWWtsbnNKRlVt?=
 =?utf-8?B?VTR5MURpa0txN3hhbGFxdUg4SXRuR3M5NHl2Ym9Melc5VU81L2RidWFPRURh?=
 =?utf-8?B?U0xlQXI2NTdPenU5a1pxT3BlQ05OQ2FjUHFpNHhJZ0lsQjBDRHVGSGM1QlpP?=
 =?utf-8?B?WEQyYlI5SlFYUXQyMGx0bnRuc3gxenpUUFVRTkQ1VHhCYkhRNVp2RDhYNEtL?=
 =?utf-8?B?azBiZWdjWkhmamhQWmxTbnN5UDRHUThhRmxSWjk5L2VoNUpBblAvU01mMjBE?=
 =?utf-8?B?bEN6RU1hQ05jTmw2OTgwWUJGakpYRVBueUNsRmM5QzlraWdLamorSE8wY2Zk?=
 =?utf-8?B?ZXIwbXdzakcrMlA5NDF2ME9DVk4zT3VDVDZQMWpVeVhzYXh1Sm5YdHBFeG9h?=
 =?utf-8?B?OUdLMG9BZDJWaUp5UWo1MTZXbmVSNUJjOHl0ZE5NSlp2eWlVbDBrNlVzdGJL?=
 =?utf-8?B?dG1MVUFrOEV3STNmYTY0T25BR1ZmZFQ2ZTFSZFJoK1dsMXNPQ1BkNWp5OGhu?=
 =?utf-8?B?M3ozbUk2SDJqVFF1akxBZFVWVTltV1pycEdWS1JySkp4ZzVGaWg0MmZma3Vo?=
 =?utf-8?B?bHFodUQxQUN1QXZ5bTZsdVQ4TEdienRyR3FXQ2YvK0ZiVlRLRlFJVGFYMnFp?=
 =?utf-8?B?ME5rTzlUTVozcW9HbzMyM2RNWXVhQU5LTzdmdk5aWEpBbTducm9WQ0owZHNU?=
 =?utf-8?B?cU0xRnNXVEZvSy9tMGRGcldtdlRGUDVDbWF5cjhtQ2tJYlJ1cUhjVUpjWEdh?=
 =?utf-8?B?MDlCSmFtK3ZTeFB0ZXZaeVg4SWFiYTR3SWVsRys2T0pZamJ5S21SVGs5SGlJ?=
 =?utf-8?Q?R8ES7N9Kb6oIVMFh5vP+cLTRy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a2fbd-ba5c-43fe-3858-08dde9f745e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:03:59.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P34mRLGfS+XslrS968lLxOIk7KTJNDt6nKuhDdoqPwN+aAcdvJbnzUxPryihQO59f3ksuiWkTvuCDbOKMG7PNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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


On 29/08/2025 8:35 AM, Rongwei Liu wrote:
> With dedicated RDMA link monitor, there are two threads
> which can update the IB device port information.
> 
> Add a new flag to avoid the race condition. Update should
> go through RDMA link monitor once ready.
> 
> Current logic is:
> 1. Update all port information in probing thread.
> 2. Probe thread initiates the dedicated rdma monitor thread.
>     Once ready, port information update will be handled by this thread.
> 3. Next probing won't trigger PMD port information update.
> 
> No lock is required.
> 
> Fixes: 51fb5c40c826 ("common/mlx5: optimize device probing")
> Cc: rongweil@nvidia.com
> Cc: stable@dpdk.org
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

