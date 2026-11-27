Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D4606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Og5Gt0fH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C59406B7;
	Fri, 27 Nov 2026 22:08:22 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 8BBAF4064A
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:16 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3b413997581so6196522a91.2
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813695;
 x=1796418495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bJJY+IRSzKQkoSBpFbMXftxD4dXpAB/cOYs6Gx+DIo=;
 b=Og5Gt0fHbxz7FazJF13+xc5jb3eQs1od0AP0gHpceFWfkQDyTPfyk/jRoRBqKDuDda
 L86Q6OKKgEtL2zuFX+xiRG3pbcGQEKgcQUYC8wmvJipWj2dzicisGcBD4J8NbOzL1siE
 Rd8Lm34YkHaxzQJaVzWLv4N1S69T4IqKyoSgqXY6lHg65I16VO2kOkKmwqWL1QGU+6pC
 FALfMymfnoEZ3pOCQW396IBuJHFgfY/7c7VdJIxXX4zKIKkZGtOWZbR5BnVSZbgL7BUy
 MptWZNe/BCIEUAMGiTwDJBCFn3tYQjnAf1aZ8DeIsmGhyLAuXuhfmyiTglLK5aCk0TuC
 x7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813695; x=1796418495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2bJJY+IRSzKQkoSBpFbMXftxD4dXpAB/cOYs6Gx+DIo=;
 b=jejPUu10+L0z1a5GoHNI3cQGSiXoR433ifofBQBvn5Mk8ev3m4KakSPrJ3LrYHrFpM
 OCutpUEIi3lcQFOLOuCGrNYeZW/eNmWmpVyt4Ex3uiSUisO700GZhfdLuh1ViMeWiqKy
 6UOd4Dv718hYVzehMFOVOjhLpdnlpBGr8jXoVSdz7eFAK9p1YZnF4QV/NExKpz92AUep
 sW0ZkcT0aSM/6D9Gmfy/Q6uPXHls9he52u7GpcUh+eA2bAy6QCPimkqrIjCktSdFpbii
 J76KuKr/rRG9iD+xkSNqwEE3r0fQh6ItPkvjM1azPCwuN7GORkLW/2g6BOoExBMy1haz
 FLHA==
X-Gm-Message-State: APuU4Z9ORdb2f1zuw4f8btcQWi7EwT7++eG9odmQLMd/bi1UF2I9yUlw
 jojVgUlIUROiBHd7CXP7Mqzq45DL/pzmUB18ppv/GncSffz+Z1cINAqjTslNuJhAFSEj6PlSTfG
 KGRWK3GE=
X-Gm-Gg: AZFdTZeWw05Artw/Z8L6Jb2eJu8TU+BZH4KL78L1FYlgtGQpfOeS9crt1k6TMwtk44Y
 NcP7J91c6eRyBZ14FvqCuX4u7oqcImtsMM7UT9xVIgOrluST/+L/eu0Bvj22yDf4p3VNunluJhy
 ZvBsiIH9oN3Q36AYKiJno7B1wJhUD6zGuPArvaCO1zyJoDknpHiRTYHxC7vxJmSa3sVr8qOJI2d
 I4m28vp/StoY2reSwRMnb2W/To1I6rxTXGPzUVkjS0YTreYG10tE0Ph7J5n9NRRoZ75mWmBW8QP
 lrvXlqKj5ZEhlvFoMF3LvgikV5cttoBlo69sFVs8xaGj38dS6FbkpIKd4KI/TZ8Zsp77t6EQSWb
 ODH9BgbJ9lvV2llPITroMhwzmGn8UBoQJFfdAIglnXuo/mKqboRnp3/+0Lptk2uFdhzzQ0HfyFE
 s8tHJerzKglet0j5xOJhf796Qs8oNMcJcSosi/B5W7pdRk51i/tfJvX2ZiKeH+rvLQyGnfhXwFD
 rJ9q1mq9xpPp5E+3AN9lHVjwbkK8hQn/Znkj2oNSqCvvI1nXjNS1Z/UwMAsW0N8w7sgFiOUkHf9
 p9KzvK7j3wpWaQdMG7MKwT1Da4Bfo6bVaSluGAJhmkSTXRpAE1M9uYkvlhnaofYXIvoK
X-Received: by 2002:a17:90b:1c08:b0:3b3:b632:7f2b with SMTP id
 98e67ed59e1d1-3b41c98a3fdmr22778123a91.51.1795813694951; 
 Fri, 27 Nov 2026 13:08:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 6/6] app/dumpcap: disable capture on the interface that
 failed
Date: Fri, 27 Nov 2026 13:07:08 -0800
Message-ID: <20261127210806.318387-7-stephen@networkplumber.org>
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

The unwind after a failed enable stopped at the interface that
failed, so callbacks installed before the failure kept referencing
the ring after dumpcap freed it.

Disable that interface as well. Promiscuous mode is left alone
since it is only set after a successful enable.

Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 47483535fc..5ae85cbdb2 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -852,12 +852,16 @@ static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
 		if (ret < 0) {
 			const struct interface *intf2;
 
-			/* unwind any previous enables */
+			/*
+			 * Unwind this interface too, enable can fail after
+			 * installing some callbacks. Promiscuous mode is
+			 * not set on it yet.
+			 */
 			TAILQ_FOREACH(intf2, &interfaces, next) {
-				if (intf == intf2)
-					break;
 				rte_pdump_disable(intf2->port,
 						  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+				if (intf2 == intf)
+					break;
 				if (intf2->opts.promisc_mode)
 					rte_eth_promiscuous_disable(intf2->port);
 			}
-- 
2.53.0

