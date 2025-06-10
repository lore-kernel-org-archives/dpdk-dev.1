Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FCC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 13:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D935742ED4;
	Tue, 10 Jun 2025 15:18:21 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by mails.dpdk.org (Postfix) with ESMTP id EBADA4026D;
 Tue, 10 Jun 2025 15:18:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkGe5gVllG/KJUTKYPMVPeBCepuh/e0n8v9cBioIur7er67G6kF3MELodnby1xq21jbROsfa9HWGlYBZeClczDduk+nzghVkzYPMI38ZYs/a3rGhbTYMNyDusZNBedubRFGWbesI50Crkh2LliZM5gvJLHQUNyiqdwHqVrm6/ThYzRRFs9DOZl39oXyMJk5Pd051mu4HOfrkQegtRaxwxt6ZPBbRq9R9h5nieQpiiuBjYZPuTbsi4AQACtiJJ19gcFwrCDMwIg03MwQYZK1lxn0+eOZ+2slsZ1y37zkOryXjBnOgrlQkAQLlWOzv334Cd5JjHwswGXmVQgF/ZTk66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gekhn2tApFLJcAsm4xzGmG2LDS5ps6bUw+YWO6jfO4=;
 b=AcW+BnFQeDmkLKgJEiiXJ3dUCtzjXpMEiDIVjUecODEX7KIAmSWXeJn/ndkbd8H1vrO35YCtOAlY75ynKdgvhk/SQ7rGWx0Yjb58wsUXPolkCZlpBxGrL6CgkwbSvYFexfbwUCUjS/ZVn7FLq1ub91yss4qzbP5InbNEBCzJ7q0vTBX2JmW0GvFRWu0rvjDhjTlAllwmD07a3o2wOjzV4b5AwoGpJ3ttUca6VeVS6tKjQzBY3aypHkxLPu8dRGh6IincD3wCCwJVrA2mAFqoIXoxKawfClF1SlZYMZGrIxW97HERxxCj8VSS6TO8ouiHuJAqkmv2lFrI5Wt+070avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gekhn2tApFLJcAsm4xzGmG2LDS5ps6bUw+YWO6jfO4=;
 b=PdP0gGBg3PBUVfkexiLiJJrZyUNkZbgwc2RW++iRO4ZGQB1km3YsufEdLehrepPrAHnQLrmWfqoB0wXso8AriK/BJrjCHOoSpnQZAnhP+H+DfgoCTu6yBUHI4bA3my9+8MjuOMLpHboZOeoaPlr82oZUJ8KEvrP4opSZiN49h6R/Qnv+OD4hEGLKnEFbDEL3InQb9Y8NUUjUMyjpgJdjSM41EwplH/6IXY8V9kLbazP85F7yTbB9/MX0f+tAQBuJz2aZc6w8b8rbA7V8wIM1EqoRDH9HvOgnEAPbeP9BoCvhzFhTuHj+RT56jfi+v1vo/H7RQp+TD2uaL+fnvOMMnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 10 Jun
 2025 13:18:18 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 13:18:17 +0000
