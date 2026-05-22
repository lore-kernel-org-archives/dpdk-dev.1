Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA4CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5D34065F;
	Fri, 22 May 2026 17:27:41 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id D38AD40616
 for <dev@dpdk.org>; Fri, 22 May 2026 17:27:39 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so16287411a12.2
 for <dev@dpdk.org>; Fri, 22 May 2026 08:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779463659; cv=none;
 d=google.com; s=arc-20240605;
 b=Lf4g+/o4HTHO8CBjUtjzcTLWHuidKY9CIupRncvzNkQByWCg3nfIO526GAUQKq4vE1
 PvNa2zyj92Xs2Qtfqtl2sKRl2vpehXIpdnNcSon5oy48i1CdBfHOZk7cxfMAJBvF8/KW
 SKGf2XF+vsXTQkJoOpdJi7r6tJpch3j/vD+op105n0wuANRq1qSxTo4OJQlKvhyQf3u8
 e3LvxYac50ATMZv8hHX0+6zwFCwqvtuT1oFyBwMtfnLlbbYeOJyjfFR95lZau/nuam6V
 FmzOyg8Bp20W94ZNs1wusrgAkrzTJAS5aoavPFDkiheP+z4u1E5QKVal9Py/PfR6ZNC8
 z9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=271SDu5mvlmMx4eIuNh4YJ5vXQ8G2F/N5VuUU/SFqG4=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=WPyw4pk6ioQytmrisT8YiQ26OPXKz93/o5+FdS/fb5J5GS+8dvYhB8mY2MZdMQIEmd
 Eh1estYnYJolEP2iBG7lII7pCsZOy9A+dbdD5OS47TCrGscBLEvrP/D7SAK05SZl+SNh
 WkURB9RVRbnSY/NuVJaAm4atfk8Vj9eQx6nPIMqaLA34DvR6bMsDfal1GbVg25vDX4df
 TzKuznLlUXP+48KgFwymNqJrmJ5Kracq6BFQFrei6LTmVWrKins7e2gVdsJrSzYoXhY6
 LZgMksdalQKNpTR6IABrssGk7RDbRawsE3lURV+8EY5wtS/TlFhNpTyVFuyAoxgJyEqq
 QmQw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1779463659; x=1780068459; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=271SDu5mvlmMx4eIuNh4YJ5vXQ8G2F/N5VuUU/SFqG4=;
 b=jdGJGpe0A2Fhg8G7yHRn9pX0Avp0TZN2UiKewCQBFIYmFzY3BFaQTOyEYfIjmpBt1S
 hDVPJjaTvO2ekevAka/TLI7oAafccrYLM3X0qjhSOMpWmyBNo9RZ7Ft3i6gW0VS+NkDg
 WZzSHG2p2jQKG6UWIBi/Q20n7/LL7m2mUCWvyQyqGrO6u/asrUbIAnRSmP7ixDjmCEse
 eLTzM6ZBhNAEzZ+rQ1RGyuGoQfUh9uL9vJICv5h6N81ML36s5e4czubFspvXS+LrtSuX
 ES3ZhDp2D/oLGhtohihNTy0OieYM7elK+9dHLvrXdGVDNH0345JNv14dG+sT1hC/W4Qt
 T+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779463659; x=1780068459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=271SDu5mvlmMx4eIuNh4YJ5vXQ8G2F/N5VuUU/SFqG4=;
 b=IgKKgooltKr6tG+Hmr6R1yq7BuiVI+kq2c3uTpFWzqSgvZFqH5q9EkaZKpRTXscD55
 F3LMXdmqFI5Iq2VkcUiq9Q4IERUak0NSfm5B6vWZEoivbVh+AM/6i0o/fedRR/gnV/e/
 zT0RrmF9u6csEzjxfnMs2TKIDNwgSPlvMIOU3OB4QbgnIyzyd9uO16Up1G9yaZKKNhMM
 YPtLAuPQ7NhsezMTA6hN2J1ISp8n+8QYjSu7aMeW7xTeqAEY0qtfUcGB9d2ZgzjLPe3K
 gzvjmQEuB/Y6TnKoQ0j7hmQPGVvFbHIhbGoreM87Ikjb2dg+ynQGusT4P2hvK0NWWmOZ
 h+eA==
