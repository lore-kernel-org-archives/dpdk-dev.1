Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA03CCA464
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 19:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2562A4027C;
	Thu, 15 Oct 2026 21:51:39 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5F27B400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 21:51:37 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-868b3248b2cso4392957b3a.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792093896;
 x=1792698696; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Y9n9OFn+idNFbKPwVXNDExV1rVfipVfS9s17emOCW0=;
 b=BQMmQJI89uXLKuRoXIUZduQ36iNCEfvYH5rTI3VfHQrBCmCJl30aOUNi+kbER3T2MK
 yxsZA0NryO69/e5zFND4DtMVx3AJ/8hmO2lRE5b3osSme9HvAzZ4cn+mhK8LbS43S2zQ
 JKau9TY8+9eOb7/bzvgwX2mRCcUcQ4r2P70dkIHJREYYA4NYVOgmVrFN5nf3utQ52+wd
 7cXURumKvlJ82CA46+28oZwiqlUTW3BU11WjI+aXf/3SC8I4bB7vPgc7o2bGcffkguJ+
 Gceu7Y6zHyJTy9G9qLJku2aOh20aVAB9PO4gyPF38oCO3TBom7PyNFxXtQPtyOnl1HDh
 zs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792093896; x=1792698696;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Y9n9OFn+idNFbKPwVXNDExV1rVfipVfS9s17emOCW0=;
 b=WEpKvH/LMlqQHXTib2amNz0j5u7z60G6Rp51GXlFn10sCK5MR4IKLstQ+MsZlgLQH+
 MqhtzWLPh0RtxL1MnnA0uMvhunhJK+t97lLhjE/9hb3j3L19MxNszwEvENz9Ffm+MnXM
 DTg6BCFelwz3jyEXiABzOy/NO8JVgYLvqTUEQXD0gsHS2vIJqmBgJqpi/TVE88BRdLyC
 0N7j/5BN4bxWExTfy8WDebXnE4om1J2IpPpEYnY/avI+o/sH/hpX/vmNuTCYdXe93Cab
 0B7a6Rc8UCubfNEQO2P4pxNdPVcrqWD6lWK3EwnvlMUsDCL2Z5lV6QCHYVb2o3cWNeK4
 unIw==
X-Gm-Message-State: AFq9FYIpuDhhFkxRwKNRbf0Wg51bvEk03n/yYBARNwgPqqhqd28atOVY
 Gs9qZY5rfA8aX2R0+v7nLxP8c+r4OdUNuFGMsaP2L14UBPeWWnSpBtCoZhUj8GkH91I=
X-Gm-Gg: AYBFou1UZbGu576w8Nro+puTvPM/QIHDxs1fdMtqgmJxb1/1hP3DMUXXtKXNc3CBHPf
 kmjF99tTHBX0sa/p5bNoKsb0yiAGtfaSi6rYQgDmEpXuY4JyIe53vUif2Y/ada0A+dejR7vbuuc
 sW17KBeHRRNw2zoMeHP717Eso73FtvCfEpZU+D7/wkANiXEU0KlBJjcuKg3+1FLdzjD7jjB5bA7
 IEqMClsSAqbAcsSkYhK93uTjpGrJT8S0bSup9G6N+GqG5qM/Qc/GLqmHZn5KheHejvN3c7OeBf/
 nVcEKhleh9fQ4y+m5cPn0RQWMq4Hi5HOacEwLnbfuPzhq4Sykh1GBTIvPbJchOTtsd8MLG+WJPd
 MVOxwJYsOrEhBzTJZigphUb3cXKPsYYUQwcyNk/BN329KAIkgt4qDfBETnNakPrHKZxDeQdmtdW
 xx7AjFu5trww4yniq0DOnFxxFPRAK2E2V411TNAA7Z5fNE0NjEnRV+/ABvNpfog1SnK3FapQ6hq
 Ri+aX1yQ+SC6+NkbtPbScip4ofmU4HFLAoUIyFV
