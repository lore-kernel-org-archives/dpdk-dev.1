Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95258C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 09:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD3364026A;
	Thu, 31 Jul 2025 11:55:04 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id E2A3D4025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 11:55:02 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so644054a12.3
 for <dev@dpdk.org>; Thu, 31 Jul 2025 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1753955702; x=1754560502; darn=dpdk.org;
 h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=e8n1tA3lRR9dFJdTFWOtuAhRbzuhG2XJ5v2Pr4JtBes=;
 b=EqTAsOBj+9EFiKLo69d6BsCOZN6GZWlEMK8c/XNlRrZ2666eeQeRKkbPksXQI05jc3
 ke+K9+8efdAzCZodmqc/64OFMD9xFi2HPDpiTHPJCjutANzdSXmj38a1lhJp9wFrPK4R
 Rk3JZ1JLWnxekygJJxYHK6xvuquxL2CEZR7eTMq/UluskZiZ8YxK8MAaRg23mT8tJW8R
 ncP7UcqhdhpXfVdg03bDSOpQaHpBgbVuQU+mKdLOUB8fUyidaF2RksTqAeMGVIWoo8Qc
 MQvCq/cMxMgfkKPYD5Ax70L2OMChrUgxOQ0aeSEryW6DGixPvBeKZ8ozvzcCHzSVqzqc
 a/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955702; x=1754560502;
 h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8n1tA3lRR9dFJdTFWOtuAhRbzuhG2XJ5v2Pr4JtBes=;
 b=V/yyyqD+03uNHT65WjMrFL+nOSY2Rb8MZ7dNQcU4WBWUonk/doKlPpR8BnwqhWfGQq
 YrQVtqIVlQ1Rzy66S8fp22pSmWu4gDlwyTU6gRTr8Yo0d1vDvSuWuEnoOZwqBuACcLs6
 gaCjSpfj4mubDwmCMskgJ0xLyZh7dw82zmWvzKrU3GPNiT6jnxwaKt0fG/DHvHy975gT
 bq157hCOCbXfg2bCcHa49N/U/7zCXKc/WTAlJJZnYYF7PFmEq3LYvyGMagPGbfiSNHEs
 G0xqjjwKt+cYM8gLauva5YhMeLSz9h/c/X1RGxbyZp04NTyntdvS9ZXC5crLVHDWJTtR
 OKZQ==
X-Gm-Message-State: AOJu0YwqwYhsPqLHlGEouJvrQ34y6DktqzFbkGf/5m5Os9XPpgQiT7hg
 ERKuO2HjpMHJIB9wsYvSnJL+dM16jHo/7U7wnvLt2yZqpC4OCa8iMyPwxmZ90W3YQqRgz0sPK0V
 Lf4z76KON8jYX6kOziGhhm6ie6GY2TCvhBPua4tl3UgajPVGElRnR
X-Gm-Gg: ASbGncsYo59EqRxM9EleNkmUWOFSBgYW39ELDLfSKwqPhYQZ34pT0NV/0QZsMFwR6vK
 Ub2cuAEkjgKhoPMn1Mcb3eTL3wnPJ94QoEJfS0DOJjiX0+pWzGiIExRKC2GX3LENQyzXCJ23QHC
 fyQFQWVFWfTgOmYn5tu5ElwGJMDxPJZGI/3cGp5fHOse1/VAfP5LpO6NuZIMur4PKvabacwPbaP
 QST6LO0+A==
X-Google-Smtp-Source: AGHT+IGSZfsSPKqyc9dVK2HXwBKa/bfnMrBR6OzdkI0FaEbyv8lVr+bnLFjQ7VBzr2nteAXL6LNxrFYknjyQ1Vu0xRY=
X-Received: by 2002:a17:90b:438e:b0:31e:cb1a:3dc5 with SMTP id
 98e67ed59e1d1-31f5dde7723mr8118514a91.11.1753955701830; Thu, 31 Jul 2025
 02:55:01 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 31 Jul 2025 02:55:01 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 31 Jul 2025 02:55:01 -0700
