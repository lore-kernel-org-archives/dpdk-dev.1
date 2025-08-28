Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD153CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 13:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0866E4025A;
	Thu, 28 Aug 2025 15:01:08 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id C35BF400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 15:01:06 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-244580523a0so9317015ad.1
 for <dev@dpdk.org>; Thu, 28 Aug 2025 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756386066; x=1756990866; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9sSbKufXiPH2FZtt7/QUe5glHx8N4ShneS5UL0UeQHA=;
 b=WhmQV+RWOZU4MWZzE5L6B8xRrGF0W/SGWtP4A0jMmSelhQyMcwQ/RZLz6ViJiHwdK5
 ziODFsT9UwkF17Y5tVIZT3RJfOi7fu8MEfJwzEbrQ7MRuvRwvRRVJuKDhrjIXdb1prWt
 t7nkF6PH7HZ41rGIe1Hgd082kArCgUGu7S/+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756386066; x=1756990866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9sSbKufXiPH2FZtt7/QUe5glHx8N4ShneS5UL0UeQHA=;
 b=d1DgGIK7C6vBNq/DNwc6q1xUQUSVbCt7nEpSUOK+NLVmuq8f6ZKgd0FnrdqWGD7dgY
 I0lD5Oqwfep0cPNgYVjhdv4mrS0B7VYOoi9yRi+9GUfw1aAsqECoXuNX8R2a7ckqrcVi
 4xibUBUxMrCUVwOgdzL/La3480FvzHjLm4hkmIMqw5SnXzp2m4fWrXXFFyuYfCIyRhgi
 yeKCe5IAgXlv4vTk8+Q08dEadX7rpsAs148+YeeHr5T48sOB+Z2qgl+irGiAcpAYDrnU
 B2VdKUfLXDE3QjspjMbzUeTVcouh3ztfaWKe91qsBzFFW6q65it3j1ChM2RP1kS8ULDh
 keLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdjjLtEEc/OV9qggYxnfViYP9qhZpPUUL9ng4+tR9L/R/C+lKqxr2f0Ir2lyk7npaZSDQ=@dpdk.org
X-Gm-Message-State: AOJu0YxKjgq/QjKjAY/Z3dNmYbSZeVvUCUbnt4HJbR7rY+EYNI2y6U4h
 Xj0uY5Cum4O3decMmeoFfndcKW1AqrWZZmcq0dkYEsAUvXU5ub6brli87HvI5zRZZ48ev4EnzYA
 bZ4lLiinC88s6NA7FGIoIrIabePh5rcYp9wdDLizKRA==
X-Gm-Gg: ASbGncvkt35HU6pK3CAqWirIPdoT4xYVrn8hct0j6C5BKc+RgzR/HtPYj1FCyBfE3F/
 T5Oh0GGJM4eJuqpy5QRIffcvXUXRdamnCM12qMh2HDLwA+gVEt4GQckEoGammsrj9uEJy/HdPHz
 4ZwIyR4qapPVBKYUP4Nu8mZDq4jpN4f0Je8LrS4ySOTbK38VIBkygDoHO0KBtd2wKStruelTWqs
 sUacpewHfsrWABB2uA5Bt3S18mpuBtTr7dyeX3U5GJVxCcezrGsaPbhIv47
X-Google-Smtp-Source: AGHT+IHFLUXS3vXi4+oQhOf7OfOUfjrxn8k1kwlKWUJc7Oqfnj8a7KBY1FC+PIVXnZxMecwD5fF3X3Eeg7oau5tpoq4=
X-Received: by 2002:a17:903:15ce:b0:246:c7dd:8da7 with SMTP id
 d9443c01a7336-246c7dd91f6mr178327925ad.32.1756386065340; Thu, 28 Aug 2025
 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250828123758.20451-1-abailey@iol.unh.edu>
In-Reply-To: <20250828123758.20451-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 28 Aug 2025 08:54:26 -0400
X-Gm-Features: Ac12FXyC-iWKvBvlXFOybiVT5mDugAbYlm4DvaT5IO9qr3D1c3JLBZKL8iUxUUk
Message-ID: <CAJvnSUDGvKb-bP3Zpk8=vciAf_9V4WP9S3UpSgGVKYJy1oOm0Q@mail.gmail.com>
Subject: Re: [PATCH v3] dts: enable port binding on the TG
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000837ee5063d6c7fd6"
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

--000000000000837ee5063d6c7fd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Luca for the patch submission best practices advice. :)

Andrew we can chat more about the bound_for_dpdk() at the DTS meeting.

On Thu, Aug 28, 2025 at 8:38=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

>
> +        ctx =3D get_ctx()
> +        prepare_node(ctx.tg_node)
> +        prepare_node(ctx.sut_node)
> +        # ctx.tg_node.main_session.bring_up_link(self.sut_ports)
>

Make sure to drop these commented out function calls and such when you
submit.


> +
>      @property
>      def sut_dpdk_ports(self) -> list[Port]:
>          """The DPDK ports for the SUT node."""
> --
> 2.50.1
>
>
Thanks Andrew.

--000000000000837ee5063d6c7fd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks Luca for the patch submission best=
 practices advice. :)<div><br></div><div>Andrew we can chat more about the =
bound_for_dpdk() at the DTS meeting.</div></div><br><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug=
 28, 2025 at 8:38=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@io=
l.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prepare_node(ctx.tg_node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prepare_node(ctx.sut_node)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # ctx.tg_node.main_session.bring_up_link(self.=
sut_ports)<br></blockquote><div><br></div><div>Make sure to drop these comm=
ented out function calls and such when you submit.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def sut_dpdk_ports(self) -&gt; list[Port]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The DPDK ports for the =
SUT node.&quot;&quot;&quot;<br>
-- <br>
2.50.1<br>
<br></blockquote><div><br></div><div>Thanks Andrew.=C2=A0</div></div></div>

--000000000000837ee5063d6c7fd6--
