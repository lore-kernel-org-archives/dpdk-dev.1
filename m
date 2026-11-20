Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C9606A333
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=KUBma+O/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6421E40E28;
	Fri, 20 Nov 2026 17:35:45 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 9DF5240685
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=17Za9iFCDQmCc8pFO/Wny+T0Zq2QhL2UkKi9du8CqKo=;
 b=KUBma+O/7XR9uM4TbzchKDRQbGDShmBCGbO8fAyL965RM4rR31eNwTA3/Yaxxv
 9r2f+J/B9ljl2ngZMkIzM/arjd6XqNDGH23oNAYl5wh+IfOtIl0sFIidlcDkn+yH
 XyEaU8Z1Ds7lkSQjBiFATa9wuNnOd42qldpNWCO9Cn/80=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 28/28] net/hinic3: expose Tx queue copied-mbuf statistics
Date: Sat, 21 Nov 2026 00:34:53 +0800
Message-ID: <20261120163454.1159-29-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S30
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4kKr4DGw48JryruryUKFg_yoW8XFyDp3
 ZxGFWDAF90qa1UAr12ga1DCryrZas8J3yjgr1xK34rZFn5CF1xu3y5J3yIyrnxJ34fA3WS
 vFWIvF97AFWj9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut5rxUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNAeps2sAdscMbAAA3T
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

The Tx path copies mbufs when the segment count exceeds the inline
limit, tracking the number of copied packets and the number of segments
too large to inline. Expose these two counters in the per-queue extended
statistics so they are visible to applications.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 drivers/net/hinic3/hinic3_ethdev.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index aba7601a04..62073ea45f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -180,6 +180,7 @@ New Features
   * Extended TCP segmentation offload (TSO) to 255 segments.
   * Added a compact task transmit data path.
   * Added Tx burst mode reporting.
+  * Added Tx queue copied-mbuf statistics.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 4bbc1a1efb..54d266b1b2 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -287,6 +287,8 @@ static const struct hinic3_xstats_name_off hinic3_txq_stats_strings[] = {
 	HINIC3_TXQ_STAT(burst_pkts),
 	HINIC3_TXQ_STAT(sge_len0),
 	HINIC3_TXQ_STAT(mbuf_null),
+	HINIC3_TXQ_STAT(cpy_pkts),
+	HINIC3_TXQ_STAT(sge_len_too_large),
 
 #ifdef HINIC3_XSTAT_PROF_TX
 	HINIC3_TXQ_STAT(app_tsc),
-- 
2.33.0

