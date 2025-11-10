Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 16:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDA940280;
	Mon, 10 Nov 2025 17:29:40 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 6C84C4026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 17:29:39 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b72cbc24637so597554766b.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762792179; x=1763396979; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UuGVg1R4LmqrC7KhTKqMBwa6l1jBiBTdMDn+dLq6KpQ=;
 b=L4eJLQIePL7Nq0iH5Dt1sldLwqfznOcGxwc5KLW17gUL+9mWBknDWypKxErzQ8O/AU
 j6K3U0ygAUseYV1ISVjY6vmrnE0BmudUIKhZwDfeqAh7Zdk4m3RbKzgegpLqpkaKAv2J
 F7/eP8ZXU3fi5PnLbAEg9b1zsQLRj6zmNRqkV/k2m48JQNJGArPwIXI5qE3/8I3kTM8S
 DkFo6V+me4sMW+APGKrJkma+aYSCmD5I+zLu+MeIcjR4FjFWloOoR/gHcDsIZ3LztkPC
 79ceJ5pZz+7O7y2FrVmJhy5PpapPS3XNhhiwtrH21ZXnDFB1sSLEM/+/KtBQgo2NU8fg
 W1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762792179; x=1763396979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuGVg1R4LmqrC7KhTKqMBwa6l1jBiBTdMDn+dLq6KpQ=;
 b=DV6d5NqiYbCcFaUrwfjDQWDOxqOqLJEFEOAGeYBevKldtdVBgZ5hVcvym8PAGe1YJH
 gUPfOpwgaZi36H6ZY5LM5/Kb4M2sLYckGPKtGgyt8ipokfm1IqTuywry9GbdBDztkplS
 DGBNABUfr2YOHVzu7BSRixp3w3jh9cYIGq/KkPNODsHj01waQnX59YHfg1AERn8PPB4/
 OLgKk1uWqTqAWTDb7c/54Dl7vHW3D/yRaICd5iWln+980QCX3sYfWQZTPv5JYhAwsr+V
 QRw04phznVlP1c8CGDFclHxIHvNKJqOYJKtBAmbeQN2Uf1O5OygQiygmCn8KqKd2WGJj
 L4ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+3XSau8Ydv4vKeXjiqnClxEd2dwL1SBLsv4RE740FH4FOOgFhDUP/llTdw95WW6j5JqY=@dpdk.org
X-Gm-Message-State: AOJu0YxljG9hJ0BysFh4PTgtIfzRqBePne7DCkK6Vn4gNLI9E4q5VENP
 2164OKVaumTluy1Fj+h7KwhatlpY/hs6nf0iVUy9ILSmZnkOfjX3yj72YniQ8B1vDUGmyCksxWn
 tIpeZ7BxXezjTsU3vVUP8K5CKRAEKauQ=
X-Gm-Gg: ASbGncvC23t5X3JwG9TI8yZWU4hsO1tp2QFZimfCLWkX0tz0AOidDfKBVlBvOXp+ENY
 8gNrFXXfEqQnLz3YqZdaKGGu/vIJu7SuQzRuUQJQXXKvsPZuW3E8xu6HaJ5FCkSxQwaslZr/eLM
 Nm0GB/54LCSfaBcOdqotG/02IGyPFo4DwVN5JbQRmZ0CGCuQo1l+Azvz4Kb1Ro3p9N6e2QRCCJQ
 Ro/vkT1GHNE8x3Kxqvtf1IViNbQWKc9m2afeviUmmSUre8rd8afAkOi39/iwaU8WHig0KSzYbOx
 fqxgHLe2enapZBaEMZIR+CyZm84=
X-Google-Smtp-Source: AGHT+IEJRGhxkc3iA+GjIgvPm3YDp+FMeMTfqAfNbyDxnsTb9HY1PYg5sAKgfFrLv6rV+X0XC7IyhRetnXCGXGE5jtY=
X-Received: by 2002:a17:907:9482:b0:b70:aae8:7f40 with SMTP id
 a640c23a62f3a-b72e0315729mr889001666b.14.1762792178734; Mon, 10 Nov 2025
 08:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20250101093735.95271-1-kumaraparamesh92@gmail.com>
 <20250101092138.4fb5fdee@fedora>
