Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C39C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1739C406B4;
	Mon,  3 Aug 2026 18:53:24 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id E296340695
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:16 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca80d708489so69034a12.1
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775996;
 x=1786380796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfYYPoZlVBAvm5TydGIOrJRU4bw/HozNqEiPB3KBVWI=;
 b=dT0wOjkn8F67VKCrOMw+zI1sIBkcLe3KfrxQYZIacO6UxqqLnfTMNPnS0rKxDqZ+6F
 im95Fheg0Xly5/Vgmnt/eCuHfgW/m1fASHCA5gz4nvdDGe7tU0ZgR5FwW+EuWJrocFTi
 sQhHLf0TsbHD3CQ79gXIsXCC6BOdDP1nQ3pXQh5ctv3geG5q099gHblQZ6hISLxms/3w
 Pk7gk+Z3IR4kHPwDkQcd1w13Wz8d2S09i4KgIRnRjgA7phvWtvNeqj/hK0JD/ILAWkSJ
 x1Eov0v2Q/cAnXznyweVBCmxITf6OY+NZcsQBbqO1YVMpb4f5zEtorBqYy/Wewz0XJ4/
 cuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775996; x=1786380796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfYYPoZlVBAvm5TydGIOrJRU4bw/HozNqEiPB3KBVWI=;
 b=tWzZ8nQQNI40LMHC5thKVqXfBNwejoqLAym1KqygQMg9YrarErx2IuR+xpD1GppBUc
 RlYeVGWbsZacJGKSdoYwV1tlcJgfNcJNQITMzHtBr2wICSvu3qIxTZ0OT6XXyhuvtfCb
 ukgV1++3hCKBtx6okGxUjfWu+ALDJeEUogyvOs4sVpGM28Q/ne87QZCV3YeOiBTZUJ/N
 WP7AzgkpeC0CXbSsnLun8+fkNC7bX9GQg/U6QDkbUgPv8JebVObZYOh/ld8H6PMusXuG
 pBCsuTh/IHKTCiOuOMRU5WSPKRFBp2rhEtFv5/x1PAgdK7kpMQ9dc/XcHjpOn4Ady1lT
 utzQ==
X-Gm-Message-State: AOJu0YzzMYyvsmGB4P7V4FMgENlIJ4kpc0/819lue8Jiy2FOnAumlXuP
 diqd7xIRhc7vTR0mvOjcilYEviQZeQbVeoSOhjgn3bG4PIwGuxf2FA6rrNQvYQHI+9WXJKPBEAu
 VMrtD
X-Gm-Gg: AR+sD11ZX+OOGawmGkgpKCvKiGhZVgBSb7O20bGkzV4ZWrE+n6/Yk9mFUlNpAnRGoju
 vmfF3GZpcUbjYsBQlVZrRle7GNK/F31BdYvabEGHj5h5AEZEn6O5qLE7oVqJyotUAeY13p5EY7J
 cmZC7DJYdC760zFM11d9XrsfakJt813zGk+AulXfviR4oWnwX6IQCPFe7/8w07AivRRISxhGmLM
 lxvnvdhnIxX7pugbs3JZu0zzQhpgNecxERsDCeo/pkz40sHhWr7qWZ1Qfu1HdbHkXzY6JqKa4ht
 4Ena8iVYGQ3E8fOrMhT7vuqC05Cmq2gT7XMPNS7i52fraZwAP8uhjgjchnJ5LAWCypZZXQQ6tS1
 a4nHcUnMj3uLB1s0ajMCRip4eGVMPgbPJCWNhmqD5+TUFras9iccTD/WxoUwDh/bDo7Omb3SZt5
 y922xxfTHuMn4kSKWWng446FvbUoUelVSwB8RhpX/G9aOAkbU7jDli+fOlx2+yu5BhqznB0zBr1
 sUg8yZviQ9YgPmvBAZk26uswvM=
X-Received: by 2002:a05:6a20:d52d:b0:3bf:990d:3fc7 with SMTP id
 adf61e73a8af0-3cb6c9c1834mr275912637.20.1785775996057; 
 Mon, 03 Aug 2026 09:53:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 09/22] net/mana: include used network headers
Date: Mon,  3 Aug 2026 09:51:55 -0700
Message-ID: <20260803165304.289869-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

This driver was getting definition of IP, UDP, and TCP headers
implicitly via rte_ethdev.h. That will be changing so instead
include the required headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mana/mana.c | 2 ++
 drivers/net/mana/tx.c   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0b72f711a1..3870cb4a52 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -6,8 +6,10 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
+#include <netinet/in.h>
 
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 10f2212b5d..9517b033dc 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -3,6 +3,9 @@
  */
 
 #include <ethdev_driver.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
-- 
2.53.0

