Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC9CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B3A40696;
	Tue, 19 Aug 2025 01:33:13 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 1FDD140650
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:10 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3bb2fb3a48aso1751426f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559990;
 x=1756164790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqn90enleDPq5sd8EnP9fyndPBZod6JewvIGiq0kntk=;
 b=bSC4h7ThslSb+a4uzf/lvT375aDJO2lQvNwZq8Evm6HNKKTClIrbQSAlBWjb7PPS+C
 qQ1pJtOGYvG2mWoq95nPUBfZZsYqTLGBSpnzha/tFqmwo3j0Z2q4e8wzU6Y7uqjL86kO
 mcMW9Y+seyRaC4fUDUJ+ORic8BTFEhOuA3YuTiHG8yjfRefGsed2A+XUrD1RN2KHMny0
 OddYg4O5I7OkqRRkSNYr+OTUmB43WPKeD54gjcU9F0c9tYMTliI78iDYMdTWqY+SYrEw
 Kpyx5JmAWXM8rcpbT+uMsyS8Sy8tBGstBz6ZWqOq+IocKb5kfyLSpKWWvhlM+P7Qch1I
 bz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559990; x=1756164790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqn90enleDPq5sd8EnP9fyndPBZod6JewvIGiq0kntk=;
 b=t6sgUZZiiTiKOVivAUE3TWngOvrqI67VPc5D1JDO3tfcKFFooqP44mMXH5YcfWlrTm
 LNYKeENollM/349SQ/Hd+xVBUjz+pR3o3Wz51QLWHI/GoL9wM7+8CBVaONPx1UJMvawC
 QDOb5UKH/C+buZGeWp5pJLkdIae63qTY3sR71UuitMRpY8NeOfdPYXQ2MZWVqCOy5DWH
 T0Ladgpzgb7CRHb02xHRjPxSHWT35NwQf/mM26O+dndyaUE52HrmSdOuxS5vkKFRPcXu
 /MdbF54apmEls/RmIz7QOIwDF6dPsM6Zo+iagipLo3oBbxBX00gQ3ZySOLmJ0D7pBHSj
 jIWQ==
X-Gm-Message-State: AOJu0YzzurWHIdZ8ZdOehja+/i2SRJVwSMwdkZ8FzcxlIbqm2Hk/W2Ez
 14swpfN2ApnT0kWgS2Jc2XeAZqDVll3JKz3ikL6q3SgBUO/GItBiVm7mLpyP0hBJIpLjaINiSt0
 uvUsk
X-Gm-Gg: ASbGnctt1oXvcpPbv15SZGyPtfJwJo0f1pVFgwO57bv/znLR5TsszV3QugPIlvqdoG+
 ic46Eo/iv/MxRCMsG3LWZ8z28unLRPygWxyvEDH6mvheIFKbaOGB6vA+ABi4MyK2G4blav25mYO
 1MmjxcpLdmDfTJR0KeiFNMDyu84F+m4sCXovVOIWYiedLGweVRdtEOzx8vnP5FstA4KK+yy7WGm
 NTJ2DhHcEVK/8AiILKCFh29H8PxtYnV4ycfInZH46ktM65PTZ1BOgrcfSoInodYUPTcDxlorkUN
 YJYGNDkVFQP8naJO7S6Nb+PK6kufMGvJhf3ISelAofQYF8UkOLOjJI7SjgEeV1OxueRn/3twf9t
 VzFA5HviEnqCuHuxCTe6+FbCs/T5sQnY0imu/HBtAi0UzNSeo+QlOSJIKZd52kqGQu+Atz8l3
X-Google-Smtp-Source: AGHT+IFX3aKKfKSjSiAWZMhn8S4PtW/fvafbl4ZXWr6kYbaGKtp6xxZ5yBcVvLOIB2p11sZWg5Z+Zw==
X-Received: by 2002:a05:6000:290f:b0:3b8:fb31:a426 with SMTP id
 ffacd0b85a97d-3c0ed6c485dmr285561f8f.57.1755559989952; 
 Mon, 18 Aug 2025 16:33:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 13/47] hash: do not include sys/queue.h
Date: Mon, 18 Aug 2025 16:27:24 -0700
Message-ID: <20250818233102.180207-14-stephen@networkplumber.org>
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

The necessary TAILQ macros are in rte_tailq.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cuckoo_hash.c | 1 -
 lib/hash/rte_fbk_hash.c    | 1 -
 lib/hash/rte_thash.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 2c92c51624..dbc0ddcf75 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 38b15a14d1..c4027bee26 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_cpuflags.h>
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 6c662bf14f..63930f67be 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -3,7 +3,6 @@
  */
 
 #include <stdalign.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_thash.h>
-- 
2.47.2

