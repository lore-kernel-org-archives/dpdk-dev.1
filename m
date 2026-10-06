Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D4D40262;
	Tue,  6 Oct 2026 17:01:50 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3776A4025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:01:49 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-88bf90b7f07so298523b3a.3
 for <dev@dpdk.org>; Tue, 06 Oct 2026 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791298908;
 x=1791903708; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ymrzpb65RH5FdNELPVYJ87QS2ucMvl6jmEbheEzb2tg=;
 b=s0iOJTvCgJnPZFb28ZxVbjimvXx3cm8qFsFPJyHVGeLyx1UXya2C+3OSWtWuIyJy4M
 WO/UNnwoVT5qYinM/YkNnY19KbIfPM2WUCc3QUO4VnKWhdXaxY1BvbF0huunEi3fNvpI
 ROb7/wcJ2J0bkgD4petw/ZEFt5nGBK7HwIb6J5+KdGuglUhTeZs89l0bRdrKM9m1Hhar
 PxcYfFXvZrjwSg9jJGX/6psjuTN9lMWGsfQlAFbm0mizh5hunrWJG0sOPoJ6J6K6ncW5
 c11WjIUVxh7/sas0KfOLEVjfmuJXzkcrUX3te8YI98FQsTv2nsIhzYQ+MAbCMkPtpTF8
 TdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298908; x=1791903708;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ymrzpb65RH5FdNELPVYJ87QS2ucMvl6jmEbheEzb2tg=;
 b=NUmS228HTuBd5SHhqJjpN4AIdOwd24gRWF2N2W4KORLatFOI2FNip65peuLH0ZmrwI
 r0Ugmp0bLRqZAzqnAz3/yxtvqy8qtwwOrggBtgdBJq5oPiEek/c//L9Wpi+JRi6IsjRw
 hjsoQ5M+HU5cvleTLl+8zyzH/wBHZBGmqCYE1Q36axDz9wKQk2XoC9GO6fo398orr0Cx
 zOJ4vbbsbJ0rDrPBs7M/DxotAOsYhtzb5IPIfsWPt1U4eUQGr15he6E1yZIJQCU28Bvk
 0RWiVSBfsXsL39QaJ2u/QJHtbtMB8gq2/aoeZrpnL/9L5LwEzmoemeuyo3CrQ3p0uVsi
 ibfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBymN7l1CjcB7ubZBAudWgY6YnzcnzBu3ejkLoU+KO1ZsCiSfmZXuqPOrKm5qz/hWNi9gEU=@dpdk.org
X-Gm-Message-State: AFuF++kAz2aLEijHWi46vFDOhILIzMmBvRTalZrrnF/2Q6DPfGejQFJT
 t39DOCg7UMUGqd2/Nz7vTirtfoK6f4uZhGhagSz2PqvTUbCD57ajGo+N3ay1bbh21ow=
X-Gm-Gg: AYBFou2yCUdhwh8Rg0hG5Hb2Q6p/2cl0cw/Oar54Cgp09MVjw0OaG5BgmLBpcb90F5E
 QHHZGj4TtlCeAouUbGi0Eawz4wHAqcW0RFZi93+25v6G0E2Ir1Doq2Dw7dNZ/pToxOB6UzSxcZQ
 i2De4mZtDLlyrdZyc3bac+sDDmooTgR422jzjEgw8W0oHndCyUW6djsYC7uUnL7dM+Aem2+Qhqo
 bRbEW0isPT/BPeQoWCg5g/IeoSgJB0JED7wfOmernhOw+kjtIke+Xa99CVx+xUAJ4jj/XMA9LBQ
 Xizx216t5LF8CJcBebyIjvaHS/FRWIVlXPJCWSonD+3C15yVHdDgxFTraeQinySEN4iDGZSI/OY
 7iVitnwolU2Cvbqh6aHU4W9LM3lHp4NJ2kZacNmG1gC0VRdEYSVlley6rlPsL4/nqrS/xzng/lf
 4cdB//VJXLxKw4PMt65i1lrAndHAhKH719eyhdx2vZKpy3hy5ArUzBrDbxyWCzuViiXD9FVDSOe
 +LHF0N6ykW/hm9CL0QDVbJnb5VCHQP08sYYYDkr
X-Received: by 2002:a05:6a00:278c:b0:886:d769:615 with SMTP id
 d2e1a72fcca58-890dba83876mr1607222b3a.1.1791298907779; 
 Tue, 06 Oct 2026 08:01:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8918891527bsm45056b3a.18.2026.10.06.08.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:47 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:01:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261006080145.33d89b9b@phoenix.local>
