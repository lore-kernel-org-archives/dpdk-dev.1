Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9531EDEBFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 01:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FEC04064E;
	Wed,  4 Mar 2026 02:49:52 +0100 (CET)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0F7D140269
 for <dev@dpdk.org>; Wed,  4 Mar 2026 02:49:51 +0100 (CET)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-797ab169454so62542217b3.3
 for <dev@dpdk.org>; Tue, 03 Mar 2026 17:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772588990; cv=none;
 d=google.com; s=arc-20240605;
 b=buctIQH25kLE+YmkLw/QhU27r/Ehp5nwGjCX+r3NGuIIsHeCucFGKn9DsZieHAjRXA
 bP+7P375PoAaw5K2L5VsLryfXQAOurei8H30VscRk2qTlgemjYCJopNJhTQpQTSN9hdI
 gcFvNhlTRCW518LaL+F+mXSlZKOsImInThPhTkYve8tEq26LrNi2/kQ9nDHxlyLboqqv
 OQC2/h+brieilEImTQSqZhmMXeMgolZBZTX8+HC3VU7TUD08V59JQl2qd3ycfy/AmG4t
 UUBLaSgDjAX4jUDRFx8e9/kIZsrGKAFAHPUFLqcs7h5I5+HEcoEjAaVZVzsxaU1sYwWL
 w6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=71okW460cI9XRDhBKuyRBvkd92hmrTAm9c+u5Y2IUNk=;
 fh=0E6rhHenMJTx7iCVaVeG4mOH4i93OFLcPVvmIeKwsk8=;
 b=JjMm5lLAGWniPKfANnnGL4eP2dBgtdZVWXRWhvsKunOlwP6T52WXyvvHBkYZYEcIil
 1iU2XHByWTaEKDWz3CG8FQcGXexWy8xhfLTjrV8OsAPYZZnK26xHy/FWjEtWoBi3Nxzr
 ykKNCcD35eBQamOjFEPR6aljZiMJ1MPaz6W4Mwu7xHygLJWQe42zixPsTfd8Q8yrNwTf
 uCVfF2Nx3RbOhc5oRvk5/ilIyTg57pAP20w5pPKwgXsClB4C3dNIf7N281qbLmoCdiF8
 UJTxXnEpvbC7Gyc9hL8j1jFJiiMBdDAGqLdm3T8/SVgsOiBEm/VicnOqWn7q0PSaYQ1A
 gs1g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772588990; x=1773193790; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=71okW460cI9XRDhBKuyRBvkd92hmrTAm9c+u5Y2IUNk=;
 b=FxxLMxt9l2iRYdvxtUeZ9CuvHxvK477WYLyr03vF17wIbs+ILR8MDpVjDjxGL6s4mn
 9cky9WMEfCtmJ/mhUp88eLvHvyuSHaI2onwHWMsiC9aH/j4B4O96OEAhEPZkcblR7G5f
 bzYH24OZY1EkcHkC6nKYVcKob84yGg3HKHCBzwm6Q3T+XMCVLJ5eCWb27H0rBbCqOxv6
 5JlcwKrTPKUUTDzYlSYwFwlHo/WCnaCVtBtSLdYiU6tnFl9ZsZhyYiKwNXr3cJmV7IUc
 +9KQxxphSaV+eZjbo83AxLwKA5QmDYQTvYm4nuPWwghNSFSePVMz78WIObWTdjI9TXuz
 yY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772588990; x=1773193790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71okW460cI9XRDhBKuyRBvkd92hmrTAm9c+u5Y2IUNk=;
 b=n0OIrmU3r9vyiXCYXBYXIDvgOfwIYaaCceiVVYzfN8rX3n1EjiFh6YanXDw0VnWw7N
 xLRI9MX5WnUxiWOHDLiZP6eJn9b3AFFmYAgW4/p+VE9qF8b6ptv6XIuh4GV0uYbssOFD
 A5qMRkA+aBaw2vN4Ck/XKYV7+9JGzbfDK7GstIr79GL4M+ErMB7Yp4JTciLKpXJHJ0j5
 HSTNlN/2Z1XTPmufg542l7TDtxmUleNOlgZw0tLIGqF7GT3dSmCESiJTIQKQXk7LA5IR
 GJ3/F/q99JFwjS7P917qa0IGQaI5bZsQ7/mSWSuYuet92eJ8E8OO9BcCzUV+K93wVRpx
 Fciw==
