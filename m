Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BECC636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C808440671;
	Sun, 22 Feb 2026 16:31:38 +0100 (CET)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174]) by mails.dpdk.org (Postfix) with ESMTP id 4B9CA402E7
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:55 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTRpepeSHRgDRw64rXEozfYUaOxtMxug7CnSqDEzOZ4=;
 b=mnDlXtbQksuroAzZFh7WS3uT9WkMxZJrDMz1raKEjaIQMhcU4DRKolAl7tXnSCpNQEK0gq
 MulcZlx7uWOH5Wo7EOOwixbnemqw7AcZBFI8FuL9W4GRRgG2afVT8+UMCM521XqMM1m1tl
 gjzK/eP5RZLqBCmeDvo4BSENij6//vU=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Daniel Gregory <code@danielg0.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Daniel Gregory <daniel.gregory@bytedance.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 10/10] doc: implement CRC using riscv carryless multiply
Date: Sun, 22 Feb 2026 16:30:04 +0100
Message-ID: <4aa8dbaacbd6ae38dae2a30c3781f1b1ee62d6d5.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Add to v26.03 release notes support for RISC-V Zbc extension to
accelerate CRC using the Linux RISC-V hardware probing interface to
detect its presence at runtime.

Signed-off-by: Daniel Gregory <code@danielg0.com>
---
 .mailmap                               | 2 +-
 doc/guides/rel_notes/release_26_03.rst | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6c4c977dde..ba36d4310d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -314,7 +314,7 @@ Dan Gora <dg@adax.com>
 Dan Nowlin <dan.nowlin@intel.com>
 Dan Wei <dan.wei@intel.com>
 Dana Vardi <danat@marvell.com>
-Daniel Gregory <daniel.gregory@bytedance.com>
+Daniel Gregory <code@danielg0.com>
 Daniel Kaminsky <daniel.kaminsky@infinitelocality.com>
 Daniel Kan <dan@nyansa.com>
 Daniel Martin Buckley <daniel.m.buckley@intel.com>
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..b5badfb909 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -106,6 +106,14 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Added RISC-V carryless multiplication support in CRC computation.**
+
+  The RISC-V Zbc extension adds instructions for carryless multiplication.
+  Support for using this extension to accelerate CRC computation was added to
+  hash and net. This acceleration is enabled when the Zbc extension is present
+  on the build target and detected at runtime using the Linux RISC-V hardware
+  probing interface.
+
 Removed Items
 -------------
 
-- 
2.53.0

