Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94056C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 06:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B9194026C;
	Tue, 13 May 2025 08:25:21 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by mails.dpdk.org (Postfix) with ESMTP id ED90B4025F;
 Tue, 13 May 2025 08:25:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPMF+AkhkOLJBlGbgB9IJec1U90txvef0cFmijEHXHfp3VzopdHDD7WQT45o544Nq/hbvYpN6spN+WuN03gj8m/pSP16auFeC6q8TI7DFDqzdnPZDpT6lL3E6pivSoha559BjaEhxIJ6NqSI41RS12J1sUHzgliV0pKydzULEoCDCyQyDHegxpX0i7JBCIeCya/JTrYwcbPWbLewuUlNBvKj/eYiIRuDiWBp7ZmRmODHlLACdhhxCuwSAJchbJeMDzvfu6/DIdGCZVlJpttjI+SZgDAHuRQNVewO15t/QMgQM39URJF04/VKmUM7V/aM0nnadK9OlQq3FvnWZ6Wyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbUH4/v/iKTVHznfvwjFrSe2yQK14G/askYfzACaqfs=;
 b=DgT12Nr6hJNPY9MfWBmuc8TUPi5jxQ7kqZd8Ms5cK90Gef5H7bHX6zZVs33Siw8UFAwbs9MY50XR8+cQmGEZzdgR59Ild0x+FiCPdX90FEXwmR/2JlHwSQHxPVCLaNkQmtQTIMcJpQdc/nC1HPJ/mXy5zaMrXN9LK3luVtlHOI6FnlYEL3mhMlNOvkLKrYfeT1BCSjSsQjnvZRFW2+G0mc2pQcnUdyNE8BQw4pE0dl2Dz0WCa6EA3X3bDZ/hICNlZ1hvHAM4nHvyKk2kdVBdTKxrVhblTrnQINZfFA3CEgbkWXlg5gt+z8ThGMtvto6eE2vQsnhud+X/F4l0wppYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbUH4/v/iKTVHznfvwjFrSe2yQK14G/askYfzACaqfs=;
 b=kRIWO78fiqQGTr9K4IMK3e7pdGcdizOEo+VSTrRTowZcqegPOHtKmBJ3V3CRQVAct04cLb6nk23aal2omaZ46MCwBdFkEBNZyK6ES6be7piXQOoZtbJLqfTsDD2efeOSUqwMnjdfZllpYSyPIqUXJuhOCWbInOdRa4Y9QqmE9N+gRbCo0JbX6F3ZiY5baCVfSAwU5JIcFD37sGWlsxCHe5pJtRnbJmpTsAy+mDVhp9EjSU4tp/lhZBSMBN/46vDKWrIYtOj+BpB+K0z0R9MyElMR7wjHKrIwBLjJfl5naMXKGTY1GFq9D/SndKroXWTjQIVfqQ7P7qGmS88kqjtuZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 06:25:16 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:25:16 +0000
