Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D94C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 02:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE6440264;
	Wed,  8 Jul 2026 04:28:11 +0200 (CEST)
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
 by mails.dpdk.org (Postfix) with ESMTP id E694F40041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 04:28:09 +0200 (CEST)
Received: by mail-oo2-f5.google.com with SMTP id
 006d021491bc7-6a2ab69a0c4so24629eaf.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 19:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783477689; cv=none;
 d=google.com; s=arc-20260327;
 b=J0Zb61CINDTYmJR/7YniNrV1wrbePORnJcrMXx1ZroCpRKCRTznwvAt0hUJHmqr8yA
 Gj2vS4LhKITEs4EfToKeKuWV5n3uP0kCYR1Imyko0V1M8/RQ4oAilDgpoTAwjaW5z0A9
 6kJ/Pn1OfbAz84rNNZbZQpVWiEzBz2Rn5c1DHDAz1AoMNKBCyNJfv5JwD0SHM5ibXsnr
 qgl7bKl4rk+fPFYD43VrgRHnyzlE1PCG6J0zb9lYWgMkO3bpgRglILVNbe93BYBm1zTb
 WqzCE9+Z1TM7VFo4AEtCKLmX/P8yKhETYjeF685XK6x0l8SUc1Hqfzukvtz+IJ6Xt+/x
 ozoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e3Vi/+wqW7eD5I3iLMqV0bQJ8jfQJcJTNbo5no6737s=;
 fh=arj6nQJ+zs09funvWRKLr4wHAxtCqonlVavJZ0Wo1Hw=;
 b=Ksu56LuFSsnvvqjuiTzBP/ri84nZN7sYh6mSYrNKYBpr13iugVKza94DehsWtrxAPL
 bMH/IX3PD8Em2zxzqvUQ29X+qlmpK280EZa0N67IDGirvConJbelaU1BlmeZcJWscrFx
 zdp60Jwz1cR+U0iTI+pk6a4vUYKS3+En7cbj25VCdK5bW49Fto9xTzN384rlclNMOcKa
 nv9wl/kuaBAxx1hZ6IskOT0Hprxm76MnG/gbFIWdbaRTw6VslWuSWVTvspGr5CYw21yf
 INWMaLlTCziPyxDzyoyeohZ54JT0aS0ApUH6yE9XyGCqtWV4IeLix3tG/YgwmL0AnIW7
 x7ww==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477689; x=1784082489; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e3Vi/+wqW7eD5I3iLMqV0bQJ8jfQJcJTNbo5no6737s=;
 b=VtjOt0ajLtg6pem2valMANfnbMZaK9F2OqOK5VdplRFP7UsQ1I1WQWWG0drLlvCpQR
 RITc9oeByVZ1xgPpNamAD7yojiw97Hu5QZLUTPCMW6AvNYVBEC2H0paGV111BIShU/Pd
 f2h3DObfzZPrFoQjDbs+1piG9ZJHYaR5uXpox1x9Ntg8fiKig8poAubF1KJmVycYaiyu
 GgWPwldkmO5qdvWWy5nkYyN+Bp5M9rm7cY9FQ7Xa60gizUnrN1Eo9TsN24YGbnA7X6M2
 tKM/p3qHQnl7oMekDhBbEHEyFOe57DlUvdxuSxcOx4EcRSsVTmQyVx0B5FK9BO8HCQu+
 h9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477689; x=1784082489;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e3Vi/+wqW7eD5I3iLMqV0bQJ8jfQJcJTNbo5no6737s=;
 b=r/SEiTpkk3DumheyE5+EqOhcfa9vC9faZ4DtAakpmWhubY7+2vEoCDxEY766/xnxEA
 nADphMYatccurzbX4OCc/Qoz7tDHbZS5RHkQOct8J4Guuclscy5BqkQCXzoK0XoJmQ5X
 ryRLw2drs1/hsITnHaN2mb159ok9EGI2xFHtIxy/1BIs7j5BxUJ/fC0CtuRafH86c+8H
 PUMqe6UXyy8NO31rmvIIl2i7CsXLa9NPi0P0WPcSE1vwQdQjOa2/UZiz8RmMa1M8Uvhm
 hNy6pKClD/OASRQolcMqKf9Cc9ewUifz790WVB1ZN67ieFe+y0SfJT9amrMujTJTNYB5
 h/bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rpoZ0aB5xtWfhCqSQWhdffekj94i3UXDHqlxOvFIJMQJWP/omggyG+MgZ5UARocYKK4A=@dpdk.org
X-Gm-Message-State: AOJu0YwgYK0hyiaLL9w05iS/RJU/2Ncb0dDJDBxmdGmx9mp1xF/rWmKo
 nbytwCrHFR6uqJYDi8VO2lf4bnq4GkZJplVFJfsBnulrKyjh2gKpntecy++kcnfDmxghFSnctfv
 AZvgaNdRwrnmEInK7tDkcElwA9DZfAdw=
