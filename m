Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5E4D30CDB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A086402D6;
	Wed, 14 Jan 2026 00:01:01 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 6E3BB4029A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:00:59 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so4166448f8f.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345259;
 x=1768950059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROGaE5FOqrZvsxIDkPsFAtK9dyn1pRnijFua0uxMqKc=;
 b=hB4lxrVhT19HLUD7hsBB1ycr9RPhQgBMDIbs3FkeYdrwrtmE0s7iepbMUr6AbvkmpN
 t1eWYzFeUyH6v7X5WSYQay4h5NnUN31+mDaJ2O42u48c9134ADTRcEo7Zka7LfYuuZO6
 ROLHxwbjJS55hDQiZ52xEzOhIxEeK0ycnVSxQaJYdDrnyeAMvb0StJ27w0oCQPlzEX8C
 z4ni13CeYO0VIkLckjnw/AXIaiJsCScFNKwhNhgYhW7ly4qXKA/p16mFnv33UnG6yGwI
 Htb8zCZ1UDws8a81NO0NAF73gEdNW1GnniT28ub96Xh9LUdoSE5AvBXhp0Zs8LpmxRZP
 3ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345259; x=1768950059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ROGaE5FOqrZvsxIDkPsFAtK9dyn1pRnijFua0uxMqKc=;
 b=rzMnBiGpe7ttY5FRqu7hWcUk+VyMGnIepM0QGjARpbDbsK5wK0e93HX8uOz9da/1ZL
 HvsHloqBt/z5ycYAoW1htFd8MTcURtKqnhMgoLcnSDPqX62S9XdHroA+BbcO8fK1wqtS
 ucBLC+X01wEvvpvuU2Rmzhkx5aUDierXneNfqpJsiTwAvPP6+Lnc5z/AvfdhuwsUpnc2
 t6j32WuOCoDBkHqZgkqEF3BrI0wCljnt3dzUYcg0HaM0rwazdvTMShp/XdNI8mvLcZDg
 QfhdlplwhSBqe9uTW5b3ZchyY7xv8N6KAI8ngF/8+jauOTC/8dUBxb+81Xtp9eLkSZgf
 IKxg==
X-Gm-Message-State: AOJu0YxdLXLb/QXMos5tYAeiRzmNg8fzK16iai6QXuOfGuEKFnIN+DBv
 +Ae0B095NMLxqYpGWj178ykTJzU7fuub/0eY06Pv0sZ9a+R8QIGz0HZ+MnYjvqkHVyPJf9U4OG/
 F/YzD
X-Gm-Gg: AY/fxX42VqTLZHobkhedtUVai5dyqsslKkvr8tgTjQGCWj274AQ3G3vqhHpT3Dtog4B
 9/P/sLw5lst5mSMZGhz5EW7i1FJNvxMpB8euUGg4VtG2AoczDZuMJ4iUj7nb1vshm8m/388UMhZ
 PDGddCJ0FtnMKMCfaap/GyiM2rsUYdo9p9a41+F+oKwoLnBxW1p28kwbD+2KO6wVFXH9x/E7az6
 c8U0nvRimTVDjrY5bMT06ohGu5pUllS0fkM2gM5+GUQ3Z1KklQwTZ+uImM/4qZDJySqoyiIejw+
 HltlQy3cSrIuA8dAj4bpIhEEwUBuwHC7alFXREv9i85SC0IomqraKvS0DaPrXIe+9q2lUEnUuXh
 QqNp2WK3ty8Gtz4r7PJYnL3SBOjn0vMMr9NHdl6aMkChH5CgWFOeebPxGsMoIksrOAU/8SC8tYa
 w749VlHz4ZAFkrWY/nZRNSfZJjJcxpTPpWcRKHZKsuKyC6Gsg5uA==
X-Received: by 2002:a5d:5d13:0:b0:430:f272:3489 with SMTP id
 ffacd0b85a97d-4342d5be8b1mr118449f8f.28.1768345258570; 
 Tue, 13 Jan 2026 15:00:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:00:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/11] doc: programmers guide corrections
Date: Tue, 13 Jan 2026 14:51:02 -0800
Message-ID: <20260113230052.54435-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20240513155911.31872-1-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
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

This is a revision of earlier corrections to the programmers guide.
At this point, it is a collaborative work of myself (Stephen), the
technical writer (Nandini) and AI (Claude).

found while reviewing the DPDK programmer's guide documentation.

Types of corrections include:
- Grammar fixes (subject-verb agreement, articles, prepositions)
- Typos and spelling errors
- Function name corrections (cmdline_new_stdin -> cmdline_stdin_new)
- Type name corrections (cmdline_parse_t -> cmdline_parse_inst_t)
- Word errors (exasperate -> exacerbate)
- RST formatting issues (section hierarchy, underline lengths)
- Code formatting consistency (adding backticks around function names)
- Critical content fixes (restored missing "out" in "compiled out by default")
- Command syntax fixes (hugetlbfs mount command)
- Consistency improvements (capitalization, hyphenation, terminology)

Affected documentation:
- ethdev guide: extensive grammar and punctuation cleanup
- argparse library guide: articles, verb forms, typo fixes
- design guide: capitalization, terminology consistency
- Linux system requirements: mount command fix, spacing
- service cores guide: clarity improvements
- trace library guide: critical fix and grammar (2 patches)
- log library guide: spelling, sentence structure
- command-line library guide: function/type name corrections
- stack library guide: RST hierarchy fix, grammar
- RCU library guide: word errors, formatting, clarity

Stephen Hemminger (11):
  doc: correct grammar and punctuation errors in ethdev guide
  doc: correct grammar and typos in argparse library guide
  doc: correct grammar and typos in design guide
  doc: correct errors in Linux system requirements guide
  doc: correct grammar in service cores guide
  doc: correct grammar and errors in trace library guide
  doc: correct typos in log library guide
  doc: correct errors in command-line library guide
  doc: correct errors in trace library guide
  doc: correct errors in stack library guide
  doc: correct errors in RCU library guide

 doc/guides/contributing/design.rst      |  71 +++++-----
 doc/guides/linux_gsg/sys_reqs.rst       |  14 +-
 doc/guides/prog_guide/argparse_lib.rst  |  24 ++--
 doc/guides/prog_guide/cmdline.rst       |  42 +++---
 doc/guides/prog_guide/ethdev/ethdev.rst | 168 ++++++++++++------------
 doc/guides/prog_guide/log_lib.rst       |  32 ++---
 doc/guides/prog_guide/rcu_lib.rst       | 143 ++++++++++++--------
 doc/guides/prog_guide/service_cores.rst |  30 ++---
 doc/guides/prog_guide/stack_lib.rst     |  32 ++---
 doc/guides/prog_guide/trace_lib.rst     | 118 ++++++++---------
 10 files changed, 353 insertions(+), 321 deletions(-)

-- 
2.51.0

