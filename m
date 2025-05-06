Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC2C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24E41402AE;
	Tue,  6 May 2025 19:40:59 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4DDFE40261
 for <dev@dpdk.org>; Tue,  6 May 2025 19:40:57 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQfd02LSz3QL5;
 Tue, 06 May 2025 17:40:57 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQfc630pz3wkd;
 Tue, 06 May 2025 17:40:56 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqzlTmwqmNS/uCXttqQfLA3/+QIpZW4stU9YHYY6jl0=;
 b=Nitkb84AqnPifHCjX4zIDuAsiM9C0CLkfsP305jvnejHYs2BJURcd6EF0wQlQl67wkaPoP
 36dXoya4LA1e43NlOqS1QtENKl1/HhEPySzmejn/kBfBYxZQe158ZvNgUlMr/ssy2UBsLc
 tayf+U8LQGIrTRXbjBvF110Z85537yjnzI0I5BnwyGq52/Um3KzxxzhZJrIxy48cNOxVbu
 kKnl6OsRow+arwMHdPCJ/la2a0wz/QzbiWg7B/alCWU9VhJDNicPlpjEpNbDvJVeCmWa/y
 SKcbMCwS+EvLvKxkH2iqx2WY/v0AFohX4y8lzTMl75Nl9w7my9eoTngPPuXMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqzlTmwqmNS/uCXttqQfLA3/+QIpZW4stU9YHYY6jl0=;
 b=vIHh1a1Q/lglgIV5YqhbGqJMIdthjuC2L/XFDC/fV80IjNzMfuScacKHd1zAp7T5P/zcqP
 qnWx+XSldlKMUpdIDnfIvqZo4afGXSHqDo8pBlYk125PdqbpibJEqIB6+eb53ESMz/tTvj
 J6WHyejGHzkpEn9Um93uV+aL5wBO0Dx5WKlXLULIoZs50k3GKlpvDZMbwRVPinYr8a/+dE
 aTX3pFxt4UQ0vdBm37Q8sz+jGNC18zJqKZ5Xwr9Q9OuxddPM9u9ewUHTx0XWjI3EDNN/tB
 lr10anRYXvzdeelIL21GkqDpqd6duX/AXQleKjlsS4rWBAEcoKwzoP+7uQzltA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553256; a=rsa-sha256; cv=none;
 b=XXVpha/8RhTOGt7RV5w3Y21ab8ZSyHnAh7iany1gZ/z2EErIumNLhm0zUlcm5CSg1ydl30
 g2Se/WoJoyIGYt/IN0bwheWyuQelE7tpFEZd4BrVv43xQoyvJ94dStXcD5z7ZlELIJgusQ
 XC1LZ/mYwVr9+PbOPkCZsC3OhzHMoKZ+Z383ndyoyZaCMuvUcRc9qliC+heJv6vEoBg51V
 o3zYzT7oqhMKWv250BVSHEWLNN0xziOViJJkpacYCBM/HvoITePZd4Rd2h3MbclAJvgQh0
 +UH4btsAKXlcx7Wg/sDfNrFSwbZm0mgYkD5PWlDcZrVnRPA/3Lp+iySv6SFjIA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQfc3gK2zvmn;
 Tue, 06 May 2025 17:40:56 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 1/4] bus/pci: Use force-noreplace flag when mapping PCI
 resources
Date: Tue,  6 May 2025 12:40:41 -0500
Message-ID: <20250506174046.1136711-2-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506174046.1136711-1-jfree@FreeBSD.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
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

When mapping PCI resources in secondary processes, use the
RTE_MAP_FORCE_ADDRESS_NOREPLACE flag to indicate that the
mapping must be made at the provided address.

Without this flag, the kernel might return a different address for
the mapping, even if the requested region was available.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 drivers/bus/pci/pci_common_uio.c | 4 +++-
 lib/eal/common/eal_private.h     | 7 ++++++-
 lib/eal/include/rte_eal_paging.h | 7 ++++++-
 lib/eal/unix/eal_unix_memory.c   | 8 +++++++-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
