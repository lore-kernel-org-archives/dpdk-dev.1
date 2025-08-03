Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADDC87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 16:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94484026C;
	Sun,  3 Aug 2025 18:16:25 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 95B46400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 18:16:23 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so3150745f8f.0
 for <dev@dpdk.org>; Sun, 03 Aug 2025 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754237783;
 x=1754842583; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NhkwnF+i2UrZETa42sBcli/499UojX672KMeQwUu1m4=;
 b=ZmtFXslJuxv1O9yXlWWZrg8Dg0E482VbT2WP+8fgND/jTEWMoLyi4UYqd/gnwiJXNc
 ARMp668Bjl+BsHq8HsdsjAjxzkZG+53i8WzlSakZWZ/vAAOP5jIeYDnITMXXDWTDhLGU
 y9YPMRBP0ZDndtJlry6nAtJFBX3xCnHxnowS4t9QqtKXgySmDiGYlJ87eWSGE6z75/km
 6qLfDt9IVii8OZKazRU025Q8CXLUmzyKLQd2CH78XZ2Hr1n8Kr9eVBe9QaengSJykijL
 kh+bvPrcT8mOZroEFPQeXZ5+Db9dyOEHoKZbjJbGWHlGlBxtRdX+FyfRxToBD77sXCrN
 owyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754237783; x=1754842583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhkwnF+i2UrZETa42sBcli/499UojX672KMeQwUu1m4=;
 b=cLs+gcBEcLNerXWs2eu+EvxK2J1+ovONWwbLDGbzK4K4KyDWRLhcSgVXDMFQLX/UrE
 JxzLJ38ppXE6lfMcGvVAwuWhAMmjakqzgvc6T1nRHwnWmO7LTV+BXADfwvXf3HxODN98
 byKcXQkB8PxIoudp4Pv4wXXfSm6nazk3A7w9Q8pGO57syRt2cj5lIkfvN5kzTH7C0WPV
 SmwvvM7Tyt/q/UfJbXbJh+M3+eDX4/LRjKIb0OowMOU4AtSMngAZ3lXynwHBGzW3uI5k
 nMkHW3uWdc0HvAmsIu+4TyB9PWtY1eeUq98Z9Z6bi3B9IgMSY0/ZW1sNHux8ytnLxAF5
 sHMA==
X-Gm-Message-State: AOJu0YzOx/cShkTcg2ufzUGWhnsRTRSsOAGK177QWwqeQRTCIx/T6AAa
 BlqYZWaHs4KQLCF2BIpAZYuXEWVMwWNrts7STTMUxf26TLn1dXn90KMvUNxpBSlj0qNFacb3Vz0
 Bc7PR
X-Gm-Gg: ASbGnctY4+nuuJi9WrlNKH5E5kqfG4rNubhcqBnixDtvBOdNA6wFSIvggGoFk4qIy0g
 NynxbKc73Fi7mOqp0LWaOpX3/9X6p+V0bOHHvcZ8QgSQqUq7Y7hFMTHmHkOeO6KjM9Q1jyxUl8Z
 7Zzgv3alGqoDsrIgrWH97ErkgorNZ3+jHEj/7dj4hmQUcJkTMHxmUGHCw9Sb6gu4ComuYj6ORt1
 UQRwQCIp7La2xR86eBYQN9YaRLj4hoP7n8TmnqCvMP+jTUDIvS9VkD5VeR6zJ4LiKoFpuG2oMoI
 Z0IqTbUrJWr6vXFYwpmt5bArn7YZK+4TIUdqEq7wHun2pxodwkK0WBrq+wkb8O1vLIj/cX+NrcV
 i/3I2eiar1EsRmZB9ZYyrYWQOOqAbUqBN5SBXQ4uATREUqD4eY6RqwQqVGhVeEN1vSt+xwIPsxs
 QeKm1MLgs=
X-Google-Smtp-Source: AGHT+IH3MFHOOICb2UjimUClWGn7N3SI5Sm+XLnFyDWSuhSEPHxd6RnhBplP5OokWsDtKk33Tj/cVQ==
X-Received: by 2002:a05:6000:2387:b0:3b7:9c79:329f with SMTP id
 ffacd0b85a97d-3b8d94c47admr4206038f8f.45.1754237783029; 
 Sun, 03 Aug 2025 09:16:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47c516sm12683361f8f.62.2025.08.03.09.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 09:16:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH] bpf: remove dependency on vla
Date: Sun,  3 Aug 2025 09:16:17 -0700
Message-ID: <20250803161617.36653-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The code for ethdev callbacks was using variable length arrays
which is a feature not supported on MSVC and later C standards.
Replace with alloca().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c   | 16 +++++++++-------
 lib/bpf/meson.build |  2 --
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..6a425d79b6 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdint.h>
+#include <alloca.h>
 
 #include <sys/queue.h>
 
@@ -163,10 +164,11 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf **dr;
 
-	for (i = 0, j = 0, k = 0; i != num; i++) {
+	dr = alloca(sizeof(struct rte_mbuf *) * num);
 
+	for (i = 0, j = 0, k = 0; i != num; i++) {
 		/* filter matches */
 		if (rc[i] != 0)
 			mb[j++] = mb[i];
@@ -193,8 +195,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	void **dp = alloca(sizeof(void *) * num);
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	for (i = 0; i != num; i++)
 		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
@@ -209,7 +211,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 {
 	uint32_t i, n;
 	void *dp;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -228,7 +230,7 @@ static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
 	return apply_filter(mb, rc, num, drop);
@@ -239,7 +241,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
 	uint32_t i, n;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 28df7f469a..aa258a9061 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -7,8 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-cflags += no_wvla_cflag
-
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_32')
     build = false
     reason = 'not supported on 32-bit x86'
-- 
2.47.2

