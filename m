Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC4CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:28:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2102F402CA;
	Wed, 15 Oct 2025 09:28:04 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id CBC44402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:28:02 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hvHOHMhftSV7qaqGV8jLckDMyl6QedsvLBak4DBUWY8=;
 b=R5Ndfa8tAD/pwwBsiAugzIyEoURO55alXhXKTxwakEtVqeH1Tm2XtNJyAu60lEQMD2Kl8Uw9F
 nuzSWAWJXAAI+jwvsI/2helCz+hWFZlcEIKx8nb4peZoux1bEZ5WHhwBfMDqEAz+Bv75sNEJkbt
 jGR9xdQBE6bdJMZFigIFeC0=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cmjMZ0nb1zpT1J;
 Wed, 15 Oct 2025 15:27:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 867D7140203;
 Wed, 15 Oct 2025 15:28:00 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:28:00 +0800
Message-ID: <fc3aecfa-9936-4e0b-8ad4-e2edc89deb1d@huawei.com>
Date: Wed, 15 Oct 2025 15:27:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/21] build: add define for the OS environment name
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-2-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251009130056.2630343-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 10/9/2025 9:00 PM, Bruce Richardson wrote:
> Introduce a string define for the currently running OS, or execution
> environment.
> 
> Originally, with old make build system, CONFIG_RTE_EXEC_ENV used to hold
> this name string, but the variable seems to have been missed in the
> meson build system, until commit cadb255e25d6 ("eal: add OS defines for
> C conditional checks") which introduced the RTE_EXEC_ENV for a different
> purpose. Now we can fix the docs with the new name reference.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

