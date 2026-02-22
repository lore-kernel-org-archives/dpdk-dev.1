Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB68C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:32:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6D97402E8;
	Sun, 22 Feb 2026 18:32:30 +0100 (CET)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id BAA1A402E7
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:29 +0100 (CET)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-45f10d7eb81so1318479b6e.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781548;
 x=1772386348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGe5ojXt4jOOfpANmQc3D7Mp1Xo1RVx3dspRsHDj05w=;
 b=sN2pUGCjcWpmkJM5PIoxZYHKHhVGrkhWKyoGPuy22qZ7PpPRKdloFX6MgwaqicI0Fd
 FbgY3X+v0cozcPfPw8q6NQ1x8KhluFN2EMy6UWz8FoTf6dXjgRATya7/Uh7LAkLq7aQf
 1p8b1aFge5Snjy8r0JDp63Il8V0k7/7+D/tQZeYe+xSGM9SL0sOwaGMo8en+cknSryXZ
 SVYaIEL8gepJ7fjAOmyDJ1lFuUXWB0Wan0eqIWc+1Q73RtVZaICIEKyn1drOu6ABi2b2
 6ui/16Zn+KEU9KfAkZr0PojWzAzapNHFDYNA5Wv+t8gn5GlEbNOgIIIMncrRwzfcrP+f
 RMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781548; x=1772386348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGe5ojXt4jOOfpANmQc3D7Mp1Xo1RVx3dspRsHDj05w=;
 b=h1zlDg/NI7fE45cyapCnSH9n7t2HBw1S2QI9BXRs9zO+g2Y16wh65jJiStMBjsf0RC
 kpsvK1kzJlYisNu0ZQrNWAxfOYzaD4VXHtns3HQTE4HshWDg8BignH6V4BWI+AIduXoG
 iLhWFwa6krnb5XA7daRIDOSmqJptkzRgh9NkvGJ4kxV8KJQpAnKrMcbfh8PwZOQtEDr3
 sFFhT/HcZma+WaZT/iutvy3tzuMaz6rqyPNso2cI1zWvc4U2UiolWXnqVvOO5uhxIQzd
 sUp/0bZMDAJpYiIcIPPCvDBb6lAtcleSHjgx0Vn4aNP3bBf6xEE+bQcGmfm25Ll3E9xA
 K48g==
X-Gm-Message-State: AOJu0YwSdqfAc51SzuMQP6D/W32iFU52YyaUXGWhnUbDOtDVcsX+y9vw
 JqVxrUUtY28DX95Aw9v7WiUV8nt8ZbI+woYxXs6/UyUSQts5fTlrfLgy0pzAW/FfvGSUJ8WmBK1
 GpIyq
X-Gm-Gg: AZuq6aIolfBDFo+NH3MpOw3358IyG7joQIXrFpEW47qzFg8uJeRWS4Rz7icruxEZlF8
 AngPUFMVDi7NmaGkOBadMYcJwG5jqsDjBD8cIoY+A1W895zfV7sO9UZNb1K47wIhXUd1FIctBHm
 QDDRSCRItgwYT+RAirFs14YGgjRBq2iJS1WBqS1ev0Fu+d0zc5OoA/tJ9PP3G3CmwDCV+wk6tiY
 dYMzHAp5hiWrpe8qcxop4MvSE4gFV+ktgetRhV1vzaTZ6SbjHNvO0L+BQBrvPURX2DWOf4X/QqU
 uFmj+VKdYzajk/nk3TzFIR5j1+NJTRXdKyZYPU0bIsPE1bx5MyYO1tT023lgZJ3BmQMRYA5RVK9
 pVpqPeDtug9QO9s7ilnXZyBsK15ZWG8RSlYu+NZB8hb6mZCAGiGfBgEED2UYxKDbXdf5pWJ7hUS
 JdrmyyWPZKzOytvl2ZocTIplz2fgwkUoiP3mVFOOH3Nvr2MXT8TLfNXrQQtslUrw==
