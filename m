Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCDECD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 19:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 678C840270;
	Sun, 10 May 2026 21:49:53 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id C56EB4026C;
 Sun, 10 May 2026 21:49:51 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id ADEFF7A008E;
 Sun, 10 May 2026 15:49:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Sun, 10 May 2026 15:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1778442590; x=1778528990; bh=ff4SeLlZGaaVyCyJkrhXj
 Z7MBihuQIzYUGQuIpHP03M=; b=bp4i1oyPCsGsiYzxOy0yLHrzvLEhXodAKq5Wq
 PTNj9MmToQHGbE1J9p/4Wr7so6RLbkXs56+n7EShgsN+4OPOe5h/lC5951MgZmF7
 t1mwTOmD0LDdidgvKcfzT4aeLuxKV3kFnwq/33SLFbdwzV8h3xdhj4ANVcrx8vYz
 tmLBy8rfNkKQJT7QfeYgOomEhA/RceDt8l6yzMKtOKytcVgDkowbfP4A0UEu37v0
 FS5NlL0ckKzmOhWNicW6aoEHcFJRE9OyLAw56h+JoQZux10BnP0NnFQ6GrtKACox
 ym3hye/9wHU2qEaCc7/KKf8Z7bRJw1hrECvyZNkpDODMNwjhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1778442590; x=1778528990; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQ
 uIpHP03M=; b=UuZIPZxG6CT/Bzt0zuxPRrNFyuzFnDCuEnug9o0s+dIK7SaKIab
 nCNELc/clqlGmqr+NaUCWxneHtt35NLPgD7nRNL2AcDmktsYZf3e1+MLqU5SgSEN
 Woo/za0uwisxDoNvd2qi/aD8GJ5pVC7ZTHW96s9W5TmD7AauSoX13P4tPGKyRkG+
 Gxfjtu55IKiwULMqBtZDuIf6MnB0OAfWAlteiGQQDEFUaDW+2KaitYZ7cGnO1YXo
 RNku+9bJaZCIhtxSWi7IM50T5E6uwERTObJJBMcKsypUbcUMbZia8od4A0Vdc5LJ
 NgBDyf1T0DHTE3rJmoc6PgUNibPjE9ya2aw==
X-ME-Sender: <xms:XeEAakPIE-YyvFtS8kvtEt8enVDMz1mg2lYV7dzLf6OghTLcZptQuw>
 <xme:XeEAalDWacYVZt_kdABH8YoIFv8YpWI0Vjbiki_vzdT9k19rfkXiqx-q8xUEzYC_K
 SzACeOGy6sojdoeWd59GDBkzfiWUgDPF3uM84_hp0ZhdEwVmpv2QS4>
X-ME-Received: <xmr:XeEAarJ7NvePr_wKthzpU1ncaNLqF8e5-OmFaPxvDOOZNusfJmMyldhvfq0Uboq46ReHK-GgbXfnVdTOh7gIC25WqXM5Yh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeileekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheplhhutggrrdhvihiiiigr
 rhhrohesrghrmhdrtghomhdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvug
 hupdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvgguuhdprhgtphhtthhopehj
 uhhrrghjrdhlihhnkhgvshesphgrnhhthhgvohhnrdhtvggthhdprhgtphhtthhopehjsh
 hpvgifohgtkhesihholhdruhhnhhdrvgguuh
X-ME-Proxy: <xmx:XeEAauOR1SdLWlcMkQFRmFpnVFRU1aEI2MvigfPyrqdB4zSmabPAVg>
 <xmx:XeEAap7N0cHtu_WCaszDr9VGtC_DoibBK5TZsephlWxfXtCPbna_2w>
 <xmx:XeEAag6eoQtAfApYrPkcSsd33428OaEDcANg8RNVV1StECwsFd29kA>
 <xmx:XeEAanFu9ygMse7jPUbbboAfr7x-uyEdsMnrVR-FiaqpqiGpjzrJ6g>
 <xmx:XuEAapOOsfCKgGL4oboPV5fwrhT1osODGCo4rROTX-6HvrCAfML8T4fw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 15:49:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH] dts: fix topology capability comparison
Date: Sun, 10 May 2026 21:49:34 +0200
Message-ID: <20260510194935.182258-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

TopologyCapability.__gt__() was delegating to __lt__(),
which caused infinite recursion when "other" is not a TopologyCapability:
other.__lt__(self) returns NotImplemented,
Python retries with self.__gt__(other),
and the cycle repeats.

dts/framework/testbed_model/capability.py", line 579, in __gt__
        return other < self
               ^^^^^^^^^^^^
    RecursionError: maximum recursion depth exceeded

Similarly, __le__() was delegating to "not __gt__()",
which returns True for non-comparable types instead of False.

Fix both by checking is_comparable_with() first
and comparing topology_type directly, consistent with __lt__().

Fixes: 039256daa8bf ("dts: add topology capability")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/framework/testbed_model/capability.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 960370fc72..96e1cd449f 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -574,7 +574,9 @@ def __gt__(self, other: Any) -> bool:
         Returns:
             :data:`True` if the instance's topology type is more complex than the compared object's.
         """
-        return other < self
+        if not self.is_comparable_with(other):
+            return False
+        return self.topology_type > other.topology_type
 
     def __le__(self, other: Any) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
@@ -586,7 +588,9 @@ def __le__(self, other: Any) -> bool:
             :data:`True` if the instance's topology type is less complex or equal than
             the compared object's.
         """
-        return not self > other
+        if not self.is_comparable_with(other):
+            return False
+        return self.topology_type <= other.topology_type
 
     def __hash__(self):
         """Each instance is identified by :attr:`topology_type`."""
-- 
2.54.0

