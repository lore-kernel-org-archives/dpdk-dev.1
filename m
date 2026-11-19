Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1B606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHrIJ549
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D09C7402D6;
	Thu, 19 Nov 2026 14:27:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 8CD93400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 14:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795094861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bX3iJ15dnvC176nE49U+wp6OtxF2Ue9fO9cv+jerzk8=;
 b=aHrIJ549ISvnnTU5jDmlSM1ukK/Q/19nimIZYtzSPELy1O89qhQSXa3YaIP20ytpj2GYh7
 gbIMeg19tiC2wS9WWHqJaAyIryeLe8h5cA8Hcd3L2koNi3rlqVQ1hybT+BzUuQMtSu9IpH
 l7EooQp9VYqOAesJsfzWiwP3gLpMpsU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-goecy8DHPmS4BMOlg5ebgg-1; Thu, 19 Nov 2026 08:27:40 -0500
X-MC-Unique: goecy8DHPmS4BMOlg5ebgg-1
X-Mimecast-MFC-AGG-ID: goecy8DHPmS4BMOlg5ebgg_1795094859
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ae0c42947aso9312101fa.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 05:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795094858; x=1795699658;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bX3iJ15dnvC176nE49U+wp6OtxF2Ue9fO9cv+jerzk8=;
 b=AP7c0AIWT/S3QEagGxTnlCjEdw7301SwaupwNPaM3iIc3cFRsVR93F1ITDzRlwviqH
 KzXVd16P4ykkJIz8A8uPb/hDWyTKVzHxuYW4AL2HeC5e/H01CB8mxoP4dWxf1Hof0qRX
 Oodc/nzUkvbcERqcpTGZojDLd/owZa8aBAVM3yQk/c4W1gKHTLZGnd0OA5AvdyB0xWHo
 S2KssdymKOpjuiGXSBY953cg8WBxhJOn8VyG5mVEAk5kVjJG8Fyff/UZAxMEgHDnPGYU
 iQX620b3n8/1kGtv7fZZNrkCgTAXvi5q2db6BbPUGsXIReO7lhcvgnjJlZrmnyrE2u1a
 snnA==
X-Gm-Message-State: APuU4Z9qSNOoVMGDLfDcoS78vIZ+SluSfpv6LpjFW5akhAHm59WKoZsE
 7DNPL/qD2Cfi8E//iJuI0RLmI7s8jxWK0+Bu13lzT860BcU7tdTzz04WBqSqIrChb97R6WOl0Af
 lAeudefJlALAyFe2oJjF3v1714OtDFn4DCTrgLTVJ3A9R0ObQekols2QSe9xI0BHSDYJ+NzDzEX
 pk5Zi6gIndEOjtntfjkc8=
X-Gm-Gg: AYBFou1MChs+zSF0LuQvB6Kb3E5rlwQnx0BE9p1JgNkCrn0ZLeVA7SkD2RGeYPKgVLl
 zlE8vhmDUgN0QhM0HNobiIhXPKAScnSDvyhqNzKyBVY2TaYJW4qyJ+4D5nsd7ecmv10ioDs8i2s
 ZbJHi5bxlBIwhT23lt68rQu1SHxwius67MQ4lcLwIrZ7d0a0zI6AvEHqtHbA2jNeMrSQGtJXLix
 nP3H9L9l/rFoWI0Bo0TNG49+ilXw5//fkvZw0zjyVrA33Yh
X-Received: by 2002:a05:651c:50d:b0:3ae:68:d077 with SMTP id
 38308e7fff4ca-3ae670d46f0mr18976291fa.18.1795094858566; 
 Thu, 19 Nov 2026 05:27:38 -0800 (PST)
X-Received: by 2002:a05:651c:50d:b0:3ae:68:d077 with SMTP id
 38308e7fff4ca-3ae670d46f0mr18976141fa.18.1795094858065; Thu, 19 Nov 2026
 05:27:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103075933.1005684-1-david.marchand@redhat.com>
 <CAO55csxRDUPNM8ZsOujk+1uAvie5r+SO9heXAPhwQ5=UuaMstg@mail.gmail.com>
In-Reply-To: <CAO55csxRDUPNM8ZsOujk+1uAvie5r+SO9heXAPhwQ5=UuaMstg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Nov 2026 14:27:25 +0100
X-Gm-Features: Aa3M54odFhR6VaI768J5Z8IfA1tj2TIns8xp1cWyVpN457Z_WJ36a1v6gmYLlWA
Message-ID: <CAJFAV8zqn=1-7rux6yVz5h-c3ATSF6c-+ur84VdBvOR1O+-3pg@mail.gmail.com>
Subject: Re: [PATCH] devtools: check uAPI headers inclusions
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i2NngwYRXvIFsqOiqOotrLtbyPRkAJ8YMEtzIw8v6sg_1795094859
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

On Thu, 19 Nov 2026 at 14:11, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> On Tue, Nov 3, 2026 at 8:59=E2=80=AFAM David Marchand <david.marchand@red=
hat.com> wrote:
> >
> > Imported Linux kernel uAPI headers must be included before any other
> > header to avoid a system-installed header being read instead.
> >
> > Add a check that runs after every operation to catch files where
> > Linux uapi includes are preceded by other includes.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Applied, thanks.


--=20
David Marchand

