Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB32ECD983
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6577410DC;
	Thu,  5 Feb 2026 16:58:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by mails.dpdk.org (Postfix) with ESMTP id 61E21410D5;
 Thu,  5 Feb 2026 16:58:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJuIb3YpAkqyFRpFsUy4sHOL86/Ziw6129hdRIO1sptbx8tS8SCmozta7kuayx/OU569cUybb4TVSeXB/i7cuxDhvoiBJtaf6GXt/v5oClV7G8oQ8uDb3W/r5Sjvqunyk/CyFrluBdbgGsHGL6TrQ9u7GMPxz1TCCF/EbSvImWMWEsZL/07YkmcnD7pMiJRzzaWNyiqbN2rTFPoaP4pkTC3urFdh5ZpdR7b6Go2lpqj/ek1xaMHOb+la3D6oVpn5jLOM5k33vebaWwffQLvs3ZXKEuOk/IOCMQ1xOHbL7kY+yciaooUQRwPbnYAbVm+maNwSPomQm+SU/fmhVTFkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXUd+dVVCfbftBq3cbBzpbKeVyINWMcmJNJAV2AuOY4=;
 b=g5NZ7ZOmXanoPk/A/wK42Nt/fSsWVbwogwizK4S0aURRwVyEX2W6FlkiD0kRqOwA0kuF69A4awTrdJNOLIg0I/Z4ysUH4HoE7rUg+9ypxgy3TrNFq56eJlFuQUvDLjw6fxOAWTVmnJ/DCvpk2lxLs6n3FNEnW54Q5HCRNUxQHKtPpLAcpuJYAxdH+fKP6aq55u2IT05Z1A1QzTiLDi7R3QVyvVizs3zWSPQlBh4bkGr7caJvTs42UWLlPI2YtX6o5I/wKUKYnJyp0iygHeTkjPtFPxv7u77Z1+TDTPnNvPNEFnD95CFH2yTTcpg7J7bGPlYr4rRDzAWOf2MNwNP6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXUd+dVVCfbftBq3cbBzpbKeVyINWMcmJNJAV2AuOY4=;
 b=cpxViK8lpDQAiXYU+g3f2h0SCzDzT1Zz5k7n7uVNUoYE1hx6pMzRVqNysV/aUiYvlLvz1xSPzheSzCJQLupSW9Mios1IcnpV5/UyyNlMUO/mJUtcY975D9893r8t7/zrc1DVzjE25mdPJQr4AYgIc2FOzRRPT2TysEb5WoGJ/AjgDRbxp2kLU2y8yfr3xBhrbSDRxsrFdIpzeP7Bgg4tiCRT87mG4W941SagdH6KHJkqllW18PD/N3OIidA+szRw1Q/SNLa2KbQqQDOuXkRSkr8/dVqVsg86XKUtUpEnR+ERUpL3AzyzDC0861/spUlMqyKme29rwVngtmpd8KLScw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 15:58:52 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 15:58:51 +0000
Message-ID: <d77bacce-7600-495a-a770-8d3c5a7cf82b@nvidia.com>
Date: Thu, 5 Feb 2026 17:58:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix SRH flex parser initialization
 synchronization
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>,
 Alex Vesker <valex@nvidia.com>
