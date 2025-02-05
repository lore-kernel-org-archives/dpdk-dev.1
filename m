Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89454C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 07:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBC8740289;
	Wed,  5 Feb 2025 08:49:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1597040270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 08:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738741790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ANlnQPwBQdlQPurf/iTF4DPi2sbibf4tMPRZVoJgXs=;
 b=Cu4hUnkzDtCl97AVLMFDBU/z0lgdxcUZca0cPuMjom0BozsZ9bB7a5r9T338SzJ9HeJg7o
 SoGanvd6vjGFGIkBi2AUVXpgIQKDOJupqPeRqYsjyM8PkznqvTG+Ty73os2qTGedc/Oz3I
 D2TcEEJA/7gxLbdIsWJmhM5Ivhi5ij8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-YTfKdmMjMdSYlz5A0p1YNw-1; Wed, 05 Feb 2025 02:49:48 -0500
X-MC-Unique: YTfKdmMjMdSYlz5A0p1YNw-1
X-Mimecast-MFC-AGG-ID: YTfKdmMjMdSYlz5A0p1YNw
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-543bb2be3dcso4145371e87.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 23:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738741786; x=1739346586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ANlnQPwBQdlQPurf/iTF4DPi2sbibf4tMPRZVoJgXs=;
 b=GMGkYSfuWH9D3NRtgcDUqOmp7rlMBZwswbPCeIsyDpDtYfZJmefyCun/qHrt7sw/JS
 zl/4Zj6nlAw9eVvcZTLdautaCy38HXDZLLW+Miq/eMivSaI1fb4xR4aBimlCqbetv4HU
 zx90HSmZ3keN5gsv8q3wwen5Px1w5gOXzFF6QqQrk4hd3bjt4w7xe3AgodZEfAmmC6P1
 /IKDBBL2emUobmaA+36sNPbEx8OYFS4ZjrbdQZw5iuKpxnL3zQ0ENS2OhNSqi09oFCtT
 shS8DHHjnJNohk7s0EOMHNtFJHjax7HbeUOY7ZEjf54+9haRqOmDwH2PrLpbYQ4VGu8y
 pGoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6aeokwvJvo+VZZ2/bp+elZg4nDkNAvfI4V2FiOaiFCB3Nygbi8NINgjowdfc/eMgCK+o=@dpdk.org
X-Gm-Message-State: AOJu0YzZlZ6eeS+4JJhwiWEH3iwiwqzFlsCx2z3SGuzHvR9FgPbz6Zmy
 K+U17mkRt45GRWC3Y3TCaXQ5O5WwgngMIUltvCjv+FXPssA3PQJzT3q2Cw3oKPJfX/CVbVJpILd
 HeLY/NPHTREwS130iPp/HCZTf8XXZO24uCWe7ghDpV+EU0qNp/sisO5W8Wm6S7TIuI88LJ7+zFV
 sWVo46aq+25LUWJ/g=
X-Gm-Gg: ASbGncsIiWKdlVaJ5G8QW+eljW6OunnNbt7RwCIAihuLb0TVeHU/npl+mhn7z19qDJu
 hgvEAObScHL+Zk3ObFYwLgcXWRfhiUWvnXf7QPzvpB2ussSY1DzZqdhL1pHX2VJHg
X-Received: by 2002:a05:6512:31c8:b0:540:3561:969d with SMTP id
 2adb3069b0e04-54405a6a85bmr536081e87.49.1738741786373; 
 Tue, 04 Feb 2025 23:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnNIoS2faaFJCNT/bvyUrx0dvpRZoAtnZbWn5RAcULuoCYQRPUyae290ZPt+Y/m6SBtQmjIeQG+QeSIUCDDBk=
X-Received: by 2002:a05:6512:31c8:b0:540:3561:969d with SMTP id
 2adb3069b0e04-54405a6a85bmr536059e87.49.1738741785943; Tue, 04 Feb 2025
 23:49:45 -0800 (PST)
