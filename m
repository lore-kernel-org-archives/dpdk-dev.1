Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3091DC83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 12:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B6934014F;
	Fri, 18 Jul 2025 14:04:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EE7234013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 14:04:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752840245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWePIDQHN7GsaYqLPFA07rMjnYBzqevdRXfJnwG6D90=;
 b=UqrMwz8qHSwRkiKh3foSJ59D3TQ5lNkGHPvbmgVGPAZQBw6RGr7ztuq7VVuRbGdLbBCj3M
 Ga3KCggAHN4eg7fbPoh7VZ5rLfufKZ2bJ4690QOLd8CohwgUd6MYaNKnJceAsBscin9R25
 rmGfkLydF+s3OJ8Egl1VUPf38tySDQY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ibGumKJnPTS-cNNfmc0etA-1; Fri, 18 Jul 2025 08:04:04 -0400
X-MC-Unique: ibGumKJnPTS-cNNfmc0etA-1
X-Mimecast-MFC-AGG-ID: ibGumKJnPTS-cNNfmc0etA_1752840243
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32b500a9a28so9027331fa.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 05:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752840243; x=1753445043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWePIDQHN7GsaYqLPFA07rMjnYBzqevdRXfJnwG6D90=;
 b=nNWJVp9GswhcNOyteTICnDrmXuH5gQMBY+itwsLOy9/e4QM926xki3wMlJxV00OWfN
 Mh9DBczdv+dYnGON6JCyXbW08x2CgEw6VILlG3y4esJ9a3hpuWjv/8fwmbua0jKpXU4A
 qCWzQsf7wHdO3lTNibk8JlFTJh+O7dcmR6f6y50J+P7+sSm1yFg28sZMqSYbrGG8BlqN
 /qcu4G5PaU179IqsLlodm9ojVVSX+tZ6n0cQgOsABzcMw0csilB1ceWeGPBSS5EVWyFt
 9Mx6LARC6BcApd/PuQt4e+1PeUWqrD/j7eiMnKR5m/zwN0gBOk9ZFEy6BM/eqU9pRby6
 /4cQ==
X-Gm-Message-State: AOJu0Yz3ZyCP9KPXDgf2htfGdup6phtaFKvmRK8zUjTsG/GybF7RG838
 mASIHJjF+gzN3Fq2e2Cxl1mktKNi96s5eSuty1yB4E4IbVedN9/TZLnR0DeNG/2SzL5/x/VpeY8
 TbhkWw3n3SN5MbR8+9+ecYXirTX2BohlFsRNLSAxW3Uo/zEMf9sI/JW0KVSjyAWbenQrd6o+jk+
 8ZYrbfzIb72RvSZ4kZhfQ=
X-Gm-Gg: ASbGnctqVC2EoeVGVNiedi7wneAZynXT6m88F0oUFZcR/yDScc1lmdNfJw6a0hx4B+1
 u9NKmw2oui9S1bkEUNK49AkVHjtgI2yxMNDruJL/lEqMTtX0AMvx/FSKazBnGUTotcb2Vv5PZCn
 iwZmGIBzqEYFJQKJNUDQF4vj8=
X-Received: by 2002:a2e:be11:0:b0:32a:7f4f:ebf2 with SMTP id
 38308e7fff4ca-3308f4bffd4mr27171421fa.5.1752840242400; 
 Fri, 18 Jul 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6FXLhvLfXweX0itJarQorvVxyEAb0bu7v57X2AKXO37XcKwPPYMX9O2NDfDpx6psPw86QX8K9Fq62W5wzPjE=
X-Received: by 2002:a2e:be11:0:b0:32a:7f4f:ebf2 with SMTP id
 38308e7fff4ca-3308f4bffd4mr27171241fa.5.1752840241623; Fri, 18 Jul 2025
 05:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-3-hailinx.xu@intel.com>
 <aHonS9mrtq_mU2s-@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHonS9mrtq_mU2s-@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 18 Jul 2025 14:03:50 +0200
X-Gm-Features: Ac12FXzsiv7RNLyqSrmNpJZD_ULlzxYyvImI4b4v0mRSDmPKbaYCl8KEWYeIacE
Message-ID: <CAJFAV8yOiqJ7EqTfLdh-PMvCML7KAvr2SS0qSN89TyqFZBUH9w@mail.gmail.com>
Subject: Re: [PATCH v1] net/ixgbe: add nic and updated recommended matching
 list
To: Bruce Richardson <bruce.richardson@intel.com>,
 hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, rajesh.t.puttaswamy@intel.com, john.mcnamara@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hZU3tsfv5Ie6zuxoJTJ_dbv6LozzyFoztN4WAgBXJ68_1752840243
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

On Fri, Jul 18, 2025 at 12:52=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 17, 2025 at 02:16:04PM +0800, hailinx wrote:
> > Signed-off-by: hailinx <hailinx.xu@intel.com>
> > ---
> >  doc/guides/nics/ixgbe.rst | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
>
> >
> > diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> > index a03ec7a7e8..6380e18feb 100644
> > --- a/doc/guides/nics/ixgbe.rst
> > +++ b/doc/guides/nics/ixgbe.rst
> > @@ -36,6 +36,8 @@ Supported Chipsets and NICs
> >  - Intel Ethernet Converged Network Adapter X540-T2
> >  - Intel Ethernet Converged Network Adapter X550-T1
> >  - Intel Ethernet Converged Network Adapter X550-T2
> > +- Intel Ethernet Network Adapter E610-XT2
> > +- Intel Ethernet Network Adapter E610-XT4
> >
> >  Vector PMD for IXGBE
> >  --------------------
> > @@ -93,6 +95,25 @@ Windows Prerequisites and Pre-conditions
> >  - Loading of private Dynamic Device Personalization (DDP) package
> >    is not supported on Windows.
> >
> > +Kernel driver and Firmware Matching List
> > +----------------------------------------
> > +
> > +It is highly recommended to upgrade the ixgbe kernel driver and firmwa=
re
> > +to avoid the compatibility issues with ixgbe PMD.
> > +The table below shows a summary of the DPDK versions
> > +with corresponding out-of-tree Linux kernel drivers and firmware.
> > +The full list of in-tree and out-of-tree Linux kernel drivers from ker=
nel.org
> > +and Linux distributions that were tested and verified
> > +are listed in the Tested Platforms section of the Release Notes for ea=
ch release.
> > +
> > +For E610,
> > +
> > +   +--------------+-----------------------+------------------+
> > +   | DPDK version | Kernel driver version | Firmware version |
> > +   +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +   |     25.07    |         6.1.5         |        1.0       |
> > +   +--------------+-----------------------+------------------+
> > +
> >
> >  Feature not Supported by RX Vector PMD
> >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Beware that the CI reported a build failure on this change:


FAILED: [code=3D2] doc/guides/html
/usr/bin/python3 ../buildtools/call-sphinx-build.py
/usr/bin/sphinx-build 25.07.0-rc3
/home/runner/work/dpdk/dpdk/doc/guides
/home/runner/work/dpdk/dpdk/build/doc/guides -a -W

Warning, treated as error:
/home/runner/work/dpdk/dpdk/doc/guides/nics/ixgbe.rst:118:Title level
inconsistent:

Feature not Supported by RX Vector PMD
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ninja: build stopped: subcommand failed.


--=20
David Marchand

