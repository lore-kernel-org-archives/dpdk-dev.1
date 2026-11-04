Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0C606A32E
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DBR7D+Lv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2471340281;
	Wed,  4 Nov 2026 13:21:39 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 521214025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 13:21:37 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c434376dbebso117317166b.1
 for <dev@dpdk.org>; Wed, 04 Nov 2026 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793794897;
 x=1794399697; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uoH3PaHnSwmOvXeimFQAH0eJpbDC9rEScU4C0gPBVvU=;
 b=DBR7D+Lv5qzo2oraHjq1rfsUqnJCkc7p7tcu0N1WFt661JglLjUO1VYYbHfKSodCRE
 aKCOT90aqXEM36A29zCVlD/QI926JZyQvNtHPJ9qrHdtjbw4IMM9szPgYSp1eLojpvhf
 rwC9Hcqw5Okh1kPrsI3zlhX4tiFklxAcHdo3ZBPeEa462PluiXGbHUNPaEIAX+Dbv7nw
 Wv7lE7dyZ/M18tAPh6YJa+Kw1crrJiU55MwVzSEcTGn2Zg3316xJdOX9uyH5hDb41R3K
 uiN6YzBGaaMChNuVorc5wgML/5/bYgRMWDnRJDdokCSjt+RA56CtxJ7Qnnb6NMe3SyHX
 7e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794897; x=1794399697;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uoH3PaHnSwmOvXeimFQAH0eJpbDC9rEScU4C0gPBVvU=;
 b=pDyyQVjNMLmM68TLaq/OulruaXnjyR5/yfND4nMR+fH5/Zc3726NYOzKobRSuvVuHm
 tAJbVEUwVD2iRJyneqQJkIDiH/ZZGQqcqKJ9PBfcXv+evtg7+iH+0PIvVUDVDp4ER4zT
 EDocv4IqE+DK7npHDIZgb65Tiw8jwWgnNMyzb31WLxBy5Z8hXL2iN/s8QzC6U1yKsOAp
 5al3i5eS7IJoDgftFRRVzPcO+/Bz+2dUquTTulWBH/xnnVfp31pfbt8uWgejRoBmmLin
 mM0IHcGNaD23CaEQ5CZom9IbYHA/0zk7olVSpbanLIqbrUZlYOCDOz/8P80TrTCU+yU4
 p3sg==
X-Gm-Message-State: APuU4Z+EzaQnarLnJ9qoOC3h7b8flvqda9deRb9GaXAGkW1E7cSro9Qb
 2ig9AgLjbXvGN3kvOVPJhfJOg4rFo/r1OA1RMSMeV0oQRDuyJRUGAyP4MPZQ+rofzFo=
X-Gm-Gg: AYBFou00EcGL6ADsa6DyxZ6ugO5ObnEG4h1aTzCp+6lb06XeEDkPuFzByFev1SC9EaH
 G2t5uh8Lll7GPBVzLDhiFvvga0rBSkVAqw7HPZUEkSNW1kBurlMx5s2pxUeDQbxEtsMiKu4G9C+
 teYe2tXro27EjEPvxBwaeIztKPRRSmVnMDXDd8EaHC2nkTp0A4U+Rldk2vi1MEDhnCSZrl7O6oN
 pcDECJHomNdTZPOyukCaCABJi79Dne2Algv3Lgu+WggFvL4BgKaHKLaDlOVS4h4+CS3nr+ZT0nb
 aaObcFqiDgVGo82XahzFmAGouu1kgqvi8S48WbZkpSC1/bQVxO1shhcQDno+OSrDtfrvyRnN58g
 qfzPxjcakocop+mtRTTn+Y+ggnqTmmAQaB3UNiepBE99xM/Op3yskV9VdzGPMT85/Pp821hQDDi
 OT6XjZqrd5r4tQw0sVHZrZ5BOyGpk4BjjNsR9bDXo5XCXJZcQGS5ZB0A1FQfOWK1BP1kHJcpKqT
 1VC/sidxXMrb25fKquLzN2gUckJorTfGDq77ljDYLKNvUH2AxmGGObtwZE9midXjoR8s4yZ4oS9
 lmu2LeBzLIoz3bo7BlYR35sMVPRRFKaXYnHOqaRbEdT/XAen5XKVikLf0fGSAB32rU9JJ4dqa1J
 5lc8jU2sXLQuCkJ8=