References: <20251225162049.648482-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251225162049.648482-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a682d34-8b5f-4003-178a-08de64cf74d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFhzcHZ3ZnQxcWJRWFZFdStPblIwUzNDclYxenNBSlZxV3RVMU9mYWZLbDZW?=
 =?utf-8?B?MDYxWXBOOE1nWWhxeVRKRTBJR2RucnZjd2FqNE81ZEdLU2dFbURvYml3QkV0?=
 =?utf-8?B?djlvV1Z0d1AydUxSZFlxb3E0TmpJSzJpLzk4bnFieHhoeGhIUklLZCsvRldk?=
 =?utf-8?B?OVp1S3NWZGNibmhpcCtJT0dLcndvYVcvanNleWhIdVB1ZnhncFlBaW5nd0Yx?=
 =?utf-8?B?ajB4b1JlUmsyckJyREl2Qk1ETlFnaGI5emNwU1ZIYmZjdHBFOGxmTjNLaGp5?=
 =?utf-8?B?elAwTHgxTDFPc2YvaTJkMTZFb2NvL2VhL29ES09id2xaT09OVEtRTTIwM2Nu?=
 =?utf-8?B?anpqTHUrRlEweXhVRFBEZnQyc1duZVhucnR5MEZqOWxjWDRpN3RPc1pMZTdQ?=
 =?utf-8?B?MnBkMTZvbmc0amlSSEFOcXF4UHJ5dWJPTktCQjZxSHVxd2g0amI1TlVEUGNY?=
 =?utf-8?B?bmxaSTZpeUJKWHNwSVhKQS93YXRNRXN4MDhQU3FUL3lYeEE1aUtwR2pqQVJ5?=
 =?utf-8?B?NzE1WkJLYjV6SHNFVFZZSUs3ZXJLeDlMNlFocXU3UG54T3JWRWl6eFQvS1hB?=
 =?utf-8?B?aTlHTUZGbkZadVNMNDBQUjRGSHR3UWRqMkIzZTM3Q1AwOTRrbXE1VitGYUdS?=
 =?utf-8?B?cDZlNGdtMHlTcnU0ckpiT2h6OHdIWTdmVDUvN2krd01jNitzUFg5cExnWmNN?=
 =?utf-8?B?S2k5bE9teWI0WjUva0JIUk1ub0htQ2wvZ0MrNFRrd1F0bHo1dUNJeVhwZDVT?=
 =?utf-8?B?bFY4ek9CTnFLKzVkbXhrUEpRSC8vWUNwN2UyODdNYzJxUUN1bVhFeXBEWHBV?=
 =?utf-8?B?WXNiSjZkS2pJRWQ2enFBQkI4ZitxSlFvek85QXhjalg3Q1dWSDFRR0diRkhU?=
 =?utf-8?B?N0Y5NTVSdWZwb2RMQmtKeWJBYjZ5NjU1NDJUMmI0RjBYeTQyUGxwKzhQcDVk?=
 =?utf-8?B?QVVjMyttSWZYY0hidHRwZVFqTVltellVdXNGL0p6WXkzNW5uOCtYM3VYY21C?=
 =?utf-8?B?dG8xOWtrMHpKeHB6VExHSTJrU3ZxNkNFWUU0UW8zRElZVVVvbzZRY0xjM05L?=
 =?utf-8?B?Y3N4bzJpOHJhOVZYYmVuQVpDR1EyeWVkeXdxS0NwOEUyOWprN3J5b0JIOTJM?=
 =?utf-8?B?QmZHeHJXQ0ZlZFNacHBnZFhvaGV3Q096b3RGNnkvYXVXUk1WZ1hPSWZrVFl3?=
 =?utf-8?B?UlJrZVNXcGJiVVJIdGtoWEdMRi9TQW9IRU04VUxxV1RiZTJIY0JodE5uMkhp?=
 =?utf-8?B?MXJlTTNZcjFZRExHRXRPa2M3cVVCcnZnQUJsWTQxMGh6TkJFa05aNFJ3bzhF?=
 =?utf-8?B?VkhBVjZhYkhObE1seUthZWJZRWFEblFYbWpnTThiby8rUWZ4Wm5Fb1ZLWEUv?=
 =?utf-8?B?QjRDY2NoenZKVXUwQWZsOWRERG1ZU1VCZnNMZGFiLzlGV3ZGSFNmRytzZTQv?=
 =?utf-8?B?RGNpRFMxaDlOYmxiZ3ZxaXJqZU1KTjVYZ1NNdzBtRDg5ZkQrQTAyV0tyeDI5?=
 =?utf-8?B?ejAwT0ZGNlo4S1NvdklqaExZUFl0Qi93UDRHalZjVk5PVngrMTJRTzFZN1pU?=
 =?utf-8?B?ZklFZzBuWnlZR2N4RTR1alZYYlN2UmNMZVd6RjRQU3ZrWmllQ0JqNXVHM2d4?=
 =?utf-8?B?U0QySllwNXdBZzBDNWZPelhLckpVN20xK1F2K0Q3N0FsQ3FzSE11eGRBbW9S?=
 =?utf-8?B?ZmVSRk1qdzFaQk9pN1YzT2d0cVpoRk9UNUJWRm9ZVGFucFVzRXE3bFZPYU4w?=
 =?utf-8?B?dE9mVXZLaWw0RWdTWnhOZktZZWNNMWxwY3pKRnlvN3NobC9RTW9acFdRdWo0?=
 =?utf-8?B?dlBmVlVqTjMxemRSSGlEaGtVL3Fsb1BHMU5Id2Q3OHJBbSsrTFdQY0NSOFl0?=
 =?utf-8?B?d25tcVl2bWFCMnc2Z0tRV21PVXo0V1UyOS96WVZKaWJmTzh5SEpYNEQ1amRK?=
 =?utf-8?B?OFJySEt3dzZuRklZa29Yc3FWV0JxcytBb1doZVVmbFRZSTNrZEVta0xBcWd0?=
 =?utf-8?B?ZmRKcVlQWk1YdmpqblNiSTJFUzJkSnk1Z09ZQ09lL3NxVzZpS3dkRG5jaU1N?=
 =?utf-8?B?bG40Nm5zN1Q4Y3A1cFJMOXVUV044V2JvS2lGZW5reWpUMDNHMTdpRDhHSUZM?=
 =?utf-8?Q?tnaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhjSEI3K3JTWXpTM0ZqOU5lVVd5Sno5dTlCSEIwRGtrWHh0NHg3QnB1UGRB?=
 =?utf-8?B?THBSek01T01HZXYySCttRnlXaXVzdHdNd3AyL211S2xpZS9pQ1d1QU5FUlJB?=
 =?utf-8?B?ZEFFcmxNZmM4R2xSa1gxaFlvRXdmNW8zQVBaZmhuTkNzcVVmMjNOb3BBRGFX?=
 =?utf-8?B?bXhDTEgyMlM4bC9GeVV1WUtHcitGbXRab0ZCLzdsRC8vREdnL3dhekoyQUpK?=
 =?utf-8?B?M0FMSFlndlRheGl5b0lDbW8xVENlYk9iOU9DOUZGaFdNVmIwTythNnJzUXZr?=
 =?utf-8?B?b2pnRE9rTjY5YXUzVXIvYXB6TFVPTzZLMVVlc1kwOGgyWENjYWhiMkMyTTZV?=
 =?utf-8?B?MlhGTU9COFpJaEQ0cHdoYzdKMG52blQvL1pzWjZ3TllqMmpSMHkySWZsL25v?=
 =?utf-8?B?ZTYyV09rd1Z4cWdyY21zeFlxWDZKcEpGMHQzZFp1RXBCQytjYTh1ajJIUXlV?=
 =?utf-8?B?OWJnTGkvdFd0V1U3dzFSNU0rZlNteGlKMy9CTnY2R0laYjFObHlRc3ZxQXhV?=
 =?utf-8?B?RHlrbUpyQnBaN0d0VmJBOURoUW9Iay9wYnJkdDdjQlVweFFkaUw0SmdkSkFM?=
 =?utf-8?B?Q2ZoK0dLbDJjWkQ1a2ZpQjdVcGM2c2FPczVTdDczRUNWN3A2b1lkQTd0TWRt?=
 =?utf-8?B?THozK29jOWMyQUZhamVXV0RaVVA2UDhFVlNhMjZVQ1BGS2NsV1lLcGNoOGRh?=
 =?utf-8?B?VHJQTzNFYzZsY2R0bmRpTUEzZzJRQkhzOS82UGdRcTlDQUMyckVSNEdHaFpI?=
 =?utf-8?B?QTQ1RjliQVVqa1ZtT2dhVkc5bER2YjdqOW1oYVdHdEczVFhyc0kwOHNpRXFW?=
 =?utf-8?B?bGdaODJSNW4vQmRZT0dXYzR6Tk1KQVB0d1UvbThSKytPa0lyYXFyTDNWOXBi?=
 =?utf-8?B?N1BUa21yY092c1VlYjJVajdPMHIzbjY3aTROR1RWTkZySSsrR0ltbGFMbWUz?=
 =?utf-8?B?eElIS2dCTDFYRUpabmN2aDRKbE5Pb3JVcHNyYURzZnhvTm1UdkZQKzIyUnIz?=
 =?utf-8?B?Q0ZRc2lPSTh1Ujh3bmdVNktVbVNROXp0VHVsS0lKSXZ2eTVZL1lPc2ZmNHcy?=
 =?utf-8?B?RWQ1dEFKMDhwdi9lV0hxY3VNYm9mNXVhYU9LYUdnSm9hVTN2ejUwU1YxbTdp?=
 =?utf-8?B?QzhzYU81YzNjL2MvelFIK2lzT01aUW5veml1RzQxZ0g0OEFITm1yQUc0R2wv?=
 =?utf-8?B?RGJicThDa1BtU2lKRmIzOXBHM3hBaUJ0UlFrTU40a2N2UEJhWHZpS0FyMHVu?=
 =?utf-8?B?SUFncklmdks0ZEc0SHNVRTg3NE4rVTMwenpCQVZiQWdvWlBoVE5XZ1ozcU5W?=
 =?utf-8?B?QlR0YUpmV1ZHM0xqU1gzTm5rZ1gwODZpOHAyMko0ci9rOUlwWFlvTWV0ZVM1?=
 =?utf-8?B?L1RuRkY0Wm9IRStGeGh4Ui9rTWE1NWM3VnAxSDk2MUszMG8wMUVFVFd0Qzc0?=
 =?utf-8?B?MWlVZ3QwYWhqa09sVkVkYTlwYkpnTnc4cUJyZ0JkZmRGRFdRRVBxRUUxMWpJ?=
 =?utf-8?B?RVRYTTZyUjluRXAwb24wVGtrakZPYmhOWkkwRjBtOU0zME0ydis1Umtvb212?=
 =?utf-8?B?SkFmUndIVHRsd2pSYklhb1ZnWUVkSWdNbmlsSktRbEljcVROcm96ODU2ZkJv?=
 =?utf-8?B?b2pYV0NqcmlXd1gvZ3p2bXQrNmF6MkVycHZIOWpVWk1odDFoa2VEbC8vR2Rh?=
 =?utf-8?B?U096QkZ3ejg5T05IWFh2emdYRWg2d0ljQ3huWjJhYU1NOUVxNFEya25XTjN6?=
 =?utf-8?B?YThLU3dFbjllNmRqci9ZTEgyYnY2WWdaR3pJeTV4ZDA3TmRFUmY1VVRMVWRE?=
 =?utf-8?B?T01xbTB4UnVEdHYzZ0NwbDJoOTNmSTBOeVhwM1hoYTd1SmJva3dzcDVTeHFQ?=
 =?utf-8?B?N05aTnlMTzhzMFc0eGg0WWhyNXE1Y2VPVzJNMnBkY3VWc1FWQnp6bFhocmtW?=
 =?utf-8?B?a3BFdUxveDhiYVFXL0h0S09kYUhuRndFT3FURkZwMU9SRU5CV0JhMzNQWnc2?=
 =?utf-8?B?MFdiSEQxcnQwTWZaK0Fja3FqeGRWMTRrYWh1bHRTVWR6a3FwOFBzVURZdG9p?=
 =?utf-8?B?MDFUMkYwVFJ1cHJ5b29ieGlHYUtXQ0Y4UmNRWHRCZWcyNHE4eS9EU1ZIcHRO?=
 =?utf-8?B?d2dSVmwyaWlRaXRMQzlzMStneklKc2REc2lUZlJwTm5PUE5VOTdHbisyWlFt?=
 =?utf-8?B?SzhjcjZDOG5OV1JrV1ZLRldtanFadkZJdG5Dd2xGUG9MUmJtSE1HNEF2bXYr?=
 =?utf-8?B?VzZIWUp1Tk5hT2ZuY1gwaW93NTJEdnVjcXVVcWlNS0toVUR1OUlFV2xKSVYv?=
 =?utf-8?Q?g39MSc9v7Z5Pj9nd4g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a682d34-8b5f-4003-178a-08de64cf74d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:58:51.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6gYFj4I4gcfV78CHI4L4+FKMZ/sJNR1Vn2JcCWHQ/ki9Hx1pCR69NJzaUydzUXlJ4Ggdw0gIa39ZkbD0TOzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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


