Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17E606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lIyS7Kq8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C98F40E2C;
	Mon,  2 Nov 2026 09:09:40 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 8778C4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:09:39 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1152100f8f.3
 for <dev@dpdk.org>; Mon, 02 Nov 2026 00:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793606979;
 x=1794211779; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RNjZi6caTYxe8pU6UHTi5kG7pBayAAlNREFFMXzdGs0=;
 b=lIyS7Kq8XDxFgwX8/dCek12S/NUyVeQKNhxXsfxxQVc4vfmQChXfql8gacDGsH4Fqn
 Se4J62fGObPo/lVKaFSyDIyfEOaLKVyJJnvmHArzQJvT2ItlQU1mRB06W+iL/WdW+sAU
 W5XVd/tRz46SOkQHTs6T+nUTQv6gs02giRmHYTW4kP2ooxxf5bgyF8PZJrRtFQqPWrKn
 uYKsxK4PrNBVy1otylg7qqYZNln6fCPQZS3zx/GRuL98XQpcVfPLLW10P6jcNajZa8xh
 +8y3KBGpPoTqTrQZhP1TnDVq0tPqfwZqvWHNnBSSJmzL4OVidTpLxdG1szmjftWS6QS9
 4Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606979; x=1794211779;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RNjZi6caTYxe8pU6UHTi5kG7pBayAAlNREFFMXzdGs0=;
 b=UyNT4oDa46fgSFCl9lMK8c0Bko+qpu128LcGnOpG3s+Lqm4hBhhe0fucKYyCCj8sMm
 y6Tf5fPY7gHMgGcrJZbfDUxxlbhCqi//dR5VulrIglh58CRxoVYe8FgqANkeKEaWTr0W
 mEmWeFAyp6YrOBxvbEjLoNyUVL+SaGrBHPgvYchIp10/mv9GbxjkbiIxEAAZSXwguwLm
 jIOrYnCZWXdjtGeNVvE2A537eVRTRRMVYxl08by2OMb2J2kl3Xj6tA8JTj3pgx9+AxRo
 y9K2wSPtBjlJ1bwkMc/Eb0QaT28nenRJknQSB5rtBEFw07ft90Hak9A8DebrfaCr9XJn
 Ileg==
X-Gm-Message-State: APuU4Z+KGE51auh/nNOrnMLkE/eV787I/fTLDzRFVtAM2c5Ddz1rxQVA
 MXWaQzz7MMA661USsLPJ7cMiCli+ZV3qCACIVHSkvD6azMOJV1XpXLy1z3Tp2Yo8spE=
X-Gm-Gg: AYBFou2dh4ZjYeWYeMTYbjb5EjMfGneSiKZLA2pEpieEEiPS9Eq+VTEPzVlujQXXqJi
 5SAcwydUIrBxxH/iyCIxjqdlZOsKQUrs9b349tELRv+/wYoL6vz7zCJiREUSseWwTLGJ61d0w5v
 211vMccdZlc/sXx6o+6tUQaObcbry76Hby9g6vsp/lGfhata5Mbu2M1HnmkXU0nuZHRJywVodLO
 AtuUXJx9ozGOlhtKM/nhoFC9wxWOc7GhmBF5G2jpZjb24E9byP4azQWNIJMAirQN1VggrE2Nfoi
 JR1GRntzAGVgVif4siwzF84kOkUQUVVLd9qv9Bj15KDapl7xzuaKfMtauQ3Wn/dIJZVV2vP9pIr
 njB+p0uDIb7yuQmT2X6ozJL6vqvVEV54f9ekhlRexHKj6CTjGcm0X9d7YoFWiU4h+LdhGqaXFYn
 px+WGDbCPFzlsS4LUG6cRJbqlh66uS3iFJSkfC9KbTZ+itmpEaUPDHPjCLj2XuiXdVrycl612Qm
 zJww7s2HzEoerM4eQKLt8bzV9ClebCcmShyLzdYgw9aWBg7zYDYQf8I0aWcwkM4xRltiSRjn98W
 beGgC3cMIjCPPBIXZMWfuzk96vEUewVcm+RZfDFr5Py55vw4TKIONUPLFKruHCbk143mF2QUqLm
 GusCyEs0r+KP7UdY=
X-Received: by 2002:a5d:6f0e:0:b0:48a:ef5c:fc2c with SMTP id
 ffacd0b85a97d-48e6e515db3mr21485390f8f.48.1793606979082; 
 Mon, 02 Nov 2026 00:09:39 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d425sm19039301f8f.1.2026.11.02.00.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:09:38 -0800 (PST)
Date: Mon, 2 Nov 2026 09:09:36 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v2 0/4] DPAA driver changes
Message-ID: <20261102090936.2eae7206@stephen-xps.local>
In-Reply-To: <20261030044318.1892998-1-g.singh@nxp.com>
References: <20261028085517.705621-1-g.singh@nxp.com>
 <20261030044318.1892998-1-g.singh@nxp.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 10:13:14 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V2-changes:
