Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EDC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 12:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0714740615;
	Wed, 26 Mar 2025 13:02:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 843E1402DF
 for <dev@dpdk.org>; Wed, 26 Mar 2025 13:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742990567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+WZPU59YolL7yEdkwGyceXQHbKVfK6HIjd26P7SqUw=;
 b=WdJS5RvS/nowpEgZrWn/HceuVUHC1CgMg5NlwegMQ9py/CLA8UaTpvC1HwV9nCxkF71xuh
 7n432PHRPfszuX49Lp76q+4yK2otEx15YMRKOYBysO6siVWOYUqKIsCQat9l87JQD1zDgY
 cXrM1MfmloBRpMMOTErSNZBS0voHyag=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-0Uz4AJDAOvqCLnB48qCzBw-1; Wed, 26 Mar 2025 08:02:45 -0400
X-MC-Unique: 0Uz4AJDAOvqCLnB48qCzBw-1
X-Mimecast-MFC-AGG-ID: 0Uz4AJDAOvqCLnB48qCzBw_1742990564
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30d8de3f91eso21162361fa.3
 for <dev@dpdk.org>; Wed, 26 Mar 2025 05:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742990564; x=1743595364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+WZPU59YolL7yEdkwGyceXQHbKVfK6HIjd26P7SqUw=;
 b=H8hvQiwT1VY94fJ3MgtXQphLTS6Cvatz9OX27HlXleVhSBqqmju0+i1aBxOOugki+o
 QwkamKlsggk44B+bggprgcawsz5bEJMgJJJ5q+VBJpXyb8hFODeNnVvKAnm6pze593Gg
 xq0RbYguuKJ395hbYQd8WYxQJb71id/L5La3iMQVL32Q5KBiRQcZZGNwurk25vUvy7P9
 MakvOwPRG/6n5kgqYAJH3+OcEMXkqIig+mq+78eT0pG/oAqxz3rit2WbOdAdTTdYuMHx
 S9ecAiWNf2b/Mt0RvT/emR08aF8dPJPaKcHxUdRhYyx9XvYOt7yzpPaAcvS3OGUr6AEX
 MQGg==
X-Gm-Message-State: AOJu0YzyGlysWJ5A2++v/ahLQ+HePOZBsvZL350xz0R/ZNaSnRC+cv7j
 /rJtdUATt/Rxk11XqEw6MXhGWy/nZgmvsyRV0iOVkY8c992om+hzaX3anuHbDUWbOQ6UbL7rDiY
 YMz6lyYgC5v48BjiB0vjn//OsB6D6prFhUoiuypA2RF4zVVXXYrcaQvx0C6pxavwpyaTNsCCphR
 enKumgIPCfIjkN3qA=
X-Gm-Gg: ASbGncv+++tM+zg2Eg6pAL2UyvlN1uVepv8jU8wJY9VNpRCySfsDMhW+0ldSvaMPEt1
 SwUMsVtbWLbjvORyIPFDxixSJwPIj2QNyW30CFc2BCem2CWPqr9sxXlbNUuNS1k14dDCzmDQF1M
 E=
X-Received: by 2002:a05:6512:1590:b0:549:57ae:ab44 with SMTP id
 2adb3069b0e04-54ad649491dmr6205256e87.26.1742990563988; 
 Wed, 26 Mar 2025 05:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0D2XqLJv6Ca87w35+RuJXAUuP+Uo10rr30ekP4E/UdNzCw9ErfPik2FpxdbHqpOk4vlA0aBUw1SJuMBL7efg=
X-Received: by 2002:a05:6512:1590:b0:549:57ae:ab44 with SMTP id
 2adb3069b0e04-54ad649491dmr6205213e87.26.1742990563507; Wed, 26 Mar 2025
 05:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
In-Reply-To: <20250317154308.2782689-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 26 Mar 2025 13:02:32 +0100
X-Gm-Features: AQ5f1JoOzcT8-viodHMIbFxQiQzlgxQ_8ISfvfelZdyX2yto6hkqyMt70Qlqil4
Message-ID: <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
To: thomas@monjalon.net, bruce.richardson@intel.com
Cc: dev@dpdk.org, andremue@linux.microsoft.com, 
 dpdk-techboard <techboard@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Aku1NG4oeRzvDNU4kaVwDI4v-KVkEUkpcPg58jnXTzI_1742990564
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

On Mon, Mar 17, 2025 at 4:43=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> So far, each DPDK library (or driver) exposing symbols in an ABI had to
> maintain a version.map and use some macros for symbol versioning,
> specially crafted with the GNU linker in mind.
>
> This series proposes to rework the whole principle, and instead rely on
> marking the symbol exports in the source code itself, then let it to the
> build framework to produce a version script adapted to the linker in use
> (think GNU linker vs MSVC linker).
>
> This greatly simplifies versioning symbols: a developer does not need to
> know anything about version.map, or that a versioned symbol must be
> renamed with _v26, annotated with __vsym, exported in a header etc...
>
> Checking symbol maps becomes unnecessary since generated by the build
> framework.
>
> Updating to a new ABI is just a matter of bumping the value in
> ABI_VERSION.
>
>
> Comments please.

- I am considering making rte_function_versioning.h a non exported
header (precisely, moving it to buildtools/ and maybe renaming it).

This header contains macros not prefixed with RTE_.
Using it requires some build trick (see use_function_versioning).
And I don't see symbol versioning as a MUST infrastructure that DPDK
needs to provide to datapath applications.

Yet technically, this change would be an API breakage if some
applications indeed relied on it.

Cc: techboard for info.


- On a similar note, this RFC series adds the rte_exports.h header
(defining RTE_EXPORT*_SYMBOL()) in config/, though its job is for
extracting a symbol list during the build.
So a better location is probably buildtools/.


--=20
David Marchand

