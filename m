Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FAC87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2036A4025D;
	Mon,  4 Aug 2025 18:30:47 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 8EFEF400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:30:45 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso20645745e9.3
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325045;
 x=1754929845; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9iCLMx5n5+Y3Rg4g28v4aRLsZtuUFMons44c4MR7Yo=;
 b=zDlQtQL7n5U5DI9ZR7pzTeANuodfOuXvp299v8k24ZTxPe8VV/0179OETenh+J+U0A
 p8cRbABF9CvHmGgJZ0qvJkEE0xEAbYy+hahZxlF+lHKg+NTBObi6CbBNUR5/ceEch8II
 eXlhyolMoC0g/yX67pq+8phsaZFgvK1bsAJhKl5gG5dvbtUpPjDy/QnsMgaSQ2egpWNF
 HxJA3PrIRA1y5OlydXiXE5dbkO5YC7NyK/fln/y1akqvQ4if7w67RH8weyWhXHBbHHMP
 KEWjRG1GVAY4bjd2FVHqUQ9v2L7/Lwo4zfU7NiAB0v7HciQqjPToOnFQLlow5uFgrYxg
 kAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325045; x=1754929845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9iCLMx5n5+Y3Rg4g28v4aRLsZtuUFMons44c4MR7Yo=;
 b=PzbOst+HztoNnMA5SeVz7plxMB7ON/YhihFOKykD4Oy6rpNl5hxnozBr8y5vZKMkwB
 SORrD4LVVzDdhkrIfl+YNHcX5+FaN4516NowCve6P/DVennMfR4ltiu7lcWuRt1/h+d4
 0peHK5aCwq6Y4GCfNCpChZvXK0sWSh4squG9eA/oNG2Q6eIopDZVL2Iw6ZOk9SztMESi
 ivK7vkMZHyLZcqoCa+SW77GY7VmmY455PcwIQ/e0EzsqT693wrxI4W/oop22VY8YLrTG
 l9dYX7oY74OshzxekYOPvDsmd14TwyMzFWH7LOi7ikLWJQy4kaOSZK4Y5/ctdiEt2Q5k
 Q48A==
X-Gm-Message-State: AOJu0YyZIl7E4V6C2dGPMykv3CcqjtI8JJQg+QQ32YVahHlGgsPq/WLI
 N9YDspr0hebDf2d85AdyJsOuu68LcJheNo2NcodoH3iJRasZwyQvk52oQQeJd6wqB1pqtY6Lajn
 eA4OO
X-Gm-Gg: ASbGncvnB8bi19TX6XtIv8cx0ItITrEhtCPNU01vtyrOGSLacabzEOoC0haCgoiuF6C
 igxog6s3JQy5o9PPJBpkCWaZmYi9dIilSzpAYhVNAQI57qiQ6oV55zgMCLbVzZmFGH8+rZjsjlw
 piDNtQHkEgeEIc4e0IACXKgK3VG0LQGyKQd626dlU9t+z2wn2T7hVniUEo5dFQwuqSOzY4apNMM
 Ozxs1Cm05BpyowV+jNQhtvk3E1ZBeUcVOb5DxXRdxgZhDx8S+Q8jAgi34XRzmH/5ygr7sIIaVp1
 QqAOLmDMLMvBivsTXNxXMI2rHEh2qKdCe+XQ52PUVmIBVgrFZsvg7r4DOKwZWV3JFIFU7kxIzSK
 Iz1pDD/lv8AVRBkQ5VNZjYAsVU65JX3sTEzPWsg1614UrNylkI/7UHNmxJS7QII+OHqlvW79y
X-Google-Smtp-Source: AGHT+IGYY5T18S5BT2SUkYJD/XmgBgwCoHxhRJ82Cp5UexS/FFjAG2oXBOyDfM+mWK9dlxbmVxWhWw==
X-Received: by 2002:a05:600c:3510:b0:458:c059:7db1 with SMTP id
 5b1f17b1804b1-459e0a0ad63mr4357605e9.30.1754325044776; 
 Mon, 04 Aug 2025 09:30:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/13] Packet capture using port mirroring
Date: Mon,  4 Aug 2025 09:27:31 -0700
Message-ID: <20250804163039.138959-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

This is a rework of how packet capture is done in DPDK.
The existing mechanism using callbacks has a number of problems:
  - can't work when packets are sent and received in secondary process
    because callbacks only function in the primary process
  - requires "opt-in" from application

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's:
one to add a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command syntax is
unchanged (no doc change needed). Using the new mirror mechanism, the
dumpcap program creates a port using ring PMD and then directs a port
mirror to that new ring PMD instance.  Then the packets are extracted
from the ring.  If capturing on multiple devices, they all get
mirrored to the same ring PMD.

The dumpcap program needs to be able to start the ring PMD it created
but the existing ethdev API is broken when used from secondary process.
One of the patches fixes that, it was also reported previously in Bugzilla.

The mirror API has a restriction that the port being mirrored to must allow
lock free transmit. This is because both Rx and Tx as well as multiple
queues need to go over the same transmit queue. Although it might be possible
to have some complex mapping between multiple ports/queues being mirrored
to multiple transmit queues, that gets to be a lot of overhead in API's
and implementation. Fixing the ring and null PMD to allow lockless
transmit is good enough.

Added tests for the mirror features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - need release note and documentation
  - more through testing on real hardware
  - figure out deprecation plan for pdump

v8 - do BPF in ethdev (when packets are tx/rx). This allows for
     selective mirroring and improves performance of capture

Stephen Hemminger (13):
  bpf: add ability to load bpf into a buffer
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  ethdev: swap bpf and ethdev dependency
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  app/testpmd: support for port mirroring
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  app/dumpcap: use port mirror instead of pdump

 app/dumpcap/main.c                          | 389 ++++++++++++---
 app/dumpcap/meson.build                     |   3 +-
 app/test-pmd/cmdline.c                      |  13 +
 app/test-pmd/cmdline_mirror.c               | 194 ++++++++
 app/test-pmd/cmdline_mirror.h               |  13 +
 app/test-pmd/meson.build                    |   1 +
 app/test/meson.build                        |   1 +
 app/test/test_bpf.c                         |  28 ++
 app/test/test_ethdev_mirror.c               | 325 +++++++++++++
 app/test/test_mp_secondary.c                |  50 +-
 config/rte_config.h                         |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/ring/rte_eth_ring.c             |  49 ++
 lib/bpf/bpf_load.c                          | 111 ++++-
 lib/bpf/meson.build                         |   9 +-
 lib/bpf/rte_bpf.h                           |  38 ++
 lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c}  |  35 +-
 lib/ethdev/ethdev_driver.c                  |  12 +-
 lib/ethdev/ethdev_driver.h                  |   6 +
 lib/ethdev/ethdev_private.c                 | 141 ++++++
 lib/ethdev/ethdev_private.h                 |  29 ++
 lib/ethdev/ethdev_trace.h                   |  17 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/meson.build                      |   8 +
 lib/{bpf => ethdev}/rte_bpf_ethdev.h        |   0
 lib/ethdev/rte_ethdev.c                     |  99 ++--
 lib/ethdev/rte_ethdev.h                     |  23 +-
 lib/ethdev/rte_ethdev_core.h                |  12 +-
 lib/ethdev/rte_mirror.c                     | 503 ++++++++++++++++++++
 lib/ethdev/rte_mirror.h                     | 147 ++++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/meson.build                             |   4 +-
 lib/pcapng/rte_pcapng.c                     | 179 +++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 34 files changed, 2251 insertions(+), 246 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
 rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

