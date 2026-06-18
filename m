Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBDFCD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 17:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46CA5402B6;
	Thu, 18 Jun 2026 19:25:51 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id A50104028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:25:49 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-137dd4cc208so1026120c88.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781803548;
 x=1782408348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JA6fsStPR1plVLEuowfh5irmLI83+NDhqe++akzhSZI=;
 b=G5HfdnfIEU0IOtGobiUDevsThmEufkB1k/WP+TaWUE0rqX3dAfAVDyR1VdhrequZAN
 l5/hFCXCD/p8xq8PlAHNaduKuJGQkPS7dxevhQSHkmn58Q4zNWpkdFN28kvgn+dCUFoN
 2s/O54dYwKynBIzx6T33w+FFOybQ+Pn77okyvVp578fTUeJiyQ8aWyvr3B3xn5iDsJVI
 kSb8QaWSB8yp+qXfrw7dlqXY9RDJXzVXVkYaei2gdfSu2B4km4HlOFrXz5YhEK3vhEeX
 4WBhmK5ULgqzjB2HFbavup9z1+w9AvJFNrGQQc7/iulzbtZIzV8Nc4a6udn1ivCuNJPO
 OeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781803548; x=1782408348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JA6fsStPR1plVLEuowfh5irmLI83+NDhqe++akzhSZI=;
 b=gpueH/O9+9/bXQ/5fSbwlf3XRVBPEept6Q1/0Ugdw3YLdoiLqcwwM0TZHcZWrf8hVD
 2//tVPefPU0bEuJuvDHuhzLyK6FmOi9NYtrOxEQNaaf5TrIlJ/y7ZVCuXm3TYQN8K+sI
 9eoD3rF/PcdLfUkylQ7+CXX7FIdFMCEPQssngaT2be7Xb29b8DrsvZb3uqz9meeNeM22
 FwJ5gPajHzkSM4etCZBHe7gRWCm7PAPnT5cCO6O3p7opZhdMBsJsDw6+HhRmsOAHWrRV
 Nu0961bw+k9ZsXdaLwDrflf+/3tf7jyxoXInzbYw7qatzb+KfhNc5c/kmO2sID/4tbBo
 5/og==
X-Gm-Message-State: AOJu0Yy5OdF8ga79rY5jXSmWr/qo1+oWS94HWInn2HafqIJox8qn/uh9
 DafLJwd9txPtcD+jhDPgs61npFBMNWrC88PYHiGrq1SAMUVmvxmFNSLnaB2nOPWAJUuZEYJwlKz
 wp4IY
X-Gm-Gg: AfdE7cnhq4GYy7gAGYtT2u4Lh7vi4YVJ/NHlbUL0AgF4J7sDrciYMDMG1HRJiTBPGJh
 lrWy9ETxNmPZEE1jmEO6rvV5PSieVbVJ8RoVBLX6cM2kvHsmUpaBWRNXXgZiF1EEvZk9mImjsKG
 eD+cEQs3Lrt8FVbCZT6gWv1YMt1v/9Uo66AcgeE3GAQWfoNsn3cyaTF/uhw7rFEnTMPbTJp7n9V
 qBbCJh5v6fyhzGA54kc2DqJjcfdlmAO8S1Ji8sPZ/jbx/GkxGzyPs2duukxrGnlg9IexONlDos7
 OjJsGAqc4ppYEqZRrpXrtxMpJ0+G5fV35ZtY9pm93zJ+Cu5NlVQJ6PJnHAC1wx1mhJMvgocfWpz
 mHKSn62alsBVxurwVqgPVpLzlD0WV3Ybab+joQ7IE7zeTvBp1Y39lh7rAbY/aAMlG8AGCOw4E0j
 wJLer35awJ39Cn2C92pCVaFFbs24OkYel+0jgS1zVU+X9ZAG2j/fo=
X-Received: by 2002:a05:7022:2201:b0:137:24c9:fb7a with SMTP id
 a92af1059eb24-13997192d0dmr3573720c88.2.1781803548440; 
 Thu, 18 Jun 2026 10:25:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670a1b4sm122443eec.8.2026.06.18.10.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:25:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] net/axgbe: fix resource leaks and OOB access
Date: Thu, 18 Jun 2026 10:21:55 -0700
Message-ID: <20260618172544.338758-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

A code review of the axgbe PMD turned up several correctness bugs,
most of them in resource management on the device initialization
error paths, plus an out-of-bounds descriptor ring access.

v3:
  - Patch 1: consolidate the error-path cleanup 
  - Patch 2: split Rx buffer setup into two passes

Stephen Hemminger (4):
  net/axgbe: fix resource leaks in device init error paths
  net/axgbe: fix Rx queue leak on descriptor init failure
  net/axgbe: destroy mutexes on device close
  net/axgbe: fix descriptor status out-of-bounds access

 drivers/net/axgbe/axgbe_dev.c    | 43 ++++++++++++++++++--------------
 drivers/net/axgbe/axgbe_ethdev.c | 40 +++++++++++++++++++++--------
 drivers/net/axgbe/axgbe_rxtx.c   |  8 +++---
 3 files changed, 58 insertions(+), 33 deletions(-)

-- 
2.53.0

