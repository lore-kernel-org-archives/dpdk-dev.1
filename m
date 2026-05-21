Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2791BCD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34651402A2;
	Thu, 21 May 2026 16:54:18 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 8B1E7400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 16:54:16 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 109D21400053;
 Thu, 21 May 2026 10:54:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 21 May 2026 10:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779375256;
 x=1779461656; bh=RKSm+VXl6JFNYMYQGKjxKpOFa1pWqE2mLhRekhkzIFc=; b=
 lm2pRpcHPeQk0wodOwwrj1vgGonQAnSmQ+Ge6jLLZzCSYXeF83OuWUtE5DYJhM4a
 C1IionX65an0oOpI+OTgj6H21fdqV7PyjHhRtrnhGZ50f3vUnda9YnaNeMfTTaRu
 Qhf+om2spzAVURprBTwyW0k04vwpAIby22iawKMCRyQTaQwO4Wv2gYPWywW81c0q
 vMUYfRFS4Fi/MxUc17qXIzR+5R72wuhVj2CBFs3lZ4tcUVGcHVr+BXXhU2zSdfR0
 aydeqB03BIRuVdVnl1jiasb/YKNQHkhts5QNGkz1CRjkQpmG+btOJkXTnH/NuIZ5
 1sU74OX8T7PeO9XwzTTSGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779375256; x=
 1779461656; bh=RKSm+VXl6JFNYMYQGKjxKpOFa1pWqE2mLhRekhkzIFc=; b=d
 TJvVzj2fX0kQDaqzyY7BSRyXwTaNDPeXqSv4nk6Kb+HbzqXyyRy5sbum8bZU84Jv
 skTwPqQubmAlqvE1uH+MLefc9bwUNYmchrnv2KT0jtbo/kfb+hy9SU2sOKsc7aNY
 +LZH5CuvPY1VmnE/YzK68PaVbYGzJSCNbnw7MnPvtccNYGNlLwm+3qkhO3QQExIz
 G/C4qUllxtwodRQOd1OsdNK6eEyQ5yv0v0w0VnXCdG0m/XeFHgxTO/nLcNKEvpjj
 VN7+tIe/8F/9L2Uy2IT/E6QrErwRSZhbX+h8vH6rVq22mcb1lWZNCmIzTX9zawNn
 GjNliGZyBei+4xtHc8xHw==
X-ME-Sender: <xms:lxwPamUWN7SfovDPIE7LNROsDaFWgxTBbv7nXm2dhSd1XTi7NaAZVw>
 <xme:lxwPan1QroN46BkJJpd5L5SkGw85uLsrIreEv5hsypXSrvnypFMfHcS-wwFkO11wg
 vxcjBiLxAUJ9MwZMDLftwu0HGnJWPS6BPRaLHGwmOw11M-KQmIULQ>
X-ME-Received: <xmr:lxwPasEyWB-vh42qRDf5ajJvLG6IvIJC4PSCLPBP2HezAQbKDCHr8F27xognmaGMBMw104U9SY-QX5iHFQSQk99xUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejkedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:lxwPalj4W_LTJZfYIx34OuSe9aGB8conU7AGVNeZDk1DjPI0CimTfw>
 <xmx:lxwPan8WQjsukFEHP1BzkTGdHUGfZ0oNeZ1BmeSKwcC2vpqsrL1_JA>
 <xmx:lxwPasorNGRkqZVjkUtJyiW57UjDL5DX9Gw8hEljFjbIouy4SiMZ9Q>
 <xmx:lxwPam8MXrE70ixXFbw5QHQBhH7qrxeRy8YZX2Ot16uebGk0JtGzmw>
 <xmx:mBwPagQF0xv5Cou0XDs1m-MYs-Jl7WheAtmPAUkO8mIWUTyliU47ccn3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:54:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 3/3] test: add test for af_packet
Date: Thu, 21 May 2026 16:54:14 +0200
Message-ID: <7d4P4SdzSECmXjb8mYjlMA@monjalon.net>
In-Reply-To: <20260429182055.398105-4-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
 <20260429182055.398105-1-stephen@networkplumber.org>
 <20260429182055.398105-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

29/04/2026 20:19, Stephen Hemminger:
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/sockios.h>
> +#include <pthread.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>

There is a compilation failure for ppc about sockaddr.
It seems sys/socket.h must be included before linux/if.h.
I'll do the change while pulling.



