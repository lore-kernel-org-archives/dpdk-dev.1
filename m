Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA5C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 18:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90C43402D1;
	Fri, 26 Jun 2026 20:47:04 +0200 (CEST)
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67]) by mails.dpdk.org (Postfix) with ESMTP id 07BAB4026D
 for <dev@dpdk.org>; Fri, 26 Jun 2026 20:47:03 +0200 (CEST)
Received: by mail-oo1-f67.google.com with SMTP id
 006d021491bc7-6a0eb989530so545222eaf.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 11:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499622; cv=none;
 d=google.com; s=arc-20260327;
 b=MKdNUVtRleLfzQesgkBw8b0Pr1pgCd8VLXKFu/EiItpjbI05buhW/QDYkITVcmiB7W
 RgMLHBrGbUjCRetGunUxuFeqXrgHjibQnQQjNtlCGbdVHVhI4cSBHkdj7+416tUkRBlE
 izDMzdBJbilP5Chz3GNy0oq/hTb9ft7aqLqcYD/dotQNkqvHOSCSJTCIQharZaA7LR2X
 EtUBmJnTJYQjcEgrdcchBf+A+8CEkXb9o/7t84/60dcNA3+cxKSisAqMT1q/6BLvMEwh
 SZlmCaTlN/ZIEtgIPNUQ6dvlyGkHuthg3QpBY5TC7kHf8PdSfBL5n7Rq8N5YgdR+oIZ7
 0w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sAqxdpqZcwGVb/lNstMVlhv37SIugyXSX8LwDrXy/BU=;
 fh=1sy3FI9FHZuYJIwl4q0afklsASxZZjqGoM2+TS8GYjE=;
 b=ENvYMFd/0tkxIHbPQp6sdMIWHTMg+wTBaWPzony9SHJ3Wrey5V5Ogy1kqtEpWAW5rp
 nrtb/PP6OwaC1zTarpBbnXBsVI7Io5YkKUuJyIMvwW5Yercrp4AAgm3cagpx0XIph+De
 GaUJc0qSLjUiMhTPwhEDcw+s6aL2Djcf/XFVUhyp5525mzbBuESqLFdJQLXA04DGhAM8
 QZeyi57rz86ULU7TNGmBSiZLhsBOLSigSgvcu9/4nfZdocMcadWkxhLup/VrakkG5hMF
 tEXjr2DAulmNDc8++k8OsKvG67bJTGFmXXbH3uLPwgvE/ciOS0NKA9GATaAoB17mUys8
 Jdsw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782499622; x=1783104422; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sAqxdpqZcwGVb/lNstMVlhv37SIugyXSX8LwDrXy/BU=;
 b=EOQ/DIJt58xsXMnhGS7zmd/NG5aHl6TNig6SCV52i7hHgMenZh6RXFkhg/lnkYsdKx
 cxTlJYQEMdIy44GOeTFcuDsl15Gr7+y876i/VQlhzElggvjcJ+Aoq6xxOAJUWAAQGxNO
 /orkjDl7hJ8knBb/vcjj8Wp9c64RVOik2D4yGZlCS/ngwDzMoNY4fZJ2Gp16Ko02i5cc
 saO1kzslLu6BxuzAgfrhqpUan80unm9MNUwF42SFKN9WnA2Zwxo4rWBrxWHawo76QazI
 3Onrejc54T5s8vhBMHEpR6gzzyLXI4Bo3BL364KqPLZjEWU1cWAYgLyzy5kY79uuc7Nl
 aR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499622; x=1783104422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAqxdpqZcwGVb/lNstMVlhv37SIugyXSX8LwDrXy/BU=;
 b=Tq95s2K4u/P9x3yI3GUvjhl272Tpr2NzkG5LWc60sVoK+TUaKNiYWKvAcf1fn9iQQN
 071F1aqSbx/o65E7uby6up/Iwc5aoOnP0Gnn7pwKwqaMbJMaYURLG5SE8fSRcRsIgIV8
 fE/Ub1yqCQchgms1sF0wq9bTPhTQWDbgJL/0DfFrKPVY+bUg5pJ0Big7Ngd4FIFnkjzl
 mPCVL4r3WC0lxb1q1LErHhdLXNAslAQd6WEBk/tiPlirZJu3r1xV+UhQZpWfHiRSj1AU
 kGuLCUX01lpf5ncsU3xlNW24sd5B6Sv23jM474ig+UyvYEZHTGOTvOyRKypdCwIVfa6n
 ayyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jnmsvcAdbs+e1yG28N7KAtq/WjAY1H1TTUiwc6LTVrJaUAOyDSJhjEe7hUkLjB2u6mIc=@dpdk.org
