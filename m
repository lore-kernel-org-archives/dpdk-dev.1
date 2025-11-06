Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D66CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBE80406B4;
	Thu,  6 Nov 2025 08:21:45 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by mails.dpdk.org (Postfix) with ESMTP id 251644013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:21:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huoDmPvHGT59cJWGnd0BIrJy95hd6ZxukHOOnLfvJwzSYNidPN2pKN1DDiczp5AXgYkFIxeGUZ/5GNMzb6u0qLc2OvNsLCPHUxLt/KxuBj1xheFC2PnQ7TXnqke0kV9kzai5bmWRu5kSRtP7YNBe9BFYlV2yNTalFa6AaSnaXNWSEtjVSjNRtv6DhZBnTKWIMdTfKYn6Aw4nR6SeGO1xr9hGpqNaoCG2+F41SNqHxyqHNsBWbLtvpb6I298GSUKAGaB/EXgHfVQLcyFig8T703v/CXU2UlxsKN/8uF9Bexbe0Q/g8QK2s/9lnw53COIzonB3H8ysnb9uOLjTnox3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFZCzQT+Qi1qVSRwUakn1Y6DMVazZC2iBUH1WrKRC7w=;
 b=FieX5yJAGhpmdsW7fTSkpuMtGM69lEqVLYNOGI8CzdXoGe56NhiMN1J0Ubnzb6zZ/tWBOaEghvtpSHiIs1wHtu42iCD/LIv0xAFa9uxQkpm+3brMyE2j1xVh/7ETpqyFrQEzUasRNP/UU9kykCesG9vGoVePLjAGL0EX5TBBEg8UvDlRnD7QrawUPvEjZzZLKEnMsnhJtr8rScztUOztR27hntfJHTGjgWwsxG3dVe5Y0ExPet2LdFz9Sn8tPuMnG1a8NhdJW1aRiMSnOaJ8mMV075ZMie7mVwkQIF2YW8vyhSrbbFfK8Uhya4Jz0bVoSieStgxGyqeXVWBc6kcmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFZCzQT+Qi1qVSRwUakn1Y6DMVazZC2iBUH1WrKRC7w=;
 b=gqVIBUojSRwDFMlp/FZQRzR7vE3UAmV2qL1YE3K8k3G9IWhKBL9wVFpWEA+QFsLOTNnpPX/i+eYKQsdZrUbrbpwaHEyBR+t2oDBC98XnK3VWhGTkxE/Q2eI7hC9WCcB61emApWP1IMpAHU0Kh3uE/9y1vIHw1SYCdbOslBu0oep/iiskPH8ippCp1jNaylFoBWiVQtae+hJ4m0j2nXn2RBrYGiAxBtCaXguA9GpW88GZTSBGueyTiHYwC72ndxI5SaUUeFDUOGwbTjVoPeGsdyUnjSKQFb9kC9ZA4WCNgxa1AYao8sZTlpyp5koLMEkGw3WnO158e55EEGxzzADxKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 07:21:41 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 07:21:41 +0000
