Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D40CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 15:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 003BA4060A;
	Mon, 18 May 2026 17:15:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 72E3C402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 17:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779117299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vpwwpC3G24VEtmju+1VVdDzGSKOEYTOiXBMfK6Gh64=;
 b=RXhZoHS8/7/dUXAsCzAzlYbDjNternAgfB8WQEG4UuzCTzVaarYZ8uWOebNTVVVogL2tX9
 d4sdy9CpOtBkRocd6TH0vW6WxCJqUecyLo6epbsDaJ+X6xH8T8p8W4ZQ/JkNvl2ueuHTGF
 7XK44e1VSEd43Lihc48BFiHbH7uCKAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-dDZnUD31P8-AW6CZAXyUuQ-1; Mon, 18 May 2026 11:14:57 -0400
X-MC-Unique: dDZnUD31P8-AW6CZAXyUuQ-1
X-Mimecast-MFC-AGG-ID: dDZnUD31P8-AW6CZAXyUuQ_1779117296
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd8162ed7so19430165e9.2
 for <dev@dpdk.org>; Mon, 18 May 2026 08:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117296; x=1779722096;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QuprnrBRcJyXEeOL4IL0z24BdIlJ3YoPuom50cKKx0c=;
 b=kHYNg+zww0pSIrGP3oyE3bgmvrk1iZPeVui4oV9r6j8FVcPLWDuhbWlszidiUYqJe3
 b+mAwZDJmtk0nKnvHcsms6ZxFmbJ5Y8CD/Ivh6pt4039/sdve5XceOPLL6cmabl+1puP
 rwJHipmQhYyzmF5zHegJoVlS785jrJD3XyE3tA41yZjfOXuqpq+73PWB4kG4+k4YPglb
 +uo5V3x9eVXlOtmH/0ZYSEazfucYIX4Fd3S1fwzHmYC2APYZEIe0cFPw3bpcmHq/5eAi
 UM4WBBTyur8gp1Jz06amvSqBGAcwcMohu4r3cl1sFxzLFh1aPYmoMTwKlJceTavlJovk
 rUiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B1nWs58LGf8kVh3DFLySN6OyUimLreZmBeYqGVLKrwOwnxDy+ETde1R64a11Uo/DvK74=@dpdk.org
X-Gm-Message-State: AOJu0YzvEc+0xKzLh1vOLUxW5puY/TPTAyXPxVBJCsQ0QCP+wfLni337
 r82PO31DVAaa3Jxb7Qsq5xL/Tj1gYfcrGc4STUp6Xuo5IVswxJgbUVqSDcM1gyEANc8b6KqBOEh
 crwqrSoibhWxU7ddfN0MAre2k84UpXPa+znv1oCpwJi9w
X-Gm-Gg: Acq92OENRXF2MOS3bxsCZY5T/0ASj90HdIlG9fMfiAgOtA2li2/WchTZHYKoP5AOEip
 wSibgvc/Oag2r+EiWso/HIQQ7rPNGOHLU6Pc2Pl2+NFTcRBnt3o0WV9hEoD4zONNNctppwFPcV6
 oaZWJu+sEhmzSl+1J7saGy/RXGzYDgT+4uDKn99HUTP95NxC48BGiqvR1KhxDu3j1s9LQYfdFGh
 OmimhYN9CN2ytNXwCLGf/4hln+wdvqTFun91kfPNXlnQJtplRIkkBkx2W62q34n2mT9WLmZT2dX
 MjvA9yQfMsSg3JCAnYYge62cstcl3tb/aGz8ccoEF47PNfJUb/pFoxzn8IBXUGRNPd4yIyWZg9A
 dVV91uq8TsaORKhpLtWqAgI2jvFV5xKU8fgt9lGUOX/SbBgSSS57d8WVK915IvhQpB2HtFrffPB
 d0Sgo=
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fe632661bmr245768855e9.19.1779117296193; 
 Mon, 18 May 2026 08:14:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fe632661bmr245768285e9.19.1779117295640; 
 Mon, 18 May 2026 08:14:55 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm37951147f8f.37.2026.05.18.08.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:14:55 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 18 May 2026 17:14:54 +0200
Message-Id: <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
In-Reply-To: <20260518150819.3332628-1-thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJKOzeWMBpoN4bEMK5y5aMsOMLETGr1bwR6xtFs7DsM_1779117296
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hey Thomas,

