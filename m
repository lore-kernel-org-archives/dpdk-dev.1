Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC7606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e4ATsg9u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4615A4028F;
	Mon,  9 Nov 2026 19:19:48 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 06CAE40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 19:19:47 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8b58d6f67a5so693404b3a.2
 for <dev@dpdk.org>; Mon, 09 Nov 2026 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794248385;
 x=1794853185; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xCj3JkX/rxciQj0zqJWz8TcQsUvTAZY9Y14Jm3SMfuM=;
 b=e4ATsg9uCcRSLXbYs3ysfHs0zD2E2Gtcls10OIAjwCWij9UDC+SqCz2qCDstTiVh+y
 9kzQKQsOx67j5BuzOB9jBDA9O2derN+Sv6fjXoEX3vbRDnetBxWwph7lqqpkOEVPBQYB
 2Hf0zWtkp0+MicihtmNyWEZLPNO4t0VW3/+MipE+wTIRVdzYV7YByz2V7lpRtdoLo8FJ
 xqFZZaCuqlwWG6BA25eAc1o/OQM+tfLZ+TGJesnsaApgXyQ1KtqKli0L1/FNX9N4Ues/
 ozWDavpmIQ78249XJcQX8yXwDWic2jmoke4R86c4/Daod0QYCBm2NJQ6SISrDHrqmw5d
 W5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794248385; x=1794853185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xCj3JkX/rxciQj0zqJWz8TcQsUvTAZY9Y14Jm3SMfuM=;
 b=LpnXzdt0MDp2PPBoa3Ox5cRLptGslgTkkr//qMSv8XY7E5SSv3TustcA/z7KFV+LmF
 fcKs0UeBhMa5yOCs8Dr9VUCp6FWPulAFbFjAGbB/I6sRxIxZmkvsrttzv3bKMiGOdzzJ
 7JTg51dCjOVdBr2nKyrgy7pANGmNOSc5VNU/l0gzttE+v1KN1Z8DVkpxZo8JO0RBfRpb
 rFG6oLr/aPREeRiFg5xlPn5RrvjnxXExOfYn2g7C2eyv8w3QDp022OfTteop6O2XLP51
 JMQ+qAuJz2/r8HVcRDshACqPHLpZm0vmywd2L4TLYrTzcqfsGWQLfbCMZsRtftO5j9Wx
 Witw==
X-Gm-Message-State: APuU4Z88wcr1+bMDFkNUYfVvoqIliv029NBr2SfcQ/wy6S0o7H35TgPv
 48OyLTRTm2E/iImExJoG19azRbZ/Pk1vqVtC2GSTwaUA0A97uzPEXUAerADh517n7ho=
X-Gm-Gg: AYBFou2HBdq0d/F5Hlz+XzJkpYjRSfkn2+csaTtT7kYRCgyUTYciu2WtXts60flMrVg
 tAWLyCgbCyW3+IniSP1MOzm39RCdFE21qyW5VfSA46TMUZSxtlM2+ZNwPA9vwAjOCSdQq/9aVY1
 W67BPaO/23qnxTBjQN9CPeek0qmAunl6EY/wtpJw0E8CMo9vq8KtxfS52jOWnv7ro12YylN7swE
 avPDmgR6MGtSoUnITrYcCYWxuLZ9L+G1k5byrIb0mRHlnKdFDBffmIhU5a9ZqyPOFhnqaCACH0c
 9IiRGRlXi9yfbN4rl7qB/XBk9jNfqn9KuWqDX5I6krKBWf2IPxeJ2ZOdgDdGr5RH9NGDQpRuQO5
 maKwRvAIUg9bds5xmub2LzZ8Zf0m2BxabX8OSTHnVbEArpkXEFetZ1Tjemnt4PnRktyNYCl1xO6
 v05we4U6zp9uSYd/XeGOJROeQz1Kyn5iLdjf0cC4BiT/p78hYXtDp2YDNQV1l5AbW2ureLt+UPz
 IHsYDcQj3EPoeo6wJbmFeAk6A1wi823ICjFjfoZ6aijpGKaVpzji973xTizLq6Vyq2HGtOw8xqh
 ESncW7U8e8uv0nHvitmRvIZmIsNXIbdCoJCQPtgc+GNAqXh+dneEQ6VbUTlnFixxO/8zSlsn
