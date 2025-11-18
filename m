Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CECED61A
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7893402D8;
	Tue, 18 Nov 2025 12:23:53 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by mails.dpdk.org (Postfix) with ESMTP id 27E9E40150;
 Tue, 18 Nov 2025 12:23:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMPP6ngo5kfUAeiYTorb93ajZ3NguDttjmiT5KRugS3/9pZEEd6sgpFmveBHMc/FPmaTOx8Zmq/ujavFYUFz2DgxFLxUva9U2JGKsJNSSog5+rkeEgaThivpApXQCdU42MZswZd31/OilxcE/CZfSFMg1zNek6SyFUAi3otGiT0e+R7kH9mBUIqEg3e9V5ocmpt7LKeMn2c2TtFSRMs9w6rztzGVp0y5HlhFHkLXpKEsN+QdDAs/Aiqm6NmZ63zlMJ2kiV/B9K10VAPZrKo0Ze3Vcx1ghf0wh0rSj1gIhAylA8rUFe66QWqlKf0LLcPBs41fHUK/j8VBWiLBdQuAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBu5eC6ULDuMaYcZc9nRFthXraX5tQXTpkL4DDI8HQc=;
 b=ICxfkAhpTcd9zFH/y4VTD8ZRtwbzXc7mAvnnGxUGpr232IOrNf/riwNa2PPdvufo4L66NS6GxC3CnpPoL730HCoKdBknjpoHQu3OIYOv+tKP7mOs/9KWZ/voyrVeMOEDncNrzzB100fxy1IYOPiPOiUU+w7Z8jRRr62VyuMBouQ0vxcq8f0smDRdAHh+HKU0SoL08L1+Nsc72TNqh8MqkygD1geZVER+eRql3vj+ZgZsEZu72eQrW/TTCtnQRnubS2ZQD6w2sSoohgM8NcRpomJVipYhLvJLroys0iSQKwZD2nYgxw51017inaq0b7jC/9F2KD77NAeRkTYhk687aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBu5eC6ULDuMaYcZc9nRFthXraX5tQXTpkL4DDI8HQc=;
 b=XGUG/lBLlunlqYorqvgwyr9OPUDcGbxzJbKhfP1jjmWR2PKtqgmxWVMgCTvq/zD+I1xJhPGqGCYw2VNn8rdGkM5W/NqaSD5yaOuVlpgc84CcgZcowu9CRo4invfeo6LkO7oavaO6g6k10ygpmejG/GuaoLmj5rLnAlcVBPAvR3wyhiYCoWdElvgTB/+t9WtkKZ/42cBo1Fuuo6mQggYfi0UCyIyyU+SRUj5YMhnMMEUdC/9I3fWva6N+uVyBFlkm996epmgy8aT9+F3bRajfuwD7Rzj9weRwQEjfy+qSetbGNYzbZkjjc6c3qzm3JHxrY9mAYXaavy422xN3A6KLZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:23:49 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:23:49 +0000