X-Gm-Message-State: AOJu0YzMKQGeOU7kJI7HOFQByQ5QmVyPb3cFYAuyyN4LSJmQo3YD6KBp
 aTyTESDH1kloKlAIMosiXKbarox6ONvfo/hEimqeu7oi5WnqUU1ZfOg2Ro4e6kg2dkz4Jh6BZ20
 /+Smt4dwJVshl/DmgNlOqkhgbieZlTLy4cW19S8ur
X-Gm-Gg: ATEYQzwkCjhrns2GCwJwIRKfXirseJ2CfrTaJ7DMMQKAN0u2ZVeQ/39jWoeasuWOdKY
 PkYqdgclABCxqZ7D4jo1zEeSTnnsdVMOZq4KHz0cPEtr4ElxfogzNl0WaeRSUYk78DZEvJv0xgb
 CkszloI4Nz9pkD0cuo3Sk5KenlgBwT6liwScyql6/k7wzIo+2XKSsiPTzzPz3vsKDkUa1llPoTq
 CqzcY2zn/mrz7Wf2Ka1vdrzV9FU9aIWKP0L8QyMftOoRCdm+/ljj1sY6sYBVnUhcDfsbpt/eJDU
 0Ny2FXQzuo74/ezOhZtTxkifUzJz18RZHF8XBRIC
X-Received: by 2002:a05:690c:6a06:b0:798:65eb:afeb with SMTP id
 00721157ae682-798c6bb20d4mr3543277b3.6.1772588989840; Tue, 03 Mar 2026
 17:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
 <20260303005804.924545-1-jtranoleary@google.com>
 <20260303072116.37d58a4f@phoenix.local>
In-Reply-To: <20260303072116.37d58a4f@phoenix.local>
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
Date: Tue, 3 Mar 2026 17:49:39 -0800
X-Gm-Features: AaiRm52rUN7cDerzOhwqsRUwHBvm5AUEiFen3pKhNh1hZ96_XB5ioOOPmrCKjUg
Message-ID: <CAAESxLLMDjy4EeTd50A3j2pW8QR04vGgjJWnsotxrDsdf2uA6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net/gve: add flow steering support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: multipart/alternative; boundary="00000000000013581e064c2909ba"
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

--00000000000013581e064c2909ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for these notes. I submitted a v3 with the following changes.

1. Fixed bit allocation in the flow rule bitmap using the suggestion given.
2. Changed rte_zmalloc/rte_free for struct gve_flow to calloc/free. In
making this change, I realized that the driver currently would not support
flow operations from secondary processes, so I made a note of that in
gve.rst.
3. Changed both verbs to "added" to match the notes from other drivers.

