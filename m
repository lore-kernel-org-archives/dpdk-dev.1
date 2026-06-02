Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC591CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2520A40A6E;
	Tue,  2 Jun 2026 23:50:59 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 5E50540A73;
 Tue,  2 Jun 2026 23:50:57 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id B8FD61D00060;
 Tue,  2 Jun 2026 17:50:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 17:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437056; x=
 1780523456; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=X
 Fqsloz/ujdBFz9i8i/D7OlBrcfDiYS4o4Tll120LI0F09fjW6SMz+7L/yLppAqKg
 XaF4M3ie4zt1kcrOiUn3kDCBn2STkz9Vd3Tc+73WUDjEDiTcnlkqiWLNAmQl9s0V
 8SSXs361/YwrYa4EK9pRFGG+JLrxDMfJJ2bVUSK39clo8Gm934PbYNMImaRUCpK2
 BDxwDtMSUAtsSt/HxdsotLhzYBpLqn4lhEC84NEbzz+ULZcGWAT0NrdN0La6QY3F
 vh77lOT7pr6d0+eKhZlO4q3EJwaUdbQlqIRmonoUozzUlrh71If08jaACoWSGjjt
 9dLbsJWa3jg/8CqLE7KQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437056; x=1780523456; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=CpMudtHhXz7xjdNpg
 86I/UGDpS+FOuFdlnqHcSHtGOdwi63jY9samr1psu5R6CH10jRwU0wyPrI2/p6lL
 k/SKhZ1HfjpjWehnKGcnhld9cUi5Q6bCW2U9qXqSIirGUf5BjStkK7PyQ6eYpVom
 bUa9GG2ri/E7P+M7Ut+MIWh0ALKJpcI/ETX1pNttZlSVd7gdx6N8yiMwd8sNvscr
 ueFjttg57Cb4lUzkHC3kaayNxTf1fu3UrXsR7Chmf0933W98azb4Ro9E3HmQaLQ0
 9mg0xA2IaRWcqV2Trp40HQYaVAF+LxiI8DNVuLsNpUwe0eyrcgT2i9Ih3lJ/UKaN
 0cu/w==
X-ME-Sender: <xms:QFAfam3AkBflx7FBYuxjegBWB9vo1U7yvYcWreX7rWAzAxyhMdcXnQ>
 <xme:QFAfajH66HQaa9DfvzyMZXim8C5b2UIJ-_eARjQ-KhWyae-Unjp9e_aSJ27KL8xXE
 dKIlXJsgc0rCME6Z-pgNqRHq_MHhAKNqCi6wCg9U1NwJ3USxJ5KCA>
X-ME-Received: <xmr:QFAfalgbZWOVv4evdaQ3QSEK5j_LCcDUdpsGPUa6UekbHgczI7BDXi6nVUnn4rHuSC7HKZO40RWYSpxLLciA0PmnTYCCHqs>
X-ME-Proxy-Cause: dmFkZTEd20+xfCVjrf96WpnI/v72S2VrZhIEfjy2DdV5qVGCOkfAkKoXOuznD+wlW2CRfO
 mdA7+fw+Y9LhGbZOfgfhJkviOaYdeMvONyVHMHxpW27WN4T/Y8z3LkyliUYV6MDGdUeKc2
 aSi3OQ1RCN9UbDBK4D6FAV5Xc1/q/sNWWReejWCpAvD5zKlZSYC2oEs6dLjH9PDM0iqoRg
 mbQImmzzq/dkUTtOeCs3Kmc7B1WssBx0dy3KjUwIHJNS/Z5542HrzblWZsCFqegIHoVN7v
 4VBnjtcRKrWW7TwVkFhlGSr0RVby6CWGnDYWtEySdlCA4gs+pbA0CdOJbMclL/nvmTO3oO
 zjFfsLZj5yhP6oG5Bi1Or45lYYH+K42odemIM6VDF1nwJspGQMa0cbzi0joUZbQ+xe7nDW
 IzBBXRZ0v7pFyWkIYp87meKGjZrbETyMz8HstVULq+oJk1pfUlI7hupbxGiWxJEQ6NQQTw
 OuVkEoHPBRHWUMKCXuCS3belmux46BLr+9HlSAgtJ0qaFUth3A789dhCGdxNiuXjVeHOwg
 HArI55AtyMjLF9EJtGoQ8bBYXScW5P1apbm/V4MxSMCK3Yd1G+TT8jksMztEXgd4nchRiz
 BVChEeVTDdItLhmeBdgoYkF0QNBV6PcN4Lhz6tYFvoPaQkMiK8f3AiLW7GkQ
X-ME-Proxy: <xmx:QFAfamCydY7a-pORlWywmP3K5cGdKc2uUgf4yt67Hfgt9WooDzCg9Q>
 <xmx:QFAfanSDopmsZ6Nj3-L4YB7vL-2lECSEPLDn6qdhTArYtVYSf3y-1w>
 <xmx:QFAfarUQ8GU49U_NPYidn5AH9ZzTaHcH1LgIfvNsg-20BaSYCu3Gcg>
 <xmx:QFAfageQM_o7IcZ77JJ_152VN629odSIrSSNkBV1KSU0XbwKGJZ-yg>
 <xmx:QFAfalGyfsMpIQSV8WJNFPwNDjIHgcswLstOmPzYgOCny-hye9VwU-Kp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Dean Marx <dmarx@iol.unh.edu>, Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v6 09/10] dts: fix topology capability comparison
Date: Tue,  2 Jun 2026 23:49:21 +0200
Message-ID: <20260602215022.3698662-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

