Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0EBCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 07:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169EF4028C;
	Tue,  4 Nov 2025 08:43:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7B10740285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 08:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762242231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HClmUDVZfMLLxLuJ+rMcBBh6+aN3qcp117WFrYeNHmk=;
 b=Bx0eDf+iA9nRnOOJd2XKcVXcTqm4Vwsl2jZYMzvb3SwwiM656QdcOS5POg95GYpBtvboKk
 /nN1Ffr0MFFd0kSv+Q0tgpn5ZGP6fwi5Ye4DFFTp5x7wxTeMnYS0dP/V+gSupaCVQM5Viv
 fKKbCrtuH0yOlDY95JRfrUo7NnYTc9c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-SLzXT6rbMSKF-r9tscQipA-1; Tue, 04 Nov 2025 02:43:49 -0500
X-MC-Unique: SLzXT6rbMSKF-r9tscQipA-1
X-Mimecast-MFC-AGG-ID: SLzXT6rbMSKF-r9tscQipA_1762242228
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-37a35d16347so11832231fa.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762242228; x=1762847028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HClmUDVZfMLLxLuJ+rMcBBh6+aN3qcp117WFrYeNHmk=;
 b=suok1UKbIgVNUK/TuoedbWBpmy0GswCEAh72CMpwepZcAo4yN8ggP5Klzt52Q1W6G3
 pGBheO3jaKzPGsvCVrTmW1LfsdusK8OA0DuFqEACQ4RcBHEyHcGjkBdjcmtdzQDvELqX
 0LYTe5ZRQd0fRCg6mlygHFzZNCno4w4uLx2rSwNac3OdthKoGvwnkeY0p7LFYXgK2H+t
 l1FE2Fg64exCm/feWiwj6qbovJCl3tnblRRvmpmrkgByvBPsRGY0CVlp+VgYxLxSKahi
 z6k0J/rwLcIYGue9O3CORlCugjPHFIs8r8SbPGqog0bs88jRuEU/eqmp5GW4BNpbprKP
 Xr+g==
X-Gm-Message-State: AOJu0YwllbNEgrWc01iVqquRpoXyzrjBU/3sbbC0jywkigMssORZQb7S
 KzfUJ7Y8MBVzOQHscEG/l41CQZlOpid+gw/UO+u6YXy/J5pH1RTSw5aUNB39FCmvZDbVP5V98y3
 T6Mw1DlazHlwCEYHaO98KznyVXrxHosOrOU/LX5usjCYgJnuP19zewsqoWDaHp6kl6UfqTT2Wcu
 +daHq151sf+KKdSkDT9f0=
X-Gm-Gg: ASbGncsqIHHd7DsH/VnW/WoQQePl28cMYWcEu5v/nyZAadqGNuP59Or79TU02KTfOpI
 A5/okNT+amus3bVVDTvGrYjXSRugH8HcPMKGde5+wKSmocJghuPC7zXWxOfmMke/3LfE5oqEY1h
 HS5uwsG4G65CRZ3zFHgwLc5VR6EvUNv17UWjpyEzvkIiamDG/xttuVtBLjjQ==
X-Received: by 2002:a05:651c:1502:b0:37a:3720:c93d with SMTP id
 38308e7fff4ca-37a3720cd16mr16837021fa.45.1762242228070; 
 Mon, 03 Nov 2025 23:43:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL5XJvCmiFXD6f8+AdfucFXgNtuvdlphlFE7xEnSBsFQfyrIKb25CWKoWu7qoxxNuLWdGGC3yR2XEip5fgrv4=
X-Received: by 2002:a05:651c:1502:b0:37a:3720:c93d with SMTP id
 38308e7fff4ca-37a3720cd16mr16836911fa.45.1762242227597; Mon, 03 Nov 2025
 23:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20251031131159.1199221-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65523@smartserver.smartshare.dk>
 <CAJFAV8xfDUuAt_aC0rzi6pJ+7YXWfEBejx3MJB6Szi28+bZU5g@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65524@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65524@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 08:43:36 +0100
X-Gm-Features: AWmQ_bkilR9y5ZgFfNOLaXs2Z17E8x1C3wzpACVtHfR3g78eQXWvZWAhlPd6Ie8
Message-ID: <CAJFAV8yt8WmGnqBBe7Ay87iWLmfG5aO1MMS5RSwrSh2b_xOJ7A@mail.gmail.com>
Subject: Re: [PATCH] mbuf: dump Tx offload metadata
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9KmEnOSoCl9np0P_xIxZ-gGLssLMKq5SAqJYX6H7c38_1762242228
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

On Fri, 31 Oct 2025 at 15:29, Morten Br=C3=B8rup <mb@smartsharesystems.com>=
 wrote:
>
> > From: David Marchand [mailto:david.marchand@redhat.com]
> > Sent: Friday, 31 October 2025 15.08
> >
> > On Fri, 31 Oct 2025 at 14:28, Morten Br=C3=B8rup <mb@smartsharesystems.=
com>
> > wrote:
> > > Printing of outer_l2_len and outer_l3_len could be omitted if not
> > present, like the VLAN IDs, e.g.:
> > >
> > > fprintf(f, "  ");
> > > if (m->outer_l2_len !=3D 0)
> > >         fprintf(f, "outer_l2_len=3D%u, ", m->outer_l2_len);
> > > if (m->outer_l3_len !=3D 0)
> > >         fprintf(f, "outer_l3_len=3D%u, ", m->outer_l3_len);
> > > fprintf(f, "l2_len=3D%u, l3_len=3D%u, l4_len=3D%u, tso_segsz=3D%u\n",
> > >         m->l2_len, m->l3_len, m->l4_len, m->tso_segsz);
> >
> > Mm, why specifically those two only?
> > If the intention is to make this debug output shorter, I would apply
> > the same to all those fields, and omit the whole (new) line if no
> > field is set.
>
> The intention is not do make the output shorter, but to reduce the amount=
 of "noise" (useless data) in the output.
> My suggestion omits noise for non-tunneled packets.
>
> Maybe tso_segsz could be conditional on non-zero too.
>
> It depends on what the user/developer is debugging, whether l2/l3/l4_len =
are considered noise. I don't object to making them conditional too, if you=
 prefer.
>
> Anyway, I just realized that the tx_offload field is not cleared on RX, s=
o the discussed zero-check is useless (checking uninitialized data) when du=
mping an mbuf at an early stage in the application's packet processing pipe=
line.
> I have an idea to get around this... The TX flags in ol_flags are cleared=
 at RX, so we can consider tx_offload uninitialized until one of the TX fla=
gs in ol_flags has been set.

LGTM, it is stated that those fields are for Tx offloads.
I'll post a v2.


--=20
David Marchand