MIME-Version: 1.0
References: <PN2P287MB22230CF53B6310DB7F70FF39D3F42@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
 <CAJFAV8z-OCYEY5OYtrxftcLoXeY9HKAZ=T3KuEOu==CreS+Weg@mail.gmail.com>
 <PN2P287MB222391396CB4C9B5325FCD80D3F72@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN2P287MB222391396CB4C9B5325FCD80D3F72@PN2P287MB2223.INDP287.PROD.OUTLOOK.COM>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 08:49:33 +0100
X-Gm-Features: AWEUYZmQGa6YnHFtOURj6fVfRdiOtEEqq6aLZ5obHVuGLZaGNnLwCsnsX_B0xU4
Message-ID: <CAJFAV8wWm+JF9LoXG3bQXZ_y44+miX+xy-5_F6QgSgT3MNggTA@mail.gmail.com>
Subject: Re: Testing dpdk application using openNIC driver
To: Nafiah Siddiqha <nafiah.siddiqha@iwave-global.com>, 
 "Wiles, Keith" <keith.wiles@intel.com>
Cc: Luca Vizzarro <Luca.Vizzarro@arm.com>,
 Andre Muezerie <andremue@linux.microsoft.com>, 
 dev <dev@dpdk.org>, Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>, 
 Long Li <longli@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M-dFZIsuZPABFW5CfvHpjmBddT36lvBfor8jhKMkzWM_1738741786
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

Hello,

Please don't go private, as I tend to just ignore such mail.
Re-adding ml and others.

And don't top post.

On Wed, Feb 5, 2025 at 8:06=E2=80=AFAM Nafiah Siddiqha
<nafiah.siddiqha@iwave-global.com> wrote:
>
> Hi,
> I'm able to run testpmd with the given set of instructions you had mentio=
ned and tried it with pktgen fir which I'm facing mbuff issue,

If you apply the same commandline options, testpmd and pktgen should
have the same behavior.
Unless testpmd and pktgen are not linked the same way to your DPDK
installation/build directory.


> I have increased my  hugepages besides its throwing the same error while =
I can run the pktgen application with vfio-pci driver.
> I'm looking forward on testing pktgen application with openNIC driver.

openNIC seems an out of tree driver from AMD/Xilinx.
The DPDK upstream developers don't know much about this.
You will need to contact the authors if you face issues with this driver.

Some comment below, as the problem still seems a generic DPDK issue.

>
> Below are the logs,
>
> sudo ./usr/local/bin/pktgen -l 1-8 -n 4  --vdev=3D"net_pcap0,iface=3Denp1=
s0f0" --vdev=3D"net_pcap1,iface=3Denp1s0f1" -d librte_net_pcap.so -- -m [2:=
3].0 -m [5:8].1
>
> Copyright(c) <2010-2021>, Intel Corporation. All rights reserved. Powered=
 by DPDK
> EAL: Detected 12 lcore(s)
> EAL: Detected 1 NUMA nodes
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'VA'
> EAL: 4 hugepages of size 1073741824 reserved, but no mounted hugetlbfs fo=
und for that size
> EAL: Probing VFIO support...
> EAL: VFIO support initialized
> EAL: No legacy callbacks, legacy socket not created
>
> *** Copyright(c) <2010-2021>, Intel Corporation. All rights reserved.
> *** Pktgen  created by: Keith Wiles -- >>> Powered by DPDK <<<
>
>  Port: Name         IfIndex Alias        NUMA  PCI
>     0: net_pcap        4    eth_pcap      -1
>     1: net_pcap        5    eth_pcap      -1
>
> Initialize Port 0 -- TxQ 1, RxQ 1
> MBUF: error setting mempool handler
> !PANIC!: Cannot create mbuf pool (Default RX  0:0) port 0, queue 0, nb_mb=
ufs 4096, socket_id 0: Invalid argument
> PANIC in pktgen_mbuf_pool_create():
> Cannot create mbuf pool (Default RX  0:0) port 0, queue 0, nb_mbufs 4096,=
 socket_id 0: Invalid argument

I guess no mempool driver is loaded, so pktgen can't create a mempool.

Rather than pass only one driver in the command line, you'd better
pass the directory where all the compiled DPDK drivers are.
That will be much easier than having to cherry pick every driver you need.


--=20
David Marchand

