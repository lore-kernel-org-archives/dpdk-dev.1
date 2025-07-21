Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BAC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 19:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 055EC4026C;
	Mon, 21 Jul 2025 21:56:27 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 598D84021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 21:56:25 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id B5095EC026F;
 Mon, 21 Jul 2025 15:56:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 21 Jul 2025 15:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753127784;
 x=1753214184; bh=I6nr+TjeqYbaIntCCuuJQQI+yXTadMHtPyHpJ4qrqzI=; b=
 bWD7POoAJhbCyZuXsol/xJ2es4cXSAFHgGQM0YTNxe+iJ6wEx2XLrtpFjzYbYFPc
 JQT4GnKRaDXloQoLDTPw+i9LMTbwcp/X22vyYmJo9h8Cy6Xh+jMGSmNCFXZ9PGZR
 2V6KcL58J2fXwdFHWoGvhro2t0RSmmD11h4qXUHtv92sbpsAxMcw0UZJFZ0VO/pN
 fTo+xJcB34V3oH1gl6kl92mjH/f/xn9kMTfccM/trL00SoDo1RV6oFv+Ls01gJZU
 43CMc9t21j8QgUAoHka9t4K/Q7S8DW1g9FDJ5UiPyujWECcD11p9KTUPXw1ClR0+
 ltdKpgVjYPDlcimWyRQhFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753127784; x=
 1753214184; bh=I6nr+TjeqYbaIntCCuuJQQI+yXTadMHtPyHpJ4qrqzI=; b=Q
 FvfIosvZ3KCJcfGGbFe6dPk5sM+BMXMAlix2oRKH+SJc6DxNAcIKATTngC3HbCND
 KZigx8aB6lKoVrrYTG7I1NPp+sD5Fb2TjoTE5oV1/b/6d/NSKWP1e/4flj8MuFcq
 M17py3HiVTKjacQkDLgclWUm161br23tzZxpC0WaZETJVYAv86zKJchSLvW6d48u
 5E/mTKvGklSJyu/baPbeAq7nCbS3Fwgyia7gF60jg4sRiPECMcJqWLbZ93uftcMp
 jnC5m9FixEH6NtIvYs9mXg/8i0v8BG4gzJE1GVDaBi2ocR7KB+h7MAzN+aB/q/Pw
 jHuxyY6La4Lz4zJi8RYsQ==
X-ME-Sender: <xms:aJt-aIbdl0nqMPGzwrTFJZXClDbfkTg1sKKAIgOU-vQtA22h6BbUWQ>
 <xme:aJt-aKIG-7R16Wn9vhtshu6-xkMqCahfsKylSovzkDR3kkFoYCczDfwldEhBr4WCP
 oNk1PUEKlY-3X1XTw>
X-ME-Received: <xmr:aJt-aEs_42KiQcDCfi4krBWE6lWQr4Z3Z9mCWnuZekey12QUjHX6lBUM4wRkey0h1xWRwNlSwSDy5uGOMOcCe8trAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepkeefheeftdegtdejheeuuedtgfelfeeiveekieekleekffelgfdtveei
 heehffdunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 gushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgv
 shhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthht
 ohepshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnh
 esnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhhiug
 drmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:aJt-aOUp4S86yYY0d8MJAU_AqRFu4_XT5R3q0TIHT6rg0_TvRtKanA>
 <xmx:aJt-aPhJK_H5WSUi-Aqmrmdh_j7m02cLGsZkz9RhOKvHzROTHGsnlA>
 <xmx:aJt-aGp-A1abI3gRRrhVaw_KnZdDD0u8dplosvkORpWSt47O6Fj8OQ>
 <xmx:aJt-aFHFaUpSBZQIsJ4jQZxVXnihL0T3LDiQGqbmRomni7L7RNvMSw>
 <xmx:aJt-aKeAmmwwwIqHx6hx0o6ZzuilJg4rkR57ZV3rSktS73ut8gQqJHvt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 15:56:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] net/mlx5: deprecate representor matching devarg
Date: Mon, 21 Jul 2025 21:56:21 +0200
Message-ID: <15520741.JCcGWNJJiE@thomas>
In-Reply-To: <20250716093846.1117794-1-dsosnowski@nvidia.com>
References: <20250716093846.1117794-1-dsosnowski@nvidia.com>
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

16/07/2025 11:38, Dariusz Sosnowski:
> Mark repr_matching_en device argument exposed by mlx5 PMD
> as deprecated and schedule its removal in 25.11 release.
> 
> Functionality exposed by this device argument does not fit
> current E-Switch representor model exposed by DPDK.
> A new unified representor model, described in
> https://fast.dpdk.org/events/slides/DPDK-2024-07-unified_representor.pdf
> should be developed.
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

The impact is very limited.
There is no API/ABI breakage.
The devarg is probably not used a lot.
To be on a completely safe side, the devarg could continue to be accepted
if a user set it at its default value.
Still, announcing this is a good idea in case someone uses this.

Applied, thanks.


