Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B1ACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 17:47:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F4E402D9;
	Fri, 15 Aug 2025 19:47:25 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by mails.dpdk.org (Postfix) with ESMTP id 88A01400EF;
 Fri, 15 Aug 2025 19:47:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYChsR3P/355uxMU5iEmwS2KAmEV5Ua2HmGNSkwcA5+3bRzt5ZLl+DmqG2KHeCUug1J4+8948YXgLYtuvoD2+KS1stSRqlLgnhbxGIlGvP6snmcjXsORTd6FebwiTCvk+E/pIASHJ1XEqc8LWfsC0EHlWVQaGb8fU1WyG2M5/Jp1Ck/u3SHFiZTu+AwiGfzi/U99vRFwsUb176kngo4til14Wrtwgq+JfA817voZsgjODuEHP+uX5J8W8UWuqa2SZ4AeV/RHzathQMuYlWtLoQ+p5AUJmM+njXhCImm84oGOf6BXnxYa36jymsPDLZG3v+IN+BCw19nXMLxHvKpCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BknIGIazPtF81m/zI3EnbdslKZAHuUw7UzTkHGAnbqo=;
 b=S/QgWCe+DdzZtWZlaQvMJx/hr89+LfBDfvk5xRTN8+WK9AaUhg8fqk/oanQUi9F3l/ygjyTWgliYwpxvuUbQjSUS8M+XcXJd89+/lMaHi0O87tFZUKAcObmrEcKCgoVMxNdBkyn+YLzOYc37RY+NvIbTBijW9tKIz2dDZNJMFQ/E1TXOzioMxHn/rlDNuKg52KW5luPmY3pZxZ2cVxlAX/xn2vvmRjvAPGBO/TfRlAjXbnuG3LOdj2BijaRMbNvSnIn9cCVR+wfWgCQCDVPsxx0vyVC+Ogr9gcGQXvGEHNJusCd/n/1pemUnNpbJxkqrS0I1VOZPn4yhHyU+TtvmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BknIGIazPtF81m/zI3EnbdslKZAHuUw7UzTkHGAnbqo=;
 b=KxuEnAR6Do670ZOILTIzpITU5jDYiTC+zkQ8mVZR6ri3fxkqvNDQ06pspXDG/3mD6H6hTooKH/j0CbV06wT70oBSgDSelulH+VMZDRvWfcwl9A42DPRDMMpUaNV/jAHM91L5VT89DkHcTSFsZA5VamXgQqoU9PSOpazVQfhDbUQDnf8ZjGi63didDfoxaFn43eyC4ykgv/Ggvb6I9Jaem/PjIbEd63MiO5yKmmBjQfjE5+1TdvV/OjTpPkQI1q6VQINldwOxmfw/aleYQ13yRRxe5pp4k8GlImXk9DAEBSREq5mmCmRYZAxNAkMLP9hIxFTpvW5NQPLDnOLWZJhN3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 17:47:21 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.9031.018; Fri, 15 Aug 2025
 17:47:20 +0000
Message-ID: <55321aec-00c9-431e-9cb3-4a9862d514b4@nvidia.com>
Date: Fri, 15 Aug 2025 20:47:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.3 patches review and test
From: Ali Alnubani <alialnu@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee
 <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
References: <20250724161514.396245-1-ktraynor@redhat.com>
 <1a0cca7f-fd45-433e-bc37-2b4b8ea7faee@nvidia.com>
