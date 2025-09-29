Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14291CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 22:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3B8D402D8;
	Tue, 30 Sep 2025 00:48:44 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id B98A3402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 00:48:43 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-80ff41475cdso50777266d6.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759186123;
 x=1759790923; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lj73FD3ytdTr3KA47peViXSKb3uZjPNveL/ZVgVxq6Y=;
 b=M8AARssfy+7iuFWywtRh6H+moVz+qLho1lvDm7CFeGMDmEmlW0qMgfS1Nv04Qmj0iJ
 stuRM91YO6t+dcON4rhiJsd9vEjWFag1yp2ja6LCJ6AeFB8p5zrZzto9QTcPa794WiEv
 3hN2fOzI0razJlEOg2zagjw5RhZLsARi9BBKM2Q5jlpmsTLqyzLl3aiN6V8OtbC6OeBE
 fMb0iltoTErNPjbwqBpb1qiQA4k0TmXKgJK51KCSBm32tUYmZYgcGSpi947v4pTUVofM
 woXifJnAXUNp+QsiY/Iw73EBvcnf7bLKWDqtXirOSQ6ApPhh4hTmqPc6EYtiVuE15f0y
 B3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759186123; x=1759790923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lj73FD3ytdTr3KA47peViXSKb3uZjPNveL/ZVgVxq6Y=;
 b=s1HHXVo4SDvh/3PQ2reWfb+guFmeWj3a6nPsSwVQB6qIVucxfWig2j3BWeOoZbTQgH
 fyXOYMOmHL6RaEI3r2MfNrtOZ6RbtKd0vIhFzsQiUqZRgPkFIJmosTSNOne6PuJPLDL7
 eG+nD1p3Q4N/GLBUf9lUXG4tU+Dj4valhXrnofKdf2DR91waV6Od10NF6QLP7lpOS+O7
 VHJbJMbqqlER3v1DGuTZxFHrA7sjhj7ylOhqy9YrKePZarH6az1wOifMQ1UTLOgO00u1
 QIV8zJv6YU60zJwUjNBhFVPzaG9KciWdqxi9BbrdYQwkN4jMtOGTa72lGIrMIfckt3oB
 iELg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp0gCn3g6PzMIiNMMR6mIfOGQpUweNox6yIXRRjhc3KSCrIBdaWklKdtDUoV278tMW1qU=@dpdk.org
X-Gm-Message-State: AOJu0YxQqQd3g6olmlhD1zV5o0fy0z7D/ImA+TcLD20VPH2+7IoB/g6C
 hZxzpiklIcrs1qZG92I3hBO2rizGR0nbbesFmStOOM0EofT0n4DPQNJvHEU/lmwFxn4=
X-Gm-Gg: ASbGncvH2ArgisWIz80p7HX7meWre4GdHC/gYYUd2FKJ2YtJtgDuBI9weCRIPvKgP+0
 GnrL0My6tbiBfcNEVRzu1a/QqPVVFSX2bQsqSbmyyZlwwK8zIz3YGdVuhCXUJrSFszOKsIyO94Q
 H5AorVaj9qvXa+9YfPa78r3ODPPntpK5mhMBkkMxk5BrwRs79nnIbs9jeDJfFB11s+NWQN1Hpf+
 TXyqjNSyWssK+4ImY7xmTVIVDwAuEAmQo4CpglVKgdlWfuLBAe/OOWzuPvAn4/DblCbp2bhIZMJ
 kEZwLuD9Z0dajATvyXtNiYFvviRzjyWUJxu532WVfWj22jxrwBoyP4GTSiTxG8oKCt0Ywe7s/Yf
 QerI/cWuik9xYYdQMmzDg1OTHDxSXCrOZvluuIPzhbrVIkNGorXpkD+iw8zugBzz5k8WjPXXQrO
 Rc74nwwawldOj2KxqR2dqX
X-Google-Smtp-Source: AGHT+IGPdtZOM5znZS94+HqJNnv9qQax6nvesk1urz7vWh926MwDZKWtru/JNsFa3xz8MEYn+UfMbA==
X-Received: by 2002:a05:6214:21a3:b0:796:268e:74eb with SMTP id
 6a1803df08f44-7fc28736d91mr240652866d6.6.1759186122800; 
 Mon, 29 Sep 2025 15:48:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013e5d620dsm84983286d6.29.2025.09.29.15.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 15:48:42 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:48:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Kai Ji" <kai.ji@intel.com>, <dev@dpdk.org>, <gakhil@marvell.com>,
 <konstantin.ananyev@huawei.com>, <bruce.richardson@intel.com>,
 <thomas@monjalon.net>, <stable@dpdk.org>
Subject: Re: [dpdk-dev v4 1/2] eal: Add mem equal and non-equal to prevent
 timing attacks memcmp.
Message-ID: <20250929154838.2f0741f7@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65481@smartserver.smartshare.dk>
References: <20250926160209.56496-1-kai.ji@intel.com>
 <20250929145049.153078-1-kai.ji@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65481@smartserver.smartshare.dk>
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

On Mon, 29 Sep 2025 19:48:19 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Kai Ji [mailto:kai.ji@intel.com]
> > Sent: Monday, 29 September 2025 16.51
> >=20
> > Bugzilla ID: 1773
> > Cc: stable@dpdk.org
> >=20
> > [0] https://bugs.dpdk.org/show_bug.cgi?id=3D1773
> >=20
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > --- =20
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> @Stephen: V4 also includes equal, which you was asking for.
>=20

The point is that we should only have the eq variant.
Having the not equal is unnecessary addition.
