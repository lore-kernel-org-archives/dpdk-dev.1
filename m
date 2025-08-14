Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73ACA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C0B402A8;
	Thu, 14 Aug 2025 23:32:56 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5E73F40291
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:32:55 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c2z470ktjz3TZK;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c2z464wzNz4B1j;
 Thu, 14 Aug 2025 21:32:54 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755207174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d52d1MPSb7r2l6yOX9qfhNl6Vif6VLRMy1PevNqS1E=;
 b=A+MhOmlGKhUQ9adIRfEWFHFHpJRt8aDB8Try3VilgH4sWvLspTsl3MuQxszrdxwmCMW7ZS
 dzT/72s32XMVPpE8n2pqeve5j9svJJQMA2u7XWKTxIZt3LsRxmQKiR08r5NHNf65mG2bHH
 H0fQnyDWq2jKsbSDMirdW7DayBUjzHaKYqM1HIM3m3N1MC3lhq54t/dDQt+AgvSD/6OI2C
 LwUHVmowJNhz7SqYjl7bBs4oPYMFkyL+kHx+j30ooXsYgEiX8BE2mB94Nhlk9NxgiczJnW
 YNb1qQo92xaaqQ1kPeRfyyzSLsHXLqOwHuGETOFrNCcnAgAMS0dmp/+6vy+3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755207174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d52d1MPSb7r2l6yOX9qfhNl6Vif6VLRMy1PevNqS1E=;
 b=hGYG6W9CogIoiIzAHj6WIoFyBDVPAhTi+lRLrgzU8S11ADSuHFj/hK3twBsX8WYnwUsTpj
 VwMIckJkW4NhfptQhG8vh/RUtV6O0boHWCtFN0/j/63GLNIURL6cJwNdBdhCUgUHR1aJAq
 GdIyNQV4kR87dRhmLg7mTpPMW8kGGZMgIHivu8EC1RSsRXL6lpxcnqldj3KIDZAG5ID2Bn
 sf6FY81PHlKzzlgRnH+01yTCFu8+nJLLrC7Jxgxv6duGKY0pXNoVXTkgNR28aAOb9tMgnN
 Hdl8lFF9l6M/7ijXG7EpvoBPpCmfQBtj8+zOYqFPnzcORj52NDBD69n3rK2VzQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755207174; a=rsa-sha256; cv=none;
 b=hj8GQpoJmW/UFvtDbE8hFC5CNqO7AbHnaGHCCyJ9bPesEhJvEyS+ex6mlxswvJMVzKy6M4
 bdNFuQLDWjRu0o/AyRHordWBlc2LwgEp680fkN3avrD2W8UTjET5pKsYmwFyk1F7Q5RjMN
 t3JXGymrUs6ikBW94GD0jiKD46EH6E49aq0IFHwcvbG6fowVRONl/PbFeiaO3mlRdAK/6y
 j7WGmGdlOyVKZjnqT/tn4Qi2ahuj8wjOcnHEPWyF39VWMIzObHfBecjguVoZZHPYulHsD4
 q1CdFTZoQMvOMElLnnLvAscH7i1qenBQWpcp7KQsKmG/rO3rsPbhDbBusLoL+w==
Received: from s1.pct.niksun.com (70-59-118-59.mpls.qwest.net [70.59.118.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c2z462x9rzRBT;
 Thu, 14 Aug 2025 21:32:54 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v2 1/3] eal/freebsd: Do not use prev_ms_idx for hole detection
Date: Thu, 14 Aug 2025 16:32:43 -0500
Message-ID: <20250814213246.4141803-2-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

Use rte_fbarray_is_used() to check if the previous fbarray entry is
already empty.

Using prev_ms_idx to do this is flawed in cases where we loop through
multiple memseg lists. Each memseg list has its own count and length,
so using a prev_ms_idx from one memseg list to check for used entries
in another non-empty memseg list can lead to incorrect hole placement.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/freebsd/eal_memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 6d3d46a390..be3bde2cb9 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -103,7 +103,6 @@ rte_eal_hugepage_init(void)
 	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
 		struct hugepage_info *hpi;
 		rte_iova_t prev_end = 0;
-		int prev_ms_idx = -1;
 		uint64_t page_sz, mem_needed;
 		unsigned int n_pages, max_pages;
 
@@ -167,9 +166,9 @@ rte_eal_hugepage_init(void)
 				if (ms_idx < 0)
 					continue;
 
-				if (need_hole && prev_ms_idx == ms_idx - 1)
+				if (need_hole &&
+				    rte_fbarray_is_used(arr, ms_idx - 1))
 					ms_idx++;
-				prev_ms_idx = ms_idx;
 
 				break;
 			}
-- 
2.47.2