X-Gm-Message-State: AOJu0Yx6XZWzv29dUR+UgWU/HZBP1xguzAmrOIOsD2jD9Run1OmJiEyv
 oEg61mfLUCYbzqayCjPHt9uSCKb98qdAVND1NiAQjyB3tak8nCKBT8MhtTqlBEy9kecqpnfjUSB
 p8sR7YU6iW5UOtXJsRKJ8zQn+T1qcofUH1iijw3G3Rgy9DxDo2Wt9c7g=
X-Gm-Gg: Acq92OEiLl6iQ27e8S0vLHUUlCeiWN9NmcbXoZs0f/vehBiYIcXs60mwnWT/GSwomL0
 8tS+jAvVgGNHvkfgtkIjHOMC6iqCuBK990FWaozjiRR/uVJn4UC21a+/MTTlrhRR9jCEnOLewqw
 q3lPpUhtiJTPFb9uHN18KHSqwIhjvgzslkdVzNstAjofHDZbnPiZF+lQx+cS4FGGuXGkyx59giw
 XJucTMRL4VHpjfncJT/zZoBaR8zffuTCqi6qCltg1IBRUlN2R9ouuqgd1Vh+sHaf7DbFNEXywgC
 1u2XQ7AodvPwmC9veA==
X-Received: by 2002:a05:6402:f09:b0:674:bf55:6f40 with SMTP id
 4fb4d7f45d1cf-6889cc602c1mr1578748a12.26.1779463659060; Fri, 22 May 2026
 08:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
In-Reply-To: <20260506033338.480610-1-stephen@networkplumber.org>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Fri, 22 May 2026 17:27:26 +0200
X-Gm-Features: AVHnY4IpSI0TWUzcPn3-3aj0p91nR3-yaCAthDkryxgKQ_K7DMam9pA9bhKCrO4
Message-ID: <CAPQRu6GMtF1B24vaOA1Er7j2iB5HpmCP9CAAcbj_T6FmXys6Eg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] flow_compile: textual flow rule compiler
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004a0f83065269ab8e"
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

--0000000000004a0f83065269ab8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 6. 5. 2026 v 5:33 odes=C3=ADlatel Stephen Hemminger <
stephen@networkplumber.org> napsal:

