Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97ACEFCE4D
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 22:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E9D402EB;
	Wed,  4 Mar 2026 23:43:45 +0100 (CET)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id D9161402E7
 for <dev@dpdk.org>; Wed,  4 Mar 2026 23:43:43 +0100 (CET)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-79801df3e21so68492007b3.2
 for <dev@dpdk.org>; Wed, 04 Mar 2026 14:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772664223; cv=none;
 d=google.com; s=arc-20240605;
 b=VLsTi41V4r3+C1OxOEiIdPyp7+qlOnv1fvvPG26J4vCEUsyZF56jSNrnRshe+OLEOW
 HlAsfxDVWOKkF+KdzviV+SIUlqA7BEDmeSVkTPsfOPJ4a+slV63v5gNbdaa9j4XeU81V
 mb8uJ7zznspjqpnE0jmsBwYadb6rLRkcLeofgE0PWlqzAE6yOfLrrG87ux5LPSwnljsh
 dY6wufzZTzWLW62EAsAj+FkgJ5fn1G8tRJ/zohASXmJZosWImEcFPSqPKlDBumyELfPB
 14awO5ogrXEii9S7+SisyN4mIoTud9u6SBxmps3UH8+0q0opcx+fjVBPlSxw5EDpzLJT
 mJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y86aGYOoDdYs7l3y7k7Td3Tn5UDqfJIsNkEEnwIFbB0=;
 fh=0E6rhHenMJTx7iCVaVeG4mOH4i93OFLcPVvmIeKwsk8=;
 b=C8gGwXcMBK+DFlS53wQ5SFva6KrN4iSEJYyYaaKljeV1fSLEs5DwYr3FRsyuwkR+Nr
 MNc5+1BjWQT3iNsSjIO/8TgBzvqh3UracQwQo7sKOtTn2WJOMtab9Gaee3XrKbvJuN7Y
 4S9pYmaAOAat+cvdychWkcWmy2agNc8juf3fVuMsMb1MSvX90CqwMe3GlfMlChHJCN0P
 2UNOKxvCz6ddrIlWERSUKbw7yiR11PEXT85pxxmy3jbrE5ITWFPLYso+wyFNGF37pFfA
 O8U01O8UYm5kpuAx6G8L1DlB+fNAGKQvrTsZFDL6blOIDStvdoKOuoTEe4vcZULcj3Sg
 NQ9g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772664223; x=1773269023; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y86aGYOoDdYs7l3y7k7Td3Tn5UDqfJIsNkEEnwIFbB0=;
 b=o0krWbSnFT6FqL292Xqp2msK5OU3iJlRnPq6a33IOo0qfwXTk+4glhkV+1Jw3kHeUM
 yQzwqrycmEAGl5ayHD6x2FWwKhIRHJGYR5HA1drCbuTOm/XWhh0pGTA9HvoJYjX26egq
 EsgfFLt7QAW/a6uxpBcpd+ewgM36hUd401j4UKfEMOrqyyBYqAiSjI+rne1UEo4r9vpQ
 xSXyFfOAbdhF+47v90JWk4zwvnSz0Mq08oU4l2ZgU1VbPLDxJY3+nVhqPgaH0faLyb8+
 MEwi3ncyqVa2w7VHPeU2Smx9jg2a9vjxtVq0NS5XwgvBfkNowqZK5lwFkZCv7tJ7uqYu
 0vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772664223; x=1773269023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y86aGYOoDdYs7l3y7k7Td3Tn5UDqfJIsNkEEnwIFbB0=;
 b=aT5mDcs45gQ6gf0jGTjjR97nwl/GnMWYryhqUWLI29Rab66Ij2Xj2lgrVYoklKj4K+
 fTNm2Wr6YqVADP6mIpt6tQ7zwp0L+nZCP+Zq75Dy/iF4m82Qc5gV1KrhPuc4YWxXozB8
 Z5MfGuvBwbpkCYYMW1nWcZ0IVOaHJS5Y834rpgz7I6ZpZKrb9SnhCC/6IZ0f05Ffi875
 4s1fWsabuXJQOH1GSdIZLC5dcqOw6ZbS7el3vJIUbG/x103C3iDeMi4wNToHD3T6ggg9
 sZBGwNSJaAlEJ2n0ce02/1tzYdYbGRAZ4qXMSgUUF/iAWM1Ba/gd5MZFd7IMh5sHp0y8
 22fQ==
