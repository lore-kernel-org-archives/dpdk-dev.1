Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CBE6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E06E402A2;
	Sun,  1 Feb 2026 18:19:47 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 8EEB140150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:44 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso27008245e9.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966384;
 x=1770571184; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN2xyND0mf9GEJNQgwTC/lV2+RFnZky3j4LXGHITHTI=;
 b=z9qtD7L5DcsR9w3n3lOYKz153zM8SZFWAlUyPO4YbhS2vD6OahH7UKFYk405h8IKDm
 v5nSkmeER+E69RUXZB8eAs8rVcDwCs3gtReKKdrn7c3yvecCKdU1WZIDdoGl3JPMqn4n
 UsLLgsPL69ibCclKu+39NZ8nfSagkO6QanccUUOe0HiIeYJ2PTq6vHpQJD6cjTlgQIL5
 drLj5KmF6kKKWx+yj8vovo9Ccs/rTUbfpWZSotykmZMmZnTrw8JCqc3nvzI+4mzZtJQI
 cxsYgLqqaeRGeTLG8rb0wlyuGY1b+ZgbON8g2UoYIswpxJTC1jBf7IOWZ7iAd3Nx3aF0
 cVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966384; x=1770571184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wN2xyND0mf9GEJNQgwTC/lV2+RFnZky3j4LXGHITHTI=;
 b=qt6+2rSblFLfOvtlBSLqqG3IK5gzSkBVYOhDUWp8CcGkC9Csd2dt2cWQuyiKQ9L/60
 9fKnfBTQDUV7uWF2oOmV4yJSw/HQzX6FhOy2NV/YkmKD6P5xPvx9gVy3SXN4TvM0MID6
 zRrU8lXMbcDJnweihde/CapbDxflCpN6JQ79SBpmzUVN0QEq22wMbgmzM8jbXSkzPvD4
 6xrfOzD8DwSvJRWe0VlWux/21gvvO6zonO9uuBXorYXHVuou/KvRCsfB5/w3n7lzVz4H
 Wnr3/DLkWTkUf+458OcZJU2cEkOuIze/Y6HAbn2uBxib74vQ3Uv8O1igpf1XmnjJddtp
 Dn9w==
X-Gm-Message-State: AOJu0YxWiN47sotk5Oe1LU7wH7clCKDj5ue6Y3vn06c8dkyOGbngFp3/
 uMjVZ7kpwaUgDhw/Oy7VHMRLQqp/xEgPiOno6HvwbpY0BnrEVQbZiXHwai/ZHtxNrwp0aYtETa8
 C0l5C
X-Gm-Gg: AZuq6aLpOlZteRE63HicEHvQpNO+2qzYTOqNeHfY0Y+WNdqFMTUUSGnPJZojsyHzypj
 /HOdYg4O4Lm51ajrx+d6/0cp+zUVHhdHU8yyZIvCqXmXohsXVMN/9yrT9c+H10XEjfqAHDDNqMp
 5myrfjJbAPboUSTjTuedwXOj1DrcNstRMSNJlg0IQPWLJIcMjrNw1G8GDxG7I2XtKUzeDZI0pmj
 GKaCMo0I6ZZ713MbTW3TOvYX8kObx7gzDTgdSrqFnpBiZFUrk6pYBU6E4e4XbKq5/vSxsw9w3mQ
 IBYBq/j/yjQn5JRLS5pBr0rWE2VzYm+x75PRqCSOPY6wXLLJxIb/8E4Z3a22iBWg4vH6UB4Ulbr
 OUfgrsGXR1Q+fuJuPJ4Shrw8C1vlSHfKleVemEx83Q5rTwLpWucGzRR72Ooi/DcY46ShoBdhzOB
 tT0rcIDjPkOpIjpAXbM+oKeVfrbzWXHZrgrBtg4FTAKsfZB/MpGQ==
X-Received: by 2002:a05:600c:628d:b0:480:1c75:407c with SMTP id
 5b1f17b1804b1-482db4577f3mr107313735e9.2.1769966383837; 
 Sun, 01 Feb 2026 09:19:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 0/6] net/null: bug fixes and improvements
Date: Sun,  1 Feb 2026 09:17:31 -0800
Message-ID: <20260201171938.89492-1-stephen@networkplumber.org>
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

This series makes several improvements to the null PMD driver and
adds comprehensive unit tests.

The series:
1) Cleans up the info_get callback by removing redundant argument
   checks and using proper constants. Also sets min_rx_bufsize to
   the configured packet_size, enabling the ethdev layer to reject
   undersized mbuf pools.

2) Adds proper validation for numeric devargs (packet_size,
   packet_copy, no_rx) using a common helper function that rejects
   empty strings, trailing non-numeric characters, and out-of-range
   values.

3) Removes redundant argument validation in dev_ops callbacks that
   is already performed by the ethdev layer.

4) Extends the packet burst generator to support larger packets
   by widening parameter types from uint8_t to uint16_t.

5) Adds a comprehensive unit test for the null PMD covering RX/TX,
   statistics, custom packet sizes, copy mode, no-RX mode, link
   status, device info, RSS, RETA, and multi-threaded TX.

Patches 1, 2, and 3 are marked for stable backport as they fix issues
where invalid mbufs could be generated or invalid arguments silently
accepted.

v10:
  - Fix mbuf leak in eth_null_copy_tx

v9:
  - Consolidated argument validation into a single patch with
    common helper function get_unsigned_arg()
  - Merged pool vs packet size check into the cleanup patch
  - Removed redundant argument validation in a separate patch
  - Reordered patches to put fixes before tests

Stephen Hemminger (6):
  net/null: fix missing mbuf leakage in the copy transmit
  net/null: cleanup info response
  net/null: validate the numeric devargs
  net/null: remove redundant argument validation
  test: support larger packet sizes in burst generator
  test: add a test for null PMD

 app/test/meson.build              |   1 +
 app/test/packet_burst_generator.c |  34 +-
 app/test/packet_burst_generator.h |   4 +-
 app/test/test_pmd_null.c          | 935 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   | 114 ++--
 5 files changed, 998 insertions(+), 90 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

