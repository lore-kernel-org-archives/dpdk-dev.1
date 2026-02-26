Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB3FD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B18A4027F;
	Thu, 26 Feb 2026 20:13:43 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 1F42F400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:13:41 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b8f92f3db6fso199683466b.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772133221; cv=none;
 d=google.com; s=arc-20240605;
 b=O9v/WxY2KkMyLJHLIW1sa3w/4YFW8IDMtXjbClv4Xpv1GYUIqyefAgA/Gyve3B8rDx
 ln9ygATo4T2SJyud+3ONOTCEA/f7A+RRlnK9sDV0yZPO2AIKDOUurcK5xYEqEyckRDYG
 Jw6chYREeg70465XbGbO2Uc55hSEZo1T8Z4Z8dlQn1q9aRxIKYvlKhjq52NIF1GJFMOe
 QEa7v272TRaoYd2KOZfsSyCS9djRynj22R2DwQKYD+crtfIWbBLMyCWEJnfvmB5fnNQ4
 TsNG2LDjYwZLxuX5KJfnYxPYid34yyEGO4uAESVD03/l4XOIPR7kphtKZbRVg/ifquS4
 U9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZGvRW1VW9djctt+DIVbbPp/xrzGOBxFAgU972V90YJ4=;
 fh=D7boA2b8UziNW8ISu3mC+qC072iZP4vwlyXPL03I/vc=;
 b=GDtjYMVxOUKaMUf5LCb6Cj43IVcY9HfaLms0uxzDtxTzFLgY7f0sPH15STKuzM16Ga
 f2ojkqeXYK3HIrTKOIpSpNAowFFwSKO6TrN1PxAn1ImB8RuAeVFj3/wvsZK5FcLQ2c8s
 nkF9DCEugE/UYZUPH5CUdbbkn1JQxObY2TwihoHXzfJzHvl8qooaAfhbjN0Doc9Lo7XV
 GyVLByCcpbEyFfyWRITufZbrD+YP/bHLXlVTf6z5mSkMB0z9z/SgXg0z6IVBrjjLlqhp
 qXEhOuNpzFEVyozQtfhT0yqski4dka3IZRFnQ4NQuRRTMLb786EM+tsu6/jKKP1ylWl6
 f0qQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772133221; x=1772738021; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGvRW1VW9djctt+DIVbbPp/xrzGOBxFAgU972V90YJ4=;
 b=IOmr/KCJipHy+eRUrCHm78lLCHzKjRt+4bKTn72vQ+9LQQgxVc4OBiAUngGGMtEHMC
 EUS0rLYva0WKuUoIEq0Nj2k7mEftzjOF8eEONfOb+JgOGt0Yb4NKHe1AUjQoNkkl+/fC
 LGdnmloy8pwf3QMovD7LO0SiSFx9MTYUkyaPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772133221; x=1772738021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGvRW1VW9djctt+DIVbbPp/xrzGOBxFAgU972V90YJ4=;
 b=szwl5awabpEqcOL6wIF/uochAbsrsxNYBpT6PBU6CDfcMMCHRB/00D0tQHvEpmv3Qz
 TgfwSq26ieAg0tOOcMHAZ1gQp10GJUeiT8NTsgKQb9xn30FOLrUIRLiftg+9epasze5l
 F4T5ZEBhEwW9vWkDxGqdAC3RZClmKU/gomzzpqWWSJsXqWNuT6uLTTBjJfTa0FYu06+N
 VtKMa9QvMC4+/zGVo7sBcGEvQa+hkJWXpKGpzgxz7GfGZqdXlcK/X1NhL7/1OEDZvsxd
 rsQZbg9Y5m8EI0k9eSYd8GZw/vZuAMR6Mo5fjLEz6gmE95Q6kbp4NEXvqLYiSuSdLqsf
 CYbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOoMU3/0bzSXl9aUhngffgK/3DUBNVOkn1/iyRtRvezeL5xjq07XEIOiYwO/a3ompm07k=@dpdk.org
X-Gm-Message-State: AOJu0YylHohw19jGmOsMsH+lHFP6TO+r73mUL+KwQ5Z8rR7LoqdTIPmg
 8O/wu4wYsl+mgZlNUYGze7zp/TYzqO8Nlux9wqnpKW4k38VLy8qjqQMXrx9vWs/EDdahdTOKtYM
 ughcEJKGawbw0MRxIaSDcrGbKGxpIRDmAvq3sd6mKeg==
