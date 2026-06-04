Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA01FCD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:29:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D05402B6;
	Thu,  4 Jun 2026 11:29:07 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by mails.dpdk.org (Postfix) with ESMTP id 056EF40270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:29:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmR6hUy/LWJj1SqHJkLTuhcb2j6NHFildUmegy+N+K/Teed9vLOaDc6oHtXaKDZ9Rij9Eg9mgQ01niJ4nn+Vnsbw61KIXBKX+GWlGAl7PeONSduh+dK4UrmgKBw1oX7D5dHzF22OiZuOT8czwZqwnequUhiz9Zjh++5TDXiKI8n/lzmZ0mGpE7SDgEXipITtT93UFZlmde5aktT+t0d3FwVGfvHmtJPvvnUxhTqGTjrAX/bU8bRC67QrRba+PK5OIquaYJPYEPoiax7C+/l/LudKMyPFcDrql9/K5LWq5YPiwCGfnPics+Bb31UzGkqCIiPThYjTLBKOc+fsYBFnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqb0Ye2qW0ArRPdi+srHJvuEZ6RQ74/0snsWHlEz3Vk=;
 b=iuGa2PZleR5D77vwAIUDpOuONxzmF4MIlnifzFmuVmIrxSjjLHKZImf613P82dWjCFU2X7NoQRkYkZwgI2/XjXV/4ituizOwEn2Oy4PsikSdXCs7Hskdzmceo0j6LAagBBIMeB0IRsJqFNIKHNk1f6c5GRXgF2BIbeoD2gkCa4wTmnN3fjK1GJr2MVzWYbw7rs3FQ7ahCOyUuQFzaFduUXwMZFTwim9hBKgsugpoOfMEFGH70WWWROtgpuCC/JN8qxYE39g6176vz6TPd7OYI30kny0S55cjuihkm9icne/WPQw8i1r11t/i3YFP+0mV6b4IkgV3clCgtPCTMrm7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqb0Ye2qW0ArRPdi+srHJvuEZ6RQ74/0snsWHlEz3Vk=;
 b=e7/LrROG6bBnO4lSZoGmlnt57vu4B8ojM29X2Jq+A4zw9ZQxSQhERpPXmmMj6XkRNtX6KChgxhL6445kjWVmT+c0iw/MDTYVj/xwaRA9bwYRwolY9FWkexoI+evn5U6pKRmrdKI4jcvJh+aPefOTAScRL4tO5ETLTP2JUbKwUuI+kOe5i3zX5aE5JfEQVHQ/pw+aVH8E9gBfDr6/gxzuXUe+ReFR0jz7llDH8OYNMSx9at/VV7yRwTxX1LSmIjF/Lr42gvwMDoTwxd06raCClAjIf980q0Un9qfnHCJp/YyxCKg2HEJl0gwFS63VGrazrWxHpWVsvLWNRt1IzA3Gaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:29:01 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:29:01 +0000
