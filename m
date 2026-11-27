Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EEC606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QI4/be8J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13B4E40696;
	Fri, 27 Nov 2026 22:08:21 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTPS id E560D40615
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:15 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cddac941ed1so3837114a12.2
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813694;
 x=1796418494; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJJJpHJaC9hQQ3WLoIe8I5Y8RFRIMhENKzA7dlQHWz4=;
 b=QI4/be8JkNdr9KRZK4aLdvi83Q6MvtJmakJhk+ONkgU/dr1CvgXlvTparTsPfaeaKd
 8CH58Cj1C8lKf1zQ0QPjJinAFffwu8wk/9pc1gKHN/kr2BXoSIhrAMSABqQsKfyEmNqU
 dW/hvFuFiWnckX2lkn651bmuC2Csxg1iXuWCQVX5EaFA5AUOpVRo5q9HS46AkqHclBrV
 NF8BzwgEtVYizIZoIdCmev/VE9ahD5suDYXhmWrj6OW7838DrKF0mdW5hzxSbjKI2I8R
 k/ZKScf7ei9ivOhmsifMhRyCI8myW61nnNTPyS2f4CIM70V5ZY51SsOdVI456hN1uuSX
 ouQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813694; x=1796418494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJJJpHJaC9hQQ3WLoIe8I5Y8RFRIMhENKzA7dlQHWz4=;
 b=1BvdiiTNR+Cm7ZVGCJ68zj5MUJVt53v2/sHOflLt8QdwmPVcgOiIGVogS0eNcd4255
 1X+aL8AQL/xYyZR8Jl6MTAg1Y0n/S0DnaGCXm9R1A3AlyQyz8OZGPIJF2JIBrKwZEXNy
 YYimenFSU1titA5JslulAyAB+DmcjG0ialZ5GqhLLnWFUBdWOCAA7PQcoq92kEMLviQO
 zYh61XlujWAr1xOKo5fW6VGsaHM7VIqTRk0bzfiLUbx8xVcuH9MwszeWWGKAqIWfa4UI
 M8t5QtHcepMkfzYlff/GsxCMUOo5hXLMkn1ozsoQowaPDO2zXD/rBHZzGIoLrzPjJQaD
 pwYA==
X-Gm-Message-State: APuU4Z8lyQ3guaiDUKMtD8FH3gWjCMXN5ReZig1WDZYVa6rFIyiTIntC
 FE+7pcHT/g6QP9EokY3JjT00uJk++m3jnpoCwnls+2Tsfay1uOHjrfAZeJy7Cv3aMcxgeM66UJ9
 7vJWHVqM=
X-Gm-Gg: AZFdTZcbr+Rh4bCplFEWWxOQ38idlYjGV7VcgdxY+V3I6nMpdiyhuksooquoDlATA6N
 osWaG/aaeZWRuKzUXYGbUG/rs5RsMFqxQz/qf2Cm3jZqKMFCJMmVmxzTP+AHZ74psY2k2TdouZM
 1dgwqoMnglCbgdrgsZNuj2bgAF6u/yORCJYJSfLN2xB1z4bmOu6u9YXekKlwiM2ICQk4i6sQvis
 xZXJnM30Hl50UkyXh8+MHcfKkivXMKFoCAp+mieJHayOr6dd2+W7MID8LBCz5v4jYtjVz2LzUj9
 IsoXGmPHXwME8CeHldEhlAatNwKG1mZ3U4FRX8akrYlOXaB5XB5f1x7eTxJwX84vluROrb3rSW8
 LDl/R8+M42Q0l9HHbGz/KwVAaj+rMfa+tAsu44vU/LPn1dwzmbc/SwCxBD1WItFq9fuujVx1UjS
 /yOVap8Wh9GGG8nWax+nAIlCnBKmhoMXCffjWlUww/yVHwgj1FykUB5eYOdfcFtuv2tsUlF5eYg
 eZuaWsM8rZoHjqyY8PVCHSy3gFy12U+jIuhWYpQM7iNZ4lYrf+Lxdg1+KJSVSZEAA+P/hqKFPYO
 rgcjibtcP1Pq2r7JztmuCbDBBcOTQ+nN0V3tTbi6MQIFD9wnW9Xlh8apHATGeyknSNi+
