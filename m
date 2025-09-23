Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4929FCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 920E040615;
	Tue, 23 Sep 2025 16:48:02 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5D76C402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:48:01 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8498f5194deso234835985a.1
 for <dev@dpdk.org>; Tue, 23 Sep 2025 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758638881;
 x=1759243681; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPqgaKsg/aPA245vm+plvYXxCCh+nj2WVz+Vx+bUpPA=;
 b=ilsVVZ/9hKtM9qK4qQgGYwpTVGdwcgDhwHxtekiU7UllaQ9TWtykdaRUhP7Z7SoZYL
 DZ9Iu9qQCliJqjJZVCYVh8tRACDcX7U75iL2VTzvZs/plKwQqxuKaGhGLGCUbhdzLbAH
 Q/Q3nqe4SPyH1haPXCPdvCFooGr9IbwthC98Bn6/oD+il+996R9LR4uc9tjalt05X7uY
 Ix9jCwNgc+iZgRHo2Vby579c4unksZZ0HzPI9rkG/KKeuTvNTv7JnHyDdJd/+ryRvynU
 MAbNdWq9zuL93ZmB0H8/Vavdw48ecRtwjM1yqaeRd3pgSK0vAkQIQJeq8fwiD1DjvlI4
 UOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758638881; x=1759243681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPqgaKsg/aPA245vm+plvYXxCCh+nj2WVz+Vx+bUpPA=;
 b=lsYgXdnnqUCxuMKtLUH80vL00gBTWSKA5xtD+olanheKRNHX09LpkiIVUHh5yhFJlE
 ntjeyIIL0qOnjt8YQA/XSWGDE2mKOqDL2igNJK5z9rjz8eOmQaSw9QMJWl/5E6bfDVf9
 BEXeEcMwyxkGD66kCyZwU9tbskWE9edJctCzEvpPnweri9Nw+r107Ofuy2+Gpyauf9vC
 JEkx9cNHiESQkWSBlBWNMeQhi13CjqBWhT/Rn4zsM4+EbMvU1HN/AuO8ODvZAF92+wRH
 X7jal2fXw2VifMXi2I4Vh0B0z1RTXx1KKCgmdTCJlI3unQ0RlS6LdXBClDnuM6ozeKr2
 BcDg==
X-Gm-Message-State: AOJu0Yy5FyalAe6152M31tYqXRHeRFoy/wXCxw/YiiFTKUjp1z+G6nAu
 OYtmwvacq3rs4b9JbejTwlLNWmqffGgBJq3vdk32VfZcmf2hRMjK/ThMd5hzlKTtv6Jn599ZXO9
 b82LA
X-Gm-Gg: ASbGnct0krVlDmKr+/5wQicUD2XWq62kPPqEPt3cUekKS2CGQH50omTaNo/3AgF1kxc
 AWB5F2xoSh3Ff8R36Xo8RAkJTHrPwP1vK2mskdhPlMu6YhO38Uv432Yql9fVecOYW038lryUhXR
 5FpfsNssjRkxfrIgvIXj/gWZYFA9osf+LQdTK2bxPqW+Mn1XSTIX+pEPiFarwNRbB2vxXxVl9RT
 +PENEoNcJ7B75wgs79QMgpdX/aGhsS+naNa5jhtcAx1UAUCCHctbdviNw0QzHuxU7tD22tr/7VL
 SPVIHE0+z9KXAnVdJzbWWic4c+reA8Ygk7ESXbA+1Wdd3v+CgmSb60FJcyEKiAMzAlA7wDQpzsp
 qHMPFVG+GdnazxLQBslhHO2Qyl4ku93YYTGMG1P8aA/Zgp8f+3ymVRjn1/Eg/4sEc4EtTas4DZV
 7irsODBUnqEA==
X-Google-Smtp-Source: AGHT+IFf6SS3L45OpmO2dbYuExOcsXIQZiKX1yl2cU3qaWr5Da+rvAAfg+9xjUBiWKlHwsnMKgL4Yg==
X-Received: by 2002:a05:620a:4808:b0:83a:dd34:aa77 with SMTP id
 af79cd13be357-85176047373mr317253885a.68.1758638879439; 
 Tue, 23 Sep 2025 07:47:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-848dd28fb3bsm420651985a.28.2025.09.23.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 07:47:59 -0700 (PDT)
