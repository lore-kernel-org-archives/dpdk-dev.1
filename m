Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA6C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6DD8402ED;
	Tue, 27 May 2025 11:01:36 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by mails.dpdk.org (Postfix) with ESMTP id AE0E8402D6
 for <dev@dpdk.org>; Tue, 27 May 2025 11:01:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MINkzKmK3+hMcp3Z3C6me/jwFYfVi4daMhJh8FjgrN9/TkSk5rpb0UfLUNPdiaU3BGztpaDpXMbRVJO6gJ5yIL3SjL/l+k8L/GRcHojScKBuBOfaBPJEfyy0beAAFyQj3Ym9fdUmPqFSW1qwNq1UCQvewiK23/FsmwmoDxKpxrmnxAjjExjW1u4Ss9rsK7IdEQo2o1IxiYvx/pE3uMX8++IOq3kv1cV9pjzzZhCAA0aYxY0cM7TaBEHGLtxaQZhE0hYA3z0JVzqKAMMngU/8O8ATtJqoBbQ+4yG6dfTKkNGakNJ63gaZHFZJQ6pHM7AtbRaaiPQhT2oaJ9hZyc8rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nO4nkS3UnS1miF7z8Z2UDRYyMLLlEboILu4sy1VsDg=;
 b=YxLX3SP7Jn+32rpOTu+/etGmJTh/KYDyNhvoz4oNC4J4mPI5UDpTv7h3ezcr+veBB49f53uM316gpeSHR9LxUlIiaauUL81pXmVunfL2umuqap/7wbP5AUQWlrm/632VtmwQZx4K8XLnQQTgZy0FXEELu9l+UiexMHs/MRsLGwAos/boYIHbl3B0UW0zzsj8wbVmoAbRzSPoPhbwIyzALHRgDeMnSQ0nD8+f28ay9GuQBeHNvG57CYw7JCOSNHqogyQfDNirW2Z/unaE3WAatYYWK2Krh3s4G/PL2U/f2d7v/9pjm2NxCU0v+Q9kr/B8WPvzPtiIN+LSPPDkebPluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nO4nkS3UnS1miF7z8Z2UDRYyMLLlEboILu4sy1VsDg=;
 b=O181SVC0AXbJ92p37fhQBzPlGoBXNwiW6ByJ66NVb/uo/cogQZtk5LqH7eAB1vCV2bz0ACM6Kkb3Bepl6S3el28lXexjZ/bNHzjFXQMWPBynZ1PlTAZCErMaMChCC8nVsAqwWrzIQSelayk/9qfNqALp2Q5ZQZH/X3IZtsHo6M9GEbKVdE4a3T6WjMjUUNmAgNcXONlD7NvDB/WbasKtmdeeGfmCjur1IK7Ua4AsWph9hq/7fBrNdsr7aGLuy95rx3rQZWq/OfMV+WuOlcKbPn57UbmV363cz0ARlTEUV0qUE9wNLhBrNPgOZDsrDTlPQU4oNyhVhca7xaQIbGBj5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 09:01:32 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:01:32 +0000
