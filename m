Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACE606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hKBJV7hu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F89A40285;
	Mon,  9 Nov 2026 23:16:54 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 0FAFA40283
 for <dev@dpdk.org>; Mon,  9 Nov 2026 23:16:53 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso551238b3a.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794262611;
 x=1794867411; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fdskUvt/fmlmCYUzjniDTYUdPWR7wtAmTQ496Po/seE=;
 b=hKBJV7hue/igLQGeOrvl7E2NbzfHdLCFFXKmQjrTt2eznVYomj3rpSh3NGFDfF0ydN
 H6RgVpOltPVsl2jIRcMpk16rxQCIwcdq5dqTlkiWTRG9oYKxQUpYLoFWnVtO2vLFg3fy
 pIWV1o1JNNcYd8CdsBBL50lS25wrULE0fvznTN+mhkbdS8F6TQEhQ8B59IuKfYmTin66
 yp8NKvUNQs/2K8uRUK9oAV60BiU5ejFRQQKbrdn+iH272Lkc2lGMjXMVDScHXpx92Huj
 iPaimZ0kS3LbyVrhAJAazgda9F0Kjcyt5iAfoxdhd6bZTu6YBc9V+kMCYsjAo81YtzA1
 4JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794262611; x=1794867411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdskUvt/fmlmCYUzjniDTYUdPWR7wtAmTQ496Po/seE=;
 b=llvF/no9l/U2SellA8AckyGon8LTsIc7566r7GoDBlM2AU9AMOJE9I5Ri/Jcjtf+RN
 1cvMlutV5h/wjdNkZ9UNZKkZ04xVXA7qWH1lY2ywtt1dlKSumogIncWUomULP6Qv7hWB
 jmHzNOpcFGhzlq7geDKD8K1Cvqvi6WYLIDi1x2Xhng9tBwnfHcQP14h9rTPTpd+tx3hP
 H+ceAgOFtJUQ4C/TWYy1RTGhjAwWg0he+Rs/ZEFAzMoYF3tdOtLn6jS4XFeqRQDHWOIJ
 2HJ9KRnxTMG+F+ltx3MgvJ+eiTWKmnPz6t/x7EEZ81ZyNYo+azAoh1Uqph2dhRoycJyS
 4Q4g==
X-Gm-Message-State: APuU4Z+n0x6YZOVejwRvhD4myeoWqO+jfwkENd82DddzghyoIvEmbrFF
 bMW8B6Yj/uTv0dloxpsXp6X3Eonge3P7296D+SLB9QHIPGSQ/TK8zieNcCd1MeMHntw=
X-Gm-Gg: AYBFou3F+JlDUtqK4T5gLqdLl0MHnmIM4MNzQRBhCCVluHB79cr5eY77i5XImq73VUW
 FBjs498uVTZGkW+UGP5yajmwN6Z+Hkpe39yj4Fxx2KE6nlw/XQ1gnyeS0343bkdSorlnarhw6r/
 J5564ZMMa59ec0H6h+8Q/nNidSQsOCX/EmgXiqFEaqJtvuXpIc91eRyIpC9EOEnuTeypSTyjn4M
 3xEBuHGTmBzzs1QgmpeCaNrMIdpilGe0KJ33kl1rGe4c2h76jlfVLHj8rVe7Y2W22+qSrnKZL62
 tRHlpqwKmcg24s6Bfep7frr6FB8c4hfpPE32YWJz05pQ4t/zrs2WbXuTyJ9Mb4yE2KCI/gnPxNj
 A1gJgRRHh1laSLfqMwK+n8DPHowxu6gv0Y7nBHgoHn5I912qIbbSbSZpW31N8RfbIp8TqrqMXQS
 XvPF5ZYyAxV3SNIEgkJp6cWID8CtlT9aufwg7yBoR4SvD7l9AGG1PT4WpS+HdAqjW7dpMyAmq00
 ffvJ+BWq0QgYxIO7y3Zo3O0CbkoQfjMrVuqhAaftBGyt55V8fXi5GuOITmhP1x3npRfxNzeBO+c
 rA0Tn37lRhoZP056MHEaYLoXHn8RRlT3ThhnbXpK/ai4XTCTcwXJ+Mit2uxxWA6L8NIWyQ==
X-Received: by 2002:a05:6a00:2341:b0:874:32d1:d3d8 with SMTP id
 d2e1a72fcca58-8ba867ab119mr898467b3a.21.1794262611325; 
 Mon, 09 Nov 2026 14:16:51 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab1226e6sm135636b3a.43.2026.11.09.14.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:16:51 -0800 (PST)
Date: Mon, 9 Nov 2026 14:16:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, David Marchand
 <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/memif: redesign control channel teardown
Message-ID: <20261109141645.78f3a7ce@phoenix.local>
In-Reply-To: <20261105112026.432015-1-sriram.yagnaraman@ericsson.com>
References: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
 <20261105112026.432015-1-sriram.yagnaraman@ericsson.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 12:20:26 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> The control channel can be torn down from two threads: the EAL interrupt
