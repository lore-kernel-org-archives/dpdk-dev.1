Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C6606C542
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/F9EX+p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 564EC40E34;
	Mon,  2 Nov 2026 15:43:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 974A140E1F
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyulNU/aSGqHO8xgjQpmIlgzNlCKV7+ZdhyZrcglYog=;
 b=L/F9EX+pDrYgbIEUE0FPENJI2bbwyk7Oq7c1JX4vidjPPGDCD6dBw9J5DybJwdDhtwEpkZ
 BeyvOg4305XsMC8ZfEGGvVWLlvGN7/OE3sDtlHUQhZvI9yrgz5lgKcnUY+vketKr93S2gE
 IkBDWiiBNoqcrsCjGmo2zns7jtqy5hs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-QqOsuLJdMfGX-TQMHu92wQ-1; Mon, 02 Nov 2026 09:43:13 -0500
X-MC-Unique: QqOsuLJdMfGX-TQMHu92wQ-1
X-Mimecast-MFC-AGG-ID: QqOsuLJdMfGX-TQMHu92wQ_1793630592
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a987e52306so13312761fa.2
 for <dev@dpdk.org>; Mon, 02 Nov 2026 06:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630592; x=1794235392;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iyulNU/aSGqHO8xgjQpmIlgzNlCKV7+ZdhyZrcglYog=;
 b=ly1RUwL5c6lNvzJU8zXEwUVdDOsE7pxOcvINXYn987TEmjS7h4F+RdhCSP++Qj9Z5J
 33Ia6EcNnTENu7s6B/WVbtfISzNAurbZ6hhr2/4akkPncXn/Gb99e1JbspKjhvazd+5N
 NmtLRlrcom56QZNu2lZshrlu90hRIvsOqBgy2FLjAgkOy/v+WzLX3Nc8Vk6IX5ZUGeq4
 PSMIYi20QRIlHRoSxQtrm0cBnFv0uIaCKa4WSCzEOi7kSwioiitNXOHMIKjr6vIlvur3
 RMCZPh318m6G3rDy+BDUHfStmkhLUEm4uANTNQ2OY8Vk+W46INXgfHIrQP9MpjSd8NDX
 CMZw==
X-Gm-Message-State: APuU4Z/MFLoXrXv/mw0ZR9+RhWS30biGkCXIJKVJX0N8auz+dgqPi1Pi
 PimsKeQ5ThMwXpbO2n2L66YcGlORMF/Cfpa2xH3bRAyGJ9+Lwvz0uvNhYmioSzlYXgfbsiUc8pK
 1Dix8pcYpaHFSOP2fA008OzFXBzPE+C1QAvk5vprig5UgpG4k1H9JSXD+aR5M7mGKu3Jzhx3rdn
 ZGFeAmKrV1Hm4F5luaefg=
X-Gm-Gg: AYBFou0aVHumAiiQLoOhBskQYqoyuhfuVsc18C45V3vVYmtmNOi1e9Glq1LnzKixDuI
 py6ALdQ7eHebWVZJ/tW5Ym6bvbHyt1afoEgT3+OZlveY2xjP6/s6ff2HDY3S8lYtPecs0n6UxYZ
 iKXtS1sLsJ5yh9S1lik3D7daZDfSoIA0C4ekYNa83zBTG4r2zolzqgozfHVNGTrLyZRv4sUYZzy
 Tp04ddCj4XEMp24g++OFKcy8mg0bWv5N4aqnGmENPezGyJC
X-Received: by 2002:a05:651c:3605:b0:3ab:1fc4:8eb6 with SMTP id
 38308e7fff4ca-3acb7a2bd0cmr25096801fa.5.1793630591699; 
 Mon, 02 Nov 2026 06:43:11 -0800 (PST)
X-Received: by 2002:a05:651c:3605:b0:3ab:1fc4:8eb6 with SMTP id
 38308e7fff4ca-3acb7a2bd0cmr25096681fa.5.1793630591168; Mon, 02 Nov 2026
 06:43:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020145541.388371-1-stephen@networkplumber.org>
In-Reply-To: <20261020145541.388371-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Nov 2026 15:42:58 +0100
X-Gm-Features: AclHuK_98Hj8lCnKDWrTUOm9GehrrUkSY54iNK8dVuPHsHq_qfOD8k7nWwo1qlo
Message-ID: <CAJFAV8yeTXeY_9vdiFoXk7N3APrZTivUmtF-7KLf1fchi8VO=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] build: disable GCC string op warnings when unoptimized
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6-tQXAsIQb2Nv41_zHgGKuLYw0MVNBVc640GW_IJ304_1793630592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 16:56, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Without optimization GCC produces warnings for unreachable code paths.
> They check memcpy() against the object size even on paths that are dead
> for the inlined arguments. This breaks debug builds of app/test
> with -Werror on lib/stack/rte_stack_pile.h,
> and has required local pragma workarounds elsewhere.
>
> Disable both warnings when optimization is 0. They stay enabled for
> optimized builds, where the analysis is flow-sensitive.
>
> Bugzilla ID: 2061
>
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Series applied, thanks.


--=20
David Marchand

