Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE89CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB124066D;
	Thu, 28 Aug 2025 01:15:43 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 5FB894065B
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:42 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so2387465e9.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336542;
 x=1756941342; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1h+aNYn7AeuFUWgxMo70gi6BXL7knsIsHOJ/zRi8N3Y=;
 b=T1JdCktl/7stMKGanbMPJpo5P548Sq9WiYZCagWZ4MEtQPeaJ4QC/dkM0DGEOM52kM
 E98hdRCnIJt2xcuQ3gn/GRd/ddzunvX9M6ShhKiXPoEuLcVeP1nzOyXMAkLOTaRYc2k6
 DRMRalrxmLa2MPC9OmT4YxXOJuWQyRaM02RLeK2AEbTfwGo6p99KKozMuPHFaAInMROX
 kootwFcBwzoa8LEeNaEHOEzbh/kOoXXJV+sY3j6seW+/Z7G066DWjtlEMAwK8ZKCUwQf
 QLcAey6XnPngUyWl+EXdGe5GB61gih70xD4rZNOZSPMEwuHe2dXxkPwrSoSYFQLOe0WT
 WzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336542; x=1756941342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1h+aNYn7AeuFUWgxMo70gi6BXL7knsIsHOJ/zRi8N3Y=;
 b=ciVna1R21Yaiwr8dJ0Nrj+A4grFDceCE5o+mer8nsMSPVXiy9LbD4vTX5TORaf866O
 elyXQFLSiYe7xiFx10I0+UfeLtpm4mMrDdAjfwDsuCjNGbeAS6s7BVHjq9ia5AnN1Hm3
 aaZsNOt9c+heBfPtf+q/JaJ7+fQsWunOyah2cGCNWdh+yQ2mZoausOGl/Vu3aEfMnd2a
 WRFOdqYmCML+s/qLIKq0lU/r2pt4hCm40G9x8PSJprv/1EMIFP3//EWIwR8Xy0POC6KD
 11PlT+ebE9ND3vVmO63OAFOr6TXSDyb/MNoc9qNysSpKey+SOf1BV95/jTDw1yje0aS4
 sx6Q==
X-Gm-Message-State: AOJu0YzXvwQy3C4/CMfWaW6ehVP2tg0hQ+MN8uVwtIKCBIdGdhXkM8kC
 Br4fuB2k5C22qg1MnXJC7kkvTtWHWTof3dPxLWggFA3OkqOJwxicIYS/4LO8trma6fXJ+NWaASf
 IDxKm
X-Gm-Gg: ASbGnctGXvZWIF8ODnKoc7FewWziIeXY6HHhZozER4lPScEZi+9JJoQJ6wK8i1QVM5W
 imNSraDn9YMgGybkogOp8oLSK1v8Ef/35QwdJ4a/s8kicmIydukcB3bW6jIeBl11SQzK0otSf1s
 sqWuE6GXAEQiSnrc0yOcfKgOvGdIfYBZOmlO1UXB30b8qL+oNUAdVnKEfXqRwXZV6bjIwIFQwwz
 tGGMXlWYYdb0iui6IRZFIHVKBSCLwKA1N6m2unuS9r4rZxLWJBwr2kf+EGiWWVS9bzoO6LNcIpS
 Z41u+rzjbNStLnlPVQi/o/YZP+vJFqTs2NpRugsPjgKGYu/8uaDz708w8e4lECCHEuYJT9+1CZ+
 4DVbHM4SFJALjeeVdUQrCXyPJM9gMzQwYAcdmh7umjG4wEVV5rH3yNNdEFjCmhaowejdRSzMN
X-Google-Smtp-Source: AGHT+IElIgR1y+m7omjWAtlca7HrSbL+Me5BhDB3VYSl8wKtmQiULci7ijtlMMu1KMJVYi1TJ7IHWw==
X-Received: by 2002:a05:600c:1387:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-45b6870e70bmr72608545e9.6.1756336541837; 
 Wed, 27 Aug 2025 16:15:41 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC 3/8] eal: add macro to disable shadow warnings
Date: Wed, 27 Aug 2025 16:14:06 -0700
Message-ID: <20250827231528.236172-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

When using constructs like:
	RTE_MIN(x, RTE_MIN(y, z))
the compiler would generate warnings about overlapping definitions
of the variables in the macro. This is safe so add pragma support
to silence the problem.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_common.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..34862cc97a 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -210,6 +210,15 @@ typedef uint16_t unaligned_uint16_t;
 #define __rte_diagnostic_ignored_wcast_qual
 #endif
 
+/**
+ * Macro to disable compiler warnings about shadow declaration.
+ */
+#if !defined(RTE_TOOLCHAIN_MSVC)
+#define __rte_diagnostic_ignored_shadow _Pragma("GCC diagnostic ignored \"-Wshadow\"")
+#else
+#define __rte_diagnostic_ignored_shadow
+#endif
+
 /**
  * Mark a function or variable to a weak reference.
  */
@@ -791,12 +800,17 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 
 /**
  * Macro to return the minimum of two numbers
+ * Need to disable warnings about shadowed variables to allow
+ * for nested usage.
  */
 #define RTE_MIN(a, b) \
 	__extension__ ({ \
+		__rte_diagnostic_push \
+		__rte_diagnostic_ignored_shadow \
 		typeof (a) _a = (a); \
 		typeof (b) _b = (b); \
 		_a < _b ? _a : _b; \
+		__rte_diagnostic_pop \
 	})
 
 /**
@@ -814,9 +828,12 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_MAX(a, b) \
 	__extension__ ({ \
+		__rte_diagnostic_push \
+		__rte_diagnostic_ignored_shadow \
 		typeof (a) _a = (a); \
 		typeof (b) _b = (b); \
 		_a > _b ? _a : _b; \
+		__rte_diagnostic_pop \
 	})
 
 /**
-- 
2.47.2

