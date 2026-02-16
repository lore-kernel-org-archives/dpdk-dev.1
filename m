Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3347EE81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AFBE40296;
	Mon, 16 Feb 2026 19:00:18 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 0DFD840289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:00:17 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48372efa020so24243575e9.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771264816;
 x=1771869616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7DtHI02sPi/EzOAqRnX/U3RhRa9soIupCw0rIqubQ0A=;
 b=kVZxzyOKj8dcG9PeYy145Z1E9lrYHoDn0iHy9W07RRXFP8z74QLRKY+OIT2DQkXAmp
 EMEnkPwu31VWsU0e1KaSHV2JMSka3RwICkDpXJXoyMi6nmkYfp90GG7oWgWP88UKUdrk
 iSLAa+Nn71jQBeOL5c5+iasVezRiHAFklEdR1nLZgqF4JV5aNwlnmzGE4sPjedpMUndL
 +/L8p5NZKlo5c1EOogZAsGmfL7QifRujx44EHQh4ru8HwNxu8lYeF/+FkpnefohEBgDj
 TpmyWUd+eI3mayDidOWPwy7l3hfWjg/NQCQzVCDP77Cy+QF3kkGYADQZE6tWYOmcjOdp
 wswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771264816; x=1771869616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DtHI02sPi/EzOAqRnX/U3RhRa9soIupCw0rIqubQ0A=;
 b=faMeW92s5+uvov0wxtaow2sonkIGljDSA3e+m3OCsbnMCHPTm4nxZr5+E7gJY/ivHY
 4FqW5zxXyONhstePcryie78oR+CeN0A7StY1CVERzKCCbFqdkIb5FVQvkvdcU85T0dE6
 S5Vgu6F3fc/Kq/zpz1ifFU5EmZ+gC2p2q89yfzI8oiaK9IpIybyiwKzbJqfBEmrch3K8
 jFrDHF44iseryqfj3LuTa4AZ+XX+Vw2AFKj8OFy7fHrsDGpzjehlI/Y5eQ0lj+Vv6YR/
 tpmAAvPaSjHdUu/yGPQ7zKZNTbo0qgQ52ItllWmqddeqHJyh0PFjNSkHA0zeJZO0VfDc
 7i9A==
X-Gm-Message-State: AOJu0Yxiux36Tlhf3e0PYwT5JknI57A5v7vFd4BVlvIUZHCteGV/9M5a
 LSrM+AeLzU9XBw3wrgEMngKbD1irNZpeXA+PaN1h/UReVjnMUdNmPG+p6PCed7HAq4dOCA6hb3K
 M7nmoG2o=
X-Gm-Gg: AZuq6aLtThGRj6bLeFS5aR7jnmNdTsZ6kNrNMkSt2pvhlU+4Wl279j6Ry7fYyshEOuj
 YqMdJNRvlgSoqXOeoigIAJvwhuH+PQiJ4dLh1IU1ye8VfN65ngRFpAo8C79V/CeHIr92Be8O4/I
 Ye36g1GGaqlOqUGLJ4Gu84B4rVOl8C5BlXJB5NfAbeXY4SZfdp0Y2HvdaR7ITN2ZfnjLw1JB4/C
 +3+thIlX2ecGK+5ERwljklq27o4WRw8Bby+v2G/42SETPvLqNJM3ZRfWiIG3tZShw+MwICPh/JS
 Sd4vfkH7lMOfdZou3Mmuf0KgH0UBUIyclVQLG8ROclYAExoqWunLt/eQyTsxyh62jGL0/rxVRkA
 Zc5OJANeh84mJGQucxMGZMmXYedl1YVjjrPQJmkfvP85WpAwZu+8lzbmAQujJCvbIddJUJtl/9J
 ntyrAEoei5y3hqC+ZO7T++ygLYmyvqZWU3mDMvhCXzf59pi7hkIoB4wVZZD02mdw==
X-Received: by 2002:a05:600c:1c07:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-48379bac86bmr174520275e9.5.1771264816383; 
 Mon, 16 Feb 2026 10:00:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a02a79sm193276775e9.3.2026.02.16.10.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:00:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC] ethdev: clarify rte_eth_tx_burst() return value and ownership
 semantics
Date: Mon, 16 Feb 2026 10:00:11 -0800
Message-ID: <20260216180011.393782-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The documentation for rte_eth_tx_burst() uses the word "sent" to
describe the return value, which is misleading. Packets returned as
consumed may not have been transmitted yet; they have been accepted
by the driver and are no longer the caller's responsibility.

This matters because the common usage pattern is:

    n = rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
    for (i = n; i < nb_pkts; i++)
        rte_pktmbuf_free(mbufs[i]);

For this to work correctly, the contract must be:
 - tx_pkts[0..n-1]: ownership transferred to the driver.
 - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.

Several drivers (and AI-assisted reviews) misinterpret the current
wording and treat packets with errors as unconsumed, returning a
short count. This causes callers to retry those packets indefinitely.
The correct behavior is that the driver must consume (and free)
erroneous packets, counting them via tx_errors.

Replace "sent" with "consumed" in the return value description,
spell out the mbuf ownership contract, clarify the error handling
expectation, and update the @return block to match.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..9e49c4a945 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6639,13 +6639,24 @@ uint16_t rte_eth_call_tx_callbacks(uint16_t port_id, uint16_t queue_id,
  * of the ring.
  *
  * The rte_eth_tx_burst() function returns the number of packets it
- * actually sent. A return value equal to *nb_pkts* means that all packets
- * have been sent, and this is likely to signify that other output packets
+ * has consumed from the *tx_pkts* array. The driver takes ownership of
+ * the mbufs for all consumed packets (tx_pkts[0] to tx_pkts[n-1]);
+ * the caller must not access them afterward. The remaining packets
+ * (tx_pkts[n] to tx_pkts[nb_pkts-1]) are not modified and remain the
+ * caller's responsibility.
+ *
+ * A return value equal to *nb_pkts* means that all packets have been
+ * consumed, and this is likely to signify that other output packets
  * could be immediately transmitted again. Applications that implement a
  * "send as many packets to transmit as possible" policy can check this
  * specific case and keep invoking the rte_eth_tx_burst() function until
  * a value less than *nb_pkts* is returned.
  *
+ * If a packet cannot be transmitted due to an error (for example, an
+ * invalid offload flag), the driver must still consume it and free the
+ * mbuf, rather than stopping at that point. Such packets should be
+ * counted in the *tx_errors* port statistic.
+ *
  * It is the responsibility of the rte_eth_tx_burst() function to
  * transparently free the memory buffers of packets previously sent.
  * This feature is driven by the *tx_free_thresh* value supplied to the
@@ -6679,9 +6690,9 @@ uint16_t rte_eth_call_tx_callbacks(uint16_t port_id, uint16_t queue_id,
  * @param nb_pkts
  *   The maximum number of packets to transmit.
  * @return
- *   The number of output packets actually stored in transmit descriptors of
- *   the transmit ring. The return value can be less than the value of the
- *   *tx_pkts* parameter when the transmit ring is full or has been filled up.
+ *   The number of packets consumed from the *tx_pkts* array.
+ *   The return value can be less than the value of the
+ *   *nb_pkts* parameter when the transmit ring is full or has been filled up.
  */
 static inline uint16_t
 rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
-- 
2.51.0

