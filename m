Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF4C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 11:09:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 445B74042F;
	Sat, 17 May 2025 13:09:45 +0200 (CEST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by mails.dpdk.org (Postfix) with ESMTP id 97E22402E5
 for <dev@dpdk.org>; Sat, 17 May 2025 13:09:43 +0200 (CEST)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-52c85c0d473so1072749e0c.2
 for <dev@dpdk.org>; Sat, 17 May 2025 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747480183;
 x=1748084983; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qVvSwvdWb4+QhiNl/2vo9cTHJ7vIPKhOEOKw5wqUCB4=;
 b=TvRSOFl5myYXNjPcCGuzJuIEBgG2p0t+Z/kvvi0Gh51LPUEaJY3jvBAyWmdGn+Q7lS
 bmmnn9HoJahN3C0cKI+QGOtY0D2HgErGoYMLVjkbi5luMFtGW4Y4IbvLzay9LGnvfxVv
 u8K7TuzbVrV5EHprxSSfXQYK4wRLCcQy0sILG5VnHScaJ1q7L2EMFLTsyZDUbiUjjhkx
 6TV+08oayT9TlV2DjVbgkxoLIeII/YE637vpgoC3D41rVrO5Lbi/8VYaJ10Uqz5fFLYO
 0qmp2umixUMb3kHLoHShf/PtMIM2AL1UmETn6PivdDhKLw1MVTE81M1ZD01geRvvWTzc
 RrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747480183; x=1748084983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVvSwvdWb4+QhiNl/2vo9cTHJ7vIPKhOEOKw5wqUCB4=;
 b=ivjHgMJREqWPUAnLbLU5M8Ew/RulV3Sa/SVil0xk4QJgedJUPtWB/NmRKg7UGvM7WT
 FzFu7GBLLPih/XAbnm8L8xhilAQVkZhQ/5yQNiAWUBRYqLVQoccO6xIgYBIxHc7+FBt6
 XCOgDeoDxQWRaxejGEyZKopAC/kk45j0j9eGL53650pkkx385vUr56mpEIpokkxotUGk
 s/ggfHWdgRg8h9CtdOnVPgx9BI5QZTYqIwfiwAc2pOpfpcHflnJKBlfUjGTX37uO/VnM
 Qu4OPNOREaseMUbZV2XuxuIcSHamD5reeI6J7HavXNcyIykGc0zESv0WiUP/9osR0y3F
 aaEg==
X-Gm-Message-State: AOJu0YwMoP5nomjNEqhJWKSw2uUZRocoHBs+BIOnQOAwCVwYm8ogaAp5
 fG2uX54d0PqUrR2DbD9LPKD7QGHoLCb3WEtHiKmx9+0RuykUEatuc5cg+LJRxVy9sIyPebt9zkE
 esCmC5k6MotnMKb0LB8XaWWNKhDgPDP+/N3hFKSl1LHV/WcXWvZVpmK03PA==
X-Gm-Gg: ASbGncsKPKSV4T0IIO0nZc+nMVVtGUhomjceFX2DQwbR6M52Z1dQ37j44LH+h20C9d6
 vpqMJGLaWPjPguS4CedpXug4Htc6QL3Ecvm3TSAhtXlLHMD4IOsTSU4NRnZPiRIsvfSG2QMEflB
 PMgpaqua9/L8u8fDjlYQAEMl1qSLRIjeN2/Db+Bno13/Kiaw==
X-Google-Smtp-Source: AGHT+IE9LldE195WjihrYEs1xgcNG6zIDvhQlfd/nEXrIighwWzzXu9AVDBBOI0xs7VtlNzmq5vIVLHwxO3mJKfzBoM=
X-Received: by 2002:a05:6122:4085:b0:52a:bf98:55b with SMTP id
 71dfb90a1353d-52dba83b131mr7315275e0c.3.1747480182726; Sat, 17 May 2025
 04:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 17 May 2025 20:09:32 +0900
X-Gm-Features: AX0GCFvE6SjZomI0D1KKxNMPva2D3cVVx8l9HEmf5lDdOl831hywEOD98Yv_Xk0
Message-ID: <CAOaVG15FDQTGgtA6VkqGMR1A=DwXvTYGGGcxDrNQrtqjxZxxhg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev <dev@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Content-Type: multipart/alternative; boundary="0000000000008b3e5e063552efe4"
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

--0000000000008b3e5e063552efe4
Content-Type: text/plain; charset="UTF-8"

Ok.
Wonder if RTE_PTR_ADD should have the cast there instead

On Sat, May 17, 2025, 05:45 Andre Muezerie <andremue@linux.microsoft.com>
wrote:

> MSVC issues the warning below:
>
> ../lib/fib/trie.c(341): warning C4334: '<<':
> result of 32-bit shift implicitly converted to 64 bits
> (was 64-bit shift intended?)
>
> The fix is to cast (1) explicitly to uintptr_t since it is used
> in pointer arithmetic.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/fib/trie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 6c20057ac5..24a08b827d 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t
> *ip_part, uint64_t next_hop,
>                 if (ret < 0)
>                         return ret;
>                 if (edge == LEDGE) {
> -                       write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
> +                       write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) <<
> dp->nh_sz),
>                                 next_hop << 1, dp->nh_sz, UINT8_MAX -
> *ip_part);
>                 } else {
>                         write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
> --
> 2.49.0.vfs.0.3
>
>

--0000000000008b3e5e063552efe4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok.<div dir=3D"auto">Wonder if RTE_PTR_ADD should have th=
e cast there instead=C2=A0</div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 17, 2025,=
 05:45 Andre Muezerie &lt;<a href=3D"mailto:andremue@linux.microsoft.com">a=
ndremue@linux.microsoft.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">MSVC issues the warning below:<br>
<br>
../lib/fib/trie.c(341): warning C4334: &#39;&lt;&lt;&#39;:<br>
result of 32-bit shift implicitly converted to 64 bits<br>
(was 64-bit shift intended?)<br>
<br>
The fix is to cast (1) explicitly to uintptr_t since it is used<br>
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
index 6c20057ac5..24a08b827d 100644<br>
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
=A0 =C2=A0write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) &lt;&lt; dp-&gt;nh_sz),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next_hop &lt;&lt; 1, dp-&gt;nh_sz, U=
INT8_MAX - *ip_part);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_to_dp(get_tbl_p_by_idx(dp-&gt;tbl8, tbl8_idx *<br>
-- <br>
2.49.0.vfs.0.3<br>
<br>
</blockquote></div>

--0000000000008b3e5e063552efe4--
