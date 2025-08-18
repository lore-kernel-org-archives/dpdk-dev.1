Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F6CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5795A40A81;
	Tue, 19 Aug 2025 01:33:37 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 8C53540A87
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:35 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso33174385e9.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560015;
 x=1756164815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2X5d6DFRnQYfas7LXAMs2s0OhgnH7LuOwgbcHKRbDI=;
 b=va9B6xngToqPjvty9+0KJaGX4tsfBQ/tDPvFnmFUGSVftMtpeZ6ZJLCMuKHQB2lSsT
 Hm/kb9myiPDYNQQe9ig8B9bJWIIA4PWpky2QbxxerWIuCb/TWZt+NT0gBkK5b3eSY6o9
 eEzRyqYwbRFFvWZo8Rt+v1G/QBKz+rfFGc4vZjMuwRWSphF03nnkcZyXToSXucGNuZuI
 A5ycLXMyDQRUHi6yY8waQQBpuUxENSRehSf3YpTKyLFU7jtCRNOZkMLNuGFcFrSW/gky
 2B2jjSgBxZjO00Zk1g/B1FjihINm5h18x1qwitTX8n629A+3PTf0ko+e94K0SJGkcGI6
 3GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560015; x=1756164815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2X5d6DFRnQYfas7LXAMs2s0OhgnH7LuOwgbcHKRbDI=;
 b=LmS/cGtBKwuvtI8jAA9FwWuFyYKtvosy/HWB4pYii01cw6FpjkN4o483yjBX/L2aWT
 HJ/m/rZBlAT0lLEHOjK1N4B1HQ4XsDInX/VIxJeF/MJbhz6DBe8qKjclfpVuiYRPKIwM
 ccOFuKl3FSvCaSyEhdvtvUvIQYclP4iMZpjITIGYtd1xJsX1QoF+7WsSBQiBMumdJYAH
 vlqgXJDg1ey3F8cCFwMAP7ioCPooDlIPWnaAQeMZ0nSmZMBxDFsAYFK6lQDRoepO8whr
 tvvC6X03JWBOyZKR5SKFsUSfgKNNpCf+6UgGwmIolM+X1xVEIgaeH8ISiH4o6sWnyhTc
 O58g==
X-Gm-Message-State: AOJu0Yz7EPOXIsuUn9jo4dmoRjGVxqUWwxbTpSnCOT9a72C68LVWYkCI
 dWXuWtKeJAPl9V27rHxzSFcSNpyJWcurrT0sy90ZsxfY9RF7RTqyN3LkYxV/Iip5kDFx/6iQ7k7
 b7oCW
X-Gm-Gg: ASbGncsqHv5oRQMIs0wERN2oQT8XEcwT++aKbn8cbcc3p0ifij0UR5JrPP6uMnzSJlD
 Z7owYktWFDSjj3rEk1R6AEUAMoOUnOMUazpQapsLnOOVUhQGE3B+MzoinF06plck1Wux8d1qiKA
 f6JIdfIpn4chm1X5nuY/eXb4QWvIXB2uLZ4JWYbUSqgU2Nuo7WpPdTEFxx+9CJMJpYoWhyjSiK+
 seOxzOP2XmkeYopmDNchSLYKv7PlP3sxmb30vv2Mm2c4p6BDn0gDr2jKAQjWlvSJ+RIW9q65wKj
 WTDdOn/DvXTeDqU94QTSHr9AV4xhER9QINCZfrNc8k8El8/J85+Xe3X4NGkGZj4Y+1RWZoEXJXL
 PZuFkib7AgbtGzSDKdxh5ZC5k/aMUApoReGQs6t4tAjZ4W0BgwFkTe9jwGYzMeQtaUbZ5x9IO+j
 6QGFQ8+vg=
X-Google-Smtp-Source: AGHT+IEmUMoCa3OugFU7I5YL/138yYs9zWuTrcKJGF+OhbAAoko7yxYI3Pdp5wYFVwDm4tu10aKXPA==
X-Received: by 2002:a05:600c:35c5:b0:459:d9a2:e952 with SMTP id
 5b1f17b1804b1-45b43db665amr2111455e9.1.1755560015107; 
 Mon, 18 Aug 2025 16:33:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [RFC 22/47] net/qede: use bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:33 -0700
Message-ID: <20250818233102.180207-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

The BSD version has the needed SLIST_FOREACH_SAFE already.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_ethdev.h | 3 +--
 drivers/net/qede/qede_filter.c | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/qede/qede_ethdev.h b/drivers/net/qede/qede_ethdev.h
index 3015c18504..656d72adfd 100644
--- a/drivers/net/qede/qede_ethdev.h
+++ b/drivers/net/qede/qede_ethdev.h
@@ -8,8 +8,7 @@
 #ifndef _QEDE_ETHDEV_H_
 #define _QEDE_ETHDEV_H_
 
-#include <sys/queue.h>
-
+#include <bsd_queue.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index cecb58c997..958ab558f3 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -12,12 +12,6 @@
 
 #include "qede_ethdev.h"
 
-#ifndef SLIST_FOREACH_SAFE
-#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = SLIST_FIRST((head));				\
-	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
 
 /* VXLAN tunnel classification mapping */
 const struct _qede_udp_tunn_types {
-- 
2.47.2

