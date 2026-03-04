Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96726EFCE33
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 823DD402A9;
	Wed,  4 Mar 2026 19:03:10 +0100 (CET)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54]) by mails.dpdk.org (Postfix) with ESMTP id CA3434027F
 for <dev@dpdk.org>; Wed,  4 Mar 2026 19:03:08 +0100 (CET)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-5ff09bb6335so2169694137.2
 for <dev@dpdk.org>; Wed, 04 Mar 2026 10:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772647388;
 x=1773252188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OB+qbSQGM0ZZxnaFtfWxfcyBuXCDgcCeNeVwvisFT58=;
 b=2D5fMwcX93f19bcEJ0aKUyjqp0kKtqeUStJzWYWMSufOTImPL1Va74FJyiGzqHgppM
 uiCysZVwcX2qvSuko/2HZhmKLl7z1ehBk0gEr0GVrrAoDL62qd9DMI5DWEa2RRoHAdp7
 2yNP3VoyvN1fXuWWajP5CbzY61KpE+SwQJ014qp6+NnVnzdNdYlW5IFCMF2CuFRNY2Wk
 3gng0ZpKhdRGDNEgGzmib8DZ0zqJERIcRvCxdG0HuT9Iq1g+0aS+IjtzTo7BOgI/biAQ
 9Dn5BrX7AGBN/Mej6zlyANjV59XX88TkHtfjsO3kmyPJRKfIJRwV60vcVTOfcil5peqM
 pARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647388; x=1773252188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OB+qbSQGM0ZZxnaFtfWxfcyBuXCDgcCeNeVwvisFT58=;
 b=dQIA3pPSGdF/7kB5My94Fw5GswqYZDVe5B+MHQG13MW04w2oC5bW+KedHFddVlVVtZ
 Pe2FQ/YWYPW+sameuTIcusevGluIHnOfrn5QQgG1cH4KkcBHFYipvodXVu76GYGbqD+0
 zfYFdSVI1rELMLCE69szUIE3MG3/mr5KE+C1VVdyUz2A26WqJNvktaPjOnrWBUL1PQu1
 wPOum5h196jtVR6jXtJIXlt1kax18rBAYAxfEnU6LskCRjV+UbnhvynqT1JcamLPurML
 +pyxSlPJD19Vgo+oqjKy+rbTRrVirtlCksY0LFuNl4J7vWbI4Ca0fdOVAStPlW/9oovM
 kqag==
X-Gm-Message-State: AOJu0Yy5480j68hmCYmb9JEd8NI7ia25iG6lVsN7iFOKHiWzZsEBk+QE
 eiwLGA1dYlKjuhVMYVLFu/JQi0sxn+9aDthTzh0rpVYbIXmR8mrttGHmyDfs8kWhI10clKvWUPL
 KQ1h1Jl0=
X-Gm-Gg: ATEYQzzQUa1orviPh7LvtKkIqhOBwjX+QGoRkux4Vv+e6CDuzi3Vvf6MIYbiswjK1hS
 T7OxWe8uzgIUQhtwBztYtmWXDgbznK5xo9jMCFO9rKaN+6nwNkuB9sL+p64WSKrh/2ibbdhbXZA
 xVCsjqoPC3pTtzrFHeXCdZUAwCEK9EtNZVMKT/VzxcS2eABA/mo0AvQcjgmrkM9mw14fW9Ns6Ag
 KyEac7/m5gNY8rDjLZJiDiH3O8oO6mde6vNu2p84KUzL/p9v30GeDDJ9Zw5SCien9a98F4l8fzj
 Gs59CvolpGjkPARl8dCX5Z2JYojPvQP9s1BEunc0mHd4Pr7vtgdlByainNQ3G4xkKxtlfnFbKYc
 ubBzYvNgav4S9+1A65tZQOsOYwylEN95RgG8w/o0LJPjz4uHlv0fk2A8venxk1ohNvO6NY+gaD5
 3xf7lddSA9DkzodyuXPQGyw62+AYJdg1POgsQDhwCuo4fNweu0+X5refalB/4s8g==
X-Received: by 2002:a05:6102:c8c:b0:5ed:675:e355 with SMTP id
 ada2fe7eead31-5ffaafc609fmr1123025137.27.1772647386498; 
 Wed, 04 Mar 2026 10:03:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a083a95fbsm51698626d6.38.2026.03.04.10.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:03:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 0/6] add AGENTS.md and scripts for AI code review
Date: Wed,  4 Mar 2026 09:59:36 -0800
Message-ID: <20260304180303.436779-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126184205.104629-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
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

Add guidelines and tooling for AI-assisted code review of DPDK
patches.

AGENTS.md provides a two-tier review framework: correctness bugs
(resource leaks, use-after-free, race conditions) are reported at
>=50% confidence; style issues require >80% with false positive
suppression. Mechanical checks handled by checkpatches.sh are
excluded to avoid redundant findings.

The analyze-patch.py script supports multiple AI providers
(Anthropic, OpenAI, xAI, Google) with mbox splitting, prompt
caching, and direct SMTP sending.

v9 - update AGENTS to reduce false positives
   - remove commit message/SPDX items from prompt (checkpatch's job).
   - update contributing guide text to match actual AGENTS.md coverage.

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1917 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1348 +++++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1099 ++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 7 files changed, 4625 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

