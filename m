Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479DCCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 17:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 380A840291;
	Fri, 16 Oct 2026 19:05:31 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id CB91840291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:05:30 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e987b4a710so5252455ad.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792170330;
 x=1792775130; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QrvFuekZZVR0Wyiovdrdl4e7P4PnyYi3DCYgrpdSHwo=;
 b=Lu+4p3dlDuJs9LkGuWzpJsyVe83LL8lMVHcxiFbgQ7Vh8lxtRtynetqF0P7uNbh8QP
 I1W4LJdCkiKHK+7qRCD1fUSkmN/5kaPh4H/Gc8qprSHSZQ6xTYKQuMpd+Rl5ZDlzqLye
 XfowtQDNNkg1c5c7VCL05M8I/7PlSi4EjvZyJXUUPybfv71Al409/qQI9iwxVZR2VWdz
 tTIwYXXkQ1bAKlDznvS+oCZkdcKk70c6s1khyYqrf+QwPlXJrsJd/Vz80fkvfLYuprOd
 cv8Xm3gwHWohk+2bDBnwI80fwEWenQNmVLULD/j6evgG0GucXO5jdt+YJHDrDs/Cy22u
 T3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170330; x=1792775130;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QrvFuekZZVR0Wyiovdrdl4e7P4PnyYi3DCYgrpdSHwo=;
 b=dgqVeDv6EnAR39SvLOKEIMmpntYk//PIpMjkmbf/fzW+SsCLExIHCphIi+Dr4OgO/f
 HKSZG3exFzeEt6KjTkiIlyOj56SxmeiNhcq5ZxGPso6Fy5WPmWTzLInKFhygoqe/9/Ah
 ueDlGJl7/JQWRrmIDfOgYWIludHdm02q9tzScedKRndIqqRSYWKrMahsNuoSkPD13n5p
 LxyKubCQzFI1Z8HykNtCuOn8T/CK1N2F6HVLNjoY8fZCvL6q3FtsG6e6G4nQ7RZCrCXe
 qc8JZrKDqBCOlWlcvg+O8Yg2aCMel1KK5tmKFoQtRZNDuSYZVQwSRsF+Gva3cIDSUpNK
 KWbg==
X-Gm-Message-State: AFq9FYJB1S9lw8d4lIVnKlr/WtHu3b0SgjGdiml83jDMD2LxYVtl+Vmf
 GCNt5YCOflDCFEw4C2S/i8RSpdbsPTVNhBlqt3raOe0NOHySBo1zvL02X6ctsCGR3ExrK22rgE6
 Ruq4wD6U=
X-Gm-Gg: AYBFou2rTFICrSZV8LmZjXghL7Q9hmSS3NCZvq9mKEpT6H2CPT4jNbsdn1LzMX4kUZw
 vGiaSG4En37gq1cz7jJnL3i4ituDSpeNRmhfmyb9plmNc0ZWJP/YqxmqmQADs2Zxc8O2huctawh
 yUNvKBoFslT0g42kPQqD2SpClvJm70VbRTZMd1GBZ+5eNxyhJBeV6WsDBPYwWPkvVmxHKYDshbl
 MfTGZM/ZnIUsCL2YXTsNHg5rFc0AEdHdIt2BLC31INAufHPSQMxb746bIBg9DeaWGZYgrIIp0NM
 MKBS3KkTziSX7HMGkuanXst0+9paDMcqAKj+jn7H8WgK355nNUacISnkgM7/eEuwYc4LKS2lUX3
 b7KU5SqOqrt6oQBBVDNV/wuNgvFKoC4mpJX19yhKkm05ZrUBsZIUWwJoR2C2bhGIMVC1eei2Ksl
 NfUos21Z0VMAtMYdKQOVm2YB9vnZfPI4A+wtIclKs46g+4SBiBM7PETeZkvXXdh08/NQ87BwNrB
 o+2baze8vzQnBFb/K9rJl+GQVAjIKHx+WCUsUJCGdUBKjpgd1Y=
X-Received: by 2002:a17:902:f546:b0:2e9:4ecb:24a5 with SMTP id
 d9443c01a7336-2e9a6833d02mr4178775ad.2.1792170329821; 
 Fri, 16 Oct 2026 10:05:29 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e878910sm13239685ad.61.2026.10.16.10.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:05:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:05:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 0/9] net/memif: lifecycle fixes and unit test
Message-ID: <20261016100523.74067d8a@phoenix.local>
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
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

