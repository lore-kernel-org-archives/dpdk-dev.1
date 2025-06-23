Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F65C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 16:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71B88402A1;
	Mon, 23 Jun 2025 18:01:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F9DC40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 18:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750694478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUEy3GhbAJhG3BTmqheAuEY/5/hQJrUCz8S1GjncTR4=;
 b=V2ocYZDuignGTFuyjE58sT6YgPwcemgkJXF+Od8pe6EtJIqTN7NOmbTDxW+zqEorIhfWOd
 fu2O30GkD+OVhkSGbWFaaNMlDHeYOR2eqzwI+5bFlXcoIPk40565wYgF3zkRaH6pRQFunH
 t62zPvi3ryN+NGSOr8DtaxwjyzSqstM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-q7loR0tXNrmI6Ru8F0SBGg-1; Mon, 23 Jun 2025 12:01:16 -0400
X-MC-Unique: q7loR0tXNrmI6Ru8F0SBGg-1
X-Mimecast-MFC-AGG-ID: q7loR0tXNrmI6Ru8F0SBGg_1750694475
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553c6367ec1so2049136e87.1
 for <dev@dpdk.org>; Mon, 23 Jun 2025 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750694475; x=1751299275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUEy3GhbAJhG3BTmqheAuEY/5/hQJrUCz8S1GjncTR4=;
 b=CslNItxsT9EZmZFO4tQjnoMe3VeNzPdJ134A4k9qrWMhjk3nka8QDHMqhR98X6Q4yQ
 nnG43dP9ohhiaz6+0WbQiOLdITQHGzy+A1OPJOeukzEVo3+VWsc08V1+wjQp4ApjDFS3
 T2ULuL7OPUzdqqYfogdrlnbnKWtsH7bzLNQoy3InyaMhpp4nmupNyeEb9Jiwr2SOIsBZ
 XwHRyOrfFQAOQbGgEnD2WPLCslQ6+It+BAtYkYr6oIkG1W2mWxEp2G+w6Q0LI1RHcwAF
 NdEj6GII5LkqerENcqxyKaR8bGIiZgdEJv5TIl+LBUN08d1CLfxDBz8d3gvBapEncRLa
 CWrA==
X-Gm-Message-State: AOJu0YwMvo0NEQ17IUOMvORWsx0XN1nY8xsMhfhTI4kHE2o2Zt3BnEGC
 cXnquZf4KcQI0DQTYnogCGazII6C/Lsz5gYuo6oYqpNZNpt+W20ejrHMq1kfsAQsrX3OE59y3s9
 cBNqhJN4LwKpnmrO0BNVqjcJ6Jha2/0Y5OjLmWiGq7Q/C+S/J2AXw8xZ3/yeSftx3MafQGcFBxl
 sr4dfGCBN3WRTXIKrpBIU=
X-Gm-Gg: ASbGncvhlyeqU9TBre7mU3beV2dd4V3n1NywVJaKRHl08hUGQwz432uQ8RRWCHLzTfH
 AnfFqmxJMPOrnO4ubyBeUC5tj7TBmha/4r2IsETwT84TbASoRaMaXSUydoXfqEDUSjEFFEjBC6J
 XQDasM4w==
X-Received: by 2002:a05:6512:2312:b0:553:5135:69fb with SMTP id
 2adb3069b0e04-553e3b9a61amr4031644e87.10.1750694474140; 
 Mon, 23 Jun 2025 09:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo22la11bRNSvNoKA+GrAG2cc3yHEMdzwMadYigZqlYdemHv5k5mSMIQvmQcP3BZBKcegOFo77h8FCNcjPXv0=
X-Received: by 2002:a05:6512:2312:b0:553:5135:69fb with SMTP id
 2adb3069b0e04-553e3b9a61amr4031484e87.10.1750694472125; Mon, 23 Jun 2025
 09:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
In-Reply-To: <20250527152913.279011-2-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 18:01:00 +0200
X-Gm-Features: AX0GCFtu8cEXfyUpBH_RVHII-ZF5YEBPESjfoco5gz6i_7ENrsCIppq5Gh77Cvs
Message-ID: <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0RCZwjTJr5ByhLeuaTCRIsdRsNbiLWJucKwH6jVVqSQ_1750694475
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

On Tue, May 27, 2025 at 5:29=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/eventdevs/dlb2.rst                |  6 +++---
>  doc/guides/faq/faq.rst                       |  8 +++-----
>  doc/guides/linux_gsg/build_sample_apps.rst   |  7 +++----
>  doc/guides/linux_gsg/eal_args.include.rst    |  8 ++------
>  doc/guides/prog_guide/meson_ut.rst           |  2 +-
>  doc/guides/prog_guide/multi_proc_support.rst |  2 +-
>  doc/guides/prog_guide/service_cores.rst      |  8 ++++----
>  doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
>  doc/guides/sample_app_ug/ip_frag.rst         |  7 +------
>  doc/guides/sample_app_ug/ip_reassembly.rst   |  7 +------
>  doc/guides/sample_app_ug/multi_process.rst   | 14 +++++---------
>  doc/guides/sample_app_ug/qos_scheduler.rst   |  2 +-
>  doc/guides/sample_app_ug/test_pipeline.rst   |  2 +-
>  doc/guides/tools/testbbdev.rst               |  2 +-
>  lib/eal/common/eal_common_options.c          |  6 ++++++
>  15 files changed, 43 insertions(+), 48 deletions(-)

