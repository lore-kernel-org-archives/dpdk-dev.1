Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E3C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 09:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB02A402A0;
	Thu,  3 Jul 2025 11:05:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C227840287
 for <dev@dpdk.org>; Thu,  3 Jul 2025 11:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751533544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF7mxLFLt/15UE/e+PFzvpWraQfhyo5wI8n+rsWrc5I=;
 b=UpgXoRy2JNouvsHrvmj/h/9aJz/7745rICEDUmACjz64r0k3MECMY/HrLliiOoeu8kcGTX
 E4Z4oe6wgIReCizNOlI5fpSFiFBthN2TusByj2azIsPIEzVEpkPgnQk76xLFYi6vVNJZdR
 OjhB+Ttzg5r64mtc6byDUTQp3xUuFNE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-PcPRb2_YPNW3p9t2o3baOg-1; Thu, 03 Jul 2025 05:05:42 -0400
X-MC-Unique: PcPRb2_YPNW3p9t2o3baOg-1
X-Mimecast-MFC-AGG-ID: PcPRb2_YPNW3p9t2o3baOg_1751533541
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553b70a3592so3791797e87.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533541; x=1752138341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF7mxLFLt/15UE/e+PFzvpWraQfhyo5wI8n+rsWrc5I=;
 b=bI++ZrHIOwtaCAKxIPfHdL/6lzjTYBnt/OmlixceN7jnOKPTQ7tzR7iZ6g1mgCWgs/
 satPZhCD2Sm0ryB4xpyG474kj/j+aPDlZCivwnrMCuY62FhgKZSgt+B+ILhUGcVFycwC
 Fz8TO1hs35RMvR3ar1txO/pSWXQcSn21vLkl9F2CebQ0mWadayQiTnb4C8fBxnFRyUu0
 49NiJ8koGMTK4iFAe0GR7pK9J3VHdDZpcuxCYs3TG1Ua6fXt6803MqlxAdvrIShuTsnx
 J1Rht635i2QKeuFPUI5aJ4lYU+vtuSNP4G8EoZ3Itvg+YZTMgd4uIRR5vcAF3HVnbWLs
 A7qQ==
X-Gm-Message-State: AOJu0YzPjWXNfFEMefNk3tev+g4lMMmZoJ8KbZuwtqmIty14+TrmYN3A
 Me/DiMwDEmLZiXqpFmsr5IJH19x7xtI0Aj9QXwWACbxxrRnfvm8Yzrlps3E6mBzQnOSTfT/CicB
 ew9LO6WFxYrhDyISDLXonuno3IvFUkhOCVKlJ92D1z5ZLc/eBmId5lgpteYaxCYgMR8N+4RjqN1
 SomTC2PGk19BPdZpjD/E8=
X-Gm-Gg: ASbGncsci4iULQR0Fl5GO4Xs4N4h+lj+BTIfHncTJ02iYInnmirTXcDrJQBW9omPapt
 +F9Yfbf8xmvnS69Mm1PaEAE6KfoyNedR4UT2NOkIEEueK4mkvDrETFEerD3uvkJ9YVMHvEFr30s
 eZdEGZPA==
X-Received: by 2002:a05:6512:b89:b0:554:f74b:78ae with SMTP id
 2adb3069b0e04-5562eed59femr847702e87.31.1751533540931; 
 Thu, 03 Jul 2025 02:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYtcO/Mj9EZ2RuvJcFZ46pDhhsfT6GQBLt5g1PKagpTouJ8X7joP1YDbrsZzlDQYS0Ja1NgtVu/izmvq/ArbE=
X-Received: by 2002:a05:6512:b89:b0:554:f74b:78ae with SMTP id
 2adb3069b0e04-5562eed59femr847692e87.31.1751533540317; Thu, 03 Jul 2025
 02:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250624133409.550372-1-bruce.richardson@intel.com>
