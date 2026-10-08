Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7258CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 22:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F1734021F;
	Fri,  9 Oct 2026 00:09:35 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7FEEE40144
 for <dev@dpdk.org>; Fri,  9 Oct 2026 00:09:34 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-88b8f0a1bcdso2744972b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791497373;
 x=1792102173; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RfbVFi1HFv/uq0Vjo56ANWtqho23VfqyKanMvC2aqtU=;
 b=zha6FO9e1VvmAhZBzWSD27P662/RZ8M0Q9vz21OZQlalO7+j1f27oTnPpTk7PZkt1d
 sDHsbaC8uYy4v4dxcdYRAStCTizQwg/iozq288lACWNh1k/K6tsQP0Ysp1bL4KkYFJXT
 XlrBkWXAygdL+yv69n9nKbcrRAEiOENCtfkKZWAtSjATVLXhTwqnXSFf7QHFEQyyLOtz
 9JuJuP9P0iL1AXqxEU12JNXVQzUnBjwTLFBZ2hx9u4ALW9lCJpnWaCnLaCQIvzwNBb5i
 cWcjzRUq4+FPyFxGwJ/RKLA07aLBUeFWTL2niABPtO7/6N7xfy509JmFOleJ26Jsb/I9
 dcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791497373; x=1792102173;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RfbVFi1HFv/uq0Vjo56ANWtqho23VfqyKanMvC2aqtU=;
 b=ka0/Av7m5MmWOaeETSklmoI7ZdBzWswsKd6xXfrEs7jUja8tg4cHQHM4iREhWkSD7V
 MegQ7H2iTgV859Dg+K4tWcLcA6PDxvMIVpkpZt/I4LETJqoRnPjI5a1tKRhVpveAXP0U
 QWGJHeyWGSxqWImT4r0MnFdPmwmKAzyZXZTW134cztorn3gz0WesTyH+zqD9fg+as7+f
 LN+6iXR1vT8Qe2uyAV2qdq7v6Lx5oTaHLjj8aTGahWkRS+GZn7deO5ruBulUkK79ST8P
 xPH/r9qTn7r2MHBAA0HaDeH7MAlyyI1GPpeH7oF73uUz3cVyT3GGQde6KvxgFD18c1ih
 z6Qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaNqyL72Ol85IHh12T7Uhea7xlhzatBrMS1rCrllg3pqEAD3d6TJKYwqAAbbkGMvwQTRM=@dpdk.org
X-Gm-Message-State: AFq9FYJtu/44kjtz9ePCZrIlyGe03qIYfJAQ7GoBnFzkwkhH0umxA2GP
 mATfPWk6e5Op3GqEmOTrjSA9xNKB02ICZ8VigRlCCsBnE2ewVcWxnobh+yBSyMRV3e4=
X-Gm-Gg: AYBFou2AXTRq3UxailIyKcSdNPJ7zvgAcIb1lNkKkGhdDTWciMngs1fcMgLT3V/SO6p
 Udo/Div00hleUt22WEeS2L+t4dLaNrxzJkm/Jr7c6KdP1EL/rYDz8bhhak3035V7TdtQmsiru7j
 jTMGkcwrY2cQRuGwrHT+W/RkY6Xjy6Zcb8xxLvwK7n1WGCwcRXbpmhIDHRP/gstq81qeId6JEvf
 TZcliRDmu/lzliCTlKZ73qjTla5YNB/0eREdbBDStUHWFfxYas8mwwDZmyD0+gK3xaEYT6Jbqfo
 V+pxQDH1o7B/L6sptUw5mlQiUlvunYZn4cwD9mjhoKpsMVhhqbgf/dtgCXX5ijM9jHjBzrXo2Y8
 g1ulK7F9pT38ThhHkX5s7qlAIh9lMBcS8Tbh1H0NmtuHKdk56PKrkaMrmDRSRjPaBsGLHWBEQyN
 fF4GkMkrBIWpmWYF025LBKvesMa98KBbUMc+7Ejb1pXglR1TMIUGFIBvsY+EDOtx16ammEbZHCK
 nx0hkJxygW+btauC8f8LkVUN2stJgABP4YrZ76x
