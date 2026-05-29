Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DDCD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42F934068E;
	Fri, 29 May 2026 15:35:54 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 460464068E;
 Fri, 29 May 2026 15:35:53 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8ACA57A0098;
 Fri, 29 May 2026 09:35:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 29 May 2026 09:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061752; x=
 1780148152; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=a
 03CyolRXjBjKKy0Wi2RsxjqyIWgLwX0i6GlLBnom9yOSycqBU6aXCbsJoX1KJ7ea
 fc+j9nLSJBnaBiw3IotP3c3AmstH5yF+bhZYyav/BVuegV81wsU+diOOvkO3BYXG
 UDJcFCZiTBH6rtjQRQR3CetsZIIXpP6xDRTKGxXVSjvvzliceERFRW9YCeVCreKp
 vS09ig639vSPPJJFmrBcWCHas8RAB9sb/7GvzCvsFYz5OXxEwQxp9VjtOemZRSf5
 hCJ7qj5+e6uvuOVeuK1jQwbvJGTI3OJnMjyoG5sVxIxWXpWgS20exq4ZGOoMU7HA
 anQOIcjmW0Rl8oKzRp98w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061752; x=1780148152; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=VO60FuNdx9MlVvl22
 d4cyAZzRP4GQyJ3UJuSVldAOfh94+MCTbe0BQimHMnJwvXNrPv2ayK0OyCL1zml9
 gZYjqWmEugdxMz0yZCr3ux95TL2MF22MQ0k+aKpGW/KEloIjffYcJ3lhLc/z+tQM
 G2ZN17Y8yqKdj2oolpyVJZH38SpvIc3OhEuVkYjG2ltTddytbTPpcN2+Shl8Q15V
 Kv04dyCz8o4RPBZ0VTzl/qLTTF6NoA4a68/2Y4OI1VrLX+idRhbIVYUGvNFYHrRs
 4hmef98Wt7EQu32aPGgrhvTn/23RsWoXFDg49WTsANVL20troL1zu+4ZE1fj2y0Q
 qFDEQ==
X-ME-Sender: <xms:OJYZanc3MGOgh0NECsB7b8ITUssaSbrc91d6wxRNP7d6nZ8C3Ydm0A>
 <xme:OJYZanOl-VWfmufBeesiVXhRf4hS_vOyvrKTeWrqHys0M5pcimW5ys6WWZxG5WkRv
 0wuwzPs9Us2X5EzV38vvZmoh8zZ3bLoo105nBfu5qhAMkbZ-S4g6w>
X-ME-Received: <xmr:OJYZanJSM04uyCqkzPeZ2l9sneyLHrM7UIzTiWorMX7QHBHxjmv-xO0dSt_P7B3L3fet7dJkssnV_vR9HBP50ut0DXl3Dvc>
X-ME-Proxy-Cause: dmFkZTFeJYx8pKFBT/SR4IekV7meci+w9c7yGsG5hJTZRsASkDR3COJQXxdKqJBRlpRS64
 nK9n0L8XevT8uywhtWnGQxH9eDJ1B+Ahaz1rd4AAnqS9fVjG9wLLHL3ER1hJNPUgBJi+fO
 rAvrALGF6bSyHprcomtWWfepEClUzWI9eQ7GVKTM487QH6Wh4D7zEmxcEZBAKWvmLSyGj5
 uajsyWfpR+fdoREWBLQtBJmjnxyY296re2E+GQZApuVjroR2LOxwmH7maPqD6IlTMnEeAS
 WAa85KLoRzeCNrYkKScTXDBb3AJwtyCYQr2aoEibt2RavaREXJ9LR/jJplP5Bs3jYNFWqN
 hBKHRZh31BJDr5l+mTt0UWL0ZcGteGXyt8K0CLXaiWrlxa6t6pTB1rHRelf7LWN+bxu5Cg
 jrjt7ctepRUsgFBinGFNChO0oa+ILEHdsUE9CbDb1DxDQ0G61kLy6j7yUvqQKuJeJf/BrU
 TjdRajsYL1Q/0TVjKp73xITkxIJi4Y4oriyIL/seDIPyk52AMgWP1q/CuUdZgb7DoYALw2
 NrWICeThAdQtLt9N0pE8N3V+XgnPVE2OKtWb94P0UOlSeP0JfRvhlTg00xYc6xRAedCMJB
 tupXjAJZdfkyxipW8sgXH1iIEulT/Ol7W60EEyWS0+ldoVzVKwthtP9/DNMg
X-ME-Proxy: <xmx:OJYZanKEvCUi_yhiNG6b-WCX7iVJQGpkWA-E0tofpyy3NR9yTr6zRw>
 <xmx:OJYZah4hHugKTCXgZhliFw-ZS6ROszuxkYXUiHqVUOXVE1x2bIuJjg>
 <xmx:OJYZahfu8KQMaxs5ciryry-OK7whRM6Rue_oHgnLn6OuKq8pboY0yA>
 <xmx:OJYZasHez6YUb-lFvZ-K_YLOhrNH5BI8gbjKQg4t6iv2ocBEpBgUug>
 <xmx:OJYZamRfKt8XPBKNbIS8FSfVf5hZEWllipLGGhws018XikFel2I9fCUc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>, Dean Marx <dmarx@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>
Subject: [PATCH v4 09/10] dts: fix topology capability comparison
Date: Fri, 29 May 2026 15:34:03 +0200
Message-ID: <20260529133522.2646044-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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

