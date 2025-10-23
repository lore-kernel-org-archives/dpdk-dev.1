Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A2CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D33402A1;
	Thu, 23 Oct 2025 17:47:53 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6BD40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:51 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so13882585ad.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234470;
 x=1761839270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37h7EnhL6WAB5F9U9CyqaGCCF2O7rggxmqczrMYfeVw=;
 b=wBm5M6zwNZ2U3BYLirpCkbqvMFn0IlvtMpf2kMJmPq+5fku+jq0I/0QpvaTuqfZAtU
 htEdtfhKOf7t2/4NuUVOeB9AGaAGbi6PAHlHk6dQ0kz9siXNqOoscF1Q0Jc+IwAHyFI8
 Bzl9z3p0LXbHGB8h64WTsskApBVR3Uo4rx7HjK1VI+Ko87Ljg6/PeBvpbdDisc9OZQoT
 plJQpLRf8c40X/fdiYeHbGwRRKObiELhr8M8Fl5VOEColZSiw74mpHnlAEz1ZVS9jiaf
 2dIqYy6eF/q8NSEn4XKrox5n34PuCx2Rh7v9gt8ISdbAcqZSM1yBpA33ceyqoAlZvvDP
 T/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234470; x=1761839270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37h7EnhL6WAB5F9U9CyqaGCCF2O7rggxmqczrMYfeVw=;
 b=oKe4hjMo6E9KJm2onu/Hgvu0YjmLChc6cLUf0tLm1H7C1BQwt0GnOAZRCm69jJ8RB3
 Bzmjc5VCNScYcpaFbL0DFPY5XFPsvZ241IgwYzLhPySTCRefaE9s16MxvgyBvQDzwiyh
 ovcIQEaoXWpHicJ2Ht91o9EEl/UsbhJ+B9KDDCUDh/7zcM4YLrNe1M5hDI6SiXn56bmk
 /8+q2hKQ4Ubq8vvUYWeB6ULbKMpmCVos1KmGarP+1Eq+lD6XgjyAxB1Kn3LrAtEYlSs9
 Afp7g031+/AfHDJSgr968bfK1vilq7P3UIft6ZPhXGzb3GK8/b6pde2Juz2M/zB34Dmr
 71Yw==
X-Gm-Message-State: AOJu0YwHZspvKnWwjPl5Yh37klF9OIyN5GOgZNXczK1FRRC1SMBMgHlm
 XhnbuC4VSDk2PprjetV3K3Ah7Stxuqgk+3IF2bMrJLoYZXdeEVYbl2rvEpCVdnlNI3bdYX8e2vU
 QzTL3a4Q=
X-Gm-Gg: ASbGncueU3ogiiPtmHbDU/LmAQCSE75oeWSrI6nwq77qEur6B23X/r8VxHnEM58IO49
 XzmrDEqdTkix3pfir6lGDLLplrGF3QpVWKgOlDTvV3AeENEMI7CCSvsHoHKlCDywMuOk3UFglEc
 LhSULue99HK8kCi6vcdbUDtfz8mpT18c+zYpZ23ZyKEs28vFZYcC33j2cbrv2nPaZnn8XCwHIgM
 BJks4HSobOkJLjVNbMp/p+dyuZC+8qr1lzk75UEFOU6VErM/nw5LtGf3M5ZfKym0565PZYRxUD8
 VH1h++mUNiLSWbE7YSTGolOFJ1Vrd1DvGzSd8ZYr+/f+rAF/wdfKN6aJ3tWE0UyZQHZtgYrUnSN
 cfQQWr5qyt3C+Lujd+nyKiVPrW/cV7Sa81zX5+toQMiNaq9iZ8pyXBIUKc04W5kDhmHHjTrjNvm
 jdMsrVAmMyDViimP7WDB/n+a790Ap6r7LZBbUBtQ==
X-Google-Smtp-Source: AGHT+IGrvfwh2dIdpsZ1Bix6FKmxTPDlYdNPCL91SoC8SkOse4r1EK5eOxvtGYrU90aeElqQrSgD/g==
X-Received: by 2002:a17:903:1a4c:b0:24c:c8e7:60b5 with SMTP id
 d9443c01a7336-290c9cb6243mr87977125ad.16.1761234470166; 
 Thu, 23 Oct 2025 08:47:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/8] packet capture bugfix and secondary support
Date: Thu, 23 Oct 2025 08:46:21 -0700
Message-ID: <20251023154748.38535-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <250811213632.16023-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
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

v4 - instead of using alloca() instead process in chunks
     which avoids possible stack overflow

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
 doc/guides/prog_guide/img/pdump_overview.svg | 135 ++++++++
 doc/guides/prog_guide/pdump_lib.rst          | 183 +++++++----
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 lib/pdump/meson.build                        |   2 -
 lib/pdump/rte_pdump.c                        | 320 ++++++++++++++++---
 7 files changed, 550 insertions(+), 125 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

-- 
2.51.0

