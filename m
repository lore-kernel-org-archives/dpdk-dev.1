Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE93606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AaenAKPi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1ED0402D6;
	Thu, 19 Nov 2026 14:11:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 55909400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 14:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795093862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNL0260EEATlGzsQLGQJ/MT41kG8kh9+NNDNA/oFwdE=;
 b=AaenAKPiIAChRWkndXCvpl7aRx8beN0o/g9gnlSLaSmTfK33S+BzonniuVlZA8WYW948iV
 cXuGlJ9MZQjJU0h2bKSe6RqUWfTUhaRXkUT3jzuaZCAdoUPV6k7w+w/befZ0bEYYTWY2/9
 o0cG56nFSFh9uNkiaHQNTFxdfUPhUZA=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-O4elZdQCMDiCHauXAlUkDA-1; Thu, 19 Nov 2026 08:11:00 -0500
X-MC-Unique: O4elZdQCMDiCHauXAlUkDA-1
X-Mimecast-MFC-AGG-ID: O4elZdQCMDiCHauXAlUkDA_1795093860
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso2678178c88.0
 for <dev@dpdk.org>; Thu, 19 Nov 2026 05:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093859; x=1795698659;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wNL0260EEATlGzsQLGQJ/MT41kG8kh9+NNDNA/oFwdE=;
 b=SYrxk2eh6XQzyqhnadzrtxZQYK42caIv7dU4B6GnmhGtV/p1mlRvQDQ07elbowh0Nj
 h+FCaFyVuMAdEzYKc7L9fvxDceFP/kr/E5pQ3EFAhQfmnz0Q4vqpt0ByPX63S66SMq0W
 iOmOVp4WSGXu5+t8PViHBbY7YWxUXnncxSO8MrVO+19ooVc9RHbB/6/a93RLZ36qZ6xb
 XQE22KCr7idES/3nKmbf9wzR9vaEu+5fKLpXGBeLg4U8Sr3pv+hS+ew9t2Qz6DRi77Ji
 gBZXSTIIZaxmlddBzmOJVSS6t7xS7zu12Jm/zukdbdNvmelJKWINs8g3xYHSnSeI2O4j
 ryVQ==
X-Gm-Message-State: APuU4Z9FVak8jz2JhEpXgyg2uQuoURrZO3jTisJVy1pnDgWkc7Uircbe
 qq/vsFO5Sw2oi0Wwfp4ISwYYSBci08KTDS8JgV3gEl9JjRsIQ1qkm6fP3WGMw5Cho8Vi90bkAhO
 URiX9VQ8ozNXXaCVGLitK04J9yHpCOaZ4eB1yD7zmocaUl65t594sewLDifattfLm8kZ21F3L8O
 c1mI9nDGkehMTLmaDIOzM=
X-Gm-Gg: AYBFou2NLcurllMm+SM0BMJSDSSNzG1XmpN6CfISwhhcwwOmFCWJZ7MuVOqK2n2fvV/
 shK6J2DkaoLS7OQisxC7Id/orXBQ9OSbmTfvsffILzaQCQaxpebEeEGRQbLzM3dP9KgT8NRCdJW
 AVJ0xOj1Xcw1VVdC83G08c1PtyMvAWIclkddwLrWeSapM9ys+GIapj69lteeihrX+gFP1Uz6ZAo
 Uf4DruhggGC8QgZgFFfYpHUhG/K2uEFFTQuf09YTJqtvspCGygtAq/jkTLSPj7tC24Hm3Hkr05h
 5qvtJoi+3Ee8CKoVJWCID0/mBMfka3hpj5HKoFCsr3k=
X-Received: by 2002:a05:701b:2608:b0:1a2:fa1d:1de5 with SMTP id
 a92af1059eb24-1b543d29cf3mr4378942c88.20.1795093859191; 
 Thu, 19 Nov 2026 05:10:59 -0800 (PST)
X-Received: by 2002:a05:701b:2608:b0:1a2:fa1d:1de5 with SMTP id
 a92af1059eb24-1b543d29cf3mr4378919c88.20.1795093858331; Thu, 19 Nov 2026
 05:10:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103075933.1005684-1-david.marchand@redhat.com>
In-Reply-To: <20261103075933.1005684-1-david.marchand@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 19 Nov 2026 14:10:46 +0100
X-Gm-Features: AclHuK951y14BGFBfzKhaPC0PQe_iV-tCxqf7YzXn4w1YaSuvZDwBLhHVmxlXJE
Message-ID: <CAO55csxRDUPNM8ZsOujk+1uAvie5r+SO9heXAPhwQ5=UuaMstg@mail.gmail.com>
Subject: Re: [PATCH] devtools: check uAPI headers inclusions
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mlgsyD-eqHpNS_oA7tPISToIKN9uA97_e-BGAwa3oDo_1795093860
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 8:59=E2=80=AFAM David Marchand <david.marchand@redha=
t.com> wrote:
>
> Imported Linux kernel uAPI headers must be included before any other
> header to avoid a system-installed header being read instead.
>
> Add a check that runs after every operation to catch files where
> Linux uapi includes are preceded by other includes.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  devtools/linux-uapi.sh | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

