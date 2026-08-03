Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF2C55175
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB88A40272;
	Mon,  3 Aug 2026 11:19:02 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by mails.dpdk.org (Postfix) with ESMTP id C41AC40269;
 Mon,  3 Aug 2026 11:19:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANDxpkSGw09D5knlCOn5vhIre8d9F+RpSpYCJNlocdXt5IZntnUUHgR3KrDpntfZL/1j3EEYnwPRG2chQwTRy4OzEi5VknyTs9SCd56KptLsKKDikoKeUrsQwdIl0odpr4RQxPuZUrIKsLsHoHsrEHYrpXfhWErGasJoSX+9XS52e8kdgVoWwlAJ08zP0Dv7pK+zOXT5n5H5Zx1Wbl9SB/BzA8WFaaQWq1HHPTOYj3CEWCDMtT1RkIXv0mh+Sji2hBs7IzaKbFva/acxwE+NiPbruLRLlerThonrKWwnFa8vJzW5JCtw2Meeo25ZVaJu/kth6NZt9bOrR9H+Nbh+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFB9oIqaXzsHYFJHZWIHNxtM+WflDoYK3TK9olOVMto=;
 b=W2hJbxzedNWZYBU6/P+oeh2bPcewfiz6iIvABACQ/HCefBLWX8o03wx2AEmnke8sZJA0aEn9xM2Cd2sQan22tjfs1VjtXvfcX+4kQDx47l3a7UT1bZ1pcWBvXARj6afMsmIMgy3ARFUm2q26lOKiAbn4Xb4hVnZAqzG75bevuHgGKbU5elYI1ryQWkvBAZ231MIcoOhuALcc6Y5d9oFISwWOe0ovsZKeK49EgXAjvKCrZKkxjqAomez8jG8O74q6oqzjvbSJHWOcfKyH1zsTIbukp9drkwv9MlX8MKHrorYjfvD53eupmQ0+dWG9jUxUR0dK78AFeiqVINjR73lgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFB9oIqaXzsHYFJHZWIHNxtM+WflDoYK3TK9olOVMto=;
 b=GP8R3HAff6/BsFMo/j0zgU8ZBrvNFRufl9eC8jsbT0WwhwneRUfEP/2yxYvs6j6OBrMoDEoOU79R5nYE2xvtqDYr3MR39J/OJhOiDYw4VNxl5mbw0pgQ27JjTWCj6r7o+3MtTE3NCfW0vnlzaMabIAfqswkIMUJLplHDRxj0Flg4m0nya40GOWara+qFGdgwTjDW6b+P4E0mskZHrMCHYC8hF3ZZuthmnJhFwa2OtOef8Jkdbuy1veU2/49LOfJUv3WNL45M1B3/MeSIccCM+nUcJMvjyBd4k8CssMPIQEbWls93LcW2nQj6ZQtOAMA8X6EWXHdve+HmB5cp4TYCLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 09:18:57 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 09:18:57 +0000
Message-ID: <c45432ff-fa4c-49c6-b443-c43e0d99e42c@nvidia.com>
Date: Mon, 3 Aug 2026 12:18:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/mlx5: fix overlapping memory ranges
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com,
 stable@dpdk.org