Thomas Monjalon, May 18, 2026 at 17:07:
> When compiling with C++20 standard requirement (default in GCC 16),
> the increment and decrement of volatile variables are rejected:
>
> rte_spinlock.h:241:14: error:
> =09'++' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:252:21: error:
> =09'--' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:278:14: error:
> =09'++' expression of 'volatile'-qualified type is deprecated
>
> The count field of rte_spinlock_recursive_t
> does not need the volatile qualifier
> because it is only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
>
> The user field can be accessed outside of the lock,
> so it must handled as a C11 atomic variable.
>
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
> v1: drop volatile keyword
> v2: make user an atomic variable
> ---
>  lib/eal/include/generic/rte_spinlock.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/gen=
eric/rte_spinlock.h
> index c907d4e45c..5d810b682a 100644
> --- a/lib/eal/include/generic/rte_spinlock.h
> +++ b/lib/eal/include/generic/rte_spinlock.h
> @@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
>   */
>  typedef struct {
>  =09rte_spinlock_t sl; /**< the actual spinlock */
> -=09volatile int user; /**< core id using lock, -1 for unused */
> -=09volatile int count; /**< count of time this lock has been called */
> +=09RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
> +=09int count; /**< count of time this lock has been called */
>  } rte_spinlock_recursive_t;
> =20
>  /**
> @@ -215,7 +215,7 @@ typedef struct {
>  static inline void rte_spinlock_recursive_init(rte_spinlock_recursive_t =
*slr)
>  {
>  =09rte_spinlock_init(&slr->sl);
> -=09slr->user =3D -1;
> +=09rte_atomic_store_explicit(&slr->user, -1, rte_memory_order_relaxed);
>  =09slr->count =3D 0;
>  }
> =20
> @@ -230,9 +230,9 @@ static inline void rte_spinlock_recursive_lock(rte_sp=
inlock_recursive_t *slr)
>  {
>  =09int id =3D rte_gettid();
> =20
> -=09if (slr->user !=3D id) {
> +=09if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) !=
=3D id) {

This needs to be rte_memory_order_acquire

>  =09=09rte_spinlock_lock(&slr->sl);
> -=09=09slr->user =3D id;
> +=09=09rte_atomic_store_explicit(&slr->user, id, rte_memory_order_relaxed=
);

And rte_memory_order_release

>  =09}
>  =09slr->count++;
>  }
> @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte=
_spinlock_recursive_t *slr)
>  =09__rte_no_thread_safety_analysis
>  {
>  =09if (--(slr->count) =3D=3D 0) {

This code is completely broken. Any thread can unlock without any check.

I think it should be:

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/gener=
ic/rte_spinlock.h
index c907d4e45c39..b1058e4f8b4f 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -245,11 +247,17 @@ static inline void rte_spinlock_recursive_lock(rte_sp=
inlock_recursive_t *slr)
 static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t =
*slr)
        __rte_no_thread_safety_analysis
 {
-       if (--(slr->count) =3D=3D 0) {
-               slr->user =3D -1;
-               rte_spinlock_unlock(&slr->sl);
-       }
+       int id =3D rte_gettid();

+       if (rte_atomic_load_explicit(&slr->user, rte_memory_order_acquire) =
=3D=3D id) {
+               RTE_ASSERT(slr->count > 0);
+               if (--(slr->count) =3D=3D 0) {
+                       rte_atomic_store_explicit(&slr->user, -1, rte_memor=
y_order_release);
+                       rte_spinlock_unlock(&slr->sl);
+               }
+       } else {
+               RTE_ASSERT(id !=3D -1 && "unlocked from another thread");
+       }
 }

(not tested)

> -=09=09slr->user =3D -1;
> +=09=09rte_atomic_store_explicit(&slr->user, -1, rte_memory_order_relaxed=
);
>  =09=09rte_spinlock_unlock(&slr->sl);
>  =09}
> -
>  }
> =20
>  /**
> @@ -266,10 +265,10 @@ static inline int rte_spinlock_recursive_trylock(rt=
e_spinlock_recursive_t *slr)
>  {
>  =09int id =3D rte_gettid();
> =20
> -=09if (slr->user !=3D id) {
> +=09if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) !=
=3D id) {

rte_memory_order_acquire

>  =09=09if (rte_spinlock_trylock(&slr->sl) =3D=3D 0)
>  =09=09=09return 0;
> -=09=09slr->user =3D id;
> +=09=09rte_atomic_store_explicit(&slr->user, id, rte_memory_order_relaxed=
);

rte_memory_order_release

>  =09}
>  =09slr->count++;
>  =09return 1;


--=20
Robin

> Monitored by the American Human Association.

