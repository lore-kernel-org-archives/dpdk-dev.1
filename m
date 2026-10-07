Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2502CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1907E427CD;
	Wed,  7 Oct 2026 23:41:26 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id BE11A427C2
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:24 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e4a341d177so26068215ad.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409284;
 x=1792014084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLURGAYVAvwQa7jh12IWZ94PhInxKkltpP3s8j1uy5k=;
 b=AqeVj1Lb2E/mAIBmST5XHlQ0gMYMC6HwbbSgeuOwyWzk+d+N7XzSLgisjmn1SWjxy/
 PKQl+G/EeUU1TAp/S0FeWbhp05XM0hm+VxjWEfZJiuQ4dLo6Z1LFp7djjlrklFoS9BCe
 SoXut5IBe6T8gbywBrbZ2bV6a2E/2rj/KdDNi8z2nX58ImNymBRvieuQGuROlw6y71un
 Pg+7j8+0RDCdPEm6H9MWJGcph7bvY8TuvJpURGqlnZiBEhUCN0ChEPG9dZWKzA4dICJB
 E7xWc4Jjoz/1munA5pIxBGnVkzr0fBhbIvXO2hkzgddNVt/DrzUaAWjKfcbHAgh151UY
 VyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409284; x=1792014084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLURGAYVAvwQa7jh12IWZ94PhInxKkltpP3s8j1uy5k=;
 b=iV9G89UBKspILU/Ywlr5pBYFgikY41kShoxA1+fGecfJ/w3omAL6HoiYyeCls/q+Uf
 yawIPZmDnt03JgY7W1ijz2vq7pYr6U9ulEwaL4n4yNFhjGQnCJ6QovHGoRjKUP5pH8Vg
 kXZ1MfojEoPoGupCCdlEgwOc0MnvcHNDUAGfnEwI/C8eQ5+pLpAbwPPPN2npOBoSHwQJ
 hIWm78fYlwipt5nyabDln/nfglrpp4oXpEkvTJOJ4IBmYaAK1CCv3nYIpWR3CcZ1Yi0i
 xxGy6LLsvEpmIwAFOhXaaCvJhMjujRSNzdOtdwwJGuVKt1ptefZcQZ2ncVjOfVpb/T+c
 uhyw==
X-Gm-Message-State: AFq9FYK9ujF8GhhozO4CehhNmftZ9EY4BcyBJ1d4zGTpmhghpzM3/rTP
 +408cYi1T5ewBTLQo1KaODwrhaw+bqJqjeukLYmdtfFljHAGcFR4p9+snGBDmxQkMP4z68783LR
 fcjum4YA=
X-Gm-Gg: AYBFou0yh7VQhvKpzNszl21eXF5TS5QxqWNi+WXoyKO+oz5c/eUt6HCsL2WUXJYObiF
 IL9AkqsqTwxfCrnO9952L7dnvq5xA95SVqmIVFzAlxa3U0nl9mKpBnxW6S6kH/DppyhexcwxNIQ
 o0tphyjZUqQPYWBO5kYNEFAY5ZAmxUIbDlFA2bgapYsKp9WB+1Rt9o9PaQpoPxev3xJCtmZ4oiC
 fko06MLAk1tHeNKczd/Iz/z2MoKGJDRPRZkw230WZs2VDJlzV04Tboj1CrCRXg6w5h1630RzSvb
 QxNch53CwSNU0ONtIdNlZ3qeipc064i6gu3jUQ01C8ZSgTqUXjz9m7EvY2nfWqsDSD844hFu0uX
 O+GaWFKV7juR9FORQBBkzv7HaCnlw7KTeh+fXDdmlQUJmPqOjeNnUuFB7CKIDOyuhFoSbqWOq5a
 B26gr09So6NQsd3CA/TXzsnWJk3eDvnxcukbNVWkXAUdpvhutxoWg1e4j7o5W3+lGPta5yQIbJc
 +IMyq0FHk7o01kK+U1mQ+Jb0+veHt10+X4Ko+yJyoJGgvES
X-Received: by 2002:a17:903:3246:b0:2dd:ad74:ac28 with SMTP id
 d9443c01a7336-2e6004e1588mr30865705ad.26.1791409283710; 
 Wed, 07 Oct 2026 14:41:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/20] eal: promote rte_size_to_str to stable
Date: Wed,  7 Oct 2026 14:39:34 -0700
Message-ID: <20261007214115.3092715-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

rte_size_to_str() was added in 25.07 and has not changed. Its
counterpart rte_str_to_size() is already stable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_string_fns.c | 2 +-
 lib/eal/include/rte_common.h           | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index e0dc48bd80..00ce95c011 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -114,7 +114,7 @@ rte_str_to_size(const char *str)
 	return size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_size_to_str, 25.07)
+RTE_EXPORT_SYMBOL(rte_size_to_str)
 char *
 rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit)
 {
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index c3f5bae6dc..6c4ae332fc 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -1137,9 +1137,6 @@ uint64_t
 rte_str_to_size(const char *str);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Converts the uint64_t value provided to a human-readable string.
  * It null-terminates the string, truncating the data if needed.
  * An optional unit (like "B") can be provided as a string. It will be
@@ -1167,7 +1164,6 @@ rte_str_to_size(const char *str);
  * @return
  *     buf on success, NULL if the buffer is too small.
  */
-__rte_experimental
 char *
 rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit);
 
-- 
2.53.0

