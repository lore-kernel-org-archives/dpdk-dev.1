Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3121BC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 20:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53E3E4025A;
	Wed, 14 Oct 2026 22:34:47 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5B26F4013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 22:34:45 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id DE1421D00066
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:34:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 14 Oct 2026 16:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1792010084; x=1792096484; bh=b6uQE//99teQr093jqY5Q
 +Mug2UxYhk4NQ/B/XBhJeU=; b=FhcaN0dFfC0K/PqxkhM6bse5VpAHpLzbuPikH
 ABZ8LML/lTsx90pk2u19E3DyP90FpyU53bL6B/wcg7hkmYfXkFl6wVQZLriWRA8c
 Idn32A38ck35QrKW6l95qEYVrfCa5t382RnaS8QPOz3zGruwlM/Ao0s9hutzAiGI
 eF+T/38oXZV7FqT+bzb6uwV28VbvPFBablcWBvAHZskRseebCjYFhw4hyJncX6YD
 2ypjizegjaX3wh7rR/CJPgjF9yzQkNtDGFvNqQWTGiu8/LwGIr/hfW2L0KBRRsZY
 4xh4wxltyQ2sOW0hYOb1rzGO4z+9NJQl66Pd9jiCQ4h73Rlsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792010084; x=1792096484; bh=b6uQE//99teQr093jqY5Q+Mug2UxYhk4NQ/
 B/XBhJeU=; b=x+Gay8ipj3Wk2J3xhAxVo4um2tsvlaGExWlM8vsMVuoqNexsngz
 ebaSJA1fu72ijLKd+7OidoliAytgqKObOpKBPpSaAKdpqS48wIQ06/qzhMYjCnKf
 F6A5FNUfX9XlM04CIsXs1vVZ8eX/TQi4+P9Dnyb8cpkwLBDL3YsjOIwE0ep+iMcT
 n7hITrsyIeeM1PU6aEVLeBRBw91zhFIvcYP5k5OxJJOYK2yKn4pjuTMdXYv0ruxV
 1vmuKCxtqLHeb+/jFuQ+CuZQDQqU4oOT76ga8KFLrehiRAvZKsNge04THiru+eqb
 MlxNndsZokdr4PUdYGLieEggihqY6hOx2mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792010084; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:k5qIzHUr9lF1cJonAlXYNAgWPGAyFJWqsF3AJYW/eFMQ2bt
 lFm3XK0SYh4oWZO1Z6fT5pEZVelPFT+sqeTMRhEwvclcl+eqFLei/37NumiERZeM
 FHJ+qTodoZLWfhjbBch+m/+uvOmUKtqBTc2/oTHVqLDqtksqa8GzmQJKqLYbik/W
 YWc7mDQWz6U/xbtp2E6AdTdN924S4YnJ6tJNP3DJKdIId+nO783rT9qlRGSqBeet
 cR+7m3Tj9gmc9B5SLEHn+fTB3Z0xPfUGOnAij8uq01QGBpBdK/V/eSzaop1E5wpl
 5lg4/LDGzhSMcmznebT/y1ez6nw1tbIw+rSQOZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:XFfmXh5ony7c3LIdnJQxShZjuwddtHnyDRiV2oMdAUE=:di0Mzsfm38m122/VQbsNdupkMqQea8bwksNuNxFwk1o=;
X-ME-Sender: <xms:ZOfPauFcSmBbxMlqMNu7ke5Yvfp4JtNuzSKUbQzidkhUhpk12Ni16w>
 <xme:ZOfPajqdHypDRmdARcNkWdMkwxidV1srmRQTHn7qB2KfYG69mAgod6DX-TCDl3-Gl
 TaQqb0u9BcgSVegCayrpLwgkvHYPkz2v-QjZMnCvOmjVppYmmXwVIk>
X-ME-Received: <xmr:ZOfPanTAxG_mqwTWwHJkuUP7C7uloZNUQeFiQv3V7Klr6-j5UOFbHeW22REa-hQ_TpAJ1tzeJddPAHu_XkBNr9cGHfz2>
X-ME-Proxy-Cause: dmFkZTGDuilSxD8v6ZYfaFgXiMgPqam5gGrMdTA5bqAWB4VQjAYHhWIW5+xAgcdVjLETPU
 wS2yen6shPHQiQGC76ux7vICmqxRand+BI7wDF17jSHEf9IuNmgCvUYMI3go0/x+fG3UfZ
 SsX1mtnMc7/kaiTp1aAtrmuEyfB7RdM87Js9tmBGhlw7Aa5ipI+31x2LgK8y5/ytmFBkNp
 1YeY9WVH17Z4n6phbRYqmHtvI0X9lTSmnaP0Rw+8ISrWaYMH9QkGXMbtDTq/fPMS4Vc3mM
 ZM97pgz6bbRCT1bQ2J+Gk6psp+iuq7jd0sS4pukd1ShOkn+vaqy8vcD0/dTgo1Hrb/2YSX
 1KTHBNtpyzh7j/j7XnBci9aP8xFhspztmJw+z1mb2hQtfOqlswmB3qKBsWpfcWguuNppYL
 xxPAWF+MWCMGw5nOyNJEkx82cb087/WgtQpfXfgV6PHBHyzdmZyBBI66IHNQ5yDOYxzTqp
 h4vaql2PCM8C4Of3WsFgZuv0CMDRm4S5EqYuRUtcAFGSwPFlEKrAqUJk1FHJDVZY8mf1st
 RpwcqSCuNYvOgmyd/qPQEoTSEg24zfu4Wt4j5iJh9YZ+3n8R2deBd5G7KxWOI9/veqbTgb
 Op1EWNbgoBTN/PzJXmq6JZKjgn78ixIlXYT/o+JmFmuYlzmybr997exfhwUQ