X-Gm-Gg: ATEYQzx9T3pIGnSY7NiUiVlTzjPz6ahGMnUJGRMwzBZyxBuERrUvRN7qtncfGbNWyD+
 3Be5lcvx7Mk/sk1st+E4iqcmySrBQqYk6kYGre+R4sX8WBNZNQaW/VXexGFijz5XZ2ZRvI6mriy
 XUtvSVksB5kNruMgGRTxO5wLRlvkHFVnP3/VgBfhjKRt++R9/b8VJ6tsIb43SBZgBrZTUrC85+G
 CwispvHTx6NsPizrjTOOmndbK8kN/cWqHctGvNbqlLwhMifES0J4ciVYKfVvLSLATamIq5NOGIj
 QHdlbxNQh4XLhV07o+G2kMZSbvRKHnTVVaf01/sp3TAKv9s2OA4=
X-Received: by 2002:a17:907:2d2c:b0:b8f:9fe5:fd62 with SMTP id
 a640c23a62f3a-b9376546d0dmr903166b.42.1772133220573; Thu, 26 Feb 2026
 11:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-3-abailey@iol.unh.edu>
 <CAJvnSUCDkbiiYGEM_PGWppQdbJNZC0ZSVPqdaTR2=2XP-oF23A@mail.gmail.com>
In-Reply-To: <CAJvnSUCDkbiiYGEM_PGWppQdbJNZC0ZSVPqdaTR2=2XP-oF23A@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 26 Feb 2026 14:13:29 -0500
X-Gm-Features: AaiRm5180IPR7sNiqwHiRlYwJjQ-t4Gt5bdk5KrNRSY5P_McuM1cWx0PuP1z4xo
Message-ID: <CABJ3N2W+SPR2mH8h5nvhde3y1118QBGzrOnuwv9sVJPLQiuyNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dts: add cryptodev package to DTS
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001b7269064bbeeb44"
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

--0000000000001b7269064bbeeb44
Content-Type: text/plain; charset="UTF-8"

>
>
>
> > +    def run_app(self, numvfs: int | None = 0) -> list[CryptodevResults]:
> > +        """Run the cryptodev application with the given app parameters.
> > +
> > +        Raises:
> > +            SkippedTestException: If the device type is not supported
> on the main session.
> > +            RemoteCommandExecutionError: If there is an error running
> the command.
> > +
> > +        Returns:
> > +            list[CryptodevResults]: The list of parsed results for the
> cryptodev application.
>
> Missing the args docstring. Speaking of which, What is the theory
> behind passing a vf count from the testsuites to the app? In terms of
> what the testsuites require, and whether that aspect should be
> configurable from the user side, why the default is zero, etc.
>

The theory behind this is that some test suites in the future that use
scheduling will require to use multiple VFs.
I think that if this varies on a per test case basis, then it should be
configurable within a test case. In regard to the
default, it should be assigned to one, not zero. As the application
requires at least one VF.

>
> > diff --git a/dts/configurations/nodes.example.yaml
> b/dts/configurations/nodes.example.yaml
> > index 3f23df11ec..1fc0a38bf5 100644
> > --- a/dts/configurations/nodes.example.yaml
> > +++ b/dts/configurations/nodes.example.yaml
> > @@ -20,6 +20,12 @@
> >    hugepages_2mb: # optional; if removed, will use system hugepage
> configuration
> >        number_of: 256
> >        force_first_numa: false
> > +  # cryptodevs: # optional; add each physical bdf as its own element in
> the list
>
> I would rephrase to clarify:
>
> "Uncomment to run cryptodev tests; add physical cryptodev devices by their
> BDF"
>
> I also think that we are at a place now where we have a number of
> optional fields in the config files that can be commented or
> uncommented, and there may be value in explicitly calling this out,
> perhaps with a one liner above all of the YAML fields. I think you are
> going in the right direction with your comment, but then we have other
> fields which are optional that don't have the same explanation, or
> it's phrased differently, resulting in documentation which is
> inconsistent and potentially confusing to new people who just want to
> fill out their config files. What do you think agree/disagree? If you
> agree can you come up with something? Thanks.
>

I think this is a reasonable request, maybe we can have a disclaimer at the
top of the file
that states which variables are optional with a short description of each
one and some optional
tag each time it is used within the file. For example,

# Optional Arguments:
#   cryptodevs: uncomment to run cryptodev tests; add physical cryptodev
devices by their BDF
#   crypto_driver: the device type of the DUT e.g. (crypto_qat, crypto_zuc,
crypto_aesni_mb)
#   hugepages_2mb: optional; add each physical bdf as its own element in
the list,
#     if removed, will use system hugepage configuration

 cryptodevs: # see 'Optional Arguments'
    - name: cryptodev-0
      pci: "ffff:ff:ff.f"
      os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use for the
cryptodev VFs
      os_driver: _ # This is unused but a value is necessary to run dts
  crypto_driver: # see 'Optional Arguments'

Let me know what you think. :)

>
> > +  #     os_driver: _ # This is unused but a value is necessary to run
> dts
>
> If there is really no point in populating the os_driver field, is it
> possible to remove the field and force the config parser step in the
> framework be tolerant to this?
>

This is kind of a shortcut, A crypto device is identical to the already
implemented port class; except that it
does not require an os driver. This field cannot be made optional with this
approach but its value has no
effect on test runs.

>
>
> > +        """Retrieve virtual functions from active crypto vfs.
> > +
> > +        If numvfs is `None`, returns all crypto virtual functions.
> Otherwise, returns
> > +        `numvfs` number of virtual functions per physical function
> rounded down. If a number of
> > +        `numvfs` is less than the number of physical functions, one
> virtual function is returned.
>
> I am wondering about this design. So, the form of the return value is
> unpredictable? What do the testsuites actually require?
>
>
This will be redesigned in my v4, It should return the exact number of vfs
requested or raise an exception
if an invalid number of vfs are called.

