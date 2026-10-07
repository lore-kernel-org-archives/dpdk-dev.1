Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164ECA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 21:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE7942E63;
	Wed,  7 Oct 2026 23:41:43 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2F0A9427DE
 for <dev@dpdk.org>; Wed,  7 Oct 2026 23:41:39 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e61f017091so4682795ad.1
 for <dev@dpdk.org>; Wed, 07 Oct 2026 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791409298;
 x=1792014098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpYQ6j/6y8kcd58lDNkUPM1VvA03ADLSfATji5njYMU=;
 b=oSj+o3WCiVQD2LkTng9WVuCHA9r4B0xKBbTvCh05VwrPp4s48k86sQqkAfQ/Yh1X4W
 D92VLaLfMHNEIT5jiD4UcaXUYCRM+TvA4n29YVPd3iPbyYpR/PRwIjlmpmCPeG74ZdqI
 xZW9gP18Wsqy54bZywtHQQOhZZ3PPLzix3QZjoqpiwDlngHyzCP5167N2AplhaSkLSOL
 0O4PzolYjOlOCOVF3NFPIoqb1BmpxYYPuvzMm+Cu6foK5GeRsUJrF/WIVs4tG7op3LfQ
 Mh9Imh7gON64A72sZY/G23qvXbd4pNe8VkEKh0/KogDzvzuLBYXtCKTooqMBvNsCyhQK
 3pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791409298; x=1792014098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpYQ6j/6y8kcd58lDNkUPM1VvA03ADLSfATji5njYMU=;
 b=MtVcNVS+IxeBrUDd4TbNx4pomWeSka+2UJ87LmayOSVMuZ+lAneZh/XXABW677Tmxp
 oETssekb08DlS3YeU35tQnRiS8PAVO2kwewG+j76a4OwKSSZCukEKUA2pCpKOT3ogj5T
 wHk3PmPsM0ZrT/NvQ//CSzPUv0JMei/WCq770fv3S4aCKIRHrZpvyLxzPUt9UYXzOVQz
 aCqOxp5sNTIlTbVdBsPfplu8fvJ2MqFdPHkTa87OgF1Wpjz+oV1lxohX4Jqcay2eAU1i
 1ehziqJ9d6Okb+gY4pcWgre9PiP4UOTLoRQvMQBnWXENoalhJ/wSuO22IcJqgg+vWaAm
 az9Q==
X-Gm-Message-State: AFq9FYIvgqVuNyjDFV3GlCho+F8ej3eP8QJNYxpwjHJz1+AyQoXMDGjZ
 PWcEAMUucLu7ioyN5AsKPHWQ0OcCEb4Pwk10nKfHrKTo1WV4OZ1T7mkRy/IJfkEhx2lRjXxNzE7
 Iiu/UH3M=
X-Gm-Gg: AYBFou2EjeO/lK1FmWTSfT0KMU09L+Fej/70mHUHhnFuu1azsD5P7X+ppRRbo87vuTJ
 kAWjwg964XgUaR6flEd/tdAjc9T8y/qzkbctcr2PY1C2oj1c/zW5EzYubewxpI5sa05poZ1j+WH
 6k/6ke6G85EnUmtDCOwnRrYB9wp7z5Km93ogsD5TYRX6MU/4ciBmJhIH9yy1DOn5/EyMsz5Uij3
 U80d6ZXe3fnEnQ0Yj7BA0pcY4gac4iYtRCmgJ0o6b15S7GXmjVhpZLRgqYmHq0eGJ1/vkywZ6py
 i1ocz96MMTIQKCdIfNpyYyZbe2z9Jb8daWDavkUiil9zTpJwWkgrnDxIOl59PMAjdVo+M+Umeeb
 T/n6mLfYd+jegcBmplaQF8IPJLR7c+CD1g4a3TtKQUtH+5+i+wL2aoJJshTDLq/yAseowoaVNtr
 5K3pWDIbT8OBQ+IIYUuEpNWoietQBjZ+nLTtCb3zdeRUU2JlcATDuCFeqHDHt+qLk2gNXcSO19B
 F+mQKY2y5LEMz5NcUxP7+rJi7QEylWHqeUiag==