X-Received: by 2002:a05:6a00:4612:b0:89f:5ac6:32f1 with SMTP id
 d2e1a72fcca58-89f5ac647bdmr308333b3a.23.1792093896384; 
 Thu, 15 Oct 2026 12:51:36 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58211b2esm93758b3a.54.2026.10.15.12.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:51:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:51:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 0/8] net/memif: lifecycle fixes and unit test
Message-ID: <20261015125133.41f86af9@phoenix.local>
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
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

On Thu, 15 Oct 2026 16:39:37 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> This series fixes a set of error-path and lifecycle bugs in the memif
> PMD and adds a unit test for the driver.
> 
> The first seven patches are fixes:
> 
>  - guard eth_memif_tx() against an empty burst (nb_pkts == 0);
>  - close file descriptor 0 instead of leaking it;
>  - do not close the EAL-owned memseg fd in zero-copy mode;
>  - free the MAC address allocated during probe on failure;
>  - unwind a partially-created device on create failure;
>  - disconnect on close so a stopped server's control channel is not
>    leaked, and make memif_disconnect() safe on a never-started device;
>  - fix eth_memif_tx_zc() returning 65535 on an invalid interrupt fd.
> 
> The last patch adds a memif PMD unit test (app/test, memif_pmd_autotest):
> a server/client vdev pair over a loopback socket covering dev_info, link
> state, stats, single-segment loopback (slow and fast path), multi-segment
> loopback across a ring wrap, stop/start reconnect, empty Tx burst, and
> close without stop.
> 
> Verified: memif_pmd_autotest passes 10/10; each commit builds with
> -Dwerror=true; check-git-log and checkpatch are clean.
> 
> Thanks to Stephen Hemminger and the ai-code-review bot for the v1 review
> that prompted all of the v2 changes below.

More semi-automated AI review feedback

2/8 and 6/8 conflict with d9191f684c ("interrupts: add helpers to
close FD") on main, which already converted the queue fd closes in
memif_disconnect() to rte_intr_fd_close(). Rebase, keeping
rte_intr_fd_close() and the new mq == NULL checks. Resolved that way,
every commit builds with -Dwerror=true. Not run.

The v1 comments are addressed. One of them was wrong, and that error
went into 6/8 and 8/8; my mistake. Details below.


[PATCH v2 6/8] net/memif: disconnect on device close

Warning: the reachable case is a server that was started and then
stopped, not one that was never started. memif_msg_receive_init()
skips any server with ETH_MEMIF_FLAG_DISABLED set. memif_create() sets
that flag and only memif_connect_server() clears it, at dev_start.
dev_stop never sets it again, so:

  never started:       peer rejected, pmd->cc is NULL at close
  started, stopped:    peer accepted, pmd->cc bound, and on CONNECT
                       memif_connect() sets CONNECTED and link up on
                       a stopped port

The second case is the bug. Fix it at the source in a separate patch
by refusing peers while stopped:

	static int
	memif_dev_stop(struct rte_eth_dev *dev)
	{
		...
		pmd->flags |= ETH_MEMIF_FLAG_DISABLED;
		memif_disconnect(dev);

  Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")

Keep the memif_disconnect() call in close as a backstop for an init
racing with stop, and change the commit message to "started and then
stopped".


[PATCH v2 8/8] test/memif: add memif PMD unit test

Warning: test_memif_close_without_stop() still never reaches the cc
teardown. The throwaway server is never started, so the client's init
is rejected and pmd->cc stays NULL. I suggested that setup in v1, and
it was wrong. What the test does cover is close on a configured but
never-started port, i.e. the mq == NULL skip. Reword its comment to
say so.

Once the DISABLED-on-stop fix is in, test that instead: start the
server, stop it, start a client, and check the server stays down:

	TEST_ASSERT(configure_port(sport) == 0, "server start failed");
	TEST_ASSERT(rte_eth_dev_stop(sport) == 0, "server stop failed");
	/* create and start the client as now */
	TEST_ASSERT(wait_for_link_pair(sport, cport) != 0,
		    "stopped server accepted a peer");

Without that fix, this check fails today: the stopped server reports
link up.

Info: test_memif_fastpath() checks only the length. Verify the payload
as test_memif_send_receive() now does.

