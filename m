Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF3CC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 20:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0048F402D5;
	Mon, 17 Mar 2025 21:09:48 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 742EE402D0
 for <dev@dpdk.org>; Mon, 17 Mar 2025 21:09:47 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id BC5F32037F8F; Mon, 17 Mar 2025 13:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC5F32037F8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1742242186;
 bh=LIlsYW9dRw0nX/4WGflHSgsrYP9xiLgZPSQS0YDtAwI=;
 h=From:To:Cc:Subject:Date:From;
 b=Q+DrxBClurMVznsbXynWc5v67z7rxvNtXW+v5HKUfQPpCHPVbY3c566UKxmjkrQ+g
 AmlxlWk6ZaYiOFMEa2WFMkRdrJ/v1QoyaXKptP345TdObNsL7M/ljPx1GoxTyoyfrT
 uDCmldUS8QwyF5b40iThZlNkVwp+JyyY8Z2bEYPk=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3] doc: announce bus/vmbus API changes
Date: Mon, 17 Mar 2025 13:09:44 -0700
Message-Id: <1742242184-19600-1-git-send-email-longli@linuxonhyperv.com>
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
Those APIs will become internal in DPDK 25.11.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in
v2: add details on what APIs will be changed
v3: remove the reference to version.map

 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 3f5f0e949c..9d3fb318f3 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -138,3 +138,7 @@ Deprecation Notices
   will be deprecated and subsequently removed in DPDK 24.11 release.
   Before this, the new port library API (functions rte_swx_port_*)
   will gradually transition from experimental to stable status.
+
+* bus/vmbus: Starting DPDK 25.11, all the vmbus APIs defined in
+  drivers/bus/vmbus/rte_bus_vmbus.h will become internal to DPDK. Those APIs
+  are used internally by DPDK core and net/netvsc PMD.
-- 
2.34.1

