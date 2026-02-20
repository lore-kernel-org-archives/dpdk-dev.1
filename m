Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A6C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8EA240B9A;
	Fri, 20 Feb 2026 06:49:01 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id E933C40615
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:55 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-505a1789a27so10315401cf.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566535;
 x=1772171335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tUh7EVqxUwyMw6nzZ2oR6xULFpxnq7V9zXAgaDpX7g=;
 b=VFaHqcqd68DMM7y5HxwPLe16aB40aChnGvGD8FsxPFqza3yNi1oHVJx8zQNKZvLOAK
 SSfsbNbjBnX8YJRDUiWUao+drBLjeqP3pDxHkBogV/VK/7caaHtBCDL+XvwLmbLde0jW
 7COdmtAoiImXJXeuIKkNwPxE/FbQVOuhqGAwPP81GGgvJ1Qx03Ubhc8ntF85wkeebHLz
 aQCHs99hKAwIJSvfYVX0/RlXw6Kb4DV2oriW40HRTXn2ODVjEGeE6eGsnXWGX/lqzd8e
 u+6XoHyq8v4qZ1TjjU68wzk+D7LrrB3+Des/GxV7qBzxu7Zb5WBzFe6X+wzU5tRDf1Us
 VVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566535; x=1772171335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0tUh7EVqxUwyMw6nzZ2oR6xULFpxnq7V9zXAgaDpX7g=;
 b=SSJWjGaIfDKEbelq24deUNdy90FazLYsjFI8awlHe7EMDPmzh4bXGbqErlHhFaJ5xT
 k3O0HAd27kyZ8Oio2yIhR5sgm7aLF++4ORwchp+3EDLUSv0s1NQ5kX6ovidvRgHDE08n
 Bpsl00f5IzR+vJJCpoe1P5FaoWkZ35eL4NA7qke/xzbegLXBH+KvsEfJ2rYzeGeus3ew
 NlA++n9utTZGsZuoFfq5d37Q6WtJAAH1m2eQ7uMfiVCgp/UrVsrjLryb0jM0+itkFFT6
 Vn/yf2dkF2JIHnqu7V12bBy4j435RKwGqIPCxzLoQ0cwKo3BmXail+m+uNxGk26Nz8aP
 cHzw==
X-Gm-Message-State: AOJu0Yzx08GIztwrmCqOD0BUR1Rwfxcwaf5LEkKjQ48Zb0Mn8usOXVRJ
 7vy4J+QL1pQ56LCGA3lwNEbu4ZZohULy1rc7hPJwLkgdMGxHy/g6LeULsi4u/XO943TP4cr2wUl
 nJUQP
X-Gm-Gg: AZuq6aIeUH4S+0WDVrjwJHSVu86+oB6aU/zMGOKz1BIXFXoIiA+tPSFszc0lQGtLc4/
 Zg+yKzuhqaNTwNHyNDTe8WXvmItAi1Hzvz4kefvRwQxWYzTWHc5SQM+EkmPRbAAIPPr+0KVkFLW
 +/1c2Ak7XNdMx9snTr21K7yYlCvTHrLUGoxr83kkwYDyX54aDJ3S5Rg4om8WHpXK6BueKEovdIf
 kTR+3OCMP+zNhjFwu1OyeTSw93UdTRmuG7HWUGgrk+UrCimpaNmv4fpQQ2TjcfkSoLxrPAXJ/NZ
 6TYbj9Y81RibW7ckhJ6A/M/PnqFaFeHu2ZYH6nbeyq+zEaBwbAjyIuv6C3Tv90GQmsdmDmIWp4a
 0XNExfuJR47IWA0d8wKJp7+SO0OmKTK8hFGf+z5d/rSqr9hkMBavO9mp6QQFdhOoZLxgcyZfheh
 koXozxFKKF5wERnXhcjqKnyZjaJ8qiwnOIQVk/sTl95FozEviaghoy9CfQYqlHyg==
X-Received: by 2002:ac8:5d44:0:b0:4ec:f26f:5aea with SMTP id
 d75a77b69052e-506e923be9fmr106811321cf.68.1771566535201; 
 Thu, 19 Feb 2026 21:48:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v17 16/23] net/pcap: reduce scope of file-level variables
Date: Thu, 19 Feb 2026 21:45:51 -0800
Message-ID: <20260220054834.1632201-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index 6fb21c96bb..508163c4c4 100644
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
@@ -629,6 +627,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -740,6 +739,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1543,6 +1544,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

