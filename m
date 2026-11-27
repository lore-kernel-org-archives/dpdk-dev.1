Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFD606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=i8nxmuyD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03EBC40653;
	Fri, 27 Nov 2026 22:08:16 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mails.dpdk.org (Postfix) with ESMTPS id AE10040615
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:13 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso3874242a91.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813692;
 x=1796418492; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ykO+DvzoUci+U4mYz7iUfTXDAYMPO0cTzIvQjxhwdc0=;
 b=i8nxmuyDbryujChHpr4FK0Zyz2pphh3cnT4rhNYropcLZPDwf8EG4tIpX3q3HUBmjf
 wXk5R5GrEWPNlrxbpdG/voPKHoK0WToePMrgjQLtiM/83w5tObLc7sDG976kFTureIBO
 pgtvuFC6KrUvT5WUy+IdWngoECtBs9XAx+f2MW+0s5H+O3kQ9OnozEOQAtfvPR/ueShF
 67ItNqIXE/w3GvTvLK+bQqB5QqBtK+HBzEHyLez25X7EEpYgDY/EKi3aVjd4OCbLDFv9
 z5YEWmIHG2sQGaz6FYGgs6nFaxo/DCMpfG4BBme58WMpsMQOY/ddas7PRlI48OJqWo2D
 hlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813692; x=1796418492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ykO+DvzoUci+U4mYz7iUfTXDAYMPO0cTzIvQjxhwdc0=;
 b=z4T8Kf0DUAqXZWsU34ISLadRHTUD0vZmbTboSRJ6wmYnt5WlZCwStv0Bmwe3AaGU5A
 996Oy701/kMIOp2aeroSymIUItTRwUyrv6oV0yz3pebr2ylbvS4p21gUvjlnW7N/1D9g
 gkcHmis/Z01XgUe1fYuQmwJ028Rm0mZOzuQhsF9dM4hboVPHdqQ+rrUDWxHbUyXTii/K
 IO8jmLrDF9u2ekbPhDC4cYn/+xFTDxKQkofJe8CoDQnC7EXsRpDkMyvNHtml/x/0gruL
 ZKIBAHE6bEX51+KwH1R4vkUqa+vAEOOgnzDhrwW6ezJ96WFa81/MKJMj5moB9eObCbne
 p9rQ==
X-Gm-Message-State: APuU4Z+H0xqgQxkts10MoAA5lJhIvrbLoXBy30lFkWtbpeqpIrjOjOCJ
 ihZQilM4TNrzOuYwsHo90P0+4NLPplcEokSLzz3AMpb7v1ffHpQqraCut1PCMRgcsW5NEBdRKEn
 zsrbkvqQ=
X-Gm-Gg: AZFdTZcr1wLP34EFf16rsrhRd2CFQcRubzikTyAqEbpPEt4vNOzYtNlB7PWNFrirtay
 pQDv7ABqDgfJWMhlZSkhnDaGDIEMxlwV6lIPTtk2y90M+tNg7SlaWd/0+DmvcToox6akPhdswdK
 J+vPnBlOl7SlitPvI0UshcR9UeARRwqq04kgdIzhb2iqbdCIVcU+3Bcujaa9yXWFCzMmhq0l9W+
 QdCVHtM0JnBarPLzHg3sA8YRtpDNe6+6zkr8esewuOOfjMmQybM6w6gMPaEbpTolLxxXKwKRhU/
 /YhNnLXHnV1FFQtn0kFeap04btddUDlMNG6tEedk5gD8K5VxluPMzhE/SFyel1D0MwiwHIqFKHJ
 C+Xuso6DtTX3krseDLjaat98qLI9NQbi3mfE7nVlPYzgzNzdZm4rcMJOaLMTTwNIS6eKnJ8qX3E
 1v6D+CssGrNlVaE4YvEeXUtPjmfhOSL6LKfpdpjrWek5F7itiHMglpm6RBZRiWKFG7SSqHtvBeQ
 th6f9d6LFY+JmbQZWpfX6O4QqAY2Stp/zd5rLsk2mdGLQWi5rXwL/RnT96uw7/pZGcnd7odbEvX
 C5PM5Yd9VqnP97V9lZOnUeItRfl2TP4hJurde4Evbp/V3uwnyZODXely1+RNr+uV4ahC
X-Received: by 2002:a17:90b:4a48:b0:3b3:af45:6a6b with SMTP id
 98e67ed59e1d1-3b41c7b5e76mr26118871a91.3.1795813691801; 
 Fri, 27 Nov 2026 13:08:11 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 2/6] pdump: fix error code when adding callback fails
Date: Fri, 27 Nov 2026 13:07:04 -0800
Message-ID: <20261127210806.318387-3-stephen@networkplumber.org>
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

The register functions returned positive rte_errno on failure.
The caller only checks for negative values, so a failed Rx enable
fell through to Tx, and the positive value sent back to the client
was negated into rte_errno, giving messages like "Unknown error -22".

Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 3d494592b3..56a12f96ca 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -283,7 +283,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add rx callback, errno=%d",
 					rte_errno);
-				return rte_errno;
+				return -rte_errno;
 			}
 
 			memset(&pdump_stats->rx[port][qid], 0, sizeof(struct rte_pdump_stats));
@@ -345,7 +345,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add tx callback, errno=%d",
 					rte_errno);
-				return rte_errno;
+				return -rte_errno;
 			}
 			memset(&pdump_stats->tx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
-- 
2.53.0

