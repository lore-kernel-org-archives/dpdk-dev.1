Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C49C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3936B4279D;
	Thu, 13 Mar 2025 18:23:21 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id CFDCD4114B
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:23:18 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so2305680a91.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741886598;
 x=1742491398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4OSwA9XGkFmsAZgEIk6Td8a0fj54neOdhe7x+NTIe4=;
 b=giiz7mCJ1xOGQqbpbUa4RytiT0GhzaJh++/UnJRQmzeFSKMcMOF9lK+czKcpf+CE8L
 /z89viOon9qotEiYWUWGQUcz/S01MVvut5ru9K7ycP7Wv5ekxQsOvvSmHT3cRG6ZBtn9
 ebi4Y1WIhWnqCXkdqDtn/tm9v/c61H01qCjte8rsKz13qnIT1mVZE75o7xEIoksFZccO
 4DGZdhnGVPjGtk0h13VYd6W5t1I9V1HTmrX4mGZmuBs4sOUyEPdxUTkkjDtrxDvvDhhH
 lQr2sdGXVU+yyjsj8NbdwuTaejiu+/mmhUbiOkUsBLbrKzvk3wVxW8QheAX5CAsn8urv
 4+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886598; x=1742491398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4OSwA9XGkFmsAZgEIk6Td8a0fj54neOdhe7x+NTIe4=;
 b=g/bjFDGPyYiU0LHGQF3V9sNQC8+fMuuuUPwnPiX5DjeVs92vaz5GxSY1CogJCyMIUk
 O+5Xrb1fC7PuUHR/fSpr7VepH23CT3GmvsosOm7BavFYPNgNKL+Tit+CPKfzemYylWgf
 qR0jrF7z9M9k0QqxQQjs6HFMxf+Noq+DvKrsyfFeyI3dMP9tnJY/piZ49f3WjWTpRePw
 l8KATOQfRxdA23jcs0RjsvR0ADACLtCHQcYgI1aeUYdbImMysjVPKKlojKyIe8pstJM7
 JqXDXUvfpBNXUc8gIlQkQwCe0ezjKmaFvoEcBUu5LzFDQ/NXe0YwlrMAmghcVyfRqFog
 pmRQ==
X-Gm-Message-State: AOJu0Yy+ow7Hj2UbdIEEwqwuu6myllbM7pfxddXnCwx98jgUwq1Y2HLU
 Rj3gilDeNPEFCPmoVlkhJ4MwxHX9S4m5gzYpbM5Hw4VRGSL3gUZ2eTEbuhqIGVzXLXttSJ3YbRy
 M
X-Gm-Gg: ASbGnctPGNk0NoG42ia2sVda/rGaAv0SUBra5qP5k4bS9Ny/+Z1a9aXMA89wpm4OWaG
 OSCixeEXe38Mi7oMa8hT+2/xQSZg3ToydCy/Voo9+oVvJq93LDAFIVa5fcvOaa4/MBNTi/gvWra
 atIN/ffSu1LygXLNspMRQUdJCvA2Tk2DRvnbg2dvPL2AlYwPMqcESbTYv7kJgI5qeCujs+SXC7u
 DISISlI3yXbtK2FVeyQsS1H83MYuZ/PlNAQ8/f1CL9ZT0oQ/uICX5hWOx/Xvy6IwecG7rZvz53R
 wEhgH2RtvOR+K3lLLiLKaUikZxwM86MZzf2pys3kxqhy9Ysf9jcEUDcQRFs1DfSxITdseETQr3I
 U8oXF50eEUdacwCR+MQj3dw==
X-Google-Smtp-Source: AGHT+IHsq36P1qerh2SyNQ0b8tbLPOSOzN9fkltTjO23BZGA1uZgTfJe/2r5EWmk092fbTRHvIuYYw==
X-Received: by 2002:a17:90b:3d47:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-3014e86148emr491351a91.16.1741886598001; 
 Thu, 13 Mar 2025 10:23:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c5csm15867995ad.124.2025.03.13.10.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:23:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shahed.shaikh@cavium.com,
 stable@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>
Subject: [PATCH 1/2] net/qede: fix use after free
Date: Thu, 13 Mar 2025 10:22:03 -0700
Message-ID: <20250313172307.274109-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313172307.274109-1-stephen@networkplumber.org>
References: <20250313172307.274109-1-stephen@networkplumber.org>
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

The loop cleaning up flowdir resources was using SLIST_FOREACH
but the inner loop would call rte_free. Found by building with
address sanitizer undefined check.

Also remove needless initialization, and null check.

Fixes: f5765f66f9bb ("net/qede: refactor flow director into generic aRFS")
Cc: shahed.shaikh@cavium.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_filter.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index 14fb4338e9..cecb58c997 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -12,6 +12,13 @@
 
 #include "qede_ethdev.h"
 
+#ifndef SLIST_FOREACH_SAFE
+#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = SLIST_FIRST((head));				\
+	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 /* VXLAN tunnel classification mapping */
 const struct _qede_udp_tunn_types {
 	uint16_t rte_filter_type;
@@ -154,15 +161,12 @@ int qede_check_fdir_support(struct rte_eth_dev *eth_dev)
 void qede_fdir_dealloc_resc(struct rte_eth_dev *eth_dev)
 {
 	struct qede_dev *qdev = QEDE_INIT_QDEV(eth_dev);
-	struct qede_arfs_entry *tmp = NULL;
+	struct qede_arfs_entry *tmp, *tmp2;
 
-	SLIST_FOREACH(tmp, &qdev->arfs_info.arfs_list_head, list) {
-		if (tmp) {
-			rte_memzone_free(tmp->mz);
-			SLIST_REMOVE(&qdev->arfs_info.arfs_list_head, tmp,
-				     qede_arfs_entry, list);
-			rte_free(tmp);
-		}
+	SLIST_FOREACH_SAFE(tmp, &qdev->arfs_info.arfs_list_head, list, tmp2) {
+		rte_memzone_free(tmp->mz);
+		SLIST_REMOVE(&qdev->arfs_info.arfs_list_head, tmp, qede_arfs_entry, list);
+		rte_free(tmp);
 	}
 }
 
-- 
2.47.2

