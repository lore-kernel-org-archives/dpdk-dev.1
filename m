Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8DC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C412B40BA6;
	Thu,  6 Aug 2026 07:10:30 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id F089240A84
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:28 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1698738a12.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993028;
 x=1786597828; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQc6JIWWyUbGqEhygW9Tx0U/jyGNDQqqyHu+3M6GVIA=;
 b=uElEgx2bGfgQp5+5ecypdDciySusFigmVQT+QeEiZN5X3esh+jiytbTIjhOLnm5Z8/
 8LHiivxScNx0kBbOeqU0jPLO/owl7v95PGTECwtYFSRKxPCIwVy0lXPs2k/C4KQkpsSx
 gnVSkr7RC0fkUVfGocrYF7dIBLW2HoR4bzdqeQVocVjX8UapoiPIFcQjFy8xRC/146J1
 IbiYLBokn0lWREUs8wNffsVaAyBuqR9F8uiRjnxAdH3GI9rHDxkc2yHWHeQgcrhsJgtK
 jgnWybArRznaNgJIuccfgdIBXOeEj4/eQL8vUUvH/sH64bDHSaEXyRmd29gEbHUtVEPg
 8Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993028; x=1786597828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQc6JIWWyUbGqEhygW9Tx0U/jyGNDQqqyHu+3M6GVIA=;
 b=IRX7mm1nqC11QoAUIlkseD4B49OUaiAAKTSY9VOo1ToHiE6NBLAsJkse0dlo/2QAGR
 jaOegOPaYtjsgnrjTMTUTgiI1WGjonOkwAxb6sGY4sFyoQ0tQexYw5sVmNi/P8KRbAEV
 dqbtgEnGxSr9A8HRSnIE2JhmpzBKlQDZmTMFnJX3CR4m/bLAnHwuyA380W4SAZckjh03
 t272CJM0CX2b0LMbNvms22IVmmd5Pe13U4koi9qx0AZs15NeYTMaaI5CLm/kegUxPfLw
 mrL90ri8FpgjCKiiVcsOWsIF95K1TyXym4ZOEvZyM6rMln6Ua+fVu34VuyY9M7Vpi+M9
 7H9w==
X-Gm-Message-State: AOJu0YzntVoXGUgQg7SNfEdTOjNopeOaZV0g2rjhrR7xjkBmIKBEfb8+
 4BhOgmSQyHBUrf+CsYcdJODeXHi42Xg2TBFEGeNzIL7U7G/XLlvhIkukCQ5toZZKoXi/W381bcK
 vqrPBjaU=
X-Gm-Gg: AR+sD11dY4gvHvQQ110oQc5ERuhiREX4MsmvDWXgKLSk7J/BC9h0tkceB+xKsa48A8z
 RB11cgNsLP98MO63XAYNB9uuJnW6pYzZLM85cxj4eJblIfw+jm05AXaGbiHmi0qhOFAm7fV7zck
 H7k9aqNXNfKkrMqMLn1R4hIfdE+ZJxcLjnLFi04JoytyTtzB6Qxsq71vojdZ0M7ZRlFOcDoyick
 GdMbAYX9M6cR45qgoob6CWwcO+A7C0sMxAMpVvkki5KiP0kim21T1rzNFTc3bhh685wnhTtIA2m
 0ETuKSneFdWsjkWj5vqucfm2uLNSl5U6ITT4O5QL8T/8/jELDQip+GaSWAiiBqvEC7kIW9p5uJB
 GFnE8810W5+lC2L+zHr1pkkdAZEw+bXpemqtbn5BVyQiqQeYsaHqey/tjnh6raadqpF6yCJX1Ea
 QqIXlzBT7Z0LC4AjDyCOoGWqrqqrr/AqTaI7ll/cLYpXV3P3XtiSL48CxdhAZz4b8Pd267SpGkE
 NKFPNMmHZM3a8HBvhDPlIszyYM=
X-Received: by 2002:a05:6a20:729f:b0:3c4:1493:6822 with SMTP id
 adf61e73a8af0-3cb85e4977fmr13896319637.18.1785993028108; 
 Wed, 05 Aug 2026 22:10:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v4 13/23] node: get UDP header
Date: Wed,  5 Aug 2026 22:09:07 -0700
Message-ID: <20260806051004.166778-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

This library was getting UDP header indirectly via rte_ethdev.h
Use iwyu to update includes to match usage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/node/udp4_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..02a8284982 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -2,20 +2,21 @@
  * Copyright(C) 2023 Marvell International Ltd.
  */
 
-#include <arpa/inet.h>
-#include <sys/socket.h>
+#include <stdio.h>
+#include <stdint.h>
 
 #include <eal_export.h>
-#include <rte_ethdev.h>
+#include <rte_common.h>
+#include <rte_byteorder.h>
+#include <rte_errno.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
-#include <rte_graph_worker.h>
-#include <rte_ip.h>
-#include <rte_lpm.h>
 #include <rte_hash.h>
-#include <rte_fbk_hash.h>
+#include <rte_ip.h>
 #include <rte_jhash.h>
-#include <rte_hash_crc.h>
+#include <rte_log.h>
+#include <rte_memcpy.h>
+#include <rte_udp.h>
 
 #include "rte_node_udp4_input_api.h"
 
-- 
2.53.0

