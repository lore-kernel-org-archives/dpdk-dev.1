Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4ACA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81096402F0;
	Sun, 11 Oct 2026 20:23:00 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 2AB02402E5
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:57 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6ab006eb282so1546601a12.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742977; x=1792347777; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=upmnWBmE5YlMSysNTiV3mDIZUm2vvnFsfOgNAnXcvDI=;
 b=WDsx8Q8XNVqd8Xon8jBlTNekEij1UrSWfoyHbCux7IXnnFjyaq0pZktC0+HqFfzd/J
 e2hehfUrI6KNQ4QQJ6NyfATBqxUlPt0J791UTRVm29KZHAea0S4wTLN8/xy6fGxjkekt
 UMX3md2U/4XQhDgVBJjsnm5e/QKvhGHwKw9DCCi6/bxSocyruEbfVSLGQ0zuV2Z791iO
 8e7VJt53lfpUKVd8yax8EBtZVkGm3LmMTn8BsRNNGMSGE9eSyy5zY4trTkqRkv6xYnlS
 HeTJmZFQht3jZ0NyzKFQrABUkpAqlPTmfOC9KF2sewo8jUY9uvnus1483HpYGeC7AvfD
 lS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742977; x=1792347777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=upmnWBmE5YlMSysNTiV3mDIZUm2vvnFsfOgNAnXcvDI=;
 b=19M4LHmbWAGFO1XsNYVV1nqV4X9kbTM2891m7G2PJq3F2eyz1GG2gyIbvhxscG57ky
 xfD85hGGZBOhu5Q+TsF3v+4s0zM3qCcZRguubYFoNM7lKZdDKl6dYgkJOAu524ClR8aG
 X9GSaPcPqnBVBu7H+F/8fWo9zZMHr1WOMoXlbAIMIiX1VSSzFqP/Z5vy1K/mttazuc4B
 R6/qpTSDSL3aY6Ax0P8tkWgjYSMan5qSr+n/BCUqdhzjXvNUrPWwWh7/W7Vc/wgQc1ou
 X8cTvd1n/uD5bs9AbNNcd0ym5jM4yQZxfm4jNLIecFTyeVx3vpjurH8v66rfQvoWkBaV
 sP3A==
X-Gm-Message-State: AFq9FYIDjmvgmaxd7qIJZMtQGsuMQMljiVkKu1O50vfwSNX4EgRVvb0n
 eehAH6M1otD9ZK/ZwCPG5jubJoL9QwU/Rcj45dSfXpYTYgvmy0+GIeRLLrv6fq3Y8CA=
X-Gm-Gg: AYBFou0x93wZ3U5oG/ZwRPXDgr1z75IsTSfBPi4Pjxe7vUmM/MEHgZXwIou49a2lXNq
 jk2mCTLH4316XL7TWYc2+to863mrMummFAddes4un3CPI8juhSrwFdEBZoDdguHcTKwqXQgHIv2
 wstpdEVJmYGY2hRXMyXbGSRlhIRmiuSIUwJSaSB/W1BdUkliyrqiuDsE4RVtl5V0197ePrEHy/t
 hR7T+pd1ydXz9g3VK04fxHr6wrJW3J9ITJ4tJLwh1lT1pbHjdVnTVQTp/j2vVe1aTH8H0phv+A5
 ZZNolRfBcNZbb+PTNo+n3FHV00DRxQiSoud//fGXB6wko4kWv1EBR6FCcKNnKvUCydhC2Fbsd1M
 iK433Lhm+K+3ln+Sfsr9klPzIWnSUmTxl5tO12mdNd4NApSYalCJ5aDmpmIEmW67/UQLijXtaWM
 5rtBBvQZhQuNYtMpn4I5tgINOoH9axm5KMn1ywxJpwBctqWJZTueIsIJdwM8rK
