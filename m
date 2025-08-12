Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:23:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2A54026A;
	Tue, 12 Aug 2025 11:23:10 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49]) by mails.dpdk.org (Postfix) with ESMTP id 45F2B40264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 11:23:09 +0200 (CEST)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-55b9c2482e9so6068841e87.1
 for <dev@dpdk.org>; Tue, 12 Aug 2025 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754990589; x=1755595389; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=85etL0DzWOE/w53gfSFhbg4UFFOupLOkCGs2JVs2Yig=;
 b=fDr+E2/PT7B6eO6Rr3BOVzORwCRtzuf3RoXZv9H1jB1vq4G+VzCMyP6hURriVv6cWM
 jgbdCSNSH1sUBVHMYLZyfDSBlwJgDqaAVyCQJiL99Ucp4A9olhnS5shMtddVkDSTWONt
 TfsYy21yLcWrJeDjlfcyY4vxocZEup0IB7+vUDCUooUeHHQbhoFb4gcj9R7NKbQ3Ixgz
 YCk2T/j4ZNpdQCRqerzbiv6yUjjKEmhVzkgyt9UDp4kLWRJRNm+sy1lvnXYB+OGXKLj8
 STiCC3CGwENI+hgEPT3HIaggV3JApxMNJt/SbfLcxSK0wR+fKsXW0R5vNcPEVnUfVGlO
 bDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990589; x=1755595389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=85etL0DzWOE/w53gfSFhbg4UFFOupLOkCGs2JVs2Yig=;
 b=w2IFtDTsdWBSuMsOuJcBNpxoyK2wWQnetFehZNyM8O7YnfxO7NK93MjQpFevKGpbNw
 VGWfkPIsUEQ+QyfNZ/FqKAkZ4NiI4P6KzyN2+N3iGEtwJNWquGtFR0CyqjJLPPGXfss4
 hZeJCRVMYWFDxGxzwhAmHyeVCc6k2EZo5/tM6sFcJHAK7OtiAFAHLGaf5rmKmZQrBuHN
 qlJrrqxLdmW+XbukYoPZuGwWRQ30ZAvYoNOTy4WM3rjTwReKAJeMHSB6OIjnld4MEXxV
 halfw+rjKJBoR94PMXTqfvmkOtsgBHTiynptI4Grr9ObThXMKMMeY2Rkqs2HBrPyHWO8
 4rgg==
X-Gm-Message-State: AOJu0YzszjSvT7NWLxUWey3Z1gA/CcElQpVz+JM0D0Na7DM2tjotKjT4
 wK1fCPMJH2E1mreLAFZAtbOpqpFbA5/NmmOrLA5Xueucqspz9bwyxhBgO9kLIwP+hw1+vrDnPC2
 3jSaZjCYgvSXuxrDMDdRrSxkkB+U+1h0=
X-Gm-Gg: ASbGncsOHSUewOzaAhbIXbFGWZpnEvfd2xe2PiiwxW9wDERpYlSuuqnvvPzzOVS3uHP
 GvC75L4XI6MJl/JnKAP6YY9QS9gEj9HcNNgAaHZfac7nwsoxlCL+2Es8I5TcHg9UKNgHRgwJwwU
 azdmvokHRC6R0hEBDuGw8ZKOUPvXje4n8U4Dv7H+5QdFhBJ5n3L2gD+R2s9dnkiJHQ2kHLxvpVt
 T/NBgnjzll6i91z5A==
X-Google-Smtp-Source: AGHT+IHRxevl0gJrj3zqukjAmHWJXy2yFyP9p69MipmCKwLDtalH1dJIwZfWkquDTaDINFRF51JTa4iGujopjfG0K6A=
X-Received: by 2002:a05:6512:3b2b:b0:55c:c971:2265 with SMTP id
 2adb3069b0e04-55cd763f664mr651846e87.40.1754990588223; Tue, 12 Aug 2025
 02:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_C36C8B675AB5C9C26B48AD986FEE0FCB2905@qq.com>
