Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AEDC36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A5F64065D;
	Thu,  3 Apr 2025 03:25:41 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 37EBA4065C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:25:39 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso350713a91.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743643538; x=1744248338; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qg9PqB8M5xJynOfNQYRPMytue7pePkO6A91g8lN1Sz4=;
 b=HxcSvH1goK3jcQh3AuTVvY9VNS/8x0Ps610gMsGTsYPmohevzBDFVOHtmGglvY58NK
 OErrrt6QIIqLx9iePkBrIvM/uGWS8ds8etfi4LMfrFKM6yaLIXlZKjN1hQXYvYogVoCB
 4g5nsVcsqJBQ9ppJHmt37R4XmNeuYmEWh75Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743643538; x=1744248338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qg9PqB8M5xJynOfNQYRPMytue7pePkO6A91g8lN1Sz4=;
 b=vnq0HFEtbZHSYnwzcNPvRsmbhM+qa7rJXlIK6/bodgV/lMGYjTjtmH1PYK2xeyGVUm
 Qjy8ziAe3GMaCsLh7O7A4Rfh9XH1HUKkxtSSznFiB05zzR5FP6SKYAfdeCFRuL01BVFT
 PXBJnd/6BqwpLtJtn7rvycr2ctd4kOgX/nISnIBGCji9xmu6NInLOzKXSTqcuTtwkHLz
 3Ai8afOASTg2WKRECP+WUttCJCksOJgKHRKOECD2ThLluR3b4nEhEpDk2YLwQJCNeevU
 zg720/YmBTjDJh61T2cA6YFW2WAXSRzEk7R7p2KMCnAOed7qCwXD5STHEoeNb2NzXdKH
 6d9g==
X-Gm-Message-State: AOJu0YyiXIUPH60kkqXtfwh1elYDQFeKiH6w0YL/Lo5hjjyHHSlhWacj
 Ijt0iqst8ra7Ila5Dk6b7wSDtCRVO7mew8WOQ6m228bFM3qNLemndhyuZTPxYjHhy0zk2w7hPem
 AWfgrvJF2xZBevp1I/JaHwbQTKSg7Nh42RbM0Ww==
X-Gm-Gg: ASbGncueiUsX8zEanX/bWzdwXQtv7xcX8zsJYFwmVIlSgAAVCPZ4AtN9TSkuaGzxwWL
 gk5DzRXqLGCH6szgBt7TFLadlKp+HBjEl7IwMdhgkmiz3jVXuxKnqdlQvtjuS3cMs6GL0tuaxSC
 h9PdsENjsb8h71RBjekG/vgasRjjZxNipBO3eRG208
X-Google-Smtp-Source: AGHT+IHrywUOnh7/fQuJwRztLEveUL83PbEHacrDqJuEi+CM3t3cBZmams/N/IlRSU1nWF4hmpXY0aYLrs9d/6GsywA=
X-Received: by 2002:a17:90a:e706:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-30532154804mr28909554a91.28.1743643538120; Wed, 02 Apr 2025
 18:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
 <20250402232441.440346-8-stephen@networkplumber.org>
In-Reply-To: <20250402232441.440346-8-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 2 Apr 2025 21:21:37 -0400
X-Gm-Features: AQ5f1Jq_Zf2aA8Mh8OcDlOTZOeFnb1awaCsFu5vp5nolEkPXtx-IeEqT8cccSg0
Message-ID: <CAJvnSUA-ymskiURxpi=gKdrHhb6Z4vb7XQNuGVAZDPcoF2k2Kg@mail.gmail.com>
Subject: Re: [PATCH v12 07/10] dts: replace use of sanity check in comment
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000b476910631d5a536"
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

--000000000000b476910631d5a536
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately I do find myself saying sanity check often... something to
cut out from my vocabulary. From a quick google it looks like many are
using coherence check in its place, or just explicitly writing out what the
check is as you did.

It would also probably be fine to just remove the comment entirely given
the assert immediately following it also contains its own explanation of
the check. But, I guess the original author thought it was useful to have
the comment, so we can keep it.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Wed, Apr 2, 2025 at 7:24=E2=80=AFPM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> Replace with better words.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  dts/tests/TestSuite_blocklist.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dts/tests/TestSuite_blocklist.py
> b/dts/tests/TestSuite_blocklist.py
> index ce7da1cc8f..82109f72a1 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -22,7 +22,7 @@ def verify_blocklisted_ports(self, ports_to_block:
> list[Port]):
>              allowlisted_ports =3D {port.device_name for port in
> testpmd.show_port_info_all()}
>              blocklisted_ports =3D {port.pci for port in ports_to_block}
>
> -            # sanity check
> +            # ensure at least one port is allowed
>              allowed_len =3D len(allowlisted_ports - blocklisted_ports)
>              self.verify(allowed_len > 0, "At least one port should have
> been allowed")
>
> --
> 2.47.2
>
>

--000000000000b476910631d5a536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Unfortunately I do find myself saying sanity=C2=A0check of=
ten... something to cut out from my vocabulary. From a quick google it look=
s like many are using coherence check in its place, or just explicitly writ=
ing out what the check is as you did.=C2=A0<div><br></div><div>It would=C2=
=A0also probably=C2=A0be fine to just remove the comment entirely given the=
 assert immediately following it also contains its own explanation of the c=
heck. But, I guess the original author thought it was useful to have the co=
mment, so we can keep it.=C2=A0</div><div><br></div><div>Reviewed-by: Patri=
ck Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, Apr 2, 2025 at 7:24=E2=80=AFPM Stephen H=
emminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@networkp=
lumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Replace with better words.<br>
<br>
Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_blocklist.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blockli=
st.py<br>
index ce7da1cc8f..82109f72a1 100644<br>
--- a/dts/tests/TestSuite_blocklist.py<br>
+++ b/dts/tests/TestSuite_blocklist.py<br>
@@ -22,7 +22,7 @@ def verify_blocklisted_ports(self, ports_to_block: list[P=
ort]):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allowlisted_ports =3D {port=
.device_name for port in testpmd.show_port_info_all()}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blocklisted_ports =3D {port=
.pci for port in ports_to_block}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # sanity check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ensure at least one port is al=
lowed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allowed_len =3D len(allowli=
sted_ports - blocklisted_ports)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.verify(allowed_len &gt=
; 0, &quot;At least one port should have been allowed&quot;)<br>
<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div>

--000000000000b476910631d5a536--
