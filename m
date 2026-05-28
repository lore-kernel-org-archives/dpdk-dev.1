Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B099CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC9840687;
	Thu, 28 May 2026 14:48:36 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id AD3CE40679;
 Thu, 28 May 2026 14:48:34 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 60257EC00EB;
 Thu, 28 May 2026 08:48:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 08:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972514; x=
 1780058914; bh=ff4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=T
 suDpTJng2lUYKbfTVDLXjWx5peDhyeJGgpeWZJc5JwZg4PmAN+uZNOdrkeft1ITu
 KkQA75FDAmPrmmUimRLcEdrJMMZ3E+kitflyXQkHD8Kqhf7wg2YCsn9krcfisgNq
 R7i63aUFHkizAS11wdyTfWjp66IiRS17gn+5CQQNxp2C4+ChVkzTi0KYAaOLa5/C
 g3wPkOxQWVCSSHee8MqiBFMLZAtjxSgYBacBL12gBNOvGJiQtOOO+jfEsYC2Tq0u
 rm7MtUJVPsDsOMELSLt415ZOkTe1ENSnc263sWp9ReFtCVgbWx9InWuBA5nYjzi6
 odXp/B10tl5dmboSaU7Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972514; x=1780058914; bh=f
 f4SeLlZGaaVyCyJkrhXjZ7MBihuQIzYUGQuIpHP03M=; b=SwrrongRS6lxYm/Da
 voTrlwhsb4/TM1F+NItJJLLA/4p8G63Ux7hkcB6szAKBixzdoUa7LQ9dGoSNgbSL
 7pysM/w0/VBbFJqDZw3IKCUZWnYD9Pvyh41OVVIZ0cEJLuJE8RbfG0tgNSm5eByP
 X+PZEMdGdEWiJXs3pGUWPqYYn7455VBkipvQc5BTQNrs/jm4c1mztHymxx6ruCZc
 ooZwzkukWIrqrpfp4S6DUXrbv2GqeE4A0IP34Eq9ivCW24Ex7B+iBK2hkSeWvDTM
 gxgVLXNW6sEcHVEMAJdR+X8i9wN6JAS6HuMtp4NmcWuYas62rg5PMJM7tiY+4WAR
 cdrYQ==
X-ME-Sender: <xms:oTkYaiRYZChRUmSGO6gNXaa0tEgZUYdgjKsaizE0LqdX1BPmpcxcOw>
 <xme:oTkYahz9AkjGgZuyvSeGXgCGJuCOp3XY5OrZe0cNn7qrNe0q-DblQwCseta0L-lsP
 liHAmMPnzXyxqXIZ2phP_RjQ1Mf7-Y9Xriq2dhanxt_jOrYxpOEAuk>
X-ME-Received: <xmr:oTkYamd7ux7GREhuErmNI8yPKw0Be0wlqJqGyQt2Sf4wW2qaVizJqG4euHEkrbq-3BezKNVO5tOnm4pIFGhNply0p-yXhgQ>
X-ME-Proxy-Cause: dmFkZTF7RVe2mdNwTqCwEQQ2E9FrHh/qzUuY3jTJSk/nHrrU5rW6spDsz/HcF8BYRtTS8c
 htexikM2HHjQLKk1gwkyYM/s5VhmvP1LQjUjdTBid5x+q69orIUFipSk8IQzLsDkyYxFzr
 DhDBZrDJoyYQYGNWk0JF4pZwW/ryhCGms3SwRSjMhs900RLbWiDtZ7U+Y+6TURa5eu60h1
 tpf5R0JPqZ4jsR4xVmCFZ0fMNqaMPeRDkRADXiDbxb0jhHX6hKRNJIHJghtvrnyouEhhrT
 RlqymmOGV2iW/xrnWeUF3CnBfQtxLgxBQbw4kz3sBQxcEMY1iwtsaCwiIAcvpG0sZVRVUh
 zgZVYYhEnAUqFLzXmUmwH51sRNRNc54hdbAy39XCcET3SqF+c0vvv9dz1QgVxw66w4jNaA
 dYODrZEkuJbqKLB0l4o6oHpruownkjyW0FSyVkTybzb8n5YxGh5jxsGD9XCp0NwsZ2q7fx
 uwoFqc0Nnu3vtneMJLUHRc06iJsF/0ftKXwey1B1naVf4ZJB8JF27GmZv/sAugPYCeaqh2
 ltyFtPRChMYLVTZoc0xtZbMWVgHX53BXwXrmDjZE+UiJ6Cepl8DMkj9qbnR3ChYYplkvVS
 NfsutdvPI2IilqeJGPVCIU5FHfSx7eBKrjJMjnpdhiESBz4E9EoOc3/RLB6w
X-ME-Proxy: <xmx:oTkYasMSXnxlj63eYrVRErbgyB_qZDR53RxNmy--jmrO9BJ67LwnUw>
 <xmx:oTkYapt_cGGzDT3t5ObJtejGB59L9BQp0r8YWCawOMphDOAiNWNJUg>
 <xmx:oTkYalB3I8-zZXKrR_Wie4VnZMDE9pZBnOCavCM1Zeges48oy99vMg>
 <xmx:oTkYagaCKfTb4X7FUJ1lE20zi2JkDf8CK9XiEZMrmESHNfB_ghXqaQ>
 <xmx:ojkYakTrc330PfxumEWbUkL7L3JOiY42PuaHDg3S5Dz3GxNwrev6oGYm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>, Dean Marx <dmarx@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>
Subject: [PATCH v3 09/10] dts: fix topology capability comparison
Date: Thu, 28 May 2026 14:46:36 +0200
Message-ID: <20260528124758.1984528-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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

