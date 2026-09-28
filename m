Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92ACCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 15:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27F0140E37;
	Mon, 28 Sep 2026 17:04:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7555640E26;
 Mon, 28 Sep 2026 17:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790607878; x=1822143878;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J990l8rXau1cw6bCBY37jkyGNd3hZiff2o6tmVtBB6c=;
 b=lan900yPkwuE5n2pZMGQwYzjcLYhfkkjpFizawpmJbZcjFTmE57Ido9u
 wo/OGOyRYEDjeJOeoKRJyxuWKi99GZ1yHixF+1600ZQGpvIhaLI/TTwD2
 TXRfxsTveKhGd1YvY+sVxEW8qlwfjXQ+jrm2O6SQqX/3f+nbk8ei9c2Yy
 cnNqOCqq/WGaR0SB/sTbrgP3SZ15CD2Fm7MaNCVv92jqwALFgDaHABmJt
 4QVSbPJ+ADBSk2evKm4TQ+EQHhj2U0eeigBXq0v4leEl7PMl7YMTmOPGS
 CbCW2AIXLTK//go1iIqeL8MiSScA/zwtY/Viiaq3B2qJyw+n+wmfdR2Ci w==;
X-CSE-ConnectionGUID: h6+ro8K2T1iMLHdOGpvDzQ==
X-CSE-MsgGUID: cLH21OziRDaB/NQ6VxhdGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="113095219"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="113095219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:04:20 -0700
X-CSE-ConnectionGUID: WJSYhRJMSdySZOCtOW/Jpw==
X-CSE-MsgGUID: eJXOerFqRxaawHELEa37Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="312998416"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 08:04:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:04:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:04:19 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:04:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQGzHJVldBQzClabko86MoKdiIUXMXKQGdoIWrD2XF83bdFiJOPyKMCaYod2vFE0290/KqUS/XbT7isxz7qod86L0gCSKPrg9Aejm81W1XDDcoG9BNGjeFOmTVC4nrJxhgi3LAfbGhK5xnbl1YOrVWkoj2XubyzfgWbCxU71hy3zcj7l1e1fiVIwpye7MPRWyiEQjWA6Zl1NQJ0gEdeFtttwEOoeu5qUSJJLlC9rmZLfwI3YXJ9CWrjF3IKwvDZIAl8xFuO0NCn+U9x8zgazxRZmM1O62uK02RjwyHMObsVLkbPpFMon7IZ4xnVDK9vNMf7JszJXtcEln8TDosqs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwXoR9a4ucRgW9CZnM0i/TWyjlHMXVKIW789JAy37Ng=;
 b=Y+TJHMWTr1PiDjlX9q2SSsiVTjDsd6kUeUnRa1KJEGTfbyOynJkInp7v+OlQo1YbFNx1zLNx/W98yBRq7EUisZgJTqviS5V075X4FDJcJKqDDk1E33y0uot78XfmhneMlDtGp9JQ5Wp7dKq5Vk8asA72eRKW/7zRTeTtCzabI3wW1jNQtE6YDuHai+s5eql0V1J39kI6T2mJlxIlUMxyskoMk9jrF5zaZFK02kdvhzasd5Sex6/RSsdtV79/3wcZJeQMO44IZm4WorjSls6An+y8hYqXqzSga9Xqs+XsKZBagKKTNYLaUw/IubjckgH4Vawd08Nv7GxIgw+BaqLdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DS6PR11MB139798.namprd11.prod.outlook.com (2603:10b6:8:4a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:04:17 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:04:17 +0000
Message-ID: <a6f5ac76-0783-4833-a351-a295183483af@intel.com>
Date: Mon, 28 Sep 2026 16:04:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/ipsec_mb: fix Null ptr dereference in
 set_mb_job_params()
To: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>, Kai Ji
 <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Declan Doherty <declan.doherty@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <pkaligineedi@google.com>,
 <roy.fan.zhang@intel.com>
References: <20260925131714.3895601-1-Alexander.Konyukhov@kaspersky.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <20260925131714.3895601-1-Alexander.Konyukhov@kaspersky.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0234.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::25) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DS6PR11MB139798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0db819-27dc-41aa-4423-08df1d71c46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SbNnBxUvXDTJ09yKGKyaJmpDdRRPj4Kg038F4ZRAZfs3m7ueBVFKCJ3soZ1/197NuPIUq37BzaZSxRcT/w/infp6SfM5m+j/6o3SrCHErk/uqtYtHXCRuPq0l/m7IFiOYfK6Hph9TDmPcDwSnFD84p/a57953VGOhnY2PhAK82tfbdEoBdyfvHcrFE8yy2yQacBcQNwTyhFrEA6rJPuPpphVtUAjZcj5eagau5FIt6FPFF3b9Z0uptcLECb/zu/h1j6CW/eLxYFoaUH0Y3cqPmVEGBHNg5OmAOvzQYG93n2q9HbwKt6yAIPb7gq3Ytu1TJgt+ymrN3CdFV77BpChaq3N+hiYd2alRh8nzYQxtlHYFhOMY3uzPVh4T8A3xvc72AxyxJYjSwISrOJRtBbpaKU4dMTDMXKLGFemuVvhCYdVk6Cg3p+mV6rwvmpnbHRTkM7zqUG1fPt3AdjY4k7CzqEvLnMRM1wkJaCyjEcuC2PaYWwsnEpPOpxb9pfDP11+A3CIWu5G4ZvjLWCEBeJ+hq6D2X/yxDIP/x6iIwNqHGPU/ki/Bbi1Sg3HeaDVGT00WiKazfLgJgXnwBvzYRaCaNfvsu8qS/h5Yth/MVa2JbNm57ZSzbQSnIsRLuCnEtFGh+xyex8/YJ83gGW+THUDTp8AuAcA+blWB6NPn5JSHac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXQzOHhxaGUyYkdUTi9UelU3YkxFYm5mRmN1cGczTTM1cmU4dWhQYUtUeElR?=
 =?utf-8?B?RFQrb3huUlorUzFLd0NBZ2VnZXlWT2I4YVhxWnZNVDI1eEhYZ2xSUm8rWGl5?=
 =?utf-8?B?ZDdVemM2dFVPWUFMQVBPMTNTbml3aGIwMlZmdlVTKzJkTldaMzdxYkFrcGxj?=
 =?utf-8?B?OFNIUGJpemVhaUZwK0ZPRlRLTVlHc2tvaXJlTlc5dWppSGJwd0RLMU1pQTBS?=
 =?utf-8?B?bEJWdVNPRHJFK01waUg0MDJYMC9JU3JDQ1psMW9naTVpVWgvcEpHajJDS0dG?=
 =?utf-8?B?Zit2YVpuL1ZLVmZldEwwMk9OSUU5dUo4cVNteU5UUkVia2FpWSs2UFdrS0hp?=
 =?utf-8?B?SE5GVUhXVXdraDY2RG1ZOEVlTWFLZjNGU1VVSlNvUjZ5QjN4R1JTSmJEelRV?=
 =?utf-8?B?S1VHb1V3ZnVDQjJCc0R2azFOaTQ0VkVOVWVTdlRmY2FXbzZuTGZTR0duNVpV?=
 =?utf-8?B?ZzNLZnk4U0hDT1RVTXkwcnUrVXc3ODZtQXBkTVdPWjlZWlM4RHBycjdWeDhE?=
 =?utf-8?B?ZVo4OGdURmJ5V2d4Ym5GN2FSRjhtWjZ6SXdMdmJlbmFRV25CTEQyblFpeEU3?=
 =?utf-8?B?c3F6eXl1WTROSmwzM1VzcGFmUXQwQ2dsb0cvWnc4aGo4b1ZIdmFNZ3VoZXdM?=
 =?utf-8?B?aTBTTmpZOXVBQnd0SW9VdWpyUVI4TmNmSTl3akZRWDBtUkY1b0VLcHlrL1My?=
 =?utf-8?B?Y0ZYdWVZbDVWWkt2T0c2TnNQdVA4elVIMk5kWUtUYmZEbkplUEJWSGRJWitN?=
 =?utf-8?B?OEJ6T0JvRUpGWUkzejBHUllMMzZUM0tQMUVIN2RmZVQybHhPaG9IVytXMzUz?=
 =?utf-8?B?MExZcDMvV2dmVWdqYlg0ak1mekFTc1N3TDFOVFR0bEwrUGpSemRUNkVTaXhE?=
 =?utf-8?B?SE91b1BBcmdQZ1ZoMWZiN3NoRGYzbkFhdHBHblVld1VTY3Nxd2NUWElQcUV2?=
 =?utf-8?B?N2c2QmJ4T3hIMUxQZVF0Q3JDM2R2UFhBS3NHYkdoU1JiZUllM1J2WS9wbVlI?=
 =?utf-8?B?NWl6NVljVExSNXp3ZUxOUU1hMFpsWlFHQSsrRklxTFcyUW9NOGNMTjQ2cU8x?=
 =?utf-8?B?R2VKSDlxYU5xWXVOTTFSWWcyMjV2eVJiUUpUMW9tTmxCM3pRZ2JMbnZQd0Nt?=
 =?utf-8?B?VkJLeEpjZ21iT0trUHZXOTVDMVJhR2RsNTdnRDVMMk9IeWF5THU5UDNVN3BF?=
 =?utf-8?B?VFQ5ODNoK3pwdlBIeDRtUHJzMXA1OWtRY3pmRm9aRno0UjcxTEhFS0hoc2Fv?=
 =?utf-8?B?UlZyNHJNVDJsQUNUZTRHNHI4WGttd3dxd2hSTDZKbXF0RTdlY0poUGoxV3VN?=
 =?utf-8?B?eHRJRVR4QTJmVDJGYTdUZCs5MVMydDlwYUYwZUdnVmZPaVV1RFVZQXBWd0w0?=
 =?utf-8?B?TS9helV1ZEJseUpLTnF5aGVUd1dMakdURXBicG9jbjlDUHJYN1J3WjNFWExG?=
 =?utf-8?B?SHBPVkUvUUNtbzdJcEI4UEhCRWlicnh0Y09Dc1M4TStWNzA4eVJuRjlEMXBN?=
 =?utf-8?B?SmRacnBTS3JQYkdISkhrZ1lUUkg5VWdmMXA3WFJnTnFSNEpDaUVqcEpqZjg3?=
 =?utf-8?B?eVgzcVRvQXhYYnFtUjhjWktCbjRYRFRsSzlLTXU2cWw3a1JOWDhRT0c4a1pX?=
 =?utf-8?B?TG9mUFV3dWJhcG5KZFhuRVo5WVMzaEhKRnFWNUlIZk5xTFg1ZmJJUmVaSWdY?=
 =?utf-8?B?NFlrTzk0VGRPQjArTi96ZUJmNUk4SjJLZE0ySCthTm1xcGdBRkhhT0NBM3VJ?=
 =?utf-8?B?NEFkWVN2VGhOV2xVR1RuL0Fhc1JHYW90Zld0T00zbHpWeW1CS1hadDhRaTl1?=
 =?utf-8?B?WDVFSkRyYlA0K2FxUDh0WEp6YWNEbnZPd2pRaUNQSm1FQUNPUU91NzBlZUw5?=
 =?utf-8?B?V2ZiNzh0NjBaT01jbmJvU1ZYQkUramJQOHU0allQaWw4MkJ0OW5qdDZMUG8v?=
 =?utf-8?B?Z0d2STQ2ZEtRR0tKTlpZZ3NScnRaMm5vWHE5U2tSeTFQNHNSTktqRGd6NjJ0?=
 =?utf-8?B?WEpvK0NLOTJ0V1ptTC9XY0hwNXppZ0NwbFdVZFQwWGdoa2VjVkN3QUw0Q2dR?=
 =?utf-8?B?clROM21ub0RDeFJFV3VOYVdQT0VtU2RNaXNiUDMyck9wRkNoMUNPdDhtL0dn?=
 =?utf-8?B?ZmQwcGVBNng4b2FKeGZqN3paZ3RlYTRVc1dmZlBVUGNQNWlCSmR5OXliZEJv?=
 =?utf-8?B?bWtiWHRQUnZpdm55R3Uvc1doYUY2bGhCQStoTXdHNjdzOVdxWVp6K2RxdTVq?=
 =?utf-8?B?LzJ5OEk3NEI2d3A2OU9BQWtpZWFOOFpPKzVtNjJUZzJyaVhFaFlFekZpSUhT?=
 =?utf-8?B?dk5GZUhZSlNieEt5bTZ0dGRQSm5tSTd2UXJldVR3clNmcFNDYlV1dz09?=
