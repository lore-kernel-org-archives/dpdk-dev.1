Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED468CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 07:32:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068C140285;
	Sun,  2 Nov 2025 08:32:37 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22]) by mails.dpdk.org (Postfix) with ESMTP id 22FE640261
 for <dev@dpdk.org>; Sun,  2 Nov 2025 08:32:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtYuexJudsJtuGy7pblX8awRtIRCjtwqLQYiUb/NWzTdoQpzFWgR/QQAWSBFWVCclL/9V5AWjQHlcggvJEhY7c2zK7geY4t6n0sVg9B6wp9xVAV8fHKb3gIIYUUwNEuQisii2RB6tJEwRO/GqmRda/VZQsxBF0jXfw3rk8Nm9Pgqud+AxryjZIxMv7fUB8KrAyNuXUXpVq2txPzH1UxrBLOyhUp6e6BXG5LCWwDi7rFxj1pbVZf0Ps/LCRoZVo7GN2plHPleEQaetEL9iyyt8Ow+D3PzTpYCsXXjkuw5OnedO4xyMXYAGJO7WMjD4MfOquSWQAPTtO6H4JtcSrIWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8Uffmc+YzTvDRHiAKzxR3seg1RR6rEfG3qCPajS2vw=;
 b=K578ajpnYrndOBaWpdPmB/x/9cSikhiuBeHKILUd3Yk49oWSLq+8u8mNKuo82yiUvtKAmarq9oMympjw7PQ2XCvdxkvrgeCz6iA0GxGV04t3qbswlVKzXCWnph79d9kNkCQL+uV5c1LTH7HhnvhYhHuXTvLFL6cKhjsjxrMFEg8dvbeXf5zDzoQEZh2XgU1JJhoROFe8S3moRAO+AT7I9hL32HzfjRP9y+5Zdrp8TU//hpjZ73Pk16sBGG4dkvEr2vaQR+/262bIX/3ahz8G6Y9JW0h6D9dp9kfI5obIFdDMHi2VN4b4yI/kDT5rbj/Fkt4YzuxtafVpchDosg1VNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8Uffmc+YzTvDRHiAKzxR3seg1RR6rEfG3qCPajS2vw=;
 b=HPHNzpcuPs9HsTiAvpkgCKEgFi+iiL5w8pT+BkyC12v+Q+VJklwDsB4iIslPD6q/HFJp+TL751VutKMBojSmBZkLRG7DJuH35YL4Lp93SRdtYCv/2Qs7pSkAFE7evMewJE75IGrh5vVS7RZZyQC+UIl5V2Tk6/V61hyYSwj2csH1EVL1k8ISHK11HL0d0r3lydizOXC1/UTQjTet4leOGAJzC20huO7Psb+TQoL38yPk3F1TeMvDWmWIaxLqAVHi/F3StVz2+ypjc6swyjVWC9XlyDqfAESbG644I0G2EnZWsdzQeowwR+2oG0XUGvKH5veTXPKLKfYPvHe7qsyoVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Sun, 2 Nov
 2025 07:32:31 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 07:32:31 +0000
