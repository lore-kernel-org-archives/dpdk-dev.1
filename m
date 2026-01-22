Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6C1C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BEA540E03;
	Thu, 22 Jan 2026 01:54:21 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 4FA1340DDA
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:19 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43591b55727so308177f8f.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043259;
 x=1769648059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=EjAHS6EkXl4b+iGEJnuwH1gJHznbgm2Kdv0x4u494dc3/GJD6JFBDE0d0XX9PywAH3
 xuyhDt/3U+AXhmt2a3OW0n+qPxFMdbMLqYM5XS7MOH17AqhEi0PtMc/q6UD3n5YkoGKi
 ViBJK65je+UBrX5hwwIPhb5Bmu6nXNmbRRkZ0SiSySThG+7vXnqamQCER51KSwODSQQS
 xQtW1VO07EMao23M3+NkqkxrPFA4bs9d9ibiqOnVn4LCNZ9p1dbewBO8hiLz8RrOIJo5
 c75p+ZyMdeDF1hkYv7AG9UqZbgs920r6nNvrRjVBzK94sItSocPy4/0kWP/v/2DGg+13
 wAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043259; x=1769648059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=fxj8/tFrjmd17NPvd3cQ47nTEPh8JozUHjiAZWdx5scXu2Nz5y0dQHn8SUstB/VqGc
 u6Bq1776CKg9b7wLFvpBOtdEhgx7hddv63mVFH6k5sbhgkjDjko3WGwsw45MT1MEe5VI
 1bI2Tu40fC70MO/tMJRarXYaoAxm5nhNwQSAhFx6N8z5oX6vYOZwkvs+hpOafj6Ke4yk
 Iy2k4HIsnJY9+OMnyzGR1UtyYMu6EcA8YNrcuOA4EYUwtZPyLmLC7fVIZh1GiBAdUDKI
 0jOSPMTKLYCWMWxVjMCFp9ie3Mm0DuZyA/nrJJc4G4jKQPWkIZu6zICtdGyqR2rU9BdK
 CKiQ==
X-Gm-Message-State: AOJu0YxdxCLXwEB6CxRqNekckBgSEhJ1/cPfhPbvfAkpExfFTnHuB2CK
 EyRN2hJn+HLtxXqt4T5WDJbfKXMKTX66Rh2Vi/VwoQizI0mZGiqp7MB7OV8QZ5eEQXqUf7yoAKj
 Uo2n7
X-Gm-Gg: AZuq6aKMJjyrRyhqOZ9l1A7yCBdDJr2gM1GJhJvlnJMbWJF2U8OzJ7P+GLtSrn2B0E4
 GcGuG5W5iGR5uRY/lqvuDMfKo3vIgnD06rNlquAkt9P6zyrc/oMFxWq3Bck4UciuWwTAKV/m3HQ
 q+sqcX/nPwipk86zl1N0fpuP0yt8kPbGJq0SAPr+yMp8GIKoJfCPFanz4twmsaOuiIIhV+ntaZM
 kFnJ5L/qOr/o7LrDth3dd3eFmEwkM/6dtL2MHwGvQpogIXuHNoX4LcVVax5fUiSYbs+IfzJAMqk
 TUIT8udsp2VQx6TeFCYUFhiHDUj4XoTbuJnaxsaeYBXBpcmocfg6lsz6CR3i2++LeRkwlUSWHI2
 S4vBvtg78/Z+4g/tahBM2YmCDsQiv2z29Ky1tuMHEodPrgWhxP9em+MAA5F8JOXEUOawj8oXbgY
 zTYIqreEpgyL7E/V/euwFoLatsRLTQY+6yYMq/NNaK6zk27XNo7A==
X-Received: by 2002:a05:6000:24c2:b0:435:a815:dd81 with SMTP id
 ffacd0b85a97d-435a815e18cmr1378238f8f.11.1769043258892; 
 Wed, 21 Jan 2026 16:54:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 07/14] test/bpf: fix unsupported BPF instructions in ELF
 load test
Date: Wed, 21 Jan 2026 16:50:23 -0800
Message-ID: <20260122005356.1168221-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

The DPDK BPF library only handles the base BPF instructions.
It does not handle JMP32 which would cause the bpf_elf_load
test to fail on clang 20 or later.

Bugzilla ID: 1844
Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/bpf/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
index aaecfa7018..91c1b434f8 100644
--- a/app/test/bpf/meson.build
+++ b/app/test/bpf/meson.build
@@ -24,7 +24,8 @@ if not xxd.found()
 endif
 
 # BPF compiler flags
-bpf_cflags = [ '-O2', '-target', 'bpf', '-g', '-c']
+# At present: DPDK BPF does not support v3 or later
+bpf_cflags = [ '-O2', '-target', 'bpf', '-mcpu=v2', '-g', '-c']
 
 # Enable test in test_bpf.c
 cflags += '-DTEST_BPF_ELF_LOAD'
-- 
2.51.0

