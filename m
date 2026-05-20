Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F4CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:38:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6FCE4042F;
	Wed, 20 May 2026 17:38:39 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id EF39F400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 17:38:37 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-303dbfbec77so5096261eec.0
 for <dev@dpdk.org>; Wed, 20 May 2026 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779291517;
 x=1779896317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20Gfb2j5al2ZbmYSC9iJbn+kFoQmgf1UMtWDKhTY2X0=;
 b=DrYimF4kXmWyO8ydS60fCse0WreOKfk4Rz+A+iQmAHXjGQb0RTswlxtBulalAuXm4J
 h6ou0j+nMuUQUJZ1Wpe5inVpRwLu7XSE9TH5Fj+8wIfkXfURJmkJ8TH8J83SYHT0g2Fh
 YTfbuTBt3/Qfa5bK9o3MMxFBhCyE3E9e8G7Sl8B0ARajymxG6L9GNwrsOfhQUvTK7nZu
 DjKWVfubF3SEXGWZp4cjrJZEaM/KuhOoWZ9lL3iUrEWGctP1tfJ+d/d29nThrSBp0ofv
 6TYPw5AlzKY4rBDIBoRynYrx+G+IwGWKTfLHSMoe5wuBy3yeHlNS1SHne3Eb7YVo7nI+
 AoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779291517; x=1779896317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20Gfb2j5al2ZbmYSC9iJbn+kFoQmgf1UMtWDKhTY2X0=;
 b=AvcX8+gzLZJBMeUPWMshvPtat+rErOgSBcmyFXzQ9+1k34UOl3uFpQhza3sZSiszLh
 1iSU8pNvABwsr7m61z/E4dS91v7YgJ1j1RDiIjjL1IdIPnwjVDb5W6VSDDnAcDZ1Uz9H
 M+8p69/PkO0wfMSZWTsh7wfIWoQJCLgoQnOG2zTG2Eg/CSB2zhWd7dnaZw+QJvfZXl0D
 hvuFoGFPkeHftv4FUZANqoGZKlFzy3ekxT10UCd/LyHq5wEnXBgVc9xBN71B1ehX7nhP
 kFhTvqiPimp0jz+t0MLcRS70a6yD3mIcCHjq4ujsHnijjPxY1cRzPUgEcPEQousF1wwE
 lvtg==
X-Gm-Message-State: AOJu0YweMiXGHh8ImfNJQSfxwT4K4fNC8/o6xqv/cbFaC4r3QuoThzKh
 0ptIh2pKnsPc4SUZO29kfE1eL7JhEamDvpu4l+ZGcKyapxD0VhyVnY3F5v3RlO+IgCdcDRTTIt4
 oYGpfgXE=
X-Gm-Gg: Acq92OHWtBmAcIssSFFr8eqHTgEs7rji2tH4onvVUczBQN+PHKlWg8eiISj2yYORSS5
 o3xi4+ggVsgis3HjFAGPMqLfYe885obYJpwKCO9Z7aO79IScAy8lu/6vRQy68T3xkuZ+cL/hr49
 ntTM/+k81HAYFyvg6KeAMEnjFkav+jgcKT73MCZcfgU7oCIEzP6x8j8pQaoX1vS7kZ6YS/BT9r7
 mg/US3Uj/HSab/XGznX7nETy96pa41c0lTMjyUS+re0CCmmFlTFURedAD8TMKlirSAqmG8KRbDf
 XBniHvaGUVWA5T78PnDjjJRXN7N4YNGqVq+y7rRorU9W5EN4GuiCL+5PNkMZycOLmhaFSrtTBlI
 i5QudkfthE4J9kaSrs3EpOTaHeWAWskWyHTtOgmd81o+ILFIOlzoPSaXiv40/fF6QBrwNi2wDk7
 zUQqquG6pq1yzYX8L0Y69emRbvZQ0S/QM5WNCuTAMYxI5nC1dAAfBQNQ66opAZcxnUfXqUaNPAy
 5k=
X-Received: by 2002:a05:7300:478f:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-30398167fccmr10875370eec.9.1779291516490; 
 Wed, 20 May 2026 08:38:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e6a9sm18777328eec.2.2026.05.20.08.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:38:36 -0700 (PDT)
Date: Wed, 20 May 2026 08:38:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v19 00/11]net/sxe2: fix logic errors and address feedback
Message-ID: <20260520083827.05365a5c@phoenix.local>
In-Reply-To: <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
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

