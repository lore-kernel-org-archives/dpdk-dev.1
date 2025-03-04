Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E1C282D6
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:59:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3C62402E2;
	Tue,  4 Mar 2025 17:59:52 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 922324029A
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:59:51 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fe8c35b6cbso9389552a91.3
 for <dev@dpdk.org>; Tue, 04 Mar 2025 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741107590; x=1741712390; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PK1kl4+W892kZtemfgUwSsT5e6kAvrahN1KczGDBUuE=;
 b=hVmRWQXS5RmDfyGvM+0foSPkdhQICybmBkHI5v0upwilan57pGdX2eDBSSINHELcAw
 nUP1ozlFvVmF+82SYnAniFl/klPL8CZKAQ+Ga/Ts84Vguizpn0jreMUsNAzI5MPoU1zN
 FbqS+D0k1eaYab6/nRK9wfjQuGjR+syuPeVuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107590; x=1741712390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PK1kl4+W892kZtemfgUwSsT5e6kAvrahN1KczGDBUuE=;
 b=ctQokkzqdlllccPhowPK9nDdWzdG8/mdrQs33TCLJszC41wSR7Sw1/VsMb0Ay8X52U
 dWAK4Yt0RH02e2mdI6ReUA0eoAnRjfJyVYrzcI6xcUPZ8do0aw95JhTrWJ0hvr5os+FD
 KwExaGdNTED00uIHcQcl2X6qVpfooOT1c6XBXTUsMSYwC8v8OJASEMYzLnNKrpZWt7GS
 chYGxr3cxgj+G/IRBU4u0+R9yCfIucmpcGA43yjuEJ59u7r2d4pW1uX/cbfpw6YQboxm
 9kXovAQkMVETx8xJ+SZZFmlkQuj1w6J6YCtSije+hGooBMxIelo0VjmnPF7/XPEZ1o6V
 sSiA==
X-Gm-Message-State: AOJu0YyK+spm9GUKt9HSzuhe2zYu5Ly3c/FgptaLYfh6XCG/SrhduSEy
 2nXQiYk7MklDaX+cUs2p1s/0RZ0fkPDzj7AcZ20idpTi/jU8FqsQTrZy3H86C2HPxjeotXcl41V
 alRyXqnd/T3zx4C12syjOn51Q/HzvC2vFZGbzdeRwu2d73fSHHhsQLA==
X-Gm-Gg: ASbGncuSpXbhXrGc6//PvluCQea8dofS6xWFYq63m0ORRmY85YTKwIrQ2uRapAY9dRo
 95gzdk9rQYhPjl3c3a755IiNT+a4QNEcHKyOwxFoWQxoOtenMod31MFdi9YbDeXIXDJMpVh9b8P
 5LEL7E9Yc+KedysKd6Jt8n/DAm5A6uNO7r66JQqy9K
X-Google-Smtp-Source: AGHT+IExHfB5gbir4KjtAZuXj4uJiiQRdhXvVlD2ZO/wC2xYKAfH8MOH+IC+2qT6RaPCbmulypku+kzH/ua54Mcq+7A=
X-Received: by 2002:a17:90b:5688:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2ff4979cee1mr2178a91.27.1741107590603; Tue, 04 Mar 2025
 08:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
 <CAJvnSUCTKvqKFXGKtsgb8Fu1sk5s4UYzKMGw3YF-u1fq3fGOQw@mail.gmail.com>
 <CAF1zDgbyybza6r=O5Dh3JiosLDHHsO2m8qfKwd52mT7vVMXXeQ@mail.gmail.com>
In-Reply-To: <CAF1zDgbyybza6r=O5Dh3JiosLDHHsO2m8qfKwd52mT7vVMXXeQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Mar 2025 11:56:17 -0500
X-Gm-Features: AQ5f1JrgSq8jNiAiUJ9b1nUJj703RhzKZk1mMLuJpSgPBqgzlI_stbbIBvn0u-I
Message-ID: <CAJvnSUCSThTNBSS=5ztrBvTe0_vPfREN1MPP9a_T4STK3U4COA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000074442c062f873349"
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

--00000000000074442c062f873349
Content-Type: text/plain; charset="UTF-8"

Thanks Ariel,

If you submitted another version that supersedes it, I think you need to
mark this superseded:
https://patchwork.dpdk.org/project/dpdk/patch/20250223214123.447579-2-ariel.otilibili@6wind.com/

Best,
Patrick

--00000000000074442c062f873349
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thanks Ariel,</div><div><br></div><d=
iv>If you submitted another version that supersedes it, I think you need to=
 mark this superseded: <a href=3D"https://patchwork.dpdk.org/project/dpdk/p=
atch/20250223214123.447579-2-ariel.otilibili@6wind.com/">https://patchwork.=
dpdk.org/project/dpdk/patch/20250223214123.447579-2-ariel.otilibili@6wind.c=
om/</a></div></div><div><br></div><div>Best,</div><div>Patrick</div></div>

--00000000000074442c062f873349--
