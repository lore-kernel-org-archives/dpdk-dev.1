Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DFCA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A5364065A;
	Sun, 11 Oct 2026 20:23:03 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 1E33740664
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:23:02 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so861228a12.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742982; x=1792347782; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MDzGolt2Ggks4bezHb9ufFRty6aXgABsi3/XqI6nMog=;
 b=H55ppasmcmFgaL/IAP70JMEmxQmWXPi1psew3QkmivxcJv/bv7aNz64VvKh5EGKGQU
 8lBoryrqZ2sOpecSjBhE7hAW65q9sazVYYCpbeJuHz3jHnf8PHq+5QE+z67nFIGCnpGW
 P/z9rTGJcerHK2cyb6tFPN88bwlF3n0KL+Jc/t66XWaxot20/YN/YWsPmYUJfU6ZKyVX
 AEZkMgdCsXZkiOWiZkoKVSDBCiPqcG0/9J2cmGyqnWZ6l2yvuh2HhrdkTLknZzA/LjX9
 IaBBmuNcsAFygPieli+vNt3vkfXEbIsJLSMwZPxtRvl133IJP1EFyuCgUWziaABx5ElM
 BORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742982; x=1792347782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MDzGolt2Ggks4bezHb9ufFRty6aXgABsi3/XqI6nMog=;
 b=pcCrs721D3/eMkjXsx+JxyfjcBnNuTaLYH5mWCUh8anGqtXxex2oGBVcVRJUs/KWff
 WLzBLkhoGk3eEVu9/yh5zjRTGJ/gKKD4XMurrmLh08GlyioM7hdWZFKXkyd5YewGvR71
 Aeh/ZdC5hOQNS/M1FEAyPlC1WUHp4ZA26m3u/J12roxDbv6d6tWMDPDAT7jUx+JVcBts
 bObqpahOyfE/SUWE3RUMW2hQdKJU2aARs0CbArT+cHXyixyOofxihaWpMishB5Xb8yb7
 zK8B17uPhMGlzgSOeW081fKjoCuoOvhsRVIOu1ib+a0B2hBW/eMo8ZDxy5g3UTL990sN
 nyow==
X-Gm-Message-State: AFq9FYKtUfiL1UutBfmuvLd5VxXKSym3bcSwOr6AadEf8NlMq8z8e1FQ
 zAyoPkp1NASPP+TFryvuACYDm2ir0JVoZcizHmvAaGWpQw2+LV4OA5QU6hmtbKi4bIU=
X-Gm-Gg: AYBFou0hoi/tX/LA7dLdurTP6G1YAN7yx51Qishiob6nBtSX7+yZHEvUtVZd81V+Xxf
 fN5fyyVCuaqbPVh6kPQCee8BtXwy+7u6Gt8+tQOBJJlnMCIybPNJ3+rVlEtTUE77h+XDzw8k7NC
 pxwPT13iPhTa45zL63M4aSZbo7b8cwpCAvX1VX7P2luDVfO4P6iRNraiQ4KeHyllVldWtbj9jp5
 LmBdGpd6MAC+1Y6Urzh9N0jwrP3OYmHAuK+7zG6VTo2w/bqdPI9tNzQJ+LwdL8IJuam1VVWzbKN
 E4HXUuxz11MChkVhCfsdTncr/iOj2QqF3EGFbK/MY2ABDR6IyAvClSvxa1pgTNXI+rt6dpOKmXr
 V5CReEOFLnsXWh36qHEBKTrePmUyNCTEzXK6cEFOjlGVrh5oANSHKKY8nqXCef4ASzAEOrdqz5g
 P3KY2uJZi2f1BTWw9GwTds0uuhlRJXBY75Zzf4S+TcjTsSw5DMQ512lgazvzo=
X-Received: by 2002:a05:6402:2786:b0:6aa:f1d2:ddb8 with SMTP id
 4fb4d7f45d1cf-6b17c25f857mr6724375a12.23.1791742981295; 
 Sun, 11 Oct 2026 11:23:01 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:59 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 6/9] bpf: simplify callback inuse tracking to boolean flag
Date: Sun, 11 Oct 2026 18:21:54 +0000
Message-ID: <20261011182158.124246-7-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

The even/odd usage counter semantics in struct bpf_eth_cbi was
originally used to detect when in-flight packet callbacks complete.
However, with at most one thread running the callback per port/queue
pair and no risk of the ABA problem, a binary flag (1 for in use,
0 for idle) suffices.

