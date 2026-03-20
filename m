Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC90109317A
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 04:30:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A580E402B2;
	Fri, 20 Mar 2026 05:30:03 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 7A93540272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 05:30:02 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1271257ae53so2136398c88.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 21:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773981001; cv=none;
 d=google.com; s=arc-20240605;
 b=fVjeGCKTgBMvCW0ToeC4JHZa/06qjkvvR7w46wc3HbulJEYxL0FPMSw+KCaAQ2GGY8
 mvVYRPaMP3fAb7dVG7gzluvJrZNfu4SYWmPA/gJg4FcXU1csOTRio8kgUslsZ8KWTwJc
 NmgfWx5Oe3am5E5yPpbxsjrNbdeFdjxFAGTz+HBBJrT3Bs/PZCcnhL6nih9KClprdsbK
 slUdOsXnhe3+yFFcCwzOJST09FW8smOQ+xtS9PlrqxiQdsKg7ndXYqYXz9svzY/BpzNJ
 OyMNwY+gBoJgyNTCCmydC88UFtUmeNM+P2MbZZi2kw0NUT1d+LzN/K8qSXS0NnyzLkp+
 GRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5T4OjWKtASMCklGncqBs0bUL84ev1E3VpC1dC51C/SE=;
 fh=l0EZoFfzBfvU7SxV5hgyp7OqOPyTkyA+JpmpO0gwlUQ=;
 b=V4Fq8xQp3jNqS3nXLnLtWl7WeDrEEVBI636U4gy+G5+1q4BnzTQ/mPNJCIE69utE6m
 Awgc+DU06/RNHZXXpEgxT6vO2jdNJaC2+nfZL3R/eTGkCtkqvdWhCJj3n6GwaHGlaG4o
 D+eV0yX/Sjq3qWMjvJnqVqYBiP18yvlbrf8BUznwxfSCrPuyc34xdBUCyj4+4sZyuFwz
 VRq7MlBGMUNqZME71SAcrdcF1CpgjqF4R1qahqA0dtkTQUBR79Mmk61gJVcZF79hX1wu
 A8Q62aSDiQrYl0O1c9nQKhN8nRV68C0wRnaJsdTzy8sq+LvDtGsfduAzUJd8ZXm3Jb4e
 c6cA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773981001; x=1774585801; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5T4OjWKtASMCklGncqBs0bUL84ev1E3VpC1dC51C/SE=;
 b=Ea/ZUEv4bSL4dRCUPI+fJV2EF9TUxdoVl57I0ZAn042X1+cSCzI07NEfhVwuqf21uB
 4uJQBShtiO3kf+XciWaIs6e5lApeZaLc5fCc8881x/B+awkm6O9+fKpg+mkP2GHsL/xJ
 CqxVym0583zis4U2nbDZyTlnQWlSzznfDHWxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773981001; x=1774585801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5T4OjWKtASMCklGncqBs0bUL84ev1E3VpC1dC51C/SE=;
 b=rvPuyR7SC/7X9hzXPVYEtDLIxg1PMCf1w+BZCaOQ+9K9tn6E5JBG5VViiH4h+cmqPg
 r5s4CCkUmJE/AFU2JQ0PEio31fjmQAPnWK9Du4j6o8o7/tyGnJ9PGSRNWenaEFSs6/do
 zUKtACY+oZwB6lTXIhPS0lU+QkMq8ZnsVXE3IBSWl5pYLVBfszDObvnxrKNRkH3riyxv
 Em+Eq3z5KpKSTNjlWe9z+kdbDX7l4x1w3XRKaNLPZZvFfOfMv6BkA5U1DhSCvfFzaZqV
 eiJP84i83muCHB/ZIg0yKb6IoxiiPxb63ol1ZAqZF8GKVqPEr6+y7kNVbbPX3twu0ddp
 s4hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUIOZsYfQY9lNs93l1QbUx+JgIkaD859Sl2lYaocKTF62A/4K1AxY5OJX2fGzv4we9zrc=@dpdk.org
