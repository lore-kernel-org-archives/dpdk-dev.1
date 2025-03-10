Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35713C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 10:28:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EC3C402D0;
	Mon, 10 Mar 2025 11:28:21 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 7476A40151;
 Mon, 10 Mar 2025 11:28:19 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZBClf2Z8VzyRqQ;
 Mon, 10 Mar 2025 18:28:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5E4A7180113;
 Mon, 10 Mar 2025 18:28:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Mar 2025 18:28:15 +0800
Message-ID: <cae9e62c-6b32-42bf-8ba0-b241c5347581@huawei.com>
Date: Mon, 10 Mar 2025 18:28:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix year of final LTS release
To: Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20250310100807.17559-1-ktraynor@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250310100807.17559-1-ktraynor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2025/3/10 18:08, Kevin Traynor wrote:
> LTS length was updated to 3 years, but a sentence saying
> when the final release would be was not updated.
> 
> Fixes: 3c60ea7b289a ("doc: update LTS maintenance to 3 years")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  doc/guides/contributing/stable.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/guides/contributing/stable.rst b/doc/guides/contributing/stable.rst
> index 289769a61d..808e7fa779 100644
> --- a/doc/guides/contributing/stable.rst
> +++ b/doc/guides/contributing/stable.rst
> @@ -74,5 +74,5 @@ For a list of the currently maintained stable/LTS branches please see
>  the latest `stable roadmap <https://core.dpdk.org/roadmap/#stable>`_.
>  
> -At the end of the 2 years, a final X.11.N release will be made and at that
> +At the end of the 3 years, a final X.11.N release will be made and at that
>  point the LTS branch will no longer be maintained with no further releases.
>  

