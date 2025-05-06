Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA1C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0AC740269;
	Tue,  6 May 2025 15:13:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 706AB40150
 for <dev@dpdk.org>; Tue,  6 May 2025 15:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746537215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+thjQ2hf1vTt3yvBv8czo+/BGBgImglBzvYDZYwhpo=;
 b=Md4Y2KskSRNoKutNib/2ta0rDMCbeh2Wuj/Eoo15anTmujbDbyvkvUzUx9IEIBcuARnQhd
 Ntb2CnbojCn4rxLZ2P+vuJcUyYfWTCBtAkNzdddvmb50e/l3QHbCJ9diOaUSV/6pbCAzSc
 zOmeGWJSwIA7UTsuAMsT+oCzCga+v9o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-2OTImbOjMTWbLYxpLVMOHQ-1; Tue, 06 May 2025 09:13:34 -0400
X-MC-Unique: 2OTImbOjMTWbLYxpLVMOHQ-1
X-Mimecast-MFC-AGG-ID: 2OTImbOjMTWbLYxpLVMOHQ_1746537213
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5498ec88462so2658478e87.2
 for <dev@dpdk.org>; Tue, 06 May 2025 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537213; x=1747142013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+thjQ2hf1vTt3yvBv8czo+/BGBgImglBzvYDZYwhpo=;
 b=Rbp0E48WloBBvGYmeFTZyg2aRZnwzrVUzaN7HxulH3lGm2Ilvs3ciErx664sTD5+BX
 TUH5aRZIbRl/2OuIIj8jTKkMTgosnWN5hpb45qt3tVUNQpis9AuV4MK/JvH/VOsm8eN6
 cYoXzRuqdQsWMkTadJm948A5ekHnpH3gWILA/06h5AZePoDgeneMDlB6Se1hng5hn9RL
 /sudjymMShHd7JjvQMscGdgX+qPSz9o0NBIh8sxP8JzvKm3Eidwe2uvVzM2I5PQJDYw1
 D9C6+lDaGhwen3RA9F88aU7HVDwud97sUp4mP0DHmjqRChb1Bt6AscWtyALl9ZL3fPhw
 9+hA==
X-Gm-Message-State: AOJu0Yz7UowMVygQctQxA4XL2GdMYaYKxAUUbIs8XPwSCmTmcBlPp26j
 rdlk/+dgsgRE+HgEiWtN3DugVfraaIz3TzxE3T+2FaCF3UbVjOreZVN7+O399v3TPYmR04oLrpT
 Wqjs2h8UBH6N3fBNuUtMQbr4UA4p0C8v/6uEB65vyz4c4kxrskduVyhZsKLMYrvxRXwPK6UdRRY
 3qhcB814VMSkAd0cM=
X-Gm-Gg: ASbGnctfM0ovdElm9JCVv0XIAcsLA3q8vVNWci//ASmDRPVaGqwh0V/WYSpzpBZUGR2
 SvDC5Y7d9BWp/WIl5MlBEQMUHXTzU7BTa5HHglf79Z6uFfSZTE4QCGH2CNStNRItOmvfF0VA=
X-Received: by 2002:a05:6512:3c85:b0:54e:85bc:d150 with SMTP id
 2adb3069b0e04-54fa4f9b9e5mr2982978e87.53.1746537212852; 
 Tue, 06 May 2025 06:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUuwp8O76UtlAlyJQ3SGUHhlYRNAzFGqQ6ATsGnURiBAD0crjLtnyQOLt+Ff5144nKA5b9UNQCxlmG/qr0q/c=
X-Received: by 2002:a05:6512:3c85:b0:54e:85bc:d150 with SMTP id
 2adb3069b0e04-54fa4f9b9e5mr2982971e87.53.1746537212428; Tue, 06 May 2025
 06:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250331161000.9886-1-bruce.richardson@intel.com>
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 6 May 2025 15:13:19 +0200
X-Gm-Features: ATxdqUGioQ0N6SNKEUUIenFOWrIrWknxc4WEnbTni9vn1EI7rQtzo4nsOZHE8BU
Message-ID: <CAJFAV8xq=a6unCGzoG4sr1RZREr6f=RjrQ3ytDF8o3dtkn0H2g@mail.gmail.com>
Subject: Re: [PATCH 00/10] centralise base code handling for drivers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1xL0od3327M7UbmwdnnZceetxfkWIFD0AK0js2dekQY_1746537213
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

On Mon, Mar 31, 2025 at 6:10=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Many DPDK drivers use the same pattern for base code handling, having
> a meson.build file in the base code directory which optionally defines
> some custom cflags for the base code build, then builds the code as a
> static library and extracts the objects from it. (The reason behind this
> is that, in meson, cflags apply per-object, so we need to have a
> separate build object for the base code to use custom flags)
>
> This patchset deduplicates this logic by putting it into the
> drivers/meson.build file, and allowing individual drivers to then just
> specify values for "base_sources" and "base_cflags".
>
> Depends-on: Series-34946 ("net/intel: clean up base code build")
>
> Bruce Richardson (10):
>   build: add generic support for base code in drivers
>   common/sfc_efx: use common base code build handling
>   net/hinic: use common base code build handling
>   net/intel: use common base code build handling
>   net/ngbe: use common base code build handling
>   net/octeontx: use common base code build handling
>   net/qede: use common base code build handling
>   net/thunderx: use common base code build handling
>   net/txgbe: use common base code build handling
>   raw/ifpga: use common base code build handling
>
>  drivers/common/sfc_efx/base/meson.build | 18 +++---------------
>  drivers/common/sfc_efx/meson.build      |  3 ---
>  drivers/meson.build                     | 20 ++++++++++++++++++++
>  drivers/net/hinic/base/meson.build      | 16 +++++-----------
>  drivers/net/hinic/meson.build           |  1 -
>  drivers/net/intel/e1000/meson.build     |  3 ---
>  drivers/net/intel/fm10k/meson.build     |  3 ---
>  drivers/net/intel/i40e/meson.build      |  2 --
>  drivers/net/intel/iavf/meson.build      |  1 -
>  drivers/net/intel/ice/base/meson.build  | 22 +++++++---------------
>  drivers/net/intel/ice/meson.build       |  2 --
>  drivers/net/intel/idpf/meson.build      |  1 -
>  drivers/net/intel/ixgbe/meson.build     |  3 ---
>  drivers/net/ngbe/base/meson.build       | 12 ++----------
>  drivers/net/ngbe/meson.build            |  3 ---
>  drivers/net/octeontx/base/meson.build   | 19 +------------------
>  drivers/net/octeontx/meson.build        |  3 ---
>  drivers/net/qede/base/meson.build       | 17 +++++------------
>  drivers/net/qede/meson.build            |  1 -
>  drivers/net/thunderx/base/meson.build   | 10 +---------
>  drivers/net/thunderx/meson.build        |  3 ---
>  drivers/net/txgbe/base/meson.build      | 18 ++----------------
>  drivers/net/txgbe/meson.build           |  3 ---
>  drivers/raw/ifpga/base/meson.build      | 21 ++-------------------
>  drivers/raw/ifpga/meson.build           | 15 ++++++++++++---
>  25 files changed, 60 insertions(+), 160 deletions(-)

Series applied.
Thanks for this cleanup Bruce.


--=20
David Marchand

