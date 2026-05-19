Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76179CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A89840296;
	Tue, 19 May 2026 16:16:44 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id CA5E04025E
 for <dev@dpdk.org>; Tue, 19 May 2026 16:16:42 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12c19d23b19so4914709c88.0
 for <dev@dpdk.org>; Tue, 19 May 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779200202;
 x=1779805002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A53zkpNW3s1KQ9ryBUm4Smimbnrb4y3hbZwk2WoCnO8=;
 b=mcV0O3bXh2uQGroSj4UZsoiUfuPUMgkGdsD77S6ggg0BAXr2MDwSa+j+x8yEJg+Qnv
 71nHmRPwyuzhZtbOfTNSICncYJJjE+JjKC+gNuD0zegIeTrQe5fhwUlf961QjTaf7w3F
 n5MLcMm0kjmX+ymMTghG29kzU3T14eJCFLzmcuSe/sNYLeBrCGaLKO+Lz7XXIqouOMC1
 LL72L+J9lfHSoxFYy53E3VooDgsCkTFQllYSDIvxfaipmAqSKttTnTBs1IluuWcZxIkQ
 u7Xa4DybIqgdnsJuG5h0VIoCA9EYDVKP/e9D5Cc0uXNaHXAzCCnkq3h2OQDFDogKUS+X
 F52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779200202; x=1779805002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A53zkpNW3s1KQ9ryBUm4Smimbnrb4y3hbZwk2WoCnO8=;
 b=ncuCozCz0VnM5pN/5sh9SqOzwh+g9GoGc9DUuPaRFA2cIhEsliUY310pq+RsKYsrEt
 sFyhM1JHJiv9zOJAtQ95RAM9dSRt9WMIPiAC6TXKarZ5yxmv4ypU2urypMSlWPC+BW3F
 91kp4eCduIc2P18NFfy8eKVkgsPGvp4PXwXY/Xs3qfuLKIQ+SN4K3HrT/pYnwtBU7z3u
 G3KJsZJQj9Y3wJK5aLsSrycBJg+xZbFaM9VmUWsLoD2ZSOnIrjqC+rUcb2QpW0pZ6fsf
 CuOvWsoSgRJqYb5vZIi+0SMb6w3wMXBWQRbFmqxOb4WazhkbTyK3gRaprxZuRUeAXDUu
 xJ5g==
X-Gm-Message-State: AOJu0Yy+CCGmpRvwI/SOkgCys5pOwLjkqirEzlNEg44iGxL/ZtRoZOq1
 nme/MP63STdt0VvSxzvNuOpMOTcLmU8c04pmttRc1lsv1AixZJqNiQSNJ+1z6a655MtGVPpRVj8
 C/Y4c
X-Gm-Gg: Acq92OE05KTHjQcqYhXUKLtouNEdAvu01f5yt67oOAN1mEnkVYrUYhrZImUUiv+1TEP
 Z2+y1g6lwucrfhQ/kmNytJ8I3wU05Otk97RyD4nXIM1/1CtSychySUCiubz/Q653NMWWyBkzcfE
 mK+7V5P3zlXbh2UqtVGKEFUgkxMdj+zuiLq1PL5EoVJdKVH+rB0WekgAU/nv6XjEJf0gBS3R0OY
 IEUgff716cMAX/c5TvTRvGReFvoHZeiSO2usb88YUUg2K61xffKYozt12GdjrYyNjlvQ7El4wQb
 7u/dALYZ1x1w3xbopTX2Dld7opVGhu6rqHGg2GHnuE8md0f5MSuwchx2PElccvbCr6hSY+ESWVV
 Gb6PD1QIXNi+kk/+mvIzLc8X6zbCjb9q8d2pU08D93186XYl+58DmKv39ywkfCJ6rHwdY4UAbmK
 mb6saaVDrvw5ZUVgcqCCjl5rBYq6pY4ys5zAwcngiNzciUaQ==
X-Received: by 2002:a05:7022:3d86:b0:128:d9a1:b68b with SMTP id
 a92af1059eb24-1350484b276mr6780074c88.33.1779200201468; 
 Tue, 19 May 2026 07:16:41 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2352f2sm23125121c88.10.2026.05.19.07.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:16:41 -0700 (PDT)
Date: Tue, 19 May 2026 07:16:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v17 00/11] net/sxe2: fix logic errors and address feedback
Message-ID: <20260519071638.17791ad5@phoenix.local>
In-Reply-To: <20260519030132.3780057-1-liujie5@linkdatatechnology.com>
References: <20260518091405.3295896-12-liujie5@linkdatatechnology.com>
 <20260519030132.3780057-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 19 May 2026 11:01:21 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set addresses the feedback received on the v10 submission
> for the sxe2 PMD. The primary focus is on fixing vector path selection,
> ensuring memory safety during mbuf initialization, and cleaning up
> redundant logic in the configuration functions.
>=20
> v17 Changes:
> - Fixed vector Rx burst function being overwritten by scalar selection.
> - Refactored Rx/Tx mode set functions to seed flags from caps first,
>   eliminating tautological checks.
> - Added memset for mbuf_def in vector init to avoid uninitialized reads.
> - Converted pci_map_addr_info to designated initializers.
> - Removed dead Windows-only code in meson.build.
> - Added NULL checks for mbuf free for driver-wide consistency.
> - Updated burst_mode_get to accurately report AVX paths.
> - Adjusted SXE2_ETH_OVERHEAD to match actual VLAN capabilities.
>=20
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
>=20
>  .mailmap                                   |    1 +
>  doc/guides/nics/features/sxe2.ini          |   29 +
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
>  drivers/net/sxe2/sxe2_txrx.c               |  351 +++++++
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
>  41 files changed, 9202 insertions(+)
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
>=20

