Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10CCA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 22:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E373740276;
	Fri, 29 Aug 2025 00:45:49 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6BB5540261
 for <dev@dpdk.org>; Fri, 29 Aug 2025 00:45:47 +0200 (CEST)
Received: from debian (unknown [78.109.64.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B2EFBE0499;
 Fri, 29 Aug 2025 02:45:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B2EFBE0499
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756421147;
 bh=7OzJr/0tWgJd8nRpEnHUYhjRpDgVvjNEe31K1s8DgxA=;
 h=Date:From:To:cc:Subject:From;
 b=h1ftI1L7gOuDaF8Mc2WOzqCPllvQRxp/yIXn9pKfunHsbFY6NB+J5bL5TicZHu3RY
 FFyhwy/FVgmAc+zwDkzmrzZ3vugPR8Vlu/XGhxPLSVceNAxMhHvM/1t8YtVHoRX9cJ
 Uc1zFhd48IHLB1u7HZOoBBl7jCG/MXvC/kvA98BbFdpqDvlkOgmBfDzP1UBfroj9tG
 OqdYRtTAfGUWlxtZF0wHTSbHudDlrBrxVER/Q5HQ0NkUaa8Qbol5T67i4JjIPROTx6
 MoVvQdGHV1et9pksQQmcrmTdcQ9+bN4LZkByP/NqRxbulYfGNQ72LoiBq0CLn7zvRy
 LtsQwqagBrH2w==
Date: Fri, 29 Aug 2025 02:45:38 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
cc: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Andy Moreton <andy.moreton@amd.com>
Subject: AMD Solarflare PMD roadmap for 25.11
Message-ID: <cbf6f000-0119-39a6-c262-9c1375c78060@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

This communication hereby serves as notification that the following patch sets,
as described herein, are the candidates for orderly inclusion in 25.11 release.

1. common/sfc_efx/base: link stability improvements for X4 NICs

    common/sfc_efx/base: fix autoneg detection with netport MCDI
    common/sfc_efx/base: default to auto fcntl with netport MCDI
    common/sfc_efx/base: fix auto FEC selection for netport MCDI
    common/sfc_efx/base: use auto FEC on start with netport MCDI

2. common/sfc_efx/base: sync DPDK with the in-house libefx repo

Please be informed that series (1) is in its final preparation stages and will
be shipped in early September. Series (2) might become ready by late September.

Thank you.
