Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFBC87FCE
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 09:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AEA84064E;
	Mon, 28 Jul 2025 11:17:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3879540649
 for <dev@dpdk.org>; Mon, 28 Jul 2025 11:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753694245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQOYEwTtJ1aiBdJtGBLCsankK6qsF0rSCUahEQp9nJc=;
 b=ZBOWiQV6Kuz7nw3A4gXVw04pZtlBN5gXQHgIwETdV6HYBhgTjtRNnCe3RMRBm+Dww38e+H
 pK7mPafsdj6cYLrXs5stmhDiy3c6wYBdbhj4oFqRXTXRL96YLw6BsXNrjQ+lUlNwMAN/uw
 KZbLKb0033y+DBHZw+OEkU2pFn9FoWk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-eJYpoQVSPSGuvOREOjLSJQ-1; Mon, 28 Jul 2025 05:17:21 -0400
X-MC-Unique: eJYpoQVSPSGuvOREOjLSJQ-1
X-Mimecast-MFC-AGG-ID: eJYpoQVSPSGuvOREOjLSJQ_1753694241
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-615bfe1dd7bso3588774eaf.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 02:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753694241; x=1754299041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQOYEwTtJ1aiBdJtGBLCsankK6qsF0rSCUahEQp9nJc=;
 b=U2e00O3WdZPoPky/X3sNH7cKcmz+Mx6v0R0gW06xxq1tuukOKGuvIBaY9NPOvAL5Uy
 xPYM4slOt7peniH6xbFxp4y9vdgutWv4Z/sl0Vc2uWHQKGWhQ78JGeDvVJnk5u0ffDGR
 EpY0EOAFfeVhABRzHul+/b5wNgOvC5r01wEqVSn0gFA26llQpgucS23QCeOStiQPgybo
 bPmoIntJbzrui1EiWUFToYKFlWwL1MztrXeM34sMYVJl2R4HKYJglNn7NjwUtxJfp/Sc
 P+YKAeHoQvhLOngpIQcCnJqgbkCKwaTVyMcPKpmcWb7dSvcMjQOdzlVEHiKATL6GKzxF
 XKhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo2dyZ/8X6A4gretcdsMdpOOhYDoNxgPcWO4hw5+wgKImyDmnhvMEfsxximas8IDcI5D4=@dpdk.org
X-Gm-Message-State: AOJu0YxqjcrRkJUocl1KrreWEy2NWaDMbX+H5dT8CVOmuYJE63wFcLRv
 WaCPjcnB1ZxKIcOy2sQA7wErzn8p3FQj5SIn9PveX4s8J1Mg+E96j5Xh3CpnQebHu9qWjoJXRAd
 THfEOLS/cB+nDwlgsoRAwpgTZhAG4EvF3tfynI3kOI25QO05+UiCvndjSYdkcvsRuj6jZ4xLxnu
 mWZYq+ifAcilYuJQCOW6g=
X-Gm-Gg: ASbGnct9eQkNh5VzOp3+8bICAzsbjDf1bXPW03CA13kQd4z2/1nu/w2F2ykp4bBwK/c
 eaObWP+u68SmN1otdyHHHNiKeT7903vdhOQA8ITX2c8vVyBkXPgtvE/07kBVLIBFkjSgExEaLNA
 uE05aJTuWdHjZKQpcCAqWMVg==
X-Received: by 2002:a05:6820:2916:b0:611:e30a:fa1c with SMTP id
 006d021491bc7-6190c846470mr5837650eaf.1.1753694240894; 
 Mon, 28 Jul 2025 02:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM90a/hvzCbCfGdgS8PVhSdrteutUX9tLZ+T9Ld1KeLnE56hJcfCI05np2wIUmHEoRvpmPq21doFMqdcM3vG0=
X-Received: by 2002:a05:6820:2916:b0:611:e30a:fa1c with SMTP id
 006d021491bc7-6190c846470mr5837619eaf.1.1753694240353; Mon, 28 Jul 2025
 02:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
In-Reply-To: <20250723160822.1686060-1-luca.boccassi@gmail.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 28 Jul 2025 17:17:09 +0800
X-Gm-Features: Ac12FXznR8we8QLzA8aYURNuMcxJYzSPcxjhcQotrB6e4a6Cdg-blhFeakJzW-0
Message-ID: <CAGYh1E-x1AxkGv-PK4PoQ5Fuj5b94LSseQAzhHVVrciqqTRCig@mail.gmail.com>
Subject: Re: 22.11.9 patches review and test
To: luca.boccassi@gmail.com
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Ian Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, 
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, 
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zRpuNV7D4oJ0tv2Z1r80kgyb78W1po5hQOBSjU4ESNw_1753694241
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000003dc293063af9c275"
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

