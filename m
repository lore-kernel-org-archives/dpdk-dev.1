Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD667D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B8B40665;
	Fri, 23 Jan 2026 05:30:16 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 4B97840649
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:14 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso13783425e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142614;
 x=1769747414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=xFHfr1l+qDdJ+udB1lvCIDcP9b/GqYLOP62U6Vx04vu1cwaPVJLre4bXXQkdCr6fkH
 5RO+kIpq1FZUdsrvzv2zQiv929fpD6Aub9vfMsv4SaRok3N4ZiIEnq9dWVMCX0daf/hy
 Ocths1xltU110aBy46RzT72dYnD/YvB9cJjgW4aC8mLrTzlPmJOVojNOXTH8BHl4+BgM
 6FNYR84jzTejuFTZdV/AK+9pEPGcCpXTYQjzpYVClIoruzLexbtXO3FxcEfiZsvKWvXl
 b2VxkFITConblAVCoduGWJ0s4vagrf7R7nGlMZ34P8h6D6QAQBnZ8KEZ0j4w0/O7VPK1
 smvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142614; x=1769747414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=SwAB7FL4RLT+mfiRK8wIzRZe+K/641IiToAog9J1VjBH/eaJu7XuPwYyBhsNaQ9MhB
 rGI0Ou/J1T14hu1JUBOpfrRkKig2p1ja8f5HcPflU18x2YX8CXb/VEzeyjdnwGM2PuwN
 nCXZ6GMDllLYc7oZeFNf+CgtSg1drxQw3VDhUi88G4w1XD+tCxyXyCQg/tu6UpQZdAjl
 YwW7qZ3OTPA79NeAGZ6yT3U/q+jZ+vD/LLo0vK0I6Ox/7jAzUjJllBjWwRBlNO5P9Pen
 mQECQ3Ihac6Le8BeYxFD/UMM6aZFGdEwUPw72zgXKZaZaesqP79nB0n4D7suwBK3CFyH
 IDtA==
X-Gm-Message-State: AOJu0YzpP4RyJMtkcp92YHysms8HJTmQd2xdL4Wg4pLE1hH/tQVWdfS8
 5j6iXqrrq5ZnB12AHLVS/GuUu+2UlSiD+U2mbnKpK64wcDL0U5ydcJMiqQ3tpj38wm2jdbLxhai
 8xA0r
X-Gm-Gg: AZuq6aIzcmrppPWjEfxzIWKgW3V+6RjheSXI1grvwkwT2+G53vytYM8wa6tBoEmsNDo
 NWf1XDIJ3RGJtl29ft7v7tr/VBO0L/WmYlgR7EL11DcnizabEuRB9yT5q4AiHj2TWd5Yi4o/Gkk
 q5dCp82ZEil+FxVScSOix0+lWFtWWjZoBKkGTFul2k48SYCg7qJXyXKwk2gZzeN5fO3pcESA+N8
 /i0vH3ql4/jIXlIfQxpN5h0la6CuDpEkkSuIJV0p9sO9QiCRdjkgKkC44a2i3YQOWlOSZUGJnkw
 O3msDhq+1TQuBru3miqpbGhdtNxyNP+sbgo62FQBVOEFx39VLnoe0HSIMWRvs+NCukB2SUScb07
 3yTdK3AQaTJCy5sYRCZJQfZKlEaVU2MMR9yRcwK/8p2xfNx0zrV8xvQ05vyGyEA2V4KDC8yOqzU
 nbHdMfiMcjOWJlqhzFWt5OkKN1dtn+7es1OBHpBRfKL2HArmkO0g==
X-Received: by 2002:a05:600c:3f12:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-4804d2ed089mr24624105e9.12.1769142613875; 
 Thu, 22 Jan 2026 20:30:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 10/18] eal: add check for sysfs path overflow
Date: Thu, 22 Jan 2026 20:28:08 -0800
Message-ID: <20260123042945.159075-11-stephen@networkplumber.org>
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

