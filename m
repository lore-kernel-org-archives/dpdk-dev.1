Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD7F532D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 05:15:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E53D40655;
	Tue, 24 Mar 2026 06:15:26 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011037.outbound.protection.outlook.com
 [40.107.130.37])
 by mails.dpdk.org (Postfix) with ESMTP id 11EA24025F;
 Tue, 24 Mar 2026 06:15:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYD1+NJKVYei6kyBugoCufX6+GWbHVGoIS6K+rSippLbgeDV2FegJ7hRpHaJV3icrRkFy4UIYD+UFf4m+ONs2DXzY6Zdk8MjhoJqDL3gALjH0NlRXyqHzfeaDkmaMuQ+t5b+iykYwoHcswOMnnB/ga1DDZ1Fa/v/5ML0JGzQlTMrD0IBrp9JNspUAUwG4ta7sONJbFNAFyC/bzV4inyTm2YQkQTKEl79FBf9yADEvxFIu7oOzF7jvqCTY/ADrW3NM47eYTWv1oejqtszksXWWO6DF5jezEbSEHfE3s+z0OTgYZFoChWS4TockCk7tAi/sUUPk5zgZzDvNBwi6uARKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=kNqTsjtxMluXp5f17wRdV0hxY7246BLJGPYBVOEKyLCPF3giCtlJeyRSgxutw8+fU7LHIF8EDkpdDksa8WY7TMaVTGiVDLj/Y55zZmKWaMsvA0GmaAHXvOJdtG5PfumeIG4VWxzUwKV6+z826vhG5X9vBEBkpK8FMnI+/oAY87KE8+7bvuBZTJswJRkNEp5uEQCOPkTXWdCaO8blNOuSkNWy4OISlupuJARPCHElvD2XBGPPx6xIwztQeCQ/pkizHqGIHqMYzYgx+3AIf1tYjcaT01X+vG9dK/CLaVsbF/4lS9mDhFYGtiqmFec3Hb8ldl5rUyXoAJ2vYppK0ndHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=L8U91uNA7uDoa05Aj3UP97IYlu6M3pSLj5faKonrULe8l4E4mEaSwCpKJbHkphDWyQblYNhpd+fml/nlTldxzoMQbNn5gHjKZ2Y6tC75rZXxjJVAhg6cMQH3Jh32LBscyFq3xjP7r/qkm4sybRiuXKHAM7y0Kf3RV/wVb8KAancTyRvuFZRNz6sMJs/hdgnyOgfZpMuVlGNMk0msufT6M0WNP44PAq6rKv7So4oNRuStSO0+HPT0LGFlHFldX2/rYRZK9suiX2t7e0B4jqEpdDHHnS8j2AnO8gMj/z6SEg7xj322sLu9LIQksxfQ0f3lLZ+HfXc434j9fy/U5qVC/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 05:15:18 +0000
