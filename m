Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF99AC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 01:40:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31FC340A84;
	Wed, 19 Feb 2025 02:40:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 85B5340A73
 for <dev@dpdk.org>; Wed, 19 Feb 2025 02:40:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 848CF20376F3; Tue, 18 Feb 2025 17:40:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 848CF20376F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739929207;
 bh=Ny/2pmQAD5kHK1kRT54uQWLsqGHeaEegBE/4Kdz9W9w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dn9KHKNbKT+/Pqs2Wh8epIjVfH03UTMznbpg3Ggpals/NFYUPGrJg97oDoWjk73S0
 oUVzvXtEDJ4LCRfYgx6jtgconCzg6U12aDKLMH7kmOpBs4fiAL5bzIeynxCY+TF1tb
 qjW5lZc6ZI0haNuUTzHwov4D0htxNqNYbi/dP9xE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 4/5] net: update use of versioning macros
Date: Tue, 18 Feb 2025 17:39:57 -0800
Message-Id: <1739929198-28432-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling with MSVC the error below shows up due to function
versioning:

../lib/net/rte_net_crc.c(418): error C2061: syntax error:
    identifier '__attribute__'

MSVC allows alias function names to be exported, but the mechanism is
different than the one used by gcc. It was considered to enhance the logic
in the existing version.map files but that file is also passed to other
tools on Linux, making this challenging. A simpler approach is to have an
optional version.map file to be used only when Microsoft's linker is to be
used. This optional map file is only necessary for libraries that have
versioned code.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/net/rte_net_crc.c         |  2 ++
 lib/net/version_ms_linker.map | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 lib/net/version_ms_linker.map

diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 2fb3eec231..5b41085a36 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -418,6 +418,7 @@ BIND_DEFAULT_SYMBOL(rte_net_crc_set_alg, _v26, 26);
 MAP_STATIC_SYMBOL(struct rte_net_crc *rte_net_crc_set_alg(
 	enum rte_net_crc_alg alg, enum rte_net_crc_type type),
 	rte_net_crc_set_alg_v26);
+MAP_STATIC_BASE_SYMBOL(rte_net_crc_set_alg, rte_net_crc_set_alg_v26)
 
 void rte_net_crc_free(struct rte_net_crc *crc)
 {
@@ -449,6 +450,7 @@ BIND_DEFAULT_SYMBOL(rte_net_crc_calc, _v26, 26);
 MAP_STATIC_SYMBOL(uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx,
 	const void *data, const uint32_t data_len),
 	rte_net_crc_calc_v26);
+MAP_STATIC_BASE_SYMBOL(rte_net_crc_calc, rte_net_crc_calc_v26)
 
 /* Call initialisation helpers for all crc algorithm handlers */
 RTE_INIT(rte_net_crc_init)
diff --git a/lib/net/version_ms_linker.map b/lib/net/version_ms_linker.map
new file mode 100644
index 0000000000..9503c669d1
--- /dev/null
+++ b/lib/net/version_ms_linker.map
@@ -0,0 +1,23 @@
+DPDK_25 {
+	global:
+
+	rte_eth_random_addr;
+	rte_ether_format_addr;
+	rte_ether_unformat_addr;
+	rte_net_crc_calc=rte_net_crc_calc_v26;
+	rte_net_crc_free;
+	rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
+	rte_net_get_ptype;
+	rte_net_make_rarp_packet;
+	rte_net_skip_ip6_ext;
+
+	local: *;
+};
+
+DPDK_26 {
+	global:
+
+	rte_net_crc_calc=rte_net_crc_calc_v26;
+	rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
+
+} DPDK_25;
-- 
2.48.1.vfs.0.0

