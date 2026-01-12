Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C9D25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68AC940A79;
	Mon, 12 Jan 2026 05:54:13 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 8DA9D40A6D
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:11 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b86f69bbe60so141439466b.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193651;
 x=1768798451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f77kBtOcgEdz63P8J3PmPI2HMrzeVND+zX545RrB3qI=;
 b=HEmhxBp10DthHnDohnk492EueI7t2Vt+sgfEHr+hw5d2wzSXkf+2NLbZnKPFIR21FH
 RjBHg1uYno9lg6tLA+vzu0p1sUN35WYP9Jc5stviTag0+rpzdRGuH645vRpCogVezZZ0
 VhbSIOD9kaXftWtpxmG3Pl9S72gWSPbh3DSDl17rW/cDsbTfddwvnNHmNrr2Ghb8rMZG
 w9X4Aw/Bm3uQiP52Iy0vggTOQ5AGBV4lxBr1fOJIUnEm5kBJMxa7CowEWHEVhVAEyJrj
 nHsi7qNTzE6K1h1sOVd9vtKPYZHGKg/7wahBiOcXYdsvg69ypsdXjkjrHIytgp+gn9hS
 CZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193651; x=1768798451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f77kBtOcgEdz63P8J3PmPI2HMrzeVND+zX545RrB3qI=;
 b=pzg9R9lrBJhHdBm5L5W6WPRYZqVdWeLkiu/AIWGzqTUWJ/qV/4icJfEJJACtxzo2g9
 KBM2k2ibDLnfLDrba3YKAoE3sTaiiqYmLhJ08QFa7TR5P36sGl4A6V1rjB2u37Tqmcuv
 pFEN6ONbA7Xo+2yBtAkNRYnJhVaXuaMfroH1FeN9N1tbgzbOo3fJ3FWBj/8Sb/1hVQcC
 iTLBjviC8Ti6TJEU/ZnDfTNQ6ivzx0/Jntb8hAsdM/tIrENrQBVPv12lMUqaGbveDhJP
 4q+Meu3Wgxvg+JDX1zRArmiP0/DFOLpzBvmxhW4yJe5keqYFEmE0h5RlDoPPvoXHA6xS
 Taiw==
X-Gm-Message-State: AOJu0Yz6KlvqySPpHaxmlbMybPnvvaHZITKiGLHRLD/s9mAwSl/rZwDX
 9B93KFYuNuDAPnG9voJ7dYx/HztqXeTueQFNvyx3mdQJ/pFMVlRpMOaA9AZadTI2rLwSTdvGgeK
 RMeYZ
X-Gm-Gg: AY/fxX4HegSqhihndNpq4DK4vJ2ns4Go2VLup/w8wPEXKOSThuH5Um34HFnVZdrjdCg
 MrbWfjaHvD1w0vPjmbLdak6oKZiNfC4QFiqCg3h09q27fYG6fpEyHRBlbTXtglPAbn+/YcJHCTn
 aWnaMYXGF6ofW/E6YSWSVGIahdS+RUWAAUoD3n8McuT7nFS0+O5fvbpwis97x/e8O4qzv83i0VZ
 yDj7xTWywBneY8UpT8laRrmfGHAWXQ3i4ORMwZpQQiCqHiLBZWqPnuZv+2e8wCzUOMeoDgWIzOd
 Srq7vQjyIfPuuSWFSLfMGyV14hC7LTpy74uy6SOMxV9g7d2M36NcOPLpcInUEV1FrOrVrkcPILI
 hV+XAwP9avDpWH3zK0T2TUD/Z//veLnxYnH+5f1mEkQef9qS5CYZQP/dslcZ2RqM7hNeVtoXTnw
 sbLcZ58QOwCg7F66Y3fk5vHTWLppINCYqHtYeJQlnGLzXhFvlX3g==
X-Google-Smtp-Source: AGHT+IEzQIKr2xn+xiNbldBmzarQL2sQIrer1GYXGlJrMxaffMaMSwFSTDkN0sCk3A4jDqbOjLcKsQ==
X-Received: by 2002:a17:907:da4:b0:b87:b87:cdb7 with SMTP id
 a640c23a62f3a-b870b8800c2mr328192066b.64.1768193650880; 
 Sun, 11 Jan 2026 20:54:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Subject: [PATCH v3 3/7] pcapng: add additional mbuf if space required on copy
Date: Sun, 11 Jan 2026 20:50:16 -0800
Message-ID: <20260112045359.142999-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
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

If comment is passed to rte_pcapng_copy(), additional space
may be needed at the end of the mbuf. To handle this case generate
a segmented mbuf with additional space for the options.

Fixes: c1abd1e93dbd ("pcapng: support comment in enhanced packet block")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index c2635d8b03..f53e6dfecd 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -568,11 +568,24 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (comment)
 		optlen += pcapng_optlen(strlen(comment));
 
-	/* reserve trailing options and block length */
+	/*
+	 * Try to put options at the end of this mbuf.
+	 * If not use an mbuf chain.
+	 */
 	opt = (struct pcapng_option *)
 		rte_pktmbuf_append(mc, optlen + sizeof(uint32_t));
-	if (unlikely(opt == NULL))
-		goto fail;
+	if (unlikely(opt == NULL)) {
+		struct rte_mbuf *ml = rte_pktmbuf_alloc(mp);
+
+		if (unlikely(ml == NULL))
+			goto fail;
+
+		opt = (struct pcapng_option *)rte_pktmbuf_append(ml, optlen + sizeof(uint32_t));
+		if (unlikely(opt == NULL || rte_pktmbuf_chain(mc, ml) != 0)) {
+			rte_pktmbuf_free(ml);
+			goto fail;
+		}
+	}
 
 	switch (direction) {
 	case RTE_PCAPNG_DIRECTION_IN:
-- 
2.51.0

