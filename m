Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D52940653;
	Tue, 19 Aug 2025 17:32:33 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by mails.dpdk.org (Postfix) with ESMTP id 266B4402E4;
 Tue, 19 Aug 2025 17:32:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxb56cXFzQDAWohNNCiwBfEr9Itpb65HTHAK+yzM5gYnDs4M9IPcrTQk79wndCHNdzetn81sE4lNHCcUoozIyZhNrn30EFep3A3XZSnZt7kLwGkmdbK7Ew9kWtTMx6LZFyun+bPiRO+LzqLH54ChykkC7+Q5JOnAMuKR4gJRcHzdtb2+6DDwj9ssJUBbhHd7ndWe4DwuHpr44sT1qovJTx2Q+cZZnpaI8YW5FhPb3ArvnvILv1Xgj7iB7og/kRHhCQZXvZFrWbrrfGDwN6MLGSe/KO641CCq44lv4mIU86MvS5Hbk9OAy3R060qogj+Gw6oOI5SvoWDX/GPGNP/baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgjT95PAbMEidMJkI7IdeCa5MVMROjkMZi+AyyONF6c=;
 b=oyryKhu5oc51kPnRH2dwvctkN4UXidRvU04MWwY/i6IHSWn4EMHdcbPh34O1phqn+4iU31CM3CkV/9dlPnI7g/mUu8pEpubs0GU/ofaxov5JncvpTFt6l8fHYOyJ70X4Mv1tbdAgFkgjDmZiIRYnU39SzrQIez736mWmQgwPWKEXyidS8PrGtBf+kylWv48liqi3+nNEb/XSNgNOQfsj4/Ovzd9hlYuc3rq3L7ckY+DFy7UDdVpBKtwcWbw5lAWEQ/9cyczZz2oPmhtnF8M/wkjk0lfq9w1lwdgxoE1VGzoTusje7aycxXjUlhwLDyBC/8wOijhVb/Qzc3PTwjRvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgjT95PAbMEidMJkI7IdeCa5MVMROjkMZi+AyyONF6c=;
 b=R7S0pDMvcA6W96iaBV9F/3n3m46TvpLch4X7OvDgA4Tajm79a+N1AIWPonfP5UMSnGAkGVfInJLbA/pkGPqyrGv1+8iobSKE4FPHBz2nxH4SKS4AIgt6ZF4RlyS+AYTWGvl1Oki/6QjPm9hnysS2FLfBBWFRkb9Z0uTfXelBMxtt/9aYHVr9LWYUPlQC5B+YkTzeLnOj691CUAqCWlS30zr7Vi9lObyXzPKFWXACYf/2Qi/tYn3S3L44GxeTcNOjqGVmeTHprP4Yde//3vNh50bLlpXnUxG3Ko6O7DwogFpBV6YZOJ/4cz54Sszs9B7SVh1HvQeRc1Q8yFCl/JSs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 15:32:27 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 15:32:27 +0000
