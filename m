Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D9CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 17:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E6F64027C;
	Fri, 19 Jun 2026 19:28:11 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id EBD9740279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:28:09 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-137dd4cc208so1762821c88.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781890089;
 x=1782494889; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8kgha7EJw9aLsZS8L/TuJeDJPf9nbXk9Y2OiWZ7fEE=;
 b=JR4LsbKzkZ8sO4Zg1XRy1tOOT6ExqV8tWcLX5YqMyzKXsW/Wl7XCpgmOnlDZOR/NXn
 n0Gn2NXtxsEWJVRGDKRV+O2zNDjpEvcZGJx9V+hz77P59Pcyo3MRKHpXjiBvg1mqo0HQ
 qL5pzReH2HpQF3igPl9bSnv+iUyS3FuKrC0l8EZXAq7TmxTOMngSQlwN7jXWozrV8Oo7
 Qj2Ij3E3StVUFeyTZsYnqfdeYZWjJKXQbkIh0ATqNXCgHbrlbQZXNzPMogoBUQrR8x6V
 IkTBGI4D+oL0fFqtrDO5+7pOZTmbzO6wbmJ9vYIPlR3AC4gqKkt6IakhC4wOpHDJe1nT
 x9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781890089; x=1782494889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8kgha7EJw9aLsZS8L/TuJeDJPf9nbXk9Y2OiWZ7fEE=;
 b=lX1kc4TRhmvLpryDb6prCm9+bxwmn2oPCylXyKMLiY106mQSAs2aUlUJWkZM4Bd6KG
 zbTHXP4fnudXQaBN3rhtiBp5MsuWP403a77uiZipizMw3gOyVzhWr6ohoCShI7frwFA5
 XmB5bdTi7BEGhmlNF0NJe2WFJRAGeAaIbN0aeeGwYIMArKIjTW8hPr3dDQQodu3oghAp
 SrTcsujq/1QTG83n6YzNC7s2OJeImwJMtDw9Hozg+yZdpOm3snvSVFxPAeojM6lffRPb
 RMtVUNqdfG71qkB6WckZpFKdq/ewxz7M3o9ESwgl1fuPBzefyLXNcTVCw2qPfzj2DUPT
 t1aQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bJasmJ+P6jbI60BDEJZqANw3aOr/TYVqabcV6+r5QSYPRFx0TSLeGgnsgqRIrjpZUNQ8=@dpdk.org
X-Gm-Message-State: AOJu0Ywdsd/EZpIU4y07xcjj6qQo0nxOOyOk9giF2HgBoroZrUP54xJq
 d2LaXppdVWu5NYbMzzA3xyImUAtiZh7443+wYeciACmK5gDsQ/fIezQLLj8ggHNv4FQ=
X-Gm-Gg: AfdE7cm4EO/eAhWtT4/TC6JMvNz5ektSdMDFRyborMjQ3aOafJ1fc7Ds5urxdGiYQ5v
 AqdB3pstoD2p7kcjL9lr5/cUVXTlfWDWrKj8H3qMGtQH84uAmsDzRzoKmcT+F74vRYywd4z4lyN
 KvhjDGavhyonlsd+JpkszcqOfpTx4nwD22QAfauJddVrA2FGilSe+hVn3rgVCkN9IF+IHE75Jrx
 c8oj2MA5EnMwaSw7MctKD8MAxDdMkcCEB2vvPuQqx70agMLOb1btRWcWvgdqPSUfZDUWhJILFxN
 bFgMGLiZBUCpbG2dKt2matZ+/NMoh2Oe169CbFUsaLRF7X12kwok7GFzOp7VPz0HWIXGooGZXwP
 QV5Ed3Jq2DD5EvdoGEKu/O9nGe5twP5+YiiwxmjmjCjfdYDn6rza/FteYSKxyTf+Z5LHBzxOdHd
 mCK1l1BpKJcZVFcw27+ZfT0BM71Pn6hdapzkSaCEawQp1IF0LOX2A1Rg==
X-Received: by 2002:a05:7022:11d:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-139a31306b6mr2147363c88.19.1781890088658; 
 Fri, 19 Jun 2026 10:28:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a366219fsm1963724c88.12.2026.06.19.10.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 10:28:08 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:28:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v3 00/18] net/dpaa: bug fixes for bus, net and fmlib
 drivers
Message-ID: <20260619102805.1fcb8c7b@phoenix.local>
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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

On Fri, 19 Jun 2026 16:08:43 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series contains bug fixes for the DPAA PMD (bus/dpaa, net/dpaa,
> net/dpaa/fmlib and dma/dpaa).
> 
> v3 changes (AI code review feedback):
> - P05: Clarify commit message: p_dev == NULL is equivalent to h_scheme == NULL
>   since p_dev = (t_device *)h_scheme; consistent with all sibling functions
> - P16: Add comment explaining the intentional loop continuation; clarify
>   commit message about the loop design
> - P17: Add DPAA_DP_LOG(WARNING) before silent return on l3_len == 0 to
>   aid debugging of corrupt/uninitialized mbufs
> 
> v2 changes:
> - P05: Fix commit message API name
> - P08: Guard DPAA_PUSH_QUEUES_NUMBER env-var for LS1043A (errata)
> - P09: Document dpaa_finish() removal
> - P10: Fix wrong Fixes: tag
> - P11: Split into two patches with correct Fixes: tags
> - P13: Also fix rx_buf_diallocate -> rx_buf_deallocate
> 
> All patches are bug fixes tagged with Fixes: and Cc: stable@dpdk.org.
> 
> Gagandeep Singh (3):
>   bus/dpaa: fix device probe issue
>   net/dpaa: fix device remove
>   net/dpaa: fix invalid check on interrupt unregister
> 
> Hemant Agrawal (11):
>   bus/dpaa: fix error handling of qman_create_fq
>   bus/dpaa: fix fqid endianness
>   bus/dpaa: fix error handling in qman_query
>   net/dpaa: fix modify cgr to use index
>   bus/dpaa: fix fd leak for ccsr mmap
>   net/dpaa: fix xstat name for tx undersized counter
>   net/dpaa: fix xstat string typos in BMI stats table
>   net/dpaa: remove duplicate ptype entries
>   net/dpaa: fix wrong buffer in xstats get by id
>   net/dpaa: fix null l3_len check in checksum offload
>   net/dpaa: fix mbuf leak in SG fd creation
> 
> Jun Yang (1):
>   bus/dpaa: fix BMI RX stats register offset
> 
> Prashant Gupta (1):
>   net/dpaa/fmlib: add null check in scheme delete
> 
> Vanshika Shukla (2):
>   net/dpaa: fix port_handle leak in fm_prev_cleanup
>   dma/dpaa: fix out-of-bounds access in SG descriptor enqueue
> 
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
>  drivers/bus/dpaa/base/qbman/qman.c        | 11 ++++++---
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
>  drivers/bus/dpaa/dpaa_bus.c               | 17 ++++++-------
>  drivers/bus/dpaa/include/fman.h           |  6 ++---
>  drivers/dma/dpaa/dpaa_qdma.c              |  7 +++++-
>  drivers/net/dpaa/dpaa_ethdev.c            | 30 +++++++++++------------
>  drivers/net/dpaa/dpaa_flow.c              |  4 +++
>  drivers/net/dpaa/dpaa_rxtx.c              |  5 ++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
>  10 files changed, 56 insertions(+), 36 deletions(-)
> 

Applied to next-net with some minor changes to commit message to fix capitalization complaints from check-git-log