> Background
> ----------
>
> Multiple efforts over the past few cycles have tried to make
> testpmd's flow rule grammar reusable from outside testpmd.
> External applications that need rte_flow want a documented way
> to turn human-written rules into the rte_flow_attr/item/action
> arrays accepted by rte_flow_create().
>
> The most recent attempt is Lukas Sismis's series, currently at
> v12:
>
>   http://patches.dpdk.org/project/dpdk/list/?series=3D37384  (or
>   most recent thread on dev@dpdk.org)
>
> That series factors testpmd's existing cmdline_flow.c into a
> library and updates testpmd to consume it.  It works, but
> inherits two properties of cmdline_flow.c that I think are worth
> avoiding in a reusable library:
>
>   - Coupling to librte_cmdline.  Even after the v12 split into
>     a "simple" part and a "cmdline" part, the parser is still
>     organized around testpmd's command interpreter, and v12 has
>     cmdline depending on ethdev to break a previous circular
>     dependency.  A library used by daemons, control planes, or
>     unit tests should not need that.
>
>   - Ad-hoc grammar.  cmdline_flow.c implements parsing per-token
>     in long dispatch logic; the grammar emerges from the code
>     rather than being stated, and adding a new flow item
>     requires touching the parser.
>
> This RFC explores a different shape and is posted to ask the
> list which one is preferred before more work goes into either.
>
> So I started a new green field library for parsing flow rules
> (with the help of AI assistance). It is only a few hours old,
> but passes tests and passes review.
>
> This series
> -----------
>
> lib/flow_compile -- a small new library providing the same
> service via a pcap_compile()-style API:
>
>     char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];
>     struct rte_flow_compile *fc =3D rte_flow_compile(rule, errbuf);
>     if (fc =3D=3D NULL)
>             fail(errbuf);            /* "line:col: message" */
>
>     rte_flow_compile_create(port_id, fc, &flow_error);
>     rte_flow_compile_free(fc);
>
> Design properties:
>
>   - Hand-rolled lexer + recursive descent parser.  No flex/bison.
>   - Parser is driven entirely by descriptor tables of items and
>     actions.  Adding a new flow item is a table edit, not a
>     parser change.  A custom-setter hook on each field covers
>     the layouts that do not fit a plain byte range (bitfields,
>     indirect arrays).
>   - Dependencies: rte_ethdev and rte_net only.  No librte_cmdline,
>     no flex/bison.  Builds clean on Linux, FreeBSD, and Windows.
>   - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;
>     rte_flow_compile_free() walks the pattern and action arrays.
>     ASan/LSan run clean on the autotest.
>
> The grammar follows testpmd's syntax closely so familiar rules
> carry over:
>
>     ingress pattern eth / ipv4 src is 10.0.0.1 / end
>     actions queue index 3 / count / end
>
> and is documented as a formal BNF in the programmer's guide
> chapter (patch 2).
>
> Initial coverage: eth, vlan, ipv4, ipv6, tcp, udp, vxlan,
> port_id, port_representor, represented_port items; drop,
> passthru, queue, mark, jump, count, port_id and representor
> variants, of_pop_vlan, vxlan_decap actions.  Variable-conf
> items and actions (RSS, RAW) require custom setters and are
> deferred to a follow-up.
>
> What this RFC is *not*
> ----------------------
>
> Not a replacement for cmdline_flow.c in testpmd.  If the shape
> here is acceptable, the next step is a separate series adding a
> "flow compile <port> <rule>" command in testpmd alongside the
> existing parser, so users can adopt the library incrementally
> without breaking scripts that depend on the current syntax.
>
> What I'd like feedback on
> -------------------------
>
>
Hi Stephen,

Thank you for looking into this. I genuinely appreciate it.
I found this almost by accident, so here are some of my answers:


> 1. API shape.  pcap_compile-style (one string -> opaque object ->
>    arrays) versus the three-call attr/pattern/actions form
>    Sismis's v12 exposes.  What does your application actually
>    want?
>

Generally, I am fine with pcap_compile style as per your suggestions.
The original intent was to only use traffic patterns because everything
else was set by the application itself. You can see an example of the use
here:
https://github.com/OISF/suricata/pull/15290/changes#diff-4d5f5239a7124ed4b4=
d45501788bddffe803911f19c157e3c4ac7676a84d68b1R301


That is why I divided the simple API into 3 calls -- to let the application
decide which part of the flow expression to parse. But a single entry point
to the library is fine too, as the application could just fill it into the
desired rule.

2. Library placement.  Stand-alone at lib/flow_compile/ versus
>    addition to lib/ethdev.  This series treats it as a
>    control-path parser layered on top of ethdev rather than
>    part of ethdev itself; v12 places its parser inside ethdev.
>

My general take on this is that it can be so useful for developers, so it
should be part of the lib/ethdev to make it more visible. As highlighted by
Thomas, it heavily interacts with the rte_flow objects.
But, as it probes for the flex/bison tools and skips the library if they
are unavailable, wouldn't it be a problem if it is part of lib/ethdev
directly? This can be a very strong argument for a separate library, then.

>
> 3. Table-driven extension model.  Is "to add a new flow item,
>    add a row to the descriptor table" the right contract?
>    Should the tables live alongside each rte_flow_item_*
>    definition in rte_flow.h, or in their own file as here?


