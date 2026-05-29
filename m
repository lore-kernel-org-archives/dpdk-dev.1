Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F52ACD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9673040264;
	Fri, 29 May 2026 02:18:01 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 667DB4021F
 for <dev@dpdk.org>; Fri, 29 May 2026 02:17:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=+mhxd453N3FycA+9KGXExSFGdCTqELvwcVeA8QRMjjY=;
 b=nw4jbv+SpCXoIcgosKBpR6DK2KulmtajgMYvke4VMSYMzBz1GVVu7d52D5uWxtANTbkt7/922
 s5R10t5L3ap8nCpiWmtzbOglti+l0fiHutmj8X/2QqnQPIFXpnPiL5aNHmcBjguJjkpI02Pp4g7
 4xdePUa14wWSOJr2y48Bg54=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gRNyn5jq5z1T4K0
 for <dev@dpdk.org>; Fri, 29 May 2026 08:09:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 422354056E
 for <dev@dpdk.org>; Fri, 29 May 2026 08:17:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 08:17:56 +0800
Message-ID: <b1a04d61-7d6a-4b1d-beac-87d271c9f738@huawei.com>
Date: Fri, 29 May 2026 08:17:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] usertools/telemetry: add a FOREACH command
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260522133714.133268-1-bruce.richardson@intel.com>
 <20260522133714.133268-2-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260522133714.133268-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 5/22/2026 9:37 PM, Bruce Richardson wrote:
> To simplify querying data from multiple devices, e.g. across ethdevs, or
> dmadevs, add a FOREACH command to the python script, allowing you to
> run, e.g. /ethdev/list, and then run a second command for each item in
> the list, gathering the relevant output values, optionally including an
> index counter.
> 
> Simple examples are given in the documentation:
> 
>   --> FOREACH /ethdev/list /ethdev/stats .opackets
>   [0, 0]
> 
>   --> FOREACH /ethdev/list /ethdev/stats .ipackets .opackets
>   [{"ipackets": 0, "opackets": 0}, {"ipackets": 0, "opackets": 0}]
> 
>   --> FOREACH i /ethdev/list /ethdev/info,$i .name
>   [{"i": 0, "name": "0000:16:00.0"}, {"i": 1, "name": "0000:16:00.1"}]
> 
>   --> FOREACH i /ethdev/list /ethdev/stats,$i .ipackets .opackets
>   [{"i": 0, "ipackets": 0, "opackets": 0}, {"i": 1, "ipackets": 0, "opackets": 0}]
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

