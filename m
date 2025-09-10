Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843DCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 07:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5865402C4;
	Wed, 10 Sep 2025 09:48:21 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by mails.dpdk.org (Postfix) with ESMTP id DD8A140270;
 Wed, 10 Sep 2025 09:48:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf1932cOKzmt5MApsoyNmkiXg+w2UVEPcyHU8q43IivRFtXq+mGxTseSSBCrDaoD6O0zp6g2ex0ho+SQbOZ4lfgE4t5hJJ2aLfJp6WmjCWpUkx1pxkJhPW21yNF5DrrGRzejkc1/eVCulHXNmLIMGHnKsl4NZ20EjxUllgLaGp1SR6sImk5xHTgZmcdqG2ToPUOl2wZ4AVxVyAG6ppt9gzpoUhmfzmWP4B8s7hYPaTwh6PSEZI7kLiyv+tJOTOnAefAGfIP/gi/cdp2kSJd4qjKvoZVOPW7wiMX6zHd4NjwdMRV1MtXhU7lELnqkd9Dl0xapLJ2jQODuOYNt96h6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEM+VlNBZgUitfW+k5aXTvhw7cJi+2qJ6bPpK4Qwtx0=;
 b=UxcMEmoQKXzAP7k9OSw0wugh/AMPMiuP36Wu60rR9GeaFCBO6raQNs1AJwnEr1IZSK/h6GgLUTsiLK2+50IZ024ArSMHdD9q6zCBIOY9iYOEDX/AxSJVColS54doU8tp9nvcNi2muLsQo9w8+ofJUZnSuqQuUfWGl/dSRHKLdkJlymnM1yBzIKfpaOCpH/AcROGyeIMgojCrFf6d25P9rMwFKWKV+WGKD2xJOuX3+cMXJaizbtcggckEyTc2fwVuxjDy6GPvjLqP4r5u5vgS4Ad57syjsx95qkbV7Iu/h2Evp2ONBDQbySLYw/NDjfIy9GFP5kqd3LBslKdqS5dUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEM+VlNBZgUitfW+k5aXTvhw7cJi+2qJ6bPpK4Qwtx0=;
 b=ksg2GvWVBUJC7qqqk+0qGlFvpGGrEuQ+2LNJ8ls3C4rJtFasKTfdtBH75fbr4IyUJ3hW+9esBkO2C2Pi/JdBvC13pnihqCir8IBoKiXU5YtwyTcpOgqyJaPci2Z8Vkg20VMrgWGeySeIhPQcglQlxehCqRGq7ON39VF/bdG/97BZfa8khIOOK1HGRmiRa2hhup1VToQDMz5jTwDY0Ouk3IwNE+i/yKguOUXtds+ulh/YrWOeGID3pqcaXHcV1Q+5XwqvfbfNvuMi8r+W32b9G+u+5mxmlR1c1UkVQ50VssMLuvq4Np99ET6zv0+JIIh3lqBY4jyBcoiMFCyr9xPOmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:48:17 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:48:17 +0000
