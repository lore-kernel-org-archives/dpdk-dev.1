Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390DCC79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E9242E54;
	Sat,  5 Sep 2026 00:10:15 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3276942E54
 for <dev@dpdk.org>; Sat,  5 Sep 2026 00:10:14 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-85339ed040aso1264572b3a.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788559813;
 x=1789164613; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=OW+kMKvcXkRDUil/66D0rp66+LKQIr5H84ASlex/IlW10/lfiEWopgzsos2RBd5THU
 OpfDW0uLDLN/ZSaOHiNTN2IeJzPiQcGAkmbcJzcnYWxp52/3Ybt4jmDC0eklaoAlBir5
 /VjkFSJLj60QE36cuplWDeDelTEF16v6lATwL0ksXXn+38RbpDIA45M24RA+IwjgxYTr
 xmRuzN2BDO+CLpiIh1txQyW+BsorAVnLX/xOHn/TPv0qIqqKLOjZesqs3wTs48uiBvg4
 wujf/6kAE2jqtrYAcD4KKu9QxEY215KGQIwXV0UXz08A0rSGfXv/tqQEpgTRYkjDTHIr
 svYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788559813; x=1789164613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=iTS7zLp7TMcZ7/ywkCO7ViIJXfODswMLCKj+Fi8r6qWOHe9PZzUeKaheNCT07O0VT2
 N28vdHbTWLs2Pq5LAj+agP6TvwOin7J+k5s3CTNXgl8tjxyk0qSHaga2AfbLaht2EY/A
 Hxo5ov8c3L1B16XpHZci3ilZtSaaMK3Oc3sQsn4JvaQYRqLXU6kV9nMezi1MD4pyi86H
 TxZ07xBPK5SMlM36aotWzHkt7QSMdTQz7lHOx7it4iHiSoigDklTOsvHFlXCu6aW6j6Y
 YOSPEbbGPWtogOt9b0Zzgk6P3NM481gqatLUPTDOvNUqQYuhwrE/SR20AeLivUQCN+xF
 IchA==
X-Gm-Message-State: AFuF++k2/o4+U+TnhOkE1nccBMjNpgZXu4K7cublRYVPERqYrcQQb8Vs
 vix80dEyOExjs3n8Kj0+AuiC1cxxxqlfXJMoBgIUtNdGoKdbREneY/hN7eWLvXF9hp4XhpwjGhX
 FgC41
X-Gm-Gg: AYBFou11ZKCWiaE0mt+gvsvUzWXPbAIV2E0xgPYFk1aA+N/GeVqyfSNXGRSLTjRS6Dk
 naOx2cwTYeVnjB3B/6Uz7XKAESaenF5OI1AIGDlVZ4XjcSvRrgJwqXvrJFIFx9mI9JfSbcoGhjO
 JbQObnLjYhqSEWqyEOjrb9HVUJGEkfbzDaYSsObiHsciXTl4pCRZBN+KDaM1r682zkU+FK4I7R0
 GMEvGbIfe1s6JPn8KP5W3aouhXJkggRjZjFsMiPKctNxuzWQMEv3GARcoQz3KiW7wuIHuwqxNCh
 RyshsEHGrprPlHTa0SrLe05Pvzk/fJPbgzpXoetitoWXNkmQtl/ciFGtk+jc9gRzbx4vzFK4SrU
 ANPVenb5yyGTYm7DLwyGueGuzrhWJGBn16Q0iu5Wj7Zg7uubm+Wr8NzFs2NRASyCN7sH4SqeqQk
 TADcLgFjLIjw2mQUflNmBNesUGoWV12LhoYIj1fTCTg6mssXMKP0twR93C/IilNnja7+uA2jw6r
 KZGFXIB8Eil344mMXV0PupY9cxm/Sv5pZwr44JlHvRp0cZjjg==
X-Received: by 2002:a05:6a00:32c4:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-861671b9567mr14321439b3a.11.1788559813146; 
 Fri, 04 Sep 2026 15:10:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86153a1c1basm1614076b3a.52.2026.09.04.15.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:10:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 3/3] arm: remove no longer used RTE_ARCH_STRICT_ALIGN
Date: Fri,  4 Sep 2026 15:09:08 -0700
Message-ID: <20260904220953.3105930-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904220953.3105930-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
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

The RTE_ARCH_STRICT_ALIGN flag is no longer used anywhere
in the DPDK tree. It is safe to drop from arm.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/arm/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 27b549a052..f1f2f3e260 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -46,7 +46,6 @@ implementer_generic = {
             'compiler_options': ['-mfpu=auto'],
             'flags': [
                 ['RTE_ARCH_ARM_NEON_MEMCPY', false],
-                ['RTE_ARCH_STRICT_ALIGN', true],
                 ['RTE_ARCH_ARMv8_AARCH32', true],
                 ['RTE_ARCH', 'armv8_aarch32'],
                 ['RTE_CACHE_LINE_SIZE', 64]
-- 
2.53.0

