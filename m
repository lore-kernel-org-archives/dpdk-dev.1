Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A8CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:29:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8151240277;
	Mon, 18 Aug 2025 08:29:46 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by mails.dpdk.org (Postfix) with ESMTP id 820104003C
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:29:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suPy5b6Ifdge4MjY32BbjO+ExzN73jmCZRiG9bnkid4+08ZSP1fY8s07J+/bgDp69VlOEP1v7WhvV7QCvZXhD4iv5FrqhXBC0gtiqM8CzQx0k2znamH5tM5gaAASBKgTyRNcdU33frpWBSCQBJQ8S2Usra0AyicjT1gPhZ3kkFG3ieejY82XGJPsDJqMqjJv5OjGOSitcYdq3nkBE7ReFU5Up1PM6NoqW7FXCWNQbWZzwxL4fsxKxJ81o+Nuyg+l/EkcMSUGhpbeZC0l3x5ol6Q9AkfRuMfYf89oVx2QQWoOxBHw1rwyt2qrGF6usUatpWunwNrctba4mnZi8JThsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggifQVcBcPr3qS8lnFAINR3/F2O/+J4lTPNMNcTlBeY=;
 b=M4oy2+da+iDPjyc8AfR4Uoc0CKkeU77ZEDvrSXMHYlyRA9Ii0XXsP7UB/fjnE+AYyiD7YAw7UYai1taMtWQQWkouVTDWl6WFVir8ErniYtC4AQxRk0eJJe9J90MVBiaVL4eD0lMrxT/4KBgU77yI/rEHWkB914ldt+fe/q1E1Co/3K4pePZkOK5/lcZlaJ1xQeFhJZRrCubRMKN9rhH4/7HhNad7G84lcTB08KVBR9kpuRWKXOfoG1ofsIil+VcSuW7bj/fSy3TFcKJLFtt/cc0OcajF5cAoM6YL13XhXFdtn9LaCE0QS5hVmgt3PT6vGkjE1LV7shE1+2/eMTfpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggifQVcBcPr3qS8lnFAINR3/F2O/+J4lTPNMNcTlBeY=;
 b=jMCPl7w2lEidaG1qCFjgTlqxWQfMjrk8dGZaUpDW55MwReTF6rtML1JorxvHz69rzE+DrTxlBLoIEpjObexkz4tFH4dAwbvzUkl5QYigWgvg/SbUxur/GAXdOzLtdwOTKi5MCG3fzfnGWalj1Wv5HrhjAEfrx8Rm3QPWwkxJoCwJPnl3aDsEtyioQDbMmPAfR8iIymq0WV3txZex0NC7a5VLJn5AFrBiAN3IIzr4HSPpLaJP54hp5JC69fkKg379srWhra1uvM2ynzuoNv6zshWCWX+xs5JHbDlVJ2RvfUxSKrwnomVbDb2gQb7+sgeRM5p46y/30HdWdmbzcp80Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:29:42 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:29:41 +0000
