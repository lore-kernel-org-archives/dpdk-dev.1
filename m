Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD5C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 11:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84AA9402A1;
	Tue, 15 Apr 2025 13:19:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E185440289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 13:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744715964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctvxcFYrWf0T9cfN2mNrrNZ2jSn0YVMXDHfazmopJ30=;
 b=M/3HMSSCShnDZ55oH1BQGWJ6wEJzFV53lCOpTNX0+pam+pKZTgkm86vEfmVFgSeTyg3Veb
 dCwCfZbfVsjtMTbdxXrJvg4upuwNaM7aDbY/k8/v3bknexQQoh5KpG5x49R8+2gb+SNUAe
 KS+h1s9oNWw6WrpSJUzVNUmkcS3E6Ok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-siHEZ36CMK2jbpmnHFqWCQ-1; Tue, 15 Apr 2025 07:19:23 -0400
X-MC-Unique: siHEZ36CMK2jbpmnHFqWCQ-1
X-Mimecast-MFC-AGG-ID: siHEZ36CMK2jbpmnHFqWCQ_1744715962
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so3662040f8f.1
 for <dev@dpdk.org>; Tue, 15 Apr 2025 04:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744715961; x=1745320761;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ctvxcFYrWf0T9cfN2mNrrNZ2jSn0YVMXDHfazmopJ30=;
 b=HAY2wx2ydNE6EuMgkPxI4qBOP2QNv7HloLG4teQON/7nUCElEOPGYybN4lhj/P4IBy
 jeiiATLNJrsNvQr/XeRBxDRJ4prZHAd79wmCb+RthClpxiXxFpoWNYvGC3IK40gW1Lhy
 kgyL1CR6ssFx1mCdiznPaph15u40mTYb97z6R1J5BdaCN0adbQopOrY965xfAu0MVpu0
 LBVQnJoVvFhoIo6kTnN/+yeydEABL3Dfh9vMfESi7+CIUXMyx5KPS78AMZULp9c9Avc8
 eFnR9CwGX1YGZNoWxAiG4LHOc4rFOhi61Zwxciw4w9ixqIkWZr8iefVlBQWuO9b+NrR7
 U2OQ==
X-Gm-Message-State: AOJu0YzJARDlHDfdp8/0Z10mT4hlbFZy7jUg4zTT/BuSWBbuMKg0gSLR
 uTnAsLdoulg6mENS/Zt8/0j2R5iX/zcH9jhbYX0MapVdtoNPgvqHg7vh2W+SCChDV/UE+51OrDz
 VpZl7N7ns2tlQ2nf71HIEISNdsfFw0c09TkX+LKniX2PwTHNf
X-Gm-Gg: ASbGncsIsa0f9vjUX27MCT0ZncdKkDt8KLr02RETPTIHsH23JGowFZ/wIRaBu01cofT
 l2x1MFH+MJr9kxkMxkYWDgD/ijG/uPJupMrkXxbzwDqA47UZs3JN+06XA0KJBMVLiYKK3CsuvDA
 49iYS1uU717pFa3dmhIiAbXi3WEdM5ahC0jeIghiqKarG8N5f4p3oR4JRty+tPgvxet37aTzAZ9
 8acoaFlBxKGCZpTtm5rmAZUMqMG2WHrB7Z8pMu+vyYehIWhYYJEw7EB1ZXseX8SlabRW1B7dPFw
 1etCUDTSmY2HmVqTlaOAhciEl/Tej0saHoMqRJEE5H3OYUsylk8JJwxQfyWNdKLv/Pp6
X-Received: by 2002:a5d:64e6:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39eaaec75cbmr13721798f8f.46.1744715961510; 
 Tue, 15 Apr 2025 04:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4nb6RJUPA44RcfhWMoTxDlvC0Se46NpAYFoXl48PNiJs17fLNTbM9IfLQQNujZgRlggIhcQ==
X-Received: by 2002:a5d:64e6:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39eaaec75cbmr13721780f8f.46.1744715961133; 
 Tue, 15 Apr 2025 04:19:21 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae964089sm13953196f8f.15.2025.04.15.04.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 04:19:20 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 15 Apr 2025 13:19:20 +0200
