Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1420C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 18:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 843C040BA6;
	Mon,  7 Sep 2026 20:33:23 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2E27640BA3
 for <dev@dpdk.org>; Mon,  7 Sep 2026 20:33:22 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d560775ca2so25384755ad.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788806001;
 x=1789410801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=jNAdLN6iWSyNNXdSvDbRf8hpKbmGyxaplxPlQ77muYOtIH5nf/iGezOcqj4cLspi4t
 AXxmvPirUX9pOO8XqprMlJZUw2P1ZtjWjIToTHuh+81km31VmycqViXoQBRWxT2ocel8
 WOD2x/rP+Xbfrci+7O/9X/PnGMfrjLB+enTu820xOWP6qiChdHv1vX7psW6hPNJkMs/H
 O5n8LLS3IKZzqMKmNPooe9SOIvzSgPIVaGSQPklS67Xmucq3N3LGNvlv7xrhH1C7WJV/
 TDTgIKDNa6PRHNRgu691l8rypuIktCve42+A6V8X2T0Du/BgaEY4kuVvtBWAu3wJolK7
 0Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788806001; x=1789410801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=b3UwQv+U5UPWAkt22Hhca7v7dpbCeW6T+lwfOCQ+4TkPA8P/UzuQ7Q2NzkewnyKS9j
 7eiAH0ZhnY6GW7HzLI5jWYAyslgyvl0aVdppiZyh6vHOY076mV64yShoiigNk/pv4vp/
 pdeg2gmoGdtD5+3QF/Pge0iNbOwmo0eO4iqgdFktiQLdRXpaLuavQCJKKxf3E4mZGCuK
 L+PijKvzRO9Z1qkeuL6VT9CE3dwYrC8D0jrrCgBwE0hgoQPzyB2IucYi0rE+IRjMDMDU
 wYZcxTDRzIHNmj1R78FFeDv80pECYM9/swcCEG9Pj+eFMsRL9KGAQ52PJ1xUNyjPozD4
 mA+g==
X-Gm-Message-State: AFuF++m+559iON5wr1yqgubkG1JFoZ/Y2xgv8OtaE5YenoMK2BZQDbdx
 Rz8p84qsvGEOinZDXiwx+EAHKq72Hq2QPvLyuVRfezs+GpsKYK2L88ODdj+rFh3NOqPQYF1kj4W
 t6JCS
X-Gm-Gg: AYBFou2r/NpK25Or9MW9QQh0/VhxjCggX65Hm+4VDWPlycXcrKJWaFU5bUswBNrIslq
 YjopI9SwYjiB7rwO6JAxWjrsL6Z5aPsggqQ+fBlxT+V1WBKCIFgnEHpeiQpgFVIyaXlJyPLltx2
 WsifMEt4pqrk3onP1XKUDs6vs5Z/UCK6pfn48QtDuDjAj9Msn+iMRHIiLlyj9z2679Ina+kGLx4
 c0yMsHA/na+pOp8VmaDRqNMDxAhIdUfr40NufFGYezwSM389lLEljoygpCBz+5m6kkOYHWAUntU
 gSjFowWmUiqYQm0OLn1lmVJXcsr6kn7NE2ZxbEJqLygwDRLx9qCNw52PUncSenU1CQ42M5k1Ik0
 En/cnIENtfhlv4MhJtLtCYJaoYNCaZkRAmBw6DLnYpj9SQepmKZCgbPI6mXqorfMzxd8Q0VM04L
 ciG8AdDO95pv9RX/tMxCVi8TuuQzTjiM9JVwP2s1Zwr3M1RholYAG6RosFjVkTToAPL/woCbTXF
 EdE2HfIkcod08STlHaKdVqWLvjUvlt3fp8iZQ==
X-Received: by 2002:a17:902:cecd:b0:2d8:d4d3:3fbb with SMTP id
 d9443c01a7336-2db126259a5mr279094815ad.15.1788806001280; 
 Mon, 07 Sep 2026 11:33:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0c0sm47590795ad.17.2026.09.07.11.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:33:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 4/5] net/mlx5: drop unnecessary STRICT_ALIGN
Date: Mon,  7 Sep 2026 11:31:23 -0700
Message-ID: <20260907183239.629053-5-stephen@networkplumber.org>
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

The transmit inline copy splits the 8 byte case into two 32 bit
moves when RTE_ARCH_STRICT_ALIGN is set. Only armv8 aarch32 ever
set that flag, and ARMv8 does unaligned access in hardware, so the
split gains nothing. Use a single 64 bit move.

The destination is inline_data, at offset 4 of a 16 byte aligned
dseg, so the 8 byte store is always misaligned. Write it through
the unaligned type; a plain uint64_t store there is undefined
behaviour and is reported by UBSAN.

The debug assertion on the inline data offset goes away with the
strict alignment path since the wider move has no such requirement.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5_tx.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 682dc07718..69a18f8a49 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -1437,19 +1437,9 @@ mlx5_tx_dseg_iptr(struct mlx5_txq_data *__rte_restrict txq,
 	dst = (uintptr_t)&dseg->inline_data[0];
 	src = (uintptr_t)buf;
 	if (len & 0x08) {
-#ifdef RTE_ARCH_STRICT_ALIGN
-		MLX5_ASSERT(dst == RTE_PTR_ALIGN(dst, sizeof(uint32_t)));
-		*(uint32_t *)dst = *(unaligned_uint32_t *)src;
-		dst += sizeof(uint32_t);
-		src += sizeof(uint32_t);
-		*(uint32_t *)dst = *(unaligned_uint32_t *)src;
-		dst += sizeof(uint32_t);
-		src += sizeof(uint32_t);
-#else
-		*(uint64_t *)dst = *(unaligned_uint64_t *)src;
+		*(unaligned_uint64_t *)dst = *(unaligned_uint64_t *)src;
 		dst += sizeof(uint64_t);
 		src += sizeof(uint64_t);
-#endif
 	}
 	if (len & 0x04) {
 		*(uint32_t *)dst = *(unaligned_uint32_t *)src;
-- 
2.53.0

