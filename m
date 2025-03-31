Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95998C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A035A40156;
	Mon, 31 Mar 2025 11:08:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6613240150
 for <dev@dpdk.org>; Mon, 31 Mar 2025 11:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743412109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbdmNgD64a7fW1ToNh7hexGasqODHky7HfNupvZ6Z5I=;
 b=aqcCC7XLPGhmfwa35JsUSA1QWlEfljDn6mZyAutQj7iHlynGh6hSC2NLJ5osKVOz+EQtLe
 FsrPS03ZsI2UThQKmVHugklW3sHhtmbmHaw9gdeGFRqcB510qTQ6ZCD3LQ3qdmYDBcZucc
 MttAJIeaODQdRwPjuNrTdk5fOBddUAY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-w_lsyLv5MgCrsfxpR_4ASw-1; Mon, 31 Mar 2025 05:08:28 -0400
X-MC-Unique: w_lsyLv5MgCrsfxpR_4ASw-1
X-Mimecast-MFC-AGG-ID: w_lsyLv5MgCrsfxpR_4ASw_1743412108
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2c2b9ab3829so3139861fac.0
 for <dev@dpdk.org>; Mon, 31 Mar 2025 02:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743412105; x=1744016905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbdmNgD64a7fW1ToNh7hexGasqODHky7HfNupvZ6Z5I=;
 b=tLSBNYl1wmr8XGiQyZooJn9aJYNQC8Sv0qh1/riJ6pdu0/0kIpbM8WQvA9WJmbU2QZ
 qF4pEkJ2Q8mxhBuOHBnXU+diTnhHMb8teaLnMd3N7oirQKHboOW6udmouCv9sWYJbIPV
 18VJx8V40JPP/Ou1Z6/XCwlYbpOPiDRBVfd4ojT4pQwIN5vICtj1E2uZtMrYfx6qsRfl
 dHzpn0k922xTwFn+RRtiRzMxH57oDesEVQStxMrKWW5pBtkl/5EuoMdDKQ3xHtgPQCIH
 ++4XHGczORjq0xrAgeRpJfU8UUlN5FvJtkWIIYJ2OjDmk1Co4hYxX/i937aw8B8f5pOL
 vjTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX+nGjgoD1MIAXT2Gx6WwQ3Ej9EOsV3s9U31YpPsR1Zqu2ToPsMzA1BBj0WMVFAkY3CNQ=@dpdk.org
X-Gm-Message-State: AOJu0YzyeQ1dxG4jjK/RUTAPMR+yb3FKqUAXbmkJhCx2M2z82x4fV3+J
 OE5rTaSH1Ef2WM8c9bCOi+nuPWM3sRxJITyrOlkx0q3rUABlwVwiqn9KNdNFftGvRfin1xq3rZX
 MU7OfZ2QgWMtxIrKU7z4rOi+9/8H4T5UH34TQlM6c8ozGlXwL5H9OO8+ZBp80HIaTp4pMUeCC5v
 hgMzuFX9h1PstPRpc=
X-Gm-Gg: ASbGncuArKQNN6f09Bsxc09AmKJQITSk8hQBZCv/xZhiHA6vp0UEV8taZGq4Yf7Xklo
 /GlEZocQnRRyHVor0OZ9EarUkoiww864cRFjhfT5TVBiiL5k0tkDP0JpBBUSBoGSVJdjOuGbi4Q
 ==
X-Received: by 2002:a05:6870:9b04:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2cbcf477387mr4517197fac.8.1743412104704; 
 Mon, 31 Mar 2025 02:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUw5CYffP/iFKdBw4mDkbpz0rCeQ39zBImmWFr/kocJWBT5FybR33cVYZgn2ApPMBb6LaBCkf7qmHKrEUlZ5g=
X-Received: by 2002:a05:6870:9b04:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2cbcf477387mr4517177fac.8.1743412104335; Mon, 31 Mar 2025
 02:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
In-Reply-To: <20250326115132.1444530-1-luca.boccassi@gmail.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 31 Mar 2025 17:08:13 +0800
X-Gm-Features: AQ5f1JoFDWsXQWq7ZCoIrD6oLAjT3PS0XdP-gICeogY7TlIE8EMrkLVYp6Q_Lb4
Message-ID: <CAGYh1E-M+DHvhyVb0CMTL9t4yw9LE2WOvOi58yGF69J1bA=fGg@mail.gmail.com>
Subject: Re: 22.11.8 patches review and test
To: luca.boccassi@gmail.com
Cc: stable@dpdk.org, dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Ian Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, 
 John McNamara <john.mcnamara@intel.com>, Kevin Traynor <ktraynor@redhat.com>, 
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kyrq9wR1YgrI5Si1GJFF3540yiDxVHPLnBulzgC85Dk_1743412108
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002d2ded06319fc38d"
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

--0000000000002d2ded06319fc38d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 9.2 hosts and didn't find any new dpdk
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

   - qemu-kvm-7.2.0
   - kernel 5.14
   - libvirt 9.0
   - ovs 3.1
   - git log

commit 684d996a201182b5335012055df33284e753d832