Message-ID: <a9cd4ded-a912-431c-8b50-9c3d90cd8c3c@nvidia.com>
Date: Tue, 27 May 2025 12:01:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/mlx5: read SWS capability bits
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250427111916.108276-1-mkashani@nvidia.com>
 <c50dfa76-8d39-4f76-b4d1-aa118e29f267@nvidia.com>
 <PH7PR12MB70184619A31E72598704E8D6B264A@PH7PR12MB7018.namprd12.prod.outlook.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <PH7PR12MB70184619A31E72598704E8D6B264A@PH7PR12MB7018.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c028fa-3364-4a97-1a2a-08dd9cfd1317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VSsrNmdLSDJ6MnJBUk44SkhETlFHUnpINkVraTNLVzY0bGlHNlVXUTBWVUcx?=
 =?utf-8?B?RHZ3KzJORDZRcmg5REJmdWJJNDFudjdzTS9VeHh5ck5zUVl4bm5kT3dFbStH?=
 =?utf-8?B?anVLNzZ1T1ZhM0F5a2NhU05ucFNsTTZOc0YzOHFHbEdaek9VMUtWRG9sTmRK?=
 =?utf-8?B?SUFzRkNMS0R5Y0hHUjk5SkFLSUlpSXRrRkU1eGZ4bjJITUZFN3d2LzU3dzBa?=
 =?utf-8?B?WHRJeDVrY0szRnE4NXk4K3NMSy9wWi9DNENhcXZHOGR1Sm84eUp0UkQxeGFW?=
 =?utf-8?B?bjhFclhsajMyaWNNT1V1VVdjZHRLL3RTdzdydk9hSDFubTVNUU9Hcyt6N3dM?=
 =?utf-8?B?VUNLNURiaklWUXpWelg4UStGZ3hmV0VLdHRvbnRWZlNqblAyQWlaRnF5RlVM?=
 =?utf-8?B?bmFGNDlucGo3OUw3M3hiT3hYUDV4cThsdHBtWUtiL0lLRVh1aGVCTXY5OFFw?=
 =?utf-8?B?bFlaNWdtb0k3a0NwclYrVG9helhUZnlDUFZkLzNmUWt1WEFya1RKbFd4NUh6?=
 =?utf-8?B?NkpiSGdISTBYQjhkN1hkby82Z1QrVnhQNDNsTTM2OVZhdHV4bUxQL3ZPM1BI?=
 =?utf-8?B?ZWdmNjRxcFBTcHQrS1dsZHBibG02Nm5Oa1d3eGovTFM5dHBCb29aSGZKcHBu?=
 =?utf-8?B?Ym96OEd1QmVxZzIvRTgzbTBySTRLZVAzNWxVdkt5WmUzOFJsejduamZzU0l0?=
 =?utf-8?B?amlSTEpmOTRQbzhhUmFuc3JtWWVIWFlyd0dOMVJEY2ZvVVJ6Y0RTMFUwdE1v?=
 =?utf-8?B?Wmh4dmxYS0Mzbm0vc0hJQmJXL2h2SkUwdHBxYUJFZkVhNndsUFdEQmJrYkZk?=
 =?utf-8?B?WE9TZlE2WURZWXlBcmhPZlMvanEveXFBWlhVTjVsVFJvKzYzWnNad1B1TmZB?=
 =?utf-8?B?aVUwOUZTdDljVTFreWZoVG5yWW43WTBWUExKQVc3SUZhRnkzNFI1RHE2QkZ5?=
 =?utf-8?B?S0tsM05PZ1IvWGdyM2JmY0Q3UW5qR1pNdEF5V01LWDRFMytqdkxDVGxiNHg5?=
 =?utf-8?B?UDlhSDJoMkhtQkY2SjFKRWNXRjNHeWpzb3JHcERNVWZHSWNJTjM2VTVzcTBw?=
 =?utf-8?B?M051Z0xoZzh0TE4rSGZyY2lndjNXQ2wyQ2EyckZmeVRrWS9rR1lISi91THdG?=
 =?utf-8?B?WjZKVXNiSFkxa0YyN2huTlB4YXlYOFE0TWpBREE2dnEwNUl5c3FXYURscUhG?=
 =?utf-8?B?UmNaU05VZU9WSVp1ck0xbHBISS85Qmp2SXJRVWFqSWVGNGdmb0VQVmpYQWhI?=
 =?utf-8?B?VExOMS81RzZRcm5yKzZZTXpDcWg5OVZVZmRmNEJpbzAweE0vVHYzdEViMkZO?=
 =?utf-8?B?SkozeWZnVXBncnlXYkw4djhldkZ3MUdKeG8xRjlEU29VSFJ0RnlzTG1zY201?=
 =?utf-8?B?bE93N2wvVlAvMGEwcnN2d1NkRVprdmlTMWUwM1NPRTRNYkxTZ1BEeEU5UGxP?=
 =?utf-8?B?RXB0Q3REYnBybTVaUmFMbllRSHVRSjQ1bGcwMFhWa2VxTTVJd2h6RFYra0Zq?=
 =?utf-8?B?TEhxV1puYTNkZW8rVFZucjcvWVg5c1AxRGdHRDFQNjBQKzV3aXhxSkZ3L2tM?=
 =?utf-8?B?NnpqU1g1SDVaNkdmQ1V3aUVWVTRFd1B4aTJKd2h3TzZwcHNaNlE1WDRiQmpB?=
 =?utf-8?B?b3A1Ujc5OWt1QVU3bktyOGVjT1pVVlNxM0ZQVGNTSFh4Q0R5RWROdUZPbDdp?=
 =?utf-8?B?Ly9sY0hxaGFUWGZCdzV5ZXpvWjNHSnRyaXVYUUVlK2hWWndqcmI5QWhhb1BZ?=
 =?utf-8?B?RmplUWtZY2loQVdsRHUzTDl2VjNGbUcrc2VJNlZOcjdJbGdPcUZDVmlHMFdp?=
 =?utf-8?B?dHRWOVRkSmVPSTcwV2JhdGwyRFYvQTVSY3ZrNDZTSmRqLzJCS2dsVU5JQ3NN?=
 =?utf-8?B?UWtmblBycjRZVVcvMWMxNXhDaFpTdUVYc09wVFNjTS96WU5DclJ0TEJYNHdI?=
 =?utf-8?Q?cBe6A3haTQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdxSXVvejZGc01rR3NKc1MzTXpqeUZpNzNSbjMweDZXRFQ0dHVkOWEvSkdN?=
 =?utf-8?B?dnFpT0oyZ2pRb3NWT2MxZ25uWFh3UVVWNS9NZ2pQVjErZWhvb28weUVPb3F4?=
 =?utf-8?B?OENmT1lNMXdOTklPWG11UlBTV3NyQWQyZ2JvNjBFekU0NmVGYytBQlVHLzNX?=
 =?utf-8?B?eFdlWHpUV28vY0V3NFF4d2llSnlIVHV5aGVvNmNmK1RVZTl0bFRkM2o1ck15?=
 =?utf-8?B?WjlOQmlheEgrdWs4VGR5Vzd4NDhDNzc1WVJYZE9LNUJYNXVIVDlHL2toMVFG?=
 =?utf-8?B?dGdpM041cnhFcWRjcEU2amNXTlVEdXNsOEFFNUduT1VSVjRYSmRRYWNPOGJu?=
 =?utf-8?B?N2ZHbEVJbmZLc05NR0tXWGYvcmE5RzRPZWVBS000QW1FU3FCM1JUZngxOVdU?=
 =?utf-8?B?aVIweWkrb3ZxeGphOUhvSVZnb1ZDSjdqaVBhdGlkT0xXM3ZNRUZ6enAwZUhl?=
 =?utf-8?B?Q1pLUlA2NEZzbit5RE5tbEV6SUhhOVdzUGk0SWljbUZ3dzlxRmdKdmxTa0F2?=
 =?utf-8?B?ajUrOXVXZHFZQW9YeEp2eEtOY1ZybEswUUJMYmZDaDNTbHNydVV1WlFJKzlt?=
 =?utf-8?B?ZVNtaFpBSHB3RW51bTR0QXZ4WlBHaUZZRVYvL1FndkRpUkNOc09UUEd4Qk5W?=
 =?utf-8?B?WENTMUpMNGV6STN1ZVJnUFhYUWlWTWk2MG1YVm1PZGhuckYveWxCalFrbEYz?=
 =?utf-8?B?QWJqY3VCNlNhZmVRSFhDVHNYTFduVmRhbmhVMzBBc2NOOTVGOG80YXBZUFZw?=
 =?utf-8?B?N3UrSUo3OWU0WUJoWnd4M1FNK1h4TzBrRFFhRGtDdkNCNTlEcVFzeUxVZzFS?=
 =?utf-8?B?QStHRzhTOHJ2TTZ0ZFNEbXliaTM3RmxqdTNIUG9xMDBlMnVpNWUrdE5XdGZX?=
 =?utf-8?B?QXhWM0ZQSUM4U2ZhdWo2MHlnOG04ZWJLTWJZY0JsWDJ6TkwvNm4yMFV6TzU5?=
 =?utf-8?B?K1ZiZWMwUGtwU3NwckNpS0J3OVNNV2tUa05nazkrSFE1OVRXWkd0blpucGxS?=
 =?utf-8?B?amswaEx4bjRZUUc0NGdzcy9ScG5nQitsY1FjOVkyWXB5SzVZUWxRUjYzVEFB?=
 =?utf-8?B?YjNWQnAvdXJVeFZ4bHd5ckpGQ0l1L0ZRMnZ6ZWg1T0JXYTZjSURlTEk0YStw?=
 =?utf-8?B?R2xrVGJPdG1WTFE0N052UFREWTZYbFlXbTBtQ1JRbGFLQmkwV01zSUZ2b0R4?=
 =?utf-8?B?SXZvZVZJWjVRZ1gwTkg2Q2EvVzZCUm8vdjR4SEpEcW9vK0tOQWdKUnRiSTI2?=
 =?utf-8?B?ODBOVGl3RmkrM2dsSXVQL2l4dHk4c2VJbUpiUytReWo0ZERRWmhkbitVMlBP?=
 =?utf-8?B?KzYxb2Z2OXhJbjhUZEF2WXFDazlQYUdhSzZoNGF1ZldJRWpmRmtQeWNSVUxv?=
 =?utf-8?B?OEduczdCeFFRZVRCc0VJZTJ4ZXhjS0ZYbzNrbitsNTJDdHpjblU5aU8wOCtH?=
 =?utf-8?B?ZlpDVDJ2eTVvUmRYRFJFWXBieGtlTVZoSkRzUG1oZ1RDUklNVCtXSXpsdE5x?=
 =?utf-8?B?dTFJbUpOKytMN1N5R1M3Yk5zNHpPMmhPdEpONEtWSmFxQTRiU1dzZEFjRDF4?=
 =?utf-8?B?ZDRlb2x6WGtZTnBzeGo3MWhiUUh3SHdsMWtDRGRWVG1mcnhuMEdnTTF6a2p4?=
 =?utf-8?B?MEdxelZCWkp5blVxTHNxK0p2NHhBM0dBdjM5MzZhZGtXWDBNVFpBNEpNVmwv?=
 =?utf-8?B?cXpCNEpPMlMwVUNxb1NCdExuaURTWTRFb3hOYmc1dVMyWW1UeDVGdnR0bGNP?=
 =?utf-8?B?ZG94UDd1cWMzWVpMbkhFQUU0bFQ0L3pmU3VXcGVWRVZ4dDNuODJ5SmM2WG5k?=
 =?utf-8?B?RXVwMVBCM1pjMjhnV0lrLzFVd0p4djdicnlaY0JOa2hSQzlWMGVzYWdHVFh0?=
 =?utf-8?B?Vk9udG8zSnFzVi9MbzN5OVBvMmU1OHROazgyYU03Z0lSV1BDaW1qZVRWTjM4?=
 =?utf-8?B?RjV4ZVM5c2hoMVp4MEk4VGRqSm1nSWw3VUt0V0pwY3FSWCs4Y3lKbEM4T0Uw?=
 =?utf-8?B?YnNjZjgwcmlaSXdkdzNmRnYrV2hsYTFlRlhSZjFnVEUzblZLNG53Z2RBdXlY?=
 =?utf-8?B?eXovR1RHZUtRSkxBMVZNUFNNZGRxNFp6QUZOdG5OMGxHN0wvYU0xbzdOd3Er?=
 =?utf-8?Q?UWdSfWTU0WLNqaE99UjNvVlrn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c028fa-3364-4a97-1a2a-08dd9cfd1317
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:01:32.0917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1/k2FLbe52K1jub1fQx10lo2ycYhxtILB7JhuXLHDlFn1r1Ol05qE7xcIVlIawwryJGrGJqXOnMSQ/qoyQ1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

On 27/05/2025 11:58 AM, Maayan Kashani wrote:
> Hi.
> Please revert this patch as it is causing a degradation(mark SWS as not supported while it is supported).
> 
> Regards,
> Maayan Kashani

as it's not pulled to main tree yet, dropping from next-net-mlx


-- 
Kindest regards
Raslan Darawsheh