On Fri, 16 Oct 2026 16:15:48 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> This series fixes a set of error-path and lifecycle bugs in the memif
> PMD and adds a unit test for the driver.
> 
> The first eight patches are fixes:
> 
>  - guard eth_memif_tx() against an empty burst (nb_pkts == 0);
>  - close file descriptor 0 instead of leaking it;
>  - do not close the EAL-owned memseg fd in zero-copy mode;
>  - free the MAC address allocated during probe on failure;
>  - unwind a partially-created device on create failure;
>  - refuse connections on a stopped server so it does not come up on a
>    stopped port;
>  - disconnect on close so a stopped server's control channel is not
>    leaked, and make memif_disconnect() safe on a never-started device;
>  - fix eth_memif_tx_zc() returning 65535 on an invalid interrupt fd.
> 
> The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest):
> a server/client vdev pair over a loopback socket covering dev_info, link
> state, stats, single-segment loopback (slow and fast path), multi-segment
> loopback across a ring wrap, stop/start reconnect, empty Tx burst, close
> without stop, and a stopped server refusing a peer.
> 
> Verified: memif_pmd_autotest passes 11/11; each commit builds with
> -Dwerror=true; check-git-log and checkpatch are clean.
> 
> Thanks to Stephen Hemminger and the ai-code-review bot for the reviews
> that shaped this series.
> 
> v3:
>  - Rebase on main, picking up rte_intr_fd_close() from
>    d9191f684c ("interrupts: add helpers to close FD"): patch 2 keeps
>    only the owned-fd ">= 0" fixes not superseded by that helper, and
>    patch 7 keeps the NULL-queue guards above the rte_intr_fd_close()
>    calls.
>  - New patch 6: refuse connections on a stopped server. The started-
>    then-stopped case is the actual trigger for the control-channel
>    leak; dev_stop now sets ETH_MEMIF_FLAG_DISABLED. (v2 patch 6/7
>    described this as never-started, which was wrong.)
>  - Patch 7 (disconnect on close): reword to the real trigger and keep
>    the close-time disconnect as a backstop.
>  - Patch 3 (memseg fd): also stop closing the EAL-owned fd in
>    memif_connect(), not only memif_free_regions().
>  - Test: new test_memif_stopped_server_rejects_peer covering patch 6
>    (fails without it); reword close-without-stop to what it actually
>    covers (the NULL-queue skip); verify the full fast-path payload.
> 
> v2:
>  - P1: correct Fixes tag (Tx fast path, not original driver); move the
>    empty-burst check after the ring == NULL block.
>  - P2: split the memseg-fd change into its own patch rather than
>    widening the check to ">= 0".
>  - P4 (MAC leak): document the secondary -1 -> -ENOMEM change.
>  - P5 (unwind): add Fixes: multi-process support.
>  - New patch: fix eth_memif_tx_zc() bogus Tx count on invalid fd.
>  - Test: add to MAINTAINERS; return TEST_FAILED (not SKIPPED) on probe
>    failure; add a default-bsize pair to cover the Tx fast path; set
>    ring size via rsize and fix the stale comments.
> 
> Sriram Yagnaraman (9):
>   net/memif: guard against empty Tx burst
>   net/memif: close file descriptor zero
>   net/memif: do not close EAL-owned memseg file descriptor
>   net/memif: fix MAC address leak on probe failure
>   net/memif: unwind partial device on create failure
>   net/memif: refuse connection on stopped device
>   net/memif: disconnect on device close
>   net/memif: fix bogus Tx count on invalid interrupt FD
>   test/memif: add memif PMD unit test
> 
>  MAINTAINERS                       |   1 +
>  app/test/meson.build              |   1 +
>  app/test/test_pmd_memif.c         | 751 ++++++++++++++++++++++++++++++
>  drivers/net/memif/memif_socket.c  |  10 +-
>  drivers/net/memif/rte_eth_memif.c |  76 ++-
>  5 files changed, 812 insertions(+), 27 deletions(-)
>  create mode 100644 app/test/test_pmd_memif.c
> 


Still see warnings from AI

v3 applies to main (26.11-rc1) and every commit builds with
-Dwerror=true. Not run. The v2 comments are addressed. 6/9 fixes the
stopped-server case at the source, and the close test now covers what
its comment says.


[PATCH v3 7/9] net/memif: disconnect on device close

Info: the commit message describes the tree before 6/9. With 6/9
applied first, dev_stop does set ETH_MEMIF_FLAG_DISABLED, so "dev_stop
does not set it again ... memif_msg_receive_init() still accepts a
peer" is no longer true at this commit. Suggest:

  Before the previous patch, a server that was started and then
  stopped still accepted a peer and held a live pmd->cc at close.
  Call memif_disconnect() from close as a backstop for an init that
  races with stop.


[PATCH v3 9/9] test/memif: add memif PMD unit test

Warning: test_memif_stopped_server_rejects_peer() passes only by
timing out, so it always burns the full wait_for_link_pair() window
(CONNECT_TRIES * CONNECT_DELAY_US = 5s). memif_pmd_autotest is a fast
test with a 10s meson timeout, and that budget also has to cover EAL
init and the other handshakes, under ASan too. Use a short window for
the negative check:

	static int
	wait_for_link_pair_tries(int p0, int p1, int tries)
	...

	#define REJECT_TRIES 10	/* 1s */

	ret = wait_for_link_pair_tries(sport, cport, REJECT_TRIES);

Info: the commit message does not list the fast-path loopback or the
stopped-server test.
