Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD336FD530E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0404027F;
	Fri, 27 Feb 2026 09:34:30 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 212D14003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 09:34:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Dqr/zoGiC5n37lZzKpF2SS+TcnH3DNq43M4MGEsaEB8=;
 b=2rIblj+93I78rfqRlkoGOzq9xEEiWFSrJB1AeUkPoNjzKpfhqwM4ltsCXh4Uxok3lpPkOUZkp
 a9Hu/yYVc+L0LAUdv4ZBKyiaTnRknJPLXDZj4G8Ym6Z8qh/+F841bETy4wXRLwd49oXrqg/MQD0
 ekSrMexY2KQHP313zNioi/Q=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fMhMP6W38zLlSN;
 Fri, 27 Feb 2026 16:29:37 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CC3F140539;
 Fri, 27 Feb 2026 16:34:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 16:34:25 +0800
Message-ID: <59136df4-304b-422a-9c64-62b76060ceea@huawei.com>
Date: Fri, 27 Feb 2026 16:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
References: <20260218101859.3028581-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260218101859.3028581-1-david.marchand@redhat.com>
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

On 2/18/2026 6:18 PM, David Marchand wrote:
> The .map generation script has no clue about build configuration as it
> relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in
> a source file.
> 
> As a consequence, Linux eal_exports.map contains references to
> HPET symbols regardless of the use_hpet meson option value.
> 
> $ meson configure build -Duse_hpet=false
> $ ninja -C build
> ...
> $ grep hpet build/lib/eal_exports.map
> 	rte_eal_hpet_init;
> 	rte_get_hpet_cycles;
> 	rte_get_hpet_hz;
> 
> As far as I have seen, superfluous exports have no impact on generating
> a shared library with the GNU linker, yet it might be different with
> other linkers (MSVC linker would complain, for example).
> 
> Moving those symbols to a dedicated source file solves this (non?) issue.
> 
> Fixes: 57c194d142d9 ("build: use dynamically generated version maps")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

