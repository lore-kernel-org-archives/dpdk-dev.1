Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB2C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 09:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5007C402D2;
	Mon, 14 Sep 2026 11:02:04 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by mails.dpdk.org (Postfix) with ESMTP id 06720402C4;
 Mon, 14 Sep 2026 11:02:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQboveTvy+YzF8qQJIyI4QZym+SBdVIN0HP9/KfTaZUQliQm6HNZzEoQxH3koAE8qX7CiEmMk/x7fpe5bShfEWXZ7hlGkR1fnkQtehRlnQVlZk4QRB+/HNMfymRCgrl+PX3wVwnPbI1JxmwEnK2Y6t86YQoDwFBLRhzEC2OnS3teDmZNnLumSvqGP0ls1wWCqqn3c8xJAG9ZlglU845SeMNGiZT+YQbTqne2nndCtAuv3pQFrF+h4l3XOt5ZGOVZNWD+4Yj8X4cub9YcSRLLboY/tEaGfCSr0yamL50G9ot/zrQ/TdT3Qau7Q0CXYc8cySg5veWvG99Crcop/WYEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seKEHP1px3NJT5EvHEq0+Cr+Bzlx7q0fDpll03qN5ds=;
 b=AvppxgaGHNKVPfL9rMON1cbHmBIUm/AfrMF8nhkuKFyYfpdIYmS6/vD+n6R0N+ZRjvQBBnF12S/6EcVhMs5skZbVKYU9ufB14ksHdlYnnpDklFFlTkwXDbzR7s6Qd7p1ej8wyV/7o8vw6G8bjIWFGYqZnXQhsPdfwAtbs6YryjYIAObNchD6iY8cmqSmpXKtX/QwoPoOIE55STHh1b33sUv5Hc8AuhBsOzBOimMZhXuMeCp5DZLCN3vtiZVVI9rQPBSp2u9Wly4aqskqWJR68BkE92/SPFO6jWa98Q/GUVxGVsH1eGjWF24cwkq4KNnRbfZ3paL6v8rogzQvaZKtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seKEHP1px3NJT5EvHEq0+Cr+Bzlx7q0fDpll03qN5ds=;
 b=D/5WJie+YyxKg0ebps7Is+8cYvyxawRe5a6lyJCHI9Zzu6ISS6aiAhrWLieaHLjxaOXlGfTG3gP2+Q8fxOmJnDY5JyaqdXFSvrU2hLfdxR28mprTwXM6qJn1zp2Dn4dqw5JfD/rJeFd/mzUbM6RGa+sG22A2Au5oenk5syl7/5E5eqbD0zAUcmvsI+Ai6w4nOm+evj8FAibr4glMbMMjqgxo9Nj0pWBcQlB45uAytQQ1kXd2NA9boVVSJzPbscJB1nW4u+OQMJ8CKsJzbMeJ/oSzGp2qX/ca/JxkTKQTJEpmt+UMhc1A0hqH3od0XGhzTavEo62ONn2C2e8Bbe0fKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 09:01:58 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:01:57 +0000
Message-ID: <1379faf2-aed3-457e-84aa-c7b79b7d196a@nvidia.com>
Date: Mon, 14 Sep 2026 12:01:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix processing of batched RDMA monitor events
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: stable@dpdk.org, dsosnowski@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com, gavinl@nvidia.com,
 thomas@monjalon.net