Message-Id: <D9766V1IAZ3F.31NUXAK24Q8GI@redhat.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>
Subject: Re: [PATCH v2 3/4] usertools: parse strings from PE images
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.20.1-64-g7cb8e0e7ce24-dirty
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-4-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744680096-17683-4-git-send-email-andremue@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: knm1mb4Y5b3VHjbK6MWsLJZtFHXnccrA2ZzX6f4WrJ0_1744715962
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi Andre,

Thanks for the respin. Could you format the code using ruff/black before
sending a v3?

Andre Muezerie, Apr 15, 2025 at 03:21:
> Script usertools\dpdk-pmdinfo.py was enhanced to also be able to parse
> symbols from sections in PE images.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  usertools/dpdk-pmdinfo.py | 55 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
> index 9189a2fdbc..9e1ae5b534 100755
> --- a/usertools/dpdk-pmdinfo.py
> +++ b/usertools/dpdk-pmdinfo.py
> @@ -37,8 +37,14 @@
>  from pathlib import Path
>  from typing import Iterable, Iterator, List, Union
> =20
> -import elftools
> -from elftools.elf.elffile import ELFError, ELFFile
> +def is_windows():
> +    return os.name =3D=3D 'nt'

Defining a function before imports is awkward and probably overkill.
Can you replace all is_windows() calls with os.name =3D=3D "nt"?

> +
> +if is_windows():

if os.name =3D=3D "nt":

> +    import pefile
> +else:
> +    import elftools
> +    from elftools.elf.elffile import ELFError, ELFFile
> =20
> =20
>  # ----------------------------------------------------------------------=
------
> @@ -114,18 +120,23 @@ def parse_pmdinfo(paths: Iterable[Path], search_plu=
gins: bool) -> List[dict]:
>          A list of DPDK drivers info dictionaries.
>      """
>      binaries =3D set(paths)
> -    for p in paths:
> -        binaries.update(get_needed_libs(p))
> -    if search_plugins:
> -        # cast to list to avoid errors with update while iterating
> -        binaries.update(list(get_plugin_libs(binaries)))
> +
> +    if is_windows():

if os.name =3D=3D "nt":

> +        section_name =3D ".rdata"
> +    else:
> +        section_name =3D ".rodata"
> +        for p in paths:
> +            binaries.update(get_needed_libs(p))
> +        if search_plugins:
> +            # cast to list to avoid errors with update while iterating
> +            binaries.update(list(get_plugin_libs(binaries)))
> =20
>      drivers =3D []
> =20
>      for b in binaries:
>          logging.debug("analyzing %s", b)
>          try:
> -            for s in get_elf_strings(b, ".rodata", "PMD_INFO_STRING=3D")=
:
> +            for s in get_section_strings(b, section_name, "PMD_INFO_STRI=
NG=3D"):
>                  try:
>                      info =3D json.loads(s)
>                      scrub_pci_ids(info)
> @@ -232,8 +243,8 @@ def elftools_version():
>          return (0, 24)
>      return (int(match[1]), int(match[2]))
> =20
> -
> -ELFTOOLS_VERSION =3D elftools_version()
> +if not is_windows():

if os.name !=3D "nt":

> +    ELFTOOLS_VERSION =3D elftools_version()
> =20
> =20
>  def from_elftools(s: Union[bytes, str]) -> str:
> @@ -269,6 +280,30 @@ def get_elf_strings(path: Path, section: str, prefix=
: str) -> Iterator[str]:
>          yield from find_strings(sec.data(), prefix)
> =20
> =20
> +# ----------------------------------------------------------------------=
------
> +def get_pe_strings(path: Path, section: str, prefix: str) -> Iterator[st=
r]:
> +    """
> +    Extract strings from a named PE section in a file.
> +    """
> +    pe =3D pefile.PE(path)
> +    for sec in pe.sections:
> +        section_name =3D sec.Name.decode().strip('\x00')
> +        if section_name !=3D section:
> +            continue
> +        yield from find_strings(sec.get_data(), prefix)
> +
> +
> +# ----------------------------------------------------------------------=
------
> +def get_section_strings(path: Path, section: str, prefix: str) -> Iterat=
or[str]:
> +    """
> +    Extract strings from a named section in an ELF or PE file.
> +    """
> +    if is_windows():

if os.name =3D=3D "nt":

> +        yield from get_pe_strings(path, section, prefix)
> +    else:
> +        yield from get_elf_strings(path, section, prefix)
> +
> +
>  # ----------------------------------------------------------------------=
------
>  LDD_LIB_RE =3D re.compile(
>      r"""

