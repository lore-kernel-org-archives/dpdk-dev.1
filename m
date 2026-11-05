Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF003606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cJhYDIKv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661D640E20;
	Thu,  5 Nov 2026 15:46:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id C0B5840E20
 for <dev@dpdk.org>; Thu,  5 Nov 2026 15:46:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793889976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WIoMViBV9YVRiH7dgmJSiozRhVBT2ykUI3nZm2hkYvU=;
 b=cJhYDIKvGYGUSmhhQ8VApx1kF3BlaSge7heb6mkc7kSYZBTdS2kYnyKd5szbKdiYvGvJ30
 MVw1QC9E50EZhZP+z27/wh5dmfkTGitoSJp7Pql10LQ2k30CDoO13HvQZcpnWG8LiPsw6p
 9JzwHNbhW9uNujPNyHGYFUBzkKKjOeo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-q85mf9PAO9qFFhwgv46ApQ-1; Thu, 05 Nov 2026 09:46:12 -0500
X-MC-Unique: q85mf9PAO9qFFhwgv46ApQ-1
X-Mimecast-MFC-AGG-ID: q85mf9PAO9qFFhwgv46ApQ_1793889971
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3acb2e2030fso12418381fa.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 06:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889971; x=1794494771;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WIoMViBV9YVRiH7dgmJSiozRhVBT2ykUI3nZm2hkYvU=;
 b=gGgc2tz4aR/PCjFwsc/78D5NetjdRnzgHRqJGIoccgllLxp8HkRhNwWWS9UuyhagmF
 p0F91ZWtIs7iKQUYylwkk9M9d6J+Qb3yMf2Eu5n9cUMOIwpSdqTHwAUzdgLLBYH+qBtQ
 mTcMk5EAtzpxhS6FQ2YIEUPukuh63EN74TEc0fXfLtcKF6osd275kZTvjFzmPe3um9MJ
 qbpne9CLgRzlBJSo+v/auXHhGibwxmiql0eh2YcOeZaEA8sE9XKDGUet4aqJqyqqDozP
 Q/vDAJ+tYGk7KnNeDSukpRCEycliiPq50+JaZ6fsoPb62oV7JBsNd0lfIVoajw+PZGy1
 axhw==
X-Gm-Message-State: APuU4Z9vxLrFW0Zi0FrwGAO1+b1tb0HE5X53KbP2uG9eEExDepDfAneb
 Uh9OHiiHUP+d9rGsnaibZqZZFrEjuw2CFPR1tT5Aj8zSoFb8U6839dQNWMJlxlS8065itZSeAh8
 FFNpVzYmVZgHaLTbUnydbCdRVxLPblZIRWBnWQ+LCXQmNY5Y6mUpXczdxsj8Z+SyhCmefrzIboE
 gEeVrwq9+TN3lDaG9+1BY=
X-Gm-Gg: AYBFou0ocDTyooE/iQb5AT53zM3PsI9/AOAkc8em5w/4nMFRWQt/aUI1l/1PjXbCHCb
 3Z7KRAMFqS9TXyhgqeX1I7PBYzjLvwmU5XAHy2sDEcZ+qqDku+363GA6d1Izq+HBeB/uViI/kDG
 C87QBvR3f28tbfhqet8yKUc6zisBWM5cF+rupptpv3To38bXOSR57xbNKvSH2KURf5rqPjhp+W0
 3idy0bPafXO/rJBd2+fyFeFutSrLRfy/Zp7A0szJdZ4fEmp
X-Received: by 2002:a2e:be8a:0:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3acb7968255mr49302651fa.1.1793889970408; 
 Thu, 05 Nov 2026 06:46:10 -0800 (PST)
X-Received: by 2002:a2e:be8a:0:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3acb7968255mr49302551fa.1.1793889969869; Thu, 05 Nov 2026
 06:46:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261104132133.638ba480@stephen-xps.local>
