Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC8CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E58F540653;
	Tue, 19 Aug 2025 17:27:08 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by mails.dpdk.org (Postfix) with ESMTP id B5610402E4;
 Tue, 19 Aug 2025 17:27:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5vu1S0aBwcVE3QWV2ajg3OTjvEIESlGRiBUclzX+IzBjb87bFmnjizWeOYLgFzTtIlUgo3b5Qm4l5FLy5X7nN/gH/Y2yvOn7+aGZJL/w078jbQQpzu25z9FPrj5m0l+rLizC8YRAm0O6GSPecLo+WcVt0P4jBjcrOokMa2IgteQZsZo08PNEXDHbVlZrI8d5uMP9znPMQQbvcLh1ly6Ed4NrIIZYpFz99EvMRpSjXKWgrfW1GIhjC1Q1VpVzOhSKzL4d3FrFJMmN0NOaEzbGw17amaO7afB7Iu/iJAn1ZmoGCqW2fasJ1BZayuRTkoebooTVdoMOYWo6V5oT0XhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPku+IfkQGVl1fMIxMSeA8NHihWsEP697oZh9H+SC/M=;
 b=T7plxt8mcr235N3KVkxXLis7AX+qRops01kSwPJNcTPfnGypFVxk+kY7yIBhqs3O1Y0xSsxJ9G/4XId8p9fG9obvDir7NLZ3DFR+CvP6PuWJpGRXmCFjVvMWBaZV4bIGnlGZNKQKWnNSrNkGi1UlW1ZuE17+npUbKbkQPhixPOHlSuD0VSbSHvo/iz4SlWQeJat8TzFkN+fN6VfjC7ikQ5MD6eqBY9vmWDNP0igP5KcACp7/sLOBMDThH33JECrTjZNqg8eNH4Mo5UIv0ZMoG6+t7k3NqAz0V7688/p/km8lu6PNrj/vyjONYJ026erZzvOicbyrSpYZlYKh4140lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPku+IfkQGVl1fMIxMSeA8NHihWsEP697oZh9H+SC/M=;
 b=H7XvC8gtu8qLb93+NtzSjTfbHEZnOQweWjn93ZWmidbRr8sVTAX/xCfJxSD04UFxIjxXBQ3IYfYzTLAs5zm5QoWwk/JhkZDkZfCkWTERPJZgkTbBd/9kd2VIPmB9ujyWU3q4tlxqdNlsHyJG2UGToGH556oaQ9VBQ2g2ctbS7oT9M5NK/PZqaF3/Ss4LDN/fQQ89jZ2u9JQevW+4v3BTq0xQNfVRfSWY2p5/5QrkbMAirzdX46FeXhDYplFN1NvwDnLSUHet+sAkMs6yW+4oxuaEoLZKldz8TzDh1kHMWb2NAlgIvy3qo9AUa5zKmIImIW8ENOGlf372pvmvLNJu7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 15:27:04 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 15:27:04 +0000
Message-ID: <8a89c883-e287-4640-80f2-576f6e8a1e71@nvidia.com>
Date: Tue, 19 Aug 2025 18:26:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.5 patches review and test
To: Xueming Li <xuemingl@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 benjamin.walker@intel.com, qian.q.xu@intel.com, yuan.peng@intel.com,
 zhaoyan.chen@intel.com
