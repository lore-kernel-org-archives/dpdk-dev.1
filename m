Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80927F44873
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1261402DB;
	Fri, 10 Apr 2026 16:38:35 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 109C64026C
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:38:35 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so384322766b.3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831915; cv=none;
 d=google.com; s=arc-20240605;
 b=JwpARfLgH/l0UZwmJ8yN+++Fz3z8troMwm3y5d8YJeENWWBalVKS59E26KBumvAApC
 AaJ3aGVMeHjlUE8jYny3ram3VdsnKQFgxnIh+cO6ODJ7lyiz1E4HLreY4OKbVgEhb6jm
 c91ODPrh9YuqnI/HzbUf4Vl/2pApxfkLYamGD+BwoR86OVZbQ/W3bpa0owda1oDMGP9R
 S2ULCHwg9GE21X7MBq5keWkhIpJPeuEwG+EgZuWvKPvI1o8yX06RVvDtT5woGAqX8Tzk
 daZwKfjENULYoalA5NcQt/U6FnRHpdgTT0W4bGFJyq4NEv3u/w/kBb7i96Iqa5xpUFlu
 hsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A06exdZm2cHZFUODeNB0Orh5lrdIeyzK5vfylk9DcZY=;
 fh=Uj0eVlpomvihxSu1pbnfelQNTW7qusIThUQ4stm88l8=;
 b=RzviPw2mOQjojWv/ZhqdqkwA2y/fVRy8j5s/uIi62MJ0/c2lLrQ4JGvEiDpVgTJ8Hu
 iwg8LChVIS1Yrhttjr3/AvqY901pJYeeDnH+/8tTSJKBI8kCAqs9uf8Vx8bmJEwnlWKF
 Md5nyZfU0dovt15ds9tSzxAVcrYUP0OEEEYS7mkbiS9YGvc64AAwqCNgZADNo9QreaYi
 /lX/qnytrUO60mGbEUqjvAO/ejvNAUhYn3kN6ynpjLeSV8yWzA9SpWF1Ntrr9KfRCC5e
 z7HD5Q532+infO9MYD2pSOMlMaSLv5+m4ZHcpGj89uFQg4zUzZ+gasZqY+6QKpEfGNfG
 8FLQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775831914; x=1776436714; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A06exdZm2cHZFUODeNB0Orh5lrdIeyzK5vfylk9DcZY=;
 b=Q12o5j4rLE3xwClqNVdXafXZKMZpjqPfRomSA+QsDF2bLn5chie6NVaa6XCH/j/JHj
 yp3IbmpTgqnS3M44m11PYH8DxtBu0OFuCn/8Sy7IUlro92SjtTHi6B40Z2sPGGc63rUt
 26RYPTUIbS7oo9ChrkaNaPzSVFwtyBPc78Z3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831914; x=1776436714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A06exdZm2cHZFUODeNB0Orh5lrdIeyzK5vfylk9DcZY=;
 b=GRmeIu8LfLLkM1TuqEV8p/LmexfkGmhQACrgb6/G7/r18tr50K11Evdi3SJDl9h245
 xngk3kwZFycnt/Q1BVEEGWwEOKbmumP7V0bmVdHgvykx87hXMtVMVS/CzxFtgdxdBIOK
 xADlChoHkW9IiCJ+l1FamSjWxBkj0k+wqZ0AMrapo89rvgWMJqcoGKiYPDZdJs87CwkV
 Tld/IN/q3hD7Ix4ciYnRipQtbslpNlHS5/JJKO3Om9oqpnjelsFi+JYn18aM5ozWMQWK
 +WmfchPPqcbxA0kTmasyf5N+DKtM7mbxDVN6Ai4WOBBfjuubEgVlY/7Io8iynaTx4Am7
 1zKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVae8EY766SyLH1IfofW/Fpk1DOuf2l/N1Ugfuvyba3jXIXkAMkYZI0ESBd8IxKZS4nDHo=@dpdk.org
X-Gm-Message-State: AOJu0Yxvw75ikKTBPyup24DG9qqeZeT0pcjPPir4zCZEuP9CW5b1RsqB
 q45vCI34rDTuG+Ii6aBzbtFAchmvs/stofZCunQi86QCKzRWdNOLVT8FOECiVKlF3PWhe3M3CeO
 iaet/4bltKw6EEwBPSN3/gD2v6K+emo0vSN3hqJCylg==
X-Gm-Gg: AeBDiev/wzqgz6ym3AY4F+3iUqKLD6hccbUVff5jTrBxqlz11+CGjuAVldXb+O9KN2a
 ElVs5UbUIK6RhlqHbm0l7W7UFGr3MIajeAEi0/JWRS5+5nxM8ag05jh2unw85O6cBOakwW9QFDI
 lH3MCrDuyoM1k/bpexs/Ex6JyUnXVq/C5G4tpOvHfBbJ266+3z3gX6Bqtb+DrgEH0Fc2i7SHP0y
 iPUfQ9zj6CmWYeXP2daEMNzmWeddw/pC4zCcimYK1M5mHx0IBZFNqafQoOMXrxMefORM1tfxW5E
 V9U92Yuyrg1tEKJhNgmQymJ39eOpgUPE6CjTcP7C
X-Received: by 2002:a17:906:7947:b0:b9c:30b7:770f with SMTP id
 a640c23a62f3a-b9d7265d35emr242290266b.34.1775831914385; Fri, 10 Apr 2026
 07:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251218150718.738116-1-abailey@iol.unh.edu>
 <20260202170924.398261-1-abailey@iol.unh.edu>
In-Reply-To: <20260202170924.398261-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:38:22 -0400
X-Gm-Features: AQROBzDQ66P5F_bQmu6Dn2j3Z_u4etYXjH99lSkcLTg22qvJq4ht0aEUJ5kwjk0
Message-ID: <CABJ3N2WovMTgNOtBGLjX3tnrgrafvQ6JUcF7hGkYbbO=ExW=mg@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update testsuite named to be clear and consistent
To: probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000702230064f1c1690"
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

--000000000000702230064f1c1690
Content-Type: text/plain; charset="UTF-8"

This is an update on the status of this patch.

This patch has a doc build failure and apply patch failure that needs to be
resolved.
Another version will be sent.

--000000000000702230064f1c1690
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This=C2=A0is an update on the status of this patch.<br><br=
>This patch has a doc build failure and apply patch failure that needs to b=
e resolved.<br>Another version will be sent.</div>

--000000000000702230064f1c1690--
