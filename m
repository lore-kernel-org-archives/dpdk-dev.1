Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94681CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 12:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B6C40292;
	Sun, 31 Aug 2025 14:06:16 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by mails.dpdk.org (Postfix) with ESMTP id 6614640263;
 Sun, 31 Aug 2025 14:05:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3z1S8/xUtue0J9dl7OhRMq75BRuCKdAqG1/2lSz8qATLeHo2f3UyKnfKuE16tnJz/yKCpf4AntDEUErJ8aox9oRB54YkyEITGVYOry6blgUIwa+5pL0wMuZJyRUFMk/WRhsxuJg6P5IniK3d/s9m+hzdDyJSdPCRcbiyRA2TUSOFXKQ/5MGqvqCxaMxpa6oGrVI7oCohx22SWh7mOeHdWMbx+2BqN2rho8pfCqoUbgCk3ydoV95ppGDAQEav3yOIxVDLqAUgquG0Y8dWqt5duMCLdhLb+ecUIYcmOcC4Gwi6fkQxivwvKf7nf4RCuvuXcuzPsLzLa+qAWEcl4m5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6hvplLWl+23r1hjxqCqFCkGs95yJExswyEW7B9Lxok=;
 b=krmJheCb2+3d/nmyVl6chdxZJW308RcHs/EN8E0rSvtojcTbjCwr5KQemzmP1QcbWTUqzYH8xpCfECxhjPh0WEaO4WoHQf+PJ1qYXhzfVZyHrOBV8TOZhvKO28FRujIZ788GphxU8L4ET6gGUbTwhidsSMR/l9C0Rf/fod1AAnylHrMgG8uUK4zfw6OFFwcsZx5JymXVNmQee2SOudlzk8yQDzP1RLz1iy+ZYJ/Xlo8269PmF/03SLQrEldZcBl+5eNQ7V6bAEZIPOJsP7y0sVYxJOCX6J1fEfmP6STm5LWWbhFCEEu1nd6YTivvZ7YL5ElWwXDd5lGueiUdK4f9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6hvplLWl+23r1hjxqCqFCkGs95yJExswyEW7B9Lxok=;
 b=E7ZYHv7Y7rQvfYMwjha7Lx7Nksx8SK9yt8OxgG2dkxIRjncTCoV4PptNbJjrlDEc0gqCOIvybWZkLKQNfKdCQneDDFQUQ9brR+Z6wjtCB+LRaCvJzCqGFfVz/cOjcO+l/pewOQ7vmy/smlSdVxF+kr7h9Iayr+GSL320Pnpj/pLai9qXUqMBlfVy3GcQGMZZuev3/hV+xfmWzr0Yy9CyWvT0fiOD6Pcp/fV0m5oCDnDPGrQlyqqF06ZUtBcV+qfAxIlkwpn4P3wWfdq1mVevhEQcMn7FgyYMmTEjZu1/Hn2bepXhID152z9mMTMH04dH1yIRDrqONmJHraaZ/lTfwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 12:05:55 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 12:05:54 +0000
