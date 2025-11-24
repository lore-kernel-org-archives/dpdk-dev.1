Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90FDCFD2F6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 01:54:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7997D4028C;
	Mon, 24 Nov 2025 02:54:02 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 6504E400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 02:54:00 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XeYHnuOWIVia7dri8R/vXK90qaHXswO2w0SwY1ZQX+4=;
 b=fYVWmJXGe2ahFB5eqH5kWA+jYgnjG7dhYSzX1lDyVRG9EVSJCw3ae5fdbQ3p9p+NcVo8Skb3Z
 BgFi30pMoBHnma+LCwIMHj35pNLnmc5DjgFny4hXZU/Ib+J42235CiKnG88LLluaYFEnolMpBpZ
 ypA9FruzIkjVZwFC3zN3mUI=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dF82B3Nk3zcbNK;
 Mon, 24 Nov 2025 09:51:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4D76A140E1E;
 Mon, 24 Nov 2025 09:53:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 09:53:56 +0800
Message-ID: <aee5ab7a-0f29-40ee-abbd-4407650b97e7@huawei.com>
Date: Mon, 24 Nov 2025 09:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] tests: fix format truncation warnings
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/24/2025 1:43 AM, Stephen Hemminger wrote:
> This series fixes compiler warnings about format truncation
> in the unit tests.
> 
> v6 - alternate strategy for handling huge page mount point
>    - fix warnings which only show up in RHEL8
> 
> Stephen Hemminger (9):
>   test: increase size of memzone name
>   test: refactor file prefix arg handling
>   test: avoid overflowing huge directory path
>   test: use unit test runner for eal flags
>   test: fix format overflow warning in ACL test
>   test: fix impossible format-truncation in cfgfiles
>   test: fix format overflow in cryptodev test
>   test: fix overflow warnings in mp_secondary and pdump
>   test: re-enable format-truncation warnings
> 
>  app/test/meson.build         |   1 -
>  app/test/test_cfgfile.c      |   8 +-
>  app/test/test_cryptodev.c    |  22 ++-
>  app/test/test_eal_flags.c    | 283 ++++++++++++++---------------------
>  app/test/test_memzone.c      |   2 +-
>  app/test/test_mp_secondary.c |   4 +-
>  app/test/test_pdump.c        |   4 +-
>  app/test/test_table_acl.c    |   4 +-
>  8 files changed, 140 insertions(+), 188 deletions(-)
> 

