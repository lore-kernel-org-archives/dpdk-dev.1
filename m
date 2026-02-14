Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C962CEF99E1
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 04:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92587402C0;
	Sat, 14 Feb 2026 05:35:28 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id D514840151
 for <dev@dpdk.org>; Sat, 14 Feb 2026 05:35:27 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2560076f8f.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771043727;
 x=1771648527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqahz/cp/2kTRcWgpZGwcpyweSbGiyZibvuIpziiqJg=;
 b=L0KO+uois33EgZhuGSvpd/CopzZFEb4p9u5eTw7ccL0lADThYNiiwuCaFyhhI31YPV
 4GOVDqC+53Z+qSNpeui9yOTtuLgXPS4zfXaGWnk80MaMqn+IEREk7QEpNQC+g2jJrM3l
 nOXr1NDzfbs5JIHmlLWe5NYY18WIbXpG3UaSkUcFOPDGEsKhInnpsTB4NrBa1rpPgmC+
 gnJpRT0w2GEmRIB9R2ese/cSVikgFybBYs7U4ezMTkFfat5OYJ065tCxuTIlr8SRKIrJ
 AxUE4/c69/zZMGDNzeqQMcFI3yHZl4tZywuGPhsv+Ia5lMySe7sa0keU4c30nQ6sneQE
 lbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771043727; x=1771648527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqahz/cp/2kTRcWgpZGwcpyweSbGiyZibvuIpziiqJg=;
 b=fxYn/gtRLhj3p0H18EMKdTdpgyAPTvSoOQbDXuRI6dKZaDGK89+hTAVgUhzkqJVmhR
 0k57k56Nvyd6hVe4MsCj+I59tWIe2BynRJ+7uhvE80pLRG+Jla2ijS3KBGm1CE9n4H0G
 hsvKrl5G+C6KDKD+JbaeQyBJKlBgLQWYVnJPayBYY/xs0RdBiZR66/g6mE5ISnCQSjyg
 jojVX7/LXa3wm0IbqN+wMo8KGnxXkAeor1/Pq+nUADJHzkLH9dAU3KgpM+fiyo54lC/X
 6ffXZxjNZzqzt5zuz8EAGFigb6LMOYHWE1n4ejZ5HJL+5JUkZ3EfOxF69krujh0zRJDD
 2aEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4EH5pxrscLA6i2zgY3iA1lSW8BJf9b7tn6TGZa+MCYizCuL9PMmAU4CxELqQZCQMVRQ=@dpdk.org
X-Gm-Message-State: AOJu0Ywl1Mg/SOFZFm8n+bpwnJwWwGYS12yeha59md/c8wFS9XXc8yuq
 aUOnnTafzlFYCBaNJdV0p/CkTcICXVMHqbvBS/ITn42XnXbyCmVgge0+8oOmTuB6zQ4=
X-Gm-Gg: AZuq6aLxCXckBAcYaecdXvcLzKAuDysKud+LrDbCoOc6aTjQ0BvVZ0XOMugMkVd4iG8
 iwN7oNknmxk31Sht3bN7QUV9CyA8X07BdoePr8JhZ1/iXahLGCMqhAKOU0a9uP9ErsBIJZMrT7z
 P9A4P6QMLLDYC9wrAOoOHbxXD2xSuFXwmU8BRXj0VNH12BqczEuJ2KDd0GudQ1YjZkC0/z2In2n
 Rr5PY/hAoIieCsu1M6DZPf9Tq55nxLrWl/mdZZIu/1TaIkmfBPK8n140LnWBxsMy0bXWiWidiv+
 e2Uizgl0zTVXPcP5zHE/AEkMZdewEy0i+ejPn3uDm6r/7l+iMWPifdTxrD16xPS7xVv+mePEPPl
 9z5Zgnwwf3DrJy83GAmrfuHSLOH0Rks3BvhDKKamKa3FIV7Wt/4AKQZV5w3j2MF/ejbWtG2H76T
 9rG1z9FZnwP+ApA60zb3L66idh3JT3BEzdD+vxhoXI0BEkYxlMGanCanBdFuUn38qx
X-Received: by 2002:a05:600c:8183:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-48378d9ccc7mr35401805e9.9.1771043727072; 
 Fri, 13 Feb 2026 20:35:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm233444015e9.11.2026.02.13.20.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 20:35:26 -0800 (PST)
Date: Fri, 13 Feb 2026 20:35:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, Ori Kam
 <orika@nvidia.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260213203520.21935695@phoenix.local>
In-Reply-To: <CAPQRu6EAKR59BGgRFAr=eWuQr+=3z14+xdCkbZMvfhM5K8bN0A@mail.gmail.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local> <2762564.TLkxdtWsSY@thomas>
 <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
 <20260212164341.074639cd@phoenix.local>
 <CAPQRu6EAKR59BGgRFAr=eWuQr+=3z14+xdCkbZMvfhM5K8bN0A@mail.gmail.com>
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

