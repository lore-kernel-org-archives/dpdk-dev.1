Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F8CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 12:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9365F402D1;
	Mon,  6 Oct 2025 14:55:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CDB6E402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 14:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759755352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdK9Jt+akqEUMYS5JVazmb+FB5xVSqUaCeWOyzRK+h4=;
 b=YvDBgd2NFiNHp19FhcRbBdlU4KEWlEjpLFjynR3LSxDIUmG0zl8wwVLLZbfbw68kqb05ta
 k5tRGJcNnMPKKajSxn8czwmzkzND/bBqs4q1484e/qL/5dHd1omG0KD7okRtvxemXSl2kp
 TJ5v+kP92lf1+kclFN+nuX7wg7jG2PU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-hEep0Y_dMG-YvczFHD9kJg-1; Mon, 06 Oct 2025 08:55:49 -0400
X-MC-Unique: hEep0Y_dMG-YvczFHD9kJg-1
X-Mimecast-MFC-AGG-ID: hEep0Y_dMG-YvczFHD9kJg_1759755348
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-375ecf5e30eso2368241fa.0
 for <dev@dpdk.org>; Mon, 06 Oct 2025 05:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759755347; x=1760360147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zdK9Jt+akqEUMYS5JVazmb+FB5xVSqUaCeWOyzRK+h4=;
 b=tG5FTUB3/bPy6YpCySeI8v67qOtT9CqUrieLQ5j3TDIbDy669WlaWDYWhnorQpQcrb
 SAsZ4PjPy1rggjEqgzbEzTQrcdLfIuxDFgDDBVjQ8uxUv0doJTu3aizv1mNS15QSVxvp
 wq8KfCDYjtFTgnTtEO6UP+qOAfCgLNmv70AfCFxSqQUxp2QZygHLD74LP0jf7dley1qp
 /c0qFFLdHC4K2VxjI1YEvbeOlbqs9vYC9pHxkTxippWVkRV8aOQFaP1Ko2kinsLqnciO
 /0UYOE/meRM9gABFoySVIBN+aE//GrVaPLBKHXM1Hv29fDdl6o0/5iCuMs75ekncvFqt
 152A==
X-Gm-Message-State: AOJu0Yy2DIHM5kNN2wTDtPrnYPLh/uf3IZ4WYjVGAveLI1AoChPI3JKY
 gKB1fo2LaYf64SCQz7TbRwjEmBorCm2Eo1M6biE9NBoLNqeQXZfAdHEeNpBm9Ng9iSN525ILngl
 LVWtOK5UrZYRHmSEI1ippzAo99QnaR/aJOQGhsFBXUqlRZDqkNCJiX8eUOayhlrX/Htb6ECaP5u
 qlSNamZcdumLrvxKGPfsA=
X-Gm-Gg: ASbGnctFL4kMghUHYpIFYWXDW1xSQHRhL7tYxtfnfkVVnfYu2dxQZEjzjykApfTanmX
 iwOvV9BnqrqtcvM639hKT6cmpFcBCqK6MLE9NdE2FPjtPTSS1hBiy8VEoXA2Iyub6pm4u9Q3cIi
 0mQMl/xX9HxOdzeuN3ucl3XmZFs63V
X-Received: by 2002:a05:651c:b10:b0:365:b79:8845 with SMTP id
 38308e7fff4ca-374c37199damr33819501fa.10.1759755347493; 
 Mon, 06 Oct 2025 05:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0VoUqRf6kuvuMaDsyqccPZ+EAvqmCf2rMYLE17r2AC2/qwpL4fGhdvyN+8QzgNA37la8br07Ze8Y/rpyTTAE=
X-Received: by 2002:a05:651c:b10:b0:365:b79:8845 with SMTP id
 38308e7fff4ca-374c37199damr33819411fa.10.1759755347021; Mon, 06 Oct 2025
 05:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
In-Reply-To: <20251006124506.388456-1-thierry.herbelot@6wind.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Oct 2025 14:55:35 +0200
X-Gm-Features: AS18NWBv53jQ6U1LmvwV42YhEi8KVtufIS7mta0TZvqAt56OAPKACXJpRoa-b40
Message-ID: <CAJFAV8zvhYiOy=PuUctg8N7EyM6asQdDNpnx_Xc+WusCz02L+A@mail.gmail.com>
Subject: Re: [PATCH] net/intel/e1000: reduce the optimization level for gcc >
 11
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Olivier Matz <olivier.matz@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ltl79lBEj6BEiXlMCrUHx_3pTTrsAEW9rIl7H6Fqng8_1759755348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 6 Oct 2025 at 14:45, Thierry Herbelot
<thierry.herbelot@6wind.com> wrote:
>
> The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> compiled with -O3 (default level for all DPDK code). There is a crash
> when starting testpmd:
>
> (gdb) bt
> #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
> #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
> #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
> #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
> #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
>     at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
> #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
>     at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
> #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
> #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
>     at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
> #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
>     dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
> #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
>     at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
> #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
>     dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
> #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
> #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
> #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
> #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
>     at ../sources/lib/eal/linux/eal.c:1253
>
> The crash is linked to the use of gcc-13: uner Ubuntu-24.04 testpmd
> compiled with gcc-11 from the same DPDK tree works as expected.
>
> The perfect solution would be for someone to investigate why the
> PMD crashes. However, this depends on Maintainer availability.
>
> A less-perfect solution is to reduce the optimization level
> (like another proposal for net/qede: see Link).
>
> Note: if more regressions are seen in less-frequently used PMDs,
>       maybe we should switch the default optimization level to -O1,
>       (tree-wide) and only rise the optimization level for actively
>       maintained PMDs, which are proven to work as expected with
>       higher optimization levels.
>
> Link: http://patches.dpdk.org/project/dpdk/patch/20250909054023.3263401-1-thierry.herbelot@6wind.com/
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>

NAK.
Please RCA this rather than hiding such an issue.


-- 
David Marchand

