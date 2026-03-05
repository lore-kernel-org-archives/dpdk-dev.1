Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95097F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8E8427BB;
	Thu,  5 Mar 2026 18:53:46 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id D8109427B1
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:42 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-89a0d53f3d1so34793346d6.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733222;
 x=1773338022; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=TLolS+JKo+PbN8PjY1w0ljCXo6QB0fd9EA9XB77euCmV1mDR1oBd20AFFc2cB8EZoD
 GIhmL6snj3c+3MfrFtgqPTwdkcnGi0utj+gtTFQNskTMpwfPij/w6Jyw6nmgrGorADSl
 EzjqKijm9eLhgwMUBztrYE/5TlFzyufPk3r0sCVB0POtAnZB1XDSM8VaOZFW3tS0p3Ce
 o6fjAId009Wf0GJz9lcQswulLRbpwa9uOnKgRsaqgoESZKkVhVmnBpZfQQTUxK8N2tNn
 91PLHo86R7qMIJz0NuOsLvNZ0KaJ10odyC3TxSzQK3KbM+2jBG8z7W+xymm1mjPjjdTE
 jNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733222; x=1773338022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPDgFzJYDqwMcCrvGrJosG0xPHafkoqdKGF5sqPVQJI=;
 b=jlMDM8OeQJWGdk9+c9b3FionEgHHza+Szwm1KzwcPKIVDu8GcO5kuilB93gTI7A0nx
 2hgcUe06/T1XBGA3rdJ31i1AZZW7Rvvh60akelKxGrAROQn2n2dqgWqKd2qL92g5vayz
 v/9HGXcKLuj/ZvTwnVpVStQnGLt68HAmJDv9lT2gjCEzK7b3ktMs5G3UbXLBax+xcb6h
 l6tmbD9sgIAhUoq+oLCSncqoPADgLEWGQR/1nBecKYO7tj6A+5Vd9Vk7oyKOl6YW2n9F
 THmZiU8gQYx19BiLKySfXbuCsiEmZCOl4inkRXEiiorhC05jiN/F/CHLOgYLrJ21hH89
 kaZw==
X-Gm-Message-State: AOJu0Yzj/Zy7oLWgpvs1iUDl/WPayl9V/NnDRI9N/betSG8Iv7/ZqzXE
 SvLlnziqkFJo1HJIWrC6PouooQ+vmYXGlocO6fF+LYNOeDN0vhY7Zy/+7zth5Tmh95A8k9mAEJA
 bqPRM
X-Gm-Gg: ATEYQzzyHO6Topf+L3BjJJ/T54nSni8S0q2v1Y4u8Pe/KT0FZkBeCLCVfq5zjkvpqYv
 iqZJ8YrtujgrIk+vTAwWwTwnd/5ikAeKU+aaqzNrFySYmkHnHCzjhMKKFPLYYdW4/ssrMvJjLCd
 atRc46D0fgsqeL8osN1SpKecBUGzhIFdJSbMK2ii2Z5FXXCXs2A6PVB3+yT2tAg+VrrmryheaPL
 +iJhwsiESQvyDmAiOEqqaWB3egjWx9kgOaKlVcGbx671HJ6jAOG8+vsU//zLIaBhH8kVsDM7uEt
 FFn8Xxz3BLjjtebiCXf73jYsfp1f2oThthV+BO1Z1qsYkEHa3xTFIGJhkmgG3v2ggvoDoWDHKgD
 bBCWkfuzRf6HiB9xdfL2hQtYJlSnMcGYbb7FmPscSy8qdAoxXEzjOI635lR/jybIqsYG4u7mYP3
 AkFyeXk/j2pGFQ7y6uqQ4LkngfQO5FEoEOtdMyTXdCZlsd8/0ZYy83BpPq+YWMMlE2VfZfi7wb
X-Received: by 2002:a05:6214:252a:b0:89a:f92:b0a3 with SMTP id
 6a1803df08f44-89a1997bbf1mr96139186d6.1.1772733222035; 
 Thu, 05 Mar 2026 09:53:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 10/11] test/bpf: fix unsupported BPF instructions in ELF
 load test
Date: Thu,  5 Mar 2026 09:51:04 -0800
Message-ID: <20260305175326.279891-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

