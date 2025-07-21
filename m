Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C1AC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D36384021E;
	Mon, 21 Jul 2025 14:50:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1F2BC4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 14:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753102255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKL4ApGKdpWeryXMjyFK2+cU8YPffIngCR8xNkJtHEw=;
 b=PgnOMYCUVrtoRkv8EN+mE3VgPGfxkBwnGwQB3WWJYQtBK5EcPWJJtTRcotBG/rW5ZKSSE3
 c/WIyYbiBKEjIG7nrGJN5nK4p9BwAYuxbYQhmMLkDvxUhiTERi4drUr+rPeuYf45z5wt/C
 PC4h77eRLl6t3Z79SQw+fFXuma3MqwI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-D4KJMHsuNxaW4LWLPdl5AA-1; Mon, 21 Jul 2025 08:50:54 -0400
X-MC-Unique: D4KJMHsuNxaW4LWLPdl5AA-1
X-Mimecast-MFC-AGG-ID: D4KJMHsuNxaW4LWLPdl5AA_1753102253
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-32b78b5a8fcso24897661fa.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 05:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753102253; x=1753707053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKL4ApGKdpWeryXMjyFK2+cU8YPffIngCR8xNkJtHEw=;
 b=seaYhJof5rWSzSA7hmVJcHfLGDDB2DBPFrDbu7bNnwn9tV3lyWpFN/Qhdr6VVxQc0B
 vN3XiGJlBvfIMnwyfQbI/L8s+5P61ZbZ36VoACmm2kay4bvkOsXaaK4qMIgviAjxSo0a
 pQm8xXqlYOT8GDRfa81iKkcxEEf5xdG1w/0MUmW+yZ5ePj7iIra0HL9SEsUmwAuhLxRf
 UIBmEEoEucd2UfZ1OW20j+9Gz6/+XB9e7MN3yU88HimuimT/Gq1/3LSfr8JI2nWIB64r
 Xq8gEgn72ounCihsyLP4oS0L/SsWVciJ27BQM9uA/G6o9cKzXt3n8OpHLgGaghBdGcWV
 tnjg==
X-Gm-Message-State: AOJu0Yy/5nLQki3CLf8uN4FtWAn4h48yqgUKUUj/pWKvWV4ecsXWrViy
 xkkMzOyDHH4mtQzlzyGx250p1w6EaDqwnoMGZTSmKypUWbyDa1NfkrV/7yD/pGt2hN0hM9IjZ0G
 hLb4eQmnzDsiVd7Gwc3qj8zel3+/fIX9OD+8RU9031gs7tOIQ39Ga63EVVWjR1SU6+XHiNHQYF2
 u9rCrOFXK8Ct/CziKfQmw=
X-Gm-Gg: ASbGncsjlsYnGxPZtRiWFa1q8seitpH8yZJs8XJF2zwCiAvyFceRy1X+SRmRHc3qZpm
 ovZ+iFHgJ1ZWkeIsHczgSIdPWBLDXOxLzT83UcPHLg3TsEDAg3gy5T2jabS/KU848ELUKuirJyE
 uG+ccaa2Y+fuwegq7mEY22VUE=
X-Received: by 2002:a2e:be07:0:b0:32a:8591:6689 with SMTP id
 38308e7fff4ca-3308f486573mr56492641fa.7.1753102252776; 
 Mon, 21 Jul 2025 05:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/MWdKbI0k3Q3T3L3tnUgd2OyqHcJsqafuGuu+hMa7oqVWHF5bycPeBEtPlcbzl8+UDDXBFlMlCIoVDoI/j4=
X-Received: by 2002:a2e:be07:0:b0:32a:8591:6689 with SMTP id
 38308e7fff4ca-3308f486573mr56492521fa.7.1753102252192; Mon, 21 Jul 2025
 05:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240730234228.89967-1-stephen@networkplumber.org>
 <20241119230915.74118-1-stephen@networkplumber.org>
In-Reply-To: <20241119230915.74118-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Jul 2025 14:50:40 +0200
X-Gm-Features: Ac12FXyPUaELbd1FELmFh4ffnduV4IZg3sBXjo8W7TcmaWPCoxuuZIG80s_qOzg
Message-ID: <CAJFAV8wOcJmUPXx5dVMYfbABVBdBe4FhQZ0CQhz0JJTzTS4gbg@mail.gmail.com>
Subject: Re: [PATCH v2] doc: no longer support end of life CentOS versions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1JFXKDxeiIUXZp-uL4MLq4x87jQHPxi8G4ipJRlZAz8_1753102253
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

On Wed, Nov 20, 2024 at 12:09=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The CentOS Project has shifted focus from CentOS Linux to CentOS Stream.
> Both CentOS 7 and 8 are now end of life (EOL).
>
>         CentOS Linux 7 EOL: 2024-06-30
>         CentOS Linux 8 EOL: 2021-12-31
>         CentOS Stream 8 EOL: 2024-05-31
>
> Update the documentation and release notes. There is no explicit
> test in the build process that would block these older versions
> but any bug reports or problems will rejected as invalid.

will be* rejected

>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/linux_gsg/sys_reqs.rst      | 4 ++--
>  doc/guides/rel_notes/release_24_11.rst | 6 ++++++

Needs some rebase for 25.07.


>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys=
_reqs.rst
> index 13d632cec7..8b39dce938 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -53,7 +53,7 @@ Compilation of the DPDK
>  *   ``pyelftools`` (version 0.22+)
>
>      * For Fedora systems it can be installed using ``dnf install python-=
pyelftools``
> -    * For RHEL/CentOS systems it can be installed using ``pip3 install p=
yelftools``
> +    * For RHEL systems it can be installed using ``pip3 install pyelftoo=
ls``

Why remove CentOS here?


>      * For Ubuntu/Debian it can be installed using ``apt install python3-=
pyelftools``
>      * For Alpine Linux, ``apk add py3-elftools``
>
> @@ -110,7 +110,7 @@ System Software
>
>      The kernel version required is based on the oldest long term stable =
kernel available
>      at kernel.org when the DPDK version is in development.
> -    Compatibility for recent distribution kernels will be kept, notably =
RHEL/CentOS 7.
> +    In addition, DPDK maintains compatibility with recent distribution k=
ernels (such as RHEL 8).

I would avoid a clear version, so maybe mention "actively maintained
RHEL and Ubuntu releases".
Or just remove the "notably RHEL/CentOS 7" part from original.


>
>      The kernel version in use can be checked using the command::
>
> diff --git a/doc/guides/rel_notes/release_24_11.rst b/doc/guides/rel_note=
s/release_24_11.rst
> index 48b399cda7..447c24237a 100644
> --- a/doc/guides/rel_notes/release_24_11.rst
> +++ b/doc/guides/rel_notes/release_24_11.rst
> @@ -345,6 +345,12 @@ Removed Items
>  * ethdev: Removed the __rte_ethdev_trace_rx_burst symbol, as the corresp=
onding
>    tracepoint was split into two separate ones for empty and non-empty ca=
lls.
>
> +* **Removed support guarantee for CentOS 7 and 8.**
> +
> +  DPDK can no longer guarantee support for older CentOS releases.
> +  CentOS Linux 7 reached end of life (EOL) on 30 June 2024
> +  and CentOS Linux 8 stream EOL was 31 May 2024.
> +
>
>  API Changes
>  -----------
> --
> 2.45.2
>


--=20
David Marchand

