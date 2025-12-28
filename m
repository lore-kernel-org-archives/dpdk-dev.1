Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C409EE784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F2604060A;
	Sun, 28 Dec 2025 19:45:46 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 0632540267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:41 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so6720734f8f.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947541;
 x=1767552341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=25eQEAm/266bxTfc67SFaS/ApWJDmp7Q79x+H5Pja13irGY2FSpGAYSXtYGLHZq7rn
 Cp2BNwSmZ1O5PPIqQ72oA/jUhW1XgatBkZHCmSZ/ViUrK/44ngG/iRQd1PGBPPzVWY4V
 M/J3z/9REL6LskDB4IThGOvLjePPL/8yRmmH5i0PgxlP9RZuffrWZsAgtQ1pBZkLCMyZ
 6gHPMpsC1TWkSREts/Zf1rqP/9NyvczvYPFNTSBhHxH72VtdWBZocddYOLYWomJkk3Pl
 hIccvM679p0JbSYJDlBspUBywoS6j0yGVEzd0XVuXDhrjvWtp978RFaT4c3CZs6jB+cZ
 4yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947541; x=1767552341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=QTAcbPQgxwj7NKUtJ+LH/uBRVtTGQMstIDmGGNw74ONKo+53R3Z3Tg2nTZ47llmfFL
 k3Ivf2yllZknqM/hBnJWEzPiU6jvdXZw+esazPDgb/siY6WC4CWM6MIp6uS+udizzmka
 h8MReRUjbIJirnX2aawy62JHDN/drFj14J+D7rHpbrhqf/I86+SBLMZtarlITmibjjYS
 dAWgcHWMqOhg7Iv+GteGOQ36W9frBA+tX1l/DJ6Xh3VHOjZAdEumD16dC1aw4P7GT0kZ
 Gk9fMNM23+VG2cS37iT2d7hTuO4V5a/lADUS/XzOQYbSbJg7BK3eXA8vR+SpsGuXDrpy
 jAKQ==
X-Gm-Message-State: AOJu0YyGvwHd4ZKGSAAb2pptz+bq7G/Ddp623fjei6yn16KT0lEU9glE
 EyIh1V2hq4jpmlpaGqpaiLJYpXBg3e0I0tOmAQLNIpmmcFTKsGivf9y0BIFwa1IOffcSPb5TUmX
 5Fzd+qrI=
X-Gm-Gg: AY/fxX5zLyl7VFWjO5vqbJ+3o8vf47Lei5ftooivLjKe+JXfJQu4pAYTWNbhiCRzwkL
 sFUb7gzCZCsfWdO51Dfq5gMXd4jdEyTczwJDwLVv8gyDHij553DTFI4mTazhRTFK7nIUw2cPbPo
 F8+/XGjedC79JdCj/nUUjdnhm+NFwUj6OOgk5lBc0WPWbrsxAd3uDTwNtWP8h1Spd8R8qJ8cU2c
 XD/Af6Uj8YU133fPmvK6+Fkrh537wmyyo6FAZLGtzhBu6POb64eQI7NHHL3D95wHwyqIY5nAXBM
 U0kONH/EnXvYCDNGqglsy+QGmuw9MNt6exGBbQXXhzi5/gaszeblJRG0KFs/V3Ii9AuCeUyAKln
 M/5d9GlCQQBPg0ZPDGuIFEiaVDmHlmEHqEnNhbbzF3EGG37miD5DM0fQLra2CKTtR1suJooLmaj
 EIdfb5IKwFvr/Ihntpej56i/2R0WsgGr/2nQAv/K3wwDlCjIeGHA==
X-Google-Smtp-Source: AGHT+IHcbXEgnP08x3Gf7Z+liHr2KPz28YCa+rsJkum2M+pR70bNWJdqzF/GTU3iru+JxYEM8tHprw==
X-Received: by 2002:adf:f144:0:b0:431:855:c791 with SMTP id
 ffacd0b85a97d-4324e4c1501mr26577650f8f.3.1766947541426; 
 Sun, 28 Dec 2025 10:45:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 2/7] pcapng: add additional mbuf if space required on copy
Date: Sun, 28 Dec 2025 10:40:15 -0800
Message-ID: <20251228184300.541639-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
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
maybe needed at the end of the mbuf. To handle this case generate
a segmented mbuf with additional space for the options.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 3067033e89..7c3c400c71 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -540,11 +540,24 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
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