X-Gm-Message-State: AOJu0Ywpuu+pnlIO4N1Q2iUj/h1Y5qqY1F9vbwC+tXYxwMVNNZirZt6q
 QdLt+mPvqm1YTdCTu7EMIwXdmMfcqkA53nJVg6n8Yl6yP22SDhcWk2cHTOJ9YT75n7O85/fJnt+
 y0A8vE1CEcPDgoGD5xu/lCfXHJ/N+9MmD/dxtT7GN
X-Gm-Gg: ATEYQzwoN7aCeBZPaQUJcLkJUyKr9tPPYHouJPjX5c2sF4JY1WRdWqLM84JsvpI/fkm
 +fn1iDIuBj2sD8llcBY1lNDpTCjJTY68cFSlRlK6STvjTD86NYQpeavdnIh/gJwTqnwXiI/Fy1p
 rsrzkDvBx+u0JatAxM9+4T6l6FbhN4VFzlJHGom5t6dXEgkoKXclU/FB73v+tbOSUyQu5UAVce+
 KYd38O61zpA0oGVH8aDBTAdrQCpg3/vFWnYF80ITceM2Tzkt5UZ/7Ty6CW3T5FZfI/KKzShKYJR
 Bsb8tVExlsnpk+ipzGCLMFHuBur8wG2y1POiqS1pUBuHWiw9
X-Received: by 2002:a05:690c:c512:b0:798:54d9:7f9b with SMTP id
 00721157ae682-798c6c01a7cmr30497037b3.20.1772664222665; Wed, 04 Mar 2026
 14:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20260304014624.1297874-1-jtranoleary@google.com>
 <20260304045033.1340269-1-jtranoleary@google.com>
 <20260304075949.07e75d93@phoenix.local>
In-Reply-To: <20260304075949.07e75d93@phoenix.local>
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
Date: Wed, 4 Mar 2026 14:43:31 -0800
X-Gm-Features: AaiRm528K0vZNj8B7P2fjdl09sEIEXxRRSwQmTgdOitsCUqQXiaXoI6nPWDUPaI
Message-ID: <CAAESxLL2V79rDSVYqDtdVONCTyHBDqzUOhrko=tdJuaJnMc+jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] net/gve: add flow steering support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: multipart/alternative; boundary="0000000000004d563a064c3a8d63"
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

--0000000000004d563a064c3a8d63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, I will address the additional patch 3/4 and patch 4/4 comments
in a future cleanup patch.