X-Gm-Gg: AfdE7clDEpuuVUQs4F2cTdkGymxGMfJeh6s6H2TdezqVXNdsPSAXKRnEwA02751+czV
 GcHFftl8ENk6nuT/fth/9bv2WIRwSfWDD/QDcHFuc8zcUGIPlVQXXBDx5RFw6EWcxAcBW9lRp/D
 Z3GwINekbOoZA2wdxvVb3wsRtU4dUAQBpgF0QFTykL/aAWsyYCfanCt64LGyOqEprYlvzlJ1qVN
 x1/4HWmpqNgEL6XiYxOgaCTYBNXwNslIYGPKColH+iWRkBwd0jy40YMQ+4lpGdw8WrKa/FC2Ixz
 W63hve/dYZ+UsIxjnVM5nHVipg==
X-Received: by 2002:a05:6820:c86:b0:6a1:8192:4d7a with SMTP id
 006d021491bc7-6a36da5eba7mr382812eaf.39.1783477688882; Tue, 07 Jul 2026
 19:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260528190449.66254-1-giveback4fun@gmail.com>
 <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
 <20260529082324.00a5f096@phoenix.local>
 <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
From: Sudheendra S <giveback4fun@gmail.com>
Date: Tue, 7 Jul 2026 19:27:58 -0700
X-Gm-Features: AVVi8CcQRi_JiymSWWHYhz47HP1iLdNx2f6YxLSZjkt3XJutuKVSVhBLpuJbsu8
Message-ID: <CADggw7+kkCxnhfNzwNYkdhjPRNXJsKz8P5RNL+K85g=1rUqWPg@mail.gmail.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Content-Type: multipart/alternative; boundary="0000000000001c5b2d06561042f4"
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

--0000000000001c5b2d06561042f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

I totally understand that you and the team are very busy.  I hope to get
some direction since this is first time ever to be submitting a patch to
DPDK.

From what I understand from the above email exchange changes needed are :

   1. I see that rte_eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.  I will
   verify that channel_manager has access to this symbol.
   2. Upon successful creation of /run/dpdk, I can mkdir
   CHANNEL_MGR_SOCKET_PATH (/var/run/dpdk/powermonitor) and opendir() that =
for
   subsequent processing.
   3. Fixup the documentation to reflect correct powermonitor path

Please let me know if I am missing anything or if I misinterpreting any
part of the email exchange.

Appreciate your timely help and support.

