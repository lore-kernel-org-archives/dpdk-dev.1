Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11996D58CCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:29:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 106B740663;
	Tue, 24 Mar 2026 13:29:15 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35]) by mails.dpdk.org (Postfix) with ESMTP id 6740F402BE;
 Tue, 24 Mar 2026 13:29:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlBUQOKkX3/Y9A+Mp3GWUIvQ+7Z/PxANEJj7+xaHnErLeP3TArm5jz/VPIyBWpboA8IiE6zX2tiJM6pEW4hWgKDE0e3LENl/gSGIwyE1y1ZOwAVCubJq87/f03RYgFBB11QbRVskFqol/UC8U4DYrhtlr6NXx7BenZ+gMnFB+Yuu1TCjr1nEXKyzjWQ6txKSrZpG6hI3UiNjr+7neR9Wc30OxpKs0CbuFafuF+eTrhpMvKt5iSmT+RLVvqlHGBmFORGMIfYBD1wNxly7wkfBt8+up1r9aAfDdYkGIyVWunYlBDVmhtZXPCpX4ML3sEs5FtMeIZ7MVVhP2wMdwCu2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SaQdX7RdKhfoyEdbwYBfuxwjXr0i5HCidKd6ojEPR4=;
 b=jyx5qn6TLC3GrGu0jaMcXTlQXiun0INBK+f0J84toW5pAlvYdr4XhjaMu9bJt/qYEGYMhGk8NJkiD7SPjsmm/Pn+MJ4QWKFh/5Ib6ZIaJ2ICNQm+lBtaI56djTYYsnDPpl0pL8h8PlITQZ05ixgGUjS/BLS99PWUhM4zgLBsWj3/gE/x1mUxCPlZQD5yev7shMfBVmXLUWBeTy9EEeMphqAeNNRsoGiyE0Ck6zSm03hU+Q4bUrt7ACkX0JHVKMnKQbimz9UccGZJ6/6bJfmMHZn/9KStSnHEFRFdp/fQevOlGStn1lJ5dgC/yCrNpBCMvifvbaXKXLDAaVIxPCdpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SaQdX7RdKhfoyEdbwYBfuxwjXr0i5HCidKd6ojEPR4=;
 b=qbK0eFCBUbIOX3OBViYQ8Y+WoEjr1eaT4EiOb1iYG3CG/DQgPXWVQcKfDX/g9CGO/PHqPe1jLzp/NqYB2iM/L3lgBRKFlOjBZoGPrCIft8pTBp7j0IbvLnhdOVsyypboWlaaLsLwYAc9AgEoi9oDDQgITP1noUgSSg0Ce6FAWTT20lvvuSHaBpJeNi/9nVQJdvRVip/wBXanI8nwVNRmOB0MB6RocmRM3lLYommsdG5rg+SF+7XMSFZI4o5BqgRLMHeeF+mF+lLb5RSxAqTDaLNDHJoSyKLEJZIEyqdzvpU0XoKFIWJ9UMpuArs8nNurI6+R8a67UZw9Un40CZiKtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 12:29:09 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:29:09 +0000
