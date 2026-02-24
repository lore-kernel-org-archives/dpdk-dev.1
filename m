Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2BEF3C991
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ACDD40288;
	Tue, 24 Feb 2026 16:27:31 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 7E417400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:30 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1271257ae53so5362368c88.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771946849;
 x=1772551649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFqgIIKK3OpWg78mPEJKWYRb2WR7Qhy40kIE8/pSXo4=;
 b=NhYwetFqn06tFaOZ2UXOSGzjRh2EhJfO7Ho4EuxagYvtxxo0CzIAVBT76BJSqD+jnA
 kJX2ERuhqEYffdPY2lwkbcb9E1SDR0rw9a3zRteWdkr2CpvVTCIfjT3iJEbLapANYwMB
 ddXbM9m5LZYOt77I0LyUOq24HPmU/l7nx7MXGxSQMYZLcT/QH5xDxiTK7gJxQXq/eiQb
 EP4p9jhTH16/4n6PV8kWg04FN8guSeUNRPxYlAMb3A1oR9cXa5wtQ7i0UrNokZvae4Da
 QvKobZT1KqR8eGtuI808A9cbD3gw/AINO06TtJCPZS5sbS+/zfQXQutMjM8Vrc5x4O1N
 T6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946849; x=1772551649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TFqgIIKK3OpWg78mPEJKWYRb2WR7Qhy40kIE8/pSXo4=;
 b=xMYyNQ/DzBv138vy+jMopjQHaGbD/S3AaYK2XzyqT1zoTVTyY8mT4kLJuz7yJ2R1Hb
 tP8TpHRoLcJOuUQqEDIw05MxWmjijlVYvDHVxGn9bsdFmO2xKePVkmFHm1OMNcKaffJ5
 dumvVKS0aQaXd42Qv0gb3QcgH/ziKBQRFUrXMVGuVveGET5vplK6qUVlTv7dPC0dwcGk
 CIDQWQ6xYmzvzCPjUqx6ft7rEcuymcOUjDze6cvBeROETMsIdEPMZx8zOHq5e4Gb3fVM
 2dMnftZnsLVOwaRqVJIL4IjikE+xxNgIcvfnpkwQuWh9so/RRG1WATG7qI2tkBHq/bD0
 DRHA==
X-Gm-Message-State: AOJu0YwgJl2nK9BHGtfOvI8ajPPetjY2vG3Oq0C66pJ/LV2eTIW+A1RO
 6nW8Mp7hIEWe1S5AAgmrM+tSny2BaQDCq0PIo8n//yCQjg302G8MwFh+DYkU9dQzMBiMCPftn9k
 nbRV1
X-Gm-Gg: AZuq6aIvpC2YKIMv0T1UujS+AhAIgyds/LDPMRvpJRlXlWwtd3Compy+S/ic6AZNt70
 Xy0S2eNovQWLxCIBy7jdhN0EFgG1lQMIMomngVkEe5PyFG+VyNEJeLKyTXP86HXqNblprIE4I4x
 NKb7YtU+RLgh8/HrfVt/Xk1uSrvfTcPFs/OYVIGraU+w1DpT15no6pXgNp8US5j3FKWlC+cNJse
 AveY+AfBZpOCSrlYmW2lTn13HRVOHh+aALe4GekadokQ82TfsEdJBcFXDoF+iBbANPiAy3UFJZv
 1KzvV9dQIKit0PX1jGL0i2nB2tEde3XOerJxk2G44yPCSnDT4e50dApL50fq1+QK45OpLAIUVXZ
 gTBnIbDZnbllXezKmi1wcSH/zNLKIbAxs7RP2VoqW5paM47/kynRegq2HKiIs7fV0FJ7pKCDREo
 M3bnQ1uQ969y+lXAuNyL8LlRZdv3dPu+vxWI9jwHBH5ZfrSwb4KsonaPY1PqCY6/OmdqxJDWYy
X-Received: by 2002:a05:7022:921:b0:119:e55a:9be7 with SMTP id
 a92af1059eb24-1276acb23f2mr5940245c88.3.1771946849209; 
 Tue, 24 Feb 2026 07:27:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm10728774c88.9.2026.02.24.07.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:27:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] pcapng: fix test and copy before open
Date: Tue, 24 Feb 2026 07:25:53 -0800
Message-ID: <20260224152726.567604-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220184255.306368-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
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

The test code does not build on Windows because it uses
POSIX-only APIs (clock_gettime, mkstemps, unlink). Add
Windows wrappers and use portable alternatives where possible.

The test code can timeout on slow emulated CPU's.

The library timestamp conversion can produce bogus values
if rte_pcapng_copy() is called before rte_pcapng_fdopen(),
since the TSC delta wraps unsigned. Handle the negative
delta case explicitly.

Stephen Hemminger (4):
  test: fix pcapng test to work on Windows
  pcapng: handle packets copied before file open
  test: add pcapng test for copy before open
  test: use fixed time length for write packet test

 app/test/test_pcapng.c  | 161 +++++++++++++++++++++++++++++++++++++---
 lib/pcapng/rte_pcapng.c |  10 ++-
 2 files changed, 157 insertions(+), 14 deletions(-)

-- 
2.51.0

