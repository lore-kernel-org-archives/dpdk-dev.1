Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FBC98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:39:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E051B402DB;
	Wed, 23 Sep 2026 20:39:36 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 5A3D2402DB
 for <dev@dpdk.org>; Wed, 23 Sep 2026 20:39:35 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so674904a12.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790188774;
 x=1790793574; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G5A05HQnuvtfhf3QIIHTovwO3sW86vkwBmQs4791UkQ=;
 b=BV37WGh+0vX8tWptZraRZi+loNlvVOo4jb/J9ccKmbKvsixW84cjsdIRjCP+6sEmmQ
 CznJJ0sYg7VGLbJ/P3u6moIoUHO4zh6t7eGWM9Pzq35jxIcwPqUg+IDUd9fbplW7ymQ5
 7rme5rZrbtC2lb7tM+qY1cUJVviuxWcM6T1Rwx5Q7MVfZZO3zFHNsc3mTMLkDFOrGzFZ
 Tpqv4KIqmhA44e1lhDmeJ9dlS1WODCon/6KbuqsW0exb/I1zxgC65WL69ho27OJTP7qG
 xo8l76ajrIzI8f1PV/mPQjnSwHXaznRZzTCOp8lurW+r9W7HFaL9AIjLr+8Yowaxjm+g
 4o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790188774; x=1790793574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G5A05HQnuvtfhf3QIIHTovwO3sW86vkwBmQs4791UkQ=;
 b=e4OwTqpm3ScZRV9apL4F1iV8tT8oGIkQaU3OGVtiervGLGNVBtiyLQTxarDxLrFkaQ
 Payf5835Zt9hLEcSyXqtn5BNYCuP1/TKDVZpgQannc0rvYcYb3n37ZInUalPknk0+EUr
 l/lXJSyS1n+rOcAV1tGCkW24EXW57HcrL6sJNRFzrCCpse/rL1SoujkxmI5rSs87V7jJ
 7JwQPqkdD2iVmBk8ytrLqh9Q0hBFk78pNd8ELfMgPRjlAn6d/MdFLGQmloXyhKMTcPKt
 tLFY/Yx5wtkn25Vvb+jEoC4r7zP42aUdXFV6HvOZnblPO/jdUtNrYvYci7nGXqnoU8o1
 A1zg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvJBJsaO8CMPw6IiD+7fSkZOD0OoC0VHz7bxaQpu9P/QtAUDYJtOFZdmQAQDBLEsSTA8Q=@dpdk.org
X-Gm-Message-State: AFuF++kGGt3K62HnYkr6OQaQGAxkUFE5RkvjIvPv0RJn+pxQdv/3tOLF
 7pXtT2fyKkopEyNxtO/tNrM3OvCuaxr4hTlp9ywCeAVpNoGoGYPbehIgGCVeKfnPgC0=
X-Gm-Gg: AYBFou2w9DlA+Qi90lWP72De7I8N8HJzNrujdguTT5BjJ88gNWKNue77GsxBn0p4QSw
 ZHEvjsMygMm6sF1RRydtsFllxTm+/5g2e9YQxlyVVncOXioDQrC020rXiJG9cmBjPV349X1qAqc
 Tmc3kmnvZ1rrIx2Xmeh6/M2z4u0NRADeCzwxq44XQ92F/zF8lQ8fLFpqE7f4AZD48wAXGdmUwaq
 fESsbM2ai/Gbfa/Nmdu+8f6cTOXqUDXSX4fGVBNdt9/ad2sIaPCe7gEA7wPHGYHVljM8tfqtu0p
 lS7cFT4yybVbjS6Pyre2Mp0R8ZJFXTRTzNlPXEqO7sshHOr32y5hwRC4qlZrM+Kdhma3h4JqUaa
 UOjCgr/xUyVLPGFNco4Awy3UGq45dZF8eksItDhEruxaLmslbCZgBIeWoO34FSrVKzaQUbCSqbY
 kQkUMzVfMBnXN6PbEGOBdlrP6HMzzk9cZlFV4aJrZgzzy2hyBkDcKckRlfvDDnhtP5u0KKa+Lit
 62jeesQdIzDm10Lh28fuHnwazqZ4t0dnRokVj9a
X-Received: by 2002:a05:6a21:6a0d:b0:3d3:adbf:7782 with SMTP id
 adf61e73a8af0-3de0e75ebabmr91181637.23.1790188774375; 
 Wed, 23 Sep 2026 11:39:34 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad42fcsm1760701b3a.35.2026.09.23.11.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:39:34 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:30:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <ykanaujia@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: Re: [PATCH 1/2] common/cnxk: support aggregator enqueue profiles
Message-ID: <20260923113036.140e0a8f@phoenix.local>
In-Reply-To: <20260715084340.300442-1-ykanaujia@marvell.com>
References: <20260715084340.300442-1-ykanaujia@marvell.com>
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

On Wed, 15 Jul 2026 14:13:39 +0530
<ykanaujia@marvell.com> wrote:

> From: Satheesh Paul <psatheesh@marvell.com>
>=20
> Support for flow aggregator enqueue profiles.
>=20
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> ---
=20
This was merged to main without sufficient review.

AI review sees:


  16f07d871f "common/cnxk: support aggregator enqueue profiles" =E2=80=94 t=
wo real bugs:

  1. roc_nix.c:533 =E2=80=94 the new goto tm_conf_fini is the first error p=
ath placed after
  nix->dev.drv_inited =3D true (line=C2=A0526). It tears the device fully d=
own but never
  clears the flag, so a later roc_nix_dev_init on the same nix hits the ear=
ly if=20
  (nix->dev.drv_inited) return 0; at line 463 and reports success on a dead=
 device.
  Fix: move the cn20k call above the assignment, or clear the flag in the e=
rror
  path. (The nix_list TAILQ entry is also leaked, but that's pre-existing o=
n every
  failure path =E2=80=94 not this patch's regression.)
  2. roc_nix.c:605 =E2=80=94 struct nix_af_rx_flow_vec_ctrl_write_rsp is us=
ed but defined=20
  nowhere in the tree. It compiles only because it's a pointer to an incomp=
lete
  type that's never dereferenced. The M() entry at roc_mbox.h:362 declares =
the
  response as msg_rsp; the variable should be struct msg_rsp *.

  Plus: if (rc) goto exit; immediately before exit: is a no-op; static (non=
-const)
  arrays defined in roc_nix_flow_vec.h; 2021 copyright on a new file; one-l=
ine
  commit message for a new mbox message and HW config path.

  I checked and cleared the things that looked suspicious here: mbox ID 0x8=
034 is
  unused, both bitfield unions total exactly 64 bits, every constant fits i=
ts
  field, and memcpy sizes match the request array dimensions.
