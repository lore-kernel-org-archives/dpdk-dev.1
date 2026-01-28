Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E71D46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE4D402DB;
	Wed, 28 Jan 2026 20:47:44 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 4230E406B6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:39 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so1671275e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629659;
 x=1770234459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCELy7rSsfUIaRL/L9D4e5qCK+U0tzhfHs5M0elcAgA=;
 b=DINLgvgSpRNHDKVCncejeWuUeii2MVf+qibNGhk9Lfuw595UXvGF9nIfHJMBPe7Nle
 y0F6erN5BbP+aKs9AV974xVvMzb/C0nd+hldOPA3VaqZBIhUP0pIiIyr58NCg9OKWrbZ
 ZA+7SiYCAX20p2aUWIw22n56XTVLPSDRimKB6jUyaDY7Rp6KF1JBmmMsKqrik1pd2/8l
 uSX8ra7hYIAIbyvKv3AUKahQ2+hZHgwzNw2uVRqSqAh4j1T7fRScXXGQ/qRe0//6hy0L
 +ipVeC0onnxQv61YxR0YmX9wszex+jbc+D3pIlt9SzN4o2ydyszHoBos0FxEv9iFDOlw
 tsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629659; x=1770234459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JCELy7rSsfUIaRL/L9D4e5qCK+U0tzhfHs5M0elcAgA=;
 b=SfdO62omOw5bjdJdYhnodDyPFKAvcl3hxdf1P3c85wYv9OAL4mfCiT69g80cdwWWxX
 K14feWLEwvLRTwK7MKWo8QNsPiTqpo70o0d5eipMy7QZCrqhc1dNspS3k9JBYTv7l7Bx
 Spk93n1avUNFpWzw9lGxlYvpQc99OFlMoRllEP3kSrU7UtL8iJgRz7NHYlbh2B8i1LJY
 akhDUK/rdM+8moqeYLqVMQG+gDpO8e+z61eH+SgsHH4vTpgn+HUksEZ+apFOM88ptuYJ
 PKsmMSCv7vj8yig7KC3cY7P1DtfHeE4BuUpTcSZpqF4tOIc/emnOJ5NkmRLsGFqJYVuf
 aQ7g==
X-Gm-Message-State: AOJu0YznI1+NoQqASA+PdP+iL/URrquieouuQj1buS8GN3jfj77CRcnW
 Y6RyaQID3RB9EioFhys20M1QLhT5wWxFYpKSBkNM+Jh3QaT5nk2w3R4+0UqGQv2mlEDY/RDfWaV
 uSrMz
X-Gm-Gg: AZuq6aI9EPDIPoDxgQNdOr/h6SBnj5fVNu13aPE3w4cTeCtNxOmAuzxU6XrzPNQLWBT
 KCJYEC39BF20PwXdk4M08OdMDHgJdjTuRHZ7dgr5mna3tqUWc+Q7keBmmRFi6//Yw6Fg/b6wYig
 EqIDSgPudCBFaOwCVIGAtAtR3QzKJLNt9RmHMInVpui3fdFxtgGMs8/WdSJQ30pRZjcz0vDUpMA
 QvG4w0EIvjQedDoO/Wr66k3aQLkdDJ86VnsO2FY0Qv+t3HekwArJBxLrM97zC+9c3rfTxnD/JeA
 gDwtHUREv6/2NN0wNeHCpzUBYeuD5QnBAEib4SKU/zsT4MNZnsL9orDJtvWXG7CrcDDd/DM8o74
 8JFbQOC6ieo8vYm8B2ereF0Cf58F/vsDyL1eChdJZW4tocLXjYS7BRxTM1cyIxpcrBqCjF7XFYM
 hLwWcC1WDllNuIya7YSPNzpyCAqzWItchI0QUxlS6KrUF7aE9nMQ==
X-Received: by 2002:a05:6000:1786:b0:430:f68f:ee97 with SMTP id
 ffacd0b85a97d-435dd1c1d82mr10139273f8f.40.1769629658831; 
 Wed, 28 Jan 2026 11:47:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 7/8] doc: correct alphabetical ordering in ethdev toctree
Date: Wed, 28 Jan 2026 11:46:06 -0800
Message-ID: <20260128194722.480862-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

The toctree entries should be alphabetically ordered for consistency
with DPDK documentation guidelines. Move "flow_offload" before
"qos_framework" and "switch_representation" to maintain alphabetical
order.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/index.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/index.rst b/doc/guides/prog_guide/ethdev/index.rst
index 392ced0a2e..82a749e2b3 100644
--- a/doc/guides/prog_guide/ethdev/index.rst
+++ b/doc/guides/prog_guide/ethdev/index.rst
@@ -8,8 +8,8 @@ Ethernet Device Library
     :maxdepth: 1
 
     ethdev
-    switch_representation
     flow_offload
-    traffic_metering_and_policing
-    traffic_management
     qos_framework
+    switch_representation
+    traffic_management
+    traffic_metering_and_policing
-- 
2.51.0