Received: from PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7]) by PA1PR04MB10770.eurprd04.prod.outlook.com
 ([fe80::944c:6b2:95a0:32d7%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 05:15:21 +0000
Message-ID: <18e8b944-f1e8-4c21-af9d-cedd773b35df@oss.nxp.com>
Date: Tue, 24 Mar 2026 10:45:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] bus/fslmc: fix bus cleanup
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-3-david.marchand@redhat.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260323105306.1531689-3-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PA1PR04MB10770.eurprd04.prod.outlook.com
 (2603:10a6:102:492::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB10770:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0cc17e-9378-4798-97b9-08de8964587b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 93Qs/AX/b2/EEUnI626JYDG50Mh/GPLH6usWkBGuj9lxQ2oBI7vnpKXAnLhcaAQUb43rVA5f8g/JI1uldIZ7oIKh7rALP1FudLUFUsXZgkLozQPcLFl/t4omBJcLUlsNDs1PKlkAiku5z5icDSMkoZr8tmixHicUVcGFuUrsHxSbzZh1rLOKvjDHz0OcjvEpDgDY3yro8QK/CesyM6NmcSI+JYakLUJyX+tIkGfmE4aSBIGQecLO8Ci4e9pH83ThlMDx9vFXFeXq9zrK6ddrGNCgJJEvPAPsrUDTUafSZgGXQ6TXCVgTuurWCk9cQXFN1AvqO9d7HaETNcs/3cCVbsxaKEpk1xK2SqTWwvSTDTg8IGcaM5nzi3GD5I+g4FKIL6kql9m1jkfhIMUCmgOi8tgOmYGOiJUm8dUFExjLfAelW5RNLzpR9Sn5K/+uYWqnlHsrnIhOovBWqbxC7vW4PsYJzKJLRRm9kqoEMtSHKEQC6Z+g0u37Ep265e+UjWmFaI/R3aztN1loZ8TIcOubMkoLYtNDMiV9jIzLtJYO0dgI1IaRaKkgL3nQMa8Sv2oo+YWa4THlEcaz8E0guEl5epEb8GlAqT3nxyN2gCrGTcAnHw/OrmXXQvvq5WhQsQNbQDhjHVdZtpE5ajHg/eSRVPGP8I2jKuWeS1/jKm8BKLgKARVZXvKAA8NWTQCHVvsBHgqqDhUjBkDKVgcxgU2cewguRxK6PcY6WDjs1VnL6Z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA1PR04MB10770.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTgwRlVRcGdxbXE5bDBNMlhCWUhXRDJCdmpHMUZKeXIwVll6MDZSdnE1Q08x?=
 =?utf-8?B?RTY2VVdQVU9qdXN3MWl5ZGpUcUkxU1V2a1BadG9qOEkrK0VhZ0hoWnVya3Zn?=
 =?utf-8?B?TkxCYlZVWnRVQmUyTVh2Sk13ZU10azJoeUtrYWFadkRtbzJiMGRSRi95SVV4?=
 =?utf-8?B?a2RxaVE3N0FMc2N2QUU3OVpPQUU0ZEI0UjdMSHVXUlVyVmdQYjRmbERwZTVk?=
 =?utf-8?B?VUl0bkhGMzdzNVFHZncwOEc3YkhDWFlNcEQrcVVHS2RzYXBSZmcrZ0pqY3JU?=
 =?utf-8?B?SHZQcDlHWmQyM0MxTDJQdlE0MWVvcDZvMnFkWmQ0akJpemlrWnhaTFFUTmxP?=
 =?utf-8?B?WEhkcUxLcmVLdlJuQWkxbEdiUG90RFdpK2k4UDhQOHk4bEY2RUUxemtwSGF2?=
 =?utf-8?B?QU5SejM5RC81VUdVRFVVSHNCMld2aXVZNmEwTHRNTmlrcm5EVjdKWUtTL0Jv?=
 =?utf-8?B?Q2psZmpobWVWWEZkWVJyWnFXZitPZkhzdkR4UUdBVjZPSkhlS1BBTCsrMTFn?=
 =?utf-8?B?MEpKVFFxWm9WdE42amVEQVVzUWt0RjlXai9UQnUrVlQ1bWZ4a1k0K2YxOTNn?=
 =?utf-8?B?ZnVVczJ5eDdJd1pYVER0ZFZyblk3Q3hXaFRiOTJuOEdZZUNlNEtuMTJONkdu?=
 =?utf-8?B?MlVZTEVYZmxDQ0xKbXhvMWFEQ2xSS0FhKzA5RjFTQUFmN1lUOTVyUnVSekFI?=
 =?utf-8?B?YVluS0phQzRqb1d4OFl4aW1sWm9mT2QvVDk4Y2ZsUjV3bnpBNlpkOFdoZmxN?=
 =?utf-8?B?NUVTbE1SRXdLeFRhd01ueVh5c3VLOGJEMXJOUTA1VDFqWVdmdWlreDZ3Q0cz?=
 =?utf-8?B?YXh3ZEhMTmdCZk5FRFYxYjFFWnpKVHpLM0NERlNGSXBDNlVpczErVVFWcFFu?=
 =?utf-8?B?TlVKbTJ2L0hQbmE3dk4xcTZYNVpQUXhoWWRvRWllZ05ObUE2aWgvaWtBRERJ?=
 =?utf-8?B?TjN1MmwwK0JjVUVrT084ZS9XTUxwd0llSlQzNWhxWVlBSnFxclp6em56Nlpn?=
 =?utf-8?B?R0NOOWkwZlFLNmViZy92V1FBWWZtZzdpN0xIcS9KdFpEWldRNTBPSCt5R01I?=
 =?utf-8?B?ejdMblhUUDB0bHl6clZPdzhPaEViZkwzY2hzS3hheVhzR0s2VVROVzZKZy9i?=
 =?utf-8?B?djBMTncwUkVLdU9UQ2wzWnJrK0pMZXNMcHZ4QVluTCtJZmtPeC81NllXdFg2?=
 =?utf-8?B?Z0xFODdSdFdKR1k3YVVYaDdtR05QVlNTbmg4K3pzaDFwaTBLZkZ3WHhJVVhH?=
 =?utf-8?B?T3RVK2RDMGZudkhyUTdPRzdSSEp6VE80L0xBZENDaHVsMncxVXFoRFFmNDls?=
 =?utf-8?B?K2dvemZIYlgvVWZTcklGdTJoeHBTWVV1R1lFZHNzeGJIRW1qZ3JTYy9DdTlv?=
 =?utf-8?B?dUR4bUsvWDVjc1RHdldnVGthU2N3d1RXVWVVVUdlMEF4eUVIK1Q5SWlBMDhl?=
 =?utf-8?B?d29HSlVmS1IrcHdXalpKcFFFUVlLWmhFQS9sazBxV21ncW5oeEVQUnc1OTkw?=
 =?utf-8?B?OGVBZUZTS2RLSit5SFVaeHdOa2JaRXFxNUU2Ynd1ZGtHTmo1UWhjMnZvZlpu?=
 =?utf-8?B?QzZ3NE40b3JqZFpaSmU3S2x1UWF5S0t5ZEhlenhwTTc5c1R6VWlKWmhEczAv?=
 =?utf-8?B?LzVKR0xmNWRXa2REdGhkaXVSSTRwVUtLRXhwbEtwVlRmbmkzT21UeitxOEho?=
 =?utf-8?B?UVR4L2F0bDl5Tlg1UldEbFRIMk1UNXpDWVBxYjVycG5walRPL1FzVm5aN2tk?=
 =?utf-8?B?SjFDS2RuZElmK2VKZlJaM1hDQ2xMelZwOVlSUHNBNWRZNm4xY3UxZjdrUGhv?=
 =?utf-8?B?VW13NzNrazltOVRqcWtseCs5M2gxektPQ2lmWUMvRGloRm9hMFZKOVAxRDVZ?=
 =?utf-8?B?U0F5M1VnSWZSdE02dDNQSy9jbnRKZ2YvQThCV0c0a1NEMDllZFJJcVgvZHk4?=
 =?utf-8?B?SnNoZmlaeHBvVTVyTFVKaTNzNVJlOXJRLzduRmJnN2dRTUpKYXhoWC8vaFR6?=
 =?utf-8?B?TjAvWmdGUENGcTR4QkFySGwrWXhZUmJnRVJncC9CYmdzbG9mWlc5dDVEZHdC?=
 =?utf-8?B?aUE0K2JNaE5OWUkxdnE4enJGdmJPR0hsYjdQN3p3Vy9tNzJYdkRvbTBkWmFm?=
 =?utf-8?B?cTNUaDdJcVlTMTFRWEJxV2pZbEhDNnpFYjIxMkR0TjQ1cS92RHJheCsvUHpD?=
 =?utf-8?B?ckVremtmcFdTWmNwbDlBSUk0QmR4V0tjdGZYUEE3Q2UxNXZDbjBzbGo5dkR6?=
 =?utf-8?B?OFVBZlM3bVErbHF3UW5wYlo2QldheFVyZzZva0hsMTFCSkdqVUQ5elZqUzZH?=
 =?utf-8?B?Vm0xR3ZtMDRLb213S2tOYUh2YXkzQVVibWZpcUFiSnZvODBPOURETHJPbGVt?=
 =?utf-8?Q?6cjq+XXU9nGvUbAg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0cc17e-9378-4798-97b9-08de8964587b
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB10770.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 05:15:21.0494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmcQsmMijkbhvAXQaOvA63pLya0+Eygz49/C9BJ9MAnThPcg/mq63vYDjOYy1lHZBZwcuHR7dTVse+IhUwKUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

