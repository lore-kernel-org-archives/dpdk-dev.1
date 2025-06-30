Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E7C83035
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B82EB402A5;
	Mon, 30 Jun 2025 15:11:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A659E40291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751289106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmOlVmTTl3BNalxrUzri2qkeBFyPPZig7HLbn4rBjEE=;
 b=hTUrFez12bGZx8QxnOYEW3xOb8XyIUWlM/rL8Ye6rNWOcHCTvmblfEzXiHCUQHrw+sbBQ6
 iMWwWoJM89ksINkaEuZW4rpSjE4otXkXhROSn0Yw8lLL16NOJxxtzXiHj+zu+oKi/8Chn3
 DaItveETn+Lmk+bmflTiNgA3a2NOZHs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-A9REVSa7NTid9U7sxi2BbA-1; Mon, 30 Jun 2025 09:11:44 -0400
X-MC-Unique: A9REVSa7NTid9U7sxi2BbA-1
X-Mimecast-MFC-AGG-ID: A9REVSa7NTid9U7sxi2BbA_1751289103
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32cf580cacdso6100031fa.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 06:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289103; x=1751893903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmOlVmTTl3BNalxrUzri2qkeBFyPPZig7HLbn4rBjEE=;
 b=KmsV9xdO4NV8L725UeqrC6RTukkX7I6G2nK+cG7/g/lVQlerUNJT97arvnvWODUb3p
 tdV+v1IbQXFXpc2z2Xa8vF+p4fHQVuwPLWqcQzlQm2noq+yeii0BDDwo4HzbD5unAOsg
 aidz6cNZpdqHloF1L0ZX2URt09z+W4TEnEU4/kFEeM4YyUT3fTI60fDPGxZsY9p9Ef6G
 Amj3pjzNqC1w1MVDkNELTXX4fzTP9yaGX19lS10SsBHWizS3sB/vFAEr/GxFdqpt6CmT
 OkQTg+BxbHtMG/iiwiclch3GbVkn9+XtFIc1kvkfgQjpFlpurst+EsAIUWxQpCKmgRJD
 ogDw==
X-Gm-Message-State: AOJu0YzhH8UT1U8tEfEm0ah9KZx0ZO+b+r+KWN9U6a66VP1qirDrJaQD
 oibMopKAHlCtVVOIaOR23AHfSGeU5XWB1KHoMOc5yp52lTE8AdBy0p/+f/TsRmYZXkZ6xctiUQ7
 ed9Lo8VxK9Hp7oSXhffYnAqMsy3QpKKdVZ0PJktJhw8wW4dRXRIHszr11u5z+h9hBF+HexT06JC
 b27vITGZX5mpqVKHKQua4=
X-Gm-Gg: ASbGnctLh1bU7QwyY6qPKGEUTG2+CsPBmyDyYoy5ZQ6LbLeVQRFBXf6U+gOoN9XqUAW
 o+EUKQq61cp6R75+PFyfkSVA140H29HBhn4nKD9HM3YfSrWsSb6nu+mdDpO0SJSQusC/Ymy+niH
 q+2m7u7Q==
X-Received: by 2002:a05:6512:3b91:b0:553:ac33:ff34 with SMTP id
 2adb3069b0e04-5550b7ecb0dmr4363651e87.8.1751289102969; 
 Mon, 30 Jun 2025 06:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdIwQbU7YUW6VtQgO/MXXrsrszmlN+POt3ja5AMfIWWESoZjtwrnU3Ztabm+2Dsgma4zs2IcddCQkuSqOUQ2s=
X-Received: by 2002:a05:6512:3b91:b0:553:ac33:ff34 with SMTP id
 2adb3069b0e04-5550b7ecb0dmr4363618e87.8.1751289102246; Mon, 30 Jun 2025
 06:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-3-bruce.richardson@intel.com>
