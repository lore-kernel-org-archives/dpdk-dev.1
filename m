Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1E6CCF2E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52AE4402E8;
	Mon, 19 Oct 2026 15:56:35 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34]) by mails.dpdk.org (Postfix) with ESMTP id A837840297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:56:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKqQ2ozaWniPP68TuvKwxxx0ZNGj8xaX7jfKQOQaux5kvwNCLHxUqhSTexasj0IQjtITFokZ8Z972G7Yo1TEItT2ViVoAdk13gbZZVfRhr37O/NypcHYjmRTABA1vAO9N+wAW7QIxzPJ/r6mpdfQrphbmh01Z1Hv05w9LV0qKkknBGVzCug6L1xahsywlBCR44U/+cJd5lc4UpkGoSmrkkI1f41h/EMiVCCb2deGFe33NA454uVhq7tbde1Nn8A2DTvHZckREMlV4c4jTHK+/92RjemA4OE0vmivddpMol4Z/hgA4NnRhm/LclDFSm+oPPg98l/ZdXTnipfTetBJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYEcsmmrInjhCsC5VscirwKIrJ4px20a9TfoclvOKHI=;
 b=vcdi9s76cgw5juLoxxtD+KbSlI/iL7b73gKAUkmcCKSt6Qku/ZkhL4on8LtljqyynfdUx+3jJUHeTxDe6SqNUXRYUqsEyF4V2QUBuYD80pMJE1O1gHPJ56PHT6Ub2nrE/8QjHdU5oe5gH40MFjaUdwIk/nfTALrMEP529LSyl3v1+PHkB3ms3jzuSuhpOUdJzq0CcWr37ERMt5vdGVzrssLk2uzOGz97YJ0MYYrMiDgu9ZUQXwlMQZqKYPFePeiZ+t0wWsuhGvPT+bvWtp2lelAS9TX+Cbk2L/TLfboyRFBURAmltXVTV71QrIMwS6yg9eGabCIcDNDwsQLv9qxvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYEcsmmrInjhCsC5VscirwKIrJ4px20a9TfoclvOKHI=;
 b=ahsFMDKD1uha3UX0hMPmPjFiXFbMsAXWthxaZcFM0UiUXaDHebAsXKn7TSi9bdV6x2dt5chPtD2OK41pK8H+696NvHZthyXOt+qIrjox6S46blyCdT8RxvENIee9PuA8iebJWDe13JWdaD+ccSSQcxVzf6LhTultw5rv3Y1DXhHgQg2SoNV94pUPB8pWeuFRbzbxVmQzP9r0RbijaWxArEE8juP7x03GTCrTbdPBWSDrpJKOxpSv2gAsDZQnbJgkr8WSScTNO3t2p6PF3UOnYIbYyTFmV98HrHZEKp8M8He2/Qqg5vpEWLkZ+Y8jJzktt5CZ7haQh14pohlpvEUgjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 13:56:30 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:56:30 +0000
