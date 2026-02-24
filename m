Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFAAE9B25B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46EC24027F;
	Tue, 24 Feb 2026 13:11:18 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by mails.dpdk.org (Postfix) with ESMTP id AF7E9400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:11:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3Xf3c7HSwkQ67bacjrvYgkSSGcMj64/FpqTpCwXug9JRrfXP/gBXBLlJX+nT5nU+fzomtMXunj/P9Zgo8lRS/ruOhZM+Ru/Nhc/Yi02JRz7iYfgKE1IqfxmcSaMiIAFALuYY7dwNeuUOGrrsPtWWOUO3u7TiNW6yOwniRWowbKB/CyZk5gY2UbPvs6nn3jxlWhKAeI1ZF7RtnMZlfUTzbwSd1SSzBy7Bz1DpUN4x0fMdfWZCOp2BGyJD66K2N1+1NGC3GJQItxbo+Y71X3Bi/Ne0a1gr8ZvLgCq/r5Dyd1dIadwvR8OpHfQoJfx8deovV2o9KdWvZErtL1ucUbAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33/NVJctnUV/GQfKg6zLDkejk9A+dodiL4sHqfBXgu8=;
 b=K65fPrHLur8l5zRUOAVJaQddYwQjSfHb1Ul+nfXF0b9EbkW7Fdj/wa9TQ+FYIkYRMMcj7YMudZhFf+4o2u4T+KqcpRFJvGhhkzTjPdAxVrO+UnqJr0rc5Lg+FFsOM5CNYDgc5R9bVLosnJXmq4R2LzummWQKugjBDC4nboF110XolfQN797/9ZnDcQJERqzgD0wrlSBe9bXDvF3JOxPRU7Oyhf/r55RzbjqQRBG49oIW4GhekgVog+6WFYX7m8Xcgsrqw1Q3zzRK+pUPho+M5lCMbnXNsgELisxvX+UcRaxGIFsBiRP6qBr9JOgUjJkQdgvIQhmjNQvLZq7nhG/pmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33/NVJctnUV/GQfKg6zLDkejk9A+dodiL4sHqfBXgu8=;
 b=aHR2HwTi3I5UW2FDQkuNBe3oUnRk87ysiMXyQlo/2aoxbXCYstFWzgiYVtNrGHKQMQZ+KwLa73nk5G9v5ABg1CRDwLg4Vsv7UJ8I3hDCVUe5OPhRIVn3CM6d4a1ncvg6K9JToRz1QGEErFcznKONJZuuo5PtPXbWzyFNqrOcXSo0DAwmOdMIii/dHXf9d5l8k9edpI2PJVOxQReF55B8IfAS11Qyayuy4JRNKpt3Eqwf+AV6TuCmTeeN9ga+F0/vFnITlXeiiGIs/gPqVpt7ungVFRYkJJmDD5by0NAHP2HUk1qZCpJV4nlcrFMbFA2jbbB8ROFct73v+S8e9Z/QFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:11:11 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 12:11:11 +0000
