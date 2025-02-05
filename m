Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CDEA40289;
	Wed,  5 Feb 2025 11:09:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 21B8340270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738750178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZv12rCR3FtmLrNNhs9HBuPk8QWnMMt1SJy7dfFxkJo=;
 b=YnBv1IEv4oHykqmelm+Q3Y7CRYyG/DD72yWWouMmbMbr6Fveu3CCjzV83lht2QJkQBkJZW
 OIhy3m5hHB8AmGFwnpURCrow46eY7S65PHb5b38TWt9NcOAmKcA1sOcaeRjoyEKc4SeffU
 pVPqyWmuu8rLXpPQyA1wIe2aPnQf7Z8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-0vhS2ABkN0ukC6qY4FG5yw-1; Wed, 05 Feb 2025 05:09:37 -0500
X-MC-Unique: 0vhS2ABkN0ukC6qY4FG5yw-1
X-Mimecast-MFC-AGG-ID: 0vhS2ABkN0ukC6qY4FG5yw
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53e1bddea1dso62619e87.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 02:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738750176; x=1739354976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZv12rCR3FtmLrNNhs9HBuPk8QWnMMt1SJy7dfFxkJo=;
 b=qVoHIYuAuhJwUJDYNdPxj/UvI1fIa8SZehNeaKeI921IfidpmTzQ4nn9v9sWfCx7bB
 8/ovPd8gC2OW4qWi/T7ZleDQNYRRwQrKaXvkxEHZAku+V6CylujdYYWx16wDmteFuNxq
 4sfRMFLEcT4pwbKl/9bAZRZI7rSXAIERSOry1V60VlQjy+T/VLX8VoBIog7FM10NURTC
 mMu4ghlxaqoxFzEXimkyrNwLoIJevSJ3TC8Uunk3Cffb11FKKrSSrhdTbJ+izPI1MY9J
 ha7lXDmwiSxYsCR3lNyW/1F47Rqlrj9EViXNFnqmWzOcUn5h2jBJACPtCZeuEeQu8RRM
 DWQg==
X-Gm-Message-State: AOJu0Yxn5d4Y7GqUULB0XLHxbERm9FEGyPkBH+szVyuodi8RQFtpwlwT
 gAcyaj56EfdR5yIbtIL6DwCtjCEXjObMz+NsiwV2zPAJmZhNCYg6z5AIZYivO9SvRs7o5g8y0ic
 /lAtwa457g38+Tl8o+V5MAGutCe516x1Blh1GC1WeTUBaI2zsxzetP21rrLDLc2pmEi6+LFZeno
 CEkkm3dHYbk8Luu/Q=
X-Gm-Gg: ASbGncuNr2EllbxEba1gwkZVr7P/pwzG2Uh/jrot/lA6XeOBqL5A3Vj3orT2JTpd9hZ
 X5x21PI7zfNvQvywA+19DJ8gofDB9TZj63+Wrsq4t3gADj5Kv9O5rpCuUKhhzUkww
X-Received: by 2002:ac2:4e0c:0:b0:540:2a92:7dac with SMTP id
 2adb3069b0e04-54405a0c68amr585009e87.17.1738750175876; 
 Wed, 05 Feb 2025 02:09:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwUd48mD8LEB0JaGAanMv89Es7z6pzgPC60MkqDEhnHUY5/i6POACogVcPmQTcqRWiJ8xzFI1qEoSqfQnOm48=
X-Received: by 2002:ac2:4e0c:0:b0:540:2a92:7dac with SMTP id
 2adb3069b0e04-54405a0c68amr584998e87.17.1738750175449; Wed, 05 Feb 2025
 02:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250130151222.944561-1-bruce.richardson@intel.com>
In-Reply-To: <20250130151222.944561-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Feb 2025 11:09:23 +0100
X-Gm-Features: AWEUYZlCRIEb7ahCD9eTp2PDFiBfP0ph2jxQOdnPYlSk2dXUvwi-pmI7XOFCQ8Q
Message-ID: <CAJFAV8zKPQGaCcHTg9BCkzqd5iM2EyF0tmQZD=YdRZeeBNpp2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] remove common iavf and idpf drivers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZftvS9s8YqdttbZkaYr9wOXA3nBHuqH2UGBtT8irqg_1738750176
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

On Thu, Jan 30, 2025 at 4:12=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The iavf and idpf common directories were used only to share code
> between multiple net drivers and did not need to be drivers in their own
> right, since it is just as easy to have a dependency from one net driver
> on another as a net driver on a common one.
>
> This patchset therefore aims to eliminate the two unnecessary common
> drivers. It does so as follows:
>
> * merging common/idpf into net/idpf and updating the cpfl dependency to
>   point to the net driver.
> * merging common/iavf into net/iavf and similarly updating the
>   dependencies, including the paths from idpf (which does not directly
>   depend on iavf, but does make use of the definitions in the iavf
>   header files).
>
> Separately, two other cleanups are done - one to remove an unnecessary
> warning disable flag. The second is a little more complex - it makes the
> dependency between ice and iavf an optional one, by having ice compile
> in the necessary iavf shared code files in case iavf is disabled in the
> build.
>
> v3: add libabigail exclusions for removed libs
> v2: include Release note updates

v3 has some meson style issues.
UNH is picky about this as it (recently started to?) runs check-meson.py.

$ ./devtools/check-meson.py
Error: Incorrect indent at drivers/net/intel/ice/meson.build:29
Error: Incorrect indent at drivers/net/intel/ice/meson.build:30
Error: Incorrect indent at drivers/net/intel/ice/meson.build:31


--=20
David Marchand

