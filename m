Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93EE0402E2;
	Mon,  2 Jun 2025 08:47:11 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by mails.dpdk.org (Postfix) with ESMTP id 896F1402AB;
 Mon,  2 Jun 2025 08:47:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+vGNnNdjWat37Q8mKewZb6/Rny5PrVDMbAd1f+ps4qaazpYkz+vKqUJRfPwP4HaQ6TuQWHSTGrpEddFU+tWA5vc61gc+1moBXIylwIox9Bhf0PZOr0vYyWxwbcp8Piuaj3LbRxCDLe6oXpci+vFTPVWLHF502Qdq6RQ6WusXWZljM29QKUtBgyaXY9S+/bYNGIPl2oqy3QJYUmooNu9CYeUSOCp74UVeDI9fBxAmJbwYmPyZwf2JMG8B6zDALbRZ2oiDEL4sf8+tXdqOKAW/+J0gaxFgsWYimTub64DMCCElT5UkDV2KRcnVfA5PugezNykaGKH3D906zNN0vBL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aiN4mHBvD42xqtf+RHrXvr4MOZXpocCNnlA0jq5JDU=;
 b=PRDlhHjCKKcMBtME0pAszMlOarLRwnL+H30s/ZKTi6z1aWJrDGzbN2yGnjUInW0692MV7cy7vVjBajaLKtQC/JAhdu5/ITNF1cdGS05cMSEkbZaUtvuG6TMvzV3l9wTXx50eiAHxPTQLVswn5AK4SFDtqByajp/L5nHB0zmCm8aGY4J6iK/JUziW3Mq5FMBo6GLWuTg907WnoSXDQGVyP3NSbsAHR0ZPg8rUaRcPk/F0VlRL4jZij8WTh4tgfD/GdAJDD/i30fWSMgVf0oVacevBosOEuP2wcDDx2Q/YBB3bCIB+Jbf98+w7s9/kgCUqxmsZL9t7GSh1XsGDVdA5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aiN4mHBvD42xqtf+RHrXvr4MOZXpocCNnlA0jq5JDU=;
 b=gxhHh9n+aGMN06zupHKjayDAf/v2wT5BTpZcqUTpeBHQKieyDy9x7ueklFoQvEdjS5aLhqXQfsHbPsAuiKoztQWEWEHPr4cG2I6mL9I60lU5YM9McagUlvTYTzgii2PRjdqskvB0y0u8RNx0iIGDm817IGKeXZSBKD1gOdrFd8cL8IkUtbhQtjW9eXl6hUwnx7xp210GKde6LEnBz/YQEBbwej3UjNI3RdvjuDzlGRA1MeuiTzY8qDPz+NbhZGzwdahXmPXdhh6DMgwvuE5dYoI+zP7VJFgF1N7v0ANd1Wf+5vSYO5Ivv41s2mSRvUrO9YDZMBPRy+lMRsqblI7BUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Mon, 2 Jun
 2025 06:47:05 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 06:47:05 +0000
