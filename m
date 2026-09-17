Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBDC982D8
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D656B427B2;
	Thu, 17 Sep 2026 16:36:32 +0200 (CEST)
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99]) by mails.dpdk.org (Postfix) with ESMTP id 5F4CE4278B
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:32 +0200 (CEST)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a64c7cdb46so1567272a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655792; x=1790260592; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDapr9N/Uz7Zc4yKsn+q3gfAMF6lfGULMVoh/ISU5bQ=;
 b=re08UoiW01m860QbA2jNmp1gN/zK3ZNYCp0FHfDdyBtkCFc9W0Tn4sZ7SkkfAygvL3
 Fl14gUISOjVNtVK6GpcjaLsS/Dpv3XLhLcQTAYfIMuQPDJr3ZNCWkDnHRBkQAPQO0H2O
 gpgpJWj7wdS36nRM95NBEazsUfWeqohFnigPpMlWcf564WozoggRUt5bkapCc+0fRcm7
 rb29jeHUQLCd/3smEqBXH4ep2nQx2APmBSne0ktXVHggjyIaFMykeUYeYrDZa7T7KYP4
 9LsweG3pCRl5jQLj8RCvuWJ8V7gY/OOtwa62jVpGraSB5+OCRD2l4Xy99JabmAL29j6P
 1c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655792; x=1790260592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDapr9N/Uz7Zc4yKsn+q3gfAMF6lfGULMVoh/ISU5bQ=;
 b=n/4FPX/sNZgA2PzrkiN8oPkD5kjLJszBUC+pTlohfj0qJvCWWdqyjC0JE91HKqlj1H
 F2z3ULvXQqDcs717lYDjvBhaASCaf544pfVNul3EXqL6eP3y5HDI70KhqH82ycVbRQ5O
 MQhg2h0mu37bZdDfI3Ovjmr9PzpWZBuYvqNZWes9Hq0t0mAZOTDq4ou4LCffQHHVSS/D
 uaTx8aDUEFsQtl1bpTJ1Q1Wi4zIFVnxb5oepz0rhdbQJvnAKJVb5NWl+etfw2sGyax+z
 9uu1rlA14GUd0rjSzFTNZqKEg4qXKNu3oq0O/nHUGGDtWcFDhQCYl1EF7rO+kaHKsnSj
 sJ4g==
X-Gm-Message-State: AFuF++kVIs2DP1nKyoT3eaBc5DOgfKA0l2yj/N7CcUuscEfKTOU4yZc+
 noVvRLGSVtcmm6pGiiIgXecLT5f3/gOh5eqqn///VowAW+GZV5z0vzL+0+kRbQuHlCg=
X-Gm-Gg: AYBFou3dxJfTu6VPiYRcKTSul7u+8fS8xwrI17oSkpmBLI0+izITShNFfgTYa8kG5J/
 wh80rQaaol6DfTAZcTx3vf40dF+Nwk+9TTUbb1wJchyU1LR2ZtmN4FTEt7h4dMt/L9sibYc6uw0
 +/2DTScAgvBXCn3l2vXV9BzQX5t2na0FoeBXYb7ZY40rXrY7FHA3TlrPg6HSm/Zl2ULLtiz4mPV
 M5cUiWo0l5qMpY3H6VSDBVe4V1j0r51Ghb2BQTj3vz3rYDRE/V4xEi19Jaz10jDXfokWSPABAi+
 dzg+P6EhDwoCRjQftz1q956vz0OaQk9uwAmF7jFd3/4pmHxvArFknYlRcuKn8haXi+AwPWrulRH
 nyQhTkMpBkfAYMPYVYS0qm4Fd1tf0c6vmymRh8pdgKEKDzjpY727Cfwx/S74m0+Dqmhr8DfEMLi
 lcDEVNDTCD8BlT/tQkzg1vXIB0Y+IIXKuQH8NLtaOwv7vD6eWuXwdQJ2Ycl34=