Message-ID: <38937104-bec7-4934-b5c9-874601c07395@nvidia.com>
Date: Thu, 6 Nov 2025 09:21:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: fix external Rx and Tx queues access
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: thomas@monjalon.net, mkashani@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
References: <20250731060849.18117-1-getelson@nvidia.com>
 <20251030091138.223868-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251030091138.223868-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 83159ea8-8619-484f-1389-08de1d05219f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFJiejUzRGdRYkdiYmNUMytoODRMb2p1aGZpWFhBbGkyOHE0ci9uU0Iwb0xS?=
 =?utf-8?B?blNFTklPZlVGTEZFbTJaSjFhSy94NVoraitIZDJ5R3BOTU1uSFZ5Wm8xbUZO?=
 =?utf-8?B?Sytsdnl2R2FCWWxOOW1NYXVzZWZWZzhGWjFsT0RobzVnR1NjUTZYUEp5dVc1?=
 =?utf-8?B?RG52bVlKcmZWZlVSOWYyZVdnSnlLVTl4dDdITWFEZHM5b3JPUVN2YXg4MDd4?=
 =?utf-8?B?K280NEZ6YkF2YkJKM2xBUlFNRk44QW9ib2UyMG1BNUJPbVRGZ2hqWVliZWZu?=
 =?utf-8?B?VEJGcXFROTZCZUhPS0Nrd1Q1anZjSzJTMS9laG9sUzVkN0ZIbXhsQjZTSWVx?=
 =?utf-8?B?aDNpSlNQcHdmSlhYRVl3VzZFL0RocXJ1ZFVGaGpZYzhaRUhlUmthODgyZzBD?=
 =?utf-8?B?MHVXNllUWjBMbC9WNHVJbnZNWXVNYlNMWlBZM2RmTGs2VlJwb1B1Mm04WFZk?=
 =?utf-8?B?UXlkQXdjU3BaZWNTbWtDZnJxdFlkanY0OXBMbVBySkoxSjlzSzYrT1BGME9M?=
 =?utf-8?B?SXlJeEFsOTJzM3VsTHc1czM1czBHZ3lTQWgyNnQzcTB2R2tPQkpheTVKTlF5?=
 =?utf-8?B?SDBYbUYrMFFZcitrLzFyZDlBWUo4RUNxNFQ0OFE5NkJRMDBWR0pFTC9YdHd6?=
 =?utf-8?B?a0dxYUY4ZEtPNDZoWkJleTlQeW9hZkhSRUo0aWJqcnBGanoyRUNqU2N0OEh6?=
 =?utf-8?B?Znpxbjc4dm9PNmEvSnpjelkvUWh3SFpvM2NLdGttSVFMNzVsZDFVeDRlK24z?=
 =?utf-8?B?aFVDOHJCeHo2QlB0cmZHL0ZIdHlKTHdwVHdSQVJyK1JWZFBoeG1UaU5rWWNp?=
 =?utf-8?B?bkt2d0h0TWltY2l2Q1JIUm9rM1RGSjhObjdwZnhHZTZMVlNQSnNGaHZLTGx6?=
 =?utf-8?B?U2hFakNobWZWRWtnMzhmY1p5cnFIekxiK0pyVzczVHpkSnJud0d0QnE1aThF?=
 =?utf-8?B?bmg2d1VrRytnMjlqU1EvR2tOTFFEZ1lhM0ppaWVkOUJzZ2NjOE5PVjVPV29W?=
 =?utf-8?B?ZU9od3ZlMlNJejlOU1BSNVRndlhEcVY4T2s0SUJwT053NkJDTTkvV1BMVHZz?=
 =?utf-8?B?ckVQNDFzNmg5MkpyUU94ZmlZeDVPTFJZcGpTQlNVc1FqSk1NNzJYTTlvd0tI?=
 =?utf-8?B?WURTQUk5aUUybDgzOURnbkpLZGtEZmpYNUxzMS96K3dBaEFRblJ4MXV0bWlG?=
 =?utf-8?B?RXJSUjJVdldWUWJOVmt3cmx6a0FJRzl3WG42VEpqaHhEck1RRkYzTDJMdnNp?=
 =?utf-8?B?V05Dd3RDUEwvMGdtdVRzdVBPTEhZZTZLZkFPWDhsZEU5N2VtMmFvZVFGcGd6?=
 =?utf-8?B?RzVzMG1xNUVlUjQySm5zd3JONHNDV21jUmRMT3FkdVRvby9zazl5M0ZWQmJa?=
 =?utf-8?B?NU9mVHZ2bG9Td1BiTjVVanNOTmt4U21VbG5RWGlzUElGNmNnU1BtbWtjL2hl?=
 =?utf-8?B?V1E3dnFqWkJhNlVsZklCZ252ZTRnNm10UVNjT0tWMndCaC9DSG5OUE9QeTlu?=
 =?utf-8?B?ZWFBSkpuL0JEU1gwVm9NckhJaHk3UzB2NHNTUEFsUkxGWjhzVjBtMnZXNWFk?=
 =?utf-8?B?dENyeEZ5RUIwd2dOLzVmK3FnZ0FpTHVtTWdZSlZKaGtMUUY4eTZEUENZNnN1?=
 =?utf-8?B?SHdNQWpRZG9FaGFnamhreThGR2VkUnM4NE9SMUUvYWlmdmNNUnZTd1puWHNI?=
 =?utf-8?B?bEd5Q0JYRVdYSCs4bVNpSTlwd1pGWk1tcUlITVNZMDNpVlY1MENvV05xaXQ4?=
 =?utf-8?B?cFc4UTJJQ0QreGtwakxha2VQK05QR24raGJzRk5CVk1MTVh0QnNzdTNhWUpy?=
 =?utf-8?B?eE0zSnRxMWU3MWpycVVycmJPT3RSZWRhdGw0V1doMEVpbHFrYXl4aTdkc2I4?=
 =?utf-8?B?bnRyZ05oVDBZSkRFWHJ4aWhkSW1HWGkxbk1hV281TjNnYXdaVFdMSlIwSWc2?=
 =?utf-8?Q?u6qrFLDw+GjaeTPp3qTaqxPb+2SGtvsg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRJK2c1amVvMC9HM1lkMlVCQnY3VjdvdXNwa1JqS1ovRGQzNDJpQ1B1Mndi?=
 =?utf-8?B?UUlhT3BSSWllb0hHZGQ0UmIreFVRSTIvN1JHMzkxWHQ4T0tuV0FUNjYrd0FB?=
 =?utf-8?B?MEduWFh1eEU1c2xmbmRWWjZIdGh2WkxQV3Z0S0xtbVhoRTVUb1d0emc1d0pj?=
 =?utf-8?B?QldIR2xTRVZTVW9tVEdXSGdqcHBlYTM1U1d6bzlqU2N2a0hMekJYNFZqRFhR?=
 =?utf-8?B?d2Vna3V6UGl3RGdZU1V2cWtvVmN4T1VKMHFKSTU2aXFXU1dzSXdGRWNuWUJD?=
 =?utf-8?B?dFUzd2tCZ3dNVjQ3bmJ6eUpKbVBTOXIxTWpDZUlxcW9rMDNIOG9wWnA4Mm1s?=
 =?utf-8?B?TmVZOHBRSHNySStiZTRNTzFKVjBWcXhxNTg2ekZpYUMybnBRSzhLZEw1VEly?=
 =?utf-8?B?WVN2WWxaMFhNcTFxNXRZdzFCQWhZWWs1T2QreWgyOWRoTVgzVitQYjlURWo5?=
 =?utf-8?B?RTIvaVk2ZG9JYS8xQjA2cCtmdzhQTWpzeWYwWWM5QlNtOTFPTmJZTWE1RFNk?=
 =?utf-8?B?R1REQVY1N1JBbTkwd3lOT042cUJIaVpPUmZURmxEeXMycGdscVJ1VEdESVpk?=
 =?utf-8?B?U251dlZpN3BaSURXL3hkWHJjcnVFU2tDZDVxZFZNejE5TTM4L3RFeHJrUWs1?=
 =?utf-8?B?SXVkUjdnaWZrWTZITDQ5R205UE5qN29zNzVPN2hwVDBNL0RkZVhwemZqQklT?=
 =?utf-8?B?WG5VMmVwWFRVM0VHTFliekpEMkJKT3VSNEVIUEdZNDJpZGVHZ29YNFphN1lR?=
 =?utf-8?B?NHpPendLVHp1N29sQS9tM3NzRVVrVHhUNlNuODdhUVE4T3FsaXpVdDVnbk0w?=
 =?utf-8?B?WXRveDB6S1R4bHE5UytXRkg1amNZWjVTUE8rVlJDSlBpaGhxaCs1a1pleUZz?=
 =?utf-8?B?blhxSnBPTVlMeTNIT1I2ZkFSd3BlaHp2YkFXZnNZM2hDakNIcEsxeElkRW4z?=
 =?utf-8?B?d0RvQllIVUhZYksrdHYxRS9IeENvYmlSbFNxd0tjbHhkS2Z4TG5pc1hnd0dI?=
 =?utf-8?B?MUhtZ2Q3UGJVRjBPS2V4VXZOdDVLN2UzU3NBZHR1YWxFWlR6a0VoTlk1Qm9l?=
 =?utf-8?B?V0Voa2ZHZDI2SVZpd0Jyc1plNVgrckY4RUt2VGZITkpmNksvUXB4ZmVENU5y?=
 =?utf-8?B?Q0NVbXhCNWRIK2lxNEdRTjZhbTVBb0V3NVdNV0RXNEdiVDh1UXd5MkcyMFYr?=
 =?utf-8?B?LzV0NlRTT0Nnc3ZPQWZGaWdWKytLRFJDbEdyejIzak13TkFnK3hERDBkc2pr?=
 =?utf-8?B?YVk5RlFvSUFNK2JyTFVnQS9icnRoZWc1WGFVWnBKUEQzaUpqODBwSkI2alFy?=
 =?utf-8?B?SE5VbitraXhCR2Rtc00yQlQveDZYU0hYbG5SSVRpVi9TWXBsUGJSY2pQbjhR?=
 =?utf-8?B?ajVSdDNUYXVaajJiYmtxRGdxamVFMC85SktnMzEvelRuK2Z1ZCt5bTE4M0lQ?=
 =?utf-8?B?NWlOcWlxM28randpTndzZnNSM3k2VCszRmxzdnFLZTM3SHlyaEhhelVJK3Fy?=
 =?utf-8?B?OEh2SFlCZVZ6cVlnK0M0aVNJR28vckJUblQxdzRldTFpUUlGbEdhdWtCR1F0?=
 =?utf-8?B?ZG01QTg2WWgyNFZ4TmhmTU5DcnNXR0dSbHhTRzlEL1ZEdkxqT0ltUkhVd1Ur?=
 =?utf-8?B?dUp4VzhKcCt4Rk1DQ1BFUEZXc1ozU1IyVGhzSVE2WlFYMWhUYVJMNXRaUDQ0?=
 =?utf-8?B?U0hvUDJUUUl0S2RVc2NqZHBxRGhxSnc2VUY3UTdVSDBVTkdDWmhqeHUzMWJx?=
 =?utf-8?B?UERJcXJSWVkvdUJvaytwK2s3K2V0b1hOejg1TmRMS3A1V09pbjZRZDlRV3RY?=
 =?utf-8?B?YWtSd2lkRTZQMFQ0anlnaWd0SWQvemUvTDJVWk1uZExFZXF2RFRXOVVvbTE5?=
 =?utf-8?B?aUhnK05XYlZKazlLcVZ5WVB5UytlaWd2ZVdLZFl1ZlVPVGNEaUhiYWRnSmhW?=
 =?utf-8?B?aXlxU0Qrc3dFUDlQLzc5RXpRckQ4Ky9qZlF1bFdsTTFyWUVOTWVWSitVZXBS?=
 =?utf-8?B?Z3NncThpL2pCaDZGN2QyaEFLZVpheUNpZStBMEhOeE5SNzFYUElaUzg1VUw3?=
 =?utf-8?B?Z3NQSE91WEd4eHUxbGZ1di9jQjZBeTJkSU1oV3M0MzN2QmNIUVdqYStMK0wz?=
 =?utf-8?Q?baOZAKfpDLpTLEiK9ztYpzncJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83159ea8-8619-484f-1389-08de1d05219f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:21:41.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIuSUw85ZzozSKRpDcfQchH8sWlng0hSeXQXj/Z52g+Fy3SY79c1SY8J3s350dFrVJQxNfIZlUCIYlh8VBoOsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699
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


On 30/10/2025 11:11 AM, Gregory Etelson wrote:
> mlx5_ext_rxq_get() and mlx5_ext_txq_get() functions did not return
> NULL value if query index was not referencing external queue.
> 
> As a result, calling functions did not expect the NULL on return.
> 
> External Rx queue:
> 
> - In mlx5_ext_rxq_get() remove assert and return NULL if a queue index
>    does not point to a valid external queue.
> 
> - In mlx5_ext_rxq_verify() validate that probed queue index references
>    a valid extern queue.
> 
> External Tx queue:
> 
> -  In mlx5_ext_txq_get() remove assert and return NULL if a queue index
>     does not point to a valid external queue.
> 
> - In mlx5_ext_txq_verify() validate that probed queue index references
>    a valid extern queue.
> 
> Fixes: 311b17e669ab ("net/mlx5: support queue/RSS actions for external Rx queue")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> v2: fixed MinGW compiler warnings.
> v3: fix return value.

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

