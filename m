Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26194C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF9F402E9;
	Sun,  6 Sep 2026 19:12:25 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id DC8064026D
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:12:23 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8541875f596so864314b3a.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714743;
 x=1789319543; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=Nv3JfYzSED0mJOQNIIM4InOI4qhmFTqfrRGv4FB7133uC25hmptjUyL5jNJ+dHGibN
 DbfFXgfhfijh+THn/Ow6InyXNRqiWFTMl2NvAuxLORPib0/8y0cnTqozbB4m1Vx2m+rx
 SvSmMqrxO3p35J36zdMyUkrF5QOqzD9O/9yygCVMOFkM7b/a8J84Ag74ldRtqXJnxsjq
 wnaU3/o25+N1A9bPF8gmEbrej/tbT+SV1otqcTVDydoBbtT9mNp0goGo6UZtGl//VXYc
 mUtt0mGYDGvpyYRLvkrsxy9k1JP5rwkI1aNtVSkkmE5x3L1OsJhzKZuVaKxwJZL1hUcB
 pQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714743; x=1789319543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IeIUDNLneLA7r7aB1Dv7bZ/B/W4m+WFYQHzG7zb5lqE=;
 b=UmZ0+H7DS3jBHfYYHlP0ZKFYW35DJ6URHo81Jidq8Nc0FcmfEt68ZYOW8TbSJimhL8
 9JhkkTbLiqpIlCdJU69aO/s77FieSlqtAp40BLGu4MZfDTHwSxGM1zd4Y2OPLIeSbg4y
 4NKWeXlgxvJ+KdRUA21baVKp+1qHX0h/MEoMUEoq+j2pEC3KydG1zT2nC7e16uMZIczn
 scgUgJBOIqC6HUYnbyah/0ySIMIPyaTIq3CBpdxC4gPnpsU236HAWs60zWUBJP1Ch+Qe
 7pKDFWjGlwzTe3qaKk2gyKcRUIPncJd81pmk1SskTVfMChwaFq3QLfNayZtf2AprEzGZ
 L7Lw==
X-Gm-Message-State: AFuF++kGXcVEpAVYAXvb7TSmxVHzU+XMWepVDOrar9xwxH1C4CCbViFQ
 WPV3nSVVjbMwwFmM3fMYyq9AUB1TAK4zICMbqnVcT5HRvjIrgoI5F0qyIx8oroQWpT50lPFw5J5
 TH1Jg
X-Gm-Gg: AYBFou1n5NW/xUwRI33zL41HShm54O4xvHZEtldAut32BlPZU0MkGMUHhE4VWVDGnN1
 +kqzrNFchPxwA625PYOu+HgGRu+C+dq1Fqhm3sPssSaVIiwcekv6seB5cdlRM7fifkRENXS9Kzr
 yXuziaFoNmoNi72O2UvbahS7RkttoG6X7xVgYRn7DtX+2/jTXbVa3Yj5yxOa9hcf/zx0tp3UmFs
 Tb8nCjxs9Omt13K9wbVVoiSesxeJkBIYJ5vZwSMtllhVXgSl6tv9Evg12txK6149q4nYpWTumbD
 GuCBh2qeGFYSvh4pxXW8/bo3z16EKT1Z1Bh867KvvqX1QPiCmYDlZJBJxd6DXzto6IRV4uCNeVp
 GPEyC6kAxpcnArnuDl9P8Cd3j5nCUqT0LXlhREEUya2iFc4CCMXmzrHQEcBVvJEYzR1M4Nf9e6R
 9NyblYpkLDqfqmOTnJZNrZaMEr6HQnR0jBymfSAlUXw8Z/nyH/LkJHv4V7E5QYAgBXSqpjtOCEh
 4D+G8oqOLsbFaur6HpRUvT9dDM=
X-Received: by 2002:a05:6a00:4c15:b0:848:46a0:3d74 with SMTP id
 d2e1a72fcca58-86169b6b588mr22665871b3a.9.1788714743038; 
 Sun, 06 Sep 2026 10:12:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:12:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 4/5] net/mlx5: drop unnecessary STRICT_ALIGN
Date: Sun,  6 Sep 2026 10:09:57 -0700
Message-ID: <20260906171142.3503868-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
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

