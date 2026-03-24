Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20286E9A77B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:30:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EDDC402BE;
	Tue, 24 Mar 2026 13:30:17 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4]) by mails.dpdk.org (Postfix) with ESMTP id 63F7D4025F;
 Tue, 24 Mar 2026 13:30:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV4V2QIhAqvlKyaQcgtfBd+oZUJaepNFk/M1bAlLtw/9/cnyJFxgkbMWCrER+x7JyjNTGsxbgVcCkjTivhKoxK9JiC3TndcUTwt8HFbRy5wv8nPOdWegs5qbGjCDxJEemzgSddAjKun+gZTGzWjJMun/WfLc56J8EdVbxkyMfnrqlVHBO991PsNvEQE+bTpYCJp0omkfDiUc3WyIYMMe8BtvzIMzwm2GhN4LritROgNBFTf9ievZnt8ZgUE66ZSLyU/9bZYdP4O2DZ0vfLEHjsr68D8TP3YY9qhn7byoncXFzrFDezZ2mKJt0XHNF3RBrYYUTF4hawHPF1PXXd0x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otd1dU5Lny2m+baoxk5AupkRjVNe6SAX8ToWKNZZpDU=;
 b=pl1O+QUFXnD/dwTcQcAb5mYhn2W8J0ZMk24CJmPvDpkGj0zcG7KBhbTvs2AQ4jB8SRZbUs3D5Zg1uzn97fNZI0HSvBRF+7uQf302i+++oNKSRcGu7u3SxOFtHOR8cRndLl1yS9Cdt29kML2LsJmcH5uuivLRF2x8t3PhCkVgx4ysRgjQtnvQTtkK2H8BpvOHwUz4HGA/W2H+cwHFpRvr+zDSywBRzPd9i+jlyM4woLaIoVyFPEytv8+aVmRHGfsC9+NIqlS9bkKHJ8QYOIK1zAuc2yYuygTK5t/Cl8ypb/bcWkqnY0kYy79k9JMGRVkRINVUs/BmJediiNgNvniPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Otd1dU5Lny2m+baoxk5AupkRjVNe6SAX8ToWKNZZpDU=;
 b=Fz1eemv+1qyeeFGgC8DS91lpfy74ohrDgFmlNdEAgOu0W+yFzK900AszcPbfN269z/cwLDQyUInrftukAVRzQVWStQZXHv/pwAAoQ9BA+bYsVh2WCTAnF0B9c5tIRJpw2Vtslr5qfNyFHBiFMxwBlLL6tcjU10h3JmE/OzqJV7nPDV0Ws4e/9/IalSDU6L5WvJrLj48GwLD5PsyGbrCh5w6lAvHm1dkwgOzYu6i8uB22/0no2GHj5hRSeuGOq0rSxotYRZpr+Yp6YtiScPkEtxDjr0OI8G0UUQgkC9vLiuOiMuYHhFhSYoJzZBQGp8X8Z87bt5aVFu4hYxRbMG097g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:30:08 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:30:08 +0000
Message-ID: <225397e4-eaed-4d03-b1a8-50ff4e22c347@nvidia.com>
Date: Tue, 24 Mar 2026 14:30:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/mlx5: fix mac deletion on Linux
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Nelio Laranjeiro
 <nelio.laranjeiro@6wind.com>, Adrien Mazarguil <adrien.mazarguil@6wind.com>
