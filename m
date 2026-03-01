Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6DAFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90C2540E72;
	Sun,  1 Mar 2026 03:07:57 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id C1D5B40E44
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:52 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cb39f64348so327655585a.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330872;
 x=1772935672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dATQtTsshYsZ/M2L/LffGTH+TjSBx0tHK5rA3zh0RQg=;
 b=YISv9md8ubJc+/jG+GcJRvNVc5qq0IgAo6+iBcJSEvywgXQR4sk0A+jtGAvcT3xyps
 SNjTLar9UuwsIuvNCxJtXCHYF/OzwxVDH+i+wHZwsE66z7YBOpfExSV81XJZFMOQ/djF
 LR42sisoXRdLg+j3gCuyDZhe4gqp7rEpsYLAPGfvQtnRSUwpc6YeOmq7AGTlJ+9YhZoU
 ZKEpf05k0r5QfvoL76cYiDGGghTglz8xz117zVHn3Di77h2Nm9RBZMa+KVnFSPY+WDdH
 4qE/P/M1GNNRzBgG/xZhhg4yWBuvW6BCnsYID2TEPHhzA0CDIzBLTNIloNz7rS57RTjd
 kMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330872; x=1772935672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dATQtTsshYsZ/M2L/LffGTH+TjSBx0tHK5rA3zh0RQg=;
 b=ZYDfkMHjux16AxOjO71YmB2vMEKsIg6Pz3rEcLY1HTjSkjcw6HKMIAcl9gUT7rB2R6
 RcwMTXjfqxqP+ZbfmKM+36JwEDPEa7iQdEUMPj+pRvbTyGwhXTNJB7MF/leB5MRQJuZ0
 Ll7Prp2ABeM7WRmNJ8B1dIsDmPKs7yR2woa3ZgXv3+VHXGCgMQ+Nd2I77+iRYjo9V1zG
 D/FSFOBeiyX9u8D9StwKO7mIJ4ukkNzWlyHN2SN78iuA0dR8XQFG2x88ZfNlLnf1Flco
 4S33shfI7emXnp43hiRSkkf48XjK5hrhxVcPgl0YpDMV4aJzoio3++/m5LX2x44jYeTJ
 wc2Q==
X-Gm-Message-State: AOJu0YzUNxhnEze6Zd3Wxyyce0laquGpK32viThXXzc/FX9yS5S7I21q
 VgKFL7aYmWTaLjH9+dwnrTR8NkluiuWDYhfEGDEPS3537jQRi/3PMJNZ/RW6J7Qpu/9dch6nO+B
 /t6vI
X-Gm-Gg: ATEYQzxnb99XcINe1DQL8XHAEMvt5uD3xwMTTZBg7LjghFARW2eK3hle4Zw51u8dx2w
 UYdGdYzQpRDMlTy8e1iG+SDaZGF7kGrSRPwFPRydDodnckYd9XjpoBqABfjfvOUKuPsAXWblXOq
 RO4xrzZ3yvgyMDzgo0xniqTCFHG6kYb6tQBsdMeBKxnexeohIQ7oFHsCPI4UnqUrNeFs8ShCDz5
 t4j+3tL3bYS5JG9AuGGd2bnET9DuVmThzyAwW11iXrb0JsOSd8v6sweSfp4G6cW2b8/J3mh580c
 sXhmoIPa3g3jLA110p0GGeMO29t1BNYxbEWBVzMPNuZs5ukmBDnNN6cnkVuPyOxoy70x72iaI+L
 TsIDtBU+8L+0Ydko1j0nEmw08yzOvCZgtIJ0+zyu+pZiVGqJqjdusvW5+mrN8RumJf4b6cbwLAI
 OPid/EuYWZ/MWpX0Bj65siIcBJBPKnc1lRDvwzgv1orL0BIC8NePcLWdD/OXB/zA==
X-Received: by 2002:a05:620a:1915:b0:8cb:4d18:bb6b with SMTP id
 af79cd13be357-8cbc8e34581mr1126186185a.73.1772330872009; 
 Sat, 28 Feb 2026 18:07:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v18 16/23] net/pcap: reduce scope of file-level variables
Date: Sat, 28 Feb 2026 18:05:49 -0800
Message-ID: <20260301020726.852401-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Move errbuf from file scope to local variables in the two functions that
use it (open_iface_live and open_single_rx_pcap). This avoids potential
issues if these functions were called concurrently, since each call now
has its own error buffer.  Move iface_idx to a static local variable
within pmd_init_internals(), the only function that uses it. The
variable remains static to preserve the MAC address uniqueness counter
across calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1b927b3c35..1a9db50990 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -46,11 +46,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -607,6 +605,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -718,6 +717,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1466,6 +1467,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

