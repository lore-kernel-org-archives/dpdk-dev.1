Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D0FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 18:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C5540616;
	Tue,  5 May 2026 20:39:23 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 5E37740275
 for <dev@dpdk.org>; Tue,  5 May 2026 20:39:22 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so98032f8f.0
 for <dev@dpdk.org>; Tue, 05 May 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1778006362; x=1778611162; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w73a1zOxCHMSHjV7h7trjXXEg1Gyqtgpah9GsnVizBk=;
 b=nG8tatZGH8jOX1LZc8abDoFnxorWU/+0JGsdylnl0o7XPqi6GpV6KsA6xREsJcMQDn
 mMOdQJz1gbJTdbFKXN3SucyXSFTicqt879vje3KHRj4wszVolMKKnTje2giCkxtIhlDp
 ljHx4qDw/pjSLAzNu9EpqHiMrYeEG1h6BGpqQjRkBf9rip1lxAguevxHyJj0ZUbDaPX9
 2pZFpTgFNRSbs1OCJDxoBQ0n3TbqoHsPSP7LXS2X24W/zJS9Xlqr8m73kUqbkIv1WycV
 M1sI1z2BEx5k8nc0JmIA2YOXrv51taFq85s+d+w8jEf7XOTRRefQ1mvON7VocVs7GHxY
 qscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006362; x=1778611162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w73a1zOxCHMSHjV7h7trjXXEg1Gyqtgpah9GsnVizBk=;
 b=HVyR44FKevkVjGdfbZJ7rrfA3rglRaTu2rFqzfIjxcku/VVkmOOwYwqyte/Puwk6oI
 EkPpVQarSLfZKLDeyclG+c6nzUDRZaNNEVzOCZYdmVmH9i7fEzLXThoUsq+rDGAUvTNr
 s6Q8JsloPtD+7BRk2Qm0wdr7ehMW4+y+FfCWTUikUUQ1dDxBFghjEiZj60Wc1tmDZYIq
 iY9cUI9AnRZxgrNrJWqhDIi5fYNy6+obqHIQLBbdNS12ILrzixM7rv/OYYQ8Ox9Nts+z
 atcB6E07ChlQyGy78vtg9z19C4Mnnyfb7ZHZDv3+u8oGWOnj2CK4sCWib9YmPwcTCKRq
 5skQ==
X-Gm-Message-State: AOJu0Yy02G9vqn5QT2TFQb7d4xJSAviHAYbs6l5h/zZCVkA5r+b1qXjm
 wrjGdIzNu5eoHc7nIEd3YfFcO8MYOYeNVM4dDpCV5i0xR+cS1q3ebNyATalyvVmaifgzOpK2yO4
 ztxCY
X-Gm-Gg: AeBDiev/SA8aKd+2bSOL9EKhQA5DG6q9a8au8tweItrDT39R9D0xcgqNbDqbwtmq8eF
 BEFOr+zM05+d5++p/7rhaP2ck9xBggIFaG+Nir1uo6GWgct9M5n81T8RlHYHZvtDBs7XtuAZJlT
 t9nk7lZyY9xoahsHxJnGhpIjwpRKUpV8Fgc2SkrYTE5LgxAj7PLkQfNQI+qw/UxyDD0lLKvGlRx
 e951eqF4a8bVL7iHv5kqXdcD40KVqZGXr40u5IMtPj/6WWNjmm1+83LXTq/z0id9YwPk87zWrvI
 HhXgrV1CgDlEtBdOf1eucjdY0S/Q6YAgy665yAcgaSpcK1seIUSFpqScFkyodQWwGjWvDwJn7HU
 H9/ly0rg1tK1Uw0gc2Zhw/3VCv/8nKDQW4763GmdJGyiIbW4QdCqhYRu2lbIyXiYNVHJJ9lU4F+
 1gXI70OtHQDKmLw2ZwC3q+DOm1XzA/1CAvFfFgU+sAIUYcOKDX0Gubn60BG83isXRhTZB7NFmi7
 hOczQVMc8ri
X-Received: by 2002:a05:6000:4553:b0:44f:9665:4c25 with SMTP id
 ffacd0b85a97d-44fde69a20emr6093332f8f.21.1778006361572; 
 Tue, 05 May 2026 11:39:21 -0700 (PDT)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02abbsm6197067f8f.18.2026.05.05.11.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:39:21 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v12 0/6] flow_parser: add shared parser library
Date: Tue,  5 May 2026 20:39:07 +0200
Message-ID: <20260505183917.370281-1-sismis@dyna-nic.com>
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
v12:
- flipped the ethdev dependency on cmdline, now cmdline depends on ethdev
- added Bruce's ACK from v11 to the MSVC commit

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
 app/test-pmd/flow_parser_cli.c                |   478 +
 app/test-pmd/meson.build                      |     3 +-
 app/test-pmd/testpmd.h                        |   135 +-
 app/test/meson.build                          |     2 +
 app/test/test_ethdev_api.c                    |    56 +
 app/test/test_flow_parser.c                   |   790 +
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
 lib/cmdline/meson.build                       |     8 +-
 lib/cmdline/rte_flow_parser_cmdline.c         |   138 +
 lib/cmdline/rte_flow_parser_cmdline.h         |    82 +
 lib/ethdev/meson.build                        |     3 +
 lib/ethdev/rte_ethdev.c                       |   109 +
 lib/ethdev/rte_ethdev.h                       |    60 +
 .../ethdev/rte_flow_parser.c                  | 12350 ++++++++--------
 lib/ethdev/rte_flow_parser.h                  |   130 +
 lib/ethdev/rte_flow_parser_config.h           |   583 +
 lib/ethdev/rte_flow_parser_internal.h         |   124 +
 lib/meson.build                               |     4 +-
 33 files changed, 10157 insertions(+), 6642 deletions(-)
 create mode 100644 app/test-pmd/flow_parser.c
 create mode 100644 app/test-pmd/flow_parser_cli.c
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 app/test/test_flow_parser_simple.c
 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
 create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build
 create mode 100644 lib/cmdline/rte_flow_parser_cmdline.c
 create mode 100644 lib/cmdline/rte_flow_parser_cmdline.h
 rename app/test-pmd/cmdline_flow.c => lib/ethdev/rte_flow_parser.c (59%)
 create mode 100644 lib/ethdev/rte_flow_parser.h
 create mode 100644 lib/ethdev/rte_flow_parser_config.h
 create mode 100644 lib/ethdev/rte_flow_parser_internal.h

-- 
2.43.7

