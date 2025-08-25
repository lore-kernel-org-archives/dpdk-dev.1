Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13CCA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5393A40671;
	Mon, 25 Aug 2025 05:42:33 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id E3C0E402D0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:13 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b00797dso30848605e9.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093333;
 x=1756698133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNkvTbaXOQwH91FNQyktwVDp8LOGcUNXOy6o9KHPloo=;
 b=EkXmk0w0+cnluiQRv4OCzl12Y9P7R56AFjAq75DL7bDmQ5ynoBg0ee5rBuVVl06kvS
 xkX5PYeI+2cgCobPI5tmXHdF+JE8GkhieihkYksrAhvjzF1CpFzXzKZA1KBoJ5Gsmy0w
 GBNTG9fx5IGDcJUeNEC30XxyIY43iK5rSvxrbPIYzcge/1LO7+2PFrBZUpBdzliHd7OJ
 G0MVXRtOCnC/HHVTQMOkgLlVdCDoVzWjIIoHdK9mwpBj8D0QbixX8bj2cQuv2dnHe7kv
 KupyOdYNKAYFjBSm6XE1UcC35+JeIx53zPpd6Jv83dINTZnjyix6KS3hJINj/8LUfupr
 iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093333; x=1756698133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNkvTbaXOQwH91FNQyktwVDp8LOGcUNXOy6o9KHPloo=;
 b=PR+Of8zMxf37Ep09OucpyRCH9iBb3UTeseQtSVN35XE82Quhdm1NanKH5uZHErtgVm
 zOsHTGyIQWxObcVqEz2zZzg2uJ93stD2dxXz9sEYC4N+CS0wBYlOuL5ww/cKXeVfuyyI
 98XKggn6hU//IRqe0k/pBcnW800VKWlJgUGwIiiFEWb1F944Wh5FHN+JVclZdP4ygMCQ
 UpE6Jvuub+x3XExTmwcPyLN0OB9nN4LlvLW5oJHKUerA/0LNiPjTzLwzxKxYvsz8v3+E
 qvKIieXw5J4ZuuyJs8Je/B4NPf/Y1E5wYnnFGeL8AgBZov7E8WVBo8tu/ByToyze2K5C
 kGIA==
X-Gm-Message-State: AOJu0YzwidVME3EMP5L3+K4T4px9YNoc5Ew7m4QbHo4xKEsfWUZET0oa
 1Y160vD/7r4BM6/mfsJ3tRwaI5hLTVUFMd3mbEsatlyVxd5pE3AKlzVjw2WaAa0a0+rgr3av7eB
 CgA17
X-Gm-Gg: ASbGnctAyWPm7eR2HdD3El+/4hZj6Jc/xv6HUCEDOINpDD54C057WFrwW5JyOHUjr7c
 mH5jqSpKBJggcRrSCFuKNqNFPIjF36wFMumNgGOAk3vdmUmP1ARd1iIHeYBI/ZjSyjiumDclKWD
 xTuAsuAke1c3Q817bKhYynRNLXe10K1+XcmYOyTooCvzX7KT/+37CgN91SwOIowzvvHhRMjq7DO
 OzScCa/AFN9WcQIIpJ2mTUyO5n4XB3Bz0JRkKIGQB6GDb1Sjpug3vmp/ZUuXLfxKUvaFGfPBib2
 MsG1AQk3/2CY5wJmrobbZvkDXoVdhya1BcfwdK2QU/gFysuxEYPASV+9MMiUjEcgU9BWptl1azv
 mC/ft1GNEVp9Hws/78M08/0drrfIeAkQPMHYmE28vY8ZC6x2auAad5oeef5+SHuRJeBfQsjrm
X-Google-Smtp-Source: AGHT+IFm6jx1KQdG9e3bUMRmstsBC9MWlxPwFyreFdOo/wp/deTGByNitwKzlRVwqdA8swwCnPNvmw==
X-Received: by 2002:a05:600c:8b17:b0:45b:47e1:ef68 with SMTP id
 5b1f17b1804b1-45b517e8dc2mr87362495e9.35.1756093333526; 
 Sun, 24 Aug 2025 20:42:13 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v2 13/43] net/nfp: use rte_bsd_queue.h
Date: Sun, 24 Aug 2025 20:38:26 -0700
Message-ID: <20250825034126.12046-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Can use common macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 7 -------
 drivers/net/nfp/nfp_mtr.h | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index 4833ebd881..904d2126e7 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -12,13 +12,6 @@
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
-#ifndef LIST_FOREACH_SAFE
-#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
diff --git a/drivers/net/nfp/nfp_mtr.h b/drivers/net/nfp/nfp_mtr.h
index 7ab0324721..c8ce03385c 100644
--- a/drivers/net/nfp/nfp_mtr.h
+++ b/drivers/net/nfp/nfp_mtr.h
@@ -7,6 +7,7 @@
 #define __NFP_MTR_H__
 
 #include <rte_mtr.h>
+#include <rte_bsd_queue.h>
 
 #include "flower/nfp_flower_cmsg.h"
 
-- 
2.47.2

