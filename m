Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B36CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C15C400D6;
	Mon, 10 Nov 2025 02:17:48 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 2C77A400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 02:17:47 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=55Lj4w6eww2J//WQ0tQalscfFYXxWnuClIZQ+tnpabQ=;
 b=gKQTnh5AxhbLMeI9RFNF65rOH9T2e0kLk6bPvibumwoF0LunV1mxk1CQYXZuRcEyB713osT7s
 5kgWhYABHk+STjlmAJbcHPsJX8Aca0LXLxqGP+uzEerv1SJ0poJv/yx4HU5oZJyX7JPY/5p3bLL
 qNc9IjwysTN0279UXJg2juw=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d4WvV43MZzpSv7
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:16:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C3F61401F2
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:17:45 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 09:17:44 +0800
Message-ID: <90c12477-0fdb-4137-adb7-563c8b564d48@huawei.com>
Date: Mon, 10 Nov 2025 09:17:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 33/33] build: enable shadowed variable warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-34-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-34-bruce.richardson@intel.com>
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
> Enable -Wshadow globally for DPDK builds.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