>
> > +    def instantiate_crypto_vf_ports(self) -> None:
> > +        """Create max number of virtual functions allowed on the SUT
> node.
> > +
> > +        Raises:
> > +            InternalError: If crypto virtual functions could not be
> created on a port.
> > +        """
> > +        from framework.context import get_ctx
> > +
> > +        ctx = get_ctx()
> > +
> > +        for port in ctx.sut_node.cryptodevs:
> > +            self.crypto_pf_ports.append(port)
> > +        self.delete_crypto_vf_ports()
>
> populating crypto_pf_ports in the instantiate_crypto_vf_ports method?
> Possible single responsibility principle violation but not a huge deal
> if it cannot be cleanly populated "earlier."
>
> This follows the behavior of the 'instantiate_vf_ports' method. The idea
here is that we will never want to instantiate
the crypto PF ports without the VFs. For this reason I thought it was
appropriate to do it in one method.

--0000000000001b7269064bbeeb44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br><br>
&gt; +=C2=A0 =C2=A0 def run_app(self, numvfs: int | None =3D 0) -&gt; list[=
CryptodevResults]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Run the cryptodev appli=
cation with the given app parameters.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: If th=
e device type is not supported on the main session.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RemoteCommandExecutionError=
: If there is an error running the command.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[CryptodevResults]: The=
 list of parsed results for the cryptodev application.<br>
<br>
Missing the args docstring. Speaking of which, What is the theory<br>
behind passing a vf count from the testsuites to the app? In terms of<br>
what the testsuites require, and whether that aspect should be<br>
configurable from the user side, why the default is zero, etc.<br></blockqu=
ote><div><br>The theory behind this is that some test suites in the future =
that use scheduling will require to use multiple VFs.<br>I think that if th=
is varies on a per test case basis, then it should be configurable within a=
 test case. In regard to the<br>default, it should be assigned to one, not =