>  - Fixed most of the AI comments.
>  - added new patch:
>    fix out-of-bounds read of mac_idx
>  - removed drv_oldev, updated comments and notes.
>  - fixes FQ shutdown
>  - removed unwanted checks, updated open, updated snprintf.
>  - updated commit messages.
> 
> V1:
>  - Adding OH port support.
>  - Updates in shared ethernet code.
>  - Congestion related code cleanup.
> 
> Gagandeep Singh (2):
>   bus/dpaa: fix out-of-bounds read of mac_idx array
>   drivers: add offline (O/H) port device support
> 
> Hemant Agrawal (1):
>   net/dpaa: support non fmX-macY type of shared Ethernet name
> 
> Jun Yang (1):
>   drivers: add DPAA cgrid cleanup support
> 
>  doc/api/doxy-api-index.md                |   1 +
>  doc/guides/nics/dpaa.rst                 |  35 +
>  drivers/bus/dpaa/base/fman/fman.c        |  19 +
>  drivers/bus/dpaa/base/qbman/qman.c       |  61 ++
>  drivers/bus/dpaa/bus_dpaa_driver.h       |   4 +-
>  drivers/bus/dpaa/dpaa_bus.c              |  66 +-
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c |   2 +
>  drivers/bus/dpaa/include/fman.h          |   6 +-
>  drivers/bus/dpaa/include/fsl_qman.h      |  28 +
>  drivers/net/dpaa/dpaa_ethdev.c           | 241 ++++++-
>  drivers/net/dpaa/dpaa_ethdev.h           |   3 +
>  drivers/net/dpaa/dpaa_flow.c             |   7 +-
>  drivers/net/dpaa/dpaa_oldev.c            | 875 +++++++++++++++++++++++
>  drivers/net/dpaa/meson.build             |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h    | 188 +++++
>  15 files changed, 1517 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Manually run AI review still sees issues that need addessing

Review of [PATCH v2 0/4] DPAA offline port, shared MAC, cgrid cleanup

Applied to next-net for-main (3b51e2e2f0). Each commit builds with
-Dwerror=true.

Series
------

The rte_pmd_dpaa_ol_* API is unchanged from v1 apart from renames and
Doxygen. The four functions still take no port_id and only pass a
caller-filled struct to ioctl() on the out-of-tree /dev/cdx_ctrl
driver. The dpaa.rst text added in v2 confirms the API is configuration
for that kernel module, not for the DPDK port. It belongs in the vendor
userspace library for cdx. Please drop rte_pmd_dpaa_oldev.h and the
exports.

There are still no release notes for the offline port.


Patch 2/4 drivers: add offline (O/H) port device support
--------------------------------------------------------

Warning

The commit message still says the port is "selected through the
'drv_oldev' bus device argument". v2 removed drv_oldev; the port is
created when "-a dpaa_bus:oldev1" is given.

With only oldev1 present, dpaa_netcfg is NULL. v2 handles that in the
two log statements but not in the debug dump:

	#ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
		dump_netcfg(dpaa_netcfg, stdout);
	#endif

dump_netcfg() dereferences cfg_ptr->num_ethports unconditionally. Fold
it into the existing check:

	if (dpaa_netcfg) {
	#ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
		dump_netcfg(dpaa_netcfg, stdout);
	#endif
		DPAA_BUS_DEBUG("Number of ethernet devices = %d",
			     dpaa_netcfg->num_ethports);
	}

Not addressed from v1: dpaa_oldev_queues_release() returns both FQIDs
to the allocator with qman_release_fqid(), but the kernel received them
through ASK_CTRL_SET_DPDK_INFO and is never told they are gone. There
is no reset ioctl for that. Until cdx provides one, do not release the
two FQIDs on close.

Info

drv_bh_port is now checked against a key list, but it is still parsed
in dev_start(). A missing drv_bh_port is only reported at start. Parse
it once in dpaa_ol_probe() and fail probe if it is absent.

The static_assert and comment added to dpaa_flow.c, and the
MEMMAC_REG_OFFSET removal in fman.h, are not part of the offline port.
Move the dpaa_flow.c change to 1/4, and mention the fman.h removal in
the commit message.


Patch 4/4 drivers: add DPAA cgrid cleanup support
-------------------------------------------------

Info

dev_close() runs dpaa_cgr_stale_fq_cleanup() before shutting down the
port's own FQs. The scan therefore finds this port's live queues, logs
each one as "still alive?", and shuts it down by FQID. The
qman_shutdown_fq() loop that follows then only sees FQs that are
already OOS. Shut down rx_queues[]/tx_queues[] first, then scan, so the
scan only reports FQs left by a previous run.
