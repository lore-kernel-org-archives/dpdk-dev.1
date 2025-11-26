Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89729D111B3
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 22:16:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E7540DDD;
	Wed, 26 Nov 2025 23:16:34 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 12E7940B9E
 for <dev@dpdk.org>; Wed, 26 Nov 2025 23:16:31 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b2dcdde65bso33765185a.0
 for <dev@dpdk.org>; Wed, 26 Nov 2025 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764195391;
 x=1764800191; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnLF+3ZMXM7D/Bw7G2BfoSb9+5hKqoZgcZ9Z/fgNQDg=;
 b=M1dDMerJRK/TShDeqOciqEPp8axVvoYZ7jZBCfUMuRiMSYn+Opt1kJHqx/ujyeMCFq
 nz+YZFcTL3EwMnB5n22V7wGr0ZoMEdxzhfZomk5q3dUQBlwEsjgAFLbLRSlvp92RAV4O
 NuA75UUGTRAnv27e9nMjhsRPnIYWbmex16cNTesSLopBvSe9UAP7XB0Pt0UEtd6C1dQe
 i5Bn5YDKX2Wfy+wORipaSthcDneKCdmscttgTkYzWzeDOuiweuQhh3LOXCkrAJyKJrD8
 GosIUt5DeLOomthJP6FWuaSXO48xkg97BToKg/cza6BkmpV2299PibP17cdZC7leOzH8
 XLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764195391; x=1764800191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nnLF+3ZMXM7D/Bw7G2BfoSb9+5hKqoZgcZ9Z/fgNQDg=;
 b=Sd9VjK1QEjVSz4Z5izYBwBTeDBNuAY0einaMlrafiMuQ0NOBIhIfnM0CWcLApNProK
 WZ9hLgk31rS7heWT3gsREHttSH8eW75YUmiyPLrdnfNCJH/t2dgxFzGI4t8h+1kDL7zL
 NYNS+2da+jh1rVqnZ7SCk67QBDk55YWWI01lcEqRyK4MW9iks66ZPaIOs8jn/jwJNLaL
 Qic2Oz907Wnn6BT9+eDxg8sBQliY7RHDNBBIWmieklwDpVAJ5CQ8srNyNhp+saJwpDQU
 k7iKC45SJx0CEDfdg7gcUwyNx5omUVomGiHb4TeedP8jLxoto1abR2QrAdbK8PNf8ivu
 262Q==
X-Gm-Message-State: AOJu0YypJVmTSFb0XpqrUA0NEMfwKZyxjjhM/j2VK1nwvPDaWnpJToDi
 8KfQ4b9DaWXVltSGWLX2uajuIjWwh4CpyZZcZ3JkEqmO4vPykDE+5p6ZaAvCYKEq9Dg=
X-Gm-Gg: ASbGncu6iinl3QakLBNjXFkFgDhI1Yun4mnkxV9WbnnPB2CL4CuDDPe9gXbtDWM3c74
 sk1CBXl7uN/EQKFAfrhI2cxeDWjr01oMAhGj9kQ9c4NQsdKUvC316Bztt8Q+aoslxJmVBU4T6X5
 R84e2XxPAyuIB+7kICGLEyVOUZ6rA5afOdPpRN5gT1t57hOPpNeDpBSh+fVsVEJQZEE7txP4K7h
 k0Yolt4YHXBym9To2l4SrI/kGPeg/cNrDLpnJhZihm/HTAWmNzd8BDI9huJYbRqV+OsD+psm672
 0w+1L5Djc+r3Gym6vx8hnFSkXPDKQfWIh5Ymr0Z16e/7icK1M60LBQT0841E8xlnvZNAmttdCt0
 EmqLRDkks/2TWcYQ3A/e+hbc3nxEkONdZmXqrpY1wtlYlgf8JZhv1YUSiM9sdCkUUIucbMoCSJ6
 SlFxekn1DloDz0sQgDP/JKEWbSVy1SC0oiQ6kTSH7DbYZS9crI6iyi
X-Google-Smtp-Source: AGHT+IEYXMQyFHozFziU2gRctWc7QJz55XX4K8rS9n9alP4MwF81ezC+3o1IkOojq+O3iOLFmgo1rQ==
X-Received: by 2002:ac8:5fce:0:b0:4ee:483:3123 with SMTP id
 d75a77b69052e-4efbdaf2d1cmr115989331cf.67.1764195391062; 
 Wed, 26 Nov 2025 14:16:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48b45ccesm130937621cf.0.2025.11.26.14.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 14:16:30 -0800 (PST)
Date: Wed, 26 Nov 2025 14:16:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Dimon" <dimon.zhao@nebula-matrix.com>
Cc: "dev" <dev@dpdk.org>, "Kyo Liu" <kyo.liu@nebula-matrix.com>, "Leon"
 <leon.yu@nebula-matrix.com>, "Sam" <sam.chen@nebula-matrix.com>,
 techboard@dpdk.org
Subject: Re: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BBVENI?= v1 1/1] net/nbl:
 add VLAN offload set interface
Message-ID: <20251126141625.55be6cea@phoenix.local>
In-Reply-To: <2f658961-3fc4-48c9-9d46-99de9fabe9a7.dimon.zhao@nebula-matrix.com>
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-2-dimon.zhao@nebula-matrix.com>
 <20251124153545.7123c338@phoenix.local>
 <c28f7d63-7af2-4b48-9c2c-9dcd51ed9ebc.dimon.zhao@nebula-matrix.com>
 <20251125072758.37b8b100@phoenix.local>
 <2f658961-3fc4-48c9-9d46-99de9fabe9a7.dimon.zhao@nebula-matrix.com>
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

On Wed, 26 Nov 2025 09:52:19 +0800
"Dimon" <dimon.zhao@nebula-matrix.com> wrote:

> Hi Stephen,
> Thank you for your feedback.=20
> We understand your technical concern regarding the VLAN offload implement=
ation.
> Our implementation choice is driven by practical customer requirements.
> In real-world deployment scenarios, there is a strong expectation that ba=
sic VLAN offload capabilities are available and functional by default.
> Numerous customer applications, automation scripts, and network configura=
tions rely on these standard VLAN operations "just working,"
> irrespective of whether the underlying mechanism is hardware-accelerated =
or software-based.
> Our current approach ensures that:
> Compatibility is maintained: Existing deployment tools and scripts functi=
on without any required modifications.
> Customer expectations are met: The fundamental VLAN functionality is pres=
ent and operational.
> The alternative=E2=80=94returning -ENOTSUP=E2=80=94would indeed break a s=
ignificant number of existing customer deployments that
> operate under the reasonable assumption that basic VLAN features are avai=
lable.
> Thank you.
> ------------------------------------------------------------------

Never mind, I got confused.

The NBL device does report VLAN_STRIP in rx_offload_capa but since
it is doing it purely in software didn't notice that.
The other drivers doing VLAN all in software is virtio and dpaa2.

Your right the mask doesn't matter since the driver is directly looking
at rxmode.offloads to determine what to do.

Since you are running on ARM could see wrong value because the rxmode.offlo=
ads
is being updated in one thread and receive logic is running in another thre=
ad.
Looks like atomic operations might be necessary here (and virtio and dpaa2)
to be safe.

I will go ahead and recheck this and merge to next-net.




