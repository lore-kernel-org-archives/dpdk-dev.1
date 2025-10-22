Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C563CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:33:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B72D402BC;
	Wed, 22 Oct 2025 18:33:07 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id D308440262
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:33:05 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b6a225b7e9eso5071434a12.0
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761150785;
 x=1761755585; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1/xp0LNq8gDzyxj9RVL3RsFeYGcnQMxm6+hEtsTO14=;
 b=XmMS6wgmx4Duvb68aiiIEZ6w8+kyclKZGjzbr9bpm4Id3qCB7d6vlfjt3bAw6hlMua
 KP+rp0UYf7EJnDBdfOEunvi3HFp4aTBu6OqbMcf0ZYn68672NnqML5DeC9Z4gCP5FqI1
 2e3ox3GwKTWqRrlLomW/vugePr1peGT9pkKs5zAdlI4tfbuuWM2NJdWSSnI5niW1vBtF
 HDLlQxlBrmSa/siY3juPrYUr6ZDv7V0cECe1vX+Uf0kX66G5Go5lSMN8AwioWRwHey26
 dQECsxk5uS4ruf+bsG5NBgoEFF2y0QBVT97pYvyzKtFCTEDuZKb3XcpWwr6jTsiQ28+Q
 ZXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150785; x=1761755585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1/xp0LNq8gDzyxj9RVL3RsFeYGcnQMxm6+hEtsTO14=;
 b=eUjiC2hAQSdDko27+nM2P/LFGsnbXMyDqiOaLiF50gcKOM4UgEa2TgATnZ4ypk13b/
 q++CovmfRY3v9QCxbqupksHYSH9fxMQiA69Ga6Xp/W7rHBb3OoVBi7ETT00VysxUe5ba
 n2clmSpZHt7pFV9LFNQwEcXPEBw8Ht5ZZTvxQVK/KuKiPiI1ySSbuqtsBs89TFWg9x/x
 yMDEr6VWn9ib80ZqbLcUIRMnaUXtVbJEddTgsNdbfQ/ApSIiBagk7d5DG2onmernzcgB
 REMGsGioMfLGu5L2bhSJLJMvIikHdx6FZ9YpvpA2ttB95j59a0B4xbDf3Do68CSnlat7
 igdQ==
X-Gm-Message-State: AOJu0Yy3mAYz0H4gsAssa7mJh473u/vHM6EU9/IykctMIzZXv9cTS2aP
 So50LrOpjevuccPyQKT9w3FiPB0YX7TzwqEJ6fPTQpmDj2VF/uxYrMkGhWgEQvix7DoMLymp+Ew
 nEsEv4hU=
X-Gm-Gg: ASbGncuTYROBsMAoAZ1eeJZux5cnLe6KnpAyb14cVOoG4sNU4NEpPl9FYDg5OxEWYJJ
 t7O12OeIr35F6RUAhJFDcInxqUDOvsrpuuuyJ2yEs4kdI/ZTMZkqve58+XxnBrM5lijuzj3DrT3
 VwJ7wxJZXl1Vddr3Rvjk8yUZNWv7CfFxuuzbcEcQgbV7rc99Jsh5a5dG8lJ/FJB/vqmT+7JUHkm
 nlEAVBL1X1/fPZ7GaSyf6YMZE0ffIRnVHSse0EI7NZ/KP2fbYWJMJBM8k5ojs+VYKLqAwBHPl+E
 dhEO54Q8WEk96gV6G2HgVmdbAw8Z5/6RSluTb+zjVQLHsu9YJXsjGgs/0uQzDdik7OlNL7939ht
 iiTkF7ig8QWApK0W20Iw2FckIRwF2eHpht45lJReTlR01XiRpxLDQiIfKLn5pyYUAw/CoLmDI9f
 g/hvlg4GCMxP7XTzyiS4lGzYg2EAbL58x7/OqyIcPGaIsLSR2X+A==
X-Google-Smtp-Source: AGHT+IFtYyb5bB2mJ6nr8/PcWR2TSItlg3kw65zOk93OhvObJf9mNgYza/NwLIaHsG4ZtpUtRx4ySA==
X-Received: by 2002:a17:903:11ce:b0:273:3f62:6eca with SMTP id
 d9443c01a7336-290c9ca804emr277283955ad.18.1761150784374; 
 Wed, 22 Oct 2025 09:33:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d561dsm142490895ad.55.2025.10.22.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:33:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:33:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v14 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20251022093302.38f7659a@phoenix.lan>
In-Reply-To: <20251022035210.3243056-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251022035210.3243056-1-dimon.zhao@nebula-matrix.com>
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

On Tue, 21 Oct 2025 20:51:53 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats 
> 
> Support NICs:
> -------------
> - S1205CQ-A00CHT
> - S1105AS-A00CHT
> - S1055AS-A00CHT
> - S1052AS-A00CHT
> - S1051AS-A00CHT
> - S1045XS-A00CHT
> - S1205CQ-A00CSP
> - S1055AS-A00CSP
> - S1052AS-A00CSP
> 
> Dimon Zhao (17):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl: add HW layer definitions and implementation
>   net/nbl: add Channel layer definitions and implementation
>   net/nbl: add Resource layer definitions and implementation
>   net/nbl: add Dispatch layer definitions and implementation
>   net/nbl: add Dev layer definitions and implementation
>   net/nbl: add complete device init and uninit functionality
>   net/nbl: add UIO and VFIO mode for nbl
>   net/nbl: add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl: add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device Tx and Rx burst
>   net/nbl: add nbl ethdev infos get
>   net/nbl: add nbl device xstats and stats
>   net/nbl: add nbl device set MTU and promisc
> 
>  .mailmap                                      |    4 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |   18 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   87 ++
>  doc/guides/rel_notes/release_25_11.rst        |    4 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  762 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  105 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1074 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   89 ++
>  drivers/net/nbl/nbl_dispatch.c                | 1318 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  138 ++
>  drivers/net/nbl/nbl_ethdev.h                  |   31 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  977 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  132 ++
>  drivers/net/nbl/nbl_hw/nbl_hw.h               |   28 +
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c |  228 +++
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  249 ++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  908 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |   40 +
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  459 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  120 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |   26 +
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |  100 ++
>  drivers/net/nbl/nbl_include/nbl_def_hw.h      |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   92 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  201 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   31 +
>  41 files changed, 7937 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h
>  create mode 100644 drivers/net/nbl/nbl_core.c
>  create mode 100644 drivers/net/nbl/nbl_core.h
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
>  create mode 100644 drivers/net/nbl/nbl_dispatch.c
>  create mode 100644 drivers/net/nbl/nbl_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_ethdev.c
>  create mode 100644 drivers/net/nbl/nbl_ethdev.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_hw.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h
> 


Added to next-net. Fixed the stats handling to account for changes
to queue stats internal API.
