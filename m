Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719DFCCA490
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 22:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5F5D4027D;
	Sat, 17 Oct 2026 00:32:06 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 067DA4003C
 for <dev@dpdk.org>; Sat, 17 Oct 2026 00:32:05 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ac5b090d16so324610a91.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792189924;
 x=1792794724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mwAd8RqBs+AgUAMMEmvk+nYv1zvE5c2o5iuWRF1QGHE=;
 b=tx4WVKIxbGgRRupzcsvjbb74SHQg2fzb3JxVgqpYN+pqDXMTGAv0VsF1LCZshTGVAr
 eyAQu44/sgLoQ7fL9/vXWjO1k4rUlMMskMEVYlZLZqLvzBlmZail6+Rxg96fYzNp6BTP
 ARdBYUiDdENztQ0fPU2TIHgpl9Lh9KjDgCxrkrhD83VO3Veb9EClXEeGwh94uH5geZvp
 AWzCgBgrYBqXwxQX0RAYBtIyjend7O7Aep8ddA5Y0gri4HEp7qJYX1fisH5sBaW1vXx+
 u1xBYEGUr/MFS2/QGlD+0/QIx/OLXdRgWnYPuv/8RTEQLt78xoR4MAedml6NXfafGqmP
 s6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792189924; x=1792794724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mwAd8RqBs+AgUAMMEmvk+nYv1zvE5c2o5iuWRF1QGHE=;
 b=O7VYpgcnKiG/BApU89lisKRGNiIT9vN3Duufepd+IjsypWMlCwqutTN2qbjf1TQx9x
 9MM5uJw54BMvwPBsT0zggFxYBPX9OK4NcUjxCyPky+gg0Fmo2oUcfnxy+Hx9JpVS+ysw
 BgcGdf/5sd87AbZrvUVi9ZBRHD7Cw8n3JIJCNFTRsnYirE3N7SN89uGF69DRoffz2Qfp
 OtmKKipEprpSd3o5WkdMdJP5KZcqueoc1ucHmNIwy9kjxerZ3xOnZDwoG3m5t4njRcz2
 04V3g089GtQX5xZTPIBK/TKJvsK/77fUxKh3jRBgq1NVS3pGLRuR6xC0sROhYnSkO/cV
 tu/Q==
X-Gm-Message-State: AFq9FYKNvkAXLgZeoVaDyOji5gjtNM4cla2gdacKQadJI9HXkAFv51yp
 k5beHgMkdfmjhrOswwHDMiwP9vKEmDCZncOhSpPv4DCMfxxQukhC0YbhA/P9PGGEY+CQHDqCveJ
 OPsUV
X-Gm-Gg: AYBFou2q3wpNdMkFpchpAlc12piqlR8JE7PWRle3eA3xFHSZ8eJsEE6yFVvP0YZS8vR
 ltrROZnayPBQPx9OW8LkisCfyC8YQ6TWikgqg0VgjWV6FGP4dL7SBTaDG3O4lQQGVNKwZTlbqxL
 JTtqi/y5NQowoI08PhSbBhDVpzX+wVex/A9O5EvDhY/okKu+AmgTNExZV5JjhyERcajGwlk5+2/
 u9MRK0wr9Z+qlza3doBU1WYPrRWLiHYy/1tZ6yG0Uw83AVxcjewm6XobNQAF9ECKf1S9wl+rcoR
 ZZUhjnl9XAOM8Dje7UtCCHmjlfEhzq+xJfRaB0VnYQDks0e9pLgx1jMJp7yFDdUPYi2DkF8qLXb
 WRCBZixEZv6TX4EvacKPGFipQaCUTCn5C2r84Xd/YI1mKyOO5MbCeI76timBfOkfOKab2ObdRKt
 oOy7UvmHF8R7J/oW5l67DUJt2/GYikHQ6ZyeMiiWZp9+HE2dV0S1kXVgAuvVhmhffw5wtkg4EUb
 zqrVDwUar0DSku8fXZMBELycVuDJvVSaM2aug==
X-Received: by 2002:a17:90b:560d:b0:3a0:bf71:eccf with SMTP id
 98e67ed59e1d1-3aceefbde01mr694683a91.14.1792189923713; 
 Fri, 16 Oct 2026 15:32:03 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm10827348a91.7.2026.10.16.15.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 15:32:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/4] wireshark extcap support
