Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0DCFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2712240ED6;
	Tue, 10 Mar 2026 17:14:21 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id C91A340EDB
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:17 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d7653db148so181493a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159257;
 x=1773764057; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkxVgJnhmQy6SsBFsffX/xocdKVo5XZqNEo7pyihiUw=;
 b=luKx7Cmhg0D4oEsli2nMhIt3UG4mxMxAcprDWr7wS78Km+dIEHx+X2r0c/BSmHTvzA
 wEZ9ISadtWwnBi6Q6/2l34CrcGLKZDF+y9lcMx96s9nxtJh6ieWvlOZEtzLKsWZtDF5n
 oapeW7SNFmrHo8Pj6mj5cwNDPeyE0nLpUs7wfjd4wEtrjKjmy894Ljse0QqgIzmIDmpr
 FqJb221OHKD+H64/pNVeC+qtETYKkQ6wHUIuwPNLt8qtEyfgnKAhTjHicVuIIt9mwUjZ
 K896xLbPEt+ermaJKBr/DwHHqENWtRZB7o3daPtgErDfnTeaQ/VM4IsHy8VffmbnpRLI
 ll7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159257; x=1773764057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LkxVgJnhmQy6SsBFsffX/xocdKVo5XZqNEo7pyihiUw=;
 b=D0eX40QOfOdyIfJPYDaVXt9tWwrpAIwtAWlfl3HEhNhB0Jbmyc5xnAnabFcjinGBCF
 Qpcox/kBjDrwi0BoG14GfIULSiXRMCR6HerBZz73KzG6GSblvm2SE0+fYAPabSnF4QTi
 82DdJriJQbVKit9yBqPswVXyWqpM/svjJt3KnXZR/cxSd7fcHcrz9W72SZ4q8Eg4JRFJ
 TPGxyiYAtSgU2PJFwldZdwps9GhCMNXSRmquWarD+KJ8icL8EaiqRFnSeWgUTcbzYJck
 V8T9CQ4sMJtHqpDKDgJyFbpHX3QRq3Qc0xDvnt15QY2h/xnG6vltgj/BQ2PXnOFUgadB
 lc8w==
X-Gm-Message-State: AOJu0Yx8mqDRakH9B0aAmE6E3rTOtizumxBu2oaAoypl5hbSQxpYd0se
 EeyufrnJk3Sy/TwsAtyunhRCZ4Q2WbrCszxF90iKZv/6Hr++YBTEehAVo7RjqtUUz8D8EP5hIdC
 U6WtvPKs=
X-Gm-Gg: ATEYQzz/NCy35nr77KNyOO2yVA2ACzlszANG6t8+2sPznQQvJYn6o9R8Xe/5AfgqRhS
 Je+9CdmgiERw60I9YZP+B3uzyy8IdQc7ajHRGlQaLlp5oiThyC91tJF26dJ4+rYaaYQdA0egyyO
 ZOi0O29M+EHaDKCJQpkh2eoGyY5YLetIZ5u0OwuFtKmmOH3XbD+MUGfI3m56WEAZP+rJJsBxKzs
 3za/PHIVLSRywwwl1tgBpqW2eGU8DJgI/1FbmhJLNuHL1aguYt8LoC/aEowOmGLgA1qAOErHIxq
 aDJhDVEXOCOtll48bT9zAz1tGATidzE3PopD4ZPrjKaEr4/Kd1GstZqcLuocjY+Zj7I+xHEhSis
 EFwxsLCAukDXdrQ29S+a+RtfA6eYHAoiA05ciUDFOYimvbe6w8xKh6tqnSl1wcQ1POqz7Mc98ES
 b9+85ePiNiiMCfSDxVzSZQQ76d5Oi1T/pw
X-Received: by 2002:a05:6830:2aa1:b0:7c7:6bb4:1197 with SMTP id
 46e09a7af769-7d7270268ebmr9759493a34.24.1773159257043; 
 Tue, 10 Mar 2026 09:14:17 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v20 15/25] net/pcap: reject non-Ethernet interfaces
Date: Tue, 10 Mar 2026 09:09:53 -0700
Message-ID: <20260310161356.194553-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

The pcap PMD sends and receives raw Ethernet frames. If used with
an interface that has a different link type, packets will be malformed.

On FreeBSD and macOS, the loopback interface uses DLT_NULL which expects
a 4-byte address family header instead of an Ethernet header. Sending
Ethernet frames to such interfaces causes kernel warnings like:
  looutput: af=-1 unexpected

Add a check after pcap_activate() to verify the interface uses
DLT_EN10MB (Ethernet) link type and reject others with a clear error.

Fixes: 4c173302c307 ("pcap: add new driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 6b728c6009..b9e828f5a4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -642,6 +642,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		goto error;
 	}
 
+	/*
+	 * Verify interface supports Ethernet link type.
+	 * Loopback on FreeBSD/macOS uses DLT_NULL which expects a 4-byte
+	 * address family header instead of Ethernet, causing kernel warnings.
+	 */
+	if (pcap_datalink(pc) != DLT_EN10MB) {
+		PMD_LOG(ERR, "%s: not Ethernet (link type %d)",
+			iface, pcap_datalink(pc));
+		goto error;
+	}
+
 	if (pcap_setnonblock(pc, 1, errbuf)) {
 		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
 		goto error;
-- 
2.51.0

