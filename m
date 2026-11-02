Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE8606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=InuOgJYu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B60A640E34;
	Mon,  2 Nov 2026 14:23:13 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id EB0EB40274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 14:23:12 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so19161645e9.3
 for <dev@dpdk.org>; Mon, 02 Nov 2026 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793625792;
 x=1794230592; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SrIZ2HitwIg+pvQsGW3veOJsX/KQ0+ktyLqjWvBcodk=;
 b=InuOgJYuOtieQkKUyMWI1EvTL/pWvhvFipKuKPIh9H9VjohTjUJltTU9YXldz0vxFJ
 4YPhQB7RUz9COeQrbjTPhmTDbcDy0qiHbSABUPW9t78JNjVNHOQl0G4TtCWAhnAizdUs
 /mHvJ4KQuOeZ15EXPH69DCZczLgS3o7o09npgW8HXkYp8HsmncATSlOaSWC67OWMtVzD
 YApNgVnFlsWKJdrEfl2yyMuOMG/aF4Z/OJF0imhKAQYrP6UMDMF6C8+gZnX+zwXVg8NR
 0pxlAn2DG6JWwcBoECtVsQltpWRU7mFKzR1GZca2Ytf658rfygLVmNKJYVAlSlPfjimT
 sXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625792; x=1794230592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SrIZ2HitwIg+pvQsGW3veOJsX/KQ0+ktyLqjWvBcodk=;
 b=KjCaO6RI6zJrM3TeOwiSdt60lmbfON2elZCJgwhWRpDa+iSmFSionST4mObT87uoxF
 Lbq9i04Mts7dhI3CRrNPddx97UlkQU50fXHWLA4Hq7es9h8D1uXnJgf/i+ZliyeDMwr0
 VuwTeNYE7gG7mj1VwF09ttOX2tDfofij/T3TFKS1BZChzGQzYKQGzGKbfj+72V3lZOv9
 evWB53FgtHgSDZnXLwrhqZQq8DwVE0PKbruMhLngMTtZY1kr6rRifY4Va35iqIXDinbV
 N8LspVGFXYIbsmkYMy5c8YpGWdlRFBT4JbeSLZqNb+hmb0/o2lZrjLnCj9wvetEQPV3m
 zDLg==
X-Gm-Message-State: AFq9FYJHKX15FkY+USNwObyue9WzeG6VqcJK/KPgQZxTBf3FPdRY0WDl
 jGU/mLpcKXfxe22VeMWZhEtmuNPNa/gh2FojbDOm3gvkxop4ZwtW/Tmt2ldSWwwjXUJvpRYfCkr
 ghpTpYG70Hw==
X-Gm-Gg: AYBFou0/5issbyJt4wzwVZwOcb73i2zcYuMv6iQXwz+UVrBK8aeB+eukLSkIv14CU8o
 6p+57Y1Bhm8LR3XcVFXDid1zGogOKYyD/7x4Y6FiwPNHXUfJXFX8wffdE6dkIpBuX/SB0xh1Jf6
 vqWEpje4VYmcBG7m+XJZ/Jbgmj/44ov5Sff0C48AdVxRDqPpNsz1WMMuPMle+XRgJbe/tuoOTdO
 57Fu6zZDqZQbhtqRp1PC1z1MwNX1yK7eJ1orW1KfJL0PWMRDv51+yoEt4+6cDBQm15PjxjUF8wz
 mSck/BsjzG0CpM1QkYDzVJsFsnqawqeHUQFfG1UVsPCm5hTfFOMlOsepQ/L5ZV0FB/MPBHmjtpH
 xtxqyUeE9pGb7zfsJotpYWCP9wxjOQw02N/g6NdN2UceCbVpUiY3KcyNAeI6wK8RW3k55mVpyRf
 HAxAbubdNCz2mVzp5SsB4KAUtV4JmATSNWJ8uqsIN6PrTrRdBvw9M4BXQ7FnMl7uECGHW1X0qZE
 KgiRhWFWbuaUN/44SksmAzSpeyTXgYuTOeVOfRXZYToFAx0lSvxxXCO5MNCZ0tT2PX9O18U2Bqp
 XP30Imqu1cDGy8N2sBdz8I91kj6lBYknf6y9nCPK/i9imUw5cDlednO7MIydCOs/0wBoaVs9TCa
 uo7w2zljmPs7QhKQ=
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4ac181e75b7mr244821535e9.31.1793625792066; 
 Mon, 02 Nov 2026 05:23:12 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm390066695e9.5.2026.11.02.05.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:23:11 -0800 (PST)
Date: Mon, 2 Nov 2026 14:23:07 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v2 0/4] DPAA driver changes
Message-ID: <20261102142307.35553cf1@stephen-xps.local>
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


