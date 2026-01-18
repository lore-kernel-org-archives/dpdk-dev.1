Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691B8C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02949427D5;
	Sun, 18 Jan 2026 20:14:19 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 42B76427C1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:17 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8708930695so565269366b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763657;
 x=1769368457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2o/QgmBE1Ax5E8Ubi93comn/3IKkkli8qNkhas9mkw=;
 b=nKwBr1LYUm7NlJUF2kCDNFUBV2nq7ezWJfKXpWvSIPdVvodbi0/382Ipdf+dEjMbqq
 glZj9ScNPzC+htuFPSKQoeQkLs4V05BvI2r0FfBDDvVKgskOZGSi+YhaRKoYcvihxtlF
 4QskJaFt0zyuWWBFbltkJAmmH1XZsSrDy6vmH3Y6XM0q7c3uQMa6B8IoyMpwByylOi7/
 0bTxKB6EsQ0jV1o7FMLCC3M/AsZO+hg/v03vvqbHrscR+9gD7R8WY2moJoU62zeeXvBZ
 t41SIkESyyuSjZRJxOvP4x4u0gMXEPhUmBNVdDj/RA4M/EWz1F4TROLuZCSoT5gxrgaR
 bSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763657; x=1769368457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b2o/QgmBE1Ax5E8Ubi93comn/3IKkkli8qNkhas9mkw=;
 b=lmYxhP8UNRX9bLRfOiwEu+HQpzJ7neP886cG5kNBLP+AV7168uB5BAooNKo9iCZY34
 Xa+gtQr4vLrnSchbECZwC8AfBmcKrWgT5enj+nJGiFAtjemnJb+kQKQKIIU+MsDvEvEi
 fZViBwDHSFXOzcw3Nk2KPUNnyZDYQKzN0n+uROYNmOT3t9V4sACCoSf3OlmEvQmOsEX5
 bSYSc3PUn4nbUIfY0Ambpcs+qu3RyFhO398soLUuGlGR+C07ZDKioDscnv67gINvuv+N
 Yxcs7FWT1eqhnyuzSNsOV5JWi0g9IpwVsBJ2CTQ21YaVJl9rCkV9IlY8CISKR+pSbUhc
 U83w==
X-Gm-Message-State: AOJu0YxY3G5O12jmxE3bVixHf3tuvprR/zaLWnSQ6pUzn2XXNglk2+X4
 vhM5bRWInOEfgrZETK5eM2C7TGTOD5P+XlaGRxwa4Nx9cWngN7JdpOnJQyqK3DkZxUvV7W/HPo7
 1hCQi
X-Gm-Gg: AY/fxX6oP09jJVqI37YQuYyHnSh0D9gRIve3TyLPkd+BHJeTswsUb85KrcLDhAoTnoZ
 HpFLJQONR0SKw4wZ6OmXvgdUQgNSb+nF0lGlMBOcFe7eCjl+Ij22HCuRy/OkXAZJ4tkh1P0p7IC
 sjpSgpOtsIPA/x7JEkicKPHLXMtyyY8z0qNjZLk9kGPPVFFmF0g2eADnmYrnae+kyO0m187vYRw
 JM4+DYzcRaSh/rB550a9I/xqQ/fwGX5mc1YoaUjQI852BqQw4Y8ZH3MYh2y+c4lHkVxUXCz/iFR
 6LCmm+RAB7ZGneUJu8i+oi99bCVc4FXOyB3CqPWQE5cycMS0HtTnb4rXuNC6Bya+0pPEoVKNRGT
 FsXfj9SvDTrlH5iHv8/CHwgvFFS2HE6klzroX9jM+1xUVMJmvQC5lTWLuHdVHGD2GR5MzaWdTUc
 NXzBG4BWgdRcLS/Evs+vlgUMv4RB0M068nQLvds1tBwhuJe5qhMw==
X-Received: by 2002:a17:907:9711:b0:b87:672c:410e with SMTP id
 a640c23a62f3a-b8796af0cf0mr702974766b.42.1768763656820; 
 Sun, 18 Jan 2026 11:14:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 31/54] doc: correct grammar in mbuf library guide
