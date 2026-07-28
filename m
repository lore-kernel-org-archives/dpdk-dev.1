Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DCDC54F4C
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0526E40269;
	Tue, 28 Jul 2026 16:12:35 +0200 (CEST)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48]) by mails.dpdk.org (Postfix) with ESMTP id 4EB2B4014F
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:12:34 +0200 (CEST)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-664db84f074so5109287d50.0
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785247953;
 x=1785852753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r5/GLwilpvYiD/ZkEdxsBYib5om7RiLPwZgDNREhKvM=;
 b=LgiFGcqxZCxXeh4WwcKWDO/fiIU+xLluVDTluM4aQM1XC7H+IKHssKvX+KHmQtLC7d
 QlNSjPedhjjvPK+RgBB+0tAq3xS3A6/wAJ/dbDvTY39z1Xa6PaESpIyFj+5YioVK89wv
 QO9iSHmAaUZzrxIZ0uo/EmgViOBul9owRtdbt/mVfoKOdkN67LGutWTamgd685B45dDX
 s6YdJW4MGudUZY33iQYv8g+RK9j9vDbT7v9+TSSmGg/x/BIywLJ/qXosq+0Sb2odddtL
 ihwqV6cjFIz40sceRP4pWiBgxGb3Q/bLIRzBpM1GI92RSOAZeOCTCLTKxbvnsrsy8bP6
 x5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247953; x=1785852753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5/GLwilpvYiD/ZkEdxsBYib5om7RiLPwZgDNREhKvM=;
 b=bSUr0giGvshb7CupfhBNqDE13Ohbgjhv0ikmBq30Igtxws3gn2KeC53ZhIrhKm2/fR
 /W5CzPq/Jhep998XCf+E1+t2e6edWG2G/zU2kPJCX4eNCLyyy6zA8FXqfbcfQIyrHREP
 Xs/n/7pSVD+nGxC0vPFURYejvXzhd8Qk/wovqyU4vh2cWFwZsA7jl0s85vVFw41qnykd
 KCctY+jcmA7pDztdC7SJbYwwPGjMb5zIH4tBfO1704PxQRrK4WICJCR4vAS+sqX5ZvN8
 QSOBItf8D2uMsGCHcaRaYc4C9ntuYSJRCeRdsiAJOD50LRMGEyHqUTNCqkmEJg8GxZWH
 We5w==
X-Gm-Message-State: AOJu0YzlK7pc41JmF6ISiRWnG2x5d/+3BJC6Xgu41F74G0CHBMH7oCM2
 CIZZCdcycZ6CTHKqu5cAUWS/Id4QIUJLjWEEU09vgqbcMsB1tee2SUSqHU8+yzwowI01xwGnOmn
 Juq7p
X-Gm-Gg: AR+sD10+ECwsMyjQ4OtMovxXqUSM4SUkDo51vRwPanFhIz+XyAdMxTo7gAzI5u65Luh
 kjNrl8acYjExU1mne+HsrygXJi+lO8QPhnu4db2/xKPXJ9+QWWyjLsRX2a8Vz/OZ8pObpgRl3K/
 nykBA5JiPg7O4F82xyJL7QWAQtpk1rCdWqSBN/n5Xu9YCja2Msv/PDbotZH1QHck4NMFCYfG0Db
 vUqSgkzFdteXHY28Z4M8tjfDoR6xsBKvfflpjeRmdgzqi7d09y1y46vQY/HePIEEmHPknaxdQyI
 p8YbdiRDD0sxq6C9PtblDvLcesmap3LqJ473Z7o1RYStHCtJk7YDUhzYawwEkvgCJo5nmJ369tq
 70H4XKdoGrj6dzN7linOYNtqBM/pC1p1T/vm/E2/WKAPxfb5Lxsd45qYMjVl2Q7/3m0zYgkef1s
 JxPlbx+dhouO6Sv/jYch7MA3cECXQYTGtCnB92IK/5
X-Received: by 2002:a05:690e:812:10b0:664:ae6b:b495 with SMTP id
 956f58d0204a3-66905807264mr635338d50.74.1785247953268; 
 Tue, 28 Jul 2026 07:12:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6f6aea3sm5065610d50.12.2026.07.28.07.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:12:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/3] unnecessary null checks
Date: Tue, 28 Jul 2026 07:11:42 -0700
Message-ID: <20260728141229.93878-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Several drivers have unnecessary checks found by Coccinelle script 

Stephen Hemminger (3):
  net/sxe2: remove unnecessary checks
  net/gve: remove unnecessary check for NULL
  ml/cnxk: remove unnecessary NULL check

 drivers/ml/cnxk/tvmrt_ml_model.c    | 6 ++----
 drivers/net/gve/gve_rx.c            | 3 ++-
 drivers/net/sxe2/sxe2_cmd_chnl.c    | 6 ++----
 drivers/net/sxe2/sxe2_ethdev.c      | 3 +--
 drivers/net/sxe2/sxe2_ethdev_repr.c | 3 +--
 drivers/net/sxe2/sxe2_mp.c          | 3 +--
 drivers/net/sxe2/sxe2_rss.c         | 3 +--
 drivers/net/sxe2/sxe2_txrx_poll.c   | 3 +--
 8 files changed, 11 insertions(+), 19 deletions(-)

-- 
2.53.0