This patch will need some rebase.

I see you fixed a few docs, but there are quite some misses in
copy/pasted blocks:

doc/guides/bbdevs/acc100.rst:  ./test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v
./ldpc_dec_default.data
doc/guides/bbdevs/fpga_5gnr_fec.rst:  ./test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v
./ldpc_dec_default.data
doc/guides/bbdevs/fpga_5gnr_fec.rst:  ./test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v
./ldpc_dec_default.data
doc/guides/bbdevs/fpga_lte_fec.rst:  ./test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v
./turbo_dec_default.data
doc/guides/bbdevs/vrb1.rst:   test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v
./ldpc_dec_default.data
doc/guides/bbdevs/vrb2.rst:   test-bbdev.py -e=3D"-c 0xff0
-a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v
./ldpc_dec_default.data

doc/guides/cryptodevs/mlx5.rst:      dpdk-test -c 1 -n 1 -w
<dev>,class=3Dcrypto,wcs_file=3D<file_path>
doc/guides/cryptodevs/mlx5.rst:      dpdk-test -c 1 -n 1 -w <dev>,class=3Dc=
rypto
doc/guides/cryptodevs/octeontx.rst:        ./build/ipsec-secgw
--log-level=3D8 -c 0xff -- -P -p 0x3 -u 0x2 --config

doc/guides/howto/packet_capture_framework.rst:     sudo
<build_dir>/app/dpdk-testpmd -c 0xf0 -n 4 -- -i
--port-topology=3Dchained

doc/guides/mempool/cnxk.rst:     echo "mempool_autotest" |
<build_dir>/app/test/dpdk-test -c 0xf0
--mbuf-pool-ops-name=3D"cn10k_mempool_ops"
doc/guides/mempool/octeontx.rst:    ./<build_dir>/app/test/dpdk-test
-c 0xf --base-virtaddr=3D0x100000000000 \

doc/guides/nics/cnxk.rst:      ./<build_dir>/app/dpdk-testpmd -c 0xc
-a 0002:02:00.0 -- --portmask=3D0x1 --nb-cores=3D1 --port-topology=3Dloop
--rxq=3D1 --txq=3D1
doc/guides/nics/cnxk.rst:   ./dpdk-testpmd -c 3 -w
0002:02:00.0,switch_header=3Dexdsa -- -i \
doc/guides/nics/cpfl.rst:      dpdk-testpmd -c 0x3 -n 4 -a
0000:af:00.6,vport=3D[0-1],flow_parser=3D"refpkg.json" -- -i
doc/guides/nics/dpaa.rst:      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 1 =
\
doc/guides/nics/dpaa2.rst:      ./dpdk-testpmd -c 0xff -n 1 -- -i
--portmask=3D0x3 --nb-cores=3D1 --no-flush-rx
doc/guides/nics/dpaa2.rst:      ./dpdk-testpmd  -c 0xf -n 1 -- -i
--portmask 0x3 --nb-cores=3D1 --txq=3D4 --rxq=3D4
doc/guides/nics/fail_safe.rst:      ./<build_dir>/app/dpdk-testpmd -c
0xff -n 4 \
doc/guides/nics/fail_safe.rst:      ./<build_dir>/app/dpdk-testpmd -c
0xff -n 4 \
doc/guides/nics/fail_safe.rst:      ./<build_dir>/app/dpdk-testpmd -c
0xff -n 4 -a ff:ff.f \
doc/guides/nics/fail_safe.rst:      ./<build_dir>/app/dpdk-testpmd -c
0xff -n 4 \
doc/guides/nics/ice.rst:    dpdk-testpmd -c 0xff -- -i
doc/guides/nics/ice.rst:    dpdk-testpmd -c 0xff -- -i
doc/guides/nics/ice.rst:   examples/dpdk-ptpclient -c f -n 3 -a
0000:ec:00.1 --force-max-simd-bitwidth=3D64 -- -T 1 -p 0x1 -c 1
doc/guides/nics/mvneta.rst:    -c 3 -- -i --p 3 -a
doc/guides/nics/mvneta.rst:   ./dpdk-testpmd
--vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -c 3 -- \
doc/guides/nics/mvneta.rst:   ./dpdk-l2fwd
--vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -c 3 -- -T 1 -p 3
doc/guides/nics/mvpp2.rst:   ./dpdk-testpmd
--vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -c 7 -- \
doc/guides/nics/mvpp2.rst:     -c 7 -- -i -a --disable-hw-vlan-strip
--rxq=3D3 --txq=3D3
doc/guides/nics/mvpp2.rst:   ./dpdk-testpmd
--vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -c 3 -- -i --p 3 -a
--disable-hw-vlan-strip
doc/guides/nics/mvpp2.rst:              ./dpdk-testpmd
--vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -c 6 -- -i -p 3 -a --txd 1024
--rxd 1024
doc/guides/nics/mvpp2.rst:              ./dpdk-testpmd
--vdev=3Dnet_mrvl,iface=3Deth0,iface=3Deth2,cfg=3D./qos_config -c 7 -- \
doc/guides/nics/octeontx.rst:      ./<build_dir>/app/dpdk-testpmd -c 700 \
doc/guides/nics/softnic.rst:         ./dpdk-testpmd -c 0x7 -s 0x4
--vdev 'net_softnic0,firmware=3D<script
path>/firmware.cli,cpu_id=3D0,conn_port=3D8086' -- -i
doc/guides/nics/softnic.rst:        ./<build_dir>/app/dpdk-testpmd -c
0x7 -s 0x4 -n 4 \

