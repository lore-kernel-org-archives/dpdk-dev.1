Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD71CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 09:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A834640150;
	Wed, 24 Jun 2026 11:36:03 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36]) by mails.dpdk.org (Postfix) with ESMTP id 311F5400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 11:36:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IErx0eCeVl5YBokFzDJ/Ivy71KyY8Usycj1ZdmZgs3+KlaeWuS/8CGKatjkbp4XAxEgXqT5b/e5rNleG9JlXxWxrugRPaZ2UzEvdQvg4I8V8pUrrYrpE8Rp5g2HimHmGcDaHIiv4DRBkRCJb0PPB/KbyFy3PM8IWG+IKMKFsREAb1kiEZtE+fvVb7Tnk5rpgvmsjhxeOndQnzWx4hcX875Qy5A4QWjAzqIwQvCTazxEqsJfRRi441Q6ZgvBtHSkGipwHNWaV7AK7WJJNw99p6uDd5LSxPLALShiz8jZ3bZq+XvomIOvyQXxt1dGAm4qMwo7U/iUHGq+xAQ30lHxwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kza1iZo7FhCO01+tsR9H92yEeea4FOayeHCIGouZ0u4=;
 b=vE2w8c165UwzNj4CJP2evZLgLO53T65JsrzpvT/AVvBzHu6S3L5hrURBoAVDsCgq9MG7T4k9DDmFfLm+kmWTMnVNpVXpE1TrA3HaH54gNXZbIVfc0yN72olZYX+iQ31jvrALD6juBRZG2RKF/knYsKH2/X7pMuKjiy76ka0+eBqSIErFP2I4xra8gf27NKGknfDhSWJfu9KoAx16PLuaQbTY5qYqUcaiDHuo6H+EqoHsPucsJywlCy1UcxzOhpDCYJxcYp0j+nL7p7bIdkU8Xo0cGilL2TXvj/zWv4YxswgXM6Y7bJha8rf4uw9xW8vLwTZge9DkQ3ywLeJIP5ZnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kza1iZo7FhCO01+tsR9H92yEeea4FOayeHCIGouZ0u4=;
 b=DTBC/JVItF7rAH7w/uO4+30ZWutXcipi5ppfjei9RaLZ57inVVsUk7ZSED9lqBnRAndqbyN5zu8B6FQo5K3fmZW78dmtr7+FnXkxdkR+JActUwtu9y+ZYFjpSRBELU+YXWAucSexA2M7F5Lf8VYxYtAvXXN7NvXt4K9v2fsY2SQiv5CJWzpboYnQvBe3+I81oHIdGVP9osKUuVRJUQdMavWaPWoSlypmfRBgB2Gz2cmJtI5Qf20ZLyg4o8miSRI9A3ucZLmUkvu3jA2nj+GO919Ii5Ac54/Vas/jjfV4ym8GNpHCzN6hih6LPe/nssh6Smy1+bWeYn81tb8KkzL5IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 09:35:58 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 09:35:58 +0000