X-ME-Proxy: <xmx:ZOfPagMhcBBNVrMozIgv38nUfCqzs0eBsMq63ETOXfKnalSFiVXylQ>
 <xmx:ZOfPaqPIqPoIfb0i5ZwDpjVDXqsmgDXgWDdNJtDcJb658rpiWUER2g>
 <xmx:ZOfPagtjLpdYJylNs5AcirVUKvzhHv99XSXqkfw6F5K-pSnbFdaJ7w>
 <xmx:ZOfPakWJQU7EVjv3ka--_uuBo0U1W1xf3i3SRnwnAckQt_OaMN29VQ>
 <xmx:ZOfPah1IfIKqcDcYKcb6nyP3WReqsaOw8lNb1pOkTd5M79nFaLJZBE1U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 16:34:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/ixgbe: avoid private driver include in testpmd
Date: Wed, 14 Oct 2026 22:34:34 +0200
Message-ID: <20261014203435.583064-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
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

Testpmd commands should use the driver's public API
rather than access its private structures directly.
Note: ixgbe_testpmd.c should be considered as part of testpmd.

ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
operations are available through the private adapter structure.

Rely on the public bypass API to check availability
and handle -ENOTSUP in the commands.
Remove ixgbe_ethdev.h, ethdev_driver.h
and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/intel/ixgbe/ixgbe_testpmd.c | 55 ++++++++++---------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_testpmd.c b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
index e0d161eafe..e209093477 100644
--- a/drivers/net/intel/ixgbe/ixgbe_testpmd.c
+++ b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
@@ -2,11 +2,12 @@
  * Copyright(c) 2010-2016 Intel Corporation.
  */
 
-/* Required for ixgbe internal structures to be aligned with the driver */
-#define RTE_LIBRTE_IXGBE_BYPASS
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
-#include <ethdev_driver.h>
-#include "ixgbe_ethdev.h"
+#include <rte_string_fns.h>
 #include "rte_pmd_ixgbe.h"
 
 #include <cmdline_parse_etheraddr.h>
@@ -621,20 +622,6 @@ static cmdline_parse_inst_t cmd_tc_min_bw = {
 /* The NIC bypass watchdog timeout. */
 uint32_t bypass_timeout = RTE_PMD_IXGBE_BYPASS_TMT_OFF;
 
-static inline bool
-check_bypass_enabled(portid_t port_id)
-{
-	struct ixgbe_adapter *adapter;
-
-	adapter = rte_eth_devices[port_id].data->dev_private;
-	if (adapter->bps.ops.bypass_rw == NULL) {
-		fprintf(stderr, "Bypass is not enabled on this port.\n");
-		return false;
-	}
-
-	return true;
-}
-
 /* Enable bypass mode */
 struct cmd_config_bypass_result {
 	cmdline_fixed_string_t port;
@@ -704,9 +691,6 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
 	portid_t port_id = res->port_id;
 	int32_t rc = -EINVAL;
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	if (!strcmp(res->value, "bypass"))
 		bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_BYPASS;
 	else if (!strcmp(res->value, "isolate"))
@@ -716,7 +700,9 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
 
 	/* Set the bypass mode for the relevant port. */
 	rc = rte_pmd_ixgbe_bypass_state_set(port_id, &bypass_mode);
-	if (rc != 0)
+	if (rc == -ENOTSUP)
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+	else if (rc != 0)
 		fprintf(stderr, "\t Failed to set bypass mode for port = %d.\n",
 			port_id);
 }
@@ -773,9 +759,6 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 	uint32_t bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_NONE;
 	uint32_t bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_NORMAL;
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	if (!strcmp(res->event_value, "timeout"))
 		bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_TIMEOUT;
 	else if (!strcmp(res->event_value, "os_on"))
@@ -803,6 +786,10 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 			rc = rte_pmd_ixgbe_bypass_wd_timeout_store(port_id,
 				bypass_timeout);
 		}
+		if (rc == -ENOTSUP) {
+			fprintf(stderr, "Bypass is not enabled on this port.\n");
+			return;
+		}
 		if (rc != 0) {
 			fprintf(stderr,
 				"Failed to set timeout value %u for port %d, errto code: %d.\n",
@@ -813,7 +800,9 @@ cmd_set_bypass_event_parsed(void *parsed_result,
 	/* Set the bypass event to transition to bypass mode. */
 	rc = rte_pmd_ixgbe_bypass_event_store(port_id, bypass_event,
 		bypass_mode);
-	if (rc != 0)
+	if (rc == -ENOTSUP)
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+	else if (rc != 0)
 		fprintf(stderr, "\t Failed to set bypass event for port = %d.\n",
 			port_id);
 }
@@ -952,11 +941,13 @@ cmd_show_bypass_config_parsed(void *parsed_result,
 		"power supply off",
 		"timeout"};
 
-	if (!check_bypass_enabled(port_id))
-		return;
-
 	/* Display the bypass mode.*/
-	if (rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode) != 0) {
+	rc = rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode);
+	if (rc == -ENOTSUP) {
+		fprintf(stderr, "Bypass is not enabled on this port.\n");
+		return;
+	}
+	if (rc != 0) {
 		fprintf(stderr, "\tFailed to get bypass mode for port = %d\n",
 			port_id);
 		return;
@@ -985,10 +976,6 @@ cmd_show_bypass_config_parsed(void *parsed_result,
 				modes[event_mode]);
 		}
 	}
-	if (rc != 0)
-		fprintf(stderr,
-			"\tFailed to get bypass configuration for port = %d\n",
-			port_id);
 }
 
 static cmdline_parse_token_string_t cmd_showbypass_config_show =
-- 
2.55.0

