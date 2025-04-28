Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4509CC36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 07:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4C384021F;
	Mon, 28 Apr 2025 09:23:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EB63A40156
 for <dev@dpdk.org>; Mon, 28 Apr 2025 09:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745824981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eu3bVFDe93sdKfDTGjXW7LWU82Q0h5I6tM/+IYRgdbE=;
 b=DNWTWMWKRgaHW35RYsPXZ9X+PvRiP53629H99Bz3VcTs0Xu4cyOnlQzBYaYFSBubZIw1QR
 ujcc1wfMtjsOvl7/dOdZ1vbKDTIq/WMGouBt6/g2AP06qg4VLjpEg0Tx0p4N8ebZLLoY2/
 Mn59v173Kq6/UCVsb3ZntzCxbqao4CY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-77Hs-XB2Mx-IOWJdHAY7NA-1; Mon, 28 Apr 2025 03:22:59 -0400
X-MC-Unique: 77Hs-XB2Mx-IOWJdHAY7NA-1
X-Mimecast-MFC-AGG-ID: 77Hs-XB2Mx-IOWJdHAY7NA_1745824978
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3f7ade514c8so1228975b6e.0
 for <dev@dpdk.org>; Mon, 28 Apr 2025 00:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745824978; x=1746429778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eu3bVFDe93sdKfDTGjXW7LWU82Q0h5I6tM/+IYRgdbE=;
 b=MZ9blzkpzEquY2ClpAb1OGWoeMSoV2tNc3tQckAt5V0ucaE5eHkEIw90D6OOX+wG8x
 qUJgor5D1JFdxu0Tu608RlmzlzE7C+PtJxNYbsacRmawNGqEemJcvcU4u/SWVQe9jPOA
 PbSDXHPLkbAHgUCxYo3zdL+B9tjcRgBUbvyi3bcUPHarymn9hraZUYzPMKMId4P9+Idt
 +h81e2ZVDSvBTtPVp5L9vkZKn1nRp1DGzRciQjOpx7+hBZejx5kkZyjuzyOG5Mj6j2An
 d/vMHgs37ILOKncBjl1L59ER0PbIDel9wa4/qkmrEQZFVSYdMaizc5bJtajecLmJaxh5
 /7MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQ8sLRf8/HMNpzT1dRLPO9b5ETgfHkay/Z8uUWSxyInej3d9jvOiMG7HjIPCw4DBIi7E=@dpdk.org
X-Gm-Message-State: AOJu0YwsD925Clr/KXw2iC8yLbUxHoo1IuaGHfEyDXHK3yOxvH9V7DLV
 /+vu5LyL+kg9cZWwzllnJohbgZmLel11D0k3GRZpg7iplqjHgQ6cxYmGSxzpBExJbZbr6JbUb9l
 4FJ/qDJPkHozwmubGiFZYYtYrWuWr7m1CQjvcCvO+a0fVP3nV3LAnwhW2vSF8rU+Hs7VEdpsNPm
 yg3VGaVcoOjCa+MBU=
X-Gm-Gg: ASbGncvcXcKMfVJi1QIk3RFyyPo+fvXgFkm3grCFaZGtyS9oWQ4amJCPKC4j9Vcp9CG
 d9645f+d93RldeNtRUoIp2MYXbAL2HR/TjcAhoR0tBK67NMKMDIPty+eN9KShYIGWkkG3eA==
X-Received: by 2002:a05:6870:70aa:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2d9be916ac9mr4764426fac.36.1745824978371; 
 Mon, 28 Apr 2025 00:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEztjBZZbvePX7oKYtHR14lQQFCN0blAsofLk1GCO2K89KD6e6pW0Fc8MXRCEa/ixFXGhs4ptpzV3F7JIHY9cg=
X-Received: by 2002:a05:6870:70aa:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2d9be916ac9mr4764422fac.36.1745824977987; Mon, 28 Apr 2025
 00:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250421141920.622156-1-xuemingl@nvidia.com>
