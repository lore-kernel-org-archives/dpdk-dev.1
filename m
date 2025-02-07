Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0629C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6B1D42E80;
	Fri,  7 Feb 2025 15:44:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2E41342DE3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:44:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9Wo45vttKxtpb0Sr8+0/n2Do31m5eQ5ZEhlC4STiAA=;
 b=gx4ILuKd5wzPmsaFRwxQU8xBbrXGhKMuzj1grmfQQ0n+kLIwUhhl7ZFHI2AyTTk2+7x2E8
 Bja+UAy1nn28RFtTwEvSRZmow2uEp6osG3CKKpujU0bzLcB/kHNmGFQEvhn3Ts4h1rfBRD
 KBtMrWU6YfClNudeVQQVO0T+oSld8Gg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-7DTH0VAcPYOEXCpXXBNS9A-1; Fri, 07 Feb 2025 09:44:27 -0500
X-MC-Unique: 7DTH0VAcPYOEXCpXXBNS9A-1
X-Mimecast-MFC-AGG-ID: 7DTH0VAcPYOEXCpXXBNS9A
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-544103a1b71so1118592e87.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939466; x=1739544266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9Wo45vttKxtpb0Sr8+0/n2Do31m5eQ5ZEhlC4STiAA=;
 b=qzZuv/Z3qZHPFJp12KeAjveWcmo/bhkoFVNmJg+j6SoDNME55LIAlXL77WpDs/5vPH
 ydcYwcoKXmUXv7uPy6+daa/HxF1ejZ6Dfe0Cf14x+nDXuhbrK+DzJ53hDbhLnFLwy8xC
 jRLPUELEKk1gjlN5n+EKk/TFZkUk/iZKnuajs5E8/jIwfThYtyAcMar4Cxn49STj+AD+
 XeeRaYTIMXpxfRGouKr0pEBhf+ylNfyLX11TDcP1HItUkZw/3n3t5HzJkP4o5/5AyKI+
 u1M9KZD060b3A12rEXEEZ9D8qrHJQLjIjabkkhVqiHQE7g+2xr4/URVUOVtD7GRY068D
 bBMQ==
X-Gm-Message-State: AOJu0Yyf4jzfidjq1HnFX/SLwlCxb74/Ibhr0A4GiHUiNjQI9gSc44+n
 +ER2JoF9NWAeyypqRN16OPbp0Zak8pOChd/8ohW93F0EM0nPq1A79cJNPDN5RLyB+Jm/SUd6GNT
 AYpbfH1JEsmCSzvqPg3p5qquj5Wqzi4W+cgAO+QMGehE+HeQQFDgYEY2+bwW2V/a/o+QtltS/nX
 8FsHj8kqP209r+3RQ=
X-Gm-Gg: ASbGnctA2R79G9rmsmqT4z6gYa1zaejHrJYtUHnmj08oKDFrsrySfCv5BOrEwe1umuG
 Yi8Amp/k1nqNoLukjuAw2B7vhUTauSJkcVz2VZ8nuvDciOqdz0v/i2nvh4OdWtPdE
X-Received: by 2002:a05:6512:39cf:b0:544:f8e:ff98 with SMTP id
 2adb3069b0e04-54414adfa4bmr1061541e87.42.1738939465991; 
 Fri, 07 Feb 2025 06:44:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlz6s0EIqnhMifutmdWh7w9m7ZsQBk0nf6xxgINJYYr+iJ2jWd4BWRxX6ax/XD+4xcWm/w6S7IFFy5H09e5I8=
X-Received: by 2002:a05:6512:39cf:b0:544:f8e:ff98 with SMTP id
 2adb3069b0e04-54414adfa4bmr1061533e87.42.1738939465592; Fri, 07 Feb 2025
 06:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20241208023022.777275-1-otilibil@eurecom.fr>
 <20241213144145.59916-1-otilibil@eurecom.fr>
 <20241213144145.59916-2-otilibil@eurecom.fr>
In-Reply-To: <20241213144145.59916-2-otilibil@eurecom.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 15:44:13 +0100
X-Gm-Features: AWEUYZmZAhODgJgfHKiljfkOYUaXLp28a5PbIO2yHg2-I4_V57GHXTDPMkWzR_M
Message-ID: <CAJFAV8z0ZaH3_c5W_mU0TxL6NjHKRvQDhrT_voWKr2TKrPFUow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] buildtools: clear out regex syntax warnings
To: Ariel Otilibili <otilibil@eurecom.fr>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Robin Jarry <rjarry@redhat.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tTYhCgCNwEU6vsyA110cciXzcYtMpzBpBsZPwdexgpE_1738939466
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 13, 2024 at 3:42=E2=80=AFPM Ariel Otilibili <otilibil@eurecom.f=
r> wrote:
>
> * invalid escape sequences now generate SyntaxWarning
> * therefore changed syntax to raw string noration.
>
> Link: https://docs.python.org/3/library/re.html#module-re
> Fixes: 0aeaf75df87 ("test: define unit tests suites based on test types")
> Fixes: 25065ef1f6c ("test: emit warning for orphaned tests")
> Cc: stable@dpdk.org
> Signed-off-by: Ariel Otilibili <otilibil@eurecom.fr>

Fixes: sha1 should mention 12 chars.
Fixed, and applied, thanks.


--=20
David Marchand

