Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B9C5AD48
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 18:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B2F1402AA;
	Fri, 20 Feb 2026 19:43:00 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id E72674026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 19:42:58 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7d4c3896e32so879866a34.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 10:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771612978;
 x=1772217778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Z6BGHqMLMvjOu7u3G/2gR/Bc5aIh0LqK5ivKn9Lqjc=;
 b=hJ3jG/rxeeo8xKA9bR/X3o4cC/BkUOvdg2JrTyN4peeAFux2cePYyQ16F5Svm4Yaeo
 Fgat+YjnPzsr5HQNcoYMu0iTEsZcogd7vVwoGddXs/nS9YmfounskL0eMYI5q240cd5/
 jOq/vs+fFT/rZKQlA6cnZzQry8IdjNxS5w5MY9b2yjB9+lqHUFNHXcPbr8synyUW1Vr3
 E1eeTZzp+plDZLIEJl8G7dmI/jCWHNqjZnNCTkzHzAmFL4sadWyCBdEvdSWnPnn5rc2e
 62F1abGqatZyrVc72bisAK3eo2MnIuKnYWDx+HYBDfnDCEmGV+hClriaTbZuvpxoZ84u
 ubkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771612978; x=1772217778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Z6BGHqMLMvjOu7u3G/2gR/Bc5aIh0LqK5ivKn9Lqjc=;
 b=WiGQSFQnHithGgj+fNVhuC/J7fAALtJZuIMj/5vxnhi3aFOmEK9xywrXGf/iW3V4bd
 +SWdiJXNqBjwrczdNjBc0UdwlFSvaqaGNnTeKvAleDjCdnbGyQjyz4Se3Im3rnvTajHV
 RZM8vyNm5mCP1f6XeugliVOm7aim7+81fmi2D0d+kQAW1HAcz+PQPJdhqDUo60Jb7gZd
 8eLkRkz7v2xKLkzSS0mKtNEwhDH33JF77cb+tRnvy4teIXDK0zVFCL1mzQIQm84KEKji
 Ze8bNiixp3yxh0YyUzUsMxsQBBTb2bzLySwFAtthaLfHRXXzyg/eEwmVttFU+i0CNEnf
 7lRA==
X-Gm-Message-State: AOJu0Yy+TdNq3TzEbqCvg1ogo5ztMz4LlQ2uaAEZ3tUab8qGOrMyIWcN
 f76NCKYeMzNKfaoDYjJxHvnA4mBrc11NWx1YoSom9RV6DExLxcyIRa8SYSq5NpaDxTyEaczboVp
 Lz6Ya
X-Gm-Gg: AZuq6aIRDNuPD7+bz454ovFOvHxxWQ9fvey//rGdnVoXh/3P32Z9kokdwhdjgsruHvD
 zzPLWmqMbZPCwDmCJbx4xB80sZZeGSpUBG03KloBNbfv2yOGRjZldDcuDsKUn/I4YIGwjIjTyJY
 ow7v/nkOJGRDymk8a/Q3UkKfxoNxRUYUp0pwPg5sGrS777lWFPdWQ/WMWnmdsgFhX+C8yaiWfo2
 p+OflFjhXzug/DMihDghjuPaDTSuAexxq0gFWG/ValNCgOaEMC2MlY6ecsf6SDRV5eRabTFAlzD
 l2oF8/onJX53HydvmTBW2fG2IMySVyryuZTMJZ78yK/49ZJgsOR6rYSxZWkUy9E4JNg+wFDUhTO
 2RnJaX42mWS+BD01sfz8qR2WJ5SNXHM8uFgiQpS+ndL2owhUnYKLklVVWoyVu1FsnOX+44NGvuT
 6Qdeo1+9SDuwjk2smnx/sqs49qdea4B1v2lS9VpmAIuitJD0jrnWVm2O6gM15L1Q==
X-Received: by 2002:a05:6808:5086:b0:45e:bb86:d005 with SMTP id
 5614622812f47-464463953dfmr560089b6e.48.1771612977901; 
 Fri, 20 Feb 2026 10:42:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm250876fac.4.2026.02.20.10.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:42:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] pcapng: bug fixes
Date: Fri, 20 Feb 2026 10:41:54 -0800
Message-ID: <20260220184255.306368-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Fix two pcapng-related issues:

The test code does not build on Windows because it uses
POSIX-only APIs (clock_gettime, mkstemps, unlink). Add
Windows wrappers and use portable alternatives where possible.

The library timestamp conversion can produce bogus values
if rte_pcapng_copy() is called before rte_pcapng_fdopen(),
since the TSC delta wraps unsigned. Handle the negative
delta case explicitly.

Stephen Hemminger (2):
  test: fix pcapng test to work on Windows
  pcapng: handle packets copied before file open

 app/test/test_pcapng.c  | 65 ++++++++++++++++++++++++++++++++++++++---
 lib/pcapng/rte_pcapng.c | 17 ++++++-----
 2 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.51.0

