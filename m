Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5156ACD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 19:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55DDC402B6;
	Thu, 18 Jun 2026 21:24:51 +0200 (CEST)
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com
 [209.85.160.65]) by mails.dpdk.org (Postfix) with ESMTP id C39844028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 21:24:49 +0200 (CEST)
Received: by mail-oa1-f65.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso941951fac.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 12:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781810689; cv=none;
 d=google.com; s=arc-20240605;
 b=Zd8oMWt0flslp7zpFPnm+iRwQlQjI1hhgeJUA4edmuPUCMemEyGyK/78rHwHE8GkPH
 /qJuz1wAZt5osHUtU/3szTvQ4ut/PXj1pd9JH7jTOX7mnGyvuA0BtoHgc7kLFNzwyPkM
 i5IB+w4iLkPtlYCM0QNA4XG2b/R7136GNHcdY4jnQUWa0Wp5rlvg3UdVKTT4QcMz7hdP
 s1rGNeYxWLwUMiCY90n77KlGeywXiBSy3DLVOFN3hv6l3sTiQ82o2q7KnKm/2hEFlwPV
 HS0ZhroBpp2Is86OqfRzL0IpIuuWs0yhyxQ5E6AY/GRD8peM8Ld8i5Km25hOTsK7ecYF
 2Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ab/fihOTSux3AYErKipfELbtBN9ak4vXxbiZdtJsHPg=;
 fh=rOFgLZkuMTaa82KlQxxM+K9p+J3iw4USlI1BNZD+CiE=;
 b=ictb0YNtQ3irbajzWOMmnMwWwBX0Pv01ZTsZ44cbqj0qM67YugnnWc9j14BCUi6IK0
 OKmJTEGGjfocneCmgMmDqb/tqU3BRqJ2rxPlBTizJq7RYOrHJk1QSF0qKCFNOWHEQOYt
 BsBkmVsY8GDlN5/l7myA1X12NIxEXU2By1MnTFbcyNY74qT54IokJPgn75TFQEQg6A2M
 LkAVA0hA7hFMj39WOrG5PqJ5OMVzzMUjH0zvvHNQcXSwnyF0uML3TuDcERhG6A0ohA1x
 T47xae2smD5FabMRXQqxiXS6lb4HqoI7EHhJP80jo/qF9abRHcMfJOnWVtOofanl237V
 vCDw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781810689; x=1782415489; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ab/fihOTSux3AYErKipfELbtBN9ak4vXxbiZdtJsHPg=;
 b=BT/Bn6cDA7l3/YEl0FSmuA/fKnnrrBQmYPwPDZ1wyF1R52YonerdzdFYGwpkHW9xIc
 N2kyqBLv7sfChmfEZGKnd4KJUqM9j6sh85UslPIRO7OyAjKhGJAnCa/1oaARyeybc+aQ
 KqX2HneQrgFWhS2QzeWCXm8+Mnd0D4Iq0SuSemgvGM+uJNglPLF9yCDStlHQYLCAhXYC
 8qzHI3rshNRZB/9qlAwClkO+cUIkt38dxYv/CRRxXtA6MjzSmPZn3wuTeNHzXR81dVWG
 kuqBVpi4rK9ppWvl6mi23760vcF7BWSsE5Eyg6R9zbytAfkeLHngdd3coI7Yq5Eejw8R
 wCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781810689; x=1782415489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab/fihOTSux3AYErKipfELbtBN9ak4vXxbiZdtJsHPg=;
 b=BAjDBRbB8tlMZfiKB9450gDGWPzaZZM2iuv9DVsigss76FO4AK9MAl2Jq4ecS9XLRh
 mTW+bZqrdxJI4clTXdffDLo02P/iAJtp71v8lYT/XWPPJ6wefgMC9Pgy7+Vllf+O4Mlo
 TY0R8aUPdfI+KAEIaw61Tt4MHe3Pyu6tAu9kd1goLgSO8wUrNlsAlTdR6k15Vf1lGMzt
 s6jmNXs94gbHj+qbrIFV5BE1bitQsK7uJEEyZaGFpK1gKuw1G1DSK3970YVdOt7Pvgax
 tOp1C15NSV7jT72v4nkvSB7mEjPXCLjTopVy6yHdAEKK05fH6+nIwkyCc0WDj8VeskRL
 9Xfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q+hJEDjqxAMJ2cuUgtf5rne27PtEfT/npFnK7mghz/nAkep04bMptIEWEptXvaHv8HAE=@dpdk.org
