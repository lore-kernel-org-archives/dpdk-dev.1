Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12340C369AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 02:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A33540655;
	Wed, 16 Apr 2025 04:42:57 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id DF25F40289
 for <dev@dpdk.org>; Wed, 16 Apr 2025 04:42:55 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-22410b910b0so43160485ad.2
 for <dev@dpdk.org>; Tue, 15 Apr 2025 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744771375; x=1745376175; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZQkDHQHAE8H3fp2NJ7y8WrGZ6FHt4ihdhUWuvJAjnBU=;
 b=cB8gw3tjoeYv0ChZc5C01pugS33fz4P/KwxafePmf9OQfUGDZIlt5Zjq6npWGi4Sn3
 trts5B9aUaItfv/lq4ri11LixPMOrxmMDxml+g0MFLCppbYPeJYMAeKXuKIeV3WdLxyU
 MD4CmUmmQRsnG+WUqFEqfh/V/Z/ONX6OkCAB4TlKc95IZkX2HuesBNXSWhqpcpkqSEV6
 svug77jgGrewOCzgtN1qRGSgNkEbHkCIeTaQ4+b90A+DpmvBP1VTZBQfqXYRaeKH0+b+
 dQ3VXHQ8JwUuYY1LUKuBS9JXYa2mJlTRIPlUMkC3sPR72065K70IZAuWiUpUJ5uwpT7F
 mL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744771375; x=1745376175;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQkDHQHAE8H3fp2NJ7y8WrGZ6FHt4ihdhUWuvJAjnBU=;
 b=B70NykjZFehKLTZ4a2LiyEpLIgoy9fJda3W2kURK2D7ilhQ9fNY4ZuDBpY0T6Psk2T
 mBvJ2yBhjEVyftq5w5/tUN5hTEutjrz9HJptgz/smdah0gRf/3hyp8tlUXWvueK+k0xU
 VX5wLnsrhgpYYitTYaxgedlgyXIoq28+4BievbCtcimoCnFaB+U4v/Jy7LN8+vkRTOp6
 PLfiFlox0Ecf8dPAqhB8ukFBvkK5g74BNommVT/XdhfhJVcEWDH94paTHywou+SEmi+j
 7tcO5+U5+Yj7Dfsn7aZ+usF+zaKQdZXwybab6fBHzpUaCNsIgTMLriQfvdfVwLQml44I
 I7IA==
X-Gm-Message-State: AOJu0Yz9mpJv586Fx6Lq5uSMrzXba/VuFfqy5MKirLYzCQareIxSIsvI
 wHXgc1UW2GnDXEqyJeapH6KLUnQqAniQ0NdYeNv8i3hzM7sqTLVRWIfqak5vpNVsttHaEEQYRGN
 /cHnMKCDWCA==
X-Google-Smtp-Source: AGHT+IGSRGfUUOuSlyrufwIFKwlNR39AWnt8U6ivCj/31USRj9ZKsMUD/BLQVs/PA7e4rpznfqXTkgiwzTEoSg==
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:2ee:3128:390f])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1905:b0:224:10b9:357a with SMTP id
 d9443c01a7336-22c359743ffmr2466695ad.32.1744771374802; 
 Tue, 15 Apr 2025 19:42:54 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:42:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416024253.713448-1-joshwash@google.com>
Subject: [PATCH] maintainers: update GVE maintainers
From: Joshua Washington <joshwash@google.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 167cc74a15..96e1d4e7a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -754,7 +754,6 @@ F: doc/guides/nics/features/enic.ini
 
 Google Virtual Ethernet
 M: Jeroen de Borst <jeroendb@google.com>
-M: Rushil Gupta <rushilg@google.com>
 M: Joshua Washington <joshwash@google.com>
 F: drivers/net/gve/
 F: doc/guides/nics/gve.rst
-- 
2.49.0.604.gff1f9ca942-goog

