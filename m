Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36CC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 14:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94384064C;
	Thu, 22 May 2025 16:31:42 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by mails.dpdk.org (Postfix) with ESMTP id 7EFC9402E5;
 Thu, 22 May 2025 16:31:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAhSBw+VLMy/5rO9JP/59jp1VZYKSMnGNhRn3ccS69XVPjIr4xGBlLbDl4ONxK7dcMYrxfo7lmGYoysNDqWn+6qwm6nlSYNwZeskr0frH4kZepGFQWZG/qV0963sUdI0SElqThMdbzCp2DI4h3tx8d4lnRcM4Ine47h97tNAdJboGlaWFhn4PXfRfUfNuWjm0E+JpFAk+eEe3X0Y1/d4yl1acHiYiRS0eyUaKvhe6JzxurzyR5ykSr9/xzvW7yt/7JXxsVXW3xjVqt33XGge4B0456n3LKHcNzxZzUi6ovRlIb16Awuu0ajlAOa6TMgnCFC0w8CAU1s0CPrh0xE67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFqqDn7x3qmCgtBWAyJpx/y2SBLPC/c5JdT5hrjvxYs=;
 b=Cu8+ooah8gFCY9guSyLzhlLW0keKBKG2SYIRNzAF0fUovuLd5nhfkX3GMGDFfiayBrDBWdz0C5c9GajaumKKn2KRq6D0JF695CbFxSmbvLz3V+7tF4Ez9J/FP3IzKZ9toXgW4RwH7re23YkkJo2r9u89Y/qsUpqH/+USsRwc1/hvAZI+YlUiRYeCSP6yBMiqZ/HYM47ib4dDA+yjPOsgr3n7hKAK8SGePDiIMsFlgHpy9esiD7SZHBxpS7FCS8JvuRkYyObLCRQpw7kfo0nHvpZG59E6rU1Rz2XHzKNO3CBWIOV/lP6bf2muC6jl3RFw/cEaGJedO6pmDIIVW5lmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFqqDn7x3qmCgtBWAyJpx/y2SBLPC/c5JdT5hrjvxYs=;
 b=eJG4tb05ifqMR5dNGBi91Cg0QwGE8uxcLE/Gf53NflJG7VQmhB216ri+6fbF+7Y2eRlOlVg9wrbIWCF3/Wzj24xO5PMS4ChcaStoUFlYCNX3NNyvbNBFkjlXJxRpPdWW8XIzZWenL6+LM8q2q9BrGK2aW1s4Zr9Bt79GUMwJYnp0IJXE54ZCOImx7X4dG0svvgLAkQvQx/aLVMmwDy29XaVWhZNHYrf2xQZCXl+TIDBhyegc1DDaZVZZP9P/AkhSUHXiS3kNFWppGb+sQlgS8ac0HIfQ915ZZEF/DGItXuKTmy6kw08KaPT+tpYdpyo7ENCNmNUXq3i9Xoo9J96vGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 14:31:38 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 14:31:37 +0000