Message-ID: <f515d29c-525d-4854-bede-ffcc01303062@nvidia.com>
Date: Mon, 19 Oct 2026 16:56:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] introduce pile stack and mempool driver
To: Thomas Monjalon <thomas@monjalon.net>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914155901.943571-1-mb@smartsharesystems.com>
 <ItqMX3UyR721OV9AeSB9fA@monjalon.net>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <ItqMX3UyR721OV9AeSB9fA@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::12) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0685cd94-ef5b-43a1-134a-08df2de8c69d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: e4o8kBSlB55bzdZUj1ld1DUB0yCrmnWMrZbQETlcpWYbbIreLzfzwDlaZCx9BAoFGbodGyX7iN1i50fTOfBNepYTQhhnnrkLi+Bga0wIzC1gK7UB6BfgqNOkp5GhU3HKqFm0h4xgvHvPVacm9LfaiKyfIjbd/EzsUzkuQgdjKSQeSqeSAnUkCOAh6YPkhO9W9Zpo2cEW6LLPm20IpHNW9CqOaSZpeOxYpxz9f23LDP+zEBsmiaY3e5akrDJY8sQBSd3lOC6ZW4ewDeyl0rK5n/NxK1h5nIPm5krXvdh9l8OK5L7avsvAensErpfi6s9FTj5wFkqVUjEs+RG9H1+HbDSJ4U4djFIKyrGlm7j4fZ/zm3o7Hp17jY17Cve70nGuN6Hq+4ddsx/QDkTjnPXb2sbbnaxG8pdMXyZd+XSqCRqIaDOP5MVJol3RN/KLs6JQMctDQxBkGZrLEJNLDgUuSjsj3EvYCELExVIUe7tGkYGkhBV7Ks3muyyYkPSpS41iK0fN9DC3QyvqAMNcpxampExQfLX+dKBS7ZlEdhmgzgUlI2QlYCkCHweb9Y8ION4OHXa8UpxY/FNfMcPHZZgVgm9jgOyNDbi1SCwa3LH9GROdzFvDapFTOE9rWKds3NDU6YSc0eDfKIkdbGjGVEqoFlKbxWJc+UzLMg0DvU/w2pc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpvYm1ZMlV0Zm9Xc01sQUxtbitjTUlYcktJcHpVN2xTV1RxbTNOdWhReGtr?=
 =?utf-8?B?bWVsYXBIZ05Ba01EcWplNGN1b0hNb2dWa3l5TzZFOXZGMkJjSVdhRjRmV29T?=
 =?utf-8?B?cHlYWnJSdmRLSUQxeitTM2xGWitILytQc1RiSTNteFZ5clFIdnlSTHRsckRl?=
 =?utf-8?B?S2trcytRUjBJdlNqMUhmU0dTUVlMeVNKbG1jTVQxNzVJRDZxdFljSTBabWU2?=
 =?utf-8?B?bXBrOVd6OXd3SWpyenZ2Y2VFQnFSUUpzUUFCY1JhU0pHVE9aUDlveTBJL3Nj?=
 =?utf-8?B?NG14MUgyZ0lyb0hsNFU2VGVpSGh3REpuTWs1THRVWEcxVGd5cTFPdDBmc3NP?=
 =?utf-8?B?WFRIcVh3b3hpVFEydlpucG4yNWsrbi9aTm9QSnZxT21aa3NZcERqcmx6YjNB?=
 =?utf-8?B?LzZNemhqcU1Ya2Y2NVk1YnBxakFiTEFtaHFCTFVwbW9wem1Tb3ROM2ZZeHMr?=
 =?utf-8?B?ME1VL3RGSk96akc1VFFNd0d4Qm5zYlpiZ0Q3VjkyUFhESDdrS1NodkdhWDZG?=
 =?utf-8?B?c1RaQVI2aGRRcHNPRkVCM0Z3Z2FCRk9ZUDlWTmNXT3JXbW1HblNvbThGS2VP?=
 =?utf-8?B?SVIwcHdKaTU3V3pMYVkzNTYweE9sZlhuZEVydkNGeVlvdGU4QUhKZStNTjF3?=
 =?utf-8?B?b0p3R3I2RDBTRHdUenpKcnF4N0dtMXdnSEVkZ05GY1hXWHR6dUIyZDNSdVdk?=
 =?utf-8?B?M0pwUThheW1VWndPMjQrWVBUeFM0Yy9pM2M4VVVITFFqd0J2MkovTHpYQ2E5?=
 =?utf-8?B?di9iNnJGZ3BKS1R6ZzNGRmlTb3VjZisyM09Sd0ovS2luRXhpWUJVQTlJdEQ1?=
 =?utf-8?B?ZHJTR0tiMTZhbU1SOTF2TXdwQ291dDJlMlFWK210akxmTnUvTWttaDVXWWwx?=
 =?utf-8?B?ZGZaMzdvZkJ1dkN5MEUra0JZQXI3Zit0aGlGaW5RR2FIRXErUU5IZDEzWito?=
 =?utf-8?B?VHhaMGxMeW5JRTRMMHNuZUQ5anNleXZRNlVPUWVxdk5CSHJHZmdtOVZGeXJL?=
 =?utf-8?B?bld3N2ZxWlY5Q09CbGdvbFVBWHYwdHFReFZLQVNtMmd6anErOWZpUnc1alpG?=
 =?utf-8?B?bWJGelBVS2FvU0U0OFJHRXpHMlEwNlZEdVNPZXNvWkZFZllSM0tOVHFOcGpY?=
 =?utf-8?B?L0ZVV0RIbzhPRStVL1ZRMkgrQWViNCtWVVZwVlZuOGlJWEVSVGVuYjUvbEh6?=
 =?utf-8?B?Mm1kazk4N0c1VmhYZHRVYVhVdXRYWWdxVnk1WjdDK015cWlvTHVTakIreEVV?=
 =?utf-8?B?T0pFOExkcmVsSVpKbGdVYmloSW4zTFZUY1JNY1dPKzdaSVpjYmFKT2JFWGdv?=
 =?utf-8?B?aWRvamJXTHdadlJDdWgwR2ZTZGhwZHVrMTJOeWdiNEc4aWNzRU54WjR1WjlB?=
 =?utf-8?B?azZRekMzSWpNbXdycnBYM3hlQWdJVDIxbDk2bTlzVVNCOERPLzdQRWR1ZEtK?=
 =?utf-8?B?YVg1Q2luakdwcWFTcUlpdCtaRHhkL0NXOHBJaEdoSisrcjM5WmxrWFh3d2No?=
 =?utf-8?B?L3dEN21ld0lGeEMyRVY5SDlBN21aTzB5NldTSmY4Z1JlbDVkcEpNRXdCUGhZ?=
 =?utf-8?B?ZzJKVWd5dXo5bDFoYXNJOTNTaU4reDhuNzdXTHVucXJ2YmE0UnVVTFVqVGI1?=
 =?utf-8?B?MnFJVEhoSnA5ZXREWEM3NGtPYUFsNEJENVdPeGhnb1dhckM4a2pUcVptK2RQ?=
 =?utf-8?B?OFBQMnZuSUJaV0dldTNyeFI4SElIVEt4SlBuZXJLQnQzKy9HNEM1YldHRnRm?=
 =?utf-8?B?WmVVQjk3SzRWWlYxOHdqTEYxRWVHcnp1V3hxcmthUytyUnBTK0xhUzFlUjZ1?=
 =?utf-8?B?RElYcHlwdW5ML29pVW5XTFFHTjh0TWM0akkwYVEzazJLR3V0OTdnam03WjQ5?=
 =?utf-8?B?WTJBNzdnWW5LR2VWMllCTzNTQlB5U09QYnpaMnJXeGdRWTBVb0JtWkNWdDNx?=
 =?utf-8?B?RTgrV3dNazB5a0luWG5QUTFtMVBIejVmOCtmdGZlVm9kZE9kcTRmclRPZ2RT?=
 =?utf-8?B?L0cwM0MycGNNUVNoMmhHTTVHbTZkelBySmUzK2FXSEpOQnRka24vRCtFRElC?=
 =?utf-8?B?djFDc0EwSEdQTEJWRkNMODE5dDdoelJkMzVLVzIxYWlLN1FTMXdSSUVEdlc3?=
 =?utf-8?B?RTl2NnJpQzk2c2dhL0c0aGw3K3VsM3Zyb3N0NlJqVElQZkdOT3lLY2h6bHRD?=
 =?utf-8?B?YTFQQUNLOUg5bkdpR2hWM29xQjhRU1BTdndFTU9menp5NWxtVTZNWWh5UERw?=
 =?utf-8?B?K21UL0ZPN1h1blBtNW5ZRU5uSE52a1B2MldTK2hIb1lsUXA0ckZTb3VIc0th?=
 =?utf-8?B?VDBobVVJMktWT1phU3BTMHA4d1FjU0UzaUNDTEszQ2M5ZWsxVXVRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0685cd94-ef5b-43a1-134a-08df2de8c69d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:56:30.2126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EYVII4C4dZaja1Nbig/aIZALByZ5F9rVpEL6QUmdhFXvGwdHkO8aJQqOk3lDT+QPg6qIb/lFO45m+C+j0MWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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

On 10/15/26 8:22 PM, Thomas Monjalon wrote:

> 14/09/2026 17:58, Morten Brørup:
>> Added a new high-performance lock-free "pile", using the Stack API,
>> and an accompanying mempool driver.
>>
>> Morten Brørup (2):
>>    stack: introduce pile
>>    mempool: introduce pile driver
> Applied, thanks.

Hello,

Debug build fails on Ubuntu 24.04 (aarch64) with this patchset. Bug:

https://bugs.dpdk.org/show_bug.cgi?id=2061

Regards,
Ali

