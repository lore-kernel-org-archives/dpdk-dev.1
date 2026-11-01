Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A5606A324
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qh4gnT1V
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6292D4027A;
	Sun,  1 Nov 2026 10:17:29 +0100 (CET)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 5EF8A40279
 for <dev@dpdk.org>; Sun,  1 Nov 2026 10:17:27 +0100 (CET)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-7bec5112765so1468571137.1
 for <dev@dpdk.org>; Sun, 01 Nov 2026 01:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793524646; cv=none;
 d=google.com; s=arc-20260327;
 b=n98/jiriCZb44Y/Afw41ylCi4M6W2hZCHicS9IyfCElCmiAUBJXq1tzQrhVV9hSfwI
 6K7+eDu0cw7f9yKqc8zthv60oABgiLBB0oKbTzmqAwpMr5L5oi6i4aqRkjK64K1zKOxq
 6n7olybqyftHI9h/Ij1cLzPVYRnIxluNGK9X6wQQnVgdCPgvfW1h0ggYHNZ7ZTS7YixK
 4VQf0NNvDNKEUOBamIAsn9phElHeN6GYbu7hYVVD8hY/Bjg2LWCX1MDB8dq6vOiG/BXA
 hHsvmLJM24Td9OobhOd89c37J0mam4Xe8MGlWLIVr8n24WekksK97Fe3EiKzVYGYBeoU
 QeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bNJM1yDw95Vd+7zludQEsIN1QHOtXmEmap1YX+210tM=;
 fh=VP1cVJADGkxCRqytTJt43nKD4bXtqp66v9BF2ZTdFO4=;
 b=dbCVMaOhP3T2qfXzd/WZye+hwFhxIfENdyNyxVhEte2g2JZg7emLadcGWtmAmqwfge
 gINps0+uNos7OE8qJimQ9+HrA9jwIpF6Z4lCRQqnTqxjej5tLUx9xQ9L1/IG3q9h8JIX
 L8fqid7F2luq8RS/eb2VmpcgCccWm5ZfwW0tGcOSfQtXuqyLmwNwrIQEziI8gFy1xUkE
 rW4iNSJ0c7wRsQLdVJ/bDGpZcjUg3PKW6xEm3qjiAGJJ83XC1qdOJWoKeLyL8D6c+zFh
 CgNNxXDSVcICkO9+BbyvBhgipo7AQSFp+GC2YjvLkeI24gG0Wm1SagMNXMwVrmoAVkDR
 6nag==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793524646;
 x=1794129446; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bNJM1yDw95Vd+7zludQEsIN1QHOtXmEmap1YX+210tM=;
 b=Qh4gnT1V30doSr5Ju8fQx5bo47XcfpZI0Lvb9kHuJ9DKtPXCZD/QmrCcPqyE5d164W
 YkJEpbnaWOwOOcOVMP2K2wV9ql0DDsH/ifV/CWb7VweqAvS6KNywf/X293/v8vY8tdn5
 wkf+Hvj+amzmQ1+/00EqUbMsFWEZtfoTYESPAKhaDNxXXLWNols6Yr9yS//2wMOY6/5p
 pqiqRily99+MmHhTiykHXEnxlPRQ15tL6++DcQbK2PwEme70tVbYPUeU0v8qPlzk+hL7
 u/w7hd1oJjOgX0awiGn50qobc7EcoBUukEdypio3xn1BcIlgA02npGCVJwp1r/+Koj8x
 ERMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793524646; x=1794129446;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bNJM1yDw95Vd+7zludQEsIN1QHOtXmEmap1YX+210tM=;
 b=R97Gl/KQ5aIzYwxABzBpu4ipagtdemJNuto9FhWl3I51N4f74KjIlWZAAOGN1HzuPL
 ZyQMRzOphf+t40sRSpS1i7ryae2AcjnSumhnm4epni3C0AjYnxuVxKuPA025KdwXKYFw
 xP8Bpc1AvQ6pFORnmzuP98dDAxXViPqJC43FDWfNGMi2ZyhuHvYsC1AUleJUP6QRln1M
 JPAiSIatEK+4M75rxqBK5jAGPMfyTlxwMuY8fBwS0JFmluMKB36nxSlvv3461q4wojvq
 4eJzF9YeqiITZ7hbOVxutlWQkfEzQ1HjkawbG6FbeAn3ZLDBBmwurvz6PnrgjsKvAFUi
 uHXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUcr0NPbrN4/KQeRNSfHSQRlkTG8F2fvY+OFQ38VrO7pCTRc9I26Ma1zjWxUMTvbfcle0=@dpdk.org
X-Gm-Message-State: AFq9FYKkX8DfGRji7YIYjAn8FfdexgaLySvspeWzMmvu2vpXh0HX5far
 O+di6LVvWvaijhg9TSJ/vHitTFqgczSWOakySXvOCMsbdCQet1S2OpjJR6zYUUTWGE2LLtLDOrA
 5EFE1QGnwsrC5M5RLe+nfAkrWEgu+Z1zliwE2ShAfiA==
