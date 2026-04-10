Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15AF45A0C
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 20:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EEB74026C;
	Fri, 10 Apr 2026 22:15:53 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id D2120400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 22:15:51 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-483487335c2so26529435e9.2
 for <dev@dpdk.org>; Fri, 10 Apr 2026 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1775852151; x=1776456951; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iYdSzIWC1YajZOqgDJyolmQ8bVk0wtK/A2WWmVHQQYc=;
 b=j35OK7IlGm5yn3abKQn8ysk46Srh/CaHU5Dh7NLWurSnsePVg+sbYQOWs8Tp2P0IoO
 wb71aRTXYnXwoIzaInKbYs8k0rCEw7h3tF/4en1HGEaDbUDEN9uTgKzHX8fMbUQPv6sI
 gkeYyBca0vlzNjehr7ySQCk0c4sXpZtiLymadnTyKTPhJdAMhlA5XTvgEe+Fdo102pWD
 c1yRRTewpIixlUbPY/VxpZiiDIQyi5/yLIT0aQ5t8RosSDV/2oUXbIHmfu7RApaq9DPQ
 Vz3nlu0Tqd9Z/jDUkrdOpf4VCD8TSRG+1yUC1652z9QFuKw2+wyZediTxoHHO+4blgTf
 H+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775852151; x=1776456951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYdSzIWC1YajZOqgDJyolmQ8bVk0wtK/A2WWmVHQQYc=;
 b=pYy8fLOojTMI6stkcUbADrWSoxVZV8PYGrSrdjg6Fy4QT96mPUsX9d/5U65J4B4ipu
 /MhhXkOYKsr1z1v6OEg9IA6aLWe3QePPyqHYfuElysKEpCXknG44XORixSN3yF5Ol/M3
 lwph985gYQqip2b/ktDO6rI+3hKwwlTAvY5Ma98uKJThTfVmZEUyV/Bd95wM0YT6d3o5
 ENam0JV46Px+g75ciIdgH/bOFUr3bYaLnrpVa0AfgnWPNJxLcJ8b+qvmETCjMX2ft/p2
 Y7/j7kSBh4mczeYuoWCnonlcTHw5hsbKzosEeXoKdtTJjFbdWIZTcRqn69e7SiVblZj1
 /KYA==
X-Gm-Message-State: AOJu0YzXOcAT3ilDLSv2pLOp2CF8wsxSXOXHIhN/ejdKFDhq8Kqe+8m0
 wmsJGhMHCXrDIr2PONo3o8zWvS5vILgZ25ZdgWmg6OZk6nAkDLy+HXTc1iP9FSLes4Q=
X-Gm-Gg: AeBDieswCqGU8JgiIYnVauPy1jjN1ijLQ1s89lS8eE2w/YLtRWRFTGZ/yBmvhjKw7mV
 /Yek5P+zsLBVMh2H9AjwH5LNgvA8AHuviQ0Bqxt63OgtQNXjFWP0LevouOkG74K5iCRD2fhtZ68
 05u10mSgRgmWu+/hsPn97u4L6OmpRcNNA9u756abZb/So7UUYUngKtWZsQczAxm2mr2KvnjBnhR
 h3Imtq/rmfojJiNxpZx+d4ElODfBn/IsbbU4iEee5wB34GcxzztRM6YFmHwsZlDuwWxE3hTFMkp
 vKituJ3itbPyS7rKp2v/02rArYsI/1vIcI8ZPWfpjbe2Yy3ShdE5MyxQakPvuGv9yAWy6j2/Ybm
 /wThKMdQAG7Pk9EnYc1HbXfGb5QPmD0Xawrh+NRZo4CJU7WLE4YcPypcK0lqW4/naH96xU82S4f
 r8AS+3c2WBh5Rjn3r/JGbbiFfrnuYhTi46V7C38Pta3BcDf1lYYcucz+ZgOJrvJQg=
X-Received: by 2002:a05:600c:8b6b:b0:488:be21:54b9 with SMTP id
 5b1f17b1804b1-488d67ce792mr61496555e9.8.1775852150887; 
 Fri, 10 Apr 2026 13:15:50 -0700 (PDT)
Received: from dpdk-test6.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm26044405e9.24.2026.04.10.13.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 13:15:50 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: orika@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v11 0/6] flow_parser: add shared parser library
Date: Fri, 10 Apr 2026 22:15:38 +0200
Message-ID: <cover.1775850858.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
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

This series extracts the testpmd flow CLI parser into a reusable library,
enabling external applications to parse rte_flow rules using testpmd syntax.

Motivation
----------
External applications like Suricata IDS [1] need to express hardware filtering
rules in a consistent, human-readable format. Rather than inventing custom
syntax, reusing testpmd's well-tested flow grammar provides immediate
compatibility with existing documentation and user knowledge.

Note: This library provides only one way to create rte_flow structures.
Applications can also construct rte_flow_attr, rte_flow_item[], and
rte_flow_action[] directly in C code.

Design
------
The library (librte_flow_parser) exposes the following APIs:
- rte_flow_parser_parse_attr_str(): Parse attributes only
- rte_flow_parser_parse_pattern_str(): Parse patterns only
- rte_flow_parser_parse_actions_str(): Parse actions only