> 4. Convergence.  If this design is preferred, I'm happy to
>    coordinate with Lukas to fold in the testpmd-side changes
>    from his series.
>

(My) original idea was to reuse one parser for both the testpmd and the
library to avoid multiple implementations of essentially the same thing.

How would "flow compile" be useful if testpmd already has the "flow create"
command? Perhaps as a library demo only? I would expect testpmd users to
like the `flow create` endpoint more for its more comprehensive support.
Similarly, at this moment, since testpmd supports interactivity, I cannot
see how the `_compile` API would replace functions in testpmd. But perhaps
it would be part of a greater effort to migrate to flex/bison solution.
Since this is also a simple, single-rule, stateless parser, it is not fully
compatible with all of TestPMD's commands (e.g., "set raw_encap"). (Ok,
noticed, you highlighted this)
Perhaps it is fine, just wanted to highlight this.

From the user-as-an-engineer's perspective, I would be generally happy for
this parser to exist. The drop-filter feature in Suricata, in my view,
requires just a simple network pattern specification so looking at the
supported patterns already ticks off most of the items I've had in mind,
except, e.g., MPLS. I can also see this as a viable way for Suricata
user-specified decap options for better applicability of RSS.


> 5. API code. Is it readable enough. Lots of code here
>    but doing lexer/parser is prime template territory
>    and AI has a good chance here.
>
> Stephen Hemminger (3):
>   flow_compile: introduce textual flow rule compiler
>   doc: add programmer's guide for flow rule compiler
>   test/flow_compile: add unit tests for flow rule compiler
>
>  MAINTAINERS                                    |    8 +
>  app/test/meson.build                           |    2 +
>  app/test/test_flow_compile.c                   |  230 +++
>  doc/guides/prog_guide/flow_compile_lib.rst     |  170 ++
>  doc/guides/prog_guide/index.rst                |    1 +
>  doc/guides/rel_notes/release_26_07.rst         |    5 +
>  lib/flow_compile/flow_compile_lex.c            |  488 +++++
>  lib/flow_compile/flow_compile_parse.c          |  634 ++++++
>  lib/flow_compile/flow_compile_priv.h           |  181 ++
>  lib/flow_compile/flow_compile_tables.c         |  245 +++
>  lib/flow_compile/meson.build                   |   15 +
>  lib/flow_compile/rte_flow_compile.h            |  158 ++
>  lib/flow_compile/rte_flow_compile_api.c        |  132 ++
>  lib/flow_compile/version.map                   |   13 +
>  lib/meson.build                                |    1 +
>  15 files changed, 2283 insertions(+)
>  create mode 100644 app/test/test_flow_compile.c
>  create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
>  create mode 100644 lib/flow_compile/flow_compile_lex.c
>  create mode 100644 lib/flow_compile/flow_compile_parse.c
>  create mode 100644 lib/flow_compile/flow_compile_priv.h
>  create mode 100644 lib/flow_compile/flow_compile_tables.c
>  create mode 100644 lib/flow_compile/meson.build
>  create mode 100644 lib/flow_compile/rte_flow_compile.h
>  create mode 100644 lib/flow_compile/rte_flow_compile_api.c
>  create mode 100644 lib/flow_compile/version.map
>
> --
> 2.43.7
>
>
> Stephen Hemminger (3):
>   flow_compile: introduce textual flow rule compiler
>   doc: add programmer's guide for flow rule compiler
>   test/flow_compile: add unit tests for flow rule compiler
>
>  MAINTAINERS                                |   7 +
>  app/test/meson.build                       |   1 +
>  app/test/test_flow_compile.c               | 234 ++++++++
>  doc/guides/prog_guide/flow_compile_lib.rst | 272 +++++++++
>  doc/guides/prog_guide/index.rst            |   1 +
>  doc/guides/rel_notes/release_26_07.rst     |   6 +
>  lib/flow_compile/flow_compile_lex.c        | 510 +++++++++++++++++
>  lib/flow_compile/flow_compile_parse.c      | 634 +++++++++++++++++++++
>  lib/flow_compile/flow_compile_priv.h       | 181 ++++++
>  lib/flow_compile/flow_compile_tables.c     | 245 ++++++++
>  lib/flow_compile/meson.build               |  15 +
>  lib/flow_compile/rte_flow_compile.h        | 158 +++++
>  lib/flow_compile/rte_flow_compile_api.c    | 132 +++++
>  lib/meson.build                            |   1 +
>  14 files changed, 2397 insertions(+)
>  create mode 100644 app/test/test_flow_compile.c
>  create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst
>  create mode 100644 lib/flow_compile/flow_compile_lex.c
>  create mode 100644 lib/flow_compile/flow_compile_parse.c
>  create mode 100644 lib/flow_compile/flow_compile_priv.h
>  create mode 100644 lib/flow_compile/flow_compile_tables.c
>  create mode 100644 lib/flow_compile/meson.build
>  create mode 100644 lib/flow_compile/rte_flow_compile.h
>  create mode 100644 lib/flow_compile/rte_flow_compile_api.c
>
> --
> 2.53.0
>
>

