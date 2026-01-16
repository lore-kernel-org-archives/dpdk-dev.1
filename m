Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19984C982C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53D0642E9D;
	Fri, 16 Jan 2026 22:31:07 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id B82C942E48
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:31:05 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso4747765e9.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768599065;
 x=1769203865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bcPDmDlB8Z2klAn9sp24ZF0sjEu1ETmwOdqd3BpNdSY=;
 b=WZenGlo4SIG6V11Zluu0Q3P2GXIR/9U5vEcSbG0IBMKFjWp35wv3hVcg3qqOgLLdy1
 p3rmtljGoeHPLgRObvJwuYwoOpxjoejSf+l8IWwM68M4IU2Q926mpmzN7Us9r84K5gxU
 HLU1KH7S3iguFUt7YL2GcL/h3k2JctNgwmw08IItpygJaKT8Ud9XmRa2ZJnmvwisjhEP
 DPQiaRHuCfukeqOuWZre/92IGuZw1LoowT0xjewACw9J4ohxNg+++w0Fx3l0XwkGtuPG
 EVJ7cUJL3Mcpe/JlfWm3Q+mpQ6PT6iaDqN2kxzUIx5wBcjTlM6YQabn7aCwOPw0mnD8x
 vsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599065; x=1769203865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcPDmDlB8Z2klAn9sp24ZF0sjEu1ETmwOdqd3BpNdSY=;
 b=reqIGc3Tj2c3m9msI6Vrd0HiKJo5tO7KJa2uR6vQZ/w2/csQDVHgBtFCRc+DNCBtX0
 LuP+KbuIHsoL5ENq1QdEUFe4O2JizPDsdzMQf23pSBsqe30X05Fo6z4S/yCsW27KI6GS
 MIRK0hGjnjKYxZzdGv27shqrMn4yqajsQATpOuU6+Jeo3db8e+bi5JkeHDIbvAAfJdQ+
 VOyUGYmyHMO451NrgKpp3/o/33+VX0h5RnArBrTJRnruPvWEGGT8RHAo1RaPCgCY4pxT
 bPyX5GNQ9JcE/7Sbb2ue4NeQqzvbtGCLuuOfuhahGyTBxb1InYQswRGiHcCjt1XKQUCL
 TZ/w==
X-Gm-Message-State: AOJu0Yz8sr5CkesCxoIpK8ZcwHni2DnS04ArAXj4hU2YeP1h2VZslfQJ
 98P+sEswWIO+hTzuF58lxTrVWbkF0gVJQ5OHMCjJq1lAeNaG//o+w6oo56pXFuLxAVKt1S6eojY
 8sFRt6QE=
X-Gm-Gg: AY/fxX6VDXasB3GvNf2GOik+9zopHKxKSCXrHSJQX7Wv/VbxFtUT28akcashBSt0JnB
 9QKHKVfatiSi3NFBuTFzyhy75couiwLE56NvOLXzB2XTu9tpNoS6Sc1JZWh0E7LSsLyFzrB3vGa
 khw8Hn/xpUIdc2k+UVAyjw8WFDr7H39Ynm0qRUHG0C5VcCZ0J1jc3Qz/7qJxrsEeB2sYKdb0dsi
 jCMzod5t8jtAdhx3YAvZSdGMJJPlkJ3DyMi7MHG+jqQM/pxDuNMC2vfP65on2MdMTqmdc6GriEY
 MqOFzHZgoon/G0tvrPMcHYH3eV65m4GFJa9yTvitKH0z3uCxzdsLk/GZA/1eY1LcFA2waemZcug
 Utmb8dqVRUOJ+UBD0R0ckUtZlT1P27Z1NhKUePEvPnvGRYCcbhiCfq05gFCt+NVfUNvPrvNM8gV
 murv/zSHfxF04jX4tS3qw8WRhpLgk2gNPJsX/BRSxs8nYiZjeHfA==
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-4801e30a790mr54810545e9.8.1768599065266; 
 Fri, 16 Jan 2026 13:31:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm7398759f8f.28.2026.01.16.13.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:31:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/5] doc: ethdev documentation grammar and typo corrections
Date: Fri, 16 Jan 2026 13:29:31 -0800
Message-ID: <20260116213100.110419-1-stephen@networkplumber.org>
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

This series corrects grammar errors, typos, and punctuation issues
in the Ethernet device library section of the DPDK Programmer's Guide.
Initial work on this was done as part of review by technical writer
then more changes as result of AI reviews.

The first patch provides a comprehensive update to the Poll Mode Driver
documentation, modernizing the description and improving readability.
The remaining patches address smaller issues in the rte_flow, QoS
framework, switch representation, and traffic management guides.

Stephen Hemminger (5):
  doc: correct grammar and punctuation errors in ethdev guide
  doc: correct grammar in rte_flow guide
  doc: correct grammar in QoS framework guide
  doc: correct typos in switch representation guide
  doc: correct typos in traffic management guide

 doc/guides/prog_guide/ethdev/ethdev.rst       | 557 +++++++++---------
 doc/guides/prog_guide/ethdev/flow_offload.rst |   2 +-
 .../prog_guide/ethdev/qos_framework.rst       |   8 +-
 .../ethdev/switch_representation.rst          |   4 +-
 .../prog_guide/ethdev/traffic_management.rst  |   5 +-
 5 files changed, 286 insertions(+), 290 deletions(-)

-- 
2.51.0

