Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54307CD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F201402B6;
	Thu,  4 Jun 2026 11:32:26 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by mails.dpdk.org (Postfix) with ESMTP id 119DA40270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:32:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAPw3f+gxOBuM5hwPFrMj1NkGYFNRbCN7bxbDbLdhif2tGPQFaIDYZWyd6nVXPzb9z0pahKBq3122zFlcKE9pU8vS6jjrWlR3078kV5zRxtE1ci7bNTZWzfhOBSF8sIG7bTYeVnxJXjwFIWGjmhzp3jcq5Fp35XN07iVPBYidUj4IEgJ9UXy3c7cJsHA56sEaL4I3DTg51+HSfNeM/UA36GqPbLiQiYB57IJuLZkfFiDhenjYq3mYjkld4YCfDqjHL2B8gqPnfeLxtc9S54g77eQb2Tyhv2IicnZm6JZcXIlszywAniB6NHK2TL+lfnfKVMvyXrmpUVE6ogWv2EJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50g3n4i6jARmNfj+oFvqRH2srQ1JYPXN8cTlmsgynr8=;
 b=WUZaI7ctWdSkgUDOWWA3zBNCUB67Rvsw5UtlOU2YpYgXjN8ORkPUI/9UoiMWM/6A0szaHjVreSwYheRIaEP2yy4l9QIILeHQ6puWjZFeczPVkB36kYcVvuT5TsRtw33zw1vNxxXsNVkOfboUV1Y73iYpRoka5xfAO22pv66/we/oS7qJGDhJkTu/ZHrcn+vJkISwF54yYkhYz8HxmuMnhykLN4xPl2KREqixuxtse6aKlK1VUC01TO5j7E5tTVMoDI3gpHlFuFpqYd54sxyQ0nHZ/oxiczUkemNLtuinDYzExfxKO4yb6/jqy1ZKZ70wtBFdx9ztiZ5/4V/bPCSaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50g3n4i6jARmNfj+oFvqRH2srQ1JYPXN8cTlmsgynr8=;
 b=ls4ZCBkKnUDNa8blA3UqnFGmLpUeyStWNisXcze3E3J3y+R7/5kUNo512tfIqHtiP5AR72tW272rzZV9fsSWsGOKItKK8ZZE/sGkImvME2sEwx1A7BwDqq0Rih54QdDI8TmHSL53hxz3fSRqUqBlvKOFhJP1W42XQfCCoZ4Hm53jw4420nULuaJYP7qp8fi+uo10nyCGpnTJl2xdFTOuMj1HNbYQvv1R7i5YyqaPY7K/qIPBbjTM8Bbi6oYBcM2e8plrjPYdxj4MCR4fZEH4dWwEchQotl6BOT2zH+/YBYVpBLsWJg4Y/qNcrOO1yZ18qzq9Mk4V3qkev297BMmCqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:32:20 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:32:19 +0000