--0000000000003dc293063af9c275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk
issues.

   - VM with device assignment(PF) throughput testing(1G hugepage size):
   PASS
   - VM with device assignment(PF) throughput testing(2M hugepage size) :
   PASS
   - VM with device assignment(VF) throughput testing: PASS
   - PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
   - PVP vhost-user 2Q throughput testing: PASS
   - PVP vhost-user 1Q - cross numa node throughput testing: PASS
   - VM with vhost-user 2 queues throughput testing: PASS
   - vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect):
   PASS
   - vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PAS=
S
   - PVP  reconnect with dpdk-client, qemu-server: PASS
   - PVP 1Q live migration testing: PASS
   - PVP 1Q cross numa node live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
   - VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
   - Host PF + DPDK testing: PASS
   - Host VF + DPDK testing: PASS


Test Versions:

   - qemu-kvm-9.1.0
   - kernel 5.14
   - libvirt 10.10
   - ovs 3.3
   - git log

commit 543047abff3b5eb16d939cdc6b5d1200c7ff7f0b

Author: Luca Boccassi <luca.boccassi@gmail.com>

Date:   Wed Jul 23 17:00:10 2025 +0100

    version: 22.11.9-rc1

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
Yanghang Liu

On Thu, Jul 24, 2025 at 12:08=E2=80=AFAM <luca.boccassi@gmail.com> wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.9.
>
> The planned date for the final release is by the 25th of August 2025.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.11.9-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
>
> ---
> Amiya Ranjan Mohakud (2):
>       net/iavf: fix VLAN strip setting after enabling filter
>       net/iavf: fix VLAN strip disabling for ADQ v2 capability
>
> Anatoly Burakov (1):
>       net/ixgbe: fix indentation
>
> Ariel Otilibili (2):
>       net/af_xdp: fix use after free in zero-copy Tx
>       pcapng: fix null dereference in close
>
> Arkadiusz Kusztal (2):
>       crypto/qat: fix out-of-place header bytes in AEAD raw API
>       crypto/qat: fix out-of-place chain/cipher/auth headers
>
> Bing Zhao (2):
>       net/mlx5: fix WQE size calculation for Tx queue
>       examples/ntb: check more heap allocations
>
> Bruce Richardson (7):
>       net/fm10k/base: fix compilation warnings
>       net/ixgbe/base: correct definition of endianness macro
>       net/ixgbe/base: fix compilation warnings
>       net/i40e/base: fix unused value warnings
>       net/i40e/base: fix compiler warnings
>       test/malloc: improve resiliency
>       power/intel_uncore: fix crash closing uninitialized driver
>
> Chaoyong He (1):
>       app/testpmd: fix RSS hash key update
>
> Chengwen Feng (3):
>       app/testpmd: relax number of TCs in DCB command
>       bus: cleanup device lists
>       net/hns3: fix queue TC configuration on VF
>
> Dariusz Sosnowski (5):
>       net/mlx5: fix header modify action on group 0
>       net/mlx5: validate GTP PSC QFI width
>       net/mlx5: fix counter service cleanup on init failure
>       net/mlx5: fix VLAN stripping on hairpin queue
>       net/mlx5: fix masked indirect age action validation
>
> David Marchand (5):
>       ci: bump tested distributions in GHA
>       acl: fix build with GCC 15 on aarch64
>       eal: warn if no lcore is available
>       doc: remove reference to deprecated --use-device option
>       eal: add description of service corelist in usage
>
> Dengdui Huang (12):
>       net/hns3: fix integer overflow in interrupt unmap
>       net/hns3: fix memory leak on failure
>       net/hns3: fix extra wait for link up
>       net/hns3: fix memory leak for indirect flow action
>       net/hns3: fix interrupt rollback
>       net/hns3: fix divide by zero
>       net/hns3: fix resources release on reset
>       net/hns3: fix CRC data segment
>       mem: fix lockup on address space shortage
>       net/hns3: check requirement for hardware GRO
>       net/hns3: allow Tx vector when fast free not enabled
>       net/hns3: allow Rx vector mode with VLAN filter
>
> Dhanya Pillai (1):
>       net/i40e: fix RSS on plain IPv4
>
> Doug Foster (1):
>       config/arm: add grace build config
>
> Eugenio P=C3=A9rez (1):
>       vhost: search virtqueues driver data in read-only area
>
> Gagandeep Singh (2):
>       common/dpaax: fix PDCP key command race condition
>       common/dpaax: fix PDCP AES only 12-bit SN
>
> Gavin Li (1):
>       net/mlx5: align PF and VF/SF MAC address handling
>
> Gowrishankar Muthukrishnan (2):
>       crypto/openssl: include private exponent in RSA session
>       test/crypto: fix RSA decrypt validation
>
> Gregory Etelson (3):
>       net/mlx5: remove unsupported flow meter action in HWS
>       common/mlx5: fix extraction of auxiliary device name
>       bus/auxiliary: fix crash in cleanup
>
> Hengqi Chen (1):
>       net/virtio: fix check of threshold for Tx freeing
>
> Jake Freeland (1):
>       bus/pci/bsd: fix device existence check
>
> Jiawen Wu (13):
>       net/txgbe: fix ntuple filter parsing
>       net/txgbe: fix raw pattern match for FDIR rule
>       net/txgbe: fix packet type for FDIR filter
>       net/txgbe: fix to create FDIR filter for SCTP packet
>       net/txgbe: fix FDIR perfect mode for IPv6
>       net/txgbe: fix reserved extra FDIR headroom
>       net/txgbe: fix MAC control frame forwarding
>       net/ngbe: fix MAC control frame forwarding
>       net/txgbe: fix device statistics
>       net/ngbe: fix device statistics
>       net/txgbe: restrict VLAN strip configuration on VF
>       net/txgbe: add LRO flag in mbuf when enabled
>       net/txgbe: fix to create FDIR filter for tunnel packet
>
> Kaiwen Deng (2):
>       net/e1000: fix xstats name
>       net/e1000: fix igb Tx queue offloads capability
>
> Khadem Ullah (1):
>       net/mlx5: fix crash on age query with indirect conntrack
>
> Krzysztof Galazka (1):
>       net/i40e/base: remove unused variables
>
> Long Li (5):
>       bus/vmbus: align ring buffer data to page boundary
>       bus/vmbus: use Hyper-V page size
>       net/netvsc: use Hyper-V page size
>       net/netvsc: add stats counters from VF
>       net/mana: check vendor ID when probing RDMA device
>
> Luca Boccassi (1):
>       Revert "net/virtio: fix check of threshold for Tx freeing"
>
> Lukasz Krakowiak (2):
>       net/ice/base: fix integer overflow
>       net/ice/base: fix typo in device ID description
>
> Maayan Kashani (2):
>       ethdev: fix error struct in flow configure
>       examples/multi_process: fix ports cleanup on exit
>
> Madhuker Mythri (1):
>       net/bonding: avoid RSS RETA update in flow isolation mode
>
> Maxime Coquelin (1):
>       net/mlx5: avoid setting kernel MTU if not needed
>
> Mingjin Ye (1):
>       net/ice: fix querying RSS hash for DCF
>
> Morten Br=C3=B8rup (1):
>       eal/unix: fix log message for madvise failure
>
> Nithin Dabilpuram (1):
>       common/cnxk: fix CQ tail drop
>
> Nithinsen Kaithakadan (3):
>       common/cnxk: fix qsize in CPT iq enable
>       test/crypto: fix auth and cipher case IV length
>       test/crypto: set to null after freeing operation
>
> Oleksandr Nahnybida (1):
>       trace: fix overflow in per-lcore trace buffer
>
> Pavan Nikhilesh (1):
>       eal: fix return value of lcore role
>
> Pravin Pathak (4):
>       event/dlb2: fix dequeue with CQ depth <=3D 16
>       event/dlb2: fix validaton of LDB port COS ID arguments
>       event/dlb2: fix num single link ports for DLB2.5
>       app/eventdev: fix number of releases sent during cleanup
>
> Radu Nicolau (3):
>       crypto/virtio: add request check on request side
>       crypto/virtio: fix driver cleanup
>       crypto/qat: fix out-of-place chain/cipher/auth headers
>
> Rahul Bhansali (3):
>       net/cnxk: fix descriptor count update on reconfig
>       common/cnxk: fix null pointer checks
>       net/cnxk: fix lock for security session ops
>
> Rajesh Mudimadugula (2):
>       vhost/crypto: fix cipher data length
>       crypto/virtio: fix cipher data source length
>
> Rakesh Kudurumalla (2):
>       examples/ipsec-secgw: fix crash with IPv6
>       examples/ipsec-secgw: fix crash in event vector mode
>
> Rui Ferreira (2):
>       eal/linux: unregister alarm callback before free
>       eal/freebsd: unregister alarm callback before free
>
> Satheesh Paul (1):
>       common/cnxk: fix E-tag pattern parsing
>
> Shani Peretz (1):
>       app/crypto-perf: fix AAD offset alignment
>
> Stephen Hemminger (3):
>       net/qede: fix use after free
>       bus/fslmc: fix use after free
>       net/null: fix packet copy
>
> Sunyang Wu (1):
>       ethdev: keep promiscuous/allmulti value before disabling
>
> Thomas Monjalon (1):
>       examples/multi_process: revert ports cleanup on exit
>
> Tirthendu Sarkar (1):
>       event/dlb2: fix default credits based on HW version
>
> Viacheslav Ovsiienko (2):
>       net/mlx5: fix maximal queue size query
>       net/mlx5: fix hypervisor detection in VLAN workaround
>
> Volodymyr Fialko (1):
>       examples/ipsec-secgw: fix number of queue pairs
>
> Yan Lu (1):
>       net/tap: fix qdisc add failure handling
>
> Yang Ming (1):
>       eal/linux: improve ASLR check
>
> Yuan Wang (2):
>       net/e1000: fix EEPROM dump
>       net/ixgbe: fix port mask default value in filter
>
>

