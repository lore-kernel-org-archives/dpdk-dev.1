Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2AECD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C0C140655;
	Tue, 16 Jun 2026 23:07:04 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 6654540289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:02 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13809223fd4so5461676c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644021;
 x=1782248821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGzFd6QqDSrFUsoZld+Dj+mn9sG5gwTlfnu9M9KQw2A=;
 b=iWhV+TJgCvNm8mhmoAzIiGuei+BKn9URbbjw1UnKBuL7FziAJfSzppz1o35EFF/BOz
 5Mc0OcInML4Ii/jPV4jni93cvS7WSO0+JQroECzRPsLH63pQ4wXM9dyEbP1cXVlqOGvn
 26JfJ7wqTeQL+bLseLQhabjJ1iQ2o4C943ScO0xIp+cSBD4yATRTyrWzhk6+UlLzvNzB
 CckUPWsQ7NC+bIrA8eMpQcF6vTxMi21aQaXBxDuqD53KK6wBlOs3gROxHqpFpp4QECEN
 2FbC/3DXO3GesNX//eVghLR11usYTS3o3t+v4jSZcorNkJgNPEEVSDFa9fJxewrEPqEO
 HtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644021; x=1782248821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGzFd6QqDSrFUsoZld+Dj+mn9sG5gwTlfnu9M9KQw2A=;
 b=ccIh+fpF3gkLG8a5JvqBYuzEE1IjG6U0vfkRjdRWjwHpVbsVMwOUEBHgOa5crJw3vx
 U+2KD5Ep/+/l8HD2tNbAKU0Le+IICau/otW9+K9XcES9ATmSRUeDm9Oy178Z6lVkYxI5
 5iAbUGrJthvITkkX7jl7sUe43gzyUdq5Qrw++/i9uhv41lu5jRLVJi5LsFBrtONOV8T7
 ckLHln54jnJzGBa5D5vCQEbH1vb0Aj3ifnwdnAXaVP8S07UycMNShSqk4IzPT4RwORwP
 FjraZTcGDpwjEaxksFWSZoz86fEbb42bVXF+xt7Y4FYUpIsb/c3jaMBzCzBHMaRPBYda
 p+Tw==
X-Gm-Message-State: AOJu0YwW/jo+Lx8WhaYsnXhsrF9MMLvTWuoBnU+NvBc/v1+NgbVJGgVQ
 wkZEC5m/Pe8x/k74u7t7Ug5sK2xBlDjcZWuKSnccW/fRfnhbz8k82lzkhmxTxsmWffxXQSQ1fvI
 QipEB
X-Gm-Gg: Acq92OGWRPhtPkvL9FSMw30Ubq31HyAuWkZSh6C7D1GeY/yenPH8f/79PCPJQai4fHQ
 aaLHT9MXMzeglvMao5Wdz//yRCmBYRBx5miSt/FF919vacON0s4eQylzjK1yy2NyN7QV/mZ2XGB
 /caAL7ZsTqf1da8xFLhO8pDP5lHjTfLQCxpUvCSyAPjYXvE4EU9V0pAMiukgrml/PhHjjd8hQdu
 fuJpAJRFTv/1OP8Y5HlfVvNm5TDPclViF6N+VpToUuodFGIDFtzABGdC2Fi+mnOGhiewjlynIbb
 ljIbUFvJK+o024RZbq67wQF+Tq6vMwVdCK2Ofq3C13Q4vy8qVutrtVqGNCHf485ysJQL8oLr3rZ
 b+qFtd/tiE3egApHDOS7qcqp6sOGTCOYH/ktT5Fd1NE9kHOjN1tZEs8+lG4uCWcgwgXjptTesVT
 w9SpH3RCQLT2uXf1RrQvJZUcO7QWnojA3jaeGOJP2WKMaxDrWVQvCvEVWgjBdLhA==
X-Received: by 2002:a05:7022:2601:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-1398f6cd5e5mr266028c88.21.1781644021352; 
 Tue, 16 Jun 2026 14:07:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:07:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Samyak Jain <samyak.jain@amantyatech.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 1/6] ip_frag: tolerate duplicate fragments
Date: Tue, 16 Jun 2026 14:05:33 -0700
Message-ID: <20260616210656.464062-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
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

The reassembly code tracked only a running byte total and reserved slots
for the first and last fragments, with no check for a fragment
duplicating data already received. A single duplicate could destroy a
recoverable datagram:
 - a duplicate first or last fragment collided with the reserved slot and
   sent the whole entry down the error path, freeing every collected
   fragment;
 - a duplicate intermediate fragment was appended to a new slot, inflating
   frag_size past total_size so reassembly never completed.

RFC 791 reassembly tolerates duplicates: a fragment covering bytes
already present carries no new information. Check for an exact duplicate
(stored fragment with the same offset and length) and drop only that
mbuf, before frag_size is updated, leaving the entry's accounting
unchanged.

Overlapping fragments with differing bounds are a separate issue
addressed in the next patch.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org
Reported-by: Samyak Jain <samyak.jain@amantyatech.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/ip_frag_internal.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 382f42d0e1..9a03ef995a 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -89,7 +89,23 @@ struct rte_mbuf *
 ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr,
 	struct rte_mbuf *mb, uint16_t ofs, uint16_t len, uint16_t more_frags)
 {
-	uint32_t idx;
+	uint32_t i, idx;
+
+	/*
+	 * Discard an exact duplicate fragment. If a previously stored fragment
+	 * already covers the same offset and length, this fragment carries no
+	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
+	 * only this mbuf and keep the reassembly entry intact rather than
+	 * treating it as an error. Fragments overlapping an existing one with
+	 * different bounds are not handled here.
+	 */
+	for (i = 0; i != fp->last_idx; i++) {
+		if (fp->frags[i].mb != NULL && fp->frags[i].ofs == ofs &&
+				fp->frags[i].len == len) {
+			IP_FRAG_MBUF2DR(dr, mb);
+			return NULL;
+		}
+	}
 
 	fp->frag_size += len;
 
-- 
2.53.0