In-Reply-To: <20250101092138.4fb5fdee@fedora>
From: kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
Date: Mon, 10 Nov 2025 21:59:25 +0530
X-Gm-Features: AWmQ_blTTjPLu-d7OtOkeaCOSeKUZ7Fcek0BuLnQEVnR6CU--qlnaC8YuvDWgGk
Message-ID: <CANxNyavFd1qZijK7CQd-Nq5OSEw1YmH0OEztor+K1wpfLx7FeA@mail.gmail.com>
Subject: Re: [PATCH] lib/gro: use hash function for flow lookup
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: hujiayu.hu@foxmail.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a059db0643400982"
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

--000000000000a059db0643400982
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 10:51=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed,  1 Jan 2025 15:07:35 +0530
> Kumara Parameshwaran <kumaraparamesh92@gmail.com> wrote:
>
> > From: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
> > To: hujiayu.hu@foxmail.com
> > Cc: dev@dpdk.org,  Kumara Parameshwaran <kumaraparamesh92@gmail.com>
> > Subject: [PATCH] lib/gro: use hash function for flow lookup
> > Date: Wed,  1 Jan 2025 15:07:35 +0530
> > X-Mailer: git-send-email 2.47.1
> >
> > optimize the GRO lookup using hash based
> > implementation
> >
> > Signed-off-by: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
>
> Rather than open coding a hash table with collision chains, please use th=
e
> existing DPDK cuckoo hash which is faster and you can also prevent hash
> DoS chain attacks.
>
>> http://dpdk.org/patch/158636 @Stephen Hemminger
>> <stephen@networkplumber.org>  - Please find the link to the patch. This
>> is sample implementation with test. Please let me know if it looks fine,
>> would add more test cases.
>
>
> Alternatively, use a better hash function such as siphash which is
> resistent
> to DoS attacks.
>

--000000000000a059db0643400982
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 1, =
2025 at 10:51=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed,=C2=A0 1 Jan 2025 15:07:=
35 +0530<br>
Kumara Parameshwaran &lt;<a href=3D"mailto:kumaraparamesh92@gmail.com" targ=
et=3D"_blank">kumaraparamesh92@gmail.com</a>&gt; wrote:<br>
<br>
&gt; From: Kumara Parameshwaran &lt;<a href=3D"mailto:kumaraparamesh92@gmai=
l.com" target=3D"_blank">kumaraparamesh92@gmail.com</a>&gt;<br>
&gt; To: <a href=3D"mailto:hujiayu.hu@foxmail.com" target=3D"_blank">hujiay=
u.hu@foxmail.com</a><br>
&gt; Cc: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>=
,=C2=A0 Kumara Parameshwaran &lt;<a href=3D"mailto:kumaraparamesh92@gmail.c=
om" target=3D"_blank">kumaraparamesh92@gmail.com</a>&gt;<br>
&gt; Subject: [PATCH] lib/gro: use hash function for flow lookup<br>
&gt; Date: Wed,=C2=A0 1 Jan 2025 15:07:35 +0530<br>
&gt; X-Mailer: git-send-email 2.47.1<br>
&gt; <br>
&gt; optimize the GRO lookup using hash based<br>
&gt; implementation<br>
&gt; <br>
&gt; Signed-off-by: Kumara Parameshwaran &lt;<a href=3D"mailto:kumaraparame=
sh92@gmail.com" target=3D"_blank">kumaraparamesh92@gmail.com</a>&gt;<br>
<br>
Rather than open coding a hash table with collision chains, please use the<=
br>
existing DPDK cuckoo hash which is faster and you can also prevent hash<br>
DoS chain attacks.<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><a =
href=3D"http://dpdk.org/patch/158636">http://dpdk.org/patch/158636</a>=C2=
=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:steph=
en@networkplumber.org" tabindex=3D"-1">@Stephen Hemminger</a>=C2=A0 - Pleas=
e find the link to the patch. This is sample implementation with test. Plea=
se let me know if it looks fine, would add more test cases.=C2=A0</blockquo=
te>
<br>
Alternatively, use a better hash function such as siphash which is resisten=
t<br>
to DoS attacks.<br>
</blockquote></div></div>

--000000000000a059db0643400982--
