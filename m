Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ADDCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:15:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C68E34029E;
	Thu, 28 Aug 2025 01:15:34 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 5843140298
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:33 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3c854b6459fso257823f8f.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336533;
 x=1756941333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bi/bGBrBntI+pB3dMmIUGFUpe/aSLg8SeKTuy1sSYfA=;
 b=uaqY/rdkycwaKSZqgqiVjDMhjatX9LUDaxeYQkhQO5eekohnoNoBl5NAN4gpljOHiY
 051Ggmuhl2UXqgP5i7oRTBMTHZ0usVRMQlxDnHrw4fzNmb42YyhPf0y7pdyZC9dNDWV0
 zt7pwkazaFCzYgx69L0U5wf6jB6CqiD3ugmLAAFgiHi1KT3gkCMIJ7SOJAtIqW9/nWCG
 x/yzgrcHQMt3bu9YYaWY/5nO/KGamEYrNA9mvrV+PqcFY9uLkbRR8qtHF6N3gD1DSYNN
 aUbyxeIXoonQN1riX+Jvdp6gfvfuATsmSvC7Gy7uZgkCKKP1OJjaP/lbKfUgfCa6NdU3
 FIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336533; x=1756941333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bi/bGBrBntI+pB3dMmIUGFUpe/aSLg8SeKTuy1sSYfA=;
 b=hE4rMziAKyZGaONMo5dYHLJ5AlDrPY1oIOzBUSTllkvsXtxPyNnErC/NufruX8WCvC
 3Nt67f/a1NBeWOXySI8LEiHVta2QSrHbX3Fs9Jrm109VsXw7mgNdiVw+eHtnC7pmSezP
 f2uAxYoCRI6npgPCj279rRD0frtDhzHR3TyCDmwTGAeAI2gsrIZZgctEaznyor00Uc+5
 hrGVPvHqPuV6Ro960YCRdqLSuTUfzaM0/BIfvuyggqybrBl2Z58DTzZSrYFAgn6kz2EI
 iegxkdFgNv/yJvjyZ7cto4YJc1aIBorvvnpJETB+hiiCAuZHJ6TdX9YAnxiYyQSSDizM
 RVHw==
X-Gm-Message-State: AOJu0YxXTUJth9ssJcBHbs810iv66joqK1mlhCHGmEcinFsejSsw2TFW
 AUQRfCdqY3Vyf4SD1203C16Fm6AuER9t7LjxahO4tc8k/Zqoia+K4CSKBYCvFBCcm4C9Uk2YdVJ
 3nYRe
X-Gm-Gg: ASbGncsAHWeNZrE48HXwoiq5vxV0GGFBKErEWM791499/yTwEaTUdy3DngMA/i7AOBL
 DgZ19EblkN7mcnVYAelbRFa0MAZGvWL6NXjg8bt93m6ox50p9y4cZjvqp9+v6q2jJd70Y2vZLxH
 ENh6M498Z6MplaM7duytZdBmekLygVhhOwVdP/pQ/fZK/s8HFRoMsbv858r9FldEaIgeh3mgH8Z
 HcGb4BBQIu49W+BxyJ1DowlC5EwWw4VzDRI5bJudvy6uxNtGW3G+TQNviqiNofGZP6Y43Eyj/d2
 Gs59gBL4T8b94j89EvAVcZKf+/3tvNIy+lNMDAECVpzSsiXEts1D8FL2xRZaJaIQrD3V/AVcKW/
 hfYdd+HGT2L5frIHTWLisc+Q70ouN7DnwGQnZgViH5Sdu+ZYvY7UGQXrYqhMovZNKaPngxsAq
X-Google-Smtp-Source: AGHT+IEMpQEM0D5n3t4DdSLyxVCBvnVzjdsmCct926P0AJqBjeLRLY0qjD+dkH+Xpm02PfRrdDRLeA==
X-Received: by 2002:a05:6000:1446:b0:3c7:f0fb:82e with SMTP id
 ffacd0b85a97d-3c7f0fb0b0cmr11904661f8f.56.1756336532750; 
 Wed, 27 Aug 2025 16:15:32 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/8] Avoid overlapping declarations
Date: Wed, 27 Aug 2025 16:14:03 -0700
Message-ID: <20250827231528.236172-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This is first part of changes to fix places where a variable
declaration overlaps another. These get shown if -Wshadow
is enabled.  Lots of drivers and eventdev still have
this problem.

Stephen Hemminger (8):
  test/ring: avoid shadow variable usage
  test/table: replace conflicting variable name
  eal: add macro to disable shadow warnings
  eal: avoid shadowed variable aligned_end
  eal: avoid shadowed variables in trace code
  ethdev: avoid shadowed variable warnings
  telemetry: avoid potential name conflict for handler
  pcapng: avoid shadow declaration warning

 app/test/test_ring.c              | 190 +++++++++++++++---------------
 app/test/test_table.c             |   2 +-
 app/test/test_table.h             |   2 +-
 app/test/test_table_acl.c         |  28 ++---
 app/test/test_table_pipeline.c    |  22 ++--
 lib/eal/common/eal_common_trace.c |  42 +++----
 lib/eal/common/malloc_heap.c      |   6 +-
 lib/eal/include/rte_common.h      |  17 +++
 lib/ethdev/ethdev_driver.c        |   2 +-
 lib/ethdev/ethdev_driver.h        |   6 +-
 lib/ethdev/rte_ethdev.c           |   1 -
 lib/pcapng/rte_pcapng.c           |   9 +-
 lib/telemetry/rte_telemetry.h     |   2 +-
 lib/telemetry/telemetry.c         |   2 +-
 14 files changed, 173 insertions(+), 158 deletions(-)

-- 
2.47.2

