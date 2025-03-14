Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A62C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 16:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F664029E;
	Fri, 14 Mar 2025 17:14:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CFD1940289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 17:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741968893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGvkJxgck6f/fDL651tpgGlQ5MSGhSAkKDcATVz8R0g=;
 b=ZgeAN/uc+NQo1R4RRmDozCRRUI99TmUKOVSrYH4ufaJdgQEYbFhftmlStpTGCOwrEL8Deq
 yI5/LwWQnByz4i8XEehnc1FjJzNRuviBy4oHNzaBEaBgytw0sm5WVB4ImoFOghHKNQBO72
 UjMqSgXnTvuUEokMhsxymvbMDA1cve0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Ys-d8ou4Of-WYhgrOskhXg-1; Fri, 14 Mar 2025 12:14:50 -0400
X-MC-Unique: Ys-d8ou4Of-WYhgrOskhXg-1
X-Mimecast-MFC-AGG-ID: Ys-d8ou4Of-WYhgrOskhXg_1741968889
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-542a77b4a4cso1373986e87.1
 for <dev@dpdk.org>; Fri, 14 Mar 2025 09:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968888; x=1742573688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGvkJxgck6f/fDL651tpgGlQ5MSGhSAkKDcATVz8R0g=;
 b=PKMazUTKYEyob6Oh1Pk98+qthgllxr4fQfkcdSrpC2kwXtrqLjam8ptIxINLaW1ZiR
 ljc7hJLqJeEetx4Q1FopWL/4TQQAuanM4AOB6p2BVKOhMrFZf+sLOyWXVIf/btbIrZXx
 QKd+NrzGVmjG+amQvWB2Eholny9hSbZckTeq91DvMYP97FdvUJApWxHfXFmJJn1bS4kv
 DFbc2biDwBrfSyOd6OJCvvzhjeZX1KZgLooUEQR9QM6V992kRkjts5/O6AxxMWah9Rgg
 Rkft15+RPy78NGUZId0dykrtl+zMGh0F6E7OsV4g64AOQzrKutf4OqMyT01sdLx+2K1X
 5yvQ==
X-Gm-Message-State: AOJu0Yx1oqptRn49ZMlEGUXIQr53AlXanOZ+IxNdcitgjWF/+SeTWc2T
 Sj+gcpjKqUPpySD1V9U5/PSCOBmn7/u7odDv7L+S4CEMJ9Lihq/hOdj/q8+NhFTf0MW/FbYErwt
 fZU/vu+02dLCTqrRf71MLb3gc83uoqOKxDmCIzDvUlVHQqwe0egJ7F7GLQdca7FInfsYMkxHvJ5
 pEFaq1hooc+fnMClU=
X-Gm-Gg: ASbGnctNZaglHF5N/JfVELOwDbOe6HMbUxeJ2G8dNXUlrUQKwM7w7zfWphilpdbyJqD
 yTUuKQ7gaVehO9uyrCbOTfD7Tk7TtIHq9Q2iWV/9qO5YUO/yS5rRhRkTBXpx/IGqtFlN+zKruQM
 w=
X-Received: by 2002:a05:6512:ac2:b0:545:ebf:145f with SMTP id
 2adb3069b0e04-549c3c995b1mr1065782e87.53.1741968888358; 
 Fri, 14 Mar 2025 09:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJBCVkL0Ml7ek+UketJ5NUF/s43KW6X5ZCOwWYLecITOjvFFexJIHsOEn5s6gTbdtHUzrV0LQnEMcbzDHyj3Y=
X-Received: by 2002:a05:6512:ac2:b0:545:ebf:145f with SMTP id
 2adb3069b0e04-549c3c995b1mr1065721e87.53.1741968887753; Fri, 14 Mar 2025
 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-7-david.marchand@redhat.com>
 <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9MWQR_o3m4T_rFt@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 17:14:34 +0100
X-Gm-Features: AQ5f1JoT8B5QoN4RqWRtVCiEeiVWs80jJOoQ9CIHFbXZ16npl2stUI-phTf7aeo
Message-ID: <CAJFAV8w0MPV7XQpMyiGTsSVDGuW1LctGyrXZ6n52O7AYzij7Zw@mail.gmail.com>
Subject: Re: [RFC v3 6/8] build: mark exported symbols
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com, 
 Nicolas Chautru <nicolas.chautru@intel.com>, Parav Pandit <parav@nvidia.com>, 
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, 
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Andrew Boyer <andrew.boyer@amd.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Liron Himi <lironh@marvell.com>, 
 Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>, 
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Ankur Dwivedi <adwivedi@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, 
 Gagandeep Singh <g.singh@nxp.com>, Kai Ji <kai.ji@intel.com>, 
 Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>, Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Ian Stokes <ian.stokes@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashish.gupta@marvell.com>, 
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou <zhoumin@loongson.cn>, 
 David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, 
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, 
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Jiayu Hu <hujiayu.hu@foxmail.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, 
 Gaetan Rivet <grive@u256.net>, Volodymyr Fialko <vfialko@marvell.com>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fZWNMGGZ2Ekl1lh8PVv8w20MukUUfepsqwq6L3HkBT4_1741968889
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