X-Received: by 2002:a17:907:7f9e:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c49d1285bb1mr1742588366b.6.1793794896666; 
 Wed, 04 Nov 2026 04:21:36 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e41de48sm63030766b.25.2026.11.04.04.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:21:36 -0800 (PST)
Date: Wed, 4 Nov 2026 13:21:33 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, stable@dpdk.org
Subject: Re: [PATCH 1/2] net/tap: fix FD leak on netns change
Message-ID: <20261104132133.638ba480@stephen-xps.local>
In-Reply-To: <20261103171730.1361878-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
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

On Tue,  3 Nov 2026 18:17:29 +0100
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


Saw some AI review issues:

Review: net/tap: fix FD leak on netns change (2 patches)

Series applies to main (26.11-rc2) and builds with -Dwerror=true at
each commit. Fixes: tags are correct: aae3a38e9e03 is in v25.11, so
Cc: stable on 1/2 is right; c663018eb7f3 is 26.11 only, so 2/2 needs
none.

Deferring the LSC re-registration to an alarm is the right approach.
The alarm runs in the interrupt thread with no source active, so
rte_intr_callback_unregister() completes, and the self-cancel in
clean: returns EINPROGRESS instead of spinning.


[PATCH 1/2] net/tap: fix FD leak on netns change

Warning: setns()/open() failure now reported as "interface deleted"

tap_dev_ns_switch() returns -1 for three different cases: no netns
(interface gone), open("/proc/self/ns/net") failure, and setns()
failure (e.g. EPERM without CAP_SYS_ADMIN). tap_netns_change() treats
all of them as deletion, logs at INFO and returns 0. Before the patch
the last two logged ERR with strerror(errno) and returned -1. Keep the
logging in the helper:

	*orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
	if (*orig_netns_fd < 0) {
		TAP_LOG(ERR, "%s: failed to open original netns: %s",
			pmd->name, strerror(errno));
		close(netns_fd);
		return -1;
	}

	if (setns(netns_fd, CLONE_NEWNET) < 0) {
		TAP_LOG(ERR, "%s: failed to enter new netns: %s",
			pmd->name, strerror(errno));
		...

and return -ENOENT (no log) for the TUNGETDEVNETNS failure so the
caller can tell deletion from error.

Warning: tap_dev_ns_restore() ignores setns() failure

The old code logged ERR when switching back failed. Now it is silent,
and if it fails the interrupt thread stays in the device's netns. Every
later netlink socket opened from that thread (next LSC re-register,
alarms) lands in the wrong namespace. Keep the error:

	static void
	tap_dev_ns_restore(struct pmd_internals *pmd, int orig_netns_fd)
	{
		if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
			TAP_LOG(ERR, "%s: failed to return to original netns: %s",
				pmd->name, strerror(errno));
		close(orig_netns_fd);
	}

Info: rte_eal_alarm_set() return value unchecked

If it fails the LSC socket stays in the old namespace and no further
link events arrive, with nothing in the log.

	if (rte_eal_alarm_set(1, tap_lsc_register_alarm, dev) < 0)
		TAP_LOG(ERR, "%s: failed to schedule LSC re-registration",
			pmd->name);

Info: concurrent dev_stop window

clean: cancels the alarm before the -EAGAIN retry loop. If dev_stop
runs while tap_dev_intr_handler is active, the handler can arm the
alarm after the cancel. In practice the alarm fires during the 100 ms
rte_delay_ms() and the retry unregisters what it installed, but if the
alarm runs as the stop thread wakes, both threads operate on
pmd->intr_handle fd at once. Worth a comment, or a second
rte_eal_alarm_cancel() before the do/while retry.


[PATCH 2/2] net/tap: fix use after free on interrupt handle

Info: commit message does not mention the fd < 0 early return

The new check in clean: is needed because close after stop now reaches
the unregister loop with fd == -1, where rte_intr_callback_unregister()
returns -EINVAL and logs "Unregistering with invalid input parameter"
plus the driver's "intr callback unregister failed". Add a sentence
saying so.