--0000000000004a0f83065269ab8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">st 6. 5. 2026 v=
=C2=A05:33 odes=C3=ADlatel Stephen Hemminger &lt;<a href=3D"mailto:stephen@=
networkplumber.org">stephen@networkplumber.org</a>&gt; napsal:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Background<br>
----------<br>
<br>
Multiple efforts over the past few cycles have tried to make<br>
testpmd&#39;s flow rule grammar reusable from outside testpmd.<br>
External applications that need rte_flow want a documented way<br>
to turn human-written rules into the rte_flow_attr/item/action<br>
arrays accepted by rte_flow_create().<br>
<br>
The most recent attempt is Lukas Sismis&#39;s series, currently at<br>
v12:<br>
<br>
=C2=A0 <a href=3D"http://patches.dpdk.org/project/dpdk/list/?series=3D37384=
" rel=3D"noreferrer" target=3D"_blank">http://patches.dpdk.org/project/dpdk=
/list/?series=3D37384</a>=C2=A0 (or<br>
=C2=A0 most recent thread on <a href=3D"mailto:dev@dpdk.org" target=3D"_bla=
nk">dev@dpdk.org</a>)<br>
<br>
That series factors testpmd&#39;s existing cmdline_flow.c into a<br>
library and updates testpmd to consume it.=C2=A0 It works, but<br>
inherits two properties of cmdline_flow.c that I think are worth<br>
avoiding in a reusable library:<br>
<br>
=C2=A0 - Coupling to librte_cmdline.=C2=A0 Even after the v12 split into<br=
>
=C2=A0 =C2=A0 a &quot;simple&quot; part and a &quot;cmdline&quot; part, the=
 parser is still<br>
=C2=A0 =C2=A0 organized around testpmd&#39;s command interpreter, and v12 h=
as<br>
=C2=A0 =C2=A0 cmdline depending on ethdev to break a previous circular<br>
=C2=A0 =C2=A0 dependency.=C2=A0 A library used by daemons, control planes, =
or<br>
=C2=A0 =C2=A0 unit tests should not need that.<br>
<br>
=C2=A0 - Ad-hoc grammar.=C2=A0 cmdline_flow.c implements parsing per-token<=
br>
=C2=A0 =C2=A0 in long dispatch logic; the grammar emerges from the code<br>
=C2=A0 =C2=A0 rather than being stated, and adding a new flow item<br>
=C2=A0 =C2=A0 requires touching the parser.<br>
<br>
This RFC explores a different shape and is posted to ask the<br>
list which one is preferred before more work goes into either.<br>
<br>
So I started a new green field library for parsing flow rules<br>
(with the help of AI assistance). It is only a few hours old,<br>
but passes tests and passes review.<br>
<br>
This series<br>
-----------<br>
<br>
lib/flow_compile -- a small new library providing the same<br>
service via a pcap_compile()-style API:<br>
<br>
=C2=A0 =C2=A0 char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];<br>
=C2=A0 =C2=A0 struct rte_flow_compile *fc =3D rte_flow_compile(rule, errbuf=
);<br>
=C2=A0 =C2=A0 if (fc =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(errbuf);=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* &quot;line:col: message&quot; */<br>
<br>
=C2=A0 =C2=A0 rte_flow_compile_create(port_id, fc, &amp;flow_error);<br>
=C2=A0 =C2=A0 rte_flow_compile_free(fc);<br>
<br>
Design properties:<br>
<br>
=C2=A0 - Hand-rolled lexer + recursive descent parser.=C2=A0 No flex/bison.=
<br>
=C2=A0 - Parser is driven entirely by descriptor tables of items and<br>
=C2=A0 =C2=A0 actions.=C2=A0 Adding a new flow item is a table edit, not a<=
br>
=C2=A0 =C2=A0 parser change.=C2=A0 A custom-setter hook on each field cover=
s<br>
=C2=A0 =C2=A0 the layouts that do not fit a plain byte range (bitfields,<br=
>
=C2=A0 =C2=A0 indirect arrays).<br>
=C2=A0 - Dependencies: rte_ethdev and rte_net only.=C2=A0 No librte_cmdline=
,<br>
=C2=A0 =C2=A0 no flex/bison.=C2=A0 Builds clean on Linux, FreeBSD, and Wind=
ows.<br>
=C2=A0 - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;<br>
=C2=A0 =C2=A0 rte_flow_compile_free() walks the pattern and action arrays.<=
br>
=C2=A0 =C2=A0 ASan/LSan run clean on the autotest.<br>
<br>
The grammar follows testpmd&#39;s syntax closely so familiar rules<br>
carry over:<br>
<br>
=C2=A0 =C2=A0 ingress pattern eth / ipv4 src is 10.0.0.1 / end<br>
=C2=A0 =C2=A0 actions queue index 3 / count / end<br>
<br>
and is documented as a formal BNF in the programmer&#39;s guide<br>
chapter (patch 2).<br>
<br>
Initial coverage: eth, vlan, ipv4, ipv6, tcp, udp, vxlan,<br>
port_id, port_representor, represented_port items; drop,<br>
passthru, queue, mark, jump, count, port_id and representor<br>
variants, of_pop_vlan, vxlan_decap actions.=C2=A0 Variable-conf<br>
items and actions (RSS, RAW) require custom setters and are<br>
deferred to a follow-up.<br>
<br>
What this RFC is *not*<br>
----------------------<br>
<br>
Not a replacement for cmdline_flow.c in testpmd.=C2=A0 If the shape<br>
here is acceptable, the next step is a separate series adding a<br>
&quot;flow compile &lt;port&gt; &lt;rule&gt;&quot; command in testpmd along=
side the<br>
existing parser, so users can adopt the library incrementally<br>
without breaking scripts that depend on the current syntax.<br>
<br>
What I&#39;d like feedback on<br>
-------------------------<br>
<br></blockquote><div><br></div><div>Hi Stephen,</div><div><br></div><div>T=
hank you for looking into this. I genuinely appreciate it.</div><div>I foun=
d this almost by accident, so here are some of my answers:</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
1. API shape.=C2=A0 pcap_compile-style (one string -&gt; opaque object -&gt=
;<br>
=C2=A0 =C2=A0arrays) versus the three-call attr/pattern/actions form<br>
=C2=A0 =C2=A0Sismis&#39;s v12 exposes.=C2=A0 What does your application act=
ually<br>
=C2=A0 =C2=A0want?<br></blockquote><div><br></div><div>Generally, I am fine=
 with pcap_compile style as per your suggestions.</div><div>The original in=
tent was to only use traffic patterns because everything else was set by th=
e application itself. You can see an example of the use here:=C2=A0<a href=
=3D"https://github.com/OISF/suricata/pull/15290/changes#diff-4d5f5239a7124e=
d4b4d45501788bddffe803911f19c157e3c4ac7676a84d68b1R301">https://github.com/=
OISF/suricata/pull/15290/changes#diff-4d5f5239a7124ed4b4d45501788bddffe8039=
11f19c157e3c4ac7676a84d68b1R301</a>=C2=A0</div><div><br></div><div>That is =
why I divided the simple API into 3 calls -- to let the application decide =
which part of the flow expression to parse. But a single entry point to the=
 library is fine too, as the application could just fill it into the desire=
d rule.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
2. Library placement.=C2=A0 Stand-alone at lib/flow_compile/ versus<br>
=C2=A0 =C2=A0addition to lib/ethdev.=C2=A0 This series treats it as a<br>
=C2=A0 =C2=A0control-path parser layered on top of ethdev rather than<br>
=C2=A0 =C2=A0part of ethdev itself; v12 places its parser inside ethdev.<br=
></blockquote><div><br></div><div>My general take on this is that it can be=
 so useful for developers, so it should be part of the lib/ethdev to make i=
t more visible. As highlighted by Thomas, it heavily interacts with the rte=
_flow objects.</div><div>But, as it probes for the flex/bison tools and ski=
ps the library if they are unavailable, wouldn&#39;t it be a problem if it =
is part of lib/ethdev directly? This can be a very strong argument for a se=
parate library, then.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
3. Table-driven extension model.=C2=A0 Is &quot;to add a new flow item,<br>
=C2=A0 =C2=A0add a row to the descriptor table&quot; the right contract?<br=
>
=C2=A0 =C2=A0Should the tables live alongside each rte_flow_item_*<br>
=C2=A0 =C2=A0definition in rte_flow.h, or in their own file as here?=C2=A0<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
4. Convergence.=C2=A0 If this design is preferred, I&#39;m happy to<br>
=C2=A0 =C2=A0coordinate with Lukas to fold in the testpmd-side changes<br>
=C2=A0 =C2=A0from his series.<br></blockquote><div><br></div><div>(My) orig=
inal idea was to reuse one parser for both the testpmd and the library to a=
void multiple implementations of essentially the same thing.</div><div><br>=
</div><div>How would &quot;flow compile&quot; be useful if testpmd already =
has=C2=A0the &quot;flow create&quot; command? Perhaps as a=C2=A0library dem=
o only? I would expect testpmd users to like the `flow create` endpoint mor=
e for its more comprehensive support.</div><div>Similarly, at this moment, =
since testpmd supports interactivity, I cannot see how the `_compile` API w=
ould replace functions in testpmd. But perhaps it would be part of a greate=
r effort to migrate <span aria-invalid=3D"grammar" class=3D"Lm ng" style=3D=
"border-style:none;background:none">to flex</span>/bison solution.</div><di=
v>Since this is also a simple, single-rule, stateless parser, it is not ful=
ly compatible with all of TestPMD&#39;s commands (e.g., &quot;set raw_encap=
&quot;). (Ok, noticed, you highlighted this)</div><div>Perhaps it is fine, =
just wanted to highlight this.</div><div><br></div><div>From the user-as-an=
-engineer&#39;s perspective, I would be generally happy for this parser to =
exist. The drop-filter feature in Suricata, in my view, requires just a sim=
ple network pattern specification so looking at the supported patterns alre=
ady ticks off most of the items I&#39;ve had in mind, except, e.g., MPLS. I=
 can also see this as a viable way for Suricata user-specified decap option=
