Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05AE7DEED
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 14:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F30D2409FA;
	Mon,  2 Feb 2026 15:05:31 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 88BFA402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 15:05:30 +0100 (CET)
Received: from debian (unknown [78.109.64.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 86992E06DC;
 Mon,  2 Feb 2026 18:05:29 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 86992E06DC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1770041130;
 bh=426b1vdgF8vf1/J47f3PAJ9QCCS3V2K+FvyQLwcsy8Q=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=hJkRtrzn20JLyej/oXUORkNwPeXsUWUpv9roKi2lXWqrsJEJXnOurMVWg1eqcF4lk
 D1BS+Gbsjs7yXv8Vw4xuszMdoER2+/FI7q5KslresDiu/oXlkIJNF08u0QBiLQwlfw
 126jWniWCoOsqjWmO9zF3JILav6pnIHAmbyaq0C6W6pAEuBYsaP+Md58DE8aGRp9hU
 SMBBnlooMuELsemIMBVrLcLw6P/V+Ncy2u8LlVK36oPp4Ww5+5MKfNH+HpLDIiZ/wg
 P+/caOOxmpHEfkDPNh/z7U80ncKMZW/davffayQAJPOBhACNzj/nxZadeE/jFI9FfN
 beR+A8dKdd49Q==
Date: Mon, 2 Feb 2026 18:05:22 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Thomas Monjalon <thomas@monjalon.net>
cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Andy Moreton <andy.moreton@amd.com>, 
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>, 
 dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/9] doc: remove support for AMD Solarflare SFN7xxx family
 boards
In-Reply-To: <5939885.GXAFRqVoOG@thomas>
Message-ID: <ebd63f2d-0a71-7774-d0c1-d2ee3405c4fd@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
 <20251229213527.37907-2-ivan.malov@arknetworks.am>
 <5166877.LvFx2qVVIh@thomas> <5939885.GXAFRqVoOG@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Thomas,

Apologies for being late with response.

On Mon, 2 Feb 2026, Thomas Monjalon wrote:

> 01/02/2026 21:17, Thomas Monjalon:
>> 29/12/2025 22:35, Ivan Malov:
>>> +* **Removed support for AMD Solarflare SFN7xxx family boards.**
>>> +
>>> +  7000 series adaptors are out of support in terms of hardware.
>>
>> Just to be clear, it is only a doc change?
>> The code still works for this hardware?
>
> Please, may I have an answer?
> I cannot merge into main that you remove something if it's only in doc.
> It is blocking, I want a clearer message to merge please.

The code is still functional. However, the situation is a bit more nuanced.
In fact, the fix contained in the series is supposed to make the driver
work properly on late Medford2 adapters, but for early devices, like
SFN7xxx, this fix might cause issues with flow control. Hence the
doc message. I think it serves some valid informative purpose.

Thank you.
>
>
>