On Wed, Mar 4, 2026 at 7:59=E2=80=AFAM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> On Wed,  4 Mar 2026 04:50:29 +0000
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
> >  doc/guides/nics/gve.rst                |  27 +
> >  doc/guides/rel_notes/release_26_03.rst |   1 +
> >  drivers/net/gve/base/gve.h             |   3 +-
> >  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
> >  drivers/net/gve/base/gve_adminq.h      |  57 +++
> >  drivers/net/gve/gve_ethdev.c           |  83 +++-
> >  drivers/net/gve/gve_ethdev.h           |  46 ++
> >  drivers/net/gve/gve_flow_rule.c        | 658 +++++++++++++++++++++++++
> >  drivers/net/gve/gve_flow_rule.h        |  65 +++
> >  drivers/net/gve/meson.build            |   1 +
> >  11 files changed, 1066 insertions(+), 5 deletions(-)
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
> >
>
>
> Applied to next-net
>
> The detailed review report if you are interested.
>
> Reviewed the v4 series. Overall this is well-structured =E2=80=94 locking
> discipline is sound, create/destroy/flush paths handle errors
> correctly with proper resource cleanup, and the bitmap slot is
> restored on adminq failure. Patches 1/4 and 2/4 are clean.
>
> A few items on 3/4 and 4/4:
>
> Patch 3/4:
>
>   [Warning] struct gve_flow_spec has a padding hole after the
>   tos/tclass u8 field (37 bytes of data, padded to 40 by the
>   compiler). Callers zero-initialize today so no live bug, but
>   consider adding GVE_CHECK_STRUCT_LEN for gve_flow_spec and
>   gve_flow_rule_params to guard against future changes, consistent
>   with other adminq structures.
>
> Patch 4/4:
>
>   [Warning] In gve_setup_flow_subsystem, the rte_zmalloc failure
>   path does goto free_flow_rule_bmp which calls
>   gve_flow_free_bmp(priv). This is safe (rte_free(NULL) is a
>   no-op) but misleading =E2=80=94 the label says "free" when there's
>   nothing to free. Cleaner to just return -ENOMEM directly on the
>   first failure.
>
>   [Warning] gve_dev_reset tears down the flow subsystem and
>   re-initializes via gve_init_priv, but does not destroy/recreate
>   flow_rule_lock. This works today because
>   gve_teardown_flow_subsystem doesn't destroy the mutex (only
>   gve_dev_close does), but it's worth a comment to document this
>   invariant.
>

--0000000000004d563a064c3a8d63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you, I will address the additional patch 3/4 and pat=
ch 4/4 comments in a future cleanup patch.</div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar=
 4, 2026 at 7:59=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:stephen=
@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Wed,=C2=A0 4 Mar 2026 04:=
50:29 +0000<br>
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
 =C2=A0 =C2=A0 |=C2=A0 27 +<br>
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
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 658=
 +++++++++++++++++++++++++<br>
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 65 +++<br>
&gt;=C2=A0 drivers/net/gve/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 11 files changed, 1066 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h<br>
&gt; <br>
<br>
<br>
Applied to next-net<br>
<br>
The detailed review report if you are interested.<br>
<br>
Reviewed the v4 series. Overall this is well-structured =E2=80=94 locking<b=
r>
discipline is sound, create/destroy/flush paths handle errors<br>
correctly with proper resource cleanup, and the bitmap slot is<br>
restored on adminq failure. Patches 1/4 and 2/4 are clean.<br>
<br>
A few items on 3/4 and 4/4:<br>
<br>
Patch 3/4:<br>
<br>
=C2=A0 [Warning] struct gve_flow_spec has a padding hole after the<br>
=C2=A0 tos/tclass u8 field (37 bytes of data, padded to 40 by the<br>
=C2=A0 compiler). Callers zero-initialize today so no live bug, but<br>
=C2=A0 consider adding GVE_CHECK_STRUCT_LEN for gve_flow_spec and<br>
=C2=A0 gve_flow_rule_params to guard against future changes, consistent<br>
=C2=A0 with other adminq structures.<br>
<br>
Patch 4/4:<br>
<br>
=C2=A0 [Warning] In gve_setup_flow_subsystem, the rte_zmalloc failure<br>
=C2=A0 path does goto free_flow_rule_bmp which calls<br>
=C2=A0 gve_flow_free_bmp(priv). This is safe (rte_free(NULL) is a<br>
=C2=A0 no-op) but misleading =E2=80=94 the label says &quot;free&quot; when=
 there&#39;s<br>
=C2=A0 nothing to free. Cleaner to just return -ENOMEM directly on the<br>
=C2=A0 first failure.<br>
<br>
=C2=A0 [Warning] gve_dev_reset tears down the flow subsystem and<br>
=C2=A0 re-initializes via gve_init_priv, but does not destroy/recreate<br>
=C2=A0 flow_rule_lock. This works today because<br>
=C2=A0 gve_teardown_flow_subsystem doesn&#39;t destroy the mutex (only<br>
=C2=A0 gve_dev_close does), but it&#39;s worth a comment to document this<b=
r>
=C2=A0 invariant.<br>
</blockquote></div>

--0000000000004d563a064c3a8d63--
