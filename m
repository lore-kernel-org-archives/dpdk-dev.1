Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08795C624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3259140269;
	Mon, 31 Aug 2026 17:41:50 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by mails.dpdk.org (Postfix) with ESMTP id 47D144025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 17:41:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olnoeYGyvYGWLrsTdU3ZMpBs7X+q7h+QeozJLcuXI7jieX/LftAxYa1OzI1tyZiM0XfZaQnU01rN2kuvG+ZYTv+yTAoEQYDU6fZhSb4mdQ9Qhl2ACF8HfdusIZWCdeQ9xXUq6Q8YFzcepg81pFb47LqLJDLCXUM7COlWzxdkTxoCJ0fh0dw6kQRT4Ht0GIiG0pWeSagbqcQXBCUSQY7WdutE1/3DXkp1xKqKe+l/tUA4G4qfSi6qq+5+KMZI4HPK3a85a+IdqGzsVnrorWJUoS9mAp+lMES30CeXMIpD7Z+zh5v/1hSy4v9HpGPtyStIjth1wC3l/hBaHpaEYkQAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hff6QCnUZ8jqGLHsYgUyCGtHm3tgaZsoUQFCuT2LYk=;
 b=vvoHsxYh+nLwxiioCU34TCYIDkAnwJ5nydga1ZEMOoZfDQZFHydRpPWbEACGzEI6+ceWiArZEVFDiIdipPiXzqif5XDfRue/TGwsg2Cv9TT+L1gG1vzAnoEmPlMY3QeHMQFNHm8M92g6iP8jltqdqMVyDk8FmS/wP44rVuc7lP6nVH5Au26Nb6t3HceYzRFwN3lHiiyqxXS1TQR+B3GdsAMqvqkNnShhyEZkDuhuPFOAHdukWtaAhZ/xKrXI9I2mazMd6/49Df6ahbQvSaKZAcsQUGZOFs6DTkHJ2gnWADSeg3kzC0UoLZ+zV8e/EAjU3Hu7J7yhdDOzMhKxfp2tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hff6QCnUZ8jqGLHsYgUyCGtHm3tgaZsoUQFCuT2LYk=;
 b=QKeqsr+0zZook51AZFnvxFCJaMZIIOlDumL+Icb+eIXf4jjvSg0nWKbYrfyH1nq29I3l90JwjtQNAqNZDxW6pxvaUEk/4AtjkeM4RH7/0odV1JPUlMkDzWA8VbssEUQM9e+oDGF4EL9jzUbxbLMrpG4Mvm5OMt4MGOvyl2ihhDZy4kg7aL1Bu/2zPK4qwlJXdRz68opgwreVBQHdpRDyk6j+diANWGHXE0i3FJyG8mfyJRhFnLpyYWhl5CJxD+t92Ww8EDezqN/gX6stByvB9W4MDr9pj9TdYumDKtuppyoh9eVV9sSQw+QRW6KNhb6rjToAeQVUHApCa3pLpYSiRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:41:34 +0000
