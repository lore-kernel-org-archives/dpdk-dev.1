Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B030EF99CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88BE040609;
	Fri, 13 Feb 2026 20:20:48 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id D11784042F
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:46 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2416151f8f.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010446;
 x=1771615246; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52CEpZR/fnWl/ivhIj47URKjtDcK037Wi5VOgs65tSM=;
 b=nNe5kyhtdYN0U71O9rTg65H4WeRmOVHhElmHvyXyAYnErvTpt0VVU3Peqs14R8rDT3
 izuHNQqwri9/S0wExMIUeO/Ii3PNOVBncL+ZrDueLbGuQwluTRIajk24p9O+pP4wcbXW
 g5Mi5FA7tourBRqvh28kye1F55TMzS6QRG/eRPJEMD3UZvzxS1qqqYGWFKj8vMDDKEcd
 C4CkAaDZzRU8kCJjdf8AK5PQDiUMq8g24Oh7WL2w2k31lmI7FQYEAxoIR3WmXwErsznP
 TuNjc9l3tnpSmmD3pAkmXkixtLz7bT6EcC8lbxpwkAOdqRwIno+Gm2QLhI1iHT5R3vWQ
 w0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010446; x=1771615246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=52CEpZR/fnWl/ivhIj47URKjtDcK037Wi5VOgs65tSM=;
 b=PXELmYdfucjKbP29d1NcDcyYN/aMcOvfOsJhCzJ4ERz801Kny7RZ5KIVaQInFqihNA
 U7nSxXB66zdexKV2vU6k9bmN2nnDOwCpugK4ZK3T2B/xfb5qUluFmiwY8ddxdY5F/h9o
 EagmIoHXGEKH+nfOl87Gehdf2Sq1v3BLy8dYU0w+w7NGwgl5DQr4mVKPZ99Qz6tSKMs6
 9fb1pES4PZpExY94f2sNIQpQSxtHrmWwXB8C7U1/rLkJFw91PihrfWad8tz0kLyByoDv
 M2H6lZIiev6w5GohZ3DGhIAqBxaaNCpFZlgeG0g+gNosDve0rBUeVC55YJdWoz7xju/f
 lutw==
X-Gm-Message-State: AOJu0Yz3YEHKbcP6Q8jRTZ2lH3VLCRtg5GsNHDZ9gh4ECZUpw8ZYGpg2
 9WDxObSAFzR+QdT2mrjx7RMcqOzd/KECKwQZW1EyyRD6AIkOghu16TO21d1zQl2TxWafXLabn2E
 QauqX
X-Gm-Gg: AZuq6aIwvxCjtafPo9P4trGEqapJqJGtFBwoyx540bYDRTecmIst0IvnbHgGU3feQDH
 pSQ/O2gvCYzV61hZT/yw4zArGwz+ethHDuG7ktieI8BT+uoDoATUemHGfF/ggDScy4+WDCO7R4V
 96j4QJL7OWKqJ9p6iPWmJdAiILY/EY1ho/3QvsE0+TKqT10AbdDQNJnx2YCmmBs5zD4yTAZuJcR
 PrPnbPSkxxVedvVHEKy9n1UpFk3QywSvUkeVesHHPgRj898CGJYWpnO7xflog88vbxc5gZ5MOtB
 1LNjWzlS9UWqgcwO8sdCH9rGewG5FaIEnNoYQafiSgprAp84guQ+LgBtKyVLPHt6QN3XtWjsazB
 dPDPRJZCbw1OW/EOvsF4nL126ZiXaCKUDlQKvm1/tIOgT1wbG0S56dprHEB0mtumbbhHO7YsgXC
 kuknL4+icYme9wkx9s2ghWt5fF7QO0MctQYFXtymKHbqAKjuyK/EHSMsgGt0g6cA==
X-Received: by 2002:a05:6000:2dc7:b0:430:2773:84d6 with SMTP id
 ffacd0b85a97d-4379d615d25mr2350732f8f.24.1771010446294; 
 Fri, 13 Feb 2026 11:20:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 1/7] pcapng: add length checks to string arguments
Date: Fri, 13 Feb 2026 11:18:18 -0800
Message-ID: <20260213192039.221213-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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

The pcapng file format uses a 16-bit length field in the option
TLV (Type-Length-Value) encoding, limiting strings to UINT16_MAX
bytes.

