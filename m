Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11F8D35164
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19DB84029D;
	Wed,  1 Apr 2026 11:15:57 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 08584400D7
 for <dev@dpdk.org>; Wed,  1 Apr 2026 11:15:55 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8a154cc6a48so31916396d6.0
 for <dev@dpdk.org>; Wed, 01 Apr 2026 02:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034954; cv=none;
 d=google.com; s=arc-20240605;
 b=EbmhtZKPIzBZHV1LpPfUs+IWd+NlVZXQDxFia8/wPgSb2eVjUv8lHvbqT/3ZyT83hx
 S/4Q5F7wbooWm/D2Q9ckVwo7KBXvQIgaB1EzciPc65qHHaqONO6HpiUyPE92ARE3Q0xa
 cq3+5tZq3cAUR1pFG0b6A0IkxLYkm/C02To14GcSlo6tsWqgLLrzAWV2x1v5qxDUA85L
 knGAVJ2LIy3neScfb1/0zHrQA2PIzjMgeAVmPSaO2JHubCxtLImMa8XWCY9K7079m81M
 eGkumOvy9W+mLUq2LCKEGzQ9q8XKcHbhbe1EjPM1TbaMqLtPS6TfNfqudF0z/GVqNs7d
 jAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=4p2bbT7B6OmgRJwqlVxHvthyl4VboXozb68KPKqwnd0=;
 fh=GViiPYLYvQcrk50N7USltnV4Mo1T8wPOXvu3IthtR4g=;
 b=URqQaEaKq1kXyk9sH46+XYpAeexj4WwrU1bQKdBAQLKJbacScP35rdg7klxjeVpVen
 sMMcFtOIE/B7gC1qiBLaByr21iBEVmsTzMEddk00sFHXv7QQ0JbFVvPnuZDb/z1DQcSr
 +xU3JfKoLFpj4dJbJjtLpPHgW0zvrioQLmUszmPeY/BPdncYTvxyyuxF0BHrq+fiTy7O
 xmjt8bzk7jBcg6PCvDu/2f0LYil/psYmmuXfVg4SjhACvhULLgvm9t9c7NkJlmmY8X8U
 TJzuh03b4yJxs/9bq0V/ku/H040mn2wjzdWS3oHL96nQh0GBvW7BjDbI0DH2FIwWnA2O
 T4tA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034954; x=1775639754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4p2bbT7B6OmgRJwqlVxHvthyl4VboXozb68KPKqwnd0=;
 b=nJR3axA37JEB7egt9E+4N1NbYfyGMjRmFtoB02bQh53jRhy2pgQpjhTrjipqFCe3rW
 UBknBN/eiO2oQmVo9xxIE2TD+IpVw+6ppLC74jLKCunHwVnly0ZUErrq2/diw34zpzLV
 GHn8X8JlPCB6W607PMXXeV0t6JwBvAD4kQI53KivaWx+6dMffmgOGK31tkn131eScTMj
 lx0X1rtvzgjqKBfeBnRAhH6w0+CwjvRFa2YcwuFU7Dxu8236GpmZoor4EWMSRPibkuIq
 wn2z3fPRdGkT3lzsVCPj/5ZHkgFA9xzjEDFLzfnL5BQg8wxUIqfodquxs+W/hwHa7DNG
 K6hw==
X-Gm-Message-State: AOJu0YyBu4ez/6b/5W5dgONZ34e3i2i3xyBDoGw13WXL2STMRkwPMMQO
 2LTLbbdjSYR35KuuiI+EzjpYn/F5Ik5tJ6Z/II1i4TLqY//UWnJyfbNbSV1rv+vF19XHFrYp2md
 kj7u7Gf1m7YKToc+NVMbU6MqPpRqpFXY=
