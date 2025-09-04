Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA990CA1010
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 01:11:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE97240609;
	Thu,  4 Sep 2025 03:11:56 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 9DC0340270
 for <dev@dpdk.org>; Thu,  4 Sep 2025 03:11:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cHLtM4Kvsz1tpGL;
 Thu,  4 Sep 2025 09:07:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2DE871402CA;
 Thu,  4 Sep 2025 09:11:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 09:11:52 +0800
Message-ID: <ce5597de-e8dc-4e48-b51b-916d23faa15f@huawei.com>
Date: Thu, 4 Sep 2025 09:11:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: update for packet buffer library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <dev@dpdk.org>
References: <20250903110006.44202-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250903110006.44202-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 9/3/2025 7:00 PM, Morten Brørup wrote:
> Add myself as maintainer for the packet buffer (mbuf) library.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7aca98c537..c64a123e76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -429,6 +429,7 @@ F: app/test/test_stack*
>  F: doc/guides/prog_guide/stack_lib.rst
>  
>  Packet buffer
> +M: Morten Brørup <mb@smartsharesystems.com>
>  F: lib/mbuf/
>  F: doc/guides/prog_guide/mbuf_lib.rst
>  F: app/test/test_mbuf.c

