Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1805D46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 079E44067D;
	Thu, 29 Jan 2026 02:43:41 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B834340A73
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:39 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so3276445e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651019;
 x=1770255819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=vF3VqyFpbuvujfb1MOLxfgkV+qZ0ikXTrl+U+KrZcDF5xa0qhEI5WN+ybVh2MYzNrg
 Y/kKoVXsK3E6YBxqM/DzfilEytRzZEsreHM7E6P//kEXkw/ARVd2le1iXAYuicvJb4xB
 LqDFxScbLHqaS7M58gxlhmGDCdeiaH1eiFgKcG9j06620SKXvgxOIQ9JrmDPdIdH4qDW
 R2kPIGmrZcrhbMEZGAx/JttmXZwfek50P3rBm6PP80L7sWpIpcwLzsBzqBwpqyyQkaZ1
 RHpoo+62P3vMKqzMaocv4QJnYSMtr9bZ6P63u20sBkdoeva39zQxUGQXoZJiGUzKFrS9
 kLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651019; x=1770255819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=l0NGlQSIAqwZ8XQKC2vmp6TMo17J7O371mkuf49zcZ/RCRN7+2IbvGxRWp++RIgNMG
 Ozm/q8jNpc37azPZoi1wlU3uSJMx5m7iCTNpH/OJpj6dUh99ycrVCYZcujGqnuNjKPJ2
 2QfRHNzmDFv29RZbDFzIUw3rF1eUtnlgyAPSY+RSYLvMPjNcKbBB5CaXUZQmktDQX/YY
 vFdCvkuu2C40XDKS90YdPPeWH2KgOn3PLbyGPTsBUvI9saTj2En7m6BlDoqorieMexEV
 UBVZOF42N+AAkGNrs0/51LGKuHW2XrxnfYice1Hm/RMA3RRlGHjxuw9hxPCueaXCJM/i
 6gtQ==
X-Gm-Message-State: AOJu0Yzr2d5K59SBadZ5znru61ZMQeOwtrOx4haCfTQlQv1+gDg6p0LV
 GDPgshvYSPNvvhBkKQ+bnAUv29H8sRrqPhLgYzwgFNTqZS4L7IcaUY/gCnzRczgdnWMyurC8lM7
 mc8Ec
X-Gm-Gg: AZuq6aKYSL2LKVHtJHmEri94Upnsa9NHpYR4lLqYFGCwvkYCCrZEBwvLCdKeA2c63Hm
 bMl+JsTNQwf2rtglfccWra1h7MlQj327rMagdbsF+unFseoIsOad60Kbsm87jPEcTNPAgw4xQLM
 DR4OvGzY8F01qInSdxDdK4u6nz+FjkI0NKyeX9H0A7ugLrClKbRPBx1dJm8Irnep53i9tjniNSJ
 7TGCQQZg8apw+QaRKzI9mbvb09Jf9Gu6cPNjpzxySJv74Ptn4qv16+zxGCqSXXL2gaUVrdiP0O3
 3a0wcBEALoD+zJmFyQfpzS9PnHw4K3JAH+Z6Qe2LfELy11AJO8ArQ2Q+lAdGgkWKHROvCCTKous
 2QiRKHtGGqXsqaFOdI7mmC6yy7ct04lcBVYUQ7P5TcPDsgt1AJXv021TZyrq4POzPaDoyHvSiFf
 k++mtL0eXbYTyFSoced3vNUEYM+zRtVZL0oOLK2iyOOKWF/pgkUA==
X-Received: by 2002:a05:600d:d:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-480f27c7080mr10092535e9.25.1769651019326; 
 Wed, 28 Jan 2026 17:43:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v14 09/17] eal: avoid format overflow when handling addresses
Date: Wed, 28 Jan 2026 17:41:12 -0800
Message-ID: <20260129014313.939831-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..dccf9406c5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,8 +1153,9 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
 
+/* Address string is "0x" prefix + 16 hex digits + null */
+#define ADDR_STR			20
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
 static int
-- 
2.51.0

