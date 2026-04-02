Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8AD6AAFE
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D4D34028E;
	Thu,  2 Apr 2026 21:46:24 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 067AD40275
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:46:22 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c7e5f38b37so1805294eec.0
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775159181;
 x=1775763981; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7F9RzlQBoh1txiMY1E08a1bfY+AdN2kRzKjCLy3K5M=;
 b=jQq0g+Hfo7JL1Tvaytf8CRv2cacqLmIUJnfB1YhwzU24lzguPyCh8AG/8A/IyxzEIN
 XjEqt1pWkub7PHYLrnrXXMmLiXs0JEX/cw37Og7tB/nW090cDIiWACx/luECwYsPryeW
 SEXqCNlY0Z5Xq3UmY/V993WtEPRv0ByTBQVZDNWA6r6QpY3RDvi7vQb/2W+K6Zkm2vJj
 nHL/HcZWc7XUYp1drW1kdYip47I7ZYnVnka/2MfwPcefp7+74Xefp7UXsfHziCtV3aWI
 NOf16BGB9me5D6kTy+uZxaKlu+vfR3gsC7Msk2vaIhDwyeU/jwXX1+2NwitbYeHbBoA4
 d0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775159181; x=1775763981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s7F9RzlQBoh1txiMY1E08a1bfY+AdN2kRzKjCLy3K5M=;
 b=RCXTfihxHnpJ+QcO+NTSKsYskbpMwSs8PDLN1PlKAfNcdHYEc8yEVdLg6T3dNm/+dJ
 Pi8zZgm8IOA4cn3eirTj9RvZCOvCbPu5rx4opiCAq943gwh7o1FsYarmZDqZCmXPw/xA
 dfDA23/7VUfpd+yVBMJac6IjiacgAEod/wIDAuFBqw6n7ohixTE5zkMhotTgF4oCrNIR
 VXoooANxiatIaVhxcSw2EpPqatJ6NmKgZA/YFTvG06fBl9NLCM0iGara9v6mZKZ7Idqn
 gA+LvgfrPwa4W52kgkp2JI7tRZ/DC8zRfU1P0NIuUYi6h8h8WtOi2OEWK0yuNluWqKge
 CS5w==
X-Gm-Message-State: AOJu0YwSqjDLPBqvsIjmHAtP+9/3FBPgvhZj8bMThdPyuncx6pBDpcMW
 r600RIWfN0wqMq9G+0lvHSQ0y3mv3tqFD4YvrujSQ/Lz8cnrDx/hLrgn6tCgLxmLrY4nIMQ9wNM
 Ujrjf
X-Gm-Gg: AeBDieuhxEpzUd9+16b+sYN/QhZdQ+cqoX9dkfg6cg2OJE/pZUjbBrFawkAJWzYzYiH
 erAgUHZQUmiYQmRacCepzo9J0fOCx/eRq+QLl2KSBUA0EQdXJOrWnEQAD3K39R1gYByw+Re2eda
 uS3xkyrIHYWYT8opqlzQgFl0KdY6nF0Gi80StOa598claa2h/dFq49q/YgCR5+L3HRMnNnU2sYR
 Un/YrWwoskTLnop0u36deFDJiS8nKkPwU2xFEjQiApOpwBSCdFxmzxuk1lfHs8RSZpZPviFYuhZ
 NRmjoNYAhPYVOaok0CVqQutjQiHTjBb0pY/fUzj66aMwct9esHwULGTqnaBRHUnUiuGFdy7uOSF
 DQ+XR8WCqxJKX0O4lp+ZS8oTju0PFQkfFtWXq55timsHytZTuf37B0TM2yQEu9LhlHs6d7dWwB2
 iz/Dy7XTX9ZBxAmW014Z4Us6xtt12VjyyP
X-Received: by 2002:a05:7300:641a:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-2cbf9ee8c3emr255651eec.5.1775159180835; 
 Thu, 02 Apr 2026 12:46:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ec7sm3164279eec.3.2026.04.02.12.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 12:46:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 0/6] Add AGENTS.md and scripts for AI code review
Date: Thu,  2 Apr 2026 12:44:30 -0700
Message-ID: <20260402194618.134002-1-stephen@networkplumber.org>
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

The analyze-patch.py and review-doc.py scripts support multiple AI
providers (Anthropic, OpenAI, xAI, Google) with mbox splitting,
prompt caching, direct SMTP sending, and token usage tracking with
optional cost estimation.

v13 - incorporate review feedback
      fix bugs found by AI self review
      add release note

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 2162 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1603 ++++++++++++++++++
 devtools/compare-reviews.sh            |  263 +++
 devtools/review-doc.py                 | 1341 +++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 doc/guides/rel_notes/release_26_07.rst |    5 +
 8 files changed, 5443 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.53.0