Message-ID: <cd318d40-7aa1-49e4-9a20-7a92d58dabbd@nvidia.com>
Date: Mon, 2 Jun 2025 09:46:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix VLAN stripping on hairpin queues
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250425194913.70742-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250425194913.70742-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b77c03-dfe0-4b07-7a8d-08dda1a14973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmhjZ0RFUzdYU0F2dURlRzhJNWxxelpMT3hWTDlDU29jSFBTSGxleEdVRFdJ?=
 =?utf-8?B?TUdqUG14Zm1ob2dzZEUxRHd2SlcrcUxBNnA4RE94UkJHUnVHZVcrMWhzSnRM?=
 =?utf-8?B?Y1JFdkVXZ2lPbzFjM09rWk9HdGFoRjc5S1ZyZVM3MXp3OVZlOG9jYjBSUFVq?=
 =?utf-8?B?T0VBUjRoZ0Jxc0N2anlVbHpZcTZySzk0RGFtWEV4ZCszaElPamdJcHJsUkc1?=
 =?utf-8?B?OXpYY0ZOV0NwbkhoeEMydjhrMFBJY3RRWWxYTmJhd3U0NmhlMWxmZVBpOTRo?=
 =?utf-8?B?VVBHMkg3aStvZmJ5T09FYkt6VWdKNXNTZVpBMHVadUFiTGRCR2pVVWM4N1hm?=
 =?utf-8?B?SEg2WTAyYVVhcTE4RmtFa1JDWngvWGZnbTVmWWhGNGwyMjdhOVlXK2pPVmFC?=
 =?utf-8?B?ZVZiUzZiSDdaK1BremV2MUw0c2g2aGQ1WGVqeE1HcFBwTmR3d05kTVdnVlFW?=
 =?utf-8?B?YW9FRXF2RlJWSlZRNWNSSUxTY0Y1Z0hMbVhCcWRRUndVLzJPMzRzZzNIRFp3?=
 =?utf-8?B?a0MyN20vclVlTTNBLy9aSEQxRDlvK09tTkw0VSttanUwWkNtVnlnclZDTEwz?=
 =?utf-8?B?eEZBUHFVOXViNWtsL0xxek53OXRWaWkvc0NvUFRrbU9CTFA5S0w1dEJjL0h1?=
 =?utf-8?B?TzRyby9qWUM5V1FXUjl0QSt1OFUwTWR0OWVaNU1TR1puc2FJSzFKaWlmRnhH?=
 =?utf-8?B?RTVqR2k0aW1OY1JUcXdYYUpyNmU2OVNzK1p6Q2ZBUzFHVnBKbTdEZHl4dVh1?=
 =?utf-8?B?WEcwRDdVbUdFUEM2ckwwRDVQZUxSYUthYVJ1b0NvdkZVajlvTDlFZTlmWGZL?=
 =?utf-8?B?YThldy9Ebnk5ZnFXeGhDcFVkZStUTldadmx3UERwYkhCbENwcTh5Z0tJalEv?=
 =?utf-8?B?dEFtREtpK2FmMi9KOWxsYmlqVGpndzFwY1RMOUwvUmlqUTlTUXFPVmJRbHdw?=
 =?utf-8?B?Q2tOemFnNTQ5RkxXTDlSM3VvK3JuaG5oUmsyMWpKS0oxeTRxNWxUK2FsM0Mw?=
 =?utf-8?B?eFhvbjlTRnIveFdITEh5djFZVkd5bXBiSUZuZU5BdFhKZTN5cDVpcEhMekhh?=
 =?utf-8?B?bU93S3EyQnJxb0dJQ054QnQrWWNxWm5rcjVvYW01Zi9yaXJRRVdWOTVaZzdz?=
 =?utf-8?B?bmVWV2ZYQlB0T1MrMzVnZlpVSk96d1FKK2cwUTRXUVlXcDR4MUhnR0QxekF4?=
 =?utf-8?B?RFVqeDJtam13dDdVeElaYlJaUUUyaUhFb0N1TGs2YUpaUkhUU1RpN2J3U3ds?=
 =?utf-8?B?K2MrNlI0Q2ZGR3pEUzVvN1JRaTJpU3hvTG1CUU15WnpXcFh3TWV3NWtJMjFR?=
 =?utf-8?B?VmEyYmpzcTZhNTJsTG5ZWjVZN2lJeGVrZkZ4K3ZlM3lPMEU2L05DWEVBRGpk?=
 =?utf-8?B?V2xTUEdNVlhOTWlXSHdQaFpaV2JIQjdJbmw2aGFDbmw0ZDhLRGV4VmlqOTlp?=
 =?utf-8?B?MkhrNkowVHJ2eUJCa0FKengwRlRRMkQxSVB0VEdLTldhUTVRTzd1c2hXS0Ft?=
 =?utf-8?B?Vlc4Z1o0SkF1Z3Q0QXQ0bGRBNzNqS0F6WEozRE54SVY4czVRdzhKaXI0ckJP?=
 =?utf-8?B?NDdGRWJKTjFCMjVsK0pubUhZcERKVWNVWVRWZEI3Q2Z1WCtaQlUzeXpTSTNn?=
 =?utf-8?B?TzdnQXQwVG5ZQml3MDVBZ3ZYTjRQYnhFaGU2M08yN2lpT3J0MnRsMXByWVhX?=
 =?utf-8?B?d21oNkFDNXRnRUZpb0pCTU50a2d4Y01LVXJ1RTBTdnBvWGNmYTlGeWkrbVdm?=
 =?utf-8?B?TlNYaWcvelh4V244bEpqYWMxN3lqclVITWV1emh2UUpxOTV5bTUrYUwrbHll?=
 =?utf-8?B?SWJrUkdQeXdIVXhiaFpwZDRCV1ZVTHFUT05NRWFhajNndVNTcmRsK1kvQVYx?=
 =?utf-8?B?QTZXWjcxS1piM0p5a3pZbTFzeVhYVUpCNTNqbW5WUldPOElubDZBTk5JWnVQ?=
 =?utf-8?Q?/UaLnEv8leI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdIbUtFMy91Q01WMnNON2FGOGdabzNVVGxrdkZZWVpNZk55eEFhL0JDOTN5?=
 =?utf-8?B?YXp6U2ZSVG0vQ3VnYnJyTkRTNStlZ3dOVkVPYnpKcGtySS9OWFRmZ0VpMTdI?=
 =?utf-8?B?czFuMWdleGdIajZMYUhacWNHazJqK1MxZkx4OXhZdDhpUENHL2dac2JMbjcw?=
 =?utf-8?B?THl3UXczOGI5c2hNMDI1QklXZkxoOEI0Sk43L2p4akVRYk1uQlpsRXFMTmx3?=
 =?utf-8?B?b1lGb0RWanNINkFzR1JDb051RmhyZkU5MHFBdUZqR08zdEpQR0U3ZXJzd3BH?=
 =?utf-8?B?c2lOZ3dST3kwOTY2b0JIUDIveG1qK1VmSlFIVGFDaGJta1UyN0UzZm1rcXVK?=
 =?utf-8?B?N0hndlBVRE5UVmtyYlhHb0VXSDVMQ2diR0FURG94Z2oxM2h0WFdENkt0RWdv?=
 =?utf-8?B?RnBTd2ZFZGJqUVRISXAxY2JMYVZ4RkZjcXh5U2I4dzBqMEpHSXZZRjMrYUho?=
 =?utf-8?B?ZnBCL3FiV0wwb01UQk1WUWZjbDlISUZNUDdTb0tEVmhTMFg5bEh2WjVXUWt2?=
 =?utf-8?B?QjBSdTNsRSt6OTAvd1M5cHczMUd1MXVBc0V6WU9TTHdYUGRsNzlqTGNBZ0Fm?=
 =?utf-8?B?TnRxSW5jRWx0UXF6bW1VRTcwTU9SWmZyU1c3dldEd2RNcysrc2pLaWZoZVg4?=
 =?utf-8?B?ekdvaEtoNTQ4NnkwNlFldmZZNzRYZEUzOEk1cklMWldzUzV5WEgrTjBVSTZn?=
 =?utf-8?B?dnd3Y3huOHJqRVVDRmlzem1jWXpJMGVlTVZyOEdidmo4RFZ6K3FyNEU4Ti9D?=
 =?utf-8?B?dEo2ZkdieElUUTV2bWJCeWVZMVQ0Nkl1WU9seHFnYlhXeWNMaWl6S0QzUG0y?=
 =?utf-8?B?TE5Jcm9INkpvZjNGblk1YXU4dm0wVHhIVi9EdG9aRjJFU1BjZjJ5MlQzQTBx?=
 =?utf-8?B?RnVZWW1HY2V2S1NCOTlheWpoVXoxQkJuMFVkblQ0OUJHSEtQWUh1VlFldHI4?=
 =?utf-8?B?ZFM4bmxxWlBTdlZaMC95V2xJRFY1QTJEbE5sMmRxUU1SWGJXZWlyNFVrQ0tk?=
 =?utf-8?B?aFpJZnY0aWFwUXdlRGpaRUtNMDQvY2xqd1h5VnpRcVlmZERxMUlyTHZHcisx?=
 =?utf-8?B?MzFVYkM5dkRmZkN3RmxpUUpwVUF3L2ZRVG9GVXMwdVBUTlBwK0I4OGFzRWND?=
 =?utf-8?B?a3BsOHVuRDZmVjlTNVRWUXBpSklLWDZyajFhNUdJRHBuakhhbXRTUTRmaE1G?=
 =?utf-8?B?R1dOWmVGclV4ZWY1SHgrL3JOYTNBWGlRSnBYcGd4bEduc00zMFpocE55ak9t?=
 =?utf-8?B?dXJaRWVaNDI5ano3MHYxUEF4bG5NZU0xakRiNmRNK012bVR1NGlZb1NIMEY2?=
 =?utf-8?B?UkFqbzlTbmVxTm1HYmpma1dLcTY4TXFhMENuVkl2eDVYeE1CNncrbDFib1NG?=
 =?utf-8?B?blhYTElTcWp0cG83azhOZllKSFhva09kK0l6dDlHSFlJY3ZRWTFldGVWdHB4?=
 =?utf-8?B?SHliQ0FSeStiMWtaL09jL04wRjlNcEIzWnk4U3BzalBKQkUyWXhPUW1QUWpF?=
 =?utf-8?B?RXU2V1VGTjJ0cUNXbEpkdElrc1JpZ3VvTWFnWTVxWW5QdmU5bEZPZmRoNHlv?=
 =?utf-8?B?OUJWRjQ3L0V5ZWcyYU9nK0ZUMXl5a3dTMWZNZ3FHNUhnZ3V0M2RMZzlFSTU0?=
 =?utf-8?B?V0dZRWY0VU5hOUtvSk02TXVyaDlmTE5Vb3lqckU4TXFHdlhVdFArcXNTL2Fm?=
 =?utf-8?B?UW1PbGpweFlrMXdISitGTEJUaVRNZmZmRU5HS0tZa3djaTFEZWI5dldwUVY0?=
 =?utf-8?B?ZEdXMDZOVmdPT1h3T3VoUjd1ZDZxOURMTDZGUUk1eUc0OTVMS1E2Z0txTXVY?=
 =?utf-8?B?bEt4R0hiakpkajBUK0gyeVJRcDBvUmxKREVMQ2xVVjE3U1E0T2ZKMWRwYnN6?=
 =?utf-8?B?VnNxMmZDQXl6dm1tYmI1a29POEpYSHpUVGJHZFdJSE1yOFRCMTBKNWtvUFN4?=
 =?utf-8?B?K3U5elo2MnhqaklMZ0VUZ2gySFk4QS8yS1NEMW9aRlJ1cmJhRE9MQkdDZlY2?=
 =?utf-8?B?ZUd5ZjhRcFRESFdyVEhwMElyNm5WSGh1cENyZEl4bXVicWQvUStUYTNxMnhJ?=
 =?utf-8?B?M0gyQjYvbGtnc2hPb0o5cW93aTVtN2tiUGU2dUJaZTRHZXhPUDRwMUFWUTE1?=
 =?utf-8?Q?z/6kSXZCmIoLKPW+tEjwwWthK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b77c03-dfe0-4b07-7a8d-08dda1a14973
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 06:47:05.3934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u2g83wh34RjDsCpSe8T1ncA0ulXd58l4wDbfrykj3F4esDq7UUWUePAX3l0MbCmDpSdjarxftGdD8KwPL2DBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

On 25/04/2025 10:49 PM, Dariusz Sosnowski wrote:
> Rx hairpin queues support VLAN stripping,
> but if port was started and application attempted
> to configure stripping on hairpin queue,
> segfault was triggered because of NULL dereference.
> Underlying function, which was updating the RQ was passing
> wrong object handle for hairpin queues.
> This patch fixes that.
> 
> Fixes: e79c9be91515 ("net/mlx5: support Rx hairpin queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Patch applied to next-net-mlx,


-- 
Kindest regards
Raslan Darawsheh

