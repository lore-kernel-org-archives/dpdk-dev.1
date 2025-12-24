Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6FE78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AABF04065A;
	Wed, 24 Dec 2025 23:13:24 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 177B840150
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:24 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so41300815e9.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614404;
 x=1767219204; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=Td874TDSHF8T0nc2eH5lMAWANFt/4VZeJHA9HT8P6upCwnNSw7wXPoStkq7wE87CPi
 hTHZfsV4GsO6+jWX5HdNSZ6454ERezDq7Pb0IQLgwZfvmfHUT35a8BOA9XAeYjJ9TPvq
 JKy3FH3BQGbIWZpVdhU9Hh5m4pDwEur6hzIwkJLpbyMILccxjYcGtS49scfUe703xear
 W5byyc4zIWEjxdqs3w4XO4wi6g6SvYm0qyw9oTwRHm2LlHXuyNsHRGyELP3s6mFAKpiQ
 o4T3Ody4CWUG/KdNi2beqHiI3OtSqwm6EHxX4i7RPs0iZMtcSTmiEDzj9q+EfrrnGRqz
 ZJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614404; x=1767219204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=kNU4ce0GAQjwa23JhQQ4M0thJGllc0EIeI5wiJ+sPX4t2/1rr+0hzstmrIYaF9YlYl
 nJx/4zVTZXMqldjnagl2YwtMdn7F6rQnsqxXRdxoBoDc4Cntz/bHaNQvYbqsZrIyKAwH
 eAHh1JrdQHYnT0vn3tiCmjGRKeI+AZHJa3F/ENu1IIuIk/BjqCGTOwsLvQVIkl3hNvAO
 tl9xZQtAXuWOVxFNPSGYvzHYfD21Avnn5b/k7FQ3OZa9OdpF4fSZMBw0dSpXB5dnDrW5
 vEa204sqi5lAZf5Y+DmJcQv5+hAuB1TL5ytZSK6IdKw93BV/CsFSW0qsX3XJfEPK8L5p
 r6OQ==
X-Gm-Message-State: AOJu0YzLrGgVYTC5oLekIYApIYOJIobSPa04I9ZMaEd51uchZckXyBJ5
 C8BBO2hrsQMElY3079BtPGfIkp5MCd8sbjd4VPYqHAZpuP6UJQz/aqFqVsbFYMJYJMZuedNL7Oa
 +G69+l3E=
X-Gm-Gg: AY/fxX4YfM7F3MqKN+dzyMUdbAt6MJLAXewTi+iarcpmcxsYtL4imDxzu5wlfOC2OX4
 05/ce+onsYwPSgpcGvx1yMPVeAQ00/6A7VViA7Jffdj+t3A2oG/i4dVf7yBAV8uT1Qe/KVuMnXc
 24onmRZtP6MN4YAbDrnPSVoClJ/E0OhX2c6ASPZKrh/CmyUFkrM7UG5N79huQCbnwGd7ekouHnO
 ctVrhq1ztS5ZYUPafreXeSTLc1+jeysMJP3g/QHDEXP3HcKdbAzJeZbt3Ikm99v+DtfVNEaiYnY
 FOtO7H06ZmZmUO2072pz23nXTuneLT+f2rc3nwBV6ZMby/rG2KLU0Xf7wSH+g+wBDMQD5rLnL41
 NiNvfkA402fy4ixI5K0Gk6mgnaJ7DMevYPMc1I3MMT48wXllFxR5gWbZ43d2yInmddG7msNA/5P
 r/CaiSMATtdTAR97gOjSUZMMtM3cKnI6lM50agbVs7SccplCV+ZQ==
X-Google-Smtp-Source: AGHT+IHGV7Bf9Zlw9QwuEdK46AkkQ2ldgGX6Q6siJU8xzj8PysVrUxBQql+/v4F3+jbkbVqryqH5Qg==
X-Received: by 2002:a05:600c:8588:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-47d19975bb7mr157190925e9.30.1766614403717; 
 Wed, 24 Dec 2025 14:13:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 05/18] telemetry: check for path overflow
Date: Wed, 24 Dec 2025 14:11:46 -0800
Message-ID: <20251224221301.52714-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

