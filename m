Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6606C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9D540B8F;
	Sun, 22 Feb 2026 18:33:00 +0100 (CET)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id 07D8040661
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:47 +0100 (CET)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-4042fe53946so1574265fac.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781566;
 x=1772386366; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8bJGXHEGuhpN+MkB+4XFmxJlih1mBH6lHYmj44C6JU=;
 b=tkuALlUJkGONPVKA2Sq0vR2XZNeS4Llb+dgI1LthRzaMNfAZI+X8IsXXk5PjiDhaA5
 YfpwF606StBOBRq2xAOyNb2IA9FmGQpB7n7atBg0jFqByU7SdJk6+W0F+FbolgRL5mwb
 G/EQOJIbNgGmfNv6skuDKyahzqTyotV3omRbagIyqKJ22AF3p1I8VlOhFhWdfZ6cZwYn
 sObNbuI1dHQkXz0EUTwAp9fcHNCvdB7p5mHmach/Kr8Ce8+64wkX5KA+UMuDR6YSV+MM
 LgfKi8gf6yl8aQ0IO+dlOcQwqqINJmB3UHho2SfkDN4jRiPJZXwlSRRrfpgNBx4WICJr
 4Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781566; x=1772386366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8bJGXHEGuhpN+MkB+4XFmxJlih1mBH6lHYmj44C6JU=;
 b=nXmFs7yg/sesa1d3OxdZIUgcq2+RPGGjX7qo0+n9sAM8M1KG9MG4jlNcM8LrgW/Ac+
 AV3MliQL25HjQ8vq6aejBNg1/fiWu99wJ3Ct8y8zCd20GukLkNhV9dK8mHkJWmhMWrN2
 t7wyS2coqhotSfZLr9U6iwD/7mPDmjAkdiXwg17Px0SbzUgNTpPGZ2Mz2JLBEyqLXJzk
 IxIW/HTmk55F/iGi41fqx7Fu6mGRNkCohKHt41rrEBRmDeda+gdOOhLjPaMOWV6aOHbD
 ajVFuvVgw6c/BCxVnVjIah0p43UMJ0Mio4xAgb6zfehgrMz1IrOeojJ0yJu0qmNP7GII
 +MwQ==
X-Gm-Message-State: AOJu0Yyh4dydDQ1AszJy8bVLavcxBXy3jz29szE9DbJSHwOYuskszDGG
 AKhLdBP5WzUszhj7mxqS+GRjxIHVZBR6aRwifRfvi4zqGJpem39adnsagfSMlZMHeK4YNdzor6m
 +2hC1
X-Gm-Gg: AZuq6aI7dfY3Di6Zxr85qAJU4vujPVGuIaVr3sGk+vldo4DvRj5WZjAucly4EdXywjG
 bpgLVyZZ92OccOywjdOWnXj+WIpyoNcCFpyzxNInbMwrxHgPZjGSHXsIfo7EKvOkhkX2lvPmh17
 /wU1kcsh7SK1/pMHaya/ANCVe/5KbaBwcPj4Tmvbon4hZo8mMrY1OMvRhnOFFrIOji+4CXCh1Uz
 CiPiUybaG0ice0KQgKNq/7zGWNK15OhLOBdYfrrU7pQEZoVpONXoe0+uPvChK67B+GmA5sasaPF
 SSeKT1hh/EDcUFGBdZxC6E5LiATSYaUrbaTUussdRohRRKLKxuxJp1d7yFiT6vM05M1UBer+Hbp
 n6qF5hfS+7W4hwlbBR2DOTOWtRXVhdrO9EqU0ZCjLI6bDx/2Vog11eexFSKhYqShu9DX2/LWyo4
 cSQeVSgWHXtrYBRlfb0B/JhLC3OM3xmegw6zzRIHxIcrqB2WZdHpBNodt5w1i5zg==
X-Received: by 2002:a05:6870:a195:b0:409:90b3:fed5 with SMTP id
 586e51a60fabf-4157ac24e5fmr3539025fac.15.1771781566337; 
 Sun, 22 Feb 2026 09:32:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 16/19] net/tap: replace use of VLA in transmit burst
Date: Sun, 22 Feb 2026 09:30:51 -0800
Message-ID: <20260222173225.522754-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

Replace the per-packet variable-length iovec array on the stack
with a fixed-size array of TAP_MAX_TX_SEGS + 1 (129) entries,
hoisted to function scope in tap_write_mbufs(). Packets with
more than 128 segments are dropped.

This eliminates the last VLA in the driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index f2cf7da736..9efdbc7012 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -79,9 +79,15 @@ static_assert(RTE_PMD_TAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "TAP max queues excee
  */
 #define TAP_MAX_RX_SEGS 128
 
+/* Limit on the number of segments per mbuf on Tx */
+#define TAP_MAX_TX_SEGS  128
+
 static_assert(TAP_MAX_RX_SEGS + 1 <= IOV_MAX,
 	      "TAP_MAX_RX_SEGS + 1 (for tun_pi) must not exceed IOV_MAX");
 
+static_assert(TAP_MAX_TX_SEGS + 1 <= IOV_MAX,
+	      "TAP_MAX_TX_SEGS + 1 (for tun_pi) must not exceed IOV_MAX");
+
 #define TAP_RX_OFFLOAD (RTE_ETH_RX_OFFLOAD_SCATTER |	\
 			RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |	\
 			RTE_ETH_RX_OFFLOAD_UDP_CKSUM |	\
@@ -533,13 +539,13 @@ tap_write_mbufs(struct tx_queue *txq, uint16_t num_mbufs,
 			uint16_t *num_packets, unsigned long *num_tx_bytes)
 {
 	struct pmd_process_private *process_private;
+	struct iovec iovecs[TAP_MAX_TX_SEGS + 1];
 	int i;
 
 	process_private = rte_eth_devices[txq->out_port].process_private;
 
 	for (i = 0; i < num_mbufs; i++) {
 		struct rte_mbuf *mbuf = pmbufs[i];
-		struct iovec iovecs[mbuf->nb_segs + 2];
 		struct tun_pi pi = { .flags = 0, .proto = 0x00 };
 		struct rte_mbuf *seg = mbuf;
 		uint64_t l4_ol_flags;
@@ -641,6 +647,10 @@ tap_write_mbufs(struct tx_queue *txq, uint16_t num_mbufs,
 		}
 
 skip_l4_cksum:
+		/* tun_pi header + packet segments must fit in iovecs */
+		if (unlikely(mbuf->nb_segs > TAP_MAX_TX_SEGS))
+			return -1;
+
 		for (j = 0; j < mbuf->nb_segs; j++) {
 			iovecs[k].iov_len = rte_pktmbuf_data_len(seg);
 			iovecs[k].iov_base = rte_pktmbuf_mtod(seg, void *);
@@ -669,7 +679,7 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint16_t num_packets = 0;
 	unsigned long num_tx_bytes = 0;
 	uint32_t max_size;
-	int i;
+	unsigned int i;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
-- 
2.51.0

