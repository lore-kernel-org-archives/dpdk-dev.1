Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80156CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E6E2410E4;
	Thu, 14 Aug 2025 18:53:16 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 0A23A402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:13 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so592982f8f.3
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190393;
 x=1755795193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqsng7OnpcEpxHSmmZ4V6IpZeThsOPmDIwEVFi5GhsQ=;
 b=WcLPPdEfTb716vRYlffME3EsNSvZo3BsK3NGNUPH6RtId+H3svj4Ygz9Mzi1tdmpxR
 OfIb/0xCeBhKA3fJYhZo1znaWc/0UB2+7hJyX3g2ztuHWclpcm+UFsSmU5s6bfIu1hRS
 x2rdf/hbbVGnyISxHzZD3a3AbHg6NOm1cfRy02qcadbSLyxx9Jw3lvs66ugqMeXgo0qY
 PtA1V2TaoiMVHLET9TzvknhoTP2q5Xm4w6zSYSdVwoGOCZExdkyp/rWPbNnhgNpj0KaZ
 BM1ljqtKfEJ2TZ7hjhqN9q4Kd4BRhEp0x6thD/FWboGn79qdxs5iqzLQFOulrflg/lDB
 2dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190393; x=1755795193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqsng7OnpcEpxHSmmZ4V6IpZeThsOPmDIwEVFi5GhsQ=;
 b=uJGcksvlf6UTnuyJGiDZnAsPYZEMYhh0jEwRjkjuAnRWNcCRJKMYRcaU6g07xmmzRb
 aFUcey4SuehOYTNASQyzczyN5R56uEUxmp1ewbBWdl1yyaJq2A7FjFa/KjpI5yTRSx7M
 nLSaGKFLjEf/x5pUJcK8w7DkIoxSbLwNgyOiRPDZKPy9yTsdh/NtZ35UwwEwQRPalT4S
 oBwjWuA8LRhxHg+2Ett6FP6GTPuKacymgjlIieGOGasBTgHewkd4b4gRhCkmR+4xmb6R
 KosV/n8EYTugWybtn3IJe8+LAxRpw872duDPqetLcklRD2wdLmKkO5HRRbPss4G1ga47
 ZBFQ==
X-Gm-Message-State: AOJu0YyJj6itAKZVPGcAusyMhH7e91fCqtBMCo2MsmcK5SGW2qQ3JAHv
 HsZqVV1SjMiK5dTMuomU+5sedsqE6JcHRgjJ2GpUKswO7gSVg8cX2tUtu0qH8NZTnWk4bxJRNi/
 7bkPr
X-Gm-Gg: ASbGncu5WA1aTk+Lj4DAR1p6Z+0m0OLQthOgxL/KbAcvFsd0BUA8f27D32z6OzDdbg+
 hR2fz4Pd6wZ1Sf7t1IPfHxkpavItzBkyzVc5twTFd3jDfcYyLNvS/q2on3siLFDNh4wSQqn3XRk
 4XqFQRf1sZVHLudAE2qfRKCPRNgpXN1IJSGGBSUcg3b9YifXn1+PX6yq4GYWKZ0lN8o1epb80W1
 vQpQC/EJ2uTe7IWFpXifDqkvntP76Nv669v9zM7xBEGdgdHgS6nBkO2vZSEIt0RLtu8+/Q3j/FO
 PLYTrRhJpnrQ7pDQc4bDXaViL3cYrj1FyMPBp2FfdzLT3eKXnilqHvrzH3PoI81wMggts0pBrrf
 oo93/miW/phonA7gEpWhg3NHS7XrwuQ2AdNOrAtj2avjjI7sitY9/Pk2WzCB70T6GiOWhstz2
X-Google-Smtp-Source: AGHT+IG8kGi9aPta15FaDB6UZsXamdYwH6tjKa9UOj7dwvxld33tk2SFFtdiT9KbXjdPoLETqvhTGg==
X-Received: by 2002:a5d:64e8:0:b0:3b9:16a3:cf9b with SMTP id
 ffacd0b85a97d-3b9e415873cmr3297943f8f.5.1755190392879; 
 Thu, 14 Aug 2025 09:53:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/8] Packet capture cleanup
Date: Thu, 14 Aug 2025 09:52:56 -0700
Message-ID: <20250814165307.12786-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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

This patch series addresses the problem of packet capture when
the secondary process is sending/receiving by using the same
mechanism as hot plug.  It also fixes some bugs on shutdown
of dumpcap (and pdump).

The documentation has been updated and improved as well.

v2 - add documentation

Stephen Hemminger (8):
  dumpcap: handle primary process exit
  pdump: handle primary process exit
  pdump: fix races in callbacks
  dumpcap: handle pdump requests from primary
  pdump: handle pdump requests from primary
  pdump: forward callback enable to secondary
  pdump: remove use of VLA
  doc: update documentation on pdump library

 app/dumpcap/main.c                           |  14 +
 app/pdump/main.c                             |  16 +-
 doc/guides/prog_guide/img/pdump_overview.svg | 135 +++++++++
 doc/guides/prog_guide/pdump_lib.rst          | 183 ++++++++-----
 lib/pdump/meson.build                        |   2 -
 lib/pdump/rte_pdump.c                        | 273 ++++++++++++++++---
 6 files changed, 514 insertions(+), 109 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

--
2.47.2
