Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F794CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 15:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4064D40267;
	Mon, 18 Aug 2025 17:05:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E43940262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 17:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755529547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8kmVqVi/fxhfTq/blHW8Wj4+AzjzSMTNZ1L9uMck14=;
 b=hT8hXy+4BS47OZFXq0P04KLwXntUcKNt08J767HfgChCMxn9y0rG+/+iWMuPmuTs6u+TE1
 U+iXN78lo2SFyfQNEnb987ZNDNwRuVIRN+msbkZ4TB3h4/LwiUMrirYE+GJ/X6O63O/AMm
 otXu1cos3Y0nW4LobYXjj4yFubl45dQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-J309VJ4KOsG8dhaTDKONug-1; Mon, 18 Aug 2025 11:05:46 -0400
X-MC-Unique: J309VJ4KOsG8dhaTDKONug-1
X-Mimecast-MFC-AGG-ID: J309VJ4KOsG8dhaTDKONug_1755529545
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-55ce4be890aso2180554e87.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755529544; x=1756134344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8kmVqVi/fxhfTq/blHW8Wj4+AzjzSMTNZ1L9uMck14=;
 b=iZ0Kpyeuh+3cjMBDX+AK8pKfdYs1HUOhoxIKUp4ll0RVrk4YHvZE5sophNtXwdOfn1
 6FCz9bX6sPSWYvNs+FXPfSThe/cETAaJZQmyWQfAE7Z11z9MklBDLhqCv008F085qoHh
 IIT64hq7vghfxNo50MXW+GGTDZ0LGNW53D6NF2GPXvhr/v/RwZum18wq7PtqP6X2HqHU
 f8COzIPlkkxSQVIaKm+Rt0qvNch9XYdt4kdSWi+vzn/MdPpGVMEK6nW68A2AQCU1Pjkz
 /VcX+b8AFAYFnLSnAkEEzC+iy74cQY/HBvNyftuKB9YC99tXUxf8VNgHLain07FrVZ8l
 H54w==
X-Gm-Message-State: AOJu0Yx4sNcL3mb1zYEtt7pRQOfpZeDm34D2Lr2fuZiD2uhJYMS9Wl0e
 kjjNcpdHnXfVK06Xu5Oc+GxLcejnI5/RKHG1x5W5ugaBNI4R2fF5oHaRQUjOrDs7miTjJfko9Wl
 WZADLZr/zyke3U4fFTeFC/hAajwyWsh8dlQJ1yFnynBfHksgksYU+tviGx59e7sy/itqZXNF3Xe
 GON++NulQSMBdfY6y3saw=
X-Gm-Gg: ASbGnctm3TKQjPA9k02h3UUB/3jW0Y8Ld0So/wtab02p6U7vXn2Q8VGFqP5LF7wJ81M
 xLZTrcRTo6neiHvTCbIGZFXDWCeCmaQEPzY1suxH1jTaPf3QMQYORW+AUzH2hfBaDCeQQakWi3K
 nMn0YxVm+WyOFB3oLS4m8NhDc=
X-Received: by 2002:a05:6512:ea9:b0:55c:adae:37ae with SMTP id
 2adb3069b0e04-55cee6fb115mr2742213e87.5.1755529544425; 
 Mon, 18 Aug 2025 08:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7l5UU89vrEeEumWAFpR3m6z4E94f+bYmd7Fnlg0Zhkbd0283b8gm8A1v1SKep0I6ELskieOAaNEPW2iyB9nc=
X-Received: by 2002:a05:6512:ea9:b0:55c:adae:37ae with SMTP id
 2adb3069b0e04-55cee6fb115mr2742199e87.5.1755529543963; Mon, 18 Aug 2025
 08:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250814154604.6878-1-stephen@networkplumber.org>
In-Reply-To: <20250814154604.6878-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 18 Aug 2025 17:05:32 +0200
X-Gm-Features: Ac12FXxqaVeJ-sRdqSj90LTXQT2u67POHAyaNZ1Drp3jaW8Jd8p9n-mk-Bp8-cM
Message-ID: <CAJFAV8xsF53aQBMh6S5y1P6vamhhvYCUAOe8akofzMgMoOA4Hg@mail.gmail.com>
Subject: Re: [PATCH] doc: remove KNI diagrams
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: noGHP1ANBxXXjdBRH35D5-gUrNGMA2a_qBB4wNhbkFI_1755529545
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

On Thu, Aug 14, 2025 at 5:46=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> KNI was removed from DPDK but the diagrams in the documentation
> were left behind.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/prog_guide/img/kni_traffic_flow.png | Bin 366308 -> 0 bytes
>  doc/guides/prog_guide/img/pkt_flow_kni.png     | Bin 51088 -> 0 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 doc/guides/prog_guide/img/kni_traffic_flow.png
>  delete mode 100644 doc/guides/prog_guide/img/pkt_flow_kni.png

Good catch.

Note that there are more files to remove on the KNI topic (and for
other parts of the doc).

$ for file in doc/logo/* doc/guides/*/img/*; do name=3D$(basename
$file); name=3D${name%%.*}; git grep -qw $name -- doc/ || { echo $(git
ll -n1 -S $name -- doc/) $file; }; done | sort
0d547ed037 - examples/ipsec-secgw: support configuration file (9 years
ago) <Fan Zhang> doc/guides/sample_app_ug/img/ipsec_endpoints.svg
207361b350 - examples/exception_path: remove example (6 years ago)
<Bruce Richardson>
doc/guides/sample_app_ug/img/exception_path_example.svg
428eaeb822 - doc: remove PDF requirements (4 years, 3 months ago)
<Thomas Monjalon> doc/logo/DPDK_logo_horizontal_tag.png
46971b273e - examples/quota-watermark: remove example (6 years ago)
<Ciara Power> doc/guides/sample_app_ug/img/pipeline_overview.png
46971b273e - examples/quota-watermark: remove example (6 years ago)
<Ciara Power> doc/guides/sample_app_ug/img/ring_pipeline_perf_setup.png
46971b273e - examples/quota-watermark: remove example (6 years ago)
<Ciara Power> doc/guides/sample_app_ug/img/threads_pipelines.png
59c51be41c - examples/dpdk-qat: remove app (8 years ago) <Pablo de
Lara> doc/guides/sample_app_ug/img/quickassist_block_diagram.png
6de0ea50e9 - examples/l3fwd: merge l3fwd-acl example (3 years, 2
months ago) <Sean Morrissey>
doc/guides/sample_app_ug/img/example_rules.png
aa0d7c2d32 - kni: remove KNI vhost support (8 years ago) <Ferruh
Yigit> doc/guides/prog_guide/img/kni_traffic_flow.png
aa0d7c2d32 - kni: remove KNI vhost support (8 years ago) <Ferruh
Yigit> doc/guides/prog_guide/img/vhost_net_arch.png
ab6ebd7020 - examples/load_balancer: remove example (6 years ago)
<Ciara Power> doc/guides/sample_app_ug/img/load_bal_app_arch.png
f78c100bc8 - remove KNI (2 years ago) <Stephen Hemminger>
doc/guides/nics/img/host_vm_comms.png
f78c100bc8 - remove KNI (2 years ago) <Stephen Hemminger>
doc/guides/prog_guide/img/kernel_nic_intf.png
f78c100bc8 - remove KNI (2 years ago) <Stephen Hemminger>
doc/guides/prog_guide/img/pkt_flow_kni.png
f78c100bc8 - remove KNI (2 years ago) <Stephen Hemminger>
doc/guides/sample_app_ug/img/kernel_nic.png


--=20
David Marchand