X-Received: by 2002:a05:6820:80c9:b0:661:13eb:6ce4 with SMTP id
 006d021491bc7-679c4278b87mr3694941eaf.21.1771781548409; 
 Sun, 22 Feb 2026 09:32:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/19] net/tap: cleanups, bug fixes, and VLA removal
Date: Sun, 22 Feb 2026 09:30:35 -0800
Message-ID: <20260222173225.522754-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Patches 1-2 are documentation and bug fixes that stand alone: update
the features matrix to match current driver capabilities, and fix
queue statistics to count all queues regardless of the queue stat
counter limit.

Patch 3 fixes interface name buffers to use IFNAMSIZ instead of
RTE_ETH_NAME_MAX_LEN, since these are Linux kernel interface names
not DPDK device names.

Patches 4-6 are minor cleanups: replace the runtime speed capability
function with a compile-time constant (TAP is always 10G), clarify
TUN/TAP flag operator precedence with parentheses, and extend the
fixed MAC index to 16 bits to avoid duplicates after 256 hot-plug
cycles.

Patches 7-12 fix bugs tagged for stable: a bounds check to prevent
an out-of-bounds read on truncated L4 headers; resource leaks in
the primary and secondary process probe error paths; a missing free
of the IPC reply buffer on queue count mismatch; a use-after-free
with an orphaned kernel TC rule when remote flow creation fails; and
a leaked remote_flow allocation on EEXIST from an implicit rule.

Patches 13-18 restructure the driver internals: dynamically allocate
queue structures instead of embedding fixed-size arrays in
pmd_internals; replace the pointer-to-VLA iovec with a flexible
array member sized from MTU and mbuf geometry; replace the Tx
per-packet VLA with a fixed-size stack array capped at 128 segments;
remove the VLA in flow item validation; consolidate per-queue
statistics into a common structure; and enable -Wvla warnings.

Patch 19 adds a unit test suite for the TAP PMD covering
configuration, link, stats, MTU, MAC, promisc, allmulti, queue
start/stop, link up/down, stop/start, and multi-queue.

v5 - use IFNAMSIZ for interface name buffers
   - dynamically allocate queue structures
   - compute Rx scatter segments from MTU instead of nb_rx_desc
   - use flex array for Rx iovecs, fixed stack array for Tx
   - consolidate queue statistics


Stephen Hemminger (19):
  net/tap: fix handling of queue stats
  doc: update tap features
  net/tap: use correct length for interface names
  net/tap: replace runtime speed capability with constant
  net/tap: clarify TUN/TAP flag assignment
  net/tap: extend fixed MAC range to 16 bits
  net/tap: skip checksum on truncated L4 headers
  net/tap: fix resource leaks in tap create error path
  net/tap: fix resource leaks in secondary process probe
  net/tap: free IPC reply buffer on queue count mismatch
  net/tap: fix use-after-free on remote flow creation failure
  net/tap: free remote flow when implicit rule already exists
  net/tap: dynamically allocate queue structures
  net/tap: remove VLA in flow item validation
  net/tap: fix Rx descriptor vs scatter segment confusion
  net/tap: replace use of VLA in transmit burst
  net/tap: consolidate queue statistics
  net/tap: enable VLA warnings
  test: add unit tests for TAP PMD

 app/test/meson.build             |    1 +
 app/test/test_pmd_tap.c          | 1143 ++++++++++++++++++++++++++++++
 doc/guides/nics/features/tap.ini |   14 +-
 drivers/net/tap/meson.build      |    1 -
 drivers/net/tap/rte_eth_tap.c    |  411 ++++++-----
 drivers/net/tap/rte_eth_tap.h    |   28 +-
 drivers/net/tap/tap_flow.c       |   36 +-
 7 files changed, 1424 insertions(+), 210 deletions(-)
 create mode 100644 app/test/test_pmd_tap.c

-- 
2.51.0

