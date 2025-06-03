Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A1C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 00:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12CF44028E;
	Tue,  3 Jun 2025 02:32:11 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CCB004025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 02:32:09 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id CC5B8206789F; Mon,  2 Jun 2025 17:32:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC5B8206789F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1748910728;
 bh=EYCyKqolryF+HdLTdxcysokyqGZqZFSIfkhKrf777wk=;
 h=From:To:Cc:Subject:Date:Reply-To:From;
 b=fyFldldvQcubQJQcjqGdIinvUIzMrBfbAIJuNdik3M9QP18EqSQ1R635reydDH/N9
 b9Eand79dRur2b8OiDZvtkwfr5dH5qCZhX5m8n11SdmN2l1yqSF2agTKk/DRZcWbPZ
 9yq01+QNp/AbXRst1dkRS2QEncj/1mIK5S5pDO3A=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] doc: remove the public interfaces from bus/vmbus
Date: Mon,  2 Jun 2025 17:31:44 -0700
Message-Id: <1748910704-25463-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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
Reply-To: longli@microsoft.com
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

The deprecation notice has been sent in
7642e3b0e0 ("doc: announce vmbus API deprecation")

Remove those interfaces in this release.

Signed-off-by: Long Li <longli@microsoft.com>
---
 doc/guides/rel_notes/release_25_07.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 6b070801de..672307da6c 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -125,7 +125,8 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
-* No ABI change that would break compatibility with 24.11.
+* All the vmbus interfaces defined in ``drivers/bus/vmbus/rte_bus_vmbus.h``
+  become internal to DPDK.
 
 
 Known Issues
-- 
2.25.1

