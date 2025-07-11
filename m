Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BBFC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 15:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D643A406B6;
	Fri, 11 Jul 2025 17:13:04 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 437284025D
 for <dev@dpdk.org>; Fri, 11 Jul 2025 17:13:03 +0200 (CEST)
Received: from debian (unknown [78.109.70.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 67391E09F9;
 Fri, 11 Jul 2025 19:13:02 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 67391E09F9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1752246783;
 bh=O2WkYRTwvR13Sm55Pzv6984aAp620zGhOpniPl91nQM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=QtKPkyzhTjFhTYoIq9d90RJ3347L0BfoWItAtF90T5qYs2Vb7bd+bW9uMGQ6yglPN
 7suvyJHDp0BYkpl3Xxc9BK/mwqMvRzZPTVr7GUfRNobNkMFHJu+nC/2sjdhZk6IXL3
 epCdCeFOw/VGsKQtFopGfk/FyxRGRqm/X1lGxzcSNC6vi3KfQR1K8KGo9R4wpTcSqo
 PGc5EqSzHU2QgVcZxZv+C2YWkdOziQ8LXv46C5DB2DJotDyRdDAW7k8lpqvemTEAnV
 MKf1+nYqiQAYl7dDQZbZvWY6vrsz45xwqcPCBwRlKx5MpboA7OmOyMrRu9TkqBM/nq
 6DTmdWbGYwP/g==
Date: Fri, 11 Jul 2025 19:13:01 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Andy Moreton <andy.moreton@amd.com>, 
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/3] common/sfc_efx/base: fix compiler warnings in X4
 netport API
In-Reply-To: <20250711075544.2fbbd18d@hermes.local>
Message-ID: <2f5f5dd0-f183-81ee-480e-8ec7f64f1398@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250711075544.2fbbd18d@hermes.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1274137692-1752246782=:9620"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1274137692-1752246782=:9620
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 11 Jul 2025, Stephen Hemminger wrote:

> On Fri, 11 Jul 2025 18:43:46 +0400
> Ivan Malov <ivan.malov@arknetworks.am> wrote:
>
>> The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
>> This series is a follow-up to [1] to fix compiler warnings in the base
>> driver that are seen in Windows driver build, also based on this driver.
>>
>> [1] https://patches.dpdk.org/project/dpdk/list/?series=35095
>>
>> Ivan Malov (3):
>>   common/sfc_efx/base: fix compiler warnings in statistic code
>>   common/sfc_efx/base: fix compiler warnings in PHY link setup
>>   common/sfc_efx/base: fix compiler warning in PHY link getter
>>
>>  drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
>>  drivers/common/sfc_efx/base/medford4_phy.c | 1 -
>>  2 files changed, 2 insertions(+), 6 deletions(-)
>>
>
> Have your tried enabling -Wshadow and -Wduplicated-branches and -Wduplicated-cond
> Those flags are finding stuff in other places.
>
Thanks Stephen. That is very useful. I tried adding these flags via meson.build
for common/sfc_efx, common/sfc_efx/base and for net/sfc trees and the only thing
I was able to find is as follows:

In file included from ../lib/eal/x86/include/rte_byteorder.h:9,
                  from ../drivers/net/sfc/sfc_ef10_essb_rx.c:14:
../drivers/net/sfc/sfc_ef10_essb_rx.c: In function ¡sfc_ef10_essb_rx_qsize_up_rings¢:
../drivers/net/sfc/sfc_dp.h:27:27: warning: declaration of ¡_a¢ shadows a previous local [-Wshadow]
    27 |                 typeof(a) _a = (a);     \
       |                           ^~
../lib/eal/include/rte_common.h:817:34: note: in definition of macro ¡RTE_MAX¢
   817 |                 typeof (a) _a = (a); \
       |                                  ^
../drivers/net/sfc/sfc_ef10_essb_rx.c:535:33: note: in expansion of macro ¡SFC_DIV_ROUND_UP¢
   535 |         nb_hw_rx_desc = RTE_MAX(SFC_DIV_ROUND_UP(nb_rx_desc,
       |                                 ^~~~~~~~~~~~~~~~
../lib/eal/include/rte_common.h:817:28: note: shadowed declaration is here
   817 |                 typeof (a) _a = (a); \
       |                            ^~
../drivers/net/sfc/sfc_ef10_essb_rx.c:535:25: note: in expansion of macro ¡RTE_MAX¢
   535 |         nb_hw_rx_desc = RTE_MAX(SFC_DIV_ROUND_UP(nb_rx_desc,
       |

But no extra warnings in the base driver.

Thank you.
--8323328-1274137692-1752246782=:9620--
