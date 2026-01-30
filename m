Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D43E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6210840274;
	Fri, 30 Jan 2026 18:13:45 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 8D4C34025F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:13:43 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1233bc1117fso2282146c88.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:13:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769793222; cv=none;
 d=google.com; s=arc-20240605;
 b=Yq5in3eaNbIh5dCIaURn+qpsWhYXK6TiOvVHXs7CG1T+wogyuGHLDiH4m3j+M3Muca
 bxeid+npY0yAy3f7TLVs6mSemKOxC+Neczb7LdcEIVlgKFMLbq6VJ8/O0H9geOnXGkNP
 GlayCm1MJ0nIW2n2U9ESm8sVcQnI4H+iY5hXikD5YL1auFOa6EvNByd5SFdNaHiN9T4i
 w1D1IloTh1Sa/TPnNpC8wNeSqqHEvT802/YbM4gicEp0erGVe4m6O8uY1DFOmxZV1Ld5
 OdEB7iS/G2tR+byS29v/kh8+mH1FKvcvkdX5dv7HDaDAIuwo4k/z0LlmrAllsg+tyzbG
 sE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zbdtMiO/uOQ5HCiOnFK5vOC5HWkcAEf2Kx4ydq7yOAE=;
 fh=FkTP05AKoi4+H/QXCdk1HgYB61dF10YtrD+oNM0tSiA=;
 b=ZgXfxJucc5GH6mv5V6MqBdr8o9heb5anOf2lCwWnFiN8o2Ho5j7AQhJn1CARHDbF4R
 rBRyy4JIm+uMKkiKt8mHjlb+E40kYF27xdVblrdc6nV+PRTa/nHkVsm/orzaKUNR9mzS
 6SwLSq0LSxX0xwbwpIEYuGpuITx9u7Z6EOAp9W9CthN9s1v4s/Meo3AFYCbAQT5ZQ4t1
 5lB1VB1WYV3qMy9C6qTKC4JE40qaTeg6XVXe9v7sgDlXq8Do4YpREuiM1XoAMIcyPPr+
 5Q9KC7f4WX/fAdr9fjmUyLomfwvgcPyiDQsdLpCnBZ9Rd8DNEZcI4CtzM3ESLW8XxNye
 KPmw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769793222; x=1770398022; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbdtMiO/uOQ5HCiOnFK5vOC5HWkcAEf2Kx4ydq7yOAE=;
 b=aQOMttRFuLsoLFwxtMn+SgiirpFdK0TF+d/XmebQCo1Z3B/gEgs+XnWHpvBnrH8/8Y
 y1DjKkv7B0rssy5i2UCHoXkmnhxBfgCEKs8ubHbJ5iX9nUb3UWyBLl4GBrkr6r8g+EaM
 o22DW7RMY5oQLo11AZiDNJ4CwGi/oddeTLpNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769793222; x=1770398022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zbdtMiO/uOQ5HCiOnFK5vOC5HWkcAEf2Kx4ydq7yOAE=;
 b=K36B6Zhh623hc488VcOC3YLJ9e3m6J8OlYOBONGX9aH3hNveHPgsfQxVUUzqMsd2qJ
 7UHxg72pMb1EJ56Xj9dntj+HIKghq6ofQ8Rj3buunQtA4nEoa/zntFSwkXFvRmec6WxN
 nguuDBgxsRXrvkTNbAWd3a5P+ni9qhwYtCYEAcV6oItdxFtkA/4ja+MPvyDsXbdzkl8Z
 iOfQljipSjlLnIIFET//NhkfFElEJIBSpP9tj6jonoVceA74zUJRopSfZUb6JyVWdYcT
 Kaw9/PSLK7Fph1JB5JxrQeGGePEwE0qVIpwgI8K5ZDtDFKv50yONpINXEcNTuj5Q5Fe9
 jO3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSAYUwFov77yssGc/OlQhn4QPdaL/faLBs4SEWB+nhg1x8uf0oYtA+tv4RqiSY4gYtSE=@dpdk.org
X-Gm-Message-State: AOJu0YwDHztc0pOG8Oj+S3OBm2zD4Q7VJ0S29xrWEaBudGOKPpVHta7a
 edjcFy2gPNXX2haauiQtizXIdds5KWr9HIAlRmZgWn0FgyZw9O+ZmO0mDC+ogCD5c1PkDl7CYSI
 VZJJ7+l1v5tSNHWjtAwCumC93VZgAp6jX2PXPKdnhWA==
