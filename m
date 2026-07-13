Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE1C44506
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 03:57:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB7340298;
	Mon, 13 Jul 2026 05:57:15 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 8934F4028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 05:57:12 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DueAd8OQQXNOrWk3tlTQHETh/1msbDcFkk8o1dEccew=;
 b=aR34OiEq6mdFy60h7I7HIAcYDyeIKRkdQvP7OsyriuVabXrHGcJxYWAXFPWpN9cO62p9mkGpd
 fhwk8ZlXXeUeqCD0h8KbrFVCQ9U/5pI9X1pkhkQAwkEQdlrdA5liiq8nvTTb71pCHHIn7H0QOVS
 BGvTyEgqhZ5RiRty15HNRs0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gz7gY6Wg5z1cyPY;
 Mon, 13 Jul 2026 11:47:53 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 714F14048B;
 Mon, 13 Jul 2026 11:57:09 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 13 Jul
 2026 11:57:08 +0800
Message-ID: <fd9a711a-2aac-43b5-b29e-398f361e9a50@huawei.com>
Date: Mon, 13 Jul 2026 11:57:07 +0800
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Kindly ping for review.

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
