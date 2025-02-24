Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE5C021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0523E427B2;
	Mon, 24 Feb 2025 17:25:07 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0AED242686
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:24:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B6ACD203CDE3; Mon, 24 Feb 2025 08:24:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6ACD203CDE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740414289;
 bh=liCZLcoycSsNfp5uPsZ3tjg195UlGWkDRisIpPYcHZk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bAitKkJA8tHp2SdBVnujWHwPWh2Is1abSv+hgvALlHdR92ONBrdafgfBoD5K0jr9L
 6sh0b2DXxnqiuL7FwCVwCbZFdpzipgX/Kf1uob+5gMe6GYvzqdQivO60AqEc9azz+s
 QkAp9ixwvCD2M3MKiY12PGEBvrzFZRbQWNH/AnJQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 07/10] test-pmd: don't return value from void function
Date: Mon, 24 Feb 2025 08:24:22 -0800
Message-Id: <1740414265-12217-8-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in the warning below:

app/test-pmd/cmdline_flow.c(13964): warning C4098: 'cmd_set_raw_parsed':
    'void' function returning a value

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline_flow.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 24323d8891..15a18db2c7 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13952,11 +13952,15 @@ cmd_set_raw_parsed(const struct buffer *in)
 	int gtp_psc = -1; /* GTP PSC option index. */
 	const void *src_spec;
 
-	if (in->command == SET_SAMPLE_ACTIONS)
-		return cmd_set_raw_parsed_sample(in);
+	if (in->command == SET_SAMPLE_ACTIONS) {
+		cmd_set_raw_parsed_sample(in);
+		return;
+	}
 	else if (in->command == SET_IPV6_EXT_PUSH ||
-		 in->command == SET_IPV6_EXT_REMOVE)
-		return cmd_set_ipv6_ext_parsed(in);
+			 in->command == SET_IPV6_EXT_REMOVE) {
+		cmd_set_ipv6_ext_parsed(in);
+		return;
+	}
 	RTE_ASSERT(in->command == SET_RAW_ENCAP ||
 		   in->command == SET_RAW_DECAP);
 	if (in->command == SET_RAW_ENCAP) {
-- 
2.48.1.vfs.0.0