Message-ID: <4cef77c3-bfc7-4380-b7fa-a7bfd8e941a9@nvidia.com>
Date: Tue, 24 Mar 2026 14:29:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix send skew settings when using wait on time
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20260320111410.148572-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260320111410.148572-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b09a31-c0ea-42b1-8bd8-08de89a0f226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +Rdez/QRwGYa8iGfAyq2lU+uU3/x55fgqdTKIHd4jbgGdjQcx8YF0bO1RP1OLJJFDh75Cu09hQHpIazO6uVPY3SGIOhEIjn+3ymBopK7lM0pPe4SdC8AxT0fhfZm0kplUMgZD+ULga9yM84t5zQT1doNgeAHkvEmHQYfM2+sScU6Rm3YF7XP33JT3w5u/gCU80AElXb6ayML0+WrFF/ocmh3S+Q7BbsqV+gMPg2fzr/wB89OFP+yBybt+dgSM2VQSFS59y01pqMHUtCqhaGhXlc8rPpc3kIJZPAETNNePnZH7RR7tfm+kQReo5/GkWZgfuFq0CXTFCr5W5o5TnRDXbH5yvrmbSCh3OD1JGfbBUd1ymarFa2JKDMvteWgrA2WCkybPAhiLAAuLkzF39YeyoAuA28fUGoM01SZsdzBFXHAOnaO4Xc3a86cj4Drp3vKy5hGf44jmtoHJoPSNxZuZN1wJlIJACEjXzBD/ltImoGU0Bn0PC9PI2Cz91wpIca5kK3az+agL5RrzwHXlEUt0mvF6S+Wk6eku/r4FOpHalvCMMQigoL8fxBVWFJI07KXb4Xr/9Z7dCPNZ7W9/e+lTN1C+WHvCDA13Dp2t09NMij2ktCnvxtt+1gVRoYKM2vn5OiLG/BQQ4ShCNUekhEdWb2rQiO+kVzejLmMXM32gOw9QuzPMsFhTYc2PJQ8wS0si/xKpic7D+ceMmjQRaQbXviRfSIn0Y99XCVKNJh7npY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lhRERiN01PYzd0MUJTYzViZFczZnJBM2d2OVIremJ1dHhZNVllUXBjN3Ez?=
 =?utf-8?B?SlFKVmUvd0h6Y2o3MUl1NW84bmtNN3hCVGdmTVVWKzM3ay9NT2FpNCs3UHl2?=
 =?utf-8?B?RnF4ZlRCUG83NlRwV2JUUitKMkpTa21hcTlPbWNOc2Zob05LU1pxamV5dU1P?=
 =?utf-8?B?ZzBZaDhzYzVUNy9WWlcxQXFMZUJaVlpaR1pCWnBOanNneE9JV2NBZ1BXQTBO?=
 =?utf-8?B?UVA4RVJNdFBaYWk0VWtwa3kyeTZhcFpzZDZyWFMxMitoZDBJZkFIcWtaaktX?=
 =?utf-8?B?UFROSkhxNXFjZ2RWU0orV3hzcXJUbTE4SXVNZnE0bzFzdVBSMDhLRFQ0WjRm?=
 =?utf-8?B?SzkyS1orUncwM2RCRkhHdThwdExrTkpnTGN1dHJJcEZIMytxbE9tbWx5MDdK?=
 =?utf-8?B?SjA4R2ZaWEFyTklwaUt4VDJaQzBHSkxzYXJTcFoxR2orWDUrajg2M01IS0p5?=
 =?utf-8?B?eTFPcGd3MUMwVVYzb1krbFdNQ3BTNXhsSHB0QnAvamZaTloyaElVeVl5amNC?=
 =?utf-8?B?QjViSHk2UGhEZUJyUCt4VURvTVRBdm1GaGc1cmQ3dFhKa2dISzRqYnEwMnBU?=
 =?utf-8?B?NUUvWHI1Q014cEJCWnVEZzRFUU4xd0pWNTczNCt2d2dNSlBGZDdOWHV1YVJm?=
 =?utf-8?B?SnY1b3NrbnZlNVoxeHJWNGlLUFpKMy9GN1U0eG1wQ3JsRk1rVFhHUXlwb0hP?=
 =?utf-8?B?VGoxcUZCQXpLazI4NDBxSUM4cnluK21nSU15MEcwcmxUM0tkOU14TjFUb2tv?=
 =?utf-8?B?WHcvelNWSzZVQ3FEWWU3cEx5SVVnVFgyYnRCMmdJTEs1M01NVGgrQXJqZWRv?=
 =?utf-8?B?Mmx1aVBjSlc1b1VKNURvVE5KYzRaQzkrTmlJRkQ4cHM0a0NjMitPd1lZaEI5?=
 =?utf-8?B?SVIweDNZUGZDRlo4RFluRUNRZEpuZEpJdDA1dXNQTjBXbHVuR2ZnRlZ0MWYy?=
 =?utf-8?B?emZEUFVHK0ZKU1Z2Sk1ubUFuZndhUDY5YmVqekdGbHEwZlNYVkY0L3p4dlE4?=
 =?utf-8?B?VURzc0ZWdVR4OTBvM0NvOTRxOStDQy92dFpjNXdqME02VUlCUlRaK05LU2tu?=
 =?utf-8?B?Y1hsbmNTa0tnY2MveEl2bk1GL3VnL1h2a0ZJVjB5OFZIQVFwK05vQkUyOEJ4?=
 =?utf-8?B?ZUFwMFVxMkNKOGh3dTROTnhkRmFXc3A2YVVaVXM4dUY2T3V3eHhROEdzd25V?=
 =?utf-8?B?emNZc3ROUzIrRFNHamNDZlZBb1JZT1ppMlExT2JwVmcwYnJMMUZVUnZaNkRy?=
 =?utf-8?B?Qi9KVHgwd2RwT0NqZVVDNXNGQ0RDelRJZVNndjE3eTBtOGljZTIweUd0aW0r?=
 =?utf-8?B?RXlyaE52eUF3MnR0M1pBcTlrcURVNlo4RmFieGpSWHF1V1dzenQ4bkJLbXN6?=
 =?utf-8?B?SU5RZ204MmwyeE15a0NTblRBNmFqTERhakwxL2gxSDJJWjV3eE9uUWdSSlAv?=
 =?utf-8?B?SytlUE9DR1k0YUduenRMWTFEWG92R3lvd0VhOWQzUzJ5aFdCb0o2emlOeFgr?=
 =?utf-8?B?UDdJUTAxZjI1NlR0SXpNZUtwRHk5R1E2NnZ1WW1QS0FrQWljQzYwdy80UElE?=
 =?utf-8?B?RUhYOTI3K2dPbXluOXlENEFiMXZNS1NXajloMU9TdXZ2ZUVKeFVGRTVaeE1m?=
 =?utf-8?B?a0ZRQ0VTbXJCWElkRExxdmptS3lTZjIzR1FRNzhGbjBramlBWjFDd0FZS01a?=
 =?utf-8?B?R0txUjM4em5qYWxRajlOTTVSYzJvc2Rwa2x1MzBndnZvenRHM3J4WTJ6ekQ3?=
 =?utf-8?B?VmkvNW1WTFVwOE00T2VwbkhMYzlNdWU5ajZhSGRWUWZFaGx5c2p1UmozNys0?=
 =?utf-8?B?TndwVHNxQU9qSytUbHZWemxnZ3dNbzdEQll0RGpQWk5JTjBUNHdnTlIvQUNO?=
 =?utf-8?B?eFlXVmc0NTFwOFNlTGNSUk5pNFlzbFk1RjdoMzk3dTRDSTZ4bkZQUXUxaXJq?=
 =?utf-8?B?MDlaQTVobU8rRlpNT2F0T0dCaXlIMHIyV1NHYTk3M0I3WldEYWtPZDJMN1lh?=
 =?utf-8?B?bGlSR3dIbjMrbU9heFl1bkFCT0JSZU4zU2dZWWZXTldYRWFTQlU2UGR0R01L?=
 =?utf-8?B?NzNYWmppUVl0V2dQbzczeTl0UXlZSzZzcENrL2NXOWw3aUtPT3lNUjA1d21I?=
 =?utf-8?B?VEJuOXpqWWlGNkgydCswL05YdG85TXY3NkdNSGEvK1IzVVloWFplb0ZoRWho?=
 =?utf-8?B?ZUtZcGJuVk8yZzFxNzRBeEVnUEhnRFQ0aEFLdW0wRVVQeG5aZDhEd2xsUi9q?=
 =?utf-8?B?VWhYVm9PQWFjTldPUEVvajViWG9jalN0U1dETnhvSHczcDdqL2xiL3lyMllr?=
 =?utf-8?B?UURDWVlMQW5oblNHMytpNkl5cnNVcFlwTnNHczBkRGM3TFdzbTZIUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b09a31-c0ea-42b1-8bd8-08de89a0f226
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:29:08.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3ExfMyGvtX9Iub+Kem6E/l8r0znzpS3Iy72UbCnSbDBjxEVYRSWzO5i9w9l0l4LyLv6HgMX4I6wL7r57nRAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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


On 20/03/2026 1:14 PM, Viacheslav Ovsiienko wrote:
> There are two modes to support tx send scheduling in mlx5 drivers,
> using the Clock Queue and tx_pp parameter, and using the wait_on_time
> hardware capability. The tx_skew devarg is applicable for both, but
> in case of tx_pp=0 (that supposes wait_on_time mode is engaged
> on ConnectX-7 and above), the tx_skew setting was missed (as
> mlx5_txpp_create was not invoked).
> 
> Fixes: 2f5122dfc41f ("net/mlx5: configure Tx queue with send on time offload")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

