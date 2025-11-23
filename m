Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E73ECFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B1024065B;
	Sun, 23 Nov 2025 18:45:29 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id C9D36402E1
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:13 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso44003405ad.3
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919913;
 x=1764524713; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=pZ0ng7637UynECwQB7B5r0z6ZbGoH8sKanVNCHYK1+jGzzC1NFBK2NlUkwnvae3/Ho
 orlI0Ckb54AwlL1p1Vsc5ouZ+ChdD4h9JpZZJIetvmvWm6Uw3P1aqRZa96b0mDGJ5xgU
 aP3wxv1+4D9v9dKyH4Rj5CBL+TEYL8un7cenYDjOWpM3JITGz3AyvsSGdUyg5y55DkLt
 0g0ATUu5+8bNW503oJzNNxnh+2dt+V1rBDXTwm0Sr3DxAvKHAagRaorUWKTDrKrgz9G5
 +rRh5YUBLAl82i7SIINdlp/aco5sd6qq8+FpOupNb/ILSG2XWqYn06ZGOM8vWT2dT3BR
 0ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919913; x=1764524713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=p4VSzDp0NENvbcMsAVifKcJ+Bi5FZRmV7A27n16afZssE8F7m42NrsyGnY/yASVUaI
 i3ZK1zPXxdc2Vh5topU9o7j7eghaZDg7fSaU5+OzBJ4kYjQBv0yK0g19WB5quzp1kqZf
 L4JVz44bLH9qY+JZveJ0qhVM+x0ClulNYkIotFOBVL7apaXOMwI1ZnPhfnkEztvj2FpR
 T/y8MtYTsWamT1qMgjV3TIXY22jntfqw5KP40QVPPomUfXM3Ovr1n4zxoYzD7dtbIFQH
 0Qh4cYwJvhxlaVkj7UTipQumpxL3OCDS9yIPuQnxGxZspjnOz+yjraOS7bEos2/wU4bY
 9mkQ==
X-Gm-Message-State: AOJu0Yy619i7hzFOmDaoVRtkYSgqXHhbrAlgNFKnbtkerYPb/grGiKW9
 wzq7l8ZF+JScPXhrqQukfrINZQYpErmD1yJXG1O8HD6YIbK8hwhg3kfAMaWZWkBSKXcgyo3qEdk
 m1CmT
X-Gm-Gg: ASbGncstDLIOcQVUuT6kXnavMCwf/c1CRU6v/pdsdoXQKCvGTU0l6k6N5WvP7R2xp65
 6CLQXvtVWcyI4hUC4AW+6RKmDbeIDP8zB4X9OI/wLTT8FlIrEsGqCIK8r59LHHGr6VquFRQH3Ql
 kRx/Mk3A60lyqchEy+4V3++wtO2cM/1ADHJXJZVGqDIDVE03leKbqZgblKU7FfyQz0tFdUKsl7a
 xpcKiDxm0u8vF/NEkTfwrvkca+jImq4hIKIXjBWf8TtAnm4JHPTgKEefF4nW0JA6+icgTRDAiP4
 EAyCx3i1Xu0v+tSw23LP0KHWzuILZkztzMmBz/KlT9igm5y9dS17S8yPXJwvGswLRTLIwBDfu72
 fN5fxt0X2pVklHrgS/jGGL9aRHxB6NVnn90vU7oYz7ms1XTnKX8Em3gWkS3u55dBHxyA3rZLzIR
 PykS2OCKCnxfMueBtfS4IMozmzTQ7dJkHsG7oAEPFm9b1h0pQeqg==
X-Google-Smtp-Source: AGHT+IHNXPo1eV0IP1nqtMBxURfQKBH6FI7z+kbsnc/4niltKQuHmhyrS/UCpkZE5aO9ZRX2IDWECw==
X-Received: by 2002:a17:903:458d:b0:298:616a:ba93 with SMTP id
 d9443c01a7336-29b6c3db802mr76001135ad.9.1763919912999; 
 Sun, 23 Nov 2025 09:45:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 9/9] test: re-enable format-truncation warnings
Date: Sun, 23 Nov 2025 09:43:32 -0800
Message-ID: <20251123174503.20880-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..b00260c0e9 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

