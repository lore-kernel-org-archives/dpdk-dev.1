Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1D606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pM8Zj945
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 600CD4067B;
	Wed, 28 Oct 2026 15:17:59 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 6C4FD402DC
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:17:56 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e9f6a16aedso6693325ad.2
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793197075;
 x=1793801875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5xRXofaK7NSJa7qVEpbGkynT4mf7M/fYWWFAMXXcv5g=;
 b=pM8Zj945qNaLNNCBjo1JnyknMuul2qOEUIVAuZWF/vy9BXSn8/gWsB9E1boLXY0q7R
 617IDESQIseys0gY0LoulOsXjQKIwHJsiiSoy7ShGq7Y2vaDDQ8w0WlQdaj7l9T/QGgM
 +Dk9Y8q5vW0JF/y5Yn9XiJe4UEsKaVefL5PTAvVI5a0kBKltoedMStqJIBtzklN0xjyw
 obAk7ZVJorpnLFWL5nxsw8Gs/GmzdTC6D7CxIzzlIZLKu8hzwBH6gllXKCSkrIc2zVs8
 heWQYczTb5avO4Hos/D0IE4JazKN1+7vkp6/mWU/AkKkBQhdK3APDTpcAtjz/edsLnHv
 xhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197075; x=1793801875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5xRXofaK7NSJa7qVEpbGkynT4mf7M/fYWWFAMXXcv5g=;
 b=O28jzl5PBzcriDriGuTcdSHxn0CPj7d4atll+AhrjJHEzlfBRKzVE39/iM1gmOngmF
 sXempgJ8t3Vs10xZqixIjxsG5aQa9tjBDdv3FYtHktLJ8Memhd8Am5eDktW7I0KxzNMn
 bax2fAnV8qK51ZoMEPtYboYJ22Cj0MFoaXr23h20l0pe52W0yoaWa2n3/sb2EhxIxV9/
 GCLNlzc5fSN/gtcPtlbPWFqsyHi0rGeV1hj1bFf4Ut9PY4OOMeBTJTSwGLaMqgkRA8gH
 ZPiyYP1NWeWZXKBPjmZm0Zl7hWF8FL5Kbk/Hwr7yp/Lyjt9zlgV5hwbHHSBb7KVXbggj
 BKCw==
X-Gm-Message-State: AFq9FYJn2r6FX0ebEAqf0DlRyigi8C8KYe84HWR0HFs+XyP/novN6l9B
 PQJp75Fs2X9Z8n/zACSdpjYbmIChEs5VXxperasUBa70HHzd5/d9ChyQU84AfGSEaZLxnE854sn
 6o73fTds=
X-Gm-Gg: AYBFou0ev+Qh0wC6lxAKZsxAU4ApCeJ9ElEjHeVG+gscLxd318xHB32sV8qaXgjn7YM
 bnN4JQGmPmW8pNfaYY4Rt8F6y93aviPPm6C8Wn4w0u7kQkm28pdQSVBGI+pCIdbl9aFJWLgPs6T
 xRl5uJfTA8WefMSlXE37h3doq34/ZaxD5RMQV1J8sNRCbQJ/NzFIyi58/JXgqyZafrv6C13c3y7
 v7xE9gAUJnLOu44XnoqVbSMtr2FevM7HUZeA9W3IJfaD/n5kZjPf3TTV4SE1y0B+iDamqDHTSKh
 YxHqJUupYNJSKoNKv/tjw6Fnh0K5xX5qBOeljL6Qo8eyQAkEGukVDig+wlNkzGJGoJCWbPLcGAb
 ojTG1CU9Jp7DuA2Gn6V5EK0In/o8hBBOZVMnbHziCgi5zo+q/C5mueaSlWYrJ92oRY2e7rRQqWV
 ueCmu0IuTY2fJxSE82Z96M+6CXpsi6G/WyM1BOXAgOr+Y2vDw0FkUVYC4f+3DtOrTqN8hzsGVUj
 3lVFk7QfcV+GjLVFGrlVuznMYYkUw49kUS2lK/FHEpxe8g0Gd7doQRBHcdxUW1rzguOwUBMaAr4
 jBSxivJ94uhXn0vCy3tbSOUn2UuOd97uGzexvI1EtWGP/a7FdUeqvjKN7Hv41z8ttn14
X-Received: by 2002:a17:902:d50a:b0:2ea:1016:27fb with SMTP id
 d9443c01a7336-2eb003ffe7dmr23407825ad.13.1793197074933; 
 Wed, 28 Oct 2026 07:17:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3b67bsm22182415ad.52.2026.10.28.07.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ori Kam <orika@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 3/4] pdump: skip hairpin queues
Date: Wed, 28 Oct 2026 07:16:52 -0700
Message-ID: <20261028141750.310963-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141750.310963-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When capturing on all queues, pdump walks nb_rx_queues and
nb_tx_queues, which include hairpin queues. Adding a Tx callback
to a hairpin queue fails, so capture could not be enabled on any
port with hairpin queues configured.

Skip hairpin queues when capturing all queues, and reject an
explicit request for a hairpin queue.

Fixes: cf5516696d77 ("ethdev: add hairpin queue")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 9c368bcfd7..3261876d29 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -8,6 +8,7 @@
 #include <rte_alarm.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <ethdev_driver.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memzone.h>
@@ -263,6 +264,16 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
 
+		/* hairpin queues do not pass through rx burst */
+		if (rte_eth_dev_is_rx_hairpin_queue(&rte_eth_devices[port], qid)) {
+			if (queue == RTE_PDUMP_ALL_QUEUES)
+				continue;
+			PDUMP_LOG_LINE(ERR,
+				"cannot capture on hairpin rx queue port=%d queue=%d",
+				port, qid);
+			return -EINVAL;
+		}
+
 		if (operation == ENABLE) {
 			if (cbs->cb) {
 				PDUMP_LOG_LINE(ERR,
@@ -325,6 +336,16 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
 
+		/* hairpin queues do not pass through tx burst */
+		if (rte_eth_dev_is_tx_hairpin_queue(&rte_eth_devices[port], qid)) {
+			if (queue == RTE_PDUMP_ALL_QUEUES)
+				continue;
+			PDUMP_LOG_LINE(ERR,
+				"cannot capture on hairpin tx queue port=%d queue=%d",
+				port, qid);
+			return -EINVAL;
+		}
+
 		if (operation == ENABLE) {
 			if (cbs->cb) {
 				PDUMP_LOG_LINE(ERR,
-- 
2.53.0