X-Received: by 2002:a05:6402:21c7:b0:6ae:16f5:5bf0 with SMTP id
 4fb4d7f45d1cf-6b17c270a71mr5131971a12.29.1791742976627; 
 Sun, 11 Oct 2026 11:22:56 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:56 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org
Subject: [PATCH 4/9] bpf: add callback flag to skip multi-thread check
Date: Sun, 11 Oct 2026 18:21:52 +0000
Message-ID: <20261011182158.124246-5-qm2k21@gmail.com>
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

Add RTE_BPF_ETH_F_SKIP_MT_CHECK flag allowing callers to bypass the
suitability check when installing BPF packet callbacks.

This allows overriding rejections in cases where the port or queue is
configured with multi-thread capabilities (such as MT_LOCKFREE),
but the application guarantees that only one dataplane thread
accesses the queue at a time.

Update the unit test to verify that callback installation succeeds
when this flag is specified.

Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 app/test/test_bpf.c      | 20 ++++++++++++++++++++
 lib/bpf/bpf_pkt.c        |  8 +++++---
 lib/bpf/rte_bpf_ethdev.h |  5 ++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 02523984b5..0ab8aa8759 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4692,7 +4692,27 @@ test_bpf_elf_tx_mt_lockfree(load_elf_image_t load_elf_image)
 		goto fail;
 	}
 
+	/* Tx installation must succeed when check is skipped with flag */
+	ret = rte_bpf_eth_tx_install(port, 0, bpf, RTE_BPF_ETH_F_SKIP_MT_CHECK);
+	if (ret != 0) {
+		printf("%s@%d: expected rte_bpf_eth_tx_install with SKIP_MT_CHECK to succeed, got %d\n",
+		       __func__, __LINE__, ret);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+	rte_bpf_eth_tx_unload(port, 0);
+	bpf = NULL;
+
 	/* Rx installation on the same port must still succeed */
+	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "filter",
+			     NULL, 0, &prog_arg);
+	if (bpf == NULL) {
+		printf("%s@%d: failed to load BPF filter image\n",
+		       __func__, __LINE__);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+
 	ret = rte_bpf_eth_rx_install(port, 0, bpf, 0);
 	if (ret != 0) {
 		printf("%s@%d: expected rte_bpf_eth_rx_install to succeed, got %d\n",
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index eab85f7417..7ee16cfa69 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -614,9 +614,11 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	if (bpf->prm.nb_prog_arg != 1)
 		return -EINVAL;
 
-	rc = bpf_eth_check_mt(cbh, port, queue);
-	if (rc != 0)
-		return rc;
+	if ((flags & RTE_BPF_ETH_F_SKIP_MT_CHECK) == 0) {
+		rc = bpf_eth_check_mt(cbh, port, queue);
+		if (rc != 0)
+			return rc;
+	}
 
 	if (cbh->type == BPF_ETH_RX)
 		frx = select_rx_callback(bpf->prm.prog_arg[0].type, flags);
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index cf3b4048f0..7a9f87e6cb 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -13,7 +13,8 @@
  * - in the data plane, it expects only one thread per port/queue pair at a time.
  *   Calling RX/TX burst functions concurrently on the same queue (e.g. when using
  *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or multi-threaded
- *   software PMDs) is not supported.
+ *   software PMDs) is not supported and will be rejected at installation time
+ *   unless overridden by RTE_BPF_ETH_F_SKIP_MT_CHECK.
  * - in the control plane, it is not MT safe, i.e. it is not allowed to do
  *   load/unload for the same port/queue from different threads in parallel.
  * - though it allows load/unload at runtime
@@ -37,6 +38,8 @@ extern "C" {
 enum {
 	RTE_BPF_ETH_F_NONE = 0,
 	RTE_BPF_ETH_F_JIT  = 0x1, /**< use compiled into native ISA code */
+	RTE_BPF_ETH_F_SKIP_MT_CHECK = 0x2,
+	/**< skip check for concurrent data plane thread usage */
 };
 
 /**
-- 
2.43.0

