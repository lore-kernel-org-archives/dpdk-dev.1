Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E27CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 01:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16EDF40264;
	Mon,  1 Jun 2026 03:56:28 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 9DB924025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 03:56:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=rtI1jPN6fDl4/D2iqGk3SSzwwi0CYUEWcr5lSx5J134=;
 b=IyA9P+ZwXiLCB8qB2bTyUinlEGi0KTBooiVNh0vKb85ioRM/NJ7/ZG7sRmXQdoQaNKEaL8Clk
 hv0hg5LndwpPXa20qmxG47gwkkA3RL9h5DDDAL6xdx5e99ELO50fCnQxQ2a9xUKtP0LcZwWFkCN
 RR5mDBJrV7Ym0hpbuJwaaps=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gTH1G6LgHzRhSH;
 Mon,  1 Jun 2026 09:48:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 145D24056E;
 Mon,  1 Jun 2026 09:56:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 09:56:22 +0800
Message-ID: <66381202-2268-4b28-bc5d-18fbbaf0b578@huawei.com>
Date: Mon, 1 Jun 2026 09:56:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] ethdev: remove support for queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260530161151.873199-8-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260530161151.873199-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 5/31/2026 12:10 AM, Stephen Hemminger wrote:
> The support for queue stats mapping has since 25.11 release
> by commit 2863cbd9ee6d ("ethdev: deprecate queue stats mapping functions")
> 
> This patch completes final removal from ethdev and documentation.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

