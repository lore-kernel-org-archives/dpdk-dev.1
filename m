Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E007FD46BF6
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ECBD402DB;
	Wed, 28 Jan 2026 20:47:28 +0100 (CET)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65]) by mails.dpdk.org (Postfix) with ESMTP id 32E184003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:27 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-43246af170aso160105f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629647;
 x=1770234447; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwKshHBFN6+bPsLGKa0ZdtWhqhq+2XZWdYuBWPh4suE=;
 b=bEttH2tPCDgarwXMcfsIXVZCBmcJ9E2hrDAEDmkJ+Yu7OpXeI1d/2QJUbZ2XyAM90X
 WyPIrNI/7vQrrQS74gG8jZ9J5tS+b6ATFKvwQ/yDMNIp5yk4oCjfY5CJq9WVENoDo02V
 5bIcj5V3L7UUEIRDTGGNgB2rxdWKhD0sPp3h3Ak19sVxYZn/m06uP32GqRENs1KCASuj
 HAk/WStxLkz4nh6l8VlwSUVUC2zlZn3NZZVhgXRjinlHGs9jc1+nRkLyLoOyTrKNUKmZ
 04bkCYP0ns2QtuSOb6j78rKN1NHEGj+qgobNOlC9jZRVO4AzVNDVlAXjU54X7au0/PPm
 RHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629647; x=1770234447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwKshHBFN6+bPsLGKa0ZdtWhqhq+2XZWdYuBWPh4suE=;
 b=CLimquTZgjajspsZ4o3fFQ6Aij8RCawu9CnZ5Zrrvwy5kIe2JgzFsiKG4N02qK2wIu
 4m0Sph9x1X0KK6/ujSFnnEP5nWRQadq0AIirxboOGKNQXPe0VAenUGJV2y6PAK9Bf3IB
 yRtkJSoMH+tM1lK0T1Cfk5v6XrzgriP/hWVfEATYQ66tDNg1Ir8I/sQLOBR8xw3o/ZGb
 SZuQepQvhIau9yD3zm4iEHaunvnohVHMPAGRwXHMAPXD2D6drvIW8XXjnDVvV/NNniFa
 1Ey/7vsS9aNuC8LjDsfRd5de0QSE/lbSxV4wPMmdnlwc/2PUQjm4oQp4d2igsP05pHXg
 228A==
X-Gm-Message-State: AOJu0Yyv9nyKNRyVNoiPFhrAMOz0iJpCji+9n+gcjReO3KEmWbayu7Ft
 /Up6KkyR9eUxOFIHrD/I+uZi6ppi5GGIRbMH46Ea5yQW9OcKeo8fdHkesR9jl3gLUp4E9q5/mYf
 Uihcdv/Q=
X-Gm-Gg: AZuq6aJk4GNgkY2GAm05xWzeUpyLscii2x806dj8os4VRVp3kAjl9gV730zXiyhZGob
 5c8DHwPaoU3TWIVXl+Q3YAto0zxRw5z0UWSPoQX0hMs+6O6j0v1y17ljfX0IjIsiK7C9mG/Aa6n
 qeHD04YKJ/gEJ0DS8yXnRTCKOVSEK3QpMm+MMxfbSmqYUbReJa41SamG6ZOpNnnuUFBwwUEeXWM
 krzhB3ZcxLy+s1Ytc7Qdv38P1QWFMKHKyOFLtRTsiSkjad5LH5QF3QA7kMXm6ONQ4W8aWUM2KYZ
 kUMkDM6hb2FtWQXLxERWsrW2LCuyhUtokTYuUC70kKP/a4vsB5tEYIHKkkw6slqRfrVYqRXBVjh
 xKYi4hmMLAEShZIX9O4IZj71709QVZjhOn4UbcRzFfCjL9kQO0pW0zkAE1beio1blHh8f3XQaas
 nEb2HCiF+QI2IyYz/RNolcvf1tLAq0RuemozcyTEteLIIbgtxQow==
X-Received: by 2002:a5d:64e6:0:b0:432:88c4:e180 with SMTP id
 ffacd0b85a97d-435ea0f421amr958197f8f.15.1769629646644; 
 Wed, 28 Jan 2026 11:47:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/8] doc: ethdev documentation grammar and typo corrections
Date: Wed, 28 Jan 2026 11:45:59 -0800
Message-ID: <20260128194722.480862-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116213100.110419-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
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

This series corrects grammar errors, typos, and punctuation issues
in the Ethernet device library section of the DPDK Programmer's Guide.
Initial work on this was done as part of review by technical writer
then more changes as result of AI reviews.

The first patch provides a comprehensive update to the Poll Mode Driver
documentation, modernizing the description and improving readability.
The remaining patches address smaller issues in the rte_flow, QoS
framework, switch representation, traffic management, and traffic
metering guides.

v2:
  - Add patch to fix minor grammar issue in ethdev introduction
  - Add patch to correct alphabetical ordering in ethdev toctree
  - Add patch to fix grammar issues in traffic metering and policing guide

Stephen Hemminger (8):
  doc: correct grammar and punctuation errors in ethdev guide
  doc: correct grammar in flow guide
  doc: correct grammar in QoS framework guide
  doc: correct typos in switch representation guide
  doc: correct typos in traffic management guide
  doc: correct grammar and improve clarity in ethdev guide
  doc: correct alphabetical ordering in ethdev toctree
  doc: correct grammar and improve clarity in MTR guide

 doc/guides/prog_guide/ethdev/ethdev.rst       | 557 +++++++++---------
 doc/guides/prog_guide/ethdev/flow_offload.rst |  58 +-
 doc/guides/prog_guide/ethdev/index.rst        |   6 +-
 .../prog_guide/ethdev/qos_framework.rst       |  59 +-
 .../ethdev/switch_representation.rst          |   6 +-
 .../prog_guide/ethdev/traffic_management.rst  |  25 +-
 .../ethdev/traffic_metering_and_policing.rst  |   8 +-
 7 files changed, 360 insertions(+), 359 deletions(-)

-- 
2.51.0

