Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B5606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eqap/xdD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91979402E5;
	Wed, 18 Nov 2026 10:20:04 +0100 (CET)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mails.dpdk.org (Postfix) with ESMTPS id 206C4402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:11:48 +0100 (CET)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961511b61so671775585a.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794924707; x=1795529507; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pMnfXWTdK+/hpXaLJwHYAdCE+PnNAPOJSNQ5x7tp+3k=;
 b=eqap/xdDmfz6H+kNGHYtRtn5EY/q44+yO54x7MYTNy+hUcnwwZSUd5+7uJPqXOE2Y9
 Iw09+ZJuwTjUIGcjPLIghjYEiwROHKUqbX4SLYvYEf6F9t5vd25vzRJqLdKVaFftEP3g
 CbtX44ZGysTaYp0Ta63u6NFWV24g+qhLcF156CdPGlRWebkPBCRxh1NbD/jC+Q/AT0fz
 N3Pcz9TPydqqjQUUcnp+yBM4xG3eqt5kQKrQZOXoxI87XrpJKqqZNRARyYpo7XsgzmGN
 VAR/TfBHyUwbP9HGBMFt/PKT7UGmRmIizdAy74cjus87aO3170xFrZWHZtwl+zBIhJn3
 atfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924707; x=1795529507;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pMnfXWTdK+/hpXaLJwHYAdCE+PnNAPOJSNQ5x7tp+3k=;
 b=dw9NSq4RPwZKkngCWjLmcgIWwgOjQxfRdJ3kPTtDwQtgRYmBhq4dEcbg9bf/uF+3oM
 lCVOnmgca1sLlYwZGbu4PDndG2und18tEboinTfrMxYvUKfppEoHTCN+6HXL+tPCQHCp
 6ZIrzZRN+A3hHl9SPt2oWYpUjvMP4tlJxkUW7yuhltuuB4DaCwVzdrvf8QFIazJ+Lg8Q
 w8xoTbwVXZif1yU34f6fZ5cO+Z1zVp4nYPPbx1K6+jq49jDRZ49ItcdblF1vPp1fG6fV
 ZzoS1qvrN9Cz03rX+Jv1QaqaVGvMSYbl7N7j+gfZx9N6Jzh/rB91gtMKyow2HyofXyb1
 CiSw==
X-Gm-Message-State: APuU4Z+mVD7L0/fBoHAbCEkuDh1IhdrO8RTV6v8TMff8hPwYniRPJfGQ
 bjhcFDFAC2o2vvQWAcn8MZ3mAKkzjHRQli2smSB3UPC9NDZrMOIryQdvUv3cR80ggngsoVpL1K9
 7574brZfBcUh+rNIt6wubaeUfvOKJEC7/PhQCgDif7KIF9TuoYHMXvO75KNhYE73rJN3fWKYV/j
 SFbw4Bkq81AjEZI61oFJRr1b2tolGL
X-Received: from qkcbb6-n2.prod.google.com
 ([2002:a05:620a:6e86:20b0:93e:4c09:8279])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6019:b0:93f:365b:42bc
 with SMTP id af79cd13be357-9494bb866c9mr2055996585a.52.1794924705993; Tue, 17
 Nov 2026 06:11:45 -0800 (PST)
Date: Tue, 17 Nov 2026 09:11:42 -0500
In-Reply-To: <cover.1794908231.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261115140016.3830109-1-rnwolfe@google.com>
 <cover.1794908231.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <f7c7f72e86bb340ca272c2b507fbcb3206aeb8b4.1794908231.git.rnwolfe@google.com>
Subject: [PATCH v2 1/3] net/gve: clear first freed slot in bulk mbuf free
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, 
 Joshua Washington <joshwash@google.com>
Cc: stable@dpdk.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
 Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In gve_free_bulk_mbuf(), the initial scan for the first segment ready
to return to its mempool calls rte_pktmbuf_prefree_seg(txep[s]) without
clearing txep[s]. Neither the early scan (including refcounted segments
where prefree returns NULL) nor the subsequent loop starting at s + 1
resets txep[s] to NULL, leaving stale mbuf pointers in sw_ring that
gve_release_txq_mbufs() frees a second time on queue stop or release.

Clear txep[s] immediately after rte_pktmbuf_prefree_seg(), matching the
cleanup loop for the remaining entries.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 drivers/net/gve/gve_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 279669165f..d344648d0f 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -19,6 +19,7 @@ gve_free_bulk_mbuf(struct rte_mbuf **txep, int num)
 	for (s = 0; s < num; s++) {
 		if (txep[s] != NULL) {
 			m = rte_pktmbuf_prefree_seg(txep[s]);
+			txep[s] = NULL;
 			if (m != NULL)
 				break;
 		}
