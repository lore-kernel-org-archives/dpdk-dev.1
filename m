Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D79CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:12:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F4774068A;
	Thu, 11 Jun 2026 16:12:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A95394068A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781187119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7V+xjHGLi4byvogZxT8vCirY3bD5eakVLdC0DVYeL4M=;
 b=PMYhMP1VDjwyAod1NQb8p224SjWcjH0Yvi7zFFvKcwfNyrJQwQijCP/TUUSG7qeni/GRaQ
 sbS65pQTILdWvQBUhoLm0y5mK5TxBO7rqh31rirCPfGYRj/f+tYtH7bl7PCSTYATZ7Z+Tc
 nlws3mjtEO1pUSZAFpHpnb9elhxBqQI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-AooL7VLXNY2nAERzABJLwg-1; Thu, 11 Jun 2026 10:11:54 -0400
X-MC-Unique: AooL7VLXNY2nAERzABJLwg-1
X-Mimecast-MFC-AGG-ID: AooL7VLXNY2nAERzABJLwg_1781187113
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39677519ac5so38683231fa.2
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187113; x=1781791913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V+xjHGLi4byvogZxT8vCirY3bD5eakVLdC0DVYeL4M=;
 b=CQPA2CtXueKwMGeZaEpfn2wTwAo/InFqPAcztJxyhUb7SXZQdJ8I/cehpw8BMhpNrn
 AlxQ3VTwTV2RG+TuOXTcsEkViSVN6bCOviWn66P6fcBaahDmsvXgfvv5qwKccpWV5G1l
 rQhEgfBVlR9rKjmA4tg98svfGdF7S6NGOgzrJAKAC3paQZpzHeQ1Mchirlr9+WA2C2Sk
 yY9u1kOXSGSc/AcfUPkXN5R9YVVBc6zdK/EnvAtr3EmY17RDuf02A0UVnMwr8vpr5F0S
 J/C/tFN+TLaeCBeaDBiE70QugMWxeltFoGWk1O1fknikxSm/HfIYJlRcyiisPuq+P7qg
 Dptg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WUbIjmeT+98+2/C9LkIehbnnlpsEAh4BBu4DRq8ZTYrM86iojPkw7ANDAPHXRmYs8/0w=@dpdk.org
X-Gm-Message-State: AOJu0YzME3p35xIszMVbHEWO7NUK8kIIEe+KD93jMhmuR8jJ994zdxwk
 IDqPy802GKVNYDo+4CRGJL2mSKQTEkha/PLhtJiERDx/e1ZN8p8bZ4DQGVI+oQfSPNVCBay5h8S
 jN738oOHDo6S5YomfXCwvu572qNUKcnzyy/vHQrTl/A67xQYP3TQEzlyxVEfmFYksKapADIN8u4
 /YdqeK66m4n6zX60LsG+w=
X-Gm-Gg: Acq92OFs5VdjSlsQv0Si/PSXXN2kQu/CFwWaaVX39kTRwSybO7Kq0ZzmMEzo+lrG/CJ
 PB/rRDc8P5mKy2r8lLIYU7nkZLdCSgkKjBC4JEHEAhSyzzBtkYP3en9MFBAtI46txM+QjegNgzZ
 amXklaDmqNTs2Ccpn8phRbN/NSVMwQyTUyWm/E5S9xf+spZEZ9/e1Q6rONVt2Yb7pxpmMvIUVTs
 UplYGBbgOihgC1rOCY3U0ibyqCm3Es2UEGI7Br0tY7ZrOzuwQs4B8W0axHNJ6EOXGWds/RspMpz
 Sytn
X-Received: by 2002:a05:651c:1504:b0:396:7fa2:e096 with SMTP id
 38308e7fff4ca-3991a017173mr9052771fa.4.1781187113250; 
 Thu, 11 Jun 2026 07:11:53 -0700 (PDT)
X-Received: by 2002:a05:651c:1504:b0:396:7fa2:e096 with SMTP id
 38308e7fff4ca-3991a017173mr9052571fa.4.1781187112607; Thu, 11 Jun 2026
 07:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260404171912.48947-1-wpan36@wisc.edu>
 <20260407070940.225de771@phoenix.local>
 <2S2V_VmSTBa7oGRJ0YAQqg@monjalon.net>
In-Reply-To: <2S2V_VmSTBa7oGRJ0YAQqg@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 11 Jun 2026 16:11:40 +0200
X-Gm-Features: AVVi8Cdy1nUeixeA-XQysY6PgYO693wbieMXMHuJM-87l9u8C1kTxY_OLQi6b34
Message-ID: <CAJFAV8w-VQJb6jM0KgAVP1rJKyUUwiBA6_seOCDwMX47rZmYyA@mail.gmail.com>
Subject: Re: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
To: Weijun Pan <wpan3636@gmail.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Weijun Pan <wpan36@wisc.edu>, dev@dpdk.org, Jun Yang <jun.yang@nxp.com>,
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w7U2SGC6oW6no9N5ZbqP5Os_C5ZPjWIMrm68NdMRP8Q_1781187113
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

On Wed, 10 Jun 2026 at 16:16, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 07/04/2026 16:09, Stephen Hemminger:
> > Why are these not inline functions.
> > Macros with lower case names are likely place fore confusion like this?
>
> Hemant, Sachin, Weijun, please could you consider this comment?

Besides, I understand the intention behind bz 1744 is to re-enable Wshadow.
But after applying this fix, I still see many warnings after re-enabling:

$ git diff
diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index ceae1c6c11..70098ad778 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -6,8 +6,6 @@ if not is_linux
     reason =3D 'only supported on Linux'
 endif

-cflags +=3D no_shadow_cflag
-
 deps +=3D ['common_dpaax', 'eventdev', 'kvargs']
 sources =3D files(
         'fslmc_bus.c',


$ ./devtools/test-meson-builds.sh
...
../../../git/pub/dpdk.org/main/drivers/bus/fslmc/qbman/qbman_portal.c:
In function =E2=80=98qbman_swp_enqueue_multiple_cinh_read_direct=E2=80=99:
../../../git/pub/dpdk.org/main/drivers/bus/fslmc/qbman/qbman_portal.c:1092:=
47:
error: declaration of =E2=80=98d=E2=80=99 shadows a parameter [-Werror=3Dsh=
adow]
 1092 |                         struct qbman_eq_desc *d =3D (struct
qbman_eq_desc *)p;
      |                                               ^
../../../git/pub/dpdk.org/main/drivers/bus/fslmc/qbman/qbman_portal.c:1047:=
45:
note: shadowed declaration is here
 1047 |                 const struct qbman_eq_desc *d,
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
../../../git/pub/dpdk.org/main/drivers/bus/fslmc/qbman/qbman_portal.c:
In function =E2=80=98qbman_swp_enqueue_multiple_cinh_direct=E2=80=99:
../../../git/pub/dpdk.org/main/drivers/bus/fslmc/qbman/qbman_portal.c:1161:=
47:
error: declaration of =E2=80=98d=E2=80=99 shadows a parameter [-Werror=3Dsh=
adow]
 1161 |                         struct qbman_eq_desc *d =3D (struct
qbman_eq_desc *)p;
      |                                               ^



--=20
David Marchand

