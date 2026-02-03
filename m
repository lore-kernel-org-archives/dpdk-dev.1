Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F99E8305A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 06:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 085CB40281;
	Tue,  3 Feb 2026 07:42:12 +0100 (CET)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) by mails.dpdk.org (Postfix) with ESMTP id 55C9A4026D
 for <dev@dpdk.org>; Tue,  3 Feb 2026 07:42:11 +0100 (CET)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-5f5418ec110so4112176137.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 22:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770100930; cv=none;
 d=google.com; s=arc-20240605;
 b=kt2E1Ahz+UnrgtL5fDN3F4aVxXRwAj7FzFEbncca6dXPre54j5qmKFMFiYHsZlIn6j
 TKDkHkcGuag6dfPHe2TD0VzJuz83KOAxwVnrpXoDrqhd+EUYWGVxrXGAZGfQ8g2oyd5Z
 9nXCEWCpoS3bSXJMTtvvI19h2IIXJGMeH5/XW7ot3l5WVirXRrOxFLrPJzAflKBdMgGm
 SVyz9mRQ8OzhVKIRE1suj0KeNG7Gf0YLpUR9vf9WVoZxnwHhQixnqQXGPlsN4EML1fuJ
 na42qYWTKlhqPoxAtKeWFuqfU9WBtYjYhchr00a807fb6yCG9eWBrKZQQsB4+/FnDtHJ
 xK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7Fm1YPehks05pbRDMJVqfpx4KXtYKvJ33rpwlyqlGUo=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=Dv2ueqkOe6RZyXo7HfQTMRZDdK+ODksMokzFyKXPaE+eFDc0uxcJmjo98YGVz7urIu
 TScmAqioq3sMRGCMI+BoTWqzCjS4UADqQNcA991LUj+lgR5IAmT6WGPhBexRxinH/KgS
 u1JZrapram/l827NQR66Fo16uDuvlXOvSrJXfXKpwejTII3eRPh2EtCHsJ0KhmvngY1V
 k+byN2S7b/WSU37exJ3sjjum6brdvE0flk2nYT+NdQfg1M0bbkLHbkNZoHlAx55GfQI9
 T2m55b8CM94gI7ngBNuYplU/IC4j5XyPQ5XemXlt5c0qJgp1HZY6aoV4DIx+Na5m/gQC
 gM8A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770100930; x=1770705730; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Fm1YPehks05pbRDMJVqfpx4KXtYKvJ33rpwlyqlGUo=;
 b=RjtErqP93wnx6peSkOmhWCg7/A/KU366VKCud2n3WM+SGVxCpnLqZs9ZVp6HCqYX/D
 +/8cUL4Iop9BLCMEmQpUGbd703n7Zl4DvxRLteNjx4y3ooc73VFBJWAd8m+lJTAht/1r
 BRYI8nIUYR7xSMy/zrHfarGL63r1lGlQD/UpmNKApCaKIEm6cCSYcgi7DL1SK1J5dJ5g
 k/NE6/K3OG9y/QxcFGvzhVCkXOplvz5vVL9HeyrHtldBVptItkoMnKqBizhhyJYVMjXK
 i+eiWxPqxNGHhiXpf+YUX5u1GmEaRXeaGfUpZvG5ByVBUrtWR+fp9OfwT7G2E4Phkt7i
 XRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770100930; x=1770705730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fm1YPehks05pbRDMJVqfpx4KXtYKvJ33rpwlyqlGUo=;
 b=dkKwOJB8Lo5Ljhng+Xaj3acVpQwV62wsFl3bKGjE1RYF/zZUmb4CcEQfbfxYYFm1PT
 aFirKyRymf8xJGmaDVli4OxuAEn4Bq40+2Efj1URtIDej6vIDDdoM8CNN3L/1yF+lFqr
 JFD1K2aJzrfrjiLUetGiu/Q1xjr62gSvNAt7clU4geViLh51QQ7bBoOj1CeTWUyiGQDQ
 aTC02c8f+qXzK6jOtzceoGS48TV8qRD+YC44fgSUG55Fdq4MqYhwsqCKOjkA6jb4N2Hs
 EkI7H55IsN68U5duYELikR7BtnkArMNv5pNqO3mlge154y99tQC6+IdHHjm7+wimabdj
 uRwA==
X-Gm-Message-State: AOJu0Yw/8pHpbVVcxSOtrmSml01Nv5wGlK3MbTbK6DYDYFpPhVZqHq5/
 MluZWBrimBPExA69Kj9rXQhcdDqhtkxN0qd3AtEU2S+U+xPQikG1NfLGY9Dds6wPIuUber1z0SU
 IawfqviaLnyiaqDHubKsmCbmIR0G4TCMQg+/K
X-Gm-Gg: AZuq6aIaxkOTbLu6zFzplq0FGw0QocPd+iCA+H9sGnBXLz7wuwf7vodbX9B3Z8QSqRZ
 5nH9V2kGknEEZ0vTmMovUW3bhPMCYl02XOAWFBaGwvFC6OXPZYD7i4HFCoed7xQwUq23582qarY
 GACvBMbP4Wj7cKXMm65MYZlc6ye/CiVcExakYlqO/mSEBVvASgKYFqUd9y45ZLdquwXXkY+VWa6
 BQHa+uEsY51lEXGvhqwqRd0MveUjgHdi7y0EgBA8q0GDxbjfjfm1HfcqXrMx4x3TzwXW0Q=
X-Received: by 2002:a05:6102:3906:b0:5f5:4027:b6eb with SMTP id
 ada2fe7eead31-5f8e26cf307mr4404973137.45.1770100930539; Mon, 02 Feb 2026
 22:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-5-scott.k.mitch1@gmail.com>
 <20260202104755.05d834b6@phoenix.local>
In-Reply-To: <20260202104755.05d834b6@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 2 Feb 2026 22:41:59 -0800
X-Gm-Features: AZwV_QgquPcs3NHk1lxVzgElfTnqYlL5PeoJRvJ1GdWa78JIuKYvMZs-73r3v6U
Message-ID: <CAFn2buBK+RuPVBTjWtLjQr=f+YPX+d2Hd5EEbrp08_5eqLjtUw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] net/af_packet: add software checksum offload
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

> This is getting a little large to be inline.
> Maybe split into inline that checks offload flags, and non-inline
> that does the checksum if necessary.

I'll move implementation into rte_net.c for now to avoid exposing
additional surface area in .h.

>
> The code could use rte_pktmbuf_linearize() if necessary.
>
>
> There is code duplication in multiple arms of the if statement
> Can the code just "do the right thing" based on the mbufs it is given.
> If the mbuf is indirect or has ref count > 1 then copy headers, otherwise
> do in place.

Sounds good.
