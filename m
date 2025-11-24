Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53961CFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 14:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 120FC40611;
	Mon, 24 Nov 2025 15:38:36 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13]) by mails.dpdk.org (Postfix) with ESMTP id 1A64C402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 15:38:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh6PXPUPDTGIRqrHlp48sMp9/e2PK42p+SECTEb0/tv5FKNLGYWYuuaDz2RSToFf/KyQw0mBDUXjfx6q/f98nvGk1y+gijSf2UYaqpN3Y3myhwtSbA4zx450XsZAlbyhvyNdY38h1YZsE3k0Iukl1BrBnKYnIjDHY1JNPgsHxRcwxVaO8D43VPQw1pMK3RNK/6jBaBSa41vuH2FaO4CjelL158RtgCYZTIfWIIuYXCPtQGt+t/8pSVxx/eEOUO37nex8yDXHin8xnhJyh0ycCoRr/Xh6aITAUbL0i39pr7ftU2z2No4qoBBIzzdFNU14xFyNEVbTKdD3N+KUl3SaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8aXBALvxH5j+atC8rs7qTZXQ0oIOEvfvsclknzkh4g=;
 b=ArCC3RcigWWoNvEHnUhQA8su+/KrZ0UdP2mQjn+yrcDyPkoHGHlJ8RPMkvy/AleEF8ea/fWzBMeQsUeDJr1s1X0oYQpntnOXzN9tm2wX8WeNNZaZQ+Z2JTLasfm6ZZ0ra30QeFd+I6QbLSnvQRTplsQBPmmFOMVAFoBfhvEZygnzzG8j+43+hcaBs1nd7FsicWEerEY65S744JXau9LvNaHcacylSK3R5/Eritwr8dsaHj9eZv4P4ZjzJUwXez3QpBBBNPFx7kymm91Ga5kfis9coi76hcfCperbSIvsvE6NmKcR4svxuyoe0FFMHyl1/bdiltI88Usq+LRyHqaoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8aXBALvxH5j+atC8rs7qTZXQ0oIOEvfvsclknzkh4g=;
 b=GHmIU/AE78gy4zMnrlimhOc+1lzSixvAafh4v7NPP/zmxq3WMZ41XFWTyt8sdwytxAuPtFdDRcPccOyTVD27RcAb523wCbGNzdik61jgcpoNiaNqz7Xnpivi7fpWB5oj2KhDodiD1njNevyqctQ9w4TPt2YHx+QOmJqjvpGeKwOkcCZ0hIs/m0bH4t6gZXAcvHLc9UaNkJe90+W+lQZ2d+pFfJTRnB+tpGJcrCniqidg9T8NjcM7HGzZWJ7BVdquwv4v5hgZvj1Xf6OLACzJpmM02+dR5QmCw2+oOTHNyfVzB7kzpiuKQWRmHxuZSKI58rTOCVnVnhcPFOmwGlIi4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 14:38:29 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 14:38:28 +0000
