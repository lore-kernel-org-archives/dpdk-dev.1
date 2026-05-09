Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCDCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:05:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED55340684;
	Sun, 10 May 2026 00:05:00 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 7200E40687;
 Sun, 10 May 2026 00:04:59 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B7E3D7A0060;
 Sat,  9 May 2026 18:04:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 09 May 2026 18:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364298; x=
 1778450698; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=Z
 50DVmQncqCtWikxoUO0w4vpfDyMQJMyP8bJp0ArTuJgjBfX4aR1HD0sbLs20jj+d
 OWc+ubEWswWn5OCUDKiWSuYZ70Z0A4+59XX+mNg4mlveNkVSX+wUwVCG7+zFqx5Q
 D43l7VgErVwSmLpJPNszSQScudyUpzSD6HI2VeMhqhNqAHLPpqD8Dtqv8m8i+g1M
 R8AVGBm4HZ0OLWhfMXYODAx8i6BV9KYB9whDp9ycSU0/pm6EIBMtbTvV4rwpp42B
 v3d0P8N2fFp7gegduvAts4xlFjnDQsFkKqLc0mIYFsn2mpaf1DZ2G2W0C+Th9n5e
 Em682cMujk1FIsZ3BNkOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364298; x=1778450698; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=YQjIEFEancdpubpa9
 dfYBQHZNpEcXjNqyqihQA9rNNCDOUN5qoCwRK0lRpim775WLAEbrCBn9jlWOfcUm
 NRbxADdcYj6H9+D9CjQ+VHJaxb7x5g1CVWKvbAAVqvEyK6QhsB8wQpSlem4HEa+F
 Wo5BEThIfu7jda0j9zFa0uVlgwvP8YCON6J+jldpj3gTm/MH9CU0zN83BSEKxtu9
 NfKEb8tx211cigGYsa919zWZO1Jzi8y1wfyXLpg2+MfFIvdtMiFg1wCMWM/k5m3x
 9TNW0Yq9laQ4uJH/4wxV4nAD+s5H1YDefbAYaW6CcqpyQXkzTkWzbu6IeCjoEslx
 DXTGA==
X-ME-Sender: <xms:ia__aWvWI0UDxS4PQ5keZTh-EbuCNcJMMPXxoI4GFsgs_L1x3KAByQ>
 <xme:ia__aXdrQvjNGOW-q3tQNxSJYmzhpNyl_xp2x1iTY6dt2LcXDuM4axxSroGbO6WfV
 s5WB5WkGlGqkWC0a5euDNq6T1HsafnrSilYEcfchYENo9KFWET-0A>
X-ME-Received: <xmr:ia__aT_8Sye8QzXoCV6r4WMZEK9hNCLu8JaZ34PXnturFI0WhiRMQG70SVr-UDX9-ZxV03uSczIq4mUiNOdq3dIAo2gMew8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheplhhutggrrdhvihiiii
 grrhhrohesrghrmhdrtghomhdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgv
 ughupdhrtghpthhtohepjhhurhgrjhdrlhhinhhkvghssehprghnthhhvghonhdrthgvtg
 hhpdhrtghpthhtohepjhhsphgvfihotghksehiohhlrdhunhhhrdgvughupdhrtghpthht
 ohepughmrghrgiesihholhdruhhnhhdrvgguuh
X-ME-Proxy: <xmx:ia__aSThwl4-TW9j1qJuE6G16ms2SDpDdgzrAlEG2siqfVFSyPdnGA>
 <xmx:ia__aUoJjruGte5JmFtVppG3hKckie_tPc0s1TAlIR216tRaint5oQ>
 <xmx:ia__afkll0HQ7-mvepW_9RBCbIuL_irwqUvz6ARJJRQnECng_3Cyug>
 <xmx:ia__adcQhSr5jsD2h22qSYlRpCMA3pDVaVwuJvQWLaz_-TRvp9fqYg>
 <xmx:iq__aX266s06ndTTzrgijqoPmbfVTyjjF_-Ss8Nm2E904249BmQ2WfmE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Jeremy Spewock <jspewock@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 09/10] dts: fix topology capability comparison
Date: Sat,  9 May 2026 23:57:00 +0200
Message-ID: <20260509220356.3679114-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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

