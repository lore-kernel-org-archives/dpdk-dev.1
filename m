Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE9CDB463
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 23:31:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2B4409FA;
	Fri, 14 Nov 2025 00:31:25 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id BA178402CB
 for <dev@dpdk.org>; Fri, 14 Nov 2025 00:31:23 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8b28f983333so147837085a.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763076683; x=1763681483; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdoOFuI7rl4Ksyn2kqdIpyBTYjkOdbDXokc5lrCHfcc=;
 b=TFRfWP/pD+sorApFUKLQdzvQmkI2gjI2XHGeJSWREhSNRmbAoO1jL62kEYKyA3tR/z
 qgO02sPpZwqL9HUgg4ie/NTZFM9j7KgokXsfY1xG9SQxMk+hlRT1m6vWfLwbiKHvClbr
 cLGF2MKR6Vd2laUZCxpBeK7TlZMV1UQRK2QvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763076683; x=1763681483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zdoOFuI7rl4Ksyn2kqdIpyBTYjkOdbDXokc5lrCHfcc=;
 b=ljoTbf8DGYgUpzQ4JjVLUbW6mGlk4Pam6sec1oOTWOQOSmKMpgbX6oj5CT+vZz/jIq
 NSSxW/zz6nj7QnHDHukhkG2/3aXtmkjZ5SdVLm0vi2izf9/gWADDJO3UDoKVyf8bFJ4S
 wzkpDQKYcJDO9gXudT2X8eKBLT2s8n+YyhLFy+qAH+JpA/x5cWyWFIEWB9/CFppO6vTU
 P2UrNknjyC4XB8I2viizjpY+61Eki9UqHIrgz1H0+VJCDc9aPaugvDqUD7IAK0JVWr+3
 IV5uT8WXMimmfUJVHJueDFRYd1eQaGSWRlNjuhKlg7AzXc0AUHSSp+StQQwX4zkJoLrN
 AjzQ==
X-Gm-Message-State: AOJu0YwQF/xVgGWwNycWVSz6xF3wggJUR3h09YcRFG7JALA3pnVqyWQh
 QgYuM/LDmgidjlJhuTNuELs2coS/SXfAXb3xfXaHP9k6LB3DKDPOhoRgg9K9gWOFgpc=
X-Gm-Gg: ASbGncvkrfbejqOXIVcTtYNAmvMr0pZhp77tIks+SZex8bNwoKNsHFRc1RypvHDsgF4
 qLBSMZwhqddl8M9QxYwLpS0NFjbwgXAWr8hiuEcFF13pK6PFMT1i8cr+DLfTZjZHRp4X58OpNh6
 Rv4DJeWK7WeyAINIvNqiNEKHhaMBhsUHWYULcfkfjnQghAlgxhWSxr6SIhWN+oAA6+Oy4nyXYyH
 lwIVAZWXneKg2hDe50VtNwPTA3T6OKE5sdVjJse+AN3yvtR4pF8Z1bhj3/mnFlDOZLYahwIQZ0B
 zasXXjCEM2KA9i0iJZ4fKhn/VqNvSmh2rOd2774jC+ZSpz5HA6GiWy0Hx7I+MMVJFiSQBZx5EKk
 IO6FTALIiKO8H8nR+fWi45mgF9P4K1Cp00rS/roD/C13UaqTYG6GiNNi6zS4oKJbhHmN63gXZvH
 ZHIag7/VhMrEEcB6fnV42NbrAaCTdwuQ==
X-Google-Smtp-Source: AGHT+IGkbbfXddJMPbO+siQ+BtiN7/gOwhp3YUtk6YoDPJY3dBCOZ0SfxqEH3V0C0F2KOBaePQQyDw==
X-Received: by 2002:a05:620a:3729:b0:8b2:621b:fa4b with SMTP id
 af79cd13be357-8b2c31b5033mr156129785a.76.1763076682737; 
 Thu, 13 Nov 2025 15:31:22 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af064724sm221837285a.54.2025.11.13.15.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 15:31:22 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 1/2] dts: fix incorrect import order for RSS testsuite
Date: Thu, 13 Nov 2025 18:29:53 -0500
Message-ID: <20251113232954.273454-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251113232954.273454-1-probb@iol.unh.edu>
References: <20251113232954.273454-1-probb@iol.unh.edu>
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

Fix the order of the imports on the RSS testsuite such that
the dts check format script is no longer reporting issues.

Fixes: 367e950f6d24 ("dts: add RSS test suite")

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/tests/TestSuite_pmd_rss.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_pmd_rss.py
index 80f6e310ae..f6adf262c3 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_pmd_rss.py
@@ -20,8 +20,8 @@
     requires_link_topology,
     requires_nic_capability,
 )
-from api.test import verify
 from api.packet import send_packets_and_capture
+from api.test import verify
 from api.testpmd import TestPmd
 from api.testpmd.config import SimpleForwardingModes
 from api.testpmd.types import (
-- 
2.49.0

