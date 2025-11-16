Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A63CCD19A
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 15:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5EA410E8;
	Sun, 16 Nov 2025 16:30:55 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by mails.dpdk.org (Postfix) with ESMTP id 7CADD402E3;
 Sun, 16 Nov 2025 16:30:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBLWgsRlknvmxxou4kgvloJ13GIL/lHGMksdvx71CPIsTv4EhGeGYEeibK6kLRY1QcfffIeVMsx+qdMxaBYj3sY0LCcx0HyG+mfNGUZ21/ltW0jVV/KP6+AoRWc+sGLWp1qoTGuf5qdBnZ9okK6IP2KE4Ox0GdksP346imh5RIq16yb3tjLgb9U0BfBxvBEJxnOjQejlM3H9CVLaTfFbj+Pbb7zYomWgvTNRJYnvvNnVgV3AgaXUpZAmlk4U0DOS+TqT/fBKTQVfXBK0PHrFLKPRUi1hxSkTLdWTzWrg3WNFqLnBbLo/5mM/LEa+gZGZWS1bbMk/b+NOz5icengHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+mEB2yTktacS1y0bPJvew4MvNdGM69ZNBY2P0aKtOc=;
 b=eMO+qfxLeMD+XyQAqbuBDGN9WFRy5iBEw/VSmXJu4ogbfYplfaHij5fdC3KR1xSBJdKMlnUB/gwi2XI6E5FdokPiLDQX7MuYKcatpqLPTrYUnfXd/FNEBqRbrR7TXuTsAmTjpj2hp3UyG0oBbOjWS5uTebX9Iu1GeA27q3lFR9RdXFH2kbfjTVeQCHhC43E+fIW9U6qJGUxRsYAms5QGKLOjb1tIYolozzCzpuSLe7EGFYOmhEg6JaY1A00qwqa86fhGrF2TL1Wx+ipCShyctQ7PdxflvMwmsv08ecZU/Mb2nf8fWU47MOU8QgFRDq3Rqp10/MyICXollzMstrffXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+mEB2yTktacS1y0bPJvew4MvNdGM69ZNBY2P0aKtOc=;
 b=d+O7BGO+7PO4Kwl4p5yY58tn1XnO9tmbnUbc/9v7x5BGJDHgMUAiFwRFtCfyDS0X+2ZMoCCb14/jRquknKLFr9EJOZdzbSVAsXqvkuh8rOaDwMAloKRLsYcqP4wwn8KuePysMC+jcj0BT63LoP2szQ62bsvJCPP7f729VJ9FNL1OlWIgWRT0xp9JiUwzlECdY6Re/G4610Adkp+Eg1Yv9H1VY9Pec3FJIoZCubg+lgnjL6wcqBnCNzAnRyCFqJuyWPd5vN4gij+ugYmHCIKdslmdOsE51wbHZeSMZdZ9F30zMHNE8CLguADA4ZBerautMll7gc7bO+OiW0uQFWyZ8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 16 Nov
 2025 15:30:50 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.013; Sun, 16 Nov 2025
 15:30:50 +0000
