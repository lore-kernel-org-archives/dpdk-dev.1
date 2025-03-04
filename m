Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F98AC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 06:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9741A40156;
	Tue,  4 Mar 2025 07:50:05 +0100 (CET)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4B45640041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 07:50:04 +0100 (CET)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-52399515bd2so1288025e0c.1
 for <dev@dpdk.org>; Mon, 03 Mar 2025 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741071003;
 x=1741675803; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2btf2Qn7ixilcgl3qopi3eWxBCS9OVY2e3I4ZlQBczo=;
 b=IvsfkgRkYNiC2UDYG1fB/7xhxzEW15iz3qslzPoZg9ahTDBPwkYEn0IQ3s5Aa5porr
 NKg7j8D5wCrlV3FVCiLrESbco9eD4dA8OWSZhk6Bj98kaTp7+6c0QI3kUuUwWs/Iqz97
 AhalqRjFCYv5GOr4QF9kWl/5H1ljC7VuTajrkX24CuK5rHzPsefDaQOLeWQB0t2Ahri6
 blLn1wDgQMJiVhbM9VI929mMGOoStJnieMgeM1P3PiO4LDJO+K4Tb7CETAG5HKE9ChJc
 SELiVnx1qqFQMCW4kN/4BXH1+L0zOKrRVa2Ni3tRU9Nn8r75eGkPgDBdhPggx9K61QAX
 KmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741071003; x=1741675803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2btf2Qn7ixilcgl3qopi3eWxBCS9OVY2e3I4ZlQBczo=;
 b=HeZYAwsEp+jKy9hb7W01GymLzTfWoHg3yGGlzywTWMSnZLZ/Gf0z60NnbsWT693jlt
 67LhIXdl9SBWWrDUKVJQ9b/esfJvQhKTnYOuM0NxdfsNs5rDd38rOZmeiGBfSpR2KWj0
 csS24TlE3ZucFhE/iMM1s6VBwYxUilaQPCyKDLNAfrkWJt9blSn1DiYM1QSvdxcrhtWg
 E3TqIctsLEbC6nmOt3nTMMib6nVubdFeY8N0rol43ZBKGfdxdB6uq598fzp7470EAM3g
 TuBsJ70rvID1OT7Iq2KhzzhbRpYlRZBphT9vdsJZYItUeP3qSBuUaE+O9pm2q1bCDew8
 qLpQ==
X-Gm-Message-State: AOJu0Yw1yfLWrTsO0uklXV7M+h/xT870bvWhg59hMGUPg0oRi4Tcap8T
 nNI7/SFWEIowWEl6aVPmxi4F9gkFtFYSa8cd2wa6CwGH6Gfgyjhp/cHj8DC/CjyrIUzW3gIkvhY
 8O/1igpKlmfUEvQFAZynSlT9eKo9E0TFlULNGJRKO0oePydEfILw=
X-Gm-Gg: ASbGncvEkahx0MEPAltgqGSFgxVhv5i2Yu5QRDEWza/s4JaZQ6tfTyIqD7qFQqzDx+y
 30aWnbN4UsH6mdtNcKE+ejMVPKjmGqOCit0fXsLz/pFZuTFq9ygrkO7nfbzMuldAsuEMD9TgFF0
 /gUy/XcOycOOKDaJKHmPrtzZiHNxW9CiX0WxNf0udXeqiGfRgBUX3s9ECw+RY=
X-Google-Smtp-Source: AGHT+IFbyr49CyuGFBrSoBPIDQ/J3dTOkn4osQKeDJRTucLm1Gj6m/vlp0mEbihTSlRdM2gz593rZc6CNDjzzAHxYeY=
X-Received: by 2002:ac5:c84e:0:b0:523:9cd5:bfde with SMTP id
 71dfb90a1353d-523abce524emr1080760e0c.5.1741071003616; Mon, 03 Mar 2025
 22:50:03 -0800 (PST)
MIME-Version: 1.0
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741042492-6700-1-git-send-email-andremue@linux.microsoft.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 3 Mar 2025 22:49:52 -0800
X-Gm-Features: AQ5f1JrZkmEtkY6r_9fzmuDis1I1AWd73RBgPU35NPbQ6wwBtTb2ufYN2EDhcuI
Message-ID: <CAOaVG16pRvfJKhE-55BKWLs_fFNDD9nfY2ff+K4SYgc-8yTUOQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/fib: remove warning about implicit 64-bit
 conversion
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev <dev@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Content-Type: multipart/alternative; boundary="000000000000b326f3062f7eae4a"
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

--000000000000b326f3062f7eae4a
Content-Type: text/plain; charset="UTF-8"

Better to cast the constant (1) to avoid warning,
.
That is what other code does like RTE_BIT macros

On Mon, Mar 3, 2025, 23:55 Andre Muezerie <andremue@linux.microsoft.com>
wrote:

> MSVC issues the warning below:
>
> ../lib/fib/trie.c(341): warning C4334: '<<':
> result of 32-bit shift implicitly converted to 64 bits
> (was 64-bit shift intended?)
>
> The fix is to cast the result explicitly to uintptr_t since it is used
> in pointer arithmetic.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/fib/trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 4893f6c636..bf9f63eaa2 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t
> *ip_part, uint64_t next_hop,
>                 if (ret < 0)
>                         return ret;
>                 if (edge == LEDGE) {
> -                       write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> +                       write_to_dp((uint8_t *)p + (uintptr_t)(1 <<
> dp->nh_sz),
>                                 next_hop << 1, dp->nh_sz, UINT8_MAX -
> *ip_part);
>                 } else {
>                         write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
> --
> 2.48.1.vfs.0.0
>
>

--000000000000b326f3062f7eae4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Better to cast the constant (1) to avoid warning,<div dir=
=3D"auto">.</div><div dir=3D"auto">That is what other code does like RTE_BI=
T macros</div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 3, 2025, 23:55 Andre Muezer=
ie &lt;<a href=3D"mailto:andremue@linux.microsoft.com">andremue@linux.micro=
soft.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">MSVC issues the warning below:<br>
<br>
../lib/fib/trie.c(341): warning C4334: &#39;&lt;&lt;&#39;:<br>
result of 32-bit shift implicitly converted to 64 bits<br>
(was 64-bit shift intended?)<br>
<br>
The fix is to cast the result explicitly to uintptr_t since it is used<br>
in pointer arithmetic.<br>
<br>
Signed-off-by: Andre Muezerie &lt;<a href=3D"mailto:andremue@linux.microsof=
t.com" target=3D"_blank" rel=3D"noreferrer">andremue@linux.microsoft.com</a=
>&gt;<br>
---<br>
=C2=A0lib/fib/trie.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/fib/trie.c b/lib/fib/trie.c<br>
index 4893f6c636..bf9f63eaa2 100644<br>
--- a/lib/fib/trie.c<br>
+++ b/lib/fib/trie.c<br>
@@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_p=
art, uint64_t next_hop,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (edge =3D=3D LED=
GE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0write_to_dp((uint8_t *)p + (1 &lt;&lt; dp-&gt;nh_sz),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0write_to_dp((uint8_t *)p + (uintptr_t)(1 &lt;&lt; dp-&gt;nh_sz),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_hop &lt;&lt; 1, dp-&gt;nh_sz, U=
INT8_MAX - *ip_part);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_to_dp(get_tbl_p_by_idx(dp-&gt;tbl8, tbl8_idx *<br>
-- <br>
2.48.1.vfs.0.0<br>
<br>
</blockquote></div>

--000000000000b326f3062f7eae4a--