In-Reply-To: <20250624133409.550372-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 11:05:28 +0200
X-Gm-Features: Ac12FXzarCx8FIUZMGvY_Nox97HzgafXs-_10u2Qaoj7rVnyAkxwlUL1diHUCn8
Message-ID: <CAJFAV8zLPYDMo=wbBuYKF-oUA-kjzOMa7GmgoaX3cuMEjC7Duw@mail.gmail.com>
Subject: Re: [PATCH 0/2] use core lists not masks in documentation
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxP5_5dpNFQ20MqOKnxwYzKCgX_9VV_qUmfFPMyx5E4_1751533541
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jun 24, 2025 at 3:34=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> For real-world use with dozens if not hundreds of cores, use of core
> masks becomes unwieldy. Core lists are preferred so update the examples
> and DPDK docs to refer to core lists over core masks i.e.
>
> * use "-l" EAL option rather than "-c"
> * use "-S" service core list option rather than "-s"
>
> Bruce Richardson (2):
>   doc/eal: add doc entry for service core list flag
>   doc: use core lists rather than masks in guides
>
>  doc/guides/bbdevs/acc100.rst                  |  2 +-
>  doc/guides/bbdevs/fpga_5gnr_fec.rst           |  4 +-
>  doc/guides/bbdevs/fpga_lte_fec.rst            |  2 +-
>  doc/guides/bbdevs/vrb1.rst                    |  2 +-
>  doc/guides/bbdevs/vrb2.rst                    |  2 +-
>  doc/guides/cryptodevs/octeontx.rst            |  2 +-
>  doc/guides/eventdevs/dlb2.rst                 |  6 +--
>  doc/guides/faq/faq.rst                        |  8 ++--
>  doc/guides/freebsd_gsg/build_sample_apps.rst  |  8 ++--
>  doc/guides/howto/packet_capture_framework.rst |  2 +-
>  doc/guides/linux_gsg/build_sample_apps.rst    | 10 ++---
>  doc/guides/linux_gsg/eal_args.include.rst     |  5 +++
>  doc/guides/mempool/cnxk.rst                   |  2 +-
>  doc/guides/mempool/octeontx.rst               |  2 +-
>  doc/guides/nics/cnxk.rst                      |  2 +-
>  doc/guides/nics/cpfl.rst                      |  2 +-
>  doc/guides/nics/dpaa.rst                      |  2 +-
>  doc/guides/nics/dpaa2.rst                     |  4 +-
>  doc/guides/nics/fail_safe.rst                 |  8 ++--
>  doc/guides/nics/ice.rst                       |  4 +-
>  doc/guides/nics/softnic.rst                   |  4 +-
>  doc/guides/prog_guide/meson_ut.rst            |  2 +-
>  doc/guides/prog_guide/multi_proc_support.rst  |  2 +-
>  doc/guides/prog_guide/service_cores.rst       |  8 ++--
>  doc/guides/sample_app_ug/bbdev_app.rst        |  6 +--
>  doc/guides/sample_app_ug/ip_pipeline.rst      |  2 +-
>  doc/guides/sample_app_ug/ipsec_secgw.rst      |  4 +-
>  .../sample_app_ug/l2_forward_macsec.rst       |  4 +-
>  doc/guides/sample_app_ug/l3_forward.rst       |  2 +-
>  doc/guides/sample_app_ug/multi_process.rst    |  8 ++--
>  doc/guides/sample_app_ug/ntb.rst              |  2 +-
>  doc/guides/sample_app_ug/pipeline.rst         |  2 +-
>  doc/guides/sample_app_ug/qos_scheduler.rst    |  2 +-
>  doc/guides/sample_app_ug/test_pipeline.rst    |  2 +-
>  doc/guides/sample_app_ug/vdpa.rst             |  2 +-
>  doc/guides/tools/comp_perf.rst                |  5 +--
>  doc/guides/tools/cryptoperf.rst               |  5 +--
>  doc/guides/tools/graph.rst                    | 13 +++----
>  doc/guides/tools/testbbdev.rst                |  2 +-
>  doc/guides/tools/testeventdev.rst             | 39 +++++++++----------
>  doc/guides/tools/testmldev.rst                | 27 +++++++------
>  41 files changed, 110 insertions(+), 112 deletions(-)

Series applied, thanks Bruce.


--=20
David Marchand