From: =?UTF-8?B?6IuP6LWb?= <susai.ss@bytedance.com>
Mime-Version: 1.0
Date: Thu, 31 Jul 2025 02:55:01 -0700
X-Gm-Features: Ac12FXxc71F34_URwZ2a1snu5Dl3gwhUGOWFsFK3gL1pT4BezT0RKsaK1xQCHtA
Message-ID: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
Subject: [PATCH] net/cksum: compute raw cksum for several segments
To: "jasvinder.singh@intel.com" <jasvinder.singh@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000008f52a3063b36a2e6"
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

--0000000000008f52a3063b36a2e6
Content-Type: text/plain; charset="UTF-8"

The rte_raw_cksum_mbuf function is used to compute
the raw checksum of a packet.
If the packet payload stored in multi mbuf, the function
will goto the hard case. In hard case,
the variable 'tmp' is a type of uint32_t,
so rte_bswap16 will drop high 16 bit.
Meanwhile, the variable 'sum' is a type of uint32_t,
so 'sum += tmp' will drop the carry when overflow.
Both drop will make cksum incorrect.
This commit fixes the above bug.

Signed-off-by: Su Sai <susai.ss@bytedance.com>
---
 .mailmap            |  1 +
 lib/net/rte_cksum.h | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..838b544a97 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1891,3 +1891,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu> <
zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
 Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
+Su Sai <susai.ss@bytedance.com>
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..aa584d5f8d 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
         return (uint16_t)sum;
 }

+/**
+ * @internal Reduce a sum to the non-complemented checksum.
+ * Helper routine for the rte_raw_cksum_mbuf().
+ *
+ * @param sum
+ *   Value of the sum.
+ * @return
+ *   The non-complemented checksum.
+ */
+static inline uint16_t
+__rte_raw_cksum_reduce_u64(uint64_t sum)
+{
+        uint32_t tmp;
+
+        tmp = __rte_raw_cksum_reduce((uint32_t)sum);
+        tmp += __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
+        return __rte_raw_cksum_reduce(tmp);
+}
+
 /**
  * Process the non-complemented checksum of a buffer.
  *
@@ -119,8 +138,9 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 {
         const struct rte_mbuf *seg;
         const char *buf;
-        uint32_t sum, tmp;
+        uint32_t tmp;
         uint32_t seglen, done;
+        uint64_t sum;

         /* easy case: all data in the first segment */
         if (off + len <= rte_pktmbuf_data_len(m)) {
@@ -157,7 +177,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
         for (;;) {
                 tmp = __rte_raw_cksum(buf, seglen, 0);
                 if (done & 1)
-                        tmp = rte_bswap16((uint16_t)tmp);
+                        tmp = rte_bswap32(tmp);
                 sum += tmp;
                 done += seglen;
                 if (done == len)
@@ -169,7 +189,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
                         seglen = len - done;
         }

-        *cksum = __rte_raw_cksum_reduce(sum);
+        *cksum = __rte_raw_cksum_reduce_u64(sum);
         return 0;
 }

-- 
2.39.2 (Apple Git-143)

--0000000000008f52a3063b36a2e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div id=3D"editor_version_7.48.0_0Rxwdj61" style=3D"word-break:break-word">=
<div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D=
"ltr" style=3D"direction:ltr;font-size:14px">The rte_raw_cksum_mbuf functio=
n is used to compute</div></div><div style=3D"margin-top:4px;margin-bottom:=
4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">the raw che=
cksum of a packet.</div></div><div style=3D"margin-top:4px;margin-bottom:4p=
x;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">If the packet=
 payload=C2=A0stored in multi mbuf, the function</div></div><div style=3D"m=
