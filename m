Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F9DC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F7F740A71;
	Fri, 21 Aug 2026 21:28:22 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id AC0F340A6E
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:20 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so1584638a12.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340500;
 x=1787945300; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FzUded7IlLR5Mg+ou7lagIpdkdpt1WZOcDbYdo7TSCE=;
 b=xaK/VBizLVqHtFotnfsFYthwgK0K7r8lAl96a0Pu5U6vdTzXSvm2sU1GG3WfwD5QlJ
 VaNU4vJMelkbrIuFFw+op8tbai6M7fkmiKseJwFWTkd0Kio2fs6fdAIFCxKf4yenbm5B
 PoSTBOn3OvPsEdxIKaqSgzEn239SV7YtWkSxDlnBq/ejRYzLkTyByg+mtFWqlr1TQ4Dd
 DE2/QXZNT4y6hOUskQc6PpY7Mt0caEew7u5K5AAzA/ml2gfTsu+5Bx4xqYkVTjmS4ZIR
 umBlEwma4YYTkJQUYlTRfgwFXbOIK/ry33H6GLgXOk+8mSeSjwSqbdSqcjIBdQJMkdRk
 NNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340500; x=1787945300;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FzUded7IlLR5Mg+ou7lagIpdkdpt1WZOcDbYdo7TSCE=;
 b=oTeP+tFFupo2wu2cXgrEfFaJGL4K+mTH1irMMUJ/DurZvBC5i6gvmuvuMBQbIbzUbb
 9yKJMVQUn4hXslygrsVU+Yb1dsVaaiIPKulaSdoMMKP5tuDCr3/j+gsMSJt250dqTN9h
 WfGdEaY9cO+/m952G/7iwzJ3BnA7YscCONEJaTZQSG81jD8m52MtL8fzmez+jdm/KV7R
 gxZoMhcsqHyMcveyX6h2QkaLfIHg4JZVKGc0kM2qwFxn41vyuGsWwexXNAlgYak7NQqW
 4g87OPrcVS7PtTrRHlygM1axtVhHe1l1w+LpcR7d1Q49pNrniMUsFBTF0lnUQNEPJszV
 9gRw==
X-Gm-Message-State: AFuF++nkkXPnAVAM3ECYYEoU4Y9YDyzxY2Y/PtoMvkQC0rM0vN1mqusI
 swyOkto8KqyVKZOqXHAQ94HhYj776g+hsysnrypSiHAGkzTp1bUVUmZaSjLQ6OF6Ck3e08nRp+p
 lXuTQ
X-Gm-Gg: AR+sD10cFvLgoBwC/6u0+gDM9GvJtHdpdapx2nfmxJ4YY8vhAyBmJoXOMt2VMCHLU+d
 JXgxraJnFJhVTuhX2J9WiH2NQFENFfQqxoZ0ZQyK28NBVpegPOoXvKyg2OB+bXEjsxRFOWc1iRr
 kptVqunnS8xbjcLm5rUAiYXM8OKTATx4ogx5rzEdvn7seI3Ipyyauyj4GLaMeOFv8SUpIOdJw2l
 5u1gYom8lTz641zj5tTbHwurJMQaWYXzkwMC4umChTvSHzoZHJIeexiCFcRxHfhZ5DPxPyfPs/e
 TK4/79Vtx46g3KnOfGhBweyyabAAsDi5m2wmiKI1Jb5UXizqvehlmVZGi1qJFu3M5u3nu/Yhqos
 VdCn/ia+cBGm4dm8f+9Y5XmaGxSFovU7x8zh4wHy4KGWZFoWkO3D/IqAg0/undusr8NwT3Th+02
 wTLtYzFr3vyOAYnMy0fqziAQ9dOfxsUUICVAYtvLR+RJGIjaHXfFULO/srXy2GLvAfnbOxDZDQ6
 PGDMND6VxjCHlA99fUo0T6s9QY=
X-Received: by 2002:a05:6a20:c705:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3cd300613dbmr18461599637.9.1787340499846; 
 Fri, 21 Aug 2026 12:28:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 08/68] eal: document when to use rte_memcpy
Date: Fri, 21 Aug 2026 12:24:03 -0700
Message-ID: <20260821192646.146382-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The choice between rte_memcpy() and memcpy() was not documented,
which has led to rte_memcpy() being used in places where it gives
no benefit, such as the control path and copies of a constant size.

Document the guidance: structure assignment for fixed size objects,
memcpy() for the control path and for constant sizes, and rte_memcpy()
only for variable size copies in the data path.

Suggested-by: Morten Brørup <mb@smartsharesystems.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/generic/rte_memcpy.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/eal/include/generic/rte_memcpy.h b/lib/eal/include/generic/rte_memcpy.h
index da53b72ca8..e409c9bccc 100644
--- a/lib/eal/include/generic/rte_memcpy.h
+++ b/lib/eal/include/generic/rte_memcpy.h
@@ -96,6 +96,24 @@ rte_mov256(uint8_t *dst, const uint8_t *src);
 /**
  * Copy bytes from one location to another. The locations must not overlap.
  *
+ * This function exists because on some platforms the libc memcpy()
+ * does not generate optimal code for the copy sizes and alignments
+ * common in packet processing. It is not a general replacement for
+ * memcpy(); prefer the following, in order:
+ *
+ * - Use structure assignment when copying a fixed size object.
+ *   The compiler generates the best possible code, and the types
+ *   are checked.
+ * - Use memcpy() everywhere else, in particular in the control path,
+ *   and whenever the size is a compile time constant. For a constant
+ *   size the compiler inlines the copy, so rte_memcpy() gains nothing,
+ *   and memcpy() is understood by analysis tools such as the address
+ *   sanitizer, valgrind and _FORTIFY_SOURCE which can then detect
+ *   overlapping or out of bounds copies.
+ * - Use rte_memcpy() only in the data path, and only where the size is
+ *   variable at run time. This is the case for which it was written,
+ *   and where it can still be faster than the libc implementation.
+ *
  * @note This is implemented as a macro, so it's address should not be taken
  * and care is needed as parameter expressions may be evaluated multiple times.
  *
-- 
2.53.0

