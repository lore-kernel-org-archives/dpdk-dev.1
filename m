Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EDFC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45C094065A;
	Mon, 10 Feb 2025 20:04:21 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6407440616
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:19 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so105618365ad.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214258;
 x=1739819058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daz6xBR9KJzm6vERrl3bx6B1qbZIN3A8VMQJwMmahSA=;
 b=VGyaTr5aCao7mOpyDJlhfuS9uJbPLbs37OiheSOi98icPzHSSPQqT3IfNRH5GrC2eI
 w566otg5LrU1otFS2xTZKD+pJf/Se5QBXrq7Fio8JVSgaXdcxF9BmbnAONE+xf3H7/kW
 5O2U2CUGHmH9RAGJCFWu1CJiyObcpErzjb94xwOA866KLsZ0zRPfGLADYltZl84wG6W7
 TypYKM1KKCsq1LYYL3kRMLzVzg3WPGNhCP4aE1Jh6D/4uTfLx+oSth0fM2LvPHBP/qpx
 sTi3Uk32oT0t86oIiLjn/X/rZrPZpeU1mK+lWhPAt7P8ia2bjfY/KR8NbcCuOUHdJr3N
 P6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214258; x=1739819058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daz6xBR9KJzm6vERrl3bx6B1qbZIN3A8VMQJwMmahSA=;
 b=BIFWJ+O3AH67iaLkxRlOCyqJC+pcDdnY0DLcDGInIGQQr4bQ0ZvMJjKmG8gyss7ph1
 ywLLCCUzMcMh1BeunQKtk1zE3gVYy9hylA4VJEjVKKhDVVRIJrhW2t58yhEYtkUiaQtD
 vEUWVBJpNQLLTHG8HMYuZE2dLrYzzaLVxzER61MbDmbaPFVLCJa7YLxM/bIdutfBNgT1
 XuKVwC5TzJe7TtBBTPvyPXrsHE0UoAmRIuEPfXZxXeSI1NXYpxTbWIf0Bf+TyIsXvZ4D
 WBiKy/HsukR0ioPYRgtCQsB3nU0MZJtEVdwhpzu2U38HayWheVZXZjpaCHFzMtzlmNu1
 5e+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbZk1ixoTC9BBuvKZhT54ypAqi5Spf31j0Oy5LzfCtq7mdaAE2spd9oq1GR1OW7XI0PqU=@dpdk.org
X-Gm-Message-State: AOJu0YyAulOrAmZeBS8J555J8X87CCQ6g2V7UYcugpTMAZR3agzRsaMu
 VFrrhtoff9kl6KOqAtEoJ5M/bV/84igQc5kXaqA/jBHcCPZ/oC/wYoM0Gs4mfOw=
X-Gm-Gg: ASbGnctEfzoCQF9z+XONv88rp2Vamir1+ww6uGwIyKS7MdY2AEV8XFJRTUGmCHhocYx
 Fk+RPAtZWcOva7DeXTmej5XHzHPxQjZdB91DGgwU11C8Xyg8FU1rDGRsh3HcmyMcQIxq/LsBbmh
 as0MxxsD1LBerFBM91M2HM0tgWTlacHjjf9sbMf+rfag1/GQbRaHcsvx6/pNWhgqMWNt2DuIHl+
 ePwrRBRhfAANybXTvcChaEIRtuF+rMtRad+gIvKdie4PyRAxrY+Wkqc0k3CYIMzdIZkyv0Pg4JS
 +p/jMOTSDQDAQ51lKHq+yhbzctybbbLSCo7M1U5SsELrH+T4A9tY96vtN7QqMwD9w3QE
X-Google-Smtp-Source: AGHT+IH8oSI4oj9rsWy6LVRAb4vKF8gSbHpu08lIsexgZBngfAlmWnOt27pYtcGCX7ydfj1AJ8pUnA==
X-Received: by 2002:aa7:88d5:0:b0:732:18a9:cdc5 with SMTP id
 d2e1a72fcca58-73218aa067amr773139b3a.14.1739214258554; 
 Mon, 10 Feb 2025 11:04:18 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73077975f05sm4511914b3a.14.2025.02.10.11.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:17 -0800 (PST)
Date: Mon, 10 Feb 2025 10:43:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250210104328.5e376c7e@hermes.local>
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 10 Feb 2025 15:26:27 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso=20
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
>=20
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.


Driver errors on most basic build (gcc-14 x86)

[2394/3266] Compiling C object drivers/net/rnp/base/librnp_base.a.p/rnp_mbx=
.c.o
../drivers/net/rnp/base/rnp_mbx.c: In function =E2=80=98rnp_write_mbx_pf=E2=
=80=99:
../drivers/net/rnp/base/rnp_mbx.c:323:51: warning: array subscript 64 is ab=
ove array bounds of =E2=80=98struct rnp_mbx_sync[64]=E2=80=99 [-Warray-boun=
ds=3D]
  323 |         struct rnp_mbx_sync *sync =3D &hw->mbx.syncs[mbx_id];
      |                                      ~~~~~~~~~~~~~^~~~~~~~
In file included from ../drivers/net/rnp/base/rnp_mbx.c:7:
../drivers/net/rnp/base/rnp_hw.h:57:29: note: while referencing =E2=80=98sy=
ncs=E2=80=99
   57 |         struct rnp_mbx_sync syncs[RNP_MBX_FW];
      |                             ^~~~~
../drivers/net/rnp/base/rnp_mbx.c: In function =E2=80=98rnp_read_mbx_pf=E2=
=80=99:
../drivers/net/rnp/base/rnp_mbx.c:282:51: warning: array subscript 64 is ab=
ove array bounds of =E2=80=98struct rnp_mbx_sync[64]=E2=80=99 [-Warray-boun=
ds=3D]
  282 |         struct rnp_mbx_sync *sync =3D &hw->mbx.syncs[mbx_id];
      |                                      ~~~~~~~~~~~~~^~~~~~~~
../drivers/net/rnp/base/rnp_hw.h:57:29: note: while referencing =E2=80=98sy=
ncs=E2=80=99
   57 |         struct rnp_mbx_sync syncs[RNP_MBX_FW];
      |                             ^~~~~
[3266/3266] Linking target app/dpdk-test
