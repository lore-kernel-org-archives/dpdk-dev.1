Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8353FC71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B08D5402BC;
	Mon, 16 Jun 2025 17:30:15 +0200 (CEST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51]) by mails.dpdk.org (Postfix) with ESMTP id 364E04021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:30:14 +0200 (CEST)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso2650395fac.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750087813;
 x=1750692613; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO8M9TxRPnftVGcdEyuQ515Z6Bymso2TqfOtNhTJh2w=;
 b=0CIqlQGnQ+r9oUYETbV86JKp4wYF6DSCRPZ9kdJkqQY9ne933C40MZh2IsgK8wIzqV
 vIhDPODusevCPppcPAfWHEcsmDANsmSXsyQrom5OYDXVpOpZJw1cu7evfQR1mGYNpFf2
 N7uE4b/Tn+sD4rq9RUWE+kuBzol27lQ2QLPiVH+NXqOYN9nRo9MTul4QHiNa81heoUHh
 fGAtnTjBmNoNnwApBw6H1U/AQKCMZS6PPnTsUe+wf9Ci9iO5PyMB+nu1nGOd8fg7EMQT
 Wgw7vvX1+bHo6s13qEdm0iX0ecozXBJUOcKVA5lHA/T3PKdLtv8kkq8JLfcBntkvKs1S
 A0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750087813; x=1750692613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nO8M9TxRPnftVGcdEyuQ515Z6Bymso2TqfOtNhTJh2w=;
 b=NyQcruD8U+MupB85G3bDlTxCJ3EgcVRZdvAIlNDsV0lNj9gSx3WWXxacGYdh8gKeBZ
 /tSn0RRNMQgY2rkh7BgvR4TKaRMs98AkK4JbwI4ZvQuStzD7b9InL6w3AIP9oak/liAa
 CObH1cVn2bUYKRVE2CyJgkt3Z6DeEeCdJ8iel2ntFEXfvvENDPwDyVOVQKrBFu49wqd4
 qzcDDWzoNIdxNb0Jw18qX7ECxWIvVitds2+CbqDor4lLaTFu4MnMvJvlU1d9GuWG2pT0
 3inqsxdNjMP4wmPZ59JXq8d9zbjdpcp1CBSRFOBNf860KTdcTDyvEwnuYsrhieVL33lD
 DLaQ==
X-Gm-Message-State: AOJu0Yxw2XHBuNFuSI4JynvNY+wvHEC7qEQBsf80Fs04PGs44bSO2rZe
 OrVcMSjCeX6LlhBsBLDKgdlBUuiCyd4gWwdtxPDxpoTaYq7RvcABWdk2LX3FsAE/Cxw=
X-Gm-Gg: ASbGncsniWLmMc3+16vGaiLkyccxSlzbHL+/4Yo4p1m+ihHvFqCXSBLyEcv+uPrQZ2W
 +4+nvpQZh+Iy3HM9bWgmYCIFAwFHd+QZ+GpVIMThOH7BU15/C3tXBzGytUARveGTtkqEFxYkCrR
 RzzYgclqfNyeavPJnbgmBXFa+/ImoWPusVl2oE53d/vgBoUXc/dce2w5rHeCSnAm0vxDEFjGzLr
 t6C9f9qmgX1B04Ga2G/QLBEtFIYI39F/4IiKsfoPCyiztjN5B+jCVPY6KGnxJdmU9LPwUnC/CZk
 UnexSeaOuLWy1VsOzZF0GCNTMUdVcv4oSKPPPJe0mUBkTfzL3ZNXOQs1aUhnbmlX8OS97TAR3f8
 IZ+OGFzcJ+J0iuQ5EpLB5R1yUevsknhrRtQi75jk=
X-Google-Smtp-Source: AGHT+IH0wZ0BfeWcdosuMy0cPCMPAIXE9LbiRfofLW6TMvhRC9pjyHxnY0SDnCPTqGQyGtEMFS0xOA==
X-Received: by 2002:a05:6870:7047:10b0:2ea:fc66:347c with SMTP id
 586e51a60fabf-2eafc663702mr3215337fac.26.1750087813238; 
 Mon, 16 Jun 2025 08:30:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108f2f6fdsm887031eaf.35.2025.06.16.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 08:30:12 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:30:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
Message-ID: <20250616083009.4a2d69f2@hermes.local>
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
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

