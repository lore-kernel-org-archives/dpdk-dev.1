Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20396C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEB240E22;
	Tue,  1 Sep 2026 22:33:17 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id DD19E40B99
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:33:15 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8558c0b26a8so229131b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294795;
 x=1788899595; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5E6/WwMa0ufbBpVMcp6ZgyQslWS9gCutX9OvAiLH9nk=;
 b=v2KqFnzAYIUrAZUWpxsxnEbLAK7Lp2qG2tTEzTjRv3xA/9INpfw48E0apSantsZ7Fr
 XQa2f2IMzxrrDjB6pkxOLSHm2DeQxbXdeYGbFDiPYXu3euI+X29BTXScMqXdWFUfVE9F
 XfxjL7IFuG4E5Ev4vxneNN8KAYrlCNzCAGijDkCAmdCo2DsjK6PwMZJ6acwBNyEMou2L
 VzNVe3CRTnsFGdiOidtL9N2NJEFH8DwdS+5r0Ya12EwrDAgEddsjt41GEQmPi70hJcQi
 x2fLmLHly7sKReXsxnRsFCwVBk3K7frNAY0bJhCzz9LhkkiP1kF6oL/3uL2NuHijk8zu
 wgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294795; x=1788899595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5E6/WwMa0ufbBpVMcp6ZgyQslWS9gCutX9OvAiLH9nk=;
 b=SdEDAQQ1E0UdDn2rKjkfbn736cmXrGNZYCq1Zq09WT/2LdoxRu50dPe0KIOmCHr+bF
 hQWroeNbMQMlIA6ubFmD2Bg69RKVvf+eD/sg0L473ZlayuRC/08nSpNOmLLgffBsJ29Y
 JeFZr3hOu1RGFphSxg5Oe2Xe7d9LjCD+zlhSNl0F/rieSqQOrZocUosH4RM5ebJ1FnrM
 dNPVG1luZEh/L5YeqWVFaegQD0w5CT/dlJj10+Yz5bX89Mg/oA7KRRtI9pwITRQot6l/
 0hIhqVy2BRw2HpQ+ueVLMPc1qbjhD3rWIxXWvBrx5FlOn3CVswF6C4POJpuzUM254+Up
 oa0A==
X-Gm-Message-State: AFuF++nJ+EfZrIUaHskr1AT+wm6tMYWgV0mmQylnl1eegDpvSLsykJWl
 5lxSn2tEfsGbKT4DsjV+Ak73wm3Gis/qC4OYnWaLWl5F+J0T30aDnCbsoH8up1IqtR7J42jz8zH
 5R+YT
X-Gm-Gg: AR+sD13Uh15jDUNM/YXeGGLxRi54O07G04tbEu60+YweC17wWvaFhL7frZGINe20VWY
 DjhrxoooGvy84IZxTPvGN3cudYl7/0O/UbxYME8Xv9WY7begOq5BAHjgbMv8vY3GkOA1Lx6kxKb
 nzKWTeemrP05UzzU43MA3C/AlXxEzMTd19Qo5DMFAK81/JJZnSPKWIT3PiJXbqGw8uPDFmBzFZ0
 oSaanSq0CzkJ0xS1sTyyBiw8ckZJVAOqs7pOANEoE28/4LSX9AyoFBABdE3OHFJSXR/iLVBBc9U
 eZqUECmD9ANd6Q379q7BOqaTtp17i9qBloKir2POa/oH3x+pmzOSqBxPakaVS/weq08FY4aOyXf
 0e6NgZ4ciiCDUSbb4GxLG7xC0Cw3tKf05e7NYZgUWqjA37k/GvT+oTtlwGlsZ57Urz4aiARSjwT
 FJzhEIAZF6EVk8JA+X1AhOMKZQULyI+1DlIYMeoK2I/qG6KBpFO/U70sUL5CtQ5/A7lxy6GuF3z
 Voucv9oyMiHo9+3b/4gAgAc5pA=
X-Received: by 2002:a05:6a00:bd8a:b0:85b:8606:627f with SMTP id
 d2e1a72fcca58-85ed4a26ccamr605343b3a.26.1788294795024; 
 Tue, 01 Sep 2026 13:33:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:33:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 12/22] ethdev: promote flex item API to stable
Date: Tue,  1 Sep 2026 13:23:11 -0700
Message-ID: <20260901203217.1485915-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

rte_flow_flex_item_create() and rte_flow_flex_item_release() were
added in v21.11 to let applications describe vendor specific or
otherwise unsupported protocol headers for matching. Both are
unchanged since.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/ethdev/rte_flow.c                  | 4 ++--
 lib/ethdev/rte_flow.h                  | 9 ---------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0f819b7013..141ad134b0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -123,6 +123,7 @@ API Changes
     ``rte_flow_template_*``,
     ``rte_flow_async_*``,
     ``rte_flow_push``, ``rte_flow_pull``
+  * flow flex: ``rte_flow_flex_item_create`` and ``rte_flow_flex_item_release``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index edbf8a8bce..75e3e1f10f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1626,7 +1626,7 @@ rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_create, 21.11)
+RTE_EXPORT_SYMBOL(rte_flow_flex_item_create)
 struct rte_flow_item_flex_handle *
 rte_flow_flex_item_create(uint16_t port_id,
 			  const struct rte_flow_item_flex_conf *conf,
@@ -1653,7 +1653,7 @@ rte_flow_flex_item_create(uint16_t port_id,
 	return handle;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_flex_item_release, 21.11)
+RTE_EXPORT_SYMBOL(rte_flow_flex_item_release)
 int
 rte_flow_flex_item_release(uint16_t port_id,
 			   const struct rte_flow_item_flex_handle *handle,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 16645207c3..6fc6f750f1 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -2252,10 +2252,6 @@ struct rte_flow_item_flex_link {
 	uint32_t next;
 };
 
-/**
- * @warning
- * @b EXPERIMENTAL: this structure may change without prior notice
- */
 struct rte_flow_item_flex_conf {
 	/**
 	 * Specifies the flex item and tunnel relations and tells the PMD
@@ -5402,9 +5398,6 @@ rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
 			     struct rte_flow_error *error);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create the flex item with specified configuration over
  * the Ethernet device.
  *
@@ -5419,7 +5412,6 @@ rte_flow_pick_transfer_proxy(uint16_t port_id, uint16_t *proxy_port_id,
  * @return
  *   Non-NULL opaque pointer on success, NULL otherwise and rte_errno is set.
  */
-__rte_experimental
 struct rte_flow_item_flex_handle *
 rte_flow_flex_item_create(uint16_t port_id,
 			  const struct rte_flow_item_flex_conf *conf,
@@ -5439,7 +5431,6 @@ rte_flow_flex_item_create(uint16_t port_id,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-__rte_experimental
 int
 rte_flow_flex_item_release(uint16_t port_id,
 			   const struct rte_flow_item_flex_handle *handle,
-- 
2.53.0

