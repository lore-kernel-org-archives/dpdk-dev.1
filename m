Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CDEC282C6
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 02:40:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D361A40156;
	Tue,  4 Mar 2025 03:40:23 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 8258C40041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 03:40:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z6KZt6tNfz9wH2;
 Tue,  4 Mar 2025 10:37:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5373018032E;
 Tue,  4 Mar 2025 10:40:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 10:40:17 +0800
Message-ID: <cae94b70-b173-4de8-8877-e26dc41404d5@huawei.com>
Date: Tue, 4 Mar 2025 10:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmadev: enable lib to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <1741053304-9891-1-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <1741053304-9891-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Thanks

On 2025/3/4 9:55, Andre Muezerie wrote:
> With the outstanding issues preventing dmadev from being compiled
> with MSVC being fixed, the lib can be enabled to be compiled with MSVC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/dmadev/meson.build | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/dmadev/meson.build b/lib/dmadev/meson.build
> index e66dcb66b0..62b0650b9b 100644
> --- a/lib/dmadev/meson.build
> +++ b/lib/dmadev/meson.build
> @@ -1,12 +1,6 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2021 HiSilicon Limited.
>  
> -if is_ms_compiler
> -    build = false
> -    reason = 'not supported building with Visual Studio Toolset'
> -    subdir_done()
> -endif
> -
>  sources = files('rte_dmadev.c', 'rte_dmadev_trace_points.c')
>  headers = files('rte_dmadev.h')
>  indirect_headers += files('rte_dmadev_core.h', 'rte_dmadev_trace_fp.h')