In-Reply-To: <20250421141920.622156-1-xuemingl@nvidia.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 28 Apr 2025 15:22:45 +0800
X-Gm-Features: ATxdqUFXd5pvb054lQkVIR14TI4HsDyHxjn22xYyZgk001NJ7w5IJarC8V2iQA0
Message-ID: <CAGYh1E8wgoQQG4L44dGh-8rHsb1892XREzcSPh7dTH6kTuT65w@mail.gmail.com>
Subject: Re: 23.11.4 patches review and test
To: Xueming Li <xuemingl@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Ian Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, 
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, 
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 benjamin.walker@intel.com, 
 qian.q.xu@intel.com, yuan.peng@intel.com, zhaoyan.chen@intel.com, 
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6b9zXX31RDMN9XrV7woCqaGLsEnz6Rfx22eT_5jOCaM_1745824978
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a7404f0633d18d81"
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

--000000000000a7404f0633d18d81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xueming,

Sorry for the late reply as I was off for a few days last week.

I tested below 18 scenarios on RHEL 9.4 hosts and didn't find any new dpdk
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

   - qemu-kvm-8.2.0
   - kernel 5.14
   - libvirt 10.0
   - ovs 3.3
   - git log

commit c4b6f6ff54c32e922971e1403f19aba9ea614896

Author: Xueming Li <xuemingl@nvidia.com>

Date: Tue Apr 22 15:38:01 2025 +0800

version: 23.11.4-rc5

Signed-off-by: Xueming Li <xuemingl@nvidia.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
Yanghang Liu


