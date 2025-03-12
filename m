Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1866C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 21:44:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75A4640DCD;
	Wed, 12 Mar 2025 22:44:01 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 904CD40663
 for <dev@dpdk.org>; Wed, 12 Mar 2025 22:44:00 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id BBFBE210B159; Wed, 12 Mar 2025 14:43:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBFBE210B159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741815839;
 bh=ZsU15eJ840osdXnpVErUATlfMZiVpnSHJjkWlvE3NZs=;
 h=From:To:Cc:Subject:Date:From;
 b=ahnZoWEcUmHJPA9dBbRbW6CmI60RnNTtWuE8Nb+cLeD5WaAjuMCBiVne2rzqbh7Sb
 DlWQHRkRb2gD0d/cz6zVV1uo8RvkmA/F1SWnQpZwyrqJEzPTcU2EN8Qo8Xr0kNxI1b
 1aWvZ2o72RZ5B5zV4Aj4OOR4gSPrav95TCTz5wJ4=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH] doc: announce bus/vmbus API changes
Date: Wed, 12 Mar 2025 14:43:51 -0700
Message-Id: <1741815831-22977-1-git-send-email-longli@linuxonhyperv.com>
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
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

All vmbus APIs are used internally by DPDK core and net/netvsc PMD.
It's not feasible or practical to use those APIs by the application.
Those APIs will be moved from "DPDK" to "Internal" in DPDK 25.11.

Signed-off-by: Long Li <longli@microsoft.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 3f5f0e949c..deb9421be6 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -138,3 +138,7 @@ Deprecation Notices
   will be deprecated and subsequently removed in DPDK 24.11 release.
   Before this, the new port library API (functions rte_swx_port_*)
   will gradually transition from experimental to stable status.
+
+* bus/vmbus: Starting DPDK 25.11, all the vmbus APIs will be moved
+  from "DPDK" to "Internal". Those APIs are used only by DPDK core
+  and net/netvsc PMD.
-- 
2.34.1