Message-ID: <4090795c-1abb-4483-badc-65f32e89703d@nvidia.com>
Date: Thu, 4 Jun 2026 12:32:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: add validation for indirect actions
To: Rayane Boussanni <rboussanni@gmail.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com
References: <20260417222104.66543-1-rboussanni@gmail.com>
 <20260514193359.195017-1-rboussanni@gmail.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260514193359.195017-1-rboussanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e12cf3-96b3-4cd3-ec3e-08dec21c2c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: B2EevmdykxB1f6CGXqKimJ4f0sLF1rH3+KbxlqCNdZW2oq7z71uN5Ul+dhNw+rzU8MaUi/gDdsY49iSyetmq2iJqd7qIP7SLE7wHLwwOfatYVjufqRBpBXwyGWJZw2huW+4u9cWgNsqbO/eT+uU9Isg4+q0SbJ6mIj+/UBHxWlD4a2SEItTqCb6jja6Lp7/Cejj1PJMrYybYLXFrBYdHJLQvG2nZfYAAB0pgfEBvIln/9JK+TgAmuB/OoRjMs2wqIsFp0V9jPgFOp5MUtIYvG3JEKK+x6BNjEU2ullmFIUEC4JE6ug//wpwgZXG4bCTXrtlNTMflUHlfyJHlS5aEeVGcXmYTcQdgav1ymXF/1D8Mumbg2cio/M8FhoHhQghKBE7bTCWQXPS5lAe14Nfb9bgNXihB7/YRePuwFkGjIrOwpheAyTi5kV8KtaUii/W1r/2YzmdsBF8h9s+G0MvvimXU5nzzPLiG8GHsD6aswkqlA/sORiO8NX2bGtrnIIO9vJOQzWProH/bAEJM/t4Vt+7TxcY7BrzUuLFqHRyzKmtBwyldhJRIpE3MjOgY/FwHtc4EkhGF4jWpJpIZeXwIXXEq27yrrkMmyQhhCbkEBU/v20Kcd6sCqD9e2toe/LP6HbXBOHZkbvDGHqKZDerPbIPyOfOTBeJURCE07ZJcQBeKlaxzU9m7Oq8l2IzfHga+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXp1NmlndjFMQ2pvaytJTU1FZXNFRnBVN3YxQTRUYnQzUTB0aWo4NHpuaUM0?=
 =?utf-8?B?ejJCQzFsYlNjV0dyUHRXbEdhb0RPNENYWWpmM3pFUENGM2RBc2VwdHBIS3g5?=
 =?utf-8?B?Y0ZzSS8wR1dhOThETFIzeTdSZ1J2MWp4ZHFwRXZQb28xckVNaW9sVi9rRFdx?=
 =?utf-8?B?UlE3eXNzZGJ2UHV2YTJheGJvMnJqV2ZLdDRLMjQ1THhyZ1o3djFxZzlBOWx0?=
 =?utf-8?B?aWJtcStGQWNsMEVWQnVRRHRGa0ptdkNYRTBaYjIxS3ZPNTkzMFNjNm1rSVJa?=
 =?utf-8?B?V1hUKzk4bDd2QUYyMHhnbzNtWWNiMkhOWm5veTBESmNNZmFManFzT2dKTnRN?=
 =?utf-8?B?aEhNdjQ3QzNlaXZDQnNGZVl4ZFl4ZGtGenlLSjZZR2JKME1GV0pvdWl4OVBy?=
 =?utf-8?B?VlcvY1QvdjNQblVkdHJPdGF5RGd5VTBRbi9xc2tna1BnVGMzT3VTa3VWTU93?=
 =?utf-8?B?UExmenU4UlJ3cHlINXJGQnBWdkVYUW44MGYrRThHQUI1dG9JdmxtWndGUjR1?=
 =?utf-8?B?VWRnRGxBWVF4QkJraXlEQVJNRG9IZEJaMDdiSTQ4ZVFibCtxMUFjajdQL3FW?=
 =?utf-8?B?V3dHVy8rSjRLb1RhMG9qeE5jUXVSSXhqNFZBbXdseU1nUWoyejRqdEJhUVlZ?=
 =?utf-8?B?dE1XODdnV1F1MVVqM0wzN3Y1MzNWVERtZVprOCs4bjJWbm9UTEJBeE93UW9N?=
 =?utf-8?B?bHY1TGxhejVINTJxaDlHRXMrbVNXNFFLLzZ6UVZtNllFUVpWbURwY1RoMTRl?=
 =?utf-8?B?RzZJTmZCcUV3akdNWVI0SDBjckI1MHlycEtSVjlSWmtxdnZURGJWMjBuL3Nh?=
 =?utf-8?B?cVhsT3l2SUVMblNLMmY4MmtBcEhPdU9PS2tMdGVGYzFDZFdQNG1ERWNwNEh5?=
 =?utf-8?B?bm9hSXgvVTRSQlRscFdtSXkwbVZiK1crd3RWbXJ1UkNJbEtFTjVGMHg1WVI2?=
 =?utf-8?B?N21wS2pHYUZkQUJ1cUMvcjlsOFRkVUN0cCtGNkxaSWw5RWJCdXVtM0hzUFlJ?=
 =?utf-8?B?ZVFmaWhscm1oYk10T3drUEJ4ZGdZbHA2ekt6b2RGNiswUW1vOTVvcnpYYUw3?=
 =?utf-8?B?VXlPMnNlenh4SlhJTnZENnFJMitmVFllK0RaNFJDZVVxdkxPdlpHWWowRzFV?=
 =?utf-8?B?a25kOEVTbE1xbU42UXFQZGVEZndxVGJEQzVQbW10YlRhaEdkZ0tTUUFqM3d6?=
 =?utf-8?B?V1NHTVZRVlpTVXdOcklIa0xXUlRMV0JFMmR5UUhGdUtNV0kxV3d1YnlReHZx?=
 =?utf-8?B?NHJDL1lWYmFZQ2V4dEl4dUpma0I1UVM2WFNOOTVtc2E1NlVGa01paFJCSGRL?=
 =?utf-8?B?UnJpVmJTMVExaE5icDVra2JzYnZIMWQ4RlhYY09udHVhTERLS0VTTTV3bWR1?=
 =?utf-8?B?NUNiaktxMGRYRC9ubVlyTUxkQTJYL3BWTyszSE9yNzVtVS9uMmJGSE4vYkNT?=
 =?utf-8?B?K0tlQmJUcUZ3ZU9ET1ZLLzZyS1Q0SzdnY2lBcm1SeVJuUUFhWVdFUG5nTENP?=
 =?utf-8?B?MDNxTXJ1dUgxWC9ZT3pLaHBNcjJjVW1HV2lCTWlxZ044VCtCYUwzMDkyblV4?=
 =?utf-8?B?aDh5aUY2TjJacFIrUGpvcVJOdC9FVDBFR0tBcnV4TXBRN21LVFJvN0FKWHFC?=
 =?utf-8?B?cjEvYnlTTWQ4anplZ1Uzc0JpMEZSNUtmaGJDVldyU1RHeDBlWG1xVWRsM056?=
 =?utf-8?B?d3lTajBnVzc0b0dENjd6SHB0Ykd1VHA0aU1FL2FQeXhqN09ubmdodWxlUE1J?=
 =?utf-8?B?VnlCVUV0Y1g4clpXUFJKMFpsNDMvU2NQbUlzWWN4Y3FmbHNIWXViUFpHYWdn?=
 =?utf-8?B?WmJDNmtqUS81ZENpR3UrMjFveE9OcFVsTVJ4YVRlWFZBZHk2ODI5SFkzbkFZ?=
 =?utf-8?B?dkRjYWY2Zm1yZmorbkVZQ2xvTkdVanVubFVZZUZFS0NjZUY1TmFrenJXcUpv?=
 =?utf-8?B?emFnSVVUWnFQYjVPOU90MEl3TG9WZXVwbXplZUpzdE5QZW9jaVdYaHJjVlZi?=
 =?utf-8?B?MGd4dndtNFRQUFl5VXVsN1NQa29QclRZMXhwNzlCR01zSUYxbEZBK1c3QlRP?=
 =?utf-8?B?M2kwVGUra1lqMGRzbDFxaWc0T0gxZWs0VzcwOTVlSlZDbHFQWSs2OTlrZE5t?=
 =?utf-8?B?Mkg2Qjl6Wjk3UEtGU2NoMVc3eFp2NmRnWjlzU3BoQzNzdWhmRTBLTjg4ZWF6?=
 =?utf-8?B?RzlpdVhjMElCbDlIaWJ1eithU3drK3Z4VzYyOGtBVU9qWGpWdjRIeTZyd1BV?=
 =?utf-8?B?WE1PT0JLa29oSnVvd1NuVDFIWjNyUWJiWFMzNWJhMUV4ZHczeXVJenBuV3dv?=
 =?utf-8?Q?Qv5KV4+gRN69OZGb7l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e12cf3-96b3-4cd3-ec3e-08dec21c2c97
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:32:19.8909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBe3oCIVYZNKrN/beMjAMXvgnNe7u6e6aT3KX08DcE1b4Z+KwSSkMNYJkR3g5742KatW8m2nWOCaX2eqJdcKxQ==
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


