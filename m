Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE2CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B28744042C;
	Fri, 29 Aug 2025 10:24:49 +0200 (CEST)
Received: from lf-2-35.ptr.blmpb.com (lf-2-35.ptr.blmpb.com [101.36.218.35])
 by mails.dpdk.org (Postfix) with ESMTP id 18FC440666
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455882; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/rrJtLoKTXuf5iF8VQLwv6eKfc1E7WYPpQnVciM1+kM=;
 b=RAoZ2pehJHK1GR4vHKOatzbwvdtTek3r++69SGtoL1nKIpFiFfUgKkzMRoJM2ZEqxpf3Gh
 xTCvmoRrDHg1Jg+1tioW7fLgB/xEtZ+nkkWpFEYYWHcEl0/WR9/FPeFA/KBZQuKNPkmgVQ
 7VEkZDOp535JQTwuWwXro7qkvBGbWFdpifAFidz1177mmkeVLojugbdAN5NY5PF/9U3wt9
 dGKsxJ2yjypkFkY/Z8/6ylJaDFn66V798evoX4p/2UUVdgHg0rX/Phl+URt1HUSA0MStfd
 RldnJhk0/PXBRfONsR3Wyo3qqe9I5OWTrxLGO2fcH/kVmy41/j66qhnmCuG+Kg==
Content-Transfer-Encoding: 7bit
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:40 +0800
Message-Id: <20250829082438.24369-15-wanry@yunsilicon.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268b163c8+e92c80+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Subject: [PATCH 14/14] net/xsc: update release notes for xsc PMD
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:40 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
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

Add recent updates of xsc PMD to 25.11 release notes.

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/rel_notes/release_25_11.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 122029b3c8..f1cb435689 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -64,6 +64,19 @@ New Features
 
   * Enabled software taildrop for ordered queues.
 
+* **Updated Yunsilicon xsc ethernet driver.**
+
+  * Add FW version get
+  * Add TSO support
+  * Add module EEPROM dump
+  * Promiscuous mode support
+  * Link status support
+  * Link event support
+  * Add FEC get and set
+  * support per port for multi-process
+  * Code optimizations
+  * Coverity issue fix
+
 Removed Items
 -------------
 
-- 
2.25.1