> thread (memif_intr_handler on peer disconnect/error) and an application
> thread (dev_stop/dev_close -> memif_disconnect). Both race to unregister
> the callback and free the channel, which memif_pmd_autotest SIGSEGVs on
> during EAL teardown (seen on amd64 and arm64).
> 
> Rework teardown around a single owner:
> 
>   - memif_disconnect() clears pmd->cc under cc_lock; whoever clears it
>     owns the free.
>   - Device teardown (link down, flags, queue eventfds, regions) moves to
>     memif_disconnect_queues(), run by whichever thread owns the
>     disconnect, so flag/link state is left consistent for reconnect.
>   - memif_cc_release() frees the channel: unregister_pending() on the
>     interrupt thread (deferred free, drops the fd from epoll after
>     dispatch), unregister_sync() on an application thread.
>   - memif_intr_handler() self-unregisters on disconnect so the EOF
>     (level-triggered) socket fd cannot re-fire (no livelock).
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

AI found an error here..



[PATCH v2] net/memif: redesign control channel teardown

Error: the application thread no longer waits for the handler once the
handler has taken ownership, so the reported SIGSEGV is still reachable.

  owned = (pmd->cc == cc);
  if (owned)
          pmd->cc = NULL;
  ...
  if (owned)
          memif_disconnect_queues(cc->dev);

Peer hangs up, handler clears pmd->cc and runs
memif_disconnect_queues() after dropping cc_lock. Meanwhile dev_stop
-> memif_disconnect() finds cc == NULL, skips memif_cc_release() and
calls memif_disconnect_queues(dev) concurrently. memif_free_regions()
then does munmap/close/rte_free on the same regions from two threads.
dev_close followed by port release frees dev->data while the handler
is still inside memif_disconnect_queues(cc->dev), which is the original
memif_pmd_autotest crash. The "Idempotent ... safe to run from
whichever thread" comment is not true; idempotent is not thread safe.

Do the device teardown under cc_lock in both paths, and have the
handler touch only cc after it drops the lock:

  /* handler */
  rte_spinlock_lock(&pmd->cc_lock);
  owned = (pmd->cc == cc);
  if (owned) {
          pmd->cc = NULL;
          memif_disconnect_queues(cc->dev);
  }
  rte_spinlock_unlock(&pmd->cc_lock);
  rte_intr_callback_unregister_pending(cc->intr_handle,
          memif_intr_handler, cc,
          owned ? memif_intr_unregister_handler : NULL);

  /* memif_disconnect(), after memif_cc_release() */
  rte_spinlock_lock(&pmd->cc_lock);
  memif_disconnect_queues(dev);
  rte_spinlock_unlock(&pmd->cc_lock);

Error: pmd->cc is set to NULL while the handler may still be running
and the handler dereferences pmd->cc.

  cc = pmd->cc;
  pmd->cc = NULL;

The application thread then waits in rte_intr_callback_unregister_sync()
on the assumption the handler is safe. It is not: memif_msg_receive()
on HELLO/INIT/ADD_REGION/ADD_RING/CONNECT calls memif_msg_enq_ack(),
memif_msg_enq_init(), memif_msg_enq_add_region(),
memif_msg_enq_add_ring(), memif_msg_enq_connect() and
memif_msg_enq_connected(), all of which do

  struct memif_msg_queue_elt *e = memif_msg_enq(pmd->cc);

and memif_msg_enq() does TAILQ_INSERT_TAIL(&cc->msg_queue, ...) on
NULL. Pass the channel down instead of re-reading pmd->cc on the
interrupt thread, e.g. memif_msg_enq_ack(cc) using cc->dev for pmd.
The channel stays valid until unregister_sync() returns.

Error: memif_cc_release() leaks the channel when memif_disconnect()
runs on the interrupt thread for a source that is not dispatching.

  if (rte_thread_is_intr()) {
          ret = rte_intr_callback_unregister_pending(ih,

memif_bad_desc_disconnect() is an EAL alarm, and alarms run on the
interrupt thread. The active source is the alarm timerfd, not the
control socket, so unregister_pending() returns -EAGAIN. pmd->cc is
already NULL, the callback stays registered and cc is never freed.
When the peer later closes, the handler sees owned == false and
passes a NULL free callback, so cc and its fd leak; if the port was
released first, the handler dereferences cc->dev->data after free.
The old code tried rte_intr_callback_unregister() first. Keep that:

  if (rte_thread_is_intr()) {
          ret = rte_intr_callback_unregister(ih,
                          memif_intr_handler, cc);
          if (ret == -EAGAIN)
                  ret = rte_intr_callback_unregister_pending(ih,
                                  memif_intr_handler, cc,
                                  memif_intr_unregister_handler);
          else if (ret > 0)
                  memif_intr_unregister_handler(ih, cc);
  }

Warning: on a protocol error the peer no longer gets the DISCONNECT
message with the reason.

  memif_disconnect_queues(cc->dev);

memif_msg_receive() queues a disconnect ("Invalid message size",
"Unknown message type", "Incorrect secret", ...) and returns -1, which
goes straight to the disconnect label. The old code called
memif_disconnect(), which dropped the other queued messages and sent
the DISCONNECT. The new handler path never calls
memif_msg_send_from_queue(), and memif_intr_unregister_handler() frees
the queued message. The peer now sees a bare EOF. Flush the
disconnect message in the owned branch before the teardown.

Warning: v1 had "Fixes: 09c7e63a71f9" and "Cc: stable@dpdk.org"; v2
dropped both. The race is in released versions; restore them.

Info: pre-existing, not introduced by this patch. The single-owner
model needs every write of pmd->cc under cc_lock, but
memif_msg_receive_init() still does

  pmd->cc = cc;

without the lock. A server port being stopped can have a new channel
attached after memif_disconnect() has already looked at pmd->cc.