Message-ID: <1b0e98e2-97c9-44fb-b734-1c9551b9a822@nvidia.com>
Date: Tue, 13 May 2025 09:25:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5: non template - fix validation for GENEVE
 options
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
References: <20250427112257.108544-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250427112257.108544-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4bfb62-6ed8-4f35-583a-08dd91e6ecd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THgvMDEvK3BSYkZVSEJweHM2Ykk4R3JhckVORHd6b0tlYXJGMjJMTzZuN1hq?=
 =?utf-8?B?Q0VJVko2WVRYeWk4UU91Z2tTdThLSXpVUlBhWWFFTDFQcWdOWHEyWENHMSs5?=
 =?utf-8?B?S2VzR0xaTmFVQjZXemlXTUdGcWdJY3FiRDNTNnZEMHJZd1RuNlVvNkNaZVdO?=
 =?utf-8?B?MERTNmg1YUtHUGpjYkFMdG1sZDFlb2NOZXhneXhiYnliczdHTFgyeHRHV3Bp?=
 =?utf-8?B?eHBJeWd2UmdvNmxDNldPZE1VMkVrQmwzZ1l6VkpWQlNGYnZ0eXZGaFRVSjdM?=
 =?utf-8?B?SlBrM1VQRU5xd3k0aFB3U1J5OWkvdHlNWnQrMlQrbURGcHJ1RThGNGQ2WkM4?=
 =?utf-8?B?ZFVseGhEUVN2NEhZODNGNFhsMEJFdWtiMElIWElhQXZTVnFSRGZuaEJUNXJs?=
 =?utf-8?B?ejlnTEpCZHFuNUVqeTN2RXY1aktMQW1zSi92RGxPLzVTQUFKWVAycENSallD?=
 =?utf-8?B?dGdyeVBGTjJGeCtobFZRUHlvZWpOaTZLL3h6d3VFNkhYQVBhYUtIZi9keFRh?=
 =?utf-8?B?aFRMNXByVFlQQnkzRnh1d2Z6L2NjZDkzc04vU3VGQWUwdmYrdEtjc0lkZFVQ?=
 =?utf-8?B?OXFQNU5FZW5ZR1JUSzFYUFFjc2V1K3NES2VlNEREdmpMNWZxSXE1WXFYRG9x?=
 =?utf-8?B?elhyRHUwODNjTWhibldTMm1MdDlPaTBkOXFiV2s0WTNDcVlWYWp1cU1qL0FH?=
 =?utf-8?B?dDkyVEF3QXhaZm90VzJja01ZckZGVngzd1BjclVPTURHRkpjR09nb2NPQXVE?=
 =?utf-8?B?RFp0SVNMeHk3a0VORmpMaVoxTGp4QWNlamJmeCtxUnZWbk5BK3VTckplZlBQ?=
 =?utf-8?B?Y1VxU3ZzMDN3c0xZbmdsT0xTZ1NReWpWUDN6MUN4UlRSTmtmSEZMSmtDZldz?=
 =?utf-8?B?blJQTVRvSHJ3R1NJYTRYRjlnT29UT1E5MG13ZFAzaXRCV0xLWklobFZGd2VR?=
 =?utf-8?B?a2w3SDE0M1c3RlI5VmNsYmlJRm96cEFJWGVodzV4Q1R3d2dad2sxNHZCUTdL?=
 =?utf-8?B?aExhWDh5ZXhUT3NqeU9MUENDZXhBaE55K25pbFlhUmp5MDRicnV5djBwOGh5?=
 =?utf-8?B?enZ1a241bnJzbFhmVHdERWgrT0VPVUMxcWdyYTdJcFM3SDBhclhaWG1ad3lP?=
 =?utf-8?B?KzJNTzg3bUk4dlpVcytaUW1haTZKRkx5NEt0ZU5IbjJIekxhbm5UN2U1SC9P?=
 =?utf-8?B?UmhnMDYyVjNuT2Z0WkZHcXJxZW9kTENBQzR1RzAvNW1OUHliYzJwNDJUWFd5?=
 =?utf-8?B?MDgyUmdxY3lpR2dQdXRWNTJudlpCQ1VsaTlaUkI0MG1UbXNiNjJtR2FrU2wx?=
 =?utf-8?B?U0Jud0N4WVFBMFh4czNBZDhyUExGQnBZS1hEQWIrS3ZDYWI2b3luSnlVWmt1?=
 =?utf-8?B?TzlEbUZOOFYzcEJmQkl5WkVZQkppdGFxRWhCVklqOUp2N2hMSmMwdmozc1Vh?=
 =?utf-8?B?aXdPWlVRcEJmTDhWN0JOT3hBZzF1NlFlYml0RythL1RGZHR5T0dyeWFQbGVI?=
 =?utf-8?B?YnQzWUVaU0x4c25OV1NhbW5qK0Y4dFh5OW5HbXVyeUtFUnlFKytTWENubUpx?=
 =?utf-8?B?aHZOUEF2MStFQVlmaWIxSGdrMjdwZEtvcWhmd2R4TlhsRWNUUFBJbVJNckdv?=
 =?utf-8?B?NTIvMy9Kb25Pc3ZrYnFIOXdHTjFuSXUvVkNOYWtZT05Bc1FIZEtoZi9MN1Bi?=
 =?utf-8?B?anIwdHErUk1YUEpIUWUxRzArNTZIYmtsVFErc3NzY0dzbTBIYXh2R1FkY0xs?=
 =?utf-8?B?VDR5cDR6NlBNWVc3SUZNZXFYZGtDZlNGNWZCTDRrU1JZMmhNeHFRWWo1NUxw?=
 =?utf-8?B?aDJZZWh0OWFOMEJMMzdOVjZqTFdJVXpjR3VMSkhncnNFU3k3NllpMGV5bEsv?=
 =?utf-8?B?WDBZZ3B3QVI1TkZSZE5iSEQxa1Y3Vmw1TGpXam9EdEthQnpGT050OFhiWEpY?=
 =?utf-8?Q?c485QFrPKG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVQVE5rNGxwQTkwdTRDYUp1Z2VTc0J1U0x0dmZKZlRnUURsSFJ2SE82WWdU?=
 =?utf-8?B?aFJENXRKY1pJanFMOFZtWXB4SEIvSm15Wi9NRTB5ZERUL0FUU2ovZEtjS09T?=
 =?utf-8?B?M01haDl2U3R3eTM2N1lZcURScTZUSWxueFYyRGZIak5wZ20zYWF4ckp4Z1Bi?=
 =?utf-8?B?c3VIUUVYSEN1VDVNZTI5eVRzemFEd2IxRlRObUNWZ1RvVDA1cjh6amFTOXJm?=
 =?utf-8?B?MStGS3RjV1dmVE1YWTMwRzZGZzZBV3kvK01NWGR4MkVveVVCSVJSbHl3WThM?=
 =?utf-8?B?UytSV09Kd2t5QzhrVEFlSjFVSEpMcy90RkNzWFZKMFc0SEl6N0hBdHJ2OFAw?=
 =?utf-8?B?RW0xck9UM2U2eGJzYzFBdHl3enRFaDZSLzEvTjdCY05qbFczdGltUmRQZVN0?=
 =?utf-8?B?dFN4R3dDWTRNTEZOMlhhTTgwK0tNdk1EaWlNQm9taGp6ZEVIbWV5MndqOHJL?=
 =?utf-8?B?cTNKcVk0MldVaWVTNGtPQzNmNnMyOFd2R0FXUGVtcXhIenh0MEdJSnhPVUFZ?=
 =?utf-8?B?Q1FRM0htNVB0blNTc2JTMUFwcWRtU0Y2eERlMUxjMHBzVmYzZ2RQdWlFai9R?=
 =?utf-8?B?cVZudVlEM0tSL3czNG9uK2F3allidFpHMUJUcEVTanhtbWhzdnkzWW85VEpv?=
 =?utf-8?B?eFNsT2NLbkhTSHhnWGRWZU5uSHFINXZRT1VEZTJjUEFWajlrcFY1QjhFdTRN?=
 =?utf-8?B?bnZrVkRuaDhRWTRFMmFObWxHaWZMVk40YkhCQnhEOVA4Sk9acEJLQ3hTSzhr?=
 =?utf-8?B?QUtQNm9PZ1U1SVp6cEUzajJMUzJaeTExSlFoeUtNZXptclpkZkgxbkhvR2kx?=
 =?utf-8?B?RWhaV1hmV2NRcjVKNUh5RThUeVdQa1ArN0xWWWFDZ2VLck5Hc2lKRHZvSUtB?=
 =?utf-8?B?TSttY0c0R2Nab0tzeXdtalRYZnVSS2JSSlc5a0M2QWYweDFmdW5LRWhPaVpK?=
 =?utf-8?B?bmRHSHJBVkhibEVZbjZIZnY5LzJrMGJHbFh2eFd6dW5KdWMwNCtkYnhvR3BI?=
 =?utf-8?B?a2czejVQcFdmaStHWFhiVW5Eb3p4NXdZbzlDejdSbEFnVThmM1ZiUG5EWThT?=
 =?utf-8?B?c2cxR2lSNGRGbGJwWExxTkdjWS9GRmZOTENzaU5zWW8zaklKdXlmVm9qNUwr?=
 =?utf-8?B?MWNkL1FOajBvZEYyNmtYMmd3WVNsQU5pRmpwMjBVY2dleXM0THc2OTJ1ZEt1?=
 =?utf-8?B?RHA0MjhlbG9HME80ay9FemxVb2dnSmxwQzlDU2ZoaGpWaE9FY0dsUEo5QnZQ?=
 =?utf-8?B?dHVnT1hmcmtRb0ZKQ1dqSW5kR2J5dkZzdEMxSjlkdXFxbnJ4R3dkTWFvOHhr?=
 =?utf-8?B?NHlVYnp5TW13T1JQVTBzZkYrdE03a2NEdTNQOENUanZTZ0pCUk12ZTFOMGpj?=
 =?utf-8?B?YVR6VCsvK1V3MWFDUjhDU1F3RkdiVldCVEZOcUVEN2J2ZFN0eFVmMFNTQSs1?=
 =?utf-8?B?MkE2OWFuajN6UVhaeGZHbXpjcXdKMFBwQjd4Sm5hWjFmWGlMNXBjUWNoTjJw?=
 =?utf-8?B?QnB3K1ZJRUttcjFpTzFqQ3YvNEJlR0phY0lJTk9tT05kRy9IUHlZLzhpaE5O?=
 =?utf-8?B?bWxiMXJkdjA5eGUzdTdEY2owOFd3eUN2dVVWa0ZGMHNtRTQrSjk4QTQ0WHdL?=
 =?utf-8?B?VWJMUlhQNTNqZHJQc2ZrajN3ZmJLR2oyWDNGaFhCRUVwRCthTjNRb0R1VTZp?=
 =?utf-8?B?N3IzZnJmdlB4Rlg3WmIrWDJ2TXA1TWpsRW94bnFhL2ZCSEtRZzlPS0tzcTha?=
 =?utf-8?B?M3k2NHh1THNrbDZ0MEoyMTRJa0VyN1Z2Y1dHSFkwUGU4ZEQ1cmVWdHJmSVV6?=
 =?utf-8?B?RnREakJVaS90Qk9rMmFIUjZ5U2RRTVhXaUwxVndZaEZBVkp0UlFrUlk2RDhu?=
 =?utf-8?B?ZGc5WmFiakMyd3RrWFJhbVNoTW9ZQmZnVHlOckhxUFpieUJyblB2ZklpQW9Q?=
 =?utf-8?B?dDN2aXA0Vk5ueDJweTJuY2hyaGFtVW1RamxPSHlWa1l6bi9mQWE3Zm4rSTBi?=
 =?utf-8?B?REk2UGpldU03RmI5V3pjOTJHelA5MmhndTFMNGhSay83aldFcjZSeUozNWdV?=
 =?utf-8?B?ckhvdTdwdjJyODRvZHNhUTdRalo3cUhyK0pLSDNWVnBNVDViRzVreU1ZZWpr?=
 =?utf-8?Q?xT7fyKdcVKeAwhPx2h/7T0KM3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4bfb62-6ed8-4f35-583a-08dd91e6ecd7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:25:16.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ6g/XRP1iga17ABRtvJB1ucCqdurHjDYbUdRayIlRU8JXnHbj8skVA+U2Lrz0b/eDEzL9c6NZryELAncKXMtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

On 27/04/2025 2:22 PM, Maayan Kashani wrote:
> For non-template API on top of HWS,
> geneve options parser is created by the pmd and not by the user,
> therefore during validation , the parser is not yet created.
> 
> The fix is to ignore the validation of geneve options in
> case the rule is a non-template rule.
> The parser will be created later during rule create.
> 
> Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Series applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

