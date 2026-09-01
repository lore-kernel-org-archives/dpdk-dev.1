Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D65C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 23:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D539B402EA;
	Wed,  2 Sep 2026 01:10:45 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 547B640281
 for <dev@dpdk.org>; Wed,  2 Sep 2026 01:10:44 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so494099a12.2
 for <dev@dpdk.org>; Tue, 01 Sep 2026 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788304243;
 x=1788909043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KGw4Lf68sMmI92A88TtZbiTrp7nGAVN4Vgn2A0L8Ta8=;
 b=Rdafu0iqBFckcE3qwmS2m9CO7H3yF+7UveDLP9YcmaaxVkr7C1sS2n82NeQXFL0eEj
 jwXwJldsKWizSBvrqMSRAtXwxDCmYGEP41VhFmL7bQfckPsXcMQdSNbxsssgnzlzWRrl
 6h2R/cYVkWx4ukr1sxsEXUdGMhkpymeJXF+0wkwOqw2DBZu39Zk2jOlI2OYkd6f1MPtk
 B5boaiHkRSO13Wx5qi3lPeYngYrcEnTGmFQnAV6P8FMRt8uqa7ZcYEWhdBH2e1RrLL0A
 hRZNxBgR6TiMQnYK6NoowQ3g7cpn1QVUTib5FJJ3U2mNDGzVjGeLGLY0d+W4YX2HQfEo
 tR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788304243; x=1788909043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KGw4Lf68sMmI92A88TtZbiTrp7nGAVN4Vgn2A0L8Ta8=;
 b=bGA1ia+PaDMXbV9ks56HBxuPnHXf85ircR0Y6XgkBisF3EXuZ4VJ87Q4wGF6xkR14C
 Si7gdTKOrxeHn7zSvcqyGi8gO3XRTQNUA3i1F1ulGWvtJVCq+QRhM87FCX9zN/UEB9Mg
 qd5zVDgB/3Mz+Gn2fONWQU4xyH+VsR/HbaPizS1u6YNB74QrBkuKx1OFYQju9wrXUgUE
 hBv2kgpqumYda82NMFu7PTVkCrej2XdFaDHgVdlCReySHpTmDa44QgaqpZQUpw5GRXjJ
 9UG/P0A/FKUTzTjlH4u0IhXhlTR4xRCVE7tUuWmtatdSAsBf1YJQ+aUlQgdzJOA2ln6t
 xltQ==
X-Gm-Message-State: AFuF++kn/Rdu7aFR8au6lDNM/AY9P2QNtWMx2j4wKSXM5pEFI7+5pWWq
 k6CyMRH3UhjQnUezlbnIcLIhSbOU3z6UhpHVfjRo57oI7p4RtiSID4+GYY3RMJGwP8t0komzfVH
 cb5je
X-Gm-Gg: AYBFou2WHoo7D6iOST2Cu2M9Qitu02rZCuBqOnbQ63dxsY1xzVEx7uCkivaxl4hfsYa
 KTZZhn720FqLfVR4Xgga+2y5uDBEv8gdF2AyXHxSNHkFzwzH07o38wcrW5gzr/Vd9w4412K1ZIZ
 xuG/cURBti5Wvk79K8cikXABUA7K7wan2+TbT95LssCbppyPIRlX+YIKkGlb3JlJZJA1dT9L3TJ
 N+8Owb9duW7m0pjqqg+My6+H+FZE0MYt1hh5fSjOu6hI4LoaNCf1lx7012ZpYqQjpnR7hba1zHA
 JF7lNQkWlv7MGyu8MkiXSEp7lZuHM9WSy2Yg/xls81ZVLsW3MgSilHwP0BykUIc5Io6tXUqUeRJ
 EOaK3Ji/dRHaFhzTrOGeCOJnRMSRjAehFX7zGGZCINgmN5bHttpYgGTVl/JpQTWXHh8LL6y72Cj
 6pb5n5pCRV6zNZX7Fh4OojE5L3+l014J3ZfgU7wN0Y8n45ONl5gDfy6fY8oG1qJYJWRkZh95IFG
 bbdDqjuh2Wl4kAIbdZi/jQKlWo=
X-Received: by 2002:a17:90b:268d:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39aee023191mr630676a91.10.1788304242989; 
 Tue, 01 Sep 2026 16:10:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d80433dsm7614260a91.17.2026.09.01.16.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 16:10:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 1/2] ethdev: remove deprecated flow copy API
Date: Tue,  1 Sep 2026 16:10:32 -0700
Message-ID: <20260901231033.169368-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The rte_flow_copy() function and struct rte_flow_desc have been
deprecated since 18.05. The function was only a wrapper around
rte_flow_conv(), and struct rte_flow_desc uses a flexible array
member which makes it unusable from C++.

Remove the function, the structure and the associated trace point.
Users should call rte_flow_conv() with RTE_FLOW_CONV_OP_RULE instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/ethdev/ethdev_trace.h              | 15 -------
 lib/ethdev/ethdev_trace_points.c       |  3 --
 lib/ethdev/rte_flow.c                  | 56 --------------------------
 lib/ethdev/rte_flow.h                  | 45 ---------------------
 5 files changed, 1 insertion(+), 119 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 760f49c496..591718253d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -71,6 +71,7 @@ Removed Items
 * Removed deprecated symbols:
 
   * eal: ``__rte_packed``