--0000000000003dc293063af9c275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.6 host and=
 didn&#39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li =
style=3D"margin-left:15px">VM with device assignment(PF) throughput testing=
(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM with device =
assignment(PF) throughput testing(2M hugepage size) : PASS</li><li style=3D=
"margin-left:15px">VM with device assignment(VF) throughput testing: PASS</=
li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q: th=
roughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 2Q=
 throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user=
 1Q - cross numa node throughput testing: PASS</li><li style=3D"margin-left=
:15px">VM with vhost-user 2 queues throughput testing: PASS</li><li style=
=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(qe=
mu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconnect=
 with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"margin=
-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><li=
 style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li sty=
le=3D"margin-left:15px">PVP 1Q cross numa node live migration testing: PASS=
</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live mig=
ration testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vh=
ost-user 1Q live migration testing (2M): PASS</li><li style=3D"margin-left:=
15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li s=
tyle=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration tes=
ting: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS<=
/li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul></=
div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li sty=
le=3D"margin-left:15px">qemu-kvm-9.1.0</li><li style=3D"margin-left:15px">k=
ernel 5.14</li><li style=3D"margin-left:15px">libvirt 10.10</li><li style=
=3D"margin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git log</l=
i></ul></font></div></div></div></div></div><blockquote style=3D"margin:0px=
 0px 0px 40px;border:none;padding:0px"><blockquote style=3D"margin:0px 0px =
0px 40px;border:none;padding:0px"><div class=3D"gmail_signature"><div class=
=3D"gmail_signature">commit 543047abff3b5eb16d939cdc6b5d1200c7ff7f0b</div><=
/div></blockquote><blockquote style=3D"margin:0px 0px 0px 40px;border:none;=
padding:0px"><div class=3D"gmail_signature"><div class=3D"gmail_signature">=
Author: Luca Boccassi &lt;<a href=3D"mailto:luca.boccassi@gmail.com">luca.b=
occassi@gmail.com</a>&gt;</div></div></blockquote><blockquote style=3D"marg=
in:0px 0px 0px 40px;border:none;padding:0px"><div class=3D"gmail_signature"=
><div class=3D"gmail_signature">Date: =C2=A0 Wed Jul 23 17:00:10 2025 +0100=
</div></div></blockquote><blockquote style=3D"margin:0px 0px 0px 40px;borde=
r:none;padding:0px"><div><div class=3D"gmail_signature"><div><div class=3D"=
gmail_signature"><div><span style=3D"font-family:arial,sans-serif">=C2=A0 =
=C2=A0=C2=A0</span>version: 22.11.9-rc1</div></div></div></div></div></bloc=
kquote><blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px=
"><div class=3D"gmail_signature"><div class=3D"gmail_signature">Signed-off-=
by: Luca Boccassi &lt;<a href=3D"mailto:luca.boccassi@gmail.com">luca.bocca=
ssi@gmail.com</a>&gt;</div></div></blockquote></blockquote><div><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"=
gmail_signature"><font face=3D"arial, sans-serif"><ul><li style=3D"margin-l=
eft:15px">Test device : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></di=
v></div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><font face=3D"ari=
al, sans-serif">Tested-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redh=
at.com" target=3D"_blank">yanghliu@redhat.com</a>&gt;</font></div></div></d=
iv></div></div></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_si=
gnature"><div dir=3D"ltr"><div>Best Regards,</div><div>Yanghang Liu</div></=
div></div></div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 24, 2025 at 12:08=E2=80=
=AFAM &lt;<a href=3D"mailto:luca.boccassi@gmail.com">luca.boccassi@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi all,<br>
<br>
Here is a list of patches targeted for stable release 22.11.9.<br>
<br>
The planned date for the final release is by the 25th of August 2025.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.=
11.9-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv22.11.9-rc1</a><br>
<br>
These patches are located at branch 22.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Luca Boccassi<br>
<br>
---<br>
Amiya Ranjan Mohakud (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix VLAN strip setting after enabling filter=
<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix VLAN strip disabling for ADQ v2 capabili=
ty<br>
<br>
Anatoly Burakov (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix indentation<br>
<br>
Ariel Otilibili (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_xdp: fix use after free in zero-copy Tx<br>
=C2=A0 =C2=A0 =C2=A0 pcapng: fix null dereference in close<br>
<br>
Arkadiusz Kusztal (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place header bytes in AEAD raw =
API<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place chain/cipher/auth headers=
<br>
<br>
Bing Zhao (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix WQE size calculation for Tx queue<br>
=C2=A0 =C2=A0 =C2=A0 examples/ntb: check more heap allocations<br>
<br>
Bruce Richardson (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: correct definition of endianness macro=
<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix unused value warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix compiler warnings<br>
=C2=A0 =C2=A0 =C2=A0 test/malloc: improve resiliency<br>
=C2=A0 =C2=A0 =C2=A0 power/intel_uncore: fix crash closing uninitialized dr=
iver<br>
<br>
Chaoyong He (1):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix RSS hash key update<br>
<br>
Chengwen Feng (3):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: relax number of TCs in DCB command<br>
=C2=A0 =C2=A0 =C2=A0 bus: cleanup device lists<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix queue TC configuration on VF<br>
<br>
Dariusz Sosnowski (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix header modify action on group 0<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: validate GTP PSC QFI width<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix counter service cleanup on init failure<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix VLAN stripping on hairpin queue<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix masked indirect age action validation<br=
>
<br>
David Marchand (5):<br>
=C2=A0 =C2=A0 =C2=A0 ci: bump tested distributions in GHA<br>
=C2=A0 =C2=A0 =C2=A0 acl: fix build with GCC 15 on aarch64<br>
=C2=A0 =C2=A0 =C2=A0 eal: warn if no lcore is available<br>
=C2=A0 =C2=A0 =C2=A0 doc: remove reference to deprecated --use-device optio=
n<br>
=C2=A0 =C2=A0 =C2=A0 eal: add description of service corelist in usage<br>
<br>
Dengdui Huang (12):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix integer overflow in interrupt unmap<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix memory leak on failure<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix extra wait for link up<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix memory leak for indirect flow action<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix interrupt rollback<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix divide by zero<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix resources release on reset<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix CRC data segment<br>
=C2=A0 =C2=A0 =C2=A0 mem: fix lockup on address space shortage<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: check requirement for hardware GRO<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: allow Tx vector when fast free not enabled<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/hns3: allow Rx vector mode with VLAN filter<br>
<br>
Dhanya Pillai (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: fix RSS on plain IPv4<br>
<br>
Doug Foster (1):<br>
=C2=A0 =C2=A0 =C2=A0 config/arm: add grace build config<br>
<br>
Eugenio P=C3=A9rez (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: search virtqueues driver data in read-only area=
<br>
<br>
Gagandeep Singh (2):<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP key command race condition<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP AES only 12-bit SN<br>
<br>
Gavin Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: align PF and VF/SF MAC address handling<br>
<br>
Gowrishankar Muthukrishnan (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: include private exponent in RSA sessio=
n<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix RSA decrypt validation<br>
<br>
Gregory Etelson (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove unsupported flow meter action in HWS<=
br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: fix extraction of auxiliary device name<b=
r>
=C2=A0 =C2=A0 =C2=A0 bus/auxiliary: fix crash in cleanup<br>
<br>
Hengqi Chen (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/virtio: fix check of threshold for Tx freeing<br>
<br>
Jake Freeland (1):<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci/bsd: fix device existence check<br>
<br>
Jiawen Wu (13):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix ntuple filter parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix raw pattern match for FDIR rule<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix packet type for FDIR filter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for SCTP packet<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR perfect mode for IPv6<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix reserved extra FDIR headroom<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: restrict VLAN strip configuration on VF<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: add LRO flag in mbuf when enabled<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for tunnel packet=
<br>
<br>
Kaiwen Deng (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix xstats name<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix igb Tx queue offloads capability<br>
<br>
Khadem Ullah (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash on age query with indirect conntra=
ck<br>
<br>
Krzysztof Galazka (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: remove unused variables<br>
<br>
Long Li (5):<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: align ring buffer data to page boundary<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: add stats counters from VF<br>
=C2=A0 =C2=A0 =C2=A0 net/mana: check vendor ID when probing RDMA device<br>
<br>
Luca Boccassi (1):<br>
=C2=A0 =C2=A0 =C2=A0 Revert &quot;net/virtio: fix check of threshold for Tx=
 freeing&quot;<br>
<br>
Lukasz Krakowiak (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix typo in device ID description<br>
<br>
Maayan Kashani (2):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix error struct in flow configure<br>
=C2=A0 =C2=A0 =C2=A0 examples/multi_process: fix ports cleanup on exit<br>
<br>
Madhuker Mythri (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: avoid RSS RETA update in flow isolation m=
ode<br>
<br>
Maxime Coquelin (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: avoid setting kernel MTU if not needed<br>
<br>
Mingjin Ye (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix querying RSS hash for DCF<br>
<br>
Morten Br=C3=B8rup (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/unix: fix log message for madvise failure<br>
<br>
Nithin Dabilpuram (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix CQ tail drop<br>
<br>
Nithinsen Kaithakadan (3):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix qsize in CPT iq enable<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix auth and cipher case IV length<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: set to null after freeing operation<br>
<br>
Oleksandr Nahnybida (1):<br>
=C2=A0 =C2=A0 =C2=A0 trace: fix overflow in per-lcore trace buffer<br>
<br>
Pavan Nikhilesh (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix return value of lcore role<br>
<br>
Pravin Pathak (4):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix dequeue with CQ depth &lt;=3D 16<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix validaton of LDB port COS ID arguments=
<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix num single link ports for DLB2.5<br>
=C2=A0 =C2=A0 =C2=A0 app/eventdev: fix number of releases sent during clean=
up<br>
<br>
Radu Nicolau (3):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: add request check on request side<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix driver cleanup<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place chain/cipher/auth headers=
<br>
<br>
Rahul Bhansali (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix descriptor count update on reconfig<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null pointer checks<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix lock for security session ops<br>
<br>
Rajesh Mudimadugula (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost/crypto: fix cipher data length<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cipher data source length<br>
<br>
Rakesh Kudurumalla (2):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash with IPv6<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash in event vector mode<b=
r>
<br>
Rui Ferreira (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: unregister alarm callback before free<br>
=C2=A0 =C2=A0 =C2=A0 eal/freebsd: unregister alarm callback before free<br>
<br>
Satheesh Paul (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix E-tag pattern parsing<br>
<br>
Shani Peretz (1):<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix AAD offset alignment<br>
<br>
Stephen Hemminger (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 bus/fslmc: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 net/null: fix packet copy<br>
<br>
Sunyang Wu (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: keep promiscuous/allmulti value before disabli=
ng<br>
<br>
Thomas Monjalon (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/multi_process: revert ports cleanup on exit<b=
r>
<br>
Tirthendu Sarkar (1):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix default credits based on HW version<br=
>
<br>
Viacheslav Ovsiienko (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix maximal queue size query<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hypervisor detection in VLAN workaround<=
br>
<br>
Volodymyr Fialko (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix number of queue pairs<br>
<br>
Yan Lu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix qdisc add failure handling<br>
<br>
Yang Ming (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: improve ASLR check<br>
<br>
Yuan Wang (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix EEPROM dump<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix port mask default value in filter<br>
<br>
</blockquote></div>

--0000000000003dc293063af9c275--