In-Reply-To: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
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

On Tue,  6 Oct 2026 14:56:36 +0530
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
> 
> v21:

More detailed AI review shows some outstanding issues:

Applies cleanly to main (49bb9a5).  HEAD and each of the 27 commits
build with -Dwerror=true (gcc 13.3, x86) for bus/dpaa, common/dpaax,
mempool/dpaa, net/dpaa, crypto/dpaa_sec, dma/dpaa and event/dpaa.
Not built for arm64.  All Fixes tags resolve to the commits they
name; v20 02/27 had a nonexistent hash, now corrected.

The v20 items are addressed.  The CGR delete on a never-created CGR
in 11/27 is gone, the 04/27 Tx gotos are fixed, and the commit
messages of 02, 10, 12, 18 and 22 now match their diffs.  The 19/20
devargs are range checked before narrowing, the unused defines and
macros in 15 and 22 are dropped, and 25/27 saves errno and releases
its FQIDs.

Two new problems come with the fixes.  01/27's rewritten message
describes the wrong mechanism.  The FQID release in 25/27 runs even
when the FQ did not shut down; 26/27 has the same pattern.

Warning
-------

Patch 01/27: The new commit message says rte_eth_dev_release_port()
  calls the close op again through rte_eth_dev_destroy().  It does
  not.  rte_eth_dev_release_port() never calls dev_close, and
  rte_dpaa_remove() never calls rte_eth_dev_destroy().  The second
  close was the explicit second call in the old code:

	ret = dpaa_eth_dev_close(eth_dev);
	if (eth_dev->state !=  RTE_ETH_DEV_UNUSED) {
		dpaa_eth_dev_close(eth_dev);

  Describe that instead.

Patch 25/27: dpaa_oldev_queues_release() returns the FQID even when
  qman_shutdown_fq() failed:

	ret = qman_shutdown_fq(&dpaa_intf->tx_queues[i]);
	if (ret) {
		DPAA_PMD_WARN(...);
	}
	...
	qman_release_fqid(dpaa_intf->tx_queues[i].fqid);

  qman_shutdown_fq() returns -EBUSY when the retire does not
  complete.  It also returns -EBUSY when the FQ is scheduled on a
  DCP channel with frames still queued, which is where this Tx FQ
  points (ch_info.channel_id from the O/H port).  In that case the
  FQ is still live in QMan, and the next qman_alloc_fqid() can hand
  the same FQID to someone else.  Release the FQID only when the
  shutdown succeeded; on failure, leaking it is the safe choice.
  The Rx loop has the same issue.

Patch 26/27: Same problem in dpaa_sec_uninit().  Shutdown failures
  on outq[] and inq[] are logged, then the whole range is released:

  if (fqid)
	qman_release_fqid_range(fqid, internals->max_nb_queue_pairs);

  inq[] are QMAN_FQ_FLAG_TO_DCPORTAL queues towards CAAM, so the
  -EBUSY case applies here too.  Release per FQID, and only for the
  queues that shut down.

Info
----

Patch 11/27: If qman_create_cgr() fails, probe now fails, where it
  used to continue without tail drop.  That fixes the crash, but it
  is a behaviour change and belongs in the commit message.

Patch 17/27: The FINI now uses the literal 104, but the
  "#define RTE_PRIORITY_104 104" line is still there and has no
  user.  Drop it.

Patch 25/27: The FQIDs are now returned, but qman_create_fq() also
  takes an FQ lookup table entry on 64-bit builds.  Only
  qman_destroy_fq() clears it, and no DPAA driver calls that.  So
  each probe/close cycle still leaks one entry per FQ, out of a
  table of CONFIG_FSL_QMAN_FQ_LOOKUP_MAX (32K) entries.  net/dpaa
  and dpaa_sec have the same gap, so a bus/dpaa helper that releases
  both the FQID and the entry after a successful shutdown would fix
  all three.

Patch 27/27: The FMCLESS default Rx queue count change in 20/27
  (rte_lcore_count() to DPAA_MAX_NUM_PCD_QUEUES) is user visible and
  is still not in the release notes.

Pre-existing, not introduced here: in FMCLESS mode, dpaa_dev_init()
gets Rx FQIDs from qman_alloc_fqid_range(), but net/dpaa never
releases them, on close or on probe failure.
