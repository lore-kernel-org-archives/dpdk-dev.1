Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018ABCD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:50:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D4F7436DF;
	Mon, 15 Jun 2026 11:50:37 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 60F5A400D5
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:50:35 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5JMqM40U64/lElymdATRycb5Bez3RwrMY081AmBmTRg=;
 b=ofsZJdS/bodg6QrT2fSR3FLl1/3nhTUALB2LQeNLbI1wK75Po98j2cK6jqqFugg81s2TEU7y0
 Uyx0YDWujMJng5NKYHKpEpqCpZty5lSYZIlSpyi+0iUsRLPOW/H8DJCp7fN0HiMg851amuRw9sR
 auJqG88Wo21JvBwjOF1dsuc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gf4sj6dpmzmV6m;
 Mon, 15 Jun 2026 17:42:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 749FA40594;
 Mon, 15 Jun 2026 17:50:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 17:50:32 +0800
Message-ID: <dbccfc80-6527-476c-8870-c9050f0188ae@huawei.com>
Date: Mon, 15 Jun 2026 17:50:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] doc: improve clarity and consistency in DMA sample
 app guide
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
 <20260611212119.1026721-6-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260611212119.1026721-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

On 6/12/2026 5:18 AM, Stephen Hemminger wrote:
> Enhanced the DMA sample application documentation:
> - Simplified MAC address modification description using bullet points
> - Improved grammar and readability throughout
> - Standardized terminology (DMAdev, Tx/Rx port formatting)
> - Fixed article usage and clarified technical explanations
> - Enhanced sentence structure for better flow
> - Corrected minor grammatical issues and typos
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

