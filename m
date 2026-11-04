Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B62606A326
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=U8zpDLs/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D4E540616;
	Wed,  4 Nov 2026 12:29:28 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 351F84025A
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:29:26 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso892036a12.0
 for <dev@dpdk.org>; Wed, 04 Nov 2026 03:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793791766;
 x=1794396566; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qUUc1Rq6V+Nuqw9SuQgAXy7lBvk8u3lZ9Q00V4S9FX4=;
 b=U8zpDLs/DPiD6j4cJx2CbRJMV08h0lkojWhaweDZ/8XjQ1BTbwI7AznAt8DZk4PWJn
 NXstoh21DpGyAX2LxkmfYnVsfKCzdBjS7G3Y5CILQ9dENx1TZjgbfW/54osIIIt1Ou/m
 OKX55la3yd7uX+QNAYIsrA66ChKUTWh/YZONLmFQ1C0I4nRuoYmBwXPv+9xr9w4nwY2A
 Zq7tqOaBp8oydYEkyEwmeibDK+fBFona7xyqj366N6WeCZICQoW0/BZsJS6bBeUoJVuj
 tTcFGJxK3KwOlYyrzkrBpngOxcnETD+lC5okwoo8rfYj0pkxYNgr8Rp8pxWFo4Q+0boV
 AE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793791766; x=1794396566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qUUc1Rq6V+Nuqw9SuQgAXy7lBvk8u3lZ9Q00V4S9FX4=;
 b=lLHl8qZZdjCRYNOIaPTGWFj+lF+5Rq+NVPmmUQudJW3E+JyMQFmLkK1ruMYaxQ/bx8
 AIToK6wT2ppA4urkQWq2VLtXOlCyLWB5E3Ct1CQ38G3UORMs1hYpnOFs8iFqJuWHK2zn
 y8Pj4cfiuJyXb8MB5Gr/JZm60q9VeQGgJAeTH3SoCjSiDPLeUOVEwbjbATOkAubDw+N6
 AK6TbX5Pti0bHOtQ2w3YSJFH9xZfCbSeyDBRBhrG2KVw2jq+QjKjjVOiWky6n7f5djOE
 I25JrrQg1A4kcxsiVZx1Kqx+/qUPJMCbzVqhd0gy7j7Di82F6g7tZFDR0pi/Aw3uuedt
 2sSg==
X-Gm-Message-State: APuU4Z/RlBMYnT/LCVfse8JLGyj1vG9g0MheCwU8xpPKGEegVGluRA6b
 6ue4Q8/1CdVD2XloZ970RTYYU/E37YFbh6+pmDnSTsu8fWmUtSixS1oA7KHDncapY/HJZ3p7TSX
 t4Eq6mt4=
X-Gm-Gg: AYBFou2ebe3Cr4fBDaUktrZ1msjTIq3lHDHucUpC9cSd+VqkBIBuSIdMPV5az14f+7d
 HQMknOcMaUcME+TeWDDWzamjsPqSIi6Q5rwtshRoDSUgidzhv53QGbgUOVzR1RUWQQTfzFFT4as
 tdrVasen/QHzyE6CaPGHDyWSuTS4wa2cL4CNRxhniG76O6SY9489MpPZeRRbeI8uaWtphEySlKc
 w3peW9Tpbc5VQWZIuUnsV5Ew1srJev9L2ZPu48XORSDE3j9TFoNPNQaUtHKbNzpmLo4vsl8ZwLG
 Ma/gmSZAzQTsPQhFfIlPQiQpZPTXcNK1AZEfvpgGlRx0y5WHI55riDQ4mQpqncmvCjrF/Bh1vAq
 Oc9RJWqHXqzW3atkp6fE8Cd0+KJEQRtnvmvCQb2EfSfG3X3LQKCYU4y3xmTlMcF3vUqKUCXa7iC
 XLFQ5zYXROHLTbZue54KuCySYxbGBZxhlHqEbro3n5KxGUdZ0GDH4AQsHl1qVZwViEWtA3YkfoZ
 3Wt1BgsG3shL0RgHDq1lW5hJsvKfQIyB/ScnNwHqQkaDCLxkfnVkau4SQrgzQml0sF5j+3Xr7Of
 K60mL8a7TBtoYSaI07e9oYPQpl7Wjjn8rTb7ypUOpIjyNrfS1UCGiCy3O99oPTZIJhU3WZdAETJ
 j8tMdMeoCBvAebQ==
X-Received: by 2002:a17:906:99c4:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c4ca7a72f91mr1324043766b.25.1793791765516; 
 Wed, 04 Nov 2026 03:29:25 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4657f6sm59825866b.50.2026.11.04.03.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:29:25 -0800 (PST)