X-Gm-Message-State: AOJu0YzVJdj3otgjivGDxv9ciDfnSpXy3njyFM5k0chtXKrhalzHunuC
 32/TNB8MByefSn1Xsr6wnlMxbYmTcu1hWtp7A5p0KiqPcdtASQ8nOxAocccTqmuhdR0Wm55xtv5
 5VtY7i2F8ABDbfIxHKSMKKRWCoyCe6cM=
X-Gm-Gg: AfdE7clznUEcDGFmvcA5LZrRxZj1vOd3GHr4jkY+U/uPK8Y+2dDdJSKUT1PyXkZVg5L
 CYxZXB88qA2VytoaLZlYa0FYIMMo+bG89i9Md5XTX/aaMvzfJdMz9GtbkC4XledfMCWnWLmXcXu
 V8hj2tZ2FLivJ3mEd5qHl3qM6FiGk8Mhfeqt3pCoZl9umNq50ejM/7eiD+Hiy1H7EskNyAVpZkg
 21mLigiqSx6Xs8tFIgrsG3/TNd3TOdooQcrzGRdqoxJP/45JZvhzM43tKDrHBOOA5aGONrjkRYr
 LpZRo6IVlb0FrBsq3bVnHXlw0nSwzg==
X-Received: by 2002:a05:6870:24d:b0:435:16e9:f288 with SMTP id
 586e51a60fabf-44707e90344mr550843fac.20.1781810688832; Thu, 18 Jun 2026
 12:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260528190449.66254-1-giveback4fun@gmail.com>
 <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
 <20260529082324.00a5f096@phoenix.local>
 <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
From: Sudheendra S <giveback4fun@gmail.com>
Date: Thu, 18 Jun 2026 12:24:37 -0700
X-Gm-Features: AVVi8Cd5egb1VsRL-l9Yjy0gFnt92LR-VRUKg7ixkXag_9h8f0RA5rRWfzjqcqI
Message-ID: <CADggw7J2CUQOD5AAF3Uv6kTK25_OV2q3xQfS3zKsSMdSO0R0FA@mail.gmail.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermonitor
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002a3a3d06548c211a"
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

--0000000000002a3a3d06548c211a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

*Note:  Changed subject line from /run/dpdk/powermanager ->
/run/dpdk/powermonitor*

Hi All,

Apologies for the delay.

So, I am following the above thread and below are what I understand are the
changes that are needed :


   1. I see that rte_eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.  I will
   verify that channel_manager has access to this symbol.
   2. Upon successful creation of /run/dpdk, I can mkdir
   CHANNEL_MGR_SOCKET_PATH (/var/run/dpdk/powermonitor) and opendir() that =
for
   subsequent processing.
   3. Fixup the documentation to reflect correct powermonitor path

Please let me know if I am missing anything or if I misinterpreting any
part of the email exchange.

Thanks for all your help and support.

-Sudheendra G Sampath

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

--0000000000002a3a3d06548c211a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><b>Note:=C2=A0 Changed subject line from /run/dpdk/po=
wermanager -&gt; /run/dpdk/powermonitor</b></div><div><br></div><div dir=3D=
"ltr">Hi All,<div><br></div><div>Apologies for the delay.</div><div><br></d=
iv><div>So, I am following the above thread and below are what I understand=
 are the changes that are needed :</div><div><br></div><div><ol><li>I see t=
hat rte_eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.=C2=A0 I will verify t=
hat channel_manager has access to this symbol.</li><li>Upon successful crea=
tion of /run/dpdk, I can mkdir CHANNEL_MGR_SOCKET_PATH (/var/run/dpdk/power=
monitor) and opendir() that for subsequent processing.</li><li>Fixup the do=
cumentation to reflect correct powermonitor path</li></ol><div>Please let m=
e know if I am missing anything or if I misinterpreting any part of the ema=
il exchange.</div></div><div><br></div><div>Thanks for all your help and su=
pport.</div><div><br></div><div>-Sudheendra G Sampath</div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Fri, May 29, 2026 at 9:01=E2=80=AFAM Bruce Richardson &lt;<a href=
=3D"mailto:bruce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Ma=
y 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:<br>
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
</blockquote></div></div>

--0000000000002a3a3d06548c211a--
