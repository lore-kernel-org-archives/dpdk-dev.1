Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA3FF885A
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 22:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 282774026A;
	Sat,  2 May 2026 00:45:44 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id BCE914025A
 for <dev@dpdk.org>; Sat,  2 May 2026 00:45:42 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c726ef332so3782954c88.1
 for <dev@dpdk.org>; Fri, 01 May 2026 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777675541;
 x=1778280341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pB8BZa9cmMMTDOgVJUtjWPLqGhQpukRd1Msk1qc5YAU=;
 b=fiAW5TMf0Z9xkAgZ+yKhNgkYvBNgYvCMxxC4I3Psr/a5FgOhqLuxvUM44PBhSBTEPu
 Qm9O1bhvc02e4nOJzLBBBvKvleZ2Aw5bR6QFq88eqH8SKGxxf4UHycd2t1VJ8DoiMqOX
 EyuwOmH9n4V27lHfn9o5saSJFVSHQqoiiUNveeerGZAv0FjtoWiFM6VicnoLFa1NxwrK
 Khwkn4TATDVVeB2LO//+RUi9hvsUq+lUcbdG7yOw4vv6hADikPudx0BbuF4OmrDnF/0r
 ucwWAkjCtwqUHUY+5viEq7jVbMf+W5fZZMwgpvIoaXOK44SB32wb+Jq/JI4FmGfgE8yj
 vqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777675541; x=1778280341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pB8BZa9cmMMTDOgVJUtjWPLqGhQpukRd1Msk1qc5YAU=;
 b=FzDRNvQSXSf7ZiKhL+vORtxaHujTsHZI35+V0B77mV6aajj+IuuYwnYji2N7mnAjof
 DVU9WiXiKds8UBPBerb8ZoW/rNc3V1dwycWd8kLoFTvfUQXv6R36By77yNvjfTfqEPx2
 qeUyGE6MenuxwvxXOh6DONxzPEMUApUeTWsOBkVIU37OclbSOs8k+Sf5T7YmiosO7Bfc
 I3fuWtIdL18doqAElL8JhLtR0zpn3wuGwYrfp9mfPM6Cg8rgLD24qRwAtJb+Aq0gGx1b
 kRAg/bZfM0H+Dg1b20RFOA3MK8Kxa81obAzCrogcP+Dz71/nkIaTTrXVAEiEILJC2cUR
 oXRA==
X-Gm-Message-State: AOJu0YxH0iRnzt8XptLVJci8A6bNq6LMu7Ji8nu35uhO0T5y8P03cYfX
 uqlNkWsgQXWSLBtQykEO6p0EbNVoVFnQwh+4fKTssU9iIvWVX5M7nCe16tI0RbnfUHo=
X-Gm-Gg: AeBDievC+UVpoewXYOcr9pWxy9HaMEWdIpB5+iYI53XxmD/LOF6dgjma+gp/SLOcGBM
 XlLG7gFSODo0U8CHHB7B503J2Ax4kcUepYhGP9hNOI2Q1m0RPAWC3ggPMbkvfXCjWSmFiCf2hFz
 WOIEa9SliLn0SMP7rbPqnvh2/kbTCCd+h1m9N5oEgjRFBsW81fRqy+K2a1q3hyH5uqw5CG2H8CR
 2XbzNZDMTTt8lG9KPRDe+MPe7xBA050gPdb+ZBwSquls/Mza8yaYQE/xl9hCbks9upb/WnklGw3
 t0EKrJQQGhMDdvc/iOEwNzwBV4dNKKRuGt3GjkK5eYKelH9k31nAXnv8NW5udajyvvf+K5ZErHn
 zCOSWmCe87C6Nj9498xGdmPBHdPO0LbP4AFo32vVx/W5qQbIQMcNPIXpGRt8magU52Ks4bBjsNA
 4qmmm07Vygfb98OJwNb59ZiFRusbaGcrk8pIwKJDyeoQb1DQ==
X-Received: by 2002:a05:7022:e98d:b0:12d:b26f:caf7 with SMTP id
 a92af1059eb24-12dfd7ac13fmr478296c88.7.1777675541430; 
 Fri, 01 May 2026 15:45:41 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df8452edesm5147919c88.14.2026.05.01.15.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 15:45:41 -0700 (PDT)
Date: Fri, 1 May 2026 15:45:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 00/18] Support VFIO cdev API in DPDK
Message-ID: <20260501154538.39181bc4@phoenix.local>
In-Reply-To: <cover.1772115411.git.anatoly.burakov@intel.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <cover.1772115411.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 26 Feb 2026 14:17:23 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> This patchset introduces a major refactor of the VFIO subsystem in DPDK to
> support character device (cdev) interface introduced in Linux kernel, as =
well as
> make the API more streamlined and useful. The goal is to simplify device
> management, improve compatibility, and clarify API responsibilities.
>=20
> The following sections outline the key issues addressed by this patchset =
and the
> corresponding changes introduced.


The patch set is still interesting but lots of build failures.
You need to rebase and resubmit.

Look for shadow variable warnings etc.
ccache clang -Ilib/librte_eal.a.p -Ilib -I../lib -Ilib/eal/common -I../lib/=
eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/inc=
lude -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/inclu=
de -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/=
kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metric=
s -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Xcla=
ng -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -W=
comma -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing=
-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition =
-Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite=
-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dcorei=
7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API '-DABI_VERSION=3D"26.=
1"' -DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP -DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.e=
al -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ lib/librte_eal.a.p/eal_linu=
x_eal_vfio_group.c.o -MF lib/librte_eal.a.p/eal_linux_eal_vfio_group.c.o.d =
-o lib/librte_eal.a.p/eal_linux_eal_vfio_group.c.o -c ../lib/eal/linux/eal_=
vfio_group.c
../lib/eal/linux/eal_vfio_group.c:914:8: error: declaration shadows a local=
 variable [-Werror,-Wshadow]
  914 |                 char dev[PATH_MAX];
      |                      ^
../lib/eal/linux/eal_vfio_group.c:905:94: note: previous declaration is here
  905 | vfio_group_setup_device_fd(const char *dev_addr, struct vfio_group =
*grp, struct vfio_device *dev)
      |                                                                    =
                          ^
1 error generated.
[97/7766] Generating