X-Exchange-RoutingPolicyChecked: sYmLBZNyLs9lOY9Cwab9G3WYCZFvNIgmBqf9A2NenJW5dxGJyMPWCp+qgXZBZuebcjMtM0u1bCYKcTfe0jmmpcJe79QZxjo5CNmEiwrsZ19x9F2XL2vG6VvleUh0ctdzMTv9bfDZ2R3Y4ccZncrcqUUxuMjsYM4uzyCApcx9cSivxUxo7VYrJxHUOQvp5g4nitEMDqL14SqIZ85WWbvZHsab2VL3o+J7/MJ5Mh0iGpxS44jFY9xJU+vJJckA3N5YbBeMGjVw8JLJzVdl88Z1nUQmhrFlSazSTv46Bn1MjpqIJuBJdw8kKzWXpTUD4D4J8FsjaG0LUpNgHmeiXDUVzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0db819-27dc-41aa-4423-08df1d71c46b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:04:17.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKQBbK0ecZ93sG8vnG1dxoAP8KRsAupqIF5zt+evzcZJDAa14eBHyiy6oqD1nQ3XZChpXHZMrIi08+qZVvz+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB139798
X-OriginatorOrg: intel.com
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


On 25-Sep-26 2:17 PM, Konyukhov Aleksandr wrote:
> In function set_mb_job_params pmd_aesni_mb.c:1742 check
> (cipher_mode == IMB_CIPHER_NULL && oop)
> is not enath to garanteed job->dst != 0, which in turn could lead to
> NULL ptr dereference.
>
> Add new check for (sgl == 0) to be shure that job->dst
> was set in pmd_aesni_mb.c:1610
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 03944ff5e3df ("crypto/ipsec_mb: support null auth/cipher for aesni_mb")
> Cc: roy.fan.zhang@intel.com
>
> Signed-off-by: Konyukhov Aleksandr <Alexander.Konyukhov@kaspersky.com>
> ---
>   drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> index 05dc1a039f..57d8925a87 100644
> --- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
> @@ -1738,7 +1738,7 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
>   		job->msg_len_to_cipher_in_bytes = op->sym->cipher.data.length;
>   	}
>   
> -	if (cipher_mode == IMB_CIPHER_NULL && oop) {
> +	if (cipher_mode == IMB_CIPHER_NULL && oop && !sgl) {
>   		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
>   			job->src + job->cipher_start_src_offset_in_bytes,
>   			job->msg_len_to_cipher_in_bytes);

An error code should be returned here instead of silently fail the 
memcopy / NULL cipher operation.

Something like this below, make sure job->user_data is set

--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2142,15 +2142,19 @@ set_mb_job_params(IMB_JOB *job, struct 
ipsec_mb_qp *qp,
                 job->msg_len_to_cipher_in_bytes = 
op->sym->cipher.data.length;
         }

-       if (cipher_mode == IMB_CIPHER_NULL && oop) {
-               memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
-                       job->src + job->cipher_start_src_offset_in_bytes,
-                       job->msg_len_to_cipher_in_bytes);
-       }
-
         /* Set user data to be crypto operation data struct */
         job->user_data = op;

+       if (cipher_mode == IMB_CIPHER_NULL && oop) {
+               if (!sgl) {
+                       memcpy(job->dst + 
job->cipher_start_src_offset_in_bytes,
+                               job->src + 
job->cipher_start_src_offset_in_bytes,
+                               job->msg_len_to_cipher_in_bytes);
+                       } else {
+                               return -1;
+                       }
+       }
+
         if (sgl) {

                 if (lb_sgl)

