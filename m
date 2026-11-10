Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4429606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6LkSptc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB7140E36;
	Thu, 12 Nov 2026 09:07:39 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 971004026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 18:18:00 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c505186727fso127953766b.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794331080; x=1794935880; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xf+8LkdF9Evg3VQ2rU0feNhtm99aKMa7E3/cYFyLyNg=;
 b=F6LkSptcrUWAhz+F6n/Fefbo1gAdDYcoDuVvTrAC2xb5+2qlF9GrJdaFu63Ofosk3e
 Z2QDdGVhf6OOVrY2m5pzQrpmnlcilQV9Ixb9LKIFBXfjHVhNCH4BJ5HjlbAB0eZuDgfd
 Y9EtnzWoHCxrZZKhl/Tj9cDAUIcEsPh0gUysCLEOUjX2+kFNQEY9+cQQE6rXFNpqdjeI
 CpeICUtOIA2VHToCqrPAA8i2+U0y099MbObeYErDNBlrkjhlAnBtkoxEr498ZCED2Qkd
 116jObUy+2IDNsZn4PR8SrsmgwNQq7P/VrV0JssZ02FcmTbCViA2oigs4bqcxt8SFH8F
 VDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794331080; x=1794935880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xf+8LkdF9Evg3VQ2rU0feNhtm99aKMa7E3/cYFyLyNg=;
 b=o/5w4dZNvhiVvEST3KJ6p6SbccHrXZQOE9H4CuhjNAqZxoHIO5/LFH5Dx4pP2Urv90
 CvOV+/7BpsLrSVfSpwJTbVil6XYSMhuK16+g4/TMhnTdgJFxuI7w0ueCK+uudfzn8EQQ
 iZD9heYtosCuY4y2iP9plye+n3gLhrnM/eD+7vDgIm6/e1Ew0Zsw67Ir8HmXlwgHtvMn
 AbYLN6Ew1vSRzg2jl/k2Hi86ZHgTuyZJLQD0Eg7uIvY8PT1Y8PINJ/q2nsIJ+o7kLEW4
 RhGnjC4zrnr9H/DmeHePRVU0LiFqPh+JTmE8WFWUYnlSE4EZ0t3Zv9S6go20khXtUyBy
 eH4A==
X-Gm-Message-State: APuU4Z9Dmu8kkpA8i2LwtT18nHODH7uk4PmZLNapNEh2qEehVVuNsPNh
 AOXyh9bhfPBTR/JE0pRUFIQHdlmDLNVqkp1MoD/5P1X9bRaUZPJyicNu
X-Gm-Gg: AYBFou2SN1dPs8ao2AtW47uZHLTfz6YuIhRGg6WKenJ4N9PLlcnbwPSvJytgDp1Rtdj
 OHpRkykNZw8EQY5bSdowCdr9oWr41zOy4+9Q4Wjtea8fG47nptyWqlCrfcHxVz91wx6R7SiR0ai
 Oxghh0txMBQS/WctKiU2q9v1nyIg/0L/GC85NWElKrC/E8v1qeYwjrNmYbxUamzXTJ9X4fJJ5Q4
 di6a44sJAInJea5R0jU9dt7JS5FrXhlkKl6w7N8SN4nWmemgHmIouv3ZLTD3jglzZm5ymEansCM
 hbtTuDc5xAWv4vgxkZADwxSLqz73muB8YXGQutRYoe69PHI0I586q5fGbLxWTZcRj1X6I8RJGuE
 kkp2hFhVjTPvuMZ7j/pmxFVShtkIxxR2Uw8HXXN5ZDiCmViUsOsPHUTJRy4KdcDgodv5pW2zbOc
 No0NLvFVfxqCfhmwXFAHbFa7CK4ApWXrnHq+jIX5LEb7YwVKFnhPygpZKh3NRMdBJh+0ekUCSfj
 HDsAU1UYv6W0zL8v2Hjsee/sz8eU0dkQQFSNaeNeQ+iF7tcWvvDSjnz0vyRsH9eVFC21a9buaNr
 svWcUuNz9I3sMzyTlGaOw43fxnOybic4cr8lbiwipfeyQUE2rbym+BacWW5AiEvh3p4Vgx4KFF3
 VZrjmhZCJ
