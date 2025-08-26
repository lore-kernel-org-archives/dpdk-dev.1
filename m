Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E3CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC06D4065B;
	Tue, 26 Aug 2025 16:49:34 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 0B74140647
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:49:32 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso49123855e9.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756219772;
 x=1756824572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFPNyr3M1BIfkSOy7qF9qjUAbUSqNEASTkdWqj+E1k8=;
 b=vETd+mDBYHW95+UfmOMzYT4wpnhUyi90xD6qmwLjh+YujkLWtQ7dOtU+yZNrEFoPXV
 Wy2k/uBViSXB5Z1e6EF1F5mCZ8OuWMpUSvS4JnuJxFvIb8UPczQqAKsDykoVF1L/0RuZ
 GMr9eyEvbe+9bJKxL+gXPvvtsAuWHoyh3MHH3grjLW4Qm6MC+mTAYcbCBuWVXMwNXsrh
 pXFrMJAgVXoe9lnliQKLecjZVD207PYfjSdBorKUyV/e04h+8uuvczoSeknmrujPvyXW
 /D2IvtVJSzPWwN5iWnrIMhJK7kv2lx67X4WTfHjgdHCqMNBHbJrhO+zMdj/ib0GZPvHL
 zwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219772; x=1756824572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFPNyr3M1BIfkSOy7qF9qjUAbUSqNEASTkdWqj+E1k8=;
 b=H3elwZfTHDDz3WHonw8u2J0O1gmyyl2ALM+erdVbnSlwxAtyOblB7+R84wly+QjvuP
 LeIBs6HVLXOVpzx5D60wbm5Y++PkLMkArg0gVT1j0r1EJkVjUJzVowbHhyT4NMZ1Ki+b
 Eb9WHkdQZK60FqeCDkSU7xrexRfJz4y+LuxCSxNvTgM/mZ2w/aT1878s4sMxfwXK1lR2
 oYvnZddBJLOQghND7nPVMgYOsKVpyMyaWjLlTtvG/xSEjT8UddX/kPAGbPSPRyGuG/g0
 JI1vPFDhz5rvHFLHAfaxFOyFSar1Bcltoy1I2Rig3RQCDkC3Tnm5sX9dI/G+ccZHfgw+
 Q93A==
X-Gm-Message-State: AOJu0YxvfTC/VBWk+1n+ge6EXim0Sfjgi/++i2HkInHPfIz8QzGVS/+K
 csjgNpR8IdHI0i2soeeRwsnrntFZC8Y8A3ZPxNmIdnyvZXtRHB2yv9UKseUiW3a05H93DOBFX9e
 5VDr7
X-Gm-Gg: ASbGncsKdxDNw4p273Dk+m4s34APzMW/MUub5LLkA4dYMlPP7yYDP9a+t7+VbomP6+t
 llWSc2SCIUfCrFUZUVqXUB4iS8jl/g/Kl/sz1dGUXotVZDzrracnU3ElDcUU5FEJe6KG0GE2OV+
 ERwb3RIsDp1xTZQz6wndwzBBxPLkYR4RP+Mixnbsni3KmZ23SUr8qlJeN+vi6DsfDm0gdjmrs1x
 bzBQnOeSknyz/cAG574CqziVGRdZi0QiBkNdg7xPqT+dTYD+kdMClZrMt+g5u/kXqNj7MPKFV8K
 0YlRV05F7kngyucaQ41fQtZtQjhirZkF+pdtNyQ3nnus43AGL81+/9z/eNiX6LnOwgFQmkKQLew
 gDviGKmnfaaV12q9UFCSIhJDYefRpWPuJQiLojWbF/GQNLSbS8+afiAWUUOL+zw6k3irm/tTP
X-Google-Smtp-Source: AGHT+IEWI2oWUc7X9cLMzJRIybSy9QCaDKadstdMDh2Wc8osTdRlHyNdlY7SAnnKaGvsDP7+eoy9eA==
X-Received: by 2002:a05:600c:354f:b0:456:18ca:68db with SMTP id
 5b1f17b1804b1-45b6a31a192mr6675945e9.8.1756219771639; 
 Tue, 26 Aug 2025 07:49:31 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492459sm154566785e9.18.2025.08.26.07.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:49:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 2/4] hash: use static_assert
Date: Tue, 26 Aug 2025 07:48:29 -0700
Message-ID: <20250826144922.74010-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826144922.74010-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250826144922.74010-1-stephen@networkplumber.org>
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
index 16fe999c4c..90fda7d7e0 100644
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
2.47.2