On Mon, 16 Jun 2025 10:29:05 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> This feature is designed to monitor the lifecycle of mempool objects
> as they move between the application and the PMD.
> 
> It will allow us to track the operations and transitions of each mempool
> object throughout the system, helping in debugging and understanding objects flow.
> 
> The implementation include several key components:
> 1. Added a bitmap to mempool's header (rte_mempool_objhdr)
>    that represent the operations history.
> 2. Added functions that allow marking operations on an
>    mempool objects.
> 3. Dumps the history to a file or the console
>    (rte_mempool_objects_dump).
> 4. Added python script that can parse, analyze the data and
>    present it in an human readable format.
> 5. Added compilation flag to enable the feature.
> 
> Shani Peretz (5):
>   mempool: record mempool objects operations history
>   drivers: add mempool history compilation flag
>   net/mlx5: mark an operation in mempool object's history
>   app/testpmd: add testpmd command to dump mempool history
>   usertool: add a script to parse mempool history dump
> 
>  app/test-pmd/cmdline.c                        |  59 +++++++-
>  config/meson.build                            |   1 +
>  drivers/meson.build                           |   7 +
>  drivers/net/af_packet/meson.build             |   1 +
>  drivers/net/af_xdp/meson.build                |   1 +
>  drivers/net/ark/meson.build                   |   2 +
>  drivers/net/atlantic/meson.build              |   2 +
>  drivers/net/avp/meson.build                   |   2 +
>  drivers/net/axgbe/meson.build                 |   2 +
>  drivers/net/bnx2x/meson.build                 |   1 +
>  drivers/net/bnxt/meson.build                  |   2 +
>  drivers/net/bonding/meson.build               |   1 +
>  drivers/net/cnxk/meson.build                  |   1 +
>  drivers/net/cxgbe/meson.build                 |   2 +
>  drivers/net/dpaa/meson.build                  |   2 +
>  drivers/net/dpaa2/meson.build                 |   2 +
>  drivers/net/ena/meson.build                   |   2 +
>  drivers/net/enetc/meson.build                 |   2 +
>  drivers/net/enetfec/meson.build               |   2 +
>  drivers/net/enic/meson.build                  |   2 +
>  drivers/net/failsafe/meson.build              |   1 +
>  drivers/net/gve/meson.build                   |   2 +
>  drivers/net/hinic/meson.build                 |   2 +
>  drivers/net/hns3/meson.build                  |   1 +
>  drivers/net/intel/cpfl/meson.build            |   2 +
>  drivers/net/intel/e1000/meson.build           |   2 +
>  drivers/net/intel/fm10k/meson.build           |   2 +
>  drivers/net/intel/i40e/meson.build            |   2 +
>  drivers/net/intel/iavf/meson.build            |   2 +
>  drivers/net/intel/ice/meson.build             |   1 +
>  drivers/net/intel/idpf/meson.build            |   2 +
>  drivers/net/intel/ixgbe/meson.build           |   2 +
>  drivers/net/ionic/meson.build                 |   2 +
>  drivers/net/mana/meson.build                  |   2 +
>  drivers/net/memif/meson.build                 |   1 +
>  drivers/net/mlx4/meson.build                  |   2 +
>  drivers/net/mlx5/meson.build                  |   1 +
>  drivers/net/mlx5/mlx5_rx.c                    |   9 ++
>  drivers/net/mlx5/mlx5_rx.h                    |   2 +
>  drivers/net/mlx5/mlx5_rxq.c                   |   9 +-
>  drivers/net/mlx5/mlx5_rxtx_vec.c              |   6 +
>  drivers/net/mlx5/mlx5_tx.h                    |   7 +
>  drivers/net/mlx5/mlx5_txq.c                   |   1 +
>  drivers/net/mvneta/meson.build                |   2 +
>  drivers/net/mvpp2/meson.build                 |   2 +
>  drivers/net/netvsc/meson.build                |   2 +
>  drivers/net/nfb/meson.build                   |   2 +
>  drivers/net/nfp/meson.build                   |   2 +
>  drivers/net/ngbe/meson.build                  |   2 +
>  drivers/net/ntnic/meson.build                 |   4 +
>  drivers/net/null/meson.build                  |   1 +
>  drivers/net/octeon_ep/meson.build             |   2 +
>  drivers/net/octeontx/meson.build              |   2 +
>  drivers/net/pcap/meson.build                  |   1 +
>  drivers/net/pfe/meson.build                   |   2 +
>  drivers/net/qede/meson.build                  |   2 +
>  drivers/net/r8169/meson.build                 |   4 +-
>  drivers/net/ring/meson.build                  |   1 +
>  drivers/net/sfc/meson.build                   |   2 +
>  drivers/net/softnic/meson.build               |   2 +
>  drivers/net/tap/meson.build                   |   1 +
>  drivers/net/thunderx/meson.build              |   2 +
>  drivers/net/txgbe/meson.build                 |   2 +
>  drivers/net/vdev_netvsc/meson.build           |   2 +
>  drivers/net/vhost/meson.build                 |   2 +
>  drivers/net/virtio/meson.build                |   2 +
>  drivers/net/vmxnet3/meson.build               |   2 +
>  drivers/net/xsc/meson.build                   |   2 +
>  drivers/net/zxdh/meson.build                  |   4 +
>  lib/ethdev/rte_ethdev.h                       |  14 ++
>  lib/mempool/rte_mempool.c                     | 111 +++++++++++++++
>  lib/mempool/rte_mempool.h                     | 106 ++++++++++++++
>  meson_options.txt                             |   2 +
>  .../dpdk-mempool_object_history_parser.py     | 129 ++++++++++++++++++
>  74 files changed, 571 insertions(+), 4 deletions(-)
>  create mode 100755 usertools/dpdk-mempool_object_history_parser.py
> 

Could this not already be done with tracing infrastructure?
