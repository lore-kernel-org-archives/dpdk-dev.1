Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE8C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAED942E75;
	Tue, 29 Sep 2026 16:04:38 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 3077E42E44
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:26 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so1619415a12.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690665;
 x=1791295465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Or7aLtWbqQHyNepzPSea/OqwWMvM9wSeyG/InoiHdOg=;
 b=mJ+DlMViZaea96AL+dXXqz+OKiJxfskJ5aCJXfc/qE4QN1mhUKqq7ccZdSmhnZPH8K
 rJYPpvAbK5yoCQApUFpqFZOHl0Bv1cHP8yQjnGiz878sW9XrUHMioqfHSvJGbY3ENmWS
 r47OfoCgx4pucGaMvtd8ZmL94SDahN833+QanIKA/iy99lZIDj7wHPLYHeG5rTRbljnB
 na6kZWfjNbTrjXmf5fUwNOnan29p2RFtkwYR7ygw54+PwOun8HtKIQiDbq8xPKPFHdYk
 5VrKy5hkV6bQDb6uCk3WaBwpidKxypKunnhjFb2gmMu926wU0rANO7PxFXgH0BpGaW4+
 57CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690665; x=1791295465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Or7aLtWbqQHyNepzPSea/OqwWMvM9wSeyG/InoiHdOg=;
 b=oEDfADIfpvZAJA3XtxeWAyj41q+6JRuRoPEQ/qw+ZwuHKtrDDA3XAapag5E9s1ORq3
 EFKUqdGKRjzSTuDyQ+IJsDhSyRh5/4Sz84K7phuHkcqUyipjz80+GjuvB9wsoZI/xlwi
 kh9ezYWmQZ3BoREDWdcKw2LkjCXTlO2EinmMP6G5/figDEZqfvtroCe4cBz9ABbesD9Z
 fRGA0AgQRpj+bADToPJVK+MQX5YDX/GDMi9GoGcSFbcqqzoGJniq/3qsqdMae1nxlr9A
 NdoWahrhitQmf7b0iQp1FKGzlPvhXyEQGQHasllgjXcYoahugZn5RmR6/20N7pRhXAwE
 oOPA==
X-Gm-Message-State: AFuF++mG79TDwS79yqv6ABu37bHQcvww69/o0DIjqU7JCZh+CeVexGd6
 HvfhbGYi2H0kDl+ZaqEubpUVWZwPdwWhG7JrIe1bxuAVey4MNdDR5JrVU6+7XP0os+UvuRZQvmY
 eHgV6Bs0=
X-Gm-Gg: AYBFou0sAo71/+cIza46066Sqylu7zilff0pyyX9Go1Xc2N49SSln76t9YNYQ9XdXOQ
 azW91/PFtxFH+JFBVIquR6LT7kt9utjuveXH/MYLFEvA1QDwLqLrGpDkvE0nW1djYLinZPHU/9A
 KFWlWKRkUJDQ8pZR+QX3FTqDobYQD57Xw1iYpb1Iy9HamsSh+Vgr2P1AbmVk79RArUxZin0rUJe
 QbkOQh+4zjfnZdxFyrvRkOk/bHPej8FA8Em9nGUXhlUWrXNmlJ3SMt+mRyZ9wpE9b5j8Cj0ECgl
 Uj/en6HPutW6t2NaKg+X5yFhooIDnnqAtF5VEmRbgQm1tu3NO8t+8qsaoE9j/7ucic/km41h4DW
 D4AIcX3/KDj8hgzPLhUYAY2KuLwXke5D9uq1kOqLvIegcjZ5UkWKCudrVDwB8sbMlBDsme5Ryid
 k8pRMzBGxz1OkXKCeuLL32nxzAkdDQPDLrqrlj1K27huMR1LccVqRqqLazr59ZZ83Rl65DMMV6y
 O2TPBYSuRrhNM8e/cEBmG7qXSEJof2PuBE4BA==
X-Received: by 2002:a05:6a20:a12c:b0:3dd:85a9:55b2 with SMTP id
 adf61e73a8af0-3de0e763258mr15553167637.29.1790690665310; 
 Tue, 29 Sep 2026 07:04:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v9 13/25] common/dpaax: remove unused atomic wrappers
Date: Tue, 29 Sep 2026 07:01:59 -0700
Message-ID: <20260929140409.234453-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

This driver defined Linux compatibility wrappers but never
used them in current code base; remove them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/common/dpaax/compat.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..580620caf0 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,20 +365,6 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 #define spin_lock_irqsave(x, f) spin_lock_irq(x)
 #define spin_unlock_irqrestore(x, f) spin_unlock_irq(x)
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
-
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
-
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
 
-- 
2.53.0