On Mon, Apr 21, 2025 at 10:19=E2=80=AFPM Xueming Li <xuemingl@nvidia.com> w=
rote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.4.
>
> The planned date for the final release is 25th April.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.4-rc4
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---
> Aleksandr Loktionov (2):
>       net/igc/base: fix MAC address hash bit shift
>       net/e1000/base: fix MAC address hash bit shift
>
> Alex Vesker (1):
>       net/mlx5/hws: fix DV FT type convert
>
> Alexander Kozyrev (1):
>       net/mlx5/hws: fix fragmented packet type matching
>
> Amir Avivi (2):
>       net/igc/base: fix iterator type
>       net/e1000/base: fix iterator type
>
> Anatoly Burakov (3):
>       net/e1000/base: correct mPHY access logic
>       net/e1000: fix crashes in secondary processes
>       net/ixgbe: fix crashes in secondary processes
>
> Andre Muezerie (6):
>       eal/x86: fix some intrinsics header include for Windows
>       eventdev: fix format string data type in log messages
>       net/bnxt: fix indication of allocation
>       common/idpf: fix void function returning a value
>       net/intel: fix void functions returning a value
>       stack: fix pop in C11 implementation
>
> Andrew Boyer (1):
>       doc: update ionic driver guide
>
> Ariel Otilibili (7):
>       net/sfc: remove unnecessary assignment
>       net/octeon_ep: remove useless assignment
>       net/enetfec: remove useless assignment
>       buildtools: fix some Python regex syntax warnings
>       use Python raw string notation
>       eal/linux: remove useless assignments
>       mempool: fix errno in empty create
>
> Arkadiusz Kusztal (2):
>       test/crypto: fix check for OOP header data
>       crypto/qat: fix SM3 state size
>
> Barbara Skobiej (3):
>       net/igc/base: fix data type in MAC hash
>       net/e1000/base: fix data type in MAC hash
>       net/e1000/base: fix reset for 82580
>
> Bruce Richardson (6):
>       net/iavf: remove reset of Tx prepare function pointer
>       net/intel: fix build with icx
>       test/dma: fix pointers in IOVA as PA mode
>       net/iavf: check interrupt registration failure
>       net/iavf: fix crash on app exit on FreeBSD
>       eal: fix undetected NUMA nodes
>
> Carolyn Wyborny (1):
>       net/e1000/base: skip management check for 82575
>
> Chengwen Feng (2):
>       app/testpmd: show all DCB priority TC map
>       app/testpmd: avoid crash in DCB config
>
> David Marchand (2):
>       ci: build with MSVC in GHA
>       net/mlx5: fix leak in HWS flow counter action
>
> Dengdui Huang (3):
>       net/hns3: fix mbuf freeing in simple Tx path
>       net/hns3: fix copper port initialization
>       net/hns3: fix reset timeout
>
> Dima Ruinskiy (5):
>       net/igc/base: fix deadlock when writing i225 register
>       net/igc/base: fix infinite loop
>       net/igc/base: fix typo in LTR calculation
>       net/igc/base: fix unused value
>       net/e1000/base: fix unchecked return
>
> Gavin Hu (1):
>       net/mlx5: fix polling CQEs
>
> Gowrishankar Muthukrishnan (5):
>       crypto/virtio: fix data queues iteration
>       vhost/crypto: skip fetch before vring init
>       examples/vhost_crypto: fix user callbacks
>       crypto/cnxk: fix asymmetric operation status code
>       crypto/openssl: validate incorrect RSA signature
>
> Gregory Etelson (1):
>       net/mlx5: fix IPIP tunnel verification
>
> Huisong Li (1):
>       ethdev: fix functions available in new device event
>
> Jakub Buchocki (1):
>       net/e1000/base: fix uninitialized variable
>
> Jianping Zhao (1):
>       vhost: clear ring addresses when getting vring base
>
> Jie Hai (2):
>       net/hns3: remove PVID info dump for VF
>       net/hns3: rename RAS module
>
> Junfeng Guo (1):
>       net/mlx5: fix actions translation error overwrite
>
> Kevin Traynor (1):
>       vhost: add null callback checks
>
> Konstantin Ananyev (2):
>       test/ring: fix init with custom number of lcores
>       gro: fix unprocessed IPv4 packets
>
> Long Li (3):
>       net/netvsc: scan all net devices under the PCI device
>       net/netvsc: remove device if its net devices removed
>       net/mana: fix multi-process tracking
>
> Long Wu (2):
>       net/bonding: fix dedicated queue setup
>       net/nfp: fix VF link speed problem
>
> Maayan Kashani (8):
>       net/mlx5: adjust actions per rule limitation
>       net/mlx5: fix flush of non-template flow rules
>       net/mlx5: fix GRE flow match with SWS
>       net/mlx5: fix hairpin queue release
>       net/mlx5: fix LACP packet handling in isolated mode
>       net/mlx5/hws: fix crash using represented port without ID
>       net/mlx5/hws: fix GTP flags matching
>       net/mlx5: fix GRE matching on root table
>
> Matthew Smith (1):
>       net/ice: fix dropped packets when using VRRP
>
> Maxime Coquelin (2):
>       vhost: fix log when setting max queue num
>       vhost: reset packets count when not ready
>
> Minggang Li (Gavin) (1):
>       net/mlx5: fix Netlink socket leak
>
> Mingjin Ye (1):
>       net/ixgbe: fix minimum Rx/Tx descriptors
>
> Nawal Kishor (1):
>       common/cnxk: fix atomic load in batch ops
>
> Nicolas Chautru (1):
>       test/bbdev: update FFT test vectors
>
> Nithin Dabilpuram (1):
>       common/cnxk: fix inbound IPsec SA setup
>
> Nithinsen Kaithakadan (1):
>       examples/ipsec-secgw: fix IV length in CTR 192/256
>
> Pawel Malinowski (2):
>       net/igc/base: fix semaphore timeout value
>       net/e1000/base: fix semaphore timeout value
>
> Peng Zhang (1):
>       net/nfp: fix multi-PF control flag
>
> Praveen Kaligineedi (1):
>       net/gve: allocate Rx QPL pages using malloc
>
> Przemyslaw Ciesielski (4):
>       net/igc/base: fix bitwise operation type
>       net/igc/base: fix NVM data type in bit shift
>       net/e1000/base: fix bitwise operation type
>       net/e1000/base: fix NVM data type in bit shift
>
> Rahul Bhansali (1):
>       net/cnxk: fix NIX send header L3 type
>
> Rajesh Mudimadugula (1):
>       crypto/virtio: fix redundant queue free
>
> Sangtani Parag Satishbhai (1):
>       net/bnxt: fix crash when representor is re-attached
>
> Sasha Neftin (3):
>       net/igc/base: increase PHY power up delay
>       net/igc/base: reset loop variable
>       net/igc/base: fix LTR for i225
>
> Shani Peretz (1):
>       bus/pci: fix registered device name
>
> Shaokai Zhang (2):
>       test/crypto: fix AES-ECB test lengths
>       test/crypto: remove unused variable
>
> Shijith Thotton (1):
>       test/event: fix number of queues in eventdev conf
>
> Stephen Hemminger (21):
>       crypto/cnxk: fix build with GCC 15
>       net/thunderx/base: fix build with GCC 15
>       test/bonding: fix active backup receive test
>       build: force GCC 15 to initialize padding bits
>       net/cpfl: fix representor parsing log
>       raw/cnxk_gpio: fix file descriptor leak
>       eal: fix devargs layers parsing out of bounds
>       net/qede: fix debug messages array
>       net/hinic: fix flow type bitmask overflow
>       crypto/dpaa2_sec: fix bitmask truncation
>       crypto/dpaa_sec: fix bitmask truncation
>       event/dpaa: fix bitmask truncation
>       net/dpaa: fix bitmask truncation
>       net/dpaa2: fix bitmask truncation
>       net/qede: fix nested loops
>       examples/l3fwd: fix socket ID check
>       common/cnxk: fix null check
>       doc: fix feature flags for queue start/stop
>       app/testpmd: fix out-of-bound reference in offload config
>       pdump: clear statistics when enabled
>       examples/ptpclient: fix message parsing
>
> Tejasree Kondoj (1):
>       examples/ipsec-secgw: fix cryptodev and eventdev IDs
>
> Tudor Cornea (1):
>       net/af_packet: fix socket close on device stop
>
> Vamsi Attunuru (1):
>       common/cnxk: fix DPI mailbox structure
>
> Viacheslav Ovsiienko (1):
>       net/mlx5: fix hardware packet type translation
>
> Vladimir Medvedkin (3):
>       net/ice: fix memory leak in scalar Rx
>       net/ice: fix flows handling
>       net/ice: fix flow engines order
>
> Wathsala Vithanage (1):
>       crypto/openssl: fix CMAC auth context update
>
> Xueming Li (3):
>       fix ptp
>       test/crypto: fix backport merge
>       update version to v23.11.4
>
> Yang Ming (2):
>       eal/linux: fix memseg length in legacy mem init
>       net/iavf: fix mbuf release in Arm multi-process
>
> Yunjian Wang (2):
>       vhost: check GSO size validity
>       vhost: check descriptor chains length
>
> Zaiyu Wang (1):
>       net/txgbe: remove useless condition for SW-FW sync
>
> Zerun Fu (2):
>       net/nfp: fix multiple PFs check from NSP
>       net/nfp: fix misuse of function return values
>
>

