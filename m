Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A78C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 02:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61FED4027C;
	Mon, 24 Aug 2026 04:45:27 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 67A6D40270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 04:45:26 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oghRgEDXk2IZyK4fWNj6gQrQ5X6MUND2PDT0mIEG81o=;
 b=cseVWitEVbx0/GN9NhjjjOsVBjvI6XLOGfW8QF8DydaIj6xq+L4/kj1jbWwh0zKaXHFXGUF24
 DPNjy2roUuAMb9BmFNR6wQax2faQ2BJcYfB+x2PfqxsI4UEWoQMQE+m3a4bnp++IXuT5O4Ga2Sx
 rDfLu64QBuRfhQ5Dx6xLg4s=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hSw3H40P5zpSvB;
 Mon, 24 Aug 2026 10:34:19 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id CE09E40561;
 Mon, 24 Aug 2026 10:45:23 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:45:23 +0800
Message-ID: <3e1c5c97-cba2-4f63-9ca8-82359b780354@huawei.com>
Date: Mon, 24 Aug 2026 10:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/68] eal: replace rte_memcpy of cpuset
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-21-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-21-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/22/2026 3:24 AM, Stephen Hemminger wrote:
> Simple structure assignment is better than rte_memcpy.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

