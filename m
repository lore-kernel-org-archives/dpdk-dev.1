Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43B606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=j9ORUYEW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D4B40297;
	Fri,  6 Nov 2026 09:08:00 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id E2F204026A;
 Fri,  6 Nov 2026 09:07:57 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 54EDE2037CF5;
 Fri, 06 Nov 2026 13:07:57 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id D1CB82034B5B;
 Fri, 06 Nov 2026 13:07:49 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru D1CB82034B5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1793952476; bh=cZ0A3hCL1XgDH4MQNTOkny6Jb2zHZog6cOAgwXVSGK0=;
 h=From:To:Cc:Subject:Date;
 b=j9ORUYEWKDUwM7L9nq64UneZv0OeLC/nM/8Q3R08P74zxhjd0Ylz7EIVYq/IE6mrh
 Gnhh8FzTuFKnSUpv8z/UOTq7je+zum2vrcV6/SeyLztMAvRCE3uh+MXLxIglDKKzxR
 j9Mf4G2+apWMEQ2Wfs61gGsOeaxGnN3zbpFjEC+u1VvBklMxN7gl5hupTuxgM0RSl7
 14VlGtNnZlZ1hPD1iv7JYVsED9e7GXwNnPUAHwHQrTFtxAr+HuX44BbgmB5A4apucI
 3Pf9rQefsX+2jT/5QK0QL48eoalFuF8K0hX95BQzNf4f0V38Vl40b8Hwa+mqbvhIBo
 5+Dnuipr+m6JQ==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH v2] gro: fix returned packet count after UDP fragment merge
Date: Fri,  6 Nov 2026 13:07:44 +0500
Message-ID: <20261106080744.138763-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_gro_reassemble_burst() decrements nb_after_gro only for packets that
are merged while being inserted into the reassembly tables. When the
tables are flushed at the end of the burst, gro_udp4_tbl_timeout_flush()
and gro_vxlan_udp4_tbl_timeout_flush() call gro_udp4_merge_items(), which
merges fragments that became adjacent only after an intermediate fragment
arrived. Such merges are not reflected in nb_after_gro, but they are
accounted for in the local index i, which after the flush holds the
actual number of packets written to pkts[].

The function returns nb_after_gro regardless. When a flush-time merge
happens, the caller is told there are more packets than were actually
produced: the surplus pkts[] entries point to mbufs that are already
chained into an earlier packet. Freeing the returned burst then frees
those mbufs twice and corrupts the mempool, and the surplus entry, whose
headers have been stripped by the merge, is handed back to the caller as
a standalone packet built from fragment payload.

Return the actual packet count i instead. In the path where the flush
block is skipped, i equals nb_pkts, which also equals nb_after_gro, so
the non-merging case is unchanged.

Fixes: 74080d7dcf31 ("gro: support IPv6 for TCP")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
v2:
- Correct the Fixes tag: the double counting was introduced by the
  IPv6-for-TCP rework (74080d7dcf31), not by the original UDP/IPv4
  support. Releases predating that rework (e.g. 21.11) recompute the
  count as i + unprocess_num and are not affected.
 lib/gro/rte_gro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..168960b8af 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -349,7 +349,7 @@ rte_gro_reassemble_burst(struct rte_mbuf **pkts,
 		}
 	}
 
-	return nb_after_gro;
+	return i;
 }
 
 RTE_EXPORT_SYMBOL(rte_gro_reassemble)
-- 
2.56.0


