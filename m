Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D74D39005
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 18:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11F440658;
	Wed, 14 Jan 2026 19:32:15 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 572F24027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 19:32:14 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so978005e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768415534;
 x=1769020334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GQOtcnON6x3dN26AESuV9mJ+HNasU85o0gitQ2cVOc=;
 b=aQ5dv3B2rGCjROh3RiltepwwoZp1+U0l6kbPa0i3sIOsvAHN2CnS0EdcGTW4yQ1MLJ
 +my8bsx+Ch0RcuSGel6FJOtz14M4xeb2cvdjQ/r9t54QMTUYo/XZqoktSTXbc60iLwF2
 OgNN2uftXogmHyPHFeOEyiSaDbua2KNqZxEJDaVT2NlTh2C8xlYMFwI5pKQDrlMLOhRO
 u1eBYn3OglAgaE0C4WTsaGdM4fMzF992KuYoogfD5IB6ktLpzSYx4Pk4qxGwZatGX8kZ
 UolYUcblftrMg5tv8VtzssiCN2sN9CoNPaVWtSBLsTx6NVf7A9NvSjkXyy0k/LzyPmDP
 /z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768415534; x=1769020334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2GQOtcnON6x3dN26AESuV9mJ+HNasU85o0gitQ2cVOc=;
 b=shHb04Y44JD+jPWxVtbBEiVrECq2iyju4f7UPlKukGsWTIH/QNloDhramDnv/4rf3H
 5zcdSTh86B7qT+kytsl3glPPhnz+DquYvMSCmvfvg57A67XbObpdRfrDMJ73spmpGizE
 RtmQY/yVzUSf8vdFAhv7HqyLTDfwv+Bwn6hXQu5EfZijl2Ks7srj1S4ufmh79y1ML1AW
 FUQtPxUFffHfPwSS5mAAnV1/iRyoS8xSmq+T1vzrTfQJ6xxiOU2O7c7NCYsOcA2hMLjV
 uqKuKo0M2vIId5i2U5Z0XZsZAxA9Tr828HQ5hWI7mpVC5RbKbrVGd1eruP4TyZCM/Zrp
 g39g==
X-Gm-Message-State: AOJu0Yy1QhUU1j6we5xQWscs3BDvEAxiWhQi17T1qN0bLI7aRdsC7DRw
 GbvVvFAjJb8gBZmBFkSg/ZkCASbrbd7/e3+zl7tdZfQ0Zr2CGgUovR0Twy7haX1h/aRlVmpUJEf
 rOkrl
X-Gm-Gg: AY/fxX6075lFr5FUtDGG2GWalLIwNzaOCOIdQXYH9F7JxgCD6H2vkpd34c3CiplDcJf
 TDsH2egY7XmTZAetg+rsppxkUMfLwxtYEBNTIashvrozDNCS9Qal391Fi7jxdWbQY79cF0Jbf5o
 Wnvl0hueOsTHqMPBIxx1HBZ1gdtjVh3bC+jB9Svo3rUV3+hoHhkz9ADHHm5hsWy6oJo1KTLKPkx
 6Q7MDn8ntjsNVNt4lxwZIK4gciJ5bz0oH/30glybpR6REaFmbQuovjQwFkI6jveYiECmFEYIdy0
 AqbF1KCeyuaB3giIhD5Xv7Du9UGVPUfb6gk0l/BzWlzRYKX3KymSnv+8bjLkO7qzl6OCanW1ae9
 XupknKIczQPKERE1noFy6Shs70YTomCSIdD6/GzbRNGGiiK39/43kI0KGHU9cm/hyO5XpMwbPuq
 fI7MGFo8iIoQrbbm6hoZ+uwEM0mW9l0gQeeA2KCCclPwCio1kGYg==
X-Received: by 2002:a05:600c:6992:b0:479:3a86:dc1a with SMTP id
 5b1f17b1804b1-47ee33aa21amr40987655e9.36.1768415533662; 
 Wed, 14 Jan 2026 10:32:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm4421205e9.9.2026.01.14.10.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 10:32:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/3] test: add null PMD test suite
Date: Wed, 14 Jan 2026 10:30:43 -0800
Message-ID: <20260114183208.14256-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series adds a comprehensive test suite for the null PMD driver.

The first patch does a minor cleanup of the null PMD info_get callback,
removing unnecessary argument validation that is already performed by
the ethdev layer.

The second patch extends the packet burst generator to support larger
packet sizes by changing the pkt_len parameter from uint8_t to uint16_t.
This also fixes an incorrect comment about the maximum number of
segments per packet.

The third patch adds a new test suite for the null PMD covering:
  - Basic RX/TX operations
  - Statistics tracking and reset
  - Custom packet sizes
  - Copy mode and no-rx mode
  - Link status
  - Device info validation
  - RSS and RETA configuration
  - MAC address operations
  - Promiscuous and allmulticast modes
  - Multi-threaded TX (MT_LOCKFREE capability)

v5 - fix issues found from AI code review

Stephen Hemminger (3):
  net/null: cleanup info_get
  test: generate larger packet bursts
  test: add a test for null PMD

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  34 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 964 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   |   9 +-
 5 files changed, 989 insertions(+), 23 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

