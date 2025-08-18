Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1032CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2115406B7;
	Tue, 19 Aug 2025 01:33:17 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id D6B09406B4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:15 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1b0b42d5so32887535e9.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559995;
 x=1756164795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39GDx5OlnFadZYHEwhaEWKQv+9zNH4IcEnUPKi1frPI=;
 b=OaF5w1tSAF7ogjL19vGdFq3rCb4P2RvUjQvtY1MTv3zr5UmgIPE3DXad2s5AgAHvvp
 ol0i2eqWCr0liROXPi0ksLLTShVnmGg3TaR2ycDZRG1E+nO7vR57qjBanuYk/tFQVtDr
 abXVbIekDq6faV4wJD0IpRnTGHCmb1DtjsE6p8+5uOBViTpqks73VLdB7AWs7tBB1zws
 PqXxHD6RdtH1qIssY8QrfoBk6G4+kxtaLNB7UVYVrTHTfMx2Gm0M8mdnwHUikMTVupQB
 qi+uMfCeadGMxTpmyPrI5eKWEHs+Yvdq2Y/a29vcKyViqLEMXnHwef3isn4wfPsZXXaj
 S5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559995; x=1756164795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39GDx5OlnFadZYHEwhaEWKQv+9zNH4IcEnUPKi1frPI=;
 b=pjY/J5k3lIiWqeEQ5Z9zWVkeCUjywgz1hqHO0ixP7YrKZ7w4OXHf6GkvGQsGLyMira
 rLKjDzB6+lE0V1s6Q5leEIbsMyw6M+6AE6DL3a6GnyCQQh8Xrv5WneUbFTqlR/YfgmSw
 Uq8sn7dCenE0/nbehBLFOjFY4b+pwKk/7flqr5z4L9cOK8Kc/boHJWRDA3dm1i6OCgz6
 BS6l+XtQcoPRJfLppRF4OdzH1Q/Nk/6S+8ikHAzsVRQw+b4sHE7KUDz32UQMsnw4mXzE
 B6X8+ZktSeGcHBVqyiIFVu0d4nLXWlKbhJFphRn/ivtZhiGjK8xi8QlI5pw3K23h9Vgx
 ilzQ==
X-Gm-Message-State: AOJu0Yz0NUT/W/0q20Ct6WvjTniAg/F714Z9ILGz7DwhSDU0hg/7Bqno
 EbL85Uxz930lfKKRdSF+AoiIjIsu7KaG3YQzYpPYz+ynVN4tl8tt1S+B1v3KKYkUpDaM6oubUz7
 JUxTt
X-Gm-Gg: ASbGnct3RVZ2tTia3cTTQmeZL/hr2eDWzlbJITqzAwA8yx+ZJKhLG69ODi82klVQtJH
 ZrFrrtPIWWykdGSG09kuF/dU0JgwZ6fzNWImNnII8scqVbTvuSznuMr6znf+Q0tdsCznAU/JwXB
 01XPoaoMcIrWDiswvzs5rVaPfXEVcw4k9IyCuPKt5qoTyBNQiDxz7ztotwPtpybpDYBZH+isJgi
 cPGJVxt/qrwJwXEyYQjYHFiqhG/a+k2k8C0ckf1rNHqj0TiKg1Lu7GMH6FFVox0yBS7LGLGU7Gt
 QfTXbL8ZDcaUL8faJqwWQTpCbV+gB2DzmaH9BwKFp0BWT4uPR55ON6MGgLf4Q1vcKYfBFtfk2FC
 Sjludb830rdMEb0WMtmViKnySNA02kD4QK7fO+LqWO6yjT+jto6qaVmEFtCUa5IlMomBpGbio
X-Google-Smtp-Source: AGHT+IFe8FDCgY1IOnsgPqqd94kiCayd24dWe3OnIWBRJUYA+Dd9I/foT73GOc3qs9ohVHJCG8hKhg==
X-Received: by 2002:a5d:5d11:0:b0:3b8:d79a:6a53 with SMTP id
 ffacd0b85a97d-3c0e314f262mr289789f8f.23.1755559995481; 
 Mon, 18 Aug 2025 16:33:15 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 15/47] log: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:26 -0700
Message-ID: <20250818233102.180207-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Use bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/log/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/log/log.c b/lib/log/log.c
index 8ad5250a13..63289dd9a6 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -11,9 +11,9 @@
 #include <errno.h>
 #include <regex.h>
 #include <fnmatch.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_log.h>
-- 
2.47.2