X-Received: by 2002:a05:6a00:3499:b0:8a0:3ed7:93a0 with SMTP id
 d2e1a72fcca58-8ba87d15973mr352320b3a.48.1794248385330; 
 Mon, 09 Nov 2026 10:19:45 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa7bf82b1sm12038b3a.8.2026.11.09.10.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:19:45 -0800 (PST)
Date: Mon, 9 Nov 2026 10:19:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
Subject: Re: [PATCH v2 1/2] net/tap: fix FD leak on netns change
Message-ID: <20261109101942.53767a42@phoenix.local>
In-Reply-To: <20261106085701.2429186-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261106085701.2429186-1-david.marchand@redhat.com>
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

On Fri,  6 Nov 2026 09:56:59 +0100
David Marchand <david.marchand@redhat.com> wrote:

> When a tap interface moves to another namespace, tap_netns_change()
> calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
> without first tearing down the old one. The previous LSC netlink
> socket fd is never closed.
> 
> Defer the full LSC teardown and re-registration to an alarm callback
> which runs in the interrupt thread but outside any active source
> context. The alarm switches to the device's network namespace, tears
> down the old LSC handle, sets up a new one (opening a fresh netlink
> socket in the correct namespace), restores the original namespace,
> and forces carrier state back up.
> 
> Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
> namespace switch logic between tap_netns_change and the alarm.
> 
> Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---

AI review still seeing errors.

Review of [PATCH v2 0/2] net/tap: FD leak and interrupt UAF fixes

Applied to main (v26.11-rc2), both commits build with -Dwerror=true.

[PATCH v2 1/2] net/tap: fix FD leak on netns change

Error

The deferred alarm can run concurrently with the LSC teardown done by
dev_stop/dev_close and re-register the callback after the control
thread has removed it. The second rte_eal_alarm_cancel() added in v2
waits for a running alarm but does not undo what it did.

  ctrl thread (dev_stop)            intr thread
  ----------------------            -----------
  rte_eal_alarm_cancel() /* none */
                                    tap_dev_intr_handler()
                                      tap_netns_change()
                                        rte_eal_alarm_set(1, ...)
  rte_intr_callback_unregister()
    -> success (not active)
                                    tap_lsc_register_alarm()
                                      tap_lsc_intr_handle_set(dev, 0)
                                        unregister -> -ENOENT
                                        close old fd, fd = -1
                                      tap_lsc_intr_handle_set(dev, 1)
                                        new fd, callback registered
  rte_eal_alarm_cancel()
    /* spins until alarm done, returns 0 */
  tap_nl_final(new fd); fd = -1

The port is left stopped with tap_dev_intr_handler still registered on
pmd->intr_handle with fd -1, and the carrier forced up. A following
tap_dev_close() then does rte_intr_instance_free() with the callback
still registered, which is the use after free patch 2 fixes.

Repeat the teardown until the fd is stable once no alarm is pending or
running, and treat -ENOENT as already unregistered:

clean:
	for (;;) {
		rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
		fd = rte_intr_fd_get(pmd->intr_handle);
		if (fd < 0)
			return 0;

		do {
			ret = rte_intr_callback_unregister(pmd->intr_handle,
				tap_dev_intr_handler, dev);
			if (ret >= 0 || ret == -ENOENT)
				break;
			if (ret != -EAGAIN) {
				TAP_LOG(ERR, "intr callback unregister failed: %d",
					ret);
				break;
			}
			rte_delay_ms(100);
		} while (true);

		/* alarm may have replaced the fd while unregistering */
		rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
		if (rte_intr_fd_get(pmd->intr_handle) == fd)
			break;
	}

	tap_nl_final(fd);
	/* fd has been closed already, only clear reference here. */
	rte_intr_fd_set(pmd->intr_handle, -1);
	return 0;

When called from the alarm itself the cancel returns with EINPROGRESS,
the fd does not change, and the loop exits on the first pass.

Review-Result: ERROR
