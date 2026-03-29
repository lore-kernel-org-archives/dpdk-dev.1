Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95CFF4923
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FAFF4065C;
	Mon, 30 Mar 2026 01:24:29 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 85A0A4042C
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:28 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-35d971fbcddso587193a91.1
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826667;
 x=1775431467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuQiCPdvIJpNJBYlAdYT1BxoIUPPfPGg/RZKZM1QymU=;
 b=T8VPVM9u1Hc4UyOK/alr+PJAn493wJfjNyTPdS8BlU02AVpxOj2/ILOUKRRHMDanLB
 Mu6KL7vyuf/3mmsdVON3t+08nqy2ku/h1FNvR9RjFPSBkAfoop+L+wioINGk1SqP1XH4
 h/FCf5mBJzIjVjWjPWBv86aKDnYJwkewcji5wcIYqNa3koKf0TuZzRMA1ft9JSwarI1R
 sIvGtlPuEY9K4dkh59AXNRY6K7BzpyXCTuV+i3ERWpHe35UE8uEQGa8Dp55ljNGcmIzw
 ZDuD0jrsKHmHCbufk/4024OXcDb1wqSqRC/HkBVoiiBbNybCc7jiYi9YdxUfyJgrxRbB
 bR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826667; x=1775431467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YuQiCPdvIJpNJBYlAdYT1BxoIUPPfPGg/RZKZM1QymU=;
 b=JHqAwx1NAVWbFYSyOckuZsdlbx69k/dehDOP2vGNWtJ7COPBNL7mPLD214Zv9cOqyT
 BdHmeNaxoJphFlBMq8GWaFi86zu+DH0MKlWMGFiNkqLS0qcuOlfq/XZzEF/19lSK1Z4L
 Cn8JnJ/noPYoo7iXsrF5Uzg78kt0F34cqHdrUbd6Ry0gJTwen47JaGhjoSPiFRkihdME
 1AmcctVrgZmtG7i4CwkWdTwVfsy8mI6Dmu093oHGj2e6W9osaTjuJ82p+26YrWzAhKd6
 1c6DSqRs2Rk+YkyCHbmD+jlsdgrfXpTczUUq80a/udhsoSfvkXCzqku2JFkhOLyq7XRh
 28MQ==
X-Gm-Message-State: AOJu0Yxbiz/en/Z1G9452dfGvP5t1u09pQOqSOcrXyTFevQrGd/x1xxM
 V0kCLVumTqhf56iinBEE1MN9Az8kN3DiV1uMqwsHjA+NydXMDDK1tzpr1392upTdCVQlG754zzZ
 Y/JlO
X-Gm-Gg: ATEYQzwOLWEnzVNMTJW1bzjm4FOlH3ksTeaWN0YzMMbig+FC3/dQJqq43lMDO81zzYO
 2aDf5pHUylR2swh4OYz64Erop+ylf/gHL2sAgdfYgUx1cLNI7LGhuxp/yiloAH/lbvBdazEB09F
 M1iszv7CcvxMDUdJ9bssXZWIKUoD/FiwmH2wEWsnOQqF6EUU0UsTROwNqMwjiDRWzBLPJdESZBA
 5oZxpWs/rWEPs8sKacUIIZtwByfsKM96mrL3WriIKIyJ7QoTOLFoeyTwQNa3sBXPzmDAt5W+nUN
 ajjnp9rtKKGUXhGWGT2f37Y1IbSqHgQoqWHDhcC58j4Fx6B25qsj/Dp1W09GvBUDqQD27u+hv+4
 aQd/h23C0QkjPcTzPl4GJGkWpWMu0Ib4WIwVORUpZnkO9gQ7pgUfG/b7V2wF/Ln83SK4KYMbAb5
 4Ej4n4Ty3aMKDYtC1tkUR7FiiykH/6rANv
X-Received: by 2002:a17:90b:4b07:b0:359:8957:7285 with SMTP id
 98e67ed59e1d1-35c30b82d50mr7749291a91.3.1774826667507; 
 Sun, 29 Mar 2026 16:24:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 2/7] hash: use static_assert
Date: Sun, 29 Mar 2026 16:22:36 -0700
Message-ID: <20260329232409.205940-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that static_assert is available, better than pre-processor
use of #if condition.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/hash/rte_cuckoo_hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index 5b3c51348e..919140ac1c 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -24,9 +24,8 @@
  */
 #define RTE_HASH_BUCKET_ENTRIES		8
 
-#if !RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES)
-#error RTE_HASH_BUCKET_ENTRIES must be a power of 2
-#endif
+static_assert(RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES),
+	      "RTE_HASH_BUCKET_ENTRIES must be a power of 2");
 
 #define NULL_SIGNATURE			0
 
-- 
2.53.0

