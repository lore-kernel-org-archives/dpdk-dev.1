Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB4CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 21:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B588840292;
	Wed, 20 Aug 2025 23:19:08 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E64EC4026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 23:19:07 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso1610025e9.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755724747;
 x=1756329547; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H2B/YtD3ZDAxO0qPdpjRQIFAI7QOg2vGWucfaQRz1Vw=;
 b=FA64M82hVNS3BoVphWkLtyy1Y+JDk8bmCkEe2CGNKbOmMXdAFDe9pViAe1p9GiqiDD
 z1v0ojSDSc702NAIn+DUh2RwxLz08Gqm6DRCJoL2Gugc6DmhSb1tvNpBb0Fqmr9jKxyI
 Y74Wza/pZRyUkDlLF0QyU1j/7xwDY7dBFZL7lMCAhXptLXZU2j9REdUKuCCa+ybYU74e
 heQxOT4Z0lkCIn9HROYVnZdVaqBIaUzCPxsEYP3vUuylqDO2ZN33dry0a88w/B/DayTo
 VdvaaIgnyqffkZkC13hLZZ0oKSrX5/zdu7DGASnP40tNDkWctDt7ejgunefLzlnlJuCv
 v2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724747; x=1756329547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2B/YtD3ZDAxO0qPdpjRQIFAI7QOg2vGWucfaQRz1Vw=;
 b=M2rAlQVE+fJvREsZf0GWLVNEled6GbD+OY7V1JcLJl9QCS4lbGhhKWcYthHLM5eikY
 OEC8hAICAqiXqgTvrscsA8UUz0PWUNPQcqhKRAvSBUuoYFLnWGn8zYX19pdgcnNUIrEe
 Ag5nz5pRQRgMB1RW7fcJZGIj8nSq3I5a1f6HwJOSAA4G86YqeLSJjleihyg05LSbX7fo
 XbgCtXZITpoyldcM0/Z2PqHUZvEeZSAjO+RBuCcLgMoUzql52sXhbuC9M5izCpa0w5WC
 NXh6mDNe9LE48dgUjmvO4H6tHyUnpJ/afnuCYXHjc84OJRbEK+eDX6WtDEfqV1mSMxyG
 vIdg==
X-Gm-Message-State: AOJu0YxXLLNBfwhbzGLDEdgcJz98F0p8S7Iy2aBCIQXx/y4K89szk7Sa
 DaWPMnCE96/yZcgIgAbz/OgKiO01McKO4QuFdanPYqhyzUt9D2nmKhLPYsobElbdDIBMcTNgtut
 ZeOZ14M8=
X-Gm-Gg: ASbGncuNMeWy5t6USLA0pjlehT6RjOPXhwxlO6PtFTkSMxjSyMwtpMn6uCj4NgksVcD
 04h89jupNgjoBXOH9l14GjObGvYO66eT7kuz9HDFxoodOu57uf7hOAY3vCVCRZuluyRAV3bDs4G
 B1DjiYr9nfecyM7S5cTtcXo2QZ6aZ5q0RTBH76skrlY13v8XDTslQXblOyHmmfnuL/oQT6Pn0AA
 yslq9CKt5yo9p5wMxml9FLgP6REVx7igXt2zDTt12ekBCihdC8N8B63J9TRLhf7P+zl3rkjsp+r
 6zDQe+0Q8k15PyUG2TsWh7u18yn6ELETK6OjusQ94UpeYkmzqlnRJfv7sDvuypWSuUN4RNUIncA
 JpxHUboevR270jfE0kjq+12eXeoXx1sSpMLLnfZAQscrlrQGNeabxbF2rz/Jtfmi8tuup1k7/
X-Google-Smtp-Source: AGHT+IEgj8BFmhs1/uas98pbBPiZLCnBYS6/fpLAxifNtcYFJdfNc9kXQFaGON/PNK1C/2IYaMkwkQ==
X-Received: by 2002:a05:600c:4ec6:b0:459:443e:b177 with SMTP id
 5b1f17b1804b1-45b4d84e192mr130045e9.25.1755724747224; 
 Wed, 20 Aug 2025 14:19:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c8e7f2sm52398185e9.12.2025.08.20.14.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] hash: replace zero length array
Date: Wed, 20 Aug 2025 14:19:01 -0700
Message-ID: <20250820211901.21986-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Zero-length arrays are a GNU C extension and instead use the ISO C99
flexible array member.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cuckoo_hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index 26a992419a..cf5cd29144 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -131,7 +131,7 @@ struct rte_hash_key {
 		RTE_ATOMIC(void *) pdata;
 	};
 	/* Variable key size */
-	char key[0];
+	char key[];
 };
 
 /** Bucket structure */
-- 
2.47.2