On Tue, Mar 3, 2026 at 7:21=E2=80=AFAM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> On Tue,  3 Mar 2026 00:58:00 +0000
> "Jasper Tran O'Leary" <jtranoleary@google.com> wrote:
>
> > This patch series adds flow steering support to the Google Virtual
> > Ethernet (gve) driver. This functionality allows traffic to be directed
> > to specific receive queues based on user-specified flow patterns.
> >
> > The series includes foundational support for extended admin queue
> > commands needed to handle flow rules, the specific adminqueue commands
> > for flow rule management, and the integration with the DPDK rte_flow
> > API. The series adds support flow matching on the following protocols:
> > IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.
> >
> > Patch Overview:
> >
> > 1. "net/gve: add flow steering device option" checks for and enables
> >    the flow steering capability in the device options during
> >    initialization.
> > 2. "net/gve: introduce extended adminq command" adds infrastructure
> >    for sending extended admin queue commands. These commands use a
> >    flexible buffer descriptor format required for flow rule management.
> > 3. "net/gve: add adminq commands for flow steering" implements the
> >    specific admin queue commands to add and remove flow rules on the
> >    device, including handling of rule IDs and parameters.
> > 4. "net/gve: add rte flow API integration" exposes the flow steering
> >    functionality via the DPDK rte_flow API. This includes strict
> >    pattern validation, rule parsing, and lifecycle management (create,
> >    destroy, flush). It ensures thread-safe access to the flow subsystem
> >    and proper resource cleanup during device reset.
> >
> > Jasper Tran O'Leary (2):
> >   net/gve: add adminq commands for flow steering
> >   net/gve: add rte flow API integration
> >
> > Vee Agarwal (2):
> >   net/gve: add flow steering device option
> >   net/gve: introduce extended adminq command
> >
> >  doc/guides/nics/features/gve.ini       |  12 +
> >  doc/guides/nics/gve.rst                |  26 +
> >  doc/guides/rel_notes/release_26_03.rst |   1 +
> >  drivers/net/gve/base/gve.h             |   3 +-
> >  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
> >  drivers/net/gve/base/gve_adminq.h      |  57 +++
> >  drivers/net/gve/gve_ethdev.c           |  83 +++-
> >  drivers/net/gve/gve_ethdev.h           |  46 ++
> >  drivers/net/gve/gve_flow_rule.c        | 656 +++++++++++++++++++++++++
> >  drivers/net/gve/gve_flow_rule.h        |  65 +++
> >  drivers/net/gve/meson.build            |   1 +
> >  11 files changed, 1063 insertions(+), 5 deletions(-)
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
> >
>
> Automated review spotted a few things:
>
> 1. rte_bitmap_scan usage is incorrect.
> 2. Using rte_malloc where not necessary
> 3. Grammar in the release note.
>
> I can fix the last one when merging, the second one is not a big issue
> but would be good to have.
>
> ---
>
>
> Error: Incorrect rte_bitmap_scan usage =E2=80=94 wrong rule ID allocation=
 (~85%
> confidence)
>
> In gve_create_flow_rule():
> c
>
> uint64_t bmp_slab __rte_unused;
> ...
> if (rte_bitmap_scan(priv->avail_flow_rule_bmp, &flow->rule_id,
>         &bmp_slab) =3D=3D 1) {
>     rte_bitmap_clear(priv->avail_flow_rule_bmp, flow->rule_id);
> }
>
> rte_bitmap_scan() writes the slab base position to pos and the slab bit
> pattern to slab. The actual bit position of the first available rule is p=
os
> + __builtin_ctzll(slab), not pos alone. The __rte_unused annotation on
> bmp_slab confirms the slab value is being ignored entirely.
>
> After the first rule allocation clears bit 0, a subsequent scan returns
> the same slab base (pos=3D0) with bit 0 now clear in the slab. The code w=
ould
> again set rule_id=3D0 and attempt to clear an already-clear bit, then try=
 to
> create a duplicate rule on the device.
>
> Suggested fix:
> c
>
> uint64_t bmp_slab;
> uint32_t pos;
> ...
> if (rte_bitmap_scan(priv->avail_flow_rule_bmp, &pos,
>         &bmp_slab) =3D=3D 1) {
>     flow->rule_id =3D pos + __builtin_ctzll(bmp_slab);
>     rte_bitmap_clear(priv->avail_flow_rule_bmp, flow->rule_id);
> }
>
> Warning: rte_zmalloc used for ordinary control structures
>
> Both avail_flow_rule_bmp_mem and individual gve_flow structures are
> allocated with rte_zmalloc, but they don't require DMA access, NUMA
> placement, or multi-process shared memory. Standard calloc/malloc would b=
e
> more appropriate and wouldn't consume limited hugepage resources.
>
> Warning: Release notes tense inconsistency
> rst
>
> * Added application-initiated device reset.
> + * Add support for receive flow steering.
>
> "Added" (past tense) vs "Add" (imperative). Both entries should use the
> same tense for consistency. The DPDK convention is imperative mood.
>
>