On 14/05/2026 10:33 PM, Rayane Boussanni wrote:
> This patch implements missing validation logic for RSS and Connection
> Tracking (ConnTrack) indirect actions in the Hardware Steering (HWS)
> flow engine.
> 
> Previously, these actions were accepted without being validated
> against hardware capabilities, which could lead to unexpected behavior
> when applying flow rules. The specialist validation functions
> (mlx5_hw_validate_action_rss and mlx5_hw_validate_action_conntrack)
> already existed but were not wired up to the indirect action handler.
> 
> The signature of flow_hw_validate_action_indirect was updated to
> include the actions template attributes (attr), allowing it to pass
> the necessary traffic direction context (ingress/egress/transfer)
> to the underlying validation specialists. For indirect RSS, only the
> template attributes are validated, as the RSS configuration itself is
> already validated when the indirect action handle is created.
> 
> Reported-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
> ---
> v3:
> - Fix segfault reported by Dariusz Sosnowski when an actions template
>    references an indirect RSS action. v2 called
>    mlx5_hw_validate_action_rss() on the indirect path, which
>    dereferences action->conf as struct rte_flow_action_rss. For indirect
>    actions action->conf is an opaque action handle, not an RSS config.
>    Add bool is_indirect to mlx5_hw_validate_action_rss() so the indirect
>    path validates only the template attributes
>    (ingress/egress/transfer).
> 
>   drivers/net/mlx5/mlx5_flow_hw.c | 36 ++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

