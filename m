Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E5F43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97E8440679;
	Wed, 15 Apr 2026 16:48:16 +0200 (CEST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTP id F0CC240650
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:13 +0200 (CEST)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4779b2497b4so3645586b6e.3
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264493;
 x=1776869293; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=JjZwo6SDuUx6IrkLYqO9dcGiJsFNSIoL3Lu7rg9LM4i4hHSEx31KPhoLfZ6M3k7HK5
 v2eMxrlJ5SBdBA1YEYJVhD3HcFSGWI/+HioDd4Kj65019Ava7DSMaauc2GD6UqvdXE5J
 O45ESOM2aT/SMf8mjMcF/OIWMArxPVEcdGKI/qRXCBQBp2LL/pPKBG7g1rjHEAqmZogP
 7KU7UkNg07HkA6SqNuI9CRBvQxhSuB/NwAbOdq+O3IHm1M1eevqSTLwGT3JtweTxmfvf
 XW7YfOcGhImNNYh9bP2oLkNbRGBVhvaqq280w/9bwbDGoDmI6zVl06bEXA4vo/DnsmQr
 +RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264493; x=1776869293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=TssGYlgsnNzlsxApXzo0K4vZeFwY8NZQLd+yvhNF7LnRbgbKpEFzYWCi2pYiiRffkm
 CTCvo6AFRL2Z8egmnntF+T35LBuNQjuaV642dy+Dgjyn5B/aImBt2u8JNMML+jXHd/I/
 yoc4pAppn0Pu1OVbVKovjJhkFIgYRTayW0TIyexGldvCr3PvTVNFSlM4XpTY6q2eM7wv
 89QymJ7KR+IpNochLxWH1U/27gnK1JM+GZS5s1OkMjYT60vwvWt2myokXrzAnPtvst6I
 lSFytcKKR8T3XnqewvofXNMHpJ9B/aPEyXW5Q/nVbhlxE5QwiHg29/3F9VOxSIhtcSCm
 HSqw==
X-Gm-Message-State: AOJu0Yw7NeCn+MLPKnbLHXmRNTDb9jnqpdYI97wKmrUSwiK483YtpUbl
 nrKqvONHMA/y/EEVe4PmjkEH+xmsBoNqgsXss2pBeDqTFwjgSxehH3Eq+A91616YdrEv+/SAmKg
 DSsuB
X-Gm-Gg: AeBDies7tDabklNROhNWGB+2a91qnVbhXqstFg0TG7QD+kPs174yoLomfAdiAnoFqcs
 1txvjPJbmi9eY6jj/AfYr9X2LaoQULFnCQfpqKulkNB/UfknQC7uhz2cUaAdbMaMNLO8tz8JIV8
 PToULP477ZvDKJ8UUyHbfjwc5ehjtop3f2r+jymgx6YSP4hVmKmiSqgY/Alw51N9SDeAUEkYvKt
 um7jTpYHEy/dtava/KzIcJ3MPMmCFmu6UoI0QtJnYIzBg1jQS7sz89mbNsZzMksaGZa8IUWNNEe
 xygTg/HvEPX4/G97w5bigjE+zqJA5yrkNaRQqsvrSQ6t0ze8c9fmAQk7AtifHKB3AjzJK3f31aV
 FHakhzeHtVX75JlYRFXS4Dq6/uNT+aMFip6c+PJkb8PvlOPVghV51H4cdfINZtnilju0IDQ8Kww
 p6I/OF782huYVlxXAsN6fHLPQGZqNm9AtErI5IOeR5d/g=
X-Received: by 2002:a05:6808:c2b8:b0:45e:84e7:c20b with SMTP id
 5614622812f47-4789f50fc59mr11986546b6e.25.1776264491617; 
 Wed, 15 Apr 2026 07:48:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 03/24] doc: update features for PCAP PMD
Date: Wed, 15 Apr 2026 07:45:52 -0700
Message-ID: <20260415144717.226161-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

