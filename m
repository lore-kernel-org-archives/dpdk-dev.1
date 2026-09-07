Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C7C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 516CE40B9C;
	Mon,  7 Sep 2026 20:33:32 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3EC7640DFB
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:33:31 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d9520b9155so31704845ad.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788806010;
 x=1789410810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=pn+iTM9jhg2rNr6HbeOpKVl7M0a3PxdnbWlJf9G0ttDqfONSs5pxHI13xhWbHF9hCG
 SPJGbn+3adq/Peg5/1finD+FmQWBQuyJfKdPzV8zbuiAHheLQBpkVMJVFYmYw+mIQmKQ
 S8RNIkV1FZV+zBPyFO7dPkQ7EHO/7nRwK9amsz1lCpLpzLgTtMw3LTLOqB6JfipEzhAs
 DA8JjF4pIUO4x3qNk7Vt9jN/JHbMoODXY3u+b45K864kHt03LmWoACrYnJ8dthzPYzkC
 scAy77B/Joc3MAifW0PbGUcQ7E8kFzwQkWoYX/ehNuNVTHAFMQ1jWDJOvBVvps8d+bkZ
 rauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788806010; x=1789410810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xzVQ4q2hir+dKmNmzTggxd11kiPoW3u1hStqGDsnlbY=;
 b=dKnEmxnVmxuXnP4U7udyAVubLRPCGILUv+NcxZKgNNlrEkKGUyFOAaa+DEUNzBeTuG
 gw9z1WYmOvn6Vf+Y+PKSaJ99WHxQa1SeJt91YkmWXRWMz1IurkguJveCcb0eW193tu2q
 baWvY8n5JmU1WwaBS/gHiwFz6kR/vjcccHTQsfpOXkQohiW9scG/dZ8I/Ik2whUbng/J
 d9dtNntiH9ETaDmJ8DQ3EZjGPjKJ19nzdUKe8ILWW+O4QRilhhHmMaBTIfefM9fMOdlG
 xcvgVlNILyYompWz3mHAkJRmMfCtzTR5+5938nXvoqioOGRQX4r0yMhVuoEpUjLwYkBf
 tiVg==
X-Gm-Message-State: AFuF++n2a2NJdyWHI2tH0fWETvKUZafJV806VTPvrAJwKTm8pkjrQy8b
 PelWG8u4+dRNOeY6kRF10tx/C5ZXdkKsEzXuQifkmxY4B1B7D/naCaoYQstHyXuaLZQ39GEcVPV
 o88Xm
X-Gm-Gg: AYBFou3rsHqhnsSlGOLO8psFtrwHKzWbKm7XAz/HEbMFlUdNf6RlX47L80ck1Xb939X
 sIU6TyRuJ2FYD2Ce+PiGsvwmJZ/R1hEcxdoTnG9suLsPcKjl7hqpScfINMZy3NwO0y03I6EXPCu
 cS+ULyk/WZpdnFvEB75isQeUrcxByqbfmj6f2x/0UctHbp7JXu6bceJrjJkZZspV2WGY3BDwmn+
 YtNO/Bad5htgc3BdQnlDWOkALEzIiz9L6HHG9kWws5GtrS5CuUMDToYmF+hVtXfqSLo+COs6CLL
 suiXprxeWsar65/Af2GhlyQDuyw8cMliNYEPjLZ0l20K7dpN/rlM10dQDoFEKEB5GePWfQc+2jp
 rkUwDWg216c70ZCh8/ipbqFIbEotrqHt1ZG2/rrwBsKCmQZtjSMFdrMXHF/+h3J9PKpLtGVCL1y
 sTgYgA2sm4Imdu9f8vgbBYaF+9naQeMzddS8EsqiOnc16uTizkE/vC+8BvNfDdMPgu7VB8YwgUX
 tb9ioWwHq1CEoZnlQyZVKexajQ=
X-Received: by 2002:a17:903:468d:b0:2d9:56d8:75f with SMTP id
 d9443c01a7336-2db1266772dmr389696865ad.9.1788806010329; 
 Mon, 07 Sep 2026 11:33:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm47590795ad.17.2026.09.07.11.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:33:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 5/5] arm: remove no longer used RTE_ARCH_STRICT_ALIGN
Date: Mon,  7 Sep 2026 11:31:24 -0700
Message-ID: <20260907183239.629053-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907183239.629053-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
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

