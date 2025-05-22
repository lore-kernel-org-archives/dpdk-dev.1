Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67632C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 08:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A9F9402C2;
	Thu, 22 May 2025 10:44:39 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by mails.dpdk.org (Postfix) with ESMTP id 26B2F402B9;
 Thu, 22 May 2025 10:44:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbmhkJ8s/QQeuQaUnUF+dRjUoLbpfL8d/HUzyhl8B3k9wUzQwUm/nZGY3DzAf7vYm3IYphX1s9PyIcBxzhuHgfR+aQ/xjhBTI2ov3UjzzAygatcX/yuWnbvbjN04w+s4182Qh8DefFr+3UjWlZNR0fmSNPdHaQxWVRFiNUhIN2DYUXK2SdQGNpotniDNL0oCjSnICK4gZdKMKmIDGDWGw0xzI3ARgeWng3PZgDCkOyj9pDAl0wQQtMkyJQ1Cc7ohEAzqulyFKUMebHjWprxDGzA/C2BwnG71No7nUM42ELebDxjofTGEeoUaOjmcnlld7ymcJtNc/77BVdqOi8G/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlKKJgQ0y4WpUp7dqjzkBIzlZxbrmqg24Z/ZZyR8ymY=;
 b=zSY2KI/L/qBV3hXvm7sur7TbIIMRi3qbUKBsc9jAN0Wv0JIsnsdxOx+EBTu2AzC4/lRHobz5dFAmygwwBLlSU0LabdQOHBg3N4+ywuSj4Hq86Kba3DC3cKdbxnkWyoI45LDCqAhuGBMSAHdj/PdPFv3feeiWYpseepkUSsJ2oQMDAJuHR8ZxUq0mI9HouHLQGoJHjupOrftSsYSBbyIiZjuHEOZcHp1y+6g4dCw6f8A9l86KsYnJ4V02RnXSyy27d+FORYbi0JwrDpLasAdJsaxp1u0gkk1qbTj+oX1hbbzoYZktydm/3KYeATPp/iGP3St26F7JNq8U6waeqJQQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlKKJgQ0y4WpUp7dqjzkBIzlZxbrmqg24Z/ZZyR8ymY=;
 b=cTzB4qfPpWM9LXJe7t+V7R5SgF1HjC0gKpyILGvuWRuTPJtfzt15P07HjbuBS+NoQKOuAm5hFN6SttS9DzUWsUAuAU60g8XE9ec3EZsFhou92ygCisLRl1AqijUyB9LQ8z7/0H7kwzXXivbyNoTDn5S2OB2qHaMVPAsVayvhoDFpxUZjvk4fb7Sa4HRPBCG/EHfUz+S6kf0u1IoJYzJF0trTbbBrcthBMm/Ml6KcavjCimVQsU0ZFYxUC11yFWaX21Mlz3rHzZyj/lpl81135E5X7yGRk6HQKrGhhXcs299WwlrWMuUN/kwk/Lo9aHrZoH9FG9K/77LUn5vVDpGB+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 08:44:35 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 08:44:35 +0000
