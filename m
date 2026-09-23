Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33591C982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 328D442EB7;
	Wed, 23 Sep 2026 09:36:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE1E40041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148996; x=1821684996;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XNpgJ/i00KqQ+/7dFW6SK5LGF1Ig/kcVG0E28f3yyX0=;
 b=bkmOytmrzkUZMFN3Kato0tD+0tVrrVFBek89f6YvrafrLLwrjiZ4nNB/
 4c8Areo70wuWgPDvvYoan+upI2Drnf50MRorHSpQ8O67Mm24h6WOEwlp4
 pbGnlG2PvvJ/zT+PwJ2iogPUJOYCLvmEXjvWuqoD6Mk8oSjO8gsqXMH1n
 izA5JMRhxIRMAbCN0i7jnEQlu1LYAGjiACS7vPVEKoA2lP+JJZeXih+qJ
 o/p5mqrINxIPK1OrdRZvPNqSr0cgb/t+x57Dj/qnO2iDGNkCWiosOP8DU
 yHS8E1UYO+xo00v4lfrGL2mU/j3NvNObtr7jch6ZtWViTHH1UUFuCCDtw g==;
X-CSE-ConnectionGUID: IQiw86fuQPGbzAMZYK0MTQ==
X-CSE-MsgGUID: tGluI7dkSx6ynrRcEW7iZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="116343282"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="116343282"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:36:35 -0700
X-CSE-ConnectionGUID: /MesWWxhSHe+mgw21Rq9nw==
X-CSE-MsgGUID: aI3M8Mn8QCCAmW9EwH8wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="299730717"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:36:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:36:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:36:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJ/k6kB9NA9DTIdU/F1qR4LYqIKHHW/RqjQC65LuVbM0pK2aIosXtUdK1coP7GOJd7oRzLlAZ8C+xcVWOBSudaRDoFDp63O9Fexn/aXXNy+nZaQm+LuzGcOWG8qPulfXLD9uK9CbL5KY5y+TV8C956fBfGxsnMdI0JIFqo9ee/O5sCzscapxvTE5cyeWlHQWJ9dyBdkKCj2lBKaOx28nk4yFwXxNnV8Su6qODhnVP0MX8+KlklXpj3Ian89iRUWWnlaoCRPfSNVdbfBpMpncm1nGjEYdEp1/IfXpKBWs6eT3Vw6uDkFhWBfq/uh8pegIslYNtHT7beBQ7dInvUg/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8JTtZU3CaCKwQXnv5JgVI97L+PXmGKsvUDXw7NW2r8=;
 b=v6phonsXbgkOSQoiz7rAZ1bimEhSQ129QNU6h3HZ2L1Ljyqm7AFBqHJQBYvLq4/Y2QbPTruCm+MGgo7DsjSUk94Pzwyjez/qjvNN2/bWghD++zMUmn0K6mP3+L+xTNTTRha2dE5yjIdijfmlAko1x1txgYc1xw2nodoUXC7dC7gqEsx9HpcoT+QTOtNe4A2U7D92IEMjp9NaF8Q7qucPaSQujXK6iIVF58n9urchkNxhhdL7IT5Y0G+O0m2chBpp6685HKgXUPyp2Kt/oxWJ7c0EWn30Q479JngNKXWy36LcumJn7GzeTTdoV6yb2DJl+A7mPGJCd1eIxHJbQrTlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSVPR11MB9892.namprd11.prod.outlook.com (2603:10b6:8:45c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 07:36:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:36:11 +0000
Date: Wed, 23 Sep 2026 08:36:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v3 15/16] app/test: use common division round up macro
Message-ID: <arOBZsOZjIgjQr_H@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-16-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-16-joshwash@google.com>
X-ClientProxiedBy: DB9PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSVPR11MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6a5013-02ae-4d9e-0878-08df194556b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aYvGLnkq+GzOehdGOJHfVkTPJva/jtAgSRy7UftYS+YayutqNHJM2bukuQYUUHXeI7gzlIv+MN4WQ+nupbi/w7aFsRI76+afDXdVNWWszE1df22FBZHljNpxFbjRxhzC7MOX0ETY7uLVKvwEoJjb91OLVedkFtNWTd/VooDYQf18/9L9FDZryGbo9HWFzHTJlmp5BXIp72fnIIsxNLKMlVSBWP82FHcpfcp4GpguY1GDJvKgUot+TnrcC84m5NOvrMTMBbXmbOamYyGIf7+8O4G5KwRzu/2ATib+HjG+qZsGBfdxToCGYTH1HAjtF3UEeXt0FF4VchKK1F/pNIjUJICN282ntoEl+vSDLkOd48tHCC611/Cf7m4RgfCn3Umfo4RrOR/LFmZ0T95ZTTV26B1AlfULpQBSD0pgAYrwekGR6LZ00JUoU28P7AdVmDvJ8c2fSwTnKXGGczQw3VQGBlfcXT5M/ckUlTwdu4ww6q4HQ+iQPdC45jFJksMTBhB+ul3QuyWMQMV/b4JNkMUoS8BUhYLE8PE7VoUxG41oY4FEn6v1j2h+8DKhNeQALQ+xSQu7jBInfvOcbyvzafrHt5PlbsCPdqpVGxo+lkpZ2cMWgMwxkoysWdNKDh96cstGlDS09YyfCRp3Hx6ZsFJ1FlwAT/QJ0U589vPmzWyoUkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdbdkVkwvuac22ZIGZiDsuYJMCbQq9B4FFpgkrBLMi3tZ0SCLXI71/v6UIJp?=
 =?us-ascii?Q?iUdSeoMemzr1YLMaVxG6OTCqDe+IqQ4muHKGPgGIjq+5fbOiAKT7Gs7Dq1JQ?=
 =?us-ascii?Q?ZxOm/8gMMBAQf9nQLYQDnmpJZein1JUpdPl2KqJztR2XNKqvXQRlGVihsRgH?=
 =?us-ascii?Q?qxjfFSHNcX8GGPPFjKrkBQoBe13/pQXUNSaF5ujk0RWgKFFyvs65nuWRjt4O?=
 =?us-ascii?Q?b3lnJ+48g3hluDtVPMBsbipcxDnxL52HjB/UIhLtkEVCdXfNvyTXhtmcu780?=
 =?us-ascii?Q?U9Aj8InEMH9ojgvaegen302TAMjPL7XDPW5jS78yheViQezyw62Gg53e+PLw?=
 =?us-ascii?Q?w/RiIcli/YWYuHDYst3Vqex2WmXiqZeWQaZgVLUHD+ZPVUuy9pOaIYQeXxof?=
 =?us-ascii?Q?KoPQkL8Ye8VDURsGBeJFPuKqCtfz/4y4DVf8LKv38y6FCZc3yNrWU6PGvKSY?=
 =?us-ascii?Q?f/XO04Hc1xMrjCq4ajmjr1MMq/2sQpSTS58QFD/gZnjxt2lkdgr48rKwA9ft?=
 =?us-ascii?Q?8whqrcuejI0E5ig8cHi+vhSDDkpLGfOJpjxq68PAfr/0ZRry67ROsYnGPNiL?=
 =?us-ascii?Q?IINodJHvUcLrm2r0N0m1l3Ee90gMGnkdz4/6X/N6DRSY4rAazou4mvU+aQKJ?=
 =?us-ascii?Q?lDrKTEySTB+vwxcMwjlMpMwqXa7icN2Xsv3r8l2WKJRgLj1S9OGYd2vtML3/?=
 =?us-ascii?Q?DrIMC+GmwoE2ZHfX/FtwgZwi5BdRrunZT5yTr7/ec0HoXpdUmNDEf5Z0O8VC?=
 =?us-ascii?Q?AxbdiLDW1ylevZGTGbEEP/NP2NYi2amO11Q/7sxGUJ0VJrbYvLmWltCr2cr6?=
 =?us-ascii?Q?AIPeFGuhaSCN2hRNihr0VxGoX3fzkfXr0Euqn0fIh4mInAUu5UEUHh+dhfyL?=
 =?us-ascii?Q?YspnwKkAM8ACeuB72cF7IP9kkH8EsWNAYbsoAfdT2sEXWKnsena6fR96Ck4E?=
 =?us-ascii?Q?xYEUNqTOXSAX9psDUtB/FFuDIaioV77atLTrhTkt2pVFAsPy1jlWm19PgzjN?=
 =?us-ascii?Q?LCz8PSj6V+BO4i+EU15W58bSRPgGVU0G2dmWzUuOq1wuKtMPkJelj2/ElK1/?=
 =?us-ascii?Q?Yds56HRgYj+80uCHElzc+REf7lnJ6NAEkRwUGP2ePpT+68F9OZXb3hpskOYt?=
 =?us-ascii?Q?qJ5HJNV/go0GrgYpgNyl5v3Fdgj5eu4MrPRJklLXyOrUJZLRZf6NrFisSYHC?=
 =?us-ascii?Q?WtEl+QBu8A9hCIdQxr1vIMF4ITp24Dtx1mulcm01UeRyFuxhkWxyv3NBXIHG?=
 =?us-ascii?Q?0jsS0l4f56NN5gy1/zmN+AHEItYfqG4/zBwq4Va/PUkcdXsP/pKzpMefskh3?=
 =?us-ascii?Q?7yH2573GxdX9y7qd0+7nf7EoRynAI/LzzzZcpqkerG5FZDZ5CSdicpchTFFT?=
 =?us-ascii?Q?w9XysyXRRwvsa99yhfirmXrYz1qlTvzPBo51TpmwK+v4/MQP8phPMjvmktZA?=
 =?us-ascii?Q?EiyjXEk1mHnNjkVzaXtzzunua7S1VZoqRmkxrG5bOCXvBAb7UnoheOtcBK/T?=
 =?us-ascii?Q?7O3w07dBHclRP+ygNA6fsHjCI/AYKi3Vra9AEFKNN92yUW0PrmcEKUVPzmAE?=
 =?us-ascii?Q?OnIxNmBbRg9v+6Ic5LAWOQCvsznA7DhqcOqcy31Vnu7gFnRmBllnVj7zFmWX?=
 =?us-ascii?Q?BHbcKm2S8GZQi6JTSBuRse1CfeCc0QnLvim1durgpx7JNzLENHxS7C8sjZNi?=
 =?us-ascii?Q?mqQW3hKo9+w+JOsUODzOf1wCB9NoMCcBaPJ9bziqTvT0T5gwqq1l/sE9k9iT?=
 =?us-ascii?Q?BwKqWjQ1l5COipb8l0GI4HePaRxcUEQ=3D?=
