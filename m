Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738F606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PvK4jrbD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 782E5402C4;
	Fri, 27 Nov 2026 19:44:15 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTPS id D7F70402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 19:44:13 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cd69954c755so6073984a12.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795805052;
 x=1796409852; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7+/48N93dVeeElupiQaqmJR7bj7623E5RURgSS/0BUs=;
 b=PvK4jrbDF4IxybVZ39o+g3EyTpriYzwIKBlJ/HBjIqaTku281FoaKlnXP5i/8w1tCx
 STZKx7VfjrpGf1k08zrYqZsLG3FZoTYb7ycq6cZBePREt2nVUy1c13myTorkeFgu8rQz
 Coa4sPxuz2PTC9degVw7sxUt+yNzyeTlt1oBxP/c+rgkisVhJLuxirRkkNwY+lvrD8j2
 aFmSlITYAPjEO7PtfWLZLATm9L4Ae5oCs1wdIQj6o++S+piCdsXciFkrlzN7y2eB9cWy
 NBAwbqTA+/JZfkyeg9hwLwq9qf2Az3Y+xUiYLmlORThUQd3sBTuoHwt6TKcorp8Xxga4
 guhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795805052; x=1796409852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7+/48N93dVeeElupiQaqmJR7bj7623E5RURgSS/0BUs=;
 b=EyBKhtwR7L3/6VVXApxB7BZ6EaNBZ/SDMpLYa8DQH5kZHTaybF20Cg8PXyVcKj2LG/
 I/lBlzPK0U5L/mxw9rby7N909oJZFYBzBsaDkGo+VZhoujTm9AKchxLMCY0EXiAAvc5U
 HheIWLywyUE8IG4WH04z0CC7qZJYtG1zHp4C7xQ15JnBW7FaPl7neK0WvU91MvQiX5ba
 XZSnF8+GlrkxJsVJid05EbQyWz7yHqT0UHGxqhbu0SbhoYoExwecSbDsv9chMgSeaswL
 y651kMVUdsiJXS6aTuny7ZiEzbjxNBkh69XBcZ8aZv01klsdUKm0qRnWDL2ZjnTYfZ8l
 gZBQ==
X-Gm-Message-State: APuU4Z+OgiPBpxwitmJdupJ5GM1OyOIK6siA7f1MNJnPeZrcy7NeUKB6
 UCrq0YJ1g7ghkVBdFAK6EcEwjErQqHOg5zU42CQ/9rt43xYyEac3GXvslIz1WJE4ZHY=
X-Gm-Gg: AZFdTZdGiiqaxi49b5fD2mwM1EIQLHhLogXgepKt/F5No5lDo4gLoBwGvk0z44DvJpj
 3J4p8HaKk2SKjBJISvad2AsNvZiHcadX7ro/BakkDesF7JvJYG1GLCIlHIJ0JaJO+0uAb6Cl9Fj
 VD9y+DqHmRk34HiyAWVAN1KcXok9yE/WnercUNIfK5dUyi8Y+JvAtixwwUVwgmsYkSFuCs5alO9
 I6Rf/bLw8T6EPNpTom8Rv68Sy0j9oYEIH7zDkzxXs/AZKAKwy+4e3U1ODII84HqgHG1dbwO2muH
 GT8i48ey31HwWO/PTO6lpTZv3FZKWOTKxhCJN8U3YlMHMzyd1QqTLO3xPK7/IyI0u17YgcEfux8
 iVv1FUnYIRqtgCb60ABsAUi40XGJX29x8VNuHkQ5mL6LAjChzh3TWhUV8f4s9X9x7kyBy07MTIe
 PFh1OCsYdfSQZHDPZyASYFHoq7osORt1eoKEOMzfwUFCgucZ8sC2KMeqAcgXsPSSYEb/yIg3PjB
 aSdlhS8mVlRja86Cgmm1DZcXfYIwYPdE5HkJM17NW84K9XTVUi51pz2+qrOGxcFTiSSyawty3ma
 c2GweO7TlGCL5qcK9dHpU3LvFTmfDdUCYzxZQo/C3L+7QgLKoL3LYXIDAJ+5vsXsc+VXB4k=
X-Received: by 2002:a05:6a20:430a:b0:3f9:bcb9:30f1 with SMTP id
 adf61e73a8af0-4014c3508ccmr29464701637.44.1795805052075; 
 Fri, 27 Nov 2026 10:44:12 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfec090sm13759358a12.14.2026.11.27.10.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:44:11 -0800 (PST)
