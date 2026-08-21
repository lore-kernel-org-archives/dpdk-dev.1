Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C247C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85A13406B6;
	Fri, 21 Aug 2026 21:28:56 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id D99FF406B6
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:55 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso1037633a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340535;
 x=1787945335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Omm41R8U1ok5QrwL5bqCi3A1DI8JhZy5E/NlBZ52mmo=;
 b=uDNReU1uM6+oFBRKcO7/0bR+Srl3+0nsfQ6V8xUCHLVQtmyC1t9ZEMNCwokM345PbV
 B1jrzIdVYNRJpx/8sXF+mqf/YtiAVXWl1O2fiT+9jvH8Mm65VBA0tN54lfvKF5rjyhPk
 bb2K6AFTHoUC/TlnrLByVWPdqGxj6kmba1bMmg2DTTQyFJGeO+2sqK9BL189KE+7dmWl
 FfNaxiVo2+7V4h1siqBYyUmdgRK3FwEwfo0gh4YGZEDtu37jGjGce+uhfGeAgjP+dsF8
 c7nqIE23ojUO7ODVq7bcR+C/HT6x/o+Xp4KTmiP4Lq+8bi7Oo7NqeV4zQBuDgd4K/TEf
 q9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340535; x=1787945335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Omm41R8U1ok5QrwL5bqCi3A1DI8JhZy5E/NlBZ52mmo=;
 b=CUckJX7ez3Y9gdSs0AMXSI0GsORGS/H9mVKBZpLi+SNMxqwLN3fk6i+IFCgMeiKYyB
 KB/kMCoOZaG+CVHYQLolv50iBicXRn1nV8nycSdN4EK3QBGiRp8GwEB1JW4TxSaUp8v7
 nXT9Xxcrx55OE6xwcKOAmqpkFTSZIj+/LV0BZaWVfWP0hpmsBnhmaGh41bTwkX/Y3A68
 LdwpNDh8qF3I/0nqU8eDenC2xX67tyVyc/HOukVjmIgMkZAF3lvzZeQ//+tI+qkJrfk3
 1D3CqNir6ccRB5nUyXNPJN/IuBuvjF7E47M73da+LnylOHKSp+Zzqnq+DrJWUwy99xIR
 m2ng==
X-Gm-Message-State: AFuF++k2qSZ5NcS48Kmkw+3J6Tno7C2nNrNQ9g8yjw+VSSbTm3kEUOBz
 Nn662NDxRvkWPmbYM/FjmP3c7iH1XYFLeeBOourOrWCQyVPYxarwveoz2xC+7HTrRccScq2JNGY
 92gvj
X-Gm-Gg: AR+sD13/l6eR+PByGz6c9GQkk2+DMyix/MF52HLpCKZpyuTyDl7trpy7iggzsDEfhb8
 +iNGqp/OB+sO8T1jeG6uqYC6y7TFRTMew/UQl1bV6B2N3J74KHmfXf/1hWBx7MtnlswP5QDFtws
 qKRXGAK7YNj57dVS4PRiH73aJgZIoBWdw7j/PBs9f5ZxWGHx3obRlnOWUsG+w6f04H5CpjHBBrc
 YVF8DxI+0CVePP9eLv8FFZiX9xmXC1OIb4LTGoYrplaJM9POptffwIi6lnzE6pFufZpPDL3Et99
 1tfhCcpmYqFJiby5EHZAhHrcrZtMzVBt4n2HYbCgrYVVXu2dIzn3FGsDX3/g+BjObvfyiGnd4r7
 m2VaobDIacGBhjCoL2qOwuBsWeIHFWyBRxxa3bk0QzCfmmICcbDFmptker6Z9DkhD2Yt0ZIpq/H
 f/fmsEXp8GQ/dFxKbmRGm2N3BByna4JG5q+XzfffMdxu7g6NEQrq5Lk3h/MECdXXjAJBzAuAgnz
 rWCUog4Qr3bMXb4hWmBE6idyBs=
X-Received: by 2002:a05:6a21:6d8a:b0:3c8:f342:132c with SMTP id
 adf61e73a8af0-3cd4bbdbad3mr1724107637.11.1787340535053; 
 Fri, 21 Aug 2026 12:28:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 16/68] ethdev: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:11 -0700
Message-ID: <20260821192646.146382-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The management of flows is better done using memcpy() or
structure assignment where compiler can do more bounds checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c |   3 +-
 lib/ethdev/rte_flow.c   | 104 ++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 60 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..faeb516093 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -16,7 +16,6 @@
 #include <rte_log.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
