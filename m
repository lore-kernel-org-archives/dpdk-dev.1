Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609DCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB6140E3F;
	Wed, 14 Oct 2026 17:10:11 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 6224D409FA
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=5coWLmtBnpnWuo17599p8bB22BTlTyFD2zzGUSN7a7w=;
 b=Q9+JWu6ztcoh452p+bH8g2X13LGZPj2y4k/Cil4GfPc3wahDtdD56KnxJwXD19
 V3joSI8T0Ds+p/hOPlxAgsGZKIgGY3l8q+vzJbPC+WNAZCmhWXIuE5X6UYELcuSz
 ntfpJCiACFWPy3wcPFClpPDYvqnYboohuVbiVS/uCuK5M=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 24/26] net/hinic3: expose Tx queue copied-mbuf statistics
Date: Wed, 14 Oct 2026 23:09:20 +0800
Message-ID: <20261014150923.838-25-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S26
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW8ZFy5urW8Ar4fAr1xAFb_yoWDGFc_ZF
 1v93W7Zw4fCr12ya1F9a17try09340qFn5AF40vrWfA347AF4avryj9rsxJryqgrW7ZFsx
 uFs3Xan8W3sxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1DDG7UUUUU==
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMx6EjmrPmz4eRgAA3-
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

The Tx path copies mbufs when the segment count exceeds the inline
limit, tracking the number of copied packets and the number of segments
too large to inline. Expose these two counters in the per-queue extended
statistics so they are visible to applications.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 3095b5a571..03d1dffb11 100644
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