Message-ID: <d7b61f75-7ec9-4893-9683-49973c5b7131@nvidia.com>
Date: Thu, 22 May 2025 17:31:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Addressing git.dpdk.org downtime
From: Ali Alnubani <alialnu@nvidia.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "ci@dpdk.org" <ci@dpdk.org>
Cc: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
References: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: fe895954-7ce1-4fac-fe4a-08dd993d5c2c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZW5JRmkzYlZYZWlrUG9HOFB2NnBpSS9EeG4zaytaVTM2cldUR21BWW5jMTBv?=
 =?utf-8?B?THp4WG4vL2tWdjVHK3JISFljY1FNM1BtWEYrZmt6RzE3ZUM2ZWdpa01rNTFZ?=
 =?utf-8?B?MUNla2hFTmJzWTVPTHBDL2xmSHJqT2ExZmJFaGFLNjRrUzA2dVhiZ0ViOE55?=
 =?utf-8?B?alErTmJWdmtUK3JZa2l0WUVWZGFSMVlxbitFUzErUTNzVVo2SUFCNzlWVlVq?=
 =?utf-8?B?RGY0dnR5ZkZmeEUvVFJ1akhTbjBralZ0YUZIZkw5QUc5ZUV2ckpEUE43bi94?=
 =?utf-8?B?d1dVYmRnZDZhZlROTkdMREZCd2JNdWhXV0VtaVZkY21rOVJvUThsaWRJc20z?=
 =?utf-8?B?TmdYcWk1cWt0UENqOXVCeU52RTZkL0dsQ3dUS1M2a2VHakFmZ0t3a0Z2SVNU?=
 =?utf-8?B?alU3ZUh6dCtPVmM2djRjVlNRWnY1dk9aZXFBN3JCTU1PMVVTTWl2NHArZjlP?=
 =?utf-8?B?bTJEWEY2YnpQUHJiR1BSbVhnUEJVS29hc3FEODh3Qi85VU0yK0xWR3g3VElY?=
 =?utf-8?B?a1o0eXdWTFVjRkZZRndZUjRqSWpuOG02enkzN2pGYUVVOTJoeHREeFF3cHcr?=
 =?utf-8?B?SXltZjZrbjVTVDEwY2p5b3hMQ2pkellmWGE5eXB3MGVKS3BCSjFhSWxCbU1C?=
 =?utf-8?B?bDIxTzdBL3BqN0hwZmxlQXR2TlQzSnF6Wkt5MXM3YWlXSkpNNjVOdW40NU1m?=
 =?utf-8?B?MytnSHZ0U3Zoa2NXUlgyTjhnK0lxMUVZZ1ErcEpEUlVrRjR1NzRwUFV6dTFK?=
 =?utf-8?B?cU56ejd0MCtuUXBXaXMwcWR5SFVxY3hQcXZnMDVKRVBNczRwcVRpV0JZbTF5?=
 =?utf-8?B?OTY3cDU2cExqOHJPVVI0WHJMdHZaUXJpS1Y4WE9ML1lNd1ZzeUthT3V4cDV4?=
 =?utf-8?B?aWpjNE9NYzNHekRwTTFmcm1oT3hlZkpybW5JcWVKWCtxcmFycDFiOHRJblEw?=
 =?utf-8?B?V0krSWRYcXp1WnlVUTE2THRtK1BJVTVkdEFzUGZKN2o1dVRObEZsY1Jrci9I?=
 =?utf-8?B?amliVmljQnMzQi9OWDV6ZlpwNmlqTXBrVDdtVlJYekpWa2lVVi9mdmJjbEdw?=
 =?utf-8?B?V1dlTDh6bDV1WDU4RWU5dUh5ZS9oVGVpbXhUNzYyZ0JxeGtHWXdJa0xLcEd2?=
 =?utf-8?B?eUQyYWxPdW44SUxBNTd3c2p2TDlkQ2tzQlZmNTA3cW9JbjlBVm41cGFkTGdk?=
 =?utf-8?B?YUN2ZGhzZGZUTHp6OHNzNXJyNnZKVGxBdWluZFBRM3VoZDRNQmJSaHBXR2FV?=
 =?utf-8?B?clF5UkhsT3FrT05tYlhaa3IyaFZNM3ZSOWFQdDhib0lNUEs1elJJUG1BTjlh?=
 =?utf-8?B?TTlvNUwyeU1UV0VsbUZaT1JIaHFwWUlxM1BVbkpEOGJkVm04WDBDR2tMUHVx?=
 =?utf-8?B?NE5qSjc5Ryt5WXY1SWd5cmZFN2Z1ZU9EU1o2V3ZGcUVLOCs0RWNBWC9oMDE1?=
 =?utf-8?B?azl4NmQrV3VMMVE2Ly9La1BMd1ovbDZDVEttQjFuT0Z1VHFYdmxpWkJjVy95?=
 =?utf-8?B?dEJpQ1BKanRIR0xyaXJ4QXd4Yy9mb1RuYjV6VlNJNUFLcjhLMHZ0c3pmcXc1?=
 =?utf-8?B?ZXlvYVZHemZZRjFac01HMXRkYXNyb2l5Zm1ZZFY1bzJjZXZsQTNPSlBJR0Vl?=
 =?utf-8?B?RGNzb25uTUZkMWY1VVlkcFNVN0s0UnZNbi9lWkNOWk1yYTc4OHcvRkptWHdC?=
 =?utf-8?B?d0E3amUyVkpDV2FLalp4Ykx0R29aZnpwRS80UGowZ3Q1U1BDVWtKb2lzYmd1?=
 =?utf-8?B?Qm1UbkR5MXM4a2hnRmtZbGxoM0llZWlVcmdzVEUxR29nUEk1K1Vnbklqbys4?=
 =?utf-8?B?MmlWZEtzZm9CTThUNFZ2S2xUWFZiWS90a3lZN2ZYb0NZeXRkTklLQmN1ekY0?=
 =?utf-8?B?ZW9qU1N6d016WFhqRlRlQmZlU0tNSGdLMG9JTExnRCtRL3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9ndU0vd2JtcGxKQ1Fac0JodENFZ3JNajRDM21zeFhsMFBiT2dmUUd1cVJH?=
 =?utf-8?B?T2VvOW9HR3o3ZmpIaktyQmliSlpYYnc3bGRBZjd5QWZ4b1NZdmFuQzNEdGVp?=
 =?utf-8?B?eWw4TXJwL2p4K3RKQVFvTk5QVnpFNW5rajlVU1NYMVFjaHFRNEF6NnNoWGlV?=
 =?utf-8?B?Mkw3NEh3Zm9xd0lMU0o0aldLRVZVMkFYU1RHSHpRbjMxM1NtOTU1SElsK3Bh?=
 =?utf-8?B?WHZVQjZUVllGZFBtc3dBL25WTTlsZUlBUDZDQ21SSEpSMFdWNzhIV1ZmRHBD?=
 =?utf-8?B?RjRPSzJGc0NJK0l1emY2dGFpZFF1bjg1YmcxZTFFS1plSzNpL2Z4amZTcEpn?=
 =?utf-8?B?aHBhNHhpQnVSWnhwUCt3Yk1LWlkyZkRkWW13VnMwa3BpWndIMVJvaVQ4Qjg5?=
 =?utf-8?B?SkptNkplRldhQzBiUkNFZmZxdDZOelpxQVQrZ3h1cVRQbXV4S3NhTE9LdWFP?=
 =?utf-8?B?bFpRcUs3a0liVEg0cFc2VXZDV1lyeThqSWVWM2pXaGc3TDRMV21wZzd3Ryt0?=
 =?utf-8?B?RTZsZWpvWU9hVC9sTjNyNjFBT2wrT0hUSjdJWEZHemsvb1lHZlkvNHBMTmt6?=
 =?utf-8?B?Y1hlakpjNE5Ea0VWZ3g3Y0I5TVJuNGNLSEszeE0vUnM4dnM5VDBWRWJITitB?=
 =?utf-8?B?MUJkbm1kdXhGc2VSblBld1dadGdweEhjQmdzM3BMdlFveW5LeWFHMVZSZ1pE?=
 =?utf-8?B?YzRWanVxbDJZRVByRzZQWFUwakEvTmdLNVRLMXlXdjZSQkhUWHV5bUYrVUt4?=
 =?utf-8?B?c3hSbk5NUDBDekdnUDNraVo3SG0yd2hJVkVXUTlPQzlpZ1RHTlNVVFdJd0dQ?=
 =?utf-8?B?Q3VLekptSFpUbFFRdW5LYkttajRCaS9YUytqeVlOTWt4RGZ0UzRIVWw0UUpw?=
 =?utf-8?B?ekFNd21kbjZyS2pIRWpJU0lrV0dVMEZrTWtpbXlHNEFrOHhuZWUxYXE0STUw?=
 =?utf-8?B?T0ZUblN0VXhSNHNQdk95UE5weHJEdTdYbG1yeDV0NU1aQWRIZFYzd0ZhZHU5?=
 =?utf-8?B?S3VTekViNXJ6ZkFKMW9XaVRpcHgvclB1WG9WQ21XTDFGQVY0L2FHc1F2Tjla?=
 =?utf-8?B?eHNicW8vT1B5YkE2eUdOeUlIL3BwL3pOWmJXd0RBbjlkN3BYdVlKcGRKckNy?=
 =?utf-8?B?dVVKQm1nTUYxdnFhUU5NTkQyaXNlNURJT3FVM1pNS2ozamhvczlkaHMyQ01i?=
 =?utf-8?B?djhpR212Mi8wd1g0enVBanZ5ZVNybkN0a1JxSnZobEF2NkJOMWFFdnozYzdT?=
 =?utf-8?B?dFFhMm9yZ2ZXYnY0NTFnYzRtTVFMNXdwQlFERWY5QVh4cHZBdGx5aW5uNSto?=
 =?utf-8?B?US9XRktwdEgyZFJsVkgyMFk0MGVCeUh5Q2Fxa3pLNllJeW9LN29OTHQxeUFF?=
 =?utf-8?B?a3BGZkI3alpBbmYva05CWllNMC9mNTNKQVVTVTVYMTZWcDV4c2VYeEVKZXM2?=
 =?utf-8?B?SG9CUWZrNHQ1R21GRVVhYU5meWFvOHJ4aUdMUVk3elNjQ3Fpcm5qUzFGMmJq?=
 =?utf-8?B?a08rblkxdHZLSmt1a0VYT1daZER0SDNKNTQyWVdJbWFPWEhWbnljTUh3VEtJ?=
 =?utf-8?B?UWg2U1YxY292R1haMjYwTE1NYktXMmZtYlR6V2Z4K3VDZCtnT0dSWXFLaW5H?=
 =?utf-8?B?SlpEZ002NXBML3dkYXk0cC9GNVM2bG04VXpLWFJTYUEybjAxdXllOVNPNXVS?=
 =?utf-8?B?K3V5RTFKbTBFTVZLOUpWWldJbWhQV01iQWcvSGo3US93dkRjTkwyUFVaVGtC?=
 =?utf-8?B?UFkrVk8zaWZqV2JpWUVnRVRpemFyKzRvRmNjV09hZTI0MnFBRkJTN01uSy80?=
 =?utf-8?B?WHhvNlV0dmlDZndaNTVaOEt4MHNqWlZScE9nRnJ0K3A0L2xzOTk5ZGpYcHRm?=
 =?utf-8?B?MWUydkFIcVBHZUp2eUhSU2VLQW5SK0pZcmhVUkRpK05rWjdlbVN3bDljLzZa?=
 =?utf-8?B?MG44WEdOV05vbXZFYWM3dEtTSkVGeUVEcXlXSU1NU0pPOUpMZWRNTWRIWnlO?=
 =?utf-8?B?YkV3QzFIWnQyYTkyVFltTk1QeXVOSHkwUmFmWFQvTnV3Zkd5MUxqbzBndXVs?=
 =?utf-8?B?cVdCWXZoU29jT0tPNmt5cjhWOXZlSjNwL25CbTQya0hvUEZTTWtWNm5SQUNJ?=
 =?utf-8?Q?s/hhEU3NWF88olz8Bw0JtyiYa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe895954-7ce1-4fac-fe4a-08dd993d5c2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 14:31:37.8816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vGh/DAiHxqh8107E+kzsztt6QgVEFe2aGbsZLpvc47waeQR3SHzCmKmsIAlqb6Sq1A7FfGWuDPqbZv6tJ5Ofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

On 5/22/25 11:36 AM, Ali Alnubani wrote:

> Hello everyone,
>
> We’re aware that https://git.dpdk.org has been experiencing availability
> issues lately, largely due to abusive bots and crawlers overloading the servers and ignoring traditional controls like robots.txt.
>
> To address this, we're preparing to deploy Anubis, a traffic-challenging tool, to help ensure reliable and continued access for the community, starting with our cgit instance. This approach has been adopted by several other open-source projects recently to reduce disruptive automated traffic.
>
> Please reach out if you have questions or encounter issues.
>
> See: https://github.com/TecharoHQ/anubis
>
> Thanks,
> Ali

The new service is now live on git.dpdk.org. Regular browsing and git 
operations should work as usual.
HTTP traffic is now forcefully redirected to HTTPS as part of this change.

Thanks for your understanding and support,

Regards,
Ali

