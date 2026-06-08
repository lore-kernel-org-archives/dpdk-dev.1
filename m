Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3750CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 01:26:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134A64042E;
	Mon,  8 Jun 2026 03:26:42 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id B5D3640264;
 Mon,  8 Jun 2026 03:26:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0DDg51HkjuBYCv3rJVGzjz9TnHmaObCwPgqe4pD5V90=;
 b=T6ZoiOzSbl3n39AYnPHHsN7FgWML6vcw4MYXLXhuNBHWG8QBN+HS47PI0/doz62KA6CzciBIR
 DGEUjYzJSWzTozWo68Rp3e/hYoCfEx4Lpis8xtMjZ8ERFDuqSk2BfY9lr3xwRP7yeXG16kkAqtn
 U15gh2aVsFhzZKUS5oOdXFQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gYZ1b4n5Kz1prLk;
 Mon,  8 Jun 2026 09:18:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 00C614056D;
 Mon,  8 Jun 2026 09:26:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 09:26:38 +0800
Message-ID: <963379dc-bfc9-4b01-bb8f-791c293feebf@huawei.com>
Date: Mon, 8 Jun 2026 09:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ethdev: make telemetry parameter parsing thread-safe
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Jie Hai <haijie1@huawei.com>
References: <20260605205253.520196-1-stephen@networkplumber.org>
 <20260605205253.520196-3-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260605205253.520196-3-stephen@networkplumber.org>
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

On 6/6/2026 4:50 AM, Stephen Hemminger wrote:
> The ethdev telemetry handlers run in a per-connection thread.
> Two of the parameter parsers used strtok(), which keeps its state in a
> process-global static shared across threads.
> Use strtok_r() with a local save pointer.
> 
> Also pass an unsigned char to isdigit(),
> which is undefined for characters with high-bit set.
> 
> Fixes: 9e7533aeb80a ("ethdev: add telemetry command for TM level capabilities")
> Fixes: f38f62650f7b ("ethdev: add Rx queue telemetry query")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

