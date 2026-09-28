Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A844FCA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4B95402F0;
	Mon, 28 Sep 2026 20:12:02 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id A47ED40275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:12:01 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc78d45f78fso1984812a12.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790619120;
 x=1791223920; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AvhOVkwf0ji2AphZiLIr4Aiw9XYjkP4AN+KmQHikOz0=;
 b=f8hmuVxglZBFTep58hEdNNp2TVODePJ9SgbuKAjxQfJ1zN/bXxdxcseqD3sYHBUHOu
 t9TIYsBMfEzuykooM6FxYxUeFjukgmWNrSdfgMiZScaa0OxlNae74ufSeNemGTF+UmMs
 egAwY08LCnDdPCpK0BYXavow5AVfXfmEpMrJhvY2mKlPvRUYpSjGRGF0CAXQKoZ4VJ0G
 HiOgH8L6c9KzghTrJdk7V04giXy8muujlQPV1jG4wysH1GWtVubkBKpH5ligsAs+ot2V
 GUO/ndWS7TWDvM0m4414/kB1o0iaasUrtGsHob7iJO0gRWj5yhi80YmMjfQqzK5kHY7O
 Eg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619120; x=1791223920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvhOVkwf0ji2AphZiLIr4Aiw9XYjkP4AN+KmQHikOz0=;
 b=wE7HDvAbIvzK0TUIZtYenWMObP/5BjB/VN2pzgpH/y12TXJPM3Ngs4OA/nIJh3uU2p
 EDu4GOwFjwKFbjoHhoYeCi2AlJscFXckozHEbHpxDBNZW6j4wmt5JHEkq/JsZkUKtguD
 p7v6+7Dbu0lRJ/FZ3DyJYUAftLmkDqeSjSbOwFTwoB1e/lz207240iFJHTK5P5qoStXY
 +E1B4Yv7uw0J6pgGacChbaNify8s6InQjimgAsirmcl5WsE1M/NHmUfz7olz5WgNufP9
 jSfnKH7XuwO68DwvJmoYBaf8mOKjhRRq2T+3YEHBJWl5hjZLrLA+G3d79MVUpipyhST0
 zgSw==
X-Gm-Message-State: AFq9FYK3oCRqM9L78WIVxv0NNGL63VVjhLOenzYIJaC1t1gafDIZ7E8c
 16iPvnEMA/6As5fXQF0QD8xQW+3op7FBdB4SwVU4Dew8pnQKpYyomElnwA+3o0SbKLQ=
X-Gm-Gg: AYBFou18owtiWV2rrr+qTwLGQB1QazEmrklrUZRNhwYUnaJGTd/XnpfzRKTQ+FL91Bl
 ZOSsnCfFJQEKIwY4ylC6zC+Aj6cKPcrRwgqvSwty+LPR2b/DS2eLVsySDj+H61I/rtHQ25VShi1
 iJGxztYEy1yvpnAp3QbZIIstCLo7/FCiGQEt9Dqmd3ysjC0lrtyXIwQNWlMJv94C8I3V9W0p8dX
 e2f1uglRebKxkwFi3aDeLWWLJCOcvT9/MocQ6YjoZWw6FV3FE0G+NKzA1o7uVeqUGrGuJg3faqP
 2Wyf0aB14mnqsjYL0cv4ZmWbgKESNGF7oD60jp7hFSk85jsNiQSMCEe1HdJBopftj9q4SLLmTL0
 dVcI+tzUiHN1Lppmd91rjbTPl46LFTD4UAujO4qstcy9L8LiJyj0KiGObw1wrrlvkUDSzIONdjY
 AgqlN71Pm2l+OhF+6bhAHbS6w43ibE0HJ9yaOOMrQ00AmW2NV6rAF3V/yAQ7KeXqX5htjbH9lqQ
 2dJZAOVTq0qEAHE7qhDHDj3CeF+1x46j16jl6Pd