On Fri, May 29, 2026 at 9:01=E2=80=AFAM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Fri, May 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:
> > On Fri, 29 May 2026 09:01:34 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrote:
> > > > This patch for bug 1832 will do the following:
> > > > 1.  If /run/dpdk is not present, it will create it first with and
> > > >     then create powermanager directory underneath it.
> > > > 2.  If /run/dpdk is present, it will verify it is actually a
> directory
> > > >     before creating subdirectory, powermanager.
> > > >
> > > I would suggest using $XDG_RUNTIME_DIR for the directory path, rather
> than
> > > hardcoding it by default. If XDG_RUNTIME_DIR is not set, then maybe
> > > consider using /run/dpdk. However, rather than /run/dpdk, I'd suggest
> using
> > > the normal runtime dir path on most distros as the default:
> > > /run/user/<uid>.
> > >
> > > /Bruce
> >
> > The login in EAL is a little more detailed.
> > The choice is from systemd conventions which follows filesystem
> hierarchy.
> >
> >
> > int eal_create_runtime_dir(void)
> > {
> >       const char *directory;
> >       char run_dir[PATH_MAX];
> >       char tmp[PATH_MAX];
> >       int ret;
> >
> >       /* from RuntimeDirectory=3D see systemd.exec */
> >       directory =3D getenv("RUNTIME_DIRECTORY");
> >       if (directory =3D=3D NULL) {
> >               /*
> >                * Used standard convention defined in
> >                * XDG Base Directory Specification and
> >                * Filesystem Hierarchy Standard.
> >                */
> >               if (getuid() =3D=3D 0)
> >                       directory =3D "/var/run";
> >               else
> >                       directory =3D getenv("XDG_RUNTIME_DIR") ? : "/tmp=
";
> >       }
> >
> >       /* create DPDK subdirectory under runtime dir */
> >       ret =3D snprintf(tmp, sizeof(tmp), "%s/dpdk", directory);
> >       if (ret < 0 || ret =3D=3D sizeof(tmp)) {
> >               EAL_LOG(ERR, "Error creating DPDK runtime path name");
> >               return -1;
> >       }
> >
> >       /* create prefix-specific subdirectory under DPDK runtime dir */
> >       ret =3D snprintf(run_dir, sizeof(run_dir), "%s/%s",
> >                       tmp, eal_get_hugefile_prefix());
> >       if (ret < 0 || ret =3D=3D sizeof(run_dir)) {
> >               EAL_LOG(ERR, "Error creating prefix-specific runtime path
> name");
> >               return -1;
> >       }
> >
> >       /* create the path if it doesn't exist. no "mkdir -p" here, so do
> it
> >        * step by step.
> >        */
> >       ret =3D mkdir(tmp, 0700);
> >       if (ret < 0 && errno !=3D EEXIST) {
> >               EAL_LOG(ERR, "Error creating '%s': %s",
> >                       tmp, strerror(errno));
> >               return -1;
> >       }
> >
> >       ret =3D mkdir(run_dir, 0700);
> >       if (ret < 0 && errno !=3D EEXIST) {
> >               EAL_LOG(ERR, "Error creating '%s': %s",
> >                       run_dir, strerror(errno));
> >               return -1;
> >       }
>
> Yes. Can the power manager call the rte_eal_get_runtime_dir() API and use
> that as a basis for its working directory? Save duplicating all this logi=
c.
>
> /Bruce
>

--0000000000001c5b2d06561042f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Stephen,</div><div><br></div><div>I totally unders=
tand that you and the team are very busy.=C2=A0 I hope to get some directio=
n since this is first time ever to be submitting a patch to DPDK.</div><div=
><br></div><div>From what I understand from the above email exchange change=
s needed are :</div><div><ol><li style=3D"margin-left:15px">I see that rte_=
eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.=C2=A0 I will verify that chan=
nel_manager has access to this symbol.</li><li style=3D"margin-left:15px">U=
pon successful creation of /run/dpdk, I can mkdir CHANNEL_MGR_SOCKET_PATH (=
/var/run/dpdk/powermonitor) and opendir() that for subsequent processing.</=
li><li style=3D"margin-left:15px">Fixup the documentation to reflect correc=
t powermonitor path</li></ol><div>Please let me know if I am missing anythi=
ng or if I misinterpreting any part of the email exchange.</div></div><div>=
<br></div><div>Appreciate your timely help and support.</div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, May 29, 2026 at 9:01=E2=80=AFAM Bruce Richardson &lt;<a hre=
f=3D"mailto:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, M=
ay 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:<br>
&gt; On Fri, 29 May 2026 09:01:34 +0100<br>
&gt; Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com" tar=
get=3D"_blank">bruce.richardson@intel.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrot=
e:<br>
&gt; &gt; &gt; This patch for bug 1832 will do the following:<br>
&gt; &gt; &gt; 1.=C2=A0 If /run/dpdk is not present, it will create it firs=
t with and<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0then create powermanager directory undern=
eath it.<br>
&gt; &gt; &gt; 2.=C2=A0 If /run/dpdk is present, it will verify it is actua=
lly a directory<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0before creating subdirectory, powermanage=
r.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; I would suggest using $XDG_RUNTIME_DIR for the directory path, ra=
ther than<br>
&gt; &gt; hardcoding it by default. If XDG_RUNTIME_DIR is not set, then may=
be<br>
&gt; &gt; consider using /run/dpdk. However, rather than /run/dpdk, I&#39;d=
 suggest using<br>
&gt; &gt; the normal runtime dir path on most distros as the default:<br>
&gt; &gt; /run/user/&lt;uid&gt;.<br>
&gt; &gt; <br>
&gt; &gt; /Bruce<br>
&gt; <br>
&gt; The login in EAL is a little more detailed.<br>
&gt; The choice is from systemd conventions which follows filesystem hierar=
chy.<br>
&gt; <br>
&gt; <br>
&gt; int eal_create_runtime_dir(void)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *directory;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char run_dir[PATH_MAX];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char tmp[PATH_MAX];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* from RuntimeDirectory=3D see systemd.exec=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0directory =3D getenv(&quot;RUNTIME_DIRECTORY=
&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (directory =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Used standard=
 convention defined in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * XDG Base Dire=
ctory Specification and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Filesystem Hi=
erarchy Standard.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (getuid() =3D=
=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0directory =3D &quot;/var/run&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0directory =3D getenv(&quot;XDG_RUNTIME_DIR&quot;) ? : &quot;/t=
mp&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* create DPDK subdirectory under runtime di=
r */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D snprintf(tmp, sizeof(tmp), &quot;%s/=
dpdk&quot;, directory);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret =3D=3D sizeof(tmp)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EAL_LOG(ERR, &qu=
ot;Error creating DPDK runtime path name&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* create prefix-specific subdirectory under=
 DPDK runtime dir */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D snprintf(run_dir, sizeof(run_dir), &=
quot;%s/%s&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tmp, eal_get_hugefile_prefix());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 || ret =3D=3D sizeof(run_dir)=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EAL_LOG(ERR, &qu=
ot;Error creating prefix-specific runtime path name&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* create the path if it doesn&#39;t exist. =
no &quot;mkdir -p&quot; here, so do it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * step by step.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mkdir(tmp, 0700);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 &amp;&amp; errno !=3D EEXIST)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EAL_LOG(ERR, &qu=
ot;Error creating &#39;%s&#39;: %s&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tmp, strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mkdir(run_dir, 0700);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0 &amp;&amp; errno !=3D EEXIST)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EAL_LOG(ERR, &qu=
ot;Error creating &#39;%s&#39;: %s&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0run_dir, strerror(errno));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Yes. Can the power manager call the rte_eal_get_runtime_dir() API and use<b=
r>
that as a basis for its working directory? Save duplicating all this logic.=
<br>
<br>
/Bruce<br>
</blockquote></div>

--0000000000001c5b2d06561042f4--
