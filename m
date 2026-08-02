Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDFC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82CB040698;
	Sun,  2 Aug 2026 20:18:53 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 21429402D2
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:45 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so2656414a12.2
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694724;
 x=1786299524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v0q/Z1FZC10y3WqOxqQxntmFA6BV5+O916M9l+d+63Q=;
 b=oJVWvsYpW31006Ywgbhj3cjGkULK7Ha8RUdpzOvnyrsAWrWFDlIyp60+4t9IZreQhf
 HsKA/go5fnujqGdNYozvSkExT00IiKQ97YADVTVelve5fT/Fa26ylFDf9BtAgqjKqf0R
 MU1JKfvazhe3rYgU43HsMZQ4R26Utk/1i4aC2XID4UvyLA5x56T0dnhyi312Bgngq1MI
 hS53YM9H3hhSnQXRVVX6iazNxARS2ONRY7j+7t7WnG9JAK9XxxVUzvd5he+GkxnJ7ubT
 418rvjAb8Wvb9NB4DLVG/rUXhkqjpX3hfxOtxL3uuEgnte83/VqA6LSmeId2aVidHQgo
 yGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694724; x=1786299524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v0q/Z1FZC10y3WqOxqQxntmFA6BV5+O916M9l+d+63Q=;
 b=O/0fhJKlLI8kS8Gdz0ugin8cq4xVCvxHGIQKXOKgrtS/qcPbXfKuz5phL8/Ljxcy1r
 sRIziBtvNZuoMJPXHmftgjwNFQTqggeeadC0MlAu78fzjEAIlm5ZBkdu4Aqa/P8dJfHG
 4OnaGQoKvEYhKiOz/jcC9gR+A4xlVyiibr6x0pJHq8q1rP5z69RhZyAULA6F624xSSh/
 ANNU2Wul/edf73VwzVIQ5fOfMGKjRLkfHeaFc5sOWTgVE18ZNEf57OEFTTYLwYto182i
 et2qhpkeFP2AY9wEvsn60VgmHOG3trEY+ypmkOQ753JWuaKPVWDgOeJXpDXkdTj/JUV4
 NSWQ==
X-Gm-Message-State: AOJu0YwHOa1yE6Z+VKY8WU2GWncdBdgi0yhVOrHRBs63qy8jgPxOkfSi
 H4e2xaGDufXBXNkHNNFeCqgKjbchSBZ/K3hiOt7uGIK6s9xJk/ld4T8we3FrxYFa0zjOg6yhkc7
 fdWKK
X-Gm-Gg: AR+sD135eUNFq1tXbv6wyLq2W2jv/hdwrQjgX59GFvEFkGTFERSXYg+jVouuhUIbES2
 Co5PM57pOV+9qdSyLnxOagxIAuj4/X7nvmgP146Gs2aL1nyrzwU2BjCp6PjY5IiTRbU7ZjqBpGN
 CvDIYRLtJ41I4Gb9JcC5r2C9SNezQs7MczBowCFnmN3DVDLjYKVlRqPLXRVuCTKd00g6hS3kacD
 +1znetSywYC2wAnPnHP2WQ+67laxGgmpGHIc9VRquZN7njYIkx4WmPUBGzaccup22M6krL65Uzu
 RXteTX1lxk1SZONqUE0iaSSqTSDwyje5AgggMdlv/tRecpl/KP9BvhiciqgL4IP5Wtwf2HDiVBD
 UO2HQfc98blhgoCKHarxmm0pGc9goOM8wWc5TjO26KySBLfXhlWUVB6npRdbsS6Rtuq3Vy8Xhop
 9w4Y0TQyXMJYQAEyofRqYt9yJiW8LxssV43XSYw7vxezu72R1uFkD7dez0CRTkIl2kWJvGGgQJz
 OWhbVfKptllDRrOqHMLn9pmvnE=
X-Received: by 2002:a05:6a21:7a86:b0:3c4:302e:803c with SMTP id
 adf61e73a8af0-3c92a90509amr7069637637.61.1785694724353; 
 Sun, 02 Aug 2026 11:18:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [RFC 06/21] net/gve: include IP, UDP and TCP header
Date: Sun,  2 Aug 2026 11:15:11 -0700
Message-ID: <20260802181835.476887-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This driver was getting rte_ip.h, rte_udp.h and rte_tcp.h
implicitly through rte_ethdev.h -> rte_eth_ctrl.h -> rte_flow.h.
Since rte_eth_ctrl.h is deprecated, better to not depend
on that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/gve/gve_ethdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..8087bf98f9 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -14,6 +14,9 @@
 #include <rte_bitmap.h>
 #include <rte_memzone.h>
 #include <rte_thread.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "base/gve.h"
 
-- 
2.53.0