X-Received: by 2002:a05:6402:3205:b0:6a7:ea53:f61a with SMTP id
 4fb4d7f45d1cf-6aa2240fa64mr5283211a12.25.1789655791577; 
 Thu, 17 Sep 2026 07:36:31 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:30 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: 
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v4 0/7] validate-bpf: add standalone validation debug tool
Date: Thu, 17 Sep 2026 14:35:30 +0000
Message-ID: <20260917143539.46951-1-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915192626.48125-1-marat.khalili@huawei.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
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

This patchset introduces a new standalone tool for pre-validating eBPF
programs and debugging validation problems. Its should allow developers
to trace validator state changes per instruction and understand verifier
decisions, simplifying the debugging of rejected programs before loading
them into a real application context.

v4:
* addressed reviewer feedback from Konstantin Ananyev:
  * changed variable and array names to lowercase to follow conventions;
  * replaced strtoull()/strtoumax() with strtoul() and removed redundant
    SIZE_MAX checks;
  * changed return types of point_infos_destroy_* functions to void;
  * replaced %jd and (intmax_t) cast with PRId32 when printing frame
    offsets;
  * refactored the inverted loop in print_frame() for clarity;
  * replaced return -ENOMEM with RTE_VERIFY() for allocations in debug.c
    print functions;
  * simplified token matching logic in parse_decl.c by using strncmp().

v3:
* addressed another FreeBSD issue (spurious uninitialized warning);
* addressed more AI comments:
  * fail if library fails to set step catchpoint on start command;
  * fail nicer if external variables are too big;
  * fail nicer if EAL initialization or cleanup fails;
  * explain why 9 steps are expeced in the test;
  * explain that non-zero buf_size marks mbuf;
  * avoid symbols starting with `RTE_` in the app;

v2:
* for FreeBSD compatibility switched from Linux to DPDK network structs;
* addressed small AI comments:
  * clarified patch 1 commit message;
  * renamed `rte_validate_bpf_logtype` to `validate_bpf_logtype`;
  * corrected comment to an internal-use-only function to reflect that
    next-after-last value of the program counter is no longer allowed;

Marat Khalili (7):
  bpf/validate: fix finished status on restart
  bpf/validate: refactor internal step function
  bpf/validate: formalize call back requirements
  bpf/validate: add jump notification events
  bpf/validate: add get current event API
  app/test: add test for bpf validate debug events
  app/validate-bpf: add BPF validation application

 MAINTAINERS                            |    2 +
 app/meson.build                        |    1 +
 app/test/test_bpf_validate.c           |  344 +++++++-
 app/validate-bpf/alloc_list.c          |   53 ++
 app/validate-bpf/args.c                |  262 ++++++
 app/validate-bpf/debug.c               | 1087 ++++++++++++++++++++++++
 app/validate-bpf/debug_command.c       |  383 +++++++++
 app/validate-bpf/debug_command.h       |   65 ++
 app/validate-bpf/eal_init_args.c       |   57 ++
 app/validate-bpf/internal.h            |  151 ++++
 app/validate-bpf/main.c                |   90 ++
 app/validate-bpf/meson.build           |   13 +
 app/validate-bpf/parse_decl.c          |  616 ++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |    5 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/validate_bpf.rst      |   97 +++
 lib/bpf/bpf_validate.c                 |   49 +-
 lib/bpf/bpf_validate_debug.c           |   92 +-
 lib/bpf/bpf_validate_debug.h           |   12 +-
 lib/bpf/rte_bpf_validate_debug.h       |   42 +-
 20 files changed, 3356 insertions(+), 66 deletions(-)
 create mode 100644 app/validate-bpf/alloc_list.c
 create mode 100644 app/validate-bpf/args.c
 create mode 100644 app/validate-bpf/debug.c
 create mode 100644 app/validate-bpf/debug_command.c
 create mode 100644 app/validate-bpf/debug_command.h
 create mode 100644 app/validate-bpf/eal_init_args.c
 create mode 100644 app/validate-bpf/internal.h
 create mode 100644 app/validate-bpf/main.c
 create mode 100644 app/validate-bpf/meson.build
 create mode 100644 app/validate-bpf/parse_decl.c
 create mode 100644 doc/guides/tools/validate_bpf.rst

-- 
2.43.0