doc/guides/sample_app_ug/bbdev_app.rst:    -c 0x38 --numa-mem=3D2,2
--file-prefix=3Dbbdev -- -e 0x10 -d 0x20
doc/guides/sample_app_ug/ip_pipeline.rst:    $
./<build_dir>/examples/dpdk-ip_pipeline -c 0x3 -- -s
examples/route_ecmp.cli
doc/guides/sample_app_ug/l2_forward_macsec.rst:       -a 0002:06:00.0
-a 0002:07:00.0 -c 0x1E -- -p 0xf                      \
doc/guides/sample_app_ug/l2_forward_macsec.rst:       -a 0002:06:00.0
-a 0002:07:00.0 -c 0x1E -- -p 0xf                      \
doc/guides/sample_app_ug/ntb.rst:    ./<build_dir>/examples/dpdk-ntb
-c 0xf -n 6 -- -i
doc/guides/sample_app_ug/packet_ordering.rst:The -c EAL CPU_COREMASK
option has to contain at least 3 CPU cores.
doc/guides/sample_app_ug/pipeline.rst:    $
./<build_dir>/examples/dpdk-pipeline -c 0x3 -- -s
examples/pipeline/examples/vxlan.cli
doc/guides/sample_app_ug/vdpa.rst:        ./dpdk-vdpa -c 0x2 -n 4
--numa-mem 1024,1024 \
doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst:multiple queues. When
run with 8 threads, that is, with the -c FF option, each thread
receives and forwards packets from 16 queues.
doc/guides/sample_app_ug/vmdq_forwarding.rst:multiple queues. When run
with 8 threads, that is, with the -c FF option, each thread receives
and forwards packets from 16 queues.

doc/guides/tools/dumpcap.rst:   # <build_dir>/app/dpdk-dumpcap -i
0000:00:03.0 -c 6 -w /tmp/sample.pcapng
doc/guides/tools/graph.rst:   ./dpdk-graph -c 0xff -a 0002:02:00.0 -a
0002:03:00.0 --
doc/guides/tools/graph.rst:   ./dpdk-graph -c 0xff -a 0002:02:00.0 -a
0002:03:00.0 --
doc/guides/tools/graph.rst:   ./dpdk-graph -c 0xff
--vdev=3Dnet_pcap0,rx_pcap=3Din_net_pcap0.pcap,tx_pcap=3Dout_net_pcap1.pcap
doc/guides/tools/graph.rst:   ./dpdk-graph -c 0xff
--vdev=3Dnet_pcap0,rx_pcap=3Din_net_pcap0.pcap,tx_pcap=3Dout_net_pcap1.pcap

doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=3Devent_sw0 --
\
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=3Devent_sw0 --
\
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f --vdev=3Devent_dsw0 -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x2 --vdev=3Devent_sw0 -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x2 --vdev=3Devent_sw0 -- \
doc/guides/tools/testeventdev.rst:   sudo build/app/dpdk-test-eventdev
-c 0xf -s 0x2 --vdev=3Devent_sw0 -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0xfff1 \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x2 \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -- \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0xfff1 \
doc/guides/tools/testeventdev.rst:   sudo
<build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x2 \
doc/guides/tools/testeventdev.rst:    sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x8 --vdev=3Devent_sw0 -- \
doc/guides/tools/testeventdev.rst:    sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x8 --vdev=3Devent_sw0 -- \
doc/guides/tools/testeventdev.rst:    sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -- \
doc/guides/tools/testeventdev.rst:    sudo
<build_dir>/app/dpdk-test-eventdev -c 0xf -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \
doc/guides/tools/testmldev.rst:   sudo <build_dir>/app/dpdk-test-mldev
-c 0xf -a <PCI_ID> -- \

Otherwise, this change looks fine to me.

Thanks Bruce.

--=20
David Marchand

