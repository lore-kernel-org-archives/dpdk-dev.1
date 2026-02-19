Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A15E9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 00:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76650402C6;
	Thu, 19 Feb 2026 01:44:58 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id A2430402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:44:57 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-506251815a3so3316831cf.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771461897;
 x=1772066697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUlidV15Pw9kVMV87Bgz9PPCMyMvG4J08zB9Bw7Cofo=;
 b=eAnr3eOIi+LQ962twTDZ+pXO5Dh9xo2jBcYJn01k1nz8vCr7dqrYmI7eHs2JgqOA/g
 w0K5WyfaCvDUfEi3fD+FGb/NrfKwzqf0zSNpBHR1sHcKy54b3x5XJo+eRpHCrMDYj9Ig
 xs5oFWwYoVUiC3hlWGOrT7UpaMBNL3eFJiaMG10qU/atwLG4fYqQD7gIofr0nf52b6dp
 /gqxKf7ch2D6Hw4zWf85C4Rs9pIEmc/M3O4CVCzwXqGhg2A+PSkbcF/N/C6yT3pwrcpY
 1sR84SowpC+qHcQaxtMF/B3mS92zYvsfmXW16fTFOOvPSXfCGbxU6sleM3jObVkF8A3U
 INjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771461897; x=1772066697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DUlidV15Pw9kVMV87Bgz9PPCMyMvG4J08zB9Bw7Cofo=;
 b=YrwxdA8WAK2xksolUKfV3EuJn65t8Ntypjitavl8En1lx6D6BX6dzuJTr490Ue2Xua
 LYNuv8daaMjPMHCEHMk9ue8nF7Ugmjc7eZkVQDYXmzRkKOkOC3qHrnufOvTjSOdbWh91
 qPF3cFaRoQfy2C5wLffqVXNmzls0pKRguh5Vovop07n9nrXJDI9EOVPImhjUDPvJq1Pn
 xXXd5XxKmtXCeAATuYesVWOBeGyOWi8ZqdXPl2qjQGrfBGYmg2mY8hWSgBvLeDlPpAqc
 opMgb5j/ym5JkHvsvYsXyXDOQMOF95cseKVoeWG9f+5BzqyQjIz4Pwq4rqO7e86rG9Ij
 2hVw==
X-Gm-Message-State: AOJu0Yy6HkNaUfAyFxSTTWfOsFMce/BGQz+wqB3G3kyq8AKWpW/Sz2lJ
 LWL0+OMm6kgC9u5QVOzmKY5wK4ZXN1/nFzV14iirPVOMRhDiaSWNqV0U2MoiagcMOd8Ip7RCnso
 NUn95
X-Gm-Gg: AZuq6aI9msMVgPkSiQHRdXV51sozubIpQTDO9vFKZfUWS7RhTADd5yUvn/thFhOClYD
 1ReIuItNosMfFAhbhFjKZNrJKqTFuloMv1RZAhpww2j8+ucBq6FuQ/YfWjITRhSalepchRFKcSf
 qtpG/hvyQthI4PHih2YtOQXeM+M6lNZdkB0rzh39gs6m8nHdcUpMHTHgLL+R1cSBxagqh1Iefhd
 RxuAZUjgJ+pc7HJw3XV7q2pIIDy8YVO9zlps66N9aGhWD+kB81vmE82eLJPP6bUvtWgBo8H8E3C
 pp2DWEiFDw3uJeedc4UJe3YN1+qoCLFT1ySoBB7Z5Ng9m+vatyaY8Qm+mdtjeSH+LfeZKWp3gyW
 U5jfRRhihA1tqtXoUvr1B4zIub/Jkqbz3/nQaMkFDEtOzwT5Q7HD86Z7+qbWWTG7dtVpnyNYDEV
 pBiNUwcLuP75PZaTGOaJGwb5UDA1w3neys3V9XBtcGmQGInduxihNxLBgk/F88HA==
X-Received: by 2002:ac8:7c4f:0:b0:506:8659:5479 with SMTP id
 d75a77b69052e-506f0712a4emr18180071cf.55.1771461896604; 
 Wed, 18 Feb 2026 16:44:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cd8baa2sm217978446d6.31.2026.02.18.16.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 16:44:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Date: Wed, 18 Feb 2026 16:44:49 -0800
Message-ID: <20260219004449.114564-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216180011.393782-1-stephen@networkplumber.org>
References: <20260216180011.393782-1-stephen@networkplumber.org>
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
erroneous packets, counting them via oerrors.

Replace "sent" with "consumed" in the return value description,
spell out the mbuf ownership contract, clarify the error handling
expectation, and update the @return block to match.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
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

