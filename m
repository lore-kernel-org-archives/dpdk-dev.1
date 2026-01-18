Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C8C98315
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22014161A;
	Sun, 18 Jan 2026 21:12:39 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id ECD28410EA
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:37 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so23391965e9.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767157;
 x=1769371957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkvlONWZqGg9W828oSRDhy894soHW6n6vuYROclMTww=;
 b=JFWWefVa5cwsq5KlcMWTFz0f2QqVRZ9ql6iLHrKFdgoQcoW2WqmLcyCcjKL1itnBe2
 h8M4DXdDuio9BPBIFq/gCIuhIGqDrUwaY2B5Ud2Cl/sShUd0E/ia+M9kXDc5TcGgNx2Z
 Di+T/sSlpN0CEtVqEXBLa53uQufmMoy3xyVrirL572wxcpLPlqKZNL5mbTKYHByyPyxg
 FZfs3VA+fzuWn3BJ9P147J8cQ5HLCe7Vt0IpVkLfKHqmCtz+Z3k07NjAZnkwXIei+vpp
 Hvt1eNHxNxOzvMUfminfG2V9EdbV3IWP8HbAw3ykZtRKowk+kM6xsNz3I5BqrIEUfVmy
 Vysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767157; x=1769371957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OkvlONWZqGg9W828oSRDhy894soHW6n6vuYROclMTww=;
 b=ltttRCVlpmNfCFka5EZ9GzPzzm2dFAuVgM8Y5qztVZWbMAMVsEs7xDEHli4/tIDGkL
 m7Gd52u5Orx4Tf8aJaEV1C4i9la1rHdIdRvJuuqGJmgeBqP+9eAq9PQcUIRhh8q9OKxH
 UeriVD9W7veYC2UK3flCI8sv7u6HFj6i3QItgZGztoE0rGQu8G58j937bMBk7+HdcTQf
 VrEYUemknWT7ZQNjz3MiqI7t16bxABUc0FEV5uITpyaA1dnXJZVt5olJ+C/3uE1x5tAG
 73UfezN3Yp1h/+dO5k/m+vZ4G5Va31BFwu/QtVXxYxl/FGpDNfC93TiJfTHb0xTc9iTV
 06Jg==
X-Gm-Message-State: AOJu0YwCQWOLdEdeXFNK7iXDBYEUWMSLJVKamSFQtqenTW5bFIpzXA4p
 LSvz02hUVIdLODlNr0fJSpo2AXQIXMiMBiGWhoPaoWCqwRcLzUfzP0/dJSAEWvtlbmDecFXuKJ5
 LgsjO
X-Gm-Gg: AY/fxX6ZXq25YgZ7AIuMmaR6VdO4LBXuqw57zb2rBD40+EYayTP7mJQt3U6qFOWPj0k
 x3W6Ton5cP6d+OcKmq4HfQzw6kzJ1e+rDUydkxPP8doqs0ctxubpxLa132170+AWAIB+FR/mJaX
 5r9HpnzU3dVkYLgGaDnex0aLQvpjyq7fpt5U7UQZ65w0+SQJKLCxX68Gko39qhsg2vgj/WmyGWF
 jWh+q7ZAj+8w6vXjkQpwtEv9dOgBXl94hGRjNw40sFEu8BoiyqBnmH/JA8ridMz9eH8fctA6jla
 dIyfDVCqUoij5BSeYj8yLL4yQEvJPS2KCshfldqCirU7+ngpgq4ejtVZyVkOGoXE8Pm1ZTtsAz2
 nJEaQAcdIOkXjGFzloYTzBmX9P4ypl0ZGvt/KkdyuAkKPxiU2XqP6MffwlkQ7WEeOZkXzrrkNmy
 s52nJMYzbQUzu0I3E7rjTCWzyEW8V7u7Ryf9yw8FMIt+c65ThPsguQmOT7tv1y
X-Received: by 2002:a05:600d:644e:10b0:47f:1a8d:4f30 with SMTP id
 5b1f17b1804b1-4801eb0efbdmr87674525e9.26.1768767157536; 
 Sun, 18 Jan 2026 12:12:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 4/6] test: fix unsupported BPF instructions in elf load test
Date: Sun, 18 Jan 2026 12:09:11 -0800
Message-ID: <20260118201223.323024-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

