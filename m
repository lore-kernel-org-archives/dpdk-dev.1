Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF69FD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E5A841060;
	Wed, 14 Jan 2026 23:25:20 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id BD7A940EDC
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:18 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so2158915e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429518;
 x=1769034318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUaxAj9ZI38Oyb2sEctr5zs4CHDPLgDB/Rg3ScLKtJ4=;
 b=0lIWuEKD7F3WYnsjL+53qVNrZJolOQFa3imoqsP3qN0s0Uj+9etH5mFQ0DqH8Vzvso
 XUeMz6XvI16uW+l3AH7N+MAVZruIloq/ycwNhSZPOyx66bs6xiH3voz/N/eqFKOxM5OT
 NeZzIFMijEUXn6HYiScWt1lxfkKc7yUIoMfpprnDGF49TPOV2vpKrxie4DhBlEfV3PCK
 nTVxhUUClg3jdsCxvw0go8WqZ3RT4imjlH1qISqtAF2G4aDrHdg3LswQH7hDFn2Kt0if
 Q6LHUzNsqXcx+lFNWwIRxvQ84xJU3ADaays4O59tuLrc0t0y4hRycNHa5gWiOTFEFqwU
 OVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429518; x=1769034318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mUaxAj9ZI38Oyb2sEctr5zs4CHDPLgDB/Rg3ScLKtJ4=;
 b=jErgcKoczzdPVKmWRmTxQASs084G2PnX3BV9s+JqRlhmsOssdfPV5C8WcrqwsWlb6q
 Vsio4rdsoRmZ1PyQ2oHIH75hPKtc7Mc6s5yLWKInt/H5oSdIpetO0HsKsGpJwjomjULn
 6TcZPrdcZ1JHsUIMf7FEgufy6DQYKJvN4lZxSvaCUK2doVs5cBYn4njWXDqqor/nymI0
 D29T20IS9WxfDPiaDbZDilonIQYJJVZCk9Yxhg2NLnD4zo7zWjg/q25UUeDQ7QWQ96LY
 WsCzdYhbiAVmYG//ZDby1XHQY5NwSWMFoJNGHrmk5xI7CiraoeVdeJoENu063yivnMwa
 6REg==
X-Gm-Message-State: AOJu0YyBc89Asb/zdgcRS02DCZBbCC4/opLdLqn4TtzDrAvIEDQN2zF7
 QYaq6auswaxx0vxBPEdVhAPkQPuFJnHsYzu0KtTlCnR0uBlEXdEHSZXkNI9OFapZV/SHzRgyqfS
 YeFNEX1E=
X-Gm-Gg: AY/fxX5AwPt8Nc8keOSygZl1dtHXmLnfoLgeYcL9mLljMc7f3GT9cscPGB1d+eWaDGz
 7VfaN6rBTuRRsIs/JW8IcUH+jqvaq2rbxnT6fGSPqfYpADzNyjF41knK0IAQMWfB+yDDLluTaS8
 CQqH3QIzfSNWVBD0RuVm/+oNPgeUHkXy0/tJBcHT3RxcbQwGpAV1Ps7meJToPCtVjIEtCXRdcif
 eL8aWC4V6PYBEUoDY8W/d/DpOFxcTz0OvYAlMi7CebhqhWwb3Bn/rsv9WtASHtRBKB7oMO4PTdl
 PXzz3zHF4qmm6qF10LhleamxzVOORaOqauTSzHPhMEDkMuXJaUNBhcN94wMgkiS7XuPFwNHnG+t
 lZkG5YqQkCZAuTxfBtcM5rljclW17+FJYNJEXWf5O+42mTgANnEINyRd/6o/ntXJ/tqtisBswms
 HaI7Oe57ibC4oD4WEQBCP2yNUchkSks0QMq3W7h4pol7xTFT5mNA==
X-Received: by 2002:a05:600c:4508:b0:47d:87ac:73b8 with SMTP id
 5b1f17b1804b1-47ee3376502mr48726595e9.27.1768429518348; 
 Wed, 14 Jan 2026 14:25:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/29] examples/ipv4_multicast: correct documentation typo
Date: Wed, 14 Jan 2026 14:21:50 -0800
Message-ID: <20260114222458.87119-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Correct typo in IPv4 multicast sample documentation:
- Change "walk though" to "walk through"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ipv4_multicast.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/sample_app_ug/ipv4_multicast.rst b/doc/guides/sample_app_ug/ipv4_multicast.rst
index 3eb8b95f29..fdccea23d9 100644
--- a/doc/guides/sample_app_ug/ipv4_multicast.rst
+++ b/doc/guides/sample_app_ug/ipv4_multicast.rst
@@ -195,7 +195,7 @@ Although both are based on the data zero-copy idea,
 there are some differences in the details.
 
 The first approach creates a clone of the input packet. For example,
-walk though all segments of the input packet and for each of segment,
+walk through all segments of the input packet and for each of segment,
 create a new buffer and attach that new buffer to the segment
 (refer to ``rte_pktmbuf_clone()`` in the mbuf library for more details).
 A new buffer is then allocated for the packet header and is prepended to the cloned buffer.
-- 
2.51.0