X-Gm-Gg: AYBFou2DlREyiMbAdYyTjmAG8hfF8GGQ+YZhZW4iQomfUAToIS6bfvc0pvyh9LAVVGy
 Xmw789hNjOnHADhwgmipfj0LLvNV40mY1zg2hzGSZfIs563NvzMB4mAZ9tzod+prOURXqU333vL
 xeMK5yKJ/tpCCBcOkEcmykLY0ar5t+E1QaViAeFDdXxiT3u+OW+8+egIjsSARy9NptM8KqCWDlZ
 8wIl+QZUdBTxRAEmw7HUKiufCc1L4TerOab3eqcR2nxhps9JIaKF2hmqt3nftFZWGVmTYscerGT
 ox1Mo569Ltd5UNNCzu57Piwq6AfX1K9JyPfMMnTZ8N4D/RuW+WFl2avXp3KL2OXnYbYiFV5VNgu
 I+FneZg6H4Ijno5plANob1iHhZIomD74JJDTzYEHE9bUvp493lkG7Ga4TDg==
X-Received: by 2002:a05:6102:a4e:b0:7cc:80ba:5e5c with SMTP id
 ada2fe7eead31-7d072bbdd54mr3480746137.6.1793524646022; Sun, 01 Nov 2026
 01:17:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
 <6951ce898ada42d43d1462c0543efcc47121a803.1793520104.git.sunyuechi@iscas.ac.cn>
In-Reply-To: <6951ce898ada42d43d1462c0543efcc47121a803.1793520104.git.sunyuechi@iscas.ac.cn>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 1 Nov 2026 10:17:15 +0100
X-Gm-Features: AclHuK_Zscb1CUH_AJWPsDU76Oc8wf0LU5U0kBHkG8XSnOi55p6Nv0AlhVDZPJM
Message-ID: <CAOaVG14E47=foiLnXVinm9DDer0RqxSf+0UGYM=VjTbUK2E7bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] eal: add flatten function attribute
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000006c2066065f337fa1"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000006c2066065f337fa1
Content-Type: text/plain; charset="UTF-8"

dpdk already does too much inling. need multiple performance benchmark
before accepting

On Sun, Nov 1, 2026, 09:04 Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> Add __rte_flatten, which inlines every call a function makes into it,
> where the callee's body is available.
>
> __rte_always_inline marks the callee and inlines it at every call site.
> Here the requirement is local to one caller, and the callees are shared
> with paths that do not want inlining. Flatten applies at the boundary
> that needs it.
>
> A spill slot has a fixed offset on a fixed-width vector ISA. With RVV
> its size depends on VLEN and is known only at run time, and once the
> frame holds such a slot the rest of it is addressed through vlenb.
> Inlining such calls is then worth the code growth.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> ---
>  lib/eal/include/rte_common.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index fed373f412..e32b6b13d6 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -547,6 +547,19 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  #define __rte_noinline __attribute__((noinline))
>  #endif
>
> +/**
> + * Inline every call made by a function into it, where the callee's body
> + * is available, whatever the callee's own inline annotation.
> + *
> + * Useful where a call inside a hot loop is costly in itself,
> + * for example where values are held in registers that no call preserves.
> + */
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __rte_flatten
> +#else
> +#define __rte_flatten __attribute__((flatten))
> +#endif
> +
>  /**
>   * Hint function in the hot path
>   *
> --
> 2.56.0
>
>

--0000000000006c2066065f337fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">dpdk already does too much inling. need multiple performa=
nce benchmark before accepting=C2=A0</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 1, 20=
26, 09:04 Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn">sunyuechi=
@iscas.ac.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Add __rte_flatten, which inlines every call a function makes in=
to it,<br>
where the callee&#39;s body is available.<br>
<br>
__rte_always_inline marks the callee and inlines it at every call site.<br>
Here the requirement is local to one caller, and the callees are shared<br>
with paths that do not want inlining. Flatten applies at the boundary<br>
that needs it.<br>
<br>
A spill slot has a fixed offset on a fixed-width vector ISA. With RVV<br>
its size depends on VLEN and is known only at run time, and once the<br>
frame holds such a slot the rest of it is addressed through vlenb.<br>
Inlining such calls is then worth the code growth.<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br>
---<br>
=C2=A0lib/eal/include/rte_common.h | 13 +++++++++++++<br>
=C2=A01 file changed, 13 insertions(+)<br>
<br>
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h<br=
>
index fed373f412..e32b6b13d6 100644<br>
--- a/lib/eal/include/rte_common.h<br>
+++ b/lib/eal/include/rte_common.h<br>
@@ -547,6 +547,19 @@ static void __attribute__((destructor(RTE_PRIO(prio)),=
 used)) func(void)<br>
=C2=A0#define __rte_noinline __attribute__((noinline))<br>
=C2=A0#endif<br>
<br>
+/**<br>
+ * Inline every call made by a function into it, where the callee&#39;s bo=
dy<br>
+ * is available, whatever the callee&#39;s own inline annotation.<br>
+ *<br>
+ * Useful where a call inside a hot loop is costly in itself,<br>
+ * for example where values are held in registers that no call preserves.<=
br>
+ */<br>
+#ifdef RTE_TOOLCHAIN_MSVC<br>
+#define __rte_flatten<br>
+#else<br>
+#define __rte_flatten __attribute__((flatten))<br>
+#endif<br>
+<br>
=C2=A0/**<br>
=C2=A0 * Hint function in the hot path<br>
=C2=A0 *<br>
-- <br>
2.56.0<br>
<br>
</blockquote></div>

--0000000000006c2066065f337fa1--
