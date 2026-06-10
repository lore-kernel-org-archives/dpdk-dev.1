Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB22CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EE7A40151;
	Wed, 10 Jun 2026 03:33:41 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 14D9A400D5
 for <dev@dpdk.org>; Wed, 10 Jun 2026 03:33:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vKvnYuwH52V340d4hXmkfdez04f3s/L3QJY6GLAHk+A=;
 b=nyL2qwPhXAQLekbWuvlstngegbeD0FLjGIL+84KdSRqrjE44NnevqkiLvsAaGQFmCfBKrgwKC
 rLODjon2bR3WSlovhRnWJXBxCQtzQ6JSxsd7LRxB8uVwv2PU+zcuW1xzzE0D2zXcSJFvGyg6xf6
 xxXJVtVfpNLbNDumqnwCMjU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gZp4q57mXzpSt8;
 Wed, 10 Jun 2026 09:25:47 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id E38D840537;
 Wed, 10 Jun 2026 09:33:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:33:37 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 10 Jun
 2026 09:33:37 +0800
Message-ID: <e43698eb-e29e-4a91-a1cd-6b520595a07e@huawei.com>
Date: Wed, 10 Jun 2026 09:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] uncore power improvements and auto-detection
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
References: <20260526081138.1434947-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260526081138.1434947-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.59]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Hi Sivaprasad,

Can you take a look at this series?
Currently, uncore core use intel_uncore driver by default on using 
AUTO_DETECT.
This series can support automatic detection of uncore driver.
After this, user don't need modify l3fwd-power to run amd_uncore driver 
on AMD platform.

/Huisong

On 5/26/2026 4:11 PM, Huisong Li wrote:
> This series improves the uncore power management in l3fwd-power
> and adds automatic detection of uncore drivers in the power library.
>
> - Fix uncore deinitialization for non-legacy modes
> - Enable power QoS for all modes (not just legacy)
> - Fix uncore help text and log messages
> - Relocate uncore initialization from arg parsing to init_power_library()
> - Support automatic probing of multiple uncore drivers in AUTO_DETECT
>
> ---
>   v2:
>   - Remove the patch which add global uncore init and deinit interface.
>   - Remove the last patch in l3fwd-power about these new interface.
>     Will send them after this series.
>   - v1 link:
>     https://inbox.dpdk.org/dev/20260512023513.460169-1-lihuisong@huawei.com/
>
> ---
>
> Huisong Li (5):
>    examples/l3fwd-power: fix uncore deinit for non-legacy
>    examples/l3fwd-power: enable power QoS for all modes
>    examples/l3fwd-power: fix uncore help and log info
>    examples/l3fwd-power: relocate uncore initialization
>    power: support automatic detection of uncore driver
>
>   doc/guides/rel_notes/release_26_07.rst        |   6 +
>   .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
>   examples/l3fwd-power/main.c                   | 256 +++++++++---------
>   lib/power/rte_power_uncore.c                  |  46 +++-
>   4 files changed, 178 insertions(+), 132 deletions(-)
>
