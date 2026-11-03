Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1572606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cRJrl79j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B26FF410D5;
	Tue,  3 Nov 2026 02:11:16 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTPS id B5B36402E3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 02:11:15 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-93f3c89594cso245327685a.2
 for <dev@dpdk.org>; Mon, 02 Nov 2026 17:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793668274; x=1794273074; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrBPtDpysUDMeJ7n/gEhG2LKB89TzW2nIXaml7i6M8w=;
 b=cRJrl79jw1DO9Z9SCK6aC75+pA6Qs9V3c+f4ESdLaweSlkxoatrnRCWKvTcjnrvBV2
 GNXQKuu2H7Ipd/MxuFXXMbTMklqhj7Xxj9Wd96XJygy6eV9509dbL8NggvMECl4UaMSU
 3/ITlhBzP6NGVYul84FgE5m6LLuM5gcqXnH6ertCTMFPrzknUhEhQV8HwUxjxC6peW49
 PFLmCN0LzmeMs/kd5gwv1/FYcCBzishSbHrca7ylVGPeA1u11nVi6a7Rc0gVa+VuTMMD
 ioF60se+uGxaek/m77dq/wZW4Nmb6he4RyFjRJy4rj7D/D5seORdmWUodRId+bQ03CEU
 L7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793668274; x=1794273074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrBPtDpysUDMeJ7n/gEhG2LKB89TzW2nIXaml7i6M8w=;
 b=lHDnRweXLwRftBSa0n+gJo8D3bdn6Ttpux+o7zbHTX0LLW67Wy74zsNKOkZ9vIerLy
 brHysu9yGhMw6DE0065+kkVxQEiJS1PLldKGARFOl0uUDJ0xYvlB0K7Qppi9Bfz7cPWP
 tG6Y5iv0d5iK+SLDJTyjhnstRilHcBfowotxCCOa0IBjPV/Rp/N/PEGaxt+OV7Eh8+bM
 8jMaWlbWThNuktA+5gxaISeIuiMnQSS+SqRmuR8pmhrYI3zvEH455mF/HazW8VSEHFsz
 KjzVco+w85q0z6KCeFpcC4Ei3fEVxgmkERv9ln1BD3IedD5HSgR6yyETD5UiYnVx6tKT
 7zYQ==
X-Gm-Message-State: AFq9FYLpKAx5iXjuBEWWIjCL1FZ68NAgg3c99nE+VGLlPdVL+zafiROm
 7HpGjky8dsPjCy8pinPUzFAHFNGwPspyOSEt7riL6Ke6OiyRqRbNRsVjC/G++a0i
X-Gm-Gg: AYBFou0IKkIGt+mifWLK+lmjuBepiFENGzvXK26iep5UiMwVZGIkyoJKMznyx3pnWKC
 eVx5Pf/8LHgofAn1/dc3RqgBWyppWx00bUSk84i3C+w2UM1RxJScd4s0Zlo2waB+kU6H6bnm4nw
 kx0G5T0mngwBfmAduwF0yrvTBwqEX/Y1QQfj+CEDJngNBmKBOlV2LZUj/cL47HFl6HHMk6WTk1M
 vFdrRTLUYQCKztGgS+DcOpqI7JGeeD6S3CPdvhnH6phzqCUCwhCkjbKYiXvZmDD1lEmCF1J8HNt
 HaUvgGknplqDF9paN9dQMHyeailHeFZHQFiqf7jMBJ2DOc0kqaxUMKQD2X+mrmLSDxANEuwjFSA
 VvMnv69HBVrfTN+yGrJOpoM+zxt6uNBKw5HAc4ruCtlZZBx/CONSyTQE8dW8WMeCBWiROPlfzCv
 KUatSJr2Cr+wD3DB/0L3A9WPfyNhulE0Nhn4/7iidiGxG/rJEefV3pGw6fRvLdQ04f5AKroy6qQ
 8NfkrKcMibT1jdiM3B1O8yqQ5eJGd/drTw2cUkq4GjsTa2/XL+wl31q2IIl04ZLcEBl2dW5U+t4
 /qfJ4nB50LfWDs0vj6VEtqC6M/ZaGHKlNcQ8HGKKDzxxdlS7kaW4xm1k5YfoZJR6HAPTOyYjrYd
 TXR18dhWhxdvHxfR0xH9JSvHCApvVVH9+xMthACP4QrZ9TP4FgW8X3U6wRKuRiESddkI6os5t8d
 DW
X-Received: by 2002:a05:620a:3708:b0:93f:d27:c89e with SMTP id
 af79cd13be357-9442175c185mr2021864185a.75.1793668274514; 
 Mon, 02 Nov 2026 17:11:14 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e2749asm103788266d6.1.2026.11.02.17.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 17:11:13 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v1 1/3] mempool: fix race between list walk and free
Date: Mon,  2 Nov 2026 20:11:05 -0500
Message-Id: <20261103011107.3658840-2-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103011107.3658840-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

rte_mempool_walk(), rte_mempool_lookup() and rte_mempool_list_dump()
traverse the mempool list holding only the mempool list lock.
rte_mempool_create_empty() inserts into the list holding both the
mempool list lock and the tailq lock, but rte_mempool_free() unlinks
and frees the list entry holding only the tailq lock. So a mempool can
be unlinked and freed, together with its list entry, while another
thread is walking the list. The walker then reads freed memory. Since
freed heap memory is zeroed, the walk callback is passed a NULL
mempool, or rte_mempool_lookup() compares the name of one, and the
process crashes.

Take the mempool list lock in rte_mempool_free() as well, in the same
order as rte_mempool_create_empty(). As a result, a rte_mempool_walk()
callback must not free a mempool, as it already could not create one.
Document this.

Fixes: a3791ff0a3f8 ("mempool: introduce a function to free a pool")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/mempool/rte_mempool.c | 8 ++++++++
 lib/mempool/rte_mempool.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 069aabaa70..d9f339a3c2 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -729,6 +729,13 @@ rte_mempool_free(struct rte_mempool *mp)
 		return;
 
 	mempool_list = RTE_TAILQ_CAST(rte_mempool_tailq.head, rte_mempool_list);
+	/*
+	 * Take the mempool list lock as well, like rte_mempool_create_empty(),
+	 * so that the entry is not unlinked and freed while
+	 * rte_mempool_walk(), rte_mempool_lookup() or rte_mempool_list_dump()
+	 * is traversing the list.
+	 */
+	rte_mcfg_mempool_write_lock();
 	rte_mcfg_tailq_write_lock();
 	/* find out tailq entry */
 	TAILQ_FOREACH(te, mempool_list, next) {
@@ -741,6 +748,7 @@ rte_mempool_free(struct rte_mempool *mp)
 		rte_free(te);
 	}
 	rte_mcfg_tailq_write_unlock();
+	rte_mcfg_mempool_write_unlock();
 
 	mempool_event_callback_invoke(RTE_MEMPOOL_EVENT_DESTROY, mp);
 	rte_mempool_trace_free(mp);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index b34cd893b1..bd58d8a9d5 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1947,6 +1947,9 @@ uint32_t rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 /**
  * Walk list of all memory pools
  *
+ * The mempool list is locked while the iterator function runs, so the
+ * iterator function must not create or free a mempool.
+ *
  * @param func
  *   Iterator function
  * @param arg
-- 
2.34.1

