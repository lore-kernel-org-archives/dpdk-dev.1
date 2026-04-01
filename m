Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E710F6FBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 15:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7248040E09;
	Wed,  1 Apr 2026 17:42:47 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 78C4A40DF8
 for <dev@dpdk.org>; Wed,  1 Apr 2026 17:42:46 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso630416b3a.1
 for <dev@dpdk.org>; Wed, 01 Apr 2026 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775058166;
 x=1775662966; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuFxiuFO5iEPwIA+HlQGeXxSolc5bAeP8xbmCtx2IJA=;
 b=vaPEPohs9XJaWX7aCCJ2KZhpUApOt7LcA7+Htjm4KKfFlmVSWP1T6Hy2Ig5K+/obXR
 lJ8j2ck8k4GyofH3wJtxNG5Qxb7dySxtlzSZKAIR+Bd81gWZWH+Nhi6YxWDBhU4wGFpH
 V60Hld17Rp17+iqUQInbe965NnMX9BLkHqZKxNjh5cQ8Rlz3DupusOO+4v/2GyzpS2W0
 iddxPb1tg653KGypgl7hZN7aYzH2+Bvz55Ynm+Y2ufVGeM9zhug0VVTiFZdZocCZTXvm
 l5qKfau/KGhmEnDCndHzEtAhZeLMF49w2TZWH6QE4IxPfPyef69vSJRS2Fgp3Su7F6f5
 Dvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058166; x=1775662966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuFxiuFO5iEPwIA+HlQGeXxSolc5bAeP8xbmCtx2IJA=;
 b=MVarB3AYugfgaPwNReFFbvP8Qi08+CcipdnKbUYxmtZIgb+yy723GzWcP6/s4h435p
 KE10k/X2iCIxgPaGa3buULIPhL7hmrR47xJj3JXhU+R9XdNze+k12bFpPhYZ7bts/SWp
 SfCROyuqm1KN/dk/wgjTszu1OHhudBPzp9P32HpsnetTe/3DTSnBYkUR3tA9s3Kd3OnE
 jbyI3f1HzrZ9rHymRB/UClkfhiV9oOhtfbcgeHCNw+zmjMAHHHxpt8IoTabGlaY3LGZe
 /U4rAcRi3pKKJcmm9uAyHRW8erzaxHXoY2RQT5USS3MPo2Q6TlyS6khM0EIN5tiO+iUK
 ef1w==
X-Gm-Message-State: AOJu0Yw7mg50wwh4e/pKwCYxTfbm2KijRT8uotPbwBfNEbdgJeWDpOiY
 cRkrLufD5zVFaa0rliGugsDCcqtPRc15muV9xZXzl2riU/xVdZuJgRJStWhJdf4nfdMveZIt8bL
 +2X9v
X-Gm-Gg: ATEYQzwmORcMTJUTZ/YWSE/yuitsmtEFGRnGHUpt1nmpmUjMB1/Zn1Jh1LX6sQ74im1
 Jx6QJYhh0ZHM8/rMXSW1RiMkbIh24KP7cEoB5hZ4K3mnoiL9DnhGwBU+0cj1454FHyl+Cb0jz1J
 DZq+HwrJSMaErBAT5tKE0oq3Jftk7vcjUuMs17KJS7kABk9YTcrpjxloLjy2M+Wphnb75aIW3Q5
 52Sl3/7axGcheBtXblz5Yt7YbK96558B69tvXxrvAsrs9sY6D5UQ2BotmpFJMTBetZqzq3jb3XK
 kg00QF7xgFtBV+sYlZIT+0HWDLLZqocnbUUhQyFNA5CCKx6a4WCQSGLF7aepGrd4WM1ywOrtRmv
 GPrG3Yxsf+9VTOYOhOaj/v6sijK1BwBXw66ov5H3OneSOrQYKA4OvwSpkwv7jDrvpsZjubWdTU0
 BEAq6HA7iaVNNwXfAvl2DqHxRNzTbFByEx
X-Received: by 2002:a05:6a00:895:b0:827:2ee7:baaf with SMTP id
 d2e1a72fcca58-82cea7e3c24mr3377276b3a.12.1775058165602; 
 Wed, 01 Apr 2026 08:42:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b2694csm297749b3a.2.2026.04.01.08.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:42:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v12 6/6] MAINTAINERS: add section for AI review tools
Date: Wed,  1 Apr 2026 08:38:12 -0700
Message-ID: <20260401154218.160500-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401154218.160500-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260401154218.160500-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..c052b6c203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
-- 
2.53.0

