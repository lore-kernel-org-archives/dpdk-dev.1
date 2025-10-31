Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855ECCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB49540395;
	Fri, 31 Oct 2025 17:44:22 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D048840150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:20 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-294fb21b068so26619515ad.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929060;
 x=1762533860; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln5UxjhTXyihDKrskjElugo5dDcXTBv4zBXZrGocRsE=;
 b=KMIE0gHvEGLyqJ17t+bippUXYdEIwhpTvIq6npjdLDv/RST4jyYSvOVjcBy4cU4Idc
 C6sHyLRjZFYnf60nX4/4yIRhuCMtNjjYpqBNQYLyBoMi/DB9uTpdABfUEK+SLqdzW+gN
 WLwa8ISIMfj+xvRrT2MAcDyp4XRqNg/inxbxT1hvVBxXZ3aX8ysGlnkaf53dr7ixudSl
 BjyYx3AHeLIhI8X3YgJeQa+oJgYRd20xaCzegiJaiwD1lPJ9LsR9rXqwPjijSHj2qYmR
 4P4WYUStFcrKBfOsVnw5EO9tORVD8hoz+qDt9nvEyMZHSMLn25gkhDwO/xT8V8OnTrSj
 foXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929060; x=1762533860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ln5UxjhTXyihDKrskjElugo5dDcXTBv4zBXZrGocRsE=;
 b=JklzAJ3doxjOw7ceqgEv4ZJRHv8e9Pzvji9wiYUMb2JxxBHc+ODFEq1chn/UInv1aK
 Gj/HIPhsDomUYw5WvYEBFkLwkDSxcd5CN3jedHT7sxpVVGXLBwh/p8RgSWwed6InbK6k
 lYnlBHmJup4WL6XIpzTIZBPy9I7am+/FIOHciJ/rsatj36MQKcyzDzuku9jNdx8CuIjC
 Kp3GpMjRPZYqDjFIU201/SoRGunImoAcJ9LhlTTaEVPdMvSbmQtIlJqBUBPIvl0F/J6i
 SxeUurl0hzC+bI3uqSTS/kofKH6QwQYewTvzkpOF8pFEB9XRJqHZwBlO8Jd0uTwDEICr
 7Xsw==
X-Gm-Message-State: AOJu0Yyv8bou0CXNtRrFbgVU+rdA5PCpHy5OuwGbYEN8Y1STmFR0X7ri
 6O8pQO/tujhyJmtf+9DJTlyO+Xx07764XOBNQ4acQ7lAxPZL8jZPPbEBbXHKnl7M+p9fN+yN3sM
 MqOOz
X-Gm-Gg: ASbGncuhIhAmhy/Va5zto4ok7GOyo7fyphms1LTmLohEN+LDVycdnjV0egs5gy68RBx
 pclZ8S+gsOF45NbBI9r59E1Wjih8E7/OaiOMYDcqLa1x4/p0jBWNA3sn61MJFpb7Uzp0Pllv0ha
 gbzcMslIOwpQIZhpdc/HlpcliGiAjVu4cmO1xhKIsycvU54AqWuOBTQGHUqY3vp+Ey/S5yP4arD
 /OEkQD3oHFw1V6AMU/Bq8B4DvUM0shxQdDhG3Zh7Uo8pxN1wOsT5rtlrQCzNK7EMXc1V+Th3Bji
 kw6z+0k6yXJkT7mbhDp/rg9pDF5InrJaqQYUlBt/PYfLL9tZU8fYE6ailo9leUDKrm0p4+0bi1m
 fO18wB91pbVoXvftd6m5t2L8TvLKZKJdUu7iiIvBE/F+sydq1o42MY85/QdQ2DGVaop7nM9SnQ6
 sZrrnInw6Q6YAPirKiUoJ4WECBECa7YshJhZ1NZ+OZkKRhwo5O1w==
X-Google-Smtp-Source: AGHT+IHtZlXgHw5pOE5808YJOp8W6xiRLULOVI9spOr2xXoP61sVzLFOalb1RdS6kE6lTlLYMKeZRg==
X-Received: by 2002:a17:902:f545:b0:295:ed0:f7bf with SMTP id
 d9443c01a7336-2951a524d5dmr58852225ad.58.1761929059841; 
 Fri, 31 Oct 2025 09:44:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/5] BPF enhancements
Date: Fri, 31 Oct 2025 09:41:44 -0700
Message-ID: <20251031164417.14166-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
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

This is a series of fixes and tests for BPF functionality.
The new tests for Tx and Rx filtering require the infrastructure
to build a bpf program (clang) and the tool to convert object
file to header (xxd). If missing the test will get skipped.

v2 - add more checks in rx test
     fix headers 

Stephen Hemminger (5):
  bpf: add allocation annotations to functions
  bpf: use bulk free on filtered packets
  bpf: add a test for BPF ELF load
  bpf: add test for Rx and Tx filtering
  bpf: remove use of VLA

 app/test/bpf/meson.build       |  53 ++++
 app/test/bpf/test_bpf_filter.c |  53 ++++
 app/test/bpf/test_bpf_load.c   |  62 +++++
 app/test/meson.build           |   2 +
 app/test/test_bpf.c            | 452 +++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c              |  84 +++---
 lib/bpf/meson.build            |   2 -
 lib/bpf/rte_bpf.h              |  11 +-
 8 files changed, 678 insertions(+), 41 deletions(-)
 create mode 100644 app/test/bpf/meson.build
 create mode 100644 app/test/bpf/test_bpf_filter.c
 create mode 100644 app/test/bpf/test_bpf_load.c

-- 
2.51.0