Message-ID: <1b366838-98e5-4547-a5ce-02f234ea1e54@nvidia.com>
Date: Thu, 4 Jun 2026 12:28:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: query hardware capability for max lro size
To: Rayane Boussanni <rboussanni@gmail.com>, dsosnowski@nvidia.com
Cc: bingz@nvidia.com, dev@dpdk.org, matan@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, viacheslavo@nvidia.com
References: <7z76boxf6nf3hzvspmc76ldy6idbynhusjcvlik2trkccupfiw@5ldoyqampej3>
 <20260424142732.1904-1-rboussanni@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260424142732.1904-1-rboussanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7a7227-9b11-4c19-913b-08dec21bb632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: GvhU+Vfe2HA6E0QRcFIZDNNgdIScvGLAd3yz3+PjIzgOJDAaCG+zk9ZlQfxbBoaeO0Yb5Yz6DCuncJYzoQ/YLFG25Po5+nqKGJ3wQpUe+JigXB2/KbAzzKf9tgnrK4dY2CN+U/aOmcnPfYzjghn3R7mzYgc8NgX3Nqe0pPRA09cMFlc0rMveX2fR8k63i1eYsfITB1Zk15Ao5uLJY3gG/z99yfiEPEw5AnD/1VfTmq0A9oBK2cQuVOLNiNpL7y9fiehY7j+fL8DOF7K4r/VpapP/Td0QGps815oKLcD++I1vVIaHHXTwO9EhfAmtgaNYG45bFQTM9ItlTj6Sjigm2lK6nrUQMC6qBG4z/CgoPdEmIm7SWn/www9WUq5+XipKSOKwxugw4eO9pdlUPqodmCpGUOIp5DnEYIeBCrAhQoY80V+rdGwMWElqjCKU5ihTEOrTkNiyUsckZhRWBCFMtqhWzH2rJ6bvuMhSXYzTOGmkUYiJGblFdG7LrRJKn5Evcg+aKqARZC4yWyl+o4SYEQlqquufam74wUV7UWuhOfuRav81c9fmmH4TCQ6iZ90rx4bQmBJOjyg5TbIxiSPMQB1EEeYjsI5aZlxsy4BJh7NOACcxQ/1xqLJWVpIjPSrGCBYC/3jKMsrBJHcp+0qhxtk+A/E98NH85DphQF748QfOEkCzIuychJM+tO3lfpq5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhtMWRIRGtUVVZXT1RFd2s0S1EzQUlBaENjQ2o3YVR4NU5GS2Y1Sm8rTFpN?=
 =?utf-8?B?T1BobUZLWFhLcUdmRm16cXdudTRyVHRuZW4zWU00eC91Y3JJTFgrQ01HRmxB?=
 =?utf-8?B?VGJFc05EWEFQdDgrTHdoZXpFblVENkRvK1BrdHZhcS9nU205VDRSUU9DYUlv?=
 =?utf-8?B?YmRlMXRRVWMwSk05SlJJb0FjOFlQbkdrckR6Vk9zaWJMZjJncU94UUtsemJm?=
 =?utf-8?B?NktIaG9sZ1BQZXRybDJxSEFTZmNmY3FGZzJ4UFIyYURFUFl5Zm1icEtHN0lL?=
 =?utf-8?B?elRkeWlNVEZ6R2JjM1NGQ1dPWEhKZEd6cTBIcVpqN1B1WVBBUkZLaWU1bktF?=
 =?utf-8?B?Q2Vva2RWdWVwMWt3bGo3MXhhais1ZDVwU0wrRzFvL0liMmYzRkdiV0YwUXBa?=
 =?utf-8?B?ZUlZUVdaNFhkb1ZnYnpCSzZ4QU1JOXRyVUF5aHJ6ZEx4MWRzWFlINmU0NEZ6?=
 =?utf-8?B?cjVIM09WNWM2OVN2RXJicnNINS9wb2RqNnlVMU5xa1ZoQjJTQ0pHdXgwUFZI?=
 =?utf-8?B?OEJodFNxd3BuZW0xbGJqcTZWb3lDc3p5TCtoZjJ5Z0Q1d1daYWpiT1JINTZO?=
 =?utf-8?B?T1d2SFJzeDYzeUcrMWhqdDNWVWRVMnpqcGtMWmlQQTVNS3NRVlFKSGVtb1BI?=
 =?utf-8?B?UEFoSDczaFNYaWpVbEs4UTY1VmwxN0tOaVVWZHZrYVRsWHgzaUNYaFd4VjU2?=
 =?utf-8?B?dnhMS1J1M3ZxQkRLVjByM3FuSEZvaW9mZCtLdDkwd0RiVkd6TmRieEdtdUVE?=
 =?utf-8?B?MWtTYksyWVJPUlZpWUlBU0xHV2dXeUE3YkxMTEJSMkRxaFdJTWRNZWhKQzJH?=
 =?utf-8?B?ZzM0MFBEYXkrbWRZK2dLam81L1pCUW9VeStubDZPSEpaMGtKT2dNQlN1eC9Z?=
 =?utf-8?B?ZVFCQXpCOGJsRFhqZDBQWDJHclEzUUEwZ2kwZVJKSUEreURMKzhWNy9WRVdT?=
 =?utf-8?B?eWg5dGgyRXc0NEp5NHZwWC9IQUw5cHJXRXFhUVRPZWNDRzRkOTBFeFJRb1Jt?=
 =?utf-8?B?V3NmcTlZcSt2V3pDRVcxMHNaQXkvbE80ODdHQTVFUDhuL3phL3pLa0owV1p6?=
 =?utf-8?B?MEN3aXRBNzNWQU5vUTluR0RaZmNKdE1kV3BUL1I5YVBZaXdOYnpVUjY1ZFdi?=
 =?utf-8?B?TUxKOXVEWk5IWTZEM2VkUEsrZGpkTU9LTExqZ2ZNNkx2ZHF6bExncVl2UkpY?=
 =?utf-8?B?SHlOUnlaeWxlaU9ycHRMS0RIdnJqY0JiWDQxeStWbHdTWURMcVdvT09BUVdL?=
 =?utf-8?B?MXBLUTViRXE1S2twVFkyZGkzTjBFMkdvUjBwTnVXdTJpVXd5cEdXMFczTzU0?=
 =?utf-8?B?S2FHSWMwTFBSUzBoR0VJTG8rQloyeERNOHZNZ3kwcERhTiszeVMwdlJwcUkv?=
 =?utf-8?B?Q0pnUU95blhuTnZ1RnF2dE1JOTZBcDVtQWNsbkw0WmhqOTZLN3Q1UWFsQUdu?=
 =?utf-8?B?MWJZMDJWdDJCL0U5Rnh3K3BYTkVKS1o3NUhMWkRZc1M0TVpPZVVkcFRLSDRO?=
 =?utf-8?B?MEtSOURGeXQwN2dVVnpkUVNmNSt0bjVneXhmZ1gyV0IzRi8zRzFEMHgrYXVC?=
 =?utf-8?B?MG5iK3d5dzB4N21aSUgycE9lZDFXSjdwSjdCZGduQXdWRmpURnB4bXJVM01i?=
 =?utf-8?B?NVNkTnJraDBHOTR2ZnpNRTFkTnJwcEpLaGxtYXNpME1ZK2Z4bjFkR0QrSjVW?=
 =?utf-8?B?YWo2bE1uRGFZMmxvVjR0elpCWGdJTzY3VUJrTk5ndEZFQmtvbEpUYWx0ZWNi?=
 =?utf-8?B?eStiZEV1aWI3NWkrYjZWbUh6TjlYbWtSU0lORUIvbFpkUk5LT1BJSjAwWFE4?=
 =?utf-8?B?T1NKK01vVk1lWVZzRWZ2OW5YSFZqbmtjZ2tQaFVPZkszMGU4UE5FQXBjeVR1?=
 =?utf-8?B?QVduUjIvdE8xbEZMTjB5RHBvZHd3U0laZnpPT1JWNkV4Q3VkcnBrV0wreHlz?=
 =?utf-8?B?N3I4TEQrQUxqaUUvNWhSY1MzZkxNWTh0N0ZPTW9jeERJU2FaalVacDlqbkdk?=
 =?utf-8?B?cCthZmZ3VlFNMk1UTVF4NE9jUlFBekJkdFpOR1J1Z21lN2xkTmF2VVJuTENs?=
 =?utf-8?B?eC9aVVgyeHQ1a09zVmFBNWtiVVZLU0xHVXppOGFHVEIvSkRwMFpPUTJEV0hJ?=
 =?utf-8?B?M3psYjVrQVVlU21FeVJLc0gzdVZydlY3K1ZRY3Fta002VWMwbi9ScDZQRE85?=
 =?utf-8?B?S2ZoV0paNm1mZGJtOEJnamxQRngxUEtmTWYraUl6U0JrNXIrSXAzZ0lFWlZs?=
 =?utf-8?B?YU53Z285ZTlFVFhBRWRYY2NUVlVMcDMwY2UwK3ZDbG9jMFpnRXgrUU8zMU9N?=
 =?utf-8?Q?dgHaTNrVQ6H6L1UUTW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7a7227-9b11-4c19-913b-08dec21bb632
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:29:01.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQtZ19MuJoP0YfX1k/FGeHN5apbnR7PoMa/dnZ6u/0N05hxVSCMBwjZ1gFdJ7OzBG+pT9XT4iWwIeDxEtj4MMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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


On 24/04/2026 5:27 PM, Rayane Boussanni wrote:
> Resolve a FIXME in mlx5_dev_infos_get() by dynamically checking the
> lro_allowed flag instead of unconditionally advertising
> MLX5_MAX_LRO_SIZE.
> 
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
> ---

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