On 25/12/2025 6:20 PM, Gregory Etelson wrote:
> When multiple threads attempt to create the SRH flex parser
> simultaneously, only the first thread (T[0]) can proceed to the
> initialization code.
> Before doing so, T[0] increases the SRH flex parser reference counter.
> Other threads (T[i]) entering the SRH creation function also increase
> the reference counter before returning a successful code to their
> respective caller functions (CF[i]).
> 
> This can lead to three issues:
> 1. CF[i] may receive a successful return code from the SRH flex parser
> creation function before T[0] completes the parser construction.
> 2. If T[0] fails to create the SRH flex parser, CF[i] will not be
> aware and will assume the parser is valid.
> 3. If T[0] fails, it will not update the SRH flex parser reference
> counter.
> 
> The patch addresses these issues by locking the SRH flex parser node
> creation attempt.
> 
> The first thread to enter the locked section will proceed with the
> node creation.
> If successful, T[0] increases the node reference counter and removes
> the lock.
> If it fails, T[0] removes the lock and returns an error.
> 
> For other threads (T[i]) that obtain the lock, if the flex parser node
> reference count is non-zero, the node has already been created.
> These threads will then increase the reference counter and return
> success.
> Otherwise, they will behave like T[0].
> 
> Fixes: 00e579166cc0 ("net/mlx5: support IPv6 routing extension matching")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

