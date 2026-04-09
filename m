Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0819E9DE6B
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 08:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8FBF402D3;
	Thu,  9 Apr 2026 10:40:55 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17]) by mails.dpdk.org (Postfix) with ESMTP id 99CB04028F;
 Thu,  9 Apr 2026 10:40:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHf2seg4buIbiiYe4mmh78V42mFkDZWRYdwzbUXVQOwlp0GJtCwtnDSvfBQc7RIUCLJCh2fbpsfg6x7BaDDNyyQA95znacM0eSxumBsqMLqgQNcym7qKE/xD63Jb4OPJQMrqMW968pnIdYY/bApKVE+hFqG82nhOvTe2C0hdAC4TEuHiuY6pE+hIyW7tKwgpXdIz4CFp/3nGLXHf+KnmrnSJ/z7phEli2B6iN4jIUMz5EzbTa6g15eCq0hD6DLrlvXM7p12JHo2BB04xatYhN4bxWdCc5/Z9+4ih7xTXjNZoABh/hQco+kWqsqnwWPrWMP09bXzeBiqsAGfXbBMfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfaQioteiD7EzkbNMlfgwDX60agROxPnMoKi6w2wDQY=;
 b=XXjzoA1t3HVNY1FhfmjmxuVusHX0B7MwgZRVM3OQeHIx7Cz4Lv2DXTq9UOPYoOmvvHoRgfYCaXaT5vNWwL604Wi7ZLiZNCIDsjOWDKkMMRi4E2gJB15yujESBXv+pK/65AObY638qNlJMGw/vkHT2Vvcum+DZ3109aDsHWjYfTCnBwDwFqXl2ds0Tuo6eOhk0zKY/iHHtLsTQr0oJR7jK0+KcbHV/oSGrcGWv8w10XCEyoPPZ3NBs+TJ3DZp/DGUzxvoNLQs0+9vs+O6yEzL0FgJbTtROw1wyb4YXphmH6+G5WVrZkwG3TAo0NckawTl6S3hx0QaiMukLfzbdP/ZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfaQioteiD7EzkbNMlfgwDX60agROxPnMoKi6w2wDQY=;
 b=ngwpWfkpiutj0WJRnxLc67z5y8xUUmTGRBICf4HFY6KIyCLFxepd5k09z5lSKbLdCqYg4CJ+5OEdh6dZJGIz3ODw3adbcU5UwFc+do4AqJgy+8q4saNNPhhMW1bMgGzHzGLrFCjRwZNcwP1yxfPFOWZbgdndq47OXEF92M6mnlDm+25k4IvyR3JgYULpiTktNdjt8bw9zEN5W/KaGxUO3sogLKt0FmXuXLtjY1SvfhONwWNf6U6PNxkGcV41831i36TiV1HJ52e1wi00Q94UsKcQLvHcsWg6t7/o8UgsLfVREo+Uzp+qrd81a4kqSBQoUa7k4Cc2G9PORbqEthWwNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 08:40:47 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 08:40:46 +0000