-#include <rte_memcpy.h>
 #include <rte_common.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
@@ -637,7 +636,7 @@ rte_eth_dev_owner_get(const uint16_t port_id, struct rte_eth_dev_owner *owner)
 	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
 
 	if (eth_dev_shared_data_prepare() != NULL) {
-		rte_memcpy(owner, &ethdev->data->owner, sizeof(*owner));
+		*owner = ethdev->data->owner;
 		ret = 0;
 	} else {
 		ret = -ENOMEM;
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 60c9a3d06f..5b62a44052 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -66,7 +66,7 @@ rte_flow_conv_copy(void *buf, const void *data, const size_t size,
 	if (data == NULL)
 		return 0;
 	if (buf != NULL)
-		rte_memcpy(buf, data, (size > sz ? sz : size));
+		memcpy(buf, data, RTE_MIN(size, sz));
 	if (rte_type && desc[type].desc_fn)
 		sz += desc[type].desc_fn(size > 0 ? buf : NULL, data,
 					 size > sz ? size - sz : 0);
@@ -78,11 +78,8 @@ rte_flow_item_flex_conv(void *buf, const void *data, size_t size)
 {
 	struct rte_flow_item_flex *dst = buf;
 	const struct rte_flow_item_flex *src = data;
-	if (buf && size >= src->length) {
-		dst->pattern = rte_memcpy
-			((void *)((uintptr_t)(dst + 1)), src->pattern,
-			 src->length);
-	}
+	if (buf && size >= src->length)
+		dst->pattern = memcpy((void *)((uintptr_t)(dst + 1)), src->pattern, src->length);
 	return src->length;
 }
 
@@ -662,16 +659,16 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 		mask.raw = item->mask ? item->mask : &rte_flow_item_raw_mask;
 		src.raw = data;
 		dst.raw = buf;
-		rte_memcpy(dst.raw,
-			   (&(struct rte_flow_item_raw){
-				.relative = src.raw->relative,
-				.search = src.raw->search,
-				.reserved = src.raw->reserved,
-				.offset = src.raw->offset,
-				.limit = src.raw->limit,
-				.length = src.raw->length,
-			   }),
-			   size > sizeof(*dst.raw) ? sizeof(*dst.raw) : size);
+		memcpy(dst.raw,
+		       (&(struct rte_flow_item_raw){
+			       .relative = src.raw->relative,
+			       .search = src.raw->search,
+			       .reserved = src.raw->reserved,
+			       .offset = src.raw->offset,
+			       .limit = src.raw->limit,
+			       .length = src.raw->length,
+		       }),
+		       RTE_MIN(size, sizeof(*dst.raw)));
 		off = sizeof(*dst.raw);
 		if (type == RTE_FLOW_CONV_ITEM_SPEC && spec.raw)
 			tmp = spec.raw->length & mask.raw->length;
@@ -688,9 +685,7 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 			off = RTE_ALIGN_CEIL(off, sizeof(*dst.raw->pattern));
 			if (size >= off + tmp) {
 				deep_src = (void *)((uintptr_t)dst.raw + off);
-				dst.raw->pattern = rte_memcpy(deep_src,
-							      src.raw->pattern,
-							      tmp);
+				dst.raw->pattern = memcpy(deep_src, src.raw->pattern, tmp);
 			}
 			off += tmp;
 		}
@@ -704,9 +699,7 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 		tmp = spec.geneve_opt ? (spec.geneve_opt->option_len << 2) : 0;
 		if (size >= off + tmp && tmp > 0 && src.geneve_opt->data) {
 			deep_src = (void *)((uintptr_t)(dst.geneve_opt + 1));
-			dst.geneve_opt->data = rte_memcpy(deep_src,
-							  src.geneve_opt->data,
-							  tmp);
+			dst.geneve_opt->data = memcpy(deep_src, src.geneve_opt->data, tmp);
 		}
 		off += tmp;
 		break;
@@ -756,32 +749,30 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
 	case RTE_FLOW_ACTION_TYPE_RSS:
 		src.rss = action->conf;
 		dst.rss = buf;
-		rte_memcpy(dst.rss,
-			   (&(struct rte_flow_action_rss){
-				.func = src.rss->func,
-				.level = src.rss->level,
-				.types = src.rss->types,
-				.key_len = src.rss->key_len,
-				.queue_num = src.rss->queue_num,
-			   }),
-			   size > sizeof(*dst.rss) ? sizeof(*dst.rss) : size);
+		memcpy(dst.rss,
+		       (&(struct rte_flow_action_rss){
+			       .func = src.rss->func,
+			       .level = src.rss->level,
+			       .types = src.rss->types,
+			       .key_len = src.rss->key_len,
+			       .queue_num = src.rss->queue_num,
+		       }),
+		       RTE_MIN(size, sizeof(*dst.rss)));
 		off = sizeof(*dst.rss);
 		if (src.rss->key_len && src.rss->key) {
 			off = RTE_ALIGN_CEIL(off, sizeof(*dst.rss->key));
 			tmp = sizeof(*src.rss->key) * src.rss->key_len;
 			if (size >= (uint64_t)off + (uint64_t)tmp)
-				dst.rss->key = rte_memcpy
-					((void *)((uintptr_t)dst.rss + off),
-					 src.rss->key, tmp);
+				dst.rss->key = memcpy((void *)((uintptr_t)dst.rss + off),
+						      src.rss->key, tmp);
 			off += tmp;
 		}
 		if (src.rss->queue_num) {
 			off = RTE_ALIGN_CEIL(off, sizeof(*dst.rss->queue));
 			tmp = sizeof(*src.rss->queue) * src.rss->queue_num;
 			if (size >= (uint64_t)off + (uint64_t)tmp)
-				dst.rss->queue = rte_memcpy
-					((void *)((uintptr_t)dst.rss + off),
-					 src.rss->queue, tmp);
+				dst.rss->queue = memcpy((void *)((uintptr_t)dst.rss + off),
+							src.rss->queue, tmp);
 			off += tmp;
 		}
 		break;
@@ -1023,20 +1014,19 @@ rte_flow_conv_rule(struct rte_flow_conv_rule *dst,
 	size_t off;
 	int ret;
 
-	rte_memcpy(dst,
-		   (&(struct rte_flow_conv_rule){
-			.attr = NULL,
-			.pattern = NULL,
-			.actions = NULL,
-		   }),
-		   size > sizeof(*dst) ? sizeof(*dst) : size);
+	memcpy(dst,
+	       (&(struct rte_flow_conv_rule){
+		       .attr = NULL,
+		       .pattern = NULL,
+		       .actions = NULL,
+	       }),
+	       RTE_MIN(size, sizeof(*dst)));
 	off = sizeof(*dst);
 	if (src->attr_ro) {
 		off = RTE_ALIGN_CEIL(off, sizeof(double));
 		if (size && size >= off + sizeof(*dst->attr))
-			dst->attr = rte_memcpy
-				((void *)((uintptr_t)dst + off),
-				 src->attr_ro, sizeof(*dst->attr));
+			dst->attr = memcpy((void *)((uintptr_t)dst + off),
+					   src->attr_ro, sizeof(*dst->attr));
 		off += sizeof(*dst->attr);
 	}
 	if (src->pattern_ro) {
@@ -1138,9 +1128,7 @@ rte_flow_conv(enum rte_flow_conv_op op,
 		break;
 	case RTE_FLOW_CONV_OP_ATTR:
 		attr = src;
-		if (size > sizeof(*attr))
-			size = sizeof(*attr);
-		rte_memcpy(dst, attr, size);
+		memcpy(dst, attr, RTE_MIN(size, sizeof(*attr)));
 		ret = sizeof(*attr);
 		break;
 	case RTE_FLOW_CONV_OP_ITEM:
@@ -1232,14 +1220,14 @@ rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	if (ret < 0)
 		return 0;
 	ret += sizeof(*desc) - sizeof(*dst);
-	rte_memcpy(desc,
-		   (&(struct rte_flow_desc){
-			.size = ret,
-			.attr = *attr,
-			.items = dst_size ? dst->pattern : NULL,
-			.actions = dst_size ? dst->actions : NULL,
-		   }),
-		   len > sizeof(*desc) ? sizeof(*desc) : len);
+	memcpy(desc,
+	       (&(struct rte_flow_desc){
+		       .size = ret,
+		       .attr = *attr,
+		       .items = dst_size ? dst->pattern : NULL,
+		       .actions = dst_size ? dst->actions : NULL,
+	       }),
+	       RTE_MIN(len, sizeof(*desc)));
 
 	rte_flow_trace_copy(desc, len, attr, items, actions, ret);
 
-- 
2.53.0