X-Gm-Gg: AZuq6aIbJzDrbAi0VT9Dz1mX4c/NQgJNGTLiNtzWOx2Uv8i3LKMVfJcltGEtk9jHoXl
 9twk5lJHMRthEWQ6Oex0JN2an8jLfMD8SDoiU9IyRShuX/zBiwc3fjZ+FT0FBKFHhnTyFpm/riq
 j3LYWl8Ngn4+suUFsyZvzlCW40IErL0OMXQsO8BY6QoHhWmSr2HoX8rYPy3d0u3AbecMbN2b5ju
 /5KGvjEIcghau9AAMk+zLeyKUFKNEMSdelgIJLZv6NyMTUizZwRf1ClHLNl77KG8ouo9YBtEsyo
 /2w8LLGf6pqd0zf/HcdlrXRStJIOD5kqPTctnPRs+oTGHkYf85Plaq48d+iF
X-Received: by 2002:a05:7022:404:b0:11b:8e9f:1089 with SMTP id
 a92af1059eb24-125c197eeaemr1421395c88.6.1769793222519; Fri, 30 Jan 2026
 09:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20251106181355.209706-1-dmarx@iol.unh.edu>
 <20260122174742.237855-1-dmarx@iol.unh.edu>
In-Reply-To: <20260122174742.237855-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 30 Jan 2026 12:11:16 -0500
X-Gm-Features: AZwV_Qh-AaufjPzR0FmihknBNqBD8vjx-HmgRUZeAEhWyCeM5w30J_-NGxi0bEI
Message-ID: <CAJvnSUD9BBT88qo32fg=u7bf_9Jwe1NPQfYYESzGP-2AUAWTyQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dts: add test case docstring checks to format
 script
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

Thanks Dean. Series applied to next-dts.

On Thu, Jan 22, 2026 at 12:47=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrot=
e:
>
> Add a python script that checks all test cases
> to ensure each docstring contains a steps and
> verify section in accordance with coding guidelines.
> Add a section within the check-format script which
> calls the docstring script after linting with ruff.
>
> Bugzilla ID: 1623
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  devtools/dts-check-docstrings.py | 54 ++++++++++++++++++++++++++++++++
>  devtools/dts-check-format.sh     |  5 +++
>  2 files changed, 59 insertions(+)
>  create mode 100755 devtools/dts-check-docstrings.py
>
> diff --git a/devtools/dts-check-docstrings.py b/devtools/dts-check-docstr=
ings.py
> new file mode 100755
> index 0000000000..3b0d2a42a1
> --- /dev/null
> +++ b/devtools/dts-check-docstrings.py
> @@ -0,0 +1,54 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +import sys
> +from ast import FunctionDef, Name, walk, get_docstring, parse
> +from pathlib import Path
> +
> +BASE_DIR =3D Path(__file__).resolve().parent.parent  # dpdk/
> +TESTS_DIR =3D BASE_DIR / "dts" / "tests"  # dts/tests/
> +DECORATOR_NAMES =3D {"func_test", "perf_test"}
> +
> +
> +def has_test_decorator(node: FunctionDef) -> bool:
> +    """Return True if function has @func_test or @perf_test decorator.""=
"
> +    for decorator in node.decorator_list:
> +        if isinstance(decorator, Name) and decorator.id in DECORATOR_NAM=
ES:
> +            return True
> +    return False
> +
> +
> +def check_file(path: Path) -> bool:
> +    """Return True if file has steps and verify sections in each test ca=
se docstring."""
> +    source =3D path.read_text(encoding=3D"utf-8")
> +    tree =3D parse(source, filename=3Dstr(path))
> +    ok =3D True
> +
> +    for node in walk(tree):
> +        if isinstance(node, FunctionDef):
> +            if has_test_decorator(node):
> +                doc =3D get_docstring(node)
> +                if not doc:
> +                    print(f"{path}:{node.lineno} missing docstring for t=
est case")
> +                    ok =3D False
> +                else:
> +                    if "Steps:" not in doc:
> +                        print(f"{path}:{node.lineno} missing 'Steps:' se=
ction")
> +                        ok =3D False
> +                    if "Verify:" not in doc:
> +                        print(f"{path}:{node.lineno} missing 'Verify:' s=
ection")
> +                        ok =3D False
> +    return ok
> +
> +
> +def main():
> +    all_ok =3D True
> +    for path in TESTS_DIR.rglob("*.py"):
> +        if not check_file(path):
> +            all_ok =3D False
> +    sys.exit(0 if all_ok else 1)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.sh
> index 907eed1293..23c0a5f1da 100755
> --- a/devtools/dts-check-format.sh
> +++ b/devtools/dts-check-format.sh
> @@ -13,6 +13,7 @@ usage() {
>  format=3Dtrue
>  lint=3Dtrue
>  typecheck=3Dtrue
> +docstringcheck=3Dtrue
>
>  # Comments after args serve as documentation; must be present
>  while getopts "hflt" arg; do
> @@ -97,6 +98,10 @@ if $lint; then
>                 echo "ruff not found, unable to run linter"
>                 errors=3D$((errors + 1))
>         fi
> +       if $docstringcheck; then
> +               python3 ../devtools/dts-check-docstrings.py
> +               errors=3D$((errors + $?))
> +       fi
>  fi
>
>  if $typecheck; then
> --
> 2.52.0
>
