Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42786CAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 12:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30C5040156;
	Mon,  8 Sep 2025 14:26:52 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by mails.dpdk.org (Postfix) with ESMTP id 458B64003C;
 Mon,  8 Sep 2025 14:26:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9ExAGQXZruiugNP/gZdPrl0vD8dKGVCfQPGxLs8hWH1om/5U2PQhEPamPkM+z0265SfVG25POP7BAPhbpKKE/sHOBjTfd9427nOvlp/SPDHfhR49O0HtytIpLJcOXF45CeHEC4BKzH9m5F7vQCTJYBlKWpiPmndL75KGZifyEVDq4XXUACDTdFZmPNygFCd6OdLfbD/kwrqe8MVlo8DpGcOPU4TPJ/ptvJX5J8Lbghds0wvaWyaWisavVF0okrHEYlBJg/e2WUSszEUAkxA5hrfNZoQDsxZZgjrtTmGRy5sxDpou+lOXy+L+QoXo31mBhP7RESGoEHv5Bqq9SUN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hVTsWniTg1xMMRZxmHW46Zpb9WDDdygtuUVHA3ltXM=;
 b=ydB85LV0pS4O2Kv8ZIdGeZ9wRsus4k5mptDbam2fDtAaDj8FmWTe4jM/eTypFZ5AQTLE427HkfmwLLZSOT0LhtrcuzXcB2yNCrDhyJgV4UuVtCllrzPB9Tz/ZQ7vUoopja4/YhSBZ+SnaGZ+CGk2uzfCGPziYKC18Izcn2b0PHxn/ER/3eEPJP8tJcFSWG6qKS1DI/10kjSdSZEhVaCi+WUcPTw7z87QidsWiHcp6zj0vHPSp8bHfLVh5/76Kd53R3kOMzQGBmoExHAm7OtB5Sor0/E9nmarnQb1g+7UVxSEGOXt9gTiv8OLt/Ya2ed3oGtoZ/zeOFGYRkAYshKALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hVTsWniTg1xMMRZxmHW46Zpb9WDDdygtuUVHA3ltXM=;
 b=IujKw1pJUkcyVoPKEyO6ozEorBkhaDIeETWhLmAcOgBKEAkjR1Rq1B0DAaWmIk5Irlwanz/hyFZRu8j1Bs+aQvrTBLMCR21lD5+JeZeJ3iVST18K4HQp/jgXSHeB/5xLcFTkT8lAc95pAfNy2u1QmMmTXu2N8eY22XJHr1tUyTCAGSrbdem3VRb4rJMXihT+ZB+Z1tExdHOScW0g/WPL9GQrem4jAqmvuVeXkXurelUqhlp7tSubXy2REmRU/b9dAfrxfQN2VmLBrPFQpVH3B+fo6+vZ27bg4OzHh2bMbG3cJOBa36hqoDyQ4X2hxnrn3ufcDr57jc4y399AiSC3wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 12:26:45 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 12:26:45 +0000
