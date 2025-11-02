Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBB6CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 10:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7E5840261;
	Sun,  2 Nov 2025 11:27:20 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70]) by mails.dpdk.org (Postfix) with ESMTP id D0A134021F;
 Sun,  2 Nov 2025 11:27:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb43TE1LQzCZHHm37NyDpcDvgSVOGnfBhOGeau7IRIWIYtB8zpxIcL2aH+xXw0bsurZmEGMo9JIcJVrwhHSSOGOuHyvcrla4iCLvsm7VAn98yCFxyKI+zhon7ZtLOEVXg7cx3y49KqCW4L2r5XbgNmi2f21hzVMekPDBTnRyBlQMhAXQ6b+2g73FwPj/OXXxm7TU8pN6SAdBwdZSZh8plKJdd7FOBKMa32lH0MBdbdwlj6N9fdkqGAOeukvwX4eYIjqOznoflYdRR3mzlnorOXQyMDzs+3M8tcv8hGixRyC3YqQUt8bXlK2LIA4M9kf7Q62lLG2t7iuPcdmOJ+HoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb61Uvhb64oeJtmGGUVuAJpFBcAB+rEoLN3WT/7TDEE=;
 b=YY3Iq2McY6oFmsl06NGNcATmI+jz9KVOf22dN2GG3tOHXIi3efANrt8f3nYnBROe220QZmtVAAMiBJD6Eg9rEnoSN1mk/YFUIqFaJac+mJCvUnWCbZUkxRcB8XlMbX/75emgpmyVxlWgUs/5vi8NSkqLD3yiVB39jbxQ1D1XsgPxxlaIKuEJpL/xqYGC2xZHSAPpTlN16C690rqXjtGC00ZlUtU9gOTS6zyQ5EMKGRe6iyQgZa8x0wJQ2OPt3O7H3g2+7Ncs7c+e1gTCE+Eu7Yro1NYdEZEcsZ4x9x9+02+HTlfCLk1u13GRmzvB0n7JEV7yFWB8obpY2fHNH2nyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb61Uvhb64oeJtmGGUVuAJpFBcAB+rEoLN3WT/7TDEE=;
 b=VqwhRXCODdIqcR5/QGcRfwemhOfhkgeUbK0a6dgwjJucOpiaInhAV9gwTq/yBpn8q9k6M2IaQb7d8nXFnd34B4PyiZeSOY1SpQ/Ku8NorTRDob4UMeoOCy40EOMwPK/rjk+elliWC32f3EzI4kuotkHpCrTvQsGC3bqkSdTrILuRxLYG0auItIY5Pf4MrgDt+LSMXphc+408JNF4a2iVW+YP6FBE136R6iMsv9ei8eMV2KXiwUrJTrfC6yq1ruzHcoFjm2XT+QZSfvReJO7QBIPmMzSRPqu/sG6qdng4jb6+JJQyjk/KBg3h0E5WRi52Lm8PE5KtW2khbG67gn/KQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 10:27:15 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 10:27:15 +0000
Message-ID: <c23b4087-d539-4e35-8b90-fc8f04c56712@nvidia.com>
Date: Sun, 2 Nov 2025 12:27:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: store rxq MTU at allocation time
To: a.schollmeyer@syseleven.de, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Xueming Li <xuemingl@nvidia.com>
Cc: dev@dpdk.org, Michael Rossberg <michael.rossberg@tu-ilmenau.de>,
 Erez Ferber <erezf@nvidia.com>, stable@dpdk.org