Message-ID: <3508a4fc-34c8-4cc1-8a81-79ee6829237f@nvidia.com>
Date: Wed, 10 Sep 2025 10:48:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net/mlx5: fix ESP header match in strict mode
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 stable@dpdk.org, Matan Azrad <matan@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
 <20250909062853.60592-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250909062853.60592-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb02aa9-6265-4ece-65f2-08ddf03e673a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eElpWjFmdVpELzBwODNmMlliZDFyL0ZWbHI3Z1NzRDYrbkxyR0V5ZWFNUWJY?=
 =?utf-8?B?c0FIUWtSeG9KQnpObFc2NHhGSGFHeW9JMVhiQ0lEU3RCK1hVSzRuN3E3LzJo?=
 =?utf-8?B?bWJIZUNpcENMS0Z1c0tpMExhRVpHUVB3dDJ2djVhRlVLZDBGUEhyUW9hc3Zo?=
 =?utf-8?B?MythRGtPTk1aR0RWV1lHQ1dmdU9xSGc3c3FzQk14bjR4Z2lEbnVmOSs0eVhD?=
 =?utf-8?B?NStYZCtoblNLcTVUaGpuQ2FGTjNERWlJUE9Qb1ZoUHdaMGxOVktGMzdJcUUv?=
 =?utf-8?B?dEJnSkZYS3lTV1BqdmpsVW1jTnBVRU5zK3hTaHJmS1A1VFR2ekRNRjI0aXB2?=
 =?utf-8?B?VkVXTXNQUE40RE4wd2dLdVc1NlZTSUU5TEFpOTgxUExKYXZFOFlIRThxVE5y?=
 =?utf-8?B?Rks4YkRlTVcvUllNNGg3K05XdGt6d2VteEZ5a0d1bmZmSnNybHBFMGhTQlJp?=
 =?utf-8?B?bzhocjk2L2RudFJvbGhRalFtc2lJQkUzMHphTVRtZjBGWU5TR1gyOUh2aTQ5?=
 =?utf-8?B?SFMvU3g3QXB0ZHoyc1FWRFNZdUxiNkpjL1ExKzUwcnZ1cllmaVMyYkFwbnRC?=
 =?utf-8?B?V25mSHRvVG1OS1h1ak50MlZhcnJDTTNma2tCK2VXTUpvYk9QM1ZsYitWcXkv?=
 =?utf-8?B?czN3UFdZSEVtTVZYWEpwWGE5S283cE9TRTJLK1FEMm9XcDJPV0RPN0diZjY1?=
 =?utf-8?B?T1NoWkM1NVZhM3FqS3E2dDNQdFVWcjh1eXQyOVFyN0Z2SXpMVXB3ejduKzdm?=
 =?utf-8?B?ZWp4NjgxenZodzFCVFQwUHM5eEVqS0Y5ZUVWL2RpODdQdWN6aTBBZFdBTlRL?=
 =?utf-8?B?OXFkVTNtMklISERKREdkQ094V1JUdjZRTXVxMmhuWWNmTXB3V3poQmpZSVhD?=
 =?utf-8?B?TmxBVmpJbWFNdmZaWEgxY0ZxWjA2N0cyY0F6WUhacHQrN3VFUHo4K3FXUHg0?=
 =?utf-8?B?bHMveitHaTBacVZzUk5NQXVjOURaRFhPQ3FmZUVyblZ2dnpiOEhlMEhNZHNW?=
 =?utf-8?B?aDVPaGFDYW9KbkVHbkRpSm5pYzQ4SG1EWVdXTUhmbXUzRHltME9ZWHJyVXZ6?=
 =?utf-8?B?NnFKTVR4aDJXUkQrY0t4OEdUeTJ4YWlMU0FHRDIwcTRaZ1Z4dGxucitaKzJR?=
 =?utf-8?B?a2RudzMrcmtlT015OHZCcmtHQ1I3OTFWYkNFZjUxTGdNL29ZVmJmVUl6QXpT?=
 =?utf-8?B?eThHZW5yUUpyZ2FyVTlJdENNbHFET3hvRytOdjNLdXBKdlhycHU5aEIrbzc0?=
 =?utf-8?B?ZWR3anF5clB1bDNoeUxBSzl5YUdlQTdtWHFGTG9yV0xhNURxcFJodDdxWGta?=
 =?utf-8?B?dHdWV0Z1YTZ3NmFuZ3M3d05leExrRE5SMDcrNlhMUzdDMjl6dGx3UmVLU01a?=
 =?utf-8?B?WVNrVnBVNlZMbWNzT2hkbjVuQkcrSUJtWXJSL3loS2xPSzd3QW5KZW5pOEt5?=
 =?utf-8?B?MFhjL045TnRRRklWdzlGUDNhRjVJT1JWcFpUY21HTVhRd2pmSDNBQ284MitX?=
 =?utf-8?B?bG93NVRVU1RTbTNoZHQ4Y1hQZllIL1BuT2U3ZU5SN0FScjRQSFg3d1hQY01Q?=
 =?utf-8?B?a0xZL3NVNE1GOXBjUytwWkNqVFlTMWQ4MmJjaWZrSlRDUnpSVzloRndDVTdF?=
 =?utf-8?B?SGVsSE0wVGdSMlZ3ZHNrb05jNDVZSFRDTitIL2Voc3hRS2pHQlJtZkptTjQ3?=
 =?utf-8?B?VHhjejhkS2tINW9xd2NwRXMrL2NwVmRYMHAwSFArSEpWbDlFbWdCU2NrN3Ja?=
 =?utf-8?B?LzJvYXRXOXl0cHVoQ0s3YUdBcXV3bEpCSVRURHlkUTFERmloNUtmR0ptb1NR?=
 =?utf-8?B?aHNxbGZGV040bVpOMXo2RnI4cE1mNG5YNmFEbHRoa0hnYWR5Y1NIWGRsUXM2?=
 =?utf-8?B?OU1DbmJDSVc2ZzY0cDdoN1ZvV1JyWFBVOVVXT01YakFHa0tkZDVqNjlobXFz?=
 =?utf-8?Q?ilbNaUq/itQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHA0OG1NMExqNWUwWks4U2RRMXdnUGEzVVVIVWpZeFp0RkhZbW1NQnVNK3NJ?=
 =?utf-8?B?NnJkN3ZoL2lYcXZNblEzKy9sL3dKOVhoTlY3c3ZMQkRJZWk3WkVHYVJoWUNu?=
 =?utf-8?B?eFhLNWdBUURIc2VzcEUycFoyN2U4bU55OW8ybkFFdEF5Yy9NWlBJK3o3R0NO?=
 =?utf-8?B?bVZwRE5KTkhVQ3RhcjBaUXZ6VThjME9pb3VjbWZaMXRmQjZ4b0NOY2h1Ni95?=
 =?utf-8?B?MlNZSkd3Mm5DUW42dVM5QU9tUTIwTm01dlkyTG5weklKWmZMT0tOMThWZ1Jm?=
 =?utf-8?B?Z282ZklZcGpyL3pMdDlacldNdGJaRzVHanJORGF6cnFPV1RCNXllYXdXK0U1?=
 =?utf-8?B?dmczck43QWdoMWdKWHdudmxFK0tGYVBOZ1JuRFpaaE8rbkVtY1QrbDJxTDh5?=
 =?utf-8?B?ZkYxZDBCVTdzU3JEV2xpM3p3Q2hWTlpqTmhITUxrR2RPTHkxMGVjcGlYVDJW?=
 =?utf-8?B?aVg0Y0ZCZ1NGNGtOeHR5bGRMKzZ4UHg1R1RwWkQ3NmQvZWJzNzBuVU1LQ29C?=
 =?utf-8?B?emRFalYwMGtlYm03QUtxNHJLZWU4RVdZTTZjeVppSVJ3dE92bnY1cnJOS0FR?=
 =?utf-8?B?aHZOTHBybGpBL3lZOFZtSzd6am91cnhUdTVHRTY4enFhSXNvaGFXR0Q4Mkcw?=
 =?utf-8?B?aEtnTTAxSDlYQVVHVFJhUDVsYVNUTXNDMUpLTUl6ZmZjNnVsK1dScTB0bWRt?=
 =?utf-8?B?bi9RSDF2ODhGK3U0WUNzc3VmempWNWZUYXpXWElkbG9nUWtJY1JyQXBGcDZH?=
 =?utf-8?B?UGoxWTdZTzVrOTdJSUY0cURCN3g0RkE3OFByMWlldDZCbVdMdlFkbm9hOXp4?=
 =?utf-8?B?MlZ6N3YvbTJ3SnMzc0hnNTc1U3VTckVKb2xsQzdxTGNLM0JXMVRoc2RxNURO?=
 =?utf-8?B?b01ueVNldjZkbkpxaXdzY3hCS0xIV2NKVllrdmxwSXdSNlhJamVVckNSWVBQ?=
 =?utf-8?B?NmNncVpmTW5tYlkrU1ZaZEpDL3VkR3NvaTRrUDh3UDY0STNJRUN4UWk0SXZa?=
 =?utf-8?B?QVp4aTJKSVUzV1ZBSVh3VVBrdUhYaEhIVCtTUGE3Vng0UVUzT0NFVlAvS2lo?=
 =?utf-8?B?RU02cStMNzNiemZJSkM0ZFh4MVlOU1FseGgzbllBNjBVU3BNU3NncUg5c3lr?=
 =?utf-8?B?cCt5aHMwb3lxcGxOU0RPVkpseFZBcjhIazJacmt2THlnWTV4bjk1eVpBZkUz?=
 =?utf-8?B?aS9TclpHM3hOV1ZMSXpaOHB1RWpRZzF1V3Q1OFVGYWE5VGVlSERDb0RYV1lJ?=
 =?utf-8?B?TzFPRzJOYzI3SEVEdUFUQkQ0dzRxWkl3VDlXU3dsdUg2R3ptSE9LYVUwRTY2?=
 =?utf-8?B?VlNleDJ4bTN1bW5RWVlvRlVDU25sb1JrcWdsZGZYdWU3RXp4QnY2bkkrRWpp?=
 =?utf-8?B?MnBlbGtDWnlueVJiYi9uamFSZ25HMHlkUWJhZDdaYmh3UWN1M05GOGpaY2hv?=
 =?utf-8?B?emZmM3hmUU52SFpacjZOb3NJRkw5bHh1ai92dEZ3bjRycmd0eG8zOVI3MmZZ?=
 =?utf-8?B?TU9wYUlmRUpySnpkRXBsblVVNCtPenBoQnNOZXNCY3hORklsNDFldVgxeFJw?=
 =?utf-8?B?Q3VXcWxtWW5Da2w2cVlZU3Rwbmk3OTdtN0RoMTZVZnhaUzk0Njc3MkQ5NGt0?=
 =?utf-8?B?dksvVDExRU14TG1RZzRaRUlkWGpFZnVIYXZidDZDN3Z4QUNXVm5Mc25KTWFV?=
 =?utf-8?B?RmhGUTZjZm1hbG96V25qZGtzVXA4WXJOSy8vMzgxODBnaW9zRzFJWjVma2dT?=
 =?utf-8?B?MjNEQ2pOVHYzUlhnd05NdFRQaWFsVEZRWGJEd09ScjRiMXc0Z2RUR1FSYmtt?=
 =?utf-8?B?eHhXOCtDUUdhYWZCOFVpQ0NIUUVlcFZuSG5XZHRDSUgyTHNJYUFYak43WXJZ?=
 =?utf-8?B?YW5wTEpMVDhzc2ZoRnB2L2JURGFlT08vM2VGWlNDdzhwQ0FPQ0Z2RjJhV3NP?=
 =?utf-8?B?MUZTblpnelN1eFBJVEQzNzRJMTQ3NTVwbXdRZWRhZVd1THhYMjN5SWZ0aGRz?=
 =?utf-8?B?eTNaY1BsWEtYSUlrMnVET2RRTW1yelBLM0w5bi9tVCtvRTVlZnJseUFHZDhr?=
 =?utf-8?B?aW5CQ2x0N3lyYUtpekFyYWw1K1owOHZNMklsY3NJTU1idE5lWGw2WEwwbmhY?=
 =?utf-8?Q?l/VahCOlsDHK/3kpMXcFvu5VF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb02aa9-6265-4ece-65f2-08ddf03e673a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:48:16.9807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDWRA4rH5MAjq/ZSRcYV6kHoeAf4170kvccLlHmXM4vGzJNI3s9Su7WL+OmM97kyWPOTsi+jdpnLOe8HgOZWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
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


On 09/09/2025 9:28 AM, Maayan Kashani wrote:
> From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> 
> The pattern like "eth / ipv6 / esp / end" matched on any IPv6
> packet in strict mode, because there was no implicit match on the
> IP.proto forced.
> 
> This patch adds the implicit match on IP.proto with value 50 (ESP)
> and adds implicit match on UDP.dport with value 4500 for the case
> ESP over UDP.
> 
> Fixes: 81cf20a25abf ("net/mlx5/hws: support match on ESP item")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Matan Azrad <matan@nvidia.com>

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

