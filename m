Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55630CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC0A7409FA;
	Sat,  6 Jun 2026 01:35:30 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id A74C84066C;
 Sat,  6 Jun 2026 01:35:29 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 59E17EC01B5;
 Fri,  5 Jun 2026 19:35:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 19:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702529; x=
 1780788929; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=h
 laSpaEs6i2uwx1vovzv6LssK54caapEYxYZU1N8Bd5PcdMKhLjdIKLYGi70peL+i
 ZQ12YcSz2DtbTzG3nawpLiKiFjWx3mcFne0v48gnK8wdTj1EmEruqGWmLjc7InU1
 XRiAQo1t+2TXo3l4S6xps0tNztK1IFmjOfJXOuoSCnLHOMbNvVVuZFFL2ICcoLEf
 DgzNEQPH2bXYER/VftelIYxfSblCgjrXCKfHIeLelAl+THARXl1yF6Ad1EI4pPaP
 YI1K+XjrUOvDynHH/1AwRKOgnHF7lItztUtJbi+mZ2a1BptdTJu3yAheJBStgnJD
 t0XepNR2alDjEjjUhoEQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702529; x=1780788929; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=HPoByAdlGcBmKyQTE
 mlspwXWqHPQElSj6AyLy4tVQrJ8QctgLKLbQkGOF1DpUdTEpl1fOm7R6GUJQdcFc
 Dcz6ACWXpR2/W0KTd9GPHDPzGUEP7kz588aIlioJJgxOGNMzRFsqXxV3X83I/kYO
 tVs0VfKTi9kXienBakXyIyOmh0CnW0DofmLc8wkAdJL+Ev+hqOZEwtmSIkdue/An
 uVd32j80nki0HBUH4rq6wnW6LXnJMvTG6bt+2CquInITWY/KusvyuGrA+ztRF9Rx
 87Y0vDqUmEEhdU2vovQ/lY4Tj99pEJwP18BlaJFDqYfJxxMDWYTQOPaGsi3SPO53
 9r0Mw==
X-ME-Sender: <xms:QF0jamL9NX7nfiFw587RVtDz5ui6SnuMxIYzBe-CaiM3l2fuHnIXUg>
 <xme:QF0jaoIM5EV0UqmjIBk3su0_mzDLWsMO69b3KjNZzRT9IQyW4vlFgaUjDgScji8fr
 sFaBah5T4jKT6vB_lazBgNsdrxmsfZHpqVo4TOCAQS-dU9_sadddg>
X-ME-Received: <xmr:QF0jatWtbBGoIb7SfYKN9c_1RjFvpRDl7ke5DVNq9YLS7dgjAY2e9qCWaNVrksTrszl3qkPoAzRkSSW77R-hmmBzxoKMMLw>
X-ME-Proxy-Cause: dmFkZTGUC2VfT7ZX5Dlxe073QUjUZhJtCW4sdVH09QyhV3r/jzDu5rVl9wylAfV6SE2hnZ
 1PcxcomxWC0aE41IU45ln4yEP0RlUsix8K8IGyl+XidxLlsXckqGfmtcyNowqNm9tlV9PP
 k9v+F7NvMpRNtIZlRvyzOs7U5GJhfQbXub8nFYkWc41k/hak6mHQEbVWXU1olgTcaCUuog
 YapyV9ZgJoWJqrCHEPu8RznSMJBw+o2BeLSMTiYzPlqDOG/taoQKZPQ2Jny4mYAb+1ikC7
 TVN9YCdO9KJANdPPPYJvP+abYdfsdPVaZHlBix7eTvY3bqDhKfcs7OPNEMjTNe84xKC+Cw
 LwrEBOssaySt4n/MVuzINwaSeoZOnKpQKLMYPe43oe7Tbz0sBw3Abt2MVMSJGRqma8SdqQ
 AuRasH2KKRvJvgVJH6zISBvoSegmhePV+48YI3L/HBLZHSJHWow5b+kpck7IuIfcUiF4hK
 lMzzDSQAYFodK7JexDH0V5NfdGuDrT1CM8D5I6rBNuntWOdc+xrYG9D6kMcJJWtc/k5hul
 ybd8G690NCxPg2KX8e3rJtkNkVAruVZKDEA53+4lRhMJnz3xKf8lQi3YKuOHt3H1qUa5ym
 JnFNLjDr/N+nGQhq05P/NoHuaJ+BbSbEX8xlVc/lHpkDXvHKUmtIT1FHlgCg
X-ME-Proxy: <xmx:QF0japlfh-Z_td1oDEeqkji3ifrOr77sIBNAY8Kzur3xRAnPNIcfqA>
 <xmx:QF0jarl6Vhmf3Ty4x3apS2dLCKcHABFc3CvpgazxDmkkw3VL--jDVw>
 <xmx:QF0jahZXVD_2oRZV4WOf5q5ElMI0r-2CEtuYHCyPbtTdcd0nbe0WVg>
 <xmx:QF0jalStjKC2jGfjaXnjn2-zZiUZcQLuBlAp9vfySkJZ96CAOxrYfA>
 <xmx:QV0jajpMSSFZyG7HvLrCp9OYqLgaYPHapnwlcGs77xOsLJwhrifxXpQ0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Dean Marx <dmarx@iol.unh.edu>, Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v9 08/10] dts: fix topology capability comparison
Date: Sat,  6 Jun 2026 01:33:48 +0200
Message-ID: <20260605233456.3017423-9-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

