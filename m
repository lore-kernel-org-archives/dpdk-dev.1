Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA51CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 14:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1920F4042F;
	Wed, 29 Oct 2025 15:51:01 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id B0C8B402E5
 for <dev@dpdk.org>; Wed, 29 Oct 2025 15:50:59 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b6ce806af3eso6784568a12.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761749459;
 x=1762354259; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgsBVNQf4qmF2Q4qjEkKI46C56Z+u0JhwNoK3PSTUek=;
 b=2rcl1BDsb04z8/AJJ9vQnmZQ74wkJ/uhWWeCIGNUgULhfHtyqPQM9LgqSaJFVns+nQ
 tLPc0HISlY3bkZhf2DoYvaiUWO2Nc9LopjYDh+J54Qt6TWALQ1IRdGSKYb2rWrOXhECp
 8FwK05aUjpF2UUHLokNpZw4V8pX5EeOCidGSoVP/4ABYbNjnhBgaLjmEOUVgkn+pBE79
 EyrN+xsYYfWsXwpZSZ1q3sIS+bhpF3hl1+FCRkVlVzpk1Vd4NuQgheYFXZXA/tsrKbSB
 JJY3yZQbOZgl4jSVMpm7NSRZh31yqZhkPrnU4kTOtSm4lR14Sx/8e6XAJx8wR7MqbMBF
 T8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761749459; x=1762354259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgsBVNQf4qmF2Q4qjEkKI46C56Z+u0JhwNoK3PSTUek=;
 b=RpVFF5HLIC/c1nzngR/557lk7AGe+mIVQ0pNoCX7uxKRzueHbdzwcaPS6poaCaynCJ
 s4x+Xc07x1XOWM5sQEt1BNtRWYXqvM5V86jpnTgChtHOvb1V90428GOoMPWbXe01a88E
 CUNnj64jGCgT8wGj+elzPnJfT9JwtDq01DXPo4+H2//hOxnXMJ4KVji9ydiWzY6X8CzC
 6cDHzmkz9sHKRTh0YOUsZ5OpPdzMeQ4o5/Lff56qhDYZL0yzF6dXZDoEShul3+3VILch
 5IQytgc2NQVxO8RC9D8ZTSxAY73eOZeV6Y8GyCfXIJlvv2LOUyM3k4PVynK/dreo5ZW/
 oQPA==
X-Gm-Message-State: AOJu0YwRUt53GuRmQCPlVMkHlHijZ54xMKd+1OiQNyOdL8LFmD2cGORs
 h9mW6XDujzbUY/RZHikqUpvUT4qN1rGrDoD+AoZpEMytley5HXF2he/janrxf9aK0/mFry06QaI
 uJ55k7+4=
X-Gm-Gg: ASbGncuLBE6NVA54juQOJv2dxj70La+AUTAOe673RpG8YwvKOKp1W9A5EucWlUpFlBZ
 pWEVFGOWV4/yi5tXQeUQGvswRhfqjWiZeA2urmUuSAEi8N13NO3ZbUj2s/+mZ/dWIzsoFtzN2JJ
 KaDP2EaJFLWtqTRqEwtg49pDWyeRgXCkLxzNt0z0pzqbSG5mxx0JAlbRPxsIRGRLSmXKbkAb47n
 V/mvZX0wg0KCKZrCDNiHEgypUH1kFeIM+VRC1T46G0SqFLcQknxG1G5IUxRS9mDrYTOgAYZRXuK
 5F9mXe76ghEx7a0F+ttOin6IgyXfsGxlMFFGyqnWt9RC1ZeibFVqSt8sq+7XUIzkrcYRFKCGBLY
 nqnX0qDviaXPRRYPR/J+EbvtRdG9hB7ggbDVsjIyVb8Ey31fN+N/mHAoduPOAJbKvpEsMUjfMAu
 vjzNSR2+P0hezEZ/4CK/uS6Een37ua6jjrnquYqrI=
X-Google-Smtp-Source: AGHT+IFXQzLJQT7ZdzE7LbtAvNvP5uhBsIZ9C5GwNTOpA6YIUB1aXFVURDaNdTghBRT1mpiFYZLxmA==
X-Received: by 2002:a17:903:f76:b0:272:f9c3:31f7 with SMTP id
 d9443c01a7336-294def30ed5mr26994015ad.50.1761749458761; 
 Wed, 29 Oct 2025 07:50:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71268bdb2dsm14343887a12.5.2025.10.29.07.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:50:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2] bitmap: change return value of rte_bitmap_free
Date: Wed, 29 Oct 2025 07:50:55 -0700
Message-ID: <20251029145055.990899-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028204432.880074-1-stephen@networkplumber.org>
References: <20251028204432.880074-1-stephen@networkplumber.org>
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

No existing code is checking the return value of rte_bitmap_free
and other functions like rte_free do not return an int.
Change it to just a stub void function.

This was motivated by Coverity warnings about unchecked return
value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_25_11.rst |  3 +++
 lib/eal/include/rte_bitmap.h           | 13 ++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..4b8e084204 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -220,6 +220,9 @@ API Changes
   The link type was previously hardcoded to the Ethernet link type in the API.
   This argument is added to ``rte_pcapng_add_interface``.
 
+* bitmap: Changed the return type of ``rte_bitmap_free()`` to void
+  for consistency with other free functions.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_bitmap.h b/lib/eal/include/rte_bitmap.h
index abb102f1d3..ebe6c44998 100644
--- a/lib/eal/include/rte_bitmap.h
+++ b/lib/eal/include/rte_bitmap.h
@@ -282,20 +282,15 @@ rte_bitmap_init_with_all_set(uint32_t n_bits, uint8_t *mem, uint32_t mem_size)
 /**
  * Bitmap free
  *
+ * This function does nothing in current implementation.
+ *
  * @param bmp
  *   Handle to bitmap instance
- * @return
- *   0 upon success, error code otherwise
  */
-static inline int
+static inline void
 rte_bitmap_free(struct rte_bitmap *bmp)
 {
-	/* Check input arguments */
-	if (bmp == NULL) {
-		return -1;
-	}
-
-	return 0;
+	RTE_SET_USED(bmp);
 }
 
 /**
-- 
2.51.0