Date: Fri, 27 Nov 2026 10:44:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 aman.deep.singh@intel.com
Subject: Re: [PATCH 0/4] move module EEPROM decoding to a transceiver library
Message-ID: <20261127104409.5580b294@phoenix.local>
In-Reply-To: <20261029181511.1736967-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261029181511.1736967-1-roma55592@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 20:15:07 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> This is the follow-up of the RFC, for 27.03.
> 
> The SFF module EEPROM decoders do not depend on any device or driver,
> and they are also useful for ports which are not ethdev ports, such as
> kernel ports read with the ethtool ioctls. This series moves them from
> ethdev to a new transceiver library with the rte_transceiver_decode()
> API. ethdev depends on the library for its telemetry command.
> 
> Changes since the RFC, as discussed with Thomas:
> - rte_eth_module_eeprom_parse(), added as experimental in 26.11,
>   is removed instead of being kept as a wrapper.
> - testpmd calls rte_transceiver_decode() directly.
> - The tests no longer depend on ethdev.
> - The ethdev guide links to the library guide instead of
>   duplicating the example.
> 
> The library name is still "transceiver", as it reads better than
> "xcvr". It can be renamed if preferred.
> 
> Release notes will be added when the 27.03 release notes exist.
> 
> The dpdk-proc-info module EEPROM decoding (series 39575) will be
> sent as a v2 on top of this series.
> 
> Tested with gcc, and clang with ASan and UBSan: every patch builds
> without warnings, transceiver_autotest passes, the documentation
> builds without warnings, and the testpmd command decodes a module.
> 
> RFC: https://mails.dpdk.org/archives/dev/2026-October/348542.html
> 
> Roman Khromenok (4):
>   transceiver: introduce module EEPROM decoding library
>   test/transceiver: move module EEPROM decoding tests
>   app/testpmd: decode module EEPROM with transceiver library
>   ethdev: remove module EEPROM decoding wrapper
> 
>  MAINTAINERS                                   |   7 +
>  app/test-pmd/config.c                         |   3 +-
>  app/test-pmd/meson.build                      |   2 +-
>  app/test/meson.build                          |   2 +-
>  ...dev_module_eeprom.c => test_transceiver.c} | 132 +++++++++---------
>  doc/api/doxy-api-index.md                     |   1 +
>  doc/api/doxy-api.conf.in                      |   1 +
>  doc/guides/prog_guide/ethdev/ethdev.rst       |  39 +-----
>  doc/guides/prog_guide/index.rst               |   1 +
>  doc/guides/prog_guide/transceiver_lib.rst     |  86 ++++++++++++
>  lib/ethdev/meson.build                        |   6 +-
>  lib/ethdev/rte_ethdev.c                       |  21 ---
>  lib/ethdev/rte_ethdev.h                       |  57 --------
>  lib/ethdev/sff_telemetry.c                    |  13 +-
>  lib/meson.build                               |   2 +
>  lib/transceiver/meson.build                   |  11 ++
>  lib/transceiver/rte_transceiver.c             |  24 ++++
>  lib/transceiver/rte_transceiver.h             | 102 ++++++++++++++
>  lib/{ethdev => transceiver}/sff_8079.c        |   2 +-
>  lib/{ethdev => transceiver}/sff_8472.c        |   0
>  lib/{ethdev => transceiver}/sff_8636.c        |   4 +-
>  lib/{ethdev => transceiver}/sff_8636.h        |   0
>  lib/{ethdev => transceiver}/sff_common.c      |  28 ++--
>  lib/{ethdev => transceiver}/sff_common.h      |  10 +-
>  24 files changed, 341 insertions(+), 213 deletions(-)
>  rename app/test/{test_ethdev_module_eeprom.c => test_transceiver.c} (83%)
>  create mode 100644 doc/guides/prog_guide/transceiver_lib.rst
>  create mode 100644 lib/transceiver/meson.build
>  create mode 100644 lib/transceiver/rte_transceiver.c
>  create mode 100644 lib/transceiver/rte_transceiver.h
>  rename lib/{ethdev => transceiver}/sff_8079.c (99%)
>  rename lib/{ethdev => transceiver}/sff_8472.c (100%)
>  rename lib/{ethdev => transceiver}/sff_8636.c (99%)
>  rename lib/{ethdev => transceiver}/sff_8636.h (100%)
>  rename lib/{ethdev => transceiver}/sff_common.c (95%)
>  rename lib/{ethdev => transceiver}/sff_common.h (96%)
> 

Needs rebase, and release note.
Something short like:


    * **Restructured module EEPROM transceiver support.**

      Module EEPROM decoding moved from ethdev to the new
      transceiver library, ``rte_eth_module_eeprom_parse()``
      is replaced by ``rte_transceiver_decode()``.
