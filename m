Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC8CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:46:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E39E40665;
	Wed,  3 Jun 2026 20:45:41 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 9F08940A6B;
 Wed,  3 Jun 2026 20:45:39 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D72ED7A00E9;
 Wed,  3 Jun 2026 14:45:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 14:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512338; x=
 1780598738; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=o
 XOiUQZ8Eqko4P6UDSlSBZgRGRclT44zDA8JJ7rZTVEnHK/mi0PnUThHjW34HTVez
 OBHajl6BOVv6ENPclQgSFshFWL2QlN6k3v/FEF8TuvmkI3itVOzhSSOQR8KmA9WO
 VWOj7HiVN6j3763cFGA63dXV0OjNGutgKtdRz9T3fLSyxw4B96XIfh9MTWmXF9lv
 apL7wTSOCUcI8wbXlosvJiZafE0MLOYdqP06ractYoGat39R3hcCP+/y4a7fI8jW
 +x80VhXhxXkTn7LLmIedV+O5eON0GkHS2auliu9NHlnJabyIn4TnP1sAGoRhTb6D
 rMQzb7gyl6YilqX+z6YzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512338; x=1780598738; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=Q8spwEOMP+Cca9YSe
 F72RPfbhMC/sjur/1iVd18/L7e0ZgWH5oGzGC7hUrQNHcUQUNOym8xhPDhoZCA0y
 wVKrc8I2YvrYpDxiWCIXMcMkayHmc/E/Hk2JV0YZEUJbGKN8o1XTu4bA/RaWE8/5
 u8L3OQPyrBS763H/F9kVs0ALqLC0QPddXX2beddQ1AKdNGXia9WPKewN5Z1m+bvG
 ZrgF0yYnLiWoCOOtKVKmahFTD1JEvBvEXiT2U0Em5jGiCzFs+pYaAt8QZFzUwASw
 UaaUtAVZErhZ2W/+Homd9tfKMzOt0cZIriPHUr2YSlWyXnuLhV7HB8Pw+fpyAWJI
 AOe6A==
X-ME-Sender: <xms:UnYgauwthzt4W9uvLuyJX6VTvzvNrcOUTikDDFGxXX6-0e19uYsAlA>
 <xme:UnYgakSzST43JeB2FZ_TwQhBV70SrTR526jmLBYjXJkMNb78Nalaf-nf6QgD6wIYi
 UeB8n-E8dXuRdipgSNsu6N8vDmXe2e0KPiir8oX4uK0GhtRBwS_EA>
X-ME-Received: <xmr:UnYgam_6Xh-_w88MjDyOoPi6vidHC78cxVpd-wlbgWVsMczgjGFyJuqnTP1IbtwN-ObXe9zN3XCiix1m1U_ewr9Pg1mKTU8>
X-ME-Proxy-Cause: dmFkZTEdfC8qzFhLOH0zkZ6kb3W9lB335TfNsF/9S8fTe5Ku8VfUSq559J3SDo6G6CwABf
 4kuMNvLAfvnWRqmwYFDVfG+uZwfdCB94yNbfJz+YqfhWAjiPxpLQWNWDa0ONrlFZ26O/a1
 u2vYy/Gr1oIAdLnyxsMp0A0dmr0i2QrHWuhAJMK0Ou0jjB9a4LHCM6T3Lhvsa48Wj2ML9e
 +E4AoT8iEkNrnVL1SipCje9dYUK/itAsEkkyZaEewuoEAfHO1vs8VDObVyQQRFmykwkZu+
 BfjVVrjguErWxOZBCSdM2elaZ8CNfOdGqIHmIqi2KU5vXMxpFjDw/QyLYkeQtnovAQdoZ+
 NfhJW0DMpmfc3h2r4RlS8CpX6kwx2MOfZZbFeHEuq2TJo0ic3QcB70H/1qyoIk25SQBELH
 0GK3xopNBWDohsItCp478CHd3ZpYHSvseDFGR/pIEHMrtDhZguT5XFu38zCYa/bvt4QfX4
 aPLfgDmcJmlyeW7IrL5kXXeg+Z5vzmBmIhNHHfRa6P0fY/dzqNqopyUPKCaE7Y3gW3cXBe
 nRqjxV7d/HfVDqmj/3qh99jEHJWgteAsD34+GqtKl8yPaV9mEuYme6sylUw/h5Jxrf7oeO
 g++NZuN2SOJpfMZCuYW+6LrUHQUv/0AnIisiLZ12/wE+w8+luRVj3LUJfKSw
X-ME-Proxy: <xmx:UnYgaitZfLGWYIBcpmvdnRfiRWb2fGy-7AqhAyoQtB89u09iJOg6qg>
 <xmx:UnYgauPpdUqr76DRm5sdZIcDfL5nbGYKRwyPVIr0rNHAcBWUVaStQQ>
 <xmx:UnYgavhnTk6sUOtSwq_qw7neXnt-3jrqja6ndifSI2eHlTsKD3YhEg>
 <xmx:UnYgao7piDgw2gCndbU3lJ9DemgykzRkNXf4E1kB5vaKAsHrm9KWew>
 <xmx:UnYgatGAW9-pxc9zmuw4_jguGs4dMIg2OdRCiHxUpTb2YsC_G_F7QOk0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Jeremy Spewock <jspewock@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>
Subject: [PATCH v7 09/10] dts: fix topology capability comparison
Date: Wed,  3 Jun 2026 20:23:32 +0200
Message-ID: <20260603184503.652030-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603184503.652030-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260603184503.652030-1-thomas@monjalon.net>
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

