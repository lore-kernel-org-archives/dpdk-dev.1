Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A2C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 17:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E0234025E;
	Fri, 25 Apr 2025 19:47:43 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id D3F5F4021F
 for <dev@dpdk.org>; Fri, 25 Apr 2025 19:47:41 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ac79fa6e1c2so38933066b.1
 for <dev@dpdk.org>; Fri, 25 Apr 2025 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745603261; x=1746208061; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D/mTflLV6Dm+YyMAAFWO10UdndzeGTE1iC1hZrjAaaU=;
 b=mm1BymiNxW7E4PHkYClxhosFnfSmTPOSrUZ0Znq9xRv/HAK8YFlLAsCl6PnSkooap/
 i03mCRsgBOsWWoCdGqJqrAulXHZV1vE5tPWRWAczjN5VY/GpHfb8uOX1tGRar0fAkORx
 oY5LieDdScVC4hwZiYOH9azojJPH28a3vNpBFKh00i00koRvX93SYjJMoFG1FuaIdbUB
 reXpZymnk1Kh9lO2ImAWa1TfLK5JaKEvH/F64H90l1zACePrAtfhJFh6dc8SnX+6s9po
 HYFk6vNCcJ3inTtRbeUZrlr6vj4vwtBOJHXNO7kdJj6jZPyKUaobSAEGt9v0RlVQBUbU
 DZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745603261; x=1746208061;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/mTflLV6Dm+YyMAAFWO10UdndzeGTE1iC1hZrjAaaU=;
 b=iK87IZswnZQOG9qy4+o/inUKqtZBrG0IVg7tTU7o98nvGKmox7SCQX8N494h74Xn9D
 0JOgFbxBz35NODIN1LIj1IqL2myXux4An7XgZtmCLTh1i3qso/jBtls1M+xIzKpQwbUT
 1572Yx7+NvhiWq6ZiulWZwKcmuQcIA2BxJKSmO8fJHVS01toATuF86Gc45HGtgJ62Qsi
 DtH8eXqeWD8sjCKRrwlMNOb1SftwLpnWdtzmD7j7QYXSucjgBHJtP7+2kuc01I+av55b
 tpViUujYpJQ8E51y1cA8AEIm+T7q3d0bvT+TXWkh3ctwn+3xHlLXJMwBRiITD7MuGrqi
 6NCg==
X-Gm-Message-State: AOJu0YyPc9wQGDJZ+hzU1FD3oiljldqU4ISyP57zMGZ8ehairRoWN2y3
 QGcibXMl8rlj/umAZvnmLNrMgIA23F0+DZnuUW+sXue1VBeJGga6hF5mI2Hee/bHv/RKZhdIV91
 BDCJc2qGHpt+iS7+6azAhjyqkaN0w7ygG
X-Gm-Gg: ASbGncv13tZrNyJzLd3kU6ecUo11zhpY5VgqYO/iJt5VxA1mWGIdel8/EJdzLHA+8vy
 Snu54ThJRg0CT8NS0imdt2u1YqQUItwL/uhXrrGEScm8eKjHO9fJnLD1y6XxARSVK8U6JNBlhsN
 bajTx+5Y07Y2iBcp77kn0NtrBOddlKd1XpyR0bjL0QZv+h3sYmxbrCH4/8
X-Google-Smtp-Source: AGHT+IHggSlMiMv5HEM/SDqonNrK+SpkasnfBgpjhWOQZhttwMhTtiJsImcqpgj8lUJMnWAm/ikPBQdoagiE5hcAiwM=
X-Received: by 2002:a17:907:d91:b0:abf:689a:ed2c with SMTP id
 a640c23a62f3a-ace7108051dmr99192366b.6.1745603260855; Fri, 25 Apr 2025
 10:47:40 -0700 (PDT)