Content-Language: en-US
In-Reply-To: <1a0cca7f-fd45-433e-bc37-2b4b8ea7faee@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2183e3-0dcb-49d9-04bd-08dddc23c8bb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHdrNEtNV2NVZFQwNFN5Mk5jcTZ6N0dGOW9yUHdQbkwwWkxWSmlxZ3l6SDVy?=
 =?utf-8?B?R2w2bzZEdXhJNTJJQnZ5WGMwNWxoL3JwVzQ0Tkc4MjZKM2pucVlHVTVNT3Rp?=
 =?utf-8?B?OC9Oc3JmNEx0eWNKbEI0bEVvaFBMTG52RUwvN2VVWnBIMGJXL1B2eldrem9T?=
 =?utf-8?B?TE1GU0s5WjNmRUVHQ2VsYVFvS05ISjRNQ0N4eGhDY0s2NUF6ZWxRUm41ZGNW?=
 =?utf-8?B?anJXOEhtNkd1SW1EbnZtc1VLQzZzSVZUc3FHM0hGVSt0QjJ3bDI2Zy9seVA2?=
 =?utf-8?B?b0h6SXlGOXBZWGhnZEN5RTlETTRmY3cySXNLdDlnK2QxcHRlNWdOajVtSzdF?=
 =?utf-8?B?QzNZdDllWXVZci9HbnBvSyt1OVcyd1NHazlCbkJCaVJ1anBiSmZWdVl5c09n?=
 =?utf-8?B?SDk1NWVja2VEUW94czR2aDFTUzd1SUxuN1JvQ2NOZzd2alpWZTJKUjN3WmR1?=
 =?utf-8?B?bHAydVdpRkVSQWZ3bUhPQXZxQlF2a0gybDY5bTB6Nm01MnVha1dEcy9hWGtB?=
 =?utf-8?B?YTdvZ0VSWTg3dG9pTytoTDNqTS84d01MclJCaTlWWnkvRFdIRWtYZTdLKzZZ?=
 =?utf-8?B?LzY0UXVxeEdWUkxHQlZ4M1JlbFhhZy9URkVaUlBTZ1dhdlh2Z3pOT2dEZmlI?=
 =?utf-8?B?Ukw4Z3p2c0pBSEFlUzlrbjI4dVRQQVZSNW94L0R3ekhMNDZmai9VSVFPNXZl?=
 =?utf-8?B?NnFsU0p1dk84bTI1NzhWOXExU1Ewc25pcWpBUHkvdURMVFkrVmhzNEYzY1Vi?=
 =?utf-8?B?YURabEg2NHlza3F3UGx5TUZaQW5hNXQxeE9ISEFacnpWZER1VzFjMUl6SzAw?=
 =?utf-8?B?T2xUazN2d0x5VkduWlRSdURUQTBEeTFtZzIxbmw0ZU5KQjV2dW5pdlV0MVY0?=
 =?utf-8?B?L3NOUThldDU2d3Q1NEUxSFpWQzFJYnBReDRHMEg5N1NqdkFzb2prR080Z3VX?=
 =?utf-8?B?MVhLVjg1WlRJN0ZWRUFKR3ZkN01BT3FkbURhTkt0RDVHb0tWRVNmWmp1ZWI2?=
 =?utf-8?B?K1BPTHdaZ3dCMUc1ZVlVS0M1K1dOZExKZmxFN1d6WjZEWFJBOGJtcEtZRzJ3?=
 =?utf-8?B?OGpXcE9Bc3J4U0lVbkIxenhzOWRCSFdwb0RXb0djWXRISUpzY1Z2TkJOaTNX?=
 =?utf-8?B?Slk5cU85U2ZTNHMxK01vcTRmQlluVHJseWgwOTAwbUdQN2c0S1hRczZVakZX?=
 =?utf-8?B?cEhMaGZKc1lVaW9Zb21ncHhGYUJlWWYza0VvTWNQZ1AwNy91aWxzcjhYaEZM?=
 =?utf-8?B?NFI1UnRKUkhkd2lEZmFMT2t6NWlXK2h0T0EyRDZNRTJmN3NoS25iTm5NV0Ju?=
 =?utf-8?B?TVN3R2YvTXZDSEk0Yzc0K2pSdUMxMlBwOFdVYkZvbmVWSkczNHlMRjhXbGhG?=
 =?utf-8?B?VjlOenE2MmwvWVd5TklUb1M0am1GVTBWT3lIQloxbkVCaElCQ3pvYWN0LzlR?=
 =?utf-8?B?TjlheThEL3h0bUo4YlZtYzBOcjRGQWpEWmFaUnJWZTI0cElQdTQ3ZGFHQjFF?=
 =?utf-8?B?ajZMenNmTnM1dnNYcFJwUVA4ZjZzS2RDQmZ2eWQzOVZxVEhpMmptZ2RCaDRF?=
 =?utf-8?B?SDhpem5WMUJQMnYzT1pGY0NkTmxuZlg1bXRXMlQyNmZpNng0WVZIb0NEN2ox?=
 =?utf-8?B?WXA0U0I5Z0IyakZmUW1OT3BMOExRZ1phZHBYRWp1RG9EWkhoOUthQXR3azdn?=
 =?utf-8?B?aTVPNGo5ZkMva0w4MEdYQ1pOUWMvdHpNS2UxNmZXQXBqY0I1VFJJVWc2MllI?=
 =?utf-8?B?YU90eEI0ZzJXelZreUN0WktOVnJqZktXTzh6b3BUc3FYa1U0MEVoc2xBU0R4?=
 =?utf-8?B?eERsOS9Zak9QSUk5ZHJ3d3pXUmVCT2lIODNvakFpUXZOVUFqOStZT3JDbW9B?=
 =?utf-8?B?NWkzTU0rQjR5bUhkR1A3Y3hKclpLLzEvUWl1ZUlOT29aanBYQytIeEJPNnQ5?=
 =?utf-8?Q?DLKa3e+QQ2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU8wUDdFeG5RM2VuZnllMW1LSmczUXNNdTQvY2xRSlVUeFFRYWNxVmxWbXBz?=
 =?utf-8?B?cnAydXV4MkZQdGF0MkdFeWhUNzExZ1BvV0dKelVLUU1STjZkemE1MHBndERC?=
 =?utf-8?B?L3ZmNGpwbXNYRTVZSFZWdmxNVEFHa0Y1ZGt1RlFNNDhyREhGdmNaaHNnbExB?=
 =?utf-8?B?TVRKanFlRWJleFFUY2hWRC9pdUlZWmZOZm5HT1I4b2E5b3VienV1bnN6eTdJ?=
 =?utf-8?B?M0FOUzRocEdacFF1c0FxeDlBUTA4QWpaRXNEY1E3WUc1cEI2bThOWUF3UTJk?=
 =?utf-8?B?U3lHdFdiS2JKNVMwb1J1dEdnRUhEK0lyZDcxQWhDUS96SyttL05KNWdONHpJ?=
 =?utf-8?B?cXBCWm5JWEYrTVNTYkZPNnd1Y1Bxc0NZaFdWaUEvdEdWSVFXc1N4ZTNoZjJ4?=
 =?utf-8?B?bGNzdHNKNVdVYjkzMCtWWk80TE44QndWUk40NjBIQlBzNmxVMllHcUM1ckcx?=
 =?utf-8?B?UVVHTTRSemU3eVkrMUVmcUw1bEVDZnh6cERDWVo4bXZwRUdKNkFwdm5wOHVl?=
 =?utf-8?B?ZE8zYXJEZnhrS0xPMFdoaE90WS9XMTNoNG0wVU5RaFZjdE9wMEtJem0valdV?=
 =?utf-8?B?QWRRTHFMVHFMM0w0ZnYwRUhmK2NMMWRyeFJEdjZzRlc5cUFVSXJrYUp4QVhB?=
 =?utf-8?B?TVdMUno0YWd2Y0I4QW9uQlYvUXV4Q1RZM0VoQ0hRRFBYZFdhaGVNdjFtNzRw?=
 =?utf-8?B?bERmdmVLNVpSUTg2MVpiajBJL0YvbWozVkxHaU5lOGtNclBuZmJNNjZRaVVC?=
 =?utf-8?B?Rmx5dEFqRFBpSVJFY3ZQRlhKVy85QlBYT1NoSmd3cmlPM0NoaE5FOVlJdUpt?=
 =?utf-8?B?V3haZzB6MS91cjBCMlJSRTU5Y3JOblV1TnJCNFBIM0hnSXcraTlhdk5YSGJs?=
 =?utf-8?B?eXVWWDVWcWQ2UjJrbkV6WE5aZWUySGxhRTl5YnEvVEpGbnhFMDNTZEpQWmpH?=
 =?utf-8?B?dGtpTUVuTFliVUhFWjFYbm4xTDF5endObmNmMWZaQWRVTDFZZVlPK3JxbHFv?=
 =?utf-8?B?RGtnWGcvcHBkQkxONTZYWjlnQ0JUZFFFcy9LbHpIYm1zT1BzYWJzZUJiYmVE?=
 =?utf-8?B?WHd0cXVqckNQOEkrOWhjbmlobTJiSGFzQjdEdVJidXJZMXAwSlV3YklsK3d5?=
 =?utf-8?B?VUxGVElnUG01TFFwVU9VWWR3UmhjbW9YVFJ3UnhJV1ZsMkoxZzdUbVhxSWYw?=
 =?utf-8?B?MnZQUWRXSFlIdkFtbG1iNmRLMU5qaDFMNmQrdkd0cFVqTmI5VTNwdzRvdk0y?=
 =?utf-8?B?clY3V1RWODZQejRNakdhRXU4VnNHSjFWVGZKbVhkRkNxOU5NUEIyVjlES2w0?=
 =?utf-8?B?eGtjMlZSeVNzaVVtemZlcC81VElWMFBaazM0a2dhMjhNMnJ1OHlaaGRaOUhV?=
 =?utf-8?B?RjhBbnJqbXBTTjhvZmVweEJUa2dDZ01laVl4eUhpM1NxYTd2S01xN2tCbDl1?=
 =?utf-8?B?NDBLN0V3b3RDU2VKbTl2TzJwWVd4NWhxRUlBSE5ZTUdXWlJHdC9XdnY3akF0?=
 =?utf-8?B?SDFZSkJRK0Nmd0RxOGN6ZGlRWTk4cGROQ0lhdEZCejkxT1BFTmZhQThKeGR5?=
 =?utf-8?B?cG5ydEdGYUs2ZnNiTnJKMEI1ZU9QaDRTa1ZNZWlGV2ZPcU9aVC9QQ1AxSzAw?=
 =?utf-8?B?d0JQc3NwWlpFSk9aRXJ5Z1k2N0xtYkN1UWx3WU15UlBwYUZVcmpkbC9MZnNk?=
 =?utf-8?B?UXZxRTc3N0hBU0hBMHpiN0xpRWNtSGRTellONmRBNWtJR2ZEMVdzNUtrUDJR?=
 =?utf-8?B?MHoxNjdwVCtPTTZEdHhOeitEU0FCMVk5VW1wK3dUZzNRVWZJNnU1aDBoYmRH?=
 =?utf-8?B?dDVzUnVORTcxTTRvcm5lRnhkV2F0b0lTYklMUjE2eEZsM3hHRjk4RnNjczhZ?=
 =?utf-8?B?NmRUVVRLelVGZlM1MkUwTW5qOWVuZklOMy9ZL0RZc05IMzg2WS95Rk1ZeUp5?=
 =?utf-8?B?SlRrNmtYZmlGMWpuNTFUQzZuQlRpam5Fck5sL3hQV1NPRzBLbC9ESTRTRXg3?=
 =?utf-8?B?Q0dWL0RQaHZNWFFJV3hZZVc4M3JwaWk1U2t4K1hLUXlMd2I3RUZMcFc0bVd0?=
 =?utf-8?B?a1VISXAyemsyNU9WMXdCL2xzMFhnT1VHSVF4VjZqVERxR1UxTXdzOUJvcXhw?=
 =?utf-8?Q?27wJuZpNBYW53QkfIRcX+1dpS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2183e3-0dcb-49d9-04bd-08dddc23c8bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 17:47:20.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYqWUv7b0QEWyMlbnfFhx6nBeQvmNAix5H71Vc/iEkT6c2Xhs8jrTS4Gw9p7rEFFdOPaIictfxu912v9tXV27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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


