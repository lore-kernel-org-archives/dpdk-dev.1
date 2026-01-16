Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ECC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06EB42E10;
	Fri, 16 Jan 2026 22:16:56 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id EE40A410E3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:16:54 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b8707005183so410011266b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598214;
 x=1769203014; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=od+xsVqEHWoVWGjUHspqbFBxk5pb+xBObkJdgw4bSKA=;
 b=0993BP5xj6AuGKUYxgcS5JLlUKVlOuUfLzhp16vlyJX2FWmxFCxCVuv+4uoZUzfgEj
 BvvgAe1U9NHgwDhu1NI+lWaJXRtp196HvfmVVXLYeJmVIh8y0YHPMT5GbD5/34f7SCgB
 awGs98OOg7oAesZIkuZScJcctKIO0t2J/UM4iGAZaGb6HeD+HWigTqmBeN8RsXiMh0yQ
 1Y8LMQm2jaAaBxX/TCUHQ7Q8vf6Hblv2gZe9V1M76l1Mz2Po1GGmgW4t9PNNHd/DaNeu
 KFUWmSIQ55kBB5Dc074jAkVr839p9cJNd62kZbE7/pxA5U30I+a2+2o9UWUxYKGIfpYB
 UExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598214; x=1769203014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=od+xsVqEHWoVWGjUHspqbFBxk5pb+xBObkJdgw4bSKA=;
 b=uts6/pscofo410wP3kW3pzyf/g13xBgYLFZHHDVb1fMXP0JbDVReZlhHk1hjghhjT6
 2L0mHC6iEQ4K7rvPk5dgThzShlOUEz57cm/SfKRAuJYjLX5B01ZyKu/YwFJ6vjLM4qUH
 1yuiYwM11rYZ8i+T9azTz8v1fQ7zsheQUjaejcRekitDBC4WzLWKCSktI40vcAHsd7QC
 sC15zVy5etjxp01GnHdey3XKQFTVKPQ92Tttajk0myjdVsyawkQ/0XMCfiVb85IB7qKE
 i0xmzGuqCflItR9/MFSLtSJqQnD0Sb8ab05ASoteTtmOTFymKhhyhiv2EjbDuZfNSM2e
 mmXA==
X-Gm-Message-State: AOJu0Ywbj5jXNJcrsbtCoKr9fbn490pLhMnQhfM3XphmNUKVABkH1GDA
 lAMCSlPW0CJ8/HrJDbCuibIrP59XlxkEU3piYfP3qcUVlkIPjXLMWHKfGX5Vkj+6+MM1HJd3Em5
 qPFf2
X-Gm-Gg: AY/fxX4DqcvlRRbfCWR1wPnBrYa+Yu+GrcFtWwWvRNlDbBf3Vw38cfqziKyDkCF9krZ
 /HIXqJUdMsH/cvRvv06QSuf4RUmzHZIwFtvonRqjro63Tl6827PINsJ+sdyiqIvFsTUH6vkfIUf
 tnHIFcCm/GlK0QMLVXTex7Qa4poj8HjRqWzW/8XhN0GuCZEW/qGPk37HMdP8VAHBGqjgrjXXdhh
 /3kMwS7WFe/wMFcaRsFZ3wL2Z/L3lHJouWtwA0+6KZknGI8ZaZH5xdtUWJr0JlsKs7atKoLHkzU
 q7bqHA/pgv/Sg+phvXwNeDXllW5ebdtLgkP0eWYlkR7w69Cu6/+uvhIEWNMawn1W+opG0iQ/L7t
 zOXwU1vYjuYCKv9TQ9aBSr0BNBa3fk2FAJJVP9vpgOvDYCouTGXyA8lOP8tnLZbaHf4cg1k4LF1
 3Six78ZkzZPiM8kf4yA7hVIbLcaprhpS0dq92M6K6MOAyLTQ6dZQ==
X-Received: by 2002:a17:907:6d1b:b0:b87:115c:4a2b with SMTP id
 a640c23a62f3a-b8792f9be9fmr416364566b.25.1768598214371; 
 Fri, 16 Jan 2026 13:16:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:16:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/11] doc: Linux Getting Started Guide grammar and clarity
 improvements
Date: Fri, 16 Jan 2026 13:06:16 -0800
Message-ID: <20260116211649.104776-1-stephen@networkplumber.org>
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

This series improves the Linux Getting Started Guide documentation by
using AI to correct grammar errors, typos, and improving clarity throughout.
Split into multiple patches for easier review.

The changes include:
- Subject-verb agreement corrections
- Missing articles and prepositions
- Typo corrections (e.g., "by be" -> "may be", "my" -> "may")
- Consistent terminology (e.g., "toolchain" vs "tool chain")
- Proper punctuation (missing colons, possessive apostrophes)
- Formatting consistency (RST directive case, bullet spacing)
- Word choice improvements ("customers" -> "users")
- Technical corrections (hugetlbfs mount syntax)

Files modified:
- sys_reqs.rst: capitalization, spacing, mount command syntax
- amd_platform.rst: missing prepositions, colons
- build_dpdk.rst: typo, capitalization
- build_sample_apps.rst: grammar, hexadecimal notation
- nic_perf_intel_platform.rst: subject-verb agreement
- intro.rst: word choice, redundant text
- cross_build_dpdk_for_arm64.rst: grammar, spelling consistency
- doc_roadmap.include.rst: redundant text
- eal_args.include.rst: grammar, RST formatting
- enable_func.rst: typos, hyphenation
- linux_drivers.rst: grammar, cross-reference direction

Stephen Hemminger (11):
  doc: correct errors in Linux system requirements guide
  doc: correct grammar in AMD platform guide
  doc: correct typos in DPDK build guide
  doc: correct grammar in sample applications guide
  doc: correct grammar in Intel platform guide
  doc: correct word choice and redundant text in intro
  doc: correct grammar in ARM64 cross-compile guide
  doc: remove redundant text in documentation roadmap
  doc: correct grammar and formatting in EAL arguments
  doc: correct typos in enabling functionality guide
  doc: correct grammar in Linux drivers guide

 doc/guides/linux_gsg/amd_platform.rst            |  6 +++---
 doc/guides/linux_gsg/build_dpdk.rst              |  4 ++--
 doc/guides/linux_gsg/build_sample_apps.rst       |  8 ++++----
 .../linux_gsg/cross_build_dpdk_for_arm64.rst     |  8 ++++----
 doc/guides/linux_gsg/doc_roadmap.include.rst     |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst        | 16 ++++++++--------
 doc/guides/linux_gsg/enable_func.rst             |  6 +++---
 doc/guides/linux_gsg/intro.rst                   |  4 ++--
 doc/guides/linux_gsg/linux_drivers.rst           | 10 +++++-----
 doc/guides/linux_gsg/nic_perf_intel_platform.rst |  8 ++++----
 doc/guides/linux_gsg/sys_reqs.rst                | 14 +++++++-------
 11 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.51.0

