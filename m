Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9175606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=oxSYi3bG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9A340E2B;
	Fri, 23 Oct 2026 17:59:19 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 5783040A7D
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=tbj+ZwFET+jYKrd9yuLwBb6zbxQOTcxqYj4rdTuV1oY=;
 b=oxSYi3bGFiK8dHAcYKhBMrQAgBjw4gLO2VEUVOw8ckNafZxAtSOGfGCfia2XH4
 y9vxV1Ezn46Fe/1frOUix3Fywmd3NBag9ctiu2E/9rAfBEry5zk/TdkxKF9JCRc3
 5XU4UWBRLxjgpRBQ5Iwj8FtCGvBnvkgt8ElzMA/wxnW70=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 27/27] net/hinic3: expose Tx queue copied-mbuf statistics
Date: Fri, 23 Oct 2026 23:58:08 +0800
Message-ID: <20261023155809.855-28-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S29
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW8ZFy5urW8Ar4fAr1xAFb_yoWDGFc_AF
 yv93W7Zw4Skr12ya1F9F4xtry09340qFn5AF4IvrWfA347AF4avryj9rsxJryqgrW7AFsx
 uFs3Zan8W3sxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1DDG7UUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNx+5w2rbhB8DMAAA3L
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
 drivers/net/hinic3/hinic3_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index aec2dc42e9..0e50efa442 100644
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