Message-ID: <c5bea902-7168-434d-bfad-cf0a84545a03@nvidia.com>
Date: Tue, 10 Jun 2025 16:18:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix hypervisor detection in VLAN workaround
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, stable@dpdk.org
References: <20241203162200.2543986-1-viacheslavo@nvidia.com>
 <20241206142605.2582139-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20241206142605.2582139-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: f471661d-358f-4aee-16b8-08dda8214382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3NLWnVFVjNvTitMRWNHSDdERno4NVhNenc3Y1U5UVI3YkFwWkRMWjlPYVI0?=
 =?utf-8?B?d3Rhd3Rockt2RnNOTWZMTnVTRXBBZmViZXBUZk5qVS93cCtFL1I4OHd4d3Yx?=
 =?utf-8?B?M3pmdzZ1Z2sxUm1qY2hXWUJNZG5ycm5VS003REJkeHNQbmFzdi9LTzBIQ1U4?=
 =?utf-8?B?NkFibWVnZVR3UEhTcENJb0Y5SFhGWVFlbjJBTDlnZlhraHRPaW1OdnIwbzdi?=
 =?utf-8?B?aGRBOW1nc3h1b0czbS9JK3Q1dzFUdE5td2syV0tjbzJlL3hKcDhkeTdpRTFY?=
 =?utf-8?B?eDlDWU90ZmZ0NXNReFZMNWRlMHN2cmZYTFRqZGNGejgycXRKNm1mS3NseEdY?=
 =?utf-8?B?UzFEMGY2dnRvTFp0ZDB4eGhoU0RZejQvNmtQdlZjYVRiMlYyeGViWXdrTVhu?=
 =?utf-8?B?L1Z3U2hWNHBTZ2dPZUVYME1YWE1iRW1pZ2V2aGpJcDNqNzF4TkFiT2Z1eHpo?=
 =?utf-8?B?ZzEzZVZ1TlpiMDJrUmNKVHBmMFNOL1BQeUc4dEN6T09FMWZVSjgxMDc1RkFY?=
 =?utf-8?B?UUNmd0Zma1pTaklRV1g5RW4zQkE1bDI4dlUyMHB2WWQrdkZNTUFEaWZKTXcy?=
 =?utf-8?B?NEFtZGhEMGNDTU9tOGNNQUgrb1ZBWGlZR290QWFJQ2FIK2p3Tmp6QkZpVlFq?=
 =?utf-8?B?Z2lVR0d3R2pnZjR3MENQeENRVUc4Nlhlcy9VUVkveHZaQWQyckNrVWRkckd1?=
 =?utf-8?B?eFgyZ2crZm5tdDd2K0JpRm54a213bUVPazdDaUJzZHFFQVdvRjBxQjBIMTRJ?=
 =?utf-8?B?S1d4TTliOHd3aXJ1cW5jRUtXUkdSc1g1VllCYnVrbVR5RjVWUmVEUjJJYnlC?=
 =?utf-8?B?OTJ6OExMQzVHR2hRaVhPQ2xjOGN2Uk52cm1zdUo4T2FQUkdXZ0lrUFJSK0t2?=
 =?utf-8?B?TmlTcGhZUEd2VTVlVkt0UlVZeG10cExES2ZyQmg4ODQ4b3JWOGk5eTIyV2RC?=
 =?utf-8?B?ZzU0b1ZvMytEbXEvMC9xYXBZTGxTTGZCME95OHNsdlRHV0daM0l0T2JaelJ2?=
 =?utf-8?B?QisvZlp5WlprWXVJcFgwaFgyVThQZU1xN3ptV01XMWk4MTA3a2N3c2gvd1l0?=
 =?utf-8?B?aVhxWmtNSFQrendLT0RMYXRKWWI3eGs3S2Q5VFhVVnFzZHAxVWNSTTVCV1pm?=
 =?utf-8?B?Z2YyS2JCT1RVSWQ5TWgyRzM2LzlpaVpDNTR5VVdLak5EQ1FvV3JCOHVVUjYv?=
 =?utf-8?B?cnlLYUxDYmZRb3pqY0NRUlh2Uk9qUUZNcUlaNEhvb3hsK214Y09VSk4wbThI?=
 =?utf-8?B?QWJCcWF6OVJUNUcydnRZSzVuanJIejdCcE94TTFyTzlMUFlzTlNhK2FnTStY?=
 =?utf-8?B?VDFOOVoxSUlyWG1sUEIvOEJ1bjR0bDJZT2VSMTVKemxnK01obndpa2NzcjRF?=
 =?utf-8?B?KzN5dUl1TnJYdVUxSXpWQmpETk5pQVRxVVhqeGJWTXZqM2d1YTgxdkpaZ0Vl?=
 =?utf-8?B?S2g2TTRqQUFwMmhKdHFmbVExNWFjOHlNckdpVVdRclNidGwxbjcvdjFmckNl?=
 =?utf-8?B?YXhPMVZPeTZJV3lNTGJNOVdZSWRhaWlQc3dSUlY5dStWUlg1Q0RKbXJvTkp6?=
 =?utf-8?B?TUl5RFhlMjlrYjNPNUp6WE50eXZpdmpMU2t1bnJXWWNFQ1NjOUdnRm12elM0?=
 =?utf-8?B?VlZROHIvbmRUQnh4aVdTM3dKejlBZm1MSlhZZEdHdVp3Tk85ZmhWRFJkMnI4?=
 =?utf-8?B?VjNIcEFsU3JPRE11eHIyVUtCV1hJVnlBWUp0Smxmamx0YXRxcG9xNlFnUGF0?=
 =?utf-8?B?dnZMVWR0QUljTXkrRHVpdFpxNU1PT21QM2J1b1RRdnl3b21XTCtOMmNIQnFy?=
 =?utf-8?B?OW0yOFpPNlF6L2I2VGI4VDI0QnJOK1ZkVURrR0FHSDZyakJSNEQ0TlpDZURx?=
 =?utf-8?B?RG5IVEQvWU1nY3RYdmwvTVRSUVk4QklieG1OUFFub0hibU54TW5JcW9TY0w2?=
 =?utf-8?Q?kC4no34ym60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRNUG15SUpSbUlsUmtzcUhpSXdWUnMrejU2MkNrU2ZySmduZkhpQlRyOWk5?=
 =?utf-8?B?SXdDWWlYNHowYmpoS05JOSt3QXNMS1UxVUppejBkYnFQZjJqV1hxa2pmVzBh?=
 =?utf-8?B?WTdZNHRTM2xpUDRYaGhQRld5ZEpocVdYYmpISTZQamExWGgwa3VIdGo4YnZK?=
 =?utf-8?B?U0tvRGdOd1NudTlaRXV3bDJZZStPYWVlN2tEWVVLRER2U1FFMWpGb1MwRGt5?=
 =?utf-8?B?SmpVUXFhRnJPbm9WajNpQnlncG1Ob09uem5TOUM2UlVGbXM4ZURLcUs2OU5y?=
 =?utf-8?B?UmhXNXBMZkk0ckVPZkwvZm9GUEJKMCtKMXdqQ3BYYmgycWJUN0FjUzkvWm5B?=
 =?utf-8?B?Y1NCOG5uMjdSSlVoSWYzOW8xOWRGMUxRUGtZdC96ak1Qc1ZrbzBuamRmRndk?=
 =?utf-8?B?eDBBdlpmZStRNGY4YW5wTlh2ckdDcmVmUDFQZmVqZVQ1aGtpdG9jcmdjbXlI?=
 =?utf-8?B?R0Q0akZyU21KWFVEUVJZVm5LR2JtelhsUTRId25QTGtLVkp2RVJnTDYyTmla?=
 =?utf-8?B?dmtiNmRtMWNGV2g2ZGx2TDRDVm1zeVhYRmF0RFVmN3RFbXpwbm15WHlucER1?=
 =?utf-8?B?eDBoTHduQWZuSGFIUGxkeG5iaUtTMXlkVllRb2NQVW1kT0RqWFc4UkxkcjVs?=
 =?utf-8?B?WHpQcXI4VDdjaWJHMit5bE1CdHBCUVh3clFydlFCTURZeTFKNm9VclJCY0tM?=
 =?utf-8?B?WEJEenNycGcvQXVOWkVLZnBvQnF6QXlBVFBFUlhNK29oSEEwa2tOdjAyajNL?=
 =?utf-8?B?dXRKTzRSVC9uRGMyN0F0Tms0bkNZWGhzZlBJMFVQcjJnWnl0SWJzVmtWOGtT?=
 =?utf-8?B?RlBOeG5hcGdDazkrRDFrK3Y5TWVoR1Jpd2l0TzFLMzU1Qk5jTklnY1J5MWxR?=
 =?utf-8?B?RG1QcEhDUDR3eVROOU5Ba3NTSXZYWXB3cVFJdEozY0Y3UXUzTjI5NEFmVStF?=
 =?utf-8?B?MjEweldwMWZtdzQxMkNYOWNCYTF2SnZVdDRTOWF3RDhUbzZVVlFabm03bTBt?=
 =?utf-8?B?Yk9PS0t5Z0phOUJBcExQUFROdjBmN2pGWjRlRlJWaktrbXl4dGFkY2sycUR3?=
 =?utf-8?B?bHAvbHpwUm5FWUhRbGJ1eHBqVkdQVytqYXpIQWtJUnA1ZmNjQmtKblBBRUxH?=
 =?utf-8?B?MGRJZC92Y0I5eTk1Sm10MmZUQmVQd3pNbldvb1VnS05GRW9OMGlXUFNlK2RU?=
 =?utf-8?B?bDV6eE1kb2ZSWVBZU081K0J2Snl5NVBvUGJINGdvckYxclZ2dWhrTFVsTjJD?=
 =?utf-8?B?bFdObThRMzc4ZXF6dm1RYmJPQ1FNMjNEamVrdHZFQmdQU3hZS2NsZkVUa1Nm?=
 =?utf-8?B?K1Q3UEQ1M2dhSDEzTWlWSUNDelhzSzJHTXpXdTJYVFoxdmVWNTZXOEFac3VD?=
 =?utf-8?B?RGdENHQ2RFlybXdlYjBFcnhsNXR6L1h1UGhOaUNKN2poLzBaRklMS3VodzFv?=
 =?utf-8?B?VCtOLzNic3NPR21Pd2c0cDRnTWVnZjNrcHJHODdvM3ZrOUNEZ0FtU1pERUp4?=
 =?utf-8?B?ektmTnJPT3pMNzFZVnZpVXJMNUd1WDVBeC92M0FFOWhHM0daY2w4QnErdEl3?=
 =?utf-8?B?RFlkTG5XMDlpWTJjVnd6SDBlMmcwSDN4R1l1OHFWVnJZRkZScm02aGY5OFd6?=
 =?utf-8?B?VGx1aDF3ZFBVMmtreHR2ZW9GakF1YzBwcklVdGhkb1RiQ1UyL1RpU3lSbUtJ?=
 =?utf-8?B?WlQ3U0Z5S0FhWXYwY0g0M0NlK1BqdmpaNDY4Nlo3Y2hNZnNoa2FGZmVZTTBD?=
 =?utf-8?B?dTdZbWdOckg2R2R0NlZzQUI4R0ErK2tlNlV6MHR1WGFOc2VDTHNOYkMvREkz?=
 =?utf-8?B?WUFrYW5uWFh5ci9PQmpkZzFzaVhGbUplZ2hOQS9GQ0Qyd1gvWFZUM2hCUGRF?=
 =?utf-8?B?MTUzRVRaYUloZm5xUFNPS1NRMzJDR3ZmZkEvSGFMSXdzQjBoWTZ5VDZJaHhi?=
 =?utf-8?B?SStLQzFGWHE1QkdzVUZEaGtZVFNnbWN4WFJoTFJiQW9FeExzZlIydVEwZUhB?=
 =?utf-8?B?OEhySmt2Y29aN3FvSlBLOWluQkkvWGg2ZTVOaWQ5RUxmcDlBZUsxSklYL0FN?=
 =?utf-8?B?ODZWcHMrMjV1UWpTZDBsUUFoVU5JNUJNWi8xbktzUDMrNzY5VDdHaHNGQ0Fu?=
 =?utf-8?Q?2ykilHii1kjxGm/8y7Kykoxym?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f471661d-358f-4aee-16b8-08dda8214382
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:18:17.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EymC4eYYOcdmhQy5nDoDc4WAdcpg7AT2yp5LLbZghen5oOkN89ddZwICfMG9tCK+XOMGvLLzEzeNQIik+M/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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


On 06/12/2024 4:26 PM, Viacheslav Ovsiienko wrote:
> The mlx5 PMD provides a specific workaround for the VMware ESXi
> hypervisor, enabling on-demand routing configuration to virtual
> machines. This workaround activates when the device type is
> a Virtual Function and either an ESXi hypervisor is detected
> or the hypervisor type is unknown.
> 
> For non-x86 architectures the function rte_hypervisor_get()
> consistently returns an unknown type, which triggers the workaround
> automatically without any actual needs. If there are VLAN support
> requirements, this can lead to failures in inserting default control
> flows.
> 
> Do not trigger the workaround for unknown hypervisor type
> in non-x86 environments.
> 
> Fixes: dfedf3e3f9d2 ("net/mlx5: add workaround for VLAN in virtual machine")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

