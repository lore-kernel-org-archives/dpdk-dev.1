Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22454C61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 00:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66FBD42E50;
	Fri, 13 Jun 2025 02:35:56 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id CBB6A42D78
 for <dev@dpdk.org>; Fri, 13 Jun 2025 02:35:54 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7d3939ecb7dso162673585a.3
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749774954;
 x=1750379754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4N9bFSsv5nCs39i+cIRvQBStm+f7CiIGPDoQaPseUk=;
 b=rhrpLlD7UtuBrRei3mRFpOJh/QgzB+qD8vRF7bsT5NKzOHQkqXquzznEnUNl2Ron//
 atCyQ8Grezkz23kYCQuCdf+Q/nUuJXrNhxK4mQICDE8yYJt+P8pQ4ec1ABTt6fUYMOxi
 R0GAFfbNt2DcPeHZkybtIgmGg6TT1bg31Tdww3NmptDkiG+KbNDZJyXcQBPFnsbv2VOY
 0VUyk+4qb1V5XFNZk9yS0okmu3l40NUwJCYiTmVIOzGfz6XYVS+IZjyHRxfWd6PZIOHf
 UCU11juk1tMuLnQjgewxENO/BjSqwfIvReLZLTgy4ZeZYWb7hJ4yfpUbj/HnAPs4WCzs
 Nfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749774954; x=1750379754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4N9bFSsv5nCs39i+cIRvQBStm+f7CiIGPDoQaPseUk=;
 b=dHc1U7vy5lJMb8U7btxCdaeO5pWipd6ca8IiwzG/NgWS56XDSEVSXbyY3DTJBQ+3ml
 5k+R8QZvj/zQJDFFVAQ/rvVwFNqZfVx5XjRTp/NIGZpUdXpZQBbXgYwsPYEv4yHDIuap
 SiZXKmrOubKoLkEUfoCv54xwe2UMJJhMK9pw2+7kw2NLwZ1yKgHdJXAH8M6mP8nizxUe
 MElpknTXdXXwDGtoN8wxnVnATIRpTJLih9hRpXj1IDinE3a2sCr6PoWyMWrkL8SRF7Js
 Z+mcS7GLp8me/fjYeM4x47SEa/aBG5GfFzfWrzobWIPYQPAITXBG22HCejBGCYiOlZ8R
 5aqg==
X-Gm-Message-State: AOJu0YwM7XOnXOa7SrV85FChLVYWuCY9lQvq347gKK6stS+X5dq7ceuY
 xIWwkGZ5cDnH7eObldKy3gof3rDFAdHRiUYuXU8brjixGUMxgx2O68Z8Zg71TK9tvqIVu2B1UgU
 mHM2g
X-Gm-Gg: ASbGncv48i38W3vCqNyPjEsojqWNl/4+LU8OV8hE9ueWAmlo7YtB/HS5kVsZe4+CUM8
 Us2cmSPCVK5XHs+/uEQvjO7ZMQrsLpbxILx+5zqT9s+wnXYUf0xCEAPCY60POW7VNBF9uJaoEmw
 BkWmpXFMzKJnfS8VYrej7PABIG7lh0TEY3lB2qFbxniRwECTMRV1Z7WXaD4rejIAVFqwdaE67rj
 rlBRu+c+N09qUu27ekqkjcc+74Et+GJi9GlgqbOx0pEEgzbQblqrFB4Ybecn3Etmz1u50ZpIhKi
 SxTdXxGlrxrAjkLp62OnwtxssxqTdJXK1i821bDi9VmEM1XcPDdnYp84ns8SMyWyKb0kOD389lE
 ygPQY5O0wN6wW8xSBsWWPUzjxZB7VAb7YG7eU
X-Google-Smtp-Source: AGHT+IFyJDpwfjxmPCDLw1R4i1LJ4uuxP2ABKOjVXDzSqQEuOyjwrhR3mQ92NowuC8Ew02md+JECMg==
X-Received: by 2002:a05:6214:2024:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6fb3e59661cmr16450746d6.15.1749774954168; 
 Thu, 12 Jun 2025 17:35:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c31566sm15691856d6.61.2025.06.12.17.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 17:35:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 2/2] latencystats: optimize locking on transmit
Date: Thu, 12 Jun 2025 17:34:26 -0700
Message-ID: <20250613003547.39239-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250613003547.39239-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
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

If transmit callback is called, and there are no packets
in the burst with timestamp set, then the expensive operations
of locking and accessing TSC can be skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 181c53dd0e..dc415c4682 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -190,17 +190,26 @@ calc_latency(uint16_t pid __rte_unused,
 		void *_ __rte_unused)
 {
 	unsigned int i;
-	uint64_t now, latency;
+	uint64_t ts_flags = 0;
 	static uint64_t prev_latency;
 
-	now = rte_rdtsc();
+	for (i = 0; i < nb_pkts; i++)
+		ts_flags |= (pkts[i]->ol_flags & timestamp_dynflag);
 
+	/* no samples in this burst, skip locking */
+	if (likely(ts_flags == 0))
+		return nb_pkts;
+
+	uint64_t now = rte_rdtsc();
 	rte_spinlock_lock(&glob_stats->lock);
 	for (i = 0; i < nb_pkts; i++) {
-		if (!(pkts[i]->ol_flags & timestamp_dynflag))
+		struct rte_mbuf *m = pkts[i];
+		uint64_t latency;
+
+		if (!(m->ol_flags & timestamp_dynflag))
 			continue;
 
-		latency = now - *timestamp_dynfield(pkts[i]);
+		latency = now - *timestamp_dynfield(m);
 
 		if (glob_stats->samples++ == 0) {
 			glob_stats->min_latency = latency;
-- 
2.47.2