Message-ID: <353d6769-1905-4b4e-9007-3c1a89bef32b@nvidia.com>
Date: Tue, 24 Feb 2026 14:11:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/mlx5: clarify device FD closure in mlx5 guide
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: michaelba@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260210144654.96538-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260210144654.96538-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To PH8PR12MB6747.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 518b5ff0-16d9-48b2-2cf3-08de739dcc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmdvWlJReEtLeWNzNGFSOUdvbHp5bjNoZ0l2NGh1QmFwcndJRUZ2RTlEeSs2?=
 =?utf-8?B?dXpKUGFmbmJ6cklheisrT3h1SmR1c2N2eTJydkR2Y2JHTUJTL0NyRDZmRkk0?=
 =?utf-8?B?a1JTUmlsMjRpR1BKbVAwOFJTQThFVlBpbVhTNnk5emVRak16NzJQcnRjbFVC?=
 =?utf-8?B?cHNEK1pJZVJ2WlpGRU1ZTGk2WlhESlhqbS9vOEEyc1VLYnNCR3RiSUMwR3hJ?=
 =?utf-8?B?R1o2TmxVWUhjYzFPVmVzSi9qM0g1L01ZR0R1WGJ5aDU3Y2REWll5aVozWE9p?=
 =?utf-8?B?aHFOS2VxT0JGUU9aN3QraVZnU2FnbUNXTTY4VE9vcFN6WHVuakNSbk10OVBN?=
 =?utf-8?B?Y1BWWHIyOU52Yzh4SVFUZDdyaG81VjRZcUs0ZjFFZW90dzZFTWxUUDBuSXp2?=
 =?utf-8?B?bGs4S0V1UldVeURtMktUNjFqVnpHaWZrVG5mUnljTGhPQ25ueUhqRkF4QVFC?=
 =?utf-8?B?bTBSYy81bEYxVEhyRFg4MXIzc3ZBaTFXQ3pBbUhqajRyUjE3b2duWVo2a0k2?=
 =?utf-8?B?OE9hYnllUjJGSlVWYStPZVRWMVZlSXRyTjY3TnpLM2J3UEtDRXBUZERYM2lt?=
 =?utf-8?B?MUVyNktQc2lJaUJqV25zWXBiL1JvM2JleEU4d2VDYkdrNDdOUUlpa0xKcGpr?=
 =?utf-8?B?My9FTE92N01mVzF2eHJFM2U4RUFzdWE3VjJJcmRGNXFUa1hvZnhFaVJvZDdp?=
 =?utf-8?B?aldKTWttWHdUck9zL2l3RjJId2dWWW9pYmZJdC9ocDZhY0l1eDM5MzRmWkM5?=
 =?utf-8?B?YXF5Sjg2R3E3Z1RwZlpFdkVYbVVkazR3NUtydFh4SVF5ZFlObXI2WFBGVGVQ?=
 =?utf-8?B?QTI4Q3dVZ1dWU2tyZEhsSkdtc2RBUU5VYmNwWEY3K242dUZVU3c2R09pOHc2?=
 =?utf-8?B?U1MzMFFNZ09wNDhFQjVLcmpIaElVeUZ3K3NvTHdWUnc4UTNIY29BeE14TGFC?=
 =?utf-8?B?ZXdHU1ZYcDhzYXExb1RsZWFNSDRTdERjSk1NblVpZWtWc2Q4dlRKN3RkUXVI?=
 =?utf-8?B?RkNweWs5UXZENklBKzk0NkFJOFhkb0sycWdobDhZQjZ0b0FOdEQxcEFSTG52?=
 =?utf-8?B?dDc1cVdkMXMzUHBKbTRKT3hSdDl6RGY0NnE5QVQ2SFc0MzdTbmoyRVZFK2M4?=
 =?utf-8?B?bFBtWEFlL0hrYzZwb0FiWFlobDFLMS83MWhEVG9ZL2crNnFQdm9BeXVDV014?=
 =?utf-8?B?eHJvUmpuaTdBR0R1bWVLQzlTSUYvZ2lEc3djazB0Mk1WSDdzUnp2RWhEaTR3?=
 =?utf-8?B?YUEvT3dnbTZnK1ppSDRMcU52U3V3RytyNDVlRjFJSzJlTTZ1bkFzNElaQ1VD?=
 =?utf-8?B?Syt2eGZTSnFOd0lZSVBKNzJjWmNqalBhUStrcDhvNEdZNlBOejhJVm1nYlFy?=
 =?utf-8?B?dWNudDJNVXYyMEVWd2JMWkxpL0JmS3VxRmlqeCtnbWpIVUJuV1pCU3V6UE1W?=
 =?utf-8?B?a2FqTnl4V29QcEZaTEVHUVVsK0NGYWdWKy8wZkxVeTNEd0Rzd2lqSUdMTy9u?=
 =?utf-8?B?V0xCejgvR0E2K0c5K2hOQ0NvRlFNZ1lWZlpRcUtYUlMyTmRlZ203ZXdLc2FX?=
 =?utf-8?B?NzdCdzlGbk1NV3NYdDJKNSt1M3Fxd3N1MVB6ZC9ZODA1N3c0dVJvaWh1QlRM?=
 =?utf-8?B?WkY5Y1ROL2tETFBxaEJiYTUwY25rMENVUmt3SGp4d21WTGhJZ1ZDWTBZSG5y?=
 =?utf-8?B?Mk9CNWRmS0gxQnk4OWFqY3ZYYXhkemFyMHppR3VZWklvRjU4blB3LzVPeUpG?=
 =?utf-8?B?UEZmekdZaWJObzh4ZW9uMVBwRDJPT3lqWUwrSVJMUk9ucUN1a2xNbU1ydEVk?=
 =?utf-8?B?QXdRU1A3OTh6ZXlKR0VQL0dkMDlVb2dibnRkeCt4R1FGMndYV1A0RTZ1WTRM?=
 =?utf-8?B?dTNheGxSc0haNWtaUHR4OFgrWlkwdHd3VWVCNExvM2ZQQ0JGVlQ2eC91bHh0?=
 =?utf-8?B?SnM5VnJldmVpN2N6NGhiaU1TZU51OTgxRG9PcVJIUzNyTHVXOXhCSnRPZE41?=
 =?utf-8?B?U0tMUCtnU2Y0dUxxV01WSW5ZeWNaT1FiUi9JNnlvcm9McENYUWFEMWRLK01R?=
 =?utf-8?B?OHpPVnRsc1ZNTHZheWRxZldPSmxudTdmSDF4cWhTNk91OWhGclduVVhncUZ4?=
 =?utf-8?Q?YLRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNkUzM5SXZWL0dqcGVLT2NKYlNGNmpZZG5xYnFSM21pYWlMSitoT3dFUitG?=
 =?utf-8?B?WG4wQU5rdHRhc205aStYU2VielFxNFdWNkpRN1ZtRnR6Z0lyM2gzMks4RXRh?=
 =?utf-8?B?Zml0Q042SDRMUmpyRTBzWHk0Zzg0S2ZwcjhrMk9rRnFIbW5Jd09kbmp5TkFn?=
 =?utf-8?B?Z3pPWTJlL1I4NUozeC9UZVM1Ymg0SjlsM3cvQ1R5WGtBV2ZnenFhQ3h0aGtN?=
 =?utf-8?B?Z0VnS21nOGQvaVNTTlI5Tm83dG01YUR4OWVOUElFTnpBTWlGNkZocGlIamJF?=
 =?utf-8?B?WHdDbVlQYkZVaXpydzNtWGJNQjdHdUZoSmlBVHBiODk1aGdNVXhuR3ZKaW02?=
 =?utf-8?B?Y2FUV0ZGUVlZM2NiRUV2QXFTZDEza2tqQ1EwUlVZajREbFMwNXFXM3BlcTFV?=
 =?utf-8?B?RUxxaldIR3g0ZUJNSm9FWGZmNnlHSGVJOEVyZ2dsVnQxTDVOMnZhYXZIVHNX?=
 =?utf-8?B?dzVObVBOQVVqOGRvUEZuenNDT2NwczNQVlhZMFBFYUZ0aTkrNmRrNFVSNTZ3?=
 =?utf-8?B?ekpWRG5na0pYMkJHNHcxOHE5Q2hTdTM3T29Tcmx5bzFEQlpwRFhkbERGMkFo?=
 =?utf-8?B?NWpHa3BwMnlXa1pFMVZNbVRXRCtSeDdjWTdMRXFnallycHpVSkNwU29GTVBG?=
 =?utf-8?B?RTlDZSt3K1dUVTB3YlVlaE5BS0ZENjRZd1o2bmdlWkVnbll1OG5ZNG5qQ01r?=
 =?utf-8?B?ekRodXdWYWNFUVc5NitQSjZWYUxnZEdOVURGT1orUVBMaUpuM21SeTdET2th?=
 =?utf-8?B?RWpyZXFGVmU0SlZ2OHFMazhIMTgvVEwxVjJpWEJOSDhQUW1MSndBaXdvZUtO?=
 =?utf-8?B?YTZmMHZSWlloVFVKSXBhL20zZngvUmh3dDF6VUpMRGdPcWc0YXNEL0JHSWFW?=
 =?utf-8?B?eTFKUDJPN3pzN2RKdEdqT1NjelJPUWJwOHFRRUJWS2pKUUFGT1podFUycGdX?=
 =?utf-8?B?bG9RQWRYZ0dRK3QzaTl3eFFNTkRlb3FsV3RMUDFrMlhYb3dqVHFMWVF0K2Y0?=
 =?utf-8?B?OU54UU1SS2w0RDFJYlhBZ3h2clR3aytxais1THpNUmpMc2hSY0hHSjdMM040?=
 =?utf-8?B?TW5vajJjdExXUmFWTkd6eGpUa0tCZm5JUlpLM2xaNS9DbXVpaVpxMUFiZHRI?=
 =?utf-8?B?c3NDM1MxQVlMckpmbWh3SlFsZDBMYW5WZUlHbVpCbGFNVStTWHhodWUwYndJ?=
 =?utf-8?B?VkM3MUFmOVVZTUp2amw0cFlWc21UUnBtcm5PLzcrcS9WOGNsaE9DVWQyamtL?=
 =?utf-8?B?Y0hTUXlnVTRaNkxKR21WcTJ2ZXFFMDVuZzNVTXlKSkpHcDBjUzJad0pka1Zj?=
 =?utf-8?B?Z1BIZGIrZ3Iyd3FlbjhCVWdzNDRrRDdpak1CWnMxaWd4Q0VsdmYzR0RwYWlP?=
 =?utf-8?B?clRyaS9mNEozVUwyeDlJNEpWM2xXak50cld2OUR5RUxCcnFiUUdvUW9hZjA1?=
 =?utf-8?B?NGxrZlJMUzdpVmhLNmxyZjBybGFFUTN6UVB0dUNLb3dhczhydHZpeUw2SmlO?=
 =?utf-8?B?QnFDNGFxN21ZQW9yL0dvazBFNm1IOXo5b1ViYlZCWURCbGR4RFc4VGNlaTQ1?=
 =?utf-8?B?ZlhmTkswWkRQQTZiM2RlZUV0TjZMeHNLNndiTHZMdU0vRDZ5clZ5RUdxMzZD?=
 =?utf-8?B?OGN0S1RXVjA2T0NURFJyWFJBdC9kZVNER3ZPM0hxaW4zczUzeXNyeXFnV1Bl?=
 =?utf-8?B?b3pwSjlCaDRPc0tiTjV4UzdYbUk1aTVYZEszUlBOTGpSZ0JvbU10L1pIa09n?=
 =?utf-8?B?ZDhzeStpWkV3RWhRaDJDUXF4QXh6cDJxN2hxdi84bktaSFBEOTFaUGRHRlIy?=
 =?utf-8?B?TDFmZlRDVTFOYktxcGQ4MW0zdCthL0xTbWtKQzdlMVp2ZnJEanhCNnQ1YWs3?=
 =?utf-8?B?Y2IwYldubWhxQkNWcjcvTEpHM2xmaUVYcGY0SDFyenJ6OUtZWjZEVURwMG9P?=
 =?utf-8?B?Ujk1blZSOE50Sm1QWFlVV0s0a0x3RFJ5dUdzcjhxMU9OcHRjZyt5OUE5MlE2?=
 =?utf-8?B?N0R0N0M3RFpJK1c1QXcvL2Y3aXRxTWZpZWdTRTNwdVFMQis0WEdJaklwc2Zw?=
 =?utf-8?B?RDYyVTFyWU93dlZtSmF3T1FCT1JLRFVHVVlPVTBDMUN5eEhlUE5YU0lJSDBU?=
 =?utf-8?B?R2s5ODR3aEEwSDFlNVo4WXpWRlM4akJhQTViM0NrbExpNlFJRnd3d2kwMFpV?=
 =?utf-8?B?THdidUZBS1Z2ZGY0WWM1Zjc4ejh4WjZRZFdLZnkyZnpNTEtZN3MyN3dVY1oy?=
 =?utf-8?B?Qkp6QWFJNFpHd0VMNEl5b2hmWHprQ3pDRFN4OVJMY3lWZU4wVGh5N3FVRHdO?=
 =?utf-8?B?Ynp3WnA1UW9UckJpazdzUVFRT0t6dUpqOVd1QmV2czNhMXVwTUxRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b5ff0-16d9-48b2-2cf3-08de739dcc0d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:11:11.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aD6/OwdmNgwJ1ydvS24OE67DHvrYW24rExpRVQKXfGmC3HrVtFAp3ymJFtSatDIBfBWgfrNhOTUH7I5g9XledQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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


On 10/02/2026 4:46 PM, Shani Peretz wrote:
> Document that PMD takes ownership of the duplicated cmd_fd
> and closes it during device teardown.
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

