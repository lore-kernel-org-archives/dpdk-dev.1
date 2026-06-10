Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAADCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 11:34:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46CEC40665;
	Wed, 10 Jun 2026 13:33:59 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id C01DB40673
 for <dev@dpdk.org>; Wed, 10 Jun 2026 13:33:57 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8423f1d8902so2860829b3a.1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781091237; x=1781696037; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zduGcz0I4tszrN4yx3/misQkBHKHdeL3X31QbzBXTK0=;
 b=JZf/ITwq6pv+GbS7n0IoEjOOA5h81Jan3t7scYtfLjtzFo2hZDZgbjSt8IKhMXbavd
 h/ffwwPT9RkhfJ6iQEAd+7/89RQlX4kDRwO1YVXE5CII9oRA851siX+ns2VyNeVWdZxt
 h0oocOq8C53Q4vKJg9T3P4BVpk7ZuvU6AoM8yYFtaNqTuN4VoYLm5GieureyzXrRcL1V
 0WgHlKHQY10fGyth4kuSJhiNsarcefO4Js9d9e0EeEJcW7/TXimQhNsePXecvHcHXDj/
 1WfNRG3H0mFt4s/4E63wk/bv62CHTPwIknU9QNQZ8HQ1UwgObeUIrEIorse17JPtcOT0
 JDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091237; x=1781696037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zduGcz0I4tszrN4yx3/misQkBHKHdeL3X31QbzBXTK0=;
 b=SYFTZ6q6pEq/cLc7yi1cY2puzp7Yo5gr+RoCuStbD79VhRkgiT3wVr5GaL75BpJU/3
 ibea8QuAriyXWO3diP0h78/Qf2n9PLa2e7NGxZQSVpMbXVGNzreQqL7AbvR8sJyE36Wi
 /LqcyRcgYt/ZCbsK2LzI7Vp/AzOJgFniWc/D0ObktPZAifesSlHPpYT1kKGjPVkEEgAI
 uR9nxQ02iVxrmH75kFRiDW9oVIPAcg3xp/ov7PBHCZISwsDQ6316bBKDKWR/FAMOSkKG
 UDCzQG8qhlMNBE3QcQNIkwAY4koMiHvTC9X21x1L528oyCilFIjFKqJRsBpgCHHNwIiO
 vxOA==
X-Gm-Message-State: AOJu0YyN0ayeJq/FebEZPzarc/NTnI7P777iR3x2nRql6jSjKMEULH7K
 QFMR1fljzUcVVTNmCcpL6gv1pRUOz8ohuFH9WcjNXma70FdQHVvmU34qKfO803jVqAQ=
X-Gm-Gg: Acq92OHRoNNfwN1XjgY1KFqC5Rv2WLuYwQxEVFOU9j/f5Cn2Ov43/bFHxLaUtN7f/Im
 2nBP562exNxR65dAzb+GIHyqoTYSVo/Au7tRKyfPPklf0q/QzexsuJHD01bIKbqEMoClh8hvcqw
 1wb/cmijdJh/fU2LafPLHAWMGeQwdmQ706Cnvi9BPpN/qrKs7NRVnnediNNmB58yF64kQO7JDFx
 lUyKSVFUC0J4afLbdayhKqw7fxui07DqHuktiMdjI9PEhvcjbAuwlAVkXR/SHjLjhLxO6mYmyO+
 M4K5OYw9ySLpVthcq2Yei34WWmswEiXQuAvUYdTGatuXPqjLmZeT3lVei9VHVi5rQc3e449T0vi
 2Wz9AAT1FKwlefpvLtZa6KY7Neyb9y3tQKxc9HbY5qtrMOoV8cu5Lv4X35WtEMSVgcZSIJF1kjy
 4CaoGqutw88vLNTEJDOfe3z3J5jhvCOSm+0pmpMD1FUX0meVJ0wHkUjXmI5ec=
X-Received: by 2002:a05:6a00:8d8e:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-842b0e118b1mr25146655b3a.7.1781091236832; 
 Wed, 10 Jun 2026 04:33:56 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e228asm26885547b3a.47.2026.06.10.04.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:33:56 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v2 2/2] ethdev: fix out-of-bounds write in flex item conversion
Date: Wed, 10 Jun 2026 19:33:34 +0800
Message-ID: <20260610113334.277895-3-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610113334.277895-1-jamestiotio@gmail.com>
References: <20260610113334.277895-1-jamestiotio@gmail.com>
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
index e534f2295b..60c9a3d06f 100644
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

