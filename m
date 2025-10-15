Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3F4CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 13:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B50E40647;
	Wed, 15 Oct 2025 15:42:40 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 1FDBC40613
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:42:38 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 643F61D000F0;
 Wed, 15 Oct 2025 09:42:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 09:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760535757;
 x=1760622157; bh=7k+eCieY6AXnjSjgzC3nAdfEXOpQZYy5IpR+PqYgvNQ=; b=
 ZZHNoVmQHaW8dwast2PxsE1NgjnJhquP1ZNmJShCOqdcNW98057sj212psSf+PS8
 NAz+EEngIY7zFeF3BEszRTqk7dKbSiwVlb/abviObwhtyOcuy5YiB0j6/qbFG6V5
 C/yUS7lKpRd5Wa2kn3vAUrks8viVaKWqKEzAy9jpvKQ+yqIPBngVFCzA2w1jv9eK
 gxNdKKIE8HJa26B3mdl/D3dO2C071IQNaqX2RFhSsYl3V09UvPwUPfMNK1TWyVjP
 q5NvTnCHgUHAkzmXEEWOTPT5BO4+3+H0hWfLaEuwPbSKvogzil0kppvt0mekrfxQ
 juTjacyt/g0efoOid1B8gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760535757; x=
 1760622157; bh=7k+eCieY6AXnjSjgzC3nAdfEXOpQZYy5IpR+PqYgvNQ=; b=J
 4JfOGUSq9PPPZial9j4z6bYcaqY7eOC73BPPjy+ULOaPYwoIxzcy6Npvlv8rgXIS
 LIsVi0vBWzUMAcd1lUOo3KGmyLM8AoZVSyKgduUxZHVTi4umLTuNrikQKglnMi2x
 Ps5x37a35RfoXePN6o2hoZ7TKpuKnkNV0SRzJGWVM3oENRI99A3i/v8EteeDqWSp
 O/Y/vNAVY8m4OtbBPkB0v20OdKMRBkGO5G+sym1NNNhSJdmhWT5zjiSFGJ80avHs
 6Xrp3XO7xfl5jN785SR7aE43CF7wdncnneUmyCbsRmAVawdTrmCoPPk078nYwpnp
 ekIw8IuUTx8FcH3lA314A==
X-ME-Sender: <xms:zKTvaKb7x2Lb8ahaOSDtkUqC-WK6sAYpi9MFK0l536BSO0XarBbkaQ>
 <xme:zKTvaEYKdA9k2MHg-cw6JfRD0Yx0MJffgQQ3Nq9IE7L2IcI1t9TV3uuYxVPA8iV93
 6AElCsb8dXN78s_pga7J8m8tOZlQFDePpoCpwtG-L0ttuEfexiX>
X-ME-Received: <xmr:zKTvaJ9RFXC0JPuEe_mMYwJWSzUaFHJmv4HEoIz0yLOnDLYHuf3scmc0Kc8oMr4JLVZh75ATQyQX2dq8AYL1Lg48vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtth
 hopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:zKTvaLioHNrfd59HYQobNtoZ6xp6Et4wAuOWIx1X20Bo5sFY1DHANQ>
 <xmx:zKTvaBdcqmQRviasXzlA4o5ukO5JcJfuU35_ZLvVkWje2BJg_bX63g>
 <xmx:zKTvaKotEBGzYEINHTEpUpObrIyIcMDvVtpripkid84BXcZcaSkb3Q>
 <xmx:zKTvaOBAjdkl7KfPlIex6HCUZT6okmGj13onm8nixRXu31ZnsBXCcw>
 <xmx:zaTvaNNhYu9ccNhVculet0O6Riu1_YrV_R355bi9xWGfj6xoEzVDz_-O>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 09:42:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, andremue@linux.microsoft.com
Subject: Re: [PATCH v4 0/4] improve cmdline file handling in testpmd
Date: Wed, 15 Oct 2025 15:42:34 +0200
Message-ID: <4017506.usfYGdeWWP@thomas>
In-Reply-To: <20250731160041.914837-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
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

> Bruce Richardson (4):
>   eal: add basename function for common path manipulation
>   app/testpmd: explicitly set command echoing on file load
>   app/testpmd: allow multiple commandline file parameters
>   app/testpmd: improve output when processing cmdline files

Applied with rebase, thanks.

Please work on deduplicating "load" commands handling.
We should start reducing the amount of code for commands parsing.



