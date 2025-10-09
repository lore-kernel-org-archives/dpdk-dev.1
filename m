Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FFCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:05:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94DF8402A3;
	Thu,  9 Oct 2025 15:05:13 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id E891D40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:05:12 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b63148d25c3so722979a12.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760015112; x=1760619912; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qzpzfWA5hYUXVPjVLnEXk9Bjf4P0Pu6p8iOqcmUUlBA=;
 b=DEb2y9dd6nUIqiXGpO9B7oDyuxpeRDXInoXuvax98vQL5V+V2ZAHrHWfnu3aYt/1Im
 ddUc2ZnjDiG5V8ZtpLtglSyZyVXCtoCte0S2+CMrJZcc5kgGYtRTTwDumTi7EgTrIp27
 N2l1shcU5YQAoeHpvpW8jmcIUXdAvIpwxHsvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015112; x=1760619912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzpzfWA5hYUXVPjVLnEXk9Bjf4P0Pu6p8iOqcmUUlBA=;
 b=MrVvro1ROE0cCRL5JbVNRnYiJVNr4dejBi0APnvMKDHnY29cL0vLpsEXAkM+8CZ0Z2
 eD15LrnA8hl9AINPAHx2pTl/eZpkcD18vmu7C7mdQyD8/ViYDncweUUqkhFalDEkh53z
 E3HtInAXqwKEGjTiMJDgv8bg2fnRtCApxPeHKmhSUl0g9gr1v4An1/My9UeVQTpx9ZiX
 kguWeV2HkssMi1RqOHaxBYnIRdKV98gpmehht/1UEyNbyIhlcgR0XKwH/ZCnmsCIV+uH
 0X3X/cu+CJhkhvZbrSPvDgtifhYJQ3jCIk1rs7tvOpm3B4vF+ZfbaNhE5bhO/dvxiwAh
 QyoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFec+jfUwnTOCZ4bftdHZMlpGodbC4qmazFp333M4pGZVhCAhrTIlzyVgjQq2js2CUt0M=@dpdk.org
X-Gm-Message-State: AOJu0Yy5yeP2vmH0zSmg5cZo2LRVwnD9IAY3ITPOGmF1ujGsQMicUmzD
 6yaU0Peyqfn33OjSZ0HQA6aSY1uxBlRpBjKBaEYz60a4K9EJvjtfIcIoSP0OVV5Xl3jzHBsyFLW
 RBUiOo8ADayeHZXx59SzI+qfizaZyBCFhsGax0D1IIA==
X-Gm-Gg: ASbGncuilt3JyHLLCsYPsxKbjL/Ica8eBnAfox1PtvsxP4obHoyaaW4gwS3jiwohbTq
 QjvlinHcKfK3AMyEtIEYmCjyupWJDhMZRifga20pzzraYF3If9x7LfkvSRZJxyqLT9IuMpxFESW
 piJDlFGWU9P5Oa/4D0Z743drykhUlSs5yBZsXPIJTxQ3eC8dBVSlCS9LXfecGjZ7z0MRAS6yiAQ
 IXXHR+05Yp/qX+aP2cZIOIhoyMTM9ygXYnkuu9pLJzcovlu8zrt75Icx8DsH23xNf8oy49aAg==
X-Google-Smtp-Source: AGHT+IFf6TvaDsKEwpjXa3aeO7jDs5L7FCckoqrvjJrBR904JdsUDPi0v9YebuLiJmUSxynJx4gbVtErL0j+3sZz/yA=
X-Received: by 2002:a17:903:1a10:b0:271:d1ab:17ce with SMTP id
 d9443c01a7336-28ec9cd59afmr130132025ad.26.1760015111586; Thu, 09 Oct 2025
 06:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
 <20250916200458.259376-2-dmarx@iol.unh.edu>
In-Reply-To: <20250916200458.259376-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 9 Oct 2025 09:04:32 -0400
X-Gm-Features: AS18NWDDQp0BVMnCPtrHGAmZBJhtMHkm0jXVdf9Wh3fGGK79FgpHUNKrPtn51cw
Message-ID: <CAJvnSUDzOvhfgCZvj4Y0d_JFq6xZrXuc8OcADgsABw=wN3YEwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add virtio forwarding test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008696200640b9732d"
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

--0000000000008696200640b9732d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:05=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Add test suite covering virtio-user and vhost
> server/client forwarding scenarios with
> testpmd packet validation.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_virtio_fwd.rst |   8 +
>  dts/tests/TestSuite_virtio_fwd.py          | 179 +++++++++++++++++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst
>  create mode 100644 dts/tests/TestSuite_virtio_fwd.py
>
> diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst
> b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
> new file mode 100644
> index 0000000000..782eddad2d
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +virtio_fwd Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>

I think this might break the build as I think the =3D=3D=3D=3D line needs t=
o be the
same in length as the above testsuite name. Can you check?


> +
>
>

--0000000000008696200640b9732d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 16,=
 2025 at 4:05=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu"=
>dmarx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Add test suite covering virtio-user and vhost<br>
server/client forwarding scenarios with<br>
testpmd packet validation.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/tests.TestSuite_virtio_fwd.rst |=C2=A0 =C2=A08 +<br>
=C2=A0dts/tests/TestSuite_virtio_fwd.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 179 +++++++++++++++++++++<br>
=C2=A02 files changed, 187 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_virtio_fwd.py<br>
<br>
diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests=
.TestSuite_virtio_fwd.rst<br>
new file mode 100644<br>
index 0000000000..782eddad2d<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_virtio_fwd.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+virtio_fwd Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br></blockquote><div><br></div><div>I think this might break the =
build as I think the =3D=3D=3D=3D line needs to be the same in length as th=
e above testsuite name. Can you check?</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+<br><br>
</blockquote></div></div>

--0000000000008696200640b9732d--