X-Gm-Gg: ATEYQzx4dHMEGSPRO5rCZfalgBtsTCBTHjhDixfeuaLM2LSU6Hf01+a48q0F/p/Eeiq
 tPsUy67uCSbgwusImuS1ntNyIrxDUgmCoKxB0WDf+5z02t5QpjOfJb5qdhI9IgGATqm/fcGu/Nh
 qkCH/EVsGOJ18qPSY5CW/Syqx8By7lTEqMxw3ndDIrJfglrpk2kPWR86MQLMhbqRlqcYMqwn1a4
 UWDXN2+6c7UKsJ3t5rzH+q6FosLqjmJPFrelTAjtT4b7E24euPO65+ptaIpQRNuBXFNj4nvLGfk
 yx4rox9+eGudpaCCDcZwYWQO28xcexHX56xFt9oWCg==
X-Received: by 2002:ad4:5aa6:0:b0:89c:cfb1:b59c with SMTP id
 6a1803df08f44-8a4387f0d1amr38229656d6.23.1775034954209; Wed, 01 Apr 2026
 02:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260331214117.142495-1-maxime@leroys.fr>
 <DHHBDQLPUP7N.N5BQQQHV8Z4J@redhat.com>
In-Reply-To: <DHHBDQLPUP7N.N5BQQQHV8Z4J@redhat.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 1 Apr 2026 11:15:43 +0200
X-Gm-Features: AQROBzAs0nx5qZkFu68_tzoW4tjkoZNGFr5erRaCN34StQrDKiNMPXq9LeKxHIo
Message-ID: <CAHHRULWgXZHc92FR9-ZF0MONA3yiSF3t27JZ8x_d58cXHcYUjA@mail.gmail.com>
Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Content-Type: multipart/alternative; boundary="000000000000e8dd09064e6287fa"
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

--000000000000e8dd09064e6287fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Robin,

Thanks a lot for the review.

Le mer. 1 avr. 2026, 00:17, Robin Jarry <rjarry@redhat.com> a =C3=A9crit :

> Hi Maxime,
>
> Maxime Leroy, Mar 31, 2026 at 23:41:
> > This RFC proposes an optional shared tbl8 pool for FIB/FIB6,
> > to address the difficulty of sizing num_tbl8 upfront.
> >
> > In practice, tbl8 usage depends on prefix distribution and
> > evolves over time. In multi-VRF environments, some VRFs are
> > elephants (full table, thousands of tbl8 groups) while others
> > consume very little (mostly /24 or shorter). Per-FIB sizing
> > forces each instance to provision for its worst case, leading
> > to significant memory waste.
> >
> > A shared pool solves this: all FIBs draw from the same tbl8
> > memory, so elephant VRFs use what they need while light VRFs
> > cost almost nothing. The sharing granularity is flexible: one pool per
> > VRF, per address family, a global pool, or no sharing at all.
> >
> > This series adds:
> >
> >   - A shared tbl8 pool, replacing per-backend allocation
> >     (bitmap in dir24_8, stack in trie) with a common
> >     refcounted O(1) stack allocator.
> >   - An optional resizable mode (grow via alloc + copy + QSBR
> >     synchronize), removing the need to guess peak usage at
> >     creation time.
> >   - A stats API (rte_fib_tbl8_pool_get_stats()) exposing
> >     used/total/max counters.
> >
> > All features are opt-in:
> >
> >   - Existing per-FIB allocation remains the default.
> >   - Shared pool is enabled via the tbl8_pool config field.
> >   - Resize is enabled by setting max_tbl8 > 0 with QSBR.
>
> The shared pool is nice, but dynamic resize is awesome.
>
> I have gone over the implementation and it seems sane to me. The only
> concern I might have is the change of tbl8 pool allocator for DIR24_8
> from a O(n/64) slab to O(1) stack. I don't know if it can have
> a performance impact on lookup or if it only affects the control plane
> operations (add/del).
>

This only affects control-plane operations (tbl8 alloc/free on
add/del).Lookup only reads the final tbl24/tbl8 arrays and does not
interact withthe allocator itself.

So the motivation for the stack allocator here is to make
shared-poolmanagement simple and O(1) on the update path, not to change
lookupbehavior.

If shrinking ever becomes interesting later, then I agree the allocator
choice may need to be revisited. A LIFO stack immediately reuses the most
recently freed entries, so high indices tend to get reused first and it
becomes difficult to form a contiguous free tail. A low-first bitmap/slab
allocator, or a min-heap, would be better for shrinking because they prefer
lower free indices and therefore leave high indices unused longer.The
trade-off is that put/get become more expensive (O(n/64) for bitmap scan or
O(log n) for a heap, instead of O(1) for the stack).