Received: from PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8]) by PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:41:34 +0000
Message-ID: <70a4ac8a-844b-4b7a-9f00-017ee88b6c3c@nvidia.com>
Date: Mon, 31 Aug 2026 18:41:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/mlx5: document modify field limitation on group 0
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20260730154440.216881-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260730154440.216881-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To PH8PR12MB6747.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6747:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: a49d7004-ae17-4078-4987-08df077655c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 79+WossAM5FYrH0Cfia0IteMv+JCMwsSNuJ7km/jAUjz1nqj+6tWQIQINcZpgciTtBD3+nE71ui5S6jtHEnalW21/2Q9G0RJiRkGKOcf6xVAmmYKAghHZY8ZRq1E5GGiCOEVAkrYmFvFOQpHYPCvi7+p3gCg+Dxe+Llsfulnx5PVm2VTn9FwsKkiSOcEpK+WYjaHC/dLAsT0f63SHZ5WpJAwmlEV/LNwTO12owj5RoFY+gvASIrhosHQIbSNUxu7Q1VuWgK3FtEt1YuDApcjWsE2DntBmsxBckOwgAcSkTmfH9zdAokS00IfEUfEX1N9OzAooJDhp/YBDOC2IXWl3Gay0l/h9mCXUfEYKWtnhRAbRpXi0gwzoDbRdmFYKihSY7z+Hb8mMzZWf5SN1J+LiV3MkxaRe9uY3OvNkPPnfM5iw4RNVtKga2j0wXv9fvw022IDvM0HNNenulyfaV7991wkSJo6W497QMWSzCsp95AgZ/93I2D5vhh8XPuDLUY8hVW6qenngnTInz1COURXFzwAi+/L0N6L4YaY4jygmQD/6h6mX+N441vIBqj3Rd1i8i3U+5hEIVKSGCBPeJ26QphgDqnl7LYMQxLwi8EjbH2usWJrguUGaEQvDLZMAA4JxBFfsEVDgFhp/UJXGaYvtAm/v88Ifs7evIkeqVQFoXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6747.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdJNUUva3R0UHdaU1BpWU9TaVVsR0FJVUZ0NlQwTDNRVGl2b0wxanhJK1Z0?=
 =?utf-8?B?bDNuR0FiVWNpeThDQjdOeVJyankydUdXaWFVQ0NXUzNFbHNhQkRJYmU3VWdu?=
 =?utf-8?B?MVhPUUNrZnhMaVdLRGd0c0Uwc3BKQnd5WGp3RUh2T0FVcm5SWnhHVW41bWlH?=
 =?utf-8?B?QWNSNmJySDF2MXZ2MU11V2VZUnIxNzU1VFJlTHV3NjZsNDBiUXphaEZjc2dn?=
 =?utf-8?B?amZpR2R6QzZXc1ord3J1VkJPcmIxT2ZObXVUN2hMN21MQlRKeTFIbS9VbURh?=
 =?utf-8?B?VU15cVBrck11a1BDaVFpK21OdSszeklCNlJJQ29yUXJ3QnFPMlNOOG1KSjBY?=
 =?utf-8?B?YVI4SDRHVU8vVDNwSGpjMEVteUVUa1FiMWF2R2hVU1doRGxqWEhaSFdVOVZP?=
 =?utf-8?B?REI1WUl4SGVTVWF5Rk9hOHRuSFRKd2xyeWExTDlRM1Z2T0FnY29pKzljcjJH?=
 =?utf-8?B?S2tkTVJKQ0YxWkhQNG1xaE9CNlFRSnRncS85TXdGTDFQckpUeGVLRXVJbEs1?=
 =?utf-8?B?QXpNYzNxdjF3VUVUWGxuMGhlQ2dmSE50UTR1VGhadHZHSkFKcEhLMFlscTMy?=
 =?utf-8?B?L2ZFTStDQ0xpNFkzQU82R01mYkxiS3RJQnZYL3p4Znp3RWFYTmhkbndlMHdn?=
 =?utf-8?B?UGhaa014RTVBZnJlWGcza1R4UkY0ZUlxcEYvZk9jT0hPZ3JGNXJFSjRXV3hu?=
 =?utf-8?B?TEZlREI5UFRJVmFPcC8vNElNZWd2Q1lGYWVPU2VFNU51TjRGeElZR1puNnBO?=
 =?utf-8?B?Y1kyVGpDUEx0RElad0Q1eTFVSk9XTlJoT3RWbFZCNHJIVEVmM3hhR1dtdDJz?=
 =?utf-8?B?bDB1M1hJMjhyNWdNaVVSWk5kVHBGOExkdGRjckZoYWtqaXYwM2ZnVE53OTN1?=
 =?utf-8?B?aFZqVFV6WXdoNzNRbUt0SDlHS2RZMzJiczg0TmdlRlZBOG5wR21SVU5lcy9I?=
 =?utf-8?B?QWdnK3Jwa0RjYnJRVzBzOUdlTWhxM1NBZU0rKzVnK2xQcHY2alNYMm1jLzRO?=
 =?utf-8?B?MjV4aUhpdzJkdXJmM0xOZklBUmFQU0NTV2hXeDY3MkhNbGhMYThDdksrdVdP?=
 =?utf-8?B?L2tpbWZaL0dFQ1JoOXAzZEd0VEpXM0RNdWplcGNRbHFJam1GTTBhb3UwRk00?=
 =?utf-8?B?Mk90RXNnZmVzZ2laT09KVnFJOEdxa2JvOHowQUlWdjhvUWo5MXp1UFM2T3dW?=
 =?utf-8?B?WUF5d0NkTGo1QUFZL2tQWDd3Tjh2VHVScjRZdUI1bFFvRHhMdmlES0J2U056?=
 =?utf-8?B?Nk9yQjExRnc4N1VQSXErOHV2MmlZeDVyaFN4WlhPcUQ0Qy9mU0ZMTVFVSlVW?=
 =?utf-8?B?dVRzYzV6Yk51ZXRFSitEWEtsUnUzcDBkUCtqODVaNXZkem45Sy9aTzkzS1My?=
 =?utf-8?B?TkppWGFnSlY0T3c0NC9TWTVmRjhvaWRkWmlnV3NvcjlVKytjaDMyTG9vMmJk?=
 =?utf-8?B?Qml3bmFPRmFXT205YXBXbFNJbWMwOEd2eU5yV1g2S1JaS1lsUGVaTnhON29K?=
 =?utf-8?B?TEM2N050azgyQm41L0hZM0NxdmZlUkpjNDRRR1ZhZUlSaVdDQVRnT0dtYUQw?=
 =?utf-8?B?VU1mNVRpUnFPZURDby9wT3p1K1JuT0lqSzNhOFBxMFcwQUtaNHJlVVBSQWZ4?=
 =?utf-8?B?MElwUDZZS3NCN2ZhTUIzZU9xeVJ6MlJlV3JoWTlhRE13TnB2di83dlM2VjFk?=
 =?utf-8?B?TUVTaUNiRnk4OERFcWRJNnExeTNzSEwxdGJnVHVjRDZKN3lHbDQrbVltbzFC?=
 =?utf-8?B?V01SMllrRzhxWFl2U1BHNkd3SlA5MkQyMEptRTJ0MnYyTlJvSjV3d1BRalVD?=
 =?utf-8?B?SEVReVByMTRiMjg5bFR4QXVQSWNqTk1VZXoyTlB1RmFDYjF4Q1dqcFV6bXVy?=
 =?utf-8?B?eXkxdnEzU2FJNnUyV0oyNUhVN3VYYTE0ckhKa2FMUmRUU05rWmovYXg0STNE?=
 =?utf-8?B?bWpWN2duWTdqQmtBZE1XQk8xOEdMb3UvczViN251a1FuVzlld0dueVpNMmh3?=
 =?utf-8?B?eXllTE1mS2QvT2dyUkxXK2lDSWFuR3VFckJCQXVwU2pxQ0ZOYlU3UnBMeFkz?=
 =?utf-8?B?MG9GTHpiRWF6M1RFd1E0R28wZzN0RVpZYnhNVjFtZFlPb25jN29MbEliV25x?=
 =?utf-8?B?S21MNnRFTmJWaGpDU3VTa25oTjlhdHBZQ2xHTUlpeTlWQzh6L09Zd1VTZHhm?=
 =?utf-8?B?Z0I0bllYdDBjU2lmY2FuQTFlaDJPVVdUZ05ZU1VIK2t4alllMHpTZnFMaDBF?=
 =?utf-8?B?ZXhkM1M0cGRST3JDQnR0TXN0cWRxdzY1bzNYYjBQYlN4dGVxSGFxdFlNYURT?=
 =?utf-8?Q?1cwEQKUyujXOELU6vG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49d7004-ae17-4078-4987-08df077655c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:41:33.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPFbhgp3M+Z9r1ThD5vN/ON2PfmNFY6iwFKUFTQsWyUXKHgQEyjE6g2FuzAnaC2nTbrakxZCnE579lVTQntbhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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


On 30/07/2026 6:44 PM, Maayan Kashani wrote:
> Document that on the root table, two sequential MODIFY_FIELD actions
> where the second uses a field modified by the first as src are not
> supported: the second action is handled before the first change is
> applied. Only immediate src types (VALUE/POINTER) are allowed on
> group 0 for sync HWS non-template and DV flows.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