On 8/13/25 11:25 PM, Ali Alnubani wrote:
> On 7/24/25 7:15 PM, Kevin Traynor wrote:
>
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 24.11.3.
>>
>> The planned date for the final release is 12th August 2025.
>>
>> Please help with testing and validation of your use cases and report
>> any issues/results with reply-all to this mail. For the final release
>> the fixes and reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.3-rc1
>>
>> These patches are located at branch 24.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Kevin
>>
>> ---
>
> Hello Kevin, apologies for the delay,
>
> We ran the following functional tests with Nvidia hardware on 
> v24.11.3-rc1:
> - Basic functionality:
>   Send and receive multiple types of traffic.
> - testpmd xstats counter test.
> - testpmd timestamp test.
> - Changing/checking link status through testpmd.
> - rte_flow tests 
> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
> - RSS tests.
> - VLAN filtering, stripping, and insertion tests.
> - Checksum and TSO tests.
> - ptype tests.
> - link_status_interrupt example application tests.
> - l3fwd-power example application tests.
> - Multi-process example applications tests.
> - Hardware LRO tests.
> - Buffer Split tests.
> - Tx scheduling tests.
>
> Functional tests ran on:
> - NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
> MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 22.43.3608
> - NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
> MLNX_OFED_LINUX-24.10-3.2.5.0 / Firmware: 28.43.3608
> - DPU: BlueField-2 / DOCA SW version: 2.9.3 / Firmware: 24.43.3608
>
> Additionally, we ran build tests with multiple configurations on the 
> following OS/driver combinations (all passed):
> - Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 22.04 with rdma-core master (091ddb5).
> - Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
> - Ubuntu 24.04 with rdma-core v50.0.
> - Fedora 42 with rdma-core v55.0.
> - Fedora 43 (Rawhide) with rdma-core v58.0.
> - OpenSUSE Leap 15.6 with rdma-core v49.1.
> - Windows Server 2022 with Clang 18.1.8.
>
> The following patch addresses an ASan issue in testpmd:
> https://inbox.dpdk.org/dev/20250730113243.197386-1-mkashani@nvidia.com/
>
> We are currently investigating additional functional test failures but 
> have not yet determined if these issues are new or present in previous 
> releases (and appeared due to environment changes). Will update as 
> soon as possible.

Can confirm that we didn't detect issues caused by changes in this 
release. Apologies again for the delay.

Regards,
Ali


