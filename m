Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6994EE3682
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 13:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57DC4027A;
	Thu, 12 Feb 2026 14:41:49 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14]) by mails.dpdk.org (Postfix) with ESMTP id B5E8740268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 14:41:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIOCwCEUAlukE9WEdTf35q1HavRfKu3TGEoF/NTWJe5NMgy9lEp/hO9jJtSio+hjKBzz6l/W6Mih8MUHpnPgjjYJP5G91hXkY7nQVf+rwK3jIqmj8a6RZWvGsmeFJyida1S1LkLTi+6E5hkmZFeTsOC4H04/5KAxlZin4X+XSyIIHbQfrIoexQwBEmLmhoGelyjsn7qXimum/oBBHpV+KQ2cyfMa9a1kzjblBQ9NUoIOiSOvH8UKlePUiNY1skkq/alpSIjrxnHFhGnj6GG3qwwrPk6ncxdqTEDM1+OW6w2rEZBHoAm93h3Eu+5rT8TWHBtE1gsvhDpCS+rs+8wEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSHCNRkUS9XbYjh5s9TD3ZGF0eckED09SNPL5OMXLfg=;
 b=iOPmLMDR+LrpLLb7YEjvPqr0tgBfXXD57D6nBr3wgTuodCSiNFj8IH17SVjUQhQSBZWja4SRdYfQI9EUrc0yMTa3fnn8JcbuWB716vpTSpx53nJ2Uv0bqYe14KbbwxQwC6HnZDKZ4dcxQ9OyKl6PKNdxRlGWSXjwguPLK8ZM67FOI1yeUBS4Ij5oGG1yPr2VhWZCPsCSmTAxDMruQduyJugQHv2/dQ5G55DklV6fWb4v7b1uKyuKngntcHDVRwqjTxcl2wyCrNBZ7Pn4/8d5k9B2uQYzSuW9FDt6+RfyOE+4qDxMV/a/pFYgdBKpP5+FANkn/kBir89YbB2Gw0uW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHCNRkUS9XbYjh5s9TD3ZGF0eckED09SNPL5OMXLfg=;
 b=cxWRXdaNZt8pBVZM2BZfKkto2nMHs8McTHuqQ4UWFmlKXCXIqfhQgmOe6JyAA3YDqqfX3jSl+SfuRT6FI2SYHcpooCaupH8wD6GYDM8VRODL2E8mw5O6je6p9mZvkfVIJ+xo7+jiiFPZ0GpnEZ/48MVrPvgJejvJb9i8TAIx+jY2Ro6wFLyDWxCSeYUAqgOIyvcWZ2RDtLW9/2TosYzUU6EGvUGDpyKvjRdmRiA+RrLh0h97Cf1XSrvOTBZfdofYI5Axkz+bqCIBPagIqGgntkrsjRflRJC74AhoPbtyVmZM6pdmwu/C1zcQpXCoM4G3RKpyuTl8ueVdQyc2I5AUNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 13:41:45 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 13:41:43 +0000