Message-ID: <9d6c3f9f-ce18-475f-ba91-da84812d98f2@nvidia.com>
Date: Mon, 24 Nov 2025 16:38:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: update count flow action docs
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
References: <20251124093214.2080415-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251124093214.2080415-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: b8466093-19c0-41ed-064c-08de2b672205
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzFPVXNlZ1M0K09ZdzJ0UERNWHVjN2xYNDl0VkdIMVNCZGljYzV5bWxXKy82?=
 =?utf-8?B?d2duUXZFa0dUVEpoK2d0UjVqQTFSdXloZHRHSkU4Y1MzRG94aEIybzMzMGZD?=
 =?utf-8?B?Z25JUzZEZVByeXo3UFdGU3c0WnZQd1ZDMFRHTjI1K25uOXZUdmtMcFU2QTk5?=
 =?utf-8?B?cGpUZGVlRnFBYmxMQ2xFTlU4MnduL2x1MjVVRnc0eFZzWldYaXF5emlQbVB6?=
 =?utf-8?B?TjBWV1E1RUVjNTRLVEpWUk9OMlZzdWxmTG1oalJQREhRaTljdVNnT1drRG1B?=
 =?utf-8?B?WW4wVE96UzV3dDNGQWw4Q3FjTDVEVGFtYkZKeXJrZjYxaENEdzNSdDRHN29s?=
 =?utf-8?B?MXJIWFZaaGpIK3VIK1JXaXpGRDVib1NveGdYa21mZE5TK0NMNlFVTmovRFVo?=
 =?utf-8?B?ZlFuOEhabkdSSUp1VnZVRkJpd2l3TXo5a01mSGVvSDN3WCtaZGxVaTZLdHlC?=
 =?utf-8?B?RDdCSXAxYWUwYmJ1QjAyUnBpaEFYSGMvNkZnVDJibjgza1QxQXdsM1l1UzRv?=
 =?utf-8?B?dk1BNWdQa0xtdFYwcGhaZVF2RkNRcldVWlJHbTVKTmdBVDJ4dkhWYVg4cjJs?=
 =?utf-8?B?WElIUkp2WS9qUEI3bzAzSjdsNDF0Y1JLYWJxTGRMSC9vWXVEQVF6VjdxT0FJ?=
 =?utf-8?B?Nno3bXpXbGEvaDEybWN1cVpyQjhka3NtK1hUS1FISnRPRXltRnRTUENGUVlj?=
 =?utf-8?B?bTdZVHdERWsydjVJOGdJNERkbU40SWoybXlZRFhKZFk2SHN1MjcycC9BZHlV?=
 =?utf-8?B?SzdKbTA1MWthOVlyVnBVd1kxdUtmRUJ1d0l5cVZHaHZ4ZXltRE1mOXlYOGd2?=
 =?utf-8?B?ZFdyNGVLZDZsY3poVWpNdFp1MGZMODhvUFdxMG1ZVEVJcHhJV3FZUG51QnMw?=
 =?utf-8?B?WnlTR3ZpWHdFMGFtaCszamtpM00vTnVQMVVhdGJ4b21hOThNYTlUU1BqaFAy?=
 =?utf-8?B?UTBYYU45TFc3RVpQbVB5elB5WVBKYW1qVmFyemlpb2pCVDN6SjJIcElXVlFY?=
 =?utf-8?B?T2xwQld0N0Y0OFdpQ1poS0ZUdHQvR2xLOGVKVDAzUmZ3a2NET2s0a2ZzSXp4?=
 =?utf-8?B?VTJNRGEwYTZYR0hLam9JRStucGVydGtsNSttQkwrekR1Z0J1ZEhBNHNFNGJv?=
 =?utf-8?B?NzBqbWNTTXFsK2tvRmF6NzdDd0tlL2Qxa2crcjdNZ0xMVnJWdWtVeUZlWFp5?=
 =?utf-8?B?aUlISkdkMHhKQytQTFFvWVBOYWJYeHMyNG1kemZFRklxOCtUQU1XM3RtWVI2?=
 =?utf-8?B?U2hmY2xQL1pJdzQ4TGFqL3NYaHhWV1JnOGNlUUQvK1Ivam9FVHZ5SHIxWDdY?=
 =?utf-8?B?cjExanN6RzkybllPcUx5d0tvVHZqUFAwbFAvTGN5UFZCRmJIcWlwMWo4Mk5I?=
 =?utf-8?B?UTk0Mk9XZ09Ic3hkcCthSFhtQjYxYkRVbnNMMFRHN2dYaEZzNWg2cmRuWWlM?=
 =?utf-8?B?N29sMnlkOXQ2czVaOG9NUVlyZmlJSGt4WnVVdVE5dGhyQnUwemtBQlpsRHg3?=
 =?utf-8?B?K2FINkJ5ZmxZTXkrWEl4aisvWWdJRjlCUEhOQ2NXeGkrWHREYkYrYlBvallo?=
 =?utf-8?B?cXQzeHl0SjNnUHk2eGtzRW9xYjZrOVhLczgvRWdKT2hvdTh6UWVHQndXNXFR?=
 =?utf-8?B?OWVLemUySmxJRWUzY0Y2Ym9zZnJiaDV4dlV5cW9SMlFOL0UrY3AydzI2d0pN?=
 =?utf-8?B?RTFINFp3Zy9qVGYvNWN0TDBRZ2M4MXptRGI0Nm01L1JQNzFPaE15Z3l1dENz?=
 =?utf-8?B?ZVhzTG5maFF6V1VwYTdaUXBQc3FPZUErdHFCNnpwVjYxZXhCdWt6TWN2bHZ3?=
 =?utf-8?B?YkpwM0ZmeDdXVUNad0pwZk54WWNnMmhjSC9KSjhiTXd6bUxLZWRlNkM2TlY5?=
 =?utf-8?B?elBEejFOdUhPbGRzNk1YWlRRV0hvK2F1R0VBOGNwSTZETHlrUlBOcTdTU2JW?=
 =?utf-8?Q?LsGdUNe4gZZfD1B5ic2ZWvDperdFVho/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtlcmdJZzNqRkpURXhFMXFGblU1eDFVTVhzZkJkUnZ2L1lqQjNwaFdJMUxH?=
 =?utf-8?B?SDhSTExKUmhuU1JCaDBuYXhrWWtLK3lzT2p2L1hKRS9XaHE0QkJGcFg1Rm81?=
 =?utf-8?B?NjVYZlA2amVPWGFRT2kweXFCQVdnU1lCMXdCS0psUkZQM2pOdW9KVFlrbE1P?=
 =?utf-8?B?cW9Qc3U3RVl5T09qMmNMTUw2Y2drYktIbE1JQTV3dUcvWUQwT2ZQKzdxQkJn?=
 =?utf-8?B?ZnRXc3FBT2ZWQUlKOXhwUDJyR0pETkZ4KzUxYng5MFhNWnZhK1F1eDVnWWxu?=
 =?utf-8?B?N3ZFZHlVQlF2NFhaNUVPZ1ZQNFBCZU5PckNlbTdvSFViY3BBUWl2K0pXY2Nn?=
 =?utf-8?B?TVRsRkpYMHp2STcweUJ4Tk9LRCtGa2V5YXJjdXpKVkUzYm83L1pZUll3M1B0?=
 =?utf-8?B?bW1GUXZaV2JSejd4S2ZLVzlGaUZqNElhM3VvTWdTZGg2Q3lhQjFLOTBNRkVC?=
 =?utf-8?B?Q0RkSUpvWmZQQnJ4cjNwY1dtVWhENjZHWm42T2lCT05MNnZEQU9rZGRlYzJD?=
 =?utf-8?B?ZUVudFY3RHo0TkhJZVdzeFMvd1ljemV3SnlHb1VucmNyVGc3aDdSb0xsTThY?=
 =?utf-8?B?aUUwc3dCUThOZDJxS1BzL2VOTkJ6VnZmb1ZodUJmalJWSUZTeC9Qbmg4T0w4?=
 =?utf-8?B?NVZsMGN0QmtYYTdvWWxHYVk4VzVNWjgxaWtpMnFNWS9STEJVUUsvelIramNQ?=
 =?utf-8?B?dnF0bC9kR3BBVGQ1UWZEL0xTVGpYVExlNStPd0JpVEdSNE5QYWg2ZFVNeDFp?=
 =?utf-8?B?aTIzVFdTVEhMSWs1c0tXNkY5R1Z6c0NReElXM2duRmZSeTFMZThLNVZqdXdB?=
 =?utf-8?B?L3hHbDZiYXFKUTJTbzZ4MGlRNUpMWVpCbW5TUW5adUNEcnVpS0N3Y29pUW5N?=
 =?utf-8?B?ZDZBMFNEeTdzcTlVak1GVUpjekZvVWxhMnlid1FCbkdtRG9iN093aXFvZDJT?=
 =?utf-8?B?L2NnbE1OSHl3bHcybkhMODlIc3M0VERGb2h3ZVI5MU9UQnRUVTdYbkRqWFow?=
 =?utf-8?B?S3BRSUpPUHlvRHN2cytaZjE2Z3daOFd3NzVMS25WT0VKNE5LdncyY0NCMEN6?=
 =?utf-8?B?L1EwbXJrZWV4cjZ0UW5zKy92NS85RWxCT0NuWmFtbGRhRi9QbEVaOURXQk50?=
 =?utf-8?B?c1Z5OFRnVkk4ckRrci91cU4vUlowc0M2aitJRGlvVmxvTzZrV1lDc25iNlNh?=
 =?utf-8?B?Z1dQdkJmdlprZnoyU1cvcnZVYkxhNG4xY1pJTUNhMFpOZ1ZXa2l0OUhMZm50?=
 =?utf-8?B?eHI3YVVnR25YYmdvbkJwWUFWSzkwc25BSFNPVjFNY2tjWDBJSWpKWlk3Sktp?=
 =?utf-8?B?cm82dm10bkVQanJvTU5tOG85ZFhUUXNkTlpMQ0hvRG5MbGxNRTgzbEtUZ0tp?=
 =?utf-8?B?T1FVQ0VkdENkMXN2cHZXQUNUQWs4Zk1vUHdaV1hGem0wdFRkUmNEMUY2ZHFC?=
 =?utf-8?B?ZThSN2s1NnI0WTFLalBoMXBaL25EbUR6TVpVeHc0THFpdStCSHpPa2t4TTgw?=
 =?utf-8?B?akEycTNpUjh2RmNkMGxMYzE0T1N5WUpVeDZReXpoaU9aaTNxTWw1S2F0WGov?=
 =?utf-8?B?WGdGdGlSenN2cDdFVUovUW9DbWMvZjFJbTZZNHdPNFhqU1k5L0lGUm5CblJP?=
 =?utf-8?B?djRPNGtQN2tKb0tJY1Q1bW9Vdm4wTXVHam00dDJVQ0N0UFIwbzVhbHE1TDBY?=
 =?utf-8?B?UEJraTc3MjZHcDlYYkdGclFTRmRlb3REL0twWERZT3EyTDYwekZ4WjFYcTR3?=
 =?utf-8?B?bFQrWGFMc1ZxNHJMOUhvMlJlcGJ4UWxyWVl4UTh0YnNzeGNSZE5pUFREcUtr?=
 =?utf-8?B?Yi9vT21HaHhGaTkvS3VIV3dYRHNHOEYrdkZPMlJZM3orTE1abnhPSjRlK0o5?=
 =?utf-8?B?Qk5sck80Y1VNUThycjNtRG01OE9iNUtkVXpIcGVUclp5a3kzZVRIM0ZuNzVw?=
 =?utf-8?B?TjJsTlAvMEpmR2FjOW5aOEhsWi94WTRwVzV5N2IyN3VQMDJ3VEVRRk5LU2tV?=
 =?utf-8?B?bGcvZVpOeGpYR003T2M0T3VwSFo2UE1lYmQ1SFpBYzdEcUdEcG1Qd2g0Q1dW?=
 =?utf-8?B?d1dBYVZaYXdwdXBlZXJyTXdhbFNOQjVjajhuU3NKZmVMNHpvYUZSNjhtUHpQ?=
 =?utf-8?Q?L8OJW/pxqwEBCb8hUN331Uct4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8466093-19c0-41ed-064c-08de2b672205
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 14:38:28.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l47LjAH5iaKgtJCUUd9vXvwnX5QzN68fpZWvFw4zla67v7g6ypVw2oMRmhfbLA51RtMxZXVpXpuBgDY32pvi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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


On 24/11/2025 11:32 AM, Dariusz Sosnowski wrote:
> Count flow action is supported on root table with HW Steering
> flow engine with upstream drivers/libraries and
> drivers/libraries packaged with recently released DOCA.
> This patch updates relevant docs with minimum DOCA version.
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