X-Received: by 2002:a17:906:7947:b0:c41:b4e4:7958 with SMTP id
 a640c23a62f3a-c5048c75ebdmr285952966b.0.1794331079873; 
 Tue, 10 Nov 2026 09:17:59 -0800 (PST)
Received: from mpeim-l-pw0j0p1n.cisco.com ([2603:5004:80:204::351f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a596d7dsm134982166b.42.2026.11.10.09.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:17:59 -0800 (PST)
From: Maxime Peim <maxime.peim@gmail.com>
To: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: [PATCH] net/mlx5/hws: fix completion polling for full queues
Date: Tue, 10 Nov 2026 18:17:39 +0100
Message-ID: <20261110171739.3917219-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 09:07:37 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The software completion ring masks its producer and consumer counters
when advancing them. When all entries are filled before any completion
is polled, the counters become equal and the ring is treated as empty.
Root-table rule operations generate completions directly into this ring,
so a full batch cannot be dequeued and the queue remains busy.

Keep the counters unmasked and apply the ring mask only when accessing
the completion array. This distinguishes a full ring from an empty one
without reducing the configured queue capacity.

The power-of-two ring capacity divides the 16-bit counter modulus, so
counter wrap preserves masked indices. Capacity also bounds outstanding
completions below that modulus, keeping full distinct from empty.

Fixes: 3eb748869d2d ("net/mlx5/hws: add send layer")
Cc: stable@dpdk.org

Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
 drivers/net/mlx5/hws/mlx5dr_send.c |  8 +++++---
 drivers/net/mlx5/hws/mlx5dr_send.h | 13 ++++++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_send.c b/drivers/net/mlx5/hws/mlx5dr_send.c
index 85f613ed39..f94957dd27 100644
--- a/drivers/net/mlx5/hws/mlx5dr_send.c
+++ b/drivers/net/mlx5/hws/mlx5dr_send.c
@@ -646,12 +646,14 @@ static void mlx5dr_send_engine_poll_list(struct mlx5dr_send_engine *queue,
 
 	while (comp->ci != comp->pi) {
 		if (*polled < res_nb) {
+			uint16_t idx = comp->ci & comp->mask;
+
 			res[*polled].status =
-				comp->entries[comp->ci].status;
+				comp->entries[idx].status;
 			res[*polled].user_data =
-				comp->entries[comp->ci].user_data;
+				comp->entries[idx].user_data;
 			(*polled)++;
-			comp->ci = (comp->ci + 1) & comp->mask;
+			comp->ci++;
 			mlx5dr_send_engine_dec_rule(queue);
 		} else {
 			return;
diff --git a/drivers/net/mlx5/hws/mlx5dr_send.h b/drivers/net/mlx5/hws/mlx5dr_send.h
index 9209754136..ad2488dca2 100644
--- a/drivers/net/mlx5/hws/mlx5dr_send.h
+++ b/drivers/net/mlx5/hws/mlx5dr_send.h
@@ -138,6 +138,12 @@ struct mlx5dr_completed_poll_entry {
 
 struct mlx5dr_completed_poll {
 	struct mlx5dr_completed_poll_entry *entries;
+	/*
+	 * Keep counters unmasked to distinguish full from empty, and mask
+	 * only when indexing entries. The power-of-two capacity divides 2^16,
+	 * so uint16_t wrap preserves masked indices. Capacity is less than
+	 * 2^16 and bounds outstanding completions, so equal counters mean empty.
+	 */
 	uint16_t ci;
 	uint16_t pi;
 	uint16_t mask;
@@ -279,11 +285,12 @@ static inline void mlx5dr_send_engine_gen_comp(struct mlx5dr_send_engine *queue,
 					       int comp_status)
 {
 	struct mlx5dr_completed_poll *comp = &queue->completed;
+	uint16_t idx = comp->pi & comp->mask;
 
-	comp->entries[comp->pi].status = comp_status;
-	comp->entries[comp->pi].user_data = user_data;
+	comp->entries[idx].status = comp_status;
+	comp->entries[idx].user_data = user_data;
 
-	comp->pi = (comp->pi + 1) & comp->mask;
+	comp->pi++;
 }
 
 static inline bool mlx5dr_send_engine_err(struct mlx5dr_send_engine *queue)