+  * ethdev: ``rte_flow_copy``, ``struct rte_flow_desc``
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
   * lpm: ``RTE_LPM6_IPV6_ADDR_SIZE``, ``RTE_LPM6_MAX_DEPTH``
   * net: ``RTE_IP_ICMP_ECHO_REPLY``, ``RTE_IP_ICMP_ECHO_REQUEST``
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 6554cc1a21..8cd95a2851 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1402,21 +1402,6 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
-RTE_TRACE_POINT(
-	rte_flow_trace_copy,
-	RTE_TRACE_POINT_ARGS(struct rte_flow_desc *fd, size_t len,
-		const struct rte_flow_attr *attr,
-		const struct rte_flow_item *items,
-		const struct rte_flow_action *actions, int ret),
-	rte_trace_point_emit_ptr(fd);
-	rte_trace_point_emit_size_t(len);
-	rte_trace_point_emit_u32(attr->group);
-	rte_trace_point_emit_u32(attr->priority);
-	rte_trace_point_emit_ptr(items);
-	rte_trace_point_emit_ptr(actions);
-	rte_trace_point_emit_int(ret);
-)
-
 RTE_TRACE_POINT(
 	rte_flow_trace_tunnel_decap_set,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 0a28378a56..a81398893f 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -503,9 +503,6 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_count_aggr_ports,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_map_aggr_tx_affinity,
 	lib.ethdev.map_aggr_tx_affinity)
 
-RTE_TRACE_POINT_REGISTER(rte_flow_trace_copy,
-	lib.ethdev.flow.copy)
-
 RTE_TRACE_POINT_REGISTER(rte_flow_trace_create,
 	lib.ethdev.flow.create)
 
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 1056cfd2c5..cc96190a71 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1190,62 +1190,6 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	return ret;
 }
 
-/** Store a full rte_flow description. */
-RTE_EXPORT_SYMBOL(rte_flow_copy)
-size_t
-rte_flow_copy(struct rte_flow_desc *desc, size_t len,
-	      const struct rte_flow_attr *attr,
-	      const struct rte_flow_item *items,
-	      const struct rte_flow_action *actions)
-{
-	/*
-	 * Overlap struct rte_flow_conv with struct rte_flow_desc in order
-	 * to convert the former to the latter without wasting space.
-	 */
-	struct rte_flow_conv_rule *dst =
-		len ?
-		(void *)((uintptr_t)desc +
-			 (offsetof(struct rte_flow_desc, actions) -
-			  offsetof(struct rte_flow_conv_rule, actions))) :
-		NULL;
-	size_t dst_size =
-		len > sizeof(*desc) - sizeof(*dst) ?
-		len - (sizeof(*desc) - sizeof(*dst)) :
-		0;
-	struct rte_flow_conv_rule src = {
-		.attr_ro = NULL,
-		.pattern_ro = items,
-		.actions_ro = actions,
-	};
-	int ret;
-
-	RTE_BUILD_BUG_ON(sizeof(struct rte_flow_desc) <
-			 sizeof(struct rte_flow_conv_rule));
-	if (dst_size &&
-	    (&dst->pattern != &desc->items ||
-	     &dst->actions != &desc->actions ||
-	     (uintptr_t)(dst + 1) != (uintptr_t)(desc + 1))) {
-		rte_errno = EINVAL;
-		return 0;
-	}
-	ret = rte_flow_conv(RTE_FLOW_CONV_OP_RULE, dst, dst_size, &src, NULL);
-	if (ret < 0)
-		return 0;
-	ret += sizeof(*desc) - sizeof(*dst);
-	rte_memcpy(desc,
-		   (&(struct rte_flow_desc){
-			.size = ret,
-			.attr = *attr,
-			.items = dst_size ? dst->pattern : NULL,
-			.actions = dst_size ? dst->actions : NULL,
-		   }),
-		   len > sizeof(*desc) ? sizeof(*desc) : len);
-
-	rte_flow_trace_copy(desc, len, attr, items, actions, ret);
-
-	return ret;
-}
-
 RTE_EXPORT_SYMBOL(rte_flow_dev_dump)
 int
 rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 1bfe1b3f61..dcd1dbf03e 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4714,51 +4714,6 @@ rte_flow_error_set(struct rte_flow_error *error,
 		   const void *cause,
 		   const char *message);
 
-/**
- * @deprecated
- * @see rte_flow_copy()
- */
-struct rte_flow_desc {
-	size_t size; /**< Allocated space including data[]. */
-	struct rte_flow_attr attr; /**< Attributes. */
-	struct rte_flow_item *items; /**< Items. */
-	struct rte_flow_action *actions; /**< Actions. */
-	uint8_t data[]; /**< Storage for items/actions. */
-};
-
-/**
- * @deprecated
- * Copy an rte_flow rule description.
- *
- * This interface is kept for compatibility with older applications but is
- * implemented as a wrapper to rte_flow_conv(). It is deprecated due to its
- * lack of flexibility and reliance on a type unusable with C++ programs
- * (struct rte_flow_desc).
- *
- * @param[in] fd
- *   Flow rule description.
- * @param[in] len
- *   Total size of allocated data for the flow description.
- * @param[in] attr
- *   Flow rule attributes.
- * @param[in] items
- *   Pattern specification (list terminated by the END pattern item).
- * @param[in] actions
- *   Associated actions (list terminated by the END action).
- *
- * @return
- *   If len is greater or equal to the size of the flow, the total size of the
- *   flow description and its data.
- *   If len is lower than the size of the flow, the number of bytes that would
- *   have been written to desc had it been sufficient. Nothing is written.
- */
-__rte_deprecated
-size_t
-rte_flow_copy(struct rte_flow_desc *fd, size_t len,
-	      const struct rte_flow_attr *attr,
-	      const struct rte_flow_item *items,
-	      const struct rte_flow_action *actions);
-
 /**
  * Flow object conversion helper.
  *
-- 
2.53.0