References: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
 <20251030091313.55152-1-a.schollmeyer@syseleven.de>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251030091313.55152-1-a.schollmeyer@syseleven.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d6d57d-5ed5-4fde-8840-08de19fa649e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnU2Sk91UDA4MjFkQTk5bkhvanBsd2FVSUNHSGxJdmNqSGlWUkNRd0hYUEtr?=
 =?utf-8?B?VUM1N2N4TUVEdlowYmxQNWNBc0pFMWNMSzJLSUxLVXMwR2ZzbDNPLzdBMXpD?=
 =?utf-8?B?VytUR0NDTFFVbUFPNU8xK1Z1b0lLN25Gb2IxSmh3SEwvanhCcE9OMWEyUDcv?=
 =?utf-8?B?UEtPK3AvSzZzODJyd0Z5S2Q3dTFrSXl3SXZYM2hhSy9QSnhFOEJGSmEveGcw?=
 =?utf-8?B?KzRhTFlCS2ZrN0tOSFg5NDNpVUkxN1hCYUNCRUlnR0lncGt5MzJxV1Z6TzhY?=
 =?utf-8?B?RGZMWWdoSk55OWk2UHpZNkFrQ1JLUThPT05naXE1UlRVTG0wbnQ5SERzczdj?=
 =?utf-8?B?RFVsMVZzeU5xU1pFTnNNdjVESXB3dEZKSFdXQlR1NG5KeGErWTcvdUo1elND?=
 =?utf-8?B?enZKSVhSNzNyWkZhNGVnVWxqK3FzQ0JWZ05PVFdrUXBSWGxzUGJqV2MzRWRq?=
 =?utf-8?B?QjJLT1JnWmJmTXdUQmZlOFNoc0hEOGtQdFovTk5Ld2VlaXdvcmg5N0RGZE5M?=
 =?utf-8?B?YUJFRlpDVldzOHVNRHJsRUdBTmdpVmZEWTUvQVBPQjAya2p5VEMwVTZSY21Y?=
 =?utf-8?B?YldhbVQ3TDVXMVpYNEtYd0xza05wVldRY045bVdYemoxZ01peVVsRHlGdTh4?=
 =?utf-8?B?RGtacVpocG9vaFlrV0JUUHl0WERsSnhIWkthSWhlbGttQW9mdUxmNzV3eUEz?=
 =?utf-8?B?TG1aeWdiRDJxNUdsTTZ1WnY3cTFkMjdJaVI1aEVTUVhqZzY2U3FudlFXWUxm?=
 =?utf-8?B?NUFBdndtSzNrd01OeFg5U3dYY1poN29wUlVDUU85WFJxY0taS2hXbDhuSWFk?=
 =?utf-8?B?YzhRekdPMTh0MStuajRkaUdGd25ZVEEyRERYa0JzbHNPQmNHRXZLb1k2eEFM?=
 =?utf-8?B?T29rV0tTdzN3V0oyRzlRdmVuenAxSS9QdkF3cHIxS2loemp5Q2JBdG1Fa3By?=
 =?utf-8?B?QlVLYlN0WkhnZ1FuZjVaK3lyazgraXpOQzhWMGM1Y3FOYjlUUzgyR1N2c3Mz?=
 =?utf-8?B?K01LV0M1NFk3NlhOaGJucWQ1NUpaaVlTTmlUbHR2b21WdFF1V2cvVlBIOFFv?=
 =?utf-8?B?QWQ2WnlHUzNZRjdoVVhaNW1LdDBmWWR0REZpTlRwUzhUdDRFUkUzZFJadXBN?=
 =?utf-8?B?QlFzZmY1SU1FZzg2dHNWVmlIT0RHS3k2RlN3eldmaEY5WFlIMkIwSnlQN3R0?=
 =?utf-8?B?VjFaVHljMTRLZnZ5VW1EWFJYYkdoQXN1ZE9CQzJNSWR4dWs0bWFJZysyVWJB?=
 =?utf-8?B?L2tENC8wYmRpYnlRS3Bja0FIQ1FkaEVaOE11bU5rck5lc0NPWUtoLzZnbnFH?=
 =?utf-8?B?ZVB3YnZobWdoeWkwZ09DcFhWbVJqcitLd2xidjFkMWJYQXl1TmxwRTBLQktz?=
 =?utf-8?B?bjVreDFneCtVTmo4cEpGNk5xWEhMZ3hkaHNwUFdWK25CZFFTa2FIWHJyUHB4?=
 =?utf-8?B?TEk3K2RMVDhkcTdWdWlJVkRRNEhJZ0VGeUlkTm1IbWR5QUtKNVQ0dndIbkkr?=
 =?utf-8?B?L3owTEo0eC8ySExpU0V3WS9QekdPM3BlaTlvekl6am8zdGh2RE5Xd1d6bklI?=
 =?utf-8?B?a0FYcHhlRjdMUnJVR3pRejNCTit3cW1HaE51NlJ4bWxCdlBmSG1lb2JES2Z4?=
 =?utf-8?B?ckxEeE56Vm5YOG5Bbis3YVcxd3N4ejQyZVcvcWhTM05rbkVHZWhqS294MlZa?=
 =?utf-8?B?MlJKeThVTVNwYk45dndJRDMwNk1RanoveHpBT2JoeW1QQ2hRSVpodGw5S0cr?=
 =?utf-8?B?VlpXR3NCSmdaMWhIdmkvVW95MWxQZ1MweVNycFg4bU9wSm5BU0xPcG1UZFI2?=
 =?utf-8?B?SFdhd0IrOW5QbGEyZnV0bmZETEh6aW0zRm9kc2NlMjRCQ1Q1ZlNsakdkT1Zs?=
 =?utf-8?B?QWwyWDI2c21lZEpvSk9iS01oZGxrUTU2S3RYYkF6MTVpZjVMQzRBb3pBSE5t?=
 =?utf-8?Q?0lwcUpi8zyVpm6bmTVTiCyeWdVn5xmO6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBPQ2NWcTFXMnJ5NVZKY0l3aWlwOGtCWm1mOEovSXpRK29tSHEyeFZBMkl2?=
 =?utf-8?B?VXZrdzZ1SkpUNHRLREYreFhWZGdiS1NjRXZ0a21vME83bW9sVGlUUVZNcE1t?=
 =?utf-8?B?c1djbEcxMHJmcHdNTE0yWFNMSkJmMlMrbERPMnlOdkQ1VnBEcytLVWt6Z3hL?=
 =?utf-8?B?MVplMWRXL3RkaHAxVlRKL3JFRUVPcVZ6NktGTzk0cDd6TSt0T1paRWhSRVgz?=
 =?utf-8?B?bWdLSEJ0M3IzcGJRRUR4dXcwVXpZdm9GR0xHM1FvS0tLaWNOeGdaTmxQRndk?=
 =?utf-8?B?U29PbkNnMHZSR0plSzNOcUpNMFJDY3lWM1BCV2VMVGRNek5ET2lJZDZQQTll?=
 =?utf-8?B?YWFtWTYwSXVRdkRBd3dVT0pYTUorZkIxZ2ZZcU02V2xNdk9Oc1JMbWhLSzF1?=
 =?utf-8?B?aHJXMitHNUVESnJQaWtFVy91U3B5WFVLVUsrcEVtbElIRzFlWU8rYXRCcG0y?=
 =?utf-8?B?ZUFydHVPSmd2a0VOY1NEYVJXZ3hEMEVBV29qdXc1VzF5dmc4bDlWeU5TU1hm?=
 =?utf-8?B?dkVjNGlFSS9td29NNFovam93dUtiMmw1Yk9keUhDQXBiREFwMW5GQzJrL0VV?=
 =?utf-8?B?SE54RUYvNGlJbUFkSWgrMVJveXFybnd4Q0IwdXk3QVZxZkFQUG1zOFpScHhz?=
 =?utf-8?B?U0IyK20zSUtBY0FYTWlhdTBRdTZxVmYvaVpVdlhCdXN0d0ZXelhFZ1pIbUUz?=
 =?utf-8?B?QlRITTE2Tmp0T0dpK21WSTBXci9RazYwc2YzdGUxVzNoUzRqSGt3NC8vdkQz?=
 =?utf-8?B?bzdmbGt1MGxvTDlXdWE4aEpiUXlxN3p1WEczNEVaZ0poalZVNWZkaFJhSHpx?=
 =?utf-8?B?UjMwbytiSnNBbkRyRWNQVDRPcjM0RTdmN2syMmdqY3pPa0hQei9YUHVkZGIy?=
 =?utf-8?B?SThDUzhvaHg4MVBhMTh0MnFZRGQrRFJRZzFxL001ODZLM1lJN0RPQmswdlJY?=
 =?utf-8?B?TS9uRGc0U3h4QWJlQXRDRVhkZkQwZXByYS9MY3RrUW00WWZGcWd2aVFUMGor?=
 =?utf-8?B?UkRNRUlxT0MxcG1LSzFqYnZpVkt2S1lDNXFCZlFJemtoOHpKaUFIdGJORDJM?=
 =?utf-8?B?R1hBMTdFQzRHSEN2SHpuNXFOT1VzSk5ZeUZweEZVdFI5cjFwYUJYUUhFRW15?=
 =?utf-8?B?TUZ5S21aalZibE4veXFiRVNpTUhmWnVTdUhTTlJqNjRhY1k5L3pEZkNxWGQv?=
 =?utf-8?B?aFZvNFNqRVBPUEJGN3JvOGJmQzR4bHl1MzRFSnc4Y0U2THVkc0x4VENiTjcx?=
 =?utf-8?B?STRINjRUcWYzYU14L3FYQmRPbFFubFV0WkcrQWQvWVgvTVhhR3RJUWlyU0pI?=
 =?utf-8?B?ajBIK1pyZXJXZ1NIVjgxdy85ZjFwTllXUzlYRFZ5TnNTQnNJN05QSDdCbngw?=
 =?utf-8?B?SWl5OU5OQ2IzVUYvei9zcGJpN3lCQnJBVU5Za00xUXY1VXV6VTFWbTJtcnlS?=
 =?utf-8?B?VDVKNEQxamZsRUVMdE52SHc3SjZSRHgrKytINzV5dXBDQm5KQmViMWRxa2VD?=
 =?utf-8?B?SWRnMG1McU11d2VuRmZveHR6aGZROXY0SldYT0RxQVZUdzVGMUh5a2Y2RUgv?=
 =?utf-8?B?eEhlaWFMM0hJWlpkMTJFd3JIRjk5N1IvZUhqMnExSFZJUE5JbEo0U1dXZmpZ?=
 =?utf-8?B?YVNtV3Z0d3ZNOXBaNUFJSG1XYzd4ZVZ2NHo2S1p1NG1Va0pZK2Z2Rm1LdFVC?=
 =?utf-8?B?L0NrZWhLVk9yaXVUbDdUT0NQK3NTUWVkSWxqSlJRWm94U0d3MDhlWmkxWm1k?=
 =?utf-8?B?VkhMWTNJaHRxblhta0dYTmRkd085Wm9aNXM0YUNZaTJvK1VCaEJRV2t0NU5J?=
 =?utf-8?B?NVYvajBVbGNZRDkrQWlla080cWIzcjRRbGdKS3VMZTN3VXZoR0JOcmVIOVJP?=
 =?utf-8?B?N3RqSHA0a3QwZ0xYWUk4b2taYzNNT1dqaitPb3FrQjl4OUtoV0FsQlpLeHpz?=
 =?utf-8?B?Z2pQTCtGYTNrbVVlMDFkWXZqeVhmaE5DeEJ1eFNvY0hwL0FNTEI4OGZDR3JP?=
 =?utf-8?B?YXlCK2FURjNkY090QmhTSk5UNXRmSitONVg1eFQ2TkVWckNKZkk2T1lNeWN0?=
 =?utf-8?B?a2lQTVpaL29uL1YvTnYvZEdlV0ZYWHdUdXo4Skc5OThVSEZocjdiQVVoaVNx?=
 =?utf-8?Q?Ad7f8lVsLSSw/p/lQqhW32Yi6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d6d57d-5ed5-4fde-8840-08de19fa649e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 10:27:15.6567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFlIAKZ8PxcJIiZEiLmU63wSTWA8Qhk2mzLcwTAKAtsOQs6k8FagJ2atZtTBjbGropXEhnUTqOTkjULmHDUrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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


On 30/10/2025 11:13 AM, a.schollmeyer@syseleven.de wrote:
> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> For shared Rx queues, equal MTU for all ports sharing queues is enforced
> using mlx5_shared_rxq_match() to make sure, the memory allocated in the
> Rx buffer is large enough. The check uses the MTU as reported by the
> ports' private dev_data structs, which contain the MTU currently set for
> the device. In case one port's MTU is altered after Rx queues are
> allocated and then a second port joins the shared Rx queue with the old,
> yet correct MTU, the check fails despite the fact that the Rx buffer
> size is correct for both ports.
> 
> This patch adds a new entry to the Rx queue control structure that
> captures the MTU at the time the Rx buffer was allocated, since this is
> the relevant information that needs to be checked when a port joins a
> shared Rx queue.
> 
> Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

