Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F97CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 02:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D69B4028D;
	Wed, 29 Oct 2025 03:02:10 +0100 (CET)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 0A83A40262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 03:02:07 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RptjHc3jS+lbx2PKg1DVCJ9Cv8QdlM1geCnSX5TDMRo=;
 b=ntk8rD3SA9PPRnJ5yINHdIALG7wqRaphPfhsTFNypy6JibuM4NNbQXMmvZB2fbncMZY08WUHc
 F2pXz/iG91M3X3lOSB/Z8kqG3Cjx484usbKkbh6fS+qzb2V7Wsygl2utqvCWr4d1+I1+lgRJ+DP
 jWNHJMESufYToEA3NW0a4qY=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cx9TZ0Qn1z1K97v;
 Wed, 29 Oct 2025 10:01:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E7FF1A016C;
 Wed, 29 Oct 2025 10:02:06 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 10:02:05 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 10:02:05 +0800
Message-ID: <53e527b7-4c47-4419-82e5-e02f00273f3e@huawei.com>
Date: Wed, 29 Oct 2025 10:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config/arm: add HiSilicon HIP12
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>
CC: <dev@dpdk.org>, <lihuisong@huawei.com>
References: <20251028084259.4925-1-fengchengwen@huawei.com>
 <20251029011626.9298-1-fengchengwen@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251029011626.9298-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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


在 2025/10/29 9:16, Chengwen Feng 写道:
> Adding support for HiSilicon HIP12 platform.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>
Thanks,
Acked-by: lihuisong@huawei.com