On Fri, 13 Feb 2026 08:46:04 +0100
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:

> p=C3=A1 13. 2. 2026 v 1:43 odes=C3=ADlatel Stephen Hemminger <
> stephen@networkplumber.org> napsal: =20
>=20
> > On Fri, 6 Feb 2026 16:40:39 +0100
> > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
> > =20
> > > p=C3=A1 6. 2. 2026 v 15:02 odes=C3=ADlatel Thomas Monjalon
> > > <thomas@monjalon.net> napsal:
> > > =20
> > > > 04/02/2026 15:53, Stephen Hemminger: =20
> > > > > On Tue, 3 Feb 2026 09:34:26 +0100
> > > > > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
> > > > > =20
> > > > > > >
> > > > > > > The kernel version of checkpatch complains here. The DPDK
> > > > > > > shell =20
> > > > script =20
> > > > > > > seems to be set to ignore this but.
> > > > > > >
> > > > > > > WARNING: break is not useful after a return
> > > > > > > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > > > > > > +               return cmd_flow_parsed(out);
> > > > > > > +               break;
> > > > > > >
> > > > > > > Should I create a new patch set or just let it be at this
> > > > > > > =20
> > moment? =20
> > > > > > Lukas =20
> > > > >
> > > > >
> > > > > I am ok with it as is. =20
> > > >
> > > > Better to update.
> > > >
> > > > There are other warnings:
> > > >
> > > > WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring
> > > > over =20
> > strncpy =20
> > > > - see: https://github.com/KSPP/linux/issues/90
> > > > #13052 <https://github.com/KSPP/linux/issues/90#13052>: FILE:
> > > > lib/flow_parser/rte_flow_parser.c:12825:
> > > > +       strncpy(buf, str, len);
> > > >
> > > > and a lot of WARNING:LONG_LINE
> > > >
> > > > I can have a look after the decision. =20
> > > =20
> > > >
> > > > And on a more general note, I would have expected to ask the
> > > > opinion of rte_flow maintainers, but they are not Cc'ed in
> > > > these patches.=20
> > > I communicated primarily with Stephen, and will CC Ori too.
> > > Anyone else?
> > >
> > > =20
> > > > I'm a bit skeptical about adding this outside of ethdev library
> > > > which defines the flow API.
> > > > =20
> > >
> > > CCing Ori to make a decision. I don't mind putting it directly
> > > into =20
> > ethdev =20
> > > as well, I just thought the parser could be its own separate lib
> > > as it is just consuming strings and producing rte_flow
> > > structures. I can see the heavy ties to the flow library, though.
> > > Thomas, Stephen, what are your opinions? =20
> >
> > I am beginning to agree with Thomas, this belongs in the ethdev
> > directory next to rte_flow.
> >
> > Also, not sure what the purpose of parser_ops is. It says to pass
> > NULL, but test-pmd is doing something else. It would be better to
> > have an initializer (i.e RTE_INIT) instead? Maybe
> > =20
>=20
>=20
> Ok, I can move it there then. Should I proceed with Patch v11 - that
> would include moving the ethdev directory and addressing the kernel's
> checkpatch issues?
>=20
> The initializer doesn't seem like a bad idea. I didn't know about
> that one. The parser_ops are not needed for purely parsing, but to
> remain compatible with the testpmd's code, which is using, e.g., the
> hints on the commandline I added parser_ops.
> The simple public library API is for converting strings to rte_flow
> structures,
> the parser_ops is for hooking up the testpmd.


My response was more immediate (gut feel). But wanted more detailed
feedback.
I think you need to have a really simple API like the PCAP
does for compiling string into BPF. See pcap_compile.

The testpmd/cmdline method is creating too much baggage!

This is what the result of back-and-forth with Claude AI came to:

rte_flow_parser_ops =E2=80=94 Summary of Issues

64 callbacks, zero documentation. No Doxygen on any member. The only
way to understand the contract is to read testpmd's implementation =E2=80=94
making testpmd the de facto spec.

Inconsistent return types. 36 callbacks return int, 10 return void.
Similar operations use different conventions (e.g. flow_create returns
int, flow_tunnel_create returns void). No error reporting possible from
the void ones.

Testpmd internals leaked into the API. verbose_level_get is a UI
concern, not a parser concern. The void/int split mirrors whatever
testpmd's internal functions happened to use, not a designed interface.

No guidance on minimal implementation. "Unused callbacks may be NULL"
but which ones does the parser actually call during a basic flow
create? A new consumer can't tell without tracing the code.

ABI-fragile but installed as a header. Adding any new rte_flow command
means extending these structs. No versioning mechanism, yet it's in
indirect_headers so external code can (and will) use it.

681-entry command enum couples consumers to parser internals. Anyone
interpreting rte_flow_parser_output.command must understand the full
token namespace.

Bottom line: This is a testpmd function dispatch table promoted to a
library header without the design work to make it an external API.
Either don't install the private header, or invest in
documenting/versioning it properly.