Message-ID: <e131922d-55d2-4f38-a4b4-1b12c0c7fa70@nvidia.com>
Date: Mon, 18 Aug 2025 09:29:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: document IP fragment matching limitations
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
References: <20250718115156.1220403-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250718115156.1220403-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f57d61-c535-429f-43d9-08ddde209d34
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWJkK3MrKzJFU1pCV0xaaVB0c000OEhlRDlVNjJMU2ZOczNNT2xNSmQ0Y3Ju?=
 =?utf-8?B?d2FwaEJ2R1lqNmdjdFdlbGhXUGVrTGFjVmpLa0M2RzFSYkVDODBjKzJ4cjM1?=
 =?utf-8?B?TXNkdkpuMEpTRjdUQ3hOOFhseWIyVjc5QTV2L29KdHR4VjN3UXZ5dVREbUNC?=
 =?utf-8?B?TmhyeFZoQkNOb0xQTjQxZ2JXbHlWN1VHbmRLaHRhaVQrZW8rankvMUh4Titt?=
 =?utf-8?B?ZkJzOFBIMW50QUNHNlBpckgxYWFTTFc5U0FUYU5QVi9QZUxzbzQwU1YxOHlt?=
 =?utf-8?B?TkhFcVc3QVl0aTduTWRFbVhxcjZiTHFGSGNTUjRHb2UzVFZkWmI3cTVVR1Fu?=
 =?utf-8?B?TkhQSEZLbjQxZVRJQW56NVhNcDNaQmFJT0Nka3RNb2hkUVJwdnhISC9LMjFm?=
 =?utf-8?B?QmFEQXY2TWxvN1paMWFWYUVLWHBwY3h2OWNCL1MwZnZxd0N1SmE5djExWDZs?=
 =?utf-8?B?REhCZ0JUK1d3MlRyYklXWWNTUEx3TllaMUl0NFlBanR5QU90bTVBMGM2N29I?=
 =?utf-8?B?WjNuSEUzNHNNZWQ5a1k3Y0V6MlZvVXBrSFd2SFlNa1IvdWtKbEFjdE5qMUNq?=
 =?utf-8?B?bU9FR0hYeTdhNWNyUGM4cE1xMzNJV1NzOWVVc2xyd01XRHg2OU50T0c4d3hn?=
 =?utf-8?B?R2N3RmJJbnZoSnkwOEdpYlZzb1ZoZzl1eHBWYTkzS0FPQkRkdDVDSGFUM1px?=
 =?utf-8?B?eEkwbmJJeWZwMFBlVzVmeUFvTjlqbW9ONjRsZlBmZUNYcFZpdW4yT2VDQnl1?=
 =?utf-8?B?KzBpL0dVWUkzcUFvRzM5OGh3RkFKbVVrRVM2QUFJM3psOGpEVzhDa1ZlUkli?=
 =?utf-8?B?VURYQW9icGJ5VElpVUtJSGdGTTEydjNPRVZaSWZaOEsybkRIbnhpYmQzZmEz?=
 =?utf-8?B?UXMvcUVwNGdFTXJDVkFmd21Nc2Q4ZW9lODJGZkJ0MGZsVDA0bG9GUmY0RWlT?=
 =?utf-8?B?bFEwVXNYcWxSdXhERFdCMk9HMlpTMEFRK0RqOVdFU1FiTzlpT0FKNEcrb3Y3?=
 =?utf-8?B?QXBKOGVjM05OVHZiRDRHRGhSdjhNN051N3FUSTlNN1BwSmxRb0JmbEQwSDRu?=
 =?utf-8?B?MkNLOGluL2tVMXM1Sk9ZWkZ0VkNnMmxaVzhZMzdoektTQjh5SmR2bFpjK1lu?=
 =?utf-8?B?MUlmQ2RPNm03MzVCcVFYaE1BS1RPVTlwRllaa2ZtM2dXNnUrSEpUOWhWb2xQ?=
 =?utf-8?B?NU5UWmpSamJiTU4xbHBuSit4UDNWYUh6U1FLb3h6S205eHhYaVRKSG11dVF4?=
 =?utf-8?B?dG01UU5BbzUxUll0cXNqYllTVlN6Z2F6NnBMWHlVY1dCSHVpcWVydU1kdSt2?=
 =?utf-8?B?RlEzMVN6RHRZbC94bnpCY3ZGbUlXeTRQRXVtZ1k0VHNabVZOTzNHRjVYdkc1?=
 =?utf-8?B?UEF6czNnaFp6YU1OdEhGb1NYeGQ5SkFHdjYvc1RVdWFBNHdzUm9jL3NrTTZD?=
 =?utf-8?B?SUxKanlhUXZFZjBkMnVJOWhESGZmeThtWjB4UGhNUFNYTVhpaXdZNmxOU0pY?=
 =?utf-8?B?QWt5MG1ZRk9DYXhlOS93ZWJpcUt0YXlkUU1nam1xN3FOQkZ3SkVtODlodE8v?=
 =?utf-8?B?U3U0S2wvSTRNZUhoaFFRVDdSU1RNcFl2ZlJVQnlncTQ2bStGT0t4cVNWMklE?=
 =?utf-8?B?bTZHVEdLVzk3RkZVNTU5eEdhOFQ0bGVFa1ZNRkYrK3kyZjVrcnAzTXR1cmRS?=
 =?utf-8?B?aXhFUkxsUDdUOFNXZ2NvSmpsTFYzQkRiVmNvTGZNOGhYSEFvS1FLWFYzNXRa?=
 =?utf-8?B?Sy9rT3BvaDB6Z0RrdGo1YnFSSldOSFQzQlA2RFhnSVhObVg2UkZZYWdUSmxo?=
 =?utf-8?B?b0FOY2xxZVhSTHczb3NaNXQ2VGd3MlFDNTcvTzgvQ0RBRytyNkhOY2hUV1VF?=
 =?utf-8?B?QWxPNmJuQ1hZbHhBTjJSZnZsODFJWUR6eHVmR2VkTkZvUHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTN6SXl0RzJUdklvektmSFlnVDBwTGdEa1VjVUU3eEZKSmtYaVFTNmtkNU1z?=
 =?utf-8?B?T3VISXphdmw0bzdjaHBjbGdXYVVGdVJYVU5LaW5wSVNpSG1WWUMvbld3QklZ?=
 =?utf-8?B?RXZSR2pNaVNsRFhEVkQwYmkwVkRDalVLb3l5K29xeVdWVXpJVFFWV2tEdmxD?=
 =?utf-8?B?cFBWNEtVK1g0Um5GMFZiNi9hVEZqS3c2YTI5VW5IbVVzRXdydnd1MlNhUCtE?=
 =?utf-8?B?dE5adGV2K2ZrOW9zWGJtSFBheGMvUEVoR3B2SjFHVE5Kd3d1SjZ2NEZuWFRB?=
 =?utf-8?B?RWptVzk3aUZNSjdZREJyOGdLUWdKdGlGcFUwMlE5U3FITjYrQzRMNVNPY01T?=
 =?utf-8?B?bVpaWEdEaTRNSjB0RHg0QnB5dFRtS3FqN1pwT3Rha0hTZlc1M3h6a09vN1Zw?=
 =?utf-8?B?azQvNm5GU1pNWG1YNVVjWnhVeXE2V3J2ZEpJY0lsKzBCMnV0dW5jMUVXV2dR?=
 =?utf-8?B?WEFJRm1OZGxRdGpvR3NBOFUzRXFUSHhNdVJPYW5zU2wxU25hZ3ZaYUhIK2dP?=
 =?utf-8?B?QnVPaUNzUGpZWHFhY0tyUEpNRVFMYkRPWkZlazZqc3Vod0FEMGRGd1hac2t0?=
 =?utf-8?B?N2dmZ3ByZTJlOGVucWNVWE1YMk5VZStZM3htMG9ObXUzNHZOdCs4MitRY0wz?=
 =?utf-8?B?aHhKWmxWR1lYbDk2WlE4MjMrelRaMTVaaHUxdERNL0xzMFZCektSeko1Q1Y0?=
 =?utf-8?B?Z09uZXVXRE1jTzg3aDBNT3l1ekhNZGlSOWxteFFBaTJTOGJ5T0NLVFYrcFVl?=
 =?utf-8?B?dGF4MUpxYWFuUWd6OHJxd2J4OFFSVjBzb1pSOFhtNkIxK0VtVU1ZL0tMM0s2?=
 =?utf-8?B?bUxtbkFtSDVWOVlLRFZpYVZXSjh1S2x2VXVZWjVkc2wzb3hHQytma1RnNkZz?=
 =?utf-8?B?Y2hOc2VWYkNRbkVkSU9FekZPeUxMcDg1cUgwN2pPVjdjSzArK0ZUQWtQWHQ0?=
 =?utf-8?B?ZzdXZEVPQXo1dDBqTHZQc1BkYnYxT0dnRlNpeEhXQmRBTUZBWS9CQ1dzYnds?=
 =?utf-8?B?U3NlWWlrelN2MGs0anJGTThJK3VwTDlqM3RReUJyd2RQeUZoYWpnRFB6NUtz?=
 =?utf-8?B?ejcyZ2FlaTFlVFVwcmhjVno1cENYR1k1SDRydnZrNG1LYk5yNEszY0l0RERu?=
 =?utf-8?B?a2ZLNjhlck8wOWcrNGJQNkZlRE1Fdi9iV3hFV0VoSEVtN0Vtc1lIcE5idEta?=
 =?utf-8?B?QjZoUUtKWWFsc0V1cHFxRk9Rd09pRUoxVmxsRHE0UEkrbGNEeTZmSW5SUXRi?=
 =?utf-8?B?R2hlaEFUSUhIamlrSFVuY0QwdkVzb1JLUXlhb3dsWmh4MDdPMngvTzBPcTJW?=
 =?utf-8?B?OGJKdEdGSGlNcWphMTRDTkNzRjNpV2lUVU92N05JSkRZckJtYy9SbnNCMkxp?=
 =?utf-8?B?alBFM1F0ZHFndU4rWkljK0EySS8xekJZc0VtdTNDb3ZnbVpPemRLdkZVVjJT?=
 =?utf-8?B?YnlmenJiR1hXdUFNQ25DVWo5S1RLa1oxVzRxbkhpZ05iNjZXbjcyTTdlVHhV?=
 =?utf-8?B?L0VTdW8xZUpsa2lxK0prSzN6S0RtT3FpanJwNkowTDZGTEY3TGxld1d2amdY?=
 =?utf-8?B?NXp5VFczVDc4SmFWOEtGK29sTDhGVWFUMFlXZ0VhSDV0ejhXeC80MTNGdUR5?=
 =?utf-8?B?NGtmbXgrT0RoUzVxRHVXZ2NQV092ZU9uekRSek9sWGJKTnVUMmZCMUNBakZF?=
 =?utf-8?B?V0FBUG5JWmJPbWkzc2tSQVJsOC9tZEhuVEZxdmx6aGsyZmpHbkNtaHB0b0hB?=
 =?utf-8?B?WDlVQksrUlhaL3J4MHNUNjFTWkYvQjFmeVR2bXlmQSt1M3p5K0lzN0dVRzg1?=
 =?utf-8?B?MFZseklMUm5hbmZHa29yUytGaTB1Mlp4WE5UcXZURHlnU2l5OGhQQkRTZFlx?=
 =?utf-8?B?OVNHd1I3N1lKZGhMNXdxRmFXZGdiYWR1S2M0bGhhMUdrK3JhclJQWGtsekNS?=
 =?utf-8?B?dENZQnRhOVh0VWJKWkZvMWVwNFczZG9VU2hndnpOTloxRUV6WklmWk43MTY3?=
 =?utf-8?B?WXU3ek5rc3J2M3R2dkVVR1RwZmUzUXBSZXMvcXA4elF1NzM1eitDRXdMQWlG?=
 =?utf-8?B?bi9zMW1OMURsT1JaVDlhZjNDdlJiNHlwemZodVRIdTQ0bWJROWF3b25IMjVE?=
 =?utf-8?Q?lL+KvBzuKYsdUe7fqAA7Eym6g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f57d61-c535-429f-43d9-08ddde209d34
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:29:41.7133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9bIffZgujpDO7fZag8U9dCo6sRZmmwAooODFJskjisVgxjcuODWxih2LelYWiLEDMMdTiLIxgeLjGGnUGRY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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


On 18/07/2025 2:51 PM, Dariusz Sosnowski wrote:
> NVIDIA NICs do not support matching on packet headers appearing
> after IP header if the received packet is an IP fragment.
> This patch updates the relevant documentation.
> 
> Bugzilla ID: 1417
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> Depends-on: series-35735 ("rework mlx5 guide")
> 
> FYI - I added Bugzilla ticket ID just for reference.
> Patch does not resolve the issue, just adds missing documentation
> for existing limitation.
> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

