Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE5E9A055
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:51:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3DB1402D5;
	Thu, 19 Feb 2026 18:51:14 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65]) by mails.dpdk.org (Postfix) with ESMTP id 5F4B1402CA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:51:14 +0100 (CET)
Received: by mail-ot1-f65.google.com with SMTP id
 46e09a7af769-7d4c3484268so874227a34.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771523473;
 x=1772128273; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKA9SvTK7bsIZsifgnwcKNqMJFn/bYfqMhplTqDOx/g=;
 b=QwPJn8IFy+yz0CZhyDbgBnOqM7IKsuR2kSmWMHo69o0KvcJJBehzHz36Y3tEolOmus
 i9k8XAPRIPA+FuzK9QBpslT915K4n0jN5rWdUV1gnTPloJCiO5EWlKa3NAE/RWZ2BS/o
 124wQOYTulcgaNIl7E/3Nx8spRnrLSxVnqHtz7P12yUIzlwV6jV8ETPi53fdzOA6k9zl
 P5bPVuxvwAEJqQ7k+gY/Ckfu8xOzKy1a2u+sEnb0HfMHvVkvy4QHjRiGv21H3Mf/C9Q0
 1KEjEdo+5pivUvfj/yzUl/Cq7ujMK+VayNxZxabgyk24yzQidSopne6i3NXi65ShXFJ4
 pEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523473; x=1772128273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZKA9SvTK7bsIZsifgnwcKNqMJFn/bYfqMhplTqDOx/g=;
 b=L4KGW7Tu5IGz3eAz4Fnw6mv8qbEydvR4cZzlk37Hoph+roJBcg51jX3MHLWt4btWK6
 YO3wCSpJ/Niwz8ljJgpjl/qLehOFbhL58pHLimNXbeQTtctuX/vAbaNkZCMZAm8VrIlb
 rVNEENP5aoo5CEgCgxf+n5g05Oskl9+G3l8RUzImYNBi6+fwjlwb9uEUTOBg8DwROUR1
 NSGDvdNeCZdMuSSpxoMAgARfxioeyMBSgLYlHlYy3OeqEwu4oE+woJ1p8fPPj9PmpkAi
 A9UFedQSVBQ3bg36uoWRUEngAd9pE4PNVuZoOD8VIKRdwyH3acXq2yejqKpXFS35erDt
 ULvw==
X-Gm-Message-State: AOJu0YwpN30L/pdaS62MvvkwpR/2GwTT/OofseBEWCSuBKXNCH68y0gQ
 OR9/AmRRL5GkYlkoW2s6CucnPhSdDju3kIz6TbRgP5Qi/Rwdv9Vx2OgMvLuGCRrPww69f93JMyp
 6E9UT0jM=
X-Gm-Gg: AZuq6aJr0NWa7Pl5mtSM2E/korZijmgbUf8o+HFnzCZ8diOEIGo1GRubcu0llVFmuTN
 sFxt4uDjioHZa2ZHdp2m5+yF7vsPzb/xCXunyOqFC9TP79WqSxbXfCP99ZwuZgmteR1h2nGk0kQ
 40gTWx5bJ5j1eB60PbDsxeo5uHiWiO9QXmM642AW24CCjv85ggPW7Z3Nef1ZUuyMP4iIrMCSUDE
 CiN6IpKEDfsTcNTJgB8Dh34GXy4+O1RudwAz3efhif32aOU6QkuMidJK+MR5G88a68PZUaVIUD/
 6AUUVUtZdk6KcmYAHU+NYHgcEsQNdhHT7qMfX6aFMWYBPJnF+crFBe4aIM/devIiFX/kdIsNrRh
 W21nFuK7vQiV9ejMKHNNY5FxKWHXV0oO3myzAokLOFjP0fwVGFeAyXht4XtSX5Rr+B3ZPwygWQg
 Nlibclr+05wZk6p+7Qc6/pxQBMTcPURhedEfpEAC1RW+3sILwQHXEfzdVKLoKDcA==
X-Received: by 2002:a05:6820:1b18:b0:66e:58f3:b4e9 with SMTP id
 006d021491bc7-679a7447c33mr3681263eaf.67.1771523473333; 
 Thu, 19 Feb 2026 09:51:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67985df6ffcsm10261701eaf.4.2026.02.19.09.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 0/6] AI-assisted code and documentation review
Date: Thu, 19 Feb 2026 09:48:45 -0800
Message-ID: <20260219175110.287747-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213214107.234072-1-stephen@networkplumber.org>
References: <20260213214107.234072-1-stephen@networkplumber.org>
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

This series adds tooling for AI-assisted review of DPDK patches and
documentation. The goal is to catch common coding style violations,
commit message formatting errors, and documentation issues before
patches reach the mailing list, reducing reviewer workload on
mechanical checks.

The approach uses a structured guidelines document (AGENTS.md) that
codifies the project's existing standards from the contributor
documentation, coding style guide, and validation scripts into a
format that AI models can apply consistently. The review scripts
then submit patches or documentation against these guidelines using
any of several AI providers.

The series includes:

  1. AGENTS.md - consolidated review guidelines derived from
     patches.rst, coding_style.rst, check-git-log.sh,
     checkpatches.sh, and the Coccinelle scripts

  2. analyze-patch.py - reviews patches against AGENTS.md using
     AI providers (Anthropic, OpenAI, xAI, Google), with support
     for patch series splitting and LTS-specific rules

  3. compare-reviews.sh - runs the same patch through multiple
     providers for comparison, auto-detecting available API keys

  4. review-doc.py - reviews documentation files for spelling,
     grammar, and technical accuracy, with batch processing and
     multiple output formats

  5. Contributing guide updates documenting the new tools

  6. MAINTAINERS entry for the new files

AI review is intended as a supplement to human review, not a
replacement. The tools are optional and require the contributor
to have an API key for their chosen provider.

v10 - add more anti-patterns found in reviews.

v9 - update AGENTS.md to cover bugs that were found in 26.03
     and previous PVS studio scans.

Stephen Hemminger (6):
  doc: add AGENTS.md for AI code review tools
  devtools: add multi-provider AI patch review script
  devtools: add compare-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1882 ++++++++++++++++++++++++
 MAINTAINERS                            |    8 +
 devtools/analyze-patch.py              | 1334 +++++++++++++++++
 devtools/compare-reviews.sh            |  192 +++
 devtools/review-doc.py                 | 1098 ++++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   56 +
 7 files changed, 4572 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100755 devtools/analyze-patch.py
 create mode 100755 devtools/compare-reviews.sh
 create mode 100755 devtools/review-doc.py

-- 
2.51.0

