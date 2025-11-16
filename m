Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69837CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:29:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A75740FB5;
	Sun, 16 Nov 2025 16:29:14 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by mails.dpdk.org (Postfix) with ESMTP id 66015402E3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 16:29:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOD8sA9EnL/cRrTbW6/ZE6RXxRkw/M0Op2mFoVGx44ocsgpkS/KgHBGFeitJ6xXMCUo4TMN/GbiTW2YTC5aLWzFg8Z2KiQkppui2eClct5tLvfasfWLRph06O4Ba8rHSMcwfku9282P/wb5JAXa+eTZ1UyVHHrNvyJyDlCHrOrPg3OFD63fmHqp1Jg5BIzNfMgLBeR9xCIzcIv+UUphcNzYRWZBS6aLa9Q0DgWMvjnwSceN2ixoGABwbIe951h8rYIP8suMqBTg0bHWww21sjiqGK56VXW5HMB3fEbcuh3nrwZlxeloTNKGJ5eunO6TZoR3G4FUjbiTHc3Z8sxAQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuXuGWatR6Kta5rzFHi3mM4zXCYq6uZ8heCSriRwUkk=;
 b=nFKbFfW8HAKEv6Y9h826OoWGc5CN/Z+gHDKotWEZk74drmGPh3M+eNZQ8h9DG9z15Bspwl0xypTWr4A0K8h0Am3SGyKLLF3VMDS4p7x7W7ThBmhW8CZRp5vw8NwbsC8bc/WetJm2MEJUImUm4sLa4NJI9JBEwu6QQ0jAMNNE9tYM9a3WVpl0wRkzRURGovK67MMgby14JMBq4nFzHh3kWTTSs94mwAy+0MVXsjxZVtIjPQri6djR3aVMp7f+OCPMi+C3n+udmvy1Ihw2gp+qxbrex947Jrdp/sEUqCtpBpPKaO02/XmP7p9GBvwXTMsgSNttgSSpyuZQJ+MPKp2NlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuXuGWatR6Kta5rzFHi3mM4zXCYq6uZ8heCSriRwUkk=;
 b=fuTVsk3K91ejRDRJOM0oo7u1wConBPsa/JyUGuDvaOtwPWemY1Jty3H8rEFewmUJ4a7J1b5CNdLKwCs4R+jqzcNW3x0hE8Eo1ep5kC2xKxhQo/26c8txfRKWyWBoQKFUHfdoxjIRYv1eN4zsMIRNodkSH6lZzZJC339jlx/CP7Bla3DGj+tp/x6xY5GjkRFASGHGscuIwkytpmpXdXb8MwbdwSwu9dDmFuVZRcbZ2SuqFAoYVrf4fb+HBgVa5wK79QDlUWh2EZr9PfHwQVqZBJS4QkP/NLM+XuvgOiznoC/Z9lhP01zxxQ+5J6o+ae6r9FTtrquqUfYD0+jaTdvvZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 16 Nov
 2025 15:29:09 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:29:09 +0000
