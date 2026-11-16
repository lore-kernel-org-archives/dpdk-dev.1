Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89337606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yMHW9ex6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01DA740296;
	Mon, 16 Nov 2026 12:35:40 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTPS id E3BC3400EF;
 Mon, 16 Nov 2026 12:35:37 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=KPE/uct1I3rU+rQYZlBaP8UD1J7jfb/xJchq2Wj7zWw=;
 b=yMHW9ex6Fl1JGcq1lNlyNn/yrA24JICUwvm585JcLuFyL0sIWNM/M1zWib0ANn7Dn7ZEKYyjo
 h/PX12SaPCkfiF+BMNZTfvleUbEB2DN5JxOhoQE61TOh6smcand2Ze400sZqHzhy9OustQCkL7T
 +HgOEC2SJauZSWk62kwGC/s=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jSm4h1lxNz1cyPf;
 Mon, 16 Nov 2026 19:35:16 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id DEA9240586;
 Mon, 16 Nov 2026 19:35:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 16 Nov 2026 19:35:34 +0800
Message-ID: <5e77e952-e82b-4662-ad37-ecf6cd60800b@huawei.com>
Date: Mon, 16 Nov 2026 19:35:34 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] argparse: fix null dereference in corelist parsing
To: Artem Novikov <naa@amicon.ru>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <bruce.richardson@intel.com>
References: <20261112153039.291045-1-naa@amicon.ru>
 <20261116085852.16580-1-naa@amicon.ru>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261116085852.16580-1-naa@amicon.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/16/2026 4:58 PM, Artem Novikov wrote:
> Parsing a corelist without a value dereferences val_set even when no
> default is configured. This also occurs with
> rte_argparse_parse_type(NULL, RTE_ARGPARSE_VALUE_TYPE_CORELIST, &cpus).
> 
> Return -EINVAL when the default is missing. Reject a NULL input string
> or output pointer in rte_argparse_parse_type() before parsing the value.
> Add regression tests for both parsing APIs and copying a configured
> default.
> 
> Fixes: d78103fb9488 ("argparse: support core lists")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>