> > Shrinking (reducing pool capacity after usage drops) is not
> > part of this series. It would always be best-effort since
> > there is no compaction: if any tbl8 group near the end of the
> > pool is still in use, the pool cannot shrink. The current LIFO
> > free-list makes this less likely by immediately reusing freed
> > high indices, which prevents a contiguous free tail from
> > forming. A different allocation strategy (e.g. a min-heap
> > favoring low indices) could improve shrink opportunities, but
> > is better addressed separately.
>
> Shrinking would be nice to have but not critical in my opinion. I would
> prefer if we could add a dynamic resize feature (and possibly RIB node
> mempool sharing) for rte_rib* as well so that FIB objects can really be
> scaled up on demand. For now, if you run out of space in the RIB, you
> will get an ENOSPC error even if the FIB tbl8 pool still has room.
>

Agreed. Today tbl8 is only one side of the sizing problem.

For rte_rib*, I think we should probably move in a similar direction as
well: avoid per-VRF/per-instance worst-case provisioning, while keeping
separate global limits for IPv4 and IPv6, e.g. max_ipv4_routes and
max_ipv6_routes.

The difference with tbl8 is that the trade-off is not the same. tbl8 usage
is both expensive (2 KB per group) and hard to predict from route count
alone, since it depends on prefix distribution and table shape. RIB nodes
are much smaller and their usage is more predictable, so a shared global
node pool per AF already looks like a sensible first step.

That would remove per-VRF over-provisioning while keeping global limits. If
later true on-demand growth is needed, I think the mechanism would likely
have to be different from tbl8 resizing anyway: tbl8 is an indexed array
and can grow via alloc + copy + pointer swap, while RIB nodes are linked by
pointers, so they cannot be relocated transparently. In that case, a
chunked allocator would probably make more sense.

Also, I do not think hugepage-backed allocation (i.e. rte_mempool) is
really needed for rte_rib*.

Maxime

--000000000000e8dd09064e6287fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div><div>HI Robin,</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks a lot for the review.</div><div><br>=
</div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le m=
er. 1 avr. 2026, 00:17, Robin Jarry &lt;<a href=3D"mailto:rjarry@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">rjarry@redhat.com</a>&gt; a =C3=A9cr=
it=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Maxime,<br>
<br>
Maxime Leroy, Mar 31, 2026 at 23:41:<br>
&gt; This RFC proposes an optional shared tbl8 pool for FIB/FIB6,<br>
&gt; to address the difficulty of sizing num_tbl8 upfront.<br>
&gt;<br>
&gt; In practice, tbl8 usage depends on prefix distribution and<br>
&gt; evolves over time. In multi-VRF environments, some VRFs are<br>
&gt; elephants (full table, thousands of tbl8 groups) while others<br>
&gt; consume very little (mostly /24 or shorter). Per-FIB sizing<br>
&gt; forces each instance to provision for its worst case, leading<br>
&gt; to significant memory waste.<br>
&gt;<br>
&gt; A shared pool solves this: all FIBs draw from the same tbl8<br>
&gt; memory, so elephant VRFs use what they need while light VRFs<br>
&gt; cost almost nothing. The sharing granularity is flexible: one pool per=
<br>
&gt; VRF, per address family, a global pool, or no sharing at all.<br>
&gt;<br>
&gt; This series adds:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- A shared tbl8 pool, replacing per-backend allocation<br>
&gt;=C2=A0 =C2=A0 =C2=A0(bitmap in dir24_8, stack in trie) with a common<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0refcounted O(1) stack allocator.<br>
&gt;=C2=A0 =C2=A0- An optional resizable mode (grow via alloc + copy + QSBR=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0synchronize), removing the need to guess peak usage=
 at<br>