Message-ID: <7cabbc63-6a3f-41de-837f-a56c00eeefaa@nvidia.com>
Date: Sun, 31 Aug 2025 15:05:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix non-template RSS expansion
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250812100717.134263-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250812100717.134263-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 789acd3e-c4cc-4ab7-21d4-08dde886bc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTZlVllxdTFCYWV0TllXVURQRXRYVmd4Mkg5NGhtYXVmcWVvRkk5OFdENkhw?=
 =?utf-8?B?ckx3UERPdzBKMzVQdm5GUDR6UTlxUXRSdmhReU5tV05uZjVXTGZCSVVoejNO?=
 =?utf-8?B?eFdZMjNENW1WalZ1eG1rVW4rT2ZHeUswd2hoa2sxSlZ2MVgwTWJlMWpmcnUx?=
 =?utf-8?B?eVE0WURqL2M5c0NEZnROTnlUTGROajdiM2ZpZ3FsVjRWVDAyZmpsNElLdEhX?=
 =?utf-8?B?Nks3TkdnRVl1SHdFcGcrNEE3Y0hTQVJkK0VjVmxBbXlNRjgzRFJya3NNV2NG?=
 =?utf-8?B?UWVFUFRZNlNhV0dLNDJzaWl0WlNtZzZpYXhXaW1VY2l5V0tUT3JiVXUzS2Rx?=
 =?utf-8?B?Sms4aXB1OWVWSFBmdUZsSUkwd3E1V2VWbVo5aStKNmJuM2R3cEF4Z2JoQzFC?=
 =?utf-8?B?aElrcERKSXQvd2llMVdwMzByQ3Q4WUVRa0NvREI2VDg2cEt1YlAzNEx3YlRr?=
 =?utf-8?B?S3IzYkRMaEpHV0pXS1A0ZkRUQ3VheEJRdEZIbktveDRzMEJkVFNRa2h3eWw1?=
 =?utf-8?B?ZG9zT1Z2dklha1NIR3k2akV4RTZPMEZSK1VIUWhRYy9rNWE3YzlyTkFrby9l?=
 =?utf-8?B?ZVlUZFZNdEUxUGdPdlJzRUlEL05CSS9xVG9Uakhka0FLNWtEcGU2TlZrN2NY?=
 =?utf-8?B?RUJIYzdiMTZYNTI5OEc1ay9ac1pnbzAySmpGeDNsY1dyVURVOHhEckdoUlFn?=
 =?utf-8?B?TzNMRVNKUzAxb2dQR2crWnIwRTNnaW5Ud3IyOUxqWVl4cHVaVVo0Y1ZUVVFh?=
 =?utf-8?B?cldSQmpJYXI2SHdtUnNZc0htK3N1SHZLT0RBdklMWjFTL3BFNEpQUDZhWHZB?=
 =?utf-8?B?UkVvRDRZaWpweGxNMW5RNjhGdHhpaEFqemNvZzE5eHdkUFVkdlN5MUtnczBY?=
 =?utf-8?B?c3JXTHlQRVFkcVJOdk5GNE8xT0VMZFRReUxFNlVHcURzM0NNQjdsM2FMVTZn?=
 =?utf-8?B?QXdYK205OGtYQWp0Z08zQS9pelJ4RlhtTk9TOS8vRHNVMm9KRC9xeDg1RTB6?=
 =?utf-8?B?U0lobnhHWE1oVWtML0xhSzNUZys4R3dBY29xaGJYSEtBY1RzVks3d1lDcTNh?=
 =?utf-8?B?MS9Kd1BLYVEvdVVqWlNyNzYzWDVjcWkrQUk3aTBEME54VUxzVDBwZy9KazJL?=
 =?utf-8?B?TCs2ZUh6Ym1yQkdzbFJsUFp0Q3ErTVZNSlF6QXJNWHQ5K3FqdWdsODVFVTly?=
 =?utf-8?B?aWpDS1EreWV3OWg3bUV0cUd0bzNkaWVFZFU5Vnk0S2krWU9lalVZUCtLOGQ3?=
 =?utf-8?B?dVdRbTFUOGlLRTY4cWltV0U5cmc3bVlFSncySGJ3d3diejBYTjdUK2lSWkNC?=
 =?utf-8?B?QkpRZXlRNGR6aWk5aWlxeXdUem94cnpNOXA5Tk40VVZxSVd6RU5zTVBxemVK?=
 =?utf-8?B?TjB6UktKUG5peWZHSFFjbzVBUldQV0FjY2xzQjV4Z1VSd3VOYUQzZXNNa2dX?=
 =?utf-8?B?Ry9VbHMxVXJLV0V2L1FjVTBiZCtST2RsV3Z4eDB1eElnRW1McWIzNm5OcWlw?=
 =?utf-8?B?WDN2dFJ4YTIwa21SeW5IQkpWZmRLaU42M3lSVU1BNVFST01VTEZ6VFIyd1Mw?=
 =?utf-8?B?bmVYaWZIU0VWeVNJdFVDSmkyVG0yR2tER3V5VjVBYW1XdEREQ0w5SXRTZFA5?=
 =?utf-8?B?M3RhbXJLMlEzYlY1KzgramlCbkxkbzNqT3VXT2tkSEtjU3ArYzcrTEUvYzBj?=
 =?utf-8?B?cHBJVnNBR1g1VEUzVnlNMVFHNzNkdSs5RHBVNXk4QWpjTGZDTDJzaFZ3ZjE5?=
 =?utf-8?B?cDJwNTZVVlk2WDlyUjFmOVBHYkY0dzJGM3FvZG9GRytzaVpUREdqQWFXOXJQ?=
 =?utf-8?B?cjBEalRjamphR0NPbWRORjlNVFc3TTlCVUlERU5xRGZIM2tBUWNqV000YkMw?=
 =?utf-8?B?UkRTRDBiQXFrWVFDOW5uTDVGeTF2WnJsdkdhYld3MjBzdFhxQkhsUW44V0hm?=
 =?utf-8?Q?lKBvr7YyMXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THByUHV3TFJ4YWxpVmNtTWI0QkxBRFR1L0hQUXVLa1ZDVGp3Z3pYRVVCd3hV?=
 =?utf-8?B?WitxeVo0TWxoVFd3SEt1Wm45SkRUd25uTExkWnpscUxWTE9ReXM0VSswWitm?=
 =?utf-8?B?ZnpPTDJCUHZYanZDS3N1NWtZUGl4Slh6WEFQU3VHTjFKYThHVjcrL09VNkcz?=
 =?utf-8?B?bi91dVVkcDFXeUVuRTEzZ2JzVys1NWcrWktsUUVwWjlnL2pzL3pPREJzQnZi?=
 =?utf-8?B?UGJNbXhuMEovTGJ6UTRLbWxZTjJ4N1FyeVBBZ3FRYVBjdlNBK3M5dHkwV1R5?=
 =?utf-8?B?WXFGVHQ0T1dJQ1Uxa3ZFYWhkTjNsQ3phLzJUYm9pWUdubC94TDlBenBET3F2?=
 =?utf-8?B?Q29VVXF2dWxNM0VoaTVoaEg5MGtRQk9DMU4xdm4xbWF4R2ZVUkIzbmIvN25C?=
 =?utf-8?B?MFZjMDZnU2EyUU9aMVFrazl6MCtvU2RBMkxuZ29SQmZxNmZ6Ym5uRDZKUHhU?=
 =?utf-8?B?OHFUS1UvTWwrR1VhY3U4T0hXcGwzemlrU3BNWkVUL2hjcHJOQmd3TTNjaXRV?=
 =?utf-8?B?clBmZDVrOFlwK2gxM09LbGhKZjZmazBEMG9OaXh3R1Z2bHRzREprdUIyZmVl?=
 =?utf-8?B?bGVQVmJsc0xXQ2t0WHNVNzAydnZRWmU5blFUWHRvSE9WT29lNXkxdlp1a0ZO?=
 =?utf-8?B?Q3huQ0xXMHlhZ29xMVliZ0JRNFFZWG9mY1ordS94dEtQUFZOUlNXUWxadVFL?=
 =?utf-8?B?R1FldTJQSnJScjNhZk5XL1M2Y1NORVdtdWc0NGx1M0cvckVuRnA5YndSZ3Js?=
 =?utf-8?B?TVFRZHd3WSszV0w2VXpJT1hiZEhYaGVaT1hDYzR1MDNUc2R4a1J4d01BWFdC?=
 =?utf-8?B?UElIdDg5QXJMOXhOKyt0cVRHWUFFZkt1MDNVRnVZN2NNVElmUWp1ODFGaXY5?=
 =?utf-8?B?c0pKL2J6ZGgzdUZFQktOSWpMODFtQ29KdExnRDgzN0QzeWFnYjJPcDkwUndH?=
 =?utf-8?B?TlFGOGpEUjBUZ295UjEyN255bFRLUDVRQXg1clFiL2dwSDJqaDRGL2NvL25F?=
 =?utf-8?B?aHRka1VXMlVUZ3ltb2Jwekd4NG9xV2hWZTNobHdNcXJRQ2xCMDJjNnc4RHpr?=
 =?utf-8?B?QWV6Q09pcDQ2eEhOSWx6bkdlR1RPZ2QvSThmRVR1alQ5cmlvTVJlRVpIR20z?=
 =?utf-8?B?NHliRHZuNVJ5RnN4U2VReWhoQ21najRxeC85VFo0THVyR1Z3c0tvTndocHAv?=
 =?utf-8?B?UGRxcTFZcWhLS2R6dEdZdUhLYm9BYnM3TmxDU2hYdmJwNXNkbFg5NGF3YXAr?=
 =?utf-8?B?RGtEdXd0aEtjRVdtVGxwaFRodnNTOWc2RVBLVklWakNOaDgrUUY5dTVKTVA4?=
 =?utf-8?B?eWZzMVJnZ0hRUXFXT05NQ0tKNWNaaE1iVkZ2MGx5S3F1cmpVRzF5MHExNzRp?=
 =?utf-8?B?OHZwWTJiRjE4UXlmQWJZUGVQVmRZZ1B4QU8vblIzUnhJcm5mYjV6RTR1cnFq?=
 =?utf-8?B?dFRjZk5pSWZ2QU83OHhMd1h6ZnJwejJja0NFdlA5OFc0TXhpVlZsY2tpbHQz?=
 =?utf-8?B?dzh6bjQ2SnNVVXpsN2ZLNTBnOE1KZG5Cazd1WTQ1dVM5WEN5R08xUVdVQjRx?=
 =?utf-8?B?TmdtT3NhREtZRXJlT0QyVTR0bCsreFpJQXpOSGMvNFZYTmUyd1JjeFFXN3dj?=
 =?utf-8?B?M2VnenVreXVQSktxUTRVV1ZMb3M4VHlJODlJSE9VN3RzRU12ZDhVWTcrd2ha?=
 =?utf-8?B?ZXQ5L1cxNGo3Nk1NMlpVNVdzbnExRlV3MUo2azdROTNjNlQ2L29LWjM1aE1w?=
 =?utf-8?B?bVdGSmtrdFo3RGhZOWNXN0V0NFJ3S25YTG50TXQvbXBFKzhKTHlIOHI1emZy?=
 =?utf-8?B?TkFIaWZuOWVuU3dSejNyenQvczVFeDYxK0xjU09pR1VzcWc1S2RQL1VpZ3Q2?=
 =?utf-8?B?WDc2TWUvRnEwVktxM2dGa3BkbC9wYk5OVWUzaW9OdHk4eTY5dWozYnpyL2VV?=
 =?utf-8?B?OWV4ZzdHS0Z0VDV1YkxXUVFZTDQxWHQyeVRHSG9qbkpJOUVnTkswdkZZVHov?=
 =?utf-8?B?b3daK1FBVU9aVXFiNURaREVINjMzMmJFQjJyUFBTTDlnNEhvVjJVZ0g4Umcw?=
 =?utf-8?B?bEJmL3JQWWhpN2xqWEFCQ0liSmVUNnRKQjY1dEJuVUVFY0JkdGFNTm9LM0xF?=
 =?utf-8?Q?U3eUkkdtPf97fdwdRG3FLVQZn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789acd3e-c4cc-4ab7-21d4-08dde886bc58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 12:05:54.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiA/SZjW+FR3zbIj7VCCsWsbUuA8ofinvXwZ03AIcjzKTimoodlnnAFc01uKT9+daWyh/MFCML1kVs2esBKxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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


On 12/08/2025 1:07 PM, Gregory Etelson wrote:
> The PMD checked flow pointer for NULL value after a call to
> flow_hw_create_flow(). The function API does not define flow pointer
> value if the function call has failed.
> 
> The patch fixes error verification after flow_hw_create_flow()
> returned - a calling function must check flow_hw_create_flow() return
> value.
> 
> Fixes: f74914c9956e ("net/mlx5: fix non-template IPv6 flow RSS hash")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

