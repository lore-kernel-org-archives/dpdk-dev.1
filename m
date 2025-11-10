Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD4CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 00:59:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 773F1400D6;
	Mon, 10 Nov 2025 01:59:36 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 77CA0400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 01:59:34 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=6LzT08VXSpLNWdUCiwWUdyTfkVxDiYfJ1DKBkFVp61Y=;
 b=I6tyKAmrsD/PWm6DpOkU0EKME7uxf0goaA7nJZ63GKUcQrsxzpUOyDGh431VV4/VNu1up+LRz
 0Pinsho+OqhpAiTzIcXu2kXoqkFcJXFT+yka4pNFuc7wCLDeMhA0AlHF5iX6fi3pmdzNVACwXfn
 8yqoZevVIacKWVB/uJweiGI=
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d4WVT2V5LzKm51;
 Mon, 10 Nov 2025 08:57:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 08370140277;
 Mon, 10 Nov 2025 08:59:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 08:59:31 +0800
Message-ID: <b03c5c49-c1a7-4003-a350-587e0e6b8341@huawei.com>
Date: Mon, 10 Nov 2025 08:59:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/33] eal: add more min/max helpers
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-2-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-2-bruce.richardson@intel.com>
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

On 11/7/2025 11:49 PM, Bruce Richardson wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> 
> Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)), and similarly
> add RTE_MAX3(). Change name of local temporary variables in RTE_MAX()
> to allow for combinations of RTE_MIN(RTE_MAX(...)) without causing
> shadow declaration warnings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

