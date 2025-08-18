Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:19:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4AB040658;
	Mon, 18 Aug 2025 18:18:41 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 61BA0402D9
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:40 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9e411c820so2349022f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533920;
 x=1756138720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnUIm6r3evkQDeIS7kIEja6eI1tEL3SixzHuyNY5FEA=;
 b=Qmxe+HuaEyy2Fb2yhChIyq7hIFi03VVR2CPSXL91w6/g8+T04Hhoglgko5z1JNyuv9
 g9fdZL6becMSSZq7DXjknSIAHtRIFl02GuLSIz8/JetmjkqwQ484e1jLoWoO4hI+aSsW
 3X40vf1JqjzfdAEP9s6jBgenUHcuczIlff5usTZogy0HbQhVTjxo62Od+VeSsG4zgSJD
 CkReXyNLd4XoLnnHR3LiJY1N6yKXh1EJ9EpdziBoNsTgm8zL8DlNNcIlB0U4HoaVTETq
 U6zSCNBdS7ZTWFgfqR9snJBOmrLL6YJfzD3kzoXd4Fx1ISXu6FIS0kVzE3capkwcXIvZ
 uxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533920; x=1756138720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnUIm6r3evkQDeIS7kIEja6eI1tEL3SixzHuyNY5FEA=;
 b=JQUDRUvkF5ofr7ou3JUda3PMPTAcOEKvGm7eA29UDk6qRvUPbHrHaG2PkECZ6AGK0i
 2u6W0Pi9vhBLNYruS+KwU3DRAfeKu+oCDxMJOAGqOLRkmHtalrybEHwlny9lqOs51Pka
 ZfFET+wxpJRcz1seCvima+1UWxFFUBpCNM++Q3IzwPCSyik/2/YKhEN1OEKxU4IXq2Xx
 KgsiS4eFUd6Dp9zITZN/udvHhy4qE4DKnURyGlhdIdPVASswNaZc+0aex5cSAeuBYse+
 N87ma13eijFHDYHu4waWzSp4/zUHs1MrkK6jKDg21uE+T3hLaqzRSfRHOC/GvkAR3kWH
 AjvA==
X-Gm-Message-State: AOJu0YzYfWDi88W2JgyP4ydrp66JHeGktTCiQ1Hy2iz3e/vCPdorV+Rs
 d8DSwrGSlDXv6GGpdYf7K/RxSA0YpLSF2bkknMYsqFSvpXbY7t6MwWw+QxUWdn/0RzpG+SpIIEd
 vqc72
X-Gm-Gg: ASbGncvsN70jZ0Do32Nmou23E43+Rn5JpcP6LmH9Xg5jxF9yxBBAS+TYDtNIzjBqrFf
 7cwH4KhfCba6nnwkOqzHK9FJBn6versV2Kh7AcxLspmkJ1AYvq/lRSrq2j3UrxQW7SgqJIF9Hra
 SOK7xxQHsapNFTXRr2XAs+pRQToL8czfFszmVqJNx+HEgSk3RTyirUc754kmH1+7GCxiUvVnEVy
 7HtjETk49w8BPOJMJeykqTNY+nVy+1ilT+x9RdgrTIq+ZcxLQ6OqwNgWI7PVPNCvbdlBBogXAtM
 a50W49sp1fYnnDKtT6Gpt/QzyM2h/FHR01OHU6aOwwKarHniHnxbNDX/93Q3GNpmvbdRkCXDoJ1
 p18CboPLhfbyFOQKNN+dxbJCT//PWwOqJ7NGcYY4Q2Okjgc0XO3NQ3DmWNW7e+8TcP5m6unu+
X-Google-Smtp-Source: AGHT+IGwKHFvUR1rt767lzEHy4wxLiCKbbYtJoGpPJpvhytD9iWRWBrgUMa1NTHYePppuWeB4gel3w==
X-Received: by 2002:adf:eacb:0:b0:3c0:7e30:a95f with SMTP id
 ffacd0b85a97d-3c07e30ac4emr5852f8f.60.1755533919968; 
 Mon, 18 Aug 2025 09:18:39 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v4 7/9] net/bnx2x: remove unnecessary comma operator
Date: Mon, 18 Aug 2025 09:18:12 -0700
Message-ID: <20250818161815.23611-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
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

Use semicolon to break lines.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 51e5cabf7b..8790c858d5 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -1537,8 +1537,8 @@ bnx2x_set_q_rx_mode(struct bnx2x_softc *sc, uint8_t cl_id,
 
 	ramrod_param.rdata = BNX2X_SP(sc, rx_mode_rdata);
 	ramrod_param.rdata_mapping =
-	    (rte_iova_t)BNX2X_SP_MAPPING(sc, rx_mode_rdata),
-	    rte_bit_relaxed_set32(ECORE_FILTER_RX_MODE_PENDING, &sc->sp_state);
+		(rte_iova_t)BNX2X_SP_MAPPING(sc, rx_mode_rdata);
+	rte_bit_relaxed_set32(ECORE_FILTER_RX_MODE_PENDING, &sc->sp_state);
 
 	ramrod_param.ramrod_flags = ramrod_flags;
 	ramrod_param.rx_mode_flags = rx_mode_flags;
-- 
2.47.2