On Thu, Mar 13, 2025 at 6:31=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Mar 11, 2025 at 10:56:04AM +0100, David Marchand wrote:
> > Annotate symbols with newly introduced export macros.
> >
> > For code not compiled by lib/meson.build or drivers/meson.build (like A=
VX
> > separate libraries, or sources in /base/ drivers), the exported symbols
> > are added in some file listed in the sources so they get caught by
> > lib/meson.build or drivers/meson.build.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
>
> Just checking: for the AVX2 and similar instruction-set-specific function=
s,
> we don't get errors if those are not present in the actual link phase, e.=
g.
> when building on non-x86 platforms? We don't need to put an #ifdef around
> the exports?

We are not there yet, but it is likely MSVC linker will complain, indeed.

#ifdef around the exports won't work, we would need a precompiler pass
(and exclude rte_exports.h inclusion).

Another option would be to provide stubs for those symbols when the
additional AVX512 (for example) libraries are not compiled.

But I think the simpler is to let a driver/library provide a set of
sources to parse for exports... maybe via an extra variable?
WDYT?

Something like:

diff --git a/drivers/meson.build b/drivers/meson.build
index 2b0fcd4ef0..6828067fd1 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -269,7 +268,7 @@ foreach subpath:subdirs
         endif
         version_map =3D custom_target(lib_name + '_map',
                 command: [gen_version_map, link_mode,
abi_version_file, '@OUTPUT@', '@INPUT@'],
-                input: sources,
+                input: sources + exported_symbol_sources,
                 output: '_'.join(class, name, 'exports.map'))
         lk_deps =3D [version_map]
 diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 5764bd0e9b..b468e1cd57 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1647,12 +1647,3 @@ idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rx=
q)
        rxq->bufq2->ops =3D &def_rx_ops_vec;
        return idpf_rxq_vec_setup_default(rxq->bufq2);
 }
-
-/* Export all AVX* symbols */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx2)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx2)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx512)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx512)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx512)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx512)
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 43a95466ae..3ff70955c8 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -473,6 +473,7 @@ _idpf_singleq_recv_raw_pkts_vec_avx2(struct
idpf_rx_queue *rxq, struct rte_mbuf
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx2)
 uint16_t
 idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf
**rx_pkts, uint16_t nb_pkts)
 {
@@ -682,6 +683,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
*tx_queue, struct rte_mbuf **tx_pkts
        return nb_pkts;
 }

+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx2)
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
                               uint16_t nb_pkts)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index b630d1fcd9..e8bf8149e1 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -530,6 +530,7 @@ _idpf_singleq_recv_raw_pkts_avx512(struct
idpf_rx_queue *rxq,
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx512)
 uint16_t
 idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts=
,
                                 uint16_t nb_pkts)
@@ -987,6 +988,7 @@ _idpf_splitq_recv_raw_pkts_avx512(struct idpf_rx_queue =
*rxq,
 }

 /* only bufq2 can receive pkts */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx512)
 uint16_t
 idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
                             uint16_t nb_pkts)
@@ -1281,6 +1283,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void
*tx_queue, struct rte_mbuf **tx_pkts,
        return nb_tx;
 }

+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx512)
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts=
,
                                 uint16_t nb_pkts)
@@ -1584,6 +1587,7 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void
*tx_queue, struct rte_mbuf **tx_pkts,
        return nb_tx;
 }

+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx512)
 uint16_t
 idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
                                uint16_t nb_pkts)
@@ -1619,6 +1623,7 @@ static const struct idpf_txq_ops avx512_tx_vec_ops =
=3D {
        .release_mbufs =3D idpf_tx_release_mbufs_avx512,
 };

+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
 int __rte_cold
 idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
 {
diff --git a/drivers/net/intel/idpf/meson.build
b/drivers/net/intel/idpf/meson.build
index 4b272d02b1..47f6f8736e 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -25,6 +25,7 @@ if arch_subdir =3D=3D 'x86' and
dpdk_conf.get('RTE_IOVA_IN_MBUF') =3D=3D 1
         include_directories: includes,
         c_args: [cflags, cc_avx2_flags])
     objs +=3D idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
+    exported_symbol_sources +=3D files('idpf_common_rxtx_avx2.c')

     if cc_has_avx512
         cflags +=3D ['-DCC_AVX512_SUPPORT']
@@ -41,6 +42,7 @@ if arch_subdir =3D=3D 'x86' and
dpdk_conf.get('RTE_IOVA_IN_MBUF') =3D=3D 1
                 include_directories: includes,
                 c_args: avx512_args)
         objs +=3D
idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
+        exported_symbol_sources +=3D files('idpf_common_rxtx_avx512.c')
     endif
 endif



--=20
David Marchand