s for better applicability of RSS.=C2=A0</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
5. API code. Is it readable enough. Lots of code here<br>
=C2=A0 =C2=A0but doing lexer/parser is prime template territory<br>
=C2=A0 =C2=A0and AI has a good chance here.<br>
<br>
Stephen Hemminger (3):<br>
=C2=A0 flow_compile: introduce textual flow rule compiler<br>
=C2=A0 doc: add programmer&#39;s guide for flow rule compiler<br>
=C2=A0 test/flow_compile: add unit tests for flow rule compiler<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 8 +<br>
=C2=A0app/test/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
=C2=A0app/test/test_flow_compile.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 230 +++<br>
=C2=A0doc/guides/prog_guide/flow_compile_lib.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0=
 170 ++<br>
=C2=A0doc/guides/prog_guide/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0doc/guides/rel_notes/release_26_07.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 5 +<br>
=C2=A0lib/flow_compile/flow_compile_lex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 488 +++++<br>
=C2=A0lib/flow_compile/flow_compile_parse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 634 ++++++<br>
=C2=A0lib/flow_compile/flow_compile_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 181 ++<br>
=C2=A0lib/flow_compile/flow_compile_tables.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 245 +++<br>
=C2=A0lib/flow_compile/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A015 +<br>
=C2=A0lib/flow_compile/rte_flow_compile.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 158 ++<br>
=C2=A0lib/flow_compile/rte_flow_compile_api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 132 ++<br>
=C2=A0lib/flow_compile/version.map=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A013 +<br>
=C2=A0lib/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
1 +<br>
=C2=A015 files changed, 2283 insertions(+)<br>
=C2=A0create mode 100644 app/test/test_flow_compile.c<br>
=C2=A0create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_lex.c<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_parse.c<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_priv.h<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_tables.c<br>
=C2=A0create mode 100644 lib/flow_compile/meson.build<br>
=C2=A0create mode 100644 lib/flow_compile/rte_flow_compile.h<br>
=C2=A0create mode 100644 lib/flow_compile/rte_flow_compile_api.c<br>
=C2=A0create mode 100644 lib/flow_compile/version.map<br>
<br>
-- <br>
2.43.7<br>
<br>
<br>
Stephen Hemminger (3):<br>
=C2=A0 flow_compile: introduce textual flow rule compiler<br>
=C2=A0 doc: add programmer&#39;s guide for flow rule compiler<br>
=C2=A0 test/flow_compile: add unit tests for flow rule compiler<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<b=
r>
=C2=A0app/test/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0app/test/test_flow_compile.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 234 ++++++++<br>
=C2=A0doc/guides/prog_guide/flow_compile_lib.rst | 272 +++++++++<br>
=C2=A0doc/guides/prog_guide/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0doc/guides/rel_notes/release_26_07.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +<br>
=C2=A0lib/flow_compile/flow_compile_lex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 510 =
+++++++++++++++++<br>
=C2=A0lib/flow_compile/flow_compile_parse.c=C2=A0 =C2=A0 =C2=A0 | 634 +++++=
++++++++++++++++<br>
=C2=A0lib/flow_compile/flow_compile_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 181 =
++++++<br>
=C2=A0lib/flow_compile/flow_compile_tables.c=C2=A0 =C2=A0 =C2=A0| 245 +++++=
+++<br>
=C2=A0lib/flow_compile/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 15 +<br>
=C2=A0lib/flow_compile/rte_flow_compile.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 158 =
+++++<br>
=C2=A0lib/flow_compile/rte_flow_compile_api.c=C2=A0 =C2=A0 | 132 +++++<br>
=C2=A0lib/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A014 files changed, 2397 insertions(+)<br>
=C2=A0create mode 100644 app/test/test_flow_compile.c<br>
=C2=A0create mode 100644 doc/guides/prog_guide/flow_compile_lib.rst<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_lex.c<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_parse.c<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_priv.h<br>
=C2=A0create mode 100644 lib/flow_compile/flow_compile_tables.c<br>
=C2=A0create mode 100644 lib/flow_compile/meson.build<br>
=C2=A0create mode 100644 lib/flow_compile/rte_flow_compile.h<br>
=C2=A0create mode 100644 lib/flow_compile/rte_flow_compile_api.c<br>
<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--0000000000004a0f83065269ab8e--