Message-ID: <cf3a9d24-f80c-456d-8546-f78516bc15a5@nvidia.com>
Date: Thu, 12 Feb 2026 15:41:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] common/mlx5: add mlx5 prefix to remaining internal
 functions
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251127112919.53710-1-mkashani@nvidia.com>
 <20260210140232.244782-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260210140232.244782-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: bae4e201-a148-40cd-b202-08de6a3c755b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTRxRlpCTGZTWlNHUFhDU1pzWlVobjRzcjVDVFNCNEpiaDg1VkQxUDl1Vlho?=
 =?utf-8?B?U3hiMmxDR2dvTlRiTWNOR1lvd2E2UnBFajZRRlJNTU0xQUNTUS9Dc292WURM?=
 =?utf-8?B?S1FUTDlrNzIwTlF0MDhhK0RXTVk0bk11Skt1ZzlGVExGUkg0bVFEMUpqWEYw?=
 =?utf-8?B?aUtPZFhYK0QvNmdrWExnRU5ZMDNCdDhWUVdjOGlTZlJtdGhNelNpdi9jRlZk?=
 =?utf-8?B?OWNTZzJyZEFoeDNLQkpCZjhaanFER2VhWGFObXZvL0dSRzRwam1WdEVlOEVy?=
 =?utf-8?B?YjFsRUk3MFkvQ0lKL3MrUlhOZGlqTlllR1dRU0RxVlNSMk9scndkYnRVcWxL?=
 =?utf-8?B?THdTSHlMOFN2Q2tXKzRQdUdaUHFKRTE2S2JYdW9NYnpSNG14OHhmL2VsSkNl?=
 =?utf-8?B?UmNmOUFid3ByNHZBKzdPWVRrUDd2YnNkbnZ6Ni9pR2x1YWthWFg2SHRkUGFL?=
 =?utf-8?B?ZCtnVTZONUdQM21uRUlUQlhUcDRNKzVJVDFHQzJSNkkwbEFINGhoTnc0a0do?=
 =?utf-8?B?ZnlkenMrRXFBR2dtQnFYYjhkR2xLdjJNVUY3c2VLWVFiVDlkaDc3NFFuM25q?=
 =?utf-8?B?WG14cDBpOWE4NWxmNEliOUJ4dS9MSjd0UG1CVldCaFhmV1FiRVhENjgrSElD?=
 =?utf-8?B?eDIvcTlwdTBFV2ZjcUtuOXNLK0NXNHRGelVjWnhZSTBoclZINm5nZlgyUGpY?=
 =?utf-8?B?VVczV09nZDJEVlJqNDFDcDRxVExlVkVPZTVYeVBRTkFnZTZhZDdEdnBsZmJv?=
 =?utf-8?B?VkpSWnNVc1FxVytneWltOGRhMXhTM09iNUtFQlRKOXlBUzhMcERiTGdJQ2po?=
 =?utf-8?B?dU04aysxd2wxTkNVdS9EZjh6M1hoMHZWNEI1SzlZbzF4UElVNk1uMDI2TlFB?=
 =?utf-8?B?UWxYNGEvWXgxdGZ1cGt0V3RzdTBkK2tYbzNuc0ljNnF3SWVPZGJTazBjQko0?=
 =?utf-8?B?a1NCUE8xa0tvOU14VVIxYmlyNkozVEdXUzhpNy8wMzFCY1BjUGVBbitPU1cz?=
 =?utf-8?B?R2pKcjhLV1dyNkN2R1NzUG1sR0xsc1A2bVZkTVdtdWdmVDdTRzlkV05aMjkw?=
 =?utf-8?B?VTkvNmRwVmV2b3FiSjl6QkJpK2VuVVU3QnRHS0hrOHNFUysxdGl3cHFNOWZN?=
 =?utf-8?B?eFR0bEQvMjFWc0UxV2p4WXlyc2R2YWcrY1JFNUhSSk9BaWlGeWlHcGN2WnV1?=
 =?utf-8?B?YS9TR1N2SmRXYmg4bDAvajJJVWpMNFoweVBQYVFnTHdaRlY1c3lBUGVNbU9J?=
 =?utf-8?B?ajFUdXBTVDFlSFRMdHpUbmRvbk1RNzJrU1hVZXVtVnV5bU1nV0ZKVkEzdmhr?=
 =?utf-8?B?VlVkTDFlc0x5M2U3b1RWcVVPcVJTUXI4Wm1KQU1mbGNFSnlZcURPVGZIaUtl?=
 =?utf-8?B?MDJweWJBcjdYRGdiU3JkdkZMdy9qQWJ0c0UxT3dVNkVYajExdmY2WXlDaWJ4?=
 =?utf-8?B?REhLeWJpMWdZVmRWTXlVL3o4WFduc3dleHA5ZVNhNkFSZGdrUkNQRUE4Z0Vq?=
 =?utf-8?B?OXUrOEFXVGFZZ1AzZWxCa2hYOHd2aThEalBTa28vQ0Rya1YydmNkV1p0dGVE?=
 =?utf-8?B?ZENvcXRuU2VzaU9NUFJjSHVmWTdyUFh1VW5wM0hocXBZN0hvaTRLdWlydzR6?=
 =?utf-8?B?SVdRZW53bW0rZWVUUEZ5OFl4S1I3ejdiNEVuLzVzb3lQbVZOZk83QUZNS2ZG?=
 =?utf-8?B?empEenNhWEZ4cDJWMDVpU0NkQ2FETHUySmNyR3Rab0hKY3JsZy9GRysrUkNo?=
 =?utf-8?B?b0VCVUpMdkpBbEpRL2hqTldrVmU2NDY2WUlYL3EwQXpTaGtudGhZeWp5TENQ?=
 =?utf-8?B?K1g4d0JYN21qYnd2MGFmNVVoWDNMQitqTjgwTUdIeUx1b0xlbkcxdGQvN2Qv?=
 =?utf-8?B?OFMyWW9XVFdiN0N1QUltR3hTTklkVk4vYU4wV0tmRFlmY3Jva3pjd2VIZmhj?=
 =?utf-8?B?bFVOc2ZXM0I0NHpGVU9ydTVxUTBrNXBHZm1kS0t2b2Q0T0FidTduV1dFS1N0?=
 =?utf-8?B?VWVXUzdoMXF2UlBKRm9LSTVqdUZyaTVzMTZmQlNoQlRibmtybVU4VjJpOWdB?=
 =?utf-8?B?bjBvb0x4Q0pDbUg1VlpXaHhoUjNuZ2VwTUhLMklBUDN5ek1TOVZhL3RRM2xE?=
 =?utf-8?Q?BJOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U09yUzBjS0xQWFNGQVdkbjVvb2FNZ1l3OXBmajUya0J6LytlQjJUZms5QlpJ?=
 =?utf-8?B?NXAycTBjN09mbTZuZWlURmE3MWFGNFF0dW94cG8zRTNPbE04MGoxb1l6R0NZ?=
 =?utf-8?B?Y0h5Qno2QTNSYzYwZS95djdiSFdidEN5eFdSNlRaVmRBSjdNNG45MmlWMlBl?=
 =?utf-8?B?d0I1eXNQSTcwYU5tS3Z6QW9IK2ZUWkhkZE1PRzhUTHhtMFI1a0o5R1oyN1RO?=
 =?utf-8?B?Nkl3QlUvdWMzM2x0Y0JxMjk0S3VpOFV5eG9QM0tnQTQ5WXoxOCsyQ0UrdlVy?=
 =?utf-8?B?VXpSUW9NWTBWamtyTWd6Z09JYjNFMDgwY1M1dWwxYlU1VGw2WXVRWHVQM045?=
 =?utf-8?B?bGJyaEVuakphZWlRRWJtQ1FUeXY1S28rMW5wZFJobGZLVTBaSjVKN2FkZDhC?=
 =?utf-8?B?QVZWeUd0dXFQSC9XTGVvOVlxVzBJVElHZ25EVC9Ob0FWK2dSbG1HWHp4YWpK?=
 =?utf-8?B?RWpFQkkySVZaVmlKejd1TVBXMjcyWm9leGZOV0xFZDNvRDc5dGF6RksvQUNp?=
 =?utf-8?B?K2dHeUcyc3BEdC9QZUllUjdDS0YrRDZTd1ZWT2UraFArNTFYby9INUZEODlG?=
 =?utf-8?B?aERFSmtZVENxeHUwTkpTSDhZd1FIdk1IajNIQkdOSi93bjlNMFd0ZzRtdFAy?=
 =?utf-8?B?N1FselE0QnZJQ3R5ZDhkTGhkRWdkSnpYR1Q2MmtTUWtMb0hsTkQxNDBoaUNM?=
 =?utf-8?B?MDhNN3luRTV0VmNkZ0RQKzlSN0dWSkJMTndyb1VlMUZSOTVwOTEzUHhIMFBw?=
 =?utf-8?B?cE1PRGVSdU1pUmpCeHhsMW9RNTNjN2xmU09sKzRPWHRZd1dhYmJ1Z3BjY2Z3?=
 =?utf-8?B?WjJZa29kV0g4VUgzMW8ycUZUcWFCeStPT0RZL0FUTmNLbnEvUzhvQ3F4dTZI?=
 =?utf-8?B?RUxqV0h3dStnYm05RXJNc2FBUjJUMWRhOTNLZXVhN2lyOXFXcStQMC94RCtl?=
 =?utf-8?B?TnlzbXFvRE9WNmNpQjYxZkNZempOZHJXejR0U1pBNk9Va1EwZHIzTUtKbXBi?=
 =?utf-8?B?Nyt4dWFSVFAxM2hVOXFMb0lWRE13ZUNrcjUxS2MxWGFLc0JReXNKUmE0amdQ?=
 =?utf-8?B?VEt2eEl2VFVOV0F2Tm1OVnRxc0ZKdHRZc1poRnVHQ3ZpR0ZTWlhPTFhzdFVz?=
 =?utf-8?B?L256clhQN05XSjlxcy9ZbzhNS01MeHUzZnhPaWNCZ1J0eHNFVzlYM1VpbHJv?=
 =?utf-8?B?U2NnVk5aTzFrejdjTzlBbFRVK3lWN294WVJ4c3BLbkUvSTA3Tm5RV1lNVzc3?=
 =?utf-8?B?WTM0YWdJN3UwQkI4TVI3citibVlPYWN2Z0lSaTJJNHZDZFhKU2pUY1NDK0k3?=
 =?utf-8?B?dFoxMmE1eW4wWU12bm9BNmtUMDEybk1YZ1pvK2RyOFI2bkhrM3dUa1RZQVRK?=
 =?utf-8?B?dnJDTG9xSEVPeHYyRGswWDRodHVkcVZiU2hsM3B5Ly9YbWxYS044WWE0aW5X?=
 =?utf-8?B?UUtVWXhQYTlmRVd2eWcxZlRxT1FzMktMUlhoMzBtaTFNeng5SGhRcGNjOWY4?=
 =?utf-8?B?djZrc1JJVHFSdjhkR3IyQkdVMytuOW1UcGJIbDQ2RmxEeTRGaWQzbVNTUjVT?=
 =?utf-8?B?OElucWE4VVQxWTRiL1BGeTVHNnQ1dHZKVmNCRFpzYWY0TjBqamlBMEluRUxo?=
 =?utf-8?B?WTYxUkhDNXNCMXFJMjI0akk5QXVkWWFFckJxMVhEOWxrOEs1WkxEaU15V3pn?=
 =?utf-8?B?MmJoZGlEWlQ3RlVqNkZydkZsd082NVFGR2RKUHVmREdZV05vWVlvRVEzc0wr?=
 =?utf-8?B?NlNWNktiQXRMemt6dHFWeEZsZUU0SGgxU1pHMTE2TE9MY3lkR1lFdVRQek9N?=
 =?utf-8?B?SFN5TGxDcURLNVBSZExPZFF3YXhLOEllcHhpbmUxZGVRbEFKeW9PMFRZRjNF?=
 =?utf-8?B?aHhCWUJseWNuK21uak9xSzhJMko1clNKYUowTG56K2lQYjJhVDY2V093Ukhm?=
 =?utf-8?B?Ky9PUWdCSUZmRFlveHJxQzZqb1l1UTc1aVhOVHNhYnliL3NZYTg3SFZiQ1Yv?=
 =?utf-8?B?cFdMV3gyRGE0dU5HS1Y5M3pIUGhBNDJCL3prblVRekhsc1JZUlQwd3pTRVpM?=
 =?utf-8?B?bEhHcDE2N2RPa3FPWU91Vi9TbjhIWVlTQVcvdEZxb1FzVzlHYXJTcCt6RnNF?=
 =?utf-8?B?WmFMUm1LYlBhTmNIZENtUFZuT3dRNE5zaHl3RStvWkRJdllPVmpoeHhEUzVJ?=
 =?utf-8?B?UmVVYW1vSG1nTUtIalZLQzJtVlh3cHA2V2tTRmxtRnlWckJWYkhkNFR4Y1U2?=
 =?utf-8?B?dDhyZW44QUtoOW1HUTlKa0dKcHk2ZWM3N1dseWpLRzByU0xLK2NIOWNDZ3Z2?=
 =?utf-8?Q?H0GeCjMpLVwtr9Rsak?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4e201-a148-40cd-b202-08de6a3c755b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:41:43.4349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkmq4pY5G+cZO/CL5NFS4E42ylLHpOmNVlg3+OWo0+CP7kfYG8Al0vo5oOeIBA6MnoqWob+DKGggJEub6KdqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

On 10/02/2026 4:02 PM, Maayan Kashani wrote:
> Several internal functions in the mlx5 driver were missing
> the mlx5_ prefix, which could lead to symbol conflicts when linking.
> This patch adds the proper prefix to all remaining global symbols
> in common mlx5.
> 
> The following function categories were updated:
> haswell_broadwell_cpu->mlx5_haswell_broadwell_cpu
> 
> Global variable:
> atomic_sn is now static.
> 
> Bugzilla ID: 1794
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