References: <20250811134220.45579-1-xuemingl@nvidia.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20250811134220.45579-1-xuemingl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0dd634-97ba-40fc-a7cc-08dddf34d97b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZkYnBOV20wSzlMOEl3Ukp6Z0NMMlQ2MGQvWTVVdnBKczNnSXlaZDVyVnZy?=
 =?utf-8?B?VmI2Q0FjdmZKK3RLbGpWRElud2pSOVhPaWtwRHNWRGdlcm0vUUhyQXpmR0pj?=
 =?utf-8?B?aGtTMFcwdDc3TjVWU0JWUkczNzluYUR3YU0vcnJlTWswS2gzTnY0Si9mOUtZ?=
 =?utf-8?B?MU05OXFBUmgwZWh3TUlsdGxZM0JSTk1EU3hZT2hyc3dOWVdQK0tKcjk3aVBj?=
 =?utf-8?B?elFDZlB5ZmR3VE41Yks5V0o0OGRkUWxPbGxLaThOeGVVaEZPWUZLckx0Sy9S?=
 =?utf-8?B?QUMrT0YzNWxZMlhQQ0NmWm1DUEJVZDRVRnVvSHlFdENsRG1JZm9Rb2RMbFEx?=
 =?utf-8?B?RnlEZC9HLzJLaEZqM3hwZE9oblh1TGNENDNRODkwSm9pU0kycVBpc3E3UVUv?=
 =?utf-8?B?SE0zZHAwV2hHNStwaFk0TTVLbHAwZmJhTjBtL3hYWS9NeUlvZUhTaHA3UXAy?=
 =?utf-8?B?TnRSR2h2QnY1VFhRWmk4VHY2TURNTURTcWN0bGJJbzVwVjBab2RlTUpIcGtl?=
 =?utf-8?B?SjM0QUp0U2MxOUU4Mmt2OTZuS3V1TCthR1JSV201VVBiTm1BRzA1MUltb0Ez?=
 =?utf-8?B?alZRRlFYSkVaMUpJVVNIcVBFV25pSlhGUkJZSURodkM2alRZcHJ1RGRoWmFM?=
 =?utf-8?B?R3JWU3RnMG51VGtMNjJJa1YxVlVjT2xDWW1yNnZmazJ2RDNtL3ZRcklaNXR0?=
 =?utf-8?B?TkNidlRHcGZ6dG11My9jZWQ4dTFnd21ZUmRpU2pNU0J3a2YremhESjJWYWph?=
 =?utf-8?B?YWd3TWtNL2RDeTYwWjFqdjVuQVhiNURZQXp2M1NMVjdpZnQ1eGtLaWJYL1NC?=
 =?utf-8?B?czMyK3lvSmdRR09hT0IvMHFhM1pmOU5YRWFQbEc1aW1rNDZNcnoxaU8vZThG?=
 =?utf-8?B?TXltNzdVdmNqcHdUQnlTYW82NnVyU2ROczZNOTRhSnlnRGh6OTZGeDhQUXhW?=
 =?utf-8?B?Rk9FcjJWc2RMNG9ISTNCR0w5YXlhMHF6M3ZCdkgzTUhyRHVUSmZqNWtiVS9o?=
 =?utf-8?B?cXR0Z2xSam5kNXFNdWFkbWFSeFh5b2RFcWIxdjVaV3o0ang1L0dDQlBGblpx?=
 =?utf-8?B?VE8wdXExcGlpd1Q3Yk1EWXl5Vys5c1Erd3dIeFNqN2tpYTE3K3pjQkhiUXNt?=
 =?utf-8?B?N21sRTIwY1lsbm5uZzllZCtUU1ZHd2MwZncvRDJBV2FEMzJrRFJ0bysrUUMz?=
 =?utf-8?B?bjRWTklpZXo1UHVvWlJyRDRVUVJUN0Q3cEoxRzJ5SVU1MG4yZzRwS0IrdDlh?=
 =?utf-8?B?UDJaNmVwaGo1ZENXbUhiT0tkUUhWaC9ndU40R24xdVkyczliTzZYaTlCajl4?=
 =?utf-8?B?RmJQcHFscTUyWnNCVTVKOExhZ2k1WUFxUy9UbnBadWdCWmhYbUg5aTdXUlJG?=
 =?utf-8?B?YU5NQjUvRkEyY3ZsMFg5ZUFScG9Edms3SFNHbGNyLzArQVhxQy91eG1GTnJa?=
 =?utf-8?B?bGhWTTc3TFFsek5pS1h6aXJHaUthWU1Db1VUVUdmTU1SSHhvS0g4ZURzR3Zi?=
 =?utf-8?B?Y2pIL2JocDZWWWRXbzN2VWxkQ0l3alVtczhEYUxNT0pTWlJBTEYvTHZDblVB?=
 =?utf-8?B?aExlemlTalBkczk3MXduemxOZDVlelZ5T0xFeDU1VHhtVXJlU1JoSTBkUnM2?=
 =?utf-8?B?UWthWTB0dnZkQ3FiOUJZMVdCM3Fsd3Q5Uk5TRU1TdUdKUjFGM3lpYnVwMlVJ?=
 =?utf-8?B?RUJSbW9XMGVnUHNPQW0vcjJueWVSRDlYeEVUYnUrS0RoVlZOZUVIQ3Y1Ti9i?=
 =?utf-8?B?UWNSQi9paHQ4WmpYcDh1blNnaFZRSE5jcklsVTl0WmxpNFhpYnRQdkxzVXhx?=
 =?utf-8?B?Qm1aZFFzVURZcFNDT3ozb2R5Vmh2enhKTUpocFdEU01TcHh4djdZQTlvYzZv?=
 =?utf-8?B?ZzlETEVHdlBhOHk1UTJhVFhvNWI3NFkxeWlrQjJZcjR3L2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWprN1J5NUJPbnFnUkg1cXdWczlCZFo2VGI0dk9sTEp0Y0QrN0VDMUVDUkhr?=
 =?utf-8?B?ZGJOZk1tZHppK0hNNTM2eHlKK3FtdTlNWEJpTEhvNTZxdmRuRjFtb2V6Vmpt?=
 =?utf-8?B?NjJCZXJuUklIaGdsM2Z6RGhtNFNBQklFUXNRdUdrUHlwMzBYdTBDMk9KbjBG?=
 =?utf-8?B?ajkvNlJDQkdQU1pRdjk4TmNkeTVEUGNTWkJmb3pwamVPUUVoTWxoL1JJaGpw?=
 =?utf-8?B?Yk4wcEhnNEExWUxDQTRkckMwa0hrTitKRFF1NHNiL1M0cFFBdEQvKzB5czZp?=
 =?utf-8?B?b2Y1R3hmMDlValQ5bDNhZFlLc292RGtZeHUyTWlaZlNPYkYyY09CY2FDS3Bi?=
 =?utf-8?B?R2szdER3eDFBQVIrcktKMmkyQnorSmZiYWJ1d1crTEFNaE9rNkhIZ0IxMWxp?=
 =?utf-8?B?OTAvODdQRE1KWkpMTW81MHhNeTBicmk2dUVacVpEQVl1NzlBVlRzTHhTaEVz?=
 =?utf-8?B?aWxPZDZrSk5iSWJlTUtWd25YeEdiQjN4YklQb2lpd21vZmwrSHRFdzIvMkdt?=
 =?utf-8?B?UGF4RjFkVlRKN1hMQW4zU09RMGxzdks2elBDbWRyWGRsS280bjBFTmpWNW5m?=
 =?utf-8?B?OElySXA5ZnpKdjNCYjNtWTlXWUNrNGdzT0FpcVh4aGdMTXIrSGVUeXNCWXNq?=
 =?utf-8?B?UkhYMGhTcE1OV2hEbW1lV3hpNERMU2VBWFYvLzZrNUdpaE9qYkZ1VjdBTEM2?=
 =?utf-8?B?SExmRVF1ajBJZEdzU3FXYXVTQ3ZTSUJ6dm5ZK2ZTZHJ0aGx4WXBSV20rRzY5?=
 =?utf-8?B?TmNLQ3c1MmJycUlmNGR5Q2NJU3c2NUsrMnF6RWN6NkM2OGExTEI5Z3IyUDVT?=
 =?utf-8?B?T2pBKytoUXU3eWZqQXFKV1hrZ2NpaGJxaGJsdjdpczcvVHJ3dkZpck5YdjdM?=
 =?utf-8?B?UXhwWkc4b1YzaXdvTE9SS3hLTCs0UzhQWE9TdDZERkwxa1ZNa2VyVlVieFZM?=
 =?utf-8?B?TDlWcDVDMHZLb2VSa21hamxiSFh4d2hCQUp0RlRjZEpsaVBjWG1GN3gzdmJz?=
 =?utf-8?B?c1JZSXZoSEJqTDhUZkV3TnhKb2VueXY2SWh6dnlJMngvUXUzZmM5YjdlcGRu?=
 =?utf-8?B?SktvbXFmVk11bk1od3gwVjdNbTdraDZBQmRCaUZKUEJZY0MvOStTWEIrWWtp?=
 =?utf-8?B?TkJvWVE0Z1dmamJWL1lvMFdoUVpJQ0RzUURreU8yZWVLcGZNUFIvajdhSzI4?=
 =?utf-8?B?N05QSENPdDVFZXNNYXBqb1k1V3ZTQmZ4d3dKRWh4cDhtRktiZXBzbE9IdSsr?=
 =?utf-8?B?c050c2grWTZJUXdmY1REQ1VYcUFiQWxmam4zZ2pqbHgvVUM0MmtxN0lxZWFu?=
 =?utf-8?B?d0R3MVUybHBYVHllMEJ5MjR5UkdTYXBvc241ZUY4eXRGaWFCVkw3Zi9iWCsz?=
 =?utf-8?B?UTkzTzVrWTJ3V3cvQ29xRjRBTmJydFZ2LzllU1lkNk1sR2x1NExJWk81d1VU?=
 =?utf-8?B?TDRNVzVhTzNUejNCNE5UcEp2NVh3MnllNzJmb0Z5SlByM0Q4MG5WTFhvZXlO?=
 =?utf-8?B?Q2NxYm96c05EQUdLb0djVlVmcDVtOC8waW9IWUdTaTY1VmxNUTB0YUZqWkow?=
 =?utf-8?B?eGVOWkw3ZmN2MzYrWHU3WUpya2l1RXU0R2NNb2FsNnpOa3RaRmpKT0dpSGtj?=
 =?utf-8?B?WE1SNVNUQ2pON245ckxRaTVJaHhTWHIxaENwcFpZdngwa1JMOW5SeXdPSXRU?=
 =?utf-8?B?VEIvYWMzTDEvbzZ6VmJTR243MjBrS29hVCtWYlpBRXQwSTF6VVRrNnAxRURq?=
 =?utf-8?B?MGxoWStXc2NKeFhUN3AwVjRyV013VkFOVDBlTkkxWDJKUmsxdFU4cFhBWk9y?=
 =?utf-8?B?OHVWRlVWU1VYT2QrR1drWTdpWHFpbHlqTkZwdlFZeTBQVGRlU0hLZ2NTenBr?=
 =?utf-8?B?WTVvSzNHc2c5Mm1BeW9TSTloWk42TUQ0V2xzaFdPT0lBOVJ6SlY5bjQ2d25a?=
 =?utf-8?B?NnBwNGNaemNkZWYrSWtvdzdIT2ZVUnNJVFdHa0NoZmVZNEJjSnJhSVFnOXRm?=
 =?utf-8?B?S2dRNWo2QzA3K2JYa29nYjgyMzd0c0M0K0RQMGQ2Y0pmK3YwTzJlZVJoRzhT?=
 =?utf-8?B?bno3UCsvNU5lcjJZWm15aUFMVnJ3QlBOVnFGOTJiNk9wOHRoRll0dXhYVDU2?=
 =?utf-8?Q?TguRY11/2q1GF0eTuPXbAjvoc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0dd634-97ba-40fc-a7cc-08dddf34d97b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:27:03.9727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFy1EI0PqRgMWDUYtCkZkYtWteckKeF0wJWxx+rAa3lqdFkEqSuQtyEt6nLLLkqKc/35jtXorW9Cujyy/JAmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

On 8/11/25 4:42 PM, Xueming Li wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.5.
>
> The planned date for the final release is 15th August.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.5-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---

Hello,

We ran the following functional tests with Nvidia hardware on v23.11.5-rc1:
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
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 22.39.5050
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-23.10-5.1.4.0 / Firmware: 28.39.5050
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

We don't see new issues caused by the changes in this release.

Thanks,
Ali

