Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846BCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:15:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA210400D6;
	Mon, 10 Nov 2025 02:15:34 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 0F0BB400D5;
 Mon, 10 Nov 2025 02:15:33 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=78DX8hHOh0o7Xu79pNDctjgknzup2NsKDh7DxgDbpaw=;
 b=xJMPcAUlCMRbha3hgSr3E5w2BQrQBH9/stzw5wkvrwqZ3i+AS0ihRLW+JrL2XS1ETKQIPI3b7
 D0M7Aq7VzK9EfP+PbyWUysiK8QlKv9uXG0KvU47eiscHMrVtBxJVo605R1kqaqZzruiYVXevEeH
 svsVM/gL5tD6WLqguQDpWQQ=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d4Ws26HsLz12LDJ;
 Mon, 10 Nov 2025 09:13:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B994D1401F2;
 Mon, 10 Nov 2025 09:15:31 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 09:15:31 +0800
Message-ID: <8ea32a32-a577-4160-84ed-1ca3667d0916@huawei.com>
Date: Mon, 10 Nov 2025 09:15:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/33] telemetry: make socket handler typedef
 private
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Ciara Power <ciara.power@intel.com>, Keith Wiles
 <keith.wiles@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-11-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-11-bruce.richardson@intel.com>
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

On 11/7/2025 11:50 PM, Bruce Richardson wrote:
> The socket handler typedef, just called "handler" does not belong in the
> public namespace, especially since it is unprefixed. Rename to
> "telemetry_sock_handler" and move to internal header.
> 
> Doing so also clears shadowing warnings in dmadev library, when it is
> built with -Wshadow.
> 
> Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

