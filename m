Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC80D29DF3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A76B4028C;
	Tue, 13 Jan 2026 10:38:23 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 38F7740276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 10:38:22 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7cdd651c884so4514379a34.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768297101; x=1768901901; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cUR37ESf4/eyJD7fiTDTG8dADvcYg3BPGPl3pT9/CCI=;
 b=k0uBGjp51U6tNjRDd8pu5P5Q0eyZOAf/fpPZfnnQUUtKNu1+vdos2+ACLzAlaMKgc9
 xuW8VcYmhaufvGgAYx49a6gHYWtByx+pNv/EoK1Y1FqENMDa3kWoPNFb79MYn43wH9XA
 5xrmtm9xNsfy+C81t8+PtwBZ/6EPJmWxGBWjhBbaX7JlxZTfOiKVVy5WsSCG77/VpAZd
 59qWbsEoZBHrrJJpkqD4uZ8tSnsTV+HJGQq0LPGiazGwXYAHBuTzf11qpk7rnq8ZjnKW
 VK4ZgqrE8vV0v59Z+c1SDzHFb7LugykouQrlE49VDez075X99b+p7frExwf9T8qeo9UV
 bclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768297101; x=1768901901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUR37ESf4/eyJD7fiTDTG8dADvcYg3BPGPl3pT9/CCI=;
 b=JX22IP5FdqJ31uBnODv6QTyCxBq9mP7GXLoIAr3i3DppN0YDb/ESpkUtudMkyZE7wF
 R/UZMkRwW84N90Of7hAhNr5qsqAl5c4QDFjbCYMmNTwaU6h2MPCpTA02OCRIK02btk43
 h37qp1VwzqIRVNupi4HS/syAyaGo/wARA7xC8o5rDUrGsRUHLFUhUmlW+m+Wo1WPfq0H
 OPCupGUSRW9gOOPQutNnstUtVy5mHfSdpDNs039ms5mfWtjhp6KgV2KvzAri2Ygqkumk
 40/4eybtn532TovOfBB7oX4qB/z1UTOdwEL8c6xsw0Pfnu0wlR4KmHWh1JPcgitWGrOk
 1HQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGtUUGnuShiopCvR+VcIpikZ5VFomqckAi7x4mEQ2txPWAf/ln9t7JrWOS0lHVbrqgkyQ=@dpdk.org
X-Gm-Message-State: AOJu0Yw0Nj54WzRO6JWf2FOwT1U2S7CGAVavvImTFnx1DLQouyNsZ4B9
 24WPmiySSVdTKrP56nXLHWA4YoMRDDw5gS69W4t/lRSekzYLtJi9BFEthjnk3lc+hELqNpA8ein
 gt1AMqzjynW0WO/Ux+8N+GdhkGvDP8pw=
X-Gm-Gg: AY/fxX520RdOvvlCRZcmggtGw0tpSjVu6sEOINNl/Z71wYZal9ReLn6Pu82ez5WuvN7
 R94+yU83oDGu/SiwVUfizobyoWOdL91iJsrrCogBgk30YVdtdHeR7wbqEZpqJh1p3K75rq326BI
 hS16hfeCnuJf5nZmZTmCxQkzzvu78jXthpcNZHsrXDmhnWLwZ0HASuPFp+PxzPen2rIOHV4+cEs
 M9XBtjVnp32DNlEa1+rtaXmLfoy7i3oHNTG0qQ5vYB7PVXmSC59+nviPUcbw6IqCEKz/3U=
X-Received: by 2002:a05:6830:11c2:b0:7c6:d01f:591b with SMTP id
 46e09a7af769-7cfbe4941f5mr1130136a34.13.1768297101165; Tue, 13 Jan 2026
 01:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
 <20260111185809.47d9f7a7@phoenix.local>