Message-ID: <25f88a18-5819-401e-ab4c-279d4b67f468@nvidia.com>
Date: Sun, 16 Nov 2025 17:30:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix spurious CPU wakeups caused by invalid
 CQE
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b95006-c3a4-4b07-83ef-08de25251f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkJXVDNzMGxpMVV0a1ZvbTFJQnMvRkNpSDM1dU1jaDQrb0QvU09WS3pEOEJL?=
 =?utf-8?B?YlRqTXFldmR3MHN5THArSG04eWJoSy9lOTg0SGZHVndlMTUycDNLeTVmRnhv?=
 =?utf-8?B?dmVnU2VnT1FQK3o2Q00zZ1ozd21COTQ5UjJKRSt0aHBBM25yeHlZUnZHL3pM?=
 =?utf-8?B?ZkpSc3FyL2NSUkJTMWJ1RVJ3V3M4djZmZGlTK0J6cGlRVGpVb0s0WjVNQ0s2?=
 =?utf-8?B?MXVBTXJSWlJFTzFWUUFHMzZVTnF2bnE2QTJrZVdGd1M0OXRrb3hpb2YrM1Zn?=
 =?utf-8?B?NTRmQXVxdDlCSnNEY1NHcy9QODVnMkJqdVFxeGdNNjhTR0FRcTIwdXNUZVM1?=
 =?utf-8?B?ek0vUFhzWGtHb1llSWI2K09ZVkN2SUxOYlVERVZKSXNuVWY0empNck0yT3BB?=
 =?utf-8?B?QzFndDZueElIalFnSGNIWDdRTWVucndTMzZmbnM1SHNNaFhzRFR6OU41KzU0?=
 =?utf-8?B?VEZDM0tPM3liKzNSTWFac3UzKzF1M05lWmh0TU5kSHU3RDBNTktFNVNkQ1VG?=
 =?utf-8?B?NURYUzlZd1Rnak1Cd2FJZEsyb3VqbzMrWjE0QnlYeVJFdHUwdHFSaEp2T2xC?=
 =?utf-8?B?bDFNTCtxL0h5cHlRcy9FYTliKzhKNnB1M1BTWVBzdldQbDVIYUEwWGZKSzJM?=
 =?utf-8?B?TFNlYmhONmJrdEEycU5ERG5VQnhkMGRCdzhTZzU4clJRZFpFU04vWXd5OWpM?=
 =?utf-8?B?NkgyQUMweURjM25lY0tGdmUzbGZWUDdKaVVld2drbHhZS3VjUjRBd21nS3Zh?=
 =?utf-8?B?clVheUNoMkdITUtVck5SSmlFS1BrOHh0U3M1MklHOXhNQnhHcDhxa0pjMHVB?=
 =?utf-8?B?WEdmNnM3UnFTenhiTldMZ3VraHNXMWxMT1pUcW1QN0lwMUNjWDJhOEE2ZUcx?=
 =?utf-8?B?U2JtTnNISnRqTUl0UnZZc1pWZ1VDUWdmUm5WRVBlR1EzNlgwTGtCczhNVVhI?=
 =?utf-8?B?L3BmL1pnN3VvY2o4bkQ2bkpzYkpVK1EyTkdGMitrWThFREFhT0VkbVhYeTVh?=
 =?utf-8?B?UFgzNThpR3gydENYK24yYnhJSS8zdGxoQWQ3Y2JXR1lmazNXT3Y1a0FDaFVx?=
 =?utf-8?B?LzBXRjJHMkNxMnE1QW9CSDhYd1Yzc2JPTDA5TGMxKzB0Z1k3eEF4amYzajY1?=
 =?utf-8?B?SFM0czJLUmVLaTR1c0RwN25DWlExTUhXRlQzS0dvZEdyZmYwVmNwV2NzZG4v?=
 =?utf-8?B?RG10d09GZFVKWDllZXo4ZlJvOTlhVG4rUENuaDhGcUQ5cVhSa2ZwREFxQVB3?=
 =?utf-8?B?OFNLRjRTblBVS0ZBZWJBNGk4dEFnMUQ1cjdDUXZjTmhWQnI2eVAyM0xoVTY4?=
 =?utf-8?B?UFhSeHI5T3pHdDc1TERYK004K2MxM0xhYVEvMitSYVpIS25COXJlQ3pOVThK?=
 =?utf-8?B?Z2hzT3JZVVlkbU51ZHV2ajg3U3J0Z21LeTRBQnptVytQRG9vNjIyU2V2bDg3?=
 =?utf-8?B?Vm9qakJucHR0cXJqNW12eVRMNExVWFdiYm9UVW9uSXcxMmM2LzNPdjBuWUxV?=
 =?utf-8?B?Z0M4M21hZ0FxU2dEYTJmNjV1UG5YZGMzRVpjd2s2MTNETkVQYmtkcVgrSW5a?=
 =?utf-8?B?RnBySyt0Z1NPaHMvcUpEK09SUm1sbnpxRU1VU1kvRDFDZlh4U0VJQlcyUm5u?=
 =?utf-8?B?YlQ1T3BIOWx1Ykw1VXA5c0Y5VTdhNXFpL0I1MHVuZTVTYWxJMHBZMVFoZ0ts?=
 =?utf-8?B?V3NKb250T2xIVlhqYkpaSURleTRSNGx2enlwMEoxYThRaGJrSG5rT0tJQkVl?=
 =?utf-8?B?VjY5clo4L2FTcyszeUdTSjRkd2VyVFNwL3RSZHdMSUJoN0l6T0p5V1BnajFQ?=
 =?utf-8?B?ZmZQdmd2M3Q3WjQvQ1hJZWZXVE5SYVJyRkIzUUdxVVdiTmVJU3QzUm85eUxa?=
 =?utf-8?B?K0NwNEZrTFlNNEV3YjlHTHFTRThqNjQ5RmdDZDJiS0NUelZ0TEFyUTBTVkdw?=
 =?utf-8?Q?iHJDeY4M7fkt0zWx4Pb8cGngOLSnAzuA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9zS0h2aU9DK1FUMW8zTTZxZjdyY1lhK0VvbDBtK0NHWmdwQ1NSTFlPYXBH?=
 =?utf-8?B?VGprYmF6dVFkM1ljODdqd05tMHByWE9kZEp2QzZIdGlveTgwdHZiRjdDVy9x?=
 =?utf-8?B?bnF2ZmdEQ1cwcFdoUVVWYUtWVDArL1A4NEdwVkF0U05mQkdlM055YW1nYnBv?=
 =?utf-8?B?Y3VWOHU0M0R0QjhUUHdNWjdvdDFOTEg4eFEwbUo4VnM4ZVY4QWczRSt5U2l3?=
 =?utf-8?B?d3J2OGN0SjhTQmI1SEZhTzNlak12Vi83VEpkUlNhS2pRUlg4b2JERW9MYVM0?=
 =?utf-8?B?UzBDSGV6TzJoZG5nUnhZM2lTS2pBTXFNVFJ2bzBxQ21yaUxnZXJYai8wVXlt?=
 =?utf-8?B?d1dWdUg0Q0xmczZhWHpzdFhoYXpUT2hxbGFMY3h2Mmw0ekp1RkhqYm83elNH?=
 =?utf-8?B?aGJoMlZNYVVFQWFmdDNWM3F4Y3V4NFVzK200VjQ4R2JndmRZMEFTTEhpWGRj?=
 =?utf-8?B?anZKSVNnZnRza0IwWC9GOWQxTE5COVN3SjNvV1VXUFRyaVcxc0pvd0VzM2Vq?=
 =?utf-8?B?b25KUDFFWlRRL0tRQVprWEFnTU8vUmdTZ0tpcnBJb2NWWGRCTm1IN2cxRTdP?=
 =?utf-8?B?SnJITmQ1ZDAxNCtxbkVKVEE4aWp6R3VtTmVjZXZlYyt0d0JCVGtQdFQwVnRp?=
 =?utf-8?B?dFlDRkUyTVVHNy83RXNOU21QN0cxcU1kYWxEclpsaUdrQWNwMVNVVTdGQVdW?=
 =?utf-8?B?YUk5aW5xeXN4RHlKY0ZMdTEreXdjYUVQQi9qUVNaVHZVMTFhSzRucktyZGlX?=
 =?utf-8?B?cFg4dHJnWXBSOUZrMDNWRzVEQlE5UGRQeUJBS0NoNUE2NlE0blQ1dDJ0Vmly?=
 =?utf-8?B?RUFRQXRJckk3YWdvMFE3QzFOODJweDhscXBvKzFrMUd4WEJDNmM4NGRvZGNH?=
 =?utf-8?B?RXk4cG00ZU5uU0JENjJhMTRmbnUvbWIwVmttanMzOEgwdkRRN1g4U3Q5VUg3?=
 =?utf-8?B?YzZZS0pYOTZ2eGQ4cWh5TkN4ODRET2ZIc1g3TklIY3cwRkJaVGJtNkdyTHZJ?=
 =?utf-8?B?L0JoNW12OW9HNm1Oem1uM012alk0aDR0ZTRNZ3czZE9YWGRBN0NYZVRFeStt?=
 =?utf-8?B?Ry9zWVc0Uit0Nm9Icnltbis4NG5LcWNNT1R1Vyt1TWs2NGFiODZGMnViMy9r?=
 =?utf-8?B?VTBsMEV3aEcySDRiYUJCc0l1MlZMQjFhWWljQlNMQXFPU0VNRzJHemduR091?=
 =?utf-8?B?bElzd2xLR3Jaa045Y01rZzZVbXh6RWp6dndrb0dQRnBDeDQwcFRmekhtdzFU?=
 =?utf-8?B?TE8ySzhGMGpMUEw1YVZDdlVsQ3AxZzUxNzMzTmx4VzI0Qm8xWjZoeE5ONXVX?=
 =?utf-8?B?RDA1YWt2ZC9FYUNrcjlNT01EemhKWU9BaDJDQ1pRTGdRUDhVL1Z5emhubTRO?=
 =?utf-8?B?bWd3bW0zc1p0SGFZanpIREtzd2d1T2hobUxaNWVkK01mZTF2dGVCd2pOdWE1?=
 =?utf-8?B?QkdEeFdrSTF6bzZCWDBGT3ZSTnU1QlZUN1pMNkExYzIxWnFqR2kzV211SXhR?=
 =?utf-8?B?Z091eXRNWjBTU0ZIYWFNekk2YjlLSSt4bWJoaG9TWkFpSEd3TEN0anZJTklJ?=
 =?utf-8?B?clhtUTdVY0ZPY2lMU3ZqdGxBd1hOY1lYdlR4bmRQY0YvNlM5L3FxUVZUWXIr?=
 =?utf-8?B?UHBubitOOVBtL21YOFUvcHB4ZlN2SXpLUFVXU0pjSm5wbzhJRG92VHMrZXJz?=
 =?utf-8?B?bGhsNTN1OUNPbGdRTkU3L0Rjbjc2cTVDazhpU1VxcFlXSC9kYjVtbUlHWU5G?=
 =?utf-8?B?ZUcwL0tDYU56cWdBVzB1MFFXYUFtNTBwaFhkTE1hTmRzNDh2MmtZM3ZUTWMy?=
 =?utf-8?B?bDJ5RXpvZ3FMZTZjWTFqUFBlQStvRXdmaTBhTFhEWDlwSjhOU3NvOGozamlL?=
 =?utf-8?B?QU9JK1BlYW81UGtRb2IzaDBmNlUrcFNrTUFOK01CMTVGM2g0U1FKbVpFVnFB?=
 =?utf-8?B?RDNIR1M5R1VHcXZsQ1RrUkNGanM5cVdhK1hqRUNLbGtaekNXYlhIQWtwWWtD?=
 =?utf-8?B?M3JQVzNnaVhsdDZFcUtMaVFuc0VkakFLQ2ZUdS9TRUlINUt5a242VHduMFJ1?=
 =?utf-8?B?N2ZOMFlNNTA1VSs4K2p5c0Fpdi9ram1pckFJTGJlRkFQeWZFWDJGNGt1ZFlL?=
 =?utf-8?Q?5c5OwH0UpOFwhHhl4L79yOXke?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b95006-c3a4-4b07-83ef-08de25251f04
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 15:30:50.0084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfoDVOm6xb8Hxh+i97ipNPtA1KjwYRsJNj6nDrcoNaq38lUeqyrIHZ6MEqtYMQ+yJbrhyxgmoj3S3zYMRH3JTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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


On 11/11/2025 5:40 AM, Sivaprasad Tummala wrote:
> Previously, the PMD used a common monitor callback to determine
> CQE ownership for power-aware polling. However, when a CQE contained
> an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
> As a result, the monitor condition could falsely indicate CQE
> availability and cause the CPU to wake up unnecessarily during
> low traffic periods.
> 
> This resulted in spurious wakeups in monitor-wait mode and reduced
> the expected power savings, as cores exited the sleep state even
> when no valid CQEs were available.
> 
> This patch introduces a dedicated callback that skips invalid CQEs
> and optimizes power efficiency by preventing false wakeups caused
> by hardware-owned or invalid entries.
> 
> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> 
> v2:
>   - Updated CQE opcode check logic — replaced XOR with comparison
>   - Renamed variable match to sw_owned for clarity
>   - Updated CQE ownership check order

Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