zero. As the application requires at least one VF.=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><br>
&gt; diff --git a/dts/configurations/nodes.example.yaml b/dts/configuration=
s/nodes.example.yaml<br>
&gt; index 3f23df11ec..1fc0a38bf5 100644<br>
&gt; --- a/dts/configurations/nodes.example.yaml<br>
&gt; +++ b/dts/configurations/nodes.example.yaml<br>
&gt; @@ -20,6 +20,12 @@<br>
&gt;=C2=A0 =C2=A0 hugepages_2mb: # optional; if removed, will use system hu=
gepage configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 number_of: 256<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 force_first_numa: false<br>
&gt; +=C2=A0 # cryptodevs: # optional; add each physical bdf as its own ele=
ment in the list<br>
<br>
I would rephrase to clarify:<br>
<br>
&quot;Uncomment to run cryptodev tests; add physical cryptodev devices by t=
heir BDF&quot;<br>
<br>
I also think that we are at a place now where we have a number of<br>
optional fields in the config files that can be commented or<br>
uncommented, and there may be value in explicitly calling this out,<br>
perhaps with a one liner above all of the YAML fields. I think you are<br>
going in the right direction with your comment, but then we have other<br>
fields which are optional that don&#39;t have the same explanation, or<br>
it&#39;s phrased differently, resulting in documentation which is<br>
inconsistent and potentially confusing to new people who just want to<br>
fill out their config files. What do you think agree/disagree? If you<br>
agree can you come up with something? Thanks.<br></blockquote><div><br>I th=
ink this is a reasonable request, maybe we can have a disclaimer at the top=
 of the file<br>that states which variables are optional with a short descr=
iption of each one and some optional<br>tag each time it is used within the=
 file. For example,=C2=A0<br><br># Optional Arguments:<br># =C2=A0 cryptode=
vs: uncomment to run cryptodev tests; add physical cryptodev devices by the=
ir BDF<br># =C2=A0 crypto_driver: the device type of the DUT e.g. (crypto_q=
at, crypto_zuc, crypto_aesni_mb)<br># =C2=A0 hugepages_2mb: optional; add e=
ach physical bdf as its own element in the list,<br># =C2=A0 =C2=A0 if remo=
ved, will use system hugepage configuration=C2=A0</div><div><br>=C2=A0crypt=
odevs: # see &#39;Optional Arguments&#39;<br>=C2=A0 =C2=A0 - name: cryptode=
v-0<br>=C2=A0 =C2=A0 =C2=A0 pci: &quot;ffff:ff:ff.f&quot;<br>=C2=A0 =C2=A0 =
=C2=A0 os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use for the =
cryptodev VFs<br>=C2=A0 =C2=A0 =C2=A0 os_driver: _ # This is unused but a v=
alue is necessary to run dts<br>=C2=A0 crypto_driver: # see &#39;Optional A=
rguments&#39;<br><br>Let me know what you think. :)=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 #=C2=A0 =C2=A0 =C2=A0os_driver: _ # This is unused but a value=
 is necessary to run dts<br>
<br>
If there is really no point in populating the os_driver field, is it<br>
possible to remove the field and force the config parser step in the<br>
framework be tolerant to this?<br></blockquote><div><br>This is kind of a s=
hortcut, A crypto device is identical to the already implemented port class=
; except that it<br>does not require an os driver. This field cannot be mad=
e optional with this approach but its value has no<br>effect on test runs.<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Retrieve virtual functi=
ons from active crypto vfs.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 If numvfs is `None`, returns all crypto v=
irtual functions. Otherwise, returns<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 `numvfs` number of virtual functions per =
physical function rounded down. If a number of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 `numvfs` is less than the number of physi=
cal functions, one virtual function is returned.<br>
<br>
I am wondering about this design. So, the form of the return value is<br>
unpredictable? What do the testsuites actually require?<br>
<br></blockquote><div>=C2=A0<br>This will be redesigned in my v4, It should=
 return the exact number of vfs requested or raise an exception<br>if an in=
valid number of vfs are called.</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
&gt; +=C2=A0 =C2=A0 def instantiate_crypto_vf_ports(self) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Create max number of vi=
rtual functions allowed on the SUT node.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InternalError: If crypto vi=
rtual functions could not be created on a port.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 from framework.context import get_ctx<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D get_ctx()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for port in ctx.sut_node.cryptodevs:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.crypto_pf_ports.append=
(port)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.delete_crypto_vf_ports()<br>
<br>
populating crypto_pf_ports in the instantiate_crypto_vf_ports method?<br>
Possible single responsibility principle violation but not a huge deal<br>
if it cannot be cleanly populated &quot;earlier.&quot;<br><br></blockquote>=
<div>This follows the behavior of=C2=A0the &#39;instantiate_vf_ports&#39; m=
ethod. The idea here is that we will never want to instantiate=C2=A0<br>the=
 crypto PF ports without the VFs. For this reason I thought it was appropri=
ate to do it in one method.<br></div></div></div>

--0000000000001b7269064bbeeb44--