In-Reply-To: <20260111185809.47d9f7a7@phoenix.local>
From: madhukar mythri <madhukar.mythri@gmail.com>
Date: Tue, 13 Jan 2026 15:08:10 +0530
X-Gm-Features: AZwV_QhCwdbWCcfwO5Ph22hyJmg2wZh-uQ86W7PUAjek6CFphw4PnzDvU5d3VWE
Message-ID: <CAAUNki13C4mFTH4CjZsKRGwPDa6Op4JUtdxdVuAozHm6J2Q=XQ@mail.gmail.com>
Subject: Re: [PATCH] net/netvsc: Fix on race condition of multiple commands
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: longli@microsoft.com, dev@dpdk.org, madhuker.mythri@oracle.com
Content-Type: multipart/alternative; boundary="0000000000009288e3064841c052"
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

--0000000000009288e3064841c052
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the comments.

This issue occurs only with the query functions (like: device info get and
link-status) and not at the time of initialization(hn_rndis_set()).
So, to make it simple, just use the spinlocks for the queries only.

Regards,
Madhuker.

On Mon, Jan 12, 2026 at 8:28=E2=80=AFAM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Fri, 12 Dec 2025 17:22:38 +0530
> Madhuker Mythri <madhukar.mythri@gmail.com> wrote:
>
> > When multiple processes issue command requests(like: device info get
> > and link-status) at same-time, then we could see the command request
> > failures, due to race-condition of common function execution.
> >
> > So, to avoid such race-condition introduced a new spin-lock to protect
> > the code of critical section.
> >
> > Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> > Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
>
> AI patch review spotted some minor things and raises vaild question
> about overall races in hn_rndis_exec
>
> ## Patch Review: net/netvsc Race Condition Fix
>
> Based on the AGENTS.md DPDK review criteria, here's my assessment:
>
> ---
>
> ### **ERRORS (Must Fix)**
>
> 1. **Subject line capitalization** =E2=80=94 "Fix" should be lowercase "f=
ix"
>    - Current: `net/netvsc: Fix on race condition of multiple commands`
>    - Should be: `net/netvsc: fix race condition in multiple commands`
>
> 2. **Missing blank line before Signed-off-by** =E2=80=94 Per tag order
> requirements, there must be a blank line between the `Fixes:` block and t=
he
> `Signed-off-by:` block:
>    ```
>    Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
>
>    Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
>    ```
>
> ---
>
> ### **WARNINGS (Should Fix)**
>
> 1. **Awkward grammar in subject** =E2=80=94 "Fix on race condition" is
> grammatically incorrect. Should be "fix race condition" (removing "on").
>
> 2. **Missing `Cc: stable@dpdk.org`** =E2=80=94 This is a bug fix with a `=
Fixes:`
> tag, so it's a candidate for stable backport.
>
> 3. **Body formatting nit** =E2=80=94 Line 89 has `requests(like:` =E2=80=
=94 missing space
> before the parenthesis. Should be `requests (like:`.
>
> 4. **Incomplete protection?** =E2=80=94 The spinlock only wraps
> `hn_rndis_execute()` inside `hn_rndis_query()`, but `hn_rndis_execute()` =
is
> likely called from other paths (e.g., `hn_rndis_set()`). If the race
> condition is in `hn_rndis_execute()` itself, all callers should be
> protected =E2=80=94 or the lock should be inside `hn_rndis_execute()` rat=
her than
> in `hn_rndis_query()`.
>
> ---
>
> ### **INFO (Minor/Consider)**
>
> 1. **Commit body could be clearer** =E2=80=94 Consider specifying which e=
xact
> functions race (e.g., "concurrent calls to `hn_rndis_query()` from
> different control paths can corrupt the shared response buffer").
>
> 2. **Lock granularity** =E2=80=94 Holding a spinlock across `hn_rndis_exe=
cute()`
> which appears to wait for completion could block other threads for extend=
ed
> periods. A mutex might be more appropriate if this isn't a fast-path
> operation.
>
> ---
>
> ### **What's Correct** =E2=9C=93
>
> - Subject length (53 chars =E2=89=A4 60)
> - Correct component prefix (`net/netvsc:`)
> - Imperative mood
> - No trailing period
> - Body lines within 75 characters
> - Body doesn't start with "It"
> - `Signed-off-by:` present with real name and email
> - `Fixes:` tag present with 12-char SHA and quoted subject
> - Code uses proper DPDK APIs (`rte_spinlock_*`)
> - Code changes are minimal and focused
>
> ---
>
> ### **Suggested Revised Commit Message**
>
> ```
> net/netvsc: fix race condition in RNDIS command execution
>
> When multiple threads issue RNDIS command requests (such as device
> info queries and link status checks) simultaneously, command failures
> can occur due to concurrent access to shared resources in the RNDIS
> execution path.
>
> Add a spinlock to serialize RNDIS command execution and prevent
> data corruption.
>
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Cc: stable@dpdk.org
>
> Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
> ```
>
> ---
>
> ### **Technical Question for Author**
>
> Is `hn_rndis_query()` the only caller of `hn_rndis_execute()` that can
> race, or should `hn_rndis_set()` and other callers also be protected? If
> the race is in the execute function itself, moving the lock inside
> `hn_rndis_execute()` would provide complete protection.
>

--0000000000009288e3064841c052
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the comments.<div>=C2=A0<div>This issue occurs =
only with the query functions (like: device info get and link-status) and n=
ot at the time of initialization(hn_rndis_set()).</div><div>So, to make it =
simple, just use the spinlocks for the queries only.</div><div><br></div><d=
iv>Regards,</div></div><div>Madhuker.</div></div><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Ja=
n 12, 2026 at 8:28=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mailto:steph=
en@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 12 Dec 2025 17:22:=
38 +0530<br>
Madhuker Mythri &lt;<a href=3D"mailto:madhukar.mythri@gmail.com" target=3D"=
_blank">madhukar.mythri@gmail.com</a>&gt; wrote:<br>
<br>
&gt; When multiple processes issue command requests(like: device info get<b=
r>
&gt; and link-status) at same-time, then we could see the command request<b=
r>
&gt; failures, due to race-condition of common function execution.<br>
&gt; <br>
&gt; So, to avoid such race-condition introduced a new spin-lock to protect=
<br>
&gt; the code of critical section.<br>
&gt; <br>
&gt; Fixes: 4e9c73e96e83 (&quot;net/netvsc: add Hyper-V network device&quot=
;)<br>
&gt; Signed-off-by: Madhuker Mythri &lt;<a href=3D"mailto:madhukar.mythri@g=
mail.com" target=3D"_blank">madhukar.mythri@gmail.com</a>&gt;<br>
<br>
AI patch review spotted some minor things and raises vaild question<br>
about overall races in hn_rndis_exec<br>
<br>
## Patch Review: net/netvsc Race Condition Fix<br>
<br>
Based on the AGENTS.md DPDK review criteria, here&#39;s my assessment:<br>
<br>
---<br>
<br>
### **ERRORS (Must Fix)**<br>
<br>
1. **Subject line capitalization** =E2=80=94 &quot;Fix&quot; should be lowe=
rcase &quot;fix&quot;<br>
=C2=A0 =C2=A0- Current: `net/netvsc: Fix on race condition of multiple comm=
ands`<br>
=C2=A0 =C2=A0- Should be: `net/netvsc: fix race condition in multiple comma=
nds`<br>
<br>
2. **Missing blank line before Signed-off-by** =E2=80=94 Per tag order requ=
irements, there must be a blank line between the `Fixes:` block and the `Si=
gned-off-by:` block:<br>
=C2=A0 =C2=A0```<br>
=C2=A0 =C2=A0Fixes: 4e9c73e96e83 (&quot;net/netvsc: add Hyper-V network dev=
ice&quot;)<br>
<br>
=C2=A0 =C2=A0Signed-off-by: Madhuker Mythri &lt;<a href=3D"mailto:madhukar.=
mythri@gmail.com" target=3D"_blank">madhukar.mythri@gmail.com</a>&gt;<br>
=C2=A0 =C2=A0```<br>
<br>
---<br>
<br>
### **WARNINGS (Should Fix)**<br>
<br>
1. **Awkward grammar in subject** =E2=80=94 &quot;Fix on race condition&quo=
t; is grammatically incorrect. Should be &quot;fix race condition&quot; (re=
moving &quot;on&quot;).<br>
<br>
2. **Missing `Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stab=
le@dpdk.org</a>`** =E2=80=94 This is a bug fix with a `Fixes:` tag, so it&#=
39;s a candidate for stable backport.<br>
<br>
3. **Body formatting nit** =E2=80=94 Line 89 has `requests(like:` =E2=80=94=
 missing space before the parenthesis. Should be `requests (like:`.<br>
<br>
4. **Incomplete protection?** =E2=80=94 The spinlock only wraps `hn_rndis_e=
xecute()` inside `hn_rndis_query()`, but `hn_rndis_execute()` is likely cal=
led from other paths (e.g., `hn_rndis_set()`). If the race condition is in =
`hn_rndis_execute()` itself, all callers should be protected =E2=80=94 or t=
he lock should be inside `hn_rndis_execute()` rather than in `hn_rndis_quer=
y()`.<br>
<br>
---<br>
<br>
### **INFO (Minor/Consider)**<br>
<br>
1. **Commit body could be clearer** =E2=80=94 Consider specifying which exa=
ct functions race (e.g., &quot;concurrent calls to `hn_rndis_query()` from =
different control paths can corrupt the shared response buffer&quot;).<br>
<br>
2. **Lock granularity** =E2=80=94 Holding a spinlock across `hn_rndis_execu=
te()` which appears to wait for completion could block other threads for ex=
tended periods. A mutex might be more appropriate if this isn&#39;t a fast-=
path operation.<br>
<br>
---<br>
<br>
### **What&#39;s Correct** =E2=9C=93<br>
<br>
- Subject length (53 chars =E2=89=A4 60)<br>
- Correct component prefix (`net/netvsc:`)<br>
- Imperative mood<br>
- No trailing period<br>
- Body lines within 75 characters<br>
- Body doesn&#39;t start with &quot;It&quot;<br>
- `Signed-off-by:` present with real name and email<br>
- `Fixes:` tag present with 12-char SHA and quoted subject<br>
- Code uses proper DPDK APIs (`rte_spinlock_*`)<br>
- Code changes are minimal and focused<br>
<br>
---<br>
<br>
### **Suggested Revised Commit Message**<br>
<br>
```<br>
net/netvsc: fix race condition in RNDIS command execution<br>
<br>
When multiple threads issue RNDIS command requests (such as device<br>
info queries and link status checks) simultaneously, command failures<br>
can occur due to concurrent access to shared resources in the RNDIS<br>
execution path.<br>
<br>
Add a spinlock to serialize RNDIS command execution and prevent<br>
data corruption.<br>
<br>
Fixes: 4e9c73e96e83 (&quot;net/netvsc: add Hyper-V network device&quot;)<br=
>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Madhuker Mythri &lt;<a href=3D"mailto:madhukar.mythri@gmail.=
com" target=3D"_blank">madhukar.mythri@gmail.com</a>&gt;<br>
```<br>
<br>
---<br>
<br>
### **Technical Question for Author**<br>
<br>
Is `hn_rndis_query()` the only caller of `hn_rndis_execute()` that can race=
, or should `hn_rndis_set()` and other callers also be protected? If the ra=
ce is in the execute function itself, moving the lock inside `hn_rndis_exec=
ute()` would provide complete protection.<br>
</blockquote></div>

--0000000000009288e3064841c052--