index 30503bd23a..71974e9f56 100644
--- a/drivers/bus/pci/pci_common_uio.c
+++ b/drivers/bus/pci/pci_common_uio.c
@@ -10,6 +10,7 @@
 #include <sys/mman.h>
 
 #include <rte_eal.h>
+#include <rte_eal_paging.h>
 #include <rte_pci.h>
 #include <rte_bus_pci.h>
 #include <rte_tailq.h>
@@ -58,7 +59,8 @@ pci_uio_map_secondary(struct rte_pci_device *dev)
 
 			void *mapaddr = pci_map_resource(uio_res->maps[i].addr,
 					fd, (off_t)uio_res->maps[i].offset,
-					(size_t)uio_res->maps[i].size, 0);
+					(size_t)uio_res->maps[i].size,
+					RTE_MAP_FORCE_ADDRESS_NOREPLACE);
 
 			/* fd is not needed in secondary process, close it */
 			close(fd);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 04ba8ddb86..aaeb140eaf 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -211,7 +211,12 @@ enum eal_mem_reserve_flags {
 	 * @see RTE_MAP_FORCE_ADDRESS for description of possible consequences
 	 *      (although implementations are not required to use it).
 	 */
-	EAL_RESERVE_FORCE_ADDRESS = 1 << 1
+	EAL_RESERVE_FORCE_ADDRESS = 1 << 1,
+	/**
+	 * Force reserving memory at the requested address, but fail if a
+	 * preexisting mapping collides with the request.
+	 */
+	EAL_RESERVE_FORCE_ADDRESS_NOREPLACE = 1 << 2,
 };
 
 /**
diff --git a/lib/eal/include/rte_eal_paging.h b/lib/eal/include/rte_eal_paging.h
index c60317d0f5..7b1983b615 100644
--- a/lib/eal/include/rte_eal_paging.h
+++ b/lib/eal/include/rte_eal_paging.h
@@ -34,7 +34,12 @@ enum rte_map_flags {
 	 * may remove all other mappings in the requested region. However,
 	 * it is not required to do so, thus mapping with this flag may fail.
 	 */
-	RTE_MAP_FORCE_ADDRESS = 1 << 3
+	RTE_MAP_FORCE_ADDRESS = 1 << 3,
+	/**
+	 * Force mapping to the requested address, but fail if a preexisting
+	 * mapping collides with the request.
+	 */
+	RTE_MAP_FORCE_ADDRESS_NOREPLACE = 1 << 4,
 };
 
 /**
diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index c540f1e838..61e914b8db 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -17,11 +17,13 @@
 #ifdef RTE_EXEC_ENV_LINUX
 #define EAL_DONTDUMP MADV_DONTDUMP
 #define EAL_DODUMP   MADV_DODUMP
+#define EAL_FIXED_NOREPLACE MAP_FIXED_NOREPLACE
 #elif defined RTE_EXEC_ENV_FREEBSD
 #define EAL_DONTDUMP MADV_NOCORE
 #define EAL_DODUMP   MADV_CORE
+#define EAL_FIXED_NOREPLACE (MAP_FIXED | MAP_EXCL)
 #else
-#error "madvise doesn't support this OS"
+#error "EAL doesn't support this OS"
 #endif
 
 static void *
@@ -68,6 +70,8 @@ eal_mem_reserve(void *requested_addr, size_t size, int flags)
 
 	if (flags & EAL_RESERVE_FORCE_ADDRESS)
 		sys_flags |= MAP_FIXED;
+	if (flags & EAL_RESERVE_FORCE_ADDRESS_NOREPLACE)
+		sys_flags |= EAL_FIXED_NOREPLACE;
 
 	return mem_map(requested_addr, size, PROT_NONE, sys_flags, -1, 0);
 }
@@ -124,6 +128,8 @@ rte_mem_map(void *requested_addr, size_t size, int prot, int flags,
 		sys_flags |= MAP_PRIVATE;
 	if (flags & RTE_MAP_FORCE_ADDRESS)
 		sys_flags |= MAP_FIXED;
+	if (flags & RTE_MAP_FORCE_ADDRESS_NOREPLACE)
+		sys_flags |= EAL_FIXED_NOREPLACE;
 
 	return mem_map(requested_addr, size, sys_prot, sys_flags, fd, offset);
 }
-- 
2.47.2

