Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D55C87FD2
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 21:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419AF4026A;
	Sat,  2 Aug 2025 23:33:54 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC7040156
 for <dev@dpdk.org>; Sat,  2 Aug 2025 23:33:52 +0200 (CEST)
Received: from debian (unknown [78.109.75.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id AA383E0155;
 Sun,  3 Aug 2025 01:33:51 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am AA383E0155
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754170432;
 bh=Q4hGnMQL5ISqPrfY2lPeFgplnnIEBW7Nqd7wXAF3lIY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=peddgq09xX7L7eoCA2UCSwEDn1kIWnsSfQeHWQdPmUSyjVLz/m/d799tngxfjqynk
 W3KSAgyBh68t2vRY4n8ZuqqVEGUnlZQP8GjQopm7a9kgyGKY05qTlVxTPK8Ydto7Ku
 9RO/sG1lVquCBLR25HEwgz3D0YV7y/yNtQPWR64bMYmMK8GjClwfWICii3uyN8JU9e
 586f3CiRq3ogKwdEYlo2wx1YL8U6orWjaNkMVWMBM3JOHX12MRWLJ0SVtgf8Khw56z
 Ox04B4QH4RCPKPLy0K4Ga8Ecwkij17yDhPlKUehp3/ed2sMlUTNcZqr0Yyc5uoGup2
 oJs53OeX1XTJQ==
Date: Sun, 3 Aug 2025 01:33:43 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH] ethdev: Reject conflicting TX offloads configuration
In-Reply-To: <20250802135354.158d8561@hermes.local>
Message-ID: <66e365f2-8398-43b2-58a6-cda29bae08e1@arknetworks.am>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250802135354.158d8561@hermes.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1420803534-1754170432=:6753"
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

--8323328-1420803534-1754170432=:6753
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 2 Aug 2025, Stephen Hemminger wrote:

> On Thu, 31 Jul 2025 09:07:31 +0000
> Morten Brørup <mb@smartsharesystems.com> wrote:
>
>> +		RTE_ETHDEV_LOG_LINE(DEBUG,
>> +			"Ethdev port_id=%d tx_queue_id=%d, Tx offload %s potential conflict with per-port Tx offload %s, "
>> +			"runtime support depends on the driver",
>
> Shorten the message, and get it on one line.
> When a message is so long it won't fit on one line, it is too verbose.

I am not an expert in naming, but on the premise that 'ethdev' is already
printed by 'RTE_ETHDEV_LOG_LINE', perhaps consider this variant:

"id=%d txq=%d offload clash %s vs dev %s: PMD to decide"

Thank you.

>
--8323328-1420803534-1754170432=:6753--