--00000000000013581e064c2909ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for these notes. I submitted a v3 with the follo=
wing changes.<div><br></div><div>1. Fixed bit allocation in the flow rule b=
itmap using the suggestion given.</div><div>2. Changed rte_zmalloc/rte_free=
 for struct gve_flow to calloc/free. In making this change, I realized that=
 the driver currently would not support flow operations from secondary proc=
esses, so I made a note of that in gve.rst.</div><div>3. Changed both verbs=
 to &quot;added&quot; to match the notes from other drivers.<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Mar 3, 2026 at 7:21=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:s=
tephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
ue,=C2=A0 3 Mar 2026 00:58:00 +0000<br>
&quot;Jasper Tran O&#39;Leary&quot; &lt;<a href=3D"mailto:jtranoleary@googl=
e.com" target=3D"_blank">jtranoleary@google.com</a>&gt; wrote:<br>
<br>
&gt; This patch series adds flow steering support to the Google Virtual<br>
&gt; Ethernet (gve) driver. This functionality allows traffic to be directe=
d<br>
&gt; to specific receive queues based on user-specified flow patterns.<br>
&gt; <br>
&gt; The series includes foundational support for extended admin queue<br>
&gt; commands needed to handle flow rules, the specific adminqueue commands=
<br>
&gt; for flow rule management, and the integration with the DPDK rte_flow<b=
r>
&gt; API. The series adds support flow matching on the following protocols:=
<br>
&gt; IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.<br>
&gt; <br>
&gt; Patch Overview:<br>
&gt; <br>
&gt; 1. &quot;net/gve: add flow steering device option&quot; checks for and=
 enables<br>
&gt;=C2=A0 =C2=A0 the flow steering capability in the device options during=
<br>
&gt;=C2=A0 =C2=A0 initialization.<br>
&gt; 2. &quot;net/gve: introduce extended adminq command&quot; adds infrast=
ructure<br>
&gt;=C2=A0 =C2=A0 for sending extended admin queue commands. These commands=
 use a<br>
&gt;=C2=A0 =C2=A0 flexible buffer descriptor format required for flow rule =
management.<br>
&gt; 3. &quot;net/gve: add adminq commands for flow steering&quot; implemen=
ts the<br>
&gt;=C2=A0 =C2=A0 specific admin queue commands to add and remove flow rule=
s on the<br>
&gt;=C2=A0 =C2=A0 device, including handling of rule IDs and parameters.<br=
>
&gt; 4. &quot;net/gve: add rte flow API integration&quot; exposes the flow =
steering<br>
&gt;=C2=A0 =C2=A0 functionality via the DPDK rte_flow API. This includes st=
rict<br>
&gt;=C2=A0 =C2=A0 pattern validation, rule parsing, and lifecycle managemen=
t (create,<br>
&gt;=C2=A0 =C2=A0 destroy, flush). It ensures thread-safe access to the flo=
w subsystem<br>
&gt;=C2=A0 =C2=A0 and proper resource cleanup during device reset.<br>
&gt; <br>
&gt; Jasper Tran O&#39;Leary (2):<br>
&gt;=C2=A0 =C2=A0net/gve: add adminq commands for flow steering<br>
&gt;=C2=A0 =C2=A0net/gve: add rte flow API integration<br>
&gt; <br>
&gt; Vee Agarwal (2):<br>
&gt;=C2=A0 =C2=A0net/gve: add flow steering device option<br>
&gt;=C2=A0 =C2=A0net/gve: introduce extended adminq command<br>
&gt; <br>
&gt;=C2=A0 doc/guides/nics/features/gve.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 12 +<br>
&gt;=C2=A0 doc/guides/nics/gve.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 26 +<br>
&gt;=C2=A0 doc/guides/rel_notes/release_26_03.rst |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/net/gve/base/gve.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 drivers/net/gve/base/gve_adminq.c=C2=A0 =C2=A0 =C2=A0 | 118 ++++=
-<br>
&gt;=C2=A0 drivers/net/gve/base/gve_adminq.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 57=
 +++<br>
