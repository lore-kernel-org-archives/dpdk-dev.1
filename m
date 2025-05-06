Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4BC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 17:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7C84060C;
	Tue,  6 May 2025 19:50:18 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id BA349402AE
 for <dev@dpdk.org>; Tue,  6 May 2025 19:50:16 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4ZsQsN3Lhhz3Xs3;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4ZsQsN2D9Fz432q;
 Tue, 06 May 2025 17:50:16 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zEcMCmXncAEm4oth9nU2xuNbcn4adyVs8FSEvlLytE=;
 b=XnvMvXS+g7wOgEAxcnv0pQWEWgLaFLRbg7ucC0Fooj/enxfTgOxubveCP9N1E86rzuoer2
 XexVtiYz0SfAbFgTKN2CEPkY3Nj0FJQD4p3bwuMzAN/mAgvenrPwgHou5b2fX1FBQZFXsX
 pl7gJXwgvSq6r3RUr7vrwj3Q1Miw3fYPBosTEYY2aUaRqrg275mC0RKKwKTrrTOFQtJaGA
 jpTPiC+Iz0O4i54438bj3vE4LPGhWNHoXWonFeoCK0cZKzpRAABgs47KNcPKm/kt2UuLBY
 m5R7gIq/XBAgSbQHNsacFJo52Q4yxw/7qwSf/ItSjSg8NW/ZWNA2XjkoCe9Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1746553816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zEcMCmXncAEm4oth9nU2xuNbcn4adyVs8FSEvlLytE=;
 b=SSg0SwNX+Hy1jjp5nbUW7tyd5cI31540u5SiHIVZ70rO28IxmFcwH0zaayjwR5Zz1ApohQ
 3VZrtDf35maoJEmLtJ7BzYet3WJuGZtsGPlgQ+5fQR73mui+JRm/jdimI/ZMYc3dTZSHpR
 miRBNwVPx8ONDAHghfKtfwd/KKAbKHlIkK7tMNsdP+SHc4LnSG2FXP++Md2OmOvnUE+RYf
 bf35bSVGBoHeHIct/hNHSHPcdaiJcMWdoO1SczFsnEjlnh6FigJocCuubUowfxVNp53/Dj
 bEHHXMWXZouQdvkBlIlQvUqs6aQ0RnY3avqweH6pRnqYjatmWQUtwfffXgSAlA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1746553816; a=rsa-sha256; cv=none;
 b=G09ACKyqym+frIjmRd5SB9Wxx26A/5sFuyoFtyHk/NRYHcm3ovqX09HTo9yYI4Ut52dq18
 tyxLK2IrufhBju2OjPRaYOgihoKe6JeruMbfiaRwyntLNPUAkbhl+vMCDUDatZY8BfFVC2
 F9jsDZgHGiG14JXGWN31zzPEMdyuZsq2gDxPayLxSmagoSRSvwFVD2cCGIPgKQBjuljkX0
 sX50KwS3lQ1VJP+yx9bqR65SvKAgPHhCxdpGuSJaSXoeyklsHLvQqA+bP/MHTV1knjJ16C
 fusyxg0+V/xb7USH/Yq4AuDAoWURgWFQDqcrFUyEgYT1wFofsewXUZIYHoRaZw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from s1.pct.niksun.com (67-4-147-206.mpls.qwest.net [67.4.147.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4ZsQsN0BNzztvC;
 Tue, 06 May 2025 17:50:15 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH 1/3] eal/freebsd: Do not use prev_ms_idx for hole detection
Date: Tue,  6 May 2025 12:50:07 -0500
Message-ID: <20250506175010.1141585-2-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250506175010.1141585-1-jfree@FreeBSD.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
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
index 3b72e13506..bcf5a6f986 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -104,7 +104,6 @@ rte_eal_hugepage_init(void)
 	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
 		struct hugepage_info *hpi;
 		rte_iova_t prev_end = 0;
-		int prev_ms_idx = -1;
 		uint64_t page_sz, mem_needed;
 		unsigned int n_pages, max_pages;
 
@@ -168,9 +167,9 @@ rte_eal_hugepage_init(void)
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