X-Received: by 2002:a17:903:230d:b0:2e6:1a6c:abcd with SMTP id
 d9443c01a7336-2e61a6cadf9mr20614845ad.3.1791409297094; 
 Wed, 07 Oct 2026 14:41:37 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60484ca89sm16573335ad.57.2026.10.07.14.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:41:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 19/20] pdcp: promote API to stable
Date: Wed,  7 Oct 2026 14:39:49 -0700
Message-ID: <20261007214115.3092715-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007214115.3092715-1-stephen@networkplumber.org>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
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

The PDCP library was added in 23.07 and none of its functions have
changed since. The whole library was experimental, including the inline
packet pre and post process helpers, so there is nothing left to keep
experimental once the symbols are promoted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 lib/pdcp/rte_pdcp.c                    | 10 ++++-----
 lib/pdcp/rte_pdcp.h                    | 29 --------------------------
 lib/pdcp/rte_pdcp_group.h              |  6 ------
 4 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6055c1edee..1fb9251dbf 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -360,6 +360,10 @@ API Changes
   The ``rte_node_*`` control path functions date from 23.07 to 25.07 and
   are used by the graph application and the l3fwd-graph example.
 
+* pdcp: Promoted the whole library API from experimental to stable.
+  The ``rte_pdcp_*`` functions are unchanged since the library was added
+  in 23.07.
+
 * pipeline: Promoted the SWX API from experimental to stable:
   the ``rte_swx_pipeline_*``, ``rte_swx_ctl_*`` and ``rte_swx_ipsec_*``
   functions in pipeline, the ``rte_swx_table_*`` symbols in table and
diff --git a/lib/pdcp/rte_pdcp.c b/lib/pdcp/rte_pdcp.c
index d21df8ab43..4bdb5c9adb 100644
--- a/lib/pdcp/rte_pdcp.c
+++ b/lib/pdcp/rte_pdcp.c
@@ -98,7 +98,7 @@ pdcp_dl_establish(struct rte_pdcp_entity *entity, const struct rte_pdcp_entity_c
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_establish, 23.07)
+RTE_EXPORT_SYMBOL(rte_pdcp_entity_establish)
 struct rte_pdcp_entity *
 rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf)
 {
@@ -199,7 +199,7 @@ pdcp_dl_release(struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_release, 23.07)
+RTE_EXPORT_SYMBOL(rte_pdcp_entity_release)
 int
 rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *out_mb[])
 {
@@ -222,7 +222,7 @@ rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity, struct rte_mbuf *ou
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_entity_suspend, 23.07)
+RTE_EXPORT_SYMBOL(rte_pdcp_entity_suspend)
 int
 rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 			struct rte_mbuf *out_mb[])
@@ -250,7 +250,7 @@ rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 	return nb_out;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_control_pdu_create, 23.07)
+RTE_EXPORT_SYMBOL(rte_pdcp_control_pdu_create)
 struct rte_mbuf *
 rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 			    enum rte_pdcp_ctrl_pdu_type type)