Message-ID: <d6c2aec1-21d5-4ec1-b969-3bb040a8db79@nvidia.com>
Date: Thu, 9 Apr 2026 11:40:40 +0300
User-Agent: Mozilla Thunderbird
From: Raslan Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix skipping PF representors
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260407103130.142440-1-dsosnowski@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260407103130.142440-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ba6307-c63a-4cb3-82fa-08de9613b195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: zfyd5Y/HXjyQFEoVLI8tmotB7ZXTHSzmKsPFLumdjjSlN4yrWmucGUATAa2QbAvwZp321C/SH+SznG/Xbrc/4WOMih7N1mhHq7gc9S+hUxbb69pVF0/UqvV1BOBg/ZXcFawemNZPZikPuUsrsQqWISniNSkbrPeSjvFQhlKyuX2OaarnD310degsJ/uufxcSPrKrXEmFHuCT36RE58x3bDZ6a7CiErnv5OBxiJg8URVmVVBMWErCjwo8Se1iz8gw181fXwwAW7ihuibrZ71Khqc2jAb9G3lof6hTmVIwCS4yRwCdzYfdxLv4eQv9T2TtDxJJiPcqQhRxyiF0pVPxKlwcSW5rJxe1kVO60CRAXMHGQMVrJVkKumFDVCSaKru99/pUp0pr8wYS0Eve7Kr/NIxBx/B8fFUq5koMIuUm2RXjfRAMrjNKiQ16SLyDcXsx5uZrnY0ePyA8xKkZqV513SR1hbhs6YviPwtaAnLsd82r6lkjUXPRCDR+K9yx9mpH04UOchG0cv+O+8ECV6w69sWelY9tdYjV7+NHueWvPoGK51M6YBxePZwAPwbw+hiuv8/1aYOY5MghmyTCS9QZaunCXupSvC1KfciTXbVlUw4M44cEjuTss+4QJ7lIjUdkakXkP0nQphb0aa731AZHA7Mn43KBg2uxOqneCxgT4qIRj+btImFs5I/K4yf6jPAUIayiSIRiHh/CGgxGLjNu6P6RCcvRVw9BaZglq7tVS7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3R0UmhSWjJ3SEpuVFIzT01ZQTZJVG9mSGgvSjJabkhjNG5QcTFubGtJa2M5?=
 =?utf-8?B?Q2RWb2FGWmdNMC9MNVg0NlU2VVp3L0tLT3k2RHpFQ2g0M2xXdHhlT3RDZWhE?=
 =?utf-8?B?NWcrS0xsRHBCa0txdDR2MWluQlNrVmc2QkF6VkhrWThDa3IyMzRBc21pc2tE?=
 =?utf-8?B?c3dZd0FzZDVDVDI0bzQ5V3hMbzJRWCtzR0lnRmF4NlVUbFNsTjNoK1JlNitP?=
 =?utf-8?B?KzBjUXJsUGFhbVlnZWx6TmpXTnI1dXJKR2ZJN2lNWUszQUxWTE13ZkFPRER6?=
 =?utf-8?B?K1pCSHBlQ2E1YWd1SmIrNlgrWjBkQitFeXNmc2ZiLzdDSlZNZHMxOFFSSDRx?=
 =?utf-8?B?aVQ1WkxTWFdvR2VXL0UxZVNsK0RzSWpnbmw0VEpJWFUxR3pjM2lBTkdQeU04?=
 =?utf-8?B?Tm5pSklpd0xFYS8waHNqblM2MFMxM2d3Mi9kS3ZtaHU5UW0wcVYyL1dackxC?=
 =?utf-8?B?dUExUU0wdzViWExNT09MTzk2QXBaRlpqa1RCTGJid3BDdEFCRU4wQzVOUEhL?=
 =?utf-8?B?akhsaSs5VGxvU09VeDJvbFIwOVlSSkZzRU5GMlYreng1QUF5QVFPaE5aQm1l?=
 =?utf-8?B?QlJQZGFwM1pvN1haVDdLVUdCOE1LUGRLRkdGcTJ6ZVRiMDEzUi9rREdwTHR5?=
 =?utf-8?B?TnhNUDFBdFRwME5YR0xSc2lWSWFKWmJidXl1RytabU8vTlJqSTlFT1AyUDZT?=
 =?utf-8?B?Qll6YXhSYjl2OVp2QkJXUktiNFRQQTJYamN6UDlIdkIvczl3WTVqWjdXYWtW?=
 =?utf-8?B?WlVYZzIwVkh1cVBLbDQvdGcwcjEzKzZRSTF4S1lpWnErdXQxenc0SnNNUHNE?=
 =?utf-8?B?ZjZQR0QzS01LUzZ3NEZRdXJkR1FhNVF6YSttQmFuZW5kWWVYeVVRaTZNNVNl?=
 =?utf-8?B?ay95WXhtckgweUVaNE5MaHpMTUNGR2RIR0dWMkhKV0VqRzdXT3RCN1VjRWhh?=
 =?utf-8?B?OS9wMTJIdmFYM2RCQlRiVlBZdGJiekhPYVhaZkV3T1NXTGZlYmhYRlh4S2JE?=
 =?utf-8?B?UXdQWldMNjhSY3pJRDV1akhkWHIrNkU4RXFhbnZxZmFiZ0xZVUg0bmV0QTdL?=
 =?utf-8?B?MUFNYUt3T0Z2VURPVTBRUW1WaG5EWkFNWTZXOTArWW04ZVQwTE5SNzYrR0Y2?=
 =?utf-8?B?dEwyaThVL0ZzeHkrT2gyNXdqTHpEanJpeTFTSjNLNzhreVU3WnpmTmpQUHU4?=
 =?utf-8?B?bzBSUFJVRE1xTExrb04yVHZsTTBHVWhxaWFMaTZ3OTBoUXF2cWR2RlQ3L0hJ?=
 =?utf-8?B?azRJN3FoMXA0ZXYvOWdsV3hGWWtJSFJDMURJak9jY1V0cmdBYUdPYlA0dEh6?=
 =?utf-8?B?UjRKTDl0TW5EZlY1U0VsSkFJZ3U0UTNtNWhNTXJIcGIzWDEwckk3RUpkSWR4?=
 =?utf-8?B?WlQ4aXlzaHVsWVRSSG8xdm5hZ3ZXdVBEblFXQXp6YzhwTlNwNzBicThzNGE0?=
 =?utf-8?B?bnAydi9VL1BFNWZoRHNWd3BUdktnUC8wVVl1VDBaWG84dWJ5U0NFdTM5NllD?=
 =?utf-8?B?VTF3Tklhbmc3bXZIdDNMNlB3Q3JNYzByRkNjbzR2emQwaStPRGFyQ3BLYUFk?=
 =?utf-8?B?YUsyM0J5VVIyUzRORUpVaVZ6WC84RjZRTVFXNnd0SCtFR0tVdnR0blhJR0g3?=
 =?utf-8?B?SUpRUnJseEd2SU5HUXFWNEsydmNpUEt5RkVwL2dJWU4vVkU4Y3I5T1U5dGdz?=
 =?utf-8?B?YmU1dk1XMDNjOGNoUlBobzl5ek4vTkN3cEVwQWx1dzJlMGRFOUR0Sjd5TXhr?=
 =?utf-8?B?ZmlxdE15UVhYbm9DSDVDR3VMUTlBQ05hY0lTY3E2V2VLdTlaTmIza1ZKaWpo?=
 =?utf-8?B?aUZKRkRsTjNOR1NwYWkrWmVuWUJxL0FVVXVXTzZJamgzdXFhdVppc0Z5SXJQ?=
 =?utf-8?B?K205RVJJOGZ2YUplVkcvdEtxOFRZUG4zZTZaNittZkdSRWNtR3ZKYlVQMFZx?=
 =?utf-8?B?Tmp1L2lmQ0N6RWdkT1RBRERhSWpPYW1WVHZ4TUVtWW1XRjZGMi9WalJYclVl?=
 =?utf-8?B?ZFRPUDRlOWUwWmJxd2doN0M5YVFGNUt6TGpmOWVzOVVmUzFZVVhpRE1iYXM0?=
 =?utf-8?B?a3RsRzJlbVJiZ01zT01KNm00cVA5WHJkUGJGekFCTlBJVS9GN0ZSb2o1Y2lL?=
 =?utf-8?B?Mm5RK0ZHRkZiQ0dmek9PaEVaUE55dkhzZlpCVlZHMERoMHk3KzZaUzRIM251?=
 =?utf-8?B?VWRXM2NuUEtRZWFFdnJxUEVOY2hGYUtiR1BzeVk1K2hHTnNOejFGbDNhM1RF?=
 =?utf-8?B?SlpZcVA4eHRva2lrZjIrdWY2NlJMRHRkM1hFeDFWbjZKaXlYaS90NDZxVG9Q?=
 =?utf-8?B?Q0MyVnBYNUR0WkVhVEdYb1AwRlBDWnN2ZzNIOElZdVAzSVdCZjh3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ba6307-c63a-4cb3-82fa-08de9613b195
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:40:46.5194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjBRTHZ67x5wxdxKUmz++v64UxQ4pvwymSJa5F8m+zofGARjYvdAxF+7pz3EEEvl0ee3RCsY4LSA0/yN7WFxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741
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

On 07/04/2026 1:31 PM, Dariusz Sosnowski wrote:
> Offending patch changed logic of matching IB ports to requested
> representors in mlx5 driver.
> Each found IB port was matched against all requested representors.
> Whenever:
> 
> - requested representor was VF or SF
> - PF was not ignored
> - IB port was physical port
> - physical port index matched requested PF index
> 
> the physical port representor was probed.
> If any of the above is false, mlx5 driver should have continue testing
> other requested PF representors.
> In the offending patch, the representor matching loop was stopped.
> As a result, if mlx5 device with MPESW enabled was probed with the
> following devargs:
> 
> 	-a 08:00.0,dv_flow_en=2,representor=pf[0-1]vf[0,1]
> 
> Only 5 ports were probed (physical port 0 and all VF representors),
> instead of 6 ports (physical port 1 is missing).
> 
> This patch fixes that by continuing representor matching loop
> on physical port to PF index mismatch as described above.
> 
> Fixes: 2f7cdd821b1b ("net/mlx5: fix probing to allow BlueField Socket Direct")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

