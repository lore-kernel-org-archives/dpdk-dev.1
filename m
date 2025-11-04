Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F19DCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 06:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 114624028C;
	Tue,  4 Nov 2025 07:05:52 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 70BF340285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 07:05:50 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=G0TtGaQYZbdzWCM1B9QQpLgr2bQvLseeK/PPGmQKZRo=;
 b=e/7b6hSBm25zPR9Kj56ObjYozKKO1nN3/qn4Sq3a+XfqkMaK7F5lzugwIhj7tyrEgHCB3NccC
 ZfpYXqijhiywE9WtMgEohQjXYRAZ/BMQnWtEBqlEnK1SY4Les3NPU4PVgYdKX/TBM9Se2gQyshZ
 b0aSZRUoKwKJjCqBfosKIwg=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d0yZk6WGvz1K98M;
 Tue,  4 Nov 2025 14:04:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C312A1A016C;
 Tue,  4 Nov 2025 14:05:47 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 14:05:47 +0800
Message-ID: <793529f0-959b-4d72-a4de-5b06497a7c5e@huawei.com>
Date: Tue, 4 Nov 2025 14:05:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dmadev: add domain_id field to access group join
 API
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>
References: <20251103102946.2204883-1-vattunuru@marvell.com>
 <20251104052146.2308361-1-vattunuru@marvell.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251104052146.2308361-1-vattunuru@marvell.com>
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

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/4/2025 1:21 PM, Vamsi Krishna wrote:
> From: Vamsi Attunuru <vattunuru@marvell.com>
> 
> Add domain_id field to access group join API, which is required
> to retrieve handler information associated with the specified domain.
> This enhancement ensures that domain-specific context is available
> during group join operations, improving flexibility and traceability
> in multi-domain environments.
> 
> Patch aligns the parameters of access group create and join APIs
> for consistency and clarity, also updates the dmadev.rst file with
> detailed steps.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>