Message-ID: <3e0f103f-7a9d-43c6-a737-44cd2f05bd41@nvidia.com>
Date: Sun, 16 Nov 2025 17:29:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix non-template sample action validation
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251106130228.491915-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251106130228.491915-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c9295524-c535-44c2-ed30-08de2524e303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFJvTGpvNGxycXRBd2hUZjZ0TlZsdmkwYXhRbStSNUY1c01xVHFjZU02Vng0?=
 =?utf-8?B?QU5OdXE0Wk55SjVZUkZVenRGTXU2Y3RIc3dvT1g5R244bEo3ZXQ3YUN0ZXJN?=
 =?utf-8?B?NVR4S09kNFAweFNIYXh2dTAreU9oMzkwVlZYNFB5dHRqazh5a2pQT0V1WTFi?=
 =?utf-8?B?OVo5ajN5RzBVa1FCVGozZXFFeTY0Tm5XMGVEeHo1VUk1bEh5V0EzbFFCdTM4?=
 =?utf-8?B?TUQ2MGpCVWtEVHRJenhXTUVLU0RvVysxRk9VNXgwUFIxTXhjMVBvT0J2L2ts?=
 =?utf-8?B?TFAxWU1qMmhMMnM4V2RDR2xJbFV5QTMyNUI3cTNZOTNDS3IvL1dhVmdXODNw?=
 =?utf-8?B?SEViYUVvYkJiQUFKb0k2OFhoZGNDbTRVWm0zL0RFdFZyTk5pUFZHTmViWXRz?=
 =?utf-8?B?cW9LS0RHY3E5Z3QvUm5BZlFwaTNyeUNOS3BWbHEvc20yQjF3SGR4SkVIRGw3?=
 =?utf-8?B?TXloVWFaWWtXVGJmWEx4NVkzY2dhZi9XZmg1a2UwR2NyUmtHUC82MnV3UEx6?=
 =?utf-8?B?UGpSSjRrMktCTmhpRjZnQk12Sk4zWGNabXFqdHFFd3FKNFRkMDRoWnZURXdB?=
 =?utf-8?B?anZMN1pQcjJwRVBHMUFtaE91NmVXc0tBUVJMUUVDU0I5L3ZCY244UVhvbWZ5?=
 =?utf-8?B?ZVY4L1lGcklBMFNxajk2SEtpR2VlSmNNR0g2LzBwMzhiaWRmSFZIMjBxbE5k?=
 =?utf-8?B?TjhSdDlJMGhJa0NxTTBoRVhRaUNoR2U2MjU1L3RXY1hldXZwTHFkT3dWQldy?=
 =?utf-8?B?OERwZEFOcG8wZnAzQnAzTjBYYXhaRU4xWXhoS00veXF4UlRHNVBIQnU1S3k3?=
 =?utf-8?B?MlJVOHdYODBhMHJSR3dHMVc2ekVuTFRpRjdDMlZTV0Z5L0ZBYkJTNGMxMnZy?=
 =?utf-8?B?aUZzamhGVjB1dEU0K2czUmErNlZ5bncxYWNiREtOdnBUWWVObDRXT1VrczV5?=
 =?utf-8?B?Zyt1d0k5UGE0emVHT1JiZGZRU0hUai94QVZFWlF5TW9BQTYvek42dThQZ0E4?=
 =?utf-8?B?T01QbU90M0RyQXpWdlhtUnMrTzNVaHlyVDB1TGlUL3o4ejFadjJ1NCtXVVNG?=
 =?utf-8?B?Q3hnRnVpRHhBTnh0bWhHWExVcVl1M0RHNUd0QWEzem5PMEZNRThkbDVKejEx?=
 =?utf-8?B?U1I2UkorUDdkWE5NMGhBbzU2RGZMcWJPK2ZiNDJBLzRTUEFzWkdWSTVlcG0x?=
 =?utf-8?B?S0I5ekpWalQ5Tkd4NlhiY1RYVng1VlBxcmd6N01rRVc2WHlQTTZyc2VkbW9U?=
 =?utf-8?B?ZXp2aE1kVmo0RHVDNWtuS0lNN3R3ci9DMXQxZU9iY3h0RzFOUEFCNTYrcVBx?=
 =?utf-8?B?SmNDU3FaVzdWc3ZMWjFhUnJISXRVbnJmWlRnYVZ1MFF1ZUhoVFdxMEVpOEpo?=
 =?utf-8?B?eTRqT29Ja205SEtOQW9kZXZ6RWJoQVh5ZjdQQ0NJSFVNcVdkR2M0aTVSRm45?=
 =?utf-8?B?MkNMT1ZlRnFhYWR0VDVBeUNPejZDeTdzT2NmRjA0WXh3VDEyanhNc212b21x?=
 =?utf-8?B?MlRZbWlka01wSTZVMTYxaGpsV2s0NGpoMEg2MlZVZGZ4YkxYZlNwekRqSWVv?=
 =?utf-8?B?aGJVb0oxWHp3UC9aL3JPNHROWHhOQVlDT3hnUms5eUoyam15Z2YrMVlYU253?=
 =?utf-8?B?Nm05YUdwaEpwQnJkc0QxYkc0WDZyeHF3YytVS0pTblBWVE5QbFAxOS9DcGdz?=
 =?utf-8?B?amxrdm1ESTRoeklqRWtiNHFuV0UzK1R6MGtOdDFSSThvUGIzbmMvNUVGMUZM?=
 =?utf-8?B?dWVmRU1FSXBGRVUzeHgvWFpEcUt6VzNiRW9NN1dCczFqeXU5K1lOVkZiZGlX?=
 =?utf-8?B?SjVEcmtCUUhEclR2U0g5anZBei9qbmNMWFhRYUdFSjVUdzBUT1JTTC9hRVBu?=
 =?utf-8?B?KzZnblBIUlJ1RXIzZlBqTFFidkl5ODZKUnMvZmMzaWNON0FFSFhNVFE4Vkgz?=
 =?utf-8?Q?h2VPi6t95RlbPKOgdfG/pDGrtwpflEJV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzViYnBPeWFtZkhJRk1rbmlJdWFicUtpSzVDWGRLTEhUNU1PdmlTVFRaRXA2?=
 =?utf-8?B?dzB0M2xNdmljNXVmYXF4bkRLUGh0WTBBbHN2K0lGOWR4L2dHOU1URDdtS3dT?=
 =?utf-8?B?bFlsRFlkc0cvdDZwMG8wb1A5MmF5akI4cjJEajNMZ0xmU0xRMHgzeHJvRi9U?=
 =?utf-8?B?cFkrR3ErcHpMSUhVUWRSb05FYStBWUNaUUpOc0VNUmNLYjBNd3VSaFJrK0VL?=
 =?utf-8?B?S0l2bTYzRVVaSmpTRlBmN0k1K1Rhc3lYWnVxcjNFeGNXM2JyZDVhZUtBUzdF?=
 =?utf-8?B?alFsd1RkQlZVV1NLWEpCSHljaVh0aGJUeDduQTdGZFlxbW0vMnFNY3h1MDZr?=
 =?utf-8?B?cVhPWE9tYzlHTlF4U1UzRFhaOERuUVFOWmJ2R24xQllwc1Z6TmJLek1vMG1z?=
 =?utf-8?B?bXk0OC9HR2VJQ3RZV3lFVDY5UkJtcG1YTnlsYm9ZenhHd1JkbDJWeXdaNXB4?=
 =?utf-8?B?cjlqRlI0QjZ0V1RBNUsrQnlpTDE1ZnpPT241cjgwRGJQYVlFUUFkeVgvenRv?=
 =?utf-8?B?Q3A4WC9ucG5vM2c4eVF2Z2I0NkdHYVZxcUdYeGFVN3NiT3JIUi9GTWFSWDFs?=
 =?utf-8?B?T3UvWGhMWHdQTW1FL2l3MVFlalhUUU5RZVV5dnN6dUFZajExVHdlMjRHNmxq?=
 =?utf-8?B?THJJdUJJTExRV09Cc3pSK0RZbWx5K0JQcktYNHJ3bU45T0IzbVBoTDNHTFBJ?=
 =?utf-8?B?REVsbmJISG94Q2FjRDVmMkhNb09BOGlKM3RvRmJIU2lGS0R5Q1VQZDBjVEFv?=
 =?utf-8?B?V2tSZHdLMWRkY2k5Qm15ekVCY3FqZk1JdmlVS3h5QmJpNnB1c0lQV0J2T1E5?=
 =?utf-8?B?dnBRVDlYSWlKazFMbFZrUytxYk1EV2FNdmtTc0xIOHB2b1ZNZ3FjaGJLVTRj?=
 =?utf-8?B?Q0NxZWp4VnBjUWc3NFFHWCsyOHhCYVQwLzZvR2xYakFnR25jOHlSVmxvaUVz?=
 =?utf-8?B?SDkwaTZaYjFwSm91THkrMm11eWNPUzVFMU8wdWdVWU5aRzgzTFpqaVV6emZN?=
 =?utf-8?B?QTRkZENSY2lhbUtoaVdRQVMvS1hWQzlROTdqTmM4bVhFbDVMci9EQUZTRXBj?=
 =?utf-8?B?OWNyamJJOXNJcXR4aTc3OE96VmN0SzNoYXFtZFphNThaYXlweE9XOWNIN2dz?=
 =?utf-8?B?QVFjZ0hwN3pVK1QrRHJHWjJENCt5WVdDZUdObmFDZzRsbVhiYzJ5UmZWaVQv?=
 =?utf-8?B?YmtGU3RrbmwyRVBZLzVNeDlTR0NSZTNFcUQ0K2FTU2o4ZFV0elR2QTFnWk90?=
 =?utf-8?B?aHBXMUdqNmpnTUhFV1U3dzZ0S3hLUWp3YXliTTdhOGNvZkNYYzlLdE5TOWRV?=
 =?utf-8?B?WGtkNjV4UDc5V2kvSm9yOS81N1luOWRYSTlNUTF3NTZEQUNiOTNrZFZTY09H?=
 =?utf-8?B?cW1tRGwwcmlKSFl5Smh3TnhyNkcxV1llTi95anR4c01yUllnd01ZM3J2d1lG?=
 =?utf-8?B?cllWS2diR2duYUdDbDhUL0ZzQmR0cjE2MzV4TUZwajhVTVk1U3J1cVl5VkJL?=
 =?utf-8?B?YVNZN1YySDh0TU5WUHBLMG5KR2JOclc3MWNWU25SL0ducmg4RWpoTWY3Rm5u?=
 =?utf-8?B?UWpZcytwZzUybGg4U1JRSklSUEhld1BtdWdmK3lhWXJKK0plV0JnU3E4SnJn?=
 =?utf-8?B?WFZ6VTc0Uy9DVlZ5UTkycnRaTk1oNUF3K0dPSk9BdStTMkphRnBaNVV2OVor?=
 =?utf-8?B?OEZDcFJiN1JwRmpvYThNbEZwbUNveHVSUEZuVWxuSUswMGN1TnhUdnpOdm9y?=
 =?utf-8?B?bFFTcE9Dc044Y2IweEltYkFicmNhRVBmU1ZkeUhLZm12aWNkZ3BnQWxIbG5a?=
 =?utf-8?B?NXRRS0I4cEg5cFZNdk5GM0s0OGl3dnhJOTFvKzBHbEJyS0JYcE9DZ0tyYU5w?=
 =?utf-8?B?dmRzTFA3Lzczdm4wbEFkVUlSTEJTNyszK1Q5TGdkcmR6d1pCMEMyOExLejZn?=
 =?utf-8?B?aXhLL2xpSzJUYnVJSGdTZnVTTUtKNUtKUTdlWjBXTW9CUHZNTkVYSjIzSDAz?=
 =?utf-8?B?SmtPMXFmZWxwdUI4bHVzS3prMzBha3hpb21oaXlkMFV2eVhSUmdEcVg3aFE2?=
 =?utf-8?B?azlJaVJHWjd1UmFoa2RzWmdnTWVVSUJrSUtJRVgzT1NsRmRrbUd4VEluRFow?=
 =?utf-8?Q?8um6ab18HIP/PnuNaxQkcWQT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9295524-c535-44c2-ed30-08de2524e303
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:29:09.3782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et3y7mbIKfnlsxKLCAUymYxf7M6iIimEVtHnE3noeoKJ34FydWynJdpB14Eax+Yr7QTyTppupYsQdGCH+9vVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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


On 06/11/2025 3:02 PM, Gregory Etelson wrote:
> The patch validates that sample actions include terminal action
> 
> Fixes: d986f04d6529 ("net/mlx5: add functions for non-template flow sample")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com> 
Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

