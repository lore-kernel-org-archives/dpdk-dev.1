Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF75D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27C6D40672;
	Tue, 13 Jan 2026 21:23:55 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id AB83640A6D
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:53 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b86f3e88d4dso462605566b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335833;
 x=1768940633; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=xCtWp4fs2nGxvE+FrAMBd0HWrNJ4+GhlAOx9P7C0eU6vamWVnvuOo2oXuEZPGXK4uV
 ElVzJlhvtMZIkghHjrwIsT4ROUcuGMz7JJr+/dxxWLoKIjNOp/+UDDDKwnNLC1iXdJxq
 AykGP8UoGXzECoifBF3EbAWVhO2phOGODVvanK/FZB/pYuye70nG0AEf08SfbTNhBChb
 KInnkRx7OR/WTz9RMLoX79R1NzkSSQYH2HyJGF8k6lfQ0HCpTGPpOZ0BTGMqfmZmqs4j
 P9QHwtVYQ6c+QPFIBzw1sK5YkeSt/L/UQ4+XizPgoFEMlPUWdFDw3xZ5OJDQVICPAjue
 NzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335833; x=1768940633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=GOGV+WIxzpVrTpvRE6Wn2fSTz9geBp/XaVYpM9GWM+36id9GJ4AyDM0vXI8zwVn5um
 n7NGhCCmgGxPksVRJsHYy0E0JjrHNRZnjzv6R4ESWorfe7kYPBPlljTEIs+uhKVos2U/
 mYtfMUfRUmZdyRU5itSOBBM/cYwKF4wgLM/1nd5QeWj9Avz7YmKQGgtyGKkUrpUSXlwY
 1Jf8iiaNXF8tgWqrKVyNrRJrMfhpQr/MZuT1sFD/Wv2OWBbfqF3N5q9wX2Rev7PltNH2
 u2/Ziud77o1ttldjARZ/DQv/cmML5ZCmeuz/l1r/DK/hOmEceA5ZcTQ+knfIsWjoShxt
 KdYA==
X-Gm-Message-State: AOJu0Yx1m4EoGPjFLkE6cy7aGly+uViTbBTC83nRIsO1Xoc4E7DBv4l+
 KEavP9EtkUJ+lARn1yB17Z5Q0ywbXh/062Hyjg2j6ooE6u2/1V6Nngar2fHbMyojSJy0W92Q49e
 Ugfk8
X-Gm-Gg: AY/fxX584o/wTckAHlMmRZ4zpsBQ3u3KxsrQHQyYM0nR0kVQ67XhsktOZ/v+xW4zASE
 OnIH7Fc6+Z1WwKnZzSVEqLdhcQDJV62ga39rC39GO7PLrMH6t5W7fdI78vUZYRiFtc6fRwMvo5E
 bkABhyvI/FH2uSfYOYW5j5RRTe9CzoF/eFXXJ+v2EF58g700xlmSnP7HB+KuEGMSdG4oibO6P5m
 dqDg8kLxFt7RfUjDxbUrbLwYZhdJKCgz69aRQ9Lh6bdb7/DDHsQe+6nLb0JR1Yvr4FqUTh8iIo5
 5QxS1SXYV8I0x2MoCst4GEs/HdLn3aH+gl/9vXAVyaM/9TJafAxdX3ALlcPOZJ7PQSy6FSDQkzh
 4GpdMAXHjdmVRUPeSqOTO9i2C5NNN0GdkZ7E60gpvhZ9wSsG3EyO1xuGqVu+s7oh0YiA/SOVxWl
 0gbDW2O+E8cwAipaexTVN0wJn8ruDLTJ0l+9Zhg7Eu14OA5Rcl299lmDfWXG39
X-Received: by 2002:a17:907:6e8d:b0:b87:965:906d with SMTP id
 a640c23a62f3a-b87612d9930mr28206666b.47.1768335833293; 
 Tue, 13 Jan 2026 12:23:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 10/18] eal: add check for sysfs path overflow
Date: Tue, 13 Jan 2026 12:21:49 -0800
Message-ID: <20260113202329.35190-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