X-Received: by 2002:a17:903:f87:b0:2df:ab58:5491 with SMTP id
 d9443c01a7336-2dfab58577fmr58706975ad.6.1790619120510; 
 Mon, 28 Sep 2026 11:12:00 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df913dd8d2sm46410875ad.20.2026.09.28.11.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:12:00 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:11:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 0/4] ethdev: add API to decode module EEPROM
Message-ID: <20260928111158.0332d3d3@phoenix.local>
In-Reply-To: <20260928084729.973192-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260928084729.973192-1-roma55592@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 28 Sep 2026 10:47:25 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Since 22.07, ethdev contains SFF-8079, SFF-8472 and SFF-8636 decoders
> for plugin module EEPROM (SFP, QSFP), ported from ethtool.
> They are reachable only through the telemetry command
> /ethdev/module_eeprom, which reads the EEPROM of a DPDK port
> and returns the result as a telemetry dictionary.
> 
> An application which needs to show transceiver information
> (vendor, part number, serial number, optical power) in its own
> interface cannot reuse this code and has to duplicate it.
> It is also common to have some ports managed by DPDK and others
> by the Linux kernel; the kernel returns the EEPROM through the ethtool
> interface with the same module types and layout, but there is no way
> to decode it with DPDK.
> 
> This series exposes the decoders through a small experimental function:
> 
>   int rte_eth_module_eeprom_parse(uint32_t type,
>           const uint8_t *data, uint32_t length,
>           rte_eth_module_eeprom_field_cb cb, void *arg);
> 
> Each decoded field is reported to the callback as a pair of strings,
> the same names and values as in the telemetry output.
> The function does not access any device and does not require
> EAL initialization.
> 
> Patch 1 makes the decoders write to a callback instead of
> the telemetry dictionary; the telemetry output is unchanged.
> Patch 2 adds the buffer length checks needed by a public API:
> currently SFF-8079 and SFF-8472 decoders do not receive the length.
> Patch 3 adds the API with documentation and release notes.
> Patch 4 adds unit tests.
> 
> v2:
> - patch 2: do not read the SFF-8636 alarm and warning thresholds
>   from page 03h when only 256 bytes are available (out of bounds read
>   found by ASan in the new unit test).
> 
> Roman Khromenok (4):
>   ethdev: decouple SFF module EEPROM decoders from telemetry
>   ethdev: check module EEPROM length before decoding
>   ethdev: add API to decode module EEPROM
>   test: add ethdev module EEPROM decoding tests
> 
>  .mailmap                                |   1 +
>  app/test/meson.build                    |   1 +
>  app/test/test_ethdev_module_eeprom.c    | 285 ++++++++++++++++++++++++
>  doc/guides/prog_guide/ethdev/ethdev.rst |  44 ++++
>  doc/guides/rel_notes/release_26_11.rst  |   7 +
>  lib/ethdev/rte_ethdev.c                 |  20 ++
>  lib/ethdev/rte_ethdev.h                 |  50 +++++
>  lib/ethdev/sff_8079.c                   |  20 +-
>  lib/ethdev/sff_8472.c                   |   2 +-
>  lib/ethdev/sff_8636.c                   |  74 +++---
>  lib/ethdev/sff_common.c                 |  14 +-
>  lib/ethdev/sff_common.h                 |  14 +-
>  lib/ethdev/sff_telemetry.c              |  94 +++++---
>  lib/ethdev/sff_telemetry.h              |  25 ++-
>  14 files changed, 552 insertions(+), 99 deletions(-)
>  create mode 100644 app/test/test_ethdev_module_eeprom.c
> 


AI review had good point that bugfix should be first patch and cc to stable

Review: [PATCH v2 0/4] ethdev: module EEPROM decoding API

Each commit builds with -Dwerror=true, and ethdev_module_eeprom
passes.