Date: Sun, 18 Jan 2026 11:10:34 -0800
Message-ID: <20260118191323.241013-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar and style issues in the mbuf library
documentation:

- make Mbuf capitalization consistent with title
- fix garbled sentence about embedding metadata in buffers
- correct awkward phrasing for newly-allocated mbuf description
- use correct article "an mbuf" before vowel sound
- fix redundant "prepend data before data" phrasing
- add missing punctuation and normalize list formatting
- correct idiom "allows to offload" to "allows offloading"
- fix subject-verb agreement for "information finds"
- fix plural "applications" in use cases section

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/mbuf_lib.rst | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 382bfbdca4..ee88b13766 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -4,7 +4,7 @@
 Packet (Mbuf) Library
 =====================
 
-The Packet (MBuf) library provides the ability to allocate and free buffers (mbufs)
+The Packet (Mbuf) library provides the ability to allocate and free buffers (mbufs)
 that may be used by the DPDK application to store message buffers.
 The message buffers are stored in a mempool, using the :doc:`mempool_lib`.
 
@@ -19,7 +19,7 @@ Design of Packet Buffers
 
 For the storage of the packet data (including protocol headers), two approaches were considered:
 
-#.  Embed metadata within a single memory buffer the structure followed by a fixed size area for the packet data.
+#.  Embed metadata within a single memory buffer, with the structure followed by a fixed-size area for the packet data.
 
 #.  Use separate memory buffers for the metadata structure and for the packet data.
 
@@ -79,10 +79,10 @@ Allocating and Freeing mbufs
 ----------------------------
 
 Allocating a new mbuf requires the user to specify the mempool from which the mbuf should be taken.
-For any newly-allocated mbuf, it contains one segment, with a length of 0.
+Any newly-allocated mbuf contains one segment, with a length of 0.
 The offset to data is initialized to have some bytes of headroom in the buffer (RTE_PKTMBUF_HEADROOM).
 
-Freeing a mbuf means returning it into its original mempool.
+Freeing an mbuf means returning it into its original mempool.
 The content of an mbuf is not modified when it is stored in a pool (as a free mbuf).
 Fields initialized by the constructor do not need to be re-initialized at mbuf allocation.
 
@@ -93,17 +93,19 @@ Manipulating mbufs
 
 This library provides some functions for manipulating the data in a packet mbuf. For instance:
 
-    *  Get data length
+    *   Get data length
 
-    *  Get a pointer to the start of data
+    *   Get a pointer to the start of data
 
-    *  Prepend data before data
+    *   Prepend data before the payload
 
-    *   Append data after data
+    *   Append data after the payload
 
     *   Remove data at the beginning of the buffer (rte_pktmbuf_adj())
 
-    *   Remove data at the end of the buffer (rte_pktmbuf_trim()) Refer to the *DPDK API Reference* for details.
+    *   Remove data at the end of the buffer (rte_pktmbuf_trim())
+
+Refer to the *DPDK API Reference* for details.
 
 .. _mbuf_meta:
 
@@ -123,7 +125,7 @@ timestamp mechanism, the VLAN tagging and the IP checksum computation.
 
 On TX side, it is also possible for an application to delegate some
 processing to the hardware if it supports it. For instance, the
-RTE_MBUF_F_TX_IP_CKSUM flag allows to offload the computation of the IPv4
+RTE_MBUF_F_TX_IP_CKSUM flag allows offloading the computation of the IPv4
 checksum.
 
 The following examples explain how to configure different TX offloads on
@@ -212,7 +214,7 @@ Dynamic fields and flags
 
 The size of the mbuf is constrained and limited;
 while the amount of metadata to save for each packet is quite unlimited.
-The most basic networking information already find their place
+The most basic networking information already finds its place
 in the existing mbuf fields and flags.
 
 If new features need to be added, the new fields and flags should fit
@@ -286,4 +288,4 @@ by the script ``dpdk-mbuf-history-parser.py``.
 Use Cases
 ---------
 
-All networking application should use mbufs to transport network packets.
+All networking applications should use mbufs to transport network packets.
-- 
2.51.0

