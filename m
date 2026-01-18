Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789DDD4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 16:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D0BF402CC;
	Sun, 18 Jan 2026 17:51:46 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id D31014026D
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:51:44 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64b8123c333so5558881a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755104;
 x=1769359904; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTHKlx8bi83USTW7qOona5g1PbuxbSn8du0EAeRkkhs=;
 b=0KbZF/PEWd8UBzwTpCtkfkS80Mo3RXqvB+3ZAXQ1vEZ94pUsZ0EgawmAti27eZAu7P
 FLPhWuibVxiVh9eCbmJFvpmWmzOD5rpjvlac0dH9uLQ9LIhKvPlh4Qbabu4l7OHZzTW+
 tZh2GlIA7X1L1MR6hlXEWMclWOYYN4M3dT4SgTadZgT8PJ61Lb67OVJsNUjNb8o2aNU+
 sVe7Aw6YDU+FEr/U972+sq9IFtBExWZSAZz/PoT1jqFFMzfmqqm0sy/sxSVkhlV0iziI
 pnbCM1pmIDHaBl8Tm07Pv111f+AFByd38y8CVuHqA7c9Kn/nrNDp+eKr/PjKdP/YSNG7
 NrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755104; x=1769359904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sTHKlx8bi83USTW7qOona5g1PbuxbSn8du0EAeRkkhs=;
 b=THKaWl5qdNCAFPqrJm6VAznymtpDoevOMj6FK7YsYeVY4h3ZrqvqZWwnEygTvUHMdW
 88yxK5Wgw/tAvXeQ8NRBSfHbcvpB8klvVOowzik0ErGsjruO0MfOq25UV96NoSVjSSG5
 QwhtGWPnFhvpDvoh3gFm/ppggNBmlIwg9U+n7WQovdp/stOayv62Dx9V5m2VtArm5Qxx
 4h7EJ9xzNrWOBjls3FpLvThSK41hsfnccJuGPEWgjtBcQ25FDnTVMYN2yVEP3hqpEc65
 sxDrmLGa3Znib1D62m2mkIkiTtQMUGyETOwzKBrUkIw9HAMmb+AkiIt1LxQAKkl0aQJ6
 7/ZQ==
X-Gm-Message-State: AOJu0YzYBOpyN24ejfsiJ9x3cjEGupP+f5kVxYap5K1i8OLotwM+Kvwp
 +iNIaIHVl3zV88U1Ah1WpVti3oqW6upe/uVcveY2BgTRq9qf6n6chelLOvDtzAKURfgbjX0HyXy
 cBRNH
X-Gm-Gg: AY/fxX47oNrIMLJlmihEfWVtkYYpkDPFwIDjzpmrvAEsuK8r+MAdNyjTSLMAWnugtX8
 quK/TxPsViI03NQk7wXxIpF0CJ4rFetJ074EzRhknQ9hMA/uTbFJs8JQdaEWt5COt0FhsVI46Wb
 9W/Gv5F0Ls4FjmvxzUjCBcUloMRB8xV+/ECUjTi4wpMAKjoNe0RKDKM4/k4rY2oho723KoGtdoh
 6oAkvCE0vfw3dddzPGHL9oLUFqj4aO/F9CtFzSrxl4JMLJhFEFhhUxwf3S6A5pbnTHpRGkBgqDD
 LhbzvEyYNMMDOqexU0m9Vk7zD5fuPjbqtmksQSDuzlXY/9u+to5KtEcKMoQvj7TKyMaNPZpuPXd
 sL07ZVL1uCX1nucrq3L6CzqLiKwMO605UoJ6gmBJDyG/TL4rh6E63W9JlOKVuU79DkHH4lpKFIs
 ZbYHbal7yoowbBGwzRw3nCMwedkz/Dp+pOY3TrBfHyjiWVmOcpkQ==
X-Received: by 2002:a17:907:a48:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b8796b9d83bmr736780566b.55.1768755104020; 
 Sun, 18 Jan 2026 08:51:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0b8sm8045946a12.12.2026.01.18.08.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:51:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/3] test: add null PMD test suite
Date: Sun, 18 Jan 2026 08:50:42 -0800
Message-ID: <20260118165138.37730-1-stephen@networkplumber.org>
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

v6 - rebase for recent REGISTER_TEST() change

Stephen Hemminger (3):
  net/null: cleanup info response
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

