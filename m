Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC7C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 20:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CBC04068A;
	Tue,  4 Feb 2025 21:57:42 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 58421402DC
 for <dev@dpdk.org>; Tue,  4 Feb 2025 21:57:23 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D8F32210D0C8; Tue,  4 Feb 2025 12:57:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8F32210D0C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738702641;
 bh=SRTZ560hU6hoVKD+Fkx5M+2z0vU/hDztzmfhWxbC+cE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=An79d0AvJwz4tjhy6oYasnMCinRnX44GOs2yZeoJgaJ8t0EP16HOMed21UYVp6nK2
 nbKdEck0HJsRYXrXNGHBBWvRy+IVozLnP9KCUcNdk7f01n9T4CdzabSUtL8p2SLNw0
 wFp3kV1w2nHUSzpM95mbWgf8VYZl4idxY1ylLhOI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v21 19/27] app/testpmd: remove use of VLAs for Windows built
 code in shared_rxq_fwd
Date: Tue,  4 Feb 2025 12:57:10 -0800
Message-Id: <1738702638-22363-20-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/shared_rxq_fwd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test-pmd/shared_rxq_fwd.c b/app/test-pmd/shared_rxq_fwd.c
index 623d62da88..b85830b90e 100644
--- a/app/test-pmd/shared_rxq_fwd.c
+++ b/app/test-pmd/shared_rxq_fwd.c
@@ -92,7 +92,7 @@ forward_shared_rxq(struct fwd_stream *fs, uint16_t nb_rx,
 static bool
 shared_rxq_fwd(struct fwd_stream *fs)
 {
-	struct rte_mbuf *pkts_burst[nb_pkt_per_burst];
+	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
 	uint16_t nb_rx;
 
 	nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
-- 
2.47.2.vfs.0.1