Add validation for string arguments to prevent silent truncation
or buffer issues when callers pass excessively long strings.

Also update the Doxygen comments for rte_pcapng_add_interface()
and rte_pcapng_write_stats() to document return values.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  9 +++++++
 lib/pcapng/rte_pcapng.c                | 37 +++++++++++++++++++++++---
 lib/pcapng/rte_pcapng.h                | 11 ++++++--
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index afdf1af06c..7a99420453 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -140,6 +140,15 @@ API Changes
   * cfgfile: name must be less than CFG_NAME_LEN
     and value must be less than CFG_VALUE_LEN.
 
+* **Updated the pcapng library.**
+
+  API functions now do more validation.
+
+  * The length of comment strings is now validated.
+    Maximum allowable length is 2^16-1 because of pcapng file format.
+  * Passing an invalid port id returns uses ENODEV rather than EINVAL
+    for consistency with ethdev API's.
+
 
 ABI Changes
 -----------
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2cc9e2040d..4ccf833777 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -34,6 +34,9 @@
 /* conversion from DPDK speed to PCAPNG */
 #define PCAPNG_MBPS_SPEED 1000000ull
 
+/* upper bound for strings in pcapng option data */
+#define PCAPNG_STR_MAX	UINT16_MAX
+
 /* upper bound for section, stats and interface blocks (in uint32_t) */
 #define PCAPNG_BLKSIZ	(2048 / sizeof(uint32_t))
 
@@ -218,9 +221,11 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
+	int ret;
 
-	if (rte_eth_dev_info_get(port, &dev_info) < 0)
-		return -1;
+	ret = rte_eth_dev_info_get(port, &dev_info);
+	if (ret < 0)
+		return ret;
 
 	/* make something like an interface name */
 	if (ifname == NULL) {
@@ -230,8 +235,14 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			snprintf(ifname_buf, IF_NAMESIZE, "dpdk:%u", port);
 			ifname = ifname_buf;
 		}
+	} else if (strlen(ifname) > PCAPNG_STR_MAX) {
+		return -EINVAL;
 	}
 
+	if ((ifdescr && strlen(ifdescr) > PCAPNG_STR_MAX) ||
+	    (filter && strlen(filter) > PCAPNG_STR_MAX))
+		return -EINVAL;
+
 	/* make a useful device hardware string */
 	dev = dev_info.device;
 	if (dev)
@@ -269,7 +280,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += sizeof(uint32_t);
 
 	if (len > sizeof(buf))
-		return -1;
+		return -EINVAL;
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -334,7 +345,10 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint32_t optlen, len;
 	uint32_t buf[PCAPNG_BLKSIZ];
 
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return -EINVAL;
 
 	optlen = 0;
 
@@ -487,7 +501,14 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	bool rss_hash;
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
+	/*
+	 * Since this function is used in the fast path for packet capture
+	 * skip argument validation checks unless debug is enabled.
+	 */
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
+
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return NULL;
 #endif
 	orig_len = rte_pktmbuf_pkt_len(md);
 
@@ -692,6 +713,14 @@ rte_pcapng_fdopen(int fd,
 	struct timespec ts;
 	uint64_t cycles;
 
+	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
+	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
+	    (appname && strlen(appname) > PCAPNG_STR_MAX) ||
+	    (comment && strlen(comment) > PCAPNG_STR_MAX)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	self = malloc(sizeof(*self));
 	if (!self) {
 		rte_errno = ENOMEM;
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index de1bf953e9..2dd438842d 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -89,6 +89,10 @@ rte_pcapng_close(rte_pcapng_t *self);
  * Interfaces must be added to the output file after opening
  * and before any packet record. All ports used in packet capture
  * must be added.
+ *
+ * @return
+ *   - returns number of bytes written on success,
+ *     or negative errno on failure.
  */
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
@@ -128,7 +132,7 @@ enum rte_pcapng_direction {
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
- *   - NULL if allocation fails.
+ *   - NULL on error such as invalid port or out of memory.
  */
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
@@ -192,7 +196,10 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  * @param comment
  *  Optional comment to add to statistics.
  * @return
- *  number of bytes written to file, -1 on failure to write file
+ *  On success number of bytes written to file,
+ *   -1 on failure to write file (and errno is set)
+ *   - (-ENODEV) if *port_id* is invalid.
+ *   - (-EINVAL) if bad parameter
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

