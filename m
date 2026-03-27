Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA510F2847
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CA9640E49;
	Fri, 27 Mar 2026 16:43:31 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 43A10402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:43:29 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1270618b3a.1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774626208;
 x=1775231008; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cobs/aafpFan70IBIJ1gV4C+Kn3e332PYn4i2MAVIuw=;
 b=PjLjZ2fNl+0QJcSR4AZVsfsbiP+YQGHgWO7ui1eaXIbgv8EUVanmLoaCKIttQ2eUAT
 UmjPynJR6HDtXGRRHsXjIafpa1HbMVuDoGacW1sszNZGd2CIh3IyNUeH4GIT4dkeYYnq
 csTS8HZ4tIG/j78dL/MMPxFCbcKnO79QvOSgTLJKpEeAY/DdAncfpp22AIFJgeFs6Z+H
 6He1nLLoqIlNhZKBTjCkjC2zWAe0fXRGXnyHYgzt6xWk1aSsr+FdTmM9++wp8Qsu6GcA
 0TA1HknvpEDtMzjBBa4Xk46qZSR1wg94Wi2DGqDyyXGGWqfZw9+4PZbwZH/CgqX1gcoR
 YPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626208; x=1775231008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cobs/aafpFan70IBIJ1gV4C+Kn3e332PYn4i2MAVIuw=;
 b=FusiSEzQe5cOqNTt9/OhYiEDQbq5q8pJ5HkmyAV4a64nbj4C1gh+WrSLIOlhWqDJ3W
 PgXy88ikGI/tuxqDsBaXrJf/8sN6OVURLBt+0HpM3iQfxWgAYURj1cerUnUHk+0zyC2y
 wwjxI4cpyl3dLQJAZ0mxgaT78/1G7004XwdjJ3H7i4aKru9xEUyjD8ywzNs2zEaryIer
 icmeZAms3OSbrV0S1vpaR555TqdpZbydmN2iGUGkKUm/QMIICXNCz4zD28xaaG2Wtrhb
 rHMMaR/1kAw6uMaHmb2+Fw6A4HWe65CW7AY8QDr7z+Y68LyhanE4144eYbQ9zM2IdNq/
 MQuQ==
X-Gm-Message-State: AOJu0Yx+hFSwHjtoCm+PozpIYPAJUisSH5s8pRSano/GWs5EDPCse5x5
 2Jiq+eLoGngDHRYJn8Ho51EXZEzQul+xu414XBKtwaKOzPpPqBQ7WdftG8tY8ZiQNc0iE/gze8U
 eaOjH
X-Gm-Gg: ATEYQzxDL/GtDBQBqxiVvtfPp/0jskzqZQlGkisKQm4SuinJielnA18QPHwzDAgvWi+
 TXTBuWYL0mJfcNAwoHBaFCbUgfgPdqgs+7pnDUub+ZZpyX/qBk9bXRMtQCoZxTmkogCtnlms9GP
 joRMSYCILbN7BdfCjTPjYkVN3fObZjmnmcA1+5O4ttNFIJJ9a14mdXR6OwELTMvK0tBiExGcn5w
 5Nyjo4jqIgbaTpUl1dirTfFTTQY1HYgjpno86yuuj0dZkgBbX2f4nmPdZE+qKsW7GNyxXFyKOnn
 Dra8iWdyXLNmVuw0T5HFYMnSYwlE1AzzEmdXQtWz+rSs3mZzjBF2FLI75tDcie7GTldg0mQ5/3C
 GQAZx49UryhfbhJrZ+P8Jvw0ZwVBo40qe6W5TztlKTuidvVvprseboqP2PpAr5cGJfx8iyXYS5/
 1H3/eq8FQ0KqdAqBkYu8lQ7NJUG2JlmVQs
X-Received: by 2002:a05:6a00:2887:b0:82c:7f08:8827 with SMTP id
 d2e1a72fcca58-82c96038433mr2681084b3a.42.1774626208118; 
 Fri, 27 Mar 2026 08:43:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d390a4csm7508304b3a.31.2026.03.27.08.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:43:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 0/6] Add AGENTS.md and scripts for AI code review
Date: Fri, 27 Mar 2026 08:41:51 -0700
Message-ID: <20260327154321.25800-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

v11 - add more checks related VLAN and mtu
      add checks for unsigned overflow on shifts

v10 - add more checks about mtu, buffer size and scatter
      based of Ferruh's revision in 2024.

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

 AGENTS.md                              | 2162 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1348 +++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1099 ++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 7 files changed, 4870 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.53.0

