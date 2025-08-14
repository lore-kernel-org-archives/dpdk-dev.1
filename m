Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58313CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 12:53:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41DAD410E4;
	Thu, 14 Aug 2025 14:53:27 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr
 [80.12.242.29]) by mails.dpdk.org (Postfix) with ESMTP id CCE0F402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:53:25 +0200 (CEST)
Received: from [192.168.1.64] ([2.14.111.50]) by smtp.orange.fr with ESMTPA
 id mXSPuWtMLz3scmXSPuiUDA; Thu, 14 Aug 2025 14:53:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
 s=t20230301; t=1755176005;
 bh=pZDGukc57aiAJhdg7dJFpsyKDkwKUfvZ6PGM1FsUgOI=;
 h=Message-ID:Date:MIME-Version:To:From:Subject;
 b=dMKepw40F7BXqDMvT1n6box1IZO3Zn2dn/7n5vLAd26X/PH2gymTAaBdrKJkgiZMM
 mWwnGXVgNQe2jG69FNDSqNZeuCQBaCJ0vEGIukh6Ek9aBGT/Asq0XvFwYGeVPhA/CD
 8hSocyJpWVjmevUHoLL5WoN2wGZDbwYUDx1BwwZaroFycwgKhGq76GZB6RFvsX9edv
 uwkQXrYR244HOrK3apyL31wig08B6Nn4FWEY5XrLRLCVln5kwFs1PXm90IX7OtEHmz
 hXGySA/cCBIflKv36oBQ9o8RqRpFHiRg0DDUzlkpFys+jQU7eN7oMXyGrWOD/eGEe0
 BkT9ZXTdkj/Gw==
X-ME-Helo: [192.168.1.64]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Aug 2025 14:53:25 +0200
X-ME-IP: 2.14.111.50
Message-ID: <be3d5abb-84cd-44de-b7c3-286536f7f994@orange.fr>
Date: Thu, 14 Aug 2025 14:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
To: dev@dpdk.org
From: Francois <devel.fx.lebail@orange.fr>
Subject: Warnings in headers when building libpcap with dpdk and clang
Autocrypt: addr=devel.fx.lebail@orange.fr; keydata=
 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
 UvQeDHHSvLjDyg==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,

I notice many warnings. To reproduce:

On Debian bookworm.

sudo apt install dpdk-dev

git clone https://git.tcpdump.org/libpcap

# build with clang

$ ./autogen.sh

$ ./configure CC=clang-16 --with-dpdk

$ make

Warning lines:
/usr/include/dpdk/rte_ring_elem_pvt.h:13:36: warning: 'GCC_VERSION' is not defined, evaluates to 0 [-Wundef]
/usr/include/dpdk/rte_ring_generic_pvt.h:93:28: warning: possible misuse of comma operator here [-Wcomma]
/usr/include/dpdk/rte_ring_elem_pvt.h:391:36: warning: 'GCC_VERSION' is not defined, evaluates to 0 [-Wundef]
/usr/include/dpdk/../x86_64-linux-gnu/dpdk/rte_memcpy.h:25:36: warning: 'GCC_VERSION' is not defined, evaluates to 0 [-Wundef]
/usr/include/dpdk/../x86_64-linux-gnu/dpdk/rte_memcpy.h:873:36: warning: 'GCC_VERSION' is not defined, evaluates to 0 [-Wundef]
/usr/include/dpdk/rte_flow.h:176:6: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:674:5: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2223:6: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2235:6: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2247:6: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2656:6: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2940:5: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:2962:5: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_flow.h:4218:5: warning: declaration is marked with '@deprecated' command but does not have a deprecation attribute [-Wdocumentation-deprecated-sync]
/usr/include/dpdk/rte_ethdev.h:3568:10: warning: unrecognized parameter passing direction, valid directions are '[in]', '[out]' and '[in,out]' [-Wdocumentation]
/usr/include/dpdk/rte_ethdev.h:5375:10: warning: unrecognized parameter passing direction, valid directions are '[in]', '[out]' and '[in,out]' [-Wdocumentation]

What do you think?

-- 
Francois
