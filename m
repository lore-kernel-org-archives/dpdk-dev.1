Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F99CEBF92
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADAA8427A1;
	Mon, 17 Nov 2025 08:44:06 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by mails.dpdk.org (Postfix) with ESMTP id 8D273402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:44:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpydqNx4YkJC7mczVi2w7E9H6KcaT80aHtIUk18kARqIR+wecxvBC6tdcLSo83CBkpH49Wj9Uq7gyLSPw/QHBkcS7vzEETtnj95JgPlTyHHNsxurnj+w/wz3L+kVUsaVXT3dvUAdyH2f2hPHOITqA/f8qvSueg/W7GHygWR6NXTJFWbeOQ6X+P3do50SV/U0p9MBhyLjlZOn+t49NEhjYG77qHoISZ1YPwYF2MGo8gqO+foRTQq9E1a16ExOKAGt/Nd5NiPmFJIO5+y2WWc4mMPMuIyyHGFOvH94dKhHXIjuVDBAVisOWRn/FIUPzqopMnC0xXOH9czYM/F9cu9idQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6aafgVlJIL/gS/ibHpXOt6kegfr0S7S1QmJfPUgk5c=;
 b=Ie8BmArOfRDRRK++O1qdGB/2wsw0YrgDI7F7P8vAyDrsHXQHMpBc5zu0uywwZw+BCQSSvwXiKmcyqe+4JwnPaWKiPycM2zNcEknEGixutXJ2ELYsoWAZRFsocu4Mnzm8mnMGjTiKcRN6pnlXpGD9txeYX/LsBFnJ2AoynvqkOzLezFF5uCR1yywiObmglHnYKBIvlsA7BHyY/bBGMeci8MvSoxT1hzsRscVxm66lNeDu5tRmv/F7tVTRrFrj/fWzMbdDp78mfluTjPEkcXidS+vLnVDklN5m836eMSnppQakFesXiiuh9KDmx1NfnkUVNMNm7D30iWead3ILfas1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6aafgVlJIL/gS/ibHpXOt6kegfr0S7S1QmJfPUgk5c=;
 b=FKRABBTzmuX9Hpjr7zm6MnagoHLqCBVBoB7S0ouUqqmfALgUA59QBzvjFy3PN9AtWn6qQJLGR/3yHB1+tYVv7x/xh0YQTGUT41cSDn6B8XIl6ho5UMW8f7avQ5Fb6o1i7nlUzxRu2r4oQo2FpHV+o/nPM8XOfv2x1ctUIb5uhhHNtNDZkwoVV0n7EAO6+mE+S1IFDvAkRkadCyYfCZOPMfely9mFSZWPfg0thEquHr8up7BXz+4GoOvTDbYSNPx3NgfmyODag4D1cFxaVailmcE7u2ykQRQwnyAAFY/Gv9OSj3Goz73QDIGgS8ZzdHASr7varxURk98kmdDAyJG2gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:44:02 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 07:44:02 +0000
