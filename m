Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566C1CD8C90
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 01:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC02740655;
	Mon,  8 Jun 2026 03:26:00 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id A046B40264;
 Mon,  8 Jun 2026 03:25:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NwciEHIs9/6nXDZ/6+TFhgKtw8rB/iFuly2OvxbzP10=;
 b=vWVjWjYOLElJ6xg9a0KW4KO7alFjhusOBOD7In/D+LX0NnHXmcDCwbGIRyj3g0RdNypT+9AJ9
 aD6jDywjhlu7A0g8QIci8D4LhnFOQi0vynP9WIV8tCyghpWmHDv9QoMGcW0zkYwijMfQinMtseC
 20dXWH46EO8yddoVhv/Y9IE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gYZ0r1qvqz12LGM;
 Mon,  8 Jun 2026 09:18:04 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4622640561;
 Mon,  8 Jun 2026 09:25:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 09:25:56 +0800
Message-ID: <97b3bfd9-1908-4c5c-808d-6fad25caff60@huawei.com>
Date: Mon, 8 Jun 2026 09:25:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] telemetry: fix thread-unsafe command parsing
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Ciara
 Power <ciara.power@intel.com>, Keith Wiles <keith.wiles@intel.com>
References: <20260605205253.520196-1-stephen@networkplumber.org>
 <20260605205253.520196-2-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260605205253.520196-2-stephen@networkplumber.org>
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
> The telemetry client_handler() runs in a detached thread per connection,
> and up to MAX_CONNECTIONS instances can run concurrently.
> The function strtok() keeps parser state in a static variable
> shared across all threads, so concurrent clients corrupt each other's
> command parsing. Use strtok_r() with a local saveptr.
> 
> Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