Date: Fri, 16 Oct 2026 15:30:30 -0700
Message-ID: <20261016223201.608942-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727224417.1419663-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
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

This series adds live packet capture from a running DPDK application
over the telemetry socket which is usable as a source of Wireshark
external capture (https://www.wireshark.org/docs/man-pages/extcap.html)

Capture is avaliable by default but can be disabled on the command
line with --no-capture. It works on Linux and FreeBSD.

How it works:
 - The capture library registers telemetry commands (/ethdev/capture/*)
 - Callbacks are installed on the specified port/queues to copy packets
 - Packets are formatted as pcapng and written to the specified output
 - No packet data passes through the telemetry socket itself

Advantages of this:
 - no secondary process needed to capture
 - installation is just putting the helper in the extcap directory
 - the helper has no dependency on DPDK libraries,
   so it can be packaged with Wireshark
 - allows for live capture
 - supports BPF (with JIT) for filtering

Implementation Details:
 - uses it is own version of userspace RCU to allow for callback
   to not need read-modify-write operations. Existing DPDK QSBR
   is ununsuitable because it requires the application to report quiescent
   states, and the point here is that the application stays unchanged.
   This RCU implementation could be integrated later into existing library.
 - helper is a C program so that it can be installed with privilege.
   That is what lets Wireshark capture from a root application
   without itself running as root.
   See doc/guides/tools/wireshark_extcap.rst.
 - Windows support is not possible with current design because
   telemetry is not available on DPDK for Windows.

Testing:
  - dpdk-wireshark-extcap --extcap-interfaces lists the ports.
    Reasons for an empty list go to stderr, which the GUI hides.
  - Unit tests are in app/test/test_capture.c
  - Tested on Linux capturing from a root application as a non-root
    user. The unit test also passes on FreeBSD.

v5
 - fix build errors on FreeBSD
 - split into smaller files
 - callbacks use a local userspace RCU instead of a use count,
   so the datapath has no atomic read-modify-write
 - added the --no-capture EAL option
 - renamed the internal filter API, it was using an rte_ prefix
   for something private to the library

Stephen Hemminger (4):
  capture: infrastructure wireshark packet capture
  eal: add --no-capture option
  test: add test for capture hooks
  usertools: add script for wireshark capture

 MAINTAINERS                                   |    5 +
 app/test/meson.build                          |    1 +
 app/test/test_capture.c                       |  688 ++++++++++
 doc/guides/linux_gsg/eal_args.include.rst     |    4 +
 doc/guides/prog_guide/capture_lib.rst         |  196 +++
 .../prog_guide/img/capture_overview.svg       |   49 +
 doc/guides/prog_guide/index.rst               |    1 +
 doc/guides/rel_notes/release_26_11.rst        |    5 +
 doc/guides/tools/index.rst                    |    1 +
 doc/guides/tools/wireshark_extcap.rst         |  203 +++
 lib/capture/capture.c                         |  661 ++++++++++
 lib/capture/datapath.c                        |  414 ++++++
 lib/capture/filter.c                          |  179 +++
 lib/capture/meson.build                       |   42 +
 lib/capture/multiproc.c                       |  250 ++++
 lib/capture/output.c                          |  311 +++++
 lib/capture/private.h                         |  233 ++++
 lib/capture/rcu.c                             |  258 ++++
 lib/capture/rcu.h                             |  112 ++
 lib/eal/common/eal_common_config.c            |    7 +
 lib/eal/common/eal_common_options.c           |    3 +
 lib/eal/common/eal_internal_cfg.h             |    1 +
 lib/eal/common/eal_option_list.h              |    1 +
 lib/eal/include/rte_eal.h                     |    9 +
 lib/meson.build                               |    1 +
 usertools/dpdk-wireshark-extcap.c             | 1131 +++++++++++++++++
 usertools/meson.build                         |   23 +
 27 files changed, 4789 insertions(+)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 doc/guides/prog_guide/img/capture_overview.svg
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/datapath.c
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100644 lib/capture/multiproc.c
 create mode 100644 lib/capture/output.c
 create mode 100644 lib/capture/private.h
 create mode 100644 lib/capture/rcu.c
 create mode 100644 lib/capture/rcu.h
 create mode 100644 usertools/dpdk-wireshark-extcap.c

-- 
2.53.0