&gt;=C2=A0 =C2=A0 =C2=A0creation time.<br>
&gt;=C2=A0 =C2=A0- A stats API (rte_fib_tbl8_pool_get_stats()) exposing<br>
&gt;=C2=A0 =C2=A0 =C2=A0used/total/max counters.<br>
&gt;<br>
&gt; All features are opt-in:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- Existing per-FIB allocation remains the default.<br>
&gt;=C2=A0 =C2=A0- Shared pool is enabled via the tbl8_pool config field.<b=
r>
&gt;=C2=A0 =C2=A0- Resize is enabled by setting max_tbl8 &gt; 0 with QSBR.<=
br>
<br>
The shared pool is nice, but dynamic resize is awesome.<br>
<br>
I have gone over the implementation and it seems sane to me. The only<br>
concern I might have is the change of tbl8 pool allocator for DIR24_8<br>
from a O(n/64) slab to O(1) stack. I don&#39;t know if it can have<br>
a performance impact on lookup or if it only affects the control plane<br>
operations (add/del).<br></blockquote></div></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"></blockquote></div></div><div dir=3D"auto">This only affects=
 control-plane operations (tbl8 alloc/free on add/del).Lookup only reads th=
e final tbl24/tbl8 arrays and does not interact withthe allocator itself.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">So the motivation for the=
 stack allocator here is to make shared-poolmanagement simple and O(1) on t=
he update path, not to change lookupbehavior.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">If shrinking ever becomes interesting later, then I a=
gree the allocator choice may need to be revisited. A LIFO stack immediatel=
y reuses the most recently freed entries, so high indices tend to get reuse=
d first and it becomes difficult to form a contiguous free tail. A low-firs=
t bitmap/slab allocator, or a min-heap, would be better for shrinking becau=
se they prefer lower free indices and therefore leave high indices unused l=
onger.The trade-off is that put/get become more expensive (O(n/64) for bitm=
ap scan or O(log n) for a heap, instead of O(1) for the stack).</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<br>
&gt; Shrinking (reducing pool capacity after usage drops) is not<br>
&gt; part of this series. It would always be best-effort since<br>
&gt; there is no compaction: if any tbl8 group near the end of the<br>
&gt; pool is still in use, the pool cannot shrink. The current LIFO<br>
&gt; free-list makes this less likely by immediately reusing freed<br>
&gt; high indices, which prevents a contiguous free tail from<br>
&gt; forming. A different allocation strategy (e.g. a min-heap<br>
&gt; favoring low indices) could improve shrink opportunities, but<br>
&gt; is better addressed separately.<br>
<br>
Shrinking would be nice to have but not critical in my opinion. I would<br>
prefer if we could add a dynamic resize feature (and possibly RIB node<br>
mempool sharing) for rte_rib* as well so that FIB objects can really be<br>
scaled up on demand. For now, if you run out of space in the RIB, you<br>
will get an ENOSPC error even if the FIB tbl8 pool still has room.<br></blo=
ckquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></=
blockquote></div></div></div><div dir=3D"auto">Agreed. Today tbl8 is only o=
ne side of the sizing problem.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">For rte_rib*, I think we should probably move in a similar direction=
 as well: avoid per-VRF/per-instance worst-case provisioning, while keeping=
 separate global limits for IPv4 and IPv6, e.g. max_ipv4_routes and max_ipv=
6_routes.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The difference=
 with tbl8 is that the trade-off is not the same. tbl8 usage is both expens=
ive (2 KB per group) and hard to predict from route count alone, since it d=
epends on prefix distribution and table shape. RIB nodes are much smaller a=
nd their usage is more predictable, so a shared global node pool per AF alr=
eady looks like a sensible first step.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">That would remove per-VRF over-provisioning while keeping gl=
obal limits. If later true on-demand growth is needed, I think the mechanis=
m would likely have to be different from tbl8 resizing anyway: tbl8 is an i=
ndexed array and can grow via alloc + copy + pointer swap, while RIB nodes =
are linked by pointers, so they cannot be relocated transparently. In that =
case, a chunked allocator would probably make more sense.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Also, I do not think hugepage-backed allo=
cation (i.e. rte_mempool) is really needed for rte_rib*.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Maxime</div></div>

--000000000000e8dd09064e6287fa--