Message-ID: <ac197013-cec0-41cd-ac6e-0755e7dbc806@nvidia.com>
Date: Tue, 19 Aug 2025 18:32:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 22.11.9 patches review and test
To: luca.boccassi@gmail.com, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250723160822.1686060-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 071d10d5-9c1e-489c-bd07-08dddf359a0c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTZRQkxsV3hzcVZhUEpDU1B4b25raEFBUW00bTFGZm54NEpKTUxoa0ZJMGc3?=
 =?utf-8?B?Zk9Va2FFM2Y4cGZYQ2FwYW5aZEZTSERNblNLam41MmpCZUNneXlGRFoyc2JT?=
 =?utf-8?B?Yk5GVC96MExBeTNVZkh6Rk5qdEJ4NWNvcnpsZkVXQ1dIcjNMTHFGNG9KdVhV?=
 =?utf-8?B?dGN4dUFsZGJiU2dMaUhHVGkyVXAyNHQvWURzVzA4RkdORGFGQmIxeXU3Ymo3?=
 =?utf-8?B?eXZzQkJtVFA2UkFMa1U4bFJtZmJXeHArNndvbUtEYTE1SUxWM0RwbUdPWjlC?=
 =?utf-8?B?WTVkM1g3dUZjRXRoVmluQyt2MHl1TXVWSHRRd3ZaREYrMjZqVWRreVYwSUNI?=
 =?utf-8?B?eFJidXVNWGlDcFNSYm9uZlBTSGVnMENpcVhRTFFXVUgzdm95TS9PMXRXQW80?=
 =?utf-8?B?VTIra2w3ZkVsWUllS1NBYmwyTE9lcDNoN2hSUGhBTEl4NEk3K3paN3dncjlp?=
 =?utf-8?B?UXp6VHhwbCt4SUpvcE1zS1R0UDRBTWlBa2JMcE05UWovM1gxZFZFS3A5Q0Fh?=
 =?utf-8?B?Y20yM0pUR0p3K05TNmJXQjkvQzNmQkJVcVIwV043RCtFZCtKMjlKNWtyUlRl?=
 =?utf-8?B?UjhBdDllaEQ5UnNFMndxeHUrWHVxQmoyYXAzckxSbTdyUTRLdk01eEQveWxo?=
 =?utf-8?B?bU9rYnF0dCtQWXp5NjcyM1dSUzdXM215aGdGbEVSbjFpNE42RmFkNEx4RnRS?=
 =?utf-8?B?dFd3VTJKZEVtQ1Vhb205dmk0QldDMTErSWg2d0JiVGZHU1pXN2pGTVBZdWNa?=
 =?utf-8?B?WjR5c2h4c1hHdmNrVGlSdStNYy9ONEpXWmthOGxBTUw2cjZYOWw3ZnJIM2dj?=
 =?utf-8?B?dE01bUxaNExXSzdmZXJEcEdER3FId1dEYmlGbERYRFdyY3Y0bVlXZk1SdVF5?=
 =?utf-8?B?RTBURGdNb2JielZ5NG5UMmt4cENaRUtBMFZhdnhxYjIydFhmUldMQldXNDBJ?=
 =?utf-8?B?MERuR1FQL0d0YnV6RndtWGRYYWVYSUl4ajd4TzFQbyt6eFI2SmJ0bElraktK?=
 =?utf-8?B?SEhkZjAvQndieHFUaHdXWmlHN1Z1RjZLYnVicS9UbzNWc29mR2tpNExQY0ds?=
 =?utf-8?B?Zmt6MGRFem5NVzJGbjFaQ3NyOGliL3Y0YlgwZjFDRmtOdkljZWRRak43bkNk?=
 =?utf-8?B?NmFsR0MrOFNYNXMyU2NtVzcxeDJwWTcxa1hhdmxmeE9jc1Z3RjRMMG5zZlFu?=
 =?utf-8?B?UXRtRGNhMFM5QktGZHRmV05oWVozRTBIeFJsWTBYM0c0bk02K0lrNW5ZaFVG?=
 =?utf-8?B?RXR3YXlxR2NkRUdOOEdGTWdKYU9WQW1HVkVMQXUvQXhrSU10TmtJMDlQQlMy?=
 =?utf-8?B?eG9HSW1KVVdLL0RVL0hRQkhWSktXdHZkSG54OHZnc0Q2YitEM3V3K3E0UWV6?=
 =?utf-8?B?K1hvNGZBeCt5My81bUtKODFBMXFWclNQMU96YTJuaDZZUDNwRmwzWHFXUmQy?=
 =?utf-8?B?Ujg5b3RrdlkvekFRYzdVMnk3RnhhWWFkQUE5RjNyMkhQeW84aTRXak81RkYy?=
 =?utf-8?B?QVBMVTRsc2RGaFBXbkNkMTE2REhnUld5YVdqd1Y5OUY2U1plOG5QeGtkMm5Y?=
 =?utf-8?B?TDhSaDNsWWRTN3N4bzZhSHZCVFplUFJFZVNJUmt2Q2NYamc4ZjUzVGJ5c3ZF?=
 =?utf-8?B?TVNKWmFwYjdRdTFxbDRuYWhKTE53QjNRVm1PSUF5Y21ubk1iZE40eFJuczJ0?=
 =?utf-8?B?TEVyUjJsMXNCZjVqYU5xcGE3Z29RVis2VGl2WFlVVVUxTVpjeEszeG1zTHhp?=
 =?utf-8?B?SldpRjErV1N3SklqQW5FZlU0cEM4NU83TTdGSCtsRDdCOExNK2Nja2hUYkkz?=
 =?utf-8?B?MCsyalM2OGN2WnFpU3Rxa0JNSFM5ZjEzQ3JSRndxRFNwRkF1UkpMT2tNbmdn?=
 =?utf-8?B?TEZINDFWb1ZXQ2NZTjVHbUZ4aURONmFpazZpMmwvQm01d3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFTTTJXRHRlOFpIeEpsSjBGTkNMclJ5R0EvbkVtYm0yajg1eUVJdXluNXU4?=
 =?utf-8?B?WjIwVjRuK0g1V3hPK1BjQUFBa09MQ3J5cy93WERhK2NPWjlGWGlaSm1vWnNO?=
 =?utf-8?B?d3RveTgxanE3NXZ3RFBjcVNxZ0RrOHlBRTczcjl6RWJ4Q2p5WmRmK2VHdUYr?=
 =?utf-8?B?SmFLMk5yNGU4cDZOa1JjL0lmQnNYVUtSQ3NsRld2SzNSZTJURENTWVdObHRh?=
 =?utf-8?B?VmhQTTA2T0ZaYXBYbHR3ZXMrY3Q4QVlqNnVLcWVZajRlVUFjRy9DWmYwcVQz?=
 =?utf-8?B?YXdMYlk0ZXpGOEZ1alY2TU9VS0tZbVhLOE52bVcwcnlSejVnVzBqd1BYYW9p?=
 =?utf-8?B?K3RnNklEaWwwNldmVnBJb1JRb2YrSlF6SzZnZGVlOW9Zb1JNZ3RPcVJhQlhr?=
 =?utf-8?B?NCsyWUlLN0pwcjhwSjRYQjhqak5oM0ZlbUxTYjZxRHl5dWQ4eGpIOE5FZ2Rl?=
 =?utf-8?B?OXg3ZVJwYVN1OU5kYW4zZ0IrRGNXSzNlRGgwbmNucmcyTnpMWVcrMmMyYkU4?=
 =?utf-8?B?cE81MnVwcS9keHlJbi9keFlCZ2YwejYxN3RQTGlWREhDUUdwemZOY05ZcHU5?=
 =?utf-8?B?MjZHVUhmaXkwaWNKbDIyZXFXaTROeUFmYlBpeFBYTURMS0FrSWxOQ1ZETFk1?=
 =?utf-8?B?Y3JtRTdVT1FYUnlKUXFOT2JsaCtuOEczRVZmV2tWUWdpdWpKU1M0Q0RiTk5k?=
 =?utf-8?B?M0t4UGY0TGZVYlk3MzloOEdLVGthNGxjdklIWENFVUZveHUwbVo3aE12Q3BN?=
 =?utf-8?B?ay90Y0Q3MEsxdVovc2toQkhCTnJjTERpaEQ5MWxpaXpHdTdDdHlLSG9qM1hG?=
 =?utf-8?B?WTB3cTVEcXVmY01oSHZoODBXZnBYY1FpenlrSGRyVE9nOXY2M2RmU0YxNEY4?=
 =?utf-8?B?Y04vc2plZEJwNHNCbkhiS1J5MFlmVkorRENVNUl6SUZzaStqMHl3clZTZzZX?=
 =?utf-8?B?akZQYXZnemNNZmU1aTBKdU8zM3lhQkFqeWtnSGgvWkhHTVpBbHFpdzVHclEy?=
 =?utf-8?B?QlNscXV3TG5lQU5yVG5wczBWKzFVcnFPZHliR2tzdXV3MmRSdjcwaTZRcXJQ?=
 =?utf-8?B?ZW0wTktPSVluVFBxWG5ObmZkSFNmVDA0RFo2Mkw5L0VHM3dJUHJmREdZUDBB?=
 =?utf-8?B?SUZqSUFEVFB1NTVNeG91MnVrT0p5THRhSmdkMlVZU1JMY1YxeG5oWVkxZmND?=
 =?utf-8?B?Z0ZTZ3M4R09DQlRzSmkzSnRVZThHMFdVOXFjcEp1VVdnaGpoUGlBVmdhOEZI?=
 =?utf-8?B?T2NaWE5QVzk4b2ZHNzRmT1lpNW1PMnhpTmtmb2dCMWkzNStJUWdXRnFtSmxQ?=
 =?utf-8?B?QnVreHZpWjl0dDBmbjRKcDJFZUpZVVQ5WlMwbTZ2cmZXVTZOdXRzRTJrYTRO?=
 =?utf-8?B?TC96dnhFWHUvRFdlL3YwYXJtQkZSRkhzeTZFZ0JyUCtiYXdMWEtJSXlESFZ1?=
 =?utf-8?B?eU82U0V2d1BKRzAvaS9qQlJuL3ZxUno2N2NQZVZWTjRrWHIvMUVUUDhUTmhP?=
 =?utf-8?B?QU5oaXRrbE1FZStFREZNS2pzNDFYN2hJK3V3NW5RbHFCU2RHNEErU3JXRENQ?=
 =?utf-8?B?S3pmYW9JbS9LbCtBckp3RE5mbTdlaVluVVZZWWZpNTZYbldxZStKOC9VUXlE?=
 =?utf-8?B?cUZnM2JQRE1wOGFJWVJmSlFuTnVybjBEdnZ4QkdXMGlVM0ZPUkY4dXhRbklI?=
 =?utf-8?B?WGx1bkRzOVRzZzFDL1g2SHIrRnlvYUVPS1VFVmdoOS9YWWh0Mm13VzdXclQ0?=
 =?utf-8?B?bEhYOEFZcDgydUtUcm50cHUrRFBMVitWRmNJMnVpRVNUdFhzNXhnYjhDV2pC?=
 =?utf-8?B?K2xIaXlvL2gvdUFWVnBqd29ZUEltUTBLRTM3Y3VpL0VKYm9ZVDV0SFpqaXNv?=
 =?utf-8?B?bWMzbGlnY2YvalUyQm5qOXlYcHU3QjRCTmxiOXBkV0cxOTFQRkg5eGRLb1lr?=
 =?utf-8?B?Y1dKamZHalE5OGUyRXhqME01cXUzQ2VwUFhOSE94MDE4OVhyL2tsVlkyamNj?=
 =?utf-8?B?UW5QTGMzZWdaaUI0MTZ0Zy9PcUQxUkpadXRKaFAvZW15a2swTkpGaHk3ZHRy?=
 =?utf-8?B?MVdYWTR0WGFNM3piMTU2eDhFWHFsRWNLUk9EdDlzTndsaE1vZ3ZXMWJ0NU4r?=
 =?utf-8?Q?V/tdd+fJmLXjTJuZmI41yDz+a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071d10d5-9c1e-489c-bd07-08dddf359a0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:32:27.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TL2U2ep2Ec3wDGm/IgMp8PVS5/vzH9Vrrr/gvIiTl7SFQ9B7J4ws0uUl6cAomrbNH2qjapwxnFXd2YFwJLnWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

On 7/23/25 7:08 PM, luca.boccassi@gmail.com wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.9.
>
> The planned date for the final release is by the 25th of August 2025.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.9-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v22.11.9-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests 
(https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Functional tests ran on:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 28.43.2566
- DPU: BlueField-2 / DOCA SW version: 2.5.4 / Firmware: 24.39.5050

Additionally, we ran build tests with multiple configurations on the 
following OS/driver combinations (all passed):
- Debian 12 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-3.2.5.0.
- Ubuntu 22.04 with rdma-core master (091ddb5).
- Ubuntu 24.04 with rdma-core v50.0.
- Fedora 42 with rdma-core v55.0.
- Fedora 43 (Rawhide) with rdma-core v58.0.
- OpenSUSE Leap 15.6 with rdma-core v49.1.
- Windows Server 2022 with Clang 18.1.8.

We did not detect new issues caused by changes in this release.

Thanks,
Ali

