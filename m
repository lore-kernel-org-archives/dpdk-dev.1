Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39486E92FF7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2126E40612;
	Tue, 30 Dec 2025 00:02:33 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id E7E33402DC
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:31 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso1744184866b.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049351;
 x=1767654151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=oEzQb9LjA2r5EkB2TJ/QVbu4hCr8mCGEdO2FW9f2TeWio57ztiwpCDnYQ9DB39EfsX
 GBnQxqb46j+dsm0VWxV1I+Bi8bGA0wACqiSP5KdsHudoJE5k1De1RwP4ko77luaa6vg8
 SeL6tTjcRMATjg0/CFsjOrxh8sZmEMhR2qdPMzfAAL/axPOmDTmSdOHicybOBPYQ/WGv
 t0KNUC+94PqVoq6MsJD/S8S/m130gFd0QyxuzoiVS60b6KS5MZPy/GqvA9bG6np4f04W
 oR8rsMO4Ppuf1+W1EpiGZnbed/fT5QL8q9lZtw55GRuuBVUlgUz+ku96dugtdjFl7XVE
 cCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049351; x=1767654151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAyYELlFSK8dL0E3zXNxrT5yRbE64um/Hu8y+IsOK40=;
 b=sV6h4R4Jpu/umi2MJlnXjLblUVc7O+1YzmeAwyCkZdy7v1SSeBhZ4+YOIy7U41NeoL
 WvGu/5yts3i6BBh+iKo/Rrn5VE+tru0Va9Op3k11WEMYfAubTt4zFgVXnwjqf7cTzWSh
 8pbeC3P4IlyWJIPVH3Vpc2ro759LE9IXMfwqGuUB13TVvoG9FfbBWVH5Fzb/u6ZTnPNi
 /iYd2wW9LraoPQnAl6QpLv/Yxd4T0W07prPojJ/f0bTo5PtLuuL71T63BDPxNlBtsdVD
 MFgUMxKxHtdh0PxvhFJvnhIHdqP+h2CbkK5q6is59Ym1sbwPgZ6zCcFNQ0N7f3Wzf0IB
 qETw==
X-Gm-Message-State: AOJu0YwoVcZYDvbtQZ1O/adfEf9JmgU8+5rLHRrHmIDMdVrdpTiF/a4Z
 cSoXE5zrDa3CbGU2LXoAaPv/zNguL5k/jmOMqan2UgfpGDYthMDBQ6tzfoH3GObPaQMswB6lzvY
 42hrPjIQ=
X-Gm-Gg: AY/fxX6G4mdZn8WAacdDnsSzueXK3rNCCy3rfh2+tfOeaZykiQ0mk1A/xqjGtFb6shr
 1G8Y5JBVhvBY17R6ALnp5vXyOE0qgUN/a0Z81Q1xCDc7kATeKKWWChtKWDao/TxtIqsa1eVyGNg
 En0N8vMUBMxZZEI2QWIVBJaZ8Y8QgRG/xrBTvHOyFkZrGqUgBUGj7ShrpIePRzk3/kLlxqChp+4
 jjEvPupu2IiyrsDcdpfByEgx18/lySMMqK/W8SFe+pMMs+w1aSzttY5MbaFJQ3/fabaOuWbJtX3
 UMFQueRWqMYBc66vUX7g86ZyvoNx4tZzAFeRPOkUKmyrNb3j5LCpgD4oDJnO/QtQqdeGkiWyOxR
 td0hCYEszWrUCA2Jlka/GkMzBSjmjxTiMlWyirONQ7ffJDuMkfjh2YSKmCbxqkN0FqPA0bZaNU6
 rMsl+wlYC20Ad8jOqgq1J3ZPC4MoBw3zsJN4Z/B1RrcSroxhpw7A==
X-Google-Smtp-Source: AGHT+IFQqTmfxkb+FqadRbhVYjps8/YPZ4x+7d3B2uipQpXJuqdr5svNVPe+AYGyvAXhKpZFRjXO8Q==
X-Received: by 2002:a17:907:3fa5:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b803718390fmr3768066366b.51.1767049351340; 
 Mon, 29 Dec 2025 15:02:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 2/6] pcapng: add additional mbuf if space required on copy
Date: Mon, 29 Dec 2025 15:01:05 -0800
Message-ID: <20251229230223.151874-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229230223.151874-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20251229230223.151874-1-stephen@networkplumber.org>
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

