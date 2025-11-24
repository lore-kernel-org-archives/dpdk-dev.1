Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE96CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 18:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF28402B1;
	Mon, 24 Nov 2025 19:11:35 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 20AC7402A1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 19:11:33 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 416CE1D00117;
 Mon, 24 Nov 2025 13:11:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 24 Nov 2025 13:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1764007892; x=1764094292; bh=aEbzZ3oCx1nKSPEx48VHQ
 hyBx9jwV/gFzCLWvgUbyPw=; b=TVhpTQeGFJWyTXJi1/uxIl40OMu0sTTN2HZcU
 3zhTSQez31woO3AAvGSkWC1nHm/JFqiqDerJtAtgST6lJcVenjqjTxcqV6wVcHic
 WoiKWAmV/zDVx+crBWrbgWgxGWnZjqMNVlbQsQLPwDb1ktWuVmuU9JdBxtrHHyQV
 GLnRFveaGcWziZuaO53rgxmjxjF86LDexIWbPtcojCWstrqbEExezyQ5/T+6HwZv
 9qk2+uv637kO49YxfFnri0CBKFtY8Imlce4oZSmbPGxAfpw0HklZmc1+iv7ojvW/
 pqaiytls2I2UvCvFoIqlgLNulHKQ6kgavbzOteVu40b/QFrsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1764007892; x=1764094292; bh=aEbzZ3oCx1nKSPEx48VHQhyBx9jwV/gFzCL
 WvgUbyPw=; b=eBke+ovlAtbH07XsP/TNrsOpP3FaSPh6FA62RvL+Dp09YkzqhLb
 YuY0ws1cCNWLoZ9deCgTv69UGRoHxe50NO16NcOGPBFmFlvdNJXz078w/a+XXUl+
 z+2KUSCGt1Ev5yb5rqpx+4orHImxhy3R2XvbEamXm9KsivO9cUf+A8M1Nlw+kQLn
 I/jIT3zoeBdMhZoct1DFMUR2QsWm9zSvUzXiC/ouHGiz6+eKbvy1kOjRxMUCM4P7
 roUqaGJ2b0/Wvnu8nFMgq92FMCEqmXpI9i20Hwf0ijtJt/JANr4XlWh9ACI33YS0
 sdjeMpZUbxy6H0KJyAu8HVx6AuC19yyUbiQ==
X-ME-Sender: <xms:058kaVLiHBb9BIwMuT33COdyUOYdocZYZ_6flmEPjolK63X9iOW4qA>
 <xme:058kaRSKyyehy-zgtWM3lzFAAdd9yKpCs_ogYpVhlxflVOAKjDUSkf4J7mZjk796K
 Fqp83DEHk3fOarMpojEhvyxZlHz9t1dt6hnmTcL8ZkPe3G0qeLU7QY>
X-ME-Received: <xmr:058kaVrM-t-3T-Lysq_66bJAi8wDSFK6yxkKyUKcFld-8wvtcvMm75n6NUux0c5B0XNJJ6m5NAZrQTHEl1deAxW0httrCnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelvdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthho
 pehmrghrrghtrdhkhhgrlhhilhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopehkoh
 hnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:058kaeqeiIO_56f7OWQU8VsXGFO9EzOr07PTAatRePkRT_zSgMjsgw>
 <xmx:058kaXPzk5lIUg1DjzRou05ZZC55rBpyGFiEIxxIPjoM124yG8GeVQ>
 <xmx:058kafwH3FHGXVbRxpaZIiiA1QNbxGuohvJQdy0jGvl-IOeRNaYlYQ>
 <xmx:058kaQsEbRvkbaaxEcPQgJ8DYwoL9mTmHrWoeojI5AzqVoa8VKzg4g>
 <xmx:1J8kadx3V92OJ-YcCKjJihva6h0t_pgO4UH6mtzgP32vXuKYN1QzPJT_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 13:11:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH] maintainers: update for BPF test coverage
Date: Mon, 24 Nov 2025 19:11:23 +0100
Message-ID: <20251124181123.3427921-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When adding the directory app/test/bpf,
the file MAINTAINERS was not updated.

Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

---

Kontantin, are you OK to be the maintainer of these new tests?
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27a4981b10..d7d8dbdb25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1907,6 +1907,7 @@ M: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
 F: lib/bpf/
 F: examples/bpf/
 F: app/test/test_bpf.c
+F: app/test/bpf/
 F: app/test-pmd/bpf_cmd.*
 F: doc/guides/prog_guide/bpf_lib.rst
 
-- 
2.51.0

