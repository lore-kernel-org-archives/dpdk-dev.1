Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5002CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:57:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F420E427CE;
	Sun, 19 Oct 2025 18:57:33 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5E68B4013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:32 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so3183949a12.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893051;
 x=1761497851; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCUaDkR1TQsccPHsVbdGO+p1YP5ROe9SuNgjYJNi6ck=;
 b=xlokiFDooK+ULN1zq0hXO8bzDmm185ZSzc1ppcPMKXUvwibLtpPipc8UVH14ywRVq4
 e0HWdL/LR7j+vDisYX3NBL448oui7OhLricwscc5lwZqvbPncqv1x+YbfXDeUUwwgg9a
 Rv+H5qtTJBmLRDeJSxl+zsDN1fVus6CmKm25bagJ0HNA0AR0WxGQ+uP5xJYRwUZ+d0X7
 qGu0tSFzsCsovn75/zVUQkpSXN71fBFGBJVa5M53FbTh5zgxXelf2s4ajyP0jFcdVvFh
 5qLfaexFGddY6wGExIoOv1QBqY/w0RtXdnPjb+blXZkA62tVcJxjcvZm+DFmIPpquBfl
 +Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893051; x=1761497851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCUaDkR1TQsccPHsVbdGO+p1YP5ROe9SuNgjYJNi6ck=;
 b=V/LSB1w1tfL3fnGozAr/7VIfDW+HrsGl4A3lg739qYFziWpSwG13eEIESqOQX37Vht
 ZyD1KvZ4f04LMF705IBxDKHzdrU+Z8irkwS4GQzG7yA2uk88x4rXl7/M0cC/ViJf7WBk
 fx19aP2uaBcvYyhAhMYk/KRRma0M9Z22dl5sPdLByiXGDeT3xPdihNCBVV8RlGf8yoxs
 iCJEVVoeaqxIFTEU34tyfbi3tOIengJqzMweYcHSGQnvda792WfiZdFaHZWLZC0iGdnb
 csK01xIZZFhVmbUdLiZvxAFfOrIS28qp9iAqa31EMatW0CBvn9YGGIUuB8JjJvsYmc3X
 Xkqg==
X-Gm-Message-State: AOJu0Yw13CO5nwVVDzzCfp5wu8+7QWEiulwrnef9DUZRXkZsHr1aqN9l
 VpFc/mq70pntwk0zbMFzusNbFaO0P44ERXDrMDF/mAY3RjC+lCY+f+B/as86sQowzTwADq6FU2g
 U3gygV4A=
X-Gm-Gg: ASbGnctSxYL2azGdRxNH0Y9gXalxJliPl1/McKWWkU5VTGOj2DYc2Vp+83+LEOFTxE1
 tWLMe+aX9PHjE30QE/sC+BmTgDfGWC0G1QWq6sGQB2Wrvh4/za8N7guummE44CuC5dJk1g157ME
 5K9F0xLD6Mr0mFcn+kXuxV0ufcsOOivtfyGEd1JSAjfyYiRO8n5o471aHEJwK3OAG80lgE1ldAR
 9TNHhfYdKxHeripHSea4998F6fk+UD9cX2QPNaRN2pcG43OOyBFIuWLXn+Q3X5HDGeiazMrHX9Z
 KhSI/2qX41E98TUQFwuyru2pRYx46MazMqMEUrIytcH5aTVcKvIyRgRL7pnQNTvCOToOWGYDyvN
 yEhn4gMJKl15Mtn2lGHAJDNRwllRyQbMSAyj++35rjHXJwedd7Pw6N8NfTTJ5HtI9H3936hV+NO
 Msokuq021a7eAJcKk9egM8UpA63HPcfvpM90qghiFNbjtIrAIo1g==
X-Google-Smtp-Source: AGHT+IF+n4bjiuCe5L1tNx4x/HJ4Etfu6t3RJF82SYxaM//hFJYMjYXaOHcdQ9AvCOgvbpQ0rGtxpg==
X-Received: by 2002:a17:902:ce12:b0:28e:7fce:6685 with SMTP id
 d9443c01a7336-290cb94792amr120769025ad.32.1760893051333; 
 Sun, 19 Oct 2025 09:57:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/8] packet capture bugfix and improvements
Date: Sun, 19 Oct 2025 09:56:07 -0700
Message-ID: <20251019165728.164929-1-stephen@networkplumber.org>
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

v3 - add release note

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
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 lib/pdump/meson.build                        |   2 -
 lib/pdump/rte_pdump.c                        | 273 ++++++++++++++++---
 7 files changed, 519 insertions(+), 109 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

-- 
2.51.0