References: <20260721121337.1608660-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260721121337.1608660-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: e419dc03-0998-4780-fdbe-08def1403f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Cp9As513WY8PzIsweQkAZlp0+XpawH6QuQv6IdEQST6NWP3Blpi0Prv5iQ3HLPTtM+mQqTe7c7tSJYNwYK+gpAx2y5Pv5sY1IYd9ZlZgzJ6tbt231a+1UrI6vEtvCuxM5Lhm+P9zHfHY4pSahyEU8+JFL8WqInq6wHvfJT0qKKJdGbucSLTjbonJte6m9KNBEOXhpKPR1LqRHKh8aDF1v7k0AO00k0oEKu66XQbHJaxOwmbzgpJV5W73bjaG0ltrMdIoBx4W0E32RdPxhn6C1xbO66ivobdeY2wvrLF/Fxau712VmLZBItvpt+XF8pvGMs2P160GmnAtwmj+ubMDuCOLao8Fw6af3Z8vk1rokSs1OuY9iasKu0Ue/PXU9Vx6tMMuS89Jyy6lO0/UWcRRIhXhBARpVqwLpjPxRLU17pwkvgJPEGp+yY3qw2uyfG2qBpn1eYksdD+2CgD7rsleRjayc2+TuvRuyIi0uf7o8XzevwQLdzInekDziL83zMqVbZuot1jZUBFNVD3jC2oJKntaXtnbYg6K8UzW5HiUZ4sI2qRxj++wkXrng/BjYSvCloJcDmAtiVpobEUIeOb9V/EYNV2PEarN9CND4cWGf7l6GC8TtYN17qhKUUkiriax1WSTBfYEK7LMivpe98sE+O3v7KMGLrzDPc2D1mHT4SE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01EU2Rrb2Jlc05zWDA4RkhqdVR5My9Pd2tKUGVHTTc2WUxKYXhFNURrVWJr?=
 =?utf-8?B?MFlscENhTHNjYVdVQzdNWG9STzVxdklieWNhY1pmSktYZEZkSDJCZEVpcUI0?=
 =?utf-8?B?QjZvVFQ2cEFlOFB2RUdzMHR4eXd1OXdiUTgxQ0ZSRFRnZ01IUjl5V242MCsx?=
 =?utf-8?B?VFlnTldhRVozRExRL2NxcWRPTVllT3RxSk5RYzN0SEhtRHNmVmlGcDRjOGlV?=
 =?utf-8?B?WXp6Z0UxeDc5cWE4NVNzMzFsNFRzWFlTK0lLNjR5eDdURno1dXg4OHBlSjVr?=
 =?utf-8?B?ZitCWU9yTE1ZR0hFZ2RDWEp0YStxYzNzYXNrWER2MG54ejVEUEo4SDA3QzlI?=
 =?utf-8?B?OTZaZ3NOSmdzWHNDRkFWT1lScE9mTVRtdlF4cmFhdzdnWE5SUzIrS29TaDN6?=
 =?utf-8?B?U3lzUXpKK0h1eE5MRlZucENLS0krNDlzSmdDUmMrK3JqZi9wUFBtZWJ1ajll?=
 =?utf-8?B?dGZWZ0VYYUFyMW02M283TVQ5bURnTWt5TjdSTmFsZ1ZGMVJ0NmxvY1RkSjl1?=
 =?utf-8?B?UFErREw0eHpXRUlPOEZ4MElrbHhqRFY5dXRsR1NXRUNFTFZOWUJaUWs0K1VY?=
 =?utf-8?B?OTBzL3dZYXIxT3F1U2Uvam5jcXRPMHZ3bnkyVHNPZkU0OEVHSlUvM3hYcUZo?=
 =?utf-8?B?STg3dzdCSDhjR3ZIODVxWjBkUS9nSVI3WGR6K3QyZGUrV29ZcndFd3ZkZFR1?=
 =?utf-8?B?d200Z3dkdlRQZ1pGQnhhS1hjN2phOFA3SE5kRjlmQ2dKNFptdUpGZlVhbmVp?=
 =?utf-8?B?OWVDZEcvc2RkYTkxRDRRb2RZd1B3QzdMY0doS1hNRGxlUjRYc1RZaXlRVW9Q?=
 =?utf-8?B?NUtJRVFneXVTZHN2S0IvWlEvNFprR2NwY204VlU4Lzd2YUVDd1FFZXJmNmFM?=
 =?utf-8?B?ZTJRR29BOEpYa3NDYk5IeVNjbmhnY29vNCtZdWV6cXE2em1mYmJHV2pOK0tH?=
 =?utf-8?B?dC84Z0VnYlhTdVdLNVNxQkhaNWZQajJhVW1LYTloaHhMODgzQ0owOXRyd05s?=
 =?utf-8?B?ZDZOd0twVWR5Q2w5eTNQR25pYUFXSWc2Z3MwbFFVaWRZd0hyelp5Qy8rY1FP?=
 =?utf-8?B?YTBaQ0Y2OEhvVmpqalBVaElPZGI1dDJnc0NXYzMvNGMwOGw0KzV3K3RmQnd2?=
 =?utf-8?B?MUdsakYvODEyUytEZ0s1RWtldXkxSVp2NTZVU2x2UWNJVEdIUmRkeVVYRlp4?=
 =?utf-8?B?aTJrZDBTZ3pkdE1TMFdNWDlqTGUxNE80WGJJbUNibkpJNGMwKzJtOWVFdHJy?=
 =?utf-8?B?UWhOWWpoMXJucHZKMEJ2ZEdINUhYRnJ1d0FLd0gvTmxrWmtkcnNkeFc2RXps?=
 =?utf-8?B?MXRZaUZFZXRrcFBKZ3NqN2RVeksycGF4MENkYVhXTjV6REsxZExRamxvQ0po?=
 =?utf-8?B?TXN6Y1NtNTZIaW1Pd0J5cEhBamtPWnR4bEVva09HWDBhMVAwWU8yWkNFSW9p?=
 =?utf-8?B?dnhSRjFUL2poUGxLdDZubEp3SkZ4Zzl6NmpEeHMxbW1aTS82NnMvTUV4NGtO?=
 =?utf-8?B?dUJZNmVzc2k3Ti9jZGJ3WFFVdVhxK25Vd1p0K09XcDVGNEtwYlFQUkkzY0hw?=
 =?utf-8?B?UExvSkMzYVNKN0w5YWFvOGxyRWlFY3hKdWxKUEQ3TjJNc3FsUmFRUksyRm1n?=
 =?utf-8?B?VTJSYkNFWEdhTysyTjBHQnRpdEY0cm1DcmVZNkNLNkJqMDl1U3hYTWtVdXRw?=
 =?utf-8?B?aW0wSkthdVJ1WjBvV2ZyeEl6YnBrSUpLZzhpcTBrdFNtVExjQ1lpRTRKMWpD?=
 =?utf-8?B?bHpoTEZHTC9iN1NURm8wY1oxV2M3S1J3c3N5V1h6NWhJdWdLU1BVZk5URXhx?=
 =?utf-8?B?Y3JJWmJxdzZSVmRlckEwTU1ETkliUDhTNlQ5MVRiZHNlQXFOREFtWENsbUZh?=
 =?utf-8?B?aEpyMWNnQ0VTTkUweUxLQnpKUDlIY0ZuUDZCZWFZUmY4Zm9ZclRab0QyN1Bm?=
 =?utf-8?B?SGVBblEzclRDVlZFV1BsblNjRFNRbXNvQkV0Vk5jUXJmU0xhUk9TbWoyWWtI?=
 =?utf-8?B?aU1EMWpMLzNidlE3akdxeGVtV3Fwa00yckcwUzVTUS9wWG4vUStKdURmcWF5?=
 =?utf-8?B?eDYvN082WkZ3N0pweG9pdXlKa3ZIbDlrbGtyZ3FGQWwzdi9OQWlZU2tCOGhu?=
 =?utf-8?B?UWlxWkFhSWNvMkU2Z1RWdmk1Nks4Sm1QNWJ5QXNTTHJmOG1XMXlENnlvVzJ6?=
 =?utf-8?B?WVRta0hrWGo0UTE0ZFk0d3VXUUprRnNianY2NHBxVFFLMVN4VDUyMUpPRk80?=
 =?utf-8?B?L0llZDFZNGU0ajlpc0hGN3g1WWduTGVVVTloMHR0RC84Y3VXV2dpRGY5T0RM?=
 =?utf-8?Q?o0tVO7gMBZQNtABsAE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e419dc03-0998-4780-fdbe-08def1403f22
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:18:57.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldSbMkjPkdi4xvinMPi7/BD1OXuOcsWL6DDCFhdu3eTO5Tbj1XNP5AV/XYM6dEAjBCdZdTfymO5Df1ILgP9dCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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


On 21/07/2026 3:13 PM, Viacheslav Ovsiienko wrote:
> The mlx5 driver requires special objects named Memory Regions
> (MR) to perform DMA operations with network data. The memory
> pool(s) is used to provide memory and to cover pool addresses
> the mlx5 PMD -pre-creates the appropriate MRs on Rx queue creation.
> 
> The pool memory can be non-contigous and split into segments.
> The PMD created MRs on the page alignment segment boundaries
> and it could cause the overlapping MRs (in case if the end
> address of one segmend is aligned to ceiling and the next
> segment start address is aligned to the floor).
> 
> The MRs overlapping could cause the wrong MR fetching from the
> cache for the mbufs in the overlapping area if the starting
> mbuf address falls into overlapped area and raise the
> hardware memory protection exception.
> 
> Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

