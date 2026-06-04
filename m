Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C7CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:34:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E339E4065C;
	Thu,  4 Jun 2026 21:34:05 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 861FD4065C;
 Thu,  4 Jun 2026 21:34:04 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 38E2E140013D;
 Thu,  4 Jun 2026 15:34:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 15:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601644; x=
 1780688044; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=p
 KFc//3nttnEqJ0mC0+rBQ1DvQ0R8jTutF8FctJinjUhme1rBy6gOOhvt4hV6o+2l
 BpdhVfmCQwOgXcyDEMinNZZ0FVqtc3wUalSQdayybPga869AmDvp4Gwulmp0JkSf
 GyDfGESSsRpbKwuAxktSw90sBnhGBAdeeJ0GxS5S3ZvyfRV3XTEfJgg1pw60Qhm3
 pTHx4Bbs0tKR9ZGiIKggT2XxOKjQ5ZsiJgM8SA4hAzMffCasldjrcSkwxzhdTI3/
 rcp+KEXnTx8Oeu+WNwMeMlATYvaS2Y7eag6xdP1b4d8PZvyttTJrzXBC6+32dKRW
 Po67Zc5ORUOhX330295gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601644; x=1780688044; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=jfXkZ7HUxKGtoVjJI
 KYh/d1ZZAIYgDvyX43HAdiHrqtRirGRDSXngKQ0bhwYLqsNm3Y/+jlZI1Jhbp9Dg
 /G0pwHeLQfoV0zD/gB6W10uljGqEJD+vjqaNlmUAPoqkcDOt6po4nQ9pWF9tQ41I
 evWNWHveGkjRlmri9NqThDPD258TJj6EXRr22zr7Jggqew9ADvXWPYHJsh0LaApH
 LMEDqi6vsxz0CabS7WHu1L6qN3Pe88c9G3vmzccH2lJNEFZFU9utU/6kiPFOVX1A
 rYF/CAMHofacMshK5CAZGigdkcPx4YbW6zxbxiUsyyVLWA/dMAtoHT6YQivY27Fz
 DmY4Q==
X-ME-Sender: <xms:K9MhaqCnQ-kwJhxjo7Uf4MFXARLlplIxLVBKhg9xlqhyNgSAPIZSDw>
 <xme:K9Mhaug80dZZMaknLHdxT9GhM2e6dAHBxPvA9R4EXBfMQ0YxEfpWfVgSlD9Ic5wlv
 IGrXL4l_P3IunbL2eT81R6Wj_UgASDdnUsFpJKAfrifl7jgWTCG>
X-ME-Received: <xmr:K9MhakPt7fF3HDuajGhedf2TfHmUsQf-nMxjVERo7Yx06V_Zw5R4XfnOlYdsTJqCP7b9yGgS6dEH6DR_EKZuUOcvK48hNLc>
X-ME-Proxy-Cause: dmFkZTGXTLG/UGrDethAghR9pnQZN4IMcO5q90Js4UfZHaaqsDa7bgd3rgQlE9cqZA9NDR
 U+lWXA/Ge5k9DWJet4CSD35z9JpZzOXdS1dqu6ClxnxMA5w8NLUbL+iqNEFPcu9kh/k0SX
 s4WFzYartu7sSDwaUWzrI3hh09xM89CoMZlHkJ9HUn+fHur2tGyDtaQCxaK1E8msi7qkt6
 7RUeJByl0fqBFxd7htiDH4b/4w0BBNoICCy9MSu/4lgwJyhHf9Ur9xMV/MIRMDXX67LF81
 6q00EI6gjRRpvDZ7N85EE67w5nPOP7yLkIpLKTrKAFSFeYIoegAjidNrvqGRU2JZ18uxTl
 yfvYRDYaC4hMAlX16g3Ib4ASzYjwrCj4gvFjVadAy1uTH857kzu5UGeztX6csjOuaK25Ge
 sXaOhVve4xEuSbI97GuvhHJQcF/x7fHVZjMHNHR+VEVVYnDbc400yHOyEEisHJpeWopv0f
 YP1ToHHFLp6p7F9Db/BxpthjhJu376OUzZNKdk5TxmnoyeNC00YR55pSVcHuGzQAN674Qy
 I+scV03mzfPxK1LYXsXKhuhGsx4rXi66RgOI4jGJ+QA19hRIeTsnoa2//FoG3cjGUmwdKe
 ivDm5sTdBMgG7a7tV7WFE/FNxZaB4rBJfws9BosH08TSf/PZNEZRR3KkCadQ
X-ME-Proxy: <xmx:K9Mham819Hl0mybS1BabxQYncm-iupKwz9OnI9bPSqRWDNiuJOJHQg>
 <xmx:K9MhatfKE1wyaOXAActMdURpu-pZIlIL6FrLt1Z5a_jPqMwx1QrF7g>
 <xmx:K9Mhatxnkp_1LV6txuwjlxibhqaqEuk0LM0TYjB0zyQbt-9YyYQmKA>
 <xmx:K9MhaqK1k4ggsEw9TM3Inq5stXtStFeQj9_92FFrvj_vWbW4oo221A>
 <xmx:LNMhamWj9fIs4Mk3ptXqIgEs0AUQn9DCpJk2vD7OsR6zlCpjbRHA2t4e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:34:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Dean Marx <dmarx@iol.unh.edu>, Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v8 8/9] dts: fix topology capability comparison
Date: Thu,  4 Jun 2026 21:31:00 +0200
Message-ID: <20260604193324.1996141-9-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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