argin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D=
"font-size:14px">will goto=C2=A0the hard case. In=C2=A0hard case,</div></di=
v><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=
=3D"auto" style=3D"font-size:14px">the variable &#39;tmp&#39; is a type of =
uint32_t,</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-he=
ight:1.6"><div dir=3D"auto" style=3D"font-size:14px">so rte_bswap16 will dr=
op high 16 bit.</div></div><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">Meanwhile, the v=
ariable &#39;sum&#39; is a type of uint32_t,</div></div><div style=3D"margi=
n-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"fon=
t-size:14px">so &#39;sum +=3D tmp&#39; will drop the carry when overflow.</=
div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><=
div dir=3D"auto" style=3D"font-size:14px">Both drop=C2=A0will make cksum in=
correct.</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-hei=
ght:1.6"><div dir=3D"auto" style=3D"font-size:14px">This commit fixes the a=
bove bug.</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-he=
ight:1.6"><div dir=3D"auto" style=3D"font-size:14px"><br></div></div><div s=
tyle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto"=
 style=3D"font-size:14px">Signed-off-by: Su Sai &lt;<a class=3D"not-doclink=
" href=3D"mailto:susai.ss@bytedance.com" target=3D"_blank" rel=3D"noopener =
noreferrer" style=3D"text-decoration:none;color:rgb(20,86,240)">susai.ss@by=
tedance.com</a>&gt;</div></div><div style=3D"margin-top:4px;margin-bottom:4=
px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">---</div></d=
iv><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=
=3D"auto" style=3D"font-size:14px">=C2=A0.mailmap =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 |=C2=A0 1 +</div></div><div style=3D"margin-top:4px;margin=
-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=
=A0lib/net/rte_cksum.h | 26 +++++++++++++++++++++++---</div></div><div styl=
e=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" st=
yle=3D"font-size:14px">=C2=A02 files changed, 24 insertions(+), 3 deletions=
(-)</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1=
.6"><div dir=3D"auto" style=3D"font-size:14px"><br></div></div><div style=
=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" sty=
le=3D"font-size:14px">diff --git a/.mailmap b/.mailmap</div></div><div styl=
e=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" st=
yle=3D"font-size:14px">index 34a99f93a1..838b544a97 100644</div></div><div =
style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto=
" style=3D"font-size:14px">--- a/.mailmap</div></div><div style=3D"margin-t=
op:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-s=
ize:14px">+++ b/.mailmap</div></div><div style=3D"margin-top:4px;margin-bot=
tom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">@@ -189=
1,3 +1891,4 @@ Zoltan Kiss &lt;<a class=3D"not-doclink" href=3D"mailto:zolt=
an.kiss@schaman.hu" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"=
text-decoration:none;color:rgb(20,86,240)">zoltan.kiss@schaman.hu</a>&gt; &=
lt;<a class=3D"not-doclink" href=3D"mailto:zoltan.kiss@linaro.org" target=
=3D"_blank" rel=3D"noopener noreferrer" style=3D"text-decoration:none;color=
:rgb(20,86,240)">zoltan.kiss@linaro.org</a>&gt;</div></div><div style=3D"ma=
rgin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"=
font-size:14px">=C2=A0Zorik Machulsky &lt;<a class=3D"not-doclink" href=3D"=
mailto:zorik@amazon.com" target=3D"_blank" rel=3D"noopener noreferrer" styl=
e=3D"text-decoration:none;color:rgb(20,86,240)">zorik@amazon.com</a>&gt;</d=
iv></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><d=
iv dir=3D"auto" style=3D"font-size:14px">=C2=A0Zyta Szpak &lt;<a class=3D"n=
ot-doclink" href=3D"mailto:zyta@marvell.com" target=3D"_blank" rel=3D"noope=
ner noreferrer" style=3D"text-decoration:none;color:rgb(20,86,240)">zyta@ma=
rvell.com</a>&gt; &lt;<a class=3D"not-doclink" href=3D"mailto:zr@semihalf.c=
om" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"text-decoration:=
none;color:rgb(20,86,240)">zr@semihalf.com</a>&gt;</div></div><div style=3D=
"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=
=3D"font-size:14px">=C2=A0Zyta Szpak &lt;<a class=3D"not-doclink" href=3D"m=
ailto:zyta@marvell.com" target=3D"_blank" rel=3D"noopener noreferrer" style=
=3D"text-decoration:none;color:rgb(20,86,240)">zyta@marvell.com</a>&gt; &lt=
;<a class=3D"not-doclink" href=3D"mailto:zyta.szpak@semihalf.com" target=3D=
"_blank" rel=3D"noopener noreferrer" style=3D"text-decoration:none;color:rg=
b(20,86,240)">zyta.szpak@semihalf.com</a>&gt;</div></div><div style=3D"marg=
in-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"fo=
nt-size:14px">+Su Sai &lt;<a class=3D"not-doclink" href=3D"mailto:susai.ss@=
bytedance.com" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"text-=
decoration:none;color:rgb(20,86,240)">susai.ss@bytedance.com</a>&gt;</div><=
/div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div d=
ir=3D"auto" style=3D"font-size:14px">diff --git a/lib/net/rte_cksum.h b/lib=
/net/rte_cksum.h</div></div><div style=3D"margin-top:4px;margin-bottom:4px;=
line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">index a8e892795=
2..aa584d5f8d 100644</div></div><div style=3D"margin-top:4px;margin-bottom:=
4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">--- a/lib/n=
et/rte_cksum.h</div></div><div style=3D"margin-top:4px;margin-bottom:4px;li=
ne-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">+++ b/lib/net/rte=
_cksum.h</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-hei=
ght:1.6"><div dir=3D"auto" style=3D"font-size:14px">@@ -80,6 +80,25 @@ __rt=
e_raw_cksum_reduce(uint32_t sum)</div></div><div style=3D"margin-top:4px;ma=
rgin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px"=
>=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (uint16_t)sum;</div></div><div st=
yle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" =
style=3D"font-size:14px">=C2=A0}</div></div><div style=3D"margin-top:4px;ma=
rgin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px"=
><span>=C2=A0
</span></div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-heig=
ht:1.6"><div dir=3D"auto" style=3D"font-size:14px">+/**</div></div><div sty=
le=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" s=
tyle=3D"font-size:14px">+ * @internal Reduce a sum to the non-complemented =
checksum.</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-he=
ight:1.6"><div dir=3D"auto" style=3D"font-size:14px">+ * Helper routine for=
 the rte_raw_cksum_mbuf().</div></div><div style=3D"margin-top:4px;margin-b=
ottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">+ *</=
div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><=
div dir=3D"auto" style=3D"font-size:14px">+ * @param sum</div></div><div st=
yle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" =
style=3D"font-size:14px">+ * =C2=A0 Value of the sum.</div></div><div style=
=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" sty=
le=3D"font-size:14px">+ * @return</div></div><div style=3D"margin-top:4px;m=
argin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px=
">+ * =C2=A0 The non-complemented checksum.</div></div><div style=3D"margin=
-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font=
-size:14px">+ */</div></div><div style=3D"margin-top:4px;margin-bottom:4px;=
line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">+static inline =
uint16_t</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-hei=
ght:1.6"><div dir=3D"auto" style=3D"font-size:14px">+__rte_raw_cksum_reduce=
_u64(uint64_t sum)</div></div><div style=3D"margin-top:4px;margin-bottom:4p=
x;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">+{</div></div=
><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=
=3D"auto" style=3D"font-size:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0 uint32_t tm=
p;</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.=
6"><div dir=3D"auto" style=3D"font-size:14px">+</div></div><div style=3D"ma=
rgin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"=
font-size:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0 tmp =3D __rte_raw_cksum_reduce=
((uint32_t)sum);</div></div><div style=3D"margin-top:4px;margin-bottom:4px;=
line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">+ =C2=A0 =C2=A0=
 =C2=A0=C2=A0 tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum &gt;&gt; 32));=
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div dir=3D"auto" style=3D"font-size:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0 re=
turn __rte_raw_cksum_reduce(tmp);</div></div><div style=3D"margin-top:4px;m=
argin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px=
">+}</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:=
1.6"><div dir=3D"auto" style=3D"font-size:14px">+</div></div><div style=3D"=
margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=
=3D"font-size:14px">=C2=A0/**</div></div><div style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=
=C2=A0 * Process the non-complemented checksum of a buffer.</div></div><div=
 style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"aut=
o" style=3D"font-size:14px">=C2=A0 *</div></div><div style=3D"margin-top:4p=
x;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:1=
4px">@@ -119,8 +138,9 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint3=
2_t=C2=A0off, uint32_t=C2=A0len,</div></div><div style=3D"margin-top:4px;ma=
rgin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px"=
>=C2=A0{</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-hei=
ght:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const struct rte_mbuf *seg;</div></div><div style=3D"margin-top:=
4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size=
:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf;</div></div><div s=
tyle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto"=
 style=3D"font-size:14px">- =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0sum, t=
mp;</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1=
.6"><div dir=3D"auto" style=3D"font-size:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0=
 uint32_t tmp;</div></div><div style=3D"margin-top:4px;margin-bottom:4px;li=
ne-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t seglen, done;</div></div><div style=3D"margin-to=
p:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-si=
ze:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0 uint64_t sum;</div></div><div style=
=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" sty=
le=3D"font-size:14px"><span>=C2=A0
</span></div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-heig=
ht:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* easy case: all data in the first segment */</div></div><div s=
tyle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto"=
 style=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (off + len &=
lt;=3D rte_pktmbuf_data_len(m)) {</div></div><div style=3D"margin-top:4px;m=
argin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px=
">@@ -157,7 +177,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t=
=C2=A0off, uint32_t=C2=A0len,</div></div><div style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;) {</div></div><div style=3D"margi=
n-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"fon=
t-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
tmp =3D __rte_raw_cksum(buf, seglen, 0);</div></div><div style=3D"margin-to=
p:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-si=
ze:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
done &amp; 1)</div></div><div style=3D"margin-top:4px;margin-bottom:4px;lin=
e-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 tmp =
=3D rte_bswap16((uint16_t)tmp);</div></div><div style=3D"margin-top:4px;mar=
gin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 tmp =3D rte_bswap32(tmp);</div></div><div style=3D"margin-top:4px=
;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14=
px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sum +=3D =
tmp;</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:=
1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done +=3D seglen;</div></div><div style=
=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" sty=
le=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (done =3D=3D len)</div></div><div style=3D"margin-top:4px;mar=
gin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=
@@ -169,7 +189,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t=
=C2=A0off, uint32_t=C2=A0len,</div></div><div style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 seglen =3D len - done;</div></div><div style=3D"margin-top:4=
px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:=
14px">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div></div><div style=3D"margin-t=
op:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-s=
ize:14px"><span>=C2=A0
</span></div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-heig=
ht:1.6"><div dir=3D"auto" style=3D"font-size:14px">- =C2=A0 =C2=A0 =C2=A0=
=C2=A0 *cksum =3D __rte_raw_cksum_reduce(sum);</div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"f=
ont-size:14px">+ =C2=A0 =C2=A0 =C2=A0=C2=A0 *cksum =3D __rte_raw_cksum_redu=
ce_u64(sum);</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line=
-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return 0;</div></div><div style=3D"margin-top:4px;margin-bot=
tom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">=C2=A0}=
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div dir=3D"auto" style=3D"font-size:14px"><span>=C2=A0
</span></div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-heig=
ht:1.6"><div dir=3D"auto" style=3D"font-size:14px">--=C2=A0</div></div><div=
 style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"aut=
o" style=3D"font-size:14px">2.39.2 (Apple Git-143)</div></div><div style=3D=
"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=
=3D"font-size:14px"><br></div></div></div>

--0000000000008f52a3063b36a2e6--