Overall I am pleased with this and no AI review feedback.
But noticed some discrepancy between documentation and implementation
around feature; so asked AI to double check that.

Addendum to v17 review: features matrix vs code
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Patch 02/11: doc: add sxe2 guide and release notes
--------------------------------------------------

The doc/guides/nics/features/sxe2.ini file claims a number of
features that the code does not implement.  Cross-referencing
each "Y"/"P" line against drivers/net/sxe2/sxe2_ethdev.c
(sxe2_dev_info_init) and the final dev_ops table:

  VLAN offload         =3D Y

    Neither RTE_ETH_RX_OFFLOAD_VLAN_STRIP,
    RTE_ETH_RX_OFFLOAD_VLAN_FILTER, nor
    RTE_ETH_TX_OFFLOAD_VLAN_INSERT is in dev_info->rx_offload_capa
    or dev_info->tx_offload_capa.  Applications cannot request
    these offloads.  No .vlan_offload_set, .vlan_filter_set,
    .vlan_strip_queue_set, or .vlan_tpid_set callbacks are
    registered.  The only references to the VLAN offload macros
    are inside SXE2_RX_VEC_SUPPORT_OFFLOAD / SXE2_TX_VEC_SUPPORT_OFFLOAD
    (the vector-path allow-list), where they are filtered, not
    advertised.

  QinQ offload         =3D P

    No RTE_ETH_RX_OFFLOAD_QINQ_STRIP / RTE_ETH_TX_OFFLOAD_QINQ_INSERT
    in offload_capa.  The Tx path does handle RTE_MBUF_F_TX_QINQ
    in the descriptor builder, but with no offload-capability
    advertisement an application has no way to request it.

  Timestamp offload    =3D P

    RTE_ETH_RX_OFFLOAD_TIMESTAMP is not in rx_offload_capa.
    No .timesync_enable / disable / read_rx_timestamp /
    read_tx_timestamp / adjust_time / read_time / write_time
    callbacks are registered.  The only occurrence of the
    timestamp offload symbol is inside SXE2_RX_VEC_NO_SUPPORT_OFFLOAD
    (i.e. the list of things the vector path filters out).

  FreeBSD              =3D Y

    drivers/common/sxe2/meson.build and drivers/net/sxe2/meson.build
    set "reason =3D 'only supported on Linux'" when excluding
    Windows.  doc/guides/nics/sxe2.rst states the PMD "is
    designed to operate alongside the sxe2 kernel network driver"
    and "communicates with the kernel driver via ioctl
    interfaces" =E2=80=94 that kernel driver exists only for Linux.
    Either (a) drop "FreeBSD =3D Y" and gate the meson build with
    "if not is_linux: build =3D false", or (b) provide a FreeBSD
    kernel companion and update the meson reason string.

  Inner L3 checksum    =3D P
  Inner L4 checksum    =3D P

    These could plausibly map to RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
    / RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM (which are in
    tx_offload_capa) plus the TNL_TSO offloads.  Worth confirming
    the mapping is what is intended.

What the matrix gets right (verified):

  Fast mbuf free       =3D P  -> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
                                advertised in tx_offload_capa.
  Free Tx mbuf on demand =3D Y -> .tx_done_cleanup registered
                                (patch 11).
  Burst mode info      =3D Y  -> .rx_burst_mode_get and
                                .tx_burst_mode_get registered.
  Queue start/stop     =3D Y  -> .{rx,tx}_queue_{start,stop}
                                registered.
  Buffer split on Rx   =3D P  -> RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT
                                in rx_offload_capa.
  Scattered Rx         =3D Y  -> sxe2_rx_pkts_scattered{,_split}
                                burst functions present.
  CRC offload          =3D Y  -> RTE_ETH_RX_OFFLOAD_KEEP_CRC in
                                rx_offload_capa.
  L3 checksum offload  =3D Y  -> IPV4_CKSUM (rx+tx) in offload_capa.
  L4 checksum offload  =3D Y  -> TCP/UDP_CKSUM (rx+tx) in
                                offload_capa.
  Rx descriptor status =3D Y  -> dev->rx_descriptor_status set
                                (typo'd name "sxe2_rx_desciptor_status"
                                =E2=80=94 missing 'r' =E2=80=94 but functio=
nally
                                wired up).
  Tx descriptor status =3D Y  -> same; sxe2_tx_desciptor_status
                                with the same typo.

Suggested fix
-------------

For the v18, please either:

  (1) Add the missing offload bits (VLAN_STRIP, VLAN_FILTER,
      VLAN_INSERT, QINQ_STRIP, QINQ_INSERT, RX_TIMESTAMP) to
      offload_capa and implement the corresponding callbacks; or

  (2) Drop the corresponding rows ("VLAN offload",
      "QinQ offload", "Timestamp offload") from sxe2.ini to "N"
      or remove them entirely.

Also rename sxe2_{rx,tx}_desciptor_status -> _descriptor_status
to match the dev_ops field name, and decide what to do about
the FreeBSD / Linux-only contradiction.
