Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D4606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gPrjzk6o
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AE27402C4;
	Fri, 27 Nov 2026 20:42:15 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 8EF6B402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:13 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so6039637b3a.0
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808532;
 x=1796413332; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MsfdIiQKvOFOt2iUgrsg71T5NerGM955WB5bu33lEX0=;
 b=gPrjzk6oKe3aB51Yj6gQTlWkMosW/jKN0+qSlSjbKEnmesiWMeVXfXwcrimZ/LN+0O
 ZYFnZCYHMQ9eF5fKkSX1ZHqCcj8A1iXMjCgCtoX+Pxi95bunZZ3H8xyes8badkEtuzIj
 4fpeHakEYZFTWs9OZlmGi4rwZ4xtYXWNIWXdFrsyNTi+Lq2x1+k2ogPIc96itP5xje6h
 /n0wllz2tsKpuKevrpJJy1s2Tg1mqERZAgkD3/S3Oclbcb99ufKW/aeao9oNCdOTKi3N
 XSg7GYQt34RePrXYPUvuLrTA5DJw70EDZlBgwdF6CmK4EKNrLVTcplMPkx7Tsi/szJI3
 /qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808532; x=1796413332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MsfdIiQKvOFOt2iUgrsg71T5NerGM955WB5bu33lEX0=;
 b=vspRO7ujuxpt9OZzLHiDcGreo6BU2OQ7v0VukNHCwhymYrAUyfCHtvxDnBAQ0TQivu
 AYcGargSmScDT0fo5KSzv3jvGfE+ED9iyOLAgc+WfmGk1ASrP3QZehpSa8zWvMToMK/q
 EYzZadUB1+DYFyYg3nvUdsVMsjAe4FhnZGOuuqfmrn7wvureJxhdcmm+2scVCz/+qpdP
 SQg/8K/uUwv1JWIKCBXc440vrRi9doWg3b5hDFwN0Qc+3MXGq967L6lllYrH0QZfdQgC
 tBpuue1sMWQIh2iYgyRXtNNYRGW8Y8a9Ta0RtLg8I5TbhK2q+39eqZBAu3PbLWtfLshX
 JG5Q==
X-Gm-Message-State: APuU4Z8R3u1G0JyNfQkAcNHnQEp55ZWsZ9ogG+2tfeuMM4WH0eAm3oyL
 QKPFyrChj+z/DvQPbP8MHd2+2lfux4MPuxfhm0JhCaXiDKLTDp7QD9ZGjjP4KhA5s1dWz3WioVk
 5qNuNvv8=
X-Gm-Gg: AZFdTZdJ2axMnxOMbjs1H91hoRsjhFTgDX++FNKMP2f44Tgy769d5ulgkyqqO+BsXk/
 GFqzHLtbFeVL5tDy0nfE4ibfozSS7FkgSEzRU+Jyn3pU4BWOOodv21pEfM91IHwA93pa7lfIMlx
 yCta1SEEpw1OS9JeyFCW6ZdUcKLZ2K5fCvltw7TqlsnEKflAinzEjqr1kAgmC38zQqhxO45k6UJ
 RemUIheb027o5wzPayjd81eUGHFZVO5lGBHfOwpQA2kW70mHxfN2BwDJfMQSQyEFF9JLCUXCub/
 rCIQvF3/zIaiNIiIAeJ+wLQWhU0VXYPe5YcWkAm/fOMgrHS2/ezlyk7yWYuZ4+Va0hbeAc+h5hW
 p/qSjXqhTJyrkOdXKPzzSY7z57sOFy3IqIFOXdKV2o1FR43cLRfCp0pLgHLIGgkyj6MBsnXpbT4
 viMGLYjN7WcPzmDwsGWUsUEZtxhPAPJ4BYvWhoPd/lHAHnuxLo8Gl+7ADVoZ3tAnMPMPwuWFZm6
 m8VPdB5CpCBCc3Xl9L2gAJgjeFgHcJBGvsHKaumCaj12PSO1OJU32Vv96v3WkDx53J3LurwGIdX
 XKgdjjKEA4ZabMrs5VVfFRCy5KWdUbSeGobf5ptoK2z/jPpIrjF3JKC32QI80Y2RJbfD
X-Received: by 2002:a05:6a00:bb8c:b0:89e:2a91:4fd1 with SMTP id
 d2e1a72fcca58-8c8794b8c20mr23556291b3a.6.1795808531725; 
 Fri, 27 Nov 2026 11:42:11 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/5] random: fix initial seed entropy
Date: Fri, 27 Nov 2026 11:39:32 -0800
Message-ID: <20261127194209.107396-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is first part of three series to fix the DPDK random number
generator to make it faster and more secure.

The first series fixes things that are broken and missing
from the random number seeding. Later series improve the underlying
algorithms.

  1/5 adds a Windows getentropy() shim over BCryptGenRandom(), so the
      EAL can call getentropy() unconditionally.
      Needs to go with #2 for stable backport.

  2/5 drops the broken probe and always uses getentropy(). The TSC
      fallback remains but now logs at ERR with the errno, so a
      blocked syscall can be told apart from other failures.
      Marked for stable.

  3/5 mixes all 64 bits of seed passed into rte_srand()

  4/5 removes the RDSEED fallback. It is unreachable once getentropy()
      is always used, and RDSEED has known reliability problems and
      errata.

  5/5 allow setting random number seed via environment variable
      for standalone tests for repeatability.

Stephen Hemminger (5):
  eal/windows: add getentropy shim
  random: always use getentropy
  random: use all 64 bits of the seed
  random: remove RDSEED fallback for initial seed
  test: allow setting random seed for tests

 app/test/test.c                       | 48 +++++++++++++
 doc/guides/contributing/unit_test.rst | 15 ++++
 lib/eal/common/rte_random.c           | 98 ++++++++++++---------------
 lib/eal/include/rte_random.h          |  7 +-
 lib/eal/meson.build                   |  3 -
 lib/eal/windows/include/rte_os_shim.h | 30 ++++++++
 lib/eal/windows/meson.build           |  6 +-
 7 files changed, 145 insertions(+), 62 deletions(-)

-- 
2.53.0

