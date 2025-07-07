Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7CC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 14:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58CB40287;
	Mon,  7 Jul 2025 16:57:36 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id D59AC4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 16:57:34 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a7a8c2b7b9so47946371cf.1
 for <dev@dpdk.org>; Mon, 07 Jul 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751900254;
 x=1752505054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AUypNZ0FB/93pcCqhdFkS8wFcgnhWUu8VEOqbyb36E=;
 b=CparyzLiTBPxIa/KgxdyK2VOJr9ArmBGcoegeZ2IarUfP8CPkdUbjq3zcJ/lCgOGzx
 nnVG6e/yujxgyeXjc6UiivGLQOIm2TfGIwoq5hLzndSSOq5qxmmUOwkD5SaZVZ7jcX/p
 dwMox7aQLdm2Nsw0EomSGM8LLqZy/rPVpL627tt2fL6GbHXIade6cKdURBkkt8OEFK/l
 Sej6sMB5LYlHBDEwU3SOHJFXGbN/e81YXYlPC5iUTCOgp6DswDY5jA5knBpleR/D8qHF
 yCdVsXIm0Fzq/++135ZYswEcgu2dL8ruolCWCpDgx6IuV/qZusXeREp2w4q+7ZcDJvjE
 m0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751900254; x=1752505054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AUypNZ0FB/93pcCqhdFkS8wFcgnhWUu8VEOqbyb36E=;
 b=IJyPfB/9X3uF6gJxQ48bvvHxfcTxaJJjiO/sE9f9r/XHLZEjX7sz3xq/cXPT7QtK4W
 xjHe8i6Zz+VZ3NML8/Tyk7lh5ZOAhDgAdTZ5HZvN8Ob/VlMU+wxxSz8YqF29BVwM38Uh
 jdX2K6qMWDu99GmgU5pL1GaBSi4vs4tkisS2WCMLHapFyhMQO6qE6TUarzClD1do2u0I
 196otuytm39Djo5Nnf/BhvpirxeeO0Qt6rirSlzzWwBNIzzWIBFfOeUDf7g0KvIbttIi
 l3g91pqyDwzC4aKPSPXDG8VJNobUa+YgDWjYX3lhdi8nryyYVuQtdmeUU4YZ6CZ5vfVV
 ZGqw==
X-Gm-Message-State: AOJu0YxZqq93QT0M34/g4jW8gN1n5BNWHfvQmFJO+J+i2u8inVhaCZi1
 QDXazmTpQi71txHMrKQ41NJSbiVgXLk2J3nIxtC7f8GTAJYcPMDEoX0iBHgsgaoUIg5TcP+tv1e
 CnRAg
X-Gm-Gg: ASbGncvkLEh3o0Hwr8XmGNuQEpHySYx1aAndJK+GdUdNPOJTPY6uDI3GerRYW1nytXB
 pJCavfMhnO9WnKrvCOh6zR/9yBwZWsFCr51JtMRvtRxeOTMqhYW2G5f8ZmxvxJsDEst0DOWtJ/w
 xi9dYqUsRDznQZrRU4id1w38DmhcSYYtNeio3JBlj3aD6i4W+zL4kzJr1MLKfys+enauFbh6pSf
 ofRcz35mF8i3VCxiWvJdJWNOPqi7nHj816q8jZOmUF7pQ9JxbGqoowrTALVWUGzd2n3uZcwprXf
 +46CzbfKnUA6jFB2NsdVtpbT5zKkOxpArFz/z+we+w/mvU8uip27l9Uto//9C4edbgT4QcPb45v
 F3c518KWhvliJ6iql3NjMiL+9nZ7aWBgV8apRGRw=
X-Google-Smtp-Source: AGHT+IF4JyLL589qE3tXnafyTmtsxxRIDMmrqWelSLFDfpQNxfDjksWJBEWgYdP7Imosb4CXBOZzBg==
X-Received: by 2002:a05:622a:148e:b0:4a7:24b5:71ad with SMTP id
 d75a77b69052e-4a9987cfeadmr173355091cf.35.1751900253972; 
 Mon, 07 Jul 2025 07:57:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949fafb9sm64994541cf.29.2025.07.07.07.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 07:57:33 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:57:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250707075731.389844e7@hermes.local>
In-Reply-To: <20250707115819.12826-2-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-2-liujie5@linkdatatechnology.com>
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


> diff --git a/drivers/net/sxe/Makefile b/drivers/net/sxe/Makefile
> new file mode 100644
> index 0000000000..f75fd35e32
> --- /dev/null
> +++ b/drivers/net/sxe/Makefile
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2010-2016 Intel Corporation
> +
> +include $(RTE_SDK)/mk/rte.vars.mk
> +
> +#
> +# library name
> +#
> +LIB = librte_pmd_sxe.a
> +
> +CFLAGS += -DSXE_DPDK
> +CFLAGS += -DSXE_HOST_DRIVER
> +CFLAGS += -O3
> +CFLAGS += $(WERROR_FLAGS)
> +
> +EXPORT_MAP := rte_pmd_sxe_version.map
> +
> +
> +ifeq ($(CONFIG_RTE_TOOLCHAIN_ICC),y)
> +#
> +# CFLAGS for icc
> +#
> +CFLAGS_BASE_DRIVER  = -diag-disable 174 -diag-disable 593 -diag-disable 869
> +CFLAGS_BASE_DRIVER += -diag-disable 981 -diag-disable 2259
> +
> +else ifeq ($(CONFIG_RTE_TOOLCHAIN_CLANG),y)
> +#
> +# CFLAGS for clang
> +#
> +CFLAGS_BASE_DRIVER = -Wno-unused-parameter -Wno-unused-value
> +CFLAGS_BASE_DRIVER += -Wno-strict-aliasing -Wno-format-extra-args
> +
> +else
> +#
> +# CFLAGS for gcc
> +#
> +CFLAGS_BASE_DRIVER = -Wno-unused-parameter -Wno-unused-value
> +CFLAGS_BASE_DRIVER += -Wno-strict-aliasing -Wno-format-extra-args
> +CFLAGS_BASE_DRIVER += -Wmissing-prototypes
> +
> +endif
> +LDLIBS += -lrte_eal -lrte_mbuf -lrte_mempool -lrte_ring
> +LDLIBS += -lrte_ethdev -lrte_net -lrte_kvargs -lrte_hash
> +LDLIBS += -lrte_bus_pci
> +LDLIBS += -lpthread
> +
> +#
> +# Add extra flags for base driver files (also known as shared code)
> +# to disable warnings in them
> +#
> +
> +$(shell cp $(SRCDIR)/pf/* $(SRCDIR))
> +$(shell cp $(SRCDIR)/base/* $(SRCDIR))
> +$(shell cp $(SRCDIR)/include/*.h $(SRCDIR))
> +$(shell cp $(SRCDIR)/include/sxe/*.h $(SRCDIR))
> +$(warning "file copy done")
> +
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_common.c
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_hw.c
> +
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_ethdev.c
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_irq.c
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_main.c
> +SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_pmd_hdc.c
> +
> +include $(RTE_SDK)/mk/rte.lib.mk

DPDK uses meson not make.
The ICC compiler is deprecated and removed.