Message-ID: <f1218a2a-9f8b-43b2-96cd-94d87038c6ef@nvidia.com>
Date: Sun, 2 Nov 2025 09:32:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net/mlx5: fix multi process Tx default rules
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Michael Baum <michaelba@nvidia.com>,
 dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251029155711.169580-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251029155711.169580-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dd8b2b-36f1-4da1-2aed-08de19e1fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEUzSmU0ZXR5M3NmZ0pVVGF4dmtkTmZZNmZET3d6bVkxT1dTQ0tNV09TZDBJ?=
 =?utf-8?B?Z012RU9sTWYzYmlud21TL25OMllzRGgwYXVSaXJBaWdDK0wzbFhiTDZIOFNs?=
 =?utf-8?B?T2ZkRnVHQjhQdmRSbFVwdjVVS1VUVDRycmRZWmRHdnVOY3Q5UjhiY1k0V2xa?=
 =?utf-8?B?ZjRSN0Nmd0pEUHlSMEZMZVpBZHZ4VUdpd1R6OWdSaFhmSUw5Ry9LUmRHRjhV?=
 =?utf-8?B?WGFVSk5WdDhyS3lCZzluV2JPRjh0MmhXWStWN3NhbGxvalYraDlXZXNybnN3?=
 =?utf-8?B?eU9vNHhReEk5WjIzNy9JaFpCcmNQTUdyQnQvaFM3cVBXc0JZWTg3SkpxUjVP?=
 =?utf-8?B?TUlpN3lIczZ1RXdzUHhlb0MvVHhxOG9DaFZqNzBObHVicFNVUjRPTzVvT3hG?=
 =?utf-8?B?eEJwb0VJTDJKaElPbWtORE1wRGpIc1l5YUJMRGNHbzFCakhZaUlQN2hZYksw?=
 =?utf-8?B?UndoUEFyTHhPVVZDNUFpMThqMDhQcG5BcDRyam5pWUxvNDRGWG5KTXNUTkRm?=
 =?utf-8?B?V2pCM0hvN1cvdzhseHIwZmhlcENWNkVmQWFBWTl2K2JSU3ZyL0wrdTJ5T3ly?=
 =?utf-8?B?d254cVJWQXpaNE40WDV4UHI1bjBHaUQ4NGg4WkhSbkRCdTZtMWJRUzN2Y1FK?=
 =?utf-8?B?ZDRoa0lnRTRhVGF4YXlaY1dkSnFpRERwVWJ0S29obFBDelIxYmQrV3V1UDBt?=
 =?utf-8?B?Tno1cHFlVExlOEVQOXMxT2cycjA5UWR1YWdlQmllbnhoelhaUGVCdVVNdmZa?=
 =?utf-8?B?MEZ2UkVKTUpDY0prcmlwSExJUEF4T0p2WEdlN3NlS3k1OFo5d0dXTy9teUhT?=
 =?utf-8?B?a2R0bjRUU1VBSzZjeUNjOFZDaURuQlVsRzNoazUxTy9YblVEQ2FGZExSU3RC?=
 =?utf-8?B?cGVic0RsNlFaOEFrald3bmk4R252MU8xQklzR09rYjV4dXBISUdpL0ZMQUxx?=
 =?utf-8?B?L3l1MVVadVhrZzM5MGgvZTFiaWcyQTgwbFNaVW1xd3AvMktHeURwNExOMDNO?=
 =?utf-8?B?Y05SMFN2MDg2TEVlMm1mMGI4aDJWNnJ0RlRWNEpMSkhyVzNYMUVTUll3ekYv?=
 =?utf-8?B?Tm50bFNDRGtuNnZwZjB4NEJPMEdIcGorYzdGZy9HZmpiMHdFOVNWR3lDWUVy?=
 =?utf-8?B?cHUyR05FcXk1RnM0QUJZN01KdTBIaVFiUnlLSkk2V3pmSzh1MEJvY2xiaVRj?=
 =?utf-8?B?ZmhGdW5UNVhYZGtVTmJ3cjJFNHNjakRoNkFTMW1QUVRUTGFIZ0NUR1Avd0Nr?=
 =?utf-8?B?UFFveThBYnJKWldFUGZtQzgwYVFZZFkxelMvV2dORnc2RzhYZzFNNkxwck40?=
 =?utf-8?B?SmJJNVlOTDE5clF2Q3BYVTN0RWkycVo0WngxMnViVXUzeFpiUE1VTmJiMEZw?=
 =?utf-8?B?Nm11WDVmeVppd2wzUitiK2dpZ004WEl6eUZGTXVHQ0hmQ200RFJvUGpLQnFM?=
 =?utf-8?B?RUVxR3pkcCtubVc0YkxFN1NlR3gwbEIvTnRPTnVieG9temQ0ZjkwcW85WG9i?=
 =?utf-8?B?bUlYb1hWUUZqcE9PTEN0RDdtdjRCMyt3UjJ0cUttd0lDSXlmRkR3MitDbUVD?=
 =?utf-8?B?T0pFNExFbUtKVzVQdHpwWFNKMEo0dHoxWDc3R0RhQXUyWUs4cWYxSTJwZ3pC?=
 =?utf-8?B?UGNjTXFmS3ZvUnNrVjJHQUg3RktOdnZTVHpQTk16MW9RT0hLTE81WWlMYzlo?=
 =?utf-8?B?OXRrM0RFaU1SVWNENENxODFTT2pqdEl0NXBSVlVaNm95amhRSGFKVnFoMUwv?=
 =?utf-8?B?OVlGaVVRSXB6MWVGcmcrV3E3RUtTVXpyNDJhY1Vlc2JOMnlibWdLUlE5SjV3?=
 =?utf-8?B?WmpZQVJ3eFRNYzltOFNJWHdsUEMwS3ZiQTg0aTFSUithbkpORlo1YlFGOG9s?=
 =?utf-8?B?OVV3N2crL1lSeERtdGEwdlc4ajBlSzloN2lzK0hncFIzL1Q5WERTUUFJUkxh?=
 =?utf-8?Q?b1AVjMgsYdYxn+lo0iXZrOzVquxBqYhL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RncvUi9XTk03cUR0dHRUN2M1Q2ZQNEFZYWtuODZidldLbk12Ung2RHZFdjVP?=
 =?utf-8?B?SUkvQXh1UTAvZ0VmWG1vVGJadmRXU3plcmJDQjNQYkJ3TEgxYU1TYTNSU0RK?=
 =?utf-8?B?ckdzdjJDNlYxdG1KUk80d1NZdHEwamhMOTBCRXRadElmeWM2Y2xxNDZ5VzNO?=
 =?utf-8?B?VzdqNWJ2Qi9yU2h1ektTLzVHSFMzVG1LUVhCakZRYzdIdzRTOUJsT0lBamFT?=
 =?utf-8?B?aVpycWl5a1lHVGttUkwySDNWTUNqL09aM25Pb3FtYWh6U0F3R1BVZ0ZPMC9n?=
 =?utf-8?B?c1lteExhbmtPQ2tMUVZldG0reFVES2p0RkowQXc1cTBRb1Bvcit6SFdvcGFT?=
 =?utf-8?B?REtLTEc2K01OaVR5RVROZ0h2eVIrUVVJbW5uRHlrU2phS1hRaTgwUFdVWHdI?=
 =?utf-8?B?eElqZVFGdVIvT0dteDNYUEhiUmNpR0EvQmMwQ1FnZndwSXQ1dXpyL2Y0MDNs?=
 =?utf-8?B?NDlCaHM4aGFpZldLODdZamRJZ2ZjU2ZjemdDQUkrTkF0UjJOQXFsdkZzSmhU?=
 =?utf-8?B?eW42QWl4MFhsNllOQ0QremRnN2cyQXYxV3FqYXlWdnpnVjRMcHl2TWhoZ09m?=
 =?utf-8?B?czlvVmR3Nks1VVl4bFd3cU5tWExZd0o5eGE1TkVPZGtOOXZYamQ3aDhMTUlU?=
 =?utf-8?B?b2ViZ3BqMitxMllvcFAvcWFqVVEvR0RyS2dnKytabUR1V2JtR25MUUw4VHlL?=
 =?utf-8?B?Y1VPYXoxSDUwOGxGeTgwUWh6TENacUxtRFE1L3Vhdk1NRVJQczNRUWRuSDNq?=
 =?utf-8?B?VGZFTTBtc3hhSGR0M2RpRk9aVXl3UXZKOEJPUTlvUmpQS3BpeDRCNXB5aTV2?=
 =?utf-8?B?MDRjbHg2dW44MStEb3Fhdm9hVlA5WjFEVW9VbzVBZ1VXQTh2U1lNWTVOMi96?=
 =?utf-8?B?NUxjQnVhVitZbFRLQ3QwUDNZMnhjdmlDQmd3UWFyb2ZhTFY3QWVhZ3g4NkRO?=
 =?utf-8?B?YjgyUjJlWkdOZ2dURWVDN01zQUU5Z0lpSUhUdFM4MnpzZUZHY0tnWk5NWEY2?=
 =?utf-8?B?ZDNEZFYvam9LV1YxeXlpamdzK0UyS012ZVFoRFRMUlB0UTRwRTI3NkUxVzQ0?=
 =?utf-8?B?YUJqOHVjOWRyMmlIWlBzZHNiMFJGZU9SelNCc2V6NmZqWHFpb092TXNSdlJ2?=
 =?utf-8?B?UDZucS9la2ZtQVF1R3JTK2QwQTRHM2UvS1Rid0JkZEtjYVhqUlFRYXBoM05I?=
 =?utf-8?B?SktFUkZWWktkVWRYamJyUGt4a0hKblU1M09wOUhRb0p2V0VoNHBjVmhicHZB?=
 =?utf-8?B?Z1c1MFVjaC84RmwxdmxHVzFHMndTZWgrVmdUS1pEcTVaaG9DNlFiWVE1RkVm?=
 =?utf-8?B?MkxadUpQVmVNUk4vOFlJclpERGtkYS9VSjlVQ1N3WnkvUndBMEljbkFDRjhZ?=
 =?utf-8?B?Rlh1MDVZUHVDazZxWVdGenRueDY5YmNqWlp2Q0x0a1duMFF3azhXNGxZRnFr?=
 =?utf-8?B?dTdOakMyZklCck5GSXpBS1hrL2FKRTZoMmNON29EZkcwaVlRbkJLbWhoVUZu?=
 =?utf-8?B?bUowSHE4K1o3ZkV6M0NjYzdaUWNPOTZpbW81MFdpemk5RHZwa3dyM0hmN05m?=
 =?utf-8?B?YlJ5N2h6Z1FvYlNtVjZmeWk3SG96UHdtaTFncXQrOFRSQ0dHL0FNRzhRR3JY?=
 =?utf-8?B?SEV0aXdlUjU3ODU0d1p3d2xTRUwzZ2VQNU1BRTMwQW01cFp2eVorekF1UTg2?=
 =?utf-8?B?TGFzSmh2ZDhFUTAyMTVBWFZoNkg3WHZjL2MxckdYS1kvOXRYdlhsQTBxRjdz?=
 =?utf-8?B?MTJXaEZzR2daR2xwbzdERTJwY084ZTFQaXp2RXlTNUtDOHFnVjRFTTR1TjVB?=
 =?utf-8?B?UUkrbGFta3VZem9sYXl1M0V1TDNzYnMrK2tqYnp1YVJWdmtJdGRpZnBuRk05?=
 =?utf-8?B?RFd4RzRtYVArUHp0OWRYWG5aUERzSVZtWXpOdFVoL1lwVnlDbmdzc012eTNE?=
 =?utf-8?B?WmpIV1ZLZ2VIRXZIanJ2KysvcUY1b2g4NHM1bk1icFkrZTFrOFJyL1ZqcHF4?=
 =?utf-8?B?dHVEcTlrT1NOSkFpUnhkM29Xd042Z2NFa0o5amFJUTJGOVlOQUloMkhlbDNX?=
 =?utf-8?B?WUx2UmRYNCs5dmg3R0xBOFI5QnlLTUxtQVNjdUFmRTAyWTlodUgyRXBrMC9s?=
 =?utf-8?Q?ZNyJ8DRyb1V/3LWFo3kwzGk0Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dd8b2b-36f1-4da1-2aed-08de19e1fbb4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 07:32:31.6713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qia1ge0ZGI6uBd4kZomzERB/gOo239DKvI0lKdkqFCF/7oGtXMXCM2/vhEOYxyGBC/yi/53oiy34i/MnZvz5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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


On 29/10/2025 5:57 PM, Gregory Etelson wrote:
> From: Michael Baum <michaelba@nvidia.com>
> 
> When representor matching is disabled, an egress default rule is
> inserted which matches all and copies REG_A to REG_C_1 (when dv_xmeta_en
> == 4) and jump to group 1. All user rules started from group 1.
> 
> When 2 processes are working together, the first one creates this flow
> rule and the second one is failed with errno EEXIST. This renders all
> user egress rules in 2nd process to be invalid.
> 
> This patch changes this default rule match on SQs.
> 
> Fixes: 483181f7b6dd ("net/mlx5: support device control of representor matching")
> Cc: dsosnowski@nvidia.com
> 
> Signed-off-by: Michael Baum <michaelba@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

