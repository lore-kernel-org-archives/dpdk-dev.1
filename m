Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AB0C53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 22:44:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD44F400EF;
	Tue, 28 Jul 2026 00:44:22 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 09B9B400D6
 for <dev@dpdk.org>; Tue, 28 Jul 2026 00:44:20 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1955346a12.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785192260;
 x=1785797060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXhbNwBK3cUIW7+2MCQlMV9Pis6HitRlg3Ru7027Q04=;
 b=rjbP9V0SBkkRoDnEYb7GDkCdokoJjlRTKrcRa2xG4XF288IVWnmaUfUTR5ZHMDsVG9
 0/whfZzF52rKdULNQPj/GTTMEJlPQzjOdN9+ZFbsGJ6N9ddyQkoU0cDSV+EA/5+4R7xj
 CRdINLSTGtUVpkIqxrZalhHz9BACKlV+aXoH1D5shdWpaF2s1lG0QyHbKgngJ/3zmuDl
 oIhnMtzosKEqtAbC7JbaRC6imM3qNBafnRM1D9LxaxkSaaAo+KJE3aTT5wKMNt1RxqX1
 G1dtAOe2TvmoGBZ3PSgXp7MzPCEKZ2TACpeFF+ZAsqcyB2iLk6Dx1rzEfb0dRNLmIVLd
 84Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785192260; x=1785797060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wXhbNwBK3cUIW7+2MCQlMV9Pis6HitRlg3Ru7027Q04=;
 b=qYD49WeVioUefONMDu0ieCjkOqePV67jN2lv51jXqC+gBlYv2yCl6pxHeUznIn0J/5
 xEXqMBOe4seJsp1WZvDOBI67R11EThUtlxzONcjTN/x6RlxeuqEHvKEGQJLZR7BCRGei
 386WyB2s5QjxayjjaLerJ9NcrVN3lZxHN0pI5aQCO5u9hdv68wuY6AyJtSonjQfZ85ot
 LAx48rz3gOqKVa2T4U8Q7tyVb6vSPgVNljOFFoR0AHn4ePuH6DxB0dF7esBQbEf/DK5T
 CTU08UE181sqwP4vR6gEQm9HrcS7aK+Wd01iLQunRePZ2YBZZP9061faeLE86Nk824W7
 FouA==
X-Gm-Message-State: AOJu0YxxyZGvYwCn4LMo1sipAVPUO4PElWTiQyafsOGOYTt7UxyBK4UQ
 mv6R5hxg6/VAegr0a1gQMxEPbVMoJH1lmSR8uPmbgN1AaoMsXn2TWy3aZvgzG5CNhsDsnSiJSeg
 wlOZ/
X-Gm-Gg: AR+sD12OgjPEUTGT2M4SjJihsBv/BP2D7NBv3u89MDWBvGIRwERbCgedNbeMJMryFvz
 9ryyDYp/UmxivR6sDzd/tHrx5eyeotw59oN7fPlbkUwaBHkAYfwni3m3Y8BDz2eL+tQVpJjVlvP
 Io7P8AAhUsAFC57hJiaFxY96QXz5tWJrOyqyi9eGMjDVG19IIhCU0AadGUvEnDWQNbE1SfGdUQO
 a2pyBQo0gbxs7wJ2b+pH12ngxTRDKHuTA7KaUt7YSkvJcgDy/NNIkGG8OxXw6aF6CXQ3Xrbt+tp
 SVkk8A6UHWkNxvVU4hA5FJb8OO3lKyxud2PyXX+/y964zwLFYUqe6DmUJy2RbeGE26ZqV6gpkfp
 hHD8FKVtNY9z6G0qf1vQLPIKGUr+vettPxdJ/iTGktajPvypqtRrCi5vfFfWubDLEKwhYZUFOgk
 GkSNhIOrclKnLTgzzE5gT8pj70QmjTE+E8R+yCzxYO
X-Received: by 2002:a05:6a21:48a:b0:3c0:9c19:b271 with SMTP id
 adf61e73a8af0-3c67dfe228emr10718362637.63.1785192259890; 
 Mon, 27 Jul 2026 15:44:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e5c921686sm20238078c88.4.2026.07.27.15.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 15:44:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] Wireshark external capture interface
Date: Mon, 27 Jul 2026 15:42:43 -0700
Message-ID: <20260727224417.1419663-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724212238.864798-1-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
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

This series adds live packet capture from a running DPDK primary over the
telemetry socket. A new capture library installs Rx/Tx callbacks on an
ethdev port and writes pcapng to a caller-supplied path or FIFO, with an
optional libpcap filter and per-queue selection. No application changes are
needed beyond linking the library.

The pcapng interface-statistics block gains a filter-accepted count,
which changes the rte_pcapng_write_stats() signature.

v2 - review feedback from checkpatch and AI
   - defer dpdk-dumpcap.py until later
   - add more documentation

Stephen Hemminger (4):
  pcapng: extend interface statistics
  capture: infrastructure wireshark packet capture
  test: add test for capture hooks
  usertools: add script for wireshark capture

 MAINTAINERS                            |    4 +
 app/dumpcap/main.c                     |   16 +-
 app/test/meson.build                   |    1 +
 app/test/test_capture.c                |  660 +++++++++++++
 app/test/test_pcapng.c                 |   10 +-
 doc/guides/prog_guide/capture_lib.rst  |  168 ++++
 doc/guides/prog_guide/index.rst        |    1 +
 doc/guides/rel_notes/release_26_11.rst |   14 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/wireshark_extcap.rst  |  144 +++
 lib/capture/capture.c                  | 1199 ++++++++++++++++++++++++
 lib/capture/capture_impl.h             |   56 ++
 lib/capture/filter.c                   |  110 +++
 lib/capture/meson.build                |   19 +
 lib/meson.build                        |    1 +
 lib/pcapng/rte_pcapng.c                |   50 +-
 lib/pcapng/rte_pcapng.h                |   33 +-
 usertools/dpdk-wireshark-extcap.py     |  416 ++++++++
 usertools/meson.build                  |    1 +
 19 files changed, 2871 insertions(+), 33 deletions(-)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/capture_impl.h
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100755 usertools/dpdk-wireshark-extcap.py

-- 
2.53.0

