Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B79C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3500040647;
	Thu,  5 Jun 2025 16:47:32 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DC31840613
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:47:30 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 00A63201FF21; Thu,  5 Jun 2025 07:47:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00A63201FF21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749134850;
 bh=XRjM/sS7zR+OZxN/CUliATWL1mZNHEjMBEkjDuRaQPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eYuS1kUPH6sksBWqFIcVKYPCYP1rXCYv9llHR3zsTUFHcrkjssKW7e5HmgD1BUlEJ
 HAxq1VXt2UerMreErbHbF+4BLjsQArBADJKL8BD3qrBTH5V+d4h+uOvyvrdT2cNfko
 EPqkmkR6NmdkvOEDTm4C3YIQkjcS3ouQoztYe0ME=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v6 1/1] net/intel: define __builtin_add_overflow for MSVC
Date: Thu,  5 Jun 2025 07:47:25 -0700
Message-Id: <1749134845-30062-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749134845-30062-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1749134845-30062-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. A macro needs to be defined
for code using this to be compiled with MSVC.
Since only one driver is using this, this patch adds the macro to
that driver only. It can be moved to some common place if/when
needed.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/ice_osdep.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index ad6cde9896..4f635f00a4 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -128,6 +128,15 @@ writeq(uint64_t value, volatile void *addr)
 #define wr64(a, reg, value) writeq((value), (a)->hw_addr + (reg))
 #define rd64(a, reg)        readq((a)->hw_addr + (reg))
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __builtin_add_overflow(a, b, res) \
+	_Generic((a), \
+		uint8_t : _addcarry_u8, \
+		uint16_t : _addcarry_u16, \
+		uint32_t : _addcarry_u32, \
+		uint64_t : _addcarry_u64)(0, a, b, res)
+#endif
+
 #endif /* __INTEL_NET_BASE_OSDEP__ */
 
 #ifndef __always_unused
-- 
2.49.0.vfs.0.3

