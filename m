Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D3606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VMzCb0sS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC8440689;
	Mon,  9 Nov 2026 15:41:23 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 8599640687
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:41:20 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-91ea3f6a506so8253956d6.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235279; x=1794840079; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=VMzCb0sSmri9cE4MVtS1NJQGHtyTzY1/ChRcMYdCBYH+Z9zceyUSgZChg7err6aIZO
 k8+q4hg4b04oiBpIrEKnpQZBjqrOl7NdUCpwj6N+V2xvwjkVLrgqqQYYga2vkzwwLZNz
 u43tbZlASfy9MzHf00VO6aj+YjManPqTb9bE/awdAFzpwbtAT3WrRAobQCjRnN86oai/
 SVUCY+1SMl74Dl2nQ5cSL7yhsYOXQx/ctnqHGxpYrNKthKWyrsF8izhyXYCN8QziLdC/
 bcXp0stpXnMhoUUddxPMv2bwoE7u+Cn79DRLEZYninwfNI1v2IR/NPGDgQN6AWcnCxIP
 JTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235279; x=1794840079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=Pi1Lu4iFc5B5vMegkVCeq3M3BWk6YkAhnaUdqEL6yRHJG6A6JczYCJU+fP7rXpef8y
 OpghK4oevwkeST8QJSO83d6Oo+L5kRjVx5/CmJCU9dow00ITXE3uaG9S7UhWX6bgiu+B
 nJm7Fx+09blxgkzvjQuJN1srD9g5mWVRbDrjZF4zmL6haNwoimcv5NrJoPpKFMOkhXVX
 7rpcMQ8iqdMwnHs9cpx7qSlmGvAkP1H+tDEpNjdjiraVJyabPzccOhQ6uG6sEXnZU8gn
 pWNY+hSHnAp7+4Xamg8/1vWO4750YqDE0Fcs09RmqFUlV0dEaTCBkxUIdu0LZUftHCM1
 Yx2g==
X-Gm-Message-State: APuU4Z/KDorjo66khvkbqmqs9lLZq5EVGZDo6Bogm/4jGU5eCVH/E9vE
 tKnFaUpQw+oiKFLwDPzB4w9LvScXuRwExW+LumcMIDA4wC/SkFx1Mj71GFflNVy8
X-Gm-Gg: AYBFou3R7BrbUoIq9xoPwPpleVjCONJmhOiDdL2V1w70sPTT9cggOhDfAci8u+uoXlJ
 LIH2zWCqv6t3PI2QA52yCRY+UbSuMhk+IjZoSym6tsSrWSqbXSFBzC+4nEpj0teN3GABVUPxC4p
 9lrm4vvrxYPxbuxhrhi83K6Sv+sEpeFV9FsF4fsDTI2vjI8V8GemWoQSOIIP83OWniStLXcnogS
 26WrdCtWdpev46LMCfv0t06+3XopULIqvB1EnTK/ATw2SkIZoi/IYXiFkE0JhRfkBGAPdYAO62n
 zTGnXBj1QY2ajcf21uFgTqA5/TZJuNAVqgU2tyFaaSakap3hKR5rOkEqtGdV3O+huM3Lkz/jTa4
 9xqX2UDSEsyGCpr62FUgXnfMzCvdbTE+/lw0PDUJLcLpwjQkyShXugqOEcfwbq3boG9TwVjj8un
 j7ogm/5idrHXZwYgTg1mvBkZlL+6iac1iXFDKdUEc7qT9bqzYvSu0QKIuZvo6mDTlSVjQVK2pYj
 8ldlYg5+z8nqHw8vNurtpcluxelCsi+2/9SN6ZEv6FrTkZsw0D1ZP9WE0mAmiCTcmx6SIQOR4he
 rHmfebVB2uqwgBjZZ/YadQI2SovVI+dMG8fr0T4KDTU5OVGdi3ezBRsyWoiZ5pqKhyZFQF9e12V
 T3LJUU6zZbpLjoSnGDF+bJcvF8tJVC/m9jO2TZBRGb1gEPrL/cn9cBr3/e5IdF9uEkTdMEt8Dre
 So
X-Received: by 2002:ad4:5ce6:0:b0:91e:8b62:fa67 with SMTP id
 6a1803df08f44-91ed245d28emr61728316d6.32.1794235279356; 
 Mon, 09 Nov 2026 06:41:19 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91eceed448dsm43579846d6.45.2026.11.09.06.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:41:17 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v3 1/3] mempool: fix race between list walk and free
Date: Mon,  9 Nov 2026 09:40:52 -0500
Message-Id: <20261109144054.3784583-2-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109144054.3784583-1-rsanford2@gmail.com>
References: <20261103173543.130142-1-rsanford2@gmail.com>
 <20261109144054.3784583-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
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

