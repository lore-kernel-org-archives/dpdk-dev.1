Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF580CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 06:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C82BA402A7;
	Mon, 20 Oct 2025 08:41:00 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 56EFA400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 08:40:57 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dzKZzf/89hWKf8/2ogq4GgXHCQoKXfeThd4I5gwHx6I=;
 b=RFoAqLe9OSQMsuXTlRrcU8NEo2D/tWci2C4hjkYYGkaCBPm5ssr7dkqo6z+5w38tBK1UCv/JN
 uPTXW+u8Bquo5JAifHi/wxfWK0/bPjBjUqfFynOyIIt6XUJNNqDRxkhFboZzokbCkdeSXyxU58Z
 gwXa0mYs2V8yXZcR66TZPvU=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cqm4f6ylmzcb2r;
 Mon, 20 Oct 2025 14:39:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3B682140156;
 Mon, 20 Oct 2025 14:40:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 14:40:53 +0800
Message-ID: <d309dd8e-727d-40ce-ae99-1e4a331f735d@huawei.com>
Date: Mon, 20 Oct 2025 14:40:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] examples: remove unnecessary use of comma operator
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Sunil Kumar Kori <skori@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Jerin Jacob <jerinj@marvell.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
 <20251017150241.28511-6-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251017150241.28511-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 10/17/2025 11:02 PM, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