X-Gm-Message-State: AOJu0Ywjxk6KkxblIvMxstJ5l0BSbRR5QJoFDl42wuLFKs2uueJEso4T
 Lm5wh54iri+nd+qdk/bqINwqgsCVFI9hz0gulSmChB8+plAcAz0yLZheSK+4zm+6SB4b2C5sEF9
 do+vqNwHQYEwwKwqWxmYwpgDUsPPyvv4=
X-Gm-Gg: AfdE7cma0l/lLgG9CJ74z6+ks7LcTrgD9Ba+rpVaTBzb4QvnpWBuoqBxhvbXl2vANp9
 Lx7XCbm94RdJr28MxyiYIi9bzOj0gHxldVMSw94Yf3aL/JRShV1QDp3hLrsrh+BoDG69tBUKumC
 +1FR9um2aKTd8skoa7cjDsJGFcGpBG4O5AAbkvaA3x4DyS67VtFCfchA5+JX0FO+lWZbQfgixPc
 8dn6EtOm6EHCHXrQ6a+iXWVBwvAxisCp/ydAk+ppHFXfE0cqP/5FV0gBPXQtCBFtXOUJngzSNQC
 hfGG47/+EtZAq2ytlshuUyg7gA==
X-Received: by 2002:a05:6820:4b0a:b0:6a1:50e7:5c1c with SMTP id
 006d021491bc7-6a150e75d4dmr931780eaf.71.1782499622174; Fri, 26 Jun 2026
 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260528190449.66254-1-giveback4fun@gmail.com>
 <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
 <20260529082324.00a5f096@phoenix.local>
 <ahm4Qr5gLBf6sxof@bricha3-mobl1.ger.corp.intel.com>
 <CADggw7J2CUQOD5AAF3Uv6kTK25_OV2q3xQfS3zKsSMdSO0R0FA@mail.gmail.com>
In-Reply-To: <CADggw7J2CUQOD5AAF3Uv6kTK25_OV2q3xQfS3zKsSMdSO0R0FA@mail.gmail.com>
From: Sudheendra S <giveback4fun@gmail.com>
Date: Fri, 26 Jun 2026 11:46:51 -0700
X-Gm-Features: AVVi8CcO_KCxzv0Jz_7PZQiYpLOo8YMK06K5H60ZWSc4_Kj83eUonKHhmDowEBs
Message-ID: <CADggw7J2xYD388UtfLALGRytUCmrQRexU=b6aXmpoa5Ht3dkVA@mail.gmail.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermonitor
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Content-Type: multipart/alternative; boundary="000000000000cac37506552c8800"
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

--000000000000cac37506552c8800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

I appreciate any feedback so that I can make changes and send out the patch=
.

Thanks

On Thu, Jun 18, 2026 at 12:24=E2=80=AFPM Sudheendra S <giveback4fun@gmail.c=
om>
wrote:

