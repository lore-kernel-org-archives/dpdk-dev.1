Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B7FC982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:23:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C62D4028B;
	Wed, 16 Sep 2026 18:23:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C742640264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789575807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RvVg5vMTcjTDhPSXnXikjDIPDRCcHZLevtIltkS8k5s=;
 b=aLPI9XHMuwk80mg+sJyREa4jWXWnVslH6Uh5RMY7NrT8mQ/gCcvNG3Hp8dRhMmHxvTHKIw
 r71Z5n7jkEEvm7/oBiCpvHaZgLT77qtzuEFSgTHVJb1qXHbO+pQDz+IZqthSLP2+iAHfe1
 txBR6ecXzK/SC/pVnpPVY7DOURojo98=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-NAo6C7iGOwCytng06ZgSCg-1; Wed, 16 Sep 2026 12:23:25 -0400
X-MC-Unique: NAo6C7iGOwCytng06ZgSCg-1
X-Mimecast-MFC-AGG-ID: NAo6C7iGOwCytng06ZgSCg_1789575804
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a56fc7ca3aso24683831fa.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575804; x=1790180604;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RvVg5vMTcjTDhPSXnXikjDIPDRCcHZLevtIltkS8k5s=;
 b=FuykeyK+Jd8uwNc5Pt2+W5w6remRcTcbbxyIhb63VaVl4LPRDJ9mo/hKzDX1/7CrLx
 aPGQ48fAWTW2x33fXjsA1wqmC0PI9vTU76eKDKaokqisD8wVbJaavYWLVGtCzLS/xcVk
 lv8xQSHPYuhWHxNz+dG0XpDE46k6/92aG/6kTn4E3gZ4W3CLYOWB3hfnu22QGeZw1PKH
 uzU2yVWQK476ZihdO2l3gt28SU7j118qBvBhKCKrqYdvAJ5OWmyIJOAqx6GehPuYTkVZ
 Oqo+Ni1+2NGoddy5a6EqYnhf5p1gtY6W2QQlrJZT8awutuD7lZemCli0MoboxmjQr3D+
 RZng==
X-Gm-Message-State: AFuF++msPpC91q1m70T/j+YoTiaiw1PhTk4rE8CFGG+jPgJNyeM5qxup
 xnhXdtc2OYTlfP59ejoHulAjt0wvNi2CnTRzxsk5rg1FfDhQ/UAUdT0vIkJTLmlf/XS2Ofyc/FI
 iU/csYNLquwUPetpZfzWXHwqhgbmddjlcGW4nC0Pqj1j8+9tRvPSY7p92UChNSZFQ5NJujpZ6sz
 4bUBoDeXPNEdHzZkYj8i4=
X-Gm-Gg: AYBFou2sxAyXyTZKVeuFKJefRkW3pI2bx5udLePXu4PqYeoVfIToEriMSoXMIJ7dFhc
 wtQWZ8WJ3cwuPzsz2T+cj1lN+eyflAK/Oka/PejvzJGrqnexV/DrqSuaUAjIOI2qdCZxxUkEEAv
 V2Md395c/JtIAuM7s2yWFvF9gZvDhiH8L5RkH77ZCfaUclOcoRt0NuwbFv744f7AUeSKdj6pn/h
 K/wFTlfBsB6+KMfPpqGXgm+wSzbMAYh7VGFegZOS9y6G9rV
X-Received: by 2002:a05:651c:a16f:b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a5dc9f2721mr6232191fa.18.1789575803897; 
 Wed, 16 Sep 2026 09:23:23 -0700 (PDT)
X-Received: by 2002:a05:651c:a16f:b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a5dc9f2721mr6232101fa.18.1789575803424; Wed, 16 Sep 2026
 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260902232700.550000-1-stephen@networkplumber.org>
In-Reply-To: <20260902232700.550000-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 18:23:11 +0200
X-Gm-Features: AcwNN1Vp6G-69PmuljHUfiCK4wib-67Q-CMT65syLD7XnmalNtck1ig_0xzXwC4
Message-ID: <CAJFAV8zb8yChKsT7uJh-EA28PhG7PyXi=XA3C=-SV-z7zD-WxA@mail.gmail.com>
Subject: Re: [PATCH] reorder: promote experimental API to stable
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Volodymyr Fialko <vfialko@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5_G5OKRDb7Z8Y12dsNFRu6JGaaVn1M3wamNLT5rMq2g_1789575804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 3 Sept 2026 at 01:27, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> All the experimental symbols in the reorder library were added in
> DPDK 23.07 or earlier and have not changed since, so remove the
> experimental tag.
>
> The sequence number accessor rte_reorder_seqn() and the underlying
> rte_reorder_seqn_dynfield_offset date back to 20.11,
> rte_reorder_drain_up_to_seqn() and rte_reorder_min_seqn_set() to 23.03,
> and rte_reorder_memory_footprint_get() to 23.07.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

No objection from the maintainer, and no activity on the API front for
this library since 23.07.

Applied, thanks.

-- 
David Marchand