Patch 2 is a real bug fix, not just preparation. Before this series,
sff_8636_dom_parse() reads the page 03h thresholds (0x200-0x247)
unconditionally, while the telemetry handler allocates exactly
minfo.eeprom_len. Several in-tree drivers report less than 640
bytes for QSFP modules: i40e reports QSFP+ as SFF-8436 with 256,
bnxt reports flat memory QSFP28 with 256, xsc reports 256 or 512.
/ethdev/module_eeprom on those ports reads past the end of the heap
buffer. This has been present since 22.07.

Please make the fix the first patch, standalone against the current
rte_tel_data code, so it can go to stable:

  Fixes: c42754fd581a ("ethdev: support SFF-8636 module telemetry")
  Cc: stable@dpdk.org

The commit message should say what it fixes (heap over-read in the
telemetry handler) rather than describe it as preparation. The
sff_output refactor and the new API then go on top.


Patch 1/4 ethdev: decouple SFF module EEPROM decoders from telemetry

Info
- struct sff_output, and after patch 2 sff_decode_module_eeprom(),
  are no longer telemetry specific but still live in
  sff_telemetry.[ch]. Every decoder still calls
  ssf_add_dict_string(), a misspelled telemetry name for what is now
  a one line callback dispatch. This patch already touches every
  signature; consider renaming it (e.g. sff_output_field()) and
  moving the generic parts to sff_common.h.


Patch 2/4 ethdev: check module EEPROM length before decoding

Warning
- Missing Fixes: and Cc: stable@dpdk.org, and it depends on the
  sff_output refactor in patch 1, so it cannot be backported as is.
  See summary above.


Patch 3/4 ethdev: add API to decode module EEPROM

Warning
- A2_OFFSET_TO_RXPWRx() in sff_8472.c casts the byte buffer to
  const uint32_t * and befloattoh() dereferences it. The RXPWR
  calibration offsets are 4-byte aligned relative to data, so this
  only worked because the telemetry buffer comes from calloc(). The
  new API accepts any const uint8_t * from the application; a
  misaligned buffer makes this an unaligned load (UB, UBSan reports
  it, traps on strict alignment targets). Reached when the module
  sets the externally calibrated bit (byte 92, bit 4). Read with
  memcpy() into a uint32_t, then rte_be_to_cpu_32().

Info
- The field names and value strings become the de facto API. The
  test in patch 4 already pins "Rcvr signal avg optical
  power(Channel 1)", missing space included, so fixing that later
  breaks applications that match on names. Either clean up the
  names before exposing them, or state in the doxygen that names
  and value formats are for display only and may change.
  Applications wanting numeric values (RX power, temperature) must
  parse "0.6724 mW / -1.72 dBm"; worth considering while the API is
  still experimental. A void callback also gives the caller no way
  to stop early.

- The doxygen documents the SFF-8472 length rule but not the
  SFF-8636 one: thresholds and alarm flags are decoded only when
  length == RTE_ETH_MODULE_SFF_8636_MAX_LEN exactly. With an
  application supplied buffer, an oversized length silently drops
  them. Use >= and document it next to the SFF-8472 note.

- ethdev.rst and the release note say Linux ethtool data uses the
  same types and layout. That holds for the ETHTOOL_GMODULEINFO /
  ETHTOOL_GMODULEEEPROM ioctls. The netlink MODULE_EEPROM_GET
  interface is page addressed and carries no module type, so its
  data must be reassembled first. Name the ioctl.

- "Plugin module" in the doc heading and release note; the usual
  term is "pluggable module".


Patch 4/4 test: add ethdev module EEPROM decoding tests

Info
- No case covers SFF-8636 with 640 bytes and paging present (byte 2
  bit 2 clear), which is the path patch 2 changes. Add one checking
  "Alarm/warning flags implemented" is "Yes" and a threshold field
  is decoded.

- The test is registered as ethdev_module_eeprom; nearly all fast
  tests use the _autotest suffix.
