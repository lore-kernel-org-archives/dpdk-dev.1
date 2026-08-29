Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E093C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 15:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85727402B6;
	Sat, 29 Aug 2026 17:47:21 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id B6DBD40280
 for <dev@dpdk.org>; Sat, 29 Aug 2026 17:47:19 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so2419048a91.1
 for <dev@dpdk.org>; Sat, 29 Aug 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788018439;
 x=1788623239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBmvUmKQcNHqiBWWFxh3wT77PlU1uv+kTtpUWJ4nRm0=;
 b=JvEGKVzjCenmDuzrzyGNmHGBBwLL9ykEp6LqWL90s8QYgT+X3apbVOM/P8oczGiFeb
 mBokrTkzB9m7LJEd61LHplYnakP9fezEo7hH7pWAkcKdMPC1aQQx280WEPu66YpAn+0u
 MUsBfXC3sWsWtZPwcHMjjN8Ke5Y7C8tyAN9zOhsbKEMwTo3GzojGqtLy4XQWc+stnXcg
 GWUTn12H+L2+r5OMky5Ivvy/Gt4KmKshVdlNuJiyj7YscUOmGFGGok87bZWl13ZDbo+W
 a9UBGpgHjAMWgrqoJzwcKTZNvs2NmVz6lsWAlJ7zUuNZJsiyisLkHNJaakhP9U6eeRK4
 cOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018439; x=1788623239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBmvUmKQcNHqiBWWFxh3wT77PlU1uv+kTtpUWJ4nRm0=;
 b=r5Urwo+GFcVpmGx1q4KwYaZo+eZDuUHNpN8MZLxSJJY1d5fvrGWCo+QahkXwekg5Y0
 otFKD6+kqDe3341cETqanuJIYFqZV7yEH3cxMnJIds+PhvJ4WjYPcCgxKl3qzVNImDzI
 spXm2PhD50Msckoajbr5+9epXGWkqLqJTsWQar64XxCp4UtDBnvwrt5GOxQcB51AiFtm
 cP10W8YlXDEaU12O436hUtTDqxwxwm+iianBEljgF6vUHjiXketw+rJS+d37ECwBKkOd
 7tNe0ZWo7WuPfTjktYW1xr/mQAvXLUFUpLSB7z85fYhNYJpm4VamVh3V1+SM56WQMHCJ
 IX2w==
X-Gm-Message-State: AFuF++n+EvjpqTW4SwCi8KEvoph75mPhIom/NAPI0yfevqgIvacL1hzz
 bh2vCWKRDhVcT0Awg08DLjkelbyAGnnY59xm49DJTMdXHoKFopvkdkmrEs0SiLB/swNCu9xldHn
 RHusQ
X-Gm-Gg: AYBFou0pwfbvTdK+dqeX1dA8Sj1Xs9FvQNgGW4jBbT6NAJlsx1allgMfT2Ovy5jZMOL
 2FEWEmOMs8iF7BwZayhjLYAoqWByuHxvZLLCAjEDPeRVpVKGiCEmjWtatdaLoeF7Wal8k5AK0/7
 eYKr3Za2ATcDjy61xC0UgJO3hlJorVDEMjF8hqj3NABrXGMT1/KtqE1SPo+qrNkq9L/ne5bEMdI
 aGkB2JFFn9tZY3Up+D/NhjzHQf2rSZknzcI+B680Dow+5rCDt8sKUjjWcJyUyQCEws8LRLC+V1I
 Az7a+44Nd2Ksytm5jSbJ97jeNi6B6gMq5Sbu91bzw1fCE2bomJifKXi4YvYssNrpMimbV79M1KI
 R9qWXHnLA9Ar/n5jD/bnL1saehcTSGEXzDyEzOwXxjic5T9EV4ExLYN3EbQkbQ54K0osjhLUbY9
 0AQtC31ApoPQKHgEiToSdVXx8lH59lFLm4dupG+MmHY7BQCF5bSZ+AMoczqfHt4qhyvRtQ8DJl7
 FmY32ULblJhzG4/roxQGn1Sbas=
X-Received: by 2002:a17:90b:440c:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-396d0eab08bmr24205877a91.6.1788018438719; 
 Sat, 29 Aug 2026 08:47:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e41837c6sm13221356c88.11.2026.08.29.08.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:47:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 1/4] common/dpaax: fix unused variable warning in non-debug
 build
Date: Sat, 29 Aug 2026 08:44:45 -0700
Message-ID: <20260829154706.52169-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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

