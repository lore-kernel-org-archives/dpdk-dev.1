Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF170D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BD94021F;
	Fri, 23 Jan 2026 05:30:04 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 2892E4042E
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:03 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so1508294f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142603;
 x=1769747403; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=3KPV77wTSyZdZeCtiOzSiAhX3of6vkHyuUhBHA1X28mamdFd33M9yWtDMUscAXNUaB
 b3kc2e7Dns2GE8ndC5ilDnmGRdX3pYbduO6ul27prHX43UP/fOxdIaJ4EgAi0NGfRqlr
 dBaedFKlOmY7zioUtsVNF5I8gaIIS4qODXN9uGsXn9P3PgYIPztf/gIOFf9ttZoOQjwR
 pDdqOvxYEytae5smthrH4RfeF25ZKiBgwLK/rB+rYUbx7k/n2K5nIG19e7IDFBo1sjEx
 gVb4rK8fSLnNdvfIYJ06pKioheTcjy7Uysd9Z2VGyPvEnftls/hCAqLfPE/rq9zvF2tL
 YzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142603; x=1769747403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=mWbpucqSrEnkO2m1FEj3UoKQZWHtw0mvx5YvcIlVtNryhiLuhjy3VbGCzZYDwYr4kK
 c2+BNiigmt8KrsdzxZ/yP49UgTdtg3f64u/lI89eQltLwuH49nc95qcFbCSF3kbLr4Rz
 MqAFGaDgalhozmf6G029NUJVaZ/ETJu0ZXk5xKhcBQhw91/i2B9WNv8brXH/xo2ZsTxk
 susQ3FTDXpoBc1NEhteuZY1aGPpgvQz3sShjvubbu9wUYhLuyodyPo+kpmPcpA0W79v5
 c6SbIXBbv3Fm1JM51DQeVV8EAW3QA2ZucbWTgcjaWkG3CYanisoNggr9Ye2ZU2ispIqY
 9Fuw==
X-Gm-Message-State: AOJu0YxM+Qxv9yVpbT3u+S/V6JpvHnUfbBjGzvFlq0vJaVv1CN9rFG0R
 SVO5D9iVUQVA5IJM+I+TyNGfFetkEFHY172iDMedNwLXxnky9kDbmLl6wSU+qotnnbyRnlnLaoy
 yYAYC
X-Gm-Gg: AZuq6aL/Ql5zQeZLSaVnI8EqC1xxrwjLuev+J5D9lT40YXoc5pCXyWvGmlP/RgFNDod
 3C4FcjmvWxaSplRRJPLFHtRLzyaElZC3MgglGjX6bVWhiWivktLkljHT2E3X3Xrt9KExEyJxc6D
 h/kUdJUy6/p8vphvwY+UY/QDEq3hmepvoT/yHLedg8EuNIDGl6wkDTvI1fmFFv5vvr/ERsdg7m2
 wlxp2znieLQhJ8wZ4jb+9YZKwXNok0UMXZWW899QDUCkDfi/iKimvDHcC/p8iL58ovmd6TBx8yX
 KjwHltZ3g6hXj4ZpMA0f/mKoAgfUxb7clH4/ne7IyUWFEGUaamwCpsFXkQSVxZ+tl2ScvKfpjAB
 oroh12Ylz7JVvnZqZbJEUQ33P1RDxYBgwVZoQ2nv8/6Q6p8LrmhrxDf9iqnc+lk6FOPccxaP23t
 GBfwzWykP7eNyuTx/gLiHFvLeBQ4gPv9+H1tIXvaWdytDde/SOWw==
X-Received: by 2002:a05:6000:608:b0:432:da3b:5941 with SMTP id
 ffacd0b85a97d-435b1594265mr2311081f8f.21.1769142602766; 
 Thu, 22 Jan 2026 20:30:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 05/18] telemetry: check for path overflow
Date: Thu, 22 Jan 2026 20:28:03 -0800
Message-ID: <20260123042945.159075-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

