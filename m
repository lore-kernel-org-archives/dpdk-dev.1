Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F0CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A884065C;
	Wed, 24 Sep 2025 18:55:32 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4CD49402D8
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:31 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-826311c1774so11894485a.2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732930;
 x=1759337730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=20fvuxfi4T6tAuajxwsjjJ7lcwFG541OPr6sFWT3V8Q=;
 b=mkbnS+0FYqKjUF7IcljBX12KopA9tFzSuqddUM9qPUS7gzTh9sgmKnEmaTqkvSWXUw
 +pBao47PLip2Kd/QPHIdJRaO+47g0zKJpWRdtr3M2HdxWM3BqM+yABSSKVLfiaKlcQGz
 17QZgqqYf0ZH34w+CUW05XtEgA5csNfoHnfXCE2o7G5EnxQ0i1BeiPUVemXVaxA72wxK
 R+agaFQooyatqfdwvhjmeOsll1uoyZ3HyfUij6xnhi8n5uPfMVX4rB7C2cd4xpxEDMy2
 vtBSib8wMNI6dGQaf1B/8utBXSyrPaHYjurXx5QEytDZyY0SA6makWkb0Sfs8KnIsPAL
 2Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732930; x=1759337730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20fvuxfi4T6tAuajxwsjjJ7lcwFG541OPr6sFWT3V8Q=;
 b=qzTqnEluhi1GCjvuUi/cojLuOxGJDJh/TqFhWp7cYqDDFc3T6g+BvyP3I7KmTIrjHo
 F4XssLePjpC576kqjE4zy2MZ9as2pItbR3Lpyid/CemPjeFNx5CN+a+QmW6h7xWhRbI1
 eo1Lu7TixwZiqQ040g8JrW9V3XxsDOdfcM7rMKui4Kw7t79vbmdvhQCir99QSsP/Si+X
 QHcxhG3wygK8aTflHRHBxqh87MHxHbOkmjVpdh2bi0qOnj+m6sNpifTkEIeZGojpCn/5
 Rpoy+cvjVvvg2g1YCh7CNk3Lvkm2jUOvp5oDjFreukjQ89cnhhHVpWLfwnfRjapz3Yjv
 0PVQ==
X-Gm-Message-State: AOJu0Yy37dfKW5Lj8G8uPpszkxtbxuipPsyxI2mpQBmXmGUAHF8pBL1v
 d0WXZ78tx0LPGvo+XcqTm2flc5ZI/ZebNb/P4WR77r2ujGaEP5QtegH6NkOB9BMaqZeu4ARNOJP
 x322Z
X-Gm-Gg: ASbGncuCCrb91Wq4jleNgjsKAc/CZbHWR2jfNjcehwayZGyu48z6avfTJnEOXtU9MvK
 D7eRJ1KcM212Q4fqMSUdANTSl48HInQ7hTjiGUFDAtJWAwl1/vZ+FF6Dpqa8ykvuvEbrZBHPlpZ
 zV9RICQp3VzO2Jb1aVP7YB4E/kiKXjX5meBKuFcIFVE4hnQhSzbMcYJhSv6y7a3wO2YBdbZ54E2
 43RNgy6Lt7ZcXgkkXpR8FHiWJhtofyyC5V6Bgp8Gl+lO8A9sFlGGFkZrPA9SHVJHIfNocKW6geM
 XRsxt1SakRXooEeJXS7TvaaezaVVTy1trB2PKMMWMWqVTm0pnu90ut9auv2RaiBqAqv5M6QYSta
 KmStOCUPr5OHtayxWj9AESrDFkosSjSMIbhKJxpsLPm2jl20K/p6bgWsSdDMiz8cgMbAWJQBnau
 tbDxHi77Y=
X-Google-Smtp-Source: AGHT+IGfw4juKQeTXalxJ4ZlWmASPxrW0x2Rehiy4rkhXzxoSvqltmxb0zk5wbd6/HYCJfc7Z666fQ==
X-Received: by 2002:a05:620a:1790:b0:826:776f:3493 with SMTP id
 af79cd13be357-85adf5d26aamr52278085a.16.1758732930537; 
 Wed, 24 Sep 2025 09:55:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/6] get rid of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:07 -0700
Message-ID: <20250924165527.268645-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

The use of pthread_cancel in DPDK is problematic since cancel is implemented
as signal in Linux and TerminateThread in Windows. Using pthread_cancel
also exposes the internals of rte_thread_t to drivers which limits potential
ABI changes.

This patchset shows how the same effect can be had in most places by using
either existing flag variables or the semantics of sockets/pipes used to
communicate with the thread.

This RFC because it doesn't cover all uses of pthread_cancel, in the final
version pthread_cancel will be gone and flagged as error in checkpatch;
and the patches hit multiple drivers which require special hardware.

Stephen Hemminger (6):
  eal: avoid using pthread_cancel
  eventdev: avoid use of pthread_cancel
  raw/ifpga: avoid use of pthread_cancel
  dma/skeleton: avoid use of pthread_cancel
  intel/ipn3ke: avoid use of pthread_cancel
  intel/iavf: remove use of pthread_cancel

 drivers/dma/skeleton/skeleton_dmadev.c        |  5 +---
 drivers/net/intel/iavf/iavf_vchnl.c           |  8 +++----
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  8 ++-----
 drivers/raw/ifpga/ifpga_rawdev.c              |  8 +------
 lib/eal/common/eal_common_proc.c              | 24 +++++--------------
 lib/eventdev/rte_event_eth_rx_adapter.c       | 21 ++++++++--------
 6 files changed, 25 insertions(+), 49 deletions(-)

-- 
2.47.3

