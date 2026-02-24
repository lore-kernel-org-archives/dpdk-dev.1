Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A6E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 11:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192B24027F;
	Tue, 24 Feb 2026 12:48:15 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by mails.dpdk.org (Postfix) with ESMTP id 021A6400D5;
 Tue, 24 Feb 2026 12:48:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlZEEc2GXozVU41jyg6z1rJE5t2HEbhBNGqjWcTDtRAD8xOUoH6CahAlQwUfpg9BDA/NM38pf/fjUyRwVaZvcANHUFEXgcn6P9lv5dndxpbS81biKRV+BdfzgdxbPVcbBg/VsZccCuftqaAGaHgzilkqm0TuZwoSPHG1npx59F0rlpFmtoV+LdzUwL78uNGdheVmd0kv+b5Mt8r6dJSxClENswHlOnkUdnSHu9Gsrs792/Hg/9GnhA1KRvmfMe5mMdSIWj8j30Re1TYgdo4ynkAGvDISxmCERgwebRCUDKMMs+aG4hhlxzqAZXuv2lP18OfbGovMYNmQJo3nxrbK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHVvTEoZC2uTZGiFLJSRKyjJiihq3xyG2lGXDZ0KaxQ=;
 b=PymW1U5qUVax2Oa4CEHpCDF10Uoa0M3mgxw4ZmBrJbRU92kv4UBBrxiU6k4nO0AfZ0BJ635F8HX2ETL6nTd/PTZvN++wOEVVwctofOvE7hxkEB/Q6ifpg5li4vW5T2e5cRjFYXR+HpxzSO1APCEYTs2XXtfLusS8sNk5D7z1zQpAWrlQXZHbcGsFv2sA6PyJlnmQEfaGf4iwjOSJF0CE/9dVBCBoyXkmd90Gk3Vqqd3aHSgw00U5e5bE0nBHekx3zdKDDHBwr2LvOpYp8MkNoeNl2MQG79rVw+kxtCi3IXLhhK081YBxxDTJnXrPNu8NAVsjjl1PBmMvf3YBlgRkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHVvTEoZC2uTZGiFLJSRKyjJiihq3xyG2lGXDZ0KaxQ=;
 b=mohqne5ettWbSG5L7XeylecxD7/+aX1wC+ZhdjYFILfBKtxWTTGbwywOqx5CPBPPkzGGZ3XReqmU2Im6EYV4uKZCsKMfGxpTDVkX17fPIHTl0ua8TJI+1axuWqF9LSwfB2f4A1Ftbu7f0/u9DqtyE0p+kLTaid/82fEC43KXjYdwtQcpmQCYax7DFM9QhvSYcVRAL1Q/y3zCxEdHTbIrcB+3a8Wb/+tqNleAKujEkshcmMlWwpRlHxFzJOur8vODW+mMyoXGvuWo4AYbW77WVcf4Nd6YH0BprWY3LctaTVN37ACK2r+YmjFmSUd9k1Am33WNVR5vAPpxanpakC1OAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:48:11 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:48:10 +0000
