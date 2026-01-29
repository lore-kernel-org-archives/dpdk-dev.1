Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82469D73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 19:13:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E0DE402BA;
	Thu, 29 Jan 2026 20:13:08 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 1974F4014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 20:13:07 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-894723da7dfso18270406d6.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 11:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769713986; x=1770318786; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCGa7xtzJHc1vy4RVFL83GKVa29grLfTemyzx3CBjEc=;
 b=jSWPxKTBbUqlxPfI8uQPKbOSwxH6HDQuffi3kzR0PThcwxXnRWxgpgaaa+bUUZla/c
 YEe8QjiCLlSxH/DzeeOJniDHlH5z0MaS4lkNGFEJzbD1WdvAtCnvQ5drO3vzjBGos9nV
 y3j7Es77OhnuDZImiPUBBJnRLVVA8HyJvtKAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769713986; x=1770318786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCGa7xtzJHc1vy4RVFL83GKVa29grLfTemyzx3CBjEc=;
 b=duGLpA979Uv4viCfQHWjxRyEbZuneeId973XT6iwAnyluQiGrvOEU7IdA+OxBrUaQ+
 F2hts5h8ksyvygYLncEDXYSz3MdSf+Pdk1sX6BO60BcWlCm7dwWpwCc5HcDhtGMrG9Dm
 8Rp5ypnL0yTisJO4VO9WiJn0wVzq18abETed42KqE0XWA7e4BFJiE6FwJA3aiOt9mSE1
 ddhxFE/ErVeGimA48igwLT6J2GU3fiGP06CKpdxk+D8snysTxVY9smXAYI6qltt3hIFO
 6Xx4V4G2hhR+2LPt/WT6u1lLRV5QXqk/T+Up+dXNNTqBnssLSSYnp1cysnfBds+bJ+Ha
 Mibg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEAFh7xKWdY12I4j5ypn6DIpBlvEC+gw9Hwbus0Ow7KWAHj1J+70HfdSZo/EQGKucnfnw=@dpdk.org
X-Gm-Message-State: AOJu0YxDQv9Jw7BXME81zPbrfWr3GNUBtnfCk5zYQ6zLBqpTExguyXsb
 FCsgjFRi/sw5yFJNcneEPGCk5n+JEoyWiuQ3MSUyGFnqebR4QQC04ROq2BqKTU56vaTz2ZfD40L
 dAupz
X-Gm-Gg: AZuq6aKEovEhUA6w91veGXJKmCYlavxxP6gUwBbwbmGBE7XQIOLvHhu03Knt2IZjnCw
 ZMeZDMgvtVoO0I2hrp/nhF+atDsZSKuO93axyo3wwJylhJemBQGsxJr8jIpZ/4LlHjmACdSF1M5
 421Q4WuKqifnDgpwF3pKe6zpdrMPQRMWKYrEGYFjNXIJIXqi9irkFJv2+tdJUVSKTyXHdGACEiY
 LUmk/K/bN3cHmoS9fcy+/7SIomy3sP88Isv0dsPSArRHDF6nVZaddn/IrnWVssE0e/9eYYXFDDJ
 gJP6JG7gPhrilCcRWU49knN2tW+V7a32ibDhjyK309YtSw8v35sllWjyJLjfeYy/R2tn8lAVP10
 PP6+GFpzHi1RI4Yu0tmV0NQrVH3LJs8gtL/qND9NSjsSOKHees97vGZp8ivvTCf+2EXNE4b23Ad
 ysmU9G+cho1yOf9u8p0B9+2XO5L2gZbKDMEqu42SuBXslznM8QcOD2
X-Received: by 2002:a05:6214:2304:b0:793:dce5:4540 with SMTP id
 6a1803df08f44-894e9f40f7bmr7168356d6.2.1769713986433; 
 Thu, 29 Jan 2026 11:13:06 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d375eb4dsm43656616d6.46.2026.01.29.11.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 11:13:05 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add missing rst file for QinQ test suite
Date: Thu, 29 Jan 2026 14:13:03 -0500
Message-ID: <20260129191303.373877-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

The QinQ test suite was added to DTS without an RST file. This patch
adds the missing RST file in the doc/api/dts directory. After adding
the RST file, the docs failed to build due to indents in the test
suite docstring. These indents were removed to resolve this issue.

Bugzilla ID: 1874
Fixes: 4f69c54bbb2b ("dts: add QinQ test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_qinq.rst | 8 ++++++++
 dts/tests/TestSuite_qinq.py          | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_qinq.rst

diff --git a/doc/api/dts/tests.TestSuite_qinq.rst b/doc/api/dts/tests.TestSuite_qinq.rst
new file mode 100644
index 0000000000..827174fcad
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_qinq.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+qinq Test Suite
+===============
+
+.. automodule:: tests.TestSuite_qinq
+   :members:
+   :show-inheritance:
\ No newline at end of file
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
index bb385a0d91..505d71dbc8 100644
--- a/dts/tests/TestSuite_qinq.py
+++ b/dts/tests/TestSuite_qinq.py
@@ -26,10 +26,11 @@ class TestQinq(TestSuite):
     """QinQ test suite.
 
     This suite consists of 2 test cases:
+
     1. QinQ Forwarding: Send a QinQ packet and verify the received packet contains
-        both QinQ/VLAN layers.
+    both QinQ/VLAN layers.
     2. QinQ Strip: Enable VLAN/QinQ stripping and verify sent packets are received with the
-        expected VLAN/QinQ layers.
+    expected VLAN/QinQ layers.
     """
 
     def _send_packet_and_verify(
-- 
2.50.1

