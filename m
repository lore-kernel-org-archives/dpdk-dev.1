Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F421CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD06402EB;
	Sat, 17 Oct 2026 22:36:30 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 57DD1402E7
 for <dev@dpdk.org>; Sat, 17 Oct 2026 22:36:29 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-89f639ba307so322679b3a.3
 for <dev@dpdk.org>; Sat, 17 Oct 2026 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792269388;
 x=1792874188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVQJLHugvtTMwm48erMNpYGpnutvZyfdSkxC3OH8wH8=;
 b=ogjhlJfjYL7SFcYr8nWQcKEzvQ3YmAlR1W3S2BXl0J27PMTDQGCL5HpuX4pRIexWoQ
 PIYqmfevFqE4yLaHssiIKjNaJiHMoJAjhGH3GXyTREGzo5HPnSTQot4qya2KhIF/dRa0
 pqDXlN+P7+SBSK26uBWm7UVHp64JyKyAC4yD+VXDXwKSKjLByhVaNcjP3MTFRWVe5rL0
 PrspLVD6UBdKX69/GsJpRMktALIYuLXFFzY4DrKFur+Hv9vGmJ3atpUvsIxanQ13Xg5Y
 Mt3jP4JOXV5EnObKr2e3ZEKQ6uxc4HrVjEASnxMpKcnEiMO00AHBKBc6jLAuRAw3AX0A
 RtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792269388; x=1792874188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EVQJLHugvtTMwm48erMNpYGpnutvZyfdSkxC3OH8wH8=;
 b=mU3d+QYnqNg2JNLsAJslBZbulnWsLLRXcoGEnSOnq07IR5NsIJOd8CyjhOpV3iJ4Gx
 bGHM4V+IrE1XcmPrXstHd3hR9d/xCrVeofdV193nQ3c/pDE7acAcogqp+YLQcWDWqA+U
 V9GIFb6xRHsyBDlkvcOcHMBjagRJcCV7n7rtGaZdETJWwHDQ4KCff/tx2cXkVa4q+r9F
 xnzN0YvjNcdJJOeLv0MoOmhlwJw3w/drL4gwcwvo6fWg+8mPW8pNkQdDHbtOiw09JLfR
 88J++0zM8MptQCD2qYzeg7AQpBjZCQ5mOiEzD3kf2KA0nN0Vz0h90kRqCtKGJfJ0qQgf
 xOYw==
X-Gm-Message-State: AFq9FYL3PPCDGHbCRPxqhBJg/vD9TQ1V6fW2hxMC7VaqFs6xnq1nG8K0
 p3Xz+pfhPk9wBj84tkvsZUtfEurD4GLKYggBxbXEAimObXMK5R1m1ZAGs43UvvtjGpXHzBn5ML+
 4hCtytPs=
X-Gm-Gg: AYBFou099eFPCyQfIBhuoBL3KKbSGbpCNE3t1YYLQiw21eawkVu7vKP5ieIE76gMOeU
 e8gfajtwAphYiSqbljkvGj2WloGGlIlzADEsxoqsLDy5l4bmqD+rFTuBpg0R0GgtY9WQCDXZdYR
 tWP7vk9NUi2LGmvuPc1EvTU4ozQuIddtBzStFySiep99/zK6MYE6qvti262WNrNWyzUdSEBDdoN
 rIR5PAivczZqkeaZbFFDIdiMGsz9XsVjMwLKphxLTdrz1fOOEwXxcNJQMiDEzq3YQ9QmLQ7/sVC
 xJoKhBX7O5PW+mg6xHW6GB74jqTIcRy8rhGImcSFb93mWcnsN9J8jgsiICFtOGmHm2wzE/dg+IU
 +dTWqMdixGUe4Afnsahj5PFKhMCb6YeR83VYQKlyml1A+EmuJN3Gf+wozYsQFgtWoYSqk2xSVd+
 PTiCSRqcv9EiIJa6nCdOrmoydJErU1ESMEaARv5b5iIn5cDqLBic9c1oH7o9apABvfRgjpMqxBo
 UwBBDzH0K46I9d8LgBJfIzWXO4ECyfsqM2aFQ==
X-Received: by 2002:a05:6a21:4eb4:b0:3de:7854:8549 with SMTP id
 adf61e73a8af0-3e225fec77cmr2392110637.22.1792269388413; 
 Sat, 17 Oct 2026 13:36:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2451929b3a.32.2026.10.17.13.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:36:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 1/3] eal/linux: do not warn when freeing interrupt source copy
Date: Sat, 17 Oct 2026 13:35:03 -0700
Message-ID: <20261017203621.3136254-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017203621.3136254-1-stephen@networkplumber.org>
References: <20261017203621.3136254-1-stephen@networkplumber.org>
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

The interrupt source keeps a copy of the caller's handle made with
rte_intr_instance_dup(). The copy carries the caller's fd and dev_fd,
which it does not own. Freeing it on callback unregister now logs a
bogus FD leak warning.

Clear the fds in the copy before freeing it.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_interrupts.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4cfaeba7fe..d4752a2b03 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -479,6 +479,18 @@ uio_intr_enable(const struct rte_intr_handle *intr_handle)
 	return 0;
 }
 
+/*
+ * The source holds a copy of the caller's handle; the fds are owned
+ * by the caller, so drop them before freeing the copy.
+ */
+static void
+eal_intr_source_free_handle(struct rte_intr_source *src)
+{
+	rte_intr_fd_set(src->intr_handle, -1);
+	rte_intr_dev_fd_set(src->intr_handle, -1);
+	rte_intr_instance_free(src->intr_handle);
+}
+
 RTE_EXPORT_SYMBOL(rte_intr_callback_register)
 int
 rte_intr_callback_register(const struct rte_intr_handle *intr_handle,
@@ -666,7 +678,7 @@ rte_intr_callback_unregister(const struct rte_intr_handle *intr_handle,
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
+			eal_intr_source_free_handle(src);
 			free(src);
 		}
 	}
@@ -922,7 +934,7 @@ eal_intr_source_remove_and_free(struct rte_intr_source *src)
 	}
 
 	/* Free the interrupt source */
-	rte_intr_instance_free(src->intr_handle);
+	eal_intr_source_free_handle(src);
 	free(src);
 }
 
@@ -1067,7 +1079,7 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		/* all callbacks for that source are removed. */
 		if (TAILQ_EMPTY(&src->callbacks)) {
 			TAILQ_REMOVE(&intr_sources, src, next);
-			rte_intr_instance_free(src->intr_handle);
+			eal_intr_source_free_handle(src);
 			free(src);
 		}
 
-- 
2.53.0