In-Reply-To: <20250624133409.550372-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 30 Jun 2025 15:11:30 +0200
X-Gm-Features: Ac12FXy-qTEygAm6K9vOFjHiQY67jp4a_xdC0Zxfb8tZFK0qZqJc4CyzdEKk_WY
Message-ID: <CAJFAV8xFCZeU_dA7Q8KqjzWPU2O1+vgRqkhw0y4PVZG_=krb-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: use core lists rather than masks in guides
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>, 
 Anoob Joseph <anoobj@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>, 
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, Praveen Shetty <praveen.shetty@intel.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Gaetan Rivet <grive@u256.net>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>, 
 Harry van Haaren <harry.van.haaren@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, 
 Akhil Goyal <gakhil@marvell.com>, Jingjing Wu <jingjing.wu@intel.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Kai Ji <kai.ji@intel.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QmqqvLiNGpBo8lergsuo5OmsWFs9kLseenEVqGrIHTU_1751289103
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

Hello Bruce,

On Tue, Jun 24, 2025 at 3:35=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> For the guides for applications and examples, use the "-l" flag rather
> than the "-c" flag to pass in core lists rather than core masks. While
> for the trivial examples given, core masks work fine and may be easier;
> in real-world cases, with potentially hundreds of cores, core lists are
> a much better fix, so update the docs to reflect this.
>
> Similarly replace instances of "-s <service-coremask>" with
> "-S <service-core-list>".
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

I have a few more changes.

I can squash them when applying if you double check them:


diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rs=
t
index 9abbd3abda..f8b43823a7 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -136,11 +136,11 @@ DEK is passed in plaintext without keytag.

   The mlx5 crypto PMD can be verified by running the test application::
     Wrapped mode:
-      dpdk-test -c 1 -n 1 -w <dev>,class=3Dcrypto,wcs_file=3D<file_path>
+      dpdk-test -l 0 -n 1 -w <dev>,class=3Dcrypto,wcs_file=3D<file_path>
       RTE>>cryptodev_mlx5_autotest

     Plaintext mode:
-      dpdk-test -c 1 -n 1 -w <dev>,class=3Dcrypto
+      dpdk-test -l 0 -n 1 -w <dev>,class=3Dcrypto
       RTE>>cryptodev_mlx5_autotest


diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 2ba0c9e058..667a876710 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -582,7 +582,7 @@ pattern.

 Example usage in testpmd::

-   ./dpdk-testpmd -c 3 -w 0002:02:00.0,switch_header=3Dexdsa -- -i \
+   ./dpdk-testpmd -l 0,1 -w 0002:02:00.0,switch_header=3Dexdsa -- -i \
                   --rx-offloads=3D0x00080000 --rxq 8 --txq 8
    testpmd> flow create 0 ingress pattern eth / raw relative is 0 pattern =
\
           spec ab pattern mask ab offset is 4 / end actions queue index 1 =
/ end
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index a8f9d40042..c6531d5684 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -413,7 +413,7 @@ and add the ``--force-max-simd-bitwidth=3D64``
startup parameter to disable vector

 .. code-block:: console

-   examples/dpdk-ptpclient -c f -n 3 -a 0000:ec:00.1
--force-max-simd-bitwidth=3D64 -- -T 1 -p 0x1 -c 1
+   examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1
--force-max-simd-bitwidth=3D64 -- -T 1 -p 0x1 -c 1

 Tx Packet Pacing
 ~~~~~~~~~~~~~~~~
@@ -429,7 +429,7 @@ For example:

 .. code-block:: console

-   dpdk-testpmd -a 0000:31:00.0 -c f -n 4 -- -i --tx-offloads=3D0x200000
+   dpdk-testpmd -a 0000:31:00.0 -l 0-3 -n 4 -- -i --tx-offloads=3D0x200000
    set fwd txonly
    set txtimes <inter_burst>,<intra_burst>
    start
diff --git a/doc/guides/nics/mvneta.rst b/doc/guides/nics/mvneta.rst
index 69aa98eafc..f999525902 100644
--- a/doc/guides/nics/mvneta.rst
+++ b/doc/guides/nics/mvneta.rst
@@ -90,8 +90,8 @@ be passed as part of EAL arguments.

 .. code-block:: console

-   ./dpdk-testpmd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 \
-    -c 3 -- -i --p 3 -a
+   ./dpdk-testpmd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -l 0,1 -- =
\
+     -i -p 3 -a


 Building MUSDK
@@ -144,12 +144,12 @@ In order to run testpmd example application
following command can be used:

 .. code-block:: console