Author: Luca Boccassi <luca.boccassi@gmail.com>

Date:   Wed Mar 26 11:26:26 2025 +0000

version: 22.11.8-rc1

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>


Best Regards,
Yanghang Liu


On Wed, Mar 26, 2025 at 7:51=E2=80=AFPM <luca.boccassi@gmail.com> wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.8.
>
> The planned date for the final release is 2025/04/10.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.11.8-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
>
> ---
> Aleksandr Loktionov (2):
>       net/igc/base: fix MAC address hash bit shift
>       net/e1000/base: fix MAC address hash bit shift
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
> Andre Muezerie (5):
>       eal/x86: fix some intrinsics header include for Windows
>       net/bnxt: fix indication of allocation
>       common/idpf: fix void function returning a value
>       net/intel: fix void functions returning a value
>       stack: fix pop in C11 implementation
>
> Andrew Boyer (1):
>       doc: update ionic driver guide
>
> Ariel Otilibili (5):
>       net/sfc: remove unnecessary assignment
>       net/enetfec: remove useless assignment
>       use Python raw string notation
>       eal/linux: remove useless assignments
>       mempool: fix errno in empty create
>
> Arkadiusz Kusztal (1):
>       test/crypto: fix check for OOP header data
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
>       net/mlx5: fix leak in HWS flow counter action
>       ci: point at GitHub mirror
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
> Ferruh Yigit (1):
>       ethdev: convert string initialization
>
> Gavin Hu (1):
>       net/mlx5: fix polling CQEs
>
> Gowrishankar Muthukrishnan (3):
>       crypto/virtio: fix data queues iteration
>       examples/vhost_crypto: fix user callbacks
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
> Konstantin Ananyev (1):
>       test/ring: fix init with custom number of lcores
>
> Long Li (3):
>       net/netvsc: scan all net devices under the PCI device
>       net/netvsc: remove device if its net devices removed
>       net/mana: fix multi-process tracking
>
> Long Wu (1):
>       net/bonding: fix dedicated queue setup
>
> Maayan Kashani (7):
>       net/mlx5: adjust actions per rule limitation
>       net/mlx5: fix flush of non-template flow rules
>       net/mlx5: fix GRE flow match with SWS
>       net/mlx5: fix LACP packet handling in isolated mode
>       net/mlx5/hws: fix crash using represented port without ID
>       net/mlx5/hws: fix GTP flags matching
>       net/mlx5: fix GRE matching on root table
>
> Matthew Smith (1):
>       net/ice: fix dropped packets when using VRRP
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
>       build: force GCC 15 to initialize padding bits
>       raw/cnxk_gpio: fix file descriptor leak
>       net/i40e: remove duplicate code
>       eal: fix devargs layers parsing out of bounds
>       net/qede: fix debug messages array
>       examples/ptpclient: fix message parsing
>       net/hinic: fix flow type bitmask overflow
>       crypto/dpaa2_sec: fix bitmask truncation
>       crypto/dpaa_sec: fix bitmask truncation
>       event/dpaa: fix bitmask truncation
>       net/dpaa: fix bitmask truncation
>       net/dpaa2: fix bitmask truncation
>       net/qede: fix nested loops
>       examples/l3fwd: fix socket ID check
>       common/cnxk: fix null check
>       test/bonding: fix active backup receive test
>       doc: fix feature flags for queue start/stop
>       app/testpmd: fix out-of-bound reference in offload config
>       pdump: clear statistics when enabled
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
> Vladimir Medvedkin (1):
>       net/ice: fix memory leak in scalar Rx
>
> Wathsala Vithanage (1):
>       crypto/openssl: fix CMAC auth context update
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
>

--0000000000002d2ded06319fc38d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.2 hosts an=
d didn&#39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li=
 style=3D"margin-left:15px">VM with device assignment(PF) throughput testin=