X-Received: by 2002:a05:6a00:c4c2:b0:892:fc00:6e67 with SMTP id
 d2e1a72fcca58-892fc007424mr2451729b3a.31.1791497373154; 
 Thu, 08 Oct 2026 15:09:33 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c479c2cdsm130956b3a.55.2026.10.08.15.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:09:32 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:09:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v22 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261008150920.4ac81e86@phoenix.local>
In-Reply-To: <20261007072439.3135351-1-hemant.agrawal@nxp.com>
References: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261007072439.3135351-1-hemant.agrawal@nxp.com>
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

On Wed,  7 Oct 2026 12:54:12 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.


Really close the AI review is only complaining about stuff in the commit messages.

Applies cleanly to main (1bad527).  HEAD and each of the 27 commits
build with -Dwerror=true (gcc 13.3, x86) for the DPAA drivers.  Not
built for arm64.

v22 addresses the v21 items.  25/27 and 26/27 now release an FQID
only after its queue shut down, 11/27 documents the probe behaviour
change, and 27/27 covers the new FMCLESS default.  Ignore the 17/27
item from the v21 review: RTE_FINI_PRIO() token-pastes the priority
onto RTE_PRIORITY_, so the local define is needed.

What remains is commit message text in 01 and 11, plus minor items.

Warning
-------

Patch 01/27: The rewritten message names the wrong trigger for the
  NULL dereference.  dpaa_bus_cleanup() calls remove only for probed
  devices (rte_dev_is_probed()), so a device that was never probed
  does not get here.  The real case is normal shutdown:
  rte_eth_dev_close() releases the port, so at rte_eal_cleanup()
  rte_eth_dev_allocated() returns NULL.  Suggest:

    The unconditional call also dereferenced eth_dev without checking
    that rte_eth_dev_allocated() found anything. rte_eth_dev_close()
    releases the port, so an application that closed its ports before
    rte_eal_cleanup() crashed in remove.

Patch 11/27: The new paragraph gives the wrong reason for failing
  the probe.  qman_create_cgr() returns an error only before
  list_add(), so a CGR whose creation failed is never linked.  The
  hazard is the error path this patch adds, which deletes one CGR per
  initialised queue; the in-code comment already says so.  Suggest:

    This also changes probe behaviour: a qman_create_cgr() failure in
    dpaa_rx_queue_init() or dpaa_tx_queue_init() now fails the probe
    instead of continuing without tail drop on that queue. The probe
    error path deletes one CGR per initialised queue, and a CGR whose
    creation failed was never linked into the portal list.

Info
----

Patch 26/27: The commit message says range allocation reduces boot
  and quit time, but dpaa_sec_uninit() now releases each FQID with
  its own ioctl, 4096 of them for inq[].  Releasing contiguous runs
  keeps the per-queue check:

	uint32_t base = 0, run = 0;

	for (i = 0; i < RTE_DPAA_MAX_RX_QUEUE; i++) {
		fqid = internals->inq[i].fqid;
		if (run && fqid != base + run) {
			qman_release_fqid_range(base, run);
			run = 0;
		}
		if (!fqid || qman_shutdown_fq(&internals->inq[i]))
			continue;	/* log as now */
		if (run++ == 0)
			base = fqid;
	}
	if (run)
		qman_release_fqid_range(base, run);

  Or drop "quit" from the commit message.

Patch 25/27: qman_create_fq() also takes an FQ lookup table entry on
  64-bit builds, and only qman_destroy_fq() clears it.  No DPAA
  driver calls that, because qman_shutdown_fq() leaves fq->state
  untouched and qman_destroy_fq() then does nothing.  Each oldev
  probe/close cycle leaks two of the 32K entries; dpaa_sec leaks
  4098 per cycle (pre-existing).  If qman_shutdown_fq() set
  fq->state = qman_fq_state_oos on success, drivers could call
  qman_destroy_fq(), which already releases a dynamic FQID and the
  lookup entry.

Pre-existing, not introduced here: in FMCLESS mode net/dpaa never
releases the Rx FQIDs it gets from qman_alloc_fqid_range(), on close
or on probe failure.