X-Received: by 2002:a17:90b:4ac5:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3b41c8e16e3mr21538981a91.16.1795813694267; 
 Fri, 27 Nov 2026 13:08:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 5/6] pdump: report secondary process failures
Date: Fri, 27 Nov 2026 13:07:07 -0800
Message-ID: <20261127210806.318387-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127210806.318387-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
 <20261127210806.318387-1-stephen@networkplumber.org>
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

The primary broadcasts an enable to every secondary but ignored the
replies, so a secondary that could not install its callbacks only
logged the error. The client was told the enable succeeded and had
no reason to clean up.

Return the first error from the replies. Disable the processes that
did enable, so a failed request leaves nothing holding the ring.

Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 44 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 670ed1bb6a..7472b008e3 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -569,12 +569,13 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 	return ret;
 }
 
-static void
+static int
 pdump_request_to_secondary(const struct pdump_request *req)
 {
 	struct rte_mp_msg mp_req = { };
 	struct rte_mp_reply mp_reply;
 	struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
+	int ret = 0, i;
 
 	PDUMP_LOG_LINE(DEBUG, "forward req %s to secondary", pdump_opname(req->op));
 
@@ -582,14 +583,34 @@ pdump_request_to_secondary(const struct pdump_request *req)
 	strlcpy(mp_req.name, PDUMP_MP, sizeof(mp_req.name));
 	mp_req.len_param = sizeof(*req);
 
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0)
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0) {
 		PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed");
+		return -rte_errno;
+	}
 
-	else if (mp_reply.nb_sent != mp_reply.nb_received)
+	if (mp_reply.nb_sent != mp_reply.nb_received) {
 		PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u recv %u)",
 			       mp_reply.nb_sent, mp_reply.nb_received);
+		ret = -ETIMEDOUT;
+	}
+
+	/* Report the first failure, a secondary has already undone its own */
+	for (i = 0; i < mp_reply.nb_received; i++) {
+		const struct pdump_response *resp =
+			(const struct pdump_response *)mp_reply.msgs[i].param;
+
+		if (resp->err_value != 0) {
+			PDUMP_LOG_LINE(ERR, "secondary failed to %s: %s",
+				       pdump_opname(req->op),
+				       rte_strerror(-resp->err_value));
+			if (ret == 0)
+				ret = resp->err_value;
+		}
+	}
 
 	free(mp_reply.msgs);
+
+	return ret;
 }
 
 /* Allocate temporary storage for passing state to the alarm thread for deferred handling */
@@ -668,10 +689,23 @@ __pdump_request(void *param)
 	PDUMP_LOG_LINE(DEBUG, "primary pdump %s", pdump_opname(req->op));
 
 	ret = set_pdump_rxtx_cbs(req);
+	if (ret != 0)
+		goto respond;
 
 	/* Primary process is responsible for broadcasting request to all secondaries */
-	if (ret == 0)
-		pdump_request_to_secondary(req);
+	ret = pdump_request_to_secondary(req);
+
+	/* Undo the processes that did enable, disable ignores the rest */
+	if (ret != 0 && req->op == ENABLE) {
+		struct pdump_request undo = *req;
+
+		undo.op = DISABLE;
+		undo.prm = NULL;	/* no filter needed to remove callbacks */
+		set_pdump_rxtx_cbs(&undo);
+		pdump_request_to_secondary(&undo);
+	}
+
+respond:
 
 	pdump_send_response(req, ret, bundle->peer);
 	free(bundle);
-- 
2.53.0

