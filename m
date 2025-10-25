Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B0ECCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 06:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5408840262;
	Sat, 25 Oct 2025 08:59:37 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 0817C40156
 for <dev@dpdk.org>; Sat, 25 Oct 2025 08:59:36 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3338D7A01C4;
 Sat, 25 Oct 2025 02:59:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 25 Oct 2025 02:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761375575;
 x=1761461975; bh=4e2hcE2i/CN/N9pDYz2EXLcs1DBBwCbu4NXt7R/egL4=; b=
 Xse4OgI4VChXZVfEa4IOaMWewv3pOd1ir9ZYUmBfpOPdIt6u34BAKqidyg+dhTXH
 1dH7EZgjijMtowb6aQ/bHBN7TnCu9BoyEIcRLTue8RlWPFtoksN6khpXSOPDkyRv
 MMXWxlG2YMGM90229n9myGHiJzsU1DPUgdgxlt3NMUIYyMuBeYGchLaOPpRZG0uN
 Hq3Hx0wr4QyStcjF5GlFnvwzYxM6LvEYFyFFP03Eir7SMKSLISTpLmPmfGJzWc5T
 3rJu6iY0Je1Y1AE2E9HU5Hjy/Tm3zRCUdIf7gIqRtLZpG5oUL4CkDspNOMT65PBn
 6CkKPOdWJ0ozphv8nUIktg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761375575; x=
 1761461975; bh=4e2hcE2i/CN/N9pDYz2EXLcs1DBBwCbu4NXt7R/egL4=; b=u
 H0nkJmDNDVmfg9FOQdP4ORZKFqwKX4nCm6XtwBxamNlZUAFknRmeKGAp1MGm8lW5
 3Xg8xOQGD+g13Lwkl+IF9IalvjP6u2LuEz43hX+ovwcvY2zWHr2eHb4SFaA2zcdN
 G0m+SfIxaatGEgXBi/Ohz1NI7MjNDtRalRcALcLPAP/Kv3RQ69ZU+HtM7qLkSIGD
 sLIYf1NeB5DzJyrCTEEDRIOJdZ6RR+ISjUmi+/5Xz1cIzhEASS1+dOHnfc8YwVdh
 xsQn4ZcQj7802krdEX8J8Q6vcEau9E8flNPcx8Hd+TRwiYaXvmMn07X+Hvg+FORP
 uKRpva+px8NebhyWqUrBA==
X-ME-Sender: <xms:VnX8aBI7YnBsKAOgnG9H3YGu0nYlXsg3mHKgNH9o2e3ugoeOwOUvqA>
 <xme:VnX8aNTTDjZKzfM-HE7i6gUKkiez31HQylgoL8j78wOK5CrpGZ6JqaBSlAhP1I_6n
 3S2YP_ox0wYz0YVIl8R410v-folPaBtVFMinXF-jNIhJGgeDYZRIg>
X-ME-Received: <xmr:VnX8aBqz4-Nu4bX-OViQs8NcK9FVKA_BqYXvqYLQ88wbjwd_xaCLSFRRH7uMuWdvLkugCFj384YMDO1ddvtAawgBCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheduheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgssehsmh
 grrhhtshhhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:VnX8aKpeA6Zv0AeDUK1rHTmQbQsklaSe8m9l02UzH4WQT2kyiHfM0Q>
 <xmx:VnX8aDMYHtX4xj4GJ6pc5V3R9CG6dxSzMI4nRNMAepLkUEH6tovMkw>
 <xmx:VnX8aLwtsilWRt8EaXC6rqXcC1GuIgjcZuFW1xdUC_Uq3S_4dZBvlQ>
 <xmx:VnX8aMuWhbQgmo6qacvJtYJ7bxOYkF6a6XQ9gAAaqQbzUn6BEtKQbw>
 <xmx:V3X8aOcaq4GKcNEcbMdgpqAWr9CbCZHUDpo_IQjmhrTeD-P-RPBySdT1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 02:59:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shperetz@nvidia.com,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] mbuf: fix build failure if MBUF_HISTORY_DEBUG enabled
Date: Sat, 25 Oct 2025 08:59:31 +0200
Message-ID: <4952662.Fh7cpCN91P@thomas>
In-Reply-To: <20251024222946.323662-1-stephen@networkplumber.org>
References: <20251024222946.323662-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

25/10/2025 00:29, Stephen Hemminger:
> Message had extra newline which causes build failure.
>=20
> ../lib/mbuf/mbuf_history.c: In function =E2=80=98rte_mbuf_history_init=E2=
=80=99:
> ../lib/log/rte_log.h:364:9: error: static assertion failed: "This log for=
mat string contains a \\n"
>   364 |         static_assert(!__builtin_strchr(fmt, '\n'), \
>       |         ^~~~~~~~~~~~~
> ../lib/log/rte_log.h:387:9: note: in expansion of macro =E2=80=98RTE_LOG_=
CHECK_NO_NEWLINE=E2=80=99
>   387 |         RTE_LOG_CHECK_NO_NEWLINE(RTE_FMT_HEAD(__VA_ARGS__ ,)); \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/mbuf/mbuf_log.h:8:9: note: in expansion of macro =E2=80=98RTE_LOG_=
LINE=E2=80=99
>     8 |         RTE_LOG_LINE(level, MBUF, "" __VA_ARGS__)
>       |         ^~~~~~~~~~~~
> ../lib/mbuf/mbuf_history.c:219:17: note: in expansion of macro =E2=80=98M=
BUF_LOG=E2=80=99
>   219 |                 MBUF_LOG(ERR, "Failed to register mbuf history dy=
namic field: %s\n",
>       |

This check is enabled only with GCC.
Unfortunately I was testing this feature with clang, so I missed it.

Updated commit title:
	mbuf: fix build with GCC and history debug enabled

> Fixes: d265a24a32a4 ("mbuf: record mbuf operations history")
> Cc: shperetz@nvidia.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