References: <20260318163628.609968-1-david.marchand@redhat.com>
 <20260320141417.1024543-1-david.marchand@redhat.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260320141417.1024543-1-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 01669a39-7c12-4ccc-63eb-08de89a115b2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IcXR2UjUG1tzIlBVmlMvA+F0mNXUUrGoLywhaWMBspx1r1ZKjUdIMP/WiGPRxYEKUANms6RfGYxQJtGzJKnkkklaywJISQTUN81AijxMtgVZ8gdkiOUNeyJe9+GvcJco2GLcthPkm7iGrvlMbyeSh8NpN9e0YYui3NrefMiyYm79Ic4RtNHHiuNmgzDUak/WC6KA9nxppg9DbT2kx+FGyRWNIHH62rQdYZoWypyciAubQ/MRTFHZZYxY9j1Ke7zoTLNNAQHlMeJHXBVHLXAju1ILNYHe/PtilZhHOZIPS00jKm1dGONxrVbAYA0gV+I5y0Z5OhgjShU3KgVqk6M1u2DK3giC1egTQyflkXjpBJSb+AOMoz19AFBQ3Oq8kPdusbZoXNjMrKgWt1p6BEbppXvytny8a6PngC6q+LYAQE5yZlkYr4t0Kn1D4lfjDsbsxUj+PwesIxfOXXFKnrUDPZwLxzDPAU0fFKAMfeXBxBnt33KsaUZMgstrzUhB5yZs2hG2ixnqY72aMoJ7yqNB3VMj4iwyg8Jw2pwB8WvAQxA+slLs/3nZSp08MYzUScxmsrKVT03zjp+NLefuUi8Ril/Gm7r6OXVD2gv2ybbbYJmKBtZa9S+hhm5yvEfesjdYlnQIdwL4iWgDwhaNDntoIi8ky+mv0l0TT2ZB3rytz2RDnTqLQS1Qp81zVRJh+IdINnwfueMqHoftmEWXrgyql4lqZqokwT04y4xDFhvbQYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmMwTFBiSG5GTG85eVRxRUo5c1NVWThibkFTNnVlNmZRL1poWGZwOU13alRz?=
 =?utf-8?B?UExyR0FpNDBPaXB5ZTZnRHRCYWFiVGJEbTFtUjBRa0pnYkFxY0psdlRhcjQ5?=
 =?utf-8?B?eXJtU21yQ0tvdktPWVl4bWVnQ2Zhc28wZ0Vuc2pWV2R6V3lieGVoNnRKVXBS?=
 =?utf-8?B?czJ6endaVldrd1BRVXlIQzYxT3dDV1QrYWJxR1kyV1U3OWZnanZjeHUwdXIx?=
 =?utf-8?B?WHozK2VjVUtsY3VidFZpU3VNYVZLOUpoWGVKQk5jOGF5UUlpTkw0bk9GYkdT?=
 =?utf-8?B?NFE4ZDRiODkyZ09VZFczWXdMU1RLelcxSk9waW02QWpRU3BQRVRPczV0aktQ?=
 =?utf-8?B?WXZRRzh2T3RFMTd5cjg4SzFTYkdBaEpDdnRnYUI5SW9TajNYNEl1V0JtVHJH?=
 =?utf-8?B?Y0tiTFFqVm1tWVlrckZKRHhRMk12UmhHVE54c3BpZVp1c2ptd1g2amZpb0FI?=
 =?utf-8?B?RmMzRnlPMm4vR0VKN2dwSStVWXExYUQyQXdmVW4vOXk4eU1STVdaUWdKUDVO?=
 =?utf-8?B?NVp2ZHhRaklHOHVBYVFRZUN3MUthVGQrY0RMNU9KbWp6ZmlSeTc3RGk3WWVV?=
 =?utf-8?B?cHEzRm9vdDcwbndhWnBpbGxzL1ZLRVhjdFdaV04yTjJpSmlvRWdiY1RtMmRr?=
 =?utf-8?B?aEd4N21ZcEdiYno0aGFIcm0xMU1VdUw5d0NRUjNxVUd0N2N2d1RPTUFlanor?=
 =?utf-8?B?dUdMRDZZQUl5cElvS0p1eTdTMTJ3Q2V2TStGdVJGZ25tUUZJUkJGK1FrQnFC?=
 =?utf-8?B?a093eG1vUVJtbFg4bnVJN0l1blB6VnVZQ2R0MGhOa1JQaVMwckwwbVRTTEcr?=
 =?utf-8?B?WkdBeFV1WTRYUU1GejZlYks3SDNocDIrZHlEbmRsYnNnelpSdEp1aE9ZNVNF?=
 =?utf-8?B?UXV3SktPcjhtd1lHZ2laZ2JCeFRsa2pNaEJOaUMrbXVHUmtmZkJvc1NyRzRi?=
 =?utf-8?B?UlJuWXhRNUtENEozT3ZCRnBYeTNuR2xGZ3I0cDV0YW5BSEF2ZmZXOElsU3Nu?=
 =?utf-8?B?NWQvOXBBNU55b0pMSnl3Ykk1dU1XanBuWmY0SGdBa2lreC9sU3p0V2VUcWlL?=
 =?utf-8?B?QTlvK1RrQlk1V20vTG9Lcm12THh0VmNGM2RpYjlFbDRORjZ5WVhHbHI3Ty9B?=
 =?utf-8?B?Y2lOTS9FWVBxZkFiRlQrdTliQ0o4c1FhUVZRV2lrVVJuOE5JUHd4c1hrR1Rh?=
 =?utf-8?B?dmNaZnJZVzhiZktldWliOEZjSWdKdUh1a2FwQWlxcWJ6UEwyVjh2K3RLeWJ2?=
 =?utf-8?B?ei9ZMngyM1k5VGNpK0FrNHZjVGhKVkxsSEl6emVRQVcrc1NHemJkWFAxcy90?=
 =?utf-8?B?MWtJL3p4OUQwOWduMW9ZckgycmVKd2Y2akFJVEtBb0x0Vm56TmN3L3JwelEy?=
 =?utf-8?B?Y0FCeGlTWW5QYkZXZHJtTWxDM1Y3Ni9TcEx3WHZaSGMya2RqRXJua0I1czh3?=
 =?utf-8?B?UWNvazBZSnU5cExvWEprSFVXUDlHUXFnbFRnbkNjdWpvZjBkdXJJOHV2d3d5?=
 =?utf-8?B?ajh6eU4yWDhVcXVPUHpFMjlKVkkyN2FPQXBVeXNlM29TTkdrdGlJaWZsMXoy?=
 =?utf-8?B?K2tDcFpFNHNSdjhUVkdIZVREdzBITyt4dW52UEZjTG1GUkJ0MDAzck56Zm5I?=
 =?utf-8?B?azFXeDFCaXJncS90andqWHVncEJqdVVFQW91dHdaQkIxaEI3T2M2K2prUS9a?=
 =?utf-8?B?S2RJa0xuQzJLMzEzWEVnOHh6bk1hdmQwNDVzQjNlamZMZzlwdkhLZkVjMXYr?=
 =?utf-8?B?dEYvQ3ExUU1TblVYWllnNUdqbGc3MHJnQU54RE5XM3VkZkFHWitDYk1kNmQ2?=
 =?utf-8?B?NlZmWGNmOEFJdkZkOXlGUU9Ba0h6ZjdWUzIvYm1naFpRWHk0blBHeVZJVDNQ?=
 =?utf-8?B?aUZYSnpYUXY0SGUwSVNBNTB4VG1Gdnp0NzR0SlBFTWsxVWhvOGhWb2xuR1ZQ?=
 =?utf-8?B?R1k5MWl0MHZlWkhmVlVDZ1Mrb3NrVExxL1ZOZlpwTnRNOFNINVVreHJibHdI?=
 =?utf-8?B?d3Q5eCs5K1dhS3llaUlVeERaTkl1QlhDcHBOa2dycmNJZ2o2QTk1TDFPRlZu?=
 =?utf-8?B?MndKZDlYdzdjQUs4NlZuMy8yUE4zK3d3aE5LSHI1VElsem5zOENhNUl6MU80?=
 =?utf-8?B?TjV4b1pEc0o1VHVwL3FBR3g2MHJvR1huNVBPOXU0SURuaysrYWJPM1ZBY1I5?=
 =?utf-8?B?U1pKMndGOXZJSWN0RVJ3YjI0MFpxbHFlZk04ekc5dTJ1djkwZmNBR1kyWFdl?=
 =?utf-8?B?WDJBUzY5aGdLbURoSUhEQnFXbjgxRkxyYmx4eS9PVkQ4WVZxZURDQWlROVBy?=
 =?utf-8?B?VTNCOC9LdDhPT1p1azQ2dXFNYkh1QXY3OXdFQjkzNTFhQ3d1R3ZxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01669a39-7c12-4ccc-63eb-08de89a115b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:08.3680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qd8Vm5X1Efd0bfRDEC8LmNzzBXENjDjx6DNA4KupBHZStDVvLMZGbJv1pPoJWPG4eeE/2QYB0dEDqi0Y15v9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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


On 20/03/2026 4:14 PM, David Marchand wrote:
> Re-enable debug logs unconditionally, this helps understanding why mac
> deletions were silently failing (while a bridge fdb del command was
> working fine).
> 
> testpmd> mac_addr add 0 FA:35:44:3F:58:31
> testpmd> mac_addr remove 0 FA:35:44:3F:58:31
> mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
> 	Operation not supported
> 
> Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
> with a RTM_NEWNEIGH op.
> 
> Since kernel v5.19 though, for a RTM_DELNEIGH op, 0x200 == NLM_F_BULK
> and passing this flag makes the deletion fail miserably for a single mac.
> 
> Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