-   ./dpdk-testpmd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -c 3 -- \
-     -i --p 3 -a --txd 256 --rxd 128 --rxq=3D1 --txq=3D1  --nb-cores=3D1
+   ./dpdk-testpmd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -l 0,1 -- =
\
+     -i -p 3 -a --txd 256 --rxd 128 --rxq=3D1 --txq=3D1  --nb-cores=3D1


 In order to run l2fwd example application following command can be used:

 .. code-block:: console

-   ./dpdk-l2fwd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -c 3 -- -T 1=
 -p 3
+   ./dpdk-l2fwd --vdev=3Dnet_mvneta,iface=3Deth0,iface=3Deth1 -l 0,1 -- -T=
 1 -p 3
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 4e42abd70e..07be97dfb8 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -162,7 +162,7 @@ In order to run testpmd example application
following command can be used:

 .. code-block:: console

-   ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -c 7 -- \
+   ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -l 0-2 -- \
      --burst=3D128 --txd=3D2048 --rxd=3D1024 --rxq=3D2 --txq=3D2  --nb-cor=
es=3D2 \
      -i -a --rss-udp

@@ -391,7 +391,7 @@ Usage example
 .. code-block:: console

    ./dpdk-testpmd
--vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2,cfg=3D/home/user/mrvl.conf \
-     -c 7 -- -i -a --disable-hw-vlan-strip --rxq=3D3 --txq=3D3
+     -l 0-2 -- -i -a --disable-hw-vlan-strip --rxq=3D3 --txq=3D3

 .. _flowapi:

@@ -504,7 +504,7 @@ Before proceeding run testpmd user application:

 .. code-block:: console

-   ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -c 3 -- -i
--p 3 -a --disable-hw-vlan-strip
+   ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2 -l 0,1 -- -=
i
--p 3 -a --disable-hw-vlan-strip

 Example #1
 ^^^^^^^^^^
@@ -598,7 +598,7 @@ Usage example

    .. code-block:: console

-               ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2
-c 6 -- -i -p 3 -a --txd 1024 --rxd 1024
+               ./dpdk-testpmd --vdev=3Deth_mvpp2,iface=3Deth0,iface=3Deth2
-l 1,2 -- -i -p 3 -a --txd 1024 --rxd 1024

 #. Create meter profile:

@@ -680,7 +680,7 @@ For a detailed usage description please refer to
"Traffic Management" section in

    .. code-block:: console

-               ./dpdk-testpmd
--vdev=3Dnet_mrvl,iface=3Deth0,iface=3Deth2,cfg=3D./qos_config -c 7 -- \
+               ./dpdk-testpmd
--vdev=3Dnet_mrvl,iface=3Deth0,iface=3Deth2,cfg=3D./qos_config -l 0-2 -- \
                -i -p 3 --disable-hw-vlan-strip --rxq 3 --txq 3 --txd
1024 --rxd 1024

 #. Stop all ports:
diff --git a/doc/guides/nics/octeontx.rst b/doc/guides/nics/octeontx.rst
index 66c5ce93e3..f963eca648 100644
--- a/doc/guides/nics/octeontx.rst
+++ b/doc/guides/nics/octeontx.rst
@@ -68,7 +68,7 @@ for details.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 700 \
+      ./<build_dir>/app/dpdk-testpmd -l 8-10 \
                 --base-virtaddr=3D0x100000000000 \
                 --mbuf-pool-ops-name=3D"octeontx_fpavf" \
                 --vdev=3D'event_octeontx' \
diff --git a/doc/guides/sample_app_ug/packet_ordering.rst
b/doc/guides/sample_app_ug/packet_ordering.rst
index 1eb9a478aa..f96c0ad697 100644
--- a/doc/guides/sample_app_ug/packet_ordering.rst
+++ b/doc/guides/sample_app_ug/packet_ordering.rst
@@ -46,7 +46,7 @@ The application execution command line is:
     ./<build_dir>/examples/dpdk-packet_ordering [EAL options] -- -p PORTMA=
SK /
     [--disable-reorder] [--insight-worker]

-The -c EAL CPU_COREMASK option has to contain at least 3 CPU cores.
+The -l EAL corelist option has to contain at least 3 CPU cores.
 The first CPU core in the core mask is the main core and would be assigned=
 to
 RX core, the last to TX core and the rest to Worker cores.


--=20
David Marchand

