Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A07CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 22:49:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD019400EF;
	Fri, 16 Oct 2026 00:49:29 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7E9E340041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 00:49:28 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-89f28c3ac7bso237441b3a.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792104567;
 x=1792709367; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bn89W5mq/6FtsglawSdfpxortl1yCHqeiFf3a0Rs5rk=;
 b=uv+J93xV5ZnEB8JOF/Se8ne81EOnJ1HULwenqeCE4fDYRozd+W0oJMMPuzYH8v/LVe
 60oEujL0zgSu4dd/pWynAcYsS3pLgD72CRnnMAXGOX3sceAZmF7Mf7Lar805iLCKLIfo
 t6i3swTMhumdZMVBVIYDbfu87X6YWv7PwdL5Vqd+cPEgZdJXHTOtg0qKD8qr+ZW/TTJj
 HOXaeGUQ84kZ1vQjLjFRF1pdy4bJXxCjRnzcduY1Ff5MbEx9waxKkuRCV+DM/KVoVeFH
 SfwPbbBPtnyIqurMpOHyQymO/c+tAcnH5vhD6ndFEJ259MmMHps/iFPqOmLJK5dSuvju
 OJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792104567; x=1792709367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bn89W5mq/6FtsglawSdfpxortl1yCHqeiFf3a0Rs5rk=;
 b=tFsEghbuzUeq6sXIxW00vwciXqegGl57akRhwJli3KU65R2G/mxViskeAxEgMKtn/r
 RcH0Q+fCjmHZ30OOvNoeZwXxQtFJU5+Tx816OuHDX4V+2rZJm8DTjoQMpJ4ZvJJrtKGc
 paXHgrkVdy6Z79MLG2b9af+R2RTACdL3NpsMIkuAut/tGL8oNTRGFlT9DC8tPkc5A34B
 mgQNUAJclrHZkNN8nToVQIBDWUGUp7wbwkjNIiQ2fHdOJflhp2NNEv55k+Im3RORsJwA
 reu6zb7zwOhlpgI2kwZvIJvJPER+flztK1Tj+n0IFbwRGH2L6NqZ5/Rj8RIcjVb4qEek
 95NQ==
X-Gm-Message-State: AFq9FYKw2HmDgtv76uPI8YBjfSV01zpLZRr3c8jr+7z74lP57GZCQigl
 PHUrApBHEPTkhJ9Kvj2RWE3rwD8P9Dq4smTme0WZKMOhFjh5DTqQNFJF7iEY6nhkhcQ=
X-Gm-Gg: AYBFou0H6P35O52LLgje8E5EmoRbgu2KVOt6YrFOz1OlErDdnwizwjh+qJCqhPfL9uA
 kSjdUGzB8CQKj0OgfqOrYYHS5bkCocbP9RP87g5p8WURZyB0vNYVo8CbwkpBljcQxDIWCXcEww8
 m0lRl6fg1c4xaEM4z8tMW1/ORpQPaWH2WOQ6lp+LyjYBuEL4ExNf5MXqTr5J+zrSQZppgNTlS5K
 imoUY4VtBqy81hmNz7GDudIJkXyCHh1/KECLGKdtq6Nh9UYLyzlKizizHdow48nRNh8iWKo4szb
 zr7/10UfX5vWujhkm2ZxAcxvKQw7ixz7jKOrez/XuGzbBtOmG1NMoewplhpGT6PD3i0N3175hYQ
 OSpc/mRBDhIxvXx83GnHHuWwfK2fXwqJXIY9ratEysPdGiqIhwcMbQlMXB52NEBsY/2tI0YLCuh
 zVjp1r1QqeWp30V9hPYo9tU8eWHqqz6ne1TXe8mxsyazljZw74BE9N6ZC0wLYpBYcaTnJJfkpmx
 tGJEvP7OIcAZYOBZoIgD2jo7mRbZk+T3YkX8jZsoDUaNenM8Gw=
X-Received: by 2002:a05:6a00:2887:b0:881:4b47:f30b with SMTP id
 d2e1a72fcca58-897c6443587mr17740292b3a.12.1792104566331; 
 Thu, 15 Oct 2026 15:49:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm207780b3a.32.2026.10.15.15.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 15:49:25 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:49:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 0/8] net/memif: lifecycle fixes and unit test
Message-ID: <20261015154923.110f698f@phoenix.local>
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


More from semi-manual AI code review.

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
