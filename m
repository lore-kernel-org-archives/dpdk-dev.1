Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B943CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 22:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4773F4026D;
	Mon, 10 Nov 2025 23:10:22 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0F1804026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 23:10:20 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-295247a814bso45791505ad.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762812620;
 x=1763417420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2X5VES9qxrt3Xi1SU9xFdqOPjJYKG57PkMX+hw6TtlM=;
 b=k7WxCkrMeC7AFMGaFi3vZdn6+oUAAh3SQmzMNU7AbbsWB88KFvehRSKi6254hM2bl1
 WvYB9VSAe6z4cvL2HfDDveRSv7uszEJXrojpC4lEH7ZVC28SRyZuUX9wjFt5OvlUfmcB
 czASRLA1lyhNIpOun1NfaDftkkip4KWFJchhkkD3s0wGDgx9nJrrtAU5AogTmN9OR2PI
 EwCme58e1SJ0z2/a31+PIEIYveZdJeuhoXkiV+Id0C5silO5Mbrx02jJCAqJ3Tqtc6Pn
 ncMAJwNBIGLUEkZWSD0zFlm4z2eIfL+6roDEHKAU6auktvF+GQZ40eIQ/i4/reqenr5C
 fbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762812620; x=1763417420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2X5VES9qxrt3Xi1SU9xFdqOPjJYKG57PkMX+hw6TtlM=;
 b=EuZRMGS2jWvWHJgOVM/CkqlzUiI/u0V5iycm4B47EOxRnsRpHpTqq9KanUixtIc1qm
 bqjtOxLQIZW0PbKDUoU5DZRyNmbFoDvS1wak50SNIUGhZS070NrlS3haMRDATADQ3ooU
 J9PgBmM54UsYakcrpmNNS1iWUfQbF6dejfizi3B/rukCfI1MppIIZIT9oHddgIi/S+WT
 Rdr7U/GKHohSQaZqmm3g46RhT2M2tR3YeKpmEMMt40yIzd0dooDfwL/u65UhIiw9CVhp
 GcTxaq3rtTryaqNvHIcpngHdtgVIbIRLH+ZxYGC5m58x2qMK7UEVO2BzVu9od7JG0Faa
 85FA==
X-Gm-Message-State: AOJu0YwkxSIawDl2q4X/TjneZX6zzM72b7uhTAFgigy84rCzjed0VFb7
 RPPFmx4LZzRw4by+ARCyUm3yV12GfHdeWA684Y6zDw2P0n0E5HFtEbrgRBTktq5x+Z8=
X-Gm-Gg: ASbGncvB5g6zEAD0r4vr69H+8ZxdwD8SoHpLbV27GGV9XzW6NAXGKiDB+W9nCOe0ESz
 UPTy9L2Rfqq421JyfzhOuu5/Mo9lO74Z0baPXnyOSJ+/6I+CGgSMOJnwwc1Wvp2x3XsP/YSVhH7
 0lS8+NDAnEBfxvtOZL3om20T1jxbjwKioxiUBcOPRGXRG7MHLgXxP28MxNSloD5m3BQugCPw9bU
 PLd/ZUADa3fx/jpWrQ6dHampbVVHJAXb8hBZuDoSk08SLwe6/I0/Jj8MzQBHpon/X0lUpidcYMW
 sqeorB+MM8mYZmwOsjAbrcbIQI3xt1DFzSPod9JkGN/7P8kH4WRRE6+PpGte+neNj/avJ2vgoA0
 0S6uFAlQgjU3T/JQZiFPot2ocF6//tIAvaL9A+6CNreei57O621xGArfoJqDt/NO85rRY/blX63
 43qzMcHFt8KMxi23B0ZM0DEWKjFL1plRWGkpWgz7HEwg3d
X-Google-Smtp-Source: AGHT+IGdtGmVZ7xXoolyYxnwnvGrgErRAn92209ouGeCxI54xxrXc9tcNrnrD4S4x1aObrLiTBxl8Q==
X-Received: by 2002:a17:903:1b04:b0:298:2afa:796d with SMTP id
 d9443c01a7336-2982afa7a31mr50149665ad.61.1762812620011; 
 Mon, 10 Nov 2025 14:10:20 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c6f6cdsm160945635ad.71.2025.11.10.14.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 14:10:19 -0800 (PST)
Date: Mon, 10 Nov 2025 14:10:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manish Kurup <manish.kurup@broadcom.com>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Michael Baucom
 <michael.baucom@broadcom.com>, Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
Message-ID: <20251110141017.4f2c034b@phoenix>
In-Reply-To: <CAEKskBV8Ebeesg8qLZ7JcENWYRgfFeOAOhHRBC-WaaLRhn43Mg@mail.gmail.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
 <20251029160712.58519-20-manish.kurup@broadcom.com>
 <20251110135206.03f1a0be@phoenix>
 <CAEKskBV8Ebeesg8qLZ7JcENWYRgfFeOAOhHRBC-WaaLRhn43Mg@mail.gmail.com>
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

On Mon, 10 Nov 2025 17:01:17 -0500
Manish Kurup <manish.kurup@broadcom.com> wrote:

> On Mon, Nov 10, 2025 at 16:52 Stephen Hemminger <stephen@networkplumber.o=
rg>
> wrote:
>=20
> > On Wed, 29 Oct 2025 12:06:34 -0400
> > Manish Kurup <manish.kurup@broadcom.com> wrote:
> > =20
> > > From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> > >
> > > Add support for hot upgrade for a generic application.  An
> > > application can start a backup application and add the same flows
> > > that has been offloaded in primary application and secondary
> > > application can take over primary application.
> > >
> > > Update the hwrm version to the correct version number, the
> > > corresponding code version for hot upgrade api got changed.
> > >
> > > Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> > > Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
> > > Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
> > > --- =20
> >
> > After merge to main the build fails because of this patch
> >
> > $ meson setup build
> > ...
> > Has header "bpf/bpf.h" : YES
> > Checking for function "xsk_socket__create_shared" with dependencies
> > libxdp, libbpf: YES
> > Checking for function "bpf_object__next_program" with dependency libbpf:
> > YES
> > Checking for function "bpf_xdp_attach" with dependency libbpf: YES
> > Checking for function "xsk_socket__update_xskmap" with dependencies
> > libxdp, libbpf: YES
> > Message: drivers/net/af_xdp: Defining dependency "net_af_xdp"
> > Message: drivers/net/ark: Defining dependency "net_ark"
> > Message: drivers/net/atlantic: Defining dependency "net_atlantic"
> > Message: drivers/net/avp: Defining dependency "net_avp"
> > Message: drivers/net/axgbe: Defining dependency "net_axgbe"
> > Run-time dependency zlib found: YES 1.3.1
> > Message: drivers/net/bnx2x: Defining dependency "net_bnx2x"
> > Compiler for C supports arguments -DSUPPORT_CFA_HW_P70=3D1: YES
> > drivers/net/bnxt/tf_ulp/meson.build:41:3: ERROR: Option bnxt_tf_template
> > does not exist.
> > A full log can be found at
> > /home/shemminger/DPDK/main/build/meson-logs/meson-log.txt =20
>=20
> Hi Stephen,
>=20
> I noticed that one of the patches that update the meson build options was
> rejected. This is probably why the build fails. I=E2=80=99ll take a look =
to confirm.
>=20
> Thanks
>=20
> >
> > =20

This series should have never gone into the broadcom-next tree.
One of the roles of maintainer is to make sure local builds with all
flavors of compiler work before merging.
