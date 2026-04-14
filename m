Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91B0F9D0D6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 15:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCCB402F0;
	Tue, 14 Apr 2026 17:56:03 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 7B2A0402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 17:56:02 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2d9916deb14so3336235eec.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776182161;
 x=1776786961; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AIQtZ3yaRXFfMMJYEmwo2rYcjB/SghWWBK2u8OX2mM=;
 b=AgHP0jpssQQD4ZCBdM0QfzmbCag0XkuJ3qiMPcWDpC5ngGDYtkocS0Mc3jA9Spd7GU
 Y/sKfVTtUrSTFReyOgVmPAI3wUWSVolFaK8NKIjLOvhUoX6pjfiBWn3fqLnPwqq1Mb5v
 oFzMLp4z4t/1ToLubqPM2Mc/bQ8gQirT31ZblFushkwQ0GvemWWnaq5nulLQTYs9w8lP
 kUkY9eH4yhfMC8Wt1LudpGFyRnw5sr4RdxrsioYaJzTRVSpKdFoU0apGJHOk+Q/xuwln
 +JmjYEeKOZvttJWg8kTaZ/ZXC36X5S4HZSZVEr6KyAXBJH1yG6Iih4ZZ3gSwxDfRrLWX
 Bbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776182161; x=1776786961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AIQtZ3yaRXFfMMJYEmwo2rYcjB/SghWWBK2u8OX2mM=;
 b=D/+O4o6DWAcfRopQnO/dYdUxafRC+ummRFVANHPJvRPOHw+1DF/cvF4WMe+thvp3vj
 XfJaQR2+CjEUyTtnG2Eq2s1NGkF3p+kJZYlVg69gVswLn6ufpBxZCN8X3uZxEColRZEM
 SsA8SeL78b9uLjjP8GVxrbEmWXJh96K66z2ta4xp4cYX06NDd8JIwhqC5a2qg44ILWa6
 /B1F9F6IaHq4ryR2z/0Y9D7AI/0uCTlzw2Dd3W3oz2IdnlSKGG9ct0Mr+ZBhYFoyjPi6
 MLP9jtbml8CuHyoQqZIFBGHLtbD+ffH6MhhlNbEZFwQRXCs1WZWgIMSzlOuw8mQRNnkt
 N/pw==
X-Gm-Message-State: AOJu0Yz41n7Q/9H2p2fV2P2gHsRT+nUA4W4PS/jNOt+RGzwxNgMnSt+g
 Jr7nmTe1uuFZ/OF5C6Z6/duNwge52oggc6UdtkCMJ6ZCbx2gwakv/r0Sdl7cWarACeFYNteHuu0
 TNxcA
X-Gm-Gg: AeBDieul2iAWe9r5/bXWE9gZj/Nu5kb17QE6YrgYZQyuIBvRCfW8wvib/qum0DqCcXJ
 dF0fkNdpU1mRcn6DTEs76Mldq9CxKe9vD1eqTYXWx2//QGj7WrmGxwydKwbxT04iQsc0uVwm6uw
 OtQG6ia1onOjQhkPds9yUD2G9K8xzWRhVstVDc/bMo2F5eAAP1C8W0NmGKt8t7lBAtrP81BIfV+
 IKlbTw5X5KQa0QuRHUtT4mMObkszX9UoAGuDKoa2sghAM0W0Afgp/8dYiMGweUtjP1LITN0u4KF
 0xSbLx2OafSGQulDZXj+MmR8kG/fUUYCshJzy9dVV/erXLuhQmGMaOfSOcJuj9WGnV9ypanq+U1
 mQD4zI5B6/VRsfp8EFMDSCvRR1ygsSVm1S4dJ1siiMD8vbYzq9noMkEplcjPdmwh8Dh21U1Mr2G
 JuhEfUxSikJoEVIghYZLG9r4O26+/KOBAxQA7Fp9jIO6hFGT1j4XRtDA==
X-Received: by 2002:a05:7300:6409:b0:2d4:aa5a:391c with SMTP id
 5a478bee46e88-2d5882a7a36mr12436935eec.12.1776182161084; 
 Tue, 14 Apr 2026 08:56:01 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d944769298sm9237476eec.5.2026.04.14.08.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 08:56:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] af_packet: cleanup and test
Date: Tue, 14 Apr 2026 08:52:57 -0700
Message-ID: <20260414155537.718635-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413230018.515837-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
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

A couple of small patches for the af_packet PMD.
Fix indentation and add a basic test.

v2 - fix test to always check write() return value

Stephen Hemminger (2):
  net/af_packet: whitespace cleanup
  test: add test for af_packet

 app/test/meson.build                      |    1 +
 app/test/test_pmd_af_packet.c             | 1166 +++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
 3 files changed, 1199 insertions(+), 32 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.53.0

