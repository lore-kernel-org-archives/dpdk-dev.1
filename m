Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17ECC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F35834068A;
	Thu, 20 Aug 2026 07:23:40 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 0209A40678
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:40 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2089690a91.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203419;
 x=1787808219; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Omm41R8U1ok5QrwL5bqCi3A1DI8JhZy5E/NlBZ52mmo=;
 b=tjrjTne89jJz2fE2sEycjYAbJ+bT73emsl5g2WMsc75IWNm8clzqRLBWYSVGMKscsa
 1DIlk36R/GOOd8tDGEewdiGj/NYtJkZhD1+R/9czjra6myeKYCaF01BfocvfezvbLRGf
 BqM17aRftxApq9xZgsvp2tu3edY2EtdG7ZVnG3pf09kaLkeGdOm1lkSKi1nDFqTFiNsn
 KtYPI/kslBKrJzDW3pqk3eT6NbPHdCd4URxq8QjP+QVDYpF8koCIw37NagPpXsnUXLpt
 /9AVOnBeOtnmVUzG/RlMdiKhvnf+9tlQGV3CP9N+XIQY4OWdm4sc0E8QYbgSLoKD8ASS
 x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203419; x=1787808219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Omm41R8U1ok5QrwL5bqCi3A1DI8JhZy5E/NlBZ52mmo=;
 b=dStU8yO2WYrpCYDrMf76TNQz4BYQVqR37JDzIec+9Vp45tVzrhWClXtJeRtib2bneO
 nKR3fh1sr3wBq5BTI+jrriGVjBM9monMyIGEOMMOTxRox5s91ESJChMaLXx0k1Kg50m1
 VAetqUXjUwK4MOEVcDMv6F5veZFuTTFfSxf/gnlKAIj9edTA+tTIm/dreRyG03QNaEuV
 MVgjC84VQdQo7IBJ9kBpSb/24TldCYaTxSqAE0g4fitslC4lA+tor0QebSam2iJ0Kqnz
 4leUNys2My0GHR3ni2eT/C8tUzVvjrs+/g8p99D/MLzGZxAenORch9nVg21iufarTeNp
 r5ZQ==
X-Gm-Message-State: AFuF++kdOJXt2S1vd2lOpIPmFlzWUKKwx2UjOau6+2sqCp1iyE516GrS
 tBeGv8rvY9o7aZJZ+viDI3zDXv9R+qiwyPVpNUnYayAZPBlVIOpQQ+Bz0rHZNoXwG9AIly1iuHM
 4IQui
X-Gm-Gg: AR+sD10nkwnekjANdN08z2jeu+x8cgOyrYTTLWI9CbNZMq1KeM1Dq+7YdnE1MenCIph
 jQQ+MIXI0WG/qq3x+Vf37xIYNXQqOuM1UyzFDIWk94RvgjgKP8aUG0o3Y/q0kuAOnuTbJpyZYPn
 qEE9zPLUWSvdjGmIeTz1oY3Y3o9uao9pKxCpMfJFGpRTtfkv3/CwusCcToobi6WOw9NflmD2ZWU
 09pY1gMeYOsLt+ApzA+B6gA0XxV9IdgoA0tKak9HTITW6G/SK2an93Jgl+4mirw8i84dG5wcNMt
 H6aYGWOKDVzz2zgCRCa3zqsOyV7IafySqg3R2TjjqTQ2Hg6yVgC+Xp0+4efgzoxdHgR5S1RT2Rd
 BPVUxRF6olCvKTHo/Yo/sJweXPU3C6bs5lRx3tDjDj/9GYmKBjRevSiWruikKLMB0z04/s3kXk6
 vtRuqJ5rBM+VFtfcP8cSTqkZA+0Ud4leDCtrtgFEiRQO7UCkXuMOToy9x9m35pHLPnOr6HUJ9h6
 TkDKa+Bl6LKKR1HvT/UM2YdA0o=
X-Received: by 2002:a17:90b:2b8e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-395810c60ffmr19805185a91.13.1787203419095; 
 Wed, 19 Aug 2026 22:23:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 09/61] ethdev: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:11:59 -0700
Message-ID: <20260820052251.1453273-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

