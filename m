Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6F9C982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECB4440678;
	Fri, 16 Jan 2026 21:17:45 +0100 (CET)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67]) by mails.dpdk.org (Postfix) with ESMTP id 5DB904025F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:44 +0100 (CET)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b876f3f603eso428434166b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594664;
 x=1769199464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMwAa5p0IwlcaQqgfD/fKJ1mFEg12th58QyCYXcbO+A=;
 b=sVIdfhePcWv5HuG1GBWo0Glr3qKIKX6YVvurNPVMkF0TPcs1GZD/ya2MyF8nIyS7Sj
 nZ7eqVNoigGBS6FIgjyan+smmVXrP3c3UxgASnac5yQ996ILKDNmCtjBITHHQ/Gnzs09
 VRVSwQHcHWaEGQZAOZ3nV7dJtjCzZ7BdBsC83xAqyQNZ/Q2lldvPqv23p+PVwJvJnEhH
 gWXR0NESoSi44JYQKRWmHtiK0yHGyDggJkcIQ7SE9EQNICR+s0Z9kX1b9Q1itMODVXzz
 +hr+5XEmz2aspebSE8wfyrOwWC/qgTJhiIcQTMYhmAlE1SMEATfv2gRekpQfeWvztMmd
 g0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594664; x=1769199464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMwAa5p0IwlcaQqgfD/fKJ1mFEg12th58QyCYXcbO+A=;
 b=iaIPuqwT+OeYseJgPWZAWOFdR87cg0A2a9j1YTTyQqvd+RwMPSw5YbfXvEAVLL4hlS
 968d9RZYzzM/dmXb3/CDV//BIMCVxab88H7sd7Ck/ujftQI5smuZtIAiUSCglVyI43Hm
 KDkSG3vVhfUh2NaXwPaN55cZ6VNCOaDN3DODcZDW02Vdg+qnJhDNDCy4d9amf5EfY/ZR
 gXgWcNhdGG5wz1GY7HvT3mUcdoNvhwyb7DpLtXkPCm5x0UJ5jacJVi96CQ/0As9/6nvQ
 NSHiSCO5ZSb7DLgp+Cyt1P+Glgh+2GU5DyIqkdMOjdNcPq5SXWytBgPmk2Qjx/08Q55F
 vd6A==
X-Gm-Message-State: AOJu0Yyw4nMdkfSu/ZtdyB3RjLGgp8DUBlYCttbk8Q+cZ6qd2NlgsYSi
 eX7gF0X0IRl49YoLY2/HjSOVNefXfBPtVlPkn1TXe6q1nyFJpoag9RQoyjcPVUoqcPIjOo+d/Bu
 LU/Iht6I=
X-Gm-Gg: AY/fxX58YYLjx4C0qXhuN5PQuW3+GhOO2I+5aIcN7EFNs+r5wPBRq0NHwMBXQ7U0YXP
 awPbHLK9jtujCm/UiCprv4u3B8dCUsYO50brksY1Mc31BZZY5aVhJr9SZyyBlccuX56kro1n+Vy
 4yZAgN7e9o6sTidceKUK7UCMr+VUef3f8BNeiBjoh/MpQK4i63klblfAbAKb/kQnmIROowHGgZY
 n2nXje8gP+jHjz83pcJibCz1NPnT3rubyZ5PodX6D5bexW3iAiTcCe8UV2cJe9qhASdY8auaU/q
 b5VZxoD7KbN0X1YZi5SUpgfOUM19/+ji3iZi5DNoyPvZyGnxM02V4rXpSVaHeyWqkuMEhfGEYT0
 NgLN6VA3L1IWaGTUg/xn30U0ZOobmTR9AuBb+jMauZbBXWii9OkX2zW8SgZlqf6q65NOhqApdcr
 pZ2ZmW9kfibPuVLMu07ptVW6uAFowlaYXA6klI1dnyLx9NPo+U8Ig8GjH9gPGv
X-Received: by 2002:a17:906:6a11:b0:b7a:1bde:a01b with SMTP id
 a640c23a62f3a-b8796bf618cmr298792566b.63.1768594663715; 
 Fri, 16 Jan 2026 12:17:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/12] doc: improve contributing documentation clarity and
 style
Date: Fri, 16 Jan 2026 12:14:18 -0800
Message-ID: <20260116201738.74578-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

This patch series improves the readability and consistency of the DPDK
contributing documentation. The changes focus on editorial improvements
without altering any technical content or policies.

Initial work on this was done by Nandini Persad. This follow-up series
uses AI assistance for broader coverage across all contributing guides.

The primary improvements across this series include:

- Converting passive voice to active voice for clearer, more direct prose
- Using imperative mood for guidelines and instructions
- Removing redundant phrases ("Please note that", "It is recommended that")
- Simplifying wordy constructions
- Fixing grammar, punctuation, and typos
- Improving consistency in terminology

Summary of changes by document:

  design.rst          - Fix "executive environment" typo, improve clarity
  abi_policy.rst      - Active voice, simplify ABI change descriptions
  coding_style.rst    - Imperative mood for style guidance
  documentation.rst   - Active voice for Doxygen documentation instructions
  linux_uapi.rst      - Simplify uAPI header import instructions
  new_driver.rst      - Direct language for driver contribution process
  new_library.rst     - Simplify library approval process description
  patches.rst         - Comprehensive style improvements throughout
  stable.rst          - Restructure for scannability, concise backport criteria
  vulnerability.rst   - Active voice for security process steps
  unit_test.rst       - Fix grammar issues, consistent command formatting
  abi_versioning.rst  - Fix typos and grammar errors

These changes make the documentation more accessible to new contributors
and align with modern technical writing best practices.

v2:
- Rebased on latest main
- Incorporated additional grammar fixes in unit_test.rst and abi_versioning.rst
- Fixed inconsistent backtick usage for command references

Nandini Persad (1):
  doc: correct grammar and typos in design guide

Stephen Hemminger (11):
  doc: improve ABI policy documentation style
  doc: improve coding style guide readability
  doc: improve documentation guidelines style
  doc: improve Linux uAPI header documentation
  doc: improve new driver guide readability
  doc: improve new library guide style
  doc: improve patch submission guide readability
  doc: improve stable releases documentation
  doc: improve vulnerability process documentation
  doc: improve unit test guide readability
  doc: fix grammar and style in ABI versioning guide

 doc/guides/contributing/abi_policy.rst      | 194 +++++++-------
 doc/guides/contributing/abi_versioning.rst  |  32 +--
 doc/guides/contributing/coding_style.rst    |  20 +-
 doc/guides/contributing/design.rst          |  71 +++---
 doc/guides/contributing/documentation.rst   |   6 +-
 doc/guides/contributing/linux_uapi.rst      |  40 +--
 doc/guides/contributing/new_driver.rst      |  62 ++---
 doc/guides/contributing/new_library.rst     |  20 +-
 doc/guides/contributing/patches.rst         | 434 ++++++++++++++--------------
 doc/guides/contributing/stable.rst          | 147 +++++-----
 doc/guides/contributing/unit_test.rst       | 129 ++++-----
 doc/guides/contributing/vulnerability.rst   | 140 ++++-----
 12 files changed, 637 insertions(+), 658 deletions(-)

-- 
2.51.0