Replace the counter increment in the datapath with stores of 1 and 0,
and simplify bpf_eth_cbi_wait() to wait directly until the flag is 0.
Update the documentation and synchronization sequence diagram
accordingly.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 lib/bpf/bpf_pkt.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 68671848e9..7ae64ed7d0 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -36,12 +36,12 @@
  * 2. Member `cb` of struct `bpf_eth_cbi`;
  * 3. Member `use` of struct `bpf_eth_cbi`;
  *
- * BPF program is only executed if the first two are set, and increments `use` at the start and
- * end of the callback execution so that in the safe state its value is even.
+ * BPF program is only executed if the first two are set, and sets `use` to 1 at the start and
+ * to 0 at the end of the callback execution.
  * This relies on only one thread calling the per-port/queue callback at a time.
  *
  * Unload processing starts with clearing the first two entities,
- * then waits for `use` to become even before destroying the BPF program.
+ * then waits for `use` to become 0 before destroying the BPF program.
  * The whole operation is protected by a control-plane-only spinlock (not shown on the diagram).
  *
  * Typical sequence of synchronization actions between CP and DP on unload is shown below:
@@ -52,7 +52,7 @@
  *     |                      |               |              |              |                |
  *     |                      |<---------------------- fetch callback -----------------------|
  *     |                      |               |              |              |                |
- *     |                      |               |<------------- increment to odd --------------|
+ *     |                      |               |<------------- store 1 -----------------------|
  *     |                      |               |              |              |                |
  *     |-- remove callback -->|               |              |              |       rte_smp_mb()
  *     |                      |               |              |              |                |
@@ -62,17 +62,17 @@
  *     |                      |               |              |              |                |
  *   rte_smp_mb()             |               |              |              |                |
  *     |                      |               |              |              |                |
- *     +-if use is odd        |               |              |              | if cb not NULL-+
+ *     +-while use is 1       |               |              |              | if cb not NULL-+
  *     | |                    |               |              |              |              | |
- *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
+ *     | +------------ fetch 1 -------------->|              |              |<-- execute --+ |
  *     | |                    |               |              |              |  BPF program | |
- *     | +-while use is same  |               |              |              |              +-+
- *     | | |                  |               |              |              |                |
- *     | | +---------- fetch odd ------------>|              |              |      rte_smp_rmb()
- *     | | |                  |               |              |              |                |
- *     +-+-+                  |               |<------------- increment to even -------------|
+ *     | |                    |               |              |              |              +-+
+ *     | |                    |               |              |              |                |
+ *     | |                    |               |              |              |      rte_smp_rmb()
+ *     | |                    |               |              |              |                |
+ *     +-+                    |               |<------------- store 0 -----------------------|
  *     |                      |               |              |              |                |
- *     |------------- fetch even ------------>|              |              |                |
+ *     |------------- fetch 0 --------------->|              |              |                |
  *     |                      |               |              |              |                |
  *     |----------------- destroy BPF program and cleanup ----------------->|                |
  *     |                      |               |              |              |                |
@@ -87,7 +87,7 @@
  */
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
-	RTE_ATOMIC(uint32_t) use;    /*usage counter */
+	RTE_ATOMIC(uint32_t) use;    /* usage flag: 1 when in use, 0 otherwise */
 	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
@@ -98,8 +98,8 @@ struct __rte_cache_aligned bpf_eth_cbi {
 };
 
 /*
- * Odd number means that callback is used by datapath.
- * Even number means that callback is not used by datapath.
+ * 1 means that callback is used by datapath.
+ * 0 means that callback is not used by datapath.
  */
 #define BPF_ETH_CBI_INUSE  1
 
@@ -141,20 +141,20 @@ static struct bpf_eth_cbh tx_cbh = {
 static __rte_always_inline void
 bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
+	cbi->use = BPF_ETH_CBI_INUSE;
 	/* make sure no store/load reordering could happen */
 	rte_smp_mb();
 }
 
 /*
- * Marks given callback list as not used by datapath.
+ * Marks given callback as not used by datapath.
  */
 static __rte_always_inline void
 bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 {
 	/* make sure all previous loads are completed */
 	rte_smp_rmb();
-	cbi->use++;
+	cbi->use = 0;
 }
 
 /*
@@ -163,18 +163,12 @@ bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
 static void
 bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 {
-	uint32_t puse;
-
 	/* make sure all previous loads and stores are completed */
 	rte_smp_mb();
 
-	puse = cbi->use;
-
 	/* in use, busy wait till current RX/TX iteration is finished */
-	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
-		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
-			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
-	}
+	RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
+		UINT32_MAX, ==, 0, rte_memory_order_relaxed);
 }
 
 static void
-- 
2.43.0

