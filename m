Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2ADC61DBE
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 23:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4404E4060A;
	Thu, 27 Aug 2026 01:59:48 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id D535440395
 for <dev@dpdk.org>; Thu, 27 Aug 2026 01:59:46 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1694364a91.2
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787788786;
 x=1788393586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2EqViHf12HJJS79kjA879LFPqegOSRowmmyAeFoQdas=;
 b=uZHhtbEdEwD2/xsR8f//Oh2PdzyLfzM+QHnjFz5TKGKZzOUfv8PvnOCzOCjO1AHo2w
 djDQAwihaPJccfhMEv9YKz1rQ18fagPcpEVBolkwLg3Mybvi3wqNutYNl28HJtVvatMn
 s3dtDDogUwmvztOlgBFi+iAzgg4RctimUgyHjOy+MIWkSwLOt9bPGKfcb1RNQ4pP044I
 Rwgeaf2GXEN30uhl3aKx6Ze4tZOnAZspkBF0uPijh6M5IpH0AJ8CBCa/zP/Uy7xKoYvA
 /QWLluRFbr8QiQ4mX5A46FTSDB+70abO/oynkpUA9a7oAxv7vzZvDnoxUmRcAFk5V47K
 9o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787788786; x=1788393586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2EqViHf12HJJS79kjA879LFPqegOSRowmmyAeFoQdas=;
 b=TDpR78f9uMN429Ipyz00+KLI/IyMZFkRiAsqwk40qbHrJyBJIfStE3cuV0KAkUAWJY
 Rz7BONV/qge4HpuAcrCcI5/XiD2vtoVlhybG6gun+31ELCiyQ2E4Fh0l8oy259OWhfxg
 Ja7JK+5bAzH/lMXIvMcudHIjNGVghBiO5aaZK4cgqR16CSDpZooCKx/k9FuPfmVCgCUN
 EwDdUaSqrUu102xa/gdlUHGz4Qq/qrR92m+23L5l4YK/yulA29Ngcrp9HOGzihkpZ2BH
 RcpKNKwwfLcdqQU0lnaysRKI5NYtZZcQf4BM0F+4uOFNDh4Hm2l+ZrSgiFNbKKWb3ek/
 M4Sg==
X-Gm-Message-State: AFuF++nj2ti8zIc5Lgxr68867nIgdu4ryuTpLZmwe0LDSjSJhMUWTwta
 s3X6rZVhGnp3JPpsybUOKcyLmYKpZhNzQX/37N9/Nmyi/twCSW+CC+EJNWqrHtVGGP+ybi0LUjF
 2k0LM
X-Gm-Gg: AR+sD10eLi6kzjjgYys2T2xWXLev5UeeCDa3NgwntwDedNiUBbdbtCApVa3Pq5/QOVl
 pzJ2sRPKjzW4BsYzniR88P2MmFFJIO2zqdMfBKKmXP2wprhC+6oD6DJ9zLDnrGD35svjtvQpGm5
 rwBKBwuOBvVZhpoZqJjUTcdUnu5FNgdQuUBB5jMJDEx6Vll6c9q2fhQGzUgFuAkHc5fwQo/ZGQn
 17mbTpBJs4rJwNPXLjl+sbSWZCzwH8z7Cs5x+Bb+ziPp+DImC/VIeEDoLpQkXjxe06fJXVKnHk4
 4fGnLO467L/GkSBZrC7AAUgbYpRQuJBvDFq2DOEGl/5RJZVvLeEkA59I0uVHRtd02fU5WiJMhFs
 7BpFah1sLS6GrAtSsMF1uzJagtnxS8y/cBOCsZ0HjA0oiAwPxTYIV1ICr8QpTxCxsMw3FcYNBMg
 CIycsMw4zvismPMdVw0DTZ5DktYAlgOL2o48arlO5u+e+xyo0wK2rZDFGb5b4ah58EcWQdoKfKL
 41fWvgLBwAiO+Yfs8/BCdQNBtk=
X-Received: by 2002:a17:90b:5543:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-3966d13eb75mr22820804a91.3.1787788785899; 
 Wed, 26 Aug 2026 16:59:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm11019596c88.1.2026.08.26.16.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 16:59:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 1/4] common/dpaax: fix unused variable warning in non-debug
 build
Date: Wed, 26 Aug 2026 16:43:01 -0700
Message-ID: <20260826235933.194681-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826235933.194681-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
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

Fix compiler warning on clang-23.

  dpaa_of.c:14:12: warning: variable 'alive' set but not used
        [-Wunused-but-set-global]

The 'alive' flag is only read by DPAAX_HWWARN, which expands to an empty
statement and discards its condition unless RTE_LIBRTE_DPAAX_DEBUG is
defined. Make the empty expansion consume its argument so the condition
is still checked in a non-debug build.

Fixes: 8c83f28cc8a4 ("common/dpaax: move OF library from DPAA bus")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/dpaax/dpaax_logs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/dpaax/dpaax_logs.h b/drivers/common/dpaax/dpaax_logs.h
index 90f0c98863..431a16f45a 100644
--- a/drivers/common/dpaax/dpaax_logs.h
+++ b/drivers/common/dpaax/dpaax_logs.h
@@ -5,6 +5,7 @@
 #ifndef _DPAAX_LOGS_H_
 #define _DPAAX_LOGS_H_
 
+#include <rte_common.h>
 #include <rte_log.h>
 
 extern int dpaax_logger;
@@ -17,7 +18,7 @@ extern int dpaax_logger;
 			DPAAX_LOG(DEBUG, "WARN: " fmt, ##__VA_ARGS__); \
 	} while (0)
 #else
-#define DPAAX_HWWARN(cond, fmt, ...) do { } while (0)
+#define DPAAX_HWWARN(cond, fmt, ...) do { RTE_SET_USED(cond); } while (0)
 #endif
 
 #define DPAAX_LOG(level, ...) \
-- 
2.53.0