On Wed, 20 May 2026 10:17:58 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set addresses the feedback received on the v10 and v18 
> submissions for the sxe2 PMD. The primary focus is on fixing vector 
> path selection, ensuring memory safety during mbuf initialization, 
> and cleaning up redundant logic in the configuration functions.
> 
> v19 Changes:
> - Fixed vector Rx burst function being overwritten by scalar selection.
> - Refactored Rx/Tx mode set functions to seed flags from caps first,
>   eliminating tautological checks.
> - Added memset for mbuf_def in vector init to avoid uninitialized reads.
> - Converted pci_map_addr_info to designated initializers.
> - Removed dead Windows-only code in meson.build.
> - Added NULL checks for mbuf free for driver-wide consistency.
> - Updated burst_mode_get to accurately report AVX paths.
> - Adjusted SXE2_ETH_OVERHEAD to match actual VLAN capabilities.
> 
> Jie Liu (11):
>   mailmap: add Jie Liu
>   doc: add sxe2 guide and release notes
>   common/sxe2: add sxe2 basic structures
>   drivers: add base driver skeleton
>   drivers: add base driver probe skeleton
>   drivers: support PCI BAR mapping
>   common/sxe2: add ioctl interface for DMA map and unmap
>   net/sxe2: support queue setup and control
>   drivers: add data path for Rx and Tx
>   net/sxe2: add vectorized Rx and Tx
>   net/sxe2: implement Tx done cleanup
> 
>  .mailmap                                   |    1 +
>  doc/guides/nics/features/sxe2.ini          |   23 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/nics/sxe2.rst                   |   34 +
>  doc/guides/rel_notes/release_26_07.rst     |    4 +
>  drivers/common/sxe2/meson.build            |   15 +
>  drivers/common/sxe2/sxe2_common.c          |  683 +++++++++++++
>  drivers/common/sxe2/sxe2_common.h          |   85 ++
>  drivers/common/sxe2/sxe2_common_log.h      |   81 ++
>  drivers/common/sxe2/sxe2_host_regs.h       |  707 +++++++++++++
>  drivers/common/sxe2/sxe2_internal_ver.h    |   33 +
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |  325 ++++++
>  drivers/common/sxe2/sxe2_ioctl_chnl.h      |  130 +++
>  drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   62 ++
>  drivers/common/sxe2/sxe2_osal.h            |  153 +++
>  drivers/meson.build                        |    1 +
>  drivers/net/meson.build                    |    1 +
>  drivers/net/sxe2/meson.build               |   32 +
>  drivers/net/sxe2/sxe2_cmd_chnl.c           |  323 ++++++
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |   37 +
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  388 ++++++++
>  drivers/net/sxe2/sxe2_ethdev.c             |  968 ++++++++++++++++++
>  drivers/net/sxe2/sxe2_ethdev.h             |  318 ++++++
>  drivers/net/sxe2/sxe2_irq.h                |   48 +
>  drivers/net/sxe2/sxe2_queue.c              |   66 ++
>  drivers/net/sxe2/sxe2_queue.h              |  195 ++++
>  drivers/net/sxe2/sxe2_rx.c                 |  554 +++++++++++
>  drivers/net/sxe2/sxe2_rx.h                 |   32 +
>  drivers/net/sxe2/sxe2_tx.c                 |  420 ++++++++
>  drivers/net/sxe2/sxe2_tx.h                 |   32 +
>  drivers/net/sxe2/sxe2_txrx.c               |  352 +++++++
>  drivers/net/sxe2/sxe2_txrx.h               |   23 +
>  drivers/net/sxe2/sxe2_txrx_common.h        |  540 ++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.c          | 1044 ++++++++++++++++++++
>  drivers/net/sxe2/sxe2_txrx_poll.h          |   20 +
>  drivers/net/sxe2/sxe2_txrx_vec.c           |  201 ++++
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   63 ++
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |  235 +++++
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  549 ++++++++++
>  drivers/net/sxe2/sxe2_vsi.c                |  214 ++++
>  drivers/net/sxe2/sxe2_vsi.h                |  204 ++++
>  41 files changed, 9197 insertions(+)
>  create mode 100644 doc/guides/nics/features/sxe2.ini
>  create mode 100644 doc/guides/nics/sxe2.rst
>  create mode 100644 drivers/common/sxe2/meson.build
>  create mode 100644 drivers/common/sxe2/sxe2_common.c
>  create mode 100644 drivers/common/sxe2/sxe2_common.h
>  create mode 100644 drivers/common/sxe2/sxe2_common_log.h
>  create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
>  create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.c
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl.h
>  create mode 100644 drivers/common/sxe2/sxe2_ioctl_chnl_func.h
>  create mode 100644 drivers/common/sxe2/sxe2_osal.h
>  create mode 100644 drivers/net/sxe2/meson.build
>  create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.c
>  create mode 100644 drivers/net/sxe2/sxe2_cmd_chnl.h
>  create mode 100644 drivers/net/sxe2/sxe2_drv_cmd.h
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev.c
>  create mode 100644 drivers/net/sxe2/sxe2_ethdev.h
>  create mode 100644 drivers/net/sxe2/sxe2_irq.h
>  create mode 100644 drivers/net/sxe2/sxe2_queue.c
>  create mode 100644 drivers/net/sxe2/sxe2_queue.h
>  create mode 100644 drivers/net/sxe2/sxe2_rx.c
>  create mode 100644 drivers/net/sxe2/sxe2_rx.h
>  create mode 100644 drivers/net/sxe2/sxe2_tx.c
>  create mode 100644 drivers/net/sxe2/sxe2_tx.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_common.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.c
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_common.h
>  create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_sse.c
>  create mode 100644 drivers/net/sxe2/sxe2_vsi.c
>  create mode 100644 drivers/net/sxe2/sxe2_vsi.h
> 

Applied to next-net with minor merge fixup to release note