Date: Tue, 23 Sep 2025 07:47:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v2 0/7] migrate threads to DPDK service framework
Message-ID: <20250923074715.41aed917@hermes.local>
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
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

On Mon,  8 Sep 2025 16:17:32 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This modification provides better resource (CPU) management for NTNIC PMD.
> 
> The following threads are migrated:
>         * FLM update thread
>         * Statistic thread
>         * Port event thread
>         * Adapter monitoring thread
> Additionally, a warning is added to inform users about the importance of
> dedicating lcores to the DPDK service framework when using the NTNIC PMD.
> The code is also cleaned up to use pthreads and rte_thread APIs.
> 
> After this patch series, an each application using NTNIC PMD should
> dedicate at least five(5) cores for DPDK service framework to ensure
> proper operation of the NTNIC PMD.
> 
> The sercvice cores can be dedicated by EAL options:
>         * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
>         * S SERVICE CORELIST List of cores to run services on
> Or with special API by application itself.
>         * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
>         * rte_pmd_ntnic_service_get_id to get a service ID.
> 
> Serhii Iliushyk (7):
>   net/ntnic: introduce service API for NTNIC PMD
>   net/ntnic: migrate flm update thread to service
>   net/ntnic: migrate statistic thread to service
>   net/ntnic: migrate port event thread to service
>   net/ntnic: migrate adapter mon thread to service
>   net/ntnic: add warning about service cores
>   net/ntnic: cleanup using pthreads and rte_thread
> 
>  doc/guides/nics/ntnic.rst                     | 112 ++++
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |  27 +-
>  .../net/ntnic/include/common_adapter_defs.h   |  15 -
>  drivers/net/ntnic/include/nt4ga_adapter.h     |   4 -
>  drivers/net/ntnic/include/ntdrv_4ga.h         |   4 -
>  drivers/net/ntnic/include/ntnic_stat.h        |   2 +-
>  drivers/net/ntnic/include/ntos_drv.h          |   4 +-
>  .../link_mgmt/link_100g/nt4ga_link_100g.c     | 303 +++++-----
>  .../link_agx_100g/nt4ga_agx_link_100g.c       | 306 ++++++-----
>  drivers/net/ntnic/meson.build                 |   2 +
>  drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   2 -
>  drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |   1 -
>  .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |   1 -
>  .../profile_inline/flow_api_profile_inline.c  |   2 +-
>  drivers/net/ntnic/ntnic_ethdev.c              | 520 ++++++++++--------
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  17 +
>  drivers/net/ntnic/ntutil/nt_service.c         | 127 +++++
>  drivers/net/ntnic/ntutil/nt_service.h         |  62 +++
>  drivers/net/ntnic/ntutil/nt_util.c            |   2 +-
>  drivers/net/ntnic/rte_pmd_ntnic.c             | 104 ++++
>  drivers/net/ntnic/rte_pmd_ntnic.h             |  26 +
>  21 files changed, 1073 insertions(+), 570 deletions(-)
>  delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h
>  create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
>  create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
>  create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c
> 

I got a report from Raslan about format overflow from sprintf()
so dropping this from next-net for now.

Please consider resubmitting with a fix for that.
Something like this (untested) change to not use sprintf at all

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 3edf7796f7..18dab16f6b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2580,7 +2580,8 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
                                .callback_userdata = internals
                        };
 
-                       sprintf(port_event_spec.name, "ntnic-port_%d_event_service", n_intf_no);
+                       snprintf(port_event_spec.name, RTE_SERVICE_NAME_MAX,
+                                "ntnic-%d_event", n_intf_no);
 
                        const int port_srv_tag[2] = {
                                RTE_NTNIC_SERVICE_PORT_0_EVENT,
@@ -2612,9 +2613,8 @@ static int
 nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 {
        NT_LOG_DBGX(DBG, NTNIC, "PCI device deinitialization");
-
        int i;
-       char name[32];
+       char name[RTE_ETH_NAME_MAX_LEN];
 
        struct pmd_internals *internals = eth_dev->data->dev_private;
        ntdrv_4ga_t *p_ntdrv = &internals->p_drv->ntdrv;
@@ -2641,7 +2641,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
        }
 
        for (i = 0; i < n_phy_ports; i++) {
-               sprintf(name, "ntnic%d", i);
+               snprintf(name, sizeof(name), "ntnic%d", i);
                eth_dev = rte_eth_dev_allocated(name);
                if (eth_dev == NULL)
                        continue; /* port already released */