References: <20260909050057.25075-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260909050057.25075-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 31031409-04c3-4672-3927-08df123ed469
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0lUFSImo0bR/cFd8ACGD7msCip6RCeklAtgXaaxV/EQEGNHKoXaBxWRt7r+I2bCDq3rSQwLJENe5Cy0vFVmFF/9bRXH42ynccjNCA02csYQ6B7LDL7MwiSjoHQbil+bpGJegljKyvHb/QWrrrpD+4hXtmtgiYOmK5xGYnzny5gbcSdMKNp9gtPuoQ2C+tSyThK8n6Zqz7UdWDjPAFBgtNsCVkCrN36d+hdNYkNenvJUxFkAc4nTazjcGPSsdLhj4L0KRABG6rYV8iw4zInr31QHYjbJXOQCnqvDVAI00zcZiBkVxCu6BqiAWpf80vXI+OXtXuociXG2BjcY6dthcWUYPkHOg1frQ9zGYPwZlZkb+/rZLLiD85Lj3Vg1lDOPZ327z+GuIt4FTdwCObxi7ye56cFGdQFqGKuuf/fBICZrAwsNf7+uAd/Q4dIZz87CliMEALUe6xPAAMeH6alxKFjUafjUpBmxCTFplXFhjpFn18YgbrwvujvaRiStBqfiblicNTiSuS+vDPPxrWkQdD3FGDuuTjQrVO64RnUgjNBgXTWoP+fDnClTUm4UuM194Beuj+uEFbRmp/6r4PQIxrkZyJHa3O8RklHiJsN4UfFtuIhqvs05M6kxfXcd/xxK+Q+qZNY4zKTHUOKmNE0Wjn4y7PdynqNrO0qjxMPE9lkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhnTitRcnFmU05JOThaazNlNUNuOG4vN2lYWll2aDdQczA2bHFlNTFDL2ZF?=
 =?utf-8?B?STcxQ1J3RnVubkdobDlsV0NrS1lOOWpaNzE4ZHZlM3pJOTlOazJDejNza2ND?=
 =?utf-8?B?RTk5NUIxNjBQSzdkc3krUDhWZnJLdW5aaW9SVHhWYlF6NGZPVmFvRlVORDAw?=
 =?utf-8?B?ejJad2FkUzZnYUl1UEhLNXNWRVVFYXRyUGZhYnhEUU5zenZrZ3N4bENKKzJz?=
 =?utf-8?B?VGVHMjdod1prbmtlQUgvMkN3em5yQ1k3Z2N4eEpncWN0c1p0VDFXa0tiR1Ux?=
 =?utf-8?B?QlJxRmhpamxobTV4OGZ4UGdLQmtMMUF4YWJEbm1qZ09uUFl6L0hJeWpWQnRR?=
 =?utf-8?B?UHlVSGYwUmJCTGs0SGVNZlpUancvc2dWVEdUK0ZUbWZiYkNDSG1BN0JGMGxN?=
 =?utf-8?B?ajc2UXZjY3hQZUdNMnJlM1hpbldhd2RrK1BWVFBzVlh0MWwyUitYTmRTamhY?=
 =?utf-8?B?UlFzaGcwc1NtbkF2TllVV2tCaHBqRVVTNlkyaXJ3Uk9hdFpuR2hybThQMndF?=
 =?utf-8?B?S1FROVlpKzAyZThLd21OaTR5ZW1YcEsyd1VlSW5ES2dlTjdYaHhCWUxsczFm?=
 =?utf-8?B?QVFENHZENVV1NEFSYXhhWGRNcVQvd1NHMklqT0N3U3RYZ3dPYUxsRlA2bmk2?=
 =?utf-8?B?NzdXa21KZlVHa1BGYzEyNnV0L2V5QXpnSWN0dlJvSGhQOEtuUmNzNk9Xd1dL?=
 =?utf-8?B?VnZWNnkxekMwck11UWlyZkZpT0Y0QTRtVFYydUMraTZNV3d2QmR0Y2ViWHEx?=
 =?utf-8?B?MUNRelBVY2FrVGlYcUQ2Y25Jb2hNV2xheFFZR3RhaEhzK3UrZWdSMmdVYmdw?=
 =?utf-8?B?U3d3UGJRMTM4WXV0OExPelR3VHhYVzB5SWcvOERIRjlWWHlvV1JraVJFNDBE?=
 =?utf-8?B?QjlHU0poVEVVMVZWdFFYSW0xWENxZ09lblBsMC9Bc2Jya1Z6Sm9Da2hVWUsv?=
 =?utf-8?B?TndBVkpFNmkxNlpJUThlOXU2aVRWOXNVMWZrdjN0VmNRcjVuUHN1c1dIWU4w?=
 =?utf-8?B?S0ozcUQwTzVRZHR4R1JUeU5zV2IrY3VVRnBnNUFMYTBveC8xODdyTC9ZM0Jh?=
 =?utf-8?B?SnlMSWFxVm95SlV4ZlZrQ05MZW55eXRFZ01RNjdJOFc5WllGeThEVmFWMVVK?=
 =?utf-8?B?UTYzN2JIY1VzS2tXMDlhaEdzYUpyVVpDUldVUnY5M3NHVHEyY1RCdk16UlAz?=
 =?utf-8?B?MzJpeU1IZnNTUlJuNFpZSHBOY1htQjg4N2JNNWw4aFdCYVFhaVNQNEJqUGY2?=
 =?utf-8?B?bzVHQjI2SmpoRnhjUVRScEtGeVpnMnM2Z2VTQUt6ZGI3S0JoQUc4OFN0cWRW?=
 =?utf-8?B?enkzUDdHSHZQeGpRSUtWOUhhVHFrZWZpUGQrWElZNTZOQkdhSzQralU4cHdT?=
 =?utf-8?B?NFFvMzhFam83eWpVQnV2S0RzRjdtajZjZWxJVXlCRm9OTDVJdkhuWDYzU1l3?=
 =?utf-8?B?Y1dybkJnM2JEeVZGVHdXcEpVd0tjNWNVa0xiWUZkM0o3bDNicGxjeldFZFJj?=
 =?utf-8?B?YzJJTnF1a0JPOXVVbEJ6dk1LZzM5SHh5Qm96RkxXYWsraGVMSGdKS2s5R3Bz?=
 =?utf-8?B?aGtlMzFrVHRtYVN3YklmRzU1SWxCNVlwVHdDY1VENEdRYnlXMlU4WDhWS2hw?=
 =?utf-8?B?MW9KaktLekViZ1o1SzlUbll6QndlOGNYZTNsRFJ2cEVEZmo0WGxJc2pVdDBX?=
 =?utf-8?B?YTlMV2JqazJhcjNTektLUVNJMzdZakhwUkozMkVOWFBLZVVlRUdsTWw3TkxX?=
 =?utf-8?B?RGFiQks0S2FkRmt1VWttdzJlSUpoZVR0L0k2MTdVNytzMnIrS2hnV1hjdGpT?=
 =?utf-8?B?aThBeGc1RU02OVF4M29mTkFhbnJ6V3QxQ1g5a2VtelhrVEJ5UGF3WCsxd3gr?=
 =?utf-8?B?UnhKYXZkT1dDbW9LTDlmNWVLdHRuQ0VjNnZObjJFRmMreU5DSkZwMHljQVVX?=
 =?utf-8?B?NUltY2h6UzY5OTdCWGZvZ3ZXVWpOQ081MDZkcmxEaWlCMzdDb1N6OEZKcGNI?=
 =?utf-8?B?UXZuS1ZBTWdSTWk1SGp4TWxIY0pHK05XYS96VDFiTXQ3a3lsMmRaSW1WVHhs?=
 =?utf-8?B?NmhVVytzMG5wSXZ4bU9yaUxtSU1CcnBQMVlvYTlXbHBGcVB0bUZIdzQ3Tjk0?=
 =?utf-8?B?elBCcGhWYWtNWmtvb1BOUFlkZXFzZEFDb1RDK1Fpc2hCN3FSSTlmWHJtb1R0?=
 =?utf-8?B?T1ZUODhFdzE5RWIzR1hyR1BCZ2RuVGMrNFVBem1Nc1VaVGwzK3VvT3JlSFhO?=
 =?utf-8?B?VUxLRXNSbERhNS9qZ1VQaGZaWkVBQnU4WncxTFRKSG5aSTNmckpYejdMSHo4?=
 =?utf-8?Q?SIg5A0n+lVhF9X5N5Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31031409-04c3-4672-3927-08df123ed469
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:01:57.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93Bq2e+Y7yMs/z/6cXHJnWZ1DMvF6jqMWvCRBvK0zwVFWd134jLz6ZphUUV5MoFx6pWP/8aoJrj1vxCNebQspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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


On 09/09/2026 8:00 AM, Bing Zhao wrote:
> mlx5_nl_read_events() may deliver multiple RDMA attach or detach
> messages in one drain. The interrupt handler previously parsed all
> messages into one structure and processed only the last one, leaving
> earlier port cache updates unhandled.
> 
> Parse and process each Netlink message in its callback. Always drain
> pending messages, validate the port index before updating the cache,
> and log at INFO when multiple messages for the same IB device are
> received in one drain.
> 
> Fixes: 2a18d0022c05 ("common/mlx5: use RDMA Netlink to update port info")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

