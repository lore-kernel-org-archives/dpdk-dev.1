Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C389CCFA18
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 02:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A26F40281;
	Wed, 12 Nov 2025 03:30:15 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 5B5504026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 03:30:14 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=FrEKCN/jX/B6i8HUewJ5H9FCzhgtkc4zvkVh+qRueOY=;
 b=pK/k6LePQqb7u7ZZi5ISlEw4QEu21HQVw9SNHPBaQ1xQ6gG0HIL7rJOj9OIjF0/sYMZ7Nh7iY
 6UeTMxEpDK9f80WJ7VjIF8tR7u9PqMm8+4w4AjKj1vXLK39HK5iv+sAnW6/96qjxuBDfmjgTW70
 Md7TesCl0phDn4OfUlGN8bg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d5nPy6ndyzcb0C;
 Wed, 12 Nov 2025 10:28:22 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id E42CB140258;
 Wed, 12 Nov 2025 10:30:11 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Nov 2025 10:30:11 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 10:30:11 +0800
Message-ID: <4e792aa5-7747-483d-bc30-d73ff4b5deb7@huawei.com>
Date: Wed, 12 Nov 2025 10:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] app/testpmd: support specify TCs when DCB forward
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251111091303.39491-1-fengchengwen@huawei.com>
 <20251111091303.39491-2-fengchengwen@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251111091303.39491-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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


在 2025/11/11 17:13, Chengwen Feng 写道:
> This commit supports specify TCs when DCB forwarding, the command:
>
>    set dcb fwd_tc (tc_mask)
>
> The background of this command: only some TCs are expected to generate
> traffic when the DCB function is tested based on txonly forwarding, we
> could use this command to specify TCs to be used.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
LGTM,
Acked-by: lihuisong@huawei.com
>   