X-Gm-Message-State: AOJu0YyOY2NWwwA+bqCyKLREwv0rqySqrlTLWhqjLEi2OP4F/1lBo9ya
 mo3uSNJS694iCf5vPvkxy2sB0VuQLSdOjnwwW+dlYaMGkpcFhNkfMzdAn2IjONKJhIgul8y2bQ/
 He5naJ/dxnF24lIqfPkNba+yrL616sjM+xBvsdsd01A==
X-Gm-Gg: ATEYQzzflgLR+s2sD5xRQvaMVnZ4j39ezdO5nTMT9nhPtK+1lcjfmiL9xWd+ozBHPvA
 eVbqCz4Qgrk3rwHyKVl8Vs/9iJd/rwcLRv/XOKB8A+qZgveetzZiGMWvUha4WQESN6nQMdTpqAW
 VDlJsytQVigmBji0krk+Hy8N/fnaXzz2eqvHowpdx9JPnvTLapFcp4hFMbSJOucI8CnL1KqqKwi
 Qc4HsOO1RgDBukFZiNKlq0geVPWQJcZ9l3hE2TrB0DGa1Ni+oncbYjLR8hsafW1V0ram3nEsG83
 +LpZh9EO2XA49LCPfvWHcNuFkyrkNflSwDtENUnbBNclkd0TUYOyi8I=
X-Received: by 2002:a05:7022:fd0c:b0:129:ea6:a3c7 with SMTP id
 a92af1059eb24-12a725c9168mr729633c88.0.1773981001389; Thu, 19 Mar 2026
 21:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
 <20260313182240.130379-1-dmarx@iol.unh.edu>
In-Reply-To: <20260313182240.130379-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 20 Mar 2026 00:26:50 -0400
X-Gm-Features: AaiRm537xn_a9_G-gdFt-fVNog_p6xqWotHnPrl5C6JtuKBfVuZFIsev0t7F1W0
Message-ID: <CAJvnSUAnAo_Fpe9Mkb0ZYtL35oXjATt2MMJ1QzbzwFJKPNyrTg@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update overall result pass/skip logic
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Andrew Bailey <abailey@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000006d28eb064d6d23b6"
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

--0000000000006d28eb064d6d23b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, the implementation makes sense and I see that it works.

However, isn't the whole issue stemming from the fact that the currently
existing get_overall_result() function calls max() on self.children, and
self.children (the result objects) are IntEnum enums which are ordered in
ascending order, starting with PASS, then SKIP, then BLOCK, then FAIL, then
ERROR? If we just swap PASS and SKIP, doesn't that make the existing logic
(using the max() function call) work correctly?

I.e. re-order this class:

class Result(IntEnum):
    """The possible states that a setup, a teardown or a test case may end
up in."""

    #:
    PASS =3D auto()
    #:
    SKIP =3D auto()
    #:
    BLOCK =3D auto()
    #:
    FAIL =3D auto()
    #:
    ERROR =3D auto()



On Fri, Mar 13, 2026 at 2:22=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Update overall result of test suites such that
> when some cases skip and at least one passes,
> the result is a pass instead of a skip. Only
> when all cases skip is the result a skip.
>
> Bugzilla ID: 1899
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> Tested-by: Andrew Bailey <abailey@iol.unh.edu>
> Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/framework/test_result.py | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index c6bddc55a9..e05663f90e 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -187,18 +187,23 @@ def serialize_model(self) -> dict[str, Any]:
>
>      def get_overall_result(self) -> ResultLeaf:
>          """The overall result of the underlying results."""
> -
> -        def extract_result(value: ResultNode | ResultLeaf) -> ResultLeaf=
:
> -            match value:
> -                case ResultNode():
> -                    return value.get_overall_result()
> -                case ResultLeaf():
> -                    return value
> -
> -        return max(
> -            (extract_result(child) for child in self.children),
> -            default=3DResultLeaf(result=3DResult.PASS),
> -        )
> +        results =3D [
> +            child.get_overall_result() if isinstance(child, ResultNode)
> else child
> +            for child in self.children
> +        ]
> +        max_result =3D max(results, default=3DResultLeaf(result=3DResult=
.PASS))
> +
> +        if max_result.result !=3D Result.SKIP:
> +            return max_result
> +
> +        if any(
> +            r.result =3D=3D Result.PASS
> +            for child, r in zip(self.children, results)
> +            if not (isinstance(child, ResultNode) and child.label in
> self.__ignore_steps)
> +        ):
> +            return ResultLeaf(result=3DResult.PASS)
> +
> +        return max_result
>
>      def make_summary(self) -> Counter[Result]:
>          """Make the summary of the underlying results while ignoring
> special nodes."""
> --
> 2.52.0
>
>

