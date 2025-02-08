Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D19C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BA9040BA2;
	Sat,  8 Feb 2025 21:32:32 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 2FF7640B9A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:29 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fa19e1d027so3545710a91.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046748;
 x=1739651548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFP884Oj2lBUZmtdtMpIv0LWkx4rU5WlVkkWd1wQ+iE=;
 b=AyKXn6lXrnKsGnmVXEZNlGiNQbmCnY48u9FcbSNdg37OZtsEWXUeMTdwLDnBJCPaDF
 xkZDsqMYs6uMcnNh3njPG/iauAc1fui/K8Owk5a0XvGf+FDy7Yb01zy2LpOk0jVr0B9h
 aMPipy1x3pu4wR70wbiwN1015b+UDE4/irjbZRW4tHCdFYmwA1/rKx8R+78wg1tMmnVZ
 dXJWAVYmF42GMYKiXDTiNwmfc7eLJKmCyhsGbVuuqvmD7V9KOj7Ah2sRZ/dTiH470qye
 bdoNwzCEOiktM8o8gkWhPl+x7DePPX7X/fMRVYcLXqHqXpl1rurf4duEJe3IMrdX+awj
 lMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046748; x=1739651548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFP884Oj2lBUZmtdtMpIv0LWkx4rU5WlVkkWd1wQ+iE=;
 b=TyqYRnj3FPnO0v68YJP8KkPJKkQCGTCYh5zAFsJSwvitr8TSu9OhiFnI35hKHvHcY3
 Ah9l2kMSbv4i0K8aeerUbRd48FaomUT4rpxLZAUMdw9fpCtX4E3zt2YRTBsIqkAPjdnB
 mjFIlWFtO2XL19UNMSiLq4OnvUaQRLbcPPyiTw+55A+DBrbB/J32CSK/Ak69vevMQsIa
 zPzX7j7YPrAcbLRTL9q6wzT/4pyP7mXqWcV/kEoe3EwtBp6eo72K7q6RcSAkwLDANAFK
 1QRnt6Rtxvd3SK3GrpnS/KilQkBu2Blpilp/Kh5le8x1YlUPKeHgtKYO1vFOtg4sCmsi
 oa7g==
X-Gm-Message-State: AOJu0YznvioSO8ar5EBIQwdNtf0s6SxOpjHIjIifTZ31z6Dg4Aqe+LYy
 mDfHwQEGFIHLrNvLsoLUFPUfR88rtkL/ZQpEtCSfgAy2nxyhDQ0l6u9Qri4rQcOIe9MAkeYBE20
 +Dww=
X-Gm-Gg: ASbGncs9q7R5H677qgOTaMrHPy6PxpAAi5liClG1HKpTo+LxxPPp/zqX67l/orTRIR+
 kRygLZEJzDaaRpD/fCWpGAbIp5pgfrcNF7DwI23/H3pc4YOHvM93S0fmfG262ctXy6glNSbXVNt
 gqd8hGvlvrPCs9QoYhzkhQ0wLPLiSmgTfOAG63jjDQXmrOcnc2TnOwRnmtXGw3lL9K0aaBvRe2t
 hIvQpHcP5y6/TboLYYLZlodjDHgXtJR1iNhGvMnZvpfdC8LhlkyH3MkfJXhDDziS8EkNsxDCOLh
 JpcTpRk8cCPPCq1fzbtI6J+VygG4UZaGJK2PzXqnfrumEepQc9IAJdaN06z+lpHIVXsu
X-Google-Smtp-Source: AGHT+IGQcF0suXuNFZt2z5qJLteSo+1Rcovq2mUNOX+PBPsFfoeEI/H55TzlNWQGJtz35XaUImd7mQ==
X-Received: by 2002:a05:6a00:1884:b0:724:f8d4:2b6e with SMTP id
 d2e1a72fcca58-7305d43a8b1mr14508431b3a.4.1739046748400; 
 Sat, 08 Feb 2025 12:32:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH 29/32] net/iavf: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:21 -0800
Message-ID: <20250208203142.242284-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 90421a66c3..d5bfbecf08 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1139,8 +1139,7 @@ iavf_ipsec_crypto_pkt_metadata_set(void *device,
 		struct iavf_ipsec_crypto_pkt_metadata *);
 
 	/* Set immutable metadata values from session template */
-	memcpy(md, &iavf_sess->pkt_metadata_template,
-		sizeof(struct iavf_ipsec_crypto_pkt_metadata));
+	*md = iavf_sess->pkt_metadata_template;
 
 	esp_tail = iavf_ipsec_crypto_get_esp_trailer(m, iavf_sess,
 			&esp_trailer_length);
-- 
2.47.2

