Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B445C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B7D40E22;
	Tue,  1 Sep 2026 22:32:49 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id EBA1240E1C
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:48 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8568e3ecfc3so217727b3a.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294768;
 x=1788899568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKiimim5VVO7bB8r39RQgsBMT/4l55ZhSUWLGmv7L84=;
 b=XHf5uTh9/1IZZx7Rmo+T62ruJ06ssYl/YEzZhB1Z9evf1YqpUNRVfKPDX5ZhxiecDR
 8v8fjyJ5BWGXHYm/aHZTsnkfxkOagnrNcekIIasVmNF83RuDlG9oxTAYOrFLMLfAyh1Y
 qkBSsCMq4lFwPCCVY2xWJon7OoyYOR5AOoHGogETnd/qksmyr9l8Rx3bUgwItuRen5jZ
 +P8T2mJwI8icfOQ6KDOVFlEukG2BFBJN1AYVKpOhDh9UPAQ++q05N4ef3Wf2I++pYe2i
 DPEECoSZuxvJPy/N0eLDy5u91z4CZyOGX2MvEoD07JSmfNXo4pj3gROJZMA2gz7G1T7S
 /ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294768; x=1788899568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKiimim5VVO7bB8r39RQgsBMT/4l55ZhSUWLGmv7L84=;
 b=aEegpdj5Jy/cC4m0R/nvn57An8wX8IJEGXbN6b5ypDJdPx01Gdnc9eaOK9dGXtmLPy
 FvrCluUBQRHyiN5Kb/r+Dl3DOKovhmVF68xzuy2xszAcrhR1Kf6mGO0ZcyNBjc2Nf46P
 3cVvU8NHQizW2plKcOmVD7blLuLy25oko8eQGCx+lAEXkgLJJPudkHTv6rDBbz6d3l2w
 mPM9CDnu7Hrks39ym1rIQtmW6cm7Jl9aQFsTYIDlgJUX2AXLdhZBiDLFbk4PadAVP0Xe
 E3WKkHLSg2b8XFN3lNGxdsCBxFJ84MT6v4GuC99pjPUQ+9fIvG4OrJA06hMWwBuH+jWe
 HRJA==
X-Gm-Message-State: AFuF++lGqEjknOHFlAI/l+pCwFuDRzjy0xPQGUEkyt0IzVoj2ldXNfUp
 LcrXK/B95F69QNU4UGlGEBoklZ4zjesG/a9BeVE0hY+L3MeBzDjw10l/60OHM5c+yDBvNoUx79Z
 FoSmc
X-Gm-Gg: AR+sD13s7Fns8LaOEz6zrBKI8U5a2Lq3mySVoSp3a1VU0KklRtUybpLKE4f1jonhv5e
 ZHO+yawqWVHExD0i83tPekjKUSR8Or9riP850xlmrnSTGZtOwdTCvxw7FlfoCSMpW2/0D530R0b
 fI+s4teHKrvI0wkH39MEWKJBy9qPkKzrY/MDZjpvo6AayMck0uWaVUPFfW5f0xyRrHwpZRDBNwq
 k9ClFjWpxTwOpQ1ayC6QKBulFzFN1wKczh32NCWBI78GJz+aWAVVtfkj/4fmdh6xG3/aeWGfHmt
 Aw2xZBQtVHF8FDjXOzUxKFjB2eLyWS3uXoxO+MM2F1hh1hf2UgjrhB9PjHi+axLhG3SLKLWsmLg
 jeghZ3HeBTYSkd8d3XELfJIPNXQ3Yn7T1F2z85tUnTlomIdOPXtMMt3i5LAtaiE/o9f40DTQ+Lk
 nbFzUeZrG6gRHyx33yxn7sCJVaTEVUEdsiMF2f7JWma1/YPaSZnYDCnV8yqUCd9QiI9UVeT4qEJ
 KxVNzlRgEyNx0Px9ZY6iWMLiLE=
X-Received: by 2002:a05:6a00:1801:b0:857:7658:b407 with SMTP id
 d2e1a72fcca58-85ed520fadfmr551276b3a.26.1788294768059; 
 Tue, 01 Sep 2026 13:32:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [PATCH 05/22] ethdev: promote read clock and flow dump to stable
Date: Tue,  1 Sep 2026 13:23:04 -0700
Message-ID: <20260901203217.1485915-6-stephen@networkplumber.org>
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

Two long-standing ethdev helpers graduate here:

  19.08  rte_eth_read_clock, to read the device clock counter
  20.02  rte_flow_dev_dump, to dump the internal flow representation

Neither has changed since it was added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 2 ++
 lib/ethdev/rte_ethdev.c                | 2 +-
 lib/ethdev/rte_ethdev.h                | 4 ----
 lib/ethdev/rte_flow.c                  | 2 +-
 lib/ethdev/rte_flow.h                  | 4 ----
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8a60d21a1d..57a47ec5f2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -106,6 +106,8 @@ API Changes
     ``rte_eth_hairpin_bind``,
     ``rte_eth_hairpin_unbind``,
     ``rte_eth_hairpin_get_peer_ports``
+  * clock: ``rte_eth_read_clock``
+  * flow dump: ``rte_flow_dev_dump``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f27f698406..ce1779ba44 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6789,7 +6789,7 @@ rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *timestamp)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_read_clock, 19.08)
+RTE_EXPORT_SYMBOL(rte_eth_read_clock)
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 33ec81792d..7905e01658 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5588,9 +5588,6 @@ int rte_eth_timesync_read_time(uint16_t port_id, struct timespec *time);
 int rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *time);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Read the current clock counter of an Ethernet device
  *
  * This returns the current raw clock value of an Ethernet device. It is
@@ -5632,7 +5629,6 @@ int rte_eth_timesync_write_time(uint16_t port_id, const struct timespec *time);
  *   - -ENOTSUP: The function is not supported by the Ethernet driver.
  *   - -EINVAL: if bad parameter.
  */
-__rte_experimental
 int
 rte_eth_read_clock(uint16_t port_id, uint64_t *clock);
 
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index db4eb515f3..827305385f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1246,7 +1246,7 @@ rte_flow_copy(struct rte_flow_desc *desc, size_t len,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dev_dump, 20.02)
+RTE_EXPORT_SYMBOL(rte_flow_dev_dump)
 int
 rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 			FILE *file, struct rte_flow_error *error)
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index 1b247a36c9..15ad58f699 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4559,9 +4559,6 @@ enum rte_flow_conv_op {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Dump hardware internal representation information of
  * rte flow to file.
  *
@@ -4577,7 +4574,6 @@ enum rte_flow_conv_op {
  * @return
  *   0 on success, a negative value otherwise.
  */
-__rte_experimental
 int
 rte_flow_dev_dump(uint16_t port_id, struct rte_flow *flow,
 		FILE *file, struct rte_flow_error *error);
-- 
2.53.0

