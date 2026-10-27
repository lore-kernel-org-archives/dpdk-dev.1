Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CF606A324
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=l5lllv04
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED367400D5;
	Tue, 27 Oct 2026 03:38:13 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTPS id 08957400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 03:38:11 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=02thnOYwgZ82T9EbPX0piFeBNx/ZYIM+2n0xS1VT5xg=;
 b=l5lllv048aszda/Pkt9LVRqG3hdj1m5jvUMXn0Db5BpqjY28eLfDw19iGVz86ujYoXCZRRSaY
 eB6M0o8TJXjtb5BJvyL0fgQZ12PerIfeIj5ZtYww6/ppoZmGN8zAERyqI8ffcAFoosBazd3c9cL
 bZHYTL4aI5koohATffopYQI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jDF600tkQz1prKW;
 Tue, 27 Oct 2026 10:38:00 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 781404056D;
 Tue, 27 Oct 2026 10:38:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 10:38:06 +0800
Message-ID: <44901187-8131-4831-903c-e4e38ca887a1@huawei.com>
Date: Tue, 27 Oct 2026 10:38:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] drivers/net: remove check on VMDq modes
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, Bruce Richardson <bruce.richardson@intel.com>,
 Xingui Yang <yangxingui@huawei.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-8-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261022174447.412638-8-david.marchand@redhat.com>
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
> ethdev now validates requests for VMDq Rx and Tx modes.
> No need to validate again in the driver.
> 
> Note:
> - for igb, max_vmdq_pools is already 0 for models that do not support
>   VMDq, so checking the VMDq modes is unneeded,
> - for i40e, the FW flag was already checked to populate max_vmdq_pools,
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