@@ -291,7 +291,7 @@ rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 	return m;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pdcp_t_reordering_expiry_handle, 23.07)
+RTE_EXPORT_SYMBOL(rte_pdcp_t_reordering_expiry_handle)
 uint16_t
 rte_pdcp_t_reordering_expiry_handle(const struct rte_pdcp_entity *entity, struct rte_mbuf *out_mb[])
 {
diff --git a/lib/pdcp/rte_pdcp.h b/lib/pdcp/rte_pdcp.h
index 15fcbf9607..b8aad9f525 100644
--- a/lib/pdcp/rte_pdcp.h
+++ b/lib/pdcp/rte_pdcp.h
@@ -13,7 +13,6 @@
  * A framework for PDCP protocol processing.
  */
 
-#include <rte_compat.h>
 #include <rte_common.h>
 #include <rte_mempool.h>
 #include <rte_pdcp_hdr.h>
@@ -161,9 +160,6 @@ struct rte_pdcp_entity_conf {
 /* >8 End of structure rte_pdcp_entity_conf. */
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * 5.1.1 PDCP entity establishment
  *
  * Establish PDCP entity based on provided input configuration.
@@ -174,14 +170,10 @@ struct rte_pdcp_entity_conf {
  *   - Valid handle if success
  *   - NULL in case of failure. rte_errno will be set to error code.
  */
-__rte_experimental
 struct rte_pdcp_entity *
 rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * 5.1.3 PDCP entity release
  *
  * Release PDCP entity.
@@ -204,15 +196,11 @@ rte_pdcp_entity_establish(const struct rte_pdcp_entity_conf *conf);
  *   - >0: Success and the number of packets returned in out_mb
  *   - <0: Error code in case of failures
  */
-__rte_experimental
 int
 rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity,
 			struct rte_mbuf *out_mb[]);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * 5.1.4 PDCP entity suspend
  *
  * Suspend PDCP entity.
@@ -233,15 +221,11 @@ rte_pdcp_entity_release(struct rte_pdcp_entity *pdcp_entity,
  *   - >0: Success and the number of packets returned in out_mb.
  *   - <0: Error code in case of failures.
  */
-__rte_experimental
 int
 rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
 			struct rte_mbuf *out_mb[]);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Create control PDU packet of the `type` specified. The control PDU packet
  * would be allocated from *rte_pdcp_entity_conf.ctrl_pdu_pool* by lib PDCP.
  *
@@ -253,15 +237,11 @@ rte_pdcp_entity_suspend(struct rte_pdcp_entity *pdcp_entity,
  *   - Control PDU generated, in case of success.
  *   - NULL in case of failure. rte_errno will be set to error code.
  */
-__rte_experimental
 struct rte_mbuf *
 rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
 			    enum rte_pdcp_ctrl_pdu_type type);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * For input mbufs and given PDCP entity pre-process the mbufs and prepare
  * crypto ops that can be enqueued to the cryptodev associated with given
  * session. Only error packets would be moved returned in the input buffer,
@@ -284,7 +264,6 @@ rte_pdcp_control_pdu_create(struct rte_pdcp_entity *pdcp_entity,
  * @return
  *   Count of crypto_ops prepared.
  */
-__rte_experimental
 static inline uint16_t
 rte_pdcp_pkt_pre_process(const struct rte_pdcp_entity *entity,
 			 struct rte_mbuf *mb[], struct rte_crypto_op *cop[],
@@ -294,9 +273,6 @@ rte_pdcp_pkt_pre_process(const struct rte_pdcp_entity *entity,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * For input mbufs and given PDCP entity, perform PDCP post-processing of the mbufs.
  *
  * Input mbufs are the ones retrieved from rte_crypto_ops dequeued from cryptodev
@@ -325,7 +301,6 @@ rte_pdcp_pkt_pre_process(const struct rte_pdcp_entity *entity,
  * @return
  *   Count of packets returned in *out_mb* buffer.
  */
-__rte_experimental
 static inline uint16_t
 rte_pdcp_pkt_post_process(const struct rte_pdcp_entity *entity,
 			  struct rte_mbuf *in_mb[],
@@ -336,9 +311,6 @@ rte_pdcp_pkt_post_process(const struct rte_pdcp_entity *entity,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice
- *
  * 5.2.2.2 Actions when a t-Reordering expires
  *
  * When t-Reordering timer expires, PDCP is required to slide the reception
@@ -358,7 +330,6 @@ rte_pdcp_pkt_post_process(const struct rte_pdcp_entity *entity,
  * @return
  *   Number of packets returned in *out_mb* buffer.
  */
-__rte_experimental
 uint16_t
 rte_pdcp_t_reordering_expiry_handle(const struct rte_pdcp_entity *entity,
 				    struct rte_mbuf *out_mb[]);
diff --git a/lib/pdcp/rte_pdcp_group.h b/lib/pdcp/rte_pdcp_group.h
index f6a94ff587..cbc2111bdf 100644
--- a/lib/pdcp/rte_pdcp_group.h
+++ b/lib/pdcp/rte_pdcp_group.h
@@ -37,9 +37,6 @@ struct rte_pdcp_group {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Take crypto-op as an input and extract pointer to related PDCP entity.
  * @param cop
  *   The address of an input *rte_crypto_op* structure.
@@ -56,9 +53,6 @@ rte_pdcp_en_from_cop(const struct rte_crypto_op *cop)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Take as input completed crypto ops, extract related mbufs and group them by
  * *rte_pdcp_entity* they belong to. Mbuf for which the crypto operation has
  * failed would be flagged using *RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED* flag
-- 
2.53.0