--0000000000006d28eb064d6d23b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay, the implementation makes sense and I see that it wor=
ks.<div><br></div><div>However, isn&#39;t the whole issue stemming from the=
 fact that the currently existing get_overall_result() function calls max()=
 on self.children, and self.children (the result objects) are IntEnum enums=
 which are ordered in ascending order, starting with PASS, then SKIP, then =
BLOCK, then FAIL, then ERROR? If we just swap PASS and SKIP, doesn&#39;t th=
at make the existing logic (using the max() function call) work correctly?<=
/div><div><br></div><div>I.e. re-order this class:<br><br>class Result(IntE=
num):<br>=C2=A0 =C2=A0 &quot;&quot;&quot;The possible states that a setup, =
a teardown or a test case may end up in.&quot;&quot;&quot;<br><br>=C2=A0 =
=C2=A0 #:<br>=C2=A0 =C2=A0 PASS =3D auto()<br>=C2=A0 =C2=A0 #:<br>=C2=A0 =
=C2=A0 SKIP =3D auto()<br>=C2=A0 =C2=A0 #:<br>=C2=A0 =C2=A0 BLOCK =3D auto(=
)<br>=C2=A0 =C2=A0 #:<br>=C2=A0 =C2=A0 FAIL =3D auto()<br>=C2=A0 =C2=A0 #:<=
br>=C2=A0 =C2=A0 ERROR =3D auto()</div><div><br></div><div><br></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Mar 13, 2026 at 2:22=E2=80=AFPM Dean Marx &lt;<a hr=
ef=3D"mailto:dmarx@iol.unh.edu">dmarx@iol.unh.edu</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Update overall result of t=
est suites such that<br>
when some cases skip and at least one passes,<br>
the result is a pass instead of a skip. Only<br>
when all cases skip is the result a skip.<br>
<br>
Bugzilla ID: 1899<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
Tested-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" target=
=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/test_result.py | 29 +++++++++++++++++------------<br>
=C2=A01 file changed, 17 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py<br=
>
index c6bddc55a9..e05663f90e 100644<br>
--- a/dts/framework/test_result.py<br>
+++ b/dts/framework/test_result.py<br>
@@ -187,18 +187,23 @@ def serialize_model(self) -&gt; dict[str, Any]:<br>
<br>
=C2=A0 =C2=A0 =C2=A0def get_overall_result(self) -&gt; ResultLeaf:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The overall result of t=
he underlying results.&quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 def extract_result(value: ResultNode | ResultL=
eaf) -&gt; ResultLeaf:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match value:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case ResultNode():=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn value.get_overall_result()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case ResultLeaf():=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn value<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return max(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (extract_result(child) for child=
 in self.children),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DResultLeaf(result=3DRe=
sult.PASS),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 child.get_overall_result() if is=
instance(child, ResultNode) else child<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for child in self.children<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_result =3D max(results, default=3DResultLe=
af(result=3DResult.PASS))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if max_result.result !=3D Result.SKIP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return max_result<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if any(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r.result =3D=3D Result.PASS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for child, r in zip(self.childre=
n, results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not (isinstance(child, Result=
Node) and child.label in self.__ignore_steps)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ResultLeaf(result=3DResul=
t.PASS)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return max_result<br>
<br>
=C2=A0 =C2=A0 =C2=A0def make_summary(self) -&gt; Counter[Result]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Make the summary of the=
 underlying results while ignoring special nodes.&quot;&quot;&quot;<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div>

--0000000000006d28eb064d6d23b6--
