Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A09606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vGUzPsA7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34744025A;
	Tue, 27 Oct 2026 03:39:05 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTPS id 9BD7B400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 03:39:04 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kTQdzGGJJrV/XOl+HT0X4gWuPVlk+g0wgk0CdaoVz84=;
 b=vGUzPsA7Ajkwlj6IOwZsojrVSK+ZkRWA9VBZcppxhLe53tr9ClG1dj5XwnNxQ4d3V2qUqsZ8P
 DXr2Alr1YU8WCheVPUbhLCiCp1T1RwsMbVHB4xEerqM0M6G1EOGsolTeSyg5N1p3wcl5W2DNTxu
 p6A15Z8TJ59ZFOc9OcPSRuQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jDF744SzCzmVCp;
 Tue, 27 Oct 2026 10:38:56 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F7474055B;
 Tue, 27 Oct 2026 10:39:02 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 10:39:01 +0800
Message-ID: <547bad6f-dcc1-45ff-ad2f-bf8fdab63805@huawei.com>
Date: Tue, 27 Oct 2026 10:39:01 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] ethdev: check DCB availability
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-11-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261022174447.412638-11-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 10/23/2026 1:44 AM, David Marchand wrote:
> Add DCB capability check in rte_eth_dev_configure() using
> dev->dev_ops->get_dcb_info.
> 
> When NULL, reject Rx modes with RTE_ETH_MQ_RX_DCB_FLAG and
> Tx modes RTE_ETH_MQ_TX_DCB and RTE_ETH_MQ_TX_VMDQ_DCB.
> Remove redundant DCB checks from drivers.
> 
> Check that documentation is aligned with driver code.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