MIME-Version: 1.0
From: Prashant Upadhyaya <praupadhyaya@gmail.com>
Date: Fri, 25 Apr 2025 23:17:30 +0530
X-Gm-Features: ATxdqUGL1VtPERtWE5rGW3sIGuwuBHPhaCL2damdtlq2lYv4b1Tvhdp9Vt4wMjE
Message-ID: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
Subject: Regarding Mellanox bifurcated driver on Azure
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000483d8c06339deed4"
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

--000000000000483d8c06339deed4
Content-Type: text/plain; charset="UTF-8"

Hi,

I am having a VM on Azure where I have got two 'accelerated networking'
interfaces of Mellanox
# lspci -nn|grep -i ether
6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)
f08c:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710
Family [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)

I have a DPDK application which needs to obtain 'all' packets from the NIC.
I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my app starts
and is able to detect the NIC's.
Everything looks good
myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: VFIO support initialized
mlx5_net: Default miss action is not supported.
mlx5_net: Default miss action is not supported.
All Ports initialized
Port 0 is UP (50000 Mbps)
Port 1 is UP (50000 Mbps)

The trouble is that the ARP packets are not being picked up by my DPDK
application, I see them being delivered to the kernel via the eth interface
corresponding to the port (MLX is a bifurcated driver, you don't really
bind to the NIC, so you still see the eth interfaces at linux level and can
run tcpdump on those, I see ARP packets in the tcpdump there on the
interface)
I can receive UDP packets in my DPDK app though.

My application is not setting any rte_flow rules etc. so I was expecting
that by default my dpdk app would get all the packets as is normally the
case with other NIC's
Is there something I need to configure for Mellanox NIC somewhere such that
I get 'all' the packets including ARP packets in my DPDK app ?

Regards
-Prashant

--000000000000483d8c06339deed4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am having a VM on Azure where I h=
ave got two &#39;accelerated networking&#39; interfaces of Mellanox</div><d=
iv># lspci -nn|grep -i ether<br>
6561:00:02.0 Ethernet controller [0200]: Mellanox Technologies MT27710 Fami=
ly [ConnectX-4 Lx Virtual Function] [15b3:1016] (rev 80)<br>f08c:00:02.0 Et=
hernet controller [0200]: Mellanox Technologies MT27710 Family [ConnectX-4 =
Lx Virtual Function] [15b3:1016] (rev 80)</div><div><br></div><div>I have a=
 DPDK application which needs to obtain &#39;all&#39; packets from the NIC.=
</div><div>I installed the drivers, compiled DPDK24.11 (Ubuntu20.04), my ap=
p starts and is able to detect the NIC&#39;s.</div><div>Everything looks go=
od</div><div>myapp.out -c 0x07 -a f08c:00:02.0 -a 6561:00:02.0<br>
EAL: Detected CPU lcores: 8<br>
EAL: Detected NUMA nodes: 1<br>
EAL: Detected shared linkage of DPDK<br>
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket<br>
EAL: Selected IOVA mode &#39;PA&#39;<br>
EAL: VFIO support initialized<br>
mlx5_net: Default miss action is not supported.<br>
mlx5_net: Default miss action is not supported.<br>
All Ports initialized<br>
Port 0 is UP (50000 Mbps)<br>
Port 1 is UP (50000 Mbps)</div><div><br></div><div>The trouble is that the =
ARP packets are not being picked up by my DPDK application, I see them bein=
g delivered to the kernel via the eth interface corresponding to the port (=
MLX is a bifurcated driver, you don&#39;t really bind to the NIC, so you st=
ill see the eth interfaces at linux level and can run tcpdump on those, I s=
ee ARP packets in the tcpdump there on the interface)</div><div>I can recei=
ve UDP packets in my DPDK app though.</div><div><br></div><div>My applicati=
on is not setting any rte_flow rules etc. so I was expecting that by defaul=
t my dpdk app would get all the packets as is normally the case with other =
NIC&#39;s</div><div>Is there something I need to configure for Mellanox NIC=
 somewhere such that I get &#39;all&#39; the packets including ARP packets =
in my DPDK app ?</div><div><br></div><div>Regards</div><div>-Prashant</div>=
<div><br></div></div>

--000000000000483d8c06339deed4--
