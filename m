Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E1C982CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 726FF4028B;
	Wed, 16 Sep 2026 18:07:33 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3624240264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:07:32 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d43f9b119so11761977b3.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789574851; cv=none;
 d=google.com; s=arc-20260327;
 b=jfn0trlwASdKkmh2tTt7aZTAvI9ruoG6Sxpnt7PyZKy+rwjuT5COb1itbXlqfgdnhP
 1zEef9EByTNZPPi21xCi+g2uEvBTXSC6XN5ociiwws40ldYkAzrv0Rxo0xvNvw7pYBwL
 40mibuMjv43p/XFxmGlktuiOvmWUEOqucSDWe2ZxMxR9rPYFrYtibtfHYGPgQlcBS5Vo
 2c2tSM/gP+Ntt8ixdWBuXvQeZvJX3MW3W27jH7xpdqoZCqboE77ZDbbEFs4uPObi043c
 rKsuFW/xtDPdJtH2fDpxLD9+n2M68e7eSVGMu+vamNi+9hsxtosfHYxgfpAEJN/UOGJ0
 ucWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9BRbwPgOWsZsqwf2x47G3/aPANVUKcI0leWRAazOyPM=;
 fh=Vn19kmve2d/3jVi9Bwdu4WOwbYYrJANCEr9xdvDyuP0=;
 b=ddagwDpEIJZWbLb9aiFDL55qBZMVXQWMzoPjLPgqlQdOPYUOlSaKMy7D+dPLcVl2wJ
 uF4mYujLr9QxgSnDUA7bRXNDuLHdenQAQl2cwyz95G0h+BVijsTNLVq+RdZ9OB1SEgaz
 bkQSTJXselWLYFrj42YDwuvCiKSlelGVA/LOjUDe+e1dBd+1MjEyXOWzM6ADvKFp1eNV
 aYzlvYvMLu8mgur9RKi8094uEljIBcl1WQXZw717DdngoOSHoEcZTdTOiQjFqzfUbvkh
 cVpTFzT2odFjhQaXJEK0aAlBq1R7sAClvzTLpemESQAql00RJGuj33FTFqTs6pDfphLJ
 Difw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789574851; x=1790179651; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9BRbwPgOWsZsqwf2x47G3/aPANVUKcI0leWRAazOyPM=;
 b=IzL7iexDtR/aTTqsJBYjyAhbWMf8yOzWp/5hXjO9uW5gevgHcO+fyzhPXN/5le3Pwb
 g5Vk4r9oJj/7kjuKqWhZRXur+Wl2t0kJ9huQ4RpC0NdEmB23pfqDzwNr5X5g/l20xBUo
 RQeWmQjn34nXhQ7GhfzwZPZvJlB6FvuFzz1sT2Jy3hmpX7vqlaqjJlU4id1HUU//Nr+x
 g32PeCuS7QnpNdeOobfVAAsz0fF/8pEbsofxVzU63SFGN+0gT8rQX8+e0LLNs/slR5qd
 2LlutrzL9g5tm7e4ZG7UHHT0AzgLLqjih3gyX5qyofbm+UiF4bMHzTtZpCGqM6XuW5C+
 0JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789574851; x=1790179651;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9BRbwPgOWsZsqwf2x47G3/aPANVUKcI0leWRAazOyPM=;
 b=DovBCGYivuIPnY0wKxVUoPeQC98jXeA/MFq68cxzPW1gdxlPxRa2nqnpCCKw1G0vUQ
 jgZfg5ZZJFzl+SCFkMC/qYBZ/itxjJv4qQzXLmqLGat7DrVjZPQXnxE28mwhlqzfnKzG
 H9W5jnEk1pxx6bOrjUcfXu12AnPF48prFD71Rx05ENMWxP3HCcY9DyJChrJ1AiJJKk7i
 GzzABFTapdf7cn3HIKdI0Jak4DeemjVl9Xh7b1BgtFjOHRiFLjZUIekDNmPRyujMLVLM
 B9R2dDKWEv/aOrmkTp997d9GUk0TA8wuB3M9NVynwehg4Rxvg9U9rINavsalEKEQcUCd
 Jk8Q==
X-Gm-Message-State: AFuF++nDo9FBG7dBubfveIEwSKMK1O2ZeWHV89KvN4T0dCXsCKRQNcQ/
 cXYstQ7OPeS31566qYjqYnlWJFac/q4WLeaZRz3OvGWg5Y/n6MM0vIuNMV30pELaFBO7G/7j5NH
 89L3DG9SpX6U7J31S5YGBVkNgVI3fjcE=
X-Gm-Gg: AYBFou2v4HbI9wYovaTziz3bpJrSejbFzJkancNsr4HYgkjp1SSre5pwty26MVYMhdR
 8cd5yAv3fDogLNHh3NhmMBOzIMerPtLRbZt0h5Q7+omNBejxoR6HiPtgexTEXla+BSHKtr7wKsx
 GOCv1PInJLPKo6YekyOV+bGDZIeqwrqU4CAe/cKsBZayvq7GkYGbkLPVxipLjVWrqOgQx6KPhyv
 ZsfKofdJJPtZYR2Uh5PBb+VlVWc+YFHi6t3+OckIo7No43AAcXUs7FrudBXVC7qjkgvKoflYkJY
 preIvKUMKCl6XBZKM04wdx/59m+ICM3foZwa/zaMg88yYpG2Kv22VHzt
