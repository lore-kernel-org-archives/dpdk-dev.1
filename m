Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A067CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E9E4068A;
	Tue,  2 Jun 2026 23:41:10 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id F26914067A;
 Tue,  2 Jun 2026 23:41:08 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 2BEAA1D000C3;
 Tue,  2 Jun 2026 17:41:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 17:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436468; x=
 1780522868; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=g
 5C8HejFi5tQ03o4dsqRei+VR/VM14AXwt0GZnKPUIFhBbEfxI9W9LSXWyzvsx6wK
 OcW6dEDCYBYs7Kvib8VbtogQhHV2GJkkHJ1HH3oEaRG4tcNnAQWEGbhNZkcawS5o
 pw3UB//C1OOckBrhwDlMdCd2FqzOUHgIbJApcGq9kdyRH1XDLSSiclgA6Lqp19r1
 XBPNc+q5JxUCieOJ2kzWoPUSrDgf4WVw4D+fMBjtMtzh4nSTu+8++XBWl9/hyybG
 HQFbeauBtD3wHsuGwyjYk3nZx4zQv6gwnewf3uB3dm5E6zmh4Q0Jia22/wquKieB
 kE364efvlVw02xdWroBEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436468; x=1780522868; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=SGvZPidcWI454wtf2
 jShaDjQ877MmRw7Y0hdQwVwu17/x83Lkz7SX6Hf8uDqj0lkHPhLlNOr4kUvnkmiw
 XWqxmja85fpBmqal7IBh4JstVDmbJ8obZu2SMlDWomqK+KK/Mcz5UdqXWLMR2M3U
 A7JKhMqphiBTZ575w4DjsocMaVqVh/+Am4n++pPLaiSAR/RuaUe6PSXvMq2AbdLl
 h2x1nK495DrgxiL+KOt6Je+JO+fAi4BmqywiLintqE++XhgcyjjHCfJwsG7F0Ys2
 aIS36BklmG2Q5yaMsYYfs7WKbqZCK+bZAzE8Jbs6D+eQSyJQTyPdV8bEy9c+XEfs
 H4AFg==
X-ME-Sender: <xms:800fanJrjUDgg91uoPR7F2dgpWvCEJAvgpAojsVPWLyXppTr7SLkhw>
 <xme:800falJJwOiLND23sqYDlsaPJiDH_qjjGGc40HEyem_jbxv9sNLyJflCpa4V8dtM9
 L3OyRfAO2zDme20xDOJXMOYpDWIAioGrQlJV8d9iYqLNtFr6iQF>
X-ME-Received: <xmr:800famVylbeyaZqA9sopNf5Q6VsCtRX7dipturauBos9uSJxDyOrjVYdp3YtW07RGJkpLbgZkFqpbCV9fkbdu3FVCWKPwkg>
X-ME-Proxy-Cause: dmFkZTGHseB7aRJBb3avwuhxSfpcSflfkyeLAEs0iZuKspSED7sytxlq5ki7NqTRdlOwGZ
 7ZFJEQmAhD4HgAM/q7rKf6TRN0Qj86JonY7YRM8FxZbkxPBBTjf+ZeM3/6prywmKrOChSY
 tI6Kzo2FpflImYOv9v7nO+z8Sy2u6HSFRFf10aNlOK4Ir5cbameQInuvLkzQ6vB7aQOs1C
 ENBp11nCNHMd8WM3YT1OWxddqHYkTXkPE/8hHyPMbAPkr0vkQuwGekM265h8UuJ1QtUcLU
 5rSNAedZgQdINH4IpOnJHwp1d2jbR1JtRxWnxbphliyY8SnWmQ1gWufn3ecI3oRJCmRRTD
 yX60mlbhRZTNrUtsae9nWILfMdH+2uueuJmN7+55UnvDuXhO25+Gkd+qDJG/BfI+SKLjX+
 39l2Eh6mVoJ7PS2Ayt5OHiPo/0qukeff89qL0wb+p8sUityQPvhiAqFtukal4o3YQh1928
 6ME/GKTLcTM6JI5sIeNbx5D3mfyMogqVOYOAXiFV/lczOiAUVNpetUL5oVz8VYfESx5A3G
 FC30wcNOx7p+JBj2oluAOI2VuSUUFfvjTa9p49cKJguIzDpyhyYlhkytUvXXxCuU1TPeZg
 ZpgW+a0BKfGGzJDc29kFigWWA/wD8ScXnv9o15RYIzloraw5NnMHSYDWTTqg
X-ME-Proxy: <xmx:800faulwPFubsxdjnab19PW41cAevqM3dqZLLiRG8ihWquy0D0AciA>
 <xmx:800fasm5vM1s2H0ZiZJezkWu5NZxRFJgqdRMd4sNNap1mQcf_qQj8A>
 <xmx:800fauaQRe5mCeD22fXaXmCd7pB-MxOYzcXRZcWC9c-Mmw2mWzLoUw>
 <xmx:800fauQq84Ijr1DKsgupIn8hrMVZOGW2tmu4lrnegIlvyj1vjxAm9Q>
 <xmx:9E0faudizEdXRckFnkUfh7RG4ThTOTTy0gLZ-wZQI1MCrOEE1URgrCb1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:41:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>, Dean Marx <dmarx@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>
Subject: [PATCH v5 09/10] dts: fix topology capability comparison
Date: Tue,  2 Jun 2026 23:38:40 +0200
Message-ID: <20260602214036.3606359-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
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

