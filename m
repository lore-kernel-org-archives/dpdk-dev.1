Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D6CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3A5A402F0;
	Mon, 28 Sep 2026 19:24:34 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 412AB40275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 19:24:33 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2d747ee1f38so15033715ad.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790616272;
 x=1791221072; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=66w21BoDUwiZ50+fMGc+CoxDi2sIKE7RlEZRu20tFDM=;
 b=qZuv05CMwRujM6xOKpRo0r42W4SgpM5wagVPoXh8sFGCXVXg0oFVjnE0poOTKdajId
 3G+AdPyIhUw+cplZ1Vv9S+sgXwonEdgpx1dznl8QIi/RMCRU73OH7tLL+pUVRIHAyOJF
 6s6WzElXIkI02pZTZAZhWiFndKVoMbyh+D8lpcv7k8j3eZDyXZtfvJgCKOvalYPw1URh
 7YRUBEfzdsweTtklxyHgxOmrMGCjzFbSuQQYrSJrgPPqNBVrq9TdjAAz7QLa+RPluWxd
 At+eA3h+sSX47MklpJDk4DSV3/bQYOXtz0Y66eQL7coOrU246TCeAF8qYWa8lioRZJCT
 2qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616272; x=1791221072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=66w21BoDUwiZ50+fMGc+CoxDi2sIKE7RlEZRu20tFDM=;
 b=DVFs4AbIfZljbaRkGDv7+4rLThYf5+ovh21Azu+4R8Wz7ZLCjMGQKsYAth7Ym3AkHn
 xODLlX8/gIMWuUxxRSCWzN6kYHthKb4l3y6ATY0ZbB6nslSEBTrH8tj7jaKd7V6XVgcN
 7zHL77oRELqjUsjWVA7PkwNkuf+p/JxwkS15K+c9110mAa1UOD8zC4NfMqcs5NW0R/Gc
 5e/u3IkKD8V4BrwjhvhbILTLosHHPSDrimbcsZla+z5T3fcA4+Lq61Dk9DAFC4G6/mQ7
 jEfoH+9k6kpncrmB4hoC13urssG8SYfoUJPVKuVEbsZiuHbAlDdWdalt7NVJJRZ4hXhN
 57Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgCHMIrb1eYCBuNlTeNsxOWooF1p666RP1jRzOWGaYnmSH6W45LL5CP3KRdpn0pbg57J4=@dpdk.org
X-Gm-Message-State: AFq9FYJf1ZW/12CKuyefOC1sHhZATyBd1lgQJS7djdfkoCW24MoRy9Xm
 274Pl6xocZclsGdooXwq0+qUF0Zp5lHbVOCyX3h5NgUtTdnTBadSxRfDK3vZ2DebLdQ=
X-Gm-Gg: AYBFou27E7vXE5RAbGmgJA1X6bGrxcicHCBMW7PJdS1t987XVjEn7A+bRCkprKf5rAK
 ZErI0e64fjtmRewdeeadQmj3aTUodjp8b+KVBAAKuj03RePwK9fhaFekOWx8JiE7ijeO37peViT
 vr+pzq5JFKrq+6uDkWTfdofS2YR15SUC8wG3MzCpoA4hBlDKGYq/DGrT5YngxWp9TPjFOlPgCSw
 G3OePJdwzajxsxCUkJIRTEpbF5Ot2ZOVos0apoQb4HyjjI1sys8T0SWPPmy0qsHkDmv5lIqnSiD
 iGBsjdGIonclhDIaQM+OsXFNGko/vFDgV2M2DkEBMqn1/0KVBHraKovYBnElZe05V9IvQGarka4
 XApNsTJpfxvUyKYGo0BDQk5nzzrhTob5a3rpKenYV1pNiCg6QZU5ZvpGi09Dq7jF7HMyxGYWwB7
 0/jpyLQRYkdN9/svLGh1y0KvISOow4SYppNtlGHDYgWJ10mraeZo8koQPIxBwlqql3ttN4BusTw
 bQsCvbjgMG5sHSs06g8BoOOXYT531+ay0wEZTK5
X-Received: by 2002:a17:902:f543:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2df7da5cdfdmr110539345ad.8.1790616271946; 
 Mon, 28 Sep 2026 10:24:31 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc787854006sm4882680a12.1.2026.09.28.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:24:31 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:24:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v3] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260928102429.70ca1040@phoenix.local>
In-Reply-To: <2ec5b83b-54b7-4b69-afbd-33d4e4e81967@gmail.com>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260922213130.90138-1-stephen@networkplumber.org>
 <2ec5b83b-54b7-4b69-afbd-33d4e4e81967@gmail.com>
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

On Mon, 28 Sep 2026 17:18:40 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> Summarizing the exchange to v2, our own copy of=C2=A0rpcap-protocol.h=C2=
=A0is=20
> unavoidable here since one included in libpcap is an internal header=20
> that is not installed by design (irrespective of package maintainers). I=
=20
> am ready to ack the patch after this is clarified in the code to prevent=
=20
> other people from being similarly confused since situation with the=20
> dependencies here is quite complex.
>=20
> My request to better mark sections of main.c responsible for different=20
> concerns still stands, but is not a show stopper. Same for my request to=
=20
> make it a part of=C2=A0dpdk-testpmd instead of a secondary process. Anyon=
e=20
> interested can probably do either or both locally in half an hour in a=20
> code agent=C2=A0anyway.
>=20

I have a new version which has more features and splits up the code.