X-Received: by 2002:a05:690c:38b:b0:85e:688f:3c52 with SMTP id
 00721157ae682-892247aa51emr12027617b3.33.1789574851280; Wed, 16 Sep 2026
 09:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
 <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
 <CAL+mCpPOPtvn+Si6PvnvpK5e3rQHp81SV-+WDaiiJADt99V--A@mail.gmail.com>
 <CO1PR18MB47963490DE511C867AC2BB80BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB47963490DE511C867AC2BB80BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Wed, 16 Sep 2026 21:37:19 +0530
X-Gm-Features: AcwNN1WTkMlTW3LIDYGsPV7HKTrrEY6l93qnEx_G1QUlUXeGjT4_DyGPmx_U460
Message-ID: <CAL+mCpPTgpJd+TUTxJDmt9r70ELAQEPvywC=+afuw69hEPavfw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
To: Ashwin Sekhar <asekhar@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
Content-Type: multipart/alternative; boundary="0000000000004f416f065b9bdd54"
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

--0000000000004f416f065b9bdd54
Content-Type: text/plain; charset="UTF-8"

Thanks Ashwin for the explanation.
*On AQ Init, the context is first allocated in the cache.* -> Does the
hardware take care of it? Before writing to memory, it writes to NDC first?

Thanks
Amiya


On Wed, 16 Sept 2026 at 21:08, Ashwin Sekhar <asekhar@marvell.com> wrote:

> Hi Amiya,
>
> NDC is a cache that NPA uses to cache frequently accessed contexts and
> stack pages. All accesses to contexts/stack pages go via this cache only.
> There is NO direct access to backing memory in NPA operations.
>
> On AQ Init, the context is first allocated in the cache. Whenever NPA must
> access this context (for subsequent alloc/frees or AQ reads/writes), it
> will read/write directly from the cache. The context/stack pages never gets
> evicted out of the cache (unless there are more contexts/stack pages active
> at the same time than the NDC can hold).
>
> Doing an NDC sync will write back the dirty entries in the cache to the
> backing memory. This does not affect the normal operation of NPA in anyway.
> Even after you do a sync, the entries remain in the cache and further NPA
> operations still read/write from the cache. The backing memory is NEVER
> accessed directly.
>
> Why we need it at teardown is to avoid corruption. We free stack pages
> when we destroy the pool. If there are stale entries for these stack pages
> remaining in the cache, then at a later point of time, these entries can
> become candidates for eviction and can cause writes to memory which was
> already freed causing corruption/translation faults etc.
>
> >> how it's a side effect of IOVA as PA
> IOVA as PA is NOT a supported mode. We have not studied what kind of
> errors will pop up in this mode. Explaining the side effects in this mode
> will require deeper study which we don't think is necessary for an
> unsupported mode.
>
> Thanks
> Ashwin
>
>

--0000000000004f416f065b9bdd54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:trebuchet ms,sans-serif;col=
or:rgb(103,78,167)" class=3D"gmail_default">Thanks Ashwin for the explanati=
on.=C2=A0</div><div style=3D"font-family:trebuchet ms,sans-serif;color:rgb(=
103,78,167)" class=3D"gmail_default"><i>On AQ Init, the context is first al=
located in the cache.</i> -&gt; Does the hardware take care of it? Before w=
riting to memory, it writes to NDC first?</div><div style=3D"font-family:tr=
ebuchet ms,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><br></=
div></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature"><div dir=3D"ltr"><div><span style=3D"font-family:verdana,=
sans-serif">Thanks</span></div><div><span style=3D"font-family:verdana,sans=
-serif">Amiya</span><br></div></div></div></div><br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, 16 Sept 2026 at 21:08, Ashwin Sekhar &lt;<a href=3D"mailto:asekhar@m=
arvell.com">asekhar@marvell.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Amiya,<br>
<br>
NDC is a cache that NPA uses to cache frequently accessed contexts and stac=
k pages. All accesses to contexts/stack pages go via this cache only. There=
 is NO direct access to backing memory in NPA operations.<br>
<br>
On AQ Init, the context is first allocated in the cache. Whenever NPA must =
access this context (for subsequent alloc/frees or AQ reads/writes), it wil=
l read/write directly from the cache. The context/stack pages never gets ev=
icted out of the cache (unless there are more contexts/stack pages active a=
t the same time than the NDC can hold).<br>
<br>
Doing an NDC sync will write back the dirty entries in the cache to the bac=
king memory. This does not affect the normal operation of NPA in anyway. Ev=
en after you do a sync, the entries remain in the cache and further NPA ope=
rations still read/write from the cache. The backing memory is NEVER access=
ed directly.<br>
<br>
Why we need it at teardown is to avoid corruption. We free stack pages when=
 we destroy the pool. If there are stale entries for these stack pages rema=
ining in the cache, then at a later point of time, these entries can become=
 candidates for eviction and can cause writes to memory which was already f=
reed causing corruption/translation faults etc.<br>
<br>
&gt;&gt; how it&#39;s a side effect of IOVA as PA<br>
IOVA as PA is NOT a supported mode. We have not studied what kind of errors=
 will pop up in this mode. Explaining the side effects in this mode will re=
quire deeper study which we don&#39;t think is necessary for an unsupported=
 mode. <br>
<br>
Thanks<br>
Ashwin=C2=A0 <br>
<br>
</blockquote></div>

--0000000000004f416f065b9bdd54--