Testpmd is updated to use the library, ensuring a single
maintained parser implementation.

Testing and Demo
-------
- Functional tests in dpdk-test
- Example application: examples/flow_parsing

Changes
-------
v11:
- targetting 26.07 now
- MAJOR overhaul of the patch set to make every part of the library API public
  and reusable, while only parsing flow testpmd commands.
- library splitted into a "simple" part and "cmdline" part
- testpmd changed to use the "cmdline" part of the library, and also to handle
  most of the "set" commands itself, while still using the library to parse 
  the parameters of the "set" commands. Previous "operation callbacks" are now
  replaced by command-codes (enum) and the caller is expected to handle 
  the command execution itself. Likewise, the ownership of helper structures,
  e.g. for vxlan/raw/sample etc. is in the hands of the caller, and the library
  only uses/fills them in with the parsed parameters.

v10:
- rebased to avoid Github Actions CI build failure
- merge conflict solved in rel_notes/release_26_03.rst
- release notes shortened

v9:
- removed extra new line from the flow parser docs file

v8:
- rte_port/queue_id_t typedefs removal to be included in a separate patch series
- move of accidental changes of rte_flow parser library from the testpmd commit
- DynaNIC copyright name update

v7:
- Fixed implicit integer comparison (while (left) -> while (left != 0))
- NULL checks fixed
- arpa header removed for Windows compatibility
- minor comments from the last review addressed

v6:
- Inconsistent Experimental API Version adjusted
- Fixes Tag added to MSVC build commit
- Non-Standard Header Guards updated
- Implicit Pointer Comparison and Return Type issues addressed in many places
- commit message in patch 6 updated

v5:
- removed/replaced (f)printf code from the library 
- reverted back to exporting the internal/private API as it is needed by
  testpmd and cannot be easily split further.
- adjusted length of certain lines
- marking port/queue id typedef as experimental
- updated release rel_notes
- copyeright adjustments

v4:
- ethdev changes in separate commit
- library's public API only exposes attribute, pattern and action parsing,
  while the full command parsing is kept internal for testpmd usage only.
- Addressed Stephen's comments from V3
- dpdk-test now have tests focused on public and internal library functions

v3:
- Add more functional tests
- More concise MAINTAINERS updates
- Updated license headers
- A thing to note: When playing with flow commands, I figured, some may use
  non-flow commands, such as raw decap/encap, policy meter and others.
  Flow parser library itself now supports `set` command to set e.g. the decap/
  encap parameters, as the flow syntax only supports defining the index of the
  encap/decap configs. The library, however, does not support e.g. `create`
  command to create policy meters, as that is just an ID and it can be created
  separately using rte_meter APIs.

[1] https://github.com/OISF/suricata/pull/13950

Lukas Sismis (6):
  cmdline: include stddef.h for MSVC compatibility
  ethdev: add RSS type helper APIs
  ethdev: add flow parser library
  app/testpmd: use flow parser from ethdev
  examples/flow_parsing: add flow parser demo
  test: add flow parser functional tests

 MAINTAINERS                                   |     6 +-
 app/test-pmd/cmd_flex_item.c                  |    47 +-
 app/test-pmd/cmdline.c                        |   249 +-
 app/test-pmd/config.c                         |   115 +-
 app/test-pmd/flow_parser.c                    |   288 +
 app/test-pmd/flow_parser_cli.c                |   479 +
 app/test-pmd/meson.build                      |     3 +-
 app/test-pmd/testpmd.h                        |   135 +-
 app/test/meson.build                          |     2 +
 app/test/test_ethdev_api.c                    |    56 +
 app/test/test_flow_parser.c                   |   791 +
 app/test/test_flow_parser_simple.c            |   445 +
 doc/api/doxy-api-index.md                     |     2 +
 doc/guides/prog_guide/flow_parser_lib.rst     |    99 +
 doc/guides/prog_guide/index.rst               |     1 +
 doc/guides/rel_notes/release_26_07.rst        |    11 +
 doc/guides/sample_app_ug/flow_parsing.rst     |    60 +
 doc/guides/sample_app_ug/index.rst            |     1 +
 examples/flow_parsing/main.c                  |   409 +
 examples/flow_parsing/meson.build             |     8 +
 examples/meson.build                          |     1 +
 lib/cmdline/cmdline_parse.h                   |     2 +
 lib/ethdev/meson.build                        |     5 +-
 lib/ethdev/rte_ethdev.c                       |   109 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 .../ethdev/rte_flow_parser.c                  | 12250 ++++++++--------
 lib/ethdev/rte_flow_parser.h                  |   130 +
 lib/ethdev/rte_flow_parser_cmdline.h          |   739 +
 lib/meson.build                               |     2 +-
 29 files changed, 9936 insertions(+), 6569 deletions(-)
 create mode 100644 app/test-pmd/flow_parser.c
 create mode 100644 app/test-pmd/flow_parser_cli.c
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 app/test/test_flow_parser_simple.c
 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
 create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build
 rename app/test-pmd/cmdline_flow.c => lib/ethdev/rte_flow_parser.c (59%)
 create mode 100644 lib/ethdev/rte_flow_parser.h
 create mode 100644 lib/ethdev/rte_flow_parser_cmdline.h

-- 
2.43.7