g(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM with device=
 assignment(PF) throughput testing(2M hugepage size) : PASS</li><li style=
=3D"margin-left:15px">VM with device assignment(VF) throughput testing: PAS=
S</li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q:=
 throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user=
 2Q throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-u=
ser 1Q - cross numa node throughput testing: PASS</li><li style=3D"margin-l=
eft:15px">VM with vhost-user 2 queues throughput testing: PASS</li><li styl=
e=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(q=
emu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconnec=
t with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"margi=
n-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><l=
i style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li st=
yle=3D"margin-left:15px">PVP 1Q cross numa node live migration testing: PAS=
S</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live mi=
gration testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+v=
host-user 1Q live migration testing (2M): PASS</li><li style=3D"margin-left=
:15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li =
style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration te=
sting: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS=
</li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul><=
/div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li st=
yle=3D"margin-left:15px">qemu-kvm-7.2.0</li><li style=3D"margin-left:15px">=
kernel 5.14</li><li style=3D"margin-left:15px">libvirt 9.0</li><li style=3D=
"margin-left:15px">ovs 3.1</li><li style=3D"margin-left:15px">git log</li><=
/ul></font></div></div></div></div></div><blockquote style=3D"margin:0 0 0 =
40px;border:none;padding:0px"><blockquote style=3D"margin:0 0 0 40px;border=
:none;padding:0px"><div><div class=3D"gmail_signature"><div><div class=3D"g=
mail_signature"><div><font face=3D"arial, sans-serif"><div>commit 684d996a2=
01182b5335012055df33284e753d832</div></font></div></div></div></div></div><=
/blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"=
><div><div class=3D"gmail_signature"><div><div class=3D"gmail_signature"><d=
iv><font face=3D"arial, sans-serif"><div>Author: Luca Boccassi &lt;<a href=
=3D"mailto:luca.boccassi@gmail.com">luca.boccassi@gmail.com</a>&gt;</div></=
font></div></div></div></div></div></blockquote><blockquote style=3D"margin=
:0 0 0 40px;border:none;padding:0px"><div><div class=3D"gmail_signature"><d=
iv><div class=3D"gmail_signature"><div><font face=3D"arial, sans-serif"><di=
v>Date: =C2=A0 Wed Mar 26 11:26:26 2025 +0000</div></font></div></div></div=
></div></div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:non=
e;padding:0px"><div><div class=3D"gmail_signature"><div><div class=3D"gmail=
_signature"><div><font face=3D"arial, sans-serif"><div>version: 22.11.8-rc1=
</div></font></div></div></div></div></div></blockquote><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div class=3D"gmail_sig=
nature"><div><div class=3D"gmail_signature"><div><font face=3D"arial, sans-=
serif"><div>Signed-off-by: Luca Boccassi &lt;<a href=3D"mailto:luca.boccass=
i@gmail.com">luca.boccassi@gmail.com</a>&gt;</div></font></div></div></div>=
</div></div></blockquote></blockquote><div><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><fon=
t face=3D"arial, sans-serif"><ul><li style=3D"margin-left:15px">Test device=
 : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div></div><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr"><div><font face=3D"arial, sans-serif">Teste=
d-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_bl=
ank">yanghliu@redhat.com</a>&gt;</font></div></div></div></div></div></div>=
<div><br></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</=
div><div>Yanghang Liu<br></div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Mar 26, 2025 at 7:51=E2=80=AFPM &lt;<a href=3D"mailto:luca.boccas=
si@gmail.com">luca.boccassi@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 22.11.8.<br>
<br>
The planned date for the final release is 2025/04/10.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.=
11.8-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv22.11.8-rc1</a><br>
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
Aleksandr Loktionov (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix MAC address hash bit shift<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix MAC address hash bit shift<br>
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
Andre Muezerie (5):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: fix some intrinsics header include for Window=
s<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix indication of allocation<br>
=C2=A0 =C2=A0 =C2=A0 common/idpf: fix void function returning a value<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix void functions returning a value<br>
=C2=A0 =C2=A0 =C2=A0 stack: fix pop in C11 implementation<br>
<br>
Andrew Boyer (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: update ionic driver guide<br>
<br>
Ariel Otilibili (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/sfc: remove unnecessary assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: remove useless assignment<br>
=C2=A0 =C2=A0 =C2=A0 use Python raw string notation<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: remove useless assignments<br>
=C2=A0 =C2=A0 =C2=A0 mempool: fix errno in empty create<br>
<br>
Arkadiusz Kusztal (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix check for OOP header data<br>
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
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak in HWS flow counter action<br>
=C2=A0 =C2=A0 =C2=A0 ci: point at GitHub mirror<br>
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
Ferruh Yigit (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: convert string initialization<br>
<br>
Gavin Hu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix polling CQEs<br>
<br>
Gowrishankar Muthukrishnan (3):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix data queues iteration<br>
=C2=A0 =C2=A0 =C2=A0 examples/vhost_crypto: fix user callbacks<br>
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
Konstantin Ananyev (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/ring: fix init with custom number of lcores<br>
<br>
Long Li (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: scan all net devices under the PCI device<=
br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: remove device if its net devices removed<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mana: fix multi-process tracking<br>
<br>
Long Wu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix dedicated queue setup<br>
<br>
Maayan Kashani (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: adjust actions per rule limitation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flush of non-template flow rules<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE flow match with SWS<br>
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
=C2=A0 =C2=A0 =C2=A0 build: force GCC 15 to initialize padding bits<br>
=C2=A0 =C2=A0 =C2=A0 raw/cnxk_gpio: fix file descriptor leak<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: remove duplicate code<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix devargs layers parsing out of bounds<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix debug messages array<br>
=C2=A0 =C2=A0 =C2=A0 examples/ptpclient: fix message parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/hinic: fix flow type bitmask overflow<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa2_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 event/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix nested loops<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd: fix socket ID check<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null check<br>
=C2=A0 =C2=A0 =C2=A0 test/bonding: fix active backup receive test<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature flags for queue start/stop<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix out-of-bound reference in offload con=
fig<br>
=C2=A0 =C2=A0 =C2=A0 pdump: clear statistics when enabled<br>
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
Vladimir Medvedkin (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix memory leak in scalar Rx<br>
<br>
Wathsala Vithanage (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: fix CMAC auth context update<br>
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
</blockquote></div>

--0000000000002d2ded06319fc38d--