Message-ID: <e76de8e8-09c1-4fc5-a2fd-c29de29b3aa7@nvidia.com>
Date: Tue, 24 Feb 2026 13:48:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix shared Rx queue limitations
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260218081350.57011-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260218081350.57011-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a39d7aa-160d-46e9-d537-08de739a9593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFhoQ3pkOWV2YVBCcHdIN3FUU3Z1aWRGVHBXOE5pOWNjTGhCamtaRjZJdmNv?=
 =?utf-8?B?eGkzNTVEeWMzQVYvb0pWM2ZyaE0yZTFLUUxFUWdFaXRDdjZIRHZ5Z2ZuWTJL?=
 =?utf-8?B?UXJ3ajhSOGE2eHQ2VlF5L0l4dWM1MSttcGE4Mnp2SS83MUtUb2JmY1cxbUQ5?=
 =?utf-8?B?S0lkSkZFbjRxSGduOTVqMTNLRWdWTXlvSU5kRjRpVnVuQ3Y5aTl2cFIxSk43?=
 =?utf-8?B?TnNuWHJpUmRFN2pxbzJWTFF3SmRURlVJUXZhRVBiNHBneXV4TmtkTlA1NEJM?=
 =?utf-8?B?RFJZWkdJbzRqNi9MK2ErbEdWNjJZTnJiaU9GQmlJeDR5Skx4Q0MzN01VaTJv?=
 =?utf-8?B?YnZhNjExeGMrbFM0azEwUDJhQkNLZDR3RlZvVkZNT3JTcnhQZnRlanVJUUxY?=
 =?utf-8?B?MHYyM2I5bzRjd1NBUFczZHh3YWZ3SUpiMXU5dFlHRWpidWlnZjFQZ2RjNmhB?=
 =?utf-8?B?TzJmbjZKTk41R214Ty9lOG1WWHZpaS9PeEdCbENsK0RiS2ZUN3dmdi9Gd3FL?=
 =?utf-8?B?VkY1YXlWck04VTJJc3p3VDA2OWVVbzdtZmJnUC83bEI2bnNZclNkQzBSdXp2?=
 =?utf-8?B?WTdnZUFJdlA0d0NoaEs1dFZHMkpJeGxsbVdvaHZnNndpbUZLRFlXSkQ0bmx0?=
 =?utf-8?B?OTBsS1VJWWlvamlnUXRuOEo2M2lWVVBJeFpPMHhzUFd2L09hZzNUS2JOeEZz?=
 =?utf-8?B?cmI0TWEzbittSG0wVVMrNWRYQWhiQlJMVUYvTkI0TlVnTmgwMGV6SnBhcm9U?=
 =?utf-8?B?YlZvdkpSQVE3RXk4VGYxaVR0Z2JlRE9sMEFib21PMlZIbDlXOXA4SC9aZFQz?=
 =?utf-8?B?V3U3eW8yb2doUG1OeGR6UTRvOUIzdWJ4UFo5VnhpQU5QaFJjZnFEZnBBbTBj?=
 =?utf-8?B?aVV3M21maWw4R2tkVi9oaTdpR2w4RFdWTy8xcUFPS3FObGsxZWhvNGxYN1Rm?=
 =?utf-8?B?U2FYRWhKR3RHbmlhc092RGVWdXVxM3FDMUUrdlNCSVBja0lXVFgyRWtpU3Ux?=
 =?utf-8?B?Wm1ucWRzNytXM3FNb0pHZUd6T3dRSTN2aDExUlNaK01tNmhnU3E3VDh1TUFp?=
 =?utf-8?B?bmZRcG5Cbzc5M1ZSRjRaZXN2YnhMRVU1NStEOUNPMTI4dzBGdExhMFY4OEV1?=
 =?utf-8?B?NEEvaFBJd0tZMGQ2WVNicXd1ek51eGdYb25WdTM1MDRmZmRydWdJZi9PZEFU?=
 =?utf-8?B?VlFrK2h2U2F4SjA2ckZyOFYzeS9uTEFZMFZ5NVF6aEYvMVJRNlNBRFp4bWFB?=
 =?utf-8?B?SWwvVnpUd3ZyT0JWUjNKZVUxK1kvOGFpYWEvTUpQSDE1OUNTaEN3NlJOWlpT?=
 =?utf-8?B?YXpISGJ4ZS9odERxcGFhQk5hcm02ZHc3ZXRNRU10d1ljMWpEbzY2T1VjNXpG?=
 =?utf-8?B?Tk15L3EyR244QmtVQ1lNSnpzcU5rUWZPVG1Sbk5OMkJZUTNCWlo2MzI3dU5I?=
 =?utf-8?B?bkpsdEppR2xHNDhFeHBpRHV2Q2ZVZ1I3cXF6MnByVXpIZklkNHhKRS9nbkh3?=
 =?utf-8?B?WmtmbXhhUlZlZnhFdGczQ2RaWW9rNW5oRno4QU1MU3hHcHRKa0tnVWMyNnN3?=
 =?utf-8?B?dDhHd1M5MXI2Mi9oWmNtS1RXcW9wcXF2UGJLS3pmUlU5M0JVSmswSThBTCtL?=
 =?utf-8?B?Um5rcjVzY05LZzlLUVlxckZhQzVsbXFDKy9PSHZiZkJReWJzYXZrMHNxbkpa?=
 =?utf-8?B?Y1ZKd0Vhc3ZyNWFqYXljdjdnUkx4eUgrQnZQTjB5NkV3MGxzQVNuVEJRdndF?=
 =?utf-8?B?VGEwdEpNeUkvTWNMenJINmxTYm1ibnZUTGc3ZXJSUlZtak9ZMElhVlN3K2dj?=
 =?utf-8?B?dUROSHk1MXRwVUJ6cDhlTkIzc1hydVhRcCs0N3lqVDEvcTJVNjVyZW1YSFJx?=
 =?utf-8?B?d0ZPQmp5T1Nzc2ZYNmtMcXFaWm9JQm9YTGt3MnppcnBEWkdmcm9qUllvU21w?=
 =?utf-8?B?dVNScWx1OFRJeEF6aVl0N0QwRENYd3NMQnkrOVZ6bWx2QzNna3Q4UUZtdkFG?=
 =?utf-8?B?WEFQMURwaGg4dXg2emx3UElBUmk2N1M4enFuNEJKS1J2RFNOOFdQVzc4UGVh?=
 =?utf-8?B?b1B0VjViazUrQWZ1RURBQ1FCSHZjeVh3ejAxRCtvOHhkdFMyQU9hRWNLUEJs?=
 =?utf-8?Q?C9gE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktvdlYvZFpsb3NXSlJiZDlHY3FyVmhycG5zSHpVVWdUNzN6YWlCdUc0SEc1?=
 =?utf-8?B?NEN0cUlYT1NDTnpuUW9IS2lZUDhob2lJMFZDaFpXQjRYUERVVmdYSzdBWGhO?=
 =?utf-8?B?bmdDbGIwOWhKNzgrVzd6QXV0UUJjVXc5NFh2aFlYSTlaSUIwRWVTTGNsN3h5?=
 =?utf-8?B?VjdiY1BSM3Z3Ri9YOFlhbWNiaVhxcitoeUFjZnNOc0QweDRSTTMwbGc4Q3R0?=
 =?utf-8?B?Q1BtS05KZU1SWlJPV3Y5RjVRYkxFMjVLMXpqZVZLTFN5ZE41TWRzWnIvZ3pW?=
 =?utf-8?B?bTM3MWtyRldTWUIxbnU2ZG55Z2YyN214cWpENUJEbGtxSTZiSjNpK2xRVXV2?=
 =?utf-8?B?OGU0ZGlURTk4ZjFGZkZzQ0JTNUEyWG9PL0liOUE3QXRlNXRzMGhUd0xwVEFW?=
 =?utf-8?B?VEVBaFVPLy93SzYwZHVkMHBNNkJvQjBzMStEZnpTQlZ2Uzhzc1ZoaFJhNEht?=
 =?utf-8?B?VldZdnRrdW15V2tXMHZ3MjlLWDZ3TGZKN0ZBdUl1SWFzdVNRTytFQmsyaXBs?=
 =?utf-8?B?NTN0ZEp4dmVjM2dCc1J1bGJjWlk5RDJuSXdVeWxDdlY0T2hodWZRZlhPVnZF?=
 =?utf-8?B?Qk9DZW1SOHhrd1MrUnN4alM0akhvYlI3dzVVYlgwSUZ6a0F0SFZYdXIrSzE2?=
 =?utf-8?B?M1pFdUlwVnhaeGFtY3grMjRza2huU3ovNWZIbERqaGdWaVBVVUtPeDA2LzFy?=
 =?utf-8?B?Q1JZZ01tT2x4Q3lIeDZHK3JTb1FOTDlKdXNKdVpmNmJKU3JLZzFQcE44K1Yv?=
 =?utf-8?B?SmxyLzBsN2NUZy96c0NZYmc3aWVpN0w3bHVWQ283ek9oeGhBaG4xY1lPQUFJ?=
 =?utf-8?B?QnhQN3hpZzVEbFlJaE8xSUhzb1Z0ZTY2aENsWENRWkNKRitjYWxsb1VvM1Bv?=
 =?utf-8?B?empRWWlycFFaVGF0MG5hY3J2Ym5lU29MV2tmZFJXUHU4MlRMc01wOXA5UjU0?=
 =?utf-8?B?K2c3Y1VSelFla2dhYWJsd2tYV1ZFMzl5VkxTQVJPYzJqV243REk0L3czZG5U?=
 =?utf-8?B?N1ZzY0FZRVJzZGc1OWNhakhTRENDRnEvWFdsbUxPZkF5SUsrLzhsMlVkbldp?=
 =?utf-8?B?Y3ZoWWpjdlJXSStOSVQ2clYrL2tFWnlRei9SU1hESCtnZGVVdW04dXJYcUJC?=
 =?utf-8?B?TEd4NUtTaldZd3A5dldzM0pnRXQ1VGNNTmN1MWhHNW11Z3ZjelVmUG1lVHhh?=
 =?utf-8?B?UlA2SWhtcVFaTDdvdXFaRDZkanlUbFdQUkJGRnBZeUZPTlJOanQxZmxpRkEz?=
 =?utf-8?B?NnhRTk1Ecm9odmdiOW54My80NFQ1OVdzemtFNGFyTDBZYXhndkNsYUY0RWxC?=
 =?utf-8?B?aEpSTE5Pc05KREtOcG1xQWZuZjJ5TGVzbENQVWVFSjhrUi9MOFgyZFkwK2hN?=
 =?utf-8?B?alZvdnpxaHF1V1pZUnE1QmJXWCtnN0VKem5wYnA2TkZCZFZXcmlQdTJLLzQ3?=
 =?utf-8?B?ak9tZ0pqTnpUK1dWV0JDQk5hWFVXcFFZbU1MSVdJNklQVlU5aHkyWUJaQS9K?=
 =?utf-8?B?bWo3c1RRK1dGdVNXT2dGU3JaR0FrdU5RRTdrR0t3VEwyQUxmUjFMNDYrV01J?=
 =?utf-8?B?dW9sOWFzcFBXbjg5eWlBN0NhMDZLbWx5aHFobzZpclB4VkdDQW9rdkUwd052?=
 =?utf-8?B?emYrNXhyazVibHBoMXJlSTJSWDNGZ0hZcEhDRE04Vmg3VDV3OTN2NkJRaDBF?=
 =?utf-8?B?UFJHZTB6b1FwSUFUdFRCYlB4Y0lOaUpKZjBkd1huOVR5QzY5NyttYS9pdjVF?=
 =?utf-8?B?ZGVuTFYvZ3R4ZFh3U3paeXo1YVkyR2EvaUg0bWZaT1RhQm9EK1l0U3V5a0J0?=
 =?utf-8?B?THVDQitrVTl4VlkzbTJnMkhBOFZPZVZzblFYWjJqZjRoc042elJMWDFPVytj?=
 =?utf-8?B?KzU0U1E0M3h5dlI5MGhlZXhKTkVwOVY2YU0wNlUyT2hmWVBPWUQ0Yi9XZ1dY?=
 =?utf-8?B?b0xOdlN0RXc4TnovLzNaNkQ4bVZiQzRsUG9wL3NoTG1ma3M1SGlhUG5jT1ZY?=
 =?utf-8?B?MGRWSzN5emdNLzZEWlpGU1crQkl5TlhZZkZXaVNuQ1BKRWtMVWRvazdHWnp0?=
 =?utf-8?B?K1g4WlFUNmM1b2NDRXRPWCtaem02NStORlFrTXRoMTJGcnM0OUlyd25Za1dJ?=
 =?utf-8?B?ODFveWZWdmhKVnJibVdNZnY4eFhIYUpwcmNac2FoSVY1cnQwUWxwMnQ0QU5k?=
 =?utf-8?B?TFh5UVV4eFZibExFVzVmZHZBaEN6YXovVG9Vc1diUngwcmRMaFZRT0l6cFpD?=
 =?utf-8?B?UkdtVU1XTVNzYjBUZGZpeWlsczVCdkcvZzVKakJUN0Y1Sjl4cXVILzhBV01R?=
 =?utf-8?B?NTY3YWxkT0N1MTNPdVdIN21NVEwvQTVqWW81TVJiYW1LTmxJWWZ2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a39d7aa-160d-46e9-d537-08de739a9593
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:48:10.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/z0nZGBCDOwxf20hx02Lt+rgMI1yzSQz9FkmYQMK/Q042IxcFKUGsWyRF6BUyEZqA1WXDQi41zYrclgxrxIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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


On 18/02/2026 10:13 AM, Dariusz Sosnowski wrote:
> Affected patch introduced a new Rx burst function to mlx5 PMD
> for handling out of order completions which are possible
> on shared Rx queues.
> This burst function is selected if and only if at least one of
> the Rx queues on the device is configured as shared.
> 
> This burst function contains only non-vectorized code and is not
> compatible with multi packet Rx (MPRQ). Although the function selection
> worked correctly, if either vectorized Rx datapath was supported
> or MPRQ was enabled, the relevant resources were still initialized.
> For example, additional fake mbufs were set up for vectorized Rx
> leading to memory leaks.
> 
> This patch fixes that by adding additional checks for shared Rx queues
> to vectorized and MPRQ support checks.
> Shared Rx queue limitations and Rx burst functions info is also amended
> in mlx5 PMD documentation.
> 
> Fixes: 5f9223611f35 ("net/mlx5: fix out-of-order completions in ordinary Rx burst")
> Cc: viacheslavo@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

