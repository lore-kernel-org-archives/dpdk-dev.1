Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60595E9D3EF
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 14:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 689D4402F2;
	Wed,  4 Feb 2026 15:53:45 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 22342402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 15:53:44 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso69252265e9.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770216823;
 x=1770821623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydyuDjojEX8sUSoWO/3eU69r/mzgYWeaw5VXlWjlGqo=;
 b=lsZ4o+aAo89rO67YMrH5t1Frt4JCSRp251HwwDsjSz31sOkFsvBrjmChe0oCDuz41m
 npZcZtgxz7Y6KKaNSYhFJ3oHKshBSnPYnQhR4RN8bu3wR4rL7TzZrcnKM4qUbv/D6GEM
 2z+/Yd4vDWETUxTKtQGINKXipY6xRn6fJ8UCRjZBnh3oNUcIO09QQHIgUZYbosHL4VGf
 iRy/DNDrObPU0j5H3Hy+8C31K30VJ8uTxYvaCpCcAoOdkTpmiyjESNG8xNhbUyUC7YmA
 3T0fh8OVGOKL+0iPsW2cvnI+7AmWCMHYCX/BL0lMYVGum2a0lWduuQmg28j/Eum+FKhe
 a32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770216823; x=1770821623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydyuDjojEX8sUSoWO/3eU69r/mzgYWeaw5VXlWjlGqo=;
 b=EFmDz40D+G+2+aTamlaAtAAlVPSne81x1dh+wdpsVgssgrnQsoiQUtK4vSae3D5xh2
 hXOasl55vjrLOYasAuwA7WhewfwoRa05kMnoPyENKY2llllbxWsG3lFm/yHtbvw5AytR
 clJrKWfO0ygv8GXGAXj2AprTKMZDWDUCWQz5bSXrphks0BmZUGaQf34PkO7jJTcwZbet
 /DZDS6Z7wyXV28n/Z5Hh7w4FSYWCBnjRj5CdPeWZPbeDcny5XgvyXixwALxLb03VT9a8
 TJibtLxXKujaPLVDHslccyMpCvzIsQ+Gs39Oo7zxX7nm3kG3dQKpZ96n0UyOmD6rEAxF
 QY2w==
X-Gm-Message-State: AOJu0Yy7ynCDXeCrGMPNhc6FAczheRqeUicr5BOiIzDscNFdg+O8dgy2
 xJKqhEu3FZrmlw56ZnlRYmnmKENXx74rh+DntBRv9O0esP6o04AB0PiJ9gn92Qj2I6c=
X-Gm-Gg: AZuq6aJzJR/sAYbKPBMPkV6osHflwnP2nW9sLmbRxuVDMS+W2eayeENwtR/v5imME4I
 FnqQ4A5cQwk6sMw1FBO54LvCHM77SbYevlfiZoW/VOX0VV+B7eS+nLUrQhlMWVuIU9AWDML5ybj
 defgKmzjXnr/ivmmCaYUPMmSDHw6hVvAe6hnx8IuTKLgNllwQyQJdvtq8I4BJIEowkWen2zv2YH
 zQRiySp0ie/ZZfXO9zknL6V4sBkbrb7t+rWxqdPlteNEOP7JAhuwa2n3BbeQdKnYnwdmAz1HDq4
 bQoA/X5cqiEBID7J5bFa4mjqzIO6nfz2isOOGGR0p8M0ZZ23KFwkhLAbVf10LpvvO6BDr3Tp+lC
 mSRpxI6jM+B+jBiO5kUTWMcgSDwv35FLANNRUOAzrGsLTD3k1MfB4GvHodNFZ5SH4vQdUY7CGO+
 0srEzI91wIoaunru1ngjAzOyUWMBQDaieojr2MbaVdEVB1aRnbkipksLrR94zZbs4=
X-Received: by 2002:a05:600c:34c4:b0:47a:975b:e3e6 with SMTP id
 5b1f17b1804b1-4830e96fa56mr41589585e9.18.1770216823381; 
 Wed, 04 Feb 2026 06:53:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25683sm6863337f8f.6.2026.02.04.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:53:43 -0800 (PST)
Date: Wed, 4 Feb 2026 06:53:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260204065338.0fae67fe@phoenix.local>
In-Reply-To: <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <20260202113659.24052-4-sismis@dyna-nic.com>
 <20260202120313.15ecedb3@phoenix.local>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
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

On Tue, 3 Feb 2026 09:34:26 +0100
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:

> >
> > The kernel version of checkpatch complains here. The DPDK shell script
> > seems to be set to ignore this but.
> >
> > WARNING: break is not useful after a return
> > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > +               return cmd_flow_parsed(out);
> > +               break;
> >
> > Should I create a new patch set or just let it be at this moment? =20
> Lukas


I am ok with it as is.