--000000000000a7404f0633d18d81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Xueming,</div><div><br></div><div>Sorry for t=
he late reply as I was off for a few days last week.</div><div><br></div><d=
iv><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"arial, s=
ans-serif">I tested below 18 scenarios on RHEL 9.4 hosts and didn&#39;t fin=
d any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li style=3D"margin=
-left:15px">VM with device assignment(PF) throughput testing(1G hugepage si=
ze): PASS</li><li style=3D"margin-left:15px">VM with device assignment(PF) =
throughput testing(2M hugepage size) : PASS</li><li style=3D"margin-left:15=
px">VM with device assignment(VF) throughput testing: PASS</li><li style=3D=
"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q: throughput testin=
g: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 2Q throughput tes=
ting: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 1Q - cross num=
a node throughput testing: PASS</li><li style=3D"margin-left:15px">VM with =
vhost-user 2 queues throughput testing: PASS</li><li style=3D"margin-left:1=
5px">vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect): PA=
SS</li><li style=3D"margin-left:15px">vhost-user reconnect with dpdk-client=
, qemu-server(ovs reconnect): PASS</li><li style=3D"margin-left:15px">PVP =
=C2=A0reconnect with dpdk-client, qemu-server: PASS</li><li style=3D"margin=
-left:15px">PVP 1Q live migration testing: PASS</li><li style=3D"margin-lef=
t:15px">PVP 1Q cross numa node live migration testing: PASS</li><li style=
=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live migration testing=
: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q li=
ve migration testing (2M): PASS</li><li style=3D"margin-left:15px">VM with =
ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li style=3D"margin=
-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS</li=
><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS</li><li style=
=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul></div><div><br>=
<font face=3D"arial, sans-serif">Test Versions:<br><ul><li style=3D"margin-=
left:15px">qemu-kvm-8.2.0</li><li style=3D"margin-left:15px">kernel 5.14</l=
i><li style=3D"margin-left:15px">libvirt 10.0</li><li style=3D"margin-left:=
15px">ovs 3.3</li><li style=3D"margin-left:15px">git log</li></ul></font></=
div></div></div></div></div></div><blockquote style=3D"margin:0 0 0 40px;bo=
rder:none;padding:0px"><blockquote style=3D"margin:0 0 0 40px;border:none;p=
adding:0px"><div><font face=3D"arial, sans-serif">commit c4b6f6ff54c32e9229=
71e1403f19aba9ea614896</font></div></blockquote><blockquote style=3D"margin=
:0 0 0 40px;border:none;padding:0px"><div><font face=3D"arial, sans-serif">=
Author: Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@nvid=
ia.com</a>&gt;</font></div></blockquote><blockquote style=3D"margin:0 0 0 4=
0px;border:none;padding:0px"><div><span style=3D"font-family:arial,sans-ser=
if">Date:   Tue Apr 22 15:38:01 2025 +0800</span></div></blockquote><blockq=
uote style=3D"margin:0 0 0 40px;border:none;padding:0px"><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><font face=3D"arial, sa=
ns-serif">version: 23.11.4-rc5</font></div></blockquote></blockquote><block=
quote style=3D"margin:0 0 0 40px;border:none;padding:0px"><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><font face=3D"arial, sa=
ns-serif">Signed-off-by: Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.c=
om">xuemingl@nvidia.com</a>&gt;</font></div></blockquote></blockquote></blo=
ckquote><div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"lt=
r"><div dir=3D"ltr" class=3D"gmail_signature"><font face=3D"arial, sans-ser=
if"><ul><li style=3D"margin-left:15px">Test device : X540-AT2 NIC(ixgbe, 10=
G)</li></ul></font></div></div></div><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: Yanghang Liu &lt;=
<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">yanghliu@redhat.co=
m</a>&gt;</font></div></div></div></div></div></div></div><div><br></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Best Regards,</div><div>Yanghang Liu<br></div><=
/div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 21, 2025 at 10:19=E2=
=80=AFPM Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@nvi=
dia.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 23.11.4.<br>
<br>
The planned date for the final release is 25th April.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.=
11.4-rc4" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv23.11.4-rc4</a><br>
<br>
These patches are located at branch 23.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com" target=3D"_blank">xue=
mingl@nvidia.com</a>&gt;<br>
<br>
---<br>
Aleksandr Loktionov (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix MAC address hash bit shift<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix MAC address hash bit shift<br>
<br>
Alex Vesker (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix DV FT type convert<br>
<br>
Alexander Kozyrev (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix fragmented packet type matching<br>
<br>
Amir Avivi (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix iterator type<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix iterator type<br>
<br>
Anatoly Burakov (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: correct mPHY access logic<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix crashes in secondary processes<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix crashes in secondary processes<br>
<br>
Andre Muezerie (6):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: fix some intrinsics header include for Window=
s<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: fix format string data type in log messages<=
br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix indication of allocation<br>
=C2=A0 =C2=A0 =C2=A0 common/idpf: fix void function returning a value<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix void functions returning a value<br>
=C2=A0 =C2=A0 =C2=A0 stack: fix pop in C11 implementation<br>
<br>
Andrew Boyer (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: update ionic driver guide<br>
<br>
Ariel Otilibili (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/sfc: remove unnecessary assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: remove useless assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: remove useless assignment<br>
=C2=A0 =C2=A0 =C2=A0 buildtools: fix some Python regex syntax warnings<br>
=C2=A0 =C2=A0 =C2=A0 use Python raw string notation<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: remove useless assignments<br>
=C2=A0 =C2=A0 =C2=A0 mempool: fix errno in empty create<br>
<br>
Arkadiusz Kusztal (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix check for OOP header data<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix SM3 state size<br>
<br>
Barbara Skobiej (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix data type in MAC hash<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix data type in MAC hash<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix reset for 82580<br>
<br>
Bruce Richardson (6):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: remove reset of Tx prepare function pointer<=
br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix build with icx<br>
=C2=A0 =C2=A0 =C2=A0 test/dma: fix pointers in IOVA as PA mode<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: check interrupt registration failure<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix crash on app exit on FreeBSD<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix undetected NUMA nodes<br>
<br>
Carolyn Wyborny (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: skip management check for 82575<br>
<br>
Chengwen Feng (2):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: show all DCB priority TC map<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: avoid crash in DCB config<br>
<br>
David Marchand (2):<br>
=C2=A0 =C2=A0 =C2=A0 ci: build with MSVC in GHA<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak in HWS flow counter action<br>
<br>
Dengdui Huang (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix mbuf freeing in simple Tx path<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix copper port initialization<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix reset timeout<br>
<br>
Dima Ruinskiy (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix deadlock when writing i225 register<=
br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix infinite loop<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix typo in LTR calculation<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix unused value<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix unchecked return<br>
<br>
Gavin Hu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix polling CQEs<br>
<br>
Gowrishankar Muthukrishnan (5):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix data queues iteration<br>
=C2=A0 =C2=A0 =C2=A0 vhost/crypto: skip fetch before vring init<br>
=C2=A0 =C2=A0 =C2=A0 examples/vhost_crypto: fix user callbacks<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix asymmetric operation status code<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: validate incorrect RSA signature<br>
<br>
Gregory Etelson (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix IPIP tunnel verification<br>
<br>
Huisong Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix functions available in new device event<br=
>
<br>
Jakub Buchocki (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix uninitialized variable<br>
<br>
Jianping Zhao (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: clear ring addresses when getting vring base<br=
>
<br>
Jie Hai (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: remove PVID info dump for VF<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: rename RAS module<br>
<br>
Junfeng Guo (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix actions translation error overwrite<br>
<br>
Kevin Traynor (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: add null callback checks<br>
<br>
Konstantin Ananyev (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/ring: fix init with custom number of lcores<br>
=C2=A0 =C2=A0 =C2=A0 gro: fix unprocessed IPv4 packets<br>
<br>
Long Li (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: scan all net devices under the PCI device<=
br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: remove device if its net devices removed<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mana: fix multi-process tracking<br>
<br>
Long Wu (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix dedicated queue setup<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix VF link speed problem<br>
<br>
Maayan Kashani (8):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: adjust actions per rule limitation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flush of non-template flow rules<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE flow match with SWS<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hairpin queue release<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix LACP packet handling in isolated mode<br=
>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix crash using represented port without=
 ID<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix GTP flags matching<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE matching on root table<br>
<br>
Matthew Smith (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix dropped packets when using VRRP<br>
<br>
Maxime Coquelin (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix log when setting max queue num<br>
=C2=A0 =C2=A0 =C2=A0 vhost: reset packets count when not ready<br>
<br>
Minggang Li (Gavin) (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Netlink socket leak<br>
<br>
Mingjin Ye (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix minimum Rx/Tx descriptors<br>
<br>
Nawal Kishor (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix atomic load in batch ops<br>
<br>
Nicolas Chautru (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/bbdev: update FFT test vectors<br>
<br>
Nithin Dabilpuram (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix inbound IPsec SA setup<br>
<br>
Nithinsen Kaithakadan (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix IV length in CTR 192/256<br>
<br>
Pawel Malinowski (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix semaphore timeout value<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix semaphore timeout value<br>
<br>
Peng Zhang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix multi-PF control flag<br>
<br>
Praveen Kaligineedi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: allocate Rx QPL pages using malloc<br>
<br>
Przemyslaw Ciesielski (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix bitwise operation type<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix NVM data type in bit shift<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix bitwise operation type<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix NVM data type in bit shift<br>
<br>
Rahul Bhansali (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix NIX send header L3 type<br>
<br>
Rajesh Mudimadugula (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix redundant queue free<br>
<br>
Sangtani Parag Satishbhai (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix crash when representor is re-attached<br=
>
<br>
Sasha Neftin (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: increase PHY power up delay<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: reset loop variable<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix LTR for i225<br>
<br>
Shani Peretz (1):<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci: fix registered device name<br>
<br>
Shaokai Zhang (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix AES-ECB test lengths<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: remove unused variable<br>
<br>
Shijith Thotton (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/event: fix number of queues in eventdev conf<br>
<br>
Stephen Hemminger (21):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix build with GCC 15<br>
=C2=A0 =C2=A0 =C2=A0 net/thunderx/base: fix build with GCC 15<br>
=C2=A0 =C2=A0 =C2=A0 test/bonding: fix active backup receive test<br>
=C2=A0 =C2=A0 =C2=A0 build: force GCC 15 to initialize padding bits<br>
=C2=A0 =C2=A0 =C2=A0 net/cpfl: fix representor parsing log<br>
=C2=A0 =C2=A0 =C2=A0 raw/cnxk_gpio: fix file descriptor leak<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix devargs layers parsing out of bounds<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix debug messages array<br>
=C2=A0 =C2=A0 =C2=A0 net/hinic: fix flow type bitmask overflow<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa2_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 event/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix nested loops<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd: fix socket ID check<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null check<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature flags for queue start/stop<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix out-of-bound reference in offload con=
fig<br>
=C2=A0 =C2=A0 =C2=A0 pdump: clear statistics when enabled<br>
=C2=A0 =C2=A0 =C2=A0 examples/ptpclient: fix message parsing<br>
<br>
Tejasree Kondoj (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix cryptodev and eventdev IDs<b=
r>
<br>
Tudor Cornea (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_packet: fix socket close on device stop<br>
<br>
Vamsi Attunuru (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix DPI mailbox structure<br>
<br>
Viacheslav Ovsiienko (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hardware packet type translation<br>
<br>
Vladimir Medvedkin (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix memory leak in scalar Rx<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flows handling<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flow engines order<br>
<br>
Wathsala Vithanage (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: fix CMAC auth context update<br>
<br>
Xueming Li (3):<br>
=C2=A0 =C2=A0 =C2=A0 fix ptp<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix backport merge<br>
=C2=A0 =C2=A0 =C2=A0 update version to v23.11.4<br>
<br>
Yang Ming (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: fix memseg length in legacy mem init<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix mbuf release in Arm multi-process<br>
<br>
Yunjian Wang (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: check GSO size validity<br>
=C2=A0 =C2=A0 =C2=A0 vhost: check descriptor chains length<br>
<br>
Zaiyu Wang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: remove useless condition for SW-FW sync<br>
<br>
Zerun Fu (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix multiple PFs check from NSP<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix misuse of function return values<br>
<br>
</blockquote></div>

--000000000000a7404f0633d18d81--