Message-ID: <3be89bb7-7ad5-4002-8dc9-b9067164d8da@nvidia.com>
Date: Thu, 22 May 2025 11:44:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: align PF and VF/SF MAC addresses handling
To: Gavin Li <gavinl@nvidia.com>, matan@nvidia.com, viacheslavo@nvidia.com,
 orika@nvidia.com, thomas@monjalon.net,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>,
 Yongseok Koh <yskoh@mellanox.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250516071032.4357-1-gavinl@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250516071032.4357-1-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: f895dbaf-c301-4bce-386b-08dd990ce099
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUhpdHlEbHRoeVZ1aUVYVDFVYlZBV280c0JoRDlpVS9xT1BnTTBYSkorWk9P?=
 =?utf-8?B?QlJzVm9MVjl1Y0lPQ3NLTFpDWnMrYjJqdzc4YlBSMkc3Slg0czhndEp5NWph?=
 =?utf-8?B?MitNNW9aS3dLTUdTWGFzM05YVXByZVVmQ1BaeFRpdU5DQTF2MFhoN21sczk0?=
 =?utf-8?B?ayswM21oaWxyZEZtQmgwTk1ZaWtMTGYzS2dWN1QyRWhleG45Yk1DLzRlMTM4?=
 =?utf-8?B?byswc3hVb3RBTjN2ekxqSlRiajdDck4rTmp4UUNqWm9pUG50U1lLU0czVzc5?=
 =?utf-8?B?SnRVVTlOYzRHMjM3QmxidHB3Vndya3BtMnFodTBkTDBqSVgyOHEyUGplRmwx?=
 =?utf-8?B?L2QwK1ZUUGw2WldEYmlHT3FHVkVWcURVdXhsY3Z3b3NER013UVI1aVQydStm?=
 =?utf-8?B?eTg4RmJWdG9lUjh5UUUrRktCNUY4R3pxbkUvRGt4cmVLK1RHcDVCcElTNkNm?=
 =?utf-8?B?NXlEcEtSYzM1c1d4bUwzZnkvR0I4Nm5tL3UrTEpMVTFLSGtkZmRuNUJKVmdY?=
 =?utf-8?B?UktsWVJiWWYreDFibGZJaXBzZzhOSTF5NkdYY2FqOVJicXVZU0x1S1VZeHRh?=
 =?utf-8?B?aUxwTHl1YlRJdXVoMjRWaGVGa00zMjh0a0VmaVNXU0R4cG9DK3kwRXM5dUIz?=
 =?utf-8?B?SFNTc2JuT2tFTVFyUEhleFNqOVJ0bkdzQmhSdTIyaUJITGcwUE1kV0ZhMWdH?=
 =?utf-8?B?ZGlkOStZN0diYkNRY3JZK2tSUkNTSGVsdUxFUzVhbWN1Z0l2WHVEU2FwWU03?=
 =?utf-8?B?cjcxMnNkeXFpSXJLSjVxTDZiVTF1eW1lMmVWMUpVL1dHbFVFSDJGYWswcWly?=
 =?utf-8?B?bWhONTc0Wmdqc0FsUUo0WHZSaFpXWHg5T3RxQUJCQXBDQUJhYTlqRjBQQlo1?=
 =?utf-8?B?VldwcUV0MVpMWFhpbjZhV21NR1lCbEwvZXkvN3gwWnV0NWlaRGh5QjdXTFQw?=
 =?utf-8?B?djRPMlJ3MEsvSjBOTndOaEszYkFmektmZ3pFQmROVmJ0MFppbDZUcmZvUlIw?=
 =?utf-8?B?RnNaZ29ORU1aNkdDQWhhaVBnY0dMSzl6NDg0RkdrdVdJVDVyTWpmOG9qUmJo?=
 =?utf-8?B?U25ZL3dWeDRYdkMwU3IvbmR1VEloMjJRQlE4WVBQNENZWXlwdkpDeEtEOFRB?=
 =?utf-8?B?czJyM2tLM3JxZ3liWVdsbmI4Z0hmNUZxNmI1eDdWZERlRTJ1cXEzV3Z5ZkJN?=
 =?utf-8?B?Ulp4ZXViUGRMclRNdXZzSktVUW5ObE9BbTNtQUJoNS9yUVVnQTEwcVRtcUF5?=
 =?utf-8?B?MmxUcXRoTytoQmVuL3R1UzB3QnZJV3JoRWVWNjY5VDdtWUpvekFoZUVHVnE4?=
 =?utf-8?B?TjFyWUNpMUJDL1IvMGxhVmFIMDRaVVZyTjdlTEZ5dFhlUzRiYTNsQUZHdVky?=
 =?utf-8?B?TDVjYmVXSEt3OWluMTVTY3dZdXFDVnkwWUcyOHo5UiszRHE3M3kwS2FJNTBG?=
 =?utf-8?B?d0REcEduSTlKQ1dOOUd1ajd2cEV4dVdKRlIwMURja0xGR2xTdFhKa2NzQnlo?=
 =?utf-8?B?ZWZqZ3p0M04vRStNTHJ1QUgrL2RhN214YmoxYkFPQ3lzSHdXcXdrN2pWKzRr?=
 =?utf-8?B?WVR0WjJjbzU0RlN4Y0VPdU9zcFZqY1lEazVlc1ZsZHFKY3lyaGdFOG9sZEJU?=
 =?utf-8?B?anlZYm9jbHI4dFU4UWdpT2FiT3dYTlVOV3djUlpOdkFaT1lQSTQxM2J4anRw?=
 =?utf-8?B?TjlwcXkrRW11b1RZRzVCNGVJVUEwTFFyVmdSTHhpYWFyRm95MDArQXEzM3Zo?=
 =?utf-8?B?bjZGR2JNWDJXbEtvUWJHKzFrc0lHb056MGtkYXFKSkFFVVZLZ01vNHF4aE1P?=
 =?utf-8?B?UGQ5RkQyS1Vpa0xNVnUxWTlVck1lVC9GNVkwakw1N1JMclpOWlMwb05WZWxy?=
 =?utf-8?B?SmNPNkdHanhrejdoaXA3NWhsOFpid3FBaU1JOFFLTEhIVGp6eUxuRGNQZno3?=
 =?utf-8?B?ZU9NNnJqQUo5ejVhTTVJVU9hUUVmTUJVUHFZT3k5ZVpueHZmQVFGMEp1NXVQ?=
 =?utf-8?B?b3h5TWwyYmlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enMyOHNyelZXVlhuTCtYcTJodzBja1dQWCtSbSs4Rnc5bFFhWThGZ1JvR05p?=
 =?utf-8?B?KzBYRG1zMWcwR2k4NGl6SjFjRE9FSjE2TXhiUTJNQVc5RW1FNWZGajJpQW1G?=
 =?utf-8?B?SW1Ca3JkRFBFVE92dmVJSFRnNmFaakZvZkhkc1NZUG5RclRVNXFtUkRubU9L?=
 =?utf-8?B?TGhxMU1tQ2JnM3BtTk0zQzViNDhWczdxNUVPMlZXYUZXaXpIVW4xdmVudi9P?=
 =?utf-8?B?SnhkVjE2ZTlYNFV5ZlZJWGNQb1dxQUxhQ1BwY3J1MlpDVVJ3Tm1lcVZXS3NH?=
 =?utf-8?B?YTlqdzQyUjZQWUVDTFg0TjE5cTZLUXNIWEl1RG9WQVMvUlhjZTBlTUhWbTZF?=
 =?utf-8?B?S0dzUS9ZSGQxUkd0RXE5NGxSanhoTllyYndYb29Ha3NiZ0FoQU9tbVpZc1dn?=
 =?utf-8?B?VnRoejYrUGtCZkV4M2VhSXU3QlNvcXd0MVhEbWtCSGhCc1FKWjlZSU1NNnZt?=
 =?utf-8?B?NzNUbkFmU3BaY0hkTlVFRzZFTkY2N2RJSXFOQWt2T0RYL0prUVUwUW0wbDdC?=
 =?utf-8?B?UDRYZlY1ZHE4SDFObVVoMm16aW1STmhrdGRqaWdTMDVyYnBRTXNtZllXRVNx?=
 =?utf-8?B?bUJHSTBieEZKcm5BUkRVZW5FaWY5eFY1T3hYVVZrOU4rZ3hmTk1TVXhQRUVY?=
 =?utf-8?B?SjJrcDloKzRza2szV21LZkRCU2V0b1RwNzNQZy82OVpkb1JvTis1dnNvYndO?=
 =?utf-8?B?NWlML1F0Y3VSSkI1czFvcHN0TDNpOUVOVTBGUWxsWnFBSzIwblZ0dDVyUW43?=
 =?utf-8?B?Um9jMjNJcjA1dkpWT3RoZFh6dUJyUWhmanA3TUtxWlp2akxMdXU2Zmk0NWJ3?=
 =?utf-8?B?OERXQ0k3bjRIQU52cDNwUGxPa3BNL3llTlZJUm1PODFOWTRBMGcrNEk0ak9M?=
 =?utf-8?B?cXMzVldpTXR2b3krUzNzRkl2MjZTR3AwVnNkenFYb1FoVWd6UzFwK2hjQUo4?=
 =?utf-8?B?blpUTzlCODVLeklmWjk5Y3B3UjBadGtxWmkvdVlBTUZlcXk4TUZZOTN0ZzBh?=
 =?utf-8?B?L2R2aWc5Y0xxM01nSmdYN1ZkVFhoc1MwckJCUXBqajRlbmtHa1ZlMitHMGEz?=
 =?utf-8?B?bG5WRjhMZHFCSjJpNDR3c3hhL0hnREdnR0ZKWUVnaTA0WTc5VmIxeEtKaHNp?=
 =?utf-8?B?cy9mZXN0d3BaaU5HYW15SWlxM29BVHlNeXk1Umc3REZYWmVzaHFtS2NMK1Bo?=
 =?utf-8?B?STZsSWFZa0ZYV3N4Q3kwV0dFenR1TS96ZnpmRWR6WkZlN3c3a2NOZlRjU2hn?=
 =?utf-8?B?cEczNWJiSVQ2NmwwMlcrRW45N05jVk1vZGk4aHhCcE96ZHd2R2M4c3VhVUMr?=
 =?utf-8?B?RDkycUQ3N2piK0g0WFE0MXk2MDVPN3VTVm1KMm51d1lycHBtVzgvWndDb0ky?=
 =?utf-8?B?ZUc1ZFRTM1ZJcWg5em5BWjlIZFZzSVVLRG04ekNxVzA2NmRhUlc5SlUxb1l6?=
 =?utf-8?B?UVc3THcwQllUbFp0TG5mbTU5RmVGT1ZRUmZqN1ZtWjltelNSR1V0SXh3SWhv?=
 =?utf-8?B?djNBbmt2NEU4MGxSR1VtMjlNRHcvTFlsVFRuUmlJQWUvSnNYTThtek5jdEg4?=
 =?utf-8?B?MDN6blZVaFQ2bHY5ODZZV0RmelJKaERXYXhQK2hOalNrdzNMd2taeGlxUkJJ?=
 =?utf-8?B?TGpncFlJd2J3dXZrMWNXd3BRWUErMkQrS2JnRm5pTVJqWnVNVHJDVEhGV25a?=
 =?utf-8?B?eVR3bXEyRzl2NTloM1BDT1dZWGJHSDE2TE1hNnNtczRLOEdUYkVYLytoK25K?=
 =?utf-8?B?TEZ2V213UTB3WktBYXhtcFdMcmF4MU90TlRFbW51a2VqaUIwN1VnYXp4N1lD?=
 =?utf-8?B?cG5SK2lTS1pWdWgxbmFBU2tucDRKS2gxMHJ6K3VkMDRzZmJCcW8rZnd6L2ZE?=
 =?utf-8?B?dHZ5SGlNeVpCdlJRbWZaeGdMK0dJNlduWWovS3RzcU43VXBwUkFJSzk2MHlC?=
 =?utf-8?B?eGE1am9tYVB2clRlMEFHR1BBU0Ywc215ZkdXeTVhckxxaFoxUml5OEszREZQ?=
 =?utf-8?B?Rkp0cFhKa1FKU29xUGxPd0RQQnNjR0VyVWVuaFBxOW8yTFlTcDNvd0ZlakVT?=
 =?utf-8?B?aGs5cjRYbXBrakRuLzFERUFXRk45VThGTFh6azRRSHA5UlpZRzJOM2FySU04?=
 =?utf-8?Q?ZVKeBPXQgqTRh7r5uLpwzaWpy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f895dbaf-c301-4bce-386b-08dd990ce099
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 08:44:34.6270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79Q0vTSzcwBtN4xB4Vk+i3ytG6e1W6VHPfoCNGovUJ4imz1pyEiVysEKhf+gd0MTBLdj+epp2gbJhiKLOuln/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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


On 16/05/2025 10:10 AM, Gavin Li wrote:
> In the mlx5_dev_spawn function, the Virtual Function (VF) synchronizes MAC
> addresses from the kernel using netlink. It queries the netdev-configured
> MACs and populates the list in the PMD device data, including multicast
> MAC addresses. These addresses are later used for control flow creation,
> allowing traffic for the listed MACs to be received. However, the Physical
> Function (PF) does not synchronize with the kernel and thus does not add
> any multicast MAC address rules when enabling traffic. This discrepancy
> causes the IFF_ALLMULTI ioctl code to malfunction, as it fails to disable
> all multicast traffic, leaving the VF still able to see it.
> 
> To align PF and VF behavior, only unicast MAC address flows should be
> added.
> 
> Fixes: 272733b5ebfd ("net/mlx5: use flow to enable unicast traffic")
> Cc: stable@dpdk.org
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> ---

Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

