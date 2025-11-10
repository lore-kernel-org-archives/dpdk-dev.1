Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE4CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 18:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9DA6402CC;
	Mon, 10 Nov 2025 19:22:14 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id BECA740264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 19:22:13 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-bbabfe5f2a2so335537a12.3
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762798933;
 x=1763403733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=brh2L4TryMrleBbxK12R7wsWPaASChvpJFzGvnZgE4Q=;
 b=K2Li5xNF/XEeR1svBfsDKEuZqYiDcQzimzVTkVtmI3xB5VeocggaAxE2XrOS9wsTS6
 bP47XcluyROkREUM9zHMA2b7TfVmo0I28d5cFdYuQ/19yvq5uMx8KIyEN8jSUzjYlT1A
 fqqSW36v0XpENd7HjsiU+P2nfFfSEBCDyWXreBH+kXtRkKYjr9hbhLBDz9PdGRUGMhHx
 aQELvFlNgZhp1hgsy/mXLlwBOiE+KPdeYq4qN4/IxUdNvYHF0FlQOQYKrgI7SNQ4ss0r
 NmDFyzYfI0HiIUs6T/Gremr8C+XW6YR8PVJ3Oxf9RVdXo0sgY1z5TJU/WRtNXkeZ8+Wl
 6o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762798933; x=1763403733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brh2L4TryMrleBbxK12R7wsWPaASChvpJFzGvnZgE4Q=;
 b=AaOLF/nCuOVSrciaTq3kFgqKVmu0zVqQV89zgvcFnzkASfMcq3wEf4qWmdS9OgmPdf
 VlMuhBCBEMT37fwn4oGBrk88ktpIMnfhGP50HCCOvi1swqNYftA8sY1Fs7k0Qlk+dzLd
 V4c14SdWGNOn55HU/60JRZMH1tDIkONhTAlZ0j8hdTrrlu7ZQ8HWd2VemapwhFLlAVNg
 mJbmUVlURTswHk6kLw6L5Z17NP2e8OKclT6IzBLD2h7inYw4bGvHQ1cWLAuuGe7uoqMp
 3XMr83qah8cq71/osr3NEsngC05wM9Qe2E6ePzeS38VEpZg3y8PAjnjIGWud9EPkVZTg
 6xdQ==
X-Gm-Message-State: AOJu0Yxyu5CPMm/JNOFcVFVzbDIV54/VgN+IgbfgkNJIefioP84askD5
 R7P1ek2q21rqBzLpme0g32knoEtGGDDSeD+jEScbGFX224Wsqji6nD9nblm29taC2J80HUDwQl0
 5rOw1
X-Gm-Gg: ASbGncvL3/Giy13FOAqS56CHx5z3JvvIw5Na2PUMc8CHcXRyajtegVyEkdSJAwySrqO
 hi4mewcap07rsTJkBR4b3e/+i5aLf3ihBu3+YyNA7wS/BO/r9Y3+vBIpaJZojshwd/Y4DOAxOpC
 6b0nZ2Ly8DiIpDmjdvVAAtsKElQsltIejitDuzP+43PsEHIBx0RBA7AwVnq2L3Bk/V68y+xXYAj
 rf+SAUejMLSayIqaxLBEzmfsvauT2nyow1ay6DJRm9CAIuHT7+yvcOEjtvTUmQmu3Vdk/p7TphV
 goaMAKErQ2l6vX2P/Ne1k5N7dEpOpKpB220z2Qf/tR+2xp7nzh7ohMFnxYLlVJzdMLNzxD5MIfk
 uFno/kANPMQ8xpOnlkPqtEJa5tuk/pNcr24+MriwoZQUOGB+EqNMk5eu78ttURb0xU2cUt+d7M7
 LTmSnS5H7dMK67U7hoHvYBL8y45jdfCfm/JtNovjVYyerrTJjlgQ==
X-Google-Smtp-Source: AGHT+IGaG07HP/mh/OqNdhqgpCyD7C+s0HuIwB7G8CCKpcxs+LW4d38hvF6L7C3qQPIoQdhlSZQTIw==
X-Received: by 2002:a17:903:40c9:b0:295:275d:21d8 with SMTP id
 d9443c01a7336-297e4bff754mr119800945ad.0.1762798932451; 
 Mon, 10 Nov 2025 10:22:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650968298sm156290405ad.6.2025.11.10.10.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:22:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] examples: format truncation bugs
Date: Mon, 10 Nov 2025 10:19:32 -0800
Message-ID: <20251110182209.104087-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Enable format-overflow warnings in examples and fix the bugs.

Stephen Hemminger (3):
  examples/server_node_efd: fix format overflow
  examples/vdpa: fix format overflow warning
  examples: re-enable format truncation warning

 examples/meson.build                       |  5 ++---
 examples/server_node_efd/efd_server/main.c |  2 +-
 examples/vdpa/main.c                       | 12 ++++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.51.0

