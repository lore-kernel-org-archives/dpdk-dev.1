Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF1CCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 18:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 012F840658;
	Tue, 26 May 2026 20:12:16 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 22E9140663
 for <dev@dpdk.org>; Tue, 26 May 2026 20:12:14 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so5203490b3a.3
 for <dev@dpdk.org>; Tue, 26 May 2026 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779819133; x=1780423933; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crqdIrMci6pxzK9BQ0ElV2Nd/oyaOph/3f52eyGVhFo=;
 b=KeLLrCMuiMcWuj0DNfE3f/4MnYcl2P1k1iGTydrntROSPpFFKtxiSYWxCbakpIIbhM
 hHEVFdPiVL+1G1Xq9972JQsug9HOeL7INRRWdqABabqUmctzHJ3HWlfevpBYWjbmJpX/
 jOrdkDtY48LeBrO6Cgy//1BFJ1gyPvAo1FuxIlo/V3gCo+wzY77c3RSqsaytN7BhEH9Q
 pr+kcSLm5X5qeBvfxGR1LNO4MlDA/FT0xi9su1ld3pEVV154mE/UAbB2kylX6ghGeqze
 rjNIi7Mj3QXfqvyYOhHhnUkoKieuOhidHbUXyYMEbPeVq+9l+Ja1a84RvajIiy4uWGh/
 viVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779819133; x=1780423933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=crqdIrMci6pxzK9BQ0ElV2Nd/oyaOph/3f52eyGVhFo=;
 b=AwfY3QhWUV54SsEGE1lk68VUDnCJBech53rEyEOdePKtVIyxpNpPrwByBrOX+UClLJ
 Xl5nDmJnWOrQpRWWl4UOzqwUvduQSJSj57HCv2Dh4NhApRG+A4lkRh9tlwnbKOR1U18f
 eLLeq2248qoGK98fcpC1csdgbZ51FW4Zg3abe/UykIVdTPFMcQQUjYrv0h2i2uDCCm5C
 mPGIU3IObSHU8qIJVHW3rHmZXxqQ7X5lCj2CjiwoHK1MqMnrc5yqSPWB3Z/3bEY2MBwU
 JxFmOtMxBjZ1fhNC21rqk4HFqOOBF0WmmhWEItkRGRK/U1PcmNZrH9e7Elnhm1c5zcbk
 p4dg==
X-Gm-Message-State: AOJu0Yyvh4kx40LTuKgZnRTv6W76ZKw5IXbyO3u0XVtjFMRyl9/IM2ZI
 LwNrKucfAAikUFh23X3KgjcoF53DU8FVR8N7ktHfbVxd5lS41qYg2hpN
X-Gm-Gg: Acq92OFPj/Zx2DDrcy0vVMVoHR9OujWlelxsjVoIdFwlYeCodKLwL4OwRR/Fr0QFjmK
 p63L2mGZYlkLtzEnVeANy1YoYdbUokK6BBTChRRnygMiKk9rLsQAV1u0EMwJMopk/DKroQnc/sn
 z8OCpy7Cg5yIy9lzUX9DjwfLb5oQLMSJdm6Fl7GHk3aU4iAIjGQeCFdzjnmPp2HKJxkYRF5+HnK
 SIfuLjklD80iMCPFBkM3U+UUq2cypcwW+ptp6t+WrMXAFW0PjfBoWYZ0OhBVjlwJyw0z8VTGTRO
 9YodB+bGSTdo5FGeOIpwpNhgr+lsViva9QalpG7KWdmyPYHTd5ecVhonTThpvt8tZzGzXQLpacI
 WjZcoE3Kc7ra86wyi6y5qIDlOVnf+9kXtRbNQGtFXAVTq7SPOKxkwb8zCWU18nbhrgT07RcfvIz
 peZbcC/3wmQwkGlNNRNLYRZUU0luxSKFo=
X-Received: by 2002:a05:6a00:22c6:b0:836:900e:8743 with SMTP id
 d2e1a72fcca58-8415f35d58amr20505055b3a.36.1779819133178; 
 Tue, 26 May 2026 11:12:13 -0700 (PDT)
Received: from JRT-PC.. ([119.234.49.191]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7a5sm16741462b3a.33.2026.05.26.11.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:12:12 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: orika@nvidia.com,
	thomas@monjalon.net,
	andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH 2/2] ethdev: fix out-of-bounds write in flex item conversion
Date: Wed, 27 May 2026 02:11:59 +0800
Message-ID: <20260526181159.287633-3-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526181159.287633-1-jamestiotio@gmail.com>
References: <20260526181159.287633-1-jamestiotio@gmail.com>
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

rte_flow_item_flex_conv() is dispatched from rte_flow_conv_copy() to
deep-copy the variable-length pattern that follows a flex item header.
The function took no size argument at all, so the trailing rte_memcpy()
of `src->length` bytes was gated only on `buf != NULL`, violating the
documented contract that output is truncated to the caller-supplied
buffer size. A caller passing a buffer just large enough for the header
struct had adjacent memory clobbered by up to 4 GiB of pattern data,
since `src->length` is uint32_t and unbounded.

Propagate the remaining buffer size `size - sz` from
rte_flow_conv_copy() into the desc_fn callback and gate the inner
memcpy on it.

Fixes: dc4d860e8a89 ("ethdev: introduce configurable flexible item")
Cc: stable@dpdk.org

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 lib/ethdev/rte_flow.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 63b686ddfb..2744cfab2f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -36,7 +36,7 @@ uint64_t rte_flow_dynf_metadata_mask;
 struct rte_flow_desc_data {
 	const char *name;
 	size_t size;
-	size_t (*desc_fn)(void *dst, const void *src);
+	size_t (*desc_fn)(void *dst, const void *src, size_t size);
 };
 
 /**
@@ -68,16 +68,17 @@ rte_flow_conv_copy(void *buf, const void *data, const size_t size,
 	if (buf != NULL)
 		rte_memcpy(buf, data, (size > sz ? sz : size));
 	if (rte_type && desc[type].desc_fn)
-		sz += desc[type].desc_fn(size > 0 ? buf : NULL, data);
+		sz += desc[type].desc_fn(size > 0 ? buf : NULL, data,
+					 size > sz ? size - sz : 0);
 	return sz;
 }
 
 static size_t
-rte_flow_item_flex_conv(void *buf, const void *data)
+rte_flow_item_flex_conv(void *buf, const void *data, size_t size)
 {
 	struct rte_flow_item_flex *dst = buf;
 	const struct rte_flow_item_flex *src = data;
-	if (buf) {
+	if (buf && size >= src->length) {
 		dst->pattern = rte_memcpy
 			((void *)((uintptr_t)(dst + 1)), src->pattern,
 			 src->length);
-- 
2.43.0