&gt;=C2=A0 drivers/net/gve/gve_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 83 +++-<br>
&gt;=C2=A0 drivers/net/gve/gve_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 46 ++<br>
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 656=
 +++++++++++++++++++++++++<br>
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 65 +++<br>
&gt;=C2=A0 drivers/net/gve/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 11 files changed, 1063 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h<br>
&gt; <br>
<br>
Automated review spotted a few things:<br>
<br>
1. rte_bitmap_scan usage is incorrect.<br>
2. Using rte_malloc where not necessary<br>
3. Grammar in the release note.<br>
<br>
I can fix the last one when merging, the second one is not a big issue<br>
but would be good to have.<br>
<br>
---<br>
<br>
<br>
Error: Incorrect rte_bitmap_scan usage =E2=80=94 wrong rule ID allocation (=
~85% confidence)<br>
<br>
In gve_create_flow_rule():<br>
c<br>
<br>
uint64_t bmp_slab __rte_unused;<br>
...<br>
if (rte_bitmap_scan(priv-&gt;avail_flow_rule_bmp, &amp;flow-&gt;rule_id,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bmp_slab) =3D=3D 1) {<br>
=C2=A0 =C2=A0 rte_bitmap_clear(priv-&gt;avail_flow_rule_bmp, flow-&gt;rule_=
id);<br>
}<br>
<br>
rte_bitmap_scan() writes the slab base position to pos and the slab bit pat=
tern to slab. The actual bit position of the first available rule is pos + =
__builtin_ctzll(slab), not pos alone. The __rte_unused annotation on bmp_sl=
ab confirms the slab value is being ignored entirely.<br>
<br>
After the first rule allocation clears bit 0, a subsequent scan returns the=
 same slab base (pos=3D0) with bit 0 now clear in the slab. The code would =
again set rule_id=3D0 and attempt to clear an already-clear bit, then try t=
o create a duplicate rule on the device.<br>
<br>
Suggested fix:<br>
c<br>
<br>
uint64_t bmp_slab;<br>
uint32_t pos;<br>
...<br>
if (rte_bitmap_scan(priv-&gt;avail_flow_rule_bmp, &amp;pos,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bmp_slab) =3D=3D 1) {<br>
=C2=A0 =C2=A0 flow-&gt;rule_id =3D pos + __builtin_ctzll(bmp_slab);<br>
=C2=A0 =C2=A0 rte_bitmap_clear(priv-&gt;avail_flow_rule_bmp, flow-&gt;rule_=
id);<br>
}<br>
<br>
Warning: rte_zmalloc used for ordinary control structures<br>
<br>
Both avail_flow_rule_bmp_mem and individual gve_flow structures are allocat=
ed with rte_zmalloc, but they don&#39;t require DMA access, NUMA placement,=
 or multi-process shared memory. Standard calloc/malloc would be more appro=
priate and wouldn&#39;t consume limited hugepage resources.<br>
<br>
Warning: Release notes tense inconsistency<br>
rst<br>
<br>
* Added application-initiated device reset.<br>
+ * Add support for receive flow steering.<br>
<br>
&quot;Added&quot; (past tense) vs &quot;Add&quot; (imperative). Both entrie=
s should use the same tense for consistency. The DPDK convention is imperat=
ive mood.<br>
<br>
</blockquote></div>

--00000000000013581e064c2909ba--
