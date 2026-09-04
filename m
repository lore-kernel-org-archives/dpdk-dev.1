Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C88EC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4793427D1;
	Sat,  5 Sep 2026 00:10:11 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6FFD14028F
 for <dev@dpdk.org>; Sat,  5 Sep 2026 00:10:10 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8558c0b26a8so1024261b3a.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788559809;
 x=1789164609; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=P95rVfIFj4YxIbmU+IS8Xnrupk39cpEHOT+guJDJfAZEoL5qkoV7dkLjDmCqXA/bBL
 g2078dXNtOsUein2fv0NtizNHzyAhtRKVCun1fH2cgmVZGT2w7Zzjk8SAlO0l++Qnmz4
 Xe59HhypY4WnxNFDXd1MaBi9NDIKWYrWYFGpmeah0NH1lwofkyt2Md6M9gimNHpGN4DF
 oWT8J+cNqFdjx5jyK/QoIBbth+c40yVHom1my174Y21+cD0K1FZ311nrzbd0rv8rDyPm
 hkNdCuVZb1Sgq4uCtjwDrVGUKn0aOL5133vpHLodiB5rhAgqjE1hRRtnrhfsXToCv0pF
 kX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788559809; x=1789164609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=tUNb6BHpNt7lQHQPNAmZH7S7dLOEWoZVbUcbfGE505RRpt77L2CepB87MLR0mBueCa
 gvY4Dqv01ka8Cb+/Kb+L4HtbBdFW1DhJeiTQOPqvpntiHpZls06drj34tgTSlo7T2ZiS
 Ab1lnqh3fgYycie3LhDvQdQBtMtFOYOBnS4DNYwpL0EC+sRE5zp+MC1xXbsFONDNHm6h
 3BxF0ry1Fm68hdXF9OXzbRPnQ3AKduiz+KC0a9jVmx9W9WPO2hT7PE3vIl/QqEILmKfv
 QmDPd8nRg0dGzghzQX4v2pdEjHBZh30+oQdQqQ5g7D9mgFqIL9/RmXk/HhgkB2MR2E+e
 5JXw==
X-Gm-Message-State: AFuF++nOIeeJPDseyuI5pPLVUZyT38C2fmVbDYHrEhIuPimiyW4ACjiG
 TRKz6zd1maGKY3M6/9H+5XWTldFJKZCHKJrD2t2+1goDtZFq0rNHRmujcItdrIfLH7114cvFIhd
 yD1SO
X-Gm-Gg: AYBFou1TtLxT2UzMXwAmfPll+0oDYrS+DFIqO1pf36QMyPrzWyDZvNWY35r4YoONLig
 d/esrcwjHzPNkOSwivdoao+Fu9jAScdaX1GJidcCuGX4t+GM25d3g5lTMnqHMCG+HJANcVqH3wx
 3ZmkX6kQQ0D+23u+ISUNSa0Xno3vtMLgs2Caibdq6UPIfLt4ENvlXrHVKxzYT3hhTHlIWqRTfhv
 eBDY9LGk21k+x9NoHCHtP77uKrSOHWWThuw3PrFgMBz6mD2e3kew6COgn7aAwiEqa2E7D2dJCcH
 Z827ZTu/B8toftB6fy8bwL3XsFj7RFuZWp+BIbZw1qJaKW/OgdImcN0p/3n3xjWju/rWKxSfaIe
 ph9PfE8lifCcGzZkDem3aqkfj4s6jV+149krtuY6x0ebBN2i9i4pDye7X4UwubXmkmCMiQpMB8J
 +pSQe5VNE3X+Bqb5rGjxOizwEvSdNHAm7q5QOdQZRRAvNDF6W4nnOm/zDAedfQWgz+C6ufWHmuj
 U4on896wZ4O/voEI2wPFIrx12g=
X-Received: by 2002:a05:6a00:2c94:b0:857:727c:a1f2 with SMTP id
 d2e1a72fcca58-8616907f6e9mr12325104b3a.20.1788559809179; 
 Fri, 04 Sep 2026 15:10:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86153a1c1basm1614076b3a.52.2026.09.04.15.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:10:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [RFC 2/3] net/mlx5: drop unnecessary STRICT_ALIGN
Date: Fri,  4 Sep 2026 15:09:07 -0700
Message-ID: <20260904220953.3105930-3-stephen@networkplumber.org>
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

