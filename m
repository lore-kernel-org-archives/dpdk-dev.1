Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79BACA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CC9F402B4;
	Sat, 10 Oct 2026 04:45:25 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 14CD44027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:45:24 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lkTE64GNr8ViSF33A3KrV1uIpG3WuukkXZZCfoivvp0=;
 b=C8rDNzFMjmfF0VXcU9ripbGKOmjCUveYt8KFssUTc+rH2fpD2EL3DwoGb8Nl8iR/sfUX2gmnV
 9wuxBGUTBynLGv0fu5GcsmTHWd84W5Mu4VjsVEBbqAo19Bwmy9BcMVj0xOz9t0jEs+wvbjDKoRG
 kMh/jdfu03+Iu6FQdVd2sU8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j1np84hVqz1prLV;
 Sat, 10 Oct 2026 10:33:04 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C3D0440579;
 Sat, 10 Oct 2026 10:45:21 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 10:45:21 +0800
Message-ID: <8bc7ee64-8c6b-495f-b0b2-09bb2c717b13@huawei.com>
Date: Sat, 10 Oct 2026 10:45:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] argparse: promote API to stable
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-16-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20261007214115.3092715-16-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 10/8/2026 5:39 AM, Stephen Hemminger wrote:
> The rte_argparse_parse() and rte_argparse_parse_type() functions were
> added in 24.03 and rte_argparse_print_help() in 25.11. No prototype has
> changed and they are used by the EAL option parsing as well as several
> applications and examples, so the interface is settled.
> 
> This promotes the whole library, so the header no longer needs
> rte_compat.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