Message-ID: <7087eabc-25c5-41da-8a01-2f8b157e3540@nvidia.com>
Date: Mon, 8 Sep 2025 15:26:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/hws: fix ESP header match in strict mode
To: Maayan Kashani <mkashani@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Cc: Matan Azrad <matan@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
 <9769c8e7-3259-43c5-812e-c61fe3e3f1ca@nvidia.com>
 <PH7PR12MB70187E047E4CEB99A96FBB2DB20CA@PH7PR12MB7018.namprd12.prod.outlook.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <PH7PR12MB70187E047E4CEB99A96FBB2DB20CA@PH7PR12MB7018.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0412.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::16) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: e85b6182-5d5d-4547-06bf-08ddeed2f973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE8ydXlXdTkwZHc2Q3Y3WEg3c3dhTGRuZDhNY09PaE5scUpiVUdkVVBuQno4?=
 =?utf-8?B?UGtEa1d1MkRqMkxTZUhWcENFL3lQdzU2elk0eUdoN085OGtMZGJjR1cxZHJr?=
 =?utf-8?B?NkhZUERZRFNKaVhIK3g4cGZZdDZOUm1QMnVEcU81ZUpnWStXcGQzVnJXM1g3?=
 =?utf-8?B?WmhEYWxoMjI2VWx0NkdkTU9mR0lBSUZTTjlXRlJFK2tLWXNzNkEyVGRGSEtJ?=
 =?utf-8?B?Zm03ekltMXIzVVRIaVRVekZyNE9lMkVtYXJjMEd3aTE1OGpNRHd0cTR1NDQ2?=
 =?utf-8?B?MVRBMU1FK0t5ZUtxRDg4bXZPRlNOQ3NEKzdzQkZlMzRUbXRwdTVtN3VCNHFx?=
 =?utf-8?B?R2ErSkhuc3lBR2hlZ1dUMzVsOU91TnJiK3FrWkw2S09SeEF0M05uZzJkWW8v?=
 =?utf-8?B?RVhXK1JHbEhDWFhITTBmZnFqUCtjd0NoQk9qOWhpV1IzL3hsWVY4OUVhMitD?=
 =?utf-8?B?bENOTFN6NEhYQjF1RFp2QnBTWnlHQVV3eHdKK2l6bTJ0TEhUMnJJWHlXb0RP?=
 =?utf-8?B?clZ1UW52YmpscU8zK2xtN0taVEJxeXgxcEZud2o2dysrMzJDZVZ3VHU0N0Jv?=
 =?utf-8?B?QWFFcnpBcEFlbEptSU8vUUVsMDJEZm9BandwNVB3alBhdjJ5eDBLK2FqUjVn?=
 =?utf-8?B?WmgxUDNibStiaktWV25YOU1iU2Z6S1ZmV3FkamsvTXlobFcrcHlGa2NBcm1k?=
 =?utf-8?B?ZmR5RHlENEROeXNOREZMdUp5OWp5VVlEdTQ0TmkvbTRjWHI0bHhJVnZNQXo4?=
 =?utf-8?B?QlcwZ1BxV2dVNno1MWlUWGhRbDJZeUFNWWIraXBtTitQdlY0SmdFMyszVDM4?=
 =?utf-8?B?alJyRXV1c0paRnhwWENpOW5CVVZHK2VVNnRNaFRPMS85cml2L043RU1pMEVn?=
 =?utf-8?B?bmYvc3NBTnU5ZnNXV3FzR1J4Z3ViL01PRjJHM3JOR01HYkU0OUJHNlFQaGc1?=
 =?utf-8?B?dkxROWJPb3ZxVGZ2ZVhVWWs0Mm9XT25UaFVXa1ExN2Z1THB4KzhoM3ZpYzJp?=
 =?utf-8?B?T0RPN2s2eUtoU1Jva0pnelZXbnJPN0UyZktzV3NSYzNBeGNRMmx1WFZ1VEhQ?=
 =?utf-8?B?NzZIZUt3MlRCU0ppemMxZ2EyejhValhCUkNSY0YrRWZibUZuUU9lMVhsdFhq?=
 =?utf-8?B?YnJoWXowaytvcWdlTVlGZFBDTHV6RUFCeUU5OHU4Q0VIVnFSQ1NMMDYvYUlF?=
 =?utf-8?B?azQ2Wng5amg4N1BIOTFBTGY3bGpVTU5mYTNnYS9GQ1kvMnJzaEQ1Z0x4bFVW?=
 =?utf-8?B?dmdGSEhicWRJNjAwcXlTUmt1SGtTQXltWkF0RUZvZTlaV2M2VlJFZkpzYU9y?=
 =?utf-8?B?VUV1V1RlQjJldjhtcGFqWDFIUW5xb2VNYlVvbWV1Z0xZVWVwbEw5a2NsUHhW?=
 =?utf-8?B?RE9LYm00d0N5S2xjYU8zd096Y1FLdVFMVE1RNHpGTXhDdjJ5YjZsbVZRUUhr?=
 =?utf-8?B?Vjhpak1VWCtKb1dPOUdZSkJuZkJRNUg5RHZsVmoyNzNNR3laNVZiMktZU1Vr?=
 =?utf-8?B?R2JMMk16bmd6bHdNNUljdld5K0IvWUJ6L252WkNqMm5PeWV1ZlA1aEFGbWFO?=
 =?utf-8?B?UHNXMm5sRkxsWWdHcnhmeEV3WXdRamZuOEkyQlpVNTNObng3NnhMV3VvR29s?=
 =?utf-8?B?NmR6NUJqc0dhM2RLRmcxMkFtNWx4b2JOU3BUWEY4aWRIdTBKQ1RXY3Uvejcw?=
 =?utf-8?B?OVA0SmE0c1JJUCtYUkpoQXY0YTlGaFhSS3lsVWg2NjVoMmVlS0gxMnl6cEVw?=
 =?utf-8?B?TEtGRkVuQUhUdm54cjJiaVJVUm8wT21qVVNXVXRnRWNiV2RRVjhqV2tqRTBy?=
 =?utf-8?B?ZVVway9PaG80dURra2I3bUF2aEpSbzl3MU5mbW1kNHQzTm1UcGo1L0hXeEYz?=
 =?utf-8?B?aWNnWUVqWkF6WlcwV3UrSndlM3JCMzJXMGlKZ0lUZGxpaE5wT1N3c0lnZjRj?=
 =?utf-8?Q?6ICvV88B2Z8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZGaTVTRHpNbGE4cHFaTzNHaWlqcHY1RGF2b1NZMklmMCs2NUI5UzFpNC9T?=
 =?utf-8?B?aUpZcDFUald0REV0bmR2cFd5N2N6Z1NrZFYyeHB3WHIxTkVCbWJCdHBMUnUx?=
 =?utf-8?B?bE50RElrcW8vK2pLOTEwL2ZDdGFnRnFMVk5CbmlZVEJuUWFMTGhkNXBJZnY0?=
 =?utf-8?B?c0QveWdwVTdZVjgwa2tjdkt6QnB1aFlIaU5qMy9UMGJ2SysvYnJJUGNldjVw?=
 =?utf-8?B?UENUbTduQmtwTHVmRWNjUTZvYjkrOUYzdnBmMlJlbGpQWjBxRXVCM0xIY0pt?=
 =?utf-8?B?K1JNd09TNDZyVkZOa0w4ZVlUSVVHMlNkUUptcmRKTEUybFZtM3N5WUR6RjNN?=
 =?utf-8?B?bkdwZzRqZ1dUOEYybUV2WERsYjN3bE0wZjhieC9HZjlqdjc1MHI5SmhITm42?=
 =?utf-8?B?UXArQjV3K1A0R2pZM1BrMXdvMU5sY0Q3cURTeHlxM0xvY1p2MDJOQmZMSW50?=
 =?utf-8?B?dllWMURBc2JEWks3d1FreHZLUnZYeS9GWFg2M1ZqQjZCUnpWWDhKNU1YYkF1?=
 =?utf-8?B?QllucGg3Nm5SNE44enNrWk5SbDFuMGdRcjRob3lzM2NPcG1zRWE5cUErWGdY?=
 =?utf-8?B?Ulk4Z0hpeEZXZHFwUFdKSTBTK2ZKcnAvTmxjT1JXd2Jhc0EzQlZSTjBIWldS?=
 =?utf-8?B?T0phTjZlamhJbmlBMnZVSUZNWlZpT0M1eUdFYlh5SDYyL3poTXlLdVhpcEsr?=
 =?utf-8?B?MGFPbHAvemJnSW9rSGtGVnd0WUFBS0xCbzdLVXhtZXREdnVjNEoyWi9sTmth?=
 =?utf-8?B?TktZK0gyNGdqcFJZMGR0bkg1aStISWRzaVNRQzNJWEVDVnZHcmVXTGwzQTVh?=
 =?utf-8?B?RU1ESjBDUzJ4Q1NsS2R3dEozS2lhM2FTdlJCZlMwTEhjYkcwM3RaaVBxSDNk?=
 =?utf-8?B?RUd4dFpGaVNEelYvT0o1eHpwc2VzR1NxWTNsUUhrT01Xbzk3WjR1SVY4eUg3?=
 =?utf-8?B?TGFXZVNEM2tNUFpjeGRxeUFoeFVCMmhObEFLMmJmc1JuUitPL1U4dWxPK2Y1?=
 =?utf-8?B?QVpVY0pVTEdEcDVyNjlQbDI4NlhleU1FSmNXU3JXcW9ad3JLZ2U2STF5RmU5?=
 =?utf-8?B?R1haNTNNMVU5ek40NUV2c3VTUXR2OGRWQUY2d3dxNGpiTVJTOFNOc0d0K2RG?=
 =?utf-8?B?QnlGZnNTanBJL0lSQTBuSzFkZFFLNm5FVmU0dDRLR29uM0pZOGVBdUIrelN2?=
 =?utf-8?B?a3lwNWk2VHZVK3hqbHFNZ0xyYlpsb3d5VzNaNTRpVXFDMzJ6M0hYN0RsTko1?=
 =?utf-8?B?MXNsaGVlbXUvSjNuY1YyZDRlRTFoQmVrdlh4V2hMMVBTVjVWK2w0ZnB2azRt?=
 =?utf-8?B?dUZESWFQZW9XKzBSSnJTUW9kUnBnbjVXQXQvR2cwN2pZMzJGS29xWEtEQVRX?=
 =?utf-8?B?Z3UzdFVuelFxaEYzaGhtRzBnQmdjWFJiRkk1SjZ3blNyTGw4NTlrY3QwOGZ6?=
 =?utf-8?B?VXovNTBPc0d4b3JyNTlNOE5MUXBUdzFWTnRTdDhVREtlMnVoekprdkx4cmtx?=
 =?utf-8?B?alovSjRKSEdSMUVuNVVIM1AvVDZRZjFQY1FyMlQ5RUs1SXdEWnNRVW1vNlNr?=
 =?utf-8?B?RzRUMkhEUnB5R3Y5VGZ3NVZ6dlJER3NQZU9pZnJBU21JeHVhUnhMMjBMTThk?=
 =?utf-8?B?UkxKN2txTWYvZkQ3WWh1WmpuS2hZUmNibFM2eXNnTFc0ZmJPcGc0Ujk1dkRU?=
 =?utf-8?B?NlQrOXdkRk84bWRieGNmYjE2QVFMMWYxRjhaOWVSdmhIcitvOC9BY29EL01o?=
 =?utf-8?B?dUowT2RiWnVWMGpaZzZ4Zk9WV0VtZEJHOEUzRVhtbm9LR2NJQlVWYko5cjNu?=
 =?utf-8?B?bGpaK0NyUDJPTFcyQUp1emtWSjJyRjYzZi85OTV5dTJ6dGZJSmtHanZrckN3?=
 =?utf-8?B?cVVBejZQT1R5YjlpZUZRTm5TV3N6SXB6NHV3N1ZmSys0WnZQY3RLMmUxZ05Q?=
 =?utf-8?B?cFpTT2JoMHVnM0tuT0I4VkU3VjhnNGJvT0dJV252Wk9vVlFDdEd6QkFlcW9h?=
 =?utf-8?B?QWNWRHQ4RTBjR3Q5N2hBK3huWk9pY0RhK2J2ek5hQW81RncrdVo3Ry9NcmdS?=
 =?utf-8?B?cFJyYU4yYXE3TGZlMW9vdzhCektQQjFVMWxRWDQxSlVqUnRhMy9UMi9LcEp0?=
 =?utf-8?Q?jHu9ZjgSOOl809r2gfg5qTYRM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85b6182-5d5d-4547-06bf-08ddeed2f973
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:26:45.5013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPnax3x7cRluQqhcu1Yu8ctbYUWcStXn2mP1ZHdK9VMnOgprc7+8aJl6OmLJYioevKHkg2O41PZbHxol2FWJhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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


On 08/09/2025 3:12 PM, Maayan Kashani wrote:
> Please drop this patch,
> the merge was incorrect and the code is incorrect.
there isn't anything wrong in the merge, the patch was merged as is.
I'll drop this version of this patch and you can send a V2 for it.

Kindest regards
Raslan Darawsheh