Date: Wed, 4 Nov 2026 12:29:19 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v3 0/4] DPAA driver changes
Message-ID: <20261104122919.1642e887@stephen-xps.local>
In-Reply-To: <20261103093601.3736486-1-g.singh@nxp.com>
References: <20261030044318.1892998-1-g.singh@nxp.com>
 <20261103093601.3736486-1-g.singh@nxp.com>
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

On Tue,  3 Nov 2026 15:05:57 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V3-Changes:
>  - Updated rte_pmd_dpaa_oldev.h APIs as per DPDK compliance.
>  - Added missing release not for OH port support.
>  - Fixed dump_netcfg issue.
>  - Added an API to release FQID.
>  - moved the fman.h changes to first patch.
>  
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
>  doc/guides/nics/dpaa.rst                 |  36 +
>  doc/guides/rel_notes/release_26_11.rst   |  10 +
>  drivers/bus/dpaa/base/fman/fman.c        |  19 +
>  drivers/bus/dpaa/base/qbman/qman.c       |  61 ++
>  drivers/bus/dpaa/bus_dpaa_driver.h       |   4 +-
>  drivers/bus/dpaa/dpaa_bus.c              |  68 +-
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c |   2 +
>  drivers/bus/dpaa/include/fman.h          |   6 +-
>  drivers/bus/dpaa/include/fsl_qman.h      |  28 +
>  drivers/net/dpaa/dpaa_ethdev.c           | 235 +++++-
>  drivers/net/dpaa/dpaa_ethdev.h           |  12 +
>  drivers/net/dpaa/dpaa_flow.c             |   5 +-
>  drivers/net/dpaa/dpaa_oldev.c            | 938 +++++++++++++++++++++++
>  drivers/net/dpaa/meson.build             |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h    | 198 +++++
>  16 files changed, 1603 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Still see AI reported errors

Review of [PATCH v3 0/4] DPAA offline port, shared MAC, cgrid cleanup

Applied to next-net for-main (3b51e2e2f0). Each commit builds with
-Dwerror=true.

Series
------

The rte_pmd_dpaa_ol_* functions now take a port_id, but it is only
used to look up which fd the ioctl goes to. The classification and LGW
payloads carry nothing from the port, and the kernel module consumes
them. My earlier objection stands: this is configuration API for the
out-of-tree cdx driver and does not belong in DPDK.


Patch 2/4 drivers: add offline (O/H) port device support
--------------------------------------------------------

Error

dpaa_oldev_init() opens /dev/cdx_ctrl through check_fd() in
dpaa_ol_tx_queue_init(). If a later step fails, for example the
mac_addrs allocation, the free_rx path does not close the fd:

	free_rx:
		dpaa_oldev_queues_release(dpaa_intf);
		return ret;

dpaa_ol_probe() then calls rte_eth_dev_release_port(), which frees
dev_private and ol_fd with it. Close it on the error path:

	free_rx:
		dpaa_oldev_queues_release(dpaa_intf);
		if (dpaa_intf->ol_fd >= 0) {
			close(dpaa_intf->ol_fd);
			dpaa_intf->ol_fd = -1;
		}
		return ret;

Warning

dpaa_oldev_queues_release() sends ASK_CTRL_RESET_DPDK_INFO and releases
the FQIDs only if that succeeds. It does this even when
ASK_CTRL_SET_DPDK_INFO was never issued: on the probe error path, and
on close of a port that was never started. In those cases the kernel
never had the FQIDs, so there is nothing to reset. If /dev/cdx_ctrl is
missing, probe fails in dpaa_ol_tx_queue_init(), the reset fails with
-ENODEV, and the Rx FQID allocated with QMAN_FQ_FLAG_DYNAMIC_FQID
leaks on every attempt. Track whether the kernel holds the FQIDs:

	/* dpaa_ol_set_fq_info(), after ask_set_fq_info() succeeds */
	dpaa_intf->ol_fq_info_set = true;

	/* dpaa_oldev_queues_release() */
	release_fqids = true;
	if (dpaa_intf->ol_fq_info_set) {
		if (ask_reset_fq_info(dpaa_intf, &fq_info) != 0)
			release_fqids = false;
		else
			dpaa_intf->ol_fq_info_set = false;
	}

Info

v3 replaced the atomic ask_fd with a plain dpaa_intf->ol_fd, but kept
the double-checked lock in check_fd(). The unlocked read of ol_fd now
races with the locked write if control calls can be concurrent. If they
cannot, the mutex is not needed. The fd is always opened during probe
by dpaa_ol_tx_queue_init(), so open it once in dpaa_oldev_init() and
drop fd_init_lock and the lazy open.

dpaa_ol_set_fq_info() copies bh_port_name with rte_memcpy(); this is
control path, use memcpy().

The blank line added after "/* Rx Statistics Counter */" in struct
dpaa_if_stats is unrelated.