Message-ID: <d8f955f9-8536-49bf-906e-7018120c7cbc@nvidia.com>
Date: Mon, 17 Nov 2025 09:43:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: remove representor matching devarg
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
References: <20251027193558.770297-1-dsosnowski@nvidia.com>
 <20251113131758.1524043-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251113131758.1524043-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c642538-7344-450a-88a0-08de25ad1350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzZSOGI2ZGRxZytCazVWZlpIR0UvN0c0WGdaV0JHRVFEaEpvQ0Z1c0lKS3pG?=
 =?utf-8?B?L2JNZ1lEcTdQTEQ4Tkt1bUxNWkZVaW5YTVZ6N0xtZ3d1R0o0RGdvV2pwODgx?=
 =?utf-8?B?MmRoVUVkQ1NqQVZoKzA3cGdDSktmWUdabFZQYkcxUG81cmNjaGllOFNXOTUy?=
 =?utf-8?B?NzZCOGJkcVRscXQ3L3NrakZNblA0WmFqY1NQNHQrU3dPZG9XVjRpazRuWU9Q?=
 =?utf-8?B?bjh0TlVPVXlITk5USCt5ZlZ5WHFHUVNndUZDbURJSzhRcVVkOTJrVi8yZzFB?=
 =?utf-8?B?M0poekJnSWFOTzhMSjNPK3pidnJ4TmFEQzdzODZBWVNkMVpWNGRjQ0pJUVRp?=
 =?utf-8?B?azZwQ0k4Q3Q2bm9KOVZ6R0VVWmVOZHpGTUNyY3pNK2kweDZyWEJjOVVmbzc5?=
 =?utf-8?B?K3kwWkUvOFRIODNrZUQwQ0M5c1R3SjNMRGkvS2VSTUx3ZWNIbXVLc0RqRHZJ?=
 =?utf-8?B?NVVKcmhyUVZ1dEZvV1RxRks4YzA4NU1MRU9tZTJKYXhDdjhva2swaTgvWmhq?=
 =?utf-8?B?RWtjcXZCMVBMcXNwV1JFWGJxVVVuYVE1Z1lFVmhTbCt5eHJab1JKODEvZE9q?=
 =?utf-8?B?MHN1MDhjWjBiYTRWc05TWDhxczA2V0I4eXlHZTIvVDB5QXZzdlE2L2RpYkNP?=
 =?utf-8?B?eUpMK3d0WVorRnBGcDQxSXRnUkJ2QVJTaW1tZmUzb2g2L0VSTm1DeURjRjNK?=
 =?utf-8?B?MGNueXU4bFdXYUtIamNEYmdwVXZ1SkhDK3dESFpDc0NVV1VCMEVMMTJ5Y0pk?=
 =?utf-8?B?NjZycnpkY0tGNU84M0MwOXd4NzJqUDBwclNjSFVRb0I3dEtSZGRPZUd3LzBn?=
 =?utf-8?B?bkhuSTg1OUxXR0VDY3h0QWRmRCtaeTZ1R0ZzMThBQ21aRkFmb0k5UGpJY21H?=
 =?utf-8?B?SGo4c1BEQm1GcUdsUzhySnYrbGVEWDNMWFVzdStFREc5WWdqMThsbmc4dVI5?=
 =?utf-8?B?Nk9IYTA0VjdMZ3FjVEY1UUNIVnpZYTJZd2I2SGQwQ1EyV0VYTGJYVENLUU9J?=
 =?utf-8?B?eGRodFJFbkZjVTEyUml1WmRrZFRJNW1PRFF0Tyt1d2VIV3BIR0IxR2l1NEN4?=
 =?utf-8?B?OEFDWTY4bElsOXhiMUpsNTZhYWt6WkFqbk03d0ZwQkVmbmZ2NXFmR0lpVm5y?=
 =?utf-8?B?ODNrSHkzeFcwMWxveS94YkFtRWFvYTg2a1JIQUM4TDZHMHMvUzFRRFZ0ZkZs?=
 =?utf-8?B?aU1vNHJ0TjNSTWZoNWlQa1FXM1hqYnMvZTN6V29KMnJER0lNVjBjY2FEbWQ1?=
 =?utf-8?B?cWNDRTJGdytWSUNTbzY2V3ZNendQREYxSS9tcWhMaVN0cGVLVHdUYXFQaHRM?=
 =?utf-8?B?TmgzeXA0all1WFB4VkdYTG8vZUNyeHI2MmZ3WGhzUVpZQWhvRCtRUWh3NDd3?=
 =?utf-8?B?WkxSb3pVNm41YkVuZy9SeVcxd09PSjRrNWFiUHlQWGRzMHNIMktCQVFiVTQ4?=
 =?utf-8?B?TTVOalVWaWtGeCswTDBtc1YxVTZPcFZPRXZqRnBZTXoxNXd5dWlUMG56Zmt2?=
 =?utf-8?B?UEQvZ3VCWnpMelVpN3NlRWpUTm5WZFEwNTkvSGRQWXBPR3ZMZWdNMHAyOC9G?=
 =?utf-8?B?OWJOcmVmbDdmRXNnMEhJS1p4MlU3Q0ZGcXNFQkVONUVsUEdvdFltZWZYUUo4?=
 =?utf-8?B?WGc3QzV1TTBzbTVobGtJaUduV3lDMWFaQ2toQ3d1OURjc28wbEtvYzJaK0li?=
 =?utf-8?B?RUNNWnE3WjZGY3dBejlEdUVxeHRleFZaRUt5KzRVc1MxQlFabmxFd2NkSXJq?=
 =?utf-8?B?TUswV2RaSTNyN1VHN3hHa3Iza2Fla3k0WXBCQjg4RWVVb25jeWdtWkpXdGlK?=
 =?utf-8?B?VHVjVWlXQmRiRkQzM3VLOG9VeUVWUDRvazd6Mkdmd0QrYmMxNXRJYnhhK2pv?=
 =?utf-8?B?a0FEMisxL2hPT0tSbUZkazIvZ1B1VXo2WXhxeGVSVTFCUjNldDUyV09FZTBF?=
 =?utf-8?B?eDBGZHg5eHFNT2lOenpsNEc1cGQrS2tqMGZxdnNVZS9qUmVndWVadmM0aitn?=
 =?utf-8?B?VDNJWm1qL0p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxsVklkeGNSdW1uU2VzVFN0SitxZENUdWhKZk5PMEZaa0hMMkljKzhKUDRv?=
 =?utf-8?B?eThGcXB2WHFLNm1HbXg4c3Zjdmk5MUFZaHBKZSs3d0pTOXl4ZEVhZnJCVTFC?=
 =?utf-8?B?T1I1NTQ3ZUpKKzBONXdubklTUFpVL1FEdTdlaWRNN1NLVXNRQzA4Mlk5ZlpT?=
 =?utf-8?B?a0RuU1ZMRUtCcGhXb1g3bFpKbHc2TzJzalZPSm1uck5EdWZPc3lub0huaWNn?=
 =?utf-8?B?amdmdUtrUWt6SXQvTFJsTmM5Y2dNNU9VazN0LytTcDJRbC9BS29yUjJHYkth?=
 =?utf-8?B?Q25DOG1xZ3NhL3JncE1lbUhhaWwxUGE5TUsxQzE2dDhWdEZZNW9UY1ZKNkZo?=
 =?utf-8?B?S1htMUlLeW1ZZkExTHZmVW5zRTlJdjUzVkZqc2cvQ0xXbkRKTVEyYjVvdDgv?=
 =?utf-8?B?dk1wcmdjS05RelkwanNYZ2JxWHBUaTF6RGs1VmhHTlp3dkZnUHdvdHhTQ2Z4?=
 =?utf-8?B?OEowWkQ4NWQ5U2pNOFpFcmlsYUhEdWZ3ZFRLbE42em1GemozZWFyaXNCOHVn?=
 =?utf-8?B?SUhRUUhDbm41czlLNnBNRG01SWlXeHc0VTRqTVlrTDM5dWQ3VVAxTnFQSTc3?=
 =?utf-8?B?aUF4ei9HTjErRndiL2YxTkNIOWRpaUd0L1RKK3JLTDhyMmVOT2E5VWQwcFpL?=
 =?utf-8?B?Mk02ViszUjZ5bVh6WGlUUng5T2RDNnd5Q2VCc00yeVMxWnNVTnp1ckJLZzA3?=
 =?utf-8?B?UE1tMW16a2VSSzhlUmNKRGJQb2dtTC9PbzVOekZCam44dnNtdW5rUVBwcjZh?=
 =?utf-8?B?Nkl0ZEdYczQxaDVMejFZU1NVbGE2bi9EUDVyZmxaQk00R1o4VVhFUzVFR1Q1?=
 =?utf-8?B?QktsR1EwekdkNUlGOUxSd1hQbVFuYUpEeDlDL0lkODhIOG5TamtXUHhmWXZs?=
 =?utf-8?B?RjhMWkt1SkUvd0tRVGx4TjUzUyt1OGF5eEVta0VobFh4SnhtS1hkZmJOVzhG?=
 =?utf-8?B?amYrN1lIRGUranZ1cnZ1YVRqLzA0MlRRVERuemJvNnJtVXJVTWJiMXZSc2NV?=
 =?utf-8?B?WVRoNjgxeXBHN1JBaytUZFZiT3Z2OWpmMERDM05KbUtFbUIzbnpUdUhMRTF6?=
 =?utf-8?B?OXA2ZjhhcFRxenlFSXE3NkptRUtWVWhrbmwwWi9OOXNnYnBiS0hNclNDMlY0?=
 =?utf-8?B?c29zT1YyVWV4RUo5dzRvYStkSGx1ZTFqQ2pFd0NxRUxiSjVZbWZZN0YvbFpI?=
 =?utf-8?B?SjBDak5oaWUvbS93UWdOVDFBRlYvcUsza3hFNVhYc1c5VDBJRkttMGErUWR4?=
 =?utf-8?B?aW9mSE9vMDRidTFObURJcmtvamFMeTEyZENweGlKR3Y2V0s0NnZKVUVoajNq?=
 =?utf-8?B?VjgzSDQ3TFJkbjl5QzJyM3JSQUtEcmhCZVdaaGJNZEQ4ckJDV0g2ay8wVW5H?=
 =?utf-8?B?MW93cFQ5dkgxVGJ0a3RZSCtrVTJTVlJjQyt1bmhsSU5MZWVvSHNVRkg1M2lC?=
 =?utf-8?B?cnM3d3JyTGw4RmJXZVdpSDY3ZnNkaThjd2VrTnhCbU85Nk5kYmpua1dVVWJk?=
 =?utf-8?B?dDlBcFE2bVczaGFzbE0wU0RsVjlaamR6bytzZWdHY3RXSEtiUjVvby9HZEpX?=
 =?utf-8?B?bmlPNFNUUFlFUWd5R2JxZjhsVWlRay8wNmptWXR5WUpDbjR3N3FiclFxM0Fq?=
 =?utf-8?B?L25xOUJIdDg1WS9FRlBxandkY1FDR2FlN0tQdW9nS0dGaEU3ZkpnNzZyd2dy?=
 =?utf-8?B?MGwrdEpuTmhkRTdGUUlLTldtNXgrKzhqTEFDanhUYUZ4ODRwdFlUb3AzSXhq?=
 =?utf-8?B?L0RYOWxGQXYvMDB1YkZITmJXODVuQVdFa1h5S1IvRE42K09LZ3RwUW9ycHJC?=
 =?utf-8?B?aDFrS0JlcWZMUENlM1lSM3ZIY1d2cDViVGZqSk04Mk91eVpDNFE3RDd0RDlI?=
 =?utf-8?B?RTgrVkpiOWNXUy9WRW5vazF1anZ2Mnd0R01ObXAydUU0ODhKS25UZTJOeVhj?=
 =?utf-8?B?VS9tQ1haZWhQOE9RcUo2ZHNtK29QcHJ6RFdpT3FYQUtaOWJRK0g4SDJwQWdl?=
 =?utf-8?B?Z0cwYkhkRVNTQUxpQ1JBY2dxMXd5dXhLaFh0ZGhYQ3F4TURTdURKcGt2WnVm?=
 =?utf-8?B?RlQvUUJqbWVPNlJaWWtOVjVYOXlyRWUxa0hMVGtnZEFIQUwrekd5TTFpWW80?=
 =?utf-8?Q?8BqAb1zKOtkyANC79XUvysxEI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c642538-7344-450a-88a0-08de25ad1350
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:44:01.9562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ6u9KcS3+HbfnZcjScquyf42z4fnVNp7cSnqoiFx/7w42uW0A3NRvsfCZ1edauJhrBDzePk9wGpmVz2bi4ygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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


On 13/11/2025 3:17 PM, Dariusz Sosnowski wrote:
> As announced in 25.07 release deprecation notice [1],
> this patch removes repr_matching_en device argument from mlx5 driver.
> 
> Applications which disabled this option were able to receive traffic
> from any physical port/VF/SF on any representor.
> Specifically, in most cases, this was used to process all traffic
> on representor which is a transfer proxy port.
> Similar behavior in mlx5 PMD can be achieved without
> the use of additional device arguments, by using
> RTE_FLOW_ACTION_TYPE_RSS flow action in transfer flow rules.
> 
> [1] https://doc.dpdk.org/guides-25.07/rel_notes/deprecation.html
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