Message-ID: <0400d002-fcf1-4ca0-8f5e-872317e8ab67@nvidia.com>
Date: Tue, 18 Nov 2025 13:23:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix higher flow tag indexes support on root
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20251114201720.1639238-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251114201720.1639238-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: b12d5a59-c8a2-4483-544d-08de2694f21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWJnK3A4dUNkYlZaTjlmLzBKWEdja3ljOUh4MndxcVA4SG9DdURSRmNHajFD?=
 =?utf-8?B?ekVLWksydEwxVXA4dWVkOGFWbXA3d2NNNXRMdFNvNVhBeWNQek1ISTVZSXIv?=
 =?utf-8?B?cUNGbXZxMHhERWljOEdUN2FybGVwb2JCRHEwYlpYcFEwRXhnL1ltM05ySGZk?=
 =?utf-8?B?V2t6dkFIcmFXdFJINzFHK2tTVk55VTk2WVFHYkxROXBmN2QyVk01NDFKYlpI?=
 =?utf-8?B?QzRkQ3RSK3ZJWGpIZS9jUzZvZUZSYzB0NTJQUDhWMXJOWGMwS1lDWXlGTk4y?=
 =?utf-8?B?T1paNDdZMk9TQkFyQjdmRUhKWE8wTGRCZC9xSldmb0w3d0llaksvQUJSSTU2?=
 =?utf-8?B?OUNLbkk1TVI4UXZMNlJYY21Wc1dzamF6WGI0QjBRYXZscFlPYkFhczlmV1hr?=
 =?utf-8?B?UGxSWDdvU2ZIRGZubXkxNmNuZEE0MUpiNGxDN3FTNHZ6Q3FzRnhiUDUxTVIy?=
 =?utf-8?B?TU55RGlJY1pGcGZqRDJNQVhqdkMrcnZkWGxMYk1VN1dveWR0YWZlbU9FNVZ3?=
 =?utf-8?B?b0lMRXJaMkNMN3N4dmhwT285aEZqaUdhUzdVSUN2VTNaZWJtV2phM055OTA3?=
 =?utf-8?B?ckhHdWpydW92YmlkZUp0aHJUKzN5VCtVMUtMWG11YmQ1aHlGVDhYQ09NOUZw?=
 =?utf-8?B?SmJneFBtRjZHaHlDSStHeXFKTWFEMmhiTUpCbHV4N2pjNmJ4dE83c1IwdUVo?=
 =?utf-8?B?MjVpaU8zSmJlRUZMeUR0WGhSRzViWWhCWXZSNzNsV2crS0htSVZJeUNFUXFi?=
 =?utf-8?B?NWo1aXNIYkdTekxTNDN2WC9Sbms0Nmo1NkJaMUgraW1UR3VrZCtHZGJNa0pW?=
 =?utf-8?B?cURwUXlkSEFpSUt4TjZNak8vZWtlRGVGaDdQSGFtRisvNEZ4R2NqcnYzQVVk?=
 =?utf-8?B?amdBd092RldOWEQ4WXhxdWR6aWRma3lFM3pFTm1nRFloUE1yckxYQVZGTWg2?=
 =?utf-8?B?cisyQ002d3hRNVI1NHpIRy9UZEVSMHlvVm9EbXUvNkN2WFpIOC9CbExRZUlQ?=
 =?utf-8?B?dXJHYTRwUVoveGxySDAvM2M0YTZaVmwvdmVaN01TblpZQ2RyVFhXU2c2U1VI?=
 =?utf-8?B?ZHJYc2VyVUJoVlpKUFJXNWdKQUZjV0JZVGJnVHo0ZDlSMytLMG9xdTVmOWZ3?=
 =?utf-8?B?RUdQaDFUQ2wxeTdwWkdlUlJCSzEvcVp0ekkwTldGM3MwdVRVNWRncDZBT3pE?=
 =?utf-8?B?bG42cnZpM21WN0VldzBxOVVJeXdHckN0cFE4ZFM0bkphdnJkaVJKTXpLelZy?=
 =?utf-8?B?dDNYLzJuVnJONU5mbFpNNk1aaE15eWppckJoUkx1dmpiVVpwNlBCZ2ZlRnhD?=
 =?utf-8?B?R3FZZmZMWTR5NVpUNllPSGZOM0RXTHQ4bWlFRTdocGhONmZuOENtR2JJWnhi?=
 =?utf-8?B?OTE1S25CZ2pzMG9oeWFnSStQVURyUnl3TU9CWTF6M1lGRElmQ2JjLzVOTFdY?=
 =?utf-8?B?b0ZJS1pOenRCdU9GZ0VBUTN0V1JFTDQ3aGhRYTBweFVJZmdzNGNVendQOVM1?=
 =?utf-8?B?bHg0ZUwxMHlkeUtINDFMQnpIczUxbE1DNXhkaHhuaVlIenZzbDRPT1JhUFZj?=
 =?utf-8?B?Y0E0SDMzVmFPRVh3Zm5iUFlvRXdTa0dRb3llaGJqK1lpTFVidXh3WEpVazQx?=
 =?utf-8?B?UVl3OVl1eDlFNDlTajZ0TW5OWGFTZmRFcm1KZlEzSytlMzFoeFVYU1VmZWNm?=
 =?utf-8?B?NFk2M2dnZHF3VGpQVmdqVGhEWHhVbG5GcVlxRUdLcGhnNDEyZHQ4cXZqYi9n?=
 =?utf-8?B?cG9DZGFpUEZ1dm9mNTVPNmxHeE5NNTFQQUZCQWtDZFYyMDk0QVlNaW1yV2FZ?=
 =?utf-8?B?dTUzUEdjVnNleFd4blE4dFFBTHlRVDhJY2Nac0N1Nm0wT0JpdnQvZmpPK2Fx?=
 =?utf-8?B?QVU0WnlwcDhibVZuL3NZeXRma3pLUGNDaWJBVFk5eXhVUFVIVDJtc0Y1enpZ?=
 =?utf-8?Q?8y7rn2LOO/Emxb4BiLUvsAz098OQQgVk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFvNkVBQ2xVZWhFaUVtUjJBV25Xa1RSTkRyVmc1YWY0d3NmZDZpM1RLTlNo?=
 =?utf-8?B?RlRhclF2V0U1bzdENXI4R0lHSlp4WXdhdFdoejIrOE9INzFvZ3p5a3JGSEtD?=
 =?utf-8?B?Yyt4dzB5SzVuRHhsTjdhdW1HSFErcXYyNEJPRGR5U2pGTEs4YVl1VHpDTjZ1?=
 =?utf-8?B?aFVaanJaYUttdDBycExydG9lWWdYSU9UV2V0R1diSHR5VGMrQ0tybUlMZ1l0?=
 =?utf-8?B?QTQyVUpKT1JBNWprUVRHMENKZGVIUEpLRFYxUm5lS1lzTlNjRzduQU1lNElr?=
 =?utf-8?B?RUNnQzFpRTYzZmdKVVJuWGExR2VLNWRaSHZmTGZFckxKNmtiRWlpT0ozd3NL?=
 =?utf-8?B?REVhMlJ5OWVmZTRvNHRwcEwzQ2VYc0F3YzFWaW5BaUd3RkZWb045RzJYeHlk?=
 =?utf-8?B?MFgwcFpMSmk2cGNuZWtDVW1pd0VtbEVGZ3lReTR2TE45WlM3OWErN2haajhF?=
 =?utf-8?B?ajAvQ1NhNTZ6TXNWMTl5c3hGK01zYW5HOE1wZVBNd1duVjlCNW5HRHBOZzZX?=
 =?utf-8?B?ZzdGSk9yc0pLcFZyeFJGVXJibDlTbEJoZ01VYzhhY3NNbjNwRVAxMFpXQXJS?=
 =?utf-8?B?YXNreVh6TGVXempaalI1bE9nOWVXTHFHVGlIOE03MXg1aEFjRmtoUmMwaHN1?=
 =?utf-8?B?V1ZiSWxXL1l5M3VYRENkbFdlSm5JYkc5ZXBxa2t4UTduK2lBS2hmMDBMNjdi?=
 =?utf-8?B?QU92SnROUytKRW5DZkJuODl3STU4SDMvY1RCZVgxZFFVWUNQSEN3T2FsV1ly?=
 =?utf-8?B?ZGxsTGNVdC9VSS9JMlJ6WTBxeHFqbFVwdzJXdHUzelhqQml0SElQMWFrTXRR?=
 =?utf-8?B?eGJIVU1FVjZpK1RjeW93YmJKd1BmY2x5QVNWRU00RmRlL2VxOXFPQ09zaVpx?=
 =?utf-8?B?bUIzTzRXSkM4Q2VlSWl4OFNNN3RLbUJrUUhuazNWYWNEb2tiQzFkbCt5VXhR?=
 =?utf-8?B?TUIwR3c2d3JINVRJQUhMaWF4bDl1WEtWcGRrSWFIZzhlcWZzZUErWlczbXRr?=
 =?utf-8?B?K0JZRUxWYUdmSm1kSG1VQzhuSWkrQ2RVUEZwTHBnL2F3a0lWeTJaSTRoN3pD?=
 =?utf-8?B?WmdnaGdnQ0phNDFhb0lLZFN6alBmM2hMcUszQnlndmJ5WEEzRUJZT1M2d3A2?=
 =?utf-8?B?Q1FReUZpaUxSemRDQk9aUTlBV2lISkVTcmZyajFuVnNiVDNpcTB4SlNWUnkx?=
 =?utf-8?B?SEtBRXFKUGhmdERXRHVMTkdGVHQ5RnpiRXpJOEkzUkFYZjQ4VThIQTBDNElI?=
 =?utf-8?B?MVpoN1o1Z2hEVHlxbkNkbkZid0N3SGtjU1N4OS9KRUdzcGhZdXMvWTdmeGhn?=
 =?utf-8?B?Yy9DSnJXQ2hCMFd3ZDQxSlBEYWZVVktuMCtLSTNwUXcrT1RqWW0wZEE1VFNV?=
 =?utf-8?B?UW41Y2xDUFBMYmJreVBkYks3MTZNN2pSdlhJTHJDV09pbmhFZ1ZOVzZkS3VI?=
 =?utf-8?B?bmhNNko2SVhkV3FOOVQ4U0hiYUpuL1NZOHdpbEY0VFlFMVNsMjRZeGZCYW1H?=
 =?utf-8?B?clJDek8zajRacnhhVFJGZzdBb24vMW8wZTh2N0RLMXc1cnNoWUpEUFhKU2s2?=
 =?utf-8?B?VFdwbUhBNklNbjFZa3dhMjBVSmtIK2I0clhyOU9sc2psVHN5cWFFWDZWZG9k?=
 =?utf-8?B?d3RwNDBkRnhPamtoWkF4Y1hmelNWUHc3bWRZNDltU040QktCRkxjUldjM2tR?=
 =?utf-8?B?TThkMU5QcGhMN3ZEV2NNM2NMckJqSUdCbkJDNUtobjZTYnpRSXYwUnhNSWZ4?=
 =?utf-8?B?MFR6dEZFZWxHempEbjc1NVB2RHZLMXVIdUFDSDJaVmU0N3Q2THRDczZZaThq?=
 =?utf-8?B?QlcyelZzWElPTWRoUmswWlhzVDJGLzBmZllRaG51blhGUENneHNGL2VVdWsr?=
 =?utf-8?B?MTlnb2d1cnpDN0xUU2lZcStjbkozOEFIKzhuMTFzUi94a2VleDRYZGd1MFRC?=
 =?utf-8?B?V2dZbytNSkRhK09UL1EwUklRYWVja0NlTlNMZ2MwSVhzTENUTkJrZXNnbzRx?=
 =?utf-8?B?a0U2M055THJnUU1XblhNRHdkWGg5NWg1NWxLQlh4SXhIbFJTUjR2aFlsT0Z4?=
 =?utf-8?B?UG9FZm5NdzZoWTJZV1hFVlRRZjBaZmtuenlRQ2pEQXZ6OWV0ZjFEU3FUc2RE?=
 =?utf-8?Q?eW3s8VsGBR94y4h4f26+WF3wc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12d5a59-c8a2-4483-544d-08de2694f21c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:23:49.5725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITYs7eNrJiAwbL0zRZAWdMpf0JUZB3u+VDn9J3ztcaUTiHFnfqNY3M3ZU0O9Se2hGPQCyy+if8FhJglssQNQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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


On 14/11/2025 10:17 PM, Dariusz Sosnowski wrote:
> Offending patch introduced support for additional flow tag indexes
> with HW Steering flow engine. New tag indexes will be mapped
> to HW registers REG_C_8 to REG_C_11, depending on HW capabilities.
> 
> That patch only handled tables created on group > 0 (non-root table),
> where mlx5 PMD directly configures the HW.
> Tables and flow rules on group 0 (root table) are handled through
> kernel driver, and new registers were not addressed for that case.
> 
> Because of that, usage of unsupported tag index in group 0
> triggered an assertion in flow_dv_match_meta_reg().
> 
> This patch adds necessary definitions for REG_C_8 to REG_C_11 to make
> these registers usable for flow tag indexes in root table.
> Validation of flow tag to HW register translation is also amended
> to report invalid cases to the user, instead of relying on assertions.
> 
> Fixes: 7e3a14423c1a ("net/mlx5/hws: support 4 additional C registers")
> Cc: igozlan@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

