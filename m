Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18DDEF99E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 21:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C314640689;
	Fri, 13 Feb 2026 22:41:26 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 7587440665
 for <dev@dpdk.org>; Fri, 13 Feb 2026 22:41:24 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so945324f8f.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771018884;
 x=1771623684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7lBi1c0DenmY+VQlxJ/hgPqEc4Ij8JerXdkvdSzMuA=;
 b=btgu7wSRYpq1q3olJSAlbV+WiWuJ774NIk3m3nzzftmZk2PkW17/UJp1OxdqIIQwdL
 2LMSeyin3DV1UsNEQ6BqCDfSicbCaJa0IvdgRN+Opou7UMXF204RINT9k6BqcLt/IW+q
 TRGaX4sm+SBImz/AsQdBzTiYB+xtBREHv4htOP1maBa6B5AG9mtvjU4U9Ouw77so5KJP
 07RqlYTVmWxDWgcVrqzeUO9BOMdErEzouNZFK/WyPIrQ/4cpozToDaNf6V1kRAi3TkgW
 UXJIZlurcxeeHiSimpC+621rootnvq+zSPuB3VTxkEV++DmAfyaqX4SHCPxszk5wTx0B
 n8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771018884; x=1771623684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7lBi1c0DenmY+VQlxJ/hgPqEc4Ij8JerXdkvdSzMuA=;
 b=oSkihz6XOHSdI2WvCXpmzDJPvMrh1Mgt1RRRZST73DAFnvrZ9j+05pmf9MbmzzI657
 fris6GN8u5BzwmfX1oeRzJ/ouGKdNz3qB9fYBcz3ygdHuvb4A/f0+lSsdZr3vSbuZyNx
 lVW6fjlCMdjMu4z8XyM0xJjyxuUW0CQq9XCbfzkn7VvdmDFN6VOPA6VumIbEcY7BQ5/u
 3vmG8wOXTD4hxDeJWbBCDNk7XZSSiyXy5JkDHKwDV/P4xs1mY+yJ4BFhYiJZIJaGqE1T
 6S0pDOCnMZ9wFc1ZbZAU6EZYTg3iI4UddTLa62ipIYMIrClEykzLVcdtaKV7B47i0yUX
 BT3w==
X-Gm-Message-State: AOJu0YyQ9YYPHzKtpujKrs7KU2WOhMU1acREicV853qtk/7I8/fEfXo0
 Gf+BwF7yeXaAco8dNUMR7jpLBKXF2gZZNLfzUrsdv12EdM/tr56oP/WUfz310r8ZLD12EePuZ5H
 4fPGt
X-Gm-Gg: AZuq6aJZcQ3s//ThR+CI9TrCFBTANCeMyfmNLhhuUs2LkyJBjjhNbd9FZLyXUHzF2Q0
 OBYsD3L85wXI4c8yIQ2eP5qQEAdcWO9SAMbWeae//DEGnuP8aOuqTrs50M80xbl8UJRoEGzhpy3
 tLEem0xwWRnRyKYiUJ0qbf/PYzKIEgu7QZDQH2DVnDKK+CdTWeyaNJdDZmEo4uFi7y+o+SE+Xqp
 Q17wXTP8IWTycjrryAxBLO0feNE3h5P5PQyymg9cCDCwX7bWu66QbggCRSUGQms+QSIXKpWCLBr
 rGJvmoz+JECTHpGm5Ul8q45T6vSQ+x6UBoFVCFiFJcSPXzAGarDgNcAt3zeYCYDABpdrMkgIaIC
 1XhNVMCcRu8xogQHf+4k+XanuERrBwFS885GI6RywA19ltOk1rDU/kF6loZevVzk9tBNQYHNZOA
 448lGTHHFmNrCcN9FCssgVfrd2o36o68MmoN4/WxU1SYwHWWKUIy7Q3q9yJSEdIw==
X-Received: by 2002:a05:6000:1a8e:b0:435:a0f5:c271 with SMTP id
 ffacd0b85a97d-4379790ee4cmr5957651f8f.31.1771018884077; 
 Fri, 13 Feb 2026 13:41:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac9d77sm8346895f8f.33.2026.02.13.13.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 13:41:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v9 6/6] MAINTAINERS: add section for AI review tools
Date: Fri, 13 Feb 2026 13:39:11 -0800
Message-ID: <20260213214107.234072-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213214107.234072-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
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
index 25fb109ef4..e8362e83ca 100644
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
2.51.0