In-Reply-To: <tencent_C36C8B675AB5C9C26B48AD986FEE0FCB2905@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Tue, 12 Aug 2025 11:22:58 +0200
X-Gm-Features: Ac12FXwXDJjs8J-pMhYefNfmhGidq9SsKaTmd4cQgbyTdBBpVLpig8j46m3bfqU
Message-ID: <CAJcPQBou5nf7JsbOMOKcQu6LFshR09cokarxTSRN2HTdkW1Vfg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] riscv: override machine_args only when default
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>, 
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000986a0e063c2796a1"
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

--000000000000986a0e063c2796a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025, 20:21 , <uk7b@foxmail.com> wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> Support using -Dcpu_instruction_set=3Drv64gcv to enable V extension.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
Reviewed-by: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>

> ---
>  config/riscv/meson.build | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/config/riscv/meson.build b/config/riscv/meson.build
> index e3694cf2e6..f93ea3e145 100644
> --- a/config/riscv/meson.build
> +++ b/config/riscv/meson.build
> @@ -111,13 +111,15 @@ arch_config =3D arch_config[arch_id]
>  # Concatenate flags respecting priorities.
>  dpdk_flags =3D flags_common + vendor_config['flags'] +
> arch_config.get('flags', [])
>
> -# apply supported machine args
> -machine_args =3D [] # Clear previous machine args
> -foreach flag: arch_config['machine_args']
> -    if cc.has_argument(flag)
> -        machine_args +=3D flag
> -    endif
> -endforeach
> +if (cpu_instruction_set =3D=3D 'rv64gc')
> +    # apply supported machine args
> +    machine_args =3D [] # Clear previous machine args
> +    foreach flag: arch_config['machine_args']
> +        if cc.has_argument(flag)
> +            machine_args +=3D flag
> +        endif
> +    endforeach
> +endif
>
>  # check if we can do buildtime detection of extensions supported by the
> target
>  riscv_extension_macros =3D false
> --
> 2.50.0
>
>

--000000000000986a0e063c2796a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 1 Jul 2025, 20:21 , &lt;=
<a href=3D"mailto:uk7b@foxmail.com">uk7b@foxmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">From: Sun Yuechi &lt;<a=
 href=3D"mailto:sunyuechi@iscas.ac.cn" target=3D"_blank" rel=3D"noreferrer"=
>sunyuechi@iscas.ac.cn</a>&gt;<br>
<br>
Support using -Dcpu_instruction_set=3Drv64gcv to enable V extension.<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br></blockqu=
ote></div></div><div dir=3D"auto">Reviewed-by: Stanis=C5=82aw Kardach &lt;<=
a href=3D"mailto:stanislaw.kardach@gmail.com">stanislaw.kardach@gmail.com</=
a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0config/riscv/meson.build | 16 +++++++++-------<br>
=C2=A01 file changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/config/riscv/meson.build b/config/riscv/meson.build<br>
index e3694cf2e6..f93ea3e145 100644<br>
--- a/config/riscv/meson.build<br>
+++ b/config/riscv/meson.build<br>
@@ -111,13 +111,15 @@ arch_config =3D arch_config[arch_id]<br>
=C2=A0# Concatenate flags respecting priorities.<br>
=C2=A0dpdk_flags =3D flags_common + vendor_config[&#39;flags&#39;] + arch_c=
onfig.get(&#39;flags&#39;, [])<br>
<br>
-# apply supported machine args<br>
-machine_args =3D [] # Clear previous machine args<br>
-foreach flag: arch_config[&#39;machine_args&#39;]<br>
-=C2=A0 =C2=A0 if cc.has_argument(flag)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_args +=3D flag<br>
-=C2=A0 =C2=A0 endif<br>
-endforeach<br>
+if (cpu_instruction_set =3D=3D &#39;rv64gc&#39;)<br>
+=C2=A0 =C2=A0 # apply supported machine args<br>
+=C2=A0 =C2=A0 machine_args =3D [] # Clear previous machine args<br>
+=C2=A0 =C2=A0 foreach flag: arch_config[&#39;machine_args&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if cc.has_argument(flag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_args +=3D flag<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 endforeach<br>
+endif<br>
<br>
=C2=A0# check if we can do buildtime detection of extensions supported by t=
he target<br>
=C2=A0riscv_extension_macros =3D false<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div></div>

--000000000000986a0e063c2796a1--