X-Exchange-RoutingPolicyChecked: 4659FHhf5GpD+9cChJjuWWnP55RswADt2S2sTJgEUtJu9F9RF2dqhW41VnUs79+bB8n939RfrXadmkrL7m4jLeuSBZaxp0WmlNDBvwatxmlrJ9ThOUSvu3TuhsBDPHlEal0dTHksppo5IaVYwmZEmg7BzDaBXj1xxXIqKRr4OPtiRjGzseUqQXMAkvnhezEf3yZYR5rsbAHuRQahWrqnsjlMPMCG7U/rgYdGqfxSiouK5tw0e6aOjrBDZemSHWBHG8TNTHrr0r82AP7Zg33bPhCD2/2qXcLd2lQNKU12PIqD/C7CwGU0upNqkgCj/ldy5RdeMf4xTzxzdx9JX7000g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6a5013-02ae-4d9e-0878-08df194556b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:36:11.1404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGzZ1JbkeEZ7+tSjwoZsPbrAih2lRsP9Li5T/BPp95nSNR8yVwE0BgtuSGg/fF8Ysrpmnohs1dO1CMxjiBh2kSQhhrW3MCmBYPNSHWAm/aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9892
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

On Tue, Sep 22, 2026 at 06:07:38PM -0700, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_CEIL redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
> Changes in v3:
>   - New patch converting DIV_CEIL in test_compressdev.c.
> ---
>  app/test/test_compressdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
> index 293d1d757f..2891b98d56 100644
> --- a/app/test/test_compressdev.c
> +++ b/app/test/test_compressdev.c
> @@ -18,8 +18,6 @@
>  #include "test_compressdev_test_buffer.h"
>  #include "test.h"
>  
> -#define DIV_CEIL(a, b)  ((a) / (b) + ((a) % (b) != 0))
> -
>  #define DEFAULT_WINDOW_SIZE 15
>  #define DEFAULT_MEM_LEVEL 8
>  #define MAX_DEQD_RETRIES 10
> @@ -688,7 +686,7 @@ prepare_sgl_bufs(const char *test_buf, struct rte_mbuf *head_buf,
>  		uint16_t seg_size)
>  {
>  	uint32_t remaining_data = total_data_size;
> -	uint16_t num_remaining_segs = DIV_CEIL(remaining_data, seg_size);
> +	uint16_t num_remaining_segs = RTE_DIV_ROUND_UP(remaining_data, seg_size);
>  	struct rte_mempool *pool;
>  	struct rte_mbuf *next_seg;
>  	uint32_t data_size;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
