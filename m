Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5004CCD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 710A34065C;
	Wed, 24 Jun 2026 03:15:10 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 4EB2440150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 03:15:09 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Cnj1ApJgRDJnC18KeRcRqJ6js+ZV6LBhdvBhzEoWTVU=;
 b=qCcesYfBWHVpA4+fS4zDpZSxYLKDc3+lFXx6aGCL65GapF5E8jJYCWTAXJOa8/LxDO0g0b3aT
 O6WeIq/U2xZsH1BXIybbJ/t0d9csCCRxny4rOboPAwYjcmhZ409x8kz6S89/BlkSJagq5pH6UAc
 hMbG0a9kk4wJNUgEim2oApk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4glNzz33W7znTVF;
 Wed, 24 Jun 2026 09:06:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 8625B40561;
 Wed, 24 Jun 2026 09:15:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 09:15:06 +0800
Message-ID: <cf93250d-de7e-4d07-8908-706ecbdccdb9@huawei.com>
Date: Wed, 24 Jun 2026 09:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] bus/vdev: remove driver setting in probe
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <longli@microsoft.com>,
 <hemant.agrawal@nxp.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
 <20260623105439.2144694-4-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260623105439.2144694-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 6/23/2026 6:54 PM, David Marchand wrote:
> Setting the device driver field is not the responsibility of the
> probe_device callback anymore, but that of EAL (see local_dev_probe).
> Yet, because of the VDEV API, rte_vdev_init() must be updated to mark
> the device as probed.
> 
> Fixes: f282771a04ef ("bus: factorize driver reference")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

