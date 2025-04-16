Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B6C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AB640EDD;
	Wed, 16 Apr 2025 16:00:38 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 917D440E4F
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D8723E11BF;
 Wed, 16 Apr 2025 18:00:32 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D8723E11BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812033;
 bh=RLtZXehrtqjP1D1ttomX6XWM+iSAXnc9x0legEMz/8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PeMbLutojI0ut/We6kL6Yfhuo3rnEFER3XQeIOTwuwaPAkMQToBaq3mL/LRmWh5FB
 BRB1W050qRJ5H7mX/M/d9WcCLkq5oUxI0K7IbY7K5e3BnT2IN5QvZzixqOxoltqiR+
 23j556OCTf2vtTdNa7yA+Jnlp08XBljUSJCfh9XjezxfMxJvuLWIeP6N7XKECTPoyg
 dVpN+iB8bqXo3thLTanq/Pi8tdi9Jw4bJVik0Lyqzz7WuSXg0dYkMuWH4LPv0ySl2P
 iVVaL7XGislZDKuKuYl0birDdsu2fSDJb1OodDOrN68qdgEi9zYoanW8FB/9jF3kb6
 W3xf2EeHDrbMw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 09/46] common/sfc_efx/base: add Medford4 support to TUNNEL
 module
Date: Wed, 16 Apr 2025 17:59:39 +0400
Message-Id: <20250416140016.36127-10-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Use common EF10 method table for that.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_tunnel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_tunnel.c b/drivers/common/sfc_efx/base/efx_tunnel.c
index d63f9176e4..75968a0b4f 100644
--- a/drivers/common/sfc_efx/base/efx_tunnel.c
+++ b/drivers/common/sfc_efx/base/efx_tunnel.c
@@ -47,7 +47,7 @@
 
 #if EFSYS_OPT_TUNNEL
 
-#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2
+#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4
 static	__checkReturn	boolean_t
 ef10_udp_encap_supported(
 	__in		efx_nic_t *enp);
@@ -59,7 +59,7 @@ ef10_tunnel_reconfigure(
 static			void
 ef10_tunnel_fini(
 	__in		efx_nic_t *enp);
-#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 */
+#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4 */
 
 #if EFSYS_OPT_SIENA || EFSYS_OPT_HUNTINGTON
 static const efx_tunnel_ops_t	__efx_tunnel_dummy_ops = {
@@ -68,12 +68,12 @@ static const efx_tunnel_ops_t	__efx_tunnel_dummy_ops = {
 };
 #endif /* EFSYS_OPT_SIENA || EFSYS_OPT_HUNTINGTON */
 
-#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2
+#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4
 static const efx_tunnel_ops_t	__efx_tunnel_ef10_ops = {
 	ef10_tunnel_reconfigure,	/* eto_reconfigure */
 	ef10_tunnel_fini,		/* eto_fini */
 };
-#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 */
+#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4 */
 
 #if EFSYS_OPT_RIVERHEAD
 static const efx_tunnel_ops_t	__efx_tunnel_rhead_ops = {
@@ -254,6 +254,12 @@ efx_tunnel_init(
 		break;
 #endif /* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		etop = &__efx_tunnel_ef10_ops;
+		break;
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(0);
 		rc = ENOTSUP;
@@ -637,7 +643,7 @@ efx_tunnel_reconfigure(
 	return (rc);
 }
 
-#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2
+#if EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4
 static	__checkReturn		boolean_t
 ef10_udp_encap_supported(
 	__in		efx_nic_t *enp)
@@ -724,6 +730,6 @@ ef10_tunnel_fini(
 		    &resetting);
 	}
 }
-#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 */
+#endif /* EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4 */
 
 #endif /* EFSYS_OPT_TUNNEL */
-- 
2.39.5