> *Note:  Changed subject line from /run/dpdk/powermanager ->
> /run/dpdk/powermonitor*
>
> Hi All,
>
> Apologies for the delay.
>
> So, I am following the above thread and below are what I understand are
> the changes that are needed :
>
>
>    1. I see that rte_eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.  I
>    will verify that channel_manager has access to this symbol.
>    2. Upon successful creation of /run/dpdk, I can mkdir
>    CHANNEL_MGR_SOCKET_PATH (/var/run/dpdk/powermonitor) and opendir() tha=
t for
>    subsequent processing.
>    3. Fixup the documentation to reflect correct powermonitor path
>
> Please let me know if I am missing anything or if I misinterpreting any
> part of the email exchange.
>
> Thanks for all your help and support.
>
> -Sudheendra G Sampath
>
> On Fri, May 29, 2026 at 9:01=E2=80=AFAM Bruce Richardson <
> bruce.richardson@intel.com> wrote:
>
>> On Fri, May 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:
>> > On Fri, 29 May 2026 09:01:34 +0100
>> > Bruce Richardson <bruce.richardson@intel.com> wrote:
>> >
>> > > On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrote:
>> > > > This patch for bug 1832 will do the following:
>> > > > 1.  If /run/dpdk is not present, it will create it first with and
>> > > >     then create powermanager directory underneath it.
>> > > > 2.  If /run/dpdk is present, it will verify it is actually a
>> directory
>> > > >     before creating subdirectory, powermanager.
>> > > >
>> > > I would suggest using $XDG_RUNTIME_DIR for the directory path, rathe=
r
>> than
>> > > hardcoding it by default. If XDG_RUNTIME_DIR is not set, then maybe
>> > > consider using /run/dpdk. However, rather than /run/dpdk, I'd sugges=
t
>> using
>> > > the normal runtime dir path on most distros as the default:
>> > > /run/user/<uid>.
>> > >
>> > > /Bruce
>> >
>> > The login in EAL is a little more detailed.
>> > The choice is from systemd conventions which follows filesystem
>> hierarchy.
>> >
>> >
>> > int eal_create_runtime_dir(void)
>> > {
>> >       const char *directory;
>> >       char run_dir[PATH_MAX];
>> >       char tmp[PATH_MAX];
>> >       int ret;
>> >
>> >       /* from RuntimeDirectory=3D see systemd.exec */
>> >       directory =3D getenv("RUNTIME_DIRECTORY");
>> >       if (directory =3D=3D NULL) {
>> >               /*
>> >                * Used standard convention defined in
>> >                * XDG Base Directory Specification and
>> >                * Filesystem Hierarchy Standard.
>> >                */
>> >               if (getuid() =3D=3D 0)
>> >                       directory =3D "/var/run";
>> >               else
>> >                       directory =3D getenv("XDG_RUNTIME_DIR") ? : "/tm=
p";
>> >       }
>> >
>> >       /* create DPDK subdirectory under runtime dir */
>> >       ret =3D snprintf(tmp, sizeof(tmp), "%s/dpdk", directory);
>> >       if (ret < 0 || ret =3D=3D sizeof(tmp)) {
>> >               EAL_LOG(ERR, "Error creating DPDK runtime path name");
>> >               return -1;
>> >       }
>> >
>> >       /* create prefix-specific subdirectory under DPDK runtime dir */
>> >       ret =3D snprintf(run_dir, sizeof(run_dir), "%s/%s",
>> >                       tmp, eal_get_hugefile_prefix());
>> >       if (ret < 0 || ret =3D=3D sizeof(run_dir)) {
>> >               EAL_LOG(ERR, "Error creating prefix-specific runtime pat=
h
>> name");
>> >               return -1;
>> >       }
>> >
>> >       /* create the path if it doesn't exist. no "mkdir -p" here, so d=
o
>> it
>> >        * step by step.
>> >        */
>> >       ret =3D mkdir(tmp, 0700);
>> >       if (ret < 0 && errno !=3D EEXIST) {
>> >               EAL_LOG(ERR, "Error creating '%s': %s",
>> >                       tmp, strerror(errno));
>> >               return -1;
>> >       }
>> >
>> >       ret =3D mkdir(run_dir, 0700);
>> >       if (ret < 0 && errno !=3D EEXIST) {
>> >               EAL_LOG(ERR, "Error creating '%s': %s",
>> >                       run_dir, strerror(errno));
>> >               return -1;
>> >       }
>>
>> Yes. Can the power manager call the rte_eal_get_runtime_dir() API and us=
e
>> that as a basis for its working directory? Save duplicating all this
>> logic.
>>
>> /Bruce
>>
>

--000000000000cac37506552c8800
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>I appreciate any feedback s=
o that I can make changes and send out the patch.</div><div><br></div><div>=
Thanks=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18, 2026 at 12:24=E2=80=
=AFPM Sudheendra S &lt;<a href=3D"mailto:giveback4fun@gmail.com">giveback4f=
un@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div><b>Note:=C2=A0 Changed subject line from =
/run/dpdk/powermanager -&gt; /run/dpdk/powermonitor</b></div><div><br></div=
><div dir=3D"ltr">Hi All,<div><br></div><div>Apologies for the delay.</div>=
<div><br></div><div>So, I am following the above thread and below are what =
I understand are the changes that are needed :</div><div><br></div><div><ol=
><li>I see that rte_eal_get_runtime_dir() is RTE_EXPORTED_SYMBOL.=C2=A0 I w=
ill verify that channel_manager has access to this symbol.</li><li>Upon suc=
cessful creation of /run/dpdk, I can mkdir CHANNEL_MGR_SOCKET_PATH (/var/ru=
n/dpdk/powermonitor) and opendir() that for subsequent processing.</li><li>=
Fixup the documentation to reflect correct powermonitor path</li></ol><div>=
Please let me know if I am missing anything or if I misinterpreting any par=
t of the email exchange.</div></div><div><br></div><div>Thanks for all your=
 help and support.</div><div><br></div><div>-Sudheendra G Sampath</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, May 29, 2026 at 9:01=E2=80=AFAM Bruce Richardson &lt;<a href=3D"mailto:=
bruce.richardson@intel.com" target=3D"_blank">bruce.richardson@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Fri, May 29, 2026 at 08:23:24AM -0700, Stephen Hemminger wrote:<br>
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
</blockquote></div>

--000000000000cac37506552c8800--
