Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1948CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 14:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CE54402E6;
	Tue,  2 Sep 2025 16:28:05 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 91B0E402B5
 for <dev@dpdk.org>; Tue,  2 Sep 2025 16:28:04 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-70df91bdc53so45335446d6.3
 for <dev@dpdk.org>; Tue, 02 Sep 2025 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756823284; x=1757428084; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H80nrb7sAjyOAslFJsslTfyQ6tPlmolDoshdYEKUmdA=;
 b=cQ6aEad3JlbgGqpYsgBHpwUg4RdUr92QIkO8R6lhvternhWcGBmlgzdY8fVpklqCbS
 FTNeYFqcdR2dquFioq2tpeXTuw3UGRtPyMlB4OhcEO37bovZ9JGIrytgTyQBGHuDZwVU
 euRuYzECc+vIuimQBhEvGb7wFOm8vzIXHQmS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823284; x=1757428084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H80nrb7sAjyOAslFJsslTfyQ6tPlmolDoshdYEKUmdA=;
 b=nQHcuvx/RTaCBVAbNPcJ7QvnPG+qZ5/3s6W80aWuIb+mQCYKqzkwg+YjKfY8c+6eEs
 pqmBgAFjtR8oEdQSmHR4ndRkRF86bXhFU8DQWCKqrGzfxDP13YFTFIJ7zkJ3OAev58px
 JUVJGlWfSYtJv7XCjXbkGeFxVq40PD2Fy114vhOcXFknfAuzGyNP3Lbtx2QY0VQPjN3L
 2PqpH8eL+bpVxvssODOE+QMR9YW5ocw0nA2BoYp2MY6asfhgD1cgg+xqhUbP4xAhzEMd
 X8Fwjhij4I+mJC+W0arkRUxl/2B+pOgWre1osjTEtDS0bgNmqukaucRGm9Xqt9UU+qFv
 2RJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCdhFBGtp+b2vpuC8o+Jl5PcpJDJgbc5O+8AdkoGt/qq7KLe26yrAjTjf7MogMwQWWF8Y=@dpdk.org
X-Gm-Message-State: AOJu0YxHR65Pc/eR7aT1k01FPZZ00q0IzlSLeg6zIz9OpMoox+Vgmry9
 t5W3ppHD/zzyWPjt+Xs5ErwVqLvYSdq1xJSE3l0KqoEuY5dmxvhZaoWJlICZ5XmoGbA=
X-Gm-Gg: ASbGncvQWb1ER8i0j4+9KCUVAXLdfMynIcw1b6nmEhQd+2UKcmGwx1vtcBYHXpWZ4XM
 MLIE5LlAXRw+FWGtY5Fh5hd+jx5MmgbifgWAaSaY1xSO8PuJCrXcD/G6DVcqbn3SOJhQoFT/FIj
 WhnsVHhwUaXJ6QLdwlwULNRs9kmO9e5ScBlel+hSRTuD8vZqeykOqte4ZQO5K95ytbiJchLoWwD
 PUBiVea7JarsHgLDqF/oofuwN8p3wDFotPahP6wGJ9UKVN9j9hgaO9OCMP0o8oPA9iajgX+Rvk6
 QG3PhPT8rZJhpLE7ivqKt8st/7+0VjIDYmjuSl3RcOy8Zby9K2Gww0ROwrQn5eZdaHphIKkZAdN
 r6Sde02mPKsdr23x/KcKilp81xIFBqg4aDAdLTVKLrFC7NQ==
X-Google-Smtp-Source: AGHT+IEpNpH88gXZGZlE5AiRiXxhD+PpBDND/9PQXJ8BkPm/CuamMCLXmyI/Fp7RFjCP6E02+4/rZQ==
X-Received: by 2002:ad4:5dea:0:b0:707:5063:4cd3 with SMTP id
 6a1803df08f44-70fac6ff110mr119561086d6.11.1756823283444; 
 Tue, 02 Sep 2025 07:28:03 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b57c2893sm12346186d6.53.2025.09.02.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 07:28:02 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v1 0/3] dts: add tx_offload support in dts
Date: Tue,  2 Sep 2025 10:27:22 -0400
Message-ID: <20250902142725.56736-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

This patchset introduces the support for TX offload configuration
through DTS, allowing test cases to be written utilizing TX offload
capabilities. Along with configuring these capabilities, they are also
added to the NIC capabilities class, in which they can be required by
test suites. Finally, a test suite was created using the aforementioned
changes to update the RX TX offload test suite in legacy DTS.

Andrew Bailey (3):
  dts: allow mbuf_fast_free to be set with testpmd shell
  dts: add TX offload capabilities to NIC capabilities
  dts: update tx_offload test from old dts

 dts/framework/remote_session/testpmd_shell.py | 340 +++++++++++++++++-
 dts/tests/TestSuite_rxtx_offload.py           | 153 ++++++++
 2 files changed, 492 insertions(+), 1 deletion(-)
 create mode 100644 dts/tests/TestSuite_rxtx_offload.py

--
2.50.1

