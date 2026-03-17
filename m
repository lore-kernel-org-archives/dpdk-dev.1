Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28159FD876A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC4A402B0;
	Tue, 17 Mar 2026 14:28:36 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 55D4040270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 14:28:35 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 569311D0010D;
 Tue, 17 Mar 2026 09:28:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 09:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773754114;
 x=1773840514; bh=FOcIUK+8cTath628iqg/Q5yAyN/m4ENcyfGadalYuHI=; b=
 gYu5E07NVdkpWaE1owUjSFnhticmajJu915GyiRpXLnLYa8K+gBMgSPOHO9JKNDn
 PM2D9jAWZczS4YKdmONz5o7VnqxTu6vkfSKI2QJMJQuc30h6qjlPPEKnpW4el3AB
 hruhBlkrQbJZECY+UA6IZMtxtqd813P3m+iM1pdPSh37+zM6nUbb9J0qFAD9KMSy
 iVno/G4rlsRyVz+X/tYkKgB9XqERuRQGwKyRvKXk0fCN5eK3AhFS9L9mKRjeRXIK
 FK4LJ7vwam0MC6mqN3G93skLkH5F4DIqiR8has+5zFy96vpNtFIMBmDGn5O7cgh9
 VXOJXV96Xt7BdeYWy7XTiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773754114; x=
 1773840514; bh=FOcIUK+8cTath628iqg/Q5yAyN/m4ENcyfGadalYuHI=; b=D
 1xgxdzpZwao45Wg/dfHMKS5EB9DgiiEeDZQhBYIqQdynpAvrMErgcvXqs9QlNvKl
 0cRs7AntyQXHNBaY83E+PVs2awQVIyNG/aOwhjLbIM29FynW8h2i8boRYOHtxwmZ
 3nE+4qKCpz4tak8ZmmGzYYRVyQicXnvB6Tws0Du79Mi0VK9Rk3nw2vzT0EcZe+nb
 5kk0rz4ptZEGYhZJjfvWHeWCb9f6yy3M8j/gxsrIRQ3udTDus4Bua75DgVPRq5if
 rYB2X+iX0psecw5tCWM2cQL29apK2OmviVAKh9XTH0gmE4cw/kAD8gxl3NLhfoIO
 7k3Lqz9eH4M0/xM/7hT0A==
X-ME-Sender: <xms:AVe5af2UZ6YYcMt9Py63ku3XozX43T94AIcZshNbrE1nrjZxN3yNQA>
 <xme:AVe5aaaq3Gpn_S2NHAE1JFp3pXLvyTNbVq69TwrJ1b29VCKWU3WdW8HoQ-jPGLANf
 lfbcvXwvdNglOBh2-h3be3xa0CocgK05s4CiYFdXWxyuyTN3gtmTQ>
X-ME-Received: <xmr:AVe5aSrWTBWpTg22UpqKmnet-gT5IZygsYpXvnqfJ7UWcpe9HwA2K-L5Meupa3u8nqvPoWsX9qtKyYZz7FpHAOjR8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddufeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:AVe5aWqLbM0tmZo7i5xiG1Ja83wCNcavUxv08kzWys_9ORpfckQ2UQ>
 <xmx:AVe5aU2OeaLNsjmj4A31mEE5uPPm1wXLm2coA__Kl7WwnH2l6uIwvw>
 <xmx:AVe5adANcYApLqRnovw1Ax3qlFNNVOhlnr-TLJRC6W0qLvTOjbX4Gg>
 <xmx:AVe5aUc_EkiWWq_NqlQoYGgDFwwvXKPY8_eaNTrEglEWS9aFsba_aw>
 <xmx:Ale5aeUlSULfTPlsmpDPMjMu3uMd-m36m50y6J4acAfCGr1S8WgKXK1u>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 09:28:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/11] test: fix test failures on high core count
 systems
Date: Tue, 17 Mar 2026 14:28:30 +0100
Message-ID: <3361123.aV6nBDHxoP@thomas>
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

> Stephen Hemminger (11):
>   test: add pause to synchronization spinloops
>   test/atomic: scale test based on core count
>   test/mcslock: scale test based on number of cores
>   test/stack: scale test based on number of cores
>   test/timer: scale test based on number of cores
>   test/timer: replace volatile with C11 atomics
>   test: add file-prefix for all fast-tests on Linux
>   test: fix trace_autotest_with_traces parallel execution
>   test/bpf: fix error handling in ELF load tests
>   test/bpf: fix unsupported BPF instructions in ELF load test
>   test/bpf: pass correct size for Rx/Tx load tests

Applied, thanks.