Message-ID: <7a02dbf0-e522-491c-9bce-d8dcbd25c3ad@nvidia.com>
Date: Wed, 24 Jun 2026 12:35:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/mlx5: add ConnectX-10 NVLink-C2C device ID
From: Raslan Darawsheh <rasland@nvidia.com>
To: dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260622080149.11394-1-rasland@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260622080149.11394-1-rasland@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 47af7ed8-2326-43c4-0c14-08ded1d3ff0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8FfxkI0WkNAJ3sRieQgnSnP5nBcWjJb/sOOTPdoao54+JNnIzJ3fGkxxrZvUQelGJ1cPkdPZnzpA/jSNZ8vguzGfUn/t4S+1Y5+fQGJU8x20BQ3bqjk6K3CzRY6BRJyLzXI9BtS85hTgu+LxRMRzQ1jHampOeA1pj6cPCBBbbiHrDxxfx/XLbKht0T5wbjTB37q+5oI3f14FT5eKkd9cuza7FBApLstkBuvAd4+2Yj0FL582i/ym/obaP+3pNBo/byIsqQfgw8mXdRY3lU9lDkwGB5yPv+E84m5USHOemwRi24ReyB6cDy7qbVlfH+mKOkBITvvGpxH6uQsW1ixRV+61r1EKG5dGrV8SnVohLRQV1H1qnuWx+ZHGc29GFBmRNQbdxqlx7v84UeRatqpWAfoNsgfWpdckNtSXttJ+wH2d0wUbNkJq005oW743ObZJCSrJbO9bRh57TfdILpk/JfU43ebCY5oNrowUW8zLCgxT9vS9jIS91zQD5+SQoIBGNClJBMLoNVmf39js9y5zXcrx7flkVxV2aFvZtyjjlWU1FtNktLu2AZ+aPzma3HK/Ie67z71MFXH32if+f0TsMqQF1aVVxhIE9r3fC2Sag/9eejYKyb2RYk6KHdAhHjpgef5PbtS+5vzmv+60jrSu2u85KQN2kskiiWb6K08mYEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTk0RHVHbXo5RkIxRzJGOWxqZ3JObENmRDMxL2tPc3hSaXJVY2xzNG1hakxw?=
 =?utf-8?B?TEQ0UXJLNEU5d2xQTk9ucjRXa1NvNTlkcURpTWxCK3dMa3ZUbXV1M3RVTU92?=
 =?utf-8?B?K2F1SXJnNm5CUFJrK2x6emVPcEdMQ3krZjlUQ1NsakxjeVRwZk1tSm5CTWpu?=
 =?utf-8?B?d0VubWJqRHpUMXV6MWZYOC8vNXM4ZVU2NTlHdEpuU2l0SWg4UWhBbVNSNElz?=
 =?utf-8?B?SmlhQ2pPOVZQbjdIQWdXTGk0RW5JVzE5c21DWjd1ZjlTMEthYmVET0J3VTRz?=
 =?utf-8?B?L3NpVDgyRHRIU0I5U3YrNXJDRTV1azZYZ240WmFORHRXZURteitER3luZmhK?=
 =?utf-8?B?RVpqdlZvM1VGamdLbDNhdnpjcWZvK1pxYjY2RHB1WVNMclZnK2taUXZxb2o4?=
 =?utf-8?B?bGx2T2dHL0JHYnlEOEhHaHdIVW9USERxbTNlTzdOYW9CY1dqODZ2bnZDSFVR?=
 =?utf-8?B?dWl1TFBmTmlXWlI1Ym83NVJRWUdzUS93dVU3cFpsTENZelM0QXFsM0hUamhX?=
 =?utf-8?B?amhvZnAvZm5mUVl4SE9KUDV3ZE5qU1Vmd1d4aUUrNEhwODJTV0o5N3Rob2Za?=
 =?utf-8?B?NzZReGVuY1ZZR2Z0NTh0Y2NYc2ZoZFcwL2tFWVkrSGswU2FoMlFhWUxRMFV3?=
 =?utf-8?B?VGN4ZnRrQnAxaHEwMlA4cVlWTXhrT004K3hzZnV5cGZKMWl2S2lyTU5jNk5t?=
 =?utf-8?B?WHU0TVNza3d5ZjFtQ2taT3JKaU5tZjNCRWs4aGg5aVFsV2NKU0hBTG5iMGRT?=
 =?utf-8?B?NzE5Sko5cVJFQ0kyVzlaK1FXa1pPTExtRUlhTk4xSzNQUE8xQVhISHpWeTRM?=
 =?utf-8?B?TmpQQTd0b2ZpYll4bzIralU2QkxJeWZhR1hoT0sycmpSR3gvbVdJaytqVzBE?=
 =?utf-8?B?elpqSmlpeDZ1RG1EeXd0T0dHV1R6bVlOdWlkM0lLZ0MrOG5ZdzVDT1cvSnlS?=
 =?utf-8?B?cyswYk1wR2FYUG9Ra3dDTDRaMmt6Z2tUZHlqWXFxS2lSMGV0ckxncTdKQXZr?=
 =?utf-8?B?VFl3Y1ppVFI2WFNyZUs4eU16dGdkYjZaeVVOZ1pUVjkzRVVVWVlaUUZwQ0Jy?=
 =?utf-8?B?VG9nZWFHbnA5NUlobXV1SXRSNTFuWXMzdmFGblpSaUpDT3BENGQzejBLZU9L?=
 =?utf-8?B?SWxPajZHSDh5cXo3bkI1cThtZHhmbEh4ZTEzVHdhbk5mMnlSVUxaUk1sYjln?=
 =?utf-8?B?UEFnZllYcmNCS1Z1YmxHT3BUSWZSNmpUc0xINVlKbTlrUVhsZFpERUdJVkl5?=
 =?utf-8?B?N1g0SysrWGJKUU50dnJHbFlPS0pxSmtya3k4VXpjTkFzYW0wYmx2Vk9NOUli?=
 =?utf-8?B?ZW1wK1p3c0k3OG5XaVhYTy80VmVES2IyUVVCOG5CSUxMMFlWNWxwRUV1Zkhu?=
 =?utf-8?B?U0dSU05lU0EzR1E3VWJMMjc1bzJrMXNZTDRJdEl6em5BbFptSXVPRlMzcjAv?=
 =?utf-8?B?dG9OYUJNeVpWM0hpZXUwNmp6N2wyMk1KakRjZXo0eG12RVp6UzRLQTQwU09z?=
 =?utf-8?B?d0Z4TzZZTVM1NlR2MnpQajNOV0dUTGczUmFhb1JNSXU4cENKQjN3ZkM1YXlL?=
 =?utf-8?B?K012a05lTExsK1JBT3FOS1JDOCtwdCt1ekRyQ21OSEcwOG80RFl2M2w5K2lJ?=
 =?utf-8?B?VjA2MnowZlRYVFRIVGVRNjdjRXNBa29MT2c0VTdzSGpkZnQrWktaZ1dod2Ez?=
 =?utf-8?B?cC9lVTl6bHFRSytCa052YVJ4a2RDYzRRS2V6dzU1N2lsaE92dk03QUFmdHpM?=
 =?utf-8?B?RjNjUVF1VmNVYThzN3MzNkNKMkJOcDc5KzIraGk5VW1taTN0KzV3V1BNSFJJ?=
 =?utf-8?B?MGVUa2xRQlcxSTE4d1l6ZU9OV3FyOXQyeVlsRS83UkVZL2F6cjkzYXNleTJH?=
 =?utf-8?B?VTJWVXNGT2VGL2lieUw0aDBlVC93TTNCMVE4RmxLSEtIaEwrenl1QU9iN05R?=
 =?utf-8?B?T3Z3TmRKUjlyb1g1OWxMcllISTM3c1Y3QzRTMW1mZ0VYc21OREJiN0lPWjZJ?=
 =?utf-8?B?KzZzSzVmRHd6MXdhdWVweVFKWlhEWFRBQ3JnaFBFdktZMUZoYnl0ckljc1Bw?=
 =?utf-8?B?SVZnUWhxRDRlSGgyZmgrQnVDYk1qQmdqeFc1TndrYy9CUTNnRk5RSUxHb3pE?=
 =?utf-8?B?dlJjbUloenU2L283V0ZqSlhMZmptaXFHTm9uSFZxS2FiRnRPYlFHbkVmVFF5?=
 =?utf-8?B?cFV4RjE0aTJnL1VlUGttSEFIV2l3VGlJMFdYWEZEbDNNS0pwNVpwTUhqdVg3?=
 =?utf-8?B?K3p0aktTRTRaQXorVkJab3hFZzc5QkV5bXdQcFhmdUJaRXJPdU8zQm1vMFV5?=
 =?utf-8?Q?FKog1ORTTBGG/c2Rdr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47af7ed8-2326-43c4-0c14-08ded1d3ff0f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:35:58.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qWLtKcnkkUW2B29UAaVPG7WEYlu0HvDh4Qapvburi1dRBjhZ4dQ8qUkXnXWQRBJOkaAx/D7hwsZPdgYMiF7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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


On 22/06/2026 11:01 AM, Raslan Darawsheh wrote:
> This adds the ConnectX-10 NVLink-C2C device ID to the list of
> NVIDIA devices that run the mlx5 drivers.
> The device is still in development stage.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