In-Reply-To: <20261104132133.638ba480@stephen-xps.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Nov 2026 15:45:58 +0100
X-Gm-Features: AclHuK8aC3132wcLVGar35JH1D87AFJlsp1D6IxfOyQII0eavwytxf0lQXfYruw
Message-ID: <CAJFAV8x7LeDYhji4558PB+Qu8yaigwOe=W90jKNu53kCt9moRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/tap: fix FD leak on netns change
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7PWLioLgwfg-KEIOQpEZg1T_HMy9C4xwn-IQZ_tzdBk_1793889971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 13:21, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue,  3 Nov 2026 18:17:29 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > When a tap interface moves to another namespace, tap_netns_change()
> > calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
> > without first tearing down the old one. The previous LSC netlink
> > socket fd is never closed.
> >
> > Defer the full LSC teardown and re-registration to an alarm callback
> > which runs in the interrupt thread but outside any active source
> > context. The alarm switches to the device's network namespace, tears
> > down the old LSC handle, sets up a new one (opening a fresh netlink
> > socket in the correct namespace), restores the original namespace,
> > and forces carrier state back up.
> >
> > Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
> > namespace switch logic between tap_netns_change and the alarm.
> >
> > Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
>
> Saw some AI review issues:
>
> Review: net/tap: fix FD leak on netns change (2 patches)
>
> Series applies to main (26.11-rc2) and builds with -Dwerror=true at
> each commit. Fixes: tags are correct: aae3a38e9e03 is in v25.11, so
> Cc: stable on 1/2 is right; c663018eb7f3 is 26.11 only, so 2/2 needs
> none.
>
> Deferring the LSC re-registration to an alarm is the right approach.
> The alarm runs in the interrupt thread with no source active, so
> rte_intr_callback_unregister() completes, and the self-cancel in
> clean: returns EINPROGRESS instead of spinning.
>
>
> [PATCH 1/2] net/tap: fix FD leak on netns change
>
> Warning: setns()/open() failure now reported as "interface deleted"
>
> tap_dev_ns_switch() returns -1 for three different cases: no netns
> (interface gone), open("/proc/self/ns/net") failure, and setns()
> failure (e.g. EPERM without CAP_SYS_ADMIN). tap_netns_change() treats
> all of them as deletion, logs at INFO and returns 0. Before the patch
> the last two logged ERR with strerror(errno) and returned -1. Keep the
> logging in the helper:
>
>         *orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
>         if (*orig_netns_fd < 0) {
>                 TAP_LOG(ERR, "%s: failed to open original netns: %s",
>                         pmd->name, strerror(errno));
>                 close(netns_fd);
>                 return -1;
>         }
>
>         if (setns(netns_fd, CLONE_NEWNET) < 0) {
>                 TAP_LOG(ERR, "%s: failed to enter new netns: %s",
>                         pmd->name, strerror(errno));
>                 ...
>
> and return -ENOENT (no log) for the TUNGETDEVNETNS failure so the
> caller can tell deletion from error.

Regardless of the error, we are in an inconsistent state and the
caller can not recover.
I will add back some logs in the helper, but returning a different
error code is pointless.


> Warning: tap_dev_ns_restore() ignores setns() failure
>
> The old code logged ERR when switching back failed. Now it is silent,
> and if it fails the interrupt thread stays in the device's netns. Every
> later netlink socket opened from that thread (next LSC re-register,
> alarms) lands in the wrong namespace. Keep the error:
>
>         static void
>         tap_dev_ns_restore(struct pmd_internals *pmd, int orig_netns_fd)
>         {
>                 if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
>                         TAP_LOG(ERR, "%s: failed to return to original netns: %s",
>                                 pmd->name, strerror(errno));
>                 close(orig_netns_fd);
>         }
> Info: rte_eal_alarm_set() return value unchecked
>
> If it fails the LSC socket stays in the old namespace and no further
> link events arrive, with nothing in the log.
>
>         if (rte_eal_alarm_set(1, tap_lsc_register_alarm, dev) < 0)
>                 TAP_LOG(ERR, "%s: failed to schedule LSC re-registration",
>                         pmd->name);

Original code was light on the logging side.
I will add some error logs.


> Info: concurrent dev_stop window
> clean: cancels the alarm before the -EAGAIN retry loop. If dev_stop
> runs while tap_dev_intr_handler is active, the handler can arm the
> alarm after the cancel. In practice the alarm fires during the 100 ms
> rte_delay_ms() and the retry unregisters what it installed, but if the
> alarm runs as the stop thread wakes, both threads operate on
> pmd->intr_handle fd at once. Worth a comment, or a second
> rte_eal_alarm_cancel() before the do/while retry.

Well, that looks like a real issue.
Fixed.


> [PATCH 2/2] net/tap: fix use after free on interrupt handle
>
> Info: commit message does not mention the fd < 0 early return
>
> The new check in clean: is needed because close after stop now reaches
> the unregister loop with fd == -1, where rte_intr_callback_unregister()
> returns -EINVAL and logs "Unregistering with invalid input parameter"
> plus the driver's "intr callback unregister failed". Add a sentence
> saying so.

This added check is actually misplaced and belongs to first patch.


-- 
David Marchand

