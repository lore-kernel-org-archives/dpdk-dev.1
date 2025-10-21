Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E70CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 08:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA2B400D6;
	Tue, 21 Oct 2025 10:38:56 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 954F7400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:38:54 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=3h75XwgKTJQfKj/cvr3BU7YkQGn6Eni6tB4VJgImZCk=;
 b=oncHj+5et8Bjj7kVJnUb8vEwSsxd2QDlfn50P8f7T3wjEgDUFOwDwmVKn6TE7boLz/3QNbQtZ
 wW8sl5FJFsg7D5/achJoAW9V7M7MZb5Ok/km9kOxtCF6n7BMTfUrPtvh1C3f7A3qapdPsaxVvMu
 wjGIe1wVBzucg9W6fCDQZps=
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4crQg80Mh4z1cyQ9;
 Tue, 21 Oct 2025 16:38:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EDB0D140259;
 Tue, 21 Oct 2025 16:38:51 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 16:38:51 +0800
Message-ID: <4d68d7e5-99de-4736-9e33-2872a3da7e4c@huawei.com>
Date: Tue, 21 Oct 2025 16:38:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mbuf: optimize segment prefree
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251020120202.80114-1-mb@smartsharesystems.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251020120202.80114-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

On 10/20/2025 8:02 PM, Morten Brørup wrote:
> Refactored rte_pktmbuf_prefree_seg() for both performance and readability.
> 
> With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
> now fits within one instruction cache line on x86-64 when built with GCC.

Learned a lot, thanks

> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

