Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39E606A330
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=TrY87Q0A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E0B40E30;
	Tue, 17 Nov 2026 16:58:06 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id D7D59402D8
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=AChxv/LScazIncPnwJ8vXe4h1ccsZn4EwhOwMj1zUlY=;
 b=TrY87Q0Az0r4G4eK8Yq1hdNl5bHvoJAfhcHdGDs8hPkHIgO72YkspFzUozIeYu
 A0wkSEeyv5xQYu3RHKZVGSZT2z4nHgyQL4zIgaZzQzv2aEjssNtLczNfNPKPoS+w
 oVXD948LZW6plMhGyl2xAeWSzim3IeVuKokKDLpN88bn0=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 29/29] net/hinic3: expose Tx queue copied-mbuf statistics
Date: Tue, 17 Nov 2026 23:57:10 +0800
Message-ID: <20261117155711.1048-30-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261117155711.1048-1-yejiacheng4@h-partners.com>
References: <20261109162033.1144-1-yejiacheng4@h-partners.com>
 <20261117155711.1048-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgC3S5drefxqC7WJBQ--.4821S31
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW8ZFy5urW8Ar4fAr1xAFb_yoWDGFc_ZF
 yv93W7Zw4Skr17ta1F9a1Iqry09340qFn5AF4IqrWfA347AF4avryj9rsxJryqgrZrAFsx
 uF4fXan8W3sxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1DDG7UUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhdVX2r8eXcDNQAA3F
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
index 76c52e7d2b..041256ba6d 100644
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

