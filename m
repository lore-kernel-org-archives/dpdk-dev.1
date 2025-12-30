Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A235EE4997
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:58:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F17840616;
	Tue, 30 Dec 2025 19:58:48 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id E850140612
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:46 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1556407866b.1
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121126;
 x=1767725926; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=usymQVYZbTE4TdyJ3Sz1eVi08SsL5R+rxmi5jK0IO8mzYz0aVczmoF/9m7dZzse5st
 VEVhdpZvEOkWHzOGL5D8WgTRBWmiTB704adiFRRxbDHoO2gg0xRje36daKK9xy54zNS/
 25PQwajXHNHl8F5uNgiQwvo3XbrO5VtpeqhXIgB/bFojlue2eApHuY1KH74RkfzgBo7e
 hT0/y9chHT9pE4BfMA4IbulgflHpeqMimCT3GRni1foXhwBH5B870XcHgGhNyS31heUN
 INTNf7RyaiTcqghOlI5YhIEsxekpxUsQNJoZPzEkmNA3raDlFtHhCTIYBZDKPr1N7gML
 TRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121126; x=1767725926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=Hq0/parbjUvOUhbZLDi7YmxsEyq6rBsgi0ngM1ITGvGVpBcmDJwis6/XxCB3X9Lska
 Gs1/BH4R0MB+S7Uo0x8jeoPNUlg+wbTtsUAtw0p83Kh2bYF/7OQ1XPD/DcF3PVoCCgRH
 HJD4wlC/cYW0iX5XZetco/JQ6wvrJGt5ZBtoDeQjDyTlB3UeQXyiGKEi53lBuHiAFGA0
 pLn2rSFK0AtTCShTR4KJNs0Q71U+aSD6mBg2P5evMUwpucVc1a0WKzDGAUwkJUtj3FPs
 syalqOJVv5b1JwvdJkCkQLXvYDHqcZZr6bxEapsMnjrTxIyD59XhB3WkOOnQYYRm87A/
 XPXg==
X-Gm-Message-State: AOJu0Yxkj99wvRSJIb1dKNOwbBQ+dqaeIVcDZejnlQrUcfR/0rL5U6Dm
 nJuE6T+71XbVjcSFsKshS71XZGV3S+d7VYEtL2ac0YDXtbunEsrYZCqxjLIwhEYEoe1TcBDDY17
 KvRRYp4I=
X-Gm-Gg: AY/fxX5nmk/gvjBm7oHRgVZ+UQwI9r8BfTMk1FNYJd9lMsY86VM9aRuPRVHYbuDGXC1
 1l7tt3O7HgZ089dz6eAv42/MsaeufNaSjdhF6jjiStc2ePvCpElwdeBI4SBTrlp547ehr6J6VXd
 rmgDDONSxTqYxMDolX6znYXXtmsPOxchcBEgPHWEKxd1otomDJsDZ0DopNdMC630qxyAm9GKjUW
 XlMqP0xjIITkCQhs/ulMC6JH4fXwbn2W9rhH5lUsuIiBCZ1RuNWm0wXNR/M09klWmlOyw6IAObj
 5mbE6aO6SlHPkHEWA0EavDIFiODf1edcITP+HsYc88vwAbvVRZpIYvSkZUfjDa1SdYVnud1czyi
 74qUeKPNMZxJqy6DDAn2keRqhMNEjA8GPlAnsZxPgqS6btp4oB/Fp81vd8wGRvbD2qe28gXFxhu
 vGUOVE34egIyQnQZZDdqNb6s7RutTa5LWkvuHE/lsBJVwtk69lLw==
X-Google-Smtp-Source: AGHT+IEQMnIvUVOS/l3yLZq3glE7h+yyu9vOMj/fyyHfWeRS3zjqHQrlTNVoGfYv6d1VPgdc/IT4HA==
X-Received: by 2002:a17:906:209a:b0:b80:5aef:c30f with SMTP id
 a640c23a62f3a-b805aefc453mr2208358366b.44.1767121126070; 
 Tue, 30 Dec 2025 10:58:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 2/7] pcapng: add additional mbuf if space required on copy
Date: Tue, 30 Dec 2025 10:55:10 -0800
Message-ID: <20251230185837.301163-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
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

